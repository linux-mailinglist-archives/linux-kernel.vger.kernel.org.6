Return-Path: <linux-kernel+bounces-352168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E32C991B2B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 00:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CDC1C2187F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DDE165F16;
	Sat,  5 Oct 2024 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="S4oq/kkd"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020087.outbound.protection.outlook.com [52.101.196.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6991165EEF;
	Sat,  5 Oct 2024 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728166255; cv=fail; b=A1O97Zu++zt38zbmk8h/0jQzsKuMGK9doXXetFYvBPuwymZr27X38T4OWy5xc/P2EyDYuT38plQ0a3khKWyiWM5rZ2OcMuZ6hMDgnmZUBTAHm3sFbulk05YMVMuWR2FTAWDaYJewifr2bjfYIL07oaZPp6FSMClK/ttF2djbPYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728166255; c=relaxed/simple;
	bh=3IQr/IJDAqqavfLUwhu4WzleiOhuvwPVxFVKDFMMGvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dmz3aPbeDdvjnPLfdPGm4UneKjsDXYwuaZ5imlwPixDSjbyFmRPKoHqliGg2Mae3M08RN8X9en+wDmluF+OhvbuJI3DQXp5XcIhh3SIvEgFtD5zV2mJ17VA+MUAKH3EvCNDKrt/ttbc4Q5FuqLyRtkWi94WyW6gCMzylJBBZUUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=S4oq/kkd; arc=fail smtp.client-ip=52.101.196.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfVdPtRHj9MQ+10NM+ie+uMWYrQXSs9bDMsENWRUtDrZCBW9Z1Gvwya7W5xfWcjio+J2WnCyLsHuw4Dxq9FCyj0pXTJ665zMJGN0/iH7migTDAlfFGwhqT57ZAH3l9idm0p833nMrRQ8XraW2D+JAlQ4fXKhuR17WnHXtvh3O774T6uBT8AiwVilDUj5ocILVipNYm3r5E+Y+jko02R7opm91cJN7xpfh5eTd6prS+i7LKSCfV05g9zmuGZkA4LjDj6WBCeUXpQZcXf4obDrdmTYOTIZuCrAIpm53g5hCJU5jSWhgJ/oHyspZuea/8IXv/ql90dkS0iMxw4rdehJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IQr/IJDAqqavfLUwhu4WzleiOhuvwPVxFVKDFMMGvQ=;
 b=geH9lHbdFLUXFWCAeAaAE0H0FPdgyk5AloU5qpJ4SBEK6avPjo80AJkxixAf25HFej7A9UJm0921DzGRdTlw4FCoFcJhQ8e8yAuLTrSFQid49NE2tJQlvC2v1JRPjKb2RPZH/2Oc0oKYw4bnkRiAtv1sJEKKMgytF8SmG+pVelI3eU4ftX4FxK6c4gc1PHa7goEC7G4wIBYEEM0Gqi6n7B6tFDoxtOpGHPZVASIIy2O3MA0ZAId2ml+xHg80JF80Y29jvrQUHyVhZIFHfR+0UIz53uRIg8NVHJYpwdu+hrumqBwFpnQXkgZEI3r1HLZoobboZ5yNbE5TMGQHlq6HDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IQr/IJDAqqavfLUwhu4WzleiOhuvwPVxFVKDFMMGvQ=;
 b=S4oq/kkdp7szFfPoIw+1I8T18qm9j9l9JaPTR9ljckJSPMSfNMMuZHv7C4S+6TGBGNr2bD3IRqUU3PROZsVffta3oxGxxHh+LTADj0SvMtMu5VSMv6IzuNsChjBbx7Om0dnsRrdmmNauX54e5oaElDEBnezANp9HtK5xEEDXYJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO3P265MB2204.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:107::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 22:10:50 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 22:10:50 +0000
Date: Sat, 5 Oct 2024 23:10:46 +0100
From: Gary Guo <gary@garyguo.net>
To: Trevor Gross <tmgross@umich.edu>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/5] rust: fix size_t in bindgen prototypes of C
 builtins
