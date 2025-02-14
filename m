Return-Path: <linux-kernel+bounces-515044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A53A35F11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E6617613A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5124B264FA9;
	Fri, 14 Feb 2025 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yYdOZ9z6"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A4264A8B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539284; cv=none; b=LhiO2746ODCj2J48/CfCrFU/7QRE8Gfg1uFQbxzg3XB9iGjBBuwVsu0NLurFwKRXQlqg5u6l3HmLK49qZuOaPRnZb6VePEVU9mYt9yotM5bgUcWgRK9Lv51RDCjnMFarWKMgxmwJlRsAQh6dQIftVnpfenfeUazVBPcAvdIGPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539284; c=relaxed/simple;
	bh=iUpdeyeQQjXOQvrBPlDvQAeSvEhUZLpAr5hoCBShPAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+qNeZ1ZhYvhL9HpTH+SoLY3yi+Ul3S5OaQ59tWHKB0MTEQsARQ4ryJVbN/y7Pe7FjRqKZ9eZyg0Ip+2NuXVllz8RKPDt5DGtqiLk2ooT0VPj0pDiq70alwRNpCTMhYe7QTGYhdmRXiPc88POTVGjKINeMEpJ0Y4ccuwW4VsUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yYdOZ9z6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc3a14f6fbso242989a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739539282; x=1740144082; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D6X7TbU2TKSA6FfWi/bx/2Zh2Uwig40zqLcYQUHDpnM=;
        b=yYdOZ9z6UK1QaqaMp4oCgDQa+dDPShDLe7gf1uGn3L8Ab4eVKyOTOAr9fYefJ4Q/E7
         V2nbvqf9lPbG/VpcflrFzczZHXd6NfKULMXmWBxPoNV9ECWPovEb4j9InJDdGPGNbx+r
         aSAVzfgDB9fqZ/Ul22I44w2uroJkGJRrO57AR+s+R1S3Z5HX3zqDesBvxTVJDwVH7NU7
         6HobBgsaA5ZWi8OdoYAeVLyMJhQYvj0b5veaQr9yFg374PFZIE1HBiociH0jFW+DOCvY
         sg5aEhSXcnsQigI3eOjreCWw/xme6RgpMmIOYllOYgFq5Zttp6V/Fzfql+yBbUgEUued
         g4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539282; x=1740144082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6X7TbU2TKSA6FfWi/bx/2Zh2Uwig40zqLcYQUHDpnM=;
        b=VJs9NH3klge19JNsI3X/7botUhHqik54QDAjqCj5isOGCIw8eSkswly+Ot4xeySgze
         uTuIzAHDNLBehdtBGW068VCrMGEhd5JNmMwdUtWw77C5TviCEsHcX2wCNksSsyhnoX+9
         igfPhJMMR9ggVGsLiruIl3De8tXjNLhK5E/IJv7/Cj4W2wa3l8hcbpEFTPHjH4DEZ1oC
         7xgwFelIGIR42a1oy1X50txHdUqbwkHQOLIGUSDNGIS4q8YXR83KHDPG6ifI8/KGbBtB
         fW/TyjQGIb6QiqLXr5ZR7Ih9qBQHUfYuI4806TzHoAxw/qB+T/2s6RV/Ur/RLSuk44/D
         2SaA==
X-Forwarded-Encrypted: i=1; AJvYcCVwRwrk8hXnt4ufJ9TStL62MNct/ljfHxxfOdUFmwQTZ76M9Mmmiz2leMpEdMfmjJ8bbGx81LKfLl2G4MU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzghu582I8sFEwLVSTb0rO2pDQR07YgQHQTc+sJGLkhN2IbNnPy
	b0p0/efFuvRdq1Rf62+0SNJ662MlNmhBSBCNQtufywQQxsSCqpEprS/q9zbY4w==
