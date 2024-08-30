Return-Path: <linux-kernel+bounces-308247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F85F965948
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645471C2142B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FD316A931;
	Fri, 30 Aug 2024 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Om08QLBX"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2046.outbound.protection.outlook.com [40.107.255.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946FE15CD7D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004843; cv=fail; b=uvr5Q2DUCgWsRQDug5Gc1I2faHXnIBAgbUNqQp6sSGL/p4IkVmHtnYX8n9lkqyPn1r2SOvFG2fp7NapbcEtBXLt+kfjaWNBNnK3Voyx6GE4KI4TRutcw175q0tXK8QS/ZLphrTINjn8xOLtGiBOXKzaQRje/CngM34IAkwMCXZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004843; c=relaxed/simple;
	bh=uMMzSBebXXKvsTCPFzAePU5iLCG4wmd34/prSOLAX2c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u3CP8DSKGTRVVdJGCJJ9zGRAN9R3X/OVkWnUZl/lP0ij9WRlF5s5fk1NUYhZiHCTUhca0TPy7EFKa8GKs6ELfwylXfVBc16MyTjVZaWVdNX6lncCTdS9LqMFdBo2/79G84+NdGVcIURvg2GH+WlgQNa7dLlkMNL6qRbrZW0ZvgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Om08QLBX; arc=fail smtp.client-ip=40.107.255.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovDvBF9/EFP6Y0LguQ+sP4QIbexcpia+YHdji9eoz8Xuh32NWsAbXGCcALdHXDRVb15sydlopoZsbx+pAY2rQDCVZaK4ezCYTWToeBUTdGRV1UdW7XDmm8nLFfOuqJvq/GKdz2ln11orT9ysZMU68GYM+oDQqyJv7ugv/7zU9X4RtzDgopjGcfEe4Kyv1OKtGDVAY3dw9C+dnes4ztjy4o++t1jl9ugCNnPeBU4pspbiO72yp83AEC1QVb9xDBws3tn4sZ4RC96l9WfRV+j23pzAletgRR+vYQ3wWR0dzTaWPickGld/fD84ZWG6f+H9VifrzJ1HGsrbPR7D9khHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+tZjcVuyAmIzZ9so2SWUagSZfz89M/gkSj310EhV30=;
 b=FV1YxODc6LEecoxUkZ68qkydsuhEawM9pIfyCrfu4s1n/ewH2TC9huw2hoaAeRzeJckEnvb7fe7u7L3EZN0AU/mgJTcc9eaq3KQupI3TarPV5dWpjsrV9CmSAGORbQYdCbb6msU4HxvA1jvp4xvZ2IvNMavaZ1834vIjIq3WTXa/wiuStsAv9WnR1IypkYO0LT0FR1X9KmnE2mtiGz1nYxyT6yuOyGoOwVmg9gxNrGe8OvoUEejVmu4XkDpKneDvJ6sSbpSz36KyHCHuzagLEuguWtvZ8ZYVr9avzbJah9Leg+wqAdplfLLrdN7ltC8DT4U9P4epqw5AkBt382GOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+tZjcVuyAmIzZ9so2SWUagSZfz89M/gkSj310EhV30=;
 b=Om08QLBXh/91t8iSWN4Ju7rm1rcTwP0BIxh9y+mgzuOqWZ89zK6WHi0YrNuR1kEZJpPqpn2GrhICmtX1BtltU2xMkQUUIVMWZ0Ap8mrhZ1knXQGPpxhuCZjx7scZLeJVxfXc6Gerw1N2fcASAEHgaVMJaLSREa4URDdoTCIJPlRR1lTxVyX15xnK42ZBJ0hTfRIHzk0bpADXoabZ6zKo9J94rvXmyTMOqfOG750bvH1fARh9d58rF1kR+o+YgAmVtYbRTl0l+pV8WHmcxqvtJk9QtV2U9rtRAu4+cmNQJq1fj/oMtVSMjiZgGOgjiT6gvYykiErOK/CLivZks3gK1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 JH0PR06MB6704.apcprd06.prod.outlook.com (2603:1096:990:37::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Fri, 30 Aug 2024 08:00:35 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%6]) with mapi id 15.20.7897.021; Fri, 30 Aug 2024
 08:00:35 +0000
