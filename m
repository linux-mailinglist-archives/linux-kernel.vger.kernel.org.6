Return-Path: <linux-kernel+bounces-370368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2738E9A2B91
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6F21F2121F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFECB1DFE34;
	Thu, 17 Oct 2024 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wHatS3GP"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8CA1D95BE;
	Thu, 17 Oct 2024 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187966; cv=fail; b=K13UN+5OZtV3wBxTmcuvkXz9ijFhxmlWqotBWcLHh2Qspx3tZKZvLncjcS/a87IcsIiTbEm9/PrQfUIpvTTIfss4X6ektCwtHW0KZ4s+VcuU55pQfD3JK0VREbWLUAvgSE7K51vNnOAb8z3mdFfvcHyENBkh394vYmlRjwxH8Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187966; c=relaxed/simple;
	bh=WwssymYyzvuhVwdeBprWWzR++WxAGUZayG15kPXAFNw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qBAFzHogAcRtNIyvqLEfVR/Zd3D2HAcr0bQWp97mTqcv/s4aTS88p/Ao5SgtBfFZBswrRXHvkPdcff8UbKuFWjHHkc8Z3wxPFuIYYGFqxThOmZ/m0sYpQaMUqswxJlT+LdaxTv0+DFSjESg13wFpGVYHChIb5DPK46ZFk54z6jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wHatS3GP; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWiPRnGaIfEvOy09sEFNiKK+8rEOo32VkrBwLDxYHjNVgMl+zx1VTKzKG/rrAo7XIudKzJay6BhQf796sdwAnSWLN5FOfR+X2ux6cISczoZ6irJMku5ORdBHbvBM5cy9dRj+/NqApR1opoaWkwNdZl97wjE8O0UZekY0tUYDj3vIMdcO6o0nDXdCj4u0AEqgdujWArfnymRT8RfbBarg8DdQ0Pn8FlUa0OrgikXfBOc2GoTotj0iuRhny1SM87+MNisjYTnGzpcfCJ0VV60K3cqgdYogLa/lg70QRWc31Or8HzoNR/i3N5K2rbptsg78TULuom8ircmGGhKBDFn5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSpAWiEZkkow0uFclR/I0vmXVPYnvlEwE5EgCoqDES0=;
 b=FKdnH2kV/y/MsuVWdxb4cZj958uAk39KRef/MSbWw+2TXcmuDevojHmrHS5kp3PNYG4QSOpBoUpmVkZToyduRibSUKCLlsk6DADTjR2DKXEMCor9KLanXZ2pw99HWbEVJXPkZ1I13Q1eJvb26jgruSP3Qy1Ufu5Svb0I2Ex3kgSV87liVFMGYdxGp8sjVdpHYYsaC6XgIAQClzb4Daspba+08HO6M17wId2T7kkSNen19r9FzZxLK9Ns5XrH8b6C/r8Jtpl1d5DlDx2fwjKqkAQqaOYhrSng+NEMbu99pJcZbE5eHenEXQVmtySDABRyMeSF/RHCi6Ff7UphNyxcQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSpAWiEZkkow0uFclR/I0vmXVPYnvlEwE5EgCoqDES0=;
 b=wHatS3GP2d+vWKOUfMs6D8XtVyLX5b6++kil3HLVGcS0t8n1pguL+64C1XHqIf/wU74h9uZ/7ZFwW5onADzMchohZDV4OW6loLcxxSVH5tH+EL6pL4rO1Bxji8SiaJ1mM1ps1adDVqsvKVIag3HKfbawol5PZ9QQAKGfmlTX56s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 17:59:16 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 17:59:15 +0000
