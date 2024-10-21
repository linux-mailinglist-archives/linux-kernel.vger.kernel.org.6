Return-Path: <linux-kernel+bounces-374599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AA89A6CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69EE0B25D29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0976A1FAC37;
	Mon, 21 Oct 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbZRNizu"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD21FAC39
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522354; cv=none; b=SMzdZ57mwsMPmFoANIQYPLkWRj9r8/gBHa3gP1hxRLuGjLI2YUNbYli+KYjyJIRTsEM7aR+pkyjr/cVpdXh+Rey8dCk5+1acmE3PhSMEzrLu8KIn00hPuHn7SgpKshgSzAjKv58vIs/drVQh7BY1HaHBIRnhN+VjwIJ2/TF5YxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522354; c=relaxed/simple;
	bh=qHkv5JDlqgqjZRZ7PQwcwLcJ3/hu2L0ISUVO1CYr6r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qw7dGNS3PToJ4xm6i/5fhS02Pq1Zc6dpA7GexPdX1wsyqy3wkOt0tNCUf9eODAHn6p8TMmOyz/DDQmP/wB3U5dOFVVoUtUIdEa8oPo81NGqlFUMrQJL71kEYV/t5A1IANk5RJbhJFYBdUUO82iExkkRmEZwu5KlBmME7AiClmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FbZRNizu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so1611057f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729522349; x=1730127149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjSRnQx5O46OacBUYkVWL1KnGLuYW+NCz+8zrCnNmA8=;
        b=FbZRNizuUuz+5GZEl+Xn6dQ4LHT8jpTIC9/cD0imTsGIRrkIQisHIy6XEaIU4E7tpr
         2qHa/1JK6d3X4abywQgEHdzL+jqa2Qdk7yU02JHpHkD48nmslu0BxEDjT7YFMC98hob/
         nLukdGRo8Ez3E7n3DQ64VlaBtqu3enChbAL3WCGmkjlDmMV7X739v7pTem+yMy4AnPf9
         g7ULuw64/n2C6AS3iOf/v8iJ7yVk0wAmWjPtrNNsDCOoA4SQWKI7gWoPQDR6nO4cDbc/
         JuJMgulCSRLQP4uLUnOu5iheZMnEpNHdhdWcFMAfAaFqAoALJH0lWLqabpTcYolXlXo/
         0aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729522349; x=1730127149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjSRnQx5O46OacBUYkVWL1KnGLuYW+NCz+8zrCnNmA8=;
        b=h6tVvHvbKDq/Ft7if9nDYkYAQZNNH5YIWte5U1JHW31YvsXy6WfYZH5sB2S4xr490F
         sB0CeqM9xYH1XUtyVOmGrTnNzx/A3F23fVAXmsjb+2RV60uP2kqG9/CX2/9gWlOyMYXH
         OmYxG1ITCUASwPCG3AEnpn/GUKsWd5MPZXBoqFnB4SMSwtVGL+EH5rO9DNP/ks2kuZHU
         SdB5X7U5i2lMssG3v2NQTGlOXboSCrshLiYFTev+5PnRzVJQ8GtjJKu8yc8krjBC2KrU
         t+ibrMaEWOGZlCmW5FZdZF0OZ/AjOAMXGKqll3CA7ekfFOlpxhQ9lNzkbnFA0Q9Snfq9
         w8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCV5H+ad4+S3d12UCOCeRV0gU1NF9Elk87EdQyMcCyzBtLDAIOyahXDkADw3qYx6EwxI3gcsZV3jEghjB8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp2IqeTmnjDg53gObSdxFqk0ph0cQZERmSTcinuBbpGvK4jjf7
	fU3ju2r/tinGNDoNVH46fsEwbOut/MztFzGtt+qt9+QKFxAV6dkBfcpU0hMfhhg=
X-Google-Smtp-Source: AGHT+IHR6qQguq7PH3Uh8RSkz2aVOh856iqdHv7IWaGdljT9tcnvh9y5umzoNMsFeKBw9U5YBzOTaQ==
X-Received: by 2002:adf:e542:0:b0:37d:4f54:f9c8 with SMTP id ffacd0b85a97d-37ea21c8569mr7292650f8f.33.1729522349069;
        Mon, 21 Oct 2024 07:52:29 -0700 (PDT)
