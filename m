Return-Path: <linux-kernel+bounces-351857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A00F9916F2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 15:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342E71C213E2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06B51514EE;
	Sat,  5 Oct 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fXS59ZVa"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2090.outbound.protection.outlook.com [40.107.122.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA41369BC;
	Sat,  5 Oct 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728133980; cv=fail; b=mEp9tY0lSAx1YGvyS0HTHE/TAR4Je1nbnXTZjSoGPMDO+p9zCHRPl1FlEPfDGp0Dp3IWxZcxqNWpvYxMVHycMFWiS2dTN5qTj0utqT7GZNHPytB1HDQv6VpuTVNPiK4YCUFIjJln6XGzbX8aNjRqnj9okzsluqN/60+tDIYAtTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728133980; c=relaxed/simple;
	bh=jvmnx50HxCj/FpUOcDcn+8MJjdDFTw0WoM0gycC9W00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a5q9O89uAdIl3k6daqaZBmjHnh3dufWGcXQL6MFYcgrq6pniE1oeNWUuGuWJfhk3bvyaFrNXoozaqUADtzAYboniKxXdy4WRRy1R9rFP98GSKA27zhdjsgrstmDSMmRbQpl2P+8eVD0iVdupG4VKsWnym9r1Zqz9YadQ7I8MsRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fXS59ZVa; arc=fail smtp.client-ip=40.107.122.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3uESKO9HR03W5E0CFXu3NfOpuwQJEkqdfDroLI08g1mluDffq0L5QLitulUsp6FqjW07Rk+vr+HIwZj2a4DCccTfWNEgUPmFGT3H7fVKoD8xDAGtTCbRHgWCrTLajoxsBkQ4bTK7+VukTraZbKw/3/Qt0EYfR17epp/0P7SwkxtG/uLT19lftp8yb4MbfT8w/hHgsVFUjFN/EiE1ZoM5VMewCLdkD7w5BZ73P9Pfc5Gf2QLvURbNcZqg+jY/wJ0Rlp+hvXhMYBSfnvTcn2McWZEAERHoIVv3BG0HedBzxy63nGtxXMdSOxrVtketW7Y6Nrjre8eIKyE2UzLsiSxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxA0juwKjvL5sTT26L6mJhUpiAOLuWoIKS+szBDJY8s=;
 b=GUIzemxrt5NW/PfkwTKCyREYHpEqRDGU2iweBgj2/+bjTaJ+q9YDilY0CIbEzr90/FPOYIIF2ThfjNuI7aHmwYCoVQ1BKPvA0Gr9ROUpG4AZGSPfcGbEsmUOBApEU016XE+wMDVm2fI+lgZCOqhkX01ddi8uC4H/ahteZIECL/mg1knUD8dHIyyqgnfKQSo9XVo8Rmi1kxS9t3VkZoV23CjnwFEPJRwhVrkiCFk9J9gxOrDjJqfUfZB6vEFUd56yuSf7elvaF2lNwtcVaJWM97udZvtqz9DouN3XsCcVFRb3k1eQRlhzndRT8e1D/g1fISYF9002JY3x2XqYZ3A9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxA0juwKjvL5sTT26L6mJhUpiAOLuWoIKS+szBDJY8s=;
 b=fXS59ZVarkKUf875vZt+SC6+jNDatcrlrIP8bRPkqi83/+eJ9sOdBpeqrdBEMlLF+zI7+QEFctjvsQ5cErmkuWedTk3jCKk6vC+ayEceJfHv4XmEisCzmQjz6zjrF9oXsaeG5iuuLS9SK6KbHVummrPDM4TAg+nT3AV3df7Pap8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5018.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 13:12:55 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 13:12:55 +0000
Date: Sat, 5 Oct 2024 14:12:50 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Wedson
 Almeida Filho <walmeida@microsoft.com>, Valentin Obst
 <kernel@valentinobst.de>, Alex Mantel <alexmantel93@mailbox.org>, Will
 Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mark
 Rutland <mark.rutland@arm.com>, Martin Rodriguez Reboredo
 <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: convert `Arc` to use `Refcount`
