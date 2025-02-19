Return-Path: <linux-kernel+bounces-522070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD2BA3C578
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912CD168306
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B581213E87;
	Wed, 19 Feb 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vmg/R5yk"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386EEEA6;
	Wed, 19 Feb 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984028; cv=fail; b=Czmf+yDvm8iDqbUwLD6NsqrIcNNDH7Gmwlv63d2VP/a4InrAdzabHvbPpoWVrVP8iZQO6jlvApplmbRLEc4kaKFoefgcc+tQfJUFO8IwNSgEcai4Vcwrj//9IKMPTs77ke1On+Fnle/ZMAe3+lAAuxnv8NOGYnfJLqmG8axSWEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984028; c=relaxed/simple;
	bh=nJu4W7tj8bTghcw56pZZuMeyb3xwOrGN5IpyS3bdxlU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U1i8E/gjR5NHwdzyHxw5J8Rm30SA+0vitc4JkoclRoDrTMh7k9h0qBP1bDgOzK8c59i3a76fy5tUfg4b8d/kDKbS+XcvhZUS904B8F0tGkHzD5Qx4/s+tz9vyzCk7h3b5AX0LLGkdM1RfieTYNaeDh1A/0sAvalT3Pw5mYLxwxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vmg/R5yk; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpF0+TLcyOv4v6OEfEc96tvmt2/8lsg4QcIs0QktNZn97dptBcSp+ay7dkR35Fds1XNaElTzaXIvvK3r4ZbtQRxnFkNvzjgi37SSMr327YDN7/1S2whA9O+mb9hIcfvUcacQCrYUD3wsomAkYPXA8XS4dFEfqQeSogVTn2URVyAILXpAdBJhiC1Nm8WmxW1h13pdK1i0NHgAWBrtIv0ILu747hP8UnMU7XeyWLnlwaEntQ8C29tm5Se52q+58VvoSgsU3ncAxTBjV1F5b3drv/gVSqV6r8p3f/REfh+Z/QHRT3MJd247tuMzQD/811KZw0O5Ha4UEBo2UtlwezYXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVW34MRzHJpu2Dg+z+BTnlKecCvpUn+LBH3aZTDw8Cw=;
 b=IG9lx9Mf0eEbfzbIejGs7DUa49HdMTwL2AYf9N8upvvCozGFTJyJdAxk9UTilRwoQczrUL4UYElg7lNa66P2mvgS/ZCisEl5v/yij6xJCEt6YGNEzbJnuSC47qVbJivPQgLtVdnMp5Jb9ngxxk/2pcJmOzf0gC1aqTsSEFrTTBdc0U6BTIJaj7k0Jp4y5ZRgP+AhDTBHmg8BuOMRfAWK0cwllWvrBGZECPafH5DRgrVCk8pVAlr+ZWMYKh/y9wx48syjaJrpHmP/ko/pMFErPfqjkPZc/zN9EBMvtvFkRsCIkORjrIHZjvDmRjgeuEApIfztHKBh0z9Vr97gAjRl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVW34MRzHJpu2Dg+z+BTnlKecCvpUn+LBH3aZTDw8Cw=;
 b=vmg/R5ykhVn/hRoGNobBG2fmqeTpB1AGcUhfq6aAo+jgGzPEOyM9UH1yh2NSURn20RpDk1wXMCFA9Ep9RU0oGRLOF0eYK1HfC1huj6q7eE4fBfhykLoWUbypRPeUalwcV+wve0af8yyN43a5TB1W+19alPkPG8cNNzMu/3XnwF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 16:53:43 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%2]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 16:53:43 +0000
Message-ID: <68cab18c-9a17-45a2-8374-86deccf2664b@amd.com>
Date: Wed, 19 Feb 2025 10:53:41 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 01/23] x86/resctrl: Add __init attribute to functions
 called from resctrl_late_init()
