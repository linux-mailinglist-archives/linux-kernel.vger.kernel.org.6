Return-Path: <linux-kernel+bounces-565433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2C7A66800
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879FD189BB9D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECEB190059;
	Tue, 18 Mar 2025 04:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DySP0SL2"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFAA4A07
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742270976; cv=fail; b=GfXaMTlDWrrG0Z7QXpObIoU2VC8uHc+5AFu+gJKqrkTIYHBX61CfolbUK0ljy6xousceWzTl3QXA+VHGuGl92KWhtHLgCAC/AYgNUpJXY0rso6rAZgE9cWgPoz5yWF8ru1FAEZZurrQFOTR56r5nsVikTA+8AA4LfKOLDazqCBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742270976; c=relaxed/simple;
	bh=a+KBYqB35QusGPazBI1pJfgWVzmXxcAXIh8CRbT8Yds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eRgYeYlI8xIxzL//HPxCVF2mezLLMIXl6+eQo+L2PeT4KmVdKKX4zgEzmPAU3mBNzdsApIAILzg4HD0rS5Pef7SrvesH3aQ08BvEIQev1LJ1iBhoJLd4iXaXy/p2ySlbrMytR+dPB5gxga+3hxaat8qn7kTeYc7UuNvTY6qaQcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DySP0SL2; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcslGTxE253QFPdP8aLs/Cq+F/Co0XKPvzWnj29veCs4dEc/SpkhVlC0ceFCd3dlejwBHI1aK0JFTQHcPwhrXUnxr8hkZq/fBupQ9zww2yWJWkrstEfbcajRmyBKpFY5GqPGnrqkYh4Co80gz/mjxWicSVjTSXJ0d0JdyDUv7iLNXZckv5+jq8f498q2U4Tgo1DuHdDGaQhfoAq4vJKZ3J8kdsu8ap7qa2VkIZ/Q4EOc68GEQ4VIl2/ZhhNCOtCJffaMwaZBCAqQ4/xHUig6qwEeTlAhYMoNRHJ8N9ZYy3OHajzfzQ0MTv24lXvk0zXWz0uIkE1wbDzQMiqWT4nS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3vDT9yDL6ND7UcsCpA6NHMsoEWSHiplrMSfV5wTxuY=;
 b=j2WWzMtpzQgHlSR1WqCHQ2w8gdsWr1zCZxkN52VqobquKUJg243uX1Zilm8T78Quuc+T9NmXvM457ATisz+CbFkpLT9or9p1qWBJo962j163otvolt6UcbW/DKD0h5JbRE3SuXQhuVLIVAq5m8a655ha3m21dhOnC6F3ul5qKbOnv2xKpqXCOVoqWZqz6DjkCRf9hYDPESwJdMtBWuXouHamZDESK7EcMeTZTWqeHBvFNSuyk+uz3+vudaFuAvGFlO+QoMa0rZPSlTdTrSakIDNwan/jGjU/STSI6wXGw6xP4HDSPr55e6+Vxdai5Y7epawRYYPOLQUzdBsammEPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3vDT9yDL6ND7UcsCpA6NHMsoEWSHiplrMSfV5wTxuY=;
 b=DySP0SL2cYcgxnD0ienz1O691Z8/oBEgvrvl7bB6sUIJlMAX64h/K5QCDp/5eyM6EYYej8Nwthz98vpvtsEYnd/Fg4DEW+qwsKJe+4UBAuxvrgcL1N0K3FmKltBEBgOxgu3ykGZltKC7a5JI5cSsXH1yUzfvPp8KZI8/9A0d1iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 04:09:31 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 04:09:31 +0000
