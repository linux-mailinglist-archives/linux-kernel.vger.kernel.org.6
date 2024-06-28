Return-Path: <linux-kernel+bounces-234731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A15C491C9E1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B22D2839B7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886244C8C;
	Sat, 29 Jun 2024 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Iu63D/5n"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730BEDB
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 01:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623507; cv=none; b=tErpAyU0LLOTOLy76DXN3v65s+saVnxweuyLSEmHjD2zEHsbzzAxPhRgSBcNQCeapnBBrE2Ynsf9HOn5ITvJYZURB63mQ7sT8UviO5ub8nJ+3mxkZlpdfb8E3Wh9nAxKEeU3Chwa1OT/TnfEmPA644g8NyzzN77wv/VEBnZgiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623507; c=relaxed/simple;
	bh=72PC3BPohlG0iiJyFw5nm5HiJEroK/w53FDUnjeE4F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJq50dhTJuECcVKbK7RQBsQGpcKdJwkUZ9TypI6DrOXy14A9nJ46VZw64ec4zSwY5HjfVhxvC5cASjbVK+lPCo4R63n4YhTEm3rEAOwOziCtYpJ7BQ/1tXJPG+1LUgWl4m8bg707wiSg0aj2ut+tYy4jdoBu4gtYV+vTHUmRH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Iu63D/5n; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7067435d376so869245b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623505; x=1720228305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsoLsLBS6AWLToaBUgOlVBtvPTidK4aikxWEMjAfiw0=;
        b=Iu63D/5nUIgD7TvQwTQKMeX4CBZ/3jyNY9w/rX9hSfOydCATk2OXqESoGKaLHDwWiA
         Lm55UttJfdXWkKuknVbkMijY7Ef57/5VCpsNyIodMvsAuR/Bbegq7g5SgcIIeUI+pref
         Jt0co+2n+fJaZfpIPklB3V1eBodfQYQTjuCT43CZ3GPUYhY+pU9T1S41EFYH42H88knB
         UOzANJ2Yt37bVGdcY/nMehPV1L+wMTp4i8Y0Q6Q6yQbQNX6fMWLa0ZGU0gzpOhEW65M2
         0jfh3g1rHFJNKlzL/BSkbOqirqCnDjIUZF93EPVTqq2bfybIfI2yHOcTsVpzVEnQmDPh
         Xw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623505; x=1720228305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsoLsLBS6AWLToaBUgOlVBtvPTidK4aikxWEMjAfiw0=;
        b=q6LnnQ2JznnqwepCp+fnrv3ZGJkg4wNnwJX2rveeN/Iy5rSe1zD4KzKuJh2hwAPPry
         TNoEjtd4VV0TJBkJ85SuEYXK6fIXfpTckwKgkJhEkIBBop2BZJFTY0CqbcBEqxVMFol6
         lVKBK89lz7SnHhR6v0fmQJEjlnO6qKHsRktzDpnTGQ5cCnJVXWNS/Dc9pESgztiMEnEJ
         WLT49iETbQ056PfvMW2SpIHGXy0/n1lhYaIApkiz+59/xD+S5kMaJkz83SKuS4Jdlwfh
         9+Nh56/piSGGXcmapxXv6+x5Rm7lFel7JA40DaKu1imATR91PPP6ubvtiFjHhto8skk0
         nOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2f2A8E0x3LvuDJVFBZ6nnbAKIH/Bedqi/2VOrV9WFBSzpIazDxqug2BtmQREbJC7bYYK5tDUA/F8ERwqVF+ji0MEAOc/F+scRezst
X-Gm-Message-State: AOJu0YxHf9RyDdyL4CXNlgOlJTQ6+dF7dggmUHZCdzd+fx+QMn8ulgNK
	iNta/A0oRxVQCL9uGPeQjxo/4e+vUdfEMoPVocu0GptXHLPysSjaF5DhHltNWBo=
X-Google-Smtp-Source: AGHT+IGCN6aa6Qe8gHQG9Hq0ONeW1TMgiLD0kMLyYmKolWs0bnwTa/i9nPUQ7jMeYAfEUM+zT4NvhA==
X-Received: by 2002:a05:6a21:6d85:b0:1b8:27dc:10c7 with SMTP id adf61e73a8af0-1bee4910b47mr5469407637.12.1719623505492;
        Fri, 28 Jun 2024 18:11:45 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:44 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNK2g-0004qO-1B;
	Fri, 28 Jun 2024 19:26:06 -0300
Date: Fri, 28 Jun 2024 19:26:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v2 08/10] iommu/riscv: support nested iommu for
 flushing cache
Message-ID: <Zn84fnUs3UtZ2vrM@ziepe.ca>
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-9-zong.li@sifive.com>
 <20240619161740.GP1091770@ziepe.ca>
 <CANXhq0pgQMHGVv12K0s9ovd0OkOa15QCdH4HMfZGCy5hYXSWMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXhq0pgQMHGVv12K0s9ovd0OkOa15QCdH4HMfZGCy5hYXSWMw@mail.gmail.com>

On Fri, Jun 28, 2024 at 04:19:28PM +0800, Zong Li wrote:

> > > +     case RISCV_IOMMU_CMD_IODIR_OPCODE:
> > > +             /*
> > > +              * Ensure the device ID is right. We expect that VMM has
> > > +              * transferred the device ID to host's from guest's.
> > > +              */
> >
> > I'm not sure what this remark means, but I expect you will need to
> > translate any devices IDs from virtual to physical.
> 
> I think we need some data structure to map it. I didn't do that here
> because our internal implementation translates the right ID in VMM,
> but as you mentioned, we can't expect that VMM will do that for
> kernel.

Yes, you need the viommu stuff Nicolin is working on to hold the
translation, same as the ARM driver.

In the mean time you can't support this invalidation opcode.
 
> > >  static int
> > > -riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_arg)
> > > +riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_arg,
> > > +                     struct riscv_iommu_domain *s1_domain)
> > >  {
> > >       struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > >       struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> > > @@ -1663,6 +1743,8 @@ riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_
> > >                      riscv_iommu_get_dc(iommu, fwspec->ids[i]),
> > >                      sizeof(struct riscv_iommu_dc));
> > >               info->dc_user.fsc = dc.fsc;
> > > +             info->dc_user.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, s1_domain->pscid) |
> > > +                                           RISCV_IOMMU_PC_TA_V;
> > >       }
> >
> > It is really weird that the s1 domain has any kind of id. What is the
> > PSCID? Is it analogous to VMID on ARM?
> 
> I think the VMID is closer to the GSCID. The PSCID might be more like
> the ASID, as it is used as the address space ID for the process
> identified by the first-stage page table.

That does sound like the ASID, but I would expect this to work by
using the VM provided PSCID and just flowing the PSCID through
transparently during the invalidation.

Why have the kernel allocate and override a PSCID when the PSCID is
scoped by the GSCID and can be safely delegated to the VM?

This is going to be necessary if you ever want to support the direct
invalidate queues like ARM/AMD have already as it will not be
desirable to translate the PSCID on that performance path.

It will also be necessary to implement the viommu invalidation path
since there is no domain there, which is needed for the ATS as above.

Jason

