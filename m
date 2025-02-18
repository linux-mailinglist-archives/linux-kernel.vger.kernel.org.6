Return-Path: <linux-kernel+bounces-519455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53A3A39D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B84F3B9B19
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A00269B18;
	Tue, 18 Feb 2025 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Nb48jb86"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A662269B16
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883973; cv=none; b=bRG2UNwyE2R5FtnhUaqShpdRuHjrOrMbgnqmgG6NbIOQrsebBxeLPSqm5H4v6E/7dL7H+iF9Wdh/kEkEQ2xBMy8zl+2gTV3Qhlcj/Fu6B0SHEeFnmVzpO0KXaT5CLBlPpFppemz2X/T0bBA946fn5HPlHchL2SB2QzzDo7HvTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883973; c=relaxed/simple;
	bh=q+HbC06i8CG8XrIehHvRej0xtlb/tpGGxGM1a3va+bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCofK/b6yS6lTjQNgGnLmYStMeTH0AEHKHwc9k3WhWUsSR7TbwY5vN4QsXEabglYDbiZLFT1bXjhJFAgmopz+qaBehyvIRy9S7dzXy23Fy/zu+jkHMGTeAaQ+glKD+lMEvOZnbFPBKUPF+dHsWbZbP21d+epgsLWCOczGq38OwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Nb48jb86; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c08fc20194so452967785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739883970; x=1740488770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lyvU9JNedDqTCpzlpsd+T8LpPH2Gmgp9plDnXA9nVc=;
        b=Nb48jb86Zct/iFx1IaXfgywRnbqk3cRMtfrwBp83H7pOy2pXBmEEVy4vYA1/+zabgl
         rNEqOFZRbhSO0NSsvQru/7W4nQRjbdW6CREuAPymHiZK4aXqS1WlQSKAvns/21ZuYB5d
         DzegpN72gBFQ7kDCMeKZ+S291Egiq5DQdE5thlQG6YhS16Z/KQiQILw0wuBjWRz1hxGc
         3QpVEwHzzPmlxrDWGQljoeutxOf09xsk/axx//8MvsZS/xCzKOZZtc4DFvSa6ns1hs/c
         FZPwZtCRHAArHHfZb/oHFCp1TSp1XuBd20RwUDc+6Gfbry1WsnN7JBBRLjFmSqDKJLDA
         +BJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739883970; x=1740488770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lyvU9JNedDqTCpzlpsd+T8LpPH2Gmgp9plDnXA9nVc=;
        b=VfYiXqQSFm3XQoSf1ncE9Z9o/TDCM+UoWCHW27pNTfT7PkUVkcyCO0q0zLjHxtZGQw
         tLi65fLwlnvywmfUYPDaoEloT7dbexhDaU9YjektowfHTuWHyw9pnPnSVauqLioMCz1c
         CXiB2Cqfj2msm8v3lOx/o+fhcu/B2/8Bldb+nmpMZkP57VDHQWJoILUpI1/bIleFSLZ0
         G8NwKVwiWTypgjqDnl5hchp/gkk7r7l7zMOEmedQc/SmUpDDz40agaDc1xP0dy44lxAZ
         TfaHVuolilTiiUR8BYaDb6mxAUNzoa3VxcPojJ43F/pApwmxOcBqHvQZ/zHOLFk90X7w
         Qyng==
X-Forwarded-Encrypted: i=1; AJvYcCXUkn0ugSLo5NAOFXPRwD0cehtZ5dBOhc6BYyQNqr1V8/8mjDtFql1IP9K5QPCEEwrxqAVQI3VAE3m1J84=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk073U+znWewfRrKOfuK1U92MCTVeIlc0v9gJQCRNZKfJawums
	pVmcl2Bpc9fYakuUk5sp74r6y4pUhmjYNr5nIbCzMKL7Lr8jhGB0sETPvEH0oD4=
X-Gm-Gg: ASbGncth5tiTYnaSdr40z/z30RQUDpA4461nvDwHDjSGuWpTdsHGpNcaAJ4hdKsrmp0
	HCwXj6S41jH/qnNtN3z7ceWw60+YHPqW9w36d9SbAFIN+Og/MVPIfqzFVOxx8lVPoQo/vQaN0gw
	hKtyVG4H1btYMf8xzhbq/kLZ1HPXbcVNnTmc3z+lfOIcF9ExXOOPmf0DfCI0VLfJKU8sjB3Qd3t
	3N5uPkwKfrH68d0rzHKvF2EKNsdJiVLiGKXcqwoxXiLjGWzcVRnuHQC67YG61hgc4ukZFex2eYF
	hSSYSDliTLDJcNuUyMfhL1Ze20Qd4GYHplji/+FgrUtSLfUw24U07AeHD3E63FKl
X-Google-Smtp-Source: AGHT+IE/gXCIwybwMK6bxAKgrlyI/gpY6nFvi94kQ78DP/ey/y9SZvjySbiVrf9fmXSNn/2xdNnHow==
X-Received: by 2002:a05:620a:480b:b0:7c0:ab46:396c with SMTP id af79cd13be357-7c0ab463ca4mr528395185a.21.1739883970143;
        Tue, 18 Feb 2025 05:06:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09f33bc60sm235631685a.108.2025.02.18.05.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:06:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkNId-0000000HRM6-2S1o;
	Tue, 18 Feb 2025 09:06:07 -0400
Date: Tue, 18 Feb 2025 09:06:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Message-ID: <20250218130607.GG3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-12-baolu.lu@linux.intel.com>
 <Z67rghQyQrjb5sT1@Asurada-Nvidia>
 <4ee09fd2-92c6-4295-88ca-1cc061135417@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ee09fd2-92c6-4295-88ca-1cc061135417@linux.intel.com>

On Sat, Feb 15, 2025 at 02:32:32PM +0800, Baolu Lu wrote:
> On 2/14/25 15:06, Nicolin Chen wrote:
> > On Fri, Feb 14, 2025 at 02:11:03PM +0800, Lu Baolu wrote:
> > > The iopf enablement has been moved to the iommu drivers. It is unnecessary
> > > for iommufd to handle iopf enablement. Remove the iopf enablement logic to
> > > avoid duplication.
> > > 
> > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > ---
> > >   drivers/iommu/iommufd/device.c          |   1 -
> > >   drivers/iommu/iommufd/fault.c           | 111 ++++++------------------
> > >   drivers/iommu/iommufd/iommufd_private.h |   3 -
> > >   3 files changed, 28 insertions(+), 87 deletions(-)
> > This is in conflict with my fault patches that Jason just took
> > a couple days ago:
> > https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/log/?
> > h=for-next
> > 
> > I think it needs a rebase, perhaps on the branch mentioned here:
> > https://lore.kernel.org/linux-iommu/20250213150836.GC3754072@nvidia.com/
> 
> Yes, sure. I will rebase it in the next version to avoid the conflict.

That's troublesome, I think just leave it so Joerg can pick it up. We
can figure out what to do with the conflict later.

Jason

