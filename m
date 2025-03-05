Return-Path: <linux-kernel+bounces-547426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DDAA50760
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18CC3A806E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA1F2512CB;
	Wed,  5 Mar 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AfHQydln"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A1824C07D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197362; cv=none; b=jHr2QpZmb41FwE+Dk/pSge0XiwYz2JaAqVF/3dqj/Vfo5K3vnIUpi9kWQpd9OdCCjw+LLoPanVAb16et4uDCTlFh6YTDIRIJdFf+moRHHANVS0mKdUAliZDpEa7e3rNRE26wo1xrErrQmrrvrbBqyhaWKxJaIILFfUhJs9kE0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197362; c=relaxed/simple;
	bh=TUPQEmrW/zlDUggHE/0eBZQD2cfbqcK2BAfpEugKfy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jncqpNYrL/yIlGLGO7Vnt3+2GvmBidDdfKhcF88pj9A8g7CPqgcs9eGBUM314AgXLWDRaTfuDaCKASbHf+mdMJgYORDwMJrWdHhZh8R068mvA/i8EDe+wuJJj1jZbaxDWUl0xRxL2m6tmO+EwSpGN7Xe8MHusNiw9mVv+P6tESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AfHQydln; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c07b65efeeso619699385a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741197360; x=1741802160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ep2jN4skgI+D4W4EsgQGzXEpA82GjT/riHpbC+3iOM=;
        b=AfHQydlnFwA7/1kyWNMWDazmS3wM1eK3EcqG2DhRmRFNpWt2ack4GtkIYJF+b8pTiW
         QPiOl9zpAWwGN6UYjr6U5J5QjnGJV7nw1rjZ0spKOle5Mmujc5pTg+FI0nkzetWz6pp9
         u+5JQZTj3yo1n74JW2p8V4Aq5iTUPSfkvjANbM9Ak0GGK4+qdYB3EksKwfKnGBvSMdJt
         z2LW2ZLjwaovBAmDpXp9fParXHVMityt/4Jsr+CuN7MHK/9vLl14fldf7g1dWRfPo84r
         Kq/1xIbNz1r5CMDTZXvx8kCWMAQQYrKQ999ZIZHM5iF64ojyesWKEpmv/NrDdzVF133+
         tlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741197360; x=1741802160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ep2jN4skgI+D4W4EsgQGzXEpA82GjT/riHpbC+3iOM=;
        b=cn8rMpdY/oSL/+a9TUmY2HVJP0FdNuqyOggvYzF/aGaLGqy+IuvjrhFURlthtr1Yrg
         zWki1qN3mMcMKev13ByIlkTbxVGbNg5u92mKyoI6O0UoDaGmbwSBZc6ktUaH0kqBZo8E
         P8Tkchwz5IOgt2zIXxjnWD/ahUocUTklGdMtdMSrqqo+q88e701mqCJBnuaH9oOD3+iq
         m7Hqv1fX4E6D9jXI0bbm3ouUBkHAeoodhOCkKJU4bprzAzYXGlpgTA7TNrVq1cAucP5g
         uOxFS8KbqAvbFZBRWWJ3kSgJEsfu79Ugp6zLY3nlQi/aGfC1MCoCwalDzkZJW7tw95vL
         ztgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWejMlgA+5DtxWZQhA9l2wAjznl3bpMAQkJaRUyUnQDLEoNFvU9ZTdzMitm5YDd5e6iPbsEsa7STKrhTQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1QNpex/xiPQ0G0FdUVDNQGy2eGta7x+PZiLMcoU2rcOARAUH8
	kOnybdMXsuuDlswF085AvWjeuMAuYtPi/Zs8rYi2yNvOp+QFF4u9fa8SAEw3fDw=
X-Gm-Gg: ASbGncsd8naGIrmznogRw1Yw6cEqkcYs1TcM0DmOkXLkCrX3zLUr7Jg1g8xhXLihKJH
	PGYUq4jlBD33CgduTwJPGwq+Zd16sdvmqAaKO8YrdHXlbMoepqebJgwalj6uBZZZeg2HjrUXZM+
	SA0IojemFXWe/7j2+bqJV0eHAGb9kDOtHj40JAFrjvuH3n7RbzkwRX/2rs3A9pJtIbCAYaZI761
	uhGOFoZAOxlOpB7NTj4x6Mf3tYYMdBWteAHVsHE3TjzYmSvowWAB1VpaK9uzRs8U16JM3JCdC+U
	eoy8quK8pZzzfJAFt54=
X-Google-Smtp-Source: AGHT+IE075gQ9paRBr5FJqePHxLiGeTWllaX8jx4kAg32gkUcqpKhkxzc9FKZ5jSjzoHlrJkCTJ+cQ==
X-Received: by 2002:a05:620a:8908:b0:7c3:cbad:5729 with SMTP id af79cd13be357-7c3d8e7ae8cmr768466685a.25.1741197359262;
        Wed, 05 Mar 2025 09:55:59 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3b4c9e120sm486128485a.11.2025.03.05.09.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:55:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpsyL-00000001TVM-2YSq;
	Wed, 05 Mar 2025 13:55:57 -0400
Date: Wed, 5 Mar 2025 13:55:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 2/4] iommu: Resolve ops in iommu_init_device()
Message-ID: <20250305175557.GI5011@ziepe.ca>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <fa4b6cfc67a352488b7f4e0b736008307ce9ac2e.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa4b6cfc67a352488b7f4e0b736008307ce9ac2e.1740753261.git.robin.murphy@arm.com>

On Fri, Feb 28, 2025 at 03:46:31PM +0000, Robin Murphy wrote:
> Since iommu_init_device() was factored out, it is in fact the only
> consumer of the ops which __iommu_probe_device() is resolving, so let it
> do that itself rather than passing them in. This also puts the ops
> lookup at a more logical point relative to the rest of the flow through
> __iommu_probe_device().
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: New
> 
>  drivers/iommu/iommu.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

