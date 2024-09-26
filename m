Return-Path: <linux-kernel+bounces-339984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDD7986CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F381F2276E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608791898E5;
	Thu, 26 Sep 2024 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NIsbgT/a"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7124178CE2;
	Thu, 26 Sep 2024 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333719; cv=fail; b=dnZwGI1C1PjjrUZ5F97kmELlIBbMbiS4LiCAUjMGPcYLRiXWRhLdSKLzCa76678+IDXjR7l2gff2kev2XLaFPQeGmebCS4q2s03sVdYRdDQFcyX5uAvckswdG5X97jQn378G76I5r/EBQwaP6nUg5gRx/hW75Z4esEeXFqfi/tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333719; c=relaxed/simple;
	bh=urEI+actT0sRaf8EZuJtNJYUX9G6MXHv5VEOQlNHfI0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hBPJavAC+3mjO71uoi1wTFeirFuq2dhaZpMkhIgV+Whg9xiJEG+G35JhdX7ZILjBquJoeJfk+XTH13RTxkHOfDNie+LGERKr+A4lLpzw+WKMY3WS9osi0dfewg7raswYo78Ap0dZbHOfbnbz6QpGGfR5SEqbEsLacfCyNf0xRCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NIsbgT/a; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuSWE85N7qAG60gbqXI+utDKLfxFuQvCDZBEpe5yB5OzGtBmdGYn6pWcWvqaoBFs8IJVNz+6JwIcAVDqC1vPz/LiZNTM2QCZXYkwlXkUV+Aui61oqy4f8IHpXxvC1Vci7mfGfed4z2NksNE8fXLGWu/bJ00duJcaML4jvUiY62fUx3hi0aoAV3DUs3hcenTztBtAkXJITwLnsZl1WVBro7gOt5FfHR05Om8MOPvAl7SQoz2uJzwMDaXF8RS2YVFnpWfby5l7RONHFfNInCaznUNucT4JXx/8htuKlGKjoqdfsD1MGEviFO86KjP2m24EcZhEj85quF2Bh08xoZDcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuiwBXRUOWyMDxnH4MjP/a4oGweaqTEFIYU5Yfu0eK4=;
 b=Qpy5ovBkOvn3IMujkDNydRItqzs0HZvHztbqdxeRNqi3ZKyZ08DiDVhHIhXOOs6uUETPQ9a9PGk5gCpvm/mzsgWcMBlEjkuzKVfTdmOFJKAJ800tvkpNBBAmS2BIGs6Zl4+fLL+vF7pxac0/kjbgXiEI9drBWnOZmUwHXVQnxJtmAUJuJdhK5Dy1b3Wnn0aSMewXJWbj8yuA3Gq7vXKqw8wOfczsjkQMDDYki36YT5iES9EHiKgB0GDWv5rc9wVtwiVDv68VX9nS/mNcV+yNIpxagoF1Tu2bXHGvxzE98Ovz5moooXNlGNsMIR+mt4OvS/v1O5DjU5RCi2hkCD0NtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuiwBXRUOWyMDxnH4MjP/a4oGweaqTEFIYU5Yfu0eK4=;
 b=NIsbgT/a5um9hzbZ04VnG+oTZV7ved1KDoSlul+RPtzrE4e8KTVnJUQwOYDT5eOmadB39mQEUSDn+J4Qutq//sfm0hvrgtyPiERlyGkVbL76cVyujT9MUkddcepgVAg2/lxrgVeKdPNtAdXYDVE88o/SpzzC+hp/ogcFzM2tcaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 06:55:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8005.021; Thu, 26 Sep 2024
 06:55:14 +0000
