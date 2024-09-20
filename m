Return-Path: <linux-kernel+bounces-334640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCD897D9D9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CFA1F23480
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09864185921;
	Fri, 20 Sep 2024 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="kgCFGCNH"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946B1865EA
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726861001; cv=none; b=BhNMSJjKi2X8ce+0BvuTmTXciMoIhgwlEPcUxiaSNA8f+VWRbkPJlqUe3+j7r0pbA6dxVXG/NJbWeIcj3o5d4RBkJncgan9LgLCfWMgsvp/7WpI9tEDW2R74+0Cqk5A918fw1bOUCVaXb8wY2Fb+gxm5TssEF4Gpu1THmKTw/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726861001; c=relaxed/simple;
	bh=o3wygS0jCJ93Tfd79C8Rq32Q4gviyK8SRxF0KHFE5P8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emw6seiCrEmJUdjP+HUIxWeiQFX+DHhjKWnhOu0kKVoTnbxOfBO1aUeF789PvHgFwss/fxMNl0OvKqwsAe1dG6aVTLO87RtcxH3r77DKBJXgnFcjAyzMGCBEp3aqoF+VSQg2S1f4Cbfu5ufkeYdrP50Df82lSZvIKWuXjYVXItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=kgCFGCNH; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726860997; x=1727120197;
	bh=yeLgx78m9Sd6Apcq8mxp4nOTMfjbR7KeS0+uCGOYT1k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kgCFGCNH+3yn3LbZu9BvOAB6jcbRxp7tPwjiVbWn+X8AuIZHTB5ohdQ7Qd2fq+BUp
	 9okPLXo0OPjuYeu30oJ3ULKMBLcbe2/Q4ekbShdNXmbcIqhaU8pqc2J97sB/CY22AJ
	 x8ZWckncXd6A1v54TAqbPcI5+B6pJdgeUR3z9fzkmUujX/JlucjNm0pkgIPW9ZONif
	 AD4wytOE/KrT11NB6QzDlWCx6GytYWoXdmWsvHJYQMFj7a5V0e55JaTrzwcnU8mHx+
	 bh8G4kICpiY/NPG61uAIyVce5z1/h27FtS+uDw5wJUKy/mbah2CGABeAle5vUXS0W2
	 5YNcEAX2yuyqg==
Date: Fri, 20 Sep 2024 19:36:31 +0000
To: gregkh@linuxfoundation.org, tdavies@darkphysics.net, philipp.g.hortmann@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v2 4/6] staging: rtl8192e: rtllib_softmac.c: Fix alignment to open parentheses
Message-ID: <20240920193356.32156-5-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
References: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: e285e2fa475220ae6b6bc43bd1a65520a1eeb044
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch aligns the code to open parentheses to improve readability.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 60 ++++++++++-------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rt=
l8192e/rtllib_softmac.c
index 0fc97c868f81..1fb7b2b027a1 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -243,9 +243,8 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, stru=
ct rtllib_device *ieee)
 =09=09=09 * as for the completion function, it does not need
 =09=09=09 * to check it any more.
 =09=09=09 */
-=09=09=09netdev_info(ieee->dev,
-=09=09=09       "%s():insert to waitqueue, queue_index:%d!\n",
-=09=09=09       __func__, tcb_desc->queue_index);
+=09=09=09netdev_info(ieee->dev, "%s():insert to waitqueue, queue_index:%d!=
\n",
+=09=09=09=09    __func__, tcb_desc->queue_index);
 =09=09=09skb_queue_tail(&ieee->skb_waitq[tcb_desc->queue_index],
 =09=09=09=09       skb);
 =09=09} else {
@@ -348,8 +347,7 @@ static inline struct sk_buff *rtllib_probe_req(struct r=
tllib_device *ieee)
 }
=20
 /* Enables network monitor mode, all rx packets will be received. */
