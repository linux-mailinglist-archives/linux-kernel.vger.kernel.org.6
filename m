Return-Path: <linux-kernel+bounces-267914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B89941B45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602902826CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E78189903;
	Tue, 30 Jul 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jjKXsW7s"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4911B189502
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358372; cv=none; b=MZEnSB699Xqjs1oS8OmHsxGujgdV+QxJuT/xn2r7OTK1KA23/cvrLnctjPwcYy7i2fpxlfxzmHAnI7tVAUIgtID8VYRlw4myRNIuM/AR58xeyvRNEekacEo6z5oBcItIKUeR7W9H5EMCWMF4DnBykiEY8lnh6dSi5zQuMBcaSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358372; c=relaxed/simple;
	bh=TehCO6G3NPKwIsnaiRX5ZLITMc67uRfDAWuQytzPkGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0UpOf+M1uERjim0nwkTq4S+89IVsEEokFj02NMF0RtGxCnN/ihuGls5CvDBVpefC2txIkO9yeI+d/mWFjPHeyF1tzOXdhlypECj7Hir5FEgTNactsLmTf7Q8HXyiFexOoCymU1CarUVVwWxau+kyyI/iZmJtzp1VQWBaIZh0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jjKXsW7s; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-83172682ab3so1180991241.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1722358370; x=1722963170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7KQVeJhA8Nc1kr8jYgp61vZfNk5AG6Jp03s6AWyvfdM=;
        b=jjKXsW7sXtoDmwGhf1Qnci431qaUuQEAsXwBMqHqupN01FAY/321TFfEdqu/FgVZ8L
         rEhXvvBlwWnOqG6mx/kZIdQSHetHHY67XNBF7Tf288HeYrxpUtBWn8R+MsGG+EXIahRT
         dLcEYU95DZDvTkhxrNBY4zmkdifJvn7oXrx4a/1pCvnb8r3eFUI94/MCOn8SFNr/b/zB
         JnBSYHFoRtMAHJEBJ3HjR2OEA+OoyEnOERUmfltT1nB1NlMr0sC4d5j+JqUVEUcuQbqg
         a0Uxewp6TNDuRajr75sAHHYTmOC9MGzCPWTQgnfYcTP45spfbEfkk6Do1qu9jdyoRy7f
         aWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722358370; x=1722963170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KQVeJhA8Nc1kr8jYgp61vZfNk5AG6Jp03s6AWyvfdM=;
        b=lalv+re0PtM+DiDAfLunYxp8bFqAu0AsHDES5b2HnGYIcpHxKVElXOunCvNn3ngBVi
         V94DEfx/Bj4XvpUdSAW8/nk/kh0DBQ0atMncXiI2/v5bUCDA3pm+TMvd9UHFQ3JLj/kN
         N1MnHToRBZ8/iHRDLUQM6xpB8stizVNlxDOIBT+YRDJio+7jaJSZAcq6QDprb2lyiYxJ
         Oae/yZ4D8Gb/7U6mDqmsGoT+J7TH3cZBaeGkw+wCyPrNh/b3G+rfHss0tVIc/xmyA6Q7
         nmjdScWqpUXtzSIOWxTZKXCl269fcnQLPVk385HCXQcyGD9bXOiBYbk9jIgAy6cU31an
         jGGg==
X-Forwarded-Encrypted: i=1; AJvYcCViIYnnagYeREZDFQ4QB4MfYn9hl+k9CW06nLLNh6P8p8PVDM8SR53gBy1qobcPsShU+t2HfVbTvWDu3vwkkVjbfKEHq+zgqpCMm0Ln
X-Gm-Message-State: AOJu0Yyz26/W96Zmz6Wu6WJ26DsA8iSaDQZzyiaVvUwuEIFruTQKPEYo
	5G9SLzuBXonfOsEdmCSLCp1Tka5cKSma9kYcFAZzxuZP8wANM2chQ/dQ7h/vg6U=
X-Google-Smtp-Source: AGHT+IG3kXzdFLdaIqxcSYNO6QXWKyhicCB56NAmLiiFCX5C4mUyPUoLIOyykWtzvpmjpM43ScoJaw==
X-Received: by 2002:a05:6102:548b:b0:493:bbd7:3ec0 with SMTP id ada2fe7eead31-493fad0d470mr9105172137.23.1722358370045;
        Tue, 30 Jul 2024 09:52:50 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b8837sm657515485a.48.2024.07.30.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:52:49 -0700 (PDT)
Date: Tue, 30 Jul 2024 02:12:27 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com, horenchuang@bytedance.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	dan.j.williams@intel.com, lenb@kernel.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] acpi/hmat,mm/memtier: always register hmat adist
 calculation callback
Message-ID: <ZqiES1T6PTQHD2Bl@PC2K9PVX.TheFacebook.com>
References: <20240726215548.10653-1-gourry@gourry.net>
 <87ttg91046.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZqelvPwM2MIG26wY@PC2K9PVX.TheFacebook.com>
 <877cd3u1go.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zqh3-TWBkhyY5kPw@PC2K9PVX.TheFacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqh3-TWBkhyY5kPw@PC2K9PVX.TheFacebook.com>

On Tue, Jul 30, 2024 at 01:19:53AM -0400, Gregory Price wrote:
> On Tue, Jul 30, 2024 at 09:12:55AM +0800, Huang, Ying wrote:
> > > Right now HMAT appears to be used prescriptively, this despite the fact
> > > that there was a clear intent to separate CPU-nodes and non-CPU-nodes in
> > > the memory-tier code. So this patch simply realizes this intent when the
> > > hints are not very reasonable.
> > 
> > If HMAT isn't available, it's hard to put memory devices to
> > appropriate memory tiers without other information.  In commit
> > 992bf77591cb ("mm/demotion: add support for explicit memory tiers"),
> > Aneesh pointed out that it doesn't work for his system to put
> > non-CPU-nodes in lower tier.
> > 
> 
> Per Aneesh in 992bf77591cb - The code explicitly states the intent is
> to put non-CPU-nodes in a lower tier by default.
> 
> 
>     The current implementation puts all nodes with CPU into the highest
>     tier, and builds the tier hierarchy by establishing the per-node
>     demotion targets based on the distances between nodes.
> 
> This is accurate for the current code
> 
> 
>     The current tier initialization code always initializes each
>     memory-only NUMA node into a lower tier.
> 
> This is *broken* for the currently upstream code.
> 
> This appears to be the result of the hmat adistance callback introduction
> (though it may have been broken before that).
> 
> ~Gregory

Digging into the history further for the sake of completeness

6c542ab ("mm/demotion: build demotion targets based on ...")

    mm/demotion: build demotion targets based on explicit memory tiers

    This patch switch the demotion target building logic to use memory
    tiers instead of NUMA distance.  All N_MEMORY NUMA nodes will be placed
    in the default memory tier and additional memory tiers will be added by
    drivers like dax kmem.

The decision made in this patch breaks memory-tiers.c for all BIOS
configured CXL devices that generate a DRAM node during early boot,
but for which HMAT is absent or otherwise broken - the new HMAT code
addresses the situation for when HMAT is present.

Hardware supporting this style of configuration has been around for at
least a few years now. I think we should at the very least consider adding
an option to restore this (!N_CPU)=Lower Tier behavior - if not
defaulting to the behavior when HMAT data is not present.

~Gregory

