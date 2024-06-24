Return-Path: <linux-kernel+bounces-228032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5423A9159D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085921F21ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270061A0708;
	Mon, 24 Jun 2024 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxnb7Mjw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81217BCC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267879; cv=none; b=fwt3A/oqpC87RzPk2TvsueQdBWrlg4SYzi/O5QPiBkYkZEENP6VwbwTv79wlCrRE6JojOZQhALFH/a5AjGJMKM8j5GF8vGvijUCF3sjZ/5T29WCX9sNr0wbx5JofHF80ES+DIpcMe01n29H/bzK7tBJnhR519Y9TJJYm32HzqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267879; c=relaxed/simple;
	bh=NWPkEmxq5Vl0pkyAV8qENe3N073yNs1JpjThfWElkhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGKITErahUHm5r2FDmVP7aB0kmzULrHzQ1Ez83ypK8+voRsotRuPLTNpygUxkAw8rEeACDZBdultLvJHv/CymDDYje+RoD1v3v8jseKqqXXdnz+S0o7GT2rE0jXUqgwAtQffVwgQWkQiK2qIs96W0QYUWgOykXN8zVbOF7NlXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxnb7Mjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D04C2BBFC;
	Mon, 24 Jun 2024 22:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719267879;
	bh=NWPkEmxq5Vl0pkyAV8qENe3N073yNs1JpjThfWElkhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxnb7MjwdXqFeLIO4XzjVRguoy6zmAQvtlIunXbOjBXlD0eC7BMH7A8sBgjHmDMGN
	 sE2hhNo4OopuJ4M5tjdtaro6MrrOyiwfpmCYSMcHt+laUu8RGdzR5silu6aHP527Y3
	 CiNntC7NLd5nw+O4rUsdbvTXgLWE74LfUUqIRa18kAUIhxV6ku42Xg9kLcGhVfuBjI
	 taG1+YjElWtLTTcC1+QhbPeTT/klcK7zVxHyM57rSZlqtZQOm4R//pukg9Ikt3KyH1
	 LJ9zQTkCgjt8IrvES44kGywox0QcXRPa4jMENeG49a2z/D6+UQ3qRjev1nV4ZCmFXj
	 4OxPZ7exxJrmw==
Date: Tue, 25 Jun 2024 00:24:36 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] timer_migration: Fix possible race in
 tmigr_active_up() in setup path
Message-ID: <ZnnyJPPTm8NHqPbf@pavilion.home>
References: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
 <20240624-tmigr-fixes-v2-4-3eb4c0604790@linutronix.de>
 <Znnst52fdxIeBats@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Znnst52fdxIeBats@pavilion.home>

Le Tue, Jun 25, 2024 at 12:01:27AM +0200, Frederic Weisbecker a écrit :
> > +static void tmigr_setup_active_up(struct tmigr_group *group, struct tmigr_group *child)
> > +{
> > +	union tmigr_state curstate, childstate;
> > +	bool walk_done;
> > +
> > +	/*
> > +	 * Memory barrier is paired with the cmpxchg in tmigr_inactive_up() to
> > +	 * make sure updates of child and group states are ordered. The ordering
> > +	 * is mandatory, as the update of the group state is only valid for when
> > +	 * child state is active.
> > +	 */
> > +	curstate.state = atomic_read_acquire(&group->migr_state);
> > +
> > +	for (;;) {
> 
> /*
>  * If the child hasn't yet propagated anything to the top level, the above
>  * acquire has no effect. However thanks to child locking (see comment in
>  * tmigr_connect_child_parent()), either the latest child->migr_state is
>  * observed or the remote CPU now observes the new parent and is about to
>  * propagate to the new parent. In the latter case it will either beat the
>  * current trial update or overwrite it.
>  */
> 
> And another comment later:
> 
> > +		childstate.state = atomic_read(&child->migr_state);
> > +		if (!childstate.active)
> > +			return;

Hmm, on the other hand the remote group doesn't use locking if some tmc activates
after that and so there is no guarantee it will see the new parent. Does it
matter?

Thanks.

