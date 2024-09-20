Return-Path: <linux-kernel+bounces-334007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF86897D151
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BED92846AD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DD536AF5;
	Fri, 20 Sep 2024 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2+WVvEvP"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F449BA20;
	Fri, 20 Sep 2024 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814749; cv=fail; b=lFe+40mGYAOEVs87OHI6xcoAmMN8/++N0H26RVQNzzvTdWZc+gMrC7TJTL4rWAqzDe498+7DBbkF0/S/v2TTz46BTfOvZnnsmBxRhGYoT3idWwSuVzcfZc3uoyJ5vwmjUfm2+p493Uelji0L43Y/hFQT7tiG5/fR/dLyKKVWsDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814749; c=relaxed/simple;
	bh=PTq4BfWalU+psRECnAGX+VdFbzRWXAtRnK9xKFaPJV8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WbGm1m3+N5i12bsr15YCMymGL026MzlqBlnTenx5PTZNUvn5GcsKnIssx49xHgK1c0VituQKp1znmweZ6dkC4bJT34+xMBo4+AJ3af17vLGEucf+8JTsqvllFDIffJMjbARKWH2HZSNRWOInl2CH87Ha+30LDt2d41OxVX2Ztik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2+WVvEvP; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlSRFteqHti8E4CSkZDcMaViaMpcuqddCr7xGYiiciUOZDZ5vCoTNioHipbOlSQg/1c7skw0K4YlXvFOa2yV2F3IhPFDK8lpOSt+uWhuk7lB5NHyhm//eefUSKmVc1Vs51mMG+tFKQRYqPuSONwknLUk7i9I5BMK6zxKAQZp4+gIguJnCpBH6avR/I4smMcVBzKZshIjICgHz2SbmS2unnRhFRlF9O/zv+cEJMbZGKZmKx735TybiPYmA9o5ftvgwNJNfhdcdRZKMQ2W/XSrQp6cqj2mlONYN5bBcVOVaFBE3oVREdNU0toCjeCbTO1LH5bMSynZ8uQTZVGEYiCO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9Arj//GMrzvJiq2rY4F5wIWMc3Pn/Tgl3Ctp7CO0NY=;
 b=TLidawZoaXDQIDhZWnBl45JiStvJ91KBdAzAk9BzDXc78b1ri3/2An/MdTHQbIdTBwqOGG7K9324ZAWxfIfTRAlnoRIDwe09T268IwTFFMkos++qMIVyILLZ1ltJfnpraWQquEgzZRiWSnoNZoOr+YeSd38eFg2abZVD/1XFXMNcJ7EZ0EtR3PvCcMDhsvn8YjEAL7syP2K9zGuLjCWMdvSME9zEAvIcAgge5WuHgooJ4pshdZOTfIaMKB3k7xzntkF2RfjnGRU6EAWbsATIBhz45N3/ZO9iSAwOCWRikSEKLdBA8lsXX55suv47eQ7TTUnhy26lujg5qYMl0PWF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9Arj//GMrzvJiq2rY4F5wIWMc3Pn/Tgl3Ctp7CO0NY=;
 b=2+WVvEvPglzK4wUb3T7BFTlxirJ7NHG/CTbUFljIRNsWmARqrvLH/IwTyiM0ZCLkSDL8doAZ+VAHOV6d4zdEqStOdbmRl2JQOvGJERd2YZsv7YQgVV7LPal62mMPNJxOmT0W9WVh9JxpmDuOGDI/FYp5wmNjWvInPkzNw4SadSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 06:45:45 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%2]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 06:45:45 +0000
Message-ID: <9b0cc2c4-44d3-3038-54b3-d4793b879820@amd.com>
Date: Fri, 20 Sep 2024 12:15:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 0/9] misc: Add AMD side band interface(SBI)
 functionality
