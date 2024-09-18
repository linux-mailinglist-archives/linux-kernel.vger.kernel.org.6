Return-Path: <linux-kernel+bounces-332915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B197C0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FF21C20E95
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC8F1C9ECC;
	Wed, 18 Sep 2024 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vLmGCKQ0"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63991273DC;
	Wed, 18 Sep 2024 20:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726690251; cv=fail; b=XyZ6ix8oDfHh5W7bdD5x/KWze1BO0UJ9q1moO/1lqbuh31Q7Thru9I4okk6MuzS+g/qiQCWxBRvSxZS3HwljgV1TEMRNd9mRDrgBTZ+y0hrFPZaWmPI54bpwOj5Yu0484STqc/RIluGWDRzk703WCMoDnFq6DpIYl3MQIlbCQGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726690251; c=relaxed/simple;
	bh=73LI7h/X/8y2eCZD3SCLQXUNK9J0qo4SMUTTfPU7Kbw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JbKNWcEd11r4Tnbx9G4meg+ULI/daFT5K22CKJ9XSFiax2YZk5QkpUdaqraowfrUdT8+SW1VVcb6FxJtWmrnmou6S7K66eeuqn2vG4MnvCakjlTELRMZlSGY7r8/stgPJ/Klp11JGiTH1guwoxLH9FZCWK/1llFPygONz0s0aYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vLmGCKQ0; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AngjQrnL0z8TLHD7u+C2DEHb/s1sTA/Ui2tiNLxGCgyZlT7q2M6HfZ39kHMm5aerb5qNW/uRqWgnkxz8VwpRsk/8poHKNVynMCMrLZPlC4qrxN44nfJ0jvnQH0ps1yHVgwl0WbxKUB0weptFNg5/WctVC7yMvfOawQBvrdXWTDi0vTQaw6L/ByFByI7Mq4uD/N+VZ6OknJYkpzKtmuc0kXXszjwto9j+/D7+r/mWyhbKs/f63f5RXtfv3QscvTWNUm2UcRs3cuX7fgBVh3aVuPhsrGLsxlDI2jo3IMnR7QT8qcgk/5EWmS98F66reG54bFJeuGVwYEvvghV6D//yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIv6ygQdofIGkTaWAU6N/7EHTYzYOGeK8GqMvuECNrs=;
 b=qV/2LsXZVm8OGz+Aj1olwLUWRcK7r1LoT2057851BStzTUfTbkhlT7W1zOKMRQgyn1jVibLiseK/NgU0eYLunZ1lqo6tn12To5iamHfabGll4SfY0BId4zuAxje3pRfhxvKD4t5jpCzu34/Jax4NaCcEqolBC1D7/Jd8FCtrz8if55F1ZNDSr+c7Dn0tgvJSxT8ATTLLON0trwvANlVN+PAKpZZPl902/ZAU22Olq1J3HJGACH38lLZT7tp0T3LAX0mKgUbBNM7YxMCpV9r0Dg0kH2eYuHtHRFlZrjrbgobNbxMWPn2muAHlD7mh3PVl+Nv0qPMrv1ec29xxjlqgdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIv6ygQdofIGkTaWAU6N/7EHTYzYOGeK8GqMvuECNrs=;
 b=vLmGCKQ042vkJaiU92wSeBOJekEYrrvtVe9zp4Ab9JbdAjZ1H7+X03HZ4iEkv2lE9xCjn6pSOxao1PJnYiEiw0sOTqo7CCSy8NyERN0EduIl+Y6XtykO9scYz23WplQDIAqMYoSIsSAvr0ikIynz2tlBhWXpHHHt3IW+T8XrQwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 20:10:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 20:10:46 +0000
