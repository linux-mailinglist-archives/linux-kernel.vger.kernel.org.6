Return-Path: <linux-kernel+bounces-170774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1108BDBD5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DECA1C2167C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B183D78C86;
	Tue,  7 May 2024 06:46:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E645E7319F;
	Tue,  7 May 2024 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715064397; cv=none; b=g59ZR3lvqX9hjtkDZzQisJ/Mk4Iv2LxoNguLobmSHpsmIfojr+ZHAglGYeyA4RnvaeorZRUUauo2fx3a0u/9/SKDyNdU7+e5FNLSmqxRjXOX4AkDWKxYJzfT7dDGCrvFLcXlSG/9GEIk2b07hPIsMecAAxjo3TGbA/8uR7qn8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715064397; c=relaxed/simple;
	bh=hqReQ5y+AsWmoo2WxdBboHTU6paScop1RtA5OVQAZTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJy8O9ZdRDVqHS8RJGAJEm9gFop5oIuYwMuDzNh9Jby/Hx9xdPGw+uTl3j2GpRZu2ZabE6aKYhEAEN5gfLPTGqN4t+kxj0S910GzUEG/RbtWENK03r57qYta/QuhhPHGTa9bqSm5qJLzizZqdXVsz09wWqoMThW6yo+gW08ABiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF670106F;
	Mon,  6 May 2024 23:46:59 -0700 (PDT)
