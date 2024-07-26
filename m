Return-Path: <linux-kernel+bounces-262829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E863F93CD6D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787B11F2217A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D1B2F874;
	Fri, 26 Jul 2024 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sqOA+kbS"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF2128E37
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721970493; cv=none; b=XrW2FwEAee3MdEpnPL+sS7XACwMHsC2fANnZoPDyBQlGFRfHkxPnZ11PfxZ5eKcsb5Msya7OmDMlgWbTazXFf+IUqGeklsha2tw8Lvp85e5YWrUnkX7GeOZe8VNxhkkU/aNeAhDsMB3SwfsdXwrR2CYYN2yEJUV4o1CEDe6QCgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721970493; c=relaxed/simple;
	bh=vRgTjVmBkef0bZYyhRCaL2/45FsAz1WDLtETKuC747c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzOA0wZ5FUTOn5TminVrG3WXvIBmBR72J0PpmoHZp7kOuDeeL4yB6LYnAeJU9Z0XEJ+FFJdMPHOnjLJa20rAHYyUBa6a1Qc3dXqzzgHThbKxYIpwrKyZ7fKUniipfwN1K1YRf+kaqB6/7lTVg1LujXmxPUvsf2XoKzIumD8tk6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sqOA+kbS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70eb0ae23e4so482783b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721970491; x=1722575291; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3rKwuSlqAIySxz11l4PWG6VIoo7RMKChxKPZ2GCuBEY=;
        b=sqOA+kbSzpKrS1p78jLMNk5h5+k31RBR6LTEwrtkOqwcPbtodik8J5Ix+zIX44c08u
         vk98RRhzB6td0SF7BauWYKCO6pFMsXikLDkeqNbrcpm2nHQH1Nb08wnqhOYkz53MJNXi
         AW077w+9TScSVS6Xl+bFdbDVIEhbD9uEOH+VPFT7dUInGG5cuGZNE7NGaLTBntw1khdF
         V+8NHheZUulpmjTcxiReF/VztZJOsg1kETTxf5SGhA2JQR9g+9HbQJCaRr8gBJf49VmA
         +e0GkWO6L8/Zi7gg/XW9s74by5CHlD+stjf88n3EdI/y5wRV81tWP3SLOTjiZuk95Syc
         gTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721970491; x=1722575291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rKwuSlqAIySxz11l4PWG6VIoo7RMKChxKPZ2GCuBEY=;
        b=UWvsz1jZPs5Du45Qb0C5w1QTpCu3gxRPA+vUxyzmHfaFsW4GNmX508PwjgT2n7J2i4
         Q+3rDqKXEjLY4SLWerKunuaw3nvcITj7v5FXC47Ez+tsvmaBMOila0nYgmhrRv1Amc55
         YVhOsVFyeBWZd912OoaEv1d6dEe+LBZx7it4V7UuFaCaKB6czlV8dGk+KMQF2ztt/T1q
         6VgW0hQZozarIstrR5hVqhYWZjbjIAV5jlEglGjkUK2KZawV7VMspAIHDa9CHPCulLDA
         NOa/DE8sytTducSOjDMGHleYL6hOhono4I88qj8RKubqDAK6ovq/LSgyiI/cqzoh7P5g
         SatQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6IFBO9MO30jWf+5xv5CIkq0Eqma7w7OqSLpb2wSfg1zWbbaBmjNexOB0I0lEmkZYyYlPZknRTdS9qZgbIW77sYe2aQwkJoZzfZseN
X-Gm-Message-State: AOJu0Yxu9vm29UztrTbLp0zQxz0ilC6gcKjJR4LfwO8/Q+tSEmsADlWZ
	s7toQZoRKCyxHV9NB/J+vGHcOSTObAbIzKjPmcWGvY8qp4FPbO1HvjHJjZGGwQ==
X-Google-Smtp-Source: AGHT+IFPb+cpIlmTJHSn/eJI9XIpxgM8cTQg0C4/esBr4+srXONC/O3SgQ8mdQoB+Y0Wokbd7ElKDg==
X-Received: by 2002:a05:6a21:388a:b0:1c4:7138:ad1b with SMTP id adf61e73a8af0-1c47b4f896amr4158589637.54.1721970491165;
        Thu, 25 Jul 2024 22:08:11 -0700 (PDT)
Received: from thinkpad ([220.158.156.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f99099sm22814675ad.247.2024.07.25.22.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 22:08:10 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:38:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound BARs
Message-ID: <20240726050805.GC2628@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-10-james.quinlan@broadcom.com>
 <20240725045318.GJ2317@thinkpad>
 <CA+-6iNyQ09BESbdCwY1x4yUOLmAHKFBU3-9TO_ST+2GkOEEAng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNyQ09BESbdCwY1x4yUOLmAHKFBU3-9TO_ST+2GkOEEAng@mail.gmail.com>

On Thu, Jul 25, 2024 at 04:29:56PM -0400, Jim Quinlan wrote:
> On Thu, Jul 25, 2024 at 12:53 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Jul 16, 2024 at 05:31:24PM -0400, Jim Quinlan wrote:
> > > Previously, our chips provided three inbound "BARS" with fixed purposes:
> > > the first was for mapping SoC internal registers, the second was for
> > > memory, and the third was for memory but with the endian swapped.  We
> > > typically only used one of these BARs.
> > >
> > > Complicating that BARs usage was the fact that the PCIe HW would do a
> > > baroque internal mapping of system memory, and concatenate the regions of
> > > multiple memory controllers.
> > >
> > > Newer chips such as the 7712 and Cable Modem SOCs have taken a step forward
> > > and now provide multiple inbound BARs.  This works in concert with the
> > > dma-ranges property, where each provided range becomes an inbound BAR.
> > >
> > > This commit provides support for these new chips and their multiple
> > > inbound BARs but also keeps the legacy support for the older system.
> > >
> >
> > BAR belongs to the endpoints not to the RC. How can the RC have 'BARs'? RC can
> > only map endpoint BARs to MEM region. What you are referring to is 'MEM region'
> > maybe?
> 
> Agreed, it is confusing.  Long story short, the HW team gave the
> inbound windows the label "BAR".   We will still have to use their
> register names,

Wow, such an inventive naming :)

> e.g. PCIE_MISC_RC_BAR4_CONFIG_LO, but what I can do is change
> for example "struct rc_bar" to "struct inbound_win" as well as make similar
> changes to the code and function names.
> 
> Let's assume you will be okay with my plan above; if not, please tell
> me what you would prefer.
> 

Yes please. Just keep BAR in the register name and use 'inbound_win' elsewhere.
Even better, add a comment at the top of these register names to clarify that
these refer to inbound windows.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

