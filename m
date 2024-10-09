Return-Path: <linux-kernel+bounces-356884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E90D996828
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BA81F2373A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345AF18D650;
	Wed,  9 Oct 2024 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mGjffzzI"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656F1917DB
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472480; cv=none; b=baOExgFY7HqUqRTNB7W0Y51uWBHIq9bnZm7+3afMXaN72WRCZksNGnGH1CBEtDkTbHOHQNKr0RZ1c8T90XUyfOYPRCfdQ4dbJQx2rBdcrdh81+Sw1p4ow/LYQKEbhSzEusCoGrKQ4RBpyc3a0VHJNvpspFgSekWd7AVvzTlArsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472480; c=relaxed/simple;
	bh=7c54uW3lN5rc1TC5au4z8TqSBDgGhRE5e0/oetoH02Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqGHd+ny2Vjp0Lf++DqSGtpT2pTNh/qnp4UjztcSRHT9kl+8bBEA+epkgaFgdonwYQOjUdcqUq7JWXHc4xCBteBj/R5rD8Z5bxnxVDbF8POrYqUyzTLbnnQsZskpwu7DYhfei+9j48l/9V2bf/89IJx0S5xQW+Ki16gcv/YW+EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mGjffzzI; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e28fc40fdccso873260276.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 04:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728472478; x=1729077278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fFC+bB9pGan8WcQNSrPQe6GRFwl+FEQ9GC351PPtFXE=;
        b=mGjffzzIqYr+ZH8poDEJpDtGIb/hnhQrWzEdwG3Js+0IgiZ8r+RkkEvnjeRjB+r4c/
         CJTx42blS/TUkPbtJQhBmfcv/k7W69m7mu2jj/+Za9YAqzqfATn/PU+UPSvcCR5JplB3
         6MRu3s4SdpWZ81zDJ3mZgdzhpR3Q/FTXfOMKbXCN1sBNWfD7qLBjk54IYHJEENV2KPoX
         J7Mgd4TwBWUiFGYOjcUjYwBSy6q+uVigUjOpDuOEGNrnOZRNfn/7fCGtyqtQFIPLgwnR
         QE+/e4Hr83pQIu8W0CFBSgnUNRfZ7IEiLSU1EHLSaWPLcnDneQr74dqngpDO/peT270W
         fE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728472478; x=1729077278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFC+bB9pGan8WcQNSrPQe6GRFwl+FEQ9GC351PPtFXE=;
        b=PD6gidLHNhMc11A7dstCpdik76PR567+h+8iT8Fjt2TyokvQVJn16zhAfsaUpvQ4M8
         GWY0qoWViryxDMlgCkR6Y08ZghtnDI5F06Wvh3mKdEWB03HcdvSgIR1F2OT72ouAMu21
         0taP4m2mwwI5iTTWvmH+2MXPcpFS+7ntoyXLj+CFc26d62e9C8td2TeEgcInrIf6EMib
         +u783F6K/Rbo11rrqii/KHzwbyY7ixH/g+8D4dmP9AXibOb0Xm6jeFnddP39dVz2qF0V
         fqnP2UDVL/y/jSqHMGoawU5jLqp01EIWEmjHvpDYUC15Hjmqqkj8S2/xGi5uCa3GQYee
         utfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo1Y1gKisqecxPulffwUpWWBs1VfCaxiiS+gYmiyxxt/tgXddWs5CA97whKGUyYQ4nItxV60T2u7nw7xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIbuerqXYb7x/VJfnZzyF1AAWBKdEaxhHV63xJFCoi5KNTsKrv
	5fBeU0sq9D0PcRO/TIAqPsKE2pvEewTi1QMPHWz/F9PRbMS6u0TJXopg4ogvr54sqJPVW5YtRxT
	oleEGkfhNbCKItPbemNoO1KZDxEGTe2cuqgYvdg==
X-Google-Smtp-Source: AGHT+IGoX0qo0TwHIFzuDhJ8uRvT8liLFL0dVJP7Xz1NBAOVSmENTvV/zOkcv3Wjec8D5Sxd9qEo1roy0l5OEKEWDTI=
X-Received: by 2002:a05:6902:10cd:b0:e28:f0e5:3805 with SMTP id
 3f1490d57ef6-e28fe36482amr1767867276.18.1728472478141; Wed, 09 Oct 2024
 04:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
In-Reply-To: <20241007060642.1978049-1-quic_sibis@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 13:14:02 +0200
Message-ID: <CAPDyKFqnvEy5D6xXTbnYsRKRfXTJ4o+3V1QpVDh1SyqJambd4g@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] firmware: arm_scmi: Misc Fixes
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, jassisinghbrar@gmail.com, 
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	johan@kernel.org, konradybcio@kernel.org, linux-pm@vger.kernel.org, 
	tstrudel@google.com, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 08:07, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> The series addresses the kernel warnings reported by Johan at [1] and are
> are required to X1E cpufreq device tree changes [2] to land.
>
> [1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> [2] - https://lore.kernel.org/lkml/20240612124056.39230-1-quic_sibis@quicinc.com/
>
> The following warnings remain unadressed:
> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
>
> Duplicate levels:
> arm-scmi arm-scmi.0.auto: Level 2976000 Power 218062 Latency 30us Ifreq 2976000 Index 10
> arm-scmi arm-scmi.0.auto: Level 3206400 Power 264356 Latency 30us Ifreq 3206400 Index 11
> arm-scmi arm-scmi.0.auto: Level 3417600 Power 314966 Latency 30us Ifreq 3417600 Index 12
> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> arm-scmi arm-scmi.0.auto: Level 4012800 Power 528848 Latency 30us Ifreq 4012800 Index 15
>
> ^^ exist because SCP reports duplicate values for the highest sustainable
> freq for perf domains 1 and 2. These are the only freqs that appear as
> duplicates and will be fixed with a firmware update. FWIW the warnings
> that we are addressing in this series will also get fixed by a firmware
> update but they still have to land for devices already out in the wild.
>
> V2:
> * Include the fix for do_xfer timeout
> * Include the fix debugfs node creation failure
> * Include Cristian's fix for skipping opp duplication
>
> V1:
> * add missing MSG_SUPPORTS_FASTCHANNEL definition.
>
> Base branch: next-20241004
>
> Cristian Marussi (1):
>   firmware: arm_scmi: Skip adding bad duplicates
>
> Sibi Sankar (3):
>   firmware: arm_scmi: Ensure that the message-id supports fastchannel
>   pmdomain: core: Fix debugfs node creation failure
>   mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag
>

Is there a preferred way to merge this?

I can certainly pick the pmdomain patch, as it looks independent for
the other. Or let me know if you prefer that I take them all?

Kind regards
Uffe

