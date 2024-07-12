Return-Path: <linux-kernel+bounces-250641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6D192FA6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF82AB21FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B15014E2E9;
	Fri, 12 Jul 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TuVR3Foc"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0E16F273
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788161; cv=none; b=FD5NnWxp+Le8LbY1Fc3El1qq7/Vt/yN+tsIeR7cRY1JH0IYzWURguhIlHKtlh9gNBdGkP9C15xTqSaBw1G9TWXJi/zffGzMObUWe/oPEKWKYWpAQHoYJORvAWth4GcOpN5m8bODQwi3z1oUacHOj8Y8K8rqPLJ7HU1Gg7nT/Paw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788161; c=relaxed/simple;
	bh=kBJT8YbrNHkTssvswA9gJLT8aMBMcBvE6Xo16vVg1no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1uuRHRyd1faMXR3uw5rjaWsyiNuJdUFQRXqQXCmlmEkH0E36of3gqDOa1Nt7L1VhxoxcCEwuPUIsSo45fimdEyqOPTMmHNxmoUD2UWWQMyptpJfr8o07fJWWmGC5AKLbPih6fNyRFxLIMUWzBqH6HR5CMkhn29RS3EmvYvlpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TuVR3Foc; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a05c755477so119006385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720788159; x=1721392959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBJT8YbrNHkTssvswA9gJLT8aMBMcBvE6Xo16vVg1no=;
        b=TuVR3FocARcpqfy530ragffG6U+brCvhWS74eVbcK7zuwsGCjwYxyLVWPeCrW8Tl1Z
         keThHek33bvykJW6zX6kX1mNKTFcGKYArF07Lhfka5PtwUFxF02HtD8kXJrw28+zvshz
         z4op9+LIk59enAtbsw38HLzLvvkiKZ9xNLjmPlJO6UaNCm+oKss4tfy/JU2mkZHvYcs5
         VNGR8sF/olPMkoj1z3PC0/B6VXwgq4l/Sy3r+Xa+Ku64ejfMbrySZOrE6M0ZZ+qcjfMw
         cB48If94KqPkEJkiivRvonLkUNG26hhA+RLDyQBBDYt8nKt3spEwhEnlaZnw08TdGVoQ
         iPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720788159; x=1721392959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBJT8YbrNHkTssvswA9gJLT8aMBMcBvE6Xo16vVg1no=;
        b=DfpL4AoMeggT2jhqViJOuKB49CjptzYMaFK9oIwZHwuy0cxM8vhgmn3ozD7ZDPtr+4
         LOVVLUo99Em928mdzKbxkDcIIgm0UD+3ldZTKPdoMmQiFySBI/k3dQpZjIWzJLA8pFE4
         l3B5/iT9ThNHQcWhKGymh+ovEf1XaOiNXStEz4hd83rHSdgDK2Ztc+HX39Hbo5lSKVrT
         PENQ9qQO2EcRrGtsykPVwwKnmt+Xx5GaA2fw5V9eM//8KDld664lINnJ3YKORLKPes0c
         nVq2o4K3hj/n4myxzSGs3QSKTpD/Id576zNgo9SLHItvyeNL6wtV0QTodOuQN4JP8+M5
         xWJg==
X-Forwarded-Encrypted: i=1; AJvYcCU1zSfIVoaHZbYOWSkEJPTITeIrPmk6gQsm1EFCFOn6A1kbI1H7Xx4F2/l/UikHo/kJhXngpxA/62tz89w5j3/q5VRwGLSsEl5y5U0j
X-Gm-Message-State: AOJu0YzMa4pCeEAEZuCgGCWS8QkfWFLkG4bHjxyPRecJwjj5mDvkYRT6
	vgjLIukIpFpGCWV4DwD6VmXkwFXEtnVsvbSbWgOCxSH5tEPVXGPtI8Hpojztvbg=
X-Google-Smtp-Source: AGHT+IFNcSNXyjLCUq4DHk3R2ij71BFERvS9sNsM3zBakmLtTWzYOjs3C+yBv/o3LvcwnsHGWOmY4Q==
X-Received: by 2002:ae9:e315:0:b0:79f:1836:b143 with SMTP id af79cd13be357-79f19ae5454mr1218368285a.50.1720788159083;
        Fri, 12 Jul 2024 05:42:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1902ac2esm394037485a.59.2024.07.12.05.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 05:42:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSFbh-000FUg-Ne;
	Fri, 12 Jul 2024 09:42:37 -0300
Date: Fri, 12 Jul 2024 09:42:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240712124237.GX14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
 <20240708235721.GF14050@ziepe.ca>
 <20240709062015.GB16180@lst.de>
 <20240709190320.GN14050@ziepe.ca>
 <20240710062212.GA25895@lst.de>
 <20240711232917.GR14050@ziepe.ca>
 <20240712045422.GA4774@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712045422.GA4774@lst.de>

On Fri, Jul 12, 2024 at 06:54:22AM +0200, Christoph Hellwig wrote:

> This is all purely hypothetical, and I'm happy to just check for it
> and reject it for it now.

I do know a patch set is cooking to allow mixing ZONE_DEVICE P2P and
anon memory in the same VMA ala HMM with transparent migration of
ZONE_DEVICE to anon.

In this situation userspace will be generating IO with no idea about
any P2P/!P2P boundaries.

Jason

