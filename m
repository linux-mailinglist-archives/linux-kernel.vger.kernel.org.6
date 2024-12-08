Return-Path: <linux-kernel+bounces-436376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C24A9E851F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 13:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFD0281760
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D96146D53;
	Sun,  8 Dec 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SnoM76V2"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D7146D6E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662747; cv=none; b=WO3/AVY0YkxiaBu+fmv9AMpf3uJFicE+/PZmUvrHYwWg5agx0O2SkmHjXyqz3dFF/IV4GFEu/Rpqjqvk5dlcDD0/0DdlJuzxOAPRCANwcSrwc2MvgaDiu0NOa1wFVIb7lbZVnwA++UBhGaOOmzd+64aDZLIAip+idl7vkBz/3fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662747; c=relaxed/simple;
	bh=qfboI2JEzglBgUiX6GwJaX8ACsXX93fcly9pP3dAhjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppILa6wJxHdDHdIkUKGfLSNa/PdZhlWIKL22LBb/zgMfPmR6/DrW10viiRFqUA+xvP9NpkajWHKMM/pLLqDiYUF1Avx4O/4QiGGuKZcun7oQM57eD8iuhEakOo2rltioC8gX5Xo+zBTkByhCDV1ksiU9XfLEnv6xx2WY8AqZv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SnoM76V2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef83c68b47so793673a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 04:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733662745; x=1734267545; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PkDi47df4w40KWTcb5cXC5QjvFJDjRmn08x5U23uXOc=;
        b=SnoM76V297rGqFd1H//F+GV9PlMDBcPdA+4+h3CgiOgdhR7TlFYEH3oBv/DsAkAWOr
         wD08WGlJ+9cT7wjXQqNZD8xyNZrljWagavHtjQEqL2a5bpwmEqJ10WuBqfIQ2RBHaYDI
         dgw3/lHCDWXNZv5n8rboU8ULYjTpd5kqLiwUlZIMxsghRd54ADd9bxTg/0o2KyhzVTvQ
         BfMdwRMsK9zqGp1mFrGQfXbNch29asL8Xlx/FXUvOsdqe6OLH7vQgpI9A+QdtLxpZtu3
         fHX4A5vRrNtxmTsSCSTahFHKgi0an27npXfe6qdOJ7cvELxrR+3TKQv2WTVu+YQ/TM19
         Qqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733662745; x=1734267545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkDi47df4w40KWTcb5cXC5QjvFJDjRmn08x5U23uXOc=;
        b=tkT87HtQLDdXrJq1++ABnB1m58Af1r2ubfEasjZ5SxdV3wydQAh6OedXwCaGs7zC1w
         edpcJmiTPocxyQYWlcXtn4N2V+EowGFGgXTB3rO2dnneERVqjudBpy7d32xFvjQKav0F
         pqnMfJ7cjb9q6rnFFziUtQTZlSN16GVQtLrYjkkikHPd4uuHvyeVm8JP6dfT6Z5MhKOH
         Fd0IzupT9DYEjN4+WaesK0/sjW0yLhin+7RvjlrwIPNMKMqq7OeV1wvNuUpHSRAQAZVQ
         TL01ckytkM/0wyrQSPZNfe27khMeHVheEojJahRB/JQs1ImIapjMFJPhZZvzswe8vTmP
         ApPg==
X-Forwarded-Encrypted: i=1; AJvYcCXn2cxaIdeqf38aZRYE71hAWVDI10ODiP8/wGIDVitAX7xrn2rqfwaR6N1miru7RWFCSgIHAVEpjZXt2wI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57h6++cMPynsieEBvgymiCUSyFF6zBdu/SemMDNyKerLXjAty
	/xsokwu8QFO2nwMWZcjAWUw8l/ObPICu9NO4LbuKZSr1mQmBXixr6igfhmwD6Q==
X-Gm-Gg: ASbGncvCNYKBq2JUFw+l6cDZp1FTeVK7s99jRwkSei+1ZaZ0NOt6/DNvKrSURyVokr/
	5EYFeOLX8gq/mqq9l3BmMp2cV/f77c91sgXGHZel60Qs7hFPGoGUQQ6c6K4YucKhBlZ8HBwT7tt
	MbWz8Lu8R7UITtKEPomFVfD/cYxHSjt18Z1nOrLWFW3owR4brf40sK+sIdQAfp9lKrwQldjxdhz
	2I50VejcJs8/3V+Rl3t8KYUf6L5gyl3sjEXqzAq2htqIDfZCMxx6zjKPJg=
X-Google-Smtp-Source: AGHT+IHnhUVK9JHD0Nbg157D2tYLCZPvpbGaZMt6ugQdpbPZ+L62KfObJPkXd8gqt06CrhFVbhdPKA==
X-Received: by 2002:a17:90b:2548:b0:2ef:19d0:2261 with SMTP id 98e67ed59e1d1-2ef69f0b061mr15208744a91.16.1733662745572;
        Sun, 08 Dec 2024 04:59:05 -0800 (PST)
Received: from thinkpad ([36.255.19.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef4600d14fsm6228921a91.45.2024.12.08.04.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 04:59:04 -0800 (PST)
Date: Sun, 8 Dec 2024 18:28:58 +0530
From: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: Re: [PATCH 2/2] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20241208125858.u2f3tk63bxmww3l6@thinkpad>
References: <20241127115804.2046576-3-thippeswamy.havalige@amd.com>
 <20241129202202.GA2771092@bhelgaas>
 <SN7PR12MB72011B385AD20A70DB8B56338B352@SN7PR12MB7201.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN7PR12MB72011B385AD20A70DB8B56338B352@SN7PR12MB7201.namprd12.prod.outlook.com>

On Mon, Dec 02, 2024 at 08:21:36AM +0000, Havalige, Thippeswamy wrote:

[...]

> > > +	d = irq_domain_get_irq_data(pcie->mdb_domain, irq);
> > > +	if (intr_cause[d->hwirq].str)
> > > +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> > > +	else
> > > +		dev_warn(dev, "Unknown IRQ %ld\n", d->hwirq);
> > > +
> > > +	return IRQ_HANDLED;
> > 
> > I see that some of these messages are "Correctable/Non-Fatal/Fatal error
> > message"; I assume this Root Port doesn't have an AER Capability, and this
> > interrupt is the "System Error" controlled by the Root Control Error Enable bits in the
> > PCIe Capability?  (See PCIe r6.0, sec 6.2.6)
> > 
> > Is there any way to hook this into the AER handling so we can do something about
> > it, since the devices *below* the Root Port may support AER and may have useful
> > information logged?
> > 
> > Since this is DWC-based, I suppose these are general questions that apply to all
> > the similar drivers.
> 
> 
> Thanks for review, We have this in our plan to hook platform specific error interrupts 
> to AER in future will add this support.
> 

So on your platform, AER (also PME) interrupts are reported over SPI interrupt
only and not through MSI/MSI-X? Most of the DWC controllers have this weird
behavior of reporting AER/PME only through SPI, but that should be legacy
controllers. Newer ones does support MSI.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

