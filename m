Return-Path: <linux-kernel+bounces-349815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8FC98FBD4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 03:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4722848F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE78B18637;
	Fri,  4 Oct 2024 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5sui2Kbf"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC117BA7;
	Fri,  4 Oct 2024 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728004325; cv=fail; b=dDf6Bvv1vNhwZDPOU9/hDtqzuhpOpmi4suEqclrUzRy3Tfd+6RY0KEM/KpgJ7gWRxuuwisTQcwt7L8v4AFZ+1yQ+L27yiKRNCdQWp0VuQ0shPSfWHQEXkJPRRrn62maiyXGKmUL9J+iyajn+1A1OV8xpMV+yVlnSnTI8pNVZD1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728004325; c=relaxed/simple;
	bh=Noe+06CaO+Fb4gvkXlmek9/X7JKnh21D9zFP4ZWrlEE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hjNwU3pO6vPJORq6wsKoj8h69g8BydRHf6JkRcDvCyecPnMQCdIQ+TEtdXSgYoW3+sH5ki86DYkwaw0M5XmDQjV8rIZ0aGy0OGsvIMoZUW+tD/p0lLLr7fqK2uqW2Go0STsVMqJaZZuS4d336MEUWU3RmWYI+95H9BkLGRmzaSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5sui2Kbf; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0m9buz1My3SF3eImQPV6qGgfpUOWAeQg4mGKqRKCKi+JUgXv7AOkwBAHV9Yln832p7CpmPXaIrQ3aITwdC5jkxJ4+C8eb0NP0cM8e0xUgwYa6TLgXSfw/riv+44euqOxCtUCfncdrGAeBUr+Dowswi+8kHP5PSOE/3xNR3RAxydxRFaFiSB7wAHyRqAuVqOYg2oZ2x0S6VQmz9pj75e9ajUIe0GDwQhSStier4rvfJ6p8Z5PUd3VXGb23q9glOSdaUPhqSFKfOwFxU0jjlJ5taUXHpKWPpUqtaspQ1SMtjpa4auDpGtI767flgymKIHGQ8ly7z0z8Pr29FAy4HBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5s3AnvQlz5wjgBMvNExJkjkRN1kZm/8NLuFcGsOcEg=;
 b=UNPMwbj83sYvTppSc/a9c4mtcmEhN3KL5BWPg/DjuC6dcGAqo6FJ0yP1KWzJWp2Z+CkD8cyYhilLwz2faKeHnGuFvKjN/l3rBKH/3h8+4KvVlk28ByNRB+XnpeIOxMRzxBCj3zw9nXu3CjALnNsTjQ65OQAXXdQpDZKyrkvKjDh9NB5Av6Fv4YKwCfwxMvaaoNWydPCpVbr8EJQi5LYTq63BmU7xAw8t9spciMYPnjyiS09/kTIoIV6l0hFrdy5LFLrlBPjtfv5X24uE8tUq73E0DPszL7pnKNMRNLO4bj6/aJsKe3Xh96uecGcHPHevnnztAa1QgPaoCGcZI1TfAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5s3AnvQlz5wjgBMvNExJkjkRN1kZm/8NLuFcGsOcEg=;
 b=5sui2KbfnyA4X8je7zn9fr+bVPcwCynsSdtZdSQUkaPItaCm3+7RgYk2E89IRfCxS3Kqehfado1hRIRCcEmlS+lN4dgdYBRFajxFUzcBojfUEggg3nI65dwxdh6IwPdnNOE/KrPMIMibJ7sYyPCxPkh0t97gsf3PaI5yXJG5BAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 01:12:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 01:12:00 +0000
