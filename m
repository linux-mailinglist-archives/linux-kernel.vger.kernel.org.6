Return-Path: <linux-kernel+bounces-418751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1BB9D6514
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DF6282FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C7F186612;
	Fri, 22 Nov 2024 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CAOjEWQa"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0DB4A0C;
	Fri, 22 Nov 2024 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309478; cv=fail; b=FsRQaqzG5qwBBO5rcaANOYFHq5McOv/1DApJpKz0nOae0trysTqXzratdM51p9Oi112o+Kppi4+EJ1Pow6hR5cJ95hgNhFcB+TjAYKNRgf9Vcj6Be6EUI6m1V5YY0YCWAtvXq4ksDPqY3B8H/RsHDsWCDqutJ6gGTxVTaIZp1mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309478; c=relaxed/simple;
	bh=CTCsHDk+g61hKKQtDVpDFv83Cuq21xqiv4WDu1gSgzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GN5E4NYo4WdOprfj3xJddFd7tbal2SVGvi1fN44s17XFEHAu/6LVcWhAykcvmljmc+2oCiR8Gq7e4fVN0evbs6Iadav+z3fGc4X653faRVQshjZ8oanxbob2ZLS6Wvfg+HdoSWjREpZnrDJ01KzR7DGzkEhUwOzn8SpMOQrjvtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CAOjEWQa; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7HYcMzGxYWO4v7sgOTslqAqoQRHFQwmmiiBF+m7vekbhjM/YhY9USGfqAMNKFhvxEVvPVSsFFCaX0g8Lg5aCGjsqKlomRjj7MB9HtmNExxhV5hj9AY2sf0CyddfjqF9Ki7PXBJiITEJSMedW8RkSyB2+u2AAXQFBOE/F7csJ1pccGLC5cPDksp4qESKlwEO4CT0AemOj6JyjUFkzahHlhN81DlfEVU/CWlrKt/hXl3djhY1RkGLNGlheO6dhrKcaAROH103HDYkYo5KnA2rh33TpEeEjLatauca7pjgU69DrIpGAzUNIhtf3AUVwdSFm72y3Bd/2J3fv+WxZK0tuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOdl9ZcC+O1qp/XA4NB220EEy+ZNEqqLNW2cMFMifQY=;
 b=SDrtwNJGucpUd1yr7QfzwlsyHJiLpfc34x/pCMggKR+AqdONFQmYVmSPvEyfBFeIsXtQSArG/IrW1Ahq78IeFgfKn9JLkbB8IOsT4uhw+aFS0vhMJmufTVtwcjpca9uSJb6KRP6sh5X5G/IbxcPenpO5KXMWKp82yf5Tng6fG1CGcRE54TR1ntOykzqYMfRBQrYGdTL3mwf4ks1kKxGjqClI1vWTIDhVresyAx/7kvmH/a985sx7FNWZqU8janiH+T5aNg7ADakQ96GlZhZOwlIbe4sdccw+RgRzgeGw57L6JUM5HqtWMHEwoDoewDN+pQfwOY7dnnpjICHaOy5YCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOdl9ZcC+O1qp/XA4NB220EEy+ZNEqqLNW2cMFMifQY=;
 b=CAOjEWQaTKaHIDSCWRkrIdSDTdA1CpQnsEhOe2xHj0XOQ0MrBxkjHg46Yhnbro0AV8g4vbE3MRgxH45D1imzE1UM2kSHNjJ4uKBUIRwcEMH092yvKpqlrMUGqGU8XPw7HOD81Zs5icWfg4fsCmKRBO4WnKZJ7aJxmcDWQdDYzGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 21:04:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 21:04:33 +0000