Message-ID: <c4f3a1a5-c553-40ab-88f6-4622a19de00d@amd.com>
Date: Thu, 26 Sep 2024 08:55:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: zynqmp: Add thermal zones
To: "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "Roche, Matthew" <matthew.roche@amd.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240812215129.3599832-1-sean.anderson@linux.dev>
 <20240812215129.3599832-4-sean.anderson@linux.dev>
 <LV3PR12MB9260AC14D997DED122284940E2932@LV3PR12MB9260.namprd12.prod.outlook.com>
 <7348caab-726c-4c30-8634-a7820aec97d1@linux.dev>
 <LV3PR12MB9260B96B057EC318D762FE3DE2992@LV3PR12MB9260.namprd12.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <LV3PR12MB9260B96B057EC318D762FE3DE2992@LV3PR12MB9260.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::11) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eeda551-2ff4-4df6-bb4b-08dcddf82c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUdlSFBhWndhS2pvYnhsOVdUT2paQlJsQ1BTTE9GaEN6dGhpZlc5akR0MDg1?=
 =?utf-8?B?NWRuVCtFb201MWNkNUt5UGd6bGZKTTc5dGtaZyt5K3grLzQ3ZVFMS1BhQmhj?=
 =?utf-8?B?dEhzNTdFTllUWXZzWWx2K2ZQTko4MkFpQUhXVGtBcE9XUXd1S0taa2FhTmti?=
 =?utf-8?B?cXpPS05XWEN4ZVJUZ1VudGxxd3ZCMUlqQ1NCWFZ3UHgweVUwZGd0RWcrQ3F4?=
 =?utf-8?B?OHBuR2lqTGxHWTdZVVRvVHc0czIwcGtmeCtGanc5ZXQ4cE0yNFFQTENjS2lv?=
 =?utf-8?B?Z04vbmtPOVNkR3cvS2dOMXZJTkQvZU05MFZZQmNveEdVbGhuK1JIMEFvQWxO?=
 =?utf-8?B?K3g3U0xCWGRlZ0ZLKzRpRmJDbVpFMTZuQXFUWEhwSkRIc1VkMEd2TTRwR1Bi?=
 =?utf-8?B?VmtPcy9FTHZuSG1FR2xibFZZV1AwOHBaYkxNNGQ4SHppdU52bnNLQUdXaXJ3?=
 =?utf-8?B?QnpiN3FVRGRUOEQyajFDMVlrOS92K2xsMVRwVytBalR2V1JLZm1SNUlDa3ND?=
 =?utf-8?B?bmswcW5Ca2hMbzhhemtacDNneDhXZ091QTRxNlc4Zkg3NGYxSzkvMlV1TTlI?=
 =?utf-8?B?QlpOdmFHS2doOC9JZHJTdEdhUHh4UDBPM3R0NEgyU3JXM291dU9lclFwMThr?=
 =?utf-8?B?c1h3Wll3QlNGOEg4VzJjYkZ2Ulk0RERNTVBjaFdmUHBwUFYzZUdzbFRQd1Bm?=
 =?utf-8?B?RkQwY0s3QjNhUUNQV3Y0Q3E1MkZwK20vdUIweWJ6MFA4dXI0WDFDZVhHMzFX?=
 =?utf-8?B?QlVzZWlBUWUvVENVY2Z6VDVqSG9JSThQN0VPd0hPdnBFZy90QjVWdUFOU2V3?=
 =?utf-8?B?TFo2TTlpSDJtK0dZcjErRVBPMXlwQUk1dmZqTGVEUTQ5b0crdTU1b21MS3Zv?=
 =?utf-8?B?UWpoTDlaSWkyVmVDTFc3RU5CcDNtWlFjV2w4QzBhSUdqR1JxT3ZVRFZwTncr?=
 =?utf-8?B?emZvMU50M0g1N1JBUEd1ZzhBMk1QOVJtM25yV0pjNDJjV1g5NmV5dkptNjJo?=
 =?utf-8?B?RHdLM1FHV3lKdHBtRGhMNFRnN0QvVWJBdGFmclhWbXdJRWxYU2MxZjJMY0FO?=
 =?utf-8?B?ZVQrTTkrdlR0Rlk4Sm5JcWNyL3lDbmNoMndvemVRR09id0ViVUpqVEV5Zmhi?=
 =?utf-8?B?MlFrc3ZQZjY5bTNNdUY0blNYL2E0V3ZQN0s3NXZOZHFPUzMyTkJMemhxSk1J?=
 =?utf-8?B?OXd2YXUrM3NxVzNKcXVMcTEwQ1VKdktIK21hTkNXNlpQMnZ6RnRoZm5iOU14?=
 =?utf-8?B?c1NrQytUbE1aRU1mN3pjTlErOXJSZFJRVlRvNWVlUldEUUtPZXMyTVVCaHlq?=
 =?utf-8?B?MDZDSTdGRmQ5VFNmQjVzVGNFVnVqd3NtRU1nT1NoL0ZsYjltNjBSMTBsS0RS?=
 =?utf-8?B?OEZkWm5LTTU5UGFzYk85eUcyU1NhSksrdjA1c2FXVmV3R09mMFdJNVdKQ0gx?=
 =?utf-8?B?WGdlUGdiWjNUUUNVTWFTcXg0QzJuVkhlRFhXWlRUa1JVNkdnM2xYNEF3MlJL?=
 =?utf-8?B?MGFXSkk2cHpUZVhpbS9pMGlQRHJGTWJWTGZDa0grdktCZmEzNDMyVzVxclFr?=
 =?utf-8?B?RFh5NndRbWtHd1VBSWdXaS9XWk95RlJFcnErZDhjTzZ6ZjVadnMrRnBIR2FX?=
 =?utf-8?B?RE9jYWNuNFhWeWR4VVhOWjFnQWVuOW1kSmZEbGc1SzdTM1RSbDczNS8weWY5?=
 =?utf-8?B?bEtRRjhsOW1COTA0UHpwaWNvekU4eTdtbk5DSS9zM3RrQkZyNkRaTVZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmtScVNUV3piT05zb21hSThmaVV1ZTRDekx1QTV0a1l2Uk1uZ2dleEViWDhJ?=
 =?utf-8?B?TnVXUm9CRGdvNlNiNm0rQXdWTzNRNkJrblZFa3RHYVdZeUR2aVBVa3JQYkJl?=
 =?utf-8?B?SUxBTWpFMHQyUHFZck10L29mZkxhK2lKRm5FQVVNYzVOYWl6OWdKclJTNCt5?=
 =?utf-8?B?TzBmKzd6cFBnMCtkeDdGbEIzeTJFTFhzWW9GNFZLWk5lQ1BsZHM1Y3JZTWNR?=
 =?utf-8?B?SW41ZDc4TU9iTzV1Zkw1ZzhOYU94bDdEOVd3VEJDb01aQTNVV2hTQmhSVzJP?=
 =?utf-8?B?YlNaVnhWbWZZcjBleCs3SEMxYWJlbWcwWWNPa29pSnZsbmtsNWNRb25HKysx?=
 =?utf-8?B?TXprZ0k3dVgwOVV2RWhoblgzWDloeEtDM1dEMzVFQ1lNY3FlL1drN0xnREtF?=
 =?utf-8?B?YW5wU3RBVE5ZUzhJL080WWRRTkZrcFNoKzlTR0hnQnZNNjM4REtVcUlLSFND?=
 =?utf-8?B?bjh5Q3ZIdkxhNVNPRmR3TlRnZmUwVXJhU0JGWjZ6S09jU0MyVmw2ZXQ5SVJx?=
 =?utf-8?B?VE1lZzJxcmxOM1diRERVVnRBYWNVUEZKNk1HT2RnMngxLzNzUWM5Y3BrTktW?=
 =?utf-8?B?ZGRmeGd1QlJSRjRoaStzUEF2Ym43aWJWT2tTQmFFN3czVDNIM3ZTS2tFSXhY?=
 =?utf-8?B?UVNyWGxjUlQ1Qi94NlhxZ0swZTFObFdJS29FQm9TbG83ZzlVbGFaRjhQZi85?=
 =?utf-8?B?ZERDZHBUOU1aY1dOVDdjRml5anlLMXZZN201b054akZ1WHVUektZTy96bEdk?=
 =?utf-8?B?N1BxZEJZL1dsaFo5ems4bytXRTMxZTNTVWthNmIzV2J6T2pQZkhDYzdielJj?=
 =?utf-8?B?WTdkV3BzQXVIRktFaHVXM3Q0amRRakw5ekVSYTBJL2RoRFJUaW92T1FQY2F2?=
 =?utf-8?B?bWxmbXFaeXZFeVc3TnhNRTJGN2JLVEQzMlBWV1VrV3YraVRVUkwzTGc3UmtR?=
 =?utf-8?B?bUdNMUVSRWNxdFNhUlVsM1JIOSsrR0dWNUlHV29QK0xBSkRkcnEyblZ4MmVM?=
 =?utf-8?B?QWREUzVLejFydDNqYmhmSk5raE53UGRYcHZ4YUlzeUpXSm90TElaQjBPT25S?=
 =?utf-8?B?TERVTHRYbnc2aHppczBUUGNmUlF4ZUVScDViMk1iZlg5bjRWMXZIYk9hZEhE?=
 =?utf-8?B?K3VhNHd4L2FZVDF1aTlQWWJZMGV6MHJQV3VHNHFOV2UrbHMzc1pnaG1mc3lV?=
 =?utf-8?B?K2NhU2c1V1dCeXRqYitsTHhCbk5KS0RpRHZzWTQvVms4L2RHSkFTejFTcHk4?=
 =?utf-8?B?SDd6b0ltY3hvTlVTaml3cFlIcG9rZ3hPN2V6RUczMkwyNTdBVnpqSkRZdDdG?=
 =?utf-8?B?UjNCcGpOUldXakpTbGRIeXV6ajYrYW9vSkw2Q0xCUk5FQ2F2NDJUallXVGJ4?=
 =?utf-8?B?b3dWcWtXTnBKYUQ0azBid1JkcldURlYzclhRVFNGRWU3VGhUMUxmZ0dFRkFY?=
 =?utf-8?B?d0VKS3k3NDZaQkJ6R216UjdGY1E0eU9rTUtlQXBhdU01eGxVaVprTVBLMmRJ?=
 =?utf-8?B?NXpVMzkrcTc0bEhRVHpKY1hrMWtKZGVsS2trWFZmQ0lTNkRmSW9QZUZWVW5u?=
 =?utf-8?B?SHlDUEhuTHNjQnhQejMyaXMrRGkyTGdyWVR4cWo4cjhkS2c2cUVqcWp2Wjdi?=
 =?utf-8?B?aUR6MDdXU3hTTFdac254akdyTi90UitnQVVjS3BJclpsWGphSDZqMWVnNjN5?=
 =?utf-8?B?MEp0aStwZWlVK3JTd3pUTjlqa3R6NGV6VTU0RGpsZWpqMEFnOTNicTFaQ1Y1?=
 =?utf-8?B?aEViSFlYL1hlMnVjNFZiMTc2a1F2SjdzeW1BcjNoYUhHYno4Zi9vTVhEWTNR?=
 =?utf-8?B?NEozVXpZTTRmemVDb3VsSmdySEM4bkNLRk9Pa3pDM1c4S2Z3MlNjc1FNSWtO?=
 =?utf-8?B?UUcrZk1pcHYySmxpdzl0MHMzWWkzN1Y3VDJreThPSWRQMmYxeUdJSVU2QkM0?=
 =?utf-8?B?Nm5WVzdYTkVIelRsNU5yN2RXN080T25RM2diczZCdVJmQ0VjTlVMMkYxaGV2?=
 =?utf-8?B?U1ZMaW1HRFQyOUM1YjhrMVBlbW1qZzR2VHQyWmhZdjVkUW04a040Uk1JQm9B?=
 =?utf-8?B?SnN5S3NZLzBNUlFkY3BOVlU3dWxDZS9yRjVBdUJXTTFpYjQ3WmdtN3JrdHR6?=
 =?utf-8?Q?yGg6WBbiFPEM0gsAaGlFSyKte?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eeda551-2ff4-4df6-bb4b-08dcddf82c4a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 06:55:14.5604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1uU+81oNBuMZTW2+IC17b0uIWDU2j3KBDAXAbQWryQeWRpdVjF1yBPdRD9z3To1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650



On 9/9/24 20:28, Thangaraj, Senthil Nathan wrote:
> Hi Sean,
> 
> Thank you for your response.
> 
> Unfortunately, I’m not the right person to recommend the thermal polling delay. I’m looping Matthew into this thread for further assistance.
> 
> Hi Matthew,
> 
> Could you or your team please provide a recommendation on this?

Any update on this? If not I will take merge it.

Thanks,
Michal

