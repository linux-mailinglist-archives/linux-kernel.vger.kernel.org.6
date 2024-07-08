Return-Path: <linux-kernel+bounces-244654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6F892A76F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667E7281391
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1A1146597;
	Mon,  8 Jul 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhzgwbCG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12813A3FF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456653; cv=none; b=niVYzVhs0yn9T9lrEYnIafrWNCACYJ48T6nxpPRGFSyVxdrF+NiENif0eT5g0TZCzo4MOeUiRl36PCsO7a3B5TF2nnCITsXiEBGdcvis2JbtFzcw05iKAYu1rACddAADMtkvXoK6Ny7FUsAcdPLZzaJOdbxnX1FWtrya4yOsdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456653; c=relaxed/simple;
	bh=kDcbHjwgPyuefWVKv/pNk6ua7WnA7T4u7uZWV8tH5Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb4cuyEPLXB9hHXrI4QAkCDOY9ooS4iwQHdLwzt02iffAczANs2uPQWB8h3TrXXzKth0NHhsadpdBGVYtExddogOSCwEOx58HUED5AwtxySN2Fp7V9CvmsGIUmFJQ34ckuX4xoaV1U3hg8nrUwb5nYtzAeT5j6SNUHkiQ6gLcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhzgwbCG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720456650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AbDyKf/92TqlYnLhXEQPoYqdtflY1u/aK6V6CtlGINo=;
	b=NhzgwbCGHubP798iqZZ+kxNvZ7lrZ2mWVxFR7eM5eId6b12hQfXWiM1RldMtV4fsu9jIOI
	cfhwGkGZcCfx96PtauhBNe7gCp5cOjeJEUyDNxubFh53318i5rdAzAPvYMao8DkEDTX864
	TBnC61BYxA2Z919ubLiyHzVrSa5blAA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-7MszoXygPvKnYW5cWmplJw-1; Mon,
 08 Jul 2024 12:37:28 -0400
X-MC-Unique: 7MszoXygPvKnYW5cWmplJw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A457C1935853;
	Mon,  8 Jul 2024 16:37:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.75])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 403921955E83;
	Mon,  8 Jul 2024 16:37:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  8 Jul 2024 18:35:50 +0200 (CEST)
Date: Mon, 8 Jul 2024 18:35:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 04/10] perf/uprobe: RCU-ify find_uprobe()
Message-ID: <20240708163545.GB18761@redhat.com>
References: <20240708091241.544262971@infradead.org>
 <20240708092415.579623285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708092415.579623285@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

I hate to say this again, but I'll try to read this series later ;)

But let me ask...

On 07/08, Peter Zijlstra wrote:
>
> +static void uprobe_free_rcu(struct rcu_head *rcu)
> +{
> +	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
> +	kfree(uprobe);
> +}
> +
>  static void put_uprobe(struct uprobe *uprobe)
>  {
>  	if (refcount_dec_and_test(&uprobe->ref)) {
> @@ -604,7 +612,7 @@ static void put_uprobe(struct uprobe *up
>  		mutex_lock(&delayed_uprobe_lock);
>  		delayed_uprobe_remove(uprobe, NULL);
>  		mutex_unlock(&delayed_uprobe_lock);
> -		kfree(uprobe);
> +		call_rcu(&uprobe->rcu, uprobe_free_rcu);

kfree_rcu() ?


>  static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
>  {
> -	struct uprobe *uprobe;
> +	unsigned int seq;
>
> -	read_lock(&uprobes_treelock);
> -	uprobe = __find_uprobe(inode, offset);
> -	read_unlock(&uprobes_treelock);
> +	guard(rcu)();
>
> -	return uprobe;
> +	do {
> +		seq = read_seqcount_begin(&uprobes_seqcount);
> +		struct uprobe *uprobe = __find_uprobe(inode, offset);
> +		if (uprobe) {
> +			/*
> +			 * Lockless RB-tree lookups are prone to false-negatives.
> +			 * If they find something, it's good.

Is it true in this case?

Suppose we have uprobe U which has no extra refs, so uprobe_unregister()
called by the task X should remove it from uprobes_tree and kfree.

Suppose that the task T hits the breakpoint and enters handle_swbp().

Now,

	- X calls find_uprobe(), this increments U->ref from 1 to 2

	  register_for_each_vma() succeeds

	  X enters delete_uprobe()

	- T calls find_active_uprobe() -> find_uprobe()

	  __read_seqcount_begin__read_seqcount_begin() returns an even number

	  __find_uprobe() -> rb_find_rcu() succeeds

	- X continues and returns from delete_uprobe(), U->ref == 1

	  then it does the final uprobe_unregister()->put_uprobe(U),
	  refcount_dec_and_test() succeeds, X calls call_rcu(uprobe_free_rcu).

	- T does get_uprobe() which changes U->ref from 0 to 1, __find_uprobe()
	  returns, find_uprobe() doesn't check read_seqcount_retry().

	- T returns from find_active_uprobe() and plays with the "soon to be
	  freed" U.

Looks like __find_uprobe() needs refcount_inc_not_zero() or return NULL, but
I am not sure this is the only problem...

No?

Oleg.


