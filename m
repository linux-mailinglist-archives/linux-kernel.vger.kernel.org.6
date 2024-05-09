Return-Path: <linux-kernel+bounces-175006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3A8C1895
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CEF1C2219C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB750128820;
	Thu,  9 May 2024 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFXd/X54"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C28594C;
	Thu,  9 May 2024 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290984; cv=none; b=U3BcSPstmWqTa+jVmmLoZCGH+2X6CTn9CyTP8/8NwaaF4JTjVF0Aue/J+Q5HicSxgKhVW7o9RNlPqTQm5uzNBY6cE6iMjYfIgW4vLZwVRQXhfVpfzjCBvLRIFne1+QgySRecwdVj9JHrPmgbIkVcntSldnpbcjYRVd6Nvc+CpEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290984; c=relaxed/simple;
	bh=jYlo5TQS0AnXYq32ycelwNFKPF0VaUE7YGHwtFDwiW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWXgH5PlVbG4URyZSDfAjPUgJMgnLuQLHFgPx3O6nrTWsGQCFLJBQng+nelVpUG2oBmpjovmVKYz1AA9kD758qt9gb5vXGSOpVx/U9ATweBSjkVVtg2dVvFiDeTCfn+j9G1hvfYfuShIurkButZnYwiDPYe+BU+qBij9Qd5A30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFXd/X54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7F9C116B1;
	Thu,  9 May 2024 21:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715290983;
	bh=jYlo5TQS0AnXYq32ycelwNFKPF0VaUE7YGHwtFDwiW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFXd/X54w7+lDfRAkiscYpZgXlzW7czFvKUgANnwcVlrWYQYDW+0XTrwPqLm9ftrZ
	 9OlpMWWbeUSv+h3VjYIwjw6FRgEWA3nnwUlbMYoLkbX+D2cwPp4w8Arz8dr9rf9Acw
	 YtrGX/kzgGeDG9zyyjih5dR3JsYhUBPGvDKU4Wdw8M1uq0e+Ydx5u/KG2kTMCrsqcd
	 z5Imt0yqYSiqpoTlhp/w8YEY7DBw5KF0ItKi7JJiMQTBwb/O8yyOX4a9E7zbRKj4c4
	 tvh7TYZH0/muj2ZlWjKacdv8M5i4lzBUMY+v3nJ6w+6HemnNqgE991tQhkqWyhkN1l
	 f2S60zbOcfpdQ==
Date: Thu, 9 May 2024 18:43:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf tracepoint: Don't scan all tracepoints to test
 if one exists
Message-ID: <Zj1DZMB3fzVMPyzE@x1>
References: <20240509153245.1990426-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509153245.1990426-1-irogers@google.com>

On Thu, May 09, 2024 at 08:32:45AM -0700, Ian Rogers wrote:
> In is_valid_tracepoint, rather than scanning
> "/sys/kernel/tracing/events/*/*" skipping any path where
> "/sys/kernel/tracing/events/*/*/id" doesn't exist, and then testing if
> "*:*" matches the tracepoint name, just use the given tracepoint name
> replace the ':' with '/' and see if the id file exists. This turns a
> nested directory search into a single file available test.
> 
> Rather than return 1 for valid and 0 for invalid, return true and
> false.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2. Fix potential uninitialized use on memory allocation failure path.



Thanks, applied to perf-tools-next,

- Arnaldo

> ---
>  tools/perf/util/tracepoint.c | 56 ++++++++++++++----------------------
>  tools/perf/util/tracepoint.h |  3 +-
>  2 files changed, 24 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/perf/util/tracepoint.c b/tools/perf/util/tracepoint.c
> index 92dd8b455b90..bb06d10fbe37 100644
> --- a/tools/perf/util/tracepoint.c
> +++ b/tools/perf/util/tracepoint.c
> @@ -4,10 +4,12 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <sys/param.h>
>  #include <unistd.h>
>  
>  #include <api/fs/tracing_path.h>
> +#include "fncache.h"
>  
>  int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
>  {
> @@ -26,39 +28,25 @@ int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
>  /*
>   * Check whether event is in <debugfs_mount_point>/tracing/events
>   */
> -int is_valid_tracepoint(const char *event_string)
> +bool is_valid_tracepoint(const char *event_string)
>  {
> -	DIR *sys_dir, *evt_dir;
> -	struct dirent *sys_dirent, *evt_dirent;
> -	char evt_path[MAXPATHLEN];
> -	char *dir_path;
> -
> -	sys_dir = tracing_events__opendir();
> -	if (!sys_dir)
> -		return 0;
> -
> -	for_each_subsystem(sys_dir, sys_dirent) {
> -		dir_path = get_events_file(sys_dirent->d_name);
> -		if (!dir_path)
> -			continue;
> -		evt_dir = opendir(dir_path);
> -		if (!evt_dir)
> -			goto next;
> -
> -		for_each_event(dir_path, evt_dir, evt_dirent) {
> -			snprintf(evt_path, MAXPATHLEN, "%s:%s",
> -				 sys_dirent->d_name, evt_dirent->d_name);
> -			if (!strcmp(evt_path, event_string)) {
> -				closedir(evt_dir);
> -				put_events_file(dir_path);
> -				closedir(sys_dir);
> -				return 1;
> -			}
> -		}
> -		closedir(evt_dir);
> -next:
> -		put_events_file(dir_path);
> -	}
> -	closedir(sys_dir);
> -	return 0;
> +	char *dst, *path = malloc(strlen(event_string) + 4); /* Space for "/id\0". */
> +	const char *src;
> +	bool have_file = false; /* Conservatively return false if memory allocation failed. */
> +
> +	if (!path)
> +		return false;
> +
> +	/* Copy event_string replacing the ':' with '/'. */
> +	for (src = event_string, dst = path; *src; src++, dst++)
> +		*dst = (*src == ':') ? '/' : *src;
> +	/* Add "/id\0". */
> +	memcpy(dst, "/id", 4);
> +
> +	dst = get_events_file(path);
> +	if (dst)
> +		have_file = file_available(dst);
> +	free(dst);
> +	free(path);
> +	return have_file;
>  }
> diff --git a/tools/perf/util/tracepoint.h b/tools/perf/util/tracepoint.h
> index c4a110fe87d7..65ccb01fc312 100644
> --- a/tools/perf/util/tracepoint.h
> +++ b/tools/perf/util/tracepoint.h
> @@ -4,6 +4,7 @@
>  
>  #include <dirent.h>
>  #include <string.h>
> +#include <stdbool.h>
>  
>  int tp_event_has_id(const char *dir_path, struct dirent *evt_dir);
>  
> @@ -20,6 +21,6 @@ int tp_event_has_id(const char *dir_path, struct dirent *evt_dir);
>  		    (strcmp(sys_dirent->d_name, ".")) &&	\
>  		    (strcmp(sys_dirent->d_name, "..")))
>  
> -int is_valid_tracepoint(const char *event_string);
> +bool is_valid_tracepoint(const char *event_string);
>  
>  #endif /* __PERF_TRACEPOINT_H */
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog

