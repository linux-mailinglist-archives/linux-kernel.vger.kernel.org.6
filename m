Return-Path: <linux-kernel+bounces-226366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEB2913D78
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5BB6B22180
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23084184106;
	Sun, 23 Jun 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvWEPkl2"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D3184101
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165449; cv=none; b=js5voZID8nm6+DloBf4K1TyH9RpdqHw4XH4eAojm7IcQmBJfRtyqpiRMVpnOsOIiehU9ple3B5Ygze/Rx6sUUsZ2Vi4cUMq0eToCk+xXIydhLdqZ5dp7tKviri/Lfk/L03AIssxC4jM0l8jqZjSYi/DrJNgOV7mdLmhjzFB9yHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165449; c=relaxed/simple;
	bh=ltnpviKeMUaGVhrUWPFxY2jebDlq6BnNyfcV9un9fnk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+/6bEXzWO2SM4ctQ53q+BZMSb9b1S+Mdxkc+/RXesHWjBvN5HSRcx+nAUXZYlBZKQCKsd4QAcCk669ltwQx4WnbSR4927H5S5Es44FSwVT4w67LuyRzRf//pbFeu4EnvwDByLWo0SXWPf2UV2q9YN7lqtdfHpj7qaDSzjApSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvWEPkl2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57cc310bca3so493208a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165446; x=1719770246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1vTbeSw9W7HSIQFs+9BiSn5ojSpE/rQVZOSqlwPo9I=;
        b=TvWEPkl26CELFLUiw/rAEt0sqeuzEjPfNz5l3bvcvQ3OjX0y2kvwc+TXxIsMs8Ssgz
         PSyHazZ2Ga4tF8WlOHZ/kD0nQxu+QV2/9iSfftGWiarTu2ytMygaya9gcMVyzIATIooy
         uk5ugHHBr6vlbbrJ+qJxbpGw3/a+/FPB9HLFnjfWHqe77ozsLZnqtEOrlcpsMUdRCRGW
         yNKktCAzZcim88sPpGd3TU5Y/B3aS+K2QBDttpLid7nFibcnRMVw5xoSkqWtSxLTlrak
         gZuAc8GqyhVWbmvDca0FiWjBtnrB2ZGx8VuaAdahXkh6lCNUS/GsNcat1uW8zVSMVn7/
         NdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165446; x=1719770246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1vTbeSw9W7HSIQFs+9BiSn5ojSpE/rQVZOSqlwPo9I=;
        b=PeCtyqvXWkpTPNC1+CR1wbY08oDrVjx/eldwvkO+G0c2h01h5u3fD830RAiVHE7lCB
         oGuCgMIaSxUWxeZvyw4IlDCjpNAvHra7D5a+IrAc9brI4Gs8WWZBP2B57BUN3+ZzpL3x
         rLJxqcj0dITFxQd7/OsyBS77iqhPBdPu1OYNk2ytKF/EpmwtUoHe5jD0nqVM9RVL69DC
         3VtrsV8QVhLBkAmAzdjU/KzDu3NIF6Hsjk5Z2SHZMZosieQSJXskobRM2CJuCKwKvtrI
         vRnMDLyPF7P6vbbYrVzPodUmH/pdR8BNS377vQOVbnXon9DrjvpNwdBHoE19xYzTt86R
         ySZg==
X-Forwarded-Encrypted: i=1; AJvYcCUoiadzxHCiYRjECkNXPMrkCViJjRQzJJclvJJJ6WnMmkoJMZWk4d5qDvgmdPalMFk6fbOxrfC91Obgeqn+B8btASRW5F21gEEXV/+e
X-Gm-Message-State: AOJu0YzQjNEeOER/HRJqFd2EAYXn7UIdwIKuZm8VoLEuv/jFBF9EtogQ
	cGUgoJt0TJSONTLuc4OattDoYeLQmJWxq3ysu8PgNEaChBj8wAAA
