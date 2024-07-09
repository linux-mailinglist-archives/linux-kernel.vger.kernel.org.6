Return-Path: <linux-kernel+bounces-246465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513A92C244
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4CF4B2BEE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15181B86D3;
	Tue,  9 Jul 2024 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LKMXvWGc"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A41B86CE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544443; cv=none; b=pmMkri3RnumxCeEE2elGAchZ/LSDiWhQRUpTVC3Cq0IrYw3kxA7PR1k5qyjtnbm5ZJW2VxCpCoHC0Z9Q8StJBsiiVcwGLfDP9MEEZZJ2YE3dSftycQYG0ShnDPZB9xmilQFXSWkwwAMEs0QJbsgUbWTnCcAxx/EicWISK3fybjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544443; c=relaxed/simple;
	bh=JgrYzVA7jCxQEkWilrTpq8hpV6Gml8vxozEpNZ2BRzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+vCGjXJyJ9Yd9Tk9Ond0CWaeeT/HLcHtMze72dWFTfZpUr16CzqHbJZ6AHYSB4vrDt4RXY21Hh83falPdqpLrsKZBvnvINWj2QwkEkPvuJSzi8QnEtBW2u8GXG+gwsmGA3sfdOSe5cTRuG83WNTQppYvYnjaO07DMB5OtA0pto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LKMXvWGc; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b5e760eb36so32365746d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720544440; x=1721149240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aoKh6CbSkvE5uLHVYrlgWMx47IaolAIb/KMsl791ino=;
        b=LKMXvWGc65eZJenjsVSpVOAwyPPCf5vlCk9NMZUhX7pDhrpYqDdyvVJYIxIUfboPc0
         NcBmMKxcz1ngBLIoDtq7o4w6LjB69xRSPBm/RHXcPkeeUKUVWtgQLR9kFSHtWRXDxPtB
         Nvj7LLkF90MGoNyI+/02ZPbam8hZ+F75NtItVcCb7+9MXc5BeEkjFxeCdmWsQlFFwn26
         4r+zwvU4vJRhZuI08JutjwMjL46I2lqQg7BcwRgYo9WE5QR42PaZ9fruM1yZrGIX+sSP
         J+yczfFvPaPaOhy1rOM2B5nT07y0brVaERg/ae4l4XW4UeL9iu7tolRzlifI8hfRSh0v
         DaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720544440; x=1721149240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoKh6CbSkvE5uLHVYrlgWMx47IaolAIb/KMsl791ino=;
        b=uJ4RzP3bHDL026lQlIMnqi4BI7ZDNOvRM0eWt2mcqzCaR7qY+9pgbTFAC0DGlJMvVW
         IbgQvTg3R2JDAz294TW0EBB56mltJXk9B2G9Vabt/F/oM473kYsAKbXisMlO2QEUMdY2
         8xa8yHOqfj2Q6HC0RgTaOlZM2JtOO8+HtSX0NeKDhjfn5C1GYuqD7Ka5+oFckW89NYIU
         A0u9+BLLRDYMUEtLV0B+uKNKjDGtgFIu0hH7RlBgVWf2iVV5lbmc8naASa2rg+FHTZEA
         fRUpMXRgtqjf96gH7GJbDrPY+3A58vvjGRuELF4NMcTC/cgI4Es2fB3FVgqBzSgGlJH4
         uS+A==
X-Forwarded-Encrypted: i=1; AJvYcCUzykbmm+2piuQbNs4JkiQkpwmfG/mCm5R1tYKsodQVP5mFw4VBqlPe6f+z6FSolHWT4nU0oo4PBXPMc4qaMqNfvcMwDPj5xeD53U/b
X-Gm-Message-State: AOJu0YwPCLb/pUB6no5BGY3q21a0ZzQFnTUygH8twa1PvyVu5fn9t/ZL
	zGXN/Df5exEDOAdRBvENrYOH4iNJILsSgXGzf+bPoM1z2llLIg5UQzgYeuX3Rv0=
X-Google-Smtp-Source: AGHT+IHQAqJ8Fss5qEp93E1gpLOGUNuxyAoBEmzUnNgYypyxw8q6HqRIgm5hrD+KkbzXQKOzZkmpdA==
X-Received: by 2002:a05:6214:21e9:b0:6b4:7910:2b60 with SMTP id 6a1803df08f44-6b61bc7f032mr32420906d6.6.1720544439969;
        Tue, 09 Jul 2024 10:00:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b59dfbsm12153401cf.52.2024.07.09.10.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:00:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRECk-002WM4-Ao;
	Tue, 09 Jul 2024 14:00:38 -0300
Date: Tue, 9 Jul 2024 14:00:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <20240709170038.GG14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <20240708162957.GB14050@ziepe.ca>
 <ZowxyUQAcqDJ4yZ6@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZowxyUQAcqDJ4yZ6@Asurada-Nvidia>

On Mon, Jul 08, 2024 at 11:36:57AM -0700, Nicolin Chen wrote:
> Maybe something like this?
> 
> struct iommu_viommu_event_arm_smmuv3 {
> 	u64 evt[4];
> };
> 
> struct iommu_viommu_event_tegra241_cmdqv {
> 	u64 vcmdq_err_map[2];
> };
> 
> enum iommu_event_type {
> 	IOMMM_HWPT_EVENT_TYPE_IOPF,
> 	IOMMU_VIOMMU_EVENT_TYPE_SMMUv3,
> 	IOMMU_VIOMMU_EVENT_TYPE_TEGRA241_CMDQV,
> };
> 
> struct iommu_event_alloc {
> 	__u32 size;
> 	__u32 flags;
> 	__u32 out_event_id;
> 	__u32 out_event_fd;
> 	__u32 type;
> 	__u32 _reserved;
> };
> 
> It can be "report" if you prefer.

Yeah, something like that makes sense to me. The other question is if
you want to multiplex the SMMUv3 and CMDQV on the same FD?

Or multiplex physical smmus on the same FD.

We are potentially talking about 5-10 physical smmus and 2-3 FDs per
physical? Does that scare anyone?

Jason

