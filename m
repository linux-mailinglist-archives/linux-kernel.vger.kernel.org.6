Return-Path: <linux-kernel+bounces-296729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0766395AE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70248B20C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E751509A2;
	Thu, 22 Aug 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qgCJaABg"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2084.outbound.protection.outlook.com [40.107.215.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3501531D2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309882; cv=fail; b=SHjIX6eOui1W7QtzLyZiSkwWEvZ7QmKLzi2jPPqnWzUG1bYpejRBey2A+OMQjhOhCTc7RQUF5HLKFZv8ZQM0lJzd/owyWejiGWXQh0kP/yp2u4YUQaBt8K4fThYRVjOgTJ6gh5PZkpuSlD2Zc5K7IJNUmXeGnYeyQISwmCdJjqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309882; c=relaxed/simple;
	bh=yMbo8iBLCC3agtqsqm87UcNJHhazdWX+C7bOesRGjYc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jhJSRxLaTbwZHKN/bXF0KQj4G3MhutLYdNXyF3QYwIlCpMDQl/Jyr4rSAB32TGkyCY7zOH6hNMR18ut5j2rH4qKrMATm44p/h+vjnw2hfAslnxvv0hdPqVUr8+WqgA4ZztSt5agm9tTomed8igOiPlFLqi6swaMbLVRHMmwe5yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qgCJaABg; arc=fail smtp.client-ip=40.107.215.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aw65ZlcUWh/y/lzUuuyPPsQuk3Tfoi5t1JzJTtSEeGAne3/4Aq5hC5H357FXzT4NY7c2y+den/5Qgi1zbg4se4QHTRKGXT7OTIr2z8YdI6Oi7Mg5Gs/JrdUHfH/C99U2J+OLRcXwdVSVbkF19qIglTXybNIB8Q/K/6otaHJ2xm8x8AjpLGX7b+y4XN3gRH6VVMrLc/oMnobttNmKE0SrXU78BRSX1TkL52htLqBUHtOiBRv+9Yu/pLbzQ4GuienqMcF4SY5xYRSlXviitiXZAOW3PAvcHCOj/PtODUVLaclwrKMzVXUicr3lRpUZ9hmYaJEzYPHL09fy8vQc2bC8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8s/el5JOOU+Pho7H74LhNFfESzGFbNXPaPJtptZs+1M=;
 b=lxFrqi63VcWb49sPjgptFGQ50PopCNeA35iHkYFa/CjQGRl3uFY+COJMVfAgNvl1gn14rSdz4D1DMMyFylTbnpHtFbZvLQaDtvHUpT4FVX9y09dXKh44/pCEnydZiKQxv2bKcwPQAc4K52o5V1+zvc++UK7WCzbMffGV/JAu9llrNhtwDxZ2JsnuA2EyP/++vv1StJEMMVKBsWWWtefm0ngd3TZYO2F2A2kUxoWBQugWkJfGHc0AJFhwkpaSO+ib+z2I6c9Lq+oA/B5fQrmqPcDhdVau/0p4+DqPCkTXIekDDukTxYzuB7etEF67p0Au0MZ3L8dC/k24j4wTOOwZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8s/el5JOOU+Pho7H74LhNFfESzGFbNXPaPJtptZs+1M=;
 b=qgCJaABga/kILiHK03z2hOoVfCkD62th2StCX6omBQ0NuplYKpsRJKMpiVctoYGWtQ3pTPjliU4uuZFMr0S0s77IGM9gc8ng+mpvmNpPO/1hewdNB5vSZC7rvjPDrK09Ym3Gtqz9WSQPlQ0NXlFyPQQPASwjwqpHYdbfBa9fhUtsWHeaHpbcjE6or+EzmiuoD2Ba3THuaMtBltZyY86rC/OIIsBXgaejnmIXTjEYQBLdu9weiqWfDcatMjBghSqV9BT7It4BozpoEBputqCZiA+pVUA9b97dRZ1A9n3H+XXJcAx4mz5wwbtDImDLKdA/MGGg6HZWdk0Thm/CWSTw8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by JH0PR06MB7233.apcprd06.prod.outlook.com (2603:1096:990:94::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 06:57:56 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 06:57:55 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Yang Ruibin <11162571@vivo.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] drivers:smumgr:Use min macro
