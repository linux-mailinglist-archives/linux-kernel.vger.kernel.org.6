Return-Path: <linux-kernel+bounces-340550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B8987517
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BF51F26F28
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6B9136352;
	Thu, 26 Sep 2024 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+HDZgNT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703622615;
	Thu, 26 Sep 2024 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359597; cv=none; b=ZWmSraPxb61tSi81/cqhTC1NMptkDtmyFBFCeVP47i6F3y74S2p5MuqmQJNwo7oa0PiZCHdVuVrZ4JS2WYpNOY64BbsW99KQk0jCxVl7X7f3SkyLIdJ/RyJr/y/NY+myBFyjGNaUFADORaIHsKzqJQMHDBaHRPlL6LD2kYp7HUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359597; c=relaxed/simple;
	bh=HIT+KGU2tmrcn0tzKkmmuQN1iMoOd6CrDJmnZSxaNUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuIQSFVYZfrBtyJcy1rnQgnwcvBI72yXaJboVxu4Wbq/oSs6ljUfjdrSyFfmFYoTwNYrlkjjym50HqYzMG/6K79lIPuFf1KBVrxTXBI5eU064wsuO/iq+M/ClcpbaZ57u4GTmjJ5oMad8ajiTfFdwwico+RuFDREXRgnutx370U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+HDZgNT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727359595; x=1758895595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HIT+KGU2tmrcn0tzKkmmuQN1iMoOd6CrDJmnZSxaNUU=;
  b=R+HDZgNTUKL/f7zz4zC9MSTW/U6WiCbkaMjJ7/VA1p5GPgilvA86mFBZ
   azeGrjSXTqEFdvakkFt1U3ytf/Xq/Pr8AhP0JwOdbbB1OBytbok88rzPk
   bJ9j5n1dYKZMmunww9z94Djq9qTDN9zff4zzue7lf8//KObvpsyYvpcoH
   PwrrS2eM0z69UY5Ze4CGdTM5LK9aKkmrTrTlhCNuLBMeW+gOMQ13udj5T
   fm/u2dThqpztl3LK/QF1xvwJuk7sbeH3Hc6ZFOZjl9XJPtAxr0KxeS1/h
   v+9T/CEnbZGTdjR+HRRPGbhbjyFoQbqdpZaERMoOfBGMwI8fcVNJNFROB
   A==;
X-CSE-ConnectionGUID: SM844ZY0QQybUnNpcsKzbw==
X-CSE-MsgGUID: m6Sx9IrKSkuPwMwONuHtzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30163092"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="30163092"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:06:35 -0700
X-CSE-ConnectionGUID: AdL6bjBWQUGcEYejE/hKzQ==
X-CSE-MsgGUID: 37vJmmwUQeW4HyzkCyZZng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="77085116"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa004.jf.intel.com with SMTP; 26 Sep 2024 07:06:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 26 Sep 2024 17:06:30 +0300
Date: Thu, 26 Sep 2024 17:06:30 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: tzungbi@kernel.org, jthies@google.com, pmalani@chromium.org,
	akuchynski@google.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/8] usb: typec: Add driver for Thunderbolt 3 Alternate
 Mode
Message-ID: <ZvVqZuyhEC6bW4vV@kuha.fi.intel.com>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
 <20240925092505.1.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925092505.1.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>

Hi Abhishek,

