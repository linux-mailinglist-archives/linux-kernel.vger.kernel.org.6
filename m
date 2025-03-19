Return-Path: <linux-kernel+bounces-567858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D18A68B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFC616ADC2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE2525A2C2;
	Wed, 19 Mar 2025 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0Lg8GYV"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84225A2BC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382655; cv=none; b=UV/2fxPUwNNLv/o0P3etVssKXk1dKi069BIdOpGilx2clACljgpQQac0MGTTIHLIUZZP9e9cZun3em8AXneeqM3ADQK4KRCjbAnnpcvdxGVSwKJqvc4waqtokRyTtOsAdfYkDGuR9G0wDFYPHVewcawPFQrGtYBs7kARk1z/Jc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382655; c=relaxed/simple;
	bh=DuCRhfvY1YWAlcegeb2xSNc/frHOXvyRWj9TuE87/Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EyD/eO+IN3qRemJW++sGFRExl864VKVHrWRmi0C1+WvHpkdYf9ekemObLxkujyd4YJzPryDIcKCPHtx03YAIj8ensD8wxw42xqDiy2ADplYe4s8ID1U27zJ0xA19ymvZW+Ff9EWGOSC5bRr8rb/mkGR1TDvw0KLnbOpvw2H2DKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0Lg8GYV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0782d787so30592645e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742382651; x=1742987451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEqsHasWuQ53hJKWtja1pTPO3NrgTSuGn7P0x/RZWWg=;
        b=j0Lg8GYVYoqh8jfarPrJwAiL1h8U4cyNi2aEnOreA9ECSas0FRsZP14EnngrUsJWsL
         n/yHMOjWbueYk4k7ZRwGAa7PsAlcE7w/fWM6KxJrwVpkAv5kck+BC/GbIdl3EBNtmdGG
         B8HXrKc8wubPnDo462JGKHEZjkWpw09ZpPoBKjGkmfwF3OitPZQ8Gjl9wEjBIEdkUhao
         ucOba2X9zMEP4I1062C4prEsbgv41gxRhK5vfLVr1mFgthtU4KTzJmfUwBgMstjskxiR
         xVZEhw4/B6uXmD9YQ3rTniD0iLrTk372127LJXX3AHQwRiY64yWhhyaSmUUUrLU1KSfw
         4MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742382651; x=1742987451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEqsHasWuQ53hJKWtja1pTPO3NrgTSuGn7P0x/RZWWg=;
        b=gt5Tpz/sl2n9QpEZN1K4TA+zliF0PU50RyhjfbmSt8mFKelC+lYT4yYoflicHD3wGW
         IRCpUwPTf2x1drrfCYWfmRODZst/Z5ATmuzhjLMv/iWEkxe2B3M+mMzAaERMoMCujWE1
         HqDJVTO6nxoq123qaFw5kM6E1kSbTH1bcZYuUNlnzEkQIp1MtMwTcnURBQgQcjNBLrL8
         cnIAZO48dTQef9quf2IS+j4xdFdBtj0gDWDLQ4xZX++lQ1H8Nv1Sfmt7UKW134I7wv3F
         80vAZl24onX8RaR6D7FaSHlEZksgvnHehBrYAqGtz/0agEnjft3ej4jCmcmMHzL+bBlY
         ojsg==
X-Forwarded-Encrypted: i=1; AJvYcCWjLnopHUJpnBza4AHxtkap87ByiKYeWoJ6Ca9+gHe21J3waC8GoBCtkQ66V8EVtpk4/LqytlIKJSXcfEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0uLRAJLdVsgts0TT06LykBB+5BENrnHRvR5eArV9XrefmOj1
	ggvS9Oj3S/t9ESRn4nw9aELFrIGtYulhS7Pq6ArPywJz9OkVvw+W5u0h5uKh
X-Gm-Gg: ASbGncsG7v+7jTutzfQQEpY9odBmTT1j3C30LP7UK6q84441GJeGFR8KxOIYFJuXnUL
	gOECWyUJv384p6PBsE3J3gPqn/AJtHrE3wB05hHY5NGWqU2B7SDfFy+mc/o0+ffeQvgoeAsShLH
	77HgAUMD2rz+vB+sO9fWbEbYJyXrSe8XrQSBseMiF+gH0twgJLi3Lf/r+T7dAs8D3rRUTBYpQxN
	fA5LSB1ThvhOW0E0Yls7RPVhPUwTYkR6P9UiCFdTwcjU9UEbOSa6PAMSHx1PzElDJCT2088wKNc
	OtVrWR7h2FeHZHq9CLJyZzhXVcHvUymGucKcb+IOLoVovYQ4F3wp5p6uJmw4CbfVDbuFqyxlCw=
	=
X-Google-Smtp-Source: AGHT+IHDT/p/3j+bWc722lk+UMK/0hxzdn0fzyby6MFzE7vnohTsH7ooXbuzUm1mBdUhwujdIXj5oQ==
X-Received: by 2002:a05:600c:c1b:b0:43c:fad6:fa5a with SMTP id 5b1f17b1804b1-43d4381617dmr18101475e9.24.1742382650623;
        Wed, 19 Mar 2025 04:10:50 -0700 (PDT)
