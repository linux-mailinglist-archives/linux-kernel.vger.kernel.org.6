Return-Path: <linux-kernel+bounces-303355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6858960B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619D61F243C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83901BAED5;
	Tue, 27 Aug 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="UABQaYse"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1642D1BC08A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763172; cv=fail; b=GqPSivECUIB4nbG8nNQ9tPc51ErYMtKzoC8o5Ym5jAN9XJD2CXNIV0PuTNmrTw6VCxVKBe9+jcTNn9LR/mrMJ1InFM9t2d5DqXsiyOa4B460Dj/5RO/Z+V0wb2yRYbiHsI6gzPSjol78YwH5YC2LmjYJdMtlOoymPgdcRfHlj8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763172; c=relaxed/simple;
	bh=SQ2tL/TphkPet1fwwyF8kYMVLEv6L7M42xeat+1TsTw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IqLTeXJvzrtfQGWxlTo5OuYpCo/mmNOUABeHYxkzQRWOCeAWVjJ6ctkh2SOYn1OmoERikGEMW/LsqSysAxKOWdi6jSZFtkDT9X1ZL8scBZgc6N+Czwb0Zwri4jjZuO5jD0WDN9fDLgCqPVs0gupSNoQdCiVVUzWrwCaGOfBp2+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=UABQaYse; arc=fail smtp.client-ip=40.107.215.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/UUnjNEvmASMj9eqFZD8H+HD1JmUM7Qzr+sp+k/VBAOSi1UkvSCXuUjOoL5jZsQb8dXkb1gdfMwcQ1fgGgBP/dJXJ+kzI8Bc+575MLJjCKnGaFJHqUM/Udop6z2buQ7VH5v/7iaoJWgMg1xmLZVyGwBYrFLoXptSdD49GtoJ8UI84SgjLS2x8drpPDn7qOvbV7J5/UFkrwoD3+s2l0rlAdBzXsC2YPbGg9EBmcZrIlKP3fwTdiuy4tRlZyH3ePJbXHF4NzBTFgj4S1u497xILXje4rxofaKQ+p6SDmUArK3otvBxBaA6iP6fsLuA6qCOR13JR7o/RKf/9QvKeCXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URGFvfUcepMlp0kGbUTWcAFFq+pUmM7XOHwTVqjSTiE=;
 b=hDoBgoSh0pWdjdqlmpe02Kf7tjjT/x+vnkdfmHkc0SYwZdjbT6YTVoUWwoh6/PSDauRp5HIHUgnDsRyGvidBvOIRD2pKYjc9n5bGXW5ff2N76Bv0uN1X1YyaDyTpYkmOj/T76RO52Z0OR1tJBZaUEtRtFyBAk1OW9YBYJ8E7SqIXQrm6vAsd22xdANyPuJrvJMUmZgVoR6nWuHjM3CxDtym8eNISwWlvJb/ObjCO+kUJK0SvA7SN9P7EnU05WyX2GhGpmrG3B1QtlU9MIaCjMyc3nhGCaOoNmCEhasanooOrwwWBsZkIMH0CYeQGBWP3LZKaZFPZDKRjNUnvolpoOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URGFvfUcepMlp0kGbUTWcAFFq+pUmM7XOHwTVqjSTiE=;
 b=UABQaYseTmrVs9j9EMGyBQJELMzdllAbmguikOHr+p25xJgj4TOgzck0SZfqL3mVW4MGzgU6okgWXyNAxwRxKDZjuCYx0vufX9qk2n74bOPZo3th44N/jZfnXCMUJGxg3jmNV3hmkXoEQLXKb7rbYMizMQfkRp5oarRVrwX2QqHwJEnazL9XlBEx/VxbfmwZNeyHtakFnroD9IeloAbbbkJrfTfYaQZQCYmc7DpHqYvq949sKebS7mWUU7TpXXCWZ2GL82QUi76ON6J3t6zl2grkvBF477YsLdIkvoLzxBuHoJJkPL/Umd5FpOu/rlyECmMcCPN+fag28QVTmaMB9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY0PR06MB4984.apcprd06.prod.outlook.com (2603:1096:400:1ac::13)
 by JH0PR06MB6917.apcprd06.prod.outlook.com (2603:1096:990:67::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 12:52:43 +0000
Received: from TY0PR06MB4984.apcprd06.prod.outlook.com
 ([fe80::d3ad:fd6a:a537:55a4]) by TY0PR06MB4984.apcprd06.prod.outlook.com
 ([fe80::d3ad:fd6a:a537:55a4%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 12:52:43 +0000
From: Angus Chen <angus.chen@jaguarmicro.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] drivers: core: Add more print info for bus remove and driver remove
Date: Tue, 27 Aug 2024 20:52:44 +0800
Message-Id: <20240827125244.1747-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To TY0PR06MB4984.apcprd06.prod.outlook.com
 (2603:1096:400:1ac::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB4984:EE_|JH0PR06MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 41856778-8e81-4b8f-3cd3-08dcc6972438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YkKQYgQBuuB+wU3rVdGtAw7cUb24WYExErPHLnNYYChp8QjIlKfoVbKHXHy1?=
 =?us-ascii?Q?krlU2NKXIODzSPX301H/Vcu/VQiCQ+1PYLXmpKrYD0fPBq17xkfiHzKiuEVy?=
 =?us-ascii?Q?rqpEPNTOv5sMC1lZIiO2gMviUWDU8h8XJowSr/0LQ9mwCe+Pj6utXQAS/lOv?=
 =?us-ascii?Q?oBFFY0+Bk2tSjmt8SGi67Xl3nGSbyRB6ZYJGRJjWWofVSRYchyOfdTncD9NZ?=
 =?us-ascii?Q?1apkmm0RIdJomd5vdOV89naI0bqgAUCOv0bfecvfnH9pMglOikA5majm4GKk?=
 =?us-ascii?Q?kgYeL0tcu+F4C1O7N4qCySEV7YNAq8k34dLGS8jqbtsaI6C6OiUIzKKRlfgB?=
 =?us-ascii?Q?x9l+41vCt9fWj+ZWAbRjJw617cwCJIaZh5ED3jGqDEgNqqpFvHCt52+B9Se9?=
 =?us-ascii?Q?Cnqo2fODuOvL6uzq9X//A5I9st8TV5ia/FKwj338Ke9TNAAgnoG+F5ppvOwj?=
 =?us-ascii?Q?YKQsaT7P5cmAeMO0XiIBpu75W7zixdqyvQg0uiV2YNOz3fkia/NPwd2Luib0?=
 =?us-ascii?Q?NEY81+ErxOqu4FKQh7ieFwXiV6QSD01D8WPnNmVqwHKcoVIirJ1W0o6OViRw?=
 =?us-ascii?Q?YfwMb1B59/9zk6lEmZdqysnXtr3hW5/5E4Mu9LMIQ8HVSD8ZnEdwpC/yP10+?=
 =?us-ascii?Q?dHCTJoUxosKWMw7h6KcdqTe8nsoS8p00EvJyYIJKSIebdMxuV52B3QpAowtg?=
 =?us-ascii?Q?B+qn1Rf1sk+Bi2zdbJ8aVdIwoHzd4c7vTMTQfTX+iN08ug8JN2hDIomVNexA?=
 =?us-ascii?Q?LKncBSoow3LyiBmSpPTt7o6nnfcxIve5rdWsbvLbRemaNIu01UTu2fD0tvRg?=
 =?us-ascii?Q?iAJNZdCi0NNldOzTUxU9x00/wvd+DlAO7al76q6Q1cxEIpm2rQ6bLokgK/lN?=
 =?us-ascii?Q?m5uODX1O0GElJICaY0crGwS+enlkId8EWtxUUHT87vhmbZsHYblILLcMzVo8?=
 =?us-ascii?Q?tCeVzu6v6CxaXqF84icE9easrU6M122abUAs0cQ+6py1013JA7H8jEAZuzLz?=
 =?us-ascii?Q?xoQbJwh61/a1/3HwwhfdUjZBvUftSTyFwg0hpZdwvdJVOjnWdbZooPTtlhgX?=
 =?us-ascii?Q?dcoFtHnQu2znsiBZdJscjg3UrL0MO9MhaHG2qDURLBr6Y0gKEAIQ5knUu7gP?=
 =?us-ascii?Q?k8Lc4eB2G5R+FkDr1Q5fnVAzip640Q7aW78/80p6774S1UzCyrcD0WKR5ZGB?=
 =?us-ascii?Q?dvkQzjw63UkM4ZoikgzRvabBLg3XJddJDKzwXSbHQh07eDlw5HqDjAHfC3kp?=
 =?us-ascii?Q?3UwDfSXbBnkjk3WWUw6DxsTouISDO3ZRjDGD/QSU65icnHGI+7erB/RZ1Pvn?=
 =?us-ascii?Q?s7hovj9t6BKXhV0AKOlz44u8VeT6BdN6B8BYnMAr/zmZQ6JRWIJ2fhohQokg?=
 =?us-ascii?Q?TqhAkZYXsN9oM/HWjgnLRvEc5/xOcJx9M9sURaEr7O/LkrY4DQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB4984.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GaXuNqLE1hzCKYVs6wDD5EzzQe8P8t1pA96QPGYn4AGlqdb7qOqhV9pIkqS5?=
 =?us-ascii?Q?u+RUw1vz8AKevQp03VzQ8fQICc6DWNVN8tZZu49nEUDqaGjW0/Zx44EGwoIT?=
 =?us-ascii?Q?nQcYL4+vmRiXrJruedA+WbOd+gSwdwfX89SvxgRxHVdr6q3jA7v39hVMdDa5?=
 =?us-ascii?Q?gv/v5qJgvmbzqGHOJMfuEi4hsOvqCnHnBgIsnuP8KqZvC5JA+J02dl5UlCff?=
 =?us-ascii?Q?lyWMFkG7ToQ0FmkNyRCUJtCnK5w+B3KwO6UYN8iCZUA1LvkBw6rO3N2hMs1J?=
 =?us-ascii?Q?W5gpMO5vtgFNG2ZOB/WA+nhmtcY6LFxEbd3jlkh8RLjvKdd3DBR0nRYiMOX9?=
 =?us-ascii?Q?GJIVJ2gQ/H8MgLHk4Jj0fsgFBjQKwan5jEmtP7lPuqtf/yMGEDAO0HPnCipz?=
 =?us-ascii?Q?lj114W2WuxVKgVWs8y+X/W5rT53SBPPwLUXQC3gGWQBfhxGvNyxccUMg/PpU?=
 =?us-ascii?Q?Lan1WjaLmCp9H4E4VQ0V9DZGjEMpTsHL4LZ+m8fyfzzgswNzkEJDlxkImGvD?=
 =?us-ascii?Q?bpc1eJoVyKViQdYBVlApuulwhWktli5Z0k11f5dv5RQiSvAXCUdKaq8E6pEx?=
 =?us-ascii?Q?qCO4fvKjg7pXgh/erb+WFRv0ZaRS7EY2q5xFahJyArr/br9wAn0rYkZvs3vv?=
 =?us-ascii?Q?GIUaNGbgEZTcdnME2EnNMulzTSDcnKaVMx3eWDGteH5TRXMJDRiZ0eT/EN0T?=
 =?us-ascii?Q?s1W30MpsasrnhLQ/EMvTc0cjz5t2YgCA4BOXpbzd0/zahA7Psk6Q3GR/CVIc?=
 =?us-ascii?Q?FMRCKl9PDrw5Hl8iaXw/xahm0FScAfrv3RYFKO+mI4mtnC9ZbkXgS+ANRUWj?=
 =?us-ascii?Q?unMdHBJNWoN0FV2Treg+4zan1pajTBxy8A5wwmHSN8peRXNZsvakOkIhu7Uu?=
 =?us-ascii?Q?kDT1+LiEn2XXYOvUiw60JukvnUSD7PpySXBeY53KwF8p8CoaUXurCYGZDiva?=
 =?us-ascii?Q?ma4EEGapiCdPccs/jSBwWPAsyNHvDMGbT4G3jPuzfqcK7Eb8TxCmHYT100rj?=
 =?us-ascii?Q?NKc62C3Q1CydrygH5ilUfHqsdsB3T6Cy3ploDVHpsDmyHC456LKHwGmjBYsW?=
 =?us-ascii?Q?5CDkKF5FXCN39vOIbUNrpSJARgERlU9r3UPLnCTd4EsuEMde3/p+rbcfMY8B?=
 =?us-ascii?Q?7+wFsGoKleeIKq9I87kljZbvvxHEaNb1nSnE6hrynmvHZXkHTxqvXVK3YaV8?=
 =?us-ascii?Q?tyaOlejntU1Ec55u1m9DWVdgqDFFFvdS7ZPgtpXDi8q4p3QE/K13N9XMB8KT?=
 =?us-ascii?Q?EH+CuacuF/Xl4VuNXy3bfxnd5cwtoYuWh+oBDiVtTtR8FIxonkqKBs8MzBpu?=
 =?us-ascii?Q?MQGzrKkf6kZNOL7JwJ6zxGzLOD9gxgBbJh/pGoueogzQeEB9y4wTxgsdeNDw?=
 =?us-ascii?Q?UbB6mBxPEejUjOrCjJQbVpWcEQ0Uyvb8aI1Tx2IqsxhoxbT6Zea8pkQ9TSO0?=
 =?us-ascii?Q?QoctPVeAH5yYncFBQnCtBSTuqYURmrLUChLRNOwJVVfdk5ctJ9+P9RRMkQi4?=
 =?us-ascii?Q?+owToha13aWW13y+NWJbzqFcJl9VP2tWp9X60qQ8xc/uOUCOz7mFsFQnFreG?=
 =?us-ascii?Q?Bq8oI6LROtB8QI1uu3+yJDJNaUlO23sw76kR1lzllBN1rIhYLMwzXsks29YH?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41856778-8e81-4b8f-3cd3-08dcc6972438
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB4984.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 12:52:43.3341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdajFtTIriLtwFqMo+KybZQPfIZqchJ0PnSm7QPmI9eG+Fx4AMkE+ILlqJrs5pezm7zQlQzN6WyZBLXB/DvsL8y3eIVfkUfkToj+kVl+Z0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6917

When enable initcall_debug,some devices call bus remove,
Some devices call driver remove.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8c0733d3aad8..ff965cd51bcf 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4833,11 +4833,11 @@ void device_shutdown(void)
 		}
 		if (dev->bus && dev->bus->shutdown) {
 			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
+				dev_info(dev, "call bus shutdown\n");
 			dev->bus->shutdown(dev);
 		} else if (dev->driver && dev->driver->shutdown) {
 			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
+				dev_info(dev, "call driver shutdown\n");
 			dev->driver->shutdown(dev);
 		}
 
-- 
2.34.1


