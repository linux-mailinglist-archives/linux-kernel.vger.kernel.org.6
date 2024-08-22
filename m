Return-Path: <linux-kernel+bounces-296732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 568D695AE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AE32850C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF0016DC0E;
	Thu, 22 Aug 2024 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="M1RMuZZs"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2083.outbound.protection.outlook.com [40.107.117.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14D1684AE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309893; cv=fail; b=DeyFwlZUs6KpI62I1ap+qqptYUIBAjrlqzx5RiFl3CQcLAr4kpS6GGGS3H9C3A+V7D+QAaoBveqU2Fbi1Ie8ee57FuT0qLMUqSYX1R0gzXXSZJXV/1g6ke5YHN4fvteEB7/PvMpHQIeoCIbFdqaGcGb3A44bP/N44ZNxSD7O4So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309893; c=relaxed/simple;
	bh=mOTuuGp9NHdZaTyR+VhF9fYrPddCTPd2FRfu8AvMd94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dR8gMYrm6B7apjAv0vu0MteLFkyWs6hiUjzKDw/CmaFfnlFbCHDMbw7vMDSWG7WTF3BfjFW83QBucbRG+wct5yl1EngAKXbIohbNOE3AMwlnj6J8+nUH/5H5jYVnt2wJJjEZEzbrGMm0rx4Rly54OdecSs5AUOX1EXPduzfiqZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=M1RMuZZs; arc=fail smtp.client-ip=40.107.117.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjZjhjR88VC/q7HrLKEc9OSgNGWLZ10zf1Vgjorxqiiqq+N+WRyWofCxSBp7egU0/crnOUwLcbGC0PPz2iXTD5LvdDBZA6nLBMmbCazWz0OjWEphdKJLGnq7b3WGpgUDAuPr+uGACd+BHuY47scz8nn2wXhTTbJ9s8t+tGCoGG32NmUrWvq4mwdmRtUc/JiXnaw/LeUm8PHPZt8SafgQXqz9/Uf/7VAyKbl5wSQ2oR6fsgnKjWXBX090rtlN0ZrspTfDqO6vk94ezO/PnHjhp4JnpPHqqMmZCDtbwyPIyHyMEQMIbfmRWdgLT9m1jz9Sky1Khb2UonRGM5RIOEQsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTsu0wrvbdIEE6vA3MQgBXlaN79AI4+N6lS1tqsz9ss=;
 b=eUfaKqImEAQyW171bhjaQ3XZS/VTewctBra6VSY78tqJMWRooeK8UP4R0mINSkyTVL7fQ7RAU7pVyG8OC0Tko4PnWmZ/MWAxpJjdgLcIABEr173cM/s4KIKRf5JhFbE69JxlD6t3B0igs7irjD2VhlwZj4MSgyQ6Zbal7m7G/GZEk3XTisbGQ1HSnxtCc4DHUmCu6oPEEopIBv3VSFF/Mep7TH3po0wLMhjLLim565YYMw4ka7dTE8CjCo9HPsC7NHX4JlVw+qiiZ9BmguPv3DB3Y6tMlHaeP0NrM4TM4n/b7rwiPdkFUjdFEneogil8NVcOFnsDRg+O8u6A6UhRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTsu0wrvbdIEE6vA3MQgBXlaN79AI4+N6lS1tqsz9ss=;
 b=M1RMuZZs05ZAGfM/evNuF3mFCjZvLbVbh3Vpgto3T3XDUrwlko8aOFm47/dXD/eak22SBLCmFgENgC06Pvl6KFTguwdZKj36CV/DIXfADd1Ou/ChHn14fXoI9rG1MyihuX3tmAN09r38b346gWrxzi4e2w80u4NdCki2pADmf+p3EHwzOwulHGcLW/5rS0F5SYyVkxSoI173NnsDxZpa27Szjop6pCQZ+xfp7WxcbfVGHULWdLR9eR5rQ1f4UXyAXn91E2lgOazMqhKHQvjHWNbLgWy+/tIxkyZjewrox67V8/SUzz97aglmZ1yHbY7q+jUpma6csE+ag5h3HVYmMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 06:58:09 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 06:58:09 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1 4/6] drm/amd/display: Use max/min macro
