Return-Path: <linux-kernel+bounces-261878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA99D93BD4A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B722283BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C124B171E4B;
	Thu, 25 Jul 2024 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9J8A8X/"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EDE3DBB7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893638; cv=none; b=lPDZnGzqpu6fw/Yj2CkA/DwcSeSeiKu/0K44ZzgVAAHLZI/YLKOe2+AR20t6dE/dTX/XkCP/EgA6fY0qhFrVOIJs06HairOJXXy6yPp9SRBNbMDYEIj7Vgou0k7/+DQqbaChCEGYaTVHyuFWiGhc269OmXYjVOjuLwx+ni6lxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893638; c=relaxed/simple;
	bh=xbNwwU319rkoRLiF5J4L5ECjiSneLZ1X5F5cu9hErGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiqP5WgRrzQ1gpA5mf4btLxdxjxX92wMVOiu+O3Ka8A6sgEDYaGlHsFOarlNMshxtzVPHDH/Cntp6xy5+J2lYq3WUdUPV6Esv1rbezdQHOVwXVpy4/MmpIJRNJ2PhosUFhZ1Fasz/biBm65xA6Xjnq57kzqvllEkDUUQB8V7sQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H9J8A8X/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc658b6b2eso5487885ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721893636; x=1722498436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KpBq3z07GcYsJy4O1z5Daz2Py/Pecj57NPa35Ml6XIM=;
        b=H9J8A8X/cnLnuixq52Qq8MknbtNeTUkz7WJb0jWO3YxDu4VObkFZOEjXfrJLAwNJQH
         CPVT2nbR4qwmUmbaUKSyGW+U/Do74/TCuLgGI9Ms67UDKS9TeWirqRFSsPcbeZpL0WjA
         vYmNXc8JWjRibQG5Ouc8TrnSSAVTIFxb8URC3ywUP6QZGsETemQcC/XnbCvWVBgezNIE
         zEooNUOS4v0p6gMPoYBRgPaIpeF+9oI6saRMRzf+vcrxKKiJ3qjRzw1rAzD0szAlO8sQ
         dJjU3V0z4F4ODuplWhCFLJh9kqTNW6sBhjFEK962VLkaoHTMHWM405inUYVdcbeefNcW
         qVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721893636; x=1722498436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpBq3z07GcYsJy4O1z5Daz2Py/Pecj57NPa35Ml6XIM=;
        b=cv3Rdyj+CsaCPsWmflvDd1xYY6joon1pFwLsp/II2UkfAXn3iKgIsI0aFUHZ7WHaLL
         hA9XhfafG5ty0ZHhK3kPcVecFdHOMT//HbjTLVPtqx/QdpmNhBAr53XDyKjCk0KIOTbQ
         pUHco5Sr82JzCMfNBsH8DrxNzQqY5aLlCPORUC2jfJfynvSCgU8NT1q0zp3SQt6X4iZA
         g7O+qNEBrlEefBXO9orWdKiAQ63JjkycdYgZ2auyeBLWDcGwBz08mvQDB5LP6EomRft2
         Fvt88xsM7jwC2M/KQZyGT5ezNj3mAhBT0KZA9brhgzGSqGN0VcEy0cDWFGdm/AsJSjV9
         4Kig==
X-Forwarded-Encrypted: i=1; AJvYcCXp0GnpEDNqSgHE1ekTV0Rb1e2nwYRz3n2s4lZYxlkywkUWHYyiC4tL0pn/bPDSs/966Fe5ECiNCltCTLrlxzNpV60BOQ0/gMx0ereY
X-Gm-Message-State: AOJu0Yykv/NjqGYtsB0EV2Gxz9DqLKeXMFlEE3WabMHwUljpsOMN+dyA
	fi3DVmtqLuZ6eLun7KhX6wZ41jX7NrbB7M9q4ydDYxqGfTitBS5MHiG15m6KVISxNgy+tktELJQ
	=
X-Google-Smtp-Source: AGHT+IEvPiQ4tXStL2sFA0d8J9F5uD2IHeouCkAncAwEO9kDbAu69BWI3aENx7hEAk7hZ0kx2c3RbA==
X-Received: by 2002:a17:903:2343:b0:1fd:5e91:2b13 with SMTP id d9443c01a7336-1fed3870cdbmr20396675ad.1.1721893635894;
        Thu, 25 Jul 2024 00:47:15 -0700 (PDT)
Received: from thinkpad ([2409:40f4:1015:1102:1950:b07b:3704:5364])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f6dc27sm7688855ad.237.2024.07.25.00.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:47:15 -0700 (PDT)
Date: Thu, 25 Jul 2024 13:17:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, vigneshr@ti.com, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	ahalaney@redhat.com, srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <20240725074708.GB2770@thinkpad>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724161916.GG3349@thinkpad>
 <69f8c45c-29b4-4090-8034-8c5a19efa4f8@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69f8c45c-29b4-4090-8034-8c5a19efa4f8@ti.com>

On Thu, Jul 25, 2024 at 10:50:13AM +0530, Siddharth Vadapalli wrote:
> On Wed, Jul 24, 2024 at 09:49:16PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> > > Since the configuration of Legacy Interrupts (INTx) is not supported, set
> > > the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
> > >   of_irq_parse_pci: failed with rc=-22
> > > due to the absence of Legacy Interrupts in the device-tree.
> > > 
> > 
> > Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq() will bail out
> > if 'map_irq' is set to NULL.
> 
> While 'swizzle_irq' won't be invoked if 'map_irq' is NULL, having a
> non-NULL 'swizzle_irq' (pci_common_swizzle in this case) with a NULL
> 'map_irq' seems inconsistent to me though the code-path may never invoke
> it. Wouldn't a non-NULL 'swizzle_irq' imply that Legacy Interrupts are
> supported, while a NULL 'map_irq' indicates that they aren't? Since they
> are always described in pairs, whether it is in the initial commit that
> added support for the Cadence PCIe Host controller (used by pci-j721e.c):
> https://github.com/torvalds/linux/commit/1b79c5284439
> OR the commit which moved the shared 'map_irq' and 'swizzle_irq' defaults
> from all the host drivers into the common 'devm_of_pci_bridge_init()'
> function:
> https://github.com/torvalds/linux/commit/b64aa11eb2dd
> I have set both of them to NULL for the sake of consistency.
> 

Since both callbacks are populated in the pci/of driver, this consistency won't
be visible in the controller drivers. From the functionality pov, setting both
callbacks to NULL is *not* required to disable INTx, right?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

