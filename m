Return-Path: <linux-kernel+bounces-546126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02485A4F6AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FFD188C2BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0204678F33;
	Wed,  5 Mar 2025 05:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5Sh+WOP"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5AB191F75
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 05:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153659; cv=none; b=scIX8c7yVu8RLPmh89so2qwPigKkcxpkSiBBXS5ooXylktGOVeaPP0x6uL4Xm8Hwr9k/PdQDgd2rt1iw3iTi1Cqk86A347czbvlzW1b5bMWaMbzjxw7/B0n1RFoZvgz22qPWe+wmEYq9SxNaLQ3tGnV1kzTjw7LmSe/sn2Xk3Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153659; c=relaxed/simple;
	bh=LMYEcYBxEqpemNoYGJZ/7fpKaSDbz0bQKj+HYIDlv8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4NY/kvXxvRJIztEgDOXIkGriPgUoO6oo31Ir4GZRkneVE2PIAoyN1RHTsW+UYmVvL1BK4xZBF27tzSGA09QVSMqj1J4GnpwvZjQDU6/PD30hI9/ET51msD+sZi91bM/CEyzh59gnxU73XklmyGrFOAfG67zrObt0tPoWEP31UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a5Sh+WOP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2239f8646f6so66470465ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 21:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741153657; x=1741758457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yQ8sGclz9ZW30bcpmgdyWwKiT4qk2MxCGSmtAY4+/ro=;
        b=a5Sh+WOPrCGxtbhoGnLa8XXMoxMEJNUlPuvsIFEn0Wu375KYYdWTMEeeO/FIBAWntX
         /Fl0v9aiA9xmaKjKsrR9ODpMNagL7Tw9mKw4wWk36YsHqM5OThb+bjTbEOfLNHZw8H7e
         eBcLdGvbWDTLVLc7G15NXjozSHC2anVCrlOYFhAlT4he5EpEwzhcK+jHUsH9cvOe62Uq
         6xEc/QA54jquOt5AJFME2taruDnsNRHhacegzMsxdi388A+HInuU0dLTeRBYyiEfbkPO
         Egwq4ImFL6G+gj4wPn68j4gJvSPTwWrdCY3bnZYyjMvK8/zLVFZKT9lV3bpjvquK4/6S
         SsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741153657; x=1741758457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ8sGclz9ZW30bcpmgdyWwKiT4qk2MxCGSmtAY4+/ro=;
        b=UFLsyq2wo9Yz/ffRZbMQLCt1FKFBHzvDGlDH+GZbl2nTyTzNQS2aZwB/8NYXY34ul7
         k+Kp2EbgBhcJJc5cKg1ER9eQeEaowiHtNGvSZab3kUAqFZhzc+VXg2dC6Gz+ISMgQHtd
         nRTttM9n/IxgeDsiSp2UAJRrl3WrDX2U24KgQe1vDhW7mVQ7a4u6zzcxO2RV1Cb+LXJ/
         sBWMlpoHBk6VoOWIG935+1/CWMuUgOrto4r/zr+0scOHhQBSSnMUFIiP/kmpFD4bJWYu
         zj4JuxYObN+5tnjgkcHTeJ/sPWVX7pYXzb4/BdzglWXhKGSZqj5qrzrgpSOC8iq7bBUr
         Umwg==
X-Forwarded-Encrypted: i=1; AJvYcCW4wYlfC1PF2B8xJZEl58qGbuBg2lDXDhSQ739yoBP8viVvw3Tx2uTvj/poa1YZybREJS2goWTV0q1R4t4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8mxCx+g+4r9NNHborKQA1zWo9oerhgrUKWIvUIB00d0t3XF3
	lT5pv+kof20gEhvmZzBwC+K9FvLsjz8OmL8WZHFd5CBHKMUGd9j+JcB54WOXZw==
X-Gm-Gg: ASbGncvUvaUMtVrbetS9w5382yKLftYR4BtNTe/7ANLT+4e5jRorzm90A9ICAnDyqux
	JoIDFDrYTiDRLw4asLfx7DbWBJel8dPCs4cd45xgOCTtHQkNgPOSoDhkNq07+6hzz9SwCCioVCQ
	7ePdlynMXifwlmOfdl42/2F+16wz/rw1nCgcgYOwTZDEXNZF+UfyWSn3Td7KfQSQp4HtQ8NliZC
	TAlf5PzDjd38tVV1r4lI9fdcmQGp05hVLnc4iREas4M67WtYbZggR+0mWveftOJDdj8NMbAxq7a
	JwlFmQZvjWxJQaJhGZp52CNWP5zPNi8/lmJr2NU2yjE3e5TtFe5OAN2h
