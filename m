Return-Path: <linux-kernel+bounces-220192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B3B90DDEB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A732AB21AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181261741FF;
	Tue, 18 Jun 2024 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dp0LhhlE"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9444416CD09;
	Tue, 18 Jun 2024 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744557; cv=fail; b=R1uFt2TXoOl14rvQUt1pvoDSEcaPehcAOhG5ir7MO74+THlsxdCgyCpuDhtkItc9O76V6e/3w4HqiGpyRQzDXJf8EOxUORW6hnM2bsh5nNhkyCiHMXzfqh1tNNKd6NullfcdKIv1JTz3QuzCRLYqoub2+0DMUQqCm6oqIZoUV4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744557; c=relaxed/simple;
	bh=A+4mgSZ5VbOKEl65qQHGkq+LBMC5OAR3TbYk/Du8cLU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=npAqnhuoOLjf1K6xccN63d/jKOUWfzzjjJz0Cn10nkUOEen/vMWDPKCqt6fJwrALgbLA71bx/7Jn8XxcggG3PUbRkVEq84cEKs2odE08nrNRkGBvDsfphJIghW8mzc/C+RX1cerEojpEl7JS8WgO+EX1iTiWPuRasg2PBZVlIWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dp0LhhlE; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF4OGCZ/UjNWzb2fRotPmRQaKSYOWOae4uJCAnkBAR4/aSj0C9+J5YNPuMWTqljQIMxNWubcyTq243F3LyL0bPEEKsokFj+6DUnxIgZyMsZjtMyjAn5nt/gy13c0XUR7tAXpWe1/TKlpQUtCUSKsVT5twlmoc0uz8vNXyOgdewNqTuuCfDCbPLEdUi9q4BTHki6FjpmtydJgqWqd79+Vwhd+0lxwc7nDbfrxawfEFNrl+I+DdTUAaMpszTBKsRrbtczmSn1QBeR1ejfkO3GOJ3TWGKglH961tAruGzelEn6KFTmHgaKt3Q0e9na/k0NXZw2knDeXyuDtpQFs4paNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAIpJo6n4IyFNHm7OXB+2Vdgt8yjvqI8XoSjNcqqMb8=;
 b=iMKjbFf0ZHousqfNzGND7UxmbqiUWTssHGZTnMRbv9obsCRaOgwLAARo75j/qP3hp2TcTuCfEHV3YK5ZKmBXXczL6/muw7JZJkMkxFu5O62UTabymS7OytnirtUMEjTV9x3gESTEYXt5DOK1Np30V6ki9LKU3T2ouaztSCGKOFJdxYqH59mmBetqrmwWN1zORjje1w3r0xiC4VIzF5j8mOEBdD/tpGLGTnqrdn3NZdqeT7OyLu38Xom3VGzFRMMnNa33nKymNb7yAlPrQylpYdwT0i2OFMIwoh8X6qfh4iFV24u91QKQ3tVCI8yJlhLeFzddloATLex2G9bPVNqbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAIpJo6n4IyFNHm7OXB+2Vdgt8yjvqI8XoSjNcqqMb8=;
 b=dp0LhhlE6MteuOsR/oxBCn7MELq+L+VU3iNNCRIEEi22O/mK1Y9etC4oK0AG1Fl6fjOdSpbo9lHdQJsprDrz29XhtkgoxZgnW9J+/ugpuqpyOO8c8IEnk995oqWoAqMq1vcKB7xFOuCfAGUSMNzJgtTbcsGaZs2kMsZFxHDQKFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 21:02:32 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 21:02:32 +0000
