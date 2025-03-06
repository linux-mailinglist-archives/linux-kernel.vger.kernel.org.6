Return-Path: <linux-kernel+bounces-548113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3A5A54022
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74EC3AA09F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386BB186287;
	Thu,  6 Mar 2025 01:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="UZcK1kch"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A6EEA9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 01:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741225770; cv=none; b=eNN4HGZIswesvGxbREbTB3pRMLwzwjOdNWO29RKzFwBxhyNLkh4OMTB6ksh7S2GKUgYwrrYM2kp/VGW4lQ5sVo6JMMIai0gQ7mNhS7EHg3109tLKgx25IY2jR2d587/5YvbkW5OzZCdWK0OlTkQPnQiYGIw4tZvPeybOUy1PKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741225770; c=relaxed/simple;
	bh=4CnsPaTl0WIRzszl0f0cpVVeSGyBM4NDYeiErRoiIkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dowxyG/3Hp3jGEwfpddP7pFlkNw4uv1HM4neCUpuTFssBPXTqU6+5O4y+rKN7lMvxyejOFxXwTkE+52Fznbm1SB7kePos/ARixTe2QjWkr5ChXWfydOb/CkBdma2r5GeiFF5JhIEKRTaSgOmeCEvJ2rf5A+QvYoR8JhqI6Xa1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=UZcK1kch; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QGHyxqVCGkNrl7QPpS/xhP2GAEWWzYY4bM8dIlqPpgA=; b=UZcK1kchFYH6J+A93W4k6rnhLt
	LH65Pm9XuzMFGE77kgMkmuXXQnRCBKnKpaBXl0OlMM5snP6cK9PBnuLiHWeOgTjPlB5mXZTszIHRx
	bKIt0xNbCOl++pIoBNRhTzgw34VXtlkZ0Jygkq0crc1CRbuYMUilCzVe5AYkzGoj2SOj5VA/3b5p9
	U/O78Kc9IqgI0NQ/dkMJusqR+qTBh1Nmo0qtEiPZ4snLD92I1lIndbYNt52dTW+h0tQgYcrHtokCW
	BS5KDkoBDq0ULvu7FGy33Ux5cI9t/1NGgF211OPRfHsK8U9Zitku3y3MlX8zlGvsIDSoa1McmVVEf
	SczVM9ow==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tq0M6-0049Wr-0P;
	Thu, 06 Mar 2025 09:48:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 06 Mar 2025 09:48:58 +0800
Date: Thu, 6 Mar 2025 09:48:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 3/5] mm: zpool: Remove object mapping APIs
Message-ID: <Z8j_Ct0hTwAnd2-w@gondor.apana.org.au>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-4-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305061134.4105762-4-yosry.ahmed@linux.dev>

On Wed, Mar 05, 2025 at 06:11:31AM +0000, Yosry Ahmed wrote:
> zpool_map_handle(), zpool_unmap_handle(), and zpool_can_sleep_mapped()
> are no longer used. Remove them with the underlying driver callbacks.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  include/linux/zpool.h | 30 ---------------------
>  mm/zpool.c            | 61 -------------------------------------------
>  mm/zsmalloc.c         | 27 -------------------
>  3 files changed, 118 deletions(-)

This patch breaks zbud and z3fold because they haven't been converted
to the new interface.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

