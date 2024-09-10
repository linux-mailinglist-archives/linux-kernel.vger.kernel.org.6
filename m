Return-Path: <linux-kernel+bounces-322331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467FC972767
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A90B2332A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 03:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689E114A0BD;
	Tue, 10 Sep 2024 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="nBYQ6Y+t"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2136.outbound.protection.outlook.com [40.107.215.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931234A0C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725937429; cv=fail; b=X6Ljpq07RlBrWJ+8A0E5vnb7OLYKZpQKOmfaSqo8XPvzxnWotsHQyFxxIwAEHrm8uMwYC5YyL+PgeBYfsUmMdPWp12xaYVccgoasaVPMpEWDc22zImBc8xKTQHsmLNmHs2ac3/ewIEeHJRi6l+WiO65+iV7k6PVWSv8mraoUeL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725937429; c=relaxed/simple;
	bh=gy1f6PrUt7jwCEgQ1n+t2BCtUma0tZbKKQpBjf7Ms+0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hQO24FE5hPZOClC1oSwqDgKLMINoJ4nuw7PLwt9sMVtebPOcFUbRlyb7y0kLGo9Fi23pYxWclGjdT5dTX7eLFKnQa3Rs6glT827ISyzDiHsVWCou46sGBhwv66Ll2BjBF6DqmubM9MZUS7hXieJNmv+hDQmUiUeS3/sxkELW9Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=nBYQ6Y+t; arc=fail smtp.client-ip=40.107.215.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGge2aWIvEK1PYG4ZM+gbHPOSuX5UCPIXghjc8LE+nslZzNjfHCOAodg/hNpH+YZW2Iv4XXCaxoOFSq0RQNchFPGwaHlxtYRjpfV+3tbQHlzkcABYIpBuY0c8FgnBpDIj0K5gAkSVRv1VQQW9a/72VLOczd/The4WlLtg6ik5pwkqLXTmmRg/6B/1ioqzk+KS9GwWIky93UzCekaO9kPxeFb0rIKVp8ALOGyUYU8sjKS8VdU4cBjGh3cCXe1W8W+o/ZdfmxZsugDtdf5rVJtuFwieBCkUGNhX6DJs3Gz4snmAy0/cs/iMq3jkB+SVMeLlA/MY7tPX3AR2x0FAzXJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgM71JnGkHC70z/LdFwokUjAUUHRqWaktuiNNCrw0us=;
 b=fe1gCGVylGB7Pf0O0EGyXTQsmBJOdf8eyG5Ag+95MOoo/IKw1+a/spEL3upKveBplfaTpkFDUbhDZeLEv9lFdVwM8ATdxfMI+YIRIo6RaAvdx15nyInddCPaupmUOSoJjoRrPGqWVdQPnnGMPVKDUftaC6AEwySoN9JMYH6TPWeF5dmu6d7ny9qytxzCwxdESXEBgGB/q8zKWvfvhyKcy65wSnspPrp33RAblv9m7ygD0Ktlvsz5pe1vjJ4FxYBxvzK95i6ptILpxuOg2z72bNPuQQMpnRxQIa9RlvRe+bZw4nCoBENbxEGbIDjR1Ls15bKOmro2o30JqoOrjl7tnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgM71JnGkHC70z/LdFwokUjAUUHRqWaktuiNNCrw0us=;
 b=nBYQ6Y+tSmE9QtHG1wcsMqEo9rr33jLoaOnZ+r6oqDot6RfNxspS9SO3vwfM7SPFIHD542dhVQ6HmH7YUYRVdqcEmB/s9fm/DNqNghfk8a8tqoY4FkmHJUW+0TXDsrwIw62P/KdWeDzX13MMe3v3lZ/tG/02oSGCryLv0crEdY2qV38NZamucuJ3ZMtuw/WsbhRo0dUlIiaNfBO3QqeXd7//KNsWfjQda0akzbgnz8PX3WP74p9+L8QGihd3AUq4SdD+pOwy07hrG7Dywcv1vq1Ph7lnU0HaWw5yuCKutN+mCicecDpZar3Zvs7DcPiuE8X0to3r/pL+5enZW6RD1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
 by SEZPR06MB5390.apcprd06.prod.outlook.com (2603:1096:101:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 03:03:36 +0000
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367]) by TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367%7]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 03:03:36 +0000
From: "Shawn.Shao" <shawn.shao@jaguarmicro.com>
To: jacob.e.keller@intel.com,
	linux-kernel@vger.kernel.org
