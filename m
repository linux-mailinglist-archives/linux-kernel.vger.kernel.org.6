Return-Path: <linux-kernel+bounces-246150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D9C92BE39
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC0328475E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE2E19D088;
	Tue,  9 Jul 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Deo3ZWRs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CF115DBB9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538728; cv=none; b=sDB91lny9FyH25pFaaBxkxEQ+FlhqkHh2Exfe4twwncSfMAeudHrU9MIg+r1xGXekq2N7CYc9kqOmzNQjDaGMKETXimg2pLt1uP6/AZ5e0o2Zf3yxft+ZuWaNgJJ1RnudHEM9RiX1XpT3FL3n+5iF6lPfM2Snl6YJ8GLs+96fdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538728; c=relaxed/simple;
	bh=XvMHVaxVk3n8U541EVDklW08UMJJjmNp5lCm1fexNo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfctQy/wvt4+w252XRR+enFgaz6t/fcvVgNsme87SzM1Jyn4jt51ISQpEwbx8ugDGwRlI6MWk4+eXFJnmqH1REii6/YHe72EXSyD0by//FZUVCZXC55hCpn/BKkeFXpM270VjhtbQLeGmQzOKGtSpTaAoelc6Z21fvd2++R+L8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Deo3ZWRs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720538726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFssJA0QF0Bx2WUDkhYlRONDp2mu9eE6Qb48WiRG5dM=;
	b=Deo3ZWRstmtFvGJSuTPgvN7cjN2WxxcAeTOUp1mRIGLW+YSu90759xpDo/HbGsH7dljVFg
	Prfr4eLvrapYAFUeVH934IcxiSbG9onBL18i4Q0WnVz1RItEGm2pn9smOcNw/H4A454rmI
	uoonDFsEeJWztwXGV0ZyU8r5RWPPBrc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-R9XcdJOeON-t4ijotGHfOA-1; Tue,
 09 Jul 2024 11:25:22 -0400
X-MC-Unique: R9XcdJOeON-t4ijotGHfOA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D562519560AD;
	Tue,  9 Jul 2024 15:25:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.34])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9A2611955F3B;
	Tue,  9 Jul 2024 15:25:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Jul 2024 17:23:44 +0200 (CEST)
Date: Tue, 9 Jul 2024 17:23:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 04/10] perf/uprobe: RCU-ify find_uprobe()
Message-ID: <20240709152340.GG28495@redhat.com>
References: <20240708091241.544262971@infradead.org>
 <20240708092415.579623285@infradead.org>
 <20240708163545.GB18761@redhat.com>
 <20240708180837.GC27299@noisy.programming.kicks-ass.net>
 <20240709143255.GD28495@redhat.com>
 <20240709150205.GO27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709150205.GO27299@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/09, Peter Zijlstra wrote:

> On Tue, Jul 09, 2024 at 04:32:55PM +0200, Oleg Nesterov wrote:
>
> > Once guard(srcu)(&uprobes_srcu) in handle_swbp() drops the uprobes_srcu lock,
> > utask->active_uprobe can be freed.
>
> Yeah, I've fixed all those already. It's a bit of churn, adding
> inc_not_zero all over the place

I am wondering if we can move delayed_uprobe_remove() from put_uprobe()
to delete_uprobe()... probably not, I forgot everything.

But if we can, then we can probably do

	put_uprobe(uprobe)
	{
		if (refcount_dec_and_test(&uprobe->ref))
			kfree(uprobe);
	}

	uprobe_put_rcu(struct rcu_head *rcu)
	{
		uprobe = container_of(...);
		put_uprobe(uprobe);
	}

	delete_uprobe(uprobe)
	{
		rb_erase(...);
		delayed_uprobe_remove(...);
		...

		call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_put_rcu);
	}

and avoid inc_not_zero.

Not sure, I am already exhausted ;)

Oleg.


