Return-Path: <linux-kernel+bounces-187714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F318CD70A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553B71F21723
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34F411720;
	Thu, 23 May 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gSDqsHyG"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799811711
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478097; cv=none; b=oE8S2Yan4SJerUpKGFp2gX5Wsqye42hrrvqE7V70YsElFnr0dXD0gmr8JAsPRC6ND2FeOU1eZXscJaGZW13Swc6kDvrg9JhOs32gVRad4Jm/V6TgBkND9UpQ5Gd4T4N6TFXM82dRCpr5N32/FIaOSGdbNbc7oLwdtHojMyWbnIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478097; c=relaxed/simple;
	bh=lHxOGmWdlihXCTgHVfb+T5jI7AtAtZWCWZ88p7h5se0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tns0YyyedSbQ7eBhPpPtSGhxcUSqMn/m6CbbHuiCUcwGpkgoCqxmSXqsg6KZwE97FUZgJd4D1qybHg8YBj+MvkixeoGL8VasqUECpYIasIb9FZn7mT6h84YUQ7QNCYjzsFL91Ebuu9HPZB8iFMitQ6Qw1UkMNY1Ny6P6KJMc6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gSDqsHyG; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79305314956so168577685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716478094; x=1717082894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmfyLYVCfyswQ3c7xb61Hr7O417fd5EFVF7yNKTH3w8=;
        b=gSDqsHyGsOcsBt5SvjKR7sU1nSqFoxJueeACqx5yt/MllU2s416ZjOM9lrDCh53QDI
         FFxmxXP0+D8KjGUd2EDlsNXBV7nqWQnBifaM39U6IBqXy20yAffFZ3I1qGPJP30xSacx
         xe7C/3mEB2SkSRTUqbX84uQe015fxVKlT1NdobcTwbM+JD7tQgXJ7ZqCgfOiGyFPcJwD
         iiYpFMjGd7WxGt/fzZZnn+aIdv2enMWPjI/Z8RlBL4/kRrC2L1ngQDoSNXwLGAG91sRK
         svoZamPEk2fwm54unYH9UWDYWsk+RcJrTAJVLGk/BikofGjzWdVuwh2QcAXXH0nGMEWO
         HicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716478094; x=1717082894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmfyLYVCfyswQ3c7xb61Hr7O417fd5EFVF7yNKTH3w8=;
        b=l+HcO3xcermjJxwG3An7qHjQq4qEL67qoaDeFvReC8ZCy32CdDFwUkxQowBk/umkIZ
         7M2pxs5DcaMe6TUEAbEqZnRny2QdZKdzbvztAuntDCNbqbqAnCQ6xj4v1S0le3SJAf93
         Z8eMaY909BLNGMgtBjkIJKEq8pyVRfLMVo0NFWO9lERwtq+QoAE1n/2WiORbx8qXa7/u
         BgFbrHfKPz+82IRikJ0DBBqV/hhWO270cOP17dRDFeVDynPWgGagx5hPJzbFUOgXdBdF
         oZzJJla5ikM38nI8Nh1fQm83rgDYI48d4wDWiD7vZQ1CicnBsyqntNn3/7Cle6uTmkwp
         22qw==
X-Forwarded-Encrypted: i=1; AJvYcCXoWf3EFY6CwJO+h+VYv3D6hnYDdHQhWGYUH5LoMSzemH3XD8LVSH0Iw/9l9LKic/B4Jy+miE+bkas2N/23eZurrvrKU0q/Hsa+bt3N
X-Gm-Message-State: AOJu0YxiPAz/EB5OZOLSzSsJ2MmMIPCb4V1f9fIz/zPv2W0a6Psp5Bm0
	PUBNA9bjsAVj8wtdKUnJuqUuWssn1VHZ+IHI+4/VdLMBHmr+kqVYFGFwPFUbTMI=
X-Google-Smtp-Source: AGHT+IHTBzzwi4PjhcyoMTsLG+C6xPlPNq6v4XQ9szwtINNcWYZzWlV7kEZtWT8wPy12nifAJzgm5Q==
X-Received: by 2002:a0c:f593:0:b0:6ab:8cbb:79f4 with SMTP id 6a1803df08f44-6ab8cbb7b85mr30572656d6.56.1716478094519;
        Thu, 23 May 2024 08:28:14 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab84cd6d93sm15777036d6.127.2024.05.23.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:28:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAAMU-00Frqn-OL;
	Thu, 23 May 2024 12:28:10 -0300
Date: Thu, 23 May 2024 12:28:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 7/7] iommu/riscv: Paging domain support
Message-ID: <20240523152810.GL69273@ziepe.ca>
References: <cover.1715708679.git.tjeznach@rivosinc.com>
 <1ddb50a47c86d384157a979a7475b45f807ba81e.1715708679.git.tjeznach@rivosinc.com>
 <20240522-b25680db03b547123f1cd59a@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522-b25680db03b547123f1cd59a@orel>

On Wed, May 22, 2024 at 10:07:14AM +0200, Andrew Jones wrote:
> On Tue, May 14, 2024 at 11:16:19AM GMT, Tomasz Jeznach wrote:
> ...
> > +static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
> > +				 struct device *dev)
> > +{
> > +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> > +	struct riscv_iommu_bond *bond;
> > +	struct list_head *bonds;
> > +
> > +	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
> > +	if (!bond)
> > +		return -ENOMEM;
> > +	bond->dev = dev;
> > +
> > +	/*
> > +	 * List of devices attached to the domain is arranged based on
> > +	 * managed IOMMU device.
> > +	 */
> > +
> > +	spin_lock(&domain->lock);
> > +	list_for_each_rcu(bonds, &domain->bonds)
> > +		if (dev_to_iommu(list_entry(bonds, struct riscv_iommu_bond, list)->dev) == iommu)
> > +			break;
> 
> We should wrap this list_for_each_rcu() in rcu_read_lock() and
> rcu_read_unlock().

Not quite this is the write side, it is holding the spinlock so it
doesn't need RCU. It should just call the normal list_for_each_entry()

Jason