On Wed, Sep 25, 2024 at 09:25:02AM -0700, Abhishek Pandit-Subedi wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Thunderbolt 3 Alternate Mode entry flow is described in
> USB Type-C Specification Release 2.0.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes:
> * Delay cable + plug checks so that the module doesn't fail to probe
>   if cable + plug information isn't available by the time the partner
>   altmode is registered.
> * Remove unncessary brace after if (IS_ERR(plug))
> 
> The rest of this patch should be the same as Heikki's original RFC.
> 
> 
>  drivers/usb/typec/altmodes/Kconfig       |   9 +
>  drivers/usb/typec/altmodes/Makefile      |   2 +
>  drivers/usb/typec/altmodes/thunderbolt.c | 321 +++++++++++++++++++++++
>  3 files changed, 332 insertions(+)
>  create mode 100644 drivers/usb/typec/altmodes/thunderbolt.c
> 
> diff --git a/drivers/usb/typec/altmodes/Kconfig b/drivers/usb/typec/altmodes/Kconfig
> index 1a6b5e872b0d..7867fa7c405d 100644
> --- a/drivers/usb/typec/altmodes/Kconfig
> +++ b/drivers/usb/typec/altmodes/Kconfig
> @@ -23,4 +23,13 @@ config TYPEC_NVIDIA_ALTMODE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called typec_nvidia.
>  
> +config TYPEC_TBT_ALTMODE
> +	tristate "Thunderbolt3 Alternate Mode driver"
> +	help
> +	  Select this option if you have Thunderbolt3 hardware on your
> +	  system.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called typec_thunderbolt.
> +
>  endmenu
> diff --git a/drivers/usb/typec/altmodes/Makefile b/drivers/usb/typec/altmodes/Makefile
> index 45717548b396..508a68351bd2 100644
> --- a/drivers/usb/typec/altmodes/Makefile
> +++ b/drivers/usb/typec/altmodes/Makefile
> @@ -4,3 +4,5 @@ obj-$(CONFIG_TYPEC_DP_ALTMODE)		+= typec_displayport.o
>  typec_displayport-y			:= displayport.o
>  obj-$(CONFIG_TYPEC_NVIDIA_ALTMODE)	+= typec_nvidia.o
>  typec_nvidia-y				:= nvidia.o
> +obj-$(CONFIG_TYPEC_TBT_ALTMODE)		+= typec_thunderbolt.o
> +typec_thunderbolt-y			:= thunderbolt.o
> diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec/altmodes/thunderbolt.c
> new file mode 100644
> index 000000000000..515e775ee41a
> --- /dev/null
> +++ b/drivers/usb/typec/altmodes/thunderbolt.c
> @@ -0,0 +1,321 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * USB Typec-C Thuderbolt3 Alternate Mode driver
> + *
> + * Copyright (C) 2019 Intel Corporation
> + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/module.h>
> +#include <linux/usb/pd_vdo.h>
> +#include <linux/usb/typec_altmode.h>
> +
> +#define USB_TYPEC_VENDOR_INTEL		0x8087
> +
> +/* TBT3 Device Discover Mode VDO bits */
> +#define TBT_MODE			BIT(0)
> +#define TBT_ADAPTER(_vdo_)		(((_vdo_) & BIT(16)) >> 16)
> +#define   TBT_ADAPTER_LEGACY		0
> +#define   TBT_ADAPTER_TBT3		1
> +#define TBT_INTEL_SPECIFIC_B0		BIT(26)
> +#define TBT_VENDOR_SPECIFIC_B0		BIT(30)
> +#define TBT_VENDOR_SPECIFIC_B1		BIT(31)
> +
> +/* TBT3 Cable Discover Mode VDO bits */
> +#define TBT_CABLE_SPEED(_vdo_)		(((_vdo_) & GENMASK(18, 16)) >> 16)
> +#define   TBT_CABLE_USB3_GEN1		1
> +#define   TBT_CABLE_USB3_PASSIVE	2
> +#define   TBT_CABLE_10_AND_20GBPS	3
> +#define TBT_CABLE_ROUNDED		BIT(19)
> +#define TBT_CABLE_OPTICAL		BIT(21)
> +#define TBT_CABLE_RETIMER		BIT(22)
> +#define TBT_CABLE_LINK_TRAINING		BIT(23)
> +
> +/* TBT3 Device Enter Mode VDO bits */
> +#define TBT_ENTER_MODE_CABLE_SPEED(_s_)	(((_s_) & GENMASK(2, 0)) << 16)
> +#define TBT_ENTER_MODE_ACTIVE_CABLE	BIT(24)

