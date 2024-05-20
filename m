Return-Path: <linux-kernel+bounces-183364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C916F8C9802
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832AA281376
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A046B666;
	Mon, 20 May 2024 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P+5+G8A6"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B9829A0
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716173139; cv=none; b=A8XVsbgVvBVVjPX4xHh1u+2ElLiufuqqKI8xKxvHnKeihdJB38CayBfHyqNnBgrY/cajAr4x3EqPm/DshNirfnfu/CDXODET+06kY+88rag0ZcCXS1FJra16Nzu6r29Y0aWF4cgD9Z7GPllyiCccag1D8i//yea0XJN9HzD2dNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716173139; c=relaxed/simple;
	bh=oR+HWfEbsdoLhwxeid1Mkiujk6fyUB9heA/7roG4ASU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KZvSm9HJXt3CAUdDsW+NFAe5/OijuTdpbYvwNDKNHm+AaBNVPls1qJDxRMcVAToETR6bFl+bcwjVs7xeccZKiYacZblw1E4D301usD5TKDj/Us5lTMLB7g7IRLtVWZml0EZ/o9ai3JLXnTeHto4ejjJJtO0ueM/wGAZ11iY8o5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P+5+G8A6; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: osalvador@suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716173134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Psj+gplghZTZV5P82hYySm+e+s2MwlhNyb4BPI/726U=;
	b=P+5+G8A6X+e54JR1eYsYT+6Aklv6iIWuzBmXUh14NpbfpPtPXiWWDT5UxscDHTwLEnEtTH
	DdVefn0R5YzlubFqEo5nzmffRd9pYlZAsQ1t3LTnFgWbBTnotw2nNEDtxihO2hQwKfY+jX
	p+ZK60SyFm3ygswrLakw0zaL0o7lVNE=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: peterx@redhat.com
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] mm/hugetlb: Drop node_alloc_noretry from
 alloc_fresh_hugetlb_folio
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240516081035.5651-1-osalvador@suse.de>
Date: Mon, 20 May 2024 10:45:14 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 Peter Xu <peterx@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <5FF6FF52-4798-4496-A8CB-25AC6EF5768F@linux.dev>
References: <20240516081035.5651-1-osalvador@suse.de>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On May 16, 2024, at 16:10, Oscar Salvador <osalvador@suse.de> wrote:
> 
> Since commit d67e32f26713 ("hugetlb: restructure pool allocations"),
> the parameter node_alloc_noretry from alloc_fresh_hugetlb_folio()
> is not used, so drop it.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


