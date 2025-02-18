Return-Path: <linux-kernel+bounces-519818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9105EA3A243
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD2918878DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0C326E177;
	Tue, 18 Feb 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SxoQFEHl"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49616C850
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895080; cv=none; b=gocGVRFFSKwaeXWl6DZ6YhQghQr1j6n2Hz+mHznYpAqGv8Y7b3CaJ1kTazZkGA7+bY4fLUB0wEobYbb+646hsQZibdEEwHjL9IxwVPhyEULCBWVYrsyp6Keh+K38vHX4Jk6JDI89nokXp76pQfqBVOFjsb8048GTjqUmpR36cl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895080; c=relaxed/simple;
	bh=PZOujvQ+MNaRhQOa2hN49EYGkUXw8bFhUJtY0Zoxzpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm4M9DyaM4tzmZrrWD/tN6ykQRf68Nl/1irsEpT7RHk/ezNuaN0zv/FhHtQMdsxYU0MSWO1/XvWimx6gXi1djoYchNS7/5u2Pv/oXKLaX7C/6aZcJygDLs5sNrJbQzCFa/HZ76dKLciGD64D77Z10J/YS7Xac839fa2+d9b+cm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SxoQFEHl; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46fcbb96ba9so63841841cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739895076; x=1740499876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cQGGMSgY8MGd0sxrw5WDxENgtEsj70+ROuTTP1PL5Y=;
        b=SxoQFEHlyn6CAmG7dHYNAUqmfSlcv6TWg9T0bVtXnFSq0uS4kOPY7gjy0WsxY0bBun
         ndHY9HQN52yErO1EIUgM8XZ1bWGLBeEbh0C+ft541Sb5fkWNAAvpvSTryAuyjCF4GU+1
         4Fj+B583Abl4/CnGmLOAFv8tfyC1UzVBDHeq1lrmSQ6K8DTpade2wR/pVl347bz2i43I
         D3iaubq32DqUfQPCe7cc9DIIxmMqG6o5t856vcFVSrTqmAnabARfaJvo2aUvQgJClvSR
         iAPStuvS0T6z12PFr1iD4VHzHO8VJuSYJ55IZeYwBm6skwF7NnT1THuxyq968E48F/3H
         JL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895076; x=1740499876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cQGGMSgY8MGd0sxrw5WDxENgtEsj70+ROuTTP1PL5Y=;
        b=abt0NmYwP3NoeXq5dgiTrMRSyC44HZIo3iqVT/gyPgBkR4h5euwupQ0vzD9EkOqJ02
         qKEDIZnNwJeq4ILOe+qtmtfF4I/9YhBa2WgX+tgho+ORQNdZn0hH18FETUtaHXRVL9N4
         cxw0qlFVawFhxrp7kVbHxLMizc3OGXupHUt7ZQduS36hNa0XG3MMKgt6YHvX+H9Fa1DE
         jY/umgkL+SxP975g4iVrClsVRUfPkF/enQmTE2g31WtZQcR0a39dwgpiHsZD7Nus466V
         CVKVdUg2aPguBqd3F00hgncgcjtu2Qm0/rvVNfHsHV3h9UTDpDllIDkE6ayIw/HOvSpy
         miDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgshPQSh2rwQOkOzoa7oT3NIPozd8A+nP1bzwT+0B8dALhvcfe5OtRfXOMv1ipKo0QsLBYEpejcRYsU/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEba3ji+5dTuufAeDf8046rWbIPyhN7R/kOu6uZfNC0UnvSD21
	ks04vqKwnKsKp7ELQqEi1+cdHZyWQFhyCLRQcgPhqRXtzWewecXcitjhS65vtu6gFQ1xLOWy4MM
	V
X-Gm-Gg: ASbGnctv8Pueiz26FITMEPo1n89tGHVEuDw7i4X0z93ja1Fm5TARMq/kDlyUjkZHkHr
	UkFIOZTV+B7JYYi0ak0+4Otj0lm2WQ/M40Xu0egvEpiCIFSze5xODOitKhgg4MDmnn31oOwy6D1
	OzEFtqSuyMhN5DUd4eTKjYqMX4tuYLilLN6o/gLfUe9y7OycHD6iB2anmS2Nh9NW1GqiHpKhv9U
	bjPNLkZg8ti8j+BRPutIMn0ltODq37+EBHBAhV/VCuxD/0I2NJ4epKZPOWi0N+gzuiEZxPh2hGz
	pMnYTijJcYElI9ondVpqJq8Z+OS+xx35kaenVgJKv96YqWGFwJYWqdv1W1en6Bze45yKZtXzfw=
	=
X-Google-Smtp-Source: AGHT+IHYr4BQwfAkYI4GpOjTNITJVFyEpNnF+z5lYLa4RM2UUxXYRmgvzKbGSZXT2OG53A5PVYI3XA==
X-Received: by 2002:a05:622a:148c:b0:46c:728c:8862 with SMTP id d75a77b69052e-471dbd6fe65mr167655371cf.31.1739895075791;
        Tue, 18 Feb 2025 08:11:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471fe6c81e4sm12279921cf.44.2025.02.18.08.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:11:14 -0800 (PST)
Date: Tue, 18 Feb 2025 11:11:12 -0500
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early Boot
Message-ID: <Z7SxIBF-gkuBTqTJ@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
 <Z7RdH7RGNivDjq6n@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7RdH7RGNivDjq6n@phytium.com.cn>

On Tue, Feb 18, 2025 at 06:12:47PM +0800, Yuquan Wang wrote:
> On Tue, Feb 04, 2025 at 09:17:09PM -0500, Gregory Price wrote:
> > 
> >    1) This memory may be placed in any zone (ZONE_NORMAL, typically)
> >    2) The kernel may use this memory for arbitrary allocations
> >    4) The driver still enumerates CXL devices and memory regions, but
> >    3) The CXL driver CANNOT manage this memory (as of today)
> >       (Caveat: *some* RAS features may still work, possibly)
> > 
> 
> Hi, Gregory
> 
> Thanks for the in-depth introduction and analysis.  
> 
> Here I have some confusion:
> 
> 1) In this scenario, does it mean users could not create a CXL region
> dynamically after OS boot? 
> 

It helps to be a bit more precise here.

"A CXL Region" is a device managed by the CXL driver:

  /sys/bus/cxl/devices/regionN

In this setup, a "CXL region" is not required, because the memory has
already been associated with memory blocks in ZONE_NORMAL by the kernel.

The blocks themselves are not managed by the driver, they are created
during early boot - and are not related to driver operation at all.

The driver can still enumerate the fabric and the devices that back this
memory, but presently it does not manage the memory blocks themselves.

more explicitly:  There is no link between a memdev and memory blocks,
which would normally be created via a region+dax_region+dax device.


> 2) A CXL region (interleave set) would influence the real used memory
> in this memory range. Therefore, apart from devices, does platforms
> have to configure CXL regions in this stage?
> 

Again, you need to be more explicit about "CXL region".  A "CXL region
device" is a construct created by the driver.  In this scenario, the
platform configures the CXL memory for use as normal system RAM by
marking it EFI_CONVENTIONAL_MEMORY without EFI_MEMORY_SP.

Some platforms configure interleave in BIOS - how this is done is
platform specific but ultimately constrained by the CXL specification on
programming decoders throughout the fabric.

> 3) How bios/EFI to describe a CXL region?
> 

You would have to discuss this with the individual platform folks.

The main mechanism to communicate CXL configuration from BIOS/EFI to
kernel is the CEDT/CFMW and HMAT.

~Gregory.

