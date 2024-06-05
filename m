Return-Path: <linux-kernel+bounces-203242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4FF8FD83A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AFC1F277C7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF70813A404;
	Wed,  5 Jun 2024 21:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2fpTzhc1"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37A27701
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622237; cv=fail; b=qr25RoD3bQriD4BfifzjLxNUyytWFUNbWiU1vqFR23FDyYooSyxHkIyBrgUfOgKYj1CdT72mQgQQCGNqWGs27Fg9mQ3/ZLYR2c9lCqaL7A3dm5yrThubn1FqGNSRtNiIR3RU+LrJ9pvyHC1aX/dk2p/2PHB4s3FkZvmT7hJGdmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622237; c=relaxed/simple;
	bh=Uf1xCwrS5gkhva3iI4wiP9QCm+zJBRtRfO/v8g8NFKY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I7Ua69E4oLlcj6E19L1ZduJafG6QQju+nV/ZknOEG6W52biwrWg7MwGMxondjOEDoJJ13v6tFZrxrdhWzoTHzVKVXAPqUYJGbVQ5AlT6S7JwPEAK6Z2L1EtkhDoYTRAV8UYGegk+Gs+hae11nxhfW1r/bT4mtTpXUUQAZUiLI1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2fpTzhc1; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH/W4VrAZlpKv+AbEziiBaLEqhDMDjX4mfX63jIGsuAjuCzt3KhVmo1kOx0ggWUt18WP4ushEtgF0epuz4GVYsym1YlQWPEW7R1iZzoNCHrB/AqG5orbe4mMTXJJO+3n3dBVxZHqsBAOBABIQyj3TfUAmsSrQHAKG8dYib536iDkd7kQYuf0HgjeZ1AJjMhenoqRiYrfxvH9AbAYft0HerIKYtpAgeuTLz5b/BobESGRhbTGWWFTbFsmNagrRxFDcYwq1JRJRO0pFMN5MOjajcUKnPmTO6s97LcfaeRIP/O3m30spbByBKhYxQYqBVMGCrWMmjRgPuIcmH1ej3jNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6VNi9Ko125ovRm4ejx2yjyy4wOt9h4J9H1yBqmxlU8=;
 b=KnJTki4coF7CmDZ6JFTWjjx+0lBALslilg8/vmNfZpwbYBloPP/qCLHvRHhIlTuuJ7CMCU+LATVoJchZpvGxYw7yyAnDLETjFcP63kW8egjNUGRIKAaOWciRG6RcC8gI0yeXn98nyqnx2/fE/PAKwVDK+whGq+x+T4MvMgaU3lfLzyEDoLAe7WILmT1MtFocaDky5mUQFyG2xMb3wwxa1d8YSrgcDMFkhE7b+edvshCkOhfgY8gYLkbfA31fgr4gmi2QZmPsFJo2NhVurhnoMNZMb1lb014ghioh4L8FLfhIGk1L36sG/OtZqVwoMLUiUtIwAlIe1HWYqbDvxL7mYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6VNi9Ko125ovRm4ejx2yjyy4wOt9h4J9H1yBqmxlU8=;
 b=2fpTzhc1oPooe9e2sl7xksQnlJ/AobZm8jWlxcbYBkYxc4buyCHt/pCj4Xpi6ctmwwt0jJHbihkzTbpJd/ajUTdUJGCOxiN+QVtWJTTTg77fPZ5dZp3Hhyf9me13KwF/yRc+VpWNnRAnNdNXYzs0ksiw9lp0Q0XwHu/3yyls5C4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 21:17:09 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 21:17:09 +0000
