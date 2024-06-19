Return-Path: <linux-kernel+bounces-221353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9541490F257
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11ED91F235FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4476614B96E;
	Wed, 19 Jun 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bDHMo8vb"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3A22339;
	Wed, 19 Jun 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811486; cv=fail; b=ChlBpcN1Q0BwCKgFp0sTLxH2do36vKGvQSCuE9vWwPnOfa9WTc8owxCIMsX5fedFFmpOCA/8UcMfjBcLUHbOqFcT3HWUtQnJJIbMy19XmufoZoqGigugxeyegYrOKbFvoKMX8F6pnc8JYAzF/67fTO8iaVd/nsw27pcw7TWJv0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811486; c=relaxed/simple;
	bh=zdzaNYRRuRLYwikxL5nPd15QuNIOhp0ENu694ilQ4rs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rVpqRZhjvg/RsFMPyufC1R8/sfxZ4vTrSZQrbxDp3XC5MyejxcfqPxIvMBJkZkWb30cadTxuofG1zMqaXJsz7MSAvVp5yB3jfh1urSG1KeSaFBh3JPrPNg0gjSM9k0lM4wl8rP0/rVl9i9RO4nRKvZVT2DkTKV7j5li5UCfqP1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bDHMo8vb; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB/neHhyVrYYj7EAQqzBlRwhGQRaZ0XMzvZ7CBpS8eCp+aYno+YQeemtFJUqzBXbyHE5rKJgoQYf8SZx+pwyR83QdZhGbORgRiLvcFX3yEIiiiOze0sj+XDx9Nwz+13EZNZSQJX5x4TN6Jja4gW8QA5ZJFF786JFUvvLuYHjOe8AG1GYrrPrE+0yLG+KVpKxQw7BQH4ZRGCQtxba3W+AIcU/jUEX1QDFhRXnDp6ouN00uppEj1o1RUT0E7Za/xc0+KxHSe+QV0Wjm4unhhiL0/FIAuqz6SnkcUB8a36OHkA7KkQOZSZuGEcFTyN6AsuRL/qniiTA5nyqW5BSFrwSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcwQa0rlriHzpAYfcd06Xox80II3JiatjTGrfV41LHk=;
 b=bleWNTgdm3BWBVBck2sQaluZv6iwvDHklniVAw9sEjOHdkdwEid1fwnBq0RBuwD1ukFkZqjvu6l9ixoYT2lT+/sn8qtz/qyLJnbE+Fuwj9poa2KjobBKDREFloO1kuTBoJ2YKXA+F1ciMjQfMQns3k3gTPyZQmpKZWVwvq48aiiuwJP5ChcAk9bFRs86nom2btAYDGph37/wrOe2W18rCT74G3MMyUwkFFaxww/yXaaRo8/U4lApwHYIKoEdP3jUP9aFo1rNW9BhC9UtQaBaIMnnN/2AtH9m5hXqo69/L2gUItcogEjz5rOHhy2aHNX0odTUOJ84vTmbKOPevRlNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcwQa0rlriHzpAYfcd06Xox80II3JiatjTGrfV41LHk=;
 b=bDHMo8vbPkEBmqxwYKd44+e+3mf5y1Ielo0fTXHsEg+2BZjqSYLSHagu9RNsiLARxoEbZ+AVhm7wBHcs9/zRTtyF1BG8d/EAnZvk49e/80tlqhorC5k9gZojP1fXeg+6ZSyq3SjT5HhMGoYc/VSTHLxjiN6y8afUwruvYj6sxPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:37:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 15:37:58 +0000
