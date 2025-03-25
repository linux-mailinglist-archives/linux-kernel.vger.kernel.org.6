Return-Path: <linux-kernel+bounces-575350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78069A700C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B18A3BA721
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4872698A8;
	Tue, 25 Mar 2025 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SPQ7pGsI"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760B25C6E4;
	Tue, 25 Mar 2025 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906168; cv=fail; b=prKw7PqaInBe9OsdpD3bQGPCcEuSi3RcsYdQuFDunq7YorvP2MJuRkio165Jrb6fyQylyMA4/91wy3PaOxOsCvzmJLlVFGvbSvEeT8BnEHdtHWH4r/vgsIjS/EIh+QSp8YrcmfuggqOOqKJhcqT74eVcbeDMs1YIg5AHBqsuaqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906168; c=relaxed/simple;
	bh=rlEvnr9v47s1wWFzI34tKo4ZbS0kw0MesFGq8bepvjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HuXglZg1OYwmRXi8Al2W6W+qfz90VFLWqAmA4DxUxixdpyBZNwojssIx3DNjQN7z5vcTKYOJ8Nff65idzQQEnjhbWAOQT7y9v0BMlR5AIDxhLONQSO+urPNWWMdL0vVSdLafuGbU//28zFpQ1597mzudzSY7ZKPC5zVE74HGu6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SPQ7pGsI; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eedQrLM0dxMFqg+N6xFArrOs+xlyVGprxoBxQwKQeCo2rWzpHaNE2nlpNUvViHazAgdHvYjUpdqRjBTHQsfZP6XekpA19e3WSdmuyDyT27k4Lq76FO3rIzA104T+tv/E6bN5OVOlUZjSZ2mwLpaFUiJXWr9FtObUuvDhNwVEv/gGAXsYirwxsEg6VwdVqZIVCPjZ+Y3mhalOIN762f/CD+nWWtNdsavFP+CbROAavYhwm0gxbJvrdhetMXwr6Kce0uPKgxQ3MJOzrLo6w9KzbR/5wgQ7YuhzVz60BJQzuk6CDTVIQzDMTsNRDUvyVdsXC3xvIe7N3VxqHqXJ4HBGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA0UrxAdki0THORIY6XBgSOrGLgeuFGj0crTutmt3UE=;
 b=Bt5hTamiS3XOB3SzRcQe88IY2XZtNQhgGBBXpObooYhWyS3N1IbjY7kpiiDHDHG7WmjGqqbrEdLMudOkImD+2eLO+h2+2POciBRlxZN5+qPEZM8CsrrAZJ29vNtOiUyCPGP9n2mHhUOynMjF7qC7NCE7I4+cySgEDunzWTtqVwaL7ohdkrerpFLkK8RrcSLb+Ab0oXZURyJuTqwnWML0YzRL5mXYTnQKRpTxAF0J/tksV7JbzYpwl5IiWBvE38X6sU2UDYmGrNm5bWmiLurOsjCxJ25RqDgA2TetYom4sOmcUhXWIiiHCEVhpVPbbJKqOOTWGTmlpLkSwpl+ixnlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zA0UrxAdki0THORIY6XBgSOrGLgeuFGj0crTutmt3UE=;
 b=SPQ7pGsIHU0KNxf3pfh/AqQnYVOGRxvRfJmTFkfSJSBcPE8YCFkLYkultIU0j4ETCddE+U80EPEvyCSVWpUVdxkYehYRO1xH1UxDUfNvGbOXUWW7bwjEseEFQMVbcMLZuG/HfqCYyqzojIbIo8EAlzJ0SvmIvAHwT/DV2lhfbck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 12:36:05 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 12:36:05 +0000
Message-ID: <fd2e2729-98cb-4406-af99-b8f3dd23bb13@amd.com>
Date: Tue, 25 Mar 2025 18:05:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/11] misc: amd-sbi: Add support for CPUID protocol
To: Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, shyam-sundar.s-k@amd.com,
 gautham.shenoy@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 naveenkrishna.chatradhi@amd.com, anand.umarji@amd.com
References: <20250324145815.1026314-1-akshay.gupta@amd.com>
 <20250324145815.1026314-9-akshay.gupta@amd.com>
 <3ab1116b-7021-4d83-847d-fdec53af9bee@app.fastmail.com>
