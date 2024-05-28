Return-Path: <linux-kernel+bounces-193108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE658D26F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4381C26227
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABDE17B439;
	Tue, 28 May 2024 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pz1oHzUp"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D617E8EB;
	Tue, 28 May 2024 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716931008; cv=fail; b=pgfX1oorpW19M4x+E7YSaau2RWMM05+BfnrKukoLlhOijqQTwbtmATh2jNinLUF+JbKQZzvPvvRfJg67UHztTEx+5PgP90vmiOxSrxaVjkExG44J0Df4VeMlVB1HhMIJ1d4H+4x2lSKWP+qxgg1rb8tz1nIjsv09vRzk8ilHPDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716931008; c=relaxed/simple;
	bh=aOEWcXlSezvzfCYejdzaENt8I/apx9CfhHI/J/L9Mfs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fu8vXBxIjtg5sgFB/QxvOiHtraaanG1Glpk5A6GR2dDJacIFOY2T9iceGWDzFdcUaJkYW07v8LhqqZWqw+rq6VZ48tAAjn3xrU2RmtA/kyVgWZXr82lh/z72F9V8ESRzPMN4o7nOxyJ9SklcUdhCW4xDYtb4QZBv31sI4gxD/Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pz1oHzUp; arc=fail smtp.client-ip=40.107.96.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4ILTch9lSXaQ6Y3foVJttPgmShWq9PwXqssvAgmk2f0i9eKOVFHGjOXQXFC6PXaWLMqjbHkh60IFX+8jffrjQfLi4x5zMi2BjwT2DnI5w4tkQ5drukc75xcU0Nj38Kbl1C5h63MQV93FS8zCVRj9m8CXoo8seVQrIwE5RrbmiL+dUDtpnNJL3WI8rSiYznNpbOq3CkxDY9d13SqvspI5aLi7g/vWIoEtLouiCichgVIsNC9PJVubiLzrZSvSe+6wirgxDEwScRfo2Vc8wsKHqUdtthHVaT9P9BlDjAhkbu1FImZe9bLWiEOsMJEyIYeykcaW1fkVSCyrdtClUr5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwhP4XO3301mSSlfQFs8swd8pwRibHMUYXzYsLmDcZ8=;
 b=ZcYQe+/McsIAQkp5GFxWUbBsGFLPRNrU8xzkyveTKZuUU22RmgtNKnLKWFiKv7xgzy14JOtskVV17wlfRO3B7s5jTnpyrQgPOBHUr38oFZNs64UW/tsV5pMNLxTqUpqoNAMCiqjgD3Ij0XbwkY/Oz5zjNM6XRCGNEp6MbADNkQvikKOs17ig6q49cWsGfVIpfSXzr8pIIYTRMI+sNYRy5r1KAXNyV6kiGbGebGuqFlTSqRnYdkbzTiJg3OILWUFiiIMfr4LVDulkuslt7EJRWeumftGGfsMVlRPCXGpeZ6WuhdqpQjzsw2QKGXpsNwhbsOmD+tJwAvfPIxU7MLc4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwhP4XO3301mSSlfQFs8swd8pwRibHMUYXzYsLmDcZ8=;
 b=Pz1oHzUpuMzo1PVsP5YdUKlqNNpdGAtHma7+6oN8XOLmiTy0FbUuGWAXrENAtemqsLuXuSZibFHx4/63JAt2amUqMiJlRC0yPpRWdmLYee4xmYnqxTOWEr5agL3xxmsGaliJofDpzjCqwBLi5VTdyRd71RXAhHl5EDNY2Ba2Kw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31; Tue, 28 May
 2024 21:16:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 21:16:44 +0000
