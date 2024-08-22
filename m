Return-Path: <linux-kernel+bounces-296809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBBE95AF67
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3491281A41
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18EC153565;
	Thu, 22 Aug 2024 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="T/TZdrBR"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2089.outbound.protection.outlook.com [40.107.215.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D60A933
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312178; cv=fail; b=UKTq2gKJr1GLQw5g+KX2RP/nXL9fNUe4ebTn2TkGaT2iAKewgakVtB21lrXpiFYvvCiFb0z3MPiNXVojGDu/Lsrts7hp4fZ31wMuR9g7sSoHES/Ya0scj6/KeMyenWg9k8AH2ElpXKtWXq7vMwHiiBa7ixY30lcKftKcHC/u8Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312178; c=relaxed/simple;
	bh=KnmPGMUnO7MpFF2bYCqKMpa4Pm7F3bsNqbbBIG8LDtc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dLUJ+eaVn60Q156Hpz4IvzRqBnmZxOyukAIc+4Nq57D12j9BzjEVqSWqcx6VU4HXtGzbkuc3hBC1nYyg86iAOvsWb4R5ZeHfuz5rkqb7Gre7AR/13IjFYCDkAQG7Qy2iBJ15Gld1omY+2/y3qOULUxhRJj3QgPEhPpR3OkuoXOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=T/TZdrBR; arc=fail smtp.client-ip=40.107.215.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFpKkavrDqtoHIvtHsK51meMbeacyvg00CzeLID8X6ah0FnAZM1rKnGdcTr3E80tE+WtrX/au6SugryE86+Sbn1ne8MxfVOPTmBqIA8eHIaEbWSubngzT8EfvWIbxHoEwfZZ0XzQyjAuO3Tc3DO+gIJorERsj2SLHmFpNWyLS+RqMurGvr2u+iVEasJV0MI9FuDOVV2PzggozYiyTfW5uqjLKJZPvkrJpJaCBiTbZcvynjccsZFm+LTBg58vkfODwJjo9C6BKSCBK9XkbMQU4nyKL5MV+KY3YOC85iNuVdjceMG6Z0Kr50+ZGTPM2PDOVVe1EUcFiaUzqAlNxBfTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2iD67AaaqjbDxHWPgzY3HiLCZs/CrQmezHszyl2IHg=;
 b=ezcldmlrjJoMjhhfQZ3TVglWV6pQ22j6rHw1/VmJBXqk+1mZR6lyvDCJ9j7XMxUP7bWTV6B0quVtirnhlw7I9U2ZVfec/wEDML4zly4elK4H2RuvP3h8PQs6iz5cQrxlxTz6vaqBthjJl7mnNnAiuJQLCadl7YInPNNLl6G/o6e5dVzrnDIn2O0PsY2ddxwyemPfcIlt+KSG9lG60VlMsJbWAObJDGeIl1i4GBP+jcQb+6Te8DDWlqkJiaYOmkna7dXE/py0wp7sg+44LXExu1jTAK/G8KviIymEzIgsAyIbjTD0fkw5/azacApELNHBTWnpM6NWtvD//QyKo96ZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2iD67AaaqjbDxHWPgzY3HiLCZs/CrQmezHszyl2IHg=;
 b=T/TZdrBRzKyR8VWvvkDHYo/2vaS3jG8wlN5N5X1l6PRYkj1qPjXIuLlw3GOWnaC2tCSmHl/xz/6J8a1VoVv+MkNJHgaypPEe0Tcxi+AAX8+H3k6s7nDd4XGP81u1s+OrTDvt7lHAy6iO0gqU2DEcnTTkgGPHBHPU9u8GoEdlATkJ3R5xPW9vOYhEtICw4AK2h5CHyj5Sh2KuGL2Kd4cBEk5qmoKsC8/7zcBYo2ceDoMnQIfAbuDlLkfgyvvRf/zzg7kjiUMmNsyBDvpvBR0kr80Tud7rgMEaxeL6ZnWOMB4qG4w/vJLoL+X3GlGIiFj3RvUKQD/wzJw5uZR6NDLOUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TYSPR06MB6289.apcprd06.prod.outlook.com (2603:1096:400:411::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 07:36:11 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 07:36:11 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v1] drivers:coresight:Use min macro
Date: Thu, 22 Aug 2024 15:36:00 +0800
Message-Id: <20240822073600.1359333-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0109.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::25) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TYSPR06MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c67b55e-77fb-47c3-b554-08dcc27d17f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qMYRwPewZQJDUOph3CMWHewrkUzjaRe4AtImFRD5e83Me3cNyYjrsLDArFky?=
 =?us-ascii?Q?sSqTTV2vInMFu7RETbgPNVmlmI2Efg1Qtn5Wl7Y2ffyZO4ffxe2K1M3+4uzw?=
 =?us-ascii?Q?r6OQQ3/UJmiVJ1RSSgySLCV0ZFQRxl+7DHQKwe6wNNfBNcUcD2tmh3MCaRxT?=
 =?us-ascii?Q?xAj9ots7mgzVYDtDvsmKRfODX23AEVdJ64a9xZ1I/ECyTX31GJX9Uka2aERf?=
 =?us-ascii?Q?PlaUA19FT3WqEfIjgVTXT39TSCxqISUU7oauIoN7V954UdP9GHxKqVv6bd/o?=
 =?us-ascii?Q?EhWy0I13veZpJDwia9ZlLUuKv/uch++txWQdxMEd3xA005WuAuuAg5enJpYP?=
 =?us-ascii?Q?8culKS+DxFoMnHkqMGEkKXIGS8+w1qJkLmTMWqsZpU0Mbu2rF67TF4GgIo+6?=
 =?us-ascii?Q?xgFV79BRB5nobMcjQwAYfFlSa/xtP5OBhRjcuz+doic6k+kg3/hP5/MCWq26?=
 =?us-ascii?Q?sddkKs0NzkMr+2gTqy5BSYialzrwKeflp1l1WjVx72wQVVcM99FMj0uqiZTI?=
 =?us-ascii?Q?50f4K9D/uVPFtzxGUetCwX2wA77w1b5USIDWhKaLqkOyQ8yudaj65rVCk53s?=
 =?us-ascii?Q?NhnJzvkl/ONKx07D+19uVrsWm2YFV4IWyb1EY5CxIFjCbynkKGv5ACqlX5uB?=
 =?us-ascii?Q?PFtdHcgsRMcUq6nZ4+DV27bQ3F4/yNUup2JE725R+kzIa90qxSOIjIffWteP?=
 =?us-ascii?Q?m9PSl/TlyWmNRMRlLRN8d7dfjQ5xq3nQtDupCWm2bMlY1DBtLK2dsp0AQ5fA?=
 =?us-ascii?Q?VZXaVtqsNVjcf/03ud4diXqPUAD0OgdMNhDzv7774t/JdeRcI1ca1L9pGIwA?=
 =?us-ascii?Q?SiuevrLHalIn4IsxeO+Q1d5wvdhHGfep09HwjyiWy54WsPFkDRsTrI0jgqYL?=
 =?us-ascii?Q?4BmISqerN0eLCY0qOam3cASB5Gpdji5Odu1DVbJ6ysd30NafugKVS26pOkFu?=
 =?us-ascii?Q?HNeuVxRZh4TS7Ii2g5usetmRv+Tc1aEBiCkZzFsr/PHBjaLsxmWn03O6uXWe?=
 =?us-ascii?Q?k7RoFA2i9DF1tsT46YYjgv+6qUJYTwID0dz0yCYHnn7nlg+QmdJqKlJu7e57?=
 =?us-ascii?Q?L6z5moTA/X6ie6Bg6lwODGZDiCwJHWsqqHxQBpVv+6iYCfd3dN+GVk0OZbA/?=
 =?us-ascii?Q?O0TlXGrlg3Rc2i3OubNM5/eX0q3yY5qRqtSnFtjqjOK+1Uedjq+ebErmZoJa?=
 =?us-ascii?Q?9y3HLMjmO2vDAqmW4TSi8PvxUYBn8iFT4YT3NRx55h0XMPHjLSrqyk8JIyEl?=
 =?us-ascii?Q?3nukkEUcOwp89htFTI1lvc4eCTEP7T8CAA3SA23KyMF1DnfpGNZrhOHYyVAO?=
 =?us-ascii?Q?KRdu0Lnz0smv+X2tB/5ZeB1Ps8Xc31BnSYzcbMZd7OvjQA9BnzIdV09wA4sG?=
 =?us-ascii?Q?CdUn8CAed6Eps2a4jzIGmLyYr+KBNpUWbqT6FsFr/zrb5Cia3nlsXFeNzSLp?=
 =?us-ascii?Q?4D0xljtgfzo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tw/0nTGUSEFo81OD158boAEr1MyNNOKzt02YOXAiGfj0NBokJ/r18IG3qQOK?=
 =?us-ascii?Q?cVhpXxXKkOakNpnYr9despdQqrOIaEBch87hxJJnd6rKHvwimglBAPP3+fPt?=
 =?us-ascii?Q?3mibiJlV+juOhOFbSd4/70PsoVd1YJJ303KlxuPEf9HJBmuvTZPRHucdM+K+?=
 =?us-ascii?Q?KFnEMwl4ZZ4oO6jToEq1QfO6RN1ZgHGMhj5lRzMl3Gv7SrpRkThjVN/gzIEf?=
 =?us-ascii?Q?5N1CTETvJ0HkAX65jBRJS754Zt4RCvILOPgB1QfrRJWQ/nNr/iC048RZjZKE?=
 =?us-ascii?Q?tkdIKcLrlvvvNvM6H2V/O7s5NdM6NIt2pAGvfA33DtbwLC19kjJKI3PrjscK?=
 =?us-ascii?Q?zGT5ZXDAFpjSaTlOtjStusp9JaD2S1IU1SvsXxJu+JEX0j2JUGNe/rc6mfq9?=
 =?us-ascii?Q?vBf25IBhm04fKRJr7peDfss7JjqDts+EZcci6GVVBMh3UAT4N3F4qZlX5X5a?=
 =?us-ascii?Q?hJ/3addVpE5npEsqKy/5L2KaNdV6bFxlrM//0s50/HQj/WR1Kx5QQkEfgz1r?=
 =?us-ascii?Q?WiPhnd3nh8SMz/Z4K/3uVNMkZqHoKabg7pEzy2bH5fXDE2XMJJyxhecOtn3s?=
 =?us-ascii?Q?a8SVINMTOVhyw8Ahkx21icIQkCBHL39Ie1mVO9irQBPoG6004irloZ2NdJPd?=
 =?us-ascii?Q?wJsahelGX49bSMwZGAB/5Zx4McHYgU/q/D58rIcC4CD2tLwNtuJ+ZZbCd6vG?=
 =?us-ascii?Q?2uKslpurLnW9t8nQ5JdUJE+FkGNdXmXm/PJcO9oohKDwyEq/YPLDA40Egx3S?=
 =?us-ascii?Q?QX3trw2rLopHnB3ZmTej/XISqsRjaB1jO0cS0HiU80IWP+Xu4XDkDXm7fEil?=
 =?us-ascii?Q?l+H49lpFrPr2w+H+BLehWdnCNygbUUuOErx+V0nC61G75pgsuNbnk6mhsyzn?=
 =?us-ascii?Q?YFHwYrtHC7WMpNKQCdG0GC6sWNAwr91+xPxRIHSeqLWiQJdrSJVbgcFZ8vcI?=
 =?us-ascii?Q?ECwfmjsRHePqPAtFUc2UtS0F9CNHzcZFtUENziUyzuPqXxn2PoyNj4EeBJ2l?=
 =?us-ascii?Q?4mCNtk9p3nY63lQutsnBi9fFYeBUS82Pe1HUFTWWOGVvcJxnK992oGW5Ow5i?=
 =?us-ascii?Q?qOVZTBoDFWyoDlppQQ2SNp1o1I1OFw4bhnZZ+Rf1HFmKD+SL2eLXeZcymW10?=
 =?us-ascii?Q?y3H4GiwpKOHS4ZKIYabkk4VrJjKT1p8zAPWTZJXIye4j68tDw9wd2//0kPmi?=
 =?us-ascii?Q?55vBmoXeRS/4PPKpVArR2WMIxcHJKI7YGZzwf3zUXmux5YPW+Hms7RaO7mo5?=
 =?us-ascii?Q?6zO4RDiHzCGUMmkZaUVpJcwZ3ni/P6tJ++MqlAwmQLCa9SFgklXRMiKLd9rK?=
 =?us-ascii?Q?jAE9DtHRCMj+k/WOkX26FupKIO3NcQFcfkVBDrpEm8mNpIsfUwMhIoGrX/D/?=
 =?us-ascii?Q?ITFGE/26dgO2j8A0M8WGCoSaEaZeJHD44ylD4k+vDWz/J6r3E6SFxNqUsWHc?=
 =?us-ascii?Q?ako/3u1hhHBBXgg/DP4Z3eWrS48KJhtA6ruMUuATfohHCctsD19lITavPP3s?=
 =?us-ascii?Q?FCP/wovNICRm+sMa5fzxj338UvAGkRaJB4BYJiZ8K4UxNVkz9hZYvZHJ7iRf?=
 =?us-ascii?Q?90v8ksYOqiEtijap8bE53WkpX26eIQRix1yrGDxt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c67b55e-77fb-47c3-b554-08dcc27d17f9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 07:36:11.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10pRDPzNM7NWhvOEMlEv0b5sQmSPhK3MzWnLV4/JJkgxfNV3lmXSTe+4tSgpAS+NSSRlaN54ET3++f18rDw++w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6289

Instead of using the min() implementation of
the ternary operator, use real macros.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/hwtracing/coresight/coresight-catu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index bfea880d6..7ea67d56e 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -152,8 +152,7 @@ static void catu_dump_table(struct tmc_sg_table *catu_table)
 		catu_table, catu_table->table_daddr);
 
 	while (offset < buf_size) {
-		table_end = offset + SZ_1M < buf_size ?
-			    offset + SZ_1M : buf_size;
+		table_end = min(offset + SZ_1M, buf_size);
 		table = catu_get_table(catu_table, offset, NULL);
 		for (i = 0; offset < table_end; i++, offset += CATU_PAGE_SIZE)
 			dev_dbg(catu_table->dev, "%d: %llx\n", i, table[i]);
-- 
2.34.1


