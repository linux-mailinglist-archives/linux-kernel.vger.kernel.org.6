Return-Path: <linux-kernel+bounces-263862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C1F93DB95
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196C11F24670
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6F917D8AD;
	Fri, 26 Jul 2024 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WTeteEud"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4117D362;
	Fri, 26 Jul 2024 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038011; cv=fail; b=ANiPHFZrw4TKai/gW2RPel4LVy7Dp7H5cbbFnJ27AszyZ2CG4+qRyW6SOVFWBmkWKwtmRRNz1nh/tIM3VY7k3EshpVN5P1bA21zCPYKkCQxKK5+rGSjmgF4jWfn+ywyE+97/nesWL9HObgrcbMoQrFUetgFCOIztRqMIBkAwPb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038011; c=relaxed/simple;
	bh=OudJtkZbH7L8rqWZhjnJHNqq2Ut/QZb24wK+S9X+KNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hWga1KsmZwnt34107eN+sumBplg4igHFMBik3NAyksF+ucFGrx+s0qP1aOrrQm4f6KyzSyTjDIfLbZupR7IZ1X/lHlaKpVTBgrTvnwdlztd9WtmIUo7JUf+d4WOHekOnagCE5bx7S3nSyLQO0uns7Vfv6lFlKVZxqb7N8pLtIRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WTeteEud; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUzfP/wBEdS4+juQ2tMOSdAQJHpXw52s6fIgTu+6mJj96Ghhd8muKko0siNi+2ihI0E7mSbn3egvLiHzoVjagfduP9pmeHUyNAKiWU0Ca2NDxXFwf4j3IbYZ/9viyCteSn5bKaTuVePHhnWIZSdRCxPcoz0iqRY7i1C6pdyoVjEP3OagfYSXOxmny5t52yQgfBELzJAv3ZDodqudMLqO30e3d2VB2j+D3m2h0d8peqqnGdMJdzRYRtuwdZg90Ho77W9wa8xG59vpN2300tg6TxmQy9lt3XyFgCE4Cmm7UKwzVCURDmXCuHMcqG8AMlssORdM9tpstaG7nSdb0GOZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuOBWQXWEWjudgJzSuptNGPkaGjSriBJEXU7oAZy/M4=;
 b=c2jncavUrhWnjajHbjU9lUFy2rQ/shZ9zLOXkkVL64jsJq7HvdiT2jFRlpMhlzvOSBOZZe+UpjekPrmOUzf36iUsPtkSLuVPE1izUDLEJptIyaSH94nqsIQJgT1spjUiGOoGOcmaT+s0fvpSaUQe6ix6155T6eAhgagS/QWkxcN3BgfISj2dR05ThamC8xmW8Nq9zlyqN9GycQQF2k00IxSmhbclz+Im4JWuPCA17/UbCVztWjA3/DYj8SO8wj+PcksTzlmhEf0pjuB90R1UrmYNWUMjGorkKSxS1nOZU3QMjQ7W8cJp5sQFypkx2VhpnP85pc60agsuJOQemyVT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuOBWQXWEWjudgJzSuptNGPkaGjSriBJEXU7oAZy/M4=;
 b=WTeteEudcleeHoJSGFzoF1dWF8X/3naCKIDQm00mvWdzwI0carpdSkb7iOT3bxF0fY8QCi2onKy04tP3mWTZVjmmvTaIYJvptvVQlY/YuY+CCVy73dMYwUX4mhkJp8SKX6LL6MT97vKWy8X6u7LZnqmYHvJg/09/lpNo0WOLnSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 23:53:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 23:53:25 +0000
