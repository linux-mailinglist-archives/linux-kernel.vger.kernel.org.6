Return-Path: <linux-kernel+bounces-421896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 153379D91A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB88328345C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F712CDA5;
	Tue, 26 Nov 2024 06:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bgx9PYo8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04618831
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732601232; cv=none; b=sVXkwWP/stQMHfSsRTCoKWwbO4QGpkVhiD3e1hx+/vFlw53LPqCsP5hOkL8UbRhsZo1b0EWwjVWlQpur3I93l1aV+qMTX8UOa1Z+6sq1y1W31ligV0lq3DatInANS3l9zg85xTfq0C6M1svc6bqWwv5/zqB8RtSrWE8Yj81RPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732601232; c=relaxed/simple;
	bh=hrf3W8lHPddH4cWex2WfhaNRVrC1KqJ53LdbppqHZLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEU1yyo+F3i7HtW+p7Qp5r2p9KMtfoVmFlEsF8ti7nfImZdaZ+yOMfe2gK8gLOjfpgrF0HpR9z2Zpw2HRmiS1QIFrzFVdOCmvJqOlxe86az+E6HDP2AJ71imE4ZH3nS+SkespI714HTjcoy22oMhwDvNt+JAOKxhLr0sYPgA3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bgx9PYo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F15C4CECF;
	Tue, 26 Nov 2024 06:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732601231;
	bh=hrf3W8lHPddH4cWex2WfhaNRVrC1KqJ53LdbppqHZLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bgx9PYo8X2dr74COFlGTXZndtxERI4//9waYwwrKcFY1+mmm/rpN5nbKVvx0St611
	 amp1caLgmEBLjtVynp4xIGUgc4W//t33OqwoWv6RRG0gwFRWl3LLYQclUgLLirGciS
	 7HKtSP+OvfK/wJAEJYj+8S09XZteKc0LuPVpPcWvdhQv4U4mGHAFUbCxaWZRIlGGKi
	 zG7JxAaeAkHVYkI2DuK6x17lD3vqOFbsnsNbLHb7AkzT+lPTRsz8Nhr4wi1WMtazd7
	 eOo/SLL5iirYRadAyKEcbErhmpHvtAZsGlOcOKgXfpIlIZ9Zw8akGuL51NetI1XEk7
	 W4uJkVDmJDj+Q==
Date: Mon, 25 Nov 2024 22:07:09 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2] perf lock: Fix parse_lock_type which only retrieve
 one lock flag
Message-ID: <Z0VljcVm4ni-lJrE@google.com>
References: <20241122002752.4179915-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122002752.4179915-1-ctshao@google.com>

Hello,

