Return-Path: <linux-kernel+bounces-304336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7EB961E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487EF1C2300A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87FE14D282;
	Wed, 28 Aug 2024 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BCedWImV"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0149641;
	Wed, 28 Aug 2024 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724823587; cv=fail; b=sf/8sbEF6rlLB226kyeLO/PRAmSYuclCAgTEjxjMBgrwfsy22XLtiVWXyw+EHzktOqFplVycQdPsoOsOeAyZZpOv2fehP4uk2Vt1DpViP5k1hK5A8uLFREM1dmPw8tTOMays77wxrtmordKvwbifVfwGLDPmFHA3d4gKnfn4Jv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724823587; c=relaxed/simple;
	bh=YDibdM9BCto41N0npNbJrZMt3Gv4+x1QjzyEwAYH7KA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G3fc80DnZXWBOQAxPXAFzCANwpZGRl/DY3lAk4LLtfG00LIPQ6uiWYivOoPtBdvyXm5qY79Ue2WkubqYQfR/JdT7YsX9CWl8pUVYL/jUHGBFcpmdKMaJI0DTcSAa1/4iShvTF7NUTi6TE1//z2JCANr27dIBQO7+ZoSWltRQYss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BCedWImV; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euruQKvhqQ9ZAgNhpyf1+Ybf7ISXFSqKawpwbwATFczJeSYLiOaVO7sud+rQqgL+d0TW7+2asSEdDtutn6M8+1Z8Gf7HgdXST/5B11d0baqnHEF7XiG3ZX9nM8EZTEousLbIvs4E/CwB31Ae43qtAB2qFUj/CKYvaxOzHZ9amWWMI861UUDkbPqvsbL5Z7DbQfgqwVz1wLhaJo9UEQwkp4rl/GB6Tphqvk7y5HjcVXICkSURkLN0datxuicP4OdllMVM4/ZT5IYoPAo0bcD2B4/lGQinbSVPbMT+wdHdHCkYmTrcLg5FXSX1TdHbQtVU0BtCdjWaiytWRb95QcjNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvLjKV+SLQ9oa6O4CirviPyt7zVBwj6In5pcXR2Lh8Q=;
 b=jTpKO3u5HTzAlpUIBz+Ysu2e0wnXemMuIYeas1GLdQvk6NTQR1m1cll31/iAzYrhoa9+b7hhKgkD85bL2vS+hc+/oQNw1z/0mSxlxn0H73VGxkfiJ6Xl7EPSVovSqN4throEGm1EmAjifNyPV/y2noZF3RuHUY/Iv+77zhAI/81UvbZqY6B6NPRANK7Y1fnIrcDiiUvi53KmTv5Me2HXfstMQZDKHVcEEs/CT2NMWj52+52HisKJGbf/IS+Kn0y6NRxAh1tYcTLTUE1FfRsYwTcVgQGlGH0rc3FyUB10PJRk3bm1c87Olzl7ey9nCDjTUT5BeyFMNoEgHgaanXZB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvLjKV+SLQ9oa6O4CirviPyt7zVBwj6In5pcXR2Lh8Q=;
 b=BCedWImV1pt/9afkrBJ1jANfzF5d7SM7yUZMPiQilBq2xm/px2fGwlj6PMMo2FDZT9Vp0ie6PYMTBZegKf4sYeN4nwHiSGhAsjo4Cycf0lvjbXUnsZNyi8ntYqAigEov9tJeUJDwzuy7Xxy2TLYBIFpvu25sRClfB0/6dmL4UB2nloDNypfmlWWMVgsOMuGmpsnbC5Az3gf1RQGmYcjPmWbYY9o/fZqT15yrltC91xVTMi9ZPyhWAww8kvstC3PnFYgwjXmHbfByatkTAKObEZ+PMzrtSbuhNrGKc9dFUK0/kBVFDsFKtZ9Lpdm4x2PcE4bAS1gg3atUznoroQLBWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 05:39:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 05:39:41 +0000
