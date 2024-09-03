Return-Path: <linux-kernel+bounces-312083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECC99691B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457642842A5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A85433BC;
	Tue,  3 Sep 2024 03:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BMuheyhs"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2049.outbound.protection.outlook.com [40.107.255.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569CB15E81
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725333464; cv=fail; b=pQTQ9MaoWzpbJqI5IHS+CZsB5/ldleglIrlWSfB1+fuu7V1vKQDEwmEI57SuiF08xFpVSz7q0TJioashtScfCr7XwdTta10u73CUkPN//KDaZRl2V36bfkQchkgOIPsAc+5aIckx5z4BbREUQhnqN8UkTNtqTWUiURgTmFkzWbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725333464; c=relaxed/simple;
	bh=dHWke372xREO3a5s2JvxKmksLtrAD0DBT3T9yEpIrQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CLfrrfbtO820E5P8zIY8tJrSnUiYES1Acdfc1WhrbBRWadryq2Hgc0ZD/sMXEgon94k1OYDIS5zHmRdNyIeOmlaCnkGrfhHFm+xtQXB43AzW6D0bM7xrBHFSzDkw/QLbx6k22cOWcRwNGz8VYK8huoZ7QaakFyb4eRiYn0f9sis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BMuheyhs; arc=fail smtp.client-ip=40.107.255.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgDEKDDYoUGpswLY9WvfG/ti+YNd6J2sRovHs4MSDvnH0Tn2GZot3b/jFqT+KLDuFLCTPrq2GeGzAgeeTU2ETPxBt8N4hEWv+nyBTGMKgb2OmB25gNqXOGKTAvsnev6wSIXNlo9y36KW0DyehuZuGMCoQIRnaAnsCT18d+GOXhgNP+md/jjvekNV/7KbGiQW29V4Z0Fxhy6QCACMDl2NT55E7U67MmsnzKrJVsND5M/HCypghdPc1LN/NtCmGjb2u6CGcOskmdjXHyCpSSEc1pmNlZPTAsRy0bj/nZzpuNmz819Wi+eN4JFqLuAWtrR8el2+u4zjgSRbBwQgDbJ/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWPnOe2W0LlEkQ1ERFBgJ7qx6KBiF/XxD0cL4TBxcVA=;
 b=alUG4K3oav366gXe9oC6P32rsq+M7/lCdRZ6re0/ECA3E9GsFtISNT5l8M5rLKh//YNnfj5sKWVMbas9VVpAPDh7IAGbb/Kho3neNxrtkKNKbDyF574VVxSgmt9tD/esUpFTxvuFY8stbC8pzSMCqm0f61Meh+85bp0dm+DKhFOHlw92J9fye7+LezvIGVVnVe9RtjUv16+vciDb37uY87HqbrylTUnq6WIdEFOkRB2vYU5cbzEbdCySSLb4Se7AVt0oQFJ6JdVOQVa2DAvCoDHnL4ydOfz7Cjm/ES+fp8tQ4EWc2a6JqTNIOT6KfIbGjpU2y8QFLOZHVPWxwPJhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWPnOe2W0LlEkQ1ERFBgJ7qx6KBiF/XxD0cL4TBxcVA=;
 b=BMuheyhs0OnvFf1+DVQVZ5eaDGwbmrZq2naptzJ42FCJSUFsvP0WHMP3jPwvcWc7MFRaEPI7Qtx4Cba992Y2YNx0jSvoqPayUjOU1tjnm0n5NtqQpnqCKopR1jl0OxOHcxY/7m3AuXDL6vxGifyaohMpPXdzFAVoTKMnYC/21aEgASy6sJ7J0+CtFWLjQHJuBCoh5u++M3CV2qBFw25haSrC0ckA2dpdjHTnNDTxkqvx0dfg2XklTQWzHraB8VSoZsuJDWmKouTTVAOJyRwb+tfyvYsaMQ0MVlg25paa1h1/Qakd2+ZvcyiL7YcEHdRUEYIwkJt4KDL5ZrvpHRKMGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by SEZPR06MB4998.apcprd06.prod.outlook.com (2603:1096:101:4b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 03:17:38 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 03:17:38 +0000
Message-ID: <71eef0ae-874e-4827-8e41-a956bb7db0b7@vivo.com>
Date: Tue, 3 Sep 2024 11:17:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] reset: Provide new devm_reset helpers for get and
 deassert reset control
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240830033351.233263-1-liyuesong@vivo.com>
 <743d4b6b-c854-468f-a0c4-8adbf58cd0ea@vivo.com>
 <a73a4bfb60b63a1253514289e59b8aa989cbd47a.camel@pengutronix.de>
