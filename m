Return-Path: <linux-kernel+bounces-197568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834238D6C90
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 00:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39541C26EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F055824A7;
	Fri, 31 May 2024 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uXJnOGHf"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9C382482
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717195364; cv=none; b=cXtUHclQfX5ckUwTKI1ddmOvqm2dUdrqjN8EWxoSjPVYmwDTe2iw7V3CzE+itt3Ea/CSqWVshaQxXRurb02mWfPTpvT32uuk8Kc4FlPkER9p97WnsiLGCX7m+gQ1PB4pHCKOh8+aANnuA5smCOuJKATkdF05I7pDun2TvsYtxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717195364; c=relaxed/simple;
	bh=LTbTrJRXsqD4HbCJs7pMX0aPhVw4BfgOdoQ/+xKr3uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir41kwer57hbJlzPhwHoeb0PRg390/NL1YY43wQbGWTpx/4vqvY216jOnKs6nJus+QVv3fiqUUvAlX7zii+8rcAwJ39cZ/VWNK+M8Ybfy5UftuUQ3BJtZLUEswzFJdtSVfQliuZOGQMlva3kVQXlhJOP5Xu/RJBwyV07hO+KUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uXJnOGHf; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: pasha.tatashin@soleen.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717195359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42+HF/lg9ToKNNAC62AfkBIUQjk90D8+CQb9koVMHSI=;
	b=uXJnOGHfEcr/IzgwqNuLMQ9RuiVUlcjbw0n6WpFsotQ58wpKM2VSlFd0g9fwiv/B6KPRp1
	z5sNHTaRLEEkPq5hXfCmhvv44aayNUl/0d2rAxHswuUNfT66p9ec9GjXvdYaJVhAm5+iPW
	ixfX+ufyX+pMi/goMtSMLuynQ9ZhPU0=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: jpoimboe@kernel.org
X-Envelope-To: kent.overstreet@linux.dev
X-Envelope-To: peterz@infradead.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: cerasuolodomenico@gmail.com
X-Envelope-To: surenb@google.com
X-Envelope-To: lizhijian@fujitsu.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: ziy@nvidia.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
Date: Fri, 31 May 2024 15:42:34 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, 
	kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com, 
	cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, 
	vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] vmstat: Kernel stack usage histogram
Message-ID: <i66bzhgnbql7bvuteqttpijml3ze3nngxapv32k7paqv25c5th@wd37oaastkvz>
References: <20240530170259.852088-1-pasha.tatashin@soleen.com>
 <cq7537bswpnbsmeiw3rh4ffrgqky4iufsaurukpk2flxts6jcu@6ctttkclvf3f>
 <CA+CK2bCuiDAv05Xu6OuKB=gqJ5NM20F_uUyJV8E=XH=r47ik=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCuiDAv05Xu6OuKB=gqJ5NM20F_uUyJV8E=XH=r47ik=Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 30, 2024 at 08:14:17PM GMT, Pasha Tatashin wrote:
> Hi Shakeel,
> 
> > Couple of questions:
> >
> > 1. In future with your on-demand kstack allocation feature, will these
> > metrics still be useful? (I think so but I want to know your take)
> 
> It depends on how on-demand allocation is implemented. On hardware
> that supports faults on kernel stacks,

Which hardware supports faults on kernel stacks and which do not?

> we will have other metrics that
> show the total number of pages allocated for stacks.

Don't we already have a metric for that i.e. KernelStack in meminfo
which is in kB unit?

One more question: Is there any concern in making
CONFIG_DEBUG_STACK_USAGE not a debug feature i.e. enable in default
kernels instead of just debug kernels?

thanks,
Shakeel


