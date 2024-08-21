Return-Path: <linux-kernel+bounces-295399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75758959A82
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F3AB25615
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56D31B6551;
	Wed, 21 Aug 2024 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ld2cezoL"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2069.outbound.protection.outlook.com [40.107.255.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23345008
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239337; cv=fail; b=DdXyy63cdvkmeII+1pvzwl1zgtSRP5pQVfLJf0MyNfEpC5EBvJj9CKK6kbeH95SClgi6grz0i4lvtordgt3nbkbF1AbzfOOC4I82nGxXOaMu0cqvD0yLjbtHLZflF3CExfFOspyl6G1rTzkgKHn8KNwyziZswT8WQFaAbJUHgjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239337; c=relaxed/simple;
	bh=Fv62/SMZU0vbzNe9i0DRC2PkGadgFBdzx+B3RjJoDgI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l/xLEThuP+oEyW4fDOMgWwV66auuG0dXSBlx/CJWrPTckWBxcoHV0TWM12aXDy3e9iftPaZq6YpolGwo69XxQl/gl1ZH6v8Un3jjGF34pJHzgTRSqqcz8eQ2hzeIf21zOVaNWKIefYZcDbW76NoijyYQTVaFiuyk0mdelUfZJLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ld2cezoL; arc=fail smtp.client-ip=40.107.255.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QS2TFDQpbLNCyReYtqPSDn6cY9Gdr0PKhO1lJlrCXW/Nv2I53bC9/6gLjLf+jMmTbVikViMLnIAuB3NxL6TcjNCSy7D615h86Pm6cD4uRx1UmXuzYVG/tysvB+ZYuIsnvIz+b3fb9n9vR5RdWtR8+JIxUMEur+z3sOjrdwORapjy9oNkGv9Uz7E6gDNxm1wQfw9335Dzsiq0K1WdFi0yjdv3ZJlDVE4hEg8JT0JaayUopl5/mOG836S4PvdNohyxx0wd1n79zb1TObCQwdaS09NA9m1JTZ7J7H5RNZj/DVx9oj1vznPbWHO+FhBQBVxGwYTtKrXoZebzZAlO/hcU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTMcIlgrXQk6v4nx3zXQZnQhyZVBHQ0XSHnnKB6A4pc=;
 b=ZeATNiPcaH6g+fu8VFfWpjLvIm+Kdnravk3iyAnV2ioAOz0pyzeViyPEXV4Z9w08bGxPjlLNIBZCGAy1XId7AVvWPZxaZzI5WIzRYgCde5/7r2XbaD2Xyn36dQZt3ZR2j9nQmo6o4wCsrF5M3egiuKgFnZBkZz7jnJ4BaZgPFxjf/+9NbANoUKJbQgGw/jOw5oLY6xye2+HQlR8Cqx8NU9piyVw6cvU0LeuwkIC5KlqbSlWydevcqI3ET1qUyzoGTz+ssrsCc99mRc2i4xNxESuzmlxNi3SBFSomXWmG+K9FkJaP9Q3XK6DILInvaodNj5wMu5ZVq6IqS15DkVK1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTMcIlgrXQk6v4nx3zXQZnQhyZVBHQ0XSHnnKB6A4pc=;
 b=ld2cezoL0zo09MamKyPaf6ix0zJUdmn5kodeX9MKEHJ4jp385w1b39pETBCePhb30w0NZIMr7Jw88/RiIYDeTVy3JRB20vfJILYvYom6OzNlMGqYabF4fWDWb0VCaaGk/fe6uPSGDhXjr5gAuFT/RHyT2DAR8Mqh9fJz1psKR/sey7NQwbcDlGcnkGbFWnIFRQi77kyY9j6TrYnrKq2uPuI3i0gvXKfzFV9dZMsqIoQi8YVScxEGzqlo3kLCI4mdFyhM76nVR56xfV2IPH3LlcXmMn3deDuGExNs2YITXQq3bvt1z7l0CO8AAuPaiNQqoWVmKVkqMc1qkL6ahjbThQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by JH0PR06MB7030.apcprd06.prod.outlook.com (2603:1096:990:6d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Wed, 21 Aug
 2024 11:22:11 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 11:22:11 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v1] drivers:bus:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
