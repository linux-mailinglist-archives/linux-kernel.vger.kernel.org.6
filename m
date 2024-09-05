Return-Path: <linux-kernel+bounces-316193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E7696CC6E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2301C225B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7E9CA6B;
	Thu,  5 Sep 2024 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkbXv4ka"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95627D517
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725501416; cv=none; b=RYBQYqYIuO13Lca2NR7FqaurvPIhwf7nHOsAnK1RduPS/gvMvdpSv8nclHwxpSbokPcpjXsXTj0WVZ8jXhBNllWtZ/LcFqoLU7pnw77Yp9yeUYVbLRuPtiGAtAtnNOVa458yb+CUJ4TYaDP4xQh4wRe+ApbmXZBih1v0D5Bmnvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725501416; c=relaxed/simple;
	bh=X2jg/CSCnac1SLcSoXZn4AwOgINNBSYi5/6aptGjVHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdn+CdfC8POEX7WHjMOlxpnNa5PiecYZS42a/06+xdXe6G6EXUGEECxIIrkAmHWdsGTT4qHohhyL1AttA0J5hxFu9XYesQf2DIRGPbn/snQUR0ag7gCVW427G1peA8euTcAlNp37rvGQodEe1DtbKObE+4XI2lRH/AyV9Pi4lGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkbXv4ka; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725501413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V9IyXZANepgCuS2Qn0I3+uCl4ttAlaIVhX5WX8XO7Eo=;
	b=MkbXv4kat7CpVmThUlftegwU+mkB5uZ1nYHuofalnr9DXSr+nnFEK8ScaIca0XVmVzo16+
	f0GWjAywhloGgl4zNqv5VRzvg+NNaOjEqSkwEK75rRZFrgEhn2+Uj/qwNHYkL1zEDbx+oj
	7kdskKNe6y66HFJagxEj3PJcj9LI1Ks=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-Vvc1lNIqNDWOmJY0jNz9Hw-1; Wed, 04 Sep 2024 21:56:51 -0400
X-MC-Unique: Vvc1lNIqNDWOmJY0jNz9Hw-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a06d38241so5475439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 18:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725501410; x=1726106210;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9IyXZANepgCuS2Qn0I3+uCl4ttAlaIVhX5WX8XO7Eo=;
        b=BS0Y/e7u+yekdN8PCds76URsPHwCBvO3ZeLwaq13wPFC5MM19YLo2WHnMCtAKf+PmD
         xP7cto0/FbfG6klyDzhc1CC6eO0FYs/a5nQ/jL4TGneZv9vuklCDOBo55hroZ50o/8PI
         TXMM1bJEPa9yM+ottHQjZcflLMX8REJ5hydT1Z/ZnXlzWxHZ11SOMeI2yIicry7Lx0H5
         E0WRQdBA+d4/8JH4P6b+APIQQYB99PHOTUjWNW3Mc4n79WHSvg52sz+6VkhTSejMGEi+
         UT8tS0moj5lM0UsmJK/5hnKGa83LzFTHhncJO4qW67AKgboEuz0mH61VXdQAA898KFOP
         zCBw==
X-Forwarded-Encrypted: i=1; AJvYcCXzQxnyz9gpMtDNP2G2CUlve/lBgH5U1KEDoyKPM0b/k6PAg37bGl5qj2oh5zLxDNEMXS/1dXcAR+oazeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0lj86vgiN7GoBvYc8bwmMrSNGtnHaay4d0YAa1Z/8rZg0b0+l
	1XSQzGT/CI6BDNJ+T1RIEqK2vTDD2eTyMkhK9H89EgW/+sAcgkptg+mEcXMTP0eZGWToNFC8c/2
	ZSW5frJE6Pk8vnvCIcbqlGxIRJ3mif9aJRE4BkLSB5f00t69ZMPfMlUsAwXaPHw==
X-Received: by 2002:a05:6e02:219b:b0:39d:2524:ecdd with SMTP id e9e14a558f8ab-39f410bee53mr124314285ab.3.1725501410488;
        Wed, 04 Sep 2024 18:56:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtuPTPL6JAs0Wyp1aEX6Xiq0niWVe1RJrweFcEntVVHv73mDCPuCPFOAe1ckf/tW8jFMjlBA==
