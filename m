Return-Path: <linux-kernel+bounces-374578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BCB9A6C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C0F8B242A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D7A1F9EAD;
	Mon, 21 Oct 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZBq15AK5"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B811E8851
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521593; cv=none; b=jA9BO4DGqnmZQXXRxrwL2AWRa6DLyKZZvrAW50FdwaOQwdJX7IiK7dH1s5fpw/audNx5yENGR+QoeON29l+iRU95m8uTTSMlCNJG0O9J840owvT9emDQxQ6X4aKZ6vevhyYOFLR6yGbQp0lkgLbEMYTdkg5tGm176/cSt84E9vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521593; c=relaxed/simple;
	bh=uMtbkt7MShDxCt5FX6kmDCLEOQrSOdDCjrPJVBe1XYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHtdbhDnev2q+JemfTVXOn/RVH7zHy3nFnfURxaeTWSmMsCcibhzJVViyrSW6oG/Pr6cb8eSPBKh+ZQLWhkBXX5YxSak3RPI9WPylrJRYF8TyFmovty5TnwG4YzcIE3Kyeb4DxeE1eEgyKGaR162WS8lAKWjpKoJQ9hfir014rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZBq15AK5; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbceb321b3so33600806d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729521590; x=1730126390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBwvaCcMFp61JVh2xwSwuOplQvwOE8lvZKAngP58VqI=;
        b=ZBq15AK5OM3g+Nc0zIQPjIIy75cQL+ffYldhRqlQIiBMqgENEo4giSujsumk2OIrmA
         nHwIQcUX0Syf0pr2McZlMzswihQtldV4h08/aq0459j5SACK02oC1UrtkwgX5d9ueYNo
         f3E2QpbybVf75BqnHjEJ5q46z/bJsytt8gtyI662cQ0rBJdXSzv/WmV3lQ+EomS51XG4
         tfYSEc2qIYYBv2sXQ7um6xOmKzbo/M1hj3GcJMjOqVsbXMRCaYi4ND5kKw/1d+EvwkCa
         PSd8snyVVtouzGrUPt0gwtyhBdD9yytYzcBFAJxXp+4PflTyOy56i8eVPKtGrdKZ1E2I
         Ycbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521590; x=1730126390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBwvaCcMFp61JVh2xwSwuOplQvwOE8lvZKAngP58VqI=;
        b=KFBIR0YnAYRngiOERkUXqSoBEqtxqAAEB6KEOmkhXAJChc64HL9Mdj7NiUpPCObMpq
         /98Wq+0KEh9XSjt/Dd35k3Sisnjtzy51AKUcc0SOIBkOLhW5e/3b90LYkrjbC3hzkcrp
         ovKnbIQ0hkmp37XwSgwUIhVTWo4C4vEQ3JPK9yLGVX7B9Ln7wSnkyscrwu6tt1YhcdZM
         hXNo0o4GCVxWJpHaMbmVrmeZLlq5zMLLPfHSkcDIg7w0AEnK03BjAtS56D0LV2GqiNNh
         dZdGV2IoCwx1/s6JhrQkqhB5TKpe0uMycmhVv79u6m41RLjT9/mH0n3oSox/2RSTl+4c
         U0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCW6R9VAZ0NBtz/4OrknzggNil7PmgciETcJ+DwGNZ3fggqj8XKChIx4ud7QqmQHtU9CZKCAiRA7311yiWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTwnlU7WrDVRB4JFP5Hq3xAz4vZAxkNtQx/34LWXoV8sOZLscC
	p7a5+Z+QyB6VGFRdnnqlndxQoamCVXwESIYQguqzS/yrr3WNHCJIwy16Cos3qj8=
X-Google-Smtp-Source: AGHT+IGwsR9nAFy5MvyVbGW/I5DDauVanyhn/ZsHEw5JDwji7gr1JZ+g7udLuUSB5y7QkaH+lDD7BQ==
X-Received: by 2002:a0c:c690:0:b0:6cd:fa19:2b64 with SMTP id 6a1803df08f44-6cdfa192c79mr99765406d6.39.1729521590563;
        Mon, 21 Oct 2024 07:39:50 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce0091ad82sm17423896d6.63.2024.10.21.07.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:39:50 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:39:51 -0400
From: Gregory Price <gourry@gourry.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	dan.j.williams@intel.com, ira.weiny@intel.com, david@redhat.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, akpm@linux-foundation.org,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	rrichter@amd.com, ytcoode@gmail.com, haibo1.xu@intel.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v2 1/3] mm/memblock: implement memblock_advise_size_order
 and probe functions
Message-ID: <ZxZntygJWqxq0zGt@PC2K9PVX.TheFacebook.com>
References: <20241016192445.3118-1-gourry@gourry.net>
 <20241016192445.3118-2-gourry@gourry.net>
 <ZxTF93VzRiygScA1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxTF93VzRiygScA1@kernel.org>

On Sun, Oct 20, 2024 at 11:57:27AM +0300, Mike Rapoport wrote:
> On Wed, Oct 16, 2024 at 03:24:43PM -0400, Gregory Price wrote:
> > Hotplug memory sources may have opinions on what the memblock size
> > should be - usually for alignment purposes.  For example, CXL memory
> > extents can be as small as 256MB with a matching physical alignment.
> > 
> > Implement memblock_advise_size_order for use during early init, prior
> > to allocator and smp init, for software to advise the system as to what
> > the preferred block size should be.
> > 
> > The probe function is meant for arch_init code to fetch this value
> > once during memblock size calculation. Use of the advisement value
> > is arch-specific, and no guarantee is made that it will be used.
> 
> I'm confused.
>  
> Aren't we talking about memory blocks for hotplugable memory here?
> This functionality rather belongs to drivers/base/memory.c, doesn't it?
>

You're right, I should have put it there - i got distracted by the ifdef
mess around get_block_size_bytes/set...order and just tossed it into memblock
to avoid it.  I should be able to ifdef the definition in the header and move
it into memory.c
 
> > Calls to either function after probe results in -EBUSY to signal that
> > advisement is ignored or that memblock_get_size_bytes should be used.
> > 
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  include/linux/memblock.h |  2 ++
> >  mm/memblock.c            | 49 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+)
> > 

