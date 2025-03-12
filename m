Return-Path: <linux-kernel+bounces-557866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F81A5DED9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F51189CA84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3074424E009;
	Wed, 12 Mar 2025 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTQn+PZS"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5722DFB4;
	Wed, 12 Mar 2025 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789412; cv=none; b=BiQCs24xMdfCygKP/YPSeD8gdxp8BSIcJNGX0sG/h/45VXHBObCOoosDvJdDbvu+wI152Cj00FvZ3Ei4e8SvVhweJ9sVkL18OTz9qE/a06OzNQ/lpHTv12GCFpHTR6KbrNLUT8rjjNck4wQ1CPcXQt+lBvpRljS5b04KpBaSiIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789412; c=relaxed/simple;
	bh=BaBUcHE4gsCZ9T7WCSTssB4OMO27xrw+ULCT8m2ZIAo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EqhlR/VsX9J0g7cDO53NYs4yzzEbXps8287UtZiB17E9+F8PpwGj61H6tLCbJX+O7IRmzoT3aOnEYINXUkOPqwdBmXs1cwsKa2ZG8WB2EGItBMuP4mOWUrDeFv5YDD4wU1r1ezIORcPpJFA/qsj4ploqLB4XYAPvjxPbKRBR+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTQn+PZS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac25520a289so961215866b.3;
        Wed, 12 Mar 2025 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741789409; x=1742394209; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEek4i2ZCkx6tmbDOfSqfNqakadAzuvY5GsHOU0PtgM=;
        b=gTQn+PZSgSf89MemIrgnDWEH4oHmdoLjoe+2cvxqQ6KmWb5zxap3HVxCi7mflrRI4x
         pIb0U5RhD1d0GVRBQd9oqukrPl/pqlmvHZkibMRHDWflBv3IHCWsJwto6fRTPcXRlg97
         etAXZ0e+AQcoCLzleknFFo7E6tJR/Aurc3/gVGOADG+8zBQT2EnNV5Intmuo9nqNM+QT
         d3zMjxp5uzrKgY82yVnT3sPk9GiWaxL/PTtGLpKbOTzacR/RXupFbrNZiP182G8cj6vx
         /9ChYVrxcf6AUz0sKOWXQ2SePWUhZmPsscYEhCsklCHxMk/EY/bsc4n0KxRFuwpshNPN
         nvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789409; x=1742394209;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEek4i2ZCkx6tmbDOfSqfNqakadAzuvY5GsHOU0PtgM=;
        b=dqTZicIiVC7V3S49yjXt6Q4CpFQXkyLc0e1V+W/goTFpJsRuwQand2ZvqNk7t/XhI1
         yIRezL0jznqwdOJFejBOsNLf7sgiOH1m6z53vekrXJ9650AXX5jtbjNhUguzs/CKPLVO
         qxM6Objv+nf46jpWu33HHMDGurGE23O3eF/hzIaqzGgpFFKW2SePXGzaUQ2waiCED9UF
         fJPSyhbgjSyev4iaFl9MMQstMLiZQZtVoEjIyhW0+NvJJ0hs66AcC5RHsulNSiu4xshS
         m1ydR5MgJga0J4Od9YXkSwVkrzal3w3NIpnJN+zypW8k3w1SIQi9cDy+/qdJMZA9TrZG
         fpDg==
X-Forwarded-Encrypted: i=1; AJvYcCUFh2oswzGmNR8sXXWBxY/mz+f5/4ep9sAXv9p6lO87SiFy+GtB7yBYP4QA5lk/lHwn1Yqcg9u3VzvCQlrs@vger.kernel.org, AJvYcCXXup+rUcGQjGJVFlJvAm1x7Q2p5MCnnV7xbjRg35A2C0TNNOLuE/e1CcWnbjXQrKZTyUE/tS7HcURc@vger.kernel.org
X-Gm-Message-State: AOJu0Yypa/lk9YBOrEOQqfAzl/8ENQ1YqokgSBj9XTbuOjy2EX7lgz1F
	pMTjYw043IGpBQ6VLbrOBMTwjl1nQxx4r/Tqku07FQG7ZqsEqqso
X-Gm-Gg: ASbGncuaJ22B7GoquuX9cE6gkfULfaN5rRLhlrXLRB4Djz6GxE8HwOSIqfJl/3H2Cyj
	75zTVCfawo7ZmxAq+LpDGXye7uyhn1I6owagWVWmOlu0jY06q04PGkuDip+iswQdSAEjXEhwfxd
	zK3P//xtaSCG/9EiSaCYNYxLvr+cEkFGRCa658zXa2o4sPXsrLLbl65+4MOrnN9PdBSVGGx4jnu
	tiYfWThYBrmTMA1wf6F/bYkIJEojxp+Ps9oHerfJ5F5UZTfiYR2BVpnYfKiQM8oJfxk6oOXrw9y
	f2DcbWMu2KUvvCVw1ftzeRotmCcUKPz05pVh0NkvUmvogS7DYVBBNuO7DGlCF/43W2/Dlr4EbhS
	mVAJ5Mqa8FHY7ngStHMHEvzEIvQ==