To: Dave Martin <Dave.Martin@arm.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 tony.luck@intel.com, peternewman@google.com, fenghua.yu@intel.com,
 x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, jpoimboe@kernel.org, perry.yuan@amd.com,
 sandipan.das@amd.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 seanjc@google.com, xin3.li@intel.com, andrew.cooper3@citrix.com,
 ebiggers@google.com, mario.limonciello@amd.com, james.morse@arm.com,
 tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
 eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <e946a96a5d161f7b32e84c23c1a0024a31db2898.1737577229.git.babu.moger@amd.com>
 <Z7Xccob9B2IMiAXy@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Z7Xccob9B2IMiAXy@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:805:66::34) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 4016ac8e-8e5e-4f6e-7036-08dd5105f7cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXFVcEdObThpYUo2ckxGZ3VXTk9nRjQ1UVFLSkgwVkh3eE1reXVGeHhIRnBK?=
 =?utf-8?B?bjQ5ZXYrdUgvZUgwVzJMT09CMmppaTJZdnBIa20zUXhRUWxpY3BuMVl4ODJw?=
 =?utf-8?B?bXBlNkxOeE5sdTlLeEIyemNLeThMQU5UQkZuNi9rY2pqNnh4bDNoZjdRNS9E?=
 =?utf-8?B?NFp2N0ZqVGJyRy96bzZsNXRveStPRitCV1FMWUpaUG5kWVF1VW5iY2dlOW5u?=
 =?utf-8?B?a2ZVSUNLNHY5cG5tajZLZUF3MGs5Rzc1eFFaSXZUd3psbWF1SWQ2cisvSjAz?=
 =?utf-8?B?dkhmNmoxYUpmR2hKT3o2YTk5NnJnNm5qVXRPaTdqZHcxWlJTMk1WUDNjSjRs?=
 =?utf-8?B?NnhnVkdwSnZhRDFxUkgxWmhoYnpVb0JueHFxdi9RTVVrUHhabVVPSUNBLzZa?=
 =?utf-8?B?d1RlWWwwK3ltNm1OUWw3UFlwZXlsUnBQTjA4VHlvWVYvajgzN0xPdHNpQ05M?=
 =?utf-8?B?eHpQdDJwNE5jWU0xVGxtVjNUN3VBY0FMeTFodm9vMkJwNXREbXU2MVpPK0p2?=
 =?utf-8?B?SkNNbTdwN2lEcUMwMFN3SUtTVFMxRXZRRklZNW9VQW5iVjhTK2xlMWZ0a0xp?=
 =?utf-8?B?czcvcWwwV28yV2paQW9UNHpzV2xNV1ptUnhaK0dGVUZmUFp6aGhKOEsrYk9u?=
 =?utf-8?B?azh6RDVEa3ZmSUVTM3ZHSHhoWk9MYVVJb2E2TXhQOFIzaFQwQzIwRWNoSXNW?=
 =?utf-8?B?bXFFbk82enM2eFZjdWVRUnRqYzFHWk53aUZzNHJGWlBiUTJ1MFBqVUo1RnFJ?=
 =?utf-8?B?UnAzSDlyWlVTcElFaTVZNEMvcS96QUhXSXhYMk16Wkh1OTY3OUhzRll4Wk93?=
 =?utf-8?B?d2h1T2JOak05ejhUTE1CUTRKZFhrVmVkdE1LeTZMK2I1OFY2U0RWYWhUTUt2?=
 =?utf-8?B?OFJXUjJLazRSQ042TkZBRFRpRUkrWDkvYnQ0a3JXT0x3bU5YMHd0R01xTks3?=
 =?utf-8?B?eHErQUtIbHYzTENic3hwYURxTXFkbE1zeUYzcEwxWldmTHp3TjFUdzlPTFU5?=
 =?utf-8?B?d1dvS3VkWEdYcEU2eGdJcTVRME1BVS82MXh2UkhUcGRaQTY2SzdFSmlGT2ND?=
 =?utf-8?B?WDNuRXIzNmVBQ0hMTFI2K1BuckxaU0R4NHRTMjJBS2RaR0hpVVhVaFRlVC9V?=
 =?utf-8?B?aTU2UDRqR1ExaEhTejlCOGhMNEZuejM0UUh4Y1ZBSE9aTEdNTkxnVHIwckNw?=
 =?utf-8?B?OWZ5RHF0dXcraytCV0hhVWlNbWNZTm5aUnMwa1N5clBSa0J5NUxOaDRhdlRw?=
 =?utf-8?B?N2FLKzJTWGxxeUN2SWJlSFh1QkZxbWw2ZjVUMEF1SzdIQmpBbHBNTjVRcFow?=
 =?utf-8?B?VGJCMlF6cUp6QmR3VFFjWlpsUmUybTVQd2l4TlFjWm83RzNqd1RvbllNRHIx?=
 =?utf-8?B?ZytSZFpOM1A5SGVIMVFlN25zS0tHK0ZmZ0xZNThWSExWaGFlRFRxK3JJOWZy?=
 =?utf-8?B?ZTFCNHMvL2JzZVc0NlplbDlmWXpGNFVGWlE3UlFXZDBKamxiOGpmQ1JFN3pz?=
 =?utf-8?B?SWkxRTNVWER0cUp5STgwaDM0MTJzTS92bzFYRFVZcE5TWVpoOENLbGh2L05M?=
 =?utf-8?B?bkhNV2RDVW11TFlPQzM1YzJWekFpU3ptZ29yazdPaGZoQmoxcG9qRTc0RUVr?=
 =?utf-8?B?blJtSWJOblZ0NFNGQzFaUlg3aTVjVUsxME1razJGMXluemNSdTZOdmQ4V1lV?=
 =?utf-8?B?aFd6K0hNMVhkcFg1RjVyajRrVGZ1blJFdDBsTnIxM05sak1Zd0FtSTg5YmFZ?=
 =?utf-8?B?RjZYdDhyRkU3U2JzbUVwTXRhVGFZSmQvVEtzUnY5U2JnNVlBUUV0SWI4cUto?=
 =?utf-8?B?a1B1SnlnRXMyU2lMRi8wNDNBb1J2ejJnVnc3OTRXdm5IRlZla3BqWEdqYVYw?=
 =?utf-8?Q?NXoP51KQqT0Sk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWJDTW04V3lmeGY4WHFUWDFHWWZDeVJGWFFWWkRGUStWOGdTK1JFK1Z4QTd0?=
 =?utf-8?B?WVo4VHprVEEzeWRJbk5ubndlUVRTbElMUnVEbW1nNTRVbTBObE9rek1ORHpw?=
 =?utf-8?B?YlpUOWh6N3dkRExQeERqaHV3bUlYMmlJSGxNZHltSmNFcnZhOWhYVVZqOEhn?=
 =?utf-8?B?bis3MUx2S1VyaTAwcFBDcUd1Y3REMVBqY3VNNm9yWjZvcW05M0NIaWVSRXFh?=
 =?utf-8?B?aDUzQmZkOWZtTE9OYnZTWkFjVG5zWkpud2lwaFFCWnJtZE5ySDVnTWNHc2ZQ?=
 =?utf-8?B?RUoyS2JpVmErMnNTQjJPYVRhN1VQclp3VWp4NDVha0dYM3FDWU1vYzJmTkdu?=
 =?utf-8?B?NDdTTGQrZGczdXZGdEJDcHV0bFVlZkJzRFZuWEdpdGFWT3lzUkJwTDNidmJ3?=
 =?utf-8?B?d2xEOU5MUXRGbUd0UFdWNVJxeW5pc1lxRzNVYlRBb0tIb2JaZ2UyVDBEVGM1?=
 =?utf-8?B?Z2JteWtpMHBPQ1R0RGZ4M3EwY1pxYTdoS2g2bHVEYy85K1J3MEVjNUhtcVBP?=
 =?utf-8?B?cWFFcUZRa1UwVVdLZlJDQXN6RUlWNllmU3plRks5Q2dRV0VxTFhZQk45Zm1t?=
 =?utf-8?B?Z3hBc3Btc096K2p2VE5vUUh2Zi9MdlN6UkU5bnp1em0wVEdra1Q0aXJyM2dm?=
 =?utf-8?B?Mnp6eVdYeFVqWG9ZaVBIZ3MwYUJ2QkVEV0ZmeERNbFVNSmJDUU9ndGFUMXNR?=
 =?utf-8?B?UWJCZGhkOUlDMmJXVitSVkhJcGNETWZTVGJQZ2VndGFHSi9iMFBkOElZS1NM?=
 =?utf-8?B?djVpQTBvTnlDd0ltSmJUV2pUTDZ5eE1iN1dmM0hqMS93TDcwTWtId2tTeXUw?=
 =?utf-8?B?WU5DN2lLN0hoWldFdjlKL3MveUN2Y2dJSktDVTdZaTZuQUpzMUt3TU5EOUhQ?=
 =?utf-8?B?RmJWNlVWemxmdTl3QU1sU054TVFqWjBQMjFpNTl0bmlCZXZMNjg2NzQ5ZE1H?=
 =?utf-8?B?Y0lzM3dXTGRBa3NMdC8xS0YxL1plOTk3Qmo4U3I1RWxWb3dkVldxZ0h3VUQ0?=
 =?utf-8?B?ZW1JdXgwdUNySVlWSjFvUG1FWXlaLzZ3cUhzSHNLbGE2WXNJa05TY09ZSEpq?=
 =?utf-8?B?SXBwU2Rxa3JnSUU1SmNsR0tHZ1NZdGNOTDRxTzZWbkV0SlNEM2dVayt2dU95?=
 =?utf-8?B?b2JBcEREaVdVang5VFdtei9kWkphd1lFTXd3OTVRV05NM0tRdm1FMW1lN1RY?=
 =?utf-8?B?RzgrRXFNc0FCSVhRdUJHVnNsY2hIU3hqaVIwa1ErYkxvTkFHaGJmYUxLckR4?=
 =?utf-8?B?UGRTRjBmcUMyUG81MGxRNnNPZjdTSmNRbE5iTWdyMml1bU9CSXJrdndhN2pm?=
 =?utf-8?B?TzJmWnNEYTYyZ1VZUDRoTFZGTFhLYzQ5eUtFVG4vSy95TzRTdGhsNzZkZmxn?=
 =?utf-8?B?THM0QnpWMWl0RGhhV1MwcG5TbU5QcHhFeDFBMW0zNjJWT1hiK054U1lxcFAy?=
 =?utf-8?B?dW0rRWpPSkhuZWszd0d6VWs2V05vR1h5ZlJWZTZRMGIzZDBBMFVoNVR5Tmps?=
 =?utf-8?B?eXFPeTN0N2c0OXdJcm0yTnl1NE5vZVBQU3RhWk5hVkgzcmpwekxOVVovQTd2?=
 =?utf-8?B?SGN1R2QvZVhjNTUzMFB4MmxOa0VCU1hsUGRvMyswaDdYQTQ4ellyRGVZbUdx?=
 =?utf-8?B?RSttMk9YWW9XSEFEbjJ0c0NnUmV3MVdwUXk3ZEVNVGx3bGdpU2QwL2ZsazhP?=
 =?utf-8?B?M3FxMFpQTDZmTGdZVUU3WUZJaXBTSmRLMnYyaldoNEV4THpVQXRWUlQ2VTBN?=
 =?utf-8?B?eWdjWVFtT01IYUc3NjM0NGplbUFGQWM2blhRK00xelZhRUhncFl4NFFyajk0?=
 =?utf-8?B?S1l2ZU1BYU95OU1MRyt4K0ZBRTNmRVpicG1QUDZKU0dXNUl0ME0yY2ZZNWx0?=
 =?utf-8?B?czcvWCthU2ZnUm5hUmpVTE9sR0VCbTZpZTNBakd0b1dHejFqOFIzT1IxWDVW?=
 =?utf-8?B?aDFnRnNyRVErSTIzVjhiRDIxaGgwK3dYRnBNbHlRNGs2QnI4N0hCTUlwV1Fo?=
 =?utf-8?B?WDJqSlk5MWg5dW5WVHRScVp3aDd4Um5Ta09OVlErZll5MVBrd01UeWpia2Zl?=
 =?utf-8?B?Z3cyTzFOcXEwdXVWL0NJczNreHJUczBObXlGRVROK3pmRDRhK0hscXVlRnhZ?=
 =?utf-8?Q?o8yc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4016ac8e-8e5e-4f6e-7036-08dd5105f7cb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:53:43.2176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Qtk/K8WKdKLSgJmSHMqE0klgxGJj9J9+cKxW66dgR30X/hzJIocdm8nAjScMpbG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664