Message-ID: <65bd664f-efcb-4bec-bf6f-218bc992e6de@amd.com>
Date: Tue, 18 Mar 2025 09:39:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com, Michael.Day@amd.com,
 akpm@linux-foundation.org, dave.hansen@intel.com, david@redhat.com,
 feng.tang@intel.com, gourry@gourry.net, hannes@cmpxchg.org,
 honggyu.kim@sk.com, hughd@google.com, jhubbard@nvidia.com,
 k.shutemov@gmail.com, kbusch@meta.com, kmanaouil.dev@gmail.com,
 leesuyeon0506@gmail.com, leillc@google.com, liam.howlett@oracle.com,
 mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
 nphamcs@gmail.com, peterz@infradead.org, raghavendra.kt@amd.com,
 riel@surriel.com, rientjes@google.com, rppt@kernel.org, shivankg@amd.com,
 shy828301@gmail.com, sj@kernel.org, vbabka@suse.cz, weixugc@google.com,
 willy@infradead.org, ying.huang@linux.alibaba.com, ziy@nvidia.com,
 dave@stgolabs.net, yuanchu@google.com, hyeonggon.yoo@sk.com
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-3-bharata@amd.com>
 <20250314152850.00003112@huawei.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <20250314152850.00003112@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::23) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: a31985fc-c17c-435b-193b-08dd65d2af2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0JPSWYzallFUkIrK1hKWno5djJPcENFRThJM2xCamlXOFVkbFc3d21WaUdS?=
 =?utf-8?B?ZmpSVzBIKy9HaFByVjA5TkFCOHJEK3g5RkVUMzVtSkF3UTJhNzFEYUFZdk5F?=
 =?utf-8?B?YjVmenBIWktCT2FoWm5lalRiY0FwUnZYN3ZIazZuTWova0xNcGFGM2kza3N0?=
 =?utf-8?B?WEp0blh6K3g4bUVaWnl2enNPNXlPcHNOaWFxQm00OTZrWlRHL2ZYSE9PUFVI?=
 =?utf-8?B?MXJmT2N3TFJmdmFrZ0laU1dodSszRWZrYmhiUjFoQzl4U1k2SW14NnFHVjB5?=
 =?utf-8?B?MkRUMkFXUTRoS3VLd2lKT0pXN3gwdTM2aCtRamVuYlBKYWJwb2ZXSVNRZkNU?=
 =?utf-8?B?cU10RE91R0tvOGlNTktDbDBScmFiaWtneTVQbmg1b3NVWkJBYkg4eVRhNzdM?=
 =?utf-8?B?N215bHhjNzcraW1QUnZ3azFqemF2b3kwNE90MTFpWGw5ZFlkeXA0cHRUOG1x?=
 =?utf-8?B?WDZoVEltU3BEMTVrVUpoZEMxUFpaR0dBOFZYdnpRNjNHd2RFVnF5bDB1d2ZB?=
 =?utf-8?B?ZDMyekRiU1hINFRlOXVQbHAxZm9ocFVsUCt5QlR6U25SQzRLQ0ZyejgxZit1?=
 =?utf-8?B?MnoyVWFMSHJiSlRLejNBWlVCdlFsR2RHV3haRDBEN2phcmd6WEd4NVJHczR5?=
 =?utf-8?B?MTVaUU9OMmJZSVlwRkRMbmdTRVJhTSs2SVQvb2Y5ZGM3ZkFiVTZLTktPUm5x?=
 =?utf-8?B?L1FydkZ1QjQ2Mm8rdXFva2tLUE5jTzhlQkozaEszQlVwWjJvMDU3ZXMyaE5K?=
 =?utf-8?B?NjdXTGdySWVaN25NOVhkNzRad2pleHhrUUt5cDBrQUlUK3pzekVTWEZoK0Fn?=
 =?utf-8?B?VEJ0OVBzWHRqK210KzgyVjFzZ3ZQTFFtaHBUalY3bENobGpScmxxbVhaM3hD?=
 =?utf-8?B?dFVGNE83Y095angrWC9mZjhTRmNsd1NCd1pLL0tmL1JuaVhLWHRxYWlPeFdp?=
 =?utf-8?B?WThpQWV1OEhKOGQ3ZVFyNno0d3E5c29oOEIwcTQ4L0dzQ2dMUmtEOEg5eFRY?=
 =?utf-8?B?S04ybFp6cHN3L2l6ZVpiU2dlL0pkQktSVXp3U2tyTkNLb1VaQXRzTVN0VFZW?=
 =?utf-8?B?R05JSTVBUjliSVFFQlQ0NWx1QThmVjNxY3pXZkptbVRjSjdZbkJRYkJsOTNU?=
 =?utf-8?B?dHJrUzdYcUlyejNtV2Vaby9YMllTakxGSGlHUDlZSjlHdWZYQTR2dXB4Z09J?=
 =?utf-8?B?L2cyekhsajIvY0ZpLzFHWTUwWk05SXRtSVMzZXFmNjdqa2pSSHJlZmhCcm84?=
 =?utf-8?B?Rnpkd1E1WHNnOGFuRGdrK1NCaGR4dzJrT1pVZXhuTG9mNjlvREpNYSt0NE9t?=
 =?utf-8?B?U1VPRDNhRU9ZaDZkeFp2REdaZnB2ejRxQzdhRVNhK21qMTBjVmJLWGZyZFpP?=
 =?utf-8?B?QklJOGc0U1ZFWmJxT2RNRWplNi9kRTN0YzEvYVVQMVlxeE5QRVB0azdsUktP?=
 =?utf-8?B?Nk9tcU90T1dMOERud3JrS1hWT3lPWHZMV3o3S1dVaWorOTVwMGo3RExTemVV?=
 =?utf-8?B?QVMzN2FwSFNZeWVRbHBUOC9jc2JuQWJGSWE2c3pUaGNoUGJJZ1hLaFNQN2lo?=
 =?utf-8?B?aGJ4b01aMGRiOGhTK3JSTy9lNnRiMmdmRW14TEVvOXlxUGtGN05FSW9Od3ZR?=
 =?utf-8?B?R253YlJmajhnQVppMFRnVzJWRktGdHFsb0hzd1dxdThSYUZuK2xEMVQ0QUVV?=
 =?utf-8?B?YUd4UGNSRTlnM2ZPcUFZZVQyT0ZEbHI3a1liY21iRXA3OW5nMlRyVlhaZVhj?=
 =?utf-8?B?a1kyR0tOcHg0NWxrMm5Jamg2M2pUVWU5WmNtb1hFNDRBOENIbVZTN202R295?=
 =?utf-8?B?ektURXpxU0RqRmRrcWZ2dGliM1lsSnIvRjZESlVZM1VlNXAzSnNhQWUrUTkz?=
 =?utf-8?Q?Ey6P/tdpk8kWJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alpLZ2VxYk5qT2tDVElUU2pzMTBxY3Vvb0lZRHd0cGlRS2Z1dEVyOVphRFVR?=
 =?utf-8?B?b2FvekR5Wm9jMnc3REl3dlB2NUJKdE1JdmdoU2dCUWhvVDVnVURtMkVUV3E0?=
 =?utf-8?B?RG5xME0raXlhVkJVMjA4aVM3bU1UMWhFdHFhN043WlZWRjNoOStNZmtLMmNh?=
 =?utf-8?B?OUtlSEc2cFpVdVFsMGtjNFhYWEYzU1IvSWFLUk5zbzNlM1VFSXBKeVdWcXcr?=
 =?utf-8?B?OGMvQXVnU01XWHJwV1l4VWtkS280bXFqdk5MWW5JRTQzUDkrOEt5SVRUbHdV?=
 =?utf-8?B?dkVOeUhjdG1lSjJrK3VpbnVXdE1DTWJvdkZCM2I3L1RBK1NwVmNsVDJrRWc1?=
 =?utf-8?B?U0V0WmhEK2F4Zzk0YkdFaDdjYVY3eHY5YUlrckM0ZVpZSS9rRHpwMHQ1Rldq?=
 =?utf-8?B?TzYrRmdpY1JMUG9Dd0F2cGZodzdaRDB6U1JhbkJENzFwRU9nZmJ3Zmd1d3cy?=
 =?utf-8?B?bStleG02bW91WkdUVkQzTE0vbFpsRmRnVlhkbklsc0haRk5oMStOVEwzM3E1?=
 =?utf-8?B?Z284T2xjZzM0T2VxakhVNVVmd1R3S0dPeU83WEEwaVE1ZUJpQU13Qng5MWhK?=
 =?utf-8?B?KzBYbVlkdUErRUV1ZmRQd3hvMSt1a2JDL1RqbzY2cmhHcHdvRUhtMVpkUlBP?=
 =?utf-8?B?N1BUZEdhZzRWV3RTOXJjZCsySEFMV2F0VDFnVDR6aWl6bHV6LzZuVi9KOXVL?=
 =?utf-8?B?MVBLZHhteUIxTlNOZUhaWjlSZHIxdWN4dnFHaUl4OXpCSGR4c2k2OVlZQVls?=
 =?utf-8?B?VEtSNVcrd1FkWnQ5MnpyWmRmTDhXenBzMHlWa3UweFFPZDVVZklwUXVzOHhm?=
 =?utf-8?B?U3BCVzZOdkNEajhIMHl6MTh2YXlNTmluNkFOL0RqNW5haEFOTWd2cVUzbUF6?=
 =?utf-8?B?TTdYcmgvMEMrVG1lZGx4Y2ZZLzFGWUtXVTFQVFVqVytWL3FJa0IyWVBKdEN4?=
 =?utf-8?B?WUppY215VTFhaHI0dGo4dTVJR3NHVlU4SllGeGlRZFlUMkhiR1ExeFlOUVNu?=
 =?utf-8?B?dmpZdTZlT3dhandEYUtFU2x3Z3E1a2VPTXZFRTZjelM1YTd3MFdCQmxqaTk0?=
 =?utf-8?B?ekRoeHFNMEdjT0k1QlBvem9LdklpQkhzSms4aDJHSkVRZFJ3R3FGMVFZcm5x?=
 =?utf-8?B?LzRCTllQUDdVZzE3b1RhQVZlWWxOaHoxOThzU05wQnh6eWdCVHBXMk5lRVpO?=
 =?utf-8?B?cXJjM3E1N3ZYNUtESlc3bGVlTlRpQkJ0M2pxNm01bXU4Wi9Ud2d3a0w0ZWd4?=
 =?utf-8?B?QTRiQjRnZXQxdmNVMVFmYmN1MHYrU0EzVko4TEI4cGJGRFFHZnpQODkyQjlN?=
 =?utf-8?B?N2FrWmhGOExsTjhycSt1cEV0SXU3RHQzVGRBTCtISnh5MFp6cWhKVWgzd0h1?=
 =?utf-8?B?QXlnWHFtRkJYai81VURoNEhHdlVQU3RHdnU1SHNXQW1Pc2tvREhFYjVFMDBW?=
 =?utf-8?B?QnB6RERBR0JjVStia1F2NWVYekdrSWVKdlJkUFA5Nm5UZVN6Y2F3NkVzbk50?=
 =?utf-8?B?QmxPTXdNbGc0SU1zbEg4ZE9nMlJuVDB1N2F0aFo0a2ptazUwRjFFR1FEZ2xR?=
 =?utf-8?B?T1ZobHlKUHc0blpPamwvUjlXL3hGU2tZaEdKSFZZMVJuRG1oRldudS93RjdG?=
 =?utf-8?B?MVVVR2ZxSlVodVhvZ0FNRDhPMWdOd1VKbmNpYmhQNmlia2F1MWpaS25DYWJy?=
 =?utf-8?B?VmZLa2dWUzBPWWtnQWE0c09qU0hHTHlDUUtxRi9UaTI3UHR6TjE3QmNGU0lW?=
 =?utf-8?B?VjFzOGtKbVpyRFgzZGxGaWtDZlcwbklBVE8zekRVOExKL0R1Ym9FVGEzblQ5?=
 =?utf-8?B?RUliVmN5V25ZODIrdTYzOThQbDhiZHo1RHo2eW15OGV4N2poU0RMeGFyU2hy?=
 =?utf-8?B?WksrYWxqdDBXNTBUKzdUVklSd25xVmU1RU03RUw1aFlBTnUrNzdwODd1RWxo?=
 =?utf-8?B?Vng2VkNZSUlTUkVTOXFEUkYvb3R6V3p4WW9IWFRSbWVyV1k2a21SZXlybVRp?=
 =?utf-8?B?THFMNmhMVDJkc0xrYlBXanIxRnpRbndOVlNnRkl4OVlPb3RIV1JCRjJ1OWhh?=
 =?utf-8?B?eE0wbEhGTUhMbEJsMkFOS1ExWEJzTkJVaGlqSCt1a3ZVTXlTeUpLMmVXRHI2?=
 =?utf-8?Q?LWt1iNgBfVaP59MIKpZKMkNpv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31985fc-c17c-435b-193b-08dd65d2af2d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 04:09:31.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2PKvyckxcYPC8hZFftxeDAZmt3waUhLiwyY4YK7g+PmUf3wVmlYWI8DDacGmlSBMotQ4kbZFt3vwbcIiu7Ofg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460

