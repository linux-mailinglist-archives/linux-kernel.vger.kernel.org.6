Return-Path: <linux-kernel+bounces-200924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61738FB695
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D1B1C20DAE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD22613D524;
	Tue,  4 Jun 2024 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnMWjt/u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A88BF7;
	Tue,  4 Jun 2024 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513665; cv=none; b=eHSucCddcO8LL8BfQVyuXn29wESlvRKg/7qQuWY+PJnoY22zSNUX9jRGLTDAwpZ+O+xpRCAAGPu+y+Qt0JjaGSHHoisNbGp6CNCqki7tw0MLUTchp19GSaDsaEmqsjoLRbcPuy/ImeIplvIXmOf1uykWVoWiScE0oNPhviv08DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513665; c=relaxed/simple;
	bh=DX+pupswXwUSpCMl8Xb07zQsQwG16PK57vbnUG38pT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjBOep6QKhCqZkGNTkRUSGiqMBfc26sUmNf5wyCZmoZctbcGGq7oNvRymfF7NG7ilP0EFLfX5uqBsaNKFHsyH5iT8QmXivhBRgmBGiGa3IvAbM0hdmqJcLYFYhHRPpMX+gr/dhwl8ylFRUV4KvKamgEPwF0okM5PsgQQb5a0DRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnMWjt/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136CEC2BBFC;
	Tue,  4 Jun 2024 15:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717513664;
	bh=DX+pupswXwUSpCMl8Xb07zQsQwG16PK57vbnUG38pT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnMWjt/uoKo1pB+DGxtT32RoBqql97GY/JPZz7flI9eN3jmEfZ7wf6QI3xfrDS4da
	 psWizhS3CUJard5UVr0aRHwGnhVRoTZ8lRsm+p9l8am7IAE32+vaAj0Pj6XpIufoAQ
	 5q52gEaLV66C8ZPnmTJKKjFekzE4c3pXuedsQ1YiTq6gQ6Sd5nU4sD88RBm9qZM4xe
	 CK1OmSgQjhnGV4nhlL1Um07eIBN6J9fCYQ6nzyTAyTxyaiVZpmfZylYowXEiy/MaFv
	 nLIlJbK4jKtsqCBFvOTQG4CXUJXIX2yMUHBsISQaRiWN1hH+ds4liogQwVNNge+zFq
	 8ta8MrRxDt1sA==
Date: Tue, 4 Jun 2024 12:07:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf hist: Factor out __hpp__fmt_print()
Message-ID: <Zl8tvVPEfLM8_T_z@x1>
References: <20240603224412.1910049-1-namhyung@kernel.org>
 <20240603224412.1910049-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603224412.1910049-2-namhyung@kernel.org>

On Mon, Jun 03, 2024 at 03:44:09PM -0700, Namhyung Kim wrote:
> Split the logic to print the histogram values according to the format
> string.  This was used in 3 different places so it's better to move out
> the logic into a function.

But are all really equivalent? I had difficulty following it, perhaps it
would be better to introduce the function and then go on making one by
one use it instead of doing it all at once?

So in the end we have:

static int __hpp__fmt_print(struct perf_hpp *hpp, struct hists *hists, u64 val,
			    int nr_samples, const char *fmt, int len,
			    hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
{
	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
		double percent = 0.0;
		u64 total = hists__total_period(hists);

		if (total)
			percent = 100.0 * val / total;

		return hpp__call_print_fn(hpp, print_fn, fmt, len, percent);
	}
	if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
		double avg = nr_samples ? (1.0 * val / nr_samples) : 0;

		return hpp__call_print_fn(hpp, print_fn, fmt, len, avg);
	}

	return hpp__call_print_fn(hpp, print_fn, fmt, len, val);
}

I.e. we do something with the last arg for hpp__call_print_fn() for the
PERF_HPP_FMT_TYPE__PERCENT and PERF_HPP_FMT_TYPE__AVERAGE fmtype's, but
we don't check for those fmtypes on each of the places that we now call
__hpp__fmt_print(), right?

That while (idx_delta--) cases is only interested in !=PERF_HPP_FMT_TYPE__RAW...

Nah, after trying to describe the confusion I think I clarified it,
probably leave it as you did :-\

Continuing...

- Arnaldo
 
