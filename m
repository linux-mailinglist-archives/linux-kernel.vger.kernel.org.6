Return-Path: <linux-kernel+bounces-549122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C6A54DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF171896EBC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B601714CF;
	Thu,  6 Mar 2025 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGrnyQbX"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588DA1624DC;
	Thu,  6 Mar 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271306; cv=none; b=oHilNyLB73fQbsYkeR49AYlleLtcxVwXNripsdAV7sYtpAm/UyMz45p4fjft4yU9KPiYaxolHA7xM5bSH2WjPjxnep60/bSWXFTB5pYw43X5HMrK6/1QF2iFJrFRUjCc52v16kIjlOL8cmPZ75g+yWZnVnBzq60xP8tPoDe3s9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271306; c=relaxed/simple;
	bh=AbwweIdVlQuGTpxqBxt0AtzrQBaGwIPj9kBjzOEZl2k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ufgDrgRxni59wd16Tgxa0WlZ7VoUCoVgSQM/98NLEZ9GKb5zz8NdoIEzt/bZEATCVckVc/ad84sbMlny510qxvGdr06dcV15TDi3p9tiZvtN+C2q/amMcagfIWfGWmVMvaNgiiMzRH8KjeUoRMOCAl97UjC/05pwacVEuG/yvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGrnyQbX; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abbb12bea54so150317066b.0;
        Thu, 06 Mar 2025 06:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741271302; x=1741876102; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0vWWMcXjFfg9c9qiH6NSV7bmKttHRNGNsOhNehrSvM=;
        b=XGrnyQbX2toPV8G9GlRc1SC+IHbLR6cc2yEYSR/w7PxwENlnZoTz2/MtW/I9INpBSS
         bsGVdRnSREAq+1fVKM3d15ER0I5MnxiQ0PnFQ3+Bp1DtqG16Dpe+tHee1wPytyMeuq7p
         BTot7cnFGVjpDaEuXnLeUDw4aHO6hCsfKXIh3Pvs5tGViTXa97/Xdy6YiwtKYfR1Od2o
         fbicEoTQWTwfPu4yWtwkZTWoLYUT2LeMfgKmlmY5Z46YL5gmsqrN6E9l7tqXT+d75MOU
         VQNvSHH+7MzJRUHIJ+avIHr8Wz4omI9fm6Iu7mmX5cp+PDJSTqSy3KeWAtSlN+LBdydH
         cjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271302; x=1741876102;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0vWWMcXjFfg9c9qiH6NSV7bmKttHRNGNsOhNehrSvM=;
        b=hguHVZws8OsciStjwAVCQW5wvwSiv3Z612rDlTqj91gCljWEoFag3rFVFS59xlnIJv
         DS/iZbR8TL4dgXf+e55JE3izx59Kg9AChRSbQSjownwICR+UvsY0v08LFL2ccqHJ+aiX
         /FzsgZZLpHCid+uB/ENeYtYDRRDU5EKUsxga6AM3hVZAupcHpVv/SOwQKBRQ2+TQSYVP
         01EuKI65HszbDJeXQ6dDt4i9mdT7+7RpjTKfNp3TiZo59I+6dwix4RoNGoQ4C9Aadwk1
         QF145FdlQwBFOpyUgGmSjpv5p9Uh9rrOl3S8uWjszy8+d69ouRp+XBbg0aA7W/kpyjQP
         7MPw==
X-Forwarded-Encrypted: i=1; AJvYcCUTMC4C0YdjgAJFEPlVKbdavK1vHyTk/szcKo4HXo3YWMcVBzbC7A/9WBoincWckvDepfFPxt1bmZCt@vger.kernel.org, AJvYcCW7bhn8fB1pUa3usKXjftpdlNJXLyDplpB/BcDR/Z46M3GtxKHvn3FSp4f2LlwhLTVuWnHPgziIv1TpXTxC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8WCBRx3HSAwBhwO9RMs31H/pzoqUJ4Y8VtCRSMVHFjqMsFHq7
	55kNEOVAiVI/DDZkocIQBPKeYBhyapossaf9qb2rqJtgWjrJzJ3I
X-Gm-Gg: ASbGnct5FVMePMaBvKi1g5JvZ03FtB7eOerM80HLXgEFM6au2BNH3+mxNHKAeEBZ06z
	P9cCeby8vxkaSCOaMh08H9hHFDD5KfYebCBPPmXPptHZYzypopQJwuRADO7U9HrkjgjEBbzOhN6
	iBn4HhOx4zVOzlEj9QhYhgA7TEYLZwU3uvizhR7KnqSMsRuf8kGUjN96Pql0XyurBjcN7/Cantg
	N5FRSxe61bTgWcGHSztQ8SK6Pbm4PFke/LdYnKWVQLxGzr7qKJ+AWc1UmuWvMy+iUPwUcwPLP3h
	UqeD0i3wqBN12E9/6qZKvTKMeoj3F90cbKNvXV0TfgzlWQr/VUf0PRhP4Yx+iKj/jd141cPv7SB
	cd6UCTpI9AfYhR0G8GUgHPcQXBQ==
