Return-Path: <linux-kernel+bounces-297091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E795B2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F98B2838AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DAF183061;
	Thu, 22 Aug 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="emwYfT76"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075713C9CB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322540; cv=none; b=sSjnI/Pt0pGSKrEBLlEADi1rxGbs9fbA3gH3c+qrYO/NVETelQmtnAJjiGJVqGe6BJaEh1CUzVOcua/HBa6LWsyEzztfsOcJYyMaC0Odha5fa48+PPWzQZGOIUS715U99+KEv8faWog1fpu9f5uXYHhxpvT596E17JSpITbuDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322540; c=relaxed/simple;
	bh=wEjMmwOu28itu+IEmB5qjqFWdVnlnVf3h410WqYtorY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8JMXeQY8NNdOAC5Pe+2VZaedPKlVX/gL1XaJCSzm9e346ZtDjzIiYtbpgIxXeeSkP8pWRDEGzG6u6n509Roa8kon+tDUf/Ja+mtU9Vq+QjrHzMJsvuSMHvnZQ+Lbtnh2uzzOe33421XOXoqccG/ri/jkpYIpq/YxFGADU0C6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=emwYfT76; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a868d7f92feso91341066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724322537; x=1724927337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldFaxJii5YgjVOkhMMsi2YnK0rlIl544cfD59JqvCtg=;
        b=emwYfT76lX+9vNinUrSceUzq7GoM6EmalER8Czyv+QUoab++j0WLgVqP5yvaqG8TdO
         rltc8ustTk0qEBFb2e4XRbtBS+ub28fhmhsHV569MaIWYtmGI5ZI7+0/7xdIWyPGhJW2
         eLUFC7dWUhwI2WGXMk1qGfY+9EJ+cvcdSQklfz1mjMKnZHziC+F9cjd/jgt30WrmaUx1
         aWkFVQ+YsRmVdbBDGO4VtIKD9az7YwREjc+fTg3pMGwFQv++sS4qYeCnx2H0YF1k7x3W
         YqcWM4cVQMFyAJ7sIZAv3RTs7FUgqbXwh0R3ZYB+pHwcYbUTYaZNox70VdDFy2lX00r0
         QEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322537; x=1724927337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldFaxJii5YgjVOkhMMsi2YnK0rlIl544cfD59JqvCtg=;
        b=PjlVkH2aBmjxzc2FhhmmqB/seXJXrmHgAe336zxMrzEkX/rqhKN4Xuj7S36S+FqA00
         xVf7eklkJ5x6CJTG0oBT2Gn//8YuLvVumb1uvJE8ugFFoKZBEjmixgO29ZRVfs/8/kDR
         Cbp+aYGrAJXY64X97MqToUG2kTKjGctpkwiQbzgw5azVzkZ45vL047PQr79It3H9IZT7
         9g/cHzfFqdwQHTYsD8b2iYyrR3TDL7cvlnzY8Unn4RCGtAxBaNJBjAJpwTEot3xknkvq
         otr8agufMNbUhHcgPLknHlDQ9ABY7fairLXprSXcO05QL/fF6p8d+r9COIoz2GVzrmd3
         XqDg==
X-Forwarded-Encrypted: i=1; AJvYcCXSNjzc8lcPUpicK/iOGBAzVQWFy0W+tDqtWv//8/gTHN4nnU0D8xUqA9r+BLjlqmKdlLzQrx2NgLSLVD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvMRSlsZVNjR1WsxF/bROzfLWHzQTSk2L7UD7Jy9P+O4RmIYMA
	8SkadEcK/UkXQNFCc5v/e9u67Z6Gydhqvu0qGAnG066W+o1R24FWuv+qyhGJwhQ=
X-Google-Smtp-Source: AGHT+IF1Of3MmQo0oMg/u9DL80JvCjQ/vh7alpChOi20zfBTX+muqLD0BEKjFzKCqhJcG7GpJ913Ig==
X-Received: by 2002:a17:907:96ac:b0:a86:43c0:4270 with SMTP id a640c23a62f3a-a8691abab27mr108579366b.13.1724322536612;
        Thu, 22 Aug 2024 03:28:56 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2a58ddsm98949566b.80.2024.08.22.03.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:28:56 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:28:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v2 2/2] ice: add callbacks for Embedded SYNC
 enablement on dpll pins
Message-ID: <ZscS5jL_Uk0cqiga@nanopsycho.orion>
References: <20240821213218.232900-1-arkadiusz.kubalewski@intel.com>
 <20240821213218.232900-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821213218.232900-3-arkadiusz.kubalewski@intel.com>

