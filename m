Return-Path: <linux-kernel+bounces-425381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B529D9DC156
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E231628A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFA21714D3;
	Fri, 29 Nov 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eKbYS7Na"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F0170A15
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871932; cv=none; b=M3RzdGuqPc1mD/EjE/NTKJR8GeuOSpNNNWkjgGnHttvt+TIHZ/mx4YaQczqzyr8dh1ur3ywYZ8X3R2Y2zQAKFZKs9Wk4reB3eoYidqhB4w1mRr1feDIIln+kKWjxwL0yMrQ8Weolep9KEVaaeojx6+kp6zdcC+fn6bgnqZjolc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871932; c=relaxed/simple;
	bh=KhIhGJSDKJsSqVUnIK738vmv13+9dzdC760/7ev8XOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXNxNBmFevhqmTazDVD7fXSUqXTlE0HJcy0wsSdRG5z3wREp1axgJf+IajukKjQulJAmiYEtCu8vkobbqLsQGe//xOLGFNi9bZgw8UMF3IKZ2hyJJdYvHMibqq8tu8sgOn+uDb61JN/YWx6FqcIdhQcoUSLWnCypQz5YjPu5meA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eKbYS7Na; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T0xzcoPiVpIQE2u/O1Rb0QJLQPq/7zFR/H5vTX4566A=; b=eKbYS7Na6LHmKY4y84dL3lKCkT
	oBhmCcvGJgSNKQ3tYTRzxk8U0GDRlrDVmrCVadp+ZSWCnG3O9zgONj9lxIq9QemmdgX+2hdUOIuJR
	JkyIYSF4ddp6dzPkLeyEyhvtREfQ9xsvdBBuIkd35Q86GD9KwN/L2C9zJIjIJa4GdeNI/VdB8DcU1
	CA7jYog2qE65w6X74eCCq3O8OysdCIRpNCsCcj/8ue4I8xvz3HtuScWtjrPLFzhMh7QKrhHZSZGFA
	+AIuomv50PvhUc26c3kHa7S1iDKlhis5JYQAccaqhMXNGyls1ehrloXak+zEGAtbvy45TkYbGXJFD
	v8TgGS+Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGx90-00000001ih9-3kd1;
	Fri, 29 Nov 2024 09:18:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1703D30026A; Fri, 29 Nov 2024 10:18:34 +0100 (CET)
Date: Fri, 29 Nov 2024 10:18:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Adam Li <adamli@os.amperecomputing.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	patches@amperecomputing.com, cl@linux.com, christian.loehle@arm.com,
	vineethr@linux.ibm.com
Subject: Re: [PATCH v2 2/3] sched/fair: Fix panic if pick_eevdf() returns NULL
Message-ID: <20241129091833.GC15382@noisy.programming.kicks-ass.net>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-3-adamli@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127055610.7076-3-adamli@os.amperecomputing.com>

On Wed, Nov 27, 2024 at 05:56:09AM +0000, Adam Li wrote:
> pick_eevdf() may return NULL, which triggers NULL pointer
> dereference at pick_next_entity():
> 	struct sched_entity *se = pick_eevdf(cfs_rq);
> 	if (se->sched_delayed)
> 
>     [  297.371198] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000051
>     [  297.406112] CPU: 116 UID: 0 PID: 10328 Comm: Grizzly-worker( Tainted: G        W   E      6.12.0.adam+ #1
>     [  297.597362] Call trace:
>     [  297.599795]  pick_task_fair+0x50/0x150 (P)
>     [  297.603879]  pick_task_fair+0x50/0x150 (L)
>     [  297.607963]  pick_next_task_fair+0x30/0x3c0
>     [  297.612134]  __pick_next_task+0x4c/0x220
>     [  297.616045]  pick_next_task+0x44/0x980

Well, if you look at pick_task_fair() you'll see we'll not get there
unless cfs_rq->nr_running is non-zero, at which point pick_eevdf()
really should NOT be returning NULL.

If it does, something else is broken.

