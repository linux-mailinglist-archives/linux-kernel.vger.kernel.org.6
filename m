Return-Path: <linux-kernel+bounces-343529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B6D989C19
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156331C2147B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A8D54658;
	Mon, 30 Sep 2024 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="liP1F5E+"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCEB17BA6
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683306; cv=fail; b=noYgiKzoLtGofOYsqGWCrHalKty1IT2RHc9WRbPNhbD6Q2oF8vdPPTtyheibeQNhBRYvBkYhkLv+nGs3xOSkvquSgQ/AOH9Hdvq3adh/upu1UIJNwZKXgcBXfh9LldNH4YNw8V3wQ6ZP/hyddz0Q7AfhxdOwvyHaxzg1A8GZm9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683306; c=relaxed/simple;
	bh=Afmcwdpyni8T/GXmio7K0QyJIHhPG68zmOJOzgbc6J8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VC/8GQ838sAa9Xxuvv9cgUsX/n1Ii9xADXL6pAco6Rnz4ufYrHl26cqKf/56sMt37GKGLQHNYXDe4oszxXwooXIA/bHjlNo1yLGaJejAuOSGJJQmJvVGw1EcTAcA7isA4+s2tddqk9IyIhKo17kAiNDG+P5hdG4iePYWXnNGWkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=liP1F5E+; arc=fail smtp.client-ip=40.107.117.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxNtuOkrusGit6Oiaw2grqqYFhNHP3JLirW8ICh9ybL9ev9lNrw8mLHmAMvOd2zcexkFQjvU+nDR0OGKE6iIzzTiAmdEfQ5fgG1QacI6TI2FhHfOhOh8R8AmV9zf3ONrcphZsFXFwsCe7mwttbzhRGXeVd/ZbUSdjjLX//YYEbDW74Fo9Oj4r06b78lVMRvOMxLPE2mDm5fIKQPX0rlkc0Hum6cdHVeMl5No08Tna9QIOEZqPiNACBkde3N3haOPqzW8SiWqe4lhDdZGY3LMbQ+itW0NElwzr2ZSkISeA1KuEfRu9dYJD/u8Nvj929BgDNLbdoU96lUByy4J+iNTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx0Lm55kR2svVsGdg5vysEr4uqAfrCbQ206Il3out1c=;
 b=TEBSArrJmft9vIwIlFLKNlBQwm5W/qjEa1dgN6E305yTgp1uMs4vR0JtHXMz6uBXdxCwkpmJejloVSj7hDWjWb6iYuajvwTJSEUoyYJeWJ0g5KC7Gv3ysgd7Zq4HN7nhrZiB+odgOVC6pTt8k48kY6mqqTug1MLCURqMNkqKBdkq28NXJLxkbAQkgFcOJOFsWlN7cxhTrSAmNX+XYgmLmorsBOXhOtLKnenpAqHQ3fLMTtM8zb4gKcByvUtpVHOyE7bkbcrDuY6YBPrDxvwLfaVcaTXa9WVW/ruOCqy7+lufsf5QrupXUDcSMtbIlHA1KHWGT7mHmPV4SZYuXrF1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx0Lm55kR2svVsGdg5vysEr4uqAfrCbQ206Il3out1c=;
 b=liP1F5E+/k3BTNiJiyVHiYgarLbXOH7uQyG3CE8C69P6rNpr+BnxKuFssMAPJruJbv7sWsNWsj7mexpo2rXxknJgE7dhNBk4xWOvLrJB+98nEN0u1qIOi/FLXaEfs5hGIqGVcyt/0+Dvx4Wbgfa+d2wF4rBMY6O/X8HLipnIuC7I5hzfBSWtGPdAIED7FHttzNQQ+g4PqSsK6OcXpRlyGSMffxKU3oAieDWozoITfp5DuZn3HX+nBMAXI6lnIAPQAIXjJD0+yD18jqq1+R9GgqW8Gs1f+LQVN3yoa6H6mcUyPMkbuyx4EVBbnTIM2Eq1hcG4Fm3A0kZGBEYtgnYXpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEYPR06MB6397.apcprd06.prod.outlook.com (2603:1096:101:143::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 30 Sep
 2024 08:01:38 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 08:01:38 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: myungjoo.ham@samsung.com,
	cw00.choi@samsung.com
Cc: linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] extcon: Fix typos in the comments
Date: Mon, 30 Sep 2024 16:01:24 +0800
Message-Id: <20240930080124.626058-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::17) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEYPR06MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bbad2d-d498-4560-eff7-08dce1261c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EvDxa+sDN16AW2KBPG7+vM4VuU6wKPUOJ3f+nVH05mCRpE1yDbkdILGI5uXS?=
 =?us-ascii?Q?/3junQpQimW5ogRei4sU7c7DNMN36+KMBvqrLUgT5PToscl2ePH9mDZJHrm/?=
 =?us-ascii?Q?CMCRcHYTNlH59qDI8EpU2MykfFRabAV85w65E4cxeg9Ammt5Bqaoj/WpLPxI?=
 =?us-ascii?Q?TGcSHGbsTTdOscjCDqZLX8U9dTf+HcOx5taaoTThvjOHM1cEx+/VwQSEhuyV?=
 =?us-ascii?Q?Gco73Pisu/GSEGUcxzqKBwpOO+M7x+9V64DdnKZE00eQVRueV1XED/XWcn2W?=
 =?us-ascii?Q?ADeiz23QcgRl/ajhdHt3/oxS86tiuAx06UyFJCghJ7mTgxMB7SS0wlpWUHSl?=
 =?us-ascii?Q?DNk+01qjkt94jAckNNKf2m38SMXQFoDGw1s/kSdixned1y//cUQVzgVJn+Xn?=
 =?us-ascii?Q?Hu9HIOSiVyXzbLPTnGgQd8Pvmxd9PRhYpRzy7AojdusM7vHBNCIwQsi6i0c+?=
 =?us-ascii?Q?wmXvP8aWNrxLThMChkWDinEGkVhMyINHHce31D2EGLBFC6mQjLfBkIjJOVrc?=
 =?us-ascii?Q?I+tiJCeGhhvksc8Ae0qO6ZiwfNIXoKCA10VJ14uSd79LzBGVLY6m5FuXjQn3?=
 =?us-ascii?Q?n9rCpwEgk+7IexOFqAru4N7SQHWv2Y6aV44BmXbMbQaJwJrChYdgOM9J8H2p?=
 =?us-ascii?Q?qIAhF368Ir99cOpHfeVZUapuzaxYmvI+Gn0gjdXnVYfAbvYEHi4VccF3NitR?=
 =?us-ascii?Q?/ubAVfAoRiUSHtmmTzSkstKNgpDVZEsVTJ7BgAkDloxpsIUW0c8brsYWhi3u?=
 =?us-ascii?Q?CEzYUio7aVU5ZSLnzRAqKI4IwGmEs1rEtTr4iXIKkSb8+x6OGxhbP9wa7LIk?=
 =?us-ascii?Q?HBIdMpl8HikvSsbwZtzVx+59uQNAr0tkKApsjswoMcMbaRYNao0pgPEOl1dq?=
 =?us-ascii?Q?3v8DyKN1YXkpY/F6QilCLa9jNJ7lAxpif6e/1dAQW3Y8RAZh3FQZ3hZ/vme9?=
 =?us-ascii?Q?c5bSKYbIj2h1yuK/PwY3Kcuf20fU4ZollQnXOWi5EdTTDj+zhvSfiMppJhB6?=
 =?us-ascii?Q?OhIkKm0O+EncJhHvgHXM1ux4mFmL0jHfOFoXEb+r1y541d1TJZc2ZGHPimAn?=
 =?us-ascii?Q?/EgYTztOw0MuZHBoj8bWmLDieZgyW24qQJ5ZsfWi992LNd9qCkXIzhmJubsy?=
 =?us-ascii?Q?DwckCK7F/41gBmcDPR5H0Frp4FypM1MmuPM53H4dmFMSTjubC6GG6q3db9UL?=
 =?us-ascii?Q?osaoarz338O4qPtXMJxeNSvohYvxopUYNducuNIPYuLJvqTctOBW/bAOOAnO?=
 =?us-ascii?Q?U0rEB6//kY/gwt154EgcYrcI3a7mdnvsKyufuOy+x4zMOI64mRZZW0BPLF/N?=
 =?us-ascii?Q?LcKR0KGSIANDsw5SanY3DPE5bzj3+Ig4mwE7BCqc43VEf3tzuHQvD/2WPSWR?=
 =?us-ascii?Q?0YNjCp28AIvxPoFsUVSy2cKS2YvMYezxUHKWn8wbySb7DM+uNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mR0FdVbmKNlDWNcG+8FTpxs5+U6W86IyJikv1Kcb90OtaBG14NZhw2gUPPOT?=
 =?us-ascii?Q?S+PY146J8vlUJpjIXGBlUo78D+NvnYyE7BArVyUrMzC3yeL/hytUe6oO/V5m?=
 =?us-ascii?Q?JcuA2tJTTX6KBL99A5fu2kmi2gAvI9cuhc8OffhF6JQD5eDUryJq6VeaHjZD?=
 =?us-ascii?Q?7fGwP8LYFz6baNzywdYHAElYh3UDBn29arv+QVp7cshRn1wEecXK9aRzQZcx?=
 =?us-ascii?Q?cIKBIT1sDs1z4cfX7eNScJwmkX0z4lriktCgOiQ4dStdOxlAPkO9+THPeewG?=
 =?us-ascii?Q?/JhabY0JDsYeC3gg5skloW0MyWr0ZGzVicLzp3BDnWRJwRQrh7uQnZR/kO7O?=
 =?us-ascii?Q?PTu7RECAMgctLZ+tNOjlYolc/IWM4l3rkwbejXJiud0rfkv8jNHbueWGuzl6?=
 =?us-ascii?Q?7M40agHe2FKsPLQjdozpgjg4/NpIGU7GRpEyVKAeVzerE1+GPZCyhAjNgR+m?=
 =?us-ascii?Q?3hsV115AZVomge6x3/tgO+nvUQZeZg20a4f8Skzr+XRm0MMzeUGfrlwAkHLm?=
 =?us-ascii?Q?5Ckka0N7b3dtEEYN3+lOD5BFKHu02tgIrn9px5EGqgzFFoCD889uVkPsYTBq?=
 =?us-ascii?Q?QbB/HSxnL4cM1DRMZOUt6/61mzK6EK8PM18agQh1NjSzYWmLjQcZlC+oITT/?=
 =?us-ascii?Q?863G0fyvJxaChh1OMRZinWDVki5a2a8O1djxxet5KU4AttgUY/KdFyF0dYvO?=
 =?us-ascii?Q?1tMxoZFBRUAoUUvz2WD51QfLt29NKSeZNfOApbobrsfonXMF/AzjSSsj6zYL?=
 =?us-ascii?Q?MUP36HFMGM+CLYdKJVX8YGM5bVKgHnkPPinkfK66GWvydp73Grl4UzlfWvf6?=
 =?us-ascii?Q?L17qAMiVkkEULeyWDhKxqp732yfVpyawkcOZlF06rQGEjcb7OFvwoJKTBNdK?=
 =?us-ascii?Q?RvaGi1ZU480R9EPELEk/y9+tS/+0PVsM41qojJlJFqqoJypPsUX+G7HiqlX6?=
 =?us-ascii?Q?VrodLrh29gDFH1rM5wW1PrFb5Kf8BZJ+JD9REModYKr6QShHz7rEANfafWrK?=
 =?us-ascii?Q?8xwE3BUXffpv0zP5dKZOGEkk8qN0DRtMDlUkCCFXXeHLbEDd84tLRc8VHw+B?=
 =?us-ascii?Q?SwM7X304VfFQp3Uauf9T9vfVasD9dJ5tpChpJmX/HlptsRMUIQhLNDDtrFWd?=
 =?us-ascii?Q?JMhqoxUxk/AKtSRvgUDXJy24Mhfo6rX1bzPQgiT/+YSY0k+FNAtrK1+JKB/b?=
 =?us-ascii?Q?O5wZHACvkB+l86xVxzgpBB9c61gyrIYi8MbCEpJPTik0snsaWI08B+vJRA73?=
 =?us-ascii?Q?IrCt7LaLMi7QZAtv9jUEhp4jWVpdgjkKVOwD1HcKVcV67rUTCYkTExeebNih?=
 =?us-ascii?Q?12GdPvmjdF872utza30AxRBd58tryLImGSz/+zZsZw+8g2uEbQMkO9DnhQ2g?=
 =?us-ascii?Q?+iY8erIu/8QmYsFbWyrJ/KJr+eWjI82x4obAlt6Hob2VZzukjOHrqnD06lDt?=
 =?us-ascii?Q?RKyeTqh7g6zRoX1f5J4eIbuqhrDJ6G/0b88H6v4mmXltmgXXoPu+lIRF3G2A?=
 =?us-ascii?Q?yGN7OQBcMfo1ZVPTuQAYPUGui1OTM2lTaI+kJeu5hxJT/1EE+yvgNaFXwnVF?=
 =?us-ascii?Q?okY1p2r7brdWpd1dMNWsGtTOhwAl1BBYamQFbZOJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bbad2d-d498-4560-eff7-08dce1261c78
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 08:01:38.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgYkDsYFxam//Dt9P36XShQrHeFyYn0GV4KjDwkmqb89NdD3hLSTErDo41oKB9vXw5XWr/rJnCryAXuGd3tIyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6397

