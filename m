Return-Path: <linux-kernel+bounces-333809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99197CE68
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 22:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95C9B22CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7077C5674D;
	Thu, 19 Sep 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxK0Dyna"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2822089
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726776965; cv=none; b=Z3W/NgmFB7MBUjcFsz4Q3MrksxGvQ+Hh0t04BPnieDnTh22Nwcu9wS2bOsmzed0rF3jezBXwt5Jxscf4vtRVRGaugYYxJdjK235iNpe7EQ71S2HnxI7CVgS+7Qxv7FxH5Rus9Et24iMZFGbl8+veXC5vJdwG1Y8hKq+z0B0KWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726776965; c=relaxed/simple;
	bh=YLxCblGPIZ1Kss+kh39LxnQ/ReiLXThpUwvfW5dIIEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkyuWCy+x2a8HkM6jojJU2MKXWqSc5m4PERIg0ar1YOmwwRQSXC4MNdBbUdWvBD9s1QEatXZLJ7pYLw6LOT+rHBzNN1F8pinpv12fnSnmt5XTNPNoKfOaQKYivfTH5I05veErJUDT9wzqYmvKT+J68zOLTRvmdVPPGLpT0LyVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxK0Dyna; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so157074266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726776961; x=1727381761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F/YjxAoXlr5u5u5N4/3TY/fS4Lvmdn+mSK4ewiV5R+4=;
        b=KxK0Dynaby8/Pk7YgXHKj2skIe76C4gF2f9NrpA2DqgCmlId8hVG3iIECZ68k4u+by
         iNkLtd9XLSB+mWRwLXpxTe8kjsfEOhUCB29BpzkU5noFnYBS32e1xuDSm6Pl+X/YY6EH
         deTClTFWpOrBJ8oQU6jU8ZautmIg7BKkccSP6ls357I2+5gaUxTqLLiUODhkOw0OELTo
         aYkKUXg8xb1Sj0Q8qthAcTdKDK1y6/VG6D9EFH2zjEFO4w4JlpuUyKTmmORN9yCLAljP
         8gQWAvckTMWB+pNY9tPrkL43C7931pmXwuhRhORnHoqIR45y8IOW9fqISHr7l40Dx6U+
         OGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726776961; x=1727381761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/YjxAoXlr5u5u5N4/3TY/fS4Lvmdn+mSK4ewiV5R+4=;
        b=mFqRzRO1KCcRejqGWZkT1MAhgtafTT+ZMNv9JMSlq088WRFEJOAuHEFJk5H45fxQHQ
         BqVo3yoNPl8MCgAYMSMa/6YQEQmEkmVHgaGEK5t8KTMT+UJ63QmBiypI/SXiUa8TRHEN
         Lv4coeT5j5FsnDXcgfmQSi1G1w9rhQh2/jCRuKH9OvEzi4sIVjTFWTp73D0QTCjeymu0
         8xE/47rkrNVX60MlLX0MzsRfuvoE2ITG3ZUQD1Ar5cc05e4H2N/RulzA9bRrZWu+LzWq
         qN0Mg0k4ucHT9T7riOOsZos2BLXPZ5kfjRAJKoH55V5ZMNtL1erasL4a9OsuNbKQWWRd
         9dyw==
X-Forwarded-Encrypted: i=1; AJvYcCUMZkiChfxrbxVJODfTde8VobOJYe1Rd7uJQcoc5Uqok5dvQrI+mVZX6Ek3D9GbbYWzmurwOah4vX26aY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXRHWBFsXF9UZRnEJa1hQ3/COUGANUKXzfjTHXp5vGUT8zLF0
	ZMGJKgi3KYPQXQQkLqjZZyu4SY7r1a1hQGl1U1IiESLJwgF9Ftt/
X-Google-Smtp-Source: AGHT+IGeUIAyq/z7la7Mj1E4jxrF4j6q9SeNrS2tLZczB0hP82APZBGc3EjuvYG57GPlIIsG+56hTg==
X-Received: by 2002:a17:907:e29e:b0:a90:97b1:85d with SMTP id a640c23a62f3a-a90d577a793mr24578266b.46.1726776960963;
        Thu, 19 Sep 2024 13:16:00 -0700 (PDT)
Received: from [192.168.2.100] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f386dsm757953766b.49.2024.09.19.13.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 13:16:00 -0700 (PDT)
Message-ID: <e3c09066-3a40-4145-b5b4-4ccf5b755982@gmail.com>
Date: Thu, 19 Sep 2024 22:15:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: Fix alignment to open parentheses
To: =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>, gregkh@linuxfoundation.org,
 tdavies@darkphysics.net, dan.carpenter@linaro.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240919185445.119969-1-dominik.karol.piatkowski@protonmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240919185445.119969-1-dominik.karol.piatkowski@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/19/24 20:55, Dominik Karol Piątkowski wrote:
