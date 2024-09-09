Return-Path: <linux-kernel+bounces-321631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79768971D37
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD741F23F1D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27551BBBF8;
	Mon,  9 Sep 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uqLVEem6"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48161AE039
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893634; cv=fail; b=VteKPRozKLvyL4j+w1JOUY0o3+atSIaxdFY8f5npMpSdVIgEie4+4G7pdwXTY+/lziONKsgxSCBwqlT+VT4iiDbTFW1XYxoHoJUsJCE3E4Qjp+KZRe+OwcFcV+jgoW5mqQzmjtqvafAfr62MJwfREGRDTZfYbSGMiTOnq0oA1vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893634; c=relaxed/simple;
	bh=/T7n2M99vA+wdof1xSyZB0s6Mi6AbJ4biyFAa0Okk0o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SUfwN4UWKZpbeF/1bvRAaa9P08zgGkkEBqoiqlWB6zm5y/I88tHIqrs8/WkMLmAqYzapL31l9fRnbVV4xQ9BEHbQ8Nlmpkz6HRvQsusRXw4lon90AWcWBrgvEALt0QskeYD7DU7plFHtgOkhcBALSi3yvU8NQQ8RE1I3uTH5kRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uqLVEem6; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxylXcUMyS0bPYIVZS1TXFhMk3KLiNjV8oOriuZoXOFkvg/gE2jaOcG+gvGRMu1s3QEeIciInZ3u17iAkFZAbDfDKgFg4Etp2k/r6hOzqk+gz2sHu3l2jgHuTxfMFXqKNvaVuMJY0KyHR1t58L7QsPeTQd2slCEBOfTCkc4FJ78Fk+MWTrc/LAET27jZAInVdPxnvMYfG+yW86P+m5Wsh2I6aPLSb2SdiCb7jDAFbiyGowKOrj2x5AYAG1h2KZtaUya/twj3cznL2cyh94Ey78jVqQqCk7RudRaxJTPJxijD8wfUqVuYn+jf15lWOl0dQ+mYNyqHpwJVc5UfZ0xWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGlKvwXe+pTpGiIy1pPj7CjKoPxmpZplosZf+C3tZGU=;
 b=mrHP1qqK2Qq8zUNA/ArTgyEm4BncJZ4/nU+1EHGNsws8MhGey2XAzT4npnka4F0CO9yhGK9BTrXSZRHrsPzZqD7rre06Lxvu5kDeyUYmAbgnojIGW8TLUKC3g0a8fBpsbVGSYndRadfBmr8oY07VStncUjkM5OTw3BW6xX0WBhPbpQZBzpGf+9nGB1Axso2Hih4iBqyKhB+CeGph9zxVvJEHSsFnlXl47wxvf+x72NLYYzpSk39N4FKxmeXkaOui58/pUXYA2m3tcxBVWGN41pWxYST7bjKw7qKQ28J027w0N3S33MWlu4SB+nXAlzvwH+2emNjlvfG4A9rcQk/H/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGlKvwXe+pTpGiIy1pPj7CjKoPxmpZplosZf+C3tZGU=;
 b=uqLVEem6F6Ca8vACyi5yJrtPDk2VFMYXVRyjtiUoG0TvOX/wAeRaUqXdoiUIAk4d2MIsAS52P+rgzmB4KWTlFcFz0HHpe3Me2QUdJeC4oKKPOETH0cN+mFILARdcbVfg1xFEl4q4O1VWM08c4e8+cBoZju2aDSefp3+YmhiYgBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Mon, 9 Sep
 2024 14:53:50 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 14:53:50 +0000
Message-ID: <43291018-098f-291a-629b-6e02ef00f8e5@amd.com>
Date: Mon, 9 Sep 2024 09:53:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] x86/mm/sme: fix the kdump kernel breakage on SME
 system when CONFIG_IMA_KEXEC=y
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
 lijiang@redhat.com, kexec@lists.infradead.org
