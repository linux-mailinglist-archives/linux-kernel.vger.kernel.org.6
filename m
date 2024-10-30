Return-Path: <linux-kernel+bounces-388956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3929B6694
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6211F21CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562261F4715;
	Wed, 30 Oct 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rNKB143K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sXqooMKj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA026AD4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300121; cv=none; b=ZF+tEO7s6B2In+t1fYLfaF6BMwun8x/yNhpYIrFOoBlVwpYQMOTv2++7QYsbOlisDZyldjl8rpfjSkKFRKeAtvbAGwF0hqjiJ21gH4kRD8RwmpbkFVJIcFtJnQzIXZXzmYwJdzQPz4PEIDR3ky/PUFKEnE7+4iBzKWSsW6VZTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300121; c=relaxed/simple;
	bh=rvbANe/r+eXmbd7CzxAwq0f0wIEd9y/PrSElKUtq688=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HI+Mgfht/TyJSizglZJUoaMx8DIQX/qWRWw12V4EgvrE3CZ0O+aqQOtSOVpH/7PSJHZxHOHyxQDHGPR/h1K4aZ3EImUepYWrPfa9dYsV71DxkZKdVvzKAuXIMhPO0yvv85XyaPZj48Yk+iJGpA73G/QLK9bTYrDV46BEUZoknsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rNKB143K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sXqooMKj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730300117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMLlcuyrBExBFQ7cARmq4EKvLPPMbZK83A9cofBFpAU=;
	b=rNKB143K8Ctczk3QICRDrjfntQZPdO2TZ1f0bQAU/xyc6baIqN5IkK9Z1iloHVIxUm4eL1
	DTVv8Fa2zQg7+4CZn8EqI2YxizzNT94IXwGJldgfESCpFi6tePC7ZXoOvt4WTbdXbhNgsq
	1sT6qx//LyoEXjk+Aun+OKMoPlBU4KnBmGMKRt4xsjZgQAyu/XFDtMSRHOd40hHQX9Fo2n
	4/W7322h5dgZu3XjP0zpmdf4ZW0uFTLVzALlgwMozRxJJo5igweVCQUhEX2JHXJ6Rz8QLP
	2fsyjfqPZS9d4ZOG8O6oLnV0CtqmcDSqZcWxXIHUaPt9YqxHPn4NTUd8w/mAQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730300117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMLlcuyrBExBFQ7cARmq4EKvLPPMbZK83A9cofBFpAU=;
	b=sXqooMKj4WSJGhKapgzAlZ6y8k02GuQUsISSgkOq1Val6CrIZxncFkQriu8lZfjdEsOgzR
	Xb0yWorE+ouD/cDA==
To: Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, peterz@infradead.org,
 mpe@ellerman.id.au, linux-arm-kernel@lists.infradead.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 pierre.gondois@arm.com, dietmar.eggemann@arm.com
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, morten.rasmussen@arm.com, msuchanek@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org,
 jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
 linuxarm@huawei.com, yangyicong@hisilicon.com, xuwei5@huawei.com,
 guohanjun@huawei.com
Subject: Re: [PATCH v7 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
In-Reply-To: <20241030125415.18994-2-yangyicong@huawei.com>
References: <20241030125415.18994-1-yangyicong@huawei.com>
 <20241030125415.18994-2-yangyicong@huawei.com>
Date: Wed, 30 Oct 2024 15:55:17 +0100
Message-ID: <87ttcty71m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 30 2024 at 20:54, Yicong Yang wrote:
>  
> +#ifndef topology_is_primary_thread
> +#define topology_is_primary_thread topology_is_primary_thread

Please do not glue defines and functions together w/o a newline in between.

> +static inline bool topology_is_primary_thread(unsigned int cpu)
> +{
> +	/*
> +	 * On SMT hotplug the primary thread of the SMT won't be disabled.
> +	 * Architectures do have a special primary thread (e.g. x86) need
> +	 * to override this function. Otherwise just make the first thread
> +	 * in the SMT as the primary thread.
> +	 */
> +	return cpu == cpumask_first(topology_sibling_cpumask(cpu));

How is that supposed to work? Assume both siblings are offline, then the
sibling mask is empty and you can't boot the CPU anymore.

Thanks,

        tglx

