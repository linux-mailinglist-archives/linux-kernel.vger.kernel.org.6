Return-Path: <linux-kernel+bounces-300735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8180395E7B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3772B20EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3FD6E2BE;
	Mon, 26 Aug 2024 04:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eldqdASC"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2045.outbound.protection.outlook.com [40.107.215.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7811C83;
	Mon, 26 Aug 2024 04:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724646931; cv=fail; b=K7Ax68W07T2vXBcqE/XdX9beOHy+JYVFgeIpbk+jwQ8pv0WofrTK8co9YF4T+rNzGYdh2fsQt+J2hV+JgpT6Av+BCWL/ecAl4eZfPYCnT5ziLPdGqyZpkcaZwIIcNRJjR48EX0JW7APFtmIr4TYlMvO0wNqLKrkdBL9GzAnzIoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724646931; c=relaxed/simple;
	bh=tBiw0pJ2lGrEOZkpV6EkRMYcUz/xqGEJDu3P7Kq50tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=T4TAG6U3QCxZoHg5LfzKCr1t9wPW1mh3eIKzN2GE9nkNuE/Gsv0JV755EIMry5cqSUrTy0cN5KiFrO7WeuUeGGSfBEfzg48IVBPDT8jsqoydRfh75AJ/ae5bsvFp2pfyax0UxssVJmjMfhTRrBg9okziH5inoCvF3fMeXsI/b1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eldqdASC; arc=fail smtp.client-ip=40.107.215.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hqv42dhS8/iLfyM/flojuIP9pp7hD2ZOE4KtRTJ4HFCG7eaFc1RRK4RhfQGKCNEMWAWqfyRi9zxPOd0FdH8GEMwDM3lwDZuDHSLZceWbSp89l4o1HdwOOk2Cs+eb0JcmO8gsplfBZUpfAVjTgFTT84GfcW5vHE6QW6ijOQUX0rruWbOmbwnIXqVTg9kM4dg9oS9giZdBj1RHmx+BNYlgUzkiul5yoAyzR3f4MQymTrgbnaHJ4Nn+cW4bsC8ruLrvzCpl/tXtuaFGtddEvx88HF5nXuHmHVSYw2sVvE6KqCzbjJQBdtA3LBEpJImuEstMRo9WitLLw84PStXyZo0l2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ93PwlKpHQNpBwIkloT8u7ghpb2MVzDECjvvDHu7IQ=;
 b=DnzDhkC7ymrBk4yx2OQ+pbY09FzoPJasxPh2HRv7f65W/I90/DAT5pUvysQ93Kkjq8ZyP1KE3oX1ENEYmOFGW0gjibC/gkHvUEqZ9dwL4OqWJnrjhBEvLaaAJ9ZPbs0mx08PO+cu36q7iyA7Vk8FUtHyZ07/7thOVJXpI1uBS+3XNFRMhaOSUleJq+owKMP0CPjyqFBHWrEuIxkVCJaa0mi1g5v8ginfvrFwn7dCFvUGYME1WZtThyEd46VRtShHZOcPEj5LmLKJ7bGWN5RNgsNODYELn0RygsTqizw/hQRfk14tznUhNPe0v5Ze7AnU6oV+VmGjs7grwUEkCj8Mgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ93PwlKpHQNpBwIkloT8u7ghpb2MVzDECjvvDHu7IQ=;
 b=eldqdASCw+Imp8SwNp/fBWVpYvYJg6lIYtf1eA+ZOXL07a04jCoVzxzTKA4HHTVBNTGN6wZGNwUYkuaTGakxXVOtDRkD+Q0HpSqslmPAEOaMdYnFYi+DYpsW1r4xqCd4mDbaG1hTdSHwcEy+zfdsWr+gh1RgmIG0MwPqvbRJzTv3BZjIh4q4RylPgYXMfPdomsSUQ3wjbFlQ6w1g+fRx2rBfNZROz6y9Gau7u5evQalke/YmQFHzCsqImoyXAcFX8M72YffI1AleUsAzRf3h/uYTcr62dvWv8ud43wCcJk/Z4Wm/sahit6riAooMbWfDxTQr7Ioi521+wlXAbzqQWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by JH0PR06MB7326.apcprd06.prod.outlook.com (2603:1096:990:a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 26 Aug
 2024 04:35:25 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 04:35:25 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] ALSA: usb-audio: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Mon, 26 Aug 2024 12:34:54 +0800
