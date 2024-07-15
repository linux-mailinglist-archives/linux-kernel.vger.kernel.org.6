Return-Path: <linux-kernel+bounces-252045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0632A930D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837C71F2144B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D311613A27E;
	Mon, 15 Jul 2024 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1BpPmAPi"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49423A9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020808; cv=fail; b=kg/79zWoMosVuJnC9BGQmIX0OpLbfkhKpeIkXivBVD9bYXq3ONkjZf6ZPEX1ZV4mxRs+afJrfmx9yMMHWpPgwYMdaPxSOU0hyk6nvhYu4RzmAv+NnYbKgJ0ng23SS/EoA275lbNC/Cwx3hJS4eSuhHgEcr6fj6PWMp6zrHTNQMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020808; c=relaxed/simple;
	bh=7ltt6AN3iCqufaGcrG9LvCFminujYNJjBXUTLAyubpo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oUooTtuKMzRU1Orp9oRb6A5fQji1NZe4pFSLh08cav0I4OY6riwqzYwPc8xndMW4Puj9EE9/6OwrjMfFjgwE00YHt7bVqvOWVK/zEwQ24YorWFwLGiwsOzIkqKlArar2xGh97N6VROCRZtsDs4Bwqgsru7NBcLywqK4Yf2N/Xsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1BpPmAPi; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObTmATqMGJ4wNdWmBrreycAvXIX5oiJAeILy24T3tlbDeYnJ8JXGjZeSIIc6evdFgCi0qHyUCJiJqrbmXdYkpM5voM5sIdzFQ19jFP0oRsJ6fNaLQoaqECFi+zMuFMJes39Cw9QU8X62PwqH2UBQf933X8cg8D8nceqfHobrvkxEYvkuALLzRWfL8mzqxUwsHEZNgRVhtsjkLiJFU6qh2cinL+G4IHJ2EsgqrvnDHbfgwvNhlaTS49I+i9uJNJuImkQ86YqXoAoRVbob0o18YO9qyPp8myx0AlZdbLHIRuN/MtrlD2VDSqqW2ijKPk9h13qBeSt8r3dyo59sDlwVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrZvEdSGFvOvBOWPHNT7MznNT4xUA/dhLTZ9deg2XSg=;
 b=bSbuBEEhKAYe8p6Q+dj4JmYxp0WXZl6QL0UuNyHlONt0FiCMFWv3vB05iPxAmRiOZqlfBF7Ovng0G9fYePRXe993ZBnR3RCiXmN/MIaiqqheLxgucUrkVufSjlEswcs0RvXcnIPg1SSCDHVbm/3bBPaJVBzNTt5YxzuIgm3CY8acMnyQSi7HJtvvN/dEM5h5dWDN78u0ANdC2P6YV6Lzuo3BN/j4CsfWjxNm1PpaJzcKY4jmLHA3twjTUwRuRlusyHd/04Sje+8fGmQ1Cb/zSZ3rcnOrRca1AHUQ7c3NrGazeAh3uEUiCLaCee4qmnKUdlcmij+ViyfsYZ9sBjjiEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrZvEdSGFvOvBOWPHNT7MznNT4xUA/dhLTZ9deg2XSg=;
 b=1BpPmAPikPEXPCmZQ54xbXpgnEjJwHkctCgyRoSgV86UVG5L9arYTUrDyuymcLM3ElX96txIPWPGRTQnn5z+m9pYb32pcy+Ik56wgODz5eA9PyYqFuD15CmSvu+HaPvcHAY9ZRu6zSYml+Yzz2Iymo/heQ2a7t9jxEBaPubf+U4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) by
 PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Mon, 15 Jul
 2024 05:20:04 +0000
