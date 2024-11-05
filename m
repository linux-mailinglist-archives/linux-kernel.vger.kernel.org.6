Return-Path: <linux-kernel+bounces-396886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA849BD3B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAA12849E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50CC1E6316;
	Tue,  5 Nov 2024 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngI4+POv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B51188703;
	Tue,  5 Nov 2024 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828716; cv=none; b=MA/VRXByp39r2PCGLv4NI+aiE5PopvSGQad6A3UYPmkZr1GIcnPQiOeb5BK8MLPuBGaqP1GQcEULXNdHMs0FNdkBO+3CdErUHak//mzpgv9crRDsN5PtDMmiIwlJpiLwzipJW48J+Y+Hh1oE0KzosGTx0bKkrq+kf9QI+IWKVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828716; c=relaxed/simple;
	bh=NMylTTk75XNfB6KH+l+siRGLPjelpm/Cl8oMQn0fsiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixolFbkvGpvTjyTRnaQL41nmR5rjCFHFo7kCHvqbaZY2L6fzy9tAPN4Qun51wv0qd0/LvOQwx5wNpP4ca61cXzafZLmMoJgnAJmfKUaqSuDdqAYfTuQUO6C+X3FUvvgpvDTGGfPkWKH54eiJUaigEYnAi2gWBjI9YU0Qwo6sSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngI4+POv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B602C4CED3;
	Tue,  5 Nov 2024 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730828715;
	bh=NMylTTk75XNfB6KH+l+siRGLPjelpm/Cl8oMQn0fsiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngI4+POvWxcqfhaUkUhVZSwDo0Wdizgy51f7ucQsIeSnzeJKp3feYnLe+W+xkpO/q
	 6Ns8LHhVv++sIU7kHqCuFMkka4nDk5yoFMVTpvhjG0ubGKfrg1rG32uw2Nf7zuyo5x
	 lDvgi5nqlUgYbDLY8eED+pDkEFjn0P8b7KhCfE3PWLy3XI6R1TdtIQmbpkxmsR54Qi
	 BipNJQH/4OtQp886y+9kJTiHlXvK+BsykoPicR2Gs9+rWrsUQFyMfBN0G48WL+bsMt
	 sdz717FMpakeTrKBLiTgDP0w/GnCwpwr295jkoeUNJiLxU/FJsvhVVwNANbAkj5fOI
	 BNzOPQkLp6cLw==
Date: Tue, 5 Nov 2024 14:45:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	James Clark <james.clark@linaro.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
	Ben Gainey <ben.gainey@arm.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>,
	Paran Lee <p4ranlee@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v2 5/6] perf evsel: Allow evsel__newtp without
 libtraceevent
Message-ID: <ZypZpjh1bDDqpxn6@x1>
References: <20241102165400.75785-1-irogers@google.com>
 <20241102165400.75785-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102165400.75785-6-irogers@google.com>

On Sat, Nov 02, 2024 at 09:53:59AM -0700, Ian Rogers wrote:
> Switch from reading the tracepoint format to reading the id directly
> for the evsel config. This avoids the need to initialize
> libtraceevent, plugins, etc. It is sufficient for many tracepoint
> commands to work like:
> $ perf stat -e sched:sched_switch true

root@x1:~# perf check feature libtraceevent
         libtraceevent: [ OFF ]  # HAVE_LIBTRACEEVENT
root@x1:~# perf stat -e sched:sched_switch -I 1000
#           time             counts unit events
     1.001071607              4,631      sched:sched_switch                                                    
     2.004003548              5,138      sched:sched_switch                                                    
     3.006847313              4,967      sched:sched_switch                                                    
^C     3.944095456              5,553      sched:sched_switch                                                    

root@x1:~#

