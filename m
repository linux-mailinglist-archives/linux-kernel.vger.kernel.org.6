Return-Path: <linux-kernel+bounces-545301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB31A4EB2C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD6F7A1A00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E7824EAA2;
	Tue,  4 Mar 2025 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeqh3NTv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BC620E6E2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111711; cv=none; b=C+g/Kbc9WL8s1+AnsAQ4px7SVkAW/H4Gph+fecF6TsvhgjnZBLyWBz7UNrHLCSBb6EoTVTL0ytIe9OBiaMTWbKvXooi2vgnIKX5sU3QipaFc7iwektswzpiV+RM5D1sGY62u573GS2D83jQBSW2AgqhBRb2WktpxEF0OdlJCUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111711; c=relaxed/simple;
	bh=7ODIMV7+9QMQYPRvfhJ2u7CgXVNgMDGv+gPG6zETx0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+gq+Gjh7NNJSA2e39PFk4frl4JIoqHR4BG9RsOri/aDe/qAp4fP0G8Cp3/03vK3j84Ut8h9GVEJj3fXEaJbyghp+MMCiF0AvJxaRwkfB4QuZJJiB+5049Sjf9AhiQbBUoO9KpfTnH+Qelp7PL9dx6m5bgxA0MD6XdDVXcsc7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeqh3NTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C724C2BCFD;
	Tue,  4 Mar 2025 18:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741111710;
	bh=7ODIMV7+9QMQYPRvfhJ2u7CgXVNgMDGv+gPG6zETx0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oeqh3NTvjJ2PUdEfikabXpCKVavSw7JQYtVtIfCL8e0hVeU6wOn9lo/0FNm5xbPBg
	 StYMAAea2SbpHh5e4ZqOTjjzkX26l8l2HalH92Bkd8dgq0O9gnQ1n4FEgMZgS+vRnW
	 rLUQmClbvhi5wHuA7J/kCM88JkBU+ZTA6Nxp4sGQ/8gK3Jb1q82JiXP/AzF71ysAmO
	 X7Ph+Xo+16u/Mc1Vl0WupdFOdEC22mldJfxbERMHSTsNkn7e2tKRkU9r+ZtLkM5MF1
	 eD4KjjoCOqdCw8umfkMi88anI8g99I8mw0KuqT+3y9aSgv4CvYvfXkEZYQ/MO6uY27
	 ZcOcjEZQwsybQ==
Date: Tue, 4 Mar 2025 08:08:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <changwoo@igalia.com>, void@manifault.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] sched_ext: Add trace point to track sched_ext
 core events
Message-ID: <Z8dBnf66Opy8IseT@slm.duckdns.org>
References: <20250304104900.154618-1-changwoo@igalia.com>
 <20250304104900.154618-3-changwoo@igalia.com>
 <Z8bwAdeAuNQgJCR2@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8bwAdeAuNQgJCR2@gpd3>

On Tue, Mar 04, 2025 at 01:20:17PM +0100, Andrea Righi wrote:
> On Tue, Mar 04, 2025 at 07:49:00PM +0900, Changwoo Min wrote:
> > Add tracing support to track sched_ext core events
> > (/sched_ext/sched_ext_event). This may be useful for debugging sched_ext
> > schedulers that trigger a particular event.
> > 
> > The trace point can be used as other trace points, so it can be used in,
> > for example, `perf trace` and BPF programs, as follows:
> > 
> > ======
> > $> sudo perf trace -e sched_ext:sched_ext_event --filter 'name == "SCX_EV_ENQ_SLICE_DFL"'
> > ======
> > 
> > ======
> > struct tp_sched_ext_event {
> > 	struct trace_entry ent;
> > 	u32 __data_loc_name;
> > 	s64 delta;
> > };
> > 
> > SEC("tracepoint/sched_ext/sched_ext_event")
> > int rtp_add_event(struct tp_sched_ext_event *ctx)
> > {
> > 	char event_name[128];
> > 	unsigned short offset = ctx->__data_loc_name & 0xFFFF;
> >         bpf_probe_read_str((void *)event_name, 128, (char *)ctx + offset);
> > 
> > 	bpf_printk("name %s   delta %lld", event_name, ctx->delta);
> > 	return 0;
> > }
> > ======
> > 
> > Signed-off-by: Changwoo Min <changwoo@igalia.com>
> > ---
> >  include/trace/events/sched_ext.h | 19 +++++++++++++++++++
> >  kernel/sched/ext.c               |  2 ++
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
> > index fe19da7315a9..50e4b712735a 100644
> > --- a/include/trace/events/sched_ext.h
> > +++ b/include/trace/events/sched_ext.h
> > @@ -26,6 +26,25 @@ TRACE_EVENT(sched_ext_dump,
> >  	)
> >  );
> >  
> > +TRACE_EVENT(sched_ext_event,
> > +	    TP_PROTO(const char *name, __s64 delta),
> > +	    TP_ARGS(name, delta),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(name, name)
> > +		__field(	__s64,		delta		)
> 
> nit: there's an extra space/tab after delta.

I think it's one of common formatting styles for tp definitions. If we don't
like it, we can just them in the future.

> But apart than that LGTM.
> 
> Acked-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.15.

Thanks.

-- 
tejun

