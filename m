Return-Path: <linux-kernel+bounces-295869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A457995A24D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234721F22201
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9470C1B2EDE;
	Wed, 21 Aug 2024 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K5bYzY6Q"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58C15099B;
	Wed, 21 Aug 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256070; cv=fail; b=Yi/NNfs24anPe142h+vP06ZgVHXW4sRdxzxxzlO04zJfmPRChTCUgRFyTtMNGyindFWJOyIs9u8A9Ja602j9YGwx6pJ+tkNEi8TjzSb6TwBaJWyqlljH6YL4sKOv2bQwj3MnqrGrWgty3Fex9DpdTrphBYpO+ibS94YauZscZbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256070; c=relaxed/simple;
	bh=nkcQ2O17DvXUdJp+hScT76g1pUmsT+3hvyMoiCR4Vsg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MyvY9ot18x1sLfXZ9GL3IsBiL6E98eVOeZxj5sTQKatiTkBOpYAdeIlpLf6mZyUbmw+z183reTiaI60T1goxr+/+iPbJ8dkxDRIksI4DA1UnBIAsIzfqe7o1dpdkIhbVVFUE6yGEh9A9wX1dzLrE0ubHFgJqPw8Ro8cW74Z4ugU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K5bYzY6Q; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olydeqIPzPiVcDtp8ASTeh+CbnU2HoGNA3uA92FLvSlUjoyrHA0vNOSiLihCKjvE+P2fjCJC6URREOHlskMVkKSDQx1K43RRPqOhcVO8y+bc7lSrE2wNGVnehova5weLc/uAJOnd9SNKkhLSdh+8Gwn43BHJDNGq5JbDi7JCkF3YOw9YvPJPwgXn5NbDOTZq01/Z4hcNfaSx5s0BEZP/b8r5BNfm4nKO/5QG9q8yohWWMb8SELMm9GUEep0cd6E/EghgGdQDEqeX1RlBtegYUdhZTaiYD6KeDnLrS97KkTdGbn8Pytxt5NJ6WrDerlNutSU98ONYQDBF/rgojlg6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlfLDePDysXK1WvqonfbXFUCBf18tvU8P6kYrElkliM=;
 b=oK6wKoKFD9457TzZPeONN1h3iZPkJ37F7gtpnkkyBxdsqyA6LhXNwxDIHMW/sZpwchgcpnXK1zrmigycaia7y9vQ21pa1IGd0CNanFHwt+uGAkcAb0tOWVNaVbJExLf+0qpB+EfMFB6ROdQZaS2UCai3/Sl8zVskqHEdObTpE+SI0h25Fjc9Fp1IBNbJN+x36NGIkmKRAUJ1P7jVN5aBR2wJOvxxRvLKdjjXUxlper8aX/LV5jBg+M9TvS2T/kOozQLIJ7qIBEtONU+VEs11Qle0N4ZZ7R6dVB+6kOQJFyO2hZjmDzzoQ5LL+E7/l2nlFsAShYc9puX7ECyXeZkKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlfLDePDysXK1WvqonfbXFUCBf18tvU8P6kYrElkliM=;
 b=K5bYzY6QkLElUEZeBlr/lyF1+Ub+UMApD+4W5vDtfByuk3oG2IJeRtGls5+9KpXpnutYH8FysZkxjAeeMfMFhEFMvjkQoj4W06xDKo6UzFUQ5hXQVACUcPD0Wm2xav9k4mdTx9IbVDEMyCAEpTC18QaE3chu+hfy5b3B0slKZSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 16:01:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 16:01:05 +0000
