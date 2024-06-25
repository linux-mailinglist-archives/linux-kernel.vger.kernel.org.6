Return-Path: <linux-kernel+bounces-229215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D645916CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FA9284AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29265174ED2;
	Tue, 25 Jun 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="j03IQq6H"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01olkn2079.outbound.protection.outlook.com [40.92.112.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C5173349
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.112.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329129; cv=fail; b=hw8KL+dDyK4NKbY5uoUlYH/tOLWqu0tGvFHusSR9lVMN8jWM0iY7rmmyAp2zvDqkj2kM+1AJqBdzPCbhpZGV8IT8BFvIWntQxqNyysJMPwog6GQl+UN4yXikc3pEGBU6HcpuYnfH8+VRqm1DFHBEwaRRvtYCQYrZ1iTXnf8Yke4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329129; c=relaxed/simple;
	bh=5HaELnYJhehjtZJb1EiqJEYZ2ikkpxvE53EuTzW1/3M=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Hb4F1cB2SpsRP/c2r76beOE4Rc9EwbjfmP+EH8+mkpFBtQsRN3qWMZS4I/fwGIXRL+hE61SKQHa97hVsxitgtMCBcI0IgpHr3ZHlwZLzZFWp9RkrmDfnbWOKMhhEdzwTEyF+e32R/+j7Ua8x5gasH6mpTWtuCz7iJgaQfo0PNeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=j03IQq6H; arc=fail smtp.client-ip=40.92.112.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLR2t2T08sy/NA1F3Gvb+504ATBoE+q7Y4BCGQXeRhUxrAPob18NW0n6Ep0b6FlHGgq2/phWhceLQk3sll+SXS9ODLqdNDykIJmUy914aM/3YRS8UXUuRyfJhSrKLUZ/4q7Tcey8SZv6C5b0/efEwzdjOg/tjevtRHS3QWRB6QDNbyeBOfqEkGtFsZ7bJVCGgmDKapB8Qch8zt0UY3xt9woUW06BscqJtRO96ONQdTN+fsXtWQXuAp6Hnwx8sZIVOHwGo8QL+h7CDCacVOjc3JpfVfJilDt2H7bBccFwL+Q91FqjpEmkSEGg0fm19qxklHkVWKcJIvlDo8TbXGxdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMCMo40WtBkgAoY32LeRgUbKLYUvj1UXoF9sbZie2Z4=;
 b=gxidTXOjNpJabuuwMsOd1h+hp9TycJs9PZ+mo67O2njllPmg0s2yBReLEFGUZlHoEV0IvAsSJ6UbPHckhOnIEKiqbwmw6lbPAM4v4rC5vFJ7d7nrNDBglbrvH5DX/y4w5BkYhRpw04knCwwc9qKAQygG+vCL7sPW24GzmzfznF4AVy9jZ/BOuCCECLQ6AJOLTMEyr29RgOz8FN0SR6PNj3a1p0dh+luOO6psyD667Tm+Nvyi+9eohiDtTUkobezyEn3nEyJI9+M2ptv67iB++Vd50vajA/hInlLV98KV8YAawe9EZ2yGoZJZeNgibaEOO+l2YnWg4usWHcB8cQaL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMCMo40WtBkgAoY32LeRgUbKLYUvj1UXoF9sbZie2Z4=;
 b=j03IQq6Ho8hOVtgXumOOZpUUYlSK5lk8N0WsuBHVCKTYu6r62gvPXRbbmb2T/XrRwNsVE3tr9gWBKmYpZHW6EpH0cEEPi8+47nRvmPKFtXw6bJvZX8FuspknhHyD8fwaPFIed8faT+LpB9ZmpJPra2nQClFYTUvWCngNb5cOwFLgwMDvU2kSRCOJMRwuIgVJmmVmM3Yt75C2t7YDC6iTuFnX3slnbdr1A8N16+lDYQ+jRxkMPgQEEqWbN3MNl3Sz3X702mc0+TibssBOPl6cIUoz8YXO/XEI8ATwv7fYE/kDz192pFfmXduNYwU8dKY4M7/+bJj8YrnuR9rTKckjTQ==
Received: from CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1da::7)
 by LO6P265MB6800.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 15:25:24 +0000
