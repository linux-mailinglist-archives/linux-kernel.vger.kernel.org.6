Return-Path: <linux-kernel+bounces-322509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6E29729E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044AA28637D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E25D17C216;
	Tue, 10 Sep 2024 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz2iTe1k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04513A242;
	Tue, 10 Sep 2024 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951412; cv=none; b=InLg8EZ1dWwnYp9Bzq0+L37HQlvP2lvrUmeD6qu70eXKRDiim0MbYYW58Yp59uoB1NQnYODc+bw4M5zvI0mMNqlTntG68z2suoW9Qvindy+lOPB1n/rhlrTHJ6Cb7R5+wNo60PIqlOLNXzHuWi3eTMFua+aGIpM/69wk8/n8WHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951412; c=relaxed/simple;
	bh=JRiZ0xj6jU/m2XriEJTGefpRMtVhRkzsDQX6ITf+Bwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIqdy5jeufk8+vzTOqgnzvO6VgmyXiArCpLiRLzqkCSzAqiNNqpQa5zG3xH7OrqSoXg9GMOTQjAT8k/lSXtnfeUcPrPAaZ+JdMMIny7StjFw3wlbHKc2dvbnD6IN6jUH6sYBMAf/4FE9zHbxvfCXw8JXGmDjOi/rlfq3WfrYXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz2iTe1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B41C4CEC3;
	Tue, 10 Sep 2024 06:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725951411;
	bh=JRiZ0xj6jU/m2XriEJTGefpRMtVhRkzsDQX6ITf+Bwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yz2iTe1kuePXBsZ7y9rcvK/ycR27hFMNXP2BI18hfPMBJwwWNC/PWdI/JX3FjSnl/
	 G0i+GQp4CuU+ZCJRysZvwx62e5cyGzYdjUdTbc2ooJCm7APQdOUIVjNrUHvSEsc5y0
	 JAPFPMFxHzgF6RUEvSsREfH1bKPFXtoB0hp1K/P4pXX4AjzKIP5lLK02bSZ1ZZ3fen
	 z0BWHcrHhE6eTuo9WZgnOoYlDl41AQglaz0TWBInyY6Lo1XzKDCUFtmP+QVLK0otv3
	 v/wNuVzobwolSfG7BUUAjxTABlcmZy2OKjQK3vrdtXjFP6gij/IyPWuYmokSXsGvj3
	 So3FaLjijAZ7A==
Date: Mon, 9 Sep 2024 23:56:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Junhao He <hejunhao3@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 14/15] perf hwmon_pmu: Add a tool PMU exposing events
 from hwmon in sysfs
Message-ID: <Zt_tsEJfOOSM1VuU@google.com>
References: <20240907050830.6752-1-irogers@google.com>
 <20240907050830.6752-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240907050830.6752-15-irogers@google.com>

On Fri, Sep 06, 2024 at 10:08:29PM -0700, Ian Rogers wrote:
> The hwmon sysfs ABI is defined in
> Documentation/hwmon/sysfs-interface.rst. Create a PMU that reads the
> hwmon input and can be used in `perf stat` and metrics much as an
> uncore PMU can.
> 
> For example, the following shows reading the CPU temperature and 2 fan
> speeds alongside the uncore frequency:
> ```
> $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/ -M UNCORE_FREQ -I 1000
>      1.001153138              52.00 'C   temp_cpu
>      1.001153138              2,588 rpm  fan1
>      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
>      1.001153138                  8      tool/num_cpus_online/
>      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET                 #     1.08 UNCORE_FREQ
>      1.001153138      1,012,773,595      duration_time
> ...
> ```

Interesting!  While they don't seem to be counters, it'd be useful to
see the values from various sources/PMUs especially for interval mode.

