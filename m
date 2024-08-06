Return-Path: <linux-kernel+bounces-275733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E9F94892B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800C31C22712
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A1173355;
	Tue,  6 Aug 2024 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggqlBV8j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F52CA5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924570; cv=none; b=WJe5ACBdOLCeShkGxqyXjpR/9JPYHaW0Gmwb/75jfICIN4wc7Q6VHCYxjlQMEPfuAvJ45a703MmsbryCuRMYnWgvddfIfAFm+Uul/vxRq2nRiSmHbpxqHuO1mWJCzMSuaLMpUk+AZFZHHdgCJ/c0jcRu32nayq+WodCrMZk3g2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924570; c=relaxed/simple;
	bh=ZsefIYStrGDb9k8xax2Vyy8z1RQ3FSStZHl5YNa9OPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=TLav8H2nzB8VywGUqO503onu9Rxtxs9WUtNSsgTJe4aCLnsZA+i/Jl/qtMHet4U3BN7Fxflw1bijF8xq2HwXaJ39BiKImggOqJIaGPcf+2wN+Dk9YFEvFcpPN4tay3MP+ui3YbmBEkCQJDGCguXXRyJWAYmhkI1ag1dUoHIp5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggqlBV8j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722924565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4SFTgS3RSxMXnR79gxMgVDPeEdFnu+n/zpjK6NCgI6U=;
	b=ggqlBV8jLnQRy3n0eQ/kiTQzWXTpnft6U8K87cklJA0KsliLuMUHyoSzazUIpAwwY5d45V
	STPtQSClT8eJtni59kPWh2PUJjyQV4bLqY/L97+FqWQ9LxSBA+Q9xafa49pS33noFIROiB
	+VBiC4njxzqSkeV3ywm1itMhgTatGr8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-626lUAqqMPmSf1YcJMvXdQ-1; Tue, 06 Aug 2024 02:09:24 -0400
X-MC-Unique: 626lUAqqMPmSf1YcJMvXdQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7a242496838so516675a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 23:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722924563; x=1723529363;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SFTgS3RSxMXnR79gxMgVDPeEdFnu+n/zpjK6NCgI6U=;
        b=tPX88pCNK/s5q0GWZQtphIhgdO4xV/TahbKh9B30gz9wsxfjQ9h69cUrRjfXe8QDUe
         hkdNVyc/PQvvqfJdf7egZSF88BujuKr95CO+/NZTJ5UlOc4FTVm4LPSspTu0T3HM0bb2
         8pokj0IcVOdZ4bY0hjBRe878QNa3vEpoKyhmeV8M+V38OlSV9BvD+fWQkXmkcD6aOqej
         ruudghA1G3wM/EXqmqTDYV4F0c64F+4sAKkEKsc4JtHbsS3kCxzC1mboxfUDSSYscFFD
         YXDWDI6o59NzBkhxDnb5/fU63BnQOwu47Bf0dOeyXIRgkfuqB0TsCa/RpWOZw/J+nOaV
         EIAg==
X-Forwarded-Encrypted: i=1; AJvYcCV6eV4VMsSfrjyWdfGMZ/8q8o8hkDkwY7PKGKRc5RmHRnUzztPdc93JK1K7izxlbRDTP9gRjSqlCZLaZD6mznDrL0WfW2f3Ma/2N931
X-Gm-Message-State: AOJu0YwWKjwrkCjbL13O2Oi0pqPdjBZN6cHvtUzrYu/3Kt0qWLH1lp+i
	J9tiY3I/F3lGH27izu/3zhEcW0kRSnPQPOXBKBRLAfPchOQ7glQcp4agWE4UaRXgkNAWWmfLp1b
	6WXMXEhHxQd69KLU51us0nkldYHs9j0SwFLNVZjwhJSHQqNR6REFiCHZfP34wWg==
X-Received: by 2002:a05:6a21:a4c1:b0:1c4:dae8:c72f with SMTP id adf61e73a8af0-1c699559d86mr13937336637.19.1722924563213;
        Mon, 05 Aug 2024 23:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFAB4iDFaLVVFzQSknryXyAqbAibTwTchg6n6ZX0voJ3rtXiQO8ekPM1EV6qpN/RcplUFTmQ==
X-Received: by 2002:a05:6a21:a4c1:b0:1c4:dae8:c72f with SMTP id adf61e73a8af0-1c699559d86mr13937320637.19.1722924562815;
        Mon, 05 Aug 2024 23:09:22 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:431:c7ed:e5a3:54cb:9e69:eacc:b949])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec3eb7bsm6387179b3a.48.2024.08.05.23.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 23:09:22 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: neeraj.upadhyay@kernel.org
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	mingo@kernel.org,
	peterz@infradead.org,
	paulmck@kernel.org,
	imran.f.khan@oracle.com,
	riel@surriel.com,
	tglx@linutronix.de
