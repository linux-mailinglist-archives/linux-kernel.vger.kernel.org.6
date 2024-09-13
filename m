Return-Path: <linux-kernel+bounces-328526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025CA97853E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC4F1C21C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730DB6F2EE;
	Fri, 13 Sep 2024 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j99Yhnar"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF466F2E0
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242983; cv=none; b=N24qzcGKlkg7gn4QElKoNS4McbRF7ZbNMAf8AdvR6mbQ5iF9/YXwoIqyeQl/NqMQXO+wzzERnVQ0mz6axuMV1toWfw0xUaKfdiWPLMPGBOxekU9LwdoLmeQBElqTKraUKSLDeNEoAxCkKY/V3deWTL6kWa/qtyYnaQSMdVYVlq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242983; c=relaxed/simple;
	bh=WOkoTc6WEzPhjgHjKFlm89/8ERCjvcO8ZeagptYZsq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W19bb4juvxRemBdHD99ePEVZVwCIRsiSG6RfXFR9i97HPUFZ2DS6EpqD76rWvqeKCEY6z1uddfKzBgvqqhfsXCsnvIVCkj1H3voZnP0yCdmCoeAEepaWdQhO5uVJo5KI+SzHclSEDyRfVWJgKc8EnQ1NB/mdmDQvT2qYuqXpeTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j99Yhnar; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 13 Sep 2024 08:56:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726242978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wah4p3gvhgUCBudKAMcB3hAx1R1SiWh66AoeZN7Xngw=;
	b=j99YhnarlC7YHmBn0n5mq1XTU82wB2olLXFKc9ki8hQ2BYfEd2EMNJJmALCzJlS/81KuEn
	S0PJIIA0yj7nDxxv4HUMJ6ptCNCWAEg/WS7aOwELMpG4Xy4xXZui2Lqiyg+bbhK83kzZFW
	vMbEct/4D1TpRfpbVBT+celTym4GKWE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Liam Howlett <liam.howlett@oracle.com>, Shakeel Butt <shakeelb@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm/madvise: process_madvise() drop capability check if
 same mm
Message-ID: <d7jobrgasskf4j6mst3amazyon5g473hhrmbrie7ki7xoy5mca@qsdpnk2qracx>
References: <20240913140628.77047-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913140628.77047-1-lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 13, 2024 at 03:06:28PM GMT, Lorenzo Stoakes wrote:
> In commit 96cfe2c0fd23 ("mm/madvise: replace ptrace attach requirement for
> process_madvise") process_madvise() was updated to require the caller to
> possess the CAP_SYS_NICE capability to perform the operation, in addition
> to a check against PTRACE_MODE_READ performed by mm_access().
> 
> The mm_access() function explicitly checks to see if the address space of
> the process being referenced is the current one, in which case no check is
> performed.
> 
> We, however, do not do this when checking the CAP_SYS_NICE capability. This
> means that we insist on the caller possessing this capability in order to
> perform madvise() operations on its own address space, which seems
> nonsensical.
> 
> Simply add a check to allow for an invocation of this function with pidfd
> set to the current process without elevation.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

