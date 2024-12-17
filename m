Return-Path: <linux-kernel+bounces-449394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8749F4E68
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67481675F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD371F667B;
	Tue, 17 Dec 2024 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pha0mVgD"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D121F6679
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447045; cv=none; b=NwdLTHAUxLV+fKOBwnZdwLz95rC3w4WFwqLIZAVYFIR4IL/rbY1clhTS3LBbrdYMCJIph/lT652Pq5wNjG8AfM6hNtlc35Tz9/HDMNgdfNaedFcm0MH6CRikVrFPOS7azGbNESHNkHUcDvDz7VeidSC4RnZNWxSrxBaZ2BoDpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447045; c=relaxed/simple;
	bh=ZbUaNb3EeOq38wPTGMjiF7auqJAwjbXnxnlKi2+F84E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lb0R6aIUZA6cf+PXsOIR9QBFTQZLD8NemHyJVGIWZumYu+vD6WqownkLJtOgUCmjZMS8JgemEwIyzWWYSfAlPKixZIrRKPXTWJr4rmI6WPoDGk/en3D6BZEb5RzxBeCjEj4FKhXLNwecqLK4D+GNpZ7++y10fHOpNj5BO1S5sy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pha0mVgD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216426b0865so47429195ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734447043; x=1735051843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WWlyGLT1JwLt22qsbr4SWZ1DntkrQPILyyQ7U2P+kkY=;
        b=Pha0mVgD4Rgj/Lyb6LKZ68WnJnpybLlzvYz/Q4ByIioxXTtVCkFcOM5j3NwARZCpsv
         6OeDaGSaiDzMOqd3Ell1zO7EB7Okkr67AkpqbfSzHnsSHrvNx5DCKGsZZT/8QHC67DYs
         hV3E+KX1y1gxNSJDDWvrUC7LxZebwHtsI4+LOOlcNjY0Ad3Dc4rwck3l7KZKcwPI8pjX
         Ctls8em5dBUZ6kizBR3VyVKQMrn/FWOt10UUz7ax6a5VQo+txV5lRElPDJ6nFxqFcEaj
         QJ7i6Ia9Of0fLUmTiYkIl9lBhW1UXPmqLTWN9+6i5tf60IfLEgOkD/7hnAvmw2f7qlAA
         hh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734447043; x=1735051843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWlyGLT1JwLt22qsbr4SWZ1DntkrQPILyyQ7U2P+kkY=;
        b=ubLlL4m3YuFMe7fDZhWOX/bpISBCYbk8xvGHoofbYTO1m+TeEAFNDYDqi6xNs+YdWl
         XUJpSAizM7DY1lydzqNDv+gCfe2BdqUXcspUwqZrsB9Gie7NRdVNmLcfKrTS4kPJfYxa
         2LDUY/vjUIMo+He61faZtC9PhQZq3FpdvYROHUygmA28AGsmeCw+T6uzmdjj38X9kE3m
         mh8UZtYe1D4fy8jDL5dfXl4ajwIqrZs5vEJPEZGtYWkGHrofrZPSEpWf8zYE1aiMPp2Q
         EVMLxEb27adRACj5GfH23/sSgGmnJ2MyXax/PljLM4TSIWP7/fbz/AS/diFviGw1hSjj
         ao8A==
X-Forwarded-Encrypted: i=1; AJvYcCWlKN4ggdzBoz7sWa3j6a+C0NSyUNGMNeyM5jDhjGIC9QhzHjNtSWwvNzUGB6E24x0S+2vqEBYI9dDr7QM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhis0PlQAcG8jh54lerM8bia0fqLQGSoka1cgcNEidzEjwT6hN
	Qm1L4sloSP0rQqMU7c18qiKJ3dEh4c1TzJjAtoe6v7ynke5ROWQfR4+aLQMEIg==
X-Gm-Gg: ASbGncuboDpwqunMtI4B9xXTmj5vdg5BEinlY3rvdh5zkh+5CFqfV4RYF8lCAFWjJ9W
	k1ekiNJNrX83bglg18pPyiNuT37waIBCxxMh8V4ouy30s7sR5+VJS700V0JwOPWpZuKbCXomB+z
	9zXz47LQEkrkPcn8dX1ebypxwS1K7dB0Q1okFqzPhaQkYzmaq4MVbAjk1mj+PBco3u9+HmHJ/z+
	2C+kFfYf/Bcbd0/ckF+zOenv9dCUOIKwbDMHNXpS44yHb29NZpmIWLSxBrGusCaS0te
