Return-Path: <linux-kernel+bounces-447660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 031AC9F35B3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F62164E98
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1526206F35;
	Mon, 16 Dec 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMRoHY4a"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7B2063D1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365830; cv=none; b=KOfSUkDK9bWZ1c0CAEq+8SM4wfKNJFLo/pmCvfsSoudeq16OSYEGA7holOmORPSoTzNENJO1C7khXtsQZR2HkZyytmybIgmVqByJTxIAjWYznPlEiw36bZvdsBT3Gz1f/9rrxcR9vLTybqS8IPva4Jhpf9Rxkr5C9+8HBDM88ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365830; c=relaxed/simple;
	bh=t8wf47QY9cmdBo63Gv0CCceIk9iBBth3UuB3w+B9zfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McvHSpg1oUkUgygT1+JdlaJmNblXKUFSjCQt3tP6s21iBMh0eZvUtcThnizuUSG9Z/tJHD34JJ20mTx/JImgBfPDeXGE8owIn1OLmHGvqNCEk9ivNFPnR1yvyIrsTcxacJ7/TqrULvXEJmCCYTZW9dbbzBeb8FEnbvYNSl0szcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EMRoHY4a; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728ec840a8aso4597612b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734365828; x=1734970628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=82gDKALWw0Ekg/l8MKhauenkjup0NAxqqSYjA8q5Flo=;
        b=EMRoHY4aeTjOHOR29cyv4zuei/iVpMLuYrSfQzyZclfe0NEXW6Jl504WqSbsqUx8Xy
         b5hpCSFig3u2axLHJnu20jv19Ba5IsKrNiFelE2gfHsvqnWFMCIfKTjHoeUL1sDoXVBf
         afShywFdFiEev+CQuTxTSPxzR4yQ7FYAj8XhplNN8NxqrN/qmwwHWsRAcADSZBGfOqIS
         aInMNWjkvwZy3nUUQE3lUsHkbKGjS/h8qFYE9uZuevWcof8ebNbhNCid6gc/sfq11E3I
         jnXBpewD3YJE9QsDWJ4VTiqibXrUPWCzAU6IgOpqEZjL0YX96WQgVW9u1nGUWJk3ewqz
         VUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734365828; x=1734970628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82gDKALWw0Ekg/l8MKhauenkjup0NAxqqSYjA8q5Flo=;
        b=PvlbdVqj5ms2eQILOweQrgh2DZl5EK2PDZCkfkTYAldG91PwB1fZYN1YR3fktlS0Qd
         iB620n//KAaJeftZEZuSEqSUdclUM1UVoKP5Vruy4hNhXEVONUW+ZY5CZLdr8RTlWdfO
         1VceDbvzd9kpRNP2vDa2Y51Fv3F7ulP3Ccg1dze2Mz5OFVeYetNvYu1niop4aNfY5YUy
         TnjpcJaC5dBuTL4c5Hwh6MTf4hdl0Ri7Fo3QKdpev6OxyloJVhw1nKkHt5y4TLvoCKJk
         8Lv1ZvO51E+7h7SC0V6Bb52DNsosuMLV1A38V4TZtyokj18FedodzmfijBI2AdwmURx0
         C2cw==
X-Forwarded-Encrypted: i=1; AJvYcCV0jcnX+bjyhFTHYug4/Yk83p+0Hez6bnFEwp9XwNuj9NM/WnZjhpoSte6Y0PQ6T9OucZtMVMrj5wmpG/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBvSPUgyPf6+xzwR4uiPar+IibKBS8iNtLbkIpgUisC3s/EkSW
	qB0sKzVFtomIaxNidgE36C4oXVCHT+meBltX+EA4ues9Ov8YwqHsWMfm4OHGXA==
X-Gm-Gg: ASbGncs3xRcYoz4rsKBmmwrQMr4yTucPbyDloRy85aKZkXq0EmpodbyD5gi80g6B1cY
	P8WNBE0hwpmwp4QL1jOySsHudCUa2RYAj0gV+We4ZwY+K+hJHOB/8kbRfNbWcBuSJPneVRbwkkN
	BOcKV33gfznnFt7ANZ8+vIg6FMtGYkUs6FRg7oBgiMboWYwq1qswxRc4nj8rn9N5BtZ+PKOy+BH
	XKgrBnhSDI/+ViH04U6Fz2sN/C3yam0kIPmvVSuFpsVJfG4lvyOdd/mfT0mSsodmXcn
X-Google-Smtp-Source: AGHT+IGvG6qXEoCqCkROvX+b6dhtMyqPUbkI3UVWtmJgHt1xZMsm2fyfByqDiqxFQpxzhlW12Qg/Wg==
X-Received: by 2002:a05:6a00:3688:b0:729:35b:542e with SMTP id d2e1a72fcca58-7290c25a4bcmr16844563b3a.16.1734365827870;
        Mon, 16 Dec 2024 08:17:07 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bb3a6dsm4925657b3a.136.2024.12.16.08.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:17:07 -0800 (PST)
Date: Mon, 16 Dec 2024 21:47:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	p.zabel@pengutronix.de, cassel@kernel.org,
	quic_schintav@quicinc.com, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: stm32: Add PCIe endpoint support for
 STM32MP25
Message-ID: <20241216161700.dtldi7fari6kafrr@thinkpad>
References: <20241126155119.1574564-1-christian.bruel@foss.st.com>
 <20241126155119.1574564-5-christian.bruel@foss.st.com>
 <20241203152230.5mdrt27u5u5ecwcz@thinkpad>
 <4e257489-4d90-4e47-a4d9-a2444627c356@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e257489-4d90-4e47-a4d9-a2444627c356@foss.st.com>

On Mon, Dec 16, 2024 at 11:02:07AM +0100, Christian Bruel wrote:
> Hi Manivanna,
> 
> On 12/3/24 16:22, Manivannan Sadhasivam wrote:
> > On Tue, Nov 26, 2024 at 04:51:18PM +0100, Christian Bruel wrote:
> > 
> > [...]
> > 
> > > +static int stm32_pcie_start_link(struct dw_pcie *pci)
> > > +{
> > > +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > +	int ret;
> > > +
> > > +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_ENABLED) {
> > > +		dev_dbg(pci->dev, "Link is already enabled\n");
> > > +		return 0;
> > > +	}
> > > +
> > > +	ret = stm32_pcie_enable_link(pci);
> > > +	if (ret) {
> > > +		dev_err(pci->dev, "PCIe cannot establish link: %d\n", ret);
> > > +		return ret;
> > > +	}
> > 
> > How the REFCLK is supplied to the endpoint? From host or generated locally?
> 
> From Host only, we don't support the separated clock model.
> 

OK. So even without refclk you are still able to access the controller
registers? So the controller CSRs should be accessible by separate local clock I
believe.

Anyhow, please add this limitation (refclk dependency from host) in commit
message.

[...]

> > > +	ret = phy_set_mode(stm32_pcie->phy, PHY_MODE_PCIE);
> > 
> > Hmm, so PHY mode is common for both endpoint and host?
> 
> Yes it is. We need to init the phy here because it is a clock source for the
> PCIe core clk
> 

Clock source? Is it coming directly to PCIe or through RCC? There is no direct
clock representation from PHY to PCIe in DT binding.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

