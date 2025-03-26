Return-Path: <linux-kernel+bounces-576389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E98CA70E95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049D8171C72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9C774C14;
	Wed, 26 Mar 2025 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hz7aHnK6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929DE322B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953610; cv=none; b=kJJM0DNTx9gdyObis1Fw1T8Vf85wliHvWqWUmpBbj2VWWAV4+wOlcBj4pLJzWaX8WMtmoR+AK+Blol4ysp46Zmcd8NVVU7KuWlY79lcbpOVT827E4XY/4C1N2OnSPei40vkAAioP4IahhQz6iVLOEFhymbPfkvp1pwF+StlQ8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953610; c=relaxed/simple;
	bh=0Zr6F69uujm0vJ/vHTxcLOnKP5fR+kPlRUODSW0qCc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbRq1SpSZ5rWlQeQh+repSCJKusyPkYggXfmG9pFC9M/rbTwiyb8exTXRYwqOqXebqYSDsQD9f4facF2VQJBEyXdqmQ5dvnBx0hGeYEusXGpY9OrRamen+B5EA4JHWv+FgqyrwzeoMKMQFdD7NaN6aLuf4nRxV+cNMLEkKoJ6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hz7aHnK6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742953609; x=1774489609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Zr6F69uujm0vJ/vHTxcLOnKP5fR+kPlRUODSW0qCc8=;
  b=hz7aHnK67T67q1TG8474wrYqcQbx96J4QpXfproJKKZlDZbNYqIRD6J4
   rs3HHkeHHiq4GKxKdoES+Qv/ANBu4zTYo0e0uRHkjGSHaGYEVoA+zhjlj
   Pifc8/h+K1ONI6akuYUV5Q2fMcd5GgiwEDVvAv/WtXODCX8XPPXqj8zQ/
   379gNFH96YyQ2AulJpK7WSxJzvQkHe6i9YrhSqJMnoZfA09wOo6lF6yIC
   Y5N0YVXgoU6UQg8sdWPM5+zui2auEeH9xUBWj1+m/AbEnWNsXh7b2F6FR
   sHs+Iqj2dCdUR7MHKXuyBoBCPwjqWnqCRIStv99d1za2nviwN1v703sJt
   A==;
X-CSE-ConnectionGUID: FnE2WI7NS/6f7Kv7wg4egg==
X-CSE-MsgGUID: eeeWfPcjQ6e2D9VIzPfIng==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61619427"
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; 
   d="scan'208";a="61619427"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 18:46:49 -0700
X-CSE-ConnectionGUID: PVCacvTMR/eS7J9LELlpNA==
X-CSE-MsgGUID: VM21gQcATh6FP8cp/4zWNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; 
   d="scan'208";a="125094575"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 25 Mar 2025 18:46:45 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txFqt-0005N1-0W;
	Wed, 26 Mar 2025 01:46:43 +0000
Date: Wed, 26 Mar 2025 09:46:27 +0800
From: kernel test robot <lkp@intel.com>
To: Erick Karanja <karanja99erick@gmail.com>, gregkh@linuxfoundation.org,
	outreachy@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, philipp.g.hortmann@gmail.com,
	davidzalman.101@gmail.com, vivek6429.ts@gmail.com,
	viro@zeniv.linux.org.uk, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Rename variable supportRateNum
Message-ID: <202503260942.B3X371Wq-lkp@intel.com>
References: <20250325091220.38601-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325091220.38601-1-karanja99erick@gmail.com>

