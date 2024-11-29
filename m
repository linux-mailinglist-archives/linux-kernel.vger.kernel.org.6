Return-Path: <linux-kernel+bounces-425550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E0D9DE69B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BA8164C64
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC0F19D8BE;
	Fri, 29 Nov 2024 12:41:42 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97B19D8A3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732884102; cv=none; b=r1Ky/bGpqPmJht+4C2pa8SbuhroohKWpve0SOzdFlyBIuyiv2c1k8Kmm7a7eDVZ1jroFvzJC7Td619abkakX1uNRxPz8OrrAhWb5FIphTeMCT8Fsfo6/RfrWRqV3SYZy89o+83bDVh2MpwNiOJnjutrM/cVFBu0rrpkgCWDH/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732884102; c=relaxed/simple;
	bh=cZEl2K1sO7btdmVLvr1d1Uwxd9IjWi/NLouMbAXl31k=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=qvv3AxZx2GrkCc+xNey8xg3LUT0R1YX7QQHldaFNz5PrwtZ0UeQFEHPZ5w4KsEva6YUUfjZcxzU9/owQgYLp9MBeWIHfJE5tuAdwdDoYbjeFaGEcAVRNi/tqX9bECSMils8SuadETKMzA1RxYIu22RkLGQi6S8YIW7oBtt+pnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:40832)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tH0JR-008Opx-4l; Fri, 29 Nov 2024 05:41:33 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:53210 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tH0JQ-00A3eA-3Z; Fri, 29 Nov 2024 05:41:32 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,  Kees Cook <kees@kernel.org>,
  linux-kernel@vger.kernel.org,  Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>,  Nir Lichtman <nir@lichtman.org>,  Tycho
 Andersen <tandersen@netflix.com>,  Vegard Nossum
 <vegard.nossum@oracle.com>
References: <202411210651.CD8B5A3B98@keescook>
	<CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
	<05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org>
	<CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
	<202411271645.04C3508@keescook>
	<CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
	<20241128020558.GF3387508@ZenIV>
	<CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
	<13223528-74FF-4B68-B0CF-25DCC995D0A0@kernel.org>
	<CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com>
	<20241129033419.GI3387508@ZenIV>
	<CAHk-=whi+OgKMXoPQ+48i=_Cu_Yb5_QCv9U9+Wpg0-GumHZSXg@mail.gmail.com>
Date: Fri, 29 Nov 2024 06:41:11 -0600
In-Reply-To: <CAHk-=whi+OgKMXoPQ+48i=_Cu_Yb5_QCv9U9+Wpg0-GumHZSXg@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 28 Nov 2024 20:44:11 -0800")
Message-ID: <874j3qnrfc.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tH0JQ-00A3eA-3Z;;;mid=<874j3qnrfc.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18eHD2e3JtxI1P6MM2ZAXRzAeJsPZT8C/E=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4996]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
	*  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
	*  1.0 XMSubMetaSx_00 1+ Sexy Words
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 488 ms - load_scoreonly_sql: 0.08 (0.0%),
	signal_user_changed: 12 (2.4%), b_tie_ro: 10 (2.0%), parse: 1.29
	(0.3%), extract_message_metadata: 18 (3.7%), get_uri_detail_list: 2.5
	(0.5%), tests_pri_-2000: 15 (3.1%), tests_pri_-1000: 4.3 (0.9%),
	tests_pri_-950: 2.0 (0.4%), tests_pri_-900: 1.60 (0.3%),
	tests_pri_-90: 104 (21.2%), check_bayes: 87 (17.7%), b_tokenize: 10
	(2.1%), b_tok_get_all: 11 (2.3%), b_comp_prob: 2.7 (0.6%),
	b_tok_touch_all: 59 (12.0%), b_finish: 0.98 (0.2%), tests_pri_0: 312
	(63.9%), check_dkim_signature: 0.74 (0.2%), check_dkim_adsp: 3.3
	(0.7%), poll_dns_idle: 1.46 (0.3%), tests_pri_10: 2.2 (0.4%),
	tests_pri_500: 13 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: vegard.nossum@oracle.com, tandersen@netflix.com, nir@lichtman.org, christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org, kees@kernel.org, viro@zeniv.linux.org.uk, torvalds@linux-foundation.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 28 Nov 2024 at 19:34, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> Just one thing - IMO we want to use the relative pathname when it's
>> not empty.  Even in execveat()
>
> Oh, absolutely agreed.
>
> Good catch, because yes, I messed that part up in my suggested patch at
>
>    https://lore.kernel.org/all/CAHk-=wjF_09Z6vu7f8UAbQVDDoHnd-j391YpUxmBPLD=SKbKtQ@mail.gmail.com/
>
> which did this dentry name thing for anything that used a base fd, but
> yes, as you say, it should only do it when there is no name at all.
>
> So instead of basing it (incorrectly) on that existing
>
>         if (fd == AT_FDCWD || filename->name[0] == '/') {
>
> test, the logic should probably look something like
>
>         if (!filename->name[0]) {
>                 rcu_read_lock();
>                 strscpy(bprm->comm,
> smp_load_acquire(&file->f_path.dentry->d_name.name));
>                 rcu_read_unlock();
>         } else
>                 strscpy(bprm->comm, kbasename(filename->name));
>
> and it probably wouldn't be a bad idea to separate this out to be a
> helper function that just does this one thing.

Yes.

It probably makes sense to change __set_task_comm
to something simple like:

void __set_task_comm(struct task_struct *tsk, const char *buf[TASK_COMM_LEN], bool exec)
{
	trace_task_rename(tsk, buf);
        memcpy(tsk->comm, buf, TASK_COMM_LEN);
	perf_event_comm(tsk, exec);
}

There are only 6 callers of set_task_comm and __set_task_comm and they
are straight forward to verify that they pass in a TASK_COMM_LEN bytes
that are already initialized.  With the bytes already properly
initialized just copying them looks like it is as safe as anything else
when it comes to races.

The callers need to be tweaked a little to meet that condition
something like:

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index a38f36b68060..5d0928f37471 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -634,7 +634,7 @@ static int io_wq_worker(void *data)
	struct io_wq_acct *acct = io_wq_get_acct(worker);
	struct io_wq *wq = worker->wq;
	bool exit_mask = false, last_timeout = false;
-	char buf[TASK_COMM_LEN];
+	char buf[TASK_COMM_LEN] = {};
 
	set_mask_bits(&worker->flags, 0,
		      BIT(IO_WORKER_F_UP) | BIT(IO_WORKER_F_RUNNING));
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 6df5e649c413..701390bbb303 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -264,7 +264,7 @@ static int io_sq_thread(void *data)
	struct io_ring_ctx *ctx;
	struct rusage start;
	unsigned long timeout = 0;
-	char buf[TASK_COMM_LEN];
+	char buf[TASK_COMM_LEN] = {};
	DEFINE_WAIT(wait);
 
	/* offload context creation failed, just exit */
diff --git a/kernel/kthread.c b/kernel/kthread.c
index a5ac612b1609..2b126835d728 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -738,10 +738,11 @@ EXPORT_SYMBOL(kthread_stop_put);
 
 int kthreadd(void *unused)
 {
+	static const char comm[TASK_COMM_LEN] = "kthreadd";
	struct task_struct *tsk = current;
 
	/* Setup a clean context for our children to inherit. */
-	set_task_comm(tsk, "kthreadd");
+	set_task_comm(tsk, comm);
	ignore_signals(tsk);
	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_TYPE_KTHREAD));
	set_mems_allowed(node_states[N_MEMORY]);


Eric