Message-ID: <ecdffce0-796b-4ebe-8999-73f2be1e703b@amd.com>
Date: Wed, 18 Sep 2024 15:10:42 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 5/7] x86/resctrl: Add interface to enable/disable SDCIAE
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: fenghua.yu@intel.com, hpa@zytor.com, paulmck@kernel.org,
 thuth@redhat.com, xiongwei.song@windriver.com, ardb@kernel.org,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, peterz@infradead.org,
 kan.liang@linux.intel.com, pbonzini@redhat.com, xin3.li@intel.com,
 ebiggers@google.com, alexandre.chartre@oracle.com, perry.yuan@amd.com,
 tan.shaopeng@fujitsu.com, james.morse@arm.com, tony.luck@intel.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1723824984.git.babu.moger@amd.com>
 <e43947374dd9124ef5a6c677d0ec3ab715b6a7e7.1723824984.git.babu.moger@amd.com>
 <cd0585f6-1d90-4ef1-9a10-7db50cb879ea@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <cd0585f6-1d90-4ef1-9a10-7db50cb879ea@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0191.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: b58334e4-ac0f-4381-0ec6-08dcd81dfb2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGVUL3BWUVB3Y2lEZnRuemZBKzhscmR0NnhuZ1JtcFBRTXVNMHBsL2dDUWp5?=
 =?utf-8?B?WDFQd3BYT2pNOVlQNmQyK2Zvb3UrU1VQa0RCamlYTDUya3dsdytocEs4NGF3?=
 =?utf-8?B?ZGk3MGJRa2ZWNzBDa1BVbW5qdXQ2NGVFaWhnMGNPTXFmbFE3c2h0UHZEclFZ?=
 =?utf-8?B?Y0F3L1Zwc1YxUTVFQTZVUElEWklvZDJ3eG1BWjNENHFZdzhuRWZ2eXBpQzNt?=
 =?utf-8?B?SFhHbzVLN3ZVcWxDajdXcnJFRWx6N0o1R29lR0wwK0F5M1VsM1J1RExtbjc5?=
 =?utf-8?B?MFN4bTRsd0lxazdnMjdhQzBUZGdxei9iaGFaNkM1OHNqZ2dTK3VBRHk0WE16?=
 =?utf-8?B?S2FYdXBjWUVWUmRMbDdiWGZFalpqQU1Qb1ZkSS8xR3ZBbGFHZjUwd1NqS3lr?=
 =?utf-8?B?TmZiNC9ZdjdNVkN0WGUxRE1xa0tmSXBDVEo2cGJ6L1R5R3dtRmNuSE0zbEFU?=
 =?utf-8?B?RGJJczVsTE95Z3M0NXcyY2hybU1FTU1rcUlhb2RXY1c0THV5Nkt6STkxb3lE?=
 =?utf-8?B?L0lvSGt5NGZMQ3VmbDFPMlpDM0Q3VllxczJXcW03MTZTaVdSNllSQzhyVVRS?=
 =?utf-8?B?ZC9zSFUvQ2RJa2l1dkR2TXN3dC9TMWFUOG9pVDlubG9uQUFORE5BLy9welYz?=
 =?utf-8?B?RDF2RUs5S09xZkdZU3pSb3pqSkliUXVUZTMyWnlPL3ZJejhRSzMzVE43YmhV?=
 =?utf-8?B?dmdqUUs4eWUvK2dHZ2VHWmhpb2xhU2pDYVoySks0MHBpRTlFb0t5YzFFdXM4?=
 =?utf-8?B?eVpoVFZtQ1RmbGt6ZTRkUEVPRWsxWTFSYU8vL2V5c2N5bEFHZ2JlTU9jaEh6?=
 =?utf-8?B?aGoyMlRSa3o0bUZmd2Rmb0hsM204WWNPZk9YMnEvWGR3anJtNGpjaURwNStT?=
 =?utf-8?B?dW4rQytqVWNpQzVSR1UrSHJNQWNhTUVJaXY2ZnJtTWJYejZWM1BMN3cwcHNY?=
 =?utf-8?B?SFhIZFo0UzhTanlxZ2VOMnkrM0l1dFhvOWREeXdCMXcrRG80YkpIOGVMQW9O?=
 =?utf-8?B?TG9mWVFZeGF5dEp3WDNUK3F0OUFtNjhXeFdMZkFPZ3VXTjVEQnAwc283STRr?=
 =?utf-8?B?NHE2NThWdzdXZlFNemtBL0tQOVNVczVsaEpEZllRZlBJOGVWU0tpRmhOMzJX?=
 =?utf-8?B?VnVHYjZ1MG5oQ011VEVtSEdOMkIwdis0RTRvbWdybzFKMC9haWhJa0p0RHkv?=
 =?utf-8?B?U3VTdVhsQitNN0c3c3krOWo4OE50bGc1WUxLbU1pK1VaRGU3Y0o2RnE0Lys2?=
 =?utf-8?B?TmhiUFgyeGNmUVNtWG1ZQ0ZJcHV2QlRDRUNvOWx6d1ROMVNBYjZCUDJYS29l?=
 =?utf-8?B?RDhPVEJjWjU3bjN4dENhYlh5TmFEaElMVWFWUFBjd25DQXZRUEFyWkx4T1BO?=
 =?utf-8?B?alNzbld4SDBUb01oY1BEOWhiOG9vREtPbWVFVVZEQ0hNenpwNUdLVS9mNDBV?=
 =?utf-8?B?MDFNOFV5UFBUUGQvNjUrc0JwK2g2TTd3ZkFNeDNVQ2I1dkNtSGpMczZ0NE9v?=
 =?utf-8?B?UUQ1a0RnSWlmUW0vaWtJUk1VTFpZVTV3MXYrMUxkRzJyZW1ZQVl0THBIWHRE?=
 =?utf-8?B?Q2RSZ1ZqRjE0QU83c1RWSzVydzV1NUVhZzh0ZldkWFcvOC9rUXJjaDZyT0Qz?=
 =?utf-8?B?Z3UvdGVZb01mTUpGLzN6TlFuZW9JOXc2cVdMWnVjNzBCeGZ0ekJKNjNydFd6?=
 =?utf-8?B?L0hNSm9tQkYrZnlJeWpPWm9DMjhMa01tNU03b1hvSjg0ektzcjcrbldRNWM1?=
 =?utf-8?B?WDlUTWNyZFJWcjJ5alVuSm1RaUVYTWRSK1ZBU1I3T2pmRzlkZFZnR3hnYjhD?=
 =?utf-8?B?R2xUVkpqRmY3VjFGbGFhdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlVocklWWlpuV1RsV1IvYW15R3Ewc1hJQkd1Q01UeEE2RzMrdUwxVmhyamRl?=
 =?utf-8?B?NmFMaDhINVNxZUM4dHhTVUFUZmZaVFYrZkkzL0NUbDhBNWlpOXRkQWFKckEz?=
 =?utf-8?B?YnF6Z1pmMkdRZGRTSmZpaEtWUnRhVWNZdmFibVUwQURIMnUxZHgyTDBtbWpr?=
 =?utf-8?B?NzlZNXEyT096ZXJ1WlExZ1Rtb2pWbDR1bEZLcEhTRVJNZnptcURKWFFTZGdC?=
 =?utf-8?B?cExHa2tWSVlkTDNQM3ZmSkNrMEp4a3NtY0lIZnpia1JleWR1WTVyQUZVZTcr?=
 =?utf-8?B?MFF2NmlpSmlUbVdnWndWT0tGWUQxZFlNWnEwbnA1UExLa1YrSXVRQnNOUGxu?=
 =?utf-8?B?M2VzYmNaRytkZXJ4TVNrbmI5OFg5c0c2SDVZQTJCbkJROU5laU5yS3dvaHdG?=
 =?utf-8?B?VnhpYlV4MjkvUVNHL25EdzFZQ3dUQ0VpeVhnOUJOUzIwNS9WMzZCYks4akVD?=
 =?utf-8?B?MStqZFpBaW1SblNTR2sxWW1GaTFET1AwbXpqNHJ1ZndtTXpNQmtsaTJuTGpv?=
 =?utf-8?B?OENWTUdMdldIVUwwaklvR2V1VFdhaE9NYzEzUVpQVk4wMEhRYzgzdU9lL2hO?=
 =?utf-8?B?OGZoZWJtbmdWTmxFQStwTkd3b1NrdFppVTNiQ2RTR0VLZnpjTUdjNGZYVy9r?=
 =?utf-8?B?UzFwcFBoTXNWeXJzK1hlTW54SXlucU5hbW9jakpEZ2RacVBCNDh0SFc0cnFX?=
 =?utf-8?B?VkIrdnZQd2JNa2RWemp2OXg3WkJRWm1aOGtmVnROM3dpWHpuWDZ1NDZrSVVv?=
 =?utf-8?B?S2dLU3pHMXZmZ05OdG5nRGFrTUNRZGxma3ZDVW00eWhRSU94MEJJWllWN3JQ?=
 =?utf-8?B?b2RpMVBSNi9UVjhWdTNUdE8rVDlBQmdFWXA3Um9XQVJQNjhxUHNld3ExbnZp?=
 =?utf-8?B?Q1hCdVF4QUpVMm9Sc2V5MFRXSEpTbnF4cHZQMlpEd0JvbEVqKzl5bDBFZ09F?=
 =?utf-8?B?dldiMVZqM0c0UUxxbmFyQ1QwWDFEcCtiQjJJcGw3ZE4xSlVZZmd5dUZESzFI?=
 =?utf-8?B?MEZ2Z01iYjRqYTRuNWtzdTF5d3pIOExCNXJCdGwwTnJ1WmFHNnAzMHVmTTJl?=
 =?utf-8?B?dlFVZjJpenQzM3VnbTk4ZFVGakttUVRFM1NETWNvZ0ErOUNmMFdVK2hHZWly?=
 =?utf-8?B?ajc2TUw0T3hia29nT2lSK0xaQW45dUtRSE9sMjllTHNXRWtEYWhITnFpMGNJ?=
 =?utf-8?B?bHRNZUhDUjdVa1lMQ2N4ZSt5bHYvSkRLSWdiaVpkY21SSjVtMThlTjM3TnNv?=
 =?utf-8?B?NnJtS2NtUmo5Rk1BaUFYeEVkeHVMT256Zk4xdStFWnd6RXRCWDBMNUZock5M?=
 =?utf-8?B?TXJYRW5WWVFEYlA0THBtUDQzLzZrc00yTXZtY05LeXEvT1RmRnFyQmF6ellP?=
 =?utf-8?B?TTZXMjV5U2txb2pwVDlERWMvcHR2SXB5WUZHSlFVT3YxSjlGKytlMGordXFE?=
 =?utf-8?B?UEVkbUVKb0VuNjNoREI3ZnRmeDJIYlNhVHRka0JIclovcGozR3pkcVlrVTVW?=
 =?utf-8?B?MWM1TmpCckplTkFaeEpaa0NEQzJUVVNhMFVOWXRaYWJZVW5yKzhGWW9IYnZr?=
 =?utf-8?B?ajRyY2NoVHZNRXV1cXc4NXpnM0tOcndaN1VYNVdmTjBJRWpDRGwydFozWDR0?=
 =?utf-8?B?TmlMSTdYdW1vNWRPRjVUckZXQ0E4TTVLa3FhUWM4QnkzWUkzRVgzTC9BMmoy?=
 =?utf-8?B?VEdOQlV0S09vS2pWTXVyanB6eGUxS1BuaEprZUpSNmw4c2k3cnZHQW9rcXRn?=
 =?utf-8?B?eWpvay9FclhtN1pzYzBaVE9WZGwwb1hXeklINmtOV1RuSXhCSVM0NjlQb0I4?=
 =?utf-8?B?UGZUS1E1MEFQcFd2cGdJYjBETGNGNW12aC91ejgrdjBDVHc3a1h0T1o4Rk11?=
 =?utf-8?B?ZVo5bnVnVk5UT2lVMUF6UUU1NTJZZWtGMm50V2x6OVVkZDFvbWRvUERac0Q3?=
 =?utf-8?B?K1BMZStUS0xGUXBWK1dJemVJREpGK0lkQ01NRm9QWUtkdllhdmJBWmxNL1VK?=
 =?utf-8?B?K3UxSlNyWDArelJNZWpGak0ybDBoY3VkanFIVzN4eFYxakwzejhDN2VYdk0w?=
 =?utf-8?B?ajRIZ1E4S1ZrS2JtbHNFdmxKa29lSGJULy9GVERLWWU5SmdIeDljdU1kcVIx?=
 =?utf-8?Q?digM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58334e4-ac0f-4381-0ec6-08dcd81dfb2a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 20:10:46.1207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9lKuZLZLnupbr+OBIsrS0b+zHCMV/9GiVB4xcoofxtQD9XYcHU/E9PQZt/uqZ00
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443

