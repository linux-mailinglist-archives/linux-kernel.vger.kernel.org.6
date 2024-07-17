Return-Path: <linux-kernel+bounces-255323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC49933F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9240F1C20F37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D5D181CEA;
	Wed, 17 Jul 2024 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qny24Z8j"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE27181BA8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228610; cv=none; b=WHMrOdMCl8nedY95ewAINvJfrk/MMw9QVHY0IFGFaccKXDHKt5GVFg9YWJDy7g69r3Q50+X85jqn/8VvWHNEztimEQg4xBx5vJHxshoq9NRPOnZb7dLn6sJbGrbZq2aWZ5zogm7J/HhbcnA15VXzXLplgEfPHb6Tq9eVdshLAjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228610; c=relaxed/simple;
	bh=OK6g/lWDwmchpxyqOEbgh8WwxmJvtIX/PBh8+/17zck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ip4xlNhhEOsdqVijgX9CLTLQiK1ig4mo7ViMDAzK2s/NFO8qY4Ag+dfRosialA5eqtVdIPfn3F5KX1eFq9KCXRRRxugINn3HbPidkU65GbizLUlJ0sfeNs9zWglPvIqTqGlNy/a0tKHHKMMpuUm5NqvWhccqzRo8KBjCh8IXNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qny24Z8j; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ca489b4146so4547988a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721228608; x=1721833408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=10gdFFvJv1+iPvT+xYjVbe0xzgeYMSRIMgDwYMfIOcs=;
        b=qny24Z8j5/Dh74oy7cVISXg4CnUXAkKVmSFad4VNhAz5AylO3fz72QDoogbePItucH
         6oLZmt3TBJw8ir921p99+SR1TxdDXlWcPcBEtwxqruMEFE26H33TqI7T6jLbSQrpe3vD
         G9NS3nTFXAAyGu3wLybPZfeHr6JxOfIOQ/fi3+UNxdEf0WlFs3HSGk6jhGYsGFTJBMlJ
         eUYfthSxVTAl+wz8AJfVYMQc3+Hq/jHZarqjOFBkZN8ZXFW8YLf7VVEysWxl2ObwhL3R
         /rNs4DrgjnytG4iLb7QF9YZk3e5I79OSUP/jg7fczlx9zlh+Xk1H9A2LkBISpEKa0hZw
         dmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228608; x=1721833408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10gdFFvJv1+iPvT+xYjVbe0xzgeYMSRIMgDwYMfIOcs=;
        b=JXubazyNqkrDko2ZYIYclErQLohd7N0okwDGFTfFYN+TXaw0edY/wIvZ2MIhAoa/OZ
         BToRgqkbFhXID8oieFxfh6z1QB2+8nFkWph2ZILstXQtf1+6rtxFKqsS+So/qQYR8mM4
         CBYb57X1zisgNzLOZ66wh8UYxYBLeBY2Syt4IR10WKFARiJL/Nii8uxP7/qW1W1XCsQO
         8zVa4UWm3hPGOgv3sVZ9waY8gj32q0hqiFhmyrJVmJ3dDOPZL6Kg+m1mhz/1qhCxTS/G
         oVQ22p/3gox3roXjwstLXdX5RTBg+MpuCdTmXE3rDPImY8oolyphRjW2K9qOM5arcegG
         LpgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrNdMgk/401qzSi3SoGK3OYdqbN1h00GVMuBVjkZyiGoMLTFUjvH0asUCU96m0vRK90NGfbgpnWl2BMyJmgOV/gvbnqS2S5XTOGEq8
X-Gm-Message-State: AOJu0YxoK/WhDTfBY0/lLnve4rlXss4WwH+FEc5fMmX/nbExd/5Jy1M5
	2SSCf41S5KGRP6O9kzVXqUFgmjUyXiSm+xWt0Vp+uRnpzP2Bpt3EA+S/twAGdc1BDcmbjv3ZBNQ
	07GdhhosKYqwNMy6DV0BmZMRwMGtCJ+w/pDLLdw==
