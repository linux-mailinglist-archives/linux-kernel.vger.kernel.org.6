Return-Path: <linux-kernel+bounces-562359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9285DA62492
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07133AC85C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A07117BED0;
	Sat, 15 Mar 2025 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUEztN3U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43B33CFC;
	Sat, 15 Mar 2025 02:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742005500; cv=none; b=QUjz/KoBXwBy1kNtaMMvtw2kwhLRxPOa5lXIJz/y+gN4hkGObFMnd6wPRLfII+grCoL4ARF2+3cpgV0r5/Q5w/BaNRQNV6AwpbT+bNsg0fxB34BZmmLX3uTIhtVlRw8Hl+ZiGGCiMGIkSTwngefjSHQzpJcdee0CnmvLcgrYyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742005500; c=relaxed/simple;
	bh=+gEPJUX20F6mNU9jfnhmVQg/fLS9tul4mhb9/EeL/nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgUMyPpjBonqppgUzCNNJDbgrSQh8hklf+TnKmZG92ylZx3w1iMpIgUh2s8sXUO7iNG17Zmw59zfhhmDjmEDq5r5pTgeLlmLKB7DafOa6JtzplxR5/Z+q8CfcZ86l6kD/kjMOc3A0BT4Xgd65EeQElKY+4o/c06lR1Ql3y8jSns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUEztN3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2FCC4CEE3;
	Sat, 15 Mar 2025 02:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742005499;
	bh=+gEPJUX20F6mNU9jfnhmVQg/fLS9tul4mhb9/EeL/nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUEztN3U3rH0gMOXUoYpzc2Siw+5oh6RE/5dJeNEJXj1EU2rasb2pPGE9pwlOD3sF
	 MpMAYVjdRKoykOZKXizAwqHl7u3Zv9xWZ62BsJr3qvF79GaAs0E5joou/qTEhvt7lV
	 DTkinrlYsnKB9nUygaTmSiomvEKLX+q2aZzMDYVlarKIcPrXfSxlAgJ5asv98jvrDv
	 28ypZWmHaKO1JNSIsZc+W4NFy3UEPlksYiX42lhCMH6vFbs2lI4pBuSdCwfNN6FsLe
	 tkabsKv9Huvln6VbxkMhqH/DIWNuEeTjDDFKNuuja9rhD20+bC3TLQF+kxC3zJb6xk
	 3WpnkT8k1zCJQ==
Date: Fri, 14 Mar 2025 19:24:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	irogers@google.com, james.clark@arm.com, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
	ananth.narayan@amd.com, sandipan.das@amd.com,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v3 1/8] perf sched stats: Add record and rawdump support
Message-ID: <Z9Tk-HFcMVvDViiO@google.com>
References: <20250311120230.61774-1-swapnil.sapkal@amd.com>
 <20250311120230.61774-2-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311120230.61774-2-swapnil.sapkal@amd.com>

Hello,