X-Google-Smtp-Source: AGHT+IHcOjK0aDg9zZYU8dTY0bxPLw4b7XQZ/EjSujAaUgk6k2jHDc4GWuzqjv6glvZdXk8q7TEpjA==
X-Received: by 2002:a05:6a00:3016:b0:736:5ee3:64d5 with SMTP id d2e1a72fcca58-73682cda1admr3217540b3a.23.1741153656990;
        Tue, 04 Mar 2025 21:47:36 -0800 (PST)
Received: from thinkpad ([120.60.140.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73637081ba7sm7772462b3a.112.2025.03.04.21.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 21:47:36 -0800 (PST)
Date: Wed, 5 Mar 2025 11:17:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/8] PCI: brcmstb: Use same constant table for config
 space access
Message-ID: <20250305054729.5jkxen5vahoxvlrr@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-7-james.quinlan@broadcom.com>
 <20250304150838.23ca5qbhm4yrpa3h@thinkpad>
 <CA+-6iNzOWU1qLfmSiThdYXX0v5RkbUYtf52yk6KXm6yDDNRUnw@mail.gmail.com>
 <20250304165808.t46fh6fwpardheup@thinkpad>
 <CA+-6iNw2i=4KVr+VYOxacWpP7Pw0E5mDwKY1i9_6V_hjxu9neQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNw2i=4KVr+VYOxacWpP7Pw0E5mDwKY1i9_6V_hjxu9neQ@mail.gmail.com>

On Tue, Mar 04, 2025 at 12:37:26PM -0500, Jim Quinlan wrote:
> On Tue, Mar 4, 2025 at 11:58 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Mar 04, 2025 at 11:37:14AM -0500, Jim Quinlan wrote:
> > > On Tue, Mar 4, 2025 at 10:08 AM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Fri, Feb 14, 2025 at 12:39:34PM -0500, Jim Quinlan wrote:
> > > > > The constants EXT_CFG_DATA and EXT_CFG_INDEX vary by SOC. One of the
> > > > > map_bus methods used these constants, the other used different constants.
> > > > > Fortunately there was no problem because the SoCs that used the latter
> > > > > map_bus method all had the same register constants.
> > > > >
> > > > > Remove the redundant constants and adjust the code to use them.  In
> > > > > addition, update EXT_CFG_DATA to use the 4k-page based config space access
> > > > > system, which is what the second map_bus method was already using.
> > > > >
> > > >
> > > > What is the effect of this change? Why is it required? Sounds like it got
> > > > sneaked in.
> > >
> > > Hello,
> > > There is no functional difference with this commit -- the code will
> > > behave the same.  A previous commit set up the "EXT_CFG_DATA" and
> > > "EXT_CFG_INDEX" constants in the offset table but one of the map_bus()
> > > methods did not use them, instead it relied on old generic #define
> > > constants.  This commit uses them and gets rid of the old #defines.
> > >
> >
> > My comment was about the change that modified the offset of EXT_CFG_DATA. This
> > was not justified properly.
> 
> Okay, got it.  You are referring to (for example)
> -      [EXT_CFG_DATA]          = 0x9004,
> +       [EXT_CFG_DATA]          = 0x8000,
> 
> We have two ways of accessing the config space: (1) by writing a full
> index and reading a  designated register (0x9004) and (2) by writing
> the index and then reading from a 4k register region (0x8000 +
> offset).  We previously used (1).  An update was made to use (2) but
> instead of updating EXT_CFG_DATA from 0x9004 to 0x8000,
> PCIE_EXT_CFG_DATA (0x8000) was used by the code of one of the map_bus
> methods.
> 
> This commit changes the code in the offending map_bus method to use
> the offset table for (2) and updates the offset table EXT_CFG_DATA to
> its proper value.
> 

Ok, this clarifies.

> If you want me to expand the commit message with the above text I can do that.
> 

No need. Krzysztof should be able to ammend the commit message for you.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

