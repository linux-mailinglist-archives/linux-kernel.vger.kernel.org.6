Return-Path: <linux-kernel+bounces-296568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77B595AC40
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5AC1C21103
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438AE364A4;
	Thu, 22 Aug 2024 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dHyApkV4"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2061.outbound.protection.outlook.com [40.107.215.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0438266D4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724298481; cv=fail; b=WqMD7S2g5uvsHuHunhsCnjDpJA2h2Hg6gL+NWSf1etYOfqRzK5veGPJs9DuVoGjLyE/u8cZDYx/p8ybNcZ6LpCyM9qbVrNejMKeQpUy1ou+dA0Mv8k4jGvEvDl5IXQJiMD9D9jhVlcRU2ifqJnqZN24KVoBPJO3dvBce5kOWbz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724298481; c=relaxed/simple;
	bh=1hDcH8K/OlP469Q/YNB3nqzhoKZvFwoPQx1S/b3m700=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ypz5wdUXY0JNQiiyMDtVuND7DoXftuIVktVeEvBUC978zcc9JOoutBYYFppcr0PerjUKi3Nq0ig+FA6eF5ojPB0pIK9DeV7OOI86j8QRy3uAdLtwxfpxNCTgtRKxzZG79gd8Bdy3emJj9FkRLBUrFjt8rZVYAMMU4zrunxw+3qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dHyApkV4; arc=fail smtp.client-ip=40.107.215.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfuRhW/+CQ82+rwSU5uXOuyBihaRwmxQkwbNecKsgSjcjsH8f8adJzjiyB7uEKE8syjetnvKZdZJw/QIsRjsKczVywIHLPIUvPUBr9DPC0XnsSjIp1in4SLwcRDybQbBKhCtVcspGPJfMp5c/cEBo1fj34r0huoRBd5JNleIq9knD9y1OSVkCshgip6mEBR9/x0L9UTXnOE0ykJdn/p0LqjzG5zsuh7OIbTefCmjjEG/bBXg/LWkCnErQAH0KkThKN5xT+taoGU1zXTNPWVHpUPsjffhzzsnvMcsabYKDurWIyLhnSEZGE7aAF7Fm1Os1L7Gn9tyr1WfdVea+2Bu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFlBuIoQqZqlob4Q8+MMri2985lqukjDJtd9D4kCPNw=;
 b=hlXPi3sHHwA/ocPjAUjt8+jRZqn7yyDgggJCQfWweBEVxb6wPdHdiyy2LTkfeZEOYjitbw9K/Qfo95JpgqCViHlzn8zcr9M7y6YMCWhDNAEI31109MlWwvxD6WmQTFcGSsACWMP7G2LD5xSeRYS9EjXUymFIcuk5MTzDJvDT3WBfhogAVjSfIQkBTUVldUBoJRWXp3FiiGTF1jsT6iDkIfim07/KTTN7r6YuDvuuAktYC8Jrl3zv93i+AejKWkDnt2itgkpcv6mf2WlAF3Bch6GvIUrA5195o9L3Mm8XR173cdCQss1Y2N6LBbZ+BSiP33tY0lL8lv0gR08BlgcOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFlBuIoQqZqlob4Q8+MMri2985lqukjDJtd9D4kCPNw=;
 b=dHyApkV4aaEo3fC8T9O+Tg+uiPfOwWzNv5EE2ezzAi+WUwRyWP3kOLv/so/MxGi4w1EFgn9DyA7C3hU7Jm9OOO/ADmOcP/xKSNcFj/oW7ABOMABXzf3DPvyUNNW563PedHuhktKsda7bOBvL4SijF3q65ArvCR8dkmiffVD+9ITF3YB+FQqCnAY9I3fuvaaUlgU0x1hCf4F31f4k9IFykSsV8oRzoJI32jIrtakjPCqV76tmmd3IQ6OnjHZyJ4JS5N+E97Rm/RA/oApwKxwXIeXdAjxZ0PDC1G/EXASSY0ase7Va5M+UfflQViCVfLYXnGU+T9gYSN7t94xh47HjVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by TYZPR06MB6192.apcprd06.prod.outlook.com
 (2603:1096:400:332::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 03:47:56 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 03:47:56 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chen Yufan <chenyufan@vivo.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] X86 architecture (32-bit and 64-bit): Convert to use jiffies macro