Received: from localhost.localdomain ([5.29.19.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8e43244sm21156411f8f.60.2025.03.19.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:10:50 -0700 (PDT)
From: David Zalman <davidzalman.101@gmail.com>
To: gregkh@linuxfoundation.org
Cc: vivek6429.ts@gmail.com,
	philipp.g.hortmann@gmail.com,
	viro@zeniv.linux.org.uk,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Zalman <davidzalman.101@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fixed a unnecessary parentheses coding style issue
Date: Wed, 19 Mar 2025 07:10:12 -0400
Message-Id: <20250319111012.1588-1-davidzalman.101@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary parentheses around derefrened pointers in
core/rtw_ap.c to adapter to the Linux kernel coding style.

Reported by checkpatch:

CHECK: Unnecessary parentheses around x->y

Signed-off-by: David Zalman <davidzalman.101@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 96 ++++++++++++-------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index a6dc88dd4ba1..50022bb5911e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -324,7 +324,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 {
 	unsigned char sta_band = 0, shortGIrate = false;
 	unsigned int tx_ra_bitmap = 0;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex
 		*pcur_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
 
@@ -372,9 +372,9 @@ void update_bmc_sta(struct adapter *padapter)
 	unsigned char network_type;
 	int supportRateNum = 0;
 	unsigned int tx_ra_bitmap = 0;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex
 		*pcur_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
 	struct sta_info *psta = rtw_get_bcmc_stainfo(padapter);
@@ -451,9 +451,9 @@ void update_bmc_sta(struct adapter *padapter)
 
 void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct ht_priv *phtpriv_ap = &pmlmepriv->htpriv;
 	struct ht_priv *phtpriv_sta = &psta->htpriv;
 	u8 cur_ldpc_cap = 0, cur_stbc_cap = 0, cur_beamform_cap = 0;
@@ -563,10 +563,10 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 
 static void update_ap_info(struct adapter *padapter, struct sta_info *psta)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex
 		*pnetwork = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct ht_priv *phtpriv_ap = &pmlmepriv->htpriv;
 
 	psta->wireless_mode = pmlmeext->cur_wireless_mode;
@@ -609,7 +609,7 @@ static void update_hw_ht_param(struct adapter *padapter)
 	unsigned char max_AMPDU_len;
 	unsigned char min_MPDU_spacing;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	/* handle A-MPDU parameter field
 	 *
@@ -645,13 +645,13 @@ void start_bss_network(struct adapter *padapter)
 	u32 acparm;
 	int	ie_len;
 	struct registry_priv  *pregpriv = &padapter->registrypriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct security_priv *psecuritypriv = &(padapter->securitypriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct wlan_bssid_ex
 		*pnetwork = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork_mlmeext = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork_mlmeext = &pmlmeinfo->network;
 	struct HT_info_element *pht_info = NULL;
 	u8 cbw40_enable = 0;
 
@@ -823,7 +823,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	u8 WMM_PARA_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex
 		*pbss_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
 	u8 *ie = pbss_network->ies;
@@ -845,7 +845,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 	pbss_network->rssi = 0;
 
-	memcpy(pbss_network->mac_address, myid(&(padapter->eeprompriv)), ETH_ALEN);
+	memcpy(pbss_network->mac_address, myid(&padapter->eeprompriv), ETH_ALEN);
 
 	/* beacon interval */
 	p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, 2: Beacon Interval 2:Capability */
@@ -1186,7 +1186,7 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 	if ((NUM_ACL - 1) < pacl_list->num)
 		return (-1);
 
-	spin_lock_bh(&(pacl_node_q->lock));
+	spin_lock_bh(&pacl_node_q->lock);
 
 	phead = get_list_head(pacl_node_q);
 	list_for_each(plist, phead) {
@@ -1200,12 +1200,12 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 		}
 	}
 
-	spin_unlock_bh(&(pacl_node_q->lock));
+	spin_unlock_bh(&pacl_node_q->lock);
 
 	if (added)
 		return ret;
 
-	spin_lock_bh(&(pacl_node_q->lock));
+	spin_lock_bh(&pacl_node_q->lock);
 
 	for (i = 0; i < NUM_ACL; i++) {
 		paclnode = &pacl_list->aclnode[i];
@@ -1225,7 +1225,7 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 		}
 	}
 
-	spin_unlock_bh(&(pacl_node_q->lock));
+	spin_unlock_bh(&pacl_node_q->lock);
 
 	return ret;
 }
@@ -1238,7 +1238,7 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 	struct __queue	*pacl_node_q = &pacl_list->acl_node_q;
 
-	spin_lock_bh(&(pacl_node_q->lock));
+	spin_lock_bh(&pacl_node_q->lock);
 
 	phead = get_list_head(pacl_node_q);
 	list_for_each_safe(plist, tmp, phead) {
@@ -1258,7 +1258,7 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 		}
 	}
 
-	spin_unlock_bh(&(pacl_node_q->lock));
+	spin_unlock_bh(&pacl_node_q->lock);
 
 }
 
