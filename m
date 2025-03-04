Return-Path: <linux-kernel+bounces-545067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBC7A4EA42
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17708A7F72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD44209F33;
	Tue,  4 Mar 2025 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUN9EUgK"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0622C3773
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107497; cv=none; b=XR1u8riDjke4jRAso2SsTDHtDM1YX4oteh22qE48mdqgsi2TiY3OiN6mx4AKdYB2HhLCHslNGx66jXZJXmCRMpZLQQ/ItPj4W+xMoRZj8FOhLlcY/ZZbqj8EUZ9EP8robuApYXD8aR7uhFDfsI6+zJlZW3naBO+y3JSWeqTVopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107497; c=relaxed/simple;
	bh=xXx7LimoRaGxZZSbMjRDlhzEtcIeeTGSh9Q0GrBdkxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7XGSfEE0c86+PhjItWHAMqHVvfPKiWTwamiws9zEQMKh5hp1GAA1D3RIj4qhnXyJ3POR6oUHVzTv51WtanJal+6id9fzc1MzIZ7c8XP1uI75t1EaaKvGtSbnkBMmI4IQp27LRtEHvaCsASg/VIX96/C3Wf1Ow0ASGNPXo/TxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UUN9EUgK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2232b12cd36so80740485ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107495; x=1741712295; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JXuDlePk3z76NmB3njzb/zW9m0v0y70IIgcfh0HFsS0=;
        b=UUN9EUgKHa0X/OazVwo0MsnuQd/ZuM4ngr/iEYWOl4u4n6hmkdrki7vTgoau7eWsbA
         7trlWz8gJEmjjkWd8A8/JE30TAhXkJKWiUzUrA5H5P5Wv3g6/3OCK+FNYZXjR+Ui0UA2
         Bsv3oEbuSoz+dwuLH6T5911/1VBPnIkROLmjSHbwv6WlYd6AlTJ5vdJQy271SHxjzt1d
         468BzHSBE2Fdyqlb/woY/HdwwixCikGRclHe4uk9R69BNLpwWAEMOhz4suVlniGv0GZF
         g2lAAP051Z9y8R+nDBoTAQE+2KiWcoGEwPwpNEhjDfZcLBD8xYv8nBmt1GgfRD6J/jnj
         rQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107495; x=1741712295;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXuDlePk3z76NmB3njzb/zW9m0v0y70IIgcfh0HFsS0=;
        b=exF2BTtBxwOewOfq8xWci84fo5/Rf3Pr29GVJp28SEPq35IjzdTlIOIGDeveUQ9602
         UfkeA4vavhyohNWhqTdbU9sCDsE8ktv2wfkV9Ys9McY63Rk1hxxXYVj2VGEtgO5pZI08
         tGoFUBYIT3SXaOs1HYDGaeF6NMvawEjw7NuEUM2pXWuENKgGaPSYW/Otc2qF+9PFNsgJ
         Z1oPfol1Ef8o7YbYSRjdIMD1z2GvrrOqfYxdmnrlwB40djGW7GTdOHBBOFmlPNDkSOsK
         bVxEYkMF5fujbxGE9RDmH+g/Xj2qWnvJaUCQeslPm7Q3R/IHyuSvJDnb1916d4HNFIyK
         KMxA==
X-Forwarded-Encrypted: i=1; AJvYcCWVYwMqQ2lnEmhEC6Ly5C1l0QjUYSNbvYmwgk3ZWCsZBnBB6dMykwfKyZd2WkhPeeS/wN3nMEXviIQMjVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL3MzrZ/hMbzHr5anRYroAFEL6zZLOYmBIgdSG08lmtrrdO8Gn
	cvB2eclkeQnGvycLNbbYFDrY3+3k0TZE0UHG/c5nmr2FZoAGDfo5R1g2ImU9nw==
X-Gm-Gg: ASbGnctvl4FSqS1vZMWnU+29Hic3SVrsxZ5H7UB6RGZC3OFuVUOwebQrCiWUA/XITtZ
	WID16WUhShda3YAggtLs+Gh0N10gf81HbBpOIHL6yVnDi4v7bPUyTw7SoNN8QgqnLUmBQ/G4gVz
	5nDXtB6OyWVu9BefP0SEnZBjvQ8Q+X6fwDhFeb/lX3JJPnLiOrujUHat8WZ13mqg55lBZfuF/kG
	Ow+W6DTc9waGQPJ6cfEAg3BlcP6XqHGkp6GFSgnaxbbabxEamnBIFaMXOkqh80xavNuU+JrFYev
	nsUzg5++WJjFeNUJeB31xiSLGnVHEe8HFwrPmydChoawMHwEEgbfnLE=
X-Google-Smtp-Source: AGHT+IGwnc/vs2CObgIuDM6UnQPGGyTdY/HL1MplDIozj/pFYdjiWAd6nq0u34IHMKPLJhyLx/VbEA==
X-Received: by 2002:a05:6a00:66ce:b0:735:d89c:4b9f with SMTP id d2e1a72fcca58-735d89c4ee0mr21649526b3a.0.1741107495305;
        Tue, 04 Mar 2025 08:58:15 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a5b1sm11112782b3a.23.2025.03.04.08.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:58:14 -0800 (PST)
Date: Tue, 4 Mar 2025 22:28:08 +0530
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
Message-ID: <20250304165808.t46fh6fwpardheup@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-7-james.quinlan@broadcom.com>
 <20250304150838.23ca5qbhm4yrpa3h@thinkpad>
 <CA+-6iNzOWU1qLfmSiThdYXX0v5RkbUYtf52yk6KXm6yDDNRUnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNzOWU1qLfmSiThdYXX0v5RkbUYtf52yk6KXm6yDDNRUnw@mail.gmail.com>

On Tue, Mar 04, 2025 at 11:37:14AM -0500, Jim Quinlan wrote:
> On Tue, Mar 4, 2025 at 10:08 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Fri, Feb 14, 2025 at 12:39:34PM -0500, Jim Quinlan wrote:
> > > The constants EXT_CFG_DATA and EXT_CFG_INDEX vary by SOC. One of the
> > > map_bus methods used these constants, the other used different constants.
> > > Fortunately there was no problem because the SoCs that used the latter
> > > map_bus method all had the same register constants.
> > >
> > > Remove the redundant constants and adjust the code to use them.  In
> > > addition, update EXT_CFG_DATA to use the 4k-page based config space access
> > > system, which is what the second map_bus method was already using.
> > >
> >
> > What is the effect of this change? Why is it required? Sounds like it got
> > sneaked in.
> 
> Hello,
> There is no functional difference with this commit -- the code will
> behave the same.  A previous commit set up the "EXT_CFG_DATA" and
> "EXT_CFG_INDEX" constants in the offset table but one of the map_bus()
> methods did not use them, instead it relied on old generic #define
> constants.  This commit uses them and gets rid of the old #defines.
> 

My comment was about the change that modified the offset of EXT_CFG_DATA. This
was not justified properly.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

