Return-Path: <linux-kernel+bounces-386838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6469B4879
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 054C6B21E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39DD205129;
	Tue, 29 Oct 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Sfy1i91V"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0412D1EF0B7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202127; cv=none; b=TcxPoLUxZpA6VlTW/g3Maz23J8r/4L5qcNwL8IS3MlGoZaLXM9ZBF03Mo+j8f0mbWmROkK6dpRcgUqNIvKc7QCTVPN4t112+wBBGBFwveoUSL2jd/vL9GEqOUcCcoUHufZiwhcgOv1PSsYpwVxdwwiarmEJa19hT7BozdjbeFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202127; c=relaxed/simple;
	bh=2c4RrWQo0qfgTGo6fjvWdjW9cI3yK8P5ZqQEESqswZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTDIsk3+ss9ZYjXmj5ulcPIHbOcuLzWt5Hg0Qmk6oHs1YMhmSb6zDXXuoMHG7vquXqqgSiDIsvdpuV/68FTwjOyk2kz0gPtUmgujJGGWJ8kW+fjvKtW4H7yEzgjBtKfd7vCEOEjugMKgQw7OPxx0HV38vpv8lsZtoHGQE3iUw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Sfy1i91V; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b155cca097so447762385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730202123; x=1730806923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rfqr1xmSjvRoYVktxyQkBgXqxH8iduV6ufjGw/Vljmo=;
        b=Sfy1i91VQJxWnCFHzzxihMT28nalPfL2BZRo2kQnamxn/lY/Iy+LmbO4DnJzsMbbFH
         bxFNhe+shg7y+6QAjFSFP3bkh0jBZTVNyUxzSxwpXhHTXho1EjIAtsZfuoFkhrcmps3i
         uMa2sv8GfDW/7fSYLBbGvl4T7zOO5SqgmUS0Js1lNpcPM+wSsAsk9sAt6r0p2h4sydoz
         GirpLCuDJMQZzgl53m6VC4NmpiGr1WOmQVxuu1a272d5RQWkuoSTV5NNSMo0Lp1WxpXy
         wIPmp6sq9a9LXVbq8d+yBkPdVCz7I9dIc8gWQLtlv0KPkJPwkzyfmkhoRpqzHH7Oe8Tn
         qdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202123; x=1730806923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rfqr1xmSjvRoYVktxyQkBgXqxH8iduV6ufjGw/Vljmo=;
        b=NTE6mjO8zi3tKJgCghkk2/jWNsp8rSsTdPPJ3ihcwtDJEhQCD9cjVVA9cch6/pJDyu
         ibkNKdkn4kIc4WmqlkbIOtH/ZOluv9EZCRZ7093SkhyPfN+UeLMg/KhC2jtwqaLaUSCm
         01iWzC+c/dTNgBg4Admv68mf5dgJzbGid3rBIKGWPziPhdcI/fxkrUpqXleKGZdwcbZI
         yxUdrk2ZkUmcf0s57774v6B0xtZvv/iF39kIJFVFmtGuIXmwMVS8p2T4ur/nOOLx+1Qi
         Jf+Ol5dTGw3HGRx0KYFcfppxEQLICLvsDdWlz2t6oVPJ5HCLI5HrSTYr7Y16GASQPbPr
         HXOw==
X-Forwarded-Encrypted: i=1; AJvYcCUaUKGmtw700Y4FyD+Tlfi4+i2s7ks22qRAPt0KvPqC7zTX00YznAzb874n0iSljOHDPNW2u8OgZrDeOls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2X6weBFn7Bk5wIt8ClZVLfWY8ZRIDyds2AO36Q7iATvyTf2wF
	iVJ0eJ74I6dN5tQxER+UjnO5ym5ccYmxdgACCDi5MhU6dmS5gw+NaWU4BWmE2j4=
X-Google-Smtp-Source: AGHT+IEaewIW3xngY+XxdSogu+jXe1ZcFyS4HQYK8sv/FdkkTGMz5Hqf+U5c3WUpu3t/AiK/vrfEdg==
X-Received: by 2002:a05:620a:3906:b0:7a9:9f44:3f8 with SMTP id af79cd13be357-7b1a9cc0e73mr251535885a.5.1730202122746;
        Tue, 29 Oct 2024 04:42:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d2ab45asm411088085a.66.2024.10.29.04.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:42:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t5kbp-00000000nX2-3Aef;
	Tue, 29 Oct 2024 08:42:01 -0300
Date: Tue, 29 Oct 2024 08:42:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu: Restore iommu_flush_iotlb_all()
Message-ID: <20241029114201.GH20281@ziepe.ca>
References: <20241029112302.63639-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029112302.63639-1-joro@8bytes.org>

On Tue, Oct 29, 2024 at 12:23:02PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> This patch restores the iommu_flush_iotlb_all() function.
> Commit
> 
> 	69e5a17511f6 ("iommu: Remove useless flush from iommu_create_device_direct_mappings()")
> 
> claims it removed the last call-site, except it did not. There is still
> at least one caller in
> 
> 	drivers/gpu/drm/msm/msm_iommu.c

Yikes, that iss some scary stuff

> so keep the function around until all call-sites are updated.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Fixes: 69e5a17511f6 ("iommu: Remove useless flush from iommu_create_device_direct_mappings()")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  include/linux/iommu.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Strange that 0-day didn't flag this in my trees. We really need to get
0-day running on the iommu list too :\

Jason

