Return-Path: <linux-kernel+bounces-229764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9672C9173BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00FE6283267
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3ED17E8EC;
	Tue, 25 Jun 2024 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CeQWJcN1"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DE717C9F5;
	Tue, 25 Jun 2024 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352394; cv=fail; b=aEcvgigBLLkuC37du2uOKeEM+hIyphOon9Q4oPVaNrJIgz6zvx9efC0LDJZQKYu1Cl79n4GJa+OZLiRKMo+MBcsIlju68YeAgKY7OjlnRg8lHQQMEw3Z0TWyCpV4gzgT3f2Y6tH9MyAKB3LJ5QXkIG9G19cy+QgnOjzWfgqyAbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352394; c=relaxed/simple;
	bh=GYSjbYdylxN89CNLEWSr0j42BNp1mC36vl/miboukkQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PLphXsfnT79XgJbQcxj7kGCr2VjGzCAhBRGuEinwoJ2liLCuUV0y5FXf8DSSmvk4gjRdKpDN6H9mubR6NDCnSctQVibTbnfeTC64ISRIKMHjRilhwFnapXp/YggQnAj7H9KFNe02XTknula9Ot5Gq6tXR03iSPdL6HzPfg0MMFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CeQWJcN1; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2NYPfLBailXqbw0nGGSRShohlGcldJgTiH/MlxELI7DRWIAqUanH9+ew3DBZoEgDbnjMeWCoEwjoZs9W4a+XdvtM4cvairLp6ppuuCwfi8fQu1oiBSWlNv98Tv8H5AMLhwbDnoxnCG85+euFuXPGdhT97TdnX9n9z+aeruG1ThzKIUmKAdZmOzL8HFCHtTzz9985qahU8kAfKPebVRNaE5nf1Fy5ds7dlcLY6R/dicFEr9vKDJNo7TFTGX3MKMEoKK7lyQnnLJ4CqhRI9uytjB0NuLzV/wS2uf7sBPaRbm9MLXJ/+24gDWRNTRDpCDiVLolkTBR7NXhwfvSyZLRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heT/kLCePxxWus355ba4tp5NLquJFfnS+8UWQ8rl6u0=;
 b=Z3utDk6JaBt/eOajz/iaPKWUN1GjkPZWiuP8kIjz1Lqy9of12x1wRPFQuo/zKx8E2deDARZzzRRWhfOKuIxJzJ4s4fHxKt34Iw89/SK6G20mCZe4AhzUCYV9Q0bLzXMKgM19BHQV5NXOVCMayq6I18crS4en2ESV77d+zipWn44EQo1SK8rpuUlxnCxAsZ2KJFvLJh8rGwrTH6y4A9SKXTqz6tTxtQ231VRsd76P2IK1HjM3sE++HXCuLnO+zU71PNHeVCTmpq944tVeC39TCQljYrRf1mVR0NkUw9HDIcNGZhTNTrIT2YZ78mYX+Lo8FXuibrVdygSyv81/Fcu5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heT/kLCePxxWus355ba4tp5NLquJFfnS+8UWQ8rl6u0=;
 b=CeQWJcN1KgTSWq/0VQ2vocMHdQdH+QcePkVQFpogIOo9IpA1ZF6Tw0GpLuougsPM3LJK561Lhkwv8ozcJaGcFDubPVNkZtDAMAhNtAM3wc0r6lQa9A1fa3vIyLpnSnSXcv56TBpLgfvORPp0r9R9PJBMl3hoXlShcvShlAWfNgjov1/0XQMi/Sg/ZOeln6pNb8lyQAeR8td/CnFi0pHTIeDkXbe2OY3ay/ECqRLCtOmkkDamOx7EqReFbBp8VTlOPTN1GroShu9leyK8x7BK71/UUI2uTL8DybsYIRzQbURF+C6f43RykHeiB1BVGqH6yTO59b0at3NsexcNIfVK/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3764.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 21:53:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 21:53:07 +0000
Message-ID: <4247ace7-b4dd-48d7-8472-2d922f73ae9f@siemens.com>
Date: Tue, 25 Jun 2024 23:53:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am65: Add simple-mfd compatible to
 SerDes control nodes