I guess my original RFC was before the introduction of
linux/usb/typec_tbt.h. You can replace all the above definitions with:

#include <linux/usb/typec_tbt.h>

> +enum tbt_state {
> +	TBT_STATE_IDLE,
> +	TBT_STATE_SOP_P_ENTER,
> +	TBT_STATE_SOP_PP_ENTER,
> +	TBT_STATE_ENTER,
> +	TBT_STATE_EXIT,
> +	TBT_STATE_SOP_PP_EXIT,
> +	TBT_STATE_SOP_P_EXIT
> +};
> +
> +struct tbt_altmode {
> +	enum tbt_state state;
> +	struct typec_cable *cable;
> +	struct typec_altmode *alt;
> +	struct typec_altmode *plug[2];

You really have to supply struct typec_thunderbolt_data from this
driver.

I understand that by leaving the mux handling to the alt mode drivers,
you have to refactor at least cros_ec_typec.c, but I really think you
have to do it. So please either add here:

        struct typec_thunderbolt_data data;

or if we don't need to store it, store only the Enter Mode VDO:

        u32 enter_vdo;

> +	struct work_struct work;
> +	struct mutex lock; /* device lock */
> +};
> +
> +static bool tbt_ready(struct typec_altmode *alt);
> +
> +static int tbt_enter_mode(struct tbt_altmode *tbt)
> +{
> +	struct typec_altmode *plug = tbt->plug[TYPEC_PLUG_SOP_P];
> +	u32 vdo;
> +
> +	vdo = tbt->alt->vdo & (TBT_VENDOR_SPECIFIC_B0 | TBT_VENDOR_SPECIFIC_B1);
> +	vdo |= tbt->alt->vdo & TBT_INTEL_SPECIFIC_B0;
> +	vdo |= TBT_MODE;
> +
> +	if (plug) {
> +		if (typec_cable_is_active(tbt->cable))
> +			vdo |= TBT_ENTER_MODE_ACTIVE_CABLE;
> +
> +		vdo |= TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_SPEED(plug->vdo));
> +		vdo |= plug->vdo & TBT_CABLE_ROUNDED;

TBT_CABLE_ROUNDED needs to be defined in typec_tbt.h. It's missing for
some reason.

> +		vdo |= plug->vdo & TBT_CABLE_OPTICAL;
> +		vdo |= plug->vdo & TBT_CABLE_RETIMER;
> +		vdo |= plug->vdo & TBT_CABLE_LINK_TRAINING;
> +	} else {
> +		vdo |= TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_USB3_PASSIVE);
> +	}

So this vdo I believe will need to be stored:

        tbt->data.enter_vdo;

or

        tbt->enter_vdo = vdo;