Wed, Aug 21, 2024 at 11:32:18PM CEST, arkadiusz.kubalewski@intel.com wrote:
>Allow the user to get and set configuration of Embedded SYNC feature
>on the ice driver dpll pins.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
>v2:
>- align to v2 changes of "dpll: add Embedded SYNC feature for a pin"
>
> drivers/net/ethernet/intel/ice/ice_dpll.c | 230 +++++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
> 2 files changed, 228 insertions(+), 3 deletions(-)

Looks ok, couple of nitpicks below:



>
>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
>index e92be6f130a3..aa6b87281ea6 100644
>--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>@@ -9,6 +9,7 @@
> #define ICE_CGU_STATE_ACQ_ERR_THRESHOLD		50
> #define ICE_DPLL_PIN_IDX_INVALID		0xff
> #define ICE_DPLL_RCLK_NUM_PER_PF		1
>+#define ICE_DPLL_PIN_ESYNC_PULSE_HIGH_PERCENT	25
> 
> /**
>  * enum ice_dpll_pin_type - enumerate ice pin types:
>@@ -30,6 +31,10 @@ static const char * const pin_type_name[] = {
> 	[ICE_DPLL_PIN_TYPE_RCLK_INPUT] = "rclk-input",
> };
> 
>+static const struct dpll_pin_frequency ice_esync_range[] = {
>+	DPLL_PIN_FREQUENCY_RANGE(0, DPLL_PIN_FREQUENCY_1_HZ),
>+};
>+
> /**
>  * ice_dpll_is_reset - check if reset is in progress
>  * @pf: private board structure
>@@ -394,8 +399,8 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
> 
> 	switch (pin_type) {
> 	case ICE_DPLL_PIN_TYPE_INPUT:
>-		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, NULL, NULL,
>-					       NULL, &pin->flags[0],
>+		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, &pin->status,
>+					       NULL, NULL, &pin->flags[0],
> 					       &pin->freq, &pin->phase_adjust);
> 		if (ret)
> 			goto err;
>@@ -430,7 +435,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
> 			goto err;
> 
> 		parent &= ICE_AQC_GET_CGU_OUT_CFG_DPLL_SRC_SEL;
>-		if (ICE_AQC_SET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
>+		if (ICE_AQC_GET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
> 			pin->state[pf->dplls.eec.dpll_idx] =
> 				parent == pf->dplls.eec.dpll_idx ?
> 				DPLL_PIN_STATE_CONNECTED :
>@@ -1098,6 +1103,221 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
> 	return 0;
> }
> 
>+/**
>+ * ice_dpll_output_esync_set - callback for setting embedded sync
>+ * @pin: pointer to a pin
>+ * @pin_priv: private data pointer passed on pin registration
>+ * @dpll: registered dpll pointer
>+ * @dpll_priv: private data pointer passed on dpll registration
>+ * @esync_freq: requested embedded sync frequency
>+ * @extack: error reporting
>+ *
>+ * Dpll subsystem callback. Handler for setting embedded sync frequency value
>+ * on output pin.
>+ *
>+ * Context: Acquires pf->dplls.lock
>+ * Return:
>+ * * 0 - success
>+ * * negative - error
>+ */
>+static int
>+ice_dpll_output_esync_set(const struct dpll_pin *pin, void *pin_priv,
>+			  const struct dpll_device *dpll, void *dpll_priv,
>+			  u64 esync_freq, struct netlink_ext_ack *extack)

s/esync_freq/freq/


>+{
>+	struct ice_dpll_pin *p = pin_priv;
>+	struct ice_dpll *d = dpll_priv;
>+	struct ice_pf *pf = d->pf;
>+	u8 flags = 0;
>+	int ret;
>+
>+	if (ice_dpll_is_reset(pf, extack))
>+		return -EBUSY;
>+	mutex_lock(&pf->dplls.lock);
>+	if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_OUT_EN)
>+		flags = ICE_AQC_SET_CGU_OUT_CFG_OUT_EN;
>+	if (esync_freq == DPLL_PIN_FREQUENCY_1_HZ) {
>+		if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN) {
>+			ret = 0;
>+		} else {
>+			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
>+			ret = ice_aq_set_output_pin_cfg(&pf->hw, p->idx, flags,
>+							0, 0, 0);
>+		}
>+	} else {
>+		if (!(p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)) {
>+			ret = 0;
>+		} else {
>+			flags &= ~ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
>+			ret = ice_aq_set_output_pin_cfg(&pf->hw, p->idx, flags,
>+							0, 0, 0);
>+		}
>+	}
>+	mutex_unlock(&pf->dplls.lock);
>+	if (ret)
>+		NL_SET_ERR_MSG_FMT(extack,
>+				   "err:%d %s failed to set e-sync freq\n",
>+				   ret,
>+				   ice_aq_str(pf->hw.adminq.sq_last_status));


