Return-Path: <linux-kernel+bounces-372173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1342A9A4548
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36DA289948
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5CF20400A;
	Fri, 18 Oct 2024 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uZgQAZdg"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B317B50E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273578; cv=fail; b=uh16U1XQCV9fa8+CfAPt0E3xZjOi06xTl4iy6xWGaowwYd4Twj5z6Udg7rkpad724KOcq6fF9h1fTFLQLK0mRa+DkuQ+OHaLag5EMA6SgwfFC57FsyxHwSUiA2e5j6Ih15BJg3BH3GPjfTCpi92eafK6sEwlIOPa0yxRzrmMBw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273578; c=relaxed/simple;
	bh=VfCPUxhEbncUo1jcFO+e+SoRj2Qr5yVKl/ZaXrn7pZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FcGzsq51VCJnMAdDMv3moQFBXOvXEIhsSuWtJ2Ok3hfNmQzLj8u5eAzyRsLVHCPVfSMqGJw6irJfOlapLtk1k43lFtCiZtyDaFn3H4HH7bYiuntX8UWJ5z6iXEnp5cahh+/eGBAYQWF4UqjIJCMrfHqKKMDe+69XCsQwBcizOHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uZgQAZdg; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1rDD9KUx9tCOCw7Key/ONW7JpgLCnvJcDRM/NCJmhMgA60Fl1KK+Bs6XaZ7hKvwllu0DlkJYnK7I/8+idGcIEcU1NVoau6YKwvBmjDWbhXXzTfjzbkS/SGnN6KcmHWG1VgtKLpSFfKzWHF1fTJhAhg5kFxC321zy5OAuxjJKrlQX5t1IKdREoBGLKQjifXEJP1m/0q9cfkkUUgdcXn2r8sE2EnXbFUbxVQDEfH0zkORTKt1Dj8m2zD9EKHgnyPzqTpWuUJak+EqkjgWn1I2ulxQ2gU+iSLs2PW5rJzgbso1wBbmh58dB2u3wf6dJXUkbMyabRp4FrumwheE7FHzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7Pt3CSpghCqH4XifFPF0Jf7M7fuZc21cinQT0iMOG8=;
 b=baKnh5BPAZO3CtRyTMHZRByluqYbxPL19LXA8lIBcJiJFoaICeRnl/sw8qdZpI1YGg0CKNiRzGNdNuYoloHc4QVwdH5nvcWbkFcdHFN5F22uEqg1/W0ZpbiO5/ahH09vv5qH9RVOSy2GvG64YsbiXI3gC7rP2ONw38pATnPcEwMrYd7/Ux0IcvIdkSXbNjLH1KLAgffFDawN99nhUgPVBOawiUuGARGgl3xArK4L56FI5XtyIY2F3l7L39bmeAnzcD54430wLoNk3YKslXwwN7E3FvgC83NQadXtLEsFBLwdoyNPu++UrTF9LTxmIgjU0yawzzdE1tP7oOK8EIkQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7Pt3CSpghCqH4XifFPF0Jf7M7fuZc21cinQT0iMOG8=;
 b=uZgQAZdgu70fbOtLudZogEOQFGXAnOLq7ItrY2UsxU1PFbvl2k1fhbKH3iqlE5mAHnrRjzHoGXhelRGj0GcFpN+A6aeGoD9rl0r3XqGw3u5t5WKunhJIXIaHjjbW77Mohma1PIERfW+NSCR2KYQeR0Yb3gwljlCIHAAqGM5N9icJziERxCIgN7SQxfF/f4wv8xSC5oruNCIxbC9JQaxhUjUHjK+bGv+s1R1bP59YBOwkS117dTazCEr7crEZZB9hi3i8CgWcBgSOLOycJOovOlbyOfLFr3W6u1roguamt4iStfnccnHkjJL8i0G1rJyfQQ6XEzKNeb9ZgNiKPx3GXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 17:46:11 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 17:46:10 +0000
