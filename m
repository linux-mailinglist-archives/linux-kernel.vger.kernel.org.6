Return-Path: <linux-kernel+bounces-215625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F9909526
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 03:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F216F1C2159D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64392F50;
	Sat, 15 Jun 2024 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GDHJsqqX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A65173
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718413568; cv=none; b=AGJOUNwA6xCDo3+LnexVwrzmlUKIGxrnNhu4a10LQX0V8vW8v9u/7bdWdr506GDneI0DfjAfNXcJ4UFRT43AQ6rM5f6ObHzKm9Ss3IG4Z9l/aJgoGTZrUHCH7x+ho1nC+8vXG3BsI5g+CDQgm7K09jxfMzBqWfiPYekbJdHpBEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718413568; c=relaxed/simple;
	bh=p6aOtYtkbORj0hMDbmAroxIU3spCCQRUJKAqIfMaykA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gtzFgjbQoHrEZmuT3QqOer+a7tMRBTwlg6e+aUEnhNLUsEoCHh1lbNcDmiP0+v+or3VU7Gox0hI7PFvXilqImu/UgkpYv9wkUgaOZIs7/40rMg2/GhDTnjcEFJBeYdHjzWoJbKH3uDCYBAlV79gJ+IsWLkuQrdI7PYTgwr0TELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GDHJsqqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E59C2BD10;
	Sat, 15 Jun 2024 01:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718413567;
	bh=p6aOtYtkbORj0hMDbmAroxIU3spCCQRUJKAqIfMaykA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GDHJsqqXC0SCtMdHFAy+v86br28YCKasbXSHTK8hMIvTU3opU7Ni1rqIAjj+qKfCC
	 xCatwH+3sGEuQjGF4IpQrUvZGHWgNFEhyHoE/t+mxaJFXXWDhNKpTCRDaTE478pvJ9
	 dNsflkm5sqt3iPbDuAwjQV3hgZ8T3V1MJiZEPV5k=
Date: Fri, 14 Jun 2024 18:06:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>,
 "Huang, Ying" <ying.huang@intel.com>, Kalesh Singh
 <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v2 0/2] mm: swap: mTHP swap allocator base on swap
 cluster order
Message-Id: <20240614180606.5f3b6f4a6cd515df30b7a0e4@linux-foundation.org>
In-Reply-To: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org>
References: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 16:48:06 -0700 Chris Li <chrisl@kernel.org> wrote:

> This is the short term solutiolns "swap cluster order" listed
> in my "Swap Abstraction" discussion slice 8 in the recent
> LSF/MM conference.
> 
> When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> orders" is introduced, it only allocates the mTHP swap entries
> from new empty cluster list.  It has a fragmentation issue
> reported by Barry.
> 
> https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com/
> 
> The mTHP allocation failure rate raises to almost 100% after a few
> hours in Barry's test run.
> 
> The reason is that all the empty cluster has been exhausted while
> there are planty of free swap entries to in the cluster that is
> not 100% free.
> 
> Remember the swap allocation order in the cluster.
> Keep track of the per order non full cluster list for later allocation.
> 
> This greatly improve the sucess rate of the mTHP swap allocation.
> 

I'm having trouble understanding the overall impact of this on users. 
We fail the mTHP swap allocation and fall back, but things continue to
operate OK?

> There is some test number in the V1 thread of this series:
> https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423b26@kernel.org

Well, please let's get the latest numbers into the latest patchset. 
Along with a higher-level (and quantitative) description of the user impact.

I'll add this into mm-unstable now for some exposure, but at this point
I'm not able to determine whether it should go in as a hotfix for
6.10-rcX.


