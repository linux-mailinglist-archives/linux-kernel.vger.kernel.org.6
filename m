Return-Path: <linux-kernel+bounces-294520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3F8958EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F49284554
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F11E1547F8;
	Tue, 20 Aug 2024 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWe8lE0Y"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213C18E344
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724182693; cv=none; b=PRp7ZM5rtDSaSk/zRNDCy4gRwpiZcQbWjWIxztTvqN3ltSiewru2wY4HpLT9yx+liqpZxEjFK8FSVMoTXXiI2xuBuX6zXNeSGqFT+eyBg5b7Mq+E8vWVHP09x3jw1RWX0Bb0jTQlMTSLgH4TEdFerpei5l208hvGjbC9ZiqdLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724182693; c=relaxed/simple;
	bh=3iA0roQxRN3QTEFh6FzoHTRmSDRYLVMI1esl+SRGMy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEySXSXcCsNwpsfgCHww30xt6/nbg1Y0eQQfEDOADe0UDtRyG+VAshQGfLUc7hhEmtIHxN+6ZfWFqB3oIqMireG8sKCFzcsHRhasqusBaF7jhs9csWe8age88cNN0/U3nJeh9Zh/nWm15RYCw90Swnt0V0j1pEJ7uuL0Zk9eao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWe8lE0Y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201ee6b084bso49692645ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724182692; x=1724787492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MAUdmohifVc8SxiXdj0pq1BBuKLEaHuMyxa7mgbBhg=;
        b=aWe8lE0Ymp6NAM7/M3cSCdMfov2VvzzI+2PflKKfKPBX9yFQqyMNMTuxD9ru0dB2l6
         BFwcoIsPaer4/jmWZlqqR7Js2MCkf+sQ9WiVlsqTWCRCozUfc47VAt44LJ+25UQSeR0o
         yRxoHKKFVE6VCz4CcTIKs/9cVOHxdA8UA4un7exkbjfUV3m7ih8o+X1Ms439PHfU9meL
         vqCQTLwiC9USiU+Ag/QKQxdLREswC9im9NedN644EheCTBUk0lLjdo2Le/9wvX9+uoVB
         2de57NM575l83p4DIoaduXCHt7G5MLIIfopZ2CrzwsOM2YA0lDyPYc+BDvHvb79agGmN
         eRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724182692; x=1724787492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MAUdmohifVc8SxiXdj0pq1BBuKLEaHuMyxa7mgbBhg=;
        b=f24meM+Wi/ovEtQFftspPy1ZNxqsAPVLrw6M7FjRlYYRz70h9hc+4ndmyJo5IQiS3u
         o8is5o0EYk/bAKi7HpLgslJQ2xmQOT67zamXQWvjzVoaOZKS9nXafpYB4M5p7v9XNvO6
         SdTXt1SzYmA/lx4LVHBTiinF91IfD+Qi37IGnper4TnjRKgeWg6gcCo2oPeW6aNbdHUV
         q98NtKvfTU1JHKNCfDNQcj+JqcJ7ogzsPLVy4asbk4hZKdHVZY6xta913tjSpe+JAPWM
         cT8SrqypuNzZ7h4Tx5DJ/nlz9qJ9Rvq06p1E62MTWDelREnoFNcIQrFk0pyJ3LzlRVmA
         vbFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMgd0jYs2we5XvoNsB7OC0PKhWk14GP1jcDqr836xzC/rsHu/OBycqdFuGfeR5aWJg+P920AOwdGJxx8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2HDQ8r0cZou2ZxFmcoE/0uV8bMJi+mTN1YBV6zPHAj+Qsgb+
	Wump1BIhzKAZqb43r+aIme8j89tPjkr8ZdScdTkaX6hgHer7/1t6
X-Google-Smtp-Source: AGHT+IEq3oVGOyKZvq35gQE5SGa8mDVokfjiFWEh0LyftSQ33AvlOyPidUmreaTS+DqizFS9paOKNQ==
X-Received: by 2002:a17:903:10c:b0:202:41e:dac3 with SMTP id d9443c01a7336-202041eed8bmr140711455ad.2.1724182691530;
        Tue, 20 Aug 2024 12:38:11 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03751e0sm81790015ad.177.2024.08.20.12.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 12:38:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Aug 2024 09:38:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU Hotplug
