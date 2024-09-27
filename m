Return-Path: <linux-kernel+bounces-341969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC12988905
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00EA1F21D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AFE18BBA5;
	Fri, 27 Sep 2024 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="czfS56VD"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E0142621;
	Fri, 27 Sep 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454155; cv=fail; b=U20on0KNnBhPbNn6f+gbL+Slwu0VwImXr7L3pbXvJzOgfCSMdcb2JZGzBuhgxM84WudaKdUsNcbx0+dJbg6EYYjznL1O/e2RJ54yqHb+XouPOduxOS2eZl3sdHVGSRRlA/rfbyQ4DPC0BNg+IcYOqkEewxfe0ar0QIURjwec9YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454155; c=relaxed/simple;
	bh=M3Gc+PJohBoQw2w3o3NRXOps4VUEAoriQErMDfBqasQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FAKsgODKi5dX3REGjhfrmkTHHZgy2QfauCZha5KZrP0+q8hTeTVp+XFkp5zCs9R1m3lZ12sNWAVNfDXTDg06rvvfDcVRam8f24EitPqeI55XBABiRx1lnswXqCK+13/vmYumgXYxevCUyUkk0eSnCb9vpI8iagFRQfVbc2Iwebs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=czfS56VD; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFLSPZ8xloUnY6bb6WocyPlV2rFW6T+IrIzwNmsSv2gr3pSWUkpaAGvtiG6FS87+QBBEvU4PAQHPBRK68Mb0YF01XlHzLskTg8LZMtoYcZ+xwJ+QNKIqeIRNXDIGL5MAKoyOWgzT7OcFYlKQDpBO2ObmONNr4Fr1kxKVpmtAiwQGK4ha98CWPvhkv//f/AKVUWDHQT6xxUugg0H0XZGgyuk07pdDCYXLlDTUodaARggQ48BMFLOENDEqMjP1UdZNRwK7sIP4uZDbcX3ULEpRy6m3GD4MApAgcFIMHdRELD5d1TEjWzFmJRKtTEpt+e615u66u2L8qvrwz6h6TswWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANC2jN04DRM7sOs5PYsQH2A/VRiYk8Qn5Me7+z/yVdY=;
 b=k4UxACe6fkJsxFY6QggDr+PkbLpzJQ+SX4Mhx2w3Oun5gVic+TEK06XwIlFzw5hDGBrCb+eT9HLrCUCRjiePum0CRwTX08TcM9uK2kTRBY7r6j7vCgCYriTFoWm+dk8tN+D6Iy9t5wLek630oiH2B7+9xhwtK1om3+vQj8pAWvbjpNKJuKMikXtXSzU7pl/t6uqLfsaBFmPl3bLbpvVzXtJwAuFLQbERLU8fK6fqtuADAnDpiNAPf1sJfa+0/Evr962Gbm36k58uIu5FiULPjdkgLwMr8Nwkq+JobLtFgDIqfxdnk6WJEbVr0nuZoj/1ixtL8sZb8mWaHo1aK6FIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANC2jN04DRM7sOs5PYsQH2A/VRiYk8Qn5Me7+z/yVdY=;
 b=czfS56VD7G62Rt+B4QjVmNK2NPziWHIyVAJsrgHp+kWJlo0EpJDNpmHLg5/d18DH2qzzu5Z2R1wLpriICQTgLd5ZjWpomnlb6rleN/3dOkrKeyevM8Ho/02nOJKfFSu/T2DzkM6fgWGGTH1qcnYQjTsipkPzLwEvA9LjdVzkr0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DS0PR12MB8816.namprd12.prod.outlook.com (2603:10b6:8:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Fri, 27 Sep
 2024 16:22:29 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%5]) with mapi id 15.20.8005.024; Fri, 27 Sep 2024
 16:22:29 +0000
