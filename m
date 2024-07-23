Return-Path: <linux-kernel+bounces-259802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E554939D68
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E571F22AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9814BFB4;
	Tue, 23 Jul 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bfnYSJt7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qX4ozGju"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E1208B6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726427; cv=none; b=OR8adVoXaMPjTsyeN15+V34DsJ13/4MuBpUmZOGUO3NFaIgpmT9grmdYL/sbwfcdAFP+OgcDGt2nAW0+sLCbYAu3yKZzuSnyuiji9A8ftrX9bfPlWd05Bo/xlqWqS51NLwPcvUQnWWca9tr83iF1cLSvVgtGaEXfRJI7NPuQjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726427; c=relaxed/simple;
	bh=pjbPLASmktH1brNQ7T+2e8HccsK78JkRS96zGdgcIVc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=S6ccxfM3J9Ab5Jbl6rMtcA9elz5HMiv7RjUaUpTKw5egOIvcuQfd3Z+3/LJ7bBkldtJggVmcdL3VdslncGNTvgxN7+BJc+FMIdkNRNWN0GwqEjzfxjWEzHRSLGQzNxDKRMknsHx3l3jPSfk4SW8nqMn5wdv19nSAiHdm4OOYLAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bfnYSJt7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qX4ozGju; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3003E11403D9;
	Tue, 23 Jul 2024 05:20:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 23 Jul 2024 05:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721726424; x=1721812824; bh=ArmI+9Lypv
	7lSLaM/gWraMfVqXyWVTNaY8nXPJ+yvQs=; b=bfnYSJt7H65pMucbCKSqznKS/g
	EH+F0X3uPMZfBtQubm8v0+prSRqJk01VAZh1T0LYNmIQgnTmrujtPPWOQQaiFUpf
	/SYi/0si/Yimqf/vocOGjvRCn/9MdgaHOfFHpNnUqtPKQJ296v8qfx7dPhFWQn78
	CflLrFbn/kkVspbp1AsbGVvOevy0ynO1hRWSlkboakQXiFFztIuzLDFOyOWCv4ow
	asZn6NpebyP+qBgOqhrqrloO+qyTMcWriBFe35nJRFc5frqdjGpC4XoOv4Y2NqIa
	3kOE4JC1CttaOozE5I62OmAcIhZ8u1AQSy4uWHGcOofjrV+5iNIzfttd+4hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721726424; x=1721812824; bh=ArmI+9Lypv7lSLaM/gWraMfVqXyW
	VTNaY8nXPJ+yvQs=; b=qX4ozGjusmbvB6RqfS4z19sayaVJZUyxKAocUuT8YldT
	KCJwcMJwy0DZgAcMb5BKR2gHZpTmFhAKRWMQziFmuCYOnan22NNX7SYR//h8qBe6
	BvHW4gEWxuafOrF8bzh6VFZP2KwUEJXj1jJHGgVl3YHRCEhwvDYxuiqnfn6FZhn6
	2nJnCKKA7EnmZ1lxne+nTW3KOTiMXLG9b/OogYSk/AYRUJ1KmJTlVdmsSY4lKy7H
	z9wDZ0EeHVhOpVXM39qH6b7HzW+UX4okqPLetL0dUkVnxhQU2hU5enXY/68J49Nc
	bY3BZ8y4vWYcIHiT9nSwAXVbRw1nY0WmvZgdDbCcmA==
X-ME-Sender: <xms:13WfZj8RLMZyk3rqeWcBdfG73QVT9flQM0FdFPumqaGndEppR5FsvA>
    <xme:13WfZvsNTMjhVCEXo5C5GRzTZ-R0K5mKQkEI-aBs5EMLGL7b6MlojbhFE9W7nQYGI
    xSX0RJmXnhrCQo0BLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:13WfZhDOtSGdMuumGD0XtFjxcDTVR15dHdD1xDvvvH9_FWLM_4h4QA>
    <xmx:13WfZveILs29-MahbjiGs2sTnaJWjlpdw_za--vV__0uvr5FZuHXVg>
    <xmx:13WfZoP_1d0ckgyUKsdsR9X5a_KaKuU5bAlET-jH1iEGNJLTmg1i5w>
    <xmx:13WfZhkZWF8X4VuDQUJyia6l-oa6f9I5rkhI9OZQoReGVK6bvOHwLw>
    <xmx:2HWfZknYfOhTG-umzxe5DRUF4xuu8lQ2D_on14Jw45aXKJGZMvbeFhCs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 66F27B6008D; Tue, 23 Jul 2024 05:20:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4896ca15-ca23-4723-92e8-c824ee6a8923@app.fastmail.com>
In-Reply-To: <20240722094226.21602-26-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-26-ysionneau@kalrayinc.com>
Date: Tue, 23 Jul 2024 09:20:03 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yann Sionneau" <ysionneau@kalrayinc.com>, linux-kernel@vger.kernel.org,
 "Christian Brauner" <brauner@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>
