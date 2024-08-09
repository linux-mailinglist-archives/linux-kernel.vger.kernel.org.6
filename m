Return-Path: <linux-kernel+bounces-281584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9678D94D86E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF43BB22270
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E0916A921;
	Fri,  9 Aug 2024 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItdtXRE2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED52556F;
	Fri,  9 Aug 2024 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723239193; cv=none; b=V1J9IlgV25mUg85xPr6U/GoWlycbG3m9uSlgweLZGmmPUnqS5LvIHu2TKLqxyF25nikeeoC5aCkBPQuM2qVmbV+r9eYEmfvpU4/Owz91lbzF0aqp6BYzi60ICIYi9E60vmNsbEufP3zubkqsMC2+TpXPPnRw7csfAmxofC06B/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723239193; c=relaxed/simple;
	bh=t62Vh9jkDKZXolX4M0Yc+cWcvhvWa1G5spzRzNQeOkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMBu2yJLl3Y32jUpkA9KHdetN4nGhVPQXkDY9IExf6entX91aUNI5oYrXa2OVN8I9/Gw/p/PnTbClqqKN0ZBr9J0F3VmfLRGmJXuj5PN1Tvk2+1poeo8MmqogWh4FK9BVPY4N6dgBYuYuAEyzXBEa4WTJqPbZhpgvdpIUq5tcmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItdtXRE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC6FC32782;
	Fri,  9 Aug 2024 21:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723239192;
	bh=t62Vh9jkDKZXolX4M0Yc+cWcvhvWa1G5spzRzNQeOkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ItdtXRE2vhZUw9942MVh4DLPc0IQDcvV+QfjQWnUXfXwuqehJX0eJxiNYYgngZ6gV
	 8KJDGL284z+8cKfiCu8Q0cxM0vYt213227t0cygWswPqSZD5rnzEvdCsgBThrMbQ5I
	 j9XYFe9NT/iCgAqJoN2xY0XBq90XxnPOFtTrRXO2Sx/HxJl/LN191KaNYAKI29Hlqg
	 g5VH2Wtm7YZhNazYABGtXKOybu6w0gged6XMkNGNGUgWcaHDLTbCWDJuZD/hgNbBhx
	 C2QQRQ6aNsZal7cP1gW4q/Z8ZAyFIIf1Q6qCETqJGzFH+LO3EamCqrIhs819O4HmqV
	 Cd/UW/j/Eo9/g==
Date: Fri, 9 Aug 2024 18:33:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate-data: Support --skip-empty option
Message-ID: <ZraLFdiu04wjxyt0@x1>
References: <20240807061713.1642924-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807061713.1642924-1-namhyung@kernel.org>

On Tue, Aug 06, 2024 at 11:17:13PM -0700, Namhyung Kim wrote:
> The --skip-empty option is to hide dummy events in a group.  Like other
> output mode like perf report and perf annotate, the data-type profiling
> output should support the option.

