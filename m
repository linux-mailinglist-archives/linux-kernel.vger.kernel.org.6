Return-Path: <linux-kernel+bounces-428881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01AA9E1498
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C585282E66
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1490719259E;
	Tue,  3 Dec 2024 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIDeAoIi"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68951BF37
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212199; cv=none; b=EY3r5VEqxZlPRyWISxFt7h+rjgWDuR6zhWqGpK7L8E16WG8NHaPJK2drLAVuyZ2AHXFxNOqK/Qpv+AxnVq43anpHTCzIe79orx97sAAPnw8hqDAvEcIFqPEv3btaQXDp5taUf9Tw2QS3oDEE0cDRDne6FoHcSxE9iNtnKWBLkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212199; c=relaxed/simple;
	bh=b2H0Pm0gr7IK2UiEdH+sjkkYnH/65HprZWAUoEiGIC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb1rkitFofX5lAS8NYeO0952fSFr5Pqud00P2HuHZvZIS0T6DibMOSk/29KDG7qpX35Pg+c7oM+pQZcMicQ3yvrNJtE553JOaHzkvLIfrQadYcklS3a5BR8Wcl+WMk6vfg7wVv1gyXpCFFLtUHReBJrFUcHgJUwwfl8iZOXfldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIDeAoIi; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d882619044so32712776d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 23:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733212196; x=1733816996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAc4beHo344rQfywcgFtNMl7CBXH2zQYh6U+MPBRhYI=;
        b=WIDeAoIi1fPRYCBUL9SHBU5br71nBfzHn0mgM0ocT2mKJ0gReaBO8wwElKfeFOuMNn
         fNoTKxaA/CqsNfWZzyi9S64SUbr6aYs1rm6l4s9+7XADT1aP8tX01dEBE7WmO4JhjaYS
         Hkp8WO/kUNP+LSuAqZi5S6nXojZySkJ6UcccIyM5GTDnNTiUI4veoc9ShLrMkX2v7HPo
         6BuPgRlfGttThVwxG2c219Xd5JX70b61nSmPIwW9lmCz+VUplEJNTcuw/gtjqW+VVWpK
         fx7JD2HNhSvMuKytzflv4q1IVDZ84/oQGFgZ2uGM9K090gpmWtQ04YIZkxo/D/7QQHFF
         k8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733212196; x=1733816996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAc4beHo344rQfywcgFtNMl7CBXH2zQYh6U+MPBRhYI=;
        b=ZEUZChiyEPvA7Vi6v+7T+nupC0+2JI2nRLxfOYGZE3Bj/fioBnTohdjoH0bBLerOaY
         qukisd/Desgx6luTZj5LLdt/Roa4+CzAVr/JXb2oVVE4NlpLVSFlyx9tkg+O+YqBGnGo
         6XfvuilAtwd0stUv0TOy2qqlIgwioxEHcFJWQCxfYV8iSpB6cyFx5S8aj4ZWWDVNabfZ
         fOC/lZ5yhI3p7mN7HUVx4T8coUOkNpCxIozkLfjH34wx1TCDJsG/vp/coEKwiAqUxLWK
         a79/y2cIFySE9ml1HLXb/4jykglsrgk2bA6eehGxjAZSyKCSVQaQr4kX6sPK6Qbo8fmK
         sxPA==
X-Forwarded-Encrypted: i=1; AJvYcCXSD9YPvPciZacAVqkJaKeVPVx6u0LVcU8UhqS4C20wESuGnxQOl4ytqQpoYrPuxgz6fpp9O5u5tK2Ppa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGuov7/2MAP2xy6edc4Nb4HjLv9nV8vXHJNeAFvnP0AXiDxhzK
	6hrMygETc5CFMguKksh8i7Q3WTiiQvw/3+YGKwYW5Q9v0BxXZgME
X-Gm-Gg: ASbGncspENHIjmvUWIuFMJvyllnUBwFdFQgajl5bwpeLkMImyg0iFA1y0YsDVDIMotM
	IYSKrx48RcjEBiHZbt3esA96lBsM/mkabbqriOptFPkEXvOvDVobk1qnwCLoTuWcsvtUvneyFwO
	CnO8jXgUuINetG9T4Sx9s8v4gxOm4g1AEmMjenzMbYj2P3PwMrZunerRdW3tN36c1wlgWa4j//E
	S/TLPTYQRSO17N13kJa/3i4QkAwj+obPD2r6CMMhI3MPDARqwx45LBTW2OgrgFIAfsrcPcRXZAV
	JEH6HpRqrP3S7NVMgjg9l8sN4zwjK+9jGRIUS/Gz
X-Google-Smtp-Source: AGHT+IFfMc5GJOYS4lujSIl+qen6QYERgYOKhcmC/OXIcTO8/V2hPEh2/qveMG2Ne+noziORysSIKw==
X-Received: by 2002:a05:6214:ac5:b0:6d8:a70d:5e48 with SMTP id 6a1803df08f44-6d8b740a271mr35475566d6.30.1733212196512;
        Mon, 02 Dec 2024 23:49:56 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d89848aa37sm34091556d6.100.2024.12.02.23.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:49:55 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id EB0211200043;
	Tue,  3 Dec 2024 02:49:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 03 Dec 2024 02:49:54 -0500
X-ME-Sender: <xms:IrhOZz7BPiju2Vya7zo19H0S1vbowPxiLsDARCRhoij72_H7_Gv7EA>
    <xme:IrhOZ44XdLXiwj7opqu1NuxOusp8o39opusynym6BNRaHWPSXk84yDUBrbYaS4AEu
    SFWHw7aXe_WNmoEmg>
