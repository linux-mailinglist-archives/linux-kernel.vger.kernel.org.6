Return-Path: <linux-kernel+bounces-367888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EA09A0801
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765AF1F21AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE111207210;
	Wed, 16 Oct 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TKCBryhC"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740081CACDB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076741; cv=fail; b=n3Ip6y++kvFceCYCXZFkP32oeZj7f/3fQxZfb6fNI7snWgNRRY8X0UPTVFKR6FrATl3NYXPBwAx679cXWUM/gcNq8+H9uL5zszX5bnCkip8vtuzXLDqg5T4AqTzJaQ5H26tqbx+bCOs4hlVAXS/90aQrMSP5g28Z3Rss2QV+Vh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076741; c=relaxed/simple;
	bh=yEV3O+VS9J0CiqcsFOJ8K/3OJ44RejilcxxvUyte5D8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iTDvKvWxbPK1gFATBaxO+AFfRmdFlMOmo3DGDybNGCza7kzJldHUuVQBF2IvSo4jiBoX2NgemdyQtWcjti8IrrhBkRouYQX9QMWLz//k9TgizNXAt/a43DriMSXfodsL1GDrvtrEjnHgXfCrzkMvOsJ3ldtpOB3oSQIfhOLGRCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TKCBryhC; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrCIV1QkUgmvX8A0nLYKB3g17PMPjlkX3pCCFxWScWFnMJ2FqSHx+jr8pJ2Jrbw8i3LRHN+GFaOw6Yw6bYCIKlizbcL6rYVtW6107GUlqbuyqYCo1zzBljkKzqOt43/aBjDxcny7X4qA4vLAH6XpTiqArRKTVUY+I+LU4C8qS74FGZaOKDALXb84kRsLWxqJzZ/uBlUKffd5oOWAmC2wtiWe7ws4nSeCKJc+o3XYUcj1aii0Yyo0dZgWfzHdIzJVeIueiHpqaE//O6HcvvYYUzvvALpghJm3PiFo440bPg6TZXieYBeMh9MJQ7hIUUWQ3h9PBVzfDA6C2UhSR4QOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LXPQA9s0AtmU9zqT5/TSkarMKbjVwZowpKMVOkKSn0=;
 b=ssHiWobR4RznIkKj0A40nBFQ/2c1klLhAyycGuH1akgu6jchAPUUG0wlqyTkEaNpRHpjVqD/AeFEXof9K2NjEsKz3hAPZscnSi4GB9SPRAfaZCezhiZfNkUFiu8lqfz2savXnZHYQ5XvJH4/z5y1nodV+uuzf7B9xhvHSuFPHEvWIkFQd/MOsOU7H8jf7rE3XW4gY9Wje8hyCuo1K8pXaFi7pf9cmOnVdFVqaEM3wsTBqRT0bpFne+asU81Mx5rstL1fEKoXIHXWUWMAaaqR08d9JcPpUwKS1DQrhlYhtioobgoy9iFU94we/LF/0LClssVncsOOiK1q/3F1ZrJjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LXPQA9s0AtmU9zqT5/TSkarMKbjVwZowpKMVOkKSn0=;
 b=TKCBryhCY/2yx9py2oZvMjgQwnNmmj6Eq+OqEky8VRTjMHSoH5xKwkb2wenFdDjXzN7L3rA6yo04Np0yd9TBEiERkyiwc5bO5xentlRY1XvPI9Lmm6fuPAGWV6s3Otg32dgG0jYzipPZ6P2WxNRyd6gkYW8EUwAwqYVJKpTBE/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17; Wed, 16 Oct 2024 11:05:37 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 11:05:36 +0000
