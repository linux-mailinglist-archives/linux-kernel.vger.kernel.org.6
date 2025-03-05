Return-Path: <linux-kernel+bounces-547270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606E4A50547
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11273AE412
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0624C1A317E;
	Wed,  5 Mar 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pK8En/2L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zayYXsPb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA8B1A316B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192701; cv=none; b=oTEi7DCad8HI1ufL0jtkYRLikU6mZdeiL5o+lQVsV4oL+SV2EK05mhGzCMNi2GJEXV+ka3ffdDw6opV0CeJeuhfswVTA1ROHYJBEJ3OaGw7lpQGLAHUI8YxiSLcaKzX38fEKb/ZFfeXPjWP+fCcXtNzNJzm6XzEQ5CufnIRz+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192701; c=relaxed/simple;
	bh=P+Oz+AvMPkh6w/QVnXxfpyC3ogF/KVO7v15m92vsUoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFkC7YNKQaqQjnwr6Y9pELBgTaSRywCtfms/pCljy9etlodB8oJtnc8cvezi6aBECAxPZImAzo2KfnKEVKASpyGWMFJfuGs2JJGqizddZnhN/s97G6u6Zy9jbomZq5tM0t4M86seLAxK6p/fGGV4fuZxb9XLEjJNhwzZsWccBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pK8En/2L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zayYXsPb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 17:38:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741192697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+Oz+AvMPkh6w/QVnXxfpyC3ogF/KVO7v15m92vsUoE=;
	b=pK8En/2LGW3yM8H8cHvpyWQDveQav9xLX0CuZ1E3OB4NH1EsSZmcvBaYi20puTs99JusgF
	pmoLuV56jo9FDqDB8wNwEUmDIgrz5xUqMgQ/54HTxEVuCA+5nw2y0bmaIzt0UASitk+rU2
	mv86Px2UzSJM89cGSoeJb+2vHg3PFKoTBP7IalLmM6vh1QG98KPqpwWPzFj5cT+rjCXUcN
	bnWqoT4DDeDAspocEvi3+4QlHByiZi/X2D0TPlfPUkfdugEefD2woH/vA+mEGvoKzPdpTi
	xqRL0G8f2vDQRDeFSu66wzz13gNTq1qPo2iwaen76cpkZmJFooTPkZFPaKbbMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741192697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+Oz+AvMPkh6w/QVnXxfpyC3ogF/KVO7v15m92vsUoE=;
	b=zayYXsPbNzFQlFhr6IssATiufwGEcI039xkoUnFQz+GFyqd8kAWTOdz3FUemAkZs5iPYLE
	euTNaRpcAJ9uAzBw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 00/40] x86: Leaf 0x2 and leaf 0x4 refactorings
Message-ID: <Z8h9-MuhYUBgtrgM@lx-t490>
References: <20250304085152.51092-1-darwi@linutronix.de>
 <Z8bI1JwDDI3JhpxP@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8bI1JwDDI3JhpxP@gmail.com>

On Tue, 04 Mar 2025, Ingo Molnar wrote:
...
>
> Please capitalize acronyms and names consistently in titles, changelogs
> and comments alike:
...
> When referring to headers, please write out their canonical names where
> appropriate - for example:
>

Thanks, will do.

