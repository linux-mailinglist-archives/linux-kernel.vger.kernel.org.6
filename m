Return-Path: <linux-kernel+bounces-327499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D083E9776CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21529B2211F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A705130A7D;
	Fri, 13 Sep 2024 02:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="q9b5Me0C"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2048.outbound.protection.outlook.com [40.107.215.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41D2B2CC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726193825; cv=fail; b=OpLvSJUeRT7s3a35SR6+OLbDXjKqOgs4YpqwCvobuCS7IuT0ez7Z7ZVquPQ1wjZDyHXq8PWf9vh1Im7xXChI8QCou1ERjzYLQ/4beg8wSClrN8tYB6YNw7IN29YuMLHdVPIf6h3OscUui+2972yRXBhEshLNYSPOxyCCJxZPfKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726193825; c=relaxed/simple;
	bh=KmRj40VmXmUc2m9VWNn9VfQtk/gyErj3sHOf7I4mRq4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Os0/7ltP7Pe+R9m6rRqVkt1erBR77xojVMHnZeOzm0895YeXKkKwk/7i/hQx78wDNWeYgTrSSjNILHe8tRBU7iKMLKIXzHfWjDrKg3eb8T1bJMaz/UzJKaiie88qvzuOE85JA5tCE7/aTiOLTF7vk1ESz3vKGQlauKflwuv76vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=q9b5Me0C; arc=fail smtp.client-ip=40.107.215.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cS0wlmN4+uxRfH6YXvYRa5SnCGbldSkFdzg9IgGwi2t0oJb22lzgFgfLJ8q3+/A+Rre70blQm4atgsgT19UEFObHptLgUW+kmYaSi0Q3WcyNiagoybaiQ79Dx9hUzulRX3CeY2P0dtt7Rl6Xn6vYyTllptphTcd22tsjcTGmp9if2fI6EuapOct7UuJKMQZhI3aLaENQJ0hS5PEoaZA9fxJAV20p1kVfw9dVtzVZZaSjQudzgFMoT6q3PhKVPmVdRRDAN4ZJeI7Dz9GBGdwWQwmkLa8Nms0/WCwiaOIXYZquJRb9FIcUvJ1fT44oFeuAhFSUl8BglXelDmqxxtiAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGHGNL5QOk6EosCBZJ1aWZK6C3JswRimNMFkIKSgOPo=;
 b=rqa+2VxhpZZfGp4oNOTT5pI8p29uiQj/7/3MaOsSo7ydhHG1QYcKYAPZTPHOpGcFczwUGj568TP5J6YLC8ywx5wRFS5dQNU9LKdzyTCYySut18nGdGpuV6nt7s+jvZ+NO2qE1xNPihKYdPphrPtC0goIRcDYtIVt78MLHkbuE8kV1w/cA89B6Y5UkmDd6yE7Sn1GAV1i6G1mGNSuEOxPsT28LpjzpFrvWahvv5t+7jMVtSREi+pDYZnld+cn4opzzPSB1PAbX5srk4LscBGYAGWBn4UxCQx0ct6AunzH0GCgqNSCwgeqJLKMHctnLWwAcPqD5rT15CNJ+LctbvoD3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGHGNL5QOk6EosCBZJ1aWZK6C3JswRimNMFkIKSgOPo=;
 b=q9b5Me0CgWmGeNmrsewMWexAqQMNzNzBLYX9BUlKQJede6FsLCg9WJBtxgEeMuKapcoh95HzVAndXAJsRERAsz+CrCGiRN2OmVuw+CrZmQqEBvYJ0iso8XrdjuIoI1LbHEw8EdnIRmVJzWa4TAcI/ELxntaiQjnjxjbqxhU23ytFwWRo3pXsWXrI7XVZme/8WQwyZxyehmnB9cG/FSdDqnvi7QcQStRoOIHstkBvTLbmaCJXtU0Rf00HBbOsOyt1eEX1nzDnkX14rRkDvubOefBiuYNx8ZfAcF8aAtNFMj6z4lM5z/Cxk82dP3f5VN4JqcDIDJ/nrzwHRYCuRKioAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SEYPR06MB5766.apcprd06.prod.outlook.com (2603:1096:101:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Fri, 13 Sep
 2024 02:16:56 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 02:16:55 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: zhenyuw@linux.intel.com,
	zhi.wang.linux@gmail.com,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] drm/i915/gvt: Correct multiple typos in comments
Date: Fri, 13 Sep 2024 10:16:12 +0800
Message-Id: <20240913021612.41948-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SEYPR06MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 621d5e6b-8533-41ea-5daf-08dcd39a2369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m/+88NLnZjT95v377jOW98qvC5qCBXs27kIWMPwJNV+QIFu8bZ5bN7K5SAT/?=
 =?us-ascii?Q?Ubfu/8KG/YpvkKbYbg15fleLcwp34ZT04+E2qIHyPwUxsDS7c4Cc709z0bLA?=
 =?us-ascii?Q?OzjWj5JBBt8OeQGtQw5CmGUuhv817ycZCfHd5fBDDP2llXGqoPdSjieaJ8vW?=
 =?us-ascii?Q?gp67x1kNbdJbkl1eOZ7O0lhKpc6uGg0V1xBW0AVkUN4EPEFXwMyp14mMhUN0?=
 =?us-ascii?Q?1sg+m3pH12Xj4I18quC/HaK50Uw9w7MFgGwcZEn6OoapVD+vBoRptiIfFFyR?=
 =?us-ascii?Q?mvjuBgsEpkeVDy4mBiKe76BmrsxV4h12J/MLCsubu0ATK+hcwTQ9GmHbcFH1?=
 =?us-ascii?Q?EeGeg81neGV3SVdDv9/hTFK0/PPs835HdmIHp0+n70UQLfL4i2nQlxoGkx8A?=
 =?us-ascii?Q?IQuZzo6Pe6blkIuIsXMlD2nw880PPlYcpIn8GNEFdpSup9+OWaBw3i3rcVTi?=
 =?us-ascii?Q?2M0BB7177QjwQ82e44gnACtcUEN6X+UOEft3yT6iRLw72wtvRTMp6JPgOsWp?=
 =?us-ascii?Q?zRoz3wxJfSr5PSi/p2KsBIN3EOyswvHH7latdGiFv2CL569mFky0EUNDe7k5?=
 =?us-ascii?Q?QpdFsu9j0l92Wt4Grz+B5uotcFTaDsj2qlStepe8TEDCMLVzhL0LE2dupeYe?=
 =?us-ascii?Q?1D8t8+iF3o6ihbwmXkbnPUQCYy1ErQUpAtZwnBYId0YtsEuBPu39bA0ywmGv?=
 =?us-ascii?Q?P30GlVaRVuTK0Xothe7eB1pNtBL/PDBmUc2wMjNR5CbyYnriOI1Pbo1hHJcw?=
 =?us-ascii?Q?5UtUL0eghJcsagrSA5oaa+iqfGBDMPHPNdEolpjqd2iIt9QsCijzFcPmE5DL?=
 =?us-ascii?Q?N5wStce2gPHty1s04EALweNU5CscSiXQ/tMmCc4gfMQy3BmVvU0Ip1JyCAcp?=
 =?us-ascii?Q?CcEGOnWGrufQsYk1BhLapik9liNyZY2H2wdaw/l62oVbO3F2srLEUAOSdbKK?=
 =?us-ascii?Q?yWhmqnHUHV3llEYaq+1pH8rUEDFiTgjwUf2l4H9D6hsvHHcE8iDI5OZ25A5o?=
 =?us-ascii?Q?Xvk3O++U9QOHDQ8+FMT9XGZ61uxaJbT/vyK5zDklpyiQEFUnvP4oMuNIjIrm?=
 =?us-ascii?Q?5H8XI6pW6EwIUb5TUEolvC9k0gsr3ENSnGS4UvWU/+zdGujnDwgveC3lJeZf?=
 =?us-ascii?Q?/wxdgPrBnuyxbgcasv9XsRxqFUQdsRu0U2jMJ4I4gUuTAE2MQmu+UupLgyKz?=
 =?us-ascii?Q?neGsjqz+62uGkoGoLYVc+mwJA5zNCWuuJN2b+DuCi57iNlV3dp3Lkh9WqAwq?=
 =?us-ascii?Q?ZFzXTdwAhHn2Dps+sAe9tO3u7fa4oXGHDxnVuTTlyKA8zkBmd9C5/1YUtMG2?=
 =?us-ascii?Q?yjk7FPx+8NYR46XCwYOFkYrNo44Gaq6u/Pxc+z8+HkJjz7E27PU2gUGLG4Tc?=
 =?us-ascii?Q?aHNvY2RR7lf/otrDwV22twBkQKNM4m5tNUNMWFGk76DnqTQUsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b1h14OOp9lgjfWD/FYfWMmRqQHwgUFEFFW2rAnPp4ZUvOdX4t7DNczplflxX?=
 =?us-ascii?Q?COif9RaRimMpeL36tTNIKnTVFtcDZr3zh2HWQCA/0ysjyXnbbBjLeJy3jE00?=
 =?us-ascii?Q?wn2yR5dQIeEzm050jYqUW5GuXliUbsUiOYmkmGBln9k9LTNdlb1eLpmuqe4Z?=
 =?us-ascii?Q?MNtcT93IwMzjpuciwblHv9Bg7KNDCrkTNh7Hbo/NDmMWxdSFMwYl3aWJGc2D?=
 =?us-ascii?Q?jEXOf44gO1S9jfNwc3dGmMkbHdv3ix7AuUS/3/HY8a92ST0FLKFNk9KjilOT?=
 =?us-ascii?Q?HFDJsPDiFVqQWjNLit4EmmvAjaiVulFkzPJHNR7LDcG/N8S0hqTfDSxDZrbl?=
 =?us-ascii?Q?vnUeCAQhdFoSwA5kFP5ZTByLwcyAFNfNnQQyKLGDr0m8RCQn0xoIUkrrPaDj?=
 =?us-ascii?Q?E279E9wbGmIS/hz+G1rRInh2iptHRZ4TexEF8Vf21/yyOETxQzZnd+Wsr/lv?=
 =?us-ascii?Q?84DhzpPxxGMMm1jpHjlNv5yFHjOewUCmE67u/85oHlN68LpTKin0VN91Jkq0?=
 =?us-ascii?Q?as7a+N1AKIyXzrivmvIRQaU0iZ3nlGM9WoT+fVSm2jSoFnu8+ICp9WStFT/H?=
 =?us-ascii?Q?5jrkrwDHtXWuWHQH1XI1jLK7DmpdotvoU7Yhzb+20nRv8poNiukmgSnruVtZ?=
 =?us-ascii?Q?c2vI8J6EDD184twp8fMAktK1VV0unZkAn+8rOPlf8DEqcENQ0tMFfvB/G5fr?=
 =?us-ascii?Q?ljGUqSl6zENlPSD0vPVxreNjBeOPGhVWH09qarU8w4GboCTYiqU+pgmCAKGM?=
 =?us-ascii?Q?jBik0BcJvrWWisLZctA4mK74dK6+B3uI2gs3S0IKjNxKMyByxT4U4dl6SNFW?=
 =?us-ascii?Q?0XJFpnew+bqzYJgyDWIft0VVhrGJZwOh23fgh3i+oJIlvD75o32S59LVkeWv?=
 =?us-ascii?Q?UnrD2ma7BQR7hvG4T57JY2NOidl02XDWC7TMaBiK9a+9tr2DjNjqVggCF4z3?=
 =?us-ascii?Q?X9s3LiQkGwM49x/K2HBfnM1G2B73YeWgTsaeBpGlPziMH2+gtbKjfNm88hc3?=
 =?us-ascii?Q?Ed3f6a/lg/FsFp+dhqSsu+2trm7nXTmTHbM4+ChaAxCVQL5j0DxCQiT1AXUi?=
 =?us-ascii?Q?VJ5FXek2zDLLDjhFfm0uMOTnPlhRVxvvsKJr8qnH7WHeajjDjJYOEtzwJ2BT?=
 =?us-ascii?Q?6v4hTAWctF/mOnHG44qYJloIcbD4tP2ZJEensKNa8y9pt4rHd70z4NsoENUo?=
 =?us-ascii?Q?80CYUEmMrSMOgUSU89geOSQ68MoomE/MoE7AzXP5aXpsVSSx0BIct0dOQI7t?=
 =?us-ascii?Q?OVylAnY5QROk4EENjUJlJir8eLvxYsMdCpBuuY/k+L9zIqLPcTwIa3nkfWaY?=
 =?us-ascii?Q?GeAL2fBDyeZQvrcVrwFsHZ9wN4AWdink/ELrKD17gqj870x3PmQjlUcwPpFY?=
 =?us-ascii?Q?xOWpb8jQLRk0tr38tkA2rqu7RqBDef+F3PyvGd6Ovc2kN9OivZZPZSyQiIA7?=
 =?us-ascii?Q?9WT3ZZcRvR1+gEuJuLitR6YVu/E01H+LsmfaG/7p5pGMyJmzFr4oP2WKj+RB?=
 =?us-ascii?Q?MpL1k5yiEDVnIisYgf9W962puC8qrV/zQQ1e+ZQINfI+hMjFztfnumguTxgi?=
 =?us-ascii?Q?IheXuamOu9Wq2beHZNNLA3Ba1+s5HhodJ1suKGVG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621d5e6b-8533-41ea-5daf-08dcd39a2369
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 02:16:55.4168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGiysnfGBMQDIxPEOPeaelYoI9mJojZ9J6T8bSY+XHPTvEr4+04uyMr/rTFPdjjxPDHjsDyOOrFkj4kY9kMGuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5766

Fixed some spelling errors, the details are as follows:

-in the code comments:
	addess->address
	trasitions->transitions
	furture->future
	unsubmited->unsubmitted

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c        | 2 +-
 drivers/gpu/drm/i915/gvt/opregion.c   | 2 +-
 drivers/gpu/drm/i915/gvt/page_track.c | 2 +-
 drivers/gpu/drm/i915/gvt/scheduler.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 58cca4906f41..1bce1493b86f 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1190,7 +1190,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
 	ppgtt_set_shadow_entry(spt, se, index);
 	return 0;
 err:
-	/* Cancel the existing addess mappings of DMA addr. */
+	/* Cancel the existing address mappings of DMA addr. */
 	for_each_present_shadow_entry(sub_spt, &sub_se, sub_index) {
 		gvt_vdbg_mm("invalidate 4K entry\n");
 		ppgtt_invalidate_pte(sub_spt, &sub_se);
diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index 908f910420c2..509f9ccae3a9 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -439,7 +439,7 @@ int intel_vgpu_emulate_opregion_request(struct intel_vgpu *vgpu, u32 swsci)
 		gvt_vgpu_err("requesting SMI service\n");
 		return 0;
 	}
-	/* ignore non 0->1 trasitions */
+	/* ignore non 0->1 transitions */
 	if ((vgpu_cfg_space(vgpu)[INTEL_GVT_PCI_SWSCI]
 				& SWSCI_SCI_TRIGGER) ||
 			!(swsci & SWSCI_SCI_TRIGGER)) {
diff --git a/drivers/gpu/drm/i915/gvt/page_track.c b/drivers/gpu/drm/i915/gvt/page_track.c
index 60a65435556d..20c3cd807488 100644
--- a/drivers/gpu/drm/i915/gvt/page_track.c
+++ b/drivers/gpu/drm/i915/gvt/page_track.c
@@ -167,7 +167,7 @@ int intel_vgpu_page_track_handler(struct intel_vgpu *vgpu, u64 gpa,
 		return -ENXIO;
 
 	if (unlikely(vgpu->failsafe)) {
-		/* Remove write protection to prevent furture traps. */
+		/* Remove write protection to prevent future traps. */
 		intel_gvt_page_track_remove(vgpu, gpa >> PAGE_SHIFT);
 	} else {
 		ret = page_track->handler(page_track, gpa, data, bytes);
diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
index a5c8005ec484..23f2cc397ec9 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -1052,7 +1052,7 @@ void intel_vgpu_clean_workloads(struct intel_vgpu *vgpu,
 	struct intel_vgpu_workload *pos, *n;
 	intel_engine_mask_t tmp;
 
-	/* free the unsubmited workloads in the queues. */
+	/* free the unsubmitted workloads in the queues. */
 	for_each_engine_masked(engine, vgpu->gvt->gt, engine_mask, tmp) {
 		list_for_each_entry_safe(pos, n,
 			&s->workload_q_head[engine->id], list) {
-- 
2.17.1


