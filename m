Return-Path: <linux-kernel+bounces-559097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEDEA5EF80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FBE19C0AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ED0263F36;
	Thu, 13 Mar 2025 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ag6ArM8z"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CC2263C7C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857923; cv=fail; b=k4jX8TorGZASoRfXMZB/zkTLPOEoyjAvMQru1SiZw68M/5uLyQ6WVyXD8BjFRnnAYngCJ1lQWG8aaRpkgKRZDlY/Qu7UNfe0SGnu1dOi7GqM53hYK0HwUJcHz6+T/a/HLOI8/FDQ7pdI7V1njP73vFGVsDRRN8HX3avYnLnN9uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857923; c=relaxed/simple;
	bh=ZfALC+loJEOjk47ZjRBf2ljKPU2zTc2UF/2V/TlHIeo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UqduzbZGapaB3Tt0lMeMriidjskLR9xbSRi7JaFHLPG9o+Bpj+CFtiE61oN0jW5xD5BJwW6WR1zPvWhGlOu6Lthblu06wnBAUcQueHEz9fDgQwGAhjzJdahr8IWEfIAGXUTALsxn7YbJJwQkgBDIlG0B73hLmp6EwF/ZI+ZJWmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ag6ArM8z; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAqKencPlGjlavZ/aqKM3W8sddBGBKAFP8ynkmfq24br0Uv8iqRy/E+5ud6VJz3sZtzuDcw2TsEeoaEbD2QG6uPInimgBIwSkQgkZ8JfnhqRlCMKRNtQXnbcaHpIS7AfMe9AzmuUb9sw3GjLvGRJfYnMto32zl5x+xtBhS7WPy2mJ8ZYWLM4ms6daeJon7YoYMy1lhL2HIE0QyWdghyiXVJPFA/OffezshIDvAAse31p4XnbmYLy4Fh5QP5NI/6ruJ3mT4BvISgfM/rzzepLuMmj8BeaSdyt4X7Jj332WRFe0x7g+dPtN4USUkMGrBV3c7m3RWN3VdFZQveIXUO4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHKad5Z6OCdrSG4L0FXZ+TwjYsm4+ba9pDNAVSxff8M=;
 b=JTCT+epiTJpXGMXasWaZYVP73fhRHqvj3vWbJnXR7K4HANQ8HIRc8IbKCHuF/4Z4r/b2b1W+UmWyQoWMFRd4Fy/ZmcvFB4X8wYfm9iB3BeWbaq5bjVihaehAUaSmSCcqL4tQAYbIiYjvAKnlzMzDfmZG9+7nDkC/DsuUdUrjAZiJFcfH8KcCaZUhcfREQ3OhW8WDl5MJ+Fi2VU4ghL6M1oUYZm7WOtuHQEoDcf6w/KbaVHvX/XXX3R1OC8/4UuPzVdyotNwZUIi5Ix/SRT2anNL9j2RhdQnba8gCY8AWdmDYLDmsW5CJ76jHMQOeE35mZLNVTl+OUFYMiHVJbwCP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHKad5Z6OCdrSG4L0FXZ+TwjYsm4+ba9pDNAVSxff8M=;
 b=Ag6ArM8z9BoPx6JL1lwyE4XaNID9kP3ilkjFQUWloOsXPp3/YFSwJOi2oZoakBoChgfPfLPVfaRBLZAZXpQS5OUQUVkqYBZvS3bYOqQS2IngwyUVZKEOZryBKEXG/eGnhVoEo6sNOWvy9js0bgCyHCLoqV9+a6qXa2a5HWGtn+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by DS7PR12MB9528.namprd12.prod.outlook.com (2603:10b6:8:252::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 09:25:17 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 09:25:17 +0000
Message-ID: <270daefd-22a6-9359-edcb-c514644cfe4f@amd.com>
Date: Thu, 13 Mar 2025 14:55:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 2/2] dt-bindings: add device tree binding for silex
 multipk
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: praveen.jain@amd.com, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
 srivatsa@csail.mit.edu, code@tyhicks.com, ptsm@linux.microsoft.com