Message-ID: <6e297b6e-e39b-e358-7bb5-59add62f8b2b@amd.com>
Date: Tue, 18 Jun 2024 16:02:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v4 00/19] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Reply-To: babu.moger@amd.com
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <2e488812-671e-4aa9-a292-c54b174f2dd7@intel.com>
Content-Language: en-US
In-Reply-To: <2e488812-671e-4aa9-a292-c54b174f2dd7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:806:21::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ba6ed7-e558-4a9e-8a89-08dc8fd9f865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTd5VHlsNlRjN2w2V3RuSjhrMHNoS1ZBUmY4SEYySklPNjYwUjcyTGtzYjdp?=
 =?utf-8?B?MDJvdk9jaFhFMkM2TDVLQ1pZUHJhQUxxRDJnZlBJRGhkRUZQOGR0SU1hNjZi?=
 =?utf-8?B?SThZRTg2c2VnMnlZVmNZcUxYNGFsZDY4clRCNUlZelFLWTNYdFBZeFNwMFFM?=
 =?utf-8?B?L2NTNTdUdFVCZ1VlS2FWZGtKdnc1Tjc4SnBvSURzcy93R3FUZTlsV0xVdDZW?=
 =?utf-8?B?QWFwZDJVSjZrSThhRmR0MjdkVDdiUlorajl1aVdXOHFkUU5qNCthMHNad1BS?=
 =?utf-8?B?b0JmbDJpaGVzcEY5bTgxYlc1RWRNdzd2dUhUQVhWc2JPMEUzKzBjR0ltSDZn?=
 =?utf-8?B?ejZYNzhLUTR3WHd4L0tlQndxRFdFaDhHSUpjalVUSmNRUXVETlR1WUI5anVh?=
 =?utf-8?B?SmwyTFNvL1hCNXRINWxTSjJhcDZUOEJkN2hOS2lPa1g3VFpVYTFGRGNlQ3JM?=
 =?utf-8?B?VE1KWi9WMkxaU3pmakZiWG5ndmQrUVJWVVY4b01senN1M3pXbi93YjQ3d1RM?=
 =?utf-8?B?TllwWmdOZXFlY2cxWCsycUpzOEVkLzY2OVBrWjNFdHRQTmpTamRQL1crRyti?=
 =?utf-8?B?WTErZE1RTGo0Uis0WEowUmo4N2gvTVpXK2Z2REdjUnZiUVBUUnNLQjNuUXhZ?=
 =?utf-8?B?STRxck1oTUJTZFpBV3pESFNSYlRQTkgzdVpzT295aEtiMGJVRm0rczUyUmF0?=
 =?utf-8?B?ZVZoeFQwak1PcldiZXRvSkJlT1U1R0dzY1BlSlB1VG9KeWt6b2R2VUVSM0Rw?=
 =?utf-8?B?UlhuQm5LaGt1TlE1MnVPZzZwZEJUbDByS0ViRDhKNHpkVTNMV1RYRC9DVExL?=
 =?utf-8?B?M09XZTU5Y3F6V096R3JwNVkwUkRFYzRVbGtmUTZCTHh1RjJQYWg2ZDVhbmNY?=
 =?utf-8?B?ZlE1RVUvM3pHaDd6OWdZZ1gzbFd4VFVEeWp0enFlMHRlQmNKWFl6d0tPaGpH?=
 =?utf-8?B?T0hsc0p3ZEUxTVQvbExYeTc1LzJmTEtCZEptZzBxVDhxbzdlMGIrYzRUeDE5?=
 =?utf-8?B?bjFlMEw1elFxVGFaYTBXUHVlTTdKem9ETGZLMW9ScSthWnpOMWkycDlzRklw?=
 =?utf-8?B?RGVjdUdGN1BnUjNIN0p2ZEJCZ2dWYzJIZmR5N0JXc1BUcDJZNWt0SnhTdjJl?=
 =?utf-8?B?SFZEb0xyMmhrbXVMK1pqSFlJcWVQU0RzaXhyVVhTa3p5UHByN0M1THdBbVRH?=
 =?utf-8?B?bkpHcDRBN2lCRHM0eUxLd0xFa3VtMFFkczAwV0tRbHVXc0dFODllQ0VaUzZG?=
 =?utf-8?B?VWMrNHNveUNmK3pKWFNnQm5qYzA0d1RZZjhMS1R3eW9FOXdtNkpWSnVrOWk4?=
 =?utf-8?B?Mk9XR3VPcU1HbnNxVW84WUVSQ0pQVGxtcDhjcmo3QmNDMXdmYjhOOFN3elhX?=
 =?utf-8?B?LzIxSlV6RmNSbzNBazZDd2JqR1M5YnZHbG92aXZDaTUwVUZZMDFCL3RBRWNY?=
 =?utf-8?B?YTRmSytDaktmZlBmYVYrYjQvNmF6eFUwWk1RSVVBcHdJWi9henRpZlJDb3hO?=
 =?utf-8?B?Z21DamVhUlcvSnAxK3BTcHZYOWY5MlIvRmYxYzBaa1Qzdlp3NW9iaWs0SG0z?=
 =?utf-8?B?KzlmeWZZN2dGN0MwRlRRaDFxb0pmREhibE5nRUhlZ2NjRWpJZzZGd2U1WUxy?=
 =?utf-8?B?dVZGTThuaDd6cllybS8wWkUzdzJTUkJrd3pCNjMwdXJqZEYvejhrcWpCRGdi?=
 =?utf-8?Q?QDUKKqvmj9GnSlBUjB+H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUhUWFJVeU1KZGtxcVUzWHppc1RONVkzWnZkQzROVE0waXlJUDRHZkN4a1Ji?=
 =?utf-8?B?N2Y4S3pFMUY3RU94bFgxYVloMllpUXJrbE9rZU1sdGtjUjBmRDRkRDdtMXo1?=
 =?utf-8?B?b1MvdXR5ck9lb0hkMmROWEx1UWtNcnNMZkFXcnE2UkFoZlFqK2NvZXA0K1A4?=
 =?utf-8?B?OUNJVUJzQW1oUGZNVFdSOE14cStmSld3ZUcralgwclp2RXlMT3FsTVdOV3ly?=
 =?utf-8?B?c1V5dlpWdTRqbmp2ejlaM0gwZm4rbFhvR1pHaFd3REcwWGZLc3Jtbjc2eXRn?=
 =?utf-8?B?MW9LWEVRV3JkQkY4NDNSZU1XMHQ5czdscE56QlE2VVZqTUllYUJIQ0VuQWxn?=
 =?utf-8?B?TWdvUFlhQjViUlQyWWNTV1dWNEIwTUtTTVhMSlhaZFFUR3c2cVNpZVh3d21k?=
 =?utf-8?B?Z3lvOEV4b1l2NituRDA3YTRNWUlOaGJWcWtreWVCWEowKytmSE9LMEJFOXlr?=
 =?utf-8?B?T2NzOXgzaEFTZjVpWS9QYlYrVFJnRFNTOXl5MEdjWG9hTG55S1pSVndIKzU5?=
 =?utf-8?B?b0F1U2JNaW9rVTNnMld3VTJnY0lMSklQSmpTZVZvZ2Q1SGRUZHdtTENyeVMx?=
 =?utf-8?B?NnFwMU5BMEIyV3hrWWRLUmZoT3FZSndiUEhQUzd5cEFNdzBLeHg0K25POFo3?=
 =?utf-8?B?czZoMnpJd0d3WDNTQlppajRJS29uWDllK0VzUGpOanNjbzZUNHI3emlaMTJR?=
 =?utf-8?B?aUE0RjFId2JtUk41VTJyRnBKWEZWOEVjb2xHejhSazhhbFl0T1ZncDE5dVJa?=
 =?utf-8?B?aVlvRlRmZGVjWGZTbHQxOGFxR0grckx2YzVITlFzSWJBWGJPRVordnA2bDBr?=
 =?utf-8?B?blMzRmQvUWo5UXI3bkVLdEdRVjFScEs1R1NobWdDK3M4eVpFWE1LTFlmbFdw?=
 =?utf-8?B?THVvVThqQXB1VXRKYXZkczIrd3ZVOGpwTmE1V3hQeTZjb2hCbGdUM3loK0cz?=
 =?utf-8?B?MjA3TS9CSTVkb1ZjWU95SmgyZFRwcmdmUFN1Qjh5VmVKNFJzdG1uK0s0QitL?=
 =?utf-8?B?dUFURUh0RVBOay9hL0luMjRsVWo4akpPKzJlMFNqRVVjb3EvZE83M3R3NFp0?=
 =?utf-8?B?Qm1OdFJGMDdWZWRWYmxyYzlqQStubTBRVVhyUi9Zb3BhS256UUF0YS9BWTVy?=
 =?utf-8?B?TStuNW1IR0hiYnZBU2pGQlBObmZaYVk1MTlsblhPYm9YdHdGK1NXNkswZE9F?=
 =?utf-8?B?L1huVHUyOVc5WVlEcFBiTmhWNTd2anpQZkt4TVQrMUJwYXRiYXBQanNmbXEz?=
 =?utf-8?B?QU9GOTNpTERvb2R4WSt5RjJFWGJIcU1FbjhhSExKOWYvK3RIeGdFM0FyQktC?=
 =?utf-8?B?QlRka1M1c0Z5RVcwZmcwd1ViSDBBZ3VOK1RUQVRmZml5My9CRVdobkxUYmp4?=
 =?utf-8?B?OHdPS0Z3aE1YZlNoL1NlZkZuZmhGMk9tT0ZHb2RYbE1FMDBRSFVVMkFqWW10?=
 =?utf-8?B?ZmtEVXU2TzlqeVdWU0p6ZUV5a0d3Ny9QTERmZzd5OUs5WEpzUWUwWHZkUWxP?=
 =?utf-8?B?K3dyLys1NEVWZmRYS01DWVlubGlZTUxJcDJKNFRoMmNET3NyRHFhNGQ1RjJl?=
 =?utf-8?B?N1loTlM0aDBxeXBlcjcrdDF5NTZQVUNBaUY4WWQ3UlN2Sjg0emFMQWRJYXFv?=
 =?utf-8?B?dWZoQWsySVVoT1oxSVJaR2lhM0JHU1Irc1pidDZXelJkR2J6RWhaYms4UFNs?=
 =?utf-8?B?UXpkU1V5bXZEM0JtWHJLamZRd0Zvbks4NnArTlA0NXFVeFQvNWFqT1NmRzEw?=
 =?utf-8?B?L0RnM0RPOWZ4eVFZdlR0am9nNldDNytWOSs2R0VaVXVJWmtXNTRPY3R4T1hT?=
 =?utf-8?B?Wkl0R3J3WmNwS2JnVmR1eXo3Vnd1c2NmSi9sa0p6dlRhUm5jaUp2ZEhQcys1?=
 =?utf-8?B?VUgxdW1KZFNnOStHd0VBN2o3cEdqS0g4ZDUxL3JId3IzMGVHdElFVXQ1VEI3?=
 =?utf-8?B?NVBXVytEcmQ0MDhsRlhrL2RFUVlMbldrQTJNUUVRS1o5YytKcjJNTXV0WnhN?=
 =?utf-8?B?amxwc1lSZi9wdEFabldReW9kMFp0SUNzekh4ZUFNTXM3Yjg2OS9idjE4OVB6?=
 =?utf-8?B?QjRWbk1ZNmYyeUhRVElnb1pSWWJNRitCWTVoY2pWa1JFVjBUY00yOTZXQjlt?=
 =?utf-8?B?TmpLZUtTaU5yd3FzOENBUkUvbU5Oem55dmJrVFFJQ0JlelowcnF6SU9GRUdt?=
 =?utf-8?Q?8hASBtAdlA38qbq3gezowQnf/WcFaKXthLw/WPn9v+ln?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ba6ed7-e558-4a9e-8a89-08dc8fd9f865
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:02:32.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaCVIaGNPbQSexhvKTsswILVJuzrXahFaWFvfaf4Y/yb+ooSHRaZSlMdxJi56+DS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

