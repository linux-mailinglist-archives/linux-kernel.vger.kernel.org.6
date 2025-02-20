Return-Path: <linux-kernel+bounces-524316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3844A3E1BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4C019C1CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21F81FFC6C;
	Thu, 20 Feb 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrAJSbQs"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F826212D68
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070739; cv=none; b=SLpmlkmP1qmIqoSM5TVm/VYQ+ql7dQpRhPgufHJcFsQy7tSWURLZUQdL2ttbiDuLGHRnVE/4a1l83tQ3jSXUko6W4B0cUNq3wNcLMD9CDMzxRbBiPMTfe3fKpXviTLG4F0XRt20Fz78/HRLNO2Q49TY1S/+Jpo0ZwFY2cyIHyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070739; c=relaxed/simple;
	bh=IaMyx4zJbOc7SlK0SsUvl5E9g4q84clVwL3Qp+Re03k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyFwxtJ3nPKB3XtcxLu5LycklBr5L1MDGBxhd+rOfnKPFTYDnPtKgx7yU9hRf847LfQ3z9Gc33kAWYl9MpmM2EM34HVHBGKInQwUVUUAifmp7/j96wJXRkMLqEErO6hQkln9nNqhjOuquOZELSPO/zYgImayZPNzQbPDifLqmKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DrAJSbQs; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ef9b8b4f13so10157747b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740070736; x=1740675536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AQGm09mvBdK2cXSMuQL4mPfZFTNbgPhxPgRHKoe39gQ=;
        b=DrAJSbQsNTEoPjrC7xyEDUT77+IZKnF6iEXQexDsVkaRiwzQdle+aNFLblGEUpsKv7
         hZyPov+6q5P3TBe+Q7U6RiqmLnBDGM4zhj8KfROlVq4kYWwij8OYy14vYWfH2kCSVX/8
         uoKnoIve7pQ2zNzgt1v5eJw6cInR7azxbwh0dC6WZwNc7F5R/c6Gc4D0fNMKl/4CmUTz
         p5L/2xajkaSxVplrWLlx4aFzD9d1Po1Jj+eF/9mCKTa78mmqdp6Arersr/pBMe6pagmV
         1WU0KFhhvIpeXW2ZOco1EvnMoJQAOvYtTLniwyQ8P83GQ+EVJRL5xNsxK8pAYPRqvSYT
         xkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070736; x=1740675536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQGm09mvBdK2cXSMuQL4mPfZFTNbgPhxPgRHKoe39gQ=;
        b=rpFHweFXJJtVpKsJDuzqN3ybXL6L9mc0Wz0ODcAZXpTqUu2PwTUehlnWL/78+Pctmf
         6/jLTY8A2Ct6xXYia8315+JlPPZgHX069IKOcWADCSITLZJzk4Z3PCIASBgCiA+uJSeR
         e6b56q53vXce6pw/AsFQtlisvIlTXcbqEe2Fgzy7jhZpi0yr3tYIn0qK0lXstxmubWWL
         5a2V0Q1vKL6HdJiMOQcQEcNUJD+gZPEaVALbGOxzNGUDSuMngo3UvCuQ0iQIh6wdA1px
         9z5SDB1PaPjRagVU2TOjRdBq/I5789KjkwjOhL7k88FlFVCgQEW8sixWWKCq7vl4eEMo
         gxQA==
X-Forwarded-Encrypted: i=1; AJvYcCUEODpCyT1zr703/6grVJr4StPUH3ydItTZc/qCxeFMxmZ09nFk27jUpIm75rkJ2X954G385LLRfRzZ/Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYthS6jUN3ix2Fx5Atx0sqQ15kv2xegRzdYrkrASdxIWZiQ3x
	TrKOU0USJf5hzKbtdd0RyWm5OsW1zPGgqtmUmePYaSklzy2TCzimluD3Gqco81qxI0cdCJuOgvl
	YT662rj8LgbZZ+iVdbO2rpD5VRyxFdjaePkptqkNCYLbUq146
X-Gm-Gg: ASbGncstNRP0rou6GM/ktz6xAFttK4otBZgC1+ckLNHCyTRRUwlOKUkRq2hWfD4pJol
	f+gQMpinKNj3NqMm8eFhKTjjWPvzSqSBg0ikU5esYr9lSIQPgOH5dzAZkCWUQDr+a+gFzC7aZUo
	odK0yRg2v5ujw=
X-Google-Smtp-Source: AGHT+IHo/TSwDj9rjaJmDI7ueG/cX0IHmiSNBjN/IaIJE2k5Ejy7bMVotuAKIkDs0CnNfxvReAEeAqe1/IzMKeJl4mM=
X-Received: by 2002:a05:690c:2789:b0:6f7:534b:560a with SMTP id
 00721157ae682-6fba561941fmr76173317b3.8.1740070736530; Thu, 20 Feb 2025
 08:58:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220162847.11994-1-srinivas.kandagatla@linaro.org> <20250220162847.11994-4-srinivas.kandagatla@linaro.org>
In-Reply-To: <20250220162847.11994-4-srinivas.kandagatla@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 18:58:45 +0200
X-Gm-Features: AWEUYZmFJxng0_893ETLEGldfZpNnTmG1J41zgQwIxN-aVy1Spd_reUcQ6cKDbU
Message-ID: <CAA8EJppOSTFfszx26GzwQb36GNTU6WEpWmSX+j5ds17wc55nig@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ASoC: q6apm-dai: make use of q6apm_get_hw_pointer
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	johan+linaro@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 18:29, <srinivas.kandagatla@linaro.org> wrote:
>
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> With the existing code, the buffer position is only reset in pointer
> callback, which leaves the possiblity of it going over the size of
> buffer size and reporting incorrect position to userspace.
>
> Without this patch, its possible to see errors like:
> snd-x1e80100 sound: invalid position: pcmC0D0p:0, pos = 12288, buffer size = 12288, period size = 1536
> snd-x1e80100 sound: invalid position: pcmC0D0p:0, pos = 12288, buffer size = 12288, period size = 1536
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Fixes: ?

> ---
>  sound/soc/qcom/qdsp6/q6apm-dai.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)


-- 
With best wishes
Dmitry

