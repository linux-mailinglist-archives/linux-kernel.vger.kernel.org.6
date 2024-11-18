Return-Path: <linux-kernel+bounces-412627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9B59D0B95
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4BBB2312C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7FC18C03E;
	Mon, 18 Nov 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jATJIly7"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41569188735;
	Mon, 18 Nov 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921943; cv=none; b=DIERAt3HvoMNWLN8UEkp5pl6p6AdPnJ7GiGTcRP+iRng7uaXlu0tUNiAVAgVHH0YUEHIucSo0F0QT7teYxyA6mATuWfAHKAN01Jk/Zg4BmKtFCVHBMAmDDEuxpf3OMAtCAxUWf34ArAWpKK4pgGeJho8YP+L4mgptFlgo4gEsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921943; c=relaxed/simple;
	bh=QZv9B88aiudPzp5KFIC/r8NmKWNQgmSFAM98pAwSItI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4Xt/uU7+/PHnyO/yx92MMA4IDYjsVIEIHXABfqGwm9kTAPAnOMkJc60vGikokJfltXjpETMzP4IsU8noSt8oQEVZAIb0L35CFnu7Wyme6pMJZztbqmkiKea1am23Ok5w40PhTZXOa/Z0R8NYevQZaexQsANXIpt5yE99YEJLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jATJIly7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QZv9B88aiudPzp5KFIC/r8NmKWNQgmSFAM98pAwSItI=; b=jATJIly71K9XLkVd42isb8BV28
	Z0Sh/qK1Z7BJtWHTOQuJXHH+Aom5xYqXR7OLOB7/P4bR6OYK3w5QX4o63cGvDgrqk073aLn67cQsW
	bjD8br0XSffBxCBn3WYcMacgCOZ9Se7QKExkYBIzNj4J26j/VYdWF0fKGDJv1MjAti4pnPfDXfeMf
	SINasJGzO/LFTzTUXQh7D+wLoKXxVGT25qOeb/srHkoBam2b/z4NfzLNPbmCBeLsCGLpbfKQ8llB6
	yhpAWkM4rmtb8c1e9tb7sx2qYwOR7RoSDsolvBI/sll0tIHtcVb/nylzONb4prHcMaJueai3/3Qhu
	pNBaYF6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tCy0U-00000000CxD-25nF;
	Mon, 18 Nov 2024 09:25:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 468F530049D; Mon, 18 Nov 2024 10:25:17 +0100 (CET)
Date: Mon, 18 Nov 2024 10:25:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: "Nysal Jan K.A." <nysal@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev@lists.ozlabs.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] sched/membarrier: Fix redundant load of
 membarrier_state
Message-ID: <20241118092517.GE39245@noisy.programming.kicks-ass.net>
References: <20241007053936.833392-1-nysal@linux.ibm.com>
 <20241029055133.121418-1-nysal@linux.ibm.com>
 <ZzsDEvJn-vauz9gE@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzsDEvJn-vauz9gE@tiehlicka>

On Mon, Nov 18, 2024 at 10:04:18AM +0100, Michal Hocko wrote:
> I do not see this patch staged in any tree (e.g. linux-next). Is this on
> its way to be merged?

I only now found it -- it doesn't look super urgent. I'll get it into a
git tree after -rc1.

