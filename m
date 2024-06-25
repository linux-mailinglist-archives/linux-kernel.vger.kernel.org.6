Return-Path: <linux-kernel+bounces-229227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8409F916D13
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FAB1C23335
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E076C16D4D7;
	Tue, 25 Jun 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="py/gfmFz"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01olkn2012.outbound.protection.outlook.com [40.92.113.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF72E62F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.113.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329325; cv=fail; b=lrJx+hFo2aY3iWNaZfiFSpSN2wz0Jd3icJd5GepNF4MPpFnLa3JsAJCewORm3LpIXfXn0SSKBz0tLb8O/ospouKzLa27HgZVWVMQAqOFfjptZAgFS5DkxodVhOBD2zPWAMHVntLqr5svl14cMvP4lZYBh32bYnIvrM3Rmnd3uwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329325; c=relaxed/simple;
	bh=bFtHkvFMBwM91f6eSXMaM5409kr/TEe5AgO1S1ul+9c=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=KE2hlxtIgQ1GHHN/jSbHZqy4o7lT31sAE4PB3pNLiT0ELIPVyHeEpm6Z+m11OmU0RUu80aLzIecOUhKCNMPiED0Zm4W5QIqSuyYP8qn+/EGjAugwMAJLjP/xaFn+uxKZvwsnahQXqrkS+kleOAxuuaXLrpCePGjShDRFrmPxpkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=py/gfmFz; arc=fail smtp.client-ip=40.92.113.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYdkHDNyeWVVd7dSeoyZa+RKcTOYFUmujtaGofMaSYWggPZOf4nor1PT2uHGlAyD7hvt15Z06HBjL6sMGfvQMlXoluK8wLd8HmYxIrwiAWcAXtCi3MF+CMIecqEfJ6Fr9pohgp7o0vjvQxZ2eRkj6kjND09e/mgF9waTMDyaPrHjI9pceB64VmQ9Ssl4JeZFZxD134bJXrOmtJOSr2DJfI/vL0g5osC6dD38Ydgz9aybsjMyqxdBfjRu9DBRqRFSzlxrUm/mWMrjpZ3fjqgPCRU18x+3KBP2eRwG3qASI10nr31dlD5WzoE/igyF2asuf+Gi5nXKgwHp2xuzZTioDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfYi5+YdkE5FEt9XtCNMMSqBUshLjrAVT6sgbWe5/AA=;
 b=MYH0zs3T3bpOGJVgVFQEFpbvYGnMf4HL7p5pHp1VkL5jKnQmz9ziH6F0hNkaHkaYfVES8kpwQtqWto0Ue0SFMwlNR8Tvzey207frsB4leUWCXg8f+dL9IOV7qFzJWkabkmd4ninwPLUawnz6O0PRrEmBHOvAiX9OyatV5Ung/45DFzTZoOwH0wnX/SorYnCsbEH2YpxJzB6wHX8zgUrJ47CpgP/do8G3xC53xjpRpBbG6KHfO/RmlXo98jCVtElC5MVyL5sJ1IcVKcn+Nsw9K6gKEikPGX1WAo2RN1A8XxO60hB2wq3sddjPfz69Ii1xfu8FmkyjbyoZ/1+qCTHKBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfYi5+YdkE5FEt9XtCNMMSqBUshLjrAVT6sgbWe5/AA=;
 b=py/gfmFznHmUs/iP+9wORpnNsp1NRkFtjGVDttFhupCRSUZJbwPHdGbQgXiJ/NJKHIP0bOPh74pyGhXkUvyTAmUMW/9zmtXw8qXobmjN2qQ3PHaCBRN1KsJII5vzg333o+dadm5y/IxkMhpXPek1oid76gI1OTAmTFZkualS7jFqtQMdN4phowqOsGAy8RFYKkOpwkYJcs1/12WkHtCIpcuoUsCNbDvLB45juIuid2tev6dxM5STFiBAgVMKR+xmrVGWzHZ3wmsKXZ/LBKihlk88zJzuJF0BdSp/f4iYFhcSp6wNIRCnzsRVET7MT3fuwc5qQ4Hg7+CDURyA38sR9g==
Received: from CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1da::7)
 by CWXP265MB2919.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Tue, 25 Jun
 2024 15:28:39 +0000