X-Google-Smtp-Source: AGHT+IFdFvbIc6D4mXkiIL9CFWFvWjoXqM1m/Hjn3uEOvZC5n66LBMKABPlNlB63rI+HegTYSS5ruQ==
X-Received: by 2002:a17:907:d9e:b0:abf:6cc9:7ef5 with SMTP id a640c23a62f3a-ac25300a440mr2449963266b.47.1741789408746;
        Wed, 12 Mar 2025 07:23:28 -0700 (PDT)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2394825efsm1073903966b.45.2025.03.12.07.23.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Mar 2025 07:23:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v2 2/7] drm/bridge: synopsys: Add DW DPTX Controller
 support library
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20250312104214.525242-3-andyshrk@163.com>
Date: Wed, 12 Mar 2025 15:23:15 +0100
Cc: heiko@sntech.de,
 neil.armstrong@linaro.org,
 sebastian.reichel@collabora.com,
 lumag@kernel.org,
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
Message-Id: <61E9B36C-8568-4C0E-A9A7-07FF612912AA@gmail.com>
References: <20250312104214.525242-1-andyshrk@163.com>
 <20250312104214.525242-3-andyshrk@163.com>
To: Andy Yan <andyshrk@163.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Andy Yan <andyshrk@163.com> w dniu =
12 mar 2025, o godz. 11:42:
>=20
> From: Andy Yan <andy.yan@rock-chips.com>
>=20
> The DW DP TX Controller is compliant with the DisplayPort =
Specification
> Version 1.4 with the following features:
>=20
> * DisplayPort 1.4a
> * Main Link: 1/2/4 lanes
> * Main Link Support 1.62Gbps, 2.7Gbps, 5.4Gbps and 8.1Gbps
> * AUX channel 1Mbps
> * Single Stream Transport(SST)
> * Multistream Transport (MST)
> * Type-C support (alternate mode)
> * HDCP 2.2, HDCP 1.3
> * Supports up to 8/10 bits per color component
> * Supports RBG, YCbCr4:4:4, YCbCr4:2:2, YCbCr4:2:0
> * Pixel clock up to 594MHz
> * I2S, SPDIF audio interface
>=20
> Add library with common helpers to make it can be shared with
> other SoC.
>=20
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>=20
> ---
>=20
> Changes in v2:
> - Fix compile error when build as module
> - Add phy init
> - Only use one dw_dp_link_train_set
> - inline dw_dp_phy_update_vs_emph
> - Use dp_sdp
> - Check return value of drm_modeset_lock
> - Merge code in atomic_pre_enable/mode_fixup to atomic_check
> - Return NULL if can't find a supported output format
> - Fix max_link_rate from plat_data
>=20

Andy,

Just small Q: do v2 needs something extra to get it working (particular =
kernel ver or extra dependency patches)?
I just replaced v1 to v2 and dp stopped to work for me.

e.g. on rock5a i=E2=80=99m getting:

root@myth-frontend-fafc53b591a6:~ # dmesg | grep drm
[    9.245284] panthor fb000000.gpu: [drm] clock rate =3D 198000000
[    9.249464] panthor fb000000.gpu: [drm] mali-g610 id 0xa867 major 0x0 =
minor 0x0 status 0x5
[    9.249472] panthor fb000000.gpu: [drm] Features: L2:0x7120306 =
Tiler:0x809 Mem:0x301 MMU:0x2830 AS:0xff
[    9.249474] panthor fb000000.gpu: [drm] shader_present=3D0x50005 =
l2_present=3D0x1 tiler_present=3D0x1
[    9.257979] panthor fb000000.gpu: [drm] Firmware protected mode entry =
not be supported, ignoring
[    9.258030] panthor fb000000.gpu: [drm] Firmware git sha: =
814b47b551159067b67a37c4e9adda458ad9d852
[    9.258604] panthor fb000000.gpu: [drm] CSF FW using interface =
v1.1.0, Features 0x0 Instrumentation features 0x71
[    9.259671] [drm] Initialized panthor 1.3.0 for fb000000.gpu on minor =
0
[    9.324353] rockchip-drm display-subsystem: bound fdd90000.vop (ops =
vop2_component_ops)
[    9.324617] rockchip-drm display-subsystem: bound fde50000.dp (ops =
dw_dp_rockchip_component_ops)
[    9.325202] rockchip-drm display-subsystem: bound fde80000.hdmi (ops =
dw_hdmi_qp_rockchip_ops)
[    9.325506] [drm] Initialized rockchip 1.0.0 for display-subsystem on =
minor 1
[    9.325531] rockchip-drm display-subsystem: [drm] Cannot find any =
crtc or sizes
[    9.325594] rockchip-drm display-subsystem: [drm] Cannot find any =
crtc or sizes =20

dp status is "not connected"

replacing only this patch back to v1 brings dp back to work.