> 
> The PMUs are named from /sys/class/hwmon/hwmon<num>/name and have an
> alias of hwmon<num>. The events are naned using the _label files as
> well as the <type><num> prefix, the latter guaranteed to be unique.
> 
> In `perf list` the other hwmon files are used to give a richer
> description, for example:
> ```
> hwmon:
>   temp1
>        [Temperature in unit acpitz named temp1. Unit: hwmon_acpitz]
>   in0
>        [Voltage in unit bat0 named in0. Unit: hwmon_bat0]
>   temp_core_0 OR temp2
>        [Temperature in unit coretemp named Core 0. crit=100'C,max=100'C crit_alarm=0'C. Unit:
>         hwmon_coretemp]
>   temp_core_1 OR temp3
>        [Temperature in unit coretemp named Core 1. crit=100'C,max=100'C crit_alarm=0'C. Unit:
>         hwmon_coretemp]
> ...
>   temp_package_id_0 OR temp1
>        [Temperature in unit coretemp named Package id 0. crit=100'C,max=100'C crit_alarm=0'C.
>         Unit: hwmon_coretemp]
>   temp1
>        [Temperature in unit iwlwifi_1 named temp1. Unit: hwmon_iwlwifi_1]
>   temp_composite OR temp1
>        [Temperature in unit nvme named Composite. alarm=0'C,crit=86.85'C,max=75.85'C,
>         min=-273.15'C. Unit: hwmon_nvme]
>   temp_sensor_1 OR temp2
>        [Temperature in unit nvme named Sensor 1. max=65261.8'C,min=-273.15'C. Unit: hwmon_nvme]
>   temp_sensor_2 OR temp3
>        [Temperature in unit nvme named Sensor 2. max=65261.8'C,min=-273.15'C. Unit: hwmon_nvme]
>   fan1
>        [Fan in unit thinkpad named fan1. Unit: hwmon_thinkpad]
>   fan2
>        [Fan in unit thinkpad named fan2. Unit: hwmon_thinkpad]
> ...
>   temp_cpu OR temp1
>        [Temperature in unit thinkpad named CPU. Unit: hwmon_thinkpad]
>   temp_gpu OR temp2
>        [Temperature in unit thinkpad named GPU. Unit: hwmon_thinkpad]
>   curr1
>        [Current in unit ucsi_source_psy_usbc000_0 named curr1. max=1.5A. Unit:
>         hwmon_ucsi_source_psy_usbc000_0]
>   in0
>        [Voltage in unit ucsi_source_psy_usbc000_0 named in0. max=5V,min=5V. Unit:
>         hwmon_ucsi_source_psy_usbc000_0]
> ```
> 
> As there may be multiple hwmon devices a range of PMU types are
> reserved for their use and to identify the PMU as belonging to the
> hwmon types.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/Build       |   1 +
>  tools/perf/util/evsel.c     |   9 +
>  tools/perf/util/hwmon_pmu.c | 879 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/hwmon_pmu.h |  30 ++
>  tools/perf/util/pmu.c       |  17 +
>  tools/perf/util/pmu.h       |   2 +
>  tools/perf/util/pmus.c      |   2 +
>  7 files changed, 940 insertions(+)
>  create mode 100644 tools/perf/util/hwmon_pmu.c
>  create mode 100644 tools/perf/util/hwmon_pmu.h
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 80187e3a52be..b1dd5d176d1c 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -83,6 +83,7 @@ perf-util-y += pmu.o
>  perf-util-y += pmus.o
>  perf-util-y += pmu-flex.o
>  perf-util-y += pmu-bison.o
> +perf-util-y += hwmon_pmu.o
>  perf-util-y += tool_pmu.o
>  perf-util-y += svghelper.o
>  perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 9e748ed20988..64883d2aa1bb 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -50,6 +50,7 @@
>  #include "off_cpu.h"
>  #include "pmu.h"
>  #include "pmus.h"
> +#include "hwmon_pmu.h"
>  #include "tool_pmu.h"
>  #include "rlimit.h"
>  #include "../perf-sys.h"
> @@ -1657,6 +1658,9 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
>  	if (evsel__is_tool(evsel))
>  		return evsel__tool_pmu_read(evsel, cpu_map_idx, thread);
>  
> +	if (evsel__is_hwmon(evsel))
> +		return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);
> +
>  	if (evsel__is_retire_lat(evsel))
>  		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
>  
> @@ -2094,6 +2098,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  					    start_cpu_map_idx,
>  					    end_cpu_map_idx);
>  	}
> +	if (evsel__is_hwmon(evsel)) {
> +		return evsel__hwmon_pmu_open(evsel, threads,
> +					     start_cpu_map_idx,
> +					     end_cpu_map_idx);
> +	}
>  
>  	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
>  
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> new file mode 100644
> index 000000000000..cc8816b787ca
> --- /dev/null
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -0,0 +1,879 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +#include "counts.h"
> +#include "debug.h"
> +#include "evsel.h"
> +#include "hashmap.h"
> +#include "hwmon_pmu.h"
> +#include "pmu.h"
> +#include <internal/xyarray.h>
> +#include <internal/threadmap.h>
> +#include <perf/threadmap.h>
> +#include <sys/types.h>
> +#include <ctype.h>
> +#include <dirent.h>
> +#include <fcntl.h>
> +#include <api/fs/fs.h>
> +#include <api/io.h>
> +#include <linux/zalloc.h>
> +
> +enum hwmon_type {
> +	HWMON_TYPE_NONE,
> +
> +	HWMON_TYPE_CPU,
> +	HWMON_TYPE_CURR,
> +	HWMON_TYPE_ENERGY,
> +	HWMON_TYPE_FAN,
> +	HWMON_TYPE_HUMIDITY,
> +	HWMON_TYPE_IN,
> +	HWMON_TYPE_INTRUSION,
> +	HWMON_TYPE_POWER,
> +	HWMON_TYPE_PWM,
> +	HWMON_TYPE_TEMP,

Where does this list come from?  Is it exhaustive?


> +
> +	HWMON_TYPE_MAX
> +};
> +
> +static const char * const hwmon_type_strs[HWMON_TYPE_MAX] = {
> +	NULL,
> +	"cpu",
> +	"curr",
> +	"energy",
> +	"fan",
> +	"humidity",
> +	"in",
> +	"intrusion",
> +	"power",
> +	"pwm",
> +	"temp",
> +};
> +
> +static const char *const hwmon_units[HWMON_TYPE_MAX] = {
> +	NULL,
> +	"V",   /* cpu */
> +	"A",   /* curr */
> +	"J",   /* energy */
> +	"rpm", /* fan */
> +	"%",   /* humidity */
> +	"V",   /* in */
> +	"",    /* intrusion */
> +	"W",   /* power */
> +	"Hz",  /* pwm */
> +	"'C",  /* temp */
> +};
> +
> +enum hwmon_item {
> +	HWMON_ITEM_NONE,
> +
> +	HWMON_ITEM_ACCURACY,
> +	HWMON_ITEM_ALARM,
> +	HWMON_ITEM_AUTO_CHANNELS_TEMP,
> +	HWMON_ITEM_AVERAGE,
> +	HWMON_ITEM_AVERAGE_HIGHEST,
> +	HWMON_ITEM_AVERAGE_INTERVAL,
> +	HWMON_ITEM_AVERAGE_INTERVAL_MAX,
> +	HWMON_ITEM_AVERAGE_INTERVAL_MIN,
> +	HWMON_ITEM_AVERAGE_LOWEST,
> +	HWMON_ITEM_AVERAGE_MAX,
> +	HWMON_ITEM_AVERAGE_MIN,
> +	HWMON_ITEM_BEEP,
> +	HWMON_ITEM_CAP,
> +	HWMON_ITEM_CAP_HYST,
> +	HWMON_ITEM_CAP_MAX,
> +	HWMON_ITEM_CAP_MIN,
> +	HWMON_ITEM_CRIT,
> +	HWMON_ITEM_CRIT_HYST,
> +	HWMON_ITEM_DIV,
> +	HWMON_ITEM_EMERGENCY,
> +	HWMON_ITEM_EMERGENCY_HIST,
> +	HWMON_ITEM_ENABLE,
> +	HWMON_ITEM_FAULT,
> +	HWMON_ITEM_FREQ,
> +	HWMON_ITEM_HIGHEST,
> +	HWMON_ITEM_INPUT,
> +	HWMON_ITEM_LABEL,
> +	HWMON_ITEM_LCRIT,
> +	HWMON_ITEM_LCRIT_HYST,
> +	HWMON_ITEM_LOWEST,
> +	HWMON_ITEM_MAX,
> +	HWMON_ITEM_MAX_HYST,
> +	HWMON_ITEM_MIN,
> +	HWMON_ITEM_MIN_HYST,
> +	HWMON_ITEM_MOD,
> +	HWMON_ITEM_OFFSET,
> +	HWMON_ITEM_PULSES,
> +	HWMON_ITEM_RATED_MAX,
> +	HWMON_ITEM_RATED_MIN,
> +	HWMON_ITEM_RESET_HISTORY,
> +	HWMON_ITEM_TARGET,
> +	HWMON_ITEM_TYPE,
> +	HWMON_ITEM_VID,
> +
> +	HWMON_ITEM__MAX,
> +};
> +
> +static const char * const hwmon_item_strs[HWMON_ITEM__MAX] = {
> +	NULL,
> +	"accuracy",
> +	"alarm",
> +	"auto_channels_temp",
> +	"average",
> +	"average_highest",
> +	"average_interval",
> +	"average_interval_max",
> +	"average_interval_min",
> +	"average_lowest",
> +	"average_max",
> +	"average_min",
> +	"beep",
> +	"cap",
> +	"cap_hyst",
> +	"cap_max",
> +	"cap_min",
> +	"crit",
> +	"crit_hyst",
> +	"div",
> +	"emergency",
> +	"emergency_hist",
> +	"enable",
> +	"fault",
> +	"freq",
> +	"highest",
> +	"input",
> +	"label",
> +	"lcrit",
> +	"lcrit_hyst",
> +	"lowest",
> +	"max",
> +	"max_hyst",
> +	"min",
> +	"min_hyst",
> +	"mod",
> +	"offset",
> +	"pulses",
> +	"rated_max",
> +	"rated_min",
> +	"reset_history",
> +	"target",
> +	"type",
> +	"vid",
> +};
> +
> +struct hwmon_pmu {
> +	struct perf_pmu pmu;
> +	struct hashmap events;
> +	int pmu_dir_fd;
> +};
> +
> +/**
> + * union hwmon_pmu_event_key: Key for hwmon_pmu->events as such each key
> + * represents an event.
> + *
> + * Related hwmon files start <type><number> that this key represents.
> + */
> +union hwmon_pmu_event_key {
> +	long type_and_num;
> +	struct {
> +		int num :16;
> +		enum hwmon_type type :8;

Why not plain int types?  I'm not sure how much we care about 32 bits
but you could use short int then.


> +	};
> +};
> +
> +/**
> + * struct hwmon_pmu_event_value: Value in hwmon_pmu->events.
> + *
> + * Hwmon files are of the form <type><number>_<item> and may have a suffix
> + * _alarm.
> + */
> +struct hwmon_pmu_event_value {
> +	/** @items: which item files are present. */
> +	DECLARE_BITMAP(items, HWMON_ITEM__MAX);
> +	/** @alarm_items: which item files are present. */
> +	DECLARE_BITMAP(alarm_items, HWMON_ITEM__MAX);
> +	/** @label: contents of <type><number>_label if present. */
> +	char *label;
> +	/** @name: name computed from label of the form <type>_<label>. */
> +	char *name;
> +};
> +
> +bool perf_pmu__is_hwmon(const struct perf_pmu *pmu)
> +{
> +	return pmu && pmu->type >= PERF_PMU_TYPE_HWMON_START &&
> +		pmu->type <= PERF_PMU_TYPE_HWMON_END;
> +}
> +
> +bool evsel__is_hwmon(const struct evsel *evsel)
> +{
> +	return perf_pmu__is_hwmon(evsel->pmu);
> +}
> +
> +static size_t hwmon_pmu__event_hashmap_hash(long key, void *ctx __maybe_unused)
> +{
> +	return ((union hwmon_pmu_event_key)key).type_and_num;
> +}
> +
> +static bool hwmon_pmu__event_hashmap_equal(long key1, long key2, void *ctx __maybe_unused)
> +{
> +	return ((union hwmon_pmu_event_key)key1).type_and_num ==
> +	       ((union hwmon_pmu_event_key)key2).type_and_num;
> +}
> +
> +static int hwmon_strcmp(const void *a, const void *b)
> +{
> +	const char *sa = a;
> +	const char * const *sb = b;
> +
> +	return strcmp(sa, *sb);
> +}
> +