@@ -1308,7 +1308,7 @@ static int rtw_ap_set_key(
 	u8 keylen;
 	struct cmd_obj *pcmd;
 	struct setkey_parm *psetkeyparm;
-	struct cmd_priv *pcmdpriv = &(padapter->cmdpriv);
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	int res = _SUCCESS;
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
@@ -1345,7 +1345,7 @@ static int rtw_ap_set_key(
 		keylen = 16;
 	}
 
-	memcpy(&(psetkeyparm->key[0]), key, keylen);
+	memcpy(&psetkeyparm->key[0], key, keylen);
 
 	pcmd->cmdcode = _SetKey_CMD_;
 	pcmd->parmbuf = (u8 *)psetkeyparm;
@@ -1397,10 +1397,10 @@ static void update_bcn_fixed_ie(struct adapter *padapter)
 
 static void update_bcn_erpinfo_ie(struct adapter *padapter)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	unsigned char *p, *ie = pnetwork->ies;
 	u32 len = 0;
 
@@ -1461,10 +1461,10 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	u8 *pbackup_remainder_ie = NULL;
 
 	uint wps_ielen = 0, wps_offset, remainder_ielen;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	unsigned char *ie = pnetwork->ies;
 	u32 ielen = pnetwork->ie_length;
 
@@ -1537,8 +1537,8 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 	if (!padapter)
 		return;
 
-	pmlmepriv = &(padapter->mlmepriv);
-	pmlmeext = &(padapter->mlmeextpriv);
+	pmlmepriv = &padapter->mlmepriv;
+	pmlmeext = &padapter->mlmeextpriv;
 	/* pmlmeinfo = &(pmlmeext->mlmext_info); */
 
 	if (!pmlmeext->bstart_bss)
@@ -1619,7 +1619,7 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 {
 	u16 cur_op_mode, new_op_mode;
 	int op_mode_changes = 0;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv *phtpriv_ap = &pmlmepriv->htpriv;
 
 	if (pmlmepriv->htpriv.ht_option)
@@ -1703,8 +1703,8 @@ void associated_clients_update(struct adapter *padapter, u8 updated)
 void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 {
 	u8 beacon_updated = false;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	if (!(psta->flags & WLAN_STA_SHORT_PREAMBLE)) {
 		if (!psta->no_short_preamble_set) {
@@ -1823,8 +1823,8 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 {
 	u8 beacon_updated = false;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	if (!psta)
 		return beacon_updated;
@@ -1932,7 +1932,7 @@ void rtw_sta_flush(struct adapter *padapter)
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
@@ -1962,7 +1962,7 @@ void rtw_sta_flush(struct adapter *padapter)
 void sta_info_update(struct adapter *padapter, struct sta_info *psta)
 {
 	int flags = psta->flags;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	/* update wmm cap. */
 	if (WLAN_STA_WME & flags)
@@ -1991,7 +1991,7 @@ void sta_info_update(struct adapter *padapter, struct sta_info *psta)
 void ap_sta_info_defer_update(struct adapter *padapter, struct sta_info *psta)
 {
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (psta->state & _FW_LINKED) {
 		pmlmeinfo->FW_sta_info[psta->mac_id].psta = psta;
@@ -2006,7 +2006,7 @@ void rtw_ap_restore_network(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct sta_info *psta;
-	struct security_priv *psecuritypriv = &(padapter->securitypriv);
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct list_head	*phead, *plist;
 	u8 chk_alive_num = 0;
 	char chk_alive_list[NUM_STA];
@@ -2072,7 +2072,7 @@ void rtw_ap_restore_network(struct adapter *padapter)
 void start_ap_mode(struct adapter *padapter)
 {
 	int i;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
@@ -2109,7 +2109,7 @@ void start_ap_mode(struct adapter *padapter)
 	pmlmepriv->p2p_probe_resp_ie = NULL;
 
 	/* for ACL */
-	INIT_LIST_HEAD(&(pacl_list->acl_node_q.queue));
+	INIT_LIST_HEAD(&pacl_list->acl_node_q.queue);
 	pacl_list->num = 0;
 	pacl_list->mode = 0;
 	for (i = 0; i < NUM_ACL; i++) {
@@ -2124,7 +2124,7 @@ void stop_ap_mode(struct adapter *padapter)
 	struct rtw_wlan_acl_node *paclnode;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 	struct __queue	*pacl_node_q = &pacl_list->acl_node_q;
@@ -2142,7 +2142,7 @@ void stop_ap_mode(struct adapter *padapter)
 	padapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
 
 	/* for ACL */
-	spin_lock_bh(&(pacl_node_q->lock));
+	spin_lock_bh(&pacl_node_q->lock);
 	phead = get_list_head(pacl_node_q);
 	list_for_each_safe(plist, tmp, phead) {
 		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
@@ -2155,7 +2155,7 @@ void stop_ap_mode(struct adapter *padapter)
 			pacl_list->num--;
 		}
 	}
-	spin_unlock_bh(&(pacl_node_q->lock));
+	spin_unlock_bh(&pacl_node_q->lock);
 
 	rtw_sta_flush(padapter);
 
-- 
2.39.5


