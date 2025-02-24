Return-Path: <linux-kernel+bounces-530060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D63E4A42E45
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2321A188CB36
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3023245026;
	Mon, 24 Feb 2025 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GepeN1xN"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284C1DDC37;
	Mon, 24 Feb 2025 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430168; cv=fail; b=SW83mgnQsC1k4CKA/bOpoCDq8CsW0AbViMNeWxSu1B2YZf1WHWp27Rj0KZK89//QLGEjwux6NjWP9Ov+3GcOg+2dd2geOq3Q+ufN/lWL2SFF0oEDJArmOBF/eXuS6WQa//GSz1GoajZza+DL6Gqoppkl/bpNMbnf6BxibZ6sOV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430168; c=relaxed/simple;
	bh=ZGwsGLrKA6F+8zABP/qPgd+SjVHWznfeQoKws7hzSUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mIflQRgcahekLw2uNlLFtyUFTGi3ZFpqaHg9zmv2vynfBSHCP9hcjjcHFG9H7DnmkCk+EKJF3Spi0R67MP/v29a07Z1BicxHHpIaqlZ4FEAo1AxdDgAQ1yMDiaq9+nnru9PYFVfilJsnUUvIdY8gLd0HGg8HBLc+C/McQKDll9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GepeN1xN; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtmioM6/id6kE/40u7OlEqEY8M1U6Q5NrKUh9RrPl2hWD8swfr4CiGO0lcpmvrlrSeiTebIfWUT3DCU8DRqmOM5Ym9FM8vFzI2n5WTWlzWKWSXM8uFWy+7EbLfMVVF5wCI1lqls6MOmPTxA16yfw3Wa7rkcsA/y3ZF+83F/kAyS4lQVakcuiLuwusrCMyLJKIOuPqWzW25jsgxk5IQPlVNRYAmrkQqg6Q2UFrlWeeRlrTS54yDZIJ51o9f4inKiOFKrMKMSXt0keY3Z9oskEqB/058h3wRww7GfqcamRgg3fKEn4VCL3CEyaHtvyljnfu/gHuHUXtHydIG9Mt7Nu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOgB9WmTswSbO3Nky37d2VT+5B7JJxZZKrkSkkZBpyI=;
 b=gh4doYzHT62WtHy5/QWRI3l+TEgVxiroTs/YCDtg6Mlv9HQEpeS+J4CxwME6xi98m6+UQj0P1/eSLabVSqGyhwuGfETsGvs3W7XqWJ0aEevGxQlfEnaA+UemOQ8f7sE6wxlYP8OSTwqOz04jmEPcr0iJf4CIoAYjRIbeadi/t5SkRbjFF3k7+1xN8fmGGLD59sAwPJzbh4s5X2HFsTd0dbVixPR1L7a66H6w2X1Kr4CM2wVE573ZI9cvQSUEznR7Z17WlUNTWAsZBwkUT8FQFMuRsIxVAuCOMpaFLraNgGgRnmXosywONXgYrUZeR+IARlaFboMqAYJjdfiZ86pr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOgB9WmTswSbO3Nky37d2VT+5B7JJxZZKrkSkkZBpyI=;
 b=GepeN1xNo/JBAIp4hY6XdlVYSv+8W2AlUufavi5ygm/uBsI4rI05p+28UNi+tKnAs+eo4ttRQHQlu/d09yONmssgX+zgQD8Zn+o85qpMIyhwikoL0Mo30AcHQGLl/xSGLFm6AqlWiWNC4ADLgLwXcG7eVHGQ7/9u1y9BOxvPjw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 20:49:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 20:49:19 +0000
