Return-Path: <linux-kernel+bounces-560321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1EDA60247
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B69A881128
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4451F754A;
	Thu, 13 Mar 2025 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OZW9pkuL"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D31F4169;
	Thu, 13 Mar 2025 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741896822; cv=fail; b=A2MUj0olQ9c4NoeWVrfVIJMOyrO8s1Qzkhvs2PTZpz7+BfvcNWHt+FyvidH0MC7bBcu7vGsTvq27zBxqvJIwWJD51NEL6mdAggCHNNKVNI+jKDdyfPL6JyBuU9/1x63IHBbK53dFoTByG9YMb1MClXOor0sUjoo45rl92GX8BhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741896822; c=relaxed/simple;
	bh=NXmkyf2guOFHaF+cReBgtYLs8JHOHN8tqayq7zhIOa8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NeQ9xYVcp3yq1AlL4E5zgETdV8IGToZGUrXVx3BPozYWhyWSKnuqHEwowRFznG42oIFc1p6alDjugimfLDxAWfDfvHc6iwERBdcx9i6/zNLGtWmOMfP6feRhAm8R41hPE7URT4/988jF6pAcXnp2Jjrfkvs8CFr3auQvNKedsB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OZW9pkuL; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5G/7XWGRDbhDVLgBJ2ykKoUE/xxZLreqPgmGRs8V/pZS2tf1Q7c+CX+P7i6Ee1lH00e7kxO9v8BfuJKg1yjFLgw8/QBmVEVuC0XaWTj8gONguMvu/MmXQH2qhooWKrIOtyiRMZLc53ambdAjKrjo1R5zl9U50kuf6RYCCIYbfJx+axXDvpseDegj2JYGGnZ+GH6iGCN0HBG1SKtWNCEOAB8nBXms9DR+4Nv5CH8dUoIf2oTI0vz0KThlhMezK3rRnpRD+0lh/YW4ZaWgjqJgfb06G2EY3R1kkrNRl4v/2sDXpdPK90u0P2oXocgEY2zh4N5dmsJJNzLTfPFGLdDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIAANKjr/b1trNvGpQgzGB9o7E1FLcG4nsyr5xJm+v0=;
 b=YZ+XKvYPC2Gg604eZFyml9FD/WoT2c/AqsWNvQIxnJ3A8Imkv7PoGzEUtfFNaI7IalBudG4AhGmMNDx25Ny5JPo5nNrqKvbkG3t8tzOU9KaZOAQmqZIk7z4irq0VorY1Yju5wRwTXbO3y1mS2ENRa3VeAfdGT5Iw3FWSpFbv2dXRe4+Ij4XRmRyWghJ2GABIrNAxdQWhikYXp7XemAAhT69Hqp9pb8ceJX0wrKMKvwOJaD+N588PVNh7aEZet7FIyVDuIg1Y+A5uPQLac7VFM0kI29rk8W0keyFLNWhiGZQ3KSwBUlfy+ybqdl+EJWua8c0Rqq88NALvgQJSvHNzXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIAANKjr/b1trNvGpQgzGB9o7E1FLcG4nsyr5xJm+v0=;
 b=OZW9pkuLUPH1kz9Rvx4Hu634/Lq6ekIzK4jsWdxu/L7H4i9Qh6X9/x6I6RvX8lC8CiHyOPoBFJIv9zOacG9bbzF7c6Ug36VpjzX8t7sfHcGe6yfp8wdQmNvHmVC18ujebOQchdFuSbbMzFjSgn0fbyzujrna6/w9ZO48OADJEds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 20:13:37 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%2]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 20:13:37 +0000
