Return-Path: <linux-kernel+bounces-280966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A1994D176
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9079D1C20D07
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DB41957F8;
	Fri,  9 Aug 2024 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eZGkQrCK"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ED2192B9F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210925; cv=none; b=ckWcZh6KVXDOmZCRhe1aUj+W2x1MwSnv+lD3VjdV0wBoDxcMkCTI626l9tbliqXMFbxic0P5b0vCF4Tg9N4XBLuJUvB2cDDj4Bcz6cCYiHIpdeQKIgeyOpIIHiN2x+clrG+FFs2ih+hFfOBC/RAflB+fZVCwTa0JClPxdrUIdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210925; c=relaxed/simple;
	bh=1fxOc/3P0me+bve4od/PfTJ74lOE4vkcbcv9RZZM76I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjbrOCZzT9Jjih2El6Uz8TasnbJltaOMY6xKv3UasxV7gsYLpM8vL1SPl00RNEVBFaR3byE36d2cG/ECU/wy8RgdrqpWfKIVFAQQsU+pRsNbUasbOJL4mf+BHaLkbWqSLfwszzim2TeIRL+1MIgPOSQiv8MZCQId38Ho56GGwO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eZGkQrCK; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fe58fcf2bso12582001cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723210921; x=1723815721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZY6QlLIxw4WLcroKmo96KDSwkSC+vWL18J8wOL3lA0=;
        b=eZGkQrCK3PAiDQ6iq+OEDE1BEm5GmbSRUAzZEgT3aSwHdA4+XMLP1FL9paltHmmgAp
         GZ7c1pw6E13mZufZ9k4R09kxXoNEJrTNAFmxidYF+d65QfCBHltdn83mlLanljFYi4hi
         61fnp4U4Kw8vL/8errYn7iFsgv2Jaa2g0S+uAAvn8xKma0oaV1Ydz9AQDWHM9kTxx+Ld
         X6ZRnl0ew4MzBFovY9xT7v7NHh5mRh32oed5D/qMURgOzG32IGoQDuh1qOkj4vQAz9zy
         TESJHWEo5EsXLnQsLWaay8EV/K69w45PDPeFWilc50KOa2FJZKDyX71u5Wxurkynvg3A
         MrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723210921; x=1723815721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZY6QlLIxw4WLcroKmo96KDSwkSC+vWL18J8wOL3lA0=;
        b=A9aXHIOuUsaRgN6OZST/5h3ff+qjLUgiRKKU82p3Y5b6SB7/BeAmKHxB1hD0pyeEZu
         5Req2xBi13yujM/EFpb2YGKVHgpMJ3Mx2exguSS52COaS9t5tArZHquhVgny8Hugjv/5
         NaAHDxOjw712yfxGMDp2Szn6nfPZ9/7w9Q2oKLzd8MV1N8PKm9xP84aPMyszG0gomz4D
         j2vydwNGRoXw4tv+vEydbkmvaF/k0VhXXGWxqrQNk8XTgY1FPeR1sdKDol0CzXJkVYX9
         zYhpW50HujPovTA0Izd7MfWrEJ2SlEfPGigt5+b+9bVxIBobnDDALWLX0a04/GeMFSub
         YPSw==
X-Forwarded-Encrypted: i=1; AJvYcCVb2cymKflxs1BjyD8mIOe1N0oie5n9kyT7/OP6QTMDcT69ek7CdKn1o0l2ftX2yTlip4Crtgb/ztl01flqoSpu8Fqe38yQks0qRmqv
X-Gm-Message-State: AOJu0YzPhsRB8Vtk0JAlk8t1oyGVJlgrXh9NqsB2Xc6NIWKMAKVeD/Oe
	LzWvyqMwNJroTvh0IBLknKSIolTyQaNBkN/EVcTKZ0YDbGf0kPj5FZFEAdUfh2U=
X-Google-Smtp-Source: AGHT+IFS+jxQx9k25oojEqcmdiGM2mY6Nd3gXM9gU92IDbR4zObHr3JkscBcWZyMpP32Un+K1OEdTQ==
X-Received: by 2002:a05:6214:3187:b0:6b7:ad32:3815 with SMTP id 6a1803df08f44-6bd78de66e6mr16564456d6.14.1723210921231;
        Fri, 09 Aug 2024 06:42:01 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c8678f7sm76635006d6.109.2024.08.09.06.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:42:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1scPsV-00G7sD-Di;
	Fri, 09 Aug 2024 10:41:59 -0300
Date: Fri, 9 Aug 2024 10:41:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu: Remove unused declaration
 iommu_sva_unbind_gpasid()
Message-ID: <20240809134159.GE1985367@ziepe.ca>
References: <20240808140619.2498535-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808140619.2498535-1-yuehaibing@huawei.com>

On Thu, Aug 08, 2024 at 10:06:19PM +0800, Yue Haibing wrote:
> Commit 0c9f17877891 ("iommu: Remove guest pasid related interfaces and definitions")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/iommu.h | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

