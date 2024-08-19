Return-Path: <linux-kernel+bounces-292303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BAD956DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126D3B21F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33292173347;
	Mon, 19 Aug 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nptT+3z9"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DCE170A39;
	Mon, 19 Aug 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078774; cv=fail; b=SIGf1yfzXgqswVzXuhyU+m0xhQ21VDNjigu7k6KfEi2ws9hLPhQR5mFBgBWbqq2Ig5ull3NOj76xqJ9q7gRhEQ4N3EKWbYS7svvY3P+gCq+AK0y9daruqheYxxUhmxfZ60oAmFV9gjqXBlv61/HfRVmLKfpHSADDlkdWPPna0k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078774; c=relaxed/simple;
	bh=7sEUl4UXjUdMgf8py8cCpokpKxyqzjQzK+GRoKPJkME=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XbRPGBf1UEpcLllGFYRtNMP/Vb+kwjrOGrq1LGEqPHb+NfnoKL8ZjCWfdRuasz0fu3Fq7w4PcvONhRJoLpkd4zOoD+T2ECn/Yq/EDlorOC+fgTCoNzZUwEbaSjkvd29Idz4rID1TPQ1SHClOjjrZm/g/5p7CzSY+QkAaKsP6cxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nptT+3z9; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emDE2XTgo5IDolhvEtBYY+wAdkMmRm3lYPF8Kv7avMO8TvUdPeAZ1zUwDIJKyaY7jfeubs+ptzqWLglJREzEttGQ8M0K648Twqz/tm9CIrk082Kzsmv0YTqpcKMX+om+Vz4rMUbtiReJd1sF7wPV80GLaJbk2Xvjz0t0dfZKETvA8P4YA3SOxabGMCpd8t3fGZeIUcZVXDWbp4w5JVK1YHD3j9och9shvIDMek6LnNM9ng0g5fAqpvBO5kcx6cPPEQekTIgywPMz0oFKqyJT0xk9rPCeTSwoou7vh4sZS69PZ7nN27p9ciodNf+TIm6M1Q7QXUYvitP5RjXLORqTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcTmQJ+7p28CRwbaqTqlfawKrxmgY8epxQprndm7E8s=;
 b=uMMBTo/gAfhqBlLVdGErNm2n/HqWPIazwDsscgMSGmBHPcKATo7LA/e8jXBrOywPjCARV91w4C5JE2jSb+Ydm+hox1PJmEet1pAPg44Q6K2/A7WY92XazNArm+OqAZV736UGWe54Uauy335KNU4NyYx7UB6g4CCeFug04YsluQLLY76SK633eTKCPLMjnFr9cDea+j/aczNxZbNspjgRiehLKS5aFVDhbYSyLzIMy5DtE9U9CcYmDRR+3FGWTYWQK/f3ipmJkomRpAbaQXMdR6a6JCTqaxfHtGOrIxsXc4W/tGoDToH4hV6opbr9tvO85g2Z3/sVJRm3N9mhkjTlhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcTmQJ+7p28CRwbaqTqlfawKrxmgY8epxQprndm7E8s=;
 b=nptT+3z99X6MFGXIHy3PseihJ8MvfU3yO7NhgP91WXXCarwMN4NGuLrr/b24SeXJUHCZEAm/35v+uRIWqap9rx7OPq2FUFDymIxrF+4nMrRRs7u30UqgN19CsM8gJOGJBxgesU2124AuBsM3QnL9zwkiKb+Kp5lraVdfop4U6sc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:46:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 14:46:10 +0000