References: <20250312095421.1839220-1-nipun.gupta@amd.com>
 <20250312095421.1839220-2-nipun.gupta@amd.com>
 <37707900-9162-43f2-b89b-3e1fec514daf@kernel.org>
From: "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <37707900-9162-43f2-b89b-3e1fec514daf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::17) To CH3PR12MB9193.namprd12.prod.outlook.com
 (2603:10b6:610:195::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9193:EE_|DS7PR12MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9f45bb-d3e5-4fad-17a5-08dd6210f7c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG5aTkNlOEducW1KRWZwNVpPUDViazh5cE9DaFMxdjZSNVZ6SFRPV0Qwd25K?=
 =?utf-8?B?bENoT3dSbElJbFltNHJ4SFJmUStETTM3Vktta0N6Zy9oUUk0R1ZZM0g4MVVW?=
 =?utf-8?B?aE9yUktndTlCbW1wTUtIeER6VTVSbVdwVGMyeGhQRGxoejJONmFZdVlIUUdO?=
 =?utf-8?B?YWhFWkpUemVqK3FuOHd6c1lTb2ZRb1ZNTzdYSXJlaHh2SDdJRmlNWnV4S08r?=
 =?utf-8?B?L0tDdXRSQWxYVnU1OTFpQkFpS3ROam16MDhIQWRlem81eTZCeXNDZ3I0a2VP?=
 =?utf-8?B?VThlc282Qnl1T0s1ZTNJZ0ZiNEpoam8zMkR6M0pvcXRNQ2p4bldKTDZsN3pD?=
 =?utf-8?B?NWpYak9nVEF2SWNqNDRRS3R0ajd5Yk5TcnovUlhKU1VkZzZmRVFRNDd6N0Vj?=
 =?utf-8?B?c3JsMnFPMUNnVEIrU1hIWm5KZmRmdGdzRjFHMVJrWGcrVlZoZk1kMnc3eGFN?=
 =?utf-8?B?WWN3RU5PVlRGZU1FQ0FudVJUbFRYVThNTDdpTzZyMkpOR2FjUlgvdlBSNEZn?=
 =?utf-8?B?bXllS3VSa28rREVBeGlGZVJ3VU82cDFLcEZSaStKTkNvZm4yOGlJVGxNRFp2?=
 =?utf-8?B?K0JkNFFqRXdYeUg1enY2WlJxMHEwc2prUWgrWmNjWENRc1B4UTZlaUFObjdO?=
 =?utf-8?B?bGJzcEFsMHoxSWRmbkdzMVFRT3l5UjlHdGd0RFgwQ0dwTEc0SGYyQmNMZWZx?=
 =?utf-8?B?MUNyNWo4ZEcwTmhHQnJuTy8yUnhLWGF2YlZLTkxpa1RITTNPVFh4UjRHNWZa?=
 =?utf-8?B?VVE2dmF5c1czOFBjdEFmRnNiYzBqS29JWXFTbng2QklUdnZrKzd0S1k2c1Zs?=
 =?utf-8?B?dVFQQ05meDlmNGdpMk12aVZUMHY5WmxlMUJ5N1NNSCtqcjNINkhoSUljdjBT?=
 =?utf-8?B?bUtMTVVoTVlSVXRQZ2xaRnI5TXRBU01IV21NQk5hd1lSSjdqWXd4OUZ6amRY?=
 =?utf-8?B?d3VVdW1WMTRuTjFIL1FIcUtCWk5RTytIZGNOWFlIR0hnVnd0ZUFCUS9BUG5V?=
 =?utf-8?B?ZmVwdTY5RXhHTmdHMUV4SkJvTGxBRnJrUzhGVmZqSmtFdEFWcXdQTENSWG40?=
 =?utf-8?B?SnM5Nno5Vml1d0s4WStTakRZdUFOT1lnU0wrWDkvaCtTU1pFdkY0dWRvSjdQ?=
 =?utf-8?B?UXhrbS9qRHhnd3l1SVlBb3R2WkhxR2RyZjBhQ2VhRTQwdVU1UW8vWEV3WG1l?=
 =?utf-8?B?ZEh0aVlRaGxRSnU4aTJmVnJpUCtIV0E5eVp3VDlzUzdqV3pRcjdBdkJKOFgx?=
 =?utf-8?B?K0k5ajVRNjhLR3JrUzFGKytlU09KdFJkcmhsVkJIanRPRjlZcFhxNGRLK3Q4?=
 =?utf-8?B?UEhObUVUSHlLNGgwejNVcXp3VUJxTHZ4SEs3dllSOGRhUzdTamFWd1pHNlBB?=
 =?utf-8?B?Ym9NR2h3bDIrUDJMenkyNGhHQzFlVzR3ODAxYk9TK0l4MURSNFl4eFFUYjhj?=
 =?utf-8?B?N0xTUUJTSWM5SXNSTERMWFJ5dURyT3A0QnNIWUtGa0ZpZloyZnJlcFNtQ1BL?=
 =?utf-8?B?KzVma0grUXlCaklaVCsvS1lvUzBQNzVwT2QwdlEzRUNCZEZuRGtvbDg4ZEEw?=
 =?utf-8?B?Vjl1MkRxeXUwWnR1eGNNcUgyVHQvSysvWWQ3Q0pDc2lJQ3g5TzBzTno5Sito?=
 =?utf-8?B?NzJ2dkNUbXBiSE0wa2UzTXRpN0tML0tyTGswNFQ1dFlYaTVVK25JOEl6Ujlu?=
 =?utf-8?B?MjFoSHUrZGY0cUpIWHMyUkJReVAwb3M5QTNnRVNhR0FsNnRTM3lESHRMS1V5?=
 =?utf-8?B?SmRDZ1U0VldCUHFBdVNROG02SVZGZTYzOUcwc0JDUW1mZUJNTDdob1M2RE8y?=
 =?utf-8?B?WjA0Z1ljMW91MkE0Y2d5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZThwVC8vVjhjQmFFRE9tdFhaS3phTkxTTm85TjI1Wkt0TFdPY25RYjlBTHNy?=
 =?utf-8?B?V2sydHFNQ0MrSnBOdDRyWWZPd0tPb0wwYmd2YTcvU2RTb1FvZTFibGpvcDhp?=
 =?utf-8?B?dlJ3VEtvSWxIakNEVFRWSFJmUTJ0UytWT1EyODVKWFMwaUo3VERJckdOWlZw?=
 =?utf-8?B?dXYxclUvaS9hQkhMWWk2ZmtQeVp3WW0raWpwV3A2ZnpjZE9VQnBrSThOWW5T?=
 =?utf-8?B?dUV0andqUmhlSFliMTVHbkxvSnY3VzJWNFdRV2JSa2IvbUg0WlZkNHpqYWd2?=
 =?utf-8?B?NEpRSEdXNEcwR3JrOWZTUy9Oc2xsSHdVUTNrUmxtMHA5R2FINDRjdVZiUll2?=
 =?utf-8?B?MW1LaW4xOW1JRkI1dkg0Yll5NnJxdFJRVEh4L1Q4a0FEdXErOHd0dUJTOFA2?=
 =?utf-8?B?UzgyVG9rZ2dqVy8vRTJGWWtkOGRpeE9wNWdTYm50WmE0V3p2ZGNsRTVWdllV?=
 =?utf-8?B?NFRobTRLVGJCalpZNVEyWk82SkN6QXV5b05aSEVaTlRLczZyZzZDVmFmYkFw?=
 =?utf-8?B?YlV3NFRoeFhNc25wM1pvemxCWFlJSFNkbU85dFpaVmRHenJ6UHRpK0tTN3Nv?=
 =?utf-8?B?a2s5Z2xpcllONWpseW9qbThWeUpnS0UveXdYOGlDdXpWcWZvNDQ5SzdwTnRo?=
 =?utf-8?B?YlptRU5RUzBQNTdUZGdGNzVBTXk3NFZFdUJkSXlGSHpDejAxUVErRmFab28x?=
 =?utf-8?B?NzE3ejk1N2VHWXFDL3NYd0hxTzZ6UFYrUmhPVWFuRjBGUUhzcVZlUStQZ005?=
 =?utf-8?B?clNpRmFQcURwUm5UK1R6eEJWVzF6b2gvcGpydEZsOU9HQU1kMnJ4RmdXa2NQ?=
 =?utf-8?B?cmMvbXNxL3l0bmdEVU15QVhoV1RhZHZ6VFlFWW03Zjd1MWI1VUFSMmlFV1d2?=
 =?utf-8?B?VGlnQXd1NkVxTDZSdU1MdEZQR0pSamxqZlVUcnpTQnE2UG1aRUcra1B2TDZP?=
 =?utf-8?B?UG1JK3cxeUloOG1oQllsWU9FUHRpL2plekZhZkc2VVF4MmRubkhzbkk1UEp3?=
 =?utf-8?B?dVpIekpLb3IySzV4UmRwakd4TzlkSzZqZzF0T29WUnFudmtVMUE1aDlmK3Zn?=
 =?utf-8?B?eWMwaEtWVGoyaS9YYmZQZkRFOGQyN3l0NDU4a1hIQUxYL0liTVhaQ3dvS1Q1?=
 =?utf-8?B?cWJ2Q2NnQi9oWXZkWEd4Yk1lcS9kRTI5a3E5a2dERHpWZG42UURNKzIrMDZK?=
 =?utf-8?B?TDhmN0RFdDlyN1hScnBwY0ltbEFoZkFpY3RlRWxTM0V6MFVVamp1L3pkMTUz?=
 =?utf-8?B?MGxDeVNPL1pvVk1PZ012SU9LeG5YaU0rc1N0ajBZMFMvSmVkaGxWdWJLUVhk?=
 =?utf-8?B?N3dkelFucWtFQU5NVWdPRGdNc0NqRmRxMnpFMVdWRDV2ZnE4elVtbnFPYjIz?=
 =?utf-8?B?SklHRjhCSjU4dUZteHdpVXdmVXA2a3FobC85d2JFc00wSmRyNlJFSnpoOWxr?=
 =?utf-8?B?U3ArR05PMXZxK3dIMW9ramN4bDdUZ0t2d0dVeHdqZlBBQk5zVXc4N3Y0SzRy?=
 =?utf-8?B?djRoZWcrR1RELzVabkdEbXF4R0pic3VHa2RHRlNuNk9JMllVQVR5RHplS2VI?=
 =?utf-8?B?b1M2RTN1OWw1c25STHA0bUIwaW9YdVl2L2JxR2IyRS92ZjV5MDVtS3llVWlh?=
 =?utf-8?B?c0R3RkFLQjE2WktSVzNSck5ISmdUa0MxblVsNDZlQU84dkIyRGovUzNuMHVv?=
 =?utf-8?B?MXF1RW5CNVYxVHNpN2RhMU5qV29GUXNzOVVlTjNTZGQrbzVRTEoyZFpqVkwy?=
 =?utf-8?B?RkNYMWdvSkhCN0NlelVoQUZ6cU1BRkd3K3hpdjRJb3dGOXBMU0U1VjUzdXpL?=
 =?utf-8?B?dk9MRVNDSWJzNUVaMWRyai9Wd1YyeTBSVE5FYkhrdXhJaXlDOVZqcERidTZ1?=
 =?utf-8?B?bHE5WVR1S3J5NzBFSkY0RE8weWRaVXpqejhqZTlST29HcmJNS0lWK1NXOC9Y?=
 =?utf-8?B?eFlOQ2Y2RUxTQ3IzUWJYdS93eFVZSzRsbzludzZWZTcvYTNQWVMrTnVGMmE5?=
 =?utf-8?B?N3Y1ckwrOUtxemxEYmRMTUxoU2E3bGVtZUVNTjJkYStJS2dMbXNCRGRtL3Ur?=
 =?utf-8?B?S216SHExSGFsT3hhaXdiMElrMk9YQ2pkcXRjaFRoVDllZm1ETThtUnViU0dI?=
 =?utf-8?Q?7psU7VLcAyT25bO/kTXCB/m0y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9f45bb-d3e5-4fad-17a5-08dd6210f7c4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:25:17.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zuz6yYqjnndYV9OPzHl43E97vRFzj426ZHphYi1S4Do82ZmNn+zFURvhw1ijl8ks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9528



On 12-03-2025 16:21, Krzysztof Kozlowski wrote:
> On 12/03/2025 10:54, Nipun Gupta wrote:
>> Add binding documentation for Silex multipk device node with compatible
>> string as 'silex,mutlipk'.
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Sure will update.

> 
>>
>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>> ---
>>   .../bindings/misc/silex,multipk.yaml          | 50 +++++++++++++++++++
> 
> Bindings are before users.

Will send this as first patch in next spin

> 
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/silex,multipk.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/misc/silex,multipk.yaml b/Documentation/devicetree/bindings/misc/silex,multipk.yaml
>> new file mode 100644
>> index 000000000000..6951886734ca
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/silex,multipk.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/misc/silex,multipk.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Silex MultiPK driver
> 
> Drop "driver" and describe hardware.

okay

> 
>> +
>> +maintainers:
>> +  - Nipun Gupta <nipun.gupta@amd.com>
>> +  - Praveen Jain <praveen.jain@amd.com>
>> +
>> +description: |
>> +  Silex Multipk device handles the Asymmetric crypto operations. The
>> +  driver provides interface to user-space to directly interact with the
>> +  Silex MultiPK device.
> 
> Why this isn't in crypto?

It is mentioned in patch RFC 1/2 - because Crypto AF_ALG does not 
support offloading asymmetric operations from user-space (which was 
attempted to be added earlier in Linux at: 
https://lore.kernel.org/all/146672253157.23101.15291203749122389409.stgit@tstruk-mobl1.ra.intel.com/)

> 
>> +
>> +properties:
>> +  compatible:
>> +    const: silex,mutlipk
> 
> Unknown vendor prefix
> 
> Device name part is weirdly generic. How is this device exactly called?
> Where is it used? Where is datasheet?

The device is on AMD versal series and is named "Multi PKI" device. I
will update to use compatible as xlnx,multipk (AMD versal series link: 
https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal/premium-series.html). 
Seems also renaming files to xlnx_multipk.c etc would be better. Will 
update.

The device is used for PKI offload for OpenSSL based applications.
Unfortunately data sheet is not available in public domain.

> 
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  reg:
>> +    items:
>> +      - description: PKI Queues memory region
>> +      - description: PKI TRNG memory region
>> +      - description: PKI reset memory region
> 
> reset? Like reset controller? Why is this here instead of using existing
> reset framework?

Not exactly, there is a clock reset which is separate from the device. I 
explored and there is a soft reset as well which will do the 
functionality and we do not need this memory region. Will remove it.

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - iommus
> 
> You did not test your patches.

We have tested the driver code, but device tree yaml needs some changes 
you mentioned (and so the dts)

> 
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    multipk@20400000000 {
>> +      compatible = "silex,multipk";
>> +      interrupts = <0x00000000 0x0000009b IRQ_TYPE_LEVEL_HIGH>;
> 
> This is nowhere DTS coding style. See how other bindings do it.

Will check and update the binding.

> 
>> +      reg = <0x00000204 0x00000000 0x00000000 0x00010000>,
>> +            <0x00000204 0x00020000 0x00000000 0x00000050>,
>> +            <0x00000000 0xEC200340 0x00000000 0x00000004>;
> 
> lowercase hex, drop the padings of r0.

Sure.

> 
>> +      iommus = <&smmu 0x25B>;
> 
> Lowercase hex

Okay.

> 
>> +    };
> Why is this patch a RFC? What is incomplete here?
> 
> RFC means patch is not ready so you will not get full review. Full
> review will come once you send proper patch (and remember about
> changelog and versioning - this is v1).

Will send a non RFC version for full review.

Thanks,
Nipun

> 
> Best regards,
> Krzysztof

