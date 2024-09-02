Return-Path: <linux-kernel+bounces-310524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39590967DE8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AAE282626
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F652A8D0;
	Mon,  2 Sep 2024 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mZ4B7pUu"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2078.outbound.protection.outlook.com [40.107.117.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A783282F7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244810; cv=fail; b=YcFiTdmqXdFkUlJKlSKJmHNtAUh4xscRg2iwxp/x430e9zrDQbvzprqGO97rBAIBqI0SaZxcYBY4lj4ESXqsKsy7uKk1KDrorZi3firppjh4ahSDYVRptI8NH3LV1prgpfbP/8VsEg5uVczoP3SYrXoSUr/72C7VAajgHGk5u5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244810; c=relaxed/simple;
	bh=eUnZm1ISqDUiXEjiijUyQuoZ826g/d9/kODIf3USBB8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eZvL79h0u3bdFqJhyPvLgn7xUXC+MM4rtgNKznfakupR3zhnUklmHxeW/JNRieupk5MlcjO7Rc3zTu3xUrIr2dxgpWzTQF2H/7+fWbpMGyOSP6Qd2sEqCoiDR65gTgARxYbAvC5ecFGIa7n815ubK6nOj4FEoFqXITzaiav7jog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mZ4B7pUu; arc=fail smtp.client-ip=40.107.117.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VN9sUF4/kGCOIK9/Lsq7wOl59d4q1IC9U1rN2Bsk13aV8D0yN+OaC/Owb47phhFgNK5h3MKrMSklKkvPYU8nXIHIoeMEL13KeGUgr1F5THKRZlOHbCeY9mSUIi4j2s+FxGxcjuIZvhdHyNKhuu58p33bWQo0komleqB/MO2esFhIGWwoxZyXDAlqmecCjYcQx8Nv0A90YLYq68dS89TXB8trN3HUGi/k4DfvM0tyg97PYQIyJfDRbQBU9QZvtL7+qB2JhRoGdUsKajE2T410jGMQHCeiAQo6kOMP+2BteDOt+vTq2m6SMap6wdG2lp4A8unJB9ISUZttY55qlA5Lng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YAjv2Rq/I66kOo8vpyW2OgDcdenz8Qq7LnUTHxK/14=;
 b=JtGQJ7hxnNUv2bYcV0sgmGXkkb4bOrT9JZiPDumPtTM5PdE/o5HSz+nPkRO5AMCmErTEtu5UcaMFviLe7dk6Aq7j55a/FPrONJtL0ZxUx+UlctpyDRFiOKouUksh5cHQeSX7dd58UxMrgrft8P6IyeoDjPvdi+b3pf4k7CZFMZdQfsMFVQ0RUa/6WP5heLk0G77tfQLyy3aFmlZ9AhgWXDRx4bgbZJtYjp5sIViVAcozuYICT0tNVFmj3+76g7DJ4AlQrhBjhIfQx9zxpMg7IuR4fhuM6mPwQ89uACQHcytVWjRmjQKJsfOVBQ62EhVt7/N/OhT1zzboEXNYhZIeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YAjv2Rq/I66kOo8vpyW2OgDcdenz8Qq7LnUTHxK/14=;
 b=mZ4B7pUu/mLdE7pTgxDu/oLaQoKomL51DgxoBrASEVfE03rOzo9mvv6d5l/97Owxuo35s6Ef1XxZDo5PRQI4albLJr5gInJhrEY/EoNhcHmARRaVxQReMyDR0ovUiLj3qENLmpsV04pTNyoGd7JvEhtyMatzDlYxfTUrHatQ2lrMw2FgCeHe2Filn9e5wR+b+i0rAEV7soS2XA1dqR3fb1vG3t4yOskBNkZcHpAWkr2Xm/uhJhXghrVvCqHGtL3CdF8ewrSVHpCwDYzEaLGVwCldEM/E5lH9vOI4P2F9sp4prgDch+izPIXHCAA3zCg4mqzhsjUHCxtV0EL7xLMN1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 JH0PR06MB7328.apcprd06.prod.outlook.com (2603:1096:990:a2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.24; Mon, 2 Sep 2024 02:40:04 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 02:40:03 +0000
From: Rong Qianfeng <rongqianfeng@vivo.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Tesarik <ptesarik@suse.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Rong Qianfeng <rongqianfeng@vivo.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2] arm64/mm: Delete __init region from memblock.reserved
Date: Mon,  2 Sep 2024 10:39:35 +0800
Message-Id: <20240902023940.43227-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0118.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::11) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|JH0PR06MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1c47bb-7750-4ec5-4915-08dccaf88c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0qG7vbd0ucVrv7T6Rsn3ltGCSBXy2RsyaOHDdRp/BbwQFBURjaoj7yupVwjj?=
 =?us-ascii?Q?qZU9ZiQ5rLjmo0aHJfrSW3jY31+s0iln+5YFv2PCnVRWc6qDgaAaohOow+GT?=
 =?us-ascii?Q?gTRDsIrcYXwBEQpqtR09WElCvEb+sIyLJjrVAD9mCqfWnvlYr62VxSrF0hFq?=
 =?us-ascii?Q?RfFevFM+p9HFdeNaGWtvU67RdLF8GoBY/XUC8Bryg450wFWuE7/RKVQZwtZu?=
 =?us-ascii?Q?1nKgjkalyh26ecRkUkvfEAZpU/HoMnC+NMilcsA0pRYVMm2EZ5ldYtNez1w8?=
 =?us-ascii?Q?hIHSSxvmLBWlEDZ/5PZksgemiQ7DYMRvVGbHuxpWyM4DpyytllMgaDzzNvpF?=
 =?us-ascii?Q?3JQZL85H1scWdu23w/mwbyv1WbgpA+lE+CcFB4MOYkaK8gYg7SUki/0Ehz7D?=
 =?us-ascii?Q?/TCAsxuftABeq1UOnJq+GknBbeyv9UA/mNzzf57fbPLYBRgdQXr5D7hTLQd0?=
 =?us-ascii?Q?Xc8d0MQekFVXhfFHrc7h11CM2vxFsWcnEW4PuvwKFEhCDUfA//6vZjZhE7Of?=
 =?us-ascii?Q?e44luBjw3AJGsRXudi0I7KRziZDspw9HulZZ/MvEiwuOrWtZ1LlaFEtTnfX5?=
 =?us-ascii?Q?YjV1fNm1UYM4hNsFaY3c7lQ5ExjzN23PmlI6kfxnwCd+ClvEtjx8mJprxNG3?=
 =?us-ascii?Q?yLjpdlq+8GbKYCqs6NBqRMUpTdhon/K1wAPBVtGAmZdvpUTOWfArAIBXDEuD?=
 =?us-ascii?Q?2ZqpSOH8NzpImGKiopljFA7IFoT2GVxuMX+qpwCWzapMtnGLBfIp9KgZzJQT?=
 =?us-ascii?Q?BqCawDO8KMc+70kG+kNrk3IikaWmFQOAHPbNCS7mOvQUdEWECklzhxKH3B8T?=
 =?us-ascii?Q?kEFhXenQqsQX79rFcMeTAY2v1OJGBsYx9784UKM/R/bTBxYxwerl4ZdhKPuH?=
 =?us-ascii?Q?dJyCwDkpvUXWdzpE/vlGMh16TVukz9Vb+ejR9YyqIplvzx8quFq/58YKpE3C?=
 =?us-ascii?Q?eqWzG99tiMRiz7b+NCVOBRkgfbB3XNpBF63y/rsfnOvSdRQ2yblutkkMxsYQ?=
 =?us-ascii?Q?dmGscRwuWfXyBNRGzOvzSErVUrBlnn/YqUmGMo5yKlkGwMtLK9LZgotheYVc?=
 =?us-ascii?Q?5sGqMblH6w5nss78DWTUh5moiIUgl84Rqz5YKcqt3pK2+YzpRLGwkwrmHj57?=
 =?us-ascii?Q?Y0M510ixPoxvQWuMWkRTg7fnN6rTHABkZCPQ1QH+kGFj0hNDOxNg+w+mT+2G?=
 =?us-ascii?Q?y6AcQ9nsiFeo1ruGX0B9eYMQfyOk9+uWS5Aaa/RVBrZ98bWBn3AUwpkhNqzn?=
 =?us-ascii?Q?FTqQGIhYHG1CnpHhHqGNpyOcUFf2GyUP7KtzytbvzJGBS3siXjewsUEk4f3K?=
 =?us-ascii?Q?PbA4a9tBp47d9ZsvZJg144qa/cjKeq11cUwZHytYjM74dhVzJT27GXEhnQJg?=
 =?us-ascii?Q?y2KvJD9JxFypJqKcpuz/RJ50Vgyh3YA0g3f/DEPgy6aItRQkWH9gQazGbZhG?=
 =?us-ascii?Q?JDQfsrXotQk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nEZplkG8WrqsH/mIhrvF1G+yDkPyEE57srG4uRCCRELAaeHo2wAitxuO/asl?=
 =?us-ascii?Q?w0sx1t6FUp+nY45kMpzzDTHig7vIltcMurx0s9+7oirhbXGw6DFoQz201+sN?=
 =?us-ascii?Q?kCDr0QXACTqIh1GDkjxdj8xgcES8lgmt3SCYGp5s2hes58gn/ickQMESXGcG?=
 =?us-ascii?Q?UdpJl0F4f8cnIWOJXfoDdihEjgJmUsDxJi92WdBirwluk66yNRCHS+zh0nAW?=
 =?us-ascii?Q?xjimCe3btOm0DQapJDxZ8BA6RvGTeE0f+GhAQLXs9Ay84TVFy7pFIf85/aPo?=
 =?us-ascii?Q?crojZvlC9PgN0cMcWBVm4g9yfmSU9SVlEHcs+1OrvoIZkWcsUA6s77ZkyVEP?=
 =?us-ascii?Q?H6EGvU0myXX52LvgvXbI0oG18NnRSuKtmL/GR/sVYvckdWFwQRMfOT44M4R5?=
 =?us-ascii?Q?BthS7Ipk9M4XF7W5fxprbnD0i3hvYTTh6H9weqg2+3vHBXZHLR9nCbfcN3+O?=
 =?us-ascii?Q?ujDxa2Ylbs3+/fdh3Crurqt2Ni6VskG+FtZHpLA8R7IgIcp8ipPKEI52+0O7?=
 =?us-ascii?Q?Y8Xz2p/NYrkHoTXo2ICf8/twlwoVNqls1398DsGdlHDJSXsIf2aQ3atxCWy7?=
 =?us-ascii?Q?WhOUprCRofhJ12t4KsdQrHea2qMCBBjPf7zpp3UFm0lT+QwXoeixFsGMQRp5?=
 =?us-ascii?Q?DFT86WB9mqPiU2n/1eawlaaPye0H5JZP71oJP6jmqTJK31U1tz5WK0zlIe4C?=
 =?us-ascii?Q?lF9mtilK2BEzWXrsCsqpVaO24elD+0mohggbiK1ZurnMwBbc8IZrYDFCg2CX?=
 =?us-ascii?Q?kKWeZE81WpfT1jNgaYwavd5cjxxQJT3nvJKGMJA6bKd/zypLs2cIB63xjWpx?=
 =?us-ascii?Q?/4LW6xdtMVfH+bGldAfSjnBOMeH55cXOtD1yovBHHyhuw0ZiEtjmkEfioleU?=
 =?us-ascii?Q?R10S7muyyzBOtO5Ll1gwmnWHX+gts5wgGkRbOTxWwZ7U6ITXTCnfopoArrEW?=
 =?us-ascii?Q?QkgWSldlcKVHgyUz6TMeIvpUHSK9X7pq9if5yTRjqlvqh5O0NuPfG7MJku/z?=
 =?us-ascii?Q?X2rIozCTon4CtywLkdVbpL5mF3bfMeLfpwjGHU3lygWwmfyDCyYXO1dKMI8z?=
 =?us-ascii?Q?FXyBUG/+jjCf8F1c0+bdV8WUoCB7gFSiY0IsURB6Hx/Cb7mVEtUgV4Qow8Yr?=
 =?us-ascii?Q?RJ8XkYBrEUKrkMDOL+TddRTTFYjAayN0LdG8EIKHqDyZkjLW+Ge8Imp04sun?=
 =?us-ascii?Q?DuAIy4IlEWSDbg04GTL7QfSGAJSdiPh45/L/k5HgY3mjqITkGSWJyyRPXwzM?=
 =?us-ascii?Q?jiJWPLZUJ3Fj4tXyRzmvzNSqVQLLxNJuWb2We0+gMAB0GfE1DlAZ0Z7hxApv?=
 =?us-ascii?Q?1pnAhGJVAMPBv6kNLi1PwhdIYwxBIlomh5PY2H0//Ohae03pEARSt3KwImEz?=
 =?us-ascii?Q?Az9Gz5t/C6OsZbNFi66mdQ0QsNCy0U4jvN/GmQO24Bgn9/DfZWc6u1knhzSK?=
 =?us-ascii?Q?7+ePS4YTJR8lKqltGqPzg9c9aLNxhnnll6+HzY+ewC0jluWlNk9dDFeg3n5J?=
 =?us-ascii?Q?siKOEhJvKyNDkgtJtp61BIroXD38zSsy1oVPi+zLlXEsGAf/AdpPgZGjedPt?=
 =?us-ascii?Q?ROqhhM0t3VFGHiksVXK9ID6yo2aRJGYunIsCb9eV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1c47bb-7750-4ec5-4915-08dccaf88c52
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 02:40:03.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HISpJfHKdrL6VV41UNycupXSOlEzbeo/1+JqA3H9Aa2LaryQGjdk5zUKIpX5u7vXeUay5PwbsbF7P5gBOjLqmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7328

