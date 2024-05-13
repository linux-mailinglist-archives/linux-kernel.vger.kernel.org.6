Return-Path: <linux-kernel+bounces-178168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1078C49EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7231C20EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD7A8526A;
	Mon, 13 May 2024 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TQ6m6nIP"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00E1F934
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641997; cv=none; b=sDrQgK+WRXYVtFJkYnXxbc9jxAASx90833i6naAQaFi/8PiG0m0LuRZZqoqEkTFxPTgoqQhg+ee4SG7e6r31lkzTb+eihkaD2blKGeYu8bv8o7CKV+HYVquFGChm1LvZinRM/+MLkCvY5/TXUhHO0oI3j1uCyTSnY/RDthPkp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641997; c=relaxed/simple;
	bh=KVxWEEMusr5o/+8wVpd82stWk9fomHiDYygEM1sIWv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AC6p1CiXqUJH2dldWH0p5OSy17zPR2BZkGt6qJCnduWOSVlsiygZL4XE4DbR6gAZOIiua68k4qIoFFewj6GKBG5ymgXGkmIe6fN5GMUT+dZplwiyU5Leo1Q42WNUW69aC4SWKfygcmBERlUWbP9JHaAyi1hv43+/wJHJpGZwxZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TQ6m6nIP; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b2d065559cso543459eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715641995; x=1716246795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K13d2suv2hs48dyrO5RUdGVdLQgHtL4pY9E2k2jEkcs=;
        b=TQ6m6nIPsAEuEdLnkuvA5ON8I8cYOIujXUmgRZOaZVz7FDWwjNJynT/HX9wB0ronbN
         hyHS38SGrS+T8Z1py42uMsjKfh9rumTD0Tc0FWFPzYUSIkNZ/0XClL3GNk46dOb2Z9l6
         UpvOu4Vg6LWHUnz3uQvXYCtoOf7soA6kSd5PNdc7egNxzcfmfsB75aofsKGV/1fupkns
         tzkor7examIjROjMu9AhNyxAxyuh8dWMoSLuRs07VcDrQEZ1DkLqrg4x5x8G1bjzK3q6
         KhwXL+r8G9d7NlfDyi+B44Nf7XTio6fMhsnY0YzEy0S0I869OE260LcI/7H/p6zVeJI1
         1ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715641995; x=1716246795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K13d2suv2hs48dyrO5RUdGVdLQgHtL4pY9E2k2jEkcs=;
        b=A7whxabjd1OfHaE212dVrcOiniKT2V9JHeamwYZ6jnXEsMy8vxms1WpfZIEQiGOr5J
         OaAojGMx+sl27Fq9Z9JvSHDtq5ZZ1n97+FOF3XxenVDfipKdmhJBn9J7MdDjA9G2E8JO
         NjZ3bbujiahasAhWl4qlwPRgCamoNY51i5ni+g1ywIaDOqXYrmvC1IWcWxZHcsaLJnGq
         nC/6YEDGb+ocCf913K9GU/YTpoWmyowz6aHMbWLyrKCsEkkGFwCpuHMGr95BLr6UEoXl
         NDcsuMVWNbPE+cF1n9FxlE1PJ4NIqPltlFRllDNlPzMNykirABlQ073EiUBjK4vAzxdI
         bdDQ==
X-Gm-Message-State: AOJu0YwCEzL1/Y/Jftu0H9S9fd8t9XRbvbMGm0/Tx1qGE85/RH1Avs20
	uUZrE0OjltTZy/daJJytQNmqntHR3IACaMAN52Oj3SfgOhUOShLw+/ZmtlIRgpk=
X-Google-Smtp-Source: AGHT+IEaRONGvO+VFioEuzjJFNAKvA7ONjteGiYwffmRtfx5NWpRsf3HAwcf5gq5E6YX5CyBb0oqqg==
X-Received: by 2002:a05:6358:7f07:b0:18a:68c9:d7b8 with SMTP id e5c5f4694b2df-193baf0130fmr1221047055d.8.1715641995162;
        Mon, 13 May 2024 16:13:15 -0700 (PDT)
Received: from ziepe.ca ([50.204.89.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b862567sm7212973a12.29.2024.05.13.16.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:13:14 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s6er3-0001hF-Pn;
	Mon, 13 May 2024 20:13:13 -0300
Date: Mon, 13 May 2024 20:13:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	thomas.lendacky@amd.com, vasant.hegde@amd.com, michael.roth@amd.com,
	jon.grimm@amd.com, rientjes@google.com
Subject: Re: [PATCH 1/9] iommu/amd: Introduce helper functions for managing
 IOMMU memory
Message-ID: <ZkKeiTE7184F6isF@ziepe.ca>
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
 <20240430152430.4245-2-suravee.suthikulpanit@amd.com>
 <20240501161741.GG1723318@ziepe.ca>
 <1b03ba34-ac06-47ed-9086-f8d346a20bb1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b03ba34-ac06-47ed-9086-f8d346a20bb1@amd.com>

On Tue, May 14, 2024 at 01:59:33AM +0700, Suthikulpanit, Suravee wrote:
> Jason
> 
> On 5/1/2024 11:17 PM, Jason Gunthorpe wrote:
> > On Tue, Apr 30, 2024 at 03:24:22PM +0000, Suravee Suthikulpanit wrote:
> > > Depending on the modes of operation, certain AMD IOMMU data structures are
> > > allocated with constraints. For example:
> > > 
> > >   * Some buffers must be 4K-aligned when running in SNP-enabled host
> > > 
> > >   * To support AMD IOMMU emulation in an SEV guest, some data structures
> > >     cannot be encrypted so that the VMM can access the memory successfully.
> > 
> > Uh, this seems like a really bad idea. The VM's integrity strongly
> > depends on the correct function of the HW. If the IOMMU datastructures
> > are not protected then the whole thing is not secure.
> > 
> > For instance allowing hostile VMs to manipulate the DTE, or interfere
> > with the command queue, destroys any possibility to have secure DMA.
> 
> Currently, we have already set the area used for guest SWIOTLB region as
> shared memory to support DMA in SEV guest. Here, we are setting additional
> guest IOMMU data structures as shared:
> 
> * Device Table
> * Command Buffer
> * Completion-Wait Semaphore Buffer
> * Per-device Interrupt Remapping Table

And if a hostile VMM starts messing with this is everything going to
hold up? Or will you get crashes and security bugs?

I don't think it is a good idea to put things in non-secure memory
without also doing a full security audit.

> > Is this some precursor to implementing a secure iommu where the data
> > structures will remain encrypted?
> 
> Yes, the is precursor to secure vIOMMU support in the guest.

How does the guest tell if the vIOMMU is secure, and shouldn't you in
this patch refuse to load on a secure vIOMMU at all?

Maybe it would be a better idea to have a mini irq side only driver
that is audited and safe to use non-secure memory than trying to
repurpose the entire complex driver?

Jason

