Return-Path: <linux-kernel+bounces-567510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FADA68736
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6233E19C4A10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2EC2517AD;
	Wed, 19 Mar 2025 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QU3eY6tF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB625178D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374159; cv=none; b=K0QYZfRsE1nS5WjvKaH/nFKXpsYQFbTWvkgh4FWJXTO5QeQSxMpUGwCxusOnUalRO1Cv4yrZdUyD8Nc+Uxoc6bPJJS548haMVdtSAFp3jCf/YZhZF0nKfqj8X4Xcg4WbMbGpJJH2/52bCm21JEnMMoqcPzLN4TbjH+eYIFZWWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374159; c=relaxed/simple;
	bh=Nx5SEeue62GWCtTNXfHreawLu9uE3MnHfLX6NV8KODg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=euO83P40fF+DioO4odicSqUCeyC1N5QR+URL+316/2tXDIHn1/e0ffMp+BUxRJFtJDQZnxYqc/n1UO+4jSwp25Vy3Kbvl2uw327+yjsemEYN2P7/dWm2c72H2ZGSbDo6BiKmVkmt1npQb9+uLcdcEiZRztWG0DeYXACl6Md8EZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QU3eY6tF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742374157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CIrUYz7y09WA8tfYaoR26MtOWKKb9sTXRyRz+5V2EmI=;
	b=QU3eY6tFtpAwbLGOoZfn7BMcjPJ0osokHlDELGfVxQEmwKJSCs1CO8CmKID0SaE3m4ZyQL
	h4ihmpgOYqSlvzcch36+UmOpqznGgbbjLEMne/mM3I1j015Fv/5FzfoMTT/6Pg7p5/PGEa
	djU58dL7Y5HwqMJkTP6W/HBhr0zy48s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Syd63CggPf-z_D3Ca0CvHQ-1; Wed, 19 Mar 2025 04:49:15 -0400
X-MC-Unique: Syd63CggPf-z_D3Ca0CvHQ-1
X-Mimecast-MFC-AGG-ID: Syd63CggPf-z_D3Ca0CvHQ_1742374154
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac1e442740cso602133766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742374153; x=1742978953;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIrUYz7y09WA8tfYaoR26MtOWKKb9sTXRyRz+5V2EmI=;
        b=m5WcZ01ag4xZzV1Ke9u2LirSNPu3NUGmxkXYc1/ZZDdcy9zQ7wlMJtNJXRnP1JOTK2
         1qID5vCtd/ew/lDNSWCIr7vXhAwjKSc7e1FXyQTEq/2zxJpUeq1ft/wKHNI2k58D6bw8
         rzwbg/AitAMBa9u+KOWkPmsRzMeQtomDpWX0ZA5UqiDQwJR+D1+5WQltvlkFBNu1C2GM
         EffzV9ck/62KQVYqqsmBL/Bmrvy9goHzH+38FIDzoLYcnRsRSEp29W9GClXp5iFr5jJf
         Z+y+piMpHGQzn13BsSfxJLjn+DMOPfCgbGm88SZtHCt7ilnWRH2EQnaXg9kvCxy4q5/x
         s7sw==
X-Forwarded-Encrypted: i=1; AJvYcCV4ZhcTJucv5Mn8FetOvgVa17FMj6TSSfBNnXuvYqEqiIYmx1fcu0Z/QunFMYqneuqf/flScfQmcxiv1ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1jt+5v0kBNM5UZlcjZhomzwbgXHqP4c0aPEYjHDbtf0yxkT0V
	HXaZaN3IGe5QnAVZF9Nem5lS1mugVCnOriaU6ROUb/W8RVWHMx7PvBfnxdnDZCaTOCigAXdIq+L
	nkza/f+Z3qtkQgClzgA/B1S6NexiMqapi+NIedEPY+34D43+QEDcC5waqB2N3GrzpuBokaZPL
X-Gm-Gg: ASbGncunjMt6E7PNF342RdCTWzSBSVlSpQw/J3KDzFrcmWdyfs9tOzaOLqCm60ne3Df
	v9YxiealUuZUftwhpJSSCMNBnvEVc7cWnmJelDYUAqhhUD1sFDQ8T8FI6F0wA1H5Kns4+wdq2nM
	zieYpj8fbGLmK1iC2BVKR60UYxUis/rh/zKZ5G7yqUlDooK8WGCk1cd37LCSuxTZvgX4Us04XbW
	NNHeKuddHPcgvM2BzSvL5pbfk/mbZGmPJ86cvYd+Y/JNpwsIIlVVvF/XYXpyQv2ZGvaJSTYdkw0
	aHKOIrTDihcSwzMJ4lnpKuXke0uA7CqrS/+xITe68NeqRQY=
