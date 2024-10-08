Return-Path: <linux-kernel+bounces-356047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D54995B7C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B0B285295
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2F6217914;
	Tue,  8 Oct 2024 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Usi2Bio6"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020112.outbound.protection.outlook.com [52.101.56.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A36213EFB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429530; cv=fail; b=M5Zzssca7CC2vlhbajefyFeA4jvZPnl9ZOo/TGniHcor4Eqa+Tlx9ao3laFYYfwQuukh7eOW/8+oxfT5upolPQplcYz0i6PLmkrdGIu9yXZ8SkDsOVMiwgGo7zdM0zXaGnQME9NLVD+OA30C+8nOF0HZl5txKNZx3YK+6l7zbHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429530; c=relaxed/simple;
	bh=a4rm/h8hhjegh/vQ77aaO2hZyYFdCfORDDbSSSvxpmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=anvd3Rucn5XklDR1i2jfsAtZIHg0uE5xCfTxOY7KrxUcCcZnDZD4DVTU+0a8rZ8suEEhYW6Q2bO+7sd94RGT203EaasS3ITgHa9Ki6pAVV6ZU7JjV9R3szjZBs2jSQuM31fwrBe5oz5opSE+Kin/3kvJiVu5zri6d38mDoKALuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Usi2Bio6; arc=fail smtp.client-ip=52.101.56.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pa648CGO4sRqiNOcJIG96cLcWRiE5lgV1mLqadG4CLsLIr+vD9z0i+A3DAFoefygjEvTJnARsiOiRdZE+L8KZlbrl0+8T5zuBgHDLXdN3KXp6WjIh7pMfyeCJMm/gQf6legawR0kvb3ay5fKxivJI07sKtIOGisvggF3ozuSUhpHQQKjU+VFsrzEET+vkN4shyfzAzA5oTUmwH4X92EHUzWCbj6B25kEHOZX+rUG6nDIafimEpk1jw0Dl9S5OeqtKXye0rI/3UNKndMygA/OZNgNyf6oiIqwGjmNSlgJ+0ZE+wH7UXCj7as5/26tP3zyE/Eva4K9+tHXdZ+WaOiFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYRRst4GwbC/nb9seL+HXRaN6b47U5rIhN8+jCBdi5A=;
 b=K1wInTJ3Hgb2ibItY0Hw9vgK5nzVw40cSF6740EJ9ClQiQCKCTzu0x6yuyMptAJxKAoGannmL/K3oNdj4xS5FPb6/z6DyDEF8LVSORtiSzcHocAVJkNrAH7DR/JzROhyYrsQzgPR0maLqf0gfqc1eYA2KC209qmdo4WcgkBp0Cphfr56zn7GDYRrw7nyk/K8QdFFrK+kmRNxLwQVbn9Hvs3nyp4LItPghu+tsjTFfZyO0WiVoGq+wZ+ES6735xub8DE3B/mVmPVnzEput1iR6mRfDttC+KpAzdMZk/OnaOItNGhUTsqmMbZah+gnYLN+A5TUeyLdfFQqM2kONeiqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYRRst4GwbC/nb9seL+HXRaN6b47U5rIhN8+jCBdi5A=;
 b=Usi2Bio6rCjsrw2vqwjI6h0JW0PomlqF+jPaFBQvgbBOvw7/7ZvA69MHCFhJ5i+Cm6kFfpKrRe/jbgVynj8ks8/aGlC8tFQ0DhRMc0tjDHJOvmhoLlf+OwuDc9OaRFyXQ9xL3rRibWTWEjQaK3bNsEeQLd7ImLpl263wXDJUOlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 LV3PR01MB8463.prod.exchangelabs.com (2603:10b6:408:1a2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.29; Tue, 8 Oct 2024 23:18:46 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%7]) with mapi id 15.20.7982.033; Tue, 8 Oct 2024
 23:18:45 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH 1/3] perf/dwc_pcie: Add support for Ampere SoCs
