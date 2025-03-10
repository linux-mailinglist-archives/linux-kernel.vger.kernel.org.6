Return-Path: <linux-kernel+bounces-555100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC2BA5A55F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA430173D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB071DF273;
	Mon, 10 Mar 2025 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTDv3PCS"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955B1DE8A9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640142; cv=none; b=FACnCf56Y2hs01HBp7LSfietIYUKeeXiZ+Sg3yFIovKMMrcNBLW+XzDdbGe3fUdfnz9dhTthYQ5bTXbz4qWypEfF7/fsjaHuXvZ4rd4r+g84ZrRCWRx4p3JHP3MMyBSqjzJIexMHr8BC8MaWIDp7xJo1WUGyLoIdbi6LSIz8/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640142; c=relaxed/simple;
	bh=Sr7K1yCFmgS1fvZkXvYB+jQ1TRjJLlv3NOHqMSpRiqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpNlzvvRGg43v+gDO4Do91Rfn1EuHvUAIWdPUZqYF9rkmrrE8pHnxUUXYRtiDYVBKOGuPA0KAzTZ9infk+kD8MqVTGdkzwGRIcqGdPCfBHldYckJY7LIWAaS5k8VkBqfBF2AwPaV2vnkhJLHdf0gIK64RZP2qsWigSzqfjFjgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jTDv3PCS; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5498c156f1dso5399074e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741640139; x=1742244939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOWDQFfh/dqAVjze2LQJgK0R1nQSBQ+Z81JUBKH/8tY=;
        b=jTDv3PCSofij6MyCigca4ypxDe154gLZUv0NHkxGX/doLytt+q0M7vZ5Y6jV+i6lcD
         E/eN3GAEKJFCEtmyMZD9QrWqoti6skx7GKbmR2RdYoqN75F0FyqeA+54cqaKC1pNPDFy
         jnqBSKaXs9abHo+ktqDMbqMMtHNEkm66Ww/McG+zVxPXqMBQvIbHhDk1Ljor9tPyDR3q
         tslwNIYfDOA4vm96OTtCKtMQY7kAqeIVTH8iiTTghBWn/FTNMteEe42MjAfLrjKf1tdt
         gUmvPJlU2rQd0S/0kgOOpCeb0HWIaCv0ePBuerJKo92SyEmJXalJzIrz6cyRIawjDsUj
         tmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741640139; x=1742244939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOWDQFfh/dqAVjze2LQJgK0R1nQSBQ+Z81JUBKH/8tY=;
        b=FjUg6wsX4EcWpKHDcZlWmXj5m5z9omGwX52nWjunEpeF+0+CY2Xugk9X/PrU0NXc2c
         1QTVuSJr2TulhfMiEiGEWi+0GFIQ6kSdjiT97vdukFYOXlEUrGhLjsm0+NrRHWKchDz7
         KYOxy7ZGKDizy7slis/oIrRK1Nl6S46wuzieGQ6fxIuy17dAtH12jm3tEnTWzursLcLE
         cI9OuuvhCuLDDf0eZBd3Okhn0zsMjatIA8DSnVEnqp96QA3QfuVupkHQ/OWB+7Uw8f+o
         EvvqHFKO3ycCDvTcjiVYvp1lCZFKnpTUnGmkCOd4FWPshVsYDvXd6IGZ5291IrPaEYd2
         A7pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWubVosa8s+/Xc5qAx82CBjddFbQc5vNFHIfg9JeZbXZ1hdNvKXwZLH/QKC/7a7bfFxnrPNjsXd75YOHlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+dNahfPo8To7cl/FpX3Vh1AROTVfJ4jINAvtlcBe6++vMaGDM
	ySN4sqS7R+cxP3kK9C3HUfyaajc03H6nUiFK2O5R7GOD3ObLwstVlooS+TVYXP0=
X-Gm-Gg: ASbGnctIAosqvsFXO8Mx4yPdaI4O8pZt7OedjkCFRwbuzYd83dbdRhSvuWMoBqyyqFD
	3VkWm0cWI9au6jWny1FtUdYBiaritP38oNKWczNTqhLel3KLWIcsM7p4jcE4ipOSSDrp15NidcA
	3wEnfJB7muYjc+pLXzGs/6qvE3G/lCurk98hDtj8Y1Q4b3G6E1TXG0MZ3gm6l2CAvHj+dry/8E9
	1lzgbtprJX2RAVcsKSrzNI9eGGAaZoKtgvHpxo1wb5w5Cg6snfBInMpWUJopRVGI+4B7mIquAQl
	AxgRs6fsShyyx6gr2Lx9DFT+GNutFUPB8hZRrYd5Tij5AqMtnK38vmpnjOcm5TCJ4TgMOY1FxR3
	of20teDlRGG2RrQMc2bfwFWyi
X-Google-Smtp-Source: AGHT+IHubY+f/rhxrSBxiaa325h/nsC0f2kSD//bxK0bB6+HKDQJSbjODqNhRDdqPFgVEC8cmQYHNw==
X-Received: by 2002:a05:6512:224f:b0:545:aa5:d44f with SMTP id 2adb3069b0e04-54990e673e4mr5915381e87.30.1741640138654;
        Mon, 10 Mar 2025 13:55:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae5f4d1sm1565991e87.103.2025.03.10.13.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:55:37 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:55:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 drm-dp 7/9] drm/hisilicon/hibmc: Enable this hot plug
 detect of irq feature
Message-ID: <k4c72nwjyke62eyurj6v6ymfwmdgu3hoxwv6zx442c5afin5cy@scqalfe3kwo3>
References: <20250310040138.2025715-1-shiyongbang@huawei.com>
 <20250310040138.2025715-8-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310040138.2025715-8-shiyongbang@huawei.com>

On Mon, Mar 10, 2025 at 12:01:36PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Add HPD interrupt enable functions in drm framework, and also add
> detect_ctx functions. Because of the debouncing when HPD pulled out,
> add 200 ms delay in detect_ctx(). Add link reset process to reset link
> status when a new connector pulgged in.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