Received: from CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a912:f233:4847:e806]) by CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a912:f233:4847:e806%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:25:24 +0000
Message-ID:
 <CWLP265MB6516C4904E979DB10F00F9F8FDD52@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Subject: [PATCH] Staging: rtl8192e: rtllib_rx: fixed alignment
From: Yusef Aslam <yuzi54780@outlook.com>
To: greg-kh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2024 16:25:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
X-TMN: [+h8vLkvGi6zvaDyUjBBZ2vgX6UoU7ILO]
X-ClientProxiedBy: LO4P302CA0045.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::20) To CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1da::7)
X-Microsoft-Original-Message-ID:
 <95dbec7fa004f82f8e67a2ea0b70ecea8b75e48f.camel@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6516:EE_|LO6P265MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: b0165734-1076-4aac-6b83-08dc952b08aa
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|440099025|3412199022;
X-Microsoft-Antispam-Message-Info:
	7EOCkb35nfpbQlzCcimJebw5iSQf4U2HmS6W2oqcwIbd1DtyLgcgpOf0TIwq/lkIVa2Hxt4/0coKlncJ0yuKpcZd69GjVb4LPEnyUk9yEF2U5TYb/hxMXYZyEsBzh1So6G/cRK1ZiWEPtZanzY+nU6kdLswc3CdeFOIuuH10BD1whkXZRKD2bEvn1skHAv/mK9MwVJOUAfuIK+ISx0Rn1gjYvuwx3rg0TgWQZqLvZpNi128+LLHvIkmlkwHksfKDtgwzJMJRyqjehvhPpuHU3fxd84y864Vs6kWkdRntL0bE3ptxozm/qgNsqaeeFdFBt2XkQTZsVCS/Fd2EQU+aNM92R/ckbuPrhNX9MORZE1eh0ugPv4ir1DnejdV9QdK8fx3eYQWk48VoS0rwqWLBCzRXZEBb28L6FodCtuLS48sF8fAKAHuYJAgAub1C8SfIFKMjdzug4BlcwiG+OMkW32MavCUH5TMzQknrUJGelP4T8VVbv9FC8wcMPXUhUU9PNWQ3wnNxfcueiX8hlSnG/Evbib/dTKc1KCVbhQ74RBAlcgVTXbhjLX4MbKfRpdk3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXJRTWk1am1KSUEwNWxMWFNGTm5MUGE2aUdnYXlOQ1NSUmplczB0Z0tXejBm?=
 =?utf-8?B?VUJSNXVwMG9BUS9sSGkvR3BKbXVnVGdsZUJ1S3BJQTZEU3lac1ZRY0hvM3JI?=
 =?utf-8?B?SzBBc2k3UzFacFNRT1NMUkRwZEhCN3dYdVFnL0xrUkpUK1FXTkcyVExubXZW?=
 =?utf-8?B?bkpGU2EwdWxtYTFkZ0gxdlV6Snc2dEFyN05rV0VFQ1d0a1doUE81RVpuSXNh?=
 =?utf-8?B?Vm9weFFlY1lDN09yNVRWdEpUbm1BUHlIM1AwMXV4cG1FNG1DcnRONmVHK0NK?=
 =?utf-8?B?TTZwVHZRMDFPbE5xVldIOHl0eHJQRWMyZWZrZW5LNWRxWHZZSEdVTmFuRUZK?=
 =?utf-8?B?Z1ErNEZId09LQlB1Yk5yZStDNitySThWMjZVcW9taC9FTVBXcXhSZjVJR2lD?=
 =?utf-8?B?MnhIOUprU2RTWk5IZG1uWVRkeWVpbzNsZDlUblJyVlo2TjlabDJRQjJEMjlz?=
 =?utf-8?B?K0ZNUWlNWUhWaWNhelBrTVZpNFAvekpWOTVvYzlybktaejJ3QmQxRnNUQ3Bi?=
 =?utf-8?B?NWluc1QxdlI3MWszaHFrbDJkRVh4VExCdzFTdnpNQ2M0M2VVR3FnbVFsSkM1?=
 =?utf-8?B?ZVRZNGNwZGZpQ2l5S2ZlcS9PcEF4ZkZpTEVLcTU3V1ovN3ZHWVcrbEIxM0hl?=
 =?utf-8?B?eTB3ZmtneXo5SndFakRHeDcycGlvVG9ZNGFKVC9ScXQ1NTdiaEtpL0NlK3lj?=
 =?utf-8?B?TGNtTkpPSThOK0lIS201NHBBdHZscGo3bXVHcDgyYk1Ra1VUaG5EWG04Ykc1?=
 =?utf-8?B?dFRVT1lpYXRvNHR4NEs1aDlqR1dUeGJad0dwaEprT1gyY1F3b0dIU3htUDhy?=
 =?utf-8?B?VTlFbG9TWW9Lcy9VMXc2M3RjWEhDTDlpNWhSd3p6aGlsTjRjdXZwaE1rek1j?=
 =?utf-8?B?QXVyVVNhSWE0VHk4T0VJeTE2UCtTZjFJU2RDdjNHc3J4aU90N2RmQUxURkZ3?=
 =?utf-8?B?VUVERG9rV0dsUzdhTERyYUdCQVc4c3ZSaUlTYkQ0K0xoL08raGNGR0xmb05J?=
 =?utf-8?B?R3VRd3FZaks4NHJtU2pTWVBRTXRXV09WckJ4RGZUZUMzWmlhVU5UUWkyeG1C?=
 =?utf-8?B?U2kxVjVmMDI5cW5VR2RJaVZPRVdqUlhhU25yeVNyRkRIUTNoTWNheWxKZ2ow?=
 =?utf-8?B?SHZDRndza2NSTG5hOWVQbVRTa2VNQ3Jtd3llTXpSRzVaUXA1OGs2RklnUzQr?=
 =?utf-8?B?T1VzV3gvT2VSMElJV2hDOUdtUXQ3bXlNVzdRRCtoOWFnekwxSmJSOUYyd0NE?=
 =?utf-8?B?a05pZzJNbzZrOEw4aDFGd0E2bDBhZVJneXo3WW5DS1k5R0wvZFBkaE4zZ3Vt?=
 =?utf-8?B?K3BVN0xnZFlDS21NNWs4MkFsT0dqTmkxYndmMWorSXo2TW5VcTdzRFVWanht?=
 =?utf-8?B?TlFSaWxyUlVFRndNU0tkQm1xVnlVbWtZVzV2TUFKdWpUSUlxdDhpeUQwcG9Y?=
 =?utf-8?B?cHFsTHIwSjNSSW5Wek5nR2gyUS9Gc0J0d2FyWEZJeEdrSy9zeXJzcCt2UFhD?=
 =?utf-8?B?RU83MEplOFhUZ3FRa0pjSkp0bXJ3ME9ObWU1OGxod3hXYi9jWk0xL0RMYUwr?=
 =?utf-8?B?RVdPQTdGbUM0ajFkcVFmRHJKRzdhdDBxMm95aFg0ZHhxUDEybFc5anBtamZk?=
 =?utf-8?Q?1xCxil10r2mK4520ZsQVkOybkZ5utPz7+aBTIdYOrziQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0165734-1076-4aac-6b83-08dc952b08aa
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:25:24.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6800

Fixed alignment.From 3acc0622bca28c1a00696e7abd7c305ca5ad1f72 Mon Sep 17 00=
:00:00 2001
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



