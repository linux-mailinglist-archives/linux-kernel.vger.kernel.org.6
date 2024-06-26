Return-Path: <linux-kernel+bounces-231172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B312E918719
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50081C22017
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9AF186294;
	Wed, 26 Jun 2024 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkNlVpre"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD35018A92A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418568; cv=none; b=BYE1QJyj8TYVbNaNf7AAuVIx1G+5wJpbSLszWld1POOl/cLQ+INbzjZ4BvHUacwrCu9SgKCZJfvOY8YS8g+dgHjHAmEnHCNHvjm72YknfFahmk8MYWnsLPQSQQO8R4oy+cuThfW802P390+etWEW+fDi7u/GnLdf39t6HI5NcW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418568; c=relaxed/simple;
	bh=Mg1bPnbPD363GuddJswMdK7zDdLLbDjY3zLFI0ddO+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdaokaFP1LLUG3vv18zrc8uooJiCfUBN1tPPyG4RgAtZyaJvD+dlB4y1acGlNxlP3+UWzNYFczjhmN21VMaDg3helxBXOyo9OyDx60lwtSZRYbZqIuOk0KUezpoKtoNvWy2q+SinHWphT5rNeKSaWxpx9tLhdSIgWEz/Ox4zMxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkNlVpre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC9CC116B1;
	Wed, 26 Jun 2024 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719418568;
	bh=Mg1bPnbPD363GuddJswMdK7zDdLLbDjY3zLFI0ddO+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkNlVpreFP/iP0k/bpL5R2bY28xwLcbl/ldpo8GOeHzUxxJLpqMxp2Iij4Npe3hH5
	 6wu8s9zHVxRONqzwE9FklCg7XawsbzXa47o8i5qGraIPAmqQz9TW53i1DNdI/mbLxO
	 IZuUjBFXvfwpG3h0baArjNRuTO3c3JzqMWTIlHJfVN4ZuB/nkUdoeeH2xEBHLePv+q
	 SoqNQxjU3gqNFGNU5Hdu+6fbwwbgOU1M4ynM4/KuZmX1b5q5/Klf9D0Sc2UEZWl8CT
	 9AXtiXRxWeN67jRTeFt8TEmOVLhQ27m4SpTaGDW4K9vJVSE1y+N/+a/EQvCYP+frTl
	 BVv+gXQ3w+xxg==
Date: Thu, 27 Jun 2024 00:02:02 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andreas Schwab <schwab@suse.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] riscv: uaccess: use input constraints for ptr of
 __put_user
Message-ID: <Znw7engdDiMldJp2@xhacker>
References: <20240625040500.1788-1-jszhang@kernel.org>
 <20240625040500.1788-3-jszhang@kernel.org>
 <mvmikxvonjh.fsf@suse.de>
 <ZnwTwnSsnZ8Td9GZ@xhacker>
 <dcf9574a-0f1b-4131-befd-39f47d4f9002@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcf9574a-0f1b-4131-befd-39f47d4f9002@app.fastmail.com>

On Wed, Jun 26, 2024 at 04:25:26PM +0200, Arnd Bergmann wrote:
> On Wed, Jun 26, 2024, at 15:12, Jisheng Zhang wrote:
> > On Wed, Jun 26, 2024 at 03:12:50PM +0200, Andreas Schwab wrote:
> >> On Jun 25 2024, Jisheng Zhang wrote:
> >> 
> >> > I believe the output constraints "=m" is not necessary, because
> >> > the instruction itself is "write", we don't need the compiler
> >> > to "write" for us.
> >> 
> >> No, this is backwards.  Being an output operand means that the *asm* is
> >> writing to it, and the compiler can read the value from there afterwards
> >> (and the previous value is dead before the asm).
> >
> > Hi Andreas,
> >
> > I compared tens of __put_user() caller's generated code between orig
> > version and patched version, they are the same. Sure maybe this is
> > not enough. 
> >
> > But your explanation can be applied to x86 and arm64 __put_user()
> > implementations, asm is also writing, then why there's no output
> > constraints there?(see the other two emails)? Could you please help
> > me to understand the tricky points?
> 
> I think part of the reason for the specific way the x86
> user access is written is to work around bugs in old
> compiler versions, as well as to take advantage of the
> complex addressing modes in x86 assembler, see this bit
> that dates back to the earliest version of the x86_64
> codebase and is still left in place:
> 
> /* FIXME: this hack is definitely wrong -AK */
> struct __large_struct { unsigned long buf[100]; };
> #define __m(x) (*(struct __large_struct __user *)(x))
> 
> Using the memory input constraint means that x86 can use
> a load from a pointer plus offset, but riscv doesn't
> actually do this. The __large_struct I think was needed
> either to prevent the compiler from reading the data
> outside of the assembly, or to tell the compiler about
> the fact that there is an actual memory access if
> __put_user() was pointed at kernel memory.

Thank you so much, Arnd!

> 
> If you just copy from the arm64 version that uses an
> "r"(address) constraint instead of the "m"(*address)

"m" version is better than "r", usually can save one
instruction.
I will try to combine other constraints with "r" to
see whether we can still generate the sd with offset
instruction. If can't, seems sticking with "m" and keeping
output constraints is better

> version, it should be fine for any user space access.

You only mention "user space access", so just curious, does
arm64 version still correctly work with below __put_kernel_nofault()
example?

> 
> The output constraint is technically still be needed
> if we have code like this one where we actually write to
> something in kernel space:
> 
> int f(void)
> {
>      int a = 1;
>      int b = 2;
>      __put_kernel_nofault(&a, &b, int, error);
>      return a;
> error:
>      return -EFAULT;
> }
> 
> In this case, __put_kernel_nofault() writes the value
> of b into a, but the compiler can safely assume that
> a is not changed by the assembly because there is no
> memory output, and would likely just return a constant '1'. 
> 
> For put_user(), this cannot happen because the compiler
> doesn't know anything about the contents of the __user
> pointer. For __put_kernel_nofault(), we rely on the
> callers never using it on pointers they access, which
> is probably a reasonable assumption, but not entirely
> correct.
> 
>      Arnd

Well explained! Thanks a lot.

