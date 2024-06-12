Return-Path: <linux-kernel+bounces-211283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73076904F75
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7412B23F00
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3AE16DECE;
	Wed, 12 Jun 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDLffwru"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA916DEC4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185347; cv=none; b=oQscx4hyAe7VuYxjy0sOQ1Xxo6W00YH9XMOkXaQjklBUbbsrbZxv//NiBVEGGOe9E503PlwNEnucTQFr5nZAgQ0OXpO6iBvzeDN1pNIObcZtq9+X3gn7/Og9Pe0uUCkqEJnHG+7afKu+pBekXFIJlAdUJltOx/KGRkES1cBa3AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185347; c=relaxed/simple;
	bh=HSw4dh9ub1weWo54EjUwm4+S05HXKpduCgiu8K38Otc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3gYxIOhtofemHuIiBY21xmYAyd7Jt7AkeZqJfOiDMSfvxREpyzYgFNvoCVeQ6tvH31bAdXQKt3k14OGyv4kw8lS5AV3DA15Dw/ua/0Wy8WrOIEEu0jBTEOl/l944rMKaaLzjgP+cHfssOeX1Vt9W7arekG14xYcVzXRRRw4L00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDLffwru; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718185344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kUU9aT8VrQY+jhgvOdk1khebdB5vgwSRueu/S2I096g=;
	b=WDLffwruSi9eLcr/wQnHd6NakZCpyIONAV00mnVPqGxtrfpjtdlj02fOH9iPoLJBNU1c7r
	9UqEUaVD7swBpPEEEymyjM6SFsOSSE15vGh4HXC/DCPMPt2QH/daYEyohcdJ8npTmfBgn2
	U1PyxhXt9Cu1u4uQxYQvNF+mMadDKNM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-8jC_LyeSP_-quMvA8gVmCQ-1; Wed,
 12 Jun 2024 05:42:19 -0400
X-MC-Unique: 8jC_LyeSP_-quMvA8gVmCQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98C2519560B5;
	Wed, 12 Jun 2024 09:42:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.215])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 70A4930000C4;
	Wed, 12 Jun 2024 09:42:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 12 Jun 2024 11:40:45 +0200 (CEST)
Date: Wed, 12 Jun 2024 11:40:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 3/9] x86/fpu: Make task_struct::thread constant size
Message-ID: <20240612094039.GA23973@redhat.com>
References: <20240608073134.264210-1-mingo@kernel.org>
 <20240608073134.264210-4-mingo@kernel.org>
 <20240610211350.GA1613053@thelio-3990X>
 <20240611124145.GA26798@redhat.com>
 <ZmlZiHVF8w09mExw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmlZiHVF8w09mExw@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/12, Ingo Molnar wrote:
>
> * Oleg Nesterov <oleg@redhat.com> wrote:
>
> > > +	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
> > > +	x86_init_fpu.last_cpu = this_cpu;
> >
> > Why? I think it should do
> >
> > 	x86_init_fpu.last_cpu = -1;
> > 	set_thread_flag(TIF_NEED_FPU_LOAD);
> >
> > And the next patch should kill x86_init_fpu altogether, but keep
> > TIF_NEED_FPU_LOAD. It should be never cleared if PF_KTHREAD.
>
> So I applied the patch further below on top of:
>
>    4f4a9b399357 x86/fpu: Make task_struct::thread constant size
>
> And Nathan's 32-bit kernel testcase [but running with 1 CPU to simplify it]
> still crashes in a similar fashion

Yes, I didn't expect it can fix the problem. Still makes sense, I think.

> in the (first?) modprobe instance with a
> bad FPU state exception:

OK, I reproduced it too. I see nothing wrong in the usermodehelper or
kernel_execve paths... and fpu_clone() looks fine, "minimal" is still
true if init_task or another PF_KTHREAD calls user_mode_thread().

So I appiled the patch below and save_fpregs_to_fpstate() in
fpu__init_system() triggers the WARN_ON_FPU(err) in os_xsave()

	[    0.014609] RESTORED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	[    0.014958] ------------[ cut here ]------------
	[    0.014958] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.h:189 save_fpregs_to_fpstate+0x74/0x80
	...

so I _think_ we can probably forget about modprobe/etc.

Oleg.


diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index 10d0a720659c..9fa78f75b2e5 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -56,8 +56,8 @@ static inline void fpregs_restore_userregs(void)
 	struct fpu *fpu = x86_task_fpu(current);
 	int cpu = smp_processor_id();
 
-	if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_USER_WORKER)))
-		return;
+//	if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_USER_WORKER)))
+//		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
 		/*
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 4e8d37b5a90b..0e63d54595aa 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -5,11 +5,11 @@
 #include <asm/fpu/api.h>
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
-
+#include <asm/fpu/signal.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
 #include <linux/init.h>
-
+#include "context.h"
 #include "internal.h"
 #include "legacy.h"
 #include "xstate.h"
@@ -75,12 +75,12 @@ static struct fpu x86_init_fpu __read_mostly;
 
 static void __init fpu__init_system_early_generic(void)
 {
-	int this_cpu = smp_processor_id();
+//	int this_cpu = smp_processor_id();
 
 	fpstate_reset(&x86_init_fpu);
 	current->thread.fpu = &x86_init_fpu;
-	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
-	x86_init_fpu.last_cpu = this_cpu;
+	set_thread_flag(TIF_NEED_FPU_LOAD);
+	x86_init_fpu.last_cpu = -1;
 
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
@@ -217,6 +217,7 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
  */
+void save_fpregs_to_fpstate(struct fpu *fpu);
 void __init fpu__init_system(void)
 {
 	fpu__init_system_early_generic();
@@ -231,4 +232,10 @@ void __init fpu__init_system(void)
 	fpu__init_system_xstate_size_legacy();
 	fpu__init_system_xstate(fpu_kernel_cfg.max_size);
 	fpu__init_task_struct_size();
+
+	BUG_ON(x86_task_fpu(current) != &x86_init_fpu);
+	fpregs_restore_userregs();
+	pr_crit("RESTORED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
+	save_fpregs_to_fpstate(&x86_init_fpu);
+	pr_crit("SAVED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
 }