Message-ID: <ceeb9dd7-bef9-40c8-aead-c1325f1e3a3d@nvidia.com>
Date: Fri, 18 Oct 2024 10:46:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/gup: stop leaking pinned pages in low memory
 conditions
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Alistair Popple <apopple@nvidia.com>, Shigeru Yoshida <syoshida@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241018011711.183642-1-jhubbard@nvidia.com>
 <20241018011711.183642-2-jhubbard@nvidia.com>
 <cc9d692a-846d-4ae4-af4b-c8de8b724df6@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <cc9d692a-846d-4ae4-af4b-c8de8b724df6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 6efb1531-8c67-4d1c-d5be-08dcef9cc090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXAxeFREQUZUVHZ1bXorSDU0YjZVcE9vS0Vuekc2N3lqOWJJOGN0QUd4eUlw?=
 =?utf-8?B?dWtLbEpPRkVJNFYrT1VjV0hBcHhKNm43RERsTHJCL05hbG5oRnRBT2drelM5?=
 =?utf-8?B?MTIzUkFHTENzbW1EeWxITE96d1puWUphUnpVTTJDQytNZmRPWWRzOE5Rb29l?=
 =?utf-8?B?b3MvbHI2b3AvSkJZdG5GUk5jMGdEcEQ0ZDdjZGpCVlVvbGFreTY4ekJXSHgv?=
 =?utf-8?B?RS9SaXByUk1HYnhxaWFEVGlRWHNyUlJDR3YwSlUvVmIvTGpEV1JhbVZ5YUp0?=
 =?utf-8?B?ODhvRkp3R3laL1grQlJVYkJBeHE2QjBkYVFLc3N1WFNmS3VrZ2l4V2MyaEZH?=
 =?utf-8?B?M2xhdjVPd3M5QTJhVXUzd0M3RU9xaFpTU2JsODlHOEpQOWNjSU9BSUtCZ0Vm?=
 =?utf-8?B?MEpDb2Vob29Wa3cwZGRlMEVYZm9IVHB1R2o2NHBQc0dFOHBZUGJzakJ6Slk4?=
 =?utf-8?B?Vk5qUFdNRXhQTUJmb1JVYzY3TGwxMFZHeUtERUVuZE9aUzB6N0ZXbm1xWlZC?=
 =?utf-8?B?bTZxY2dDSU0vSEJObHlKcXJSbkNPbjFldG5oVVRxemdEejFDTVlSbWhRUnor?=
 =?utf-8?B?aXl1V1BJWXROckt4ayttTUh2U3YzQnVQZ1pZM3BJRk91WEZKRVVubytVOFZo?=
 =?utf-8?B?anpCNk81VHFIZWpmUXpsTG9kZ1pNVVpHZEwrc0o1MjZLWDM3S2ZRRGU4M2dy?=
 =?utf-8?B?dzV2ZWkrQVJsZW9oTGU1RkdrSjdmRnNIWkVJN1o4TVJvblQrakMzMUJLeFY0?=
 =?utf-8?B?emxUcEYzOWdGZi9hd1VaYjVyRllqYmRtTXp1Vi9ic203cUp0Z05mU0U0clpI?=
 =?utf-8?B?ckl5Qjd5bE5HQzRMc0dLSjFjR1BOZFdVczdIOWQwTjdSVUhnOUMzWWNnNXo0?=
 =?utf-8?B?amhsZEVOV25XT3JBbUdmc1huRFh1Y2lqampLNmFHS01JeVVUYzIwc0dOZ2xi?=
 =?utf-8?B?WjVSaldsdFZDR1p0VE5JUFVtUjNkMkU1eUdKbGVFYTFKY3o4VVh0TVMrNjFs?=
 =?utf-8?B?c3dNS3hCZzRZNktVUlM0Nnl6ZjJIa2grQzNiZ01SNHVOckFoWStQNTBtTmNJ?=
 =?utf-8?B?MlRNZnpGMVVLcWNNenE2b2dTUTQ4VkJPUUJxOE42d3lPUWpOL3VwRm1oWU1l?=
 =?utf-8?B?QUc4S3YrVmxGK3hXU0JsVlBZQ1FJRnBSUGtTWGdrUExIOWtDRDRiZFN6U3pP?=
 =?utf-8?B?L3FlOS8yd0lyM0NaOUp6Yzk4M3NqaTRZZ2NrcWx4YlBCblZsdC9uWlF2SFdK?=
 =?utf-8?B?OFpmUnRYYUdHWThxSWxuZ0s2QUhHMmN5ZDVrSE1SMEJvNExhU21uNndXWngw?=
 =?utf-8?B?bXNwOTh2cG5yNkIwSnhuQnhvVWd5N2xIem5OdzlHZ3grYWZjRVhscFJmVGJa?=
 =?utf-8?B?ZUxzeVVCV2IycVhHV2dWT2lYYjY1aVAvUXlIUlNyVlhlK1RkUnlqZTRIVHRm?=
 =?utf-8?B?QkdWUkJ1TTdJYUtCMUhzRitRbi8vR3VuaTFmbGQwOVZxK0VEZ2JDN2V0MlA0?=
 =?utf-8?B?N3ErNWJyY0dKQUxpSWsrUmJsb3JPYWpqSCtsZjNUbytPVVd1UW8wOFIvQ1Ex?=
 =?utf-8?B?TlgvcWJHTU1HYlBYRmQ4YjJzVXN5eThSVVlPRGJrK3orajErajEvYVR3cWRK?=
 =?utf-8?B?b2lrS1dCZEd5clozTjZnL3lSMitaQUMxN0lsQittZnI4WHliTkhGYmtSYkMv?=
 =?utf-8?B?S0tCb2JmR2tzSkhlUlE3bEtxSFVnTG0vOTYrWjEzdnNwdVFaTGZUT3EzbUI4?=
 =?utf-8?Q?iTYoMuh0u4s6F5ajT4AHQPlnZth2f9kRVczyTnM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0RmS0kwQ2FOUERZKzBjcUJHa2ZEQThPdWMxWVREa1d4YzFac0JIeFlzdmhW?=
 =?utf-8?B?aHVXN0c3RS9MczN2UkkvWW9mbkoyQm4ranNkY1YyUmZxODBPV3JTYmVrSW1X?=
 =?utf-8?B?R1NTL1RrUlVUc1BadGhCS2xBbzFocTFYTXFIcUdOUDhtVjZEaDVKSFh6K0kr?=
 =?utf-8?B?S2JMck9JZHFMVzNjK0QxSW5EQk9PV2R3b0lPa3RrVGNWRGJPRG1Ec2xVQWZE?=
 =?utf-8?B?OWFMdllnTEVTb3gyaTdGUmdCa3hMWENBNTBSMTVpRTc0amdFVjd0eG1Kamli?=
 =?utf-8?B?TFpYS2Vib2M0MzVtekpJT29LZkpQeGFlMGx6eVZzWlhDVVBWaVZhZkZhSE1L?=
 =?utf-8?B?eFphVzc2T1lrUjBXMFQrdkNVOXYxV21tdlZGcVBibVFsZnp3d0Z6enBWU1Mz?=
 =?utf-8?B?bm5DWXQ0bU5TRFM4RjFLRjZoRVVpUjJDb0liZEdCMWpDdUpIUjJORUpTMFZ0?=
 =?utf-8?B?YVYyN0YyS0Z0czd2b3hiVTRHb2ZuZ0h1L3JXQjNJc1Q5Wm5PSFFGa2xyWUJK?=
 =?utf-8?B?djRjczJRdlArKytJQUpZN0JXUWxQMXdQV25kMDAyTm1uT1ZXY3J6RlQxM0l3?=
 =?utf-8?B?b2JvUkVJNEFFd0RvQmZXV3RzTXVYZ1lhbkZtNGZsODhXK2I1MG43RUJPNURP?=
 =?utf-8?B?dVBEMTJTQzdCVUxQOWxzRzUrS2grcDZJSWd1TzB1RzJoa2Z4eDB5TDdCeWZU?=
 =?utf-8?B?MWRJUXNCVTlUdEJUQTFZNkRWUWxZTHN6bTFDblRzTVZua0U5UktVUWtRSURv?=
 =?utf-8?B?OGdtMmp6TTQ4UkVYdCsrNVozdVhMNWJ0ajlTM3cvdzc5a0ZHZUpRSTFRMDNR?=
 =?utf-8?B?VkRJK085Z0RVOFloTEJ5SHVjWUJxbFBicWNzdmtyT1V1aTVRZmFOTlhNa080?=
 =?utf-8?B?MnQ0QU1FYmRtYWREdkJUWDdUdzc4cmRWcVNLUlhhUnYzQytQaXpjdS9KYlF4?=
 =?utf-8?B?cnNvQ3JkUlduQnBreFN5Qjl4dVI1UHg2d2xMb1hVeHZEWDBRUVcyay9PUnYv?=
 =?utf-8?B?c2dXcm1wejVIakU1SkhoSFZnRGRyOHM4bDR5RlJaeVdFQ3RYc3F5Q0hnSG1R?=
 =?utf-8?B?d0haQ1RUWGZBNW1ub1hqbzlQaHBMNGZDOHRtQWc0emtjU05wS1JiSE1mQWpo?=
 =?utf-8?B?dklhSFM3S1ppWkRicVk1U3JZTjE3UElGbTRoMHZkNEJ3RnFrV0IzaXppcE5L?=
 =?utf-8?B?L2lIclY3TTVxZHZHTC9Gb0tyN1FIY2RaRlJrWHlvVWpVSlczZnJmcTNNSjhI?=
 =?utf-8?B?MWpoczNMS3l6RHJCOGxtVWJKVkZrME4vY2tLT1duQTA5ZzR5ejAwa05Uelo4?=
 =?utf-8?B?eDJDVVFyTlZxem5HR2xsaXZ5WVRvQUw0ek4rQ3p0VzcwTGNoVitUcDZWS3c4?=
 =?utf-8?B?cHFwbXlIa2h3VGxOVmZIdkJtN2ZqZTNLQUpSejBNTmpLSTVId1d2cnQvcEJE?=
 =?utf-8?B?SDM5QlpSbk41MENmZE5EamlYZFNvb240eVhTZDFhZm9zdlZNVUlUc3V5KzBj?=
 =?utf-8?B?SW42TG5rZS8wU1dINjRsWHdZL2JtQUlJV3BCanI0RVI5dEkvSnN5TFZpL0dz?=
 =?utf-8?B?TjQrOXcwVElRZnpQQUhTKzBUWXRvVE54SUZtbkVhVXZJN3pXYTMvMndsY0lE?=
 =?utf-8?B?RVgvclpyQTMrTWhpeGdTVE4vN3F4NDI2WDcrN1NiYnE2U1dwamhqSG9LWHZq?=
 =?utf-8?B?a1JPSU9EbUhRN2VMQ09ERUNnZU5IQWI5ZGF3OU44VlFaR3ZWYUJ6a0RuUW9D?=
 =?utf-8?B?bzVJSi9JY2lDY1R2R0k4UFk2eVkzQ0dZTEF3UGdnNlRuUTFpYnM3YUo5YWZv?=
 =?utf-8?B?bGNEbk5YbGxlN1FJVk5jcWM4SkFEZzlBSE9HRzRjR2h2b0JiWjNKRTBTMTRG?=
 =?utf-8?B?OVBSTVZJcHBsREJ1OVpxdjJYb1ZTUzZVVWgxZ0x1MXVhZTdLaUxVdW5ORFZS?=
 =?utf-8?B?Q1h2Yk1RKzdwcHFyM3RicWZiZmpBN2RjZU9hVVF0ek9icUdZcE1uc1NLMENx?=
 =?utf-8?B?eXFsdHR4VHVVdVlZN3JMYkdTaHRqTzZGYkNDQUR1TUJQLzlLSGpKOWRBSVly?=
 =?utf-8?B?MEphaG9CZ1IwRlE5SUwvaEdFNGpaR3A5MVd0ZEpZWVhoM3NXNm1hU1pyNWk3?=
 =?utf-8?B?eng5bVZwL1Zoc1g1d01QREd5emFlaEZ0MmZFRzc3MGZ4TldTZkY5MUdzL2dK?=
 =?utf-8?Q?LzzI0Dnx7dFlOEZLt48GnLU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efb1531-8c67-4d1c-d5be-08dcef9cc090
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 17:46:10.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WxihRbo79DeutKfjqA5nvbjggKTznnS9xFyPA3iGUXQzdfMi/TklAioRJ5YlHg9ogIZ2SZavHPmt4vtkZNQXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441

