Return-Path: <linux-kernel+bounces-575615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2E6A704CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A18F97A258B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B531725C704;
	Tue, 25 Mar 2025 15:18:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6021F4E4B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915891; cv=none; b=XBSM/cMQoXYO92GF92QmhZ/sxKH/llEtItg9QeJi+rQeA7FU4i9WA8WRJ/uZR+RH5KxtyeiddRScR4v/4TwkpU2ToCfjCMMkGvx6iYD9o7pkpdTFOZnXKfuNC4wzZtulVEv9et7XaAu7nqiN+5vX3miLFlJf9EHAEsAXmmYq5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915891; c=relaxed/simple;
	bh=zkoP0hulZMAR7wBmbrzGy8q5F/HEyYjX8+IcYsgCaxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMNFo7v60rw42GMwerL3F8LWrGRzx3snpobraA1vtmIeyxpCG/pJtFzEHDdmqqD4tTA2x2KjiU9X+NORZyhbJrbn1PpXeA2AVjyD1CQmUv2mZpFlaxqZKUJpDpNDTf0SvbBw2lOhB0SM0HrPBEv1LzuR4IjMaPtEYtckkaYL0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 221C81756;
	Tue, 25 Mar 2025 08:18:14 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C720B3F58B;
	Tue, 25 Mar 2025 08:18:07 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:18:03 +0000
From: Leo Yan <leo.yan@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: suzuki.poulose@arm.com, mike.leach@linaro.org, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] coresight: prevent deactivate active config while
 enabling the config
Message-ID: <20250325151803.GD604566@e132581.arm.com>
References: <20250324191740.64964-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324191740.64964-1-yeoreum.yun@arm.com>

Hi Levi,

On Mon, Mar 24, 2025 at 07:17:40PM +0000, Yeoreum Yun wrote:
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

I am not sure if this flow can happen.  CoreSight configfs feature is
integrated into the CoreSight core layer, and the other CoreSight
modules are dependent on it.

For example, if the ETM4x module is not removed, the kernel module
management will natually prevent the CoreSight core module from being
removed.

