Return-Path: <linux-kernel+bounces-317707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5DE96E28D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F422868C4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DD3189514;
	Thu,  5 Sep 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Z38w+qqs"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4FB8821
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725562782; cv=none; b=okANwhAdsTaAW2PNXA/dxiRoxY2GTMHgEDDBw2A7FOVemQxbxpRs16My010rFPeoFI9lIwmW3/mG50JHYr6y155CIjty+n8/BtaWNWUchxKh5q84x4BNY6lZOrwAPbxSFhxB9oc+SfvfHNSr5ps+uUYFRp600h9TC9Z5F0/sPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725562782; c=relaxed/simple;
	bh=i5FclfWCii5Rvdb3jy3BvdpoUPMPQ/QF4e7NzxKe9Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osHCGv4FUCPHdq8ILxEBryh9QdFMRUomr7ACCB6wUkf+djnvhwgmgrpb+QpFSc4YJQlw34s0q8ddhW7NHfk0MNSzfbuVxWyP/8IV6NMKH+bgUVngaHlaT3ClNfOkzHRNZpHPUU8JcNsMyUgHR1E2x+X+JWpPEBWV8Rj6Z9rwo8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Z38w+qqs; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d87196ec9fso843632a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725562780; x=1726167580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2xXMiJkXG/XKel4c9liX97+zREFCecgH1QTxtXCOAOg=;
        b=Z38w+qqsLmoFEl2COWAv2kXtKFkHQWIQI2DF1HTdWBfc9GwbwT45gbaqQbbX0UkZQW
         rx1xWx6CVZfPSYewDgXAuPlk5N0cUn9RkO4nyi/JCX6GKi30jLn5PzttTU7L+fEhbwrM
         3WaODjds2/S91Yq8TW1VhKYahBLF2buGVYp9pNpPMyY7th5QXZEsuPO/tIE2mMzICo/Z
         nOjKRcX3Hr9IgJiyJAyr8tuInm+GJkhfZvqdW2HRjxb9bqTAEvWqXtf6kx/zaN+1AI/R
         5DzEYenFLUNR6LHEqNzoNgHZaw24e2YLxPACVZk4sn6FR05iaJHiI9JWg/hGtNbiSrUq
         keeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725562780; x=1726167580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xXMiJkXG/XKel4c9liX97+zREFCecgH1QTxtXCOAOg=;
        b=YvooQG6+EUnjlOpvV+0x7MxMO2ogwqXAH8Nj48vItAljx5C6nZVNc8R5aXzV78fYm/
         895+qYKHNqq7m/7VluGstKR7jJh/vH/MdbNNBXS0vgWW3tsiYJM8s1iVqVec/N0b0hdf
         FhHbIQp1UuM6nK2v8h4+pzcuOQq6ZVJubzusRugsAD5LAcMCfzczcJdSAMTNV2b1Mh6J
         kRkUSCXUQ4VEVs81jOLaNaEro1fWwdBknOFsi/WdgFrMTB0WPN+yimw8dliWU2OqSkDT
         7IOPRRFMF3Tw8nJxSeqtPsfDkA++bfL6Oxqi5mJNSLLglCyBduwJiPXcOitj8XrM8WFy
         ZOuw==
X-Forwarded-Encrypted: i=1; AJvYcCXjT599WhyMK5I7AaAUN9RrO1uSmiHgzXw23LsBVjWZWqFVhEfM+mTWmdRBItjeOELJRZWYGXYQQfCFYtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJO5FJCYbdrlf20z1cc5cD4vBABVHJf7u8nd/RuZlLh+WfGAov
	hxOVfoQIJiJAYNrF27DfCdmXOGXN8hiFqspqFYzQGeLhFKD1Dbibx3uOSxWWzl4=
X-Google-Smtp-Source: AGHT+IEVMsGYRIMYoYrLXhgGX529BCqZqaiW5JOf6OWz1PJJ0pylM38eCYzRjQlDPAxY0di9xcEO7w==
X-Received: by 2002:a17:90a:c086:b0:2d8:816a:69c5 with SMTP id 98e67ed59e1d1-2dad501ba04mr364098a91.23.1725562780154;
        Thu, 05 Sep 2024 11:59:40 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8446f3949sm18406441a91.48.2024.09.05.11.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 11:59:39 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:59:37 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf: Add perf_evsel__id() function