Content-Language: en-US
To: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, arnd@arndb.de
Cc: linux@roeck-us.net, naveenkrishna.chatradhi@amd.com
References: <20240912070810.1644621-1-akshay.gupta@amd.com>
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <20240912070810.1644621-1-akshay.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::21) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 485de415-2f1d-4033-62fa-08dcd93fda44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVR6eDVUanNUUy9zblNVc045aTFJb0M3eldYZVlnWGJ6NlZWaUZ2T2FTL0tj?=
 =?utf-8?B?UW5SaVhSNjJ4UnNoYlYxOCtsRStDOXcycVNSd1dnZ0plekoweGR0ckhZcWlh?=
 =?utf-8?B?WTVQdi8rL2RORmt6TG1kajRnWm5ZaXdvbDNOUGFZUWhMRzdxUHpZYm1wSENn?=
 =?utf-8?B?K2FtZ043SU5OSHNVTUdIT3AyL2tCTDYvai9vcXpaSjdrNnA2YjFsN0VFd2hu?=
 =?utf-8?B?UlNvdXVSWG80L25BVno1YjQ3ZTRoQzhSMVZwdkZzNFUzWXdjd1JObEwrQVNE?=
 =?utf-8?B?RzA3Z1N3S3dzRXllMDBZNWhoWTE0VWg4bkhGemhNSnQrbWpUL3ErKzNqRzRp?=
 =?utf-8?B?QmhCK0dnUXdsd3VrQ1I5amxwenpMT2NTSml0emlyd1hLbTlWUTJWY2FSbTgx?=
 =?utf-8?B?RDRKMEM5bGZ2cS9HamdDaHF6UWlMVnkydTRrdURqUGNSMnlIeXc3Qlh2RmNz?=
 =?utf-8?B?UWUxY1Vja3F3aGxUcW1mT3hzSnBGSUZ3cWEwQnBGQ3BPNjUwakRhQWRhV3du?=
 =?utf-8?B?QWNGcloxamlyNEswYngvQlU4R3pJemJYT2NQU1dvMmo3YXFwMTJ6WWdJTDBQ?=
 =?utf-8?B?eHNLNW8rR1ZqYXRrb29lNVlxTnFtcjlNRVE5Q3JESEdGcXdUeVlMZWlGVDBr?=
 =?utf-8?B?MGJ3dEFtOW5zc0Q0K25ESnF5YWNRTzhINTA5TEdrY21oQnV4M0tITEdZcVZm?=
 =?utf-8?B?QVFGMDBEQ0NjMEMvenVFQzVNTDVuTXVnS2dYL2pJREk1eDBaWnp6eUY2bmtG?=
 =?utf-8?B?K0Y5WEJxUldzQmFVZ0ZpeHM2Q05SMVlCaFZ6Ylp0TWM1UWk4a0lTL0lTSHhE?=
 =?utf-8?B?dTFVS1FhVVRwTTNnV3lvdERJNm51TlVkS0RxYkN0RDZNVTFjclZPSjJkSUhY?=
 =?utf-8?B?NUVZRjFGTUNjaFpYN0R0dzkwWlV3dTRmU3IzdCtwV1BsV0VLOEdYTnI5TVZz?=
 =?utf-8?B?eURrOU5EWGFxVzJtMHlMRWxhaHJYMnlja2EwbEdPcUNBbHI2QzFKM0ZRRHR2?=
 =?utf-8?B?SlQ0d3hiZGRkV1RRcHZuY0x2dEZ3Y1BzV2ZmbE12Tkd0ZHVFRnA1em9PU1k3?=
 =?utf-8?B?WjRIdUsvT1BEWFVtQ1N0ejczekR6a2wxRk91Yi83bmpYRkZRWWZldmFVQVN1?=
 =?utf-8?B?RW1lcnNma2V2YndXOFlMRXV1ZHp0N2t5dTM0ZW56N0RPZVU2SG5Cbjd6Nnhm?=
 =?utf-8?B?OWlNNFp5bGs2YUZmb01ZY2hxYi9vcFc1WnpSK2E0SFZVOUxLc2kzY1Bkclk3?=
 =?utf-8?B?bjVua3dodnR3eEorOGZaQUJoaXlkQlFDa1hzdWdzemUxdUUyUmliUmhVTzJ0?=
 =?utf-8?B?aElWQWdQUGticDRzcEpoQTVlK1RSS2h0b29rb2RyVHEwSTdFYkhxbVlxcXhl?=
 =?utf-8?B?WDVXdlo1QUVDK25uYXFvWlNZc0FUZVJLUysreDMwOG4zM05DQ0R1cGtUL3NU?=
 =?utf-8?B?eEVXc0pVZmFXdmgzOVJzam5nWG4vVVM1QjhqVXQzdVgwR0Zyb2NaMEN5cm1q?=
 =?utf-8?B?Rlc3MEpsdU9QWFc1c0JlNTM0VFBFcnNJaFV1NXU1amQ5dk5rUmhXdTFiNFBs?=
 =?utf-8?B?UGN0ditOcDdKRi9pQVhUZ0NiakY2aHZIMFFGRVlCS3lQbCtpb1NCdG5RWHdp?=
 =?utf-8?B?TnBIbU5jNC9tS2hMVFJDVUhJNlhVZ0MvRCt0a0tsKzg2QnZiU1JhWnFCZzRB?=
 =?utf-8?B?aXJLRlpKazBQZXFRQnRhNVlhTG5VTWd2VlNjQ2FCdjNDTmlaN3A2L05MVWxJ?=
 =?utf-8?B?dkU4dGQ1RE5vRUwrYklMVlM5Vm9HODB0Q0ZDSks1SzZJQnRFV1RrMERZMzJU?=
 =?utf-8?Q?HHVZLt7k8vuzYNmmMzVfAggN0oEv38xK0YQ+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnE1Z24zQTE5MEwrMnFDRHJnTFhZRms5TFlRd1VhcmJtR0NidzloTktVZXQy?=
 =?utf-8?B?Z21vSWRMVGZodUFZcFFpVU8xeit6QzVYNWYzdUFKMjhkM285QytWNzhFWFhM?=
 =?utf-8?B?OW1tRmhHUTA4Y0ZlaUxGZUl0N1AwMFgzdDQwM3NBV1hsbWJOVlFPY0J0UW1N?=
 =?utf-8?B?RWJIQkFrZjVSYzdtcDlkcWxRSHdZa0w5b0czOVBpeHpxVVdkRnVxbTZQWWtF?=
 =?utf-8?B?R0tBWExQUTgrSFpXU1FLWVE1c2pwc28yd3lUOFhNV010MWp6MHdZcGcrK25P?=
 =?utf-8?B?UjhvbGNlVDhzSEtiYldVdEZuTFpUUHh0NlpmajJnN2VKZGs2MUM3dDhsQ3ZY?=
 =?utf-8?B?Slh6dXpGNld6aUZjc1lHTUplNUlza3ByUEFnMWZFekRHNzRaOTVxU1VVZU1m?=
 =?utf-8?B?bHNTZDlFcFRRa09sZ201WlNJL3pQMkFCQ0hiRU9TdHZkMjN6cEhzRDcyT2hN?=
 =?utf-8?B?anZ5MmtVUm4rY3plZmJPRjRqbXNhNDRQWDBaeHcycFpETEJOenMzOW95OWND?=
 =?utf-8?B?RmR1eDRnbTd6VVhEbkZ4N2Z3OUw3N0V3bEtVZXBNa1VYVXlWem1zR1VvNmhq?=
 =?utf-8?B?dlR6TXdaeE5XcEJDY24rLzY5cXZzdjFSSTJ5M0NlMkJNKy9YQkFhL2hDSU5B?=
 =?utf-8?B?RXA4N1NHYmVoNHdKbjN5Sm9odTBteWZRc2t2Ym5wWCtjK2FrN2ZaSnU1d0Yw?=
 =?utf-8?B?a1IyWnNsSG8xYWJrbytwK05XMlF6MjZ1Sk4rMDdnSHpOUUNFR3lUd3dsRlV4?=
 =?utf-8?B?c2dzM0lmWGgxUWptcmFZWHRpTHJBa0wwb0F4WnJ6emhaOGgvS2UzV1hDVlAv?=
 =?utf-8?B?cFJiVjBXU2pxYVl6dE51MjlNNWQ1eTRYVXNQVXVmdys2ZDlXbU9OeCtXYXVs?=
 =?utf-8?B?WGNUdk9qTlFBc1UrRDFhc3AyZjZMUVQ2OWxnRHVIWnFSUHN1ak1ZZGRIcUdh?=
 =?utf-8?B?TzdWNHdSanpkSnl0LzhDRTdBUERDc3ZJT2tWV044T0VER1dWZUJLUDBMWmVD?=
 =?utf-8?B?WHp0bHh0Tm9IaG1JdWFpcnhLZjZwdkdEM2J4eEpKSGVGb04vRkpkVVI4UG1P?=
 =?utf-8?B?dmJBazZZRWNsMWFTblF0MUwvWnFkM2Y0ODJtZUx0M1VHeTVGTUtiSG1OU0Rq?=
 =?utf-8?B?OVFtSFJTMUNFemV4eWdFYjN4WUdYcEVVczhXSDl4ZXJzeXY3aGtjOVBWZThC?=
 =?utf-8?B?MnZBak1uSDJPdjIrRkY4UGlrUUgwZU90NVJKd0kyZDdBMXFuZEsxeDBsajBv?=
 =?utf-8?B?dG5YUWVYZEg1V2RuRXNPSytOeUNmaHcxMEpXVGJCbm8xQ1NDajJEaXdXZnBF?=
 =?utf-8?B?SWVxdXRuRytzYmpkODJyWWpJNm5QQ1N3RFlaTzF3WUJvblhiRWp0MkVmS1N4?=
 =?utf-8?B?WXZZRUErSUFadEtJT1lWNjdFWWx2MmsxeldET0NSWkZVYXREU2RDbEtBb0pX?=
 =?utf-8?B?SEdyVGorR2hRM3RTTjMrVnpJSWVvM3hJSEM0S3BGZzNmZ3ZOZU14bitwTHZZ?=
 =?utf-8?B?S3B4TTc3dmVuN3phS0crU3VvUjN2MXhLZjNYK25oR3JmdjIwRUFzYUpWZndP?=
 =?utf-8?B?andDRU1XeWwwdmthMWhPSzlaT0ltWGFhSkc2eVdTRDZUVGdaRFJZdW5rNERG?=
 =?utf-8?B?QzZ6Sjk0aGViN0hTdmZDRGp5ZHRHSll5eXBFYys5VlRWUjVhL3JTMUZrSWZp?=
 =?utf-8?B?SVc0eUduVWY1WlhnYm42T0JWVG1ac3V1WElGcExqRUY0QzJjQ0xLS3VUN2xU?=
 =?utf-8?B?SnJET2wwQnRpKy91ZW5OamsxSTF0dnJ1ZzlobnZzN3B5emRwelNTMWVCN2dG?=
 =?utf-8?B?L3g0S1dnL2RIZjlqbW9ZRnNIK2FoemQ3YTlZWVdmMW1LMHI3NGtxaUg4UnNN?=
 =?utf-8?B?YUFDbUt4RUgwQzdxVTIvSXJuNUJoRjBaOVgrekFySk5MQUx4aDh1cjE2QUcx?=
 =?utf-8?B?ZlFGdSsyWWtNem41NDl6b3c1VXR4RE9yTEtYZFd3QXRtQUtMSTVSUDNTdDFw?=
 =?utf-8?B?eEt2azZNcHRLZ09jdGk3Z3JZQUtEUnJNNmZ1cXFYOGtrTUlKL0VyUFl3WnNs?=
 =?utf-8?B?dFZENUc3Sm1LQ0tRU0dIeWNTVVp2SlBLcU04RGg0dDdqeGFtczR1dGp1RkhC?=
 =?utf-8?Q?AL0RSrL5Q4KkRBGZemKju/PT2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485de415-2f1d-4033-62fa-08dcd93fda44
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 06:45:44.9379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rkIliL3jyp9DOuzSBqfp5hw1f8TwjnUZWKtcak1cl4x4gMVo1s8n1mKwC1OVP0UJBE7+XcplMMsWbqUBz/rsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884


