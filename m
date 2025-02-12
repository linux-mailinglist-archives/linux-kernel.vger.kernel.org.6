Return-Path: <linux-kernel+bounces-511714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24531A32EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0023165757
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F7225C6E7;
	Wed, 12 Feb 2025 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Las1eu4L"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994525D53F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384663; cv=none; b=lT0K+ivCwEZXRaXfi4ZzcN4q6plRVa5wUsVskq8PwJXWtzFtt5Yr16mOUs/FWTwUA0otVk1YPZ0maob/xYABhpl2U/B/KRM7is6e1PuUzXLesU1vQUZlEK985kYqRD3XvlYILdySPdnArX1EWmUDoIoWe0xjwHOAJ3qKs1rQIlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384663; c=relaxed/simple;
	bh=0uNIZ8azrN4SXlTTCOY6h5LukAXKY7QkwSwNdDhAG8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArtQVbHYBTG5Ee4UEBv5r16xkMYapX3Sfg2cfjFyeQoK+UYKLT1lGU94gg1gWpPNCN0FNMCSrTaR0NWYFVgnxG/SYN14gafyrkjxDMmH049uIVAmPGqfxdb7/vkkW9TgcK2+ZEckpp82MWs/BNnuR0hAQiQF6i8HfAEArx5v03U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Las1eu4L; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f6f18b474so65485455ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739384661; x=1739989461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m2ElU3GctxRiMFYaVoj6vY+mOKEICVfyJ0GDO9SHjY0=;
        b=Las1eu4LFFIYzybTCB3FKAtGkh3L4ToyDvTyfXhQU7OXt03x1x+JhgUora0vRe2Q24
         0yWFd0FlF34nlUJHR0TufEOG2MWn0hnrgYbDgdGXLhKoP3PN8zbiR3uFibNC4cGUphOp
         3tfb8ZJTMnDbn6JZHSta1aP2+9dPI8zfSK68Jhh6h5/SzWBbAyO6XkwxWAfv3wYTSmTn
         FuaLFGcD5b9wiVFLQaPlWHqfN11jGeBPqxFgYLFjOMnJ8m+SgTL+PMbWb24iuVkrsizd
         LJp4d+UsYsxYBAVjd9mWJYHOTw5xPHuAISF6daf7Hf/GmhGBNL0QzHr2ggcjkInQ+pwk
         UCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739384661; x=1739989461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2ElU3GctxRiMFYaVoj6vY+mOKEICVfyJ0GDO9SHjY0=;
        b=svAjTZutNwvTt2opyTuS2EI2e8SUx7szgQnrbbU5ZZEG9QLa+yc9t4t/iTI1LkyHwX
         SwAtSY9LvS8u15xpMu2jMoCAcEk4N6QkkjTik+tqklslq0JzGZiCfm39KtYFYhSHK2Na
         1xoR61P2Q+TS4ENtShdJ6YlPV8tglywSvIq5x29/4C7zf7q3+WwhLvvUOvwgSZGYVwt0
         br44KyijYQmWdsbjknZr3Jso7JmqidASZKomePNJ1E7DvV9KzlNlf2aIWO0U4nZq3KQ8
         1hCS87PX7LPo5t1Jr/yRfvR7rvgItwWR31Y2YSUSS7+EKp1npKCCdKuhyewQv87xn2xS
         CTzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhzFWlXlkteeQ7i4BXrgJTD00XfFU5A4jSo9ZaP/qh/nh/L1IBxsCFIsCUivkfqiWQQW0UtVzo6cUwJhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59u29T4nKBMgX9Cs/1BIdmWWorVwSR5JVdYz2qDmZzxNqYquU
	jju4R4YvpQTIng3wlJHgZAT10EtN+iNdXMndG7/2LYCfLOvENJP0eJmkS84m8/7DJcwx+c8whdq
	g6d5ra9qnARVXJGI1pU4hEIxPjKSd3LyOI02M+Q==
X-Gm-Gg: ASbGncs0MxoYgQSUuQwqzi5rZTP5Dk775fhD0fU2giD4XYpIfmu60CDlfXxukLiokGS
	6fXRsVYPjb0H3tDIDzyzp97kvzxY2IDjZA6YU787DvCFIIwhZwuJXN2exVxfOc/QNplpSWc+mFq
	86fQKNzX0h8SEze4afkeGDOcF5UePq