Message-Id: <20240826043454.3198-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|JH0PR06MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 0adef02f-7481-40c8-e22b-08dcc5888113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I0OFWi7sVMqSMR1kAU1xIsUzsaR81nkSUADd18zy12WmwNQDvhlaL3nSUqId?=
 =?us-ascii?Q?gkpi3JXBKjy4FCOsHCeUdu3mGgLOcx/0fxTMxUt7ya2xfeLfw6Do9hX4Ee6t?=
 =?us-ascii?Q?7a7YoS5ENFFFr5D9iHvHvIdp1JmOJtYqF8TpRQYDbnNBznAeKZZVStIgdCHC?=
 =?us-ascii?Q?s1mp7cqTr+lxKeO3j2iKVMR1ZH2Jb1KGNpUS8t6V2n8pwN0HibdsuWMyca5M?=
 =?us-ascii?Q?Tg5gZ4tcrRtDL4cz4iLFvApRHgLg8dLlTdaNjvRTcJcUX53gj1CDpJ2c3sfg?=
 =?us-ascii?Q?85TnhsxPlgHm1MxmbeZuUoh6vW4D94YCD5/t0SQeEu1RhCEf0BanymlGpm9p?=
 =?us-ascii?Q?IucAw0YEhRBsN/vQY8Sq7JISyTd3sfZV03nv293e49rdNLf4AhnjjVhaQ7eg?=
 =?us-ascii?Q?O9fpPuHyokvSqAEZ/esLyn74+ReD1akEvT0lKBDZ77rUYux8JW6j05cjHwTF?=
 =?us-ascii?Q?ETLrR6OvUbLAETOXkLvyA6J8ZqRaHtSWFIGOkcRTzSuLiGzMoZ5GA6BzlMXO?=
 =?us-ascii?Q?lHMR65GY2IK+2JsvCC8UqMy8aWiBIDHm8sphjqiTIFRH1EdjHd4GotXadP+y?=
 =?us-ascii?Q?B/srgzliUFYky8Nhi26fmBeLIII0snUxcvNCbWHBPc9JbN9IYY4+XLJyhK+E?=
 =?us-ascii?Q?D24bQse4aGh04MxOA/9+Gh2tj/FRkz1ncPCL1X2hrdZ3CErHVd7ABS05dtIE?=
 =?us-ascii?Q?ethqrrCrSriph/J83ID4xCS8oI4hdUYpi+iuVe5n1b7PLMXXau/o8jIzqeXi?=
 =?us-ascii?Q?PJwZTX4PM4YzKiNSXP5dI9fSP/j2YxaAYqPlVDboHYolFm/nYbxgvwI9ix0n?=
 =?us-ascii?Q?JXavfWacMCVNyaeXBZEQeb6Em03IxEpKaOKNUD3Dp/G5xH92iTq8Xnh9fs+H?=
 =?us-ascii?Q?6SGOIqn36ckr2bZG5bWMuRknG8KzhiH5FJHPLECEAWmt/BFC9MSUR1YK0I9C?=
 =?us-ascii?Q?lqtjYnXq0TqHHmIe6rtYTazxR0mpa4bWrj0nsQsN9/M+CLdYUws95D7baYbZ?=
 =?us-ascii?Q?WQXoZVQPJQLBDiBvPSaabWu4O9Vf5K0PDU2uEJIH1CwWgMqcb+7nWPnvSBIX?=
 =?us-ascii?Q?kNn38cl3o5axDBJUVRhAcIjso4Lakf1wQp8W00c0DXvvDjeO0bBAeL73lWsb?=
 =?us-ascii?Q?Rt9iYlYEYsCcgYKbjSU1FjXg9jMwKTTdsT1a1qOlRYkFnC6vLSiF3TbPFaYH?=
 =?us-ascii?Q?jLzxIpobT0WUxlZHbeXIi5XtOS1SVCauQPBP/pfXPMKIWMXNCD1UUS11+T+R?=
 =?us-ascii?Q?82QSFElAUA7ZUSx5ah2mOGJl6fBZ/P0kveLCH7Db60XrQsnHjNSFkW/b51H4?=
 =?us-ascii?Q?lbBdIuqYa3X/PEHZMRF62bsJWDzL6nluaB5HstWgNhpmv4YkqUMisrEuidCL?=
 =?us-ascii?Q?cytJgduZganR0dk208/EDx0SBvzKia+eUNGTyArbz0Nwsze3ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4igZJShy5nzIrxmJkma4E2sVEMGaUTnH7yFomXHbtudQpbgdDh0WKvXJ8jyH?=
 =?us-ascii?Q?S8TqX7xaZP7gw5ArXTMelJ+Ex2F37VbYQy/b3wrkh7awwFRbnGdzC2O8AJPr?=
 =?us-ascii?Q?o8zG+kngFO91uJxFGgHExHfcFF/XgIL5beUDjUcaN15imtW6/ZomxU5f/cBG?=
 =?us-ascii?Q?l/n1qtfs3PQKN1bCIbl2irri4ebZ42RAq889PckzY5kHTHg25SNgCJUA+wzY?=
 =?us-ascii?Q?uzbjcOaTB6WmcXPUf2o9iDXOUrX1LvIHGJi5m0B2vrVnjsf93OEI9ynqFRzU?=
 =?us-ascii?Q?r4jRefCKQ1IeY+bvUwKJsi2D4skiPFpmF0vmIpffAafZ27q+hLXnzDM89agg?=
 =?us-ascii?Q?GiH1g9IBqYyjUx2ICmnLUKQbX1f1KoftvHuYrNe6Gbi1+A4GkTpQBVG0S/E3?=
 =?us-ascii?Q?jUq8u8JVOspNG3hmSFVzbjj58uYaNTmuV/rnL2Tdu8p+BWncalmXjib+X6/c?=
 =?us-ascii?Q?4QXlQe123vAoizSUljDzUnsmNHewo8a00anZnVtwax7g0c7PYtD3LSpYh02n?=
 =?us-ascii?Q?b1UJ+FtTPmb589M37P8sEeHwXOOFrkBmpy3qezkPqvZre/fjrNMU/t3wkuKs?=
 =?us-ascii?Q?LjZb/xNE1uFQkpkNmrrcLZQ6Mp7rdOpBIYWfg4g67cnaXslqBVy+1vp9QrH1?=
 =?us-ascii?Q?PBUveuWRvG0Rh6BvbfxdtFOqwjqiBfpMlocFWsMf1LDziU3BI/IbRMpiFf9W?=
 =?us-ascii?Q?mHBq9OBk10+wquF4sw6F+mC6Kh9HCLVCpNsRCn4p/NLujC27kBRgkeAMZ2+H?=
 =?us-ascii?Q?1IP18uYrWyUzkmfYr2udj6oRB8+OuTWzTSZilaRxL4aj8ZCmbnNgfyYlTSvb?=
 =?us-ascii?Q?vrHkHW512YxILyvHivn1XlIf5MWBy/KASyIlDlpf4pLVXEh6xC0X1GPOp9Ma?=
 =?us-ascii?Q?aJ7BnPITIqIJ98YBHIruFFrMEEdIssZHvk95uEA4h0V45z5BaK7ERgLnRel7?=
 =?us-ascii?Q?y1LIkDRuGwJI+AFjdEaoewr7bXEDvTpzKKPvLClBsIoG2R2Z7QtIwu+K1y88?=
 =?us-ascii?Q?dtHZokfXL/VQ5yKPNQFDKyomgkdwaN2/7DxbpH7rBwtE7Q0YXgsoPr7ByEBF?=
 =?us-ascii?Q?U3weUSMFVaqLASk58NJuX4WtxqDhmW6CfXJWzh9KdK4w8j4dIzwn3oSB3DGd?=
 =?us-ascii?Q?0wGjx/qnona8wSGSgSxOoVaVrSVy7OSeAJoEj+cncqgJ89sNDmSQxfu/umj+?=
 =?us-ascii?Q?rkjxwEbVOU9knFnmyRyT70MlGYDNmYAKOcFLmnGXV0wfTLx2/Dcj7gtx1FtY?=
 =?us-ascii?Q?VpQpet82qKi7M/L4ALD5OUOe8T0psS+6QC2WtXPTHkQRgJTtMsG7+/z5U8XN?=
 =?us-ascii?Q?9fOsyPsTIKAKYy/CXmTbomPx08vV7FQ5N3Xgpa5qGNmtrTEUcQiTVcMB/I/g?=
 =?us-ascii?Q?xyFZo6GWxCoQ+HvK5NDLJ+YNCVr78xrml7gq4c8uX+ANFGUUuaDFNwG0Q6YF?=
 =?us-ascii?Q?1l/goNXnIbApy62mW8pzYbmUci5JbkM+kaxS6j7AaCw16RC6W/WRj/GTWUn0?=
 =?us-ascii?Q?OF+3pyQKSCBrtxiIL/ok80DH5kzt+qk3NmJONv7vpeXVyhMUPwEDjJzUdDBC?=
 =?us-ascii?Q?rxG+irN8psAoSv3WUY4IKDu/boKazIUSH6Rqwc9A?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adef02f-7481-40c8-e22b-08dcc5888113
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 04:35:25.3705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzM6y9Sc0ZkNzBHG5uR38Crl7rN/IgBKwDM1q36y+/Cl/zesgAXYES/zZ3dQoc4vZ/6laZLZ19kheABCes2TLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7326

Let the kmemdup_array() take care about multiplication
and possible overflows.

Using kmemdup_array() is more appropriate and makes the code
easier to audit.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 sound/usb/quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index e7b68c67852e..53c69f3069c4 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -167,8 +167,8 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 		return -EINVAL;
 	}
 	if (fp->nr_rates > 0) {
-		rate_table = kmemdup(fp->rate_table,
-				     sizeof(int) * fp->nr_rates, GFP_KERNEL);
+		rate_table = kmemdup_array(fp->rate_table, fp->nr_rates, sizeof(int),
+					   GFP_KERNEL);
 		if (!rate_table) {
 			kfree(fp);
 			return -ENOMEM;
-- 
2.17.1


