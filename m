Return-Path: <linux-kernel+bounces-256415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C30934E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A35284B94
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB7413D8A2;
	Thu, 18 Jul 2024 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPSi0ob9"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6713D63E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309087; cv=none; b=mlbnx0+DBvuKfgVdc+sBp78xUNfTe2zlT+Nwz7oKOuz/Af8k/c/GIFM1mChAiH3u+gQe4p8kMtp90w9Rt+YlPacaBAwNY629K7f2oAlvPahDApJeT57Y+/C1loTQ4qmr3iGRyQViZPE/OOqLviAcO4jiWRud7/oHYLPJVTeQNTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309087; c=relaxed/simple;
	bh=swCmPD17diG2jnavDnksc2NuxVuLrrARkP/gdP3rn44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wm4mEQHZb3fFOq2nWGy/cAbONLb9NLCy+iTFwqUlhy6WHf5BNx2ZRT0OxZZybH3KKvOivQgspNUBTNU00wblB22VUqywfPJx8bR9UJDsDWiUswaSttLuqG3Vyq+yINtTRvpQAI7WMIXdc+HC3Am+I7+OG4+ADgJNmhdL1B+Pwm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WPSi0ob9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70af22a9c19so562926b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721309085; x=1721913885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fq6buaq0J77LyE/GBWk8ILfSOIynHPKL2rGxd48KAGw=;
        b=WPSi0ob9on8NvBjFXo1MBKbtxVOM43W3IYo5j5Tabu7GMWi7gJ+IlhTPLOCb/S8Xox
         2muhXT/zI+wu8BvjiWmSyhrTCaJWeahwp4oQzr4hQGoZ53a0ME9kJNzaNcHXznUSF39k
         HHQez9HbaiOsKlpzXx0ycdO/0fcIds55tdUlFPEj/3hFlAlRFNqOVpSRyO3yYV9NO1kk
         ktqPBFwvSPEl6qHvsVrTZObk2stf9NBZy9kKFE1UseVa793nZhLwLKdtuqn1pv4JFgfb
         TdbNoUF2L3/sjF8H/VAHg0qq+KpBzhp6AkjdplJWFbjthqNp9x+jrT5oDqSzWfPqe1O+
         D4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309085; x=1721913885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fq6buaq0J77LyE/GBWk8ILfSOIynHPKL2rGxd48KAGw=;
        b=JsBTjjh7sPIRLcDPpA96Y/+jIYoFr/mNkbX2wluCknCo4WeXo3FDHLkOzuUQLml7xH
         qFZaNzAkwz7zhZPHATPvQYivcLTVi4oBRIm5cK0RpWnV/4HTrYeMplTgCMSZKhInEKE4
         evn9RQdXtCWyYekhz6X7rlvO2pIg+i7DIN0LPxLQjltx1/jL0aDX5TvsQY0I9qsFfeLk
         jRkADebYfi+Z9wYGDzNCEJZATAJGX8AR+eNhs+ePt7kbhlBcxDzZ/o1y4tJx1IH52Fok
         HEkVYYsJ/0PJEebsnH+1M79RBiGmTYI/5m62ILeWR01e27zMJBl+hZkZkK86DCqPu3Yn
         952A==
X-Forwarded-Encrypted: i=1; AJvYcCXVEIFiRhTP8pn67g8VwTW4VuMjYtEH3nLLFlvKCqik09TBEFi3aSE6c+JpYMM4L4G0bjJmb5cRNSzL9dFeu4CshMgijk/8knT0P3RM
X-Gm-Message-State: AOJu0YyxnbIokP/VjmCD6WBRBps4nV68/7hfR/ClC0Xl6LYq7jf6tZlC
	NhelP1alpEFHP3dUSjSGai2t3lA+QJ7s/KXUL3V8fThGDlmde/UbRTsudQo5lNljtdpgwhQZVM3
	8xEdD+YZO6OMhSkrt6yszr43iwKyYc0/7WJC0Ug==
X-Google-Smtp-Source: AGHT+IH9mIMsGzBmrv3QWb32eFUfrlMcHd5f8eA96tyiDq6Dw/aKdX2ecIK8CZzn1z6FPeTtkwF7rM24BmD+rSYOAdo=
X-Received: by 2002:a05:6a00:4b15:b0:706:8066:5cdf with SMTP id
 d2e1a72fcca58-70ce5066a47mr5635179b3a.21.1721309085199; Thu, 18 Jul 2024
 06:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-6-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-6-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 18 Jul 2024 14:24:34 +0100
Message-ID: <CAJ9a7Vh9GwbFZQDH=FedjnvdVPrOQnftCpu2CBh4EFT=kbg_2Q@mail.gmail.com>
Subject: Re: [PATCH v5 05/17] perf: cs-etm: Only save valid trace IDs into files
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com, 
	gankulkarni@os.amperecomputing.com, leo.yan@linux.dev, 
	anshuman.khandual@arm.com, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> This isn't a bug because Perf always masks with
> CORESIGHT_TRACE_ID_VAL_MASK before using these values, but to avoid it
> looking like it could be, make an effort to not save bad values.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index b0118546cd4d..14b8afabce3a 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -643,7 +643,8 @@ static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu)
>
>  static __u64 cs_etm_get_legacy_trace_id(struct perf_cpu cpu)
>  {
> -       return CORESIGHT_LEGACY_CPU_TRACE_ID(cpu.cpu);
> +       /* Wrap at 48 so that invalid trace IDs aren't saved into files. */
> +       return CORESIGHT_LEGACY_CPU_TRACE_ID(cpu.cpu % 48);
>  }
>
>  static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr, struct perf_cpu cpu)
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