On 14-Mar-25 8:58 PM, Jonathan Cameron wrote:
> On Thu, 6 Mar 2025 11:15:30 +0530
> Bharata B Rao <bharata@amd.com> wrote:
> 
>> Subsystems that generate hot page access info can report that
>> to kpromoted via this API:
>>
>> int kpromoted_record_access(u64 pfn, int nid, int src,
>> 			    unsigned long time)
> 
> This perhaps works as an interface for aggregating methods
> that produce per access events.  Any hardware counter solution
> is going to give you data that is closer to what you used for
> the promotion decision.

Right.

> 
> We might need to aggregate at different levels.  So access
> counting promotes to a hot list and we can inject other events
> at that level.  The data I have from the CXL HMU is typically
> after an epoch (period of time) these N pages were accessed more
> than M times.  I can sort of map that to the internal storage
> you have.

Even for IBS source, I am aggregating data in per-cpu buffers before 
presenting them one by one to kpromoted. Guess CXL HMU aggregated data 
could be presented in a similar manner.

> 
> Would be good to evaluate approximate trackers on top of access
> counts. I've no idea if sketches or similar would be efficient
> enough (they have a bit of a write amplification problem) but
> they may give good answers with much lower storage cost at the
> risk of occasionally saying something is hot when it's not.

