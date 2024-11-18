Return-Path: <linux-kernel+bounces-413190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B470F9D14D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7516D285E75
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10191AA1FE;
	Mon, 18 Nov 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="m7lOnL/e"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0719F411
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945505; cv=fail; b=I4d0ztDb2rTMsC+RvXLsDTG0bp5lhLW9jbUHfiguaROe1g3VqT3Vo4V28H8ZNG8LB/VldcdwCAQqFXY2SEya5/c4MjZxLCY4w575Txqu9TrHF3s2JmmWtPMclDKyqOBwLuJBSfBZNLsG5QtPPy2WLVA23X+cC/q70W1qUhHyj18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945505; c=relaxed/simple;
	bh=wx58hRi7R0EMjhboF2ZerJ5GLd8nWAFMJaLShyMUhbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IgMOIGWRIbY+LbP1LBpVC3hN6d7RHQOX00lKmk+cE25Bys0lijAW1tRGNociKL83vl9W62BVeiz87XH8c6y30ZSjgNjiau0m0+PPhszhaYA2lzxwFFG6J4bmEbpC4cCi9n/XT0xiumW/UXeZg9kD9muP12BK6aelTd6tieDfH8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=m7lOnL/e; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywYRW4mT15YkWbo6k+AcnRmRyEnPcO0dfTDrnqeV08lDUz/ku6QAoi9c/GFOzJqVDdM47SFxtOmFbDaTOb5AD9Ud9UU8YANNfo1eDf30ThQAlaq0HfQghz1ICJP0sKmBZWfjf64cQl20N0VByI4iOQdsdILlBnPR4J7fu68Wu7HPoJ/R5yXKZh4u3MgOZO/JkPFGokAZzbqR6uhozG8unR45cTG5/CcH2K9lLOZLQIZyMF/AFm7OkJ7L9CgQhlJGAuaRd+MWTquymJ6P3EiL0CjHYLTe/uC6c7V5Cd8jlRQKm2E2zwmDqU8vHQ3CeVrNxKPyPzrvxF97diFluTOWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3O2EePm62GmvyzjGwFJ9mfx8Jm3ghdp72rGZre5COI=;
 b=rxLesquMNERlFkExDxCSYp+cS1aKZ7yNgox1oohMtu5C7MjqSKbGB25Yp7T05zwKaSw+gOToaB6JR1+yeUxnZ10biKs7DnLFnA7xaV3uV+0cqzoi6JiQMpNYYwCuxVGhGGQ5ZSSfBEG2USKkt1c9WPOy6iWbPTKhiKfCCiq5NtVIsS3u13MUBaW+VSZNrXwoMC+Nz4mbUp0iFXNAiEbb23SxDWoj0NcHJ0tNdo2BpFuB47OySx9VsjCWTxq/mhEi6H7vLZZDpWK8Ucj8o+ZPTa/ADRK17HrJsyirT40d7OWNRKGl5gwIheiivcAFdD8Nf5fRETCLooQXSWQn7HFeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3O2EePm62GmvyzjGwFJ9mfx8Jm3ghdp72rGZre5COI=;
 b=m7lOnL/e/jVPwZGDfRDL713LFw4+EKWar4b74s9+CiAQdSeO68D+GJnBhjCzzBqHAjC4dfAHfPDMU9hCMhHtTCgM61KKPjwdBwpNl0KsP7eykOhJarN0iYSWpXH5Hds2GmEg4NZZJ/f3h5HlKEKt/0UMGXLZtLQZLERiuxpwWQweFZ2MEAsgXPZsiHQxeMb5pft9gER+drYFYtI/mOtc4Ut7FJBcGu3h897a4S9vLLqUI86ZARn3yw5G7ZEZUYgDfGE6EnFjsM2Vz8Y0gTLhKT8lPidgOxFd2v8I1z92vpLctgiLdZ66L/qV+41Ym3SyEp2eLzVLfNicXL6jvFY+hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DB5PR07MB9582.eurprd07.prod.outlook.com (2603:10a6:10:4a8::19)
 by AM7PR07MB6689.eurprd07.prod.outlook.com (2603:10a6:20b:1a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 15:58:19 +0000
Received: from DB5PR07MB9582.eurprd07.prod.outlook.com
 ([fe80::a809:c351:afb4:53b]) by DB5PR07MB9582.eurprd07.prod.outlook.com
 ([fe80::a809:c351:afb4:53b%3]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 15:58:19 +0000
Date: Mon, 18 Nov 2024 16:58:35 +0100
From: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: x86/amd late microcode thread loading slows down boot
Message-ID: <ZztkK4UK-VTnLhLY@antipodes>
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
 <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
 <Zy0p5DT0SOWsCDn7@antipodes>
 <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
 <3f6a84bd-af4a-4ffa-8205-25b2c9084893@citrix.com>
 <20241115205114.GCZze0QtUKbeXdFEHe@fat_crate.local>
 <ZztZsCgX45rrMOVD@antipodes>
 <20241118152859.GDZztdOyjUvVe17Ua5@fat_crate.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118152859.GDZztdOyjUvVe17Ua5@fat_crate.local>
X-ClientProxiedBy: PAZP264CA0116.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::6) To DB5PR07MB9582.eurprd07.prod.outlook.com
 (2603:10a6:10:4a8::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR07MB9582:EE_|AM7PR07MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 4574ff23-2a00-43a7-c5e5-08dd07e9d25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEVRY2V4NEQwOXh5R3lmQU9HYUIwZ2txR2JyZVhOallWTGh1TkVDTEpuRmhJ?=
 =?utf-8?B?UjFaL1BabC9nWUtJcE9DSllVbFhyR1lEbUlUQ0ZncmpjQzNWU3ozRmNGRi9x?=
 =?utf-8?B?NG9WKzhkKzgzZ1htR3dPRTVWMGJKMWVvQXVnYmROWXVSaXdyQ1dxZGlCMU5N?=
 =?utf-8?B?d0ttRlZndGhFL3NKQno3VjlWMXQ2dGtZZEdHZW5yUS9PNndSR3pDcytUdXQv?=
 =?utf-8?B?SHQxM2NQQjd4aTlKUm1TSXZlU00wdFhTZUh2OHZYWWpLU1FFUVpkRjk3cEd0?=
 =?utf-8?B?N0dKVWJzTzRFUElHcXFPcmh6K2JHbzlEcDIwL3loY3lHNEhzYVNWUm5XVVhq?=
 =?utf-8?B?SE5FemJwRDM0UStqTEZKb0k0ZzJNZElrMWR4R3V4TEp0cDJiYjI3b3g2Nmph?=
 =?utf-8?B?UkFGNDE4OUZnRVJ6SDhtOHNaOFdDVnd2a3FkbGxmYVpGbkRlWFBXcTZqbURa?=
 =?utf-8?B?a1JjVDdySlBQSFFiT1VrQXRGNjh2NkJyVW95eG9JZnlCb0grSXRCOGlTWG55?=
 =?utf-8?B?M213OWZOWEQ3aysxYjNJNWZOT2c0cFh2TWNlTkVqN2lZWm4xeHI5UGMvM1FR?=
 =?utf-8?B?S0tRNTdVK0NDVVhYNFd5MFZ5TmowNG9yelRYVUJOOW5IZWp2OWVCQndCTGlK?=
 =?utf-8?B?eGdNall5QXUzMi9FWkVUVjhSeTZ1MUpHdVB4cHpMUUdCK2hEY1VYY0JFUml6?=
 =?utf-8?B?emJHTExudmZoK1l2aUY1LzJXSWZXc09JRHozVEU3RWNYcFlRTHU2alczOUdV?=
 =?utf-8?B?cTNJdGovQWExUUZYNkhaLzBSTFFkUUhkdjQ4WC8rRnpKdlFoT2dNUUZXeHor?=
 =?utf-8?B?dm9nTlRJeXBQRlUrWitBSVdvZmtBL3lIL1lGNVlxNko4OGpkbytob0o0NG5t?=
 =?utf-8?B?bTFyS0h6cC83QVM5dlZqS2hpTzA1SUNocG83aGZIZnNsVW9DbDhqYjBpVjZL?=
 =?utf-8?B?UTl6anpyZjU2OEhaaG9jNWZSc280YS84aW15bmpZVklGaWJleTN2Vnd0S2U4?=
 =?utf-8?B?TzRUczArMWNoWXVKMWpDOENCQVRJb0xMN1l5TTdkU05NdllTeHdTUVl1UG9m?=
 =?utf-8?B?dFl5K1IyczduSkhxMFNWZ1ZuRjc5NFVoQmVJNXdVYnY0aWlkUzVvcW12dE5Y?=
 =?utf-8?B?S1dEZ0Z1b2JTSkZ4eWdXTVE3RXdpaGJYcmNmcjNOakZLWXVQZTNUZ082Nk1C?=
 =?utf-8?B?dHdHVUFMNXFxaUF1ODRQOUtkckxKTlRtTzhkODVsbWRyL0lPS0hzZ1lWSWk0?=
 =?utf-8?B?ZEhjM0RhZFJubXBndHRzMGRlS0NpaG5RV0NmUHlnMHg2WlQ1M0NJdDM3Y1pk?=
 =?utf-8?B?Qy9xUmQzQWo3eU1jSTZEWVppWnEzUFVlUHlUN3BZMnVJRDNFR2RFZFlkcXg4?=
 =?utf-8?B?djJ3VVZqVkJFMDhnbkZIZ3p2aW1QMlVVZjZ5Y29lK0NFQjVYWEIveXAycko1?=
 =?utf-8?B?d0dsKzUrcVZZV2kzd0V2YnU1VDRrLzJiUDh1V2RWb1Z4OTducno5OUc2Nmh1?=
 =?utf-8?B?RG9xcVUwTHByOTR0WTdkSndYVklqbW14b1h5TDdlbnhyQkFHbUR3L3ZyWWJ2?=
 =?utf-8?B?cDNZL2MwMGk1ZE9CQVhNNmF3dWR3TkkvNENvcGd5d2hTZUtBeVA5SW9TeUMy?=
 =?utf-8?B?OW1JNy9pNWZXazNBWE1EdExzMTVzRW1yN21PeVJjMTVjQ0R3YmJsY1NSVElL?=
 =?utf-8?B?c1ZhVGRHV1lPSk5kdTJPOW0weWYrSU1KOUpRcVgrbDRuK2tWM05mVEQvNGZL?=
 =?utf-8?Q?pBMNPtXpOUJ9kq3sSe0qvLOw55TGfpBxaNhEiNK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR07MB9582.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzVnejNJb2FGbWVsUjhja3pKTWxxZ1pHaFBNTjZmenJtMklyaHBwWDk3SmFs?=
 =?utf-8?B?eDFEeUd5WVVUbGl1cm9VYnFoZG9YdEdiZkswYVJMc0pzVHpic3Z5VFF6cHk3?=
 =?utf-8?B?WE16OTVqUmNTQVFVZGZVSTB4U2FIYWxrZjQ1eW9NcUxOZEVWVnVJUjB5QkE2?=
 =?utf-8?B?MW9RUzNObHUwSVdBa0IrTmQ4alF5a01lWm5TM2JaUzFKY0h0OWNLZm1VSHJi?=
 =?utf-8?B?dDRueDI1eFBhRXBhSGN4SlpoRGIzRm45M2JMMWkyelNtd1R5M2ZNQkk3eWtQ?=
 =?utf-8?B?UkhOQnlGcEpHR0N4ZWZaSjlQR1ZhSS9xSXhLMW1QNjQ4WDBJR2pvQmIvbkhN?=
 =?utf-8?B?OVlsVTF2OTJYdHZGZ3RMSG1IT1YzMXE2RHBlTE5jSlBPQ0szVmV5ZE5zZFFE?=
 =?utf-8?B?eThlcXhMdFpJTGV3M2d4bmlpZXRCV2VoU1VoTEFTQXZQakp5MGhhSlFZOUpD?=
 =?utf-8?B?SjlRMDk0R3ZTeitxeUxnbk13eWxGTGZVT1EvR2xyWTNzMlVzWWNRcGRuZ1lK?=
 =?utf-8?B?MVFHQU0xNzZrbXA1ejhES3REUXJuQU9qZklMQ3dNYmJQSXFDa05aUVRiRldm?=
 =?utf-8?B?bGRNMzRxMlFZQVBQYUJkVHVhb1A5NzJtbnpvSitNdGUwYzROTHJUTE5lcUJu?=
 =?utf-8?B?TDJxVDRuL2lXMnF3LzM1bm44QkZvMjFEaHlLQVRhTE9vWi8rWXZYUDVIS1NC?=
 =?utf-8?B?TDlLRk9zUUZMdXBPQmhSNmxvTVd2SHJiNkN5Sm1ZZm1LNEF5Z05uRGRWYk85?=
 =?utf-8?B?MFpiQWJ5dk9KTytPZ1lUNkhyc1VQV001ZFFTaXJVdUthRXBGK1lmSnNpdjM3?=
 =?utf-8?B?THZWK1VTVGJRZW5OQkZOVUZTbVNkdStZaUtVNGxhSnEvNVZLd0NPeWl1QWVi?=
 =?utf-8?B?MWYrUE5hNDltU251YWVyZi90bk9xVDlSbCthN0xxUGlkMHVUYnI2UFI0VHBN?=
 =?utf-8?B?bFlldFEyUVkrcjl4MUR1OEcyLzFNbEVRK3FEREpGRWJKTEorVmxEcW5veVQ2?=
 =?utf-8?B?Q3ZKSnB5ajRzMlZPK1NtOUFpVnZNQVdSTzFQcW1PbnFGeVVNRUVhTWtYWExy?=
 =?utf-8?B?ako2YTRjcVp1YVFLazVacEVoY3ZrOEJyV21KMkpXVml1NEJ4SFd0VmVLdmt5?=
 =?utf-8?B?QmtyQ3NNc2JWM3JWbDNjbFAzZ3pOOUs4amFVb1o0UWhPSFpDQVF6eENqMWFu?=
 =?utf-8?B?a0t6Zlo1eG5XaEY3SkdHaTlWVjZEeE9wZ3NQOXE5Q3hWMVo2NzI1dzA4Rytl?=
 =?utf-8?B?ZjUrUFpHUlRMcGRlYjNTamJWRnNnbFhtZmhaZzBJb01oYmd3L0VLbHNub2Zk?=
 =?utf-8?B?dTV4OFBkNFRLcHZYclN5Ry9jZERwM1oza0pPTkVvRTJsQmxjTnYvbU1HUGZE?=
 =?utf-8?B?MzRpa1E3b3FnUitsUTZ0YlkxeEc0STh0YUZvQmhZVE40VTVQMUlMVFRmT1Rp?=
 =?utf-8?B?bFYvSkFaUDlVeDhWcUFIVzA5VWIwSE9tdXlGMU5XMFFHQi9LcVVIVGdiTTRO?=
 =?utf-8?B?eEI3UVA2QWJpSDZYanQxajQ5L0R1djAzem43cGIwN1ljOCtqZDB0RjkwMzZ5?=
 =?utf-8?B?ZjFMUWpQOHBNd3JXbnJta3BwZG10SFhNMkVnUlhuSjJWOEJtM1gzR2FiQVFK?=
 =?utf-8?B?WnV2cmlkbE80NG1DQURJdEpuNjIzQnNGTGM3dHRwcGFRTU1jWjU0NlBzTlRt?=
 =?utf-8?B?N0NQbk9vVzdxUnJLTEQyaHg4d1VBZGVUeG9KZThlMkkzYzduNS8rcTFlTW9J?=
 =?utf-8?B?d2xQUVFEc3hMbW8yNUllTjA4aXRGMXB5c0xGSkFuYjRSSHRFcWtFYm5icGpT?=
 =?utf-8?B?UWl3SFFGemh0R1puN3QxRVN3TE56S2hhSG1IWHJpNW96Uk82Vm9aUGYrQW1Z?=
 =?utf-8?B?TlVzQU9YTG9iQWRTOHNiN09BcjNiS1Frc0FIL3hUR2dRaE5wOXRXS1N3bkc5?=
 =?utf-8?B?N1JYM2R6Tnp0UzcwUWhaMmEzSzB6S1dXbjk3WWcrK3RiUnpvbndkODY4RkFx?=
 =?utf-8?B?dXdmc0RNdDY3YXo5em0vekhRU1BORnNpY3h4ZFNpYTlXc3VmZXBJWStNbEMz?=
 =?utf-8?B?cnZQUHVFb0VGcmpMc0U2MW5NYTFraitoV1pFeTNQcXZCdlY5ZXBLWFo4L3Ew?=
 =?utf-8?B?V01wV0liSEs3b3RqcEtvdVBJeFJ6OW9lTDRyenVrQXRuR2t4UlkzNVJFOURr?=
 =?utf-8?Q?iRKAZKMYNuzEX7XrS2AHYv4=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4574ff23-2a00-43a7-c5e5-08dd07e9d25b
X-MS-Exchange-CrossTenant-AuthSource: DB5PR07MB9582.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 15:58:19.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2KqbFw7VjAKLC5Mv4JZB1QsTgxjZhaAu4B+DA1E05qf8RFHpXrqgVjL1N3x4agqfkUWglbH8o+ibRjf4LVh/kSCzxEYFdsE4gmz4lJ5JNLdaBImGZfv/gtvzGCunhxc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6689

On Mon, Nov 18, 2024 at 04:28:59PM +0100, Borislav Petkov wrote:
> 
> Thanks for testing, want me to add your Reported-by and Tested-by tag?

Yes please:

Reported-by: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Tested-by: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>

