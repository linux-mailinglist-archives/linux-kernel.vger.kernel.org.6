Return-Path: <linux-kernel+bounces-263996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA7993DDAA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 09:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97807284082
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 07:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FB938DD1;
	Sat, 27 Jul 2024 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbVeK7jI"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F036374EA
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722065172; cv=none; b=YKrk0+7g2a8StxcGmBwAkPhQybeLA/xvw5TJd4vUp/S0ttAYPwx7ITGojMbaZ3IvrLIX56xItqJT962fGH1KeCC5U/79z+qhU+vL/Q4voGpTcQhUdyvkpSyefK3fVzdWrf9k9zHBycXIWibQYtJMPiuK2mrJ/GWdpQEimj/DB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722065172; c=relaxed/simple;
	bh=wVyDMVru9jHoalCvIuSAZBDdlmA1W+RGwLO3NRHdVV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+j6HwkywhFSN7SsVUClnHkgRSOFb6VW4p5SUDK9bhSwAvUF9s5ljpbAiDE24H2L6+H88A4FYmG/Dhdjx7qff0EVZmMz6cWIW3NZuvvx/8qAAcdHxWiJhTDOuD3pSuA4owQowS9do+LqHx8MPq8FEvuxTbkLduSCtiMi3j+jLxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lbVeK7jI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc4fcbb131so12675985ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 00:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722065170; x=1722669970; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mgIFGhO+4R0dnQC/n0QRP0A2Ej/io3M8MqP1jjsA33k=;
        b=lbVeK7jIrHEplB5V4NHo2tqWYN8uI6ofbRBII0tsGrlLGKuJRIGBNS4xebG14zq20v
         8QVybEuRmtFQNBa3EazHMBhvQ6NvamMm0s81/KQQU7sBD9AETKcr6rkMjlbezqnKnrdT
         2yma9ehn9OuobF7+1puNcaupML+UnE07k5+bE1WpeJbFtijjcVki32drDGP1eQ2D6EvV
         caiWN+1obSKT7Qe8EcINWzj8z/vp06mhSToADxqnj6yS4AvbbCNggaSKQnvxyZCwkO1A
         /DjuQcpF4M8x8k/prIg0pL1ANTkZbsvp54x02vRH/Ex3zK8Fi/izykAnwkc5SpMfSQwB
         qf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722065170; x=1722669970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgIFGhO+4R0dnQC/n0QRP0A2Ej/io3M8MqP1jjsA33k=;
        b=ftCdDE7EtgiimoUPO1zioPYH4n98mXb0y9eqgC+pci4yGb4cRl4ykaojn2EQJzBuux
         5xoYvAbArvQ8VVUEIL/HS74VOI9ScP3zquOU+jWgkRRDY5oci5UkbCCAsX5v/WsbOM26
         MagphUeJ6jmKZcsoB/nF+J/tr+2NhHu8+7yixdx5NXw1BN6n9oUaLzhiBi3q+Unv3yhR
         lsIGtVB42r5xUUgudytXV6RaExkjL1z0rJVeM1XIxI95UStAXbxJDpLdiSl1jS7YTe33
         RNuuoHLSTTDuVui2mIctT2oi+Xsw4GsTO0I8QtPzNs9QYLz9gwt22NzqVsg49SGkI4Zd
         XDwA==
X-Forwarded-Encrypted: i=1; AJvYcCVIJNCKiYTjaNpo7UX2ietgO8hLNvUhRhOlsIBWLKWPzNc0QIfF/jCNGpBSLuvG1hBAq6t3oyyCukwCrrbhuemsBEcgoiHfETHKmmol
X-Gm-Message-State: AOJu0YxewCSacCRhb5PbfyIE5vEjAxvKZQGMKx8R/EWywRvA2VRBAWv4
	sUOL+VMCpzjzh1DKD8izrZTXkZS6b1E5sNtutZgGX1GrzFJL1T9fu/4RXvORjg==
X-Google-Smtp-Source: AGHT+IEhYA99MWB2IcFIKbgWxyTV91+WAS8vGXPD9bnGh2cV4Xg/Ih5Vc4bVcoe2exZB4aVjkbeibA==
X-Received: by 2002:a17:902:e80c:b0:1fb:3b89:b130 with SMTP id d9443c01a7336-1ff0482500amr23813065ad.19.1722065169690;
        Sat, 27 Jul 2024 00:26:09 -0700 (PDT)