Could me point me to some information about sketches??

> 
>>
>> @pfn: The PFN of the memory accessed
>> @nid: The accessing NUMA node ID
>> @src: The temperature source (subsystem) that generated the
>>        access info
>> @time: The access time in jiffies
>>
>> Some temperature sources may not provide the nid from which
>> the page was accessed. This is true for sources that use
>> page table scanning for PTE Accessed bit. Currently the toptier
>> node to which such pages should be promoted to is hard coded.
> 
> For those cases (CXL HMU included) maybe we need to
> consider how to fill in missing node info with at least a vague chance
> of getting a reasonable target for migration.  We can always fall
> back to random top tier node, or nearest one to where we are coming
> from (on basis we maybe landed in this node based on a fallback
> list when the top tier was under memory pressure).

Yes. For A-bit scanners, Raghu has devised a scheme to obtain the best 
possible list of target nodes for promotion. He should be sharing more 
about it soon.

> 
>  From an interface point of view is that a problem for this layer,
> or for the underlying tracking mechanism? (maybe with some helpers)

It is not a problem from this interface point of view as this interface 
expects a nid(or default value) and would use that for promotion. It is 
up to the underlying tracking mechanism to provide the most appropriate 
target nid.

> Also, see later discussion of consistency of hotness tracking and
> that the best solution for that differs from that to get
> potential targets.  The answer to Is this page consistently hot?" can be
> approximated with "Was this page once hot and is it not now cold?"
> 
> Access time is something some measurement techniques will only
> give you wrt to a measurement was in a window (potentially a long
> one if you are looking for consistent hotness over minutes).
> 
>>
>> Also, the access time provided some sources may at best be
>> considered approximate. This is especially true for hot pages
>> detected by PTE A bit scanning.
>>
>> kpromoted currently maintains the hot PFN records in hash lists
>> hashed by PFN value. Each record stores the following info:
>>
>> struct page_hotness_info {
>> 	unsigned long pfn;
>>
>> 	/* Time when this record was updated last */
>> 	unsigned long last_update;
>>
>> 	/*
>> 	 * Number of times this page was accessed in the
>> 	 * current window
> I'd express here how that window was defined (I read on
> to answer the question I had here at first!)

Currently the number of accesses that occur within an observation window 
of 5s are considered for hotness calculation and access count is reset 
when the window elapses. This needs to factor in history etc.

> 
>> 	 */
>> 	int frequency;
>>
>> 	/* Most recent access time */
>> 	unsigned long recency;
> 
> Put next to the last_update so all the times are together

Sure.

> 
>>
>> 	/* Most recent access from this node */
>> 	int hot_node;
> 
> Probably want to relax the most recent part.  I'd guess
> the ideal here would be if this is the node accessing it the most
> 'recently'.

You mean the node that did most number of accesses in the given 
observation window and not necessarily the last (or most recent) 
accessed node.

> 
>>
>> 	struct hlist_node hnode;
>> };
>>
>> The way in which a page is categorized as hot enough to be
>> promoted is pretty primitive now.
> 
> That bit is very hard even if we solve everything else and heavily dependent
> on workload access pattern stability and migration impact.  Maybe for
> 'very hot' pages a fairly short consistency of hotness period is
> good enough, but it gets much messier if we care about warm pages.
> I guess we solve the 'very hot' first though and maybe avoid the phase
> transition from an application starting to when it is at steady state
> by considering a wait time for any new userspace process before we
> consider moving anything?
> 
> Also worth noting that the mechanism that makes sense to check if a
> detected hot page is 'stable hot' might use entirely different tracking
> approach to that used to find it as a candidate.
> 
> Whether that requires passing data between hotness trackers is an
> interesting question, or whether there is a natural ordering to trackers.

