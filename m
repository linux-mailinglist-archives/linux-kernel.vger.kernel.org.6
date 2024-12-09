Return-Path: <linux-kernel+bounces-436883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E059E8C15
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E913188591A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3D5214805;
	Mon,  9 Dec 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="AJruBtg5"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2102.outbound.protection.outlook.com [40.107.236.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17AB21481E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728855; cv=fail; b=eBCIByVdknogMOGk4d31NHjGc3ZX6DF/fQaGYg+CJYoTUmUdfb9Kh32wLXksfEGY+GgxYW7zVu+YcuUiX1OvYS2VFh+Tf1XcqB8Kas6nS0cQpKbp7op0pKflJKmIGhja5oYuvNShVRCYmD72aWfXxAN1xxJNOrDc2fbFdXfFUhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728855; c=relaxed/simple;
	bh=sLEUbWqSbxG7LKS4OWMrP1X+BH/d4l+7Umzc2Ntr3WU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=O9vR/e9NQ1ougmOd1gSs7NxSgD361IKViflsx+0CHlOfB7M1VaqbHMcCFP3CmGb6rK1s0Pn5CW82ZGzkPBP6wD23QUaJ0yJ113u438RYvTLvtNX6zVAi8Eq+oPsxQHXkjUAvrPqRzwlG+aUIugngb62bqVHtBDPuC/jZasM8AgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=AJruBtg5; arc=fail smtp.client-ip=40.107.236.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zgu5K5X93Bw9tlPQYx5VIX6XBAoJIdgeONSr2ItR662usAJQBZwu03VA4ld6oBamiCdXj0V4Okl4OtiQ08nETBzZ/W+bFRc/0pwj9gUUkoDsMK2dVszxLu72uORh6hVOitlk5GPSHVjn0E26k0wcLzjmGwTJr8hgXo8BrUELXZbY3kBJXKMN4nYwdIC1UM/t4cIfAfEgQY7Ud1stnGqzGglUHCRSntUvmlf7ilwAhfcMDzsUTIlv65p0Iwor8RQELhMKVSj7ZeOqkDhc3Y1JFeENEE505oNzyM7TImOEeIJs2eI5ISEQpjLwvIAPS8gzkxo7e+2AGsrsMW8ru/ys5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwvtflO0eQ9q4w4DOxaRWTP4ieks681Xlks/czfMYgc=;
 b=OB1ZitIcvNkQBmaCJ2kPPr5IEQS2keelKCPmSXO6NAjKUO/FETTckTJbzfZ4YzLh+L6vJmPbSVkwWYtpCzdvxyuftXKNA6VQMcAWXE8OVgpKBQj+V44tYwFh3ekqTvTqF41UoWnVn9bFo2TuKc5AvhiQOH0Z3KZuZTOiz9Du+e/nalb+VPynmXxTxTxbFgeZAlIJhUwRpA/DJ98H7jHrF3ZjVd+cCpFAZag1w4PG9E8S2RhgKJRNNPDA7BWEvIXxaLlRQ3u+5ke9Lk9z8CMC2CBU/xwyIiFYrrxRGxy0iiE4luIKcw4NtUPd9QzIqh5pD7r5uFUjf3X9mAaxuEfHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwvtflO0eQ9q4w4DOxaRWTP4ieks681Xlks/czfMYgc=;
 b=AJruBtg51/F8xAWHrVS8LWMJBXvI4RohAfyT7iHjWldJFwUM7YVY0TFGpTDzHyTHFChcP1LKGCntMF6PWB6aFZyvm4xnK0q1AFlNtql6KPxFWTfbwi+xcSxZ1lKhx80oFYwlVCCdAtMGDumGIhPlDVMjBUV2qmKORGNfW4rexnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BL3PR01MB7196.prod.exchangelabs.com (2603:10b6:208:347::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.12; Mon, 9 Dec 2024 07:20:49 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%3]) with mapi id 15.20.8251.008; Mon, 9 Dec 2024
 07:20:49 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	anshuman.khandual@arm.com,
	corbet@lwn.net