Message-ID: <f4d5ddac-9399-4581-b914-ddebe1824463@amd.com>
Date: Wed, 21 Aug 2024 11:01:01 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 16/22] x86/resctrl: Add the interface to unassign a MBM
 counter
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
 <09da6e20b695086558d6cadefbc4830961e6e60b.1722981659.git.babu.moger@amd.com>
 <e2b9bcd1-4b5d-4eb9-8e3c-604a4c5cafe8@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <e2b9bcd1-4b5d-4eb9-8e3c-604a4c5cafe8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0138.namprd11.prod.outlook.com
 (2603:10b6:806:131::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1cae21-00be-44ed-1ca2-08dcc1fa7687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWxlM01JZnNjQWdRQk9JeGpZdENzNERmcHE5dmYvOFZ0UlEvbCt1OUxaVngw?=
 =?utf-8?B?RUp3c3BNck9EZW5Ebi80Ulh6OEhxUHFJZzl1b09YQUY3by9rTEdBOSs5QnRH?=
 =?utf-8?B?SWNMOStGT0hORzRyTE5WbmpHemVoaWh6RlNjb1FRMHJXbFNwZjZVYXVKZGQw?=
 =?utf-8?B?eTlqQU9jcnliR2owdWNRcHRoSGk1OVdyNG03eEhCK3BRZkVKZWdHOWZwUGhl?=
 =?utf-8?B?RmNQT1pRWVJmR2lBQWFNV0JxRDd6czFIblBrUVZZMUdtcTlFRWZ5UkJjN1Rl?=
 =?utf-8?B?OENjQ21zV3gxcExsNTM4eUZmVGNZWnB6T1E3cmJLU0FtNnhvR3Vsa1o4V2Jq?=
 =?utf-8?B?d09iNjQwNi9qd3JxMFZ4dlEzaTZmTHZqU3czbTFadTFNTmhZWlRsZW5yRVdK?=
 =?utf-8?B?eVE5WUUwODV3eXZNVVlseUNUU29MektFNUtYNXVZS21zeHBnWCtac2FhcUFu?=
 =?utf-8?B?VG1NQzNOS0NybXNJRmRpaXJZa1pJUkY4UHZDYzFEWGljWDhzaTNaYmtjTll1?=
 =?utf-8?B?dStYSnhzVVVDRWVhN3dLSW5lQmNFWXZRVzJ4VjNRTGk4UXFOS1N1N3lLWFph?=
 =?utf-8?B?N0hleTBkcUordW1rdUEraW5OaVdkSlFlZHNocjNFL1ZLRm5ObFRDS0pGdjJC?=
 =?utf-8?B?TDRqOWp2c0VtclVsU3Zrd3N1TWo5L21VNm52T1VIcTYvZkVIRlBqemx6RVA4?=
 =?utf-8?B?dDY3NjdKNlY4aGxCNGJyM3dsRnZwNHY4OGpIaFZCVDFRKy95UXpEVmZ0SmxC?=
 =?utf-8?B?VUNmQkRPWDI2OG1DVmJGdlp1bmJCWElCYlNINzI2MHJCVlY2cTdVTHlPSEwy?=
 =?utf-8?B?dHJJWWFWaktMNFJoMmtpVmpzaFJHTjUxZVNsSXNTd290NDhqUTBTc2RUbWdl?=
 =?utf-8?B?clNuc0NoUFV0WElxbmMrRnlZdGRSSFM0Zi9oc2VXbHNsY1VRZks0SEsxNWxN?=
 =?utf-8?B?NmphQ0tkY2hvVThGcHRYVjJqWm55VkREVGZYTGMxK3ZPVXpIKzlQcWROTWRO?=
 =?utf-8?B?bnB3bklZcUlUV0tuQnRmTDVEUEU2QkdySGIwK1puWVhWUGx0WHNnYTVJUzhJ?=
 =?utf-8?B?L2VldHZRNlVJVFVvMWI4SGJFRm00aXg1Z3FWVkoxZVpVd2svdVdqWWk0Vnpr?=
 =?utf-8?B?cVo0UHdGM1Rwc3l3VHpIMzJaSmJ2N00xWHFnVDRlcFIrS3dVdGxkRXJKUlB3?=
 =?utf-8?B?cStvT2pQaHFQamRxeE5lTktUSHV6cm4rYjVkcTE3a1BQSHFiRk4ycnVNWnd2?=
 =?utf-8?B?TExPY2l3S0JERTNKN0JCci9ONjdaWnQ3QmtUa3VEeHQ2Y25tcUludG1hai9i?=
 =?utf-8?B?bmpXYVRFbW1IODBGVGRiM1ZEVlBmS0xhM0lyWWZNekUvOU9UNlFZTXh0d1Jm?=
 =?utf-8?B?NmdtZE1FNHpYQjAzNjNsZXZvR205eTZPa1k0eVFndEdTKzFuUlEzaTNURm1V?=
 =?utf-8?B?SVF4M2wxUnhXbnp1ZEROb0tZRmcydDZ3SkJIZkdlZjYvWm8vc0ZsczQ2S3A4?=
 =?utf-8?B?SlBhM09XckEzVTRzZEtjMjN5VkJIcFhCbWE2YnlabGhxMkFoeDBBRWhRMVQ1?=
 =?utf-8?B?ZDMrbVA0YWRRT3JmUWNlU1J5VzhJV2QzblkrbytkTi81WnZjcWlMU1puMW15?=
 =?utf-8?B?U0hpVFRIT3BiOEJ4QlA3bWhJbWE3ZzdHTTlGcTEzMUk4bnFuOGlydEx4NXNB?=
 =?utf-8?B?VlBzb0svaTU3Z0piUmZtclUrejMxQUlIK2hBOE5UT2FjTXo1d2FqYTNpUjJW?=
 =?utf-8?B?b3hwRTVwZURYdjNVWVRaM1FTcXhNbkRJZ3UrWmdrMmxhejVsQzFJajRYZGtm?=
 =?utf-8?Q?FMqFQZQEzl6aVOg3l7lgUQ+nSlwZ4aDhu7MLk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjlvWGNTS2wvcllCQkhnUUJRZ09vdjZibTdaOFo5SUdmU2lIb3FmNFdiWVZr?=
 =?utf-8?B?cXY2S21iWG1nbGhXdjdNZkFBc0cyK1d0a3AwSWxXS3p2NGJmbXRPZVdpOXJJ?=
 =?utf-8?B?b09lR3R1ZlRiNEUrUkFBNEdlZk80emNHNnRrYVB5NVcwTzA2a1NkZmdmMXl1?=
 =?utf-8?B?WmdHV3J5MVlEYnNDcG9FTlllOGk2L0tRRmtGZ0M5aklzVzZUa09ROTkxcExo?=
 =?utf-8?B?UDErMjFaclZwS0RGbldNVmU5VS9aR3hqazZibE81M3hzd0hzZEJaSGgwaFh1?=
 =?utf-8?B?Q2lxeFZzTDdwVFJpaVRoQ3hIOVBlTm9HeTRPNHcycU5Mby9wa3Z0dU00djdk?=
 =?utf-8?B?ZFN1TVA3UlVPbEkxeklmQ3ZFSDd2bVdJVks1NEk4Ny9UalNEVzcwZVU1WUZt?=
 =?utf-8?B?ZEhhUTk2ZStyZVBrdTdxdjFobW9IT01EMGRmSWMwZE9yR2ZhOHJZMXpobGxa?=
 =?utf-8?B?cGNJeHRkNytUTDIxeWd5bm1ibkVsSlkxT1duaTI2K2Z2cDdwd0ZQb0lOdS9x?=
 =?utf-8?B?TkFLWXdtdFN4cnRjVnJ5Z1pORERVOE56TlJpS2V5d2ZQc3Y4WUg2TmJaU1la?=
 =?utf-8?B?dDA3VDQvVUF2WW1WT0hmSUR4VE9BQk1wRndDOXZBTnNuaFhqU3QzVXBVeFA4?=
 =?utf-8?B?RHRjaUZxbWpDbUQ1RFhvRUR1cTlnMUtTNXBxcmlyTUZGU1c0YTdwelNIUUp2?=
 =?utf-8?B?dzNrRjZVc2txWC91dncyL0FxL1pOQjM1SG9iT1JKWUlrYko5VlRvNzBXSEtV?=
 =?utf-8?B?MHM5Ykg3SVdUYi9nMzhCck9NS0JRR01aNWNBdzIzdDFMdFkvVGRETmxpZU83?=
 =?utf-8?B?NlF1cmZVUW1aaDhVcThtbjJVNnBOblA3MjZKTEJpS3dhM0hFVzEzSHl2Vnpo?=
 =?utf-8?B?RmM5eXJIRjF1OXBCUnd3emcrU0JmZmVnM1YwZU9LR1BtSTNqb3VTa1BPZFVr?=
 =?utf-8?B?RVd2Y2h3dU5QZ3FYMlNna0RLWjY4MEtwalJNMnQ5MzB3RXVlczNyNjlRcTd2?=
 =?utf-8?B?NzFjd25ZTFBPb2NXQTBjcnZRV1VmZmN0MFhaVUNnWWE4QmI2aXNKN1FldDYy?=
 =?utf-8?B?Ri9mRlRwWmFYeUZFTW1TUkxNR251WE9pT0ZLVHZhMzFRTHFJT0diYWozRXJn?=
 =?utf-8?B?bDBuYUhDUFp0M1RidzRUeEFyeHltVTdNcStIUFpCRndhVU40MGtDQ01UWEhJ?=
 =?utf-8?B?bGpJdXI2ampCdTZETkdxYnI0RHRPbHYyNWlQRUo4MmRwM3BSVmZUdHh4Rkl3?=
 =?utf-8?B?R0ljekFzU1JaY3prUWw1c1VYZ2plUE4vc05KS2RvUGthSlpZeEhXTDN4NFFT?=
 =?utf-8?B?QXk4b0pLbHpTZFRseW16RmNiTVl2bWRGU2srVWx3VnlPb0IzdTNNR2dWallL?=
 =?utf-8?B?czcyT0JEcTRvYzJoVy9oZ1lHK1VMRitkSFlYdmx1RVVFWlBmbk9YbkxEdERn?=
 =?utf-8?B?a25KUUdSZFRLR3REeEUxanZPaXFDZ2NNZWZ0VDQ4UC9KMTU1aVNJNis5bWtH?=
 =?utf-8?B?WE5leUtSRllPZkhaYnFKTGhhRmNCMnUzNG15OVJsVHI5WExsOGpCVEN3djU0?=
 =?utf-8?B?bG51amYzSkg1TFFEaEJ4a0orL2MySnI3T2FpQXJDTHNpdzduYjdyMGZMM0tS?=
 =?utf-8?B?ZXhkOWIvREdXVmhERU9tL2RqWHlJQ3RVSi9pbElmR0RLNUYwTXFXdjY4Qi9M?=
 =?utf-8?B?ZVhnOEFJTTRqTVVQcEVYUlkzS2Nkcmhxb2Zpc3drNTE2ZERCSE95cW1SQ2F2?=
 =?utf-8?B?UHZSOVJTd2NxdHRwV0hPdGVXQ2pmTTNpZU9hVGhTalY4Q2p1azZrZjhxbVg0?=
 =?utf-8?B?cmg0N2hJY3U3U21lUkErV1djdUFENVAxbkJubDdXbzBMRlhYZHdlazU3clg3?=
 =?utf-8?B?RUVtcjF3UGl5ZUd5L0d3UTh0Nll6TjZZaXVjdnNNSm1SMjA1Y3owd2JIN3JS?=
 =?utf-8?B?Rk1hNWt3MVVSUFFqUnNSM2dwalNFcnNpa3NsbmI3KzBiUXh0MEdUdGlpbWVY?=
 =?utf-8?B?ek5TRjFKaUxIbnRsdCtKV3BPeElmWmRJNHBLMnc2aEVLT3RMSVFIYzNoaXZu?=
 =?utf-8?B?RjZsaStrL211QU92azlPTk56VGFaREIvN1BtSHo0TVluSFRLaWIrZDBSWW5R?=
 =?utf-8?Q?ncoY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1cae21-00be-44ed-1ca2-08dcc1fa7687
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 16:01:05.6026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cu5AOmBNU1unFPjVbHDrZ7ZCs50fEmiQQNWF7sIq2UmywVDND9XcEqeYw5al3u27
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138

Hi Reinette,

On 8/16/24 16:41, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
> 
> This is about resctrl fs so "The ABMC feature" -> "mbm_cntr_assign mode"

Sure.

> (please check whole series).

Sure.

> 
>> counter to an RMID and monitor the bandwidth as long as it is assigned.
>> The assigned RMID will be tracked by the hardware until the user unassigns
>> it manually.
>>
>> Hardware provides only limited number of counters. If the system runs out
>> of assignable counters, kernel will display an error when a new assignment
>> is requested. Users need to unassign a already assigned counter to make
>> space for new assignment.
>>
>> Provide the interface to unassign the counter ids from the group. Free the
>> counter if it is not assigned in any of the domains.
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>      Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable
>> Bandwidth
>>      Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6: Removed mbm_cntr_free from this patch.
>>      Added counter test in all the domains and free if it is not
>> assigned to
>>      any domains.
>>
>> v5: Few name changes to match cntr_id.
>>      Changed the function names to
>>      rdtgroup_unassign_cntr
>>      More comments on commit log.
>>
>> v4: Added domain specific unassign feature.
>>      Few name changes.
>>
>> v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
>>      The function is not called directly from user anymore. These
>>      changes are related to global assignment interface.
>>
>> v2: No changes.
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 52 ++++++++++++++++++++++++++
>>   2 files changed, 54 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 4e8109dee174..cc832955b787 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -689,6 +689,8 @@ int resctrl_arch_assign_cntr(struct rdt_mon_domain
>> *d, enum resctrl_event_id evt
>>                    u32 rmid, u32 cntr_id, u32 closid, bool assign);
>>   int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum
>> resctrl_event_id evtid);
>>   int rdtgroup_alloc_cntr(struct rdtgroup *rdtgrp, int index);
>> +int rdtgroup_unassign_cntr(struct rdtgroup *rdtgrp, enum
>> resctrl_event_id evtid);
>> +void rdtgroup_free_cntr(struct rdt_resource *r, struct rdtgroup
>> *rdtgrp, int index);
>>   void rdt_staged_configs_clear(void);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 1ee91a7293a8..0c2215dbd497 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1961,6 +1961,58 @@ int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp,
>> enum resctrl_event_id evtid)
>>       return 0;
>>   }
>>   +static int rdtgroup_mbm_cntr_test(struct rdt_resource *r, u32 cntr_id)
> 
> Could "test" be replaced with something more specific about what is tested?
> for example, "rdtgroup_mbm_cntr_is_assigned()" or something better? The

