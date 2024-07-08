Return-Path: <linux-kernel+bounces-244377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB0392A37A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F229C1C2117A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F108137923;
	Mon,  8 Jul 2024 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="An6G4Uph"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070.outbound.protection.outlook.com [40.107.117.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C806674057
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720444300; cv=fail; b=N1iqjO9Iyfd9SR473vNFiJEgyvg76ItdUO+65vnjhasR1FiFnYZKzHZX9jaYFq5ECoHxEoLLeyO/Gw40NcXNv2NWUineJnA8PZkZkcm+tkP6KmDXH3p5af3ioaqNNvetYaG8pKgtO59LJk/3dCIKWxG4x/nV2iHSFMr5+VVRxPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720444300; c=relaxed/simple;
	bh=LPMsGI0RXgRz8+GoO3mqN+yMS/FtpT6rh+oYJj8sk3I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ex0EYdIprvWzj/BEODS9vHBq/Y5hEbENtwGVDTDZ1z/VimUwAfY94ciZsyk9Elwe+YDkI2HO5DH1DctYI/jEUwGF69psnixmHlR7dZW6iT17sv87b8mt/vs9k897FFAlKgjLqqrHIdyS/BruV3wHZHRP07dPxi+gCEM9BeduSgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=An6G4Uph; arc=fail smtp.client-ip=40.107.117.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bsk1rkoKsW+UZ8qrrHsWfdj9hrjO+DGKhUzN/wpp7KO8bMpuNEa2z/leVtxMUmqhEAsGlFzCF7xDAO8aiB+V9E9OleIIKNqIijFog4T5r6O30jY9C5wuOHHbqjM1mTWtZoeJ21crt3sC3YAY2l39fz580n4Qo9J62gJ2imMFYOtb4B6ZxIEbM4KBhr4iOfeT5sClkgF5jp7Znco7uy26uKI0fdmEFTPl36Bei/rpGrovqsFrrvWsfQf55O8PpfXvAjlZ1H2c9MSm6LiLAgK6uywl5kas/Ehhv6kgOlfyOa9nll0q6Vpc+zQr43H/ETWrsagXL+xrqeqAGNGiKP2B7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBG9stpm67lT3u2dRH8M8bs/2f50sOXAHyVPfArHOF4=;
 b=NbiAyIjiq+B2dCeudHkQDJKtK2jsWIoP+TzyfvVAGO80PzTzNtLVkog/8v4ekfJw6KcoMS6d4A0uTZVniQY9R8jbv9KZlNuuZ05ZKoinI0/GZMAfLBpczKxGdc8DNPLd6Ni+96wFAFfpx4jlcw1qhzieztQjDiRKNerN3hw/FrP3LYMC95qBJ8PzvjiXE3RoJWkIBqqk1M+XzEitFBVjMlnaU7OAnUYmGbtoNq3BIzoEIGJsljTnpa8rNnAnoAwocfIFu/TaMhFlc/ovia7CSeV9izQsBVQbZb/YIzJrRMlq2lZZYg4cWQ6Pmkd9dVT7WdlihQVwR0cBrpRP0gFb0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBG9stpm67lT3u2dRH8M8bs/2f50sOXAHyVPfArHOF4=;
 b=An6G4UphJ6awY479yzMndq9omKQQjplEtEmtPyVC8tzoJRrYt1hNvGCVyVAHZTRRerkw2R1CGW5vISycfYDBm7ond+l3oqZlEPIkGgV4mgq9APBooNlR0CybLl4UbUXBupOFiBsBeSNettTEzd0hrVXNOWTUE+oOtE/bkcnU37qcU2qpD1GvNulj53G+Z0DWpSkBkhcwORmsg/mAygYMYMawQO0V/KA2w6RBVK5+E/zc7lc9X2xPjSfUs4SjwDZl21BKy8q8m1X+ChraoM2avipoD7McSRCWZvdkqFeIrBaNgkXk+OhHxLrHHoZaOPgystfjuY3sHFrtdKURkygHeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by JH0PR06MB7211.apcprd06.prod.outlook.com (2603:1096:990:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 13:11:33 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 13:11:32 +0000
Message-ID: <cf6c6d1f-3719-4744-b943-5c572d0d5fb4@vivo.com>
Date: Mon, 8 Jul 2024 21:11:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm: shrink skip folio mapped by an exiting process
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
References: <20240708090413.888-1-justinjiang@vivo.com>
 <CAGsJ_4yrGR5ULU=MDXZq+hEDb+TWuRkfbg9V9Rg=mGAWOpUkxQ@mail.gmail.com>
 <122bbe20-f2ab-4d44-97ac-76df8469d3fa@vivo.com>
 <4ca9836c-4f03-4792-9be8-f7db71a2b162@vivo.com>
 <CAGsJ_4xMrzTfAC8wicK1-CLftXY-Bm+mZ8BnD=ZvtmB_NKzbKA@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4xMrzTfAC8wicK1-CLftXY-Bm+mZ8BnD=ZvtmB_NKzbKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|JH0PR06MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: f11681bb-b118-42cd-a6dc-08dc9f4f7cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVFFbjJFempOamVKM3k1djNEeEJaWlJXU1RhT2JwTVc4cTFVT1VjK0JFVzRM?=
 =?utf-8?B?MkVRWVBGNXF3ZDlrRjMrS1JkVTZlcHdubnVhZE5hdm5pOGxEemJTYzFhRGJz?=
 =?utf-8?B?R3I3RS94SzhTejhmNEpYVlRzUHBlMHp4cm1ubDkrU09QQmJKT0xiWVdZS2hP?=
 =?utf-8?B?Ui9neU9IMEVlNlhHWjRENW9uTmlKdnFKNmJGY0pYRmh1QnE5VFIzRDUvbU1j?=
 =?utf-8?B?Wlk4MXE3dnUzYnczQ0hjbjloNzh0NGhSSEowZzlTSWpRUHplbCt4Z2Zha3VF?=
 =?utf-8?B?ajNNM2d4eXZwd2FwVXIzZHJTMVI3dnVFSldheGFUTE5XQTNsSjhCc3JUeGt5?=
 =?utf-8?B?QzBPNjcxZFVjQytNVEY5NjJCcE5ibG41K0NKMUtNUE0xelZUU3NBU2hKb1Fp?=
 =?utf-8?B?WlpsOEpUOS9JTGZhQStJNjBHUm9GeTJ5c1VENWhuc3lXM085Wm42OEtCU3Jw?=
 =?utf-8?B?MXpmOFBZRWhoNWNMSzd6U0ttUjhnK3FZVzJYb2Y5bkFRZHBaM3RDQjRZKzlk?=
 =?utf-8?B?ZGFzcm91c3g3RmdqekZLVWo1S29nQzVaM0FhTldsYUpOYWJLM0dkU3puUVBR?=
 =?utf-8?B?aUZiWjNPK1JlZ1hsNERXUjZVMlowNUZGNmpUL3o3SkltdStyU1hrQStkam5S?=
 =?utf-8?B?U1E4MWdZTzIzWE01V01xa2I2aDRna1FzdVZ1SHlaZVJjTnJVTFkxa08rQ0I0?=
 =?utf-8?B?c3IrYTJaNVlJbGNzUVRTaVRDYmhFMnBaQVAyYUNFZXJhZVpwNWN4NmNYMWw4?=
 =?utf-8?B?NHFKUnVqN1A2T1RrZkUrL01vT1gxZFRhMlhQUW0zWjducU0zdFFacE5zUjVD?=
 =?utf-8?B?RVlQelpva3pLNVVobC8wMS9lSHdFck9wOWFaMGtwU1c3VGtFSEtuVTFnY2pp?=
 =?utf-8?B?aTVyeko3cVJ1SHkxNitIbXJsdGlDVFZyNC9Fb0syOFhOOHRNU0dRSktlMHFp?=
 =?utf-8?B?OU05K21ISTRSUXcxQTloK2hZSXZPb2w4dnZsSzQ1VzV2YkdiV1FBbU1KTG52?=
 =?utf-8?B?dnZUT1ZnMzlnWVhSZ0tLdEkxTDQxOVhQVlJpSEdXaXdGMitVVWtVSjlBWnlZ?=
 =?utf-8?B?eElIVDhrcjBKbm9STWY3MEozdUYvQUNuVi9mQWo1U1BtMElueUt2NGU2eW1O?=
 =?utf-8?B?ZTg1Y01ac0hFdDRBM1lNZHpvVk43YjhVZjFuM3VqWk9tWElKSUFsditPOHhT?=
 =?utf-8?B?ZWkvb3JsSzlRS3hsZCtBUmg1SmlodCtCczNidkJtTDlSYzNqcGJMaDdYR2s1?=
 =?utf-8?B?UDZDUU9JR0VCb2VjSGFYeHhUWVpiUVZZM2orK1kxL2REU3lWeU1ReTVDdlJX?=
 =?utf-8?B?TW9OZnZja1NSM0JYRXRUMEZnN3lmTkszRjJxTS8zdGhBNlMxQzdCcXovbTlY?=
 =?utf-8?B?SFFHM0t5Uko0R0tYWVY3ZDcyaWZXcW5iZ09uWXZSeEluZGdtd3RuamZJVTlw?=
 =?utf-8?B?TzVsSVBrdEpPdmZtbm01SkFiSmVzV2d4RnRBcmZlbjFwRW5Fa3JjMWxRS3VJ?=
 =?utf-8?B?NjA2Q2t1T2lSclI0d1d2cktJTHJndEQ2UHMrOGIzWnQ4Ym8rSzZJR3FtT1Z2?=
 =?utf-8?B?TXdXRmJjZWViOGdESEozVlRqY0l5OHJDZHh5VFV0YlJPTDRCbEYyQ1JWdGp4?=
 =?utf-8?B?cnd6bTdwaUlSSDV2djZheUo2TENxSC9WVFlMcmRUbThiUU4yVGNsMTFwUDBn?=
 =?utf-8?B?WWxmQ0Z5dU5CU29hVU5FY1JxQ0RobHBqRzZaNXQ0UTkwSkV4SzByZWl4NEQr?=
 =?utf-8?B?VHo2REJkQTlQbE1UaUZDa1ZKKzR3L2JNNGRKZDF4cE5VQkpmL1IwbHVmMjRI?=
 =?utf-8?B?OVVSUG9RRWovaXF6eHdRT1ZacHBtaHV3ZTVxdVBNVkh6cHkwb2R1WXJwckxW?=
 =?utf-8?B?Qmp0ZDFES0JTTVNydG5VYWZDN2xlL01QcWN5TGxoVk9rWjcyMFRSazZ4RHRh?=
 =?utf-8?Q?hD2Q9zwrTeE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGNzK0cwUFB6ejVVZXNCTEJLS0NhUjNyNnBtM2lOM0didTI1VEhyQllUNWJt?=
 =?utf-8?B?cEdqTUh1S3VWSmRyTEY3c2UvcnEzL2wzWWdLVjl1VHJmZ2pmb2w4Qk1PN3Vs?=
 =?utf-8?B?M2FnVHBkTWoyL3JDY1FjbFROUEZjOUhacTBpZ3VNaG9KSW9RNmxQNWpJM2Mr?=
 =?utf-8?B?Zmtab1Y0Rmd1d0JORTVxKzhCamlkV25qVksrSGdnOWE0dnhiTFpXdE5uVFJo?=
 =?utf-8?B?RjFlMFdXZ1lZaXhEb2VjR0hCQTVEM29zSkE4QUx2TGM1TWlBWVYxWU0xQ24z?=
 =?utf-8?B?QjVXMjJQVFIxZ2VOUi9oMjRCcmkrenVnOW5IOUNKNU5PRnNUZlQ2TVhDZDZD?=
 =?utf-8?B?R21mT0x5SHNpRFc2MUUyVHV1N0FLRlVCSE1lZERlN0lHeHpsbUJBd0NZeWtB?=
 =?utf-8?B?ckozNXJPbVFldUZsZmtEQUpEYVpOc09QUG9YcHJlU1lpRm1DNHdYdzVtNnR4?=
 =?utf-8?B?WE9RUmozZ1BaQWNjM1hmRVptd1BqakJVeWhVWHVJZEdBckZMd1VENlhYMy85?=
 =?utf-8?B?ZHEydU9Fd21kOHlyMk83NGxBQ2Z1QS9sUmNpbWkwUi9RYWt3ckRYR2JaK0FJ?=
 =?utf-8?B?RUxsMThUdWc3K25XbUpMWEhkOGhud29JYzFQOUVrcGRWZGtQZmgxWUg4R0ZQ?=
 =?utf-8?B?OVo4V09XK3RFamE4bnlKRjZxNTd5eTBDMytzbTNMUXpmenZNbU5FUU1KaEZh?=
 =?utf-8?B?aWtSNnBYVlUxWGt6NmlSc0FpTjF5UXpTVGxOM0pTMlRhNSs0WUhoQVd4aGM2?=
 =?utf-8?B?elNibzFRdnhqN0tBSnhSS3dVaExCMDlmMW9NL242NjIycUFFc29kdGRPMkIz?=
 =?utf-8?B?NnFFc1ArVWlza3NwaHo2aHFLQlM1RVF3ZnROdTl0TlJ5N1RwWEcyV3QwQjRK?=
 =?utf-8?B?T2FqejhMVHJWVkw0ZHMyYlhmdlcxT1VCYzN2SEZCSzFNV1ptYU9Oa2lmRTZ5?=
 =?utf-8?B?cHV3UXR5MXIvQ1JHM2ViazZ0aklyaHBGUytsNGZHSnk2WDdxRURnZVZSZlNV?=
 =?utf-8?B?RFkrR0hxWE5ETHdrdDRLMk9MRkZXalRqQzVjREpZNzBNdkFMRkdReURnRndW?=
 =?utf-8?B?UkNndkd6SVJuUWN0di9vbFZ2a3A4U0RXbC9LS09IOTRkeklRL0c0YjF5cmJY?=
 =?utf-8?B?MHZYNE5GZE9RMFhKNzNVYVBZSWY3RlJ1S0JEckNReDBjUmhJaDZUZVBGZHFK?=
 =?utf-8?B?Tkx4Wkl2bVhvbjc4YjJWbElLLzc0MkFzSVBCNmtneGhJeE5mWi9mWmhKU1R4?=
 =?utf-8?B?S1pXWDhiVVdCem4zMmNVampleDczSDZSYlRpUU9HeGwwY0d4TXFsNnQvQmVZ?=
 =?utf-8?B?TXlQOTNuUjZJd1ErY2ZURTZaQk5HRzM0N1BSb0VpRVV2NDV3MzhTdjduSSto?=
 =?utf-8?B?UXZJTms3UkFXRktCMFRwMHp6aWhwNURMOUhFdzhoeExsY3ZwRTNtVENvNEw5?=
 =?utf-8?B?MG03Y1pMVFo1eVozeVpyWmRvWlVOZ0VURjJCWGhBWkNvT0RrUTNtSFk1c2Zx?=
 =?utf-8?B?VVZpejRKeVhwTlJWckh6ZHNXSHVJMHdUeGhoZGplQ040YWROM0Z4c1Zoa28v?=
 =?utf-8?B?bjZEUDdrclZuTzNLRGRobUw0RkExdnhPcEEwNysxR2k3SnNBMU5SeFdzSDll?=
 =?utf-8?B?OEk2T3dyeTR5ampUMVFMVkQyRTQzTUUzOUY1QVd2YXhOenV1eGFJOUJOd3k0?=
 =?utf-8?B?KzZQaGswbDdsdTI0b2p1QitVUkpPNU1QeWdSWVlhWTdoSUdxbnJzZm9CMmc2?=
 =?utf-8?B?bm9iSnpyRDh0WXkvL1Y0N0lSQWxwSzZndlI5TjE3c0FuZXpjTGV5eG5uOUcw?=
 =?utf-8?B?ZVFLUEZCM3doTlNnQXF0U0VJS2hMQlhEREsvdlBaVTdkdzlPUHA1Ukh1MlVI?=
 =?utf-8?B?dVVVVllUK05TdXhtd1gveVB4bVdFRDcxTHJKMW9ER2RLalgzUmlkS0EvdVhu?=
 =?utf-8?B?OFFSdnFCbzM1V0RhVTE0ZGRwQ0FuMUtwUTZhNmppTm1qTkQzUFVrWFVGTjFx?=
 =?utf-8?B?KzhXYWxHODRsT2dDZXZiQXJUOXcwQ2w4ZWRtM0I4V09jVzVNODB3MjUzMThN?=
 =?utf-8?B?NE05cGNSMDh3STNCeWJLeUFEUkxZRENHa1dYb0tUUzl4SEFUclA3TGExOUtY?=
 =?utf-8?Q?/msz/W51lv4/yF6nM5PCYt2wQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11681bb-b118-42cd-a6dc-08dc9f4f7cfd
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 13:11:32.8632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDJN9Uv3wBHoawSKOD9jlqVv7aJUJp4jh4+ib2nX0sbNsQ93WO/XTHZYUO7dzBX4hRcM2wtXAsHxMvtW1R4hHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7211



在 2024/7/8 20:41, Barry Song 写道:
>
>
> zhiguojiang <justinjiang@vivo.com> 于 2024年7月9日周二 00:25写道：
>
>
>
>     在 2024/7/8 20:17, zhiguojiang 写道:
>     >
>     >
>     > 在 2024/7/8 19:02, Barry Song 写道:
>     >> On Mon, Jul 8, 2024 at 9:04 PM Zhiguo Jiang <justinjiang@vivo.com>
>     >> wrote:
>     >>> The releasing process of the non-shared anonymous folio mapped
>     >>> solely by
>     >>> an exiting process may go through two flows: 1) the anonymous
>     folio is
>     >>> firstly is swaped-out into swapspace and transformed into a
>     swp_entry
>     >>> in shrink_folio_list; 2) then the swp_entry is released in the
>     process
>     >>> exiting flow. This will increase the cpu load of releasing a
>     non-shared
>     >>> anonymous folio mapped solely by an exiting process, because
>     the folio
>     >>> go through swap-out and the releasing the swapspace and swp_entry.
>     >>>
>     >>> When system is low memory, it is more likely to occur, because
>     more
>     >>> backend applidatuions will be killed.
>     >>>
>     >>> The modification is that shrink skips the non-shared anonymous
>     folio
>     >>> solely mapped by an exting process and the folio is only released
>     >>> directly in the process exiting flow, which will save swap-out
>     time
>     >>> and alleviate the load of the process exiting.
>     >>>
>     >>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>     >>> ---
>     >>>
>     >>> Change log:
>     >>> v4->v5:
>     >>> 1.Modify to skip non-shared anonymous folio only.
>     >>> 2.Update comments for pra->referenced = -1.
>     >>> v3->v4:
>     >>> 1.Modify that the unshared folios mapped only in exiting task
>     are skip.
>     >>> v2->v3:
>     >>> Nothing.
>     >>> v1->v2:
>     >>> 1.The VM_EXITING added in v1 patch is removed, because it will
>     fail
>     >>> to compile in 32-bit system.
>     >>>
>     >>>   mm/rmap.c   | 13 +++++++++++++
>     >>>   mm/vmscan.c |  7 ++++++-
>     >>>   2 files changed, 19 insertions(+), 1 deletion(-)
>     >>>
>     >>> diff --git a/mm/rmap.c b/mm/rmap.c
>     >>> index 26806b49a86f..5b5281d71dbb
>     >>> --- a/mm/rmap.c
>     >>> +++ b/mm/rmap.c
>     >>> @@ -843,6 +843,19 @@ static bool folio_referenced_one(struct
>     folio
>     >>> *folio,
>     >>>          int referenced = 0;
>     >>>          unsigned long start = address, ptes = 0;
>     >>>
>     >>> +       /*
>     >>> +        * Skip the non-shared anonymous folio mapped solely by
>     >>> +        * the single exiting process, and release it directly
>     >>> +        * in the process exiting.
>     >>> +        */
>     >>> +       if ((!atomic_read(&vma->vm_mm->mm_users) ||
>     >>> +               test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
>     >>> +               folio_test_anon(folio) &&
>     >>> folio_test_swapbacked(folio) &&
>     >>> + !folio_likely_mapped_shared(folio)) {
>     >>> +               pra->referenced = -1;
>     >>> +               return false;
>     >>> +       }
>     >>> +
>     >>>          while (page_vma_mapped_walk(&pvmw)) {
>     >>>                  address = pvmw.address;
>     > Sure, I agree with your modification suggestions. This way,
>     using PTL
>     > indeed sure
>     > that the folio is mapped by this process.
>     > Thanks
>     >> As David suggested, what about the below?
>     >>
>     >> @@ -883,6 +870,21 @@ static bool folio_referenced_one(struct folio
>     >> *folio,
>     >>                          continue;
>     >>                  }
>     >>
>     >> +               /*
>     >> +                * Skip the non-shared anonymous folio mapped
>     solely by
>     >> +                * the single exiting process, and release it
>     directly
>     >> +                * in the process exiting.
>     >> +                */
>     >> +               if ((!atomic_read(&vma->vm_mm->mm_users) ||
>     >> + test_bit(MMF_OOM_SKIP,
>     >> &vma->vm_mm->flags)) &&
>     >> + folio_test_anon(folio) &&
>     >> folio_test_swapbacked(folio) &&
>     >> + !folio_likely_mapped_shared(folio)) {
>     >> +                       pra->referenced = -1;
>     >> + page_vma_mapped_walk_done(&pvmw);
>     >> +                       return false;
>     >> +               }
>     >> +
>     >>                  if (pvmw.pte) {
>     >>                          if (lru_gen_enabled() &&
>     >> pte_young(ptep_get(pvmw.pte))) {
>     >>
>     >>
>     >> By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
>     >> &vma->vm_mm->flags) is
>     >> correct (I think it is wrong).   For example, global_init can
>     >> directly have it:
>     >>                  if (is_global_init(p)) {
>     >>                          can_oom_reap = false;
>     >>                          set_bit(MMF_OOM_SKIP, &mm->flags);
>     >>                          pr_info("oom killer %d (%s) has mm
>     pinned by
>     >> %d (%s)\n",
>     >> task_pid_nr(victim),
>     >> victim->comm,
>     >> task_pid_nr(p), p->comm);
>     >>                          continue;
>     >>                  }
>     >>
>     >> And exit_mmap() automatically has MMF_OOM_SKIP.
>     >>
>     >> What is the purpose of this check? Is there a better way to
>     determine
>     >> if a process is an
>     >> OOM target? What about check_stable_address_space() ?
>     > 1.Sorry, I overlook the situation with if (is_global_init(p)),
>     > MMF_OOM_SKIP is indeed not suitable.
>     >
>     > 2.check_stable_address_space() can indicate oom_reaper, but it
>     seems
>     > unable to identify the situation where the process exits normally.
>     > What about task_is_dying()? static inline bool
>     task_is_dying(void) {
>     > return tsk_is_oom_victim(current) ||
>     fatal_signal_pending(current) ||
>     > (current->flags & PF_EXITING); } Thanks
>     We can migrate task_is_dying() from mm/memcontrol.c to
>     include/linux/oom.h
>     > static inline bool task_is_dying(void)
>     > {
>     >     return tsk_is_oom_victim(current) ||
>     fatal_signal_pending(current) ||
>     >         (current->flags & PF_EXITING);
>     > }
>
>
> no. current is kswapd.
Hi Barry,

It seems feasible for check_stable_address_space() replacing MMF_OOM_SKIP.
check_stable_address_space() can indicate oom kill, and 
!atomic_read(&vma->vm_mm->mm_users)
can indicate the normal process exiting.

         /*
          * Skip the non-shared anonymous folio mapped solely by
          * the single exiting process, and release it directly
          * in the process exiting.
          */
         if ((!atomic_read(&vma->vm_mm->mm_users) ||
             check_stable_address_space(vma->vm_mm)) &&
             folio_test_anon(folio) && folio_test_swapbacked(folio) &&
             !folio_likely_mapped_shared(folio)) {
             pra->referenced = -1;
             page_vma_mapped_walk_done(&pvmw);
             return false;
         }

Thanks
Zhiguo
>
>
>     >>
>     >>
>     >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>     >>> index 0761f91b407f..bae7a8bf6b3d
>     >>> --- a/mm/vmscan.c
>     >>> +++ b/mm/vmscan.c
>     >>> @@ -863,7 +863,12 @@ static enum folio_references
>     >>> folio_check_references(struct folio *folio,
>     >>>          if (vm_flags & VM_LOCKED)
>     >>>                  return FOLIOREF_ACTIVATE;
>     >>>
>     >>> -       /* rmap lock contention: rotate */
>     >>> +       /*
>     >>> +        * There are two cases to consider.
>     >>> +        * 1) Rmap lock contention: rotate.
>     >>> +        * 2) Skip the non-shared anonymous folio mapped solely by
>     >>> +        *    the single exiting process.
>     >>> +        */
>     >>>          if (referenced_ptes == -1)
>     >>>                  return FOLIOREF_KEEP;
>     >>>
>     >>> --
>     >>> 2.39.0
>     >>>
>     >> Thanks
>     >> Barry
>     >
>


