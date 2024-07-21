Return-Path: <linux-kernel+bounces-258120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FEE93840B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 10:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DA828150D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 08:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08231BA50;
	Sun, 21 Jul 2024 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F73N04yk"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E692905
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721551839; cv=none; b=SF3WDQJKZ9HGYdUgwereQABJstYGi+wolTiEjVzQEyHBh8IZYDsqNklYanPbW+Z9Lx83KW6oD89AUiiTHaenVEmZ5WBP8/JyolKn9Iy64+QN/7kSzzjZ0zgYEZioTUVQoAGaoxcP/3gqzrS9PrFExR9HocT5X+m0YfztBSikh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721551839; c=relaxed/simple;
	bh=gLnxwy1QV32PBkEn0Wk5Y5q8ECKk4zdpHdlRZeylk2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLW9liP0Yd7Rkpy1BNGeKIhHhimrbjA8z5R9aueXH6sP6M2W2HetU2nm74KHzahfhrXykwn6mJRnkLAdVOLGNMH5a49rPoEh04kmmSWxIs8nYm0VOxawy3HW0BusFeoFqDlmbht9L+lfVS/unfhHdqfVEOUj7S7ZR8TI1maAW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F73N04yk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb566d528aso2052391a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 01:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721551836; x=1722156636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=blMJ5CUEcmYvSUk3ZYMTYy2ptp/2K3A7omMls3BzyVA=;
        b=F73N04ykytyjWuWTdvYrQSNcn4ZFUar20uvcD5QHJxPAnwQl1kMBRoB+4ocpmfoIhW
         902fwr3fb5QylVCLxr6iVeBdET5Zz63BDg5dyOPoxTzYUY5EshEcSl0c5nhKJuaPdEp3
         W/1ekQ8Whs+g9NQ4GhaI1qKaxUqKjCbgXauRR8cjA2UcWelwqMVF1rkQsQeTEsl1toy9
         hi2Fda/EpUQtoO2EOTHPr8vzuVacaGqOoaLWnQZKwZKtji7QjHbpsze0XT6vGNVsjGNA
         CNB+tTbO2wEZCRHGDbstXS7FucKL7iBwTvE1D14j5dJwSXCMHv4EswZOQ65TrFRBsIx6
         7k6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721551836; x=1722156636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blMJ5CUEcmYvSUk3ZYMTYy2ptp/2K3A7omMls3BzyVA=;
        b=OY6Sh0dCIGp92yg0aCJDTVt36vN5B3Z1MW/+ltbUXZETvidlp2OFfvbPDwZIGI2maF
         Y8bTSI4CreDNYIj6rbEzClvftICd9CNiIVv0ecORF/lx96S3K9Fz7ewtGK0Y44NS04oW
         JFHOr4FxQbaVoAdg+6+1fnjYJUn0VGsFiSQPRXE7QjAXbqtYLQkSqyyvCXk2ZgozFc04
         Bkmq0mDuku5Jur9FBWiT1yzVa+LPbkzzhFGJl87Q75yBnq3AvudCAu4i5Aig2LzNU3cT
         HUISagj4QmrFVY9QtOHXa/ZXfEVn+4pE55KKC9fu+FtL2ZvU2N8mrBV+VOSWW7D2oWsy
         0k6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDcdr3cqOQ/zgUnNUuoxHuDvizhujP5UCYFD7RBNiTDmdBhkJ1JXlPTVbyHgUrFEVHpkZc3F2PvXo5r70uGdr40p/OArXo96YT1gfe
X-Gm-Message-State: AOJu0Yxh8Ks6a99RsKFeQoc0eQb4SLbIL8RakBoV7uTaMK2yBwK55s3L
	D58NIroDX1J+/fXdiBiQRHeJ0MXCEF4h5m1t6+LjcpQZ+G2OUjxkil2sYk6YoA==
X-Google-Smtp-Source: AGHT+IEEDmd00hA3jTB0a6TdvwUfKHPTBRovNKbfh5jFjeaEsgNkvsM6tDX15cW9DGrBUz0GPn7P3g==
X-Received: by 2002:a17:90a:7307:b0:2c9:81fd:4c27 with SMTP id 98e67ed59e1d1-2cd27415a88mr2731703a91.14.1721551836504;
        Sun, 21 Jul 2024 01:50:36 -0700 (PDT)
