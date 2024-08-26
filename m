Return-Path: <linux-kernel+bounces-300836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CCC95E90E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6BC1F22B48
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FC857CBA;
	Mon, 26 Aug 2024 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="l5452ohB"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010035.outbound.protection.outlook.com [52.101.128.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D44A28
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654169; cv=fail; b=etFfcuVEQK18milZ5dxdxVAT0DtXHku1HzV02K9JDPKnaqWqFdbx5xnKSXKX8ln8LJnAi34iNGFK8O7AcFlrYj/4vTJ66a9V2T40uMLEXyi7L/Tk4mVkaK0Hl18a7v3KJOQO2IiAN6yqTOj4uE21U57N1efTL4Z7fl1cg08MII4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654169; c=relaxed/simple;
	bh=ujs7zLX3wfR0a8e4VKQ0+daCT09XTuX+SP4nA1tW8dU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=j/z5Qp4xO03vnavCopajrN+5eBnvL4AeJCuQ9nJDhltwiBcKsROQA7O1m0UTFrEoVFxaRWUFTGgmSi9ECxwGgBivoJ0CoKY01g9sMy/8ji8SzOHVF5rGXMt1cmxKbC8B7PHeA7rWl8S8A/22dSkd72U+PR3pDnBJLnTj2cYi5BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=l5452ohB; arc=fail smtp.client-ip=52.101.128.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlmq7cPHEIgiecc3NvvpigrrZ2rS8KEGIGZ1QXYgMdKpbT5gAyNRJZW2m9Xpx62jlSiLyuCEnTmHavJrzwcdcJdkxgxdFpfWaTRWBaAxLBLXPVq4qHgHMJVDg37Qa2gj7w0x4wkC2uLPwxWSflGi2aIcEPAV3L/SjzaLDk+MBX3RL6i1YpgJOzbLsuJwCJ9j/HRNL15ZcaMV5qoojgt4ZsoMaHR2FzFcwfI0sC4FDJ6tj78PyVFG5nTua9X7zn7qfshd0FTefiyRjqoEmt57ExrKQPMT9ACxNgSt9bwZg7FfUuivdpEV4W/rpD5vSe5QkSord2vh7eI9/o0ur2FS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz/EVunoOiX/fAeklvvhibF3SK5zFtUNT5QNuwArAYc=;
 b=Zl+s5MyP8ehjXR2L2SNvzjsN3B0rTMLH4c0ymlREh4VpPLtiJ7+lC8wvEumf/MdUnRjZNftcBTkkE1gXoS03QwYY9YKjySSrQ3hxwvCi7pDfEPI/hRv1SagyV2GtLkNxomZGJPQC+CxGU4Rbi0n/wAIphxXvE77ym/v7C9txbyl6IEpZwbxaQveJFTw7J8olFWedIPyaETVBJkTcCSvWR+UX9+oxyLYgnE42g9G8t1B/OgS1EU9oOKblZ/gjHysevDzkPLV1dIweumkX32VaYrYyucKp4IMeh/4/0nl4W5eJrG1hAtsISAwtcpZxIoHCKweor4bsH26hlG3v4HJj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fz/EVunoOiX/fAeklvvhibF3SK5zFtUNT5QNuwArAYc=;
 b=l5452ohBFsSlyC7BBLh08SN6UGBUPg4lkVdDmEK93bpk9hBi4v2cuBdpbaCWROJdlAVJ+MuVT1eK5mChbX5nkINM4ez3vs/d5y6uK7vJvG0o8zuTgTg0zkUnqjBwOUwgoiWXvuke8xFZtK1U6AWoyzWBARO8Ry/awu2mJ2Uy6MzNYVRWbBjkhImw4HjInjPEfybKHKqHvkaegmhKSGXvmBPtQgQeseyFBwZUeo0XUDRHexW3/ca7kfIBLL+tikXCYbdDP9zhGTTFIpkhGydTtM3/2dFXk3sRVmbBKEuMQxCidVBkBSAHIeU1rd0REhdp0QprGy8L1E/WuoRzo/ukyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB6252.apcprd06.prod.outlook.com (2603:1096:101:c5::14)
 by SEYPR06MB5892.apcprd06.prod.outlook.com (2603:1096:101:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:35:57 +0000
Received: from SEYPR06MB6252.apcprd06.prod.outlook.com
 ([fe80::d2f1:960e:a2e7:406b]) by SEYPR06MB6252.apcprd06.prod.outlook.com
 ([fe80::d2f1:960e:a2e7:406b%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 06:35:57 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Yang Ruibin <11162571@vivo.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v5] drivers: smumgr: fix up the misspellings
Date: Mon, 26 Aug 2024 14:35:33 +0800
Message-Id: <20240826063542.2144716-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) To SEYPR06MB6252.apcprd06.prod.outlook.com
 (2603:1096:101:c5::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6252:EE_|SEYPR06MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 028a209c-5329-4d5b-187e-08dcc59957d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|921020|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IYoRfI2CST2yxFBQS1HqOhbeaIBvsUuNw7XvJuTttKk0LgF7PRAn1SjNsUAC?=
 =?us-ascii?Q?XszxQimJvKp71UJeDLndNPD0qK0duwQpgqwp7XE1tZ8wSw2RpoAEZs/blZ9s?=
 =?us-ascii?Q?vWNkFJXRSTfrLNhYrcuBGSlIBQm6rqK0aY961OR2cGQqsp/GiWkoEXZtF1Y/?=
 =?us-ascii?Q?9LmsU2mTBTRbI/xXOqlAn2ux/raoeR/jvvaZdxAPte6I5MPlZiP4TgznpOic?=
 =?us-ascii?Q?RX0v+y9PS+HaMoDGUGp4r02H68XKhIwpJPso/mjcyipK5yZtJmFkpkwUhQc3?=
 =?us-ascii?Q?hb29xhgTVgmeFvKa0J60qU2HtN6WDdMKTKIgjC7gTN6NNtKJEPfNfv/aeHj+?=
 =?us-ascii?Q?kyTBy79j2qSaICBW/NnR3Ui+OBYHAfX8e+rIaeucsNi8UXUHFJ5D6GpONXmT?=
 =?us-ascii?Q?UaVrWPi8Xf7eKTgg2l6Sfmoo13EVHjQqtY4DBB4HSxw7WBpm0uW6Yg+T4HYO?=
 =?us-ascii?Q?QI5JkYJgCr5w13+Q4RDkQ0Wo4i31mnWaBKpSrGyDkePW8w5AP4AowSrIrXm6?=
 =?us-ascii?Q?HZvRmPuRqJw6S4eoucqjMLNgDzAKnTFW1B5wsFp6hSUGKVIWKLPgq8ZxhXmv?=
 =?us-ascii?Q?vhK76wcIe1qobf6EFXTNMN9iKxWBhi6W2QpNLJdPNTOoNCqUUcw/UL+FvYdU?=
 =?us-ascii?Q?+zyyox3YfffcyrG/JvAvTODx+e79dQU6+4+MxwG4/9Jky+qLOemfW73XOwlM?=
 =?us-ascii?Q?gXtlQl4yzdg65NfciXQf9X4vrzGrpBcsiYqcy2i8i+GPBMcIpssOzV7ikyWo?=
 =?us-ascii?Q?id4rM8Pp6S6WPwPiz2eI6AdpEz2pkVEK+kkMvPS16kTH3jEVdyFbzTKmzh9X?=
 =?us-ascii?Q?m5cyzknEDsuMQWFL0TfRqISvt5LMhv+Fj8fytFF6B4QuMxH4a5x7pWkRXYYw?=
 =?us-ascii?Q?hmVImyLd1gihSbWaLi0XSbnlU1uFk44KVQ16fdXccDhuCPtWIuky1FUIAKBy?=
 =?us-ascii?Q?wVRs+h63zllUCTEuW0wCDSU5mX+WnggEmKd4YRjLs1sS05R04yf93tJInrig?=
 =?us-ascii?Q?SvuDUK+jU7N9KczIQiBCYGxBv2OGRddJSzmw29XYJvC+BfgZE0+3R05NpL0N?=
 =?us-ascii?Q?GArw3BQTFRevVaTBL7b4AieTFfl12+y4/KgaWbNb3ZTnrx4OsHT0jj0oIKpC?=
 =?us-ascii?Q?DeouVbcb0MJKKFmUgZsRHXQG2c0sNSKsHadNYTD/Bmp+cF++sGeZz/REDIWW?=
 =?us-ascii?Q?OjN7CZnJ0Di84GxFiOr2+TuSQny4Nm+kOfLz1FtkWqeoopddKff89vp7LbOl?=
 =?us-ascii?Q?JRR98iqQzcRhgiJPkFohNnZyHqOfeUUjnAlqo0brGJKqsVlNuuhiYBCd+410?=
 =?us-ascii?Q?d0AnmAdaZsDK8BDFK6UeUGK8gOqWpHsnpen2OAEHPbGiK1DXY/G8maK6eRgf?=
 =?us-ascii?Q?zTLFililmv+XXe3fu4H3piefW3XzwY/sWyB9ezNvcTGW8sCjq+FWTb4WRPeu?=
 =?us-ascii?Q?+ykBfLTwx/6DwJrgnui4d4YxDBNim7Q7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(921020)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nhAMj/qoOOe3LZJbsRg8yxfwKBEdRYiRXZGtyLKaBtvG5aPCjx47qGtWmnPg?=
 =?us-ascii?Q?6InoTe3D6t3qxvTOQAeC7gaQyaVaruGyK56EBUd2aKdr4RGKyGPykr1tQ+Nz?=
 =?us-ascii?Q?m6j/EsIiMX3QEmCqcZz+diuD0gMRPN05kWGq4j0xucJNag21AwNH5/dc8dqj?=
 =?us-ascii?Q?AGKoSSmPET32A0iLKwr+AWGlT4nZWuvx2NcfRRRHeG7bHZPJmbCJAxJAtgSI?=
 =?us-ascii?Q?1PijsyjxqLi66/a75RZV/PGMQ4E8/nYBaI7v4Je75OxMoVYOJ5uBRXrFB3pt?=
 =?us-ascii?Q?Dq/5DKA4EaHqXmtpE9mvUdKR4jLJxnGOzwLiNq2GdpyirFLypln8WfpKWqgg?=
 =?us-ascii?Q?5lPD7busyMcny0rz6rk3hmM8yxLoeXKtvLQnjMAFHcIQN0lyL6Vp0KcOe+q3?=
 =?us-ascii?Q?/zf+iQgA8x5THublqLapExAc0tjxw7eHZTR+CELziRzVyCBnu+/MC+YUM1z7?=
 =?us-ascii?Q?GRzfMuCW32ufnUw8D9On0T8jH5y0Jb4r0LdASp9ZQgow6tBLPKa364fm67Vx?=
 =?us-ascii?Q?BGRr5sIWzs+iXvU/jC5Hdg4w6/7yZRZZhRLeFz9sQ3IvYMGW7Gp+y8CEGrP2?=
 =?us-ascii?Q?k3T1AW9SbnXcg93YPa612LBU/CcPKy3ytuYXWTNPnDKoYzODsV2AGDW6ox08?=
 =?us-ascii?Q?JeV4KCYlrxUePFU3FBz+Tcltu7xM+cF1A5ucVuncaGYvfzzBpweRrC9SI2IW?=
 =?us-ascii?Q?e/YqErOMM0FXvopcZjb2v4vCqQDXC8k8nsW/CPHzuJDjNYuQF0iDEh4BIIp7?=
 =?us-ascii?Q?6IwNBn3YKw/RwMx1ahMqBjymxzFuACpaclbqSlS42fedXxOw4d/QvfL59JGb?=
 =?us-ascii?Q?Cx1Q2wKh4BcRArNV0MqLJVAo8N+zbBSwY9TwuTA8NEC86pf/ql9nS0+Wr8Dc?=
 =?us-ascii?Q?dhN8N32O/dJec5L6fzRMcUStd96Uw2So/ck0dFZJ0PDRyzK0M0XvNXI/mbHg?=
 =?us-ascii?Q?PDJcIu4FSZW5tqBqn1cLlE4OOSPAS7oyF/wnziLOpNynCwxocujng+zIdQCC?=
 =?us-ascii?Q?9v1VTHY9HLN1iCIIm3ccO5oQslxM5H1/Cznr6LV09trF63k4T8DTik7hPS7d?=
 =?us-ascii?Q?IiTidPANHA+pg2LBiEm5AKFdJKV5efDlSUfjjna8TR0ScXXQtJGTYJps5lRS?=
 =?us-ascii?Q?dtYQVVODy2M5Pz/6pOONFs7XZ33jFn3kh9rSEIRjEO3ckeulnWTVmCAKyce6?=
 =?us-ascii?Q?foFC1MAq42kzskmligKd/+AANH2CmMIyo+A0lBwmg6I43q9ssGIg+0LcDckp?=
 =?us-ascii?Q?aL971ii6ZtE+oCkAJ8kWAhBuOvp90v21GwwRQUS1YkRwK1vC4ha07fX80Hut?=
 =?us-ascii?Q?/BKPb5AKn660Mot+anS80R6pAAE7oVbzFas7YYGZU9Lvzo5fsSDgrQ1arGxD?=
 =?us-ascii?Q?C9mGsTEwptMo1ITHdC/bv1TISm5J38Lx6+jog0obOA3Br379zI22zpIk5vYQ?=
 =?us-ascii?Q?db9+gdBVhiLXWvPbhdAZ3OjgQjIz4/ySt1vekyG+Gs5ucd9f1XqZrIY3wR/Q?=
 =?us-ascii?Q?ogfslJ5NW7KC0vwX6mRvGjYYbBXcVh55Oi+hCVslK1JrAGe2MUqXmli4ZDpc?=
 =?us-ascii?Q?EBUviPZcDMZ2uK4+iW/E97WklhdvYFYHKOp29dz2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028a209c-5329-4d5b-187e-08dcc59957d0
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:35:57.5713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mz7ORM88jDOGA6ZTspWxcqqaOrR8UqHcw1RjQFj/Q08XqWfcw/40lpMkN/i9sKdPDgIr2oCcuSx4a/rup8PRJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5892

Hightest is a typo. It should be highest.Please ensure
the consistency of variable naming.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
Changes v5:
-Updated the ignored misspellings
---
 .../drm/amd/pm/powerplay/smumgr/fiji_smumgr.c    | 16 ++++++++--------
 .../amd/pm/powerplay/smumgr/polaris10_smumgr.c   | 16 ++++++++--------
 .../drm/amd/pm/powerplay/smumgr/vegam_smumgr.c   | 16 ++++++++--------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
index 5e43ad2b2956..e16efc44df88 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
@@ -1014,7 +1014,7 @@ static int fiji_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 	struct SMU73_Discrete_GraphicsLevel *levels =
 			smu_data->smc_state_table.GraphicsLevel;
 	uint32_t i, max_entry;
-	uint8_t hightest_pcie_level_enabled = 0,
+	uint8_t highest_pcie_level_enabled = 0,
 			lowest_pcie_level_enabled = 0,
 			mid_pcie_level_enabled = 0,
 			count = 0;
@@ -1054,27 +1054,27 @@ static int fiji_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 	} else {
 		while (data->dpm_level_enable_mask.pcie_dpm_enable_mask &&
 				((data->dpm_level_enable_mask.pcie_dpm_enable_mask &
-						(1 << (hightest_pcie_level_enabled + 1))) != 0))
-			hightest_pcie_level_enabled++;
+						(1 << (highest_pcie_level_enabled + 1))) != 0))
+			highest_pcie_level_enabled++;
 
 		while (data->dpm_level_enable_mask.pcie_dpm_enable_mask &&
 				((data->dpm_level_enable_mask.pcie_dpm_enable_mask &
 						(1 << lowest_pcie_level_enabled)) == 0))
 			lowest_pcie_level_enabled++;
 
-		while ((count < hightest_pcie_level_enabled) &&
+		while ((count < highest_pcie_level_enabled) &&
 				((data->dpm_level_enable_mask.pcie_dpm_enable_mask &
 						(1 << (lowest_pcie_level_enabled + 1 + count))) == 0))
 			count++;
 
 		mid_pcie_level_enabled = (lowest_pcie_level_enabled + 1 + count) <
-				hightest_pcie_level_enabled ?
+				highest_pcie_level_enabled ?
 						(lowest_pcie_level_enabled + 1 + count) :
-						hightest_pcie_level_enabled;
+						highest_pcie_level_enabled;
 
-		/* set pcieDpmLevel to hightest_pcie_level_enabled */
+		/* set pcieDpmLevel to highest_pcie_level_enabled */
 		for (i = 2; i < dpm_table->sclk_table.count; i++)
-			levels[i].pcieDpmLevel = hightest_pcie_level_enabled;
+			levels[i].pcieDpmLevel = highest_pcie_level_enabled;
 
 		/* set pcieDpmLevel to lowest_pcie_level_enabled */
 		levels[0].pcieDpmLevel = lowest_pcie_level_enabled;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index ff6b563ecbf5..d785cc6468ef 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1050,7 +1050,7 @@ static int polaris10_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 	struct SMU74_Discrete_GraphicsLevel *levels =
 			smu_data->smc_state_table.GraphicsLevel;
 	uint32_t i, max_entry;
-	uint8_t hightest_pcie_level_enabled = 0,
+	uint8_t highest_pcie_level_enabled = 0,
 		lowest_pcie_level_enabled = 0,
 		mid_pcie_level_enabled = 0,
 		count = 0;
@@ -1114,27 +1114,27 @@ static int polaris10_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 	} else {
 		while (hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &&
 				((hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &
-						(1 << (hightest_pcie_level_enabled + 1))) != 0))
-			hightest_pcie_level_enabled++;
+						(1 << (highest_pcie_level_enabled + 1))) != 0))
+			highest_pcie_level_enabled++;
 
 		while (hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &&
 				((hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &
 						(1 << lowest_pcie_level_enabled)) == 0))
 			lowest_pcie_level_enabled++;
 