Message-ID: <371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com>
Date: Tue, 28 May 2024 16:16:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] platform/x86: asus-wmi: add apu_mem setting
To: Luke Jones <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, richard@hughsie.com
References: <20240528013626.14066-1-luke@ljones.dev>
 <20240528013626.14066-9-luke@ljones.dev>
 <6f4bc109-00d0-47b0-a581-b96a6152545c@amd.com>
 <4d6b9171-7248-4937-87de-7e921ed8e507@app.fastmail.com>
 <5f4799b1-0606-46a9-a347-5a03738db341@amd.com>
 <ac597520-fb5b-40e5-ae1f-de825450d2db@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ac597520-fb5b-40e5-ae1f-de825450d2db@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:806:120::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a304265-c425-40a5-a739-08dc7f5b79c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1dUOGplUSs1dSttU012VzJubjJNQmFMN3oyQVpWa1BONXpLREFqSC9vS0Ft?=
 =?utf-8?B?NFNoV2RWZEdIOUxxeDFGSzBoaUJ6QjIwWlRCMlJDWjl4QjRwSXM0dk1FWklL?=
 =?utf-8?B?MnhQQU1TUHd2M3Vkb094cWR6eGk0a080ckl4S1Fyd2xDMENYaEF6M3NrOWFs?=
 =?utf-8?B?OUlqZ1BQNW9GVG9sZ2VCeU1ud3gwTjQwbmpzYkdzdlBEbmxyRUFqU0M1cWRM?=
 =?utf-8?B?WjNpWWRoakNocGkycUtLaFdNOHJKbUxqVUdEQ2pGaFc2UEwzK2UrblpBUXM3?=
 =?utf-8?B?N2ZheEl3WXhGUHBOa2xGYlZzQTkvR2hjWldENHU2djk5R1VYb01BdjRQcXNL?=
 =?utf-8?B?RVQ3UUZDYUk1MGFzRXNZQ2VrTlg5Qk02WVZXYndMWDdDT0tiZ0prZWhtbmVq?=
 =?utf-8?B?bllLQ0tTVWR5M2dvOXJjNHRpbUFmcnpBWU5yNzZWQVdWRURicGYveHQ0dVpn?=
 =?utf-8?B?T29iTFJNSW55MEhBQktyZ0F6ek1nelFmYWNrUDgwcmFwNGFMUW41RXdjVDgz?=
 =?utf-8?B?TW85Y2xUWmZSMXRpUUlWckpiTEJkNGJkekprVEpPeEw1L2xrcFcySmhkaDFS?=
 =?utf-8?B?cmcxcUFJRkZyV29RZ25wMTdRY2hXQlh2V0Y0SGdIV2QyYlpWSWg5dXhzM2lz?=
 =?utf-8?B?d2ZUdlA5N04vWWdBcWFJZjloSjFPaStObmh6czRqUThVbElxb1h5cHc4NllE?=
 =?utf-8?B?TmZOczVNaDhKWWpXVjBQNHQ4TTJ6T2pPZnRZdHNpSlNtNDREU2FocVdLYURM?=
 =?utf-8?B?ekx2SEdmT2h3bkJEQWtLc1IvSFQwT2h1VGZZbHNsM0ltRHpoeTZEbEVFYW4r?=
 =?utf-8?B?U0lZYzM0blJBZElKNWR4UGd1NUxCSVJLOVR5R0ZhZmxxQVowQU9vanJYTTds?=
 =?utf-8?B?L1dta3ZxZlVwTkZNNzFKbGlhVXMyU2I0cUc1clNQcUtCNlJyVlJRLzZsbzY0?=
 =?utf-8?B?dlBzUEJGTklUMlBIN1BTV1JGZ1QxeENKMExqMFNQenQySUUySVFROTl2NlVw?=
 =?utf-8?B?aUxGZG9LTFM0Q1ZsdmE1MkR3dVdzL0pGaXNZUTdOOUxkYzJjMENrV3FBaXlE?=
 =?utf-8?B?K0ZJT0lpdE0xdlQyYkZvbytVU0l1b0Z0VE1MaDR5bTh5cFk2ZEJUU2cxVjNZ?=
 =?utf-8?B?WVZpRnVvUExGN2RRZWFJNDRvOFFRSkY1bVVoR1JndUUvYm9sRURCaUMveS93?=
 =?utf-8?B?aFd5WjlKWUxYYm5CY1hNWURaeDdQV0lUMDhZNjc5dkU1MjY5b2ZhR1pGWVpv?=
 =?utf-8?B?YVVZZ2N5bzMrL0Zic3NtZGtyazFSYU5jUnQzdldNYWtWekt3Wkd6YUFETzM1?=
 =?utf-8?B?akduYWFVc0MwNzl6c3VqSXh5SUI5azNzMXV2aTN5M1Q0ZkkxT1BUUkJ2U2Yy?=
 =?utf-8?B?WkZkVUF0TEt3cm5lbHlWL0ljL21SWG8wVEtlTHNtaGErQVNmNUk3R0FRdTRH?=
 =?utf-8?B?SjZnYkVlMXd0V1RnbWpDZlh1M3JkN3hLeGRWN1FmZ2dZM3pmUmlDUnZwMURS?=
 =?utf-8?B?Q1NmZzBPbmEvUlNJQy8vT2xlZUorS1BraFJOSXdGWFdUOWpwVnZUMGVxLzVW?=
 =?utf-8?B?TU9PRlg3R3R2OUN5YnpFWW9NeU43WGZOV2ZIbndtUGVEeDlIdHBQN0hNNzRM?=
 =?utf-8?Q?CfvncZ+iPwAij9vQV8myZMGzTuNL7llUtUDNKpbfJb9o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ny9nZkdYZEFqMEtIaExtS2FFeW5lcUtJN09FZEVpTUZzSkRrRVRPNjc5VzVK?=
 =?utf-8?B?THlValI3LzZmQ2Z5Wm5YZHFBQVdOK0s4Z2hlQ1VDWVB0Sld5aWUwZ3NMRUFB?=
 =?utf-8?B?VnBvaTZiZUxWbUh6S0Rpbk5MbThXYlJWUHVhRXRPL3dhNU85OGtmSnl1MzBr?=
 =?utf-8?B?N2xFd0hoQTJ5UFBnV2laa1J0WWszdXovbytNREd3Tk4weml2NXg5a1M0M3Ny?=
 =?utf-8?B?S2FJeXI2cVhXMGZmejBDbDdORXFzNEM5TUZSYzdVYlZMcE40YzZIOGlsay95?=
 =?utf-8?B?S290WDJaejVuYjhCL282WjBUWUxvM0RBeFhzcWRxa0drZkVzZGFXYUhPMjRy?=
 =?utf-8?B?YTZXRjFjRlFiUzRRSWt1TzREaXV5MXRXNHRpRzJhbHV3ZDlSQStiQXphQVc1?=
 =?utf-8?B?aFNQczlTK3VkYlBxR1NaL1RpbmVrNmU0d0NGSnpBNldrVlhLQ0lFRml5SUxi?=
 =?utf-8?B?OTYvNllUUFFxRk14VDJYNThlaFRlQkx5K245TlU3OVNML1hhWjlwdmpXRUNE?=
 =?utf-8?B?VkltYTFiVm1ZUnllMFlxZk1OZnFqMXREOXFLOUNHTENSWFQ0ZldwcG9uRDlZ?=
 =?utf-8?B?OHNYWTIzRC9sKzFyWkFyZGlJWkl4eXVya243WUI1VXVVUkF6bFQ3VktsVWoy?=
 =?utf-8?B?M0hIUStRaERRbmFXL2tEbnIvMmhqYUtOVUpVT3kyUHRXM2VlMmZrMG5WYXJX?=
 =?utf-8?B?UnRGT3I5a0xUUnhIV2FjNmFVNTRTTGVFN28ySXdJU2xEQzVWemVxL1d0ZGl6?=
 =?utf-8?B?VDc5b3NSRk04QXZUUnhidEVpQWJNRVM3d0pGUzNkZ0hrUzlxSU5CMTdka0V4?=
 =?utf-8?B?SGFrYkh3TlZhYStLa29FMmdKQnl0eUg4RDBrMHJEcmhGTEdZMGhlcmpXS2Jy?=
 =?utf-8?B?SjBwd1lIOFlsNUhlS3p3RithVkQ1YmJ5eENjQ09jUUp1ZGR3ZXhkeVdoQjR6?=
 =?utf-8?B?RkZkWnoyOTMrRHVaYUxpUHFIZVF6TDBlallMTlVLL3p2OE53SXB6TmRCZmpn?=
 =?utf-8?B?NGxyalI2QnpBUlhuYkNkR0hCU2czK3psaFN6MVBNaUZzSVpIb1BIdFg5MFRh?=
 =?utf-8?B?bjM1eHlyOWNDRStDeXV4YU9URThFeFRNcjdPalZ3SzhSbytaaFRRUU9PZlhp?=
 =?utf-8?B?N2RFWHhRUVNDcjlvSVg1b2VNQUVzZU9wNndGUGJWYlhNc2d0SG9CQnRka09F?=
 =?utf-8?B?WElvQ1BxZ1NraFpDYXZOeHlqV1RLT2hRMmVqZG9iYzRrcWppdWRxNEJ1RFlK?=
 =?utf-8?B?R0RyS0M4UVVPTWMvbVpjTW9GZ2J4TWo3NEViZmNQVFp1ODhHN0NGWXgzUTIv?=
 =?utf-8?B?aXZaTUtnL3JqTDFHUUtuOGtSMDVvZXRMQkQ0Sjh6NnZtR1plUGhGTWZRaFRy?=
 =?utf-8?B?Z0o1Qkl3bmI5d1RPT0xIYnA5NEdKYVE0MGIzWW4rRGRheXBUOHJ0REdKRjMz?=
 =?utf-8?B?SU9vMENzNU1zc2JGdTJUVWExV0lQYm91cnRZMEdvbVROMldCOWVnRGFMY1FK?=
 =?utf-8?B?dXRHQkUyY3dpN3k4dWVEaU1JVG5qclprc04yUUROSTVzNTJqWVJ4cHA4TzQv?=
 =?utf-8?B?cGRLM3BYRkcxWHJSQVFoMEFpWjlzZmhOTktmMUYreXREU3M4TDVidkQwL1dj?=
 =?utf-8?B?azV6S1p0cUpzeU1yYVRPTmY4bC83SnE0blpUUzJpYTBoMTUrbStkUkZwVUZQ?=
 =?utf-8?B?cHJHWFVBYWFYZldZQ1hDUEFrbnFBbjBkNU9Pd2RsSkppbXVOcWdaMTFod2RY?=
 =?utf-8?B?WW5JUjVPSm5NSE50WjlLOFB2TEtFVGZuWFZjMWRRUTZmaG5QSGIxR21jcnZz?=
 =?utf-8?B?SUtPc3pySDIyMVJlN0FWZk9sL1hXa2J1TE5rbkwzbjl4YjV6eHQ2RGgvWEJm?=
 =?utf-8?B?Rm1aL3kyQitEeVpXV0JIRm5tZW5mQVhXUFh6Wk40dmFWYjY1RFR1MVhkT0NL?=
 =?utf-8?B?Z3lZbFhiMVJHaTQzZ3JIbHhQcWFIT2hha2Q3TlJ3djFyWjdwZFhXU3B3WTJU?=
 =?utf-8?B?OHgyc3pzenF1R3p0K2J0U21HR3lFR3ppcWRNazcySkU4dHNRVUxocjlzS0hU?=
 =?utf-8?B?YmNsUzNxTnpVZU5Gd0lDVm1MeHBQRk9lRzNTRlpFRlBlL2VEZWpoZHo0SmNp?=
 =?utf-8?Q?a73RxHWPCH90MUDQ0OfTBDz4K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a304265-c425-40a5-a739-08dc7f5b79c6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 21:16:44.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0yHbGg5zRv8QKafmwnq0op1awaIUpzWV5kvTV8z2RxUbq8GM8xs/V+ajY3vG0/lK4dn5doEEIRwT73U5OhJgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727

