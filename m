Return-Path: <linux-kernel+bounces-253324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCAB931F81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C231F21DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9448F182B9;
	Tue, 16 Jul 2024 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yl8upRbp"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524E15ACA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721102408; cv=none; b=P7XD9RW8sctzbIZ6E85tXa03VYbH0kYlmJKvXbfshoL2YnkN+buUL5l0NHPHyI5WYn8DygkJAb1PAylF1Xd0AYaXszuPzlGJhSu0Ue5Sj3bxTzoAFbOsPVg2+avlR1vhPCGzeIjnJe2h0gIAS0iE9TmNN+oLt7oMBmgSCQ6yw2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721102408; c=relaxed/simple;
	bh=w6wrS5/gCqtqzxcgqChtIUqQYumuveue6NsiaJ4awY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bknVmwmXFkzBDbXAh9OcK7m9VIV7qH/iU48l0UuR8zVS9InNN6bRTD1lCcNNZKXgcBfMEMyUHqG4/lHmwMtNHh3vtjxo575+AKfAaVEI3KExN7O7tTqPKShdK75btpwO6rnNY4UB4rcCJtSq3cVWNs6W2B/rWEniVzk+/e+ZIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yl8upRbp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b0d0fefe3so3347405b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721102407; x=1721707207; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zLiH0A1+RV+/g86YHPvhurkf2DOSCRyhqfiaE8DKamM=;
        b=yl8upRbp3eJVIPF6BuXo5ZFIcPTLMNZU5cL0gO706YOohsYJ4Fk3C86HPZWVFMirad
         EcjcjXKI70t5a92pvtbGnz8jQuELzt31SyxfYGntwPBehk1vDiDddVRRufb3738Bq5uA
         ZDqnzZQSkVpEPM0oEPhmEBQCTWbJ6ZGyfNLfDTIvlxQjlBPzbUiJpYbC/Gssfv7qYGPG
         bhHA+QtwpAuTyQoFw0NYaiOQjsiQkZYiyqDcdpXBTaN45uiMVVz0WUqzTwqpX31vO65I
         aLUPZx65zTgSp8UZQMsH5jDJ6HDjbDTMGg2N4KMbeTbX1xow4tVHf28e34ZtcHooCUyr
         5Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721102407; x=1721707207;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLiH0A1+RV+/g86YHPvhurkf2DOSCRyhqfiaE8DKamM=;
        b=PGsTCjzFH3l6H0rZPNfuhv9vxM3WQOSfELhKjSadeiu6r3HBj71TT7GdoePEvqrrsL
         XKnRcvfhqfwereybc2dMM/v6kbGD2eRDctIAkrrY+moeu+8EUvdw++rs7k0BoDXyLS/A
         7m9ddLB7ev25AeHBs+MoRzLWnsH+f5z6E6wgtFGQjnrFlo/rCXUnWqvMUcGb0EwcJOT4
         Lvk3+VR8h1Fkwjhgu0wXQGkVv4K+TjMYgN6Z6J0e79qeO17yWBuoMpa0Zodsgg/ZZh7b
         AUo4sDAp049th69f7fRYCsMLBYxrk5C/aXcDjLumHZgTFSCIfE8XU8QQ45/p9+MtpuHG
         zNug==
X-Forwarded-Encrypted: i=1; AJvYcCXMM/YDpu2YO+7j8Wz5M7xEPGS0UyEz3xo5q+Vs7VW5hUQmoXnec3W3L1Xb40pDP58ThyD77IJ7Nq/pyK5oIJtXmUYYvEWiB/hDZO0h
X-Gm-Message-State: AOJu0YwamTeCOo9MfPfoqPoFXxPZejnn+UQW9l8gyhL8SbPILv4YCTJj
	WcUMLIDo4A8sLeI2Htz9onSo5CgqRbrIKwzUd4D7J3cnUuuMXtKMk7lGv02/Yw==
X-Google-Smtp-Source: AGHT+IHXhRWSmbOP79s1ERaN+4g8E688ydkNtmFevDn0uwyyShCGHGv/A9gTzb6yCOwb1QPd5C+MEA==
X-Received: by 2002:a05:6a00:3cc4:b0:70b:2a:15da with SMTP id d2e1a72fcca58-70c1fb3c33fmr1093386b3a.4.1721102405137;
        Mon, 15 Jul 2024 21:00:05 -0700 (PDT)
Received: from thinkpad ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca776esm5196790b3a.163.2024.07.15.21.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 21:00:04 -0700 (PDT)
Date: Tue, 16 Jul 2024 09:29:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 00/14] PCI: qcom: Simulate PCIe hotplug using 'global'
 interrupt
Message-ID: <20240716035959.GA3446@thinkpad>
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
 <b56c54ae-f12e-4c2c-bb55-6a64695a1c94@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b56c54ae-f12e-4c2c-bb55-6a64695a1c94@linaro.org>

On Mon, Jul 15, 2024 at 10:10:47PM +0200, Konrad Dybcio wrote:
> On 15.07.2024 7:33 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > Hi,
> > 
> > This series adds support to simulate PCIe hotplug using the Qcom specific
> > 'global' IRQ. Historically, Qcom PCIe RC controllers lack standard hotplug
> > support. So when an endpoint is attached to the SoC, users have to rescan the
> > bus manually to enumerate the device. But this can be avoided by simulating the
> > PCIe hotplug using Qcom specific way.
> > 
> > Qcom PCIe RC controllers are capable of generating the 'global' SPI interrupt
> > to the host CPUs. The device driver can use this event to identify events such
> > as PCIe link specific events, safety events etc...
> > 
> > One such event is the PCIe Link up event generated when an endpoint is detected
> > on the bus and the Link is 'up'. This event can be used to simulate the PCIe
> > hotplug in the Qcom SoCs.
> > 
> > So add support for capturing the PCIe Link up event using the 'global' interrupt
> > in the driver. Once the Link up event is received, the bus underneath the host
> > bridge is scanned to enumerate PCIe endpoint devices, thus simulating hotplug.
> > 
> > This series also has some cleanups to the Qcom PCIe EP controller driver for
> > interrupt handling.
> 
> Welp I've reviewed this series, and only now came to the realization that
> the PCIe RC and PCIe EP descriptions are borderline identical.. perhaps for
> new platforms we could get a new binding that could have a structure like
> 
> pcie@abcd1234 {
> 	// commmon properties
> 
> 	pcie-ep {
> 		// ep specifics
> 	};
> 
> 	pcie-rc {
> 		// rc specifics
> 	}
> };
> 
> or better yet, have a single node no matter what, but consume only the
> required resources from the driver and have something akin to phy-mode,
> just like we solved the DP/eDP dual-mode controller story
> 
> Although here it may not be so simple given there's properties like
> iommu-map that map to bus specifics..
> 

It's not that simple, but I wouldn't rule out the technical possibility. Also
with the addition of PCIe bridges and endpoint descriptions (thanks to the new
pwrctl driver), it will look even messier.

And then there will also be the driver side ugliness...

- Mani

-- 
மணிவண்ணன் சதாசிவம்