Message-ID: <2e774d31-d63c-4bc8-b88a-1cee74533a5d@amd.com>
Date: Fri, 22 Nov 2024 15:04:28 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 18/26] x86/resctrl: Add the interface to assign/update
 counter assignment
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <3851fbd6ccd1cdc504229e4c7f7d2575c13f5bd6.1730244116.git.babu.moger@amd.com>
 <1757cedb-e5b8-45fa-9b70-4c78b5770624@intel.com>
 <77f808e3-1dea-4a85-b574-dcdcb03697f9@amd.com>
 <7fe1298c-d026-460e-aa0d-76144abce524@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <7fe1298c-d026-460e-aa0d-76144abce524@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:806:20::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 631eaf18-c6f0-4b36-a565-08dd0b3943a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHBlVlNuQzdUTTJQbkVMME5sTkNPc05NSHQwRUFwcDJSVm1lM3AwYkFSQ0tl?=
 =?utf-8?B?dmU4Tk5lNk9BWWVHaFZWYUYxWTFPTXJOc2lvUWVML3k3ZUZtWUluaDBCL1VZ?=
 =?utf-8?B?V3NFVUxuaktRS2tkRFRZdGhMdWxsM0l3VktteEJRQlpFcWRZVDNEd2ZsVzdk?=
 =?utf-8?B?QllHclBXZXZRVkJyUmFDM3kvcmgzOXR3M281QnJDV3dxSUxnL0NnR3ZWZ09i?=
 =?utf-8?B?Y3RXSk80QklXRERwUW5QKzRsQm5wblgwTWlkTzJJTmt2bDJOMGVNbW5wWkwv?=
 =?utf-8?B?ZGlYK2VTaU1hWTY2Z3V2bVdicTRheHR3Q3ZZQnd2cWJ2YWpqY0FEaUFlQy9W?=
 =?utf-8?B?LzlmRmErcTdYeXhlR1VlRVpEemwzOHM2NG45Y3ZLWGVpN2xsVktkcUdGTHR0?=
 =?utf-8?B?MS9CUUpRbGFhSVNsbjQ0Y1BvNmpraFkzNmxPTUZYK2U1OTJJNzAzVkJtZlFr?=
 =?utf-8?B?OEpsVjVRa1ZLUnF5V3BOd2YwczZ1bXBKS0RXUkpyYUo1T0luYUtkMm1NUUk1?=
 =?utf-8?B?ZjRwc25oWW5yUzY1WTU1UG13L3NhUVkxTmtTK1MxaGNLQWhkR24wcHhUdGMw?=
 =?utf-8?B?UTgrZWdGeEJJdU50SURsWFlqVHU4RlNNTjJTNHBjQmNJdlpQYmhnQUcyYkxu?=
 =?utf-8?B?dnk3aXNEOWp5dXZlUEhLcnRabGNLNVZFZk9maWFjUE9yR3I5bzc3WFJyRGxQ?=
 =?utf-8?B?anZzdUlkbFkyUG8rUWdzY0hVNVl6MFJDTVFKa2QxZTZ0WE9jZ2IyTDVMRFFZ?=
 =?utf-8?B?ZHVscVVqNWdhSDZGRkFMVnpEV3J5WnBSeWZiaW1YQ0hJcHlqUW9jTDhsWjBL?=
 =?utf-8?B?aTU3RnAwRENIN1hVZSsybWEwN1M1emVnbzNlN1NxUUg1TmNaOFE4bFdXRUVz?=
 =?utf-8?B?SmJjRUFVRi9jcE43bXZTVXNaeThkbHZoeVN2UlAvanNmWkt3QlFCNWIrb1dX?=
 =?utf-8?B?YjEwdEpTOWh2TXU2MVdWQ09jaVA3OEhXWW91TTBRTjF0bk5vZUxLdjBYQlNv?=
 =?utf-8?B?akpLeTR3TVpkbVdyMGFlS2V3RElZYnVRa0V4dUsvbnZBc1F3UWxaNk5ZZkk0?=
 =?utf-8?B?Sy9UTGVvREFieXJrRkRTeUFGUUpXcFFGNnc2ejZPK1l6cG43QmRvSFZmc1Vt?=
 =?utf-8?B?aXh6RGp2czJBRHZVZ2NUMnNUTUlwMHlhVUFGd0lSUDBYaGk4Q3YwcFcvOTJB?=
 =?utf-8?B?Q2ltQjd6WExUZW9yTjdtQitDOUJmSGtJdUUrMHFDOWpobG5PRFpydGdHZnNz?=
 =?utf-8?B?R21wT0M5Y01zSm5xcDZGN2dyNEFyaGJqdDZCOUFrV25IQzVXb2x5bGZQek92?=
 =?utf-8?B?QzJJT3g4S1hZUU15ajV1a1FJVXFjYytHcTg1bWNyTnZ0dnlrRUJ5VzRmaC9s?=
 =?utf-8?B?Q1dmUFhGUnc4Y0psRk02ak4wZE4xbzl2WjNSZ1lDMUQxWDVEcWlJaXdUTE1U?=
 =?utf-8?B?VDdseXAwQXN2MjhMdHZmRVJLSjVmSW93SDFXdXJYMlRZL1RKeDhoZ0N4aWpY?=
 =?utf-8?B?ZnRjQVB3UDdUMXpMZUhrNlJQUzVhMlBtNkE0ZTNXZjhVQzJIOHZKb1dTU2kz?=
 =?utf-8?B?VWh6R1NDcDNxQTJHL0xPREdGL1JvWDhIcnlYRFRWTndVcXFZbkt5RmF1L1dn?=
 =?utf-8?B?ZjhxQ1VtdGNhdEJWdm8zMi9ocVYyNEtad1I5a2dtZm5RSXRPNkNmbFpubUdN?=
 =?utf-8?B?STdOMkd5WmRhMGRGV1Y3YnNyaGFET0svZW9JR0tlY3Vkbk1tQW8zVWF3Z2pR?=
 =?utf-8?Q?pQW1KeJMiuTh8jMSzVp8dH6ffY7pzNd9j/DPFW0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlJQUHlFbGgyWUVUcVlsZE9SSU1udWlQd2JxYkpWVlFxR3Q5VWhnNHRNN1l4?=
 =?utf-8?B?WmhWcUFpVStsaVFjMCt0VDQrd1ZRYnR6bEZFRU9KT1Y4SDdIc3k2Wk5UMlhv?=
 =?utf-8?B?N01iaDhqMThxWXhFTUQ4dWRReTVUVXhYcWhlK2E3OFZJV2FwTmZLWU5TRTRX?=
 =?utf-8?B?UnFrcHVXYUJqZW9nSHRJMWFPUEp3M1oway9vQXNJK2FhSjYySk1jNC9hMVIr?=
 =?utf-8?B?T0N5cmxLWFhOWG44NTA3NTJ0WUc5ZDM3eGpvREV4L1dZQXQ1aTVVZE1nMjBx?=
 =?utf-8?B?RVFHWGZhZERQR24xZ0I1OFdGRkt0cGw2dUNLblJKdHZOV1hHTUNWWjBrSWFQ?=
 =?utf-8?B?c3d4aXlSd2VOZDNZTkFpaytUY0lsdUVqRjlZQkFPQ2w1OVdFdGFDMVY5eG85?=
 =?utf-8?B?dFhrTHhkMTJrdndvQWJhbVpZNFBid1hjOFIzNWQ1MzFWajZsbHBQVHhmNGRT?=
 =?utf-8?B?YXFCb3Vmb1g2Mi9FZzhLQURjcVJ4cnQ1MHBuRjhmNlZGclVpcmk1eTZUWmN4?=
 =?utf-8?B?MmRBa1ZrVXBhWmVtUDVuNk54SGpiaUlMbkw4N25QYTk4dy9JVXo1M0VsSjZr?=
 =?utf-8?B?aS9BNVNKaEtwZ09hMEpiUmRSM0RSRnVpWVl1M28rS2hhNEd0YzJWcWZIdm5K?=
 =?utf-8?B?dk00MHZTQXVEd0dCTGJRN2JhbnJDWGFscW5HNVA0QVBxWDhsdkdZNE9Bc1lw?=
 =?utf-8?B?U0thQzB0cTNaSm5oa0llUFgvWldYNFMwaURlMEdXTGNnZCtwQTdXT3FPbWFG?=
 =?utf-8?B?OGdRQXVYc20xTDlvWW5EZThQcVpVUkFpT09tTWpNSVVoaWRJSmRsRmJTem9N?=
 =?utf-8?B?UTRYSy92cUJuRkQvRUpSWjlRWVRabUErUjlxSVNhNU91UGhuOHRIaE1sTWFS?=
 =?utf-8?B?MnhxNTZsUExpWWNJOVNWendPcWxSQmhYQ2tBZnl4ZXo3WFJiakRRSFpJT2RN?=
 =?utf-8?B?MHJKNXVHOFhaR2tLMGJGZytlL2pOd3YyMjZKYk4yUUQ5NWI3MUFJVCtjODlL?=
 =?utf-8?B?eC8zeEdVYUhnZTEvMTRQMkY3WDFvT3pWWDR5UlMzNlhZOEJYOXo1SXZwRFVt?=
 =?utf-8?B?aHFaS3llYVRxRmFOT3ZwMjlNM3FFVGFnNHc4NEhnVXhrQjdJSTZqbzZoT1ZW?=
 =?utf-8?B?K2QyYytFa0lEZGNnTnA2OCtWY3JkdW1odE1TSG5yeVdyN05RVFNHTmtnbGpW?=
 =?utf-8?B?MHJ3eTRpOEJKWVZ0Ym9ma2xVQ1BqVU50bjNlbjlxbW93bGNpNFV4WFNKZTcw?=
 =?utf-8?B?b0JLNkovVklxZmtoWGJ5aWZuVWFrU2paMXY3T0ZQM0c3ZWEwdllJdU4vbWN6?=
 =?utf-8?B?b2FHbEpxZW9mRktrNWlnN2kxZHFuVzVCV1RpWmVtSHQrOHp2NWNGeWc1QmJ2?=
 =?utf-8?B?MGcxM1AwdlJycHJnZThJSHJ2WlFNcEh0RHVUSEZQQ1B5a3VlWnB6SWhreFdm?=
 =?utf-8?B?RjdWK1oxVEhocjZOelFKR0FSUzNNS0hEZkxKUzNtcGM0T1c5d0tHN1NhcDNK?=
 =?utf-8?B?RlZmRUZpYXR2TlEzT0VXRVlsdGFyNkJWUzZCMTdnaHp4azcrTEkrTmQ4bnox?=
 =?utf-8?B?V0w5TjN3NzMzVU41b21XMmt4elhSZGh3emxRUGx5L1JhejFiUXNYOHh2UmMz?=
 =?utf-8?B?bGtmOTVwTm1Cd3RIMldocFIrTWJUQTIzTG91MFE3VFBmUXIyeldFdlFrTFFQ?=
 =?utf-8?B?RitZa3dGaENOUUhJclVYTXR4cEpRMVZWMnZaUTJTV3Q0N0xCRlUzKzYvem5r?=
 =?utf-8?B?bzdlblRQKzBRMUxVaDVkK29GMzdJZzF0dEt3MUtiVXkyZ3BBYmtGcTdzSFFt?=
 =?utf-8?B?OXBpYnZUaUZhaHd6QStzdEp4M3grS1kyc0hvNkN0TWkzSGFSNjNmTkxDOWtj?=
 =?utf-8?B?NnVnSE5uS0t3NmtDdVdZZHNKeGcvSzV1QzkyT1N6ZGhEUHZFTExuUUEyV082?=
 =?utf-8?B?KzcrN0xvamlPdldpck5XckEvOVpvbklYQmtrZnh0SkJXRWJmVzFraUhZdUU3?=
 =?utf-8?B?NHZlbjdxeVBCbGkvTk1MZnJqVHFlRUhlVGQwYVp4eStLUWFxcm9aeEZUVVBE?=
 =?utf-8?B?MTRtYWFSeEs2bFRObFo1bFltYWluRE51WmtRVk9qRjgzUTZDU1dWRFBrdkt3?=
 =?utf-8?Q?ru6A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631eaf18-c6f0-4b36-a565-08dd0b3943a1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 21:04:33.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adwQ2vMKQAd7cWJ7ARc5Ye5Tm+pz3Xo4h+4QQSvT8Mk+/GYg/HHBVF6Ct7kkC3UT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095

