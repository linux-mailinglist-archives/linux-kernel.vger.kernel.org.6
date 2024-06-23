Return-Path: <linux-kernel+bounces-226362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA5C913D74
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C02C1F21305
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87351836ED;
	Sun, 23 Jun 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpyJoAFb"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA6F1836E3
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165414; cv=none; b=A5evnVtpV0rAJMY5PhAekfT4Cj/fUWb1t0jzxIxYzD87BmUetwuB0c75t4gzmrm1ZAuOAj86MMTbyntFrfbuHRf5Z88MCklWWeckzape360T5ZQE+M62dc6ENDg/38vNTND/x232IoaSplN59pPG02rri9zLoEa7WfXJ/bttgtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165414; c=relaxed/simple;
	bh=CkNidE77ffiowd7zZh05OdJoJAHIaW3NM/A1Lnyb0cQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQnqVCQXDjCTrOavx6W2466Wc2D0MkgQjhIJozLDPDNuAIdFBeMxHUrf7Guf3Bz2HIWcwvsBpYjkWNejP3fNaZR/B/0BsbdWTh5HZrJ2rCrR0aXCmKmM8fy+l/NpD2Bzm+YuHOgIoVRvpwvkM4JYNDniQJO9XbPGpzYGkGpehus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpyJoAFb; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec5d86e759so679281fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165411; x=1719770211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxEkr3kzazdvCbWAtPFW8X6ggBQGBByP2sngH0vtHa8=;
        b=UpyJoAFbO/jqvBCxJwsc+QkfgVOHpKl107cPKjYAxprFieeXBOkwD0jfKJqYiov1gt
         FXmn/dg6zLdG6H9RXn7Ynfe/H4JACo3xS6eDo0iSW+8vfUtItYWPhwIgsIdvyQqku2hp
         BxExxo1/yIUPkqQj/nK+YoeUq1ChwHaaQExtJbybnT3x5utk2Nk4CnUDtH3fMgP2dnZz
         apluM5GZSkXs2u7pVVeTBNpnM2b5tc11Tbikn2jUQ6+8lWIfXRC7qURwog40cpZaXHxL
         ZQKoPWn8nqz4x9iIgvrQxXmlFlRX6pqDKBO8JKGZEHeROQCd3JRwcNQJutnpH8kiJsnC
         R24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165411; x=1719770211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxEkr3kzazdvCbWAtPFW8X6ggBQGBByP2sngH0vtHa8=;
        b=pY3piURAaeGh0nd12yUGg8FXFIJ4D1xkEQsX1Z/W6RcPOscK8Iiam3a6ZBnNpKLz63
         VwWXAHIBX8EVceRGTY5WoVqEE4AJ4ZsZ/E7pGFxWHJDSKgrdIHjEHAVaWthHAqHThXk/
         iuhyTREPmKRgX27dV1PdmhCdhYdkfoR9rL9TnjDDFnCH0R9Jo25DDRAkXuERQw6rdt97
         VauY9pDW9xeoV+3Uvey6eCXsmdfvq8qL/8cLrWVNHAQdsE0MomDafhOmGPu+ddoTid3R
         LMeCXp312ypPwxCEMU/M0gLLBsbcvnY1c9kx/Y+ZBnCZAfUke+PSE6MpCR+pcnzm7aRn
         C2ug==
X-Forwarded-Encrypted: i=1; AJvYcCU2atdnChbFkXu3dqf9bOCRrijd15Fk/7c0L8QjII9wHXCoKAgZjarH+wvjd8SeXj1r8bxQ0z6P3XtxOpm5+kpVUaaz2Ym2Mwl7720r
X-Gm-Message-State: AOJu0Yy52bnGWiHqaDV1KF796MRVuYH2QWoon9VtEjmC0/JN+cR9+bIM
	vpSG7Mt7kcpWsyp0GB272EXyG1op+l5k7Uvs+mLimagB6Cv8tf29
X-Google-Smtp-Source: AGHT+IEGyyMp4Lh3xeBd9+B2B85X7h/A/naDjsCxxbgClWb8uFpH17/mXX7GTaHDfU0ro6S+G1ryhw==
X-Received: by 2002:a2e:bb8e:0:b0:2ec:31d9:16e1 with SMTP id 38308e7fff4ca-2ec561caabamr17414171fa.5.1719165410904;
        Sun, 23 Jun 2024 10:56:50 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3053558esm3719128a12.64.2024.06.23.10.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:56:50 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:56:49 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] staging: rtl8723bs: Remove unused structs starting
 with profile_info