Message-ID: <20241005231046.5f575779.gary@garyguo.net>
In-Reply-To: <CALNs47sgdi4PU8YXxozMm4=7aQ9RspJsKkKrYuT++9KiC8E-KQ@mail.gmail.com>
References: <20240913213041.395655-1-gary@garyguo.net>
	<20240913213041.395655-2-gary@garyguo.net>
	<CALNs47sgdi4PU8YXxozMm4=7aQ9RspJsKkKrYuT++9KiC8E-KQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0156.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO3P265MB2204:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e542967-ab7e-4eff-c268-08dce58a924e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkluZ1lzcE9PRjgyRlV2YUFQRHJ5N3l6TTVYVVRoZDJGMHJ5OTl0TS9MSUNv?=
 =?utf-8?B?c3c5QjNaWDFRS3BFdzBueGJQa1dGM0hqVU81M2R1V3VmMnQ1N0tkaCs5NlVi?=
 =?utf-8?B?aWJ0SG5lSHYyZVE5R2FhUjMvOFFCV2NZZjR5UlRxSlU3RFVMM3pIWkNZZmQ3?=
 =?utf-8?B?YlMwYWJhZU5pVEV3RlpNcGd4L1drY2tBNmY3YWZnZmFac0NaVlRhaDJUTCtW?=
 =?utf-8?B?dFVPYngzUXNZQlplb3l2U2FEYmo4Mi9MUGE3OUhvTUtQU0I3cjgrQXZDQVZx?=
 =?utf-8?B?YVV6cGdZTnRBL1Y0MnNkazJpYzBmaWVQM2UwVUFacTFWVnhxTy9BK00rYmJC?=
 =?utf-8?B?a3l2TXk0ZjVOSDlFeUljdzc1UHBaVFJOajhpNTc0WWpWRlZiZ1dYSWxOYm82?=
 =?utf-8?B?NndMK2JhOWFBc3pUYWtSdnpBaUU4V0o0b2VXZVFiblZVV285MmwvVFFHWE0z?=
 =?utf-8?B?MXlhbVQvdFlPbzYvMFpXVUxCSXdVQ25DamJVRERpRU5QYmFZY1NUcHE0Q3Rt?=
 =?utf-8?B?OFp6VUJ3L3lZaUdobHpQUTZWOGlKNXZBb0RkZWV3aTdZNU5LVkUwR0hjengv?=
 =?utf-8?B?TW1tbGdyYlczVTBhckg3RlRzdnNMd25MOVV4dkVBMnVPSWpsa0crcCthWC95?=
 =?utf-8?B?WXhXZ0wxR2w1ZDNmVlZ3dDltNEVZaWJHWUpOSWV0elFic0FEOFRndnBLbFMr?=
 =?utf-8?B?ZVF1SitPSmU2YUtwL1ZHVUJHL3lRUlJuZ2lRT0xld1JuTGFIak1tZjJGUnVV?=
 =?utf-8?B?RGlNbk12N1kwa0RvMUxNdWhwYkFQNFVjaG1VNWs0Tm9iVWxEb3ZKZUlMLzdk?=
 =?utf-8?B?N1BJMXczQnlBRkhIR3NnTUtVVDVCWUNVQ2hUUTd2YVdpVHpybkwwVGpkRmZQ?=
 =?utf-8?B?N2hpaVJnOU1zVWYwY0ZGQkpHSU54QStmcS9LdEUyaUZvSTY2TmlqNUdzeDZj?=
 =?utf-8?B?QU95RnV4aCtsZWl4YVZXdGRpRFV6RnphaXM4WGFVTmt6d3ErUkFGK2xRTDBn?=
 =?utf-8?B?K01FRnNLR0xzMXE5ZVJ6bGN3V3dlYTlLbEh5V3ZsekNsS3VkMDNqV280SkhJ?=
 =?utf-8?B?U2FmZ05CNXl4YTM5TXhhTCtMKzFubC9wVkYvdkNqVXdUcmRTZnJJU3k3c2ZF?=
 =?utf-8?B?eGd3K2U1N2VVN3h4bkVBd0ZyV09YMmVTVnVlcFAvcDQxa1NTS1k5OG1IWG4x?=
 =?utf-8?B?MzlHTHVrbzYzUkxaS2lUWG1VSGJWSlNwOTFjNm9jdUQ2Z092MDNYK2I5cU93?=
 =?utf-8?B?LzRZMVFjNTQ0RTJ3VU9WS25zNW1lcWZaQnozbUFLblNQcHRqRy9XU2xlRnhJ?=
 =?utf-8?B?aFJoRHZoMlFGU2gxTTQ2RGNYdy9nMEwvUTF0VVo3R1VTOUZqdGVPOEhERUhk?=
 =?utf-8?B?bzIxdGNJeGhiRkEzaUNMaWNabll6amw3NTdHT2xVSWNWQUFPUFBVREhHdktr?=
 =?utf-8?B?dGwyNmRZOEg3SWVBK24zTi80SGNwSzlrUWlqMTJhSDc0TzZ6aC9ETCtkVzlH?=
 =?utf-8?B?d1BZV2ZiWWdmOWowVks0OStsd0pELzlSN09ETnh3d3NpVDh5aHdPME1NLzFt?=
 =?utf-8?B?UnFDR2NtV1F6UllTRnEzdkpLc3Zvbmk2RTRNcWdyYkR5YnluV0ZQOFl6QmF5?=
 =?utf-8?B?c1FGNkI3Rk04SjVnakc1dkYvZExIaUt5cVJpZWZKeVZERHB1bHRaSVA4dmU4?=
 =?utf-8?B?SDZYOW5LVjZidjdBQlJPdzhzUHBlZXZkc3J2Q3MxTGhGeVAvMzZrMkRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGpsWDRsdzNoUTFhNE9RdkNNb1EyTGk0Q3JhSXB5TTRZa0owNVZ1WXJVRHpG?=
 =?utf-8?B?OWdsQmJYSHR0akpFejRDRCt6TnVvMGl1TUFxbkoyMGhXUCsvUENmbkZFSHJw?=
 =?utf-8?B?bXZoaVZQQStaMkwwYld6NVFYOGhDRHR3cGlwZmdCYW5WdmpPaSs1azZFTklh?=
 =?utf-8?B?NS9pd2dFdXpFWXBkeHRjSWs3YjZNaHlOUTd4OVVlSkVEeXFRaGdzck1vWEYx?=
 =?utf-8?B?RDdEaFExMW1wbzR1eks2a2RCc3hpb0pqT0t6ZzFFQzQwekpVeERHZG1ITWFz?=
 =?utf-8?B?SDB1WVZ3R1NPVlZmaGNBeEJkSVRVYmR1L3NZQlNEWmtrR1pEVUlFdndyYlJi?=
 =?utf-8?B?Q09iUWNsc2M3eHhqUFBmUk1yNDVmQTZMbmVwd0ZSZytzNHp1UzVURzlzZXU3?=
 =?utf-8?B?amNpcEJDYWsvTVNweFl4enNyVWRlMjgybENnVTZCdVQ5RkVHSERwUHp1Q3FC?=
 =?utf-8?B?MlRvT3FGS3JRYWxqQWJTZUczZnIrMk5PVHNrdk4xaW85Kzl6OG5Fd2xFV0hF?=
 =?utf-8?B?bHgrY1hlQU5nTWIrOVRwR2tWaHljZ0dsdEE0NThVcWUwTmpHZWRPY3F0TVgy?=
 =?utf-8?B?eHJVN1MrSDJTTXRvcVJKOGRlQXV1YjBTdFhHN3JmSnpOWGRtQmFCaGp3azBV?=
 =?utf-8?B?cG9HMXYrOWt2b1NjZTJsbTljaU5ZVW93Z0NGUTU3QlpxTkJWa1V5WnEzUWlT?=
 =?utf-8?B?TmU3QXd1a2JLQzV1Qm9WQnA0Y2I5QzRyUC8xRkRCSk5HV1hUcCtJZ0RIeEJu?=
 =?utf-8?B?S3JCWVZPQUdGc2s5b2tvKytyWnM0ZVlkamtMZnVKOW9BQ3F2V21QTzcrOXJz?=
 =?utf-8?B?cVJ2ZHhQQS9SaVgwaFZJUDArY3JSdXoyT25BMFlVMzJQc2QrQUU4eEQvMzRM?=
 =?utf-8?B?bHUxcVkxVExLeGRkaU5CaHNYMlFqb2NERGEybG01ZHVaMXF1amM0K21sT0NE?=
 =?utf-8?B?QkFiWC9KZEc4bk8yUUJkS0hHbE1oVTFmOUtiZ1FQQkt5YU5RemcvRGZIM0h5?=
 =?utf-8?B?dFhvQ1AzamZHdTNJVFg1TmFoRHpSenJWbHMveXNDZ0dHaFlrdER5MVdnWGx1?=
 =?utf-8?B?dXFxMjdvdm81RkJyZnpKSGUzR1h4V3Zucit5WFZpbS9nTmFyNm40N2J6aGE3?=
 =?utf-8?B?RGFrRHE2bUhTMTE5TEJDbkxtc28veWpITGFSRlBhQ2ZUZXJ6VVJmbFl3K3Yx?=
 =?utf-8?B?ZjRoK3I1MnZzWWlvVjJHWk40eGVLVGlXMXJ3NWlnc0NoTlhlYzFLV3hRdnlI?=
 =?utf-8?B?Uy8yT0hWdEZRclVZZElPQTEwaG9xNEI3amk0dStuWVp1WTUyRGZNTTI3cHZ6?=
 =?utf-8?B?N0JCMm9vd2NZajRsYnBNdDlBSk1iaXV4anNQQ1IxbWZNNUZMU2xtd1VUQ3BO?=
 =?utf-8?B?R0FkVVU0SEdaM0pkWVNVRlRyY3pUeGVsMi9NWWNabFhES0sxNW43U3pjcGVZ?=
 =?utf-8?B?WFJWTURnazZNaE1Md2tlNDVaWnhNOXlGSXFTUzZFc2Q1RUhXTzBzWXZmaWtD?=
 =?utf-8?B?NXlOUHFYMkRxa29RVmN2bnhDZ2NpMUNQMFcxQW9QcTBqcHhnQ0F4ZmFqeWFv?=
 =?utf-8?B?cVBPVDZYQUU4c2ZmWTByTDdkeGZUSG5qRVB4VWVmTVJUeFZZK254OEtQSlBh?=
 =?utf-8?B?S0FmNWE1RENWN0N5V09nRUZYYStLSjB3VDh0dHNscDkwUFdkYmZsRW0vb0tz?=
 =?utf-8?B?NG5YNXpmY3BscFgxYXltNDhvcVVIYk9ibjh3ZTNmYVdWRFM5UThyOGxTUVJD?=
 =?utf-8?B?Z0h6WnZra0VXdmgxVUg1UUQrd05mNWNkS2RxeGF6TEN4WG1iZTlDQkNrMkpK?=
 =?utf-8?B?VWNTUE5FMy9EOHVUU3hweGdpOHhHRXFFRU00SW9ldFA0ZkxnYURJWHhBUVN1?=
 =?utf-8?B?VGpSOUZ5YVhQWUZ2ajBGNXBsZ08zMU9MQ0tOQjhnMEQ4cWwxRWE4ZnVvb1JY?=
 =?utf-8?B?cjVlaWE2SjFGSHl6Ritya0dSUzRVQVp3Z2t0SE1aTHBQVXQ5STIyS1FmTVZU?=
 =?utf-8?B?aTZUUndHd2lEQXFLRmJ2UUtOUmZ5Y1UyaG51UlkzWXF0VkFCVjVrM1RyUTVR?=
 =?utf-8?B?OHZWa0NQUkNaWUk4eWhtakc1UWZWSVJjMFlRZVQwZndDMTF6b3V5OGMrSzdB?=
 =?utf-8?B?YWFzU1AyaWpwSUlpZ09sTEZOb3lhMWlRMkFyRFBqWDkvaWpKQnhURHllWVpO?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e542967-ab7e-4eff-c268-08dce58a924e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 22:10:50.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfzgvIGrRsuocCLGujfLoXBXJ4hIEjjBdRcX+QuR2vJJQOeCv/cBuYnzVMyPngKqHVOfHNic11jOmIhXcQ5Q+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2204

On Sun, 29 Sep 2024 17:00:29 -0400
Trevor Gross <tmgross@umich.edu> wrote:

> On Fri, Sep 13, 2024 at 5:32=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
>=20
> > -bindgen_c_flags_final =3D $(bindgen_c_flags_lto) -D__BINDGEN__
> > +# `-fno-builtin` is passed to avoid bindgen from using clang builtin p=
rototypes
> > +# for functions like `memcpy` -- if this flag is not passed, bindgen-g=
enerated
> > +# prototypes use `c_ulong` or `c_uint` depending on architecture inste=
ad of
> > +# generating `usize`.
> > +bindgen_c_flags_final =3D $(bindgen_c_flags_lto) -fno-builtin -D__BIND=
GEN__ =20
>=20
> I wonder how reliable this behavior is. Maybe bindgen could do a
> better job controlling this, is there an open issue?
>=20
> - Trevor

I didn't search for bindgen issues when made this change, but
apparently this is indeed the suggested approach in
https://github.com/rust-lang/rust-bindgen/issues/1770

Best,
Gary