Message-ID: <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
Date: Thu, 13 Mar 2025 15:13:32 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, "Luck, Tony" <tony.luck@intel.com>
Cc: Peter Newman <peternewman@google.com>, Dave Martin <Dave.Martin@arm.com>,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
 <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com>
 <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
 <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com>
 <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
 <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com>
 <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
 <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
 <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17)
 To SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MW6PR12MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: d16ee503-d4f9-43b5-f39e-08dd626b89d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WURvZkRkbU5xQWVlamVuekVPNzZiWXByclliNFRiUG52ekFtTVplam1wajkv?=
 =?utf-8?B?TUJCMG96bzhlcHNDa2lDMnNhS1NRQmVYbi9LTVcreFl6RkJCR09LdE9XVGd5?=
 =?utf-8?B?bEdQMWNMVlgySlErNVlBdkJGT2dteFQ1NndrNThkTCtZQVYwQkVVYzR6eDhO?=
 =?utf-8?B?ZUtpaHhKYVl5c09GSzZESGRaL1JzQUZkbk11Ky9Xb2ZpTlpqSy9qeng2a1Za?=
 =?utf-8?B?eHN5UkU2TUlwRmNQdENTci80ZSs5Y2M3bDErM3Byc0xCWE1USGpKRU1xdW1w?=
 =?utf-8?B?NE1sb1MvYzdjdHc0WE5iVVNwSGI1UmZ6SnBFM2UyWXN5Zm1Vdk5KQzV3QWx6?=
 =?utf-8?B?UmxGdW9pZkxhaXJRRjQxV3BrL2xkSDlZQjQ4b1g2T1BTOHd1Mno3NzB3OFRN?=
 =?utf-8?B?RVdjSDZCcXBLaS9JWkF1Tm1IWnRTdDY0LzRxai9HQnhTSmF6L1JBWG1DU2hy?=
 =?utf-8?B?dWxrWmtWOU9mMWF4YVhGQk90MUtYYTg0MVdDQmpMbkt0ckN0MmhvNXJBZnJh?=
 =?utf-8?B?TjNGZjE3Tnl4a1ZCRGxMTlpKUTV5NDhmT1prbTJrZzRGend2SGRRRHdmdGVm?=
 =?utf-8?B?bEdSVVdnemNjNmZJSmhWUWlTWG4rb29vQU80Qm5LWHlHS0RVWXVrODkwYWNy?=
 =?utf-8?B?cVJ5WWwzWjA5ajJTQkNhUXhUMEVJaVAxN2hYMW03NnB2VGZweVB2eXpiQUQv?=
 =?utf-8?B?YmxOQW1aS0pEeFlVdnZrM2l3cDFxVEdFTGJzbVFKcTRtZVlSdFU1RGNpUHI5?=
 =?utf-8?B?WjVhSzR2anZoNUpOR0N4bjhmUHpFa21DdFAvUWZzd3pFTkFJQVBYeS9uR0Nw?=
 =?utf-8?B?cmlWMUlaUU5idVpCWDdVbVVLN3B0aGtUY1RkY1V2TFRnSzQ4K2xRYktxaXFo?=
 =?utf-8?B?dHhzb3piWnFQUnJYdExkNk1zbnZSaFNRYzRZMXNYVS8xVTJHM0c1WHVMYVpM?=
 =?utf-8?B?Q3pESjJYMzkrQXkzV0h2dkFNSXdyYWNaZkNyQi9tUytZVlZVYkFyZXJpUC96?=
 =?utf-8?B?VmpVNzIraHNTYlZ2OXlocmdSTCtjNGRML3JWUUtMeG5OS2JnakRJaXpKc01W?=
 =?utf-8?B?ZGVHdDRuT2k2bGtGT043cjBsRVQrUUJIRjlXV3lCaUVrSTJZTzZXYVBJUmVq?=
 =?utf-8?B?Y0dMNit4UXNrUHBXZDVYVjZFdlByNmNmN2JER3k5SWJGYkFldnVyTHJlZm5u?=
 =?utf-8?B?M3ZIYjgyYmR1ZlF6QStYYy9zTlFERE16WVcxVWRUc25PallqMUU2UFJQNlNY?=
 =?utf-8?B?aTBTbTBVZXpGOGVBemRLNmM1cFpRL21UQ2ZncGZVbGI1ajZUaXhZZ0ZoNzZk?=
 =?utf-8?B?UHlsN08yWUZqMXhoL3grREEycjNLTVpweUxuR3Eyc3RWM0NWajZRbDdFeGx0?=
 =?utf-8?B?bzdBQ0FEcmVaUnUxbDJDRlNkSWw3dGpJWjNLWm4veUhKSFZzNjN4NkV3Znlr?=
 =?utf-8?B?VWp0UXhZblJGNmFJQnI5MURtaUdaUDdFbWZrL3VKSWtheUgwelpBelFQWlNa?=
 =?utf-8?B?ODYwK1FxMERuU2RmUzg1WGFBSkVoelJtTWVYR1FVRk9tdndrNUwzMFNaMG9s?=
 =?utf-8?B?a0ZKbkMwKzNGTVM3UXU5OFdFaDBBSWRtdFFkS1JvS1pzcmVpZmc5L1BHdWwz?=
 =?utf-8?B?cEN0NThzRFpQT3plVjVyV21LVDVMY3RINXQ5QWUzYnkxcjRlaW5TWGZ5ZHo4?=
 =?utf-8?B?dHdIVytqTDZhOUppNGFYVjV5RDFMZzBlZWVGdWpjTlVRL3hVTTM2Qy92b3k4?=
 =?utf-8?B?QXZSalBGeVM2UndWM2ovZEVveHdHMCs5K0pPYSsweElDdE9EVUgvbTRieUps?=
 =?utf-8?B?cnVOS3NrbHRmOEdkMWZLYy9qNVgvUVMwZ3NMQWxSTUNQRVlZRktLOENqRWNy?=
 =?utf-8?B?bnRDMmZCOXBVb0wvaEN3Ym8yWXI5TFFaM2hDUkxlOFRVWEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUFJR1pXMldscjN6K2xkQjlKWWtHcmRyemttLy9RZEkvRFBZNHZJTDhsWE13?=
 =?utf-8?B?MVBDUktLVnlZeU1VT0RNR3ltNE5WemkyazdadkduZmJBbVQ0NVB4QkFPRDhV?=
 =?utf-8?B?M3JnTWh6YjBJMkU3RlpvVmJyRlVTSWttTzU2bjdZVjR3d3FZVm1aZjArdm1T?=
 =?utf-8?B?OFV1d2lpbkJQaWxYRHc2aUttcVU1VzZNNzlkbDg4YXhpQnpDWTFab3JzNGcw?=
 =?utf-8?B?VFVHa1ErVExmTnlsMmZhcWRFa2hQM05ybllmVG1mc0x1cVZxQ3lRNjVaaE92?=
 =?utf-8?B?SURQeCtoOGxZOHc3cEFHSXgrZzAyZXpYazFNOFhHOTlLMXVrUzRucjZuc29Z?=
 =?utf-8?B?YVprVW5rN1F1UWt1YjRDNUZ6aVFWSG9pOVdvVUkzbnVNVTdkR2RkZnZEQ2ow?=
 =?utf-8?B?OWhlMzcrcE9kRmkva0xkdXJ5Z0hPSUJSWlQzbENDN2ZuZDNrL2QzUmlTNXJK?=
 =?utf-8?B?YWFBaTlkODRJU2M5RFd2R3hWM1FQSlNsYlN4OGFVK1QwMitUSjFXTkFxeGJv?=
 =?utf-8?B?T3d5cEdRa1hYL29vc0VBbkNBRytOSU0rcHF3bTZCeWZ6dXc0azJheDBrWWtu?=
 =?utf-8?B?UzRqN2dSSzJVd3MrRmlhMnNuZ1hQODhmUnZDbExINGdKbVJ2UHFzTzJMZEU2?=
 =?utf-8?B?T3FYa2hxaEFEZnFKZHB1SU13c2EvWHNzODZDcExrOU1OZVhZNWxmejZMZ3E0?=
 =?utf-8?B?dHNsOCs0RElzdVYrb0JybTJNWHU3Z0NXOUh1QW11YTdSdzFsTmh1UXdLbWN4?=
 =?utf-8?B?Y0VCWFhFaUlQclZUMnlCTTNuMitxWVZMSE9BaWxSZm16SGYvb2pBRmh6am9V?=
 =?utf-8?B?RDRISE10bkJMZ05SankrM2Y1K00xOUw2VXRKZm16M3dNUk0rUnA0anBnOXR5?=
 =?utf-8?B?ZVVFMldjR2gyaFN3KzZFaDZUTzJNK3VXODNrMzVlSERJbmQrVFZMOFFnOGxX?=
 =?utf-8?B?ZjlMQU8zbVBtK1VGVW9VK3hRUUVTdGFOVjFGVEJaR09MVHdTaUtmaUdjdkFt?=
 =?utf-8?B?dXpHY2wvSFp0bldaTFZTNCtCTGZwNEFPYlNHeUJHMzgxSnd3cWNrUERnRXBU?=
 =?utf-8?B?NHlvS01hOTE4ZjYwb1lYdURqQ0xxRXpVRjZYd0FKNlpuM1k4WmEyQUJkZVRY?=
 =?utf-8?B?SWp1ZS8zWlI5ckVlbXBpS0ZyK0NiR0NTZUc0eDRTMFBGaitvTlI3L0MwcmFN?=
 =?utf-8?B?c2hpYzAwNXNDa0xGUjJJUGo0UU8vRlZxaVdiSTgrcjYzZnpNRFZ0amZGZDFT?=
 =?utf-8?B?ekRXN3dnSzk2eWp2S2t4S1NoekN3TEdqeTRzdEMzcVNlRk5DSWpRcGV4aEZp?=
 =?utf-8?B?Y3hWcmpPUEU3SkFueGU5OU1JRWxTcUh1aHJZa205aEVxSnduSXpvS2Z6bURl?=
 =?utf-8?B?SzNnaHk0ZDR5WjlhS1lJOXFCTGFLOVp3VmlNYkJhendiQXBjZEM1RXZUZVYw?=
 =?utf-8?B?cXlGUnFZRm1pRnhGNm51U1o2Z09MM1lyRGJNVWxranczdnpLREJFNm14QnNW?=
 =?utf-8?B?a05BdnpsVlUwV0RybHFRM0Fod2wzMkFYeG5OdWFobDFsdmtpTG9SamVyUSt5?=
 =?utf-8?B?TXVxZFdDOE8rekJGMkxHRHFrZ2FDNHpPa0p0UmFyc3FZWWdPbXM0WStCdkda?=
 =?utf-8?B?RjAxZ0kwOTlXTWtvQ1N2UzcrdDFDekNkVDQ3NEtxWUJQQThUcEd5eitBc2dp?=
 =?utf-8?B?S002ZUYzZkpvYmZqUU5ORmtqQTVESVpCbVRFSExFNjlGQlE0QTAybTRxUi9x?=
 =?utf-8?B?RWF4dXFsc2RWZjBCTzJvaXBVWUFVZmt3QXNKdEh5aFVDM2pNSXYxNmFFV0kx?=
 =?utf-8?B?bHBJOE1Tc3ZlZDVWeUgxWk1mb1ZCY3lkb2xxSkp1RjBXZUF6SEtrSGQ2RThi?=
 =?utf-8?B?Sjc0VTZTZml1bGlXOFRWUkVTLzhVNWJUTnBOZ1JZbTVESktzVFdwbHBlN3Vx?=
 =?utf-8?B?VHNxaGtycmxLb1BzUE9qcDdrMzlTOG5HQTlMZDUydzEzbStmZTBja2J2V0hx?=
 =?utf-8?B?RkhoYXNwaDU5MUN0S3JOTHlXUm52OFEzVFFHb2pTRE9yUjdyRmdjSmVEN0E4?=
 =?utf-8?B?QWdJbWczM2RwRjNDa002TzlHbW5EeW40YUIxT09GR0MyT2pVN2JaSGdBQ2Jz?=
 =?utf-8?Q?VX20=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16ee503-d4f9-43b5-f39e-08dd626b89d2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 20:13:37.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCwuRtJsUytWv66MtdbbhC0kuBYgIr4fKXQf3mfU+DRA64Xh9uh+s8/6sWYKYn7X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7072

