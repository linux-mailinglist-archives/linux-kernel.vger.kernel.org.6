Return-Path: <linux-kernel+bounces-221060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E28190EB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAEBD1F223E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD6714373D;
	Wed, 19 Jun 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPB+k6o2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E86F1422A2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801004; cv=none; b=uDPwGQ+r7dZoe4/DyDkdxmGx/LShTyJ6+E+uhfh7W//jYJxRx/K7QQgn2VnUDTDVJjoAki8o9FLf4WExXiJ4Ywmi2vosQDfptPR9Wph+UKoxpqN/mv5Au4E4Txi6Uf/26hrq/RpxRUz6eyhy8l4zAUaaKm5tgBnQoA7Lw7t08Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801004; c=relaxed/simple;
	bh=8DOB/d48t2pWusmnExKrkeBR1xLBOr5S97SWCqbn0EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKgDb5KSYyO1FVmY72pVhmSr1AIu4+EqhKsK6RgRT8d2g7kTHsWDeD7ShOq+s35PL3NLnKSTFEcWPEvOaGfNQzPHUZOepBBubhfX9hvv1s4v59wWsciCiZgCyz49K799trG4mZJzhVoSHEf0hklxX+lNcyo3epidwXoZdzo+0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPB+k6o2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA87AC2BBFC;
	Wed, 19 Jun 2024 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718801003;
	bh=8DOB/d48t2pWusmnExKrkeBR1xLBOr5S97SWCqbn0EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPB+k6o2hGcwArkCZuQakYDAFr5Z2cZPY/zv61ozbCT867EPZ0fppVD1vjoaUNQmN
	 +NCkkjlqN94dzLQ9+Jw7e8pnP7XzZJs0lL8hSbjhtx/6mLtYDFGjBgv51oqH+m8+1k
	 KCxyknyoOZSJ3RYTY3o8KD53OvAmGDjcVi+sxPBX880sc4TIKoPY+d70BwaiIiG8Hl
	 K0VOj3SgIWgpyaHigMdAbUIoUZXsIIHOsiIIf1sMHaU3Wmc4CvTPQZEwkgGMrxS3GI
	 +4kjzlsASwuRgmJn3MXDkL6CuwjqadD2kMrAZrfES9vuZdi9tfXuch3PsBHPrSmDuO
	 r1gRBFbv5VJog==
Date: Wed, 19 Jun 2024 13:43:18 +0100
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, rostedt@goodmis.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	chenqiwu <qiwuchen55@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	puranjay12@gmail.com
Subject: Re: [PATCH] arm64: stacktrace: fix the usage of
 ftrace_graph_ret_addr()
Message-ID: <20240619124318.GA3410@willie-the-truck>
References: <20240618162342.28275-1-puranjay@kernel.org>
 <ZnHHHmEv-oqaXmq0@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnHHHmEv-oqaXmq0@J2N7QTR9R3>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jun 18, 2024 at 06:42:54PM +0100, Mark Rutland wrote:
> On Tue, Jun 18, 2024 at 04:23:42PM +0000, Puranjay Mohan wrote:
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index 6b3258860377..2729faaee4b4 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -25,6 +25,7 @@
> >   *
> >   * @common:      Common unwind state.
> >   * @task:        The task being unwound.
> > + * @graph_idx:   Used by ftrace_graph_ret_addr() for optimized stack unwinding.
> >   * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
> >   *               associated with the most recently encountered replacement lr
> >   *               value.
> > @@ -32,6 +33,7 @@
> >  struct kunwind_state {
> >  	struct unwind_state common;
> >  	struct task_struct *task;
> > +	int graph_idx;
> 
> Minor nit, but could we make that:
> 
> #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> 	int graph_idx;
> #endif
> 	
> Regardless, this looks good to me, and I've tested it with a few
> stacktrace scenarios including the example from commit:
> 
>   c6d3cd32fd0064af ("arm64: ftrace: use HAVE_FUNCTION_GRAPH_RET_ADDR_PTR")
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
> Steve, what's your plan for merging the ftrace bits, and how should we
> stage this relative to that? e.g. would it make sense for this to go
> through the ftrace tree along with those changes so that this doesn't
> end up transiently broken during the merge window?
> 
> Catalin, Will, do you have any preference?

I think it makes most sense if this patch travels together with
29c1c24a2707 ("function_graph: Fix up ftrace_graph_ret_addr()"), so that
would be via Steve's tree. In which case:

Acked-by: Will Deacon <will@kernel.org>

Will

