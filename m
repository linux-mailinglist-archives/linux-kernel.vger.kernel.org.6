Return-Path: <linux-kernel+bounces-272637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3466945F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1253C1C21843
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415E1E4875;
	Fri,  2 Aug 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CjzS1p+3"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D7A1E4855;
	Fri,  2 Aug 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608292; cv=fail; b=aCkCsIoC2ci1zE4iuYY9qTRTkEsw8crj0ZNX9t+bqwpzZbJHZdgJ5pN1JZ/3axWbqGmUbkQL9g6ha3n5NlMonzkEQYmlUsBiaoWwa08z9wEs1JHSMDHLQHjI1dgaqJ9ciG3ES7BKklZamlzuyfEdN7OYfN7RtxYMUr9Bd5JeoJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608292; c=relaxed/simple;
	bh=IsKLJs3LNHNJGR0PSdv6NzK18JRb6QX7cYROzkS2Qao=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fmaQwae1Sz/prNthGgmoD0suCCi2gvxQhz2xhVfq0reol2VKjtgmFIRfpCiNgmKaMfeT6wvNjsAd2TGh9KloWpp0UTi3HMcmNp9qbPnI746yDxFWxVo/nvn5tedbqu4Zv4j69ZCRng8qXZGMYmSt11jTzIxIjLjloQbirNe6Vfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CjzS1p+3; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOr/GjPuhAdia/+Q7I2nAMHAfumEZNdxMlZeprVl6LhZz6CRYguPXHIJuFqDWo3P1H3a41It9HxGcaAyQTK0YbUkP9rMvPXyCB+RBDpCy1krBFa3Q2mCrPNZkhwaf9nAKMf2G/FB1zhZZOwtRH20Qx4RO1NXJamN1EJmwFMyi6giiNCJRRza56pFVSfg0Jcm56D7Afb25JJ2jfzyKWPvFCiG6003fBUwT3UfXNg9kwUQtRW98eNQuOxQU5w5lD0OO4jFXAtRS6zQQPzQj1qUF7qRy096jZIAh98msR1ROmRACWElyawPmvWwW29q1tQGo9dl3E6UljEVaT+jKEL+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zssWc3zC4sYVwbs7XyXZfhpJ3SrQZHJATxxEMPc/vg8=;
 b=UilkTrXIK7SY1nMcZfjs3Ver43TX8XzXJG5Cm4p0MXm4WBBKQRwXWaCMlpAcjf9GOL62nmImqPSwES7qCWogW9oN0gkBAUb93EsQEPy2zivIdP8f7E3Q4e8qZUTWJwhkYLo3vgfOmf11OKEFiLC2iNTwNmsQyG+jEL1klwAqnKuptBXp9gMf9zEPSPjyHxBsaqj3pUVFnN8z+qQn3mr7ts9p5ivKUErGeXamxoPEuYu7vqwyvzDp81kJOrHMNznvKARgBzcC0Yw8jLgOnYeDF9Spq4iXVETnzPFd3Xn6rWiM83xBVgMdFvsoCB9z4djaWt+TexMg7jhfQAldzsGBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zssWc3zC4sYVwbs7XyXZfhpJ3SrQZHJATxxEMPc/vg8=;
 b=CjzS1p+3pMSiUVv771qGfxpr35YCrS5ovsgWaw7LIPI5OU3Ykaybt63YWccyqpbxIG/SB7TzrIRXLWoIDGOH8iA3kZt3ViZxkgMWshvjJVqqYC7asgXxTvXgCjZpAs+asKlqFFDwWIYg9yllIld3C2POeU9I1y/u7aWTnAJFVwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 14:18:06 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 14:18:06 +0000