Message-ID: <a29c83a2-3450-b459-880e-a0737825f381@amd.com>
Date: Wed, 16 Oct 2024 16:35:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 4/8] x86/sev: Move the SNP probe routine out of the way
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <e5f2f8249a6fefefdf4930ad21c48a9a768f50af.1727709735.git.thomas.lendacky@amd.com>
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <e5f2f8249a6fefefdf4930ad21c48a9a768f50af.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::17) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4cb1d2-d802-400e-cf7f-08dcedd2766c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amtoS01IK2ZPOE12ZEhVbExsVmtpeU80OElicXNnTVd2QStyK3F5UjViTU95?=
 =?utf-8?B?M2JreGF4b1BPczhtZlg4NVdETitKQ1JKajZ5SGxhM3NzNDFrTDlGSjdmM3ZE?=
 =?utf-8?B?SU55eTlSa2pzWWQ1R3FFT1VucnlDczRLcy95V3lhWDkzRTJwSlN4Vmc1Q29H?=
 =?utf-8?B?bzk1ZkFIQk9wVGVQWUs5aWFXd2xPVlUzVkZhQjFvRExPUEtjZVQ2VXJYamt0?=
 =?utf-8?B?Vmt4T2luTTU3dzVYQnBnb2VteERhSE1rUFBFb1FoUHE5eitLOEJjRWRCTHlH?=
 =?utf-8?B?NGNkNjdCUFkzSmRPNnEwM3FjTHNXY1dzRlljMmVtMm13b1BHcXZSb3JyTXN2?=
 =?utf-8?B?eU9tSHRkR09oNFJGTHcrVm1CRVJrOU94QWRsWEV5YTlmYTFuWHZHYWg1MFhr?=
 =?utf-8?B?ek53WVNWZzJkZVV1eGlYb1AvbXFkWVhEcXdDcEljQXZ2VHZlVzFReC9IZzFk?=
 =?utf-8?B?QXR6bzQrMFJvZ0YwY0lMMkxLeXR5L1loSVZnYms0aWh6Y2FEcGtwM0loYjFG?=
 =?utf-8?B?dHA2L2xUK1dUc1ZuRkZ4a0E3a29GbFVYMEVWZ09yLzY2WHhvMEd4eTkyVk95?=
 =?utf-8?B?ZDNvZnFvS2xydjJyQ1cwWWlndFFIeW5hRDEvNTFyRk1ZTHpMNWhlN204dGZ1?=
 =?utf-8?B?UG4yeWpiTm81YnQ0RGdOZWFoa3BYdTVxZzdGekdzVFpnQlpidmViNTEyYWRp?=
 =?utf-8?B?dHZkOU91KzVPaUFSSFZsS1A0WHVvbXM1dkhXMjlpV25pSVV2bWxiaVJCRlhZ?=
 =?utf-8?B?YmJ2TGUzMlZqYkQzRGtRLzFUUU02WWREbGtVZUlGSEYrdG55alZMKys3Zm0w?=
 =?utf-8?B?d1JwTUozRlFBZktNU1FFanhDNmg5MEwxWndlN0kxN2JSSFFmWUdhQ0w1WHMr?=
 =?utf-8?B?K3Q1Vmpwb0J3K2RISStXeFhiNE1UdVYvalVHc2lqN2tEdlFFR1d4QmhHdksv?=
 =?utf-8?B?SW05RkhxR2hialRtK2hrZ0srNjlaRGFKcU80azNXZlVQeExmeTM0VmdQWlZt?=
 =?utf-8?B?NUloRHRISEZ0Rk1yVThudnFOZU9zUy9aczVoYVd2b0lQQkpVbmwwWWE4SVZQ?=
 =?utf-8?B?Y1RNdWR0bHUwTWlkeW9Jc0FWdm9vVytMdVVaRlFNdDNGb083TkI2VmVtZ0dP?=
 =?utf-8?B?bzByWnpqSjdpcHNrcGpjTDdKaGdQVlZ6ZForSHpxWndYTVVRMDJQOUVPV0Iw?=
 =?utf-8?B?cEE1S3JtMmVWSTU0RlNyTWdjbDAzTlRDTW91bGFUVklRZURpRmk4bUkwTGVS?=
 =?utf-8?B?c2orN1RWblpYZ2tnSXBZY0o1SkkvTXUxbGlidVdXcEM4MDlBQVRpRVJ4TTZP?=
 =?utf-8?B?SGdNSndYVnVRSWdNODZhSVp4K1NLZG1NbmJPQ1ArbDZhOCtQSndaa1plSWF0?=
 =?utf-8?B?MjFyY3BwczFGMGJnNzI2QWoyYlRrLy9yV09BWkttRHNPSG5LZmxGQjIrR1Bo?=
 =?utf-8?B?YVVCZUlIWWtLWFdvZ2tGeEJoNFBrcjdNTkEvUjJRT1laWEVoajhlV0RieG12?=
 =?utf-8?B?cTVZeHdqOVVrTW9EMEUrdjU2VE8vdHBaTFpXaFZ3N2I4dUZHQk5Fc3dvSG8w?=
 =?utf-8?B?VHRSOUdoOCtaY25nS0Q0K2s2V1o1ckYrVUpxU3ZKRmZVWjF5YTJTaXNtNmFV?=
 =?utf-8?B?NXZHTjdQWE4vaXZPazNCdW9UODJCOG9yNGhhV1A1dWdoTWE4VTdjMStneEVu?=
 =?utf-8?B?aGxlSzlaRFc4VmRaUENnc2dNZngweG5XUUVKVFphdGg2ckFMQktSL0pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkQ2d3N4VUNEeUYyS1VTeHI4S29ZQ0d5V0VIeGpGa1FXZy94dVBrYzVXSVRQ?=
 =?utf-8?B?RUdtUUVhalhVaTRHeTMyMklIOW5tOXppU0E5Q3FwbVJzWWpWQUR3ZVc4ZWsy?=
 =?utf-8?B?V2pvc20zWThidDZ5QnJIVm1paExVa3Q5endZUXhWU1VTcW03S0RybTRvTUZE?=
 =?utf-8?B?OVJSZDFWTmFjeWVnVGNNbVd6SUxubFpkdUwrVWZOUmZwQ3JZM2dSMmJ1YWVY?=
 =?utf-8?B?cnl6aXdFRnl2ODJsbjBNODNFckQ0TkVTTGN1YWtMaHFYZ21iMkNWT2lmd1hV?=
 =?utf-8?B?aFpMaFlZTm9sMmhxVjJIN29GRUw1Q1JpTU1hY0dseG5JQnJ5YTZiL1VnWUNI?=
 =?utf-8?B?Zmd1cFg0VDNUTTVGaVpUZjRnTk42ZFk0RzRUV0gyVU4rQlhxRGluOVBqL2tp?=
 =?utf-8?B?SW5UMmpPejJmOGhtSnVWNERFUjVzYTlmdE4vYlNJTEc1K0hmS1ViOG1sOUZa?=
 =?utf-8?B?eDhkZyswU0J5WWhoeGlNQUxVd01lcHI3ZUdEcm5lRVg3OE9RMHdrdlpSd0xZ?=
 =?utf-8?B?VnMwZTJqSWRBUW5sNlRoZXo0YTA5TUtvZ1hwRXd3MVpjb2dVVFBmK0NrR3A5?=
 =?utf-8?B?REM4VjU5dzBsQjJ3ajREZ3B6U0ZmcTg0eHpGZFVpSFUzR2RvOHpqZ0ZhN2Ja?=
 =?utf-8?B?djVjOHpHL256OS9lbjNWR0hCOFduZXBJaFhYak5aMUZWcDFsZVhnNVJHUVNE?=
 =?utf-8?B?eHRWcDJ2L1JoMGFlajRTcHBnWXVhVjZ5ZkxaUFJkMjdhdDBRVE5FTUNHM0FU?=
 =?utf-8?B?ejBNUjhaa3pqbXIyTWs4YVJlUS83UHp5RHorL0YxZk1XUFNwaGhKNWZSejBF?=
 =?utf-8?B?RFZrYloxUWhOV0JkdGtFNHZBMnpUTkRBOFVuaWp3c0hlT3pqVFQ5TE9PVlE2?=
 =?utf-8?B?b0YzWHNIZEhLVy9ZVjI2c0dZbko5MHFldmFFTG1zaVRhRUp5N25IbGxlQkNB?=
 =?utf-8?B?eVNmYXhOUmVURzFHc3luMHJCSUpyQUZGTmJOTFh6QTl3RGRQbEhSZWdSbGZL?=
 =?utf-8?B?c0lpZVNJazdhQlAxOU9SZzBpaGs0Rk9Ga3ZkU29WR2FjbEtwelV5aVo4UERi?=
 =?utf-8?B?c2JTaFQ3VUhHSlZVNzJuUG9aZUVNaFIzRDNjaGRrS0hTMmY1MkhYU3pIREhD?=
 =?utf-8?B?YXpRd1lhdjBHZXI4T0RjVk5iWTRsNGgwajlWUCtJclp5U0JYa3JJMzMrTjFJ?=
 =?utf-8?B?TW9PZ3Uzc3gwMHQxSnArWTJZQ2ZlaDdTQjlRd1p6Mld6OFVMUHpYT3NYRFB1?=
 =?utf-8?B?ekJvbVRDb0FDakZ6RWJ5QTdJQlArcjEydVdjUGFxcERXcmV5eTdsUmp2Z1V1?=
 =?utf-8?B?bVFjbDEwUFlvSmFlYmM3cGRyMGNpbE8zNUtiMmxYa2h2bklkNXZZQVoyb21i?=
 =?utf-8?B?YmNrSmJkOVAzejF2dC93akxoakNGbXFBeW1ZV2plRGNHSG0wcXFvSjV6cjBh?=
 =?utf-8?B?ZWZVWm1zejBiSGhUN1VoUEp5Smo1aTdTTkJRb3NaQWd3VERvM3FidmxOY002?=
 =?utf-8?B?SEhwaTB5RG1Rc0hCSXVhVStiL3VYSGZDMUk4bFhRUnNsS0x3S3BVU29tcG13?=
 =?utf-8?B?ejFJMXdtSDd3OTAyYis3VDI1U1VWU2FmSEdKWHJFdTJ6U1FrSWQ2UnAyQUpI?=
 =?utf-8?B?aldvcjgrQTNzVUVqb3AyUTlySmp6b3dHUUs4QlExT2dYakJhcGJ6ZnR2Q21U?=
 =?utf-8?B?V3BNd3NyQlhrczVZU3ZQM3BqdXBOOFFQOEJ0aFVMLzBFWXJzeWtGOEQ5UHZh?=
 =?utf-8?B?ZVIvTWpMWGI4MW13djhoYzRMM0J2WlIwaHd3VUFpWmFFNG1hWGNpMStaaWFh?=
 =?utf-8?B?QlhLYzZCR1JDZXhxWEFNSy94NUtFL0FxeEdiR2NQeHVFdlBadGZRMDhSME5a?=
 =?utf-8?B?Mm52T3lZdWZsQnNuQVVDbHIxTFFNUkEva2x4YzhVNm85UkFnVGVrQWpEQjN4?=
 =?utf-8?B?WVRHMHJnU2w5MEFrQU9aaWRwVmdyRjZIeXdmQksrcEQzYmFmUGs5MlVGcVBm?=
 =?utf-8?B?eSt6NWlpQk4rOEoyOU5Vb0oxYVRzeDNCY3RCZWVXa09nQnF2NU5Nakt6elBU?=
 =?utf-8?B?WkxNNHlMTEUzbGlkV3ZUNTVCWm9Xbk9VUENqUi9GRzJ4WEYzcXIrckpQL0U1?=
 =?utf-8?Q?6AON6BC1X0dTK0wCdMYjzD3va?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4cb1d2-d802-400e-cf7f-08dcedd2766c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 11:05:36.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQiV6BoIL2ugoIcikUkY6wi8sOGj3J02wu8gyN/0l2Za+hTiZlKwKGDSqNwSme/LyvXsHUHJp4Em+YUDsX6nFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227