On Fri, Nov 22, 2024 at 12:27:51AM +0000, Chun-Tse Shao wrote:
> `parse_lock_type` can only add the first lock flag in `lock_type_table`
> given input `str`. For example, for `Y rwlock`, it only adds `rwlock:R`
> into this perf session. Another example is for `-Y mutex`, it only adds
> the mutex without `LCB_F_SPIN` flag. The patch fixes this issue, makes
> sure both `rwlock:R` and `rwlock:W` will be added with `-Y rwlock`, and
> so on.
> 
> Testing:
>   $ ./perf lock con -ab -Y mutex,rwlock -- perf bench sched pipe
>   # Running 'sched/pipe' benchmark:
>   # Executed 1000000 pipe operations between two processes
> 
>        Total time: 8.425 [sec]
> 
>          8.425402 usecs/op
>            118688 ops/sec
>    contended   total wait     max wait     avg wait         type   caller
> 
>          194      1.68 ms     44.16 us      8.66 us        mutex   pipe_read+0x57
>           10    423.03 us     44.27 us     42.30 us     rwlock:W   do_exit+0x365
>           54    254.67 us     58.87 us      4.72 us        mutex   pipe_write+0x50
>           21    146.64 us     11.54 us      6.98 us        mutex   pipe_read+0x282
>           10    141.27 us     20.62 us     14.13 us     rwlock:W   release_task+0x6f
>            5     58.92 us     16.37 us     11.78 us        mutex   do_epoll_wait+0x24d
>            3     29.81 us     17.66 us      9.94 us        mutex   do_epoll_ctl+0x6c1
>            4     26.82 us     11.02 us      6.70 us        mutex   do_epoll_wait+0x24d
>            2     18.32 us     12.49 us      9.16 us     rwlock:W   do_epoll_wait+0x255
>            1     11.34 us     11.34 us     11.34 us     rwlock:W   ep_done_scan+0x2d
>            1     11.02 us     11.02 us     11.02 us     rwlock:R   mm_update_next_owner+0x4e
>            1     10.60 us     10.60 us     10.60 us     rwlock:W   do_epoll_ctl+0xb65
>            1      9.90 us      9.90 us      9.90 us     rwlock:W   do_exit+0x365
> 
> Fixes: d783ea8f62c4 ("perf lock contention: Simplify parse_lock_type()")
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/builtin-lock.c | 93 ++++++++++++++++++++++++++-------------
>  1 file changed, 62 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 062e2b56a2ab..052dbf423efd 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -15,6 +15,7 @@
>  #include "util/lock-contention.h"
>  #include "util/bpf_skel/lock_data.h"
>  
> +#include <string.h>
>  #include <subcmd/pager.h>
>  #include <subcmd/parse-options.h>
>  #include "util/trace-event.h"
> @@ -1575,8 +1576,13 @@ static void sort_result(void)
>  
>  static const struct {
>  	unsigned int flags;
> -	const char *str;
> +	/* Name of the lock. */
>  	const char *name;

I think this is the name of flag or access - read or write.


> +	/*
> +	 * Name of the group this lock belongs to.
> +	 * For example, both rwlock:R and rwlock:W belong to rwlock.
> +	 */
> +	const char *group;

And this is the name of the lock (type) - rwlock or rwsem.


>  } lock_type_table[] = {
>  	{ 0,				"semaphore",	"semaphore" },
>  	{ LCB_F_SPIN,			"spinlock",	"spinlock" },
> @@ -1591,42 +1597,38 @@ static const struct {
>  	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
>  	{ LCB_F_MUTEX,			"mutex",	"mutex" },
>  	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
> -	/* alias for get_type_flag() */
> -	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex" },
>  };
>  
> -static const char *get_type_str(unsigned int flags)
> +static const char *get_type_name(unsigned int flags)
>  {
>  	flags &= LCB_F_MAX_FLAGS - 1;
>  
>  	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
>  		if (lock_type_table[i].flags == flags)
> -			return lock_type_table[i].str;
> +			return lock_type_table[i].name;
>  	}
>  	return "unknown";
>  }
>  
> -static const char *get_type_name(unsigned int flags)
> +static const char *get_type_group(unsigned int flags)
>  {
>  	flags &= LCB_F_MAX_FLAGS - 1;
>  
>  	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
>  		if (lock_type_table[i].flags == flags)
> -			return lock_type_table[i].name;
> +			return lock_type_table[i].group;
>  	}
>  	return "unknown";
>  }
>  
> -static unsigned int get_type_flag(const char *str)
> +static unsigned int get_type_flags_by_name(const char *name)
>  {
>  	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> -		if (!strcmp(lock_type_table[i].name, str))
> -			return lock_type_table[i].flags;
> -	}
> -	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> -		if (!strcmp(lock_type_table[i].str, str))
> +		if (!strcmp(lock_type_table[i].name, name))
>  			return lock_type_table[i].flags;
>  	}
> +
> +	pr_err("Unknown lock flags: %s\n", name);

I'm not sure if there will be another caller, but it seems better to
have this error message in the parse function directly.


