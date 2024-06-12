Return-Path: <linux-kernel+bounces-212107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16640905B49
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51491F217C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED884CB5B;
	Wed, 12 Jun 2024 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LctJ6ty3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DCB47F60
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217816; cv=none; b=aVdqu6BH2vhCiugP5cEr1RqWQvEEAsjGlNfPQAUyfJmLarJm5qpgmv9ZlMfVtElHeGCt8ONsLVBMkfqUY9bTZ8vSe6saxhwWfO5FAtTIrUWmkpv0GqaAogy34ItCFmkyEOCl2ejWaIixyRfkoEStDci2+vlkoktF5aAZKVwQPz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217816; c=relaxed/simple;
	bh=o7ns0CAimFMDnmRjVIVStSrzzCFJQjHy/Tp515miRY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgVOfQIMHhKsLsO0pFBlQeleDIC7PbV+NNAGnGF5ybZISN0d0RYeJvRPX0Y/OtNxCLIBVGvEMXnq9pws+hbuZwx4A7C6fi8flaGaO7cW8sYFJhqYSybd/rl/M8x6k3y4OIlI8JbCJOoj86H5mOptcrHXSUsYUywY3PkZFb7qNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LctJ6ty3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718217813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XSie2rDJ5lPJ+f0eDBkZKw9s3cyHlIqim7LR340IID4=;
	b=LctJ6ty30DFZ75Mc1zzsgqYsBzAi2o/4jqo2zxAPyxkMVnq+mxkb9LfhcRWnksKqzkA/39
	EpE1j4RBB7lH8oY8pCJWtdG55FUYhXM2YdgQBAzb5GFDLAMCPoFkLEqk1EoDBk7Pdh9ENi
	y5E3O4UHsaGvJpuI3pnzmfg4SkSRwwM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-2pUjVqh4Mya6sBGXoAxjQQ-1; Wed,
 12 Jun 2024 14:43:28 -0400
X-MC-Unique: 2pUjVqh4Mya6sBGXoAxjQQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 610E71956068;
	Wed, 12 Jun 2024 18:43:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.215])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 968DC1956050;
	Wed, 12 Jun 2024 18:43:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 12 Jun 2024 20:41:54 +0200 (CEST)
Date: Wed, 12 Jun 2024 20:41:48 +0200
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
Message-ID: <20240612184148.GB23973@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The patch below seems to fix the problem.

Again, the changes in fpu__init_system_early_generic() are not
strictly needed to fix it, but I believe make sense anyway.

Oleg.


diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 4e8d37b5a90b..848ea79886ba 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -71,16 +71,14 @@ static bool __init fpu__probe_without_cpuid(void)
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
-static struct fpu x86_init_fpu __read_mostly;
+static struct fpu x86_init_fpu __attribute__ ((aligned (64))) __read_mostly;
 
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
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 215a7380e41c..ec22b9bf27f5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1562,7 +1562,7 @@ struct task_struct {
 	 * they are included in the randomized portion of task_struct.
 	 */
 	randomized_struct_fields_end
-};
+} __attribute__ ((aligned (64)));
 
 #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
 #define TASK_REPORT_MAX		(TASK_REPORT_IDLE << 1)


