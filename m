Return-Path: <linux-kernel+bounces-352659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1298992241
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 01:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9341F2153F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 23:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8715F18BC30;
	Sun,  6 Oct 2024 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lenbrook.com header.i=@lenbrook.com header.b="FGvqXUqk"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021087.outbound.protection.outlook.com [40.107.192.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF218B482;
	Sun,  6 Oct 2024 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728257215; cv=fail; b=ZyQQl7NI7Nq674t775N/pMVAzQygYe/aEkeqZfhL4/Tz28ILb5kR8C71y3Z6q8BKB0PtLKHhu56Wa1DR5LuLInndAxHsHaNfWbMFXu/ubqqLBhDjTY1vbNrdiOTPHIMYZ0MmV6+mJ1xghY1Q/MkCrIvsTstIJ8uDcyhG4lsxKNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728257215; c=relaxed/simple;
	bh=rb1kZrKXbzelXQhaDGgwadO/K0qdJXgGi2hrtDEYDO4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e5c+XSoTzuShVKGPk4c5qZ0ofvqrcJI51uuSVXYd+K4MBkNm03evCEnYM07JslCq3lUfCkP0II4h+Kgc0zwAdJNNdG+wy1A3B4SzDdxBBph7AsGaqFiUiFhBNvf3oRFnhnwQwSlJvZo0ItVwyz9tj+gNsLUbslpU+SCub5RQphA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lenbrook.com; spf=pass smtp.mailfrom=lenbrook.com; dkim=pass (1024-bit key) header.d=lenbrook.com header.i=@lenbrook.com header.b=FGvqXUqk; arc=fail smtp.client-ip=40.107.192.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lenbrook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenbrook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZrMwnwI8bdtb7j1wQbf7aJUdWek9T9VdiR8wNBeayBYWZ5dkVBRfmde6QRUQCKxkmKp1eyF6D9IXfuGEGemt7WWkGr79dV7sRCxo3RJw1bWxSUZPh/lVR6CMpipeqNspceyP+AlJxSWSDDzWFs133K8r+hHoVkq91/YMxFDLwx4fAN8vAqRmMfntc/xBMA/gc0oVbnlkREr/BzicgOGBrPNPZ3j8mWY5p2JD+LE0dPPdow1KUM8jVWvGIMPrOgciYTjoBjVnSUobApCtUeBDykKfTe5n/grq79n8xMdVHrh0fC2gcXUYbxnwcrd0q7IrssAAXGtrinW5lITbqJV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmYumSOwhaHx5JlbpnL9DvXBZMdUyeQUseqBxgUqH/o=;
 b=CuQ4Gn/lClDKRS1SWXztrRIGms9El7qwRuf1WYBgCuikZ7cBrpLcjm88D4Tgw/tnXoQCFfB5P6TlWbWLxswWqEGzTAuiZQ3HKX3x7K8j3OSrDyttI7bLvIpM+oLMHUORM/pLJWK9mS+BuM2s2Ixvh/fgeKOCbLFKgq80SGl+QEN3MYIN7+Aq7iAvBBTiAPBg64vzba0VTSRGrZqRQFhFeNtvm4bsQhJUnB2Bll2dOelsxYK+brqdaiydp3JT8Bh16yZK6qYJ9Pqgbmxd3MYDH6pBFoBfyKVFCfXpxQiZvtDjnhbHU092+RdwVxJb4T9CO0ern17EWFoDpCBNhdxxVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmYumSOwhaHx5JlbpnL9DvXBZMdUyeQUseqBxgUqH/o=;
 b=FGvqXUqkurPLOoA9Ckfy9shd2ev3aJT3gyIQSQo6jZ4BWB8NDDnfIB5ApZs6FKF9dibJBiEGYFdjPx1dMG7Rp/nMwRjEGBj1FpurIsbX6I/pZzHMUYBuSseIS+PuUJYJn2KIT1FT681+Ih7h7OiDqBT01nf6wUwCZ+SrioBR0VE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::12)
 by YT4PR01MB9688.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Sun, 6 Oct
 2024 23:26:47 +0000
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1646:7ee4:f637:6449]) by YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1646:7ee4:f637:6449%4]) with mapi id 15.20.8026.020; Sun, 6 Oct 2024
 23:26:47 +0000
From: Kevin Groeneveld <kgroeneveld@lenbrook.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chris Wulff <Chris.Wulff@biamp.com>,
	Kevin Groeneveld <kgroeneveld@lenbrook.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	John Keeping <jkeeping@inmusicbrands.com>,
	Lee Jones <lee@kernel.org>,
	Yunhao Tian <t123yh.xyz@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: f_uac2: fix return value for UAC2_ATTRIBUTE_STRING store
