Return-Path: <linux-kernel+bounces-281791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8168294DB60
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59EDB22137
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09FA14E2CA;
	Sat, 10 Aug 2024 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UQb58pLH"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2093.outbound.protection.outlook.com [40.92.47.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753714D71E;
	Sat, 10 Aug 2024 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723277091; cv=fail; b=mQ7HA9hxJbxdBwm70Gxpan8s71RchUMMo9B5yav3tP8LtRNbCMDzfjlvEnp1FF4WAVQDCLI1VmMm1YXoKRLlhZdaGyop4GSmSwy6mGagJn5N1oOiu9UKqst1xMx1br+t+g9H4quhTGT2UA3lBdkwgKJCzYvO0wtgfZZhors2dpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723277091; c=relaxed/simple;
	bh=0RQj/2N28nLENxgeeuSHKE6QLsW6jiwxyfSICCm/3gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KNZNl7t3K2v3h/yrXzgBOCIOXsC8y5Eao62/1H0SiRhkQWDm1Tm2dvi78nx5cxowNhGs5TLA4YoYN1Ku8TSW/XqpBuACsDTnuGAu3/fWS3xq6HXKaI55BRk9Fb66KpoarQ/FX0QOyIPkR2/Obzv4XFjLhFqWIi42vGeqclPZc9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UQb58pLH; arc=fail smtp.client-ip=40.92.47.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwrbVoWb4Bh84L22E79TnqKWbjpq2sszZveJgfyjogrFtalpoh8FsafC6H6JkIyGGIyKUmC7y1UBN4KQ+juOT0gRWcHAwntOnggGlnlIyksrpx8zwdhFSqD0VuWmUy3OrJ7WwQgtKE9bS7F7hn/YakVdRDZVGkYnfDOpubVXeDJM6dkJLUQO33HlBflJUUxUKd6Ly/XhTtgPdAwF/lA/kd4eUcGwehLqolnp0fRc1jAQwLzFmv0wHzGZBuvHbU0/D85REb1vCfKjnMjt3CpP1W0ybiwiz/UEpl0XmB8hiDW6S+Fxv3xM/YLp86kQ9ewUCBCRXTIoAjayJeK8Dc6k8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1jAVsTw8hZ/KN1DR2QpYyBsseR5e1kBRaw4LadbN7o=;
 b=WFB3xEZl6o+DnsCn612HvFuNoljnXLUzkDC7JYrW1+oZJ2XJHb8qPcfiGekJAisSEoRQxpQkL9gIClbPXxkhbujiDTSRXXbu1iLS/2tUC8vG2/f3njsC3RX1mGsowWANtdcsfF9d414+zP772F0yswreeHu6AT9RlBZLFidTuBOIyvMhgGnauNPV8ECt9Kd9WI1ih88moluHb9EaL//OOxqSD21j4UwFESnoUX92vV8wLleZ8wVlNRSdddvRM9Lcn/g2soHjrSLcvfmdjBTs8MykVoRy0TqvziWg/EozxXd6WeBd5VPo+1sHLsikH4s/miBqBlAIawfKMp/tJtYwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1jAVsTw8hZ/KN1DR2QpYyBsseR5e1kBRaw4LadbN7o=;
 b=UQb58pLHAxPMMGDhzCXQTz9CiGOmSjy/A8IREEGfa7Yh0otSrQ9MeH2EaIB2j9dOEG2s1UGGiicrPX1i5RVXGnHId9mGUC4kawWyTflg7PL6NRdbF9M/4GJSemenHpjC7N6gBJ4dSxxzAELeNZWlBKpEGkFeEJHtYSoz2n/zjyEegHvrTvil31DVu5+JE1tH7lt2j0H51A2soOkWP6vmSGyuNKJsD3I8UfEw4vFmHdt0y0j2w/bH06QYyXN0qzVCeTiuZsIip6hTGUweN2csKd2958jSyFFHfWD1oYIUxunH3fX6PK+F6tc7fH12mcyf98L2c6XCrYA+0AO+0kNXvA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5117.namprd20.prod.outlook.com (2603:10b6:510:1b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Sat, 10 Aug
 2024 08:04:46 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 08:04:46 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v10 4/4] riscv: defconfig: Enable MCU support for SG2042
Date: Sat, 10 Aug 2024 16:03:53 +0800
Message-ID:
 <IA1PR20MB49532638EA9CA53CF9FDAC8CBBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [zwc/UzstrbZaMYimlA/zCxx/sR3eAmlebfUckKOLqhs=]
