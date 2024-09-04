Return-Path: <linux-kernel+bounces-315512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A796C389
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA43283051
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C861E00AE;
	Wed,  4 Sep 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="murfCdeO"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6071DFE2A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466231; cv=none; b=YfkUeq6VWsfKkbPJpOJq560TLUhLUhPFRhdv/RZRGjYp8QKxRr1lgXf1X31UrXyPuMxE4rSAchFVExrT72uq9HXMc4D60ZftkCkRXMubWHbXy5n6NEd6koybC/EekbRNQt2FKJoeNuigF67DzSeV1GZnfgNwJ0REhnn8YH9HwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466231; c=relaxed/simple;
	bh=LrvtrkWRerWnfI0vNYGrgLvyh/+JTim9O7/36OuYxtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWltXPoG8RUDvIRwlDIf5k0chmPUH3NilruyCsDLCNIlbr8kj+/9jnm0pDAW9T3lnas3MnAzfoY4pIWE1xt9KvYLF7kH4Hluc7h3i9WyrQjOV7yuSbyajLqEMmIPqS0qy1Hrj40Z3Z0Hl7yeNEM2GEJn2FqhCMNmhcDRnZgiY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=murfCdeO; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4568acc1ca8so31701311cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725466228; x=1726071028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LrvtrkWRerWnfI0vNYGrgLvyh/+JTim9O7/36OuYxtA=;
        b=murfCdeOvOQ9h4NW2hG62WBuZ2LdjQcE8w/y53yPK62AlrleXgyqyA/p7hvMqqWnVB
         1p4w3m02sP2I+RJAegUUD2LRv5eLLPy4qdZexioegiaBZ+RF/41zquLY5McH//rsYqQI
         KeCjmc040Qse5dCVPZy+h0Xw8LPuSUygdjR56AB+wJ4JB8+0FWp67ota8VwIbqSwXf4P
         jLYJ2xT3alWGcijigIzHeWH33LwgZzO6/A7gMHsrzaeSFJ7Qvkazi/qkhjwDrglncZcb
         goUS29AenwU0z99vdPdZsTKofXBLuCL6eZrazOnZ+lRIL3Ld8kCO5o80/2fYJFmHKdq8
         A13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466228; x=1726071028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrvtrkWRerWnfI0vNYGrgLvyh/+JTim9O7/36OuYxtA=;
        b=CdiDNYbX6dYSYracsR2jJF/ZBwbApdQTjtuP1B7krE0EFVPFcPIyeBMDtGVkFS0DfT
         MJ6uiD/+ME50xjd8QujFoCCCscb9oIrTr/ruLUluGhHw2VSDb9HYJ1Cyl6IYDi0BHS/3
         ZoZQ8EeshZxCi0tn36zIQoOgUBjnypicNFtqMCbpSPASmFLpODQxYwimPuEI7eI2bOwz
         iRBiaPt6gRoaHhKzYqCz6AkKo4pWPTQp0WA4Z8Hsn7UxvtPwFLGADnC6yezSOMAtE+g1
         ImpY8JDdBhxq1aRoqORsWgl7KdVMV/aQBmLhlfQziDEIWhUInU3IRM2fBb81+obXehBO
         l40Q==
X-Forwarded-Encrypted: i=1; AJvYcCVy0Cd2Isl7uuYtQebi1mHm4hi8+psyRDFUCoesD5XNC2vMmdjIdB9fGhkYuIg6iCpdjAX/Hsa3Kx5AyK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwevQHvaYE92gk43xlhorm6bhkgcRNCYGmOip5D1olgLNaDNSxo
	WDvWYYpqWzQUmo6hqfxfW2eVOpk4cpCMzGJ91NjdvCJbyEoCGs35ongUYC+d8aLkOx/DDbzLBDm
	x
X-Google-Smtp-Source: AGHT+IHK4NXjBOWUCjPvBi2kpRLHdj4b5nBYnVLrUwbShKXuSggGV0DYJ+x4RGFMamYZLzah7RbD6w==
X-Received: by 2002:a05:622a:5109:b0:456:7d0f:f426 with SMTP id d75a77b69052e-4570540f463mr152174381cf.52.1725466228062;
        Wed, 04 Sep 2024 09:10:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682ce5b05sm60158851cf.51.2024.09.04.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:10:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1slsaR-004kUs-1e;
	Wed, 04 Sep 2024 13:10:27 -0300
Date: Wed, 4 Sep 2024 13:10:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd/selftest:fix a resource leak
Message-ID: <20240904161027.GD1909087@ziepe.ca>
References: <20240903200806.9803-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903200806.9803-1-liujing@cmss.chinamobile.com>

On Wed, Sep 04, 2024 at 04:08:06AM +0800, Liu Jing wrote:
> If the file fails to open, not only return return1 but also close the file descriptor,otherwise resource
> leak will occur

Why doesn't FIXURE_TEARDOWN do this?

Jason

