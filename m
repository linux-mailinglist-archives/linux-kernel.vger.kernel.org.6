Return-Path: <linux-kernel+bounces-186805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6738CC985
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF96A1F22338
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B0149DE6;
	Wed, 22 May 2024 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RC8GZmO8"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5AC1422A3
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716419980; cv=none; b=Yr/VSrwK1WCrg/6UVbERJbRmB3oERi1l5dUdVwaXNtGS+ai6v3wU54DKEAzstN2EQ/NYVc5NJHUu59Ls+L+KRK+fd204Ft+enLpgOtfQCyTo2kiT5rtuOas03M+IgsHdPWEnGGZngjara3odLYjDD0keF1EvaeXNHvAz24CllVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716419980; c=relaxed/simple;
	bh=n5slVlqOAykID9MEbfympq1Zg8oJL6MvLOqRwWH0S0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8y8cHR2Z1cabPyI/6GqTk41/H3E8ORkmaT3eeKbH1lycUYoOquh0erR35L2OBAXCV7iRhyl3eKCuxx8jXDN96sobWOvYP4AHiDMJ+cNiGT8hTksMK2nqfKHxuG+p9FogBKpLUVYf+osWkPMBy8WKJtwvwv2KwqcjvvrAWK291U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RC8GZmO8; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-47f02dfe3adso505026137.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716419977; x=1717024777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UrSl/xjV6yIg0FZx3wy10QWpD7zCQXutDkJQvlsFhyU=;
        b=RC8GZmO8+77ERwhYuEMryD/cl8rtQZawDw2HYLW8XTen9nrbK8vxSqj6OzlhTeeQ2T
         jawz05EmY3+v2z5RoxovUwxOnf48Mlzect0tQxFz+kdsj8fuV2gSZ9DyUdIivBO7Tds4
         KzG3B4xWjy3EWG3zPY387aHH2RFUtcyO+S+Xzkpf2w/gGLW3GzRmDNqSd6gu5TVbFmwy
         WTni6m3nwNcMfuB7Kqu1pSXpt/2gB6AzzelnUx7QB3Z0Mhup1VR+CdQK0FjXZiGOjXqI
         HIE4Zf8ds3kvMXrRq3wDgd/6Of9nT6hqYnQQyJR1kA2tGQea7BxYejRncy4vwAM6EZ1f
         BueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716419977; x=1717024777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrSl/xjV6yIg0FZx3wy10QWpD7zCQXutDkJQvlsFhyU=;
        b=SiYYz3KOpxoT2HTdHHEXAhcSb4a5Rp8X3w+Qpj0CAwTiDgFWRMdrbWZfNsWZc31cNT
         CNX6/SohbN5SzI/+OY7m3WJ6N4HofnPw/vxceBMMcjKaKXBaiHd/nKvla5AmoAo5BNmW
         7gk7jfQhynOnnyH0yCMQURT2E8YtLRnAtgfvNJ8+DRY3WPP+XBgwcnrBO8NicTwD6Fm4
         rxAjjqaLvBALTpioZ5g7M84/Nqm9VMrV8zAaUqzejZ0+OXmIyIajpObCHCsDVxP1SQZv
         z6siygVRC5YvniErkzWbWTxkx/9/fgCT1qUY02oz9ftLIUWZBzK0KM9O8elhQa8aX4x2
         GQ4g==
X-Forwarded-Encrypted: i=1; AJvYcCWpPAYtWPBX4Wj+hMx0y+kFdKlGZ9C4VQdP00wwalozTEgXDVXHA7Sydv2AJzVBFfoULncgyES7WKVqoEoN+ktnMpeAkPgIF5V3F/Pl
X-Gm-Message-State: AOJu0YyLfvHqcgZ3c0teOSmKAFMyr5Rv0bP6t/5VEQLddd/nIFK/1I0j
	6KGWNIotmegRzVF4tf5Jl7JdFJb5fuoRB7O3m9fKdauf6z20T0pYLam+Pnyc6yM=
X-Google-Smtp-Source: AGHT+IGensuS5Pk2fc/N9/agazTDQfEmFFa3e6WHotIo6avs9UZXDQxrWdOHLx2cieNHiAlEyTlUGA==
X-Received: by 2002:a05:6102:a4a:b0:47b:b5a0:6708 with SMTP id ada2fe7eead31-4890a275ffdmr3677299137.23.1716419977636;
        Wed, 22 May 2024 16:19:37 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1ce6b9sm137775086d6.83.2024.05.22.16.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:19:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s9vF9-00DcH9-UV;
	Wed, 22 May 2024 20:19:35 -0300
Date: Wed, 22 May 2024 20:19:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/3] vfio/pci: Tolerate oversized BARs by disallowing mmap
Message-ID: <20240522231935.GG69273@ziepe.ca>
References: <20240521-vfio_pci_mmap-v1-0-2f6315e0054e@linux.ibm.com>
 <20240521-vfio_pci_mmap-v1-2-2f6315e0054e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-vfio_pci_mmap-v1-2-2f6315e0054e@linux.ibm.com>

On Tue, May 21, 2024 at 02:14:58PM +0200, Niklas Schnelle wrote:
> On s390 there is a virtual PCI device called ISM which has a few rather
> annoying oddities. For one it claims to have a 256 TiB PCI BAR (not
> a typo) which leads to any attempt to mmap() it failing during vmap.
> 
> Even if one tried to map this "BAR" only partially the mapping would not
> be usable on systems with MIO support enabled however. This is because
> of another oddity in that this virtual PCI device does not support the
> newer memory I/O (MIO) PCI instructions and legacy PCI instructions are
> not accessible by user-space when MIO is in use. If this device needs to
> be accessed by user-space it will thus need a vfio-pci variant driver.
> Until then work around both issues by excluding resources which don't
> fit between IOREMAP_START and IOREMAP_END in vfio_pci_probe_mmaps().
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