Received: from DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::ec83:b5e5:82dd:b207]) by DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::ec83:b5e5:82dd:b207%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 05:20:03 +0000
Message-ID: <893a263a-0038-4b4b-9031-72567b966f73@amd.com>
Date: Mon, 15 Jul 2024 10:49:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
From: Bharata B Rao <bharata@amd.com>
To: Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com,
 "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz,
 kinseyho@google.com, Mel Gorman <mgorman@suse.de>, mjguzik@gmail.com
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
 <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com>
 <CAOUHufYA-ZAHni1_aDQjjwB5UC9EFYPL_YqVN52DoL3J7SFziQ@mail.gmail.com>
 <7a06a14e-44d5-450a-bd56-1c348c2951b6@amd.com>
 <CAOUHufa7OBtNHKMhfu8wOOE4f0w3b0_2KzzV7-hrc9rVL8e=iw@mail.gmail.com>
 <b68e43d4-91f2-4481-80a9-d166c0a43584@amd.com>
Content-Language: en-US
In-Reply-To: <b68e43d4-91f2-4481-80a9-d166c0a43584@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::20) To DS0PR12MB6439.namprd12.prod.outlook.com
 (2603:10b6:8:c9::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6439:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 441298de-fc88-4d15-d8da-08dca48dc7ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE4wOWpJUktlYTVtNUVRd3hUUEhFTFBVN0RuVmZNOGZ1YmlZM3RSOGIyVWd1?=
 =?utf-8?B?eGpDSjBYVmR4K3F1NXREcUhsN244MFhwdkc1L1JoZkhrNUY0TzJVY2xhSWhR?=
 =?utf-8?B?THRrc0huUk16RWtxd3BYZHRwT1lRbHpJTjc5R2lhell2ZTBIR25oeHhQVTN4?=
 =?utf-8?B?eUczZ01kcThIeUZDa3hnNXZYNlhDKzlKdHBiRlNFdURSZVRoTEpJYXlKV0ZU?=
 =?utf-8?B?YVBxVHRJQ0RHNk8xK0FyUDJTeHBjeEZPTU5hY09JVWFVeGcrTTlmbG5FZ2tH?=
 =?utf-8?B?ZGNzN2ZlVVZ1WlRpMDEyRHJiZkxRL3dzay9wNXZVaDhDY3I1TVFrd1BSRXBM?=
 =?utf-8?B?RmNjWWsrNGJvLzVmZEplUDJwQVZuaU1JbDFaemNoMXZ4anhFZ0NOQy9SYWlS?=
 =?utf-8?B?Wjg1Z3BoWjlpNk50TEZrNEhSTWhBOWkvd0JPNmxRbG9qZDNlYXV6UG5DaUo2?=
 =?utf-8?B?b1ZGcUlCVDltOGN3TStkVml0Q2lOTzJZWG5SMWo1YXJRSmh1dEw5MHl0c0lE?=
 =?utf-8?B?cGFyVG5STWdlbmpiRlNoT3VyWHVXam43RVF4TFFlZ0g4VGw1UGFlYWJqSmVX?=
 =?utf-8?B?aHllKytJanlrYlVJdXBqZ01uVTg2QzR1cGlLbTFNYXRLSDhBcWZuMmVNaXJl?=
 =?utf-8?B?aS93NVdyaXJJRUhuVitzcDM0Q2lRdlAvNHVsblJ5cG5kOTh2Q2N5NlhPN0ly?=
 =?utf-8?B?dlNvaitBeHNaR1BWdTVmSVBGdkRDWk1Dc1ljZmVpcXgrTDRTdHFuZndtbkRV?=
 =?utf-8?B?VjFpZzRsNWFRTzJLY252dXNaS0wyQTFMMTVGeGtnZlcwaEM3L1I2L2ZIZ01P?=
 =?utf-8?B?clJ5dkY3Yk9vTG93QnhMK29YRVNmaGxtUDJBNE42d0tnU2NBd08xYmMvWmpF?=
 =?utf-8?B?M0pxYkZtM3dFNzV3bThCaE5PNEQwQjZTemNRRSt6anpNUWFSdTZuQ2E2bzJT?=
 =?utf-8?B?NGV6akRSeVNHeU1SL01vOEphcFppVWlIYnZRN1ZPMFpMQzVGNnc0cFJCbzlU?=
 =?utf-8?B?UER6S1Y0dGEvOGZkL0UxaGJyMWxHZngrbjAyckFZRU5Tc2R5Uk84MkZwYzdB?=
 =?utf-8?B?QndOTHh6Slo0aCtRaW11VUx0cHdULzhBVTY3TlEvbFMrQWtsbGlMSko0RFpJ?=
 =?utf-8?B?dzNKSElZSVVlUmtTN21mMVg4SXRjNXc3NUpubEdybkYzMjI1c3NXSmtxVEtQ?=
 =?utf-8?B?TmI4ZG1DOXJ6aUZncUxnMGc5c0NMcHZhYVlIM200L2p3SjQvakxVNG81dHBY?=
 =?utf-8?B?eDlLaW1wQ3JOSm9BR1ZPU2dVNGZSbkZQdFhBdkFEWnVyWU5GRjVMM241ZjRs?=
 =?utf-8?B?M3NnSFF3L2ljNnQvejZsdlp1eFJyMGJvL3haYU40SXpiUUk4WGowYTdXZ1J6?=
 =?utf-8?B?b21vY2IwR0M0Mi9ldnRqYjR5VU5xU0tZeDhORFFpY2xUS0NSbGxBaDVpWWU5?=
 =?utf-8?B?RzFlejRZb2NqcXdTYUJNQmdJcUpzWVZxUG1LQ3h5aHdRZDkwRzJwNGd2bW05?=
 =?utf-8?B?SUlBZWl4UzRoaWdWT09jdCsvL1IwbUJrdzVjWXVlbUNEaUtoS2hra2RKT1pi?=
 =?utf-8?B?QUhROVQ3VXg0OXpOYlVSWS9rbzBXbEp3SGpyMHBwZUo4endZMER1TU9LRU5x?=
 =?utf-8?B?UHUrOU1JRzlMWDJpdEpPYktIR29oMml6bzVNSHNJaWlyc0NKVGtqUG5MS2xa?=
 =?utf-8?B?elh6OURIck9vUVEvUWQ5cXNETys0b0UrR01uYWtNdkEyY1YyWjUxSlcrV3VH?=
 =?utf-8?B?SExUdHIxZ2kvUm5XeE5teThqRzFyMUZWeFRrOFEzTUlySkMyMlZhVlNGdURZ?=
 =?utf-8?B?clBjWThQQVBUU0pueDVjZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6439.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXA2dkVML2djNTl6SDB2Yjg1eklLaERvVStXdXp3M1I3SDdPWW5PajdEYmlT?=
 =?utf-8?B?S0I1OXdEUTluL0U2YlluaHVJTERwY0tXblkwSExHYkF2K2gvUlNwTzRPQWRJ?=
 =?utf-8?B?dlIvY1lVS3hWWXpoeTFxLzBwRHN4K2dkbFdydmJGR2Z3QjV2MVRDUXVsWVlT?=
 =?utf-8?B?YkVzenNHZU1xaXZaeGxtektSRnFqVllOM1BEL2ZQRzEzalpqNXc2dStzejNn?=
 =?utf-8?B?RXdVUnl5bW45MlAvOFM3L2dZalhhMmMyUVlFV3JUVGRFU0huOWE0OE4yUnFU?=
 =?utf-8?B?M0hUNTIxS3dRVFBuTnlvQTR5Z3lFZEJuYWhzRnlpU3NEZVBSVENyaFVTN01X?=
 =?utf-8?B?NW5QSDVJTXk0azZ4bGF0KythcytXanBRbUxiZEM2Tm02REx4dlhVVC9WYkVY?=
 =?utf-8?B?N1VscmVmOUgrMmNWb3NmR2JyelAvN1FrVnNUczA0RVFXV3hyNTBsSkhxQ0FU?=
 =?utf-8?B?cVRDbVIzaTc4QS96WERjRkY1aGIrbUhYQm5COEt1VmsyanFOSWtiSENISERu?=
 =?utf-8?B?eGNmYld0dXF3VEZ2azZRa1RaT3M5dklhdktKMnhkWk5FM2pMM2poam1EUVlM?=
 =?utf-8?B?WWp4dW9HcVNwUW1jbHNiRTR2RTV6TWRlUURseWhSVjJNTURsdWI1cG5iVjhC?=
 =?utf-8?B?bkoxSmhWYW9nOGdvWUZWTWQ2KzNKakFxU0RVTlZBNVk3M2tiaUl0Wkdwa0lw?=
 =?utf-8?B?U3EvT0FKMFNPR0tEK3pGd1JTUW1JVGV4MU0rMkZ0N3VRS3lCckdjVWF0U3Z6?=
 =?utf-8?B?bHoydUVpQU9ITWpxTWVFOXBJMS90L2gxdlc2dE5LOGxtVlI4Qzh2RGk5MmpR?=
 =?utf-8?B?VXAxeTZQcjBGT3pKdWI4bktRaDdjbGMvSUdTWWUydHVDZlcyRFJMT3NNQ093?=
 =?utf-8?B?UjIrNjFLSVZFTFVzVFhJYTlYQkJSNHZHdjFVK3BubjlPL0VmMi83VHk3ZGNT?=
 =?utf-8?B?a3VIaWc0TnhDVWtxR25yNDVVaVdqMFRsQ2h4RXhEWHlXck54MXg0eklWYXlh?=
 =?utf-8?B?RnJPM3lQT1VuTkp1aVJkVHFFYk9LNUlpWFkyWXZnSldrbWZhY1piWnFxYlVu?=
 =?utf-8?B?clN1VWFzZDRDeEE3MXhXbW43NFE2clZhQTlFZWZDK0xQS29LWENhS1hnbEg2?=
 =?utf-8?B?dTJ6RDdSc3FDL2NYTk1wQldJeXR0N1JFYWkxbGdjdy9Fa0pYYTh6dWk3ZGpV?=
 =?utf-8?B?aUUyV2NrZnlycTFPLzRFZ1Q0ZEdGamEzbmNKK09mTjltRmF4bURDczJHWHJK?=
 =?utf-8?B?S1pETis0dWYrcGMrdUhOQzdSckFZZDdCTWR5RTZseWhETU1COGU4dkR2dmhM?=
 =?utf-8?B?cGlUcmp5NnFPVUF6UHgzdDRFeldZc3FDNmlEei9TNWdYcmx5YkpJaHlnczRE?=
 =?utf-8?B?cnUxR2FaOFhINXBnRitBKyt3VUR2OTQ3SkFsN1ZJenVrS2JJV1VrdmNnL1Iv?=
 =?utf-8?B?eVRkVkcwc1VQSTdnekZDcjhYQXplV1hNNi9XYXlhUFRQbC9NVmJHTVVrZ1Ay?=
 =?utf-8?B?MFlVNEVBQ2hacE5pQlRvRWJkZHY1VGgxaWJXcnhBVWNJaENTUk1yVmpoUTNC?=
 =?utf-8?B?WE5hZGlBcERHdWN2Ny9GYmpQak9yMGY3UXpXR0RDcm5YaUhHbFkweUhJa2JZ?=
 =?utf-8?B?OWppdDlwMWlpZlphc3hvUllTdGI5eHBMSWkwR0FjMC9VM1RYMDhzSjFoUUJv?=
 =?utf-8?B?RlQ2dW84VUdMZ0d4TGZ2WHRXK0Fma2ZqQWNYUkkyc09ZWXhXLzlYYWd6c0pa?=
 =?utf-8?B?TnlCMWRQRlBteEVGa3RvS0RxVFZPZ2MwQ3lPZXdvNkxVMlRGSWlIYnJQaGhp?=
 =?utf-8?B?TlJRMVpzcHpmcG5OaGlwY0t4Q00vbmtWRThYWnpDZ2xaclpPWkU0Q3cvV21k?=
 =?utf-8?B?Q1pFUUY2bDFVaHBPWGIzdUlYUXhPcUNESmozVEVhdnhkTmRtU0NZYjdpY2pi?=
 =?utf-8?B?cEZLbTlyK21CVXhJdUVwSndhZ0RSWXp0VlZ0dUoreFVUWkJ2WVAwWVBYV2N4?=
 =?utf-8?B?VXcrd2ZYakRXb0puRnBnMDZpMXpSMjJvUWlLcjZ4cHNBQlRYQ200U01ZSGM5?=
 =?utf-8?B?L2wyaWFyaTlJekVJakE1SjltR214WEFWeE84bmNGV3d0TFhFQkd5bEozUnVW?=
 =?utf-8?Q?Dr4Q0SK3YX+p8nMEuxCd+x8Xs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441298de-fc88-4d15-d8da-08dca48dc7ea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6439.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 05:20:03.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eimJw5uqwev465pa64vVGYQ1s7rAG7R9Z6qL0Sgs86r2FpVxkxm8uMRan0hcpwI5AAoDoleI8eTpBiv1DmhWYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116

On 11-Jul-24 11:13 AM, Bharata B Rao wrote:
> On 09-Jul-24 11:28 AM, Yu Zhao wrote:
>> On Mon, Jul 8, 2024 at 10:31 PM Bharata B Rao <bharata@amd.com> wrote:
>>>
>>> On 08-Jul-24 9:47 PM, Yu Zhao wrote:
>>>> On Mon, Jul 8, 2024 at 8:34 AM Bharata B Rao <bharata@amd.com> wrote:
>>>>>
>>>>> Hi Yu Zhao,
>>>>>
>>>>> Thanks for your patches. See below...
>>>>>
>>>>> On 07-Jul-24 4:12 AM, Yu Zhao wrote:
>>>>>> Hi Bharata,
>>>>>>
>>>>>> On Wed, Jul 3, 2024 at 9:11 AM Bharata B Rao <bharata@amd.com> wrote:
>>>>>>>
>>>>> <snip>
>>>>>>>
>>>>>>> Some experiments tried
>>>>>>> ======================
>>>>>>> 1) When MGLRU was enabled many soft lockups were observed, no hard
>>>>>>> lockups were seen for 48 hours run. Below is once such soft lockup.
>>>>>>
>>>>>> This is not really an MGLRU issue -- can you please try one of the
>>>>>> attached patches? It (truncate.patch) should help with or without
>>>>>> MGLRU.
>>>>>
>>>>> With truncate.patch and default LRU scheme, a few hard lockups are 
>>>>> seen.
>>>>
>>>> Thanks.
>>>>
>>>> In your original report, you said:
>>>>
>>>>     Most of the times the two contended locks are lruvec and
>>>>     inode->i_lock spinlocks.
>>>>     ...
>>>>     Often times, the perf output at the time of the problem shows
>>>>     heavy contention on lruvec spin lock. Similar contention is
>>>>     also observed with inode i_lock (in clear_shadow_entry path)
>>>>
>>>> Based on this new report, does it mean the i_lock is not as contended,
>>>> for the same path (truncation) you tested? If so, I'll post
>>>> truncate.patch and add reported-by and tested-by you, unless you have
>>>> objections.
>>>
>>> truncate.patch has been tested on two systems with default LRU scheme
>>> and the lockup due to inode->i_lock hasn't been seen yet after 24 
>>> hours run.
>>
>> Thanks.
>>
>>>>
>>>> The two paths below were contended on the LRU lock, but they already
>>>> batch their operations. So I don't know what else we can do surgically
>>>> to improve them.
>>>
>>> What has been seen with this workload is that the lruvec spinlock is
>>> held for a long time from shrink_[active/inactive]_list path. In this
>>> path, there is a case in isolate_lru_folios() where scanning of LRU
>>> lists can become unbounded. To isolate a page from ZONE_DMA, sometimes
>>> scanning/skipping of more than 150 million folios were seen. There is
>>> already a comment in there which explains why nr_skipped shouldn't be
>>> counted, but is there any possibility of re-looking at this condition?
>>
>> For this specific case, probably this can help:
>>
>> @@ -1659,8 +1659,15 @@ static unsigned long
>> isolate_lru_folios(unsigned long nr_to_scan,
>>                  if (folio_zonenum(folio) > sc->reclaim_idx ||
>>                                  skip_cma(folio, sc)) {
>>                          nr_skipped[folio_zonenum(folio)] += nr_pages;
>> -                       move_to = &folios_skipped;
>> -                       goto move;
>> +                       list_move(&folio->lru, &folios_skipped);
>> +                       if (spin_is_contended(&lruvec->lru_lock)) {
>> +                               if (!list_empty(dst))
>> +                                       break;
>> +                               spin_unlock_irq(&lruvec->lru_lock);
>> +                               cond_resched();
>> +                               spin_lock_irq(&lruvec->lru_lock);
>> +                       }
>> +                       continue;
>>                  }
> 
> Thanks, this helped. With this fix, the test ran for 24hrs without any 
> lockups attributable to lruvec spinlock. As noted in this thread, 
> earlier isolate_lru_folios() used to scan millions of folios and spend a 
> lot of time with spinlock held but after this fix, such a scenario is no 
> longer seen.

However during the weekend mglru-enabled run (with above fix to 
isolate_lru_folios() and also the previous two patches: truncate.patch 
and mglru.patch and the inode fix provided by Mateusz), another hard 
lockup related to lruvec spinlock was observed.

Here is the hardlock up:

watchdog: Watchdog detected hard LOCKUP on cpu 466
CPU: 466 PID: 3103929 Comm: fio Not tainted 
6.10.0-rc3-trnct_nvme_lruvecresched_sirq_inode_mglru #32
RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
Call Trace:
   <NMI>
   ? show_regs+0x69/0x80
   ? watchdog_hardlockup_check+0x1b4/0x3a0
<SNIP>
   ? native_queued_spin_lock_slowpath+0x2b4/0x300
   </NMI>
   <IRQ>
   _raw_spin_lock_irqsave+0x5b/0x70
   folio_lruvec_lock_irqsave+0x62/0x90
   folio_batch_move_lru+0x9d/0x160
   folio_rotate_reclaimable+0xab/0xf0
   folio_end_writeback+0x60/0x90
   end_buffer_async_write+0xaa/0xe0
   end_bio_bh_io_sync+0x2c/0x50
   bio_endio+0x108/0x180
   blk_mq_end_request_batch+0x11f/0x5e0
   nvme_pci_complete_batch+0xb5/0xd0 [nvme]
   nvme_irq+0x92/0xe0 [nvme]
   __handle_irq_event_percpu+0x6e/0x1e0
   handle_irq_event+0x39/0x80
   handle_edge_irq+0x8c/0x240
   __common_interrupt+0x4e/0xf0
   common_interrupt+0x49/0xc0
   asm_common_interrupt+0x27/0x40

Here is the lock holder details captured by all-cpu-backtrace:

NMI backtrace for cpu 75
CPU: 75 PID: 3095650 Comm: fio Not tainted 
6.10.0-rc3-trnct_nvme_lruvecresched_sirq_inode_mglru #32
RIP: 0010:folio_inc_gen+0x142/0x430
Call Trace:
   <NMI>
   ? show_regs+0x69/0x80
   ? nmi_cpu_backtrace+0xc5/0x130
   ? nmi_cpu_backtrace_handler+0x11/0x20
   ? nmi_handle+0x64/0x180
   ? default_do_nmi+0x45/0x130
   ? exc_nmi+0x128/0x1a0
   ? end_repeat_nmi+0xf/0x53
   ? folio_inc_gen+0x142/0x430
   ? folio_inc_gen+0x142/0x430
   ? folio_inc_gen+0x142/0x430
   </NMI>
   <TASK>
   isolate_folios+0x954/0x1630
   evict_folios+0xa5/0x8c0
   try_to_shrink_lruvec+0x1be/0x320
   shrink_one+0x10f/0x1d0
   shrink_node+0xa4c/0xc90
   do_try_to_free_pages+0xc0/0x590
   try_to_free_pages+0xde/0x210
   __alloc_pages_noprof+0x6ae/0x12c0
   alloc_pages_mpol_noprof+0xd9/0x220
   folio_alloc_noprof+0x63/0xe0
   filemap_alloc_folio_noprof+0xf4/0x100
   page_cache_ra_unbounded+0xb9/0x1a0
   page_cache_ra_order+0x26e/0x310
   ondemand_readahead+0x1a3/0x360
   page_cache_sync_ra+0x83/0x90
   filemap_get_pages+0xf0/0x6a0
   filemap_read+0xe7/0x3d0
   blkdev_read_iter+0x6f/0x140
   vfs_read+0x25b/0x340
   ksys_read+0x67/0xf0
   __x64_sys_read+0x19/0x20
   x64_sys_call+0x1771/0x20d0
   do_syscall_64+0x7e/0x130

Regards,
Bharata.