Date: Thu, 22 Aug 2024 11:47:21 +0800
Message-Id: <20240822034721.9561-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|TYZPR06MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 645518f4-70dd-4a00-ac1e-08dcc25d3521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tbt5B0WfSFV5NuP254i3S5XtOJ6hBUGXEZzDjNXmwIW0IpaG3cLskjxu4y0L?=
 =?us-ascii?Q?VVXsbJ+t5bNOS9Ew9fdv2KvnUCmJzQsZgfMk+cZkxBMBJtJtV232FIJhbuKG?=
 =?us-ascii?Q?NZqYoZRjktgDNjB3udyAixUuWmWc8F/K3i9BUxWk9hZzR2NkRjA9rPmHyemf?=
 =?us-ascii?Q?mECpGdAnN3v1BHEyfc6gBGbY196IS9FBEXryelbpIuZy8tcJjLb5VF7+M8yb?=
 =?us-ascii?Q?/8u8HvO9P2Zy3uQ3ztawMMssVZ9sNnHTqARORq6GSGotefpCV7/+Wo29a91j?=
 =?us-ascii?Q?oJc6g/30H35eye/4/pcmbjBW6CpCKl9g3bCbiMUaQxr13WQWfqgvDODcy9v4?=
 =?us-ascii?Q?5fLMUdpaeypTVAap8pXiQ9pN5pwVG8rYUGc/4f7+imZXIlblv9nfDRjLfdlp?=
 =?us-ascii?Q?fLD1ZTX77Ne9bew7MVZkfHW3LQWIa5qoaBNe6EFdFUuLp3IOj6DYxyapmVjL?=
 =?us-ascii?Q?SQOY5VafSEvXlTT8N6v5ke/c/Oc4rnLMwaiMqrPDJlQXJ2V3IMRaHzo963kc?=
 =?us-ascii?Q?TFWOe5X4grgxcvgUBC8NgKEUA10/hGtkQbiq/WATyuIig7E71LYVKT3GMlbr?=
 =?us-ascii?Q?jlO1beMZ9Udh7+DpYwy2HIEqHkrxM8HvhrFQDQsBMw2Lz7h5tjsn35VuWjQ3?=
 =?us-ascii?Q?SrSxI2fXUmFrHoGJIAkZIigpWtSTyD04a5tZSHZ5pAsLJfCiAZItu2FfA5kq?=
 =?us-ascii?Q?4BIURX2x3DA2txDbdb0bIIJ1g7xJv6bAiD9hiiMqZ9fp1SR6xoh00v+bK8iT?=
 =?us-ascii?Q?6qe8cpTyOqzHTZUawE24PvYYhh2ff3cHzrGrEBAR3t+/z22kSneiBKAa7wrz?=
 =?us-ascii?Q?9Ot+qpI4se+N6RjYr3u2hHVo3Z6HHLTCOFOiuH/ucooWLd2HOXtxcrjICu6C?=
 =?us-ascii?Q?b7CNIpMhtOV2F9Ky+/AOd89yqT+aa4NufFRQLX5BEhqAvFJTZCoH8IPHjHhI?=
 =?us-ascii?Q?b0BCwGsPByT3IzI2KtjCRP78Zater2cl/wBPFKwRY822Zkry5zK22yZdAaGp?=
 =?us-ascii?Q?OWQ27HaF74RjlMh+qesQ2tuGJGhGUextp2Glo/TrKr5JCEnDQkeKRAvGZrxc?=
 =?us-ascii?Q?UKoM81dSJS2Pl4khFl0xHZdAVBBgoNy4K1LBdfuPuRRGuxumLZstAsnKoPAL?=
 =?us-ascii?Q?CwYgtosvmLQ9uu6CuENSouqlZ/zTTAuMjM+Z38gYoSa0jisXFT36581DcXan?=
 =?us-ascii?Q?A89D4FEreE6JKNSnAosRYjHSGVTSInGRD3jv9qwh5ki1+aKYNMEsMkvINqFT?=
 =?us-ascii?Q?y0cGBmND4OuAZPqCZBXnpSoNO3FZTgZ04hVp19aGqkln7/JqQLWOMJpQ5HrF?=
 =?us-ascii?Q?dB5d7TdTh8FbUybKVGpru9wAuAR6lm7ErhEDTTqes6f+oWP8+amcTCiVr1fQ?=
 =?us-ascii?Q?aGhmux/DG+o9POKfxeNuvOtJYJQWS1Ww39kZVgB5GgguABeyMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8XptFNRDoT9GfxuijoURSAMgkqoShKAteINmxuBJKdI7ZsqmckId8mvYPkEQ?=
 =?us-ascii?Q?BhZsnpOsr6hMlT4aIJZdewY1uNEI2s7DpE7SBq/ma4pbwXhjaOrznUWcYQNC?=
 =?us-ascii?Q?9xUF9gTIIw8IVQ3CdXB/eYAIt1i36Y9+s9XFTvGdiJ+2y2VC65gNF8fdPeQg?=
 =?us-ascii?Q?G7d0AHYE3ynww1dD+EO//EHohUqVwo6LRbipKAPO24HfMWBQCghsekYS4Mb0?=
 =?us-ascii?Q?sv6AzOncYS+Js09VX6OxcR4HVYLxmGMH3U5wQYE5h9a/uCr7jb+707Z+QJQg?=
 =?us-ascii?Q?CHSoKt3nePXvSryHPcg8nJvVi86XUs5S7g5cdg/X8B6DvlSongJjNScsmi0K?=
 =?us-ascii?Q?B26pNBMw1uDNL1wsWGxCzeF65HOay51pmwNBLW3fS0BeeXqAFLS3Q9kjnjVj?=
 =?us-ascii?Q?FrYYEOip8rmK1lw8iHT5nwHazxGml1znXyzB3y3ap5rM18d+ugv34xnGARsQ?=
 =?us-ascii?Q?UfW9UUzp1HxgF6LPqppfFt4IghbLTxKkom8hvgAfcLRmRUiaVaz+KrwYkYPU?=
 =?us-ascii?Q?5udOiYOdFLJv3B2PNn4pEqgfs1S/0Y32+F405vfUHtK4GXyZP/ZIkXTTek1Z?=
 =?us-ascii?Q?KaosxDMl8ERy/l5q6lJHtsI4VM+Z1SzpGnp3gJ7Rl6g0Gj6j9o2ygkDwmMI+?=
 =?us-ascii?Q?cT/scxVq6zQkMVDtkqJnElUBt43Wh7D+7tnRhrDBpG+67/m2DSbyhBEr5muB?=
 =?us-ascii?Q?Vx8nnU9uoEQsP2KlLReD291NsRyeujVpD6cygLfeVV5b7przoCuNGyO/rbPH?=
 =?us-ascii?Q?gpouF+FlzkNG7FWnQxpDEcBZvbrrkF0B4YJxIUHOAafDXNXKCPDdftOeZR5s?=
 =?us-ascii?Q?iyLsAWAMfx+sbO1dFOlJnXWSlUMJ3BlKFFFHI1P8d/S0jsMP/cWfpviB8Sdj?=
 =?us-ascii?Q?cU0GrKwYGxTHEG3eSzdqb0j9BzeCM57EXNzoLOR0nndIJGV1BFvcMAcd/YjX?=
 =?us-ascii?Q?NlLYCTs2S9ZyxsxrPHrLp8Sqfm6VwKGQadSZJcpjfA8mBUUscTXJcWKKgGHR?=
 =?us-ascii?Q?ELSkDuAF4m3WjgOvdUj8xJQBef0+jI5TqzVc9jS33Mq5lf95yfqv1Y+ddlpy?=
 =?us-ascii?Q?s/tL3Q1wYTr9Pv4ZLQvl/PtEbIFW5kzyj2o+Tu1pfbgk59wZXCOT0fnL+XXd?=
 =?us-ascii?Q?IrCzjSLtlo9IhMhwrLVIv3knxFoBX6sjMugPCrleMTXDyG6cZy/pjaIiIgqP?=
 =?us-ascii?Q?LWTJQju6DmEwzLXJY0trmXF61upwnGDKkTqubwKigOE7ZEmnHQ2u0q7z8d6H?=
 =?us-ascii?Q?FAxVWeOhjgICMfKaj/7HSMTOLGQAzB8UZ/dUVsXXZ90CUkY8t/5hK6oU/r11?=
 =?us-ascii?Q?3Q9h+/AcW/EBHCsjnsHsHtGOw4ApdmEUYPdrnskT0Zex0r5pDlDdWeBaeiH4?=
 =?us-ascii?Q?v82suonBfuBZlYIHMp1Zyg37AC55AP1DWmSVZj1fME2mmBO3QKv5LsgFsJcA?=
 =?us-ascii?Q?8J167YU2wm3jOLqXIbuXvh5A+A9NuBYO79F0hapzp4yHEzolcGGnTTARacyr?=
 =?us-ascii?Q?H4CFfRGcAmKVT3XamDDmOi9AsElZ+8cRmKelOiPj031BpcCEtwx+WzPjFZFJ?=
 =?us-ascii?Q?6n2zZ3YfGPOjbAhGlwX2k/Zh5fkcTEf+DPO16fOu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645518f4-70dd-4a00-ac1e-08dcc25d3521
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 03:47:56.0874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtQuVlcZ2D+upojp6ImFpTJyOA7+/BSmwJ49/XKOGmbd6HA0A3LTpmiR8f8zoIP/kHKDjxv3N+4+ik8CBfBynA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6192

Use time_after macro instead of using
jiffies directly to handle wraparound.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>
---
 arch/x86/kernel/cpu/aperfmperf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 0b69bfbf3..5fe0a7576 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -16,6 +16,7 @@
 #include <linux/sched/topology.h>
 #include <linux/smp.h>
 #include <linux/syscore_ops.h>
++#include <linux/jiffies.h>
 
 #include <asm/cpu.h>
 #include <asm/cpu_device_id.h>
@@ -434,7 +435,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	 * Bail on invalid count and when the last update was too long ago,
 	 * which covers idle and NOHZ full CPUs.
 	 */
-	if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
+	if (!mcnt || time_after(jiffies, last + MAX_SAMPLE_AGE))
 		goto fallback;
 
 	return div64_u64((cpu_khz * acnt), mcnt);
-- 
2.39.0


