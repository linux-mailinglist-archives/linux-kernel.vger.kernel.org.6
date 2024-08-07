Return-Path: <linux-kernel+bounces-278115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6367C94AB50
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0BB282C59
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6432413213A;
	Wed,  7 Aug 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BiBqr+6K"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B551823C8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043057; cv=none; b=sRlPZdpU2Ka0XwlJwkOictuAZbxeK4T1i67C82t9CDxo44k5H2bXFm4Zk34uYRsS4OH9JphZDEuxI3h7B57876ozzcz0oHzxKKSAneXk6AWl5O8n1uSUrCBql549WJyGkL6wANS7FABoeCzxoLVYIZNXkcxna+6ol34OyAj8oRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043057; c=relaxed/simple;
	bh=9/AgtS1xl+hUVG+/ngIpGUPthHDHXYwAlaqfvl9/mj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTekeaqbVw5YvJMzYZdC78XLjLfl76LmOFpf6qX24vyPQnLLTfbAv7hHvnoFf6H8hESHRxL3l/cZIk67FYPXBK8r8ttLF0lKeGqWaAVI7IzfD8lo29viVsC/yuEas5XqxYn/fIIlz0/Yst6iR78ZPQoxttkOYF9WzF8ZgPaUavQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BiBqr+6K; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-710afd56c99so784728b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723043055; x=1723647855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RIRNLkw9dTzgIpXpghTsmUqrsJ/SAPgpl7FytrsGTJU=;
        b=BiBqr+6KUH9+ux6k7PZl+koLT18Suii6gOs9vLxNU55YJ7nRtd0LMfcZFJvfJ0ojpN
         HMVqiRDdGuo9PbiXMyXw60t/pZgs7OlKAOC1kRj5vwuIE5bzR0B2YZJ99ivLonC44Hf9
         WHQBcTDGMlvLySjPfIduCbCmKaA+DlFOZfuPzweqfK8055FI58Xq9JgwWL2PZ2QP05jG
         vy1/E5kQWSec9hwrt2/ImYFIURbTbDOommzeUiYgA60Ya0eQ7DUe1cQfAPVYZHj5oQLb
         KfDK4AZaNPK2y5/VySnkSavtaYdeYLW+j4Ns5n4c6zVZNNr4s4gBY/hgFOiRxhso0Pw6
         0N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723043055; x=1723647855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIRNLkw9dTzgIpXpghTsmUqrsJ/SAPgpl7FytrsGTJU=;
        b=OWMt4lBHmhWmkWFvxSPJOdYPO0K91KPXVsUcUI8AVgpvvNNSDdXBSgkVLDJUBdrBlh
         KE2/7RH6Cc3O6+iH3kg2UY6BEIL/bg24qSDO28h4nQRp2Tl5U3hqwibh4RUQiVrs82br
         sySgAbq2eLXmrvaO5zMg5qEjmUg1Tls1Skrzlyx6q9kM5hRKmr8v7y1W2NzDeP5eR0mI
         3E1XGp0xAE8tXKoSAvF0o5v8XYh2eFmUwF+SdP1rF2VyGAe5VvjoPcK4SPYsJC2jsBtI
         ojnq7td3Nd/GT8Ajczu4TQow1GOtvztYhXwaWyL/Cs4wjVuK1AdfDSkG2Z514Opzys3M
         MdWw==
X-Forwarded-Encrypted: i=1; AJvYcCXZaJHWxTaYdQUcIvw0blZrfFibtQp8xGjZ4huFGc1p73/Mq2OmRrmba84yju+YmJRrOr7rMRVCPDA7VJU0D5iCGQij+hRSvd7RMcbz
X-Gm-Message-State: AOJu0Yx8PI2sZqJjDfVOuHbPlGkvslxTDn/jrcDd7rXvi5cF8egJs4ml
	CvpvBYmTOIKJV+OJkN5GVg4uS1VGAfjH663QwOGHu64y0i0VFGrt036z/GMeRA==