To: Andrew Davis <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240625164528.183107-1-afd@ti.com>
 <20240625164528.183107-2-afd@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240625164528.183107-2-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3764:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f74b7d-bd19-4223-e72c-08dc95613291
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUp0akUvZE55ZnlwVE5hTG9qVitCWHB3aVpPaUdQRjE4Z2M3NXlCdzBQWXlV?=
 =?utf-8?B?SlR6SE9lTVByOFlaSWZKUHN2ME1JNUt0anE3VjhjbzdxR05oRzJsMWNIVUJD?=
 =?utf-8?B?dGVQQkRHbkdyM0gxaWJPamdja3l5Q3hvM1Nna0JXSWFVYmVkcS9RR0tiTVdX?=
 =?utf-8?B?SitnWkNLcmVURU8xVTVtMlFFNlRSSUUzRElQNlRacEs3bHpaRGs5QURwZTJZ?=
 =?utf-8?B?Y3VpNUpNcXBhZzZoQmpaaTEwQXgraURlUmxZeWhVbTZoSXNOT3o0eUJ2d2cw?=
 =?utf-8?B?RCttWGlKWTJWNlNKbTgvcVdNczVtK2daQXVyZWZnWnlpbkRsaXBPaCtaQmJU?=
 =?utf-8?B?VFhNR0xjbHNvME1sekVXN1VpWksrV05SWDNiZU9sZXZheHJnOVlQK2Q5NTFN?=
 =?utf-8?B?dnVLZXZMQ2hLVlhxQm5GMHo5UGxmdUhTQ2dyQ05qbnhMSXVlQi9UTWRrS2cr?=
 =?utf-8?B?L1c1YStRc3luUHFNRFZ1d1k1d2pNTWZSeENTL3ZsRTU5R3RtUU9uRFZBN0RT?=
 =?utf-8?B?MFJ1MHQ2c0NVbXdOb1lMKzZOQ1Y0OTMzUDZPQ2lKYVZ4MGpNL3hyZUh1L1dp?=
 =?utf-8?B?YWMrTzExRTJld0VnRExWWWhHS3dxaklEMDBtSnNNbEplMlFBNkNSMVZlTlU0?=
 =?utf-8?B?OXNJdGNSaWF1ZWg2MEllWjdaRGRvazA5WnNLTEJCZ2R2d29LKzN6R0IwbFVS?=
 =?utf-8?B?YnJpek0rR0g3ZlBYZlVLeTJpUllCUy9hS2NaU1hWMU1QWUwydG9JUTRCU2do?=
 =?utf-8?B?ZXoxYm5xcjZsZ0JiRGNaWFNMYlF5bzdmQ3pyMnVBK3lvU1FlZUdjaWhLMlFC?=
 =?utf-8?B?azFJWmsyS0p0a0t4d3FPNFlTU3pPM3Z5NGw1V2YreUQ0RUVha0dacVhUZTFJ?=
 =?utf-8?B?Q2pobmo3OEVISXMxUWhIVlhRYVllNnl2WEdGY25CZEJPTzlQMUw1SDhYZnVB?=
 =?utf-8?B?eEh6NXk5SWgyL2ZqREduTkI3VjNZelRxTE1IMzdxV2pnMm9iTnlJU09wYmY5?=
 =?utf-8?B?OWRRSVdhYWI3RklsWmwxYkNlMnUxTlY2Q1BoYUE2c1hFVkxET0UwZzRRZGVP?=
 =?utf-8?B?SUx1WGx6UVZMUlAvdnVMWWF1N3JuUVJBbDFGTlFrQlZ4bTRjai9qQmdtWlFQ?=
 =?utf-8?B?TXlDOE1XY1FsMExOdlBIVzJybmhGcFJMdUZKR2l2akhHT0hMMUF2OFo5QUY2?=
 =?utf-8?B?Z1o1S2IvTDNaNGdHTTFxM1RCK0h6TGo2VU93TVlhWFlXbXFtWGlSemdEaTNT?=
 =?utf-8?B?cmxOcnVqWmw3UVVvWVVFU0NabHZTcE5sVGthbmZTdjB4Y3A2b2kzYzU4ZnU4?=
 =?utf-8?B?dngxNXZKeGdha3ZVK0VISFZoNmlnYmg4TWl4T3REKzZmSUpHMlVRR3R6cUwx?=
 =?utf-8?B?bElZN1JSblVpbXdlbytQTkhUbTdUaFJ3cThwYTZobDdDdW9CRGZlMjN5UmYw?=
 =?utf-8?B?Z0lvRDRUR0FIWmJMbnJEZ0hPN2IwLzVoV3hQSmZpZHpnczVqWHV0WVE5T2lp?=
 =?utf-8?B?a0U1WlIyYVc3am9IYll3VUlHUFQ5RkNXNGV0SjV2dlZ5MkQ0SWd5UkNHZ3hR?=
 =?utf-8?B?RVVGVXBLMmlRS2MzNmNMWkVaQy9aR1BSakJnL0k0M0kyYnM3dllxNFJrWHFS?=
 =?utf-8?B?Sms1dHB6dlNETEtuQlZScXpJVVU5TDVKSEp5NHFBZlhhb1JLYzMzeWtFdUFw?=
 =?utf-8?B?eUtiZUN6YkZhZDFDZS9NUG5NUzJrU0FWTkVmcFJrVEc4b1RHVjJTdlk5VHIy?=
 =?utf-8?B?ZHFVZDlWQm9LREZxVEpUOGU1eGpjVjBKVWVOM0REa213NDNqTDNacWZHOUIx?=
 =?utf-8?B?d1dVWENReU9DQXhsQ3NYQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUlBc0VMTDhHSGloOG83cGRqQXZxemNkdUNxRlVLcHd4VVM1N0p2YW9XNWpl?=
 =?utf-8?B?Z1hvWFJTWUwxUGFxQWR5SFFrMk1iNFIrMU9xQzFDUDhqWUMvaFNEOXVibzlK?=
 =?utf-8?B?eCt6aVV4aWxzdW1NOG54K1VSS2xPZEF2YlJUNTc2Njl4YUJUQVhTVURJR0dO?=
 =?utf-8?B?Y3FhT1h6QllReGhhTjBCdmZ1ZmJFQ2NObnhhTHFBTW1jNHZCOFRNV21aRHAw?=
 =?utf-8?B?M0lIKzR5OU4yMDFOVm9kM2NWZU1mV2FNOC83MVZxd2duRGVybForV25XOU1p?=
 =?utf-8?B?akNKUWNZdFh1NzdwSVY1S2hOU3lZU0FLSys5SUFmZHRnV1JiWDluWFdSOXhj?=
 =?utf-8?B?NXJLM0Z5bnpmd0I5US9FeVlnbTI2MDlxYjV4SjAvQ25FSGUyU3JxRjl3Z3Fi?=
 =?utf-8?B?V0tEYWdnV0Y5S1AwVmtaY005T1dPUXpjYzA1cU1pOWlzVmtIRTJ4U0o0eXpW?=
 =?utf-8?B?c0dldVo2SHJ3OE1qYzZKblBHMWVTWnZQZk1ITDF3Wjc5RlFpY0owSUw2ZmEv?=
 =?utf-8?B?Ly9sY21WeEFlRldjQ1RldFVNaHowNVFNWWsrUTdLWXRIVkxGQ0NZMkgrNU1r?=
 =?utf-8?B?ZnhHOXlxMytYODUramtERklHYXcvY3ZHWGMvdWFqRmpSVjl3Z29KdU1VSlpS?=
 =?utf-8?B?WTUrRE1xTHNFQ2ZTZE5hbEMzcm1BSVlRNmhNSzNwSzZiYTZEZEJiV2NnS0pL?=
 =?utf-8?B?TEtlU041OTlRMUtqRE05N2p3SUc0SjBTeCtWV2UzdTBINHgzTTBUVW15NXdK?=
 =?utf-8?B?WVFiSWJNQTcrSEVvNDlGNno3b2hMQkNyZ05OOEo2SjBjS1o1TUdBeXVYc2xk?=
 =?utf-8?B?Y1JQNFNETDE5MFp6MFlNaWh2VVA3MUNzNmRnRTVBYlhQU3hxS3BNTG1wYUY0?=
 =?utf-8?B?YncwR0R5cDZESEp4L1c2eFNLOE5oWUFmVzRpaDk2UXBIa3BtM0xqRVV4bEVn?=
 =?utf-8?B?TER1dUdDQ3o5ZVIzL2Rja1R1UndYY2xLOW1uNnRraXdXNVdLTU1neEhjcW1W?=
 =?utf-8?B?M0UzOVAxR2RJUG1BWXk5UVVKZlB6U2ptbkxMdlhYb0ZRVzNlSHdvc1V3Qkk2?=
 =?utf-8?B?WDVQeExwUWt6S1lGZ0VSNm5aeXJvVTgwM2crOUZpZUdYaXFhbHdGQVQ2R2JF?=
 =?utf-8?B?dm5hc3dPYXpjNTVWa210aGdyRm9xSkh1QkpVVXdnYURrMEZWM2x3M0xDYXZ6?=
 =?utf-8?B?K3hqTHdtV1JqKzU3TDlya1pPdEJ4dytWM1RmTVc5dCtmUjRVTmN2d2hkZjJ1?=
 =?utf-8?B?S2VESVFhKzJFajltSHd6QWlMV1MrWFQ4RGhuUUpVZ2NVcVlodGU5WXpqNFBl?=
 =?utf-8?B?cXZOOXJEMEt0aHE1MEgxN2JNRFVwZW56Qk53VUlra0VwUkZWVzZ1aGlySk1B?=
 =?utf-8?B?aE9GS3FZTlZNazQ1UnE4eHgvSFZNZFJrSlZGdUVlempIbzRXSVQrTS9LdnRn?=
 =?utf-8?B?NHNGQnlZQkcxeTBCOFlLRnpEMElOamExcWRWSjg0bjZNYWJaZnBXd3EzRWdm?=
 =?utf-8?B?V2M4dmFpUTRhaGZEWTFlZEI4VmFJTFJGcGozN0VwbXFiUmM5M2NCb0pBYzRB?=
 =?utf-8?B?VnJGV2VpdmtzQmZjVUVJYnh1Z0QvNGZJcDgvM3BvR21qaHFvQVV3QjEveWx2?=
 =?utf-8?B?OVNTdDI3TDFkaWQ2eW1HYm9tdUNYYk04Tk15UysxdWhjTThJb3lQcXVXRlhR?=
 =?utf-8?B?SlF4NHoxL3hxZGNERktqZXhNRDZEYjluUzEwL2VKbUY3OUwzS2lHMDJaWWpV?=
 =?utf-8?B?VURuZmhubWtZdW84cXNncUx5MThFakFTWjRzalBIUSsrK3hPcm5DVnFicWpG?=
 =?utf-8?B?dzFVdnVCSk9Xdy9aekhCdjV6S3NxOVNHdkxpdGxSeGxUQkc1RS9TdjNlMlMr?=
 =?utf-8?B?ZTRFSkNKV1lpVWdNSVV1T3VaWFI4TGM4MkFNeFRmaVM2d0UwZCtJOVJDSDYr?=
 =?utf-8?B?U1Bab2NPNE5pZFBzUjYrUjN1Zi9vQ0pNS1c0N0kwNzEzQ0ZadnRtZERoTFQy?=
 =?utf-8?B?NVpyY0NZRlRXV1cxdHRGdVdYMDRVY1d3aElDd1RDdm9yMUJic3YvWTd0S3ZJ?=
 =?utf-8?B?MW9pWHo3RFYwWGF3NDh0ek54WlRFam1XSVNkVFoyS3JlZ3pieXphZE5MTm1I?=
 =?utf-8?B?WXNDTWJJSnk1L0RyN2VjWlczZ3pkMFVxVHBuQzVmbVN4Tldwb1BSdS9OUEVR?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f74b7d-bd19-4223-e72c-08dc95613291
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 21:53:07.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg14zhjiD6etMeafZ3FwJ2ZuHRGWJFJonrPN9YoQcTAewxICbAYYIGz0U3bZvAVbzCvjysNlZ5faWY/G3WgZWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3764