X-Google-Smtp-Source: AGHT+IFozHswlf0bg9ThZSp1FbgljtVYCPPvnTD1k5tckBB+eJRBJhF1NQdof80kjppsiFvLEvgOsA==
X-Received: by 2002:a17:907:3da2:b0:ac1:e2e0:f8d6 with SMTP id a640c23a62f3a-ac20d8bcb19mr672425066b.17.1741271302225;
        Thu, 06 Mar 2025 06:28:22 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399d4ed4sm104210166b.178.2025.03.06.06.28.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Mar 2025 06:28:21 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 0/6] Add support for RK3588 DisplayPort Controller
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
X-Priority: 3
In-Reply-To: <252BB2E2-4BC5-4402-953D-F7B30EA5DE14@gmail.com>
Date: Thu, 6 Mar 2025 15:28:08 +0100
Cc: heiko@sntech.de,
 neil.armstrong@linaro.org,
 sebastian.reichel@collabora.com,
 devicetree@vger.kernel.org,
 hjc@rock-chips.com,
 mripard@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 yubing.zhang@rock-chips.com,
 dri-devel@lists.freedesktop.org,
 Andy Yan <andy.yan@rock-chips.com>,
 krzk+dt@kernel.org,
 robh@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <326B91E9-FB91-43C3-B98B-3EF079F313C6@gmail.com>
References: <25401bfa.291d.19564244e54.Coremail.andyshrk@163.com>
 <75189787-28E1-4FC2-8E10-4960B3877A6F@gmail.com>
 <28b0d3fc.bb3.19568f6b5f8.Coremail.andyshrk@163.com>
 <44213B17-FE14-4FB8-8319-1E31BBF6EAA0@gmail.com>
 <74c154b6.8c50.1956aa8c8d2.Coremail.andyshrk@163.com>
 <1573D5D6-AFED-4D92-8112-B0C6BB52D5FF@gmail.com>
 <46c0d239.a4f5.1956b619b97.Coremail.andyshrk@163.com>
 <252BB2E2-4BC5-4402-953D-F7B30EA5DE14@gmail.com>
To: Andy Yan <andyshrk@163.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Piotr Oniszczuk =
<piotr.oniszczuk@gmail.com> w dniu 6 mar 2025, o godz. 15:08:
>=20
>=20
>=20
>> Wiadomo=C5=9B=C4=87 napisana przez Andy Yan <andyshrk@163.com> w dniu =
6 mar 2025, o godz. 13:15:
>>=20
>> Hi Piotr,
>>=20
>>=20
>>=20
>> Then when you DP cable plugin, you can run command as bellow to see =
if the driver detects the HPD:
>>=20
>> # cat /sys/class/drm/card0-DP-1/status=20
>> connected
>> #=20
>>=20
>=20
>=20
> Andy,
> Thx!
>=20
> With above changes i=E2=80=99m getting =E2=80=9Econnected=E2=80=9D.
> Also it looks crtc gets reasonable mode: =
https://gist.github.com/warpme/d6220e3cc502086a4c95f05bd9f9cf0c
>=20
> Still black screen however=E2=80=A6
>  =20

some additional data point: /sys/kernel/debug/dri/1/vop2/summary=20


working hdmi:

Video Port1: ACTIVE
    Connector: HDMI-A-1
        bus_format[0]: Unknown
        output_mode[f] color_space[0]
    Display mode: 1920x1080p60
        clk[148500] real_clk[148500] type[48] flag[5]
        H: 1920 2008 2052 2200
        V: 1080 1084 1089 1125
    Cluster0-win0: ACTIVE
        win_id: 0
        format: XR24 little-endian (0x34325258) glb_alpha[0xff]
        rotate: xmirror: 0 ymirror: 0 rotate_90: 0 rotate_270: 0
        zpos: 0
        src: pos[0, 0] rect[1920 x 1080]
        dst: pos[0, 0] rect[1920 x 1080]
        buf[0]: addr: 0x00000000017e1000 pitch: 7680 offset: 0
Video Port2: DISABLED




non-working DP:

Video Port1: DISABLED
Video Port2: ACTIVE
    Connector: DP-1
        bus_format[100a]: RGB888_1X24
        output_mode[f] color_space[0]
    Display mode: 1920x1080p60
        clk[148500] real_clk[148500] type[48] flag[5]
        H: 1920 2008 2052 2200
        V: 1080 1084 1089 1125
    Cluster1-win0: ACTIVE
        win_id: 1
        format: XR24 little-endian (0x34325258) glb_alpha[0xff]
        rotate: xmirror: 0 ymirror: 0 rotate_90: 0 rotate_270: 0
        zpos: 0
        src: pos[0, 0] rect[1920 x 1080]
        dst: pos[0, 0] rect[1920 x 1080]
        buf[0]: addr: 0x00000000007ed000 pitch: 7680 offset: 0