Message-ID: <0771ebf074f71fb484d0005241416144ca813859.1719155208.git.philipp.g.hortmann@gmail.com>
References: <cover.1719155208.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719155208.git.philipp.g.hortmann@gmail.com>

Remove unused structs.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_mlme.h | 133 -------------------
 1 file changed, 133 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index fc0b43d38d9a..7ce8eaf4ec80 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -141,139 +141,6 @@ struct rt_link_detect_t {
 	u32 LowPowerTransitionCount;
 };
 
-struct profile_info {
-	u8 ssidlen;
-	u8 ssid[WLAN_SSID_MAXLEN];
-	u8 peermac[ETH_ALEN];
-};
-
-struct tx_invite_req_info {
-	u8 			token;
-	u8 			benable;
-	u8			go_ssid[WLAN_SSID_MAXLEN];
-	u8 			ssidlen;
-	u8			go_bssid[ETH_ALEN];
-	u8			peer_macaddr[ETH_ALEN];
-	u8 			operating_ch;	/* 	This information will be set by using the p2p_set op_ch =x */
-	u8 			peer_ch;		/* 	The listen channel for peer P2P device */
-
-};
-
-struct tx_invite_resp_info {
-	u8 			token;	/* 	Used to record the dialog token of p2p invitation request frame. */
-};
-
-struct tx_provdisc_req_info {
-	u16 				wps_config_method_request;	/* 	Used when sending the provisioning request frame */
-	u16 				peer_channel_num[2];		/* 	The channel number which the receiver stands. */
-	struct ndis_802_11_ssid	ssid;
-	u8			peerDevAddr[ETH_ALEN];		/*	Peer device address */
-	u8			peerIFAddr[ETH_ALEN];		/*	Peer interface address */
-	u8 			benable;					/* 	This provision discovery request frame is trigger to send or not */
-};
-
-struct rx_provdisc_req_info {	/* When peer device issue prov_disc_req first, we should store the following information */
-	u8			peerDevAddr[ETH_ALEN];		/*	Peer device address */
-	u8 			strconfig_method_desc_of_prov_disc_req[4];	/* 	description for the config method located in the provisioning discovery request frame. */
-																	/* 	The UI must know this information to know which config method the remote p2p device is requiring. */
-};
-
-struct tx_nego_req_info {
-	u16 				peer_channel_num[2];		/* 	The channel number which the receiver stands. */
-	u8			peerDevAddr[ETH_ALEN];		/*	Peer device address */
-	u8 			benable;					/* 	This negotiation request frame is trigger to send or not */
-};
-
-struct group_id_info {
-	u8			go_device_addr[ETH_ALEN];	/*	The GO's device address of this P2P group */
-	u8			ssid[WLAN_SSID_MAXLEN];	/*	The SSID of this P2P group */
-};
-
-struct scan_limit_info {
-	u8 			scan_op_ch_only;			/* 	When this flag is set, the driver should just scan the operation channel */
-	u8 			operation_ch[2];				/* 	Store the operation channel of invitation request frame */
-};
-
-struct wifidirect_info {
-	struct adapter				*padapter;
-	struct timer_list					find_phase_timer;
-	struct timer_list					restore_p2p_state_timer;
-
-	/* 	Used to do the scanning. After confirming the peer is availalble, the driver transmits the P2P frame to peer. */
-	struct timer_list					pre_tx_scan_timer;
-	struct timer_list					reset_ch_sitesurvey;
-	struct timer_list					reset_ch_sitesurvey2;	/* 	Just for resetting the scan limit function by using p2p nego */
-	struct tx_provdisc_req_info tx_prov_disc_info;
-	struct rx_provdisc_req_info rx_prov_disc_info;
-	struct tx_invite_req_info invitereq_info;
-	struct profile_info		profileinfo[P2P_MAX_PERSISTENT_GROUP_NUM];	/*	Store the profile information of persistent group */
-	struct tx_invite_resp_info inviteresp_info;
-	struct tx_nego_req_info nego_req_info;
-	struct group_id_info 	groupid_info;	/* 	Store the group id information when doing the group negotiation handshake. */
-	struct scan_limit_info 	rx_invitereq_info;	/* 	Used for get the limit scan channel from the Invitation procedure */
-	struct scan_limit_info 	p2p_info;		/* 	Used for get the limit scan channel from the P2P negotiation handshake */
-	enum p2p_role			role;
-	enum p2p_state			pre_p2p_state;
-	enum p2p_state			p2p_state;
-	u8 				device_addr[ETH_ALEN];	/* 	The device address should be the mac address of this device. */
-	u8 				interface_addr[ETH_ALEN];
-	u8 				social_chan[4];
-	u8 				listen_channel;
-	u8 				operating_channel;
-	u8 				listen_dwell;		/* 	This value should be between 1 and 3 */
-	u8 				support_rate[8];
-	u8 				p2p_wildcard_ssid[P2P_WILDCARD_SSID_LEN];
-	u8 				intent;		/* 	should only include the intent value. */
-	u8				p2p_peer_interface_addr[ETH_ALEN];
-	u8				p2p_peer_device_addr[ETH_ALEN];
-	u8 				peer_intent;	/* 	Included the intent value and tie breaker value. */
-	u8				device_name[WPS_MAX_DEVICE_NAME_LEN];	/*	Device name for displaying on searching device screen */
-	u8 				device_name_len;
-	u8 				profileindex;	/* 	Used to point to the index of profileinfo array */
-	u8 				peer_operating_ch;
-	u8 				find_phase_state_exchange_cnt;
-	u16 					device_password_id_for_nego;	/* 	The device password ID for group negotiation */
-	u8 				negotiation_dialog_token;
-	u8				nego_ssid[WLAN_SSID_MAXLEN];	/*	SSID information for group negotiation */
-	u8 				nego_ssidlen;
-	u8 				p2p_group_ssid[WLAN_SSID_MAXLEN];
-	u8 				p2p_group_ssid_len;
-	u8 				persistent_supported;		/* 	Flag to know the persistent function should be supported or not. */
-														/* 	In the Sigma test, the Sigma will provide this enable from the sta_set_p2p CAPI. */
-														/* 	0: disable */
-														/* 	1: enable */
-	u8 				session_available;			/* 	Flag to set the WFD session available to enable or disable "by Sigma" */
-														/* 	In the Sigma test, the Sigma will disable the session available by using the sta_preset CAPI. */
-														/* 	0: disable */
-														/* 	1: enable */
-
-	u8 				wfd_tdls_enable;			/* 	Flag to enable or disable the TDLS by WFD Sigma */
-														/* 	0: disable */
-														/* 	1: enable */
-	u8 				wfd_tdls_weaksec;			/* 	Flag to enable or disable the weak security function for TDLS by WFD Sigma */
-														/* 	0: disable */
-														/* 	In this case, the driver can't issue the tdsl setup request frame. */
-														/* 	1: enable */
-														/* 	In this case, the driver can issue the tdls setup request frame */
-														/* 	even the current security is weak security. */
-
-	enum	p2p_wpsinfo		ui_got_wps_info;			/* 	This field will store the WPS value (PIN value or PBC) that UI had got from the user. */
-	u16 					supported_wps_cm;			/* 	This field describes the WPS config method which this driver supported. */
-														/* 	The value should be the combination of config method defined in page104 of WPS v2.0 spec. */
-	u8 				external_uuid;				/*  UUID flag */
-	u8 				uuid[16];					/*  UUID */
-	uint						channel_list_attr_len;		/* 	This field will contain the length of body of P2P Channel List attribute of group negotitation response frame. */
-	u8 				channel_list_attr[100];		/* 	This field will contain the body of P2P Channel List attribute of group negotitation response frame. */
-														/* 	We will use the channel_cnt and channel_list fields when constructing the group negotitation confirm frame. */
-	u8 				driver_interface;			/* 	Indicate DRIVER_WEXT or DRIVER_CFG80211 */
-};
-
-struct tdls_ss_record {	/* signal strength record */
-	u8 macaddr[ETH_ALEN];
-	u8 rx_pwd_ba11;
-	u8 is_tdls_sta;	/*  true: direct link sta, false: else */
-};
-
 /* used for mlme_priv.roam_flags */
 enum {
 	RTW_ROAM_ON_EXPIRED = BIT0,
-- 
2.45.2