-		while ((count < hightest_pcie_level_enabled) &&
+		while ((count < highest_pcie_level_enabled) &&
 				((hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &
 						(1 << (lowest_pcie_level_enabled + 1 + count))) == 0))
 			count++;
 
 		mid_pcie_level_enabled = (lowest_pcie_level_enabled + 1 + count) <
-				hightest_pcie_level_enabled ?
+				highest_pcie_level_enabled ?
 						(lowest_pcie_level_enabled + 1 + count) :
-						hightest_pcie_level_enabled;
+						highest_pcie_level_enabled;
 
-		/* set pcieDpmLevel to hightest_pcie_level_enabled */
+		/* set pcieDpmLevel to highest_pcie_level_enabled */
 		for (i = 2; i < dpm_table->sclk_table.count; i++)
-			levels[i].pcieDpmLevel = hightest_pcie_level_enabled;
+			levels[i].pcieDpmLevel = highest_pcie_level_enabled;
 
 		/* set pcieDpmLevel to lowest_pcie_level_enabled */
 		levels[0].pcieDpmLevel = lowest_pcie_level_enabled;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
index 34c9f59b889a..3e73f380a591 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
@@ -878,7 +878,7 @@ static int vegam_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 	struct SMU75_Discrete_GraphicsLevel *levels =
 			smu_data->smc_state_table.GraphicsLevel;
 	uint32_t i, max_entry;
-	uint8_t hightest_pcie_level_enabled = 0,
+	uint8_t highest_pcie_level_enabled = 0,
 		lowest_pcie_level_enabled = 0,
 		mid_pcie_level_enabled = 0,
 		count = 0;
@@ -925,27 +925,27 @@ static int vegam_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
 	} else {
 		while (hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &&
 				((hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &
-						(1 << (hightest_pcie_level_enabled + 1))) != 0))
-			hightest_pcie_level_enabled++;
+						(1 << (highest_pcie_level_enabled + 1))) != 0))
+			highest_pcie_level_enabled++;
 
 		while (hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &&
 				((hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &
 						(1 << lowest_pcie_level_enabled)) == 0))
 			lowest_pcie_level_enabled++;
 
-		while ((count < hightest_pcie_level_enabled) &&
+		while ((count < highest_pcie_level_enabled) &&
 				((hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &
 						(1 << (lowest_pcie_level_enabled + 1 + count))) == 0))
 			count++;
 
 		mid_pcie_level_enabled = (lowest_pcie_level_enabled + 1 + count) <
-				hightest_pcie_level_enabled ?
+				highest_pcie_level_enabled ?
 						(lowest_pcie_level_enabled + 1 + count) :
-						hightest_pcie_level_enabled;
+						highest_pcie_level_enabled;
 
-		/* set pcieDpmLevel to hightest_pcie_level_enabled */
+		/* set pcieDpmLevel to highest_pcie_level_enabled */
 		for (i = 2; i < dpm_table->sclk_table.count; i++)
-			levels[i].pcieDpmLevel = hightest_pcie_level_enabled;
+			levels[i].pcieDpmLevel = highest_pcie_level_enabled;
 
 		/* set pcieDpmLevel to lowest_pcie_level_enabled */
 		levels[0].pcieDpmLevel = lowest_pcie_level_enabled;
-- 
2.34.1


