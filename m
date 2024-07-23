Return-Path: <linux-kernel+bounces-259988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2C093A0E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9284B1C222AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3121B152799;
	Tue, 23 Jul 2024 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cHzY8bvy"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D6152196
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740123; cv=none; b=KXLJvmWyO33hJ4hjf39XsFPMfHrj6coepi/17V4SrHnypLFXamkJHhamXxHKkIpkzJyenQP4H96Gid3GjgQ0DPI63O8cYyPka1YduBDTXi3qHMh9Zqu6HLN1mGmnWCGO+k7Eo+hotzp5AwfhZQiH25ygux8Cc1BY+nxmjLDy4Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740123; c=relaxed/simple;
	bh=anpGqlaJTd/4YOCYRdZXnrrSVEHn+JR0BCZ71ULmuWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgOsrs2mhgIOtBWRmHmE52xDLhf28FQRZPXZ+bJ9BqVpBfk0qbtSKTr8bMVn2KY15qT7aKcagW3ICzfWjdz/NhPOhY6HKUuPB8avvw1Ikaj0ZMW9h7Y4MXMtKEnDAXGn2BPqjOKjqJ+HjLupGQXmUc9uuiotRpEl/OXnZXdzxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cHzY8bvy; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44931d9eda6so40994021cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1721740120; x=1722344920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+axTqVsfgDHJ4ABgdOvxQq1+BYfsc3vDRLQbJOeOOAo=;
        b=cHzY8bvyVqpl0LW0PFjYaUURfjRlSxwe/6IG4/7+eN6fHiwP6LT5H/3eN3/dQvVZwN
         wHgXN6+kp29/R7zuJaOLADMReVNwLohXIHG90Ql+3N5KL64cPR1qMRD7RiYHjTQH2OLr
         o0/qSXlVhrBMh95GxoFAjAqIoru4fX6jpyv7+wCjGrE/icHH7RYS28apSruhI+pA7Ilk
         eVe0cq8WcGvX0lDnEaUfp3HZ43160veL3vWzaBqaGeyZ6qtVHAOCTl1+e48hlfM/nVoI
         ks+2agPbdnB/qz/jQt+J0DlHl2+NDzGdQ5Y1GTJS8hfGYsipeGC3ZjFpfvAypkXJwkEa
         TgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721740120; x=1722344920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+axTqVsfgDHJ4ABgdOvxQq1+BYfsc3vDRLQbJOeOOAo=;
        b=UwdpBeFU7PQjxN3xvboGUzga99W3uSxKA3nOJA9bo2W9ACudLjd7k7lS4CXiq92vKK
         NlRJ2qtR6uNdaG1pQepODdG/2JdBRWfjlWH5k3ldFmQqCGQcAnu0J10cloWaGbaw0J1h
         1bhcWWPRmoiDt+JePxTBA/jByp6qTTkiOPp9EzM2xyu1e5tR08WTa3LZ8FqCgPx3itwn
         LRskAsP7HPZAuVEyDHFiFiCXcT3VAxfihUR3SIgSvpKIt3qP+RKVLP8/Ce7JLOVwKsox
         EntTT7EfjjEW5CXLeMF0xc2G2Je8tWgNoea2vBNkQbBoS+hB6o296QrFtIQHa5xROFJp
         4bBg==
X-Forwarded-Encrypted: i=1; AJvYcCVY6iD5fHvwR+1KNQQ0L6Jts9SD/G/hWkovara3ieeJ3k2AiBbN8Wap2ayKw/hqpvkc/IydJSWXJxISfKgVSl7/tOq/Bad8bORqDpLv
X-Gm-Message-State: AOJu0YwSaJNygdtnG952sfznzhVaf1hoX1Ug7YpvBD9RqoWXY3TEo+kU
	e0yYcivDxaD5XuHIiJNTxPKyp6RAcrSKg4tg/lqZFAHG0brcyfCgXAQmisYLqSU=
X-Google-Smtp-Source: AGHT+IFdiAXbdFdhLaoPZtxacfRA4jPBGSoBhjNyXiB95amXvNCVw1j1puDQQ+mYwJ3alK8exv17nA==
X-Received: by 2002:a05:622a:ca:b0:43e:1231:1040 with SMTP id d75a77b69052e-44fc7fa8970mr35543231cf.20.1721740120332;
        Tue, 23 Jul 2024 06:08:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd3cfccsm44348711cf.54.2024.07.23.06.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:08:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sWFFv-003hHI-CL;
	Tue, 23 Jul 2024 10:08:39 -0300
Date: Tue, 23 Jul 2024 10:08:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v8 7/7] iommu/riscv: Paging domain support
Message-ID: <20240723130839.GL14050@ziepe.ca>
References: <cover.1718388908.git.tjeznach@rivosinc.com>
 <bdd1e0547e01d012bf40c5e33b752e77c6663c90.1718388909.git.tjeznach@rivosinc.com>
 <CANXhq0rpX=+YZLfzLcBmHPUxBpo+xWPY9XaNkV0eQAX72KCFKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXhq0rpX=+YZLfzLcBmHPUxBpo+xWPY9XaNkV0eQAX72KCFKw@mail.gmail.com>

On Fri, Jul 19, 2024 at 02:33:13PM +0800, Zong Li wrote:

> > +static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
> > +{
> > +       struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> > +       const unsigned long pfn = virt_to_pfn(domain->pgd_root);
> > +
> > +       WARN_ON(!list_empty(&domain->bonds));
> 
> Hi Tomasz,
> I recently hit the issue here when I removed a device. I think we need
> to unlink the device's bond in domain before releasing domain.
> Do you mind pick the following modification in this patch? Thanks.
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 859cdd455576..f0707147e706 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1541,6 +1541,8 @@ static void riscv_iommu_release_device(struct device *dev)
>  {
>         struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> 
> +       riscv_iommu_bond_unlink(info->domain, dev);
> +
>         synchronize_rcu();
>         kfree(info);
>  }

That does not seem the right place to put that, or something else has
gone wrong becuase:

> >  static const struct iommu_ops riscv_iommu_ops = {
> > +       .pgsize_bitmap = SZ_4K,
> >         .of_xlate = riscv_iommu_of_xlate,
> >         .identity_domain = &riscv_iommu_identity_domain,
> >         .blocked_domain = &riscv_iommu_blocking_domain,
> >         .release_domain = &riscv_iommu_blocking_domain,

The above use of release_domain will attach to the blocking domain
prior to calling release_device and when doing so everything about any
previous domain should have been fully cleaned up.

So info->domain should be the blocking domain during release_device
(if not that is another bug)

And attaching the blocking domain should have cleared the
domain->bonds of any prior paging domain.

Jason

