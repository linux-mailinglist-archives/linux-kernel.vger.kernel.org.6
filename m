Return-Path: <linux-kernel+bounces-405785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8719C5914
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB7EB3C84F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F001BB6B5;
	Tue, 12 Nov 2024 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoHmyHJL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973C230989
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412133; cv=none; b=sJIIca9Gu6VoeLxuRR1aMXe04dVmyRqJCGkYnfM4UXt5GkmwO4fUcx01lgQ3lcQTevHyzk9TTVFpomxunVNBjEJrIlO8aEroylh0ouGmUvjt9kOw8Mr0rgYI5H7HW/14Oztd662QyND+8W3cUkg4Eb1YGSXYG4BdihSvNEJEOJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412133; c=relaxed/simple;
	bh=sexKNXD7XnpRvBHnDNQiw6uZrGJfJ24MEeItqx5xgu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JqRQC1gFJiGqV3Fb3eWOtuVZGBow83KnHr6oeuKfxp8UTG+CB0GVovMeKf4SPEObAwsfEClOvZBuZBG8xV3t/VPbw0pM9Fhpul2Fy6Gujiku3kuGPRoqXVvEavQMlNj0L9tgYw6jJGPeJ0UnIzTF63F5tQbW9w8yAUNOFa1HKW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoHmyHJL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731412130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FPaew/J2nFAbKvuzEnykWeNVwVW0+Al07LcXLfJeJc=;
	b=KoHmyHJL0ghVs6wXUsK86gANffDyPwUbmZqczRVWRmkyMtAHIvdlCsTTnP0cCthj5/GUf+
	mfHiOsZpV8ghn8E74hKwEdLm3zxKME6eeEld8jBr+DifNQKU2dkI8/YfIlMRDLrewbMp91
	PEdo99HdgoexWQpgVVGBepmahGpE64w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-vlWNuBxDPYC_6QIZU25JhQ-1; Tue, 12 Nov 2024 06:48:49 -0500
X-MC-Unique: vlWNuBxDPYC_6QIZU25JhQ-1
X-Mimecast-MFC-AGG-ID: vlWNuBxDPYC_6QIZU25JhQ
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b14634dba8so717680085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731412129; x=1732016929;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FPaew/J2nFAbKvuzEnykWeNVwVW0+Al07LcXLfJeJc=;
        b=sF7jBag/zfIsMeXbHwaDxwcT2HrWdAFgLrxqTVBFeF3LYtUYuIZxWK/8oj/Wa9Fr1I
         2WrzGO6BMJ5VllZrQbwjKGZ9UHw/IqWXFTGf59KEVDIthOzVJkT55TyUpoghPD2RmSXJ
         KhKmtMGkQOEWl5NV1ZrcWuRo2ZDYHFruhDU83RcPJx+M2S3iEO4PP+jOnemYL5ojDxww
         C2tGF93og/dTNrKI8cgMiA0GvQlRsDtEJtjeye2gN20z9nnCoHMGLC7iLkyf5jRRaoDl
         8tg3azmBFQ4On6jHERpyIIReLtbky1od+ZbyXvFEP9eqXlHdDImEoDsXgPZZch+nyjYC
         LyKw==
X-Forwarded-Encrypted: i=1; AJvYcCWysiZH466K7XvwEo1eJ8KzjRFH4vqDyZvQS1QdFvwegY3hRU2mobU+nTxxXPpg8lHTCAXhHRac4Q9bJ4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOo+YLzia00Zh0aSPlpRq0feV/bxhBKXjoprfp8ABZ46p2SOIz
	D7LqoYja3onjYaT/PiS/Zwhqvt8+lZ30w/TnV7DJMCAgUHPJf8keshcPCus/HrkWjXymyLjsLEd
	kd2VU3/k5T8deyuDr2uBfmZM5Jjty15H7MiUYeRBgU/uGgXSNsKrcu5gwh9RdlQ==
X-Received: by 2002:a05:620a:2943:b0:7b1:4579:61fa with SMTP id af79cd13be357-7b331f30f83mr2118315585a.55.1731412128852;
        Tue, 12 Nov 2024 03:48:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn8DsE5PCyIYersXMpgZHU5Oevhjar6lRDGEWUDoYfsGQSD6wAakm5smKreq1Jiix5BtG4WQ==
X-Received: by 2002:a05:620a:2943:b0:7b1:4579:61fa with SMTP id af79cd13be357-7b331f30f83mr2118312985a.55.1731412128516;
        Tue, 12 Nov 2024 03:48:48 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ace4fd7sm581186985a.108.2024.11.12.03.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:48:46 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar
 <mingo@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] sched/fair: Mark cfs_bandwidth_used() and
 m*_vruntime() with __maybe_unused
In-Reply-To: <20240905171210.267626-1-andriy.shevchenko@linux.intel.com>
References: <20240905171210.267626-1-andriy.shevchenko@linux.intel.com>
Date: Tue, 12 Nov 2024 12:48:42 +0100
Message-ID: <xhsmh7c98d65h.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 05/09/24 20:12, Andy Shevchenko wrote:
> When cfs_bandwidth_used() is unused, it prevents kernel builds
> with clang, `make W=1` and CONFIG_WERROR=y:
>
> kernel/sched/fair.c:526:19: error: unused function 'max_vruntime' [-Werror,-Wunused-function]
>   526 | static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
>       |                   ^~~~~~~~~~~~
> kernel/sched/fair.c:6580:20: error: unused function 'cfs_bandwidth_used' [-Werror,-Wunused-function]
>  6580 | static inline bool cfs_bandwidth_used(void)
>       |                    ^~~~~~~~~~~~~~~~~~
>
> Fix this by marking them with __maybe_unused (all cases for the sake of
> symmetry).
>

I assume that's with CONFIG_CFS_BANDWIDTH=n? Looks like
cfs_bandwidth_used() uses are tucked away under helpers that themselves
only really do something for CONFIG_CFS_BANDWIDTH=y, so you could remove
the CONFIG_CFS_BANDWIDTH=n definition of cfs_bandwidth_used() directly.

This compiles:
---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d16c8545c71e..57abb4ae8af39 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5373,8 +5373,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 
-static inline bool cfs_bandwidth_used(void);
-
 static void
 requeue_delayed_entity(struct sched_entity *se);
 
@@ -6754,11 +6752,6 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 
 #else /* CONFIG_CFS_BANDWIDTH */
 
-static inline bool cfs_bandwidth_used(void)
-{
-	return false;
-}
-
 static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}