Received: from CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a912:f233:4847:e806]) by CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a912:f233:4847:e806%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:28:39 +0000
Message-ID:
 <CWLP265MB651697C43A8A396DE8989CD8FDD52@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Subject: [PATCH] Staging: rtl8192e: rtllib_rx: fixed alignment
From: Yusef Aslam <yuzi54780@outlook.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2024 16:28:38 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
X-TMN: [4xibs7ad+0Dff58LTk1XYNPd62fZCcCQ]
X-ClientProxiedBy: LO4P265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::7) To CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1da::7)
X-Microsoft-Original-Message-ID:
 <51c93280b0d7547d7cc6e2d8dfc8dcdb855a1f4c.camel@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6516:EE_|CWXP265MB2919:EE_
X-MS-Office365-Filtering-Correlation-Id: d44f2a96-f9e8-4142-a299-08dc952b7cf4
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|3412199022|440099025;
X-Microsoft-Antispam-Message-Info:
	VTI5JcyXmqpq4SKMmD7thws9BFE1tsfKsVjA//8Rg90qzr7S+6qMK7sIEcmhlkIONtLukkzkmUHCA5wn/O7Xa3I+faCZw6SqoDuaWmVZrHS56CZFJB7q+4TmO1jfySQXSHLxFeqwzHvTJpaPEsKy2fbTrkb1qftl2WIkecDXANiDydxWIZkUHz+ncDqDdmMaEXbCBwdOifZGkL6nDaGGZgF+J4rKpBxWbFQyzBSs8vdsLIaBilaQX76hHUn27uh6vYgRDuV6MLhWoGH8BwaOF4zMUTQapb5CAq7rAkSfx/ydV9Fgh4Gejp6NL4PsVlvT7PYjMOejM62VhKG1Fo4zTdM1T8f8JCz2dO8AGzEBebAl/eZYRvZyTP9f8tRx5pO7z2RpWvrUqSee8xONS6LSnNrlnW8h7EBvDZldwbxl/kStuii67tT4RaCE+e3ChmHW8vI+8XVvAZfu2rRl0ELG4oDCgaIzDnBvYwOVbtgFqXWKELR/UcvYpleh2EI6qIRZYaLfdyS+SzLKgN06tXbuqgby7ZIN7dILvioQAOnEgAOWZ1v+r5LTtU1iF4/76eQq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlVia1g0UVdFc1hLM3RsU1hwSkZDU3dnZVhsdUdYSDZvUnJ3WDVKOGtVbFlD?=
 =?utf-8?B?VTlqQmhhbHRPL1ZTRWtoU2tmb0g0ZDRtZDJsSCs1THBJQWpyWEExLzQvUGNp?=
 =?utf-8?B?NUdmZUx4L3I3amhVZEZLUmp6azF2YmZ2QVdmNlRxUGFHUDg0cWs4TCtnUTEy?=
 =?utf-8?B?dFpzQkxxMFlSeU1TV3JONkMwZlZ0STBTR3MvS3NxRlNxZWE2S0hGVHhLTmpP?=
 =?utf-8?B?UkI3djhlWjFEOHMzVzRvL1crVEtJakFkZVl4V2FVbDFrSWptVWswZmdnQmRu?=
 =?utf-8?B?YnBNL0oxRktBZHpTMnkzUDh0MWdtTWxBVWJ4dThHVXdDWmtFNmdWdUtFdXp0?=
 =?utf-8?B?czN1OVFYSmVwM2YzTUt5OHNvWDIzSkM2b1ZsUDVGdUtHbEpsUzFJWUZ1UWxj?=
 =?utf-8?B?cnRuMlBWYmgxK2t3MjVEUFVDeXVTbnRUaG1kWVhCVVI3OHNCQzRlKytaZVEw?=
 =?utf-8?B?ZmdmZ2FMZmYrbkZSczVUQVIyblBFMXV6NTNWT0ZFZWllUE12RTFqUXRWQkVH?=
 =?utf-8?B?NUpTYmhtelhTTzk4OGVVZGxqZE1WOXM5cGVoUmJGb010UFdpLytKVXpzcXpy?=
 =?utf-8?B?VnBFSkE0T3NtT3BTOU1UUUtLZ3F4MWdFQk5mZEhHVjNNd0lFUjZKaTJSRm84?=
 =?utf-8?B?NTdORmFhMXNRN3F6MHV2RHRjZk41Ym0xYkpQeHdNQnovTzF0c1hwY2N6NEVa?=
 =?utf-8?B?aWRVRGluUjY0OWpTL1VWbWxGTnRvWXdNSXNFVEthU2ViRFNkd1dRU0NiVlg0?=
 =?utf-8?B?QTNvRzZQbDBtbEtPK1VsT1hsakdDT3l5UUZEaUtaL2tpb05ITWNjRWtzQjdP?=
 =?utf-8?B?RUpUQlhrWEJ2YWlza09zbDRVN3A0bjhuYW5BRExCeDljRUZKUy9oVXZPdkZu?=
 =?utf-8?B?Y0dERUxnRlUwQUlGU0t2SE5XR05jdjR6MUFWdkg1cm8yMWN0MldSc2Npd3R2?=
 =?utf-8?B?S1lPaDVLL3QrTXRwaGFZNmQzUkVoOE5OcWN1b1BvOEw5YVZreFV6MU5BOGUr?=
 =?utf-8?B?Wi9vSXlvdHUwQk50TnMrUHNqT2xjeERqTFR3a1dJVVBackRKVldMSzdScU9V?=
 =?utf-8?B?NGVrNlR3NW4rTkNBTHJGVDZjd3B4WTdMbjJpaFlXR1lFWUh0SEdTZk41Y1M5?=
 =?utf-8?B?QUVYcEwya3hxZVdRc2MrQTl5SjBqK2c1bFBLYys2M21CWlpQTVgyNXo0aVd6?=
 =?utf-8?B?TTdkVWl0SGN4N0ZHSEU5c0MwUmhxY1E4SmsrM29VenE3VU4rRXZGYUMreVZm?=
 =?utf-8?B?Y1F0dk1yNkJNOVZVQ2Z3aUR0M014azlrZnlPUWRjcE5JUGpFOWdUczlYYmF1?=
 =?utf-8?B?VXkvQlhOTWNjWXBpYjB5QVFZcWVQZkpxUHB0d3ZXS1BLSHhqcVNwYnBiMnhD?=
 =?utf-8?B?eXVWd2t4S0xRZmFYU3NNL0pBbnkxM2U1dGFkYnBzZzhwV1pVNEFERGRCS050?=
 =?utf-8?B?VEtZVzljcjlzcW54WXIvanhpaURqWkpUWjJGWENhSFZRWGI4MHlUcCtzUTNo?=
 =?utf-8?B?cmZFcUVIUWxrQ1pRU2czalYxckZHMTU0a0dTcUZPOVdRWCtqUzM2V1VveXlI?=
 =?utf-8?B?YWJkRlJNSkpUbC8xeEtrb2x0V2d2OGo2Z3VIMkVTMWk5THBLQkZpejN6QWRC?=
 =?utf-8?Q?Q1MzBo1wulndR9O4R96zEOzHItW/Kcr8uAC0pct3XNnw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44f2a96-f9e8-4142-a299-08dc952b7cf4
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:28:39.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2919