Hi Reinette,

Thanks for the feedback for the series.

On 6/13/24 19:54, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>>
>>
>> d. This series adds a new interface file
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>     to list and modify the group's assignment states.
> 
> There was a lot of discussion resulting in this centralized file. At first
> glance this
> file appears to be very complicated and I believe any reasonable person
> would wonder if
> all of this is necessary. I recommend that you add a motivation for why
> this file is needed.
> Some items I recall are : it makes it easier for user space to learn how
> counters are used (no
> need to traverse resctrl and open()/close() many files), on the resctrl
> side it makes
> it possible to support counter re-assignment with a single IPI. There may
> be other motivations
> that I am forgetting now.

Sure. Will add those details.
> 
> Also, could the name just be "mbm_control"? What is enabled at this time
> are "assignable
> counters" but in the future we may want to add support for other flags
> that have nothing to
> do with "assignable counters".

Yes. Sure.

> 
>>
>>     The list follows the following format:
>>
>>     "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
> 
> "assignment_flags" -> "flags" ? (throughout)

Yes.

> 
>>
>>
>>     Format for specific type of groups:
>>
>>     * Default CTRL_MON group:
>>      "//<domain_id>=<assignment_flags>"
>>
>>         * Non-default CTRL_MON group:
>>                 "<CTRL_MON group>//<domain_id>=<assignment_flags>"
>>
>>         * Child MON group of default CTRL_MON group:
>>                 "/<MON group>/<domain_id>=<assignment_flags>"
>>
>>         * Child MON group of non-default CTRL_MON group:
>>                 "<CTRL_MON group>/<MON
>> group>/<domain_id>=<assignment_flags>"
>>
>>         Assignment flags can be one of the following:
>>
>>          t  MBM total event is enabled
>>          l  MBM local event is enabled
>>          tl Both total and local MBM events are enabled
>>          _  None of the MBM events are enabled
>>
>>     Examples:
>>
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>     //0=tl;1=tl;
>>     /child_default_mon_grp/0=tl;1=tl;
>>
>>     There are four groups and all the groups have local and total
>>     event enabled on domain 0 and 1.
>>
>>     =tl means both total and local events are enabled.
>>
>>     "//" - This is a default CONTROL MON group
>>
>>     "non_default_ctrl_mon_grp//" - This is non default CONTROL MON group
> 
> Be consistent with "non-default" (vs non default) as well as "CTRL_MON" (vs
> CONTROL MON).

