Return-Path: <linux-kernel+bounces-283617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D0D94F6D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C061C2109C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CD718A6DA;
	Mon, 12 Aug 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ld2z0lQ6"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928FD189526
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488028; cv=none; b=qnIVognTLWpdK70Ry5tLlWfGbBVOUuYSuVdGswV1Yi7ArmpDzRwOMOl0s8Gbl/WTr0iWbur9t7hy3+yZM0TCPipcgGf/8AiN21cr0AZv8fxmm3LbrebvkjAUerXNgQlaSTt7hPqg/b6jC2D9S9e6MwfSiErEQlsecOHogPNQ0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488028; c=relaxed/simple;
	bh=yR2eCKJ/RHBhyH8Cf47wO0mAudZSl9NhHhiDZQiRmtE=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvD8Pk33TziwAtEEv4IxF6ghpajm/6VbTTzlkmQp6qzg2WdP3KIV+bETsnZ5YpQrEY9msfUc9gnXanJX8U8A97V/PN8kZ89YWSQw3/Ah6et+xEqgvikVnSGjliJFu7JfjgU+0rdz2xXiy4GBdADo4yDhxN5Ii3TNKBI0UWIraZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ld2z0lQ6; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1dcba8142so415877885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723488025; x=1724092825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ncx0KjsnMUSOlidEu3+KOW8xjiQtkAoEgGIPpLUP9Bg=;
        b=ld2z0lQ63qds7cIT2dBGqOFuUufyq/2SHFPaFCg5ZRShnLyFJva7YyCWXfnLxzlX8Q
         bmniBo/uTSQUmf1LnJJXEXOB2XKeOyAz/WlYf9nq1tqAS3NyKugO0DAsFCl5k08y/zUX
         NnTAnmCzpEeQflSCQTgBPTb/9+0vrlVbFbyYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723488025; x=1724092825;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ncx0KjsnMUSOlidEu3+KOW8xjiQtkAoEgGIPpLUP9Bg=;
        b=Yi65LRuXb0xKcU4s62q+KkHYWRYWggGiM9FGYw+LZHHmRbFTqmzEtbGsHq0MYfBMHr
         3nxh4Pzidm0pXxw7GQqHc6ScST7a+51UBrVYyloI9IYHlU1ZoSdNqKs73Cr3qHSEbdJp
         hGW1e4l0RdnVUM0cdA3W+hJST1NcUGNi0pxFiZ6TWmyYHJDBwntY5lCtmQhC+Bp/h0mR
         oDifiv71DRMipe4HB4NF80aSYhbm7jeYmp+7U1B7sblGxO/zU7NWbIT1uS6GrjtNfE63
         jMeKvIDhbhgx9rRQeoL3oNbY6MYxiUGIqdU62EE9aeJq6xw9jc1seoLQQFKC6Wx+dI5s
         r5Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV8vdALyG/BUkRlmA6YnIy9NNr5CEFLxf7hz6Nh/f9z2SUWRiw/qYv6VFF9YA/Xcvo5RBpLZf2F1C6S6OpRLrE+3H7r1wyTSkXyoRjA
X-Gm-Message-State: AOJu0Yy3fCKtm3x2Opz9GpwrER0BKQV8BktuJwGHqcnk3x+2tKk/QO8w
	XvVed7j2ymha7TMkdB1eVBwr2D0c6/YPP8r4GGh50w3L3jj+AwXEaZ7KZ7+GGPVHsmatyPwzx1P
	G0EGGnJwEfFYmiHh4MgWqev2w2bUS61bASsLb
X-Google-Smtp-Source: AGHT+IHU7T7mETTa8o0eIAERX5Q/cpE4El91Q1zKhqhAZWti96HazCD976i3q3JmtZLa+HkARhuwHJyq8saSXRwQcCA=
X-Received: by 2002:a05:620a:40d2:b0:79c:1178:dc9d with SMTP id
 af79cd13be357-7a4e38410c4mr94180385a.24.1723488025574; Mon, 12 Aug 2024
 11:40:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Aug 2024 11:40:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240808235227.2701479-1-quic_abhinavk@quicinc.com>
References: <20240808235227.2701479-1-quic_abhinavk@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 12 Aug 2024 11:40:25 -0700
Message-ID: <CAE-0n53qMJVbfb9oXbDexqhOj6qTBq9k5kMj1e6CXadObhBmLg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix the highest_bank_bit for sc7180
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, freedreno@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com, 
	dianders@chromium.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Abhinav Kumar (2024-08-08 16:52:27)
> sc7180 programs the ubwc settings as 0x1e as that would mean a
> highest bank bit of 14 which matches what the GPU sets as well.
>
> However, the highest_bank_bit field of the msm_mdss_data which is
> being used to program the SSPP's fetch configuration is programmed
> to a highest bank bit of 16 as 0x3 translates to 16 and not 14.
>
> Fix the highest bank bit field used for the SSPP to match the mdss
> and gpu settings.
>
> Fixes: 6f410b246209 ("drm/msm/mdss: populate missing data")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index d90b9471ba6f..faa88fd6eb4d 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -577,7 +577,7 @@ static const struct msm_mdss_data sc7180_data = {
>         .ubwc_enc_version = UBWC_2_0,
>         .ubwc_dec_version = UBWC_2_0,
>         .ubwc_static = 0x1e,
> -       .highest_bank_bit = 0x3,
> +       .highest_bank_bit = 0x1,

Usually when I see hex it's because there's a mask. This isn't a mask
though? Can it just be '1'?