Hi Reinette,

On 3/13/25 11:08, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/12/25 11:14 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 3/12/25 12:14, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 3/12/25 9:03 AM, Moger, Babu wrote:
>>>> Hi Reinette,
>>>>
>>>> On 3/12/25 10:07, Reinette Chatre wrote:
>>>>> Hi Babu,
>>>>>
..

>>>>>> We can add the mkdir support later. That way we can provide basic ABMC
>>>>>> support without too much code complexity with mkdir support.
>>>>>
>>>>> This is not clear to me how you envision the "first phase". Is it what you
>>>>> proposed above, for example:
>>>>>       #echo "LclFill, LclNTWr, RmtFill" >
>>>>>          /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>>
>>>>> In above the counter configuration name is a file. 
>>>>
>>>> Yes. That is correct.
>>>>
>>>> There will be two configuration files by default when resctrl is mounted
>>>> when ABMC is enabled.
>>>> /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_total_bytes
>>>> /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>
>>>>>
>>>>> How could mkdir support be added to this later if there are already files present?
>>>>
>>>> We already have these directories when resctrl is mounted.
>>>> /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_total_bytes
>>>> /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_local_bytes
>>>> /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_total_bytes
>>>> /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_local_bytes
>>>>
>>>> We dont need "mkdir" support for default  configurations.
>>>
>>> I was referring to the "mkdir" support for additional configurations that
>>> I understood you are thinking about adding later. For example,
>>> (copied from Peter's message
>>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/):
>>>
>>>
>>>  # mkdir info/L3_MON/counter_configs/mbm_local_bytes
>>>  # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>  # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>  # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>  # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>> LclFill
>>> LclNTWr
>>> LclSlowFill
>>>
>>> Any "later" work needs to be backward compatible with the first phase.
>>
>> Actually, we dont need extra file "event_filter".
>> This was discussed here.
>> https://lore.kernel.org/lkml/CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com/
> 
> I undestand from that exchange that it is possible to read/write from
> an *existing* kernfs file but it is not obvious to me how that file is
> planned to be created.