Received: from thinkpad ([120.56.198.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fbfe33sm44415235ad.276.2024.07.27.00.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 00:26:09 -0700 (PDT)
Date: Sat, 27 Jul 2024 12:56:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v4 0/4] PCI: Allow D3Hot for PCI bridges in Devicetree
 based platforms
Message-ID: <20240727072603.GB2974@thinkpad>
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
 <20240511071532.GC6672@thinkpad>
 <CAJMQK-gBACa0s7qo=sOkK2UJB+9WbNHBkfg4NTxp3dVfjvugSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJMQK-gBACa0s7qo=sOkK2UJB+9WbNHBkfg4NTxp3dVfjvugSg@mail.gmail.com>

On Fri, Jul 26, 2024 at 04:06:03PM -0700, Hsin-Yi Wang wrote:
> On Fri, Jul 26, 2024 at 4:02 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Mar 26, 2024 at 04:18:16PM +0530, Manivannan Sadhasivam wrote:
> > > Hi,
> > >
> > > This series allows D3Hot for PCI bridges in Devicetree based platforms.
> > > Even though most of the bridges in Devicetree platforms support D3Hot, PCI
> > > core will allow D3Hot only when one of the following conditions are met:
> > >
> > > 1. Platform is ACPI based
> > > 2. Thunderbolt controller is used
> > > 3. pcie_port_pm=force passed in cmdline
> > >
> > > While options 1 and 2 do not apply to most of the DT based platforms,
> > > option 3 will make the life harder for distro maintainers.
> > >
> > > Initially, I tried to fix this issue by using a Devicetree property [1], but
> > > that was rejected by Bjorn and it was concluded that D3Hot should be allowed by
> > > default for all the Devicetree based platforms.
> > >
> > > During the review of v3 series, Bjorn noted several shortcomings of the
> > > pci_bridge_d3_possible() API [2] and I tried to address them in this series as
> > > well.
> > >
> > > But please note that the patches 2 and 3 needs closer review from ACPI and x86
> > > folks since I've splitted the D3Hot and D3Cold handling based on my little
> > > understanding of the code.
> > >
> > > Testing
> > > =======
> > >
> > > This series is tested on SM8450 based development board on top of [3].
> > >
> >
> > Bjorn, a gently ping on this series.
> >
> 
> Hi, I was also working on a similar patch to add bridge_d3 to arm
> platforms until I found this series, which is what we need. Also
> kindly ping on this series.
> 

Thanks a lot for testing. I will respin the series once 6.11-rc1 is out.

- Mani

> Thanks!
> 
> > - Mani
> >
> > > - Mani
> > >
> > > [1] https://lore.kernel.org/linux-pci/20240214-pcie-qcom-bridge-v3-1-3a713bbc1fd7@linaro.org/
> > > [2] https://lore.kernel.org/linux-pci/20240305175107.GA539676@bhelgaas/
> > > [3] https://lore.kernel.org/linux-arm-msm/20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org/
> > >
> > > Changes in v4:
> > > - Added pci_bridge_d3_possible() rework based on comments from Bjorn
> > > - Got rid of the DT property and allowed D3Hot by default on all DT platforms
> > >
> > > Changes in v3:
> > > - Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
> > > - Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org
> > >
> > > Changes in v2:
> > > - Switched to DT based approach as suggested by Lukas.
> > > - Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org
> > >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > > Manivannan Sadhasivam (4):
> > >       PCI/portdrv: Make use of pci_dev::bridge_d3 for checking the D3 possibility
> > >       PCI: Rename pci_bridge_d3_possible() to pci_bridge_d3_allowed()
> > >       PCI: Decouple D3Hot and D3Cold handling for bridges
> > >       PCI: Allow PCI bridges to go to D3Hot on all Devicetree based platforms
> > >
> > >  drivers/pci/bus.c          |  2 +-
> > >  drivers/pci/pci-acpi.c     |  9 ++---
> > >  drivers/pci/pci-sysfs.c    |  2 +-
> > >  drivers/pci/pci.c          | 90 ++++++++++++++++++++++++++++++++--------------
> > >  drivers/pci/pci.h          | 12 ++++---
> > >  drivers/pci/pcie/portdrv.c | 16 ++++-----
> > >  drivers/pci/remove.c       |  2 +-
> > >  include/linux/pci.h        |  3 +-
> > >  8 files changed, 89 insertions(+), 47 deletions(-)
> > > ---
> > > base-commit: 705c1da8fa4816fb0159b5602fef1df5946a3ee2
> > > change-id: 20240320-pci-bridge-d3-092e2beac438
> > >
> > > Best regards,
> > > --
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