Message-ID: <b8ffb0d2-b189-4d3c-8eaf-73e653241b68@amd.com>
Date: Mon, 19 Aug 2024 09:46:04 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 03/22] x86/resctrl: Consolidate monitoring related data
 from rdt_resource
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <de0a8fc4b8f6093dd74516ca7ef569107de7b213.1722981659.git.babu.moger@amd.com>
 <f098bebf-2ea4-4fc8-aa20-8dc2fef79f03@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f098bebf-2ea4-4fc8-aa20-8dc2fef79f03@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:6e::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8a5e06-891d-4607-aa50-08dcc05daa16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rzh6QkFIUFdlbVlSbGlRbklyLzIwNWZpMjZZQk9ndzIvcmdJcmFwendSV1JJ?=
 =?utf-8?B?L1lmUlRORlFGYkRPMFBOVVljclc4Vm1LV0RrcVIvSjJKNGh2VHBOUDdhdnVO?=
 =?utf-8?B?dnUvdEtFaVByOW1tRmw5eTYybCtiUEp5dklDdCtoSStTOEZZbHlRd0ZnWlA5?=
 =?utf-8?B?d2tVL3l3dW80LzAveVIwekFRd3FKL2J3NzNGamJXUnlhL09Iblc0WXgyVDZV?=
 =?utf-8?B?ZWVoVW5hZ0lIUFE1bDk1VFh1UFI4bzdGZ25aYi9JL2YzaFdzZ00zdjZENlJu?=
 =?utf-8?B?RHNKdkM1a0V5RVFpUk9XMWxMWlFYc1NXeFJRNjM0RkdHWm8xRWRHUEIvcTZl?=
 =?utf-8?B?UklnMTlTempaKzJqMjBmOE82UVEvSklTaVBaTENIZXoweUVBRnNkbHNpckNU?=
 =?utf-8?B?TkFobUxLQUNmVU1xL0ZSdkhIMVpWL3c1TEVXampPUGh5ZkkwbnR2Q3lWOGpi?=
 =?utf-8?B?VTdUcmdxZTY2Wm5kOTZRTzNKZzZnc0ZDR3VHQUtzYXlMREQ0TVFQSkZ1VFBZ?=
 =?utf-8?B?N1Rsd0lUYlorMVA1ZzN6bGRjMTFOZG9SSko5dndIWVVYUHZ1NGFzdEsxenNn?=
 =?utf-8?B?QWFucUt3MVloNUVTVGlvRUg1T2NlZm9WclVhVStZa2pBM0xxdjlpSVdXZTU3?=
 =?utf-8?B?RG80SXBVcG9zRjFQbDR1L3hMcFBQS2RWUHR5ODR0OVNBZUZ2UjBXVGVDY01F?=
 =?utf-8?B?cHBhRXBPYmdDbk9VU1ErMmpSSzFHTW95Z1UweWh2RWw5Q2dQdjRINFFUVlMx?=
 =?utf-8?B?bHdqanpzNDV6UDIvNm5ZdytoWWU4UHN0QVBrbEhsMEsxeUtCYXRxSnVoUHY2?=
 =?utf-8?B?RVpITUlkQXYzdkhqOURkVlZCNmxhMkpjcFZucUl2S1NoblNPUSswSS8zcWZw?=
 =?utf-8?B?VUNhUk9oMHdPeEhOL2JaeTJySGVzcDZCbXBzS0hVRy9mQlJwVnJodWduTGZC?=
 =?utf-8?B?R082anBKR2x3Sm45bzExb0ZMenZnU1dza0UvWC85NmNWdGg5amJiei8zbnJM?=
 =?utf-8?B?L2VuQVk5WkhkWUJ5ZERiSGwrekVWVW53Qlk3M1JwdXZ0emFZSTNjWlNCU0hF?=
 =?utf-8?B?YzJ3cjNvL1pBK3lSWEZCVlRNNGtocDIzSjhHSFRHL0RLS0tsc2JQTUtncnBi?=
 =?utf-8?B?WDJBZ1VjQktPWS96ZlVLOUkwYUVReWEzV0dmd0Q0SFk4OWF0MWREeEphNUdB?=
 =?utf-8?B?QmZIM2ovb09aQ1N4S2VMTnpGY0l4d1NUNW5HUzV1T1dEM3pFTDdKVlVBRitC?=
 =?utf-8?B?cjM2SlYwVzVKTG1vTFVlb3hhQ1QrM1dXRXdtK09hZHZHVlhaRHo0bXFNWW90?=
 =?utf-8?B?VU5Rejhvd3VtTGZtL1MwTjBiWDBVOEZNWGIwK0VlaVlJYk9GcVlqNmFBdnJZ?=
 =?utf-8?B?L0lGS1loeVl4c2swdlFnTVhrdldGbTdHYTI5MVVFMHRoTXZCRTZtaEdENlNp?=
 =?utf-8?B?Smhxc09BTnZSWndvSC9YVG0vS25ZWlVGTTFBK3NIM040MGpNaDJvWUtZRVJQ?=
 =?utf-8?B?Z3BUMFdNMEhtRUFQNU9jcXVhdXllNVliUGVOb1NJNG55SnZRMEozaVNzZDVs?=
 =?utf-8?B?ZW1vQlJJOXgwdDBLSE5QTlpZNHI3NlVYY0w3TFQwVllWbmVTRzdFTG5LSlNU?=
 =?utf-8?B?cHF0d2QwZDU1L1QzaVdhZjRrdVZ5L3pLTGhwZ0s4ZzVUYjRieklNQkpOWkoy?=
 =?utf-8?B?WWVSNE00K2kybmlqYStqeVZ4RkFBU2pTaUNoOVRVd0RJQXF5aHk1UFhxNXJE?=
 =?utf-8?B?OU5MOTJLaTFQREIzcGJPU0Y0L2huUi9saWg2OVk0a1ZQa1NWVTNwMW5SVGJ4?=
 =?utf-8?B?dWZWSVFxQzBFY2ZvdmprUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czllemJBam9nVklQMzdMeFZ2YnRzWDQ0Yy83VzBFaEV3T05OMGhjampGTFN1?=
 =?utf-8?B?TDlSMFdETVB2bG9OYWJHbEd5SEVEM0I1RnBMNk83b3dteU9rT0NtY21LaUh5?=
 =?utf-8?B?RlZJSEEwcEx3dFhoZ2FvSW9Oc3FWVnprQUtOK1F0dUxiYjZsNjVrZzZmUlZ0?=
 =?utf-8?B?c08xdTJOM0RSeGt5VjF3NXlHb3pDKy9WdExaT0tHR043S1pab2crdFpJNHQw?=
 =?utf-8?B?aHRZc1dMUk9peUlscDB5Q09GQ05ESFcwMG5YeXRJRkNnV2h5azJrbkRldGxh?=
 =?utf-8?B?MTdMenJLZ0o3UmNSRy91a3VnMFl5Tk5lU2pqMjM3QjNaTkVtN2lrYmtteDRH?=
 =?utf-8?B?WmZIaVNSUnduWEJibXVpZVVzY2x2b3RYaXNFalBqa0tSWjhBU2lVNU9WZlJ5?=
 =?utf-8?B?ZlVQbHVkYSs2ekR2aEYrN0FRYVdTNjJkNGpPRmRQSm41dzYvNlVMenFDcVYz?=
 =?utf-8?B?bHRNYUY2K2JQWjJHNGxCRlc3VHRneUF5MEh3Tkw4bGVFK2NkVVU4UU5pSEht?=
 =?utf-8?B?ZmhRRnZMTkRrRlhGbVRyczFJWUFOSFpBbFMzMTl0NEEzVEdpYjNxcUZsUTdy?=
 =?utf-8?B?ekY0L1NnUDRpOW56aWZDSUlJeHUvTzJ2SE54eUZLZXJNY2RzNzhVRFJaYmhB?=
 =?utf-8?B?ZWtrcW1LMXM3VUNjL3JOc1JuWDh2OW5SR3ZoQ3ZZczJZTHZHWVd3OFNaK2p6?=
 =?utf-8?B?ckFrMGt2YXM1RUNINTBKR2psaG1XdXN2cEZmcUxXQjk3OVFjQ0NVUS9nR25j?=
 =?utf-8?B?dXZadFEzUUIyTVBjWkJWOE13N2VhQUNSYlBPNVZXY1BkNnN2ajJCSG1yOVRi?=
 =?utf-8?B?NmdVZ3F1S3NWVzhhemlkL1RjUGhWSTJ3aExiSTg4MFdVSHcrR1UwdlRnTDZH?=
 =?utf-8?B?Q0sxcnB3RmxFMmxZYmhnY1dtQW5SRzVqOVFUSldZWmpTdHRIbEhOcnFzUWRM?=
 =?utf-8?B?WWpTRXNpSHF5bjNzdTBVbzBnRldWTTNjSGVHRDFWRFM3allkQnpiL0cvOERU?=
 =?utf-8?B?NHlnTGEzd2RzQm5Md1dhMFhlLzN6ZUgxSUoyWE10cUdjeVFrQW5FeWx3Qk1k?=
 =?utf-8?B?UERNRWJGZVkzMzZNT3VpV0pHWnltUTc0QjdLaS92T1lzLytKcEpZTzZ1NjFj?=
 =?utf-8?B?cEgrVCtYWkU2L2NPOUZxb0ZoWHN3eCt2ME44UGlGYTFZazVtcVJGb2hvd2Z3?=
 =?utf-8?B?KysxV3Y5K1ROTks1V25WY2pYbStaQkhIQ2h0MHA3V3ZRbDFuTzlUdE0zVk5q?=
 =?utf-8?B?ZE1td0lyUkFsUzFqNlF2a0dqWVF3d2k0Rkw1YWVjVnpReS9Bc2xRcUxTZG1C?=
 =?utf-8?B?eERucWR0TzU2cVpIa2wyN3BSa1Y2UFBWSStCSk0yVDVTaXpaTkhGaThqQ3B3?=
 =?utf-8?B?UWVqRVpyeXlIdFBnVUdqdHRaOUs1RDQzMEppblBvRFpGNlhHMFhBK2N2S3Zj?=
 =?utf-8?B?Tk12Y3RHM3FCd1B2UHY0d0wyNGxVMzFtQUJNay9PWEdQeWVmaHE2UlAwcm45?=
 =?utf-8?B?K1AvcVZYcTZPaFp3MVhMM25HaEUzL3IyK0RGKy9OQkVvNXZUcHpld2wvcmkv?=
 =?utf-8?B?dUNHbjJPZVA0VlJmaTdnTjNkeDhyYlE2VUlhb29ZTVVxOG1PMnZCcGZ1ekoy?=
 =?utf-8?B?VVNLclN1MUdzSG9nMkduRnhvR2lRTnExd2cvQ1RYYkhuQVdybFhIQ0h2Mk4z?=
 =?utf-8?B?UVlJYTNqdFo2c044WGNqNkpreVhPYUhCQ2xHdjNpMmc3cGpoY3pJaTU2R1pp?=
 =?utf-8?B?amJCR2UrNTdoR0xSNTFOR2R1U0xwUU44eDlsZDdRdDhqRFRZMkZFT0dWQzV1?=
 =?utf-8?B?dlpTWnBCcURLM0RQY09YbVNESldTbDlISU1HZUYwOFRmQ3R3UiswUmx1dzBQ?=
 =?utf-8?B?RGJIb3FOL1NGMkFKSGoxaWdPS3hFUzJWelRCYjBubC9rNmc0aEhGemZlNzFx?=
 =?utf-8?B?YWlQNmtscHl1cWZoRWk5TE8zN2xOOWlLUUp5WFlkUTAxdkxFVExlNGJaS2h3?=
 =?utf-8?B?RlVRdjJLeTZzc1IySlpZd0NaRjN1STF1SnJ4M0JrUXFZcGxaaUVLVXpONENV?=
 =?utf-8?B?YllsSmRVVGIrWFViVFF4WGljeCs3M3UxWG9peExreEFISHhuWm5VMWQzby9q?=
 =?utf-8?Q?JbwQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8a5e06-891d-4607-aa50-08dcc05daa16
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:46:09.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOivcvp3BhZLWPnxn6kf49rtlHWdx0x8sBLEeGgF/wayjRVZST1uHQ3pcdfGR11y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381

