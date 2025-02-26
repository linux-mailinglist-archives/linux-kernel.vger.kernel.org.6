Return-Path: <linux-kernel+bounces-532885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8962AA45359
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE78C164B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B3821C9E8;
	Wed, 26 Feb 2025 02:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QzYFiPnY"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000E18C03D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538021; cv=none; b=EY7fQz8ds0ejcNuym9c3a+MTWReH9z292M2y/qsH2ZFNbxH+wQMqhECzxdMo7YS/NVtAOV2GRtQ2Vx6t3DT53fL/zyQD6TOCY7srfoWd8Qn6OfZbsKcHELKIIhwMzmQECaGs9FZ16vXOTPLwH/tMehhSAddtqY0qT5sPPDQzsmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538021; c=relaxed/simple;
	bh=Ztaw/4iKvi4PfNHCK3e+9IS8E/GsOpzkRTl/ZUe1gZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAbQulbIKCLafRqzviPbBMMNcJlDFraSnHBATyqhpkfDuGQ6TTiE/YKsxFQ1S2BkbsaDkj5EvjnEjpNZQx8U6J0fIlJyQD2rqIFZjZIRIH+YIwX5ayv+yrcYpnHwmLfG9WZfLyLxvcLlwrwIf+skezYhbSAWPXmVBIMxrjud8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QzYFiPnY; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 02:46:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740538018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PNQREzBUoxFxQC1/e8FKtyGb+Q7/bb7nwwjKa99py3U=;
	b=QzYFiPnYne0hV2XOpE1d7tPmtG1cJziA1H08fMY70Pz58C0xPOCeYla7VgDTnkrOOGymDf
	hc3iZysvaUwRGDfWRzwfDDHBhq2GuQhiY6ZLvA3FWvmUlcvMdpNDcz8VZtHMMw4H11CgmF
	5ae30sMl1UdWTExtrUhTmd9NDui1nJ0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: syzbot <syzbot+1a517ccfcbc6a7ab0f82@syzkaller.appspotmail.com>,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: mm: zswap: fix crypto_free_acomp deadlock in zswap_cpu_comp_dead
Message-ID: <Z76AnbQVZybcAi3g@google.com>
References: <67bcea51.050a0220.bbfd1.0096.GAE@google.com>
 <Z72FJnbA39zWh4zS@gondor.apana.org.au>
 <3482501981b13aedda3c1c6b54d83d496bd05922@linux.dev>
 <Z75tg3wXoDnGtLis@gondor.apana.org.au>
 <Z753jsValuBdcvnv@google.com>
 <Z754DloF4TpoRr7P@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z754DloF4TpoRr7P@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 26, 2025 at 10:10:22AM +0800, Herbert Xu wrote:
> On Wed, Feb 26, 2025 at 02:08:14AM +0000, Yosry Ahmed wrote:
> >
> > Could you please:
> > 
> > (1) Explain the exact scenario in the commit log, I did not understand
> > it at first, only after looking at the syzbot dashboard for a while (and
> > I am not sure how long this persists).
> > 
> > (2) Move all the freeing operations outside the mutex? Right now
> > crypto_free_acomp() was the problematic call but it could be 
> > acomp_request_free() next.
> > 
> > Something like:
> 
> Looks good to me.  Feel free to send this patch since it is your
> system after all :)

Can do :) May I add your Co-developed-by and Signed-off-by since this
would be based off your patch?

