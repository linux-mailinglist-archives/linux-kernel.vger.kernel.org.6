Return-Path: <linux-kernel+bounces-245153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90DB92AF07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DFD282A4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E187F476;
	Tue,  9 Jul 2024 04:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gPzo9nYy"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2059.outbound.protection.outlook.com [40.107.117.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE2C620
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720499043; cv=fail; b=rbqC+Hu7k0CZZTx3XYi78lKv5n9wsFQzDdADqaPCyG0uzPdLj5piTiwd/lO1VJgTIxVcJJj6/ClYpdDNPNTcUnm5OeCTDIO5UnOlro5X2GlSOlv1lrOI7gu3XXBve0BMkZVn7yUeSDoh+x47Lf0z0iHJfEkJcp0Lz3R+FAQy/7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720499043; c=relaxed/simple;
	bh=mWZqrh3BX/nQt2fEha5tE5PplXfk0LNWysZKzeBJZtA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aFqC6QpqlXfNGZioiggGmruyrQHA0BhUVVTVR5dbEusP9KFxvk5DveY01qUDj0SbP1bXg1gxw4/YrCL1Bu9Jq12LYNxm6AI+cZneuf3Rz5uoJnrgj9b40e5IE+c0jx9sgrkUQrRnMF/iImFLQieIrIa7565SVAq5M6rbdoDdazk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gPzo9nYy; arc=fail smtp.client-ip=40.107.117.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWk6Dx77QXU4BeoTQGvqIvYojrTBrtUlp0TFtIBEhLrvHXiSNeqUeiIPyXuHminXFu0GYJb7LbQTap9ui9ilDv+gBTyvMSnb5NYBBu9LePakNUgfp49x8zFfOZYHLh4OYleX1LSgA+iumtL8TfprhWVJnQF/vP6wf5Fv2cd4f5FZlpfA365hfvLm3+7tvgj9RiRNWMfVbE5nwq8h5oCPADDADIQ2yNKN8YCTONdFKW3zEGpXZ6ZPPAT09rQjlV3IRLLI+fnYOdk47aw/atNrey6Bbcm3N/WXKI208Qac303vuHYto/kOVGIWZsJtYSkw51+uH/UCDcfo8huEg00f8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEz5YGHSmCd73GD4lVcFrmlFGAJRzUuq4imxDRKVoUw=;
 b=b43vDIvwvYj7vt1nB3xnygpIjZhDYyI5vtzfs/e1CJKNsZhBS6hqxTcalw1qdnlLi2Rm2QjfHHuJzfQtuG10lrWG49v3Wlh22L5UBR9e/is4E+j/GJ4F3E8tIubyCI48AWNfdKxbQpJ8H41uxwaQHQxhStTqbO4uXLouXkLbA8PD4XKeZNpaDM6h7EPe4LLm/k2vecb1HOO9os4mUhGUMGo6nWw/MEXPBr+8ACPLiBvpN4+UnjOUU1VpJFO2QGngb5QkUnq0PX3nF7S5Ly2meCs63Tw0mltAQqnXlrUg9gfplyW9dtVI8Ga9AT+teLKpSHou77h+ObD7P3zyjRm6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEz5YGHSmCd73GD4lVcFrmlFGAJRzUuq4imxDRKVoUw=;
 b=gPzo9nYyjSVuSX6V87GtW2yyycEElcwAW6SzpTidaJMuodWh7y4/rGsQxwRnWix54YpiIhlJ5004u6YUwDpPd9P2V3xlyr/DX+bcUsR6A20+xUzfyolil24q+xukINHy0AtqReMafIeoDrzhlGnEKoABvgl4j3QBke3mo/JIZUhNHU/QcSNeJMOUu3HwJgOTdNiot7p5O0MSK1pToaRVm9b7bxddnxnaYGIuGaclMYqtyTs+QUny+q5J40ZO0h8Z4UNfbLB2crNxZp1B/GsBDo5CBtXUGHuETm0bNKu8XbQ9gxCY9UrELbtp5BgNm2AUW7HCpZkSDNFcprMou38XSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB5100.apcprd06.prod.outlook.com (2603:1096:400:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 04:23:56 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 04:23:56 +0000
Message-ID: <d2c24550-1274-4611-a26e-24b204da8778@vivo.com>
Date: Tue, 9 Jul 2024 12:23:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm: shrink skip folio mapped by an exiting process
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>
References: <20240708090413.888-1-justinjiang@vivo.com>
 <CAGsJ_4yrGR5ULU=MDXZq+hEDb+TWuRkfbg9V9Rg=mGAWOpUkxQ@mail.gmail.com>
 <122bbe20-f2ab-4d44-97ac-76df8469d3fa@vivo.com>
 <4ca9836c-4f03-4792-9be8-f7db71a2b162@vivo.com>
 <CAGsJ_4xMrzTfAC8wicK1-CLftXY-Bm+mZ8BnD=ZvtmB_NKzbKA@mail.gmail.com>
 <cf6c6d1f-3719-4744-b943-5c572d0d5fb4@vivo.com>
 <CAGsJ_4wE9pZoGoWoJD6R09uAppNqeycUdFUy0E8ZSUi4VcwaMQ@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4wE9pZoGoWoJD6R09uAppNqeycUdFUy0E8ZSUi4VcwaMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2c6434-5b32-45f7-1404-08dc9fcef2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm5MLzBCN2o4MW9OMUxlYlNjckZBaVNFaHlsdUhwc2VJNExDWHc4WjhzQk5U?=
 =?utf-8?B?QWdLRXIzd2NiYTJCcmlnRjFZUlZWQjlWRDNGdmwvSENsZm1sU25TTWxObmJL?=
 =?utf-8?B?Sm5GVGpaK244M1RVMG8yWVFmL3FEV3BDTlpvdGRNY0t5Vm5YRnZjTkY1dm8x?=
 =?utf-8?B?cmUweHdDMDE2SlJVMUNqeWhZQ0hOcTBFTWZEeTlhZGh5YlVJWFNPS25EajhQ?=
 =?utf-8?B?WXlOZ0VaN0xnWGZKb2VTczdvUU5SVGwvUTE1WS9zOU1hc2hzWW56ZTRIMXFH?=
 =?utf-8?B?Zy84VFhERTFCT1U2bjcxaFF1bmxHQnRWQkdXNk5udlhIajNlVnJYZlc0OEJs?=
 =?utf-8?B?Y05nQklSWXRKckYvUEUvejJSUTZKMVhqYnN1V1J5WkRUOW91aVM3QWt3OS9O?=
 =?utf-8?B?MjRxaCsweXh5UWZRYmZwYkVlQ3VjYnR5Z09JeDYwSmZBQ09Bc3krNFFlYTVT?=
 =?utf-8?B?aU9BZ1hKVVppMDdBdnlYWEkyU0IvMlF6emhFaTVzTGVxQnpTS0w3ZDBZMHc0?=
 =?utf-8?B?YzlKVkN1QVp3R3BFMHRMWE1TRU5nZE96dEFQaVpnK1N4UFVKQTdmTTdVd2NS?=
 =?utf-8?B?RUxRWDhGUytUMGdRZmE2NGhyN2xDSG1aRnhQQ094ODkvVDNSQjBoZW5tVUw0?=
 =?utf-8?B?SGJlMW9MbFlrMzhYakRUVlFMMnpiUlZ2Wm9xSktYVDY5bzRQNW5tbW9IOTVo?=
 =?utf-8?B?c0hpTk5OS3hxY1c4bjBQRitRbWJINDYyWWkrZEZXampGNUUrNCtSVlFLTnZs?=
 =?utf-8?B?clBYcWJpaXlOT0hETUpwRk1zSmsvYUxqc2RnWDZyY3orcGFkcWdBbnRZOGRC?=
 =?utf-8?B?WEJ5K2NSczVjLzV1aE1vTmxDQkpqWFJSZVJvU0FMR1JYWmtpVFZGZkdjbUN0?=
 =?utf-8?B?VkhIRGRtZUZENnM4MldRR0k3TyszbEVNOWw1TFllRVZJWDNYeUNYcGNIb2Nt?=
 =?utf-8?B?aE1WQVd4NDF2NHo0NFFORit5blZRTFYxZExHdnRjTDhBVGlUVkMvdHlKMnpH?=
 =?utf-8?B?NUV5T0czMEwxT3VJdUNQbGU1dHhuQk5FczJlbWF5Z2wvZXBDcWp3UlhVUTdB?=
 =?utf-8?B?dS8raERzQUlaeHN3amRYQ3N4S0FQay9QUUNsSXdsN1Z4cFhIRnFxdmlvY2R3?=
 =?utf-8?B?NFlvSS9haUVyZmFuSWdmU1VrNkRVQXZVbTZ6V0FVUTkxaDg4MW43d2JMd0o4?=
 =?utf-8?B?L1IrSUw3eWlBY0gyb3dQWmlRYmpwZTVPRGFINmljVXhMVUlabytNTFRnbVhI?=
 =?utf-8?B?K01WNWtRUVhRZjVEYW1ONTJvVnE0YkxLcU10aXVvZm1XTk1rYksvMXlGVUli?=
 =?utf-8?B?SEZnQU81V3VSOG0wdWpQUVlXRXZCK2RDN25TN2ozRDBXd0lscnpwMkR2NWoy?=
 =?utf-8?B?aERwd084VnIyS2lQNXp0eEFuMi9ZM0JFRVoyMmRHYkczNnV6aGtCaEs1Qjhp?=
 =?utf-8?B?M08vMWMvTHVZWENpZVJMZTY3RjAvRXJYMkNIWHQ0Tm9kbW1iRDBvdzkwVk1j?=
 =?utf-8?B?Mjg5b3NKS3Fsb2NEVE0xeE51YnVYOXJJSVZ3cWlmdkJIdDNVcGVLT2o2NkE0?=
 =?utf-8?B?QVd5bHg5c1VCZnJaYUw2anBVdUZHMkFLdElHa2U3ZjV4S1BZVWJpUGtnNWFM?=
 =?utf-8?B?b0puQWdRTW56N1ZPRGVlYlk0MHFQYnNiTU05TkdzanlLYkFhOHUzcnZ0TlMy?=
 =?utf-8?B?RWg4bHJHU0JmQmVCZ3pBTkNqaEwzUUVKcjRDUnBGYURBVEwwblF5VXdGYzkx?=
 =?utf-8?B?d200ZncyWVZaQWMvK1Vhalo1N1hCZWExZmNuTnBzb3JCdlRLZGh0VDNvSVc5?=
 =?utf-8?B?U3B5c0JNVVZaY3h0aWZEUm1FK3FkWmxla1dSLzM4VWN5Qzl1WmhHQ21zWlE1?=
 =?utf-8?Q?0OM76zfDwHwIa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emZZR2JxRHdyeVRaWjU5NlB3M3g1cE1Sa1Y1L2dZQUZXczJacEY3TzRNRkIy?=
 =?utf-8?B?c0FFRXBHN2FLTDNOWFlOa0RoSFhHVk5kSzI5WGVoaFlPZTFvTU8zU1FFQzJr?=
 =?utf-8?B?YVZQRkpZaUdmYkQ4NmYzb0h2UVZyM0RiZzFMQlQ5ZzdlQW9BcS9sTXI3ZlBY?=
 =?utf-8?B?Z0lRMVZpOFBpdUJrOXYvUFZUWS9nelZENzRyN2hrUkVSV0lNeGFIT29ZUyti?=
 =?utf-8?B?Y0dtZnFCejQya3hHRkEvamFuOXIzdklPdkZxZFd1SDA0eWNHSGZpOVovY0c4?=
 =?utf-8?B?ZWZBRm5KTHZjVlZXREhvbDMvYUttWkRwc3BXSEVETE9NVm1aeU51ZVAyendT?=
 =?utf-8?B?M0RvUWQwdXF2REJSOTFUVG1hSC9ZWTBVSmdCaHhpZVVKUmxubEhYcGpxcXY3?=
 =?utf-8?B?Z0d2WkhEKzNsT0NJM0UrOXlOR2VRQjBhNFpBQkNvSWsyeUdmMU5ITys4Qzcw?=
 =?utf-8?B?cnMwdllMelVLRWVybktNN2NGeEh1ZlcxNnhULy9YczZSSFFvSUxpK2c2aEc2?=
 =?utf-8?B?czEyeFcvR1E1UzREZmpHSEVjV003Z0tuejZBREFjaE1XR0xTSTVCS3JtSW9k?=
 =?utf-8?B?L3lQUUFxUmJsazdvdUNMQUJtakozTmZ0ZTl0VHR2cFVDRFBzOHYxbVkrQjRX?=
 =?utf-8?B?RmR4ampIOGxORVk3UE5oc1lMTkMydjJadDhhbzU0SHZ5cUV2UzlGS1Q4QzRk?=
 =?utf-8?B?cyt6c09henhOd2g3bXZrRW5ZMUl5OGdKUkFjV0xUNlNIM0UvLzc4QUY3M3Fr?=
 =?utf-8?B?blVSZHdNNWE4b2MvdGh2NmlpVi9qMFA2U2wybHhxelFFYmVvWG01TEtPV3Yw?=
 =?utf-8?B?c0pTTnFOWjVqcUh5YUU4aEJlUXRRbnR6TTc2OTdIekRMTmRRckRxWmJVQ2RT?=
 =?utf-8?B?VmsxSmpkbmNWTEdMTkJTZlgrME9vVXc2ZmNDZDBtRml6TjdTeGg3aTE4MXhu?=
 =?utf-8?B?b1A4MWhNV1lueEU1czBnV21HV21rSVlub01WN3hGZUx5MjRrOXJobXRUbHJw?=
 =?utf-8?B?SG9rMnhzNkc1TU8ybzI1cjFiOW8vRlNPL0hPVER2S0tlOGExU2hlczdlY21j?=
 =?utf-8?B?eld3MFNESlVsZlgyTmF1cEtMZk1ka3BiQWRpaGtNZ2dobjRpc1ozUWxZeUlS?=
 =?utf-8?B?ajVDb0lEL0F0cEN1emxNeVBPLzAvbVZsVElXM2twUXhjMnVBMlpBczNUbXhx?=
 =?utf-8?B?dmlqcEhlVHhkQnNJTVN4RlVBMWE5MTQrSVY3bS9LMGZsQ0hsN05ydHN6QnA2?=
 =?utf-8?B?K09BNEZrQkZDTFVwYjZKK0Q4UDNkMnhWckdkeU5PQ1dhZ2VXRTRPbUEyM0U3?=
 =?utf-8?B?V3huWWhscm9wajZCbldBb0E4RzZnYWZzVVplYk10SHJGR1pjVlkrUm5iOXox?=
 =?utf-8?B?dVFDSUpheldwQ3p2T0FSSTNaQ3h5NmhCREJJUXVLblBJb1JIdHhWbm5zelpx?=
 =?utf-8?B?VG5LSVRzOEJlbVBBVDY2ZUtRTjRrbE5PUm9rcjRERm5STGIyS0h5WVZaK2Vu?=
 =?utf-8?B?UTJ1cEd2ZjdVakVkcTVCM2F6eG05RktyMlpIcFFQaWYxaGM1ZGhNS1JQOFQv?=
 =?utf-8?B?N3ZOMnhHc1NDQXppcmpFRkJTWTFKTlErSFpITU5RRjdINDRheVJndlRPMjFv?=
 =?utf-8?B?Q2g5VnU1L3o3ckplNzB1c0QvR0h2UVhrclJ1QUh6ZnJyTjVIUTdUYTExbFZq?=
 =?utf-8?B?Y0xEMVZzR2FBSzdXRnlKQ21NVm4ralhCVE5TSUxsRm9IOWg0QVpCTVdIQytQ?=
 =?utf-8?B?OEd4dDBya0R6R3VCaStOaFcyTU1BSjFrY2J6ZGhIZGFRMTA3WFN1MU9Wc0hW?=
 =?utf-8?B?ZFQ3dUpoWDQ0NGtXcm1zL2RCOUdqTmdEVjh2ZDBxNlEvZ1pQR0FKLzFyaFZx?=
 =?utf-8?B?NTYxVStPZFloaDdpam82RXdqRjhMdHVJZnRZTHEwSXQyankwUnU2WFlUWWtq?=
 =?utf-8?B?bjFYMnFFVjVya2toZkNqbVdZQ1dIVFFlZ3Q2a0VtTnQraUJPeW9BaS9PL0tx?=
 =?utf-8?B?QW55NGtaaGdFaDZ2c3dHYlV6bHlSQU1Zd3dFQmN1Ykljc0d3UjBwcWRtM3Js?=
 =?utf-8?B?UUJuUDF5b2FVTU52d09rYllLK3IzN1J6dldjUFhPU0lPdkM2T2ptdEh6a3lH?=
 =?utf-8?Q?usQKWrd8WcEIEjLlAeybCpOWJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2c6434-5b32-45f7-1404-08dc9fcef2da
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 04:23:56.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKWzWvNr2Z1F/JLVC6Azf/znFI9GYHmqKald5RsUJbqVIMK94e+xm3fykStOx/ZXtIWf89qsOQ0E3WdVl7lP9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5100



在 2024/7/9 5:34, Barry Song 写道:
> On Tue, Jul 9, 2024 at 1:11 AM zhiguojiang <justinjiang@vivo.com> wrote:
>>
>>
>> 在 2024/7/8 20:41, Barry Song 写道:
>>>
>>> zhiguojiang <justinjiang@vivo.com> 于 2024年7月9日周二 00:25写道：
>>>
>>>
>>>
>>>      在 2024/7/8 20:17, zhiguojiang 写道:
>>>      >
>>>      >
>>>      > 在 2024/7/8 19:02, Barry Song 写道:
>>>      >> On Mon, Jul 8, 2024 at 9:04 PM Zhiguo Jiang <justinjiang@vivo.com>
>>>      >> wrote:
>>>      >>> The releasing process of the non-shared anonymous folio mapped
>>>      >>> solely by
>>>      >>> an exiting process may go through two flows: 1) the anonymous
>>>      folio is
>>>      >>> firstly is swaped-out into swapspace and transformed into a
>>>      swp_entry
>>>      >>> in shrink_folio_list; 2) then the swp_entry is released in the
>>>      process
>>>      >>> exiting flow. This will increase the cpu load of releasing a
>>>      non-shared
>>>      >>> anonymous folio mapped solely by an exiting process, because
>>>      the folio
>>>      >>> go through swap-out and the releasing the swapspace and swp_entry.
>>>      >>>
>>>      >>> When system is low memory, it is more likely to occur, because
>>>      more
>>>      >>> backend applidatuions will be killed.
>>>      >>>
>>>      >>> The modification is that shrink skips the non-shared anonymous
>>>      folio
>>>      >>> solely mapped by an exting process and the folio is only released
>>>      >>> directly in the process exiting flow, which will save swap-out
>>>      time
>>>      >>> and alleviate the load of the process exiting.
>>>      >>>
>>>      >>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>>      >>> ---
>>>      >>>
>>>      >>> Change log:
>>>      >>> v4->v5:
>>>      >>> 1.Modify to skip non-shared anonymous folio only.
>>>      >>> 2.Update comments for pra->referenced = -1.
>>>      >>> v3->v4:
>>>      >>> 1.Modify that the unshared folios mapped only in exiting task
>>>      are skip.
>>>      >>> v2->v3:
>>>      >>> Nothing.
>>>      >>> v1->v2:
>>>      >>> 1.The VM_EXITING added in v1 patch is removed, because it will
>>>      fail
>>>      >>> to compile in 32-bit system.
>>>      >>>
>>>      >>>   mm/rmap.c   | 13 +++++++++++++
>>>      >>>   mm/vmscan.c |  7 ++++++-
>>>      >>>   2 files changed, 19 insertions(+), 1 deletion(-)
>>>      >>>
>>>      >>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>      >>> index 26806b49a86f..5b5281d71dbb
>>>      >>> --- a/mm/rmap.c
>>>      >>> +++ b/mm/rmap.c
>>>      >>> @@ -843,6 +843,19 @@ static bool folio_referenced_one(struct
>>>      folio
>>>      >>> *folio,
>>>      >>>          int referenced = 0;
>>>      >>>          unsigned long start = address, ptes = 0;
>>>      >>>
>>>      >>> +       /*
>>>      >>> +        * Skip the non-shared anonymous folio mapped solely by
>>>      >>> +        * the single exiting process, and release it directly
>>>      >>> +        * in the process exiting.
>>>      >>> +        */
>>>      >>> +       if ((!atomic_read(&vma->vm_mm->mm_users) ||
>>>      >>> +               test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
>>>      >>> +               folio_test_anon(folio) &&
>>>      >>> folio_test_swapbacked(folio) &&
>>>      >>> + !folio_likely_mapped_shared(folio)) {
>>>      >>> +               pra->referenced = -1;
>>>      >>> +               return false;
>>>      >>> +       }
>>>      >>> +
>>>      >>>          while (page_vma_mapped_walk(&pvmw)) {
>>>      >>>                  address = pvmw.address;
>>>      > Sure, I agree with your modification suggestions. This way,
>>>      using PTL
>>>      > indeed sure
>>>      > that the folio is mapped by this process.
>>>      > Thanks
>>>      >> As David suggested, what about the below?
>>>      >>
>>>      >> @@ -883,6 +870,21 @@ static bool folio_referenced_one(struct folio
>>>      >> *folio,
>>>      >>                          continue;
>>>      >>                  }
>>>      >>
>>>      >> +               /*
>>>      >> +                * Skip the non-shared anonymous folio mapped
>>>      solely by
>>>      >> +                * the single exiting process, and release it
>>>      directly
>>>      >> +                * in the process exiting.
>>>      >> +                */
>>>      >> +               if ((!atomic_read(&vma->vm_mm->mm_users) ||
>>>      >> + test_bit(MMF_OOM_SKIP,
>>>      >> &vma->vm_mm->flags)) &&
>>>      >> + folio_test_anon(folio) &&
>>>      >> folio_test_swapbacked(folio) &&
>>>      >> + !folio_likely_mapped_shared(folio)) {
>>>      >> +                       pra->referenced = -1;
>>>      >> + page_vma_mapped_walk_done(&pvmw);
>>>      >> +                       return false;
>>>      >> +               }
>>>      >> +
>>>      >>                  if (pvmw.pte) {
>>>      >>                          if (lru_gen_enabled() &&
>>>      >> pte_young(ptep_get(pvmw.pte))) {
>>>      >>
>>>      >>
>>>      >> By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
>>>      >> &vma->vm_mm->flags) is
>>>      >> correct (I think it is wrong).   For example, global_init can
>>>      >> directly have it:
>>>      >>                  if (is_global_init(p)) {
>>>      >>                          can_oom_reap = false;
>>>      >>                          set_bit(MMF_OOM_SKIP, &mm->flags);
>>>      >>                          pr_info("oom killer %d (%s) has mm
>>>      pinned by
>>>      >> %d (%s)\n",
>>>      >> task_pid_nr(victim),
>>>      >> victim->comm,
>>>      >> task_pid_nr(p), p->comm);
>>>      >>                          continue;
>>>      >>                  }
>>>      >>
>>>      >> And exit_mmap() automatically has MMF_OOM_SKIP.
>>>      >>
>>>      >> What is the purpose of this check? Is there a better way to
>>>      determine
>>>      >> if a process is an
>>>      >> OOM target? What about check_stable_address_space() ?
>>>      > 1.Sorry, I overlook the situation with if (is_global_init(p)),
>>>      > MMF_OOM_SKIP is indeed not suitable.
>>>      >
>>>      > 2.check_stable_address_space() can indicate oom_reaper, but it
>>>      seems
>>>      > unable to identify the situation where the process exits normally.
>>>      > What about task_is_dying()? static inline bool
>>>      task_is_dying(void) {
>>>      > return tsk_is_oom_victim(current) ||
>>>      fatal_signal_pending(current) ||
>>>      > (current->flags & PF_EXITING); } Thanks
>>>      We can migrate task_is_dying() from mm/memcontrol.c to
>>>      include/linux/oom.h
>>>      > static inline bool task_is_dying(void)
>>>      > {
>>>      >     return tsk_is_oom_victim(current) ||
>>>      fatal_signal_pending(current) ||
>>>      >         (current->flags & PF_EXITING);
>>>      > }
>>>
>>>
>>> no. current is kswapd.
>> Hi Barry,
>>
>> It seems feasible for check_stable_address_space() replacing MMF_OOM_SKIP.
>> check_stable_address_space() can indicate oom kill, and
>> !atomic_read(&vma->vm_mm->mm_users)
>> can indicate the normal process exiting.
>>
>>           /*
>>            * Skip the non-shared anonymous folio mapped solely by
>>            * the single exiting process, and release it directly
>>            * in the process exiting.
>>            */
>>           if ((!atomic_read(&vma->vm_mm->mm_users) ||
>>               check_stable_address_space(vma->vm_mm)) &&
>>               folio_test_anon(folio) && folio_test_swapbacked(folio) &&
>>               !folio_likely_mapped_shared(folio)) {
>>               pra->referenced = -1;
>>               page_vma_mapped_walk_done(&pvmw);
>>               return false;
>>           }
>>
> Yes, + David, Willy (when you send a new version, please CC people who have
> participated and describe how you have addressed comments from those
> people.)
>
> I also think we actually can remove "folio_test_anon(folio)".
>
> So It could be,
>
> @@ -883,6 +871,21 @@ static bool folio_referenced_one(struct folio *folio,
>                          continue;
>                  }
>
> +               /*
> +                * Skip the non-shared swapbacked folio mapped solely by
> +                * the exiting or OOM-reaped process. This avoids redundant
> +                * swap-out followed by an immediate unmap.
> +                */
> +               if ((!atomic_read(&vma->vm_mm->mm_users) ||
> +                    check_stable_address_space(vma->vm_mm)) &&
> +                    folio_test_swapbacked(folio) &&
> +                    !folio_likely_mapped_shared(folio)) {
> +                       pra->referenced = -1;
> +                       page_vma_mapped_walk_done(&pvmw);
> +                       return false;
> +               }
> +
>                  if (pvmw.pte) {
>                          if (lru_gen_enabled() &&
>                              pte_young(ptep_get(pvmw.pte))) {
Ok,  update in patch v6:
https://lore.kernel.org/linux-mm/20240709042122.631-1-justinjiang@vivo.com/

Thanks
>
>> Thanks
>> Zhiguo
>>>
>>>      >>
>>>      >>
>>>      >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>      >>> index 0761f91b407f..bae7a8bf6b3d
>>>      >>> --- a/mm/vmscan.c
>>>      >>> +++ b/mm/vmscan.c
>>>      >>> @@ -863,7 +863,12 @@ static enum folio_references
>>>      >>> folio_check_references(struct folio *folio,
>>>      >>>          if (vm_flags & VM_LOCKED)
>>>      >>>                  return FOLIOREF_ACTIVATE;
>>>      >>>
>>>      >>> -       /* rmap lock contention: rotate */
>>>      >>> +       /*
>>>      >>> +        * There are two cases to consider.
>>>      >>> +        * 1) Rmap lock contention: rotate.
>>>      >>> +        * 2) Skip the non-shared anonymous folio mapped solely by
>>>      >>> +        *    the single exiting process.
>>>      >>> +        */
>>>      >>>          if (referenced_ptes == -1)
>>>      >>>                  return FOLIOREF_KEEP;
>>>      >>>
>>>      >>> --
>>>      >>> 2.39.0
>>>      >>>
>>>      >> Thanks
>>>      >> Barry
>>>      >
>>>
> Thanks
> Barry