Message-ID: <7517fca9-1cc6-edb0-cc50-61e8153ad8e9@amd.com>
Date: Fri, 2 Aug 2024 09:18:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
To: Pavan Kumar Paluri <papaluri@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Eric Van Tassell <Eric.VanTassell@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
 Brijesh Singh <brijesh.singh@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240801205638.6603-1-papaluri@amd.com>
 <20240801205638.6603-2-papaluri@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240801205638.6603-2-papaluri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::14) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: a94d5d20-4aa2-4277-5213-08dcb2fded91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHM3aGt3VHhla2laU2lVNmN2alBvRE51RkhxLzhxS2NieWtqRzY2UzFnQlVq?=
 =?utf-8?B?V0RLbG0rcnlTZzkySFlwdXRXWEJlYTI1ODJWaHBIZDZEUDlwSlVxQ05hUUdi?=
 =?utf-8?B?aTgyZHMvdkFOaEtuS2t4ZmlvdTg1andzcnlDRnNoU1U0TVBGWmgvbVFHZk9m?=
 =?utf-8?B?Y1IyZEIrU0syTTBLTnFOemM4NVpJeUxhRUpBc2pCK3FrbWRrWllBZngrWnY1?=
 =?utf-8?B?UnJHd24xeDF0K1NyRFNjUERPdWJ2QWZSQ2xHOCtoKzlyRkVaK1JybGRubjVK?=
 =?utf-8?B?dnNtSlRRR2NVOVhyc24xVTlrNHFxYzIzT21IZVhDUXU1Myt5U2hNUGVzZmVX?=
 =?utf-8?B?NTN3WnNWRG1kSkN0bzY2N2xSWXpOV2k4Y2x3a1ZEQ0M1cFhkQmFPWmEreHY4?=
 =?utf-8?B?cHdGeHc3d3hlR2hZK0M0TEM2WDBTdER1eVN3WEcwaG5hdXpxSFpSNGdSOU9T?=
 =?utf-8?B?dXVJdnhGOFltNDRaYmlPYWNDMktqSTdzVGpPRmZnVmxzRi9YMW5wQmx5cmFQ?=
 =?utf-8?B?MUFmK0hBTVFmc21NRDJEdFBzbWpUbk5Qb0lLT3hxT2J2YjU4eGwrNzB1NDdt?=
 =?utf-8?B?dkNEMjFWT0F5a1IwQ2NJbW9VUkVNVGh3cnV1bmJubTVsdDFrL2hxa0dBVllV?=
 =?utf-8?B?QlM2amg1ZXpoSkZYdWFsZ3B1czVwMWU3K3RFR0RlZFd0RHNIaU1QQ2dCWVow?=
 =?utf-8?B?M1BJelcyc0JSN0ozdFM0TjF5N29kQ1VyWVc4OXltMHpLY3pBeGhUNitaaFVG?=
 =?utf-8?B?a2phK3htS3VCcHBqaUdnUzNPUm9JcTFPbnlqWkN1WmRhUXFQaDNaTjhMbWdp?=
 =?utf-8?B?WTFFZ0lqV0tNdkhxWU9zUWhJMGxNK0tyaG1mTnc5TWx4bkRwcDdYWXk2RStF?=
 =?utf-8?B?K0x4VUpvYW1lT1hqOTdDa3dmMDNoSkFGYnV0eG5aTXlCZkpsNXdtT0xqd1Iy?=
 =?utf-8?B?Ly9UK0t5R2l3N2NZMytWNFFXZlg1LzZvYSs5MlN0WitYNXpGK2xibmRMVVpU?=
 =?utf-8?B?aE9oVDFyb3FzT0pqemlLR2RWcTkzOGdHTXozOURjZWl5NW93RFhmemxrMFl2?=
 =?utf-8?B?S250Q29GOFlxbEdPcHVHQjlMdklrYitSd1lkR1FjTGt3dUtlblAwK2o1VllF?=
 =?utf-8?B?bmI0SXpsMzE5cjhzZ2E1QUN1WjFVOGl5NXlPR0pBZGFmOWtpd3o3TzdhTVFT?=
 =?utf-8?B?NExUOHk2ZTFHa21UQmVWeFpoNndvcEVmcHVNSUhoK3AycHRlT1dhTmNpTFA1?=
 =?utf-8?B?R3VLQ3o5ZktJNUhNUnJodGx0Zm9FMzJoWm5VR0ROWTF2UjVlbHc4Q2ZIZ1BF?=
 =?utf-8?B?Z1drYmdQbk92ZEkvSHpEY3hyWk9Pek1GUko2U0FLemtVT2k3ZzAyc2VwY3pI?=
 =?utf-8?B?OUpQdEFQcHRWSWZ5dlVoS0s1VEY1UXdiNFpKcDlReElJb1F1eGphbjdUNU1S?=
 =?utf-8?B?NU5YSVlKVVZHVHJ2bU01ZWtaRW9FQWVySDR2NzdVS2U2V1ZEckZsM2JQL2gz?=
 =?utf-8?B?dzBna1ZaSDEwS0o3bEZLdHY3NWFJVlN6YjVOZ1dQOTVvU0JQN29XK1kva1RZ?=
 =?utf-8?B?MEtWcmp0dkNBSnVRL3dtTkhYcEZwRjhzT0kwOGZnQ3R2Um9UWDhsT2hOejZp?=
 =?utf-8?B?eVFVOFZDU1RhcHNGcEtYWnBnUlQ4anNwdTdUdytRMTVQNlFVMGFxYUw0SmpJ?=
 =?utf-8?B?RkVmRFJRc016Y2I2ekpXNmo5azlCU3Nad2orQXVLbWVvQndwN1FlUmtsNTdK?=
 =?utf-8?B?Y3ZYVytkV3BmK1Yvd0lBTDI5dEpEQUNZQ0xxdDZRc1hvWnlQRGRWQ1lXeWRp?=
 =?utf-8?B?Z01RNjZoaWVrcEQzZU1XUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym4rZjVKbDNueGRxSGFKY2FmN1RlVGkwcmNTaWJ6SFRhYS9JdW1oVHdKWDJ0?=
 =?utf-8?B?ZldxN1IzbGZNdmdzdGI0WUxJYmh5UUh4c2hRQlZ6REovWXU0c3YzSm9HUXVi?=
 =?utf-8?B?WW9SampHTTJ6clVqdjZ6b0tnQ1Y0QTBUSlVmUUlHcTE1QmdwU0YxanZKS2hH?=
 =?utf-8?B?Wm9WSUVVRGc2RSs2SU5nUlVhR1JYcFlZUTFVc3Y5ejliSWxjYzQwT3dIaWds?=
 =?utf-8?B?c3FqRmtnRVdramR3WU16RkprY0hDdlpNVUtCNWZkYlNkOHpGdDdXdDJ4aFBQ?=
 =?utf-8?B?ME1hNFV2NXVlcTlvQXpPcUFwMklTZXFmMkVDTXlEYVpjRXZyN0RkRVkvc3Qr?=
 =?utf-8?B?VE92OEpMMVVQbXJ1OEg0eWZ3bVpCTVJvclFDVFA2YlJ5R3hLbm5OUVdkbEtj?=
 =?utf-8?B?L0VyYXVRZ29FQ3paVmw4UVVsOGRlYmI2R2dXTVlEK1FrclZDZEJFV3d3N1By?=
 =?utf-8?B?YlQ5UnN4aHVtcUIwTW03SHdqN3hPWWVHV2hNR25LZjlzZU1RQ1F4Mzd1SHVU?=
 =?utf-8?B?SVc0endZZ3hWeW55STRjU0xZMzE5dUZ5YTJralArSWdpVWhPVnJsVi8xeEcv?=
 =?utf-8?B?Q0hpUHcrQlR0VnRIY2dLUVgvb1NlMjhKU1RObzFHWXNHbUJnZUFxdVhpbkhi?=
 =?utf-8?B?eWtsQjJSZW1lNE9SYU5keWNuQ0Zha1lnck52bVlQMHZsdUlFOGRzOFBlZXVr?=
 =?utf-8?B?OUJGU3ozM3FoQWJVcER6d3dCVXhGQktwM2VkTUx2a0g3NHVKTU5HVlBWMk9U?=
 =?utf-8?B?NWFhdjNSL09HRHhXcUpvYWZCN0dsMExDTUh4bDZaNnU3ektOOEQvaGM2UmtE?=
 =?utf-8?B?R0hhUHlQUGwzYWhHSGxxMVYzUVVYWEFncTRZSmhmbTlvRE11WjZhOU1xYU1Y?=
 =?utf-8?B?NTBQSE9qSUd2cmZaanpQeEhqVjA0Z1d6TStFaElUZXQ1MzhoY3ltOFIxdW14?=
 =?utf-8?B?d1A3Z242M0QzeGNyTFU0VGVDZW43c2gxNnY1dVgzSFNKQU1ua0Y1UjJlR0Uv?=
 =?utf-8?B?ejl2c1ZhWUtSVDg0aTQ4WmdIY3NsVHNJZi9rZm1LWjUrR3BQMnNVMjRGWWgz?=
 =?utf-8?B?Sy82VElzNWN4RnlvQ0t2Z3d6UHl0NmhxZzE3Q0pSaXF5NHd6azhXVjFCR1JB?=
 =?utf-8?B?MjkxdGRUZ3Z1am50WXBPK1NzbzhpbzZnbFdLSHU1eVJDbnEwa3k1RTdISHV2?=
 =?utf-8?B?OWNqYlNOS1ZxRXh6a3YvdVFxdExnSnJFVUFyWmFkTCttNmF0Y29EM3JuODNX?=
 =?utf-8?B?dHN2em90SHVhOFhRSnRCS2ZESzZsc2VRcmwxTmpMUUdIUjNaaUY2QmtOdktO?=
 =?utf-8?B?QVdEY1Y1bU1RaWhiTC9ocCtUY2R4dUJKY3VZNGdBSEx5bVNVNGxYSVVsTjZm?=
 =?utf-8?B?b1Y4MkNSL281VnlhalIybFNubm5GTG1mVGVPRkdXMVZpeHBhQXUvb0hIOUxo?=
 =?utf-8?B?MDl2d09jc0pUUnJnR3g3RlZZRFVXTTBXUWVISHc3VzkzZzVSMm1BY3h2OVdo?=
 =?utf-8?B?ZWZoZnRaVEcrdEp4Q0VkMGgwWHl3Q3M0UE5WQVZ5eVhxbi92a0pXWUFtbmF3?=
 =?utf-8?B?bE41dzdBNndWV2tpclNCd0UrbU42aTJKcHN4ZXd6VmZ0NldaN1NUZDUzZUdm?=
 =?utf-8?B?SkI2eDNRTWMraEg4Q0xEMUtML2VEcHdzRENNbkNLczI2UTBqOGZZTWswaDRT?=
 =?utf-8?B?ajljWS9HUkFSejczRXBCSFIvNUlGU0xTYXZMNVRRdVg1VzJjeUUybVd4aWFT?=
 =?utf-8?B?c0ZGNmh6eWdLVUFOcjVORDJWR090bDR0RWtjbmN5eUlSTjUxVk5nWGFSZ295?=
 =?utf-8?B?Y010alc1MHUvUXFscWxld05aeFB5VnBUd094dEh2WXdicGJneURyTWFvVS9D?=
 =?utf-8?B?UjloQ2dpUUEyQ3JGRmtFUk9tbHV2dVZ3S2dzVlhXWUVicDVEamUwOVVUZU10?=
 =?utf-8?B?TEo4OHVtRkpLVWVQWTRraFZkSlU2NlYwT0FtVmlFVStKcDVwNURUN0FNc3Ax?=
 =?utf-8?B?RG5ZbzFNcEdqRlo5azZPYTdQMitUM3kzSkhIN3lYTVRITmpkZkZkZldtOW92?=
 =?utf-8?B?bk1mY0RwUVNpSEh0eTQrYUFYZDNqWVVwVFBxK2g0QzRnYmh4WUh0L2d2MHd3?=
 =?utf-8?Q?7pX5aUjeFnbzcBgYX0yCw934s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94d5d20-4aa2-4277-5213-08dcb2fded91
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 14:18:06.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YR5A6be+xemValz1CGzpeyRWFHSRh1uOEWiAU0t1HIg/V0xllC6hLSk1UFUhrTKZT7up3vRysE+HuULwfsGw3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

On 8/1/24 15:56, Pavan Kumar Paluri wrote:
> Move SEV specific kernel command line option parsing support from
> arch/x86/coco/sev/core.c to arch/x86/virt/svm/cmdline.c so that both
> host and guest related SEV command line options can be supported.
> 
> No functional changes intended.
> 
> Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/coco/sev/core.c          | 44 -------------------------------
>  arch/x86/include/asm/sev-common.h | 27 +++++++++++++++++++
>  arch/x86/virt/svm/Makefile        |  1 +
>  arch/x86/virt/svm/cmdline.c       | 32 ++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 44 deletions(-)
>  create mode 100644 arch/x86/virt/svm/cmdline.c
> 

