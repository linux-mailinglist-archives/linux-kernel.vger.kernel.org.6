Return-Path: <linux-kernel+bounces-333839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCF997CECF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 23:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF19282CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DD314B064;
	Thu, 19 Sep 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dcAgRKzM"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2068.outbound.protection.outlook.com [40.92.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F5F142E70
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782094; cv=fail; b=J58i86nOtHblv8z0Y2JB8GmWQS9D0ZYucGs30uWPM73EtGpPZW6g69QwHrjk5pVOmywTXKR/dQ8f0slMK7EL1kwJcr56R5OhlHVM5SjiK4UUogql6lyPuAZ9lVcECxsnKy1+MocOqrww5MGsnqoKMINcuxSHTNgr5/EMJQumkxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782094; c=relaxed/simple;
	bh=u7gMN+mV+ZEsWrz7gVEb2TO4Jx2Vt6CCzodG7hoxXdY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BsxtNo0p2K2DZ45nkPB5J5nWoXW86rrJJbGfDKmwPwqLyGzDqZvh46IDnQ8M9mEYDRxEA3fukCPCz05hZtv04TLfbk9oPFIXYkd/nLgc2vq3gO3VyUmRMNiMHgo9YkcoIK7Oh0XtdRyV6UKee7Z//YXLCXsy3KVlvFaSn2vnT7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dcAgRKzM; arc=fail smtp.client-ip=40.92.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIhaEo8zSWr2Xp4LdNnKMnsK+NC8LaGpbv1XShgTN2YNxZx598yZkLfSSGUsBSV6ADmHzZ9FlAx9NCk0U7Ju73Nn6Mv5jxWWPXgwf0eQAkAS3UoK90jfhmQw8nhh3m7BcVX7PMyqCyd6Tzejf4xzyQBxhg8J++uv8d+pfup5lEyVUPaX6mxtvr4tMjgmvISm6AMesPK5skbXmHEBlDnCffKy/RcBUdKqbMkGsSIkRpa+wGNZQ3yz4G3OqC5L/Fv5oZluRGc8p7v7aNlBFBG+VitSEgfoAUhmAq1IyuuJrW0qR3oKLck0uAUV8vjMaUATzYbYhrzZHxXR5LQmhO2zXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znIXMbVKkiijy+9FiPQg4zBkjtUcC/BUFTHVVdkCB1w=;
 b=RV1GeXKqTbbaCP8tNQAEO2IQH9CeUo2jGrFck31IT6rUE16QF2sCukhBaf3bydrPMtQ+KPRgOdo0wmZ9cZuIQM2RJWqK2LN+0WA6xiLstqH/uSE274gN75G56Om0pnrBkRKiubpojWBy0eSMPVv9ZnlJtp6fEAFcPnkIUDiQd5S1vtsciW2rCwvBfxaPvXOkaxXtGpNsN4MwMSDm7s3dIJNzdKFAhp4ED0+V62bYn3czt38wQ3EikfKzkj1CVnOW+jrc7w6qqG+yhqpO/YiTID2HjI4e4tzo2olSHtp2g6LCKdqXcd7hSw6FtV1Y36j0Wd3YUuAcwTQ/ONSlJ2VquQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znIXMbVKkiijy+9FiPQg4zBkjtUcC/BUFTHVVdkCB1w=;
 b=dcAgRKzMyhaAjObNsFmsaitIK+u8EQaoXx9BAbgC5VvAw8vWkcZWGG0K9tKhZirskyAEJojLqUKG0jO/Xe6wOarq5jRnQYgvvpwU9BsSiXOojRlSbchNm1QRjVfFPPX4ueoPeJN+ttRVOh44euRj23OiCYqOGHt/1I/mRzXtbvASxY1K2F5yuAztJbIBebYcshT+WSWBCZniebYETOMAfG+cMamdzIxDYBRcNtZ2ez6nWlC8VU1i+SwbJaJp07TKwFzWAhdjIW2ypNQfHMsP6E2V/zNvdQyxbDwQBg4Ys+wJcdxXaMaf1+cwfx1zQYLS6oCnLWll/bWtygHIG1m8YQ==
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:570::8)
 by SJ0P223MB0711.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:483::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 21:41:27 +0000
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd]) by SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd%5]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 21:41:27 +0000
From: Steven Davis <goldside000@outlook.com>
To: brauner@kernel.org
Cc: jlayton@kernel.org,
	nichen@iscas.ac.cn,
	linux-kernel@vger.kernel.org,
	Steven Davis <goldside000@outlook.com>
