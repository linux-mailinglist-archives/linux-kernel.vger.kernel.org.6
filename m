Return-Path: <linux-kernel+bounces-225012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01939912A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F10B23F35
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC3815697D;
	Fri, 21 Jun 2024 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QE/3YagV"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89CE5FB9C;
	Fri, 21 Jun 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984711; cv=fail; b=TWvDFYQopXtiO+oZu7h/4lYzB4vKja0heWqmK1rv4C5LRJvvDuyYHakUMYMzoxvXuiNWq35Y44x6VN0qGMIODRlxbua5zCa3peWYwymt7jjjpabSWa+ATb+/O4OLSudqmHQT0IRnWSJCcLdZ1GdbYnbM/j7/dAC25B6SNQeEOtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984711; c=relaxed/simple;
	bh=0og8+9MIOL4KlMyjmNZHVk2Q+bv+GDMRcCRCzdOp4Lc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GORluggoYncLjFC6JmSRaohuZAf1Eo0uiGiFR2CQR14WMYsiU57T/xR4O7BLXr5fJfHEKXq8082nnANE22WmtsJxwkhoQQ5xAVxICp8k1ckxoAqfaIXgVYSKtDzKNqsClWSpPYpA0YmQkW5h6mNaHRLDBzb/0E+APZ7CedQrMr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QE/3YagV; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blwKfnRVwvItXBzj77EJOI1nFi200iKa4j7qSurtKe2Ot5J9kzn8oU5KvJ4pkXXZ6+8MGrzOXiTA9mAWaW/tdYc06NBWYKTUYM3SXAQ2NmztBNav85NDLNBrDeSeImbzOLA5exBWiWX+mSzn7ZAXUP+I6U4Po6ziISO661hMOAr1s1qvdb6EzFBd3icqsC3kVZMq0ozI0NrqCX+miKltAsSqGCykgoP8lk/z7d2zSbCAoSODTx50ufBeROF+cTZg1VOJ8NL8GGcbqF1nY7UV4KApJjkxgHWh1rQhMGEIfTIe2/xuovKzJSQ4q6ELVmDwcptBdyKlgf6u5SbtNRThEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTYW570/n1ycGJBPDFyhjp5rUSjia796EqBWi+9uBUk=;
 b=GoelMztesI59UVs53S38a5yNdYOZXP8uL+8Jzayjv6H5M1/BeppZDVK5kfROEJW/2bazLJ0bs5PToPC9gCkjsk+FYIMlcJ+0I8RG5T6nhPa2pS6XuvxlT/VEukUr298nYCoc8eL0Tipx8F3zE/I04pB/tGCk7258JaYn5qb+6QWngNjZZnPuawxq5fNUbJ7JR3tTypl7/zEj7eKAdVGa5te6iAHuLMy8HZ4YqPvugeVbOciCvJtBqnRJh9PxnrjWiVBE9iZBrMPuVSk5leHuMX4uK3NwvQN/gczubZtbJIVay8PbAY2K3nABBFQJwCzU5Z+imnxx7uRjJDuJ0/7hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTYW570/n1ycGJBPDFyhjp5rUSjia796EqBWi+9uBUk=;
 b=QE/3YagV5IScL2hJ9TGc9e/EwavGtGW4KOyQzcpNwsb2IoaZaQ6+/z2ruFZZeqKZlSAPh4Y0Mr1bkzVPBBgkl48wzYEFM5nSErh+VSXViDfcZL6z3kgNbS0vD9s53N8u3aOWwsYOclrylghY+DzBgm7khvEZH78NA9ZBLsFBwDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 15:45:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 15:45:05 +0000