Thanks, tested and applied.

    Committer testing:
    
    With dummy:
    
      root@number:~# perf annotate --stdio --group --data-type --skip-empty | head -24
      Annotate type: 'pthread_mutex_t' in /usr/lib64/libc.so.6 (50 samples):
       event[0] = cpu_atom/mem-loads,ldlat=30/P
       event[1] = cpu_atom/mem-stores/P
       event[2] = dummy:u
      ============================================================================
                       Percent     offset       size  field
        100.00  100.00    0.00          0         40  pthread_mutex_t        {
        100.00  100.00    0.00          0         40      struct __pthread_mutex_s  __data {
         45.21   84.54    0.00          0          4          int   __lock;
          0.00    0.00    0.00          4          4          unsigned int  __count;
          0.00    1.83    0.00          8          4          int   __owner;
          5.19   10.65    0.00         12          4          unsigned int  __nusers;
         49.61    2.97    0.00         16          4          int   __kind;
          0.00    0.00    0.00         20          2          short int     __spins;
          0.00    0.00    0.00         22          2          short int     __elision;
          0.00    0.00    0.00         24         16          __pthread_list_t      __list {
          0.00    0.00    0.00         24          8              struct __pthread_internal_list*   __prev;
          0.00    0.00    0.00         32          8              struct __pthread_internal_list*   __next;
                                                              };
                                                          };
          0.00    0.00    0.00          0          0      char[]    __size;
         45.21   84.54    0.00          0          8      long int  __align;
                                                    };
    Skipping it:
    
      root@number:~# perf annotate --stdio --group --data-type --skip-empty | head -24
      Annotate type: 'pthread_mutex_t' in /usr/lib64/libc.so.6 (50 samples):
       event[0] = cpu_atom/mem-loads,ldlat=30/P
       event[1] = cpu_atom/mem-stores/P
      ============================================================================
               Percent     offset       size  field
        100.00  100.00          0         40  pthread_mutex_t        {
        100.00  100.00          0         40      struct __pthread_mutex_s  __data {
         45.21   84.54          0          4          int   __lock;
          0.00    0.00          4          4          unsigned int  __count;
          0.00    1.83          8          4          int   __owner;
          5.19   10.65         12          4          unsigned int  __nusers;
         49.61    2.97         16          4          int   __kind;
          0.00    0.00         20          2          short int     __spins;
          0.00    0.00         22          2          short int     __elision;
          0.00    0.00         24         16          __pthread_list_t      __list {
          0.00    0.00         24          8              struct __pthread_internal_list*   __prev;
          0.00    0.00         32          8              struct __pthread_internal_list*   __next;
                                                      };
                                                  };
          0.00    0.00          0          0      char[]    __size;
         45.21   84.54          0          8      long int  __align;
                                              };
    
      Annotate type: 'pthread_mutexattr_t' in /usr/lib64/libc.so.6 (1 samples):
      root@number:~#

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate-data.c | 30 ++++++++++++++----
>  tools/perf/util/annotate-data.c        | 44 +++++++++++++-------------
>  2 files changed, 45 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
> index 8d6bf08d371d..c3db80a7589a 100644
> --- a/tools/perf/ui/browsers/annotate-data.c
> +++ b/tools/perf/ui/browsers/annotate-data.c
> @@ -46,15 +46,18 @@ static int get_member_overhead(struct annotated_data_type *adt,
>  	struct annotated_member *member = entry->data;
>  	int i, k;
>  
> -	for (i = 0; i < member->size; i++) {
> +	for (i = 0, k = 0; i < member->size; i++) {
>  		struct type_hist *h;
>  		struct evsel *evsel;
>  		int offset = member->offset + i;
>  
>  		for_each_group_evsel(evsel, leader) {
> +			if (symbol_conf.skip_empty &&
> +			    evsel__hists(evsel)->stats.nr_samples == 0)
> +				continue;
> +
>  			h = adt->histograms[evsel->core.idx];
> -			k = evsel__group_idx(evsel);
> -			update_hist_entry(&entry->hists[k], &h->addr[offset]);
> +			update_hist_entry(&entry->hists[k++], &h->addr[offset]);
>  		}
>  	}
>  	return 0;
> @@ -203,6 +206,7 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
>  	struct annotated_data_type *adt = he->mem_type;
>  	struct evsel *leader = hists_to_evsel(he->hists);
>  	struct evsel *evsel;
> +	int idx = 0;
>  
>  	if (member == NULL) {
>  		bool current = ui_browser__is_current_entry(uib, row);
> @@ -219,9 +223,12 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
>  	/* print the number */
>  	for_each_group_evsel(evsel, leader) {
>  		struct type_hist *h = adt->histograms[evsel->core.idx];
> -		int idx = evsel__group_idx(evsel);
>  
> -		browser__write_overhead(uib, h, &be->hists[idx], row);
> +		if (symbol_conf.skip_empty &&
> +		    evsel__hists(evsel)->stats.nr_samples == 0)
> +			continue;
> +
> +		browser__write_overhead(uib, h, &be->hists[idx++], row);
>  	}
>  
>  	/* print type info */
> @@ -300,8 +307,17 @@ int hist_entry__annotate_data_tui(struct hist_entry *he, struct evsel *evsel,
>  
>  	ui_helpline__push("Press ESC to exit");
>  
> -	if (evsel__is_group_event(evsel))
> -		browser.nr_events = evsel->core.nr_members;
> +	if (evsel__is_group_event(evsel)) {
> +		struct evsel *pos;
> +		int nr = 0;
> +
> +		for_each_group_evsel(pos, evsel) {
> +			if (!symbol_conf.skip_empty ||
> +			    evsel__hists(pos)->stats.nr_samples)
> +				nr++;
> +		}
> +		browser.nr_events = nr;
> +	}
>  
>  	ret = annotated_data_browser__collect_entries(&browser);
>  	if (ret == 0)
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 734acdd8c4b7..be3b84a82271 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1492,10 +1492,15 @@ static void print_annotated_data_header(struct hist_entry *he, struct evsel *evs
>  		struct evsel *pos;
>  		int i = 0;
>  
> -		for_each_group_evsel(pos, evsel)
> -			printf(" event[%d] = %s\n", i++, pos->name);
> +		nr_members = 0;
> +		for_each_group_evsel(pos, evsel) {
> +			if (symbol_conf.skip_empty &&
> +			    evsel__hists(pos)->stats.nr_samples == 0)
> +				continue;
>  
> -		nr_members = evsel->core.nr_members;
> +			printf(" event[%d] = %s\n", i++, pos->name);
> +			nr_members++;
> +		}
>  	}
>  
>  	if (symbol_conf.show_total_period) {
> @@ -1530,31 +1535,26 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
>  {
>  	struct annotated_member *child;
>  	struct type_hist *h = mem_type->histograms[evsel->core.idx];
> -	int i, nr_events = 1, samples = 0;
> +	int i, nr_events = 0, samples = 0;
>  	u64 period = 0;
>  	int width = symbol_conf.show_total_period ? 11 : 7;
> +	struct evsel *pos;
>  
> -	for (i = 0; i < member->size; i++) {
> -		samples += h->addr[member->offset + i].nr_samples;
> -		period += h->addr[member->offset + i].period;
> -	}
> -	print_annotated_data_value(h, period, samples);
> -
> -	if (evsel__is_group_event(evsel)) {
> -		struct evsel *pos;
> +	for_each_group_evsel(pos, evsel) {
> +		h = mem_type->histograms[pos->core.idx];
>  
> -		for_each_group_member(pos, evsel) {
> -			h = mem_type->histograms[pos->core.idx];
> +		if (symbol_conf.skip_empty &&
> +		    evsel__hists(pos)->stats.nr_samples == 0)
> +			continue;
>  
> -			samples = 0;
> -			period = 0;
> -			for (i = 0; i < member->size; i++) {
> -				samples += h->addr[member->offset + i].nr_samples;
> -				period += h->addr[member->offset + i].period;
> -			}
> -			print_annotated_data_value(h, period, samples);
> +		samples = 0;
> +		period = 0;
> +		for (i = 0; i < member->size; i++) {
> +			samples += h->addr[member->offset + i].nr_samples;
> +			period += h->addr[member->offset + i].period;
>  		}
> -		nr_events = evsel->core.nr_members;
> +		print_annotated_data_value(h, period, samples);
> +		nr_events++;
>  	}
>  
>  	printf(" %10d %10d  %*s%s\t%s",
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog

