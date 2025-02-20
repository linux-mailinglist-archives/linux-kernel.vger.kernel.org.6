Return-Path: <linux-kernel+bounces-523439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892CDA3D6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9DE18847BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E381EE035;
	Thu, 20 Feb 2025 10:33:26 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145F1D6199
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047605; cv=none; b=bjHCT0gUphp5REN/WrsI6fdPObhx3fCpbv638wheUbjrcra3308ysnd+BsZUBt10MagNfb3p9h19vZk/+6bSb5GDsmAB6LbLU2xuGG1InyolQ+yZK4nGgY51lvuXlGjs27zKMSgQbHq61QcMrn3mTq+FQMMmLynUT5DnirKlQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047605; c=relaxed/simple;
	bh=GVSeW4fkDKWRAkVHOnefisC0+w1diWMQGZ7EL1kD2bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOIVa8nN7+cV6U0ppxRTfLdiWgp44eLN0gstOCcYsaSRuA55cFFPc1wCr32fdohH8Go90xEJylWhxUOrHX4DCE4cOU3RBYm+6HUYNxbKbmI6FQKkccSS+0gfVJlSSxFu15KGPTNxPIdUZMFxFY3xLs57cwIHyzNCliYcsTQ73vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.172])
	by sina.com (10.185.250.24) with ESMTP
	id 67B704BE00007436; Thu, 20 Feb 2025 18:32:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 64076010748088
X-SMAIL-UIID: 6DA3C6523AD94F4E983067A69F19E86E-20250220-183232-1
From: Hillf Danton <hdanton@sina.com>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers over 90%
Date: Thu, 20 Feb 2025 18:32:22 +0800
Message-ID: <20250220103223.2360-1-hdanton@sina.com>
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 14:20:01 +0900 Byungchul Park <byungchul@sk.com>
> To check luf's stability, I ran a heavy LLM inference workload consuming
> 210GiB over 7 days on a machine with 140GiB memory, and decided it's
> stable enough.
> 
> I'm posting the latest version so that anyone can try luf mechanism if
> wanted by any chance.  However, I tagged RFC again because there are
> still issues that should be resolved to merge to mainline:
> 
>    1. Even though system wide total cpu time for TLB shootdown is
>       reduced over 95%, page allocation paths should take additional cpu
>       time shifted from page reclaim to perform TLB shootdown.
> 
>    2. We need luf debug feature to detect when luf goes wrong by any
>       chance.  I implemented just a draft version that checks the sanity
>       on mkwrite(), kmap(), and so on.  I need to gather better ideas
>       to improve the debug feature.
> 
> ---
> 
> Hi everyone,
> 
> While I'm working with a tiered memory system e.g. CXL memory, I have
> been facing migration overhead esp. tlb shootdown on promotion or
> demotion between different tiers.  Yeah..  most tlb shootdowns on
> migration through hinting fault can be avoided thanks to Huang Ying's
> work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> is inaccessible").
> 
> However, it's only for migration through hinting fault.  I thought it'd
> be much better if we have a general mechanism to reduce all the tlb
> numbers that we can apply to any unmap code, that we normally believe
> tlb flush should be followed.
> 
> I'm suggesting a new mechanism, LUF(Lazy Unmap Flush), that defers tlb
> flush until folios that have been unmapped and freed, eventually get
> allocated again.  It's safe for folios that had been mapped read-only
> and were unmapped, as long as the contents of the folios don't change
> while staying in pcp or buddy so we can still read the data through the
> stale tlb entries.
>
Given pcp or buddy, you are opening window for use after free which makes
no sense in 99% cases.

