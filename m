Return-Path: <linux-kernel+bounces-245725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580392B81E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA0A285D2A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C63156C61;
	Tue,  9 Jul 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REHOlr9y"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C3312CDB6;
	Tue,  9 Jul 2024 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524640; cv=none; b=sHNBp2U2ZjuETUFEvqH704YabaPKsiq0sfGUpi4LEytonml6Omdd+lsMxvtmAAjAHDj7wtLT1eEn90Oh6qSROoLy9JqyAm8LAMOAfImYOjOkFw0gn3DCK+ztByvrDKO0kpy6En3L20MSUPD93oULWEmpF8iFX9BQIkz5tsJp+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524640; c=relaxed/simple;
	bh=fIX6ixrAYdf6dI/dZkfwDgBUu1sXkxgK8sJ2KThkAKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJHQbyaWzZpCPEdpyIQjrPTAo/IF3ridL39bSJYvsvDexf24kMg5ynwvDaxjBTaht45YTJlaXpJ0pTBtffky1Q2AygbcyyZ6ptgnuQB4NZQfbyOvPqro52051LC34zrCV6gcKB36DX69HuHUfN2nX93DjvZRd7HCMNRB5yvTx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REHOlr9y; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-38b1ce72526so1021715ab.0;
        Tue, 09 Jul 2024 04:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720524638; x=1721129438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OybDJgpz6EY+j/3mJEj8sCqVPmrO9HMmhiXf8ikWJtY=;
        b=REHOlr9yLph/zHi5D2ehMTTwZ48soxeCJaFIWes9SIj9qw3lQP8EUONC4UhHj/SdNH
         HcPNwQZfNBoyFojIzFDqgSKKN/wY7gFTWbnL5lG8zUk1TxPZ1yREOUuL5joEYhLmWQl3
         WTHSMk410jvEshtEOUGzfnPeGXq1Dekt6oUSnr4Y2utcZCaiHXxoQWUKD/93Gfx6QnrS
         xjyJS0WDyTkkk69vs9DyXA2H6wBzU7Ls7PW+WfrK/bbzemes69BDPWEcRzjXCZ9Z14ZP
         W9PQ9UBI7juiavZzSV2Veo6r3MEOh1jAxhhNWKgLnVuMAMp6w8rPUVMFjaUrUltJQeZI
         94sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720524638; x=1721129438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OybDJgpz6EY+j/3mJEj8sCqVPmrO9HMmhiXf8ikWJtY=;
        b=J8jeIVeW788kHTus4SVaX3xnGBP8nHvs3qbC64OnzF+F17mqbsAkoELKYflWl4FeWj
         g2lQaxt2OwTAeN0wSoll5ekR0MJSISh9EISCuK5MXsEJ7usgxEQnqkiqwslt+QBfGtR1
         Nsv05FDpHPVh5nFYzRq5lYPimpsW92JCqLaDGcyzpfd1Zu8s5tvSLtPK6yhKw+Mj5c8F
         4/cEZTD4EN2jp62n2BUKS3xs3pmmlCo2NS3iNMMdM5IIPZPWQl8+73yN3ElnHtUQBgtP
         e+CU6JMm45sYCOkhg4vT1k3Ct7uNl/EmtnzwaO+0pYvAYITMaW5zsT5wHUgdIF8QMmpu
         D6xA==
X-Forwarded-Encrypted: i=1; AJvYcCUyp/SlzUvAz1wCtFTTOY5InhjZsSABiLT5DWKGNqCglIy8P8jrNa8Bpjj84FIOWMObkiuwxpFku/wIkIjxuoGQ1R16N/l++imVfFaFgTOBY76YyDjX+FdKx7VaJ7Nd+84xhdcyxOAIIQ==
X-Gm-Message-State: AOJu0YwOL63wzWFdCYEnVTXY7Ghlb2Xu7kPSR2GVngdd0A6NbGtng+aa
	amJi/cXJaAt0dzQAJY1vc4btuhXag3g6oD0PM0DwOFJVAaFJXkk+VK2URUt2cZ6SEdwlSdjiQKT
	RRAio4LRGg1wVmoDh0UIvmk13XHo=
