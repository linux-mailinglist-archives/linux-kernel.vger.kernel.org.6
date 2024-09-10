Return-Path: <linux-kernel+bounces-323800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D49743A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547691C24E44
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E091A707A;
	Tue, 10 Sep 2024 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="qUQ+iyly"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEBC17B505
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725997492; cv=none; b=hcrEG7pskSW8aWqCDLNw6z7MrHQDa/cx9cnDEYVkSsThz39hIQvoF3fCAzYGWZqqpGZeJ0DGXSlLYf3PXjlDGLbnWx5teG2DlLXloLW+HnD5dFT8DxWQ8O+eKS6chuJiHDL9NpEHWduSsCUjoMPqMEL1rm7EnaYLJLZom9vq11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725997492; c=relaxed/simple;
	bh=bMaAsqxpDzNR4JWuJkohtjEPlfLsDwYUOKeLbpg5/O0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HsOllsSBErI9EDE906oQr//nVQMSz7fKdTwKEETdf/fnEnE47zd04sCHLQEo1fmLMU2bfHcWdmRpKkY/bt2oaXQ1uTevlqO+YkyAt/malhy2cKkM5HUnvafSfA2vpRw/i9aaC0c2VmUmacu3r/YJxVlH9B5gaun3TlIVLTJ/yok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=qUQ+iyly; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-846c36009d5so336714241.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1725997489; x=1726602289; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=paDdDLZuWPg2gJJW4B+S1cFVaWCPfU31jT9c47Deq1c=;
        b=qUQ+iylyy2Z6YIXN3bi4VGgSs+vtcXs+KAlXO45f8DqQILlqzPgnm8B33tbx1EDWOh
         qIqsiLcx0jv2RyXJZiPICBBf24nhdhWTYLHFYPWue5wmPEke216R49wtlf/XqxIDsxN9
         /cky4PKFSCPv9jGpaFttW88/8a1cW3aCHS6C+svlwK5k4OLE0z9peVXKK9AyPHhpqr75
         fz7bO0VdE/sGGdzbIeF4blKXsLCZT6bRl6dSi2oxMHZLGjlbqTeIX0QOf+1JM7O0aGHA
         aw3vz4tdXKRrLSASCPyG88snIU+BNLqeSfxWa6/VqsUTdeFDYhRioRLQQcybKxxqoM3i
         fkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725997489; x=1726602289;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=paDdDLZuWPg2gJJW4B+S1cFVaWCPfU31jT9c47Deq1c=;
        b=WpQ/rFDKb5pXYOW61VNi4ZuOT4R8VpKi3wA9YJjY9Lo+3bwuASqHLGe1AQDVp7ily6
         lCC7/1Sm8UWu8WQUSyYkq3e4T1pDCFdwO1cW3Z0limPRDD3OWrX58hIRWYDmFCYG/+nf
         /d9bCqA9ZVQ+/vN8IwpxQqTZBQMf/eBrSuoGOyZ7M8533iJ6xiGNLWSFa8lHseDX08pQ
         QfANmxgNH1ukcbKrrlai760b4Nm6WW5CeKUNj4nwYxlk+Bya0+49iav9onMrCG1rRdSV
         vSXLuD/GQEWDJjy0VsycjKOhGhBfqttO/o23jBVE5la7LqJBnCa0B4BimTRyZyaeGM4z
         c77w==
X-Forwarded-Encrypted: i=1; AJvYcCUDfqAfalR0/lclwxIgRHERzq2aocOTz7hBirZCp4q4AIutotyjIOKA71qwbqtUdK+tzNAYXtyuF3Au0Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz8z/+rsYZ3uZOFQNDDWiGmm9b+Hg1VZw9DqpTyx0mGGjMO8Us
	PSuM7w9pnJlGury/Ju7AjrFN3i2H9RnyvIPOnxtK1ReeUXCE/moPX+kOIbTka+Y=
X-Google-Smtp-Source: AGHT+IFg9JLqxdW3sXfJRhqrKXQcUosatQMw8YzACBm6eCw99hRxZNZ+Q4Fu0IP4u78spQSl2exOIw==
X-Received: by 2002:a05:6102:d86:b0:493:d3ec:76e5 with SMTP id ada2fe7eead31-49c2423d34bmr1186558137.18.1725997489510;
        Tue, 10 Sep 2024 12:44:49 -0700 (PDT)
Received: from nicolas-tpx395.lan ([2606:6d00:17:9cac::580])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53432dee3sm33173866d6.8.2024.09.10.12.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 12:44:49 -0700 (PDT)
Message-ID: <10f107089cf679bcabd03e49fc469bb89518deeb.camel@ndufresne.ca>
Subject: Re: [PATCH] media: verisilicon: av1: Fix reference video buffer
 pointer assignment
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de, mchehab@kernel.org, 
	heiko@sntech.de, hverkuil-cisco@xs4all.nl
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Date: Tue, 10 Sep 2024 15:44:47 -0400
In-Reply-To: <01020191dc45365b-26b103cd-153a-4b74-a663-ed7beecc1713-000000@eu-west-1.amazonses.com>
References: 
	<01020191dc45365b-26b103cd-153a-4b74-a663-ed7beecc1713-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le mardi 10 septembre 2024 =C3=A0 14:10 +0000, Benjamin Gaignard a =C3=A9cr=
it=C2=A0:
> Always get new destination buffer for reference frame because nothing
> garanty the one set previously is still valid or unused.

Mind documenting here which tests got fixed with this change ?

>=20
> Fixes: 727a400686a2 ("media: verisilicon: Add Rockchip AV1 decoder")
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c    | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_de=
c.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
> index 372dfcd0fcd9..2b9a1047479c 100644
> --- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
> +++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
> @@ -161,8 +161,7 @@ static int rockchip_vpu981_av1_dec_frame_ref(struct h=
antro_ctx *ctx,
>  		av1_dec->frame_refs[i].timestamp =3D timestamp;
>  		av1_dec->frame_refs[i].frame_type =3D frame->frame_type;
>  		av1_dec->frame_refs[i].order_hint =3D frame->order_hint;
> -		if (!av1_dec->frame_refs[i].vb2_ref)
> -			av1_dec->frame_refs[i].vb2_ref =3D hantro_get_dst_buf(ctx);
> +		av1_dec->frame_refs[i].vb2_ref =3D hantro_get_dst_buf(ctx);

Good catch, would still be nice to improve the commit message.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> =20
>  		for (j =3D 0; j < V4L2_AV1_TOTAL_REFS_PER_FRAME; j++)
>  			av1_dec->frame_refs[i].order_hints[j] =3D frame->order_hints[j];