On 9/30/2024 8:52 PM, Tom Lendacky wrote:
> To make patch review easier for the segmented RMP support, move the SNP
> probe function out from in between the initialization-related routines.
> 
> No functional change.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

> ---
>  arch/x86/virt/svm/sev.c | 60 ++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 73d4f422829a..31d1510ae119 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -132,36 +132,6 @@ static __init void snp_enable(void *arg)
>  	__snp_enable(smp_processor_id());
>  }
>  
> -#define RMP_ADDR_MASK GENMASK_ULL(51, 13)
> -
> -bool snp_probe_rmptable_info(void)
> -{
> -	u64 rmp_sz, rmp_base, rmp_end;
> -
> -	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
> -	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
> -
> -	if (!(rmp_base & RMP_ADDR_MASK) || !(rmp_end & RMP_ADDR_MASK)) {
> -		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
> -		return false;
> -	}
> -
> -	if (rmp_base > rmp_end) {
> -		pr_err("RMP configuration not valid: base=%#llx, end=%#llx\n", rmp_base, rmp_end);
> -		return false;
> -	}
> -
> -	rmp_sz = rmp_end - rmp_base + 1;
> -
> -	probed_rmp_base = rmp_base;
> -	probed_rmp_size = rmp_sz;
> -
> -	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
> -		rmp_base, rmp_end);
> -
> -	return true;
> -}
> -
>  static void __init __snp_fixup_e820_tables(u64 pa)
>  {
>  	if (IS_ALIGNED(pa, PMD_SIZE))
> @@ -286,6 +256,36 @@ static int __init snp_rmptable_init(void)
>   */
>  device_initcall(snp_rmptable_init);
>  
> +#define RMP_ADDR_MASK GENMASK_ULL(51, 13)
> +
> +bool snp_probe_rmptable_info(void)
> +{
> +	u64 rmp_sz, rmp_base, rmp_end;
> +
> +	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
> +	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
> +
> +	if (!(rmp_base & RMP_ADDR_MASK) || !(rmp_end & RMP_ADDR_MASK)) {
> +		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
> +		return false;
> +	}
> +
> +	if (rmp_base > rmp_end) {
> +		pr_err("RMP configuration not valid: base=%#llx, end=%#llx\n", rmp_base, rmp_end);
> +		return false;
> +	}
> +
> +	rmp_sz = rmp_end - rmp_base + 1;
> +
> +	probed_rmp_base = rmp_base;
> +	probed_rmp_size = rmp_sz;
> +
> +	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
> +		rmp_base, rmp_end);
> +
> +	return true;
> +}
> +
>  static struct rmpentry_raw *__get_rmpentry(unsigned long pfn)
>  {
>  	if (!rmptable)


