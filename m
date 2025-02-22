Return-Path: <linux-kernel+bounces-526964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F8A405C0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CEEB7A774C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787241E7C19;
	Sat, 22 Feb 2025 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DulgnGbz"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157D817C2
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740203870; cv=none; b=OHkvqz2ykfM6Yx1HD+xQHn69UaEasTiCIBDRs3UjxNjVIFdYkYicWQ/rZfT2hNFRbqZOQf6VLPIGcNua3qzd2S9u1bhrLb658ZE+ZEq38ljCf7vAl1UNUWDw+2X42ntXT3eJkwRDinwLrKcDzD0bZZRGZiF5V5XZkr/8x+JoSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740203870; c=relaxed/simple;
	bh=3lUi4eaP8fiSjpUflPb1RACY4yHSfW8GKlJbVHdvqCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN2ZJVehbHbf/XWCbidRhY2OvDhDm0Dxc7AIGRsJ6SJixstrHheqF7+64kftCk205UabFQoctXy1NbrgawR2tPSO57fH7qdfkS55PmJPzEoRDwoXl0aL4ziISbiSAMlweLyBoPOZ0qoO0Hr83dCSQs9S8w+BXuW06vMCVhmY760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DulgnGbz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54622829175so2556962e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740203867; x=1740808667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Kt0NR2NlGLg/3e+DlKZWP6D2g9Q+QziaayO29Mn3Uk=;
        b=DulgnGbz9pwqU4TPQyKSut0zZ35xKmsQfHPrdPlmybPOQzqZ4MouLTgiDRe1AR6iXp
         8KYphDeWYRben+p8vaYbvZlVMa4yRW+kD0r6Xol51nnURkrCvKtSRMg0xCH+6Ds1ipoM
         tKf7XEUBaLOih+gwFGsl8uzmn9dvH8V/46GntaI3Wdz8+OEAaLEvWrvY5bBrGAHreRkV
         pf+V839DvpI/FfdPSNkPSu0ZVcbOAtTCOE5PnLMAdUBUn0l1GGx5YsO+2jOoR7CNut59
         1oa5fPXwEjCEw4nrN1/d1MBO3pRXy4RObPvTWg6pjGLKduncij0o7eGkHttoBrMEXv0l
         jcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740203867; x=1740808667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Kt0NR2NlGLg/3e+DlKZWP6D2g9Q+QziaayO29Mn3Uk=;
        b=U2Ac6R1Yq+JTWw/dDTS0tFgEOKCuomcv0WpWTYe/AcZekBmcLAED3i6mFOoGvx2jou
         22vEPXjsBDyufZzeGwzIZfZ9Xyy6OjpgX+AnDSa+O9NnFD1qg3JDr9fDNtD/5uapt/ZC
         yykc2kyerl8lzisowHpVHXnVXkzRT+Mb4dqavUvkIsBox6RjNOn8vajEXSJrHdWcGFhv
         T5o760sJGnO0quY866Lm0/qrN+8gZgHn25pXe8Gl0wPeiiZjwzKxkIGG30T1XPreSizQ
         KHY52TC5+6BvYJWmC9Zs2BF90hV4ZsJSXaZ5juam8+Ynnc2ng+J9Bp8aswX4m2J1bGQX
         wz2g==
X-Forwarded-Encrypted: i=1; AJvYcCWJp//rAOqIOjKZPUHBfUXCHS4fotcNdR9cdUFK9dh1tUNX6zr4Yle1RRKPiO8bC+AZEPdh4h3Ks4hogpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC+9GJwprI6RcOTUvhClfMeYf9X5KWkyE8r7bg8Tgt2WGfiXEF
	F+dShYDenpR3l9UUEaE3kkclUi2bvZ7L3pLwnviGALdd41ImFsari3/FwrAdUJY=
X-Gm-Gg: ASbGncs4bzQNlhNhUtMEboPl16r4VUAr3TCpfpcPQgwBw9Pv/uR/ESjqcH5BCjDp2pB
	Zkg5EnflLdx2mnn8boagI5a6Ag20FOrKC747gsZgmobrvnUYr17LujtndCcp44oQ6/etVKMocjd
	YxeUkdBEHhnRqBXawDbhFx/BhJZl8me8yISikEt1v4yprlwTUElJPAvev5FQDry2YdleDCMJhnZ
	agmK9kCAPj2SoZGVYt7PC8HvPOfHu9IJRB2x6i9QECtetrMsfPKyCnJ80L4PJowtPOZXPmZlMqd
	eraeagvRPIms4gMeHODtHe0l/v9i4hS7lwwCjVjWXUQKHMXKVm3KgCK8IqeFvWBnBI1X2sqkY0K
	q5JhA8g==
X-Google-Smtp-Source: AGHT+IEGU+ITg7kX7MUzMtAr9W6WLS946omhx6csxzIbCYxjStKWUvFgymVnv5iOhDMlgG8tznozRA==
X-Received: by 2002:a05:6512:b98:b0:545:16fe:536a with SMTP id 2adb3069b0e04-548391452a9mr2739083e87.31.1740203867063;
        Fri, 21 Feb 2025 21:57:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452e44052fsm2457607e87.80.2025.02.21.21.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 21:57:45 -0800 (PST)
Date: Sat, 22 Feb 2025 07:57:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 8/8] drm/hisilicon/hibmc: Add MSI irq getting
 and requesting for HPD
Message-ID: <sjddkllmy4fptwpzlejyjo5jlusxlnipf2fryziirbbetkrbmp@bx62xcu5kzjz>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-9-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222025102.1519798-9-shiyongbang@huawei.com>

On Sat, Feb 22, 2025 at 10:51:01AM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> To realize HPD feature, request irq for HPD , add its handler function.
> We use pci_alloc_irq_vectors() to get our msi irq, because we have two
> interrupts now.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  3 +
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 77 +++++++++++++++----
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  3 +
>  3 files changed, 69 insertions(+), 14 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