X-Gm-Gg: ASbGncunrHMa/h63vSE8PFON+0SDvmkXo49EVwRffhN6ggg6fEsaRU/Dnm8wbExjhQP
	KLcWzE5UDu0qwuOdHdgWkAGhp2f5oRdgShhuGXxYNkkuOAIVqmwhDnLn49aFCAd0cW43pFGMwi4
	YfP7q9Dk2HaWduQrGg559u8Pkb7KlIBKau1Cfsd1LR0u20oSteon4zigWDDVi4JatQmjzcqmUO6
	q3loY6Bvq69pU4o5ObVsjU9IfxQuJz2ZOSLfB/32Q+nyxBori6YdxTs0BhrYAF/UX+ivxN28a08
	cGszK2WVSAzMPElqtJsoKuBtLn6qc6w=
X-Google-Smtp-Source: AGHT+IFojHOCI81P67j+Pdb6NB1BhabP8Ji4yZG9LPBDN4to6OWIQ20bBJz01hSrYBfB9Y6LZ3Z0iw==
X-Received: by 2002:a17:90b:4b06:b0:2ee:f687:6ad5 with SMTP id 98e67ed59e1d1-2fbf8957f05mr16448954a91.2.1739539282301;
        Fri, 14 Feb 2025 05:21:22 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:250c:8408:d2ac:10db])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b5b4sm5588794a91.30.2025.02.14.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:21:21 -0800 (PST)
Date: Fri, 14 Feb 2025 18:51:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, bwawrzyn@cisco.com, cassel@kernel.org,
	wojciech.jasko-EXT@continental-corporation.com, a-verma1@ti.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v3] PCI: cadence: Fix sending message with data or without data
Message-ID: <20250214132115.fpiqq65tqtowl2wa@thinkpad>
References: <20250207103923.32190-1-18255117159@163.com>
 <20250214073030.4vckeq2hf6wbb4ez@thinkpad>
 <7eb9fedc-67c9-4886-9470-d747273f136c@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7eb9fedc-67c9-4886-9470-d747273f136c@163.com>

On Fri, Feb 14, 2025 at 04:23:33PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/2/14 15:30, Manivannan Sadhasivam wrote:
> > On Fri, Feb 07, 2025 at 06:39:23PM +0800, Hans Zhang wrote:
> > > View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
> > > In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
> > > Registers below:
> > > 
> > > axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
> > > 
> > > Signed-off-by: hans.zhang <18255117159@163.com>
> > > ---
> > > Changes since v1-v2:
> > > - Change email number and Signed-off-by
> > > ---
> > >   drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
> > >   drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
> > >   2 files changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > index e0cc4560dfde..0bf4cde34f51 100644
> > > --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > > @@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
> > >   	spin_unlock_irqrestore(&ep->lock, flags);
> > >   	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
> > > -		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
> > > -		 CDNS_PCIE_MSG_NO_DATA;
> > > +		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
> > >   	writel(0, ep->irq_cpu_addr + offset);
> > >   }
> > > diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> > > index f5eeff834ec1..39ee9945c903 100644
> > > --- a/drivers/pci/controller/cadence/pcie-cadence.h
> > > +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> > > @@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
> > >   #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
> > >   #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
> > >   	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
> > > -#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
> > > +#define CDNS_PCIE_MSG_DATA			BIT(16)
> > 
> > Oops! So how did you spot the issue? Did INTx triggering ever worked? RC should
> > have reported it as malformed TLP isn't it?
> > 
> In our first generation SOC, sending messages did not work, and the length
> of messages was all 1. Cadence fixed this problem in the second generation
> SOC. And I have verified in the EMU environment that it is OK to send
> various messages, including INTx.
> 
> And that's what Cadence's release documentation says:
> axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.

I'm confused now. So the change in axi_s_awaddr bit applies to second generation
SoCs only? What about the first ones?

Are you saying that the first generation SoCs can never send any message TLPs at
all? This sounds horrible.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

