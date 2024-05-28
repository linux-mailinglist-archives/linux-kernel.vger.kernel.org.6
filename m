Return-Path: <linux-kernel+bounces-192742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A58D2182
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ECA1B2304C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D233E172BD8;
	Tue, 28 May 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kk1LlkUh"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7D172786
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913290; cv=none; b=iUJ4SYetisiZV6V1uewKR5rpawbJApk/rlJkfsujC9tZmo0Aux8eOqsitylQEpKZ9+G6g4odBmuVyhlmxnNj7OJJOJl+6RroL0n7WR2y59Oxn/exbEWiu5V5qB0bktBLTOfjEjMEHEBwfO/SVFCK04wBywsHh79krvPKFhmVK80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913290; c=relaxed/simple;
	bh=Biu4PBBspoqGQ3J7fgglu/BUZ6uUOiZAOORBWSaUKy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQTFIXZ+L2Khl8oeuHWv/V+oRQ/qFk7Wrr6kqW9HM4guTvt04CGNh1AbWahfX7lFeOpMPkZHHPr5CKcZjI7+kx05fhqPckKeznLkTUbayFMuwYmY2OBhzjILhf9TGzWHhZEvzuT6s4nDHVJWwtH6y9ktLZHoMJqYz+cZ/PlYTw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kk1LlkUh; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716913286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yuktqrfd31OkWOROGNmSkwGnkxmTBVn2VgOEo4Ue4P4=;
	b=Kk1LlkUhvRu0ERT35QVz+9NWUESdBeuDKd/X62727Y+kM8i/6ZCwLGAs+Wy+NxMHFZQke1
	NMFqhXFreeY0TihVufHlBN1vGNTfoSzFnU2jFRdGKOo8Lt9DobDHYkcWRmdnm9xmQbKtp6
	uVV7ICwDx5v6coFe53oMYyOXeZgFSKc=
X-Envelope-To: bigeasy@linutronix.de
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tglx@linutronix.de
Date: Tue, 28 May 2024 09:21:22 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] memcg: Remove the lockdep assert from
 __mod_objcg_mlstate().
Message-ID: <iww7fbadwh6srabn42qpyhskvhv4jvyibq6xjuhsnrxkmguuqu@mv76yy3aqi4h>
References: <20240528121928.i-Gu7Jvg@linutronix.de>
 <09e085bb-f09e-4901-a2dd-a0b789bb8a4d@kernel.org>
 <20240528134027.OxDASsS3@linutronix.de>
 <c84d6962-34fa-42e5-899c-925579cbfb26@kernel.org>
 <20240528141341.rz_rytN_@linutronix.de>
 <dk4tgppzjy53qr6274cetbyhqjjvsvmjgtknzrsueagoomuchb@sxolann3nib6>
 <897354c6-764b-4f3f-9ece-2feafb0222e9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <897354c6-764b-4f3f-9ece-2feafb0222e9@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 05:07:06PM GMT, Vlastimil Babka (SUSE) wrote:
> On 5/28/24 4:59 PM, Shakeel Butt wrote:
> > On Tue, May 28, 2024 at 04:13:41PM GMT, Sebastian Andrzej Siewior wrote:
> >> The assert was introduced in the commit cited below as an insurance that
> >> the semantic is the same after the local_irq_save() has been removed and
> >> the function has been made static.
> >> 
> >> The original requirement to disable interrupt was due the modification
> >> of per-CPU counters which require interrupts to be disabled because the
> >> counter update operation is not atomic and some of the counters are
> >> updated from interrupt context.
> >> 
> >> All callers of __mod_objcg_mlstate() acquire a lock
> >> (memcg_stock.stock_lock) which disables interrupts on !PREEMPT_RT and
> >> the lockdep assert is satisfied. On PREEMPT_RT the interrupts are not
> >> disabled and the assert triggers.
> >> 
> >> The safety of the counter update is already ensured by
> >> VM_WARN_ON_IRQS_ENABLED() which is part of __mod_memcg_lruvec_state() and
> >> does not require yet another check.
> > 
> > One question on VM_WARN_ON_IRQS_ENABLED() in __mod_memcg_lruvec_state().
> > On a PREEMPT_RT kernel with CONFIG_DEBUG_VM, will that
> > VM_WARN_ON_IRQS_ENABLED() cause a splat or VM_WARN_ON_IRQS_ENABLED is
> > special on PREEMPT_RT kernels?
> 
> It only does something with CONFIG_DEBUG_VM_IRQSOFF and that's disabled by
> dependencies on PREEMPT_RT :)

Thanks for the explanation.