Sure.

> 
>>
>>     "/child_default_mon_grp/"  - This is Child MON group of the defult
>> group
> 
> "Child" -> "child"
> "defult" -> "default"

Yes.
> 
>>
>>     "non_default_ctrl_mon_grp/child_non_default_mon_grp/" - This is child
>>     MON group of the non default group
> 
> non-default

Sure.

> 
>>
>> e. Update the group assignment states using the interface file
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control.
>>
>>     The write format is similar to the above list format with addition of
>>     op-code for the assignment operation.
>>     
>>     * Default CTRL_MON group:
>>             "//<domain_id><op-code><assignment_flags>"
>>     
>>     * Non-default CTRL_MON group:
>>             "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"
>>     
>>     * Child MON group of default CTRL_MON group:
>>             "/<MON group>/<domain_id><op-code><assignment_flags>"
>>     
>>     * Child MON group of non-default CTRL_MON group:
>>             "<CTRL_MON group>/<MON
>> group>/<domain_id><op-code><assignment_flags>"
>>     
>>     Op-code can be one of the following:
>>     
>>     = Update the assignment to match the flags
>>     + Assign a new state
>>     - Unassign a new state
> 
> Looking here and the implementation it seems that "+_" and "-_" is supported.
> I think that should be invalid. Only "=_" seems appropriate to me.
> Also please take care to not have a catchall "default" that does an
> unassign. Doing something like that will prevent us from ever being
> able to add any flags in the future.

