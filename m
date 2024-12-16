Return-Path: <linux-kernel+bounces-447994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF82D9F39A3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123D916B104
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF0207DF7;
	Mon, 16 Dec 2024 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSPVYcQ2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0585206287
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376817; cv=none; b=i08nEdBh6bk9ffqB469FD4ZyRSopO2/HOWP7+pq9ENC6cP1y7s350dNbz07XIY9NtZ6bPvn7DHV/ZR3fQNQPuaZzoV2i9JAxZL7hMfy4OJ65PAhkd8jkJYRr6JBCWxeq96sUHd6xfPoVGrFoOUyMoC9L140UMOwyD/q41fuaLao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376817; c=relaxed/simple;
	bh=hJO7PhFFILWqOSoDZ6qlrrhdx3WwQXrpYMxPRM4LBuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJXleR8wGOj92mIdOhTF3WWhzyleGZpWg+21IK8Laec0a0w/h2/5px2xOoFODYWM0WLbRoysXnndqmF5I6Ig9/Q22RfVoaIFM6QJJuHxM6XwmPZP36BcAFEMyV+IOJcijXpMSVdV1kd2y5KjxAL2peDeo45rmPB8FNyuGfP4YB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSPVYcQ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734376814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAcFp9mawsitE6ltl4OckOZ068h+OrWsoh6QDL7J4Vg=;
	b=SSPVYcQ2L6rJKW5GftEy5Eabm0VD/q2OwH3SCKpPSCDr9GzRpxQ/UzyKbcHanFuNO70nWU
	bEzgbGELTs4g9Mlrl8tVNr4Ajp0Q0tuAC4RhONAOjjt4ZsGHJPBLVxB99rWil4U66a5Ch+
	er+xe+1UCcugYzKTs3Z7cq0YbGUWPtw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-cyoXPWvWObWdX3TmoZTNOA-1; Mon,
 16 Dec 2024 14:20:13 -0500
X-MC-Unique: cyoXPWvWObWdX3TmoZTNOA-1
X-Mimecast-MFC-AGG-ID: cyoXPWvWObWdX3TmoZTNOA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70D561956089;
	Mon, 16 Dec 2024 19:20:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.224])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5C73419560A2;
	Mon, 16 Dec 2024 19:20:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 16 Dec 2024 20:19:46 +0100 (CET)
Date: Mon, 16 Dec 2024 20:19:37 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v4 2/6] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <20241216191937.GC374@redhat.com>
References: <Zy4OFlxoRK2jM5zo@localhost.localdomain>
 <20241108190835.GA11231@redhat.com>
 <Zy6QHHakztIXvudC@pavilion.home>
 <20241111120857.5cWFpNkJ@linutronix.de>
 <20241204134826.GA923@redhat.com>
 <Z1DxqJlGM_I8irVQ@pavilion.home>
 <20241205092015.GA8673@redhat.com>
 <Z1F6_cC4bRvcN56T@pavilion.home>
 <20241205102840.GB8673@redhat.com>
 <Z1y6vSznjbCwAvn1@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1y6vSznjbCwAvn1@pavilion.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 12/13, Frederic Weisbecker wrote:
>
> So which way do you prefer do solve the initial problem?

Ah. please do what you think/feel is right.

I can't suggest a better fix anyway.

> > > > 			do {
> > > > 	-			next = work->next;
> > > > 	+			next = READ_ONCE(work->next);
> > > > 				work->func(work);
> > > > 				work = next;
> > > > 				cond_resched();
> > > >
> > > > Perhaps it makes sense before the patch from Sebastian even if that patch
> > > > removes this do/while loop ?
> > >
> > > Hmm, can work->next be modified concurrently here?
> >
> > work->func(work) can, say, do kfree(work) or do another task_work_add(X,
> > work).
>
> Right but then isn't it serialized program order, from the compiler point of view?

Hmm, indeed, you are right. In this case the compiler can't assume it can
"defer" work->next. Thanks for correcting me!

Oleg.


