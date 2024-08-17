Return-Path: <linux-kernel+bounces-290620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B0495565D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 10:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8C9283B81
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB113D2BB;
	Sat, 17 Aug 2024 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXFSC6xG"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648014375A
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723883144; cv=none; b=kglSEwKSOTUiJJ0p8A7xIrXdye5tREXUbBlfjgeiw4tabR/CU/7WTnVJNtDh5DwEigsMnnYunZHLLnQx5qM5bTP+CDknAy7+V4qzLDFRtUxPyzWQr/gUBSXp+I9m4r4mU8fMigT/XvHyY7V/vVM1WwypJUOxrZmhvnk8o5oSJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723883144; c=relaxed/simple;
	bh=7QYh5fWsYcBy4BjPUODYKtBT58CJYBQAeJg9WYheKL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dK3b2ACBsJh+O95JYZJIDCeRKH5UPc7/zrzG6v4n5WOLhYljilgMbz9Up7Y7vYZ2mtHD2vopcwQPYUTK1ekg0lFE4GhDEU/xeJRYRWUYghwXBAtSNGWpRxBIzwC6ZrA/PHhej+5nGDLQbBgT0bWhltA6aBPa1LgfxAR0osP5Tug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kXFSC6xG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42812945633so21804265e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 01:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723883141; x=1724487941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ0y+Bx0FfYzJuV9mHkWycb1W7eNsjmgnYDcCobrBgQ=;
        b=kXFSC6xGH8epNlVa2RzJmDHoiSTn/dJGKlY0JMnNNnv/7q0PjV0W1ZIHAdXvh3Xi9c
         Embr8d9Q41mORTPSPolWBaip3j7o2iNgoDcMGqpH7qKcSt3Ot758P2juBmohHTsIdb6c
         bO9/qRfenU5p/HBhf/pQkQABtOlaXLotVifvYupnakiBt+TRe41txv4Bq4sHRVMOKoO0
         jtlo/LjQ3yZ8R2KouTLZAqpH9KteXsQ8wMGGuy6Z+leZZWxw4uHjZTjh4ZkxoKG0TI3H
         wSpXJ9r7g+g6uZVqZ0PRRVmFHz9aa9AiPyoGY24jASf5e/h3vDaEiFGDZzsY8v9DNF6m
         op4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723883141; x=1724487941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJ0y+Bx0FfYzJuV9mHkWycb1W7eNsjmgnYDcCobrBgQ=;
        b=I4s9e1EIc3SiRG6vrrCwxHJ5E7Sc99GIohPPojs8qhKmj9eTGcRJcLVcQOAZkjv1uh
         Pqx5HKCTNUXxwf2N4cXZV29Y4Aj9Hw8g67C1bxnKOXcCzFvqQjtKInHS3149HE4GyNud
         wyS5FGIn1txYRt83bauYoxnRCx0HIwGJZBb1M5lLaXqnhxn52o29pk9uStqgFi/X+H6+
         FIdes68XuR82jgHa19RiLxsyxM5N3NlqKr+ZxvpXHgbM6VUfdfOEvwO6Lv6RDh+BiqL6
         TElKIXwkG5jB1ZsNYtoM+X/vt4SxldDK7ygWepVITx//wk+yUoJerK2Vogmzw68xf+rj
         O4rQ==
X-Forwarded-Encrypted: i=1; AJvYcCX141gRTO9r9BrXJrcSeWQuzpfhPtaiIKNaGaxxTdj1YiPVWtETxOwS7TvhZcvabQXHjj+4VMc0In5NIwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSTe3vt6eF7KEHIprndkMAGI7OYBsNP1JHzxdWICH3wY1ax7X4
	P4Xg3f0mrszLoy/7SmhCUGvEX7SfhAAfJeIgb9W1tu5F8zxO5gpvsy+t9DvlPR8=
X-Google-Smtp-Source: AGHT+IFJ12nDtVRGYsYXFLwDyDsgUaCOjGBYJyBY4Zbk3GuRikGwJdu2MeEqx46imh4mG3NDHfzGgw==
X-Received: by 2002:a05:600c:3ba5:b0:426:6667:5c42 with SMTP id 5b1f17b1804b1-429ed7856camr34069445e9.4.1723883140978;
        Sat, 17 Aug 2024 01:25:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded364fesm96109695e9.27.2024.08.17.01.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 01:25:40 -0700 (PDT)
Date: Sat, 17 Aug 2024 11:25:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amit Vadhavana <av2082000@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	ricardo@marliere.net, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, vkoul@kernel.org,
	olivierdautricourt@gmail.com, sr@denx.de,
	ludovic.desroches@microchip.com, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, rjui@broadcom.com,
	sbranden@broadcom.com, wangzhou1@hisilicon.com, haijie1@huawei.com,
	fenghua.yu@intel.com, dave.jiang@intel.com, zhoubinbin@loongson.cn,
	sean.wang@mediatek.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, afaerber@suse.de,
	manivannan.sadhasivam@linaro.org, Basavaraj.Natikar@amd.com,
	linus.walleij@linaro.org, ldewangan@nvidia.com,
	jonathanh@nvidia.com, thierry.reding@gmail.com,
	laurent.pinchart@ideasonboard.com, michal.simek@amd.com,
	Frank.Li@nxp.com, n.shubin@yadro.com, yajun.deng@linux.dev,
	quic_jjohnson@quicinc.com, lizetao1@huawei.com, pliem@maxlinear.com,
	konrad.dybcio@linaro.org, kees@kernel.org, gustavoars@kernel.org,
	bryan.odonoghue@linaro.org, linux@treblig.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2] dmaengine: Fix spelling mistakes
Message-ID: <b155a6e9-9fe1-4990-8ba7-e1ff24cca041@stanley.mountain>
References: <20240817080408.8010-1-av2082000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817080408.8010-1-av2082000@gmail.com>

On Sat, Aug 17, 2024 at 01:34:08PM +0530, Amit Vadhavana wrote:
> Correct spelling mistakes in the DMA engine to improve readability
> and clarity without altering functionality.
> 
> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---
> V1: https://lore.kernel.org/all/20240810184333.34859-1-av2082000@gmail.com 
> V1 -> V2:
> - Write the commit description in imperative mode.

Why?  Did someone ask for that?

regards,
dan carpenter


