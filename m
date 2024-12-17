Return-Path: <linux-kernel+bounces-449131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E049F4A51
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E36D97A5808
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CF01EF0BE;
	Tue, 17 Dec 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HKFedOop"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0271EC01F;
	Tue, 17 Dec 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436252; cv=none; b=ERARDJB9CP2yqmUKhqEsD5ljKuzZU1fr5j86+V66SUlyvoqvjKjkW0mO07XGpJ9i7Gie8XqB/f7nQVXhb15PUGz+WylhpA+A6dMjzbAP/k44M1sNSZmSU29zbboCdorvIDwSopD0ZoLu7imZjBuxirfFrsXp8BPQVE9czFPwkUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436252; c=relaxed/simple;
	bh=ViqCOSoR/5Oc43ls7HezXtbZDLOSU5TXHvdzQkiSbkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USaj1ag+kxsuZenwQLsACedkMytLBm2+reNVvIwbZJilHKQO2UrZdnVHAkMmkipHwc51BB/p9Exmh6r3BeBACaWXnrL3wLLgYkYXgRnBxK0TyyTNufb+M7O4lwuIZCItCuPezVzPisuWPSDn3dDPJsmIZz0UXGT8aojuWIrxnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HKFedOop; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=01JtgBOhDZPiaKNzWOsr8GiiDOYISUrtTSVb4wXML7s=; b=HKFedOopoXyWWMfVIGmf9A5iuG
	YIY6DShf7sgODfmUh5u2yM3+Sf743/L/BMhz0l+JlLoCANLME4dt57NjPKqPRh/DjhN6GyRKkeOSO
	uVYoS7LnzBNp2DlhWl9z0h9q7jY/nibW3oYgH2RRMHF6Fmw9/yCV5go6SRd089pBF87tK6e5rivmS
	KWSCgCsJpB0crtQOR5HvUmX2zbiipIybkyS2NaMAzjWZL3KOkp3sCZZX2fT88HEcM0mUdukL+rbTt
	8EDOuVTZbTlYdr16j+gKXXLf7b39SurhI+9ZmHFWlJRizSrhxbXowA156iDJqZhZEQ9CSMgbwG3dC
	CP28oslA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNW64-000000054SO-1y0Z;
	Tue, 17 Dec 2024 11:50:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0DCF730015F; Tue, 17 Dec 2024 12:50:40 +0100 (CET)
Date: Tue, 17 Dec 2024 12:50:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Brendan Jackman <jackmanb@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Add force_cpu_bug= cmdline param
Message-ID: <20241217115039.GF11133@noisy.programming.kicks-ass.net>
References: <20241119-force-cpu-bug-v1-1-2aa31c6c1ccf@google.com>
 <20241216171700.GIZ2BgjPerQ8jQlq8S@fat_crate.local>
 <CA+i-1C1HeLfbGg=LdXBYuhXWVPn1O0qtEYxFRYaXPUch4goEtA@mail.gmail.com>
 <20241217111752.GDZ2Fd4E4XX-w_t6eq@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217111752.GDZ2Fd4E4XX-w_t6eq@fat_crate.local>

On Tue, Dec 17, 2024 at 12:17:52PM +0100, Borislav Petkov wrote:
> On Mon, Dec 16, 2024 at 06:58:24PM +0100, Brendan Jackman wrote:
> > OK yeah, tainting definitely makes sense, I think that goes quite a
> > long way to avoid bogus bug reports?
> 
> It was my feeble attempt back then to leave enough breadcrumbs so that when
> I see a bug report, I can say: "well, then don't do that then" and mark it as
> invalid. :)
> 
> > I will also update the docs to sound scarier.
> 
> Right.

Perhaps issue a pr_warn() for every bit set? People tend to not like
WARN/ERR in their production logs much :-)

> > So do you think we should allow setting arbitrary cpu features? That
> > seems like a much bigger footgun. But then again, the difference
> > between "big footgun" and "very big footgun" is not that important,
> > either way it needs to be clear to users that this is a scary red
> > button.
> 
> Yeah, with your patch we're half-way there. Might as well do the whole thing
> but again, this is only my opinion. Probably should hear what others have to
> say first...

Given I'm the one that did the retbleed=force thing (and other force
options), I'm in favour.

