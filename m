Return-Path: <linux-kernel+bounces-436106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98739E8132
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9AC188218A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2706E1494DC;
	Sat,  7 Dec 2024 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vx/sykzz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9238B2E628
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591674; cv=none; b=SwOeOIcLcLK5aGu0DEpt07Vyx89wDrX9jDc/OPAUJ71NINwBs02Au0wBBu8J/W0jIQbLliguCklFmw/QS5parcGPx/YeIriYHXL0pEoKCCbhHebXImrqi3U6tMQm92qTitAMyHDrxbT+7x8vvDaRvboQDDiKtJVHbweZCAQ77Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591674; c=relaxed/simple;
	bh=3D65gVaO6r+7/u6tHQvEuqMx7QBtYqKRRCUT4yM+8Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXrH5nt/S8NymsMU9zsfxesng0NECxTv+j/qDfsZtBaPqDHPYjv3kkGCFUlH0V/xje+84zUGvz+LU9t5Eo3B+8ZF2AHVhCqGERM0x5eP/0/xzgEyGDNGDZh6qZrApUXpJeowUObK5Z9yKxgUpAYfKKhTdmVKgMQxX3di7hFxpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vx/sykzz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+m8LqA+l0VP1e4fQDn1Gn3p69MDF3GIuUMy0vbg9kcg=; b=vx/sykzzxk4L7k9Kk8E4O3I1xK
	bXUlbhB/mVrdDuCMgXaYxCplWZWLPbpnvhYpQLOXshJzJb2DWjwdUn/OF5nxIMBVvR/P7+vf9roRF
	k6ZpuQsFb7xw3hC1xOsn2DY+4g7u24SU2Y/NUdj/MyFxNpvLhMDgzCRhza6jmEp9F5E1Djv/qE5IL
	U89GMDdlS0SGe3ELeFiSeR01Iy8Tn5sm/e2rxGrU9zQ2D1b5ZnrheMsEy9CLzWun6JIlWv4ShVq4r
	bSuhw7+RbNwchu7PqXsALkPlFVkxwwoLbpem/hSrgc+3HiZmVWbP7lqu3LUVs99BJ0CThSRZhf/vl
	zb3js1NA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJyNi-0000000GIgZ-3RBZ;
	Sat, 07 Dec 2024 17:14:14 +0000
Date: Sat, 7 Dec 2024 17:14:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Junjie Fu <fujunjie1@qq.com>
Cc: akpm@linux-foundation.org, gourry@gourry.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com
Subject: Re: [PATCH] mm/mempolicy.c: include pagemap.h directly
Message-ID: <Z1SCZlMcjBCzHOxf@casper.infradead.org>
References: <20241206220037.5c0cd212d3269dd8a6f36e4d@linux-foundation.org>
 <tencent_38F9530F8D11EC9B038B77AE97E73145DA07@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_38F9530F8D11EC9B038B77AE97E73145DA07@qq.com>

On Sat, Dec 07, 2024 at 04:14:30PM +0800, Junjie Fu wrote:
> @@ -113,7 +113,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/tlb.h>
>  #include <linux/uaccess.h>
> -
> +#include <linux/pagemap.h>
>  #include "internal.h"

This is in the wrong place.  The linux/ includes go before the asm/
includes.  I like to stick to alphabetical order within that divide,
but other people have other preferences.

