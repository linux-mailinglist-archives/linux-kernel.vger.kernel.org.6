Return-Path: <linux-kernel+bounces-246574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346BF92C3B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F681C22349
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E9D182A55;
	Tue,  9 Jul 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SON9NnTx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4401B86E9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552174; cv=none; b=By87Fo4aXcT7vFc0UEDJAQqWQY0kgeijZW/MYWDCHD+gdQV+YXw8qL/U3In3QoJi6o4TzP9VNErspXjy8ctimEGJWLur0IX+ii6lJ/wRrElliwqR8WvhCFNyxRg7GsfrS0LDawMPpWWg+iR2WcSe3FheiZW9jyqTOaJ8SnxmPY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552174; c=relaxed/simple;
	bh=80GqaqTeOgHHI4tnQMSIOx4wIsLZkIL6Sr5RMyAQw1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av56KnacPb0vWpY+HLEKp8C5f8rOHippIoxh1UG0VF90HrHfNJMJf54IOiRgtTGQGH97jMduQM5aW3tPHaHkbN2hvDQxarkmnA4KHvA3asMtvgaFtiDWQfznkXnNlhpwH5DDLDjjZB8RXzy1bDzF2Etmat66SdsvPLfV8PVRBf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SON9NnTx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720552172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXZKL8ojyqitWmVdURnWWa13FACQeMHK3/aNjCXRfs4=;
	b=SON9NnTxZMDFVPVOj5752kbd33KeMgvb6GNKOhxgSCQ/6VXpPspD7Z7NL/5VAEly0H7peg
	vouUvpI4ifZZHP9UsKctecL96ZsIjn6Qfk9UIlguvsX/BFA0WICmBmk+QhA+98ybrY12tC
	unsHnCUwMhFSHVn/V9biddqDKpuivrY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-0akiT6_UNpCE_dTNJ7c1cA-1; Tue,
 09 Jul 2024 15:09:27 -0400
X-MC-Unique: 0akiT6_UNpCE_dTNJ7c1cA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68B25195608F;
	Tue,  9 Jul 2024 19:09:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.34])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AC32E1955E83;
	Tue,  9 Jul 2024 19:09:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Jul 2024 21:07:49 +0200 (CEST)
Date: Tue, 9 Jul 2024 21:07:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Julian Orth <ju.orth@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] kernel: rerun task_work while freezing in
 get_signal()
Message-ID: <20240709190743.GB3892@redhat.com>
References: <cover.1720368770.git.asml.silence@gmail.com>
 <1d935e9d87fd8672ef3e8a9a0db340d355ea08b4.1720368770.git.asml.silence@gmail.com>
 <20240708104221.GA18761@redhat.com>
 <62c11b59-c909-4c60-8370-77729544ec0a@gmail.com>
 <20240709103617.GB28495@redhat.com>
 <658da3fe-fa02-423b-aff0-52f54e1332ee@gmail.com>
 <Zo1ntduTPiF8Gmfl@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo1ntduTPiF8Gmfl@slm.duckdns.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Tejun,

Thanks for looking at this, can you review this V2 patch from Pavel?
To me it makes sense even without 1/2 which I didn't even bother to
read. At least as a simple workaround for now.

On 07/09, Tejun Heo wrote:
>
> Hello,
>
> On Tue, Jul 09, 2024 at 03:05:21PM +0100, Pavel Begunkov wrote:
> > > -----------------------------------------------------------------------
> > > Either way I have no idea whether a cgroup_task_frozen() task should
> > > react to task_work_add(TWA_SIGNAL) or not.
> > >
> > > Documentation/admin-guide/cgroup-v2.rst says
> > >
> > > 	Writing "1" to the file causes freezing of the cgroup and all
> > > 	descendant cgroups. This means that all belonging processes will
> > > 	be stopped and will not run until the cgroup will be explicitly
> > > 	unfrozen.
> > >
> > > AFAICS this is not accurate, they can run but can't return to user-mode.
> > > So I guess task_work_run() is fine.
> >
> > IIUC it's a user facing doc, so maybe it's accurate enough from that
> > perspective. But I do agree that the semantics around task_work is
> > not exactly clear.
>
> A good correctness test for cgroup freezer is whether it'd be safe to
> snapshot and restore the tasks in the cgroup while frozen.

Well, I don't really understand what can snapshot/restore actually mean...

I forgot everything about cgroup freezer and I am already sleeping, but even
if we forget about task_work_add/TIF_NOTIFY_SIGNAL/etc, afaics ptrace can
change the state of cgroup_task_frozen() task between snapshot and restore ?

Oleg.


