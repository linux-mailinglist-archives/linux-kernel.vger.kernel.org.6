Return-Path: <linux-kernel+bounces-337279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9849F984808
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34B6B21E58
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D591B85F0;
	Tue, 24 Sep 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1CxYvEvn"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB831A7AD6;
	Tue, 24 Sep 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189513; cv=fail; b=OwX/Qrubcckuir2plWDzkmFOYHwWeVsSd7EchWS7kJdiGtwHdu7S3myTJy9XReONoGR8BMhdwUhWNquC6uhv3yxL3WotvyWyBww65nHwmPWWr5h0f/VDhu6vv5uorpa1hMf4n7PF31YZBXxJFV1otd8kXg4fx1sPBThHEpvK4k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189513; c=relaxed/simple;
	bh=V63Gq/LR37+3+Kp2WeVdk6PdVm9PHNYp6mQKbhQs4iI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IAXPZ0In5jIXyKcXlioUyBc03IyyO3XvMiUexwtT4bEdpoGotl9nuWmHvEKlvXsgfop03EVtal+fGyztyolALP4iFE9FCgCkd5INQmACXfLerWhcP5Mqaqg6IgdN9QGOuUkyuOtS6KOHO/6spF38pqswy7ZAadvUihHrSI5o+CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1CxYvEvn; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTQnj2RGnQoglPUNG18iGSh+7th/stsW2mHTduB9B9iLCKD/twqH4pP2Gh5xIvQ1XPTqaUwZuuj93QGLTM0lt5GGXtcKmAJLi7LsF6FBv7ZltiXn1TBTJuUBkt3flobopM7IxzPDvi1Zpx1xRNTwyyYngndlY8yN57IkBZ1fiBjoPl5wjSpDAHzK4lGB8Iu/uY1pDJPlTitIERhA02V4y9HA4YLaitq0nhukxoPZlOHJQhkHFCy0LHphtJPQirV7eDN2D5KVHeVpJC7j7R+f3uWa0X1qwSy3aee41VZGqj8AXw45pr+TpbIwLv+AhNGGw9vn2ZHYa+BL3YEl7ntfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wooYgKP7vO+BfXo1/d71bwhMh0Wvm43IQ+wpCh1rXE=;
 b=N6pVCDmt9IZLbKdGtVjL4KuONurU76+Cd8+y+oMIY0x3XZkbv/q80F06LK8o9J6VI0tqBe862tyvxGQ5IijX0RIqSmfhRMgfYcgqI3A0GHQgDyyNLR8/9F9Hh6EX1FtpcOXwe0SsSV2LOUbuipCZ52Pr5hQ4ySNun2gWj5v3NZUyRx0iLTy9KWqzW0I8h/7YWNXyjhy5XkYjOr+T0wDjf780qyQ4mVifw15nHwy3Mtd0qIHx5lwt4WVF0ItjWPnhSvsP0lir5rC76FFKIdeqhj4IuZ2mDYitJYGRlKoUmJFYyXmG2FtUMFL0r5VNXi9eiXfD0LP/72kM9NyhMrTW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wooYgKP7vO+BfXo1/d71bwhMh0Wvm43IQ+wpCh1rXE=;
 b=1CxYvEvn01lwFgiJx9mUc+aXsp0rkegBryOaR1aVi1JqdBt5+FQA8rYs6oXl7fhpg510zpFHNyGRy/BN6NP/la4dkYRNoTJQUIM4akKQzT2oSXtpeIY1rQbRvj1UDvh8Y5JnVD5NlEaJSxilRXnHW50+2riy1y4yWZCGZ63zRkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 24 Sep
 2024 14:51:48 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 14:51:48 +0000