Content-Language: en-US
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <3ab1116b-7021-4d83-847d-fdec53af9bee@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::16) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 31776b81-be78-445d-acc7-08dd6b999c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1BuSUt6MitpVVVkQUphMjBENThzNkY0bm91VEhHWEZXcDI5OUJXVyt2azMy?=
 =?utf-8?B?S3BKczJ1VGprVE53dS92UmJxK2tlOEpnTGIzbHk4TTd4R3Fsd1lwaFVQcEVU?=
 =?utf-8?B?R21XdllBOXNweTdkd2RYUml2SmtseGVBMkNtV3pqVFZHSkUwTWlZNjJWUWtq?=
 =?utf-8?B?Sk4rZkJia3lEdHYrbnpScitaMEk1VW0yUFM4dysreTFMVWtCQjBiSjdyd0x3?=
 =?utf-8?B?ay9SV2R3NUEzVXpZcTE4Z3gyeGU3TmdRZDFkNkQ3OE9seWlDK01nVGk5L2hn?=
 =?utf-8?B?UFVaZU1TN3hUL0FMOUs3NXY5aHZNT21oL3lHTkN2MnhYdGZrZWNTYzdORU1B?=
 =?utf-8?B?L1ZqQzZxVGZzZHk0MnM2WDRlekM4S2hZQ0lYbmNJdko2Q3RBaWN1OXlCbUh6?=
 =?utf-8?B?WkFlUzRtMGJFQ3BBdFFsN3NqUldESUM3Ym15OTk0TFVYOUxJMU1zanNaMThw?=
 =?utf-8?B?eFdDamUyeXQvcnZrOU1nMEhYdjUvVDF4ZjB3Q1ZWeGh2TXVaSGVvVGFrSDRo?=
 =?utf-8?B?WE0vais5dkxVeWF1azFqaVgxaGlZWEg5QWhGNUtSN09qR0VFVm9OYnJuU2p0?=
 =?utf-8?B?WHd5eDhBcHRxSzVMZGZLbDNwSFc1c05JbFRqSUFrZkdQWncxNC9mTDZaNDhn?=
 =?utf-8?B?MkMrcWlldHZEcHNkZ3ROVy9mNWw1aCtjQnp1UHl6U01PSXRHeitFdnhjdGcr?=
 =?utf-8?B?STNUeUlWbFNjczJKd1RFU3lJNzBxZnNxcXNpY0kxTEoyRkZWYXI3Ri84VTEx?=
 =?utf-8?B?UENuVFRQYnBvNjdjelJuYWlrOG0zNTFYQVhXY1AxNDA5OFY3bkcvdENCbDZL?=
 =?utf-8?B?bEt3eHR0aWdESjR3Y21qZGFzNWFTUUVkcGdxbEQySDNub0lDR2NSTElWUjlZ?=
 =?utf-8?B?K2NFQi8yalM0NE4wTTVCWGUzRzlaZ1Zjb0ExZkNVTEhjZ0tFUG5YVWtEWlhR?=
 =?utf-8?B?RFMxWHBEZjRnTEZiMnVPR2IzUTFhOHFhcDN0eDlPM1ltaGJhdHMvaTRKUVZB?=
 =?utf-8?B?Ym1xa2VuRnRnTHpWWmR0WXdabGJpc2x4T1U5RWUxbzdsc1dhbi9WUjFFVnZY?=
 =?utf-8?B?ZmQ3djJ4dTRkazkwU2V5YkxrWXYrM2ZnMUNIT0hLVTlOYmFrSHJZU05IVUtj?=
 =?utf-8?B?TGF4bGJXbFh2aGtJcmVuZFZ5d1RRZFltLzFCbTkwc2hjT1o0WFdBc0lIb0Fq?=
 =?utf-8?B?MytPaDR0TzBrUW9FT0ZlN3ppNEJZdlVja2hkWGJLQTI5b0lhaE00c1c3bENl?=
 =?utf-8?B?NjBVWGk3MEM0Q2VLbFBqTzM5TDROem1JVXZ1bjVCZU93ZlRPMnBjVVh4b05I?=
 =?utf-8?B?QWZlMXFxVXJwQUdwYzJpdzUrTFIydnBMTTJuYjF6d0Y4dFMyRXVNRWZNN1NQ?=
 =?utf-8?B?azduNXhyMnc1UlppZ25yazBIQzJadzgvem0vVGJVY3hwWDJrcDNIK0YweXZo?=
 =?utf-8?B?U2p4elQ5b0JpLzZGV1l3VUo3a1pET2kzYVdlVUExeXYvc0g2U2ZRRm5EcGpo?=
 =?utf-8?B?YldhaFIxaGswdFZzZ2lNNWR2aXlXQWJZRHlmMGpLQ002N0VjNE5QWUVQV0ly?=
 =?utf-8?B?NkN4N1dWR2ZjUzAvWk84UzBwNSt6WmU2d2JkYXNMNnQyR2dXUEZFTFdmL1Rz?=
 =?utf-8?B?NGhxeDBtc3FTdmk5cExLQjYwU29kQkliWkMzVGEvOVMwWi95QWpnY04yOUlw?=
 =?utf-8?B?ZFNpNVVtN0pPelRpR2IxbzVROWJYaDc4Q1ZnNjVWcmNraXd3QkJMTHNJZWUw?=
 =?utf-8?B?V3djNWs5bzVnZkpleWRCNlB1ZnpUVlcvVWhFbmN1KzBxOUdTVm1DTVVtbTdU?=
 =?utf-8?B?cVRqclJGSXVnVVc2cjRKSzZJZG5ieFdEWHdvd2o5QmRtbEd4MWQ1RGdkazZN?=
 =?utf-8?Q?q3JHjYtX0VQmc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkNUTHFxa3RReVU3VEs1bGszZVN0bGRVWnNFUXIzek5OemVsN3dic3JPRnU4?=
 =?utf-8?B?UDBLOWdJN1NpK0ZReW5tUDRjVjJEZTRDWStiOURESlUxVWdRN09MbTJLTXRG?=
 =?utf-8?B?Q0ZmT0RZUFhaakhPdkpyaWxBRHJNalB4dDZETkxYTmhWQXNhTHRPbVNBOUhn?=
 =?utf-8?B?MnpFbExmMzJoS0p0ZTBVQ2c2U0FHWFdVZDAvRHVyZm12bkRvUnk1QmxjQUtr?=
 =?utf-8?B?c1Y3R3Fpb056WVhSbkdDbjBtMFBiNERDWXVrSGI3TWp4dXdDWWxlc3YzcnY1?=
 =?utf-8?B?VGJTQlB6aytmM3JsZ3hIbUpnNWVNNHg5T2NPVzhVY2xPZGNWMXkyVHNpNzFa?=
 =?utf-8?B?Z3JLL0JpaUtsRXV2VjlENjdnRlEzdDVtd3NjOEovejRnY2p4WkVSTzNRUmNJ?=
 =?utf-8?B?ZmhBQlIwZzFDeWVrQUpjbjNBU2pkOWpUbERKZlZVUnhJT3llcS9QUXIzcFZL?=
 =?utf-8?B?cmpzSVZCdW03UExGeDJtNy9OZ2ZRU2RpUWNUVUh6V2RZbktPZVZQeTI2V3lh?=
 =?utf-8?B?TG9FWHlRYy9nV2ExRlFacFY3Yyt4V1hFaTIwZ3JnL2dKVXZhUnpNUUpIZTFG?=
 =?utf-8?B?cWZPSi9ldzhwMkZ3TzVTcU5RRzBSd01LTjFCVS92RE1SdVZlU1ZQUnFWS3dl?=
 =?utf-8?B?Y1ZhYWk5UWZ2RnFjenlTSENweHVHQ05ER25xbnBlQU9uV29DWmR6UFc0WUNB?=
 =?utf-8?B?UUZzL3RvaFd2QXl1aCtXUi9uSUpLakhja1lZdStWUTRJMCt1SnpsRHJyS2hB?=
 =?utf-8?B?QnB0TmhiYmJSeUFGMzMwaXhIME9mTmsrVGdqMURtbnJjOXpqdmgxVzNkcUlu?=
 =?utf-8?B?L3lMMk8xWUpDeVM2SlZJV3hnZmJvaGhLRzhZM2NqNU9ubEgwcjFFdE5ZY0Y4?=
 =?utf-8?B?L1pNSnlpbDFDNEo4WXdtNVhsT3VUaFpVaUxNK2dlVFY0MzhaNmlNUXlUTDNl?=
 =?utf-8?B?Rjk5c2ZpL2JaUVFGOGNRKzVqK2lmelUyekx0K0IvR0piZWJUZ29OaUJsRDZl?=
 =?utf-8?B?V0V2NXg1UThQSGFVYnNnS1ZudW95SnVBVG4rTU01S29FVXZPNkVPYUhTT3NT?=
 =?utf-8?B?K005czdPcFhsYVRQK2QxQUI0WUFIVlZQdE91UWpLTjFwejNFNnN4M2txVFBp?=
 =?utf-8?B?N2FhK1NpdG1tL3NodHVNWkpJNHE3WnZMWHp1YkN6QUNCSzM0MzdoSE83Y1Bj?=
 =?utf-8?B?T29kYUJ5KzZPR3NIbkdSYmdEc2ZzWXF2d1pZVGxzdGk3LzMvSDZKZlNJYjRk?=
 =?utf-8?B?a1hVSTRpSVlBR3pLQko1SjJXcUIzYkQ2RjRLNHljdkJCUWZQZTJKQVhUaGVy?=
 =?utf-8?B?cmNaSmRPMTQxSm43YUdPNTVmMWRKQzl1cWxoeVZ6RGJVcGdqNm5MdEFjdTRm?=
 =?utf-8?B?VzFNZWxTZkQwL3RzVmpPekYxVUxjSXR1d3pPbUhxY3IvUzcxT21xeVFUWkRS?=
 =?utf-8?B?cTc4b244ck0xZjErTnQ1RjlkRjBDRVF1ZGxJQUx4VkdKMU9vak1xenFzM1gx?=
 =?utf-8?B?V3R5ZnFHVkRIOGcraTRvN2ZOYkZlZ2tBSmdwK3YwajNNakk2L1pualBZaTdB?=
 =?utf-8?B?cXFWMzA5eUxPbTV6cXVhcERJWkYxbmIvT1NwU0I2aldFcFFjakRBZU9mcFdo?=
 =?utf-8?B?QzZGK2NTclptZzVCSk9YRW5sNVNzaTdRakpraTFYN0ZUMGNWeGk4UDhVTmhn?=
 =?utf-8?B?OWsyTHR2MFJTTDd6L0NOV0xvbnQvaDJJaGNtdkp4TFNKKzlRTFJEbHIxMmFl?=
 =?utf-8?B?SDQzdkFLS05ucEl6OUZRaWZCcjBqWW5QSE5ndjg2eWwvdmJiaGFqVmU1QmxD?=
 =?utf-8?B?T3MrNTB2TklqRWZwYnNtUGVSK1JVK284YXFnSnpoRStwTVQ3dTRwYSttOUYv?=
 =?utf-8?B?OStmKzU1THA0eE5rSEwrWFBkaW9PS25UQTQzUjNwaTJrS2hnbDllUEU0Nm9s?=
 =?utf-8?B?d2kwbmsrZlJpdnRtZDBjNnNHb3MrdG1FZmIvTzFZbFlKdTNBUFZZbkhvWUdw?=
 =?utf-8?B?RDg4NkR6R0lESmZ4Mk5weW9OcHV4aXBwWTY4OVluWkRPd0JqSUl3bXNHU3pX?=
 =?utf-8?B?ZmtOeWpUalFkdzJOWFlkdzNuZkt3UXpXYldMY2F2Q0VSTkFuMHFoM1dnTS9m?=
 =?utf-8?Q?k81ulA3uOsnuMDkK0t8HHEmOy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31776b81-be78-445d-acc7-08dd6b999c07
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 12:36:05.1341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVvFaSrm/atT7a5OYtfjZkPQZJ5ejbDbBSc3DYnaoaa4vunCzeQxEwOWEBuAgZKcN9jt/wHgwqlUWV4vkXmvrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446


On 3/24/2025 8:59 PM, Arnd Bergmann wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Mon, Mar 24, 2025, at 15:58, Akshay Gupta wrote:
>
>>   struct apml_message {
>>        /*
>>         * [0]...[3] mailbox 32bit input
>> +      *           cpuid,
>> +      * [4][5] cpuid: thread
>> +      * [6] cpuid: ext function & read eax/ebx or ecx/edx
>> +      *      [7:0] -> bits [7:4] -> ext function &
>> +      *      bit [0] read eax/ebx or ecx/edx
>>         * [7] read/write functionality
>>         */
>>        union {
>> +             __u64 cpu_msr_in;
>>                __u32 mb_in[2];
>>                __u8 reg_in[8];
>>        } data_in;
> This changes the alignment of the structure and makes
> it incompatible between 32-bit and 64-bit userspace
> when there is an odd number of 32-bit words in it.
>
>        Arnd
Ack, I will add explicit padding of __u32 padding[2] in the end in the 
structure.