> +	return typec_altmode_enter(tbt->alt, &vdo);
> +}
> +
> +static void tbt_altmode_work(struct work_struct *work)
> +{
> +	struct tbt_altmode *tbt = container_of(work, struct tbt_altmode, work);
> +	int ret;
> +
> +	mutex_lock(&tbt->lock);
> +
> +	switch (tbt->state) {
> +	case TBT_STATE_SOP_P_ENTER:
> +		ret = typec_altmode_enter(tbt->plug[TYPEC_PLUG_SOP_P], NULL);
> +		if (ret)
> +			dev_dbg(&tbt->plug[TYPEC_PLUG_SOP_P]->dev,
> +				"failed to enter mode (%d)\n", ret);
> +		break;
> +	case TBT_STATE_SOP_PP_ENTER:
> +		ret = typec_altmode_enter(tbt->plug[TYPEC_PLUG_SOP_PP], NULL);
> +		if (ret)
> +			dev_dbg(&tbt->plug[TYPEC_PLUG_SOP_PP]->dev,
> +				"failed to enter mode (%d)\n", ret);
> +		break;
> +	case TBT_STATE_ENTER:
> +		ret = tbt_enter_mode(tbt);
> +		if (ret)
> +			dev_dbg(&tbt->alt->dev, "failed to enter mode (%d)\n",
> +				ret);
> +		break;
> +	case TBT_STATE_EXIT:
> +		typec_altmode_exit(tbt->alt);
> +		break;
> +	case TBT_STATE_SOP_PP_EXIT:
> +		typec_altmode_exit(tbt->plug[TYPEC_PLUG_SOP_PP]);
> +		break;
> +	case TBT_STATE_SOP_P_EXIT:
> +		typec_altmode_exit(tbt->plug[TYPEC_PLUG_SOP_P]);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	tbt->state = TBT_STATE_IDLE;
> +
> +	mutex_unlock(&tbt->lock);
> +}
> +
> +static int tbt_altmode_vdm(struct typec_altmode *alt,
> +			   const u32 hdr, const u32 *vdo, int count)
> +{
> +	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
> +	int cmd_type = PD_VDO_CMDT(hdr);
> +	int cmd = PD_VDO_CMD(hdr);
> +
> +	mutex_lock(&tbt->lock);
> +
> +	if (tbt->state != TBT_STATE_IDLE) {
> +		mutex_unlock(&tbt->lock);
> +		return -EBUSY;
> +	}
> +
> +	switch (cmd_type) {
> +	case CMDT_RSP_ACK:
> +		switch (cmd) {
> +		case CMD_ENTER_MODE:
> +			/*
> +			 * Following the order describeded in USB Type-C Spec
> +			 * R2.0 Section 6.7.3.
> +			 */
> +			if (alt == tbt->plug[TYPEC_PLUG_SOP_P]) {
> +				if (tbt->plug[TYPEC_PLUG_SOP_PP])
> +					tbt->state = TBT_STATE_SOP_PP_ENTER;
> +				else
> +					tbt->state = TBT_STATE_ENTER;
> +			} else if (alt == tbt->plug[TYPEC_PLUG_SOP_PP]) {
> +				tbt->state = TBT_STATE_ENTER;
> +			} else {
> +				typec_altmode_notify(alt, TYPEC_STATE_MODAL,
> +						     NULL);

                                typec_altmode_notify(alt, TYPEC_STATE_MODAL, &tbt->data);

or, if this is possible:

                                struct typec_thunderbolt_data;

                                data.device_vdo = tbt->alt->vdo;
                                data.cable_vdo = tbt->plug[TYPEC_PLUG_SOP_P].vdo;
                                data.enter_vdo = tbt->enter_vdo;

                                typec_altmode_notify(alt, TYPEC_STATE_MODAL, &data);

> +			}
> +			break;
> +		case CMD_EXIT_MODE:
> +			if (alt == tbt->alt) {
> +				if (tbt->plug[TYPEC_PLUG_SOP_PP])
> +					tbt->state = TBT_STATE_SOP_PP_EXIT;
> +				else if (tbt->plug[TYPEC_PLUG_SOP_P])
> +					tbt->state = TBT_STATE_SOP_P_EXIT;
> +			} else if (alt == tbt->plug[TYPEC_PLUG_SOP_PP]) {
> +				tbt->state = TBT_STATE_SOP_P_EXIT;
> +			}
> +			break;
> +		}
> +		break;
> +	case CMDT_RSP_NAK:
> +		switch (cmd) {
> +		case CMD_ENTER_MODE:
> +			dev_warn(&alt->dev, "Enter Mode refused\n");
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (tbt->state != TBT_STATE_IDLE)
> +		schedule_work(&tbt->work);
> +
> +	mutex_unlock(&tbt->lock);
> +
> +	return 0;
> +}
> +
> +static int tbt_altmode_activate(struct typec_altmode *alt, int activate)
> +{
> +	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
> +	int ret;
> +
> +	mutex_lock(&tbt->lock);
> +
> +	if (!tbt_ready(alt))
> +		return -ENODEV;
> +
> +	/* Preventing the user space from entering/exiting the cable alt mode */
> +	if (alt != tbt->alt)
> +		ret = -EPERM;
> +	else if (activate)
> +		ret = tbt_enter_mode(tbt);
> +	else
> +		ret = typec_altmode_exit(alt);
> +
> +	mutex_unlock(&tbt->lock);
> +
> +	return ret;
> +}
> +
> +static const struct typec_altmode_ops tbt_altmode_ops = {
> +	.vdm		= tbt_altmode_vdm,
> +	.activate	= tbt_altmode_activate
> +};
> +
> +static int tbt_altmode_probe(struct typec_altmode *alt)
> +{
> +	struct tbt_altmode *tbt;
> +
> +	tbt = devm_kzalloc(&alt->dev, sizeof(*tbt), GFP_KERNEL);
> +	if (!tbt)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&tbt->work, tbt_altmode_work);
> +	mutex_init(&tbt->lock);
> +	tbt->alt = alt;

        tbt->data.device_mode = alt->vdo;

> +	alt->desc = "Thunderbolt3";
> +	typec_altmode_set_drvdata(alt, tbt);
> +	typec_altmode_set_ops(alt, &tbt_altmode_ops);
> +
> +	if (tbt_ready(alt)) {
> +		if (tbt->plug[TYPEC_PLUG_SOP_PP])
> +			tbt->state = TBT_STATE_SOP_PP_ENTER;
> +		else if (tbt->plug[TYPEC_PLUG_SOP_P])
> +			tbt->state = TBT_STATE_SOP_P_ENTER;
> +		else
> +			tbt->state = TBT_STATE_ENTER;
> +		schedule_work(&tbt->work);
> +	}
> +
> +	return 0;
> +}
> +
> +static void tbt_altmode_remove(struct typec_altmode *alt)
> +{
> +	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
> +
> +	for (int i = TYPEC_PLUG_SOP_PP; i > 0; --i) {
> +		if (tbt->plug[i])
> +			typec_altmode_put_plug(tbt->plug[i]);
> +	}
> +
> +	if (tbt->cable)
> +		typec_cable_put(tbt->cable);
> +}
> +
> +static bool tbt_ready(struct typec_altmode *alt)
> +{
> +	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
> +	struct typec_altmode *plug;
> +
> +	if (tbt->cable)
> +		return true;
> +
> +	/* Thundebolt 3 requires a cable with eMarker */
> +	tbt->cable = typec_cable_get(typec_altmode2port(tbt->alt));
> +	if (!tbt->cable)
> +		return false;
> +
> +	/* We accept systems without SOP' or SOP''. This means the port altmode
> +	 * driver will be responsible for properly ordering entry/exit.
> +	 */
> +	for (int i = 0; i < TYPEC_PLUG_SOP_PP + 1; i++) {
> +		plug = typec_altmode_get_plug(tbt->alt, i);
> +		if (IS_ERR(plug))
> +			continue;
> +
> +		if (!plug || plug->svid != USB_TYPEC_VENDOR_INTEL)
> +			break;
> +
> +		plug->desc = "Thunderbolt3";
> +		plug->ops = &tbt_altmode_ops;
> +		typec_altmode_set_drvdata(plug, tbt);
> +
> +		tbt->plug[i] = plug;
> +	}

        tbt->data.cable_mode = tbt->plug[TYPEC_PLUG_SOP_P].vdo;

> +	return true;
> +}
> +
> +static const struct typec_device_id tbt_typec_id[] = {
> +	{ USB_TYPEC_VENDOR_INTEL, TYPEC_ANY_MODE },

There is also the alias: USB_TYPEC_TBT_SID

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(typec, tbt_typec_id);
> +
> +static struct typec_altmode_driver tbt_altmode_driver = {
> +	.id_table = tbt_typec_id,
> +	.probe = tbt_altmode_probe,
> +	.remove = tbt_altmode_remove,
> +	.driver = {
> +		.name = "typec-thunderbolt",
> +		.owner = THIS_MODULE,
> +	}
> +};
> +module_typec_altmode_driver(tbt_altmode_driver);
> +
> +MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Thunderbolt3 USB Type-C Alternate Mode");

thanks,

-- 
heikki