Can you please add some examples of typical filename in a comment here?


> +static bool parse_hwmon_filename(const char *filename,
> +				 enum hwmon_type *type,
> +				 int *number,
> +				 enum hwmon_item *item,
> +				 bool *alarm)
> +{
> +	char fn_type[24];
> +	const char **elem;
> +	const char *fn_item = NULL;
> +	size_t fn_item_len;
> +
> +	assert(strlen("intrusion") < sizeof(fn_type));

Why intrusion?


> +	strncpy(fn_type, filename, sizeof(fn_type));
> +	for (size_t i = 0; i < sizeof(fn_type); i++) {
> +		if (fn_type[i] >= '0' && fn_type[i] <= '9') {
> +			fn_type[i] = '\0';
> +			*number = strtoul(&filename[i], (char **)&fn_item, 10);
> +			if (*fn_item == '_')
> +				fn_item++;
> +			break;
> +		}
> +		if (fn_type[i] == '_') {
> +			fn_type[i] = '\0';
> +			*number = -1;
> +			fn_item = &filename[i + 1];
> +			break;
> +		}
> +	}
> +	if (fn_item == NULL || fn_type[0] == '\0' || (item != NULL && fn_item[0] == '\0')) {
> +		pr_debug("hwmon_pmu: not a hwmon file '%s'\n", filename);
> +		return false;
> +	}
> +	elem = bsearch(&fn_type, hwmon_type_strs + 1, ARRAY_SIZE(hwmon_type_strs) - 1,
> +		       sizeof(hwmon_type_strs[0]), hwmon_strcmp);

Can we make the first entry an empty string rather than NULL to make
this simpler?


> +	if (!elem) {
> +		pr_debug("hwmon_pmu: not a hwmon type '%s' in file name '%s'\n",
> +			 fn_type, filename);
> +		return false;
> +	}
> +
> +	*type = elem - &hwmon_type_strs[0];
> +	if (!item)
> +		return true;
> +
> +	*alarm = false;
> +	fn_item_len = strlen(fn_item);
> +	if (fn_item_len > 6 && !strcmp(&fn_item[fn_item_len - 6], "_alarm")) {
> +		assert(strlen("average_interval_max") < sizeof(fn_type));
> +		strncpy(fn_type, fn_item, fn_item_len - 6);
> +		fn_item = fn_type;
> +		*alarm = true;
> +	}

A comment to explain why it handles the "alarm" differently would be
great.


> +	elem = bsearch(fn_item, hwmon_item_strs + 1, ARRAY_SIZE(hwmon_item_strs) - 1,
> +		       sizeof(hwmon_item_strs[0]), hwmon_strcmp);
> +	if (!elem) {
> +		pr_debug("hwmon_pmu: not a hwmon item '%s' in file name '%s'\n",
> +			 fn_item, filename);
> +		return false;
> +	}
> +	*item = elem - &hwmon_item_strs[0];
> +	return true;
> +}
> +
> +static void fix_name(char *p)
> +{
> +	char *s = strchr(p, '\n');
> +
> +	if (s)
> +		*s = '\0';
> +
> +	while (*p != '\0') {
> +		if (strchr(" :,/\n\t", *p))
> +			*p = '_';
> +		else
> +			*p = tolower(*p);
> +		p++;
> +	}
> +}
> +
> +static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)

