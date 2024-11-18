Return-Path: <linux-kernel+bounces-413350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73739D17E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34972B23ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D00B1DF75B;
	Mon, 18 Nov 2024 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JYLYKSNz"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2127.outbound.protection.outlook.com [40.107.94.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4DB1DF273
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731953867; cv=fail; b=u0H8Tlu7YDgMDZiOxSKw+XOfQf5CABcHguvKxjRGG7vXFIBXitrZOGU+DHmehyXUjEQtZY1pCE1iGvmbH58csgXEF3PoNB04mdpym37PeSdVw4NldI0MgrAiTbpIzrvOvIgnH+TkvMKyc8f1483URC4p306eoPIkhyCMfELW8GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731953867; c=relaxed/simple;
	bh=aFFAZjM3ZMTkSGKrwYfYX6uLXPkTlUCGcAtH2DT3phs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lkd6XBuDSS0eetZbzXTM/OP6212ZSFpIrju2hC78TDtY8+yOuPU1g+GWWVh+Xbcelnws4nT7Ue/qRdrmJ2/djDEuWUpI2S2kCy1oa2x+O2cbfdOt160IIUFob1RYMLA7uK5R7viok3JfYMfzAIFwdrQNEOv91nqC9mDO+rAKyo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JYLYKSNz; arc=fail smtp.client-ip=40.107.94.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hi7zeUyZqqupLF2Eo13vUeAYErRz/DDn8XpdwzPIKT//WjNAsXsL4qFo+x/xSZVY7cQuMENtOpwWQ1nOdSEYniAkox7NP+yKyW0SB+AFfH3BAZ4gQZ713nBNVg9Oq/kLfny6+rPj+a9ctCFBSC64AQckZH0V/9Wu0hnxchYHdu7lhGJWg0uJ+oCao3bO0x7blK9TNwAbEMhx4fElTaFR6zNCtqYywDsc9kG3lMfraZY5eb1CezmhfS/2V+k4LDTD6bBdrB9/35YvuaJUWmLZIzowHVpHZE+jxkKYd15nLjj7yuciyCSD1Anqb7bgvJkwFyCr97Lbpk8AlmRBfQ6m5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMy6CyGxIl2yyFuR4S4pWWa5p+rMXlhUtz651DwcqwQ=;
 b=U9TDf9H+JuKlyCMcCGFkitK8uqFAkNnqHQ+LC+8aD/PjfmjYXfMyfg/DIAv2TrTOaRUgYj2BwzJ9WoWVFGA0i68q0+RpaOFq+3umbTMkUETGj8jMIopN96FCGRrMshNBnbj8cOBqIlUBKX8ARZlNNb1OT3pUAOeycxYpC594aa3//paUCUd1cnNoFBBkx2SkUel20LMAIqGhsfW2cGqxUCLS86T0NDIbrKEzBvDKwujhavhbIi5U7VAcRQou14XU6PBuSHb00euNfOfy8gJNznd8eTRZ9Ohkz0v/WkF0uoD1WpCJe5zOmPBxGt8FyRNixZdiB5OQx1cT3Rs9+/hBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMy6CyGxIl2yyFuR4S4pWWa5p+rMXlhUtz651DwcqwQ=;
 b=JYLYKSNz6fD0PyStP2uk0RcgebJJRAacERu9FX7RtjCpccxSgRDJSe3WFVGDaw9fRD/P14nMTu+2D/8I1Kl3CNbux4ckzLugJr8onIa1bTr8I5DqiSHf9hlE5oTDEargi9uEgM2cuHfSdqLl+JPydBK5X5AS9blXTNFX20i33tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO1PR01MB6694.prod.exchangelabs.com (2603:10b6:303:f5::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.13; Mon, 18 Nov 2024 18:17:41 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8182.013; Mon, 18 Nov 2024
 18:17:41 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: cl@gentwo.org,
	scott@os.amperecomputing.com,
	yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: cpufeature: workaround AmpereOne FEAT_BBM level 2
Date: Mon, 18 Nov 2024 10:16:10 -0800
Message-ID: <20241118181711.962576-4-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20241118181711.962576-1-yang@os.amperecomputing.com>
References: <20241118181711.962576-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:610:b2::13) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO1PR01MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: e78287f5-fcf0-4a65-e06a-08dd07fd4a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P1gMl1sy1BiyWADik0Ii2kIoNw3t4O8mH8WT49zKqcICZVBIEwH0cwFHAJQP?=
 =?us-ascii?Q?2h3vU0lK4qQsplUdpyhuivL7MEWYOllIhG+6fI3ln97CFzi+b9S43EUEDQ+s?=
 =?us-ascii?Q?luhk07xTExiNhif3Y/T65zYTGbHIlM1cKjcwBOSPgiBr+1gEirn2LTVqj57+?=
 =?us-ascii?Q?Zc62TFGw0+2kMEfe1zb2LRDF8xCtnbhMlmDfv8m7Tm+OkHK3tlAL4Zzf4Pal?=
 =?us-ascii?Q?YxIjGDysqNWNhyJJV+K1GmaFshhWt9X4mvhVX1kVsqPlOaAd+bhAtqoPWWV7?=
 =?us-ascii?Q?HfA7r8Qoqgovzj0tc1PBEEejBVnRzg4j4ZSVS3YmZZI7fe21DJfeO5+tllyd?=
 =?us-ascii?Q?J/runcbBJN+svuGcZeaLkMpVrGHSPv7IAWUJ5pWjsfpoJLfOl3dpvB7LAHt+?=
 =?us-ascii?Q?A2NLVA7XE5i0eTBxzmKKSal+pbwOVee3cueKrsRYBggDpLeW4o7I9XY/TaMs?=
 =?us-ascii?Q?B/tzIsVpOwfMmr0fXThsx4NYXD1+117hJLixZ7J2nowGtyHZZS71O9C7CbkQ?=
 =?us-ascii?Q?w+fz0PgcbHQHmqrrY924PwVGZvxCBl+yO/4wLdJ7BbBiU8RUPbT+6v0jjDGL?=
 =?us-ascii?Q?UWyOcMAGkxE2KsQnnm/DgiyNrb/nq1QOiu6oeyouRCjUzQZ7Qd+xR9DrNh0F?=
 =?us-ascii?Q?pI1uDk3V/uR4Eisn1irAmR17MnFqk8mBwnAyEcoqZyMbPVkWaWYT6OgN6xoS?=
 =?us-ascii?Q?tLfFpQV8k0aagBQxn6wiC7bRJvW0uqx28daowZqMLtZqd3zVFRwWnu2hNYoh?=
 =?us-ascii?Q?K0HazgOMl5qKFYePznPGRppkq2K2Aq8SDxISsxlcBGkaA9wB4UH/Q5V4nrLB?=
 =?us-ascii?Q?qcxsw31524O0kzrgaalLKxEKcG5CBhn1dRSJN5GBJIxFYf5Ftlrrrdmp0uv6?=
 =?us-ascii?Q?qMlnDfCuRqMnJGW6jAEuuhCNq3lYjiF+lbnuTIFL58rMjaR1IKumC6OvE7HK?=
 =?us-ascii?Q?QUyQME2iPFlgvr4Be+5vlBTXvki1dPIMV9g3iO6Yod4ZkRezh5ikVm2aRaCt?=
 =?us-ascii?Q?lPAInTm9OmWvqAaCs8r+GVC/OU9Pz0i2DhE1g8t3iiqE2BjEZgn0GMFzI24d?=
 =?us-ascii?Q?BOTEjx2GR6DOmxPb0gLexH5X3JtXaubkj1XpN1OdeLY0eS9yQLuNGMZC5F7y?=
 =?us-ascii?Q?A07/A1iRTavugnK+3j5QEmHxZM8ZEoT3phzSFQVucGf5vYSRCG1pcKepzOJZ?=
 =?us-ascii?Q?fJ126ipKD7eOiUgLLv4h6gRE2befFCrgQN/dv7MHz0MWAiZtruK2TmykHfqm?=
 =?us-ascii?Q?1oxnE5FvVYuqX0veygaDOX1rBxzkwAGLVUlMh2CvmxGgQvw2d/h8/cqV+YLD?=
 =?us-ascii?Q?sTkL8a8lQup/5iUwh3h4/QVn/VPUoonNIwJIqRN5nxVAsYjXktVsuilSunPs?=
 =?us-ascii?Q?2FgmxjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9X/xPXVQ9qv6qgJ2Vp/i1qBP3x9nIfwPp+GeKpsyxHe8+/lUHTYc4g77+hnp?=
 =?us-ascii?Q?Ujm+sFyw8jleT1pgL7k5IHFaRQt0PL25yjdt0adD5y3BEr+BUvaf4tOVvTwg?=
 =?us-ascii?Q?lPGB5jO4hNGNl310wIt+WsdNdPdniLGfsCDtWVJu26Xely2eya3YySnQBIAy?=
 =?us-ascii?Q?IPcxisaVSRQAKu8ym8JO2GdxMURpjqdJVsTvCh8qauO1uhdD3C+6cOS8bluf?=
 =?us-ascii?Q?HCmCaNypCNST8YtWoDPt9WeTwUDvXb9eaaZLmprmPBr41jtQOSN8ZkOTvQ93?=
 =?us-ascii?Q?hoXWETv0+b/ofbmFZtvwNnXrXw+JwciKcz6KJPM6p2CR/kxXebHOIZUUkfaL?=
 =?us-ascii?Q?RKd8dwehDf6i2YZnx0Sju7wuABupPi5kwC6PgzmviGY8zPVXb5HxYSWLHpIH?=
 =?us-ascii?Q?1hxYrrbghFHBVWvcTYUgr/O/RECFRDbtdGB7RczQytRIFZvjVtpz9pdKeMga?=
 =?us-ascii?Q?hryRpe8MXhfK3zgkNvEr6AaFfQhFfl8sN1EXnAB+RYPeqmn237QnvOuAz5Qx?=
 =?us-ascii?Q?bgAKqnuA2flcr5xP2062uX4oF++l0Ji98iFuQ7jV5gCAYvbfLMbOgNhPuNVf?=
 =?us-ascii?Q?ZF2aYtqVUI3f09ShqKqTMiRJ/SA6tny0RZScQPIFib5/vjrHgBZL/GW3QDZG?=
 =?us-ascii?Q?Qm+gGn25JLhdAd4MuQDebTuuIK6WWLDYkoEkV+nr7Z7sp6Rt2JDBhacmGs95?=
 =?us-ascii?Q?OpihHXFYy7F+sMdMi8Mbhwczk1ooYP5OH9qg3O/V8/P0OZ5V4LTU+As/WHXd?=
 =?us-ascii?Q?v0eQOOKN624C5PpNXaLRI9Y3zltUJ48i8EIrd0yi7likBZJLyYnIXJazKl9a?=
 =?us-ascii?Q?p90XHMgz+N2zb/Wy4Y8/RtQeRFVR2rl941tx/6zCTRe5Kz43txfWW1CacrjR?=
 =?us-ascii?Q?wMs5h2Rpy5bqfPMEm86cc3f/MzT74eVnFaPn2JviPGp0dbfAZbkqX9jGVArJ?=
 =?us-ascii?Q?ohMKhwQ1xV/+bsttEcDtevDjLVoFFvDOi+WJLRXyKGGP1GGZqJ4Gvg6fD5eb?=
 =?us-ascii?Q?H3F7XBKORcfz/jR3n1YrH6mPgmLXyZobXQAd0m2cQm1n1FBIcH1m1hx5D0ZC?=
 =?us-ascii?Q?rGa9PbCEoT9FRJXHHQFuyBwzkMVwiOHwmmQemB+l5bYDbddK+Ppj8NtG12b8?=
 =?us-ascii?Q?ecczagGwfqSx5H7e/fUH7oGo6iduz0B7wPgfXOUaZV5mxenNgltqCfiI8bUv?=
 =?us-ascii?Q?NojIyTFfhsCpkQg4B+PqLTUNEAeMfpUKWStBKgKH1NYvd9RF2K6vngaQaPSS?=
 =?us-ascii?Q?5XkZ5lbXGOFboiHSZ5EnNFbPPyfrQC1nmZ9aNj2hOpiMhFOeu52NZjyO+VIZ?=
 =?us-ascii?Q?ULwWFYle5u5KSqc60OvDXBgJHQnG5T309UVnz+aOdoKarxziMzU7mIUMytet?=
 =?us-ascii?Q?mpH6MaOFNx9g/y7MNlVoHUx/IzN1UhBZC7evlSz59qUKYJ46znExdE+WmpH8?=
 =?us-ascii?Q?QOiTCQzMxDEP5SOfLTA9SzQnDsDbg0lkFmZq5624bDnnDv7VGcKVU132uZFI?=
 =?us-ascii?Q?wWPptC7vv222kNb0V37VBBv3FJj/tdAWXfUKiWMWVVVnr/YRlw71dtWyyWCJ?=
 =?us-ascii?Q?7nat4sZ4hrJgCuyJ6SRTGo9p6wy0Z8iKuyeV3Bcn0IHzkdJZnMCSgSTCviB+?=
 =?us-ascii?Q?VnTp85lfpY5tnXhCYqEdMHE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78287f5-fcf0-4a65-e06a-08dd07fd4a99
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 18:17:41.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hQsEjbUiLQHeNv3BEQsI7d+IbcUReWIfRKKcg4RKdI4P36VUchiI/6dUAiCSWixfE8rKzo/TKdeuHU81wVIXcSuP8aFRqezXzFTiB8bT04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6694

FEAT_BBM level 2 is not advertised on AmpereOne because of a bug when
collapsing stage 2 mappings from smaller to larger translations.  That
doesn't impact splitting stage 1 mappings (whether stage 2 is enabled or
not), so workaround it by detecting CPUID.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/cpufeature.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index c7ca5f9f88bb..d9b20eb43d31 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -847,10 +847,19 @@ static inline bool bbmlv2_available(void)
 {
 	u64 mmfr2;
 	u32 bbm;
+	static const struct midr_range ampereone[] = {
+		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+		MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
+		{}
+	};
 
 	mmfr2 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
 	bbm = cpuid_feature_extract_unsigned_field(mmfr2, ID_AA64MMFR2_EL1_BBM_SHIFT);
-	return bbm == ID_AA64MMFR2_EL1_BBM_2;
+	if ((bbm == ID_AA64MMFR2_EL1_BBM_2) ||
+	    is_midr_in_range_list(read_cpuid_id(), ampereone))
+		return true;
+
+	return false;
 }
 
 int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
-- 
2.41.0


