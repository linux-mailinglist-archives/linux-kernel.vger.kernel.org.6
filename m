Return-Path: <linux-kernel+bounces-307411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CBA964D49
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE2C1F24827
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65BC1B81AA;
	Thu, 29 Aug 2024 17:54:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080F91B6541
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954053; cv=none; b=ppQL0Qdjxk4DXb9xa808ENsJRoURObXSoMcFWmvp7BbJ3ZgvA5lOI4GPvISsamkKBVeXYUsrOsK9O7yLggIaIdULYg276dn0oHBQvb26zOpDlOcXUaITvkt6BDG0mTyqNR8+K74OokxNueqgxkrOjQ+WdRM01RiUJuGmp830RsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954053; c=relaxed/simple;
	bh=GGWbhfZVHj/Ty1krQn+9GMsuBPdkuoRKWI7iXvq5Qys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPwpO4fykgtrdm5ZrZVskAHOYxC10ccVKmRpH9JP7+WJeBbC2Kkcw5RfvK+KXSIb6BkRRDN2qpl0io81CaWy7zuSDIy93TNIIY8EbVWEftrZwLltV5GeGbkXUlYsRM2SjtxrewuchOCaGPZkfGn5XVcYb1xBcAvFi9FI+R8sX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 680EA1480;
	Thu, 29 Aug 2024 10:54:35 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 722D93F762;
	Thu, 29 Aug 2024 10:54:07 -0700 (PDT)
Date: Thu, 29 Aug 2024 18:54:01 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	chenqiwu <qiwuchen55@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	puranjay12@gmail.com
Subject: Re: [PATCH] arm64: stacktrace: fix the usage of
 ftrace_graph_ret_addr()
Message-ID: <ZtCz2IiskUTVu6Xu@J2N7QTR9R3>
References: <20240618162342.28275-1-puranjay@kernel.org>
 <ZnHHHmEv-oqaXmq0@J2N7QTR9R3>
 <20240619124318.GA3410@willie-the-truck>
 <20240624161741.2a16d904@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624161741.2a16d904@gandalf.local.home>

Hi Steve,

On Mon, Jun 24, 2024 at 04:17:41PM -0400, Steven Rostedt wrote:
> On Wed, 19 Jun 2024 13:43:18 +0100
> Will Deacon <will@kernel.org> wrote:
> 
> > > Catalin, Will, do you have any preference?  
> > 
> > I think it makes most sense if this patch travels together with
> > 29c1c24a2707 ("function_graph: Fix up ftrace_graph_ret_addr()"), so that
> > would be via Steve's tree. In which case:
> 
> That makes sense to me. I'll go around pulling in all the updates to the
> arch code here (with the respective acks).

Are you still planning to pick this up? On next-20240829 the ftrace
tests blow up (as below) due to having the core ftrace change to
ftrace_graph_ret_addr() but lacking the arm64 fix.

Splat on next-20240829:

  [2] Basic test for tracers
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 198 at arch/arm64/kernel/stacktrace.c:112 arch_stack_walk+0x1d0/0x350
  Modules linked in:
  CPU: 0 UID: 0 PID: 198 Comm: ftracetest Not tainted 6.11.0-rc5-next-20240829 #1
  Hardware name: linux,dummy-virt (DT)
  pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : arch_stack_walk+0x1d0/0x350
  lr : arch_stack_walk+0x1c4/0x350
  sp : ffff800080003e10
  x29: ffff800080003e10 x28: ffff800080003fe0 x27: ffff800080003eb8
  x26: ffff000003813600 x25: ffff800080004000 x24: ffff80008002ebd8
  x23: ffff800080003ed8 x22: ffff800080023c78 x21: ffff80008002ebd8
  x20: ffff800080003f40 x19: ffff800080003f30 x18: 0000000082000000
  x17: 0000000000000000 x16: ffff800080000000 x15: 00003d0900000000
  x14: 00000000000c3500 x13: 0000000000000000 x12: 0001f4e457e39c1c
  x11: ffff800082f06ca8 x10: ffff800080003f30 x9 : ffff80008002ebd8
  x8 : ffff800080003db8 x7 : 7fffffffffffffff x6 : 0000000006dd7418
  x5 : 0000000000000023 x4 : ffff800080003e88 x3 : ffff800080003fe0
  x2 : ffff80008002ebd8 x1 : 0000000000000000 x0 : ffff80008002ebd8
  Call trace:
   arch_stack_walk+0x1d0/0x350
   return_address+0x40/0x80
   trace_hardirqs_on+0x8c/0x190
   handle_softirqs+0xf0/0x400
  ---[ end trace 0000000000000000 ]---

Mark.