X-Google-Smtp-Source: AGHT+IFDViMZlPC0m+oxxZvBpRPL70m/brWbrYzW/ZKuaCPt2qJLSqTvp50LiJFnWq39M8/NKSm20g==
X-Received: by 2002:a17:903:234d:b0:215:5240:bb3d with SMTP id d9443c01a7336-21892a416f2mr237981565ad.42.1734447042791;
        Tue, 17 Dec 2024 06:50:42 -0800 (PST)
Received: from thinkpad ([117.193.214.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcc165sm60475035ad.88.2024.12.17.06.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:50:42 -0800 (PST)
Date: Tue, 17 Dec 2024 20:20:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH 1/4] PCI/pwrctrl: Move creation of pwrctrl devices to
 pci_scan_device()
Message-ID: <20241217145035.xqfl4yp3atpgqzth@thinkpad>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
 <20241210-pci-pwrctrl-slot-v1-1-eae45e488040@linaro.org>
 <Z18Pmq7_rK3pvuT4@wunner.de>
 <20241216051521.riyy5radru6rxqhg@thinkpad>
 <Z2F5Oph2o8o_LiZc@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2F5Oph2o8o_LiZc@wunner.de>

On Tue, Dec 17, 2024 at 02:14:34PM +0100, Lukas Wunner wrote:
> On Mon, Dec 16, 2024 at 10:45:21AM +0530, Manivannan Sadhasivam wrote:
> > On Sun, Dec 15, 2024 at 06:19:22PM +0100, Lukas Wunner wrote:
> > > On Tue, Dec 10, 2024 at 03:25:24PM +0530, Manivannan Sadhasivam wrote:
> > > > diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> > > > index 2fb174db91e5..9cc7e2b7f2b5 100644
> > > > --- a/drivers/pci/pwrctrl/core.c
> > > > +++ b/drivers/pci/pwrctrl/core.c
> > > > @@ -44,7 +44,7 @@ static void rescan_work_func(struct work_struct *work)
> > > >  						   struct pci_pwrctrl, work);
> > > >  
> > > >  	pci_lock_rescan_remove();
> > > > -	pci_rescan_bus(to_pci_dev(pwrctrl->dev->parent)->bus);
> > > > +	pci_rescan_bus(to_pci_host_bridge(pwrctrl->dev->parent)->bus);
> > > >  	pci_unlock_rescan_remove();
> > > >  }
> > > 
> > > Remind me, what's the purpose of this?  I'm guessing that it
> > > recursively creates the platform devices below the newly
> > > powered up device, is that correct?  If so, is it still
> > > necessary?  Doesn't the new approach automatically create
> > > those devices upon their enumeration?
> > 
> > If the pwrctrl driver is available at the time of platform device creation,
> > this is not needed. But if the driver is not available at that time and
> > probed later, then we need to rescan the bus to enumerate the devices.
> 
> I see.  Sounds like this can be made conditional on the caller
> being a module.  I think you could achieve this with the following
> in pci_pwrctl_device_set_ready():
> 
> -	schedule_work(&pwrctl->work);
> +	if (is_module_address(_RET_IP_))
> +		schedule_work(&pwrctl->work);
> 
> Though you'd also have to declare pci_pwrctl_device_set_ready()
> "__attribute__((always_inline))" so that it gets inlined into
> devm_pci_pwrctl_device_set_ready() and the condition works there
> as well.
> 

I'd prefer to skip the rescan if the pwrctrl device is created and let the
pci_pwrctrl_device_set_ready() initiate rescan once the device is powered on.
This way, we could avoid scanning for the device twice.

> I'm wondering whether the bus notifier is still necessary with
> the new scheme.  Since the power control device is instantiated
> and destroyed in unison with the pci_dev, can't the device link
> always be created on instantiation of the power control device?
> 

I did move the devlink handling out of bus notifier callback with commit,
b458ff7e8176 ("PCI/pwrctl: Ensure that pwrctl drivers are probed before PCI
client drivers").

The bus notifier is only used to set 'of_node_reused' flag to indicate that the
corresponding DT node is already used.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

