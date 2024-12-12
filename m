Return-Path: <linux-kernel+bounces-443246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7A29EE92A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8F2168819
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6182210E4;
	Thu, 12 Dec 2024 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="nE3YEqk1"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8041215784
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014384; cv=none; b=shtK4bypFXBiL/FA46Pcjbuctmdx5qGZz7r5xukKtXIzhh/eyyOKnTOiP7bpJf+ydGRwzlaGEo2KxkLEqY0YcfmRP0ZIrHiGWVtoG2vSTclmfLM3WgrjqQeA/rPUgzkACCgmMsd/TbXKTyFR4++tsaVoqWsl/S4mWSXFd07Tdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014384; c=relaxed/simple;
	bh=V4H+RkOOPoNNuIkUPtageq9keE9J9/rHZNDzDW/fPS0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MfvIbCxdQwKm0DEUtVS3tKn3Li8M/YJTp9NpHrZFuWqxEQQ1VDJKocHBrIqdVrbRWHEzbNTg6iLsNyS+Uapvkpe7BdhUMgCJoFHNXGfPsYkRaCVaO1ZYQg60UEpDLi3aqNuPglcWAMtMkca4/7IXXvjB6nVpIO43qBThK33AYFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=nE3YEqk1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46772a0f85bso5480841cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1734014381; x=1734619181; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LIeJWDB2e3v6s0K160v2H6XjXslzfSsSGvjLFvy0AhQ=;
        b=nE3YEqk1jr3ss4rvOKYWLjGLxUP3Qtq/0CdNa4KdKDw6relbTszWSKvoFr8ZJmFmxz
         D7izbJyodun90Y0Z4OyRt0fqq8SCJR9PkByENqwfrN7/fdYS/c12WAoI+cFeqElHNJnn
         G7CRxUUip9g7JwyWnkVholLGZ9mjxbNGgt1zpFoboMNnikmndVjJEiv/+5/UXkRSV6LG
         CAfTUCaspl1yxbfoZLxHxkoEZpDVMC2SY/7wcVdC/zIv7zT0vg9p10fDaK1OpIg51AI1
         rGon+EyCeTkTMsGq23f8OyN2Z4Jtis05nS+w2/ixy8bRWdNaXCcM0gV+pdpO9GcxgTsf
         vKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734014381; x=1734619181;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIeJWDB2e3v6s0K160v2H6XjXslzfSsSGvjLFvy0AhQ=;
        b=q18YDoHK1T67vTo92I/TPnmcUN8jeWjiUUbsHA5XkCdrLUtrIR0kQVVnbJWkyzCSVo
         Br7ZXADiHuTl04asVGpxEiaM1R+n4s+pwICm71NMNfDwyWyLDAq2GneJElUAnkjUo5MS
         P01e2djWxrVpqd2/dyiL9JSJUVIMxiG+u54K676ny8i67hvbUjf52h1I1xa4OSweBb/P
         RMWe21iQ0vnsF3U1yYOkdrUVwDT+3sFAru5Ftfco6Kg6gtdwKResZ5r/FCLxqDtQwtRg
         M/oSQubdY/RXUdwMIfGgYSTiH7mb1ZXRU90EJV4q/W77I38UGH8kZuBKzS2KRpPfVkrr
         xvag==
X-Forwarded-Encrypted: i=1; AJvYcCVJvCLy/iSUkAP5Vs8khpgyZougGRlScnXk/Q3qlH1J1qDYsZrxKVn2cpUyD9g9VD6I10gRVen21uYUWAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWuC4YoObDeaLGj7EMkSG7abOWwu1ScF6SXoj8fgToTk+eM2Q
	zcMTTDG74n7M8BB40rOysQ3IQqt9NrZzNAyZKq/r7z4NIQIlNfY40BX4NEWSL30=
