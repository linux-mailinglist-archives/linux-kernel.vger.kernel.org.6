Return-Path: <linux-kernel+bounces-353468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D2992E40
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED7C5B23FC5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3701D61A2;
	Mon,  7 Oct 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VQ8UDpC5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hWXyg4nP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574501D5CFE
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309880; cv=none; b=eIFmX4cUSDvF9WTMunxYkQAWmF1+N+YG/JwYgiSJbk79T//eOilWl9CdkxhTT3imV1Ay+LooEyR3/pUztGRLkN1Y4mMywPu0K34BFq7jSqWmFM1cZRce2osffD82xLWD2xpO7mJ3NBfoVXno8A25RRu4nRvY5Vb5/BzpPuK5PT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309880; c=relaxed/simple;
	bh=rmKw6LLj7jBKDgXm1hLLZ95lIGmeEqWZHnhflQSsGRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PxTZ1zY14M9S/3qiukblSizG8JLEUk6yxlRsUf7gOstUJ/DENhQqnjjON9gXKWLHjQi0mjVcIPqvG+Q3lRMpUCQ0UfF/1YZ0GJtZJQjNjnTZvjJ4epFN1YJjjVXuqhW8eNKjaa3MD1KuuOzhs4klT4vmT2OU/sgVX/URIXo7v98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VQ8UDpC5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hWXyg4nP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728309877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=apQjRdzZUuzHhphPj0jRLtCbKIqrTzCZuqN8LSFSIIg=;
	b=VQ8UDpC5ZqjkH1Wcrqj6FRCYtGBmEH/VQzrfijCibVVfRGufHjav9ilHmG08TJFudA+Dse
	5+iB86APX7TbyE1twkxSp6X0StS9g9lPp9PBwUPGPwqdz5MLNRd0KfIq9uG5B0yg2Ejeod
	x5U1/8IxEbD4OEiGxVUmFH+saQ7jClYatR+wi1H21Lj8iV2rXHmL4HwyMI5pjNDeo/J4uo
	44hi+cCbnV+QD2lSIz+9neCD4O37L5DttifD9So3+rJy7ufwhyKRyNZs7nudyvFYa60A9/
	IE1YB/0gpog9FChrjSuLFET5RVCLt9tIqTes1OSJyHJ+FjckK5SCepwkVZR5jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728309877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=apQjRdzZUuzHhphPj0jRLtCbKIqrTzCZuqN8LSFSIIg=;
	b=hWXyg4nPhXOApLmoijKuBAlUDBljMU35BdNCjWuALxWoDBcJXh8F6Fj15bJ5M1pNFK049i
	CZd2mzatMjIdQwBA==
To: Zhen Lei <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v3 3/3] debugobjects: Reduce contention on pool lock in
 fill_pool()
In-Reply-To: <20240911083521.2257-4-thunder.leizhen@huawei.com>
References: <20240911083521.2257-1-thunder.leizhen@huawei.com>
 <20240911083521.2257-4-thunder.leizhen@huawei.com>
Date: Mon, 07 Oct 2024 16:04:37 +0200
Message-ID: <87r08st3ey.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 11 2024 at 16:35, Zhen Lei wrote:
> +	/*
> +	 * Avoid allocation and lock contention when another CPU is already
> +	 * in the allocation path.
> +	 */
> +	if (atomic_read(&cpus_allocating))
> +		return;

Hmm. I really don't want to rely on a single CPU doing allocations in
case that the pool level reached a critical state. That CPU might be
scheduled out and all others are consuming objects up to the point where
the pool becomes empty.

Let me integrate this into the series I'm going to post soon.

Thanks,

        tglx