Cc: patches@amperecomputing.com,
	cl@linux.com,
	akpm@linux-foundation.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	xiongwei.song@windriver.com,
	ardb@kernel.org,
	inux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v3 0/2] arm64: refactor the rodata=xxx
Date: Mon,  9 Dec 2024 15:20:18 +0800
Message-Id: <20241209072020.4743-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BL3PR01MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf61d4a-9e3e-4f50-c331-08dd18220157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cD/eqJCqu9MyANfE7Cu/3bF+JMeE3H78SEyVpWZeSeubltWHi7NePT5X/VtA?=
 =?us-ascii?Q?FrfABK1WBAIa1ElK7bOPbgK2eoUZOT2oTDd4WcQRdTn/3u89ysn6yzQREXVT?=
 =?us-ascii?Q?LsQFn7luxA1RyhIDpwuGSKbLrsf6kCFJrsTAXIP/zEe1Kx44UbmdyT6+tswK?=
 =?us-ascii?Q?Y0Ljvc2UMr4RYAj9Kq5+gBp3QhmQjYWdU/8SX/2wGxCHYukZoX1EJ5UduQ/a?=
 =?us-ascii?Q?5qTGOgE5V2wVHzlwL2FpsDxrU6KfVnnMFseajGaAbbEWQnkYBX3DBVzVDHU1?=
 =?us-ascii?Q?FXAUSuwAJSKuyrdJiKeKTWbDx+c7PXqt7hSCq+ra6dueYSZ0eVUssJyIBp1c?=
 =?us-ascii?Q?fMe9GF4GnPTdJOo5i9NwzH1RhzH4m4qcyMBOiwu/n30CJn+IPfYa8vOcdsdG?=
 =?us-ascii?Q?sWBKl+H+02SSgDYMekjlntxaDJQy0vZyxnhfiK0URRbzwO1hmxE/5Hhv4XX0?=
 =?us-ascii?Q?ObM/KMOI1QBPdLpCnJjsmOuuUQZy9hBJBLF69NEWBEC4mvfvMaYRLno5s/1b?=
 =?us-ascii?Q?H43tHst6uPxCE16o6v9na8VqMxhNKrScRnOdU7MPLgGOrqv2cQiq05wZ4n9B?=
 =?us-ascii?Q?xqNt79PBMFRidEwHmVnUY7TyOdCF7ffq+yXmFGJ0V9VrRVhhjcSRIHzqWqHK?=
 =?us-ascii?Q?CreOZidS4rfmW9ufDB+egVrUqDVPEK4smeTNSPuF41Li1foYJxiS7XDuDJtE?=
 =?us-ascii?Q?4iJ3sQB9LSNoo+ljZd3dEDhGkTUx6So0i+iNycs7/16Xuva74GQyuyPCCMdA?=
 =?us-ascii?Q?QtPfxJ7hVIkuE1tRmsArl8w1hhuIt+EMBH5c7lHFijfXRGIweCRG7qqX4ZBE?=
 =?us-ascii?Q?wjgYtq+2TvZojzot/B+/c97b4djPd0rzAy/pwI2vTvYcJx3LurBuJDL4RBEj?=
 =?us-ascii?Q?lPEHx0FLeqzebOL11ZkXyd9bBy7jjpd9OKRtxmuicP41VhUNoIMoBn+WXoK9?=
 =?us-ascii?Q?VG3v1pXDRba+LOX9KJsKdDT7Wh0gSZDm4S5YVeog5ReGhL0/fWv1flSb/Iao?=
 =?us-ascii?Q?vuhsWWOnBVhMzpYgKGrnfWIF9kBl0kekflV5AHfEzKX0srzv32AW75XjCkmD?=
 =?us-ascii?Q?E4MXDHq7i7omlYNRmDY/LqaosziyINrF6Z1vgQYFaokkDuyNafEApor7NgaW?=
 =?us-ascii?Q?7NfElPZlEXuokovKhyda7j7FQrCWYmHNN4ypFxr05WtRpQAnvovMO73+Lb0k?=
 =?us-ascii?Q?jcg24tn4Dy4ZQSqLWNhPGEdxsjEK1IlcJ/Mt3oq965BE5RsC4OruZbhTyzMs?=
 =?us-ascii?Q?5W1X+9oC6BmQBQVCA4RgKacJpXL378qvRHs18x17LQF1p+gRCfqBkaAUkgB0?=
 =?us-ascii?Q?aYCfTmbl3Z5n+nX7Dqkmk7MeisKUrlHsD2dDgMMoskeTSGsuqpMrruOiukwJ?=
 =?us-ascii?Q?OOS9N6A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ldYElHzoKwyw5IK4JLmMJoQ7/s0osAYqw9uS6bnrXbYWLzB3fd4Y1M1CTvVJ?=
 =?us-ascii?Q?xEE04BIYSgFiOvTTM2EbMh2Vt8MBppa8I0mOhpfJJrFMwN+q6rYdAIGlpZ48?=
 =?us-ascii?Q?uLEi4twUWLDUsKfSMLdQMqiZ5RODK4TJI2w5CTNxbdosvzAKDNuVQUrXPeKU?=
 =?us-ascii?Q?vZ2YEZM00BEKR5RNXXJ96A/R9kGa8pGqYOANPs3Dl0pjGfp1KBtQQSuKGYeh?=
 =?us-ascii?Q?RlcWADbGBI+e2yGaMUTRXc4l+TRibc7oLOWbrly94OdUfFRmEKIarekR+jJD?=
 =?us-ascii?Q?FwgzAQJRDiqiOa2xP5PLk22fgEgu+PjVZUs1KI+OQ2yXw7B0GOr9KppMA+eC?=
 =?us-ascii?Q?V2oHuv+OZmfjIqeQNaGfSY4jPxzInnItD6uApgYXqhTElw2DG0gIHJkXOX5v?=
 =?us-ascii?Q?2xXn/UjLZUz7PSbMYj5C1UQQUA4ywXPIu+zdn4k1mmsNhLv5+hlzGmZUquFz?=
 =?us-ascii?Q?33B36uGB1wvzO+K7sh5HoZ4sxvxd77342sIBQJqWo9AO/HMvHAyd465HCybb?=
 =?us-ascii?Q?t4TkZMTVB8BMb2DLGJafr8la+BpajA0V8NIXj58JWsXD1K8Gyj8DqKSKk0qr?=
 =?us-ascii?Q?LJ45IQetRuDweLAT7yBQ6AaV07a1V/piUugmajt+kHgCcNgRCzo21xR949TC?=
 =?us-ascii?Q?5ZRyJ0AxwDogl+7qtA8TMrtwKlJ1wiH8hl1KPNLNsMGoPQbauohc5+CRNzC3?=
 =?us-ascii?Q?fRWwkIgF9NREV5nIrGKZMy0FySnL/jdOJNUajKVy1H04TqUm+LlgBU0uVMkz?=
 =?us-ascii?Q?moWn0VOanfE/UkHUDjP+/2L+VprOs10x4BgAFgQkxTf8LFID8v3sIMP4gEVd?=
 =?us-ascii?Q?V7gcImJz91/MGF0nlp8Gu+0sTn4+AYEu7PNXxZI623zjCOBzC4brC3Fz7mCo?=
 =?us-ascii?Q?lnmige1CqkK7kgxEBY9ADgXVKWGTKMfwRIiSHN11FLm+c6O1wDxm1o2pvk7K?=
 =?us-ascii?Q?P3Qou6RSGg2Nb9ynzh3GimVUfYdmp4ID4DTGu6iap4fkiBlmZ7FKzFK9ieh7?=
 =?us-ascii?Q?XgLkFXTVN6cIZVIRYVGvldYQTvGSvI/wcZoO8xUbYO4E2mLu07MdEceku/Tc?=
 =?us-ascii?Q?lkWVErNmcN8GuADS4uQFoTb2ssqCsBNgyUQ9U1E2gck2DAN5BRG9owyzdXxC?=
 =?us-ascii?Q?QE2iHMFRSQwFZudt5nutEvxlH7ZBjz9v+RDcYu4wc9WMTm6nDRaCmPCvALbZ?=
 =?us-ascii?Q?WbvqhR9v3G+0YqgnQEQ43EZW4J6qFZ0Klzl1SjtZWMS6w2MS0W6cDUnFvoZC?=
 =?us-ascii?Q?PsxlKfJ2Qo3bwFaVAEUiNAJPju6rlZK/CR70LmtDBZnZM4pwKBVtYmDtb249?=
 =?us-ascii?Q?tiUPZ+ArX3SpiZi2B8h4GPFHTnk+7A150ppOY06rqxba2L1RHfg4Ki1iQ4R6?=
 =?us-ascii?Q?mKhY+u2tAYwy6tLj88QFagjbBGvwoGA3kOcPOhtokn0EJaEFQ59w3MDzakTW?=
 =?us-ascii?Q?DJhtos4a2VAXsps7apZ6aIP7OLOyO8rJ1CApgkKGug4hfqUv5YJsPxXegrSN?=
 =?us-ascii?Q?pFOdXVDxUkH6dkj6uwNzAPl/HvLKDqNHbMfyxGdOBKDFl0RfapCvr3PqgQZ6?=
 =?us-ascii?Q?LEnv7AgZxcn/woc9R0ZTSfIfP1zlAE0L5Vg99v1FM2CLC9lE63d5mXHPme2o?=
 =?us-ascii?Q?9cxrrIdv8YI1dh7sFnBawnw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf61d4a-9e3e-4f50-c331-08dd18220157
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 07:20:48.9644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZg7zZ9hUPns0sjlyRnM92yrH9CDVXtuXOlQ1LoSA9aLIhZUwbc/ZKzdjbeBF6oY5rqYU4GajijQ14YN6AOP46ID3jdlKXHtkl4RXy4euqSZtu30aFQCkTg5BhXozRmf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7196