X-Google-Smtp-Source: AGHT+IFPPY70EF131mrWS92AdxahsTxcIjvT/UMQ5GCEha7X5m+AdeBkpVaMR0Kgsk0JXGV9ftk+CsXREEzIyZTvwPw=
X-Received: by 2002:a05:6e02:1c03:b0:382:7825:fe4e with SMTP id
 e9e14a558f8ab-38a585851d4mr26758075ab.16.1720524637800; Tue, 09 Jul 2024
 04:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708230613.448846-1-quic_obabatun@quicinc.com>
In-Reply-To: <20240708230613.448846-1-quic_obabatun@quicinc.com>
From: Klara Modin <klarasmodin@gmail.com>
Date: Tue, 9 Jul 2024 13:30:27 +0200
Message-ID: <CABq1_vjvPeF-h19-H99q5D1u7wvtbRPoKKqroMJFaMb+yUFLgg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Revert use of Unflatten_devicetree APIs from reserved_mem
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: robh@kernel.org, saravanak@google.com, aisheng.dong@nxp.com, hch@lst.de, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, will@kernel.org, 
	catalin.marinas@arm.com, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Den tis 9 juli 2024 kl 01:06 skrev Oreoluwa Babatunde
<quic_obabatun@quicinc.com>:
>
> With recent changes made to initialize the cma regions before the page
> tables are setup, commit f2a524d9ef5b ("of: reserved_mem: Restructure
> code to call reserved mem init functions earlier"), an issue was
> introduced where the initialization of the cma regions fail and are
> initialized as "non-reusable" regions instead of "reusable". [1], [2]
>
> This issue occurs because the device_node of the regions are not yet
> created by the time the cma regions are being initialized.
>
> The cma regions need to be initialized before the page tables are setup
> for them to be configured correctly as was realized in [3].
>
> Hence, since the unflatten_devicetree APIs are not available until after
> the page tables have been setup, revert back to using the fdt APIs. This
> makes it possible to store a reference to each cma node in the
> reserved_mem array by the time it is needed in the init function.
>
> [1] https://lore.kernel.org/all/DU0PR04MB9299C3EC247E1FE2C373440F80DE2@DU0PR04MB9299.eurprd04.prod.outlook.com/
>
> [2] https://lore.kernel.org/all/986361f4-f000-4129-8214-39f2fb4a90da@gmail.com/
>
> [3] https://lore.kernel.org/all/20240610213403.GA1697364@thelio-3990X/
>

These reverts also fixes the issue for me. Feel free to CC me when you
decide to send the next version if you want and I can retest it.

Regards,
Tested-by: Klara Modin <klarasmodin@gmail.com>

> Oreoluwa Babatunde (4):
>   Revert "of: reserved_mem: Restructure code to call reserved mem init
>     functions earlier"
>   Revert "of: reserved_mem: Rename fdt_* functions to refelct the change
>     from using fdt APIs"
>   Revert "of: reserved_mem: Use unflatten_devicetree APIs to scan
>     reserved memory nodes"
>   of: reserved_mem: Restructure code to call rmem init functions earlier
>
>  drivers/of/fdt.c                |   2 +-
>  drivers/of/of_private.h         |   2 +-
>  drivers/of/of_reserved_mem.c    | 103 +++++++++++++++++---------------
>  include/linux/of_reserved_mem.h |   2 +-
>  kernel/dma/coherent.c           |  10 ++--
>  kernel/dma/contiguous.c         |   8 +--
>  kernel/dma/swiotlb.c            |  10 ++--
>  7 files changed, 72 insertions(+), 65 deletions(-)
>
> --
> 2.34.1
>

