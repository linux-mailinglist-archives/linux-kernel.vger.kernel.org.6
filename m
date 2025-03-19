Return-Path: <linux-kernel+bounces-567446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66B9A6861C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D921B624AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68941250C17;
	Wed, 19 Mar 2025 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mSterZZf"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA76250C0C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370300; cv=none; b=XgrXJ0YPn3Nh/SYawNzBJrdf887jqe4L5ZeMkl89bFCnBBUOKwzcwsr4vSBK1DrC/1RBm0RDBfEYzVYNu+8nVxHuDWtreyO2J011kbbjYjMWEE54KOmU/Xc92FY21uwvTIkxbd1lxW+K28gOqY0UWHkaZlD0AqlAJmpLZI25Y4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370300; c=relaxed/simple;
	bh=HFUwn0Mp6/yF1JDqO9zVJkGqqBWsO2pGeuIVBIryGNA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=t9eAcfUs0BVGa7yMysXj9J5dSdpaLJ/3/Pz3T0cQ7n55MmgnHAEefldGGwQHH4EWGkrYu9fDGO7h6KxakzXBCKW4Eu9nxBjfZUftdrBBDuoqj7hhbbo17wuzKD+M0fQgXurEN/aA2JyA66cEsUvj5jiTGQKyjPUK2fAQ40p8S0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mSterZZf; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742370295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H//bt2Ql4jLgPp9BR9F6R2R/qCJ1uZlIgPQbHzz7ooY=;
	b=mSterZZfaAVR04cVNnqvxJMdvCXEUjRgS/DEUsRPeF10brF26Wdj45K363o/vqqd/ujMCr
	7f/b++gTwpAfBerrmGkaIy/TBpeaZXov4iSQvSFCcADdbjqF0gKaj9ZWzpBcW8DWDA6f+r
	tFVsZUfN78owQxqzHTr82xnVa1V7vBA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] mm/hugetlb: move hugetlb_sysctl_init() to the __init
 section
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20250319060041.2737320-1-marc.herbert@linux.intel.com>
Date: Wed, 19 Mar 2025 15:44:15 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2870C104-2F76-4B3A-A4CF-35D6F3C7ACF9@linux.dev>
References: <20250319060041.2737320-1-marc.herbert@linux.intel.com>
To: marc.herbert@linux.intel.com
X-Migadu-Flow: FLOW_OUT



> On Mar 19, 2025, at 14:00, marc.herbert@linux.intel.com wrote:
> 
> From: Marc Herbert <Marc.Herbert@linux.intel.com>
> 
> hugetlb_sysctl_init() is only invoked once by an __init function and is
> merely a wrapper around another __init function so there is not reason
> to keep it.
> 
> Fixes the following warning when toning down some GCC inline options:
> 
> WARNING: modpost: vmlinux: section mismatch in reference:
>   hugetlb_sysctl_init+0x1b (section: .text) ->
>     __register_sysctl_init (section: .init.text)
> 
> Signed-off-by: Marc Herbert <Marc.Herbert@linux.intel.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