Hi Reinette,

On 9/13/24 15:51, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/16/24 9:16 AM, Babu Moger wrote:
>> The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system software
>> to configure the portion of the L3 cache used for SDCI.
>>
>> When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
>> partitions identified by the highest-supported L3_MASK_n register as
>> reported by CPUID Fn0000_0010_EDX_x1.MAX_COS. For example, if MAX_COS=15,
>> SDCI lines will be allocated into the L3 cache partitions determined by
>> the bitmask in the L3_MASK_15 register.
>>
>> Introduce interface to enable/disable SDCIAE feature on user input.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   Documentation/arch/x86/resctrl.rst     | 22 +++++++
>>   arch/x86/kernel/cpu/resctrl/core.c     |  1 +
>>   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 88 ++++++++++++++++++++++++++
>>   4 files changed, 112 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst
>> b/Documentation/arch/x86/resctrl.rst
>> index a824affd741d..cb1532dd843f 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -135,6 +135,28 @@ related to allocation:
>>               "1":
>>                     Non-contiguous 1s value in CBM is supported.
>>   +"sdciae":
>> +        Indicates if the system can support SDCIAE (L3 Smart Data Cache
>> +        Injection Allocation Enforcement) feature.
>> +
>> +        Smart Data Cache Injection (SDCI) is a mechanism that enables
>> +        direct insertion of data from I/O devices into the L3 cache.
>> +        By directly caching data from I/O devices rather than first
>> +        storing the I/O data in DRAM, SDCI reduces demands on DRAM
>> +        bandwidth and reduces latency to the processor consuming the
>> +        I/O data. The SDCIAE feature allows system software to configure
>> +        limit the portion of the L3 cache used for SDCI.
> 
> Above needs to change to a generic resctrl fs feature.

