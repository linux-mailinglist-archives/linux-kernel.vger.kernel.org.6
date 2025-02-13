Return-Path: <linux-kernel+bounces-512716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093B2A33CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9583A188AB81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D27B212D7A;
	Thu, 13 Feb 2025 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T4a+xWHV"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FBE207E15
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443696; cv=none; b=K8ZE9au9KgP/I7uIdc4/fKht00FX4JFfYg/xr5yRk2dBmAFaEuv7mtmrrQ07WYUljYQ7N4oI180Jgw5MGzsoqak4vrcoCVPOFAw3xbWxZTtYDOvRLjSradrbNdjFzSvAJ0ZNdUOps1Ic0r2LrGXtu7ySEc2KCOKmeHo76liuX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443696; c=relaxed/simple;
	bh=z6ne5/xHHHBZbOAhfUfbX1Y+FbBvqX0EX1WhwQhJCEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMnTVsjt9EwWXGzkHFtdkB749Czapd88aneo+WANaRVeQOGv32FlsQGs8HimReE2s3v1zEvgfB21gQClPo6xpyU+8eCzz4Q0CJ0lRBUk+I2vZfFgZ6iHuxYp62JkLgC7Q/vhfLWHpxbDZBinrfEhk7ABS78N+RJebmEi7W9d0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T4a+xWHV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oZdD49nkQRr86UNXlDNl2BXueFlY2XCfgHfk71Jg188=; b=T4a+xWHVxnX1WvLh4W6hVwnc2Y
	DBMX1oKbqkelze4H22crSukMQAVl8d//MvkQaAjhM6p7zXpc+7MKHv/Vj6Z8TI/Hd+NMDWa2oA5cH
	sY1BsBOeURl3HOr/ZJPyfxDP6wWBCtMrVBrHzTZYzKfdLM5RX+OB5oxec1368gkvnAYnzuEvHiNVm
	++xgUPq9omM9GXU+GFqUONvZBft3/qlOYw5E64iZaM9SYf82dD5k/8ck1MSwm2MiNsI4fx4UbBxaU
	vzCtxZqUFB5dXB/zp8TzK2/YJhOVeQ9/FVCBc+FHp3Cg50lJvwh4g78yJQihdBnCax/5gWEOjoWiH
	I2SGGzXQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tiWlH-00000000xbR-2p2N;
	Thu, 13 Feb 2025 10:48:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1B7D3001AC; Thu, 13 Feb 2025 11:48:02 +0100 (CET)
Date: Thu, 13 Feb 2025 11:48:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 00/11] x86/ibt: FineIBT-BHI
Message-ID: <20250213104802.GE28068@noisy.programming.kicks-ass.net>
References: <20250207121529.222723073@infradead.org>
 <CABCJKudA8aUf=SDsVOOsWX_Cq6LAcioOjgtpv+uq+WGwJbxFPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKudA8aUf=SDsVOOsWX_Cq6LAcioOjgtpv+uq+WGwJbxFPA@mail.gmail.com>

On Mon, Feb 10, 2025 at 10:29:22AM -0800, Sami Tolvanen wrote:
> Hi Peter,
> 
> On Fri, Feb 7, 2025 at 4:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Hi!
> >
> > Respin of the FineIBT-BHI patches.
> >
> > Scott has managed to get LLVM bits merged:
> >
> >   https://github.com/llvm/llvm-project/commit/e223485c9b38a5579991b8cebb6a200153eee245
> >
> > Which prompted me to update these patches once again.
> >
> > They boot and build the next kernel on my ADL when booted with: cfi=fineibt+bhi
> >
> > Aside from the last two patches -- which implement the FineIBT-BHI scheme
> > proper -- I'm planning on getting these patches merged 'soon'.
> >
> > Scott, what those last two patches need, aside from a lot more testing, is a
> > coherent writeup of how the mitigation works and ideally also a few numbers
> > proving the performance gains are worth it.
> >
> > Last version at:
> >
> >   https://lore.kernel.org/all/20240927194856.096003183@infradead.org/T/#u
> >
> > Current patches:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/fineibt-bhi
> >
> > Patches apply on top of tip/master.
> 
> I gave this a spin with a ToT Clang; LKDTM 's CFI_FORWARD_PROTO test
> now traps in __bhi_args_1 as expected, and the changes look good to
> me. The is_endbr() clean-up also fixes the gendwarfksyms+ftrace build
> issue reported earlier. Feel free to add:
> 
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Thanks!

> One thing I realized is that CONFIG_CFI_PERMISSIVE doesn't actually do
> anything when FineIBT is used since we lose track of CFI trap
> locations. I'm not sure if that's worth fixing, but perhaps we could
> disable FineIBT when permissive mode is enabled to avoid confusion?

Hmm, yeah, that's one thing I keep forgetting about. Let me try and fix
it and see how ugly it gets before offering an opinion :-)

