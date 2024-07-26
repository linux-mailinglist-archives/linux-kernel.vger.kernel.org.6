Return-Path: <linux-kernel+bounces-262957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6D493CF0F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63BA282A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06C178CC8;
	Fri, 26 Jul 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XNW3Tzgj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5717625C;
	Fri, 26 Jul 2024 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980146; cv=none; b=Xzs9mG+UWZvuSG41uENCY6Qhj1MXA3S2GCWNqi5oVlBrJwx5ObAs2pwxE5wS61+BOy0hsJAlOzT1AoOodOEXbmw0G86q50YCS/YdBWJBrG2ZK2s2tYfHs4lyWGJIw9Re2nLylOcx4fSNOHr8r0yGEVexxyYj31DE1hOwZMWadxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980146; c=relaxed/simple;
	bh=3/xlK+MDuuXcM29JL1BSwi8O9iw8VaAS3ThguDSBFyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAXu9Ug+hYa6hERLliHP+5yohzJIptXRVdz2FSATnFePRypuezm9kCI0lZn+syCu1k2DGEL+IfFZlg2CnZJk6qjaeQhnuySPMIYuaWFdZlzTOpPBX/zGp6qSThbOdBrLyKmxdAw4ejPZ/VhLPWTdkoTlji5qM/W6cm/5am+8fco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XNW3Tzgj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3/xlK+MDuuXcM29JL1BSwi8O9iw8VaAS3ThguDSBFyU=; b=XNW3TzgjeyYb/S7ecNzDiGyUgH
	hmFBNNkPkWE4PJgoc7uxsLUdjGVHjr1Im6gAxdt5QfdKMTUY1ppyQuK2/wXSjMNX+RgojxKEQmdBB
	qQfA5f2hZS1C6M8/hMr609eDqlCKPFB3tt/K/WjU0VSMfeYTp4yhlB/pBgXJaHdlhd+SD2Z1d0pc5
	YyBCvlsxDyjREhbGapZsVp5D6mpOMl8VoZ/V6+Vk6QQ7rbtr6Hbge8+4DwzSgRseXyTHNPRQ+tukK
	Qb3dFAqf2DNWhVIc/WFrR32NP7e3dZEfZqfSIDo6L1Mn1Z/ml8WKZSRqFktjsvi+0Uw+xUUgF/lH4
	yDLaUB2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXFh0-00000009wS0-3RIj;
	Fri, 26 Jul 2024 07:48:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A94DB30068B; Fri, 26 Jul 2024 09:48:45 +0200 (CEST)
Date: Fri, 26 Jul 2024 09:48:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: sync: Add IrqSpinLock
Message-ID: <20240726074845.GM13387@noisy.programming.kicks-ass.net>
References: <20240725222822.1784931-1-lyude@redhat.com>
 <20240725222822.1784931-4-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725222822.1784931-4-lyude@redhat.com>

On Thu, Jul 25, 2024 at 06:27:52PM -0400, Lyude Paul wrote:
> A variant of SpinLock that is expected to be used in noirq contexts, and
> thus requires that the user provide an kernel::irq::IrqDisabled to prove
> they are in such a context upon lock acquisition. This is the rust
> equivalent of spin_lock_irqsave()/spin_lock_irqrestore().

So aside from the horrendous camel-case thing, why are you naming this
thing the wrong way around? Shouldn't it be SpinLockIrq rather than
IrqSpinLock? Or possibly even SpinLockIrqSave?

Randomly changing the names of things isn't going to make it any easier
for people to use this stuff.