Message-ID: <ZsTwoWJQcnsJhYbe@slm.duckdns.org>
References: <8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com>
 <Zo3PgETt43iFersn@slm.duckdns.org>
 <dde4b09001da2641f9679b9409727e2147c5e9a6.camel@linux.ibm.com>
 <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>
 <Zq1NksrG9blyN-KR@slm.duckdns.org>
 <e3069da05fb1676f8faad88b9a4dfc4a6cef4175.camel@linux.ibm.com>
 <Zru5_UmEmWhNaPyo@slm.duckdns.org>
 <fa56b39990dd0b90f971018f5abb7352c60af3b1.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa56b39990dd0b90f971018f5abb7352c60af3b1.camel@linux.ibm.com>

On Tue, Aug 20, 2024 at 12:33:34PM +0530, Aboorva Devarajan wrote:
> On Tue, 2024-08-13 at 09:54 -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Sat, Aug 10, 2024 at 11:54:24PM +0530, Aboorva Devarajan wrote:
> > ...
> > ...
> 
> > Can you trigger sysrq-t when the system is stuck? Also, can you see whether
> > the problem is reproducible on x86 w/ the wq changes applied?
> 
> Hi Tejun,
> 
> I couldn't trigger sysrq-t so far as the system becomes unresponsive,
> will get back if I can successfully trigger this via console. 
> 
> And yes, this issue also occurs on x86 when applying the proposed workqueue
> patch on top of the recent sched-ext for-6.12 tree. However, it takes
> significantly longer to hit the issue, and the stack trace differs
> a bit.

I think this *should* fix the problem but it is rather ugly. The locking
order is such that there's no good way out. Maybe the solution is making
cpu_hotplug_disable() more useful. Anyways, can you test this one?

Thanks.

---
 kernel/sched/ext.c |   30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3990,6 +3990,24 @@ static const char *scx_exit_reason(enum
 	}
 }
 
+static void block_fork_hotplug(void)
+{
+	while (true) {
+		percpu_down_write(&scx_fork_rwsem);
+		if (cpus_read_trylock())
+			return;
+		percpu_up_write(&scx_fork_rwsem);
+		cpus_read_lock();
+		cpus_read_unlock();
+	}
+}
+
+static void unblock_fork_hotplug(void)
+{
+	cpus_read_unlock();
+	percpu_up_write(&scx_fork_rwsem);
+}
+
 static void scx_ops_disable_workfn(struct kthread_work *work)
 {
 	struct scx_exit_info *ei = scx_exit_info;
@@ -4045,8 +4063,7 @@ static void scx_ops_disable_workfn(struc
 	 * Avoid racing against fork. See scx_ops_enable() for explanation on
 	 * the locking order.
 	 */
-	percpu_down_write(&scx_fork_rwsem);
-	cpus_read_lock();
+	block_fork_hotplug();
 
 	spin_lock_irq(&scx_tasks_lock);
 	scx_task_iter_init(&sti);
@@ -4090,8 +4107,7 @@ static void scx_ops_disable_workfn(struc
 	static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
 	synchronize_rcu();
 
-	cpus_read_unlock();
-	percpu_up_write(&scx_fork_rwsem);
+	unblock_fork_hotplug();
 
 	if (ei->kind >= SCX_EXIT_ERROR) {
 		pr_err("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
@@ -4657,8 +4673,7 @@ static int scx_ops_enable(struct sched_e
 	 *
 	 *   scx_fork_rwsem --> pernet_ops_rwsem --> cpu_hotplug_lock
 	 */
-	percpu_down_write(&scx_fork_rwsem);
-	cpus_read_lock();
+	block_fork_hotplug();
 
 	check_hotplug_seq(ops);
 
@@ -4765,8 +4780,7 @@ static int scx_ops_enable(struct sched_e
 
 	spin_unlock_irq(&scx_tasks_lock);
 	preempt_enable();
-	cpus_read_unlock();
-	percpu_up_write(&scx_fork_rwsem);
+	unblock_fork_hotplug();
 
 	/* see above ENABLING transition for the explanation on exiting with 0 */
 	if (!scx_ops_tryset_enable_state(SCX_OPS_ENABLED, SCX_OPS_ENABLING)) {