Received: from [192.168.0.157] ([82.76.204.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a3805esm4552502f8f.9.2024.10.21.07.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:52:28 -0700 (PDT)
Message-ID: <5f31c010-a965-48f3-a975-efd8307316bb@linaro.org>
Date: Mon, 21 Oct 2024 15:52:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] firmware: add exynos acpm driver
To: krzk@kernel.org
Cc: alim.akhtar@samsung.com, mst@redhat.com, javierm@redhat.com,
 tzimmermann@suse.de, bartosz.golaszewski@linaro.org,
 luzmaximilian@gmail.com, sudeep.holla@arm.com, conor.dooley@microchip.com,
 bjorn@rivosinc.com, ulf.hansson@linaro.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, marcan@marcan.st, neal@gompa.dev,
 alyssa@rosenzweig.io, broonie@kernel.org, andre.draszik@linaro.org,
 willmcvicker@google.com, peter.griffin@linaro.org, kernel-team@android.com,
 vincent.guittot@linaro.org, daniel.lezcano@linaro.org,
 Jassi Brar <jassisinghbrar@gmail.com>
References: <20241017163649.3007062-1-tudor.ambarus@linaro.org>
 <20241017163649.3007062-3-tudor.ambarus@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241017163649.3007062-3-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/24 5:36 PM, Tudor Ambarus wrote:
> +static int exynos_acpm_chans_init(struct exynos_acpm *exynos_acpm)
> +{
> +	struct exynos_acpm_shmem_chan *shmem_chans, *shmem_chan;
> +	struct exynos_acpm_shmem *shmem = exynos_acpm->shmem;

As Krzysztof has already noticed, I need to use the __iomem pointer
token when referring to shmem structures. This could be caught with
sparse as well, lesson learnt:

   drivers/firmware/samsung/exynos-acpm.c:493:54: sparse: sparse:
incorrect type in argument 2 (different address spaces) @@     expected
void [noderef] __iomem *addr @@     got unsigned int * @@


The following changes will be needed for v3:

--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -161,7 +161,7 @@ struct exynos_acpm_chan {
  * @num_chans: number of channels available for this controller.
  */
 struct exynos_acpm {
-       struct exynos_acpm_shmem *shmem;
+       struct exynos_acpm_shmem __iomem *shmem;
        struct exynos_acpm_chan *chans;
        void __iomem *sram_base;
        void __iomem *regs;
@@ -485,8 +485,8 @@ static void __iomem *exynos_acpm_get_iomem_addr(void
__iomem *base,
 }

 static void exynos_acpm_rx_queue_init(struct exynos_acpm *exynos_acpm,
-                                     struct exynos_acpm_shmem_chan
*shmem_chan,
-                                     struct exynos_acpm_queue *rx)
+               struct exynos_acpm_shmem_chan __iomem *shmem_chan,
+               struct exynos_acpm_queue *rx)
 {
        void __iomem *base = exynos_acpm->sram_base;

@@ -496,8 +496,8 @@ static void exynos_acpm_rx_queue_init(struct
exynos_acpm *exynos_acpm,
 }

 static void exynos_acpm_tx_queue_init(struct exynos_acpm *exynos_acpm,
-                                     struct exynos_acpm_shmem_chan
*shmem_chan,
-                                     struct exynos_acpm_queue *tx)
+               struct exynos_acpm_shmem_chan __iomem *shmem_chan,
+               struct exynos_acpm_queue *tx)
 {
        void __iomem *base = exynos_acpm->sram_base;

@@ -527,8 +527,8 @@ static int exynos_acpm_alloc_cmds(struct exynos_acpm
*exynos_acpm,

 static int exynos_acpm_chans_init(struct exynos_acpm *exynos_acpm)
 {
-       struct exynos_acpm_shmem_chan *shmem_chans, *shmem_chan;
-       struct exynos_acpm_shmem *shmem = exynos_acpm->shmem;
+       struct exynos_acpm_shmem_chan __iomem *shmem_chans, *shmem_chan;
+       struct exynos_acpm_shmem __iomem *shmem = exynos_acpm->shmem;
        struct mbox_chan *mbox_chan, *mbox_chans;
        struct exynos_acpm_chan *chan, *chans;
        struct device *dev = exynos_acpm->dev;