Maybe better to use other short name ('hwm'?) than 'pmu'.


> +{
> +	DIR *dir;
> +	struct dirent *ent;
> +	int dup_fd, err = 0;
> +	struct hashmap_entry *cur, *tmp;
> +	size_t bkt;
> +
> +	if (pmu->pmu.sysfs_aliases_loaded)
> +		return 0;
> +
> +	/* Use a dup-ed fd as closedir will close it. */
> +	dup_fd = dup(pmu->pmu_dir_fd);
> +	if (dup_fd == -1)
> +		return -ENOMEM;
> +
> +	dir = fdopendir(dup_fd);
> +	if (!dir) {
> +		close(dup_fd);
> +		return -ENOMEM;
> +	}
> +
> +	while ((ent = readdir(dir)) != NULL) {
> +		enum hwmon_type type;
> +		int number;
> +		enum hwmon_item item;
> +		bool alarm;
> +		union hwmon_pmu_event_key key;
> +		struct hwmon_pmu_event_value *value;
> +
> +		if (ent->d_type != DT_REG)
> +			continue;
> +
> +		if (!parse_hwmon_filename(ent->d_name, &type, &number, &item, &alarm)) {
> +			pr_debug("Not a hwmon file '%s'\n", ent->d_name);
> +			continue;
> +		}
> +		key.num = number;
> +		key.type = type;
> +		if (!hashmap__find(&pmu->events, key.type_and_num, &value)) {
> +			value = zalloc(sizeof(*value));
> +			if (!value) {
> +				err = -ENOMEM;
> +				goto err_out;
> +			}
> +			err = hashmap__add(&pmu->events, key.type_and_num, value);
> +			if (err) {
> +				free(value);
> +				err = -ENOMEM;
> +				goto err_out;
> +			}
> +		}
> +		__set_bit(item, alarm ? value->alarm_items : value->items);
> +		if (item == HWMON_ITEM_LABEL) {
> +			char buf[128];
> +			int fd = openat(pmu->pmu_dir_fd, ent->d_name, O_RDONLY);
> +			ssize_t read_len;
> +
> +			if (fd < 0)
> +				continue;
> +
> +			read_len = read(fd, buf, sizeof(buf));
> +
> +			while (read_len > 0 && buf[read_len - 1] == '\n')
> +				read_len--;
> +
> +			if (read_len > 0)
> +				buf[read_len] = '\0';
> +
> +			if (buf[0] == '\0') {
> +				pr_debug("hwmon_pmu: empty label file %s %s\n",
> +					 pmu->pmu.name, ent->d_name);
> +				close(fd);
> +				continue;
> +			}
> +			value->label = strdup(buf);
> +			if (!value->label) {
> +				pr_debug("hwmon_pmu: memory allocation failure\n");
> +				close(fd);
> +				continue;
> +			}
> +			snprintf(buf, sizeof(buf), "%s_%s", hwmon_type_strs[type], value->label);
> +			fix_name(buf);
> +			value->name = strdup(buf);
> +			if (!value->name)
> +				pr_debug("hwmon_pmu: memory allocation failure\n");
> +			close(fd);
> +		}
> +	}
> +	hashmap__for_each_entry_safe((&pmu->events), cur, tmp, bkt) {
> +		union hwmon_pmu_event_key key = {
> +			.type_and_num = cur->key,
> +		};
> +		struct hwmon_pmu_event_value *value = cur->pvalue;
> +
> +		if (!test_bit(HWMON_ITEM_INPUT, value->items)) {
> +			pr_debug("hwmon_pmu: removing event '%s%d' that has no input file",
> +				hwmon_type_strs[key.type], key.num);

What is the input file and why is it required?


> +			hashmap__delete(&pmu->events, key.type_and_num, &key, &value);
> +			zfree(&value->label);
> +			zfree(&value->name);
> +			free(value);
> +		}
> +	}
> +	pmu->pmu.sysfs_aliases_loaded = true;
> +
> +err_out:
> +	closedir(dir);
> +	return err;
> +}
> +
> +static int hwmon_pmu__new(struct list_head *pmus, int pmu_dir, const char *sysfs_name,
> +			  const char *name)
> +{
> +	char buf[32];
> +	struct hwmon_pmu *pmu;
> +	int err = 0;
> +
> +	pr_debug("Hi Ian, '%s' -> '%s'\n", sysfs_name, name);

Forgot to remove? :)