Message-ID: <f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com>
Date: Fri, 27 Sep 2024 11:22:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 22/24] x86/resctrl: Update assignments on event
 configuration changes
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
 <ff0cd2a73c78fdb7487632381b4aec642a0af5ef.1725488488.git.babu.moger@amd.com>
 <384c2074-0076-4686-bebd-ba3ac3c05188@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <384c2074-0076-4686-bebd-ba3ac3c05188@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DS0PR12MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 64950d35-c59b-496a-9928-08dcdf109528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlkyeEd1TjJ3Y3ViTyttemxqeFZydXlqQ0lJWkNTSFVDNlptM0ErZ2tGMktl?=
 =?utf-8?B?alFpMEc5VkppRXUySlg2SVZ0cVhMZG9uZE55Qmh1UFVRZzlON3NUbGx2M1RG?=
 =?utf-8?B?VGp0aS9aeEx2d0Y2ZzNCQVNESVJPVzFsVmxtUWIxRjNnVytySmNibVVabzBR?=
 =?utf-8?B?eVdtVGJpckVLcWtsZlpGOE1JNjdWL0p1c3A3dVIreVRtSFdnVmlSSnB5Qk1L?=
 =?utf-8?B?Z08yWlVuL3RJUXYxSGhwSWhSajNPS2gya3lnNXlRajN1bG9kaHhFMDR6dGth?=
 =?utf-8?B?WDJiajJBeFBINzBXUFB0WDJZcmpYV1BvTGxCMTZaMzhGekRld3E4bW5XNStM?=
 =?utf-8?B?cWtOSjlhcDh5b3BEUHZVMHVOZm52UVZYanFod0ZpR3lCd1FiZWxVazkrTkhO?=
 =?utf-8?B?VnV1RDRJM2Ftb3ZtUitzVmpmK1JYdzdtY3M3MzNBL1g2eHJ1RE8wakRxRmQv?=
 =?utf-8?B?a1Z2bklqSjBLWUpmOXphaThTb290VFVYbkxUVEsvaFZINTJRSjQ0dkNnSUJs?=
 =?utf-8?B?enNnY3hQYTBGMG1aMjJGQVE1eXYwd0dTbWxTbnBoL0diMWtqUURNSWt6eXlU?=
 =?utf-8?B?a3EvczB0NXNYYnJ5dTJOOTVCYU0vVHdydElnYS84RERVMFFSNlhKMmJMU21a?=
 =?utf-8?B?eEJMbVlxZjgxaXZ6MjRyNjVDc1diQjNWR1B5R1BSMHd5NEMvTng4b043azcy?=
 =?utf-8?B?eGFKWTJoY2VTU3h3RlFlK2hjMFZkOTh2V0pSSDg5eU5CMnNBUW9rb1lLMTJ0?=
 =?utf-8?B?MWV5S2FYUzJhYWFhYzNXdDlyM0RGbWZaTlVsN1J2bGFpL2Q5c3hYYmpkU04r?=
 =?utf-8?B?U2VlMTlGTFhQNEY4UFc0Y3dCV3JibmxmeGRiNWkwZGRIbXEzQ3JRWW1ndHRK?=
 =?utf-8?B?d1QybE9JcDdsNkhabnJsSUdUVEdGWGJORFBGNVlmR25laHRvemM3aGJFcFhP?=
 =?utf-8?B?bStpd256cm1kYVRXUm53RUJZWUZwMWJ2ZDZ3U2QvWXBuckVUNGpHVXR5bU5j?=
 =?utf-8?B?WU9JakNGR1ltTklMMkx1Nm9rQ1ZqYzJXbGNwbHJPZTZtdnlLK05wczNzbk44?=
 =?utf-8?B?blUrSjVsY2hoczRtYi9abjNrdUFXdGNtdituMjhkWWczRjl1YlJZbWttMXRw?=
 =?utf-8?B?T2R1VGRhMSt5cmNoc3pkWHN4b1lLNklzRjh5bTBWWGF1NGxJSVczMnMreGlG?=
 =?utf-8?B?ZzFFeHZJN0xVUkVLaGc1Qm0rdXFnOUIrQ3pmbGhmcFhpdStlUTZ1UStJVDRW?=
 =?utf-8?B?OU9kODhYZlF0VnU5blNVbFhIZExNdHZhYzdaRUMvN2JLUWFoYjNoNFhvOTla?=
 =?utf-8?B?WkZmczA4MmJSUWJCTXBTcHpPUXlWMDJBUUtwMzhNblAzbnlveUJHRXZaYlVM?=
 =?utf-8?B?em1oQ0llRHdpcGZTM0JraklYcjRHOXlCTFRVb1UwMC9wS05xcmhoMDBNN2J1?=
 =?utf-8?B?N3YyU3BJSUtycXIvd09janRrMlZKZHNKd0hhYjgzenNydEdDZHYydm92c3NR?=
 =?utf-8?B?SXVTQitzZ3RYaXlNenBrdHdaMjZBbzA3T1VvSENiZVRiNzZMOTV3VXA2aExF?=
 =?utf-8?B?SVI3eXRVZW1vNmpXN21mZ0ExL3lzV28xNnlVTHg4czh1WVBqNzVqakNoRzk0?=
 =?utf-8?B?TVFIRjl6UStHS3pMSGRXVDQ3aVJlZ2dLS3V6TmFSb25ZNENIcXltRHFQRVQ4?=
 =?utf-8?B?S2xub0NtQzF0RThYZ2lWcDV2MVdBL1FJRFJGQmphRngwLzNxbThaT2lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDRHR21TMWJjSEl2YVBYYjYvM3prUEYxbitXN3BKb2lPT25kRDlEK3l6eTIw?=
 =?utf-8?B?anp5TzRES0h4cHFDVnhZb3h0RUJoRWJydXVkbG92UzhKZklyZ0ZaMWRYRXFn?=
 =?utf-8?B?d0VlT2xBSE5yRE9VS0g1c2Zod0I5K0NRMFh2MVEwYzkxdU9nZllzWGFCOXo5?=
 =?utf-8?B?VDQyUGIzMGsvRUhDRkZ0ZjJIaFlkVGRCNEdjMFB4Z0tRZ2UvN3JRUW5VWXZm?=
 =?utf-8?B?M2tlOElZd2JaOGpqTXh3VE81cUtvMHJsMkRha2JwdUVCWEovRXpqZG1sSUtB?=
 =?utf-8?B?Q3MwTEhibTMzdjNlOWl0a2dvbnU4dEdkMTkwdjBHTFJodjB2ZDViYzRFNS9G?=
 =?utf-8?B?YlRwTE9ia1g4OStmUzdocHZsZy91MDJOR0lGR2swYnB6dzZnV0NkWG4yK2I4?=
 =?utf-8?B?OWZJZFJpMTVncWRVTGl6cHBUZmtSMll6dHdwNDR1dktTNzBPd2pJQUc3NnBt?=
 =?utf-8?B?UDQrQlJsNDhNVXVWWEdLN05pYzU1ZVp6K2FWVzIzbmorVng0dWlKUVRIWE1p?=
 =?utf-8?B?Qm0wc3RhbXgrYWc4ei9RUVZwVERML3RRcTRac1AzeUpocWpJQWV0SWcyU2RV?=
 =?utf-8?B?cExueEhZQkthdWdsT3ZGS3c2Y0hKTzVzOVRmYkYwN0RWTE5vNEZmMDBhQ1ly?=
 =?utf-8?B?ajR6MlZHNWdaZ2Y5YTNITnAyeUFLQ3hzS2QxWFBOcUU4Rkd1djRsYmlQaStL?=
 =?utf-8?B?bFZ4djhISzdrY2FNRnFsb3JuSGJHVVp3eE5kZ0VxTUxqMTNtc1drZjI2VVdZ?=
 =?utf-8?B?V0NETGVEOGl6OXpKRFFzRmtmRjBDVis1Nkh4b2tVREpTaUxWTDRYcnd4bUkv?=
 =?utf-8?B?VXFvOG03Z2dQN2FmK280SUZsa1M4dnFaaHVmNVBNNGdwckN6bHBIaUdaWXF0?=
 =?utf-8?B?WG9WelVRK2FJcGFQNGUvNk9uWGFpSnYxN0FYWFZqWHVvR0QwM1k2eFRKQWlm?=
 =?utf-8?B?WEU4TmxoQlQ2UzMwbjZzcTNKdUExT0tOeWIveXhwYm1BcVBHTitoKzcwYjZp?=
 =?utf-8?B?T0w1NU9ZZEhYWWxPWWQzZlN2NG9OMUlqM1V2dC9tN254VHhrakJQL1kxSmZD?=
 =?utf-8?B?NHAwMUwzOW9zZVphbXBNTWovcVNzUXhldlBMMzhWeXZLdUI2RDduejFBUFIv?=
 =?utf-8?B?L21VZERiRXNjNWx3amJYRlMwWUNrOE1YZnBHUm9ManJVaG9XUEVXbk9CWG5D?=
 =?utf-8?B?YkhrSDJwbERORFpqMnk1dW9TSjBKTHdlTUs2UzVtNy9EQXpvRUY0Y2d2OUZF?=
 =?utf-8?B?TFBqQ3pSeTdwd3JxWDl1WVFqZkI4UnNURGxYRk4yU0h0YVkxRUd2bmpJeFhz?=
 =?utf-8?B?S0JrL3htalVqcTluMzkzS0NtUkREZWZCNjM5TkMydjdMaEJVYlM0WFcxWmZm?=
 =?utf-8?B?Z3Boazh6ZWVmU1ZSdEpoRTBSd01XMGJpRmhYOWpOSzczazVyMXFvYm5XVzdX?=
 =?utf-8?B?MkQ4MG5mbFQ1dEJDTXpnbEN2RXdqK1FNWDl5bDc4YktWTnFUa0c5aXZxRVYw?=
 =?utf-8?B?QURZUytUUDc3eEY0RGdtbUgxUFNRaUZoenQwV2p6ajVTR0VyS1lQY08ya3ox?=
 =?utf-8?B?MXhmdGRQV3BWZWQyUEZYaGk0c1FpZVR3M2JNdXROOHpidjdYZGtRdklsTFJS?=
 =?utf-8?B?TENvUkNBVlkwQXMrSTBJVEMrTnN1ek9MZnBrakZ0MUk5czZpejZiRUFOanAy?=
 =?utf-8?B?QitSaHZINGdVelhLWDFVaENvV25NRExBeHYyQzBSaFkyRkZ1WTluME1mOHVW?=
 =?utf-8?B?cWJaT0VWVitJbnhncnNWQS84YzZYS2FjeUwxR2lRRlN5Zi9BZ0hXM0tkQ0VY?=
 =?utf-8?B?TEpuMlNNTXdtaVpqMVRPZWNuN0FUTlRJQkdwVzlrNjBESmNZOEJBL1VWaGJl?=
 =?utf-8?B?dFlIVEtvekFHeFU0VFB5QjhMbTZkaXl6RUhWS094S0I3a3RDSXV5Q005VzBB?=
 =?utf-8?B?SU55dXBYVGFjODdCcEg4OHZIYiticzNYM1ZCZk9DNEljMGxWdEhOZnFaRTA1?=
 =?utf-8?B?Q1Y3RzltVEFvbW9RNys5b1VPMFBJMWhLUEswQ3E5TmtUMGhqdmVhV1ZFZmMw?=
 =?utf-8?B?dFZYcDBybGlIbG1TRkNUQXBnckVHcmJ3TDFPU3dNZ013dG5DY0tWblhlMW40?=
 =?utf-8?Q?cx/kXGw2ieTQo/U6Wi6sYQEo9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64950d35-c59b-496a-9928-08dcdf109528
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 16:22:29.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUg0XAOym7CGqZPC919j4zZu/QsIgbUw8pM6/nvCIjaZXBO5o8YuEiycEKrhJqWV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8816

