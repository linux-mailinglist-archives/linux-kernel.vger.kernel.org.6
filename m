Return-Path: <linux-kernel+bounces-516779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C24E5A37748
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A19167621
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54931A239A;
	Sun, 16 Feb 2025 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNRQemKD"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE01494AB;
	Sun, 16 Feb 2025 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739735625; cv=none; b=VcuVobz6BbK2Pw8EBQHWFYG0ZAPvRSrQ2sNWfxCK/htK6faQa4gXUCX560lzPsXfTOQTWQzlMef28PD9/5prfB4K2oaajnFWoEE0Mn2wxX1RHJnP2VU0UnqzGvQJcJVPTPe3eU+ksYkgIo4dMKgE9xHawt1RyDljn10QhQyPoRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739735625; c=relaxed/simple;
	bh=0cUM+2ow/h/nzbuzL8uF2L/aTYu78jPmqJNt+qnVHn0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oDVtTVVdJMOzsyAj/u0IamEOYnkU5vvARrkqCaaGNHAksDMhBOtPGoIANW6d9ZGsvDp1UOJ7YsXnXPaHkn9Ig4Mygw7G4jIWRPeZ9Gzq3fUpnsHSlLwyR4+XkLzsZBN4337PxDlA1f+4nCWo1wWztiEP7N5Wq76zDihPSC5GEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNRQemKD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so6743372a12.0;
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
        b=f98aQi8r8QJFBRioiqa+RUGDtbfuujbNASD/0d0HPtAMXvpBjklhxAfwRWvPupoLCw
         0IqSJaakgicSprxmIGnBxhBG8hDT4+76Ry2Jxq8kEwWh+gcsbOm3uo6y7z2MJLfM+5Q1
         xctYRJnnJgQkyc6ZFHQsMDG7wMCWpDKwIOplbU/0xpzb6RV7aNgum9MK/sM5bA8xHRlY
         PO6S3RE85nOC4+9LLU/PG5QmJzG7NfU6DxvUSqNbl7+3SYKs1Qet7J2MUzdhHAIYN0UT
         yZesF2iZ+1rgVan2yoGiUCeAdnoBAtkKdBvb64+9XdSxOWlaLlyE7hQ9ow8VveGNrsUw
         +7sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTJAy66w9oPz1teCaYCZxgJSAJIvAHWQqKCPXLiW7zPaRvc4XMzSDmo9ShTIAsMoR5fSyNnUR4z8oVFXaK@vger.kernel.org, AJvYcCWUP4fH/OYrQ/mfO7MiQCYw8ilIzZBJmYsxAfwSTjBhjOS+bKs0an8yGGU1d7Tr3jnTEpgVQXcd9mYb@vger.kernel.org
X-Gm-Message-State: AOJu0YwpOUE7pm+HjBJpcLcrfAJlxTPbg8pXwdO9IEV2ZR6umTcGTKjt
	a2DVmFb5XokepGlbwkX6iASBZvRo9qIY+Tm+VJHtfwsGEZDBdiGj
X-Gm-Gg: ASbGncvsha5/VL5qeTWLphqCSE+TttTPA860iv4P4gTcimTrD2ayp3zsdOy5rO5LGh2
	7CIjmfp2NWko0IvalRwqqSjXCShHQ13TNwN27KHCrpki1f9IBz6b2nyWc8y8efDk+wUqJQrLtRq
	nYh68tMaWPXVo8ArYxV3afeTAa9gzpm897ixludhCrH+K8A14QU2JssPwwpIH1j9V+x4HljvKxd
	OY88uuKudE/Fq3jKBRKM2MqnIl5ZyFvIjjwvdu7WnpEkjog8w6jD+oocTkLET7VEo2Lawl/9VjD
	RhsTRgSliPOMlde4x9KvxaMuL/j6rzELEQvz/lJG0uOnerwrtkk2rx8ruNUnz3ng32extAFg
X-Google-Smtp-Source: AGHT+IHNAYN/ohlBH1PsGGST7ieKr2wc9iNQj10zrIC3IuwUmk0o8j5XTagbop5wOPUoxS8ZwtDvrg==
X-Received: by 2002:a05:6402:51d3:b0:5db:e88c:914f with SMTP id 4fb4d7f45d1cf-5e037222d59mr7744568a12.4.1739735621515;
        Sun, 16 Feb 2025 11:53:41 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d3493sm6225309a12.35.2025.02.16.11.53.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2025 11:53:40 -0800 (PST)
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