On 25.06.24 18:45, Andrew Davis wrote:
> The SerDes control nodes contain both a clock and clock mux, this is
> a simple MFD. Add this to the compatible string list.
> 
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Fixes: da795dc4f2a0 ("arm64: dts: ti: k3-am65: Move SerDes mux nodes under the control node")
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 1af3dedde1f67..06ed74197f893 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -478,7 +478,7 @@ scm_conf: scm-conf@100000 {
>  		ranges = <0x0 0x0 0x00100000 0x1c000>;
>  
>  		serdes0_clk: clock@4080 {
> -			compatible = "ti,am654-serdes-ctrl", "syscon";
> +			compatible = "ti,am654-serdes-ctrl", "syscon", "simple-mfd";
>  			reg = <0x4080 0x4>;
>  
>  			serdes0_mux: mux-controller {
> @@ -489,7 +489,7 @@ serdes0_mux: mux-controller {
>  		};
>  
>  		serdes1_clk: clock@4090 {
> -			compatible = "ti,am654-serdes-ctrl", "syscon";
> +			compatible = "ti,am654-serdes-ctrl", "syscon", "simple-mfd";
>  			reg = <0x4090 0x4>;
>  
>  			serdes1_mux: mux-controller {

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>

Was briefly nervous as the fix initially no longer worked. But I had
switched devices in the meantime, ending up on a SR1.0 variant. And for
that, we are still missing a PCI errata workaround from your SDK in
mainline...

Jan

-- 
Siemens AG, Technology
Linux Expert Center


