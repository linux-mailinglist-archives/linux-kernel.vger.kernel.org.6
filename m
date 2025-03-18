Return-Path: <linux-kernel+bounces-565647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A25A66CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F81C424418
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF04417A309;
	Tue, 18 Mar 2025 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gHLMemDd"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854F1E8357
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284166; cv=none; b=G6bO2iz/R1QkvpcJmYa8iFduH2ei7gYqzTZ3r7d3xS0FEd6pu9lImJK6Y0/gHwksuH31DzlXum01FFyNal3LK7+wE5U7CTFOw5oLlSoiuKSKqWz0HYVZf1YCo7bHilykVVN0nCjZlfgFqpX3xyfm/j86w2ZBwpRS4HWF1JqjEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284166; c=relaxed/simple;
	bh=3esxDzO1vXxe0Pp8AngxqXrndMvDlKWTXyN6Qrtc1LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0T15tqCaKr6ZQW1hFbFcrr28cyfSqAt7ParCUlqSf1je+izZrUeP8ptM9gOQxjZNpxQV43BA/4Qft+/4bX8USaefART4BwpHi4g3SN3rvdTcsAz6khECq/Q9tnVoMU1sSMvXoq7tpgvIlV7lXtcNYTL1vqIBlEh4JvkNnaqXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gHLMemDd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22423adf751so88838705ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742284164; x=1742888964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4gk6oJcdXjJrwsMImt/znJgOTOwkBmDOkZsDuxU3Rxs=;
        b=gHLMemDdw6wvNEPLA0rw/ywI2g3U4wN00pFrPSqsddWtos6sABylGbL22MRuP2MXmR
         ixVonI3BT84RjsjOSy4lkDa4Wr7CKlUROt86Sa22J/lQyDkUhMZvL4g4jyGv/F/v4S1e
         B+0NL0IcZ89frjYKEMnLdzPmDldKDIuqZw74WPhYJnqVHMOziqOIo7f5dL3GL9NhEt4e
         CK9DqZWtqperSYUE9Xq88cLKWBIU+3fk+CIqMcyxzCR4W6TM4zmAk4mn23KZ/1CQf2Ot
         GW3qijhVh1EaaM0yea66Og6fiYnTjWBFvRC4qMlkQNYxMwst4E+6BSlW0n7NggyDC933
         HA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742284164; x=1742888964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gk6oJcdXjJrwsMImt/znJgOTOwkBmDOkZsDuxU3Rxs=;
        b=plrxqfFS8yg0Lfs1qPs+uVJfvlRs5Jcju5pKaz7G+bB9zXv8+OdVcauyegUgjG4DbY
         TrFuUx33SqQsgAeBtMs578kCDytdc5yFubPJqAYWGueOv4tUFAq4WP8LxzucgbZusF2+
         v/bfK/fb0mj1js4aUmZvOwBE/LEzSPopv2i5FhNiwqL4x5dMsaHqMQQmSaBKiUeDBwXC
         58z97qX2FwkFlteHN/Q1HwPCsAK8bAnrmKMq3aitBWiVb0GgkaH7COibV9lFezZPZKuf
         xAAnCo6ti0mxT8/tNkNQiU2XzWAAymk8G+lLkynU6O2leeM65lIZ+7bO9IzI/knwwCdH
         aRRg==
X-Forwarded-Encrypted: i=1; AJvYcCU4kQyoWyez1lQizT/bpFVCq6YkSBhvLfQxMk8/ad5S7y/gG8CioaA6lY6rWtC04mlIWyjj7nUcA10wcGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQeVG/qYqnzXeoeM+m6FV6+tX877U5K6cqfqXDxs/KOT8BzFTW
	GHWSNgbWE+HQF/1iNLWTrCFvo3OoSNWUJwji+YeQg7Yw/0WRUtzrRH08DCNE7DTNJ4dmBRQK+LQ
	=
X-Gm-Gg: ASbGnctbUdPXUGp8aGtDPXATubXAHgE9ar/gNs11b6vnQR1TXOPHef6uJzoozzWFHn8
	Jh/kU90pwU+im++Wid1FKG2QKVr46OLT4doEnteBQ32aBywlxHa2bVAd+nsqqj3T+EhUyE99oJb
	vPw6zwp0SP1G8eMwUFFu6K2yflE7DkpSQBeZgvg3JjJT8UOGbyjhOZ6JggzAf9qZirXDCtQwBcX
	S5dgWAIQbs/mixM8Q2ZQLKNR66ik+9m9YzqKEYRyYgS5wABkuSSmqRXry5c7aiOe8B7aTYzENau
	54wLhr9jOwVYl16Jz39wDvAS9k78zqfer91qD4ALcWFfJCcXGoOUOqHG
