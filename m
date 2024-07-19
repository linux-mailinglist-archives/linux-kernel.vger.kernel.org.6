Return-Path: <linux-kernel+bounces-256999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 691F29373BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4E8285027
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BF9144D21;
	Fri, 19 Jul 2024 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="QgebXErj"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2073.outbound.protection.outlook.com [40.107.255.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2611448DE;
	Fri, 19 Jul 2024 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368860; cv=fail; b=IjYjaM5k+mMm+uokX9b6VCXVw74PL655edjrM9sKuxqUPfIXfrLjW4CLb0bs1PdyCFMT/ChvsYdWYSrOy2W8PChLwdjLpTjN8Wt7MnpSEB0srPdfuO8lUwVEgrXXnX305HTRs732YoMSGXEORPZWzdSqzw8JKq13nVWtjfSRB+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368860; c=relaxed/simple;
	bh=AQ4i6Qu58H2Mz2uR8G2Vyh48mhMggrP06dUm8cpEJ3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFcH0CYJ3b4NqsCgEa62qTjr9aOC9XMt8g//wb28Y61QNTIReET+4mgPq+eXGAbeA3/aN53DjIYiKfSm8kStcGuMFwX0tf+3VKC7V4K2nqnwC1XIrFIAXPe3G/3kh0QwSSFAVlKb3LQpDDL0c/WV483TuMbFVcUyS0toEfENuCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=QgebXErj; arc=fail smtp.client-ip=40.107.255.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syyQ8dAeIbDHYTI7KlotSid9uSu9Fx2MbvSlcgNTlYb+hC5QlxOZ/rMSKOPckBODWLksDa5N8CWRTsVTblKwv1x3t/Clj5ToXd4TOAUGJ829Ah7jYJBaU78HTWGGMq6CeRLzsB6dsOe8V3zF/5CVnxZoz3qyPQXmUDRgKukdPB6Xk58kT3sLW/8Sj9f2MgnAfz5GJivlEEfNT4CRycdSnz3ji/gZZQQxrfAEITCJBHQaHSkAnEZ6aZ1zh39cqneHXSOiDGJCIfEUnZrRzhS1vjOTYxoQkMJulZVSFaXEAy7tr707fUyZZD3mpqTtb4lsgpBYSIA/vMSVjeGrn3+CQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqimXxCSFfjlalerndMtt8J4+kzLlcFkd5OkESE2nnI=;
 b=m6aSxNFSPzVi3ZJ4vGvN9DHd3dCHxqyzisdFbUQSv9/TTOF0Jy2MJW0B6oC5H59Q0WK85QxPAl+uuc+/e0U6xRKgDmCdQz9QCNUlw0mGxnwc2ztRkxOMWQauHejsciwToK7erEDLnwSHTpEznWnkhW1aUlU9J/YJ5CEM6ge4J0kubY9hrEskAo6Ecb2QSBmHKWjO1bJgo7Y1vXmeQ49Tgj0jWhSMSftYfyHk5HzthujhsA1PDCf2BhZKJWHreW0l9PQ6mG1PXSZ+5/ZzNacWy2t9yErtH1F3PgQpHIF2s4wuWutl1e/dGa/3jAF5mwF5mzKYZvNaWYUDtHlocEUghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqimXxCSFfjlalerndMtt8J4+kzLlcFkd5OkESE2nnI=;
 b=QgebXErjVQvuP+4kj3nlfMyhIjj4I/sph3lo4TBEMWJHX6VG2jEK8Q39S6TY/yff8+u2/KrtYa0xbexUTqyZODSl5fVsfCSv26ukSi74KnKLQP6Z3wK+MVvxwICM/l5BSa3TL212eQLGM1vmSPk2oD6UBTDCcrDEAQ5+xfhmFJlm8/cqHYh3F5WBwPs9OH4Dn7jKYjHmbgPiFrvvY2BARQhfqxmj+8plGEsPK3e7namKwAdgZmDXlIAqj8GpSUWpRlw9MOdmhDxMkXEtIr+XiQc9dPhSDOhdsIZ30Z8U45BvhBcqUVvPqqf9lg/0lNKjvIT2ZIx8aNBipPUQZjyFLw==
Received: from KL1PR0401CA0035.apcprd04.prod.outlook.com (2603:1096:820:e::22)
 by SEYPR04MB6553.apcprd04.prod.outlook.com (2603:1096:101:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.9; Fri, 19 Jul
 2024 06:00:53 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::f8) by KL1PR0401CA0035.outlook.office365.com
 (2603:1096:820:e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Fri, 19 Jul 2024 06:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:00:52
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 24/27] ARM: dts: aspeed: yosemite4: add XDP710
Date: Fri, 19 Jul 2024 13:58:53 +0800
Message-Id: <20240719055859.4166887-25-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEYPR04MB6553:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9f812978-3d9e-48d1-74cb-08dca7b825e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KrIjZ7OWYyrdVUPPqK7Oe+Qax0l6MKEWKRrSqc9MRrasj38/Xm/8rgNtJhnj?=
 =?us-ascii?Q?jhAxFivZhOBnOg17QHAzA4NV6gokcm9iVfvmD/qGDoJESvhxzf2trSdb/nJL?=
 =?us-ascii?Q?jKxoEmVfEAVmr4hQhrdbbE2St1iNxLe44FhArhHqDlcSSHGnQSvUGs6UAdpq?=
 =?us-ascii?Q?0wO+XTZas7U8Zpn1vLMdDXpbfOmgwqO3j7iWyN007GI/HayfWUSAHGpcG+rl?=
 =?us-ascii?Q?JRvJmUBcpSng0nudiK6ikXj0amTS6wSgjBHrw5dgJR8x8eeAncGL+CsklfLL?=
 =?us-ascii?Q?n2yMdihzFvs+fn3xq6qsXetnj+r1YIpDL8xS55GX7lsMY8gj/rTBUQu4rstP?=
 =?us-ascii?Q?reaEiv/FvhOAsIeX6+jgw+wxkCFbCNCEW5g36X/69P5gNmCoGOxmUvzWw4Wo?=
 =?us-ascii?Q?wUDJJGpt1+mC/uzQOP0/sTjM5CqbtNJ6JIOIjNxCb9kmBybkYUa1I+4+7i1C?=
 =?us-ascii?Q?xgKYACqu6Jcq4G3ykEDCPkSJbRjtsBJoQojWarxgWrKqEZjxl+Is/GakZwAa?=
 =?us-ascii?Q?4PPn+j2sM7IkIljPCnRV8aQ/aA8H1arTvTlJgQGCGsF7YGrqsXJaRekcGC9d?=
 =?us-ascii?Q?yId6B9OOySaehdInmn8bNWbYmH0Fn2HXOikcJAROb9p8llBDRUrtgSSbGXm+?=
 =?us-ascii?Q?OLeC6k391prL+Xt+ErxpiX8q8qa2StCAJLOK6er95cVVrrsS+L2cgZeiFL7L?=
 =?us-ascii?Q?CpkIHXaVx016aVV+ynXIWeBnAU6eMZ8E53n2mQ5cmA4f3OlyYeYSNAlu/SJ1?=
 =?us-ascii?Q?7lMA4DRWnfxrBW+j3rNv3mfVCwTDi+c65Q73PsRVSnAaOAwy+3dWAIatA5YX?=
 =?us-ascii?Q?8sonFum97/RGjLMNL828dp/oPtKhb65W4NDESC0e7jWkEtwfORlbwPkBtz/r?=
 =?us-ascii?Q?/kjKzplo0AZ4EbZsUbVCUob3UmrpECeCLLqsX2PZ9ULFYcEGS8+T1FlYt0v3?=
 =?us-ascii?Q?2tEOV1EcmxP7OF0xxhPbyRMf1+T8KL0OTTmUWWHj/V6DkbCYAvlRtVGUJOj3?=
 =?us-ascii?Q?T8v1Axw6vQxVaC974G0S0bDlq0IpfMmpG7DPvouGDRMl+vn1xfgjL/M4FaV9?=
 =?us-ascii?Q?AwocoH1x6/zxj3zGaUGeRTfg/T7To5gJlGXQr0+Pg9B0JGYZvSRWDYJmuYl8?=
 =?us-ascii?Q?xr5sjgWfH+jfc5+5DOIdEFSKovirU1YmSFv3Q8Ra112ZQInAJNuR0ZbRtiM7?=
 =?us-ascii?Q?AFNrJzU78DCshKEvz9D7n7FSROkPcUF6W1uagmvn42XmXuQDMJsEfgnis/wl?=
 =?us-ascii?Q?vvb3NEmLf/xArS42beMVlj5rJHmIXzK4kl3TP+jwfm0ubv1t+E2LiYckc/6l?=
 =?us-ascii?Q?OSSFJyVjlhjvdmM8tYLvc02Obuk5J6DWHdqN/nme+z2cYcjOpOnqWFVnDCCN?=
 =?us-ascii?Q?oxZ8T4usNGau7v76CI4vUDL8lFK6/89Qci4gXI3HXzdICyKPyNsnSn6SCrZZ?=
 =?us-ascii?Q?9FrlAgFXzi0SWNLfdVkwd0SgLlSCZwJd?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(34020700016)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:00:52.9080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f812978-3d9e-48d1-74cb-08dca7b825e8
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6553

Add XDP710 in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 2cbb210ed53e..05f109687ee2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -978,11 +978,21 @@ power-sensor@10 {
 		reg = <0x10>;
 	};
 
+	power-sensor@11 {
+		compatible = "infineon,xdp710";
+		reg = <0x11>;
+	};
+
 	power-sensor@12 {
 		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
+	power-sensor@13 {
+		compatible = "infineon,xdp710";
+		reg = <0x13>;
+	};
+
 	gpio@20 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
-- 
2.25.1


