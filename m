Return-Path: <linux-kernel+bounces-408139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE1F9C7AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F0A1F2291F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E165D20125C;
	Wed, 13 Nov 2024 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YP1/DgKY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XBoxo/Ng"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AAC33997
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521901; cv=none; b=Fc7qYqMPioSDzNW1vhzn7oATMmCEb3UoShBpa+aMrGiZZRZ+hA1hKIvOvwPUZvyKtYIXR2WXFOZ7tOIbtVy6e80oShMAXpnaNTW4Mfz/2YI3PqdgA0RDdX4PYFtTdJrNbE8jEAT5mjxtLTznSEziQhs4sKhryP4Kjh/CT2vGap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521901; c=relaxed/simple;
	bh=nNcKaTMRS0dLG4RBUK/layKHxW+Imdsje0yyzrv46RU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lyBEpogyHpP1MIH3OSwLLj3LiqafXgIh/X8OzGEDR93ZCnIPnjKTw15NUsLvZVm4iF6u3AXz5/wbwXZwU5AWvxNes30QxDNNKnfMSbkv45dbO/fcI8p8vjU185pqVbIzEPSp8LdVz5ItHmhR4pzet7clbvxBepvW828S+w+oxgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YP1/DgKY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XBoxo/Ng; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 214081140126;
	Wed, 13 Nov 2024 13:18:17 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 13 Nov 2024 13:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731521896;
	 x=1731608296; bh=4woTuZ2aZBNRPk91FjfQYtN2vLwn38+0sqlvsUDtbQc=; b=
	YP1/DgKYUcIud7Mf/4Rz8dY+i5TxMSMK/6pyZqXU82PfSuW9thQXoPo9ScFPm5Bk
	Gi4mGr5sRdJEcMN2lkxJayQwsNdZfRdzjg5Lawl9NMFahc903ag5gEVD5bzcwfph
	6ZrJyXcQ05tPI/ike7ZW7ZatpOfZTmtYFIAEF7R/W36G2mOa9dkxivsqvnyaaE3x
	jJ+ow8HpUmgTbnhmzIzqxDQCl+ctyCIKXSK02bqnE8g7zUgvaixjrwVgb+n6V5Th
	wgUwegWcxyV0HYwFnINIGS7vJNEaOHipSkAVfUo4IfQybljCYFr0BX+LTkpykIlq
	hvDvGxG7aT4SjW9iuIjmfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731521896; x=
	1731608296; bh=4woTuZ2aZBNRPk91FjfQYtN2vLwn38+0sqlvsUDtbQc=; b=X
	Boxo/NgYe66HjG7NMKMFMgLA+5id4g/rHWneYsSjMYx+OhOobkrI0zmBY87A2H4u
	FWRrx7xI26WE9QsW/rTF5SxVxXId+BNKB2G7+ctoVmyjImV+5E8j4eNrsOGaxjkP
	1wpKcPjS/7CVCiAvasL/BnfeRmqQO2wQviKnf6N1vlTOXC3IYIMnSy+V/oPjobJJ
	hFzyGJ/gf0Nr/TZSNOytSb1sVt2cIvcnONhJNcrriOgNu9hgtCc6KUYb7FU9Z9z4
	DEhBxn2ytYQheMu43i3d8XXXVQlV1jnjTwlgVRQ/rO2YnotWQq/Mlx817DrHg1C3
	Zh0/bXmlMPtBeMnN6anEA==
X-ME-Sender: <xms:aO00Z8nK9tuY0JDAx-0xCcniACEjkts4OG31YusJfUovpK15iza_qg>
    <xme:aO00Z70Jh-krLN85Iow0UPblHflAdsxpHZW0V2ChwiVxQSpd8yk16qoiqvBFaTC5l
    K1vvG8AunOZpFhieSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephefhjeehueefvdeufeejjeejueetffegveekgffh
    fedtvdefheejuefhfeetuedunecuffhomhgrihhnpehlihhnrghrohdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopedvkedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepkhhprhgrthgvvghkrdhnrgihrghksegrmhgurdgtohhmpdhrtghpthhtohep
    khgvrhhnvghlqdhtvggrmhesrghnughrohhiugdrtghomhdprhgtphhtthhopehmvghtih
    hnrdhkrgihrgesrghrmhdrtghomhdprhgtphhtthhopeguihgvthhmrghrrdgvghhgvghm
    rghnnhesrghrmhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomhdprhgtphhtthhopeiguhgvfigvnhdrhigrnhelgeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepsg
    hsvghgrghllhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhovghlrghfsehgohho
    ghhlvgdrtghomh