-void rtllib_enable_net_monitor_mode(struct net_device *dev,
-=09=09bool init_state)
+void rtllib_enable_net_monitor_mode(struct net_device *dev, bool init_stat=
e)
 {
 =09struct rtllib_device *ieee =3D netdev_priv_rsl(dev);
=20
@@ -719,8 +717,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 =09else
 =09=09encrypt =3D 0;
=20
-=09if ((ieee->rtllib_ap_sec_type &&
-=09    (ieee->rtllib_ap_sec_type(ieee) & SEC_ALG_TKIP)) ||
+=09if ((ieee->rtllib_ap_sec_type && (ieee->rtllib_ap_sec_type(ieee) & SEC_=
ALG_TKIP)) ||
 =09    ieee->forced_bg_mode) {
 =09=09ieee->ht_info->enable_ht =3D 0;
 =09=09ieee->mode =3D WIRELESS_MODE_G;
@@ -729,14 +726,12 @@ rtllib_association_req(struct rtllib_network *beacon,
 =09if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
 =09=09ht_cap_buf =3D (u8 *)&ieee->ht_info->self_ht_cap;
 =09=09ht_cap_len =3D sizeof(ieee->ht_info->self_ht_cap);
-=09=09ht_construct_capability_element(ieee, ht_cap_buf, &ht_cap_len,
-=09=09=09=09=09     encrypt, true);
+=09=09ht_construct_capability_element(ieee, ht_cap_buf, &ht_cap_len, encry=
pt, true);
 =09=09if (ieee->ht_info->current_rt2rt_aggregation) {
 =09=09=09realtek_ie_buf =3D ieee->ht_info->sz_rt2rt_agg_buf;
 =09=09=09realtek_ie_len =3D
 =09=09=09=09 sizeof(ieee->ht_info->sz_rt2rt_agg_buf);
-=09=09=09ht_construct_rt2rt_agg_element(ieee, realtek_ie_buf,
-=09=09=09=09=09=09   &realtek_ie_len);
+=09=09=09ht_construct_rt2rt_agg_element(ieee, realtek_ie_buf, &realtek_ie_=
len);
 =09=09}
 =09}
=20
@@ -1042,8 +1037,8 @@ static void rtllib_associate_complete_wq(void *data)
 {
 =09struct rtllib_device *ieee =3D (struct rtllib_device *)
 =09=09=09=09     container_of(data,
-=09=09=09=09     struct rtllib_device,
-=09=09=09=09     associate_complete_wq);
+=09=09=09=09=09=09  struct rtllib_device,
+=09=09=09=09=09=09  associate_complete_wq);
 =09struct rt_pwr_save_ctrl *psc =3D &ieee->pwr_save_ctrl;
=20
 =09netdev_info(ieee->dev, "Associated successfully with %pM\n",
@@ -1177,10 +1172,10 @@ inline void rtllib_softmac_new_net(struct rtllib_de=
vice *ieee,
 =09=09 * and the network does broadcast and that those two bssid match
 =09=09 */
 =09=09if ((apset && apmatch &&
-=09=09   ((ssidset && ssidbroad && ssidmatch) ||
-=09=09   (ssidbroad && !ssidset) || (!ssidbroad && ssidset))) ||
-=09=09   (!apset && ssidset && ssidbroad && ssidmatch) ||
-=09=09   (ieee->is_roaming && ssidset && ssidbroad && ssidmatch)) {
+=09=09     ((ssidset && ssidbroad && ssidmatch) ||
+=09=09      (ssidbroad && !ssidset) || (!ssidbroad && ssidset))) ||
+=09=09    (!apset && ssidset && ssidbroad && ssidmatch) ||
+=09=09    (ieee->is_roaming && ssidset && ssidbroad && ssidmatch)) {
 =09=09=09/* Save the essid so that if it is hidden, it is
 =09=09=09 * replaced with the essid provided by the user.
 =09=09=09 */
@@ -1190,7 +1185,7 @@ inline void rtllib_softmac_new_net(struct rtllib_devi=
ce *ieee,
 =09=09=09=09tmp_ssid_len =3D ieee->current_network.ssid_len;
 =09=09=09}
 =09=09=09memcpy(&ieee->current_network, net,
-=09=09=09=09sizeof(ieee->current_network));
+=09=09=09       sizeof(ieee->current_network));
 =09=09=09if (!ssidbroad) {
 =09=09=09=09memcpy(ieee->current_network.ssid, tmp_ssid,
 =09=09=09=09       tmp_ssid_len);
@@ -1218,7 +1213,7 @@ inline void rtllib_softmac_new_net(struct rtllib_devi=
ce *ieee,
 =09=09=09=09if ((ieee->current_network.qos_data.supported =3D=3D 1) &&
 =09=09=09=09    ieee->current_network.bssht.bd_support_ht)
 =09=09=09=09=09ht_reset_self_and_save_peer_setting(ieee,
-=09=09=09=09=09=09 &ieee->current_network);
+=09=09=09=09=09=09=09=09=09    &ieee->current_network);
 =09=09=09=09else
 =09=09=09=09=09ieee->ht_info->current_ht_support =3D false;
=20
@@ -1314,10 +1309,10 @@ static inline u16 assoc_parse(struct rtllib_device =
*ieee, struct sk_buff *skb,
=20
 =09status_code =3D le16_to_cpu(response_head->status);
 =09if ((status_code =3D=3D WLAN_STATUS_ASSOC_DENIED_RATES ||
-=09   status_code =3D=3D WLAN_STATUS_CAPS_UNSUPPORTED) &&
-=09   ((ieee->mode =3D=3D WIRELESS_MODE_G) &&
-=09   (ieee->current_network.mode =3D=3D WIRELESS_MODE_N_24G) &&
-=09   (ieee->asoc_retry_count++ < (RT_ASOC_RETRY_LIMIT - 1)))) {
+=09     status_code =3D=3D WLAN_STATUS_CAPS_UNSUPPORTED) &&
+=09    ((ieee->mode =3D=3D WIRELESS_MODE_G) &&
+=09     (ieee->current_network.mode =3D=3D WIRELESS_MODE_N_24G) &&
+=09     (ieee->asoc_retry_count++ < (RT_ASOC_RETRY_LIMIT - 1)))) {
 =09=09ieee->ht_info->iot_action |=3D HT_IOT_ACT_PURE_N_MODE;
 =09} else {
 =09=09ieee->asoc_retry_count =3D 0;
@@ -1581,13 +1576,12 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, st=
ruct sk_buff *skb,
 =09=09   WLAN_FC_GET_STYPE(frame_ctl));
=20
 =09if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
-=09     ieee->link_state =3D=3D RTLLIB_ASSOCIATING_AUTHENTICATED &&
-=09     (ieee->iw_mode =3D=3D IW_MODE_INFRA)) {
+=09    ieee->link_state =3D=3D RTLLIB_ASSOCIATING_AUTHENTICATED &&
+=09    (ieee->iw_mode =3D=3D IW_MODE_INFRA)) {
 =09=09errcode =3D assoc_parse(ieee, skb, &aid);
 =09=09if (!errcode) {
-=09=09=09struct rtllib_network *network =3D
-=09=09=09=09 kzalloc(sizeof(struct rtllib_network),
-=09=09=09=09 GFP_ATOMIC);
+=09=09=09struct rtllib_network *network =3D kzalloc(sizeof(struct rtllib_n=
etwork),
+=09=09=09=09=09=09=09=09 GFP_ATOMIC);
=20
 =09=09=09if (!network)
 =09=09=09=09return 1;
@@ -1599,8 +1593,8 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, stru=
ct sk_buff *skb,
 =09=09=09assoc_resp =3D (struct rtllib_assoc_response_frame *)skb->data;
 =09=09=09if (ieee->current_network.qos_data.supported =3D=3D 1) {
 =09=09=09=09if (rtllib_parse_info_param(ieee, assoc_resp->info_element,
-=09=09=09=09=09=09=09rx_stats->len - sizeof(*assoc_resp),
-=09=09=09=09=09=09=09network, rx_stats)) {
+=09=09=09=09=09=09=09    rx_stats->len - sizeof(*assoc_resp),
+=09=09=09=09=09=09=09    network, rx_stats)) {
 =09=09=09=09=09kfree(network);
 =09=09=09=09=09return 1;
 =09=09=09=09}
@@ -2225,10 +2219,8 @@ u8 rtllib_ap_sec_type(struct rtllib_device *ieee)
 =09if (encrypt && (wpa_ie_len =3D=3D 0)) {
 =09=09return SEC_ALG_WEP;
 =09} else if ((wpa_ie_len !=3D 0)) {
-=09=09if (((ieee->wpa_ie[0] =3D=3D 0xdd) &&
-=09=09    (!memcmp(&ieee->wpa_ie[14], ccmp_ie, 4))) ||
-=09=09    ((ieee->wpa_ie[0] =3D=3D 0x30) &&
-=09=09    (!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))
+=09=09if (((ieee->wpa_ie[0] =3D=3D 0xdd) && (!memcmp(&ieee->wpa_ie[14], cc=
mp_ie, 4))) ||
+=09=09    ((ieee->wpa_ie[0] =3D=3D 0x30) && (!memcmp(&ieee->wpa_ie[10], cc=
mp_rsn_ie, 4))))
 =09=09=09return SEC_ALG_CCMP;
 =09=09else
 =09=09=09return SEC_ALG_TKIP;
--=20
2.34.1



