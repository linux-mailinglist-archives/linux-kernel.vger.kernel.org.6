Return-Path: <linux-kernel+bounces-345082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4BD98B1BE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2259A280EE2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788FDF44;
	Tue,  1 Oct 2024 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="QF5e9rgH"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F14746E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727745719; cv=none; b=CQkk8JGopkOsTpCQcdu+ThmwxA4rL48IUrJych9jlPMRJDlkI3rgCuKV1UNl5L+51cRqDX0Xqym0z3lpkMFo4vX/TxHElbZ3tLFRgwIX1n7vvLx3Bsc+3iN0pBXfRRON0zLUqDVlu4CffzK3IyyaofTEjMcA7rUvZOX/Ufm8Gkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727745719; c=relaxed/simple;
	bh=0Pb6kqwcfzJSuPkPEfi5hivQZgAY9uS6U+YiW7bwzH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIUVUlo/yDkJOS1s04eLZRm2vsHkqzB6nX8qjpwmORs7xB9PO5GZEtZrGi25on5oKlSTHJN5/avFkOSr0Zz2sjIb72zmnyvjMvAz5synlQYntmKV6Z0Q0SePKzgIScuxBL42x4IlbQglfq1MKoxR+D+IGR6dZrvDPegJIrzZFnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=QF5e9rgH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9b049251eso392496585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727745716; x=1728350516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9EMKkGY8JiQyUELW/D0h8veqZgb1ODzmtoXQOTbwGZQ=;
        b=QF5e9rgH4NVAksR/8qs6HRYLBasvdNfOyp2WbnsUQhalLlWyBk/YEfDQyCfXkSkh/a
         TFDMH0zooDF6rLW78PGAcyVRQ6U9ildI+GnHYRk6WsGePiQjcmkXM4fgxGSRhAV6GZ20
         6jsJYD/3gQtM6nnsbWLHizo+m66QCAfwGNiKD8LXsbI0NKTSbjwcqa4Fe4iycI7veNq+
         v5oaNKfUcbDgGILKChZcB8h9SiucjScaLwf9uVp2dPwi9crA9RPwvxkjmzigKOleCB49
         7I7iGE7z4fBMLdvjU10TdM6rDoqFzSTQ5413NE8tiXNrd4ZExOFuCtk2eFC0C6efemaq
         cRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727745716; x=1728350516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EMKkGY8JiQyUELW/D0h8veqZgb1ODzmtoXQOTbwGZQ=;
        b=apzNd/KYw9E8/5oiJ1ISyAGQiM+y5CiPrevzXrkOeeNMMEHVEn+JDc41HQiZ2NQYZe
         97LXs4PFKB6xBOOG7cRpaYZh2zpRGJ2BnYqpd43wuhsrv73CD13YTiR410sZWJyQD0ks
         JyWX0ry9TBULTxZJ6cgH9HO9vNizQ7/UrDGryyWJGu6Hj6yD0UfwsJqrbaZYq9s/SjIx
         hOqMX328sQfH0SQF9zY1LGphKiBjMdhr0z4FP+yFl98K+QjLDhylp9NxWbKlkjVrD2Rs
         naig8nWROZPU/+9poH6shQkVXmXSfkReta+DchYtnvqQitKCfHeYHMCyytM4GQ/wcExa
         33nA==
X-Forwarded-Encrypted: i=1; AJvYcCWJSFVPtW+/xTFxnuT6in7gkUtEarD6gjQSmyfncnLyLwtDOHpyBchVf0J6/c8vJgpFGvg8a/gvURhF/Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwyAehA+5eD0A/PnrVqukjFQ6C1ebDnkFhaGbImWHoynz/cNFS
	DKB5eLscVf1bP3T7xjNsNEa6mpRGJu82+t1io9wioURnaojDIw9c2rDNhkPAE4yO2Li10ubWGOX
	q
X-Google-Smtp-Source: AGHT+IHWLGA/BaXge2RcFCFj7nmUHQiL0UVsYGGIs/pHqYhtUX1ZqWjMo4zVt1XrL4p/22F3GB8azA==
X-Received: by 2002:a05:620a:1aaa:b0:79f:af4:66f1 with SMTP id af79cd13be357-7ae378c2cbfmr2350170585a.50.1727745715641;
        Mon, 30 Sep 2024 18:21:55 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3783d086sm454654985a.107.2024.09.30.18.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 18:21:55 -0700 (PDT)
Date: Mon, 30 Sep 2024 21:21:53 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Parag W <parag.lkml@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	pmenzel@molgen.mpg.de, regressions@lists.linux.dev,
	surenb@google.com, tglx@linutronix.de
Subject: Re: Error: psi: inconsistent task state! task=1:swapper/0 cpu=0
 psi_flags=4 clear=0 set=4
Message-ID: <20241001012153.GC1349@cmpxchg.org>
References: <20240922102047.GA437832@cmpxchg.org>
 <20240923120339.11809-1-parag.lkml@gmail.com>
 <20240923154601.GC437832@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923154601.GC437832@cmpxchg.org>

On Mon, Sep 23, 2024 at 11:46:08AM -0400, Johannes Weiner wrote:
> On Mon, Sep 23, 2024 at 08:03:39AM -0400, Parag W wrote:
> > FWIW, moving psi_enqueue to be after ->enqueue_task() in
> > sched/core.c made no difference - I still get the inconsistent task
> > state error. psi_dequeue() is already before ->dequeue_task() in
> > line with uclamp.
> 
> Yes, that isn't enough.
> 
> AFAICS, in psi want to know when a task gets dequeued from a core POV,
> even if the class holds on to it until picked again. If it's later
> picked and dequeued by the class, I don't think there is a possible
> call into psi. Lastly, if a sched_delayed task is woken and enqueued
> from core, psi wants to know - we should call psi_enqueue() after
> ->enqueue_task has cleared sched_delayed.
> 
> I don't think we want the ttwu_runnable() callback: since the task
> hasn't been dequeued yet from a core & PSI perspective, we shouldn't
> update psi states either. The sched_delayed check in psi_enqueue()
> should accomplish that. Oh, but wait: ->enqueue_task() will clear
> sched_delayed beforehand. We should probably filter ENQUEUE_DELAYED?
> 
> This leaves me with the below diff. But I'm still getting the double
> enqueue with it applied:
> 
> [root@ham ~]# dmesg | grep -i psi
> [    0.350533] psi: inconsistent task state! task=1:swapper/0 cpu=0 psi_flags=4 clear=0 set=4
> 
> Peter, what am I missing here?

Peter, any thoughts on this? It appears to be a regression caused by
152e11f6df293e816a6a37c69757033cdc72667d.

It's not just the warning in dmesg. The task state corruption causes a
permanent CPU pressure indication, which messes with workload/machine
health monitoring.