Correctly spelled comments make it easier for the reader to understand
the code.

Fix typos:
'negaive' ==> 'negative',
'varity' ==> 'variety',
'reigster' ==> 'register',
'drvier' ==> 'driver',
'funciton' ==> 'function',
'simulataneously' ==> 'simultaneously'.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/extcon/devres.c         | 6 +++---
 drivers/extcon/extcon-max8997.c | 2 +-
 drivers/extcon/extcon-rt8973a.c | 2 +-
 drivers/extcon/extcon-sm5502.c  | 2 +-
 drivers/extcon/extcon.c         | 2 +-
 drivers/extcon/extcon.h         | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/extcon/devres.c b/drivers/extcon/devres.c
index f9d52e8ec5cf..01da069ad4c9 100644
--- a/drivers/extcon/devres.c
+++ b/drivers/extcon/devres.c
@@ -113,7 +113,7 @@ EXPORT_SYMBOL_GPL(devm_extcon_dev_free);
  * If extcon device is registered with this function and the device needs to be
  * unregistered separately, devm_extcon_dev_unregister() should be used.
  *
- * Returns 0 if success or negaive error number if failure.
+ * Returns 0 if success or negative error number if failure.
  */
 int devm_extcon_dev_register(struct device *dev, struct extcon_dev *edev)
 {
@@ -167,7 +167,7 @@ EXPORT_SYMBOL_GPL(devm_extcon_dev_unregister);
  * "old_state", not the current state. The current state can be retrieved
  * by looking at the third pameter (edev pointer)'s state value.
  *
- * Returns 0 if success or negaive error number if failure.
+ * Returns 0 if success or negative error number if failure.
  */
 int devm_extcon_register_notifier(struct device *dev, struct extcon_dev *edev,
 				unsigned int id, struct notifier_block *nb)
@@ -223,7 +223,7 @@ EXPORT_SYMBOL(devm_extcon_unregister_notifier);
  * device resource management and simplify the control of unregistering
  * the notifier of extcon device. To get more information, refer that function.
  *
- * Returns 0 if success or negaive error number if failure.
+ * Returns 0 if success or negative error number if failure.
  */
 int devm_extcon_register_notifier_all(struct device *dev, struct extcon_dev *edev,
 				struct notifier_block *nb)
diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 9cddf08e0696..475c51af2f7c 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -190,7 +190,7 @@ static int max8997_muic_set_debounce_time(struct max8997_muic_info *info,
  * @value: the path according to attached cable
  * @attached: the state of cable (true:attached, false:detached)
  *
- * The max8997 MUIC device share outside H/W line among a varity of cables,
+ * The max8997 MUIC device share outside H/W line among a variety of cables,
  * so this function set internal path of H/W line according to the type of
  * attached cable.
  */
diff --git a/drivers/extcon/extcon-rt8973a.c b/drivers/extcon/extcon-rt8973a.c
index 19bb49f13fb0..0a0d99b06005 100644
--- a/drivers/extcon/extcon-rt8973a.c
+++ b/drivers/extcon/extcon-rt8973a.c
@@ -269,7 +269,7 @@ static int rt8973a_muic_get_cable_type(struct rt8973a_muic_info *info)
 	}
 	cable_type = adc & RT8973A_REG_ADC_MASK;
 
-	/* Read Device 1 reigster to identify correct cable type */
+	/* Read Device 1 register to identify correct cable type */
 	ret = regmap_read(info->regmap, RT8973A_REG_DEV1, &dev1);
 	if (ret) {
 		dev_err(info->dev, "failed to read DEV1 register\n");
diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index c8c4b9ef72aa..6321b427781e 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * extcon-sm5502.c - Silicon Mitus SM5502 extcon drvier to support USB switches
+ * extcon-sm5502.c - Silicon Mitus SM5502 extcon driver to support USB switches
  *
  * Copyright (c) 2014 Samsung Electronics Co., Ltd
  * Author: Chanwoo Choi <cw00.choi@samsung.com>
diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e7f55c021e56..b84068dd9fc0 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1238,7 +1238,7 @@ static int extcon_alloc_groups(struct extcon_dev *edev)
  * do not set the values of "internal data", which are initialized by
  * this function.
  *
- * Note that before calling this funciton, have to allocate the memory
+ * Note that before calling this function, have to allocate the memory
  * of an extcon device by using the extcon_dev_allocate(). And the extcon
  * dev should include the supported_cable information.
  *
diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
index 946182687786..a920328ae58f 100644
--- a/drivers/extcon/extcon.h
+++ b/drivers/extcon/extcon.h
@@ -16,7 +16,7 @@
  *			ending with 0 or be NULL (no mutually exclusive cables).
  *			For example, if it is {0x7, 0x30, 0}, then,
  *			{0, 1}, {0, 1, 2}, {0, 2}, {1, 2}, or {4, 5} cannot
- *			be attached simulataneously. {0x7, 0} is equivalent to
+ *			be attached simultaneously. {0x7, 0} is equivalent to
  *			{0x3, 0x6, 0x5, 0}. If it is {0xFFFFFFFF, 0}, there
  *			can be no simultaneous connections.
  * @dev:		Device of this extcon.
-- 
2.34.1