X-ClientProxiedBy: TYCP286CA0109.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::6) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240810080354.387820-4-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5117:EE_
X-MS-Office365-Filtering-Correlation-Id: b70250ef-b498-4abc-7997-08dcb913196a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|15080799003|5072599009|461199028|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	cyrXeCkvDrd3eK3sPB4sKI7Eev5I7qqTyzXVtEX2Reb0blThX9A3yXN/Ns8GF8KRUGOpftW14UDhjB/TnS/kGwduJdtbxz9ab0Fov6YYMnoXUNquqmVhDee1VrE3ZzxBVsEEefcNGNJsd9nBZQQs+lu2ZpfROgjHD7AuDj8iDp08fMVVaMs2/bEV36CjANWv6eEec/EqLhNi+o5nOvyQMmgli256mYL5+h/MY1Qbykwt4jgvfRB2mNcMFzmw8T7v5mZOnNlBcE0+llRWnEuOOMXB+/D1LBOdJJFe4tcijnpr4ZWpY5lcOp9qmWuwP4NTakKGMfiAofcOlZSDJg1GuFme8p0qCXkVMxPtA7ei8uLbNaKqHJ+bNRu1HISgsw83kccz9tEfTaN86qSCwOWculupXNZLslyHmbNFkqiU9uSERFL5EnLi8jTiN6SgmthKs8IW3tSMES1jeaA5hA2w79A86sSejRsacYJ1deGYpZ2aPHrH013lfhdXwlfOrft/uo2gog/PKmdoVN+M2Ps+u/p9lN99BbSPyoreQVf8cD8Jro/ud5cLCZBAyEBckIZP6PHnSxx3/4mSDqtNpS7Sr5s9ECwgofC0fssSSvKnqU4TpIG0Yk4WtloRK6PEi7MhIwZgoKwyg6AfeU6mehFwYr4zc8jefhsjxIt7WSwKdDQoMsAVyYeFSRK4eqHuHNoW3s1Vpmcs409JA8vZ9GKX2e0Ojg0gaSH1OuHyyXVj/0U=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PkzeE90EwFz3YzXEUt7NSHXjEgXkRimiGrteI4e8CAcmSQfo7MlvZOg0KZVi?=
 =?us-ascii?Q?ZHXFlrBZdV+HYlVM0G6I1jt8S6kw2Ie8udbOOjjhz47eBj5VYbbKMVEG2GL8?=
 =?us-ascii?Q?1odq2RBHvl2jiYYEUdIKYz5PGlGQUUyUwQxNdLG5CKE7nO7M6Mmy+Vam8yut?=
 =?us-ascii?Q?XSy8F7Ya7V2CVS4wG3jaqvWVq82NhUqD85qs1cmXFOyo4mMhXDpb0p2tGVGl?=
 =?us-ascii?Q?vGhNIh0uLRxcuBV1YoOrVKK/d/lYrDhVMF7ifW9fFNCrhJZTPO/dG1xo0+9V?=
 =?us-ascii?Q?FNN/HmzqgI8gGcLoozjkXysbd/5hbiBCbWXUjl4jl2AanuTYjq2w0MUJAiHz?=
 =?us-ascii?Q?o3xsQDqXM0TGRlVroJ+h4pVBp6CQMWOTLksTETFX7THCfd5VPoQsWwOJkmG9?=
 =?us-ascii?Q?0AAvB2masNYhOCrNRAifwOFxUVIpXIEBZiaJZxKMUKcoCgZ3Tafleym8zeur?=
 =?us-ascii?Q?ONZymgVmDHTC5TnFASizzvGPjwn/9GrzZXOnY290yhmyjnljlubkPQJJZzTR?=
 =?us-ascii?Q?tL4Xy+3qZ5DGKYe9dLtuF1p0KNK9Cfv1daWaLUriPHA6vg/RV5BVmDPAaTt6?=
 =?us-ascii?Q?D/8b8m2maDWOBRxrele+r68F3/iaLrlHlWfL3fYQQroNqKXhHynO6mF5OWiy?=
 =?us-ascii?Q?uEOlr25VrucddzvCXoXycDWIGGHkPiuCMvyE6CWLo4yFHjkZ4I48bnH0hMSx?=
 =?us-ascii?Q?ZWmQKsvzlnh7c9wqG2xdFjb6Pq7AP6J8KMvM2qnHs0extd4lKCqUF5iYsXjB?=
 =?us-ascii?Q?6DFYd7yI7xM8Zx1Y9RnTvhU+YPBD9Zlwz/QYojRkWwVeP8aFbN3miNZF6MJ3?=
 =?us-ascii?Q?v0pcZv4+Rbjjam0EP7BOUV+fvZjF0AUO9JLv4BLfaxhgki9JDPiucBUbFTGP?=
 =?us-ascii?Q?Zbdih4ZXCuNMlF/f5hVO/W2cSTUVmO8FVmS7qgS39PjfoukcWC+Yid6qY5Nb?=
 =?us-ascii?Q?AjM6rBkQnXMiqWPAwvVy4wQWnL9KneZ1K/NMvm+QalBQaJOgfvZ1ag1xb35u?=
 =?us-ascii?Q?LJcZjTjKBZVUGpthCKjOFz4XeSCZL+KnRd0MlaNa/imn90HkV2P76umiaFS4?=
 =?us-ascii?Q?D8jWPkWrS8NbaC0SWetJpFLRadXjdXpLWLa55EPJ+i2libZ94Wrynrmt0f8a?=
 =?us-ascii?Q?PDJWkFzakbJb2JWRt1/NCI47CJ7Lndvj2e8yC5e46BBRh9MHGkk4sl+DhdV9?=
 =?us-ascii?Q?bhQF8Ze3VzQT3ZyIW9jG3LX+WmW1zdePwurRwnqlSJDKtXTNAca1uI5RSagI?=
 =?us-ascii?Q?wrO5xHmQfgz4fZQ8g9bj?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70250ef-b498-4abc-7997-08dcb913196a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 08:04:46.4536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5117

Enable MCU driver for SG2042 to provide thermal and reboot support.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 0d678325444f..a0f346301df6 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -170,6 +170,7 @@ CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_SIFIVE=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_SENSORS_SFCTEMP=m
+CONFIG_SENSORS_SG2042_MCU=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
-- 
2.46.0


