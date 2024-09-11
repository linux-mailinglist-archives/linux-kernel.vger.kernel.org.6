Return-Path: <linux-kernel+bounces-324163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2681B9748CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABFD1C24BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6143144;
	Wed, 11 Sep 2024 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RQKkuXCI"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3865EEC8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026218; cv=fail; b=lL8uYmrIvRBfhV6GlP50OGb5RcRE6l2LCU4PPZw61qdhflvNSAJun/q9BjL9YxNzr2/BNwu0crPJRl5kKMiUKPHhbzNGoMWJ13tAaKi3kbuKRh3m4aAS/I8Jb0HcAEYv/muzxTMkLG24/wT0gTTvajeqj4MWQXUWbnQXnC4WLT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026218; c=relaxed/simple;
	bh=Fmgk2q4p/IwR2wdACxNVa0GZ4upX8qqi13m3lejd2u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RI5FqHXUHLl2lzoYX2X7W41D8KUJU5jsAStBWVgJqgOJ4vPRIbwbxUlmAl//W6xfW6nL+eiIRq9vW4EDXQpbfpx36rrrgbhnBdflxo6NDWOMfaP/crS5B7FT4MfvsVJbsUejbRGFCuT59bv/vERMS6kxziyrGlpNoWSt04sb7JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RQKkuXCI; arc=fail smtp.client-ip=40.107.255.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvAh/BdlqmcZodyk7Z1QBbZCIJ7kyP6wdAJnMa0w0FV0eGZdx1idlPdCRlmQ8V1TCVoywWxiX68iOAlf68tyRpXIWjZhj8ErIHkzRTOAcP4bHRr0jqAcnXMBAIIC1QrwU/DZ1VTUIfmCtox4PXHvYRNYi3PvvFM1Jwrvof3OCPtEqgNcs1YsDRzAILqqd2VUloN2TyK3A7KlGOmDQrHvS7UXOYCZVDNtJuirVPx+slnHivH/imt60erIOdh95Iae/nftxw7gNu/8jWQNP8za0O0AljYOehIEsUqPCte3Dd0EQpobgifsTpCtUhVMFX9NXpycmHnhAEMfVnWHw0KqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui23Wl4gzNHQSlumlPbHvIZ7K3txKFrFBs2u97Fs0kA=;
 b=eqsZDirFi1F7bDzlOKbGU9A/lGmyU38hlsR4t5328iJtm/JfN8/rZsAdGdbtGZNU0lfTLQcG7u7G+JkRaGQga9XaYSeCJPGkpArnElExRVjF0WRghz+8W6Oe4Ud1vdTxjpl0Z2vjNagr9NgST++FRebSYYpkoGm/FT4jBuuhyAnN4ZInxrAdxDlMfimeOYen+HPhO9TJW74uxuPHc1QMAjbNZXY7WD3lPUPVHsmHntEgZBroUFO9aSb9WHxIn0H8WH1RNRCLgP9DQ4/DpiNQWDPmc6ZwORSGGsXa8ZX0DzLlWEn+YlhrywsdbMQhSTDSSRVqfeMrJpSgwkoPrXDSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui23Wl4gzNHQSlumlPbHvIZ7K3txKFrFBs2u97Fs0kA=;
 b=RQKkuXCI5NHGS5tVV9/QC6ySG5EVtjudQFGjlbjhQ3F1e/Aeax66TBqMmSrR68KPwxd8ORnvmboYjhQuu6oYSRpKYi/aYX7lwcuioDtLMypH6fMT6yQp0fSyfq4kLZMuEx5rhXcVkVZiz1Dn9mV2pNeAx93ZgMWil1I9EHZGYNs/ngq8Wh/YXjYFPrMG7FPevm6NnenFGDIVdp2PKWcGECEXCY+CxI44vu0jwe/CFVYq+A/WjPl7Q1KtqwudJPgrMiTwBl/qQh8OOYHmU5ZaLRRcF9O4x3tHVzop22fTxJSHBsVNJtnQtAp1ZWsWeouzfQb+ongKTszwAAVOUFT3Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by JH0PR06MB6917.apcprd06.prod.outlook.com (2603:1096:990:67::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 03:43:32 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%4]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 03:43:32 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v2 02/13] f2fs: add inline tail disk layout definition