Message-ID: <a8055c81-331f-4204-9069-3a7d1b3594f0@amd.com>
Date: Tue, 24 Sep 2024 09:51:43 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 13/24] x86/resctrl: Add data structures and definitions
 for ABMC assignment
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1725488488.git.babu.moger@amd.com>
 <e0520492d3417df6f708c7ff7b9163b64843fc77.1725488488.git.babu.moger@amd.com>
 <02f1a542-f642-4efd-898a-a604e3a741f9@intel.com>
 <520817d3-6521-4320-b6a2-d0695a5d3699@amd.com>
 <5093395d-d8b7-482c-825a-5b87df7aecfa@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <5093395d-d8b7-482c-825a-5b87df7aecfa@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:806:d2::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d01a639-52f9-40e3-a9fb-08dcdca86aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzkrUHFmWEVZb0M0a1BmZmllNEx5YlNGcEZDVS93Z0hEUXg2VDZ2MjRGZUh5?=
 =?utf-8?B?amZYOXBEV0x0aXo3Qm9yb0ZaM0Y0MXErNzZHREE1UlZtamZHNEFQZ3pXK3lt?=
 =?utf-8?B?RjFBWjBCbjRpYWV4bk1TdW1CUGoyTG1LVGVSMlgxWnl2d0JCRzJvVWMxQ3B6?=
 =?utf-8?B?KzZBQWNxS1lEamxManVtcm44M092Njk5SThQTGdOL2ZtY3JHb05sTklmMG1Z?=
 =?utf-8?B?SjNMc3VSd0M4clp5UDJWTEJ6b2Q2OW5FdWNLRTNGWHZ2UnN2a0swTE1FK2hF?=
 =?utf-8?B?WENEMWoxVWVRN01BS09YWk02NS8wSlNZNlVPNlpLcEgrc21aVFpCTkRJS1ZK?=
 =?utf-8?B?dGEvUkN5QjhqenM3aHlIc3ZuTEhBOXEwUE5rUVVEaEpvR0NCUDlMRGF3OHVH?=
 =?utf-8?B?aXZMcERTWk1TMXJrTGsrNllTNEFDaXRkSTVTcWdISUZOQ3VVL3BTVFdRR3c4?=
 =?utf-8?B?dmh1Z3dmTU9JZThSeXZReStVVXBld0Nmc3hId0p5c3VJUXNaS2FKNzkyVC83?=
 =?utf-8?B?L24xNFkvZ2M1SGZ2SVlKZzEza0xVS3U4c2Q3dlhxNW1OYnBGbGppZVFEbG14?=
 =?utf-8?B?Ym9sbnVESnNjYkRBY3RMVGU2NTdGRkQ1ZkhJSW1YY3R1OENaT1p5SklvYUJv?=
 =?utf-8?B?bmZMU1UrQWZoRmhNRmc3SWxsS2JXeThhUFdlSW1EcU85SUpDQi96ODRGTTlQ?=
 =?utf-8?B?bG0zMnBwMlM5eWVvRDY0cDQ5ckdUUVNPTGFpN1F5TjdUTG03U1docVVheEpu?=
 =?utf-8?B?NGVnR0NMR2NkV0FrQ3JCSHVJTVJkTXpnZGZLdXprZVZoNE9XdU5MNjlBakRQ?=
 =?utf-8?B?WkdaVHZmMGUwWGdnZUh0MSsrSGFVZzkvb2dIa1JoZ2FCOUFxTldJb3pGQWYv?=
 =?utf-8?B?V2dFZEJBdGx2ODBTbXIyUGI5TFk1NXhDcEFkcXREYXdHZ0JKcnNvUkp2MitD?=
 =?utf-8?B?SDJ0K0tzQUYvK1NyakxSaFVVL21GblRDMkVScm0vYThsTVhGNG1MWC9iS3V1?=
 =?utf-8?B?ZzFTeVhTMHJ1YzZhQlY3ZlVnV2s2RG1ISnlvOWhMcDRsdG5CaXkwTUxBQWRI?=
 =?utf-8?B?TEhoQ2hMcFZQeWtCVmlPdktxOUMrbFlxN00rSFlwbVFlRnhxVGhvbHRIQWtz?=
 =?utf-8?B?eXhIaUt0cjdhOGRRU0tST21iVEFmVVlhWmpOdCttbHdDcnc3MGNWa0wvTGt4?=
 =?utf-8?B?WS9LYWJiRGNEM3M3TGVmc2thTkR1L2NYV0gveEl6Nk1sajVaMVZZbFZhNDZk?=
 =?utf-8?B?aStLaUgyMXozcjVkdW9CZndYNCtwSHpheUNMTHIwU0F4TFkrZDJramErcnFv?=
 =?utf-8?B?b1RiTkZDcm9tZ2VSdkJMN2FKYXk2cVJQeWxxczUvQnl6bDBhR1F6cVpLVWNO?=
 =?utf-8?B?MmlXNkZTOEZkbEZmRDYrdHo1dWR0SXdTeG5qS2srdWdXZUc1SlZGWW9kMnY0?=
 =?utf-8?B?VHAzTzI4T3pPSnZIWGR2RmFZY2hWcXk5TDltT0NvbVV5MHovZzNHNndSdFVY?=
 =?utf-8?B?a1RBMHVDNExXVHFUWkxWTGpTYURjYnhudkRmZlR4anNBNzl3dWYrQll4amFx?=
 =?utf-8?B?dUxjTEE2YmQyaFVlZ2NzRkJSMEpKZTNycTNIZE9yMmZySWdORDUwSXVwRzVM?=
 =?utf-8?B?Y0ZKQ2pIZDFPaUdGSExmSUdneE4yakoyUEt5ZkZFZnVUdW1Zb2xQbGZxTUk2?=
 =?utf-8?B?VXJRcFdxZVJPSnpaQ2hiVmJqZWpidlYrR0toL0FTQzRaTkhNdWkzZ2VnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFF0UXBVRWRQSnNrVHFudVdrOU94Mkp3Y3gydzNYMUZ3bVNPbGh2Nm5uMWo2?=
 =?utf-8?B?TVpwRkhpais5RUdLTUk5a0ZFNkR6ZTRtZk9rdUUvWGxaa2QxaW5ZMmNkNndt?=
 =?utf-8?B?TjY2ZE4rc25UTVhENmFEcW1yYVJJV3ZrRk1vYWYrOFhGRVUzemIzQlhhK1dM?=
 =?utf-8?B?cndYNUV6bWdOdTA3VXhYbDhIRmRkVzg5ejBtc0Y0aGhpUDNFTjNHM1lhdVNi?=
 =?utf-8?B?cjNxUWZHOW5qclRaU3ZaTzR2cFhDNCt6U1g3UWliRmpKd1NYTDMyTTFGdnQ2?=
 =?utf-8?B?QlluOG1HZmx5ZVVKeFRjRTAzN0lNWDZEd3RzeElRQjlnZnFjWmZzKzNIV3Nn?=
 =?utf-8?B?QlFxQXZpNVgzNGNxYVRwTmhnNEtabDBienQwVzZGYndMSmt1Sk1qbktYTUht?=
 =?utf-8?B?K1U5cDhzZ3M0MG1zbGl5WXRuY2RZT3kxZk9oR2FTWEVncXdSN2FuMjU5RGdy?=
 =?utf-8?B?bWhDSSs1OUw0OGRNcU1rOUFTdWpEa3ptMGJxRU45ZmxiODhwK1ZzYkZodkFn?=
 =?utf-8?B?b3RBdkppL1EwMytTZ2pSUVVzdGNScXRnQjYvdHJHTC94SkdKdUhEdlI4UGlN?=
 =?utf-8?B?bUtFZXJNNWU1KzBjVXQ4ZDJzSk5yTERMQlRyVDUwZHR2SmtldHBET2tEanBT?=
 =?utf-8?B?dzJJcnNSVm8yK0MyemlpY0VqSVdhclpFTGJsd05yMWQ0UVBFTHN2cHZCRS9U?=
 =?utf-8?B?NTl1NUxxZ3NRN09SQ3lsQll2YUJKRUxINW9vaTFSYU94Zkl6S0hGSU1lYmJS?=
 =?utf-8?B?RVQ1dHZFakYvT0FDblJVTkg4eFBYQ1dpeXZNWDdKYzlycWswRnJNcDNPcDFs?=
 =?utf-8?B?VXZraUtBcFJsTm96UDZ3UGUxVVB3ZlpVSHVRc20vOElINEFTVFV0c1pvUVUr?=
 =?utf-8?B?Wnl0alhYUEEySW1EN205QjBSamtLM2NvRHVEK3ZLV1VFZ055K0UwWFBOT1Nm?=
 =?utf-8?B?RUtnWnYybmdTNDJPMmRZYndoSi9CaC8wc1RtZzNuQktVSUZlR0V3a0U5VHoz?=
 =?utf-8?B?SDRSSGRnRFVSNEhjUzVvRy9BWlhlNTdncU1QeVdnNWlxVjNwYWFsRk9ZTFlq?=
 =?utf-8?B?UnJaRmxwek5sSlhla1VXU05lZG5iRFRTNWF3MU5oZ2ZSZm12M3k1WDhoRGlI?=
 =?utf-8?B?dmNwZStSTDI5VkJBSS9XRjdJTTlxK1VrYkI2Q0hBNTk3d2Z6UEVYZUdCZ0V2?=
 =?utf-8?B?WjJjNVFjaEZ1bWR6QkZDS3NuaDJML3NhemExSWJISFNtOE1Gc3lLRXBxemhp?=
 =?utf-8?B?VWdxM1hCb05yWnFjdHE5ckt4b3BJbmV6Vjh1REtvMXVVMHloTS9TSjBiN25V?=
 =?utf-8?B?dTJTZUV6eVA0dDBxYWpuZmJ2NGVic0J5ZmtkcUdPQzRoMkNiRTJsT1puNzI1?=
 =?utf-8?B?WkhkZk9rSVozeFhrbzY2cjZqaTlYK2tFeEJDeGpLVll3Q2x4VHlpYjh3eVJw?=
 =?utf-8?B?NnJWV0VWV09QZk5mTXRycXpzaDA5RmRraHlNRW9RLzN2dE4xT1krTGljOWYy?=
 =?utf-8?B?VXVRcTNEWFNPSVhIbEFqTnFnSjJGUDFZWENhbzBDc01aQ0hXaUFOMjVLQWdp?=
 =?utf-8?B?ZHlLaFBsZ29rR2tuTDRtSmljeEphY21GMkhJc1NVRklxUEd3NWdmVXhIWVV4?=
 =?utf-8?B?NDhnSjB5cUJJaVVsdkxWc3p0Qk1TcWVqL0tXNndZSDZaQk9nTlZDVnk3a1NC?=
 =?utf-8?B?Si9XNzd2VHNrbURIaTJuMVYxeExTQWZpdGxzbG9WemRlN3pPRkVJUzNER25W?=
 =?utf-8?B?MlgyT2lJLy9hcVFJZFF4Mng4MHhEeEtTWWxvUXBnSmlkcnNNVXVZdkc4Zjdn?=
 =?utf-8?B?UVhuUW1lL1k0blhLVW5EbVhFalU5K2VRek5wN2FxMGtTQUJRUUhGVnZ4Rmc1?=
 =?utf-8?B?QW1NVTQwSU9CTzVZbW03TXlITDRyUU4wejFEMWFONk1rZXhRcHRONnUxSi9l?=
 =?utf-8?B?MVdvY1d3Y0RDQ0FjWmgzNkNVZHZCMGNrWVhaUnlBTDNiTkd0dEFrbjd3bmxQ?=
 =?utf-8?B?U3J0SlBxUWlnTXRXM0JjT24vNXgzR0s2QVc4YWRKYktxUkdvZlZuN1ZOcUpx?=
 =?utf-8?B?NUZBVnY2eGlUQW5VOFFib1hETjVIeHUyUXFVaXh1dWVWVHdyTmlUT2tJRENN?=
 =?utf-8?Q?AHhc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d01a639-52f9-40e3-a9fb-08dcdca86aa5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 14:51:48.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOuwyUQ5hpSkw+ug3O1k5gu9cMSsDaSG0CoBgpZ2LWVjc1Tv1Jj7qzz/76zlM93t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076