My bad.. I misspoke here. We need "event_filter" file under each
configuration.


> 
> My understanding of the motivation behind support for "mkdir" is to enable
> user space to create custom counter configurations.
> 

That is correct.

> I understand that ABMC support aims to start with existing mbm_total_bytes/mbm_local_bytes
> configurations but I believe the consensus is that custom configurations need
> to be supported in the future.
> If resctrl starts with support where counter configuration as
> managed with a *file*, for example:
> /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_total_bytes
> how will user space create future custom configurations?
> As I understand that is only possible with mkdir.
> 
>>
>> # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes
>> # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes
>> # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes
>> # cat info/L3_MON/counter_configs/mbm_local_bytes
>>  LclFill
>>  LclNTWr
>>  LclSlowFill
>>
>> In the future, we can add mkdir support.
>>
>> # mkdir info/L3_MON/counter_configs/mbm_read_only
> 
> This is exactly my concern. resctrl should not start with a user space where
> a counter configuration is a file (mbm_local_bytes/mbm_total_bytes) and then
> switch user space interface to have counter configuration be done with
> directories.
> 
>> # echo LclFill > info/L3_MON/counter_configs/mbm_read_only
>> # cat info/L3_MON/counter_configs/mbm_read_only
>>   LclFill
> 
> ... wait ... user space writes to the directory?
> 