Message-ID: <f51e9718-df4a-4a94-811c-24f56fca696a@amd.com>
Date: Mon, 24 Feb 2025 14:49:15 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 23/23] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: James Morse <james.morse@arm.com>, corbet@lwn.net,
 reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, tony.luck@intel.com,
 peternewman@google.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, jpoimboe@kernel.org, perry.yuan@amd.com,
 sandipan.das@amd.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 seanjc@google.com, xin3.li@intel.com, andrew.cooper3@citrix.com,
 ebiggers@google.com, mario.limonciello@amd.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <fe1c0c4cebd353ccb3e588d7ea2fe9ef3dff0ef2.1737577229.git.babu.moger@amd.com>
 <8f783170-feb4-4819-bbdc-cdf0a7c25dd0@arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8f783170-feb4-4819-bbdc-cdf0a7c25dd0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0090.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df8f302-8229-4a23-afd0-08dd5514b589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTN0bXV5bUI3QVBaZ3p6OUU1RFEwTFdZM1RDTjdtSEJuNFNFMDJsY3VESHU5?=
 =?utf-8?B?eGI2TXRsUXVFYk45b0lTN0NESVBlVUVtcVcyaFpVK2srYkJCVEYzTXBQTU5h?=
 =?utf-8?B?YU4yR0ZEeFJxa1Byc3RxUmlhUGgvUDltVElZelhVTVphMlE1TS8xQTk5cWdX?=
 =?utf-8?B?OVpOejdFeHh0eWIxcWV6RC9HZDRBclorYmpIK09saGdXZEtnMWJwckRiOVVV?=
 =?utf-8?B?UFBEd0F3YktzRGRwenZTc0t3VnFMUDFMYXkzeHZocHB3MktTWWtNTkNhNDNN?=
 =?utf-8?B?UnNLa1dZVElTVzN4c3BBcWRPS0p1RWJVRnBNRlZ5S21tR3lvRkJRSUY3YkpX?=
 =?utf-8?B?amhvTU9HK0Rsb1k3YTRFQ1dQSndpZWQraTJkQmFPbkwzMjM1a0hzSFdlVmZy?=
 =?utf-8?B?RUxNVjF3US9XNmtRY2hLUnYva2tWYUorTXlEVkE0RklXODlpbXBBTUZETEUx?=
 =?utf-8?B?eStIeWJzcHZmeElEMmphbXZMbEVzNXZ5bU5XK3NUVUFIMTB3L0FkYk1XUmh3?=
 =?utf-8?B?SW1wZGRKTUpSMG80VHRVOUVLOVdZMHNQWHNqb2pVNWZXcUt3Q1FkeUIvZWtG?=
 =?utf-8?B?UE5OR2JvdmMxcjFZdTRNcENvd05Qd1ZNaHUrMHdXbDI0TCtaR1BKREJQRWtl?=
 =?utf-8?B?VmYvQ1ZNMFNVSmVGSURLUGZtR2NnVkxTb2dvc3ZqSi8xOVJ2aUNOc2o3bnhq?=
 =?utf-8?B?OHpvTDFzR2Vybzd4SVZoRTZ2aW56Q1Jna2pCeCtNOUVqQ3l2bXdxNEJQcTB3?=
 =?utf-8?B?UHVDTnpDTTJGZkVRQ1d0eXhzbVNvaWZVcjEyNXVIcC9jb0M4QjF1YWFSZmNW?=
 =?utf-8?B?dmIraCtiWGszbDA1cUhEdVA5cUN5VDNMcjJSOUw3dG13WDV6dUpkbU51Vitm?=
 =?utf-8?B?ZDVpcFloSzBURlIxSkVvanAwM3NKUk4xWGNzNlhpVGdZRFRLSUJ3VkpTLzh5?=
 =?utf-8?B?K0ZZVE5NejE5eXVRZVlITE42YUhUamYxby8wL3lWMXNTeFhBYmlIRHdtdVNO?=
 =?utf-8?B?OHVEbmgrVlNYL1daODhZZUZyMUFTT3oyRmxLYzczWkZaODFzeDQycnNtVDJm?=
 =?utf-8?B?TFpLWjRWWTVZbGFMUWxwaTNTWTljZ0ZsMDQrb1h0YTc1aElZa1krcjBMYVlU?=
 =?utf-8?B?ZUlXWmFNc0kvUlZPaEJneVRDUlMzOCtsR2Y4TUdwbDNCM21TOFZTSEtiVHZN?=
 =?utf-8?B?T2thZHZjczRhM2JtOVIrZ3JGcm1pUHJCWjVZbllydXNpakhlc1RNNDhUdXNI?=
 =?utf-8?B?VzMwL2cxUUpGTGZQa0JlQW5YVXdESVJzQmI3bmhSUXh4MitzVGE3T0ZUUXZX?=
 =?utf-8?B?RXk3aHBYcVZEL3kwYWJ6NkhOMGJpcUpwSGJVUzJjK2duTDR1S1pkL1V5c0xG?=
 =?utf-8?B?c2hGbkNRbVJVWjJMdDFOSHBYTWI0Tzh5bWNhdHRjdnJsMTJNK1I5SnZoMk1W?=
 =?utf-8?B?OWhnOEhYVyt0TDlod2pubHpVamdDYnZwYk9USDNSQkpyNHFlV3lDMFF0YnpJ?=
 =?utf-8?B?YWZicFVoaDNaNFpYRjVlWTRUb3IxRHc4cFpVRUNUKzhOMUwvZlcwTXpZODBr?=
 =?utf-8?B?U2tHR2VTK0ZqZVc1enhaelpBZ3FuNEVwZDBPT3RaSTFlb1BvN2VnRG10K2Zl?=
 =?utf-8?B?dHhWYkN5MzhIYzBQTzY1ODZYWTMzVEZLSzRIUXhHWmhJWWIxSitUVGJaam5y?=
 =?utf-8?B?RDl6YUZUZDlLOHQ1NlhZOUNQdWZoL0pyeEw0czY2enVhOGlDZnNaTFh6TE1n?=
 =?utf-8?B?cDdOMGY4dnVvVHdOOE5ZdHVzUWEyMTJmZVh0YWhzNE9tYnVzVE81UDAwOFp6?=
 =?utf-8?B?cmxKYStURFg2Ly9QZzBXYm1aRk1SbEtlWmVhb3gwcldZZTJiREplQk0zVW5C?=
 =?utf-8?Q?mWiWcrlMAW8SE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHo2RVNGR3dGRU5EVVFCd0MwYW1iVHkyQVFEOWJNd2hOUnordGJQN095SnpI?=
 =?utf-8?B?NlBTY0FHWjh0Yk5sM0x4KzNqMm5lYXF3VDB5S3VyQmkxRFRUencwUS9ZUlRv?=
 =?utf-8?B?SzVuOUIrcEM5SWRDREdvWXNPMGJJbWJUT08vUko4WHVtcDgzbEJ6ZEhwNHds?=
 =?utf-8?B?dFRXUlJkWVllSHdQV1RYeXk3cW5Wc3ZyUmU3SmNjcGhNVkpCTUZVVGJrOGNZ?=
 =?utf-8?B?YXhWeURzR2ZFZEJJM0lFMWNYZTZBazVGWTB5bjlyUHhyRWtESG5YQlB6dytk?=
 =?utf-8?B?SmVLMkxURmFoRERkbTcrY2VrZHFXaWFNZk9RRFRzbmN3QTR3UkZMdWJtOFhm?=
 =?utf-8?B?RjJQVGszazhHQkRlbDZ5YXBqSUhsR3ZHWVRLODYxeEwwQmVVZG9oQ3RERVZq?=
 =?utf-8?B?K091MlR5ZWs5UnFrT3FlNk9DS2hJQW83QzZLWTdxR2VhcHEvRFJwRG1GbnJH?=
 =?utf-8?B?ZFBsblN3TVIveTJha2VFOGxWYUNhdDZ2WnAyUmFDUjc0RlV6LzdHdzUvc3R3?=
 =?utf-8?B?TjdzYkR5QTlaaXB0V3RINW5JRjcrTGw2YlhNOHByUjR6YUJTbllHdUx4eUhu?=
 =?utf-8?B?QWtpQ2E3NzBGbndFcEpLeGVXaFFmdmlBQU10Qmw2cDloS3hycTZtSFVneGEw?=
 =?utf-8?B?REg4eWk4QTNMQStQQURFUENJZkRSWWJZbmZQMHY1NUl1MXppMlVrTDlMWEY2?=
 =?utf-8?B?UEhUa1I4N2hweXkrem1xakFiSWtmam41MkplWjdxSWIvZUJtQ012ZU1sM1Rr?=
 =?utf-8?B?OFVyVk50bmFhWHBQVWk0RUI3MW9nK0dzYmdxY1BFRlZvcjg0U3IvSysrcFNa?=
 =?utf-8?B?RFoxbURRclNINm9VRkVnMzlLWEwyQUx5V29MTTNvQmZnUW85YVBHY0ttUUd2?=
 =?utf-8?B?MzEzelBzOUVENHQwVFlSZEFlS2JERkkxS0RRWnFaVG1pbFlPRVMzZXVEcEVh?=
 =?utf-8?B?UEJtSUxNNWpXOG5TWmM4M1cvMWs5UnJOTkU1RUpLNm5HSXprWER2alB0c0U2?=
 =?utf-8?B?RjBIVjBkcnZ3OXhaT2JOaTUwUU9kUDRRMkh6UG1ZenlLTkF3NWVpQTdsREp0?=
 =?utf-8?B?TzhwYXdkQTc5SkJnUGk3S1Y2N0Zabm1vcTYwenViaWk4RExNa3dIbVhRbkdJ?=
 =?utf-8?B?OTlyUEhmaUswaWM5R1IydERDaFNIZ01IVVpIdXpVVDVMckFlS2ErOW1XQ1JW?=
 =?utf-8?B?T2FpcXdXRXA0R3BtQzBNMUZBVnJaVUNOSmJEVTB2dmlFWFVtc3prMzVpR01L?=
 =?utf-8?B?RGZOdzNndmo5RkdycUtMMXBubVFWczVhNG9oSVFFVjNBcUVac1k3SjluZzhr?=
 =?utf-8?B?WGJ4TXZQODROcTJ3eGYzM1p0a0dJTkZxcFIyQ0gwSmRnTUV1cGw1SjUvUGlG?=
 =?utf-8?B?S3NnNlBSV1VlRDJLRDJ2RStvSmszSUhQVXNXQWpIeGZsMW4zMmJQTDJweDZW?=
 =?utf-8?B?SmtxSEx1bzZVWnFVZ2RQdE1BMWNrMWZGWDMxNThaNmUxYVRvQ0ZGclp6cEwx?=
 =?utf-8?B?VkpyZ3hBZWVHTWV4bVJiYlV1b2s1b212K3FTMEpYK1EyejFkclR3ZmJlUEh1?=
 =?utf-8?B?VkVLYjM5cHlvM1lEbEx6MnJndnVsZ1pPZFg0R1EzbG5Xd3F6Yk9uTlpXQ3hw?=
 =?utf-8?B?enA2L09IeTFWN291L0FRS2kvUWpNUk9SeThJQ1ozQ0VWb2NIMDNxclhuNVlW?=
 =?utf-8?B?Uk5OeHZ5QVhHZ2lNYWpCbVpFOVJrUHJnTHVsUnhhYlBUWnYzRXdLSVRRNXd3?=
 =?utf-8?B?cUZTUGlvYWpKSTNCSjIwT056SWRZS0NrOEM1akNiREZoWHRBY0JqVTFXL2JL?=
 =?utf-8?B?VllFUnlUdHhDamdoNHQ1aHV3bUlCaC9jOHdvSk5XNUFnWHkyZGNnTit4MGpo?=
 =?utf-8?B?bXZrWmVvTlFQcWVMbTFCN2ZUU28zNlQvb1pTNmorN29CR0xmamM2M1NZam5H?=
 =?utf-8?B?cG5vejl4MVNDdVNBYTNkVFhSOUUxc0tXbDllM1Y3cmg0RVRQRytzbFpxMlZp?=
 =?utf-8?B?dndSdnNzRkRuSEhWVDd0TVRaODMzR09CRzlBSVdPVjVqaHlGY0YwSlVobEg2?=
 =?utf-8?B?cndQT05kOUZVN2c0UEpvMm9XVkk2VEE5cVdSbng5T0JodVRMWjZhdVZyb3ZQ?=
 =?utf-8?Q?hoFU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df8f302-8229-4a23-afd0-08dd5514b589
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:49:19.2095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0/DDw26S13PJTaZtSLzfP05JO2KP1uFSLcR4fNmHC8MYMIvaWN1NtT7j63OIBTC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488