Subject: Re: [PATCH v2 4/3] smp: print only local CPU info when sched_clock goes backward
Date: Tue,  6 Aug 2024 03:09:11 -0300
Message-ID: <ZrG-B5JKw5rboCHX@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240724170652.809939-1-neeraj.upadhyay@kernel.org>
References: <20240722133559.GA667117@neeraj.linux> <20240724170652.809939-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 24, 2024 at 10:36:52PM +0530, neeraj.upadhyay@kernel.org wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> About 40% of all csd_lock warnings observed in our fleet appear to
> be due to sched_clock() going backward in time (usually only a little
> bit), resulting in ts0 being larger than ts2.
> 
> When the local CPU is at fault, we should print out a message reflecting
> that, rather than trying to get the remote CPU's stack trace.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> ---
>  kernel/smp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index dfcde438ef63..143ae26f96a2 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -253,6 +253,14 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>  		   csd_lock_timeout_ns == 0))
>  		return false;
>

Hello Rik,
Thanks for this contribution!
Seems a really nice bug you found here :)

Your solution seems very efficient, but I noticed a few (possible) issues here:
  
> +	if (ts0 > ts2) {
> +		/* Our own sched_clock went backward; don't blame another CPU. */
> +		ts_delta = ts0 - ts2;
> +		pr_alert("sched_clock on CPU %d went backward by %llu ns\n", raw_smp_processor_id(), ts_delta);

This ns number is not necessarely correct, since a few calls to 
csd_lock_wait_toolong() may have happened before the clock going backwards.

As an example we could have, for a 15ms backwards movement
05ms: csd: [...] waiting 5000 ns for CPU#X
10ms: csd: [...] waiting 10000 ns for CPU#X
12ms: sched_clock on CPU X went backward by 3000 ns
						^ wrong
17ms: csd: [...] waiting 5000 ns for CPU#X
			  ^reset waiting.

> +		*ts1 = ts2;

Second point here, above line just resets the counter, so we start printing 
messages again, with the wrong waiting time. (see 17ms above)

> +		return false;
> +	}
> +


Suggestion A: Save the last ts2 it succeeds, and in case of 
the clock going backwards, adjust ts0 and ts1 to the new clock.
This way the waiting time does not reset, and the backwards amount is 
correct:

########
diff --git a/kernel/smp.c b/kernel/smp.c
index aaffecdad319..e8788f7e1a78 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -213,7 +213,8 @@ static int csd_lock_wait_getcpu(call_single_data_t *csd)
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
  * so waiting on other types gets much less information.
  */
-static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
+static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 *ts0, u64 *ts1, u64 *ts_save,
+                                 int *bug_id)
 {
        int cpu = -1;
        int cpux;
@@ -233,10 +234,21 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
        }
 
        ts2 = sched_clock();
+
        /* How long since we last checked for a stuck CSD lock.*/
        ts_delta = ts2 - *ts1;
-       if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
+       if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0)) {
+               *ts_save = ts2;
                return false;
+       }
+
+       if (unlikely((s64)ts_delta < 0)) {
+		/* How much clock went backwards */
+               ts_delta = *ts_save - ts2;
+               pr_alert("sched_clock on CPU %d went backward by %llu ns\n",
+                        raw_smp_processor_id(), ts_delta);
+               *ts0 -= ts_delta;
+               *ts1 -= ts_delta;
+       }
+	*ts_save = ts2;
 
        firsttime = !*bug_id;
        if (firsttime)
@@ -248,7 +260,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
                cpux = cpu;
        cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
        /* How long since this CSD lock was stuck. */
-       ts_delta = ts2 - ts0;
+       ts_delta = ts2 - *ts0;
        pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
                 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts_delta,
                 cpu, csd->func, csd->info);
@@ -291,11 +303,11 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 static void __csd_lock_wait(call_single_data_t *csd)
 {
        int bug_id = 0;
-       u64 ts0, ts1;
+       u64 ts0, ts1, ts_s = 0;
 
        ts1 = ts0 = sched_clock();
        for (;;) {
-               if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
+               if (csd_lock_wait_toolong(csd, &ts0, &ts1, &ts_s, &bug_id))
                        break;
                cpu_relax();
        }
##########

Suggestion B: Compare to ts_save to ts2 before calculating ts_delta.
Pros: 	Much better detection of clock goin backwards
Cons: 	Overhead for the fastpath
	More detections -> more messages, which is not necessarily good.

##########
+++ b/kernel/smp.c
@@ -234,6 +234,15 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 *ts0, u64 *ts1, u
        }
 
        ts2 = sched_clock();
+       if (unlikely(*ts_save > ts2)){
+               /* How much clock went backwards */
+               ts_delta = *ts_save - ts2;
+               pr_alert("sched_clock on CPU %d went backward by %llu ns\n",
+                       raw_smp_processor_id(), ts_delta);
+               *ts0 -= ts_delta;
+               *ts1 -= ts_delta;
+       }
+       *ts_save = ts2;
 
        /* How long since we last checked for a stuck CSD lock.*/
        ts_delta = ts2 - *ts1;
##########


What do you think?

Thanks!
Leo