Message-ID: <20241005141250.0fb0a3a9.gary@garyguo.net>
In-Reply-To: <CAH5fLggOEVxNQLfLxMg+0B2zEciaJ9Y7wkmrMoYXEcEQOg5HNQ@mail.gmail.com>
References: <20241004155247.2210469-1-gary@garyguo.net>
	<20241004155247.2210469-3-gary@garyguo.net>
	<CAH5fLggOEVxNQLfLxMg+0B2zEciaJ9Y7wkmrMoYXEcEQOg5HNQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: f937de3f-5a28-4b2c-b9da-08dce53f6cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVVEZGhOallpTGN6N1BvSXBSSmpuLzRmNzgxMUNPYVNibGVMMWQ4V0xZRnA5?=
 =?utf-8?B?YVZORGtaSEswNVlMYnIxaEY5c1FlRU9PcElPajBwUE1EZnkydENiWm1IQ2FV?=
 =?utf-8?B?dVozbWI5K1pudW4zajI5WXdGd2ZVSVVIdHR4SEpsalJkVWQ2NW92YndnSHFH?=
 =?utf-8?B?Q3E4RGdwQWlaWndZZ0hyNHJoWkxqN3RaalRZSnoyNEdKUTluaWRFZWpwbHVt?=
 =?utf-8?B?RHc2RTY0Z0V3VUJ0Vzlqek1ONUFHRXY4VVMzMkZCTkV2ZTlQSSt0RGZ3NWpv?=
 =?utf-8?B?T1g5Y3BSaWpZQ2RYUkZGSzdCeXo5YjRhRHU5TlpQa204UGdtZFRMeVhsTTZD?=
 =?utf-8?B?SS9QazhRUVlQTEtyNDR4cjFCMnBYa2IrTGxHTnowby8rWFNzMVRKZzZramRU?=
 =?utf-8?B?TzdBZTA1cVVaZlZTT0tKREUvdlB4M1JDaXZsaTZiMm03WSs0K0dxZzd2dFhJ?=
 =?utf-8?B?dkVNdUNnMmEydTYxTmhWQll6UVpkWEFBeVpnb0lCckJqcDY0d0sxaGdQdXl6?=
 =?utf-8?B?MngxNDZKMDA2MHFpSXUvaXlZMHppRS9EMDNMR25HelU4dHZFWmFBeEJhTG9T?=
 =?utf-8?B?cTZ4S2VIdHU5RGdtMC9wYlBOVlhZUmlYN25NSTN3Zmc3bUxIaGdTWkVlRE1C?=
 =?utf-8?B?bURjMFQyTFNydkVZaGwwenQ2cnY0TWJZOTU1L3JZTlQxV3BDMlBVSFhmWFZ6?=
 =?utf-8?B?MEhDZWtlS1h4ZmFDNk4zTllZS1FxQkFJdm5LVk1Xc2FaY2FKUzA3WUxXNzEr?=
 =?utf-8?B?Y0dxUWplWmFkMGtyTjZtc0MrS0FYb0ZNaWFwQ3Yyem8ydS9BdUYrSDBPQlQ5?=
 =?utf-8?B?U2tDOUNrSjk5cGg5UTNxa2pETjQvMk1rY2J2VlUxcFRXdE5KZWkwQzhWaDNu?=
 =?utf-8?B?VWVMaW5mTjd2R2ZBN2RXQThQUWpIaHhoQ2dpOS9MUXNvMEpMdG1SQnhQYVRB?=
 =?utf-8?B?VDBjYzB5UlVVY2JQbmJpdWhDNWtQejIvbjRkV2lyV1BxYy9vK21JVEE5allr?=
 =?utf-8?B?alpVVm91K3JmYW52YkdiUVZVQ1NHSzBBcUo5d2V5Y0xMSWJtdzR1Q0JSWSsr?=
 =?utf-8?B?S2l6VVgyeFAwMjdsU2pPZWlESTd0QXdjRGljb0ttNURDVnRnVDhZWUp1RGta?=
 =?utf-8?B?bmM0Z3RLbDFoWXZBd3VHbjBxUzlITmhxYTF2NnhOUDZlVE9uZFVUSnRndHIv?=
 =?utf-8?B?bmJvYVladWMwMERISkNkN0gyMDBtR1A1TzBxU09scVVDczE1WlZGMGtVd2pS?=
 =?utf-8?B?ZW8zZUVUK1VxMGs1ZUYrMGN6R29FUTN4WERzVVJuclhmMmFONjh5M1g1NDRM?=
 =?utf-8?B?S3haaDA0bjRRcmxKYitidU1ib1loVStnUVFIWEZiZWZWMlNJa2VnUmhMVDdP?=
 =?utf-8?B?Y1ExMHI4TnE0NkIrK2g1aTZjNDc4cHdOY1VGOVNOdy95TUNpSzlMR0M4dnR0?=
 =?utf-8?B?U01TWFk5eHZNVHpxME1kcTNzK3Y0RFg1ZTVyN3hJaXVYNGxicXgzZUxJeC9a?=
 =?utf-8?B?dGNKN1p3YlVDdkVZVHZxbmc0ZXBTRFlrOXhSajNEWGI5L21sMHNseGw3ZUxs?=
 =?utf-8?B?aEJJR3JDZ1BSZ3pnL2lqVUc3WGZpWFJ6NjJsdk1zcVJlemFjenZaOEZqVHpW?=
 =?utf-8?Q?OH0dAtpg/k/ilJHrPlBOfBPn7PxQ1D8Y9KCqhk6ummxM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHdlRy9DRDdoL1hlTGttenEzZ3RWNm1ld2ZSS0lqMTFnQ3V1TmJMVWlISGlR?=
 =?utf-8?B?M25YditTMmhVM1U3Q3Q0K2tGQ1RYbTUxSVQrSVZHbzJSSkw1dXNYc2I4Zlh6?=
 =?utf-8?B?c0IzNEN1WjdGL2lZUlNjR2VQMkd2aTg5UXV1dTVOM1IzNDZMVjg2SEh1VHF1?=
 =?utf-8?B?NmVERnRJSURZOC9penoxYUw5eGFsQVpvajg4YzZyQkZVMEMzU0l6OWJKUzhK?=
 =?utf-8?B?ZVhjWnVzN3N3amZmTUVCUEdjRk92STdrMWlhNVE0VzRrRUNFUVJMU050RC9R?=
 =?utf-8?B?azBYek44UktVUm12dG9FUy9WUE1ibG01cHdPejNqc0tTWkE2VzJZbUtRcE53?=
 =?utf-8?B?TDlnSHFCN0VlbmIydS9rcHdBa2J6dTM3MWVPMS84RGRMNGtxUEYydmZOZlZU?=
 =?utf-8?B?aFNXcGRkdmN3UGN2RlQwUFZpNzZGWHc1MlZaRUpKT3RVdVZOYmZtTWdtMmlK?=
 =?utf-8?B?eitCR2pmeXVLdHhFN1Nsb2lzUXFKa01LR3JMUlkrMWVleXRDSEx6bXFZU1B2?=
 =?utf-8?B?YWlqTDVkOThINmlReGY2QmtscnJzMEN4RXZId2UwM0I0cWc2N253M3B4ZE1I?=
 =?utf-8?B?S0RzNi96RXRSemd6cW1abWRINm9menJsOVBKN25uaXo0cHdOcFpjWFdmeURQ?=
 =?utf-8?B?OGsxUXNBVXZQeVR0dUZuUEtWODA5Um5SUmZCS0k4NjBrYWViczFGb1pSMEdp?=
 =?utf-8?B?U0s3Yk5tRW5pcCs5N0hjeTdEWGtRS3QwZUh5SVorS1VGNGRmMU45ME1GaUhE?=
 =?utf-8?B?cDdRVDJCMVpBdkhFMk5GWDhxQ1lBeXFRWjhWWTlVM2g5YUtKUElVengyc0tY?=
 =?utf-8?B?RGlWcHlLR0Y1Q09jSnl6WUJuWlhVV0Y4c3J6UW9SbW5Hcjg5MjV5anpxWlQy?=
 =?utf-8?B?TlFTWkRJVlZ5SkxzNFBWOTN0MnhsMEFzamxUZmRlQTB0ZFZ4T0RMbEt3QmZB?=
 =?utf-8?B?THRXM29Ha05KRWNxOUhpQ2ZzSWVVUStiTVlRdFF2blNKaWRiMzVML0I4cGpU?=
 =?utf-8?B?Ui9OWTk4VDVsTFdsMlpRbDBIWVZFWUwxdnh4dUtORlhGSFUyODhpa3NuZ1N5?=
 =?utf-8?B?SXlNMHB6bjRTeTVsSWxtb0FOeDJpV3NmV01nRTZoNnV0UkJOQTM4UFFGTSs1?=
 =?utf-8?B?eXhnOTZSMFpMb2dNK01hR3RjanArZWxmRlJydFd5QUR5NFlIL29vL2VxYTZI?=
 =?utf-8?B?V2dsZ0Q3b2pMdXI4TUxIdVcrQlB3bUlXN3psOE1MRTRTd3RVckt6NkNoM29i?=
 =?utf-8?B?blQ2TGlsMW5LWkxxNTlWa1FTQkZWVEc2MUF0c0I2YVdXWkttU0E5cFFsRWFY?=
 =?utf-8?B?cmxlaXRoOGxscDE4WDQrVEU0RFZVRTA0b25UNnVISkUxaENzbWFuaGFCSy9L?=
 =?utf-8?B?bXErWmh3Uk1jZ0RPV0tlakVwQUtsdjdGeEJQbmd5UCtkek5YR1ZBVG9Fd2lm?=
 =?utf-8?B?QWRLTjNVRjVVNEtYaFVFYXFIQm16d2JKRTlML29FYjRyeERRQ3VsTkRYb1JI?=
 =?utf-8?B?d21wU1ZTb1I0N2ViQ0hRVTJuOGp1bm9qdEpla1RaK01wcDQ4MUF5aWRjS1hF?=
 =?utf-8?B?RWVrOENvbjBZL0xkNTBMS3BMcVlZVFpDQ0Q2N1ZzVE5udU1hMVd4K1lTSG5E?=
 =?utf-8?B?ajFDeUJtZ0xrRVhWZ3VCalVSbW1KcDJRNmxTN1g4QzBBVVJEMjk3R2lxNUtS?=
 =?utf-8?B?UHY1VnhMZisxZTZ1ZjE5WUJBYlpVY3RQODNLdUtPeUVjYWdlYUxNYnI3TVFr?=
 =?utf-8?B?V3ZNU1FZZTZzZ3BEeVRkSFhGTTltaXVtRTJyWVMzLzdNV1BRVkJEV09vcTZC?=
 =?utf-8?B?UlZKMnFWSWxmQ1NvbzhqaHFFM3ROQThmUk5DWWRwYWxNcE81WkR3MDlhQnRU?=
 =?utf-8?B?TzBLTklRQmZXYm1tZUFEZjhrSUlJcWxJZEtCYW13Tlo3SkpTeXA5L1RTRmRY?=
 =?utf-8?B?NzlRNC9ZK3F3NENmaUwvWXJJa0VRQ3FMUTJVWUcwYjZLaXNOMTJVdU96MjY4?=
 =?utf-8?B?NmNTWTA4V2NmNWJKT2x2RkxLc1djK1EvVWtZSitZRXkzMTZiajB3SldydERx?=
 =?utf-8?B?L2NwZlNmaEJEMXFlVHFpN3QrU3VTV3UxTGZ2WUY4OUFGbzErUGNySC9VMGVa?=
 =?utf-8?B?SFF3bjJDVGFsTmE0RkdpdVFjcFh6TzB5KzhCVVZIVXpVUml4V2ZLYnJJRldT?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f937de3f-5a28-4b2c-b9da-08dce53f6cfc
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 13:12:55.5705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRZO4BXWK8/r04N6qsTYC0abwWurAJhyG62GJb8GtwLwe0fbpwbTezXvTPJbaKAhaON2hhOWEnlrls5Zyh72uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5018

