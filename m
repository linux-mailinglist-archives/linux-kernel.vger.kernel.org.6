Return-Path: <linux-kernel+bounces-437731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC79E97C6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129581888EAC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B81ACEA4;
	Mon,  9 Dec 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KuCxrIFL"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143533595B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752200; cv=none; b=JcMO22D+YKynbe51llTbxYR1a62u4z5qFQRqaLtRwzIQ9Hj+UTNcLO48evu+Xkw3hOO3W0dobgyhHibh/yTyIgtntbqT8d1Zh583NmYgzbw78c2euC7E4dP7GRDCm1X7+l2w1SJj3rpgwVu5TUhg937KZJ1RbZLJh1/Hsp+a0i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752200; c=relaxed/simple;
	bh=J4YDUO69JYXmaK7rKTsj+KtVjyKbXrmdSv9J3ZPhd6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNPRUi4WrFXh36DyuyssDcWl4r5FT2zVy3NPei6+RQGGBUMKQwqoYnC99bCUWVXKtT6paY8K+JJXyWZc+Ik6cI5+2XmjSC+XfgU+owkkylZwqPzAOiuTeA9jRjqkLlVXLyGlbbINFz6Ybr6BkbPkfOmTh+1+FfGNjnJvTlOOGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KuCxrIFL; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4676aad83d3so5282051cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733752196; x=1734356996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yQm6NRzBKoFkTK/j8h2ksq4bd1PuJrEmkFvS72/a7c=;
        b=KuCxrIFL+QIi008aH8/RligBv9dlIVjSV7venC5Jw8Urg5wZ3ygFMHVI4iCyVbsgJV
         i2uJrFG16c157LXxMizy8OOC8RZGUhotducQ3DgZJMGBt4KPFpiYssvU3wA5BE9wswGd
         N3pMHwN7zir78rGPser+Jf2wwZgyL47daEYOl0SKPhyXFomd6ZEotJUGI6NekHQJzGkb
         q53gKjoH88GrhEQiWjhiosYCVNzgs/boRKq0yuowiKm2Yzl3/wWh6AIAXrWzLdZLjIX5
         cWWAP1FaJ1XlcrQouo4va87NcoUrWV6QTYQlKiBkhrK/l3NUN1bZH0IjTRruYe0dJ+2a
         7U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752196; x=1734356996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yQm6NRzBKoFkTK/j8h2ksq4bd1PuJrEmkFvS72/a7c=;
        b=QlWTMBfPaXNYoiz04ZXu9Mi2fJyQ0lXDfEIKosRSMZqljcNBo5n+0pdgKFHvGjpgWJ
         55oA4Xbww8XuxVoCrGrpvoClz5Aa21QmQCjaCduC6kN6eHMbhHrxcO0R6qNZWv5TCK0K
         Le416XLFkTDzUuFAlrW8eG9xxA2SD/i6A0sQnnu6icVwTjGhx+ZDGCtix8iTZD6denZD
         S25Ewvj3OGiqXbkR5cRULrFU3L63TYkvaNStvglwpN7OsVMKa1Vpj/2ti2lEyOxOwZaI
         ccc/MdmVJ5PksL2s/zTgjjtt+PyIrjg5Ia+z9BfBcZvYxf8UaRoBbvDto5ub16j66RuC
         UmXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTWABjjOl93VG+ZMRNh4jNP2gfyMR46gohtXeNaxWMxBj7vYIjEhYK16Hg5ugRqlB7i5q70PNF1Xxjahw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw73DcQwqRRWrOLudaItWfmzBLNyY/H3IeDK5Z2TPuORYQPFM3X
	w6kFno7F+sQDMJrw1YeA4VV95UNiULGEse7YD402gLmGSLxnWDlA89a20DIKbdY=
X-Gm-Gg: ASbGncvfHVOcrvjfPjkv7bdfao2B9gjCl4zdu0JnkO+o5ZwmepN+v/8hky6b5NEv/9h
	/R5fFIqwEi+aXt02g5/F8+4/KWtyJ8Oyk2lZNeO058Pnmi0R8XtlrFIYvb1I1qXzmrpBbbFbdIq
	DGq3gL71NIp+E9C2DXLTW2ghYGMeZTLGnWPF4+JcCeMPFkI+6+480k9ihwPGr+8bHWDkzlyX0PN
	twVKEaV/OcCcgI5v51pffJku4YVe+RJzMnsNmXGU1Y7BCBWlqIpyvbI5KdQA3kaNzJqENIz4UYE
	DGXUScWMBHHe8PR98TIYvRY=
X-Google-Smtp-Source: AGHT+IEPGcEjlVPXl0LLEC/ecMx9oKz0ZCnq+q3yRQq+kzeZbdlnYmEto5Kklr6sYe6DPslMR8nNJg==
X-Received: by 2002:a05:622a:4a17:b0:466:ac03:a714 with SMTP id d75a77b69052e-46771ff4e3dmr8541981cf.36.1733752195027;
        Mon, 09 Dec 2024 05:49:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6db04175bsm32715185a.52.2024.12.09.05.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:49:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tKe93-00000009rzT-3Dxo;
	Mon, 09 Dec 2024 09:49:53 -0400
Date: Mon, 9 Dec 2024 09:49:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Longfang Liu <liulongfang@huawei.com>
Cc: alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jonathan.cameron@huawei.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH 4/5] hisi_acc_vfio_pci: bugfix the problem of
 uninstalling driver
Message-ID: <20241209134953.GA1888283@ziepe.ca>
References: <20241206093312.57588-1-liulongfang@huawei.com>
 <20241206093312.57588-5-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206093312.57588-5-liulongfang@huawei.com>

On Fri, Dec 06, 2024 at 05:33:11PM +0800, Longfang Liu wrote:
> In a live migration scenario. If the number of VFs at the
> destination is greater than the source, the recovery operation
> will fail and qemu will not be able to complete the process and
> exit after shutting down the device FD.
> 
> This will cause the driver to be unable to be unloaded normally due
> to abnormal reference counting of the live migration driver caused
> by the abnormal closing operation of fd.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 1 +
>  1 file changed, 1 insertion(+)

This one needs a fixes line and probably cc stable

Jason