Works:

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> To populate evsel->tp_format, do lazy initialization using
> libtraceevent in the evsel__tp_format function (the sys and name are
> saved in evsel__newtp_idx for this purpose). Reading the id should be
> indicative of the format failing to load, but if not an error is
> reported in evsel__tp_format. This could happen for a tracepoint with
> a format that fails to parse.
> 
> As tracepoints can be parsed without libtraceevent with this, remove
> the associated #ifdefs in parse-events.c.
> 
> By only lazily parsing the tracepoint format information it is hoped
> this will help improve the performance of code using tracepoints but
> not the format information. It also cuts down on the build and ifdef
> logic.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c        | 103 ++++++++++++++++++++++++---------
>  tools/perf/util/evsel.h        |  14 ++---
>  tools/perf/util/parse-events.c |  16 +----
>  3 files changed, 82 insertions(+), 51 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a95db7e900d5..56e19e32a852 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -543,54 +543,101 @@ struct evsel *evsel__clone(struct evsel *orig)
>  	return NULL;
>  }
>  
> +static int trace_event__id(const char *sys, const char *name)
> +{
> +	char *tp_dir = get_events_file(sys);
> +	char path[PATH_MAX];
> +	int id, err;
> +
> +	if (!tp_dir)
> +		return -1;
> +
> +	scnprintf(path, PATH_MAX, "%s/%s/id", tp_dir, name);
> +	put_events_file(tp_dir);
> +	err = filename__read_int(path, &id);
> +	if (err)
> +		return err;
> +
> +	return id;
> +}
> +
>  /*
>   * Returns pointer with encoded error via <linux/err.h> interface.
>   */
> -#ifdef HAVE_LIBTRACEEVENT
>  struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format)
>  {
> +	struct perf_event_attr attr = {
> +		.type	       = PERF_TYPE_TRACEPOINT,
> +		.sample_type   = (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
> +				PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD),
> +	};
>  	struct evsel *evsel = zalloc(perf_evsel__object.size);
> -	int err = -ENOMEM;
> +	int err = -ENOMEM, id = -1;
>  
> -	if (evsel == NULL) {
> +	if (evsel == NULL)
>  		goto out_err;
> -	} else {
> -		struct perf_event_attr attr = {
> -			.type	       = PERF_TYPE_TRACEPOINT,
> -			.sample_type   = (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
> -					  PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD),
> -		};
>  
> -		if (asprintf(&evsel->name, "%s:%s", sys, name) < 0)
> -			goto out_free;
>  
> -		event_attr_init(&attr);
> +	if (asprintf(&evsel->name, "%s:%s", sys, name) < 0)
> +		goto out_free;
>  
> -		if (format) {
> -			evsel->tp_format = trace_event__tp_format(sys, name);
> -			if (IS_ERR(evsel->tp_format)) {
> -				err = PTR_ERR(evsel->tp_format);
> -				evsel->tp_format = NULL;
> -				goto out_free;
> -			}
> -			attr.config = evsel->tp_format->id;
> -		} else {
> -			attr.config = (__u64) -1;
> -		}
> +#ifdef HAVE_LIBTRACEEVENT
> +	evsel->tp_sys = strdup(sys);
> +	if (!evsel->tp_sys)
> +		goto out_free;
>  
> +	evsel->tp_name = strdup(name);
> +	if (!evsel->tp_name)
> +		goto out_free;
> +#endif
>  
> -		attr.sample_period = 1;
> -		evsel__init(evsel, &attr, idx);
> -	}
> +	event_attr_init(&attr);
>  
> +	if (format) {
> +		id = trace_event__id(sys, name);
> +		if (id < 0) {
> +			err = id;
> +			goto out_free;
> +		}
> +	}
> +	attr.config = (__u64)id;
> +	attr.sample_period = 1;
> +	evsel__init(evsel, &attr, idx);
>  	return evsel;
>  
>  out_free:
>  	zfree(&evsel->name);
> +#ifdef HAVE_LIBTRACEEVENT
> +	zfree(&evsel->tp_sys);
> +	zfree(&evsel->tp_name);
> +#endif
>  	free(evsel);
>  out_err:
>  	return ERR_PTR(err);
>  }
> +
> +#ifdef HAVE_LIBTRACEEVENT
> +struct tep_event *evsel__tp_format(struct evsel *evsel)
> +{
> +	struct tep_event *tp_format = evsel->tp_format;
> +
> +	if (tp_format)
> +		return tp_format;
> +
> +	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
> +		return NULL;
> +
> +	tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
> +	if (IS_ERR(tp_format)) {
> +		int err = -PTR_ERR(evsel->tp_format);
> +
> +		pr_err("Error getting tracepoint format '%s' '%s'(%d)\n",
> +			evsel__name(evsel), strerror(err), err);
> +		return NULL;
> +	}
> +	evsel->tp_format = tp_format;
> +	return evsel->tp_format;
> +}
>  #endif
>  
>  const char *const evsel__hw_names[PERF_COUNT_HW_MAX] = {
> @@ -1587,6 +1634,10 @@ void evsel__exit(struct evsel *evsel)
>  	perf_thread_map__put(evsel->core.threads);
>  	zfree(&evsel->group_name);
>  	zfree(&evsel->name);
> +#ifdef HAVE_LIBTRACEEVENT
> +	zfree(&evsel->tp_sys);
> +	zfree(&evsel->tp_name);
> +#endif
>  	zfree(&evsel->filter);
>  	zfree(&evsel->group_pmu_name);
>  	zfree(&evsel->unit);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index c3e53d320bf5..93b6244ec302 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -59,6 +59,8 @@ struct evsel {
>  		char			*group_name;
>  		const char		*group_pmu_name;
>  #ifdef HAVE_LIBTRACEEVENT
> +		char			*tp_sys;
> +		char			*tp_name;
>  		struct tep_event	*tp_format;
>  #endif
>  		char			*filter;
> @@ -247,25 +249,17 @@ int copy_config_terms(struct list_head *dst, struct list_head *src);
>  void free_config_terms(struct list_head *config_terms);
>  
>  
> -#ifdef HAVE_LIBTRACEEVENT
> -struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format);
> -
>  /*
>   * Returns pointer with encoded error via <linux/err.h> interface.
>   */
> +struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format);
>  static inline struct evsel *evsel__newtp(const char *sys, const char *name)
>  {
>  	return evsel__newtp_idx(sys, name, 0, true);
>  }
>  
> -static inline struct tep_event *evsel__tp_format(struct evsel *evsel)
> -{
> -	return evsel->tp_format;
> -}
> -#endif
> -
>  #ifdef HAVE_LIBTRACEEVENT
> -struct tep_event *event_format__new(const char *sys, const char *name);
> +struct tep_event *evsel__tp_format(struct evsel *evsel);
>  #endif
>  
>  void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index afeb8d815bbf..7fc1c36ef2a4 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -489,7 +489,6 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
>  	return found_supported ? 0 : -EINVAL;
>  }
>  
> -#ifdef HAVE_LIBTRACEEVENT
>  static void tracepoint_error(struct parse_events_error *e, int err,
>  			     const char *sys, const char *name, int column)
>  {
> @@ -644,7 +643,6 @@ static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
>  	closedir(events_dir);
>  	return ret;
>  }
> -#endif /* HAVE_LIBTRACEEVENT */
>  
>  size_t default_breakpoint_len(void)
>  {
> @@ -1066,7 +1064,6 @@ static int config_term_pmu(struct perf_event_attr *attr,
>  	return config_term_common(attr, term, err);
>  }
>  
> -#ifdef HAVE_LIBTRACEEVENT
>  static int config_term_tracepoint(struct perf_event_attr *attr,
>  				  struct parse_events_term *term,
>  				  struct parse_events_error *err)
> @@ -1111,7 +1108,6 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
>  
>  	return 0;
>  }
> -#endif
>  
>  static int config_attr(struct perf_event_attr *attr,
>  		       const struct parse_events_terms *head,
> @@ -1303,7 +1299,7 @@ int parse_events_add_tracepoint(struct parse_events_state *parse_state,
>  				struct parse_events_terms *head_config, void *loc_)
>  {
>  	YYLTYPE *loc = loc_;
> -#ifdef HAVE_LIBTRACEEVENT
> +
>  	if (head_config) {
>  		struct perf_event_attr attr;
>  
> @@ -1318,16 +1314,6 @@ int parse_events_add_tracepoint(struct parse_events_state *parse_state,
>  	else
>  		return add_tracepoint_event(parse_state, list, sys, event,
>  					    err, head_config, loc);
> -#else
> -	(void)parse_state;
> -	(void)list;
> -	(void)sys;
> -	(void)event;
> -	(void)head_config;
> -	parse_events_error__handle(err, loc->first_column, strdup("unsupported tracepoint"),
> -				strdup("libtraceevent is necessary for tracepoint support"));
> -	return -1;
> -#endif
>  }
>  
>  static int __parse_events_add_numeric(struct parse_events_state *parse_state,
> -- 
> 2.47.0.199.ga7371fff76-goog
> 

