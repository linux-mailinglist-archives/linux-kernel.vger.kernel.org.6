Return-Path: <linux-kernel+bounces-213216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E76E3907180
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700ED1F26731
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D101E49B;
	Thu, 13 Jun 2024 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJ/rhK5L"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB004143C46
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282246; cv=none; b=FO7CRXXq3WJwmonQZ3yP8aEBJSzVrsaQ+YopCo2SBubpI5AfB9fvSAWm+3XbMNfYwrSZzABVAft0xoXV0XV3gIBL9gEC+yVt1QROoph2FFbmGM/C8bq8dnVDKmSBmmj7Uo5K6a7EbdCjtlbjDSch640Fsy4HsXJLnEjGlT9lo/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282246; c=relaxed/simple;
	bh=HO+x80vOL45DfnbGDH+HE4l2kGlmP8xcQBK47SIOSDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHAJGHj6xkulN0b3GE1zr+Qs8X+n+AzHK7YSgcI077VaxH/kC6fgLya24joDLY4Pl5G5VQHpR8GicPc9U3fTCjaL9ExfXToN6fK4OHrEf1/KqRJmxo9BT5RoiffVR+udZiYLRhDzsg6yQJFzyT2Ucee0IgiXu9lJX7SnnaMun1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yJ/rhK5L; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6316253dc52so4046897b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718282244; x=1718887044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lK324ZHK2UbYkaord9YynZkPLQSYfxb5dYuVjUssGuM=;
        b=yJ/rhK5Lg+rkWw8pq9YggxvBlPh8A/DOkCsY3uA/ktzMZgZYq+Yr/0NWUahCQMP55y
         A41T+7/FLd5ADX08KV5D2c+XpBCfcH2zIojMMrU1rfH1EuPJBej6dvln/02u84kpGc4Y
         RSJ8AGk5gJFAdRWE7vWEkN49G0p9CUUaAha0v5UlWEF02DAJtg3ETnq3Nz4o22RH4fou
         AiXMaIEnKrl3zgNsdYIjul6ybY5XEC+8VKCPApSvCtwaLJR0Bz6y/ftradFMQO4fQ9C2
         6f71NU6+8wmxDTe38KKrKwEGtfNHOCSAgdbnd2jzn5RlUOhv3R5MEkOiNbTqXbTVjlI3
         41Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718282244; x=1718887044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lK324ZHK2UbYkaord9YynZkPLQSYfxb5dYuVjUssGuM=;
        b=vvqmb7muqCetIlqDq7opBR4kaerVBOVNmYNxA8lFr+Th7MjYY56QBKpw1m5M+f07Jf
         AbqyLbQkVnc5VgxFLRBs6FUuNcZQYG7/HGDtk8V+MLCvL5Qax2mTc4QGTFEFHv50YzZv
         /iNtaM8yUgD1vv0l08YWEzA/suXQVpsjMp+0nFRhX3e9t4jIGBaB4uUGumi/erQ4t03V
         MdcMEF9F+AWcWIgHLzaHMYw5eTkltpY5OVLlm90KKoYbJuk8CU4g/OBl1hI4CXvGb0OZ
         pC75i8WPFSlIkH9AORkD1dSqy6zWkbE0OCqDsFhoFIRG9RoUleJ5vIJJPIZ3iv6I0SRF
         ufkA==
X-Forwarded-Encrypted: i=1; AJvYcCWcbFbNNvF9UyLPJiSX5KCV9IbukXFAwmZ/pSa6UltwXvVazkkVpIXpLAGTWGuoaabW7ZCqCKdvCrNy5+mwZaaGLxnRzJlXVitmZf6S
X-Gm-Message-State: AOJu0YwhP30I4aovY7m2jAgyNSHuhxU9Tj8ag7/kLNRwewfx9DrXIapU
	Vz3PS65wvYm/REXmtlG7WFkR7BlmcxnHmMPPBLvMJkHaeGMFfD1D4whFHEKWBLvZTgwnuF3+VO3
	qS7cC71+RU8Fljox7e33PRHI5duByNp7cp5dqd3tC8tbs70lp5+8KGQ==
X-Google-Smtp-Source: AGHT+IHZvUBnLsMhW62XBAnxIb34bbF6VpwyWCJv6bXVbMOYQVTTwWrwK1vnVsv5FrvtFe2dwrIEhVqsavWTdlA/pfI=
X-Received: by 2002:a81:8a42:0:b0:62f:9e2d:3e5d with SMTP id
 00721157ae682-62fbdba5388mr40959977b3.43.1718282243851; Thu, 13 Jun 2024
 05:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-q6apm-fixes-v1-1-d88953675ab3@linaro.org>
In-Reply-To: <20240613-q6apm-fixes-v1-1-d88953675ab3@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 13 Jun 2024 15:37:11 +0300
Message-ID: <CAA8EJpq7SN5J8Ye8nGfbJdKAC5Ws61iKMu6QO9ebnRV6q3EVNQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: q6apm-lpass-dai: close graph on prepare errors
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 15:13, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> There is an issue around with error handling and graph management with
> the exising code, none of the error paths close the graph, which result in
> leaving the loaded graph in dsp, however the driver thinks otherwise.
>
> This can have a nasty side effect specially when we try to load the same
> graph to dsp, dsp returns error which leaves the board with no sound and
> requires restart.
>
> Fix this by properly closing the graph when we hit errors between
> open and close.
>
> Fixes: 30ad723b93ad ("ASoC: qdsp6: audioreach: add q6apm lpass dai support")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # X13s

> ---
>  sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)

[...]

> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0

Note: this didn't go to linux-arm-msm, probably because of the use of
an outdated tree for submission. This commit is v6.10-rc1, it probably
should have been Mark's tree instead or linux-next.

> change-id: 20240613-q6apm-fixes-6a9c84852713
>
> Best regards,
> --
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>


-- 
With best wishes
Dmitry