Hi Reinette,

On 8/16/24 16:29, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> The cache allocation and memory bandwidth allocation feature properties
>> are consolidated into cache and membw structures respectively.
> 
> "are consolidated into cache and membw structures respectively" ->
> "are consolidated into struct resctrl_cache and struct resctrl_membw
> respectively"

Sure.

> 
>>
>> In preparation for more monitoring properties that will clobber the
>> existing resource struct more, re-organize the monitoring specific
>> properties to also be in a separate structure.
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> @@ -182,12 +182,21 @@ enum resctrl_scope {
>>       RESCTRL_L3_NODE,
>>   };
>>   +/**
>> + * struct resctrl_mon - Monitoring related data
> 
> To capture that this is not global monitoring data but instead
> resource specific:
> "Monitoring related data" -> "Monitoring related data of a resctrl resource"

Sure.

> 
>> + * @num_rmid:        Number of RMIDs available
>> + * @evt_list:        List of monitoring events
>> + */
>> +struct resctrl_mon {
>> +    int            num_rmid;
>> +    struct list_head    evt_list;
>> +};
>> +
>>   /**
>>    * struct rdt_resource - attributes of a resctrl resource
>>    * @rid:        The index of the resource
>>    * @alloc_capable:    Is allocation available on this machine
>>    * @mon_capable:    Is monitor feature available on this machine
>> - * @num_rmid:        Number of RMIDs available
>>    * @ctrl_scope:        Scope of this resource for control functions
>>    * @mon_scope:        Scope of this resource for monitor functions
>>    * @cache:        Cache allocation related data
>> @@ -199,7 +208,6 @@ enum resctrl_scope {
>>    * @default_ctrl:    Specifies default cache cbm or memory B/W percent.
>>    * @format_str:        Per resource format string to show domain value
>>    * @parse_ctrlval:    Per resource function pointer to parse control
>> values
>> - * @evt_list:        List of monitoring events
>>    * @fflags:        flags to choose base and info files
>>    * @cdp_capable:    Is the CDP feature available on this resource
>>    */
> 
> Please add a kernel-doc entry for the new member.

Yes. Missed it.
> 
>> @@ -207,11 +215,11 @@ struct rdt_resource {
>>       int            rid;
>>       bool            alloc_capable;
>>       bool            mon_capable;
>> -    int            num_rmid;
>>       enum resctrl_scope    ctrl_scope;
>>       enum resctrl_scope    mon_scope;
>>       struct resctrl_cache    cache;
>>       struct resctrl_membw    membw;
>> +    struct resctrl_mon    mon;
>>       struct list_head    ctrl_domains;
>>       struct list_head    mon_domains;
>>       char            *name;
>> @@ -221,7 +229,6 @@ struct rdt_resource {
>>       int            (*parse_ctrlval)(struct rdt_parse_data *data,
>>                            struct resctrl_schema *s,
>>                            struct rdt_ctrl_domain *d);
>> -    struct list_head    evt_list;
>>       unsigned long        fflags;
>>       bool            cdp_capable;
>>   };
> 
> Reinette
> 

-- 
Thanks
Babu Moger

