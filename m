Return-Path: <linux-kernel+bounces-260111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D721393A330
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8781F2265C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E297156C52;
	Tue, 23 Jul 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KqhEj8lj"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661B15698B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746157; cv=none; b=jo6JLsO4dyd/KetXQYIRLMKmHVnYkN+fX4sewCm9c6jjIcBv0Rpvdkz1E0yafyreUpZLP723+YOi+6Q8OWFfH6k5YPmf1Zdlvwjs33s3KYGFWwj0JDx1e9OeYLVK9e51ap3MInUatbbgbvvHsNCLEOtSt9oNpjYWXgfbMKlqys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746157; c=relaxed/simple;
	bh=D/WnwQTW9BFVaG/Xs5CjUVRukgZHnyylEbhaayuJB0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMle/4u9AsWpA6QjaSYqxb3y2WNDY9IVKeal4lqp1BYqGYF1OVmGJeeMOj8tTVvXyX1KaAjffg4lqix+w05rPKAY3/RIJtiyIEiEGsyUe4n6ZR+X64PUnlQjiUtTvTkVccwqzA/AncoCDrB1ouLgMi50Vz2R6n2Lo6lCZj9wiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KqhEj8lj; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so5234014276.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1721746155; x=1722350955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HF7Q8BYVpApn5PT3KGRPJc84HSwFTLHmpZNdfKhD7M=;
        b=KqhEj8ljztHAcVYelWEfGYgYE+6Lid9oTyUXtpBkGCglU/heroFUoD0GgPtblaLixR
         NrdAuDRAUFJB8792mjbVwLeZwig7uC3oeCts3njx2OsEXEpCF2PtkHnJT+/duCn6v78Q
         62mqlaVPxeO4B6f0CPHUt4wp05bZg4CeWdFuY4DWLuU+x8mjAko6PF/hi3TBOvJpPwYe
         T4mLF/WWlz44JHP4X7w7pfzYEJ8jc4AwYzGj6jA8ixZ0hf995SmZjE/xS07Zx/VNHblB
         e9vJIfPuOAXxeRVkU1EMDOBImykB/WG4WGdAMfPTafI7kTorYL32pgW3OWOGZQ150svc
         kY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746155; x=1722350955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HF7Q8BYVpApn5PT3KGRPJc84HSwFTLHmpZNdfKhD7M=;
        b=Kyq3AY8EMyf/gEYvse6eUfDXHgLjKlhZyGmqwaeyqeXzkQBNs8gKhED9H1u0WppG7M
         sFPrxjEJ/eup/kaBWRsdE7vyQ87Srq219XCoGh/s9CZfG0k0Z9/O5zB9798hH/p2lJNg
         Qo+SUrUQB3QzfZWhUZEPSWNE16sI+xoF7jXkipRBzpZt6gD4CsJLaEYegjpJhPaEIcPX
         2NcgR0q5cN8liB98g5/SBTEqDqascoktNjQcH0NJ5zXfiqn/jEUpdwhKZOCtxizPFlLU
         5dZ2ITs0o4jxmBCgSS+23iaRNaSB9dUNeSCjL5LL0pGoKT6qm7buopZRrXg0lhvBJEeo
         dPfw==
X-Forwarded-Encrypted: i=1; AJvYcCWkKqnXylyMUvQNYOl54RkInzZ55slCQfeTaFekZXeCWRFqg6uaxa8ANxa78iEP7QCrADJgB6dMz+kxf4Mm4motcq94qhc+kZTdPLaL
X-Gm-Message-State: AOJu0Yxi2BsrpthqbCT1DcMizCDPptuUR+fKGDLlLXLjZTk7NLv56EFD
	evMLEmInBvlgR5/Gpd2b+OV8p5VDtdclIINCvPKuEolbxkQf88qLKC/38evfUNGUqQChialCjMD
	W8AQ=
X-Google-Smtp-Source: AGHT+IHw8bzuJOKqHhNWSkL//t6fUYsEYjxn7Hjm93jAzR3sIFR1CZp1IMh8tpB9hciLHpE5Kdag+w==
X-Received: by 2002:a05:6902:2611:b0:e05:eabd:62e4 with SMTP id 3f1490d57ef6-e08706a4df0mr13359623276.36.1721746155371;
        Tue, 23 Jul 2024 07:49:15 -0700 (PDT)
Received: from devbig133.nha1.facebook.com (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e08609f765bsm1891063276.33.2024.07.23.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:49:15 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:49:13 -0700
From: Gregory Price <gourry@gourry.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 2/3] cxl/region: Support to calculate memory tier
 abstract distance
Message-ID: <Zp/C6YgwiK9r0l4w@devbig133.nha1.facebook.com>
References: <20240618084639.1419629-1-ying.huang@intel.com>
 <20240618084639.1419629-3-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618084639.1419629-3-ying.huang@intel.com>

On Tue, Jun 18, 2024 at 04:46:38PM +0800, Huang Ying wrote:
> An abstract distance value must be assigned by the driver that makes
> the memory available to the system. It reflects relative performance
> and is used to place memory nodes backed by CXL regions in the appropriate
> memory tiers allowing promotion/demotion within the existing memory tiering
> mechanism.
> 
> The abstract distance is calculated based on the memory access latency
> and bandwidth of CXL regions.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