X-Google-Smtp-Source: AGHT+IFuD8nz40RMqkzYJCfxTE68PfV3pHMIdzh7Ep55xtIPlx+Citggle90AtKKROXdK/6gMWF4UQ==
X-Received: by 2002:a17:906:37c8:b0:a6f:aba1:ae34 with SMTP id a640c23a62f3a-a6fe76b5db1mr232009466b.2.1719165446140;
        Sun, 23 Jun 2024 10:57:26 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7252a1a659sm42920166b.58.2024.06.23.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:57:25 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:57:24 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] staging: rtl8723bs: Remove unused macros in wifi.h
Message-ID: <26af5a910e84523d9040ee29967c9b3a4971daa5.1719155208.git.philipp.g.hortmann@gmail.com>
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

Remove unused macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/wifi.h | 299 -----------------------
 1 file changed, 299 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 53f9411fcc4c..230b2c4ffd3b 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -7,30 +7,11 @@
 #ifndef _WIFI_H_
 #define _WIFI_H_
 
-#define WLAN_ETHHDR_LEN		14
-#define WLAN_ETHADDR_LEN	6
-#define WLAN_IEEE_OUI_LEN	3
-#define WLAN_ADDR_LEN		6
-#define WLAN_CRC_LEN		4
-#define WLAN_BSSID_LEN		6
-#define WLAN_BSS_TS_LEN		8
 #define WLAN_HDR_A3_LEN		24
-#define WLAN_HDR_A4_LEN		30
 #define WLAN_HDR_A3_QOS_LEN	26
-#define WLAN_HDR_A4_QOS_LEN	32
-#define WLAN_SSID_MAXLEN	32
-#define WLAN_DATA_MAXLEN	2312
 
-#define WLAN_A3_PN_OFFSET	24
-#define WLAN_A4_PN_OFFSET	30
-
-#define WLAN_MIN_ETHFRM_LEN	60
-#define WLAN_MAX_ETHFRM_LEN	1514
-#define WLAN_ETHHDR_LEN		14
 #define WLAN_WMM_LEN		24
 
-#define P80211CAPTURE_VERSION	0x80211001
-
 /*  This value is tested by WiFi 11n Test Plan 5.2.3. */
 /*  This test verifies the WLAN NIC can update the NAV through sending the CTS with large duration. */
 #define	WiFiNavUpperUs				30000	/*  30 ms */
@@ -164,9 +145,6 @@ enum {
 #define GetFragNum(pbuf)			\
 	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 22)) & 0x0f)
 