X-Received: by 2002:a05:6e02:219b:b0:39d:2524:ecdd with SMTP id e9e14a558f8ab-39f410bee53mr124314155ab.3.1725501410091;
        Wed, 04 Sep 2024 18:56:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e92976sm3397323173.119.2024.09.04.18.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 18:56:49 -0700 (PDT)
Date: Wed, 4 Sep 2024 19:56:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Philipp Stanner
 <pstanner@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
Message-ID: <20240904195647.6489fedd.alex.williamson@redhat.com>
In-Reply-To: <65fe5c47-e420-4b4d-a575-2bb90e13482c@kernel.org>
References: <20240725120729.59788-2-pstanner@redhat.com>
	<20240903094431.63551744.alex.williamson@redhat.com>
	<2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
	<24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
	<dcbf9292616816bbce020994adb18e2c32597aeb.camel@redhat.com>
	<20240904120721.25626da9.alex.williamson@redhat.com>
	<ZtjCFR3kd5GfV_6m@surfacebook.localdomain>
	<20240904151020.486f599e.alex.williamson@redhat.com>
	<65fe5c47-e420-4b4d-a575-2bb90e13482c@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 09:33:35 +0900
Damien Le Moal <dlemoal@kernel.org> wrote:

> On 2024/09/05 6:10, Alex Williamson wrote:
> > On Wed, 4 Sep 2024 23:24:53 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >   
> >> Wed, Sep 04, 2024 at 12:07:21PM -0600, Alex Williamson kirjoitti:  
> >>> On Wed, 04 Sep 2024 15:37:25 +0200
> >>> Philipp Stanner <pstanner@redhat.com> wrote:    
> >>>> On Wed, 2024-09-04 at 17:25 +0900, Damien Le Moal wrote:    
> >>
> >> ...
> >>  
> >>>> If vfio-pci can get rid of pci_intx() alltogether, that might be a good
> >>>> thing. As far as I understood Andy Shevchenko, pci_intx() is outdated.
> >>>> There's only a hand full of users anyways.    
> >>>
> >>> What's the alternative?    
> >>
> >> From API perspective the pci_alloc_irq_vectors() & Co should be used.  
> > 
> > We can't replace a device level INTx control with a vector allocation
> > function.
> >    
> >>> vfio-pci has a potentially unique requirement
> >>> here, we don't know how to handle the device interrupt, we only forward
> >>> it to the userspace driver.  As a level triggered interrupt, INTx will
> >>> continue to assert until that userspace driver handles the device.
> >>> That's obviously unacceptable from a host perspective, so INTx is
> >>> masked at the device via pci_intx() where available, or at the
> >>> interrupt controller otherwise.  The API with the userspace driver
> >>> requires that driver to unmask the interrupt, again resulting in a call
> >>> to pci_intx() or unmasking the interrupt controller, in order to receive
> >>> further interrupts from the device.  Thanks,    
> >>
> >> I briefly read the discussion and if I understand it correctly the problem here
> >> is in the flow: when the above mentioned API is being called. Hence it's design
> >> (or architectural) level of issue and changing call from foo() to bar() won't
> >> magically make problem go away. But I might be mistaken.  
> > 
> > Certainly from a vector allocation standpoint we can change to whatever
> > is preferred, but the direct INTx manipulation functions are a
> > different thing entirely and afaik there's nothing else that can
> > replace them at a low level, nor can we just get rid of our calls to
> > pci_intx().  Thanks,  
> 
> But can these calls be moved out of the spinlock context ? If not, then we need
> to clarify that pci_intx() can be called from any context, which will require
> changing to a GFP_ATOMIC for the resource allocation, even if the use case
> cannot trigger the allocation. This is needed to ensure the correctness of the
> pci_intx() function use. Frankly, I am surprised that the might sleep splat you
> got was not already reported before (fuzzying, static analyzers might eventually
> catch that though).
> 
> The other solution would be a version of pci_intx() that has a gfp flags
> argument to allow callers to use the right gfp flags for the call context.

In vfio-pci we're trying to achieve mutual exclusion of the device
interrupt masking between IRQ context and userspace context, so the
problem really does not lend itself to pulling the pci_intx() call out
of an atomic context.  I'll also note again that from a non-devres
perspective, pci_intx() is only setting or clearing a bit in the
command register, so it's a hefty imposition to restrict the function
in general for an allocation in the devres path.  Thanks,

Alex


