Return-Path: <linux-kernel+bounces-266167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1182A93FBDF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426B61C22172
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A72E158D7F;
	Mon, 29 Jul 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V61BRB7P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A1E78B50
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272023; cv=none; b=bV9z3+Zf/c4IAyM9RpWnmH4vBQ2rTmxgSEMM/vDq7dINK1ubBlnYUzfJv1moqRW0LV1AC//qeeUj/wNy/S88Rdt16wAoMbA9B4rHB6es5M6aP2RuusSnpD6Od1itzRUlSHF7oKx+XVY04iq5yFuiLAPqTZUyQlTV/vqD/spo71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272023; c=relaxed/simple;
	bh=p+N8Ve5P1Ip05fYcKq9Z0+kWjejsON2Cg4gjMupfgNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETYmVHIp/4ckoom9HgTgRhndWf2Mb1AG6IfUi2S8wtC+ruZWOuG3FJZopgHks3vK1V6DO9VivbeIOSQWPP3SMgNLBE+O0oF666CPUcFzmjNSdQk2AMhCoDYh6pVNLyIncIbTN3mbtHd6Ci8Hhk4MbE/D+t4OL7JKGQXkdrmPvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V61BRB7P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722272020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1B0+0v9UoO752ShDZ+sUoeYQDHn6i5gDwvgX32wEnDQ=;
	b=V61BRB7POaK0qEiQNmMIurZTAu4H4DpCAEQauPwREk0YSwdO9CldwNeCRM5+uvqMXGlnGT
	nkpPF5fKgWwSzrDu8KuAzTPfg7afgYnFsuXP/u0XvUFiMi98AID9sjppzMkr5ILaNoi0R9
	lzxmZ6pEhS4Q3afIqqMOG8U/mGQisAA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-1qvuAJt7OVW_3YsQIYnIDw-1; Mon,
 29 Jul 2024 12:53:37 -0400
X-MC-Unique: 1qvuAJt7OVW_3YsQIYnIDw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03D111955D50;
	Mon, 29 Jul 2024 16:53:36 +0000 (UTC)
Received: from localhost (unknown [10.22.34.81])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBEE71955D42;
	Mon, 29 Jul 2024 16:53:34 +0000 (UTC)
Date: Mon, 29 Jul 2024 13:53:33 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: suggest the fix for "lockdep bfs error:-1" on
 print_bfs_bug
Message-ID: <ZqfJDTn9rCQ1eVnz@uudg.org>
References: <ZqKdZZp7TI69DWRE@uudg.org>
 <ZqQUDI3Ai9GP9hUO@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqQUDI3Ai9GP9hUO@boqun-archlinux>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Jul 26, 2024 at 02:24:28PM -0700, Boqun Feng wrote:
> On Thu, Jul 25, 2024 at 03:45:57PM -0300, Luis Claudio R. Goncalves wrote:
> > When lockdep fails while performing the Breadth-first-search operation
> > due to lack of memory, hint that increasing the value of the configuration
> > switch LOCKDEP_CIRCULAR_QUEUE_BITS should fix the warning.
> > 
> > Preface the scary bactrace with the suggestion:
> > 
> >     [  163.849242] Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:
> >     [  163.849248] ------------[ cut here ]------------
> >     [  163.849250] lockdep bfs error:-1
> >     [  163.849263] WARNING: CPU: 24 PID: 2454 at kernel/locking/lockdep.c:2091 print_bfs_bug+0x27/0x40
> >     ...
> > 
> > Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> > ---
> >  kernel/locking/lockdep.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 58c88220a478a..1cf6d9fdddc9c 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -2067,6 +2067,9 @@ static noinline void print_bfs_bug(int ret)
> >  	/*
> >  	 * Breadth-first-search failed, graph got corrupted?
> >  	 */
> > +	if (ret  == BFS_EQUEUEFULL)
> 
> This line has an extra space after "ret", but otherwise it looks fine.

Should I send a v2 of the patch with the extra whitespace removed?

Luis

> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Regards,
> Boqun
> 
> > +		pr_warn("Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:\n");
> > +
> >  	WARN(1, "lockdep bfs error:%d\n", ret);
> >  }
> >  
> > -- 
> > 2.45.2
> > 
> 
---end quoted text---