Date: Tue, 10 Sep 2024 21:57:15 -0600
Message-Id: <8532545a0f982fe320105ee61cb7ac32319781d9.1726024116.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1726024116.git.bo.wu@vivo.com>
References: <cover.1726024116.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|JH0PR06MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d9507d-f412-4b34-e3d9-08dcd213e83f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SdM9nOqdPJ1yGyT9w4EX4fSf+qitFm8s+/3bVAF/UfvjnBVxBGwSgerLdGnH?=
 =?us-ascii?Q?tim2sdVmltj72TeLZYBY3/lJaepyioCel+S0wN0L3zuWf8QRpn0jWLYHQ4yk?=
 =?us-ascii?Q?fCH4nw0oJGPz1i5xQ6Iz1upsgZ44XoYvVNGsKVCiKycea5QXUzWiAcsEf91a?=
 =?us-ascii?Q?+NJ73lvaG5hVR86XbTe6usUr+rhPpQ7FmEThVE4VFLTCufeboENoS5eNTWbT?=
 =?us-ascii?Q?xikzySybATNiL+IaUy8VCAN/HI/Kyg7PX2mJQnsaMPa9mccg/SYfXbpuWzpu?=
 =?us-ascii?Q?OqfAYzmh++lFULD5NoNW8RQ0mBAeRTogVAmj+cm+lCxsbju8HQg+yWo3OhPJ?=
 =?us-ascii?Q?DQHhxEH+i33YZp3b5Iv8mrLVphtCYZDlEFoGPJgYcX7cuJnJxNAb19XL8JBH?=
 =?us-ascii?Q?aOSBy6g/QK+bsmAkyhIAEMH0iWCbes/oJDLC9HVPwOUA1H8s10iGZw9i+7c3?=
 =?us-ascii?Q?MN7jd6WEb7l3i57YQuyM+adg8WIGTUvBmXLap2wCEo2Mu++u9kZXjjpqV0n+?=
 =?us-ascii?Q?Uur0toMXek1MWxbLCzGw8R+rlJzxvGD8lpUvq4fvD5GGkUWThZx3wpl4mzC0?=
 =?us-ascii?Q?r3RtpJuJt9lKNvbwpAHUVyIQ8KzU32F59vx/IR350WcCcLX3wJsHamylPRs2?=
 =?us-ascii?Q?KTPISA6pp8h5yoPSt32zflZTwqo2SSTzjZqB+WAPrdl/vBnfOiBGffsxs6ex?=
 =?us-ascii?Q?F+hGCeeWYH2CYAMkCW8x8bB242aLPrA8Lah9NACBFYzc++X3R+1d4dLZWcM+?=
 =?us-ascii?Q?Vit6AQICnKHXJTlDHPovHB9MWJZ64YBVtLNj7b2o/PRYkXo6BNopMfwBLw0W?=
 =?us-ascii?Q?PnIZc/t2s2JH/59RY9sf2DXHn1Yhx5twsMsjvre6J9x0BlTXgKmetoj3bZrK?=
 =?us-ascii?Q?a5PAo50soNsjhKchUfxDv576iPdMkPwMnwvJT1JkQt935vYFzVF8K1L0SrEo?=
 =?us-ascii?Q?PndBzpp/Vr7tGAZAga/iMe8gWGJLp+Yn87pmgUVnDHD8SvpKCXaFQ6b4xvfs?=
 =?us-ascii?Q?FQpKgIluyPpOh6k6nkqy4widw2h+zUXuLED9OnszpzyzRZbAvtK21XnDxazx?=
 =?us-ascii?Q?KZL5tLi2wcomq9hUEgPOo9/0CWY3KPOiK3LMreg6LsEpsWp95+T4IpXXJCSE?=
 =?us-ascii?Q?2HREGNu7p8FPgUqyD3g+gptVMWHAaiBt+7atwdJIgBLNm+Bw+J2rs13bp16P?=
 =?us-ascii?Q?jI+7KbULL3npX1+M4QdVfXUZiExqTGDeHr+j/xJbe/8iAouSXeFSFlniUdy9?=
 =?us-ascii?Q?OV1NiNJL8mMiQ5OBiqmHZms9qjD3mMHM+UhoXrbX3sl3kQSTZpJ7ntbs88B0?=
 =?us-ascii?Q?UsHJvuXwJBELCxUHXx6nOoZf33J39k9EuZzUDsy+rGdCDiR+vP2AheP+HCQH?=
 =?us-ascii?Q?hvzSxENYH+wa2kUb1an/krMAChK0iyP+hUD23iSRKoIJNVIifg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NT5Md5M7L/yo9Pv0+BO2a0VK5M3UdlBRczlFRCobPeeHo3IVEh7GiDhK/SEJ?=
 =?us-ascii?Q?2r7ZF/I0yzKW5RalIEh7ZdE+VIIrZG+yZpQYRM6X/Xj6N3gK6nCyMRI3UjwL?=
 =?us-ascii?Q?m6eYAe2MG5cVAQVXu5Ef9N7fAxvnnOV8pHOmAIpmCl2+19hIqYOEcGi3pSVT?=
 =?us-ascii?Q?T9cjhvbEGJz+T/f1qn9ue//zt5xO74JrLIsTjr1EY2qULqtL6pZeClubsAI/?=
 =?us-ascii?Q?2zzgOJvsxWfReig9L/YamH7yTChvfydIFsz9Bj61uwZ6QO2bycSMLmDT3gHS?=
 =?us-ascii?Q?ZPPn+BHO4mwVSipYoSt6C3iPQY7nhdHOiYdCNQCDPOnFM9wXagAzVIsWK3Wf?=
 =?us-ascii?Q?iRcrKmkZSXZqSjcaBRVW+AvTiTYUNjWu7r1y6P8l8WtDz1XhFmckKS/ydDQb?=
 =?us-ascii?Q?wlPjdNHq/cTqx/DVQYgBcVF676kDqAPp6kMyybRTh1M8k9r+ZaqoGjMTw6ug?=
 =?us-ascii?Q?q1Mrjtj6LBhai9Ypb9iMqvyW/tsLSww4TimZMxetZo0HFPxL8VH7RD5zxkV4?=
 =?us-ascii?Q?IPFTRJ7UwPTL/8k/AaOYb7lf4eF0tVGsRBhrc8NTjL/MhXpoeZ1Q9hKY2c6Y?=
 =?us-ascii?Q?LGPfkQgQJCS5+LrGCahUUIo1FRFV86wj9rewsQ6fZwijjXIiMWousHrwNksA?=
 =?us-ascii?Q?m6GVBDKTgFdI6qFHl9uDOm6lBdA4IlsR1fXClrakFBcdc35rnvYateibRrr8?=
 =?us-ascii?Q?4oPubGLiTziH3TsGT3G/KHhUqxUaZk3XPT/oXseuSQ6VyfvHILRIa1Dey61f?=
 =?us-ascii?Q?lglOQjY1Q+9XlIV085ZHFtf0CX7aVMl+QOlldqifMZEMi1QPKU+cC+rMgfO4?=
 =?us-ascii?Q?syxl+DlxgGZUrSkVyvB3HTAzklG82qsJXA+iBgno4I1URjEg8iFYmxn/dORp?=
 =?us-ascii?Q?6B/n+1D7NH4q9/M+Cw0Cu6NEqcadmgPx3p/RN1CbKEvqAaZUg4HS/EiJTBNn?=
 =?us-ascii?Q?8SoJWpQcyg3jzkQr2rjEIcgVr8H8U+8bBHDRuvepTu2ouvhPFWznTyQdOtSs?=
 =?us-ascii?Q?zksHz3HShvBojosd0GbxNRK6fEqhyZ2ap/0G9Hv0Yi3eBodM7bHMTnSEcZVx?=
 =?us-ascii?Q?wzu/YTk5XTSDWoD7p7mBjKlPY0AT/TpbBSMeRXwp9KzPxIf70WnQ/NhphhT+?=
 =?us-ascii?Q?mjMCbKslX0jeMUMSwGyfMHEcCYdOhC1NDaav8GcEvjq6oGEH9MgaMmTSHF4M?=
 =?us-ascii?Q?/waxX3kt6jRQ/lznv8KvM8sP3w66K07jPYUwCbjwkIXpMLxR2xLLc2wo8dND?=
 =?us-ascii?Q?HBDTFKcksrKwf4t1eqmTXaW2GcCcohrZNkxlMW7SXgTTXOzxzws1zq8OgTgk?=
 =?us-ascii?Q?+FhHi7xYaPGHGHuIWPdpen7gudCFjs07du990NiFZimEdv1nUyvve3Cy24+X?=
 =?us-ascii?Q?BzQqP847VKR45wyu3H1ooYCHscQgazB+PLuED7jQcMn2Mj0dF99xf3DD6Ld8?=
 =?us-ascii?Q?6IwTsWfcoImmp+LIr2QPwSZenc9oe0ou6v2UaQbr3N0ytrZ+oDO6LvUhB8tV?=
 =?us-ascii?Q?dX7TpqWE0J1xUkvTApRr8vSSJQWo5zNucVn1n28gKGV5wq+T2dpE5gxKaAnZ?=
 =?us-ascii?Q?0kZF5+xReB8bPyisJfbOe/me5NSIkwujRzPGigvD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d9507d-f412-4b34-e3d9-08dcd213e83f
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 03:43:32.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFzmp02DP6ZYqAtAm7f8xeg+IAtVQ59JdlKDgUXToqd4gr4v22qBW1YwushQql2VIAl/BK7KqGDDyIPceCA6Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6917

