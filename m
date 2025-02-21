Return-Path: <linux-kernel+bounces-526355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065AFA3FDAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653C63BB705
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34333250BE0;
	Fri, 21 Feb 2025 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JnXOP68m"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03CF2505BC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159528; cv=none; b=tBCIuUPrEfCC0tfhoYIW1R8dDE3TsJmAOah/k2quMv2pTMt3LOtCGEGjFAHvs2Q0hWOGvpUoLeQbJT520lueYbmHV9KcIWuYtUzkg3MKm4F7DyVl1wkMgH5rlYkyq3Musk6J7FLVdRnEg8NSPM4nTyoZNHIL/cpDExNd/0OIQOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159528; c=relaxed/simple;
	bh=qIP63+uFmKIQiAqirrGDSCV5Cld724eX5jwqFNrBJYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1D0VMAphpzjzZy+IxKp6BhxeBZZCmdKXzg1i1+F/wHx/nwnUGMLHoU995p0Nyvdyiy3uW/nep29ADE7V3gsFLT/Gky3S53NwPPREvzvDsSMeEXYpCXoWJQz4Khe2To8MgT59rbL6OEY4QNq+FOJZSM/rAhFuKHsOGcDqVUGTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JnXOP68m; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220f4dd756eso49750325ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740159525; x=1740764325; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FiHwJM8dSlFwqISp7CMjrgy4RPDtS5r3xeIe6eP69ds=;
        b=JnXOP68mJwIy8eoqtOrm3QcKKM4CqpxOsZP2pXf953zz5R5/qCI3JsVJSCsnXOoMDS
         PFmmpsCti0W3sVIr0oqe+Dn7q+orK/fX1AY1B08T0quhid02AmB7yvxYBAfNxnlWxN0A
         olFiZjrD9SLMvSrBDsLbPCfcZJSEl86ZSIaHzjFyCyjekT2Mq+IV5Y97KErZkT/92bTg
         tqZplnoWq0b+vEBMrkjjXpzWRzaZkDMwinTSihWG5fHBPKZkE8J/SL8dgcrMI8kKFho/
         xzspW43RtKg3YPIhu/npVhFgvRPplpc7wzIvTzULv04SvIrN9u2XEvBLPf7jqcWuP/pG
         7uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159525; x=1740764325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FiHwJM8dSlFwqISp7CMjrgy4RPDtS5r3xeIe6eP69ds=;
        b=Zovcoz3x+trNTwbHi+iLarAzy25J1jmIpTIrwjlOXZSFlnwpb9b+56c8f6DpBTSCUU
         uFJ5lgWPrOTrcXuoWWI6hJqr0wPkwuHIkA/wgCGZaP0Z4EQ1MtGe8vx0EH/NL/gTCmMZ
         tu2VN+OexO78G2JGLiLEHzba8UThlHqIWg/LHyydTJ8gAIUoV0z+sli19YaviLqHwLOS
         rgniSob1thX8jCh1V2v3qGFN/YfFpo5PzJO8BNcY+0Rr1FgQ0VhXxlFMtiWh7PW+E0rN
         RuTQiA6sTMJQlc/Uy/CxrbGKPsLhhEfkmOyccaHmmFTkI6Rjlnf9OGV/Gv8mu/t95hDO
         XCig==
X-Forwarded-Encrypted: i=1; AJvYcCVt/0QQE44FGuQC4P5raplbbnIS/4sDZUpOB4WeCdz0/lXMAGmyyDNRC20L52kqKPecLmB0qWxdm3NVfgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuklK0tYzUlqYnAt2xIJiwL2lAWGPMnbQU2GIrTSyhYdv/m7Kg
	T6vNzjm8/t67XXo6mj5BJPzJpTmJ+4P0AItZYC+XbD0MtoXMM2FLaUCK6+PBUFmrzJbyI2NRilc
	=
X-Gm-Gg: ASbGnct+5yilgEmRx+Gv2juhI4kWiGT5XP/aED/ByWjN1lfdgvaWlpcXw4f2OaLCzha
	GcI+ZDWlgeprGCBJIKWORPVKKi7lKbaxkI4euzin7IXMtycFcHVr9LfAjibir2gmvgPqXQ2sLhd
	8Nv00rM6m40syRLuZuY51aZmDDVg9gNpmdNknE4NDHRpygeA+tVB//ynPdDseNopbv/D8ntFd7d
	CwndJKG3P0le4MpSfj9vz+oSdR0O4qdjwwGxCUSfqZLXyDOYnSUobdaKcMeZ96CmwmXUl1XiiW1
	xIKa70hxDRSstq5vDKmoWI0vxtZwNIk2G1s=
X-Google-Smtp-Source: AGHT+IFOundMH+uCAPZpiCXJrYcHQOAFx0FBt3tRpEx6h5NQf8ybpnEEcUX3gkiekCR/3GOpiHaQrA==
X-Received: by 2002:a17:903:2f06:b0:21f:2ded:76ea with SMTP id d9443c01a7336-2219ffa36d9mr64483195ad.36.1740159524826;
        Fri, 21 Feb 2025 09:38:44 -0800 (PST)
Received: from thinkpad ([120.60.73.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556fb40sm139273425ad.193.2025.02.21.09.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:38:44 -0800 (PST)
Date: Fri, 21 Feb 2025 23:08:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 3/5] PCI/pwrctrl: Skip scanning for the device further
 if pwrctrl device is created
Message-ID: <20250221173840.dc3eocblfklbrklo@thinkpad>
References: <20250116-pci-pwrctrl-slot-v3-3-827473c8fbf4@linaro.org>
 <20250220232451.GA319309@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220232451.GA319309@bhelgaas>

On Thu, Feb 20, 2025 at 05:24:51PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 16, 2025 at 07:39:13PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > The pwrctrl core will rescan the bus once the device is powered on. So
> > there is no need to continue scanning for the device further.
> 
> > @@ -2487,7 +2487,14 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
> >  	struct pci_dev *dev;
> >  	u32 l;
> >  
> > -	pci_pwrctrl_create_device(bus, devfn);
> > +	/*
> > +	 * Create pwrctrl device (if required) for the PCI device to handle the
> > +	 * power state. If the pwrctrl device is created, then skip scanning
> > +	 * further as the pwrctrl core will rescan the bus after powering on
> > +	 * the device.
> > +	 */
> > +	if (pci_pwrctrl_create_device(bus, devfn))
> > +		return NULL;
> 
> I assume it's possible for the PCI device to already be powered on
> even if there's a pwrctrl device for it?
> 

Yes, if the device was powered on by the bootloader.

> Does this change the enumeration order in that case?  It sounds like
> it may delay enumeration of the PCI device until the pwrctrl core
> rescans the bus?
> 

So previously, while enumerating a PCI device that requires a pwrctrl device
(indicated by DT), its client driver won't be probed until the pwrctrl driver is
probed (thanks to devlink). This was required to make sure that there would be
no race between client drivers and pwrctrl drivers probing parallely.

So in that case, there is no reason to enumerate the such devices in the first
place. That's why this patch is skipping the enumeration for those devices.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

