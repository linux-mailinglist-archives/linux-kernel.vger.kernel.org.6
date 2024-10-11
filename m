Return-Path: <linux-kernel+bounces-361426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C391D99A805
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67AFC1F22414
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB10E195B37;
	Fri, 11 Oct 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAni/X7n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF37195F22
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661209; cv=none; b=McJc7S0a6KyEXT4pduhV5DZr6ie3woddU9im1EJeHuxHo8hq4tQWEC4xZmdGEAJkcWAZJhLQlIMUtKu4LRyWdkSA32a9H9hqzrlIsr7Eu4FFDNStbjUNIRFv5syNY4ZsXGr/OicGtjAGBv947fFCbJCRk+tRTYYFY0OJa99lBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661209; c=relaxed/simple;
	bh=p12mizpy4UBDMafTnY9aYbveCfe5qj+904EjTUMkA7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3wqUgCbmrQbGGIho7GPcvmYQ+Camb/cBrY1TfY4on5bJ+/1MRiLdra1oQtBm4j9uyfMfkJfUzhk9X3HKRL73rw+yGue/lTgFq/vSEUwoh+fH0+Dynrq94cQye2eHuG+z5mk1MOmYG0RdFDPphwZREhnTGy0wNNAZuALOBDLyEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAni/X7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91256C4CEC3;
	Fri, 11 Oct 2024 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728661208;
	bh=p12mizpy4UBDMafTnY9aYbveCfe5qj+904EjTUMkA7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAni/X7nhn7oh/aFBnZ47vWaes7QdLTSTLCwLDHHoF7+IkkTnRcAOkeBrgGVI9g1h
	 Oz9NlYaCE+7N1MkODhRQFs9Qvx3nQcVMZWDW8AbZ8Sbwct5fq9LK5ZGsbrSAAUWZSF
	 aFARs61qPMhD3MSjXFgBueB/f0qZG37ta1mhPT2IBWOGAH62I6HfQbfXA5AMCBTG9A
	 kXLn2EnPTvjeB/niRIhmOA3wYUkjT/cg5UbjKDpAy1dF7dhc5JyV2jbrYk3Za3UZhB
	 bgVBBUVbTJNPkLotzdRvGLFap1zmaDYvTAEUjewSN0K+EFVYvR4MgmEs6ENfCouq3x
	 DIyXWzrJWa4aQ==
Date: Fri, 11 Oct 2024 08:39:38 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	brgerst@gmail.com, samitolvanen@google.com, kees@kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Ye Weihua <yeweihua4@huawei.com>
Subject: Re: [PATCH] x86/unwind/orc: Fix unwind for newly forked tasks
Message-ID: <20241011153938.knk2yp46ajjo27gj@treble>
References: <20240913024501.1337327-1-zhengyejian@huaweicloud.com>
 <20240913231108.a3ukhoyhp2xactdq@treble>
 <afae0e1f-7033-858c-ea5d-2b4a5383e9c6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afae0e1f-7033-858c-ea5d-2b4a5383e9c6@huaweicloud.com>

On Fri, Oct 11, 2024 at 02:50:32PM +0800, Zheng Yejian wrote:
> On 2024/9/14 07:11, Josh Poimboeuf wrote:
> > On Fri, Sep 13, 2024 at 10:45:01AM +0800, Zheng Yejian wrote:
> > > When arch_stack_walk_reliable() is called to unwind for newly forked
> > > tasks, the return value is negative which means the call stack is
> > > unreliable. This obviously does not meet expectations.
> > > 
> > > The root cause is that after commit 3aec4ecb3d1f ("x86: Rewrite
> > >   ret_from_fork() in C"), the 'ret_addr' of newly forked task is changed
> > > to 'ret_from_fork_asm' (see copy_thread()), then at the start of the
> > > unwind, it is incorrectly interprets not as a "signal" one because
> > > 'ret_from_fork' is still used to determine the initial "signal" (see
> > > __unwind_start()). Then the address gets incorrectly decremented in the
> > > call to orc_find() (see unwind_next_frame()) and resulting in the
> > > incorrect ORC data.
> > > 
> > > To fix it, check 'ret_from_fork_asm' rather than 'ret_from_fork' in
> > > __unwind_start().
> > > 
> > > Fixes: 3aec4ecb3d1f ("x86: Rewrite ret_from_fork() in C")
> > > Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
> > 
> > Thanks!
> > 
> > Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > 
> 
> Hi, Josh, thanks for your ack!
> Will this patch go into mainline soon?

Sorry about that, I'll go ahead and queue this up.

-- 
Josh