See my comment to ice_dpll_input_esync_set(), same applies here.


>+	return ret;
>+}
>+
>+/**
>+ * ice_dpll_output_esync_get - callback for getting embedded sync config
>+ * @pin: pointer to a pin
>+ * @pin_priv: private data pointer passed on pin registration
>+ * @dpll: registered dpll pointer
>+ * @dpll_priv: private data pointer passed on dpll registration
>+ * @esync: on success holds embedded sync pin properties
>+ * @extack: error reporting
>+ *
>+ * Dpll subsystem callback. Handler for getting embedded sync frequency value
>+ * and capabilities on output pin.
>+ *
>+ * Context: Acquires pf->dplls.lock
>+ * Return:
>+ * * 0 - success
>+ * * negative - error
>+ */
>+static int
>+ice_dpll_output_esync_get(const struct dpll_pin *pin, void *pin_priv,
>+			  const struct dpll_device *dpll, void *dpll_priv,
>+			  struct dpll_pin_esync *esync,
>+			  struct netlink_ext_ack *extack)
>+{
>+	struct ice_dpll_pin *p = pin_priv;
>+	struct ice_dpll *d = dpll_priv;
>+	struct ice_pf *pf = d->pf;
>+
>+	if (ice_dpll_is_reset(pf, extack))
>+		return -EBUSY;
>+	mutex_lock(&pf->dplls.lock);
>+	if (!(p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_ABILITY) ||
>+	    p->freq != DPLL_PIN_FREQUENCY_10_MHZ) {
>+		mutex_unlock(&pf->dplls.lock);
>+		return -EOPNOTSUPP;
>+	}
>+	esync->range = ice_esync_range;
>+	esync->range_num = ARRAY_SIZE(ice_esync_range);
>+	if (p->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN) {
>+		esync->freq = DPLL_PIN_FREQUENCY_1_HZ;
>+		esync->pulse = ICE_DPLL_PIN_ESYNC_PULSE_HIGH_PERCENT;
>+	} else {
>+		esync->freq = 0;
>+		esync->pulse = 0;
>+	}
>+	mutex_unlock(&pf->dplls.lock);
>+	return 0;
>+}
>+
>+/**
>+ * ice_dpll_input_esync_set - callback for setting embedded sync
>+ * @pin: pointer to a pin
>+ * @pin_priv: private data pointer passed on pin registration
>+ * @dpll: registered dpll pointer
>+ * @dpll_priv: private data pointer passed on dpll registration
>+ * @esync_freq: requested embedded sync frequency
>+ * @extack: error reporting
>+ *
>+ * Dpll subsystem callback. Handler for setting embedded sync frequency value
>+ * on input pin.
>+ *
>+ * Context: Acquires pf->dplls.lock
>+ * Return:
>+ * * 0 - success
>+ * * negative - error
>+ */
>+static int
>+ice_dpll_input_esync_set(const struct dpll_pin *pin, void *pin_priv,
>+			 const struct dpll_device *dpll, void *dpll_priv,
>+			 u64 esync_freq, struct netlink_ext_ack *extack)
>+{
>+	struct ice_dpll_pin *p = pin_priv;
>+	struct ice_dpll *d = dpll_priv;
>+	struct ice_pf *pf = d->pf;
>+	u8 flags_en = 0;
>+	int ret;
>+
>+	if (ice_dpll_is_reset(pf, extack))
>+		return -EBUSY;
>+	mutex_lock(&pf->dplls.lock);
>+	if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN)
>+		flags_en = ICE_AQC_SET_CGU_IN_CFG_FLG2_INPUT_EN;
>+	if (esync_freq == DPLL_PIN_FREQUENCY_1_HZ) {
>+		if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN) {
>+			ret = 0;
>+		} else {
>+			flags_en |= ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
>+			ret = ice_aq_set_input_pin_cfg(&pf->hw, p->idx, 0,
>+						       flags_en, 0, 0);
>+		}
>+	} else {
>+		if (!(p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN)) {
>+			ret = 0;
>+		} else {
>+			flags_en &= ~ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
>+			ret = ice_aq_set_input_pin_cfg(&pf->hw, p->idx, 0,
>+						       flags_en, 0, 0);
>+		}
>+	}
>+	mutex_unlock(&pf->dplls.lock);
>+	if (ret)
>+		NL_SET_ERR_MSG_FMT(extack,
>+				   "err:%d %s failed to set e-sync freq\n",

Not sure how you do that in ice, but there should be a space after ":".
But, in this case, print ret value in the message is redundant as you
return ret value to the user. Remove.

Moreover, this extack message has no value, as you basically say, that
the command user executed failed, which he already knows by non-0 return
value :) Either provide some useful details or avoid the extack message
completely.


