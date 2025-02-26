Return-Path: <linux-kernel+bounces-534715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E289A46A39
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01EE188976A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B5A236A77;
	Wed, 26 Feb 2025 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="IdvBgujZ"
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11010024.outbound.protection.outlook.com [40.93.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B021D5AE;
	Wed, 26 Feb 2025 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596107; cv=fail; b=bkkfNWRbyqHsN3Qwi38lyC09PrjrchT/v1pmIHzJ8AKNve18M+zwbAavpg/qEPYAgMqUIecUbeaF+TCe7kb9BHi8NQy08CKWsMXFmfGkKk94GEZ+mzJsJkmTEkwBD1CjXMLZVPJiUF7y9EHEyGTVOWik3FkUuVxZSqO9CJBX4Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596107; c=relaxed/simple;
	bh=SyTQrycSQ9ocuBTeeuRTFJ9Z4BUZ0KOu4fK6cV3Y/LU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=G1DUNwqDICh5IBw3KmHVXR906pBrht24PkGaxfa4A5F1Thm8O3EVuDdM59FYaHstNC68q1ipJx79ASyHv/LiP+VCSA2BoY0hvrKtf1wYCdXlbt0DkCxzuYMO0dpOL4JXhvI2kKWQrPPPszoI7u17P/U99jsF0CEsZAeEvFV5XzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=IdvBgujZ; arc=fail smtp.client-ip=40.93.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nl7856fdVTwVFmV7poy4CwzLoD2xPdxr3ydmxG7HJJGrguK6jqSn62LqiVF59ZjtrClOxwkr+Tg0/r2zjxtmqpFeYSPhbboSTxNYP2B2oPrQfgik19CzzL5bctsd7Z/c2a+bRPBJKkYJVr/0AliL8/yEAx9IgPRqJXRhVe56+1q4rL1WpwTuSm6DZHUekSVb1Qls/T3vsJL8gpz7DVDi1prtqZZtxIa/XGjwC/CGAMkv2BxpzxYTDxoc6Zu0CEVGsD6/yOiq2SuhBIW4Ce+OlNpWUs6yaCjU6IwwWpP6ynWA4Dhd5N8rGTGtEkv8UBBSgpnNwhYMiO+oiBexluyCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9FBC3872Z1YKE0cUYOuCO4ujATEszea9HGd6AJPWxQ=;
 b=XOwWsZl44Yd99umKWcJD1yNO2KSXI10J2ImBKDhQaKp1ASqaeDUsp0KXzXO6fH8XM8+Xwvt6UDG6bOBm2+AFpiqOq14QQGchYSWHpTXyFaagj8Zfs58QRJMcku7j+gfHAd4fNn3bZ9kjkAJeScBsxqpCgZFOLVHMPDYkFdekdgaHQbIVon1UkTv+qzvK9G7CMkLgk/Rb1imNcYzdQsbrsCO3gVhV99qL/e7WvdE8w0zFtoKHpwLy6OQs/4yMbyOXr5CJr+O0qJIhzGjnyzrPKhPbKchMkWFH1/J8xSi4MeVY43Mf4a4nwVvAHohZF00LaXzZ8MLIwP+JwFHXE1NFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9FBC3872Z1YKE0cUYOuCO4ujATEszea9HGd6AJPWxQ=;
 b=IdvBgujZPixXOdXqBXHRPXv7ohq311KblJcwdHNhEJ4YMrh74Lj3vCV7YFgA5j4As8/hCRW3nvV354nlbuTSJ8efeUKy3mLN/xzMDaM0bTLxZwvwG6x8cTShpNB5D2twKZU4xovvpPsoIQvspyxLNUqKxj4Nmqh42H5U57Dyq7TgFtSO6a02TvtUcWKUfZSlSYfA6GQh+w5Sly8sF3SXDyei7YBFTOZm6yXbxZ4JRrhw+Fp7KcrDNAXQwvCwcQwt9HdDLay0EMTzVueKA1i6m1eh5CJAAndVDK3luO5ldQhC25w79/48DySlCQYnA1HAA8+4oteX0kqVJqMLa9eU1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by BY1PR03MB7969.namprd03.prod.outlook.com (2603:10b6:a03:5b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 18:55:02 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 18:55:02 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH] arm64: dts: intel: socfpga_agilex: add frequencies to internal oscillators
Date: Wed, 26 Feb 2025 10:54:51 -0800
Message-Id: <20250226185451.11748-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|BY1PR03MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d4f376-023e-4e19-0d38-08dd5697138d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nTUycIG1qjE0p9G0twdUFZm34h0NIZGW2stT5WolMU7yGyqKLqmejENErtpB?=
 =?us-ascii?Q?tCU9pmoSJyyaRAnHny1di3jFqZ06du2sK4lJUeDDKNcbTmBD0BMTEtVA2HMD?=
 =?us-ascii?Q?lNsmReCoDcmz990wr8QoP+V8yaYn0H13hQYhh2Qc5/fwzV7bCqK+a7WUOfwm?=
 =?us-ascii?Q?X7oXvA3qNxW9a2J2RZNwxdkD6TwmJ645JnI3Lm5gQb1ropi0E1x3GXM/LJnc?=
 =?us-ascii?Q?VLwcnyS2AjYkhEZOCq+6TnLVikcjpVcfGYYrVp7BG4HPA9iMcN+bL7K5yw5a?=
 =?us-ascii?Q?MQnYoVl4Cq/xv2EEUnD9oEFSzMWzTx4yL9gYppMO4sY8I5OugYKSmnh1qvOj?=
 =?us-ascii?Q?iFn4Sf8y6yj+xhAf8uRgLUJL8/M+j9hdz1/3O++XFxCwp/lA8iqund+sW03G?=
 =?us-ascii?Q?0UONcMqbwgRnKoAQzPtsX/kOJTH3Ct/KRBxZN9VT1KqW6jF5WJjAeZhxGys3?=
 =?us-ascii?Q?aR5jV6g7O3fATkb6xiqZO29nsGC6KQnOzpPirM5nSXR/RxzFfcSllAnS//r7?=
 =?us-ascii?Q?hA3dC+pcbDdSFi4AGq4qSkw9ru0icCGRYY1uVGo/qjh7veAu9ZABiQQMJQV5?=
 =?us-ascii?Q?VsQqleN2f7Fkjz6dSIx4NEH5NysuWgn4NhwtTBxUpW45fyXMY+HrA+8tmOOo?=
 =?us-ascii?Q?78jVsZiu452YEWfZKEUCpf2kSsSnWGu27Nmt4bCd3Qbmk6UkhvrcEbY4ru/6?=
 =?us-ascii?Q?MNnRFf4MLhk+K2DDA/HvgrbAGPdSkTuCdxVstm6+E2EE991ekE2oe+L3mA16?=
 =?us-ascii?Q?aA1KRq2enEu/XXcVdxoOv4hZv1gmSfo1xd9KGIlF/VECxFCywqnfV0BhZk3w?=
 =?us-ascii?Q?LlQs8JpH8eak/JMV11S5ovV3f/LJesUceD/EZVEwD1yHvE/vtNA/kqV6OK1v?=
 =?us-ascii?Q?kgEjHPxbGsECrM3zecV0qmt9CAkahVagwbnwmmhQ+NoOTPdVliUEJRgKbG5Z?=
 =?us-ascii?Q?43Qeyf+2+JGFoHEiQFxCaqqIpB1JInC0P3s0bxVP8bBVDUlVv8AuFkugkutZ?=
 =?us-ascii?Q?nhVUBSQDtPbd7pnshikr5czX+H2rS86jBhna/3XnOUevnWc2N52HkXCsrVbH?=
 =?us-ascii?Q?yolekgYU0S7xgL64Oiww0YZIi7YPYFVYdQUYzxYZX34EFNyarZ38W8DH+NLv?=
 =?us-ascii?Q?SiQhOcl/3x9SZg5UTWB5rxCFw1g/uMrVGaPlff+OgiNSVcB0AOIEftKKukWE?=
 =?us-ascii?Q?RbU1xuoACNEy5xFEYoRHQ+hIeFFAHsKKKXF8FPVJkeSnrE/Ug8O5b9oW5Xrz?=
 =?us-ascii?Q?I71fxSVIrhBY/qp4RlxH5SE22fH3SiWP1xjUzatf4U2+GZfT8+BU0Nbr6TPy?=
 =?us-ascii?Q?0+9m1zBOQ1CWkvwyP1ZvOieP5f2Gp70egSX7+hnojQoHxJ83wXx7IMpDD1YP?=
 =?us-ascii?Q?d3q8n55J1m/yJh1yftr+ZnchqT1l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mvdM6Wfx5+KoDDRWbNftZEMIXP0PcK3zGQQO+/AA50HiLgr/mJ5SdqBct+Lw?=
 =?us-ascii?Q?JQQWVSsWHO7DL2nZIchGlCwCTOqZq2FVbS2RvfqkEMGf+gNMp+loEkXx52rQ?=
 =?us-ascii?Q?JWsBo+ONy669zq1k4Xf+CdjtDitpE9qs6+oqtzxA0CVdwhD8UHaYLRM55WJd?=
 =?us-ascii?Q?+Iyq1riqiHt4MmUoVb9IcV1p2IIfWvbzi9N2/bX6o7NdEmLJ+AxACahfPEVA?=
 =?us-ascii?Q?aK7ZR9UDLa9dQ1gfNjYdCWvJMH/qjmgiH21hAtSktyuBFmXo/uGAPy36LnUj?=
 =?us-ascii?Q?ET0LcghbsqcxPxMG1mhQdfL67r+EokVTFIIWjzhYCMBMc6mcAJN3il3ZyaGP?=
 =?us-ascii?Q?au+aDS3G3oIWGbhhLL6KZOpsFcdyOCXSiKqzxLd96tUvOUhgZgFHhhi8owPE?=
 =?us-ascii?Q?UJAhncoLz69ayxDPtr2FjpI6uuokmx7fc7agJp95XBYMZBo3uC2t9tjuct3A?=
 =?us-ascii?Q?NvBX5qEc2MB0hYNXgCfXmg0ioHsizsIDA4qR+LbBLkq1YvUozf52E8cwiS8N?=
 =?us-ascii?Q?jkv8zY0SPlNffTt8lL9ls0EtAt+m438KnYU3YMg4OmogKxUvyKEsPp+Wex3v?=
 =?us-ascii?Q?sBM7ubZLM/pW1quiwItdOXQMbMWeqDLNbJh/8LanDFCdslUt8pQAlYqaXlby?=
 =?us-ascii?Q?pUynuGEK+qEaL+kvfT2IKI/ZwRo80zMpZb6seoYarp1KBS0wy9krwi9P3rA3?=
 =?us-ascii?Q?ZuHUgyguPRp3SUrPu9mPMG/irUwVR/epGM0au8MnNsY7KlXQInI7jKHvMF3f?=
 =?us-ascii?Q?qd4ZUGNpO3TsAiWUyDozO+VbudBhuIefzPNtwH0lvHFyrgVFrdihtWbMI7OD?=
 =?us-ascii?Q?gjdddT1fsZ7rise7t5iaWJZRx5zJpm5n/2vW7jNCaFOzaUBJFV6H3gnpbuvI?=
 =?us-ascii?Q?lz+NwUdqx2o4bQ76RkPli6JN8eQqnFSjIDEVY1LS3j67NLtywWEcQD691F6Z?=
 =?us-ascii?Q?tD3cDk62ku1a9Pc1hz0pziTBqqfz/5hzes5k0etIIRjHDTRYqimlaKZ0ApST?=
 =?us-ascii?Q?POakT7ILas4oW5rM/XtszBCkWQ1MusBB7ZGEnu3pHAJsrNSOSyd7U5L7uFJQ?=
 =?us-ascii?Q?LDEMdpIxFEbeUQodn4Bz6tl1P5PK2FzCe2aePnHwZf0KQMh+LJ91Nyk+rPF3?=
 =?us-ascii?Q?HPCHAH2qRgTt2QJJHOPYYCoH80AKHZvzk6SKyCZpIsP1EBv0UP9kOTeAV304?=
 =?us-ascii?Q?3TkS9cVsijRpl4nLxqgzDmZc6Q6b2UdCeuZMJncJZph19/004NYH38URiTCa?=
 =?us-ascii?Q?dZ1od4i7SBIMHIZTxNxUnN4zKrdV7nlgYmbMfp/DI5TdX/MPhUHG69nYFbeL?=
 =?us-ascii?Q?uWJ2gWzj8HKgIGPGFd2tx5Qx9tDBvKmcxDQgfs5PFxmHhEAQuzLn4RCeG6zo?=
 =?us-ascii?Q?JqAjz5W+uvI3ZZVyGr8EQDHdeufWAZ9FZ+unyRfpg87C72+Mzb42Sil8a+gF?=
 =?us-ascii?Q?50By3zZYyqCF3rG6Yk5UfVuLLemtcwxFGK6yaRKq+QTfmzqD/ieGM4HmAS3Z?=
 =?us-ascii?Q?Fva72WGp0VELdeLK6G9OLdXErg235HIchGGLU2ouELv1gOUHDU/YIg6aYdBJ?=
 =?us-ascii?Q?M1QNbv0Tb+c6goJ50o+SD17wpznYcJpXUpit/3BG6a649iIGHKXNiX7hIblY?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d4f376-023e-4e19-0d38-08dd5697138d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 18:55:02.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZFxpia5o9meJWO9OQgcXmFSVhHW8pUZprmPuKnJ5uZOvXbDDfq8ZD8X+TWgYvawOPZyZLUt75WNKyM8GUD4j7bG9mCanDKdGxd+gx98kAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7969

Add clock-frequency property to the internal oscillators, cb_intosc_ls_clk
and cb_intosc_hs_div2_clk.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 1235ba5a9865..bcd12f82636f 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -114,11 +114,13 @@ clocks {
 		cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			clock-frequency = <200000000>;
 		};
 
 		cb_intosc_ls_clk: cb-intosc-ls-clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
+			clock-frequency = <400000000>;
 		};
 
 		f2s_free_clk: f2s-free-clk {
-- 
2.35.3