On Tue, Mar 11, 2025 at 12:02:23PM +0000, Swapnil Sapkal wrote:
> Define new, perf tool only, sample types and their layouts. Add logic
> to parse /proc/schedstat, convert it to perf sample format and save
> samples to perf.data file with `perf sched stats record` command. Also
> add logic to read perf.data file, interpret schedstat samples and
> print rawdump of samples with `perf script -D`.
> 
> Note that, /proc/schedstat file output is standardized with version
> number. The patch supports v15 but older or newer version can be added
> easily.
> 
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>  tools/lib/perf/Documentation/libperf.txt    |   2 +
>  tools/lib/perf/Makefile                     |   2 +-
>  tools/lib/perf/include/perf/event.h         |  42 ++++
>  tools/lib/perf/include/perf/schedstat-v15.h |  52 +++++
>  tools/perf/builtin-inject.c                 |   2 +
>  tools/perf/builtin-sched.c                  | 226 +++++++++++++++++-
>  tools/perf/util/event.c                     |  98 ++++++++
>  tools/perf/util/event.h                     |   2 +
>  tools/perf/util/session.c                   |  20 ++
>  tools/perf/util/synthetic-events.c          | 239 ++++++++++++++++++++
>  tools/perf/util/synthetic-events.h          |   3 +
>  tools/perf/util/tool.c                      |  20 ++
>  tools/perf/util/tool.h                      |   4 +-
>  13 files changed, 709 insertions(+), 3 deletions(-)
>  create mode 100644 tools/lib/perf/include/perf/schedstat-v15.h
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index 59aabdd3cabf..3f295639903d 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -210,6 +210,8 @@ SYNOPSIS
>    struct perf_record_time_conv;
>    struct perf_record_header_feature;
>    struct perf_record_compressed;
> +  struct perf_record_schedstat_cpu;
> +  struct perf_record_schedstat_domain;
>  --
>  
>  DESCRIPTION
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index e9a7ac2c062e..4b60804aa0b6 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -174,7 +174,7 @@ install_lib: libs
>  		$(call do_install_mkdir,$(libdir_SQ)); \
>  		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
>  
> -HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
> +HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-v15.h
>  INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
>  
>  INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index 37bb7771d914..189106874063 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -457,6 +457,44 @@ struct perf_record_compressed {
>  	char			 data[];
>  };
>  
> +struct perf_record_schedstat_cpu_v15 {
> +#define CPU_FIELD(_type, _name, _ver)		_type _name
> +#include "schedstat-v15.h"
> +#undef CPU_FIELD
> +};
> +
> +struct perf_record_schedstat_cpu {
> +	struct perf_event_header header;
> +	__u64			 timestamp;
> +	union {
> +		struct perf_record_schedstat_cpu_v15 v15;
> +	};
> +	__u32			 cpu;
> +	__u16			 version;

Why not putting these before the union?  I think it'll have variable
size once you add different versions then it'd be hard to access the
fields after union.  You may want to add a padding explicitly.

> +};
> +
> +struct perf_record_schedstat_domain_v15 {
> +#define DOMAIN_FIELD(_type, _name, _ver)	_type _name
> +#include "schedstat-v15.h"
> +#undef DOMAIN_FIELD
> +};
> +
> +#define DOMAIN_NAME_LEN		16
> +
> +struct perf_record_schedstat_domain {
> +	struct perf_event_header header;
> +	__u16			 version;
> +	__u64			 timestamp;
> +	__u32			 cpu;
> +	__u16			 domain;

If this has similar information for schedstat_cpu, I think it's better
to start with the same layout.  And having version before timestamp
would add unnecessary paddings.


> +	char			 name[DOMAIN_NAME_LEN];
> +	union {
> +		struct perf_record_schedstat_domain_v15 v15;
> +	};
> +	__u16			 nr_cpus;
> +	__u8			 cpu_mask[];

Does cpu_mask represent the domain membership?  Maybe you can split
those info into a separate record or put it in a header feature like
we have topology information there.


> +};
> +
>  enum perf_user_event_type { /* above any possible kernel type */
>  	PERF_RECORD_USER_TYPE_START		= 64,
>  	PERF_RECORD_HEADER_ATTR			= 64,
> @@ -478,6 +516,8 @@ enum perf_user_event_type { /* above any possible kernel type */
>  	PERF_RECORD_HEADER_FEATURE		= 80,
>  	PERF_RECORD_COMPRESSED			= 81,
>  	PERF_RECORD_FINISHED_INIT		= 82,
> +	PERF_RECORD_SCHEDSTAT_CPU		= 83,
> +	PERF_RECORD_SCHEDSTAT_DOMAIN		= 84,
>  	PERF_RECORD_HEADER_MAX
>  };
>  
> @@ -518,6 +558,8 @@ union perf_event {
>  	struct perf_record_time_conv		time_conv;
>  	struct perf_record_header_feature	feat;
>  	struct perf_record_compressed		pack;
> +	struct perf_record_schedstat_cpu	schedstat_cpu;
> +	struct perf_record_schedstat_domain	schedstat_domain;
>  };
>  
>  #endif /* __LIBPERF_EVENT_H */
> diff --git a/tools/lib/perf/include/perf/schedstat-v15.h b/tools/lib/perf/include/perf/schedstat-v15.h
> new file mode 100644
> index 000000000000..43f8060c5337
> --- /dev/null
> +++ b/tools/lib/perf/include/perf/schedstat-v15.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifdef CPU_FIELD
> +CPU_FIELD(__u32, yld_count, v15);
> +CPU_FIELD(__u32, array_exp, v15);
> +CPU_FIELD(__u32, sched_count, v15);
> +CPU_FIELD(__u32, sched_goidle, v15);
> +CPU_FIELD(__u32, ttwu_count, v15);
> +CPU_FIELD(__u32, ttwu_local, v15);
> +CPU_FIELD(__u64, rq_cpu_time, v15);
> +CPU_FIELD(__u64, run_delay, v15);
> +CPU_FIELD(__u64, pcount, v15);
> +#endif
> +
> +#ifdef DOMAIN_FIELD
> +DOMAIN_FIELD(__u32, idle_lb_count, v15);
> +DOMAIN_FIELD(__u32, idle_lb_balanced, v15);
> +DOMAIN_FIELD(__u32, idle_lb_failed, v15);
> +DOMAIN_FIELD(__u32, idle_lb_imbalance, v15);
> +DOMAIN_FIELD(__u32, idle_lb_gained, v15);
> +DOMAIN_FIELD(__u32, idle_lb_hot_gained, v15);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyq, v15);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyg, v15);
> +DOMAIN_FIELD(__u32, busy_lb_count, v15);
> +DOMAIN_FIELD(__u32, busy_lb_balanced, v15);
> +DOMAIN_FIELD(__u32, busy_lb_failed, v15);
> +DOMAIN_FIELD(__u32, busy_lb_imbalance, v15);
> +DOMAIN_FIELD(__u32, busy_lb_gained, v15);
> +DOMAIN_FIELD(__u32, busy_lb_hot_gained, v15);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyq, v15);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyg, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_count, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_balanced, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_failed, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_gained, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v15);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v15);
> +DOMAIN_FIELD(__u32, alb_count, v15);
> +DOMAIN_FIELD(__u32, alb_failed, v15);
> +DOMAIN_FIELD(__u32, alb_pushed, v15);
> +DOMAIN_FIELD(__u32, sbe_count, v15);
> +DOMAIN_FIELD(__u32, sbe_balanced, v15);
> +DOMAIN_FIELD(__u32, sbe_pushed, v15);
> +DOMAIN_FIELD(__u32, sbf_count, v15);
> +DOMAIN_FIELD(__u32, sbf_balanced, v15);
> +DOMAIN_FIELD(__u32, sbf_pushed, v15);
> +DOMAIN_FIELD(__u32, ttwu_wake_remote, v15);
> +DOMAIN_FIELD(__u32, ttwu_move_affine, v15);
> +DOMAIN_FIELD(__u32, ttwu_move_balance, v15);
> +#endif
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 11e49cafa3af..af1add2abf72 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2530,6 +2530,8 @@ int cmd_inject(int argc, const char **argv)
>  	inject.tool.finished_init	= perf_event__repipe_op2_synth;
>  	inject.tool.compressed		= perf_event__repipe_op4_synth;
>  	inject.tool.auxtrace		= perf_event__repipe_auxtrace;
> +	inject.tool.schedstat_cpu	= perf_event__repipe_op2_synth;
> +	inject.tool.schedstat_domain	= perf_event__repipe_op2_synth;
>  	inject.tool.dont_split_sample_group = true;
>  	inject.session = __perf_session__new(&data, &inject.tool,
>  					     /*trace_event_repipe=*/inject.output.is_pipe);
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 26ece6e9bfd1..1c3b56013164 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -28,6 +28,8 @@
>  #include "util/debug.h"
>  #include "util/event.h"
>  #include "util/util.h"
> +#include "util/synthetic-events.h"
> +#include "util/target.h"
>  
>  #include <linux/kernel.h>
>  #include <linux/log2.h>
> @@ -55,6 +57,7 @@
>  #define MAX_PRIO		140
>  
>  static const char *cpu_list;
> +static struct perf_cpu_map *user_requested_cpus;