>> For any "new" attributes it's better to put them in that API than code
>> duplication of the BIOS attributes API as well as a random sysfs file
>> API that you can never discard.
> 
> Do you mean the firmware_attributes API? If so, I'm not opposed to adding all the existing ROG attributes to it also.
> 
> If I'm understanding the docs correctly, for example this apu_mem attr would then become:
> - /sys/class/firmware-attributes/asus-bios/attributes/apu_mem/type
> - /sys/class/firmware-attributes/*/attributes/apu_mem/current_value
> - /sys/class/firmware-attributes/*/attributes/apu_mem/default_value
> - /sys/class/firmware-attributes/*/attributes/apu_mem/display_name
> - /sys/class/firmware-attributes/*/attributes/apu_mem/possible_values
> - ..etc
> 
> That's absolutely much better than what I've been doing and I wish I'd known about it sooner.

Yup!  And even better "fwupdmgr get-bios-setting" and "fwupdmgr 
set-bios-setting" [1] will work with bash completion too.

If you want to build a GUI around it, it could use the fwupd dbus 
interface for getting those settings and manipulating them.  The dbus 
interface policy is protected by PK.

> 
> So if I go ahead and convert all the new attr to this are there any issues with also converting much of the previous attr? And I'm aware of "don't break userspace" so really I'm a bit unsure how best to manage that (would a new module be better here also? "asus-bios.c" perhaps).
> 
> What I don't want is a split between platform and firmware_attributes.
> 

My personal thought is add everything to the new API and then hide the 
"old" interface behind some boolean Kconfig option that defaults to 
disabled.  If someone enables it then when it's "used" (IE read from / 
written to) then do something like a pr_warn_once() that it's a 
deprecated interface and it will go away.  Wait until next LTS kernel, 
and then rip it out after that.

Need Hans and/or Ilpo agree to make with that though before you spend 
too much effort on it though.

[1] https://fwupd.github.io/libfwupdplugin/bios-settings.html