Hi Dave,

On 2/19/25 07:28, Dave Martin wrote:
> Hi,
> 
> On Wed, Jan 22, 2025 at 02:20:09PM -0600, Babu Moger wrote:
>> resctrl_late_init() has the __init attribute, but some of the functions
>> called from it do not have the __init attribute.
>>
>> Add the __init attribute to all the functions in the call sequences to
>> maintain consistency throughout.
> 
> (BTW, did you just find these cases by inspection, or were you getting
> build warnings?
> 
> Even with CONFIG_DEBUG_SECTION_MISMATCH=y, I struggle to get build
> warnings about section mismatches on inlined functions.  Even building
> with -fno-inline doesn't flag them all up (though I don't think this
> suppresses all inlining).
> 
> If you have a way of tracking these cases down automatically, I'd be
> interested to know so that I can apply it elsewhere.)

It is mostly by code inspection at this point.

You can refer to this commit [1].

We used to see section mismatch warnings when non-init functions call
__init functions.

MODPOST Module.symvers
WARNING: modpost: vmlinux: section mismatch in reference:
rdt_get_mon_l3_config+0x2b5 (section: .text) -> rdt_cpu_has (section:
.init.text)
WARNING: modpost: vmlinux: section mismatch in reference:
rdt_get_mon_l3_config+0x408 (section: .text) -> rdt_cpu_has (section:
.init.text)


1.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.14-rc3&id=bd334c86b5d70e5d1c6169991802e62c828d6f38

> 
> Cheers
> ---Dave
> 
> 
>>
>> Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
>> Fixes: def10853930a ("x86/intel_rdt: Add two new resources for L2 Code and Data Prioritization (CDP)")
>> Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()")
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> [...]
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 3d1735ed8d1f..f0a331287979 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -145,7 +145,7 @@ u32 resctrl_arch_system_num_rmid_idx(void)
>>   * is always 20 on hsw server parts. The minimum cache bitmask length
>>   * allowed for HSW server is always 2 bits. Hardcode all of them.
>>   */
>> -static inline void cache_alloc_hsw_probe(void)
>> +static inline __init void cache_alloc_hsw_probe(void)
>>  {
>>  	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
>>  	struct rdt_resource *r  = &hw_res->r_resctrl;
>> @@ -277,7 +277,7 @@ static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
> 
> [...]
> 

-- 
Thanks
Babu Moger

