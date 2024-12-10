Return-Path: <linux-kernel+bounces-439538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19A19EB0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8304C283F38
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2180C1A3A94;
	Tue, 10 Dec 2024 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcHQwKEH"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6071A3056
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833427; cv=none; b=iujk15Yt0NCqXVKvPkmlFI8OjYBF4aAlyOQKCe0iYIYIphqD0NdyG6q29NdVCGYehEQOiXZ3TuNJOdybYMJ1JDOJWfGPoeNdZdDYoCi5IZJZUHp30S3C/wH/WiwIYOTY5ZAQstu9X8nS0gSFAxSF/XJOkJbnqeA568CD+irjFrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833427; c=relaxed/simple;
	bh=lUtYIb9FWysANuBVRjGqvIA7tKeEyU84yMrXWdg5+fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZftZl6Jbfs1Z0CVAh0s1gUhkq1lJxhFrNnhtIWjUQS8AQjF6zNfodJYEXnGA6ppqmsUWNloNuVyNCF3cWGlkk2pmLMd419dTFmdz2SBmDRWen3SrLWgXaJIW4/1HyL0Hat/pdxlFxxats6Vz4OHUckEfoaNwcTvxajiKtbXZso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BcHQwKEH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa66c1345caso182317166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 04:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733833424; x=1734438224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kXv1q2+I00SEA4qivPj7ki5hHn17ZgKv03WB0L5X0HI=;
        b=BcHQwKEHVqSPK0XUnBzCrM8R2LizwxAzY+Qcz0h8Wqi+CmKHPK17OqqEcTSfsHUU3y
         SjZe/AwFEVW+knc3JwCubVg1J2R3Y/VitEOcIU0atswcZTWzABzXeXvfv+yNMTQ9QhYd
         0ofhE7+SDbXkAoR6WkLe+iKDBcUOYzSNBU8LMY05xpgSZ+b/e2JM4BA8U6J4iw7mekNG
         mTucQyG4yH3Qa/PpmkWqYAIujNOe+dfTh4zqyNZyhVetbIPhmFg8lZ7/U8xPWWr9O8+6
         pjbhFliDmZQi7hKjmpOlYkUI0zw/5rjmMh5QPzYGwlHehxHvZiZTsO5aMyHb4rO+CPls
         pNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733833424; x=1734438224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXv1q2+I00SEA4qivPj7ki5hHn17ZgKv03WB0L5X0HI=;
        b=wvqZuYnSWMXYAVz5h/f6S+57puxmHzUqaD7CdPPKVxEfkLhsZDpiTgJooN9q25zQef
         bxQX9JtSxjQFaOqYiUAqUQsE+gAcmtmjmTGy29J30m5RfTAqACs10AbjdDHAe7Frq8yW
         gPnJeZBnCQ9cfNUE5sDbHkOvBLckdWECKAcCNfwW6WhAg8M4rfhbzANA7GUWLCU8Xb6d
         0TexaGLqKVF8nC/uLjE9Mk174R6VwoF8PIV0ZVW7dcsAr3xitxN48Hug6xLGzqJXQfsx
         oLW0AWcvbKCF+J4YP/jm4COJqDb0R6cpwIrOEz+87fs2ETdHaj1OLmkMS1yPf1vpyzJF
         80Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUQnup/2OVh6Jt1MT+k4TTDgPiKAPJnGopbmWJf/kllaO2dDr55WZuRWSb/Ca8lFEp679NHXniwDwrJANU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQA/0jFJUeH2Zl+iPH0gdBUoFe8hqS2dFKdp5zp8m6Jju3y7GW
	ld5CCSi5P946KAL9aJFht13u/C7eU9vPNafOj1n0pi1sTehgWRWCOktsG1yZvfoM0QLcQdpad0l
	wSdtUT4laN0O0UIpsLIZ6gWtoUdYBUZqwq0YIGw==
X-Gm-Gg: ASbGncvfcA5fn6/tsdcUNFSf5Wh57WnPFnWPoHWWwZxeionHX6gDI3baWRHqm50tIM0
	RVFa+Id+mgGC/q0NrxxpKmO3KbQfgZK5MZEo=
X-Google-Smtp-Source: AGHT+IGPQzofPCSKwnJOzRNwnbqypQHGaVFPVRHAbVBETWyHajWU00pxqxU268Qgqllb0B6W2GZfn17ZSH3AScx5ITE=
X-Received: by 2002:a17:906:311b:b0:aa6:9217:fcd1 with SMTP id
 a640c23a62f3a-aa692180342mr561378166b.52.1733833423910; Tue, 10 Dec 2024
 04:23:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-qcom-video-iris-v7-0-05c6bdead47b@quicinc.com> <20241209-qcom-video-iris-v7-14-05c6bdead47b@quicinc.com>
In-Reply-To: <20241209-qcom-video-iris-v7-14-05c6bdead47b@quicinc.com>
From: Stefan Schmidt <stefan.schmidt@linaro.org>
Date: Tue, 10 Dec 2024 13:23:33 +0100
Message-ID: <CAEvtbuuObqiXMVeaxHu0LLsT3G4Nr-byMSR2drVQq+S8fN5uVQ@mail.gmail.com>
Subject: Re: [PATCH v7 14/28] media: iris: implement iris v4l2_ctrl_ops
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
	linux-kernel@vger.kernel.org, Vedang Nagar <quic_vnagar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Hello Dikshita,

On Mon, 9 Dec 2024 at 13:57, Dikshita Agarwal <quic_dikshita@quicinc.com> wrote:

> +static struct platform_inst_fw_cap inst_fw_cap_sm8550[] = {
> +       {
> +               .cap_id = PROFILE,
> +               .min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> +               .max = V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH,
> +               .step_or_mask = BIT(V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH) |

Would it make sense to have
V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH as the maximum as last
item here?
You have this sorting in the LEVEL list below and even here in the
profiles only CONSTRAINED_HIGH is out of order.
I realise this is technically not needed, but I had to go and look it
up in the v4l2 enum to check if CONSTRAINED_HIGH is really bigger than
HIGH and should be listed as .max.

> +                               BIT(V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_PROFILE_MAIN) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_PROFILE_HIGH),
> +               .value = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
> +               .hfi_id = HFI_PROP_PROFILE,
> +               .flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
> +       },
> +       {
> +               .cap_id = LEVEL,
> +               .min = V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
> +               .max = V4L2_MPEG_VIDEO_H264_LEVEL_6_2,
> +               .step_or_mask = BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_0) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1B) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_1) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_2) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_3) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_0) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_1) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_2) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_0) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_1) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_2) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_0) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_1) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_2) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_0) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_1) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_2) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_6_0) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_6_1) |
> +                               BIT(V4L2_MPEG_VIDEO_H264_LEVEL_6_2),
> +               .value = V4L2_MPEG_VIDEO_H264_LEVEL_6_1,
> +               .hfi_id = HFI_PROP_LEVEL,
> +               .flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
> +       },

regards
Stefan Schmidt