From: Rong Qianfeng <rongqianfeng@vivo.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Baruch Siach <baruch@tkos.co.il>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Rong Qianfeng <rongqianfeng@vivo.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH] arm64/mm: Delete __init region from memblock.reserved
Date: Fri, 30 Aug 2024 16:00:16 +0800
Message-Id: <20240830080020.33666-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0190.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::10) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|JH0PR06MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: f17225ff-a400-4193-bb76-08dcc8c9d3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AbaVVLbpfFFyDnB9ESrYcENZPKAh9+4Uw1LE2jYo4BjaXmuzDcspWODYJ2BM?=
 =?us-ascii?Q?yUtgrBTX9n9HYlXwG4UKfD4Mu2OlwRghJUoXFO1UxGRDFqtcYp3WFgnqfJIN?=
 =?us-ascii?Q?8LYFwz7DOehagjN5ww1AyfOkaXHtI3p+jODfsi3mqVuPNLyMXf9mAI8+7JWZ?=
 =?us-ascii?Q?EJ6XIvp+T3UII3fyZ5slD9uloVpHt1pRxMbDd1XsG3zJ0JfpyQfglGnQiiA1?=
 =?us-ascii?Q?7PTmEKnAgKUFB9AOZS/IUJA+2z4t57er7WB5S5/eiENtOCy3tYVdkoClIY5X?=
 =?us-ascii?Q?/VonQpeJgHoUdwVBINpHJEuj9j0XY8XPhu1rP5GKa/fVnkj2wK9KYOOvUHSV?=
 =?us-ascii?Q?LVcSF8bSsX2zZkQCnCL6WQnvRQFtuq1qj2FVJhtLuVRWPLgEKCVKTM7DEeur?=
 =?us-ascii?Q?47lphhbtNIrR8rsRgm9Dc6l2D4vTpTh2Ltmk1hKEqqxgAbOqZN4W2YEk6DBY?=
 =?us-ascii?Q?UzAjLomVsJdEs0la5NIdnv6picxJfPt9+3u1Oa+mkHQJYYvyCIZAuv3oP6gR?=
 =?us-ascii?Q?ZUz27C81TON/0Pgv1d0w3rxlRw0c5MRnyZHIDtpqw/Ct2dxsjIWSuarxv6/q?=
 =?us-ascii?Q?t7ohS+vyDdgMHnoeqqK9K2CYHINaRYsF6zrikbx/8B8LG1IsFbT37uePYnyL?=
 =?us-ascii?Q?Mn99Ne21toKw8PsSqFxumycMSuquC3U8aP3HQAcnmfH6pY37g9RWSGyKaHzY?=
 =?us-ascii?Q?fwxxk2kauErhNR1yDQsloyWFLbhMRNfZRPIPuT/mCH5ZLWJpX8JUoqUNWNar?=
 =?us-ascii?Q?ykBFKZdcSKuvgcfLFq0XH1FalzvLzQAzkF7tqmW746ywPLGXWm5lSneJua/n?=
 =?us-ascii?Q?tHNMqKCr4EZ3j20vuHF4FJ+CsD78jdwU5WPwOGFOwwyvJYoB8k1+fm8jrc8G?=
 =?us-ascii?Q?GGMlY2rrryG6Ir7gTeDEVAEApm18pBHEWJKd2Dg1E92+W3TfWvObdZpXDPVu?=
 =?us-ascii?Q?Z24DIXkzhsdJ/mibVNvpdS6kfZtz6HsofJIF3TXYoqY2oIN2FFTNZYPLG408?=
 =?us-ascii?Q?TtCpqHJIFNBMwTKzsyqJUwZHSiUm2XzKMIMai0ENoAKOZKEY+REh4TkZsTYo?=
 =?us-ascii?Q?aaKxLmz/SehkpUJrHuTGEsb7PjT9/yg1EkqV9dWHaKfnW7mxpWuArUZ9HPpx?=
 =?us-ascii?Q?+DjTUCOsTo5Xooz5SyyMGmWkfksDgcRFbg2ujwO6R9PVpnMwzIY8aZpZTlH3?=
 =?us-ascii?Q?RlSPwe9wYfiYGz4q/7TIDCVDyXLoBLZ+kiuMl7I/7Xkz24OAyglssP746iLv?=
 =?us-ascii?Q?xMAoESn5Zkn6KtxKR68SJhwL0BhU+3r3HY537BhoMIP+g0VXfXh0NUQZWejY?=
 =?us-ascii?Q?juq/7BMU1mKsM/L1LtEVIwdDsjHaKzfuPG3OHUnMomQfHJWglGYWh9N+BGdd?=
 =?us-ascii?Q?9Ggi/Z7ND9lO5JcPlKaGKXHbmRQoX7I1YvW4aZ7oSbNeczKMikfdudTdDnnw?=
 =?us-ascii?Q?sYJ8r4pp4Xk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yvr/Ie98Cc/+cBfVSHQOHZQ6ZkKs5r75cH+GQUq/3ykPKlYGL34uTM/8BvGW?=
 =?us-ascii?Q?kcjuTAkXImRfcXuRQbvNM5WcTx8Ml8JNr8y4AVk5Jhuweq7V4wz1O6bW+VxT?=
 =?us-ascii?Q?4n9kiQdzyQjKLSZLQ6LGd8xef0DqAbWhFUy52bSO9GNP/mgsLOZdOGeEPVC+?=
 =?us-ascii?Q?28ew+BQgoRFiFwOI8vH7j8mOAHPM4mlOSaOXLBnhX6zzG/53RtuwGB9XJ3Vr?=
 =?us-ascii?Q?RSyVTMyKeZMoB6uTriQ2I9bJT/OET/Zj0EVCjA+L7TRTFtV366smTukBb1gH?=
 =?us-ascii?Q?OsW5gFB/cP/Dh9UZh1W5STJRQ1TA5QGt3peo0+iKuA3McMKsAUXMCjku9hP8?=
 =?us-ascii?Q?1aMygZY/CrvNHgt0antXmqzv/uAR8Fi7omK3YyTvw8EKVJAufh7ExSwa1X6J?=
 =?us-ascii?Q?PSs8StThh3c6X0mBGDVKlixRAggVBcEZvUuw04onnQGNi0nH0vOU94B4ff2o?=
 =?us-ascii?Q?PJcQYKLV8Mz+g++BK7rVz7HMAZzLujAE5nOWRTsDB8GfKaHK2a/FOOrLGEDl?=
 =?us-ascii?Q?ln/+2Fne8KUtefwapHsWxRICDlM/jcila4h23brM6A4TS+AdYpugzxwmgEmz?=
 =?us-ascii?Q?rCQP6yOhdis9EJU+426S0z5a5Tl5YVuO/VxSAuylqURRLxHqTDykxRgkjlPP?=
 =?us-ascii?Q?CcYI8ORnfm0Oei1U1nOCLt0MOP7UXTiy+IcDZhsIJ+anmx87EPm9yfOX1mMc?=
 =?us-ascii?Q?5lR3pUCcTmTRKwU1v1NDWn2t7Epu22OT57+GUXaPKXPgoAdBQdxEBZ2DyHN/?=
 =?us-ascii?Q?X1HD/N9vocwKGX/bzT0IPr1KYIW9q5H5bRD4NPwZcf4//8Bk+cPx5bYjlH+a?=
 =?us-ascii?Q?AS1jPrjXxqVU4OWTfA2N186gAaPPY8ZsmVG20ks0GFgd279I4dHOk/TcWQM8?=
 =?us-ascii?Q?1PBu0w2cqXerHWDqv2HcoXXGfD1GJBzKzHWZej8nRuxgTALMY8vEkOvSSKJx?=
 =?us-ascii?Q?degBOrscfg2d9Y5KYst+Dl43pQe1bOC3Wyd2rpWHgRQbIghieqDd30zzpuqe?=
 =?us-ascii?Q?2GZATnDa7phYuebM4oMQ09xJur5H02iE1XnvFOmg3LbRDY2kiC9z+NAN23QL?=
 =?us-ascii?Q?U+UiqAneTnTZMuEHRqONh+/SZIGL6Z4UE1bj2dZlhFjPLwD0guvLLblyhqgQ?=
 =?us-ascii?Q?DAl5wCrRABx1Nh1Y9l6Ke4bvMD3C6Gs5O4n8yi9+hGzAJ8kiT9CFuRb2LqjS?=
 =?us-ascii?Q?8YSgqTtyPKumpBF833pRtNaSH93zqVXn56nu+fd8EBx9FzcKKFO37ghGania?=
 =?us-ascii?Q?Ck1VoeLOJR2oxy5Q+bM2q57M8sSTmKYKaWQc66kQ+lRhMygRepgt2OgD2LHN?=
 =?us-ascii?Q?r4ZS+tjQAYeeo6wa0gsQekK5B/yV5VGCXC08NFwbcWsb77tNvg4ergUhxUx5?=
 =?us-ascii?Q?fgfpAs6gQgdFgLdP4ZIcg5Z6K9OUOQMdKpI5EsP2JuPBvibtvJbASH0k3Op2?=
 =?us-ascii?Q?Z3tH/uZASAjadEYJUq2O/tCxlpHrfU9I9hIHEDkOGp9olf6JhgB4aFW9mEGN?=
 =?us-ascii?Q?8wK6Rw8n1/6OQqQtSDLL2F/5D7UPbJv2XW5O0cTrUILcqnXYdek8brJPdfrD?=
 =?us-ascii?Q?1QGrGz94psSD1Pvwg2NLwS7oRM2p8BR8BljJa1M3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17225ff-a400-4193-bb76-08dcc8c9d3e1
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:00:35.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cst0VOBy/687vgZR3XlQGHEMXJ8pDRu+sL61PVTEKjoz1LghWZLD812Af7wX5ZTU8EKmacQvIa743ErxsT8EOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6704

If CONFIG_ARCH_KEEP_MEMBLOCK is enabled, the memory information in=0D
memblock will be retained. We release the __init memory here, and=0D
we should also delete the corresponding region in memblock.reserved.=0D

Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
---
 arch/arm64/mm/init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index bfb10969cbf0..99cfa217e905 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -402,6 +402,13 @@ void __init mem_init(void)
=20
 void free_initmem(void)
 {
+	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
+		unsigned long aligned_begin =3D ALIGN_DOWN((u64)__init_begin, PAGE_SIZE);
+		unsigned long aligned_end =3D ALIGN((u64)__init_end, PAGE_SIZE);
+
+		memblock_free((void *)aligned_begin, aligned_end - aligned_begin);
+	}
+
 	free_reserved_area(lm_alias(__init_begin),
 			   lm_alias(__init_end),
 			   POISON_FREE_INITMEM, "unused kernel");
--=20
2.39.0


