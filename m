Return-Path: <linux-kernel+bounces-345969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29A498BD8B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880F5286C07
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BCE1C3F1A;
	Tue,  1 Oct 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HIISvUsg"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544E1C4603
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789351; cv=none; b=kT660e+bodKGTGPJcvYY4Y8r++8BrdqbxZozIbJvFp164a+zgwvQ4fIMlTLlehIgAaExQKjjisTeQD2/aVgYgbKFHBPY97A6yxVOIWF985pPrn0nmf0HiuoFgN2Sx2aQ28xxAiAuAjCI/nwqHBUCfwFKV4XcVRzyffkE7JzpJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789351; c=relaxed/simple;
	bh=IYoaygpRBTMJrUmK7pC0QpN/YCpoIdhfZOU8zVoAzeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZTh9ARxkW5OxXfCFtrYlRhEtmx36mWv641YepA64cPLHpLw385MiVhnO76LNG1iGGAl50KIUTBPdkP1SdZgEodyKBiAO2ZZrD9YWupNLi3412+8dA/w+xH8y1mY6xY4G/KyVJ/ynp1ZzIL0C8kD32Nlr40U0eAARXQkXAb8hSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HIISvUsg; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 1 Oct 2024 15:29:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727789347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/i/tqFpQA2xa+oZSo2Vy6IX2WtT2U57Ske/NOjlEBc=;
	b=HIISvUsg17M15FWHMG3J+BzZfrzf/v6NWLiY4ErfiEo6BJLrzl7OoA1Y4C7xQd6J/cqDjn
	F7NId9ITzDsSNHMfP+BJ8LM5DpIlrY5KT2oxmwXkhkbw3gkp/M7cCDwHS3+H4MF8yNeoKa
	fw+B10uRK2SqAOhs30IbbucZRWdEdYE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provide a per-scheduler unique sequence
 counter
Message-ID: <Zvv5HpBjzo_T5rub@gpd3>
References: <20240927165901.40313-1-andrea.righi@linux.dev>
 <Zvru7Qx4aZ9MVU6G@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvru7Qx4aZ9MVU6G@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 30, 2024 at 08:33:17AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Fri, Sep 27, 2024 at 06:59:01PM +0200, Andrea Righi wrote:
> ...
> > @@ -662,6 +662,13 @@ struct sched_ext_ops {
> >  	 */
> >  	u64 hotplug_seq;
> >  
> > +	/*
> > +	 * enable_seq - unique per-scheduler counter that can be accessed from
> > +	 * user-space to determine if a scheduler (within a specific hierarchy)
> > +	 * has been restarted.
> > +	 */
> > +	s64 enable_seq;
> 
> Let's just make it a global variable for now. When we package up context for
> each scheduler instance into a struct, it will get packaged up together.
> It's a bit odd to add enable_seq to ops as userspace can't do anything with
> it (note that hotplug_seq is different in that it's provided by the
> userspace on load).

Yep, makes sense, I just sent it because it was mentioned in the other
thread about enable_seq, but we don't really need it right now, so we
can just ignore it for now.

Thanks,
-Andrea

