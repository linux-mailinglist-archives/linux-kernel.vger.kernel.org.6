Return-Path: <linux-kernel+bounces-546981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A08DA5016E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF65B16D797
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB924BBF5;
	Wed,  5 Mar 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AAmq0Dq+"
Received: from outbound.mail.protection.outlook.com (mail-canadacentralazon11022080.outbound.protection.outlook.com [40.107.193.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C538924A076
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183624; cv=fail; b=cA1MOHeVmxvZV+1lUYUsTcpQ4H9pInEgVYYryFszlDRLPyyUW3klDLDLvYtUxBY6XvN2ymhP6BAzUoRRlOIUINeEFI+5LOrb0SUh4dSsO5rQshiGVkFcWQkyx+Myc1IhWVHQJcdxUYV1qDqZHaa9EErXUvjGJS2Po3ivX3/VoM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183624; c=relaxed/simple;
	bh=KTOnGZkVc9p7Yuyyl0rwhJIlVrMch/pbQWcfc10pwzM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bGfeE+VmfjTBdfmquvMbS7cyooqeNxFyfxGYyccduZwAr5T3dBpzb/fA2fyg3+noUgN7L8Q2Yr/ILJwUpemmE16Dh33psw/Y9JpfLPdFBm8mwK/y8gVvULqVK6hydTWdHtr5Ez+jjaExWCETEm1k1LbF2ZodJc4g414gllB3sWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=AAmq0Dq+; arc=fail smtp.client-ip=40.107.193.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBqwnZHMIgbjpc27vOlCJi0AdDzC7NmtjyLAZT48ya7ZSsp6decwREOW0922K/wfrJaYxkrByzjbZcMuhxxHMNQGxSCBAOjh04Sj5UaMp3zXuiZwpvqMCLafCZDVsicr0QcGX+DE6IsvGEJv7RA2eigvvbbmMkFxllShIWyrCrzxHysj6X/zmHSRhzMXSLwrqyNMz8lwujLHyjX4ZexzQa1NAeAw2tFV8j3qXmPQLt+RHG0FnbV614HSlc+CR2xn9ze0riIXcxdNyDeo3zlOGdbgrC/65d7KpAGPmEqHect84FKfsLNcYJOS60mtTLuEmeFbk4X9mDzGxVU6moF/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+oi9cbjovUWuVVe+gxqc3etcQu/R13F6nSnpKqJYGM=;
 b=w2190VXoYB9ipsguej3ZTPavA6OQ1ZpZHwMVHgcujaW6CfWSTQLVIIar9p+oYLtJ7cAYiEEntaOjnsjTcYjqzIE72iA2sp/sdxnWpswmPCV6thGZXymKgloaNzr0qri3bTH0zbWEtimLM+7RweQS3NesesYG1lNzShQw9y3KWhCXlUhwDgHDvfuiGtOhb+1UO8V8AQANus1wIaQZejyGOsqcH2MpUdDU9/qTkAKdwzzBwLgfUTIiPt807f4jJ+gpup3gRcE1e1j5NF5KqD8iO8xXmb9vLJJRrhNLjqMjPHtu3XxmBuDyZjY4D+UhLtN7rmwXCHxKUdFCsSqKcDa70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+oi9cbjovUWuVVe+gxqc3etcQu/R13F6nSnpKqJYGM=;
 b=AAmq0Dq+qK/+kWEWZAjBpiJNIXI3JcFOS7dF+GSOiRslbFYaizkfjm+QkaZ3tMIbtiKflXhAGe7ir6tQwsF/nvtzritcxH43bZx9AvIo7RcIdHSCyzatOx01eTceLGW/UyiA3k2k67UnoWFHJakZO2+i1qsNANiEyADXshwacp/vu7ZikjsdTLQZtKN9MdwidgZo589/SAEMeMCjHx80ByYJnIHPLpFa/swx+dQkZ+dr1FZuD+Hasfzs5P5PGlFOlUvIZbjVn+lYBpX5DFOi/CW0FqEl3MzVkVfeYbex2wTY35jHKMLnu6UBgdWMUKIL3ysfo3AA2hT4IdDpSky1rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6107.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:28::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Wed, 5 Mar
 2025 14:06:58 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 14:06:57 +0000
Message-ID: <08506527-5d0b-44c7-9d09-a4d53b2fda2d@efficios.com>
Date: Wed, 5 Mar 2025 09:06:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <cc1dec8c-8323-4c67-913f-5d8fb55ce715@efficios.com>
 <Z8HlL4FopVjeveaJ@x1.local>
 <60f148db-7586-4154-a909-d433bad39794@efficios.com>
 <Z8I5iU6y_nVmCZk6@x1.local>
 <72810548-b917-49b7-b7ef-043c6b395d31@efficios.com>
 <8cae1e56-239f-4f67-a18c-b4f4d09f40d0@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <8cae1e56-239f-4f67-a18c-b4f4d09f40d0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0202.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::24) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd424e8-5f3a-4e7f-313a-08dd5beefdf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2lIZ2EwdXdSaXRtVXhKWHpLc2lNLzlqTEQ0SzkzM2tKUFdYcldTUno3S2RN?=
 =?utf-8?B?VGpMVTVYNkZFbTRBSFUyNDMyTEtHbG9Xc09GWWlIcEZ1LytaWndnNTJMRmQr?=
 =?utf-8?B?ajdCUlZobWRvaTUzWHIweVR6cGx4RFUvVU9ML3JjQTdacnJocFhxYjZTNUlT?=
 =?utf-8?B?K1ZoSnVTb2puVzZYeEpkeFFqL1djNXcvQmlYWkdUUWdTL2xqaUxYVFpBR3Ny?=
 =?utf-8?B?eUNzc2NwRG5oaEowR09ESWRkSFJQejNJYWNwNFgzRGF6bUxmTGpYak9sa0pQ?=
 =?utf-8?B?RUZuV3Q3TEJwSHpjaXUzVHRxNWtVL25KdEJFdlczcDFSS1Y5bjdtOWFwaDhR?=
 =?utf-8?B?a1VrUnA3TUw4WEVzNEdYRTdyWmpLZnphRlRONUM5MTl5cUptc1JDM1ozRG53?=
 =?utf-8?B?U0FzdTZoQmRGcDE5eDNqMnJKUmNhdVpPZVVQeSs3NWxvOWJVdFNlRlBQTE03?=
 =?utf-8?B?U3NoTWNKQjhGKzU0WFpoYXljZ0U5eENkT0xDMmJTdi9DWFhpdWFIbm01Nk95?=
 =?utf-8?B?ZW1NTnBlaEx6N1dXUC9UU1pZb3N6V3hyZDdEWFlZSm1HWVB5Z0h2aExlZW1R?=
 =?utf-8?B?aDVwYVQ1azArTE1URHVWc3FTcTI0VEJhbnE0cEFaTjljazVNaCs0ZjVNa3NF?=
 =?utf-8?B?M2x2VjR4NkR3WjRvbS82TGR0bXUwalV1ZFhFd1BMRWJFK0NaMTJlSXhWbzJK?=
 =?utf-8?B?T3FpRitpRTJ4V2pWdlAxQWRBYkE4UmxaSzVyR3RYWlhWcG9pWHlDL2dmem9G?=
 =?utf-8?B?S1RxNDQ3SWR4KytSa0I0MHJjQzMydUk3ZmtPTlM3cm9kYTl1ZExUQ1pqRkEz?=
 =?utf-8?B?d0lJems3MFFQeC9VYSt4SW5qTmY0cThNT0s1QkxrZndZRG5BVzJFc1JoV3ZZ?=
 =?utf-8?B?ZFMwakxwQmtkSTc3aEpTZDFmVy8rYmFkYVZua2EzMnd3WW1MSnluNVBRQTkr?=
 =?utf-8?B?ak50T0RiYmhWcGIzbDZCUC9BVi9qMDRwY08rUDc1aVFUeGp5bkNrOGlQNTdG?=
 =?utf-8?B?WlNQR0M4ZGdIN1JMNXlOalcwV2tRY0FQOE5yLzZCVERucUtvZk9YOStRYkJp?=
 =?utf-8?B?TXF0R2g0TFFrWWQySFJIcXNlcnlWc0hOL3d5cGJwVktZbDJTUW1DV2t5TFF3?=
 =?utf-8?B?Y3pLMDNxZFhGRlMwK1hZanFaemsrcGlGRzB0WjZLT2tqWTg2Q3Y3OEJkcnlH?=
 =?utf-8?B?cU16MCtEMzJmTGxlcVZ6U3NabURIRG9TT3hrQ1Z6c1pqRExmODJDZ08yMjd4?=
 =?utf-8?B?TXB3RlMrVGNlcVI1NnFSendJVXpxdlRiWW5QY1BPK2xGMnlsN09CcUw3TFh0?=
 =?utf-8?B?cWlvSjFDckdzOTd1WmZFMFllOWVuRm9DUm9DSnA3dkR1UnZ0azRqa0dzbFFo?=
 =?utf-8?B?R1haSWwwNnI4U043M0d4dEdaV3BQK3ZBWUxiTlFCa2VvcmpXNnNhanNZaUVa?=
 =?utf-8?B?QytuSGdoeDM3OGdNUWU5M2lwUVJla1FVb1FrVlErRUozTEV4ZEYxcmdNbDQw?=
 =?utf-8?B?Zlh2ZnRQUkg4Q2wwY2k2aU9uZnIrbGV3MUVMeHhGeHMyckJjc2ZvS0dJV3Z1?=
 =?utf-8?B?UUI3WHBBMkM4anNhUUlkOEZlSlZ6Y3VVUzNZcW1zQUxrK2pCL2JsNGJTamc3?=
 =?utf-8?B?WXlNbDhZdGlMSzNIRmtkdXJCRUkwMDR6cWhreDE1dmhLSmZkSnErYWdMdmJ0?=
 =?utf-8?B?ZndLZEkyWGxRdzVJRHRCSzJuYkptSWIyNHFTNzYyRGxNSmducCs3OUxJZjNo?=
 =?utf-8?Q?uAXQwN7UaeZBNjP66D50FukXsesIRdoWDizapF4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDhpY0IxWkpKQ29BdWludVE0Lzl3N2ZlUElVNENYZEIvdlMwMlBmdkhHSjB0?=
 =?utf-8?B?dlp6WVV5ZnBydFI5aHljVWdrNEZxdlA0OXVZdUJxQTZtdWdoQTVueWk5cUVI?=
 =?utf-8?B?TFBnREpKdk9CSG5BbTN0T1JRY3EvSm5oNm16c1dCdkJLbmxHaWpvNC9LY29o?=
 =?utf-8?B?Ny9YY1Z2a3dzR0UyWkpuLzZENmwvVENwQ29yS1lWNGdYeFEzQ0Vwcmg0bUpW?=
 =?utf-8?B?N1RhR2djZ1RRMzFGV1J3ZFgyNTVyVEJLU3ZOdER2YmQ1aFQ3UURXeWdKRXVP?=
 =?utf-8?B?RkhnMXRLd1FhS0puNUlqbWFqdUl4K3E0OUhmOHNXWERZQWthbUF4aVkxcmk1?=
 =?utf-8?B?dFpiZUVYU3ZHSjRSZEY1dERUVVRVK292RDdhdjhRTUthaG8xL09CV25WRmR3?=
 =?utf-8?B?ZjFQT3ByS0x2VnBJNk90S2U2MmFickZmTktIbW45elBaajh4aTVkbUtaWTFP?=
 =?utf-8?B?UmZiQ2pjYmQ1OVgraXBvS0hsc1FXSFB1TGVZU2t1QnBjTVBPZzBTbVBBbnFx?=
 =?utf-8?B?dmZwb0IwT3FmQnNUYXg3SHFIMXRhUzVBazNjK0pqV28vZW00YXJSc2Rxa2Nh?=
 =?utf-8?B?NGhJS0t1OGZTUFNNaFVacVVhMVZ2SE1ObVY1S3l3bm1KVURNdnJWUUwwRXBR?=
 =?utf-8?B?VGNwUGVVRzVhSE56S3EweGtYQlhabndibENDNnIrcmdXYSt5YjBnenJ3eTZT?=
 =?utf-8?B?Wm5MSDZBSWJLVm5VczBBRlEzcHdadUNwMklvcHJzc0ZobDhGRVowbThGNmZz?=
 =?utf-8?B?ZnZhTU4vbFBLajdoeUZsVnlySkMxL1lWZExwVHplT1hGWVpKRm1STk5NMzNV?=
 =?utf-8?B?TDR3RTB3S1o5bWxhZ1Q0RmJZdDMvK1JVdDZQKy81NFVCeW1XK3UrdGxFVVZU?=
 =?utf-8?B?cWg5OVV5NVY0ODhOeDlYYitkMXJ6dExsS3p2VVJ5NytvbVZFMVI5Y0lBSmdu?=
 =?utf-8?B?cVlKdXJkOTdZYVBLczU1VkhHSytBZmZ2Sk9FS3RDd01LNmJuQUo2R2cvUDQr?=
 =?utf-8?B?NGRISFJUOXpBSG5mNUFyekRydml2cHZLS0RwUFdOdk53N0cvNUxXWlBaQ296?=
 =?utf-8?B?ZnpDUmJJcElpb014eFVUdHJEWkhqVWRTeE16MDNIUEY3U09qQlV2Nkd1MnlX?=
 =?utf-8?B?dm1HWS9IRlhpSVExWEJwMzBoQW1XRjBmcnZQVlBkSHVheHBYVnNzNlFZeVgy?=
 =?utf-8?B?MkVJZzJ0d01KckNremZ6MUtBMkpxZXd2NlAzRmpDTnQ4SUNLYy9FblQ4c2Zv?=
 =?utf-8?B?ZDhjUUprUHdkeHJIQ210NXlHekd4V0tCQTR0NjlSRkx6bEdYZHJISUhkK0RK?=
 =?utf-8?B?M09May82L2lSb2N4VUhDWXdGeFFFOU9WYnJYT2dkSDBNRDFJUGVrZUNON0tq?=
 =?utf-8?B?akN4cVpuWXBrNEtOeTFjbTB5a0tRNDhyb2tpVlZSNWxCWmloN1R4NjU2T0ds?=
 =?utf-8?B?dUtGOFBMS0E5MlZtQVNlaGxBZHV4VWtmRU91YU5MMjUyRENZSnZ2OEJ3MG1V?=
 =?utf-8?B?MFlYbVppeWtTNVR6VVlITXNRS0FGOFNPVUc1ek80Ty9LcVFMMXkxbTVYZFR3?=
 =?utf-8?B?U0Qvb1oyRkM5Z1pnS0ZPdTgvOFNMaTdVRUx6bHlCUmRHTTlYZVlvd2dOeEs2?=
 =?utf-8?B?RTBoekVRblZOSi9sdTBlNFVWcGFnTnNyNTh0VE1pU3ZmcnR3N2MwWjVjdVRn?=
 =?utf-8?B?NlppZDU3RGw1NmxQK2VkRGJhQ0tYa0pWQzgzTnZBSFVqQm40QXl3TmcwR3pU?=
 =?utf-8?B?L01ZWERDQUoxRnBMb0FJU1lZWUZoMkVzYmlBNGltVCt4dk5lMWt1bUJVb3p1?=
 =?utf-8?B?OWtjbG80STA5SUo2bmYwMFJDU2l5VGhwbkVEeW1GUk83RkdJTFV1REtrYTFJ?=
 =?utf-8?B?aEdPdlFrdk1oVStqdk5JNVVVN0ZNQXlwWlRRaE8zVnp1RnpZSnN2d3RibGtV?=
 =?utf-8?B?U09EZTczLzdpR0d2MmJMNGE5b25zTVdaOUtuTC9aSjZJZDNLMTVYeGVHa0NX?=
 =?utf-8?B?b3NWc3h4WktHV2IrY040akJzRTFnUm5yTktIbXdIa05RUitVcDNodGxpbTZZ?=
 =?utf-8?B?U0E1TkkrWFRSWmxKaWVNQTRIazZRQmd3SUR6T2V3YWliN1dyQWQ4Sk56QzVh?=
 =?utf-8?B?UkRYY2lBUThDQVNJVDdOUVVoZTJaenFqZnYvckEzWkhLdE9kN0UrRUdKMW1q?=
 =?utf-8?Q?nIWZ5+S0UHz1CeL81KjDit4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd424e8-5f3a-4e7f-313a-08dd5beefdf3
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:06:57.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vk+5rFFRjn5TcIGtnx2h4xVHR5H9/5HJu6CUh/dSwKCJ1T82IHbsK9tMVArQmFLFJ1IiIFK8ajqSztL9PlJlV5n9K6+G+p2qcKwWPz+42Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6107

On 2025-03-03 15:49, David Hildenbrand wrote:
> On 03.03.25 21:01, Mathieu Desnoyers wrote:
>> On 2025-02-28 17:32, Peter Xu wrote:
>>> On Fri, Feb 28, 2025 at 12:53:02PM -0500, Mathieu Desnoyers wrote:
>>>> On 2025-02-28 11:32, Peter Xu wrote:
>>>>> On Fri, Feb 28, 2025 at 09:59:00AM -0500, Mathieu Desnoyers wrote:
>>>>>> For the VM use-case, I wonder if we could just add a userfaultfd
>>>>>> "COW" event that would notify userspace when a COW happens ?
>>>>>
>>>>> I don't know what's the best for KSM and how well this will work, 
>>>>> but we
>>>>> have such event for years..  See UFFDIO_REGISTER_MODE_WP:
>>>>>
>>>>> https://man7.org/linux/man-pages/man2/userfaultfd.2.html
>>>>
>>>> userfaultfd UFFDIO_REGISTER only seems to work if I pass an address
>>>> resulting from a mmap mapping, but returns EINVAL if I pass a
>>>> page-aligned address which sits within a private file mapping
>>>> (e.g. executable data).
>>>
>>> Yes, so far sync traps only supports RAM-based file systems, or 
>>> anonymous.
>>> Generic private file mappings (that stores executables and libraries) 
>>> are
>>> not yet supported.
>>>
>>>>
>>>> Also, I notice that do_wp_page() only calls handle_userfault
>>>> VM_UFFD_WP when vm_fault flags does not have FAULT_FLAG_UNSHARE
>>>> set.
>>>
>>> AFAICT that's expected, unshare should only be set on reads, never 
>>> writes.
>>> So uffd-wp shouldn't trap any of those.
>>>
>>>>
>>>> AFAIU, as it stands now userfaultfd would not help tracking COW faults
>>>> caused by stores to private file mappings. Am I missing something ?
>>>
>>> I think you're right.  So we have UFFD_FEATURE_WP_ASYNC that should 
>>> work on
>>> most mappings.  That one is async, though, so more like soft-dirty.  It
>>> might be doable to try making it sync too without a lot of changes 
>>> based on
>>> how async tracking works.
>>
>> I'm looking more closely at admin-guide/mm/pagemap.rst and it appears to
>> be a good fit. Here is what I have in mind to replace the ksmd scanning
>> thread for the VM use-case by a purely user-space driven scanning:
>>
>> Within qemu or similar user-space process:
>>
>> 1) Track guest memory with the userfaultfd UFFD_FEATURE_WP_ASYNC 
>> feature and
>>      UFFDIO_REGISTER_MODE_WP mode.
>>
>> 2) Protect user-space memory with the PAGEMAP_SCAN ioctl 
>> PM_SCAN_WP_MATCHING flag
>>      to detect memory which stays invariant for a long time.
>>
>> 3) Use the PAGEMAP_SCAN ioctl with PAGE_IS_WRITTEN to detect which 
>> pages are written to.
>>      Keep track of memory which is frequently modified, so it can be 
>> left alone and
>>      not write-protected nor merged anymore.
>>
>> 4) Whenever pages stay invariant for a given lapse of time, merge them 
>> with the new
>>      madvise(2) KSM_MERGE behavior.
>>
>> Let me know if that makes sense.
> 
> Note that one of the strengths of ksm in the kernel right now is that we 
> write-protect + try-deduplicate only when we are fairly sure that we can 
> deduplicate (unstable tree), and that the interaction with THPs / large 
> folios is fairly well thought-through.
> 
> Also note that, just because data hasn't been written in some time 
> interval, doesn't mean that it should be deduplicated and result in CoW 
> on next write access.

Right. This tracking of address range access pattern would have to be
implemented in user-space.

> One probably would have to mimic what the KSM implementation in the 
> kernel does, and built something like the unstable tree, to find 
> candidates where we can actually deduplciate. Then, have a way to not- 
> deduplicate if the content changed.

With madvise MADV_MERGE, there is no need to "unmerge". The merge
write-protects the page and merges its content at the time of the
MADV_MERGE with exact duplicates, and keeps that write protected page in
a global hash table indexed by checksum.

However, unlike KSM, it won't track that range on an ongoing basis.

"Unmerging" the page is done naturally by writing to the merged address
range. Because it is write-protected, this will trigger COW, and will 
therefore provide a new anonymous page to the process, thus "unmerging"
that page.

It's really just up to userspace to track COW faults and figure out
that it really should not try to merge that range anymore, based on the
the access pattern monitored through write-protection faults.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

