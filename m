Return-Path: <linux-kernel+bounces-276419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3051949363
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FA81C217C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33662101AB;
	Tue,  6 Aug 2024 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XceokrfW"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEFB201273
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955168; cv=none; b=toyn9RIqGDXuAld7/hjJ3tFzwkoFmE4RXblPVoD4gHY/m95QATgy3+RZ62TFN0MzhlnsK+1/7XP9MYvOX92N8rMJ+lrYcNgRlOk1xYOCRhzOskys1fuFG+idFwesnPbeyEzAjDVPkuAM5txpSXtWEUyWMLXRK+/m9NSfAo3U5iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955168; c=relaxed/simple;
	bh=7oknU6DGKYF5IvjWgkJ9pfIXoZcCEanwoQfqqdPzX3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9R4TKdchLWmw1mKwM2YcNZADsWiUbQs9FzmhTutj+75V0bp9cDOVt1Wg+6IOuKx2AqPN0/ZUQJaBYOuXsmQ7SvM2oLtYDlqFRcTJ2tD+hyAj5H1/vD4TyTIjTvcFA9Up+LfbYl6agnUCnw1f1R2i7ypnwp5B5Il3WaW4gi1q4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XceokrfW; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so507787a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722955166; x=1723559966; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z4EeH0lY+Ewy/pWDk6E3bMS6Wq7uVbNGOBf9b/txebg=;
        b=XceokrfWz4sOtlr9SvB0GGIC8srXx+pJq6Ki9mU7DPxJNv8bwTzxIZw8ZjVS0xAZwq
         LxXrf6KOirC1OU2i2wDZodzJftKZcfFk0Brn0MFiyb15elECPTyu9Bzn3BK/nDJw62mN
         zy8vJHQfvjpRxmxflI7nED5LQCbBI5kc0+ikAtaVk+IvMqCDOLxWKe4BBdOXvabADo91
         vRRBvT4NYFC7qBvZQjkTgI4uQnM3c9pWB+7Y4L/PlLYQG9INNJdmAJOi4mkUkqjgSZ9l
         HLU6O1+WfnPUK1p337FobOT9sDW/QxkjKc7GkRZjXHmOg1hra1TYE/yRfKbMoZ5tTLAF
         OmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722955166; x=1723559966;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4EeH0lY+Ewy/pWDk6E3bMS6Wq7uVbNGOBf9b/txebg=;
        b=vk/IQL/pnStil0yWACRC2V7kmLRLFY9nKdoTIykY8YtxAkySqk8BdnR+87wU7zlrmw
         xgbB4s5hCA+SJCe1NAKiuCk33+XAB/JDNDpzw7NgHnK2nuaBQtrMXW/pMWoEq+O7YMGY
         JcAjWq3KfRkvw4zVaf8BgiZghc9NlgwehzFWDU+xfvEvmQE1x1yNlB+lAYYCCS/Q4dSG
         Co+fL3tBgyprIkZdkR4V+SLM2yckB8cbRBynBNtytit3x/YYtje57lxTiCJ9IkzRiWOj
         nM8LnUBQFG/u703iscLuKxR3xs6h+lesp7OE4PMoEbEaaVaCzM4XFcAqoA2/VP2GNom6
         pKhA==
X-Forwarded-Encrypted: i=1; AJvYcCXpgze+6kpTSmgKSdjI36+1JuCka18qwK36FOoV+np6TvZDctGwVk1wstFEKM/Jd9Bq0Q3W9DhPY4hrDfrz0ZiB7WPon7HVocuwJNiS
X-Gm-Message-State: AOJu0YzxCRq2CowPUJeVYDDKG2nqc5FUCYD4zTiJw0hnXiM1d+bxhutX
	LT0d6QP1aFjhMYqj0nhJ+LV8qo6JVX4wUeWSO90Db+m2naCDjvQJ1CHJ8ON6tQ==
X-Google-Smtp-Source: AGHT+IEt+B2fM5winuaW+nvnzWqWUM+4wQ9VRXuPNs4sBBxJsLRqx4kYyRLSWtsgj2ZxvObCS1514A==
X-Received: by 2002:a17:903:1207:b0:1f6:fcd9:5b86 with SMTP id d9443c01a7336-1ff5722e771mr156566585ad.12.1722955165862;
        Tue, 06 Aug 2024 07:39:25 -0700 (PDT)
Received: from thinkpad ([120.60.72.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff591786b3sm88483375ad.214.2024.08.06.07.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:39:25 -0700 (PDT)
Date: Tue, 6 Aug 2024 20:09:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	mika.westerberg@linux.intel.com, Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <20240806143918.GC2968@thinkpad>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org>
 <ZqyxS8spZ-ohsP3R@wunner.de>
 <20240805133555.GC7274@thinkpad>
 <ZrHITXLkKrDbQKQp@wunner.de>
 <20240806124107.GB2968@thinkpad>
 <ZrIe70Z7uFven8HH@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrIe70Z7uFven8HH@wunner.de>

On Tue, Aug 06, 2024 at 03:02:39PM +0200, Lukas Wunner wrote:
> On Tue, Aug 06, 2024 at 06:11:07PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Aug 06, 2024 at 08:53:01AM +0200, Lukas Wunner wrote:
> > > AFAICS we always program the device to go to D3hot and the platform
> > > then cuts power, thereby putting it into D3cold.  So D3hot is never
> > > skipped.  See __pci_set_power_state():
> > > 
> > > 	if (state == PCI_D3cold) {
> > > 		/*
> > > 		 * To put the device in D3cold, put it into D3hot in the native
> > > 		 * way, then put it into D3cold using platform ops.
> > > 		 */
> > > 		error = pci_set_low_power_state(dev, PCI_D3hot, locked);
> > > 
> > > 		if (pci_platform_power_transition(dev, PCI_D3cold))
> > > 			return error;
> > > 
> > 
> > This is applicable only to pci_set_power_state(), but AFAIK PCIe spec
> > doesn't mandate switching to D3Hot for entering D3Cold.
> 
> Per PCI Bus Power Management Interface Specification r1.2 sec 5.5 fig 5-1,
> the only supported state transition to D3cold is from D3hot.
> 
> Per PCIe r6.2 sec 5.2, "PM is compatible with the PCI Bus Power Management
> Interface Specification".
> 
> Granted, PCI-PM is an ancient spec, so I think anyone can be forgiven
> for not knowing its intricacies off-the-cuff. :)
> 

Ah, the grand old PCI-PM... I don't remember the last time I looked into it :)

> 
> > So the PCIe host controller drivers (especically non-ACPI platforms)
> > may just send PME_Turn_Off followed by removing the slot power
> > (which again is not controlled by pci_set_power_state())
> > as there are no non-ACPI related hooks as of now.
> 
> Ideally, devicetree-based platforms should be brought into the
> platform_pci_*() fold to align them with ACPI and get common
> behavior across all platforms.
> 

Yeah, that would be the ideal case. Unfortunately, there is no ideal ground for
DT :/ We do not even have the supplies populated properly. But with the advent
of power sequencing framework, I think this can be fixed.

Regarding your comment on patch 3/4, we already have the sysfs attribute to
control whether the device can be put into D3Cold or not and that is directly
coming from userspace. So there is no guarantee to assume that D3Hot support is
considered.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