Yes. Good catch..  Will fix it.

> 
>>     
>>     
>>     Initial group status:
>>     
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>     //0=tl;1=tl;
>>     /child_default_mon_grp/0=tl;1=tl;
>>     
>>      To update the default group to enable only total event on domain 0:
>>      # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>     
>>      Assignment status after the update:
>>      # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>      non_default_ctrl_mon_grp//0=tl;1=tl;
>>      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>      //0=t;1=tl;
>>      /child_default_mon_grp/0=tl;1=tl;
>>     
>>      To update the MON group child_default_mon_grp to remove total event
>> on domain 1:
>>      # echo "/child_default_mon_grp/1-t" >
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>     
>>      Assignment status after the update:
>>      $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>      non_default_ctrl_mon_grp//0=tl;1=tl;
>>      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>      //0=t;1=l;
>>      /child_default_mon_grp/0=t;1=tl;
> 
> This does not look right. Why did domain #1 of the default CTRL_MON group
> change also?

Will correct  it.

> 
>>     
>>      To update the MON group
>> non_default_ctrl_mon_grp/child_non_default_mon_grp to
>>      remove both local and total events on domain 1:
>>      # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
>>                    /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>     
>>      Assignment status after the update:
>>      # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>      non_default_ctrl_mon_grp//0=tl;1=tl;
>>      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>>      //0=t;1=l;
>>      /child_default_mon_grp/0=t;1=tl;
>>     
>>      To update the default group to add a total event domain 1.
>>      # echo "//1+t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>     
> 
> Unclear where "t" flag was removed.

