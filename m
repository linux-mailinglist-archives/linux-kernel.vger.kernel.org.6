Return-Path: <linux-kernel+bounces-408351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0299C7DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD751F22DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB1518B49F;
	Wed, 13 Nov 2024 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tyGmpIxR"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BEE18BC15
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731533935; cv=none; b=U9WtyACLJDI+lPcnBUupNzdY7b9h283bDm1t5bsjovkJW6p2+ZYs97DzBtG77ONhJMrT4HI4+f5TQzRavHL4e1w/48dlq+z8XkLi1WcpLnlnjEIuMeg4fJhBdvxkmRcA7PGMM9+nB8P8HGpvRRuXENcwKqwzmxgeb/BxL1sfA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731533935; c=relaxed/simple;
	bh=h3pNFM0oblrUYOB6pkkCwK/sr+vTUFr1C8PiWtlv8rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fd6v0bTejqbvpVzI+kZcZcpOgLs3Ccp6rxsH/PLfR2j4Cz10QjKKdH0yjpznR17u79A0uMJifs8UvVEl/Qh2qVPJMERCeIRTWdDAROQr0W+PST+LhYXXR2gNaXRVxUb+j946TzcNpG3maaIAE/6ectMs0SnAnrO8WKtIyWOigsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tyGmpIxR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ca1b6a80aso81279705ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731533932; x=1732138732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/SIxTh7J31xbTMjPP69b/bUoDVK1zzpUJ9rscgsMJY=;
        b=tyGmpIxR2G8GWmo1ECXKwrB/S61FrGFI6J+mU082jp1bade0uh/BpZDpthLvYrd+hz
         5p67nLz2PAyngYFFVQHsBVjXDyZ+0KoHoqqCK2D37x8bZ07TzMK6gPL4QLj2R4L0KgC3
         sVOFagi8bvmbao9rvorJIJjCCB1Qz9J2e3JAiHirPwcJxFjSQlMJoEG6qZTiXFKIKLPJ
         K/le1vkzw/1/nCcEzqlMc9hLCuKOscOi9yaLSF7bpBAPQvSP4KLu4o/q7W8cS//OASPT
         i/yydlo/4UMMjKTjNEPkiMJmnVIH/gR4N3dstqf8YP5t+oOwdz4joxnbO631e2pQBDX/
         xy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731533932; x=1732138732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/SIxTh7J31xbTMjPP69b/bUoDVK1zzpUJ9rscgsMJY=;
        b=WyWEiho2jWSyXtBtTjlDgZ+JDR5Cst5Pj1Xje0klMOcArUVnsnHa8iSb3HOQ6lcdgY
         3fwx7wvyd/+wK53xt6JVvPfvHxoH3OWpT0z6nwHkKovJtQJS9JQc3CJUwxNxdMez6Vml
         I6QNPave8QDyiONTPXicDIidgUA7Tab+4Nmg4FAtpUVWQoKXxGN5kaJleZ3AB+bZK1+v
         f3aEZeV92IauPFkMRvcmkzlxJ3VX8/tQaLUr9ld/aetvXxBJaf8a0uUSEsJwocBgHBl5
         HMXRWRD+i8Xpa64pq8MeMlXhaI/JyG+BF9hssxAsumxqKof7ymAhupqMr7IDBJwFyp88
         xy3g==
X-Forwarded-Encrypted: i=1; AJvYcCWGMUcm8YXmCF+koga8IxnsuqO6zOcqRP+KtAJJuxt3oVkZ+Yfja7C244LkEH4egwYyEj3uB4Y8Pakj0vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUXf8wQM6fxdPpjuY1dMICZ017DVDQrOEDKgFk7ISh2dSpOcpx
	hS64+ol3nXRw8HLw1klBXITvmyBVC4Qq91xqMWwW3atvs3zUXAl0LtxpGb5i0K0me8XxdJT7L+1
	YAGZCGUf4KmTAPTNJS7iNvse/Uw5M8Bb1xVio
X-Google-Smtp-Source: AGHT+IFSTZo8eDq5AVjULTxkBdn1QAACx9SVOAxHbG2ogMZWy2xpiXhaZKNwmM2oe/A96ZXy7LtkzQ+cUTRsIShcqKg=
X-Received: by 2002:a17:903:2447:b0:20c:895d:b41c with SMTP id
 d9443c01a7336-21183d55336mr284292875ad.41.1731533931844; Wed, 13 Nov 2024
 13:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220426172105.3663170-2-rajatja@google.com> <20241113202214.1421739-1-jperaza@google.com>
In-Reply-To: <20241113202214.1421739-1-jperaza@google.com>
From: Rajat Jain <rajatja@google.com>
Date: Wed, 13 Nov 2024 13:38:13 -0800
Message-ID: <CACK8Z6FHBj2eUp9Wrqg_ehY76hUZF7iEa+y7tFP0eT_7rdVT1Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
To: Joshua Peraza <jperaza@google.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, gregkh@linuxfoundation.org, helgaas@kernel.org, 
	iommu@lists.linux-foundation.org, jean-philippe@linaro.org, joro@8bytes.org, 
	jsbarnes@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	mika.westerberg@linux.intel.com, oohall@gmail.com, pavel@denx.de, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rajatxjain@gmail.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 12:22=E2=80=AFPM Joshua Peraza <jperaza@google.com>=
 wrote:
>
> This patchset rebases two previously posted patches supporting
> recognition of Microsoft's DmaProperty.
>
> Rajat Jain (2):
>   PCI/ACPI: Support Microsoft's "DmaProperty"
>   PCI: Rename pci_dev->untrusted to pci_dev->untrusted_dma

Thanks for resending. This probably dropped off my radar since I moved
on to other things. But I can confirm a lot of Chromebooks today in
the market already use this property (and this patchset) for
identifying untrusted DMA capable devices.

Thanks & Best Regards,

Rajat

>
>  drivers/acpi/property.c     |  3 +++
>  drivers/iommu/amd/iommu.c   |  2 +-
>  drivers/iommu/dma-iommu.c   | 12 ++++++------
>  drivers/iommu/intel/iommu.c |  2 +-
>  drivers/iommu/iommu.c       |  2 +-
>  drivers/pci/ats.c           |  2 +-
>  drivers/pci/pci-acpi.c      | 22 ++++++++++++++++++++++
>  drivers/pci/pci.c           |  2 +-
>  drivers/pci/probe.c         |  8 ++++----
>  drivers/pci/quirks.c        |  2 +-
>  include/linux/pci.h         |  5 +++--
>  11 files changed, 44 insertions(+), 18 deletions(-)
>
>
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> --
> 2.47.0.277.g8800431eea-goog
>

