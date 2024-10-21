Return-Path: <linux-kernel+bounces-374410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D97A9A69BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FA8286867
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2A51EBFF2;
	Mon, 21 Oct 2024 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="avgJdvep"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC01EB48
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516133; cv=none; b=CMTX/yuWUfzfT/A8xbcSGyLZ1IyubX46Xqh9koH6WR/uXPs/fi2hD2u37cOk0qC/tAWhguHCqhZ6IT7S306WcpnjLut8e2yFfi0Aj1qUQcMsCV+sugodEqFIkS34Se1sTxMO2Lvc7qyOtmHB43/07TSRV6SWYbf2iPKZFz+Awao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516133; c=relaxed/simple;
	bh=uMCpjxkkbpH4cJ9rg27SpjeMUkWX+azzoaNSrCRm8DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGCFh35mbalFTzNhohl5LW+zwSRxzmMyoOvUVB3wcO/JgY4/TWFBJC9p/TVMRuansiUJLMYAHyDa3fAbuxtn9ji4fXjgiWxqmFrru3zuXo/CQlA46imQMptPVy93fBkzFxqtI9V3jdEBpApiFn43uAkIE/KoAs5An8oAbjMk/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=avgJdvep; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460ab1bc2aeso24918841cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729516129; x=1730120929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=evJa18w61he0GiyzWsy/XhrOLrknrY4Tqt+JZDSyhOc=;
        b=avgJdvept0OE1LanC/2ilnaI2lyswG5KNPOtzGQTCZOA0GGCo09gCvvOVhNbCljI/N
         5J7/G7cAsAlGBMN8d+v/GnYLpu6CPeoDEWaJBf/57vCaCB2wLyFb96oI0IdItpiZVOM4
         PbH7bL1TSdHrUnhf8ip4UaXCRukRUGJx1VdjOkPnrnGT/Qi5LFYDxKifUCvEyAZMI3Yz
         HL22GBdkyu2kewYY9HPqZfRmF6V2+MR+VwDTeT5OfJ/X1mi+DB3sHeq/ecaBCIup6vz7
         406tcx+EKjh7QoqA09F6x5P6Da6C0u4T7FeRV98qKh+SZ9QYLCsWUdKp7DmP2IiDTO+9
         9RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729516129; x=1730120929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evJa18w61he0GiyzWsy/XhrOLrknrY4Tqt+JZDSyhOc=;
        b=UxGejLEOy8alXpNhbaQ4NSRQwlYRwujGUMTBupzqyZxEQbvVt9XpiIsT4G0IT2kubo
         h3cCrCZWSKuTECy6enJqtUnCCf2WfG7LRGLfCjEnxhFqED9q1oypvB6usam8hGWwJlRL
         DH21JApBbF02AS4CT7dYehxodOqCepP+92QI/JOtSPBQj4AIxOUX/sNqqrVF7Zh3tpXE
         +e3srY07bzoxfuO7OMHP6xnL4/Uqh9yRDxmZN6kATnDrykmIv6Tp0n03qZAkek4BwDJB
         3k8VA6l7wsQOWHu2isOC3ZQgYBJLKSQuk8KUQ6PHiC5OEHuqe9JSUrvm3fLRj+HARLT1
         7Uhw==
X-Forwarded-Encrypted: i=1; AJvYcCVUZqjcv1tR6OSlDUNa4AGpaFfvbomkZgDrYHdaE6xiW+rFxGSuIsd+FE21KxmWErJmVmL/ne37tgHMKrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoWGtN0jtwkjMls+kGa3OLl8dAGqK6Lpf+/2YdgKiJcEB+OkPl
	BXlfwcIzmsNNMPAGzhsZYt6Gyo3Vs2KlaltlvKeHq2ziAqo7gfIjbo0YQGkEFIDEPKhxuYkazvw
	s
X-Google-Smtp-Source: AGHT+IHELvc9bJUkKetX+mL8TDIZmJ616V/74r+nkShR2wxBIrLxWT10RhDZSE2+v55iHiwoGSKOUQ==
X-Received: by 2002:a05:622a:28b:b0:460:a06c:4eae with SMTP id d75a77b69052e-460aed809bdmr174162711cf.31.1729516129164;
        Mon, 21 Oct 2024 06:08:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c3a85esm17492791cf.9.2024.10.21.06.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:08:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t2s9P-008Nw4-ST;
	Mon, 21 Oct 2024 10:08:47 -0300
Date: Mon, 21 Oct 2024 10:08:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] iommu/sysfs: constify the class struct
Message-ID: <20241021130847.GD3576661@ziepe.ca>
References: <20241018121725.61128-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018121725.61128-1-brgl@bgdev.pl>

On Fri, Oct 18, 2024 at 02:17:25PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> All functions that take the class address as argument expect a const
> pointer so we can make the iommu class constant.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/iommu/iommu-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