Date: Sun,  6 Oct 2024 19:26:31 -0400
Message-ID: <20241006232637.4267-1-kgroeneveld@lenbrook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::6) To YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB9670:EE_|YT4PR01MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 61af9dfa-79e1-4478-3749-08dce65e58fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HOTgSVWvnKXT3sY3gmsuVFKFkEDmQDjhIjxMYuqxIgPH3/BylaXBkxm08kHA?=
 =?us-ascii?Q?O4aOlhmCVXjtel08ckTyo6bdOlKJVB8HADcMoX6jZJwIHZoifkvH/hTk94RO?=
 =?us-ascii?Q?QFrH2U/ih5a+nXx4z3hOw/U8oNzfch+moimeNGSXTxtmwq3o9C1JbNmRLVyH?=
 =?us-ascii?Q?SEJLEjzpm4/DdYv8fGDltYkCkJtqBae1CYPWLXA4cHlSMkbBHowYS+UBwXm6?=
 =?us-ascii?Q?I79FBZMrIs8OssE8YT1Yg0P6EdzdMKf7K9aAS1rd3XR5N9l2v491CigjIPZr?=
 =?us-ascii?Q?pKbc8fC/eqctWk0e6aZvdLE52D7lvo9XfKrikJ6ywVMpz4Ni4btfYK2RWk0k?=
 =?us-ascii?Q?Pvn4hW1v66LyO4WeTscC0Fx6G2Th7LZL2eKLsc1fMgLz6diDOYlAXudIfcS0?=
 =?us-ascii?Q?hrswdef+Kcdv3tKD25mDHaGRc1s4sDIUj+e6fgS1tUQw72aQg0t2xvg0VZdj?=
 =?us-ascii?Q?MOPhrwrKO/gVMa42NdVtpNJlEb40p0K6L0F1CrK/WDt8x/cw7dszmh6HxgfH?=
 =?us-ascii?Q?IojeSqNvGaqf8KZd/4hN8TjaBgj/HRSMz6DONnEDZ9XNQQ4DnUSCwAcaDHqL?=
 =?us-ascii?Q?2LcVAGrmBM6/agZoLPTQ0oYRkAeG2MaWngKtLcvhN4Mx4RjyC6uyF3FSAot5?=
 =?us-ascii?Q?lRA74RagwSC6EceqSeOZQ21MCgdlu4/QztKARTY/lROFKi0bdydsHXJOU7FV?=
 =?us-ascii?Q?3aMSm3G5qvKawfRlMYEeXzgxmzO4drgKXN1FbybtC7C6PahN+hn8Um3MJlga?=
 =?us-ascii?Q?zRqd29o1+6Pi9GBnO6KxtGB437UKzGb2+6VZJ/3nv1X8AFgMiRqfLT/Vz+Wf?=
 =?us-ascii?Q?lIZGWKtpY+dwpz11WAOLkv2YgAY7b99X1XXLL/YKZkQ8IXHRydxK4jWqqPiP?=
 =?us-ascii?Q?6X1HcJWnkXrq+hHXZ9L6cXCu1KfAnM1mooz7rPMGitX66oy5diMbi3C+F933?=
 =?us-ascii?Q?2Bf+GCgxeloHRS8aLX41Xs8OZGCvq+WzDsOX4hEK8v0JF6UWuN4fDK8QyToP?=
 =?us-ascii?Q?vIEH5agxg+CzYwMTcvVRcB69/unuu9tRpRtP2HxvfeKXR/lgQhjrn50T//D2?=
 =?us-ascii?Q?vO1c8PKFwkSsWV4OTcPC2tDokCkEttT9+bQiQRlOvzyN40BdnVIv5wz7vCe7?=
 =?us-ascii?Q?ga/LmAUqb8ZB6vH4weVnEpvf2cUj+sH+ZXrU1Schkd6fVEU2NxI31jXMjrNi?=
 =?us-ascii?Q?uJaAK6+SQWG8n/FChJe54Tbwm/XjuHG2OWB+gmF9DI12XWIMyrIQE/oZ/kZe?=
 =?us-ascii?Q?dNKV4EJCU0DFOZJrVQfR6CovB72HRoTqNCow7UhlJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a/M+kqPd5THotVvVbzBkzCKvdz+7h41bryqWDtCOMY5mGESyVG9DI43QILBg?=
 =?us-ascii?Q?sVVBWUd4NacLR/8ZVvx90+qPoFcu16a155/djezsNcHRPsybc5g4PfkJPWDY?=
 =?us-ascii?Q?cSCeG/6y2cG9M25dgcodP72CiSOVYflVxKJV7P+cw0y/eHRTboI3xd8ruiYZ?=
 =?us-ascii?Q?h0/i5+ljgaSCgrRVPHM/VXtaY5o7Qw+USPNKM3RLNHqO2Gp752Vw2cTi/tHH?=
 =?us-ascii?Q?g124tAyvZcVNCK7gv5Bp/mg/ZkVOZTD5/QzpEVDZLSkEVVceL416KPIjdanN?=
 =?us-ascii?Q?Djnt+yq4IJ8jVeUnOT5L4Jtpbtf8NoillNwWOqAEb5ub6fsF8X/oG2dyzTm8?=
 =?us-ascii?Q?N1eL+unk2aHvfYErZgFdultd0iB+0X3ZzFg/+veCzQa0tX1RKkjqgDsTAeCC?=
 =?us-ascii?Q?Wqk/bCmBICbL5mnPCGIIYHgaz1ZAbAx16TBcLCd0jqtrn2g+5BB0uA6wPUOJ?=
 =?us-ascii?Q?gPFdtnclRJ+mTJZhBM2QZZGjR6REti/f5qr98pj4tbpyKHeMZdx0k0taRmYf?=
 =?us-ascii?Q?PC+AkVGX26lnp3mbH9dO7FJ4AbRzsAyKpjIi46xSUGPVq0o9pDYlkdE9Phxc?=
 =?us-ascii?Q?eFkd/UqmlWB5wgUz1n0u1B8Vryvy+3TfzNQn4Y6MLraTVUv8+npF//k50Uh8?=
 =?us-ascii?Q?BC5xD2YGWVCYNAIYH+a72fNqFB4hyAaoA8CBA7gDVXfp7t6AUl4H06ncAW85?=
 =?us-ascii?Q?iN8Az3Y51ELVClL0FGGzVNd4H2DjZh3AjTOD04cAM3H3WJ3Nl7kF2GS2Qio9?=
 =?us-ascii?Q?J81Lk/c0B9iI2x0P8PKxE+PGXjqH92wp3U/xMCZQQ1dZW5wykCZcT+ju9MGF?=
 =?us-ascii?Q?xTOb9ZWnDDhZlSlIqgdPKp8XytNJlzwb5tRc3Aos2g1NR3jeIYLd1oYokROC?=
 =?us-ascii?Q?Qq21FeI7hHjtMkjSGui/0s/ywN1AYOLo3VbExtKGmt3gzXPGIisZ85a6B3iC?=
 =?us-ascii?Q?wNPld/1VsPIJxKIoCAipKZi9KfQctSxNwkvvkKd+PPSmRwOzDpbYx/LEZZRv?=
 =?us-ascii?Q?syMOOsBx1Fq5DRdxcn4ynE5jwvoqjwc/chcIuzW5LBLXW9gDR8/Pj8X/pq7P?=
 =?us-ascii?Q?cK5fZnjz+kfK/VbKkRRbYHNt3dwG8gzlJlM4f/GkYpbpIxlDh9WSyjlrLu8Y?=
 =?us-ascii?Q?q2nfecBi77RtZDGuUKrv70g+3cfCIjpx/CSmoHiOzoLExoO5yt0HRggxxGfs?=
 =?us-ascii?Q?fzzJhcAfk6nVQQ/bfML2xMp/uM+m6nmNF64NNb47PUY+RTPGYFCWuaQFn930?=
 =?us-ascii?Q?YGgHULNUSL0UuNx4TnIGYpgSTEqCvmWOMMyyx4ScKAKVXXTxyjlkDwSf9vUd?=
 =?us-ascii?Q?OS4qQTmtMNmGRL7RbulRadbHgVp6pOstdhq79jUD5+uPKrg07g9mncZmYd48?=
 =?us-ascii?Q?Xmf0T4uuFdIYGs/PrDnUKZxvEnCcmyc6YiO4yTyyuXcYdZVfeEKBGzeSuRoI?=
 =?us-ascii?Q?MCMHiCSvR1P2eS+z6FH4+CxCSFGgquR7Vg1cAahDj3Lz6zymnhIJngffliKg?=
 =?us-ascii?Q?7fqZxO4AGBXlmTx6coOXJWS3JbBLOOhfItP6DyZjEg4vfdUdjWJWdUYPfDj4?=
 =?us-ascii?Q?l5lqTbf8VDgFZpXqN3vFcF9cyp227bUHeuBSspcnG+jWW+yF5i/CUa4sr9bv?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61af9dfa-79e1-4478-3749-08dce65e58fd
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 23:26:47.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkSDuRGhWsEmEo7IXjFzDI9raHGVz/pPxJlK517J3RtOxlQNAqSUvpwSrhgE6i6IKs1M1b/WpnNG4GN8rKalfY89wuxB2dy5ENgxo0XEk+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9688