Date: Wed, 21 Aug 2024 07:21:30 -0400
Message-Id: <20240821112131.6004-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::10) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|JH0PR06MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e1c5cb-6906-42dd-1f2d-08dcc1d36e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?baKanrzAMipKLFAQoVzC497FG0DKP3VyOK6UY4FtIWOaXie9v+yIgdaMaZyS?=
 =?us-ascii?Q?9ykvO8Red1FTpdZSB4SAaZwnYyPjddhVUS6lbCfO/T8+rr4pnRrkaHTSr9CL?=
 =?us-ascii?Q?NXwcvGUMjFUHQeLh/05tLJyWD+p6Kq1leH4dfmnPx9mRL+N2tTIZer/uB5kz?=
 =?us-ascii?Q?sAHFagd7rB0ycu3rBOywqd/XQtSCkmZQYFDxdUJ9f3wPnCu/41ss3O1ep685?=
 =?us-ascii?Q?drP/3R9kTncFZzXVtpKRsm2SsNbP9jcF630cF6r+ytG03Px0Of2rXJGk5TLZ?=
 =?us-ascii?Q?tWGNs/Nep9PVh8HDpcm4XXMz8c6EZs5408CcDRVsem/ztQTc+xP59KvrVFYU?=
 =?us-ascii?Q?MI1n+XphrnNv1iC1m6i80QbX5ssMSD/wmhBL2Zamffd0t9bOhGERIghtEk23?=
 =?us-ascii?Q?zebHRQ01BbrhzcdktAISYnjjRysQxw+azmQwRLQALOPnwHmh2aPi+b0JA/+O?=
 =?us-ascii?Q?gMjRxFZLlkqu8KQfiZlMh5eike9uNWoJoVsQU75mixzF+M3iCBuYmAVZu+oq?=
 =?us-ascii?Q?EYZrXwTtVw0j5yzNPqFclG/9TAcwdnwX327arYafQqmoJtTRDCZZ1p8VsMsl?=
 =?us-ascii?Q?VqZiWrG9r30h323z6PrrzM2VhXzJr2lgb7PK4qEoIr/vkKd7/kS6iBZMthNw?=
 =?us-ascii?Q?Gse6g+S2jE6XN8X34bPPYALp+ePEKOC8nnEJi2KFkICKEc8LxPE5Accy/AVd?=
 =?us-ascii?Q?WBpvskCkBuRSw9FQVhMn8LdaCSVuKd+yNhfa1pwy5fe6I0y4Qet6pF7Et4j4?=
 =?us-ascii?Q?sM5FwxD0bT+99UrOcPzXBXOnO9JN8xYh3PuYIstTaX/S/3Z39ujYZsatBtPN?=
 =?us-ascii?Q?3r2DoRSEf+SPkY+qWP1idnvsZDAwQeqGCz6g7b4dJovwTOlbRpLrLBBhmEoY?=
 =?us-ascii?Q?MLX4pT7dBKsUm3fDbzpAlVxehW+nom2KNizGGKWtUk4HkXKYNW3E1WcSr+ro?=
 =?us-ascii?Q?uOVLDWKeCjtSyyyxtACAA8m1VBEljMiNvpZ2TKfCixFIHtXu6ojDJ3TUAB5k?=
 =?us-ascii?Q?H8NevUDxEPYCalDeCDbB3yJE8NGwrj/W5EAIf10Pw8n8nAkFSZhzN+XD20sb?=
 =?us-ascii?Q?GWWeOTBmnZ3hdQmsJynyBKjncyDLOg9X9pfIsHzguzKki2T7q3PxGYtsf4xP?=
 =?us-ascii?Q?BExreEl4ZrNakYf0/jaEOzLOwFkdpr7RIp6mFxhTWDyVKmru+ebOxisx5Qqo?=
 =?us-ascii?Q?5H3v+Nv3vEqol7JS+7o/qITr7TaFssv87RFIihu3fD3rPlidHgljcNzPlb6F?=
 =?us-ascii?Q?ucklDVHZ9ykJ8d7je3ud8ieJruVQrwMvaFG/YrKfNhlhW1FMufdd1BlYjBLI?=
 =?us-ascii?Q?ZnCgNYi7LKjYA+ls3YiUxIDUADbN0lnkjKT8ahWqq1VfunS0gKeEBeBeuD/q?=
 =?us-ascii?Q?58odM7WISL4rHtnAGO3h/jTG9dTOP2eqs/kkPCe99ugjkaNnJtNPnd3Xwkax?=
 =?us-ascii?Q?+ET/aoJPNaY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GPymSuVPehA53ZxO+FogjD/z2NLMEjLlcTpd8FraHK0PAJJJqdQm700mOCwp?=
 =?us-ascii?Q?TZJgxDpCGXwVHryXeBbbtZgT5VNOaFlEJfR81kDii1nKKYFH53w3b6x7no65?=
 =?us-ascii?Q?XHgbuDKYh5GcBJVPth6+hzGlzfCYwWo2rNr3UAzHDvMNac7YVNN/8ZYFx6pr?=
 =?us-ascii?Q?0dDGJbvR5ZbPmA3Q6yJ4NSvumf9AZjzH45DGf64LkgFsYu7EgI6sqUJF264A?=
 =?us-ascii?Q?fVl+idBukd54gEYexE0oiIcrkoWEmtpFK/nL7qXQteMICDjeOAI0FTcM96Yr?=
 =?us-ascii?Q?prxEw9Xqz7c4ZOJ09AsiVEgT6b5OovWl3qt6s2OvwbcE1fLHccfnL3y/ehX/?=
 =?us-ascii?Q?GsrkhMOvfKm3Kz3++FKSJfUK+97l2Sx6Kv7L7IHxRLW3T3h7z5NeYkuzZvZH?=
 =?us-ascii?Q?KF5JHh4jbNFvKOsJO7H1kGyrPn9fVfn6/OucRBEZZDCjvIo3vMkn020mW3CP?=
 =?us-ascii?Q?LEv9ED/Ty/y+1XG8Wy5BgcjI/L8Zq4xgHDr2LnMYmb+vfZiH24lHM08FCE50?=
 =?us-ascii?Q?xp6HrneKc0eMpmw7YFqIFTZTeYAzLf/IPquaw/0HI2Wl+WT8Ot6ikvbLKdCq?=
 =?us-ascii?Q?wpi1A2qEs0KRILCJFT/lHWatCMSh0snfrneIMDLGXNUFMLOpJETvlEVKS2GC?=
 =?us-ascii?Q?lGskKRInmItETbOmFr73dAixS6LPFCLcpoWKNinbSEurrAICrCCE6Lpw1sql?=
 =?us-ascii?Q?aIUr0hPzZXh1hWGUn+cJYcBvmVnxR6BQpMrw7M5em6siNvBizrPuoXt2aJcU?=
 =?us-ascii?Q?rGsYuO172/zHf/LZsPDAaaH3w9W/+m7Mu3MSRHFlILbs/FxQRY3IFp+eMkfO?=
 =?us-ascii?Q?kpUjVlj6/umoUpUGD2quWVMpeCLn7Ie0+nSM6s3YvExbTjnjAbMxwAWZfQZO?=
 =?us-ascii?Q?LMPT/Q9aN3J8qjsrj6ztdVO3yfdJ7glseblqPNdZtc0agSKQigloH38o2GkX?=
 =?us-ascii?Q?U4WUS2dWjOizB1c+/1QctFE9OxRqftaErhFWMFkhhBuM2qol7vAz/JRjnHqq?=
 =?us-ascii?Q?KN71EK5DdR66h79wvWVaoVO/jH/XIMJjfNogR9/lHjtOrWymA2QH2DILSVcH?=
 =?us-ascii?Q?YPzbE1QvSfWJCGyJ1KfYZQKeb69DHXEhX7E/OfTu7CW3g4RzKHTj4s3bBYOm?=
 =?us-ascii?Q?2zAOeMftiTLYUrkoJ+zwPnRZ1HjtwWo/9IhAXzqp18EoYwqqWOW7RRDVpRv4?=
 =?us-ascii?Q?08I+YcKCykKo5MiuuAhhuNw0QWHFApcKlPxAdNVqqnle6nuJO0q5vAfkRU4H?=
 =?us-ascii?Q?zpQFbAyTKq2NDJRgrP0tFQsh/p38UG2qdxF1sbhYZugrOzZnWe+z8lpdOaJB?=
 =?us-ascii?Q?APouaHN9zg9pxFaKsFnCCqm3OSi+JgPEd/Yprrr91P7KCmjAvQxG89RTlxk9?=
 =?us-ascii?Q?FxcnVwrklwthkK7slC88x4AfHP78TYE1GqE6n4tc7Dj//WENrZQ5clXLD3fB?=
 =?us-ascii?Q?EAyUKQrWt0Z4WNxGacuuvssxXaXNM/Lq0GXsNUfCeDfoShtORcJ/RU07qejZ?=
 =?us-ascii?Q?AJ3JL6rIlw2XhvCRXuP0+ysRsKlBVYioO6npZl56byjPckyjXL32FQpqT99h?=
 =?us-ascii?Q?+xf/qZOYmtDEEaQK9Z1TfA+CRJGBJ5QHGfA6BD18?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e1c5cb-6906-42dd-1f2d-08dcc1d36e26
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 11:21:41.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSokrn1cmdZQvUtihylIC0orntsuv7jmSfZteVzH27kf4RxRGV6OBXUO0R5j4K29QwUHSkKk1Uh0RyriXWA0iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7030

The debugfs_create_dir() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/bus/mvebu-mbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 3c99d72087eb..42621838ba75 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -995,13 +995,13 @@ static __init int mvebu_mbus_debugfs_init(void)
 	s->debugfs_root = debugfs_create_dir("mvebu-mbus", NULL);
 	if(IS_ERR(s->debugfs_root))
 		return PTR_ERR(s->debugfs_root);
+
 	s->debugfs_sdram = debugfs_create_file("sdram", S_IRUGO,
 							s->debugfs_root, NULL,
 							&mvebu_sdram_debug_fops);
 	s->debugfs_devs = debugfs_create_file("devices", S_IRUGO,
 							s->debugfs_root, NULL,
 							&mvebu_devs_debug_fops);
-	}
 
 	return 0;
 }
-- 
2.34.1


