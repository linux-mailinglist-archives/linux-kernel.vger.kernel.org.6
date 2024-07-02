Return-Path: <linux-kernel+bounces-238387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E56D9249C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD361C22DDB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D313201273;
	Tue,  2 Jul 2024 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bcI9T0GY"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58085201265
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954794; cv=none; b=Z6URoQUCluRmsHQr2+iCsRWSEVqX09QkrIfvFNHVhz1V6C8ZxgLSIaYZKZdp+lp/mx34dmdpAWy7euGY/5BdrTCi03A9MB/0Eyk7P7wrOb0kjQb3764XfdATZCurI8HzavhIRGOB29m1JKoacM/KP7UJuQh0q8yhyYJLsizyyHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954794; c=relaxed/simple;
	bh=nfa+FhkQzr3AAZGuZ6ZrrRXiWMZ8ZsQAG/ezPBYGLSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c07x0oVpNGrIMEitgn0LJA1IvV2qpGb1I8u9mi+Zqj7I3FEwyKl55Pd7TvGjurs87lBAPTOU9xcyCDXLLVTNfDhXcQ2l5Xeh4lWI12WQcqrMYCWqC0q9xv3CyS1gLU82A2/aTc8vLDdBm5XRfIl3VDjCGAUv7kG0u7Nlcd/nXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bcI9T0GY; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719954789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TnOurbSGAywWjCC55R7y4gHWEoqmY93tzoWLEfbrmLc=;
	b=bcI9T0GY0ZpoohlzKj+D9VwwrP/xSgfqxn9zKjrSBMkLN3WtTibw4BqsvfHlN/m0Z2331i
	vqBepPYGbQWRuBJs7/+EA7Py2jAHLadSAA4H79mk0Gd3voxyFxrnV7AzXtWfKdqtLVR93i
	yrsadAIhJM+1X880KcU1N9k04KU08QM=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: rientjes@google.com
X-Envelope-To: cl@linux.com
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: keescook@chromium.org
X-Envelope-To: aliceryhl@google.com
X-Envelope-To: boqun.feng@gmail.com
X-Envelope-To: rust-for-linux@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: patches@lists.linux.dev
Date: Tue, 2 Jul 2024 21:13:02 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, David Rientjes <rientjes@google.com>,
	Christoph Lameter <cl@linux.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] mm, slab: extend kmalloc() alignment for non
 power-of-two sizes
Message-ID: <ZoRtXgf7g5TU6HSz@google.com>
References: <20240702155800.166503-2-vbabka@suse.cz>
 <ZoRVbdCxrBwmDF2s@google.com>
 <1ca7b081-c1f0-45a3-b901-39c503368f43@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca7b081-c1f0-45a3-b901-39c503368f43@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 02, 2024 at 10:25:44PM +0200, Vlastimil Babka wrote:
> On 7/2/24 9:30 PM, Roman Gushchin wrote:
> > On Tue, Jul 02, 2024 at 05:58:01PM +0200, Vlastimil Babka wrote:
> > Hello Vlastimil,
> > 
> > the idea and the implementation makes total sense to me.
> > 
> > Do you have an estimate for the memory overhead it will typically introduce?
> 
> There's no new overhead for the non-debug case as the layout already
> naturally has the same alignment as is now guaranteed. Debug has its own
> overhead so it's enabled only when needed, and this will not add much more.

Got it, but can you, please, add this note with some explanation why it's true
to the commit message? Because it's not obvious and the commit message makes
almost the opposite impression:
    Slab allocators have been guaranteeing natural alignment for
    power-of-two sizes <...>, while any other sizes are
    aligned only to ARCH_KMALLOC_MINALIGN bytes.

Should it be "guaranteed to be aligned" vs are actually aligned?

> 
> > I don't think it will be too large though and actually can be compensated
> > by potential performance gains due to a better memory alignment. What do you
> > think?
> 
> Yeah but again, the difference would be only in the debug case and
> performance gains there are not so interesting :)

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

