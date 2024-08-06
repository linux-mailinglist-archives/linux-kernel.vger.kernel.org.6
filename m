Return-Path: <linux-kernel+bounces-276637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA41A94966A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6598028C489
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277B04AEF7;
	Tue,  6 Aug 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="doL0xlIz"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E976481D5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963933; cv=none; b=sTxQ7v8NA/1siSfq8fUsGPgzEbYblusp76Io428ZUUa2mQiDboqEseEcRwgjED5ZGBAuXjvNr+hCi27Qohuvf5ChrooGwkziOhzLgMchL8E0GtT0mKs7I5yIRrwk32GapzEwL3LCCh4xQDEe54fJLGaoeg35xOfLZTw/fcd0Bl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963933; c=relaxed/simple;
	bh=yGvpZoh5vCSJK/qbn8LcdrNoO2Wx65yHXP8tJqegytQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RY8b1TlPTSVGiAEJGnPYZE+L3kLbBR45QUbfDcR7/q09vyRPCV3qbeinBUTlpKEibvbRZpOaYGt4pwJvvNBH8H8SYUKchPA/nzJYv4eNfWSliFliZ93rE8kzI4iKeTBJHGSiyrGH7/oaHzz5Q795WS5FgPK8kQ07vu2CWtLYcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=doL0xlIz; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70943b07c2cso535005a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722963930; x=1723568730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FF/1bBloQvKewzJ9i4AR99oRC5uWACaYmjJ4UN+yhI=;
        b=doL0xlIzgekfUWcBFpOvvakl/BMg27KtJsShZR5YAhHtMNr3KIWzfxZUvndX+4rKPW
         AmT5b+cMB1stYsBnqLdzAOU8lQ4xNoZGwYuYdczODUsw1v2dLBSUEOujMS9Pbtq4wjtU
         NRqQzInPiFdU4I8ua3OZuHB33zcqTYNFFkCGKFXSmmunzTxoEH891EYaH2G1IW3c+KqU
         HS6RvzeIKwSXgcC/eG0FdCgnddsNgiZv8xXCi8T6spAYi8tcT4QtooGUK0fyXiFXcvqQ
         1Oj7Elos7+z7FV4nthnRXKPo7ZqJ03FAD2y/aaC6hOwjVtCdP900sbt2hYzO0O8E/Lv9
         se9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722963930; x=1723568730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FF/1bBloQvKewzJ9i4AR99oRC5uWACaYmjJ4UN+yhI=;
        b=tAZSg3RUjf2jyvwrx5lRPSIMk04uzqldugnvOJ9/EbSCnTzNUpmRNtEAdEECBXLYxY
         qBiLqb8ZHqjmBIockrI9Mk9RfGt+TmGSVId907DmIpr33n3hLW/4XGL8v0UxyYCd/0BT
         H/eKnyEeG9WNZWbdXP6gFZVesFnp+pYYtuFTNWuQRwJxld08bGwSyiFB1YzUkXHy7w3P
         vVzWpHfgTHFUZSPoLjdiauSKLOyF0kf7w296IHE1qjp7fJTuOcmjrA3Si1hWVFzVtTaE
         d2RVhTpZDZHW45PmrZ1BALCkGgYmWV2WdekRaJtkWm36KdaSTBY1PDVJURU906H5z7QP
         xBVA==
X-Forwarded-Encrypted: i=1; AJvYcCXWoMuMNhL425+j3gMznSW9pcXQQ49ChEdelSwPXxHwdJ0C4M6kiMDSx+zBSR+T+oMRHqyjtqXNGq5L8cwBqyPBR9GxrJhh0CQCoPDq
X-Gm-Message-State: AOJu0YxiH34wpP22HM0pB0NsEIxPcZTVOn2+ZUeIvrzhTOcK7CqgNaJ6
	hukrLVugQQVEsE0tu7bn4E0dG36iZU8VCjr/mu+wsHfsHV+6go9cekBc8iPXfB4=
X-Google-Smtp-Source: AGHT+IEfBFlT4KzSQTpw4KAX++80DJzKla5Md85qMeUYrxRTC3yZCZpkl1YY0dnUlf481tT88r1k6g==
X-Received: by 2002:a05:6830:380d:b0:709:472d:f342 with SMTP id 46e09a7af769-709b3201792mr21629352a34.6.1722963930227;
        Tue, 06 Aug 2024 10:05:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c79744esm48125606d6.40.2024.08.06.10.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:05:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNcn-00FTSc-AN;
	Tue, 06 Aug 2024 14:05:29 -0300
Date: Tue, 6 Aug 2024 14:05:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] iommu/vt-d: Remove identity mappings from
 si_domain
Message-ID: <20240806170529.GK676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-3-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:36AM +0800, Lu Baolu wrote:
> As the driver has enforced DMA domains for devices managed by an IOMMU
> hardware that doesn't support passthrough translation mode, there is no
> need for static identity mappings in the si_domain. Remove the identity
> mapping code to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 122 ++----------------------------------
>  1 file changed, 4 insertions(+), 118 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I always wondered why this was so fine grained, I would have expected
it to work on blocks of 512 x 1G, once you allocate a memory for the
1G table level you may as well fill it with identity IOPTEs. The only
optimization point is how many blocks of 512x1G are needed..

Jason

