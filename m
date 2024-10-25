Return-Path: <linux-kernel+bounces-381311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8569AFD7D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1891C240E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886F71D359A;
	Fri, 25 Oct 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FuxGHgyK"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2042.outbound.protection.outlook.com [40.107.255.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67E22B647
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846926; cv=fail; b=ZbhMij9ptmX8TrKmr+9klVZo5iwpkwePfU4J1XtC/AII5rmzggEQINWvcvd+0gF7JQ+NJPPg2BDpXp2qYlhH9Iihy8kYkkrYYDBkTJiBaZ1Dta3OdtlnoXkLcl/01vhHvxrFZb1MX4PzUo4IzYgPNPI/gyQTPmxqrj28kh5WzKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846926; c=relaxed/simple;
	bh=E3CVJuELb5UxzvNbCaHMcI8UyJGVGnih62+/gM/zfOM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sGOga4aTEsUPA4FX1dZeUAE6NU2Hk+DLx+ZClAEUwd1q7fmwiYgJHosNuRgqvYcns2j7fVYvl1U1sSFUN8KiHacBIZGTrDP9nCZ6EtJgc905p/Zx1dhY4Eo1ZFB3XiKE1mOsYmjiTEuucwG78zzlU2bWVw4U5ew/zzTLUOwGU8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FuxGHgyK; arc=fail smtp.client-ip=40.107.255.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyWoPc4y5xkrNbau3F04P+k8nTZAQe9UMpzLG1LuCe0kYCaKfMdrmgVByQu8wMC3ks2nfbEs0PaZXieELfL3l+SCJD+ww8Ti3MZSVSZ4/g/bMShuLZZN3IoV2WIIkbQTBBLAekRs3i00J4mg+vgoOlAW5qGSzLqxqrPvL5OWedY7aK1uf2IY4m4n1fGA+QDRaLkWqeX1xrGo8+bQ/AWizAtbz1vBinEvnOnHLgmssy0UvRFge8I5XM6r+8juIk/A6mK0oHPbK8B9yfSP9eaRzMZqhORSLiNCsFlG582ntMXDNC3UTGdKS+gHfGMUvRJGAlr2FBB2J34z8mIa/hEChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIZOqrFYshyPocBVzqEXoTYVXDbw9L+XY2j3qGuOQAw=;
 b=G1VvcZEcZ1x2xcPgXsJdDCQ6xncPnrKb80r8Purx7QjJkljxrCaMZmrz/3qOtwJYEapc7Omc6KFtegAKG4u+DWV70noYvR+zGnaqo4JeYNJkh/Q90ulwzSSN5MEuT514Lizv6uGSAjIN/I7yoYQip6A858KuAXj0PHYdOVRYPI/CKy0Zfju86fxinQGGt7KDWnvkFfKF++fm4YvsLNhQ3LUuAa/TmqoD5sGMcfvudXccS8JJ1Q//VaA2OU0Y+q95bpX8eQHJy4mC2X5bRXQdwOaLfRCe/L57RrDJHF7hng8jtIJKJZ/ds57QlIxRhBm5bmZy6Z2dY9jSaWM4AZyIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIZOqrFYshyPocBVzqEXoTYVXDbw9L+XY2j3qGuOQAw=;
 b=FuxGHgyKhNz2ljRdNGGb20Tj7pUneZdeixfkQM+ZDejyZNaObLckiSSv/QM4DHCOeIQQTwbpEVYH2nR5D47qan+KGG4RAI7N7hw2SmHmTKNM97it8Dp+AmPK59hygU+jSORgJpPps3OdI6UKJcu7qE+vnoB5H2eM82Wz6Eq0T9hB1ONovy10FhoinMYr8hPD7QkDBiioumOncYUxkjqhkWyTNZ/EI37aHJmjXv2HojFQzihVzzikrHL00ih23Icwr5L/APooJkTRXyU+Dp7037s3S6cy9ETzV3tgBJDmTau1ADrnihX9NTIiHPoru0YofCkOAJwHMonAlemi38rxZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB7151.apcprd06.prod.outlook.com (2603:1096:990:8e::9)
 by TYZPR06MB6093.apcprd06.prod.outlook.com (2603:1096:400:33b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Fri, 25 Oct
 2024 09:02:01 +0000
Received: from JH0PR06MB7151.apcprd06.prod.outlook.com
 ([fe80::5dfa:f434:cd39:85dc]) by JH0PR06MB7151.apcprd06.prod.outlook.com
 ([fe80::5dfa:f434:cd39:85dc%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 09:02:01 +0000
From: Qi Han <hanqi@vivo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: niuzhiguo84@gmail.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH v4] f2fs: modify f2fs_is_checkpoint_ready logic to allow more data to be written with the CP disable
Date: Fri, 25 Oct 2024 03:18:23 -0600
Message-Id: <20241025091823.2467074-1-hanqi@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To JH0PR06MB7151.apcprd06.prod.outlook.com
 (2603:1096:990:8e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB7151:EE_|TYZPR06MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 004bb97a-e5e0-4e6f-ca42-08dcf4d3b050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMTceFU3e1QDxb369V8ZhyYONeKA5K2wgNgUznslAeWZJ3O2cXP5880NJ1Fz?=
 =?us-ascii?Q?hRkOsbx1148AOkPoZv0fLf8lNqRL36mFmOEXm953bpcx9aOxqOl1iGaWpe9C?=
 =?us-ascii?Q?S2aVPFH84lzd5AhHMDKkcYaNjn/U5CXiPPPPDnNnKvUnHNokM6/WzGoZz+I/?=
 =?us-ascii?Q?mdna2C8MeLHmnQyvBt2ZZWagbqc6vg7UKQbnzXw3HFz1OfXOlySw50hDHk46?=
 =?us-ascii?Q?j9ypE4tFghM0ZLvSi4C8D+h7WpcC2m9m4DmYKpmGmOGcp/GBouKWLdN7Zmmp?=
 =?us-ascii?Q?DZhiUPgWqp0Bki6oJZ8rc0akC4Db9+kzgqQ9taf67/sHVY2vKe3KLyhlqTQ3?=
 =?us-ascii?Q?fPQ4emSUoWY1cTDb3Yd+YRgIfL5bvQ8W0YHmaBqDNtFY9fHRqk2KAfrJ7o31?=
 =?us-ascii?Q?jIln3SVyRm9a6eBQ/dmiCCpXOM9WsS9JZzEDMY+mjMhfTLQAaXbfywhlouQN?=
 =?us-ascii?Q?LuWgfm15yI5WjGXejQ8m7b1BKlpCsTDLKYhc2uzJaE8R4Feb1qG1QTt+3zV1?=
 =?us-ascii?Q?7V4FAcrfYb+aR+bZSVS/jhVN7ci/JLlsCtVOvcSUarOQ1PZMVHHc2152pGzd?=
 =?us-ascii?Q?Gs0U9zdhUsJfIwGg3EQV+GxgqBo8cEYPIXIVQCOTuOXtxbKb5DHv+M7PzC6R?=
 =?us-ascii?Q?vH/C37+tADfLwbFQJdHw5nOQvprPix2mnHFtab6ejkpG5Iptj2u10ZapdoEK?=
 =?us-ascii?Q?53JWSus6nApnPLpVz6ZA5AzTSM5Ic/YnNqY6/IRUXRbDmxlA5eWBw8oGvP2C?=
 =?us-ascii?Q?URdGdQA5y7JDJ+pnjSxD/NQ9iSjArj7dlfwV0jopgDuD/25cim/DSm/yHvCJ?=
 =?us-ascii?Q?FoBbYAKPQfx4ufvabCTyBPLnoSexjFKK6u1b+xCL074XORfKefhJNnimuzzn?=
 =?us-ascii?Q?2wM94ejWrr5sTpIgq5cXqtSdNbPA/f2BjjmkIyKN4sw6IWodSKsZpq+UgSMg?=
 =?us-ascii?Q?8zX0JEK8G2Fp29NtvSkRhNlcrBidA+3ZeKXr1oxYogv6mNJhE3NZQ/CgXrGp?=
 =?us-ascii?Q?4iYqDUIIpjkyfuWvbFp0UTNCiR9YtI9VZXIQOKJzbf2XoNRvblFAV2uK5x5R?=
 =?us-ascii?Q?0/WSyRrZuvBk11Ll5J4eGMV8cNlYaQQKyY2005XUiWQTFBvqdC6sdwKmUxbh?=
 =?us-ascii?Q?N6iTcBz87OtO0VC+T5y4WaSc+AtjB9n6uW0SpNtHqcC1A+VxeEHYbKdB7rrI?=
 =?us-ascii?Q?z2uXvlnEpi7/HJ5yXxaH9xwCSC0omPi8Cdf3x2WlckZJPqyCTbvdVip79Ojh?=
 =?us-ascii?Q?Vwv/I9QntHfSAe2nb5oGc8jl6pVO5W/1DlS9WLsKiHzsIp4V022Ae3rJ66xR?=
 =?us-ascii?Q?kKgLWQyUE/gansF2B55X6c5l5bahnV0zer2sQoLn7o6UKmmFM6QjfxKKlD6p?=
 =?us-ascii?Q?7Ci06eo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB7151.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oep9Cq+nFvaFNMz1POJ9JRlDGypSlZEYkYWmarqm68P0lfZolUaAVyIg5237?=
 =?us-ascii?Q?0b8wENiHKC0XPnddp6OEts9KXqM6jvlTjBGjfotNiBwJDha0CDOI5p8juEZ2?=
 =?us-ascii?Q?G8vt+ZxZF3epradC0KfgwF78iWQsGdty1obIZrM4wRGGM1j7Xe+f4qob+MOg?=
 =?us-ascii?Q?h0MqwHnSPsnQs0OdrT8tD0Uia3f37M7nFXYKm6s8hxol0DOC4yGGuU6967p/?=
 =?us-ascii?Q?Ns1PQLc+O0Mm8iXCzihTd8fmImEhkRTbZX7HDEpkpldkOrfParxET5QP7PFE?=
 =?us-ascii?Q?vdHB+uP6UdWDFu0EQDuZVOy/AuagKhlgmuy9QYLupenfzmjSFhdTTt5FZWgi?=
 =?us-ascii?Q?Q127NS2aZlC/AReAmXtlw64L0VFo5uGxo3DW/PjTeAWyEDCKcVd5WMsbzE0X?=
 =?us-ascii?Q?tHeXg8p1rmh4caXbY7XmZOGqZKSthMJUYdnCaLUF+4gOObcNIrQj1fj+OL7l?=
 =?us-ascii?Q?WiGEHOkqSPCG4U6LzXh6Tuek60+cgQ99XCXjgzv46FFkJBrTMU5X6JmhW944?=
 =?us-ascii?Q?CmbFqTP2DP7LVZkZ+D7re3LYDrmC2nLmCnOoGuuWP6VcaRg7EmrOceQUA8Bx?=
 =?us-ascii?Q?vgkHZYR3272TvQERyje52v0/nmhSwVCWSiO8NXSiyG7NP816Xxjd3mgGuMSe?=
 =?us-ascii?Q?80sU9f9gBNvrdSqJ4OHaluSZoY1N3lau307lFg9Jqf/ybT0xnRodxyxmErJF?=
 =?us-ascii?Q?HeI9joJR1eBepgRR1eMla+tnpZpOEQxFwGpazQti4HsrXYi2DicaD6PFDjg6?=
 =?us-ascii?Q?vPvNATlmcAC1YQk57AdKtX3kzazjZdvwnUMNMRvdXlSXTQoGZXBCrIMeAbAP?=
 =?us-ascii?Q?R7IjI//yv+J14WsiVeV2GDpO7nNrL/jsJixZxI/aEhIErNEPXDLGydStRzc7?=
 =?us-ascii?Q?Zkb8R48CXHMWJuiDhv028VTKIoafV2ijPKO3/6YzYxmvQD4rAp1G10T+aHYs?=
 =?us-ascii?Q?UVf1J1TOqwM0TRjujgDgKe6hfHYijNaMnDyBL4U02A1XTqrP7Jr4Om3lNC5Z?=
 =?us-ascii?Q?11MUzT/AGhLIZJ7yav+uwqqNI2GS3bmr5s7K4T5Ic8qD1RlVK1xE+yiAclhP?=
 =?us-ascii?Q?8juuULfkl9ZZr2YRrTJsbPu/n/QgeS2VjjP9D0OPTYS2YzLg8abq1jEZsA5V?=
 =?us-ascii?Q?BZYgs+rWTP9cVIMICEuj9FG/ap8hyNlyZnY9kSQxsPYvRMpWzxlrEw4Iklcj?=
 =?us-ascii?Q?aXg/huRc1lZJRzEJ/Q2LGPXk+t1PaMvScXHUH1Fe49FZM1FMYPS1OT0sS6sd?=
 =?us-ascii?Q?RVFK9ImNqXR3y6NA8s3Zdt/Cimj5fninX+mPRTEGemvK+EbgfzgDPFhRMJTd?=
 =?us-ascii?Q?CspykYNBww51aSzw4dPRpllT+w4TBxJGNGpV5GTc9a1c68azTa5n7TnGetqy?=
 =?us-ascii?Q?7eoD5m1fVh+5l9By3QEdL0TOukZdMjipK6Azq9YbaBD7uRVSbxj2C8nsGRAt?=
 =?us-ascii?Q?UZO3hLvkFMFAFuSgKY+dbLTLwPmlJPsPh4PeavPf2lZuTK8GA/i11JWP2+cH?=
 =?us-ascii?Q?z8s7G2X5qSfK9A+9eZw41nztTo722roKiN3UofjDhZb0g2GyLbSSCli5UAP1?=
 =?us-ascii?Q?HeKSo956GFproi1dEwqVr0qgzMdxjCQk8xZHAqaz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004bb97a-e5e0-4e6f-ca42-08dcf4d3b050
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB7151.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:02:01.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAz5Sj9psRmpDoQtDtk2rQG+g5NhSE7SbG751UTfat6ITa8qLTJNbd7WJDs3E3EqinEy+riI9q2wR7spjMiLdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6093

When the free segment is used up during CP disable, many write or
ioctl operations will get ENOSPC error codes, even if there are
still many blocks available. We can reproduce it in the following
steps:

dd if=/dev/zero of=f2fs.img bs=1M count=65
mkfs.f2fs -f f2fs.img
mount f2fs.img f2fs_dir -o checkpoint=disable:10%
cd f2fs_dir
i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; dd \
if=/dev/random of=$file_name bs=1M count=2); i=$((i+1)); done
sync
i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; truncate \
-s 1K $file_name); i=$((i+1)); done
sync
dd if=/dev/zero of=./file bs=1M count=20

In f2fs_need_SSR() function, it is allowed to use SSR to allocate
blocks when CP is disabled, so in f2fs_is_checkpoint_ready function,
can we judge the number of invalid blocks when free segment is not
enough, and return ENOSPC only if the number of invalid blocks is
also not enough.

Signed-off-by: Qi Han <hanqi@vivo.com>
---
 fs/f2fs/segment.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 71adb4a43bec..b8e88f2f17a7 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -637,12 +637,30 @@ static inline bool has_enough_free_secs(struct f2fs_sb_info *sbi,
 	return !has_not_enough_free_secs(sbi, freed, needed);
 }
 
+static inline bool has_enough_free_blks(struct f2fs_sb_info *sbi)
+{
+	unsigned int total_free_blocks = 0;
+	unsigned int avail_user_block_count;
+
+	spin_lock(&sbi->stat_lock);
+
+	avail_user_block_count = get_available_block_count(sbi, NULL, true);
+	total_free_blocks = avail_user_block_count - (unsigned int)valid_user_blocks(sbi);
+
+	spin_unlock(&sbi->stat_lock);
+
+	return total_free_blocks > 0;
+}
+
 static inline bool f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
 {
 	if (likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		return true;
 	if (likely(has_enough_free_secs(sbi, 0, 0)))
 		return true;
+	if (!f2fs_lfs_mode(sbi) &&
+		likely(has_enough_free_blks(sbi)))
+		return true;
 	return false;
 }
 
-- 
2.39.0


