Return-Path: <linux-kernel+bounces-208871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF3B902A19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D823F1C21E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE693147C71;
	Mon, 10 Jun 2024 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QAZEJSSR"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8597442E;
	Mon, 10 Jun 2024 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052409; cv=fail; b=bjMP80EWgqfMAERCFbGfLwpskR7uz5BDgdOrVroWtoziwgIL/mnXaGV3rM5ghdrJQEJ5JieAGYTmh6QzmsaZ+89PI88tLqZqfwF+qe8D8S0BHuq1Q+/fawcDjpWjjIoXFNMFUAKVrPpuiIBezM8mr0HOLnHDN+FRMJuLYgmG05A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052409; c=relaxed/simple;
	bh=0p2raQ2N5vsPsJddo41AkiQ1pr49GXdARo/kCGawPe8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mqcgLB+l4FkIF3q33HFmrvLL9Cvm2PyFf/wed0xOYFQzD2Xn9lTenBGp5cMmm6kI/znmLzG1uKMWDwraFuzuhCM2SMXj9Rq2aUPc+cGETwOOphFswGGPqrszrPfCIob3Ka511pCWvn0klblsFk/0gBW7SX20/BF2wgkSlJj65Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QAZEJSSR; arc=fail smtp.client-ip=40.107.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkvzgzfltDyXefqzJjnBBw7Rqi/EG3azwtciy835gCjjcZWa3xfYNksriu8T0KXbnnloAP/+kJ1Z/6xGRc5gBNizjmPHUrCEazobOzeKOe6FJ9ANxfw1hAyHX91hxjYunaGwSBrXzF9oZttd9wiyw8+wBjgbAFFluR7vsUAfo5t+ByhHU1uF/royiuDUjRwUwbTOQAcxPf4QdkrNI+x14ECA4aMWgxnoZJfV4wk0CLK7Od5hs9df8O/9W+VNBbmaCTeYcctGEZbZZ5f6W+O0T1suhWLwq/Ed61ixkkPRKnu8cWm3xh3P7KRQB3pJPaMiHcsilH601ObzFQtpddDlcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1U9ThRqch8jsYxZT7J1rZ1nB+WhDLbERuAB0RbR+r0=;
 b=XuRKd+7/5TZAJP0T8DD9fazDfgOnWW9ckqN7BSp0ZPQJySgaLskFqpSaLD5U+U97NT6XwKbHoqGHin0lUR7j5NBcpoT7u28N5EnlF4G09p3fJjwrProMpa3a5UQCi9W+hsBDQY/6/wSDD60WFDvMGp70pEvwmKOt1n6ANlWXlhP6pl8ikDGCSGtFKAdsqifCgiUB254B1gnzhS/oHANmi0ejqNyV12cxIAgGdlWKl/+CyObCcFIin8+pKZB0Fu3XsUSl7NqJUHvbWK+R7gJUDwpLHUXmIE2X4+7b9JFtWN8ecjdFJ7ym8H3OqBdkYoOIl0HxfcfyJ6S7VIi83+LemA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1U9ThRqch8jsYxZT7J1rZ1nB+WhDLbERuAB0RbR+r0=;
 b=QAZEJSSRGNzqGp5/raf+EYaYVfhJvQdEiFsAL2sRGxZ8GArb0cUWGhgIvWjT5DeIBUkP11yZEO7dqAaeEitbfk+1eofRzcugR6yVAyAFN0eXEnjH4cS17185Gntn+F4c4NB1lycjHHMFil+146dSlnHp/82mHx4BSQbHOQZQvQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9376.eurprd04.prod.outlook.com (2603:10a6:102:2b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:46:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:46:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Jun 2024 16:46:20 -0400
Subject: [PATCH v2 3/9] arm64: dts: imx8: add basic mipi subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-imx8qm-dts-usb-v2-3-788417116fb1@nxp.com>
References: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
In-Reply-To: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718052391; l=9827;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0p2raQ2N5vsPsJddo41AkiQ1pr49GXdARo/kCGawPe8=;
 b=GsDY+d6CU5FyYahH2FFIud+BNHMK1F79fUMvkCGhLRXOLKcWSShDu7w0SbQPOjq7EGdJbmYb5
 FTYq7jl7l5CA0RovNnAdjwkO8p4tiLgV3Yf7Lc6dS1KN93mppS7wOv1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9376:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a67cf75-7f97-4aeb-1acf-08dc898e70da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkxKYlV5VmI0MmpiRGRFQjNDZlhVbXlmanpYOFlJenJpQkI0M3FrTkJCdCtH?=
 =?utf-8?B?MklSQnFDS3M2L3NCdGszOFBlZ1hyOEpJdVlsMGlCdGlmRVJGN096a2o0bi9s?=
 =?utf-8?B?am91MisrSHFWRmEwZS90aDM5WEdVWlR4aCtqVjZualhtK01ERjdYOVFUazJh?=
 =?utf-8?B?bHVCSmg4a2k5WU9mc3RlRk04eFg4bXZQdDFWSldTVTZJZis1UUdlanYvcmxS?=
 =?utf-8?B?WHN3bjBTUkFHSGN1bkZjSDZCTTE2QWFpQUQ5M0lSYXVUYUxVbEdnSSs2Uzd0?=
 =?utf-8?B?V2VYS2JabjNvS29HYVFNVEk4N21oSUdraCtVRXV2SGRpUUZ0SGJGOWt6TFg2?=
 =?utf-8?B?Nno4TnFRVmtRaExaaHp3Nk1CeFdBNURJUE93VWhzQzVIR1JZNVVYdUp0ZmNL?=
 =?utf-8?B?d0ZVK3JxbW55dU9acktZbndlV0ZFa2RxZ1pWdEF2UGYrL3AvbUhGUmNNYnJi?=
 =?utf-8?B?M1QxU2I2dEtIQVlQaVROcVRibXNCNklYQkF6RWczTXVGSkNmNll3ekEzQlRs?=
 =?utf-8?B?R1JkNFRYZUNNT2pGdGo4SElWaXdDb0IwMHRqK3J3RE1KY2FWRG5TU2lOdnor?=
 =?utf-8?B?ZW1uN2VoYkFPYkdteXFwM1VScEJaMkUxVE9kemppNGVBbUNKeEYyRlBJcVZZ?=
 =?utf-8?B?eXRPZi8xSmZjdjZJY093Q29oQXcrM3Q1Q3A3cmUxUXRjenczNHRESUxTejBW?=
 =?utf-8?B?T2YyWU0wekFsOHBYUGpBYTdKOVB0ZFlaRDNoZUJhREU1ekF5VHN1SVc4aDU2?=
 =?utf-8?B?MlNZMUJHa2xKYzVXNjhjYWlKMzFhMlN4a2EvWm9IVlp3RHpRTHkzTjVGTThK?=
 =?utf-8?B?eDYrbitxVFhsR3FIUlNUdnF3M3dOVW0wUmoxMzZvWjk0b0pGUjgxOW5ZaUN6?=
 =?utf-8?B?RjZpcytBZy9XQm5JbXluTHcvc2tSd3B0VVpRbnoyazNMN3ZVT0RwRTk2Z0pH?=
 =?utf-8?B?dzMrTEpVNG83aEJXcjRIU0ViaHpDTm1ScVVuNktwMjNoazdML2RrbzBJZTRt?=
 =?utf-8?B?MXEvRVZadHF2YWM2Um04ZHBIR3pmUkZTWFludHRwcEtuaFJqNEIxaG4wdktE?=
 =?utf-8?B?R2sxOWJXR0N5cExoT3JTMWgxYnNQM1kzQWo2eXpxVWZwc2NocmFUT2U2OVhs?=
 =?utf-8?B?cmVMK2VzNG1UZzl3NEF3aUk5WEdiQXZtdEM0VXBjMWpZUXZJdHNNWGFyUWhZ?=
 =?utf-8?B?NUl6YU1UT3hCdmMxaXpLVXUwS2xVT1BDNjlRa3ZaQW1IUFhwNEt0RDFObHNV?=
 =?utf-8?B?NDdNMkVDOWdkZlUzQVhiSkpwaTVPNWNTNFlZL3lwZTJkTzJXVkRoRE5BWlRH?=
 =?utf-8?B?TC9xdUtJcHRqNU8yMGxaMEJzMmpFWHpIVjNLY3RRbjVmR2VpZHYvREZ6ZEFW?=
 =?utf-8?B?bFNMNzB1eUpaZjRhZHF5a2h6NUMrNEoxbmpTTDZuNHRTWkIzL0tlRkRnb2Qw?=
 =?utf-8?B?N28vT1lKUXNrWWhpd0JmYUVmZjVBV1lVTjgvVmxlc0ZiZSt2QnlRalpqUGFo?=
 =?utf-8?B?azl4b3ZrbEdLOW5ORUhTV1o1bllTck44bjFvWms4QitKb0FkejRDeG9OQWNK?=
 =?utf-8?B?S2Uvc1ZIeWw4VVl6RlJIdnNSQ0FkYkNFSjBLaGlOQnhqZTM3QzBGVFFva1h2?=
 =?utf-8?B?QmVHcU5oSWJSeks0SVMxSWNZOEkxWUE5Y3daOWJCRzZYOWRiOW1RdHpFMGlS?=
 =?utf-8?B?M1AzcXNYU3IxOWhiSEpOT3UvUXhUdUxIWVJPUlR6eTZTemIyOGVTVEtTVFA4?=
 =?utf-8?B?OHdRbTcxamE4VFhEeXBpcEhJaGFERVV5Nk5sdVFMMUdHa0R3djdPck5xazJH?=
 =?utf-8?Q?hXLK1oPRfBW0yTE7kN2uyB4oXlcnpnyGUvOsw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2lBRlllc0FQb2FheFBXam1ZMjY3c1V6bFIrRE4yVXdINm54SExJbUVmTTg5?=
 =?utf-8?B?eVMwZUsrdlF5MU1Yd2pOc0ppSVF4TnNGMlFSQllrc1ZabUw4RTFuQ1JUZmk1?=
 =?utf-8?B?TFJmODMyRVc5YWZ2WWFnQlpHZEZtZzNIMUQ2Q2FyQi9sWWpvRVU0T1hNSFc2?=
 =?utf-8?B?bXlzNVVKdU94ZVFDZC9UTFdIRkJFNnp3YlNJWFh4OU9rUUdMQllHakdldUpD?=
 =?utf-8?B?RktvQ0pKTHA0RlR6MXhZYUV1andidmFWSmZKTXFNZHJYcWdham1MbmlwODBP?=
 =?utf-8?B?aG5WUUU3cHBhdG01L3dwS2NxZEdKODNJektiSXM1ZGR1ZGpwWWdObHYvSnFK?=
 =?utf-8?B?OHpvTEMxaUlMaEFpSExNUUhxNXk4bmdLWit5U25CV2J6VkVPeEF2b1M4NWJF?=
 =?utf-8?B?V0lFRVJOOUdzTkUyOHdYUzlld1NqZzVUWWZqc2hUK2ZoeHpoRkxDUWhkYU1k?=
 =?utf-8?B?TzJWZjFjU3ZEeUZ6dThaUFhqUHdrNkNLVzlkeDZzNFFUNWFVM1gvbXo2V2dY?=
 =?utf-8?B?OTA3aVVLa3RJUTZxTVJUdndqMHczbEt2cFVFVFgreDJjaUxaR3BwQzNLL3Jj?=
 =?utf-8?B?UmtKY0RwRUlINGRxNHpScDl1cE1zcHIzZnVqbVVrS0J5aCtHVEtheklRVVRT?=
 =?utf-8?B?UXZIYVErbllMRFNwajZncWdRbHkyNHFsR0FQaHNyN2poWWNMZDFHcWlZaXJD?=
 =?utf-8?B?N0dsbEo3bE9yQURtRWhUUWhobWJocGdCLzIra0M3aStHUXhodU84L2tQNFMy?=
 =?utf-8?B?Ryt5SlV3eVQyUnE4M3ExTHNUeC8xZnFWYk5OQWY4ejRwNHl0TmpsRnhqOE1o?=
 =?utf-8?B?MktNUWo2V0xmY3J3WldHeklxcDBzL0hVNmswMzhGRFZzV1IxWDlsMGxaUEta?=
 =?utf-8?B?TzN2TVdPNVkyNEpCYzBqajhrdzIrRWxLbWpGZzBGeW1Xd09DS2c1Qk1vaWE3?=
 =?utf-8?B?TWdFWUtWNTREU2pQbzMyUkVML2oyOTdtN3ViSHVuMEF1MnBiSmRBUHNlUUNa?=
 =?utf-8?B?TElqYlU1UWljZ2xudDZIZG5BaXVFSUdIalNsOVdFaTRhOXZGdnJoUXlGMVRo?=
 =?utf-8?B?V05HVFNFK1BvNkxiNDR4YjdRMzRmdFZobTVHSmtZc2V2RmxlUVlxQWZLVGpo?=
 =?utf-8?B?cEZ3bjBvTnJiNFIxZE1vbjlGLzNlck54Z1VuSk94UTZRSzJXVnpVdXFIYVR6?=
 =?utf-8?B?V2wrTE1QSTI3NXZGZGZDck00aW51QjdDWENwcGpiQnJlWVp2ODhOc3RERjNZ?=
 =?utf-8?B?VVNUVGJiby9yc2l6TWcvOXJOMWFOQ2JMYm5qaWN2anJObUhid2NXTVROOWVD?=
 =?utf-8?B?alRoN25rTWswempTUWcwOU9PMEhyWkdIem9TM21NOXgrcEN2dWRSSURWb3lm?=
 =?utf-8?B?dWFPL1BvS1NQUmJkRHNzSlBEbXlaTWg0bGxFYW1UUHFJc2V0Zkw3anpGMHdz?=
 =?utf-8?B?czByNUVCdkNuRklFSURTb1hSb3ZqYnQrM0k4TTc1MTd6YktIOTBsdEN5aUNF?=
 =?utf-8?B?Q3NEamE4NDNBRXhMRnU2cjFIV2ZIbmwvSzdFV25xMkxiTzZKOEw5U3ZaQUpn?=
 =?utf-8?B?VkczNVBSNnNXRVhicmlQNkhGMnVLZVRvWDhlclFqRUcrWTdRb0tic2x4RWZS?=
 =?utf-8?B?amx6Mno0ODc4ZTFFeWV3V2hCYzQ2SWdLOGRhaWd6T2JqMG12cFFiRWcvbWtF?=
 =?utf-8?B?VWpRc2RqK1lCbEtCb0pGZGRkTHZIUS9UNG9weVlET1FJa2hlQVFPOENNVWUz?=
 =?utf-8?B?SUJ4RVRxUU0zRkh5VXkvOUVwOUE4UlI5S3krUEFCczBPZnlpbTAwRU9PZG5C?=
 =?utf-8?B?anpaYy9LbUg2N2FRMWxKVTZHYWFuKzY0dG9JalM4OWxqTlVBTTljQlIwdnpZ?=
 =?utf-8?B?cXFZK0RUZUZySm0xa0FFc2tlTW1Bb1F5aHR2THp3MG5lNUk2bGhvWmVETE9s?=
 =?utf-8?B?eG54RDFOQzBjWUFvejlwZnN2WjFUaHpqZXhOd1VBUVFKYnBRSDgxWW9pNExV?=
 =?utf-8?B?Q29vRzB1ZXV1blFlYkJycEprQ3owQmMxUHhOaG9OMzlEUVNjYXRaRHhscUlM?=
 =?utf-8?B?azBBMlFDbHlBT0NlQlFXTUp1Q21CR3NYSjlIUkFTRTZLcXg1TFFWYUZEMExr?=
 =?utf-8?Q?Kg/U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a67cf75-7f97-4aeb-1acf-08dc898e70da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:46:45.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzZnUX+TQqIrc0AvpL1c18UprZSy+0HFBG3PGPXee7uj3NisRdlaKFb3MvFZ3xsfyFwOaFcMvLtkVU81XpYtGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9376

Add basic mipi subsystem for imx8qm and imx8qxp.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi | 138 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi | 138 +++++++++++++++++++++++
 2 files changed, 276 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi
new file mode 100644
index 0000000000000..6b56315e8c434
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only and MIT
+
+/*
+ * Copyright 2024 NXP
+ */
+
+mipi0_subsys: bus@56220000 {
+	compatible = "simple-bus";
+	interrupt-parent = <&irqsteer_mipi0>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x56220000 0x0 0x56220000 0x10000>;
+
+	irqsteer_mipi0: interrupt-controller@56220000 {
+		compatible = "fsl,imx8qxp-irqsteer", "fsl,imx-irqsteer";
+		reg = <0x56220000 0x1000>;
+		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		clocks = <&mipi0_lis_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_MIPI_0>;
+		fsl,channel = <0>;
+		fsl,num-irqs = <32>;
+	};
+
+	mipi0_lis_lpcg: clock-controller@56223000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223000 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_lis_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0>;
+	};
+
+	mipi0_pwm_lpcg: clock-controller@5622300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5622300c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>,
+			 <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "mipi0_pwm_lpcg_clk",
+				     "mipi0_pwm_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_PWM_0>;
+	};
+
+	mipi0_i2c0_lpcg_ipg_clk: clock-controller@56223014 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223014 0x4>;
+		#clock-cells = <1>;
+		clocks = <&mipi0_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+	};
+
+	mipi0_i2c0_lpcg_ipg_s_clk: clock-controller@56223018 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223018 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c0_lpcg_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+	};
+
+	mipi0_i2c0_lpcg_clk: clock-controller@5622301c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5622301c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_0_I2C_0 IMX_SC_PM_CLK_MISC2>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c0_lpcg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+	};
+
+	mipi0_i2c1_lpcg_ipg_clk: clock-controller@56223024 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223024 0x4>;
+		#clock-cells = <1>;
+		clocks = <&mipi0_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
+	};
+
+	mipi0_i2c1_lpcg_clk: clock-controller@5622302c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5622302c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_0_I2C_1 IMX_SC_PM_CLK_MISC2>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c1_lpcg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
+	};
+
+	mipi0_i2c1_lpcg_ipg_s_clk: clock-controller@56223028 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223028 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c1_lpcg_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
+	};
+
+	pwm_mipi0: pwm@56224000 {
+		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+		reg = <0x56224000 0x1000>;
+		clocks = <&mipi0_pwm_lpcg IMX_LPCG_CLK_4>,
+			 <&mipi0_pwm_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <3>;
+		power-domains = <&pd IMX_SC_R_MIPI_0_PWM_0>;
+		status = "disabled";
+	};
+
+	i2c0_mipi0: i2c@56226000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x56226000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <8>;
+		clocks = <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
+			 <&mipi0_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+		status = "disabled";
+	};
+};
+
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi
new file mode 100644
index 0000000000000..5b1f08e412b24
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only and MIT
+
+/*
+ * Copyright 2024 NXP
+ */
+
+mipi1_subsys: bus@57220000 {
+	compatible = "simple-bus";
+	interrupt-parent = <&irqsteer_mipi1>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x57220000 0x0 0x57220000 0x10000>;
+
+	irqsteer_mipi1: interrupt-controller@57220000 {
+		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
+		reg = <0x57220000 0x1000>;
+		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		clocks = <&mipi1_lis_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_MIPI_1>;
+		fsl,channel = <0>;
+		fsl,num-irqs = <32>;
+	};
+
+	mipi1_lis_lpcg: clock-controller@57223000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223000 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_lis_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1>;
+	};
+
+	mipi1_pwm_lpcg: clock-controller@5722300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5722300c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>,
+			 <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "mipi1_pwm_lpcg_clk",
+				     "mipi1_pwm_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+	};
+
+	mipi1_i2c0_lpcg_clk: clock-controller@5722301c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5722301c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_MISC2>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c0_lpcg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+	};
+
+	mipi1_i2c0_lpcg_ipg_clk: clock-controller@57223014 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223014 0x4>;
+		#clock-cells = <1>;
+		clocks = <&mipi1_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+	};
+
+	mipi1_i2c0_lpcg_ipg_s_clk: clock-controller@57223018 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223018 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c0_lpcg_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+	};
+
+	mipi1_i2c1_lpcg_ipg_clk: clock-controller@57223024 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223024 0x4>;
+		#clock-cells = <1>;
+		clocks = <&mipi1_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
+	};
+
+	mipi1_i2c1_lpcg_ipg_s_clk: clock-controller@57223028 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223028 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c1_lpcg_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
+	};
+
+	mipi1_i2c1_lpcg_clk: clock-controller@5722302c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5722302c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_1_I2C_1 IMX_SC_PM_CLK_MISC2>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c1_lpcg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
+	};
+
+	pwm_mipi1: pwm@57224000 {
+		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+		reg = <0x57224000 0x1000>;
+		clocks = <&mipi1_pwm_lpcg IMX_LPCG_CLK_4>,
+			 <&mipi1_pwm_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <3>;
+		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+		status = "disabled";
+	};
+
+	i2c0_mipi1: i2c@57226000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x57226000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <8>;
+		interrupt-parent = <&irqsteer_mipi1>;
+		clocks = <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
+			 <&mipi1_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+		status = "disabled";
+	};
+};

-- 
2.34.1


