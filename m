Return-Path: <linux-kernel+bounces-227237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB24914DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8125B23F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFBC13D518;
	Mon, 24 Jun 2024 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtSvxBEE"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548352556F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233676; cv=none; b=QB42cXEw37NPQu4GJolqKs/f1bAam2hq68NtDQWq65HnBZ9IX8akRpPf4zgCfdzlFjz8yRjP9m38ceMqnidBTtKdLbrb8JdGgLbDkbEbKkGvw8Fo8FP832lB4ynhO67/lAfEsXHgvMqbbUNBAkb5QbsxmnsglguuPltoGkHSvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233676; c=relaxed/simple;
	bh=DOxpGDRPXOULudQMfRyURG+LRWh3ynkAOi8ERNjON/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUsDbTwRZaXaI+gNUIyl/abLDDRBg582d5a0juToRPt/63zgPrN0Hsm3KeoRY72GE28i//Ty5BP+0Sfjf3R9stpc7ajlRnII2E3MZkiSQ9kJM+uTKclAtqZtKLi7ELLzOdOIjDtJ6NqWrAlNgdmMzahb5ZMDQrsQo8QLRbntj58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DtSvxBEE; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfe1aa7cce2so4014832276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719233672; x=1719838472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T4MhoPIjswsMp7f7a8/ndhL9pANhZJFzHy+iV0sTzTk=;
        b=DtSvxBEEy6zDc7eqfmXzzgHKKeEFIglDj7rFFmslwBAG4coJwbFa3tTmqmHjZEMzgN
         3j0yo8GpMAAZ6rVGKRPyazs2FH6qTvUReAznA0gIiTzapS8XxIojuL4SLTlTmhTMHEZ7
         pESD+GwERCoS/86FQ5j6MuUsQHva//d85yDzZEGEfxeeFPQg3amVHgY4vMYqr28jLapQ
         cVz7mMzkj/cxdbmZScoiXn4Ke33r7tQwAAxEikgoA6A5FUS1Gcg3X8AwFy6h2dk3XRS6
         ZL/Sj94EEL8GLqriVthUuvUjt1nU2PaWCokok3W9MIn8d02E/VX/LgRsbLjzF3gR2nAn
         XHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719233672; x=1719838472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4MhoPIjswsMp7f7a8/ndhL9pANhZJFzHy+iV0sTzTk=;
        b=jpJwNK8ymx7VU23xi4FVaqlyKnDKKDhtP9ahtJyc5yfVxqqfNqd6xHTiT6ZWnUhOb2
         DPOBZA922947aiF3LZytpY1g8vRs61rGP00pIX69FAJxGQkjkVjnEzOuW+VIia03TPNw
         2+ZfJNqRAIKRY4+Dxhkd/FdI4ATcwHzpP3Vzptdaw2maBLWGJBxErcN645zidLev82sH
         kZAfzLRRmRMPKV0LxXCX9SEARrIPexQLHoCR92k6q0b0hMAeA4MgCf05IEMBIuQHchGj
         bYWTsFbW6YB4KK1F4SYQsufvmE+JyOmdI8SOl6vvham44X/eiaq8mKOSwuImjARWh8mt
         VouQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRxwkiAQAgKxT3DhoXP+64NiDbD3rPesmuJueJtg/k2ResOy9pdpuEjt9wEPZbW8fzaTaBdmwXZrsCejjZixm5xX3AR1/KR6LCmZJU
X-Gm-Message-State: AOJu0YwiHP/WyAWeltoaDdGOAID9BFgnn5AebRDrtn3ZKV11Z6jJ7mps
	s+zZoeXWvabzldQnSjrgvsQ6OaD3XHq/0CgY75F0S5GLtOxjxE2PbaeyADL+TZ1lUhm358hrhFm
	cUfKTb+Ulnbe6DwyYkpCWEbYTbx+1c0pLf0+Nvw==
X-Google-Smtp-Source: AGHT+IEEe2Wox3jWC9RV0LVT1QsuSsNWmLHgdKtfDBvlgM6eb1pktgBqHVRKocFL/tWEa8Hwpz7Px1YRrvmHbynoaFc=
X-Received: by 2002:a5b:bce:0:b0:df4:476e:7577 with SMTP id
 3f1490d57ef6-e03040182b2mr3570101276.60.1719233672328; Mon, 24 Jun 2024
 05:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619-lpass-wsa-vi-v2-0-7aff3f97a490@linaro.org>
 <20240619-lpass-wsa-vi-v2-2-7aff3f97a490@linaro.org> <hz5eqta4ttzsnwttqzqrec4vcwvyleoow7thoiym3g3wjsfqk4@tx23nktde3gh>
 <fe75671f-c292-44b7-9024-15e0825c55c2@linaro.org>
In-Reply-To: <fe75671f-c292-44b7-9024-15e0825c55c2@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 24 Jun 2024 15:54:20 +0300
Message-ID: <CAA8EJpoLE5zUEvC4-q8h5KH=c_ucew=py5TV2qCTaSEQNQeQzQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: codecs:lpass-wsa-macro: Fix logic of
 enabling vi channels
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Manikantan R <quic_manrav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 15:35, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 20/06/2024 21:28, Dmitry Baryshkov wrote:
> > On Wed, Jun 19, 2024 at 02:42:01PM GMT, Srinivas Kandagatla wrote:
> >> Existing code only configures one of WSA_MACRO_TX0 or WSA_MACRO_TX1
> >> paths eventhough we enable both of them. Fix this bug by adding proper
> >> checks and rearranging some of the common code to able to allow setting
> >> both TX0 and TX1 paths
> >
> > Same question. What is the observed issue? Corrupted audio? Cracking?
> > Under/overruns?
>
> two Issues with existing code which are addressed by these two patches.
>
> -> only one channels gets enabled on VI feedback path instead of 2
> channels. resulting in 1 channel recording instead of 2.
> -> rate is not set correctly for the VI record path.

Thanks. This should be a part of the commit message.

>
>
> --srini
>
>
> >
> >>
> >> Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
> >> Co-developed-by: Manikantan R <quic_manrav@quicinc.com>
> >> Signed-off-by: Manikantan R <quic_manrav@quicinc.com>
> >> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> ---
> >>   sound/soc/codecs/lpass-wsa-macro.c | 112 ++++++++++++++++++++++---------------
> >>   1 file changed, 68 insertions(+), 44 deletions(-)
> >>
> >



-- 
With best wishes
Dmitry

