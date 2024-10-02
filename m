Return-Path: <linux-kernel+bounces-348139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6703098E335
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEAF286C67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66106216A19;
	Wed,  2 Oct 2024 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VYeJxk1L"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56E216A17
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895324; cv=none; b=E71Uv5HmsfxXcaYYIkR/k/uxT11mJeB8YdZlnwQdKHbn+5oJggoHj3OdbLEW7GhShmExTE65AMj+SYSUE+2Y3E9NURVdfoXvrqhhR/fDbyLmOOLUILKGsSWy+ND3RpPgvodGc8bD5KT3l5vp/5kz3z05UAnu6P/G45otcT5iipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895324; c=relaxed/simple;
	bh=0ElWqU503cDmthQrkETKoibn+yxrDRTlI0NA4DOSxVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgHWHqIcpSr/MpkrnHQa8TCLDbMfzqtvy63zYzFNmUNgW8SJktcKw/wrFc35XV1KYkBNrqZJ1MNGYHZ88dyRMQR6iIKUmcWZnIubKD3fd75yQ4iT6FPlLM7kQXc0uDL+XIY5of1xkKxSPiQQqBOxks7BqzsiqKVXPMzX+1ajuWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VYeJxk1L; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e25cfe70b37so130079276.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727895322; x=1728500122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ElWqU503cDmthQrkETKoibn+yxrDRTlI0NA4DOSxVY=;
        b=VYeJxk1L6Smd6iHmZ08M4AKC6KTz3GEIw9WBw8D1yfw9EtwO/bvbZ4zSY7WhkzjThf
         zsIxy91GCL/4ZtdHCSfcB+YTZFMzKzyVRerXw2xxrMnO7Z7daTXZODNvhBcD5jdh+tNW
         zagH9R39VAH0qQzqAmthVEC7Emon9OtEP5FqD0QbvooZ8G3+C/HvS2LmUAPNfLXj5Y8j
         FXSDEjqCbggq1rmB1amKimSj23dBuuszFCeRIQUM+MBctu8nx1gTBjgcLzBW9Hs5gxlY
         jwI0sQZhAWmOh5+23lE+rnm+bu2mDgHZjQX/uJ8Ie8wzJvWXt1KYJgozTVNlHbnMY7+o
         kK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727895322; x=1728500122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ElWqU503cDmthQrkETKoibn+yxrDRTlI0NA4DOSxVY=;
        b=FvDz8dT+mUH5eyLBW0Sq002DYCEEjPU4RoF2zRDyjK37Ofxl+lJ1XDcoQ0sMbqHtB5
         cXsEBfObS2Cy3f0NSuIkKJEJSLzvMUrDR2hgFn6F6LByz8D/i2FSKNW5kIBX+tG6tgT+
         VEoOgzTm2bBZeOJgIy0d7EozC3iIUUHPYlTGS9x04bk4JEFiSX4sKc3KNaXXMIAv4bfM
         eR4OPI67QLmdeVP/7+aXb9lKT4XQlcSys0DYtfbaxW5l402DCkW8H4u0JcjGKOvt/ECD
         bZIQCgm09RCd927JepM1bidhbpDtRexizP39D/uln+x77aGBeRTXWouJtwtcoRRnLAFS
         wh+A==
X-Gm-Message-State: AOJu0Yxgr5mq+viRLx/p2SDE+GUC2M8G7TivNgDDCwesc9DNOaNxu7Bo
	JjrNPLAkeFXZbMgW3NU6l7eiGHEvKcY8DdQ5DDKjWOmgXcEx1tcgLWdCSUyNSDg=
X-Google-Smtp-Source: AGHT+IE/4YDKGNMGbzf1cBV3ciJ6gTYpbDOAXQ+3Q/QHeGIUP/Ee9BC7INUAzJEGFa5vHK8ha9AvWQ==
X-Received: by 2002:a05:6902:1002:b0:e20:268b:8ad0 with SMTP id 3f1490d57ef6-e263838509amr3699684276.5.1727895322247;
        Wed, 02 Oct 2024 11:55:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d74dacc1csm20873031cf.36.2024.10.02.11.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:55:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw4VM-00AAFG-Sb;
	Wed, 02 Oct 2024 15:55:20 -0300
Date: Wed, 2 Oct 2024 15:55:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	iommu@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Alexander Graf <graf@amazon.de>, anthony.yznaga@oracle.com,
	steven.sistare@oracle.com, nh-open-source@amazon.com,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>
Subject: Re: [RFC PATCH 05/13] iommufd: Serialise persisted iommufds and ioas
Message-ID: <20241002185520.GL1369530@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-6-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916113102.710522-6-jgowans@amazon.com>

On Mon, Sep 16, 2024 at 01:30:54PM +0200, James Gowans wrote:
> Now actually implementing the serialise callback for iommufd.
> On KHO activate, iterate through all persisted domains and write their
> metadata to the device tree format. For now just a few fields are
> serialised to demonstrate the concept. To actually make this useful a
> lot more field and related objects will need to be serialised too.

But isn't that a rather difficult problem? The "a lot more fields"
include things like pointers to the mm struct, the user_struct and
task_struct, then all the pinning accounting as well.

Coming work extends this to memfds and more is coming. I would expect
this KHO stuff to use the memfd-like path to access the physical VM
memory too.

I think expecting to serialize and restore everything like this is
probably much too complicated.

If you could just retain a small portion and then directly reconstruct
the missing parts it seems like it would be more maintainable.

Ie "recover" a HWPT from a KHO on a manually created a IOAS with the
right "memfd" for the backing storage. Then the recovery can just
validate that things are correct and adopt the iommu_domain as the
hwpt.

Eventually you'll want this to work for the viommus as well, and that
seems like a lot more tricky complexity..

Jason

