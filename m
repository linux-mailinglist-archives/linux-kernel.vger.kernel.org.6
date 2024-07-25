Return-Path: <linux-kernel+bounces-262350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB13893C4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C55B1F224D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E6B13DDB8;
	Thu, 25 Jul 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWRYRc2h"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C8199E9F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918582; cv=none; b=Jmuh6WOqdAyDDdQBz1zHwo3+jk3/S0BIDu/PvLFCWyOmL3hgZofDle069C6OEqY0PGCCFf1lczZT1kclpOgmGEeh/Mf7MUhqpEPv2kxB5xHAmQPzR2Bse5vc1fcwukYDrqyHJas4c0/TN98qrmvc9rHQXFT4c0Lu5OFcs4p8uXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918582; c=relaxed/simple;
	bh=faanBAO+qhoC8QoSrA86V5OnWBa2oiFKYr6w+xQD6eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBi+WLHj/Az/cSKFx3dx2DQIHPNqKgVduWEPfsvUrCcepg8V6EMcc1QKhK9wnl9mSuP73edoz0XEEa0gxHDCtHgY5NnP9/RRAvH1z8wJ5yDhY+9lF0Xxh11S/gdFc+5m1mEIF9m+SQ8nELb3zTL+A0oUG6SatcOmqCraaJ+yO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MWRYRc2h; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f00ad303aso404114e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721918579; x=1722523379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCjulFw/55gEE5G6IF7i12l/P7yLcG58r3gVGqhyEsA=;
        b=MWRYRc2h8HpEwjoFqogczh9KME4veqvs0kkeZuVuZW6IEqHQ3XpV0nUHny41Bc43cK
         fpxuigNPv39A7wwn0adFyDoVWCHXk7uLvVvQVwfDhtbCUcEmU0Rf6D5VXniHWlThhKUC
         2E9EKTzrI9k8/mNU9qpR0rW3yzMTkJaDztKRWcMCOFbqqB4lC5/SCa0jMgU2t1uvtQ2u
         cXtUzSfa+TAxJyAyQvQY70kwhw0Addk49BDWH8vQxT4JRhjtY6iNBUmkXhMvL8C8uUkV
         Ryk5btbgQFiXXRJxwl1auu833/MKd4xKkEJdMLQR+T7gynohBxoGCFNHYMEyNnQCc9Kw
         ix7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721918579; x=1722523379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCjulFw/55gEE5G6IF7i12l/P7yLcG58r3gVGqhyEsA=;
        b=ihtFy1bpHDEN1awTDmBcnwockzdG/95I4i9DKysqbW9F7Gy4Mz/kvgAC6yKqaej/tv
         fZ7rX9PLDJvoq8gdp9OErjEFSEeG8kH5xYmoRzqJl5arQQiInfkvdvm/zgLhohA+fk6+
         uc2ntM62nXDMfgQTnheUwH81o2/BriWDJ9dM3S8Hu5TxGbPj9IMFTR/DD69IkJ3Bn+7K
         H0YlkoDc887925meRJhmclzvdCU+YVDB8hT/v4liOZc3xnGA71wj/Z5Pmg2PS8bhJFM7
         mhqulzJH/ihvyNNxp0uG2O1rNrhwr0gZbA6NHtdOZieuOUX29VIXdwsE6sBvw2XxxfuV
         uhVA==
X-Forwarded-Encrypted: i=1; AJvYcCVho5MVx81A63rYkg0aZwDAI7/P2v0wD2Dc6piCZ9vTxZpmiuKx/dsD2Jv+3qGNfF9B3Yod+75bhx8e9AJJo3gUROK7d+am+ENub2Jg
X-Gm-Message-State: AOJu0YyedUXFkasG11YQcK8pnSyXEalCyybXjXpkizfy6aD0OTEN1rVK
	aPIWyTPYajVVCn1yGoaMPNf29BR+gbOe/ScPuLyLTuKo26hDmDvPBK7UG0mGWf3OR9UZny7nKA0
	/0QprKlTrl4GUt8tZb5RdG4ZKHf958Kq7xPi84g==
X-Google-Smtp-Source: AGHT+IFDJXTKfmXELr0EOd8N03rRQIn6DB4stRnrhohX82CVZr8DPXPGuyN6rhDMgcXYaTQsS+zgvProDk8qxGR4jxs=
X-Received: by 2002:a05:6512:b8b:b0:52c:a5cb:69e4 with SMTP id
 2adb3069b0e04-52fd3f9a228mr2703794e87.54.1721918578496; Thu, 25 Jul 2024
 07:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716013953.1715134-1-tanmay.shah@amd.com> <Zp6LNyyuzskj+UBH@p14s>
 <db26a6c4-0529-4ff7-91fb-a4501b23185f@amd.com>