Message-ID: <8a14e6d5-a1cd-2452-ebd5-e5031fba40d5@amd.com>
Date: Fri, 26 Jul 2024 18:53:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 09/20] x86/resctrl: Initialize monitor counters bitmap
Content-Language: en-US
To: Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1720043311.git.babu.moger@amd.com>
 <28866653751deb8405f575e40df6f08affdb25d6.1720043311.git.babu.moger@amd.com>
 <CALPaoChGp+JHeyxsqDvix=t=ik5eTqc3bf+ihUL=RXx5p9r5Cw@mail.gmail.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <CALPaoChGp+JHeyxsqDvix=t=ik5eTqc3bf+ihUL=RXx5p9r5Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0198.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d41e19-3399-4dd6-ecd2-08dcadce235e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djZGczl3ZzZ1N0FudTZKdTVNRm80T21YQTFTcC9Kbi9uNGQrNzU2a3JPQ2dl?=
 =?utf-8?B?ZzRxREJuUDVzSGFHYkxucDd1S1doTlc3WEt1Q0FtbE5LbnRqQWRzMjA5Nk9s?=
 =?utf-8?B?L2VCZDFMZHRaa0FSYmRsTWlTbnFiL29SZ0JzcEFYWFJkQlhNMVA0VzFyRzlG?=
 =?utf-8?B?cWs3WFcvd2x1c1Z6NUIzV1BQS0cxOU1hbnQxSmZJVWwrWXJpYzcxYURaWjJv?=
 =?utf-8?B?S1FUeXZHNnM2b0NGWUQrcVROT3BJR0h0QVBGdy8vb1hoZUxidW5nb3kzejAv?=
 =?utf-8?B?SHlkb0l2aEtucW45cWNzSXV0d3locXBoS2FUQ0FiQjFYY1AyNXl1MnFWUm5q?=
 =?utf-8?B?aUY3Wlk3cHBiL2EwTUJnUFlIemVCUUJwZXJEYkpwK1JuMEp3cTJzeXU2VDVi?=
 =?utf-8?B?cW5vQ1hKNVBteXk0MTE4UXBDUVRnbHhGR1dKTjd1NUtnKy95NW83YUw5S0hM?=
 =?utf-8?B?R3piZWdwdnRZSnhCSy81OUZQWFMxRm1YcXRnQm8vUTQ3TmpRUktGdjBZRUFo?=
 =?utf-8?B?OVloakFVR245VUhCUStESGpOdjczOXdjeW1jZ09kTXAraTVNakNSQVRRY3hu?=
 =?utf-8?B?dnlUcThmak5TTEtLbDA2SnZNU2hBZTdDMjgvSk9vdTNETHRRVXNQZUQ0QUdS?=
 =?utf-8?B?WTBuK2NLM0RBZFh3Z3lBTVAwRElibTg2bnkrZlRXQWF4ajZ5SG9UWDVCTnRy?=
 =?utf-8?B?b1lpOXFvMW51WTNVZ0x0cXlIT3kwT01zbU1WYzArMi9UT2k5bnBmeFU3UHJP?=
 =?utf-8?B?TGFzTlJUSGs2OFdNVFJ4MUJWUkFZalpUT0laUWkyTVVmc1RuMnV0Q0pWWlZ6?=
 =?utf-8?B?VW5VYWNORWVkU1hqMllkaUVwRTh4S01GOVR0NXF6eVlITWw4bGtYd2lZR3hG?=
 =?utf-8?B?aVp6T1o3dzRFcmxpUlh6aU5jL2U1dnJPZ1RVdWkrbVNDYS9MQU1PU2VNRzNa?=
 =?utf-8?B?YjZWWFoxRU0zZWxwQURIRmhYYWxZQTJvQm5MdlovQlkySXJKUzNMNUY0MEpl?=
 =?utf-8?B?eVNLSUV6amZYZjJvRVJxMzBjaFlwRzhmQ1RpemdJVGlsVmc0TVZySVQ0WFVW?=
 =?utf-8?B?V3B2am1STmVQVW5NbGpiNEhjbnY2cHl3Qzc5UXlkVHJtVDFnMktpSjNjb3N6?=
 =?utf-8?B?cUE3eWlSUEJxdVlmaTJYSnpLMzNlamphSU9KbDdabVI1RXFjSldkR01OZ0xD?=
 =?utf-8?B?WTFxbE5vZGtEb1dNVWJFY0x6SVNHOTFUckVBeHhCVTNNR1Q1Q29Xc2ZDTy9i?=
 =?utf-8?B?VG5iemZsSjBwRXFDeHhCcWZUZC9JSFptRnNlbzJHYlNBMHBKVUdCS1Z6ay9N?=
 =?utf-8?B?eGJIL2liT0xOSkd1VW02K0JqRmdNdE5Kb285T3BPSjIrcWlPZE1JOVVrQVBI?=
 =?utf-8?B?d1Y4dElYRTZNNC9VTVIrSkxURXBiZ2tSQ2lRdlN5VTk1K3lmdnRLaWJ6QUQx?=
 =?utf-8?B?U1JHdm1xZVp4LzJKZ1hQRFM5T2FhcGNDN3hjVUI4Z3N3ckozTktmelpLYWNo?=
 =?utf-8?B?a1E3NUpnTEozMkMxMWlpS0VocFdtaDducDlveUZzY0JEWnNrbEZwNWdXTG9h?=
 =?utf-8?B?dWw0Q2RhbTBnV29IN2Y2UFltTHg4Vit6cmpKNFluSjRMcXVmTHNQVHM5MDBL?=
 =?utf-8?B?aHBWd2QvZmJhb0xOelJPT1BHTmRHUEoyV0twQzhKZ1k3SzlJWk5CdFlyZ2Vz?=
 =?utf-8?B?UTNyRUNUSGMyc2YzN2RiUW12RXppemhsVVc2Sjd1Nngrczc3TStpRUtxRGhj?=
 =?utf-8?B?TE9uTmV4S3g2U2diOVJzY2tQM2lCaG9pNEdzais3Ujg1U3gwdFlBYUNMZ1pO?=
 =?utf-8?B?UkdmUCthZWRnSGlMOFBjQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akw1VmU3QWRxOWkzRnpZeWxqZ2ZXNUNFREM2RWxPdGZmQ21PQzNNcGxhMGZu?=
 =?utf-8?B?bmQ2QldzRUZRUkNlcStKWEtFaGR4a2Mwdm9hNWZ3djRCdVoxaTYycE5YVlVV?=
 =?utf-8?B?SWZ2RWliMnFmN3BzZDJIZVZoWVNEaDVSeDZZUTRPR0xROFRGTTBtK0Nzcml0?=
 =?utf-8?B?TnNaTFBINjcwb3NYZnkxUW8vaHI1cTNJY2tBVUhUa281bmVZU1Z2b1pLbC9u?=
 =?utf-8?B?UWVacW5aRjFJTGdMTDhHM0pOcEFqREdHYitVVW42UlNzMXl3QkdNN0VRelZV?=
 =?utf-8?B?UGkrbGxoeldEOTQzbnlTNGhBMHpiNjJIdGN3ZEg1T1A1U0F0c1RQUWlIajli?=
 =?utf-8?B?Ni9RYW9MNUdYT21HeVprUlFlSCtybjhxU2FybEEzRklWc1QxbkNiaTZBQVdk?=
 =?utf-8?B?enUyQ2VNVUU4cWdnYkJJM0JGSkcyU0pFL3dCVWhnVk5yRXZjbFcwaC82S3Nh?=
 =?utf-8?B?UU16UFQrY3pkWFExcWVuUG1hV3p5TDBQNjVWQWd4KzBaRVJNNWtBR0VoSmNR?=
 =?utf-8?B?ZTR1a0k0ZVVPN1g5Z0VUVW11QUhqaGpwcHhlbEpKMGlSN1pjRHUyYVFFUXd4?=
 =?utf-8?B?ekNFMnVST1ZjSVZuckMvWnNWWEZBUUpCVHRJSmJPY1VJdWp2dEVFVEMvN2pV?=
 =?utf-8?B?ZGJJcnA2eW9yTFY3VlhUMHpQQzNhWXVYNzhjS1J5Y0JaWUNxWDRlM0pwK1Br?=
 =?utf-8?B?bW4xb2hkRlU1OGI5V25hZ01BSGRZbDJ1K05lMTcvU2dGVFI2bk5QWUkxMEhF?=
 =?utf-8?B?N0hoN0duNHEvTldWNW9nK0c0T2dIalF4cUkwQTg2QytDRkhtODNTcGdielZn?=
 =?utf-8?B?RjBpUTNhRVBSUVdVT2UyUDlFTE85eUg4N0Q4MzlOSUx0TDhOMXFtVHg0V3Vx?=
 =?utf-8?B?MmVDNDc0aStRd2F4eGdPM3BYTGJhVlZUeUlEZmhYYzdYaENqVi9rWFI2Z2FG?=
 =?utf-8?B?S2ZqWEE0Y1JTcXh6QmV4aEZNaSttYzFxOG9Ca0krV2dxQ0VqTGJ4Zzh3TTUx?=
 =?utf-8?B?RGwzZEJaZUJhQVJpUjU4S1VYZmF2dFo0R1l3ZElQMUFLU1loL05wd2xmUmdX?=
 =?utf-8?B?MTRDdEs4UitFaXdSMzNTbEVUaXYxZ1BVSEVDSUJ1bFgreCt5N2JTS0gzSlQy?=
 =?utf-8?B?RnFsQVRLZFl6SVF5NlI1bXJTQnhTc04yNXpLZk1aUmFTR0lIWW42T2YwSEhN?=
 =?utf-8?B?dWR6c01JWTY1dEVEeTdBbFk1b3NhQk00cUl5TTdXb3F1bW0xS0VwS09JZHo4?=
 =?utf-8?B?ZWxBbTIzYVg2TGdmaHV1eHBVWHdsNjFLb2RRM0RrQis0blZJUkZVUStmRDND?=
 =?utf-8?B?Um85akFad0VNdzdzemNpZ1pORENDR2tqNDUwOFZyT1NQSVUzdlhrOFdlNklF?=
 =?utf-8?B?SFJBM2VmVHZIOTVWNytrZ3pNdE1oQWgxOVcrcVZ0RFAyTzZtSWpkL0RLOXFj?=
 =?utf-8?B?K2FCc1AxNnFVaGg0VGtObXdQUGhsT1N2c2x6dk5URkduR29EbytnaVFBN2Nq?=
 =?utf-8?B?TWxtV3VOd0d3UjRiQ3NTa0g2Nm9sN3pIY3JKbThuTnZ0WS9RZjh4WiszR1ZL?=
 =?utf-8?B?dkMvaVFGM3NleWY4NVdiVmtwQVJYVlJIK1Vtb3grRTZTYVRxb0VHdGxhZXB4?=
 =?utf-8?B?eUlkZzJtd2oyQ0F1eml1QU1JSDhoWEl1T1I1Zm9hQkNTQ1hKcGZVQ3lZKzhm?=
 =?utf-8?B?RkF5MFJVM2tDNElycC9CUGhPMEowbjBZZWVXUGhIT2xFY2RRclVjL3BJWjRq?=
 =?utf-8?B?V2t4ZHUrK0RJdHN1ZEl4T1BzQzRmUzVablM5ZW9NbkVzN2ZsVkNzNlFFd1JK?=
 =?utf-8?B?WmEwYStWOEd0dHh4ZWV1Z2xLb0kxYXJUakhBY2lQZk9SVkxLalZzVnlMWlVp?=
 =?utf-8?B?Nit6b1o0WWZXSWhzZWo3RXRLdUE3UEVWb3JSRUtkWnVQWXFBL0Q5Y2U5QTRM?=
 =?utf-8?B?eklhME1tVW1KT0VBWkFhR0ZvSHBMMXBjUG01OTd6QktnNXBSREZPS0hwRjRL?=
 =?utf-8?B?aHZsZlNvclcvTWNiamw2Q2VDcGx0RkRRVUR6N2JrSkJ1WEluL09DdUFMK3Bs?=
 =?utf-8?B?MTNwRDZZM1NpMWhkeGtTVDdHV21KT1lWY0dyRTlvRjhNVzAvbWZWeTd6SE8v?=
 =?utf-8?Q?6JpM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d41e19-3399-4dd6-ecd2-08dcadce235e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 23:53:24.9908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLhaeSu6dc8OV00Yu6YOHv4avv3r/QnAoOCoNBLcAKjeyZIw39OVOHJa/wTLh5Uj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772