Agree. Will rephrase it

> 
>> +
>> +            "0":
>> +                  Feature is not enabled.
>> +            "1":
>> +                  Feature is enabled.
> 
> What does "feature is enabled" and "feature is not enabled" mean to the user?
> What can the user expect to happen after enabling/disabling this feature?

Ok. Will add few more details.

> 
>> +
>> +        Feature can be enabled/disabled by writing to the interface.
>> +        Example::
>> +
>> +            # echo 1 > /sys/fs/resctrl/info/L3/sdciae
>> +
>>   Memory bandwidth(MB) subdirectory contains the following files
>>   with respect to allocation:
>>   diff --git a/arch/x86/kernel/cpu/resctrl/core.c
>> b/arch/x86/kernel/cpu/resctrl/core.c
>> index e4381e3feb75..6a9512008a4a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -299,6 +299,7 @@ static void rdt_get_cdp_config(int level)
>>   static void rdt_get_sdciae_alloc_cfg(struct rdt_resource *r)
>>   {
>>       r->sdciae_capable = true;
>> +    resctrl_sdciae_rftype_init();
>>   }
>>     static void rdt_get_cdp_l3_config(void)
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index ceb0e8e1ed76..9a3da6d49144 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -662,6 +662,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource
>> *r);
>>   void __init thread_throttle_mode_init(void);
>>   void __init mbm_config_rftype_init(const char *config);
>>   void rdt_staged_configs_clear(void);
>> +void __init resctrl_sdciae_rftype_init(void);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>>   diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index c62d6183bfe4..58e4df195207 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -171,6 +171,27 @@ void closid_free(int closid)
>>       __set_bit(closid, &closid_free_map);
>>   }
>>   +/*
>> + * SDCIAE feature uses max CLOSID to route the SDCI traffic.
>> + * Get the max CLOSID number
>> + */
>> +static u32 get_sdciae_closid(struct rdt_resource *r)
>> +{
>> +    return resctrl_arch_get_num_closid(r) - 1;
>> +}
>> +
>> +static int closid_alloc_sdciae(struct rdt_resource *r)
>> +{
>> +    u32 sdciae_closid = get_sdciae_closid(r);
>> +
>> +    if (closid_free_map & (1 << sdciae_closid)) {
>> +        closid_free_map &= ~(1 << sdciae_closid);
>> +        return sdciae_closid;
>> +    } else {
>> +        return -ENOSPC;
>> +    }
>> +}
> 
> How does this interact with CDP? It seems to me that the above would
> cause overflow on a CDP system since the closid_free_map is sized to
> half of what the hardware supports. This also seems to still allow
> creating resource groups that may end up using the CLOSID dedicated
> to SDCIAE here since the (when CDP enabled) resource groups use
> software closid and then hardware configuration is done with the
> hardware closid. When CDP is enabled it seems possible to still
> create a resource group and modify the CBM of what is then intended to
> be sdciae allocations?

