Return-Path: <linux-kernel+bounces-439925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0479EB633
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C425188165B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83A31BEF74;
	Tue, 10 Dec 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ta+vKn2r"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702219D06E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847851; cv=none; b=JGlYX1LQ6Bopfbp3oXBYlGiLVRd61pRz19S1EUScdTRox7Ue1TMjs/6+gVpKUp/w7Sj/vaXJVxkpjEZrgQhTSEvoqLBvMK+ZoUotFZUck5FelV3GnPdb902X6F7XAsz/Fitua0LJ4eAiDEip0J7iLjxFHhpH9USTrGoewOFgnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847851; c=relaxed/simple;
	bh=lqZ6jfWQv518JCCW7cIDrKpuYmAnQVHmRlFDMQF5Ifg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1r/NM9ye2JZ7jh4QSZwb+IpjzkG00dr2zG9gnwztJmR7WCVnyxat+LWdGBoP+2MySSFFo11QW/XuUaYDHpAE1V2Xl4qLPhBUYjjksuU0briF36Elwb4O8bIDtIBy1kBVlJ4hN1QSFjwkIhXBtSxSPIxjPdzBmGdFFVcyZO+y38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ta+vKn2r; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso1096731466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733847847; x=1734452647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l1Zl6mnBjiQBNeF1Q3VMTAkh1KaygVJextd08NrJPLQ=;
        b=Ta+vKn2r6vus4DWqB4e7Mp2tp0yqU5NWY5BVE9UuqdXHqRjo193jP7ZZVYRL3wYqQa
         KACoAFyF6kE3oERfdu8r3Re3yb2CzH1IjWeLAuYzay7bypjBE6Ax4hV7nI5hCOkK0cn2
         TAdzpdqZtQwflhVCn4WlDPXNgzOstm8lYyEjb/S+4DHUFOQqWb0Uc9Ial65LSsUhHbfp
         +x2gkiNGziimVWfjhqnt3WVxGSwBOyyj/i0UmEGUhT0LC/a9jnD6Xr3pb3DC1DUf7xAW
         i0sy2kNugbSn7ufck5Ei4FpZjB7kgN91MN1fAtvviXVe/5pq3WWF0WbIZJSTqJ5SxDkA
         TjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847847; x=1734452647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1Zl6mnBjiQBNeF1Q3VMTAkh1KaygVJextd08NrJPLQ=;
        b=PUkzBDsY9pFynRCx6EO419QsioaeL8JaoiMh85XQS3X5GFdEg/MBlsBdtNCIwPptzl
         tvJUnkriBM36prihLhN91MfUEgoP9vHZi4tdy/t3Uk/vPUeccxI+mOhbVHsOFFfy+X4j
         xr0KG/0/RbfXbs5oJ7nxyIgCaw2jl+0TVr/hqqbzAkBWhKSpo/3uROQEi57CGjhKMY5F
         SnUTvHzWCYY8pCEpTwH9Uo8gnvVOG5X+VMVea2ssYwlESWeyZ6u3HReXUGm0L1hJAle8
         CACiPtuIZain+t5Wi8omrbadd9hkyVFZGuzRQiGC6HRqPO8b+NNoEf3KsNJdVwcYLJbi
         hujg==
X-Forwarded-Encrypted: i=1; AJvYcCWHZK7Et09NsMD5vUD7WkTENquXccCrfxooDkvuXNZ5vZo9b/ilyFEKTwi/JEap7tQCAwR5prs31q4kupA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0mPF1HMuewAALtfz7+YwFTIFWnymUOR23xlrzKjW8JHSeiQ5
	vSNSeQvix4cyPjARqqukBOyJ/gY2ofPdf3r6uraFoN/LzJfcyjA1OpWyvqjmr+0cbH5kM17ZS4b
	huqFokX5p86fhAsT5aHxkxjXvbjLDOjd2DB7y9g==
X-Gm-Gg: ASbGncuQpXHA1awpnqkjORnlP7k2XPQtL+PJF02QKDr+XEGpLlmmE5yzAyWQXSNthL4
	uOhwsa7vMiBhaSftmfBY3iga1Suuq8JYNlFg=
X-Google-Smtp-Source: AGHT+IEDe+ZlasDaSk7kkMNC2p4PajKO8n+r9pHmoj0mnmgFy9RuiKu/RGzpGKCUoMbkgvfshlUA8vwl2fXnyVlspYY=
X-Received: by 2002:a17:907:6ea0:b0:aa6:7285:469b with SMTP id
 a640c23a62f3a-aa69cd5c6cdmr593652366b.18.1733847847098; Tue, 10 Dec 2024
 08:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-qcom-video-iris-v8-0-42c5403cb1a3@quicinc.com> <20241210-qcom-video-iris-v8-27-42c5403cb1a3@quicinc.com>
In-Reply-To: <20241210-qcom-video-iris-v8-27-42c5403cb1a3@quicinc.com>
From: Stefan Schmidt <stefan.schmidt@linaro.org>
Date: Tue, 10 Dec 2024 17:23:56 +0100
Message-ID: <CAEvtbuuO5Ga+wW9rstX_e_RGnm5jSNSHmyy3w3M9FTopNhKttQ@mail.gmail.com>
Subject: Re: [PATCH v8 27/28] media: iris: enable video driver probe of SM8250 SoC
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Nicolas Dufresne <nicolas@ndufresne.ca>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jianhua Lu <lujianhua000@gmail.com>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hello Dikshita,

On Tue, 10 Dec 2024 at 12:08, Dikshita Agarwal
<quic_dikshita@quicinc.com> wrote:
>
> Initialize the platform data and enable video driver probe of SM8250
> SoC. Add a kernel param to select between venus and iris drivers for
> platforms supported by both drivers, for ex: SM8250.
>
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

[...]

> --- a/drivers/media/platform/qcom/iris/iris_ctrls.c
> +++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
> @@ -17,6 +17,8 @@ static inline bool iris_valid_cap_id(enum platform_inst_fw_cap_type cap_id)
>  static enum platform_inst_fw_cap_type iris_get_cap_id(u32 id)
>  {
>         switch (id) {
> +       case V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER:
> +               return DEBLOCK;
>         case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
>                 return PROFILE;
>         case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
> @@ -32,6 +34,8 @@ static u32 iris_get_v4l2_id(enum platform_inst_fw_cap_type cap_id)
>                 return 0;
>
>         switch (cap_id) {
> +       case DEBLOCK:
> +               return V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER;
>         case PROFILE:

The handling for DEBLOCK does not seem to be part of the SM8250
enablement. Or did I miss something?
It seems they should be part of a different patch that makes use of
the DEBLOCK cap.

regards
Stefan Schmidt