References: <20240829104016.84139-1-bhe@redhat.com>
 <20240829104016.84139-3-bhe@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240829104016.84139-3-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:806:f3::28) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b22abd0-0efd-4ea2-1c8b-08dcd0df370f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MC9yckFjTjhQU0Q4eGZjMzVZN1hEek5XckI4dE5IclB3LzRwRE1rYnZtMXdh?=
 =?utf-8?B?UXorVjc0VjFPMkJGRm5sOCtrbE1nLzBzSEt1T3RIMk5kbWgwQmVjbjM1cEkw?=
 =?utf-8?B?NkQ5MVlXWmtSVjhnalA0a2MzM1poMHo3WmpkSm9ZT1d0UzkrTjk0Q2doOG5K?=
 =?utf-8?B?ZkpKT0RKYjJ0V0l2NlZRUHJCb3ZvdmJzekhCRVd6OWQ0Z2Q2QzhWWjBueEY3?=
 =?utf-8?B?bStPbXc0eDRkSXk3QW9hR1U1aXNZaUczQk04WEhha1Axb2hMOThCcUpDYWJp?=
 =?utf-8?B?aWZqOVBZRkVGOTVHdGFEOXJGa3Bob3pEUGh6bzJFNlUvZStvaUNOQlhJSyty?=
 =?utf-8?B?YllkY1ZvZGJSVG5jSmVPa3ljd1paeTRwNGQ5eGRCT2xlcjV0VjB1SGNIMmUy?=
 =?utf-8?B?TW80Z3dMdElOVW5MZkJvL2x1QkdjZVlxWGRmS0x6SnNZS05HcVRqOExuTVhx?=
 =?utf-8?B?azRQa3BPWXkwTlBVaURGTGdWRVY1ZC9jSlltRVNLMTM2eHhnNWNnRE13MkJn?=
 =?utf-8?B?WmJPZllKMUIvQ2JmVmp3dloyWHk1VzZHbU8zT2dLV0xhbWJJcUpKTDN5T1RU?=
 =?utf-8?B?SDk3T2diakFFV1dXSDkrL21ac0daWWdFZnpTQmZCNTdKUUpBS05FOXkrMnRZ?=
 =?utf-8?B?SkdyYkJjZHBUYTdkRURUemF3cE1nU1NxcGpzN0tLQm1IZHorbkY1cCsxYi9O?=
 =?utf-8?B?WWlSYUNhTEJSVnBadWVaT3cyRWx2c3Uvc0VTYXpKVVhreUJ4WUNFKzhPcHQ3?=
 =?utf-8?B?UlZTSUc4VEJ5SXBERkl6RUJWU21BWFZENExIaTdhdGoxOGc4VkNHK29WMDFU?=
 =?utf-8?B?aUZZWHNjVStDK2g5N20yYnBGZnY0eURpSDFQSzJzU0NBSFEvdTZQQ3UyUzBz?=
 =?utf-8?B?Rk1lUGN1THdrdnNEeVNYOFJNZ1ZTeERyU1lMTXVuSEJ6YVRhY1lKYU5aZVVT?=
 =?utf-8?B?TndZclNHWmZFRlA1bVlZbU95ZlZpL1RVWStnYllVekxObTVmSjFrVGdCKzBh?=
 =?utf-8?B?OHNvb05aRzZacGpjelowb1VqTjZSRURIbE9uL3ZvckZDWUNyR3MvdS9rYVVv?=
 =?utf-8?B?T2lFbFZURGhidC9YVlJFSmFxc3V6b3Jvdm1RemlGa1Fua0N1Tlhpemd6eHdB?=
 =?utf-8?B?Qkd3R0ZHcTE0MXZJblJSRk9mdTBTaStwT3Q3RWNKMllma3ZLOGhISFo3YzZZ?=
 =?utf-8?B?SkZhMDF2aVUrMDAxdTRERk12Wm9hM1RzSzFockt6c0VoUmM2MDloZU9CRkNX?=
 =?utf-8?B?dkJDdUVnUlRSVEk2UzFJbHVoVGJXUkF5WVVBZWN5ZFdicUxTUHpvZ3BPdTVG?=
 =?utf-8?B?NXRnczRLeFMxY2lVaDhNQnQ4VG84akMzTGJhOGFqUFRtQzFDVHVkdG03bjUz?=
 =?utf-8?B?WEdUL2FNL200TUhzMWZNS2pHUkt5eXVFTkN5N2h3ZTBwaE4xZlNuUDU4N1d2?=
 =?utf-8?B?VTBPY1BnZ1VLZlphekdoZWc4RGlsaktUSTJHNzg4akpkaHJwYXAwd25WUzQv?=
 =?utf-8?B?S28wbEhpQStaejRWcjJZRTdvMy9TOEVOTEUyZWwxdUtlcVhCWVhmNVVNSW5m?=
 =?utf-8?B?N2ZnSkQrMzEvN3RLRDNLS2FoMm1yUTFPZ2g4MmFDcU1PRkJyUEdjQkRlRE92?=
 =?utf-8?B?bUdMNnhGMUV0dDZUTXBzRDFyMTBTSzEwTXIyaWpMUDZJeHdiOFN1QUhMc045?=
 =?utf-8?B?WVlkb2t4SjlvekpGc3NpUmRwUjY1ZnlYUFFFYWU5QTFEa2lLbzJ1cWtCRlZX?=
 =?utf-8?B?bEJxaDZLY2U3VHdES1pjWDQ5KytGRUZIeVlOUmJiR2dlUjEwY1V5dVEvSWlU?=
 =?utf-8?B?NysrNWN3OUZTM3B0YUNNUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWJNZmtHZlFvZTRYb3hOdHpzOThKZ0JBUHJVeWJXbWxTVmliVkloVXpCbjhX?=
 =?utf-8?B?eTdhMnZDWXdLbzdpVnI5Q1U4QTVYSEVXMTgvb2FIcGhsZUtoWEZvb3p3VUdl?=
 =?utf-8?B?L0ZvbWsxR0svcTN6ZWdoTFV5VEtYaHIyVEorSENZYnhJUU11Y3B1R1VSUHNJ?=
 =?utf-8?B?TG02aHJIYlUram8zQy9GME54bWdwL1g4K2lwL21xeUJKZGtrNmVhS0hJdXhj?=
 =?utf-8?B?amdOT0xLbEpWN3FsNWg1NFAzTkZST2xRQmkvUkRzWDdvZ3V2U0YyNHdrbTFC?=
 =?utf-8?B?cmU1dnNMamEwYVlyUDhLazFKNTUrSFI0YXlnUVhMWk0yQXRIaG1wNmFPRG9l?=
 =?utf-8?B?alN6Y2pSeGFPN3lsV2ZKZVhTdDcvc04vMVhaT0xYRkMzbUhoYW5ESDdvNUlz?=
 =?utf-8?B?eld6cWN4a0lSeWljeldSUkVGWTNNMElKM3BIQXdKTTRUMzk0SDlWNjlKMmdz?=
 =?utf-8?B?YzZIZ0hBcjlwak1JVkVUTHZSeG9qeFVlYjMwUlZFV1htaHkzQnNxNVNHb1Mx?=
 =?utf-8?B?d1RsZTJkM0EzbTQxZ2drODZrM04vRktXaml1VnBkQ1g3dEJTMWlaMFVBOURt?=
 =?utf-8?B?Zms4ZU9xNVBWMmpiTDVTc21LWEhXMzNEZFhWcmljUTZrVzVYZ1ZrVUVEbita?=
 =?utf-8?B?eWNxanBLalJoTVlFTHRidHRHdVZiNXNtYVVHTWJhUDZ6eWVLMS9jVnhoMG1N?=
 =?utf-8?B?cHZueFk5eUMrbDNwTDJHbUdVSUtEOTRpdGl3VmJnY1pIZnROZy80WFNvamJM?=
 =?utf-8?B?SmJVbEs1UTlXbUFUMEtLUUNzeEJiOWpzY2x2WThDZnVzLzFnSFRDcHdxaS9v?=
 =?utf-8?B?dmFOZEJJOU92bmhtM1FLZUJrREU4SStkNjNWcGpjTzRsVGhaL1FFVWJhQUNr?=
 =?utf-8?B?dllhRFkwOWhFbXRIR1VBZzQ3SDFkQW1uaWh5bHJSR1NETHN4djIyVCs1eFRN?=
 =?utf-8?B?S3EzYU5Nd3hIdTA4bUFNYW50VDJ1aWJiLzBpNU51SW1PUkJhbzl3V1Zxa2NB?=
 =?utf-8?B?U3dFOW5kekNaSjlESzZPTDJZNjdHdmNuV1FvTWk2WkkyMU5idGRIbDhsUjBP?=
 =?utf-8?B?c21leWE1UUJ3Smx2VjlUL1o1MjRGR2JaWkFaVVhQVDZteTBiTUdoUmw1L1Js?=
 =?utf-8?B?UzlrellvL1BzMzZtTFVDU2lINUozQlN5WkI2Y09JbGtoVVBJQ1ZLY0dJbzQ3?=
 =?utf-8?B?VjlYTUtTQWozY2NLOTNWREk1ZWJWZktSQ3VGNFpLZUhNczl4dUY5eVJWeFZV?=
 =?utf-8?B?amV6Z1h5dDlmS0ROV2JSdUdQckJHQnJQYlViV3FFRDhQYXVYd09RbHFBdE55?=
 =?utf-8?B?SlRZUDFDSW5tY0crQkJiRSsxeFlYbFNJa0IySi8zTzY2T3E0dDROaUM5Mkla?=
 =?utf-8?B?c0t2SVBoeUQrVXI4djg5bG15cndRdVNlTXZBbEdOZTJkSDZnOUZoQ3JpTU03?=
 =?utf-8?B?SGdzTTMvUGwzdlFNYm5lWU4ycUpRcHZzZ3pCTForMGtwWEtWTGoxSXdwWnlI?=
 =?utf-8?B?amZMV20zdUlvWk16U2UrWGhocDN1SFRDb3djMXZmSjQxNTRtcHFPbVJadjYr?=
 =?utf-8?B?cGdGb0tRRjRiQkkxMVFBclpQZXBiTW1iME03aDJOOGVHQU1TQ0tGR2tLM3JJ?=
 =?utf-8?B?YVNlM3Byc29ETURxMzBzSnVDNVZPQnduTW9NQVpXTHpjVmZxbjlGMUE3VjBZ?=
 =?utf-8?B?NEVWd3BCRGVoYUd3SzY1aDN2SlIzVFVnN0ZxZm83S0drRm5MU3dBdHlqMDhF?=
 =?utf-8?B?Y0FvNHZUVVdYWDhyL0tkRmVRZW50NDB4Q0dhSUpFT1Z4dUQyeTZPTkVpTE0v?=
 =?utf-8?B?VTBrWFVnTEtrWjdWbCtHa0NXTkgwMWV0S3lXNHBqOEpoRklmY2JaaXhuUUs3?=
 =?utf-8?B?bWxGNGVQc3BrTXU1V2dyWk8zMWRZNVJiTmVsRk9rVUlUVFZFZTZxYStPMDdU?=
 =?utf-8?B?T3hxSnlQaXh4eU54eEt6QkwzdTBnNG44Vi94ZUhaNG9qdVF6ZzVnVFhuV05t?=
 =?utf-8?B?NFJicEZ3QkRGbU1HdzJET2h2SlFYczdLY25GM0trcWZSOHR0d0x0Qjl6cDBD?=
 =?utf-8?B?Vzg5M1NFZTRzMWd6SEFrOFNvSjg4L0FseVlUWDhVcTVnNTdGUFN1Y2U3U2ha?=
 =?utf-8?Q?/1/dIFPn4UBd5M4olM0lqPA51?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b22abd0-0efd-4ea2-1c8b-08dcd0df370f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 14:53:50.1764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4P5VwF3sDDp1VkaJd0G3UY5aiL6W+WR900oE2bTKwgsHZIgbLoLkYbBhzMk9TWvsQVMHURCW5Jfmwf45TxpHJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824