Received: from thinkpad ([120.56.206.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b5c385sm4776539a91.18.2024.07.21.01.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 01:50:36 -0700 (PDT)
Date: Sun, 21 Jul 2024 14:20:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: MSIs not freed in GICv3 ITS driver
Message-ID: <20240721085032.GL1908@thinkpad>
References: <20240708153933.GC5745@thinkpad>
 <865xtf4woi.wl-maz@kernel.org>
 <20240709173708.GA44420@thinkpad>
 <877cdupdvu.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cdupdvu.wl-maz@kernel.org>

On Tue, Jul 09, 2024 at 08:24:37PM +0100, Marc Zyngier wrote:
> On Tue, 09 Jul 2024 18:37:08 +0100,
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > 
> > On Mon, Jul 08, 2024 at 06:31:57PM +0100, Marc Zyngier wrote:
> > > Mani,
> > > 
> > > On Mon, 08 Jul 2024 16:39:33 +0100,
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > > > 
> > > > Hi Marc, Thomas,
> > > > 
> > > > I'm seeing a weird behavior with GICv3 ITS driver while allocating MSIs from
> > > > PCIe devices. When the PCIe driver (I'm using virtio_pci_common.c) tries to
> > > > allocate non power of 2 MSIs (like 3), then the GICv3 MSI driver always rounds
> > > > the MSI count to power of 2 to find the order. In this case, the order becomes 2
> > > > in its_alloc_device_irq().
> > > 
> > > That's because we can only allocate EventIDs as a number of ID
> > > bits. So you can't have *1* MSI, nor 3. You can have 2, 4, 8, or
> > > 2^24. This is a power-of-two architecture.
> > > 
> > 
> > Ah okay.
> > 
> > > > So 4 entries are allocated by bitmap_find_free_region().
> > > 
> > > Assuming you're calling about its_alloc_device_irq(), it looks like a
> > > bug. Or rather, some laziness on my part. The thing is, this bitmap is
> > > only dealing with sub-allocation in the pool that has been given to
> > > the endpoint. So the power-of-two crap doesn't really matter unless
> > > you are dealing with Multi-MSI, which has actual alignment
> > > requirements.
> > > 
> > 
> > Okay.
> > 
> > > >
> > > > But since the PCIe driver has only requested 3 MSIs, its_irq_domain_alloc()
> > > > will only allocate 3 MSIs, leaving one bitmap entry unused.
> > > > 
> > > > And when the driver frees the MSIs using pci_free_irq_vectors(), only 3
> > > > allocated MSIs were freed and their bitmap entries were also released. But the
> > > > entry for the additional bitmap was never released. Due to this,
> > > > its_free_device() was also never called, resulting in the ITS device not getting
> > > > freed.
> > > > 
> > > > So when the PCIe driver tries to request the MSIs again (PCIe device being
> > > > removed and inserted back), because the ITS device was not freed previously,
> > > > MSIs were again requested for the same ITS device. And due to the stale bitmap
> > > > entry, the ITS driver refuses to allocate 4 MSIs as only 3 bitmap entries were
> > > > available. This forces the PCIe driver to reduce the MSI count, which is sub
> > > > optimal.
> > > > 
> > > > This behavior might be applicable to other irqchip drivers handling MSI as well.
> > > > I want to know if this behavior is already known with MSI and irqchip drivers?
> > > > 
> > > > For fixing this issue, the PCIe drivers could always request MSIs of power of 2,
> > > > and use a dummy MSI handler for the extra number of MSIs allocated. This could
> > > > also be done in the generic MSI driver itself to avoid changes in the PCIe
> > > > drivers. But I wouldn't say it is the best possible fix.
> > > 
> > > No, that's terrible. This is just papering over a design mistake, and
> > > I refuse to go down that road.
> > > 
> > 
> > Agree. But what about other MSI drivers? And because of the MSI design, they
> > also round the requested MSI count to power of 2, leading to unused vectors and
> > those also wouldn't get freed.
> 
> This has absolutely nothing to do with the "design" of MSIs. It has
> everything to do with not special-casing Multi-MSI.
> 
> > I think this power of 2 limitation should be
> > imposed at the API level or in the MSI driver instead of silently keeping unused
> > vectors in irqchip drivers.
> 
> You really have the wrong end of the stick. The MSi API has *zero*
> control over the payload allocation. How could it? The whole point of
> having an MSI driver is to insulate the core code from such stuff.
> 

Right, but because of the way most of the MSI drivers (not all?) use bitmap to
allocate MSIs, this issue is also present in all of them. So I think the fix is
not just applicable for the gic-its-v3 driver alone.

> >
> > > > 
> > > > Is there any other way to address this issue? Or am I missing something
> > > > completely?
> > > 
> > > Well, since each endpoint handled by an ITS has its allocation tracked
> > > by a bitmap, it makes more sense to precisely track the allocation.
> > > 
> > > Here's a quick hack that managed to survive a VM boot. It may even
> > > work. The only problem with it is that it probably breaks a Multi-MSi
> > > device sitting behind a non-transparent bridge that would get its MSIs
> > > allocated after another device. In this case, we wouldn't honor the
> > > required alignment and things would break.
> > > 
> > > So take this as a proof of concept. If that works, I'll think of how
> > > to deal with this crap in a more suitable way...
> > > 
> > 
> > This works fine. Now the ITS driver allocates requested number of MSIs, thanks!
> 
> Well, as I said, this breaks tons of other things so I'm not going to
> merge this any time soon. Certainly not before Thomas gets his MSI
> rework upstream. And then I need to work out how to deal with
> Multi-MSI in the correct way.
> 
> So don't hold your breath.
> 

Sure thing. Thanks for getting it around quickly. I'll wait for a proper fix.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