Cc: "Jonathan Borne" <jborne@kalrayinc.com>,
 "Julian Vetter" <jvetter@kalrayinc.com>,
 "Clement Leger" <clement@clement-leger.fr>,
 "Guillaume Thouvenin" <thouveng@gmail.com>,
 "Julien Villette" <julien.villette@gmail.com>,
 "Marius Gligor" <mgligor@kalrayinc.com>, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v3 25/37] kvx: Add system call support
Content-Type: text/plain

On Mon, Jul 22, 2024, at 09:41, ysionneau@kalrayinc.com wrote:

> +/**
> + * access_ok: - Checks if a user space pointer is valid
> + * @addr: User space pointer to start of block to check
> + * @size: Size of block to check
> + *
> + * Context: User context only.  This function may sleep.
> + *
> + * Checks if a pointer to a block of memory in user space is valid.
> + *
> + * Returns true (nonzero) if the memory block may be valid, false 
> (zero)
> + * if it is definitely invalid.
> + *
> + * Note that, depending on architecture, this function probably just
> + * checks that the pointer is in the user space range - after calling
> + * this function, memory access functions may still return -EFAULT.
> + */
> +#define access_ok(addr, size) ({					\
> +	__chk_user_ptr(addr);						\
> +	likely(__access_ok((addr), (size)));				\
> +})
> +
> +#include <asm-generic/access_ok.h>

You should not need a custom access_ok() function here, juse use
the asm-generic version directly.

> + * Copyright (C) 2017-2023 Kalray Inc.
> + * Author(s): Clement Leger
> + */
> +
> +#define __ARCH_WANT_SYS_CLONE

I previously commented that you should remove
__ARCH_WANT_NEW_STAT to match what we did for loongarch.

After long discussion, we now put that back though, so you
should probably do the same here. The way you do this is now
different with the move to the common syscall.tbl format,
and I think in the case of NEW_STAT this will change again
since we now should't even need that conditional any more.

> +
> +#define __ARCH_WANT_SYS_CLONE3

__ARCH_WANT_SYS_CLONE3 is now mandatory, and you can drop the
select in 6.11.

> +/* Additional KVX specific syscalls */
> +#define __NR_cachectl (__NR_arch_specific_syscall)
> +__SYSCALL(__NR_cachectl, sys_cachectl)

This one should now go into scripts/syscall.tbl instead.

> +SYSCALL_DEFINE4(cachectl, unsigned long, addr, unsigned long, len,
> +		unsigned long, cache, unsigned long, flags)
> +{
> +	bool wb = !!(flags & CACHECTL_FLAG_OP_WB);
> +	bool inval = !!(flags & CACHECTL_FLAG_OP_INVAL);
> +
> +	if (len == 0)
> +		return 0;
> +
> +	/* Check for overflow */
> +	if (addr + len < addr)
> +		return -EFAULT;
> +
> +	if (cache != CACHECTL_CACHE_DCACHE)
> +		return -EINVAL;
> +
> +	if ((flags & CACHECTL_FLAG_OP_MASK) == 0)
> +		return -EINVAL;
> +
> +	if (flags & CACHECTL_FLAG_ADDR_PHYS) {
> +		if (!IS_ENABLED(CONFIG_CACHECTL_UNSAFE_PHYS_OPERATIONS))
> +			return -EINVAL;
> +
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +
> +		dcache_wb_inval_phys_range(addr, len, wb, inval);
> +		return 0;
> +	}
> +
> +	return dcache_wb_inval_virt_range(addr, len, wb, inval);
> +}

This syscall is different from apparently all other architectures
that have a cache management call, in two ways:

- The CONFIG_CACHECTL_UNSAFE_PHYS_OPERATIONS flag and the operation
  behind it seems like a badly defined interface, I assume this is
  a performance hack for a particular device driver, but it should
  not really be done at the system call level. Ideally I think this
  should be redesigned so it's never needed. If you do need it for
  something, please make that a separate patch with a long explanation
  about how it's used.

- The other architectures tend to use sys_cacheflush() with
  more or less standardized calling conventions. Could you
  use the callong conventions from arch/{csky,parisc} instead?

> +#include <linux/syscalls.h>
> +
> +#include <asm/syscalls.h>
> +
> +#undef __SYSCALL
> +#define __SYSCALL(nr, call)[nr] = (call),
> +
> +void *sys_call_table[__NR_syscalls] = {
> +	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
> +#include <asm/unistd.h>
> +};

This file will have to change in 6.11 as I replaced the
uapi/asm-generic/unistd.h file with a generated version
taking scripts/syscall.tbl as its input. Please copy the
code from arch/loongarch.

       Arnd