Date: Thu, 22 Aug 2024 14:57:45 +0800
Message-Id: <20240822065746.1336545-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0141.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::6) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|JH0PR06MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 06788e1e-775f-476a-1689-08dcc277bfc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|921020|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zr51OenXTNgCif7haAU/SHL1Wer+cesg25/m9RnR97OeXVHOFpxA2aFTddAb?=
 =?us-ascii?Q?b/7NTRWDsUpMc8PDnWprlLo/2GxeEympXwaQhTvo2otn5JORYDniq9avYIo8?=
 =?us-ascii?Q?8DlyTZFbMKkalcijgeV1/t+z4wLetGUSxlGqmZDvzn0LKEzDbuUOe8j3NDpO?=
 =?us-ascii?Q?tDzYhCZVV49p3awYMulN49gR63wWPRnNPShoNHTwWS1enAzwOM0VQ2oIUgDZ?=
 =?us-ascii?Q?AZaiMQ3uWXFbxFYxkMPViQjO1HJOxWHsAACK60cpH4Dr2xv7LNzTUi5++FA8?=
 =?us-ascii?Q?xwO2eVlRZADp6BAnSH1g0rFmJCb56fZRoOKMrtYjdO6jTkme4jZP/dVd7Ktd?=
 =?us-ascii?Q?P1IOwZ79KXCdg2thfZsM+Sp+tFKDkUjZ+mARo00sqehp+9VOv1VgTEkKdR4R?=
 =?us-ascii?Q?RB1VeyqhWC4ME5fqizEvDeO+qpWhw/U16ZHVyxv8J4HQfxO1rJ9JuRw1NxDV?=
 =?us-ascii?Q?UakX8+g1pniigmiuVYtJdzYEveA1tljdaEHM3shBdsdlCp+jnPC/N5FlXLsV?=
 =?us-ascii?Q?Qk07z82buAX12/ETIOucZifrNg6Pr4Rm+8wf1ZTwO1SRzyBp1+Rl0Zm7iPfi?=
 =?us-ascii?Q?IJL2qeEEC39iitQoCt9P+RKb5xzmaYFf8WPn5DIO5195PNqj5x23PAG+kAIe?=
 =?us-ascii?Q?UrIx34aAgllk1JPm9qw/a9bp0hWj3Q1h6a/Xmh4BhgH+yffMt0GdAFWQLIFW?=
 =?us-ascii?Q?/6PC8dIeaDziygCPf3tF1JBBqkgi8om58vLsy1eEFdgx3eKq+GCmAkJAzadU?=
 =?us-ascii?Q?VxvZuPmn8nuiv49D6YIvQBfnymqm97ilhruqGNJhTEmyO7FfpLPttuWfeLqb?=
 =?us-ascii?Q?e4jX8RzMWAX1VjsMJpRmhsay19PDmy4pvOsHO8S+EhGh3qSDPJ2puTb+OIVJ?=
 =?us-ascii?Q?Okdmr+ujScBUrQ8etvFPSNFTDnWZ19W0nJ9gYmZWJT2P5ZrvwppigSjnAW+C?=
 =?us-ascii?Q?CBXHB3VZSyVVsr3Pzx4T70VxzLyl3tBwIyNWSoN2184wOCSpMEVf8Rse6+R4?=
 =?us-ascii?Q?9ojzrwb1/ESVFmUatFjwr81QVBqS19DH3aRMN/2ExGKtJKplDlUYl7onEjr8?=
 =?us-ascii?Q?UpuQpa/Du3v0R6RR2e31xVz/WLcWxPIsn2npeDgCYTmpNNx0m7LP4v3W1tqT?=
 =?us-ascii?Q?UD9eFybxQ9bLR0bjDC4gOxgUmK8gRk4U6eACyvLUYF4c6QxxWFuRNRwJayiZ?=
 =?us-ascii?Q?zMw//4r7B4Vj8UfXm0bxPu9HlEsj8+nMZqsNWq6LTM1X/z9/SlOtXx2oSOir?=
 =?us-ascii?Q?Mf0NkbzLa4lVyDEz77dCWkL9ID5ZLu2vyfeLn73NRVcHp5dUeTFxtXMONIr8?=
 =?us-ascii?Q?S7sDK9pr6lvE0oHRT8+zz4By/KrDbk8Ps9GFSVuz+5fgty8t3DMfPA4Wot/O?=
 =?us-ascii?Q?g2zuYSKGCFKNtJrsefawJ3vW8h89SOqR+mSTIAo5w6GA3QLhm9w+EUEMtAfb?=
 =?us-ascii?Q?x67Q8FiPm5aI1DpBR4wsV7IsDQw98aLs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(921020)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kiCPIrrc4CW66Y7DcxLW/Olg3TG+VnBOMT3rKDIYCNwd3BQ8g+aGcCJxkB/b?=
 =?us-ascii?Q?0Xc/iJo8/vExTr5Y1+fOHThNEHng02vQoaxSrxOEhaNABqDuC8/HTdoUyzHL?=
 =?us-ascii?Q?TWViuwcaem2o+fDHBRikCX3MwXA6SQB/cpF/uCyBcIlnoe6Z2nvcaDNt82Ih?=
 =?us-ascii?Q?KG+CWmiJR1HWnQ6or/TK6wDUTsIhFKZTBLHsWe48MGiWFRpU2dzFq/iEHQXD?=
 =?us-ascii?Q?oHyt6z2w3xqDw8DbmsRs/U3kj7H78gPV+ZUsgo3U/+a4Cpye55FXNp8lP/K2?=
 =?us-ascii?Q?ZnKY3BULk4jg7ad6xFDo1JGGlk2r4/oGjikZkdPhvsg4t10gburirnPlHhhN?=
 =?us-ascii?Q?mgwn73r7Ax30pruUJefLDNqUTkncGMCEFMgWEczhmpkICrlqJg+dBG/1y11S?=
 =?us-ascii?Q?FvVvJhtc0WoAnJCMM1EvJhOrcENpSDzzY0buaH27Xp8Z0dIO4gTbbTnk0cra?=
 =?us-ascii?Q?FkF50eYakckAEe4vFdw8cluGRxdZ091VXTr75lSBXW0ou3ykAY2f5fgvOzRm?=
 =?us-ascii?Q?DCr0Q8cxY/DGQWKIel+dk6HL6qieUM+fVxRXCaqbBFpxzVCngIkR/7Zepqnk?=
 =?us-ascii?Q?KZfWQvsv3Zl1amt0e6LlKRqXFxtaRK6uYfbOzk2q/lZbgMoLDLZ2LWQepedD?=
 =?us-ascii?Q?AHh6qDAi3DStD88eF/2cBVPPyyI3jh/TaPJOpGAkM7RTc90hRik0X/6kLWAk?=
 =?us-ascii?Q?daKTdk2IVvtDDj68rZ+WT1QHbZ1H76+2Y4CKuLrgSoxlz6+sTbYFO9+izk3N?=
 =?us-ascii?Q?68+wPceBU9mHTeAx7+1zUOHQ40pcXl8+a4n2BnerUdz4O2119dflzQR4qgaF?=
 =?us-ascii?Q?2iAra78RaN/4aWD+zyNodG0ZkYbOYUHhm8rMojHQpqCi1fHfO4Es6UeBGAhv?=
 =?us-ascii?Q?qQXgZYJHkHReGOVBiIcBQiTsvVmGsBLBsd6Kkxb2Fy44+oLho1iIlxEQZ3PF?=
 =?us-ascii?Q?YoloktjDgUsNF4IgFbi8JES4W0il2YkUM97OhK8HnZK6aH8l/zgmqQ7ZciSe?=
 =?us-ascii?Q?Hr26Z/T+hJqJpHpLx5wECljQXTILGhxbSkf7YHbPzahdi4tkarpxiFUj3zTc?=
 =?us-ascii?Q?1ld3eRDft4QWi7aea35MfhKQ2hSs7TkOOOxEUlMciYpGgsZlQuSHUjHK2hwc?=
 =?us-ascii?Q?2fAH+CEAcLR2Bp/UHFe3cA4SHy5J//RED6geYKmkGtrUH+mwJfQIsu1kCkNv?=
 =?us-ascii?Q?1tLq3MMiGY6wymYNt4Fptp6oNaHRW3nfpK8naxzyRWHcJrW73fvh48fIUa6l?=
 =?us-ascii?Q?TCafzR7bddmwL+lPQYJrFara9btTKTq4lkaPx+iWIPJSfHMSYzKhT/u4CYDM?=
 =?us-ascii?Q?zcx3Uv5Qpr4DT+qqhRjnh/yR3LrqYbjVV2McxdBAvJEQ9GPlUj9Ma3OHwMQy?=
 =?us-ascii?Q?LWj2WPeJmGRL7pCR7b4WVAl4akbKPaL5/bnDi/9uFbhgJZ9voAEQGXvS0dVk?=
 =?us-ascii?Q?5hCA9vXWO76U7/Sf9hxgRTggwCqwUX1JASTJt/q4mm217CkzmRCtIWPE3eQA?=
 =?us-ascii?Q?s5huUaDj3Aqjpt3XBiBq1+fBHHb0TaifkMMtLWjKjdfzTh/eb2cb6FfhFmw7?=
 =?us-ascii?Q?vBPcRrmhoIhKorOi07L+T4rz1ZFJ0aRnh+LtcXXq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06788e1e-775f-476a-1689-08dcc277bfc1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:57:55.7045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCurTbo6wY0bS9nCdA8lXvW/+FUpkKXv8E7VDerjFWALAu4j5T0VHUDx7LbDmWkDfFcOF9eDTkX7V0S7anDKAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7233

