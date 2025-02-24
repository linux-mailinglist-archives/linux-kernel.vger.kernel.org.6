Return-Path: <linux-kernel+bounces-529935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE0DA42CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AB0177490
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D99204C30;
	Mon, 24 Feb 2025 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IfipELbT"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B4020468D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425011; cv=none; b=h530aFNI9zeqPu6aCdd2xGjyoUtobFkOL4y9Fr1zWHEh8sI4MaVVYnq0qDeVusR8NDKyvqorUtvbEYezRXWaaF0SGn0D9vK+7ZQmn4cW33Ntj0B1uErU3LpEQErHWW2toOTf34HgF0LDLGZ7r41aIFstlA5xyXkC/r/YrKKUJ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425011; c=relaxed/simple;
	bh=8cbM4V9ub4rnejeU1ZZ2B/L3f85wUTVcUeq+2GJa79k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzM2ehIAe7YgTVZhvAgTPajaesmP19dtyH+lQ0JdTKSvrXE0YczFCfrRw3Y5j1n0ak20cCcqIG1/Zj3O0mg56av5s0bRfh94KY1XXLud03cFeE+PYU/D0ShhG/BoXVFXDiL9FH/MHsqIsjP2UWdYr6QmvGKP5JzH+FwwCYpGfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IfipELbT; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e660740061so42805766d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740425009; x=1741029809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtNAj8eJxRHAo05cYb2k/oK+PktmXbkyBqA45R/z1e0=;
        b=IfipELbTXDAKw8c70uGVyC/jjUbdo/GXIzV141otfmFrOxXGIyL8Xc3/gE+CfMPCKP
         sQMQ0WTC/A2KL8cMbpsU/FQfTdODEsIUk7gJJIH+2XksfHZyy2ZacgpbmHKRSJdFqDRV
         oGYLjAdXYagHXHeIuvvFnIjtoSOQR0krzVA6Jejj5EwDWfshQk5Oj/dqEnMtey79Yet9
         +qdQabNtMrHS9U2etwim1dioAdrw3Grk6AqJJ5Wk5OGahAK8UE+leHLTkchK0EYHmIKL
         TkV1Gtk4CmIHZEAYs8Kbe32YC5MZMZVwusn2I3Wvhdy/BhfDIme+/3AIQSu+4Xk3HOo8
         bk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740425009; x=1741029809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtNAj8eJxRHAo05cYb2k/oK+PktmXbkyBqA45R/z1e0=;
        b=WfaWKQf7ZscV3F5DJMI5RPd+BH6MGldWKAapiC3tbjOJpiV9l9qZVDHcCWedXL70oL
         +1LC56oB32mdkqtl1hx5m5elwn4hWya//7jH07ZuwCqHu/AuiXg0505THxBgH+p59qKa
         OUxtJ8C9zybTnIZkLwuF28VjscdpX3UdylLobrSmqyn1IiV9XT0mVDpFMN4lQggqbR96
         obvU79FYK6JlWOfEzKkLUK1/RDAAwv01V8DD87pBkQnOx5QzeRDMiZPyeP3GaLGZCSkK
         pQ3piXZdV+n65uWRG4W4EFVY4eRBGnBrEKrNBIhIp7P/apno7somUtqO7eZvBzDoWQE1
         vIKA==
X-Forwarded-Encrypted: i=1; AJvYcCWl0X+AZEN5DUCSytK7HVB3yLTMYLFs4/Plx0g41NVsDHqlZ//UN9e4S0skmdwCQsdPD/wSHyDC0HRHtNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMLV9AmCyqUiTjIzhy8wyzssfvjYupg0ywO+AmXWqYOUzq+wP6
	ciK8THtXv9nIZGv7NVuQuT52xUcxboZMu+OwwrVQd14h61op+8nFNeOWaV8ZIRo=
X-Gm-Gg: ASbGncvjsRnQtMv/4IJX6IjWQwpOYRhRRuf6UsKNaUtSpMy7eqK5dC4oB0xvpp35gLd
	mZ2W6haETpiXg9wjw3Ku3bJZ4XuuEx/A0OUxgizt+tjrkzWLjUcwOBbsg7FlCAfZ6aH0Z7v0Tlv
	z9j2MNOCL4zKqDPrwvpTQt4eC8R+5WsTuc+DO0Gp3LTjIZ7y38hvyu2s47QHBXMocHX63yNh7h9
	WqvfgbSxaybPvfmXKK0wCg9/bPdle7YbUtTSCFtHbdNGJ0RGmnTKQngQA0SsFqw6VgALdY0USNp
X-Google-Smtp-Source: AGHT+IGeq9N/sleTryYSxmFHmjG3gE9MgwEWAr2E5G/8AEMsyKAkPjD3H6qBvUlnG+WAR4l96JGZRw==
X-Received: by 2002:a05:6214:626:b0:6e6:698f:cb00 with SMTP id 6a1803df08f44-6e6ae9c0c30mr210708946d6.42.1740425008796;
        Mon, 24 Feb 2025 11:23:28 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b086e18sm464276d6.44.2025.02.24.11.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:23:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tme35-00000002CJx-2O9s;
	Mon, 24 Feb 2025 15:23:27 -0400
Date: Mon, 24 Feb 2025 15:23:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] iommufd/selftest: Put iopf enablement in domain
 attach path
Message-ID: <20250224192327.GA3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-9-baolu.lu@linux.intel.com>
 <20250220010250.GQ3696814@ziepe.ca>
 <d93c8cc9-77a5-4b78-85d2-6b4601f52266@linux.intel.com>
 <20250220180004.GX3696814@ziepe.ca>
 <6754e308-d2ee-4389-9dcd-c2a5bbb16c48@linux.intel.com>
 <20250221150401.GY3696814@ziepe.ca>
 <682b5b61-e556-479e-b641-3c987360d87b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682b5b61-e556-479e-b641-3c987360d87b@linux.intel.com>

On Sat, Feb 22, 2025 at 03:25:43PM +0800, Baolu Lu wrote:
> On 2/21/25 23:04, Jason Gunthorpe wrote:
> > > -       return mock_dev_enable_iopf(dev, domain);
> > > +       if (mdev->domain)
> > > +               mock_dev_disable_iopf(dev, mdev->domain);
> > > +
> > > +       ret = mock_dev_enable_iopf(dev, domain);
> > > +       if (ret)
> > Though here the domain is disabled but not removed from mdev->domain,
> > is it OK?
> 
> That's not okay. I can make it like below:
> 
> static int mock_domain_nop_attach(struct iommu_domain *domain,
>                                   struct device *dev)
> {
>         struct mock_dev *mdev = to_mock_dev(dev);
>         int ret;
> 
>         if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
>                 return -EINVAL;
> 
>         ret = mock_dev_enable_iopf(dev, domain);
>         if (ret)
>                 return ret;
> 
>         mock_dev_disable_iopf(dev, mdev->domain);
>         mdev->domain = domain;
> 
>         return 0;
> }
> 
> Both mock_dev_enable/disable_iopf() will be a no-op if domain or
> domain's iopf handler is empty:
> 
>         if (!domain || !domain->iopf_handler)
>                 return;
> 
> Does it work for you?

Yeah that looks Ok

Jason

