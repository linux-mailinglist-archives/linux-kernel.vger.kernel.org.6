Return-Path: <linux-kernel+bounces-300677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D3D95E717
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C321F21A00
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5272E29408;
	Mon, 26 Aug 2024 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="It0FK7Yk"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2057.outbound.protection.outlook.com [40.92.18.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41E6F2F6;
	Mon, 26 Aug 2024 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724641003; cv=fail; b=DCzJypr2jvf4hr3WXBWrEuO+yijbK4ZY+d4Pag4weSZI4/dmIWkyiApj/lqijIDOr/rIO2/2WBNBantnsJUhWZKNKexVDp8uD0DQv4ZslVT/E/jaZsPRsVsKDEwqtvYpQ3F83UjmJA/MFNneE6Pq+pris8Pc+2SseBr+JhxeKhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724641003; c=relaxed/simple;
	bh=Ad5pnd9fKxleMnAwBrZGuOXypZS4OwbSLzbFyUFxlL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AmOjfrPbl6LSnJy2dFhTobT7BfjwJPglLhfQy0Xf9X9cUASHS9RlD6w1aFdNwCZduiOx+Pv3pNUjeyGoRw9aSK5NOnUPlsnZ2T7RdnRUF8dzxFHui4pYOtQ+5WIwejXN9TNzJjBbDpTnC3Mag0YawWu3WDVImVhb13lP3VjvG0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=It0FK7Yk; arc=fail smtp.client-ip=40.92.18.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTYL77voAcnnFJiaccQSUvIVbZ7RxL+V7zoBGUzED47TO+vhukeGRwOO0GffGPkjidcP5269EyfijQlt0WlQtCZ0wla/csrGdggaakQMeZ2AUPHHCaNlcvyuZaMALEIsX4ty2clnKyvINRnPNgAKS2A7/G8lMzS4V6kVasz6Z2S+ZhrNFf1+PQegIrU2k2QcrY2MPkpucgwzaDNy0BwBcCHZEeomEpkq0xXVBl2/lqxFF6mu/LPkxSKB6JrwlGLZkGg51xMJpwTYpIlB5x//7ecmIdJ1J8wZs4DcN6cLRAHOP4EuSMPWpkharmO1QRSEzXyigHdsG14ZGZwyZSsZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE5KAG6u97A1XDtdRa27fa3TYeVRdGHoB+D2kcAekvc=;
 b=JdBMwqM4O+2UWFheDta7HAgnofKr6o+JBsHgSGaJxOh/7PXzFwXI0P1hF4/93gj15ExxyBBAa4LWFlspjMcZUN5PyMBqUyH9nDxNZZBgN2vtwtPOf4jCGzsCj7VQfhfRHe1cPuiuqiglHbCKtrZ38wmHU8mOePuTrV0hTOPlU80hYLz+AQwLE5wNimSV99FP981an/08hQXZMHFkEZNx0UWmHtSsBRaHiUlxzcohfeard1cM+aAuPuuvLBReAgkqOrcfF3QqJ/cznZqZAMd4eZfJLyEny9KeCuaWDdsq+6V3xuNCILbCX3VDYi7plBMWAb511a4S8JI0Xc7sCJHbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE5KAG6u97A1XDtdRa27fa3TYeVRdGHoB+D2kcAekvc=;
 b=It0FK7YkJpFDrKKzRg6EAUxhYtG1gdfKj6MqYs/WfYxIMw7yTUtdRqcVfIrrcX72fCkqxqaS+PRSy7LCjNig8Nht+3spkJlUp6WuFBFdDjooRGQmhGilVqLWk8d2OO7/mAJ/nspYmBEtQO8h02qqDqGcnnskuhJ95mHmr/uTmTDBaRdVbNsQkaKzU6EsI1JStyFWpZrFSUmoRQyqW+bVoDLXyi+Ilcj/DcXc0RphXrVtqGHWbG8qEzGQThjfFdIMXfKTa7nnOJ9S2iZa2WkAlKkvz4iu3St95tL1I0J2i+95QaELS0joiCjT+mP9Iy+CBwicLJ4JiPF+ikSY+TvyZA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW6PR20MB6742.namprd20.prod.outlook.com (2603:10b6:303:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Mon, 26 Aug
 2024 02:56:37 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 02:56:37 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>,
	Conor Dooley <conor@kernel.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/4] Add board support for Sipeed LicheeRV Nano
Date: Mon, 26 Aug 2024 10:55:38 +0800
Message-ID:
 <IA1PR20MB49531ED9F5A8F685E1AE2692BB8B2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
References: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TMN: [jkHHrsrMHvfL1wznLstqa6p/fD+tl5IMVKwoYrIBONk=]
X-ClientProxiedBy: TYCP286CA0122.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::8) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <172464089405.43748.14986659500049351960.b4-ty@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW6PR20MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b235ee9-cc2e-429b-7c70-08dcc57ab398
X-MS-Exchange-SLBlob-MailProps:
	0wLWl8rLpvuFPcexptlQQ31fj5pwhFvfwTfX0MCrcXMY+7uVifDtjdAzdbqwRtR7qJJnTmPdrF/1Q21torFei/vmB5uWdo2wIgtAJ1GdjoJLGClTLiu57AuSX20Iqnq7m3XzEMKVf9cppem4dxpp06fh5fHiD3+zvYAXZL73e2PCB4H14wiysDdQUo3Cbtql4vxhQ34utgsDBLhfyVoKvyn4uIdhj+ZafsR1oE5eLd1GyVax90jDm2DyiEgbZF4/eHRm7IsQjFf029aNRhifxRgMQ5H66S+RTV7/InzMNdOqcdeSuTQ5Tx51sErglgkJRzAbUEpZo5VM5JKqFgGJuOrwhNfCcj+uimsB8EzJdKr/LYtY2GQHKoGny6nC5xiBSpuSBUMBes9YrcBMGTF2G2EcP/VoWSr7VQEb9pDwYlWe2cExLDdSdvJEON2XsktmZYs/4nKkG14t5Lrw+VzlslnV5535yH7Rr3fx6qruvH3Ua2gbGUJJxIDgu2OjfreJzJ5C+xhzLwdhfBoTSgZtC8wCPn8b7Sz7Uag6WT2Qo58Lf1j4qddNBCiik+hmLDtdj5sKOclaAUQ3d2BiCXyVdJAT+Rdv4maX4j7giJyG80KO0rZER0xW9nSHHDQI+pNDe+2CViJdJg2pTZ+XC5MrcX3QguCKeCRFJIZzWgMOnpHsxHRXQctZCAUadQQhEN1Hbk4QLWHjhDjMbSE/YTwyYrE6MAjoWrHaQVTVo2PeR8XcRGtLEqUQ2xTOT3wtxxzqsgupU5Y9Rjo=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|15080799006|461199028|1602099012|440099028|4302099013|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	i/Y97YmFpOu48XlSCItazO/NgskUMZfrWwjCnSWDwJeUCUQXyWAlLgeEKqOsg5gN+VXc2ZAUAHRGBg908Ualk0lVXa6unv3EUlnoUOzg3mJOJGMWvhoxn/Q49y+96FS4foLDsKP7wRgAumLsbB6bsL6H/o2eESuGbISp71udPawvChEdBJQMpum/TgE7uPReWTtm/7uUQ5McyvEwGPC34WcDPcXunJ2T40H3Az0+Rnh+KgC7YBLce/fnTdXLCnFUPKRWINLE5SNVDFU+efFdtSwP5x7Cz16QwGRBQv8U1INZrpJ0SiMODO4YHkf4UkQAG9q5ywgFZadYE04lUsisW/6Q6zQrZpRh1u/Rr9HnGe0WePDfHy1PT0VXbmTsdloXzs6Gumtl0DyQ1r+GTc1y1wTIPQAuqhnH5DmY0jiY5KRDqx/6/2fseCJNAehziKHC1oK4jC2htqQt1r0HLdfrwfOBZpOimLFj7QoU29ePW+9lp9fslJtVJdEn9vfGwoUVw86DIWCloHulxoDqL1CYTH3xFPcbWatN6AyvWKdyvgBaly8Pi417SdfYpCMbtHKGsJPBdoxrPxhoLHBRuX+idTmrxbTsDmErbomhtkMbPY+60RGi2gXRSu59tY6+iPoI/MFfPpLql8XhvspNXxkA830JbEF9fM3f21UY/LPF029JX0Y7WDD/RugD/l7ewDp2WCjBgM8blmmaZevCHhgo1zudGdjxFuWyDxPIrcUltJRkAWEdWr6c1AWp70hOM0lMCw5WkxCaBJmXM1cd1AyK/HtWMNvK9DpKfYndDS5/509cxMoE1HKUSEc7CupBcr6LKrIx93SWVdykDul/K/mDiItMNdGNlm8xgJMWcogk69Y=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmdmRWdkNTlVNytEZkhJWVlrVFdUZmVpQWhpQ05GNU9QMjZQMTVFWGJTSjJH?=
 =?utf-8?B?VDRzY0VpWGd1cnBEWFp6YmU1bmRUMkFWTUJJTU9sYklydDExZDlQQUIrclFk?=
 =?utf-8?B?UzA4NnhVU0szcVFteUptT3VUa2ZoQThCbTA1ZUE2KzVXNDgxR2tPWGdMR2xX?=
 =?utf-8?B?YWExL3l6N2JxMzFqalhHUXhZL3B4eC80eUNmZXYraVAxVWRHbGZRaC9IMEpk?=
 =?utf-8?B?V2xybVdSU2x1aE9JSWh0bVBFL1dYaVJsa2IxZTNsR1RDRk1kejFNekNxR3VJ?=
 =?utf-8?B?emJadlRBU1UyN2g4Z1F3WTZveDNQUm13WU1VSlVScFF4Y3dWOWZyVzY1bFpJ?=
 =?utf-8?B?TVlDdzhSRkVXMEFmME5xZUUyOVVoTWllUVhVNFQ3NXRPQWp3bS9DK2h5U05l?=
 =?utf-8?B?UmFYVHlGbGdYZnRERkJuMkp1ZDF5endRZ3ZyMmpEdUU3N05nTVJad1l5eHEv?=
 =?utf-8?B?OTNWWVgxbGJrSnlkalUzMXh0MDM5bU83Kys4RGRYOWJLa1FlQWZzTGZOaUM4?=
 =?utf-8?B?NmVKTzRzeDVyVEJqWGlZM3VlL3BLZUVvUGVxR3IxMUpYS0lPcnU3ZVlIWGF4?=
 =?utf-8?B?ZkRMUCsvVTdwV3lJSnM0a0ZhdXl2ODU0VU53RVFuM21XMnlzT0FsRE5jVWhI?=
 =?utf-8?B?cEFJRUF6anZCeW9GTS9qb0ZJYng0Q2ZsbVFsaWVRN2ZDZ1hmUUsrN0RVWVZy?=
 =?utf-8?B?SGh0N1ZvS21aNUcwYVhObHNvWDUyT1FpWW43N3Q5bzBhRWJsT0YyTmpZMjVu?=
 =?utf-8?B?cGQ0bmJvMjQrV2Y4U2g4L2N6WFArZDFKS2M1MXVrRS9EZFMzeHVWdFBwdVZl?=
 =?utf-8?B?ZlFTM3dYR1dqWWd1RFo2OEEwUklYZlV5dW1NcjJCbnhSMVYzZXl5QTNrMkNx?=
 =?utf-8?B?RVFVNWMxSkw3Mk85Umh5VEtzUFcvZ1ViS0w0dlN2WHd0QnVCLzc5SmpYVVV3?=
 =?utf-8?B?dlh6eDlEalpHS3pyVlJyZXplRU5rbGduL3NldS9lanArVmJwNFZWSUdoSWFo?=
 =?utf-8?B?WERnb1NQdGtRSWxuSWFiWDdXNXhkZDZSclVDck5hdEZWR3VWTEFtZW5tbkNl?=
 =?utf-8?B?SDZ6bFVvTVB3eGgrMkgzRWdmblk3K0YyeDgzWFNYWDN6L1pnUnFRcVljYy9m?=
 =?utf-8?B?d08wUkFZMzdyWTNpMzdBd2RJbnMwMm1TeHBYOFF2NTZ2M0FCOUFVb3RYTEpq?=
 =?utf-8?B?aUpTd1pKVno0M1FqQ2J2ak1kbnpmOEVlL3RjYlJTeXJ1ZXdDQXdwWVVpMjBE?=
 =?utf-8?B?VmRZdzVLZUtoaExqaWpXRGczekd4aHBZY0hwNE5TbGdrN1Rpak8yM3VDT0Mx?=
 =?utf-8?B?c0lBZ01lZFNaUFF6djRUVEhJUmE4SmJVOFBoT09YWVdtekdiV1J5RmdaMHBN?=
 =?utf-8?B?VGNPRmlDMEppQ2xneXJ0Qlc1V0gwbmVGeTA1UTN3aUtNK2RlK28vdGpuM0Ry?=
 =?utf-8?B?SllVaStMU2t6R2JwNWtrVHcyTWtuRWZvWE93ZEoxbUcvaVQ0bUhhSlJKeFNI?=
 =?utf-8?B?eExJT2N1QWIxeFplZHpWWHJRMW1mSnNoc2NBaUJNa28wejQ0WDJ0MUxPd1Zu?=
 =?utf-8?B?OXYxUEFLVWNsbXJKc216ZWRNTjVnQjlZWlcycVV0TXIrQ3hSaG9mRHVKbGxs?=
 =?utf-8?B?QlZwSUg3TVp0RVI0R1hOUG50cHRWOGlUdk13bGZNQmlGbTNWdTV1WHVYS3FP?=
 =?utf-8?Q?7RIoPz2Ju0mSTLDA6XQb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b235ee9-cc2e-429b-7c70-08dcc57ab398
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 02:56:37.3566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR20MB6742

On Thu, 11 Jul 2024 12:01:27 +0200, Thomas Bonnefille wrote:
> The LicheeRV Nano is a RISC-V SBC based on the Sophgo SG2002 chip. Adds
> minimal device tree files for this board to make it boot to a basic
> shell.
> 
> 

Applied to cv18xx/for-next, thanks!

[1/4] dt-bindings: interrupt-controller: Add SOPHGO SG2002 plic
      https://github.com/sophgo/linux/commit/866e86d73f0a1bc4e482162276c4e9765597362c
[2/4] dt-bindings: riscv: Add Sipeed LicheeRV Nano board compatibles
      https://github.com/sophgo/linux/commit/4ecff14f1a45f82c60ec77d2662e439d088fefd6
[3/4] riscv: dts: sophgo: Add initial SG2002 SoC device tree
      https://github.com/sophgo/linux/commit/05949703b659b138a9ade02e456ddfe112581457
[4/4] riscv: dts: sophgo: Add LicheeRV Nano board device tree
      https://github.com/sophgo/linux/commit/c919edd074714f53763cbfeb8bdc9f1accfa7f52

Thanks,
Inochi