From 3acc0622bca28c1a00696e7abd7c305ca5ad1f72 Mon Sep 17 00:00:00 2001
From: Yusef Aslam <YUZi54780@outlook.com>
Date: Tue, 25 Jun 2024 15:03:08 +0100
Subject: [PATCH] Staging: rtl8192e: rtllib_rx: fixed alignment

Fixed alignment.

Signed-off-by: Yusef Aslam <YUZi54780@outlook.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 98 ++++++++++++++--------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c
b/drivers/staging/rtl8192e/rtllib_rx.c
index ebf8a2fd36d3..b1a476e29670 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -55,7 +55,7 @@ static inline void rtllib_monitor_rx(struct
rtllib_device *ieee,
 /* Called only as a tasklet (software IRQ) */
 static struct rtllib_frag_entry *
 rtllib_frag_cache_find(struct rtllib_device *ieee, unsigned int seq,
-			  unsigned int frag, u8 tid, u8 *src, u8 *dst)
+		       unsigned int frag, u8 tid, u8 *src, u8 *dst)
 {
 	struct rtllib_frag_entry *entry;
 	int i;
@@ -84,7 +84,7 @@ rtllib_frag_cache_find(struct rtllib_device *ieee,
unsigned int seq,
 /* Called only as a tasklet (software IRQ) */
 static struct sk_buff *
 rtllib_frag_cache_get(struct rtllib_device *ieee,
-			 struct ieee80211_hdr *hdr)
+		      struct ieee80211_hdr *hdr)
 {
 	struct sk_buff *skb =3D NULL;
 	u16 fc =3D le16_to_cpu(hdr->frame_control);
@@ -143,7 +143,7 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
 		 * should have already been received
 		 */
 		entry =3D rtllib_frag_cache_find(ieee, seq, frag, tid,
hdr->addr2,
-						  hdr->addr1);
+					       hdr->addr1);
 		if (entry) {
 			entry->last_frag =3D frag;
 			skb =3D entry->skb;
@@ -155,7 +155,7 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
=20
 /* Called only as a tasklet (software IRQ) */
 static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
-					   struct ieee80211_hdr *hdr)
+					struct ieee80211_hdr *hdr)
 {
 	u16 fc =3D le16_to_cpu(hdr->frame_control);
 	u16 sc =3D le16_to_cpu(hdr->seq_ctrl);
@@ -181,7 +181,7 @@ static int rtllib_frag_cache_invalidate(struct
rtllib_device *ieee,
 	}
=20
 	entry =3D rtllib_frag_cache_find(ieee, seq, -1, tid, hdr->addr2,
-					  hdr->addr1);
+				       hdr->addr1);
=20
 	if (!entry) {
 		netdev_dbg(ieee->dev,
@@ -202,8 +202,8 @@ static int rtllib_frag_cache_invalidate(struct
rtllib_device *ieee,
  */
 static inline int
 rtllib_rx_frame_mgmt(struct rtllib_device *ieee, struct sk_buff *skb,
-			struct rtllib_rx_stats *rx_stats, u16 type,
-			u16 stype)
+		     struct rtllib_rx_stats *rx_stats, u16 type,
+		     u16 stype)
 {
 	/* On the struct stats definition there is written that
 	 * this is not mandatory.... but seems that the probe
@@ -228,7 +228,7 @@ rtllib_rx_frame_mgmt(struct rtllib_device *ieee,
struct sk_buff *skb,
=20
 /* Called by rtllib_rx_frame_decrypt */
 static int rtllib_is_eapol_frame(struct rtllib_device *ieee,
-				    struct sk_buff *skb, size_t
hdrlen)
+				 struct sk_buff *skb, size_t hdrlen)
 {
 	struct net_device *dev =3D ieee->dev;
 	u16 fc, ethertype;
@@ -346,7 +346,7 @@ rtllib_rx_frame_decrypt_msdu(struct rtllib_device
*ieee, struct sk_buff *skb,
 /* this function is stolen from ipw2200 driver*/
 #define IEEE_PACKET_RETRY_TIME (5 * HZ)
 static int is_duplicate_packet(struct rtllib_device *ieee,
-				      struct ieee80211_hdr *header)
+			       struct ieee80211_hdr *header)
 {
 	u16 fc =3D le16_to_cpu(header->frame_control);
 	u16 sc =3D le16_to_cpu(header->seq_ctrl);
@@ -411,10 +411,10 @@ static bool AddReorderEntry(struct rx_ts_record
*ts,
 	while (pList->next !=3D &ts->rx_pending_pkt_list) {
 		if (SN_LESS(pReorderEntry->SeqNum, ((struct
rx_reorder_entry *)
 		    list_entry(pList->next, struct rx_reorder_entry,
-		    list))->SeqNum))
+			       list))->SeqNum))
 			pList =3D pList->next;
 		else if (SN_EQUAL(pReorderEntry->SeqNum,
-			((struct rx_reorder_entry *)list_entry(pList-
>next,
+				  ((struct rx_reorder_entry
*)list_entry(pList->next,
 			struct rx_reorder_entry, list))->SeqNum))
 			return false;
 		else
@@ -601,7 +601,7 @@ static void RxReorderIndicatePacket(struct
rtllib_device *ieee,
 		if (!list_empty(&ieee->RxReorder_Unused_List)) {
 			pReorderEntry =3D (struct rx_reorder_entry *)
 					list_entry(ieee-
>RxReorder_Unused_List.next,
-					struct rx_reorder_entry,
list);
+						   struct
rx_reorder_entry, list);
 			list_del_init(&pReorderEntry->list);
=20
 			/* Make a reorder entry and insert
@@ -738,7 +738,7 @@ static u8 parse_subframe(struct rtllib_device
*ieee, struct sk_buff *skb,
 	/* just for debug purpose */
 	SeqNum =3D WLAN_GET_SEQ_SEQ(le16_to_cpu(hdr->seq_ctrl));
 	if ((RTLLIB_QOS_HAS_SEQ(fc)) &&
-	   (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN))-
>field.reserved))
+	    (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN))-
>field.reserved))
 		is_aggregate_frame =3D true;