> +
> +	pmu = zalloc(sizeof(*pmu));
> +	if (!pmu)
> +		return -ENOMEM;
> +
> +
> +	pmu->pmu_dir_fd = pmu_dir;
> +	pmu->pmu.type = PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name + 5, NULL, 10);
> +	if (pmu->pmu.type > PERF_PMU_TYPE_HWMON_END) {
> +		err = -EINVAL;
> +		goto err_out;
> +	}
> +	snprintf(buf, sizeof(buf), "hwmon_%s", name);
> +	fix_name(buf + 6);
> +	pmu->pmu.name = strdup(buf);
> +	if (!pmu->pmu.name) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +	pmu->pmu.alias_name = strdup(sysfs_name);
> +	if (!pmu->pmu.alias_name) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +	pmu->pmu.cpus = perf_cpu_map__new("0");
> +	if (!pmu->pmu.cpus) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +	INIT_LIST_HEAD(&pmu->pmu.format);
> +	INIT_LIST_HEAD(&pmu->pmu.aliases);
> +	INIT_LIST_HEAD(&pmu->pmu.caps);
> +	hashmap__init(&pmu->events, hwmon_pmu__event_hashmap_hash,
> +		      hwmon_pmu__event_hashmap_equal, /*ctx=*/NULL);
> +
> +	list_add_tail(&pmu->pmu.list, pmus);
> +err_out:
> +	if (err) {
> +		free((char *)pmu->pmu.name);
> +		free(pmu->pmu.alias_name);
> +		free(pmu);
> +		close(pmu_dir);
> +	}
> +	return err;
> +}
> +
> +static size_t hwmon_pmu__describe_items(struct hwmon_pmu *pmu, char *out_buf, size_t out_buf_len,
> +					union hwmon_pmu_event_key key,
> +					const unsigned long *items, bool is_alarm)
> +{
> +	size_t bit;
> +	char buf[64];
> +	size_t len = 0;
> +
> +	for_each_set_bit(bit, items, HWMON_ITEM__MAX) {
> +		int fd;
> +
> +		if (bit == HWMON_ITEM_LABEL || bit == HWMON_ITEM_INPUT)
> +			continue;
> +
> +		snprintf(buf, sizeof(buf), "%s%d_%s%s",
> +			hwmon_type_strs[key.type],
> +			key.num,
> +			hwmon_item_strs[bit],
> +			is_alarm ? "_alarm" : "");
> +		fd = openat(pmu->pmu_dir_fd, buf, O_RDONLY);
> +		if (fd > 0) {
> +			ssize_t read_len = read(fd, buf, sizeof(buf));
> +
> +			while (read_len > 0 && buf[read_len - 1] == '\n')
> +				read_len--;
> +
> +			if (read_len > 0) {
> +				long long val;
> +
> +				buf[read_len] = '\0';
> +				val = strtoll(buf, /*endptr=*/NULL, 10);
> +				len += snprintf(out_buf + len, out_buf_len - len, "%s%s%s=%g%s",
> +						len == 0 ? " " : ", ",
> +						hwmon_item_strs[bit],
> +						is_alarm ? "_alarm" : "",
> +						(double)val / 1000.0,
> +						hwmon_units[key.type]);
> +			}
> +			close(fd);
> +		}
> +	}
> +	return len;
> +}
> +
> +int hwmon_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
> +{
> +	struct hwmon_pmu *hwmon_pmu = container_of(pmu, struct hwmon_pmu, pmu);
> +	struct hashmap_entry *cur;
> +	size_t bkt;
> +
> +	if (hwmon_pmu__read_events(hwmon_pmu))
> +		return false;
> +
> +	hashmap__for_each_entry((&hwmon_pmu->events), cur, bkt) {
> +		static const char *const hwmon_scale_units[HWMON_TYPE_MAX] = {
> +			NULL,
> +			"0.001V", /* cpu */
> +			"0.001A", /* curr */
> +			"0.001J", /* energy */
> +			"1rpm",   /* fan */
> +			"0.001%", /* humidity */
> +			"0.001V", /* in */
> +			NULL,     /* intrusion */
> +			"0.001W", /* power */
> +			"1Hz",    /* pwm */
> +			"0.001'C", /* temp */
> +		};
> +		static const char *const hwmon_desc[HWMON_TYPE_MAX] = {
> +			NULL,
> +			"CPU core reference voltage",   /* cpu */
> +			"Current",                      /* curr */
> +			"Cumulative energy use",        /* energy */
> +			"Fan",                          /* fan */
> +			"Humidity",                     /* humidity */
> +			"Voltage",                      /* in */
> +			"Chassis intrusion detection",  /* intrusion */
> +			"Power use",                    /* power */
> +			"Pulse width modulation fan control", /* pwm */
> +			"Temperature",                  /* temp */
> +		};
> +		char alias_buf[64];
> +		char desc_buf[256];
> +		char encoding_buf[128];
> +		union hwmon_pmu_event_key key = {
> +			.type_and_num = cur->key,
> +		};
> +		struct hwmon_pmu_event_value *value = cur->pvalue;
> +		struct pmu_event_info info = {
> +			.pmu = pmu,
> +			.name = value->name,
> +			.alias = alias_buf,
> +			.scale_unit = hwmon_scale_units[key.type],
> +			.desc = desc_buf,
> +			.long_desc = NULL,
> +			.encoding_desc = encoding_buf,
> +			.topic = "hwmon",
> +			.pmu_name = pmu->name,
> +			.event_type_desc = "Hwmon event",
> +		};
> +		int ret;
> +		size_t len;
> +
> +		len = snprintf(alias_buf, sizeof(alias_buf), "%s%d",
> +			       hwmon_type_strs[key.type], key.num);
> +		if (!info.name) {
> +			info.name = info.alias;
> +			info.alias = NULL;
> +		}
> +
> +		len = snprintf(desc_buf, sizeof(desc_buf), "%s in unit %s named %s.",
> +			hwmon_desc[key.type],
> +			pmu->name + 6,
> +			value->label ?: info.name);
> +
> +		len += hwmon_pmu__describe_items(hwmon_pmu, desc_buf + len, sizeof(desc_buf) - len,
> +						key, value->items, /*is_alarm=*/false);
> +
> +		len += hwmon_pmu__describe_items(hwmon_pmu, desc_buf + len, sizeof(desc_buf) - len,
> +						key, value->alarm_items, /*is_alarm=*/true);
> +
> +		snprintf(encoding_buf, sizeof(encoding_buf), "%s/config=0x%lx/",
> +			 pmu->name, cur->key);
> +
> +		ret = cb(state, &info);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +size_t hwmon_pmu__num_events(struct perf_pmu *pmu)
> +{
> +	struct hwmon_pmu *hwmon_pmu = container_of(pmu, struct hwmon_pmu, pmu);
> +
> +	hwmon_pmu__read_events(hwmon_pmu);
> +	return hashmap__size(&hwmon_pmu->events);
> +}
> +
> +bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
> +{
> +	struct hwmon_pmu *hwmon_pmu = container_of(pmu, struct hwmon_pmu, pmu);
> +	enum hwmon_type type;
> +	int number;
> +	union hwmon_pmu_event_key key;
> +	struct hashmap_entry *cur;
> +	size_t bkt;
> +
> +	if (!parse_hwmon_filename(name, &type, &number, /*item=*/NULL, /*is_alarm=*/NULL))
> +		return false;
> +
> +	if (hwmon_pmu__read_events(hwmon_pmu))
> +		return false;
> +
> +	key.type = type;
> +	key.num = number;
> +	if (hashmap_find(&hwmon_pmu->events, key.type_and_num, /*value=*/NULL))
> +		return true;
> +	if (key.num != -1)
> +		return false;
> +	/* Item is of form <type>_ which means we should match <type>_<label>. */
> +	hashmap__for_each_entry((&hwmon_pmu->events), cur, bkt) {
> +		struct hwmon_pmu_event_value *value = cur->pvalue;
> +
> +		key.type_and_num = cur->key;
> +		if (key.type == type && value->name && !strcasecmp(name, value->name))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static int hwmon_pmu__config_term(const struct hwmon_pmu *pmu,
> +				  struct perf_event_attr *attr,
> +				  struct parse_events_term *term,
> +				  struct parse_events_error *err)
> +{
> +	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {
> +		enum hwmon_type type;
> +		int number;
> +
> +		if (parse_hwmon_filename(term->config, &type, &number,
> +					 /*item=*/NULL, /*is_alarm=*/NULL)) {
> +			if (number == -1) {
> +				/*
> +				 * Item is of form <type>_ which means we should
> +				 * match <type>_<label>.
> +				 */
> +				struct hashmap_entry *cur;
> +				size_t bkt;
> +
> +				attr->config = 0;
> +				hashmap__for_each_entry((&pmu->events), cur, bkt) {
> +					union hwmon_pmu_event_key key = {
> +						.type_and_num = cur->key,
> +					};
> +					struct hwmon_pmu_event_value *value = cur->pvalue;
> +
> +					if (key.type == type && value->name &&
> +					    !strcasecmp(term->config, value->name)) {
> +						attr->config = key.type_and_num;
> +						break;
> +					}
> +				}
> +				if (attr->config == 0)
> +					return -EINVAL;
> +			} else {
> +				union hwmon_pmu_event_key key = {
> +					.type = type,
> +					.num = number,
> +				};
> +
> +				attr->config = key.type_and_num;
> +			}
> +			return 0;
> +		}
> +	}
> +	if (err) {
> +		char *err_str;
> +
> +		parse_events_error__handle(err, term->err_val,
> +					asprintf(&err_str,
> +						"unexpected hwmon event term (%s) %s",
> +						parse_events__term_type_str(term->type_term),
> +						term->config) < 0
> +					? strdup("unexpected hwmon event term")
> +					: err_str,
> +					NULL);
> +	}
> +	return -EINVAL;
> +}
> +
> +int hwmon_pmu__config_terms(const struct perf_pmu *pmu,
> +			    struct perf_event_attr *attr,
> +			    struct parse_events_terms *terms,
> +			    struct parse_events_error *err)
> +{
> +	const struct hwmon_pmu *hwmon_pmu = container_of(pmu, struct hwmon_pmu, pmu);
> +	struct parse_events_term *term;
> +
> +	assert(pmu->sysfs_aliases_loaded);
> +	list_for_each_entry(term, &terms->terms, list) {
> +		if (hwmon_pmu__config_term(hwmon_pmu, attr, term, err))
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +
> +}
> +
> +int hwmon_pmu__check_alias(struct parse_events_terms *terms, struct perf_pmu_info *info,
> +			   struct parse_events_error *err)
> +{
> +	struct parse_events_term *term =
> +		list_first_entry(&terms->terms, struct parse_events_term, list);
> +
> +	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {
> +		enum hwmon_type type;
> +		int number;
> +
> +		if (parse_hwmon_filename(term->config, &type, &number,
> +					 /*item=*/NULL, /*is_alarm=*/NULL)) {
> +			info->unit = hwmon_units[type];
> +			if (type == HWMON_TYPE_FAN || type == HWMON_TYPE_PWM ||
> +			    type == HWMON_TYPE_INTRUSION)
> +				info->scale = 1;
> +			else
> +				info->scale = 0.001;
> +		}
> +		return 0;
> +	}
> +	if (err) {
> +		char *err_str;
> +
> +		parse_events_error__handle(err, term->err_val,
> +					asprintf(&err_str,
> +						"unexpected hwmon event term (%s) %s",
> +						parse_events__term_type_str(term->type_term),
> +						term->config) < 0
> +					? strdup("unexpected hwmon event term")
> +					: err_str,

Probably better to move the asprintf() out to a statement.


> +					NULL);
> +	}
> +	return -EINVAL;
> +}
> +
> +int perf_pmus__read_hwmon_pmus(struct list_head *pmus)
> +{
> +	char *line = NULL;
> +	DIR *hwmon_dir;
> +	struct dirent *hwmon_ent;
> +	char buf[PATH_MAX];
> +	const char *sysfs = sysfs__mountpoint();
> +
> +	if (!sysfs)
> +		return 0;
> +
> +	scnprintf(buf, sizeof(buf), "%s/class/hwmon/", sysfs);
> +	hwmon_dir = opendir(buf);
> +	if (!hwmon_dir)
> +		return 0;
> +
> +	while ((hwmon_ent = readdir(hwmon_dir)) != NULL) {
> +		size_t line_len;
> +		int pmu_dir, name_fd;
> +		struct io io;
> +
> +		if (hwmon_ent->d_type != DT_LNK)
> +			continue;
> +
> +		scnprintf(buf, sizeof(buf), "%s/class/hwmon/%s", sysfs, hwmon_ent->d_name);
> +		pmu_dir = open(buf, O_DIRECTORY);
> +		if (pmu_dir == -1) {
> +			pr_debug("hwmon_pmu: not a directory: '%s/class/hwmon/%s'\n",
> +				 sysfs, hwmon_ent->d_name);
> +			continue;
> +		}
> +		name_fd = openat(pmu_dir, "name", O_RDONLY);
> +		if (name_fd == -1) {
> +			pr_debug("hwmon_pmu: failure to open '%s/class/hwmon/%s/name'\n",
> +				  sysfs, hwmon_ent->d_name);
> +			continue;

close(pmu_dir)?


> +		}
> +		io__init(&io, name_fd, buf, sizeof(buf));
> +		io__getline(&io, &line, &line_len);
> +		if (line_len > 0 && line[line_len - 1] == '\n')
> +			line[line_len - 1] = '\0';
> +		hwmon_pmu__new(pmus, pmu_dir, hwmon_ent->d_name, line);
> +		close(name_fd);
> +	}
> +	free(line);
> +	closedir(hwmon_dir);
> +	return 0;
> +}
> +
> +#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
> +
> +int evsel__hwmon_pmu_open(struct evsel *evsel,
> +			 struct perf_thread_map *threads,
> +			 int start_cpu_map_idx, int end_cpu_map_idx)
> +{
> +	struct hwmon_pmu *hwmon_pmu = container_of(evsel->pmu, struct hwmon_pmu, pmu);
> +	union hwmon_pmu_event_key key = {
> +		.type_and_num = evsel->core.attr.config,
> +	};
> +	int idx = 0, thread = 0, nthreads, err = 0;
> +
> +	nthreads = perf_thread_map__nr(threads);
> +	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
> +		for (thread = 0; thread < nthreads; thread++) {
> +			char buf[64];
> +			int fd;
> +
> +			snprintf(buf, sizeof(buf), "%s%d_input",
> +				 hwmon_type_strs[key.type], key.num);
> +
> +			fd = openat(hwmon_pmu->pmu_dir_fd, buf, O_RDONLY);
> +			FD(evsel, idx, thread) = fd;
> +			if (fd < 0) {
> +				err = -errno;
> +				goto out_close;
> +			}
> +		}
> +	}
> +	return 0;
> +out_close:
> +	if (err)
> +		threads->err_thread = thread;
> +
> +	do {
> +		while (--thread >= 0) {
> +			if (FD(evsel, idx, thread) >= 0)
> +				close(FD(evsel, idx, thread));
> +			FD(evsel, idx, thread) = -1;
> +		}
> +		thread = nthreads;
> +	} while (--idx >= 0);
> +	return err;
> +}
> +
> +int evsel__hwmon_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
> +{
> +	char buf[32];
> +	int fd;
> +	ssize_t len;
> +	struct perf_counts_values *count, *old_count = NULL;
> +
> +	if (evsel->prev_raw_counts)
> +		old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
> +
> +	count = perf_counts(evsel->counts, cpu_map_idx, thread);
> +	fd = FD(evsel, cpu_map_idx, thread);
> +	lseek(fd, SEEK_SET, 0);
> +	len = read(fd, buf, sizeof(buf));

pread() instead?


> +	if (len <= 0) {
> +		count->lost++;
> +		return -EINVAL;
> +	}
> +	buf[len] = '\0';
> +	if (old_count) {
> +		count->val = old_count->val + strtoll(buf, NULL, 10);
> +		count->run = old_count->run + 1;
> +		count->ena = old_count->ena + 1;

I'm not sure if it's meaningful to use the old value for hwmon.
Oh.. is it just to make interval logic work correctly?

Thanks,
Namhyung


> +	} else {
> +		count->val = strtoll(buf, NULL, 10);
> +		count->run++;
> +		count->ena++;
> +	}
> +	return 0;
> +}
> diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
> new file mode 100644
> index 000000000000..49e1683d5bce
> --- /dev/null
> +++ b/tools/perf/util/hwmon_pmu.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +#ifndef __HWMON_PMU_H
> +#define __HWMON_PMU_H
> +
> +#include "pmu.h"
> +
> +struct list_head;
> +
> +bool perf_pmu__is_hwmon(const struct perf_pmu *pmu);
> +bool evsel__is_hwmon(const struct evsel *evsel);
> +
> +int hwmon_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
> +size_t hwmon_pmu__num_events(struct perf_pmu *pmu);
> +bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name);
> +int hwmon_pmu__config_terms(const struct perf_pmu *pmu,
> +			    struct perf_event_attr *attr,
> +			    struct parse_events_terms *terms,
> +			    struct parse_events_error *err);
> +int hwmon_pmu__check_alias(struct parse_events_terms *terms, struct perf_pmu_info *info,
> +			   struct parse_events_error *err);
> +
> +int perf_pmus__read_hwmon_pmus(struct list_head *pmus);
> +
> +
> +int evsel__hwmon_pmu_open(struct evsel *evsel,
> +			 struct perf_thread_map *threads,
> +			 int start_cpu_map_idx, int end_cpu_map_idx);
> +int evsel__hwmon_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread);
> +
> +#endif /* __HWMON_PMU_H */
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 5ff6556292fd..c31d3409c787 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -18,6 +18,7 @@
>  #include "debug.h"
>  #include "evsel.h"
>  #include "pmu.h"
> +#include "hwmon_pmu.h"
>  #include "pmus.h"
>  #include "tool_pmu.h"
>  #include <util/pmu-bison.h>
> @@ -1529,6 +1530,9 @@ int perf_pmu__config_terms(const struct perf_pmu *pmu,
>  {
>  	struct parse_events_term *term;
>  
> +	if (perf_pmu__is_hwmon(pmu))
> +		return hwmon_pmu__config_terms(pmu, attr, terms, err);
> +
>  	list_for_each_entry(term, &terms->terms, list) {
>  		if (pmu_config_term(pmu, attr, term, terms, zero, apply_hardcoded, err))
>  			return -EINVAL;
> @@ -1661,6 +1665,11 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
>  	info->scale    = 0.0;
>  	info->snapshot = false;
>  
> +	if (perf_pmu__is_hwmon(pmu)) {
> +		ret = hwmon_pmu__check_alias(head_terms, info, err);
> +		goto out;
> +	}
> +
>  	/* Fake PMU doesn't rewrite terms. */
>  	if (perf_pmu__is_fake(pmu))
>  		goto out;
> @@ -1830,6 +1839,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
>  		return false;
>  	if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(name))
>  		return false;
> +	if (perf_pmu__is_hwmon(pmu))
> +		return hwmon_pmu__have_event(pmu, name);
>  	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
>  		return true;
>  	if (pmu->cpu_aliases_added || !pmu->events_table)
> @@ -1841,6 +1852,9 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
>  {
>  	size_t nr;
>  
> +	if (perf_pmu__is_hwmon(pmu))
> +		return hwmon_pmu__num_events(pmu);
> +
>  	pmu_aliases_parse(pmu);
>  	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
>  
> @@ -1904,6 +1918,9 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
>  	int ret = 0;
>  	struct strbuf sb;
>  
> +	if (perf_pmu__is_hwmon(pmu))
> +		return hwmon_pmu__for_each_event(pmu, state, cb);
> +
>  	strbuf_init(&sb, /*hint=*/ 0);
>  	pmu_aliases_parse(pmu);
>  	pmu_add_cpu_aliases(pmu);
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index c4ca359d4215..32f95a1060d8 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -37,6 +37,8 @@ struct perf_pmu_caps {
>  };
>  
>  enum {
> +	PERF_PMU_TYPE_HWMON_START = 0xFFFF0000,
> +	PERF_PMU_TYPE_HWMON_END   = 0xFFFFFFFD,
>  	PERF_PMU_TYPE_TOOL = 0xFFFFFFFE,
>  	PERF_PMU_TYPE_FAKE = 0xFFFFFFFF,
>  };
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 19673b9991c6..4e3b19a2db00 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -15,6 +15,7 @@
>  #include "evsel.h"
>  #include "pmus.h"
>  #include "pmu.h"
> +#include "hwmon_pmu.h"
>  #include "tool_pmu.h"
>  #include "print-events.h"
>  #include "strbuf.h"
> @@ -234,6 +235,7 @@ static void pmu_read_sysfs(bool core_only)
>  	if (!core_only) {
>  		tool_pmu = perf_pmus__tool_pmu();
>  		list_add_tail(&tool_pmu->list, &other_pmus);
> +		perf_pmus__read_hwmon_pmus(&other_pmus);
>  	}
>  	list_sort(NULL, &other_pmus, pmus_cmp);
>  	if (!list_empty(&core_pmus)) {
> -- 
> 2.46.0.469.g59c65b2a67-goog
> 