X-Gm-Gg: ASbGncsDD7/C/EV6mhIiOb108LGbztAdkWMfBTVqBu7HkeDOzqaTw0cton5qiAr4DBJ
	idnw/q0e8es/7n0BWfxYpHvhApWXwpdEGpYhmubqDx5VkG/gtLHDVe9JAI/msAagCMhwdmcGMsw
	8NODwmuJNAxUhoqBaOPn1tGAGEq4tJ87xz928EtUvhhMJoSkxSjOIcgobcEPNZE+n1j7d/BZY1i
	LuG75fDn41YeV8kV18PhZw/ztT1UGBwuMdZW8md3vWxbXb5w5ae6w3apA==
X-Google-Smtp-Source: AGHT+IGe6BR/nJYecL4uvVJeolPMjPs95fnRbDMbA7nYERaQwE6R6C8dpsFTy9fb3t3Pc0QRB2bHtA==
X-Received: by 2002:ac8:5f83:0:b0:467:59a3:b44a with SMTP id d75a77b69052e-467a170e8a3mr8393441cf.56.1734014380603;
        Thu, 12 Dec 2024 06:39:40 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:862e::7a9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467a115b939sm1298231cf.44.2024.12.12.06.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 06:39:40 -0800 (PST)
Message-ID: <6d322d25bef972851b323e795ef35bb8a8ef556d.camel@ndufresne.ca>
Subject: Re: [PATCH 2/2] media: verisilicon: Fix IMX8 native pixels format
 steps values
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com
Date: Thu, 12 Dec 2024 09:39:39 -0500
In-Reply-To: <01020192f83fdef5-358ea072-9630-473f-9407-53be13d85864-000000@eu-west-1.amazonses.com>
References: <20241104173623.1058335-1-benjamin.gaignard@collabora.com>
	 <01020192f83fdef5-358ea072-9630-473f-9407-53be13d85864-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le lundi 04 novembre 2024 =C3=A0 17:36 +0000, Benjamin Gaignard a =C3=A9cri=
t=C2=A0:
> Hantro decoder non post-processed pixels formats steps are different
> from post-processed ones.
> Fix the steps according to hardware limitation.
> Since reference frame pixels format issue has been fix, it is possible
> to use V4L2_PIX_FMT_NV15_4L4 rather V4L2_PIX_FMT_P010_4L4 for 10bits
> streams.
>=20
> Fluster VP9 score goes up to 207/305.
> HEVC score is still 141/147.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/verisilicon/imx8m_vpu_hw.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/=
media/platform/verisilicon/imx8m_vpu_hw.c
> index f850d8bddef6..35799da534ed 100644
> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> @@ -187,23 +187,23 @@ static const struct hantro_fmt imx8m_vpu_g2_dec_fmt=
s[] =3D {
>  		.frmsize =3D {
>  			.min_width =3D FMT_MIN_WIDTH,
>  			.max_width =3D FMT_UHD_WIDTH,
> -			.step_width =3D TILE_MB_DIM,
> +			.step_width =3D 8,
>  			.min_height =3D FMT_MIN_HEIGHT,
>  			.max_height =3D FMT_UHD_HEIGHT,
> -			.step_height =3D TILE_MB_DIM,
> +			.step_height =3D 32,
>  		},
>  	},
>  	{
> -		.fourcc =3D V4L2_PIX_FMT_P010_4L4,
> +		.fourcc =3D V4L2_PIX_FMT_NV15_4L4,
>  		.codec_mode =3D HANTRO_MODE_NONE,
>  		.match_depth =3D true,
>  		.frmsize =3D {
>  			.min_width =3D FMT_MIN_WIDTH,
>  			.max_width =3D FMT_UHD_WIDTH,
> -			.step_width =3D TILE_MB_DIM,
> +			.step_width =3D 8,
>  			.min_height =3D FMT_MIN_HEIGHT,
>  			.max_height =3D FMT_UHD_HEIGHT,
> -			.step_height =3D TILE_MB_DIM,
> +			.step_height =3D 32,
>  		},
>  	},
>  	{