Message-ID: <147af3f0-ca05-6abc-fe2e-c7922bda06b1@amd.com>
Date: Fri, 21 Jun 2024 10:44:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 07/19] x86/resctrl: Add support to enable/disable ABMC
 feature
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <e4edf1794852cff132b17c8f061f24799d9e79ad.1716552602.git.babu.moger@amd.com>
 <28cd2683-2ab5-4772-8597-6aaf0aec1f0e@intel.com>
 <a08d4234-651c-4ac5-9cf8-96a4461c71ce@amd.com>
 <4a072745-11d1-4903-896b-c1544ceb692d@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <4a072745-11d1-4903-896b-c1544ceb692d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0080.namprd11.prod.outlook.com
 (2603:10b6:806:d2::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4b8ed8-cacc-4797-f2f9-08dc92091ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|7416011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjZWKzhUNnIwUDJsKzd6dVF6RmVicE5hK21DZmQxSCtKbjIrekxPclZsbnVu?=
 =?utf-8?B?OXZ1eEZGK29VbnZreFlzZ3V6TDFRRnBLRzBVWHltZ2FlL3R0SFJXTzhvNEdF?=
 =?utf-8?B?R3UvQ0phQ2czalpSMjRnSmV3QUIrNnZ1RlZjaUtBdWFEck9uclpmblVyVjBq?=
 =?utf-8?B?U1BBSjVxb1EvUXlDMGwzZXY2Z0dFVGUwamdLZndOWTdHa252dmo0UC9FQlcv?=
 =?utf-8?B?SitRMHV0c0xqNXFjUmhvMjNMa3JmaUpvU1ZFUXd1Y3hRUWV5T3NGb25tZExw?=
 =?utf-8?B?K2RnRzlIRENxU1J2dzlObE12aFNyRW9MTTROeko4Z1FtSmdUNG1uNWdvOXlx?=
 =?utf-8?B?QzhCcUR0R1dMakVFcmhQK2JOQnhzNGZIS00yeFc2ZUM0MnlQTnNyZ2JMRTVF?=
 =?utf-8?B?OC8zc1U0dnBaeEJjZkNGTWRMTEd6QnBFS2ZVTUxQOUh4YUwyVlVTc3UwZWdp?=
 =?utf-8?B?d2hOekk0WmZ0WFlieU1CK2JCbTZqWjBVQXMzWm1RMllISWZvTUNkS1hxb0pL?=
 =?utf-8?B?NjJnOFMwdEZaZFVqWkdoUFZuNGZIcmtQRy9yY2V4MWNmWFNtQXh1M252cTI0?=
 =?utf-8?B?M3NBWWRCSno4NFBYVHgrQ0hFTUx1Qk05ck1Kb0V1Mnd0T3JZZkhxcEFrSkg1?=
 =?utf-8?B?UmRub0ZmZHgrN1J2bDJyUkF0eWF5ZzJGM1c1aTJHSGhVYkdqNDkyVzNlRmVv?=
 =?utf-8?B?blFOb2EveXRldXBTSDBTZk94TTBDVTBLbklCK2NleEhGbXV6dDlac09LMWxo?=
 =?utf-8?B?U2JYMTZxaUFENExLUmNvcUtTUmtNOW4yQitvYnZrZ1U5bEFkN1RjMnY3YXc5?=
 =?utf-8?B?NmU5eUJURHFNZHlEK21FR21IUDBTOHNFSXdGcUFiV0Z4cWtmSEhrSHU2L3M2?=
 =?utf-8?B?QXpSYmJGV2JrTGI2aEpTMHNUcFRuckl4d0pnY2ZBbUxPNkZDTlpqVXBGdkVX?=
 =?utf-8?B?NDNYMyszRldadDlWUC80d0ZqdWhETXBZeXNQT1o5MkVhTHFxZERBU2laVWZx?=
 =?utf-8?B?MzJWR2M5R2ZaUGdYSXRVdjJya0VYTGlCK2RCNWJZcDhUSE41OTV5TTVENGZY?=
 =?utf-8?B?UVk3enRhUzhwUmJJRkFmTVgycEc2NC9MM2dlYzdIelFwYlhWN3paUnk1U1Vp?=
 =?utf-8?B?VG5Nem5nTW5UbElYbGFCeHp5QlZDT0VYRUR1UFkvSWRSNEI4eERjQ0hhKy9I?=
 =?utf-8?B?S1QwVEVYdjdmemZEZFNYUloyazFFdDBpelpubzNRYUtEdklIb0l0bFRjOHJS?=
 =?utf-8?B?dGVmNlZvOFN1QVVRRWx2S3JVVERtQW1CdVQzTHBqenZ0dXZhTjlxc3VHc0RF?=
 =?utf-8?B?YmRRT2ZRK01ISzVJeGZqWjZsNGg5VFNKYmhUWnI1M2RIL0U0U1RNN1FqbjJE?=
 =?utf-8?B?VDRNZ3dOcmxnZS9sVUwvUnF3RzNGdDVsU0E3SzhMTHJVWDgrZW1TbDE3TGgy?=
 =?utf-8?B?NjR0V00wcnJCZVFBbXEwWFlwaE1tVzFCRHk4WTRrczJZQjZKK21yUHJMcEQ0?=
 =?utf-8?B?WFc3a21FQXprRCt3ZitUQzRMbFFIeUI1SUxlR3czb08vOGFwOFpQdlFCdTd0?=
 =?utf-8?B?U0JWRTVod09mWTNYSkc5Y1RzSnlrMHRQdGJPcnBOdWJwbTlmaHpJclYrQy9O?=
 =?utf-8?B?KzY2emtXSDVpdEtzd0VrZ1FydjYvMWgzNk54akdYQklBV21kNGNYT3JMT01j?=
 =?utf-8?B?TmN4WnBhcEVycysybDFIS0dzbTUzaEROUy82WTBWcWhJTkxIM2xPbENDTDlt?=
 =?utf-8?Q?7COsZh8wGlV5Dg2Du3KmuhHSnSsvFda92e2XG1N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(7416011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnNaMjJwNm45d2NzbEpjaGc5YUFEYWd2VDRRZ2diZWZ1RTRWb2tDcU9XbGdY?=
 =?utf-8?B?VlFSb1VRZlhhcm5kaW5xaUxwd3RRQjJ0ZS9sUi8ySGRQOU1wT0VyaDJ3dmMz?=
 =?utf-8?B?aWE3MklCdnVBWlBZZTZFQW10VEpmSTUyOG4reTM2c2ZZemZkSXk5ZEpjNUp6?=
 =?utf-8?B?cTJEdFUwWXh3Yi8xazVkdEEyc2pQOFRPUElJVkc5M3Q3dE9ORXdkei9CMUNs?=
 =?utf-8?B?cHhkTVYvZlZlV2d1T2p2OCt2a0k5MXgxQ3FxQ2hNZ0lmQnJyNXQ0d1p6UjZz?=
 =?utf-8?B?K1dlTFNpa1hsU0VKbkorZHhPM2lxZEFJb0lOeUpOM2JvUWRIZWM3aUdYT3VE?=
 =?utf-8?B?R0hkOVEwV3E3RjV1Y1BNQnZXT0REdGcra0sreE85RWNQQ1Fnc2dacXFnVkFP?=
 =?utf-8?B?dWJQTW54K3MzZUZwVm1LRFNRV0M0ZThtRGRKLzFWR1k3cGtucXlCU3Q3S1B1?=
 =?utf-8?B?dmtXRG5wWVZOL1B2VEdLV1kyYndkZEtBYUIvNDA2a2t5K2xLY0IrMFd5SkFm?=
 =?utf-8?B?dHJJZzJzeE82aithTmNnRTRhWk5oQUF2V2ExT3ZVdmJoOGw1NmdMWXZ4bzdH?=
 =?utf-8?B?SXZhaC9hb3pZc0txcWJXZFljVnh6ckNXYllMaTVEQWZNay83UzdxaSs4OXE0?=
 =?utf-8?B?K2pJS2tLSU44MjhNTXZreUw5UGNoN1A2S25LWGZucUpqS2c2TE5WZzdxYmNw?=
 =?utf-8?B?QUpxQXV6Um51VTF3RjZqblJwL1pOaThqRHJnc2NubkFqUTNGZ0RZRUZMN1Rq?=
 =?utf-8?B?TEVTb0pnNEdTOUQ1bkhSbmZ4QUNDM2NkVkFTdjJQTXpIUHBQbTJpcW5hb3Vn?=
 =?utf-8?B?OExjOG5vc1B5aElXVDY4WWxXSldKcVpvcVp1b3l3UEk3UU4rYVJOUnZueHpP?=
 =?utf-8?B?OVlSbEpabEovODkxakcvRm9jN1JPaTdGTTJYVVlPdWs3REhFRGJXYm0rYlhH?=
 =?utf-8?B?RG5xN2hpMWdSME5FVmVPL1NHZFczT2VrWVUyb0JST0N5NnRBQldLcnBoZ3M5?=
 =?utf-8?B?MldBREV2cktEZGZTeTF2NE9rQkVoZjFGL2VYVy9DRUxKb2E4czkxM3JuMVFC?=
 =?utf-8?B?RDdVQ1UyQUY2cGNJdi9lWUZOeFo3UzA5QWVoWGRmcXJJTHROZjM2b0ZscjZF?=
 =?utf-8?B?NC9yUFJpckhJSjhOcWJ1YmNtdEFKckN4a0FOakFSa2VmYmRMaUhBaUpQOHlV?=
 =?utf-8?B?Q1ZHcDVieFBGSjdVUHd2NCtjcEMwSHlGR0M3ODFmUUUxeHpTb1RTc2thUnk4?=
 =?utf-8?B?elZFbXFtSFpkRnJBcmJ6SFcxL3lLOE51OW1nUy82UDJJT1JOc3RwNUxZNFQ0?=
 =?utf-8?B?ZjFvTXdNOXdFL0RXSVBsZVd5SHA3QThzKzY0NG16NFZiY245cWNpVzU5VFUw?=
 =?utf-8?B?ZWRPNHAyVWl0bE1tQnVMRTFPK1lDNytmaXIvc2xIMWdEUXR4TzZuU1ozNHlw?=
 =?utf-8?B?dEZhbmp5Q0MzNm9HUUN6V2pQSDQ5andFejBna2NybUJTODZiZyt2ZGVJZjFR?=
 =?utf-8?B?b3lMVXRSVmFvMGpVc211cmtLRlkvUFVuSHI2RDJ6Wmg2WEpxZHRnb0QvMlUv?=
 =?utf-8?B?MEt6S3pmZHNlNnozTWdheVowNXpkaklrclJmR1BqbVJXYlJlNlozdnBWTmI4?=
 =?utf-8?B?ZzdWMEl2cUMrWXQ1Mlo5bzRIYmY2MEtTKzlKS3dxME53ZHJNeFUvNkt5Y1BE?=
 =?utf-8?B?WitKL1pHSldiczc1T0tMQmxiemp6SE5VcU5OK2RYaVcrd1RHQTRPd1VRWWds?=
 =?utf-8?B?OVIvcVNwbGN5T1ZDOUtpUVRWWmV1aGxvNGdHbmJ6SGFkenBabkY4RnpaV3p4?=
 =?utf-8?B?eFhTdG1rczZQRzhIQ3VaejJTTk5NV0w2YmdpOE91NEsyOGhoQm5FM2xVNUdF?=
 =?utf-8?B?eloyY0xnMjV4dzBVOGV1bUk5WCtuV1hKcVVuTG5hdi9RZmorMVNTYU94K0tV?=
 =?utf-8?B?TG5uMzM0Vlh5SzlxVDlhc1U0Rm1uMFFwejNERlJOb0wyWVlSenV0NHVWaWZE?=
 =?utf-8?B?eXVtT1k3V3hxVFhnaGdWUitCTjdaekR5MEJzY0NkMGZlUGdPK2pvckZURFhN?=
 =?utf-8?B?MkRBMC9WaUZEcHR1M29PR1pKM25DRlZuSUsrR1VaUEdjU2F1cWE4R3p3azla?=
 =?utf-8?Q?vYUUNgz+tprgyvG1Xf7MoK/lI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4b8ed8-cacc-4797-f2f9-08dc92091ecb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 15:45:05.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +V8t6NjkGtVK6Ip2Jm8hpltkQZnfjsOgcZuRNCBm0j5g1OtLiyXmXHaI9Quv0ePA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893

Hi Reinette,

On 6/20/2024 5:02 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/19/24 8:37 AM, Moger, Babu wrote:
>> On 6/13/24 19:59, Reinette Chatre wrote:
>>> On 5/24/24 5:23 AM, Babu Moger wrote:
> 
>>>> +     * Reset the internal counters so that it is not considered as
>>>> +     * an overflow in next update.
>>>
>>> For the first time the term "internal counters" is introduced. What 
>>> does it
>>> mean?
>>
>> How about "mbm counters"?
> 
> I think it refers to the state resctrl maintains to be able to catch 
> overflows,
> so how about just "architectural state" with matching change of 
> something like:
> 
>      Reset the architectural state so that reading of hardware counter
>      is not considered as an overflow in next update.

Sure. Looks good. thanks

-- 
- Babu Moger