From: Yuesong Li <liyuesong@vivo.com>
In-Reply-To: <a73a4bfb60b63a1253514289e59b8aa989cbd47a.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|SEZPR06MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: c436a19c-3395-4d91-b3bd-08dccbc6f651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clYwdG8wZmxEUGljVVZ0T1pNOWVIeDhkTGg2emtEWkprZkdLaDRzVDA3Q2ti?=
 =?utf-8?B?cnNsWTdDWHhpZTNJaStIVXFiN2ovNWphbWsybHYyRkJWU3kySWxMcHRJbklZ?=
 =?utf-8?B?TWNRV2I0MXRnc05LNUZjVmhscDZpSG0wRExySUZ2NDlOSHJCS0Jwdk1BRzJj?=
 =?utf-8?B?SDJvNkp4aVRiLy9CMUtzNWxwMUFkak8yWE9vbjZrY1ZyditJbVVBUnRkUWxy?=
 =?utf-8?B?V1NJbmJ2Qm1FanM2TFpXMzRXR09lbUNsMjBmREl4WG5pOGdLMHRFS0NVMjlY?=
 =?utf-8?B?SWttV2Yrb2tMWXpXUTFReHpGMm5CRWVxRlB0SEYzblRhNWZ6UE5idHl3ZDdC?=
 =?utf-8?B?QnZRdEE1UW1yT1pUeVhySFhnNG5mN1ZrSlN3TDUyRWJ4S3NWNEZYbndtL2Vj?=
 =?utf-8?B?UkxZOTBxRVBxdHlkT3NQNzlxM1A0a3dWRGRVNTNxQTlCcHZCWWZ4bHNBVlhU?=
 =?utf-8?B?b2l3UlB1VzgyQVd4WFZuRW5Wek5qMyticTYzSklEOGtIbDNwaUhrWTVHMzlX?=
 =?utf-8?B?U2J1dndHZ05qZjdncmdqeWtRWmt1Z2lTMTRtUGlkYnlFK1NnRDZRRGlLYzFM?=
 =?utf-8?B?Smh6eVRkdk9POExTdThYK0Q0eExGUFltZlN2dEtDNFkwTlNQaHFDZXlEZFp4?=
 =?utf-8?B?ZkJ4WHp1QzZJTDNRME1zaW1DaHc2Wjg5dWRtbTg5Skc2dGNEMUY5OUFFWTJu?=
 =?utf-8?B?RTFPK0c4K2FpWkZXWEU5Uk1YcFp5c3RCQW5iZ1FSb0tIcDFraWF1MFZoaEpY?=
 =?utf-8?B?Q1N6bWk0VytZUUNDcG13Ym1hcmZCTEpaV2tuY054RVJjSDFCN0xDejhWZFBU?=
 =?utf-8?B?WkFZdms3bzVtdTRId0V6ejdCNEJKVXArT2tqVDJwM1lESGxOelRpbnVCSDFz?=
 =?utf-8?B?T254azlHdU5oNXFNU0REUFhIYW5uaWVjVUlHbkthUHEzekJ6SmJ0TmtzelBY?=
 =?utf-8?B?dk9INzZmRUdrMmpXUUVoMVA0MmdDaUNaTm9rYmoydUE1QVNPUXFaZldkZ29C?=
 =?utf-8?B?S1BCVjlKdnpXdlNUQzJBdW9ZL1g4a1RxNUR6TXM2UnFHbDJkT3hQRFN1RU96?=
 =?utf-8?B?WU5kTEs1TXdOQXNVT0ZNb0FlR2lKR2FsaWFnTVVZZ3lwZWxwRWcwWk5MeEFx?=
 =?utf-8?B?MEVLU1BYbUxSSGVRNU9lYmRIa3FCdXZuYTlXYlY1QWc1SFFiRWZCUExyQ2tK?=
 =?utf-8?B?aWxJU3huRFZWNmsxZDVuZVg2TURWRWRuK2ZwYTk3U1RMWnpvZGxXT2tDTk9l?=
 =?utf-8?B?cnFsLys3bWtXYmJCdXhzamFXSEEwYXFzQWNWTEZqa1JhT0lMM1UxTm92U3I4?=
 =?utf-8?B?V1V5eXZGcVE5bFpicFhWM1lSRkI0aVpXMjd6ZlVHaTV3bk9rZGU4aTdIc2xN?=
 =?utf-8?B?dFNPeUE0WkF2YzZYZXJIS2NwYjlnOTNzaGVrZUFYT3BmWU43QlFpRXNPRkt3?=
 =?utf-8?B?R2VtckN4dzh6M2I1aFZvTEppOW0wd1VUSVUyWG5vL1NrQXdpbVo1WjdGQkp2?=
 =?utf-8?B?QWVESjdSa2xxNjNpd3crOGlPSERwamNKcmphWmdOY2d3YzlKSXJad1ZqTlZt?=
 =?utf-8?B?VkFoaEdxcjNraEhDcDZpRXZJQWs1YnBQQzZGS0JleUpUSVBVZzY5bEI2U0FL?=
 =?utf-8?B?MW9DNzhMOXpmcEVNK21NdTNlSnhlMjd6ZnZuSWR6d0JBMFdCZnVaWmltYXBs?=
 =?utf-8?B?K2g5REJVTTAvWXk0NVhkL2JtckRCVDVyaEtHRDZwV2lEek5LVlV4OHNjTVlH?=
 =?utf-8?B?enA3WnBIQ3dBRGcrZkNRME9UZmFMRmlCQkNLOTlKU1NDd24vTnZ3TmxCcFJX?=
 =?utf-8?B?b1F2bmtSWWxiSjczeEZYVld4eHBvUXZwWU9sbTFKNmJCeFk2R2ZMS1VrdThl?=
 =?utf-8?B?bW1ZSElOWktBWmovZHJHa1pybG9UcTBneGd6MHRDTFI3OWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmZFTkh5RGVCTFZOUmk0ZWxEenZWdWtvUGdyQ0ljUVZxUG9QMlQ2RnhBc21p?=
 =?utf-8?B?S0V3VlhYQ0FkMitiTXBCWGtoN2N4MjE2bDBmQkR1S3ltMXcxSWxDUG00MU1E?=
 =?utf-8?B?bE1WMVR6UHZ3Q0tvY3JZS3lTNHRzUWJSc0M4N3RXRzRRWHBWSmRKVFoxb3pL?=
 =?utf-8?B?d2hJZksvcFBCTkNJcGcxNHpyaVYwTEREUmZSNm5BMllocXlLeXR4MjhheWow?=
 =?utf-8?B?Zlc3WjkvMDNsMkhmbitBRjk0VXZMSnl1Wkp2eWUwWXdFWUhOSHlCK1luNTNt?=
 =?utf-8?B?L0pESzBqUkdBR2QwRFRFbzhiVVF3QUtGZHFmN29BTlh0VHVBS2hYT1lhZWJH?=
 =?utf-8?B?ZXdERFVZeVJoM1d5VTJPK2NjV01HbDM5YjRodmxJVlAyREpzNFF2RU9ZMlBu?=
 =?utf-8?B?M1hpN3lsRkhrNTZHRUsrZW1ndnNBVGVWV29XOU51cGw2RjZyVlI2VHVPQkIx?=
 =?utf-8?B?cVlScnh6NTZZeVFsTDNGSlB5WWxtaEs5YmtuMDU1Yld0Q1VUTjNQV1pFZVZK?=
 =?utf-8?B?Sm80ck0xUkVMNXJabkFuTlRoWTZjVG9PQjkvTlFMUnZpNEFDbWtFMHdqRXlu?=
 =?utf-8?B?Rk1JWlgzakdNWVp5L0YyOEtVRUxjMG11cUswYnRIRDBxSU5TZWRGMzdqVWE0?=
 =?utf-8?B?a25iakZuSVFBRUFEM2psS0lpYXlFdnNCSEZXZml1SmFmZzdCR2wrd29DQ1Rt?=
 =?utf-8?B?bzFwUkdiVzhjUDlhL0ROWXQzL216dzloT2FkWWdCWXdUTFFPTTF2clNNRnJQ?=
 =?utf-8?B?TFZqNElnMnFoaS90WVFWT2hwU0ZXV2NGYzB6RlhhMXRFaExob1JZYklhR1Vj?=
 =?utf-8?B?ZnJuRWQ0eTZPL05CK0hIdm1vQm1jdXcwTDUxYnFNUm41L2NQWmJLdzYxa3Jo?=
 =?utf-8?B?aEU0a3dyN3Vmdjl5VHVQZ2Y0QmIwMHFuOVpYcU94cHJuZHF4d1JCVzczcXRz?=
 =?utf-8?B?TUJNUi9RT2c1dFdBQWdydE1MejFkOUtsbUF6U2xoRXZTdnBxUy9DM2YwVHlL?=
 =?utf-8?B?TnRaa2ExYlhnVU9LQk9xbDVqaFNYcGx4bVRGei8yTUFqL3F3TDNpKzlkQVBD?=
 =?utf-8?B?UnJGbno2Uk5YTnpEYUlYV1pFcG9OZGFpemNBWExIQ0F6N044WW5BM3JMNi9p?=
 =?utf-8?B?dFI2bTJCSmw2TmNzQnFBaEVSRGplYVNoay9uVHRLaUY5OGRSazhKdkxsVEx1?=
 =?utf-8?B?Z0NWRU1LYm4xY2pnby80d1RyMi9pSG41bEQxWWtNeVZBVU9Ka0dZekFRQjBi?=
 =?utf-8?B?V24yMUUvb0lObUVKSzNWbldOT1c1L3NqUmVwUWVGT3FXR1l6Smk1SnlTL0hq?=
 =?utf-8?B?bWhkN1lTMFhrS2tobFZSM0FuWklib1FkRmt4eDdGVHR0QkJTS1RkN05kQUor?=
 =?utf-8?B?aDdNYkJRa1NjaTVkOW5UN2RoaG0xU2EzS2JhSmxESmpReVBKQzZ2aGlCU0R2?=
 =?utf-8?B?a3htcTRVbHhobXhEWW5GVlV2cFdESTVUQittN1prSUh6T2EzTmVlQ3NGTlBS?=
 =?utf-8?B?YmJMTHlUZktSRVFWZVA3UlpXUkJvTUJodFIwRlE5ZUVnblVmejJqV3JFOTNR?=
 =?utf-8?B?Mm5KNzVkeUt1K0RXY2hUazUxMERjOURHUnRKemVrdEVYNHB3eWRqMkRBOWJa?=
 =?utf-8?B?c25TWmpuTk5tT0MrUDZZWFlqaVdTZWlFc3NvMVhra09xa3MwdmV4OHoxYUd3?=
 =?utf-8?B?M1I2eDRjQXVENmtqNzdmWENmVG9YbEYyUXYyeE5LK0xMM2o4MStzNVJoOVJN?=
 =?utf-8?B?S0dXUWZoNlpZYnBPaWY5REZwdFNtVWtCNStOajlzMTRyZXV2TytuT1ZmQkI1?=
 =?utf-8?B?SDJIUEJsZG00aHR2OGJlSGxmMWJBTXRlTTBjSi9zZ2Q4Z1AyUGsxcVFkWWtI?=
 =?utf-8?B?djZYR3k4NlVMcWlUSWtmN21ubjNFRWJTQWt2QzlzcE5LbFdzWHhGMXRaU21P?=
 =?utf-8?B?azJMOWl5TlNKMExJYmZrVnZpUVBmZ0RxcXN0dnc3Umg0VGFJbnlhdzQxRTRq?=
 =?utf-8?B?WEhBblBwYW5FNmVmd29iUzhnNlY0YnVxQVZpUS9YU2hTaEFENGlEWDVtTG13?=
 =?utf-8?B?bjdvMEhMRzREWUNtSGRzK2Y0d09aUVpoeTVPVENxYjd0WVFCVnJINDF6WGsv?=
 =?utf-8?Q?oJrp3KF6KiLILTLuGEpeuAeV4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c436a19c-3395-4d91-b3bd-08dccbc6f651
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 03:17:37.9047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyogkaI2V1i3ZEZbYoMEuwC5VyWwqhiVz5k+aybuwWFbwtCil977+TeWsQKX6NQ65bGzky3GsOyzZtCRyGc1qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB4998



On 2024/9/2 18:44, Philipp Zabel wrote:
> On Mo, 2024-09-02 at 17:52 +0800, Yuesong Li wrote:
>>
>> On 2024/8/30 11:33, Yuesong Li wrote:
>>> When a driver wants to get reset control and deassert it,this
>>> helper will handle the return value of these function, also it
>>> will register a devres so that when the device been detached, the
>>> reset control will be assert.
>>>
>>> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
> 
> Could you have a look at the pre-deasserted / auto-reasserting reset
> control series [1] and see if that would fit your use case?
> 
> [1] https://lore.kernel.org/all/20240621-reset-get-deasserted-v1-0-94ee76fb7b7d@pengutronix.de/
> 
> regards
> Philipp

Thanks for reaching out, this patch fit my case exactly.

Best regards,
Yuesong