When inline tail is enabled, use a compact block address array. And the
rest space is used to save file tail data. The layout of an inode block
as following:

| inode block     | 4096 |     inline tail enable    |
| --------------- | ---- | --------------------------|
| inode info      | 360  |                           |
| --------------- | ---- | --------------------------|
|                 |      | extra info         | 0~36 |
|                 |      | **compact_addr[16] | 64   |
| addr table[923] | 3692 | reserved           | 4    |
|                 |      | **tail data        |      |
|                 |      | inline_xattr       | 200  |
| --------------- | ---- | --------------------------|
| nid table[5]    | 20   |
| node footer     | 24   |

So if we define compact address array size is 16, then we can have
3392~3428 bytes to store tail data.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/f2fs.h  | 27 ++++++++++++++++++++++++++-
 fs/f2fs/inode.c |  6 ++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3956740ca7e2..e02a6619b90a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -476,12 +476,17 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 
 /* for inline stuff */
 #define DEF_INLINE_RESERVED_SIZE	1
+#define COMPACT_ADDRS_PER_INODE		16
 static inline int get_extra_isize(struct inode *inode);
 static inline int get_inline_xattr_addrs(struct inode *inode);
+static inline int get_reserved_addrs(struct inode *inode);
 #define MAX_INLINE_DATA(inode)	(sizeof(__le32) *			\
 				(CUR_ADDRS_PER_INODE(inode) -		\
 				get_inline_xattr_addrs(inode) -	\
-				DEF_INLINE_RESERVED_SIZE))
+				get_reserved_addrs(inode)))
+
+#define MAX_INLINE_TAIL(inode)	(MAX_INLINE_DATA(inode) + \
+		(PAGE_SIZE * COMPACT_ADDRS_PER_INODE))
 
 /* for inline dir */
 #define NR_INLINE_DENTRY(inode)	(MAX_INLINE_DATA(inode) * BITS_PER_BYTE / \
