Return-Path: <linux-kernel+bounces-561616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24097A61411
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B57E3B6DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2357200B85;
	Fri, 14 Mar 2025 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="okpb09VS"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC031990BA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963815; cv=none; b=Hvn5l0KdCyGV+NMuTBVZYZqaXVLKp3h9bPOm/FgalKIIsxT0oJvOos/GUxqPzouNUceKAgBWGO6HsGkYzU71uyXI3c4A6ZxuVR18jGNk5DuaKk/gmvuJcB5a6oRn8F5kap/LfQ67WsWogDTLBzZNrY9y5TQ1eVv3jk0/qQw3fOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963815; c=relaxed/simple;
	bh=1b6fOYKrDOeEBjKm5OS1L1JxubIGbOF7ajN0PGPcDGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJt+lPbHdpPZBZ8TTAPgwneLFswFejO/MOHqK69uTxISYLXhNZXBH89DPnyFxc94FYUj+Q1XcONuL5VR0joX8mgsKjE/DFMpKEL1mUx71UYVpP7Oz6yNs0FIEt7OlZfsRonv0K+4Mw+nNy0zfFmKo3ZaQ8njO4jMlFu3VoRl8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=okpb09VS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240b4de12bso59712285ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741963812; x=1742568612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EdlZPQacY7WF2SEKB06YPKehd8J9E8+LtVa0C/rc4Zw=;
        b=okpb09VSEIeQNmNklluykqnIjoslhpfmHH1n0GbOdzAgByAXoKjRi0xAKA1VUtuoCo
         1PsEsAqdhsU3N6KGJGdRCSarZikX+KpERk3/MSvUHf2XfqIFQImEOXpKg0ykWSH/ytey
         ylJGSlgDEKXXR2ctfFEU+j0enqBtFKvO6j1/QURkPR1zAXMvA17YIJeOtwb2kaYW2F2I
         RbyQuPD6YUqbQQMAJ/qrsSrXcfSWqL8XWNs6qodxax54PiTojuwE68HJfGO1yLR22lHO
         kjP/gDQHUCOnz6KvKe+m7RqddPvcHXO5D2yBfQQmM2MZhXsgzASww/PofVHlKc/S2Xmq
         xnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963812; x=1742568612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdlZPQacY7WF2SEKB06YPKehd8J9E8+LtVa0C/rc4Zw=;
        b=wAxhmkxFVPv2KWCVNoygsZrO7oo17K6QjiSlCHImMb5M2uFmqXdLHCRY6xKgFbjE1k
         rzbuYT4glgqS4ZDuIZidjGnrH0di9z2suqsXAxMDgddU/E5sUfXVG3EW9uCO29wv9h5S
         mV3tL3U4VMEinm2xFYRN+iEUgv4vw3vcWZMi4ujyFcPDcuQaC3SN1T/kACZ/0f2xihO7
         5AAdjvOUvMqWDdEnSIg9IWX9imMGcgsNyLSwFBPy/L4zJqYMjxc4SObZxHRsVEMbEO5E
         nxQp2vNgBf+fOoEQUSs0bojJvZq+TbaK0OjTnSaRtSGR6J2fE0FD9fa0RRidTyQId65q
         sOcA==
X-Forwarded-Encrypted: i=1; AJvYcCUOt6+D+HJyARUYiTfk8rWLgGC6bD5oL2qjl3jEP9vP17XntAbO/VM1/Mgwb7ETT2gBT/C51BIdIRw+1P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQzrNKwNT+kb2jlHth8I7J4NIgprXpoZoBbFc5PE1RfJz2qtaz
	9eBdLOytgjgLTV7zcFXhybc7lfG2l0pMuu2uFrPTZzKILutDSvCgs9/rjRSxYSvOT5xj4hg7Sjr
	Ls55vYXKwjjTJlFLi1tbfARZgTXaiO4I5xAs47Q==
X-Gm-Gg: ASbGnctdY13ntuJ0OMdI98Wk/BHw+qIkXUsfyrLvNgLuCPjsBox0Yj+udJcW+zH4xaj
	M5ECH+YEC1t+lfg3cYsm0GDmOwI8gXLYv74h9dLCR5eLMB0Z+PTuAmxm8ot3fRTHGzXNwY6yMPO
	EU2irfbV5e4wS216lWt0wskTTI1lE=
