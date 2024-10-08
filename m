Return-Path: <linux-kernel+bounces-355511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAC399534F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1752F1C25942
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F91E0498;
	Tue,  8 Oct 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlC7qGRQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC51DF73A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400955; cv=none; b=G3yRfmQkPYG9IyP0Lqy1ImL7d134kFwEuexd+NfrFtNm4abc/zhlrNHlZL9m7DSoHbhFAGYCAS/p0So1/Fnmxy+feVI1JAWPLEYGszVunSllkFXThlIei5bQewAvOLukC3oTFa6rqoIraNB+h9G8F2B02F20iW1nwH/AVB3MSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400955; c=relaxed/simple;
	bh=36sM4Q1sOGw+kCcI2rfQ73ppgLkiGCgftyKTRR1ozZE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k1OXEo+zbqaWu9GPqJG6V5tWWD7woImRWJ0Cg/ZRxEPX/rz+jTaFxHomfjDQtHOQiuhXal1brwFrDjvufGfAvgiaEWhOsL3iQ3ISFdUaPZDbttrnAsbcOyg2QuTvaOludZHN+/7u3IjldOv/aN1cvOr99NsxvjGuFRGLGwBhoIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlC7qGRQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728400952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rr2UnGu4H8vXDUXzwYqapeIqTXFZ0Lq9umuLzat/RKs=;
	b=XlC7qGRQ3OoVDie52zvh4QmA1dHRR6SMB6sMjTr0De+ZkMZHdb0gYTQkG9APCOgZu8JaGN
	OrphUjFulywVaK86IVvG5deEYqPd2O8S1PCB9C9ovi9ZY7bFGKioWDUlBM30GPhmyZZDcc
	q5qc1hI+BTUMhwry2M3zsr/GLnpL4nA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-jEOa7NPrPq64nu7pjy0KwQ-1; Tue, 08 Oct 2024 11:22:30 -0400
X-MC-Unique: jEOa7NPrPq64nu7pjy0KwQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cae209243so37211155e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 08:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400949; x=1729005749;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rr2UnGu4H8vXDUXzwYqapeIqTXFZ0Lq9umuLzat/RKs=;
        b=kSZkFdXRbZFZ7+H26P6Zi1Cxqdr8yUZgHiBJkX/sdl/xdfwtunhEuUU9+3t8T8JUFG
         tZH5XXddsGzaQLLGvy+INppsIKXb/diKz0uzWZYmPVGL3dWDPYtM2OsH2P3yQPp4i5KV
         2bNf982oDOVhcmwI4TqBKjuCGR3Gkpshjh4Mibu2niVggyLpApX3/Rpju+P8p7gBPGka
         68OctjGzTnnY42reJ+aBO72dQwIE96xZrdv9IZs9kimNCkZ7b+Pw3Kmoh+aykmUEXDLr
         z0E0vrKhnl8GqyKAETw+79CSnuzyKx3sdKaqxQ0L4jSzlnkoQV/6YuTsRDioQfWqUS2x
         MXUw==
X-Forwarded-Encrypted: i=1; AJvYcCWPWCUsiXxXfQt0q1OsLcfFtgF5UwxBtDGym6VjzNv5vs/QxwhVZxypsqfnxOcfA6IzE/CCDsJcADy8+hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJS6a387wX59sOvjab/qn+8/tII+KrmFgOqXXS/JazFn1x/j8M
	wMaHiFR7hCrrcZmWtV/+jTK+ChHpYNxS4taEcW4QRfvcyg/PtcxOhBYMIM6Nnbqs4lQiR2vyzGd
	Nn4tsJ5auExzSjHPz79SP9fBkjswVwpt9Mv1yaaxzlVBdf1pUrLrnbqur6plKHw==
X-Received: by 2002:a05:600c:5359:b0:430:54a4:5b02 with SMTP id 5b1f17b1804b1-43054a45cebmr16890585e9.34.1728400949188;
        Tue, 08 Oct 2024 08:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDjeKQpJKtmhnu6B+7yIWSsUC27Cui6eNPRY5RNqL+CL26Nk9sjrZOhlZRKG0N5F0ozKpyGg==
X-Received: by 2002:a05:600c:5359:b0:430:54a4:5b02 with SMTP id 5b1f17b1804b1-43054a45cebmr16890395e9.34.1728400948809;
        Tue, 08 Oct 2024 08:22:28 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-206.as13285.net. [80.47.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43055e5616bsm15218255e9.6.2024.10.08.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:22:28 -0700 (PDT)
Date: Tue, 8 Oct 2024 16:22:26 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
Message-ID: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

A report concerning latency sensitive applications using futexes on a
PREEMPT_RT kernel brought me to (try to!) refresh my understanding of
how futexes are implemented. The following is an attempt to make sense
of what I am seeing from traces, validate that it indeed might make
sense and possibly collect ideas on how to address the issue at hand.

Simplifying what is actually a quite complicated setup composed of
non-realtime (i.e., background load mostly related to a containers
orchestrator) and realtime tasks, we can consider the following
situation:

 - Multiprocessor system running a PREEMPT_RT kernel
 - Housekeeping CPUs (usually 2) running background tasks + “isolated”
   CPUs running latency sensitive tasks (possibly need to run also
   non-realtime activities at times)
 - CPUs are isolated dynamically by using nohz_full/rcu_nocbs options
   and affinity, no static scheduler isolation is used (i.e., no
   isolcpus=domain)
 - Threaded IRQs, RCU related kthreads, timers, etc. are configured with
   the highest priorities on the system (FIFO)
 - Latency sensitive application threads run at FIFO priority below the
   set of tasks from the former point
 - Latency sensitive application uses futexes, but they protect data
   only shared among tasks running on the isolated set of CPUs
 - Tasks running on housekeeping CPUs also use futexes
 - Futexes belonging to the above two sets of non interacting tasks are
   distinct

Under these conditions the actual issue presents itself when:

 - A background task on a housekeeping CPUs enters sys_futex syscall and
   locks a hb->lock (PI enabled mutex on RT)
 - That background task gets preempted by a higher priority task (e.g.
   NIC irq thread)
 - A low latency application task on an isolated CPU also enters
   sys_futex, hash collision towards the background task hb, tries to
   grab hb->lock and, even if it boosts the background task, it still
   needs to wait for the higher priority task (NIC irq) to finish
   executing on the housekeeping CPU and eventually misses its deadline

Now, of course by making the latency sensitive application tasks use a
higher priority than anything on housekeeping CPUs we could avoid the
issue, but the fact that an implicit in-kernel link between otherwise
unrelated tasks might cause priority inversion is probably not ideal?
Thus this email.

Does this report make any sense? If it does, has this issue ever been
reported and possibly discussed? I guess it’s kind of a corner case, but
I wonder if anybody has suggestions already on how to possibly try to
tackle it from a kernel perspective.

Thanks!
Juri


