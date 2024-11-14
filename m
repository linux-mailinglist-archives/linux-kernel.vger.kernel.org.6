Return-Path: <linux-kernel+bounces-409877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3379C92CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA09DB29CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507AE19AD70;
	Thu, 14 Nov 2024 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="hfjsOfOK"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB488146013
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614481; cv=fail; b=njn/kleiRJsFps2p4mcByUnln6Kao1KsoeGQbpPbZnlYnzk3PxCdwMV9riqPn8327US0Aioome2z1GO7f9pfml9G2GkwWHtJtmZ9ae8Kwft+/TlCcVwaYpScdp41oFqSRYyBm/u3W/Yd8lM0yhg64P3Abu+1CNgdrtdu1hzXUeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614481; c=relaxed/simple;
	bh=dGyvbyPtZmkGihRcPvQF5ECnw/VkQaB1XL/cxnPLImE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kk3Pkq+0947+lCPuHk4eniJCCzpWQ1/IsCn/jUMYopzcgtp9J0Bdk0gikM/92brMCSYAo8TXeCoVKRbNYIlY4OHaK6FGSBN5Dr/HUtdwTn+1BlN7KWNP0JTPBd7LsEHQlOdauPPHxThnQZFqLoC0/6pD2vS/ny3y8LCl5yuVQg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=hfjsOfOK; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ap6MtFyuVN06/DF+ZAMfjXqeTwn6uz2rL3Mtw3bdVdlWEl9ZsA1sac9CYJKxmLBVPnEdkA2YqqV9Fat7EgBxFXHu2sNQUEQD8u9jxcni5PoP2mZm56C/jadqt27EZkmfykSnD8+Mnho7a0yzjEQnT2MsNpWXUs7PDPURtHH5EK5bB7nmEn9jdVILC0PTAEW1GWoLFQ90vujrmzuBx7jDeHs3ZDcLZtIIVGsptb9tQeRqQ3zR3rSKY7YOvI1HdFeihpKVRB/HOXQYE01wdXFg+c5KdF1NG82IAsmCg67FdRaE2/cWCfP1bUwxfNJD/afigMZHPL1LqtN14jt3mM1aZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLC/IMJetEiMbmvQhV1x+iPD3OJVnB/Za/XggM3wXwg=;
 b=dtKmt1aN80Gfw28PoR1AArxeBw7FMSzePEhvR29NiwCC3d8upSy1ib4vjIbsMt7CPEhkrtSJk0fnUUHbumDml02fW1adz3UM2NoayIjaJuPBP3aJnLy3kc9+udWXKBUZdq0kZiQxv+OFdgY611ePILGTj/Ejtfa5b9WHBozO/A+RQ4Ne91HseIjWdeHWU3/s/MYGUQgDTgE+o0cOCnxiJrtw1mVzB9wNBHec1dWwlpCeJ5pHjFm5/y5phABy6SuovFeJWAf2FZa3t7fxTSJwz/tXEmdn99AtD88aDUjztUV92cov3exSkhik7ZxzDnWnLrkXLabRuOYesAKTJ8jxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLC/IMJetEiMbmvQhV1x+iPD3OJVnB/Za/XggM3wXwg=;
 b=hfjsOfOK+LQg5NpXXMhozUSZ1JylkCoZjwLXhogcU3iceDU4lwEWakGqjHSBUBksaax1Ose4C/X7g/NFCt94gWXoaTwkawX58skmxQps2ITI99eno48y6U7lf+WhzgYw5ngIIxvdL5K2DeiL8KRnBrHY4x3vvysxeh+msg7328McJN8Kyuv4shU/7x4Xh5Oi3LRjOA4ln6Pqfdi1IAFtM+xTJxjJdnn6Bla+3PUL2kdOxnWW0JmLJX7t6pEHzYb879JY4F1aAC3xP1SAHcx/y4j/Jf7U+N5ABRTs9xVAKHb2ag/H0punJClfKTORamLrlhIoiRT7/s+TPm8c++Djcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DB5PR07MB9582.eurprd07.prod.outlook.com (2603:10a6:10:4a8::19)
 by AS8PR07MB9567.eurprd07.prod.outlook.com (2603:10a6:20b:62a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Thu, 14 Nov
 2024 20:01:16 +0000
Received: from DB5PR07MB9582.eurprd07.prod.outlook.com
 ([fe80::a809:c351:afb4:53b]) by DB5PR07MB9582.eurprd07.prod.outlook.com
 ([fe80::a809:c351:afb4:53b%3]) with mapi id 15.20.8114.028; Thu, 14 Nov 2024
 20:01:16 +0000
Date: Thu, 14 Nov 2024 21:01:19 +0100
From: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: x86/amd late microcode thread loading slows down boot
Message-ID: <ZzZXD2tDLuIkBLNg@antipodes>
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
 <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
 <Zy0p5DT0SOWsCDn7@antipodes>
 <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To DB5PR07MB9582.eurprd07.prod.outlook.com
 (2603:10a6:10:4a8::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR07MB9582:EE_|AS8PR07MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: b1bc6920-da50-4f41-884a-08dd04e718f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MURRRjRMbkdVOFdwYkx2aWY3cndyNjZqdGZjb2pic3RCczBzTUlaekhEOXhs?=
 =?utf-8?B?VWcxV2NKaTVRNkNBQllQOUtPMVhCdGRSRVJtREozOG1mZjRXZjlmMUY5TDZp?=
 =?utf-8?B?V0RJRTM4T3p5UjI2WlI1T3dzVHpJY3ZNdk9iZmdWdnJXTi9sSUNhWGU3VUU1?=
 =?utf-8?B?OW1NRkhiUDBaMUY5Zlh2UHBIUWEzYUg5ZWZhb2g3ZjVDaDhXZVNkL2dIRmoy?=
 =?utf-8?B?bDRUYlNkOUZtTDd4S0Y0clNlWHExSkFJRWljam1rMytBa0ZISkQ2OXVkRlpD?=
 =?utf-8?B?SXkwMms0S0FPOVpEVmZNMHREUHhlZEEreG02MTFZZVhTSGo0VjM2YXdPdVZO?=
 =?utf-8?B?OTM4dlpHZnNmV01KT3BDbENmbGlnWFBNWHgxamdRa0IzbGRzeDQxcDlsL0hr?=
 =?utf-8?B?empMTkNYSFFHMmlJbGxzVlR0VC9ucjlnOFBISjJqUGNuTloycC9ZVS9LQXIx?=
 =?utf-8?B?ejYwUzY2dE96aUdZM3R2RG51aUZFVzlXNGhDK2dpTHF2cWRyY0p1aldBNnhW?=
 =?utf-8?B?UzRZU1pSVUI3Qzd1Slc3alRTd2luZXIvVTZkVU9LTXpIV2F5cVY1V1RLRmpt?=
 =?utf-8?B?RGFWckY5SkFVYUhuaVdHb0dNazR2U2lzSklWVmR3Y3Y3azhMVUd1Zi9JcSs2?=
 =?utf-8?B?T1ZJMC9Xa0VCelNLbHUwcE1tRVQzVkFPdjVvTnFobUMyZmY0Z1lFUDc0QUxT?=
 =?utf-8?B?eDkvZ0tsbHcyQ09jb3h0d2dJaldIT1VmK05YOENFQzJ5V2ZXbmtSYXczUUNs?=
 =?utf-8?B?bU5mdkxrRHR6Mk16VmdsUlFSTHRTR0R3RWFnY3lZeVRTSDh0N0d0WEpNd1cy?=
 =?utf-8?B?ZXl4aVNFZ2ZZMkt3QlZHb05xSklGRjRyL3pmWnBRQVJTdlkzeUEwZlEyclhB?=
 =?utf-8?B?ZHMrY05OeGVPMFUwMStLdmxZUzhFYUFVeUZMY1dkaTlxcmRSZUZNOWd5U2dE?=
 =?utf-8?B?UmtlZllFYnlkODNRT3ZuOE9oaU1jVzF6UnpEb3Vnck5ScTZjd3VXL0MwanRL?=
 =?utf-8?B?ck5wRGQ3TkZFUElEWG5VRVBQd2c2NVJ0LzdpOUNUZE9lSjVTNnk1b2N3dmp0?=
 =?utf-8?B?NGIvWEljVC81ZzFlWEZhcWxxd0JlRSttcE4xYnozK0hHUFJIOVh3Y3lIakYr?=
 =?utf-8?B?Znk1b2ovYXI5ZFNPVjBrajd2aXhmZkdHbUpveTJzMTQwdGVKY3EzQXJmUnMr?=
 =?utf-8?B?R0NLMHIxQm5VRFA3T2ZoaG8rVS9YUXB2aURvcWdkUFlIMjVBMFZ0KzByUGJ1?=
 =?utf-8?B?NGV5Rk5MNHJ2cEtLWC9WTlJwRHRqcUxtZ1pQMTByZHZlRTFLdTVwVjZrZ2wz?=
 =?utf-8?B?aSsxZy9TUzNlRU5nbTJIU3VndjZXb2RnbTJheEcxNGhvZG9DalMrSW44OW8w?=
 =?utf-8?B?TkZMVFlhMzdxcjdEWU5YVTM2QU1hUWgzbXNKdUFBQldIOWJOMm5KM1hjQmxR?=
 =?utf-8?B?dzNiYTBnczlkWmFXRG5ydkR4c1NPeDdFTXpwVjlJRTlhZC93bW81ZWFOOFVR?=
 =?utf-8?B?N2V5QzNRdlpFNE0yMGxYcldERG0zeHRkTlhieTN4aEdaWmZhcm1zVGlrb0M3?=
 =?utf-8?B?OW1oUlF2dTlhU0FFRFRHVTMzS3Y5WDk3T2FGM0tkYmVhc2o3T0hxV1JSK2V0?=
 =?utf-8?B?Yko0K2lpbVlJV2RhNUlSVDhWNGVsYWdReEcvTzNPSGo2REZWdjFibDR6T3RN?=
 =?utf-8?B?VzNVUStnYVBYR0hNdW5QdW1RS3BaaUhtejRSSFA0a1NOMit1KzF3eGJubUNO?=
 =?utf-8?Q?FKwVcEBbHG4pXYo2kLr788EWdWUxE/fM/bHBZRF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR07MB9582.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDZyN3p4Y3AyUnBaZTZQY3lwbW4yVTlDamJzTm5BQ293ZUR0cDdBSEtQR05s?=
 =?utf-8?B?MjBVWmZiZW45dmtYV3k0MDJBODRkRzVLc2xwZUpZWXplbGFBQjBoUDBOZVJX?=
 =?utf-8?B?WlN0dGpCTnRXb1VhdjhHOXNWeW5TSFVtU1ZHS3BCWmtQaFpMNHVtTVFPUWYr?=
 =?utf-8?B?SnhjVmNDN3FseWFnWUE1WE1aRnN2dnlaL28zMGxUSWk5Wll3WUNlRkw4d2VJ?=
 =?utf-8?B?TktNZGs3TnJYMHpVK3NUQjBkcE41bVRnWWtnVzl5bTVNK09ydWxKOTNPWFBt?=
 =?utf-8?B?bTYzdzlZM25lZmJsY3pDUTJCVkhGTUpRMGtjOE5kQUZvbzEvcjdubTVGamVL?=
 =?utf-8?B?UkIvSjhKcXg5RmFpREtqQXFLbkdZemFNaVlUSlpvdTdDVkFrRmVUYlgyWTll?=
 =?utf-8?B?TGNTdTJDR2gyMWtnMHREc1p6RDZLZmxxWG5aQjh1K2Npd0gyWGtrdThMNFNE?=
 =?utf-8?B?RGs4Z1haT3N2eWcxTDExdUtud1hacCtCbnpQa1lOQmFqVWluTGVHZWdrNVl3?=
 =?utf-8?B?VjhuekVjVDJ2a0Y5alV5ZG5jOGZFdTNLTzhPbnRqRTRERndaQ3I3MUxxNUxy?=
 =?utf-8?B?aHluOTRjV1V4TGRqTy9ORHhnUS9NMUNmM1RJbXQydlVOdWtkRndmZGp6RHFm?=
 =?utf-8?B?dUxMeW1MeEhXVXlpeWxzaWZCOVRNQ3ZoVjJyUXdBaCsyNFhIUkR3aWVtQk5z?=
 =?utf-8?B?bk1FV3NDSnFERTJGYVNLeThrOGJBZXZlL1RiaXBSbW4yc05jRlQ0M0dsVDdh?=
 =?utf-8?B?d0xVT1M5alpnazBMQkRTbThSL21PNnEyUGNTTW5SeFVmM1F3a09zM2d6blJU?=
 =?utf-8?B?cHRuY0VNR3QvMHlDNDE1Y2ROaEdrU0lkWTBmbER1amhLUWpqOUt6TWhScUd0?=
 =?utf-8?B?ZmxtNnErN2syUkRmZWhWWHNEK2tQNUZ0R3JKaFVYdFUvR2t3UDdYd25HSTRl?=
 =?utf-8?B?L3RDZVlxMFNKYytPNHpVZGxRcnJzdUUzK0xnZlppU1JXMVdVYit5Q1d3QytG?=
 =?utf-8?B?Z2pmNlA1QmtiU3BiKzlOQ1hIcGRNQUUrRndCRWhERE5SbkxiNXJuajYwR3hG?=
 =?utf-8?B?YjZBTWFHODJJVURMTUFLQlZvNEliMk1sSWpHd1FnZ3E3Z0lvc2RDTytnTjBr?=
 =?utf-8?B?T2ZzdFJGVERRZkJDOGNBWWFOWDVwd3JPeENBSWs1MTR3SEFFbzBqR2F6ajVi?=
 =?utf-8?B?MFJmbWx1MHZIblcxbHBkU1IxSUwySW40eS9JMjdrYmpsbTF3VzI5SGpvOERY?=
 =?utf-8?B?V3puVWtVQlhRZlJyVDVobnoxK1RXYUhhbnhlS0twVi9xUkpUUFlKajdLczg2?=
 =?utf-8?B?OGoyUGlodTlnYjIraUVySkVlaXQybW5yL3hsVjBoVWRXcWRmRGNZYUlpOGlz?=
 =?utf-8?B?K1NOeTUwM1JrWTVHcGl3djFoRTFzYXpVeGw1ajR2anhtQXQzVzhUQ1pCK0RK?=
 =?utf-8?B?V1lLTXhidjJIUVhZc0RxemRJeGFndnBCU0gzOWZmRWszbndnSHF1cjhreEFn?=
 =?utf-8?B?TW9EMnQyV0xkWC85aHY4akswYkh5YUl5RWVZbEFWcCtBR2FGTURvYlpYNTg0?=
 =?utf-8?B?M2ZPWnRyTitHVnEwQUFOTGFKdm9ZK0xSV1BISk8zQ28wRElTVlQxUkpHNkRy?=
 =?utf-8?B?NGZXbHNxM0xjWk5BaU9xMlVnYWo4ZmJKdFlPTS9hNGdlVFNNeC9yMm5qdmI4?=
 =?utf-8?B?NmE4NXBqMk5JcnU2TDhNZVUxbkhYOGJaRFNST0lURWEvL3FhS044UFdTUG5N?=
 =?utf-8?B?QlpJRjBHaHUreThBaHB2Y1N1WnRyUnNGZ2dzTlRncFpsK2tURUJGVlU3WTNh?=
 =?utf-8?B?Tm1FUjJUeXFscVNDT0JmVWVLNTdmeFF5Y0hLTjMzRHVTZkVndnZlYWJLTUpS?=
 =?utf-8?B?M2ErRHd0Ym4xekhpTlVuZFpxNWZxSmx1N2dIVngrNkhxZGlqN0VENzNNdXNo?=
 =?utf-8?B?Y01hOE9rWTIwYzFqN0VZRVJ3Zno3Q3lPNHVNOUM0eHBldDVsdU5DVnBQcmFt?=
 =?utf-8?B?eTVwWUpEZ3plQkdDaTZlb1BUUDFMQmR3M2pQYkV0M2Z1Vy9yRXIvcGVhSmo3?=
 =?utf-8?B?UHlMRkVMRzljWm4wNVdEUkJDa21EYzEyL0NxV1JXNnZjaDN0SVBCZDhoa0pM?=
 =?utf-8?B?RWxwakJYY3NOdEpQTmM0bzVLZzlLWExZTW5CVjhhSEhwQ0lldHBOTmkrbElJ?=
 =?utf-8?Q?ig13eohBMJfV8+yEkZrCQYw=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bc6920-da50-4f41-884a-08dd04e718f3
X-MS-Exchange-CrossTenant-AuthSource: DB5PR07MB9582.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 20:01:16.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MR1ByHyTlX5cScoIkTboEtxOQhLZ+p0BxKi263LfCid6cr6FDKygTDb9++fsPtAf36tYcr+yJaH4O6qyPKnskFV/KFF9/BU/etPn+0LTMj12Ds/S0C2wffqiyT4JqhvM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9567

On Thu, Nov 14, 2024 at 10:56:39AM +0100, Borislav Petkov wrote:
> 
> On Thu, Nov 07, 2024 at 09:58:12PM +0100, Thomas De Schampheleire wrote:
> > Boris, perhaps you can propose a more fine-tuned flushing? I'd be happy to try
> > that.
> 
> Let's see if that does the deal too.

Thanks, I tested your patch (ported to 6.6.x) and confirm it also fixes the
issue.
This test of course does not invalidate any of the comments from Andrew Cooper.

Best regards,
Thomas