>+				   ret,
>+				   ice_aq_str(pf->hw.adminq.sq_last_status));
>+
>+	return ret;
>+}
>+
>+/**
>+ * ice_dpll_input_esync_get - callback for getting embedded sync config
>+ * @pin: pointer to a pin
>+ * @pin_priv: private data pointer passed on pin registration
>+ * @dpll: registered dpll pointer
>+ * @dpll_priv: private data pointer passed on dpll registration
>+ * @esync: on success holds embedded sync pin properties
>+ * @extack: error reporting
>+ *
>+ * Dpll subsystem callback. Handler for getting embedded sync frequency value
>+ * and capabilities on input pin.
>+ *
>+ * Context: Acquires pf->dplls.lock
>+ * Return:
>+ * * 0 - success
>+ * * negative - error
>+ */
>+static int
>+ice_dpll_input_esync_get(const struct dpll_pin *pin, void *pin_priv,
>+			 const struct dpll_device *dpll, void *dpll_priv,
>+			 struct dpll_pin_esync *esync,
>+			 struct netlink_ext_ack *extack)
>+{
>+	struct ice_dpll_pin *p = pin_priv;
>+	struct ice_dpll *d = dpll_priv;
>+	struct ice_pf *pf = d->pf;
>+
>+	if (ice_dpll_is_reset(pf, extack))
>+		return -EBUSY;
>+	mutex_lock(&pf->dplls.lock);
>+	if (!(p->status & ICE_AQC_GET_CGU_IN_CFG_STATUS_ESYNC_CAP) ||
>+	    p->freq != DPLL_PIN_FREQUENCY_10_MHZ) {
>+		mutex_unlock(&pf->dplls.lock);
>+		return -EOPNOTSUPP;
>+	}
>+	esync->range = ice_esync_range;
>+	esync->range_num = ARRAY_SIZE(ice_esync_range);
>+	if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN) {
>+		esync->freq = DPLL_PIN_FREQUENCY_1_HZ;
>+		esync->pulse = ICE_DPLL_PIN_ESYNC_PULSE_HIGH_PERCENT;
>+	} else {
>+		esync->freq = 0;
>+		esync->pulse = 0;
>+	}
>+	mutex_unlock(&pf->dplls.lock);
>+	return 0;
>+}
>+
> /**
>  * ice_dpll_rclk_state_on_pin_set - set a state on rclk pin
>  * @pin: pointer to a pin
>@@ -1222,6 +1442,8 @@ static const struct dpll_pin_ops ice_dpll_input_ops = {
> 	.phase_adjust_get = ice_dpll_pin_phase_adjust_get,
> 	.phase_adjust_set = ice_dpll_input_phase_adjust_set,
> 	.phase_offset_get = ice_dpll_phase_offset_get,
>+	.esync_set = ice_dpll_input_esync_set,
>+	.esync_get = ice_dpll_input_esync_get,
> };
> 
> static const struct dpll_pin_ops ice_dpll_output_ops = {
>@@ -1232,6 +1454,8 @@ static const struct dpll_pin_ops ice_dpll_output_ops = {
> 	.direction_get = ice_dpll_output_direction,
> 	.phase_adjust_get = ice_dpll_pin_phase_adjust_get,
> 	.phase_adjust_set = ice_dpll_output_phase_adjust_set,
>+	.esync_set = ice_dpll_output_esync_set,
>+	.esync_get = ice_dpll_output_esync_get,
> };
> 
> static const struct dpll_device_ops ice_dpll_ops = {
>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
>index 93172e93995b..c320f1bf7d6d 100644
>--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
>@@ -31,6 +31,7 @@ struct ice_dpll_pin {
> 	struct dpll_pin_properties prop;
> 	u32 freq;
> 	s32 phase_adjust;
>+	u8 status;
> };
> 
> /** ice_dpll - store info required for DPLL control
>-- 
>2.38.1
>