@@ -805,6 +810,7 @@ enum {
 	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
 	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
 	FI_OPENED_FILE,		/* indicate file has been opened */
+	FI_INLINE_TAIL,		/* used for inline tail */
 	FI_MAX,			/* max flag, never be used */
 };
 
@@ -3002,6 +3008,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
+#define F2FS_INLINE_TAIL		0x80000000 /* Has inline tail */
 
 #define F2FS_QUOTA_DEFAULT_FL		(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL)
 
@@ -3263,6 +3270,11 @@ static inline int f2fs_has_inline_data(struct inode *inode)
 	return is_inode_flag_set(inode, FI_INLINE_DATA);
 }
 
+static inline int f2fs_has_inline_tail(struct inode *inode)
+{
+	return is_inode_flag_set(inode, FI_INLINE_TAIL);
+}
+
 static inline int f2fs_exist_data(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_DATA_EXIST);
@@ -3299,6 +3311,9 @@ static inline void *inline_data_addr(struct inode *inode, struct page *page)
 {
 	__le32 *addr = get_dnode_addr(inode, page);
 
+	if (f2fs_has_inline_tail(inode))
+		addr += COMPACT_ADDRS_PER_INODE;
+
 	return (void *)(addr + DEF_INLINE_RESERVED_SIZE);
 }
 
@@ -3428,6 +3443,16 @@ static inline int get_extra_isize(struct inode *inode)
 	return F2FS_I(inode)->i_extra_isize / sizeof(__le32);
 }
 
+static inline int get_reserved_addrs(struct inode *inode)
+{
+	int size = DEF_INLINE_RESERVED_SIZE;
+
+	if (f2fs_has_inline_tail(inode))
+		size += COMPACT_ADDRS_PER_INODE;
+
+	return size;
+}
+
 static inline int get_inline_xattr_addrs(struct inode *inode)
 {
 	return F2FS_I(inode)->i_inline_xattr_size;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index aef57172014f..88dfcf16da0e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -425,6 +425,8 @@ static int do_read_inode(struct inode *inode)
 	fi->i_dir_level = ri->i_dir_level;
 
 	get_inline_info(inode, ri);
+	if (fi->i_flags & F2FS_INLINE_TAIL)
+		set_bit(FI_INLINE_TAIL, fi->flags);
 
 	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
 					le16_to_cpu(ri->i_extra_isize) : 0;
@@ -666,6 +668,10 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 		memset(&ri->i_ext, 0, sizeof(ri->i_ext));
 	}
 	set_raw_inline(inode, ri);
+	if (is_inode_flag_set(inode, FI_INLINE_TAIL))
+		F2FS_I(inode)->i_flags |= F2FS_INLINE_TAIL;
+	else
+		F2FS_I(inode)->i_flags &= ~F2FS_INLINE_TAIL;
 
 	ri->i_atime = cpu_to_le64(inode_get_atime_sec(inode));
 	ri->i_ctime = cpu_to_le64(inode_get_ctime_sec(inode));
-- 
2.35.3


