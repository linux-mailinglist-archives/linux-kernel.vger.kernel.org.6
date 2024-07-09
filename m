Return-Path: <linux-kernel+bounces-246700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D2A92C545
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED1AB2288E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D749E18561D;
	Tue,  9 Jul 2024 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MsStrag/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D80180056
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560194; cv=none; b=XaJSl4FdI8MM7we+WrQOA69RaedQKp3kTt7v6AEqg+h0jviY2SL0/aHSlugNYYCB7Ne6pVLgGXW5v+RNE8o1/f8j9qPgba+8imltjIGKvCU/6/IFI27LT1oPxQNAtlPhXN0+TLkAsE2jm0nAgjtib5eiuqapdgIhwAzt36lPCu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560194; c=relaxed/simple;
	bh=VRFCCGEOkSVu6wLAu6Ukd1lXb0ZA3XKDLl/lMCkSGCE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ePsug0ppH11DGnTfvAWHpEXyG9yzf56krtbDq+8p9lIZLey3fOL5BIluowmgAzwW2+QNjLUzX39gGVQ4rJskt6sen1nHvMjGYFjValg/d+A1H7tNZiMfvmmh/BWhj6AhjrlXt/+bdrmyp5kcIXW595az+0AJJNy07Sfd4XYLFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MsStrag/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FC7C3277B;
	Tue,  9 Jul 2024 21:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720560193;
	bh=VRFCCGEOkSVu6wLAu6Ukd1lXb0ZA3XKDLl/lMCkSGCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MsStrag/Ajc65Th9HXLsDg+uhDu3qo+pKmZ4dLLOtAEeq1NZtbvQ6vNv7udgGXdeC
	 8i2PJGsA2SNmGvoI7OMtQTX1X/dN1L04/oMcBhATrDMyPkFaK+t1pzqwW5pTvf/XAI
	 hVKiC5/DWor86Ukctgptd6dh2plnEWXuVA8XikuI=
Date: Tue, 9 Jul 2024 14:23:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Barry Song
 <baohua@kernel.org>, David Hildenbrand <david@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, opensource.kernel@vivo.com
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
Message-Id: <20240709142312.372b20d49c6a97ecd2cd9904@linux-foundation.org>
In-Reply-To: <20240709123115.117-1-justinjiang@vivo.com>
References: <20240709123115.117-1-justinjiang@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jul 2024 20:31:15 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:

> The releasing process of the non-shared anonymous folio mapped solely by
> an exiting process may go through two flows: 1) the anonymous folio is
> firstly is swaped-out into swapspace and transformed into a swp_entry
> in shrink_folio_list; 2) then the swp_entry is released in the process
> exiting flow. This will result in the high cpu load of releasing a
> non-shared anonymous folio mapped solely by an exiting process.
> 
> When the low system memory and the exiting process exist at the same
> time, it will be likely to happen, because the non-shared anonymous
> folio mapped solely by an exiting process may be reclaimed by
> shrink_folio_list.
> 
> This patch is that shrink skips the non-shared anonymous folio solely
> mapped by an exting process and this folio is only released directly in
> the process exiting flow, which will save swap-out time and alleviate
> the load of the process exiting. 

It would be helpful to provide some before-and-after runtime
measurements, please.  It's a performance optimization so please let's
see what effect it has.

