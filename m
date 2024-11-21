Return-Path: <linux-kernel+bounces-416925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5015E9D4C74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3F81F21412
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167FC1D5158;
	Thu, 21 Nov 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhS0yCdw"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74361D130B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190429; cv=none; b=Md70uvsfa8wD9GZQvqtKFiU+XaXl4aBiuM43vzwfEWMEh9TsOVpr4SfkxWYix+EOSpiNc9uVPxHlk/5myYzSvNM/ZWeqjioukNiQpRzWvBqhO5QP8N9Q6tbdPpsg40F+NdjSSNvhuddoFJrgww8cguiaMayh9qB/HjxlQ3bx8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190429; c=relaxed/simple;
	bh=OoZJR2+ov3fDxBQH8pWZ/XmJj7qoEvI8McYAkI4dJ3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrVnvJPguvVHfEqjc+bn/rFiepqUVrk08AdF5n7cTuDkqeYB2ZjNsbk5nEMIypblJ68aH7B1kO/QdXRkFgQXLOILJS7oS/rh+0HWyt0i4UlSLrv5aSHl2QCw8XRTfcqz7vdapqFHEAvU/bX2fnpdEHJdCielZjpOgacqNf64YQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JhS0yCdw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so550160a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732190427; x=1732795227; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A0KaqIgWU78jGTLQV/ntlFCPMpX4M5t2dVVcePwkX5Q=;
        b=JhS0yCdwmU2xJCtXwYNvnCA+2Y+Y43bPVUknf452bjy9TqmgWOPRornCLqHqJq3khX
         jP3VqJ6mXTn+HFYNBDT07t+86TwVYY2LPM8cIui4wQ9Rtm6j4vpdjNXz9w/3FUYDai7m
         zzs+drttdAB5m5UIR2y3I4syw0gWdLTiMAXZcLPlxXLM9WXGrIT9byOEBUobrkqkffKt
         2FFkvyhE30IdweSU3lpzdj7zRsKAd1kEGejbOp/ZfFTA4P5m8cJonu05jlkl0H6x/FSS
         mU3vIi0knGNTjmED7L+uHzjHf98K0vxpKJmY8AArJtRZzC6foebpClw/1ob3SgLmQ3PK
         j+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732190427; x=1732795227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0KaqIgWU78jGTLQV/ntlFCPMpX4M5t2dVVcePwkX5Q=;
        b=L7Ul+aILqnYSfmuwe1LozhoqcbhxPC1+8TmSqhjcquMGSDPn7f/9h2hs9oO8jwDWBr
         07jRmwzT5RGY78CeLWL4hqbPDWIE6hcKf/raU+fhLH2CyazzCK7O18fdjpsnHcsi1W3B
         VMqiSlxs2H4vSQ0bnXYViSwAvIC9N+cRkIi/FKVBM+TuSxnmHSoLR8DDVrodzguNXFNZ
         Pm6EjZs5IwvjQkKo635EbI7LlPx2ES86H+2UGDwwy2P7iWgkR+9BLHeyiJL5Rf/ImwAL
         k4YB2OuJIZmUlL3BN/X009m5aJMCK7Gl5HuFOmZFb/aG58HlkOcAsXawMxUM0SXGqnZe
         FBDg==
X-Forwarded-Encrypted: i=1; AJvYcCUu+qDmEnjZslmUp00Ix+Xp2Clwx7eMua6qnuwzxZ3meGEW9TkV+NljS/fzfcubbqA9Z46Q8atX7b5QV1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLvOPc8QzQE8u6YgFsLKyICIoYKRct0s4IZzaMEVdpGlqHOHi
	MF2YIxLftIhnyT6Jw/W1/OjH/K2MEfORhSVcsMZWWdjaiMnx4rdGIefNS0TGJw==
X-Google-Smtp-Source: AGHT+IFqmjxDouxPX/74E997yYaCb6bWEwvPoG1rWG54LZgfgq2N/Y3XtIQ20mASvuKJapBPu4OW5Q==
X-Received: by 2002:a05:6a20:6a20:b0:1db:e587:4c3d with SMTP id adf61e73a8af0-1ddaf399e1bmr9836982637.23.1732190427120;
        Thu, 21 Nov 2024 04:00:27 -0800 (PST)
Received: from thinkpad ([120.60.55.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64ef735sm1161644a12.18.2024.11.21.04.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 04:00:26 -0800 (PST)
Date: Thu, 21 Nov 2024 17:30:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable+noautosel@kernel.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v2 3/5] PCI/pwrctl: Ensure that the pwrctl drivers are
 probed before the PCI client drivers
Message-ID: <20241121120010.zjmo7sun2j7w2f5r@thinkpad>
References: <20241120170232.flllyqcycsrsk6cj@thinkpad>
 <20241120201839.GA2338274@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241120201839.GA2338274@bhelgaas>

On Wed, Nov 20, 2024 at 02:18:39PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 20, 2024 at 10:32:32PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Nov 20, 2024 at 10:10:47AM -0600, Bjorn Helgaas wrote:
> > > On Fri, Oct 25, 2024 at 01:24:53PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > > > As per the kernel device driver model, pwrctl device is the supplier for
> > > > the PCI device. But the device link that enforces the supplier-consumer
> > > > relationship is created inside the pwrctl driver currently. Due to this,
> > > > the driver model doesn't prevent probing of the PCI client drivers before
> > > > probing the corresponding pwrctl drivers. This may lead to a race condition
> > > > if the PCI device was already powered on by the bootloader (before the
> > > > pwrctl driver).
> > > 
> > > > +	 * Create a device link between the PCI device and pwrctl device (if
> > > > +	 * exists). This ensures that the pwrctl drivers are probed before the
> > > > +	 * PCI client drivers.
> > > > +	 */
> > > > +	pdev = of_find_device_by_node(dn);
> > > > +	if (pdev) {
> > > > +		if (!device_link_add(&dev->dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
> > > > +			pci_err(dev, "failed to add device link between %s and %s\n",
> > > > +				dev_name(&dev->dev), pdev->name);
> > > 
> > > This prints the name for "dev" twice (once by pci_err(dev) and again
> > > from dev_name(&dev->dev)).  Is it helpful to see it twice here?
> > 
> > Hmm, not very much. It could be reworded as below:
> > 
> > 	pci_err(dev, "failed to link: %s\n", pdev->name);
> 
> OK.  I updated the comment and the message like this (also renamed
> of_pci_is_supply_present() to of_pci_supply_present() so it reads more
> naturally in "if" statements):
> 
> -	 * Create a device link between the PCI device and pwrctrl device (if
> -	 * exists). This ensures that the pwrctrl drivers are probed before the
> -	 * PCI client drivers.
> +	 * If the PCI device is associated with a pwrctrl device with a
> +	 * power supply, create a device link between the PCI device and
> +	 * pwrctrl device.  This ensures that pwrctrl drivers are probed
> +	 * before PCI client drivers.
>  	 */
>  	pdev = of_find_device_by_node(dn);
> -	if (pdev) {
> +	if (pdev && of_pci_supply_present(dn)) {
>  		if (!device_link_add(&dev->dev, &pdev->dev,
>  				     DL_FLAG_AUTOREMOVE_CONSUMER))
> -			pci_err(dev, "failed to add device link between %s and %s\n",
> -				dev_name(&dev->dev), pdev->name);
> +			pci_err(dev, "failed to add device link to power control device %s\n",

Maybe use 'pwrctrl' instead of 'power control'?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

