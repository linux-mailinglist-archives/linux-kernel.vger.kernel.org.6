Return-Path: <linux-kernel+bounces-544650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62837A4E460
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA3F8A3829
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF96D24EA96;
	Tue,  4 Mar 2025 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBIbM/7U"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5605424EA93
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101507; cv=none; b=GqcL8ZemYRYTFx+TwhX6h1eJSadVypQXWpn3Wn3/ebGcp7ThDilj97d/8h2MzAoSKJ/F6PVNBSa27z+CUvC/h6X9QE+t4bBOfEJ5VFq04d7HCm2WAL55b1SU/86QOw+CvJLVX5P3FyXiTa7/6aImNQl9zqpA4j/Q//INfFu4Vwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101507; c=relaxed/simple;
	bh=Nfbb4Q2xiDkH6WLiFI7e76Q6PwRDTA9H9+XvuWdYO9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWZ80q9bPQRUjtcj5F/zt9dFUzjGtWm9/RVDh4MtJgHfvIoXTqlNvdgjXrD0Z301VGXMr2mMABWTZfFALfNVxaFKJjr8hBNC55b2mlSsAjHEe+koufw153J/IYdI8bQUkm0D8CcV49mopyISWEt1ClBo5o9WZQjDteGhHq/V8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBIbM/7U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22349bb8605so112120495ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741101504; x=1741706304; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KzhE+tdJAYWvPcPUwSdrS55NblQcSF6sK2zBz4cziEo=;
        b=gBIbM/7UCn3d+kG8XQQpXgjv6oo4359Az4NnhRvQG+OrZfNy37HWbUI6mXw5KqCHhH
         TN/VygfvNKNe497X57clJASH+VZQaIHPlbwaiW25ebDH9QtnXib+9HHy7Y7VFEiCJc+0
         U6ORj5nJcfQTJnuISlGSu2QKJys2DcjF9JWIjL2ZDYXn0GW5v+baNmvKmzUWgSviPKUa
         +pz2PZJPk1H6e0PFFtX+/9JS+ayLoZlPhgkvw7FqIaZ3vpHaioJX/BrbbMaNU3vxZUKi
         mA7vfCrejLi428a5pJ8iKs16cicAo9+tgbEkDiktMQHaJK8sJcird1xYiJfZFyBJh/HC
         0m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101504; x=1741706304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzhE+tdJAYWvPcPUwSdrS55NblQcSF6sK2zBz4cziEo=;
        b=VuMYzVjYQsTnyySmiERlI+JPil4QmrjUfDpDgNpDpM1xI6LDGEl0Szs6wnQ0eGthFb
         P28ek87e5K/qTVnzNrf9j4EsohaZtRrdrsZdAoaEPfGFgZgxIiO+iwP7LlckLnmm3kna
         aA3x1pgKkwklzoinjvwGlRMB7bFIY2nuDpZ5DEFeGdO5WFvxbKpcUoGClr9yfyoxp+9R
         C/lC/KJztXhV2kzQ72BPokMjOX6RQVUhev4P2wqMsS5f/i90kFoJxRMxgoHc/vtB3Em+
         a60QpCRA4t422bCTc16Ix+a0gD7drTfDczDofkhfr3fc9WBVkNUNaGoVHOvCG3Dnm5YY
         TLqg==
X-Forwarded-Encrypted: i=1; AJvYcCW2B1aExWNwwpwjk6i2024MibJ/h96GQA1sMuSUEV1wZ8AfLn/LrtkD25Vl5AXn3rR7uzTZ7fo9gOa/Wss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJXJ87o8SfIefWdaWRjlxSkkxck7GbrxLMnONPQTGdafhpgJJ
	ls3hpuKVYZNKsxxgN/LjlR3/VE8HZLS1yl84eyZNjiInPnuSn8W+NhcKbdyPJw==