X-Google-Smtp-Source: AGHT+IEejgs1nHZZEUVKuRT4OqPhcasDNwG7eWkBaIZiRpvgt+WEoYJIPSty2XnbpXqIZ5TozWF3quDi8DLQcb4bDY0=
X-Received: by 2002:a17:90b:803:b0:2c9:7a8d:43f7 with SMTP id
 98e67ed59e1d1-2cb527b83abmr1484253a91.23.1721228608148; Wed, 17 Jul 2024
 08:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-14-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-14-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 17 Jul 2024 16:03:16 +0100
Message-ID: <CAJ9a7Vg-L+Csx15G_sNci3koMhZY6g95_pAiFgormmdbvWw9hQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/17] coresight: Make CPU id map a property of a trace
 ID map
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

On Fri, 12 Jul 2024 at 11:23, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> The global CPU ID mappings won't work for per-sink ID maps so move it to
> the ID map struct. coresight_trace_id_release_all_pending() is hard
> coded to operate on the default map, but once Perf sessions use their
> own maps the pending release mechanism will be deleted. So it doesn't
> need to be extended to accept a trace ID map argument at this point.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-trace-id.c | 16 +++++++++-------
>  include/linux/coresight.h                        |  1 +
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index 5561989a03fa..8a777c0af6ea 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -13,10 +13,12 @@
>  #include "coresight-trace-id.h"
>
>  /* Default trace ID map. Used in sysfs mode and for system sources */
> -static struct coresight_trace_id_map id_map_default;
> +static DEFINE_PER_CPU(atomic_t, id_map_default_cpu_ids) = ATOMIC_INIT(0);
> +static struct coresight_trace_id_map id_map_default = {
> +       .cpu_map = &id_map_default_cpu_ids
> +};
>
> -/* maintain a record of the mapping of IDs and pending releases per cpu */
> -static DEFINE_PER_CPU(atomic_t, cpu_id) = ATOMIC_INIT(0);
> +/* maintain a record of the pending releases per cpu */
>  static cpumask_t cpu_id_release_pending;
>
>  /* perf session active counter */
> @@ -49,7 +51,7 @@ static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
>  /* unlocked read of current trace ID value for given CPU */
>  static int _coresight_trace_id_read_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
>  {
> -       return atomic_read(&per_cpu(cpu_id, cpu));
> +       return atomic_read(per_cpu_ptr(id_map->cpu_map, cpu));
>  }
>
>  /* look for next available odd ID, return 0 if none found */
> @@ -145,7 +147,7 @@ static void coresight_trace_id_release_all_pending(void)
>                 clear_bit(bit, id_map->pend_rel_ids);
>         }
>         for_each_cpu(cpu, &cpu_id_release_pending) {
> -               atomic_set(&per_cpu(cpu_id, cpu), 0);
> +               atomic_set(per_cpu_ptr(id_map_default.cpu_map, cpu), 0);
>                 cpumask_clear_cpu(cpu, &cpu_id_release_pending);
>         }
>         spin_unlock_irqrestore(&id_map_lock, flags);
> @@ -181,7 +183,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
>                 goto get_cpu_id_out_unlock;
>
>         /* allocate the new id to the cpu */
> -       atomic_set(&per_cpu(cpu_id, cpu), id);
> +       atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
>
>  get_cpu_id_clr_pend:
>         /* we are (re)using this ID - so ensure it is not marked for release */
> @@ -215,7 +217,7 @@ static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_ma
>         } else {
>                 /* otherwise clear id */
>                 coresight_trace_id_free(id, id_map);
> -               atomic_set(&per_cpu(cpu_id, cpu), 0);
> +               atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
>         }
>
>         spin_unlock_irqrestore(&id_map_lock, flags);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index c16c61a8411d..7d62b88bfb5c 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -234,6 +234,7 @@ struct coresight_sysfs_link {
>  struct coresight_trace_id_map {
>         DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
>         DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
> +       atomic_t __percpu *cpu_map;
>  };
>
>  /**
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