-#define GetTupleCache(pbuf)			\
-	(cpu_to_le16(*(unsigned short *)((size_t)(pbuf) + 22)))
-
 #define SetFragNum(pbuf, num) \
 	do {    \
 		*(unsigned short *)((size_t)(pbuf) + 22) = \
@@ -305,27 +283,13 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 /*-----------------------------------------------------------------------------
 			Below is for the security related definition
 ------------------------------------------------------------------------------*/
-#define _RESERVED_FRAME_TYPE_	0
-#define _SKB_FRAME_TYPE_		2
-#define _PRE_ALLOCMEM_			1
-#define _PRE_ALLOCHDR_			3
-#define _PRE_ALLOCLLCHDR_		4
-#define _PRE_ALLOCICVHDR_		5
-#define _PRE_ALLOCMICHDR_		6
-
-#define _ACKCTSLNG_				14	/* 14 bytes long, including crclng */
-#define _CRCLNG_				4
 
 #define _ASOCREQ_IE_OFFSET_		4	/*  excluding wlan_hdr */
-#define	_ASOCRSP_IE_OFFSET_		6
 #define _REASOCREQ_IE_OFFSET_	10
-#define _REASOCRSP_IE_OFFSET_	6
 #define _PROBEREQ_IE_OFFSET_	0
 #define	_PROBERSP_IE_OFFSET_	12
 #define _AUTH_IE_OFFSET_		6
-#define _DEAUTH_IE_OFFSET_		0
 #define _BEACON_IE_OFFSET_		12
-#define _PUBLIC_ACTION_IE_OFFSET_	8
 
 #define _FIXED_IE_LENGTH_			_BEACON_IE_OFFSET_
 
@@ -336,20 +300,11 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 #define _AUTH_SEQ_NUM_			2
 #define _BEACON_ITERVAL_		2
 #define _CAPABILITY_			2
-#define _CURRENT_APADDR_		6
-#define _LISTEN_INTERVAL_		2
 #define _RSON_CODE_				2
 #define _ASOC_ID_				2
 #define _STATUS_CODE_			2
 #define _TIMESTAMP_				8
 
-#define AUTH_ODD_TO				0
-#define AUTH_EVEN_TO			1
-
-#define WLAN_ETHCONV_ENCAP		1
-#define WLAN_ETHCONV_RFC1042	2
-#define WLAN_ETHCONV_8021h		3
-
 /*-----------------------------------------------------------------------------
 				Below is the definition for 802.11i / 802.1x
 ------------------------------------------------------------------------------*/
@@ -361,18 +316,10 @@ static inline int IsFrameTypeCtrl(unsigned char *pframe)
 				Below is the definition for WMM
 ------------------------------------------------------------------------------*/
 #define _WMM_IE_Length_				7  /*  for WMM STA */
-#define _WMM_Para_Element_Length_		24
-
 
 /*-----------------------------------------------------------------------------
 				Below is the definition for 802.11n
 ------------------------------------------------------------------------------*/
-
-#define SetOrderBit(pbuf)	\
-	do	{	\
-		*(unsigned short *)(pbuf) |= cpu_to_le16(_ORDER_); \
-	} while (0)
-
 #define GetOrderBit(pbuf)	(((*(unsigned short *)(pbuf)) & cpu_to_le16(_ORDER_)) != 0)
 
 #define ACT_CAT_VENDOR				0x7F/* 127 */
@@ -440,244 +387,20 @@ struct ADDBA_request {
 #define IEEE80211_HT_CAP_SGI_40			0x0040
 #define IEEE80211_HT_CAP_TX_STBC			0x0080
 #define IEEE80211_HT_CAP_RX_STBC_1R		0x0100
-#define IEEE80211_HT_CAP_RX_STBC_2R		0x0200
 #define IEEE80211_HT_CAP_RX_STBC_3R		0x0300
-#define IEEE80211_HT_CAP_DELAY_BA		0x0400
 #define IEEE80211_HT_CAP_MAX_AMSDU		0x0800
 #define IEEE80211_HT_CAP_DSSSCCK40		0x1000
 /* 802.11n HT capability AMPDU settings */
 #define IEEE80211_HT_CAP_AMPDU_FACTOR		0x03
 #define IEEE80211_HT_CAP_AMPDU_DENSITY		0x1C
-/* 802.11n HT capability MSC set */
-#define IEEE80211_SUPP_MCS_SET_UEQM		4
-#define IEEE80211_HT_CAP_MAX_STREAMS		4
-#define IEEE80211_SUPP_MCS_SET_LEN		10
-/* maximum streams the spec allows */
-#define IEEE80211_HT_CAP_MCS_TX_DEFINED		0x01
-#define IEEE80211_HT_CAP_MCS_TX_RX_DIFF		0x02
-#define IEEE80211_HT_CAP_MCS_TX_STREAMS		0x0C
-#define IEEE80211_HT_CAP_MCS_TX_UEQM		0x10
-/* 802.11n HT capability TXBF capability */
-#define IEEE80211_HT_CAP_TXBF_RX_NDP		0x00000008
-#define IEEE80211_HT_CAP_TXBF_TX_NDP		0x00000010
-#define IEEE80211_HT_CAP_TXBF_EXPLICIT_COMP_STEERING_CAP	0x00000400
 
 /* endif */
 
 /* 	===============WPS Section =============== */
-/* 	For WPSv1.0 */
-#define WPSOUI							0x0050f204
 /* 	WPS attribute ID */
-#define WPS_ATTR_VER1					0x104A
-#define WPS_ATTR_SIMPLE_CONF_STATE	0x1044
-#define WPS_ATTR_RESP_TYPE			0x103B
-#define WPS_ATTR_UUID_E				0x1047
-#define WPS_ATTR_MANUFACTURER		0x1021
-#define WPS_ATTR_MODEL_NAME			0x1023
-#define WPS_ATTR_MODEL_NUMBER		0x1024
-#define WPS_ATTR_SERIAL_NUMBER		0x1042
-#define WPS_ATTR_PRIMARY_DEV_TYPE	0x1054
-#define WPS_ATTR_SEC_DEV_TYPE_LIST	0x1055
-#define WPS_ATTR_DEVICE_NAME			0x1011
-#define WPS_ATTR_CONF_METHOD			0x1008
-#define WPS_ATTR_RF_BANDS				0x103C
-#define WPS_ATTR_DEVICE_PWID			0x1012
-#define WPS_ATTR_REQUEST_TYPE			0x103A
-#define WPS_ATTR_ASSOCIATION_STATE	0x1002
-#define WPS_ATTR_CONFIG_ERROR			0x1009
-#define WPS_ATTR_VENDOR_EXT			0x1049
 #define WPS_ATTR_SELECTED_REGISTRAR	0x1041
 
-/* 	Value of WPS attribute "WPS_ATTR_DEVICE_NAME */
-#define WPS_MAX_DEVICE_NAME_LEN		32
-
-/* 	Value of WPS Request Type Attribute */
-#define WPS_REQ_TYPE_ENROLLEE_INFO_ONLY			0x00
-#define WPS_REQ_TYPE_ENROLLEE_OPEN_8021X		0x01
-#define WPS_REQ_TYPE_REGISTRAR					0x02
-#define WPS_REQ_TYPE_WLAN_MANAGER_REGISTRAR	0x03
-
-/* 	Value of WPS Response Type Attribute */
-#define WPS_RESPONSE_TYPE_INFO_ONLY	0x00
-#define WPS_RESPONSE_TYPE_8021X		0x01
-#define WPS_RESPONSE_TYPE_REGISTRAR	0x02
-#define WPS_RESPONSE_TYPE_AP			0x03
-
-/* 	Value of WPS WiFi Simple Configuration State Attribute */
-#define WPS_WSC_STATE_NOT_CONFIG	0x01
-#define WPS_WSC_STATE_CONFIG			0x02
-
-/* 	Value of WPS Version Attribute */
-#define WPS_VERSION_1					0x10
-
-/* 	Value of WPS Configuration Method Attribute */
-#define WPS_CONFIG_METHOD_FLASH		0x0001
-#define WPS_CONFIG_METHOD_ETHERNET	0x0002
-#define WPS_CONFIG_METHOD_LABEL		0x0004
-#define WPS_CONFIG_METHOD_DISPLAY	0x0008
-#define WPS_CONFIG_METHOD_E_NFC		0x0010
-#define WPS_CONFIG_METHOD_I_NFC		0x0020
-#define WPS_CONFIG_METHOD_NFC		0x0040
-#define WPS_CONFIG_METHOD_PBC		0x0080
-#define WPS_CONFIG_METHOD_KEYPAD	0x0100
-#define WPS_CONFIG_METHOD_VPBC		0x0280
-#define WPS_CONFIG_METHOD_PPBC		0x0480
-#define WPS_CONFIG_METHOD_VDISPLAY	0x2008
-#define WPS_CONFIG_METHOD_PDISPLAY	0x4008
-
-/* 	Value of Category ID of WPS Primary Device Type Attribute */
-#define WPS_PDT_CID_DISPLAYS			0x0007
-#define WPS_PDT_CID_MULIT_MEDIA		0x0008
-#define WPS_PDT_CID_RTK_WIDI			WPS_PDT_CID_MULIT_MEDIA
-
-/* 	Value of Sub Category ID of WPS Primary Device Type Attribute */
-#define WPS_PDT_SCID_MEDIA_SERVER	0x0005
-#define WPS_PDT_SCID_RTK_DMP			WPS_PDT_SCID_MEDIA_SERVER
-
-/* 	Value of Device Password ID */
-#define WPS_DPID_PIN					0x0000
-#define WPS_DPID_USER_SPEC			0x0001
-#define WPS_DPID_MACHINE_SPEC			0x0002
-#define WPS_DPID_REKEY					0x0003
-#define WPS_DPID_PBC					0x0004
-#define WPS_DPID_REGISTRAR_SPEC		0x0005
-
-/* 	Value of WPS RF Bands Attribute */
-#define WPS_RF_BANDS_2_4_GHZ		0x01
-#define WPS_RF_BANDS_5_GHZ		0x02
-
-/* 	Value of WPS Association State Attribute */
-#define WPS_ASSOC_STATE_NOT_ASSOCIATED			0x00
-#define WPS_ASSOC_STATE_CONNECTION_SUCCESS		0x01
-#define WPS_ASSOC_STATE_CONFIGURATION_FAILURE	0x02
-#define WPS_ASSOC_STATE_ASSOCIATION_FAILURE		0x03
-#define WPS_ASSOC_STATE_IP_FAILURE				0x04
-
 /* 	=====================P2P Section ===================== */
-/* 	For P2P */
-#define	P2POUI							0x506F9A09
-
-/* 	P2P Attribute ID */
-#define	P2P_ATTR_STATUS					0x00
-#define	P2P_ATTR_MINOR_REASON_CODE		0x01
-#define	P2P_ATTR_CAPABILITY				0x02
-#define	P2P_ATTR_DEVICE_ID				0x03
-#define	P2P_ATTR_GO_INTENT				0x04
-#define	P2P_ATTR_CONF_TIMEOUT			0x05
-#define	P2P_ATTR_LISTEN_CH				0x06
-#define	P2P_ATTR_GROUP_BSSID				0x07
-#define	P2P_ATTR_EX_LISTEN_TIMING		0x08
-#define	P2P_ATTR_INTENTED_IF_ADDR		0x09
-#define	P2P_ATTR_MANAGEABILITY			0x0A
-#define	P2P_ATTR_CH_LIST					0x0B
-#define	P2P_ATTR_NOA						0x0C
-#define	P2P_ATTR_DEVICE_INFO				0x0D
-#define	P2P_ATTR_GROUP_INFO				0x0E
-#define	P2P_ATTR_GROUP_ID					0x0F
-#define	P2P_ATTR_INTERFACE				0x10
-#define	P2P_ATTR_OPERATING_CH			0x11
-#define	P2P_ATTR_INVITATION_FLAGS		0x12
-
-/* 	Value of Status Attribute */
-#define	P2P_STATUS_SUCCESS						0x00
-#define	P2P_STATUS_FAIL_INFO_UNAVAILABLE		0x01
-#define	P2P_STATUS_FAIL_INCOMPATIBLE_PARAM		0x02
-#define	P2P_STATUS_FAIL_LIMIT_REACHED			0x03
-#define	P2P_STATUS_FAIL_INVALID_PARAM			0x04
-#define	P2P_STATUS_FAIL_REQUEST_UNABLE			0x05
-#define	P2P_STATUS_FAIL_PREVOUS_PROTO_ERR		0x06
-#define	P2P_STATUS_FAIL_NO_COMMON_CH			0x07
-#define	P2P_STATUS_FAIL_UNKNOWN_P2PGROUP		0x08
-#define	P2P_STATUS_FAIL_BOTH_GOINTENT_15		0x09
-#define	P2P_STATUS_FAIL_INCOMPATIBLE_PROVSION	0x0A
-#define	P2P_STATUS_FAIL_USER_REJECT				0x0B
-
-/* 	Value of Invitation Flags Attribute */
-#define	P2P_INVITATION_FLAGS_PERSISTENT			BIT(0)
-
-#define	DMP_P2P_DEVCAP_SUPPORT	(P2P_DEVCAP_SERVICE_DISCOVERY | \
-									P2P_DEVCAP_CLIENT_DISCOVERABILITY | \
-									P2P_DEVCAP_CONCURRENT_OPERATION | \
-									P2P_DEVCAP_INVITATION_PROC)
-
-#define	DMP_P2P_GRPCAP_SUPPORT	(P2P_GRPCAP_INTRABSS)
-
-/* 	Value of Device Capability Bitmap */
-#define	P2P_DEVCAP_SERVICE_DISCOVERY		BIT(0)
-#define	P2P_DEVCAP_CLIENT_DISCOVERABILITY	BIT(1)
-#define	P2P_DEVCAP_CONCURRENT_OPERATION	BIT(2)
-#define	P2P_DEVCAP_INFRA_MANAGED			BIT(3)
-#define	P2P_DEVCAP_DEVICE_LIMIT				BIT(4)
-#define	P2P_DEVCAP_INVITATION_PROC			BIT(5)
-
-/* 	Value of Group Capability Bitmap */
-#define	P2P_GRPCAP_GO							BIT(0)
-#define	P2P_GRPCAP_PERSISTENT_GROUP			BIT(1)
-#define	P2P_GRPCAP_GROUP_LIMIT				BIT(2)
-#define	P2P_GRPCAP_INTRABSS					BIT(3)
-#define	P2P_GRPCAP_CROSS_CONN				BIT(4)
-#define	P2P_GRPCAP_PERSISTENT_RECONN		BIT(5)
-#define	P2P_GRPCAP_GROUP_FORMATION			BIT(6)
-
-/* 	P2P Public Action Frame (Management Frame) */
-#define	P2P_PUB_ACTION_ACTION				0x09
-
-/* 	P2P Public Action Frame Type */
-#define	P2P_GO_NEGO_REQ						0
-#define	P2P_GO_NEGO_RESP						1
-#define	P2P_GO_NEGO_CONF						2
-#define	P2P_INVIT_REQ							3
-#define	P2P_INVIT_RESP							4
-#define	P2P_DEVDISC_REQ						5
-#define	P2P_DEVDISC_RESP						6
-#define	P2P_PROVISION_DISC_REQ				7
-#define	P2P_PROVISION_DISC_RESP				8
-
-/* 	P2P Action Frame Type */
-#define	P2P_NOTICE_OF_ABSENCE	0
-#define	P2P_PRESENCE_REQUEST		1
-#define	P2P_PRESENCE_RESPONSE	2
-#define	P2P_GO_DISC_REQUEST		3
-
-
-#define	P2P_MAX_PERSISTENT_GROUP_NUM		10
-
-#define	P2P_PROVISIONING_SCAN_CNT			3
-
-#define	P2P_WILDCARD_SSID_LEN				7
-
-#define	P2P_FINDPHASE_EX_NONE				0	/*  default value, used when: (1)p2p disabled or (2)p2p enabled but only do 1 scan phase */
-#define	P2P_FINDPHASE_EX_FULL				1	/*  used when p2p enabled and want to do 1 scan phase and P2P_FINDPHASE_EX_MAX-1 find phase */
-#define	P2P_FINDPHASE_EX_SOCIAL_FIRST		(P2P_FINDPHASE_EX_FULL+1)
-#define	P2P_FINDPHASE_EX_MAX					4
-#define	P2P_FINDPHASE_EX_SOCIAL_LAST		P2P_FINDPHASE_EX_MAX
-
-#define	P2P_PROVISION_TIMEOUT				5000	/* 	5 seconds timeout for sending the provision discovery request */
-#define	P2P_CONCURRENT_PROVISION_TIMEOUT	3000	/* 	3 seconds timeout for sending the provision discovery request under concurrent mode */
-#define	P2P_GO_NEGO_TIMEOUT					5000	/* 	5 seconds timeout for receiving the group negotiation response */
-#define	P2P_CONCURRENT_GO_NEGO_TIMEOUT		3000	/* 	3 seconds timeout for sending the negotiation request under concurrent mode */
-#define	P2P_TX_PRESCAN_TIMEOUT				100		/* 	100ms */
-#define	P2P_INVITE_TIMEOUT					5000	/* 	5 seconds timeout for sending the invitation request */
-#define	P2P_CONCURRENT_INVITE_TIMEOUT		3000	/* 	3 seconds timeout for sending the invitation request under concurrent mode */
-#define	P2P_RESET_SCAN_CH						25000	/* 	25 seconds timeout to reset the scan channel (based on channel plan) */
-#define	P2P_MAX_INTENT						15
-
-#define	P2P_MAX_NOA_NUM						2
-
-/* 	WPS Configuration Method */
-#define	WPS_CM_NONE							0x0000
-#define	WPS_CM_LABEL							0x0004
-#define	WPS_CM_DISPLYA						0x0008
-#define	WPS_CM_EXTERNAL_NFC_TOKEN			0x0010
-#define	WPS_CM_INTEGRATED_NFC_TOKEN		0x0020
-#define	WPS_CM_NFC_INTERFACE					0x0040
-#define	WPS_CM_PUSH_BUTTON					0x0080
-#define	WPS_CM_KEYPAD						0x0100
-#define	WPS_CM_SW_PUHS_BUTTON				0x0280
-#define	WPS_CM_HW_PUHS_BUTTON				0x0480
-#define	WPS_CM_SW_DISPLAY_PIN				0x2008
-#define	WPS_CM_LCD_DISPLAY_PIN				0x4008
-
 enum p2p_role {
 	P2P_ROLE_DISABLE = 0,
 	P2P_ROLE_DEVICE = 1,
@@ -718,28 +441,6 @@ enum p2p_wpsinfo {
 	P2P_GOT_WPSINFO_PBC					= 3,
 };
 
-#define	P2P_PRIVATE_IOCTL_SET_LEN		64
-
-/* 	=====================WFD Section ===================== */
-/* 	For Wi-Fi Display */
-#define	WFD_ATTR_DEVICE_INFO			0x00
-#define	WFD_ATTR_ASSOC_BSSID			0x01
-#define	WFD_ATTR_COUPLED_SINK_INFO	0x06
-#define	WFD_ATTR_LOCAL_IP_ADDR		0x08
-#define	WFD_ATTR_SESSION_INFO		0x09
-#define	WFD_ATTR_ALTER_MAC			0x0a
-
-/* 	For WFD Device Information Attribute */
-#define	WFD_DEVINFO_SOURCE					0x0000
-#define	WFD_DEVINFO_PSINK					0x0001
-#define	WFD_DEVINFO_SSINK					0x0002
-#define	WFD_DEVINFO_DUAL					0x0003
-
-#define	WFD_DEVINFO_SESSION_AVAIL			0x0010
-#define	WFD_DEVINFO_WSD						0x0040
-#define	WFD_DEVINFO_PC_TDLS					0x0080
-#define	WFD_DEVINFO_HDCP_SUPPORT			0x0100
-
 #define IP_MCAST_MAC(mac)		((mac[0] == 0x01) && (mac[1] == 0x00) && (mac[2] == 0x5e))
 #define ICMPV6_MCAST_MAC(mac)	((mac[0] == 0x33) && (mac[1] == 0x33) && (mac[2] != 0xff))
 
-- 
2.45.2