Hi James,

On 2/21/25 12:07, James Morse wrote:
> Hi Babu,
> 
> On 22/01/2025 20:20, Babu Moger wrote:
>> When mbm_cntr_assign mode is enabled, users can designate which of the MBM
>> events in the CTRL_MON or MON groups should have counters assigned.
>>
>> Provide an interface for assigning MBM events by writing to the file:
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control. Using this interface,
>> events can be assigned or unassigned as needed.
>>
>> Format is similar to the list format with addition of opcode for the
>> assignment operation.
>>  "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>>
>> Format for specific type of groups:
>>
>>  * Default CTRL_MON group:
>>          "//<domain_id><opcode><flags>"
>>
>>  * Non-default CTRL_MON group:
>>          "<CTRL_MON group>//<domain_id><opcode><flags>"
>>
>>  * Child MON group of default CTRL_MON group:
>>          "/<MON group>/<domain_id><opcode><flags>"
>>
>>  * Child MON group of non-default CTRL_MON group:
>>          "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>>
>> Domain_id '*' will apply the flags on all the domains.
>>
>> Opcode can be one of the following:
>>
>>  = Update the assignment to match the flags
>>  + Assign a new MBM event without impacting existing assignments.
>>  - Unassign a MBM event from currently assigned events.
>>
>> Assignment flags can be one of the following:
>>  t  MBM total event
>>  l  MBM local event
>>  tl Both total and local MBM events
>>  _  None of the MBM events. Valid only with '=' opcode. This flag cannot
>>     be combined with other flags.
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 6e29827239e0..299839bcf23f 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1050,6 +1050,244 @@ static int resctrl_mbm_assign_control_show(struct kernfs_open_file *of,
> 
>> +static int resctrl_process_flags(struct rdt_resource *r,
>> +				 enum rdt_group_type rtype,
>> +				 char *p_grp, char *c_grp, char *tok)
>> +{
>> +	unsigned int op, mon_state, assign_state, unassign_state;
>> +	char *dom_str, *id_str, *op_str;
>> +	struct rdt_mon_domain *d;
>> +	unsigned long dom_id = 0;
>> +	struct rdtgroup *rdtgrp;
>> +	char domain[10];
>> +	bool found;
>> +	int ret;
>> +
>> +	rdtgrp = rdtgroup_find_grp_by_name(rtype, p_grp, c_grp);
>> +
>> +	if (!rdtgrp) {
>> +		rdt_last_cmd_puts("Not a valid resctrl group\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +next:
>> +	if (!tok || tok[0] == '\0')
>> +		return 0;
>> +
>> +	/* Start processing the strings for each domain */
>> +	dom_str = strim(strsep(&tok, ";"));
>> +
>> +	op_str = strpbrk(dom_str, "=+-");
>> +
>> +	if (op_str) {
>> +		op = *op_str;
>> +	} else {
>> +		rdt_last_cmd_puts("Missing operation =, +, - character\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	id_str = strsep(&dom_str, "=+-");
>> +
>> +	/* Check for domain id '*' which means all domains */
>> +	if (id_str && *id_str == '*') {
>> +		d = NULL;
>> +		goto check_state;
>> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
>> +		rdt_last_cmd_puts("Missing domain id\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Verify if the dom_id is valid */
>> +	found = false;
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +		if (d->hdr.id == dom_id) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!found) {
>> +		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +check_state:
>> +	mon_state = resctrl_str_to_mon_state(dom_str);
>> +
>> +	if (mon_state == ASSIGN_INVALID) {
>> +		rdt_last_cmd_puts("Invalid assign flag\n");
>> +		goto out_fail;
>> +	}
>> +
>> +	assign_state = 0;
>> +	unassign_state = 0;
>> +
>> +	switch (op) {
>> +	case '+':
>> +		if (mon_state == ASSIGN_NONE) {
>> +			rdt_last_cmd_puts("Invalid assign opcode\n");
>> +			goto out_fail;
>> +		}
>> +		assign_state = mon_state;
>> +		break;
>> +	case '-':
>> +		if (mon_state == ASSIGN_NONE) {
>> +			rdt_last_cmd_puts("Invalid assign opcode\n");
>> +			goto out_fail;
>> +		}
>> +		unassign_state = mon_state;
>> +		break;
>> +	case '=':
>> +		assign_state = mon_state;
>> +		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
>> +		break;
>> +	default:
>> +		break;
>> +	}
> 
> 
>> +	if (unassign_state & ASSIGN_TOTAL) {
>> +		ret = resctrl_unassign_cntr_event(r, d, rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	if (unassign_state & ASSIGN_LOCAL) {
>> +		ret = resctrl_unassign_cntr_event(r, d, rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	if (assign_state & ASSIGN_TOTAL) {
>> +		ret = resctrl_assign_cntr_event(r, d, rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	if (assign_state & ASSIGN_LOCAL) {
>> +		ret = resctrl_assign_cntr_event(r, d, rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
> 
> This sequence of if's allows the helpers to be called on platforms that doesn't support
> both local and total. Could we reject such misconfiguration here in the parsing code?
> You have these checks in rdtgroup_assign_cntrs() added in patch 17.
> 

Yes. Added the check is_mbm_total_enabled() and is_mbm_local_enabled().

> 
> What do you think to trying to group these four by event type, and passing the event type
> in as an argument? ... it ends up with a helper that takes a large number of arguments,
> (both assign_state and unassign_state), but there is less repetition...

Added a new helper function resctrl_process_cntr_event(). I could not
avoid the repetitions.



> 
> 
> Thanks,
> 
> James
> 
>> +	goto next;
>> +
>> +out_fail:
>> +	sprintf(domain, d ? "%ld" : "*", dom_id);
>> +
>> +	rdt_last_cmd_printf("Assign operation '%s%c%s' failed on the group %s/%s/\n",
>> +			    domain, op, dom_str, p_grp, c_grp);
>> +
>> +	return -EINVAL;
>> +}
>> +
> 

-- 
Thanks
Babu Moger

