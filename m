Return-Path: <linux-kernel+bounces-439945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1B59EB693
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9F5283629
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8F72116FA;
	Tue, 10 Dec 2024 16:36:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDA61BDABE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848568; cv=none; b=kClwVH02VY69n8DzoBVZ+9q0P1EboGBuecL1St8CMJqjwMayM9k4Qv/lvYDVYhO8T6n++P0UJLwl23UB7GFNwPBZsZT3DwumjR4+9951GYG6kOHTslWABOuuoivmHiQg5u+jvjRhcHL1wPpDnv+JUxNqiILhQULaIka/tArOuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848568; c=relaxed/simple;
	bh=HwASyyvcsaBbJaDtuiZm7NcZG2UFBV7lOyWsR13eWyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkGSE++VBUo8vQQNYhKVbcHA+1F4cOvE5+kwOq6bK3WS5RZhEByrOjZTei62Mbp3r0x8l1e8OUSCqIC995GJNGPr0OhxweiRXqep9nHB29i3x+LMeBrk9s0SL872E81aO6LGLTdQX67mzcqpXAQF9m00hepFDoEylPwj+IdISTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4A18497;
	Tue, 10 Dec 2024 08:36:32 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD03F3F5A1;
	Tue, 10 Dec 2024 08:36:03 -0800 (PST)
Date: Tue, 10 Dec 2024 16:35:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm64/signal: Silence spurious sparse warning storing
 GCSPR_EL0
Message-ID: <Z1ht7X2LRw34pMJK@J2N7QTR9R3>
References: <20241210-arm64-gcs-signal-sparse-v1-1-26888bcd6f89@kernel.org>
 <Z1hU0Ii-Sm9NHnhj@J2N7QTR9R3>
 <20c12aac-193e-43ae-9418-39db1af4ede9@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20c12aac-193e-43ae-9418-39db1af4ede9@sirena.org.uk>

On Tue, Dec 10, 2024 at 03:44:29PM +0000, Mark Brown wrote:
> On Tue, Dec 10, 2024 at 02:48:48PM +0000, Mark Rutland wrote:
> > On Tue, Dec 10, 2024 at 12:42:53AM +0000, Mark Brown wrote:
> > > We are seeing a false postive sparse warning in gcs_restore_signal()
> > > 
> > > arch/arm64/kernel/signal.c:1054:9: sparse: sparse: cast removes address space '__user' of expression
> 
> > This isn't a false positive; this is a cross-address space cast that
> > sparse is accurately warning about. That might be *benign*, but the tool
> > is doing exactly what it is supposed to.
> 
> The spuriousness is arguable, from my point of view it's spurious in
> that we don't have the type of the system register we're writing to.

All that I'm asking for here is a trivial rewording; make the title say
something like:

  arm64/signal: Avoid sparse warning when manipulating GCSPR_EL0

... and in the commit message, say something like:

  Sparse complains about the manipulation of the GCSPR_EL0 value in
  gcs_restore_signal(), because we cast to/from the __user address space
  without a __force cast. Silence this warning by ${DOING_THING}.

... which clearly explains what's actually going wrong, rather than
making spurious complaints about the tool that may mislead a reader of
the commit message.

> > > +	write_sysreg_s((unsigned long)(gcspr_el0 + 1), SYS_GCSPR_EL0);
> 
> > Only one line here wants a __user pointer, so wouldn't it be simpler to
> > pass 'gcspr_el0' as an integer type, and cast it at the point it's used
> > as an actual pointer, rather than the other way around?
> 
> > Then you could also simplify gcs_restore_signal(), etc.
> 
> I find it both safer and clearer to keep values which are userspace
> pointers as userspace pointers rather than working with them as
> integers, using integers just sets off alarm bells.  

Having casts strewn throughout the code sets off more alarm bells for
me.

> > Similarly in map_shadow_stack(), it'd be simpler to treat cap_ptr as an
> > integer type.
> 
> With map_shadow_stack() it's a bit of an issue with letting users
> specify a size but yeah, we could do better there.

I don't follow. The only place where size interacts with cap_ptr is when
we initialize cap_ptr, and there we're adding size to an integer type:

	cap_ptr = (unsigned long __user *)(addr + size -
					   (cap_offset * sizeof(unsigned long)));

I was suggesting something along the lines of the diff below.

Mark.

diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 5c46ec527b1cd..096add5f2ddb2 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -71,10 +71,7 @@ unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
 SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
 {
        unsigned long alloc_size;
-       unsigned long __user *cap_ptr;
-       unsigned long cap_val;
        int ret = 0;
-       int cap_offset;
 
        if (!system_supports_gcs())
                return -EOPNOTSUPP;
@@ -106,17 +103,16 @@ SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsi
         * can be switched to.
         */
        if (flags & SHADOW_STACK_SET_TOKEN) {
+               unsigned long cap_addr = addr + size - sizeof(unsigned long);
+               unsigned long cap_val;
+
                /* Leave an extra empty frame as a top of stack marker? */
                if (flags & SHADOW_STACK_SET_MARKER)
-                       cap_offset = 2;
-               else
-                       cap_offset = 1;
+                       cap_addr -= sizeof(unsigned long)
 
-               cap_ptr = (unsigned long __user *)(addr + size -
-                                                  (cap_offset * sizeof(unsigned long)));
-               cap_val = GCS_CAP(cap_ptr);
+               cap_val = GCS_CAP(cap_addr);
 
-               put_user_gcs(cap_val, cap_ptr, &ret);
+               put_user_gcs(cap_val, (unsigned long __user *)cap_addr, &ret);
                if (ret != 0) {
                        vm_munmap(addr, size);
                        return -EFAULT;