The configfs store callback should return the number of bytes consumed
not the total number of bytes we actually stored. These could differ if
for example the passed in string had a newline we did not store.

If the returned value does not match the number of bytes written the
writer might assume a failure or keep trying to write the remaining bytes.

For example the following command will hang trying to write the final
newline over and over again (tested on bash 2.05b):

  echo foo > function_name

Fixes: 993a44fa85c1 ("usb: gadget: f_uac2: allow changing interface name via configfs")
Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
---
 drivers/usb/gadget/function/f_uac2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 1cdda44455b3..ce5b77f89190 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -2061,7 +2061,7 @@ static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
 					  const char *page, size_t len)	\
 {									\
 	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
-	int ret = 0;							\
+	int ret = len;							\
 									\
 	mutex_lock(&opts->lock);					\
 	if (opts->refcnt) {						\
@@ -2072,8 +2072,8 @@ static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
 	if (len && page[len - 1] == '\n')				\
 		len--;							\
 									\
-	ret = scnprintf(opts->name, min(sizeof(opts->name), len + 1),	\
-			"%s", page);					\
+	scnprintf(opts->name, min(sizeof(opts->name), len + 1),		\
+		  "%s", page);						\
 									\
 end:									\
 	mutex_unlock(&opts->lock);					\
-- 
2.43.0


