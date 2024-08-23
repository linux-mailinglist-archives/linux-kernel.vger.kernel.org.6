Return-Path: <linux-kernel+bounces-298649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3B895C9CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64B8B21D24
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEAA152196;
	Fri, 23 Aug 2024 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="uegu6IYh"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022101.outbound.protection.outlook.com [40.93.195.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D887346D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407051; cv=fail; b=o2eHINXcj3Qnu7NNQiLLEGh1qD3pIXbjY/EkRRZegimKAlKGJTX3Az56sr9UMYkxHZnUaZR9WQKBz8Ue5jXIHo4m2bJU9Pe7RoD0HsHCRhVu1K09J+AAizm5d+z/XR/Fv7P+THGqjrlFAJF+ab6BqvT9aHXS13vW3eCWKX8sBXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407051; c=relaxed/simple;
	bh=gVb5ZZHdcHF8Rn4KPHuCl6yc42H19rYahTO4SQTPRFU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sAedhA9UVFAtdjDSDJq7fJg33Xv2NK6Vkb8vEo9eXjKM8ecbcRH8nagv76PZHXnTOJxlov7CjfoiZwdJfJpQg0IedZAf8sWaO+eOIETcsJyKH4MYo6jF5IvYXNbBY3cwU+FVAehottaCtjH8rxorp/fc3vhY6dW4R/1g4ixidHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=uegu6IYh; arc=fail smtp.client-ip=40.93.195.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgKsz9sBhFGa1xKQmGUV9eCUDEbScaiwoDGsSn80v6AqoqBe183xni0kqyRcfZZ+RfvyRePeIYpVPAfutzh6JEtymuzKsAs9VjlFvUNZmmgG0uLCUmAXmoSvhvn1+/kRXEOL6uUXrAyY+T74JOk+fJ4mqMjVkCvPOie4VWMFR7+wMD1IbrwUE7acZlr8DyJ6nEPKcn4F7hG7QQ7p1+tiNr/yv8MuL11biNWkE9XTwtB9n9j73hy5mJcZEk/iKNsnI9k6cYsafPHJG/ezvtQo+fMprzG/mdJFyLKiNNqI9UWXTCo5CtCYjFzouezYaASr89QQ4OsBcNYsFTn3s9j6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F42buNuTgXhuQNVmgJsJFTRKQJztAOtYn36hz2vZHlU=;
 b=FA6uadfgB5Noj74OZdeqxIgKTQdZMt9Foqow/Vpf1pJvOuZBnQiUh77d7ytZlhL+pTBissDIECkFjeAH3kinnzcZuMutQ93Flxiv4X11aBGodgGvas5u7kgEXMpKO6LyA6969hhYkobtHHs0hm1plwYtvk5NvhMIsk28ie76NO+g9K/IOB18XKNKROn8wZ9qYmhCT8GcGZcJeeDeyaV15OC0Vie+pTIQi0YDqhvdkX1i2xUVW8c+j4STv9uMeRBA0+HOOt6mJFzEf+A0x9/vQsLktaXSP4eaAX5y48yPs8av/tsmW1KEfSuqG0Wu6Nbuv/G/YOxwjO94gidddRSp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F42buNuTgXhuQNVmgJsJFTRKQJztAOtYn36hz2vZHlU=;
 b=uegu6IYh/v27uNGAhFknwfn42Rdb3AJuvxjQdOjx09aYIiVzVbQlfz5CB8XCTAuLXITfNTM38s3DkizVtsB279Vxrhy9f9kbGbtcDlvTfaYV8fLMSUJi6hnu9S8QElK2LA46FVvxoiT6612N2YE+kf3n0Akeem8GQuQYk55SNPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CH0PR01MB6972.prod.exchangelabs.com (2603:10b6:610:109::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.18; Fri, 23 Aug 2024 09:57:24 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.7875.018; Fri, 23 Aug 2024
 09:57:23 +0000
Message-ID: <51661f76-c02a-49fb-8d68-53a8549acd19@os.amperecomputing.com>
Date: Fri, 23 Aug 2024 15:27:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, scclevenger@os.amperecomputing.com,
 acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Al.Grant@arm.com
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org>
 <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org>
 <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
 <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
 <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org>
 <3d7a6f93-0555-48fa-99cb-bf26b53c2da5@os.amperecomputing.com>
 <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org>
 <4dd7f210-c03e-4203-b8e9-1c26a7f8fe79@arm.com>
 <c73573e7-206e-4a6c-b6c6-27903978d0aa@linaro.org>
 <CAJ9a7VhJFNxPCVva5tS51SBaxx76nFq9in0MGJe2jEwbVdSTkA@mail.gmail.com>
 <27912fc6-8419-4828-82a7-dacde5b4a759@linaro.org>
 <CAJ9a7Vg3W0NseXes3_irgkyeDKjhWqw5YMRghguHJZS73p9SJQ@mail.gmail.com>
 <36f947ef-c2a7-486a-b905-f0529308b06e@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <36f947ef-c2a7-486a-b905-f0529308b06e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|CH0PR01MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2dc25e-e964-443a-7589-08dcc359fc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHpTVzV1MFZ1aEEyM3MyYm9JWWcycTlHUGhyd3ZLWjA3c2pwclRIM2dBK09p?=
 =?utf-8?B?dUl3cGZ4YndtdEpSbEtodmFNRlMxSFNSd3N0cEMwa003SVhNbHNMQlR0cU5G?=
 =?utf-8?B?YW92TVNzNmZDbDhRZkpVOHYxR3VYeGc0ektXWkRzUmFYaXFLSlNVblFSRjNk?=
 =?utf-8?B?MzBtb0hvU0JrUmFaaThNb1hvcDI1TkJTcW9aVXE5akl2bkhYUUpiN1E2TVFt?=
 =?utf-8?B?YkRxbjRGUXRDaWFrQ1RzejE5T1dyZjF2ZmpuMURRWU0vVU5RVkNiTkFtVjlj?=
 =?utf-8?B?SFNmMHJQSWF0WTRVbkZGOG1Ec09JejNZdDB5Q3ViT2pxU0xsNHE2TTBZbUVF?=
 =?utf-8?B?RmVqazc2NzZNZlQ2RlU4RVpPVGZ0TjFtcnExOGFOM0hkS1ZENkE0OFVhQjZN?=
 =?utf-8?B?Z2xyYjgyY0lOUWhXTFVDNlJ1MWVyY2FGYkwxejl6bDRBZmZ5eXZYazJUby8z?=
 =?utf-8?B?ZVVMaTJIc1FWM3VQSmlFejY0RFNmS2xFZ0E2TjlGZGdxb2NvOUc2aWFTUU1k?=
 =?utf-8?B?QUhmbmVKcG5LU0xFSUhzcElQSlR4OUd3NjVsWFNsUzU4aUsrTkVlNkZmUlU2?=
 =?utf-8?B?c3JQbDVXRXV3Y1BUV1N0QkdwQjJsMzR4UTB2VXArRU44SjMwbzMrYXRMR0V5?=
 =?utf-8?B?UEZDcFpTczhKNDZaUkhnR3NITlVPQkJaNHNjeG1scDdrVUlKU2swaEI1Zm5y?=
 =?utf-8?B?MDg4ckRRQ215bXNJdmV6WG14cUkzcWZ2ckZPSEFvZnFacDRlQ0duanVCclNh?=
 =?utf-8?B?d3VTS1h6dFl1Y1l3OWgxWXlVV0dSWGU2VTVMVkcxNlQ1clpGR3VZRm9ldjRr?=
 =?utf-8?B?R1FLVml3alY1UU9tNXRtd2l4YTdjT0xTMkl1eXRMTVV6WG8wa3Q1WkFMSmZz?=
 =?utf-8?B?UnZxYlljeXdGUVlubmsvYjBBTWw4dUZwZWlJTmttSVhUUjQ3aUp6bDFNZVJp?=
 =?utf-8?B?NlFBNEpqMjRZVEFGdzE5bGhpMVNSRzI3a3QxS0Y4ekh6a3lWK2FpeWdrRFZK?=
 =?utf-8?B?dFVaSmhCRnFrRDRTbm9HMUp3R3kvWllrRnM1a0tUMmJWdnp3TVBrQU1OV3M3?=
 =?utf-8?B?alEzRkxYYmxnTktCbWtoblkrMk5xUzJzTnc3c0FVZWFCSGNjQ2xOUWVGT0JQ?=
 =?utf-8?B?WUhPVlIxSXZTdUg1cUZWYmdyOVBRRW9jZ3oyeWczSXloMjVDcW9PQ1oxOHJU?=
 =?utf-8?B?ekpML25uSzhveDhqNWw4VWhadEtUUmdhSHdZWUtWNWtDZGx6b3JNOGJRcVhV?=
 =?utf-8?B?dGZMa2JRSXdBTS80T3BmSURKdEVrMlV3aWY4eEc3U3FtbnlycjJjUWxiK2JK?=
 =?utf-8?B?czd0NG5WTXhTSC9tbit0SW9KYVBpNWRMWUpHZjNuMGFJTjcramhoby9uMmdN?=
 =?utf-8?B?cWFyb3E3T0JQbElCY0RJNkpIQnVVVUVwL3JyQVlSd1NpT0N0azlxUHljOThw?=
 =?utf-8?B?OEptUFVwdmhZOWp2eUgrNU51RHAwb2puTlpxa1RvM2YzNXJUWUozUUNPV0Qx?=
 =?utf-8?B?S29KcVZHUWhXYVo0TDJZZER4NXo2RkI5dDlFZ2M1VEkvaU4vUWQ1QngraTc4?=
 =?utf-8?B?aFplblllV3BjMXpKTnFlcW1NVmNkUHBYancrckEyRHpXSURKYnExSDBKS0lC?=
 =?utf-8?B?ZGt6RjMrWEVndWNCZXIvcVJFMVNQYmZ1VVVaVi9qdzVCUWJtcFBFdGhxSzAw?=
 =?utf-8?B?blJLeDUrRCs1VUQ5Z1NPOCtvNHF4MTBibXkzVkZoY3BwTlFXTVNuRGN5RTVO?=
 =?utf-8?B?aFpCS2R5bEV3OGRrczhTR04vRGt0T1JiOG4zQlMzZGM1bHVMQ0U0dU5KK3Js?=
 =?utf-8?B?R3YrL0llc1V0NEs0Q0NSUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amlxZCt2VjdKMVhsS0hHTUpnTDZnL3ErQldlRWZ3blBuQkFvbWtBaUo4OW9Y?=
 =?utf-8?B?VWE1em5YcVJLK1Q5NTRpMDlXb1owRml4SE5QbExyUzNWVWFjVHRvWmZZUHNV?=
 =?utf-8?B?eGFjMnVvckZTWFJoYXRvcngzUDVwSkt1R0Iwc2RBcENXNWU5R1dLSUc0dmN4?=
 =?utf-8?B?N0ZXMEk2alJaSzFLV1lyemk5YytsWjRvSUJGVUNqY0V1VUxRZktCZ3hsRXQ3?=
 =?utf-8?B?aXVTeU9KcTQ4aTVURk9HK3NkZWZWN1VrMkF3cDZPTFpxNFFZSGNxMmxZWC9a?=
 =?utf-8?B?QmRpaTZPSnFabU41ODRoZ0RQNTZOd3kxVllCK0V0NmJFTmJ1Z3NyZWEzdk9X?=
 =?utf-8?B?OGxsT25BcTlmWGR3VHBmcEh1WHo3U1dweC8rSjExczJwK0NGTGRKeGpvdEJG?=
 =?utf-8?B?aHhwbjBSSUwzWnJ3S0ZXMlA4ejZNU2lOK3FqcmJPYzhFRGlpSUg2RlhleG5W?=
 =?utf-8?B?djB4NFNCSUJ1TGVFa2pKeGIzV21kWTNpa0dvRThUeHJONFlsS2Vrd2FlQjJI?=
 =?utf-8?B?RVBnOE9EVEF0dHNYRmtjV0I2dmxucnRDQmdidHhUbDdSMTVRT0xzcUJUdG5v?=
 =?utf-8?B?eUREd0hWeVdKYUo5ekR5WHFjSjlIZWVsQ2Y0TGtoTGJaamp6WktYclR0ZWZE?=
 =?utf-8?B?K0VqTkhtdEZvVFVzVXB2dGR0dGpUN2ExMFNiWnFHWXExRWU5YWppRk92cFlz?=
 =?utf-8?B?Y0d3VXg1S2Z0RFZVUlBiMHozV2hSakkrM2p5dE1KM2dBMVNrckg0ak9ra3RJ?=
 =?utf-8?B?UnhIY056TlBwbEZGN3dYZXI1Rmppd0NVMnpoSExkeU5icGdKMzkxYTFOUXBT?=
 =?utf-8?B?VlNyR2VnMzA2STM1Vk5BdGUybDNLWG9sMzFTYmE3ajlaKzhlQzBHbEpjVlRP?=
 =?utf-8?B?QVR4MENQUXVJRjFic3ZlUkhWeEJtWWVnTjVUVzkxYnZUbERWY0M0RG1QTE5q?=
 =?utf-8?B?RGhkOTN1a1RPWUc2eXExSjluZ2dyVzE4eDNJUWFReWdiOW40ZWM5LzJhcTNn?=
 =?utf-8?B?eENNUFRQNEx0UTlpNVNLend2Q0gwV3VzN1V5b01weXJna0VJaWI1eGw0Umxw?=
 =?utf-8?B?RmlvbmdQZUtIZWxiSnQ5QklKWWszYVY5QmpEN3RPd05PRWpYVS9jRmVsMStV?=
 =?utf-8?B?dGhYOW9pSTY0RUgvQ2x2NmU1WTJoa241c0tMWllLSzUxMjZ3aG96U1NxQjRH?=
 =?utf-8?B?blF1S2xzRmo5dnJTM3VCSzU1Zk8vdW5kMkVNTGRSSnB6OUZrRmg3U1dJSTgw?=
 =?utf-8?B?VlZweUhNR0hwcnNwZVo5Q2xRQXNldEVTSU1DcFk3VEl6SDdXbUJGckxCYlBm?=
 =?utf-8?B?WjFsZ0EvQnBKUGdsRm85SmtwVWhiTmRCS1hRTURPOHZheEtOTm5XWWNKVjhP?=
 =?utf-8?B?UURMQTNNMUZqdWRHWlB2cnNwTlRTNGtHODUrbkhVNjI0aUN6NTdKWFRqMTFj?=
 =?utf-8?B?UVVSa1JVQnB2NTUxUDI1b1lDWjFzTThKOHUyTHBWN3Q1SHNlRjFVRjZhUVB3?=
 =?utf-8?B?MGMzcVowMWpoOE8wZklHVlhiWEo4RUNzYzNYRk0rL1BGaDRWeTM4Y01sckNh?=
 =?utf-8?B?Y25nZ2ZlQW9GMUJERUp6NlVBOTJzRDRhT2VYc0pjbWhydHY1Y3E0TStCL0ZL?=
 =?utf-8?B?MTRQTkdpY3daQXNRYzIveXJQMGd4Qko0Zlk5bktjY1JwalFVcFl0a0tiRTht?=
 =?utf-8?B?NG9KU2VodWFIOCtQNE5SM0krWFpsY0dVeFRJSWlQWmpvNkdDYlNMdUo3YnhQ?=
 =?utf-8?B?RzFvTW9lbDlYa09QMDdIM05rSEFZRGhHa3FzTjh0eXBmSjdEYjF5VlpRRDl3?=
 =?utf-8?B?Z0Q2L2pWbE5lWlZXK3BOU0hzdDF1dUxLaEppT0srSEcvMG5GZks4MlNrTngx?=
 =?utf-8?B?aEVNMmJwY2JncXZOUURFYjM2NU5sQUVjcW1PTVBaVVRId3lmTFlGU2RmU2xm?=
 =?utf-8?B?b2d3ZWVNajRDTnVxaWdldjFXNEpWS0RRUUhuUHBRRnVEdDdXajFNbjU3Y1hu?=
 =?utf-8?B?OFkxdXErNFZ2aEowaWlnbXdPb2tFYUExNDVTVWZFeVZzWUl2WjJsaStCOGtI?=
 =?utf-8?B?V20yMkhrR2ErNk9ZU0loSERJNldRZW1zQkNVR00ya21ZVWpuU0h2Mm5WVW9s?=
 =?utf-8?B?ZjlSVTBwWElDS3o0U3NTUmNLQ3U1djF0NlFMWnNLV3NYdFpXcWdBMHY5ZGEw?=
 =?utf-8?Q?ibdR7jWkAsAmqp+cATzODZU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2dc25e-e964-443a-7589-08dcc359fc7e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 09:57:23.8037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TByh0grCwWZ47ac9jbCNQZUCR3xdalxx0avcu9nbUQ5toCTjvB0mEzPvbq956GRxsnLUjCWPUQ02uh73Cv5XTBSCvNJXsUSrlfCSbJXcfD5paP7yGXcE1e7zTkcFlw+7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6972


Hi James/Mike,

On 23-08-2024 02:33 pm, James Clark wrote:
> 
> 
> On 19/08/2024 11:59 am, Mike Leach wrote:
>> Hi,
>>
>> A new branch of OpenCSD is available - ocsd-consistency-checks-1.5.4-rc1
>>
>> Testing I managed to do confirms the N atom on unconditional branches
>> appear to work. I do not have a test case for the range
>> discontinuities.
>>
>> The checks are enabled using operation flags on decoder creation. See
>> the docs for details.
>>
>> Mike
>>
> 
> Hi Mike,
> 
> I tested the new OpenCSD and I don't see the error anymore in the
> disassembly script. I'm not sure if we need to go any further and add
> the backwards check, it looks like just a later symptom and the checks
> that you've added already prevent it.
> 
> If you release a new version I can send the perf patch. I was going to
> use these flags if that looks right to you? As far as I know that's the
> set that can be always on and won't fail on bad hardware?
> 
> I also assumed that ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK can be given even
> for etmv3 and it's just a nop?
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c 
> b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index e917985bbbe6..90967fd807e6 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -685,9 +685,14 @@ cs_etm_decoder__create_etm_decoder(struct 
> cs_etm_decoder_params *d_params,
>                  return 0;
> 
>          if (d_params->operation == CS_ETM_OPERATION_DECODE) {
> +               int decode_flags = OCSD_CREATE_FLG_FULL_DECODER;
> +#ifdef OCSD_OPFLG_N_UNCOND_DIR_BR_CHK
> +               decode_flags |= OCSD_OPFLG_N_UNCOND_DIR_BR_CHK | 
> OCSD_OPFLG_CHK_RANGE_CONTINUE |
> +                               ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK;
> +#endif
>                  if (ocsd_dt_create_decoder(decoder->dcd_tree,
>                                             decoder->decoder_name,
> -                                          OCSD_CREATE_FLG_FULL_DECODER,
> +                                          decode_flags,
>                                             trace_config, &csid))
>                          return -1;
> 

I tried Mike's branch with above James's patch and still the segfault is 
happening to us.

-- 
Thanks,
Ganapat/GK

