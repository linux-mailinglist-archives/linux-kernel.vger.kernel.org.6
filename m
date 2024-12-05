Return-Path: <linux-kernel+bounces-433739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747309E5C68
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5A61880685
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AF4218ABD;
	Thu,  5 Dec 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dKoqPgxn"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA72199920
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418027; cv=none; b=ZqJxwR3/S8gJnGlLeZbaYoRJXEW7YYFoiX4WySTV+J1OEXZJCvNQvc5Bn7OVyIO51I8eQ4D2037UYaoTipE0YBMimNtJBBNpQVN0NVg8orHMHESSn1sgNuTSjo1F0xHeo1yyH9/+Ih7Y4IcCXQqHbcOBMa0SONYK2h/HER/x4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418027; c=relaxed/simple;
	bh=3B6C0eFOg5HAsggqTDObwAiBKwnnSYNFhvqufOhKhfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbbykOuMNTgru6eJF+JCspyMjXgzo+ZBusIW7OZR3PY32kS/SltFMwi8PGueIefhg3Y56EZTH34irHYRPOFf1uQQyCKH23PFgbVtSfoSdKcmHGJiltqRjM4PV1ylRySkd3NQsH6zidkSKjYBoWs8icDer/thuItwYikW+adsCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dKoqPgxn; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 5 Dec 2024 09:00:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733418015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mO0UIbfAAT857srzsQRM1yeqtHRA0tGKkLFerm/srE8=;
	b=dKoqPgxnaKlyoLuWp3m1SRi9EaOCUIvyw9inFhbiAMknHVGSODxiv4kUMrxbpzv6bvFh7v
	ZaeV5AFQOJ5uBlnC7hVNG4QSWRtE/1cCJocWPVbbEffi6kcPizbCm1YW2p9cR0an5fGGLJ
	giBKNdYwa64aSuOfnavG/St+pDto6W4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm: shmem: fix ShmemHugePages at swapout
Message-ID: <33cp6mak3viari6dkmq52htfulpagzhct4mn533nhghstny2gj@yfdax7oitydw>
References: <5ba477c8-a569-70b5-923e-09ab221af45b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba477c8-a569-70b5-923e-09ab221af45b@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 04, 2024 at 10:50:06PM -0800, Hugh Dickins wrote:
> /proc/meminfo ShmemHugePages has been showing overlarge amounts (more
> than Shmem) after swapping out THPs: we forgot to update NR_SHMEM_THPS.
> 
> Add shmem_update_stats(), to avoid repetition, and risk of making that
> mistake again: the call from shmem_delete_from_page_cache() is the bugfix;
> the call from shmem_replace_folio() is reassuring, but not really a bugfix
> (replace corrects misplaced swapin readahead, but huge swapin readahead
> would be a mistake).
> 
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

