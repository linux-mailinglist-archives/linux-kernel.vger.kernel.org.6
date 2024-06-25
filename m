Return-Path: <linux-kernel+bounces-229086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6931B916AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195241F24723
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0F916FF55;
	Tue, 25 Jun 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHNJh8ki"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8616DEB3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326428; cv=none; b=gRjJD8118kGPmNcD0b/qIdyceCls4hNJpind6knxXShD3kXTMcG230B4eAIJTNK3FbdzQXcgGmK4ZfyFOPPHVZRtWT52m9NzTUGedj6BuShR8DtfNaCmgIMUjH2sJRPMjQRuK3K/pTTg8LeyTQxCK4lvSBbRuEPKP7nzodW7Mqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326428; c=relaxed/simple;
	bh=trALs8KdLx6VhITV+c8+7FsleAuPSHSH71GZILSGCq8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sqFA/O10wSYgVDx4BV3vTEfMPyxEIaWBH7IEcB3Dd8IRdhA/1G9a+7/D4xLd94pRUvfsMkc0VlzZh7rVefwe7y86YIF5ronM/XgJ82RsmZkZ1qp1QPQyJucD9R4ALX9FQ+qrZf72yKHOB9qX5qo+WCsi96lWLgkFMheciwPtBIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oHNJh8ki; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42198492353so46818495e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719326424; x=1719931224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSANmUbEh6D7VW1j/tL/xnWMrzPKUXm5bDXQ8ewTync=;
        b=oHNJh8kikWXt3JTsg9SRimjq6SKmnkmH2Ag4dH5nl5IJvby0LErFjtGTsskBk5Ezhq
         X3+CFvqZUI1IN1fzTYY5Njd1kL4dneyw2O8U8Q3zKIg1SHgwF0YcK1fa5Rd3A5LJ01eZ
         DYmv/78x+qzw3o7zPxSZ93wF6jA76JtPKy+fYw4Ux1Mfrm/qnm4BGxmgV6bB/4iMivQe
         g9YCM3g1RzbK2N9yzdHEXbUlae1rakkBPFWrXJvkPkiEFJ9rMIG6GrZYyLfscrCWukBM
         HBTwK4/WckrR26ctoXz+27yJ102WZd/nz5sW5Ph6c7+UKVDVvrCSnvztkKHSfhH8VxRF
         m4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326424; x=1719931224;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSANmUbEh6D7VW1j/tL/xnWMrzPKUXm5bDXQ8ewTync=;
        b=nU1VOf4J/YNFZRfPzkInl7FP9uhpNiMaqxm9yZYF+GtWk0HEktVWnEMrTJutEOL/sw
         83l5LGIU0Ph3tBj7grsEJnJVjW2IHy/CFQnaPX8bq3EinPdIkTo+wkVCi1xati/B5IJM
         6sgKi3JlYtiC0UnBJ4rvD9q3dpgv2ck4FEx+sYYK9DxWrgWavoxgaDWIYIUTk6WLaMTI
         jn3leWlIh2AMNRVNwgNpszKV4YcJNOk0TSYjpCZA3S3I46ivl/EcfjgLg5reTCO3JfK6
         uNVlejo5Rd9biz9MrelSYjokDtVPL4YAxEnQdad++7kdQWilwEwaSZhBNFEZSitBT3ec
         dVtw==
X-Forwarded-Encrypted: i=1; AJvYcCVxXutkpGhi0knKIy2WNWUzTee1/f0HU/vfb394R2JeDxaGUi58j4OS3sOCYHj+Gk5cRehg5thtoB7kEYmzu14Fx5XYCKDCq7w38JvZ
X-Gm-Message-State: AOJu0YzCCN248WBSLBEwZQ7vmVaQknuz4pOS5ky1rt9Zker/YTWUIons
	K+f0yS+BJiHeXkhrZGj9elWVr3MnYwtBjss5Feog9y4d236lhTQFbTDqQe0Uw72+OLODD/CedEW
	7OqE=
X-Google-Smtp-Source: AGHT+IHETM2J/do/2SDqnSnmgKYgYsfQ586CEBVmGuu5NWFMEzbLBxusn/KmGl6Yk1pyNmCJDNWl4g==
X-Received: by 2002:a7b:c3c1:0:b0:421:2b13:e9cf with SMTP id 5b1f17b1804b1-4248cc66b18mr53553185e9.36.1719326424339;
        Tue, 25 Jun 2024 07:40:24 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b3dsm218556165e9.34.2024.06.25.07.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:40:23 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20240624-fastrpc-ml-v1-1-5dad89dce78f@linaro.org>
References: <20240624-fastrpc-ml-v1-1-5dad89dce78f@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: CC dri-devel list on Qualcomm FastRPC
 patches
Message-Id: <171932642324.352395.16698786992801289835.b4-ty@linaro.org>
Date: Tue, 25 Jun 2024 15:40:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 24 Jun 2024 11:19:09 +0300, Dmitry Baryshkov wrote:
> FastRPC is a way to offload method invocation to the DSPs on Qualcomm
> platforms. As the driver uses dma-bufs, add dri-devel mailing list to
> the MAINTAINERS's entry, so that DRM maintainers are notified about the
> uAPI changes. This follows the usual practice established by the "DMA
> BUFFER SHARING FRAMEWORK" entry in the file.
> 
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: CC dri-devel list on Qualcomm FastRPC patches
      commit: 47bf4198bf386018e99673c1ce5dbd8e5eda293e

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


