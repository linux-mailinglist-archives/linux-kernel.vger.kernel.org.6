Return-Path: <linux-kernel+bounces-548472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F2A5454C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163397A7E99
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3C020896D;
	Thu,  6 Mar 2025 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="jjqyJYr3"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E820896C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250895; cv=none; b=f4KONTa3aK5Uo7iXgQ4h2ZJPKh6BGa5k4TKZWE0hdXgl9Zs4LV7T4Wxje0nqYzCOLOcxQASbVIdnbku1YQVXD3vpNM7wM5jhqCYTVyMgQHdCBgdTmYXZnl+KzRBtA6wDcyQsqvv1BQR34C9928BBlBshtaVUmJbJazd/I72Hg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250895; c=relaxed/simple;
	bh=eN2UxJs/P0sNcKbeYZx5A6ber95WpSjYnmsGggEt1+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRH0mK6SqGOK5XON9jC6jML9TRnioc96aRi+/ZYTlbgGYtAaUxzAUYxQOxyhfC6Lb5gpI9aW4KmkLqG5X5/WKhDvXvmBv24WiO0EAfQwJ2tLvTIVy8660+JSygVpbIE/ewfuxVv9ua/G9A7AIeXxGxw6PiHGgjjtzgDhSVvuxpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=jjqyJYr3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so326829a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 00:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1741250893; x=1741855693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4k+jXFhr9NDIRUmOU/UyvLqGcx7hV3cHJqh3EvrMGk=;
        b=jjqyJYr3BZ2t+TXJRZksijLIUHO9KQVi+rASpiLxjcieoe84XmIDYaR3WXCAPOBTJy
         UyqZV++9uyWRP0DOEpTIUgv1ftKbXH4HnIhd4tCpKqCDPWlmyKIokgPKo87aKdis3nC4
         5SXmwax1sJcACkem++Gr3d3A8A62Q2SxSo2XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741250893; x=1741855693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4k+jXFhr9NDIRUmOU/UyvLqGcx7hV3cHJqh3EvrMGk=;
        b=XA4gLErreFhgBV6BoSAcQUaUfjXPcQArQLOwCkPPdsT3F3dfk39xjoIliXnwOP5rJ4
         Nth7TAcHfuX1frYZHMStP1ZE+f4PyX/Bx7Hp16Zl3Ht8n2jLWaksyb3qekNXqe32U/ls
         GDnI3H+ICHnlbH1ZqF1ouzXf4OuZApI70F29DgZE1fckJ4uKBmgjWAn5nFPqDcD05aAW
         inkXJYHlLn1NRC9sULb7Yl+NwkKrfQ+SWyNQe7BfqG+nXEyYNfOUPAe/2XUq30v6Dlk8
         HUUM0mQ3Jz/L4wCZk+P3+NA3463TH37PB8L2xWsRMaLVUoQdgBx+UrC74zgxNHa+Icnb
         6rkA==
X-Gm-Message-State: AOJu0YzSZ1qTt8vldBtZr5gF7M8OMgY1q+NxITUcNJk/dpIUoviJEst6
	v/tqInhvDHBhDhv9PaluQwVAMR92fS25fUlk9LZt/9urDmFt37Uho9IOiz4oRFs=
X-Gm-Gg: ASbGncsEGAQSwSFDF7qV/6mpDf5Ulxr3ANCGVSGg69k5rokW4Rf1gtq6LGdsgBxWZ2V
	qbRCrMSkJrk3vuiPcwXw6p5DLk5b63jKHjjJ3t7pqenUHizTHK2qbZLzGns/o2OxQzm4NVTF/Gw
	3Lbrqf50y78lVhF5r/92gMNfBYFS3JjeytEoqY2rHyaCNEQw4EWcsqxiuenCrF1e46/ewRD6kHS
	CQBe9+T4v2GeX5Oee90gyRXdZ4+bKSmx5BgyJeW2vbkAgr1IF6QCiWiSZUYF0832PLPDDcvddlA
	mqlikalIHDLYSxfaj1kDz016bHmMrlh8i0B7hIbDUpAfxjC1aA==
X-Google-Smtp-Source: AGHT+IFzZ0vFCL7WbpviFO4L9vuMIRkk6grLTKfpSaA2lbSdMUSiTAorLN0JYGBYyPjaalZWK0RreA==
X-Received: by 2002:a17:90b:524f:b0:2fe:ba82:ca5 with SMTP id 98e67ed59e1d1-2ff497283aamr10783848a91.11.1741250893553;
        Thu, 06 Mar 2025 00:48:13 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff6933b039sm727306a91.1.2025.03.06.00.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:48:13 -0800 (PST)
Date: Thu, 6 Mar 2025 09:48:07 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 0/3] xen: Fix usage of devices behind a VMD bridge
Message-ID: <Z8lhR2DSsB8P6L96@macbook.local>
References: <20250219092059.90850-1-roger.pau@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219092059.90850-1-roger.pau@citrix.com>

Hello,

I've attempted to ping Nirmal directly on the VMD patch, but got no
reply so far.

First version of this series was posted on 10/01, yet there hasn't
been any feedback from Nirmal.  Would it be possible to merge this
without Nirmal Ack due to timeout?

It's not even a new feature, just a bugfix that allows running with
VMD devices when using Xen.

Thanks, Roger.

On Wed, Feb 19, 2025 at 10:20:54AM +0100, Roger Pau Monne wrote:
> Hello,
> 
> The following series should fix the usage of devices behind a VMD bridge
> when running Linux as a Xen PV hardware domain (dom0).  I've only been
> able to test PV. I think PVH should also work but I don't have hardware
> capable of testing it right now.
> 
> I don't expect the first two patches to be problematic, the last patch
> is likely to be more controversial.  I've tested it internally and
> didn't see any issues, but my testing of PV mode is mostly limited to
> dom0.
> 
> Thanks, Roger.
> 
> Roger Pau Monne (3):
>   xen/pci: Do not register devices with segments >= 0x10000
>   PCI: vmd: Disable MSI remapping bypass under Xen
>   PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag
> 
>  arch/x86/pci/xen.c           |  8 ++------
>  drivers/pci/controller/vmd.c | 20 +++++++++++++++++++
>  drivers/pci/msi/msi.c        | 37 ++++++++++++++++++++----------------
>  drivers/xen/pci.c            | 32 +++++++++++++++++++++++++++++++
>  include/linux/msi.h          |  3 ++-
>  kernel/irq/msi.c             |  2 +-
>  6 files changed, 78 insertions(+), 24 deletions(-)
> 
> -- 
> 2.46.0
> 

