Return-Path: <linux-kernel+bounces-570128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7498DA6AC91
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02F2487EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33C225403;
	Thu, 20 Mar 2025 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IgdTDTb1"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E0224229
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493446; cv=none; b=aAh/w7mr7cTjBCnu3fohTM5Tpe3fT9WtAyHYw4DCtoUtagbR6UOpVF+viiEMh1/M6WPfdV9jQZeQtrHiyOR7MDEEZE/2hQiXGTFo/c6IkYhZkbNMHLWuc3q5lUR0o7p98h3XPAj8KGcOgl+8lZtjGbMROykNEv2mspzIoQx9J18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493446; c=relaxed/simple;
	bh=mO6ApbMHzxFMCtQxPMSGmJnnaUVaxpdYXWiMJjhdnYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVV9uA0f1h5A647KyGdXebHKlnnb8ICE4+F+GkQGgBpUEjaZENwjptprRA7dpBm81vfxqsFPmqI3Uo3vEGGfKoBxgOmcVtcXxkyGGq1nyI3U8wOzzNTyVM61Vl20BiA7GIIk1Qtx22SZyVnX1DH0dPEtVJOKRQgAI0MHG0FDvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IgdTDTb1; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso3588258a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742493444; x=1743098244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZBuAO/4lH4CVBlD86N+IBRXOKzZiRkJHD/4cEnzLg8=;
        b=IgdTDTb1X2qtQtOkDRsbcKFEP0YT598B/9Y24roSjP6k+N94B0usGnhtgNhRHvg0oA
         ug/vDzEqKyvbWyEoPZoWX7T1fP0ze0kP5URxeXtgHY3H1yKyh+FQBkONrq/sUv+v4HRb
         SAI/w/sQUA+DLKkcAVN5KHw+yH3qNxSmovIy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493444; x=1743098244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZBuAO/4lH4CVBlD86N+IBRXOKzZiRkJHD/4cEnzLg8=;
        b=Fdwn5MU5KF3Shp/e3cUa0grIxRImQHzveW/FwLX0z4gOrlW3wbNZflSCWETq3j9Mdf
         DgKpCnKnnxb3wnWEdgwR1K8bNKGahwfHlJPDILFLzgB8kKj0NA/rSvoXmGAsV78E53XP
         ZnSbyk9iDWUQPHhqF9/5Oqt4c5TmoZ44bvEu+TBnzqyKffI2omduO0m4DuSLhT2NX7bc
         oBkrm0qVS3cnxOpyCj7C4b+jGUQZldhgumCFpAjmbbS5UmC0U0UaYCe+Vt4uTZuOjTbQ
         W+QBZVa5f/rhVCm3UbLzIMH11e8ZEA0bL4YyTDPhNUtNzRajqYJ3oak4H8vPxdEx9N4o
         gzrw==
X-Forwarded-Encrypted: i=1; AJvYcCWyVZthSMAh57ogsX993/ZMsW2hwWcKzy9nQs/A9AGg8N/BukjVUUTv2L3Nj+WoggJdrCmneYs/vIntxDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypmpP5wmdbvewlIKqEyIngFkpFXawkEuhZGkZxSbxFM1ZXRLEV
	zFFXo12BHhhLUXoYhbHvK1LGd/JOItdXklFYrrTh28x0AcF93uteOI9AfxxajA==
X-Gm-Gg: ASbGncvwbjJDahiuxLHtATcEma0r+neTItCx6jZ/+f9u19ky+oCQYlZ/Jo7xcS1NgOq
	RY03AVZf0M+h70DpJd5ZIqfYUJVNh8MwV5EX9XJn3/zuGTk/qW29/l53jVJv4qpV0k36tTiT+qa
	T5kYuPw4gXoflBhpCxhyozDB/u/OOOHgz24UDc6ucZXMLasCI+c9PzF8XylAk4AXP3HkKBdyd7t
	gygt0YBwG2wHbVf04YjHOkV8hU5jQGC1HskHOM84fnoKR7auc1I6bNFFUPkadDEXxxbB05bfJ/X
	cul42pO0dUHZLsuZvRYCr6gU9myYDEHOHQkGmJWd7UgcnEqc21fEr6C5I1Lja7SihmKMqKCrUCA
	ZNUVRV64=
X-Google-Smtp-Source: AGHT+IE7xF5qbvgKRnHfx2I3KfMDgIwTK12qXs2qkhWYJrmEZMMPOAnefkb2h4CcUxPOX3VUqrZHNw==
X-Received: by 2002:a17:90b:54c7:b0:2fe:93be:7c9d with SMTP id 98e67ed59e1d1-3030ec2a985mr625654a91.7.1742493444134;
        Thu, 20 Mar 2025 10:57:24 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9e6b:24df:389d:f71b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301a5ea4e9asm2514396a91.1.2025.03.20.10.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 10:57:23 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:57:21 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>, linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v5] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <Z9xXAYA4KS5BabhE@google.com>
References: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>
 <20250228174509.GA58365@bhelgaas>
 <Z8IC_WDmix3YjOkv@google.com>
 <CAJZ5v0j_6jeMAQ7eFkZBe5Yi+USGzysxAgfemYh=-zq4h5W+Qg@mail.gmail.com>
 <20250313052113.zk5yuz5e76uinbq5@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313052113.zk5yuz5e76uinbq5@thinkpad>

Hi Rafael, Manivannan,

On Thu, Mar 13, 2025 at 10:51:13AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 05, 2025 at 02:41:26PM +0100, Rafael J. Wysocki wrote:
> > There were hardware issues related to PM on x86 platforms predating
> > the introduction of Connected Standby in Windows.  For instance,
> > programming a port into D3hot by writing to its PMCSR might cause the
> > PCIe link behind it to go down and the only way to revive it was to
> > power cycle the Root Complex.  And similar.
> > 
> > Also, PM has never really worked correctly on PCI (non-PCIe) bridges
> > and there is this case where the platform firmware handles hotplug and
> > doesn't want the OS to get in the way (the bridge->is_hotplug_bridge
> > && !pciehp_is_native(bridge) check in pci_bridge_d3_possible()).
> > 
> > The DMI check at the end of pci_bridge_d3_possible() is really
> > something to the effect of "there is no particular reason to prevent
> > this bridge from going into D3, but try to avoid platforms where it
> > may not work".
> > 
> 
> Thanks for sharing the background. This could go in the commit message IMO.

Yes, thanks Rafael. This adds a bit more than the guesswork I've done so
far.

> > Basically, as far as I'm concerned, this check can be changed into
> > something like
> > 
> > if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >= 2015)
> >         return true;

I suppose if this harms any non-x86 BIOS systems, we can just add to
bridge_d3_blacklist[]. This works for me too.

> > which also requires updating the comment above it accordingly.
> > 
> > This would have been better than the check added by the $subject patch IMV.
> 
> Looks good to me. Brian, could you please respin incorporating the comments?

Sure, will send shortly.

Brian

