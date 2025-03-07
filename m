Return-Path: <linux-kernel+bounces-550312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBB9A55DC3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6FB7A7EE4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6862A18BC26;
	Fri,  7 Mar 2025 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="YxFGu8BH"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B7E189B91
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315177; cv=none; b=F2qYVnAYp5c8cwTLZ5rr0VrQAIoWgJMrujGGK73mkN5YG3Xj9gC2iI0JUIfbwFIdNlkRVOwlgi3BLAcv9xCInwSrlF6hq7mWrDHUtTNYZkvnOppbppWXTqyUgZ1k1CBOnUm59vpJ+C400O6/t1MowWuAhkGAfOeLsa0JFVECcSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315177; c=relaxed/simple;
	bh=5GhOQEdryPt9BFVLFTj/gU8q0yWwu6xiBflwBtD1jyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ7EpU3frH5itnNC/e2SXoKJKMXBYRduPaprHBuYFEHgRpkA3CABPots17l1g/YELluG4CSBBR6EPomD+q9ybtmJnRtHUBihgfdhEMBa8fze0TaIlc/DBhzsjQ1gBUL3sviRDW5L9ecPa6Rktf85//fGia3ijT9cEqfPpBpqyxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=YxFGu8BH; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=93IFiULzvSt6qMHavOvaFYPNKhhnDXBb0AUZKSuA94g=; b=YxFGu8BHHn6/ZFoIqMnTWnty7i
	FhUmEhAht/0Pr26JuaZTRIwlknlACjoH6UjcHjvbIYeL6ztLRG129qBiqfdpNDIQ9gacHvQr/t6Yj
	JDeKE0PNrRNLRDyiGwLMfS3FlguTxIWb+gsOp57JkjPcQ2IR3HvxJ/FOaL0ypQHwLGTHc2aeki2EB
	FRydBLY5s4A+iqtBL/f7wylYPZDf/sGjaYxwcEfaA+UfP6706o4T+CRJIKziVGtGZWw0CbfBGLT+g
	gntR4ZAtuyPPxNNFpXFtbnofc6W16qKZiFM3HvNGmswY3XJVnz3vcTiBfMsae9hK3IUMMSQ/9LlpR
	ckMwBQAg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tqNc1-004TwD-3A;
	Fri, 07 Mar 2025 10:38:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 07 Mar 2025 10:38:57 +0800
Date: Fri, 7 Mar 2025 10:38:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 3/5] mm: zpool: Remove object mapping APIs
Message-ID: <Z8pcQdB4HA9ulyE9@gondor.apana.org.au>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-4-yosry.ahmed@linux.dev>
 <Z8j_Ct0hTwAnd2-w@gondor.apana.org.au>
 <Z8kiRym1hS9fB2mE@gondor.apana.org.au>
 <Z8nTa1yut6I0RS0a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8nTa1yut6I0RS0a@google.com>

On Thu, Mar 06, 2025 at 04:55:07PM +0000, Yosry Ahmed wrote:
>
> The zswap and zsmalloc look good and the code is simpler. I am fine with
> this approach if Sergey is fine with it, although I wonder if we should
> update Sergey's patches in mm-unstable do this directly. Currently we
> are switching from mapping APIs to read/write APIs, and then quickly to
> the pinning APIs. The history will be confusing.
> 
> Sergey, do you prefer if we keep things as-is, or if you update your
> series to incorporate Herbert's changes for zsmalloc/zram, then I can
> update my series to incorporate the changes in zswap?
> 
> We can also combine the series into a single updated one with
> zsmalloc/zram/zswap changes.
> 
> Let me know what you prefer.

This patch is only illustrating what zswap would look like once we
move to an SG-based interface.  So I'm not actually submitting it
for inclusion at this time.

Sergey has volunteed to add parameter support to acomp.  Let's
wait for that before making these changes to zsmalloc/zswap.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