> +++ b/tools/perf/ui/hist.c
> @@ -23,35 +23,42 @@
>  	__ret;							\
>  })
>  
> -static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
> -		      hpp_field_fn get_field, const char *fmt, int len,
> -		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
> +static int __hpp__fmt_print(struct perf_hpp *hpp, struct hists *hists, u64 val,
> +			    int nr_samples, const char *fmt, int len,
> +			    hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
>  {
> -	int ret;
> -	struct hists *hists = he->hists;
> -	struct evsel *evsel = hists_to_evsel(hists);
> -	char *buf = hpp->buf;
> -	size_t size = hpp->size;
> -
>  	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
>  		double percent = 0.0;
>  		u64 total = hists__total_period(hists);
>  
>  		if (total)
> -			percent = 100.0 * get_field(he) / total;
> +			percent = 100.0 * val / total;
>  
> -		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, percent);
> -	} else if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
> -		double average = 0;
> +		return hpp__call_print_fn(hpp, print_fn, fmt, len, percent);
> +	}
>  
> -		if (he->stat.nr_events)
> -			average = 1.0 * get_field(he) / he->stat.nr_events;
> +	if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
> +		double avg = nr_samples ? (1.0 * val / nr_samples) : 0;
>  
> -		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, average);
> -	} else {
> -		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, get_field(he));
> +		return hpp__call_print_fn(hpp, print_fn, fmt, len, avg);
>  	}
>  
> +	return hpp__call_print_fn(hpp, print_fn, fmt, len, val);
> +}
> +
> +static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
> +		      hpp_field_fn get_field, const char *fmt, int len,
> +		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
> +{
> +	int ret;
> +	struct hists *hists = he->hists;
> +	struct evsel *evsel = hists_to_evsel(hists);
> +	char *buf = hpp->buf;
> +	size_t size = hpp->size;
> +
> +	ret = __hpp__fmt_print(hpp, hists, get_field(he), he->stat.nr_events,
> +			       fmt, len, print_fn, fmtype);
> +
>  	if (evsel__is_group_event(evsel)) {
>  		int prev_idx, idx_delta;
>  		struct hist_entry *pair;
> @@ -72,30 +79,16 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
>  
>  			while (idx_delta--) {
>  				/*
> -				 * zero-fill group members in the middle which
> -				 * have no sample
> +				 * zero-fill group members in the middle which have
> +				 * no samples, pair->hists is not correct but it's
> +				 * fine since the value is 0.
>  				 */
> -				if (fmtype != PERF_HPP_FMT_TYPE__RAW) {
> -					ret += hpp__call_print_fn(hpp, print_fn,
> -								  fmt, len, 0.0);
> -				} else {
> -					ret += hpp__call_print_fn(hpp, print_fn,
> -								  fmt, len, 0ULL);
> -				}
> +				ret += __hpp__fmt_print(hpp, pair->hists, 0, 0,
> +							fmt, len, print_fn, fmtype);
>  			}
>  
> -			if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
> -				ret += hpp__call_print_fn(hpp, print_fn, fmt, len,
> -							  100.0 * period / total);
> -			} else if (fmtype == PERF_HPP_FMT_TYPE__AVERAGE) {
> -				double avg = nr_samples ? (period / nr_samples) : 0;
> -
> -				ret += hpp__call_print_fn(hpp, print_fn, fmt,
> -							  len, avg);
> -			} else {
> -				ret += hpp__call_print_fn(hpp, print_fn, fmt,
> -							  len, period);
> -			}
> +			ret += __hpp__fmt_print(hpp, pair->hists, period, nr_samples,
> +						fmt, len, print_fn, fmtype);
>  
>  			prev_idx = evsel__group_idx(evsel);
>  		}
> @@ -104,15 +97,11 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
>  
>  		while (idx_delta--) {
>  			/*
> -			 * zero-fill group members at last which have no sample
> +			 * zero-fill group members at last which have no sample.
> +			 * the hists is not correct but it's fine like above.
>  			 */
> -			if (fmtype != PERF_HPP_FMT_TYPE__RAW) {
> -				ret += hpp__call_print_fn(hpp, print_fn,
> -							  fmt, len, 0.0);
> -			} else {
> -				ret += hpp__call_print_fn(hpp, print_fn,
> -							  fmt, len, 0ULL);
> -			}
> +			ret += __hpp__fmt_print(hpp, evsel__hists(evsel), 0, 0,
> +						fmt, len, print_fn, fmtype);
>  		}
>  	}
>  
> -- 
> 2.45.1.288.g0e0cd299f1-goog

