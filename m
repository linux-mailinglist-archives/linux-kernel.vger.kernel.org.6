Return-Path: <linux-kernel+bounces-276784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC78949851
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4BB1F2182C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8942146A6F;
	Tue,  6 Aug 2024 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sV9CG21T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F81C32
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972735; cv=none; b=qL9QBRDPwp27fqrJF/8PMVnYcVXRgXo/pZDWHsCVyRFUSyhnLO2gxwR35i8zS/J4OW1opXoLGxFqUcg1j6SOJ4lPdZaRfq/TQKODCjElMkpUHE+wtK9OA9jtUBixd97tog6s4Nkw3ysRiD+GBwDcW/EakqqC4dwLtxZIvOap3YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972735; c=relaxed/simple;
	bh=iDJ0kMO8qxRUISw+966I+wYuPEfne9SVL08eirb/gjU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Mz5LCbSTIYYtUJdSTX2/Jy56ytAx/gImBZksW6QJWKyHKVl1gFuoUgBAyXqZUKrp0NypydyA+JpfTW6pogBmadiY3NF6coODMddGlYU7VLUu9a7tL5hwI24yYMbRxd6EakDcANPg8kmAfmu21vgH+T2cJT/gGc29DSPterppgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sV9CG21T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538B0C32786;
	Tue,  6 Aug 2024 19:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722972734;
	bh=iDJ0kMO8qxRUISw+966I+wYuPEfne9SVL08eirb/gjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sV9CG21TxpfrA2WYV2qr+2qfYRoB3TNlX0SbxGRiUkMHj3bnwOPup9Eqmuso4689f
	 Trxdsk5ZSKmBnLgnc0znnNOHl9IXHH0osAWaf7iK3ulwyMYJRPqzsyJMuTiptNOGIC
	 r5+HdbQavinCRPe3vkvX4aammllr+rXNU5mGKrDU=
Date: Tue, 6 Aug 2024 12:32:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin
 <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 minchan@kernel.org, willy@infradead.org, senozhatsky@chromium.org,
 david@redhat.com, 42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
 nphamcs@gmail.com
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-Id: <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
In-Reply-To: <20240806022311.3924442-1-alexs@kernel.org>
References: <20240806022143.3924396-1-alexs@kernel.org>
	<20240806022311.3924442-1-alexs@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Aug 2024 10:22:47 +0800 alexs@kernel.org wrote:

> According to Metthew's plan, the page descriptor will be replace by a 8
> bytes mem_desc on destination purpose.
> https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org/
> 
> Here is a implement on zsmalloc to replace page descriptor by 'zpdesc',
> which is still overlay on struct page now. but it's a step move forward
> above destination.

So the sole reason for this work is as a part of the mem_desc
conversion.  I'd like to hear from others who are to be involved in
that conversion, please - it this patchset something we should be
merging?


