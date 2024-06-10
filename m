Return-Path: <linux-kernel+bounces-208673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E7A9027FA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F381F2353A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0D0148841;
	Mon, 10 Jun 2024 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="axT/7pGA"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1541422A2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041778; cv=none; b=UUOtuUKfZBbyiCZa6Io5H4BslGPN29VCWgXkdXsb8Lywnn4UfBgWltVSXqpWVY8xqfm7svvCWGYtJjT+ylgKDhmbuDkUOzvQtCBzsb5V4UbxuVqDAGEUt0gRB3dH8K4Qli7E+6+akdtHbJeDNb6vnqQoIHSJHP24j4YyyPB6Mgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041778; c=relaxed/simple;
	bh=iOCQA3gFhsaGFrQM1y+O+3mLLYJQ5KrPcSjHAx+iK2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtUDxi+BpkeA5vaJ1lFwyNP3odSrdMGocpFkGJoCltlR4NwEVdOQd+a564FcI8jMtbJec4dMjJ4kzxxdcnDQD+NdKJz42IywnCQyqs6VE2/uM96C/UTPHWC5WHitG5K4bMdo0DYRT3e7/exIA+qOwtXwXx9+4EJvjvqRa87ZNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=axT/7pGA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-62a0849f5a8so46528197b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718041776; x=1718646576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLnQ2l5LC4vBk1KAktpJMA8+PgPoixo2FswnJOlP1yg=;
        b=axT/7pGA2KuK2hmbj9U2tGetDxGEFcgntD6ROfNX7iatlqMW33wmcsZZEPxtq1PaXA
         37gaRouVg3yZZuOOnwh9n6bnMYjJNn+cnRbuW9AmCJusoGIEJDCLEACN0yCiHOsIGovQ
         YBftl/ag4CTDFHsKcv4db06QKFhPMo2siXIIX8xKu0fNBB4wVo8hDttdH8b96m63inEk
         bizGbAi7MIEO+QO2U5nkoILiheGJrSkGVWYP+0eTR3EEC4j5oaoOqbDR9Nz6G1GtblHT
         79NVNv4OgPuCCeLFzuTK/7RN4M2gS/LIzqyPYrzzzhuyyR/x/g9vRYT1EopZgEiAD4iH
         KSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718041776; x=1718646576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLnQ2l5LC4vBk1KAktpJMA8+PgPoixo2FswnJOlP1yg=;
        b=mT8XwFD45Q7Qm+FVuKHG9sOFmzJqd9fTYZMPKaX5GkCOvwlXPcSIt9v54KboMfLF85
         SpuMgxkq6DkDKmm7u3IAgIgDCupBTI38vEkRY5ioLaFWHJ1J8rho097fQXfFH01SEujV
         XsEmDtIaiTb7F1GVl3fwFPEcy98fqCIrjw8GBzpKCZO/d1TmHwU7kZUZwwMUWQJn/lWz
         8LP6t3Qz9F3Nkh9ex6JftO5fQM1+AaTFKw4eEB4kNk2Uxrh9eAw5FyiBZAhNfy2Kha7g
         3S7ssCdGX1mLpYb0cnM05L9McpWWsPn7L5NdkPXd9Y7168QeyPya2KlzCVjrBPEC3NMu
         87mA==
X-Forwarded-Encrypted: i=1; AJvYcCWEBkhHvHwC6cTna56BxfbEvnTBctAIYPj/LpRMe0g8lBaTWbeISrwf23uOaHj2Nsk4P3zvIOMvYvA5+vj9JAxFKHqx9woPAcuuujV8
X-Gm-Message-State: AOJu0YxbbKyVcLYLeCGwNs/5GJfK/2G7toM/+Ej7sHXWZkG//ZGBNgB0
	ox5S9tfk3zkSY4M32ou9kP6s4s36Edj898WZbpklIva2ZJvQ7k2J2R4x8Zbuddc=
X-Google-Smtp-Source: AGHT+IFe8OwLGzvnbALaK/BDvvOAZwFQVf4gWc79kKkP946QP6T5IhIBj387LfKTGJKnPwAn+7jYYg==
X-Received: by 2002:a05:690c:72f:b0:627:7ff0:fb4e with SMTP id 00721157ae682-62cd55f3aa3mr88716287b3.26.1718041776199;
        Mon, 10 Jun 2024 10:49:36 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04fa1a628sm48037996d6.136.2024.06.10.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 10:49:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sGj9C-00Etv9-1y;
	Mon, 10 Jun 2024 14:49:34 -0300
Date: Mon, 10 Jun 2024 14:49:34 -0300
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
	Lu Baolu <baolu.lu@linux.intel.com>, Jim Shu <jim.shu@sifive.com>,
	Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [PATCH v6 5/7] iommu/riscv: Device directory management.
Message-ID: <20240610174934.GM791043@ziepe.ca>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
 <e18ec8ac169ae7f76e9044c26d0768e6469bad19.1716578450.git.tjeznach@rivosinc.com>
 <CANXhq0p4gERQeROSCSKqxnRZq9-fGfmROGV8JZyqFaenNpnsLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXhq0p4gERQeROSCSKqxnRZq9-fGfmROGV8JZyqFaenNpnsLA@mail.gmail.com>

On Fri, May 31, 2024 at 02:25:15PM +0800, Zong Li wrote:

> > +static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
> > +                                    struct device *dev, u64 fsc, u64 ta)
> > +{
> > +       struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +       struct riscv_iommu_dc *dc;
> > +       u64 tc;
> > +       int i;
> > +
> > +       /* Device context invalidation ignored for now. */
> > +
> > +       /*
> > +        * For device context with DC_TC_PDTV = 0, translation attributes valid bit
> > +        * is stored as DC_TC_V bit (both sharing the same location at BIT(0)).
> > +        */
> > +       for (i = 0; i < fwspec->num_ids; i++) {
> > +               dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
> > +               tc = READ_ONCE(dc->tc);
> > +               tc |= ta & RISCV_IOMMU_DC_TC_V;
> > +
> > +               WRITE_ONCE(dc->fsc, fsc);
> > +               WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
> > +               /* Update device context, write TC.V as the last step. */
> > +               dma_wmb();
> > +               WRITE_ONCE(dc->tc, tc);
> > +       }
> 
> Does it make sense to invalidate the DDTE after we update the DDTE in
> memory? This behavior will affect the nested IOMMU mechanism. The VMM
> has to catch the event of a DDTE update from the guest and then
> eventually go into the host IOMMU driver to configure the IOMMU
> hardware. 

Right, this is why I asked about negative caching.

The VMMs are a prime example of negative caching, in something like
the SMMU implementation the VMM will cache the V=0 STE until they see
an invalidation.

Driving the VMM shadowing/caching entirely off of the standard
invalidation mechanism is so much better than any other option.

IMHO you should have the RISCV spec revised to allow negative caching
in any invalidated data structure to permit the typical VMM design
driven off of shadowing triggered by invalidation commands.

Once the spec permits negative caching then the software would have to
invalidate after going V=0 -> V=1.

Jason