On 8/29/24 05:40, Baoquan He wrote:
> Recently, it's reported that kdump kernel is broken during bootup on
> SME system when CONFIG_IMA_KEXEC=y. When debugging, I noticed this
> can be traced back to commit ("b69a2afd5afc x86/kexec: Carry forward
> IMA measurement log on kexec"). Just nobody ever tested it on SME
> system when enabling CONFIG_IMA_KEXEC.
> 
> --------------------------------------------------
>  ima: No TPM chip found, activating TPM-bypass!
>  Loading compiled-in module X.509 certificates
>  Loaded X.509 cert 'Build time autogenerated kernel key: 18ae0bc7e79b64700122bb1d6a904b070fef2656'
>  ima: Allocated hash algorithm: sha256
>  Oops: general protection fault, probably for non-canonical address 0xcfacfdfe6660003e: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc2+ #14
>  Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.20.0 05/03/2023
>  RIP: 0010:ima_restore_measurement_list+0xdc/0x420
>  Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
>  RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
>  RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
>  RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
>  RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
>  R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
>  R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
>  FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
>  Call Trace:
>   <TASK>
>   ? show_trace_log_lvl+0x1b0/0x2f0
>   ? show_trace_log_lvl+0x1b0/0x2f0
>   ? ima_load_kexec_buffer+0x6e/0xf0
>   ? __die_body.cold+0x8/0x12
>   ? die_addr+0x3c/0x60
>   ? exc_general_protection+0x178/0x410
>   ? asm_exc_general_protection+0x26/0x30
>   ? ima_restore_measurement_list+0xdc/0x420
>   ? vprintk_emit+0x1f0/0x270
>   ? ima_load_kexec_buffer+0x6e/0xf0
>   ima_load_kexec_buffer+0x6e/0xf0
>   ima_init+0x52/0xb0
>   ? __pfx_init_ima+0x10/0x10
>   init_ima+0x26/0xc0
>   ? __pfx_init_ima+0x10/0x10
>   do_one_initcall+0x5b/0x300
>   do_initcalls+0xdf/0x100
>   ? __pfx_kernel_init+0x10/0x10
>   kernel_init_freeable+0x147/0x1a0
>   kernel_init+0x1a/0x140
>   ret_from_fork+0x34/0x50
>   ? __pfx_kernel_init+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Modules linked in:
>  ---[ end trace 0000000000000000 ]---
>  RIP: 0010:ima_restore_measurement_list+0xdc/0x420
>  Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
>  RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
>  RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
>  RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
>  RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
>  R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
>  R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
>  FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
>  Kernel panic - not syncing: Fatal exception
>  Kernel Offset: disabled
>  Rebooting in 10 seconds..
> 
> From debugging printing, the stored addr and size of ima_kexec buffer
> are not decrypted correctly like:
>  ------
>  ima: ima_load_kexec_buffer, buffer:0xcfacfdfe6660003e, size:0xe48066052d5df359
>  ------
> 
> There are three pieces of setup_data info passed to kexec/kdump kernel:
> SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED. However, among them, only
> ima_kexec buffer suffered from the incorrect decryption. After
> debugging, it's because of the code bug in early_memremap_is_setup_data()
> where checking the embedded content inside setup_data takes wrong range
> calculation.
> 
> The length of efi data, rng_seed and ima_kexec are 0x70, 0x20, 0x10,
> and the length of setup_data is 0x10. When checking if data is inside
> the embedded conent of setup_data, the starting address of efi data and
> rng_seed happened to land in the wrong calculated range. While the
> ima_kexec's starting address unluckily doesn't pass the checking, then
> error occurred.
> 
> Here fix the code bug to make kexec/kdump kernel boot up successfully.
> 
> And also fix the similar buggy code in memremap_is_setup_data() which
> are found out during code reviewing.

I think you should add something along the lines that the "len" variable
in struct setup_data is the length of the "data" field and does not
include the size of the struct, which is the reason for the miscalculation.

Otherwise:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/ioremap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index f1ee8822ddf1..4cadc7ef1cb4 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -657,7 +657,7 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
>  		paddr_next = data->next;
>  		len = data->len;
>  
> -		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> +		if ((phys_addr > paddr) && (phys_addr < (paddr + sd_size + len))) {
>  			memunmap(data);
>  			return true;
>  		}
> @@ -721,7 +721,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>  		paddr_next = data->next;
>  		len = data->len;
>  
> -		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> +		if ((phys_addr > paddr) && (phys_addr < (paddr + sd_size + len))) {
>  			early_memunmap(data, sizeof(*data));
>  			return true;
>  		}