Hi Peter,

On 7/26/2024 5:48 PM, Peter Newman wrote:
> Hi Babu,
> 
> On Wed, Jul 3, 2024 at 2:50 PM Babu Moger <babu.moger@amd.com> wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 4f47f52e01c2..b3d3fa048f15 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -185,6 +185,23 @@ bool closid_allocated(unsigned int closid)
>>          return !test_bit(closid, &closid_free_map);
>>   }
>>
>> +/*
>> + * Counter bitmap and its length for tracking available counters.
>> + * ABMC feature provides set of hardware counters for enabling events.
>> + * Each event takes one hardware counter. Kernel needs to keep track
>> + * of number of available counters.
>> + */
>> +static unsigned long mbm_cntrs_free_map;
>> +static unsigned int mbm_cntrs_free_map_len;
> 
> If counter assignment is supported at a per-domain granularity, then
> counter id allocation needs to be done per-domain rather than
> globally. For example, if I free a counter from one group in a
> particular domain, it should be available to allocate to another group
> only in that domain.

Yes. I noticed the problem.
> 
> When I attempt this using the current series, the resulting behavior
> is quite interesting. I noticed Reinette also commented on this later
> in the series, noticing that counters are only allocated permanently
> to groups and never move as a result of writing to mbm_control.

Working on fixing it right now.