Date: Tue,  8 Oct 2024 23:18:22 +0000
Message-ID: <20241008231824.5102-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
References: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:930:8e::29) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|LV3PR01MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 070828ba-be32-4463-ecdf-08dce7ef8ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fNIcU4E5S075DMoGXxeXXLoLZoysZ8S/T9zVKqvRqFrpYh7suVo7KjQWzczu?=
 =?us-ascii?Q?7px/jXeZnlqNZBz5YW1ZU69IbS79TLJAZexIAiTLnfTDraXAgCc/FNZlYgSe?=
 =?us-ascii?Q?+CQagW+SeHDKQCqJOmaVuvb9OKmCBxMk3obio59nc2sFz6048ahJD1BJ8vxA?=
 =?us-ascii?Q?ZbszQ2vYfSs+JEjx+90yw8JBU8Ndu4/DAMAC/2U2417921vNTU+7agIfqEfr?=
 =?us-ascii?Q?xezfisnMFRCjH0YxL+YGT69qhBrXuHyjfc5Cmn7cfxSdfMjbW7yV45qtVErE?=
 =?us-ascii?Q?LmAmaz7W5wIlM94NnOFS8pMb6BBCfs3++B7TD0x1uevC5mg++UHgwi8zcx7U?=
 =?us-ascii?Q?OttrMMLhgBDmU5JFihjhLwxd3c8unMW75t6L5o36sxgraKbj8nQ0a553EJQb?=
 =?us-ascii?Q?wiSUbtOiJShxM9WUxL9htdrJehy0gHthHeZsbD8GfBvlG8k/afIRpAVo+CUB?=
 =?us-ascii?Q?QvHzVPi7/BVoUDYR9ib4Z+mRNVVU1ns6gUM7BBaCUEPWp25qUcWYAKYmpTlh?=
 =?us-ascii?Q?mbiW4m2d9ckB6vi0QigdcSfMVV0faBs9V48LTGrKt9LShnZJERSJnv1ARsfB?=
 =?us-ascii?Q?ifvhYrrPwfvn36M4nhFNQBYqkI5oUPWgU4owVWjfiJzbIq2emeBC4uDZuLHq?=
 =?us-ascii?Q?/5YZsTigMlmwXdT0esdTKzUbGC9yTQY04ZSH7KnCHyZ2UWkJgKdvW4h7G/en?=
 =?us-ascii?Q?/W6dtVV3bh5ySymS4HlvgmA4dftIEEjTnGxoldtiXd27fP9NVjjAMHDCRSYe?=
 =?us-ascii?Q?CfHJsJfpl5RNy+rjQfZV59gkJsKaqZj4I07Czrm/FL47jMZ6hPzRu0sESomk?=
 =?us-ascii?Q?1FI/JM3Yj6MncO9HqReDOxcRSf9uET31HoQ332JHLZM8dFEuYGJmNgX7DNuL?=
 =?us-ascii?Q?hZ0r6NrbtsbQuMUjURICuh2Nd8yh57YdFOWVpCNUUcLC4J1+d8kZ9K8a/CNd?=
 =?us-ascii?Q?uJaevLlCAzBhrfKpGoPUa+4OhbPJW/PhyTtRL+WuW93wZpPmd7xchGA5GuXZ?=
 =?us-ascii?Q?RmghQ9JlLbMBnOuaOqFYo98FNnxRGXHxLHgWhB87pUa35To2+f4VIlyiiOXa?=
 =?us-ascii?Q?zicYWAFXoIOPr9KRhJmDP8W+9JE1PUJodNE29Gt3jVVIV65j3LoqtshejDch?=
 =?us-ascii?Q?ziRhkyPC+tf3H9VNJhSkD32+GtE1/CJPDxeGUSikokz4pL8b1YrhKhjLJJT3?=
 =?us-ascii?Q?8GU94VHIVJnmc57jIVQ0W/2vYsUY1KLyDyFr49/m28HW7E9AWZe2BYHMimdE?=
 =?us-ascii?Q?oxJrLrMr8TSZ8EOEgrfQrOCAgZmey5pDQD1gpgYR0zBe9egOmIr4hvCHjZ0v?=
 =?us-ascii?Q?vUs7Y4TnJuDEYb8YbgIDsOZ1Ku+YQdEwXsQpQ5dhosvJog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+jX4gngFMCqOsRmswqVSmNaPnZsk2FeqYOXWah/KkvSdTUPsG5L86l1QuIUW?=
 =?us-ascii?Q?4tUCEoLMpnUZhet2sxoCnL3r7Wj7t/sYUMSVIaR2ru4aU1sS4+ZWV7aZGRe8?=
 =?us-ascii?Q?RVyag8cfsseTRJMTyb3W/bfK7ffC9pRgOLzv0tWIiMBThJO0fieaPsKfu0Z6?=
 =?us-ascii?Q?GGwUAaPZ+EkLkW4IYIEckQhlyiIREtIpah8oMkhT+mx1Dh4yFGckZxnNaGuk?=
 =?us-ascii?Q?YgjIgaTH8USMlLftu5la7WEwEZDvC07TaSDchHgw8chFx3tKYKT1vJTZUCCo?=
 =?us-ascii?Q?9LGECc/G+bmBQAN0I4/rTUMCv+Kh22jDPdvJDKKt5VJQwXHS56ag3IjfEpP8?=
 =?us-ascii?Q?//qRQxOv6ypYW5w/6iCgWUjSaCFv76BD7Bn1dzhUGKLXpTk/4KE5pNLzItc9?=
 =?us-ascii?Q?KeSNwL5enYdFRwaFh830Dbx3Zqw/Be8k5IET5yGh/EtdvQ1wEt9LZhfva5X5?=
 =?us-ascii?Q?YpTRJh2x/xXWl7OvIxc58mGDh/wG/2gRIa+1rOI6d9Gobx+lN3XKu6EGuf/m?=
 =?us-ascii?Q?CJEUfE+ide/1gvJZg4hPQ48FTTxN7zUNUkuzU9UgEp+hMog2IXtOA5nOuuon?=
 =?us-ascii?Q?Hedt2ErHEogHWmyySODGHj3hLB51kqwyIOSiQnPjOGdoI4D18ySC+T4MnmHV?=
 =?us-ascii?Q?pEIZq8YvMskmgFc2J96Nu9CVWSvNKVISl+GLxz8IGUGqAOYLLo8iI9fcMqpo?=
 =?us-ascii?Q?yL3XIflk3XZS4KOcAr+VU109nvqcn7JxBpf+qff7HCIc6RAQ8SyvKhcDuKHf?=
 =?us-ascii?Q?cBTyJA+RNR5vzttvd0cXVHNSYJvyA26cf5EtSYtUHCXx5Zr7+LFze7TanyvA?=
 =?us-ascii?Q?TOUEnIuf9/IOzpY40kGrOtd7Hjk9kC2qkZD+fEpUm3LkrbLOMrFkG9pMr6MI?=
 =?us-ascii?Q?FHEpFqpphRmV0zNdxjIZD4rUPZrKb+59T7GSymOK33Q0i2p5jNDW3+i1Co+m?=
 =?us-ascii?Q?XUQlacbhJEr8eF7BX02LUa/cIdzZVJvz9wkC2GUE8K7AOCVq//b/I49GkZwk?=
 =?us-ascii?Q?yB6m6jdDPvj7DnwJb4Vw9PBi2znsOR/U5ffE08WcaYUf2riZQ8479JJFqoJb?=
 =?us-ascii?Q?AzwR3LrhKRZBCafikJaE82STKGHdYbmIm9N24R+/UYlpp9iOEJX2e5dnJ+nX?=
 =?us-ascii?Q?6I2G1HsMSXn1kZtiBMSP6sMD9QtsdvkShWiLNrxIuojiNdmx8OrmMYW7dYhL?=
 =?us-ascii?Q?TYSXTNRnC6m51ycxb3jp1wiNOGnLnUxBKy7KH3LC/xcBy+o/Mc1Xcjqzlplk?=
 =?us-ascii?Q?8a2yM60WeEvcJdW01s5dNeK0r5jD6vmOejaBdeiNY3udHqwLQTMzATxjfWK4?=
 =?us-ascii?Q?Zf1YI2lfUSMExRXfzO4GB/CCjf24OYS6XvD8kqrRJehwaeVHbS2AOtN6PG2a?=
 =?us-ascii?Q?Yki6EZQfXjroY2vKk41XDVozwC+mV04enfNpKa0REz1bO2zG6va0GQSqSwh6?=
 =?us-ascii?Q?f1nHiklqfJKnoxf/37EMTmHtsVkuwY2AsZ1JikqUom+N4MCpHoVgg9UMWslJ?=
 =?us-ascii?Q?RRc7uQaKH8QdUAoPvL2uXjSkzZDqznfmgznegx9j8nU7il4RjmNltYKupQwr?=
 =?us-ascii?Q?WQBvl7Cs+IVx3OyXo+02Lwj1N9mF/uD72NFLsyOg3SRo1O4qs6543s4Cubzj?=
 =?us-ascii?Q?ggvzqqfgr6OQFwlhnD7N5cg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070828ba-be32-4463-ecdf-08dce7ef8ebf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 23:18:45.9196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nQbFDr/gX7h4sWuWyxrqRjudGuQNFsQooBKId1+rgFInld/8LGudypr68D+OYpt8ikzwa0GQwD4cZrVvKS/Z/1Z/MwFo81+WoWVgsXNifbYfqj7YawDXVkKf1cqrUgz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8463

Add support for Ampere SoCs by adding Ampere's vendor ID to the
vendor list.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/dwc_pcie_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 4ca50f9b6dfe..3581d916d851 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -107,6 +107,7 @@ struct dwc_pcie_vendor_id {
 
 static const struct dwc_pcie_vendor_id dwc_pcie_vendor_ids[] = {
 	{.vendor_id = PCI_VENDOR_ID_ALIBABA },
+	{.vendor_id = PCI_VENDOR_ID_AMPERE },
 	{.vendor_id = PCI_VENDOR_ID_QCOM },
 	{} /* terminator */
 };
-- 
2.46.2


