Return-Path: <linux-kernel+bounces-229549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560739170B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0EF28B9A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2344117C7BB;
	Tue, 25 Jun 2024 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="J8j5l9QR"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2135.outbound.protection.outlook.com [40.107.93.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733417C9EA;
	Tue, 25 Jun 2024 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341667; cv=fail; b=tY4ZtziGyMF8oOh07KdpoYfS3Bp+5vM6EgTHiu9Or6opNFXIgWmLjIVTe/0bg5we7aDt9ampUtqJPZqibB2Om6cVdycarfpZi9QH6Np+R6EIbxMPQcfpWJ6C91MemqmmxJEYM7k6TnTIOMkNnu6LhLASNk4UYZv7GcdiEjnn65Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341667; c=relaxed/simple;
	bh=fgTWTGvsHXnaVX3L1Jwozp5PJoha7Wzj43DpRZaVCo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uoNwx3QYR0lX8xRAusmwkLT8vr4GIA03MQ0E2892cj8ACexohxcIlTLn7ElrecUjjubykp2JFZ61TWkjKaqQ2rB4T7CiFMh6dx7/3lrVOjf0TtP5N57guWsaB+eqVtoFtennElC5oNwNM45VjDQIanaQr0DoKCCqGfvVZuI/azk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=J8j5l9QR; arc=fail smtp.client-ip=40.107.93.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1dEEdi9xluS9CcGMC8jxQGxYposQLzHHCHj91WSOfb8/VDGEBIK90JkO4SdKWxMFXs8ordd0QQKZ7C5BF4ajV97/y6lhSJOe4OmhfvPQ0837BOPhslXBVKmzEjGFcwGXsDXhpVy4vQL72Y2fUWAHQONrEMhECpKzdN3wPZHFvLQoWWZ26tGRRDjsvXdf+wLKSi+DwnUdXdU3/zDSUYQf1es8q5hqgEktdrzJjeerb1mucPuj7t5M+hXj0rzKuqEJ5vDNOtRGy/ZmccRnP7Aw29sD6G/oc3182xuHycCqj6SPOCJJvqAELdokw0mNVGyC9PGIgSw9Moxlwj6diZmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua0BXbLR3aM8CkftHphBGrDrg8UpUc55dReUPDlo1MM=;
 b=I2mmvNtExe09Rd0nMHXQ9ttBfD/BoJtd+ZfqSjEFH82kRZpwL2LZV/T4leNvL5JlOFX88ISc4geh3T7xgT2FFhAW3oWJaSB+hR7SwZmZxWS0ptK0YeMaEtpFwWEwAFXyfzHpe4dZdNRcwOo7+AN1RFnOSYFO1sU+7wR/VsB47q81TsUIe1DNPqGctYRzlUOsUJYaJ34s65Ib2YQPOG/ENLklIxLI7tVHEPkdHxubmMH4VDFqgINQITNfknx6O1DuCosgvulAJXKoZ37DIkp9algxCb3xv3FHF6+/JN/3HtrghvSpbcMBfIkwOBIEH2pwGTfX3WWxucMMbKmp1TwMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua0BXbLR3aM8CkftHphBGrDrg8UpUc55dReUPDlo1MM=;
 b=J8j5l9QRAY1TgWzXr4leNA5jloi+CEt5c2YDLVkAKxf2dQZLrmrY6uF2wwi3/Nv7YJ4D3BpjPinDyAGVc9EWCMLqXH/3MZfgTwmFaBo0iusNcmN5wFFSZDEioHrFEOj3C6OVZPHmDlQLD/0JawNuz3MTp7bzEVYbT79qVQ9PSMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by PH0PR22MB3911.namprd22.prod.outlook.com (2603:10b6:510:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 18:54:17 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 18:54:17 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH 2/4] arm64: dts: ti: Add am62x-phyboard-lyra carrier board
Date: Tue, 25 Jun 2024 11:54:00 -0700
Message-Id: <20240625185402.1896623-2-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625185402.1896623-1-ggiordano@phytec.com>
References: <20240625185402.1896623-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:610:50::31) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|PH0PR22MB3911:EE_
X-MS-Office365-Filtering-Correlation-Id: 323385fe-4a96-4e97-0177-08dc9548371c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|366014|7416012|376012|52116012|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+so2FQLBN/rZ4PqP7i9MXG90VRUobuzKOqyHhFU/5IknAWdKGtx7sZw3eiWn?=
 =?us-ascii?Q?8nBiHysr/iI2h22kjSt1zm6HfK9kegSz85VBdMNsOSqVAcSKwfgnrdAmbVIH?=
 =?us-ascii?Q?3+f5Dj1TVofDjtXnQv3AZoh8r+5zx9ZwadyyNIyh21ThJvIkufy4HTBvbfQW?=
 =?us-ascii?Q?VqQyINQ7rey/rgonPYUfcoq0VllNgPKi5R71cbqeoiuQAMnOxGJQ7FI6mTJx?=
 =?us-ascii?Q?uCxCaXAv6WWK1prvdaz8HD9bL8HuqLPNlIEZenpMnd3B9Z5GyhrZCvGE6oyN?=
 =?us-ascii?Q?EMbWfnoY3LM4UHPDmiijyGoUdNp/57VyBszfGPThKyYoXjPuli/iUHbS8G59?=
 =?us-ascii?Q?F25gyFeGNjVqFaSzRceTYz5/Y/lGqYQq9Z2OwJ5cbBqkh/wXJh7JyFZzzVuN?=
 =?us-ascii?Q?IheZyHosS9V03WQvCmUsO2Zz4ORnyD8VKrBnw5aJxfRurkCxddWMEim8Fqft?=
 =?us-ascii?Q?NzCYU6ODhqPqNEKBIYu9i/xRVkj2CqyV+gnvnzfEGwNRsFdy/hiPaBU/kzpL?=
 =?us-ascii?Q?td2+Cr1zd9cCFDmxOJj4Vp+tmh+/oxqKXHEDLJy3Qb9XtyI+jxgPH88sH55L?=
 =?us-ascii?Q?fqFrnCs/L/4dxFszeF2Z0kSKA/2VGhRlNELZcY6fV4+1n00LD7EEizcCiq7d?=
 =?us-ascii?Q?7yb8J+8+sCjmsWgGgz6cgQ2Ko2x6mTNCu0TUsP9FlBwNz26K0bt4MqpF6Zvi?=
 =?us-ascii?Q?9ENnxn+uE/rn3MWkONJ13mWfGEyJ9qC67dItnVj6CTnU0A30a6dO0G1FDgBI?=
 =?us-ascii?Q?Qm6vmebX+1xliweqib5SD0MXM6l+qpLRjS5g9F6EhGgQr0Y93rDgcU6VLp5p?=
 =?us-ascii?Q?DGDYMunLiJPtV4mvZu6wMn27WNoC+qC0wBSuqzQ58gafRHlB+C6f49333LNe?=
 =?us-ascii?Q?ZGdjuH5QfAY4w/TJmYoIntMndI9M1+kwWSf1FHWVI228Y1OgRUruMsC6Ad7G?=
 =?us-ascii?Q?Xw3fR2hqjLyhtdcU5vh0mkzbv9PumdKltjNYwQfjE/hEXDvaCbQfa4wEQFk/?=
 =?us-ascii?Q?lQRLmV5Kf3cRugagYbkKMwOCrpg1PAhaSln1X1sigzN/PJcgQlvuzl8OTAkp?=
 =?us-ascii?Q?S89BoHxLX1KLpu48TNooJx9Rw6GW4KorPdL72MMatvo+yauaeuULiaDCYGxh?=
 =?us-ascii?Q?qy31d6/Zxvcrb3K0yfTiADLEF7zHYqMs+bGSHgGjfY1hJO2WohhvEQFLdtVh?=
 =?us-ascii?Q?YrlO4o0CvTH2l6fAA+JU3waYmpSIfQLSMDX+feGoAPykiu+0EIfFS81AsrDX?=
 =?us-ascii?Q?Yw6Dves/f+JxfBjtqsLZOG2AzkAPkjjMs9VTT6j5+rY/IdPByftKdgYe7JyW?=
 =?us-ascii?Q?Ar/yiCM4usPB9CVbWKri9sQj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(52116012)(38350700012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?INcFL9A8afHsj7fWT1c31E/2LO03KkP7s7rjp4z6PjgptUTaoO+cER0HvWow?=
 =?us-ascii?Q?VgSCh4KY1MYqGSjw3TR9sUw2IP4QMBbQ5jONtcB55xKnVCv//a6hl/upbBVD?=
 =?us-ascii?Q?AdKPGeqSfHH4leg2aD7v5GfVwqdLx04syF+R1Wty+w592NTBGPAp5i6w/zfN?=
 =?us-ascii?Q?2Ir6K4MAcEuqGgEqYUyRIZBIvDA33jjG2P2O1FKc4zxb+F8fz3E9AdBgaI6o?=
 =?us-ascii?Q?3Oq1LLGgtI596An33O200Fgjunv95GoG2yuJUQzPXQfNxAjyVa2T/yyJqDhs?=
 =?us-ascii?Q?H8wOmBRjugbVuuxSX1gznNq6fmbbtkMiXLrH/1+RVUHW/xD8VBZ24u7kr/4m?=
 =?us-ascii?Q?t/Fj1Tmwk59fGY2OWbebw0TPs/pPNroyR2e/pSH5SK9dC2zRAQwwn2uCAZPt?=
 =?us-ascii?Q?ZhCp7jNXRNfrxXB9SfkPsi/RXcvOGTUr7HeqbctxlAQunpG7btY113jgvw3U?=
 =?us-ascii?Q?MfTjJVt8W+B8g3O25gi9Ac+W5DuLsPiISOAPpdMmeXOgQXMdu5t0FbXaTfvK?=
 =?us-ascii?Q?hKE46fIQArCE/O/ha4YIXzNioNR0knqDILSf0jGMQeN57YEwD27gKJPESmgj?=
 =?us-ascii?Q?3wS6mm9hlKw4pHuGa235TPhjbv63K53DKIZxjx8U0jqRCygNniUdERh4m7YY?=
 =?us-ascii?Q?dDcwibLElhCJ37BRYgPwrxgG5tewuXAT6LkhLUlLfddEg1wY2xEZuYdEQ0WI?=
 =?us-ascii?Q?G6jLBB/RsFrO9Kie5+qBzW29qqFG22OzjiTyDHD7vvtSw3+8nUOMTJgsxJhr?=
 =?us-ascii?Q?yCyOHnK+aAaK9y5EOFIlJPU3MhYurF4sIVklIEn4wLjwltEIAfq9MTfrROtg?=
 =?us-ascii?Q?QDuJJ6SimP13+OJiGmPM+NJ4aDDjNsQdudSPXUJudadjKJSWdENtsx/biY46?=
 =?us-ascii?Q?34gLPA6waW9HN4mxKS9oI+vTEFwlFBtbAt4H/OribVMtftA9i9f1KuHv+Dfa?=
 =?us-ascii?Q?vDdUU9a/gWDHxdZ8Nf8Je3efo+c2mBj3r1gUQwITZ3qxhl9KcDEpmIy5aBv6?=
 =?us-ascii?Q?fw2856FXvAbkWsBZJPIBWeXsRqiNXx5br8yrJxXeV/wLz0ohQuE6O+nO/kPx?=
 =?us-ascii?Q?E7JwdcgJzEv9asJqpF+70TfFLw50Cn2B0ZxCFj/sER8v+1KuZnkKftNSrU6I?=
 =?us-ascii?Q?b2jYEdCFVySMWLksr2ES9NpLIsCgcNikdDQjvZIlEwdBYaIkUDePLOSLh8Id?=
 =?us-ascii?Q?KE2+2pfnAGGWYgPaTV9Eye1MWa+uZlcjDo8GXvGxOTC9SZE0ZpkECT9UtJRH?=
 =?us-ascii?Q?2dB3RgUcOIrNY7xrf8Zv5emc48lnVTelIyuv5DaGT46br5KeNNTFYNtt1gg5?=
 =?us-ascii?Q?FXibJricg9WRkRkvnqAg/d7DR4tNumFDEeIR2DfHdddWrnEgUTJd+3JJ5QR9?=
 =?us-ascii?Q?ayrG4IFfP74sGRZ6y6lWgwh732QqZlmznwj2oeQ4BK9+v0XGlRUJb/dbq2Dp?=
 =?us-ascii?Q?xYa2mhjk3hNWM6JTAqB5seX/tTTDG24Wtqd0z4HgsOkpZ0dipwPYPvsm5jDR?=
 =?us-ascii?Q?/WHAoJvm9FNRxMxPsUjZCsqHk6T8m1eyeL/QwY66wYgN9XV27KwKDt7vNPre?=
 =?us-ascii?Q?u0jjf2TS65w8bUkEgECW5ZlCaXKCrTSAVG2Jpex3?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323385fe-4a96-4e97-0177-08dc9548371c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 18:54:17.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3NtvQXj2w/Y+N/8QrTqKsJHx95GwYS3AD4LQdl6OSyWoIDUQDlAMwe5wgdNJCQChK8/jbTKwCclAIGTRtYRpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR22MB3911

PHYTECs phyBOARD-Lyra carrier board is able to accomidate multiple SoMs.
Refactor k3-am625-phyboard-lyra-rdk.dts into an include file so it can
be reused in combination with our phyCORE-AM62Ax SoM.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 .../dts/ti/k3-am625-phyboard-lyra-rdk.dts     | 467 +----------------
 .../boot/dts/ti/k3-am62x-phyboard-lyra.dtsi   | 475 ++++++++++++++++++
 2 files changed, 476 insertions(+), 466 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
index 50d2573c840e..4fa5efdffcd7 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
@@ -7,477 +7,12 @@
  * https://www.phytec.com/product/phyboard-am62x
  */
 
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/net/ti-dp83867.h>
 #include "k3-am625.dtsi"
 #include "k3-am62-phycore-som.dtsi"
+#include "k3-am62x-phyboard-lyra.dtsi"
 
 / {
 	compatible = "phytec,am625-phyboard-lyra-rdk",
 		     "phytec,am62-phycore-som", "ti,am625";
 	model = "PHYTEC phyBOARD-Lyra AM625";
-
-	aliases {
-		serial2 = &main_uart0;
-		serial3 = &main_uart1;
-		mmc1 = &sdhci1;
-		usb0 = &usb0;
-		usb1 = &usb1;
-		ethernet1 = &cpsw_port2;
-	};
-
-	can_tc1: can-phy0 {
-		compatible = "ti,tcan1042";
-		#phy-cells = <0>;
-		max-bitrate = <8000000>;
-		standby-gpios = <&gpio_exp 1 GPIO_ACTIVE_HIGH>;
-	};
-
-	hdmi0: connector-hdmi {
-		compatible = "hdmi-connector";
-		label = "hdmi";
-		type = "a";
-
-		port {
-			hdmi_connector_in: endpoint {
-				remote-endpoint = <&sii9022_out>;
-			};
-		};
-	};
-
-	keys {
-		compatible = "gpio-keys";
-		autorepeat;
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_keys_pins_default>;
-
-		key-home {
-			label = "home";
-			linux,code = <KEY_HOME>;
-			gpios = <&main_gpio1 23 GPIO_ACTIVE_HIGH>;
-		};
-
-		key-menu {
-			label = "menu";
-			linux,code = <KEY_MENU>;
-			gpios = <&gpio_exp 4 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "phyBOARD-Lyra";
-		simple-audio-card,widgets =
-			"Microphone",           "Mic Jack",
-			"Headphone",            "Headphone Jack",
-			"Speaker",              "External Speaker";
-		simple-audio-card,routing =
-			"MIC3R",                "Mic Jack",
-			"Mic Jack",             "Mic Bias",
-			"Headphone Jack",       "HPLOUT",
-			"Headphone Jack",       "HPROUT",
-			"External Speaker",     "SPOP",
-			"External Speaker",     "SPOM";
-		simple-audio-card,format = "dsp_b";
-		simple-audio-card,bitclock-master = <&sound_master>;
-		simple-audio-card,frame-master = <&sound_master>;
-		simple-audio-card,bitclock-inversion;
-
-		simple-audio-card,cpu {
-			sound-dai = <&mcasp2>;
-		};
-
-		sound_master: simple-audio-card,codec {
-				sound-dai = <&audio_codec>;
-				clocks = <&audio_refclk1>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&leds_pins_default>, <&user_leds_pins_default>;
-
-		led-1 {
-			gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc0";
-		};
-
-		led-2 {
-			gpios = <&gpio_exp 2 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "mmc1";
-		};
-	};
-
-	vcc_1v8: regulator-vcc-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vcc_3v3_mmc: regulator-vcc-3v3-mmc {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_3V3_MMC";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vcc_3v3_sw: regulator-vcc-3v3-sw {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_3V3_SW";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-};
-
-&main_pmx0 {
-	audio_ext_refclk1_pins_default: audio-ext-refclk1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x0a0, PIN_OUTPUT, 1) /* (K25) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
-		>;
-	};
-
-	gpio_keys_pins_default: gpio-keys-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
-		>;
-	};
-
-	gpio_exp_int_pins_default: gpio-exp-int-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x244, PIN_INPUT, 7) /* (C17) MMC1_SDWP.GPIO1_49 */
-		>;
-	};
-
-	hdmi_int_pins_default: hdmi-int-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x040, PIN_INPUT, 7) /* (N23) GPMC0_AD1.GPIO0_16 */
-		>;
-	};
-
-	main_dss0_pins_default: main-dss0-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (U22) VOUT0_DATA0 */
-			AM62X_IOPAD(0x0bc, PIN_OUTPUT, 0) /* (V24) VOUT0_DATA1 */
-			AM62X_IOPAD(0x0e0, PIN_OUTPUT, 0) /* (V20) VOUT0_DATA10 */
-			AM62X_IOPAD(0x0e4, PIN_OUTPUT, 0) /* (AA23) VOUT0_DATA11 */
-			AM62X_IOPAD(0x0e8, PIN_OUTPUT, 0) /* (AB25) VOUT0_DATA12 */
-			AM62X_IOPAD(0x0ec, PIN_OUTPUT, 0) /* (AA24) VOUT0_DATA13 */
-			AM62X_IOPAD(0x0f0, PIN_OUTPUT, 0) /* (Y22) VOUT0_DATA14 */
-			AM62X_IOPAD(0x0f4, PIN_OUTPUT, 0) /* (AA21) VOUT0_DATA15 */
-			AM62X_IOPAD(0x0c0, PIN_OUTPUT, 0) /* (W25) VOUT0_DATA2 */
-			AM62X_IOPAD(0x0c4, PIN_OUTPUT, 0) /* (W24) VOUT0_DATA3 */
-			AM62X_IOPAD(0x0c8, PIN_OUTPUT, 0) /* (Y25) VOUT0_DATA4 */
-			AM62X_IOPAD(0x0cc, PIN_OUTPUT, 0) /* (Y24) VOUT0_DATA5 */
-			AM62X_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (Y23) VOUT0_DATA6 */
-			AM62X_IOPAD(0x0d4, PIN_OUTPUT, 0) /* (AA25) VOUT0_DATA7 */
-			AM62X_IOPAD(0x0d8, PIN_OUTPUT, 0) /* (V21) VOUT0_DATA8 */
-			AM62X_IOPAD(0x0dc, PIN_OUTPUT, 0) /* (W21) VOUT0_DATA9 */
-			AM62X_IOPAD(0x0fc, PIN_OUTPUT, 0) /* (Y20) VOUT0_DE */
-			AM62X_IOPAD(0x0f8, PIN_OUTPUT, 0) /* (AB24) VOUT0_HSYNC */
-			AM62X_IOPAD(0x104, PIN_OUTPUT, 0) /* (AC24) VOUT0_PCLK */
-			AM62X_IOPAD(0x100, PIN_OUTPUT, 0) /* (AC25) VOUT0_VSYNC */
-		>;
-	};
-
-	main_i2c1_pins_default: main-i2c1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
-			AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
-		>;
-	};
-
-	main_mcan0_pins_default: main-mcan0-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1dc, PIN_INPUT, 0) /* (E15) MCAN0_RX */
-			AM62X_IOPAD(0x1d8, PIN_OUTPUT, 0) /* (C15) MCAN0_TX */
-		>;
-	};
-
-	main_mcasp2_pins_default: main-mcasp2-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x070, PIN_INPUT, 3) /* (T24) GPMC0_AD13.MCASP2_ACLKX */
-			AM62X_IOPAD(0x06c, PIN_INPUT, 3) /* (T22) GPMC0_AD12.MCASP2_AFSX */
-			AM62X_IOPAD(0x064, PIN_OUTPUT, 3) /* (T25) GPMC0_AD10.MCASP2_AXR2 */
-			AM62X_IOPAD(0x068, PIN_INPUT, 3) /* (R21) GPMC0_AD11.MCASP2_AXR3 */
-		>;
-	};
-
-	main_mmc1_pins_default: main-mmc1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x23c, PIN_INPUT_PULLUP, 0) /* (A21) MMC1_CMD */
-			AM62X_IOPAD(0x234, PIN_INPUT_PULLDOWN, 0) /* (B22) MMC1_CLK */
-			AM62X_IOPAD(0x230, PIN_INPUT_PULLUP, 0) /* (A22) MMC1_DAT0 */
-			AM62X_IOPAD(0x22c, PIN_INPUT_PULLUP, 0) /* (B21) MMC1_DAT1 */
-			AM62X_IOPAD(0x228, PIN_INPUT_PULLUP, 0) /* (C21) MMC1_DAT2 */
-			AM62X_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (D22) MMC1_DAT3 */
-			AM62X_IOPAD(0x240, PIN_INPUT_PULLUP, 0) /* (D17) MMC1_SDCD */
-		>;
-	};
-
-	main_rgmii2_pins_default: main-rgmii2-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x184, PIN_INPUT, 0) /* (AE23) RGMII2_RD0 */
-			AM62X_IOPAD(0x188, PIN_INPUT, 0) /* (AB20) RGMII2_RD1 */
-			AM62X_IOPAD(0x18c, PIN_INPUT, 0) /* (AC21) RGMII2_RD2 */
-			AM62X_IOPAD(0x190, PIN_INPUT, 0) /* (AE22) RGMII2_RD3 */
-			AM62X_IOPAD(0x180, PIN_INPUT, 0) /* (AD23) RGMII2_RXC */
-			AM62X_IOPAD(0x17c, PIN_INPUT, 0) /* (AD22) RGMII2_RX_CTL */
-			AM62X_IOPAD(0x16c, PIN_OUTPUT, 0) /* (Y18) RGMII2_TD0 */
-			AM62X_IOPAD(0x170, PIN_OUTPUT, 0) /* (AA18) RGMII2_TD1 */
-			AM62X_IOPAD(0x174, PIN_OUTPUT, 0) /* (AD21) RGMII2_TD2 */
-			AM62X_IOPAD(0x178, PIN_OUTPUT, 0) /* (AC20) RGMII2_TD3 */
-			AM62X_IOPAD(0x168, PIN_OUTPUT, 0) /* (AE21) RGMII2_TXC */
-			AM62X_IOPAD(0x164, PIN_OUTPUT, 0) /* (AA19) RGMII2_TX_CTL */
-		>;
-	};
-
-	main_uart0_pins_default: main-uart0-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
-			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
-		>;
-	};
-
-	main_uart1_pins_default: main-uart1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x194, PIN_INPUT, 2) /* (B19) MCASP0_AXR3.UART1_CTSn */
-			AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19) MCASP0_AXR2.UART1_RTSn */
-			AM62X_IOPAD(0x1ac, PIN_INPUT, 2) /* (E19) MCASP0_AFSR.UART1_RXD */
-			AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20) MCASP0_ACLKR.UART1_TXD */
-		>;
-	};
-
-	main_usb1_pins_default: main-usb1-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x258, PIN_OUTPUT, 0) /* (F18) USB1_DRVVBUS */
-		>;
-	};
-
-	user_leds_pins_default: user-leds-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x084, PIN_OUTPUT, 7) /* (L23) GPMC0_ADVn_ALE.GPIO0_32 */
-		>;
-	};
-};
-
-&cpsw3g {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_rgmii1_pins_default>, <&main_rgmii2_pins_default>;
-};
-
-&cpsw_port2 {
-	phy-mode = "rgmii-rxid";
-	phy-handle = <&cpsw3g_phy3>;
-};
-
-&cpsw3g_mdio {
-	cpsw3g_phy3: ethernet-phy@3 {
-		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
-		reg = <3>;
-		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
-		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-	};
-};
-
-&dss {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_dss0_pins_default>;
-	status = "okay";
-};
-
-&dss_ports {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	/* VP2: DPI/HDMI Output */
-	port@1 {
-		reg = <1>;
-
-		dpi1_out: endpoint {
-			remote-endpoint = <&sii9022_in>;
-		};
-	};
-};
-
-&main_i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c1_pins_default>;
-	clock-frequency = <100000>;
-	status = "okay";
-
-	audio_codec: audio-codec@18 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&audio_ext_refclk1_pins_default>;
-
-		#sound-dai-cells = <0>;
-		compatible = "ti,tlv320aic3007";
-		reg = <0x18>;
-		ai3x-micbias-vg = <2>;
-
-		AVDD-supply = <&vcc_3v3_sw>;
-		IOVDD-supply = <&vcc_3v3_sw>;
-		DRVDD-supply = <&vcc_3v3_sw>;
-		DVDD-supply = <&vcc_1v8>;
-	};
-
-	gpio_exp: gpio-expander@21 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&gpio_exp_int_pins_default>;
-		compatible = "nxp,pcf8574";
-		reg = <0x21>;
-		interrupt-parent = <&main_gpio1>;
-		interrupts = <49 0>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		gpio-line-names = "", "GPIO1_CAN0_nEN",
-				  "GPIO2_LED2", "GPIO3_LVDS_GPIO",
-				  "GPIO4_BUT2", "GPIO5_LVDS_BKLT_EN",
-				  "GPIO6_ETH1_USER_RESET", "GPIO7_AUDIO_USER_RESET";
-	};
-
-	usb-pd@22 {
-		compatible = "ti,tps6598x";
-		reg = <0x22>;
-
-		connector {
-			compatible = "usb-c-connector";
-			label = "USB-C";
-			self-powered;
-			data-role = "dual";
-			power-role = "sink";
-			port {
-				usb_con_hs: endpoint {
-					remote-endpoint = <&typec_hs>;
-				};
-			};
-		};
-	};
-
-	sii9022: bridge-hdmi@39 {
-		compatible = "sil,sii9022";
-		reg = <0x39>;
-
-		interrupt-parent = <&main_gpio0>;
-		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&hdmi_int_pins_default>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				sii9022_in: endpoint {
-					remote-endpoint = <&dpi1_out>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-
-				sii9022_out: endpoint {
-					remote-endpoint = <&hdmi_connector_in>;
-				};
-			};
-		};
-	};
-
-	eeprom@51 {
-		compatible = "atmel,24c02";
-		pagesize = <16>;
-		reg = <0x51>;
-	};
-};
-
-&main_mcan0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mcan0_pins_default>;
-	phys = <&can_tc1>;
-	status = "okay";
-};
-
-&main_uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart0_pins_default>;
-	status = "okay";
-};
-
-&main_uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart1_pins_default>;
-	/* Main UART1 may be used by TIFS firmware */
-	status = "okay";
-};
-
-&mcasp2 {
-	#sound-dai-cells = <0>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mcasp2_pins_default>;
-
-	/* MCASP_IIS_MODE */
-	op-mode = <0>;
-	tdm-slots = <2>;
-
-	/* 0: INACTIVE, 1: TX, 2: RX */
-	serial-dir = <
-			0 0 1 2
-			0 0 0 0
-			0 0 0 0
-			0 0 0 0
-	>;
-	tx-num-evt = <32>;
-	rx-num-evt = <32>;
-	status = "okay";
-};
-
-&sdhci1 {
-	vmmc-supply = <&vcc_3v3_mmc>;
-	vqmmc-supply = <&vddshv5_sdio>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc1_pins_default>;
-	disable-wp;
-	no-1-8-v;
-	status = "okay";
-};
-
-&usbss0 {
-	ti,vbus-divider;
-	status = "okay";
-};
-
-&usbss1 {
-	ti,vbus-divider;
-	status = "okay";
-};
-
-&usb0 {
-	usb-role-switch;
-
-	port {
-		typec_hs: endpoint {
-			remote-endpoint = <&usb_con_hs>;
-		};
-	};
-};
-
-&usb1 {
-	dr_mode = "host";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_usb1_pins_default>;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
new file mode 100644
index 000000000000..e4633af87eb9
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2022-2024 PHYTEC Messtechnik GmbH
+ * Author: Wadim Egorov <w.egorov@phytec.de>
+ *
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	aliases {
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		mmc1 = &sdhci1;
+		usb0 = &usb0;
+		usb1 = &usb1;
+		ethernet1 = &cpsw_port2;
+	};
+
+	can_tc1: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <8000000>;
+		standby-gpios = <&gpio_exp 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	hdmi0: connector-hdmi {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&sii9022_out>;
+			};
+		};
+	};
+
+	keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_pins_default>;
+
+		key-home {
+			label = "home";
+			linux,code = <KEY_HOME>;
+			gpios = <&main_gpio1 23 GPIO_ACTIVE_HIGH>;
+		};
+
+		key-menu {
+			label = "menu";
+			linux,code = <KEY_MENU>;
+			gpios = <&gpio_exp 4 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "phyBOARD-Lyra";
+		simple-audio-card,widgets =
+			"Microphone",           "Mic Jack",
+			"Headphone",            "Headphone Jack",
+			"Speaker",              "External Speaker";
+		simple-audio-card,routing =
+			"MIC3R",                "Mic Jack",
+			"Mic Jack",             "Mic Bias",
+			"Headphone Jack",       "HPLOUT",
+			"Headphone Jack",       "HPROUT",
+			"External Speaker",     "SPOP",
+			"External Speaker",     "SPOM";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+		simple-audio-card,bitclock-inversion;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp2>;
+		};
+
+		sound_master: simple-audio-card,codec {
+				sound-dai = <&audio_codec>;
+				clocks = <&audio_refclk1>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_pins_default>, <&user_leds_pins_default>;
+
+		led-1 {
+			gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc0";
+		};
+
+		led-2 {
+			gpios = <&gpio_exp 2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc1";
+		};
+	};
+
+	vcc_1v8: regulator-vcc-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_3v3_mmc: regulator-vcc-3v3-mmc {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3_MMC";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_3v3_sw: regulator-vcc-3v3-sw {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3_SW";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&main_pmx0 {
+	audio_ext_refclk1_pins_default: audio-ext-refclk1-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0a0, PIN_OUTPUT, 1) /* (K25) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
+		>;
+	};
+
+	gpio_keys_pins_default: gpio-keys-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
+		>;
+	};
+
+	gpio_exp_int_pins_default: gpio-exp-int-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x244, PIN_INPUT, 7) /* (C17) MMC1_SDWP.GPIO1_49 */
+		>;
+	};
+
+	hdmi_int_pins_default: hdmi-int-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x040, PIN_INPUT, 7) /* (N23) GPMC0_AD1.GPIO0_16 */
+		>;
+	};
+
+	main_dss0_pins_default: main-dss0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (U22) VOUT0_DATA0 */
+			AM62X_IOPAD(0x0bc, PIN_OUTPUT, 0) /* (V24) VOUT0_DATA1 */
+			AM62X_IOPAD(0x0e0, PIN_OUTPUT, 0) /* (V20) VOUT0_DATA10 */
+			AM62X_IOPAD(0x0e4, PIN_OUTPUT, 0) /* (AA23) VOUT0_DATA11 */
+			AM62X_IOPAD(0x0e8, PIN_OUTPUT, 0) /* (AB25) VOUT0_DATA12 */
+			AM62X_IOPAD(0x0ec, PIN_OUTPUT, 0) /* (AA24) VOUT0_DATA13 */
+			AM62X_IOPAD(0x0f0, PIN_OUTPUT, 0) /* (Y22) VOUT0_DATA14 */
+			AM62X_IOPAD(0x0f4, PIN_OUTPUT, 0) /* (AA21) VOUT0_DATA15 */
+			AM62X_IOPAD(0x0c0, PIN_OUTPUT, 0) /* (W25) VOUT0_DATA2 */
+			AM62X_IOPAD(0x0c4, PIN_OUTPUT, 0) /* (W24) VOUT0_DATA3 */
+			AM62X_IOPAD(0x0c8, PIN_OUTPUT, 0) /* (Y25) VOUT0_DATA4 */
+			AM62X_IOPAD(0x0cc, PIN_OUTPUT, 0) /* (Y24) VOUT0_DATA5 */
+			AM62X_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (Y23) VOUT0_DATA6 */
+			AM62X_IOPAD(0x0d4, PIN_OUTPUT, 0) /* (AA25) VOUT0_DATA7 */
+			AM62X_IOPAD(0x0d8, PIN_OUTPUT, 0) /* (V21) VOUT0_DATA8 */
+			AM62X_IOPAD(0x0dc, PIN_OUTPUT, 0) /* (W21) VOUT0_DATA9 */
+			AM62X_IOPAD(0x0fc, PIN_OUTPUT, 0) /* (Y20) VOUT0_DE */
+			AM62X_IOPAD(0x0f8, PIN_OUTPUT, 0) /* (AB24) VOUT0_HSYNC */
+			AM62X_IOPAD(0x104, PIN_OUTPUT, 0) /* (AC24) VOUT0_PCLK */
+			AM62X_IOPAD(0x100, PIN_OUTPUT, 0) /* (AC25) VOUT0_VSYNC */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
+			AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
+		>;
+	};
+
+	main_mcan0_pins_default: main-mcan0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1dc, PIN_INPUT, 0) /* (E15) MCAN0_RX */
+			AM62X_IOPAD(0x1d8, PIN_OUTPUT, 0) /* (C15) MCAN0_TX */
+		>;
+	};
+
+	main_mcasp2_pins_default: main-mcasp2-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x070, PIN_INPUT, 3) /* (T24) GPMC0_AD13.MCASP2_ACLKX */
+			AM62X_IOPAD(0x06c, PIN_INPUT, 3) /* (T22) GPMC0_AD12.MCASP2_AFSX */
+			AM62X_IOPAD(0x064, PIN_OUTPUT, 3) /* (T25) GPMC0_AD10.MCASP2_AXR2 */
+			AM62X_IOPAD(0x068, PIN_INPUT, 3) /* (R21) GPMC0_AD11.MCASP2_AXR3 */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x23c, PIN_INPUT_PULLUP, 0) /* (A21) MMC1_CMD */
+			AM62X_IOPAD(0x234, PIN_INPUT_PULLDOWN, 0) /* (B22) MMC1_CLK */
+			AM62X_IOPAD(0x230, PIN_INPUT_PULLUP, 0) /* (A22) MMC1_DAT0 */
+			AM62X_IOPAD(0x22c, PIN_INPUT_PULLUP, 0) /* (B21) MMC1_DAT1 */
+			AM62X_IOPAD(0x228, PIN_INPUT_PULLUP, 0) /* (C21) MMC1_DAT2 */
+			AM62X_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (D22) MMC1_DAT3 */
+			AM62X_IOPAD(0x240, PIN_INPUT_PULLUP, 0) /* (D17) MMC1_SDCD */
+		>;
+	};
+
+	main_rgmii2_pins_default: main-rgmii2-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x184, PIN_INPUT, 0) /* (AE23) RGMII2_RD0 */
+			AM62X_IOPAD(0x188, PIN_INPUT, 0) /* (AB20) RGMII2_RD1 */
+			AM62X_IOPAD(0x18c, PIN_INPUT, 0) /* (AC21) RGMII2_RD2 */
+			AM62X_IOPAD(0x190, PIN_INPUT, 0) /* (AE22) RGMII2_RD3 */
+			AM62X_IOPAD(0x180, PIN_INPUT, 0) /* (AD23) RGMII2_RXC */
+			AM62X_IOPAD(0x17c, PIN_INPUT, 0) /* (AD22) RGMII2_RX_CTL */
+			AM62X_IOPAD(0x16c, PIN_OUTPUT, 0) /* (Y18) RGMII2_TD0 */
+			AM62X_IOPAD(0x170, PIN_OUTPUT, 0) /* (AA18) RGMII2_TD1 */
+			AM62X_IOPAD(0x174, PIN_OUTPUT, 0) /* (AD21) RGMII2_TD2 */
+			AM62X_IOPAD(0x178, PIN_OUTPUT, 0) /* (AC20) RGMII2_TD3 */
+			AM62X_IOPAD(0x168, PIN_OUTPUT, 0) /* (AE21) RGMII2_TXC */
+			AM62X_IOPAD(0x164, PIN_OUTPUT, 0) /* (AA19) RGMII2_TX_CTL */
+		>;
+	};
+
+	main_uart0_pins_default: main-uart0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
+			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
+		>;
+	};
+
+	main_uart1_pins_default: main-uart1-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x194, PIN_INPUT, 2) /* (B19) MCASP0_AXR3.UART1_CTSn */
+			AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19) MCASP0_AXR2.UART1_RTSn */
+			AM62X_IOPAD(0x1ac, PIN_INPUT, 2) /* (E19) MCASP0_AFSR.UART1_RXD */
+			AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20) MCASP0_ACLKR.UART1_TXD */
+		>;
+	};
+
+	main_usb1_pins_default: main-usb1-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x258, PIN_OUTPUT, 0) /* (F18) USB1_DRVVBUS */
+		>;
+	};
+
+	user_leds_pins_default: user-leds-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x084, PIN_OUTPUT, 7) /* (L23) GPMC0_ADVn_ALE.GPIO0_32 */
+		>;
+	};
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_rgmii1_pins_default>, <&main_rgmii2_pins_default>;
+};
+
+&cpsw_port2 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy3>;
+};
+
+&cpsw3g_mdio {
+	cpsw3g_phy3: ethernet-phy@3 {
+		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
+		reg = <3>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+};
+
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_dss0_pins_default>;
+	status = "okay";
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* VP2: DPI/HDMI Output */
+	port@1 {
+		reg = <1>;
+
+		dpi1_out: endpoint {
+			remote-endpoint = <&sii9022_in>;
+		};
+	};
+};
+
+&main_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	audio_codec: audio-codec@18 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&audio_ext_refclk1_pins_default>;
+
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3007";
+		reg = <0x18>;
+		ai3x-micbias-vg = <2>;
+
+		AVDD-supply = <&vcc_3v3_sw>;
+		IOVDD-supply = <&vcc_3v3_sw>;
+		DRVDD-supply = <&vcc_3v3_sw>;
+		DVDD-supply = <&vcc_1v8>;
+	};
+
+	gpio_exp: gpio-expander@21 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_exp_int_pins_default>;
+		compatible = "nxp,pcf8574";
+		reg = <0x21>;
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <49 0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-line-names = "", "GPIO1_CAN0_nEN",
+				  "GPIO2_LED2", "GPIO3_LVDS_GPIO",
+				  "GPIO4_BUT2", "GPIO5_LVDS_BKLT_EN",
+				  "GPIO6_ETH1_USER_RESET", "GPIO7_AUDIO_USER_RESET";
+	};
+
+	usb-pd@22 {
+		compatible = "ti,tps6598x";
+		reg = <0x22>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			self-powered;
+			data-role = "dual";
+			power-role = "sink";
+			port {
+				usb_con_hs: endpoint {
+					remote-endpoint = <&typec_hs>;
+				};
+			};
+		};
+	};
+
+	sii9022: bridge-hdmi@39 {
+		compatible = "sil,sii9022";
+		reg = <0x39>;
+
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_int_pins_default>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+
+	eeprom@51 {
+		compatible = "atmel,24c02";
+		pagesize = <16>;
+		reg = <0x51>;
+	};
+};
+
+&main_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan0_pins_default>;
+	phys = <&can_tc1>;
+	status = "okay";
+};
+
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+	status = "okay";
+};
+
+&main_uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
+	/* Main UART1 may be used by TIFS firmware */
+	status = "okay";
+};
+
+&mcasp2 {
+	#sound-dai-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcasp2_pins_default>;
+
+	/* MCASP_IIS_MODE */
+	op-mode = <0>;
+	tdm-slots = <2>;
+
+	/* 0: INACTIVE, 1: TX, 2: RX */
+	serial-dir = <
+			0 0 1 2
+			0 0 0 0
+			0 0 0 0
+			0 0 0 0
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+	status = "okay";
+};
+
+&sdhci1 {
+	vmmc-supply = <&vcc_3v3_mmc>;
+	vqmmc-supply = <&vddshv5_sdio>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	disable-wp;
+	no-1-8-v;
+	status = "okay";
+};
+
+&usbss0 {
+	ti,vbus-divider;
+	status = "okay";
+};
+
+&usbss1 {
+	ti,vbus-divider;
+	status = "okay";
+};
+
+&usb0 {
+	usb-role-switch;
+
+	port {
+		typec_hs: endpoint {
+			remote-endpoint = <&usb_con_hs>;
+		};
+	};
+};
+
+&usb1 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb1_pins_default>;
+};
-- 
2.25.1


