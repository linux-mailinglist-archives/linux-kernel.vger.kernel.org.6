Return-Path: <linux-kernel+bounces-571824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF8AA6C2CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81DD7A6F01
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE3122F3B8;
	Fri, 21 Mar 2025 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpa44CBY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ECE225A20
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583233; cv=none; b=MGV54fxYdvI7WMTnl9QITek9sjCghuPIuZJ0cmq2qn+Mx3y0Bdb/xm8ThfW/nB0DKc7AzMwfL4aWOtyndfwIkKUHnI+2/FcXvV74UH1FEOCSGRBFsPWf2GUAOU9wTVAKmyC5WmGUJ+lzUVTHnuv6dfry/0KiMrLeLp+JD+MvjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583233; c=relaxed/simple;
	bh=GRG+RpIcpVXkQzw86AIa7wqi73DB7ofrqw0o+C4XEHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFJtD61iEBtr0inRgAFCNAIVI5blc0Wu01OMYiwhFspDssGVXkx1ZQ31FyMG6to2ElyzqJJVTBmVuFYKQkDT6+t7dCdj0Bo9ER11YNKGd9MZtc4mR1GkvH/At1GIpvFNBziL+lHNKkUnWaaN0+2xEfQLVzwyfHQB+onGBzgkmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpa44CBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB929C4CEE3;
	Fri, 21 Mar 2025 18:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742583232;
	bh=GRG+RpIcpVXkQzw86AIa7wqi73DB7ofrqw0o+C4XEHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpa44CBY1sT7HrE3poNo2bhwdkB/24h29oJemD2eM7PbteEmP1M6+kyI1s0HTDjOT
	 HotvdSHN2IvEO2Gmroe9WmtaKTyhwnQ32D3rSLLiKpiafH4tgcLnkJc9Of4lGxlT+C
	 gjSr1PLQ0WIl/P29cxx/O3hz4LtapkCcRA7wpf/eAtKzY1QBqphuhS2sWyFu2sVOTO
	 e8EU7LTDAncnn5I9aduvOddj70h6a0xE2hfQ+3LVZic4D+k35pDkdsM9FnKe4SNjIH
	 bHU/VoISQK3MFolZTqLMDkx597bFmBcqKiYoN27hInkQDtHQCZIjbcaF+ovayDCkHb
	 0BLwCwP4z46Mw==
Date: Fri, 21 Mar 2025 11:53:50 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] tracing: Disable branch profiling in noinstr code
Message-ID: <u5yiybx34ghfisslqv4dudyph2opwedq6qdwy7ag2bcnawnnqc@cue4hs5gse32>
References: <52a664ec9e14ef53c39c3d4fa400c2f1d29348c0.1742537096.git.jpoimboe@kernel.org>
 <871puq2uop.ffs@tglx>
 <20250321131248.02114dd7@batman.local.home>
 <g4rdlv4it35nlftf6uyaewe4b52buho6pvnamjmwd2iu5cq5q2@xh4uluvgaqvn>
 <20250321142826.65a160bf@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321142826.65a160bf@batman.local.home>

On Fri, Mar 21, 2025 at 02:28:26PM -0400, Steven Rostedt wrote:
> On Fri, 21 Mar 2025 10:21:34 -0700
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > I *basically* did that, albeit in more of a surgical manner by editing a
> > lot of the makefiles in arch/x86/*/.
> > 
> > Let me see if I can figure out how to do that more broadly at the
> > arch/x86 level.
> 
> Ah, I thought there was a way to do it recursively, but I don't see a
> way to do that.
> 
> Masahiro, do you know of a way that we can add a CFLAGS option to a
> directory and all its siblings without modifying all the Makefiles?

This appears to work:

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index cf0ad89f5639..ff8f0e2fbf4b 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+subdir-ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 obj-$(CONFIG_ARCH_HAS_CC_PLATFORM) += coco/

 obj-y += entry/

-- 
Josh

