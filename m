Return-Path: <linux-kernel+bounces-244552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4DB92A5E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4501C2162D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E159D1422CA;
	Mon,  8 Jul 2024 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PsHVBUn7"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430A13B7A3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453180; cv=none; b=TbhQ8vQrKdQEHb3BtxGzyi71OrygYSSfcstFBW2wTNEyES9ioo8KlTCc4hh8uzJ+DlZ1OxP777vnBOQ2sWEEuvm8C7BmM4GcxxcpzdnWDZLd0BqZ6mUYrcmPMSmYdJisJI51CrFlxZ8Kb9sTve2ii7hizfvXLecwvz1+mALTNsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453180; c=relaxed/simple;
	bh=lFmVvDZRq/Ve1iuqOkYT5EoULMpc/byYke1wKWP0OrU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dl7zRpDmJwPuE+Ztr3wvDeCRcbrT/00H7QQagOzFP3u7Ihst8mhhTGL0eENiVp55gF57poRfh6SLnsEPhrayj4+TePxmTB/bdZnbuSjz/MUo+CvatcGlVXgfpA19xhoJBhjFk6B8wNdWDWlmp8BBEEqJ/3pBQOEJLm69rwyMOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PsHVBUn7; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c6639b34fcso1408850eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720453178; x=1721057978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ko4nEiDfhlR7fhraWGQD/gHhjHGleJUcF9JQDJhaqVg=;
        b=PsHVBUn7Dv9qm9gG1nPU2z4Iiil1/ZLId1E9tR+syI5S2nYTTljL83N7lyot+3C+Es
         xTDVfK6JK/2melVVeXvRY7VuqCzX1Onr4T59oB2AFGOgbPUAsMOA8aDOMdoZyuZrjWdT
         K1RndZFu0DGeClSX/a5YX6YfrObFKOU0qX2zD35v/61W2z/0UT6UvELdXbHm7cA8zRC6
         nwHXj/kazf2KVuwUogeg7iv8Y6sVbcVNGt1sykmwqf33esT38E4wBB8c8rtG9Wt2kds4
         jHngWid4+7Nh/1/xu0tuSvXE018QYOCFgKEi+MgFXb3tnwGp6WhqIXdC7fTAOTYRTVHu
         gffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720453178; x=1721057978;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko4nEiDfhlR7fhraWGQD/gHhjHGleJUcF9JQDJhaqVg=;
        b=TmO+ZdD2B79+C5CMluVt+ndFUPYYvzBEawPcaR3Ti41xgm1iEPehB58skKhW0qceh8
         J/IdRkqXh2sjCKLOCO4S8Yp1obwP90LyGF2eGknmMFKLcbg/syiznnAwHwxhs7dvqU2X
         tCnR5c9Oq8eavrV61vLJ94PNx/sKXifb93pWoW/lVnmnsjTNK8jsa2+ODBQ4WOBX03/o
         twxom61DUjdlbJqB70nAeNwIxlwDiqeiukK14H3245noT4Iz/EO9KRPqN1AX8XZENQId
         TmIz5YSCelcvfAoW+v+7W7nAotbq1bjVHs4FQKh2vLbGJprALA5hArarHwLChncSnZWg
         WjKg==
X-Forwarded-Encrypted: i=1; AJvYcCVfpLnEEc17GT5xBK1I8o8ICTSMTBvW+jGAgR1Qnnk2gWd4WZwwZGo8jZLgfaQs2/VeGWtKx/B5lUUun/V0ogUfqP1Gt6ilx3ilKuTj
X-Gm-Message-State: AOJu0Yzxw2BORc9CaROTj+njJFgklcTiwusVKBUaGMlagUx//MuAfGsx
	2DETpg6MPCqXzANjEg9vdqt9j9p8rJdJpt2lktzZBkAud/XPM24gYGaUeFt4EFaMvOuTszP03IU
	=
X-Google-Smtp-Source: AGHT+IHZ+X32NksTb54ym15qqLdWcT2/2e6/hNZhPy7Iz2Eghsby8ddGDc0YUlTOyQwI2Yx4TvgURA==
X-Received: by 2002:a05:6870:9690:b0:24f:c31a:5c29 with SMTP id 586e51a60fabf-25e2bf1eebbmr10662019fac.43.1720453177758;
        Mon, 08 Jul 2024 08:39:37 -0700 (PDT)
Received: from thinkpad ([120.56.193.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b1d15b336sm4760838b3a.198.2024.07.08.08.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:39:37 -0700 (PDT)
Date: Mon, 8 Jul 2024 21:09:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: maz@kernel.org, tglx@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: MSIs not freed in GICv3 ITS driver
Message-ID: <20240708153933.GC5745@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Marc, Thomas,

I'm seeing a weird behavior with GICv3 ITS driver while allocating MSIs from
PCIe devices. When the PCIe driver (I'm using virtio_pci_common.c) tries to
allocate non power of 2 MSIs (like 3), then the GICv3 MSI driver always rounds
the MSI count to power of 2 to find the order. In this case, the order becomes 2
in its_alloc_device_irq(). So 4 entries are allocated by
bitmap_find_free_region().

But since the PCIe driver has only requested 3 MSIs, its_irq_domain_alloc()
will only allocate 3 MSIs, leaving one bitmap entry unused.

And when the driver frees the MSIs using pci_free_irq_vectors(), only 3
allocated MSIs were freed and their bitmap entries were also released. But the
entry for the additional bitmap was never released. Due to this,
its_free_device() was also never called, resulting in the ITS device not getting
freed.

So when the PCIe driver tries to request the MSIs again (PCIe device being
removed and inserted back), because the ITS device was not freed previously,
MSIs were again requested for the same ITS device. And due to the stale bitmap
entry, the ITS driver refuses to allocate 4 MSIs as only 3 bitmap entries were
available. This forces the PCIe driver to reduce the MSI count, which is sub
optimal.

This behavior might be applicable to other irqchip drivers handling MSI as well.
I want to know if this behavior is already known with MSI and irqchip drivers?

For fixing this issue, the PCIe drivers could always request MSIs of power of 2,
and use a dummy MSI handler for the extra number of MSIs allocated. This could
also be done in the generic MSI driver itself to avoid changes in the PCIe
drivers. But I wouldn't say it is the best possible fix.

Is there any other way to address this issue? Or am I missing something
completely?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

