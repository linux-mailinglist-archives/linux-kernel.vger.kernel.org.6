Return-Path: <linux-kernel+bounces-306752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D959642F9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686EDB23CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B272191F70;
	Thu, 29 Aug 2024 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bxiQm554"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2074.outbound.protection.outlook.com [40.107.117.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F5122339
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930950; cv=fail; b=MCLAhVwiNBPtBiF1AsC+mp+9M2wY7uGrNsyGJ7iFldFxOZdbsUAIjZjVQm70E/78aUoSh7tZtvCB9GE2HXOn5FsAaL7fDSS2TniNS3ap/Gmq0/3duhyUW30KdvtGOeqfiWOK9XbzD45J7O3NyTXkaGvUKcAZBX1UVbFjX+M4VCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930950; c=relaxed/simple;
	bh=JJjxxeqUVdrhYdHQHj2vO3XkW5wMKyC6UZcXxFu8Dgs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hOt8HdEgkPWTzyDPHoo9Lof+a8dEJXMrDhyvg7AXJVoeoHN5YeYsei3n7EPD4cUyY97E0HrgNSySokDcerObR98N9hiRA66ySlB83UHiW60jDfsVmwRXVsiE63OQFjwkuNbRSFXS9iEhnNsfkT/lMb3O8f9pHc/PmTwooqwxBMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bxiQm554; arc=fail smtp.client-ip=40.107.117.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obNpUXsVWoAZcEB+3VMhCL3tz9OiK+yyYwMAUdreZfMp1DHikDftJDj/bhw6WucAW5d8LmRE7lQ6PC/mpu5jI2s1VQIbf8vWlo3NjkBByqmkHRT+4pSWUuw3go7dK8Ir9bnnKymDV/bl94ql54wDGi7alq9EoFpnGm+nfz8rXTnn27ZU+BZsWvMc0Nry1NKH2ya+tZ9Bkp50WK+wQir+7W8rSA1b43wh9BDKc5c3tWsJnJEC4IpzNemzkpDYCmdTeq69deCTYrWiQte93OzMh7VSPwnI8zfPjKupW4MWQ7YRze+0WBaVlfrbuqMK+1CO1Ub0JlGGMdPSYSdBSh2F/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDpRfMuRfEFhl3UVAtea/BCUs1CbilTFR8kYLGR8+Hw=;
 b=hyM008vwwrcJV6NmGEW0zy3CHI/W9MR/cyD+DOuE75relFpAAjnrwHGI+r/BQj7UDVLz0wujbadUVSOtyrts8yapbb38EZqDFcxTm9r9fTTUBIAdz0XnXqzottlu6jnXtFmYMqspJhXJfUkn8+3dTgPus3xLdIVB7mKcRXfiM0kK3f7t5dD/OBG0DIzeRDirJELoZaa8DOXJjRmTwLm0UM9H4btpIJswj+PR3yOjgOIZFM7AZBwT9Mhg73+o59210eOubAzxN9vLy5M42Wic3DIj9DUsbgK6uugv8p0OtlSPduE2ZDQM/sXFZ0Bg93Y1uSsm9GCuPOlv5+cIpvc15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDpRfMuRfEFhl3UVAtea/BCUs1CbilTFR8kYLGR8+Hw=;
 b=bxiQm554F2e+L/jkfKtFyzXgUPVyvFBPqLC7BL2QgPlJwAMFoHzQdUrKWGjx4dJ8G3+zq0EdbUqRk70btwFcE5Tnz4lCUhpoeIX8U/orA6Ppb76tbGHAXti39A7gZ2Pl+iWYVd32KRm4wOxHXNGbWOruomLV///8ycBzo/ewT9eEFrMFTdShWByfXegFAW4s0nJgAL0XfzO7ZWR2s2d0UGWN+QLiNC3EN4COsGRejl29B2uUyrjBJGvt5uArjAJeCfuzBwAhnt04kBNZamcGv4UyWPcKzjJVmJ6IfUzreMl0MHApL9Tv6ZKG9dnbkw3qwDN0anKkkeCLZEUwFSA4Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by SEZPR06MB5318.apcprd06.prod.outlook.com (2603:1096:101:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 11:29:02 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 11:29:02 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: kvalo@kernel.org,
	kees@kernel.org,
	johannes.berg@intel.com,
	neal@gompa.dev,
	a@bayrepo.ru,
	justinstitt@google.com,
	marcan@marcan.st,
	j@jannau.net,
	wsa+renesas@sang-engineering.com
