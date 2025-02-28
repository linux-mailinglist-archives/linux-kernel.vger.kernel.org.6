Return-Path: <linux-kernel+bounces-537641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9FEA48E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD4A3B5E08
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48887145A18;
	Fri, 28 Feb 2025 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="cXHPewBE"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188DB3596A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709573; cv=none; b=NbJThCYadb3D2l0Bq+EmgPoz6fOEY7Ocu1PeH3qooPYWexoMmkD64PgdlpAw5DqxfwRKRen+aSGuF0Fpw7qY6cibu6jqnOUk0Xj9uELkRK1/P0tuK3S8wcqpDFjUVThdZOp8E0nFxkpHfgLwPt9tVPkS1ka4lqpCJsK1ADrFFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709573; c=relaxed/simple;
	bh=2RjuojcGz7OIb+BqenvzLYjiwmJCtWUXykp9gpRxjoo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eY+sWNFjVTmr93CBNjCbaFQIBJcSJ98VP/WvUwC+Q7FiECXf+cqhuPQrSW3JjizhwKUx7EamEYan5TRT9t7hisptp9JwAkUCKOVhSPc2IiDSsXmTMVi6xtopT+Xj8wfDCtn7DccgfLPDePXZU5HonxrXbdZGobPhzG90Km8HGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=cXHPewBE; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e89b6b5342so10966696d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1740709571; x=1741314371; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VJcCBxZrPcF1HtINZMO6IVGAMykP+k9zuguph0IARao=;
        b=cXHPewBEc/mOcfV2g5jYx/OOQYP0tq6uH+W+Cab579WN5mN0DzP8LtK5EgxYiyQhO7
         5dfWbfE/tGeMcWjb8opWC+E/0DOkcsVs4lDHA9FsjsM/6OLpLqkQQwnl4DVYZqcL9o2e
         2vSYdAKwhYaW/QyGrYRhub98CTbzWeAD5URlX7OuTjLm68UA50L35+2w3Y/FxJxGXePA
         oTcliTqe8v34ffBr/savgCih/cJJ8kbdXUf7V9HV3/jXI0UhFoUY3Cfc6Dcsa2Wd/pru
         tcrNGrjfdiJvi0Plqq/nex5SlDGBQExsZ8KXjJgWdGLIejALqguTweeNoQCPIcaV597m
         gMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740709571; x=1741314371;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJcCBxZrPcF1HtINZMO6IVGAMykP+k9zuguph0IARao=;
        b=VnzEwPGOUDVA3dtWlBQR3lH6FMCdBlbvc5gh4D0JciuH7UwU9esuo880Y43DcSU33W
         W+nTlOZd7jze+sg/PjA+t+T3C4is0U3XtTQRZCRfNc+GccIDeYVDY7dCe1ubf/FvlRyE
         y15iYXy93kTEYJpiVdE01cyCp5Izk+IGktTIcAvggynBViYY9nVVukyI5IomCGc92w9A
         fvFpZzmD+Np7sHfEBSlRIOWdz+29MgnHp8Xk50P1Is8KeSwJPGATbAuHX5UH+xy4AXA6
         TtQQm0gk/0TNGyELzp4xxeHzS3PMCN33jphAf0GM1BlSNGieqM1tHuDulxGW/a4WL0h3
         HqHg==
X-Forwarded-Encrypted: i=1; AJvYcCXgOcUCgfUJtuSYaNFAkafw2moJqXzJsoQAgXZt6lIE4GF22R4RaqMx85JQaCyie5+HOGlKbX1PfFHTC0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+Sv5nsgtx12f8XW+NObJSwRsfFdM9PDGmouN43jbS1kjDGSa
	kTw9RkV+KsxZvFAz72oK6D/oWXRuNvwHTI4hrS3ZPAkAezdgXEhmgm4wRx0IJvY=
X-Gm-Gg: ASbGncskiaCRS4cs2iyQD2meErwARKl4/RXU+lSg3x9NXXxIZ25TlRUYfPExZn+KThP
	9pQgCnGYKAMrXaEAkKQjO9QByafsqHyt+YLVsWWj7WIiDg1xJgBwrKBqL+aM7ax6vgmPXEEOr8S
	ad6HuwoJEzTV16jzkjPg7Ucb1g5Ih6OTy2XfhnalsTf23+xlXopT4Hn/oeyaLcHs/IFsMhDyOZp
	75mtMKlnwteqGvUm1pE7Cuja/EDIBKjoHmFZTuoWFbcX9not9oWoWjYcOgfKOOup5FFCckg74Gg
	Fu2usfoeoq1XfFLOc61qjrQPXpgGVUU=
