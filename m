Return-Path: <linux-kernel+bounces-522160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9928DA3C6D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628113A2E73
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539271FECAE;
	Wed, 19 Feb 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nM5pqWGn"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA01F61C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987799; cv=none; b=ZQzI3QPPR72VOEs/SnKgD+dX1A+vrOtN7slL/wFa85kLBgNribOrS6x982EDAWSQyd132mkgA33HOf1c1hutei9PpTdIeKOHQmJgAWbdaPkandiEKIgSThInMNjEC0SO10voYu2Anzdc/y2OblUJm6bmORwMNm0ntPe9xZMh7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987799; c=relaxed/simple;
	bh=25LBDrXUY1k92K3ZALiwN85ZcrOPTqA9yDwmxWp3oWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JygKts9x0WGIF7L3W2HNL/G7OASer85/B/AuRBDI6vafcf1YfONXEZ9+9Lsij/BCpYLSKlkvheJFjfl2DPnMdx7A2Onx7mp8JNjkqHQGxvz3Y2xpEY8I74WiP+5vXc5va1Ia+VH4TMG/LWmpG5hqgTa3ElForUTHlxyjG9qxDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nM5pqWGn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2uzJ3jVYwcSiVFdHn+2OB1N57+isTXYABrRMjX113PE=; b=nM5pqWGnx1czbAFIugT4ZJf49p
	jPlWysUcyupngzYDsdvxx75wNtZIF2EhqA34vyVUwUBZxsQi6cNT+X0e89kyxvb+62iAzK+LZrQhw
	pqeVovcGCPSw7FcvxJQ155XZoSw7GZDSgyiBNP2Q8bWcK8roR4nkLu3DUmGZvfers4eTzvHfS5tP/
	9chuvRYIJ5XXkq8Xp9cUvZWIHuyw6NWmB40WY8A8IPZb0gm11CDLByE0xWF2dZwdTsvy61/GOYo+i
	k+Pg+mqxNtl/sPMyewNtW891IiYS2gm9JJNQpawO/CcJj6tEVXyENGvgCKItfS7JXoqWO9+Q4HvR2
	YGRDIrHQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkoJD-00000002IXK-0rkx;
	Wed, 19 Feb 2025 17:56:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2F6E1300783; Wed, 19 Feb 2025 18:56:30 +0100 (CET)
Date: Wed, 19 Feb 2025 18:56:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 01/10] x86/cfi: Add warn option
Message-ID: <20250219175630.GA23004@noisy.programming.kicks-ass.net>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.364049576@infradead.org>
 <202502190941.CA60135@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502190941.CA60135@keescook>

On Wed, Feb 19, 2025 at 09:50:54AM -0800, Kees Cook wrote:
> On Wed, Feb 19, 2025 at 05:21:08PM +0100, Peter Zijlstra wrote:
> > Rebuilding with CFI_PERMISSIVE toggled is such a pain, esp. since
> > clang is so slow.
> 
> This seems too complex; report_cfi_failure() already has the fail/warn
> logic test. I would have expected cfi_warn to take CONFIG_CFI_PERMISSIVE
> as a default instead, like:
> 
> +bool cfi_warn __ro_after_init = IS_ENABLED(CONFIG_CFI_PERMISSIVE);

In kernel/cfi.c, yes that works.

I somehow got stuck with having cfi_warn in arch/x86 and then not being
able to use it in generic code. Been too busy to debug all the fun fails
to realize I could simply stick the variable in generic code.

