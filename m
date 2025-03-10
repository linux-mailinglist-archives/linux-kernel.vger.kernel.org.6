Return-Path: <linux-kernel+bounces-554203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67045A5949B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5FA1889989
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E112227EBD;
	Mon, 10 Mar 2025 12:32:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B7227EAB;
	Mon, 10 Mar 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609941; cv=none; b=Z/xJwd75mu+Ss9Vhk4FAehYeBQ2maQjujTEVgW3sGCKg3KgXeFmLjIhbS48+wqMLh2e5YpeXEqbTY7RO7yNO5ijyydP4lGFh6K4UcZLlSX00rnLcNEQKIZiBsLbWjdOzBzvFxEUNTCfkxxkLMObq8lBzM+OGDLIAwAPNAeZcKOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609941; c=relaxed/simple;
	bh=exkXYUE0FeKGBzwmCRFCISHi0LQL8ZF9Eb/Tz0O8Sss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEx+lnhqwthC8uMIBazoWKTCMre2tEnDYN444Arib2gAdXMq0oTxLIaM8o/ZO+rq+6FQFHheLCCbh3lndAMJKWTFXbLggR9NzX4F/Cpzjg1Dml6EKpHsxU9zXDsh6d5YdJ3ruhFQ003pRFHbEpUjlM/vX4v7A1TAOH5HwK4/s7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E0DA152B;
	Mon, 10 Mar 2025 05:32:30 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ADEA3F5A1;
	Mon, 10 Mar 2025 05:32:18 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:32:13 +0000
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] coresight: Introduce pause and resume APIs for
 source
Message-ID: <20250310123213.GF9682@e132581.arm.com>
References: <20250310104919.58816-1-leo.yan@arm.com>
 <20250310104919.58816-3-leo.yan@arm.com>
 <65979e92-0047-427c-848d-53f908671905@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65979e92-0047-427c-848d-53f908671905@arm.com>

On Mon, Mar 10, 2025 at 12:01:25PM +0000, Suzuki Kuruppassery Poulose wrote:
> On 10/03/2025 10:49, Leo Yan wrote:
> > Introduce APIs for pausing and resuming trace source and export as GPL
> > symbols.
> > 
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-core.c | 20 ++++++++++++++++++++
> >   drivers/hwtracing/coresight/coresight-priv.h |  2 ++
> >   include/linux/coresight.h                    |  4 ++++
> >   3 files changed, 26 insertions(+)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > index 0a9380350fb5..eb7b83a7bfa2 100644
> > --- a/drivers/hwtracing/coresight/coresight-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > @@ -365,6 +365,26 @@ void coresight_disable_source(struct coresight_device *csdev, void *data)
> >   }
> >   EXPORT_SYMBOL_GPL(coresight_disable_source);
> > +void coresight_pause_source(struct coresight_device *csdev)
> > +{
> > +	if (!csdev || !coresight_is_percpu_source(csdev))
> 
> You may remove the !csdev check, coresight_is_percpu_source() already checks
> that.

Will do.

> > +		return;
> > +
> > +	if (source_ops(csdev)->pause)
> > +		source_ops(csdev)->pause(csdev);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_pause_source);
> > +
> > +void coresight_resume_source(struct coresight_device *csdev)
> > +{
> > +	if (!csdev || !coresight_is_percpu_source(csdev))
> > +		return;
> > +
> 
> Same as above.

Will do.

> > +	if (source_ops(csdev)->resume)
> > +		source_ops(csdev)->resume(csdev);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_resume_source);
> > +
> >   /*
> >    * coresight_disable_path_from : Disable components in the given path beyond
> >    * @nd in the list. If @nd is NULL, all the components, except the SOURCE are
> > diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> > index 76403530f33e..a9f14c075e91 100644
> > --- a/drivers/hwtracing/coresight/coresight-priv.h
> > +++ b/drivers/hwtracing/coresight/coresight-priv.h
> > @@ -247,5 +247,7 @@ void coresight_add_helper(struct coresight_device *csdev,
> >   void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev);
> >   struct coresight_device *coresight_get_percpu_sink(int cpu);
> >   void coresight_disable_source(struct coresight_device *csdev, void *data);
> > +void coresight_pause_source(struct coresight_device *csdev);
> > +void coresight_resume_source(struct coresight_device *csdev);
> >   #endif
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index 17276965ff1d..703e1b8dbe22 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -385,6 +385,8 @@ struct coresight_ops_link {
> >    *		is associated to.
> >    * @enable:	enables tracing for a source.
> >    * @disable:	disables tracing for a source.
> > + * @resume:	resumes tracing for a source.
> > + * @pause:	pauses tracing for a source.
> >    */
> >   struct coresight_ops_source {
> >   	int (*cpu_id)(struct coresight_device *csdev);
> > @@ -392,6 +394,8 @@ struct coresight_ops_source {
> >   		      enum cs_mode mode, struct coresight_trace_id_map *id_map);
> >   	void (*disable)(struct coresight_device *csdev,
> >   			struct perf_event *event);
> > +	int (*resume)(struct coresight_device *csdev);
> > +	void (*pause)(struct coresight_device *csdev);
> 
> Given these callbacks are for perf mode, does it make sense to pass the
> parameters similar to enable() ?

It is not necessary to pass perf event handle to resume() and pause()
callbacks.

The main reason is perf related operations have been processed in the
coresight-etm-perf.c layer, the low level's callbacks (pause/resume)
should simply take actions on hardware logic.

> Also, should we rename these as :
> 
> resume_perf
> pause_perf
> 
> To explicitly mark them perf mode specific ?

This makes sense to me.  The naming "resume" might be confused with
CPUIdle's terminology (CPU resume).  pause_perf/resume_perf can
perfectly avoid any confusion.

Thanks,
Leo

