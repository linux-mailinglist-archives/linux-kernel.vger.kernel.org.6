Return-Path: <linux-kernel+bounces-575477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBB8A7030D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787E9168EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D35D256C70;
	Tue, 25 Mar 2025 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ap4WG8wP"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED31DBB13
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910935; cv=none; b=bZbuxmWcs9SeMfpwaBvyva22I/c/diml97BDagNMOBK7lxbvmdXJPTobvaiQg1/m2qtRowfvkhlWL2KfXk1QDT1WiPzsJAZuhSHqgsv9zo+KThaIMk3tN1H17rElVkmKTgVBXT3zQ3tsIgl0CBI5HAEMd2ZAllboleeRD9z4IqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910935; c=relaxed/simple;
	bh=OSX0TORPiNrDXa8v+Fpy4Nylpvg63xS3qyc2FnH4q+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rmex15PDdk+DpGUrqP0r5MvtZXFsEs2DbX3C9wEzvqAWZJ96AfiA2jBOfEBQ8ITrIKLnbL9xtg6iSB7vIxnp57AKoZE3LgQZfGtdfeu60t7awc1zghpsjwusd2oP1T5LreqmkZND3PWW2H3ySh7ZK8+FgHr38ThDnepVbUBfQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ap4WG8wP; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-477282401b3so38976311cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742910932; x=1743515732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVfx3UQRZQeGiEfg09GHBIEEGmSfPB7wa4J0uKs3RME=;
        b=ap4WG8wPmBSb8/XdIF83BORCSmQzjffScOehv78NDPDGzmMYIKI+wdfemY6XVPmUYa
         4rt2IIYPrKGiSLROMekcY8725sxV1KSPZjzEegh+VeN3uFiRx+PWfBXPM2zGnARSDR0e
         AFwyvOn/9TH8HlBmI7XJUH81Vd/NyCzbwYvYhE0NIRXJezZcgLxdKnjn9T8lI5Vc4C4i
         joEIvrDjVeT83p6pIYxYZctUSNOuj1GgGqytQvNEYGlZIuCYE/73zhyQzUhWwkZSQHAD
         ajmtPcaojEsW1Gn/Fu2EYzIgatIS9YwGRExVVy6Gni9RpY/go6oQx4NVBENAdmYYPaED
         qmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910932; x=1743515732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVfx3UQRZQeGiEfg09GHBIEEGmSfPB7wa4J0uKs3RME=;
        b=Hqun6nfOY3xt7b5YWpAzcUNFqDGkRPemyjPHhKM4r5xvt54AlDuqjuaHJhCfiLt+EF
         le30goUZQFns8j+rrgLCZFnytUuGKH0pWZtBTHebj4Yu0xTAzzr9B/55P9M0/IuWOxqo
         aCf05WkwZ8BuQbKq+38GaK9f7H5kocuTXMfQmUS89F0IYRZmRoDhT+cMKuv7SiWgjAbq
         llNj/6kIl8t1SOHnkwF4BE8TtQloE4gdy2ydjWy/QdYYdQcLpG4VihBX11uQ51s37EgG
         n6afPmIuNj6gCqbJN6cfgtabHPHZxwMWPhxiFTrGLq22A0JuoDzCicQi5H9zM8OrfB6B
         ivCg==
X-Forwarded-Encrypted: i=1; AJvYcCWA/bvorOC6wMQGvLz4nGgeoWvMjp3lmZ0aAm+ph5OB9zRnplykEMPxT6RNzGBHipz1AWBUB2ihVkj2lmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCRkN2LtP0tD9LqN2Fr/XhWDudXjjqdYdknUO2a1inWU9VyT/T
	8HZe1SKOR1883Zx5KZv1rt34IGP3hdBJuePneoVL48H1/BXuTnInGwiQxwIrsLzs1GhsjZmZZZ9
	n
X-Gm-Gg: ASbGnct3J9UQXR8Ddy7gmYVlX5mV4qhBPpAObUxAJHc594BVfluVsBnY3AA8go6O3Im
	GiyA0eFQBTm7mpOu0UOm+2eLy+Rh5nQnCEgaUtYcrOsKKjQuX+tzE7X9ldif1LuwjxoSOHsBQTF
	TG54pUm+5Gnv5C/gxGi+jjzj24MvUjqKoF3bvjBpxnOrzLrBI3FTtnnMAF4KILhlap1NxuORXtw
	4wR+ZT4HQcQzrDUIb1TC0y04sos0yKKMkZWmJy4sGiAQKSMBj6KON2JfZTD/J8qx7TIpbgVe1gT
	yXVKRq7guliBSIBlaYgcn7jSP4F1
X-Google-Smtp-Source: AGHT+IEw+cUq8N3YnTJQvX1WmFYfTqQVR7hTqQXnoJ+ZcLi1ljTgfQoIUXe99s2hH3estqLJNitCKQ==
X-Received: by 2002:a05:622a:58c6:b0:476:909b:8287 with SMTP id d75a77b69052e-4771dd801c5mr305002311cf.20.1742910932009;
        Tue, 25 Mar 2025 06:55:32 -0700 (PDT)
Received: from ziepe.ca ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d18f7f5sm60098791cf.35.2025.03.25.06.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:55:31 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1tx4kd-0009Ay-2x;
	Tue, 25 Mar 2025 10:55:31 -0300
Date: Tue, 25 Mar 2025 10:55:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: benve@cisco.com, neescoba@cisco.com, leon@kernel.org,
	liyuyu6@huawei.com, roland@purestorage.com, umalhi@cisco.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	yanjun.zhu@linux.dev
Subject: Re: [PATCH v2 -next] RDMA/usnic: Fix passing zero to PTR_ERR in
 usnic_ib_pci_probe()
Message-ID: <Z+K103IYCOwa/pwg@ziepe.ca>
References: <20250324123132.2392077-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324123132.2392077-1-yuehaibing@huawei.com>

On Mon, Mar 24, 2025 at 08:31:32PM +0800, Yue Haibing wrote:
> drivers/infiniband/hw/usnic/usnic_ib_main.c:590
>  usnic_ib_pci_probe() warn: passing zero to 'PTR_ERR'
> 
> Make usnic_ib_device_add() return NULL on fail path, also remove
> useless NULL check for usnic_ib_discover_pf()
> 
> Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> v2: remove useless null check for usnic_ib_discover_pf
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_main.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