X-Google-Smtp-Source: AGHT+IGJUsHyZSoKK5mSruQ5wxSVF6TWnc3F12WJLnpptzSxoOCChCB1xYH+gN32bgRak35HYjqMclfM6hSw0FjRwws=
X-Received: by 2002:a05:6a21:6d9a:b0:1e1:9662:a6f2 with SMTP id
 adf61e73a8af0-1ee5c86dfd8mr8405109637.35.1739384660428; Wed, 12 Feb 2025
 10:24:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211103945.967495-1-james.clark@linaro.org> <20250211103945.967495-6-james.clark@linaro.org>
In-Reply-To: <20250211103945.967495-6-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 12 Feb 2025 18:24:08 +0000
X-Gm-Features: AWEUYZmvOWXiL_1p-coFMaJE37zBLrEvFWpIf8yOSB6Gps34OI_OmwL5PSCwH3E
Message-ID: <CAJ9a7Visv1tbR06RFZH435Q1UNCdqz+Mh0wGbsPPoYmnkVOzgA@mail.gmail.com>
Subject: Re: [PATCH 5/7] coresight: Clear self hosted claim tag on probe
To: James Clark <james.clark@linaro.org>
Cc: lcherian@marvell.com, coresight@lists.linaro.org, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

Hi James,

On Tue, 11 Feb 2025 at 10:40, James Clark <james.clark@linaro.org> wrote:
>
> This can be left behind from a crashed kernel after a kexec so clear it
> when probing each device. Similarly to
> coresight_disclaim_device_unlocked(), only clear it if it's already set
> to avoid races with an external debugger.
>
> We need a csdev_access struct in etm_init_arch_data() so just replace
> the iomem pointer with a full csdev_access struct. This means all usages
> need to be updated to go through csa->base.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c  |  1 +
>  drivers/hwtracing/coresight/coresight-core.c  | 48 +++++++++++++++----
>  .../hwtracing/coresight/coresight-cti-core.c  |  2 +
>  drivers/hwtracing/coresight/coresight-etb10.c |  2 +
>  drivers/hwtracing/coresight/coresight-etm.h   |  6 +--
>  .../coresight/coresight-etm3x-core.c          | 28 +++++------
>  .../coresight/coresight-etm3x-sysfs.c         |  8 ++--
>  .../coresight/coresight-etm4x-core.c          |  2 +
>  .../hwtracing/coresight/coresight-funnel.c    |  2 +
>  .../coresight/coresight-replicator.c          |  1 +
>  .../hwtracing/coresight/coresight-tmc-core.c  |  1 +
>  include/linux/coresight.h                     |  3 ++
>  12 files changed, 73 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index d9259c0b6e64..575c2d247a90 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -558,6 +558,7 @@ static int __catu_probe(struct device *dev, struct resource *res)
>         catu_desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
>         catu_desc.ops = &catu_ops;
>
> +       coresight_reset_claim(&catu_desc.access);
>         drvdata->csdev = coresight_register(&catu_desc);
>         if (IS_ERR(drvdata->csdev))
>                 ret = PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 7fe5d5d432c4..97f33ffad05e 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -212,20 +212,48 @@ int coresight_claim_device(struct coresight_device *csdev)
>  EXPORT_SYMBOL_GPL(coresight_claim_device);
>
>  /*
> - * coresight_disclaim_device_unlocked : Clear the claim tag for the device.
> + * Clear the claim tag for the device.
> + * Returns an error if the device wasn't already claimed.
> + */
> +int coresight_reset_claim(struct csdev_access *csa)

Given the iusue being fixed - i.e. previous sessions having residual
claims - and the fact that this funtion is only ever called from
device initialisation as far as I can tell,
would this be better to be called coresight_init_claim() and return /
log an error only if the device _was_ actually claimed.

As it stands it seems to return an error if the device was not claimed
- which on initialisation is the correct state!

Since the retrun code is ignored by all of the callees, the rerun
could be dropped and a warning issued withing this function if the
claim needed clearing.