Subject: [PATCH] mqueue: Prevent memory leak by freeing unused node
Date: Thu, 19 Sep 2024 17:40:58 -0400
Message-ID:
 <SJ2P223MB10262FC2C833475F2A5BEE3EF7632@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0439.namprd03.prod.outlook.com
 (2603:10b6:610:10e::8) To SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:a03:570::8)
X-Microsoft-Original-Message-ID:
 <20240919214058.11512-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P223MB1026:EE_|SJ0P223MB0711:EE_
X-MS-Office365-Filtering-Correlation-Id: bcff8d01-a1ef-4022-c6be-08dcd8f3d066
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|7042599003|5062599005|15080799006|461199028|19110799003|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	NT5Bsw+AE122KgDcnYSkfVe6LdrmzMwt7AkNvPtgyztz4E7lspafvgBOJG5ueriOOGGn+Kzyz8p8yYXGAxv6q9LkVdA/k9hj5j6nmSSYIday1au4o/AuJWKEJKywuVFimq3677SDV1p5eGr5vnBhHQKdgMtjEAJ4MwNDtuw0k/qObsKyp6fzyM2vZxsWtO7XA0Ke8EjcXIOjPA5Wikwb2pbv8LLPfh1tvHs+q6jy2TAbf/jvJGJG+4cDbBwU4GYq6wIoDIOGUjYLIi+P1x/AP3DNm24ije2olXhEDgO72D21s/DfKi1sSaB95bJcxjCgK7pBOi90+q8z3G3z83yZveY3CINirVLWISeGhFd/vEXfjatXNf2kuDfmgBNUdDvEtXTdu8V2KXrhLCvpNogjROxXPH4AwhskG1wOB8Z1FhUvKp/rIosfkyAeqEMPK9390hIZe1jFc4r/XlzHMR36lT6pG8VlkFXo4DM5GMQZDqtqvVm1hRlX+bTBVcDXL4u18US5IlGbfLVOaIA7jx2bnGCl6HQsWn2fKFzrfDVMyW5jyo4cKezBolQIpa6vW4tLib2mmsk2CYiw84Lyiyp7wWURYd7TvWxLjfSpz1Vx1txT0r9jcQayRkkHOabDV/54rbkiXDFJCGVhHQMKG3U6Pnao2KbxaW/AYSnUF+qaBqfD64DmiOCN80ozmUNwjnWyv7GJf91TDezTysHt3iqTLaKv1VVjZE49Zq/X6Eve78KZwhv4fXFxo5A9m+7ZN+7evENsJ7ftQ1MXmj2oGdBGrteYCcN8anjIkWUU4dA0paE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AduBqkHiczwaERrcTg8caK4mvEmhVk2W/LJiNPUaHhl9Z2GJMfdGYGiuoCHJ?=
 =?us-ascii?Q?OgzXrEuqJ9RmjS//Njep+oASMtaT3rGrnKJJrxDiUpDwEzdH3dEbuM4rfB8L?=
 =?us-ascii?Q?VpMlA+EwFFlAh5JOUA82xrDz+pYLKQoyHxV6+vJ8eT8nPW1xdkUYdrA2OhHQ?=
 =?us-ascii?Q?9A1/lcujhEKX3jO3U12LcWxD9HhPaaQTJRPwwGF8XuIhdEUriYHbzNZwwp/4?=
 =?us-ascii?Q?1DZ3IWBGG/quh82phwZV5EE/TGfvpJi+NGW0jd9X06l/6v3DGBEmDvtrS3Eu?=
 =?us-ascii?Q?7wyEuANiLzYFL5cAzlXmqRctfJ3gVPwgcoKLdZvWimpsCmqBjhs5iPqeRx8w?=
 =?us-ascii?Q?KcDO7L84iGWJbTCZa+WgB9B52Ce9RMwOwEGOxWu74c/MuI8SYfsE99m6EUBb?=
 =?us-ascii?Q?hPSjXsJwEWG9UHDsjIynX04prXGQH7q9K1o0xqQ1rWsFWgjBqGyaVeI2pDjr?=
 =?us-ascii?Q?n4qyHwEV9TlrGcb41qeDWJ6cha8dzIm5cWTa6nylDjdaqU/Ixqi4Bt8W8fec?=
 =?us-ascii?Q?WGnvyXoXODCJm+t5pClMFgCViZ/tYni0i8eGXQO/BCeYJJ0cdsFFAdk1ve2y?=
 =?us-ascii?Q?k1Ed7yGCrXNuRH0f89WhIFPoSnLp5gxTxyIbDsphOkdc006GlfSYNm9bvwa2?=
 =?us-ascii?Q?fqp3ZzdvYlG238zehwqRY4vXcK6caFjfSWmvNyAZ0XWUxFRdwHpvNpiHMc+Y?=
 =?us-ascii?Q?0oNdYaOCPkt7krFl/vC7cD4o402s5IYEUKHAK1VpMqfye9wp978X15SWHwX1?=
 =?us-ascii?Q?+UbAd7WJqSkTapZB4gwcs9VwXeIazEI1X2S2Evp6btnHlRLS07J3qIpKQ0ad?=
 =?us-ascii?Q?jxCmbyko9pZTtv1OHgGcFgZpi6wKN/UbYjvS8lFagUT3yLBs5N2DkKVCAbBT?=
 =?us-ascii?Q?d7YPXO9mixg443BGjpkeivCgpMACkhemajR6P8T2rbr34a33cAlviS6/2clJ?=
 =?us-ascii?Q?m1RynI01yTEPz8MjCei0a/AByVH7cIP9rXM64M+276SSOE2HS+KlsK4zhCy+?=
 =?us-ascii?Q?8yzfmfAgUclaTYYWFTsqEUnuNMAOO+smo7D65Lx8AjMla0zXzqXjxlRAvLWS?=
 =?us-ascii?Q?GXekYij+dg6vYtG+BOS4z9Rk61r4cOOieYD3hnwu+lNNKeACo1OsOkI/b0le?=
 =?us-ascii?Q?qgzt3IJfJk4MmGDZpPvR2PadwWocYNFwOZbnigHvo7bJhpWk4xet40/PkKse?=
 =?us-ascii?Q?vf3O9Iv1mnZdqaEA5XB66gyoQobdYs0ZblP6sdUbAItByzviv9yhAdLdnRbC?=
 =?us-ascii?Q?K7NloLhpzMWzbNX1V2cy?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcff8d01-a1ef-4022-c6be-08dcd8f3d066
X-MS-Exchange-CrossTenant-AuthSource: SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 21:41:26.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0P223MB0711

Added a check to free the newly allocated node when the node cache is NULL.
This prevents memory leaks by ensuring that memory allocated with kmalloc
is released if it is not being reused from the cache. This change enhances
memory management consistency within the msg_insert function.

Signed-off-by: Steven Davis <goldside000@outlook.com>
---
 ipc/mqueue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index a7cbd69efbef..59ec6b3c1557 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -227,6 +227,10 @@ static int msg_insert(struct msg_msg *msg, struct mqueue_inode_info *info)
 	info->attr.mq_curmsgs++;
 	info->qsize += msg->m_ts;
 	list_add_tail(&msg->m_list, &leaf->msg_list);
+
+	if (info->node_cache == NULL)
+		kfree(leaf);
+
 	return 0;
 }
 
-- 
2.39.5