On 10/18/24 12:47 AM, David Hildenbrand wrote:
> On 18.10.24 03:17, John Hubbard wrote:
>> If a driver tries to call any of the pin_user_pages*(FOLL_LONGTERM)
>> family of functions, and requests "too many" pages, then the call will
>> erroneously leave pages pinned. This is visible in user space as an
>> actual memory leak.
>>
>> Repro is trivial: just make enough pin_user_pages(FOLL_LONGTERM) calls
>> to exhaust memory.
>>
>> The root cause of the problem is this sequence, within
>> __gup_longterm_locked():
>>
>>      __get_user_pages_locked()
>>      rc = check_and_migrate_movable_pages()
>>
>> ...which gets retried in a loop. The loop error handling is incomplete,
>> clearly due to a somewhat unusual and complicated tri-state error API.
>> But anyway, if -ENOMEM, or in fact, any unexpected error is returned
>> from check_and_migrate_movable_pages(), then __gup_longterm_locked()
>> happily returns the error, while leaving the pages pinned.
> 
> Sorry for another comment, I am taking my time to look into the code 
> again in more detail ...
> 
> migrate_longterm_unpinnable_folios() will always unpin all pages: no 
> matter which error it returns.
> 
> a) If it returns -EAGAIN, it unpinned all folios
> b) If it returns any error it first calls unpin_folios().
> 
> So shouldn't the fix just be in check_and_migrate_movable_pages()?

