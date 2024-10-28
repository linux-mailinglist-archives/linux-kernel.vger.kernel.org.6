Return-Path: <linux-kernel+bounces-384885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18309B2FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFCB1C2334D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569291D90AD;
	Mon, 28 Oct 2024 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bL5N0jI0"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC618E778
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117221; cv=none; b=JCc2Ujrl9NV1Tq2BIhVJyWzwi/l5CZECWVdIPdlgqyskRry8+lao1CdOy64z6bXQzVIAWuBLvwYD92GEbCWv7zMdIPwztBOey89L93r8xQbvR8NV/X6TljDkp9G8L59Ss3aSqEHVU2O507VC3L9rpJ7e18S58oge/N0v32WHhYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117221; c=relaxed/simple;
	bh=yb/nXf+A7vG51hl0MkoS2zYLUNSodJN9EvjoSGEKEqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izrtgmupO0J3Zf+JYiInbGAB+9fNKpXLQfxIfh7u73TW4kBkCyxsEqWo39qZCRzE7vQ0Yy3k3M0/Nt++UQIR0TOMbyR4B+5bLM3DfXC8dyVCzaTSXnDr77+his6393W2byxgpLy7AeDltmKeSCcvCtMNGjUUuKXGIH8rbJPgP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bL5N0jI0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f1292a9bso4874977e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730117217; x=1730722017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvV5hGWWeFN5rUkig7q3oRLHUxqWQ6MdiNZiUO2eDYw=;
        b=bL5N0jI0dyo27hgP0J4b/g+GXMk5S0X/A8MkMnDunDteB6P5bRjG2n9ORi/zhCCGak
         3VSjprtNTb9MSBtvCxpz9tLUPKACmLHDnpLs+RI2NMpFO0US9kCNZZnfT6Cri7zIbqfI
         9QVMRwPDsyIakjRT6uQKSxFlAfVf3tJ3Jj4BsVVVLbwJRcH514GBh+kQ58kf9oqPZlvZ
         l7J4ODDwfMk3mh01OPPlq6Zw4jNAYWIuvS76MZvgL41l0dA6FumILs3R8O7DD3jdYZSU
         SPUw1UUmL8olm0BI7ANt3lnE/Ht71u5L55hgw/CLQc8atpLUgAXiGl41vZSDzYTnEa3Q
         FIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730117217; x=1730722017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvV5hGWWeFN5rUkig7q3oRLHUxqWQ6MdiNZiUO2eDYw=;
        b=aNwNtGWNIpCQmp4R2G2rZn02bw433Woq0/ZzS3abXJuq4qDF42DAg+lJIcIGHr7bUN
         PqSl+JJAwY/j9bs62sU9rMlYhybemGSy+3AzN78YVmPI8Xqxv8aP/WeEUadV/2aWzS2f
         5ynumZzEHC/wavQh43OMnjDY7PPSKUTJ2pEl0OcFTj1CqsP7vBrXdXvp4p/Oxhq23cC5
         zQ5qRTmrmV4ZsVYTW9vz2RylnLm5g7oHssH60hm8F4JEaOOZ2vlQ7RIVUIWHI48K3mfa
         bJLRXaSvDPC9I2UBL8npDWEoCTwnwKK6+9j9Edhhu4dHLC3yRZdRuFU3F4Ah8dxUkE47
         J2Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUDwcIki2u4DK2cvg43LGoUQTlkxWHEImlpA7eQsWRSVclb60TCu9FZ/a1RyO84sltf0bwMLuN+cBwFUj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznjjb6ZozR5BP8eiTAlN0mDtnCoDBEL8ph9t9bxAP7zV8fIFkQ
	WmHz04ueVqbp67LdN+9zpmDEuPuG5KUlFx3NS76wgz8tkFZjm2+GmRnf/eHduWg=
X-Google-Smtp-Source: AGHT+IE5ttRcl/11oqWt7LWA48nODyAc3M2AxGcKR636+4JvhticJ1WZicn2DdsAWLH/eET3V5bCbg==
X-Received: by 2002:a05:6512:3e1d:b0:539:fde9:4bbe with SMTP id 2adb3069b0e04-53b348cb110mr3239205e87.20.1730117217512;
        Mon, 28 Oct 2024 05:06:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1b0c79sm1057321e87.151.2024.10.28.05.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 05:06:57 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:06:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 drm-dp 1/4] drm/hisilicon/hibmc: add dp aux in hibmc
Message-ID: <uoanbi6fk7ozdjms2zlavhm6n5jdus6boosa2xlpqbffaxu4nj@7bxpobenzjcp>
References: <20241022124148.1952761-1-shiyongbang@huawei.com>
 <20241022124148.1952761-2-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022124148.1952761-2-shiyongbang@huawei.com>

On Tue, Oct 22, 2024 at 08:41:45PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> Add dp aux read/write functions. They are basic functions
> and will be used later.
> 
> Signed-off-by: baihan li <libaihan@huawei.com>

Generic comment: all patches miss your SoB. This is SoB of the author,
so you as a submitted should add yours.


-- 
With best wishes
Dmitry