X-Google-Smtp-Source: AGHT+IH069HRnLK7GJqqbw6Dd1HNX+3REq1qkSJVtn6/nxb/rYTa5SmZP93qVfdUgG49SQLEkOhpBg==
X-Received: by 2002:a05:6a00:9a7:b0:730:927c:d451 with SMTP id d2e1a72fcca58-7372246dacbmr21313065b3a.20.1742284163790;
        Tue, 18 Mar 2025 00:49:23 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711559fbdsm9171304b3a.59.2025.03.18.00.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:49:23 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:19:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org,
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com,
	thomas.richard@bootlin.com, bwawrzyn@cisco.com,
	linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH 1/4] PCI: cadence: Add support to build pcie-cadence
 library as a kernel module
Message-ID: <20250318074917.inhspuuypxmaioqe@thinkpad>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-2-s-vadapalli@ti.com>
 <20250313174416.n3c4srf6hb2l3bvg@thinkpad>
 <20250314065444.fmvhyqmuefnm4mcq@uda0492258>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314065444.fmvhyqmuefnm4mcq@uda0492258>

On Fri, Mar 14, 2025 at 12:24:44PM +0530, Siddharth Vadapalli wrote:
> On Thu, Mar 13, 2025 at 11:14:16PM +0530, Manivannan Sadhasivam wrote:
> 
> Hello Mani,
> 
> > On Fri, Mar 07, 2025 at 04:01:25PM +0530, Siddharth Vadapalli wrote:
> > > From: Kishon Vijay Abraham I <kishon@ti.com>
> > > 
> > > Currently, the Cadence PCIe controller driver can be built as a built-in
> > > module only. Since PCIe functionality is not a necessity for booting, add
> > > support to build the Cadence PCIe driver as a loadable module as well.
> > > 
> > > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > > ---
> > >  drivers/pci/controller/cadence/Kconfig             |  6 +++---
> > >  drivers/pci/controller/cadence/pcie-cadence-ep.c   |  6 ++++++
> > >  drivers/pci/controller/cadence/pcie-cadence-host.c |  9 +++++++++
> > >  drivers/pci/controller/cadence/pcie-cadence.c      | 12 ++++++++++++
> > >  drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++--
> > >  5 files changed, 32 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> > > index 8a0044bb3989..82b58096eea0 100644
> > > --- a/drivers/pci/controller/cadence/Kconfig
> > > +++ b/drivers/pci/controller/cadence/Kconfig
> > > @@ -4,16 +4,16 @@ menu "Cadence-based PCIe controllers"
> > >  	depends on PCI
> > >  
> > >  config PCIE_CADENCE
> > > -	bool
> > > +	tristate
> > >  
> > >  config PCIE_CADENCE_HOST
> > > -	bool
> > > +	tristate
> > >  	depends on OF
> > >  	select IRQ_DOMAIN
> > 
> > Even though this was added earlier, looks like not needed.
> 
> Thank you for reviewing this patch.
> 
> drivers/pci/controller/cadence/Kconfig has the following:
> ...
> 	config PCIE_CADENCE_HOST
> 		bool
> 		depends on OF
> 		select IRQ_DOMAIN
> 		select PCIE_CADENCE
> ...
> 	config PCI_J721E_HOST
> 		bool "TI J721E PCIe controller (host mode)"
> 		depends on ARCH_K3 || COMPILE_TEST
> 		depends on OF
> 		select PCIE_CADENCE_HOST
> 		select PCI_J721E
> ...
> So PCI_J721E_HOST selects PCIE_CADENCE_HOST which in turn selects
> PCIE_CADENCE. As of now, none of these configs are enabled in
> arm64-defconfig, and they also will not be accepted as built-in modules
> as it will bloat the Linux Image for everyone. For that reason, they are
> all being converted to loadable modules, and their configs will eventually
> be enabled in arm64-defconfig as loadable modules.
> 
> Please let me know if I misunderstood your comment regarding the quoted
> change not being required.
> 

Yes, you misunderstood indeed :) My earlier comment was about IRQ_DOMAIN symbol
which looked like not needed at all.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