My bad. This is wrong. Let me rewrite the steps below.

> 
> 
>>
>> #echo mbm_read_only > test/mon_data/mon_L3_00/assign_exclusive
>>
>> Which would result in the creation of test/mon_data/mon_L3_*/mbm_read_only
>>
>> So, there is not breakage of backword compatibility.
> 
> The way I understand it I am seeing many incompatibilities. Perhaps I am missing
> something. Could you please provide detailed steps of how first phase and
> second phase would look?

No. You didn't miss anything. I misspoke on few steps.

Here are the steps. Just copying steps from Peters proposal.
https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/


1. Mount the resctrl
   mount -t resctrl resctrl /sys/fs/resctrl

2. When ABMC is supported two default configurations will be created.

  a. info/L3_MON/counter_configs/mbm_total_bytes/event_filter
  b. info/L3_MON/counter_configs/mbm_local_bytes/event_filter

  These files will be populated with default total and local events
  # cat info/L3_MON/counter_configs/mbm_total_bytes/event_filter
    VictimBW
    RmtSlowFill
    RmtNTWr
    RmtFill
    LclFill
    LclNTWr
    LclSlowFill

  # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
   LclFill,
   LclNTWr
   LclSlowFill

3. Users will have options to update the event configuration.
   echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter

4. As usual the events can be read from the mon_data directories.
   #mkdir /sys/fs/resctrl/test
   #cd   /sys/fs/resctr/test
   #cat  test/mon_data/mon_data/mon_L3_00/mbm_tota_bytes
   101010
   #cat   test/mon_data/mon_data/mon_L3_00/mbm_local_bytes
   32323

5. There will be 3 files created in each group's mon_data directory when
ABMC is supported.

   a. test/mon_data/mon_L3_00/assign_exclusive
   b. test/mon_data/mon_L3_00/assign_shared
   c. test/mon_data/mon_L3_00/unassign


6. Events can be assigned/unassigned by these commands

 # echo mbm_total_bytes > test/mon_data/mon_L3_00/assign_exclusive
 # echo mbm_local_bytes > test/mon_data/mon_L3_01/assign_exclusive
 # echo mbm_local_bytes > test/mon_data/mon_L3_01/unassign


Note:
I feel 3 files are excessive here. We can probably achieve everything in
just one file.

Not sure about mbm_assign_control interface as there are concerns with
group listing holding the lock for long.

-----------------------------------------------------------------------
Second phase, we can add support for "mkdir"

1. mkdir info/L3_MON/counter_configs/mbm_read_only

2. mkdir option will create "event_filter" file.
   info/L3_MON/counter_configs/mbm_read_only/event_filter

3. Users can modify event configuration.
   echo LclFill > info/L3_MON/counter_configs/mbm_read_only/event_filter

4. Users can assign the events

  echo mbm_read_only > test/mon_data/mon_L3_00/assign_exclusive

5. Events can be read in

   test/mon_data/mon_data/mon_L3_00/mbm_read_only

-- 
Thanks
Babu Moger