X-Received: by 2002:a17:907:3e04:b0:abf:74d6:e2b0 with SMTP id a640c23a62f3a-ac3b7c39176mr174214066b.3.1742374153552;
        Wed, 19 Mar 2025 01:49:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpPH651CuhsTUlW/hY81e/he6vji52EgPu/RQ4JfREl/I+fAy3nCLvtFVM9/qOgHA2qpgURg==
X-Received: by 2002:a17:907:3e04:b0:abf:74d6:e2b0 with SMTP id a640c23a62f3a-ac3b7c39176mr174211066b.3.1742374153038;
        Wed, 19 Mar 2025 01:49:13 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([81.27.113.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0bfbsm998676566b.95.2025.03.19.01.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 01:49:12 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Thomas Gleixner
 <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Mel Gorman
 <mgorman@suse.de>, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/5] sched: Make CONFIG_SCHED_DEBUG features unconditional
In-Reply-To: <20250317104257.3496611-1-mingo@kernel.org>
References: <20250317104257.3496611-1-mingo@kernel.org>
Date: Wed, 19 Mar 2025 09:49:11 +0100
Message-ID: <xhsmh4izppfqw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 17/03/25 11:42, Ingo Molnar wrote:
> For more than a decade, CONFIG_SCHED_DEBUG=y has been enabled
> in all the major Linux distributions:
>
>    /boot/config-6.11.0-19-generic:CONFIG_SCHED_DEBUG=y
>
> The reason is that while originally CONFIG_SCHED_DEBUG started
> out as a debugging feature, over the years (decades ...) it has
> grown various bits of statistics, instrumentation and
> control knobs that are useful for sysadmin and general software
> development purposes as well.
>
> But within the kernel we still pretend that there's a choice,
> and sometimes code that is seemingly 'debug only' creates overhead
> that should be optimized in reality.
>
> So make it all official and make CONFIG_SCHED_DEBUG unconditional.
> This gets rid of a large amount of #ifdefs, so good riddance ...
>

Pretty much every distro I'm aware of has CONFIG_SCHED_DEBUG=y; a quick check
tells me it's been like so for RHEL since at least 2013, and that's from a
commit copying configs from RHEL-6 to RHEL-7.

Two things however come to mind:

1) What does this mean for the debug stuff we've repeatedly said wasn't ABI
   because it was under CONFIG_SCHED_DEBUG? I've been burned by making
   sched_domain.flags read-only, and there's still writable stuff:

   # ls -al /sys/kernel/debug/sched/domains/cpu0/domain0/
   total 0
   drwxr-xr-x. 2 root root 0 Mar 19 04:36 .
   drwxr-xr-x. 3 root root 0 Mar 19 04:36 ..
   -rw-r--r--. 1 root root 0 Mar 19 04:36 busy_factor
   -rw-r--r--. 1 root root 0 Mar 19 04:36 cache_nice_tries
   -r--r--r--. 1 root root 0 Mar 19 04:36 flags
   -r--r--r--. 1 root root 0 Mar 19 04:36 groups_flags
   -rw-r--r--. 1 root root 0 Mar 19 04:36 imbalance_pct
   -r--r--r--. 1 root root 0 Mar 19 04:36 level
   -rw-r--r--. 1 root root 0 Mar 19 04:36 max_interval
   -rw-r--r--. 1 root root 0 Mar 19 04:36 max_newidle_lb_cost
   -rw-r--r--. 1 root root 0 Mar 19 04:36 min_interval
   -r--r--r--. 1 root root 0 Mar 19 04:36 name

   + all the non topology related debug knobs.

2) Peter mentioned a few times that, last time it was benchmarked, there
   were noticeable perf differences between CONFIG_SCHED_DEBUG=n and
   CONFIG_SCHED_DEBUG=y. This would be an occasion to re-measure that and
   potentially move (some of) these checks to e.g. a sched_debug_verbose
   static key.


