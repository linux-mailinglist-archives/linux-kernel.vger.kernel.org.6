Return-Path: <linux-kernel+bounces-203331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FA68FD996
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C84C2B2468B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B0E15F3FB;
	Wed,  5 Jun 2024 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HUvp73ij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B730C15539D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717625145; cv=none; b=B8EB+sR9pOY53d0Sh2Ei4WKXjjZap5ZyNmQrB7MgcBjFLODlvfOL6Iyxmzfti2TMcs7xLHgZM4FeN9bFR+K0i6+Sv2L42lYNLmgG3V8l7AJDQF948U+U65AuPjJ/9TLskpejYBdx7FTNQpJSV0npizwp1OYmug67N3TqdUNYhi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717625145; c=relaxed/simple;
	bh=R3+HS5IAcTR42fptTxGAE8k7b69s+G5kxAPPVyzJJfg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PDg/XmC7MLDxP2Uu3khnABMu5RJ/xZb5ysdkgt41ySrYvoh+wH0R8boggEKiLU+eKVGUu9nhZaZ/iRp+N0cidQegweN5u8OgeECcIQee+ocQQCmBVbmu0BcHrfloYJp39o0yZCSp5KalskkwOYemaV3p9NSpGEB29/jpBz/SdCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HUvp73ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF83C2BD11;
	Wed,  5 Jun 2024 22:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717625145;
	bh=R3+HS5IAcTR42fptTxGAE8k7b69s+G5kxAPPVyzJJfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HUvp73ijpQYic3gRaURF4D3OSbULFRnhHTQh5Kic03/1ZO+YRcy/dsR5zGvdl0hPH
	 znrLxImKjFswYuAqJUYOCBDVBWcDUna+fcIbdRRe3TQSt469Z2xLrtt65RTvOVrth0
	 Gd+MaGyE61KwnWtvs7ClEhgwGfH73C8fUoBBK1k8=
Date: Wed, 5 Jun 2024 15:05:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Dan Williams
 <dan.j.williams@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] mm/page_table_check: Fix crash on ZONE_DEVICE
Message-Id: <20240605150543.87c81189fa7cb562e73fa0b8@linux-foundation.org>
In-Reply-To: <20240605212146.994486-1-peterx@redhat.com>
References: <20240605212146.994486-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jun 2024 17:21:46 -0400 Peter Xu <peterx@redhat.com> wrote:

> Not all pages may apply to pgtable check.  One example is ZONE_DEVICE
> pages: they map PFNs directly, and they don't allocate page_ext at all even
> if there's struct page around.  One may reference devm_memremap_pages().
> 
> When both ZONE_DEVICE and page-table-check enabled, then try to map some
> dax memories, one can trigger kernel bug constantly now when the kernel was
> trying to inject some pfn maps on the dax device:
> 
>  kernel BUG at mm/page_table_check.c:55!
> 
> While it's pretty legal to use set_pxx_at() for ZONE_DEVICE pages for page
> fault resolutions, skip all the checks if page_ext doesn't even exist in
> pgtable checker, which applies to ZONE_DEVICE but maybe more.

Do we have a Reported-by: for this one?

And a Fixes?  It looks like df4e817b7108?