If CONFIG_ARCH_KEEP_MEMBLOCK is enabled, the memory information in=0D
memblock will be retained.  We release the __init memory here, and=0D
we should also delete the corresponding region in memblock.reserved,=0D
which allows debugfs/memblock/reserved to display correct memory=0D
information.=0D

Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
---=0D
-v2:=0D
* Removed the conditional check for whether CONFIG_ARCH_KEEP_MEMBLOCK=0D
  is enabled, since it is always enabled on arm64.Thanks to=0D
  Ard Biesheuvel for the correction.=0D
=0D
-v1:=0D
https://lore.kernel.org/lkml/20240830080020.33666-1-rongqianfeng@vivo.com/=
=0D

 arch/arm64/mm/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index bfb10969cbf0..b275ead50415 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -402,6 +402,12 @@ void __init mem_init(void)
=20
 void free_initmem(void)
 {
+	unsigned long aligned_begin =3D ALIGN_DOWN((u64)__init_begin, PAGE_SIZE);
+	unsigned long aligned_end =3D ALIGN((u64)__init_end, PAGE_SIZE);
+
+	/* Delete __init region from memblock.reserved. */
+	memblock_free((void *)aligned_begin, aligned_end - aligned_begin);
+
 	free_reserved_area(lm_alias(__init_begin),
 			   lm_alias(__init_end),
 			   POISON_FREE_INITMEM, "unused kernel");
--=20
2.39.0