Message-ID: <a08d4234-651c-4ac5-9cf8-96a4461c71ce@amd.com>
Date: Wed, 19 Jun 2024 10:37:54 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 07/19] x86/resctrl: Add support to enable/disable ABMC
 feature
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <e4edf1794852cff132b17c8f061f24799d9e79ad.1716552602.git.babu.moger@amd.com>
 <28cd2683-2ab5-4772-8597-6aaf0aec1f0e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <28cd2683-2ab5-4772-8597-6aaf0aec1f0e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0081.namprd12.prod.outlook.com
 (2603:10b6:802:21::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f367ec-8c12-4d48-0d94-08dc9075cb80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1paNDh5TUdKVEUra3pkU2U1WHRpMVRGSk9CZGR0cjRjbXgrOGo3aktwLzB1?=
 =?utf-8?B?Y1ZVZEhraWxuRHg2L3FlNW5DcElUL1NZQkNqMDNPUkZIejA0Mm1rNTY2R2cz?=
 =?utf-8?B?Ym9lVHVJNkdPQTFhR0E3WndOTmRac0NDTG9QcTV1eU5ZV1VHUDkvbThYRGNQ?=
 =?utf-8?B?TkI2YzRLK3FqR3FCYTlxTnB3aFZRY1gzTmJnL3pnUC9MZXRJaFhJUk03bkh4?=
 =?utf-8?B?cVhma0ljK0wzMnF2YUtqVlhvRllaeXRiZW9WaW5pb0VES3Z6a2tLQjN0VHo4?=
 =?utf-8?B?TVJhSFU4WnNTNkpSTWpoc3hJdnJUczQ3TzQ5STk2RGVWV1pOWkFwNWpibnVa?=
 =?utf-8?B?Yno5djdzTDQ5MU5kTG5VaGFmWEhNWjIvbkR4M1VRaHhqTFpYU3NyR09mYmxI?=
 =?utf-8?B?UDlqWTlQN1RTSnJWQW5CMXZlQ2VIb1pyam1aaXlEWWJSMVd2TVlCdmxXVHJ1?=
 =?utf-8?B?eUdRY0wzcEN1azhMWkUvYzBRVzFXREtFSmdRVHEvek4rT0ZDdWR2cUVlY2g2?=
 =?utf-8?B?aGJlUGxoZDN6eFVZcXd6OGd4U2xyZVFMdElic1gzRUlxaitCak1kZkJVRGxH?=
 =?utf-8?B?OFN3VXl2dldzSDdGYmxVczNWb085QW4wNjhZbnczTmh3NXQ0UW83ZHBqTHdW?=
 =?utf-8?B?VFExYzByM1FFQVAxNXdpQ0NSemFndW90bXdob29vWitySU9BNW40Q25rL1I3?=
 =?utf-8?B?NWRDUWV5SFc4RjQrclU4dFlBSXh4WFJodGNJdFgwYmxkV1E1YXh2TkNsSWFY?=
 =?utf-8?B?TEo4QllHdzBxbHVOM2Y2K1BRMEVMZkltR0NGRzd1b0owVnJMbWpaejJxeWI5?=
 =?utf-8?B?dGVSaTRCNFhZWnAvR05tTnRzTm5uSFpDVWx5Smd6NG55aTAzS0hMSUs5WmZW?=
 =?utf-8?B?d3dHeUg2aWVGSFI1NmhvMTd6U0lDd21rTXhyMFZjcDZvbVdremg4clhtWFpU?=
 =?utf-8?B?YmQ0aGFmRXpLNFFYL2NLR29XWGt5UkpzVVVud1FVbUlQV214QXlpai8xSWI3?=
 =?utf-8?B?WnY1U3QxMExCQWdtM0g3N2I4elVCbDZic0RrMnlxYUgvOXJQRzZmR2RXQWlr?=
 =?utf-8?B?RGpwY0pCcnI3dTQ4TGhGNmVvVHRoZ2xwUjVTc3lZUTErc3VYQ0lwOHBPSjR3?=
 =?utf-8?B?bkFWMllubnFMalpDc081SmRIekdDODNEQXVUc0huT0t1Um15czhzRk8zWUhv?=
 =?utf-8?B?Sk50c3g4S0dQZXZwL05TMDlIT1VuZzJkRTlxUjRxN3dieTRWWGM5My9ZeUg5?=
 =?utf-8?B?QXhoME9ncFBhOEFaU0xVaU9RSTNjNmVYWGFlNGFtclE2RXBUc3FDZzdRczZP?=
 =?utf-8?B?d08xbnhQamltRVBEZGZMVjRkaVFMOExWOWtMTDYwVWRqd0RWaU9LYVdqaGpT?=
 =?utf-8?B?ZFpqMmpERGM1NWtkSlVGbmdkV2pXY2lXbVFMRkVqaG1hUEJCT1M3ZmphZlBZ?=
 =?utf-8?B?enhtdm1SY2tjcTZOaGk0OS9mRC9TeUJSL3FRc1Z0aGMvczVVcWZzQ1VFejJk?=
 =?utf-8?B?dlZWL0JOL3d1SDZjdlR5UTVjWHp3UTBPd0ZFaTZhNXZmWFpZZkFOLzZKV2R0?=
 =?utf-8?B?ZkFPcFMvUC9Kc3BDb1B5Nk5QbEd5UjBVOWZwdjBHd3VZWWJZOEVNN2JwcUlo?=
 =?utf-8?B?b1pMQlpqR1VpLzU3Wjd4UzBYZjQrckJGYjkwOGVZL3JaY1FhM2NWQWYwQWdQ?=
 =?utf-8?Q?c38ZLjEqWh9gOXIYaMV3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFczekNyVktwYmhTUzNoKzhDQXNWeUdBNE9PV0hUZmVDYkdVcWVHeDExSTdn?=
 =?utf-8?B?VGlTSVBia09YWFVISXhnL3Z0YS9BOFE0L1VkMjVydEtoYzBjTzhQL000OG9E?=
 =?utf-8?B?bm9HTG1EVkpxUHpYL1ArcDkwQ0VkWFh0Qi9GTFcrN1dsdmRCeXRjc2pFUmN6?=
 =?utf-8?B?bkVDS1dOMHAyYjd5WDZZTWFBRm0yNFMwa1E1M2NrVXREQlF3K0tpaGJPWmhk?=
 =?utf-8?B?NjdEWGZiTWorVCs1V2hVb3pNcFBrY1BVaVZvNEU5dnBKWkRoL3d6VnZjMlIw?=
 =?utf-8?B?QUc0alRVdjF1VTUwRWlZdFQ1VkhkeTRKMndObGVVQlhuUDFaQlBnUXJvb0ti?=
 =?utf-8?B?SldjWXFIc3J0ejBWNy9IRDVENkpPMTNxdGlGMVhUdXFsazVsN3hYbWl6Nm5x?=
 =?utf-8?B?MERKcFRWVUgwVi9iM1RCWVRsQkVqNWJHZUwvbEx6NjNySDd4aW94Z3d6S1Bv?=
 =?utf-8?B?SkZ3RkVCWTltdzV3WXhMNG9uOUw4emgrNGIwUUlLYXZ4bkoxdzlmLzdHU1Q1?=
 =?utf-8?B?aTNJTXVjeVg2Q0hkaktBNmJSanRwaDBTODc5TGlUWHpkUUF6ZldsZ2Fjb2cx?=
 =?utf-8?B?UFlyQ29SY01wZWl2U0tHYU9rSDNzeVducWpYOGJRU2gyVEk1SC82K0lLZ2ph?=
 =?utf-8?B?WTlBQmhlL0RnWlBvcmVxelNtb3NjQ0tOWXh2SHdVYTUvK2NCemZIOGV4RGxP?=
 =?utf-8?B?L08wYXJSU1hVNEJBVjFzaDFaSDcvK3FlcC9OSlRCQnU1VDhiUElyR3BONTRJ?=
 =?utf-8?B?WmJHTUQ3VTJsSGtydjZNT3ZOcnJ5TUZPZXlqZElZMm9TQXpHdmZySWZyblZH?=
 =?utf-8?B?b21TRkF2bmthak9SL2xPNUVkcURtbzBIbkpORHVHTWlaQUhaTnFIZ0tub0xo?=
 =?utf-8?B?ZnQyQU5NTGxZWm8wVUh6SFcvS3VNMGhrdFYwU2VxWElITlBSYUVzbE1XbmJp?=
 =?utf-8?B?WHVSN25UVkh5WE5FTDBhcHk0RkVVMVpxaGpPMGxZbUpLTFg1MFBVbTg3RHFj?=
 =?utf-8?B?a1RFYXk5eHVZWGFuWElLOEFkdjQ0THpuWUU3RkZtekpielhUVDZoMWpRaFZ4?=
 =?utf-8?B?d0xnWWwyY0d1UzRWNFdKcEZvS1JSNlNFOUFIaVVscndFaHJTSU1qNFJuSlp6?=
 =?utf-8?B?OXkxdVVTSEJ1NWNxTFJvQkxuL0pzVmliWlpvQTlMWHRqSGtKd04rR2pPbVBQ?=
 =?utf-8?B?NUJOL0JiOWRTQWpNQm1lYXdYOTJFN0lFdEdIWW1aUDl0MnB5ejcvTFlHTnlN?=
 =?utf-8?B?TFpKVXFXVkNDdlNXUmh2Y3RpKzFTaldiM2NVSE81MzZFbVhxL3R6UE1ESFlZ?=
 =?utf-8?B?M09lYm9ENkhZcjR4SDVuK0tRS1NwOVVNZ2t5WUZKdWJvRElvelpqeDFWS3ky?=
 =?utf-8?B?V05zOFBrRlJUOWZnZytMbDc3c01wMC9ZYTZaV05taFpqOEc0ZzVpWGh5TlRt?=
 =?utf-8?B?Q0xkZjM0Sk5YMDUvOGdhMWdxTWtuT001aUxaSlRTUGRmRnVsdGR1TjVFc09L?=
 =?utf-8?B?d0lpd0tyTGVFTnkrWDdET3A3Rm5XQzRDL3ZVc0VYWkF0Z3lTQ08xWlZrRGNS?=
 =?utf-8?B?Z3ppRWxYenlxTnVOVnFERityQU12blBabzg4UXNGOWxLT3RnaFJHRnpBV3dC?=
 =?utf-8?B?b0ZWK2VoSGJZcEgrelhjWWJabHI0ZUpkbGE0d1RSYktrL3RPREdQK0xuQzYv?=
 =?utf-8?B?L29VNE90dnZQNlZNTXhkVVRUeDFJdVVnKzdZYVVSNVBaTUlYbXVsZUg4NVJE?=
 =?utf-8?B?a3d4UjQvQjhuMVFoK0FrekVuVTVWV3U1NkNxV1JabTB1UjloNWJGZFpMSnc5?=
 =?utf-8?B?MkFrQ25ydzBJWmZZckt2aXFuMnFFTjhZai9sWTdGcmNjdnhHcEF5WXdmQzh0?=
 =?utf-8?B?TjlYM1duVlVaUFUrRWxGcXk1N0JDUGpMVFFjTWJUcm5XVk5yTjNQQldaSjNx?=
 =?utf-8?B?K0dHZFhOZkg3ODFyMy9RZFZ6K01tM2RsS1ZudGs0dEJuYXdJU2djWWFLcDUw?=
 =?utf-8?B?V2EyamphRThwWGUwYitMNWZDcS92T1h5bzlNL1hnNjBOazFTU2NHZjIxYjha?=
 =?utf-8?B?VUdVakVvUjY3OHJyTGNOT3BJbmVuRit0anU3cjMvRWJxbU50VUNLdXJhcXJx?=
 =?utf-8?Q?7VBc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f367ec-8c12-4d48-0d94-08dc9075cb80
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:37:58.1357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPtzBhQBKB6tWxJLdTZ3a8e3CvGpBLrLZH1joctC0lZm7PiZqzKX0uHy+d5i0a0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080

Hi Reinette,

On 6/13/24 19:59, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> Add the functionality to enable/disable ABMC feature.
>>
>> ABMC feature is enabled by setting enabled bit(0) in MSR L3_QOS_EXT_CFG.
>> When the state of ABMC is changed, the MSR needs to be updated on all
>> the logical processors in the QOS Domain.
>>
>> Hardware counters will reset when ABMC state is changed. Kernel internal
>> counters need to be reset to avoid overflow condition in the next update.
> 
> Please note that there are two "ABMC" features introduced in this series.
> First, there is the "abmc" resctrl fs feature that just happens to have
> the same name as AMD's "ABMC" (which may be a good motivation to change
> this name). Second, there is the architecture (AMD) specific "ABMC" feature
> that is enabled in response to user's request to enable the
> resctrl "abmc" feature.
> 
> Other architectures need to support resctrl fs "abmc" feature with something
> entirely different.
> 
> Please consider this distinction during this series because it is often
> blurred.

