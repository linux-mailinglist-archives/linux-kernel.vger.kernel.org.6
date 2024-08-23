Return-Path: <linux-kernel+bounces-299125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B4295D06E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4921C2203A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79762188903;
	Fri, 23 Aug 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XURnp9Mk"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA51865F3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424722; cv=none; b=IBk5XN7KCzje5tIkPwB76dLlcAScS9D0BQ7NTTwO6KDmRiLYzrFeWvfLjLGSzamUHsE2GIHE4gA6LXDrHX9PucGcK57XAZAM/sf6AhUFTRKGiaBfn78CmBEfw3L05/8ney79hp2BPyFrzVn4EKWTmNkN/QwLfqe5SSs9CRL+nPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424722; c=relaxed/simple;
	bh=jBxJz9+YDXMC8ppQtIEHlqXpXj+BGCaWCPgK8rMC6mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0tedSwb1rcT9QhnBVrlc2sN0NUJg3d+u1v+xpEhIqhpOKLBrO4lAihKkFieomO30ZZYx88ax87YQEmbgDNNvrWIl2P8pvZd5PE8Yfzoj9dnHclP4W7JlK5qrszFZ/ZaERfwDLEKlmWbuJ4kA8ibeXkHclWqLS9rhjsiPxK1BmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XURnp9Mk; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 Aug 2024 10:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724424716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Nw0oeKC0c/lBdFIV3nEBnSjrIyK4atBlPc1mqLkoE8=;
	b=XURnp9MktKyMwmSb7xBxlZKY6HVgt7UImuZ0j3/GEMFhzalohhkPaVwqytnT1UQ4VuN/ui
	e+3GLnLQPDdHJbh2MiZvOzrinR1d+auuCaonhqYeCtQPx3eB6oVn4eqiDUrQDNLx0FcYZq
	402yC6RIidVYubJdphuFHYtGvPemyVs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] bcachefs: Remove the handling of bch2_trans_iter_exit()
 in __bch2_bkey_get_iter()
Message-ID: <dcutapnlzvglzlbta2tzcvch26g2nnptluykgz5gabcoolxywu@fwq3u7jzd3y2>
References: <20240823031955.202795-1-youling.tang@linux.dev>
 <f2uohiy7zaaiv33r7xhofaprv6tk5mumvzzf7plvagdtavrini@3orfgcehid7q>
 <f9f50184-364c-4082-bf19-ea953c3c1429@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f50184-364c-4082-bf19-ea953c3c1429@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 23, 2024 at 02:07:20PM GMT, Youling Tang wrote:
> On 23/08/2024 11:55, Kent Overstreet wrote:
> > On Fri, Aug 23, 2024 at 11:19:55AM GMT, Youling Tang wrote:
> > > From: Youling Tang <tangyouling@kylinos.cn>
> > > 
> > > - Reduces bkey_err() calls.
> > > - Avoid redundant calls to bch2_trans_iter_exit() in some functions.
> > no, a function that returns an error should clean up after itself
> Yes, functions should self-clean when they fail.
> 
> However, there are repeated calls to bch2_trans_iter_exit in
> some functions, take lookup_inode() as an example,
> 
> When bkey_err(k) returns a non-zero, call bch2_trans_iter_exit()
> once in bch2_bkey_get_iter(). It is then called again in
> lookup_inode() via 'goto err'. (We can correct it by simply changing
> it to 'return ret', but there are many similar cases.)

I'm aware, but I'm not looking to microoptimize at the expense of making
the code more fragile and less clear, especially right now when the
priority is stabilizing and fixing bugs.

If you were also doing performance testing and could show that it
makes a measurable difference I'd consider it. Did you even look at the
assembly output for any of these functions? CSE might be optimizing away
the redundant calls.