Yes. This code is problematic when CDP is enabled.

Hardware techically supports both CDP and SDCIAE together. In that case
SDCIAE mask is shared with COS=7 Instruction mask.

We have couple of options.
1. Dont allow SDCIAE when CDP is enabled.
2. Modify the code to handle both CDP and SDCIAE. Add documentation to
clarify about sharing of SDCIAE and CDP masks.

I would think option 2 may be better.

> 
> Also, please be consistent with function naming, note how the above
> two functions differ wrt namespace and verb. resctrl is surely not
> consistent in this regard but it really helps to have partner functions
> look similar. For example, this could be "feature_closid_get()" and
> "feature_closid_alloc()".
> 

Sure.

> Also, there looks to be opportunity to use bitops here ... perhaps
> __test_and_clear_bit()?

Sure.

> 
> 
>> +
>>   /**
>>    * closid_allocated - test if provided closid is in use
>>    * @closid: closid to be tested
>> @@ -1850,6 +1871,57 @@ int resctrl_arch_set_sdciae_enabled(enum
>> resctrl_res_level l, bool enable)
>>       return 0;
>>   }
>>   +static int resctrl_sdciae_show(struct kernfs_open_file *of,
>> +                   struct seq_file *seq, void *v)
>> +{
>> +    seq_printf(seq, "%x\n",
>> resctrl_arch_get_sdciae_enabled(RDT_RESOURCE_L3));
>> +    return 0;
>> +}
> 
> This does not look right ... this file has flags "RFTYPE_CTRL_INFO |
> RFTYPE_RES_CACHE"
> which means that it will be created for all CAT resources. So, on a system
> that supports
> L2 CAT, the "sdciae" file will be created for the L2 resource and it will
> show whether
> "sdciae" is enabled on the *L3* resource?

Yes. I will have to get it from resctrl_schema. Good catch.

struct resctrl_schema *s = of->kn->parent->priv;
struct rdt_resource *r = s->res;

seq_printf(seq, "%x\n", resctrl_arch_get_sdciae_enabled(r->rid));
return 0;

> 
>> +
>> +static ssize_t resctrl_sdciae_write(struct kernfs_open_file *of, char
>> *buf,
>> +                    size_t nbytes, loff_t off)
>> +{
>> +    struct resctrl_schema *s = of->kn->parent->priv;
>> +    struct rdt_resource *r = s->res;
>> +    unsigned int enable;
>> +    u32 sdciae_closid;
>> +    int ret;
>> +
>> +    if (!r->sdciae_capable)
>> +        return -EINVAL;
>> +
>> +    ret = kstrtouint(buf, 0, &enable);
> 
> How about kstrtobool()? This will make things more consistent with
> resctrl_arch_set_sdciae_enabled() expecting a bool. Or should we be
> looking ahead
> at this file later possibly needing to support more integers to activate
> more capabilities
> related to this feature? In that case this implementation needs to take
> care since instead
> of supporting "0" and "1" it supports "0" and "anything but 0" that
> prevents any such
> future enhancements.

I will change it kstrtobool().

> 
> 
>> +    if (ret)
>> +        return ret;
>> +
>> +    cpus_read_lock();
>> +    mutex_lock(&rdtgroup_mutex);
>> +
>> +    rdt_last_cmd_clear();
>> +
>> +    /* Update the MSR only when there is a change */
> 
> The resctrl fs cannot make predictions on what arch code needs to do to
> enable feature.