Message-ID: <d4c39495-aafa-43dc-b5a9-d36c22ae4db2@amd.com>
Date: Thu, 17 Oct 2024 12:59:11 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 12/25] x86/resctrl: Remove MSR reading of event
 configuration value
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <d6e298e9ccbf04207cb352b4f3c9f90613547b52.1728495588.git.babu.moger@amd.com>
 <dd53ed4f-d1c3-4b1c-9f4c-1852a64e9d87@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <dd53ed4f-d1c3-4b1c-9f4c-1852a64e9d87@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:806:27::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d4558c-4820-4419-039e-08dceed56a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE5TZUJVQ2pnUmxCVHdOZk0yZ2Mxd1dkV0tOc2pkd2hDVlFQZy9tWjYxaEZG?=
 =?utf-8?B?QW9tWmZqM3phTElxelBjRGdMY0NrVWp6OWdRaG4zdGdhZFhISHpxUE1vSU5s?=
 =?utf-8?B?Q2Rwai9vMHQ3VVNzQmRWbkN6RHo4WU5sNnhlb3NOZm9tdTgyaEI3TDBKQWpR?=
 =?utf-8?B?NWpTQWZkVWZjdG82RFNTKzNKVEhvYnVVdi9kZ3hWdWtPZ0hRRlZNYnkreVJy?=
 =?utf-8?B?RjJIN2lNZCtuSHZ0c21iWXo2N203RVJJTkFpdVRDbjBKTXFXV1ZMUmI1RjRu?=
 =?utf-8?B?Z3dmeUFaL2QwblRpS3Vtc001ZkxYcDhaSW5kZWo5bDVlWThxMTBOL3BhVHhL?=
 =?utf-8?B?OHp6eDZBUjZiSWJwQ0tEY0VFaHFUNU9kY2gzUENKQ1pRZ0syd0FuaGlZTTAr?=
 =?utf-8?B?UE42S0Y5eTBJeGY4K01DdFVYRWxYUnZYOE41YTNrMFlQU1VBNW5Kbjc1WENu?=
 =?utf-8?B?ZjJXMGNDaDJUaDcvUFNtNE5JZzhCTXJYN290NFh1dFRydTVNdFQrVk9ZNm95?=
 =?utf-8?B?RGkxTFJUTVdPVlZyakk5RERXZWttRzFxY21Qd3ZUZlRhcDdwOHlQZVVJZDFw?=
 =?utf-8?B?djJzTDRqOWVnNHZNc1M4bllsL0tDMVpWcGo3TVlqajN3NTVHc0M0d3E2aVdI?=
 =?utf-8?B?TVV6MzJWcnhOR1BVdElUUy84c2VBM1FnSjR2VDRGZTI1bEM0QXp6Z3pxWEk1?=
 =?utf-8?B?clF2U3BZVTN2VGI3eXBjYWFzc2RQYjh2VG5vSm5uQVM2a2pMSTZZa3Q3bW1W?=
 =?utf-8?B?RzR3V0ZDNHIwOWg3Y2VuRVhxeTN1MHJBQTJTWTBwNzBGMWx5SUpPUmN5Z2lh?=
 =?utf-8?B?Tm11UzJuK3BpS3pHcWlrTzhzOVlVY2ZzNG5BTEwydHRsU0ZpNlViandvZWxt?=
 =?utf-8?B?MWExTnBVWVJUZkZtUUlVNkVyTy9OcGV1ekU5MDhiK1gya2wySThRbXhQb2Z0?=
 =?utf-8?B?OUtmSitlNnpWYythYTZqU21MV04zcWk2UXVIY1JXNjhDdTIyODAzRFp6TzdP?=
 =?utf-8?B?ZlpHcTJoTXBQSFNmei9MeDZKWXdEa1R5bGRDelRWNmhYWGx0VWN1WFZOWmtp?=
 =?utf-8?B?YThpMFJDZ0JFdEFvc1luN0k0VDd3MkQ5bnlway9QaTFhUk9RSEZwNStiYlNN?=
 =?utf-8?B?dE9DMmt0QVNJVzJQU0VvRXQ5anB3akR6dlBpdnVBODNQcVdlNTdQdEFDekMw?=
 =?utf-8?B?NFhrZDVUSWk1eWp4RVVWRzdRa2dBWHZ3Sy9MdmxiNDBndm13QUovRWZyYlly?=
 =?utf-8?B?elBqa0crdTcxTE1VUkJVOWI3ZmRGZlJveHJwOEFCc2YrdUF6ZmRxSHhSOXhW?=
 =?utf-8?B?c1diVnArODBtSjdacGxpNlhnYWNBaDh4R3h0NnBWNmZzMkxESXJyOUMrcFRm?=
 =?utf-8?B?TnhxcWpPSVNxMGFSQ2JSVTRubGVEK2RNQzMyZndMZ2dwRUYxaEliaDhURUw5?=
 =?utf-8?B?NHpsRlc0UXJXN2RPLzFlM1NST2ZVb2J4ZXpvZGFHU3J3Sm1pWlZSekxkc2x2?=
 =?utf-8?B?SnpCQkYwUTNYRWRjZCtKTnNKcE1MYmNpclNUSHovV244WDk3SmxiUWpWMklo?=
 =?utf-8?B?cmtobG5MamNtK3cydVhrRGhBSXZPaXlQR3ZIUkZSWUZVVFVONmZQUUpWN1Bw?=
 =?utf-8?B?OFE3N1h3SVI2Q3ExY3hpZUhIVDlCMXFkOXkxdElmWG5zVlpCeXFpRzdrNW9P?=
 =?utf-8?B?OUxjVkxZNGdSRnZLUU1DTUFHRW5kLzRpblBZYmlPamV5WVM2NVZRdG9BOVFU?=
 =?utf-8?Q?4ul8aK+UYZqjiY4h8P/pYswuA3HD1bi07ISefzM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2Z3QS9ybExHQXpZV2R3ZVNqSWJHbWFNRkJMOTZTN0hlcUQzRmZBYmtJcVVh?=
 =?utf-8?B?NkdjYkJBRmcwMTRnM0ZqYjRoQnhjc0VwWXdCL0tReHhkZ3R3bXR0YU1qMkZM?=
 =?utf-8?B?VjE0VExRMTM2ektFbmRRNGhPaW8zeXZXWDRzbjVGSVdjcUZCRXpDditnbVUx?=
 =?utf-8?B?dElqcEdQM2o3QjBjWEdaUkNmVUNYbDZINmZKY1NUckdKa2NYUkpUWmlRRHFj?=
 =?utf-8?B?N0RNdFlBT2JYbyswUENFR1FLQW5hTW16RjNTeVVlWWErcmpjSWQ2MDBndXh4?=
 =?utf-8?B?WHZBeUlTallsNGlFVVdZR3hlL1NNN05JZXJmclJFTk10S2ZPWThibmZsZjhr?=
 =?utf-8?B?YTZqTTBPUjR4OWFQME1sRUxFRUIzNWVVdzkrdmVEL3k2TkNFVzc1Q0JzV0pi?=
 =?utf-8?B?QWdaeFYvS2UxNlFhcmlPNlhFSDlZb3psZ2NtMlV0a1M1NFZ2bVo5NDVSYUNx?=
 =?utf-8?B?RVlPY2lHYzJ4ZGJBMkVaODhlNDY5Vlp0WERObzVNUHZRcE1TSUJhU1dRM1J1?=
 =?utf-8?B?TU1OMjZ1NmdKZHl0V2RXYmNiWGQ5QWlwNkp1U0YwREFOTWsvOTVaRE1VTnhV?=
 =?utf-8?B?TXJ5K2Z2WEIxOFE1cERuWkVDTWQvYlRuK3JLYnA2LzcrVUZEYkxxczJuWDBT?=
 =?utf-8?B?ZW1hbXJ4WW04dmVNNkZRWVovc0t5T0J2OGxyVmJZeEx6SjM2N3psM3p1RS93?=
 =?utf-8?B?RysyQ1NzbVRGWExkSENkM2toaDZ4NDh2RThyUWVLbnk1RDBBc2ZCQndLeXE0?=
 =?utf-8?B?RnZ2RDVmZi8wOWpJZnJYb2hJcHFHMHhIRUpOenVKcEJQNkYrbS8rc2ZkNDUr?=
 =?utf-8?B?aWpOeFJyWW5aNzlYaXFlc2liTUxvcDloVGx2NUs3TGh0R1ZWQ0dPb0NjTlp4?=
 =?utf-8?B?c1VGVUpsZW9YUitVS3pVNGJDdmZGdU10NUhrU2JSck4yZ09VZjBDWlF3TDhS?=
 =?utf-8?B?NUhEZ0xPa1NUWGhoS2x0RGpsZE5uYW1WU0prVGxBUUo4bnJjMjUvWDhTZGVl?=
 =?utf-8?B?RTFQV0FYSTZIVC9EdFhOdVlIb3FQa05HSHIxQk5telBPNDFOaWIvSFJuYTdS?=
 =?utf-8?B?N2E2QkdUZXBsTzJGZHdpNHZ3SzV3aGU1TTgzb0tzQVQ0cEZNZEFNSjVWWDhh?=
 =?utf-8?B?NzNwSXlOSUlYMFZNZjlrZmdiRitremtqNklvaURkOWxVMzFOVndWS3NKaGoy?=
 =?utf-8?B?L3dtaExKdHB1Q2NXamFKS3BJeTVpSmRiR2NaSHV1K1U5OEtXdGtnTHZOL3ND?=
 =?utf-8?B?V2o2TlpwakpVdXpkWFMvOWdMTkdRNXFRQU9Wb0h5aUdESEVTMWRBUzBDZEg2?=
 =?utf-8?B?T0xwOEtvd2w0aHE4dWp1d1JVSVJrUVZwaEdtY0xpc29Ta1M5eHpMTFdXRVFl?=
 =?utf-8?B?aUp5WktvZG9QOGFUZ0ZORmhYbEwrUjRQSnc2SmlBTXJEKzIrdjVFdjV3bXlh?=
 =?utf-8?B?RWppTjFDcU0xNkQzVndMcEpUTlppYWdyTFBwZjdyQzdWNUx4V3J3aEE5aitW?=
 =?utf-8?B?N2dwUE05cllYeTNRTS9mLzMzSjVzSGhGcjhkMkVyME85RTU5RWZyZmZOTzlo?=
 =?utf-8?B?clJ3YU9ZNmdUOVYwOTVQZzArd3hwZDczQXdPalpuSFRjVFJ6b2VIWkJHaEY5?=
 =?utf-8?B?QTBRYmFZTjRBSTlBeXhoSjJFcXZ4bVpNQStRaGZqWHRHbEhteXd5K1N4SVkw?=
 =?utf-8?B?Y21yUm1PZzhuRW5tWUZUM2dqYWxSb29seUFCSUdpYXdqa3g2SldSRWlDL3dY?=
 =?utf-8?B?V3NNMHRwSm1OaVdmZlV0SXg5ZWtBY01yUkdCNmxSaGZ2NTFDOVdQVjZHZ2NI?=
 =?utf-8?B?SFJJZ212TGVPTUFKdG9maFBqYVpWVzFLekUrWlZlLzIyUDJxSXcyQitNUE5v?=
 =?utf-8?B?dDJSbGdZMlh2M3hNQXNtVGcwT2RwZ2llRWJ3eUpHaUZacHJBNG1lbWVQaFBC?=
 =?utf-8?B?eW5WNmFGZHA3UWdTMGhrUmZ3T3hDd0dINzFnRVJERU5FUWtiU1d1VlpnU1Mx?=
 =?utf-8?B?bVpBNENJWWxYVlpNYktqN2VVVDhKakhBNk5ZUERRbmgrbUE5NUpSblFKaFVP?=
 =?utf-8?B?UEZqS3MwREttUEtWT1BHcENjc1dXWC94VWprOXlhbWNadkZDM1FmdFIrdy82?=
 =?utf-8?Q?jjC0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d4558c-4820-4419-039e-08dceed56a2f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:59:15.8283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq/9RDBwMZWSpGuPsaCnoSwRTE5sxFilEtZsCnVAr657cHVWlxJScl4MehAStCGy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368