Message-ID: <2e91fcd9-b674-4a42-93bc-40ce2cc004a1@siemens.com>
Date: Wed, 28 Aug 2024 07:39:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: iot2050: Add overlays for M.2 used by
 firmware
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li <huaqian.li@siemens.com>
References: <cover.1724682539.git.jan.kiszka@siemens.com>
 <7062ec915ecd161f6c62952eb7c1cd5036785dba.1724682539.git.jan.kiszka@siemens.com>
 <CAL_JsqJ+czuiiBUEaPBn0E+=5intMsxr6D8c33BapAD2=n7jOg@mail.gmail.com>
 <22f22118-58f0-4974-8327-736181c71aa7@siemens.com>
 <d24b0cc5-31cc-4fd5-91e0-17254e15b826@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d24b0cc5-31cc-4fd5-91e0-17254e15b826@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: ba36b41f-4f29-42ee-dfb3-08dcc723d092
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXdvNnhsWllsUEZoRVNUN2J5bnJtdmxrSnRpYjBlTmRLYzV6STg2Y0VhbHYr?=
 =?utf-8?B?cTBUOHFvMmF2S0RxS2tHNHVCc054bnJyRk5LRURLV0xUenRZU1ZjT3FqbXU4?=
 =?utf-8?B?Y2dpcGxDMnZhS08yOTdrN1NoYWJWOTE3eWFUMW9oVENDTWlCSjc4QlkxRmlw?=
 =?utf-8?B?aEJwc1A1clc3cmViVUJ3NDkwWCtVTFRPSHNNczk5cnlqTEh5UTdDL1I4cUZG?=
 =?utf-8?B?c2Z6Tmc0a0V4ZjFyUXl6bDcrMzFTRFJtV0gybEtqWEhTVGJzRTlJNHVwc2tT?=
 =?utf-8?B?TlQ2UHZyYThlSEVkM2dEYW10QjZFblQwMHJhM2w2UnVNOE8rMjNreERzL2Vw?=
 =?utf-8?B?S3Y5dXlXbGUzQVE1ZkQ3T204Y3d4TFlyZ1pVbXFaUE15dkI3aEZlb3FZS0pr?=
 =?utf-8?B?SG13dVJaeUtDajkxcnBBbFVNZXVrSlVFdUwzUWVvMlZQNzJqUjlMTWFPWlE0?=
 =?utf-8?B?RTZrY3BXcmRGQlg4UnVJRzlUeFB6Q0ZnTThJNVJsTC9POStudGUwOTgyK2xl?=
 =?utf-8?B?N1RVWXRZbWlMRzFKWlYxTXBOZ2VTTDNmS0JldkFYd2ZDRlczVVRhd3owaVBG?=
 =?utf-8?B?UHltdDFOK3I3ak5qRnVkVU9YUlJMOEwyOTJSTUFIUGlEbkZnYm4zb2lQVTcv?=
 =?utf-8?B?WVFwMGw5WHlXWmx3WDdPMG4vdEw2ZnNjbXNPL2xGVHRmWVRWazJRY290cjJ4?=
 =?utf-8?B?MnRTYVU4VFBHZ3cwTjRIU0I3OElaN2w2QnhHQzRZT21lNWRLT29EVlhGc00v?=
 =?utf-8?B?UHpjQzJ3MU54WWtURkdUbm9kV0FsamkwV3R4WjByS1Ryc0hqQUptZkVIN1BI?=
 =?utf-8?B?V09CQk54dkI0bU9PNWpkNC9rQlpacnZ3UzdJeThaWExOT3doaWxoWVJvZkFt?=
 =?utf-8?B?ek9UcjgzdlhPcERXR3ZqTHF4SUdQSldFNTExbm5adlpTN3ZsZXI3QW5KRDFO?=
 =?utf-8?B?bUplQmlZSlN1WU1rdW43M2pnM0F1U295UTdSQ1g0czZFeE1XSnQ2RHpGcEJS?=
 =?utf-8?B?SWtKVmRvV1VBWDRjdWxkNTRFQnMrdlJhUitvV1BXeE5nTk9ISzVnY1ltb0Vp?=
 =?utf-8?B?SG56Mk5YQTVuZ09sQ1JWZEJwWElINStKc09vaTRNK0owc3UvTDQxRXBiWlQ1?=
 =?utf-8?B?ZmtFZ05zbUVSLzdUdFkvc2tMdUdLVElmd2VRRFp0SlVkdHdsd1B2eWRDMDJa?=
 =?utf-8?B?RFU0U0RvMjNyYXFmNVo5NE1tZXVLcStRVDlkOUhKRlR0Tnp4cGpOc3ppMzZF?=
 =?utf-8?B?VzBPZ1pLWGdpcmxFUDI0b1N5b2tQNW5zdTcxR1E0SlRtQ2VmU2pGUFpOVyt4?=
 =?utf-8?B?MjAyTTJHMVBDdEVDWUIzZ1lQRWc3ZXEyWTRHZ3hibi9NbTZGUnNDRSticnlS?=
 =?utf-8?B?WHlSYTZJcHllSmxjQjN4N1pLcG5iRlc2bDk2UG9RUlFPaXRVOStHVThEV0Ur?=
 =?utf-8?B?SGdKWlhsTjJPeThTMVlsK1hNR3BSMTJRWjFweEwxeS84cEI3b0ZaMGc3VXhm?=
 =?utf-8?B?RFhtTXUvek5jMlRFeXRSQytjWEVURlhKR245MUhPVW96NWRsa3A5L3NXMzA1?=
 =?utf-8?B?QzVLZjRER2lLRElrcEFwM3ZjL2VIQytCY09DSzFVWlpZWUtDaDc2NDhGUDdE?=
 =?utf-8?B?OTdzbGlma3A2SmtWN3lYOCs5QzhvS1NVRGpaYU9xMVkwbytHNUU5VGdJbWN0?=
 =?utf-8?B?TERRWm0wR2JidG8zNGJFTWdlMlNrVURpS3RHa2lOcVo1YzEwSzgzTDRjS25u?=
 =?utf-8?B?QUw4Mkw3OW1vci9hcDlVN0dKY0NwSEVkVzFtS1ZUOFNNUDdnYW91bm1RcUY0?=
 =?utf-8?B?TkY0QlVZNEIxMXU4N0VaUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3YwSk9hUGU5a29nYTlhQUYwaE1xckFwL3ZkMGFneUFVNklHejJkSzhsaVF4?=
 =?utf-8?B?U1l6VU82bGw3VnlrVytWZlRzUVpkb2QvODNnWmROYzdTOWxNaWYrcWpZb2tH?=
 =?utf-8?B?ZDlUYWpoTWJwRjBNTHNBaXpsTWQrdWsvTU1QaGxWL09lZjZERGdYb1ZyamlT?=
 =?utf-8?B?dmhrdXZ3c0hLVmFtSmRoMnRaTlBUZDhaUENxeTczUU0yc3JxYkw3SytZRFpa?=
 =?utf-8?B?UEVoZDhJUUthYm1vVWUvMndWK1J1M1ZtUVdOaFhMdDZuNHVqY3AyRFJydEov?=
 =?utf-8?B?ZFFiVlVwNXMza002OGx1VFFIcXNlcWcyS1diRjQ5U2R2VGxUK1k1QUJMb0la?=
 =?utf-8?B?THZESURxWVZ5WXR5aWkxU21NQTdsSkM0c3R4MmRHR1BFeVVCZVdPMVppS3Bq?=
 =?utf-8?B?a3NyYmk1MkxOU0crQ1h6dGQ2UHdXMml5d01pZyt4YjdXWUUzdHlXV2YzUGRs?=
 =?utf-8?B?TXZLSEQ4aXVaVzBGeWlERkl6NGp4ZXJlUFN6Uytsb3ZLdm5oRjQ2SDNuTjZZ?=
 =?utf-8?B?djdtbXEyeHdMVVM2akdIOURUK3FmUStrY1dFdjBUWGtlVVJyNW84blBQTDRU?=
 =?utf-8?B?YmdzWExFbjRrR055VXhqOFl1ZGxqN291VUx2d1psSWZZNm5GNzNwQ2QzS2g1?=
 =?utf-8?B?MlQyV0s1TkNMYXh6eVh2VDhRYXRyTlo3Y254TEUxd1pKaWVtaHY3OVliaTk4?=
 =?utf-8?B?U1VYOGlucERaNHV1YTYyN3VqNEc1blhybjd1czlJWkhMV2FocXZSQ05nOE92?=
 =?utf-8?B?WXd4L0RIdVg0RG1TR05hNWY0ZlZhYUhMMGNmRFJCQlpkMWlUWDV1SlVBRjBC?=
 =?utf-8?B?WkNvQkxFNzhzUndEcmlKZXdOaFBNZHlMNFdNL2lZV0tmZm5JYUJrenljQnBE?=
 =?utf-8?B?bkxTejJIMmoyYWRKazdSVHAyU1Y0ZUVtaFhaZnIwTUZDZUF5V2dsaFRrdlRk?=
 =?utf-8?B?Yi8vSlpCelgwTTh2UldCZHVndWx6SStmTlM3dzIwMWVVWkVpcGhEb3Y5M0tI?=
 =?utf-8?B?eGtJVnByNVBDQUtIVWVXZDNYcUhCejg4cHFodWU3ZmVjRi9pbnpVWXRVaGtN?=
 =?utf-8?B?TFM0dWlXT3lsY2wxbmhXUzNUcUdUSzJJbkRwNS9EM1ZYT2dHLzA3NmZMUC9J?=
 =?utf-8?B?cTF4bkhjbE9RenhpRGx4VXpCYU9hYWovTlNPbFJyd3lvWGlqNWNaSEdZTURQ?=
 =?utf-8?B?eGFwcjNrZTZ4d2FVa0w3QzZzMTl1UUxMSHhNdGVjYzhURnRuaXVuNEkrZjdH?=
 =?utf-8?B?cE5ocFNxeUYyVVQwL2l6emJ6aHdvTUNUQ0owTHZFQUFQRHg2TXNKZXB1eTYr?=
 =?utf-8?B?WWxwZ0lWS3I3Z3MvdVpjcUtEYVRHbW5KR2wxNDYrUTBOTERjMXdGSzdZYmFM?=
 =?utf-8?B?dFVyZWl5WnVpdmVuVjBFbWdpQTM3WEh2aDZkY2x5VUsyS042WXNLZHJuQXho?=
 =?utf-8?B?eVVsS3ZyQ1RzUys0dGpjRVh4T1Ftc2JRc0x2NTMyUE5meFlUY0VUc2JJSklO?=
 =?utf-8?B?VnpSRGM5SEVOVktBWGFUZ21xN08wTGxWNjJZTGgxZjNoa3d3emlhNzgyVkg4?=
 =?utf-8?B?OWlXZmRYaFM5YWpSNmwzdWZGODY2Q1psOGNCcytKdFJETzZrZTdGSVRRZ3Zl?=
 =?utf-8?B?alU2YkJYNVNPTkltUVpENzlLYjRVaHhnWmFUSEZrVE56eWZTbkRrbHliQXpK?=
 =?utf-8?B?My9raDRVZFBCZWNIdy9KTnc0UVlRbjJsaHdnVGVIWnJ3NjZFMmwwY2diQTlk?=
 =?utf-8?B?WVNmUjgwYmprNGI2NlIzakMzdnZ2aW1KL3lTM3QwY2tOZC8ybXMwUWljcTJo?=
 =?utf-8?B?eElWbXFobWJVb1FtS0lQc1Y0cmpnU3g5Z3JNWnU2ZGc0c0I4RXNoK3FUUHNK?=
 =?utf-8?B?cW9kVGJ5WmoyNnVkVnhFS2dld0R1MEVvT3JqQVFhdlA4QzdEWmN5UWl5eGN2?=
 =?utf-8?B?OStWVTc0d1ZRT0EwcitwRkhDMHBZejY3SHBsVVJabGl5TUx5b0o1dXBleE5v?=
 =?utf-8?B?SDdWL1hRamhHS0VzK21jaHZtdVFKWTZIdlJPb3VNbDB3ZCtpcncvSU5IZkNq?=
 =?utf-8?B?WXNTZ3U5RnVDNE1GWFpvSGQ2N1lWNkZuN1pDb3d0bXBueDZDSExSWFhkMVky?=
 =?utf-8?Q?FNaLfMlIFSuWQqhShwYbMHBJk?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba36b41f-4f29-42ee-dfb3-08dcc723d092
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 05:39:41.8116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzH5D2rOqoLR3YSOsLI62d5AEv5bIaBKQ5sLbNkNJyjj54UYAn3pEJIiEGYVYCNaxP8TKXDuXnT64Fs88WsjIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8674

