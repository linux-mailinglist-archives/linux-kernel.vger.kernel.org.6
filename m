Return-Path: <linux-kernel+bounces-275800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013F19489F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98A4284DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE6D1BCA00;
	Tue,  6 Aug 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nFpv9vL4"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021086.outbound.protection.outlook.com [52.101.62.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C61BD4E4;
	Tue,  6 Aug 2024 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928758; cv=fail; b=r6yg4yt2YTdG1AfpIjW6xjSFusPHk67KV6adUhRfHGtJ0q2C3f1E+MjRP0fotZzP1VzJSU9vU3CWgdV8ozYaR7wpIK9AyhyL01wOvSwkEFwSHBD+0ETon/iOmG2xmU371iX2tLCDqRrPK7IjFlCONjIDMl26+QosevtAbqQzaPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928758; c=relaxed/simple;
	bh=sJJ13ho1S5LndsmQkKKiP2JBpBxnll6jYqvkevi7+fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m5+yjwn9LYAt26BySJQPi5W6s5K/x/HW8WQlA67F+iyBZlx+iS0qk96B4htY0nJuBSazNsMd5R+mMukNJtd6lcOHf4ZzHlKqjY+Dd9Ffgn2Su7tgu2kBXQJ57K0V+zOkGjxGSS3Ug76T1s6uNrsxC6zT77WmkIwP2/1qLEVICik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nFpv9vL4; arc=fail smtp.client-ip=52.101.62.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEDhX6QKiWWylweNHYpXqMghzl9TAAfyc8RNVdtPHmttZuoEhq2X7P+E8BjalUASd6hmGt3/Cp4aIFQQNF/ehVlq2GNYg5qszradhi9FwvvK/LavNUDnPvjgL1+71tj6JjSlFUzSDt57bCj8WI3oT1uS1JexOJ1PvTgtaASA/bisekIDjkd7jS+1IkEtY7Gz6W1lQRjD0RxGR+ahh09K4fAa2pGksEzHQkOXQnhOaQBAqdmqRhum5KE4kRi/hELqfoBFNH4pmT+EvEUxWVp6VZi6CIfY8f+tc2NL8IIRTu31jGx9JKUmB9Hd1eIOxSdmmTu51LyIark/Fvp/7e3qcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8fTsT/wmD3e7P8bdlXQ3b8HcpK52Ulj5xajjrlW/EQ=;
 b=cWKGewA5xF3W12zD0MHjOlQpDKT/PkTX5tK2WMABIajMeB0riyhvl1jmbFjEtQuNg8eM5cfO/TM3FeiYldTiLjhzw+zimlPA6aJJdYu0TxzQiXLXLXs+JFMAOq1sOQSvjwLnebdB6VWy9p+x7oMCjhnpDp+4PDIrCuntaJo4Ig00igouIvYmZX6ZQcRwVfYH3sJFloEgAcE/7Hem8AuHipTSjqikxPWhSv5bFSf+q9P+MEaxrbhblL7m+xfnrACDyhBx45f2tnmSijFMCwYyh9Isj9ieENYggXQiZg0qXdzkVVgVTwh2+pjaSmdU3bbhzjrj4YFvvY9WCgIKrq6gTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8fTsT/wmD3e7P8bdlXQ3b8HcpK52Ulj5xajjrlW/EQ=;
 b=nFpv9vL4f4rs3K0xcXj3zL2dNMQrNyJSZ4uAu8BRs/yyvkqXVpLMrKVvttqvI973A8/FvloE8OUE1o75xrmsMwcyYgzNbMee/gn27vzfJa5sOl8N3qArQgelBwExNYbvCDGco5PZocXC1HKoZeKXhXUi/eexIysHdaTXKp+h/4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7057.prod.exchangelabs.com (2603:10b6:208:35c::16) by
 BL1PR01MB7770.prod.exchangelabs.com (2603:10b6:208:399::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.25; Tue, 6 Aug 2024 07:19:14 +0000
Received: from BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09]) by BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09%4]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 07:19:14 +0000
From: Chanh Nguyen <chanh@os.amperecomputing.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: [PATCH v2 5/5] ARM: dts: aspeed: mtmitchell: Add LEDs
Date: Tue,  6 Aug 2024 07:18:06 +0000
Message-ID: <20240806071806.1666550-6-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
References: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To BL3PR01MB7057.prod.exchangelabs.com (2603:10b6:208:35c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7057:EE_|BL1PR01MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 70542a14-725a-44de-c47b-08dcb5e8130e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cvJSEjo2OvJdrSE9qhmBHMuJ0cmuJ04+pQFTfSHcwbsZRym9wBrv4RjuwUL4?=
 =?us-ascii?Q?cYfVtlr9i5qafnaI6w9I57H+LvW3IEQP/UDXRL6cjWoL/z0B2sYFssQocuCS?=
 =?us-ascii?Q?DjjGTS1lmHx5lEAt1TMi/NMSRXkosLK6dsEETizwDyPulc6BsuanqKxejMKJ?=
 =?us-ascii?Q?MvrgrwSTQ3DitT2smu+vhokwzdOSENGavDKgBbqYtrr+WQmI1MrYf2cCLi0n?=
 =?us-ascii?Q?jWy93U6M7PWGod6iTO93cp+QOtbGrJ6yU9erA+y0kVUogx82kI6Gwe8P7kW9?=
 =?us-ascii?Q?US9wOyA+mArRXfRlbtRr2NQNX9yc8GIBVI4RiKC8eCB0XgsD4Ijckq1pR7wl?=
 =?us-ascii?Q?PCbKg9VOwY9iJFjtfyw167InB2/f/NR6QnRHFLjiGrQ5Z0G539ecMenCCqCK?=
 =?us-ascii?Q?f3oukr3v1O040D+ZENT5e9Y9cA867T+aJrkOni96kamHSbXYV7T9kcyiSEZd?=
 =?us-ascii?Q?SlA59qw5AIa6nrBrCCntxmS/f4UPPmB0V9BOJ5p1TQnhuPdhPxCI2G7OmQ8O?=
 =?us-ascii?Q?HksFqt6T3J01eQ95EUDFe3Gn8BifLHHOvjYEYOfh5hboR1AsClV7xUpM6sUx?=
 =?us-ascii?Q?HCjL5GhdhrjqTngov3bNHvJMnLrA71PNqJd5lY7kNAIdvsR4Z+VNINhsI2hp?=
 =?us-ascii?Q?8BBDgtbqL93dD1iEf2jalYa2N6gW4gFnsU2gHN/YQuYr1L+noYwun1C0j0fA?=
 =?us-ascii?Q?2gKdWRL7BbPuaRJAE4MAXi72egvaCN5T7GHE7z9dULTi1VIisXI5tp6WFBQt?=
 =?us-ascii?Q?Fjf8r7i3hxAxb4MIA7jyDuMFpQmbOEEWzbeHH2rd1sUf6d5Znlq0UGZbgkgg?=
 =?us-ascii?Q?HiC3ZxFSv+UGi34YwtqnHsH8sKqBe7TUKtEmlr6xengH0UeGZwuWlxMGZlMI?=
 =?us-ascii?Q?RpMCbBj6ybFF0Z0Soc14YA9AXkcfYPgFfC7+nmEPqJMFJrb3fMPO5gjqTRFS?=
 =?us-ascii?Q?M2lr7ihP7UUm9gx4W4B/XPhiJqdOPYDnLGqCGstu8oN39PIxOnMuWRVPtPoK?=
 =?us-ascii?Q?nPUjISTDAnyE+ev32S/ws4Ii1aORvLJMwPOZyGZn/43iJpC76pSrJGXl/QYm?=
 =?us-ascii?Q?0syAso7QHc/OAMMDCnw4H83gkSUDthFmuQHuqU1z1NX4QUPPd0/E3C/rvCOn?=
 =?us-ascii?Q?5tEJxPleSkn9szoemANfFb8oj1E9smh5YWa43cGCSNPwI1Eo2vd4UZnpz8A8?=
 =?us-ascii?Q?UahDJak0g7h3bfUrF8eRlQ/Yd+4gzots2VaO7LS9Z9blCJvvOSnwqZlqTGLZ?=
 =?us-ascii?Q?j1g/QhniJf0VRugk+KbOD8MywtrMQhHsMIepJCs5Fz1/SPgIeMxjSQeRbOll?=
 =?us-ascii?Q?tl9vL7urCEr7b2dCU1984Y3e58B11w5Dd4zd39N0LVeHHgNIoedRpudqnvSG?=
 =?us-ascii?Q?lCs/LJOOXhVjNuPx+CzuRDIJ4ZzmWW9zt/cSzO8Bd18lDiK2TfZhuNnv8luB?=
 =?us-ascii?Q?acwi4DeaxUA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7057.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4yqBYZHNI3WawGa4N9lAgfTEOZW/ysC2+HU8wfwdqKhkrQHZ1x3QWmGYMzH4?=
 =?us-ascii?Q?cZJm3rgBwyTS7Eq0MUnk1PXZmMBDCgHaFWcmAiLJnxDVUEOOppvSQcJdKsZ+?=
 =?us-ascii?Q?S2UJNRPbz6WI79SSeJqI5xkkQvnOrmK1XuV0Qzr4Z4xKTr+suIOSZfp7MlB1?=
 =?us-ascii?Q?IPbKwizlbgh+S0REAKZZizN9i++Ze1V3dp90W8ryRNQ3pIMEyUCuVKoGW9me?=
 =?us-ascii?Q?qlfPKi5acblqiqtFbbkzAxBqt5Z6RnllV8inRz+CYqViNnDUqoOuF8EXfCAf?=
 =?us-ascii?Q?5RcgrUr2WrSs33+DP2VyR+wetBFfHFhXxoj12vV6avuFpJ5Ach1cBl3Zu+dp?=
 =?us-ascii?Q?0gRbEsaAO76iXSpu06ZrCVUHDB/mxCVzcpqj4lpJXhxsqoqM9AURHDQ2o/Ys?=
 =?us-ascii?Q?Ugkd9XWYJXXKo38t2Kb0p57hVadWE2i53hBO8rpiqj8hiHNLl6dK5iiKJHqn?=
 =?us-ascii?Q?69s+x2S8G8Qb/vyHslW+LOEC/mK7W7ySTuCj0Hm7n7oxxUBi3BaJA5YiASts?=
 =?us-ascii?Q?9vkvM+xYZxkGrt2WNtMgP3APSzrnRyw+VI5kGbAyTG3gwVcDuH+UrNXl8mkS?=
 =?us-ascii?Q?SmNeWeve0ejT2dc3XTrHFnswEdvVfzAiloeN0hmPIpdNpbO0uceoESS2k1hX?=
 =?us-ascii?Q?p3f7bd4yRgIO+Miha7cAMUfpMfZmTzLLAvuI/7WHkYS9SCTIcxN1kUw86E8f?=
 =?us-ascii?Q?9ow1Om+rGw6E68BKPlf/FFFg7KOv5a+n/G7M+XcYO02tcW5zr9gl5hoxL9V6?=
 =?us-ascii?Q?Zw0v5Tsdh4BarLLQaKAnGggRTWKz5oMlYRR3hcchQ9iTKlN8qxXJ8qVRKX45?=
 =?us-ascii?Q?Ha+Nwa8n99g/dEubbz4acCyd3DDF042WwJPqmiPHHlnNhm9+MWSSgWuasSc5?=
 =?us-ascii?Q?ltJP9VwHL9dgGD8U2c/jj3Slv/2Vy0nSQCW+5r7Pln4rxjKQ+ei87JkaC3Es?=
 =?us-ascii?Q?BzgYtWmIFDgWrVt6qqyCsZUtgM93TRoewu9nfG7yi2+V7y2B/dm91UhyY/0a?=
 =?us-ascii?Q?E9wbA+92BO8LqiG26Tv32CAkftTpL4LeLHkR/AZsv5vSqviv++JVBX0BiMLC?=
 =?us-ascii?Q?TbOmvpcnYBNUQUe0BTCrJtVhEI7E8r9SmO/x5cEKyw/DcQQ6v5VivNh5wpFG?=
 =?us-ascii?Q?I+bzAYLqbGinepTqWwgjNnFmPZUXWXHEAjUNaKh4AJNxkOdnyPqkrKDi+4LM?=
 =?us-ascii?Q?VQubwaVvJyYcTY2a1lQAhqF6iJU5DYm94Jf6WDD3X4z2kC3V1RM4N9HChsAf?=
 =?us-ascii?Q?0LmlqERWA0wuXeFifqVfYt3JipWKchm7m6SlhZJ/fhXMl4+B9x/sJPAsYPFr?=
 =?us-ascii?Q?oC/it0DUOz51rPAIuvzFxZaWNSW4tUz7Cz5il4QPJHoJXAEFcoA7f87Zx26V?=
 =?us-ascii?Q?KZv7O+Dwfx4DGAVJd8q7STBTzUjIja0TuUS2scCmlli9H5ZjSoSFtIKeq1el?=
 =?us-ascii?Q?X65pwJhyhYWBLe6EM2ZHuTPLCIgupmf4Tiq2xBSiWFbcVYL6h3EqzDQR878X?=
 =?us-ascii?Q?LC6ovMkztgiqAh0xXsf3dTg/ByhN98qJQIl/224jPeROihTfqAWfFTAJsfJL?=
 =?us-ascii?Q?GkXfgrxYBUEAKXJGkjyZdePDXK6phrzBJtogUY5nnM3uT0w66L86esPcYRWQ?=
 =?us-ascii?Q?EgaMCW5kVhinA4qt3b5lYX0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70542a14-725a-44de-c47b-08dcb5e8130e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7057.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 07:19:14.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfPfTZ/JBycW6H5iaWMY+RMbagOel2cnjrvE2VlWNDRlLKJEPEveZAcdUKtygEI8/M9omdePBqCpjbYmGGRczFUT/QFEMDLNy9PqcsReA0/vPQ3bEasvND2f22weXLY0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7770

Add LED nodes as the gpio-leds devices. They are led-bmc-ready,
led-sw-heartbeat, led-identify, led-fault, led-fan-fault, led-psu-fault

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
Changes in v2:
  - None
---
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index 3111f23e56dc..0295f5adcfbc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -113,6 +113,37 @@ vga_memory: region@bf000000 {
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		/*
+		 * Use gpio-leds to configure GPIOW5 (bmc-ready) pin to be reseted when
+		 * watchdog timeout.
+		 */
+		led-bmc-ready {
+			gpios = <&gpio0 ASPEED_GPIO(W, 5) (GPIO_ACTIVE_HIGH | GPIO_TRANSITORY)>;
+		};
+
+		led-sw-heartbeat {
+			gpios = <&gpio0 ASPEED_GPIO(N, 3) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-identify {
+			gpios = <&gpio0 ASPEED_GPIO(S, 3) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fault {
+			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-fan-fault {
+			gpios = <&gpio_expander1 0 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-psu-fault {
+			gpios = <&gpio_expander1 1 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	voltage_mon_reg: voltage-mon-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "ltc2497_reg";
-- 
2.43.0