Received: from [10.163.37.41] (unknown [10.163.37.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D1053F587;
	Mon,  6 May 2024 23:46:25 -0700 (PDT)
Message-ID: <1d2e50f0-d7d3-4392-8f2c-48eeb59d60c3@arm.com>
Date: Tue, 7 May 2024 12:16:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] coresight: Pass trace ID map into source enable
Content-Language: en-US
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
 coresight@lists.linaro.org, suzuki.poulose@arm.com, mike.leach@linaro.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240429152207.479221-1-james.clark@arm.com>
 <20240429152207.479221-15-james.clark@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240429152207.479221-15-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/24 20:51, James Clark wrote:
> This will allow Perf mode to pass in per-sink maps. System sources
> allocate IDs on probe so they don't use this and it's __maybe_unused.

Right, makes sense.

> 
> Sysfs mode also has the global map hard coded in various places, so pass
> in NULL when enabling for sysfs. We could bubble the global map all the
> way down to where it's used, but it wouldn't have any functional
> difference, so it's probably not worth the code churn.

Agreed.

> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-dummy.c      |  3 ++-
>  drivers/hwtracing/coresight/coresight-etm-perf.c   |  3 ++-
>  drivers/hwtracing/coresight/coresight-etm3x-core.c | 10 +++++-----
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 +++++-----
>  drivers/hwtracing/coresight/coresight-stm.c        |  3 ++-
>  drivers/hwtracing/coresight/coresight-sysfs.c      |  3 ++-
>  drivers/hwtracing/coresight/coresight-tpdm.c       |  3 ++-
>  include/linux/coresight.h                          |  2 +-
>  8 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
> index ac70c0b491be..1f1b9ad160f6 100644
> --- a/drivers/hwtracing/coresight/coresight-dummy.c
> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
> @@ -21,7 +21,8 @@ DEFINE_CORESIGHT_DEVLIST(source_devs, "dummy_source");
>  DEFINE_CORESIGHT_DEVLIST(sink_devs, "dummy_sink");
>  
>  static int dummy_source_enable(struct coresight_device *csdev,
> -			       struct perf_event *event, enum cs_mode mode)
> +			       struct perf_event *event, enum cs_mode mode,
> +			       __maybe_unused struct coresight_trace_id_map *id_map)
>  {
>  	dev_dbg(csdev->dev.parent, "Dummy source enabled\n");
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 25f1f87c90d1..177cecae38d9 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -496,7 +496,8 @@ static void etm_event_start(struct perf_event *event, int flags)
>  		goto fail_end_stop;
>  
>  	/* Finally enable the tracer */
> -	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
> +	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF,
> +				      coresight_trace_id_map_default()))
>  		goto fail_disable_path;
>  
>  	/*
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index b21f5ad94e63..b310bdf19038 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -482,7 +482,8 @@ void etm_release_trace_id(struct etm_drvdata *drvdata)
>  }
>  
>  static int etm_enable_perf(struct coresight_device *csdev,
> -			   struct perf_event *event)
> +			   struct perf_event *event,
> +			   struct coresight_trace_id_map *id_map)
>  {
>  	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  	int trace_id;
> @@ -501,8 +502,7 @@ static int etm_enable_perf(struct coresight_device *csdev,
>  	 * with perf locks - we know the ID cannot change until perf shuts down
>  	 * the session
>  	 */
> -	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu,
> -						  coresight_trace_id_map_default());
> +	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu, id_map);
>  	if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>  		dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
>  			dev_name(&drvdata->csdev->dev), drvdata->cpu);
> @@ -555,7 +555,7 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
>  }
>  
>  static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
> -		      enum cs_mode mode)
> +		      enum cs_mode mode, struct coresight_trace_id_map *id_map)
>  {
>  	int ret;
>  	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> @@ -570,7 +570,7 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
>  		ret = etm_enable_sysfs(csdev);
>  		break;
>  	case CS_MODE_PERF:
> -		ret = etm_enable_perf(csdev, event);
> +		ret = etm_enable_perf(csdev, event, id_map);
>  		break;
>  	default:
>  		ret = -EINVAL;
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index d16d6efb26fa..02dbb6c4daf5 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -753,7 +753,8 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>  }
>  
>  static int etm4_enable_perf(struct coresight_device *csdev,
> -			    struct perf_event *event)
> +			    struct perf_event *event,
> +			    struct coresight_trace_id_map *id_map)
>  {
>  	int ret = 0, trace_id;
>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> @@ -776,8 +777,7 @@ static int etm4_enable_perf(struct coresight_device *csdev,
>  	 * with perf locks - we know the ID cannot change until perf shuts down
>  	 * the session
>  	 */
> -	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu,
> -						  coresight_trace_id_map_default());
> +	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu, id_map);
>  	if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>  		dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
>  			dev_name(&drvdata->csdev->dev), drvdata->cpu);
> @@ -839,7 +839,7 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
>  }
>  
>  static int etm4_enable(struct coresight_device *csdev, struct perf_event *event,
> -		       enum cs_mode mode)
> +		       enum cs_mode mode, struct coresight_trace_id_map *id_map)
>  {
>  	int ret;
>  
> @@ -853,7 +853,7 @@ static int etm4_enable(struct coresight_device *csdev, struct perf_event *event,
>  		ret = etm4_enable_sysfs(csdev);
>  		break;
>  	case CS_MODE_PERF:
> -		ret = etm4_enable_perf(csdev, event);
> +		ret = etm4_enable_perf(csdev, event, id_map);
>  		break;
>  	default:
>  		ret = -EINVAL;
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index e1c62820dfda..a80ad1de4c23 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -194,7 +194,8 @@ static void stm_enable_hw(struct stm_drvdata *drvdata)
>  }
>  
>  static int stm_enable(struct coresight_device *csdev, struct perf_event *event,
> -		      enum cs_mode mode)
> +		      enum cs_mode mode,
> +		      __maybe_unused struct coresight_trace_id_map *trace_id)
>  {
>  	struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
> index 1e67cc7758d7..a01c9e54e2ed 100644
> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  
>  #include "coresight-priv.h"
> +#include "coresight-trace-id.h"
>  
>  /*
>   * Use IDR to map the hash of the source's device name
> @@ -63,7 +64,7 @@ static int coresight_enable_source_sysfs(struct coresight_device *csdev,
>  	 */
>  	lockdep_assert_held(&coresight_mutex);
>  	if (coresight_get_mode(csdev) != CS_MODE_SYSFS) {
> -		ret = source_ops(csdev)->enable(csdev, data, mode);
> +		ret = source_ops(csdev)->enable(csdev, data, mode, NULL);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index a9708ab0d488..0376ad326a2f 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -439,7 +439,8 @@ static void __tpdm_enable(struct tpdm_drvdata *drvdata)
>  }
>  
>  static int tpdm_enable(struct coresight_device *csdev, struct perf_event *event,
> -		       enum cs_mode mode)
> +		       enum cs_mode mode,
> +		       __maybe_unused struct coresight_trace_id_map *id_map)
>  {
>  	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 7d62b88bfb5c..3a678e5425dc 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -384,7 +384,7 @@ struct coresight_ops_link {
>  struct coresight_ops_source {
>  	int (*cpu_id)(struct coresight_device *csdev);
>  	int (*enable)(struct coresight_device *csdev, struct perf_event *event,
> -		      enum cs_mode mode);
> +		      enum cs_mode mode, struct coresight_trace_id_map *id_map);
>  	void (*disable)(struct coresight_device *csdev,
>  			struct perf_event *event);
>  };

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

