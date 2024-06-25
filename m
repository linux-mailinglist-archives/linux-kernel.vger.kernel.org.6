Return-Path: <linux-kernel+bounces-228300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 619D0915DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158511F228C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B9913C9BD;
	Tue, 25 Jun 2024 04:54:10 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7613912E1D2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719291250; cv=none; b=MXPqTS9nw3xroiEXrfM7Cfjn2bJdM+oIie98wauHabtSTDFbBPcT9arLBSoalWXz8R9DcXg2Qy3TIAOz3vvzpf0YFjaqLDAI+A0rZfiHJc2CQuVi/dzCSfcwbf4bSc5jZsD3APdUmlwaAfbnChcoCy3F1WH4xUS5Z3riWBWo2fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719291250; c=relaxed/simple;
	bh=UAZafgTioIB4RZU9F8hI1c0llV96siVufhfJdveDgaQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=S1BaVlQk+U3ZquDzAbQIQkB8lbuVb8KUEOCViwBs64YRqd74dFQ+Ou3qxmNuKKLdkd7hmZS2rTBXgqBj5UScxklmdJ3i1VJc98HfTArAGdZF/+ZOMXjdszxxLQ/gVrb4/mqYoJ1IqyTcrlZNoM8RSbIhVeYTkryvi4IicgpzvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45P4s4Hi018260;
	Tue, 25 Jun 2024 13:54:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Tue, 25 Jun 2024 13:54:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45P4s4bV018257
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 25 Jun 2024 13:54:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <eb23b7f7-826d-408f-b2a4-7d3bd2ab4b22@I-love.SAKURA.ne.jp>
Date: Tue, 25 Jun 2024 13:54:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] profiling: initialize prof_cpu_mask from
 profile_online_cpu()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <a2775599-67a8-4b4e-a9df-c0da021fe59c@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <a2775599-67a8-4b4e-a9df-c0da021fe59c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot is reporting uninit-value at profile_hits(), for commit acd895795d35
("profiling: fix broken profiling regression") by error initialized
prof_cpu_mask too early.

do_profile_hits() is called from profile_tick() from timer interrupt
only if cpumask_test_cpu(smp_processor_id(), prof_cpu_mask) is true and
prof_buffer is not NULL. But the syzbot's report says that profile_hits()
was called while current thread is still doing vzalloc(buffer_bytes)
where prof_buffer is NULL at this moment. This indicates two things.

One is that cpumask_set_cpu(cpu, prof_cpu_mask) should have been called
 from profile_online_cpu() from cpuhp_setup_state() only after
profile_init() completed. Fix this by explicitly calling cpumask_copy()
 from create_proc_profile() on only UP kernels.

The other is that multiple threads concurrently tried to write to
/sys/kernel/profiling interface, which caused that somebody else tried
to re-initialize prof_buffer despite somebody has already initialized
prof_buffer. Fix this by using serialization.

Reported-by: syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b1a83ab2a9eb9321fbdd
Fixes: acd895795d35 ("profiling: fix broken profiling regression")
Tested-by: syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/ksysfs.c  | 27 ++++++++++++++++++++++-----
 kernel/profile.c |  6 +++---
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 07fb5987b42b..0be3dc86da54 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -91,10 +91,23 @@ static ssize_t profiling_store(struct kobject *kobj,
 				   struct kobj_attribute *attr,
 				   const char *buf, size_t count)
 {
+	static DEFINE_MUTEX(lock);
 	int ret;
 
-	if (prof_on)
-		return -EEXIST;
+	/*
+	 * We need serialization, for profile_setup() initializes prof_on
+	 * value. Also, use killable wait in case memory allocation from
+	 * profile_init() triggered the OOM killer and chose current thread
+	 * blocked here.
+	 */
+	if (mutex_lock_killable(&lock))
+		return -EINTR;
+
+	if (prof_on) {
+		count = -EEXIST;
+		goto out;
+	}
+
 	/*
 	 * This eventually calls into get_option() which
 	 * has a ton of callers and is not const.  It is
@@ -102,11 +115,15 @@ static ssize_t profiling_store(struct kobject *kobj,
 	 */
 	profile_setup((char *)buf);
 	ret = profile_init();
-	if (ret)
-		return ret;
+	if (ret) {
+		count = ret;
+		goto out;
+	}
 	ret = create_proc_profile();
 	if (ret)
-		return ret;
+		count = ret;
+out:
+	mutex_unlock(&lock);
 	return count;
 }
 KERNEL_ATTR_RW(profiling);
diff --git a/kernel/profile.c b/kernel/profile.c
index 2b775cc5c28f..1a6c1cf98485 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -114,11 +114,9 @@ int __ref profile_init(void)
 
 	buffer_bytes = prof_len*sizeof(atomic_t);
 
-	if (!alloc_cpumask_var(&prof_cpu_mask, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&prof_cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
-	cpumask_copy(prof_cpu_mask, cpu_possible_mask);
-
 	prof_buffer = kzalloc(buffer_bytes, GFP_KERNEL|__GFP_NOWARN);
 	if (prof_buffer)
 		return 0;
@@ -438,6 +436,8 @@ int __ref create_proc_profile(void)
 		goto err_state_prep;
 	online_state = err;
 	err = 0;
+#else
+	cpumask_copy(prof_cpu_mask, cpu_possible_mask);
 #endif
 	entry = proc_create("profile", S_IWUSR | S_IRUGO,
 			    NULL, &profile_proc_ops);
-- 
2.43.0