On 9/12/2024 12:38 PM, Akshay Gupta wrote:
> AMD's Advanced Platform Management Link (APML) interface provides system
> management functionality accessed by the baseboard management controller (BMC).
> sbrmi driver under hwmon subsystem, which is probed as an i2c driver and
> reports power using APML specified protocol.
> However, APML interface defines few other protocols to support
> full system management functionality out-of-band.
> Out-of-band management is term used for BMC talking to system management unit
> (IP in the processor). AMD's documentation called this link as side band interface.
>
> This patchset is an attempt to add all APML core functionality in one place
> and provide hwmon and user space interface
> 1. [Patch 1] Move the i2c client probe, hwmon sensors and sbrmi core functionality
>     from drivers/hwmon to drivers/misc/
> 2. [Patch 2] Convert i2c to regmap which provides multiple benefits
>     over direct smbus APIs.
>      a. i2c/i3c support and
>      b. 1 byte/2 byte RMI register size addressing
> 3. [Patch 3] Optimize wait condition with regmap API regmap_read_poll_timeout as per
>     suggestion from Arnd
> 4. [Patch 4, 5] Register a misc device which provides
>      a. An ioctl interface through node /dev/sbrmiX
>      b. Register sets is common across APML protocols. IOCTL is providing
>         synchronization among protocols as transactions may create
>         race condition.
> 5. [Subsequent patches 6, 7 and 8] add support for AMD custom protocols
>      a. CPUID
>      b. MCAMSR
>      c. Register xfer
> 6. [Patch 9] AMD side band description document
>
> Open-sourced and widely used https://github.com/amd/esmi_oob_library
> will continue to provide user-space programmable API.
>
> Akshay Gupta (9):
>    hwmon/misc: amd-sbi: Move core sbrmi from hwmon to misc
>    misc: amd-sbi: Use regmap subsystem
>    misc: amd-sbi: Optimize the wait condition for mailbox command
>      completion
>    misc: amd-sbi: Add support for AMD_SBI IOCTL
>    misc: amd-sbi: Add support for mailbox error codes
>    misc: amd-sbi: Add support for CPUID protocol
>    misc: amd-sbi: Add support for MCA register protocol
>    misc: amd-sbi: Add supoort for register xfer
>    misc: amd-sbi: Add document for AMD SB IOCTL description