Message-ID: <ca7b1d14-e37d-5f0d-9371-32d8506e51eb@amd.com>
Date: Thu, 3 Oct 2024 20:11:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 24/24] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
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
 <68c8ef0592c653c5b99cd26d982966cd4a41cb31.1725488488.git.babu.moger@amd.com>
 <faf50d1f-d3c1-4a9b-a87f-4598e88dc9a1@intel.com>
 <c43171f4-48c6-b6c3-d71e-1f23367932d7@amd.com>
 <1d987ed1-0065-4e4b-a719-65af93907974@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <1d987ed1-0065-4e4b-a719-65af93907974@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0196.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d9f0a6-abf3-43a9-d551-08dce4118c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THE1TmN3cW9LWjRkMDE1VmlIVk43aFgyU3JrYXZJc2lBRkpUTFpRL1dLS2lQ?=
 =?utf-8?B?YWw0MDBsaVRieHgrRUE5RURKakQ5a1FadTg5NmtXSW4rd043WlFDT1Rtcllz?=
 =?utf-8?B?d2JTM3loWDRkaldNVmJML1g2Q1ZMd0ltd0w4NTVEOU1VMmJJQ3ExQVlYNFRM?=
 =?utf-8?B?UnVMa2xBR09ZOXdlTGZGVVRDR210ZENNa2pSL2VaaThSNE9VODBLZDBlVnFV?=
 =?utf-8?B?V3ZOSXFNR0VEUmRnMnZKZVd2UGxra0RKVm1jR0RUNW9JUTBlNm1NM2MrSFVK?=
 =?utf-8?B?QkpDNUovSUVaMFVldXFCYjJ2UUh4bWp5dXBZWVV4QXRvUmdTY3lGQzhmOG9i?=
 =?utf-8?B?REU5ZjRQZDVMY0QwSEZQcUxyeFRZUTFKUjNuc2R4dEFHT3hVYWhobC9YS1Jq?=
 =?utf-8?B?dDZQUG5RaWQwQnRaMWltZ1h6c0R5KzdwcFVPc2NXc2pUVlRoc2M0RmdGTWJF?=
 =?utf-8?B?dWhFSjAvR1BxNkdtWTJsLzRxclRPNWRlbDJFWUVzYXJWRlUrNmM5ZWNHSGdI?=
 =?utf-8?B?Q1JXVFpSWE1xUUpyMXovbklEY2hQNVExVDlUWUErbWIrNzM1bCswSWdZZFVi?=
 =?utf-8?B?M1QrZTlEQXlQVVdDRnFHc3hVQ1lnNENHcnliV0dFQWl1RXBTRnhRWlZ5S2lV?=
 =?utf-8?B?TjF2cVNwNFRud2V5WGM1VEw4R00zbHJtNUQ0SmlremlOQ1o5OWQ5bXM0V1cy?=
 =?utf-8?B?MFgvZUNzeFJqOGpSU3Nxd3JqWm4zS3FvREhPVVBDVWJHWXlqNE1HblJsa25T?=
 =?utf-8?B?a1RLWkh5bWkxbytkdXF0aE1pK3RiWTB0WVNOWG4zRHhuTmMwRG5kNU02UnBQ?=
 =?utf-8?B?S2lNdFd0b2dqaUdmTmo2NGJGWGp0MGVDS2VaRnU4bTV1YldMaHNiQzFCTWcv?=
 =?utf-8?B?aHNkWWQvZzF6ZmNhaXFqZElndUQ0WFkvYWx1WUZnQjVSTDVKWjFoZ1pPUVJz?=
 =?utf-8?B?bC9EYitFTVRLa0pnUjRZNkluV0xBV0l6STRJNDd6OWNSOUtZcW5oUzZrdUNW?=
 =?utf-8?B?cDYvZlEyNXNoeC9SM3FtQ0s1eHp2bGkzd2J5VnVBTjR3QnJtaHBaWDIrQ1FT?=
 =?utf-8?B?bmhvMG5oZWFieDNEOHdwTUo0WHRkUVNpWFlQMVJsNDgvbEhVaTk3ekYyMHBU?=
 =?utf-8?B?OHU0MEY4WVl5aGtyQU1Wdm9DTVBseU9qKzlhOUNvZDdjTFUwRjBTQ3pLTEYx?=
 =?utf-8?B?RVhqMWVQcWFDWDNRY1k5QmcxYVBDcWx2aU1XOWt5cklTTmVjVHE0WDNDSjJY?=
 =?utf-8?B?RzFjMkR2YXJkL2hvZGx6M2VQQ1d3WmNBbUtPSTU0ZFR5b000aFh5K1M2L0JT?=
 =?utf-8?B?SFBkQ1ljWjVZTTdBZjlieGhpR2JabXQ3dFhYbjRBTlh1SWswYTBia29sQXBn?=
 =?utf-8?B?eUJ3NFNVd1dEL0hoYjJuNG9vNDFpRCtpK1RUa1FXOVBPRkFMQXJKUVVEMnI0?=
 =?utf-8?B?ZDJPWWc5RnF2M2M0WUN4QUpsTGhMQlc3YlNKejM0UW1IcytHRW9ZbCs1WVow?=
 =?utf-8?B?VEwyMDFnZExwT1VmTTVUSTEvaXo0eFRreUd1S3UyTzBOTlBNZzA0WVFWd2Na?=
 =?utf-8?B?cHhNSmI5SldVSVAxS1lkY3NTQXJBYmVEc0VPdC9tS2I5WHdWOGxCMm9WVGlK?=
 =?utf-8?B?SEtrUU5VckU3Q2crTlB2TkdZWDFjZm03QUhFTE0xcDM2TlhJd3FJR01aeWc0?=
 =?utf-8?B?czFMa3FrTDBCT3RVdHd0bERmMkpxOEhVb3hGdEVxWit4Zk5lREZkblRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjN3cmRJQzdvWDUycUw5WDhvR2g4QW1qYWpQd0JiTWErSUhkTzMwWk44VDlO?=
 =?utf-8?B?TFdzQnlaUHlYTnh0NHFBdlEzV1BiVm0yWVZNNVdEMWRQRE9tZ2ZvQXpBeFJ6?=
 =?utf-8?B?S1Z0NzVsSE9QeXNpNjRBQzVmQVMrZ0JGUmNLcFRqS1pEdmFWYmdvakRHaGhK?=
 =?utf-8?B?S0o5Sm5kZmpWY1E4eHdHWDE1SzBZd3hJazRmb0xHY3IwSDZWV1IydUVYdmlo?=
 =?utf-8?B?QzNudy95N1Nzd0FoWWVMckpEUEFhZUpjemw0bzRMdUxmaGRSWUx2QlZGVVhU?=
 =?utf-8?B?bVQreDVYdnhEa2JORUtXaWM1b0dWQWY3VHhGNHlDRGVPRWw5SUxUN3hVeHMw?=
 =?utf-8?B?MHNkNkcvSzRNclRZdkdVNjllL0hFZ1ZyR1NLb3F1WVVldFQzV1V2S0JoL0JT?=
 =?utf-8?B?SXJGTS9aejBWbkZLR1ZNSVpSMmFSeTY2SU5CQUpPUndtN09VSzZqVFg5Z1Bv?=
 =?utf-8?B?ZWVrS0FxbnRsRE9ETHJweU1RME14cjR5NTBENmtMelZNaElFaHJJM3FVK09N?=
 =?utf-8?B?R3Z0OHQ3Y0JLWVRJSUFLQ2hxS1ZHazBwcldVdzc1Y3ZyOTNLSTVLUVBtL1hS?=
 =?utf-8?B?R1lKY3krR292a2VyQlVtNmlpbVI5M2R3ZVZtMVpLODZpcWpMWjdLc2h5Zkxj?=
 =?utf-8?B?cTY5UjBISHVqQ0FNcHh1UVlFb09OOUtPcDd3bklVTnhqUmpZUjFqcU9xcUZS?=
 =?utf-8?B?Y0xCTThTY3d6cFRnY0hDR2pNMkIwY05mV3Z1NytWZytTUFhrZ1gxUDlEWlY2?=
 =?utf-8?B?YmFFWkVva2N0KzNLQlFYQmEwSmgvVXpjUjlyS1kyeVEwcms2SE9zZmRYRFoz?=
 =?utf-8?B?SS9kOVcvWHRXampySjRlTXczQ25jbldGYWRtN1FQQm0yTUhqZFpDNlpNdXNI?=
 =?utf-8?B?ZnpXYi83YlJHaFF5QTZFN1AwWUliZ3dXNWttajRGN211d01QTEZrTFlYWE9R?=
 =?utf-8?B?aTlKanRrY2xtanZSdGVCaEZSODF5b0ZVUHVYeHNpampGbU5DUXh4Vjc0S1d2?=
 =?utf-8?B?UDEyd1BDM0NROWZRYURVY09HZlRkcG5iQ0Q5eVpWeUVBL0hNZFdhcUtQcmNS?=
 =?utf-8?B?NmQwR1RweWE3RjU2RWV1MVZJTysyVlRrRmRHbDZvS3lUZ3ZGc3NDRldyNTAv?=
 =?utf-8?B?eVZIek51cVpCdWRuZnZHcnJjMDN5bFNDS1o2eHVEZ0E4NU9JcExrOE5icDI1?=
 =?utf-8?B?TWNQL0hUVTcyd0lLQ3cxeVVmaVRKdnVHWUIxU1RGV1EwSGZKVnJGTlFyNzZa?=
 =?utf-8?B?NmwwbXh6WGFMdWp5K1dMK3lreVgrWXRzWDNMYjZ1S01ydTlBNkw0TjAvOXVr?=
 =?utf-8?B?RGYvdVpMV3o3S0hMTTVNNTVoOUNnaENmWkZmejlib3lhWWxMSDRQMi9HcHRn?=
 =?utf-8?B?aEM3RE5mL05RY01OS0lDbGhEOVFMSnQzazV1QjNzQ1hza0pRRXgxcTJNRFBM?=
 =?utf-8?B?ZEk4c0lzK3pkUmdYcXZUOGkxWXY3Z2hvVzJnNHl1b1A4U0VpSkkyOG13MVF2?=
 =?utf-8?B?SXg5eDlTZlJNTENQMHFqdWF2NnNQUnoybGI2T3FqSWJneXNsTzBpKzF0aVZP?=
 =?utf-8?B?NDQzbnpjengzYXR2dDlqRlJzUDluVXdPZUVDblNsdlFKMUllNG5TT2xOb1lX?=
 =?utf-8?B?cThjY1NnN005UVZ0RTFTZ3cwRW1RUFpkUGhYcGpMSWMycXhUUFh2bmtJNHpE?=
 =?utf-8?B?SngvZUlvRGwyNzhrVmNzMTVRWE05NDJHSWtlYWJyUUhSWmhIVWVHdEI3M0gr?=
 =?utf-8?B?UDl5OTZpcHV4TSt0Qi9NOGtpSlZSd0JzQXFPOTJhNEJuOHBmSnRGZitJOEJG?=
 =?utf-8?B?WjZwUmVtQXpCdkZwQngwVXpQbkpFRGFVTldyRWJiMlhqdE85cTNrTkNIN09q?=
 =?utf-8?B?c3pNK1pGYkFldlhKRFNOZksrVnVFaWZwZWhEb2dtUkd5a3ZXMW1SL2FSSnZD?=
 =?utf-8?B?dUlvTFMxRDgwa3dQZkgwY0htTFBPcmFqSU11N0VyWTNoUE9Wak9KRHhSdjRK?=
 =?utf-8?B?cGswc2NuWlNiMVJyUEdwZVJuWVVhaVF5TlZMUHYydXFhcG9OcmNvWjFvSjY4?=
 =?utf-8?B?OG9HcTlIMnB6enEwOVBtaEJhK3pmMDBEZEVHb3VxeC93ckhEU25ERW1TenFL?=
 =?utf-8?Q?1KEs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d9f0a6-abf3-43a9-d551-08dce4118c78
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 01:12:00.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDKT+MB/vgJGj0V85NF6AQe04nksWVHdt1DAFRAKWtOjbXx+P4lnLL36jk8SHvpe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987