X-ME-Proxy: <xmx:aO00Z6pL25gSE8rI_NmpbpxQjXxFwXuuiP1qhO6n4BHjxt9Uyd64iw>
    <xmx:aO00Z4lf9YxL3BEr55OyfNtW0zcVaXA6lusFec_ihuPqixJV3cMjCw>
    <xmx:aO00Z62H3pTukY7y8oAeQeediYymOYo1bDEV311aZ8Bpb8TvVXG11g>
    <xmx:aO00Z_vOB-sSkSGvIVFDTXzjRZKX8hAasBd7FN7R60RmxZj3DqlqDg>
    <xmx:aO00Z0EVPIp-rMWpg-22d9jorcxZGzY2KN7I3x49ULjCQ4l7WEp7hq7Y>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F19E72220071; Wed, 13 Nov 2024 13:18:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 Nov 2024 19:17:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Stultz" <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>,
 "Joel Fernandes" <joelaf@google.com>,
 "Qais Yousef" <qyousef@layalina.io>, "Ingo Molnar" <mingo@redhat.com>,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
 "Valentin Schneider" <vschneid@redhat.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Benjamin Segall" <bsegall@google.com>,
 "Zimuzo Ezeozue" <zezeozue@google.com>, "Mel Gorman" <mgorman@suse.de>,
 "Will Deacon" <will@kernel.org>, "Waiman Long" <longman@redhat.com>,
 "Boqun Feng" <boqun.feng@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Metin Kaya" <Metin.Kaya@arm.com>, "Xuewen Yan" <xuewen.yan94@gmail.com>,
 "K Prateek Nayak" <kprateek.nayak@amd.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Daniel Lezcano" <daniel.lezcano@linaro.org>, kernel-team@android.com,
 "Davidlohr Bueso" <dave@stgolabs.net>, regressions@lists.linux.dev,
 "Thorsten Leemhuis" <linux@leemhuis.info>,
 "Anders Roxell" <anders.roxell@linaro.org>
Message-Id: <6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com>
In-Reply-To: <20241011232525.2513424-2-jstultz@google.com>
References: <20241011232525.2513424-1-jstultz@google.com>
 <20241011232525.2513424-2-jstultz@google.com>
Subject: Re: [PATCH v13 1/7] locking/mutex: Remove wakeups from under mutex::wait_lock
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Oct 12, 2024, at 01:25, John Stultz wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> In preparation to nest mutex::wait_lock under rq::lock we need
> to remove wakeups from under it.
>
> Do this by utilizing wake_qs to defer the wakeup until after the
> lock is dropped.

To follow up from IRC, this patch is the one that caused a
boot time regression in linux-next in the regulator framework.

Anders Roxell found this during testing on the Rock Pi 4 board
(rockchips rk3399 based).

The book load with the NULL pointer dereference is at
https://lkft.validation.linaro.org/scheduler/job/7979980#L741

The interesting bit is this:

