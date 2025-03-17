Return-Path: <linux-kernel+bounces-564823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BAAA65B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C7E1895923
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFDB1CCEC8;
	Mon, 17 Mar 2025 17:45:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AA01C8607
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233526; cv=none; b=l++AKJ60X3InT83wzMje3jyBL6GppJsiCIgcwm2Dv3icHa0JAr+DbYFBYJCkgA9t5o0bQnnBxGgymdwdCi15rKsGrKIBxerudzvPjlRvR3cVmxzEeGwZGD/6LzbM8KSi0g6IlH5nyxk5fo9Z9e3ZIQxo/1ANnAvwDFJYf2e+1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233526; c=relaxed/simple;
	bh=p+aKngnMxSF8d/jqu0kk/3CUtHVCZarSj1pyygL9FV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnUJ+DTt+65lbqt0dJsWvZEq70sLogBn12VwCymC6F+MsSuR2k6weuBx07ex+5zT1Che9Pe0pPj+qU1f2F1+6QPNGD+lDrNL/jTWZ53TQ7aE3E1dJOVDcR8KXiAVNQc15DR6DZg+VAJ1j+ur3cOpyVHr85WphJZ7Hg7/O8WVIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2DD413D5;
	Mon, 17 Mar 2025 10:45:31 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A758B3F694;
	Mon, 17 Mar 2025 10:45:22 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:45:18 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: lcherian@marvell.com, coresight@lists.linaro.org,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 6/7] coresight: Remove inlines from static function
 definitions
Message-ID: <20250317174518.GJ2487211@e132581.arm.com>
References: <20250211103945.967495-1-james.clark@linaro.org>
 <20250211103945.967495-7-james.clark@linaro.org>
 <20250314095025.GW9682@e132581.arm.com>
 <9d06b27a-c2ce-41b8-9657-151000c0b244@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d06b27a-c2ce-41b8-9657-151000c0b244@linaro.org>

On Mon, Mar 17, 2025 at 03:26:42PM +0000, James Clark wrote:
> On 14/03/2025 9:50 am, Leo Yan wrote:
> > On Tue, Feb 11, 2025 at 10:39:42AM +0000, James Clark wrote:
> > > 
> > > These are all static and in one compilation unit so the inline has no
> > > effect on the binary.
> > 
> > I read the doc coding-style.rst, the section "15) The inline disease",
> > my understanding is though the inline is not encouraged, I prefer we can
> > follow up the rule:
> > 
> >    A reasonable rule of thumb is to not put inline at functions that have more
> >    than 3 lines of code in them. An exception to this rule are the cases where
> >    a parameter is known to be a compile time constant, and as a result of this
> >    constantness you *know* the compiler will be able to optimize most of your
> >    function away at compile time. For a good example of this later case, see
> >    the kmalloc() inline function.
> > 
> 
> Isn't this advice about whether to make an inline function in a header file
> or do definition + declaration?

Maybe it is not about where defines inline functions.  It is about
how these inline functions are invoked.  E.g., in a single C file, a
inline function can be invoked in multiple places, and it is possible
the incline function can optimized by compiler case by case.

To be honest, I don't really understand how compiler works :)

[...]

> I think it can be useful, I've used it a little bit. Might as well make it
> easier to use for someone if it exists.

Sure.  This patch is fine for me.  I verified this patch with default
kernel configuration (-O2, -g), it does works as expected (no code and
data section's size change between with and without this patch).

Thanks,
Leo