Sure. Will remove it.

> 
>> +    if (resctrl_arch_get_sdciae_enabled(RDT_RESOURCE_L3) != enable) {
> 
> (same issue with this file being present under L2 resource creating
> confusion)

Ok. Will address it.

> 
>> +        if (enable) {
>> +            ret = closid_alloc_sdciae(r);
>> +            if (ret < 0) {
>> +                rdt_last_cmd_puts("SDCIAE CLOSID is not available\n");
>> +                goto out_sdciae;
>> +            }
>> +        } else {
>> +            sdciae_closid = get_sdciae_closid(r);
>> +            closid_free(sdciae_closid);
>> +        }
> 
> 
>> +
>> +        ret = resctrl_arch_set_sdciae_enabled(RDT_RESOURCE_L3, enable);
> 
> I assume that once SDCIAE is enabled the I/O traffic will start flowing to
> whatever
> was the last CBM of the max CLOSID? Is this intended or should there be
> some default
> CBM that this feature should start with?

It will start with whatever the last CBM for max CLOSID.

> 
>> +    }
>> +
>> +out_sdciae:
>> +    mutex_unlock(&rdtgroup_mutex);
>> +    cpus_read_unlock();
>> +
>> +    return ret ?: nbytes;
>> +}
>> +
>>   /* rdtgroup information files for one cache resource. */
>>   static struct rftype res_common_files[] = {
>>       {
>> @@ -2002,6 +2074,13 @@ static struct rftype res_common_files[] = {
>>           .seq_show    = rdtgroup_schemata_show,
>>           .fflags        = RFTYPE_CTRL_BASE,
>>       },
>> +    {
>> +        .name        = "sdciae",
>> +        .mode        = 0644,
>> +        .kf_ops        = &rdtgroup_kf_single_ops,
>> +        .seq_show    = resctrl_sdciae_show,
>> +        .write        = resctrl_sdciae_write,
>> +    },
>>       {
>>           .name        = "mode",
>>           .mode        = 0644,
>> @@ -2101,6 +2180,15 @@ void __init mbm_config_rftype_init(const char
>> *config)
>>           rft->fflags = RFTYPE_MON_INFO | RFTYPE_RES_CACHE;
>>   }
>>   +void __init resctrl_sdciae_rftype_init(void)
>> +{
>> +    struct rftype *rft;
>> +
>> +    rft = rdtgroup_get_rftype_by_name("sdciae");
>> +    if (rft)
>> +        rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE;
>> +}
>> +
> 
> Another instance of the pattern that is impacted by the ABMC and MPAM work.

Yes. Agree.

> 
>>   /**
>>    * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
>>    * @r: The resource group with which the file is associated.
> 
> Reinette
> 

-- 
Thanks
Babu Moger