Hi Reinette,

On 10/2/2024 1:19 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/27/24 10:47 AM, Moger, Babu wrote:
>> On 9/19/2024 12:59 PM, Reinette Chatre wrote:
>>> On 9/4/24 3:21 PM, Babu Moger wrote:
> 
>>>> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>>>>       Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>>>>       Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>>>>       Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>>>>       Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>>>>       Removed ABMC reference in FS code.
>>>>       Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>>>>       Not sure if we need to change the behaviour here. Processed them sequencially right now.
>>>>       Users have the liberty to pass the flags. Restricting it might be a problem later.
>>>
>>> Could you please give an example of what problem may be encountered later? An assignment
>>> like "domain=_lt" seems like a contradiction to me since user space essentially asks
>>> for "None of the MBM events" as well as "MBM total event" and "MBM local event".
>>
>> I agree it is contradiction. But user is the one who decides to do that. I think we should allow it. Also, there is some value to it as well.
>>
>> "domain=_lt" This will also reset the counters if the total and local events are assigned earlier this action.
> 
> The last sentence is not clear to me. Could you please elaborate what
> you mean with "are assigned earlier this action"?
>

I think I confused you here. "domain=_lt" is equivalent to "domain=lt". 
  My reasoning is handling all the combination in the code adds code 
complexity and leave it the user what he wants to do.
- Babu Moger