Hi Reinette,

On 10/15/24 22:16, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> The event configuration is domain specific and initialized during domain
>> initialization. The values are stored in struct rdt_hw_mon_domain.
>>
>> It is not required to read the configuration register every time user asks
>> for it. Use the value stored in struct rdt_hw_mon_domain instead.
>>
>> Introduce resctrl_arch_mon_event_config_get() and
>> resctrl_arch_mon_event_config_set() to get/set architecture domain specific
>> mbm_total_cfg/mbm_local_cfg values.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
> 
> 
>> +void resctrl_arch_mon_event_config_set(void *info)
>> +{
>> +	struct mon_config_info *mon_info = info;
>> +	struct rdt_hw_mon_domain *hw_dom;
>> +	unsigned int index;
>> +
>> +	index = mon_event_config_index_get(mon_info->evtid);
>> +	if (index == INVALID_CONFIG_INDEX)
>> +		return;
>> +
>> +	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
>> +
>> +	hw_dom = resctrl_to_arch_mon_dom(mon_info->d);
>> +
>> +	switch (mon_info->evtid) {
>> +	case QOS_L3_OCCUP_EVENT_ID:
>> +		break;
> 
> This check does no harm but I do not think it is necessary since earlier
> mon_event_config_index_get() would return INVALID_CONFIG_INDEX if the
> evtid is QOS_L3_OCCUP_EVENT_ID.

Sure. Will remove it.

> 
>> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
>> +		hw_dom->mbm_total_cfg = mon_info->mon_config;
>> +		break;
>> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
>> +		hw_dom->mbm_local_cfg =  mon_info->mon_config;
> 
> nit: unnecessary space

Sure.

> 
>> +		break;
>> +	}
>> +}
>> +
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger

