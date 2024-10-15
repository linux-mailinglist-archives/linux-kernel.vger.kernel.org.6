Return-Path: <linux-kernel+bounces-365077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7DC99DD38
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59381C217A6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09F943ACB;
	Tue, 15 Oct 2024 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/pUaM1t"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A2165F01
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 04:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728967149; cv=none; b=CwXcg4VLfa8cvJ6Xy/A9xckSmlxjpwyIoJ6Nqx2yuhv2emmoCfereQsJ77/ER1jWrBTJJD/5fqYfV9aUw0Hc5+6RCur11hcEMBxr9jGOYfsVAGsnKWqmgkAKppoyXzXvA2E72ysQUVRzzCXnYTQTRorS/a+u8ucESCcZYNMjLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728967149; c=relaxed/simple;
	bh=jh7xylnB3sPgYnLH/Q8khd5/Ku8vuL8jppv2JExA6no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXhhfA4C0ZSP7Big0ec9SeBR/L6c89IeoQ9/MvvUxNtG4JVUU3ODHHHmfBc8xsyPWtBkrxLkGNS8e2MGpK6xcecYfmh0phMxw6Kw9MkgPkE66tigM74msxPy/D04jCKp0JrvVI6CWHwRl30UTGBGuLmyeqDfa8VEbPCQwLEASyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b/pUaM1t; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2bd347124so3227856a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728967147; x=1729571947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MJynfKVQDflANhJ64n4kOsY801zOhbhkmmcsAv5LdWE=;
        b=b/pUaM1tDC6gLxEvqhCZ25c88NP/qOKi8dqhSGWWb3u/6JY0gDEamTxDhcejl/Oxkg
         CPuI8mxtM6zwhWtoPPoFy0zS53Kiw/O9+MRvalr6E2DzKWUchDMM7ktsPGAdq0cBq9EB
         OSbV4tYH+MAc6rvz0lC5+w8ywZb5wrw0u0ds9el1c7kYC6aK+df9bosppq/LjYYXJRWe
         yplqrGsA+wAqc1ceYV6SsWHaVDUk4RNyJCmCS3KIIpwPtm9Yxv0SuYIumlnmud2ybOYm
         +zl/TPGUxkdOsENKH95bl/cV/lfCGsDC3yfoQPp8llSSRoDn4UJANEcx/A7kobzoaYj3
         0bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728967147; x=1729571947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJynfKVQDflANhJ64n4kOsY801zOhbhkmmcsAv5LdWE=;
        b=TqSrT2l/Ya0fr0XbGhBuKdl+rv90WlQ5c6PK8bOzCO3sr2jU9uZPAOEYN/kihY+Iff
         cQR3IGbQipE79JIau+FZYPgBPGz8BkCOjUbbHPw65u+KHIK6WUg0G39VBdD6BlQHV5T4
         mxMKpapbK4xCVKMHTNT2Cd9mLsvxQ3IjZwUv+JSOIVoixSst2ZaFCEXd4LD6r7/os8Tx
         HPOPHIGp5yEzzYvJPm15hG7hE0EDiEeFkCVbH/c1mTVbkQLrnYzWgMCxZ3BCu3daHtvW
         p74ba6p07slZc8aeCNE688RLm/YO1UBS9yDNwtbmj87aFM3sFE2zt/4XESZRWQ/2qQIg
         sP0w==
X-Forwarded-Encrypted: i=1; AJvYcCUAG+5fCx9RwN5H9zyWa5gfjNgDdp4C79WucTMc+wZZ7hqnSw10WAt1BUzhS2RiJfWoHSXCAIPPIUIU5hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+4RnNAoug8Gra7c4OgZqQ25UB/F44H9ClT3kW8jXwZ7YJjyyf
	fKuOwrtEFjn2slObCC+TIMomgdO3hOzz1uGoFOjGunblLq83HDxGG/JzH9Xetg==
X-Google-Smtp-Source: AGHT+IEr7R59FAO98rpKKUVnCK37geRIvg8ePNXNuf3uQK5yL+pqDgFHGRuED+RGAhFDNXIrmDMgaQ==
X-Received: by 2002:a17:90a:784f:b0:2d3:c976:dd80 with SMTP id 98e67ed59e1d1-2e2f0da0e7bmr16506702a91.39.1728967146745;
        Mon, 14 Oct 2024 21:39:06 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f62c21sm484160a91.46.2024.10.14.21.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 21:39:06 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:09:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mayank Rana <quic_mrana@quicinc.com>, kevin.xie@starfivetech.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] PCI: starfive: Enable PCIe controller's runtime PM
 before probing host bridge
Message-ID: <20241015043901.gys454ykv7lgwtvm@thinkpad>
References: <20241014174817.i4yrjozmfbdrm3md@thinkpad>
 <20241014180841.GA613986@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014180841.GA613986@bhelgaas>

On Mon, Oct 14, 2024 at 01:08:41PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 14, 2024 at 11:18:17PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Oct 14, 2024 at 12:23:21PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Oct 14, 2024 at 09:26:07AM -0700, Mayank Rana wrote:
> > > > PCIe controller device (i.e. PCIe starfive device) is parent to PCIe host
> > > > bridge device. To enable runtime PM of PCIe host bridge device (child
> > > > device), it is must to enable parent device's runtime PM to avoid seeing
> > > > the below warning from PM core:
> > > > 
> > > > pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device
> > > > with active children
> > > > 
> > > > Fix this issue by enabling starfive pcie controller device's runtime PM
> > > > before calling pci_host_probe() in plda_pcie_host_init().
> > > > 
> > > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > I want this in the same series as Krishna's patch to turn on runtime
> > > PM of host bridges.  That's how I know they need to be applied in
> > > order.  If they're not in the same series, they're likely to be
> > > applied out of order.
> > 
> > There is no harm in applying this patch on its own. It fixes a legit
> > issue of enabling the parent runtime PM before the child as required
> > by the PM core. Rest of the controller drivers follow the same
> > pattern.
> > 
> > I fail to understand why you want this to be combined with Krishna's
> > patch. That patch is only a trigger, but even without that patch the
> > issue still exists (not user visible ofc).
> 
> I don't want it *combined* with Krishna's patch.
> 
> I want this applied *before* Krishna's patch because if we apply
> Krishna's patch first, we have some interval where we report the
> "Enabling runtime PM for inactive device with active children" error.
> 

No, I was asking why can't this be applied *first* and then Kirshna's patch? Why
do you want this to be again resent in a separate series?

Both patches are in a mergeable state already. So they can be applied in order.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

