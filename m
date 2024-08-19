Return-Path: <linux-kernel+bounces-292087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A0E956AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EF528614C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9119916BE23;
	Mon, 19 Aug 2024 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GwAk+wSJ"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF016B38F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070533; cv=none; b=iRx/NcUub66+VVgvLCvjLbS77uKySaNsX2OtlTlpVRc63ONglISsnRwaM883DTM5zk5lml07M+h4rHdJlQTz7sh6Xtwx87ZD2dE7p8yOktEzAG1P1rWoKOgZ8ukk1w2WLQv8ArRS5HLyGTucLR3e6VOFxcx0a+s8sqkLCakvrTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070533; c=relaxed/simple;
	bh=RyUkRNXmhJ5lIQbz47jZgf3RzPgsgH/d3BFP+Wl/Pxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0zC609elQWL9GXqmaCooxhK3KplaEa4qkOwunhvgYmCDvYyGJaJ5a2TnUga3nhnWeT7KFApO8SWUK6HKEZz45ioT0mQVtKGH7mmglGjfnQHJLPJAb523p0UDk9+Cq2BTgPG9nzM9F3ZP7DLFfHmwGXXrk7r2dmaG1OcyqQULt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GwAk+wSJ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44fff73f223so22103961cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724070530; x=1724675330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lriq5+tRSRLkM8EzeVI/tjuBsyDcUwfembmPFZugMx4=;
        b=GwAk+wSJtjXoDc1SpuZYu1yxTcar+2ryz5rFGXR3vIyWlRgBnxtsIEGkvs9aZxPqzD
         NO+5b7lWD9xHRphAOvEGsMEcmNRjmXylXxaNhuOXzRM48Ey8/PDVczxJBmv9d/pLfWXY
         IwQ5o8+bz1e3QnXMmsFb21TwPmSpTgxmCa90W0CWKIH4YJ/gX6WRRIz2iJBSlqm3Q1yX
         bRr9JIB3rwB/u+enFTG+/5kc4fIvGIKAyP8MBM9Rpi5XQqlkNjti4QEATUg9/m/5o1nz
         VBIP2c40ZwOujoTPLGPpq4RCQFSWO2hhyuMVmMnZxDnZtdTEKlZRZtJjVQeCV1pvdM7X
         bMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724070530; x=1724675330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lriq5+tRSRLkM8EzeVI/tjuBsyDcUwfembmPFZugMx4=;
        b=ZCIiBK/AHSnGdt1+BkfTunNaIB+HXdGSaIGF+wK7GJFpd2KG7LLoVmB9e4rYs+GG4u
         az3cjNKS+fPajA6nGy5VZnb/CPEsCYDa1mP3z0gQxpJpQ4ABf2Nm3J11L194Rn/9V0mV
         H8GfOhjy4Ijm4H7+wjiKvI+/k7NxmlcL4KWsSnjnDpV0u5r/NRGLRZizyptrDOE8xCrM
         MMBIGe/FRi8GvJS8hzXD7WHM3seML5+dwx5jPyKFJhMwcWxca2pllsBJfvz3AXQA0zMb
         yhpc2rXIX++xP6cYbXGsxcjw5Mo4WfzXdWCGUSg5lqG4j4MH/w7GdW5zEWxtmiX0NCfz
         VD/g==
X-Forwarded-Encrypted: i=1; AJvYcCXPQAY8aRUIBhTqMwHaNQOO5QRbneJwuGy9LbsTodqAp/t9TqBuFORmGvcRna7swNIk8HY0dau95wyMGYXBHX48ntlD+6w5YTB6SM4R
X-Gm-Message-State: AOJu0YyOAZB86uOTuCy+z2nZi4b3/2sAokbPD9loefwBmfK610E7r2JX
	q8x8y8MMid0sVp7kUl0cBN3zXLWY5VczwM9dwIn3iyTtUtioPF3sIE64FJ0Qbj0=
X-Google-Smtp-Source: AGHT+IHNw+vGr/7csQmWCkE0wiwg/E+XpDzDEzhlnrIiVMvjWiTJ+dakALBuGKPHH1MPfHM79/ZEFQ==
X-Received: by 2002:a05:6214:4520:b0:6b7:ae86:e33e with SMTP id 6a1803df08f44-6bf7ce59f5cmr92736316d6.37.1724070529543;
        Mon, 19 Aug 2024 05:28:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec5e9csm42159046d6.80.2024.08.19.05.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:28:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sg1VA-00CHYK-Az;
	Mon, 19 Aug 2024 09:28:48 -0300
Date: Mon, 19 Aug 2024 09:28:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 3/8] iommufd/selftest: Make dirty_ops static
Message-ID: <20240819122848.GS3468552@ziepe.ca>
References: <20240819120007.3884868-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819120007.3884868-1-ruanjinjie@huawei.com>

On Mon, Aug 19, 2024 at 08:00:07PM +0800, Jinjie Ruan wrote:
> The sparse tool complains as follows:
> 
> drivers/iommu/iommufd/selftest.c:277:30: warning:
> 	symbol 'dirty_ops' was not declared. Should it be static?
> 
> This symbol is not used outside of selftest.c, so marks it static.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I picked this up for iommufd

Thanks,
Jason

