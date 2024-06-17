Return-Path: <linux-kernel+bounces-216840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5A490A73C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351711F24A52
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6E7190041;
	Mon, 17 Jun 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XiPztCWv"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56818F2E0;
	Mon, 17 Jun 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609577; cv=fail; b=EOEwJRzAe2sPJvdyPf41Fc9zadotDOXIlf/EYhz7gUCYc4pEATGpdc7+b2SfsKKinOVEMCGwqezfUb3k0sa2UX5F7NI3PtgQjD6dlTCoMBKsuaiK9MHpByAFbe2ZP7u5AdX6m5MN6iYSoVOZZWi7Ye8tBvDnjvLX7sfq32SI6o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609577; c=relaxed/simple;
	bh=EUeRLH1u3HnFhFGQ8WFYu1U3Bzgyf144085PpyjlZlA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hACBOb6XRqvo6LkCThR2Hk9nEbsjGpmne0d0UpYAxCqhtnh6ZvXsYlECVGcR6m+pOI+oTwY1e+YPGdQ4yw5B/sE7H4GT7I6M96w+Fs6agiIylfXPQhg3/hIInmowHL+coaLzUF9cLtpBwZjgXG0Oz+rqSoyaf2BEgZcsG7PtO/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XiPztCWv; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCJ2KIqkBAvedxMRjcujt/4sN0Hul1YimdaRjv7tE8ORQJnMV2ZCA+/mTJVvZT0sBAZl+W42KU9Kxwic2n3sLAhrOnc5Wvvnyp33ZQuzMFZSQ3bjN9LyCGNwk2bo9Qw9YGe00pRaUTxu0Lip2ICIvqxTwS7GscvvnokWD+cLmV4GwV1XwqquFlYj69LErKGA1p4UfSqZaDD5Qd3zdbezuVzgnqL3l40U2CLbric3DoJHpkaX3BQQyyBZfiYauCe2/pIoakQ56X3aAk8BQtdlg6XlOn9Zn3aG259E01ISPCFHPRbfeT6I+Fm0qeizvI2b9+Lpf1XjGCG2EAFnyhYezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUUkBLMg0O8LrsxQpmu3PouhOIOH0gJxqVubz2X/YPI=;
 b=nyTzhWEeoa719S0KbARwsxwz2nVAA/4h5CP/yyUG113fOEYyKCqspsboXhmeAKkxLzsDthivyipWgRZUPN1wHLI+qHYUjI9kHDHAqvUui4IzDSCFK/QhcR4JdCwMwi069LkeBNScJjpxFebdQ15aOumbIMptLRwjzM9lk6LztTWJLgQX8zR2+mqR+LQ7AnDAJyQ8jguN380YU0wRHF8dj12jm/CfHJvQsEB8D5rfuDlMprQMtzXiFgyYQSONavCB48c6Lx465nmShI66XjCk24lX2OLjCjVTEx3+rLDeNv9IGwOHbdfJvkbnna5jiiJ9qSBTbG4833Qvok/Y6YmrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUUkBLMg0O8LrsxQpmu3PouhOIOH0gJxqVubz2X/YPI=;
 b=XiPztCWvpYuj69eC+Qb0fIWLn1ew5sbXvE1CbRUxgg8nP2tzXRCXZB201S4+vbXrWw4j1NIRxuIyfVqH3qafsR4qfd9reomJwytoHZF/wVSzddSstAzABaIMJHSIitKEMTP4eVV8rHj+agmyy+JWPMl9inwsOZoLyZEfF+z3mSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:32:53 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:32:53 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Mon, 17 Jun 2024 12:59:39 +0530
Subject: [PATCH v3 1/5] Documentation/firmware: add imx/se to
 other_interfaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-imx-se-if-v3-1-a7d28dea5c4a@nxp.com>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