X-Gm-Gg: ASbGncvi1CszbJymOtQe0KGtyNd+zVYGKshHFyRL5K+zzSGdhP7PkiNdgIFVxvrIyw8
	9s0ZT5OO33un95kZQ/sTox1Y2+shzOY6AIf4BNnD95Y3w0VbR/V6O7sjzqndF1kTrR90qKbl1WK
	vbQm/KlEdmCSXnjWzpZd7h8PkYyRI6CgM9++Ufi8yzVgRwSjWDtY9dBlkSblGKASweC82yK8CQ0
	QOxAFfQACcDC3neAOxjlR47PAHXA30WAvrZt1R0Tc1Xh9vJxSDrxtSlHhZJvhmenekEYrN1A1kk
	A7JOKxpY8Cd8tQayGJhHtHv240K8bfCZ+YIW8Fp5SAxT28D7YnqWxok=
X-Google-Smtp-Source: AGHT+IE5m+vrO6nNhOZDvuax+Cu982tB5v2FtygKBkyOtqqZSXWNrXN1iB/dSPoQj7bI+IrEJ3ckng==
X-Received: by 2002:a17:902:e752:b0:21f:45d:21fb with SMTP id d9443c01a7336-22368f61965mr234071745ad.3.1741101503081;
        Tue, 04 Mar 2025 07:18:23 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504db7a6sm95889145ad.160.2025.03.04.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:18:22 -0800 (PST)
Date: Tue, 4 Mar 2025 20:48:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Fan Ni <nifan.cxl@gmail.com>,
	Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <20250304151814.6xu7cbpwpqrvcad5@thinkpad>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
 <20250221131548.59616-4-shradha.t@samsung.com>
 <Z8XrYxP_pZr6tFU8@debian>
 <20250303194647.GC1552306@rocinante>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303194647.GC1552306@rocinante>

+ Geert (who reported the regression in -next)

On Tue, Mar 04, 2025 at 04:46:47AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > > +int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> > > +{
> > > +	char dirname[DWC_DEBUGFS_BUF_MAX];
> > > +	struct device *dev = pci->dev;
> > > +	struct debugfs_info *debugfs;
> > > +	struct dentry *dir;
> > > +	int ret;
> > > +
> > > +	/* Create main directory for each platform driver */
> > > +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> > > +	dir = debugfs_create_dir(dirname, NULL);
> > > +	debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> > > +	if (!debugfs)
> > > +		return -ENOMEM;
> > > +
> > > +	debugfs->debug_dir = dir;
> > > +	pci->debugfs = debugfs;
> > > +	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> > > +	if (ret)
> > > +		dev_dbg(dev, "RASDES debugfs init failed\n");
> > 
> > What will happen if ret != 0? still return 0? 
> 
> Given that callers of dwc_pcie_debugfs_init() check for errors,
> this probably should correctly bubble up any failure coming from
> dwc_pcie_rasdes_debugfs_init().
> 
> I made updates to the code directly on the current branch, have a look:
> 
>   https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=1ff54f4cbaed9ec6994844967c36cf7ada4cbe5e
> 
> Let me know if this is OK with you.
> 

If the SoC has no RASDES capability, then this call is bound to fail (which will
break existing platforms). I'd propose to return 0 if
dw_pcie_find_rasdes_capability() fails in addition to this change:

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index dca1e9999113..7277a21e30d5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -471,7 +471,7 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
        ras_cap = dw_pcie_find_rasdes_capability(pci);
        if (!ras_cap) {
                dev_dbg(dev, "no RASDES capability available\n");
-               return -ENODEV;
+               return 0;
        }
 
        rasdes_info = devm_kzalloc(dev, sizeof(*rasdes_info), GFP_KERNEL);

This will fix the regressions like the one reported by Geert:

https://lore.kernel.org/linux-pci/CAMuHMdWuCJAd-mCpCoseThureCKnnep4T-Z0h1_WJ1BOf2ZeDg@mail.gmail.com/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