X-Google-Smtp-Source: AGHT+IFUq3a888UA6wQ7lTpYeaEGuRpyGPntz4KOze7iKWL5Lbq2AqEWrIvFsDKl9yLEGbIl3Z7fZw==
X-Received: by 2002:a05:6a00:9155:b0:70d:32bf:aa45 with SMTP id d2e1a72fcca58-710bc916b4fmr3349555b3a.14.1723043055153;
        Wed, 07 Aug 2024 08:04:15 -0700 (PDT)
Received: from thinkpad ([120.60.60.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfd064sm8809352b3a.170.2024.08.07.08.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:04:14 -0700 (PDT)
Date: Wed, 7 Aug 2024 20:33:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound windows
Message-ID: <20240807150357.GB5664@thinkpad>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-10-james.quinlan@broadcom.com>
 <20240807140401.GJ3412@thinkpad>
 <c32a28f3-aa64-4e89-a8f7-acfaed8ac090@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c32a28f3-aa64-4e89-a8f7-acfaed8ac090@broadcom.com>

On Wed, Aug 07, 2024 at 07:16:44AM -0700, Florian Fainelli wrote:
> 
> 
> On 8/7/2024 7:04 AM, Manivannan Sadhasivam wrote:
> > On Wed, Jul 31, 2024 at 06:28:23PM -0400, Jim Quinlan wrote:
> > > Provide support for new chips with multiple inbound windows while
> > > keeping the legacy support for the older chips.
> > > 
> > > In existing chips there are three inbound windows with fixed purposes: the
> > > first was for mapping SoC internal registers, the second was for memory,
> > > and the third was for memory but with the endian swapped.  Typically, only
> > > one window was used.
> > > 
> > > Complicating the inbound window usage was the fact that the PCIe HW would
> > > do a baroque internal mapping of system memory, and concatenate the regions
> > > of multiple memory controllers.
> > > 
> > > Newer chips such as the 7712 and Cable Modem SOCs take a step forward and
> > > drop the internal mapping while providing for multiple inbound windows.
> > > This works in concert with the dma-ranges property, where each provided
> > > range becomes an inbound window.
> > > 
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > ---
> 
> [snip]
> 
> > > +static void set_inbound_win_registers(struct brcm_pcie *pcie,
> > > +				      const struct inbound_win *inbound_wins,
> > > +				      int num_inbound_wins)
> > > +{
> > > +	void __iomem *base = pcie->base;
> > > +	int i;
> > > +
> > > +	for (i = 1; i <= num_inbound_wins; i++) {
> > > +		u64 pci_offset = inbound_wins[i].pci_offset;
> > > +		u64 cpu_addr = inbound_wins[i].cpu_addr;
> > > +		u64 size = inbound_wins[i].size;
> > > +		u32 reg_offset = brcm_bar_reg_offset(i);
> > > +		u32 tmp = lower_32_bits(pci_offset);
> > > +
> > > +		u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(size),
> > > +				  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK);
> > > +
> > > +		/* Write low */
> > > +		writel(tmp, base + reg_offset);
> > 
> > Can you use writel_relaxed() instead? Here and below. I don't see a necessity to
> > use the barrier that comes with non-relaxed version of writel.
> 
> Out of curiosity what is the reasoning here for asking to use
> writel_relaxed(), this is not a hot path, this is a configuration path
> anyway. I am not certain clear on the implication of using writel_relaxed()
> on systems like 7712/2712 where the busing is different from the other STB
> chips.

It is the general recommendation (although not documented). If the code path do
not need ordering/barrier, then there is no need for non-relaxed variants.

Btw, if the register accesses are to the same domain (like PCIe), then certainly
you do not need barrier as writes to the same domain are ordered.

Problem with readl/writel is that the drivers started using non-relaxed variants
as if it is a norm and completely ignored the relaxed variants.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

