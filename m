Return-Path: <linux-kernel+bounces-575525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1512A703C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634AF3BB100
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869325A2B9;
	Tue, 25 Mar 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMmooDw5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44E2561DF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912718; cv=none; b=aZ9s4yEqS1jjANt6fsrNshuEBRf5DIbOCFgtIpsMSv3V2SFH/lWrJf6O/A5ZYiKTw4iQ9N6s/erRLYJ7HsYRa4RVpsxSLp/Vvm/fztBujkhF82E1VqDsYWgSyXF0g/c4/oikFwMQ/GBlK8go0s58A/We6psNn4fmGG5nrEbPWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912718; c=relaxed/simple;
	bh=N0kygDs2Nv9MG/KsCxyOCnV3RH+/UvpzkwPqB1CVxzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asZHo9O7pBzrI/0jrlZj3nTMLQrcTHwOzyqY7K7ZaYeR73sOLKAWrLbiQsmEkYmKHZ1iWtuAVdI2C0Fq/n7hdgV33F5JYKMAXtBuYHyrRCNaMFi6F00AkiCsUqFM21JTwcf2DqTslksOOwOwkDDq4n47Vm4Hc2nQMwuogVHuIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMmooDw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8283FC4CEE4;
	Tue, 25 Mar 2025 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742912716;
	bh=N0kygDs2Nv9MG/KsCxyOCnV3RH+/UvpzkwPqB1CVxzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMmooDw5GZoigLUeg+ulTTHhGAJEU9UKr8r+OG0g/sWCBCH09UBi0up8Ovf9xML11
	 v+ygrEI8DtiyhB3lXFPq/awkQjeovrskcLvsWpaPlmZ9Mu8HjpnndWRUenp9R5DSX0
	 qMkedVjcecKnwfJnUK+4si0B1s8z/fwZL3l5myyfQL5ms0UambAaRGfERKQ+DcwQdI
	 K+MDwjnLy9KWsRgUwAly82RLuub/6m0lYalj3Qwgx97vyYGSf1JPiKYSSbZcrdmtTT
	 NCPaS4C1SLT1M7v9p0mwatzkcRgz8WrHOPvfD77fA32pyU9mRAxUphcSu9eum7r+57
	 SPCpDxuatyaow==
Date: Tue, 25 Mar 2025 15:25:13 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org
Subject: Re: [PATCH 1/6 v2] task_work: Provide means to check if a work is
 queued
Message-ID: <Z-K8yaPo632B6wLj@localhost.localdomain>
References: <20250209223005.11519-1-frederic@kernel.org>
 <20250209223005.11519-2-frederic@kernel.org>
 <20250210124340.GD32480@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210124340.GD32480@redhat.com>

Le Mon, Feb 10, 2025 at 01:43:41PM +0100, Oleg Nesterov a écrit :
> On 02/09, Frederic Weisbecker wrote:
> >
> > @@ -56,6 +56,8 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
> >  {
> >  	struct callback_head *head;
> >
> > +	work->next = TASK_WORK_DEQUEUED;
> 
> Do we really need to do this at the start of task_work_add() ?
> 
> If the caller didn't do init_task_work() before and task_work_add()
> returns -EINVAL we probably do not care?

Yes good point. Let me fix that...

> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 