Message-ID: <Ztn/mRDqPSpmliWq@ghost>
References: <20240823-perf_evsel_get_id-v1-1-0ffa204c4164@rivosinc.com>
 <ZtkyCWXVjnn-hjUT@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtkyCWXVjnn-hjUT@google.com>

On Wed, Sep 04, 2024 at 09:22:33PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Aug 23, 2024 at 11:58:38AM -0700, Charlie Jenkins wrote:
> > Introduce perf_evsel__id() to collect the id of an evsel. It is not
> > currently possible when using libperf to determine the id of an evsel.
> > This will allow applications to link the id returned by PERF_SAMPLE_ID
> > to the event being sampled.
> 
> I'm not sure what's your use case.  We have evlist__id2evsel() to
> convert sample-ID to evsel already.  It'd read the IDs from perf data
> file.

That function is unfortunately not exposed to be used by applications.
This patch is for libperf, not for the util internals of userspace perf.
Since I am using libperf (and not the python wrapper) I am collecting
data directly from the mmap buffer and not from the perf data file. The
mmap buffer only contains the id of the sample, and no way of
associating this id with the evsel that is backing the id using only
libperf API functions. A libperf function that provides a pointer to the
associated evsel could be another alternative to this. However an API
that returns a pointer to the evsel is not very useful as libperf
applications cannot read members of perf structs, as the layout of perf
structs are not part of the API.

> 
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  tools/lib/perf/Documentation/libperf.txt |  2 ++
> >  tools/lib/perf/evsel.c                   | 10 ++++++++++
> >  tools/lib/perf/include/perf/evsel.h      |  1 +
> >  3 files changed, 13 insertions(+)
> > 
> > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> > index fcfb9499ef9c..69c1d7efb659 100644
> > --- a/tools/lib/perf/Documentation/libperf.txt
> > +++ b/tools/lib/perf/Documentation/libperf.txt
> > @@ -94,6 +94,8 @@ SYNOPSIS
> >    void perf_evlist__enable(struct perf_evlist *evlist);
> >    void perf_evlist__disable(struct perf_evlist *evlist);
> >  
> > +  void perf_evsel__id(struct perf_evsel *evsel, u64 *id);
> > +
> >    #define perf_evlist__for_each_evsel(evlist, pos)
> >  
> >    void perf_evlist__set_maps(struct perf_evlist *evlist,
> > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > index c07160953224..765b17045342 100644
> > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > @@ -484,6 +484,16 @@ int perf_evsel__disable(struct perf_evsel *evsel)
> >  	return err;
> >  }
> >  
> > +int perf_evsel__id(struct perf_evsel *evsel, __u64 *id)
> > +{
> > +	int i;
> > +	int err = 0;
> > +
> > +	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> > +		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ID, (unsigned long)id, i);
> 
> IIUC this would update the place pointed by 'id' for every fd then you
> will get the last ID only.

Yes I have a misunderstanding with how this is supposed to be written.
Can there be multiple ids associated with a given evsel? When parsing
the data in the mmap buffer, I want to be able to associate a sample id
with the event encoding. I suppose an API to get the evsel from an id,
and then require libperf applications to search some data structure to
get the associated event with the evsel is reasonable.

- Charlie

> 
> Thanks,
> Namhyung
> 
> > +	return err;
> > +}
> > +
> >  int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
> >  {
> >  	int err = 0, i;
> > diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> > index 6f92204075c2..1457e5a46b28 100644
> > --- a/tools/lib/perf/include/perf/evsel.h
> > +++ b/tools/lib/perf/include/perf/evsel.h
> > @@ -41,6 +41,7 @@ LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx
> >  LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
> >  LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
> >  LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
> > +LIBPERF_API int perf_evsel__id(struct perf_evsel *evsel, __u64 *id);
> >  LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
> >  LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
> >  LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
> > 
> > ---
> > base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
> > change-id: 20240822-perf_evsel_get_id-f7e11f15504b
> > -- 
> > - Charlie
> > 