Instead of using the min() implementation of 
the ternary operator, use real macros.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c      | 5 +----
 drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 7 ++-----
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c     | 5 +----
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
index 5e43ad2b2..8bf80f65f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
@@ -1067,10 +1067,7 @@ static int fiji_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 						(1 << (lowest_pcie_level_enabled + 1 + count))) == 0))
 			count++;
 
-		mid_pcie_level_enabled = (lowest_pcie_level_enabled + 1 + count) <
-				hightest_pcie_level_enabled ?
-						(lowest_pcie_level_enabled + 1 + count) :
-						hightest_pcie_level_enabled;
+		mid_pcie_level_enabled = min(lowest_pcie_level_enabled + 1 + count,
+						hightest_pcie_level_enabled);

 		/* set pcieDpmLevel to hightest_pcie_level_enabled */
 		for (i = 2; i < dpm_table->sclk_table.count; i++)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index ff6b563ec..62d9156ef 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1127,11 +1127,8 @@ static int polaris10_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 						(1 << (lowest_pcie_level_enabled + 1 + count))) == 0))
 			count++;
 
-		mid_pcie_level_enabled = (lowest_pcie_level_enabled + 1 + count) <
-				hightest_pcie_level_enabled ?
-						(lowest_pcie_level_enabled + 1 + count) :
-						hightest_pcie_level_enabled;
-
+		mid_pcie_level_enabled = min(lowest_pcie_level_enabled + 1 + count,
+						hightest_pcie_level_enabled);

 		/* set pcieDpmLevel to hightest_pcie_level_enabled */
 		for (i = 2; i < dpm_table->sclk_table.count; i++)
 			levels[i].pcieDpmLevel = hightest_pcie_level_enabled;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
index 34c9f59b8..4616c3261 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
@@ -938,10 +938,7 @@ static int vegam_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 						(1 << (lowest_pcie_level_enabled + 1 + count))) == 0))
 			count++;
 
-		mid_pcie_level_enabled = (lowest_pcie_level_enabled + 1 + count) <
-				hightest_pcie_level_enabled ?
-						(lowest_pcie_level_enabled + 1 + count) :
-						hightest_pcie_level_enabled;
+		mid_pcie_level_enabled = min(lowest_pcie_level_enabled + 1 + count,
+						hightest_pcie_level_enabled);

 		/* set pcieDpmLevel to hightest_pcie_level_enabled */
 		for (i = 2; i < dpm_table->sclk_table.count; i++)
-- 
2.34.1