[ 0.957586] rk_gmac-dwmac fe300000.ethernet: Enable RX Mitigation via HW Watchdog Timer"}
[ 0.969402] hub 6-0:1.0: USB hub found"}
[ 0.969450] hub 6-0:1.0: 1 port detected"}
[ 0.988163] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000"}
[ 0.988172] Mem abort info:"}
[ 0.988174]   ESR = 0x0000000096000004"}
[ 0.988176]   EC = 0x25: DABT (current EL), IL = 32 bits"}
[ 0.988180]   SET = 0, FnV = 0"}
[ 0.988183]   EA = 0, S1PTW = 0"}
[ 0.988185]   FSC = 0x04: level 0 translation fault"}
[ 0.988187] Data abort info:"}
[ 0.988189]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000"}
[ 0.988191]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0"}
[ 0.988194]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0"}
[ 0.988197] [0000000000000000] user address but active_mm is swapper"}
[ 0.988201] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP"}
[ 0.988205] Modules linked in:"}
[ 0.988217] Hardware name: Radxa ROCK Pi 4B (DT)"}
[ 0.988225] pc : wake_up_q (kernel/sched/core.c:1059)
[ 0.988238] lr : wake_up_q (kernel/sched/core.c:1054)
[ 0.988243] sp : ffff800083433a00"}
[ 0.988245] x29: ffff800083433a00 x28: 0000000000000000 x27: ffff0000053b6080"}
[ 0.988253] x26: ffff800083433b90 x25: ffff0000053b6000 x24: ffff800080098000"}
[ 0.988259] x23: 00000000ffffffff x22: 0000000000000001 x21: 0000000000000000"}
[ 0.988265] x20: fffffffffffff850 x19: 0000000000000000 x18: 0000000000000001"}
[ 0.988272] x17: ffff800075678000 x16: ffff800082728000 x15: 019ee6ab98006e30"}
[ 0.988278] x14: 000002ce459acd0c x13: 000b52b4cf08772c x12: 000000000000000f"}
[ 0.988284] x11: 0000000000000000 x10: 0000000000000a50 x9 : ffff800083433870"}
[ 0.988291] x8 : ffff0000050fceb0 x7 : ffff0000f76ab9c0 x6 : 00000000000b52b4"}
[ 0.988297] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000"}
[ 0.988303] x2 : 0000000000002710 x1 : 0000000000000001 x0 : 0000000000002710"}
[ 0.988310] Call trace:"}
[ 0.988313] wake_up_q+0x50/0xf0 P)"}
[ 0.988319] wake_up_q+0xa0/0xf0 L)"}
[ 0.988325] __ww_rt_mutex_lock.isra.0 (arch/arm64/include/asm/preempt.h:62 (discriminator 2) kernel/locking/rtmutex.c:1794 kernel/locking/ww_rt_mutex.c:71)
[ 0.988333] ww_mutex_lock (kernel/locking/ww_rt_mutex.c:82)
[ 0.988338] regulator_lock_recursive (drivers/regulator/core.c:161 drivers/regulator/core.c:333)
[ 0.988347] regulator_lock_recursive (drivers/regulator/core.c:348)
[ 0.988354] regulator_lock_dependent (drivers/regulator/core.c:409)
[ 0.988360] regulator_set_voltage (drivers/regulator/core.c:4173)
[ 0.988366] _opp_config_regulator_single (include/linux/regulator/consumer.h:707 (discriminator 1) drivers/opp/core.c:933 drivers/opp/core.c:1019)
[ 0.988375] _set_opp (drivers/opp/core.c:1253)
[ 0.988379] dev_pm_opp_set_rate (drivers/opp/core.c:1357)
[ 0.988384] set_target (drivers/cpufreq/cpufreq-dt.c:63)
[ 0.988392] __cpufreq_driver_target (drivers/cpufreq/cpufreq.c:2292 drivers/cpufreq/cpufreq.c:2355)
[ 0.988398] sugov_work (kernel/sched/cpufreq_schedutil.c:537)
[ 0.988406] kthread_worker_fn (arch/arm64/include/asm/jump_label.h:32 include/linux/freezer.h:36 include/linux/freezer.h:54 kernel/kthread.c:861)
[ 0.988414] kthread (kernel/kthread.c:389)
[ 0.988420] ret_from_fork (arch/arm64/kernel/entry.S:863)
[ 0.988430] Code: f100067f 54000320 d11ec274 aa1303f5 (f9400273) "}


> @@ -1776,8 +1785,11 @@ static int __sched rt_mutex_slowlock(struct 
> rt_mutex_base *lock,
>  	 * irqsave/restore variants.
>  	 */
>  	raw_spin_lock_irqsave(&lock->wait_lock, flags);
> -	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state);
> +	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state, &wake_q);
> +	preempt_disable();
>  	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
> +	wake_up_q(&wake_q);
> +	preempt_enable();
>  	rt_mutex_post_schedule();
> 
>  	return ret;

This is apparently where things went wrong, but it's possible that
the actual root cause is in the regulator framework instead.

The NULL pointer itself happens when chasing wake_q->first->next,
so it would seem that one of these got reinitialized at
the wrong time, perhaps with a task_struct getting freed
or getting put on more than one wake_q_head lists at the
same time.

       Arnd