Hi Reinitte,

On 9/19/2024 12:45 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> Users can modify the configuration of assignable events. Whenever the
>> event configuration is updated, MBM assignments must be revised across
>> all monitor groups within the impacted domains.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v7: New patch to update the assignments. Missed it earlier.
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 53 ++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 1054583bef9d..0b1490d71e77 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -871,6 +871,15 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>    */
>>   #define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
>>   
>> +static bool resctrl_mbm_event_assigned(struct rdtgroup *rdtg,
>> +				       struct rdt_mon_domain *d, u32 evtid)
>> +{
>> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
>> +	int cntr_id = rdtg->mon.cntr_id[index];
>> +
>> +	return  (cntr_id != MON_CNTR_UNSET && test_bit(cntr_id, d->mbm_cntr_map));
> 
> (Please check spaces and paren use.)

Sure.

> 
>> +}
>> +
>>   static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>>   					 struct seq_file *s, void *v)
>>   {
>> @@ -1793,12 +1802,48 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
>>   	return 0;
>>   }
>>   
>> +static int resctrl_mbm_event_update_assign(struct rdt_resource *r,
>> +					   struct rdt_mon_domain *d, u32 evtid)
>> +{
>> +	struct rdt_mon_domain *dom;
>> +	struct rdtgroup *rdtg;
>> +	int ret = 0;
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>> +		return ret;
>> +
>> +	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>> +		struct rdtgroup *crg;
>> +
>> +		list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>> +			if (d == dom && resctrl_mbm_event_assigned(rdtg, dom, evtid)) {
>> +				ret = rdtgroup_assign_cntr(r, rdtg, dom, evtid);
>> +				if (ret)
>> +					goto out_done;
>> +			}
>> +		}
>> +
>> +		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list, mon.crdtgrp_list) {
>> +			list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>> +				if (d == dom && resctrl_mbm_event_assigned(crg, dom, evtid)) {
>> +					ret = rdtgroup_assign_cntr(r, crg, dom, evtid);
>> +					if (ret)
>> +						goto out_done;
>> +				}
>> +			}
>> +		}
>> +	}
>> +
>> +out_done:
>> +	return ret;
>> +}
>>   
>>   static void mbm_config_write_domain(struct rdt_resource *r,
>>   				    struct rdt_mon_domain *d, u32 evtid, u32 val)
>>   {
>>   	struct mon_config_info mon_info = {0};
>>   	u32 config_val;
>> +	int ret;
>>   
>>   	/*
>>   	 * Check the current config value first. If both are the same then
>> @@ -1822,6 +1867,14 @@ static void mbm_config_write_domain(struct rdt_resource *r,
>>   			      resctrl_arch_event_config_set,
>>   			      &mon_info, 1);
>>   
>> +	/*
>> +	 * Counter assignments needs to be updated to match the event
>> +	 * configuration.
>> +	 */
>> +	ret = resctrl_mbm_event_update_assign(r, d, evtid);
>> +	if (ret)
>> +		rdt_last_cmd_puts("Assign failed, event will be Unavailable\n");
>> +
> 
> This does not look right. This function _just_ returned from an IPI on appropriate CPU and then
> starts flow to do _another_ IPI to run code that could have just been run during previous IPI.
> The whole flow to call rdgroup_assign_cntr() also seems like an obfuscated way to call resctrl_arch_assign_cntr()
> to just reconfigure the counter (not actually assign it).
> Could it perhaps call some resctrl fs code via single IPI that in turn calls the appropriate arch code to set the new
> mon event config and re-configures the counter?
> 

I think we can simplify this. We dont have to go thru all the rdtgroups 
to figure out if the counter is assigned or not.

I can move the code inside mon_config_write() after the call 
mbm_config_write_domain().

Using the domain bitmap we can figure out which of the counters are 
assigned in the domain. I can use the hardware help to update the 
assignment for each counter.  This has to be done via IPI.
Something like this.

static void rdtgroup_abmc_dom_cfg(void *info)
{
	union l3_qos_abmc_cfg *abmc_cfg = info;
         u32 val = abmc_cfg->bw_type;

         /* Get the counter configuration */
	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
	rdmsrl(MGR_IA32_L3_QOS_ABMC_DSC, *abmc_cfg);

         /* update the counter configuration */
         if (abmc_cfg->bw_type != val) {
             abmc_cfg->bw_type = val;
             abmc_cfg.split.cfg_en = 1;
             wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
         }
}


-- 
- Babu Moger