X-ME-Received: <xmr:IrhOZ6fz32GIip3vjQ-F2RIXIW029kSOkFgwRvxDdF_SOsIUWNelvd6PsU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedugdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieev
    tdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrg
    hilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtoheprhihohhtkhhkrhelkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepsghighgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegtlh
    hrkhiflhhlmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehg
    ohhoughmihhsrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidrug
    gv
X-ME-Proxy: <xmx:IrhOZ0I0GpZfOHp4wJS7oYCdsiPvEckylrNZUWYTl9KsacnICV9ucg>
    <xmx:IrhOZ3JQNxm5BxnCiCVz4OVmtl1ZWwk85NV0govEwewqvhGWazek1Q>
    <xmx:IrhOZ9xI0vRzkvMyyIJpBcesDOpB3n9IQYUWYlljWcgdMyc6Atp6Zg>
    <xmx:IrhOZzI_bJBx3mVtgp6YDvxmMl5uTQfABNvneP9JfLbeUNzqYkIiNA>
    <xmx:IrhOZyahpmUdsOP2BK8Phq-yaJVBDG17yGrMOWcKWvPN8HyDmPp0YCUA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 02:49:54 -0500 (EST)
Date: Mon, 2 Dec 2024 23:49:24 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ryo Takakura <ryotkkr98@gmail.com>, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
Message-ID: <Z064BAsxrEe5zQV7@boqun-archlinux>
References: <20241202012017.14910-1-ryotkkr98@gmail.com>
 <20241202103228.GM24400@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202103228.GM24400@noisy.programming.kicks-ass.net>

On Mon, Dec 02, 2024 at 11:32:28AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 02, 2024 at 10:20:17AM +0900, Ryo Takakura wrote:
> > Commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
> > PREEMPT_RT.") stopped updating @softirq_context on PREEMPT_RT
> > to ignore "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage"
> > as the report accounts softirq context which PREEMPT_RT doesn't
> > have to.
> > 
> > However, wait context check still needs to report mutex usage
> > within softirq, even when its threaded on PREEMPT_RT. The check
> > is failing to report the usage as task_wait_context() checks if
> > its in softirq by referencing @softirq_context, ending up not 
> > assigning the correct wait type of LD_WAIT_CONFIG for PREEMPT_RT's
> > softirq.
> > 
> > [    0.184549]   | wait context tests |
> > [    0.184549]   --------------------------------------------------------------------------
> > [    0.184549]                                  | rcu  | raw  | spin |mutex |
> > [    0.184549]   --------------------------------------------------------------------------
> > [    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
> > [    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
> > [    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
> > 
> > Account softirq context but only when !PREEMPT_RT so that
> > task_wait_context() returns LD_WAIT_CONFIG as intended.
> > 
> > Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> > 
> > 
> > ---
> > 
> > Hi! 
> > 
> > I wasn't able come up with a way to fix the wait context test while 
> > keeping the commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting 
> > on PREEMPT_RT.") without referencing @softirq_context...
> > Hoping to get a feedback on it!
> > 
> > Also I wonder if the test can be skipped as I believe its taken care 

Skipping the test would be awful because tests are supposed to catch
unexpected bugs :/

> > by spinlock wait context test since the PREEMPT_RT's softirq context is 
> > protected by local_lock which is mapped to rt_spinlock.
> 
> Right,.. so I remember talking about this with Boqun, and I think we
> were going to 'fix' the test, but I can't quite remember.
> 
> Perhaps adding the local_lock to SOFTIRQ_ENTER?

So I took a look, SOFTIRQ_ENTER() already calls local_bh_disable(),
which is supposed to acquire a local_lock "softirq_ctrl.lock" (Ryo, I
believe this is the local_lock you mentioned above?) in normal cases.
However, if local_bh_disable() is called with preempt disabled, then no
local_lock will be acquired. For example, if you do:

	preempt_disable();
	local_bh_disable();
	preempt_enable();
	mutex_lock();

no local_lock will be acquired, therefore check_wait_context() will
report nothing. The fun part of "why this caused an issue in the lockdep
selftests?" is these tests are run with preempt_count() == 1 ;-) I guess
this is because we run these in early stage of kernel booting? Will take
a look tomorrow.

Maybe the right way to fix this is adding a conceptual local_lock for
BH disable like below.

Regards,
Boqun

------------------------->8
diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index fc53e0ad56d9..d5b898588277 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -4,6 +4,7 @@
 
 #include <linux/instruction_pointer.h>
 #include <linux/preempt.h>
+#include <linux/lockdep.h>
 
 #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
@@ -15,9 +16,12 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
 }
 #endif
 
+extern struct lockdep_map bh_lock_map;
+
 static inline void local_bh_disable(void)
 {
 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
+	lock_map_acquire(&bh_lock_map);
 }
 
 extern void _local_bh_enable(void);
@@ -25,6 +29,7 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
 
 static inline void local_bh_enable_ip(unsigned long ip)
 {
+	lock_map_release(&bh_lock_map);
 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 8b41bd13cc3d..17d9bf6e0caf 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -1066,3 +1066,13 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
 {
 	return from;
 }
+
+static struct lock_class_key bh_lock_key;
+struct lockdep_map bh_lock_map = {
+	.name = "local_bh",
+	.key = &bh_lock_key,
+	.wait_type_outer = LD_WAIT_FREE,
+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
+	.lock_type = LD_LOCK_PERCPU,
+};
+EXPORT_SYMBOL_GPL(bh_lock_map);

