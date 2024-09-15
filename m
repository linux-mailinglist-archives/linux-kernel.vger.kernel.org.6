Return-Path: <linux-kernel+bounces-329876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E11D9796F9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EC91F21A81
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8271F1C6F64;
	Sun, 15 Sep 2024 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BsstoVRS"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5321C57BB
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726409290; cv=none; b=q49TaQlWwsU4D4Jf9FRwHtRb7wiBQPLil5x3EKsPxrQgUmHJPZMKlFi39LsmBzeX5k4lJiq+XCnVRjBbj1HT6BEOoAEI+j1R3y0b74dQ1vtbbR0R63VcZSYWHfKTf9x5VOeXud1OOZXiAnpYAC2RvmAOXVVPf6ZSQ11QQSpIlOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726409290; c=relaxed/simple;
	bh=GfT6dD8sFY2oQhCO9PtqTkl3lPIfLc+IuYIxo1EtG9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Huq/8HHhV9+NOH4+FDLpEbqRUFFu5+eNVzmIktxIqSaawHRF2+9ZcTz+H1fMkw8y+y/WoT3/xPxl+0+FfVAoBLqGT7GSDgiITEvO3gPgggSP0hLz+soTxah1q7LIucbvcS3P2lY/+zey741rtQ15Dofv7XE+a7Q49Mj0PNmHaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BsstoVRS; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c582ca168fso14482806d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726409287; x=1727014087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qETOmqLs3VcWBE6fq/NLpP/VdMfGfLvWYa4naTceEbU=;
        b=BsstoVRShEMxUrH7sLstFMUcVjr3GLiPJfqCUTfB6j2SpOjmx1/khaNRiimGAQVB/h
         khiZQaeJJVdVBd60qnLpPYLWi3Ng+p+qbxXu2BPRsIjB/bPNh/+VNWbYWH8R6D29wT46
         ol/XaQiZSgVv3z54MPYHzURGn4mL9OXZLOq7bebjG98y7Rc5EX2n5mZNS3atHm2okb00
         wJRF/uKjwEga5RDQvYz01N74XRqyCFYrZ/DXr499XyFKbEPjZefN3B//NmYBJkENKL9J
         6CsCoTyXY5jqtoG3BoPvQSyHTZAgnOpNR+bC78wBl8Bfa1WZTDqGOlwsTol7LeMkIPaK
         BKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726409287; x=1727014087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qETOmqLs3VcWBE6fq/NLpP/VdMfGfLvWYa4naTceEbU=;
        b=vr63yr5BPt/fzSk8kgro3WPS3PRHX1oOqj1+ADI6stli7ySC67lL+ebGFSBMLKHB2F
         v1azo1ankETVAaANs8+E0lY4YhMMexTgyfvxe4kKceWoEj9S/N5qiktvVSWmfD6nuICD
         U0dyQ6Itug9TFfFgJXPNbrYnu5e4OmX2dVhLylAnG26ZdJkRh4djZtJjeWI/GlRvN2yZ
         Aqcl8G2eMcCeAi6GzxabslRTBiJJuK3TgNZ0B8uSQkFYDCKzqB+Wxf3vmS5wcBbtwzKh
         tlzpwyHpI9bphwzdcc1+JwbCau+wjNcal6AUpuhUoTsWsEqMVdq7kCaSnyPp37SnBBT9
         NWpg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Dc6VOY1xkbAcy9QZom5vvRL0fgGWRQ3PthEGCwBrMJqnNvGfPZtHjVaDZWeY3JSQzWscp6xgftoXlmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWCnNaBNw8jH6ZuLFTdJrTPzLhR4sjEF0TxSLlmYfRglcyqOL
	5pAN48wx7wY3L1R0C0kbHXCUhluIw+Yglbvy8r0k+UuyqvFmQ7VPClxc45YI838=
X-Google-Smtp-Source: AGHT+IEGScRXWkjCa1MsukJtaEHzEo9sxiP6ZOXcwDMa/t01rqjqte/GHdDfO4BuPAC0Ip8flPeYYw==
X-Received: by 2002:a05:6214:5a07:b0:6c5:5326:18a5 with SMTP id 6a1803df08f44-6c57dfb94a0mr155649476d6.28.1726409287152;
        Sun, 15 Sep 2024 07:08:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c632f7bsm16033696d6.37.2024.09.15.07.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 07:08:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sppv4-007h2G-0a;
	Sun, 15 Sep 2024 11:08:06 -0300
Date: Sun, 15 Sep 2024 11:08:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Karol Herbst <kherbst@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/nouveau/tegra: Use iommu_paging_domain_alloc()
Message-ID: <20240915140806.GE869260@ziepe.ca>
References: <20240902014700.66095-1-baolu.lu@linux.intel.com>
 <20240902014700.66095-2-baolu.lu@linux.intel.com>
 <a43c31da6a6989874eb0998dc937d7a611ec542c.camel@redhat.com>
 <20240905132459.GG1909087@ziepe.ca>
 <243808ad949823a0d64cd785ed05a375ccdba096.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <243808ad949823a0d64cd785ed05a375ccdba096.camel@redhat.com>

On Thu, Sep 05, 2024 at 12:26:31PM -0400, Lyude Paul wrote:
> I did take the one patch - but I'm happy to push the others to drm-misc
> (provided they all get reviewed. 2/3 seems to be reviewed already but not 3/3)

Did it get lost?

$ git reset --hard next-20240913
$ git grep 'iommu_domain_alloc(' drivers/gpu/
drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c:		tdev->iommu.domain = iommu_domain_alloc(&platform_bus_type);

??

 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |  4 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        | 10 +++++++---
 drivers/gpu/drm/tegra/drm.c                        |  5 +++--

Now we have the other two but not nouveau?

Jason