I guess this can be in evlist.


>  static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
>  
>  struct sched_atom;
> @@ -236,6 +239,9 @@ struct perf_sched {
>  	volatile bool   thread_funcs_exit;
>  	const char	*prio_str;
>  	DECLARE_BITMAP(prio_bitmap, MAX_PRIO);
> +
> +	struct perf_session *session;
> +	struct perf_data *data;
>  };
>  
>  /* per thread run time data */
> @@ -3670,6 +3676,199 @@ static void setup_sorting(struct perf_sched *sched, const struct option *options
>  	sort_dimension__add("pid", &sched->cmp_pid);
>  }
>  
> +static int process_synthesized_schedstat_event(const struct perf_tool *tool,
> +					       union perf_event *event,
> +					       struct perf_sample *sample __maybe_unused,
> +					       struct machine *machine __maybe_unused)
> +{
> +	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
> +
> +	if (perf_data__write(sched->data, event, event->header.size) <= 0) {
> +		pr_err("failed to write perf data, error: %m\n");
> +		return -1;
> +	}
> +
> +	sched->session->header.data_size += event->header.size;
> +	return 0;
> +}
> +
> +static void sighandler(int sig __maybe_unused)
> +{
> +}
> +
> +static int enable_sched_schedstats(int *reset)
> +{
> +	char path[PATH_MAX];
> +	FILE *fp;
> +	char ch;
> +
> +	snprintf(path, PATH_MAX, "%s/sys/kernel/sched_schedstats", procfs__mountpoint());
> +	fp = fopen(path, "w+");
> +	if (!fp) {
> +		pr_err("Failed to open %s\n", path);
> +		return -1;
> +	}
> +
> +	ch = getc(fp);
> +	if (ch == '0') {
> +		*reset = 1;
> +		rewind(fp);
> +		putc('1', fp);
> +		fclose(fp);
> +	}
> +	return 0;
> +}
> +
> +static int disable_sched_schedstat(void)
> +{
> +	char path[PATH_MAX];
> +	FILE *fp;
> +
> +	snprintf(path, PATH_MAX, "%s/sys/kernel/sched_schedstats", procfs__mountpoint());
> +	fp = fopen(path, "w");
> +	if (!fp) {
> +		pr_err("Failed to open %s\n", path);
> +		return -1;
> +	}
> +
> +	putc('0', fp);
> +	fclose(fp);
> +	return 0;
> +}
> +
> +/* perf.data or any other output file name used by stats subcommand (only). */
> +const char *output_name;
> +
> +static int perf_sched__schedstat_record(struct perf_sched *sched,
> +					int argc, const char **argv)
> +{
> +	struct perf_session *session;
> +	struct evlist *evlist;
> +	struct target *target;
> +	int reset = 0;
> +	int err = 0;
> +	int fd;
> +	struct perf_data data = {
> +		.path  = output_name,
> +		.mode  = PERF_DATA_MODE_WRITE,
> +	};
> +
> +	signal(SIGINT, sighandler);
> +	signal(SIGCHLD, sighandler);
> +	signal(SIGTERM, sighandler);
> +
> +	evlist = evlist__new();
> +	if (!evlist)
> +		return -ENOMEM;
> +
> +	session = perf_session__new(&data, &sched->tool);
> +	if (IS_ERR(session)) {
> +		pr_err("Perf session creation failed.\n");

Also need evlist__delete().


> +		return PTR_ERR(session);
> +	}
> +
> +	session->evlist = evlist;
> +
> +	sched->session = session;
> +	sched->data = &data;
> +
> +	fd = perf_data__fd(&data);
> +
> +	/*
> +	 * Capture all important metadata about the system. Although they are
> +	 * not used by `perf sched stats` tool directly, they provide useful
> +	 * information about profiled environment.
> +	 */
> +	perf_header__set_feat(&session->header, HEADER_HOSTNAME);
> +	perf_header__set_feat(&session->header, HEADER_OSRELEASE);
> +	perf_header__set_feat(&session->header, HEADER_VERSION);
> +	perf_header__set_feat(&session->header, HEADER_ARCH);
> +	perf_header__set_feat(&session->header, HEADER_NRCPUS);
> +	perf_header__set_feat(&session->header, HEADER_CPUDESC);
> +	perf_header__set_feat(&session->header, HEADER_CPUID);
> +	perf_header__set_feat(&session->header, HEADER_TOTAL_MEM);
> +	perf_header__set_feat(&session->header, HEADER_CMDLINE);
> +	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
> +	perf_header__set_feat(&session->header, HEADER_NUMA_TOPOLOGY);
> +	perf_header__set_feat(&session->header, HEADER_CACHE);
> +	perf_header__set_feat(&session->header, HEADER_MEM_TOPOLOGY);
> +	perf_header__set_feat(&session->header, HEADER_CPU_PMU_CAPS);
> +	perf_header__set_feat(&session->header, HEADER_HYBRID_TOPOLOGY);
> +	perf_header__set_feat(&session->header, HEADER_PMU_CAPS);

Probably you don't need {CPU_,}PMU_CAPS.  Also I wonder if it's possible
to add cpu-domain info here.

> +
> +	err = perf_session__write_header(session, evlist, fd, false);
> +	if (err < 0)
> +		goto out;
> +
> +	/*
> +	 * `perf sched stats` does not support workload profiling (-p pid)
> +	 * since /proc/schedstat file contains cpu specific data only. Hence, a
> +	 * profile target is either set of cpus or systemwide, never a process.
> +	 * Note that, although `-- <workload>` is supported, profile data are
> +	 * still cpu/systemwide.
> +	 */
> +	target = zalloc(sizeof(struct target));

It seems no need to alloc the target, just putting it on stack would be
fine.


> +	if (cpu_list)
> +		target->cpu_list = cpu_list;
> +	else
> +		target->system_wide = true;
> +
> +	if (argc) {
> +		err = evlist__prepare_workload(evlist, target, argv, false, NULL);
> +		if (err)
> +			goto out_target;
> +	}
> +
> +	if (cpu_list) {
> +		user_requested_cpus = perf_cpu_map__new(cpu_list);

Where is this freed?


> +		if (!user_requested_cpus)
> +			goto out_target;
> +	}
> +
> +	err = perf_event__synthesize_schedstat(&(sched->tool),
> +					       process_synthesized_schedstat_event,
> +					       user_requested_cpus);
> +	if (err < 0)
> +		goto out_target;
> +
> +	err = enable_sched_schedstats(&reset);
> +	if (err < 0)
> +		goto out_target;
> +
> +	if (argc)
> +		evlist__start_workload(evlist);
> +
> +	/* wait for signal */
> +	pause();
> +
> +	if (reset) {
> +		err = disable_sched_schedstat();
> +		if (err < 0)
> +			goto out_target;
> +	}
> +
> +	err = perf_event__synthesize_schedstat(&(sched->tool),
> +					       process_synthesized_schedstat_event,
> +					       user_requested_cpus);
> +	if (err < 0)
> +		goto out_target;
> +
> +	err = perf_session__write_header(session, evlist, fd, true);
> +
> +out_target:
> +	free(target);
> +out:
> +	if (!err)
> +		fprintf(stderr, "[ perf sched stats: Wrote samples to %s ]\n", data.path);
> +	else
> +		fprintf(stderr, "[ perf sched stats: Failed !! ]\n");
> +
> +	close(fd);
> +	perf_session__delete(session);

It seems session->evlist is deleted only when the data is in read mode.

> +
> +	return err;
> +}
> +
>  static bool schedstat_events_exposed(void)
>  {
>  	/*
> @@ -3846,6 +4045,12 @@ int cmd_sched(int argc, const char **argv)
>  	OPT_BOOLEAN('P', "pre-migrations", &sched.pre_migrations, "Show pre-migration wait time"),
>  	OPT_PARENT(sched_options)
>  	};
> +	const struct option stats_options[] = {
> +	OPT_STRING('o', "output", &output_name, "file",
> +		   "`stats record` with output filename"),
> +	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
> +	OPT_END()
> +	};
>  
>  	const char * const latency_usage[] = {
>  		"perf sched latency [<options>]",
> @@ -3863,9 +4068,13 @@ int cmd_sched(int argc, const char **argv)
>  		"perf sched timehist [<options>]",
>  		NULL
>  	};
> +	const char *stats_usage[] = {
> +		"perf sched stats {record} [<options>]",
> +		NULL
> +	};
>  	const char *const sched_subcommands[] = { "record", "latency", "map",
>  						  "replay", "script",
> -						  "timehist", NULL };
> +						  "timehist", "stats", NULL };
>  	const char *sched_usage[] = {
>  		NULL,
>  		NULL
> @@ -3961,6 +4170,21 @@ int cmd_sched(int argc, const char **argv)
>  			return ret;
>  
>  		return perf_sched__timehist(&sched);
> +	} else if (!strcmp(argv[0], "stats")) {
> +		const char *const stats_subcommands[] = {"record", NULL};
> +
> +		argc = parse_options_subcommand(argc, argv, stats_options,
> +						stats_subcommands,
> +						stats_usage,
> +						PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +		if (argv[0] && !strcmp(argv[0], "record")) {
> +			if (argc)
> +				argc = parse_options(argc, argv, stats_options,
> +						     stats_usage, 0);
> +			return perf_sched__schedstat_record(&sched, argc, argv);
> +		}
> +		usage_with_options(stats_usage, stats_options);
>  	} else {
>  		usage_with_options(sched_usage, sched_options);
>  	}
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index aac96d5d1917..0f863d38abe2 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -77,6 +77,8 @@ static const char *perf_event__names[] = {
>  	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
>  	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
>  	[PERF_RECORD_FINISHED_INIT]		= "FINISHED_INIT",
> +	[PERF_RECORD_SCHEDSTAT_CPU]		= "SCHEDSTAT_CPU",
> +	[PERF_RECORD_SCHEDSTAT_DOMAIN]		= "SCHEDSTAT_DOMAIN",
>  };
>  
>  const char *perf_event__name(unsigned int id)
> @@ -550,6 +552,102 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *ma
>  	return ret;
>  }
>  
> +size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
> +{
> +	struct perf_record_schedstat_cpu *cs = &event->schedstat_cpu;
> +	__u16 version = cs->version;
> +	size_t size = 0;
> +
> +	size = fprintf(fp, "\ncpu%u ", cs->cpu);
> +
> +#define CPU_FIELD(_type, _name, _ver)						\
> +	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)cs->_ver._name)
> +
> +	if (version == 15) {
> +#include <perf/schedstat-v15.h>
> +		return size;
> +	}
> +#undef CPU_FIELD
> +
> +	return fprintf(fp, "Unsupported /proc/schedstat version %d.\n",
> +		       event->schedstat_cpu.version);
> +}
> +
> +size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
> +{
> +	struct perf_record_schedstat_domain *ds = &event->schedstat_domain;
> +	__u16 version = ds->version;
> +	size_t cpu_mask_len_2;
> +	size_t cpu_mask_len;
> +	size_t size = 0;
> +	char *cpu_mask;
> +	int idx;
> +	int i, j;
> +	bool low;
> +
> +	if (ds->name[0])
> +		size = fprintf(fp, "\ndomain%u:%s ", ds->domain, ds->name);
> +	else
> +		size = fprintf(fp, "\ndomain%u ", ds->domain);
> +
> +	cpu_mask_len = ((ds->nr_cpus + 3) >> 2);
> +	cpu_mask_len_2 = cpu_mask_len + ((cpu_mask_len - 1) / 8);
> +
> +	cpu_mask = zalloc(cpu_mask_len_2 + 1);
> +	if (!cpu_mask)
> +		return fprintf(fp, "Cannot allocate memory for cpumask\n");
> +
> +	idx = ((ds->nr_cpus + 7) >> 3) - 1;
> +
> +	i = cpu_mask_len_2 - 1;
> +
> +	low = true;
> +	j = 1;
> +	while (i >= 0) {
> +		__u8 m;
> +
> +		if (low)
> +			m = ds->cpu_mask[idx] & 0xf;
> +		else
> +			m = (ds->cpu_mask[idx] & 0xf0) >> 4;
> +
> +		if (m >= 0 && m <= 9)
> +			m += '0';
> +		else if (m >= 0xa && m <= 0xf)
> +			m = m + 'a' - 10;
> +		else if (m >= 0xA && m <= 0xF)
> +			m = m + 'A' - 10;
> +
> +		cpu_mask[i] = m;
> +
> +		if (j == 8 && i != 0) {
> +			cpu_mask[i - 1] = ',';
> +			j = 0;
> +			i--;
> +		}
> +
> +		if (!low)
> +			idx--;
> +		low = !low;
> +		i--;
> +		j++;
> +	}
> +	size += fprintf(fp, "%s ", cpu_mask);
> +	free(cpu_mask);
> +
> +#define DOMAIN_FIELD(_type, _name, _ver)					\
> +	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)ds->_ver._name)
> +
> +	if (version == 15) {
> +#include <perf/schedstat-v15.h>
> +		return size;
> +	}
> +#undef DOMAIN_FIELD
> +
> +	return fprintf(fp, "Unsupported /proc/schedstat version %d.\n",
> +		       event->schedstat_domain.version);
> +}
> +
>  size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FILE *fp)
>  {
>  	size_t ret = fprintf(fp, "PERF_RECORD_%s",
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index 2744c54f404e..333f2405cd5a 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -361,6 +361,8 @@ size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *machine,FILE *fp);
> +size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp);
> +size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FILE *fp);
>  
>  int kallsyms__get_function_start(const char *kallsyms_filename,
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index c06e3020a976..bcffee2b7239 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -692,6 +692,20 @@ static void perf_event__time_conv_swap(union perf_event *event,
>  	}
>  }
>  
> +static void
> +perf_event__schedstat_cpu_swap(union perf_event *event __maybe_unused,
> +			       bool sample_id_all __maybe_unused)
> +{
> +	/* FIXME */
> +}
> +
> +static void
> +perf_event__schedstat_domain_swap(union perf_event *event __maybe_unused,
> +				  bool sample_id_all __maybe_unused)
> +{
> +	/* FIXME */
> +}
> +
>  typedef void (*perf_event__swap_op)(union perf_event *event,
>  				    bool sample_id_all);
>  
> @@ -730,6 +744,8 @@ static perf_event__swap_op perf_event__swap_ops[] = {
>  	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
>  	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
>  	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
> +	[PERF_RECORD_SCHEDSTAT_CPU]	  = perf_event__schedstat_cpu_swap,
> +	[PERF_RECORD_SCHEDSTAT_DOMAIN]	  = perf_event__schedstat_domain_swap,
>  	[PERF_RECORD_HEADER_MAX]	  = NULL,
>  };
>  
> @@ -1455,6 +1471,10 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>  		return err;
>  	case PERF_RECORD_FINISHED_INIT:
>  		return tool->finished_init(session, event);
> +	case PERF_RECORD_SCHEDSTAT_CPU:
> +		return tool->schedstat_cpu(session, event);
> +	case PERF_RECORD_SCHEDSTAT_DOMAIN:
> +		return tool->schedstat_domain(session, event);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 6923b0d5efed..f928f07bea15 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2511,3 +2511,242 @@ int parse_synth_opt(char *synth)
>  
>  	return ret;
>  }
> +
> +static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version,
> +						    __u64 *cpu, __u64 timestamp)
> +{
> +	struct perf_record_schedstat_cpu *cs;
> +	union perf_event *event;
> +	size_t size;
> +	char ch;
> +
> +	size = sizeof(struct perf_record_schedstat_cpu);

I think the kernel code prefers sizeof(*cs) instead.


> +	size = PERF_ALIGN(size, sizeof(u64));
> +	event = zalloc(size);

The size is static, do you really need a dynamic allocation?

Thanks,
Namhyung

> +
> +	if (!event)
> +		return NULL;
> +
> +	cs = &event->schedstat_cpu;
> +	cs->header.type = PERF_RECORD_SCHEDSTAT_CPU;
> +	cs->header.size = size;
> +	cs->timestamp = timestamp;
> +
> +	if (io__get_char(io) != 'p' || io__get_char(io) != 'u')
> +		goto out_cpu;
> +
> +	if (io__get_dec(io, (__u64 *)cpu) != ' ')
> +		goto out_cpu;
> +
> +#define CPU_FIELD(_type, _name, _ver)					\
> +	do {								\
> +		__u64 _tmp;						\
> +		ch = io__get_dec(io, &_tmp);				\
> +		if (ch != ' ' && ch != '\n')				\
> +			goto out_cpu;					\
> +		cs->_ver._name = _tmp;					\
> +	} while (0)
> +
> +	if (version == 15) {
> +#include <perf/schedstat-v15.h>
> +	}
> +#undef CPU_FIELD
> +
> +	cs->cpu = *cpu;
> +	cs->version = version;
> +
> +	return event;
> +out_cpu:
> +	free(event);
> +	return NULL;
> +}
> +
> +static size_t schedstat_sanitize_cpumask(char *cpu_mask, size_t cpu_mask_len)
> +{
> +	char *dst = cpu_mask;
> +	char *src = cpu_mask;
> +	int i = 0;
> +
> +	for ( ; src < cpu_mask + cpu_mask_len; dst++, src++) {
> +		while (*src == ',')
> +			src++;
> +
> +		*dst = *src;
> +	}
> +
> +	for ( ; dst < src; dst++, i++)
> +		*dst = '\0';
> +
> +	return cpu_mask_len - i;
> +}
> +
> +static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 version,
> +						       __u64 cpu, __u64 timestamp)
> +{
> +	struct perf_env env = { .total_mem = 0, };
> +	int nr_cpus_avail = perf_env__nr_cpus_avail(&env);
> +	struct perf_record_schedstat_domain *ds;
> +	union perf_event *event;
> +	char *d_name = NULL;
> +	size_t cpu_mask_len = 0;
> +	char *cpu_mask = NULL;
> +	__u64 d_num;
> +	size_t size;
> +	int i = 0;
> +	bool low;
> +	char ch;
> +	int idx;
> +
> +	if (io__get_char(io) != 'o' || io__get_char(io) != 'm' || io__get_char(io) != 'a' ||
> +	    io__get_char(io) != 'i' || io__get_char(io) != 'n')
> +		return NULL;
> +
> +	ch = io__get_dec(io, &d_num);
> +
> +	if (io__getdelim(io, &cpu_mask, &cpu_mask_len, ' ') < 0 || !cpu_mask_len)
> +		goto out;
> +
> +	cpu_mask[cpu_mask_len - 1] = '\0';
> +	cpu_mask_len--;
> +	cpu_mask_len = schedstat_sanitize_cpumask(cpu_mask, cpu_mask_len);
> +
> +	size = sizeof(struct perf_record_schedstat_domain) + ((nr_cpus_avail + 7) >> 3);
> +	size = PERF_ALIGN(size, sizeof(u64));
> +	event = zalloc(size);
> +
> +	if (!event)
> +		goto out_cpu_mask;
> +
> +	ds = &event->schedstat_domain;
> +	ds->header.type = PERF_RECORD_SCHEDSTAT_DOMAIN;
> +	ds->header.size = size;
> +	ds->version = version;
> +	ds->timestamp = timestamp;
> +	if (d_name)
> +		strncpy(ds->name, d_name, DOMAIN_NAME_LEN - 1);
> +	ds->domain = d_num;
> +	ds->nr_cpus = nr_cpus_avail;
> +
> +	idx = ((nr_cpus_avail + 7) >> 3) - 1;
> +	low = true;
> +	for (i = cpu_mask_len - 1; i >= 0 && idx >= 0; i--) {
> +		char mask = cpu_mask[i];
> +
> +		if (mask >= '0' && mask <= '9')
> +			mask -= '0';
> +		else if (mask >= 'a' && mask <= 'f')
> +			mask = mask - 'a' + 10;
> +		else if (mask >= 'A' && mask <= 'F')
> +			mask = mask - 'A' + 10;
> +
> +		if (low) {
> +			ds->cpu_mask[idx] = mask;
> +		} else {
> +			ds->cpu_mask[idx] |= (mask << 4);
> +			idx--;
> +		}
> +		low = !low;
> +	}
> +
> +	free(cpu_mask);
> +
> +#define DOMAIN_FIELD(_type, _name, _ver)				\
> +	do {								\
> +		__u64 _tmp;						\
> +		ch = io__get_dec(io, &_tmp);				\
> +		if (ch != ' ' && ch != '\n')				\
> +			goto out_domain;				\
> +		ds->_ver._name = _tmp;					\
> +	} while (0)
> +
> +	if (version == 15) {
> +#include <perf/schedstat-v15.h>
> +	}
> +#undef DOMAIN_FIELD
> +
> +	ds->cpu = cpu;
> +	return event;
> +
> +out_domain:
> +	free(event);
> +out_cpu_mask:
> +	free(cpu_mask);
> +out:
> +	return NULL;
> +}
> +
> +int perf_event__synthesize_schedstat(const struct perf_tool *tool,
> +				     perf_event__handler_t process,
> +				     struct perf_cpu_map *user_requested_cpus)
> +{
> +	char *line = NULL, path[PATH_MAX];
> +	union perf_event *event = NULL;
> +	size_t line_len = 0;
> +	char bf[BUFSIZ];
> +	__u64 timestamp;
> +	__u64 cpu = -1;
> +	__u16 version;
> +	struct io io;
> +	int ret = -1;
> +	char ch;
> +
> +	snprintf(path, PATH_MAX, "%s/schedstat", procfs__mountpoint());
> +	io.fd = open(path, O_RDONLY, 0);
> +	if (io.fd < 0) {
> +		pr_err("Failed to open %s. Possibly CONFIG_SCHEDSTAT is disabled.\n", path);
> +		return -1;
> +	}
> +	io__init(&io, io.fd, bf, sizeof(bf));
> +
> +	if (io__getline(&io, &line, &line_len) < 0 || !line_len)
> +		goto out;
> +
> +	if (!strcmp(line, "version 15\n")) {
> +		version = 15;
> +	} else {
> +		pr_err("Unsupported %s version: %s", path, line + 8);
> +		goto out_free_line;
> +	}
> +
> +	if (io__getline(&io, &line, &line_len) < 0 || !line_len)
> +		goto out_free_line;
> +	timestamp = atol(line + 10);
> +
> +	/*
> +	 * FIXME: Can be optimized a bit by not synthesizing domain samples
> +	 * for filtered out cpus.
> +	 */
> +	for (ch = io__get_char(&io); !io.eof; ch = io__get_char(&io)) {
> +		struct perf_cpu this_cpu;
> +
> +		if (ch == 'c') {
> +			event = __synthesize_schedstat_cpu(&io, version,
> +							   &cpu, timestamp);
> +		} else if (ch == 'd') {
> +			event = __synthesize_schedstat_domain(&io, version,
> +							      cpu, timestamp);
> +		}
> +		if (!event)
> +			goto out_free_line;
> +
> +		this_cpu.cpu = cpu;
> +
> +		if (user_requested_cpus && !perf_cpu_map__has(user_requested_cpus, this_cpu))
> +			continue;
> +
> +		if (process(tool, event, NULL, NULL) < 0) {
> +			free(event);
> +			goto out_free_line;
> +		}
> +
> +		free(event);
> +	}
> +
> +	ret = 0;
> +
> +out_free_line:
> +	free(line);
> +out:
> +	close(io.fd);
> +	return ret;
> +}
> diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
> index b9c936b5cfeb..eab914c238df 100644
> --- a/tools/perf/util/synthetic-events.h
> +++ b/tools/perf/util/synthetic-events.h
> @@ -141,4 +141,7 @@ int perf_event__synthesize_for_pipe(const struct perf_tool *tool,
>  				    struct perf_data *data,
>  				    perf_event__handler_t process);
>  
> +int perf_event__synthesize_schedstat(const struct perf_tool *tool,
> +				     perf_event__handler_t process,
> +				     struct perf_cpu_map *user_requested_cpu);
>  #endif // __PERF_SYNTHETIC_EVENTS_H
> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> index 3b7f390f26eb..9f81d720735f 100644
> --- a/tools/perf/util/tool.c
> +++ b/tools/perf/util/tool.c
> @@ -230,6 +230,24 @@ static int perf_session__process_compressed_event_stub(struct perf_session *sess
>  	return 0;
>  }
>  
> +static int process_schedstat_cpu_stub(struct perf_session *perf_session __maybe_unused,
> +				      union perf_event *event)
> +{
> +	if (dump_trace)
> +		perf_event__fprintf_schedstat_cpu(event, stdout);
> +	dump_printf(": unhandled!\n");
> +	return 0;
> +}
> +
> +static int process_schedstat_domain_stub(struct perf_session *perf_session __maybe_unused,
> +					 union perf_event *event)
> +{
> +	if (dump_trace)
> +		perf_event__fprintf_schedstat_domain(event, stdout);
> +	dump_printf(": unhandled!\n");
> +	return 0;
> +}
> +
>  void perf_tool__init(struct perf_tool *tool, bool ordered_events)
>  {
>  	tool->ordered_events = ordered_events;
> @@ -286,6 +304,8 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
>  	tool->compressed = perf_session__process_compressed_event_stub;
>  #endif
>  	tool->finished_init = process_event_op2_stub;
> +	tool->schedstat_cpu = process_schedstat_cpu_stub;
> +	tool->schedstat_domain = process_schedstat_domain_stub;
>  }
>  
>  bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index db1c7642b0d1..d289a5396b01 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -77,7 +77,9 @@ struct perf_tool {
>  			stat,
>  			stat_round,
>  			feature,
> -			finished_init;
> +			finished_init,
> +			schedstat_cpu,
> +			schedstat_domain;
>  	event_op4	compressed;
>  	event_op3	auxtrace;
>  	bool		ordered_events;
> -- 
> 2.43.0
> 

