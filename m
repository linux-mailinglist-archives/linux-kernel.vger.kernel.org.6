Return-Path: <linux-kernel+bounces-292092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B6C956AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B401E1F21B35
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697C016A959;
	Mon, 19 Aug 2024 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Me3YBvDZ"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C015B111
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070844; cv=none; b=HUADtjcfrhc3EnzizUozv6LoCJR4l30ghxm8e4VSg1TCGAOARqCDMhtui0wHJfZZ2NxTt4aEBIXFtpxvHr3TU5W5upUD4Eu7fu40qpJ9weGzeDMhq7upL49tqnXnEYlzbEasdqnuMNOpIvhofv1phx5vQXQkQbNSoHx7hEwE0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070844; c=relaxed/simple;
	bh=+0jRmYM3BIyfYfODUKjrloxe1+Z9UqA25KBuL4lSTdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbLxb8aWzdu8E+m8nGRmy6OIq1GkULZMMnOKnVW0lVwRPyPWp8fGDNIsPdI4ZEOeYrNKNE7q3h0+NqPNzzcv/yh3TgQyDWl78F/Of0gq3s6SJy2TqUL1Q/OFV7+d5bGBTM2UvQeEbIp4pH6IMK+I7fMKijnAd1tLvpXDdU19jN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Me3YBvDZ; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-49297fca3c2so1529103137.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724070842; x=1724675642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQpOZu4CzjYzGnVaMGjEB0UGuRwYjdpu2bXWuEbf9n8=;
        b=Me3YBvDZmkcR/5FniFGW0eSe4J4XMjd7OXOfGv4pKg7N8MjbmIZb3KnC/1NHY753v/
         FBUmteY0V9CMqOiJUB4/ehn50n3JXhHlJzi1wXZMWe/POfg98SQWfhuq/fqErfpmqV3g
         /MrwKYiUCmHT4/ujq657l10kFFAmif+aMMJYPFq4yygv0yFHKV9ORIJ5B6n/49ryUBaE
         4zSuo3Ob9DjRKGk7Aqd2FkWvFCQC+aXRHkkfiQPZYyXCn28hKe65MhECVOzMCCGikuJT
         Rag8SUQPqp8ibWRh6/YrHwIwwrEaMNJ+8+pTSrCZDPIWw7fd8ag+8L0uWMxsR4v8kbpH
         Y20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724070842; x=1724675642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQpOZu4CzjYzGnVaMGjEB0UGuRwYjdpu2bXWuEbf9n8=;
        b=D3hHtR4+gIhGkt52AVMManJUDlPQoPXohLUllJB7NMRMMbm5GAlKV/tsAE9XyKPeLA
         VE0yUwMpXzz285XhRfm9fSEfmR6WfQIq+OGUHckeXb0HcFsJVMpbEgG9PDx7+25mzYB8
         4jy5KLasQwlzm504TP7yK0aJrxyAq7d5khhG/A3+p0FHClPbzFKHFUHfCCib+aPqZLp+
         q3XbvlpHKzgZzkr+xyfxdp4Ped6i6oXUHl44uNMqFhavJu7jKd3zrOwARYBM5AFRe0S4
         Xge84buuN3vYxibqvrhniSD/2ydnQO+JqKQXIBznPHrnS6MI9Ie7UsL0YR71GkiLadcs
         j4OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrR63KaEEsBdBBCbX/ZrWZxEl+a80YjTdlK0SAPGffx6CBZObdk9FLEzQXjDxGldUsjD6v7HFJhkWC6kZ6fMMM5tdp+duJ2yDC2YmR
X-Gm-Message-State: AOJu0YyhXftS5lwffuRc8brwrchlYyqb9aSLOa1nvIOxg6dESOKDU2SB
	f6R7LBI81v8rFvuthjd9k9XFNxoWSu+sohB2Mx+rnxkoMIE1Z29tWvIkYvMixGk=
X-Google-Smtp-Source: AGHT+IHrKEFNCileOhq7EM4IymMT5yiLPV6Hjs48m7OF3CiU15peExhQF2qose8JEEzRWgOAer2Lew==
X-Received: by 2002:a05:6102:3912:b0:492:aa42:e0ce with SMTP id ada2fe7eead31-4977997cd15mr14374649137.20.1724070841927;
        Mon, 19 Aug 2024 05:34:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff025280sm428971985a.24.2024.08.19.05.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:34:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sg1aC-00CJ0V-Qc;
	Mon, 19 Aug 2024 09:34:00 -0300
Date: Mon, 19 Aug 2024 09:34:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
Message-ID: <20240819123400.GU3468552@ziepe.ca>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
 <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
 <0e807eec-ce51-42e2-9290-dc90c4210888@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e807eec-ce51-42e2-9290-dc90c4210888@linux.intel.com>

On Mon, Aug 19, 2024 at 03:09:00PM +0800, Baolu Lu wrote:
> On 2024/8/19 14:34, Vasant Hegde wrote:
> > On 8/16/2024 6:39 PM, Baolu Lu wrote:
> > > On 2024/8/16 20:16, Vasant Hegde wrote:
> > > > On 8/16/2024 4:19 PM, Lu Baolu wrote:
> > > > > Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
> > > > > attached to the device and disabled when the device transitions to block
> > > > > translation mode. This approach is inappropriate as PCI PASID is a device
> > > > > feature independent of the type of the attached domain.
> > > > Reading through other thread, I thought we want to enable both PASID and PRI in
> > > > device probe path. Did I miss something?
> > > PRI is different. PRI should be enabled when the first iopf-capable
> > > domain is attached to device or its PASID, and disabled when the last
> > > such domain is detached.
> > Right. That's what AMD driver also does (We enable it when we attach IOPF
> > capable domain). But looking into pci_enable_pri() :
> > 
> > 
> > 202         /*
> > 203          * VFs must not implement the PRI Capability.  If their PF
> > 204          * implements PRI, it is shared by the VFs, so if the PF PRI is
> > 205          * enabled, it is also enabled for the VF.
> > 206          */
> > 207         if (pdev->is_virtfn) {
> > 208                 if (pci_physfn(pdev)->pri_enabled)
> > 209                         return 0;
> > 210                 return -EINVAL;
> > 211         }
> > 212
> > 
> > 
> > If we try to enable PRI for VF without first enabling it in PF it will fail right?
> > 
> > Now if PF is attached to non-IOPF capable domain (like in AMD case attaching to
> > domain with V1 page table) and we try to attach VF to IOPF capable domain  (say
> > AMD v2 page table -OR- nested domain) it will fail right?
> 
> Yeah! So, the iommu driver should basically control the PRI switch on
> the PF whenever someone wants to use it on a VF.

PRI enable sounds like PASID enable to me.

The ATS control is per VF/PF, and PRI does nothing unless ATS returns
a non-present indication.

Like PASID, it seems the purpose of PRI caps is to negotiate if the
CPU can process PRI TLPs globally.

So, I'd guess that just like PASID we should turn it on at PF probe
time if the IOMMU can globall handle PRI.

Enabling ATS will cause PRI TLPs to be sent.

Probably more of this code should be lifted out of the iommu drivers..

Jason