Hi Greg, Arnd,

You have previously reviewed v3 of patch set and I have addressed the 
review comments in v4.

Can you please take review v4 patch set?

Thank you.

>
>   Documentation/misc-devices/amd-sbi.rst        |  84 ++++
>   Documentation/misc-devices/index.rst          |   1 +
>   .../userspace-api/ioctl/ioctl-number.rst      |   2 +
>   drivers/hwmon/Kconfig                         |  10 -
>   drivers/hwmon/sbrmi.c                         | 357 --------------
>   drivers/misc/Kconfig                          |   1 +
>   drivers/misc/Makefile                         |   1 +
>   drivers/misc/amd-sbi/Kconfig                  |   9 +
>   drivers/misc/amd-sbi/Makefile                 |   3 +
>   drivers/misc/amd-sbi/rmi-core.c               | 452 ++++++++++++++++++
>   drivers/misc/amd-sbi/rmi-core.h               |  67 +++
>   drivers/misc/amd-sbi/rmi-hwmon.c              | 122 +++++
>   drivers/misc/amd-sbi/rmi-i2c.c                | 135 ++++++
>   include/uapi/misc/amd-apml.h                  |  97 ++++
>   14 files changed, 974 insertions(+), 367 deletions(-)
>   create mode 100644 Documentation/misc-devices/amd-sbi.rst
>   delete mode 100644 drivers/hwmon/sbrmi.c
>   create mode 100644 drivers/misc/amd-sbi/Kconfig
>   create mode 100644 drivers/misc/amd-sbi/Makefile
>   create mode 100644 drivers/misc/amd-sbi/rmi-core.c
>   create mode 100644 drivers/misc/amd-sbi/rmi-core.h
>   create mode 100644 drivers/misc/amd-sbi/rmi-hwmon.c
>   create mode 100644 drivers/misc/amd-sbi/rmi-i2c.c
>   create mode 100644 include/uapi/misc/amd-apml.h
>

