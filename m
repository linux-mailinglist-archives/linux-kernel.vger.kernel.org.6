Return-Path: <linux-kernel+bounces-355490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF79995315
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85ECCB24D41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C271E0089;
	Tue,  8 Oct 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D0XVOg4Y"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D831E0489
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400511; cv=none; b=UtihhZOyD0OGLFOG9l37w5BeLsuJahhC9DEsVOZvCqeTsg+TgoRH6qySHdoYydOjbi+jr5qcqr8qYvJjCmu27fZikAr7Qxj2IRYVqpnrKUbVzqQBkajIlAInv3ytsnmGGL3mePcCSCHM6ZplPbBbLRuDnhqnQXYEx+h5eC6Paug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400511; c=relaxed/simple;
	bh=YsqpEHSxQs1WSXGDQ6CWUY1+FoJF5J2RonY3yGje8Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksQfw5i/P/+fY34AirBjJ2p1qTXU2VFkvOAgGmvJNu3W9LyT/nGeQ5nCWuOfGeG4hsTqG5ZvbO3JiGm6Lo7Y8LU3TscB+j07YpjQzzErI2lfMxEfYb49IPjQw+tgA5ytXPdigW3r67Lrelw0h3EiszSxSxflKrRfUXTGU3pw4gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D0XVOg4Y; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9b3cd75e5so577884885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728400508; x=1729005308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YsqpEHSxQs1WSXGDQ6CWUY1+FoJF5J2RonY3yGje8Cw=;
        b=D0XVOg4YpHg+8BeP6tBYWrkKUqeh2C87fYfemeuA1UP1BdPYLB3mdsVu1A/csjrTVy
         GPZPpy/HZrmVGkuf0yTwklTy5nNqC5yNkki8kouFltMqo16fqx7RWq0JEFXJOxTI/oL+
         ladSeY5CwTKRgRwoZ4hFjkdLblqUjCGI4qln0axVHWg56/g+BWKLTgl8ay4T4TlGuAeu
         Gf1uQQRdHL4uLpuUR/2UZCmVhPPhbT0rt2J00PbfsZ0IdEjBKoK9Oj/vs8fhI0uP4Ah3
         WuEzUNfDGJJWHE8IxMnkCLo5HVVFet7W1yJu8PbCTmran2slZUKv8bpzZT8kt+VM57Ub
         6Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400508; x=1729005308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsqpEHSxQs1WSXGDQ6CWUY1+FoJF5J2RonY3yGje8Cw=;
        b=DEKXeGKL84ShsJkboX8zX0ewFgWJ0m6OjZOfL5OaLpuTzjYbjPL9TI1YT84AniIk3E
         r1M15mnhPluNH3XL1nWgtocWxYRZiR5FORv5ptjlDDvnGy9jsM/i52PpRYFIonsQLGYw
         4UvAoIDuL7RkaDeQVamWRbyX+IGGv4Zlsy/2Qxy7auzrfbSYI8AR2ixNQy1hNLOKfAfT
         KZh+v4ZdGHun0E9ZNmmFYduyduufeADmZrasLcJ0mB1e+vP5yT9NY6Pu79OseIPRA05m
         GavyZX+zB++gbvAVwflqKyE1hDMeyLT80cq8E2EerpbdumGYvTjPgD7+OWjk2y72Rvx7
         Ot3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcjc6l0Kr/do5AEPwm7rZ4Jb10Ph00ShUSsKrLP2kX8u4H3vsHCFfrVnSz/TAA2ujYNpSdreaV652Suxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Ge/ZdRwIpsvdpV73PUj6ggOUK2P/ORQ3h+Aj7vbRyUbsnPA4
	7DAB8xTFyiUMWVnLz4HlqNWRoLMjQVfAdTThA8KOk5EKKTVBmBnix83w74WXEcE=
X-Google-Smtp-Source: AGHT+IH2uRC2UfcD0r1BF9aCv8jK6ZDJjGODQUbS2anKumzSrd3t/zuWy5T9g/mXSSYSymaMjGgK/Q==
X-Received: by 2002:a05:620a:192a:b0:7a9:b114:471d with SMTP id af79cd13be357-7ae6f4541a6mr2723208285a.33.1728400508653;
        Tue, 08 Oct 2024 08:15:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75764d2dsm361159185a.117.2024.10.08.08.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:15:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1syBvW-00684j-QA;
	Tue, 08 Oct 2024 12:15:06 -0300
Date: Tue, 8 Oct 2024 12:15:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, nicolinc@nvidia.com,
	james.morse@arm.com, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <20241008151506.GC762027@ziepe.ca>
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <20241008133458.GA10474@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008133458.GA10474@willie-the-truck>

On Tue, Oct 08, 2024 at 02:34:58PM +0100, Will Deacon wrote:

> This all looks a bit messy to me. The architecture guarantees that
> 2-level stream tables are supported once we hit 7-bit SIDs and, although
> the driver relaxes this to > 8-bit SIDs, we'll never run into overflow
> problems in the linear table code above.

My original point was about the confidential compute position (sigh)
that the untrusted hypverisor should not corrupt the driver.

So your statement is architecturally true, but we never check that
IDR0_ST_LVL_2LVL is set if IDR1_SIDSIZE > 2**7, and so we can get into
this situation where the hypervisor could trigger some kind of bad
behavior.

> So I'm inclined to take Daniel's one-liner [1] which just chucks the
> 'ULL' suffix into the 2-level case. Otherwise, we're in a weird

I think you should take it and let better be for the CC crowd.

Jason

