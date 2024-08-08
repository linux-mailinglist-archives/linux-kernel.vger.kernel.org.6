Return-Path: <linux-kernel+bounces-279516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635DC94BE47
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB3F28D333
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E26818CC05;
	Thu,  8 Aug 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LMfCCbHd"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7091A18CC08
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122877; cv=none; b=Z0/SEFQW2gSmH2/3Qmp2KT3W/CNHpiWqnayh3Tp4STP2geTZ+pydMrfd/mVwQzNEHGdcucCuJyTPnEVqyC+SVnijI0qIkuhNkOLYarga/r5qx6sJAjfFBKi/fKRpArDu7fnTZZtwUWDk0n2b40vlO/muJjfXkEbRtijO/VNe1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122877; c=relaxed/simple;
	bh=9BcU6Etuy+F9fzT7V09q69yexo+bi/TCqSACAPExzgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWrSJKgXo8MWlowZihD5nqFIB8mkbYgvQVCiBFeeUoJS9ioyDz84ibNZZoPYJMUBEyL0zoCx91MClQ7U443g2fQmhwmViAM2gi03WQutGe/PSu7i8MJWavzm1DzWxlESkgZFBCivPFpeJWd0JFLWZv81hGtMe0eoBht3LooCNEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LMfCCbHd; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1dcba8142so144996885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723122874; x=1723727674; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dgXGNnW/b5f9t+CKB4b5Vyo8s9dDJsUrC85u/qccVjs=;
        b=LMfCCbHdM6018lHYcjvO3Lnav0zhDzfwjKvtcVnYWWTzv86mgGtYDKPPOkR+gx0xhc
         278dURVA6wklEgv8Wm0JoSb30DSW4rTTU8i4/pt9+6h89sXa2X95u+6KSJCh7tnWUGka
         7AvMld6bgy9lfZFlUNNRK+ns+dH5axv9GJ3hRob6UryMXtvo4xgYPRQLS3Sdfk1nzG4t
         yuCBKeuLsxbUdNSQ9aNt/R2rohPc5G0J3604SaUs0IPPMsqAm0rsi/gUXI33aSkw6alt
         1OfuFuGScqMWBKcd7XMPBckCS0EPlaNILiOLtQV2wZzHDXdmDVISTZYq5lmBkXt2vRx3
         o/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723122874; x=1723727674;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgXGNnW/b5f9t+CKB4b5Vyo8s9dDJsUrC85u/qccVjs=;
        b=quh2Aje5aF+f7PjJLlGT4uo1/ntf570e0LCaZcLii5vXA9aIamM5QcAAnlCtWZao+D
         xPozTEgzeNncfTG+Ip4nhjRyImqSCFc2e80gDgWJw11BRQLXJHBDE1JweC6UMJIYmTr9
         jE2NRx7dlQ7vAgLW9rw53NHIOB04Pynu7Di58a7viwpsmm4nTZwX624y0ahtOsYI7vNJ
         VvxMR4kazlFjM4pHiDfa++dfd9aaS1KDNrrJC9/mTU5nOvkvB6ajR1LBbJ+/CoB3TJfD
         z5Jdyxl9VEjcAgPVf4FkmjKKZ+h5zap21pddsYLwWTqJ9FV90HwBiBsFAsYNCzWj825n
         FXSA==
X-Forwarded-Encrypted: i=1; AJvYcCVEZ5ZcL6T8gRelvkq9YCBMqJCryNZfZ2aiQFhw6ueGhNuHkJFPWW9czdDKJqDQrizZ6wvMTbWEKpf69QHxbWyTEQa04dEh091q2pFH
X-Gm-Message-State: AOJu0YwCAMjd5nwbwzayAOm121MkNbxfW8+Jez1qP7a5yXkLegthJNxl
	suLSmoPR6DmzlFiw89wZEC39crNjEoU8NgSD/HIkTYc9fD1HcpkBTdhTDYppK0c=
X-Google-Smtp-Source: AGHT+IHnezL7bVQyZ4vj2ahY4vzl5lMTpzGek5s6d8TdzvnwI8VOuUhjJYFi4WFfdbdI8ZW2URnzyQ==
X-Received: by 2002:a05:620a:4612:b0:79e:fec7:d6e9 with SMTP id af79cd13be357-7a38278a9a4mr249030285a.32.1723122874374;
        Thu, 08 Aug 2024 06:14:34 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785e5744sm156520485a.51.2024.08.08.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 06:14:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sc2yO-008v8L-5V;
	Thu, 08 Aug 2024 10:14:32 -0300
Date: Thu, 8 Aug 2024 10:14:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com,
	Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v8 7/7] iommu/riscv: Paging domain support
Message-ID: <20240808131432.GB1985367@ziepe.ca>
References: <cover.1718388908.git.tjeznach@rivosinc.com>
 <bdd1e0547e01d012bf40c5e33b752e77c6663c90.1718388909.git.tjeznach@rivosinc.com>
 <389da90e-df78-4ea4-8453-ae2080a68956@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <389da90e-df78-4ea4-8453-ae2080a68956@linux.microsoft.com>

On Tue, Aug 06, 2024 at 12:24:40PM -0700, Easwar Hariharan wrote:
> On 6/14/2024 10:27 PM, Tomasz Jeznach wrote:
> > Introduce first-stage address translation support.
> > 
> > Page table configured by the IOMMU driver will use the highest mode
> > implemented by the hardware, unless not known at the domain allocation
> > time falling back to the CPU’s MMU page mode.
> > 
> > This change introduces IOTINVAL.VMA command, required to invalidate
> > any cached IOATC entries after mapping is updated and/or removed from
> > the paging domain.  Invalidations for the non-leaf page entries use
> > IOTINVAL for all addresses assigned to the protection domain for
> > hardware not supporting more granular non-leaf page table cache
> > invalidations.
> > 
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > ---
> >  drivers/iommu/riscv/iommu.c | 642 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 639 insertions(+), 3 deletions(-)
> > 
> 
> > @@ -856,7 +1473,7 @@ static struct iommu_domain riscv_iommu_identity_domain = {
> >  
> >  static int riscv_iommu_device_domain_type(struct device *dev)
> >  {
> > -	return IOMMU_DOMAIN_IDENTITY;
> > +	return 0;
> >  }
> 
> <snip>
> Sorry for the drive by comment, I just happen to be in the nearby code
> context.
> 
> Nit: It may be better to use IOMMU_DOMAIN_BLOCKED here for readability
> rather than the bare value.

It is weird and confusing, but 0 means "I have nothing to add" not
BLOCKED.

You can't return BLOCKED from this op right now..

Jason