In-Reply-To: <db26a6c4-0529-4ff7-91fb-a4501b23185f@amd.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 25 Jul 2024 08:42:47 -0600
Message-ID: <CANLsYkwN=OVtb17M5+DiqT8ANgp=PW-AXvT2RvxXx=VcdjL=+g@mail.gmail.com>
Subject: Re: [PATCH v2] remoteproc: xlnx: add sram support
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 16:04, Tanmay Shah <tanmay.shah@amd.com> wrote:
>
> Hello Mathieu,
>
> Thanks for reviews.
>
> All the comments looks good, I will send next revision addressing them all.
>
> On 7/22/24 11:39 AM, Mathieu Poirier wrote:
> > Good morning,
> >
> > On Mon, Jul 15, 2024 at 06:39:54PM -0700, Tanmay Shah wrote:
> >> AMD-Xilinx zynqmp platform contains on-chip sram memory (OCM).
> >> R5 cores can access OCM and access is faster than DDR memory but slower
> >> than TCM memories available. Sram region can have optional multiple
> >> power-domains. Platform management firmware is responsible
> >> to operate these power-domains.
> >>
> >> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> >> ---
> >>
> >> Changes in v2:
> >>   - Expand commit message with power-domains related information.
> >>
> >>  drivers/remoteproc/xlnx_r5_remoteproc.c | 131 ++++++++++++++++++++++++
> >>  1 file changed, 131 insertions(+)
> >>
> >> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> >> index 596f3ffb8935..52ddd42b09e0 100644
> >> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> >> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> >> @@ -56,6 +56,17 @@ struct mem_bank_data {
> >>      char *bank_name;
> >>  };
> >>
> >> +/**
> >> + * struct zynqmp_sram_bank - sram bank description
> >> + *
> >> + * @sram_res: sram address region information
> >> + * @da: device address of sram
> >> + */
> >> +struct zynqmp_sram_bank {
> >> +    struct resource sram_res;
> >> +    u32 da;
> >> +};
> >> +
> >>  /**
> >>   * struct mbox_info
> >>   *
> >> @@ -120,6 +131,8 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> >>   * struct zynqmp_r5_core
> >>   *
> >>   * @rsc_tbl_va: resource table virtual address
> >> + * @sram: Array of sram memories assigned to this core
> >> + * @num_sram: number of sram for this core
> >>   * @dev: device of RPU instance
> >>   * @np: device node of RPU instance
> >>   * @tcm_bank_count: number TCM banks accessible to this RPU
> >> @@ -131,6 +144,8 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> >>   */
> >>  struct zynqmp_r5_core {
> >>      void __iomem *rsc_tbl_va;
> >> +    struct zynqmp_sram_bank **sram;
> >
> > I suggest making @sram an array rather than an array of pointers - it would
> > simplify function zynqmp_r5_get_sram_banks().
> >
>
> Ack.
>
> >> +    int num_sram;
> >>      struct device *dev;
> >>      struct device_node *np;
> >>      int tcm_bank_count;
> >> @@ -494,6 +509,40 @@ static int add_mem_regions_carveout(struct rproc *rproc)
> >>      return 0;
> >>  }
> >>
> >> +static int add_sram_carveouts(struct rproc *rproc)
> >> +{
> >> +    struct zynqmp_r5_core *r5_core = rproc->priv;
> >> +    struct rproc_mem_entry *rproc_mem;
> >> +    struct zynqmp_sram_bank *sram;
> >> +    dma_addr_t dma_addr;
> >> +    size_t len;
> >> +    int da, i;
> >> +
> >> +    for (i = 0; i < r5_core->num_sram; i++) {
> >> +            sram = r5_core->sram[i];
> >> +
> >> +            dma_addr = (dma_addr_t)sram->sram_res.start;
> >> +            len = resource_size(&sram->sram_res);
> >> +            da = sram->da;
> >> +
> >> +            /* Register associated reserved memory regions */
> >> +            rproc_mem = rproc_mem_entry_init(&rproc->dev, NULL,
> >> +                                             (dma_addr_t)dma_addr,
> >> +                                             len, da,
> >> +                                             zynqmp_r5_mem_region_map,
> >> +                                             zynqmp_r5_mem_region_unmap,
> >> +                                             sram->sram_res.name);
> >> +
> >> +            rproc_add_carveout(rproc, rproc_mem);
> >> +            rproc_coredump_add_segment(rproc, da, len);
> >> +
> >> +            dev_dbg(&rproc->dev, "sram carveout %s addr=%llx, da=0x%x, size=0x%lx",
> >> +                    sram->sram_res.name, dma_addr, da, len);
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>  /*
> >>   * tcm_mem_unmap()
> >>   * @rproc: single R5 core's corresponding rproc instance
> >> @@ -669,6 +718,12 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> >>              return ret;
> >>      }
> >>
> >> +    ret = add_sram_carveouts(rproc);
> >> +    if (ret) {
> >> +            dev_err(&rproc->dev, "failed to get sram carveout %d\n", ret);
> >> +            return ret;
> >> +    }
> >> +
> >>      return 0;
> >>  }
> >>
> >> @@ -881,6 +936,78 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> >>      return ERR_PTR(ret);
> >>  }
> >>
> >> +static int zynqmp_r5_get_sram_banks(struct zynqmp_r5_core *r5_core)
> >> +{
> >> +    struct zynqmp_sram_bank **sram, *sram_data;
> >> +    struct device_node *np = r5_core->np;
> >> +    struct device *dev = r5_core->dev;
> >> +    struct device_node *sram_np;
> >> +    int num_sram, i, ret;
> >> +    u64 abs_addr, size;
> >> +
> >> +    /* "sram" is optional proprty. Do not fail, if unavailable. */
> >
> > s/proprty/property
>
> Ack.
>
> >
> >> +    if (!of_find_property(r5_core->np, "sram", NULL))
> >> +            return 0;
> >> +
> >> +    num_sram = of_property_count_elems_of_size(np, "sram", sizeof(phandle));
> >> +    if (num_sram <= 0) {
> >
> > Any reason this is "<" rather than "<=" ?
>
> I will make it < 1.
>

I had another read at the documentation of function
of_property_count_elems_of_size() - what you had will work just fine.
You can disregard this comment.

> >
> >> +            dev_err(dev, "Invalid sram property, ret = %d\n",
> >> +                    num_sram);
> >> +            return -EINVAL;
> >> +    }
> >> +
> >> +    sram = devm_kcalloc(dev, num_sram,
> >> +                        sizeof(struct zynqmp_sram_bank *), GFP_KERNEL);
> >> +    if (!sram)
> >> +            return -ENOMEM;
> >> +
> >> +    for (i = 0; i < num_sram; i++) {
> >> +            sram_data = devm_kzalloc(dev, sizeof(struct zynqmp_sram_bank),
> >> +                                     GFP_KERNEL);
> >> +            if (!sram_data)
> >> +                    return -ENOMEM;
> >> +
> >> +            sram_np = of_parse_phandle(np, "sram", i);
> >> +            if (!sram_np) {
> >> +                    dev_err(dev, "failed to get sram %d phandle\n", i);
> >> +                    return -EINVAL;
> >> +            }
> >> +
> >> +            if (!of_device_is_available(sram_np)) {
> >> +                    of_node_put(sram_np);
> >> +                    dev_err(dev, "sram device not available\n");
> >> +                    return -EINVAL;
> >> +            }
> >> +
> >> +            ret = of_address_to_resource(sram_np, 0, &sram_data->sram_res);
> >> +            of_node_put(sram_np);
> >
> > Why calling this here when sram_np is used below?
> >
>
> Ack.
> I wanted to keep of_node_put as close as of_node_get.
> But, I think within same function I can move of_node_put after all use of sram_np.
>
> I didn't face any runtime errors though, so I am wondering is it required ?

It is required to keep a proper reference count of the node.

>
> I will move it anyway as suggested.
>
> >> +            if (ret) {
> >> +                    dev_err(dev, "addr to res failed\n");
> >> +                    return ret;
> >> +            }
> >> +
> >> +            /* Get SRAM device address */
> >> +            ret = of_property_read_reg(sram_np, i, &abs_addr, &size);
> >> +            if (ret) {
> >> +                    dev_err(dev, "failed to get reg property\n");
> >> +                    return ret;
> >> +            }
> >> +
> >> +            sram_data->da = (u32)abs_addr;
> >> +
> >> +            sram[i] = sram_data;
> >> +
> >> +            dev_dbg(dev, "sram %d: name=%s, addr=0x%llx, da=0x%x, size=0x%llx\n",
> >> +                    i, sram[i]->sram_res.name, sram[i]->sram_res.start,
> >> +                    sram[i]->da, resource_size(&sram[i]->sram_res));
> >> +    }
> >> +
> >> +    r5_core->sram = sram;
> >> +    r5_core->num_sram = num_sram;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>  static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> >>  {
> >>      int i, j, tcm_bank_count, ret, tcm_pd_idx, pd_count;
> >> @@ -1095,6 +1222,10 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> >>                              return ret;
> >>                      }
> >>              }
> >> +
> >> +            ret = zynqmp_r5_get_sram_banks(r5_core);
> >> +            if (ret)
> >> +                    return ret;
> >>      }
> >
> > Thanks,
> > Mathieu
> >
> >>
> >>      return 0;
> >>
> >> base-commit: d87dbfd31796f810ed777aee4919f211b4a6c7fb
> >> --
> >> 2.25.1
> >>
>