On Sat, 5 Oct 2024 14:06:48 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Fri, Oct 4, 2024 at 5:53=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
> >
> > With `Refcount` type created, `Arc` can use `Refcount` instead of
> > calling into FFI directly.
> >
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Gary Guo <gary@garyguo.net> =20
>=20
> [...]
>=20
> > -            // SAFETY: We have exclusive access to the arc, so we can =
perform unsynchronized
> > -            // accesses to the refcount.
> > -            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INI=
T(1)) };
> > +            // We have exclusive access to the arc, so we can modify t=
he refcount at will.
> > +            refcount.set(1); =20
>=20
> Why are you changing this to an atomic write? We just took ownership,
> so we have exclusive access and can perform an unsynchronized write.

Because I can avoid an unsafe, and use the new method. This is a
relaxed write, so I don't think there'll be any real difference.

>=20
> >  impl<T: ?Sized> Drop for Arc<T> {
> >      fn drop(&mut self) {
> > -        // SAFETY: By the type invariant, there is necessarily a refer=
ence to the object. We cannot
> > -        // touch `refcount` after it's decremented to a non-zero value=
 because another thread/CPU
> > -        // may concurrently decrement it to zero and free it. It is ok=
 to have a raw pointer to
> > -        // freed/invalid memory as long as it is never dereferenced.
> > -        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get();
> > -
> >          // INVARIANT: If the refcount reaches zero, there are no other=
 instances of `Arc`, and
> >          // this instance is being dropped, so the broken invariant is =
not observable.
> > -        // SAFETY: Also by the type invariant, we are allowed to decre=
ment the refcount.
> > -        let is_zero =3D unsafe { bindings::refcount_dec_and_test(refco=
unt) };
> > +        // SAFETY: By the type invariant, there is necessarily a refer=
ence to the object.
> > +        // NOTE: we cannot touch `refcount` after it's decremented to =
a non-zero value because
> > +        // another thread/CPU may concurrently decrement it to zero an=
d free it. However it is okay
> > +        // to have a transient reference to decrement the refcount, se=
e
> > +        // https://github.com/rust-lang/rust/issues/55005.
> > +        let is_zero =3D unsafe { self.ptr.as_ref().refcount.dec_and_te=
st() }; =20
>=20
> This code needs to make use of this guarantee for correctness:
>=20
> For both `&T` without `UnsafeCell<_>` and `&mut T`, you must also not
> deallocate the data until the reference expires. As a special
> exception, given an `&T`, any part of it that is inside an
> `UnsafeCell<_>` may be deallocated during the lifetime of the
> reference, after the last time the reference is used (dereferenced or
> reborrowed). Since you cannot deallocate a part of what a reference
> points to, this means the memory an `&T` points to can be deallocated
> only if *every part of it* (including padding) is inside an
> `UnsafeCell`.
>=20
> from https://doc.rust-lang.org/stable/std/cell/struct.UnsafeCell.html
>=20
> so when invoking `dec_and_test()` you can have a reference to the
> `Refcount`, but not necessarily to other parts of `ArcInner` like you
> do here.

This is fine.

A reference only lives until it's last used. This has been the case
ever since NLL. This is totally legal code:

	let x =3D Box::new(42);
	let y =3D &*x;
	drop(x);

This is true for safe code and unsafe code. You can dereference a
pointer and hold onto a reference, and then free the pointer. As long
as you don't use that reference after it's freed, it's fine.

The only exception is when the reference is passed in through a
function parameter, and then the text you quoted matters. Normally these
references are assumed to be alive for the duration of function, except
when `UnsafeCell` is used, then this requirement is cancelled. I linked
to a closed Rust issue, and I think the paragraph you have quoted is a
direct result of it.

Now back to this particular case. Before calling `dec_and_test`, the
entire `ArcInner` is still alive, so it's valid to create a reference
to it. That reference is then used to derive a reference to the
`Refcount` field, which is needed for the function call. Then we call
`dec_and_test`. The call is okay because all bytes `Refcount` are
covered by `UnsafeCell`. The reference to `ArcInner` is never used
after the call, so we are all good.

In fact, the standard library also does
`self.inner().refcount.fetch_sub`, which also creates this transient
reference to `ArcInner`.

Best,
Gary