Cc: Shawn Shao <shawn.shao@jaguarmicro.com>
Subject: [PATCH] lib: PLDM supports parsing the `DeviceUpdateOptionFlags` parameter
Date: Tue, 10 Sep 2024 11:03:30 +0800
Message-Id: <20240910030330.1880-1-shawn.shao@jaguarmicro.com>
X-Mailer: git-send-email 2.37.2.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To TYZPR06MB3933.apcprd06.prod.outlook.com
 (2603:1096:400:29::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB3933:EE_|SEZPR06MB5390:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db41ea4-ecbd-43c2-89a1-08dcd145297a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nfDYajGZH1gYThtIyTl29y8ec73jTPsHDbrbpfSMOPr6xQvVCFiQZWZIYuX7?=
 =?us-ascii?Q?Dsh/y6PswSPxsS+ZHYvtCu9qN7cRXpMH65qUKtuei8TMKEB7VNuLy/JUIvYg?=
 =?us-ascii?Q?HtfNfGodcTMuALqJeG2NZoSJLHW796gtynowKzsDSvQ+wqUMhfWckWVExqTj?=
 =?us-ascii?Q?JfYkfmY58hJL86qOx5XE0CClj/e5qRi2BPNkAsbPkt+C1XhVZMZabPFQqozX?=
 =?us-ascii?Q?Reof6e2Sk6N0ZmVdwyvSjFeJlPgOu+ktpz3V6sFqc/6MFAODjRslCn9+Nkmi?=
 =?us-ascii?Q?8kViiZaX1rkW15Ara4tSxbVBBIvfsk96NwnP0GdwiDcfslomAJAg6Q/gaTF6?=
 =?us-ascii?Q?/LgUmMDuF0ryaiwfqRC99FnFSL+718XgtXnnjWzV1VqWZ2JYlnNLx85bGlbW?=
 =?us-ascii?Q?1fhoVEDPbWj7c1Czuc0vGvKAs+61j0Nixgi69M6EsBvsuT3pbf8DXJvAhuLD?=
 =?us-ascii?Q?HliDUuV/mvJh8y4I0UJrit07AyKpUAbx/6Ya554lVnTa2tJGnoWQg+W76ATa?=
 =?us-ascii?Q?Sdi4HD9GcxC7dPGrCfu54A2xbvluwOEGURN1j4gGGXFtpjizLOr3VHAvHgb8?=
 =?us-ascii?Q?sLU3bpyLuX/8VbF3JwGSWVu/6a22LCMsISvl4L2eblztXoRFgxtUgggcYmTW?=
 =?us-ascii?Q?lefk/Dwc3lOkVT3mS96QBJHLv0gchHxOYVv1O2E6Efkkr5UknUZ88XewVnbo?=
 =?us-ascii?Q?e7l4EBg/1fBCzW8Rh0tB56DO6nAUWDJWpUIk2uZdo2YM7LtUFUCW1hKUxvhX?=
 =?us-ascii?Q?/418XULvolrPe9CwNP6+zikwTB47hT0exyRxWPPt9z6xoFn07GFFkspsprnB?=
 =?us-ascii?Q?O7g7c8Tl3ZJakrhNXiEbmAr3DEUzjhzG1xSMu2zc++v9vJS/GSsu/5w+kflt?=
 =?us-ascii?Q?c+u3uEBg+7fVIMR0Lb3W9dRAPwJ2mSyPtq1d0FKd4t8GenFyS471Sxf5mvg1?=
 =?us-ascii?Q?hYcTZNAf1WdWnORNDfhf5OFYX0KgI+MdoqYQQ1O7Y+VgqF4vWfftj7f0olni?=
 =?us-ascii?Q?wWwNBmNja3I+ptnBajFKYcEFKwC4oYN4GmHM+PiX/09KOeUBRszbA9fqhRh/?=
 =?us-ascii?Q?t58p9+R4tTAHyaNRV/Di3mALuedcMJYfFy0KhSwxxNgEdYNIi52TpV0LJB4G?=
 =?us-ascii?Q?2xrmVrTzL+FjKWIhDepeLL9wGuGSY1nTDlRNXJDAilvgsxiGSq5+Q+DGV7VN?=
 =?us-ascii?Q?l/zbwrGhEU512GW58ClhZEkJycjelVPlsa6oNpg2RZBh8m+Wm9F/oJLCn0IB?=
 =?us-ascii?Q?bxL61Y9JHlCSDHCttbCb6BbOwrf736m4hw+BMxcU8AIcrLie8SekAMR2L9qd?=
 =?us-ascii?Q?U9TBefjyrSs+HDEbm1A+wZOtEIJRTsqOKWawLFzcLrdqb3JbXvo7EetcSrkd?=
 =?us-ascii?Q?WVi8O8NOMBibfxdJ4/Rep45i1KrEeyX5J8ASM3QsVKAtnCzIuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB3933.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cGKH9NXnrx9Mg8Ll4vqKoLOib7uObL19Qqie9jFRQ1G2So0W98tOW+bBClBA?=
 =?us-ascii?Q?Vk/8r4x1/Kh5qqkokNDF1lMeYKEx5pQsz66dmL1NE2cBUY40zxBPmSn+ente?=
 =?us-ascii?Q?RMSi2695beAOtT7l3XcENJuX5WMKu85rGoN97ujBN0V+UWyvPnntcoR1eBgH?=
 =?us-ascii?Q?XhhIAi9BGl+m/28Lp7Ze5xhTDNJc8Df0KT3Tf2e5QEpp/Oy1uZtMuDFppzKa?=
 =?us-ascii?Q?9gVUzGn94lQVCjuals3dj13hytKCr1OIyRFqqX3cA1D3d4RMhHDGS6Y8qPmH?=
 =?us-ascii?Q?TcrHzKL5OuEJ8f3ArHvcofvWO3ABlyuS/5s9OR2KkV5tFFbUb3JG3k9Vr3p3?=
 =?us-ascii?Q?ANzjs0KD1F6j+kupFPZdEEPRtolSVe/SGLoJCMGwsBsbfiE6K1MUvuYxmXa4?=
 =?us-ascii?Q?+Xz4xw2cDox1/AC2lv7J7v7qhfXkNwCy3PYwJJteyCrjHAHbx394DcTD20V9?=
 =?us-ascii?Q?3flO3YFZT1miX1siiLNzOhlPZSseuXoAwGXkT4VoTIMbwoLK5oG8bllUhh96?=
 =?us-ascii?Q?Bo1AH30f/pM4phvsOo67/7BwDHxFsggJk/LWICZoQTkiudsbUgp75o91FP5D?=
 =?us-ascii?Q?9N1h2qFKybeFkBLvqjTRv0xNnweFnlyk9DzI2Z/7PfnR4HlbeoUcichQ3dPh?=
 =?us-ascii?Q?Co17WdSQGnMdtnjJ3Ikfn4IRJJXMC1AMt3sI3n3Nw3CmrjaJt8bCeKoXq2p+?=
 =?us-ascii?Q?QKFA4NKsqV9vUiHxWRl3othC96dETpeBJySUtnUyNXp4vXD0GH+MItt6+v8R?=
 =?us-ascii?Q?9HN3R20EKkRdv+6SxRAYDdD5FQy8S69CdYITuFEZuVMEnojWfJ0SCq8vYDo9?=
 =?us-ascii?Q?9TbRSyRAMOR10/43/klbt7fGZJdrALpgTvwLse72TpkPVbBOuNlME6lCy/1N?=
 =?us-ascii?Q?QTJh3IPkImJlOuo4DzsUghksUKWSy6laqyAOSIBZWxoobQH0WkIq1HRg4nlj?=
 =?us-ascii?Q?/x9xL/uIqbctgiila0O78rL5VdwpYwzk7HMNZHzR9zkSeUNoATBLuHhovxsK?=
 =?us-ascii?Q?fg8w1xLVAtWuYRrTTFee1bEELW5OKMvZTw5MVihPA+4ZKdyU4W+RVS47xWPW?=
 =?us-ascii?Q?pKdkWElmaaaVBWzk//8JL2BSV0i1BNBYerC9zZkXd8u4EZbqmCdW1OwEEnJR?=
 =?us-ascii?Q?TnY6JYW3RrfMrDsRw5QItKHdTGb0c5hvtmcNXkY/GdylUdlr/oWna0T/73cl?=
 =?us-ascii?Q?PJ12OU+s+IKN9chx6yLYd4rImvSvc/hP2xG7aqD16HbGNZPd/dhYUqKtGS4h?=
 =?us-ascii?Q?iOJh1GgMNvvXFfu9OGFPmyPQ8fP2mJkt33tLTWDd2A66pcXVnWDxKM4R5KcF?=
 =?us-ascii?Q?dcEFnOlKFibeP9UnpBKLQGEuctUb2QywKtDaQc7AvQrI+7xlnuSxfO81yueB?=
 =?us-ascii?Q?XjTo6CWjhpJvEdtafOzYBhyYUehN6/sbDS0IIwElKZdlwKez0FJ0V4aF9Rtw?=
 =?us-ascii?Q?fOF6eELowZmi82qq8lWECWVd/f2jXpx1ENP2evofIhNnq++3dTAnAIFUVT5A?=
 =?us-ascii?Q?CNz23RIPsGJd/Ys5FSvGyzOeXpWxn93XVzJ93maywe5EEWR0p0TC7kxnRuKo?=
 =?us-ascii?Q?mKGcgWxzJ/gQ/i0TorAfuQ39MqN5PaiUGfCTxH2pduGR3WfuTb+PO4ekh2kJ?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db41ea4-ecbd-43c2-89a1-08dcd145297a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB3933.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:03:36.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7QRtNCDvg9oP4q7lQGC10YQRpprOIw5muEaVZORsDu5VwdBkt87vKtoZtk8RLqt7Asv8RutYx4dD8FYG8hN4V5jcB5es1RwwlIqSDSs6mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5390

From: Shawn Shao <shawn.shao@jaguarmicro.com>

The current PLDM library does not support parsing the
DeviceUpdateOptionFlags parameter, which is defined in
the PLDM specification to facilitate the transfer of
control information between the UA (Update Agent) and
the firmware.Please refer to:
https://www.dmtf.org/sites/default/files/standards/
documents/DSP0267_1.3.0.pdf P37.

Signed-off-by: Shawn Shao <shawn.shao@jaguarmicro.com>
---
 lib/pldmfw/pldmfw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
index 15ba5f76043f..cd1698e9c340 100644
--- a/lib/pldmfw/pldmfw.c
+++ b/lib/pldmfw/pldmfw.c
@@ -306,6 +306,7 @@ pldm_parse_one_record(struct pldmfw_priv *data,
 		return err;
 
 	record_len = get_unaligned_le16(&__record->record_len);
+	record->device_update_flags = get_unaligned_le32(&__record->device_update_flags);
 	record->package_data_len = get_unaligned_le16(&__record->package_data_len);
 	record->version_len = __record->version_len;
 	record->version_type = __record->version_type;
-- 
2.34.1