Yes. Will correct.

> 
>>      Assignment status after the update:
>>     
>>      # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>      non_default_ctrl_mon_grp//0=tl;1=tl;
>>      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>>      //0=t;1=tl;
>>      /child_default_mon_grp/0=t;1=tl;
>>     
>> f. Read the event mbm_total_bytes and mbm_local_bytes of the default group.
>>     There is no change in reading the evetns with ABMC. If the event is
>> unassigned
> 
> "evetns" -> "events"

Sure.

> 
>>     when reading, then the read will come back as Unavailable.
> 
> Should this not rather be "Unassigned"? According to the docs the counters
> will return "Unavailable" right after reconfigure so it seems that there
> are scenarios where an "assigned" counter returns "Unavailable". It seems
> more
> useful to return "Unassigned" that will have a new specific meaning that
> overloading existing "Unavailable" that has original meaning of "try
> again" ....
> but in this case trying again will be futile.

Hardware returns "Unavailable" in both the cases. So, thought of 
reporting the same without any interpretation.

> 
>>     
>>     # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>     779247936
>>     # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>     765207488
>>     
>> g. Users will have the option to go back to legacy_mbm mode if required.
>>     This can be done using the following command.
>>
>>     # echo "legacy_mbm" > /sys/fs/resctrl/info/L3_MON/mbm_assign
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>          abmc
>>          [mbm_legacy]
> 
> It is confusing for the value written by user space to be different from
> the value displayed: "legacy_mbm" vs "mbm_legacy.

My bad. Both should have been "legacy_mbm"

> 
> This is still missing information about what happens to the
> counters/events on
> such a switch. Will events just keep counting? Will they be reset? ...?

It will all reset.

> 
> I also think we should try to find a more generic name for this file.
> "mbm_cntr_mode" or "mbm_mode" maybe?

"mbm_mode" looks better.  Then I will change "legacy_mbm" to "mbm_legacy".

> 
>>
>> h. Check the bandwidth configuration for the group. Note that bandwidth
>>     configuration has a domain scope. Total event defaults to 0x7F (to
>>     count all the events) and local event defaults to 0x15 (to count all
>>     the local numa events). The event bitmap decoding is available at
>>     https://www.kernel.org/doc/Documentation/x86/resctrl.rst
>>     in section "mbm_total_bytes_config", "mbm_local_bytes_config":
>>     
>>     #cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>>     0=0x7f;1=0x7f
>>     
>>     #cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>>     0=0x15;1=0x15
>>     
>> j. Change the bandwidth source for domain 0 for the total event to count
>> only reads.
>>     Note that this change effects total events on the domain 0.
>>     
>>     #echo 0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>>     #cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>>     0=0x33;1=0x7F
>>     
>> k. Now read the total event again. The mbm_total_bytes should display
>>     only the read events.
>>     
>>     #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>     314101
> 
> According to doc, right after a BMEC change the counter will read
> "Unavailable"
> is this not the case here?

Yes. First read will come back with "Unavailable". Will have add one 
line about that here.

> 
>>     
>> l. Unmount the resctrl
>>     
>>     #umount /sys/fs/resctrl/
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger

