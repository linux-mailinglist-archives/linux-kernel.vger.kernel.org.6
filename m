Return-Path: <linux-kernel+bounces-230755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9382D918185
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6E41F21567
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D05181CF3;
	Wed, 26 Jun 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cPC73yqS"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01olkn2028.outbound.protection.outlook.com [40.92.112.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8057516CD35
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.112.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406601; cv=fail; b=aE1HUk38pnXEuHTt7mr1m4bJ2Sa0FhihBvseeoalg5K4gnsRxrQs3rkyfL7bB5slBEn0vNx38bKzMCap6UJPpc0njAyqbECL98QWuNW8LUpjbMHR7zFkBjFFTGPnJd4QGqHraX0SedROpN9A7/b64W38zPRqfgAjmgmoLVkLBl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406601; c=relaxed/simple;
	bh=6Tb4yI/fnZMDv7/WXVXEYe3tEKFNHzZgw7wFUNJ1ZoM=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=QdbX+zrYMNYbujdu/6IE9dbXz0ezo+Fq01ywcCVC9++rg6roJrUiQzGab6QegEqtvVHTuw5nandHCfS7Arep2+ixb4wK3NK9fR+9E3FhrBtYcnROMCTze2S5gIEC3XuN0+9CELEdUEjfj2cWmye5Tr2sBGJF8DJTmAJe6Fjdb9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cPC73yqS; arc=fail smtp.client-ip=40.92.112.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXkwCJDsddDF0vEabuFyBhT3geaplZo3uucjmsftoL8cyTx95t+l+kYs9Lwlz9Qua7ypV1ikejCJc9UDrjmNkmJq/64PyOGkyid+c+YuY+LDNfZEYFc3xrzMwNO4dx/N7IoVwNsZBf8PKJE49nLw2YZdimfJ2zmwxD4xsKeM8H7cehfNuoxZ0NNyfPq0IiJcXaQpCABZRQSdND1xNeHKLV74lwDYtXT1u4uzBLkr9FKJio4hzZSYMuZ1X8rIVo5o//reeKj18NpOoRGTCmk/S3V+noL5gNAcM9cBa/gpJGK2lnp0GbWGKdCQ1V7nmqWIPa5a1L3KJjvBPM7W3ePimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE08UcZNiXhTDkYBuYOKDVV9JzY2GWc0vL7noN8WWjk=;
 b=WnH7ezVPKFTnsLMWk5rCDu9Sb+t2XjTVaUOJfGDib2f59StIQEE6I6JtGb091AoqqL1lcxWt2gGK3nP09AgDpFaB1os3pJcCHkCN+wcTCVDdg+Lg0QFR9QyW3pB7UFhdfCmWiRKljLzBljm3qJ73nYBfbavWfgQ0vG3EO5lLK7IMAZZJ7qgQD9Kbjnwf7Nw1SfGQtk+fiHsw6DmmEv00aTRa+j0Nu3WrCKq6f8qT9iGPvh2F85yTrpraUBXSJ4snUxfA06+Vg/xPOZFFVbNzkKebAeqKBaecQdaqb5mXpaGU3VJSLiQjJXOmlDqC7QnrCtu5/oCuH+6UFh33h1XyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pE08UcZNiXhTDkYBuYOKDVV9JzY2GWc0vL7noN8WWjk=;
 b=cPC73yqS/xoNQt0t1Xi6KTU43P/w+w5XKrw1x5D7pnY+N8/sf4FMomkeOBFY7Yda5wuc9Uc1l4gCxVj/j/1PipKAKpqHYOp4bbcE4qbhUyry6v8aSgiIzYEUjgq6uoIcY990+2KqvxB5qX3E2784xNsqFZth8vvzN6q7MCBRHeI2Lmu8Mblgv6BS2oqyJBjURXUccRRyeKe7/EwWFW/1oW/1rQDzygB3CUZjhH0igbdOp5X7Nyd/gYk7eKIoNbv9VoN0aqlyOpNx37f6cIlm1uZlVjF8PKiQHIPn6G26agsEuPUQF2Nk5U1zbk7AcXG263i4DuoqCgYEUQ2p+/YwQQ==
Received: from CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1da::7)
 by LO4P265MB3472.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 12:56:36 +0000
Received: from CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a912:f233:4847:e806]) by CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a912:f233:4847:e806%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 12:56:35 +0000
Message-ID:
 <CWLP265MB65165E806F938F87CB67BF87FDD62@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Subject: [PATCH v3] Staging: rtl8192e: rtllib_rx: fix alignment
From: Yusef Aslam <yuzi54780@outlook.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Wed, 26 Jun 2024 13:56:34 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
X-TMN: [9TXCPdNJSH83XbhugSoR8qXdKZomjnJ7]
X-ClientProxiedBy: LO3P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::11) To CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1da::7)
X-Microsoft-Original-Message-ID:
 <f48e26a83b7667a01103b5d888cc6baee5e6c52b.camel@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6516:EE_|LO4P265MB3472:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2b63dd-cd72-40e7-2a8f-08dc95df694f
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199026|3412199023|440099026;
X-Microsoft-Antispam-Message-Info:
	U79CPSCoxfelCqV44yJUTn4cFya4J9NmQ7WbpZzmrftuC2Eh/L6f9EnQX8Bg9R7lnBSxxy47fHv03/Jne6aDnH+a13LY4K9O9xkI5QymYv0il2HzgNaV5NjSz1rB9M18CnjHi5N3jb30sQwNWeAUIZExmVCUmOn0oe3KgvaE6b3pwus0pkXXGCLvQkiaMDK/N+1z0FZtot5BFYllVrRhpeEdg/nPJGeFBWrFdjBs3atsh9OF9dIMaADwaM7CImZgdWqZq3vOd/OzZIw0RSS3V115A95iH3SWCHdO8U5yT8+06XA4/C/qhVFHIaRT9uQmH4jwpUahgzq9/Gm7J56ciTA4+lA/beLqiiipusBVWOMxk1hyOmn8CFJR8OLf1WoKSUJO6NsRppc4qTNG4SoSiC6g6CXJClBeJWCbqpOCD4tlTI4FON3iHPr3EmyFM0OuInfOfnPGDNO7cAijF+EvmWmBi9mFFQxkjjHdtXqf/LYDMrLMkXngmUbvjDcSbptxGLX3sK0+XqoXCiEJxUTrYRihSchiPVgjKukBL6+a8OpD9os8ImZEYsK2yEKkdrHA
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTFpeHpsYjVWUXBIcytOY2VtZmVFaktiM1pyVEJRODVWQmUvL3FCNFNnUjZU?=
 =?utf-8?B?a3hETGFVamYxZVRpSEdtU0lDTzJ0Y2dHS0JUVVdzU3U4d094WGViYWdCRlZl?=
 =?utf-8?B?TnhLTzcrNzI4bkNXOHpmK3VpS3cyeEpzSW0rZnhlNnY5NzA5c0VQd255ek9D?=
 =?utf-8?B?SkFCTHBGMDYyWXZqMzExeUl2dGgrQVVaTHFHMGhhQTlFVXZZUy96N0hVb3hM?=
 =?utf-8?B?U1pERjFZL0Q4U3FYY0VQVEloVExPdkdnQVByTHNTSUpVMVZtQkYzZlFQUmts?=
 =?utf-8?B?UFNGQVBBMWpIdUs3aUNGWVI2SzJ0MVQvd3hkR2FsWkc0Z2JOKzQwdkhzQ3gz?=
 =?utf-8?B?Q1JOZUg5K0Y2K05ldUxrSmRzK0d2MGkxZG1nUThTQjUra3RGUVZOem9uZStm?=
 =?utf-8?B?K1FxY21ybXo5eUlUWjA5TUQwL3JhTFF5dk84aytDdWsrS0FydDNjWXl6Vmox?=
 =?utf-8?B?NUZ1QXRBWkVLQXk3YUwyVVR5K29RZkFYclFjSjd5L1JtUmZQTG9QaTc2d2Iv?=
 =?utf-8?B?eWk2NFBjSG5SMXNmWFQ4TWRZUzNqTVpCM0NJcXp3bUVPSko1ZEJhNGlTUHVs?=
 =?utf-8?B?QmIxRlJrbzErczRDMXZTWUNhaVpLeEJQaGlQV3piRWFwajRBU1RLeGxCYU80?=
 =?utf-8?B?RU96Y0tOOFM4TlpkUHJHU2c0Vm1odko0cUg1MnRWVmttQVh3NjhadTMrUWgv?=
 =?utf-8?B?a3FwNDBwY2M5Tm4ybG9iZUI2VmljVGc0WGUyekRZNHFJTWZtS2VSRUJEcmZP?=
 =?utf-8?B?SVkzNGZRNE1zc0NTd1RDUm52bSt0RUc2RWNTOUJRaEFqQXo3bDhMYmxVb3lD?=
 =?utf-8?B?RjBHREVhUkRVbE8rNlhreXdGV1ByZzFFREFBcWQwQUVwVDhjdldBSXY5SjVa?=
 =?utf-8?B?WFQ3YmNPc21Lekp4Wm5iaG5kN1pzMzZveGRSb0VEM1RocG1kM1JBVlpBeVQy?=
 =?utf-8?B?THErNGRLNjJKa3YrRnl3WmYySjcyMGdXaGRteVZPN3JDZTFFbStrSmNDU0NO?=
 =?utf-8?B?R3h5QSt6bTE3K1R6ZkFQM2FCSFNHR2w0aWxkV3lYRHdVVC9od2FtRitPNllN?=
 =?utf-8?B?SjlUdy8za3ljYWJFSFp6YkNVZWpOdUdyM3pYUjNUdzV3T0VZczVpZTRxV0ZV?=
 =?utf-8?B?SkE1cnltdHNEVVVQcDkyK1puMXNQTE1ZQnkrVzVhS3VTTUdEdCtzUCt6Nytv?=
 =?utf-8?B?YW9SelR4WDRUeldhRTlsejRyNFloaHZydkQ4TThBYzJzVzBSTWxDQzdNYzFB?=
 =?utf-8?B?MGUxSExqUGdMZlF5NHNMaGxCTUFGdXk4SnJ2TTZJRWFWeFg2NExWdGVGb2lQ?=
 =?utf-8?B?bGtFLzdGZy9pd0MzYTg1Y2lXYWFNOFUxN2pIWGQxYWx1ejZjSW52Y09EMmVG?=
 =?utf-8?B?Yk5NcUtiL1F2NTZVRm41UjVZK252UFBjT241WFgrUjR4SnprOHFOaVBhSHN1?=
 =?utf-8?B?REY0T1J6SzU2VDVzTXJaWjNHQ2Z4VExUS1hDSmJtQzIxaGdpTHp3ZDF0RDNU?=
 =?utf-8?B?bnhMVUVvTmtNMkxBdVVkRXhjeHJqcDZoMTNROHhDSW96RXBVdkV6OUlVQ3M1?=
 =?utf-8?B?NDVxSjVyUVZFclZaWm05WUFZSVpjeGlkamVNd05hd0tLOXdwQTFKclFHREs5?=
 =?utf-8?Q?kOTpdpgobS+GlwKIXRBXGvknTdVbooh6PIeNZKjr+yFE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2b63dd-cd72-40e7-2a8f-08dc95df694f
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 12:56:35.9062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB3472

From: Yusef Aslam <YUZi54780@outlook.com>
Date: Wed, 26 Jun 2024 13:02:02 +0100
Subject: [PATCH v3] Staging: rtl8192e: rtllib_rx: fix alignment

Fix alignment.

Signed-off-by: Yusef Aslam <YUZi54780@outlook.com>
---
 v3:
 - Used the correct email addresses.
 - Developed against the correct git repository.
 v2:
 - The email address of Greg Kroah-Hartman was wrong.
 - Developed against the wrong git repository.
 v1:
 - Developed against the wrong git repository.

 drivers/staging/rtl8192e/rtllib_rx.c | 110 +++++++++++++--------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192=
e/rtllib_rx.c
index 84ca5d769b7e..1f6c4a3de5c2 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -410,7 +410,7 @@ static bool add_reorder_entry(struct rx_ts_record *ts,
 	while (list->next !=3D &ts->rx_pending_pkt_list) {
 		if (SN_LESS(pReorderEntry->SeqNum, ((struct rx_reorder_entry *)
 		    list_entry(list->next, struct rx_reorder_entry,
-		    list))->SeqNum))
+			       list))->SeqNum))
 			list =3D list->next;
 		else if (SN_EQUAL(pReorderEntry->SeqNum,
 			((struct rx_reorder_entry *)list_entry(list->next,
@@ -736,7 +736,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, st=
ruct sk_buff *skb,
 	/* just for debug purpose */
 	SeqNum =3D WLAN_GET_SEQ_SEQ(le16_to_cpu(hdr->seq_ctrl));
 	if ((RTLLIB_QOS_HAS_SEQ(fc)) &&
-	   (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN))->field.reserved))
+	    (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN))->field.reserved))
 		is_aggregate_frame =3D true;
=20
 	if (RTLLIB_QOS_HAS_SEQ(fc))
@@ -876,13 +876,13 @@ static int rtllib_rx_check_duplicate(struct rtllib_de=
vice *ieee,
 	frag =3D WLAN_GET_SEQ_FRAG(sc);
=20
 	if (!ieee->ht_info->cur_rx_reorder_enable ||
-		!ieee->current_network.qos_data.active ||
-		!is_data_frame(skb->data) ||
-		is_legacy_data_frame(skb->data)) {
-		if (!ieee80211_is_beacon(hdr->frame_control)) {
-			if (is_duplicate_packet(ieee, hdr))
-				return -1;
-		}
+	    !ieee->current_network.qos_data.active ||
+	    !is_data_frame(skb->data) ||
+	    is_legacy_data_frame(skb->data)) {
+	  if (!ieee80211_is_beacon(hdr->frame_control)) {
+	    if (is_duplicate_packet(ieee, hdr))
+	      return -1;
+	  }
 	} else {
 		struct rx_ts_record *ts =3D NULL;
=20
@@ -976,7 +976,7 @@ static int rtllib_rx_data_filter(struct rtllib_device *=
ieee, struct ieee80211_hd
 }
=20
 static int rtllib_rx_get_crypt(struct rtllib_device *ieee, struct sk_buff =
*skb,
-			struct lib80211_crypt_data **crypt, size_t hdrlen)
+			       struct lib80211_crypt_data **crypt, size_t hdrlen)
 {
 	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
 	u16 fc =3D le16_to_cpu(hdr->frame_control);
@@ -1008,8 +1008,8 @@ static int rtllib_rx_get_crypt(struct rtllib_device *=
ieee, struct sk_buff *skb,
 }
=20
 static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *s=
kb,
-		      struct rtllib_rx_stats *rx_stats,
-		      struct lib80211_crypt_data *crypt, size_t hdrlen)
+			     struct rtllib_rx_stats *rx_stats,
+			     struct lib80211_crypt_data *crypt, size_t hdrlen)
 {
 	struct ieee80211_hdr *hdr;
 	int keyidx =3D 0;
@@ -1092,9 +1092,9 @@ static int rtllib_rx_decrypt(struct rtllib_device *ie=
ee, struct sk_buff *skb,
 	 * encrypted/authenticated
 	 */
 	if ((fc & IEEE80211_FCTL_PROTECTED) &&
-		rtllib_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt)) {
-		netdev_info(ieee->dev, "%s: =3D=3D>decrypt msdu error\n", __func__);
-		return -1;
+	    rtllib_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt)) {
+	  netdev_info(ieee->dev, "%s: =3D=3D>decrypt msdu error\n", __func__);
+	  return -1;
 	}
=20
 	hdr =3D (struct ieee80211_hdr *)skb->data;
@@ -1152,10 +1152,10 @@ static void rtllib_rx_check_leave_lps(struct rtllib=
_device *ieee, u8 unicast,
 }
