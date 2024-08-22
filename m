Return-Path: <linux-kernel+bounces-296423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B395AADF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07722283A56
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D99171A1;
	Thu, 22 Aug 2024 02:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="p8XvCc/t"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2053.outbound.protection.outlook.com [40.107.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F741171D2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724292859; cv=fail; b=Q56qlaMhmnHpLoUfqFyJNrjjWW1YgXCiXenYUHyUDWa+x95nq3vOFoVcgO0/psB7nC4zkpuHFY6wjz7QIitBCUuZgAyUFNdh4s9FuLA5ZV61Xbm6tJutElG79BUAe4jonoXYIpIzYM3IEKMNqroiCiad+yTCVk/KZC6lxai2fI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724292859; c=relaxed/simple;
	bh=G15m01zAPkOXwngZtca0E0SK6nP/H8h0ajAlOoAESSY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QBnXkB0i7WQf/rdkzlox+RxC3V4yKEwnEFj8KMnpTOnW8vI5BgzLYx4pFb1ysAwBt3n228kpEqXF7pQo4vfHpGuI2WLoPBbY0UNHvDw/pomLt7R+42MEY7XtQD24RkdPTQUQaBb/pIy3ufnwkyjjlftOPBo51r9VQEG0ylTffCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=p8XvCc/t; arc=fail smtp.client-ip=40.107.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0F6mrtKjzEvm9YoZUpXrr9m3RGL1CxT5fu6L393JOPtkbJbBnXP/Y+rYn2c5Zx9oBFiTxSivyfFeLeEoAF1id8ATAVf5Eq/SY+FaKeO+gV2XqbkPkQc9vdbkfHuIs5P7P8Rmop4aQP5WPKUR4TZq88ttnpNZWEk2t+8eSml1oxdbipC9BJ5ih3ITu9+dw0C0UOXcoFbrtBk74AINXkTKrVnzwIyMa5ED1L+YeB0GLveiKgefn2qTsHjiuHYz9xCEz2pJ80o+a8/L9CatXB9BxXgwF695Cjb8zutAOQmMU2yxZqZ26u+1as2hw9mYqgOf214Yt6ylKApXAEtYJz7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNXck4mm6GDgcUskKj/n7aujxxiroUMLGhXFAITJcaM=;
 b=QDXUCabDatOGWrFZyWU3vMs6aaTvStl6rPxi+GmVg0ncNxOCI7GMVwrpyC5ZRF5jcyVRyfCq35NaGRZSTHl+/7ieSUyvcUo75xGvmWuz+xNcdtWmPIeK0WGbflL1tfEgWirEV9alfvkv5SCFcMwCuyWyXvdQNT03BZGVBuAVkiWBLrGJk78JjGTTp2uA1wiiGJMbdrv9gnAET0pPxPe00vjavlgfo7jcKdPXcu/sEylAT1B3BC439Fk2TwjJyULTPqYdaVJORo14savipTIw1nW7/e8GmTKncyilLWqJjGKD5xxgFFzuYZJGeh4Rb9/pjG+FOCo5V5x8DJjBjKYY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNXck4mm6GDgcUskKj/n7aujxxiroUMLGhXFAITJcaM=;
 b=p8XvCc/tyovXfEmD1WuAVtIkRoeII3p4zPM3nRNtbrjLkWAsB+k63sHIyLpDYHBBkGzIkIGhkAyxKOBC6/Lm84QQ2vSRidzU1E5ZVTvAKySEJ/z/dOUC7wJ6gLWpQVXoGpMKv2CIn9YNwcJ2DvCH1R4HuzDIFwC0wOYh1VDs1ntpU6252t37hBOVr7JdI0nD0zllBrTCojly1fWLTXLmSYNRk+eYf7JoKI3p9Pmadvy2hQfQdQQmOuQqlRAzBmS8RI4XsjBcSL8ug1vSy1eaEOFp66ipVHfPD/oFtNOoo/Lnw9xbAtl77ZtBF+Dn7AhaFlcOxjjt1mp4jOi206GfyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5724.apcprd06.prod.outlook.com (2603:1096:301:f4::9)
 by TYSPR06MB6900.apcprd06.prod.outlook.com (2603:1096:400:46e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Thu, 22 Aug
 2024 02:14:14 +0000
Received: from PUZPR06MB5724.apcprd06.prod.outlook.com
 ([fe80::459b:70d3:1f01:e1d6]) by PUZPR06MB5724.apcprd06.prod.outlook.com
 ([fe80::459b:70d3:1f01:e1d6%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 02:14:14 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] driver:md:dm-bufio:Remove NULL check of list_entry()
Date: Thu, 22 Aug 2024 10:14:00 +0800
Message-Id: <20240822021400.1193855-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0069.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::8) To PUZPR06MB5724.apcprd06.prod.outlook.com
 (2603:1096:301:f4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5724:EE_|TYSPR06MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: ac652a99-38d8-4d64-1f1a-08dcc2501e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SWjp7AgfGCJgGH5fOCbAySj7bYp0VKVHy/x90BuaZ4mZ9imB7STw9hAtydIu?=
 =?us-ascii?Q?5uv3gpqzuIeA5Rf3QfYZYa0Czp0fZbu6IZ1ZC3Y6atnodExZTzUh8gYUldOg?=
 =?us-ascii?Q?hU8A9KdIP3ozk1RZLaUwd22oGvmbvS85zPKKoaEP7H+fsRrX1yENkmks0Oe8?=
 =?us-ascii?Q?TRdvC1UpuEvN2GO+hCrBZSlNJvAzjS8+ok8B+Tt4rrhjelZkrlwgpz16EIWb?=
 =?us-ascii?Q?9F8xAMM6DcBIG2LLF19N0eIttrLJgMx2GFM+GP4gru08/s4Y9KSXa+Y1G5BH?=
 =?us-ascii?Q?2EZLzPnv/VCUSmPwmfMwoSIYQi2d8DzvLp040Lfk7LZP/p00B6w5TFxQpYDd?=
 =?us-ascii?Q?BoKPRLI0FLiBiPoeN9McwvxaFbihQtgzGyHeSA+tW8T06BHRXdsYlE4Bz8Fw?=
 =?us-ascii?Q?qlMwdDbRGsgdTR/0cxPLNw0/qJD9eHPKBVrnnrYFccA0NZc4d/j/vFu42zKS?=
 =?us-ascii?Q?JzVqTuY8NUbCt30qFoZQKTYdO69oSh0h/ZBGrCgCu3s18wZmEbPydwQxfro/?=
 =?us-ascii?Q?UR5o1w82Wy9HNXIWLG9fSd8MLPhGUu3U0BMoRc0Dfi4VFV7JMEGLK5ORIH1E?=
 =?us-ascii?Q?zmGf2UMPPobMxeLma5qGPfFKUZfbPigSUl1QuipVT2j1qM8a8xunjY6hXaYR?=
 =?us-ascii?Q?/TBoUeQRQyq8CZYHTGUAY1uvLYtJ4STfLpBYWakbYoMmmNbBsoaU7o1iDkE7?=
 =?us-ascii?Q?TfT4F+vnP7+UKvXdULsGFdnGJ/yYXVHfpBhjFL4CP3JRIQOrzMN4bWYr9RRV?=
 =?us-ascii?Q?vHHmkCga0AXJiRAl+re6R+9kFM/WEoaH7MLVRqrXRgnr46nFiqJ7Hz7urYtd?=
 =?us-ascii?Q?J7SCig+KT5p2O9hv36149qjU9p8mTKekgxE0fDonzAq52T8v+l+QuYnjZVea?=
 =?us-ascii?Q?sWpCofkApe0vOP5UTq0+ka9a4mXdSXijUiKmTM48f+c1vdmU6DfjFEhgJldk?=
 =?us-ascii?Q?opWoFIhzSUE+dwGBaJVvq6/vN2CHtrvAFiBAwClMjIar3YUOkNMshqJgS6oP?=
 =?us-ascii?Q?za4VNY8ZBl+0CVIzfj5z142mNmxshSjNoWvr0RWI0UVzpokkACR8fZEF1seZ?=
 =?us-ascii?Q?6RG5XQnHCwV7ij3uj+pqHzcmFZRu6TEsuo6srUMbGij/ES0qyaoMxeyvX4RO?=
 =?us-ascii?Q?TPny0e6DXFRf51IVM7OHBwPYwWC/qfMp3+sFctknzXxTaJmib+DiopvfAaE7?=
 =?us-ascii?Q?IKL5o4c7qFLSvlyEc0aqsA6u+pzbIf4czyTyJS2Q9UIh00icZBKCkSsgw9Jh?=
 =?us-ascii?Q?U68Ht86gOjKFTHP3n/2/A7t36flJH0Gwt/RK36E+4hJr9WkS48xwmFqd/hvj?=
 =?us-ascii?Q?XMab22nG8FQhthRbHMvEPM1/pTdJgk/4Ol0aApdotpHdtCEN/XzHozKE/2Cq?=
 =?us-ascii?Q?Iz5kgEpOqGK0JmBJwrfWDfVKL+yAuSkFtvh3lF/8baHzWDOh4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5724.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P3gg5Jihp4DO6M828Gs+1sTf6+1x3ozAM4cEjUqF4ZNu2WQUxqbnwNQVTFLh?=
 =?us-ascii?Q?mm1NuGze6e3zxFy+2AqQuhagzPgLXKy8KaAjC53VR160hWvdRD+eKJBcKIXl?=
 =?us-ascii?Q?eGXnx4jPHPU4oRhvyzpfS5rVba74oKhFXFuy8atWeq8q+Gv7bQ4NH/+vsmFe?=
 =?us-ascii?Q?PzM6IeQ18VvbSe7szb53rHBkso4HXWn+ttH5mVYPdHn7smvXxxCBVYMNkquR?=
 =?us-ascii?Q?EfwX9Qy3+4hcRC5PIjLVlIJ2ucT5Lzb0p1S5tnlPU8m+URMRpui32VtTjRgQ?=
 =?us-ascii?Q?Ii0fXjToUjW86lhWvUoc6dj71q/aQu0z8lHRsGABc/9lNV868MVhJc0UgvoA?=
 =?us-ascii?Q?In9s7+VQ7S9olc2d5P3ToZQlenImq2mofDKHq3saR42u0YNbg3CrABMhBxpO?=
 =?us-ascii?Q?M13oUC0MQLyioZZyqlpk733OetbD2PcIqK2fgItPZmtkGQs/TlRTgiBFAli8?=
 =?us-ascii?Q?ZwCuotbm2KFOhyDrKgzSQJs4fARwV6JpnYiAzZ6wKaK4BoOuOE311qdG5ilC?=
 =?us-ascii?Q?Y1ZAhXr7Ao8oHs1oSz1Hfk957jFuxGPhZfh7qNYNpiAX5ho1KdCDnae1XSHc?=
 =?us-ascii?Q?3SDOpTTQUu7y9EVjDee8V9qToeNphKrWPqpMTYcOenZqTlT7VaWJzMpAn72g?=
 =?us-ascii?Q?9/znecXe4kQKGRuN9OZJ2t0RtwzSkp6Ya+0x9Xjjb4JHiyUdHxvIcV2MNtMq?=
 =?us-ascii?Q?J9J6BH5J5CI/hVbLC2KSMeMcxS2ZpkIxdyD7CNCGbD68EZbPaoseP/z1Iswb?=
 =?us-ascii?Q?WvMu+uL3W0CPtMx+zJ4BVM18Gtimq78kaDJ58FTC4TAtHxhIGwkn4RYSlMRZ?=
 =?us-ascii?Q?ohak0jYvMM0TnwR87BQvYfHTRFup+G96Bpo9ecJkEx8e2x/EJ6aohgqvJelc?=
 =?us-ascii?Q?feBbe1ds9JtbSqDISYxN254NWu3Uixq/4AN2nTR99of9P/lsam6UyxVLOdnJ?=
 =?us-ascii?Q?e9QyeRc8fbIBfFdexC7NAnIqC2ODsHzcGMqCvtY7gs8LLJJSMWIdXMeZPcV6?=
 =?us-ascii?Q?vEyjak+W8wBlKmTpldGI1y/fpBQwmC2zhfuBxThh3gZDnHCsOurX7Lv4c4PM?=
 =?us-ascii?Q?tKB3QF3gEzyoqfEpJhnsTJqZ7unimevNiQswocH3yXLQmUuyEdiCY1TiaWGa?=
 =?us-ascii?Q?wDTTeg/wbyTJ2tzqvfe615mQt9fmkXSesIwJZCkaLO+sk/M5bWXM/+LHNsR7?=
 =?us-ascii?Q?8EXj8BnW0jRYkSsGoX8gFsXBa5je9hjm1JawU4sgFniWQTpvrwXUFjyPvKvU?=
 =?us-ascii?Q?Vs65Mnw+wztZOXlIx0gEiElSYV8h5IhXH5Ugsk/CMAOriMm35YnubXCZN4db?=
 =?us-ascii?Q?UVmBZSreI451ylvKV4cJygJuhdMTgSc9fTvSISa1fhA/iULUuzEOnfmZNqg0?=
 =?us-ascii?Q?OH0wddtEdtVtpAYKfK5z1AXlYHgvoiwOMwqUc5u/Lky+PGBPZa+3RkUjNXgx?=
 =?us-ascii?Q?XOsxbf63HqJniT4B/p8Um0zWms78lEysl6mkQ7OSaZhHKbXzPlqO6rv0eOSr?=
 =?us-ascii?Q?J6n8mSdxly73mDac7HnIpf1W+cOgADRJXf/y015KkYe1JEfafzrRqq1e1ne9?=
 =?us-ascii?Q?REzKveKPcssQ7B5GmMZ7BEKYfT+GLsY/n7vpPysM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac652a99-38d8-4d64-1f1a-08dcc2501e0f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5724.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 02:14:14.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uX9iZvUC3S251E+HMwLHz9O2dpTuv9kT/17uYmkaehcp/KIV77dACHstLYTfhNbKGmN4FS6umBoseRoALib1gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6900

list_entry() will never return a NULL pointer, thus remove the
check.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/md/dm-bufio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 098bf526136c..d478aafa02c9 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -529,9 +529,6 @@ static struct dm_buffer *list_to_buffer(struct list_head *l)
 {
 	struct lru_entry *le = list_entry(l, struct lru_entry, list);
 
-	if (!le)
-		return NULL;
-
 	return le_to_buffer(le);
 }
 
-- 
2.34.1