In-Reply-To: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718609402; l=6534;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=EUeRLH1u3HnFhFGQ8WFYu1U3Bzgyf144085PpyjlZlA=;
 b=5N946jyoYyIH+1rE0s8cEU281jVSBh/5qwW/oTXVP5LKHeCgTUWSgMoJwPWLuXmbNwts5WiMq
 xrHees0xJ9wAqQ85XpulXdeZHfiV+y6DlA7drrjxSPpwPdGQkEeNoe2
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PA4PR04MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce71f75-8013-4d15-f011-08dc8e9fb2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmpaRHVWYzhBUkM0SFNGZGVDdHVodUJDZ1B1NzRqbldwT29VeDFVRlNWb00v?=
 =?utf-8?B?bjBtRFUwRFUwck9Ic2R4Qnc5d1pMSzhHR1NHa3RNR3AvWFhnQ1VsaUNMVCtO?=
 =?utf-8?B?MmdpcUZOekREVWhIZUJEcGhzOVc3THJZT1BQb1MzMWE5YUtTWmpCZXM2c1Jk?=
 =?utf-8?B?SytORExVdWdVWWY3MmF4eG1BVTZTSUdZVVpGUHRSdjV5cmNYY2lqTEZpdFll?=
 =?utf-8?B?dXFLQnR2R0lPNTBWSkczR0VwTnovR25PYlVGYkI5SDVmeEtWTXplOFlZbWFP?=
 =?utf-8?B?aGFmZlNoaEpyMkhxZkRIdlBKQlM0OUM3cmJaQzFMeU5tUHF0YU8wUm9TRW5j?=
 =?utf-8?B?dG1qRnpTb2pIUkFpZklsVjdWQVpmWGM2VTdRa1ZRVkplL1BsTVg5SlhmOFdS?=
 =?utf-8?B?NFpIVnZpOCswYWJnTnRscG96aDJ4TStnd2lOZFlvbnltL0J1SFBndXluQ0dw?=
 =?utf-8?B?SVg3azg0dEdma0FqbHUyRDZNM1gvVHF4WU1QdjJDbUtUOXd5aURSdFNLSnNz?=
 =?utf-8?B?SXhic1pRdGFMM1M1MlRXeDRoU2RHbmRwKzh5Y1dua2VCT3djRkVlcEpTZVJO?=
 =?utf-8?B?Uy9vSklmSmg2K053c0JNT1hyWlFkWDJ0K0hESmY0d3ZHdVI3S0FDaWlOMy9r?=
 =?utf-8?B?VzU0Q2trNDVhd0Q5RDZRNmVwUzVHMExkVDE2dlFUNTl5YytpeENNMmlKb0Mx?=
 =?utf-8?B?MFhObzJQa20veDVkVUdXSzZ0dkxtdHRoQy9TVXh3eXI4NDBramt5TkI4UHlE?=
 =?utf-8?B?cnAwaitmZ2lnTGgxN3YwYWhhY2pyaFg0cW1scXVNNWFLd0xrdGkrSytWbXZa?=
 =?utf-8?B?RGRVMHl4WDhUUHUxVnpzV2ZXMm9Kc1paTXhQNVB3YjgzQ0VOMmZXdUtiS0hh?=
 =?utf-8?B?Vm1BS2JWbzM2NHNzM2I0R3lYckJKaVBjMHNjN0tDMTNzY0huZkh4UWd6TE15?=
 =?utf-8?B?ZzdtNlo3UG9OM3RqczNIYXB5cTN1MWQzSDJWM05nRlpSSGZmRi9CMW1iTDlU?=
 =?utf-8?B?R2I3VUNMYitMVjZMMEpnWldCd3NyTVpSSFl1dzlWcW1FSEZiR2VLcGgzVXdu?=
 =?utf-8?B?NGwvdUdhMXROdTM1cmp2TnpYUklaenUrUzlrd1pmZ00vK2xwbzFsM1V3dzBa?=
 =?utf-8?B?c1Mzb0dDc0RDRXNhSS91aFN0QnBwNGd0elZJOFhXRG5FOXRhY1UxOFpHL0xR?=
 =?utf-8?B?UU5FakRBczFwci9peTFjR2oraHl1cDNGcDJaTlF0UTdobU9DTyt6b1ByTHpG?=
 =?utf-8?B?OGk5K3hpZEFEa2VQTDNnQUxHVlEyRDgrVngwZUZYWG0yVUtIdmxtTHdRNkYz?=
 =?utf-8?B?bDl5Y0ZtejZ5V3hEbWg1eDZyNCtoNHA0ZHczSUgySFBrRjlRT1Y0cnFQVTYx?=
 =?utf-8?B?ZEJWU0dkTnJKMEd6b0hyNk5XNk1YUVRyQjlmU1J3ZnZ1SW5zZmJ5bW5pWTda?=
 =?utf-8?B?VVErSm1ScUw5SWw3a1htZFF5d0prWFRpeVVPN1JXRzRjTllKVlpyc3VIeDZ3?=
 =?utf-8?B?MDVNdEJvVmhYSDVRRHJ3NnFIcWNKOElPdzRQRDE1Z1hhZUxpLzhLNE14blRK?=
 =?utf-8?B?WWVZZ1NXUWZ0NHpjKzg3bXQ3SzYrUVAwK1VwNlpOdC9yQnF5UWR1M3orRDYx?=
 =?utf-8?B?cUVzY1g4Z2puNjZpbmlQazN2cVF0TCt5RjhMei9pS1dETW1ibW8yVExSaEJv?=
 =?utf-8?B?eG81QTlDNnhlOVNkVHlocWU5QWl6YnNVY2lYWHN4aHRIYnQ1bTB2RkYvZ0tB?=
 =?utf-8?B?SHNrWDVDSnVDWCtCZHJxaXl0MDVXdkIyaHZycHNNODZWQW1JR0cwQlVXR3FD?=
 =?utf-8?B?NnJVUUpQMzlKbTh6Y2ttcHRhZWF0eVFydyt2KzlkNitIOVRjemMycC81SWtM?=
 =?utf-8?Q?8DD/1E9RKIYU4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0x0MEYrTlFUeXBZY3R2K2NFa2puSGpLdkpUek82dlNqdXdtdlkwT1RibkFG?=
 =?utf-8?B?aWZkTmF5SnpxRTZGc2psaCtIQWtDVGFOZkluR2NYVUtqZzBNT3pWTERPVC9p?=
 =?utf-8?B?Z21yQUdMZytybU1EaVRGVmRvaE5sSWlXOE1NOGo5MWJyeU1XVkZlRkZZc2hW?=
 =?utf-8?B?K2JTSnROZFd6VXRBVkpWOXlwbEVPTVNOUVlYZWxBOGwvV1graTc3OWJjWnQ2?=
 =?utf-8?B?RFE2RWNSVloxY0J6QnlNeWoyNGEyYTExdmFremtvd0o4M2dSOEFHSHhQaTBQ?=
 =?utf-8?B?dlF1a0swY2Y5dFVCYXF0Q21OZ2wwNVlsY2RtdHpnRC9aYWxLbGoxek8zOHM5?=
 =?utf-8?B?Um5ReG80WGcvNVh0NHUwUVBZTFZrWktndGpCNHVuejl3dmRwcG9SbE0zV0t1?=
 =?utf-8?B?Tk85MXdZU1hCaUVoNmkvVmMxZG1EWVBURHdaZ3JQVVRWU0Nvb1FXZkNpdlox?=
 =?utf-8?B?UFByd3pHMVE1ZUhOSmRvTHdDYkdyVU9PaWVwaVBJeW9ySlJ3TThjZVl5a21C?=
 =?utf-8?B?L3ZoNVpCTkdRTElaNWVUQXBxVWVoc0hic25PMEFoSm9mM0pQMUFtSHlVWW9Z?=
 =?utf-8?B?RmpqUWZHbkF0RmUrZkJvclFVT0E2THF5Nk0yNE1YRTVpcVBmZlZDRHM2S2ty?=
 =?utf-8?B?T0VVTTVlekxNQkxlb29kbCtmT0QzYUtibWhCdUNPR2tzK2VQQVRVdEF4dk8w?=
 =?utf-8?B?NDJIY0xrYUM1QmRvYVg1dzJHUC9JRWFaVUxSeUd6d21mdFZ2bzlzU2ZWdkpF?=
 =?utf-8?B?Q0x5RFBkSW9ZYXBKNEJDaEdvVmMxZFNJNFVoWnM0ZjVsekJoUHR6TEdySGZW?=
 =?utf-8?B?SjVYN09kWWV3TVdsUmJFZ3c4WFVEOXNKWkV0VzhsRE1pV1ZuVGJsSm1aT1Vw?=
 =?utf-8?B?enMwRUpjTk9iTnI1bXMxN3E2Z3I0ODFFMGhrWVVLdVh6UUdCVm9qbjNWMTJP?=
 =?utf-8?B?Ti9NTVNTaTlLakJhTVRnazFlemdlT0tBRFYyaWwrYkRIWjYrRktMR0FyN0VP?=
 =?utf-8?B?N1VrWE1MSGhBejh4VlBBYmc0MTlySjRoQTlndExUVTZMNi9MbWRpZ2d0d2xY?=
 =?utf-8?B?ZkpONzJmTjF5amhxMmhZT1RpTHBMeDdaeUxpRkhtSGsrbW83di9xaHBQOEVj?=
 =?utf-8?B?d09LYTRzRGVaejFqRnZjU2FRRDZTQjZJUy9kams2ejBINXVXUFhaRy9WZERS?=
 =?utf-8?B?ZGxycnF1ZkYwVE9DdGhsTEZJdTBMaUkyZ1U5VE1ibGYxSzFRbDNOdmNNVTdC?=
 =?utf-8?B?ZE5uT0dwNVhRelFnK0ZkVDBGK1FDMnR0alNHcjF4NDJxS3lnMUVldi9mSlI5?=
 =?utf-8?B?NVFXOWEvNzU3UlpaTVRsWFRMdGRXQy93TE5ZT1NvWkR5Z0IyN3k3OVdPek1I?=
 =?utf-8?B?YkhrSWJFMUhNTEc3MnVGU0RGL3RyLzZSSVBseFJENTRJUVczd0tjems3a2kv?=
 =?utf-8?B?a2NmcEM1NkJmSWlxbmphUUNkakZ0SHUxK3RRSjM3amVvQzkxeE80eEo0VkNY?=
 =?utf-8?B?akx3UjdxeVp6NHRnWGtqZFBVdWVLcFdwVjV4SnFWZkU0YUMzNCtUT2lBS0pi?=
 =?utf-8?B?Y2tlL1MrSWpuOEpyY3pOY0kxRlJMUjVPWmhINy9OdVpGVk8wUzRQOFlqcDQ5?=
 =?utf-8?B?ajhrcW9waW42NmhnOEc1UndXblV6djhLQk1yVHNPc0JFT0ZVMHprRWo4K1Ba?=
 =?utf-8?B?VnB1TkZVa3JOZ3ZGd0s0UTBDYU5lYzcxbGVLYi9YN3dvNUJuU1o4YUh5QmZP?=
 =?utf-8?B?aU16S3ZKUEJJT2RTRElyM2R4UXU3YjkxcWRTSjYxTVk0Nnp3VlN0VTFlNW01?=
 =?utf-8?B?cnkzNHZIRmxpdUJzbk1QWEg0MUF6N2lxUnhoLzFIVEJNRWkwWk90T0JjT052?=
 =?utf-8?B?dVd6WFc3RWJsZ1BNdStrNHZLb0hMYXBLMFZrYk9QNGdSNTR5VXM0eXMrU0Vy?=
 =?utf-8?B?OGIwRmMyNnI4R2poKzlTZStZeVdrRjVrU2JUalVOcUFhM1BYYkFDN2JTU2dB?=
 =?utf-8?B?Uk10Q1czY2ZXbklHNGhVMlh0RmV1a2VRajJyQUI5ZGRaWm9oNHplbkVRc3d4?=
 =?utf-8?B?MVhjMTA4L0xSZjNYZXlCNjBGbFdQZVdiaDAwM3BteDExRmxMaHFndGc0U2dF?=
 =?utf-8?Q?wFdsiEgh+Dr7eiol0oukuRZpl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce71f75-8013-4d15-f011-08dc8e9fb2ba
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:32:53.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hc7ED1EA5US1TfDwGP1lnMY1FwoKnFKhhiMODK9sZhW23MgBglhjWD4UyY2kY9uYe90+ZrXLO26ScLktjJQchQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7982

Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
that contains the NXP hardware IP(s) for secure-enclaves(se) like:
- NXP EdgeLock Enclave on i.MX93 & i.MX8ULP

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../driver-api/firmware/other_interfaces.rst       | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 06ac89adaafb..65e69396e22a 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -49,3 +49,122 @@ of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
+
+NXP Secure Enclave Firmware Interface
+=====================================
+
+Introduction
+------------
+The NXP's i.MX HW IP like EdgeLock-Enclave, V2X etc., creates an embedded secure
+enclave within the SoC boundary to enable features like
+ - Hardware Security Module (HSM)
+ - Security Hardware Extension (SHE)
+ - Vehicular to Anything (V2X)
+
+Each of the above feature, is enabled through dedicated NXP H/W IP on the SoC.
+On a single SoC, multiple hardware IP (or can say more than one secure enclave)
+can exists.
+
+NXP SoCs enabled with the such secure enclaves(SEs) IPs are:
+i.MX93, i.MX8ULP
+
+To communicate with one or more co-existing SE(s) on SoC, there is/are dedicated
+messaging units(MU) per SE. Each co-existing 'se' can have one or multiple exclusive
+MU(s), dedicated to itself. None of the MU is shared between two SEs.
+Communication of the MU is realized using the Linux mailbox driver.
+
+NXP Secure Enclave(SE) Interface
+--------------------------------
+All those SE interfaces 'se-if' that is/are dedicated to a particular SE, will be
+enumerated and provisioned under the very single 'SE' node.
+
+Each 'se-if', comprise of twp layers:
+- (C_DEV Layer) User-Space software-access interface.
+- (Service Layer) OS-level software-access interface.
+
+   +--------------------------------------------+
+   |            Character Device(C_DEV)         |
+   |                                            |
+   |   +---------+ +---------+     +---------+  |
+   |   | misc #1 | | misc #2 | ... | misc #n |  |
+   |   |  dev    | |  dev    |     | dev     |  |
+   |   +---------+ +---------+     +---------+  |
+   |        +-------------------------+         |
+   |        | Misc. Dev Synchr. Logic |         |
+   |        +-------------------------+         |
+   |                                            |
+   +--------------------------------------------+
+
+   +--------------------------------------------+
+   |               Service Layer                |
+   |                                            |
+   |      +-----------------------------+       |
+   |      | Message Serialization Logic |       |
+   |      +-----------------------------+       |
+   |          +---------------+                 |
+   |          |  imx-mailbox  |                 |
+   |          |   mailbox.c   |                 |
+   |          +---------------+                 |
+   |                                            |
+   +--------------------------------------------+
+
+- service layer:
+  This layer is responsible for ensuring the communication protocol, that is defined
+  for communication with firmware.
+
+  FW Communication protocol ensures two things:
+  - Serializing the messages to be sent over an MU.
+
+  - FW can handle one command-message at a time.
+
+- c_dev:
+  This layer offers character device contexts, created as '/dev/<se>_mux_chx'.
+  Using these multiple device contexts, that are getting multiplexed over a single MU,
+  user-space application(s) can call fops like write/read to send the command-message,
+  and read back the command-response-message to/from Firmware.
+  fops like read & write uses the above defined service layer API(s) to communicate with
+  Firmware.
+
+  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
+
+                                Non-Secure               +   Secure
+                                                         |
+                                                         |
+                  +---------+      +-------------+       |
+                  | se_fw.c +<---->+imx-mailbox.c|       |
+                  |         |      |  mailbox.c  +<-->+------+    +------+
+                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                      |                               +------+    +------+
+                      +----------------+                 |
+                      |                |                 |
+                      v                v                 |
+                  logical           logical              |
+                  receiver          waiter               |
+                     +                 +                 |
+                     |                 |                 |
+                     |                 |                 |
+                     |            +----+------+          |
+                     |            |           |          |
+                     |            |           |          |
+              device_ctx     device_ctx     device_ctx   |
+                                                         |
+                User 0        User 1       User Y        |
+                +------+      +------+     +------+      |
+                |misc.c|      |misc.c|     |misc.c|      |
+ kernel space   +------+      +------+     +------+      |
+                                                         |
+ +------------------------------------------------------ |
+                    |             |           |          |
+ userspace     /dev/ele_muXch0    |           |          |
+                          /dev/ele_muXch1     |          |
+                                        /dev/ele_muXchY  |
+                                                         |
+
+When a user sends a command to the firmware, it registers its device_ctx
+as waiter of a response from firmware.
+
+Enclave's Firmware owns the storage management, over linux filesystem.
+For this c_dev provisions a dedicated slave device called "receiver".
+
+.. kernel-doc:: drivers/firmware/imx/se_fw.c
+   :export:

-- 
2.34.1