Hi Reinette,

On 9/23/24 17:30, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/23/24 1:21 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 9/19/24 12:08, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>>> +/*
>>>> + * ABMC counters can be configured by writing to L3_QOS_ABMC_CFG.
>>>> + * @bw_type		: Bandwidth configuration(supported by BMEC)
>>>> + *			  tracked by the @cntr_id.
>>>> + * @bw_src		: Bandwidth source (RMID or CLOSID).
>>>> + * @reserved1		: Reserved.
>>>> + * @is_clos		: @bw_src field is a CLOSID (not an RMID).
>>>> + * @cntr_id		: Counter identifier.
>>>> + * @reserved		: Reserved.
>>>> + * @cntr_en		: Tracking enable bit.
>>>> + * @cfg_en		: Configuration enable bit.
>>>> + *
>>>> + * Configuration and tracking:
>>>> + * CfgEn=1,CtrEn=0 : Configure CtrID and but no tracking the events yet.
>>>> + * CfgEn=1,CtrEn=1 : Configure CtrID and start tracking events.
>>>
>>> Thanks for moving the text ... could it now be made to match the new (outside
>>> AMD arch document) destination? For example, "CfgEn" becomes "@cfg_en",
>>
>> Sure. Will do.
>>
>>> "CtrID" becomes "@cntr_id" etc. Also please fix language, for example
>>> what does "and but no tracking the events yet" mean? So far this work
>>> has focused on "counting" vs "not counting" events and it is not
>>
>> I will change the text to "not counting".  Hope this will clarify here.
>>
>>> clear how this "tracking" fits it ... this seems to be the hardware
>>> view that means "tracking the RMID to which @cntr_id is assigned"?
>>> Please help readers to understand how the implementation is supported
>>> by the hardware.
>>
>> I have checked with hw team on this.
>> CfgEn: This corresponds counter assignment.
> 
> To be specific this corresponds to *hardware* counter assignment? This is
> because software sets CfgEn to 1 whether it is assigned from kernel perspective
> or not.

Yes. We are setting CfgEn = 1 in both assign/unassign.

In case of unassign, we want the counter to stop counting so that software
does not get confused. Otherwise it is really not required.


> 
> Actually ... when I look at the AMD spec it becomes more clear to me. If I
> understand the spec correctly the CfgEn bit is used to coordinate changes
> between OS and HW. Seems like OS can leisurely write to any fields of
> L3_QOS_ABMC_CFG, but only when CfgEn bit is set will the actual hardware
> configuration be performed.
> 
>> CtrEn: This is to start or stop counting.
>>        We always set this to 1 to start counting.
> 
> Understood. Now that I read this portion of AMD spec it is more clear to me
> and I understand why CfgEn is set in both counter assign and unassign.
> 
> Reinette
> 

-- 
Thanks
Babu Moger