> This patch aligns the code to open parentheses to improve readability.
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> ---
>   .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |  9 +-
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 20 ++--
>   .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 11 +--
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 30 +++---
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 10 +-
>   drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  2 +-
>   drivers/staging/rtl8192e/rtl819x_HTProc.c     | 26 +++---
>   drivers/staging/rtl8192e/rtl819x_TSProc.c     | 20 ++--
>   drivers/staging/rtl8192e/rtllib.h             | 30 +++---
>   drivers/staging/rtl8192e/rtllib_rx.c          | 91 +++++++++----------
>   drivers/staging/rtl8192e/rtllib_softmac.c     | 53 +++++------
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c  | 60 ++++++------
>   drivers/staging/rtl8192e/rtllib_wx.c          |  3 +-
>   13 files changed, 172 insertions(+), 193 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
> index 7061f1cf4d3a..d909f5c4fd21 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
> @@ -101,12 +101,9 @@ bool rtl92e_config_rf(struct net_device *dev)
>   		RF3_Final_Value = 0;
>   		while (RF3_Final_Value != RegValueToBeCheck &&
>   		       RetryTimes != 0) {
> -			ret = rtl92e_config_rf_path(dev,
> -						(enum rf90_radio_path)eRFPath);
> -			RF3_Final_Value = rtl92e_get_rf_reg(dev,
> -						(enum rf90_radio_path)eRFPath,
> -						RegOffSetToBeCheck,
> -						bMask12Bits);
> +			ret = rtl92e_config_rf_path(dev, (enum rf90_radio_path)eRFPath);
> +			RF3_Final_Value = rtl92e_get_rf_reg(dev, (enum rf90_radio_path)eRFPath,
> +							    RegOffSetToBeCheck, bMask12Bits);
>   			RetryTimes--;
>   		}
>   
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index 2672b1ddf88e..cf1231fe5319 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -321,8 +321,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
>   
>   		if (priv->epromtype == EEPROM_93C46) {
>   			if (!priv->autoload_fail_flag) {
> -				usValue = rtl92e_eeprom_read(dev,
> -					  EEPROM_TxPwDiff_CrystalCap >> 1);
> +				usValue = rtl92e_eeprom_read(dev, EEPROM_TxPwDiff_CrystalCap >> 1);
>   				priv->eeprom_ant_pwr_diff = usValue & 0x0fff;
>   				priv->eeprom_crystal_cap = (usValue & 0xf000)
>   							 >> 12;
> @@ -335,8 +334,9 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
>   
>   			for (i = 0; i < 14; i += 2) {
>   				if (!priv->autoload_fail_flag)
> -					usValue = rtl92e_eeprom_read(dev,
> -						  (EEPROM_TxPwIndex_CCK + i) >> 1);
> +					usValue =
> +						rtl92e_eeprom_read(dev,
> +								   (EEPROM_TxPwIndex_CCK + i) >> 1);

Sorry this is not really increasing readability.

>   				else
>   					usValue = EEPROM_Default_TxPower;
>   				*((u16 *)(&priv->eeprom_tx_pwr_level_cck[i])) =
> @@ -345,7 +345,8 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
>   			for (i = 0; i < 14; i += 2) {
>   				if (!priv->autoload_fail_flag)
>   					usValue = rtl92e_eeprom_read(dev,
> -						(EEPROM_TxPwIndex_OFDM_24G + i) >> 1);
> +								     (EEPROM_TxPwIndex_OFDM_24G + i)
> +								     >> 1);

Sorry this is not really increasing readability. The >> 1 in the next 
line is net nice.

>   				else
>   					usValue = EEPROM_Default_TxPower;
>   				*((u16 *)(&priv->eeprom_tx_pwr_level_ofdm24g[i]))
> @@ -1325,8 +1326,8 @@ static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
>   	} else {
>   		if (rf_rx_num != 0)
>   			pstats->signal_strength = precord_stats->signal_strength =
> -					 _rtl92e_signal_scale_mapping(priv,
> -					 (long)(total_rssi /= rf_rx_num));
> +					 _rtl92e_signal_scale_mapping(priv, (long)
> +								      (total_rssi /= rf_rx_num));

I am not happy with this either. There are two = in the same line...

>   	}
>   }
>   
> @@ -1737,7 +1738,7 @@ void rtl92e_update_ratr_table(struct net_device *dev)
>   	    ieee->ht_info->cur_short_gi_40mhz)
>   		ratr_value |= 0x80000000;
>   	else if (!ieee->ht_info->cur_tx_bw40mhz &&
> -		  ieee->ht_info->cur_short_gi_20mhz)
> +		 ieee->ht_info->cur_short_gi_20mhz)
>   		ratr_value |= 0x80000000;
>   	rtl92e_writel(dev, RATR0 + rate_index * 4, ratr_value);
>   	rtl92e_writeb(dev, UFWP, 1);
> @@ -1898,8 +1899,7 @@ bool rtl92e_get_nmode_support_by_sec(struct net_device *dev)
>   	struct rtllib_device *ieee = priv->rtllib;
>   
>   	if (ieee->rtllib_ap_sec_type &&
> -	   (ieee->rtllib_ap_sec_type(priv->rtllib) & (SEC_ALG_WEP |
> -				     SEC_ALG_TKIP))) {
> +	    (ieee->rtllib_ap_sec_type(priv->rtllib) & (SEC_ALG_WEP | SEC_ALG_TKIP))) {
>   		return false;
>   	} else {
>   		return true;
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> index fbe624e235df..b5f516c18b72 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> @@ -632,10 +632,9 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
>   			case cmd_id_rf_write_reg:
>   				for (eRFPath = 0; eRFPath <
>   				     priv->num_total_rf_path; eRFPath++)
> -					rtl92e_set_rf_reg(dev,
> -						 (enum rf90_radio_path)eRFPath,
> -						 CurrentCmd->para1, bMask12Bits,
> -						 CurrentCmd->para2 << 7);
> +					rtl92e_set_rf_reg(dev, (enum rf90_radio_path)eRFPath,
> +							  CurrentCmd->para1, bMask12Bits,
> +							  CurrentCmd->para2 << 7);
>   				break;
>   			default:
>   				break;
> @@ -992,7 +991,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
>   	switch (rf_power_state) {
>   	case rf_on:
>   		if ((priv->rtllib->rf_power_state == rf_off) &&
> -		     RT_IN_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC)) {
> +		    RT_IN_PS_LEVEL(psc, RT_RF_OFF_LEVL_HALT_NIC)) {
>   			bool rtstatus;
>   			u32 InitilizeCount = 3;
>   
> @@ -1013,7 +1012,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
>   			rtl92e_writeb(dev, ANAPAR, 0x37);
>   			mdelay(1);
>   			rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1,
> -					 0x4, 0x1);
> +					  0x4, 0x1);
>   			priv->hw_rf_off_action = 0;
>   			rtl92e_set_bb_reg(dev, rFPGA0_XA_RFInterfaceOE,
>   					  BIT(4), 0x1);
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> index dc1301f1a0c1..82a1b19fa1b3 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> @@ -253,7 +253,7 @@ static void _rtl92e_update_cap(struct net_device *dev, u16 cap)
>   		u8	cur_slot_time = priv->slot_time;
>   
>   		if ((cap & WLAN_CAPABILITY_SHORT_SLOT_TIME) &&
> -		   (!priv->rtllib->ht_info->current_rt2rt_long_slot_time)) {
> +		    (!priv->rtllib->ht_info->current_rt2rt_long_slot_time)) {
>   			if (cur_slot_time != SHORT_SLOT_TIME) {
>   				slot_time_val = SHORT_SLOT_TIME;
>   				priv->rtllib->set_hw_reg_handler(dev,
> @@ -326,9 +326,8 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
>   			network->qos_data.active = network->qos_data.supported;
>   
>   		if ((network->qos_data.active == 1) && (active_network == 1) &&
> -				(network->flags & NETWORK_HAS_QOS_PARAMETERS) &&
> -				(network->qos_data.old_param_count !=
> -				network->qos_data.param_count)) {
> +		    (network->flags & NETWORK_HAS_QOS_PARAMETERS) &&
> +		    (network->qos_data.old_param_count != network->qos_data.param_count)) {
>   			network->qos_data.old_param_count =
>   				network->qos_data.param_count;
>   			priv->rtllib->wmm_acm = network->qos_data.wmm_acm;
> @@ -390,7 +389,7 @@ static int _rtl92e_qos_assoc_resp(struct r8192_priv *priv,
>   			network->qos_data.param_count;
>   	} else {
>   		memcpy(&priv->rtllib->current_network.qos_data.parameters,
> -		&def_qos_parameters, size);
> +		       &def_qos_parameters, size);
>   		priv->rtllib->current_network.qos_data.active = 0;
>   		priv->rtllib->current_network.qos_data.supported = 0;
>   		set_qos_param = 1;
> @@ -406,8 +405,8 @@ static int _rtl92e_qos_assoc_resp(struct r8192_priv *priv,
>   }
>   
>   static int _rtl92e_handle_assoc_response(struct net_device *dev,
> -				 struct rtllib_assoc_response_frame *resp,
> -				 struct rtllib_network *network)
> +					 struct rtllib_assoc_response_frame *resp,
> +					 struct rtllib_network *network)

one space missing...

>   {
>   	struct r8192_priv *priv = rtllib_priv(dev);
>   
> @@ -819,7 +818,7 @@ static short _rtl92e_is_tx_queue_empty(struct net_device *dev)
>   			continue;
>   		if (skb_queue_len(&(&priv->tx_ring[i])->queue) > 0) {
>   			netdev_info(dev, "===>tx queue is not empty:%d, %d\n",
> -			       i, skb_queue_len(&(&priv->tx_ring[i])->queue));
> +				    i, skb_queue_len(&(&priv->tx_ring[i])->queue));
>   			return 0;
>   		}
>   	}
> @@ -905,7 +904,7 @@ static void _rtl92e_if_check_reset(struct net_device *dev)
>   		RxResetType = _rtl92e_rx_check_stuck(dev);
>   
>   	if (TxResetType == RESET_TYPE_SILENT ||
> -		   RxResetType == RESET_TYPE_SILENT) {
> +	    RxResetType == RESET_TYPE_SILENT) {
>   		netdev_info(dev, "%s(): TxResetType is %d, RxResetType is %d\n",
>   			    __func__, TxResetType, RxResetType);
>   	}
> @@ -970,7 +969,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
>   	}
>   	if ((ieee->link_state == MAC80211_LINKED) && (ieee->iw_mode == IW_MODE_INFRA)) {
>   		if (ieee->link_detect_info.num_rx_ok_in_period > 100 ||
> -		ieee->link_detect_info.num_tx_ok_in_period > 100)
> +		    ieee->link_detect_info.num_tx_ok_in_period > 100)
>   			busy_traffic = true;
>   
>   		if (ieee->link_detect_info.num_rx_ok_in_period > 4000 ||
> @@ -1030,8 +1029,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
>   
>   			ieee->link_state = RTLLIB_ASSOCIATING;
>   
> -			remove_peer_ts(priv->rtllib,
> -				     priv->rtllib->current_network.bssid);
> +			remove_peer_ts(priv->rtllib, priv->rtllib->current_network.bssid);
>   			ieee->is_roaming = true;
>   			ieee->is_set_key = false;
>   			ieee->link_change(dev);
> @@ -1170,7 +1168,7 @@ static int _rtl92e_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
>   
>   	if (queue_index != TXCMD_QUEUE) {
>   		if ((priv->rtllib->rf_power_state == rf_off) ||
> -		     !priv->up) {
> +		    !priv->up) {
>   			kfree_skb(skb);
>   			return 0;
>   		}
> @@ -1571,7 +1569,7 @@ static void _rtl92e_tx_resume(struct net_device *dev)
>   	for (queue_index = BK_QUEUE;
>   	     queue_index < MAX_QUEUE_SIZE; queue_index++) {
>   		while ((!skb_queue_empty(&ieee->skb_waitq[queue_index])) &&
> -		(priv->rtllib->check_nic_enough_desc(dev, queue_index) > 0)) {
> +		       (priv->rtllib->check_nic_enough_desc(dev, queue_index) > 0)) {
>   			skb = skb_dequeue(&ieee->skb_waitq[queue_index]);
>   			ieee->softmac_data_hard_start_xmit(skb, dev, 0);
>   		}
> @@ -1640,7 +1638,7 @@ static int _rtl92e_close(struct net_device *dev)
>   	int ret;
>   
>   	if ((rtllib_act_scanning(priv->rtllib, false)) &&
> -		!(priv->rtllib->softmac_features & IEEE_SOFTMAC_SCAN)) {
> +	    !(priv->rtllib->softmac_features & IEEE_SOFTMAC_SCAN)) {
>   		rtllib_stop_scan(priv->rtllib);
>   	}
>   
> @@ -1952,7 +1950,7 @@ static void _rtl92e_pci_disconnect(struct pci_dev *pdev)
>   		if (dev->mem_start != 0) {
>   			iounmap((void __iomem *)dev->mem_start);
>   			release_mem_region(pci_resource_start(pdev, 1),
> -					pci_resource_len(pdev, 1));
> +					   pci_resource_len(pdev, 1));
>   		}
>   
>   		free_rtllib(dev);
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> index e9ca5a8768ad..207dc0e57315 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> @@ -540,11 +540,9 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
>   
>   			for (k = 0; k < 5; k++) {
>   				if (k != 4)
> -					tmp_report[k] = rtl92e_readb(dev,
> -							 Tssi_Report_Value1 + k);
> +					tmp_report[k] = rtl92e_readb(dev, Tssi_Report_Value1 + k);
>   				else
> -					tmp_report[k] = rtl92e_readb(dev,
> -							 Tssi_Report_Value2);
> +					tmp_report[k] = rtl92e_readb(dev, Tssi_Report_Value2);
>   
>   				if (tmp_report[k] <= 20) {
>   					viviflag = true;
> @@ -1765,8 +1763,8 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
>   				   (REG_C38_TH + 5)) {
>   				if (reg_c38_State) {
>   					rtl92e_writeb(dev,
> -						rOFDM0_RxDetector3,
> -						priv->framesync);
> +						      rOFDM0_RxDetector3,
> +						      priv->framesync);
>   					reg_c38_State = RegC38_Default;
>   				}
>   			}
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
> index 7b6247acf6f4..dba35ba20dac 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
> @@ -118,7 +118,7 @@ void rtl92e_ips_enter(struct net_device *dev)
>   
>   	rt_state = priv->rtllib->rf_power_state;
>   	if (rt_state == rf_on && !psc->bSwRfProcessing &&
> -		(priv->rtllib->link_state != MAC80211_LINKED)) {
> +	    (priv->rtllib->link_state != MAC80211_LINKED)) {
>   		psc->eInactivePowerState = rf_off;
>   		_rtl92e_ps_update_rf_state(dev);
>   	}
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 9c9c0bc0cfde..ec43b5fda06e 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -228,7 +228,7 @@ void ht_reset_iot_setting(struct rt_hi_throughput *ht_info)
>   }
>   
>   void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
> -				  u8 *len, u8 is_encrypt, bool assoc)
> +				     u8 *len, u8 is_encrypt, bool assoc)
>   {
>   	struct rt_hi_throughput *ht = ieee->ht_info;
>   	struct ht_capab_ele *cap_ele = NULL;
> @@ -308,8 +308,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
>   	}
>   }
>   
> -void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee, u8 *posRT2RTAgg,
> -				u8 *len)
> +void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee, u8 *posRT2RTAgg, u8 *len)
>   {
>   	if (!posRT2RTAgg) {
>   		netdev_warn(ieee->dev, "%s(): posRT2RTAgg is null\n", __func__);
> @@ -357,8 +356,7 @@ static u8 ht_pick_mcs_rate(struct rtllib_device *ieee, u8 *pOperateMCS)
>   	return true;
>   }
>   
> -u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
> -		       u8 *pMCSFilter)
> +u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet, u8 *pMCSFilter)
>   {
>   	u8		i, j;
>   	u8		bitMap;
> @@ -398,7 +396,7 @@ u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
>   }
>   
>   static u8 ht_filter_mcs_rate(struct rtllib_device *ieee, u8 *pSupportMCS,
> -			  u8 *pOperateMCS)
> +			     u8 *pOperateMCS)
>   {
>   	u8 i;
>   
> @@ -418,8 +416,8 @@ static u8 ht_filter_mcs_rate(struct rtllib_device *ieee, u8 *pSupportMCS,
>   }
>   
>   void ht_set_connect_bw_mode(struct rtllib_device *ieee,
> -			enum ht_channel_width bandwidth,
> -			enum ht_extchnl_offset Offset);
> +			    enum ht_channel_width bandwidth,
> +			    enum ht_extchnl_offset Offset);

This one is not correct.


Hi Dominik,

this patch is to long. 1200 Lines are long for a patch. It might work 
out when it can be checked automatically. But in this case I need go 
through it line by line.

Another issue is that I cannot apply it on top of the following patch 
series that I see likely to be accepted.
https://lore.kernel.org/linux-staging/Zung-0ClV_527-_e@kernel-710/T/#t

Here a trick to ensure this is not happening. I would look into the 
coverletter of above mentioned patch series. There are only 8 files 
changed so there are plenty left untouched. You can work on them.

My opinion is that people who are knew to the kernel community should 
start with simple patches and then evolve.

I propose to look for unused macros in:

r8192E_hw.h

This is the output of a program I wrote. You need to carefully check if 
they are really good for removal.

BCN_TCFG_CW_SHIFT
BCN_TCFG_IFS
IMR_BcnInt
MSR_LINK_ADHOC
MSR_LINK_MASTER
RRSR_SHORT_OFFSET

You can find patches in git about the removal of the macros as an example.

Thanks for your support.

Bye Philipp