Hi Reinette,

On 11/21/2024 2:50 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/20/24 10:05 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 11/15/24 18:57, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>> The mbm_cntr_assign mode offers several hardware counters that can be
>>>> assigned to an RMID, event pair and monitor the bandwidth as long as it
>>>> is assigned.
>>>>
>>>> Counters are managed at two levels. The global assignment is tracked
>>>> using the mbm_cntr_free_map field in the struct resctrl_mon, while
>>>> domain-specific assignments are tracked using the mbm_cntr_map field
>>>> in the struct rdt_mon_domain. Allocation begins at the global level
>>>> and is then applied individually to each domain.
>>>>
>>>> Introduce an interface to allocate these counters and update the
>>>> corresponding domains accordingly.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>
>>> ...
>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> index 00f7bf60e16a..cb496bd97007 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> @@ -717,6 +717,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
>>>>   int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>>   			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>>>   			     u32 cntr_id, bool assign);
>>>> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>>> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>>>>   void rdt_staged_configs_clear(void);
>>>>   bool closid_allocated(unsigned int closid);
>>>>   int resctrl_find_cleanest_closid(void);
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 1b5529c212f5..bc3752967c44 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -1924,6 +1924,93 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>>   	return 0;
>>>>   }
>>>>   
>>>> +/*
>>>> + * Configure the counter for the event, RMID pair for the domain.
>>>> + * Update the bitmap and reset the architectural state.
>>>> + */
>>>> +static int resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>> +			       enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>>> +			       u32 cntr_id, bool assign)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (assign)
>>>> +		__set_bit(cntr_id, d->mbm_cntr_map);
>>>> +	else
>>>> +		__clear_bit(cntr_id, d->mbm_cntr_map);
>>>> +
>>>> +	/*
>>>> +	 * Reset the architectural state so that reading of hardware
>>>> +	 * counter is not considered as an overflow in next update.
>>>> +	 */
>>>> +	resctrl_arch_reset_rmid(r, d, closid, rmid, evtid);
>>>
>>> resctrl_arch_reset_rmid() expects to be run on a CPU that is in the domain
>>> @d ... note that after the architectural state is reset it initializes the
>>> state by reading the event on the current CPU. By running it here it is
>>> run on a random CPU that may not be in the right domain.
>>
>> Yes. That is correct.  We can move this part to our earlier
>> implementation. We dont need to read the RMID.  We just have to reset the
>> counter.
>>
>> https://lore.kernel.org/lkml/16d88cc4091cef1999b7ec329364e12dd0dc748d.1728495588.git.babu.moger@amd.com/
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 9fe419d0c536..bc3654ec3a08 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2371,6 +2371,13 @@ int resctrl_arch_config_cntr(struct rdt_resource
>> *r, struct rdt_mon_domain *d,
>>          smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd,
>>                                &abmc_cfg, 1);
>>
>> +       /*
>> +        * Reset the architectural state so that reading of hardware
>> +        * counter is not considered as an overflow in next update.
>> +        */
>> +       if (arch_mbm)
>> +               memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
>> +
>>          return 0;
>>   }
>>
>>
> 
> I am not sure what you envision here. One motivation for the move out of
> resctrl_arch_config_cntr() was to avoid architectural state being reset twice. For reference,
> mbm_config_write_domain()->resctrl_arch_reset_rmid_all(). Will architectural state
> be reset twice again?

That is good point. We don't have to do it twice.

We can move the whole reset(arch_mbm) in  resctrl_arch_config_cntr().

> One thing that I did not notice before is that the non-architectural MBM state is not
> reset. Care should be taken to reset this also when considering that there is a plan
> to use that MBM state to build a generic rate event for all platforms:
> https://lore.kernel.org/all/CALPaoCgFRFgQqG00Uc0GhMHK47bsbtFw6Bxy5O9A_HeYmGa5sA@mail.gmail.com/

Did you mean we should add the following code in resctrl_arch_config_cntr()?

m = get_mbm_state(d, closid, rmid, evtid);
if (m)
      memset(m, 0, sizeof(struct mbm_state));


- Babu Moger