I was envisioning that different hotness trackers would reinforce the 
page hotness by reporting the same to kpromoted and there would be no 
need to again pass data between hotness trackers.

> 
> 
> 
>> diff --git a/mm/kpromoted.c b/mm/kpromoted.c
>> new file mode 100644
>> index 000000000000..2a8b8495b6b3
>> --- /dev/null
>> +++ b/mm/kpromoted.c
> 
>> +static int page_should_be_promoted(struct page_hotness_info *phi)
>> +{
>> +	struct page *page = pfn_to_online_page(phi->pfn);
>> +	unsigned long now = jiffies;
>> +	struct folio *folio;
>> +
>> +	if (!page || is_zone_device_page(page))
>> +		return false;
>> +
>> +	folio = page_folio(page);
>> +	if (!folio_test_lru(folio)) {
>> +		count_vm_event(KPROMOTED_MIG_NON_LRU);
>> +		return false;
>> +	}
>> +	if (folio_nid(folio) == phi->hot_node) {
>> +		count_vm_event(KPROMOTED_MIG_RIGHT_NODE);
>> +		return false;
>> +	}
>> +
>> +	/* If the page was hot a while ago, don't promote */
> 
> 	/* If the known record of hotness is old, don't promote */ ?
> 
> Otherwise this says don't move a page just because it was hot a long time
> back. Maybe it is still hot and we just don't have an update yet?

Agreed.

> 
>> +	if ((now - phi->last_update) > 2 * msecs_to_jiffies(KPROMOTED_FREQ_WINDOW)) {
>> +		count_vm_event(KPROMOTED_MIG_COLD_OLD);
>> +		return false;
>> +	}
>> +
>> +	/* If the page hasn't been accessed enough number of times, don't promote */
>> +	if (phi->frequency < KPRMOTED_FREQ_THRESHOLD) {
>> +		count_vm_event(KPROMOTED_MIG_COLD_NOT_ACCESSED);
>> +		return false;
>> +	}
>> +	return true;
>> +}
>> +
>> +/*
>> + * Go thro' page hotness information and migrate pages if required.
>> + *
>> + * Promoted pages are not longer tracked in the hot list.
>> + * Cold pages are pruned from the list as well.
> 
> When we say cold here why did we ever see them?

Those hot pages that couldn't be migrated for different reasons are no 
longer tracked by kpromoted and I called such pages as "cold". Guess not 
the right nomenclature to represent them.

> 
>> + *
>> + * TODO: Batching could be done
>> + */
>> +static void kpromoted_migrate(pg_data_t *pgdat)
>> +{
>> +	int nid = pgdat->node_id;
>> +	struct page_hotness_info *phi;
>> +	struct hlist_node *tmp;
>> +	int nr_bkts = HASH_SIZE(page_hotness_hash);
>> +	int bkt;
>> +
>> +	for (bkt = 0; bkt < nr_bkts; bkt++) {
>> +		mutex_lock(&page_hotness_lock[bkt]);
>> +		hlist_for_each_entry_safe(phi, tmp, &page_hotness_hash[bkt], hnode) {
>> +			if (phi->hot_node != nid)
>> +				continue;
>> +
>> +			if (page_should_be_promoted(phi)) {
>> +				count_vm_event(KPROMOTED_MIG_CANDIDATE);
>> +				if (!kpromote_page(phi)) {
>> +					count_vm_event(KPROMOTED_MIG_PROMOTED);
>> +					hlist_del_init(&phi->hnode);
>> +					kfree(phi);
>> +				}
>> +			} else {
>> +				/*
>> +				 * Not a suitable page or cold page, stop tracking it.
>> +				 * TODO: Identify cold pages and drive demotion?
> 
> Coldness tracking is really different from hotness as we need to track what we
> didn't see to get the really cold pages. Maybe there is some hint to be had
> from the exit of this tracker but I'd definitely not try to tackle both ends
> with one approach!

Okay.

> 
>> +				 */
>> +				count_vm_event(KPROMOTED_MIG_DROPPED);
>> +				hlist_del_init(&phi->hnode);
>> +				kfree(phi);
>> +			}
>> +		}
>> +		mutex_unlock(&page_hotness_lock[bkt]);
>> +	}
>> +}
> 
> 
>> +/*
>> + * Called by subsystems that generate page hotness/access information.
>> + *
>> + * Records the memory access info for futher action by kpromoted.
>> + */
>> +int kpromoted_record_access(u64 pfn, int nid, int src, unsigned long now)
>> +{
> 
>> +	bkt = hash_min(pfn, KPROMOTED_HASH_ORDER);
>> +	mutex_lock(&page_hotness_lock[bkt]);
>> +	phi = kpromoted_lookup(pfn, bkt, now);
>> +	if (!phi) {
>> +		ret = PTR_ERR(phi);
>> +		goto out;
>> +	}
>> +
>> +	if ((phi->last_update - now) > msecs_to_jiffies(KPROMOTED_FREQ_WINDOW)) {
>> +		/* New window */
>> +		phi->frequency = 1; /* TODO: Factor in the history */
>> +		phi->last_update = now;
>> +	} else {
>> +		phi->frequency++;
>> +	}
>> +	phi->recency = now;
>> +
>> +	/*
>> +	 * TODOs:
>> +	 * 1. Source nid is hard-coded for some temperature sources
> 
> Hard coded rather than unknown? I'm curious, what source has that issue?

I meant that source didn't provide a nid and hence kpromoted ended up 
promoting to a fixed (hard-coded for now) toptier node.

> 
>> +	 * 2. Take action if hot_node changes - may be a shared page?
>> +	 * 3. Maintain node info for every access within the window?
> 
> I guess some sort of saturating counter set might not be too bad.

Yes.

> 
>> +	 */
>> +	phi->hot_node = (nid == NUMA_NO_NODE) ? 1 : nid;
>> +	mutex_unlock(&page_hotness_lock[bkt]);
>> +out:
>> +	return 0;
> 
> why store ret and not return it?

Will fix.

Thanks for your review!

Regards,
Bharata.

