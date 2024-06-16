Return-Path: <linux-kernel+bounces-216246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40547909D1A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94B31F21424
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7719187339;
	Sun, 16 Jun 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcaHqvX1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B2C2F2B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718535460; cv=none; b=YfRm7c8qcpXbudBmUAXUSC5ts0GIS6oONNVfreqSGySjR+fIfkH7O4seeVL7X9K4bAiaEHx3eDWX4PG4D4lZU8Gsmw+iQ3TJ2zs1QuScy7U2IjfVMkQG+/7cyGJ9tb4LL/6d8kXxfdVriQqCTiMqpVJHWrJl3aARDQ7JMCJgnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718535460; c=relaxed/simple;
	bh=lT+7jy1TsghTd7hBJsamK9CCbx90HbEOd6ZrkTkX7Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fej5CryBCrvIRkYVu31W35SFBOkk/FgFpi5oHbY7MyKod4ftq2VO+iMGRh0RjT4W5zOK0RADngPUpjM1kBUmRXPAs/TPLSPgjkPgmmPKpAy5sK59RMS9rEEecwQtuOVyaqXXw+VGjsTeMEs1a9WHmeZQ+5r239l3Jw8ltsVDlhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcaHqvX1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718535458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dPWNw5rM16mDlaXdfYIdcTXFH2yzS6Zl30ajhlUPr8E=;
	b=fcaHqvX1VM1S0PybCbm8qTnKjyy3XGBfcwp863bDofrm/AC+Yp6SWRU2j9sdu9siccaqST
	/CStlifrzOx7tqFPuJNiO3Q9WA2BEqC7XsMI+Cwh3VtDJtqa3XCvRDBaGTBel2LQp61gTX
	gjVio27SQdvRQa9bj1AbRD4/QnPvzlo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-cU4dpq-dM42oKM-BHmVROA-1; Sun,
 16 Jun 2024 06:57:31 -0400
X-MC-Unique: cU4dpq-dM42oKM-BHmVROA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 091D719560AB;
	Sun, 16 Jun 2024 10:57:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 816B03000218;
	Sun, 16 Jun 2024 10:57:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 16 Jun 2024 12:55:57 +0200 (CEST)
Date: Sun, 16 Jun 2024 12:55:50 +0200
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
Subject: Re: [PATCH 10/9] x86/fpu: Fix 'struct fpu' misalignment on 32-bit
 kernels
Message-ID: <20240616105550.GA18292@redhat.com>
References: <20240608073134.264210-1-mingo@kernel.org>
 <20240608073134.264210-4-mingo@kernel.org>
 <20240610211350.GA1613053@thelio-3990X>
 <20240611124145.GA26798@redhat.com>
 <ZmlZiHVF8w09mExw@gmail.com>
 <20240612184148.GB23973@redhat.com>
 <Zmq9ppuIZJ9IMZDr@gmail.com>
 <20240614151404.GA27644@redhat.com>
 <20240615102352.GA18384@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615102352.GA18384@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/15, Oleg Nesterov wrote:
>
> So perhaps we can (later) change x86_task_fpu(), fpu_clone(), and
> fpu__init_task_struct_size() to use
>
> 	ALIGN(sizeof(struct task_struct), 64)
>
> and remove the alignment attribute in sched.h?

On the 2nd thought, perhaps this makes sense from the very beginning?
See the patch below, up to you.

> Or use ARCH_MIN_TASKALIGN == __alignof__(union fpregs_state) which is
> also used in fork_init()->kmem_cache_create().

Either way, I hope that CONFIG_X86_VSMP can't define ARCH_MIN_TASKALIGN
less than __alignof__(fpregs_state).

Oleg.
---

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 64509c7f26c8..7887e9493330 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -507,6 +507,9 @@ struct thread_struct {
 	struct fpu		*fpu;
 };
 
+#define X86_TASK_SIZE	\
+	ALIGN(sizeof(struct task_struct), __alignof__(union fpregs_state))
+
 #define x86_task_fpu(task) ((task)->thread.fpu)
 
 /*
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index f0c4367804b3..613198372764 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -591,7 +591,7 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	 * This is safe because task_struct size is a multiple of cacheline size.
 	 */
 	struct fpu *src_fpu = x86_task_fpu(current);
-	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
+	struct fpu *dst_fpu = (void *)dst + X86_TASK_SIZE;
 
 	BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);
 	BUG_ON(!src_fpu);
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 4e8d37b5a90b..8b43c83b82c7 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -71,16 +71,14 @@ static bool __init fpu__probe_without_cpuid(void)
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
-static struct fpu x86_init_fpu __read_mostly;
+static struct fpu x86_init_fpu __aligned(64) __read_mostly;
 
 static void __init fpu__init_system_early_generic(void)
 {
-	int this_cpu = smp_processor_id();
-
 	fpstate_reset(&x86_init_fpu);
 	current->thread.fpu = &x86_init_fpu;
-	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
-	x86_init_fpu.last_cpu = this_cpu;
+	set_thread_flag(TIF_NEED_FPU_LOAD);
+	x86_init_fpu.last_cpu = -1;
 
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
@@ -157,7 +155,7 @@ static void __init fpu__init_system_generic(void)
  */
 static void __init fpu__init_task_struct_size(void)
 {
-	int task_size = sizeof(struct task_struct);
+	int task_size = X86_TASK_SIZE;
 
 	task_size += sizeof(struct fpu);
 


