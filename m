Return-Path: <linux-kernel+bounces-345373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7933498B55B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F3E281355
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFEA1BD50B;
	Tue,  1 Oct 2024 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="E3bzzzEb"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2128.outbound.protection.outlook.com [40.107.244.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1892F1BD02E;
	Tue,  1 Oct 2024 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767193; cv=fail; b=sd2zqhUPP6Nbezb8ZiZtSFP9xCmL1WH7qI2uCKVKNyQ1I+WeyiAzKU+SxskBzU4a1C2+B+TYTkEVBRQRQEZfMwU9bJ5Xf4Q+AuU8Rq2b4froM0su4sr84SxMAGCefKLsmCwV39oNPMwvwCg4ZppvkAi/SMjPdF7dwRbnHiNcdP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767193; c=relaxed/simple;
	bh=SckMwVYn9//0NNiKmGqquCwPxQf1cjFKBOQZScu5omc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwvpbwnYXg1RGvOuHuIXSeJj4DT7Mkw7sfV7g4qwN9D6enbiXjKYeh8Gh3UsJp3tMumXSSnJ0KJ4vnyXSQnIFvN8lCOlhN2lCHaYgeKZRsgawjcXlPYEsuZ1fGXuQGV+we/wgBxo6B+6peA3Jfp7imEByvvc9ezKl9y+lrXwrjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=E3bzzzEb; arc=fail smtp.client-ip=40.107.244.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbMA/4l86hhC3WSwqYNnuE1De2SsOPNg5IU62AGoBhltK6o4V9BE/50uVxwpb4CTDkobhBngG2cgQHgNs3dWWqelHPy6dlrB+HDs3mOGZbKEgwnMOJr9zsfEzHfLHOHBNI1GWig/Ps2czs03hxq5/v4rpBBdqAN9VwDdrbFMgrlcDJgWQOfPmBbOCdsupZOuIYS+dBop1UzqvSMg3XA+nzdCGLRkMMKn6SGf0TQwugoaPDK+u5NNi4G0rHN7osonlQigWa92Yw4QJFzvb1jvFTgrpZ20/n+zW8sv4bvUaXtdkArG9Kx948e/kavUm4I9tleQLA26O6p7IJ2i8x+Ptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA5JLsK0cSXQX/t5KOVtEaEJ5lhx2wfrOw0hmOlAgTg=;
 b=Q1u3V/vKf1LeLh34bFZpZP0CzqTqPVD1P8uXHPTYvJ9qnY8LuKajhsy3Ebk/T8nA4cB90J/VHvMrPzTPVJqLX7fgz0gOGV6L1Jb5fcQsTZuEH8FXD/uvdpkam7fNm4NZxMgvF11jzCBA63E+ApVb6+vfZv8eH7ecFiy2RR1V4gnmcDJAH7yFlhhVrmPBAihA+vmFrF0MV8EQhhZstgGFe7I4hm9LhJpCj9l4hd4Ow9OB52x4C90t73nQWXHgzIcoZqXoc3xnBXHU7W/2QQ6VEbAwVKT4Rn41bCH++fJCP43AgxXHd+46xMfJsmAEMWN4nJxF0kuwhuyXaV+FARUJfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA5JLsK0cSXQX/t5KOVtEaEJ5lhx2wfrOw0hmOlAgTg=;
 b=E3bzzzEbRD9misMphNBxPN083I+YsIQX0ccI6h/U9zvHK1FJQjcg5pabjp58L487LvF0XmXV16hzj0jw8p5ZASsb/y2K1qSIHcPt+YU1bcO/rcB/HiDuUxNbKvZRXUc+m/LYmUg46uxcNgaeH28MUj4zGiBgi234qXJaQ5PLMEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by LV8PR22MB5551.namprd22.prod.outlook.com (2603:10b6:408:232::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 1 Oct
 2024 07:19:48 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 07:19:48 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 1/2] arm64: dts: ti: am62-phycore-som: Increase cpu frequency to 1.4 GHz
Date: Tue,  1 Oct 2024 00:19:15 -0700
Message-Id: <20241001071916.1362213-2-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001071916.1362213-1-ggiordano@phytec.com>
References: <20241001071916.1362213-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:610:38::46) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|LV8PR22MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: f54dd8cc-45a6-4dfc-d7e7-08dce1e96ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5sMb0FmYu6sIUQrrsER8cMxp4oQ4Edeif3Fd4BqFrAvK6xa3lynFPtJpEnpT?=
 =?us-ascii?Q?hY6PYvTx3sIcJ3Fe1P0qJR2QmQY67zepxHf1bTRVKLywBzGYRBdLbNI/owLv?=
 =?us-ascii?Q?SPyRYaM0IleyNYC+wQY4Fn0m1/L0IkFlnUbnnaf46jhZNxNG0WDHZC4/3pIU?=
 =?us-ascii?Q?EOBDIqoXzmEd7S7R++1PF2HwR/O0/s61U2ByDNNC+gvlZL4yqg3TVU70VNxS?=
 =?us-ascii?Q?YEAHo34TkpYP90eWTXIPDSarfsnkSGgHwayRM1gNyUOtcvM7uR/UWRmULgbq?=
 =?us-ascii?Q?1SSA0U7qRYjxqjct5+VhR4c2BHY2SwJQAVS+rDaWMo3//3vqSjMbY88SfBLE?=
 =?us-ascii?Q?/OorjH2P621ru1YePp2n+F1OsS7e7Ksc2m1O0tHqf0JC2FbJ/T8k0WnWnRqu?=
 =?us-ascii?Q?7oKfnjD8aiJEr2FtSowRGeh1C5WdSmB9xhXICRB0c3iMYtQjUo5Duz399w1V?=
 =?us-ascii?Q?qNvBNkRtuuk7nLrOXmImop8+4KXCSxjoqTj23W+uGgek3NNFkYLg0EX0intf?=
 =?us-ascii?Q?Re6wRITeU+d18dXqayLdxw71jmsnfHurz3azQ50GfVUqi6GQeH3610nJBxSa?=
 =?us-ascii?Q?iWX39MfjjmwyA5XI8wmeMAyMgj33K1FnUQhFPfT72YfgEosxDNvPjGW8q6a2?=
 =?us-ascii?Q?DfdWFQ7NXM1PN+oDWJYCy24DrigExaYXLtjAY1gkGKGId2ipG2QqVV1l7yFX?=
 =?us-ascii?Q?vyIhOI90CFyFEPggqPZC8qNbMLKFom0sCnZj+/5ErAtsk/0eIgYi+rX+emzz?=
 =?us-ascii?Q?IBsv1BnMB/nKg/sKhi7cqmeDx8vUOH/4ht8WYQu25eSV4kgNOiaDIGs6xG9b?=
 =?us-ascii?Q?eRlha6PDUv7gERM5LzBNWtLSRjngnQNTbTvQClupEk8P+aa6tOaSnVHTPHay?=
 =?us-ascii?Q?CZ9orc/bhQAYgHBCfd3UdGTIdPmKmDblvoHnvwNpNzWENIMYeX83rfSuAPrB?=
 =?us-ascii?Q?1RpbyMTjKwKH3MnMjmeR/q4b96cmfoxAAfczak/2dKHrMHB/nPsym4IoEmLX?=
 =?us-ascii?Q?61Ox2TVuHVDgxCoikO1UeOCMhC34I4B8jw2xEhpEvzmXSpbpWpHoQyUKGmFp?=
 =?us-ascii?Q?c9VHIZi1cvn8nOkvcPj5qAeRj8CIXkGLqSUEOWLe0s0MNR6T6lXnPgeYUlI/?=
 =?us-ascii?Q?Vv4Qhm8pmp9+vDdhBQ/AL2XJ65w+eTO8dT5vhjV3kojCH0AG6xZSmdw3UB4J?=
 =?us-ascii?Q?YAenmNE9kdmLOqqul6XQemO+/R6cQYxWWAFK0mFM289vESOX94vv+tnIPtbz?=
 =?us-ascii?Q?mDztYOT27Iy+e255ljIvRFQr8qZ5guBGh0sN4tuApDrGyKoBMQrLdTzn0VXO?=
 =?us-ascii?Q?uccc0yzB78Jr1bpJR7SkBeU+EwyWV3P8B1BrcPP3NhzINg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oh6364RJ9yZ7xHYY80vUkCb9E3Mf14cmY6nJft2dUD6SG+CY6IewAJqn5Z64?=
 =?us-ascii?Q?a3Wf8OK6TJ3EoZXcFvMTSJ0Y81FirA2Xv+B5P3FosxIoe4OR4b/DePHHDpjj?=
 =?us-ascii?Q?jNYL0F6kmkB2C7Df6ocn6oP1SDvr2C9PEvYkowM+nCC5r/bu9hC8iQwuT0g1?=
 =?us-ascii?Q?sHvJzsZXgUpXjPYnmCAL5AHflTELSp+hPQ9DK9lRco/yPwRCfAUnTxz4kJdA?=
 =?us-ascii?Q?i+USo7UntLYcWlRYam3hqd5RPYFpUf/Rq+XmnhvjWnbNp330NfObuIepDQVe?=
 =?us-ascii?Q?lFXVcDcnEoPEvt/JDH1Rey9LjouvqdNNQxu4mdvZ1iqj2cGfiGJCKwvcW++a?=
 =?us-ascii?Q?kdcxkXg2YhKFFENOR2bfljXvaXWDqo/6A9//Fuf8CRZu7tOoq//oc3y10Vw1?=
 =?us-ascii?Q?/v1w42Jd+4b9OsqTFI7UUHuwd8trKj9HKDKBE4ALA4j/BMXcFosus2CdiaVf?=
 =?us-ascii?Q?fxk0+WIkdZNoTfRixv/54OAkTFFv2jlIxEHtxkyJtiTuhVpkt7/HWK0zA5kR?=
 =?us-ascii?Q?wgd4yqDHHlT9ZGXH0SYw/AsOsI/O/3dvX5PUcfHRcHKLE9FatVnp/wHXQ1L3?=
 =?us-ascii?Q?sk/3QX/GroqnVxM+Jv+N43f4R3dpjHPl1G4R2Ne0Tuv1kc4MC0mMwsEDIfwb?=
 =?us-ascii?Q?wNKyFEIBRIcUMvAosrTtTS8wxGo5fqNCF3QUZfladcFC88L8P4RZTtT/mvBg?=
 =?us-ascii?Q?Yz0y4igDMhtLUmsk8gYTvtFz1P6DUSvzmdeZrNbbMk9DUpIpQey+isb75JgO?=
 =?us-ascii?Q?xmCJlssUXrNAyE+J4VfVbXlDNXAiw3Astshlj5Pzmqe5TMT0RfVSFD9lS/zD?=
 =?us-ascii?Q?eCiYadkV+f9J+LoyRgNvSnzEiLY6necMhUMlmeM7ebzfRlwZGRWb3KdzX+Q8?=
 =?us-ascii?Q?9dzDuesSx6OYhA7U1Y4FfHx2RAbPQ2SXkZ9FnNkT96KkZkBetBWDJuvcbLX6?=
 =?us-ascii?Q?QNZ4/VewtbN/mTqKUP4felT+Dm8q0N/pNtCRnhTUJgeNcF6gPft8DrX4AVXb?=
 =?us-ascii?Q?VbCxCAuKP19lZv+K71v8fRjogXslbWhlOKqEGTHd/ioSKxkv92XRfxO00wR0?=
 =?us-ascii?Q?1Xu334FMYm3nt9phg/N1ZFleYPs4vreznMtrASstVK6Kal91GAhU/50J/LeL?=
 =?us-ascii?Q?dCZjq5HgtsVHXw+9svIzWKm6R7paAtmxMwgjzzgKj1HQNPTyogWMGOgtrUUv?=
 =?us-ascii?Q?SO/h1qvVbhbRoGByE68REmHeZOd8Y7uB3S+N1GLfbB10/ocW/jIDodHgFIMB?=
 =?us-ascii?Q?S2fULcmgKbQHGN1BjLr/GnmeuAX1Ofk201+3kQ0YHSDVILbTnFadwihqbS1Y?=
 =?us-ascii?Q?VkjsGmsLDTOfVSbi3gPE9zEm3ZxSVofIzj3NQIEi/5KwnXWg8DS51v2vrU3G?=
 =?us-ascii?Q?lSaO4qV4FvV8KbQCo1XIERkFndf7uV+C/8F1C3mAL/m4ygTkPpuUwclSlKqo?=
 =?us-ascii?Q?jM5JwjmdJBpnujFxzONVIyJBNEv5jAmdooCQK3kjgxRO7bsLBNJrIOGCP8Fj?=
 =?us-ascii?Q?o5ZkcUV2+QdCaC9M+NULUu4vWfASrQgF/Eokj82xMhZfha7OYa7E8PXe8HzS?=
 =?us-ascii?Q?V2E29Xb+nGXCu3HSYfb09StV3yuEe4P66cGyOv+6?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54dd8cc-45a6-4dfc-d7e7-08dce1e96ed7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 07:19:48.4650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m27uweAlKHWc+3Nf3qajWfuPSFP1arrVX19dXpHRDFS8ycqVI/V/1KP9Oy82kEibg40iqx/2q3h14JJ6NJxkUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5551

The am625 is capable of running at 1.4 GHz when VDD_CORE is increased
from 0.75V to 0.85V. Here we add a 1.4 GHz node to the a53_opp_table and
increase the VDD_CORE voltage accordingly.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index 43488cc8bcb1..236b94c0248c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -173,6 +173,13 @@ AM62X_IOPAD(0x01f4, PIN_INPUT, 0) /* (D16) EXTINTn */
 	};
 };
 
+&a53_opp_table {
+	opp-1400000000 {
+		opp-hz = /bits/ 64 <1400000000>;
+		opp-supported-hw = <0x01 0x0004>;
+	};
+};
+
 &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_rgmii1_pins_default>;
@@ -226,8 +233,8 @@ pmic@30 {
 		regulators {
 			vdd_core: buck1 {
 				regulator-name = "VDD_CORE";
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <750000>;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
-- 
2.25.1


