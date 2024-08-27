Return-Path: <linux-kernel+bounces-302466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99AB95FF0F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A431F22622
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBA017BC9;
	Tue, 27 Aug 2024 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="bxjcHa6l"
Received: from outbound-ip8b.ess.barracuda.com (outbound-ip8b.ess.barracuda.com [209.222.82.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFDA17557;
	Tue, 27 Aug 2024 02:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725682; cv=fail; b=a+yzGNFhAHlPKEUzp5Bn1A0ThQakiWmjOJWvgSf7tFnJiHQWJzcrBeChOFbGXeCk17QTHybxjHb/uzaL1M/oQZUVYS5ceOR7VfBAMB+QKvx4tfkeAG5W4IPQt9mvk6c4ZpaCh1pJZ+wIChYUkkMLeXYHACwi+Hc+hbBwAXko0LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725682; c=relaxed/simple;
	bh=idbL/CrTBGfwZmNJnvPhE9EbPGgk3UfbR9m5ABsBJk8=;
	h=Date:From:To:cc:Subject:Message-ID:Content-Type:MIME-Version; b=QBzx3/ETPjFmJshzOWxIrFs2YQnEQn775yB47mxnJdyNd6gnQMJDiTD64xkGtSyGr8eRiNUwMiDFtDc0amIlHL1Bm5SMNyxVB8gKkmCgCK6RzPBiZv6OH3TlhRBEKkkrqm2VEaTJRywM5lnAarQZ2fY7kuBcggPdYrTS9od1cWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=bxjcHa6l; arc=fail smtp.client-ip=209.222.82.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169]) by mx-outbound-ea22-15.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 27 Aug 2024 02:27:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THgiIM1n7JAqtyaphgTMoAUqryWlkoKwFHDYhkbka45vypsz6gBz1qynADl3Npws7TJkM4sexqgiHTnNCK9dB0C8azvrHrRjjGTGkQwt+AA8TqZ42ysdlJP9tuyHemGCT07QmjWr9T2VAbkasw960bIzfFa0UHeT1pPRTMgOw4Npykd4RweYPsXjxyhyGLQwLPXp1jTTcqVvE1qOxT2hnpvXe72me7j/GLjyMq6zEohPpZvEwWOts308NK7JtkhqOlC4XMkrNkL0h84QvmG6xbR+UQ1BHjIjKKlkRx7juNVSubeUQDFordF6Ot1kc+63O9CRvPhkGhbCSul2F7cgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPd0rzJD8VJgIw2m8ojLM4mcTxYa1xSWreBEvEoXSlU=;
 b=r6ShZHSLnZQEFIuw1lx3GIDmelwSKUUJ+w4rrpFAdFI2jqoRBPV151JrscCR1N/XjLybk0EwqtYkblOLXdrBurbaZn3ItXnrcUElBZmzGow8AhHSaHIyaIIdU5Y8XWEhE9lVjt9+J31FVe+uAlDmlFv5rLZtnyB+m2H9wq0V7gPTYLOdz2RoY+wbz4Rp4nqhh+5rt3E96IGX9PsSSZrYKMyDAPcm3mxfd8dR4W6B7vgD2Nu3lPsBKgRqZ1QJyz1qwi7t1VJYDYQDMiJK7/F/jG8IHZrzXi4MzZjZzHSDSQxO2Qs2GHNYR/rm2F0pgo1olcixIyYI7dgAmzML9KFJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPd0rzJD8VJgIw2m8ojLM4mcTxYa1xSWreBEvEoXSlU=;
 b=bxjcHa6luWEKfQ5Qh5D6vu+aBAki7HKvHwKUuuCZ/WjXG92u5AvP6DsQmcn1yXHIIX+1T3IS9V5OVyBvhE/36t2xeZha+UWTkItAkjyAMp3Mrue9+KO/8oolLUKAXVD9DB0w/XBQ6HfuJxKImCiEtaxQCOQi/l8r5QuaWDhB1CJLiUHvey2B6kk0VIaMEwdi/EZTc0zfeif0C6V5jeu+ArWTKaQEU/T8usPRleTP3MDdSSCCK0Vj0xECXmaW1E+lLsdXtdFL8fY1/1Z2YLDptisnp4bEFEd/uG1+aJUjdiSom4bW0TQpCXj0ghH13afsXX1C+0VhcHISPIeu5kKxwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from DS0PR10MB6918.namprd10.prod.outlook.com (2603:10b6:8:136::8) by
 DS0PR10MB7432.namprd10.prod.outlook.com (2603:10b6:8:155::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.14; Tue, 27 Aug 2024 02:13:37 +0000
Received: from DS0PR10MB6918.namprd10.prod.outlook.com
 ([fe80::3697:c0ef:caee:24ae]) by DS0PR10MB6918.namprd10.prod.outlook.com
 ([fe80::3697:c0ef:caee:24ae%5]) with mapi id 15.20.7918.006; Tue, 27 Aug 2024
 02:13:37 +0000
Date: Tue, 27 Aug 2024 12:13:30 +1000 (AEST)
From: David Leonard <David.Leonard@digi.com>
To: linux-arm-kernel@lists.infradead.org
cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: ls1046a: add pinctrl node
Message-ID: <1d7da01e-4f61-df0d-1795-5fbd78ae14b7@digi.com>
Organization: Opengear Digi
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: SY5P300CA0070.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:247::26) To DS0PR10MB6918.namprd10.prod.outlook.com
 (2603:10b6:8:136::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6918:EE_|DS0PR10MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 0afde38e-faf8-4af3-dd23-08dcc63ddc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g9Hqy6p3e9qGx5yFNNj6CUQ8h+rhjfD56WhnLGhIwoZDwLAxzB2nkXUW0Fta?=
 =?us-ascii?Q?1U1yEaqj+yKblGVZwmCDEPaGZ/FOlf/0J3tgpM6+7x1CbXza1qxb5jCbn8Ve?=
 =?us-ascii?Q?2eft2qG5Ng3yLDSlVuvotu13V4E35MIi/OD2NVIxoF+xtYA0HFC2S29UTw4f?=
 =?us-ascii?Q?fUX4Bw6J5sB/2Yq5z4xqgZCQOGHYBKfK2I5w6VGyL0M1H9wu56vpXuA5un2c?=
 =?us-ascii?Q?DMF8nyYE/Wahx+mI12bCv8faY3+kWAPLa30fIJHzyYjIWJkZStp9wQ7aJ3Y1?=
 =?us-ascii?Q?R7DKyPsuZfOqC5Ho2896C4qeknPbzj1UOSmVHZl8+1V+Bn6qV0raerFJjBy3?=
 =?us-ascii?Q?WuEPQa0Q8eWDGXiwHpOoRsAY4VCsqIk3C9QU/zLV/fd1bQUcl3fQeuBCozYz?=
 =?us-ascii?Q?TyDrSBm5E+SgK0bz0We1ddfRlwlXP98cw1OkVx5YfpoCCWknAaS8XbWJpWuF?=
 =?us-ascii?Q?CUYI6PG2mCOu+LujtiFXaUs6nqvhft2za7W0a8D01SF2B3fgbci3I/Ctif/U?=
 =?us-ascii?Q?AifJTr5DqW7+khOmHrEwDfLXGhUYlkMDwY0xwECX51tWWBsE4C/nzDJK48HJ?=
 =?us-ascii?Q?rN7NwcAzWWLy04fWxdOcWjx8vBuN8/k44Wq0Ylgj2qlccm4pZS+mKv6uY5jW?=
 =?us-ascii?Q?wzlOOPykGrMTqmqQSGFFRluEhBBsBKnn+Zd/qMFHvjf3W2CiXfsry5PmQH49?=
 =?us-ascii?Q?RdfkpiLjFoxu0z/Ju9B3NDX3EvPhrdAoVYEUHsqlKToxw7kqVF8MvhAeuAQL?=
 =?us-ascii?Q?EffkufrwKMMxh0tBo5EFET6rdHlSJPBLZBcGEpYb+8GdK1KYmDFQgmlqFqJZ?=
 =?us-ascii?Q?6DrpzHTHqqvDZPT7TnULzpYrImYwdYAiIMsUy7WPU773NduseDVdRTe5XCO3?=
 =?us-ascii?Q?VvWyWMw4FV+GXceF7UxXak8Hl2A2fm1d4JU1f+gRwiqXBkFSg82gnw06W+1a?=
 =?us-ascii?Q?PeQOAnD9SNEuQoo618906e1JTe/AwJic72V3aAj52r2gYcQD4lM3TdpzwyP+?=
 =?us-ascii?Q?oUKHudOtHTj0NfoIONzZQVUjhI7YPEJO3wa30UDbK22HdbsHajnhIHVxrodL?=
 =?us-ascii?Q?GP/GTXoUzvJOg+EMtEGt9svdcoqndCNy7ZkzKcs5Jr2SEyEDdVLnRka/JOSh?=
 =?us-ascii?Q?JpJcOkiA+pBtP72HnPHuabXBQVgQ9FDvDGRufmm4ATfu11EUhq5n9ekXttPy?=
 =?us-ascii?Q?nWAct9erDCf8XgjPi3OGXmkPpVP5I7xlqzcbqXgBR4ho6EaPHE7R/x0BBB95?=
 =?us-ascii?Q?5oFO4Fe/Zk7twQ0K1wAHwuTycMXX+c9ZFt1GIgCatNtxJvKoQQQ0d6bcSgE0?=
 =?us-ascii?Q?YOvwm71K1EIRM1M2eoav5WCGatMZgMACc5M1I6zueiSf/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6918.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KrjYhQwkG1veFmjdAFITuK2Azmf2u06x1DGmz+QjhAZXkP4Qd69wji1LAAsK?=
 =?us-ascii?Q?32xl+iWdvKmjyxihK2a4kDEGUv7vFSmsKR6D7JgdVk7InaWJOmReU21PVQdh?=
 =?us-ascii?Q?KZjguRZewKY2YKnMJ98591HmVbjtcye3WI+R3/YqzSCct6jd2eJ4t+Df4/XZ?=
 =?us-ascii?Q?baRnGos4kcB5r27NVIPm+nQ7MkRODODuIRHHE2ipyk4GScNgswsRPhmxSFo5?=
 =?us-ascii?Q?aS9K/6f+ExdOe9v0waFuLaWJBHMy6voEh35nqeKiiEuPYr6LIbGOJt1MMrpM?=
 =?us-ascii?Q?5xRgDohGYxqSfhE7hVwyzIdOn1+8sdUCdJW1y5Th7ru4XMY7IC6aOangK0G/?=
 =?us-ascii?Q?3WS88jodT215FvTNBId5BkUo5/+Igz8oIDTo+HjJ/iMhDczEC/KQ7hdUvm4W?=
 =?us-ascii?Q?VTjR9hdJaSltjqV3aDg48AnIkgomjqI+lbB+GLPgR/XPKYQeAUAShrTzR4E9?=
 =?us-ascii?Q?fC/fU/AEvgiLtr4yYofw/r6VWFk68qIaSYL90IOjNaGdKNxogZQQTPGp4ghR?=
 =?us-ascii?Q?sQzrSEpKMFBWH2csMnzDvhBZEJ7yoKFl5fgvBTUp04PUTCOS7i/H375zryL4?=
 =?us-ascii?Q?JhvLiCRZGO3Ius7hSvbfKoSMmK8sNB8Qp5LnNiXLquViYr5lv/IMjod8S43t?=
 =?us-ascii?Q?Tze5m0wyphAi3ys+Syk4qimdjcCEnYq5m1Rv9Efium+LLj+5IRlgHHSoezP+?=
 =?us-ascii?Q?CEpjRQOUasoqsJE3tmUt51tCH/16yihFH6iV+psDBJevALXHuLSHbU1tJkEp?=
 =?us-ascii?Q?GacKiE6Qqpw0CZoaLDbchyJLqq6upXcDnmz3J15/ZRk2abpkfclGtpwOKh8/?=
 =?us-ascii?Q?ftb/gPfAEyhrPE7GUDn2C+lrEfe1outdOPak/9/ST1Lntn4SWMi6uPMXXcF3?=
 =?us-ascii?Q?pQOIquyczoqrHoU1nzRO6dlPeSlwkZ/nJKSySflkeXXEVznIL2jhhaHwjFm6?=
 =?us-ascii?Q?tjX/eSWGesFncdXmRFEiA6vYjVE2DXF0VtAhT+imXDSj6rmq/GLQUkfL8WCg?=
 =?us-ascii?Q?8PbPCfLSHoTeCWo/q7RhOR0h6qgHqUz0ZNr6sE9OKcAxN4dFQJXkUc1pNE9a?=
 =?us-ascii?Q?JKuxlQCwhIR/2hAyueL7Hy24VfDe4khOZkhizy4TmNM7ayb51vk1mZp4Q/K1?=
 =?us-ascii?Q?kH6m+Q0O0mPPHwYClvMgrWgVQYo4KoE8iykNYm9VxDh5sNxW+2u8NQkx11oT?=
 =?us-ascii?Q?xAQcI1AVpHtXca7I/7/blSPSjQc5osC9ml1Jlc6F25fJj0IG/aUisqh2hCUf?=
 =?us-ascii?Q?eI0CkZ3ouPuJ045IQyNjfvXIvrZUfwP2Y3mPNV2q4tq7IBZztBk7tbJsFLNR?=
 =?us-ascii?Q?YE/Vn/4ySytl7VKQd1jFQYr90Rfh18wudhMho7APO0qD9RpFNAstd6pWXYhL?=
 =?us-ascii?Q?5vt5vtDtnSxxtw+aD57a8k7ct4Aj+IglhyK0+ZndGoA4GsUbsqYPbsasljIq?=
 =?us-ascii?Q?HfvpJmm2NgALjEkkL6P9yMNpfK3/ThDuhgRZmKpuGLPITP/nQnsYCdeBqFkF?=
 =?us-ascii?Q?7m5yjSXSxnL5dfeuAaUpkiYaZyMeWZUE1NtrfMBcSTFAsOkpNnM7F/xqxNpD?=
 =?us-ascii?Q?2SAYU9bPBEDR0X60hsIgIQngOtcBrwixXhpwyOO031pTZxTVQgZ9hBNwWzvx?=
 =?us-ascii?Q?tUtk/ODAMmGACJet+vrKCwrLy9MtJoIzKKHVJ/jL4vVs?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afde38e-faf8-4af3-dd23-08dcc63ddc46
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6918.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 02:13:37.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHRoYkkjZ1wYoXVVw94d5adYHnuX+IDbbCxqjrEEsOtwXM8quj5RYYsTomwbI/4yvgEHM2iV2fBLW9v8sBUSSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7432
X-BESS-ID: 1724725677-105647-3850-79065-1
X-BESS-VER: 2019.3_20240823.2007
X-BESS-Apparent-Source-IP: 104.47.73.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGloZAVgZQMDnRxNjEKNHELD
	nJyMjAzNIoLc3CxCgtMcnQMtXIyMhMqTYWAAvNyLNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.258621 [from 
	cloudscan18-3.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1


Add a node for the LS1046A's pinmux controller and related pinctrl
properties for the nodes using the gpio and i2c functions it controls.

Signed-off-by: David Leonard <David.Leonard@digi.com>
---
  .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 36 +++++++++++++++++++
  1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 200e52622f99..d2286fd6f972 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -350,6 +350,29 @@ extirq: interrupt-controller@1ac {
  			};
  		};

+		pinmux: pinmux@157040c {
+			compatible = "fsl,ls1046a-pinctrl";
+			reg = <0 0x157040c 0 4>;
+			big-endian;
+
+			pinctrl_i2c2: pinctrl-i2c2 {
+				groups = "L4", "M4";
+				function = "i2c";
+			};
+			pinctrl_i2c2_gpio: pinctrl-i2c2-gpio {
+				groups = "L4", "M4";
+				function = "gpio";
+			};
+			pinctrl_i2c3: pinctrl-i2c3 {
+				groups = "M3", "N3";
+				function = "i2c";
+			};
+			pinctrl_i2c3_gpio: pinctrl-i2c3-gpio {
+				groups = "M3", "N3";
+				function = "gpio";
+			};
+		};
+
  		crypto: crypto@1700000 {
  			compatible = "fsl,sec-v5.4", "fsl,sec-v5.0",
  				     "fsl,sec-v4.0";
@@ -537,6 +560,10 @@ i2c2: i2c@21a0000 {
  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
  					    QORIQ_CLK_PLL_DIV(2)>;
  			scl-gpios = <&gpio3 10 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+			sda-gpios = <&gpio3 11 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+			pinctrl-names = "default", "gpio";
+			pinctrl-0 = <&pinctrl_i2c2>;
+			pinctrl-1 = <&pinctrl_i2c2_gpio>;
  			status = "disabled";
  		};

@@ -549,6 +576,10 @@ i2c3: i2c@21b0000 {
  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
  					    QORIQ_CLK_PLL_DIV(2)>;
  			scl-gpios = <&gpio3 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+			sda-gpios = <&gpio3 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+			pinctrl-names = "default", "gpio";
+			pinctrl-0 = <&pinctrl_i2c3>;
+			pinctrl-1 = <&pinctrl_i2c3_gpio>;
  			status = "disabled";
  		};

@@ -626,6 +657,11 @@ gpio3: gpio@2330000 {
  			#gpio-cells = <2>;
  			interrupt-controller;
  			#interrupt-cells = <2>;
+			gpio-ranges = <&pinmux 10 0 0>,
+				      <&pinmux 11 0 0>,
+				      <&pinmux 12 0 0>,
+				      <&pinmux 13 0 0>;
+			gpio-ranges-group-names = "L4", "M4", "M3", "N3";
  		};

  		lpuart0: serial@2950000 {
-- 
2.43.0


