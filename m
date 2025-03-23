Return-Path: <linux-kernel+bounces-572855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8265A6CF6D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 14:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EF83B472D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1521096F;
	Sun, 23 Mar 2025 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h31+9vo4"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991517D2
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742735626; cv=none; b=sDutqx0hOBDZWfsbZIB9eC0/jB4OhEVUarm+FU70p9Vw4XZwCzRpcxHlQr9EBoKYR09uonHyZZ/R5VW1SQD6GdJlKwyWR1IM5P1skEb4HbBNeSZ/5ViNF2rK13eLsqYuqe8IysZ6cjeUQGWAKE574UzPs/ww2jq2daiDia+4VlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742735626; c=relaxed/simple;
	bh=LKr4Tq6eNnj7Xe9zMSlrQR5ZDQsgfe5FGBhc/jpYjx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3jtiLgWhQzvGypAHR/arnwl49RL4wpgIbF1+itp8ZJ6t40xxHOjFQSmT7H2kLDZzX2PZ4IIbzMg6OGgxvYv3J9XmyKpzR5pxvr58q4uAvWwXqIjjFGcKGc8Wy5V4q0kqr0jx0kOLWzHLvVNEouZAniEFnvc/t6sKMsH3Y+jjBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h31+9vo4; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso40006176d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742735623; x=1743340423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+wF4IQZggkSDSdyJgdkeavpzbtB2emtmQgy0osOszU=;
        b=h31+9vo43BhA93H9pHpR+HEhQ5yPlKSVbK8yGik1pIJ4Phz65z92yUh0cL+eefK/jH
         WMod7R5tqqH/pWN8UChIr7h5wPC1zu8SS46nWVR65WNlKk7gXGN7XcRv9+Iq6pLycHi+
         n3amt9DQmhwiuu7GVqCQhJXBOZx+uq3CFx6hE8wzgc3xjXxt5H2SNTlH95ybS35fBDQd
         4b5wPsIuyTHdYkPirmyLg4d7hYw68sdEAVzIvVp8gbQNnrDT1VXzBcmpU6TNWaaR2iyV
         0EGwHJtxODz3m5YQwZjI9PDAoT/q7c7MfISyUbRUShGXqi3WbhhEXExs4KWePfLasDV8
         bBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742735623; x=1743340423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+wF4IQZggkSDSdyJgdkeavpzbtB2emtmQgy0osOszU=;
        b=TaOMUzqHqehOTn3lG/607dREXJFJN1esUS9nU/nGOOhqy7NR3YeugEpLhRX80AFeva
         LffEANdEh3Dqr7dpPgDQltO30psnFLiggpVn8M4/j1GlDikn3Faxt5kax7T6aIkkAueL
         RxD5P74bXAkJc8euEvLnl68exdOBN0F4R3y4C8DbxvcdHrTpoffv/gqxolLplWakZJOR
         tpU1SZ2ic5p/vRqrz7QhyzzOkliXM5bq+lzC5/4qdp8JZx1sB7oSrsUfAAn/FLC42FmQ
         Xbj7N63UlS9f4RmZNWGsSFNXg3b551GI3NHvWYuVk+lq15hXwpPkyggcNlCjsM+uqKU+
         497w==
X-Forwarded-Encrypted: i=1; AJvYcCWksrzX4JBhUQlL4enMvs2pzDrjPjqLIpe7dK9lVExKksiLrD5MDYco6gfF5P7ZOkaMikdMG6jZZdVWtP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Yaw/6cbVg2SPvkSE95KWh8nsJovi0bf8lZENuGAfsQ3s849E
	A+qXEIPrXiIoADaiJoWp67rCSZmq3uuMTG1SRa6wESZ3ZrX2aHQX6LxGsxqKxNg=
X-Gm-Gg: ASbGncufmFHoJr5D2GXTx/rCSc8Z28WTRAI/MTQWkIoFZXmiVV2d3YXm9tv0VKtRqkp
	jxLfzU5C8C8lSvJkl7ZzaSX3UPpA/eLF316vQUqrYk0tz+GPvdsCMrr+mwnxNQ3wEcNPXKTHHwi
	Bl5AtmgTHgLtogKRwqTcWeV1/nwRMAiOEiIWnBADduQi+PEWHz9eQXrOH4caC1hBm9yr9rf8I5z
	4AV42EnJLXDdyEae4fKQqVupck4i3IL78p06SC+vAZwCw/Upy30aT1gqB2jZ7DUFwEONBlKcnFn
	HVffeb+NwWlvQFa55CUJNqPNk3Pl4lbjmejpK9HtOzoDrN0C5suTdUVTdTPQeU46TpZz75r9gml
	mSzueBH7xKx0jFTJDgjvjyOM=
X-Google-Smtp-Source: AGHT+IF4UIJE9UDyWQ9LTQ9Krxp2Ixpd1OB6m6mGqwsy9YA+QPXyhTykLF+PW3HLeymx/bkZOK2ZKQ==
X-Received: by 2002:ad4:5d41:0:b0:6eb:2fd4:30a7 with SMTP id 6a1803df08f44-6eb3f32b63fmr177643166d6.33.1742735622728;
        Sun, 23 Mar 2025 06:13:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efc5aa4sm31520026d6.71.2025.03.23.06.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 06:13:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1twL92-00000001R6u-3RMd;
	Sun, 23 Mar 2025 10:13:40 -0300
Date: Sun, 23 Mar 2025 10:13:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: benve@cisco.com, neescoba@cisco.com, leon@kernel.org,
	liyuyu6@huawei.com, umalhi@cisco.com, roland@purestorage.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/usnic: Fix passing zero to PTR_ERR in
 usnic_ib_pci_probe()
Message-ID: <20250323131340.GA305901@ziepe.ca>
References: <20250323033414.1716788-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323033414.1716788-1-yuehaibing@huawei.com>

On Sun, Mar 23, 2025 at 11:34:14AM +0800, Yue Haibing wrote:
> drivers/infiniband/hw/usnic/usnic_ib_main.c:590
>  usnic_ib_pci_probe() warn: passing zero to 'PTR_ERR'
> 
> Use err code in usnic_err() to fix this.
> 
> Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
> index 4ddcd5860e0f..e40370f9ff25 100644
> --- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
> +++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
> @@ -587,9 +587,9 @@ static int usnic_ib_pci_probe(struct pci_dev *pdev,
>  
>  	pf = usnic_ib_discover_pf(vf->vnic);
>  	if (IS_ERR_OR_NULL(pf)) {

usnic_ib_discover_pf() doesn't return NULL, just remove this test
instead.

You could also fix this:

	us_ibdev = usnic_ib_device_add(parent_pci);
	if (IS_ERR_OR_NULL(us_ibdev)) {
		us_ibdev = us_ibdev ? us_ibdev : ERR_PTR(-EFAULT);

So that device_add doesn't weirdly return NULL and EFAULT, probably
just return NULL on all failures.

Jason