X-Google-Smtp-Source: AGHT+IHfNAUp36XMnCX/SK1JaWPhnvmshNR+2Vk1C9duS1GWTRT77F98TfUOhGL5wJRSLUOHOb+RdxqUV9fFS+99g+c=
X-Received: by 2002:a17:902:ef51:b0:220:c143:90a0 with SMTP id
 d9443c01a7336-225e0aaf01dmr49754705ad.24.1741963812527; Fri, 14 Mar 2025
 07:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109171956.3535294-1-yeoreum.yun@arm.com>
In-Reply-To: <20250109171956.3535294-1-yeoreum.yun@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 14 Mar 2025 14:50:00 +0000
X-Gm-Features: AQ5f1JoxOsWKyJm3DNqvZjWuUp7uRpfo7Q2U9LCVyTj9tsYddKfxgU51SLSJ53Q
Message-ID: <CAJ9a7ViuVntYL62q=WYPkFR3++cyufPdKUHm0FUAPyGy76pB_A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] coresight: prevent deactivate active config while
 enabling the config
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: suzuki.poulose@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 9 Jan 2025 at 17:20, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>
> While enable active config via cscfg_csdev_enable_active_config(),
> active config could be deactivated via configfs' sysfs interface.
> This could make UAF issue in below scenario:
>
> CPU0                                          CPU1
> (sysfs enable)                                load module
>                                               cscfg_load_config_sets()
>                                               activate config. // sysfs
>                                               (sys_active_cnt == 1)
> ...
> cscfg_csdev_enable_active_config()
>   lock(csdev->cscfg_csdev_lock)
>   // here load config activate by CPU1
>   unlock(csdev->cscfg_csdev_lock)
>
>                                               deactivate config // sysfs
>                                               (sys_activec_cnt == 0)
>                                               cscfg_unload_config_sets()
>                                               unload module
>
>   // access to config_desc which freed
>   // while unloading module.
>   cfs_csdev_enable_config
>
> To address this, use cscfg_config_desc's active_cnt as a reference count
> which will be holded when
>     - activate the config.
>     - enable the activated config.
> and put the module reference when config_active_cnt == 0.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
> from v2 to v3:
>     - add cscfg_config_desc_get()/put() (from Suzuki).
>     - remove sys_enable_cnt.
>
> from v1 to v2:
>     - modify commit message.
> ---
>  .../hwtracing/coresight/coresight-config.h    |  2 +-
>  .../coresight/coresight-etm4x-core.c          |  3 +
>  .../hwtracing/coresight/coresight-syscfg.c    | 55 ++++++++++++++-----
>  3 files changed, 44 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index b9ebc9fcfb7f..90fd937d3bd8 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -228,7 +228,7 @@ struct cscfg_feature_csdev {
>   * @feats_csdev:references to the device features to enable.
>   */
>  struct cscfg_config_csdev {
> -       const struct cscfg_config_desc *config_desc;
> +       struct cscfg_config_desc *config_desc;
>         struct coresight_device *csdev;
>         bool enabled;
>         struct list_head node;
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 86893115df17..6218ef40acbc 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -986,6 +986,9 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
>         smp_call_function_single(drvdata->cpu, etm4_disable_hw, drvdata, 1);
>
>         raw_spin_unlock(&drvdata->spinlock);
> +
> +       cscfg_csdev_disable_active_config(csdev);
> +
>         cpus_read_unlock();
>
>         /*
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index a70c1454b410..8766f72db33e 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -391,14 +391,17 @@ static void cscfg_owner_put(struct cscfg_load_owner_info *owner_info)
>  static void cscfg_remove_owned_csdev_configs(struct coresight_device *csdev, void *load_owner)
>  {
>         struct cscfg_config_csdev *config_csdev, *tmp;
> +       unsigned long flags;
>
>         if (list_empty(&csdev->config_csdev_list))
>                 return;
>
> +       raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
>         list_for_each_entry_safe(config_csdev, tmp, &csdev->config_csdev_list, node) {
>                 if (config_csdev->config_desc->load_owner == load_owner)
>                         list_del(&config_csdev->node);
>         }
> +       raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
>  }
>
>  static void cscfg_remove_owned_csdev_features(struct coresight_device *csdev, void *load_owner)
> @@ -867,6 +870,28 @@ void cscfg_csdev_reset_feats(struct coresight_device *csdev)
>  }
>  EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
>
> +static bool cscfg_config_desc_get(struct cscfg_config_desc *config_desc, bool enable)
> +{
> +       if (enable)
> +               return atomic_inc_not_zero(&config_desc->active_cnt);
> +

Not sure why we have an "enable" parameter here - it completely
changes the meaning of the function - with no comment at the start.

From where it is called it makes figuring out the logic confusing.

Just keep the "get" functionality and drop the parameter & the nz check.

> +       /* when activate config */
> +
> +       /* must ensure that config cannot be unloaded in use */
> +       if (cscfg_owner_get(config_desc->load_owner))
> +               return false;
> +
> +       atomic_inc(&config_desc->active_cnt);
> +
> +       return true;
> +}
> +
> +static void cscfg_config_desc_put(struct cscfg_config_desc *config_desc)
> +{
> +       if (!atomic_dec_return(&config_desc->active_cnt))
> +               cscfg_owner_put(config_desc->load_owner);
> +}
> +
>  /*
>   * This activate configuration for either perf or sysfs. Perf can have multiple
>   * active configs, selected per event, sysfs is limited to one.
> @@ -890,22 +915,17 @@ static int _cscfg_activate_config(unsigned long cfg_hash)
>                         if (config_desc->available == false)
>                                 return -EBUSY;
>
> -                       /* must ensure that config cannot be unloaded in use */
> -                       err = cscfg_owner_get(config_desc->load_owner);
> -                       if (err)
> +                       if (!cscfg_config_desc_get(config_desc, false)) {

Drop the false parameter here.

> +                               err = -EINVAL;
>                                 break;
> +                       }
> +
>                         /*
>                          * increment the global active count - control changes to
>                          * active configurations
>                          */
>                         atomic_inc(&cscfg_mgr->sys_active_cnt);
>
> -                       /*
> -                        * mark the descriptor as active so enable config on a
> -                        * device instance will use it
> -                        */
> -                       atomic_inc(&config_desc->active_cnt);
> -
>                         err = 0;
>                         dev_dbg(cscfg_device(), "Activate config %s.\n", config_desc->name);
>                         break;
> @@ -920,9 +940,8 @@ static void _cscfg_deactivate_config(unsigned long cfg_hash)
>
>         list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
>                 if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
> -                       atomic_dec(&config_desc->active_cnt);
>                         atomic_dec(&cscfg_mgr->sys_active_cnt);
> -                       cscfg_owner_put(config_desc->load_owner);
> +                       cscfg_config_desc_put(config_desc);
>                         dev_dbg(cscfg_device(), "Deactivate config %s.\n", config_desc->name);
>                         break;
>                 }
> @@ -1047,7 +1066,7 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
>                                      unsigned long cfg_hash, int preset)
>  {
>         struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
> -       const struct cscfg_config_desc *config_desc;
> +       struct cscfg_config_desc *config_desc;
>         unsigned long flags;
>         int err = 0;
>
> @@ -1062,8 +1081,8 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
>         raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
>         list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
>                 config_desc = config_csdev_item->config_desc;
> -               if ((atomic_read(&config_desc->active_cnt)) &&
> -                   ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
> +               if (((unsigned long)config_desc->event_ea->var == cfg_hash) &&
> +                               cscfg_config_desc_get(config_desc, true)) {

This obfuscates the logic of the comparisons without good reason. With
the true parameter, the function does no "get" operation but just
replicates the logic being replaced - checking the active_cnt is
non-zero.

Restore this to the original logic to make it readable again

Regards

Mike

>                         config_csdev_active = config_csdev_item;
>                         csdev->active_cscfg_ctxt = (void *)config_csdev_active;
>                         break;
> @@ -1097,7 +1116,11 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
>                                 err = -EBUSY;
>                         raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
>                 }
> +
> +               if (err)
> +                       cscfg_config_desc_put(config_desc);
>         }
> +
>         return err;
>  }
>  EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
> @@ -1136,8 +1159,10 @@ void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
>         raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
>
>         /* true if there was an enabled active config */
> -       if (config_csdev)
> +       if (config_csdev) {
>                 cscfg_csdev_disable_config(config_csdev);
> +               cscfg_config_desc_put(config_csdev->config_desc);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
>
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