> +{
> +       int ret;
> +
> +       CS_UNLOCK(csa->base);
> +       ret = coresight_reset_claim_unlocked(csa);
> +       CS_LOCK(csa->base);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(coresight_reset_claim);
> +
> +/*
> + * Clear the claim tag for the device. Called with CS_UNLOCKed for the component.
> + * Returns an error if the device wasn't already claimed.
> + */
> +int coresight_reset_claim_unlocked(struct csdev_access *csa)

Given the comment and the function - this could be named
"coresight_clear_claim_unlocked()"


Regards

Mike

> +{
> +       if (coresight_read_claim_tags(csa) == CORESIGHT_CLAIM_SELF_HOSTED) {
> +               coresight_clear_self_claim_tag(csa);
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(coresight_reset_claim_unlocked);
> +
> +/*
> + * coresight_disclaim_device_unlocked : Clear the claim tag for the device
> + * and warn if the device wasn't already claimed.
>   * Called with CS_UNLOCKed for the component.
>   */
>  void coresight_disclaim_device_unlocked(struct csdev_access *csa)
>  {
> -       if (coresight_read_claim_tags(csa) == CORESIGHT_CLAIM_SELF_HOSTED)
> -               coresight_clear_self_claim_tag(csa);
> -       else
> -               /*
> -                * The external agent may have not honoured our claim
> -                * and has manipulated it. Or something else has seriously
> -                * gone wrong in our driver.
> -                */
> -               WARN_ON_ONCE(1);
> +       /*
> +        * Warn if the external agent hasn't honoured our claim
> +        * and has manipulated it. Or something else has seriously
> +        * gone wrong in our driver.
> +        */
> +       WARN_ON_ONCE(coresight_reset_claim_unlocked(csa));
>  }
>  EXPORT_SYMBOL_GPL(coresight_disclaim_device_unlocked);
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index 073f67a41af9..389a72362f0c 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -931,6 +931,8 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>         cti_desc.ops = &cti_ops;
>         cti_desc.groups = drvdata->ctidev.con_groups;
>         cti_desc.dev = dev;
> +
> +       coresight_reset_claim(&cti_desc.access);
>         drvdata->csdev = coresight_register(&cti_desc);
>         if (IS_ERR(drvdata->csdev)) {
>                 ret = PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index d8bc3e776c88..b598b2c0c9bb 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -772,6 +772,8 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>         desc.pdata = pdata;
>         desc.dev = dev;
>         desc.groups = coresight_etb_groups;
> +
> +       coresight_reset_claim(&desc.access);
>         drvdata->csdev = coresight_register(&desc);
>         if (IS_ERR(drvdata->csdev))
>                 return PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
> index e02c3ea972c9..a89736309c27 100644
> --- a/drivers/hwtracing/coresight/coresight-etm.h
> +++ b/drivers/hwtracing/coresight/coresight-etm.h
> @@ -229,7 +229,7 @@ struct etm_config {
>   * @config:    structure holding configuration parameters.
>   */
>  struct etm_drvdata {
> -       void __iomem                    *base;
> +       struct csdev_access             csa;
>         struct clk                      *atclk;
>         struct coresight_device         *csdev;
>         spinlock_t                      spinlock;
> @@ -260,7 +260,7 @@ static inline void etm_writel(struct etm_drvdata *drvdata,
>                                 "invalid CP14 access to ETM reg: %#x", off);
>                 }
>         } else {
> -               writel_relaxed(val, drvdata->base + off);
> +               writel_relaxed(val, drvdata->csa.base + off);
>         }
>  }
>
> @@ -274,7 +274,7 @@ static inline unsigned int etm_readl(struct etm_drvdata *drvdata, u32 off)
>                                 "invalid CP14 access to ETM reg: %#x", off);
>                 }
>         } else {
> -               val = readl_relaxed(drvdata->base + off);
> +               val = readl_relaxed(drvdata->csa.base + off);
>         }
>
>         return val;
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 509f53b69e42..0b010683b883 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -86,9 +86,9 @@ static void etm_set_pwrup(struct etm_drvdata *drvdata)
>  {
>         u32 etmpdcr;
>
> -       etmpdcr = readl_relaxed(drvdata->base + ETMPDCR);
> +       etmpdcr = readl_relaxed(drvdata->csa.base + ETMPDCR);
>         etmpdcr |= ETMPDCR_PWD_UP;
> -       writel_relaxed(etmpdcr, drvdata->base + ETMPDCR);
> +       writel_relaxed(etmpdcr, drvdata->csa.base + ETMPDCR);
>         /* Ensure pwrup completes before subsequent cp14 accesses */
>         mb();
>         isb();
> @@ -101,9 +101,9 @@ static void etm_clr_pwrup(struct etm_drvdata *drvdata)
>         /* Ensure pending cp14 accesses complete before clearing pwrup */
>         mb();
>         isb();
> -       etmpdcr = readl_relaxed(drvdata->base + ETMPDCR);
> +       etmpdcr = readl_relaxed(drvdata->csa.base + ETMPDCR);
>         etmpdcr &= ~ETMPDCR_PWD_UP;
> -       writel_relaxed(etmpdcr, drvdata->base + ETMPDCR);
> +       writel_relaxed(etmpdcr, drvdata->csa.base + ETMPDCR);
>  }
>
>  /**
> @@ -365,7 +365,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>         struct etm_config *config = &drvdata->config;
>         struct coresight_device *csdev = drvdata->csdev;
>
> -       CS_UNLOCK(drvdata->base);
> +       CS_UNLOCK(drvdata->csa.base);
>
>         rc = coresight_claim_device_unlocked(csdev);
>         if (rc)
> @@ -427,7 +427,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>         etm_clr_prog(drvdata);
>
>  done:
> -       CS_LOCK(drvdata->base);
> +       CS_LOCK(drvdata->csa.base);
>
>         dev_dbg(&drvdata->csdev->dev, "cpu: %d enable smp call done: %d\n",
>                 drvdata->cpu, rc);
> @@ -589,7 +589,7 @@ static void etm_disable_hw(void *info)
>         struct etm_config *config = &drvdata->config;
>         struct coresight_device *csdev = drvdata->csdev;
>
> -       CS_UNLOCK(drvdata->base);
> +       CS_UNLOCK(drvdata->csa.base);
>         etm_set_prog(drvdata);
>
>         /* Read back sequencer and counters for post trace analysis */
> @@ -601,7 +601,7 @@ static void etm_disable_hw(void *info)
>         etm_set_pwrdwn(drvdata);
>         coresight_disclaim_device_unlocked(&csdev->access);
>
> -       CS_LOCK(drvdata->base);
> +       CS_LOCK(drvdata->csa.base);
>
>         dev_dbg(&drvdata->csdev->dev,
>                 "cpu: %d disable smp call done\n", drvdata->cpu);
> @@ -614,7 +614,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
>         if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
>                 return;
>
> -       CS_UNLOCK(drvdata->base);
> +       CS_UNLOCK(drvdata->csa.base);
>
>         /* Setting the prog bit disables tracing immediately */
>         etm_set_prog(drvdata);
> @@ -626,7 +626,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
>         etm_set_pwrdwn(drvdata);
>         coresight_disclaim_device_unlocked(&csdev->access);
>
> -       CS_LOCK(drvdata->base);
> +       CS_LOCK(drvdata->csa.base);
>
>         /*
>          * perf will release trace ids when _free_aux()
> @@ -772,7 +772,7 @@ static void etm_init_arch_data(void *info)
>         /* Make sure all registers are accessible */
>         etm_os_unlock(drvdata);
>
> -       CS_UNLOCK(drvdata->base);
> +       CS_UNLOCK(drvdata->csa.base);
>
>         /* First dummy read */
>         (void)etm_readl(drvdata, ETMPDSR);
> @@ -803,9 +803,10 @@ static void etm_init_arch_data(void *info)
>         drvdata->nr_ext_out = BMVAL(etmccr, 20, 22);
>         drvdata->nr_ctxid_cmp = BMVAL(etmccr, 24, 25);
>
> +       coresight_reset_claim_unlocked(&drvdata->csa);
>         etm_set_pwrdwn(drvdata);
>         etm_clr_pwrup(drvdata);
> -       CS_LOCK(drvdata->base);
> +       CS_LOCK(drvdata->csa.base);
>  }
>
>  static int __init etm_hp_setup(void)
> @@ -866,8 +867,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>
> -       drvdata->base = base;
> -       desc.access = CSDEV_ACCESS_IOMEM(base);
> +       desc.access = drvdata->csa = CSDEV_ACCESS_IOMEM(base);
>
>         spin_lock_init(&drvdata->spinlock);
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index 68c644be9813..af566b62785c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -50,11 +50,11 @@ static ssize_t etmsr_show(struct device *dev,
>
>         pm_runtime_get_sync(dev->parent);
>         spin_lock_irqsave(&drvdata->spinlock, flags);
> -       CS_UNLOCK(drvdata->base);
> +       CS_UNLOCK(drvdata->csa.base);
>
>         val = etm_readl(drvdata, ETMSR);
>
> -       CS_LOCK(drvdata->base);
> +       CS_LOCK(drvdata->csa.base);
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>         pm_runtime_put(dev->parent);
>
> @@ -949,9 +949,9 @@ static ssize_t seq_curr_state_show(struct device *dev,
>         pm_runtime_get_sync(dev->parent);
>         spin_lock_irqsave(&drvdata->spinlock, flags);
>
> -       CS_UNLOCK(drvdata->base);
> +       CS_UNLOCK(drvdata->csa.base);
>         val = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
> -       CS_LOCK(drvdata->base);
> +       CS_LOCK(drvdata->csa.base);
>
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>         pm_runtime_put(dev->parent);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 45b30a4b3eba..3609bb74c4ec 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1337,6 +1337,8 @@ static void etm4_init_arch_data(void *info)
>         drvdata->nrseqstate = FIELD_GET(TRCIDR5_NUMSEQSTATE_MASK, etmidr5);
>         /* NUMCNTR, bits[30:28] number of counters available for tracing */
>         drvdata->nr_cntr = FIELD_GET(TRCIDR5_NUMCNTR_MASK, etmidr5);
> +
> +       coresight_reset_claim_unlocked(csa);
>         etm4_cs_lock(drvdata, csa);
>         cpu_detect_trace_filtering(drvdata);
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index e986922d555b..be2a47636ef3 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -255,6 +255,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
>                 drvdata->base = base;
>                 desc.groups = coresight_funnel_groups;
>                 desc.access = CSDEV_ACCESS_IOMEM(base);
> +               coresight_reset_claim(&desc.access);
>         }
>
>         dev_set_drvdata(dev, drvdata);
> @@ -272,6 +273,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
>         desc.ops = &funnel_cs_ops;
>         desc.pdata = pdata;
>         desc.dev = dev;
> +
>         drvdata->csdev = coresight_register(&desc);
>         if (IS_ERR(drvdata->csdev)) {
>                 ret = PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 5d42a9a8c460..679a36effbe8 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -284,6 +284,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
>         desc.pdata = dev->platform_data;
>         desc.dev = dev;
>
> +       coresight_reset_claim(&desc.access);
>         drvdata->csdev = coresight_register(&desc);
>         if (IS_ERR(drvdata->csdev)) {
>                 ret = PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index e9876252a789..5ac4e3c706ac 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -558,6 +558,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>         dev->platform_data = pdata;
>         desc.pdata = pdata;
>
> +       coresight_reset_claim(&desc.access);
>         drvdata->csdev = coresight_register(&desc);
>         if (IS_ERR(drvdata->csdev)) {
>                 ret = PTR_ERR(drvdata->csdev);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 937931d107e0..11808aee9d1d 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -655,6 +655,9 @@ extern int coresight_claim_device_unlocked(struct coresight_device *csdev);
>
>  extern void coresight_disclaim_device(struct csdev_access *csa);
>  extern void coresight_disclaim_device_unlocked(struct csdev_access *csa);
> +int coresight_reset_claim_unlocked(struct csdev_access *csa);
> +int coresight_reset_claim(struct csdev_access *csa);
> +
>  extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
>                                          struct device *dev);
>
> --
> 2.34.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