Cc: brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH net-next v1] brcmfmac: Convert to use ERR_CAST()
Date: Thu, 29 Aug 2024 19:28:44 +0800
Message-Id: <20240829112844.3193582-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|SEZPR06MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: f1269bee-de2e-44bb-287b-08dcc81dc84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NuU3XkAejgKFyvLOBVfaVE9ki1ZiZLlDgP304D0eBOn3zqE9WT82sHsSdWA5?=
 =?us-ascii?Q?CZmcbR9MsuFeUw9vPU39gIHQw+7o7pbTIRTn1EjxP92/azEuW5Dz2c3PLmKB?=
 =?us-ascii?Q?a5pK6LpJoZKw2Ad6aw027bynm4b55ILSbX9PNYaEAkLTv62hHAHzVOuf/Ne5?=
 =?us-ascii?Q?bC0NLOhsmlNHBuWSdP7iWgFndi6oXR+X6Pw1sKWbmTLmQMS+4as1onc3aVLU?=
 =?us-ascii?Q?Z5aUUqgmbkDRaXxlgnJ7XH6N46BeMgsp9ve2HUPdEwkmv22Z7aP7W6UTa0PV?=
 =?us-ascii?Q?5pvMH7rFfOofoOlW5YZXVvLSYsMZGUQk5QDBSK3NKHPT8OfRAyshWYm0OWsk?=
 =?us-ascii?Q?JJhj2Z6XbU2BfujmDF1FeAGW/8AFFkWcD8pjP4d4dJaDDOva+w4+0tTAIYhE?=
 =?us-ascii?Q?DhmfGSxdlnvH5mteyPHImnMrIKqYcEcqiWWGtYMmpqw/9q63ZObgFrd+kRe9?=
 =?us-ascii?Q?qjSsFbo1BXWaUCsNJfhTjPexSpMU+a/DkPR+VZTkDkzc9dCGWThs3i9pXmcR?=
 =?us-ascii?Q?ap9YlG8DkOPPYKJxYKooROiRLJ+BesdTyeWfNuoe+TPOlW+tJHGrmt60SCuq?=
 =?us-ascii?Q?9o5JgTnwqkcDlIaQRMA3kjPZXYuy3fA8M7Tl3Ae/FWOxgnI4LoS6InCLeQ9j?=
 =?us-ascii?Q?qW12PiJWIJFoSJJidSSU93LMgD8evdjQkYFenI8cbsjUzeL7SoAThwGYlhCg?=
 =?us-ascii?Q?iNjWnlnrqZBKvGdD58fITX1ex+uHMdlp4mnrOr4f69aikF6te92CYApkIIwv?=
 =?us-ascii?Q?/xy9MH2EoxWanCx5IDExbpDLR/rXmhoqYweU9l2TaWXDTCsW2d1sRKUPYa/p?=
 =?us-ascii?Q?zMWsE3EF598LmBTZBrb9jHrGb6MoCxPAeFHc9lqscOM51FE6RxQRvQvZLW4J?=
 =?us-ascii?Q?VeAto4MDjf+DjtYo5AfSAMUKU0s4ZIX19QoPEQvKXMjku7VUnMR8hKWbhQ93?=
 =?us-ascii?Q?cJby4FSqgt/WgEO6R/XX6YiI/d9XcHIwYQsslqDG6TWPjvZii9nLpJHvqJy1?=
 =?us-ascii?Q?8LcOwZdGT38xVehVncSH4O6S8ExrDfGftGB6483HgaBXNKWhakl1/QSxac4b?=
 =?us-ascii?Q?Batrkk8AGL5k5F9ox3YFx1e1/4B0dJOmoGrgqa6emXq0BFqH0TiAw+Ct/U7u?=
 =?us-ascii?Q?VMB9fgEnfwLewR+PzPKaClMihi0L9ZtzfvgCnjOs7xx1698QTvmXYYct9WEt?=
 =?us-ascii?Q?bQZTXjj7enQJ/fXopWLBm5REPmo5exQ8HITChVYDFfsLY3oxHCMfqalcttSu?=
 =?us-ascii?Q?DQS0TBrgGk55Qg2MJrQ6gnm3n8CN/dSsb96tIbEclcnRLv+CvHUejfy8VnDW?=
 =?us-ascii?Q?VCqWjaQtdzoeZCRHyrjJ1xzJpgPa+4fpGQgUV+RcMr4046JJwsd2MsPcGDo5?=
 =?us-ascii?Q?Co8Ecc/symZvOduwAl/PAsoDv4XG48/NI0JoBAADgl4o2ZJ2HA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QkeAqboCUzsBZNZH1VuWpb64p22z8Z66ksyLkMyjxcbo1+S40PHN9/5AO5h+?=
 =?us-ascii?Q?SLy2kXSTQbnKh1LGcjTeWaSJE5X4OoQB77wZY8GXZ8l/o5bC6jb021kK8XUE?=
 =?us-ascii?Q?rhDsW9ze21rCX+T+540hvBd2m2mFYy4zL6lrgA22FcCR3N4TiAyezefDnwEJ?=
 =?us-ascii?Q?uorh1NZYAUbZgHfHQ/PfojbAudpyCMNm4WEkEVFDbX/qhoqLoVcopluVCA1C?=
 =?us-ascii?Q?F7PhZIR0L1Jsl1TOkqMXsZAf6vI4HZKQuQ7l2g2Wv/K2oWUe/eVgyA6NWroS?=
 =?us-ascii?Q?fH6+pQ4Df9dZQ7zlCTCemIt73a5JQ/KMAdA92K/02jdzz/qi6EwPEwIsTm5s?=
 =?us-ascii?Q?uPgGUMwmD1deF0umG059zM5m0WnQyovbuqjxFV5yh3qOVgK5FpRlwITNJ6j0?=
 =?us-ascii?Q?xI190W07w8w+aadouR+Kzo1JZnva1Gd11Zud9nJ+o3tiZaTegD32BN5TpBdW?=
 =?us-ascii?Q?sJ2H5HFuXiTVX7LsLIeeGMEynz++D+KlIWD7pS2jVxeZR5HtyKOLtCF/Simk?=
 =?us-ascii?Q?fY9CkWYVwy5P9TizDCrtkuv3SgSR2zB/z2Nx1dyT9auTfF2iJ2WKdb/fbJbT?=
 =?us-ascii?Q?1NOFRHtAobLgvIBUXcnWnublzyls5S8FVKIY4mj1xOHZ5bZ/yN1d4jPjBKI+?=
 =?us-ascii?Q?yv9xWX8TkVv4MV0FFtVlAtLOp265i04ye1u1SpPlRmb/tCMGXwbBVX0uT5oA?=
 =?us-ascii?Q?LZU0eIdW+U7bzCEqn7FjunqtUhVyNIHqg0t7EMpERck2uKouvcLmzs+2+vZk?=
 =?us-ascii?Q?iX9Eb2JEbXmJCZn0kkp+vqkcbj6ztbcQ1+sNps8qHGNQeQLi1Kp2rpNeDgdr?=
 =?us-ascii?Q?R38MJGd2VazeADilGsUXXxNH2YPFnUH3zbxIpkWo7W8dfIFvp9p3eZhc6mgl?=
 =?us-ascii?Q?2Sw4X/lJanyWebu77T1/N+gcAAXxC0LneqaB6JUawvuCUecIGi8OT6LUu+1w?=
 =?us-ascii?Q?CDLlTs0svGpyIILpbrzHJ11JsMJNI78Ql7covK391hKXTAJfdBOmbOv0ZLvs?=
 =?us-ascii?Q?vLNCeINAXBnCx1tsjkw4NNfLNeiOQ6rwGT1VBPCxJFGXnWtE2hZVmYnjIPm+?=
 =?us-ascii?Q?XIYCofz0KSbxUboPKnApsb61FW61F6H5JU8UKaqWBKCNT3WQWR1ruz5+L25r?=
 =?us-ascii?Q?v3KW/o+h7XTd4iUQvxk1sL3VtCgFaLOhxju3eefAqe1LDQiVP+xr0GtFiWZu?=
 =?us-ascii?Q?Nn6Nj4m9GiZeQUrf3Ha8ETnPQu6L2dF8RMUqXqrdx8B+sZV2q7fFNrfkkOI2?=
 =?us-ascii?Q?xzOE0Af0HYZE0VTCSy1QfSi6udOoOG5JrjuIFDZWbnF+Nc5nuZA6DqDU80Dx?=
 =?us-ascii?Q?uTBKiErEVo212pJ78HXc5KkY6t3axShclAqoIPxgfA6ub1YLeR0kze3BPT5A?=
 =?us-ascii?Q?kJFL0oO00/I253B/esnkD9Oye9/EJQRi/ApOjS1LsnEgFTKw6nAA0K5sKBeE?=
 =?us-ascii?Q?dSZq0Igf0ztw4z7nJnM2IoINe2EyXIPye03veoiJ7mxPhAFue+LidNc4QWaR?=
 =?us-ascii?Q?RlcSFFDVF7b1zDGOdh8+IK6Z8zVYrB1ShgFCjAfhmUBaeGhtAfJZbSO61RdV?=
 =?us-ascii?Q?H8pOyeY2Di7S+X5cygCmSK8cM5nSEaDiSlPLoOQw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1269bee-de2e-44bb-287b-08dcc81dc84c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 11:29:02.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLBJNSi3zfVen51/YdbooggxAS0rN1DkVT0PxDwleJxdYvUS5vfXrE/f8knNlnPG8zwrsdmduvK9+4J0iAsIcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5318

Use ERR_CAST() as it is designed for casting an error pointer to
another type.

This macro utilizes the __force and __must_check modifiers, which instruct
the compiler to verify for errors at the locations where it is employed.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 815f6b3c79fc..3ea2824f8a68 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -836,7 +836,7 @@ struct wireless_dev *brcmf_apsta_add_vif(struct wiphy *wiphy, const char *name,
 
 	vif = brcmf_alloc_vif(cfg, type);
 	if (IS_ERR(vif))
-		return (struct wireless_dev *)vif;
+		return ERR_CAST(vif);
 
 	brcmf_cfg80211_arm_vif_event(cfg, vif);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 6e0c90f4718b..2e627f428f5f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -2164,7 +2164,7 @@ static struct wireless_dev *brcmf_p2p_create_p2pdev(struct brcmf_p2p_info *p2p,
 	p2p_vif = brcmf_alloc_vif(p2p->cfg, NL80211_IFTYPE_P2P_DEVICE);
 	if (IS_ERR(p2p_vif)) {
 		bphy_err(drvr, "could not create discovery vif\n");
-		return (struct wireless_dev *)p2p_vif;
+		return ERR_CAST(p2p_vif);
 	}
 
 	pri_ifp = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif->ifp;
-- 
2.34.1