From Documentation/admin-guide/kernel-parameters.txt, we know that:
 rodata=	[KNL,EARLY]
	on	Mark read-only kernel memory as read-only (default).
	off	Leave read-only kernel memory writable for debugging.
	full	Mark read-only kernel memory and aliases as read-only
		[arm64]

So the "rodata=on" is the default.

But the current code does not follow the document, it makes "rodata=full"
as the default.

This patch set follows Anshuman Khandual's suggetions. 
It makes the "rodata=on" as the default, and removes the CONFIG_RODATA_FULL_DEFAULT_ENABLED.

v3:
  Follows Anshuman Khandual's suggetions:
  - Merge patch 1 and patch 3 into one patch.
  - Remove patch 4 
  - update comments and document.

v2:
  Follows Will's suggetions.
  Add a new file fine-tuning-tips.rst for the expert users.
   https://lists.infradead.org/pipermail/linux-arm-kernel/2024-November/981190.html

v1:
   https://lists.infradead.org/pipermail/linux-arm-kernel/2024-October/971415.html


Huang Shijie (2):
  arm64: refactor the rodata=xxx
  arm64: remove CONFIG_RODATA_FULL_DEFAULT_ENABLED

 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/arm64/Kconfig                            | 14 -----------
 arch/arm64/include/asm/setup.h                | 25 +++++++++++++++++--
 arch/arm64/mm/pageattr.c                      |  2 +-
 4 files changed, 25 insertions(+), 18 deletions(-)

-- 
2.40.1


