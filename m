Return-Path: <linux-kernel+bounces-549636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80356A554C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 019CF7AB733
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0998B271803;
	Thu,  6 Mar 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KUyRHqeC"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5436269CF1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285188; cv=none; b=ou5LlU+wrDN1jLqbzNIE6vwo4rbbCmUudSAc5Q8IHc9z/na55aFwjti9/0r1YZsdpp/olg3LUCQxbVNQvAJu3dxV1lojejHChGO0l6IpYRcvqVRF7GPZEeBNKqJTD9j87a2/kSttRdbqoSpUgCQUcqQmtrmH6juS6oq0ZA4+LPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285188; c=relaxed/simple;
	bh=TqiZKDYRbvqiA+onzWKWde9aH/FtaKLM3ZFPhd2Xe3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LI+lamnMIhjzQDMPURzBv6MZ1ruLvweDwFI3fHaJ8mzJ2NZ3FVSjKmw92+seD4jL6QKptBMHmcv5B3QLv43MXAlWGy3ogAH5lSTalRX+hYQJTlV8fsFK93xyIlPdGIon09KljD7BcfgfCbHevDbF7gMldXUfsxSOi8Jdi7QoK1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KUyRHqeC; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-474f15a2087so4423691cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741285185; x=1741889985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcWUU1E6OiQ5QkC/8p7XoPGRHT862BXEOfHZQ44uF5Q=;
        b=KUyRHqeC5JaRGd1hQFjScxhlQnsZFtaFCPRUnv7cwHP0XiZb3Y8sbyuieVbUKI4i0D
         XTSovfMBDE5Pjt66dyxwNl3iatlF27QuPMG7EVDqN3Q9qvmdWHaQYdgJgiDqIbzvBoxx
         Z8tYGuZI1F155rpM908pByOUb2Wn+pc9Ahum5wCUOwBVnRQnPpeD+frZbJMMXCkLOu9W
         clzpGI/5PAdsgm+24kdVW7G+iAhc6Bx8vU+Id2z92vw0EsZpIJnFcNHwlwqE3dv284br
         5f7GcGvJ8SNdn1jKPic22a7Y2QkMRfpeAKerpA6MMlA0Qes3fTWRwDrcPRrbeJMDBc8p
         cfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741285185; x=1741889985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcWUU1E6OiQ5QkC/8p7XoPGRHT862BXEOfHZQ44uF5Q=;
        b=E5dztinhW5WxDDQGhJTQsNTQf5uFIG984PB6ZwuYT8mxM097yJuFvhKpsP1LNG7hm9
         S85pDrGwEVlwbMDUdrWwGQbm2rLFwcQQVTUlo8cr1DSgjwSa0N7orfDFwFTwGgkplg6C
         0OukehRl/vbU8SL6EAy0Kts+CZOxrfUgmV84abe3KIgnRFa483oVOQkYJS5f2t+bLwvl
         GmKGMLKDvdmMw1g09i8JMaoFaTsfdGILPNjOtpNywbSpyMF1THJEMa2aKaTrDkjQBXBy
         3sAnqSHes11h7hKT6n9XqdLf67H6ai18qC+yUrebQKIWNRoGIQ+p6jWZj2Jl3iyM6be3
         lkhA==
X-Forwarded-Encrypted: i=1; AJvYcCVeLwivvqCbT49N11DLQlC7OkRT75nWxUItvppZROSuHG/uzeOUHGfpDaxO/SNAiWNZHOQuDzxGOSEkC28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIVONXFRcJHeP25NVWfPGq9erErcLp2v0vQ0ygblk0YOfX8W8d
	dt2Q7TSBzP5vuX17d6ppgl6n0Zh+GSWK2QjMRrqLIZUtcTQqwN1/kS+ojq/sefQ=
X-Gm-Gg: ASbGncu42fjjr8ChhmkkwSzoSZyeiC1LlWT6Rxobuvi5T4ljiG8nCeipWCNGGBoo/tI
	366mhCOpdzhF/4DkCJjJ3CPz7uH/edbJu+Tc5EKqw32B8ZkWg3Z/JXLTX4u2rsvUgMiHcdkOVtJ
	rD42NBOgkXD7MXAGB36amoReSOH4NVM9pc0w5Hb3sS88bB7u2Q8ibIxGegweGOZkZQbOccYZgDL
	ZXtfOL3PYZzoVeSf7+686xpQ4YLbmCdEMPBQbHR1G2Hre5OvOqLuouLBlzRZ29X0htTXr1B8XX1
	DIFF/CBX3xTccfTJ0K632irgJ5H84WhGkcWjYRb7DBnKRiYvOrbnAZZmq7xshg+mKZHzjU6TLIV
	tL6aveWYgBNFD1uZo52jXTy3vEec=
X-Google-Smtp-Source: AGHT+IF1Oy+4QhvAWwHeDn3R0uQ5Isy1d2l2u08+njtWzaQFhNdJOyfxxqQyz/PR71XHxSfgw3/fYg==
X-Received: by 2002:ac8:5d54:0:b0:474:dc44:28c4 with SMTP id d75a77b69052e-4761194f13emr906341cf.38.1741285185382;
        Thu, 06 Mar 2025 10:19:45 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751db569f1sm10055721cf.80.2025.03.06.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:19:44 -0800 (PST)
Date: Thu, 6 Mar 2025 13:19:41 -0500
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, AneeshKumar.KizhakeVeetil@arm.com,
	Hasan.Maruf@amd.com, Jonathan.Cameron@huawei.com,
	Michael.Day@amd.com, akpm@linux-foundation.org,
	dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
	hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
	jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
	kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
	liam.howlett@oracle.com, mgorman@techsingularity.net,
	mingo@redhat.com, nadav.amit@gmail.com, nphamcs@gmail.com,
	peterz@infradead.org, raghavendra.kt@amd.com, riel@surriel.com,
	rientjes@google.com, rppt@kernel.org, shivankg@amd.com,
	shy828301@gmail.com, sj@kernel.org, vbabka@suse.cz,
	weixugc@google.com, ying.huang@linux.alibaba.com, ziy@nvidia.com,
	dave@stgolabs.net, yuanchu@google.com, hyeonggon.yoo@sk.com
Subject: Re: [RFC PATCH 1/4] mm: migrate: Allow misplaced migration without
 VMA too
Message-ID: <Z8nnPYldSXs5TYND@gourry-fedora-PF4VCD3F>
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-2-bharata@amd.com>
 <Z8naQNirs4HfTX0O@gourry-fedora-PF4VCD3F>
 <Z8nfPlJu8kxUvB8m@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8nfPlJu8kxUvB8m@casper.infradead.org>

On Thu, Mar 06, 2025 at 05:45:34PM +0000, Matthew Wilcox wrote:
> On Thu, Mar 06, 2025 at 12:24:16PM -0500, Gregory Price wrote:
> > we may also need this:
> > https://lore.kernel.org/linux-mm/20250107000346.1338481-4-gourry@gourry.net/
> > 
> > May be worth just pulling these ahead to avoid conflict.
> 
> Or not putting them in at all because this whole thing is a magnificent
> waste of time?

Divorced from the tiering mechanisms, is making misplaced migration able
to migrate unmapped pages not generally useful?

~Gregory

