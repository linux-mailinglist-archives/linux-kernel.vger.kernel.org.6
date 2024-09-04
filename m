Return-Path: <linux-kernel+bounces-315973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DE496C953
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4291C25912
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFAD15E88;
	Wed,  4 Sep 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuWgbZ3s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C6BC2F2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484229; cv=none; b=KTcmDvWTu4NnrJiVU7eAYm2uFi3Um6QafeosBnuDmr7vFXX/LXusltg60gmXGRZd8k4jo0KW8B7okq3gKBe18rDGl86WnPB+xnOrizuzU/bYnofV3X+WoEvsXw+lpTqnn8orwFhGVlxK/te8LyDnCVTbGIUPmuwUKy+oXGEIYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484229; c=relaxed/simple;
	bh=AaWK/QPXRZfLzR92qjHxzhe3iEAWiYE2gFeSf6BoHes=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sD/QOzc+6stimwPq5wRG9pUzy7SU6GBnc1FVFNlhn94vsRvuVLGan+K1Xfb2Qkv4eIP0JLjLqft/sGshWQeBHom1ug2EBFycWxJhx+UNqaDnWajaSK0lEf3XPbEPVOgyAT+tWLGg2tk0yDkifNatL8wic8pg/oyhe95/2Z8G56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GuWgbZ3s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725484226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmlDgdck4DQOj2zQLq7yI2rKc9oAlzHGpi1D8CJZoNo=;
	b=GuWgbZ3s3QOc4SLGKbWwxA8apnb+Qrllf6ab8EebkV4AN6gFr6PGW4xsAuqrd2OfS1ooyR
	2mtahPvW19cxZC84omzOJec+OX5sxfiMVg8HqtzfGkTjXh9kYf7fP365EWgW05rgX/Il6k
	p7qUWlo8Z65wf3tuWGYoIIw5uZ4+cDU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-FAt6QmIUMGu1ZGPnylJcRw-1; Wed, 04 Sep 2024 17:10:24 -0400
X-MC-Unique: FAt6QmIUMGu1ZGPnylJcRw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a5b3341a1so107339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725484223; x=1726089023;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmlDgdck4DQOj2zQLq7yI2rKc9oAlzHGpi1D8CJZoNo=;
        b=T5mNvYFGZKmhi6Trt2yB5VG8KcAhZVmqcMorl7MSbhzpxqt8EaO+hcCLn9C+SuFB5b
         LpiWd4TZU1OnvoF6xtx+6k0a0XWvh9MiWDNyOB+OUTesrd/N8M1eICGtgoaP1Bqh5z8r
         hCD81cZGwSBwdtpLnd4Td9+G5PO+pChysv6Prid0ADscSosl8bRkrf31bpkD+2Qt21jd
         OlaQ4Pbkj4Yg/Ghcc6ak/oF8dEE16CMMG9X3Biycqh9LPr8izSjiML248hkRKbUmsUOp
         3YqlJZ3fwa4TVjXreObrM4Lj9w+R4Auou2Ofobg9ypgYgoOAt6hcr1hDtogjZy6bMFZB
         H49Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQT9/lwLuXPzle8veHesKw6NIcOu2qavVXDNEHVvgkehCObh88OvwaTMeshowk30KOTkvC4xuGYDZxm8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXgMM8mVXL7cftqKPwdpkhKp97FQ2qk9BDRuLAlsgo7vutOu9J
	CU1PtHDvx5AcetlWw76oF4IBXHTzc+m7w56pmkkQTPN+wbKSeY/iupKy13x3rpoZH7/oA+mzBIa
	1kShPS43b8RvhmdBGj3bskqHNNhGjS3EVLyMpkCQZVuN2d/NykthUsCMo9mKxSA==
X-Received: by 2002:a5e:8a0c:0:b0:81f:86e1:5a84 with SMTP id ca18e2360f4ac-82a262dccfcmr1147221139f.2.1725484223562;
        Wed, 04 Sep 2024 14:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZYsadPqPXpc7RvQuadK1TsaP01DtwjD+z0URp/pH4uIMb05QskHkC3t5HSszJ5KAhNNz0jw==
X-Received: by 2002:a5e:8a0c:0:b0:81f:86e1:5a84 with SMTP id ca18e2360f4ac-82a262dccfcmr1147219139f.2.1725484223197;
        Wed, 04 Sep 2024 14:10:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a2f071fsm379684939f.6.2024.09.04.14.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 14:10:22 -0700 (PDT)
Date: Wed, 4 Sep 2024 15:10:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Philipp Stanner <pstanner@redhat.com>, Damien Le Moal
 <dlemoal@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
Message-ID: <20240904151020.486f599e.alex.williamson@redhat.com>
In-Reply-To: <ZtjCFR3kd5GfV_6m@surfacebook.localdomain>
References: <20240725120729.59788-2-pstanner@redhat.com>
	<20240903094431.63551744.alex.williamson@redhat.com>
	<2887936e2d655834ea28e07957b1c1ccd9e68e27.camel@redhat.com>
	<24c1308a-a056-4b5b-aece-057d54262811@kernel.org>
	<dcbf9292616816bbce020994adb18e2c32597aeb.camel@redhat.com>
	<20240904120721.25626da9.alex.williamson@redhat.com>
	<ZtjCFR3kd5GfV_6m@surfacebook.localdomain>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 23:24:53 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Wed, Sep 04, 2024 at 12:07:21PM -0600, Alex Williamson kirjoitti:
> > On Wed, 04 Sep 2024 15:37:25 +0200
> > Philipp Stanner <pstanner@redhat.com> wrote:  
> > > On Wed, 2024-09-04 at 17:25 +0900, Damien Le Moal wrote:  
> 
> ...
> 
> > > If vfio-pci can get rid of pci_intx() alltogether, that might be a good
> > > thing. As far as I understood Andy Shevchenko, pci_intx() is outdated.
> > > There's only a hand full of users anyways.  
> > 
> > What's the alternative?  
> 
> From API perspective the pci_alloc_irq_vectors() & Co should be used.

We can't replace a device level INTx control with a vector allocation
function.
 
> > vfio-pci has a potentially unique requirement
> > here, we don't know how to handle the device interrupt, we only forward
> > it to the userspace driver.  As a level triggered interrupt, INTx will
> > continue to assert until that userspace driver handles the device.
> > That's obviously unacceptable from a host perspective, so INTx is
> > masked at the device via pci_intx() where available, or at the
> > interrupt controller otherwise.  The API with the userspace driver
> > requires that driver to unmask the interrupt, again resulting in a call
> > to pci_intx() or unmasking the interrupt controller, in order to receive
> > further interrupts from the device.  Thanks,  
> 
> I briefly read the discussion and if I understand it correctly the problem here
> is in the flow: when the above mentioned API is being called. Hence it's design
> (or architectural) level of issue and changing call from foo() to bar() won't
> magically make problem go away. But I might be mistaken.

Certainly from a vector allocation standpoint we can change to whatever
is preferred, but the direct INTx manipulation functions are a
different thing entirely and afaik there's nothing else that can
replace them at a low level, nor can we just get rid of our calls to
pci_intx().  Thanks,

Alex