X-Google-Smtp-Source: AGHT+IGUs//lkbvx/dTZ6S1dXtcIeqOusIiHyVcn8w8wYwcYyF0soDMXcDq4Vyroqi8kUxCmEF+Ucw==
X-Received: by 2002:a05:6214:2b0b:b0:6e6:6225:a910 with SMTP id 6a1803df08f44-6e8a0c9f160mr30820726d6.14.1740709570881;
        Thu, 27 Feb 2025 18:26:10 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:e976::c41? ([2606:6d00:11:e976::c41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976da38csm16657186d6.108.2025.02.27.18.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 18:26:09 -0800 (PST)
Message-ID: <fb0e0c207cd6c2cad39c2a38398080d93db4000b.camel@ndufresne.ca>
Subject: Re: [Patch v2] media: s5p-mfc: Corrected NV12M/NV21M plane-sizes
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Aakarsh Jain <aakarsh.jain@samsung.com>, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: m.szyprowski@samsung.com, andrzej.hajda@intel.com, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, krzysztof.kozlowski+dt@linaro.org, 
	linux-samsung-soc@vger.kernel.org, gost.dev@samsung.com, 
	aswani.reddy@samsung.com, pankaj.dubey@samsung.com
Date: Thu, 27 Feb 2025 21:26:07 -0500
In-Reply-To: <20250226102251.9040-1-aakarsh.jain@samsung.com>
References: 
	<CGME20250226102749epcas5p35afe43774ad2917b846c921dc593a5ef@epcas5p3.samsung.com>
	 <20250226102251.9040-1-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le mercredi 26 f=C3=A9vrier 2025 =C3=A0 15:52 +0530, Aakarsh Jain a =C3=A9c=
rit=C2=A0:
> There is a possibility of getting page fault if the overall
> buffer size is not aligned to 256bytes. Since MFC does read
> operation only and it won't corrupt the data values even if
> it reads the extra bytes.
> Corrected luma and chroma plane sizes for V4L2_PIX_FMT_NV12M
> and V4L2_PIX_FMT_NV21M pixel format.
>=20
> Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
> changelog:
> v1->v2
> Patch link: https://patchwork.kernel.org/project/linux-media/patch/202408=
06115714.29828-1-aakarsh.jain@samsung.com/
> Removed duplicate code and aligned luma and chroma size
> to multiple of 256bytes as suggested by Hans.
> =C2=A0drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/dr=
ivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> index 73f7af674c01..0c636090d723 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -549,8 +549,9 @@ static void s5p_mfc_enc_calc_src_size_v6(struct s5p_m=
fc_ctx *ctx)
> =C2=A0		case V4L2_PIX_FMT_NV21M:
> =C2=A0			ctx->stride[0] =3D ALIGN(ctx->img_width, S5P_FIMV_NV12M_HALIGN_V=
6);
> =C2=A0			ctx->stride[1] =3D ALIGN(ctx->img_width, S5P_FIMV_NV12M_HALIGN_V=
6);
> -			ctx->luma_size =3D ctx->stride[0] * ALIGN(ctx->img_height, 16);
> -			ctx->chroma_size =3D=C2=A0 ctx->stride[0] * ALIGN(ctx->img_height / 2=
, 16);
> +			ctx->luma_size =3D ALIGN(ctx->stride[0] * ALIGN(ctx->img_height, 16),=
 256);
> +			ctx->chroma_size =3D ALIGN(ctx->stride[0] * ALIGN(ctx->img_height / 2=
, 16),
> +					256);

An eventual port to v4l2-common helpers instead of open coding this
would be nice, though I see nothing wrong to report with this code, so:

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

regards,
Nicolas

> =C2=A0			break;
> =C2=A0		case V4L2_PIX_FMT_YUV420M:
> =C2=A0		case V4L2_PIX_FMT_YVU420M:


