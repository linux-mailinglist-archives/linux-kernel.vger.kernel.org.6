Return-Path: <linux-kernel+bounces-178166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 550FD8C49EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11257284D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041FB85C4E;
	Mon, 13 May 2024 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xtg3NSyi"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427784D07
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641830; cv=none; b=G6wgBVCpESveNiLF8zrEvr27ejABF0/AWZYUtpjEvWq6RMct07SMtP/WOIz481cajS9Ge7gy5WPf/62ggDWzbqTgbw9k6pMQi8ESGX1bhIro303yfPvDo6XEZUEgQac0FwxAHhcm9QezYHtoc87K0AgJepdxJD0yl5YnfETngMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641830; c=relaxed/simple;
	bh=1WDDb0G+Go3P3Dw5AcG0i87vAB3ot81JQmWmWx52LiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F63S0+Wx1L/8q9yWCLpZ4MSZ9Jm8J6H9n1CKv0ywR0xCD4tLR7FUYIu2+bgiDyslTVbvG+IrFyQhXJplJn7sm38CPQEt3F+g3YSyx5EroQsBVCcY6nbEBr37rGaKDT37NiqjjfcB35rziPQElDU4ApWXmeocDXyjReEPUmEwing=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xtg3NSyi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1edf506b216so33488725ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715641828; x=1716246628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OqUtHMhIHZ+cDddS0kGh4AWHOaBRInzG3LMW1ryk5e0=;
        b=Xtg3NSyi0/zLgwRvpPZ133zwyvtQtNFHXnutO3QFZQoDAmiP7R9/rQVFgJmFROrTxG
         ItFs/SWKMO1EKUkR3MnWGX4A+QJomvSGgGcRVPt5hLVy9ac6P9DGu43+zut7TEl5JXZz
         krB1c3vq9i29UeCRbH+f69pIhMA6ENobhzFHSqUP5pGLTij1DU7mRxmNRrND75pwo9YL
         Iox2UhA7DjZeJ4n3oN6yIOA5qcJEdlAam0kO+VrjYADFptvixeqxrT1Vbwm5oYNFPEzT
         tP5o91T0mGDKS5unZGCrG7i1INN7+7rVfKB1WTZiC/KFcJoMIntSXDFO7eSIrHGvNL9e
         CbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715641828; x=1716246628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqUtHMhIHZ+cDddS0kGh4AWHOaBRInzG3LMW1ryk5e0=;
        b=u62+x9fWp649DD67MOn12lcjTn1M6GxddZfhAoh9NJQnedk4iOLzP2hCjIPqvHOhKo
         0+UOMxva9zCds8fk8ttzIDmkcM3C8EmX5IrRGtJPVXltrkJojVzCMCykF+KnnL2QmQgV
         2KK+onkZehZ+d4xs/UXXDd/nomEtxeOAxfpslcmR+1nd3JTRUWcw/nGhR0U0PfPS3eAT
         dKn1/nNLOisyjZOwRnP1uaA6JkinFbD75dMF2JwRxjNy2NMhK0qxwPftZkRjbg9XKRrm
         JF0+yZxoxLGnAw0hTXVWfVeNS1lH1hsRUScCNns4QwSBjsp3CDh3nsHINfH8ZhAP99B+
         KVNw==
X-Gm-Message-State: AOJu0Yx275fEp7SYIx6gCBK5OACR/YKt2/ANF4GmY0TAQtXrOZME2qKg
	S0+YqQj8leFiV1MCX4/FSqVu8vVceMosDxpaZhvzxPQgD8BOt+YqrBpKtAruO2A=
X-Google-Smtp-Source: AGHT+IGYgJZTZtNiduqAOvB6Tm4M/yJ8HythCJeRBzJLhT8PXhf/vrWofASJznIm3W5oA28r520mtQ==
X-Received: by 2002:a17:902:650e:b0:1e9:a0ce:f618 with SMTP id d9443c01a7336-1ef442ba9c5mr109684375ad.69.1715641828258;
        Mon, 13 May 2024 16:10:28 -0700 (PDT)
Received: from ziepe.ca ([50.204.89.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d3b0fsm84494655ad.22.2024.05.13.16.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:10:27 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s6eoN-0001gR-2Z;
	Mon, 13 May 2024 20:10:27 -0300
Date: Mon, 13 May 2024 20:10:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	thomas.lendacky@amd.com, vasant.hegde@amd.com, michael.roth@amd.com,
	jon.grimm@amd.com, rientjes@google.com
Subject: Re: [PATCH 9/9] iommu/amd: Set default domain to IDENTITY_DOMAIN
 when running in SEV guest
Message-ID: <ZkKd49lPHj1WhBXp@ziepe.ca>
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
 <20240430152430.4245-10-suravee.suthikulpanit@amd.com>
 <20240501141737.GB1723318@ziepe.ca>
 <aacaa02c-0e58-4a0c-b180-f201f483b70b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacaa02c-0e58-4a0c-b180-f201f483b70b@amd.com>

On Mon, May 13, 2024 at 07:17:49PM +0700, Suthikulpanit, Suravee wrote:
> Jason,
> 
> On 5/1/2024 9:17 PM, Jason Gunthorpe wrote:
> > On Tue, Apr 30, 2024 at 03:24:30PM +0000, Suravee Suthikulpanit wrote:
> > > Since SEV guest depends on the unencrypted swiotlb bounce buffer
> > > to support DMA, the guest AMD IOMMU driver must be force to setup to
> > > pass-through mode.
> > 
> > You should block the creation of paging domains as well if the HW
> > can't support them.
> 
> Sure, I'll add a logic to check and block domain creation.
> 
> > But, is there actually a functional problem here? Doesn't swiotlb work
> > OK with iommu even with the encrypted memory cases? What is missing if
> > not?
> 
> Currently, SEV guest is default to use SWIOTLB. This does not have any
> issues.
> 
> However, in order to support vcpus w/ x2APIC ID (> 255) in a guest, it
> requires guest interrupt remapping support. This is achieved by adding
> QEMU-emulated AMD or Intel vIOMMU models.
> 
> In case of AMD IOMMU, depending on the CONFIG_IOMMU_DEFAULT_PASSTHROUGH
> kernel config, it would default to setup the v1 table for DMA remapping,
> which is not supported in the SEV guest (since it requires to use SWIOTLB).

But this just means you are inserting an iommu hw that is totally
non-working. I'd expect that the iommu continues to work correctly but
cannot access any encrypted pages..

If it is unusable do you even need to allow it to probe to any
drivers? Nothing works so there isn't much point to binding devices to
the iommu..?

Jason