On 27.08.24 19:30, Krzysztof Kozlowski wrote:
> On 27/08/2024 18:20, Jan Kiszka wrote:
>> On 27.08.24 17:33, Rob Herring wrote:
>>> On Mon, Aug 26, 2024 at 9:29 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> To allow firmware to pick up all DTs from here, move the overlays that
>>>> are normally applied during DT fixup to the kernel source as well. Hook
>>>> then into the build nevertheless to ensure that regular checks are
>>>> performed.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/Makefile               |  2 +
>>>>  ...48-iot2050-advanced-m2-bkey-ekey-pcie.dtso | 27 +++++++++++
>>>>  ...-am6548-iot2050-advanced-m2-bkey-usb3.dtso | 47 +++++++++++++++++++
>>>>  3 files changed, 76 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtso
>>>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtso
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>>>> index e20b27ddf901..f459af7fac0d 100644
>>>> --- a/arch/arm64/boot/dts/ti/Makefile
>>>> +++ b/arch/arm64/boot/dts/ti/Makefile
>>>> @@ -77,6 +77,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
>>>>  dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>>>>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>>>>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
>>>> +dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtbo
>>>> +dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2-bkey-usb3.dtbo
>>>
>>> You are missing applying these overlays to anything. That is a
>>> requirement for any overlay in the tree.
>>
>> You mean apply for testing purposes? How, technically?
> 
> Apply as build a target combining base DTS and overlay. See all other
> overlays for technical aspect (just do the same).
> 

OK, it's about the magic behind the -dtbs vars.

BTW, it's not "all". I would say about 10% of the overlays are "dangling".

Jan

-- 
Siemens AG, Technology
Linux Expert Center