=20
 static void rtllib_rx_indicate_pkt_legacy(struct rtllib_device *ieee,
-		struct rtllib_rx_stats *rx_stats,
-		struct rtllib_rxb *rxb,
-		u8 *dst,
-		u8 *src)
+					  struct rtllib_rx_stats *rx_stats,
+					  struct rtllib_rxb *rxb,
+					  u8 *dst,
+					  u8 *src)
 {
 	struct net_device *dev =3D ieee->dev;
 	u16 ethertype;
@@ -1175,17 +1175,17 @@ static void rtllib_rx_indicate_pkt_legacy(struct rt=
llib_device *ieee,
 			 */
 			ethertype =3D (sub_skb->data[6] << 8) | sub_skb->data[7];
 			if (sub_skb->len >=3D 8 &&
-				((memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) =3D=3D 0 &&
-				ethertype !=3D ETH_P_AARP && ethertype !=3D ETH_P_IPX) ||
-				memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE) =3D=3D 0)) {
-				/* remove RFC1042 or Bridge-Tunnel encapsulation
-				 * and replace EtherType
-				 */
-				skb_pull(sub_skb, SNAP_SIZE);
-				ether_addr_copy(skb_push(sub_skb, ETH_ALEN),
-						src);
-				ether_addr_copy(skb_push(sub_skb, ETH_ALEN),
-						dst);
+			    ((memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) =3D=3D 0 &&
+			      ethertype !=3D ETH_P_AARP && ethertype !=3D ETH_P_IPX) ||
+			     memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE) =3D=3D 0)) =
{
+			  /* remove RFC1042 or Bridge-Tunnel encapsulation
+			   * and replace EtherType
+			   */
+			  skb_pull(sub_skb, SNAP_SIZE);
+			  ether_addr_copy(skb_push(sub_skb, ETH_ALEN),
+					  src);
+			  ether_addr_copy(skb_push(sub_skb, ETH_ALEN),
+					  dst);
 			} else {
 				u16 len;
 				/* Leave Ethernet header part of hdr
@@ -1220,7 +1220,7 @@ static void rtllib_rx_indicate_pkt_legacy(struct rtll=
ib_device *ieee,
 }
=20
 static int rtllib_rx_infra_adhoc(struct rtllib_device *ieee, struct sk_buf=
f *skb,
-		 struct rtllib_rx_stats *rx_stats)
+				 struct rtllib_rx_stats *rx_stats)
 {
 	struct net_device *dev =3D ieee->dev;
 	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
@@ -1323,9 +1323,9 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device=
 *ieee, struct sk_buff *skb
 		TID =3D frame_qos_tid(skb->data);
 		SeqNum =3D WLAN_GET_SEQ_SEQ(sc);
 		rtllib_get_ts(ieee, (struct ts_common_info **)&ts, hdr->addr2, TID,
-		      RX_DIR, true);
+			      RX_DIR, true);
 		if (TID !=3D 0 && TID !=3D 3)
-			ieee->bis_any_nonbepkts =3D true;
+		  ieee->bis_any_nonbepkts =3D true;
 	}
=20
 	/* Parse rx data frame (For AMSDU) */
@@ -1380,7 +1380,7 @@ static int rtllib_rx_infra_adhoc(struct rtllib_device=
 *ieee, struct sk_buff *skb
 }
=20
 static int rtllib_rx_monitor(struct rtllib_device *ieee, struct sk_buff *s=
kb,
-		 struct rtllib_rx_stats *rx_stats)
+			     struct rtllib_rx_stats *rx_stats)
 {
 	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
 	u16 fc =3D le16_to_cpu(hdr->frame_control);
@@ -1412,7 +1412,7 @@ static int rtllib_rx_monitor(struct rtllib_device *ie=
ee, struct sk_buff *skb,
  * This function is called only as a tasklet (software IRQ).
  */
 int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
-		 struct rtllib_rx_stats *rx_stats)
+	      struct rtllib_rx_stats *rx_stats)
 {
 	int ret =3D 0;
=20
@@ -1577,10 +1577,10 @@ static int rtllib_parse_qos_info_param_IE(struct rt=
llib_device *ieee,
 		struct rtllib_qos_parameter_info param_element;
=20
 		rc =3D rtllib_read_qos_param_element(&param_element,
-						      info_element);
+						   info_element);
 		if (rc =3D=3D 0) {
 			rtllib_qos_convert_ac_to_parameters(&param_element,
-							       &(network->qos_data));
+							    &(network->qos_data));
 			network->flags |=3D NETWORK_HAS_QOS_PARAMETERS;
 			network->qos_data.param_count =3D
 			    param_element.info_element.ac_info & 0x0F;
@@ -1864,7 +1864,7 @@ static void rtllib_parse_mfie_ht_cap(struct rtllib_in=
fo_element *info_element,
 	if (*tmp_htcap_len !=3D 0) {
 		ht->bd_ht_spec_ver =3D HT_SPEC_VER_EWC;
 		ht->bd_ht_cap_len =3D min_t(u16, *tmp_htcap_len,
-				       sizeof(ht->bd_ht_cap_buf));
+					  sizeof(ht->bd_ht_cap_buf));
 		memcpy(ht->bd_ht_cap_buf, info_element->data, ht->bd_ht_cap_len);
=20
 		ht->bd_support_ht =3D true;
@@ -1882,10 +1882,10 @@ static void rtllib_parse_mfie_ht_cap(struct rtllib_=
info_element *info_element,
 }
=20
 int rtllib_parse_info_param(struct rtllib_device *ieee,
-		struct rtllib_info_element *info_element,
-		u16 length,
-		struct rtllib_network *network,
-		struct rtllib_rx_stats *stats)
+			    struct rtllib_info_element *info_element,
+			    u16 length,
+			    struct rtllib_network *network,
+			    struct rtllib_rx_stats *stats)
 {
 	u8 i;
 	short offset;
@@ -2329,10 +2329,10 @@ static inline void update_network(struct rtllib_dev=
ice *ieee,
=20
 	dst->wmm_info =3D src->wmm_info;
 	if (src->wmm_param[0].ac_aci_acm_aifsn ||
-	   src->wmm_param[1].ac_aci_acm_aifsn ||
-	   src->wmm_param[2].ac_aci_acm_aifsn ||
-	   src->wmm_param[3].ac_aci_acm_aifsn)
-		memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
+	    src->wmm_param[1].ac_aci_acm_aifsn ||
+	    src->wmm_param[2].ac_aci_acm_aifsn ||
+	    src->wmm_param[3].ac_aci_acm_aifsn)
+	  memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
=20
 	dst->SignalStrength =3D src->SignalStrength;
 	dst->RSSI =3D src->RSSI;
@@ -2450,7 +2450,7 @@ static inline void rtllib_process_probe_response(
=20
 	spin_lock_irqsave(&ieee->lock, flags);
 	if (is_same_network(&ieee->current_network, network,
-	   (network->ssid_len ? 1 : 0))) {
+			    (network->ssid_len ? 1 : 0))) {
 		update_network(ieee, &ieee->current_network, network);
 		if ((ieee->current_network.mode =3D=3D WIRELESS_MODE_N_24G ||
 		     ieee->current_network.mode =3D=3D WIRELESS_MODE_G) &&
@@ -2467,10 +2467,10 @@ static inline void rtllib_process_probe_response(
 	}
 	list_for_each_entry(target, &ieee->network_list, list) {
 		if (is_same_network(target, network,
-		   (target->ssid_len ? 1 : 0)))
-			break;
+				    (target->ssid_len ? 1 : 0)))
+		  break;
 		if (!oldest || (target->last_scanned < oldest->last_scanned))
-			oldest =3D target;
+		  oldest =3D target;
 	}
=20
 	/* If we didn't find a match, then get a new network slot to initialize
@@ -2528,9 +2528,9 @@ static inline void rtllib_process_probe_response(
 	spin_unlock_irqrestore(&ieee->lock, flags);
 	if (ieee80211_is_beacon(frame_ctl) &&
 	    is_same_network(&ieee->current_network, network,
-	    (network->ssid_len ? 1 : 0)) &&
+			    (network->ssid_len ? 1 : 0)) &&
 	    (ieee->link_state =3D=3D MAC80211_LINKED)) {
-		ieee->handle_beacon(ieee->dev, beacon, &ieee->current_network);
+	  ieee->handle_beacon(ieee->dev, beacon, &ieee->current_network);
 	}
 free_network:
 	kfree(network);
@@ -2553,9 +2553,9 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 				stats);
=20
 		if (ieee->sta_sleep || (ieee->ps !=3D RTLLIB_PS_DISABLED &&
-		    ieee->iw_mode =3D=3D IW_MODE_INFRA &&
-		    ieee->link_state =3D=3D MAC80211_LINKED))
-			schedule_work(&ieee->ps_task);
+					ieee->iw_mode =3D=3D IW_MODE_INFRA &&
+					ieee->link_state =3D=3D MAC80211_LINKED))
+		  schedule_work(&ieee->ps_task);
 	} else if (ieee80211_is_probe_resp(header->frame_control)) {
 		netdev_dbg(ieee->dev, "received PROBE RESPONSE\n");
 		rtllib_process_probe_response(ieee, (struct rtllib_probe_response *)head=
er,
--=20
2.44.2