Yes. We can do that.

> function
> looks like a good candidate for returning a bool.

Sure.
> 
> Is this function needed though? (more below)

Yes. It is required. It is called from two places
(rdtgroup_unassign_update and rdtgroup_unassign_cntr).

We can open code in rdtgroup_unassign_cntr. But we can't do that in
rdtgroup_unassign_update. But, I will check again for sure.

> 
>> +{
>> +    struct rdt_mon_domain *d;
>> +
>> +    list_for_each_entry(d, &r->mon_domains, hdr.list)
>> +        if (test_bit(cntr_id, d->mbm_cntr_map))
>> +            return 1;
>> +
>> +    return 0;
>> +}
>> +
>> +/* Free the counter id after the event is unassigned */
>> +void rdtgroup_free_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +            int index)
>> +{
>> +    /* Update the counter bitmap */
>> +    if (!rdtgroup_mbm_cntr_test(r, rdtgrp->mon.cntr_id[index])) {
>> +        mbm_cntr_free(rdtgrp->mon.cntr_id[index]);
>> +        rdtgrp->mon.cntr_id[index] = MON_CNTR_UNSET;
>> +    }
>> +}
>> +
>> +/*
>> + * Unassign a hardware counter from the group and update all the domains
>> + * in the group.
>> + */
>> +int rdtgroup_unassign_cntr(struct rdtgroup *rdtgrp, enum
>> resctrl_event_id evtid)
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    struct rdt_mon_domain *d;
>> +    int index;
>> +
>> +    index = mon_event_config_index_get(evtid);
>> +    if (index == INVALID_CONFIG_INDEX)
>> +        return -EINVAL;
>> +
>> +    if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET) {
>> +        list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +            resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
>> +                         rdtgrp->mon.cntr_id[index],
>> +                         rdtgrp->closid, false);
>> +            clear_bit(rdtgrp->mon.cntr_id[index],
>> +                  d->mbm_cntr_map);
>> +        }
>> +
>> +        /* Free the counter at group level */
>> +        rdtgroup_free_cntr(r, rdtgrp, index);
> 
> rdtgroup_free_cntr() is called right after the counter has been unassigned
> from all domains. Will rdtgroup_mbm_cntr_test() thus not always return 0?
> It seems unnecessary to have rdtgroup_mbm_cntr_test() and considering that,
> rdtgroup_free_cntr() can just be open coded here?


Yes. We can open code here.

> 
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   /* rdtgroup information files for one cache resource. */
>>   static struct rftype res_common_files[] = {
>>       {
> 
> Reinette
> 

-- 
Thanks
Babu Moger

