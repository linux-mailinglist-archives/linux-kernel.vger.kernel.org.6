Return-Path: <linux-kernel+bounces-209598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6110990382F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E2D1F233DD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B671779BD;
	Tue, 11 Jun 2024 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dx9x+I2d"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198C16F900
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718099610; cv=none; b=WI9KCqfbIwr3hBI8s2TgfCL3JnslTS9r3KXKAFjlcUlQXaXpiN9aRrOsdOIRvDOGYEDuSI3MuglbxZ34NPp/q83fTe4LUMaksgSnBBdvFgX+4YHmclAFK5qc6rSnhmfg5eFqafz8CK2LhZWNaByzShf2lKjubb4Vz6tAMpt//I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718099610; c=relaxed/simple;
	bh=hR6p4+dSS3cxtO0luCHlTXEIhaPWgeI8DfCZAZXynYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mghvPT695cVezF/98+2QxUzxtavWx9DcpXhBgqsXdbNsO6k/DOLbN8emNFEaj6cqZM+XJKoGFplwt2T0uI1DCg2dejV+J2p4L9wzDq+iPjF0O+SA35n94H6qytIFCMeUps1FjxhHMLsedlKQ+oLHHP8C4j2hP+MJmI8ep7JSW6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dx9x+I2d; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: usamaarif642@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718099601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZME8sShk2kQ0RQHoagPPnoqrAeCpuE0ELxkCzr8HcM=;
	b=Dx9x+I2dMTfsmx7Y5v0uA4z1QMT9EX39/98SVtUgORIbsv9LcWYlMYxd9rAQQHU0VRtZk4
	tGEFSZeStmTm9ozA0tUzxCnuP0tADDb709AHv8WduazDjKJELn3BvYhVNHwmt4sT00z3rc
	Ur2l1rnuvnrJ2PjfDJOlPb86Ciug4Lw=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-team@meta.com
Message-ID: <5d051998-015c-4da4-83f0-1b4fb9009c68@linux.dev>
Date: Tue, 11 Jun 2024 17:53:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: Do not start/end writeback for pages stored in zswap
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, hannes@cmpxchg.org, yosryahmed@google.com,
 nphamcs@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20240610143037.812955-1-usamaarif642@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240610143037.812955-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/10 22:30, Usama Arif wrote:
> start/end writeback combination incorrectly increments NR_WRITTEN
> counter, eventhough the pages aren't written to disk. Pages successfully
> stored in zswap should just unlock folio and return from writepage.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Looks good to me, thanks.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>  mm/page_io.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a360857cf75d..501784d79977 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -196,9 +196,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>  		return ret;
>  	}
>  	if (zswap_store(folio)) {
> -		folio_start_writeback(folio);
>  		folio_unlock(folio);
> -		folio_end_writeback(folio);
>  		return 0;
>  	}
>  	if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio))) {