OK, sure. It's a little odd from a layering point of view, because the 
callee
"helpfully" unpins the pages for you (wheee!), but the updated comment
highlights that, at least.

And actually this whole thing of "pin the pages, just for a short time, even
though you're not allowed to" is partly why this area is so entertaining.

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index a82890b46a36..81fc8314e687 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2403,8 +2403,9 @@ static int migrate_longterm_unpinnable_folios(
>    * -EAGAIN. The caller should re-pin the entire range with FOLL_PIN 
> and then
>    * call this routine again.
>    *
> - * If an error other than -EAGAIN occurs, this indicates a migration 
> failure.
> - * The caller should give up, and propagate the error back up the call 
> stack.
> + * If an error occurs, all folios are unpinned. If an error other than
> + * -EAGAIN occurs, this indicates a migration failure. The caller 
> should give
> + * up, and propagate the error back up the call stack.
>    *
>    * If everything is OK and all folios in the range are allowed to be 
> pinned,
>    * then this routine leaves all folios pinned and returns zero for 
> success.
> @@ -2437,8 +2438,10 @@ static long 
> check_and_migrate_movable_pages(unsigned long nr_pages,
>          long i, ret;
> 
>          folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
> -       if (!folios)
> +       if (!folios) {
> +               unpin_user_pages(pages, nr_pages);
>                  return -ENOMEM;
> +       }
> 
>          for (i = 0; i < nr_pages; i++)
>                  folios[i] = page_folio(pages[i]);
> 
> 
> 
> Then, check_and_migrate_movable_pages() will never return with an error and
> having folios pinned.
> 
> 
> If check_and_migrate_movable_pages() -> check_and_migrate_movable_folios()
> returns "0", all folios remain pinned an no harm is done.
> 
> 
> Consequently, I think patch #2 is not really required, because it doesn't
> perform the temporary allocation that could fail with -ENOMEM.
> 

Yes!

> 
> Sorry for taking a closer look only now ...
> 

It's all still in review, so the timing is perfectly fine. I really
appreciate the closer look, it's definitely making things better.


thanks,
-- 
John Hubbard


