Return-Path: <linux-kernel+bounces-449649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF43B9F52E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2395616550E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E26F1F7568;
	Tue, 17 Dec 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAg37WfX"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73B1F7577
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456045; cv=none; b=M+M0qwNYlf14rSzhZE9WFi8RSGsZ7Xlx2ERU3b9LDCw3XJhrvo87xKzWCbjFAZLjEX4JBaQZvm2ifsebNoNX40U6agtW+6K8nwBPFu6fXplxpFxEfZYWG4qYk9ncK8NiY1KHr4fjC+6HUe3v0zXCZeM/uD/atXiLn9I9O0UXtpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456045; c=relaxed/simple;
	bh=lU3v/h95t9yKq+oPE/QPiEX37Ydf45Rwlzuvm1RuHwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyUBRAL+Zj+tHKCgbhcex/Z2o1DIEU0yOGC/z1tqAxV6Ye7vX50D+0vx93T2j6JvlkA0rVR34pZtT3BLfoiq9blb9GNU2PAx3cym5RUV4ISdJ3YO5XwJfCaTllo/m7ZsEvNVhdOEgeF8u8OO/LnThZIAjNK/Bk7Y7vg4KJlMtAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aAg37WfX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2162c0f6a39so58669485ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734456043; x=1735060843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=97u39/mB75Gyvq3MUoP9A6BWuOZp1jV8oYjBZnf5YHs=;
        b=aAg37WfXAKzH8J0gBo8+CmgbMQfNxTmLmgza8p7mM/WtKG4Udas38fPEtaCtY+COQ8
         WREMrEuUdRJIWM3Ymd0PILouuqEj3uWXJ2ZM+GVrRzxOp3nmuymm1rGPfnU7ZCmztpsK
         meVDvwXNmC6zdP1JJmkWIBpZvYmnFZ4FllTZid26VQpo5MC9INOj2k2jy56KfJXGIVNW
         vpvVOGsmL235elLgXzSlNW1tfiW0d+BDwkPqXiSBGjcC33iMaJ+FuaUJ73055VvY0dcL
         jowC5Fux9CdlXCmwEoyte6FMWxN7hArG0OBMzqpv1YmTObDdrzJjn1d73Cp+tc4RvTwY
         y0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456043; x=1735060843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97u39/mB75Gyvq3MUoP9A6BWuOZp1jV8oYjBZnf5YHs=;
        b=V93eMeuapf6dlR3UfE8PUGDbj6FQ1urqxH669tG8I5Bq/Tp0AYZWr3dAUciL8htfBv
         HDNDODzpeDZGgtnSBbG/t78yq2KeaMZ2CfhwtlNodfhHj6Ks9GxjmyTNzQ8mY86EfA7a
         eYw2oWT1E11L3dMrgciRWBBV1qLIyMAwQEMu3U2yyISnCOGxhMFhhwfQ+cNmUAMPHMdG
         +xkOfqfS/K/G5JyImOzhA/SiNNftLUtDrgRSADMUYU0uCKPSdwLIyku0UNPEFxSrPVui
         LTsLa3Y92K+0C8AwmuOIapcrv1GppSl/0qh9DRYlxKvIa/GwGxL+7TKEidNIkHh24ClY
         1rpg==
X-Forwarded-Encrypted: i=1; AJvYcCV8hNhENSG8yi0DLW3Z+Szu3/+kKv/S93ChQotYEMqdQlp4T8XUov8XoE0HEuAcH/VLcJA4azWr76XgHcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS9QqVFMVz35Kbg8j2aTfN+Tx5q6KPl8N+YHt1v3JhxAH1qu1K
	3U/VKoZYrBmMD4X6Ov1K3a3phxC5uTRHhQcooaFBuC89t7fNrVzfYZGcLzpvDQ==
X-Gm-Gg: ASbGnctek+WRphfGrk8I98cjxFRXq0ecaKB8W86Sb/sYxSKLjNFZ91tC6q10R3vHHMG
	9Brq0PSD5pXzz9xb5Xob3nPC27l6xDPTzMJV0ONpAyUr9LCaLurcXFUEdDxFziZ8c+6T4gu80gU
	H7j8cBEihWN7VlHkkT0XQ/L0F1VlWUtFULXhFK+zacpRG1zSAa9+DO3UWPOmhyW00B4lkeCfiv+
	ni7yukTtmoofkMrUYzVsAbrBc/+Soi0tiTSJ0/kwU2Ca7Xfm50WY7blZphY1JIrU/7z
X-Google-Smtp-Source: AGHT+IGjUccenohiYb+SDkdAmpf0k5ZpdC9204RkXFZyFmXwB9GNV/fs0d/6P1jKINhalSCuMQyisw==
X-Received: by 2002:a17:90b:2750:b0:2ee:7504:bb3d with SMTP id 98e67ed59e1d1-2f2d867445amr6395058a91.0.1734456043265;
        Tue, 17 Dec 2024 09:20:43 -0800 (PST)
Received: from thinkpad ([117.193.214.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2434a7bsm6848964a91.36.2024.12.17.09.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:20:42 -0800 (PST)
Date: Tue, 17 Dec 2024 22:50:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christian Bruel <christian.bruel@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>, lpieralisi@kernel.org,
	kw@linux.com, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	cassel@kernel.org, quic_schintav@quicinc.com,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex
 bindings
Message-ID: <20241217172033.zxl4bufakzx7eww5@thinkpad>
References: <20241126155119.1574564-2-christian.bruel@foss.st.com>
 <20241203222515.GA2967814@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241203222515.GA2967814@bhelgaas>

On Tue, Dec 03, 2024 at 04:25:15PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 26, 2024 at 04:51:15PM +0100, Christian Bruel wrote:
> > Document the bindings for STM32MP25 PCIe Controller configured in
> > root complex mode.
> > 
> > Supports 4 legacy interrupts and MSI interrupts from the ARM
> > GICv2m controller.
> 
> s/legacy/INTx/
> 
> > STM32 PCIe may be in a power domain which is the case for the STM32MP25
> > based boards.
> > 
> > Supports wake# from wake-gpios
> 
> s/wake#/WAKE#/
> 
> > +  wake-gpios:
> > +    description: GPIO controlled connection to WAKE# input signal
> 
> I'm not a hardware guy, but this sounds like a GPIO that *reads*
> WAKE#, not controls it.
> 
> > +    pcie@48400000 {
> > +        compatible = "st,stm32mp25-pcie-rc";
> > +        device_type = "pci";
> > +        num-lanes = <1>;
> 
> num-lanes applies to a Root Port, not to a Root Complex.  I know most
> bindings conflate Root Ports with the Root Complex, maybe because many
> of these controllers only support a single Root Port?
> 
> But are we ever going to separate these out?  I assume someday
> controllers will support multiple Root Ports and/or additional devices
> on the root bus, like RCiEPs, RCECs, etc., and we'll need per-RP phys,
> max-link-speed, num-lanes, reset-gpios, etc.
> 
> Seems like it would be to our benefit to split out the Root Ports when
> we can, even if the current hardware only supports one, so we can
> start untangling the code and data structures.
> 

+1 for moving the properties to RP node where they should belong to. The
controller driver might have to do some extra work to parse the RP node and get
these properties, but it is worth the effort.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