Hi Erick,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Erick-Karanja/staging-rtl8723bs-Rename-variable-supportRateNum/20250325-171434
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250325091220.38601-1-karanja99erick%40gmail.com
patch subject: [PATCH] staging: rtl8723bs: Rename variable supportRateNum
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250326/202503260942.B3X371Wq-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250326/202503260942.B3X371Wq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503260942.B3X371Wq-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/staging/rtl8723bs/core/rtw_ap.c: In function 'rtw_check_beacon_data':
>> drivers/staging/rtl8723bs/core/rtw_ap.c:896:17: error: 'support_rate_num' undeclared (first use in this function); did you mean 'supportRateNum'?
     896 |                 support_rate_num = ie_len;
         |                 ^~~~~~~~~~~~~~~~
         |                 supportRateNum
   drivers/staging/rtl8723bs/core/rtw_ap.c:896:17: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/staging/rtl8723bs/core/rtw_ap.c:821:13: warning: unused variable 'supportRateNum' [-Wunused-variable]
     821 |         int supportRateNum = 0;
         |             ^~~~~~~~~~~~~~


vim +896 drivers/staging/rtl8723bs/core/rtw_ap.c

   809	
   810	int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
   811	{
   812		int ret = _SUCCESS;
   813		u8 *p;
   814		u8 *pHT_caps_ie = NULL;
   815		u8 *pHT_info_ie = NULL;
   816		struct sta_info *psta = NULL;
   817		u16 cap, ht_cap = false;
   818		uint ie_len = 0;
   819		int group_cipher, pairwise_cipher;
   820		u8 channel, network_type, supportRate[NDIS_802_11_LENGTH_RATES_EX];
 > 821		int supportRateNum = 0;
   822		u8 OUI1[] = {0x00, 0x50, 0xf2, 0x01};
   823		u8 WMM_PARA_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
   824		struct registry_priv *pregistrypriv = &padapter->registrypriv;
   825		struct security_priv *psecuritypriv = &padapter->securitypriv;
   826		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
   827		struct wlan_bssid_ex
   828			*pbss_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
   829		u8 *ie = pbss_network->ies;
   830	
   831		if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
   832			return _FAIL;
   833	
   834		if (len < 0 || len > MAX_IE_SZ)
   835			return _FAIL;
   836	
   837		pbss_network->ie_length = len;
   838	
   839		memset(ie, 0, MAX_IE_SZ);
   840	
   841		memcpy(ie, pbuf, pbss_network->ie_length);
   842	
   843		if (pbss_network->infrastructure_mode != Ndis802_11APMode)
   844			return _FAIL;
   845	
   846		pbss_network->rssi = 0;
   847	
   848		memcpy(pbss_network->mac_address, myid(&padapter->eeprompriv), ETH_ALEN);
   849	
   850		/* beacon interval */
   851		p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, 2: Beacon Interval 2:Capability */
   852		/* pbss_network->configuration.beacon_period = le16_to_cpu(*(unsigned short*)p); */
   853		pbss_network->configuration.beacon_period = get_unaligned_le16(p);
   854	
   855		/* capability */
   856		/* cap = *(unsigned short *)rtw_get_capability_from_ie(ie); */
   857		/* cap = le16_to_cpu(cap); */
   858		cap = get_unaligned_le16(ie);
   859	
   860		/* SSID */
   861		p = rtw_get_ie(
   862			ie + _BEACON_IE_OFFSET_,
   863			WLAN_EID_SSID,
   864			&ie_len,
   865			(pbss_network->ie_length - _BEACON_IE_OFFSET_)
   866		);
   867		if (p && ie_len > 0) {
   868			memset(&pbss_network->ssid, 0, sizeof(struct ndis_802_11_ssid));
   869			memcpy(pbss_network->ssid.ssid, (p + 2), ie_len);
   870			pbss_network->ssid.ssid_length = ie_len;
   871		}
   872	
   873		/* channel */
   874		channel = 0;
   875		pbss_network->configuration.length = 0;
   876		p = rtw_get_ie(
   877			ie + _BEACON_IE_OFFSET_,
   878			WLAN_EID_DS_PARAMS, &ie_len,
   879			(pbss_network->ie_length - _BEACON_IE_OFFSET_)
   880		);
   881		if (p && ie_len > 0)
   882			channel = *(p + 2);
   883	
   884		pbss_network->configuration.ds_config = channel;
   885	
   886		memset(supportRate, 0, NDIS_802_11_LENGTH_RATES_EX);
   887		/*  get supported rates */
   888		p = rtw_get_ie(
   889			ie + _BEACON_IE_OFFSET_,
   890			WLAN_EID_SUPP_RATES,
   891			&ie_len,
   892			(pbss_network->ie_length - _BEACON_IE_OFFSET_)
   893		);
   894		if (p) {
   895			memcpy(supportRate, p + 2, ie_len);
 > 896			support_rate_num = ie_len;
   897		}
   898	
   899		/* get ext_supported rates */
   900		p = rtw_get_ie(
   901			ie + _BEACON_IE_OFFSET_,
   902			WLAN_EID_EXT_SUPP_RATES,
   903			&ie_len,
   904			pbss_network->ie_length - _BEACON_IE_OFFSET_
   905		);
   906		if (p) {
   907			memcpy(supportRate + support_rate_num, p + 2, ie_len);
   908			support_rate_num += ie_len;
   909		}
   910	
   911		network_type = rtw_check_network_type(supportRate, support_rate_num,
   912						      channel);
   913	
   914		rtw_set_supported_rate(pbss_network->supported_rates, network_type);
   915	
   916		/* parsing ERP_IE */
   917		p = rtw_get_ie(
   918			ie + _BEACON_IE_OFFSET_,
   919			WLAN_EID_ERP_INFO,
   920			&ie_len,
   921			(pbss_network->ie_length - _BEACON_IE_OFFSET_)
   922		);
   923		if (p && ie_len > 0)
   924			ERP_IE_handler(padapter, (struct ndis_80211_var_ie *)p);
   925	
   926		/* update privacy/security */
   927		if (cap & BIT(4))
   928			pbss_network->privacy = 1;
   929		else
   930			pbss_network->privacy = 0;
   931	
   932		psecuritypriv->wpa_psk = 0;
   933	
   934		/* wpa2 */
   935		group_cipher = 0; pairwise_cipher = 0;
   936		psecuritypriv->wpa2_group_cipher = _NO_PRIVACY_;
   937		psecuritypriv->wpa2_pairwise_cipher = _NO_PRIVACY_;
   938		p = rtw_get_ie(
   939			ie + _BEACON_IE_OFFSET_,
   940			WLAN_EID_RSN,
   941			&ie_len,
   942			(pbss_network->ie_length - _BEACON_IE_OFFSET_)
   943		);
   944		if (p && ie_len > 0) {
   945			if (rtw_parse_wpa2_ie(
   946				p,
   947				ie_len + 2,
   948				&group_cipher,
   949				&pairwise_cipher,
   950				NULL
   951			) == _SUCCESS) {
   952				psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
   953	
   954				psecuritypriv->dot8021xalg = 1;/* psk,  todo:802.1x */
   955				psecuritypriv->wpa_psk |= BIT(1);
   956	
   957				psecuritypriv->wpa2_group_cipher = group_cipher;
   958				psecuritypriv->wpa2_pairwise_cipher = pairwise_cipher;
   959			}
   960		}
   961	
   962		/* wpa */
   963		ie_len = 0;
   964		group_cipher = 0; pairwise_cipher = 0;
   965		psecuritypriv->wpa_group_cipher = _NO_PRIVACY_;
   966		psecuritypriv->wpa_pairwise_cipher = _NO_PRIVACY_;
   967		for (p = ie + _BEACON_IE_OFFSET_; ; p += (ie_len + 2)) {
   968			p = rtw_get_ie(
   969				p,
   970				WLAN_EID_VENDOR_SPECIFIC,
   971				&ie_len,
   972				(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
   973			);
   974			if ((p) && (!memcmp(p + 2, OUI1, 4))) {
   975				if (rtw_parse_wpa_ie(
   976					p,
   977					ie_len + 2,
   978					&group_cipher,
   979					&pairwise_cipher,
   980					NULL
   981				) == _SUCCESS) {
   982					psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
   983	
   984					psecuritypriv->dot8021xalg = 1;/* psk,  todo:802.1x */
   985	
   986					psecuritypriv->wpa_psk |= BIT(0);
   987	
   988					psecuritypriv->wpa_group_cipher = group_cipher;
   989					psecuritypriv->wpa_pairwise_cipher = pairwise_cipher;
   990				}
   991	
   992				break;
   993			}
   994	
   995			if (!p || ie_len == 0)
   996				break;
   997		}
   998	
   999		/* wmm */
  1000		ie_len = 0;
  1001		pmlmepriv->qospriv.qos_option = 0;
  1002		if (pregistrypriv->wmm_enable) {
  1003			for (p = ie + _BEACON_IE_OFFSET_; ; p += (ie_len + 2)) {
  1004				p = rtw_get_ie(
  1005					p,
  1006					WLAN_EID_VENDOR_SPECIFIC,
  1007					&ie_len,
  1008					(pbss_network->ie_length - _BEACON_IE_OFFSET_ - (ie_len + 2))
  1009				);
  1010				if ((p) && !memcmp(p + 2, WMM_PARA_IE, 6)) {
  1011					pmlmepriv->qospriv.qos_option = 1;
  1012	
  1013					*(p + 8) |= BIT(7);/* QoS Info, support U-APSD */
  1014	
  1015					/* disable all ACM bits since the WMM admission */
  1016					/* control is not supported */
  1017					*(p + 10) &= ~BIT(4); /* BE */
  1018					*(p + 14) &= ~BIT(4); /* BK */
  1019					*(p + 18) &= ~BIT(4); /* VI */
  1020					*(p + 22) &= ~BIT(4); /* VO */
  1021	
  1022					break;
  1023				}
  1024	
  1025				if (!p || ie_len == 0)
  1026					break;
  1027			}
  1028		}
  1029	
  1030		/* parsing HT_CAP_IE */
  1031		p = rtw_get_ie(
  1032			ie + _BEACON_IE_OFFSET_,
  1033			WLAN_EID_HT_CAPABILITY,
  1034			&ie_len,
  1035			(pbss_network->ie_length - _BEACON_IE_OFFSET_)
  1036		);
  1037		if (p && ie_len > 0) {
  1038			u8 max_rx_ampdu_factor = 0;
  1039			struct ieee80211_ht_cap *pht_cap = (struct ieee80211_ht_cap *)(p + 2);
  1040	
  1041			pHT_caps_ie = p;
  1042	
  1043			ht_cap = true;
  1044			network_type |= WIRELESS_11_24N;
  1045	
  1046			rtw_ht_use_default_setting(padapter);
  1047	
  1048			if (pmlmepriv->htpriv.sgi_20m == false)
  1049				pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_SGI_20));
  1050	
  1051			if (pmlmepriv->htpriv.sgi_40m == false)
  1052				pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_SGI_40));
  1053	
  1054			if (!TEST_FLAG(pmlmepriv->htpriv.ldpc_cap, LDPC_HT_ENABLE_RX))
  1055				pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_LDPC_CODING));
  1056	
  1057			if (!TEST_FLAG(pmlmepriv->htpriv.stbc_cap, STBC_HT_ENABLE_TX))
  1058				pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_TX_STBC));
  1059	
  1060			if (!TEST_FLAG(pmlmepriv->htpriv.stbc_cap, STBC_HT_ENABLE_RX))
  1061				pht_cap->cap_info &= cpu_to_le16(~(IEEE80211_HT_CAP_RX_STBC_3R));
  1062	
  1063			pht_cap->ampdu_params_info &= ~(
  1064				IEEE80211_HT_CAP_AMPDU_FACTOR | IEEE80211_HT_CAP_AMPDU_DENSITY
  1065			);
  1066	
  1067			if ((psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_CCMP) ||
  1068			    (psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_CCMP)) {
  1069				pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY &
  1070							       (0x07 << 2));
  1071			} else {
  1072				pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY &
  1073							       0x00);
  1074			}
  1075	
  1076			rtw_hal_get_def_var(
  1077				padapter,
  1078				HW_VAR_MAX_RX_AMPDU_FACTOR,
  1079				&max_rx_ampdu_factor
  1080			);
  1081			pht_cap->ampdu_params_info |= (
  1082				IEEE80211_HT_CAP_AMPDU_FACTOR & max_rx_ampdu_factor
  1083			); /* set  Max Rx AMPDU size  to 64K */
  1084	
  1085			pht_cap->mcs.rx_mask[0] = 0xff;
  1086			pht_cap->mcs.rx_mask[1] = 0x0;
  1087	
  1088			memcpy(&pmlmepriv->htpriv.ht_cap, p + 2, ie_len);
  1089		}
  1090	
  1091		/* parsing HT_INFO_IE */
  1092		p = rtw_get_ie(
  1093			ie + _BEACON_IE_OFFSET_,
  1094			WLAN_EID_HT_OPERATION,
  1095			&ie_len,
  1096			(pbss_network->ie_length - _BEACON_IE_OFFSET_)
  1097		);
  1098		if (p && ie_len > 0)
  1099			pHT_info_ie = p;
  1100	
  1101		switch (network_type) {
  1102		case WIRELESS_11B:
  1103			pbss_network->network_type_in_use = Ndis802_11DS;
  1104			break;
  1105		case WIRELESS_11G:
  1106		case WIRELESS_11BG:
  1107		case WIRELESS_11G_24N:
  1108		case WIRELESS_11BG_24N:
  1109			pbss_network->network_type_in_use = Ndis802_11OFDM24;
  1110			break;
  1111		default:
  1112			pbss_network->network_type_in_use = Ndis802_11OFDM24;
  1113			break;
  1114		}
  1115	
  1116		pmlmepriv->cur_network.network_type = network_type;
  1117	
  1118		pmlmepriv->htpriv.ht_option = false;
  1119	
  1120		if ((psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_TKIP) ||
  1121		    (psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_TKIP)) {
  1122			/* todo: */
  1123			/* ht_cap = false; */
  1124		}
  1125	
  1126		/* ht_cap */
  1127		if (pregistrypriv->ht_enable && ht_cap) {
  1128			pmlmepriv->htpriv.ht_option = true;
  1129			pmlmepriv->qospriv.qos_option = 1;
  1130	
  1131			if (pregistrypriv->ampdu_enable == 1)
  1132				pmlmepriv->htpriv.ampdu_enable = true;
  1133	
  1134			HT_caps_handler(padapter, (struct ndis_80211_var_ie *)pHT_caps_ie);
  1135	
  1136			HT_info_handler(padapter, (struct ndis_80211_var_ie *)pHT_info_ie);
  1137		}
  1138	
  1139		pbss_network->length = get_wlan_bssid_ex_sz(
  1140			(struct wlan_bssid_ex  *)pbss_network
  1141		);
  1142	
  1143		/* issue beacon to start bss network */
  1144		/* start_bss_network(padapter, (u8 *)pbss_network); */
  1145		rtw_startbss_cmd(padapter, RTW_CMDF_WAIT_ACK);
  1146	
  1147		/* alloc sta_info for ap itself */
  1148		psta = rtw_get_stainfo(&padapter->stapriv, pbss_network->mac_address);
  1149		if (!psta) {
  1150			psta = rtw_alloc_stainfo(&padapter->stapriv, pbss_network->mac_address);
  1151			if (!psta)
  1152				return _FAIL;
  1153		}
  1154	
  1155		/*  update AP's sta info */
  1156		update_ap_info(padapter, psta);
  1157	
  1158		psta->state |= WIFI_AP_STATE;		/* Aries, add, fix bug of flush_cam_entry at STOP AP mode , 0724 */
  1159		rtw_indicate_connect(padapter);
  1160	
  1161		pmlmepriv->cur_network.join_res = true;/* for check if already set beacon */
  1162	
  1163		/* update bc/mc sta_info */
  1164		/* update_bmc_sta(padapter); */
  1165	
  1166		return ret;
  1167	}
  1168	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

