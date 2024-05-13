Return-Path: <linux-kernel+bounces-177069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836D78C39BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 03:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 011E6B20B14
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 01:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB57AD2D;
	Mon, 13 May 2024 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEPmqErU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6E4C8F
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715562403; cv=none; b=R7h88yPPEJnfs9SJHc4yCq4Tsd1hERQqeCnzDEYdwAaNBsW2sCIGLoqQMQ206zFJR9QbblbqvZbLWBWQBI4fraR1GlsXeWk6KVldnUcSGH+q/DIZURxUv9FM4RXjdXc7/jpgbBhCGZltIoA5spAmw2ydVVLTqpUW0kghbBpXmZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715562403; c=relaxed/simple;
	bh=ezi5JG5jGeRIMP4maaRmb26rGRyip+vMxbnGTkqsVGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/lF9Q2PkRR5vXKSQjotWrmlgyLN8RFVe/7NJCSp7jeZRaf1apAaABvJSRwTH85RMBp8dCypRH6t6m+d2/WXDo02AL3zyzz8P8vwPi1pn/aNJSfCDQB2aRLzUO3X/g77GpmDKhFTfgB0zp5SZ1I/bTXtiFc5KjiXFYqErMr0zFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GEPmqErU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715562400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MyrT71GcyLYykYsEHxxBn+570CfbXvsmsIsSXNOh8M=;
	b=GEPmqErUPPMbPAoWZvn1zdB5MUKUpOOqsXtI6YINarramTKKrkS5W+qEVrgVSCphZeCCys
	yGV080s9CdgroGGnPN/yp4qEnKs6CL0laoi1bZ5xJnBc4CwvT4GMkD27Xh+WMtcfnQxv+y
	UAO+C94k5KBNzzhu+IsjsK5Fbo/L8wc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-8OscVjmtPX2G7pk1n611Vw-1; Sun,
 12 May 2024 21:06:37 -0400
X-MC-Unique: 8OscVjmtPX2G7pk1n611Vw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3B551C05149;
	Mon, 13 May 2024 01:06:36 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AB61B40C6EB7;
	Mon, 13 May 2024 01:06:35 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 0C35B400DF3F8; Sun, 12 May 2024 22:06:20 -0300 (-03)
Date: Sun, 12 May 2024 22:06:20 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] kvm: Note an RCU quiescent state on guest exit
Message-ID: <ZkFnjDZRB2x/tzVt@tpad>
References: <20240511020557.1198200-1-leobras@redhat.com>
 <ZkE4N1X0wglygt75@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkE4N1X0wglygt75@tpad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Sun, May 12, 2024 at 06:44:23PM -0300, Marcelo Tosatti wrote:
> On Fri, May 10, 2024 at 11:05:56PM -0300, Leonardo Bras wrote:
> > As of today, KVM notes a quiescent state only in guest entry, which is good
> > as it avoids the guest being interrupted for current RCU operations.
> > 
> > While the guest vcpu runs, it can be interrupted by a timer IRQ that will
> > check for any RCU operations waiting for this CPU. In case there are any of
> > such, it invokes rcu_core() in order to sched-out the current thread and
> > note a quiescent state.
> > 
> > This occasional schedule work will introduce tens of microsseconds of
> > latency, which is really bad for vcpus running latency-sensitive
> > applications, such as real-time workloads.
> > 
> > So, note a quiescent state in guest exit, so the interrupted guests is able
> > to deal with any pending RCU operations before being required to invoke
> > rcu_core(), and thus avoid the overhead of related scheduler work.
> 
> This does not properly fix the current problem, as RCU work might be
> scheduled after the VM exit, followed by a timer interrupt.
> 
> Correct?

Not that i am against the patch... 

But, regarding the problem at hand, it does not fix it reliably.


