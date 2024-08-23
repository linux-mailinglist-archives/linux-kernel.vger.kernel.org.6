Return-Path: <linux-kernel+bounces-299027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2463E95CF32
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493431C23804
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8C518BC07;
	Fri, 23 Aug 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pdfPbUWp"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2078.outbound.protection.outlook.com [40.107.117.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6218918891A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421868; cv=fail; b=Vp6+k081EuJ5SxEFeIPzLA68povYqVaruVRI5LH98Gy0f8PObRmh+0fh4mFrsLi6fEtUiUIMagvihg7tUQnEzNfdF3Oy5L7ps7/FZGhjflnYBWw6jy91E9eW6ForeXWs3JRlogCQxDnYJ7c+vhbh+QlQ6lCZbQchjRY8p6wp2a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421868; c=relaxed/simple;
	bh=ocQsDeIb1cGmUuUUXLVQ7Yuj98ySKHoQRNW2Y8+5OTY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jycR3HO/tj48yHMYl76pK8VrstXIaG1eQLFri/ESfXpcCdk7gr2RGVielOuKBPOl7EUrgZtJ1wKPpuXP3xN5IhsMDvlwcFghIWSHHSkaDE51Df5wxKpnzPoiwnBXfguLUHH+7IbaZmfgUGDS4EmkfXAZE1yDishRhDLi5KYYM58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pdfPbUWp; arc=fail smtp.client-ip=40.107.117.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPCBktyPF0eIcI+3mUI6jukecImzQ1AJrgYWsex7eo1ZPPe15PbQn6uMt5eTz0h7EAZYCNTmXvbhjMiBwoQu2eu50B0Mv8uEmasCYubMsXASNmODCYA5FDaOr6BP/CNifHlpsIuEUBslzAIpOEgNJQgHABDNaP1F5qYrfcuLUZjBy3BnuC++du0Xz5CKClmWPDAAOPq3SL1dnrreG4xYXfV5+LI0/UckH3rND+iDki/FXUolbhx23j2REIokL22ZNBd+9jWPhJ6bjmqrPcd4Ub4/jPCE5+hGOzEDqBvk9jGmDFVPzhqin7rqkZOqeKI0SviYNZMO7ohPPr30vEfmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqYZaIgB9LHHIjXXm8XGEnmbNq6Y51Qc91Kd1oOeBe4=;
 b=Gy9OgQb7mTH0Ymxz8CrtKI9W47NMMHCoRaskAn91099flAAm1LJShmMxoKJLmzjsDpta67Ro1p/8M/Rsizrmz62MLtLSkMqOXD8+4jLPtkLwxEUcXEm4MP7Thhip3IDMYeOmghzObK71FiUVrTlsqAvnJSXQ9iZ0QTAzEnUNqiJ76fTarv+a2HtnbOWi6YOEB2OB71J4fAFZX1uixSRT7St14YLQAiGfHxv1vqpj6mGVwolt7mOv+62HCqh0qHFOf42KhpBx3oONPinnnubCu+uq1y/5N8L1FpVN08V/QZjC+cLEYZXgBsrFaEZq1sbPgZfdJyAMHuBdOnA5XqB5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqYZaIgB9LHHIjXXm8XGEnmbNq6Y51Qc91Kd1oOeBe4=;
 b=pdfPbUWp6GrzvADFxIkwXaNeSbeNpqvCmgzZh8E+6XFzM62DX8e8h7qYfUiYqylWj0s3PsmIKhYDV8ElLVUBh5aHVVNjCkKAUJGBLV7BJD7Qbw2eA91fAUIGgfW6wVwSUDL8XhyLaJTObZOeplYEIKbb8j9lqksWng4f8xJN85EbCkR/Tm2bzksShYgUf6jBQ4aKmLa3W+85x0BdWONdQjogXLonTsYR9ZJZ2BA1jAj+4XFlXhYR6FIhd5SvtcPJ/W290f2edFfww8Ko7CWQ0k+l4d0k7VAHtLsAWGECadhJQ2goHQMq35a6Zae9RWCWAQOuoT2h1KupOAoRVVcZpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TY0PR06MB5458.apcprd06.prod.outlook.com (2603:1096:400:329::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 14:04:21 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 14:04:21 +0000
Message-ID: <617ea0f3-3a7c-453c-af65-f8724008ac4a@vivo.com>
Date: Fri, 23 Aug 2024 22:04:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: vma remove the redundant avc binded with old folio
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <202408230938.43f55b4-lkp@intel.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <202408230938.43f55b4-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TY0PR06MB5458:EE_
X-MS-Office365-Filtering-Correlation-Id: 9256f82a-e902-4aa5-37af-08dcc37c7c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QloxRlVVeFNUb0VJc1hHTWp5dzVTMWw1a0JsWVB4VFNVZEFETG1QUnA3WmVF?=
 =?utf-8?B?UDlTNFVQUEUzdms4MXVvN3RGeWlLL0xBMzlwMEFpYUFpMit1QXhoMnF3NUtZ?=
 =?utf-8?B?N09ObFMyelhXNkp6NXVBQnVwNk9Vemo2Y3FWMmovVHNvY0VyZXlZZzMxYjB0?=
 =?utf-8?B?YTZ6YXpSa2dOWjU5THlsK1p5WXhxYzIxYjg0YXJidHlERElsMkphaExQZm5D?=
 =?utf-8?B?R3NlK1ZWNDVnT2N6dWJyclJiUmo1MHlBWE9GTktvYUxVYkZUWUlWY3dadVFG?=
 =?utf-8?B?cVUzVGZsMGlseGIrT1NhL2wrSktwVWdaZE5HV3VIQmNvSXdUb1BHTHYwbWh1?=
 =?utf-8?B?MHE4K0hSblhPbW4yNTJPdHlSaHlwbFZrcFErNE4rL2lsYmFxQy9DZ1pMKy8x?=
 =?utf-8?B?WkcvV3Z0L2NVZ1lKdW5BbFlWc2poaFJ3bURYQktTaWUwVmRTengvOXdMbm1D?=
 =?utf-8?B?cTVrYWFRWHpBVHpKUnZzOVpPNmpQdVgvUWZTYUVSaExEOG9qZ0l4NENOWUNT?=
 =?utf-8?B?cTVTZXlUTjlsRTNlQmUxTnRnZU5KRVVqZytCemwvT1l5dUI0bU8wTXZzcGlS?=
 =?utf-8?B?MGFNQjFGWFkwUUxJc3pwSk5SMWUvVmFiTERuUWpvY21yQ3gxVHNSL3RGTENj?=
 =?utf-8?B?bm9mcW1QUU53clJVTHVKSjJzOEkxekZPK2VFenRIeFVLT3BFcUV2dHZUcjdZ?=
 =?utf-8?B?Y3djbnpLL281NjVtd1YwYmYzc0FjTTRNYU9SbW9XZEtSRHB5M0JLSUp2U3RK?=
 =?utf-8?B?djJkUndpczkydlNGMTJsdlozQjRHdGJBOC9hVzdBVEd2NHdiWVZoOUJqNGpr?=
 =?utf-8?B?TGJQa05BbEsvbDUvSm9UMXIwTmY0Vi9HemxVYm50cGFxTzRtaUZVUFJPdnJV?=
 =?utf-8?B?R0had0VaOWhuU2dUcUNITnZRdnUrckJRdnZEQTB0a0dsaWNaZUhySjFOUDhS?=
 =?utf-8?B?ZFZBSzV5OEI4Tjl0STdSbTluZDkyZ3pzdVoxWE1RZERUeWpzLzlGaWFEM1Ny?=
 =?utf-8?B?V1dQOHoyRlZiM3lpWWJWVVNHK1FZemNMdUJIWjh4bXN4Yzk5ajUwNThIeGRq?=
 =?utf-8?B?YndUNHFhSkY3aHRVVnl2WEpvRkRMZDV4Y3lKL2g3T1BwdDBiS05YQVpTVEZq?=
 =?utf-8?B?c21yRmNNSmc2akZMS3Y3emVDS1RTVUVwWEd2bzhITnVlQzllZEpiMjV3QmRV?=
 =?utf-8?B?SlVBbkh2UWxPNGxvZVNmOHYwOHVmaGxGazA4eXVDcXdvcEY0b3l5VnVaQ2Va?=
 =?utf-8?B?VXFyQVhuVTE5WWh5dzRBa2NHalRTanVOVTE3ajZmeDh1cnh0SzlVMDFTUVJx?=
 =?utf-8?B?UUh2OVRSK0V0c3Y2aE9xRjhVaEptWXRaU2toQkNHUURiZ01nRFJOUHNJZ0tn?=
 =?utf-8?B?TDJjTm0zQkQwNnBvQ25mS3g1R2o2Z0xkb1BsbGpydkhtU013Z09sR1FKZHQ2?=
 =?utf-8?B?anF0YWV0NHQyNnBiZ1locEh6QTB4R0JZZDJ6YWRBdnlMRmtpWDc0YnUzcDNE?=
 =?utf-8?B?eHVpb3d1VStBWnI0S0tsTlBpRHAyZlRyUHZNT0VZQzhOYUIzbGVkYkd1U1hW?=
 =?utf-8?B?Vm9OeURxMXZia25uS3Y4NS8zUjNoTTA4UFoxSGtpS2kzbWNUdEIwbzFnRmlE?=
 =?utf-8?B?QW9LZnBHV0t4ZkZLcDZ5aGJaZGlxd0hRLzJMY1FIVW5qNm9zeGlLRzB1dDJu?=
 =?utf-8?B?czlQQ0VWVklaaUFzUXlXMktXc3RYay91MHdjTkdTT3hsWXpYVk1FbGl1ZkQr?=
 =?utf-8?B?bWNqVGE0WHpCOTlRY3BQY0RudFdqaitCT25KN0Fub29JQUtRbFdZVDdzbzFa?=
 =?utf-8?B?d2xQbWg3aXJOSnBEYU4vZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVZmMHVuTUd3Nm9mV3BvUmxrMGFsbHVRRFhlSk0zd2UvVCtzRVE5azg0OEJk?=
 =?utf-8?B?U0JHaXdaSGRlcUMwRDdXSWRaODdSUDRjbFIyYVJrRWMrbjdrRlJWeUs3OXRa?=
 =?utf-8?B?UkwvY0srNVlEUU5SS3FnRGE1MGZWNFNUVldxdmhMZkd0eW5iQkYySElDOEhm?=
 =?utf-8?B?WFdCMHBmMDhmUEtKUFlTUk9vY250QjVZS2NaUzhBejVrVVVpTG9qdW0yYTNs?=
 =?utf-8?B?cGR3VkduUW5vbVNncnhqL3hmUlFxQTFLMU1QaXllcjFXSElDdER3RHBjVHRk?=
 =?utf-8?B?OHNVYzE2cGdZM1lVSWIvV0R3dFBwTXdoVUlSMVJRd3F0NGgwR1V2Rlk0Rjcr?=
 =?utf-8?B?MzRoQkFWTFREa0JWNXBaaERheWMyL09NWnV2NjBFd3hWbktVZ29EV3pEME15?=
 =?utf-8?B?WTBEa2ltdVFYQW1Ua0JBK0lvN2FMRXg1MVk4dmo1SGFzb0xDREdnVmVRYUZ3?=
 =?utf-8?B?SWFRVnM3Q3BGbkpGRHQrRExYMTVXNjkxTFIyNUwrSnZzL0JlbjNMaXpUQjY5?=
 =?utf-8?B?K1dHbnAvMmg3Uy9oaVZrNU1kRmU3ZzQ4NmdObEwreHJ4My9PYWEyVWZvSUdT?=
 =?utf-8?B?eEI4eWVNdTVENkY4YlFlank5TGdlcWZHRUIzeFRpSExYMXhUNlEvY2xoVzNy?=
 =?utf-8?B?dkxYZnFEU0pQZ2ZWRU1xYkdxbDl4dkNyVHo1azNDSHlqdzhwNFE2eDdMRUNU?=
 =?utf-8?B?WUhaK2RJWjRnaXJQRGloU2lGaVdqV3FTQ2ZWOVRSbVp0REx6V3dFNUNSM2kw?=
 =?utf-8?B?ZU1pNmZNaVIxdW5aV3pSQXplK2dSU2xYbHZPRTNFNUJrVFlEWUIvb1hET0do?=
 =?utf-8?B?eGJRMndWblZGUElzZy9JY2c3dEM2ejVNMlhmUHduVVNwWDBWNkVWdlBGajRj?=
 =?utf-8?B?UDZZTzlobFZRMysyeUtuazJQMTVCVzM1OFIvRXdjbTBkdlJlVTBwKzU5UzZy?=
 =?utf-8?B?aDhISkNMUktzL2w0UVYrR29MeWpZVEVMZW91dGkxVGs5R2JTTEFjaTFGS05k?=
 =?utf-8?B?bk5qNTBtbVg5eFNkNjlVZER2RGpxQWcrcjJuRE9ibDlpM3VrclV4WVN2VDNG?=
 =?utf-8?B?QUsxdWFmZm9xUnB6Q0ZXUHJpL2FDOGxMNWZmUENDeDNNcXhzdkorUm0xbFRk?=
 =?utf-8?B?elhidFBoQXQ4Tk5rbDVtbW9xMzBtL2FvaXpGSTlOR1MwNGZXNld4aWZqK2dv?=
 =?utf-8?B?M0thekxGNCtLY251YVd5Wm5PTEZTN3lYU2NnL01wNzlwNmNuRVU2bW14NkpM?=
 =?utf-8?B?TXNYRzExcE1Ga2hRTk80L29SN1FkVEsyaEp5dS9DcDRRWTBUZ3dkdmRUTTZ1?=
 =?utf-8?B?UWtlSVM3d1g3Q1VtYW5DVmgrSUMvQmRyTXYzcXpndlY0Q2xOVjkyT202Sk9R?=
 =?utf-8?B?VXhaNnNVVzZpbmRNa3RKcXlIZzZPK01mNVg4ckQ5STFmQVNBMm9VWU0vb283?=
 =?utf-8?B?bFMyazE2dWhLeUl5UlU2dFMzY3E4OXN4ZXVvazJRc1hBSVdBdllrYjkySGRs?=
 =?utf-8?B?eHMvUnNmTVB2MWNOa1R5ejVGbzVnbXMrcDR5MjZUdUx3RmdnejhVUzNyaGdT?=
 =?utf-8?B?QjJJdldSUDZrSXNmYVNaK2JpcStpaUxZQ3lrMHhobENYc3lzYnQzcWdkV2RR?=
 =?utf-8?B?T2NsL3IwYlZxQmFXbGpOYi80WGhlNTBkYzN0a0drUlZlb05WdHFMRDYwdml6?=
 =?utf-8?B?MGhzSFpkTlEvd1hERWU4VHJJVE0zTncvVFR5T3duUnEwc1MxVEE2YWR4T0lO?=
 =?utf-8?B?TlNqZFZrbzRKUzE2blN3ZWVISWJlWjkzekJmS1pmMzFhSzBzL3NTQWpRZ0RP?=
 =?utf-8?B?MGIwRVpEWldoR1MzYlEwN0tiRHhXVkhQVmFMOTFOR3FhWSsxbDNLZ2tMdFZJ?=
 =?utf-8?B?NUhvcnUvNzR5WnJpUWpwZ09NOURCbVBieHRIeVM4RXJjL2oxeUY2L0hFNVJq?=
 =?utf-8?B?b1lhOUNaNmdoeVBLWjYzZ1JGSGloeDJWODJQK1ZQM3VYczY5Y0pKNlA0RDBT?=
 =?utf-8?B?WHQ3QzFiZkJrRlB6a0pTbW94RzVWWXBkUjYwcGpMTEFFaXk3TEZwKzRwVkRT?=
 =?utf-8?B?NWFLYkhVdDBxaFlkTmp5VmYyT3hZUnZhN2JWamRMd0RoRHVXcmRJNm5teE5j?=
 =?utf-8?Q?hl47vrKC+3YLpUefAkVfPZ7T5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9256f82a-e902-4aa5-37af-08dcc37c7c95
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:04:21.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BcftBvxnPMpd5nJbCKEUJPZzpUgv6Iq5e5dqoMkiGSNTTB9+xG4yr/5SCvrhoinK86+ru1IEzx0hVGGnpAOJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5458



在 2024/8/23 10:33, kernel test robot 写道:
> [Some people who received this message don't often get email from oliver.sang@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hello,
>
> kernel test robot noticed "WARNING:at_mm/rmap.c:#unlink_anon_vmas" on:
>
> commit: ae307233d6efc18c3d6015b127b099450ca8588e ("[PATCH] mm: vma remove the redundant avc binded with old folio")
> url: https://github.com/intel-lab-lkp/linux/commits/Zhiguo-Jiang/mm-vma-remove-the-redundant-avc-binded-with-old-folio/20240820-223531
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> patch link: https://lore.kernel.org/all/20240820143359.199-1-justinjiang@vivo.com/
> patch subject: [PATCH] mm: vma remove the redundant avc binded with old folio
>
> in testcase: boot
>
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +----------------------------------------+------------+------------+
> |                                        | 75bee94793 | ae307233d6 |
> +----------------------------------------+------------+------------+
> | WARNING:at_mm/rmap.c:#unlink_anon_vmas | 0          | 6          |
> | RIP:unlink_anon_vmas                   | 0          | 6          |
> +----------------------------------------+------------+------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com
Fix the issue, please help to review again.
https://lore.kernel.org/linux-mm/20240823140139.263-1-justinjiang@vivo.com/T/#u

Thanks
Zhiguo
>
>
> [   36.655884][  T197] ------------[ cut here ]------------
> [ 36.656843][ T197] WARNING: CPU: 1 PID: 197 at mm/rmap.c:443 unlink_anon_vmas (mm/rmap.c:443 (discriminator 1))
> [   36.658183][  T197] Modules linked in: sg ata_piix libata crc32_pclmul crc32c_intel scsi_mod polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 aesni_intel scsi_common cmdlinepart
> [   36.660508][  T197] CPU: 1 UID: 0 PID: 197 Comm: lkp-bootstrap Tainted: G                T  6.11.0-rc3-00378-gae307233d6ef #1 5ff8330b382acbcd2719e520175822ac6c64d0eb
> [   36.662685][  T197] Tainted: [T]=RANDSTRUCT
> [ 36.663288][ T197] RIP: 0010:unlink_anon_vmas (mm/rmap.c:443 (discriminator 1))
> [ 36.668434][ T197] Code: 7f fe ff ff 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 c3 90 0f 0b 90 eb ad 90 <0f> 0b 90 eb 82 90 0f 0b 90 48 8d 7e 08 e8 2d a2 bf ff e9 ca fc ff
> All code
> ========
>     0:   7f fe                   jg     0x0
>     2:   ff                      (bad)
>     3:   ff 48 83                decl   -0x7d(%rax)
>     6:   c4                      (bad)
>     7:   28 5b 5d                sub    %bl,0x5d(%rbx)
>     a:   41 5c                   pop    %r12
>     c:   41 5d                   pop    %r13
>     e:   41 5e                   pop    %r14
>    10:   41 5f                   pop    %r15
>    12:   31 c0                   xor    %eax,%eax
>    14:   31 d2                   xor    %edx,%edx
>    16:   31 c9                   xor    %ecx,%ecx
>    18:   31 f6                   xor    %esi,%esi
>    1a:   31 ff                   xor    %edi,%edi
>    1c:   45 31 c0                xor    %r8d,%r8d
>    1f:   45 31 c9                xor    %r9d,%r9d
>    22:   c3                      ret
>    23:   90                      nop
>    24:   0f 0b                   ud2
>    26:   90                      nop
>    27:   eb ad                   jmp    0xffffffffffffffd6
>    29:   90                      nop
>    2a:*  0f 0b                   ud2             <-- trapping instruction
>    2c:   90                      nop
>    2d:   eb 82                   jmp    0xffffffffffffffb1
>    2f:   90                      nop
>    30:   0f 0b                   ud2
>    32:   90                      nop
>    33:   48 8d 7e 08             lea    0x8(%rsi),%rdi
>    37:   e8 2d a2 bf ff          call   0xffffffffffbfa269
>    3c:   e9                      .byte 0xe9
>    3d:   ca fc ff                lret   $0xfffc
>
> Code starting with the faulting instruction
> ===========================================
>     0:   0f 0b                   ud2
>     2:   90                      nop
>     3:   eb 82                   jmp    0xffffffffffffff87
>     5:   90                      nop
>     6:   0f 0b                   ud2
>     8:   90                      nop
>     9:   48 8d 7e 08             lea    0x8(%rsi),%rdi
>     d:   e8 2d a2 bf ff          call   0xffffffffffbfa23f
>    12:   e9                      .byte 0xe9
>    13:   ca fc ff                lret   $0xfffc
> [   36.671148][  T197] RSP: 0000:ffffc900019ffad8 EFLAGS: 00010202
> [   36.671931][  T197] RAX: 1ffff1102e73f0bf RBX: ffff888173c55ab0 RCX: 0000000000000000
> [   36.672880][  T197] RDX: 1ffff110241d68e2 RSI: 0000000000000000 RDI: ffff8881739f85f8
> [   36.673933][  T197] RBP: ffff888120eb4700 R08: 0000000000000000 R09: 0000000000000000
> [   36.675002][  T197] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881739f8550
> [   36.676082][  T197] R13: ffff888173c55aa0 R14: dffffc0000000000 R15: ffff888120eb4710
> [   36.677134][  T197] FS:  0000000000000000(0000) GS:ffff8883af300000(0000) knlGS:0000000000000000
> [   36.678328][  T197] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [   36.679207][  T197] CR2: 000000005663e33c CR3: 000000012021c000 CR4: 00000000000406b0
> [   36.680251][  T197] Call Trace:
> [   36.680681][  T197]  <TASK>
> [ 36.681079][ T197] ? __warn (kernel/panic.c:735)
> [ 36.681682][ T197] ? unlink_anon_vmas (mm/rmap.c:443 (discriminator 1))
> [ 36.682312][ T197] ? report_bug (lib/bug.c:180 lib/bug.c:219)
> [ 36.682920][ T197] ? handle_bug (arch/x86/kernel/traps.c:239)
> [ 36.683494][ T197] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
> [ 36.684125][ T197] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621)
> [ 36.684804][ T197] ? unlink_anon_vmas (mm/rmap.c:443 (discriminator 1))
> [ 36.685501][ T197] ? unlink_anon_vmas (mm/rmap.c:400)
> [ 36.686185][ T197] free_pgtables (mm/memory.c:410)
> [ 36.686819][ T197] ? free_pgd_range (mm/memory.c:367)
> [ 36.687466][ T197] ? preempt_count_add (include/linux/ftrace.h:976 kernel/sched/core.c:5634 kernel/sched/core.c:5659)
> [ 36.688179][ T197] exit_mmap (mm/mmap.c:1934)
> [ 36.688758][ T197] ? trace_contention_end (include/trace/events/lock.h:122 (discriminator 52))
> [ 36.689496][ T197] ? do_vma_munmap (mm/mmap.c:1895)
> [ 36.690125][ T197] ? __mutex_lock (arch/x86/include/asm/preempt.h:103 kernel/locking/mutex.c:618 kernel/locking/mutex.c:752)
> [ 36.690779][ T197] ? __mutex_unlock_slowpath (arch/x86/include/asm/atomic64_64.h:101 include/linux/atomic/atomic-arch-fallback.h:4329 include/linux/atomic/atomic-long.h:1506 include/linux/atomic/atomic-instrumented.h:4481 kernel/locking/mutex.c:929)
> [ 36.691585][ T197] __mmput (kernel/fork.c:1346)
> [ 36.692143][ T197] exit_mm (kernel/exit.c:572)
> [ 36.692699][ T197] do_exit (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/sched.h:333 kernel/exit.c:930)
> [ 36.693256][ T197] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116)
> [ 36.693947][ T197] ? stack_not_used (kernel/exit.c:878)
> [ 36.694605][ T197] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202)
> [ 36.695304][ T197] do_group_exit (kernel/exit.c:1069)
> [ 36.695908][ T197] __ia32_sys_exit_group (kernel/exit.c:1097)
> [ 36.696561][ T197] ia32_sys_call (??:?)
> [ 36.697142][ T197] do_int80_emulation (arch/x86/entry/common.c:165 arch/x86/entry/common.c:253)
> [ 36.697852][ T197] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626)
> [   36.698504][  T197] RIP: 0023:0xf7f03092
> [ 36.699039][ T197] Code: Unable to access opcode bytes at 0xf7f03068.
>
> Code starting with the faulting instruction
> ===========================================
> [   36.699967][  T197] RSP: 002b:00000000ffcfddd8 EFLAGS: 00000296 ORIG_RAX: 00000000000000fc
> [   36.701055][  T197] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000003323d2f
> [   36.702120][  T197] RDX: 00000000ffcfde00 RSI: 0000000056633734 RDI: 00000000f7ef8000
> [   36.703147][  T197] RBP: 00000000ffcfdef8 R08: 0000000000000000 R09: 0000000000000000
> [   36.704165][  T197] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [   36.705185][  T197] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   36.706281][  T197]  </TASK>
> [   36.706698][  T197] irq event stamp: 10051
> [ 36.707257][ T197] hardirqs last enabled at (10059): console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 kernel/printk/printk.c:341 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120)
> [ 36.708455][ T197] hardirqs last disabled at (10066): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120)
> [ 36.709660][ T197] softirqs last enabled at (10006): handle_softirqs (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:401 kernel/softirq.c:582)
> [ 36.710805][ T197] softirqs last disabled at (9997): irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637 kernel/softirq.c:649)
> [   36.711941][  T197] ---[ end trace 0000000000000000 ]---
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240823/202408230938.43f55b4-lkp@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>


