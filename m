Return-Path: <linux-kernel+bounces-516780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEAEA37749
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1271886D6D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6741A3140;
	Sun, 16 Feb 2025 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNRQemKD"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C1179A3;
	Sun, 16 Feb 2025 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739735626; cv=none; b=OXKh6jfMSeIu/vX5fbskJxfdkvsgGWnHFIZ4E0VQnAot0FLVhhF6EwgjhIFgA8f08hzQwLJ2ycx6UGkom8cEIt1yVKuW2v6rR4o1XGTd/sy4K24YeTyiyxpAK4UGkHZ99Qp7JkcmJMpDphqToTUbaWEt9roLLcIBHkRL7/uqSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739735626; c=relaxed/simple;
	bh=0cUM+2ow/h/nzbuzL8uF2L/aTYu78jPmqJNt+qnVHn0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uGCUZMLHOLJR/gCB4ZEEL3scgDVvNfqKBMGkS+12//W7KO3LchetaIfDvAm18XPLU0KKYb4jt/pPxmgmgpFjxLGJGz8Wr+6u40BMO4J+jEe25qRvfvpk32o1YRMDkRYqpnSGer+vxNtBN+0Z7Zs+hc3K0//YLt4USQwmYFbziIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNRQemKD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab744d5e567so691335666b.1;
        Sun, 16 Feb 2025 11:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739735622; x=1740340422; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af1SOjIZIJuY/yZ1MYRyyrZydDPDM0jQ3H4asZdVI0w=;
        b=UNRQemKDHvhd5n559HPy0slJ2zTfGEDJbIvCINj3QZoqwzAKehVCGYJrNMetKETQP/
         dgCBbLQymXjVNjoBaPKVRaxvM+YjM9/PXidwUytvpw822beDY9rvF/QWwYNJ7D4hfeCC
         NUFB8EOGOUNLCRqel+594ef41zAz3wwR2I+e9OZETM0O47ZppqcC4hMEFPss1PSHgdvm
         NkbxuFuwAIs9hhpqonwICEUb/URmdQvmbFPYEnRMnfdbnmT7z+9kHUj8SnafU2UiOCQw
         47z+w5WagW+kBA7HEkVbCe5r9h28L7RbJPEkNU7+DCJBTkCOIvsqST1i3ydM+RcT4Aig
         oKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739735622; x=1740340422;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=af1SOjIZIJuY/yZ1MYRyyrZydDPDM0jQ3H4asZdVI0w=;
        b=hTrwFVZYCLEvjiqBtXhoru6208qsU9S0IWR2rJ1IJSmL3q/G7hEGVaFWFQqa2lHi+d
         YfeI3x+R2ZmAmvdTjAtm54anFEVaXbEghak8feJHsvagXZISH/o4V8zi9yuJH3m9YSgR
         yLkB1acH/GUQXOK7ccv8vf393x6WkE2nazOlAXjaclD4En6qQDKATBZWeDqArWZyutte
         B0D993S1sdF1qgVfU5XLEhymKmHyOsaUSnjkUAyPxwbxO/Y3RIAuS+QY1/DlcbqC0HXM
         jVodBonRTz+pv+iPRq9rNaUG4GwIwG51NKyJWLWVPr7MuWhMV1wV/s+yM64viXI5Imwi
         0HTg==
X-Forwarded-Encrypted: i=1; AJvYcCUHaMM1YmY44AKWgkrjj/RG1ceIvdYHQyhMAlVo90syaUaFs2tLRGSwbjS3oXRlRwPE+8Y2lQ058QS8@vger.kernel.org, AJvYcCXT0h/SXoTunz/lM2zCGB7KkWXfnr2ud+S2BMUeuG/UFI5EAVjnvlkJUl7Rz34fDa7rQOEzf+mvMyil1Zx1@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxiNKgugsaAshC6vQ45thBqRvpmMZrBYV+BzhNv9rnyTwL628
	Kao2spNt5xjktVDowNAmTlTWoHoPdZ+W7Av6bZcl7Gg+Ydxi23cf