=20
 	if (RTLLIB_QOS_HAS_SEQ(fc))
@@ -880,7 +880,7 @@ static int rtllib_rx_check_duplicate(struct
rtllib_device *ieee,
 	frag =3D WLAN_GET_SEQ_FRAG(sc);
=20
 	if (!ieee->ht_info->cur_rx_reorder_enable ||
-		!ieee->current_network.qos_data.active ||
+	    !ieee->current_network.qos_data.active ||
 		!IsDataFrame(skb->data) ||
 		IsLegacyDataFrame(skb->data)) {
 		if (!ieee80211_is_beacon(hdr->frame_control)) {
@@ -980,7 +980,7 @@ static int rtllib_rx_data_filter(struct
rtllib_device *ieee, struct ieee80211_hd
 }
=20
 static int rtllib_rx_get_crypt(struct rtllib_device *ieee, struct
sk_buff *skb,
-			struct lib80211_crypt_data **crypt, size_t
hdrlen)
+			       struct lib80211_crypt_data **crypt,
size_t hdrlen)
 {
 	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
 	u16 fc =3D le16_to_cpu(hdr->frame_control);
@@ -1012,8 +1012,8 @@ static int rtllib_rx_get_crypt(struct
rtllib_device *ieee, struct sk_buff *skb,
 }
=20
 static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct
sk_buff *skb,
-		      struct rtllib_rx_stats *rx_stats,
-		      struct lib80211_crypt_data *crypt, size_t
hdrlen)
+			     struct rtllib_rx_stats *rx_stats,
+			     struct lib80211_crypt_data *crypt, size_t
hdrlen)
 {
 	struct ieee80211_hdr *hdr;
 	int keyidx =3D 0;
@@ -1096,7 +1096,7 @@ static int rtllib_rx_decrypt(struct rtllib_device
*ieee, struct sk_buff *skb,
 	 * encrypted/authenticated
 	 */
 	if ((fc & IEEE80211_FCTL_PROTECTED) &&
-		rtllib_rx_frame_decrypt_msdu(ieee, skb, keyidx,
crypt)) {
+	    rtllib_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt)) {
 		netdev_info(ieee->dev, "%s: =3D=3D>decrypt msdu error\n",
__func__);
 		return -1;
 	}
@@ -1156,10 +1156,10 @@ static void rtllib_rx_check_leave_lps(struct
rtllib_device *ieee, u8 unicast,
 }
=20
 static void rtllib_rx_indicate_pkt_legacy(struct rtllib_device *ieee,
-		struct rtllib_rx_stats *rx_stats,
-		struct rtllib_rxb *rxb,
-		u8 *dst,
-		u8 *src)
+					  struct rtllib_rx_stats
*rx_stats,
+					  struct rtllib_rxb *rxb,
+					  u8 *dst,
+					  u8 *src)
 {
 	struct net_device *dev =3D ieee->dev;
 	u16 ethertype;
@@ -1179,8 +1179,8 @@ static void rtllib_rx_indicate_pkt_legacy(struct
rtllib_device *ieee,
 			 */
 			ethertype =3D (sub_skb->data[6] << 8) | sub_skb-
>data[7];
 			if (sub_skb->len >=3D 8 &&
-				((memcmp(sub_skb->data,
rfc1042_header, SNAP_SIZE) =3D=3D 0 &&
-				ethertype !=3D ETH_P_AARP && ethertype
!=3D ETH_P_IPX) ||
+			    ((memcmp(sub_skb->data, rfc1042_header,
SNAP_SIZE) =3D=3D 0 &&
+			      ethertype !=3D ETH_P_AARP && ethertype !=3D
ETH_P_IPX) ||
 				memcmp(sub_skb->data,
bridge_tunnel_header, SNAP_SIZE) =3D=3D 0)) {
 				/* remove RFC1042 or Bridge-Tunnel
encapsulation
 				 * and replace EtherType
@@ -1224,7 +1224,7 @@ static void rtllib_rx_indicate_pkt_legacy(struct
rtllib_device *ieee,
 }
=20
 static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct
sk_buff *skb,
-		 struct rtllib_rx_stats *rx_stats)
+				struct rtllib_rx_stats *rx_stats)
 {
 	struct net_device *dev =3D ieee->dev;
 	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
@@ -1327,7 +1327,7 @@ static int rtllib_rx_InfraAdhoc(struct
rtllib_device *ieee, struct sk_buff *skb,
 		TID =3D Frame_QoSTID(skb->data);
 		SeqNum =3D WLAN_GET_SEQ_SEQ(sc);
 		rtllib_get_ts(ieee, (struct ts_common_info **)&ts,
hdr->addr2, TID,
-		      RX_DIR, true);
+			      RX_DIR, true);
 		if (TID !=3D 0 && TID !=3D 3)
 			ieee->bis_any_nonbepkts =3D true;
 	}
@@ -1384,7 +1384,7 @@ static int rtllib_rx_InfraAdhoc(struct
rtllib_device *ieee, struct sk_buff *skb,
 }
=20
 static int rtllib_rx_Monitor(struct rtllib_device *ieee, struct
sk_buff *skb,
-		 struct rtllib_rx_stats *rx_stats)
+			     struct rtllib_rx_stats *rx_stats)
 {
 	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
 	u16 fc =3D le16_to_cpu(hdr->frame_control);
@@ -1416,7 +1416,7 @@ static int rtllib_rx_Monitor(struct rtllib_device
*ieee, struct sk_buff *skb,
  * This function is called only as a tasklet (software IRQ).
  */
 int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
-		 struct rtllib_rx_stats *rx_stats)
+	      struct rtllib_rx_stats *rx_stats)
 {
 	int ret =3D 0;
=20
@@ -1581,10 +1581,10 @@ static int
rtllib_parse_qos_info_param_IE(struct rtllib_device *ieee,
 		struct rtllib_qos_parameter_info param_element;
=20
 		rc =3D rtllib_read_qos_param_element(&param_element,
-						      info_element);
+						   info_element);
 		if (rc =3D=3D 0) {
			rtllib_qos_convert_ac_to_parameters(&param_element,
-							     =20
&(network->qos_data));
+							    &(network-
>qos_data));
 			network->flags |=3D NETWORK_HAS_QOS_PARAMETERS;
 			network->qos_data.param_count =3D
 			    param_element.info_element.ac_info & 0x0F;
@@ -1698,7 +1698,7 @@ static void rtllib_parse_mife_generic(struct
rtllib_device *ieee,
 			if (*tmp_htcap_len !=3D 0) {
 				network->bssht.bd_ht_spec_ver =3D
HT_SPEC_VER_EWC;
 				network->bssht.bd_ht_cap_len =3D
min_t(u16, *tmp_htcap_len,
-								=20
sizeof(network->bssht.bd_ht_cap_buf));
+							    =20
sizeof(network->bssht.bd_ht_cap_buf));
 				memcpy(network->bssht.bd_ht_cap_buf,
 				       info_element->data,
 				       network->bssht.bd_ht_cap_len);
@@ -1868,7 +1868,7 @@ static void rtllib_parse_mfie_ht_cap(struct
rtllib_info_element *info_element,
 	if (*tmp_htcap_len !=3D 0) {
 		ht->bd_ht_spec_ver =3D HT_SPEC_VER_EWC;
 		ht->bd_ht_cap_len =3D min_t(u16, *tmp_htcap_len,
-				       sizeof(ht->bd_ht_cap_buf));
+					  sizeof(ht->bd_ht_cap_buf));
 		memcpy(ht->bd_ht_cap_buf, info_element->data, ht-
>bd_ht_cap_len);
=20
 		ht->bd_support_ht =3D true;
@@ -1886,10 +1886,10 @@ static void rtllib_parse_mfie_ht_cap(struct
rtllib_info_element *info_element,
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
@@ -1914,7 +1914,7 @@ int rtllib_parse_info_param(struct rtllib_device
*ieee,
 		switch (info_element->id) {
 		case MFIE_TYPE_SSID:
 			if (rtllib_is_empty_essid(info_element->data,
-						     info_element-
>len)) {
+						  info_element->len))
{
 				network->flags |=3D NETWORK_EMPTY_ESSID;
 				break;
 			}
@@ -2193,10 +2193,10 @@ static inline int rtllib_network_init(
 	network->wzc_ie_len =3D 0;
=20
 	if (rtllib_parse_info_param(ieee,
-			beacon->info_element,
-			(stats->len - sizeof(*beacon)),
-			network,
-			stats))
+				    beacon->info_element,
+				    (stats->len - sizeof(*beacon)),
+				    network,
+				    stats))
 		return 1;
=20
 	network->mode =3D 0;
@@ -2333,9 +2333,9 @@ static inline void update_network(struct
rtllib_device *ieee,
=20
 	dst->wmm_info =3D src->wmm_info;
 	if (src->wmm_param[0].ac_aci_acm_aifsn ||
-	   src->wmm_param[1].ac_aci_acm_aifsn ||
-	   src->wmm_param[2].ac_aci_acm_aifsn ||
-	   src->wmm_param[3].ac_aci_acm_aifsn)
+	    src->wmm_param[1].ac_aci_acm_aifsn ||
+	    src->wmm_param[2].ac_aci_acm_aifsn ||
+	    src->wmm_param[3].ac_aci_acm_aifsn)
 		memcpy(dst->wmm_param, src->wmm_param,
WME_AC_PRAM_LEN);
=20
 	dst->SignalStrength =3D src->SignalStrength;
@@ -2454,7 +2454,7 @@ static inline void rtllib_process_probe_response(
=20
 	spin_lock_irqsave(&ieee->lock, flags);
 	if (is_same_network(&ieee->current_network, network,
-	   (network->ssid_len ? 1 : 0))) {
+			    (network->ssid_len ? 1 : 0))) {
 		update_network(ieee, &ieee->current_network, network);
 		if ((ieee->current_network.mode =3D=3D WIRELESS_MODE_N_24G
||
 		     ieee->current_network.mode =3D=3D WIRELESS_MODE_G) &&
@@ -2471,7 +2471,7 @@ static inline void rtllib_process_probe_response(
 	}
 	list_for_each_entry(target, &ieee->network_list, list) {
 		if (is_same_network(target, network,
-		   (target->ssid_len ? 1 : 0)))
+				    (target->ssid_len ? 1 : 0)))
 			break;
 		if (!oldest || (target->last_scanned < oldest-
>last_scanned))
 			oldest =3D target;
@@ -2532,7 +2532,7 @@ static inline void rtllib_process_probe_response(
 	spin_unlock_irqrestore(&ieee->lock, flags);
 	if (ieee80211_is_beacon(frame_ctl) &&
 	    is_same_network(&ieee->current_network, network,
-	    (network->ssid_len ? 1 : 0)) &&
+			    (network->ssid_len ? 1 : 0)) &&
 	    (ieee->link_state =3D=3D MAC80211_LINKED)) {
 		ieee->handle_beacon(ieee->dev, beacon, &ieee-
>current_network);
 	}
@@ -2557,8 +2557,8 @@ static void rtllib_rx_mgt(struct rtllib_device
*ieee,
 				stats);
=20
 		if (ieee->sta_sleep || (ieee->ps !=3D RTLLIB_PS_DISABLED
&&
-		    ieee->iw_mode =3D=3D IW_MODE_INFRA &&
-		    ieee->link_state =3D=3D MAC80211_LINKED))
+					ieee->iw_mode =3D=3D IW_MODE_INFRA
&&
+					ieee->link_state =3D=3D
MAC80211_LINKED))
 			schedule_work(&ieee->ps_task);
 	} else if (ieee80211_is_probe_resp(header->frame_control)) {
 		netdev_dbg(ieee->dev, "received PROBE RESPONSE\n");
--=20
2.44.2