We need to have bitmap at group level(global) as well as at domain 
level.  We need to set/clear bits at both the places when 
assigned/unassigned. If all the domsins are cleared then we need to free 
the counter at group level. Will address it v6. Thanks for the comments.

> 
> # grep 'g1[45]' info/L3_MON/mbm_control
> test/g14/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;12=tl;13=tl;14=tl;15=tl;16=tl;17=tl;18=tl;19=tl;20=tl;21=tl;22=tl;23=tl;24=tl;25=tl;26=tl;27=tl;28=tl;29=tl;30=tl;31=tl;
> test/g15/0=_;1=_;2=_;3=_;4=_;5=_;6=_;7=_;8=_;9=_;10=_;11=_;12=_;13=_;14=_;15=_;16=_;17=_;18=_;19=_;20=_;21=_;22=_;23=_;24=_;25=_;26=_;27=_;28=_;29=_;30=_;31=_;
> 
> [domains 2-31 omitted for clarity below]
> 
> # echo 'test/g14/1-t' > info/L3_MON/mbm_control
> # grep 'g1[45]' info/L3_MON/mbm_control
> test/g14/0=tl;1=l;
> test/g15/0=_;1=_;
> 
> # echo "test/g15/1+t" > info/L3_MON/mbm_control
> # grep 'g1[45]' info/L3_MON/mbm_control
> test/g14/0=tl;1=_;
> test/g15/0=_;1=_;
> 
> 
> -Peter
> 

-- 
- Babu Moger