X-Gm-Gg: ASbGnct9e9Gg62mN238c1m1iJvuRXQMMOsfOvcsAibL5CmgHBP24lc/UBF6OyXaxK3a
	+fd3PZAA1NPOemttn5FTBlQMhZMETjb1JInX6fM1yACIzVeVaoX8oNwJfGgbDyUOUQx6KrNkuQA
	/Dgwr/tV7yzRy0WljnKVhBh2QnCdkqKPU4kTl4ZkBdY0zgUd0dNDyE2uJ6m89fhJ1NCkztpbO4i
	gmZ2mnAW3BoDc0cKxmLlcT7CBQg+C9az7Eq0Fb3RSR/8y/nft93tSqxDJaSea1MXRDxDNxytewf
	gLhdTLcyKVNt3h8NkqE4Ga/4ullqTfL8RGI19tATuFaNTeCJcHL4D1TcR+7/pYNcHC84HLpv
X-Google-Smtp-Source: AGHT+IF2PPpA5m0LdNbLmv+C2VzL4+ag8aQtphiRxdf9NymmWeqgUCheAUnp1GoDDrvzrYazgYP+ng==
X-Received: by 2002:a17:907:2d88:b0:ab7:b896:b80c with SMTP id a640c23a62f3a-aba50fa0b94mr1264192566b.9.1739735621628;
        Sun, 16 Feb 2025 11:53:41 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb904a4ae5sm165308766b.29.2025.02.16.11.53.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2025 11:53:41 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20250216134918.1357069-1-liujianfeng1994@gmail.com>
Date: Sun, 16 Feb 2025 20:53:27 +0100
Cc: conor+dt@kernel.org,
 devicetree@vger.kernel.org,
 heiko@sntech.de,
 krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 robh@kernel.org,
 sfr@canb.auug.org.au
Content-Transfer-Encoding: quoted-printable
Message-Id: <2FE649E5-61FE-4299-81D1-F838298A04A5@gmail.com>
References: <566E6F11-765C-4415-8805-55DFD3C2BD4D@gmail.com>
 <20250216134918.1357069-1-liujianfeng1994@gmail.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Jianfeng Liu =
<liujianfeng1994@gmail.com> w dniu 16 lut 2025, o godz. 14:49:
>=20
> Hi Piotr,
>=20
> On Sun, 16 Feb 2025 13:37:05 +0100, Piotr wrote:
>> Is there anywhere repo with this patch applied to test it on rock5 =
itx hw?
>=20
> This patch is applied to 6.13 and I was testing with armbian:
> https://github.com/armbian/build/pull/7829.

Well - i build 6.12.3 with current armbian patches:

=
https://github.com/armbian/build/tree/main/patch/kernel/archive/rockchip64=
-6.13 (all rk3588-*.patch)

 + https://github.com/armbian/build/pull/7829

and i=E2=80=99m still getting:

root@myth-frontend-56b0f018b5e0:~ # dmesg | grep drm
[    0.529361] rockchip-drm display-subsystem: bound fdd90000.vop (ops =
vop2_component_ops)
[    0.531139] rockchip-drm display-subsystem: bound fdea0000.hdmi (ops =
dw_hdmi_qp_rockchip_ops)
[    0.532197] [drm] Initialized rockchip 1.0.0 for display-subsystem on =
minor 0
[    0.532846] rockchip-drm display-subsystem: [drm] Cannot find any =
crtc or sizes
[    0.533538] rockchip-drm display-subsystem: [drm] Cannot find any =
crtc or sizes
[   10.157564] panthor fb000000.gpu: [drm] clock rate =3D 198000000
[   10.160033] panthor fb000000.gpu: [drm] mali-g610 id 0xa867 major 0x0 =
minor 0x0 status 0x5
[   10.160755] panthor fb000000.gpu: [drm] Features: L2:0x7120306 =
Tiler:0x809 Mem:0x301 MMU:0x2830 AS:0xff
[   10.161569] panthor fb000000.gpu: [drm] shader_present=3D0x50005 =
l2_present=3D0x1 tiler_present=3D0x1
[   10.219825] panthor fb000000.gpu: [drm] Firmware protected mode entry =
not be supported, ignoring
[   10.221411] panthor fb000000.gpu: [drm] Firmware git sha: =
814b47b551159067b67a37c4e9adda458ad9d852
[   10.222315] panthor fb000000.gpu: [drm] CSF FW using interface =
v1.1.0, Features 0x0 Instrumentation features 0x71
[   10.223733] [drm] Initialized panthor 1.2.0 for fb000000.gpu on minor =
1

Initially i was thinking my board is defective but=E2=80=A6..hdmi1 works =
nicely with Roobi OS flashed by radxa in eMMC so i=E2=80=99m really =
puzzled with this=E2=80=A6

Is it possible to provide me url with kernel package you are using (wich =
works ok for you)?