> To address this, use cscfg_config_desc's active_cnt as a reference count
> which will be holded when
>     - activate the config.
>     - enable the activated config.
> and put the module reference when config_active_cnt == 0.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
> Since v3:
>   - Remove enable arguments in cscfg_config_desc_get() (from Mike).
>   - https://lore.kernel.org/all/20250109171956.3535294-1-yeoreum.yun@arm.com/
> ---
>  .../hwtracing/coresight/coresight-config.h    |  2 +-
>  .../coresight/coresight-etm4x-core.c          |  3 ++
>  .../hwtracing/coresight/coresight-syscfg.c    | 52 +++++++++++++------
>  3 files changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index b9ebc9fcfb7f..90fd937d3bd8 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -228,7 +228,7 @@ struct cscfg_feature_csdev {
>   * @feats_csdev:references to the device features to enable.
>   */
>  struct cscfg_config_csdev {
> -	const struct cscfg_config_desc *config_desc;
> +	struct cscfg_config_desc *config_desc;
>  	struct coresight_device *csdev;
>  	bool enabled;
>  	struct list_head node;
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index e5972f16abff..ef96028fa56b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1020,6 +1020,9 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
>  	smp_call_function_single(drvdata->cpu, etm4_disable_hw, drvdata, 1);
> 
>  	raw_spin_unlock(&drvdata->spinlock);
> +
> +	cscfg_csdev_disable_active_config(csdev);
> +

In general, we need to split changes into several patches if each
addresses a different issue.  From my understanding, the change above is
to fix missing to disable config when disable Sysfs mode.

If so, could we use a seperate patch for this change?

>  	cpus_read_unlock();
> 
>  	/*
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index a70c1454b410..6d8c212ad434 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -391,14 +391,17 @@ static void cscfg_owner_put(struct cscfg_load_owner_info *owner_info)
>  static void cscfg_remove_owned_csdev_configs(struct coresight_device *csdev, void *load_owner)
>  {
>  	struct cscfg_config_csdev *config_csdev, *tmp;
> +	unsigned long flags;
> 
>  	if (list_empty(&csdev->config_csdev_list))
>  		return;
> 
> +	raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);

I think we should use spinlock to guard the condition checking
list_empty().

Here the race condition is the 'config_csdev_list' list and
configurations on the list.  For atomicity, we should use lock to
protect any operations on the list (read, add, delete, etc).

A side topic, as here it adds locks for protecting 'config_csdev_list',
I am wandering why we do not do the same thing for
'feature_csdev_list' (See cscfg_remove_owned_csdev_features() and
cscfg_get_feat_csdev()).

>  	list_for_each_entry_safe(config_csdev, tmp, &csdev->config_csdev_list, node) {
>  		if (config_csdev->config_desc->load_owner == load_owner)
>  			list_del(&config_csdev->node);
>  	}
> +	raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
>  }
> 
>  static void cscfg_remove_owned_csdev_features(struct coresight_device *csdev, void *load_owner)
> @@ -867,6 +870,25 @@ void cscfg_csdev_reset_feats(struct coresight_device *csdev)
>  }
>  EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
> 
> +static bool cscfg_config_desc_get(struct cscfg_config_desc *config_desc)
> +{
> +	if (!atomic_fetch_inc(&config_desc->active_cnt)) {
> +		/* must ensure that config cannot be unloaded in use */
> +		if (unlikely(cscfg_owner_get(config_desc->load_owner))) {
> +			atomic_dec(&config_desc->active_cnt);
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static void cscfg_config_desc_put(struct cscfg_config_desc *config_desc)
> +{
> +	if (!atomic_dec_return(&config_desc->active_cnt))
> +		cscfg_owner_put(config_desc->load_owner);
> +}
> +
>  /*
>   * This activate configuration for either perf or sysfs. Perf can have multiple
>   * active configs, selected per event, sysfs is limited to one.
> @@ -890,22 +912,17 @@ static int _cscfg_activate_config(unsigned long cfg_hash)
>  			if (config_desc->available == false)
>  				return -EBUSY;
> 
> -			/* must ensure that config cannot be unloaded in use */
> -			err = cscfg_owner_get(config_desc->load_owner);
> -			if (err)
> +			if (!cscfg_config_desc_get(config_desc)) {
> +				err = -EINVAL;
>  				break;
> +			}
> +
>  			/*
>  			 * increment the global active count - control changes to
>  			 * active configurations
>  			 */
>  			atomic_inc(&cscfg_mgr->sys_active_cnt);

Seems to me, it is more reasonable to use 'sys_active_cnt' to acquire
the module reference instead of 'config_desc->active_cnt'.  The reason
is 'sys_active_cnt' is a global counter.

> -			/*
> -			 * mark the descriptor as active so enable config on a
> -			 * device instance will use it
> -			 */
> -			atomic_inc(&config_desc->active_cnt);
> -
>  			err = 0;
>  			dev_dbg(cscfg_device(), "Activate config %s.\n", config_desc->name);
>  			break;
> @@ -920,9 +937,8 @@ static void _cscfg_deactivate_config(unsigned long cfg_hash)
> 
>  	list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
>  		if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
> -			atomic_dec(&config_desc->active_cnt);
>  			atomic_dec(&cscfg_mgr->sys_active_cnt);
> -			cscfg_owner_put(config_desc->load_owner);
> +			cscfg_config_desc_put(config_desc);
>  			dev_dbg(cscfg_device(), "Deactivate config %s.\n", config_desc->name);
>  			break;
>  		}
> @@ -1047,7 +1063,7 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
>  				     unsigned long cfg_hash, int preset)
>  {
>  	struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
> -	const struct cscfg_config_desc *config_desc;
> +	struct cscfg_config_desc *config_desc;
>  	unsigned long flags;
>  	int err = 0;
> 
> @@ -1062,8 +1078,8 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
>  	raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
>  	list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
>  		config_desc = config_csdev_item->config_desc;
> -		if ((atomic_read(&config_desc->active_cnt)) &&
> -		    ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
> +		if (((unsigned long)config_desc->event_ea->var == cfg_hash) &&
> +				cscfg_config_desc_get(config_desc)) {

This seems to me not right.  Why a config descriptor is get in multiple
places?  One time getting a config descriptor is in
_cscfg_activate_config(), another is at here.

To be honest, I am not clear what is the difference between 'activate'
config and 'enable active' config.  Literally, I think we only need to
acquire the config at its creating phase (maybe match to activate
config?).

>  			config_csdev_active = config_csdev_item;
>  			csdev->active_cscfg_ctxt = (void *)config_csdev_active;
>  			break;
> @@ -1097,7 +1113,11 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
>  				err = -EBUSY;
>  			raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
>  		}
> +
> +		if (err)
> +			cscfg_config_desc_put(config_desc);
>  	}
> +
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
> @@ -1136,8 +1156,10 @@ void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
>  	raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> 
>  	/* true if there was an enabled active config */
> -	if (config_csdev)
> +	if (config_csdev) {
>  		cscfg_csdev_disable_config(config_csdev);
> +		cscfg_config_desc_put(config_csdev->config_desc);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
> 
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