Date: Thu, 22 Aug 2024 14:57:21 +0800
Message-Id: <20240822065723.1336181-5-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822065723.1336181-1-yujiaoliang@vivo.com>
References: <20240822065723.1336181-1-yujiaoliang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|PUZPR06MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d45a7d-1d94-4538-5a5c-08dcc277c826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qt5qY8xaYneybMEkK5+XF17QlP3ctUHZ00AwIHam+emz56q8jDwKEF2js6DI?=
 =?us-ascii?Q?2K4jkWhtFZu1YFoVujF7nUWBZDXV1M+p/PcPk94ZbwYg6Ay792rAfVeSNsNZ?=
 =?us-ascii?Q?yxIsRfGIYWNNXbbfZdvtrTH/84kfHJUDGJ4+pqHAAs2cJpSca/qoXpQ07BaF?=
 =?us-ascii?Q?ZArPC2a32lcmvaNafOlyXLlMcQruiTp0blGM/aXjdmVFNiPI4K/mi1FNLAIO?=
 =?us-ascii?Q?G6ErGUqWFPIIyaGwR8PewwMDpJKGJ7RVDqHxRGz8rNMZ7wmoYMQ8U2vtYiDt?=
 =?us-ascii?Q?uJncPbyFKFRPD5Fi324OMQO3pxAie77O1jT0Zacu1UrScBTHNiNXMMz8RM7h?=
 =?us-ascii?Q?a55t6CC1LFXtxdv4LHVHqWJksIVkd4I5lzL6owmhDRXRlfVBbB4F0xstoSJQ?=
 =?us-ascii?Q?+/6oVkwCylCqeqt/0tDezPZcOiZQmf+eycLgwTqF+wWM1ALnlB5daOBZmk46?=
 =?us-ascii?Q?JMqe/lWXI0SdIy6qGRRUutg8gH+HrB7S/hoskY3bOMrgYQI9Z8qeOk/7OoI2?=
 =?us-ascii?Q?aJGFrFnFP1R0ByoKxG/4cLGyshETGQlvE2Axv80Fy4uOy8kfJghdiIhjOW+P?=
 =?us-ascii?Q?egAlcmsTGqwIY9v5E3LKWu2A2cCVZtzzOU//uX6UMb+LY9heKbVj4aKhS4Cx?=
 =?us-ascii?Q?Kw4/9bsPv48Myv1EKkloeWsu8hNXT63xC5aY+8FN2NluwVSylPhKNTV7sDDV?=
 =?us-ascii?Q?mL1Vv4a9hJ0+uKL8pMJ4Ffnpr/+SzHyH2RxdscoCYT1dMh52yTZWxSQo9XSF?=
 =?us-ascii?Q?ygsjr8srTQtAzYaLstjgFp82Kn3yGueEWeXAKDkX18n86GgB74h45A1QeXRm?=
 =?us-ascii?Q?lKcAHbofiAuIpUB7knocNdpTEHmCesNl2ld5xsJIhfVLPOGvIYlb+zZGiV2T?=
 =?us-ascii?Q?PUY8NnTemwn4L5GhsZlLGLMFRfbaVSpRGbZ3L2aBMqDoYnleIVMMdAhHkJiq?=
 =?us-ascii?Q?3ktcClxgW/uKYVx44TpygVOzDd6U+hWg8qNCzrRYZvbEPQhL618dTGRmrl06?=
 =?us-ascii?Q?jYarScRFS7/geA9QqEBfn+5ElM4Al+3Z/pf4+DxXydOiY74oroK5yZ5G132E?=
 =?us-ascii?Q?Eirk7raEHmb01gN6tD4eqfnEA01I0GqUUVb4I+j6BZNi2ciMr1rbgLwNtS7U?=
 =?us-ascii?Q?viLqL5f+I//MxDqQFNhQj54o8Yp8eqfwduKj0cH/Vi1fsHq0myORj3/lkuOQ?=
 =?us-ascii?Q?Kjznt7fXrQfbc6am1LdTYVOOddw0m25fqi0zI1X2M++ReoggKklSNO7amMd4?=
 =?us-ascii?Q?eDyBsCSOE01PX/DwCpznpOGEI7YPnYQzOv2x7E9Y8+ebXVfsQiarfdRCopnN?=
 =?us-ascii?Q?iznEelwEnybYIYbQVqkwuUBx6IQq6LJUNrp64uypPJBCNCC8wtNuYVnIlpCM?=
 =?us-ascii?Q?TNQKLNlAjKbkv00pzKw3b41vY5zei2uqypkauKTqQNzYkkipOw2v7CMj0sw4?=
 =?us-ascii?Q?xEhDBi0BOcE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f2IibXv9BAz1y7K8MmJfRtiPuPn4WkN2D8cdpSuhYrRFru9JBPgqWQRdxRZQ?=
 =?us-ascii?Q?cwW0tnGU2bzRG1Vh+TihJ3naih4wsSXmuIPtPYd6UggXf1dPiCf9nKOwHh3R?=
 =?us-ascii?Q?+FuuDpb5qgc0LokPxK7VohkBanekRAwAFZVFb49TwWzFix/8dx48OfiE+xmV?=
 =?us-ascii?Q?PuHaBnqbhM2+BAO9HNx9VIKDpPgOK5iNmk97fGxAUNwATzc8fKf3F024YJA1?=
 =?us-ascii?Q?GGNrg9k1sa5BLbFu0V9Pbwl8VeAlr0F/sp2cdCK+hI3766ny6+fkEobjn5VU?=
 =?us-ascii?Q?BKvWQ4LUK0yBGFCA5IJjzmzm5tPRuH+6K6s49SEx8Qkd/o55dzpux6dQxRHJ?=
 =?us-ascii?Q?c0TqrkQXQPoHBbfbQVDQFSG2YYMA3FyWxnIp20b0hwmDcBuQZjci6/OeE1a1?=
 =?us-ascii?Q?pELasuTCjiLgWoUG19CoLtIQJ74P/rhcQBm9mNsOMdc6rKf4XvWEnQ2eS9OV?=
 =?us-ascii?Q?1DZMRpnh76Jsl4GSHIaIgbDQsA2IAiTgyU6iXtvAVOrJjvoTWppnJugq31LK?=
 =?us-ascii?Q?x6rFOEeQl8b2s5wclXMWrP+rnfhGW6SN3+VBtzutvaQTxJecgaFNaXOReZnv?=
 =?us-ascii?Q?D/YH/mRvgFU2ZR4BRb9Mkq7Omx00dtRqKm/5wd3rwGCPGAHLrzIcdvT6ea3X?=
 =?us-ascii?Q?Zk1VnmhUo4Gp1gwX2X2a7BdiTZBgNkwzebdvwrviADdVy4FjCyYpOFJC2NUY?=
 =?us-ascii?Q?fAWWIXwK/utNl41WmDEK/KkYSTyO93UXRfr7jaBHfR4Ca8RwUQY8Ab0L66AL?=
 =?us-ascii?Q?EW0TBpvcwW21g5OM2+YgUOBa6Y+z+FeY+F8RruJs5TAVd6hgttORg/lpI+sU?=
 =?us-ascii?Q?Of64oVQL7HUKqMpuEg6QHrIyJm6wFBXDBYlVPbqQhc7HdgfJ9ole53Hdc8CH?=
 =?us-ascii?Q?F/4/fRNwuT3OjsU1O3eT5jG504wGyNcSw+IH3tYalltweeM8dMKd6iuMdpTh?=
 =?us-ascii?Q?k+NLEjj5rlr3VQusn7kjXNF/QrS1Efs1EhG0VF7Yl8U1isLx/tnVEig6IK5J?=
 =?us-ascii?Q?CNBhvrSAL/erznzgJqs1nkdbnaXnfuwNUwS+4K3RKaib7Gio2xn9FOiG8d/M?=
 =?us-ascii?Q?ldHsq/sxCH/j9hRxKLSdhNIdovkT6Es99iKMtbzpNT8ElR9vkGqQoW6D+yWW?=
 =?us-ascii?Q?iCJsj2L015qzaBwWgizoN8PA00QwXRJINffQAqqHLkgpfqrsHncJ0qBNjWxg?=
 =?us-ascii?Q?zmL0Fk7SS9sCuinLcjFpHRZDXjEbrRgohKyMK64ubcYR3UhSL9eI51jTfggf?=
 =?us-ascii?Q?1gN1VUYHUndcHfGokNFrGKzZfxnBHANTh0vc/ljWMkb5xLc3VZluJFZxcY/M?=
 =?us-ascii?Q?zpQfs1rz3tJ77nJZAbwgI5gsQv8462qMfPZ6TesT7xw2fQUUDIHFWWVY3YMq?=
 =?us-ascii?Q?r2qrSutfqT0zrhxwXCkGEFZigbwuA7+tPZU5pgSJsl5VEmWQVMgGpdgZ+OHz?=
 =?us-ascii?Q?mQQ67MAv3IPuDXwxnZR4THNaH10c6QpoiEk7d+nk7axAXsKqPFblLsj0rFby?=
 =?us-ascii?Q?AxpQwFkarFCOBB7aHDNcwOht7aIqnpBVwL2DYsp0SH8aA4V3Zp4fkMDEG95J?=
 =?us-ascii?Q?nkoEz65jGjFJ/yt/fuL8ZL8t141BCmIEm1RIk9Go?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d45a7d-1d94-4538-5a5c-08dcc277c826
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:58:09.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlAzvivbHKgws98IlpL9hhHrHa5MnkYyyZ4R8SlPrOtTYLNdz0kvTxH0ovDcbEayBHnhm4iRKqfX1Mt+U/V0xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982

Use the macro instead of ternary operator.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index b1265124608b..f48f8cf1e232 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -606,7 +606,7 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 	max_drr_vblank_us = div64_u64((subvp_active_us - prefetch_us -
 			dc->caps.subvp_fw_processing_delay_us - drr_active_us), 2) + drr_active_us;
 	max_drr_mallregion_us = subvp_active_us - prefetch_us - mall_region_us - dc->caps.subvp_fw_processing_delay_us;
-	max_drr_supported_us = max_drr_vblank_us > max_drr_mallregion_us ? max_drr_vblank_us : max_drr_mallregion_us;
+	max_drr_supported_us = max(max_drr_vblank_us, max_drr_mallregion_us);
 	max_vtotal_supported = div64_u64(((uint64_t)drr_timing->pix_clk_100hz * 100 * max_drr_supported_us),
 			(((uint64_t)drr_timing->h_total * 1000000)));
 
-- 
2.34.1