>  	return UINT_MAX;
>  }
>  
> @@ -1732,7 +1734,8 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
>  
>  	switch (aggr_mode) {
>  	case LOCK_AGGR_CALLER:
> -		fprintf(lock_output, "  %10s   %s\n", get_type_str(st->flags), st->name);
> +		fprintf(lock_output, "  %10s   %s\n",
> +			get_type_name(st->flags), st->name);
>  		break;
>  	case LOCK_AGGR_TASK:
>  		pid = st->addr;
> @@ -1742,7 +1745,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
>  		break;
>  	case LOCK_AGGR_ADDR:
>  		fprintf(lock_output, "  %016llx   %s (%s)\n", (unsigned long long)st->addr,
> -			st->name, get_type_name(st->flags));
> +			st->name, get_type_group(st->flags));
>  		break;
>  	case LOCK_AGGR_CGROUP:
>  		fprintf(lock_output, "  %s\n", st->name);
> @@ -1783,7 +1786,8 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
>  
>  	switch (aggr_mode) {
>  	case LOCK_AGGR_CALLER:
> -		fprintf(lock_output, "%s%s %s", get_type_str(st->flags), sep, st->name);
> +		fprintf(lock_output, "%s%s %s",
> +			get_type_name(st->flags), sep, st->name);
>  		if (verbose <= 0)
>  			fprintf(lock_output, "\n");
>  		break;
> @@ -1795,7 +1799,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
>  		break;
>  	case LOCK_AGGR_ADDR:
>  		fprintf(lock_output, "%llx%s %s%s %s\n", (unsigned long long)st->addr, sep,
> -			st->name, sep, get_type_name(st->flags));
> +			st->name, sep, get_type_group(st->flags));
>  		break;
>  	case LOCK_AGGR_CGROUP:
>  		fprintf(lock_output, "%s\n",st->name);
> @@ -2338,41 +2342,68 @@ static bool add_lock_type(unsigned int flags)
>  	unsigned int *tmp;
>  
>  	tmp = realloc(filters.types, (filters.nr_types + 1) * sizeof(*filters.types));
> -	if (tmp == NULL)
> +	if (tmp == NULL) {
> +		pr_err("Failed to add lock flags: %u\n", flags);
>  		return false;
> +	}
>  
>  	tmp[filters.nr_types++] = flags;
>  	filters.types = tmp;
>  	return true;
>  }
>  
> -static int parse_lock_type(const struct option *opt __maybe_unused, const char *str,
> -			   int unset __maybe_unused)
> +static int parse_lock_type(const struct option *opt __maybe_unused,
> +			   const char *str, int unset __maybe_unused)
>  {
>  	char *s, *tmp, *tok;
> -	int ret = 0;
>  
>  	s = strdup(str);
>  	if (s == NULL)
>  		return -1;
>  
> -	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
> -		unsigned int flags = get_type_flag(tok);
> +	for (tok = strtok_r(s, ", ", &tmp); tok;
> +	     tok = strtok_r(NULL, ", ", &tmp)) {

I think you changed this because of the 80 column limit.  But I think
it's recently increased to 100 so you don't need to change this line
uncessarily.

Other lines containing actual changes may be accceptable.  It's up to
you but I generally prefer smaller changes.


> +		bool found = false;
>  
> -		if (flags == -1U) {
> -			pr_err("Unknown lock flags: %s\n", tok);
> -			ret = -1;
> -			break;
> +		/* `tok` is a lock name if it contains ':'. */
> +		if (strchr(tok, ':')) {
> +			unsigned int flags = get_type_flags_by_name(tok);
> +
> +			if (flags == UINT_MAX || !add_lock_type(flags)) {
> +				free(s);
> +				return -1;
> +			}
> +			continue;
>  		}
>  
> -		if (!add_lock_type(flags)) {
> -			ret = -1;
> -			break;
> +		/* Otherwise look up flags by lock group */
> +		/*
> +		 * By documentation, `percpu-rwmem` should be `pcpu-sem`.
> +		 * For backward compatibility, we replace pcpu-sem with percpu-rwmem.
> +		 */
> +		if (!strcmp(tok, "pcpu-sem"))
> +			tok = (char *)"percpu-rwsem";

Can you please split this into a separate fix?

Thanks,
Namhyung

> +
> +		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> +			if (!strcmp(lock_type_table[i].group, tok)) {
> +				if (add_lock_type(lock_type_table[i].flags)) {
> +					found = true;
> +				} else {
> +					free(s);
> +					return -1;
> +				}
> +			}
> +		}
> +
> +		if (!found) {
> +			pr_err("Unknown lock flags: %s\n", tok);
> +			free(s);
> +			return -1;
>  		}
>  	}
>  
>  	free(s);
> -	return ret;
> +	return 0;
>  }
>  
>  static bool add_lock_addr(unsigned long addr)
> -- 
> 2.47.0.371.ga323438b13-goog
> 