I was explainaing the enablement of  AMD's ABMC feature here. I can add
text about it.

> 
>>
>> The ABMC feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>> v4: Removed resctrl_arch_set_abmc_enabled and
>> resctrl_arch_get_abmc_enabled.
>>      Directly calling resctrl_abmc_enable and resctrl_abmc_disable.
>>      Renamed couple of functions.
>>      resctrl_abmc_msrwrite() -> resctrl_abmc_set_one()
>>      resctrl_abmc_setup() -> resctrl_abmc_set_all()
>>      Added rdtgroup_mutex lockdep asserts.
>>      Updated commit log and code comments.
>>
>> v3: No changes.
>>
>> v2: Few text changes in commit message.
>> ---
>>   arch/x86/include/asm/msr-index.h       |  1 +
>>   arch/x86/kernel/cpu/resctrl/internal.h |  8 ++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 62 ++++++++++++++++++++++++++
>>   3 files changed, 71 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h
>> b/arch/x86/include/asm/msr-index.h
>> index e022e6eb766c..5f9a0139e98c 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1171,6 +1171,7 @@
>>   #define MSR_IA32_MBA_BW_BASE        0xc0000200
>>   #define MSR_IA32_SMBA_BW_BASE        0xc0000280
>>   #define MSR_IA32_EVT_CFG_BASE        0xc0000400
>> +#define MSR_IA32_L3_QOS_EXT_CFG        0xc00003ff
>>     /* MSR_IA32_VMX_MISC bits */
>>   #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index d566251094b2..fabe40304798 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -97,6 +97,9 @@ cpumask_any_housekeeping(const struct cpumask *mask,
>> int exclude_cpu)
>>       return cpu;
>>   }
>>   +/* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature */
>> +#define ABMC_ENABLE            BIT(0)
>> +
>>   struct rdt_fs_context {
>>       struct kernfs_fs_context    kfc;
>>       bool                enable_cdpl2;
>> @@ -436,6 +439,7 @@ struct rdt_parse_data {
>>    * @mbm_cfg_mask:    Bandwidth sources that can be tracked when Bandwidth
>>    *            Monitoring Event Configuration (BMEC) is supported.
>>    * @cdp_enabled:    CDP state of this resource
>> + * @abmc_enabled:    ABMC feature is enabled
>>    *
>>    * Members of this structure are either private to the architecture
>>    * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
>> @@ -450,6 +454,7 @@ struct rdt_hw_resource {
>>       unsigned int        mbm_width;
>>       unsigned int        mbm_cfg_mask;
>>       bool            cdp_enabled;
>> +    bool            abmc_enabled;
>>   };
>>   
> 
> ok, so here by making "abmc_enabled" a member of struct rdt_hw_resource
> this is
> an architecture specific property. This is reasonable since every
> architecture
> will look different. What is _not_ ok is that this causes the rest of the
> series to change resctrl fs to reach into the architecture code. For example,
> this work causes mbm_config_show() to now need to peek into struct
> rdt_hw_resource
> to see this value. That is not ok. All of the interactions between this
> field and resctrl fs needs to be via arch helpers:
> resctrl_arch_abmc_enable()/
> resctrl_arch_abmc_disable() and
> resctrl_arch_get_abmc_enabled()/resctrl_arch_set_abmc_enabled().

Sure. Will change it.

> 
>>   static inline struct rdt_hw_resource *resctrl_to_arch_res(struct
>> rdt_resource *r)
>> @@ -493,6 +498,9 @@ static inline bool resctrl_arch_get_cdp_enabled(enum
>> resctrl_res_level l)
>>     int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool
>> enable);
>>   +int resctrl_abmc_enable(enum resctrl_res_level l);
>> +void resctrl_abmc_disable(enum resctrl_res_level l);
> 
> Why do these need enum resctrl_res_level parameter?

It is really not required. It is always "RDT_RESOURCE_L3".
I can remove it.

> 
>> +
>>   /*
>>    * To return the common struct rdt_resource, which is contained in struct
>>    * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index ca692712b393..9148d1234ede 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2416,6 +2416,68 @@ int resctrl_arch_set_cdp_enabled(enum
>> resctrl_res_level l, bool enable)
>>       return 0;
>>   }
>>   +static void resctrl_abmc_set_one(void *arg)
>> +{
>> +    bool *enable = arg;
>> +    u64 msrval;
>> +
>> +    rdmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
>> +
>> +    if (*enable)
>> +        msrval |= ABMC_ENABLE;
>> +    else
>> +        msrval &= ~ABMC_ENABLE;
>> +
>> +    wrmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
>> +}
>> +
>> +static int resctrl_abmc_set_all(enum resctrl_res_level l, bool enable)
> 
> Should this function and resctrl_abmc_set_one() perhaps have "amd" in the
> name just to enforce that this is not filesystem code at all and specific
> and unique to AMD.

Sure.

> 
>> +{
>> +    struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
>> +    struct rdt_domain *d;
>> +
>> +    /*
>> +     * Update QOS_CFG MSR on all the CPUs associated with the resource
> 
> end of sentence needs "."

Sure.

> 
> This comment about the specific register seems more appropriate to
> resctrl_abmc_set_one() though. This function is a higher level
> enable/disable of the hardware feature.

Ok.

> 
>> +     * Hardware counters will reset after switching the monotor mode.
> 
> monotor -> monitor

Sure.

> 
>> +     * Reset the internal counters so that it is not considered as
>> +     * an overflow in next update.
> 
> For the first time the term "internal counters" is introduced. What does it
> mean?

How about "mbm counters"?

> 
>> +     */
>> +    list_for_each_entry(d, &r->domains, list) {
>> +        on_each_cpu_mask(&d->cpu_mask, resctrl_abmc_set_one, &enable, 1);
>> +        resctrl_arch_reset_rmid_all(r, d);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +int resctrl_abmc_enable(enum resctrl_res_level l)
>> +{
>> +    struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>> +    int ret = 0;
>> +
>> +    lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +    if (!hw_res->abmc_enabled) {
>> +        ret = resctrl_abmc_set_all(l, true);
>> +        if (!ret)
>> +            hw_res->abmc_enabled = true;
> 
> This error handling seems useless since resctrl_abmc_set_all() always returns
> 0 ... perhaps it should return void instead and this error handling dropped?
> With that this function can never fail either and it can just return void,
> but this is probably not what we want as the architecture call since other
> architectures may fail.

Understood.

> 
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +void resctrl_abmc_disable(enum resctrl_res_level l)
>> +{
>> +    struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>> +
>> +    lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +    if (hw_res->abmc_enabled) {
>> +        resctrl_abmc_set_all(l, false);
>> +        hw_res->abmc_enabled = false;
>> +    }
>> +}
>> +
>>   /*
>>    * We don't allow rdtgroup directories to be created anywhere
>>    * except the root directory. Thus when looking for the rdtgroup
> 
> Reinette
> 

-- 
Thanks
Babu Moger

