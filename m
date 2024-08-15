Return-Path: <linux-kernel+bounces-288037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF689531EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA3428829F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEC119F49A;
	Thu, 15 Aug 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kpP/wN5G"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C01991D0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730396; cv=none; b=M/bxykIcupt2pO7z2YsRw9849t5Xtyx1q2+lv4b0/vm+rboZ9kPuKLYDr0m8qCZKsdC3/xRV9llOvlphsfVNYn+OYqhzgyXs9KWHhUMkOON1W739nCAj+dwxz+WGRUCXD6o/DWpflhISNhjII2yxqSyDnq9P4r9be2Zgik6/fuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730396; c=relaxed/simple;
	bh=i3+GFw9Kb+1vg/wagAiTI6DAAGXtT4Of6H280gyIteg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn35aQiY1NdoGWwwEUtGtXC0SfezFaJDPJ40162hXXElKuYePwsj4L0kJqx6qimdfJZeAXAnw0y71lFcr1ZyCi7SXFnvekpGja0GH8a3JG0qfa+WLVds/QrbtetHW/FkaEReExtWMpjzDmqXyomNYC7itocc0HKEn8fnzdWtvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kpP/wN5G; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bf790944f1so1754626d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723730393; x=1724335193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RvUa6R9Ngwkz+XHKPZK7VQ65M31ZGD3yUkDY22gLioE=;
        b=kpP/wN5G64AYpK72evutxg8jzpmhBy0OSpYVdowCU1PiNXaYbmAvyX/bzQi+TCdNGk
         66dARy2m+qZEzJtj4o3JJkwMOwJOK+bIkLVRM/tDwCcpVN3h/oTUb2sEwpehrGfQ09QK
         lT631FSQsn1GHkVcFMO1GI16u0PUNjtpXOCHCTro54jLArXXHFo5QaE5BsfSguSz63ja
         yFyQ7kHfbx4xi+tkY6yB+abxMxmcS+36KJgB9fWpIvt64K/ELkcVcD0rqOs3SgjIB6/x
         4gyTn/YQYHDgeVK0BaXYVWUwe+NWBZovA8VikN6UA2KlH2/jWdtPbEAVarjn5ae9kQNf
         CnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723730393; x=1724335193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvUa6R9Ngwkz+XHKPZK7VQ65M31ZGD3yUkDY22gLioE=;
        b=VK3eEytLzf7fSOLgpisWO722Khh0jwD+Fjk68ZzoBVosQpQsO+Hd63aZaq7Q3CZi/D
         QgfJ1m0WIa6v+Hm/q29ZxNUJHHkDvvoTtvNMm4uA8t8sVg+VghyWls/4VvXDJQDVG9re
         9eO8OW1Ma+xn0IP7eThVGptti6tg+EE77cZsr4inTbjXUYvTssNbhu+Hu1VWC+0d1JpG
         CHZuI81ZgpoPem/FMON5TJjH/Di+AoLtylqmnFviM/XIP/pnNW3lgolDzCBNV0sYHvQx
         zCXg4DBe+28kn1xd3EtLaf9yKoa73CfLd/6Vmr4S+Vp1NV3mtJmC0bujkZCnCQzW58PJ
         xIAA==
X-Forwarded-Encrypted: i=1; AJvYcCUVGH+Aa4o0yc2XxLywW7wvoYxqXZagYLRbYhhk3rqAeEcILouxwIVImulX1KskjsFNp7Aw6gVvIB0OWzE3A+wxwUpegMGS0b9M8XZo
X-Gm-Message-State: AOJu0YzZtgWfVUVWWB1YUnZB3qlUZjHddQQ6WRyO2gu/DvBs9HZXbdgj
	FxZWb/Izr0EyFyx1K9bxEZm3r243pNZBgtuuYEik3dXndPKJdAcbejCj0+nFkG91L+OFCtY03kf
	tcLU=
X-Google-Smtp-Source: AGHT+IGoyA/8Iq/P+2JCZgm5EBJMl53zENEDiocnjbraFpHg4YpT96fqlFsiW0Tns/OdsqGyBH6Y+Q==
X-Received: by 2002:a05:6214:3202:b0:6bf:7acb:ff4 with SMTP id 6a1803df08f44-6bf7acb1aa3mr5666206d6.52.1723730393194;
        Thu, 15 Aug 2024 06:59:53 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef3124sm6542716d6.123.2024.08.15.06.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:59:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seb15-003IAo-L0;
	Thu, 15 Aug 2024 10:59:51 -0300
Date: Thu, 15 Aug 2024 10:59:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <20240815135951.GM3468552@ziepe.ca>
References: <20240814145633.2565126-1-smostafa@google.com>
 <20240814155151.GB3468552@ziepe.ca>
 <Zr3m4YCY7Ape3R6y@google.com>
 <91d6574d-c67e-484c-ad96-91c9fd3d0c43@arm.com>
 <Zr30BjAcVDKJPv3B@google.com>
 <20240815125919.GH3468552@ziepe.ca>
 <43290d6c-004d-423c-822c-7b2558badcee@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43290d6c-004d-423c-822c-7b2558badcee@arm.com>

On Thu, Aug 15, 2024 at 02:41:52PM +0100, Robin Murphy wrote:

> Unfortunately we can't do that, because there *are* RCiEP devices whose data
> interfaces are native AMBA, and thus for whom stalling is not actually a
> protocol violation as it would be on a real PCIe transport layer;
> correspondingly, it's *because* they are not true PCIe devices that they
> can't support ATS, and thus need stall support in order to do SVA, so things
> should still work out OK in practice.

I wondered if that would be the case.

Looks like if we want to do anything then arm_smmu_ats_supported()
would be the right place.

> >          if (dev_is_pci(dev)) {
> > 
> > Though I have no idea how the GPU driver that wants to use this
> > works - it doesn't seem to be intree :\
> 
> It's not a GPU: drivers/crypto/hisilicon/zip/

Ohhhh.. so it goes through uacce, I see.

Jason