Message-ID: <952085da-d209-5144-19ef-26c5e7b03cfb@amd.com>
Date: Wed, 5 Jun 2024 16:17:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 02/13] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
 <9d3fe161be93d4ea60f43c2a3f2c311fe708b63b.1717600736.git.thomas.lendacky@amd.com>
 <20240605193831.GYZmC-twcfjlArW3Hq@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240605193831.GYZmC-twcfjlArW3Hq@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e83b63-c617-49c9-148b-08dc85a4dc30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnVLQmF4cno5aXRYUStsbTIyaE5QdzJtWnhsbTV0R2crdk44RmJYdmtKQ3Ju?=
 =?utf-8?B?SWpRQnloMnNLSis3YVdRaExmQlVrdllLdTNjMUJ6aUZ0WnhaNlRRZkhBRUJM?=
 =?utf-8?B?SlNOVGExb0dKbHgraE5BSDVDV3NFR2xmQWp5Rm5tRWx3R2tZN2VGKzJpUU5T?=
 =?utf-8?B?SndyZ0gvMDBJeFoxWVBuMkN5QlZWVGZXMU1pTTROeHlYU0NCMUdGNEdlSDhB?=
 =?utf-8?B?T3I5YTFGSGtGa1MvcThZaWtFL3BEejJZRzFqcUliRGVJbkx3QWMvcDhiN0VO?=
 =?utf-8?B?SFF3dUxjVU5UdzVPRW1OUkI4MlVvZUM0UXloY3c0allwRnVUUkM4U01wOWx5?=
 =?utf-8?B?c2lWaXlhQThMLzhic2FRR29TYU1rRFZqZzJXVlp1U1FONTNTMVZodU4xZVo2?=
 =?utf-8?B?TGUxNmNZNTJyZk5hSHUzSGNQSXVGWVA1SEthSndsZWZJTmRtL1hPUlNTQjZt?=
 =?utf-8?B?T0ZVY2VtLzIySGFzdlMrbkJCdG1rRjRSUjB3ZTc4alByQnNNVlZYUGZtMndp?=
 =?utf-8?B?UDYxbkNJSHRCVGFBUmdJUzIvL3dETlY0aW0xUEdCSUdQS0t5cHdkV0VrUU5l?=
 =?utf-8?B?eFhra0poY2U4TVRTNUFzN3Y5TlhZeUMzcmREV0JJcGowb2o4NlVrRW94Z2Rl?=
 =?utf-8?B?KzZKMDRMNHF6VnVaVklwRUpEQ2UvRGNiMTYxUzNsaUovcjFYdjJLbC9BOWs3?=
 =?utf-8?B?cGw4TUplWEJDMEtnUmZaTlBYTzZINDRFNkFlVFpZa2k0bzBwOUFMQWFmVDhy?=
 =?utf-8?B?NldTVTRkUzlZd0xMQVUvZllhbFhZK1JPSFN5NUlHdFJIemRDYk1tTG9OUVpT?=
 =?utf-8?B?ZzZ6T3VFOE9jOTRjMFI1YkVISUxkMldyV0ZSVkVHckFyT1ppdTVyQ0l5U1du?=
 =?utf-8?B?M3NGcS85bDQ1eHdrK0dQTVdNb0p2cXpNYnhSaTFIQzZxQllobm11aElNands?=
 =?utf-8?B?UlRhREx0UmNjN0d3eDZaUEtWUkVaUjRYYXlTOHpSWjY4dGdqdGJqME1XU3M1?=
 =?utf-8?B?VzdsQVNvQ0M4Y05jWXlRVlFEdDRRRjFaWUpJNXM2VWpmUHNjcTRsVDhTUTNC?=
 =?utf-8?B?MkxCbXNXTUZVd2tuYVBMNjVOdW1QWHVZMHRCL2VGYWNzOUV4d2psTGNLaVZs?=
 =?utf-8?B?Rnk5MnlaRmpkNU5qYUFCbVcraGp6OWJPcmcwUk5YeG8xV09JV2I4ZWJqaXEz?=
 =?utf-8?B?bkFvMjhHKzRjaTVVR1ExeENhZTRsK3hka0tuRE91ZnFQZFFBeUVhUkpHMmJS?=
 =?utf-8?B?ZGg0UmlXZDVBT1EyMldlYmxPcHhaOW9QL3F3MkszWFJlcG8rT01vM1ljZmhX?=
 =?utf-8?B?VmFmeG1ia0NUOE02SW9ZVnJsZ21venRwSzc3UDRxbHdyT3g2TVBCek1JQW13?=
 =?utf-8?B?U1lJYUhON3RyQ2kwNXVyVUk4R3ZnUzRWZU44amhxbVQyZ0FTQlQxRVpJVVN3?=
 =?utf-8?B?TVlwVThhbzJxTDNCenNuWjdKL1d4bmMxZ3N6V2V0SVcvUzBuTWlYVFo1OXE3?=
 =?utf-8?B?WWE1MWFKMndiYXV2WVdZQVFRb1hBektRWll2K1hVL2d1eWQrTmkzYUttK1NW?=
 =?utf-8?B?Ym9BK2hYOWZJNk1IWDNNYU1XOXRrZWNQaFgzWVJnVWpNYkRoOWhldGJsODF1?=
 =?utf-8?B?UndWOWQ0cFZFUmZkNURTNmZ3ZmxkcXdsY3ZNOGhINFBOaGhuYUdpVUlQK3RY?=
 =?utf-8?B?ODAvdVhDUU1yOUdHeEFReVZ0Lyt2UmpNdjh6K1NzWFpXbVdlOEtWbXZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2R6NlhFSWw1Smp5M2Q3cURPajdpcTlJNWxhcEdjeGJKVDQ2RnhaZlVjaW1w?=
 =?utf-8?B?V2hYWjR3Y0YwNXE4dm5aRWppRmhSalMyb2JTLzVRa3owS1dISWl6ZDcyRUJP?=
 =?utf-8?B?cjIwY2JNNnlDMTBKS0xvb1kyWVdpVzk4Y2RQcU8yT3VaTFZVb2RVTm5nU2VU?=
 =?utf-8?B?dFhhc2QzY0hmNXZRN3NsWndXTzB2Zmo1WVRlZjV4eUs5YnRkelcwek5mQmlk?=
 =?utf-8?B?NW95Z3o2aGI2cUVQVHJaNVkxU2x5b3RWMmtJWW91YTJBb012SzFXNDd2Q2d5?=
 =?utf-8?B?amF1azdNYXdCYkpRY04rRTlod0g3WEtVK04yZVRDOXoxU3ZxZEZweHMvOHpM?=
 =?utf-8?B?WTlSQnNIK1E5YTVjcTdxU2QwSndXSitOOVhKMktTSmJJVFAxSWhTL1dWbUdL?=
 =?utf-8?B?YXNVRmJWVG1XMXRaSlFPTG01bEMyNExkRGRtRjNmZHZOYTQyNmEyZjVtcXdk?=
 =?utf-8?B?TVVIRnhaclpVbSs2Nm0yWGNKZXh0Ri9Ja1FUNXpLTXUrL29KMTQyTGJkc01V?=
 =?utf-8?B?RlF1cVhkWU50TVBOQ1pjdlVoUVVaWTEyUDNSc09FL1pqaVdvRUNFQ0NMdlNN?=
 =?utf-8?B?dDJMK3dKN2tqVFc2Y0hEaFpEd3BicjNaT0xTNHY1UFM2aUFzZWRkQ0M2U1pS?=
 =?utf-8?B?U3c4VXRIVWxUNDZ3UWdIZm5pSGxoZm5hZGU1eUUwOWlMbTNoWjJsK2pZd1BX?=
 =?utf-8?B?VjhSdE5kbkZ1R3ZmV2dFbGFRZ0RkQkN5eUcvQVFqUmtQcnd4eDRCTnE1MnNl?=
 =?utf-8?B?MnlEYk9PcUdlNFRPcVEvM054eXRWMlh2ek0xbUFNTUlNNnZuWjZadTErNlgy?=
 =?utf-8?B?K2VOYmtNUjRXQmF2elJZbk45dTNNbXVVSWRXeklXS1Z6NU00SnVSRUVCYURJ?=
 =?utf-8?B?WUI0bGh4YTAvUHJueDFjWHF1T2llMWM0bE5Ic25sTUFMVENjeWxDUWNQeFpE?=
 =?utf-8?B?M25ucTlnTVdZblJ6WUZEYzFpNDhRVUlUR1hoRVZWMTBpOTl3NDlDUzBNNHpz?=
 =?utf-8?B?d09aSXo2M3BEVy9mU09FeGxtU3lFckt3NmFjZ292aU9kSmVFcHhXdEtRd2Qv?=
 =?utf-8?B?SVEyTlFzN09mNDVnYVJQYmZ4ZEZzYUNHU3p3TkcrcUMya0FFNjVnby9FRjZN?=
 =?utf-8?B?NHBEVkR4R0poZVpYSGwzck5TeFpTWlZYWTZWN2IyK2kzUzdHVHUxdkRjdDhs?=
 =?utf-8?B?aGpVWFhOWUlqMFV6MWZVcUtiRjlpN2VaNmZGSnlmWFBsNjN5RWpxTFhzTkhW?=
 =?utf-8?B?amNPYWJoTHRrQktkQ3NmN2l2aW9FS0JUMXJsa3VQVlgzc3ltcFhQaFFQbnMw?=
 =?utf-8?B?bWhOcnZNK2M0R2NIUXg2SC9pSlQzRlFCR1dMdXdIMEpYZVM5dVdDdmYvQ0Rw?=
 =?utf-8?B?RmRXZ0ZxRDN2OHB2eEJOMFlHVzNQS0k3K294bDF4NEQyb0dJYWtCL0twcitY?=
 =?utf-8?B?YXRrTzJxa0RhMHdyempMOWxDVW1FU0p2TjBLVmtJWXloc1p5bFNpUmFHeENh?=
 =?utf-8?B?VTRpRUdDb2FvNEVVQU43QzVvVWd1aTlBNG0rMFVsNkppUXlZUE9vYlc5aHc4?=
 =?utf-8?B?ZTdQb1FuMlBFcE9hVVMwS3FrNGdTNWlra3J5a2ttcXJhQU41aVZhcFlTUlVC?=
 =?utf-8?B?TTRLalUyZkIxZ0ozT0xZbHhqNHAzYTVJNUhYUjM1N0ZyZHVCbCs5RFM4RWRt?=
 =?utf-8?B?VnMzOHN3bzFydDRza3JBNmMvd2Mxa05kNXNHT2lBVjNHOXlUMXF1NTN5V2sw?=
 =?utf-8?B?RDMrOHM5Z29UQVY3QUtkMWdCSjVmT29YOVk0V0RKNEsrQzlEWmFpUHBGd0Nr?=
 =?utf-8?B?Y2ZnRk1FcHFBZkJkTkJFWGhyMStIdkROQ2xXRDFJR2dETUdEbmFIWjl3MkdO?=
 =?utf-8?B?SzNqV0pMczQyc2ZYaG5ENE5hQnE2MFZFSUhMeDVzQVN5dzNKaWI0d3k2Q1NR?=
 =?utf-8?B?cTRrZUx1MFYyb3RQZUFXQjJGdGo3SnZ3ZzRrNHFPL3lBdVdWdjIxc3BqY3hq?=
 =?utf-8?B?V1RqOUlSc0pubWNDUGJZUExJUFIxallVZWtRYmY1c0taQXNaZ0NBeFZaQ3pN?=
 =?utf-8?B?TzhRQ2NnQ3QrS3plMk1FM0tCeUhGaVlROHZxTmJGd1gvR2tyanZHbk1oR08w?=
 =?utf-8?Q?cR/2c7NOPtReh/BmPDBf7qAMC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e83b63-c617-49c9-148b-08dc85a4dc30
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 21:17:09.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngXR0EKkne2uH6ySwokxD/59aM54j3UWyV6TY68gYrlQve6h7PZEL6XZ44ZvYig/MZG0Nqn0nkm60G0mOtzIzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

On 6/5/24 14:38, Borislav Petkov wrote:
> On Wed, Jun 05, 2024 at 10:18:45AM -0500, Tom Lendacky wrote:
>> During early boot phases, check for the presence of an SVSM when running
>> as an SEV-SNP guest.
>>
>> An SVSM is present if not running at VMPL0 and the 64-bit value at offset
>> 0x148 into the secrets page is non-zero. If an SVSM is present, save the
>> SVSM Calling Area address (CAA), located at offset 0x150 into the secrets
>> page, and set the VMPL level of the guest, which should be non-zero, to
>> indicate the presence of an SVSM.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   .../arch/x86/amd-memory-encryption.rst        | 23 ++++++
>>   arch/x86/boot/compressed/sev.c                | 21 +++---
>>   arch/x86/include/asm/sev-common.h             |  4 ++
>>   arch/x86/include/asm/sev.h                    | 34 ++++++++-
>>   arch/x86/kernel/sev-shared.c                  | 71 +++++++++++++++++++
>>   arch/x86/kernel/sev.c                         |  7 ++
>>   6 files changed, 151 insertions(+), 9 deletions(-)
> 
> I did some touch-ups ontop:

Works for me, thanks!

Tom

> 

