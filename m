Return-Path: <linux-kernel+bounces-572067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79152A6C61B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E917A6572
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B522D781;
	Fri, 21 Mar 2025 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EF0lzY4K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED11E7C0B;
	Fri, 21 Mar 2025 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742597650; cv=fail; b=Nx9ewhbq/vjDdNly3+ZzNMzzgEyqep8i6uOySBx5xGLnE6G8ysXLEbvD9ccBqfq3zhzZ0gRvKqUbVtKwkbyldDSdhQol6durcE5scV53EtBjL0Z3NP1GbTYm0+jra/cdFbCPFw/qxY+gvNXZnOHZ8WZ04ynPizWuaqUGAWMxv1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742597650; c=relaxed/simple;
	bh=mvhsFoxb3knbjZBhAwYlJyOrbhiKPHBfO+JiBw/JYd8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lGQ1IPOR2rsk4l4eqB+BorulApMm/btBdBNkwmmmwb2+SPL+bmJH6/DlhchV+e6+4Rz+8nfTI344GC5FqddAjl0APzOnYcWjCXRE3aXc4+8nPaTV7gt+ysB3gxdm4NC5mBeGjYGmPY08BfUSWNh9+PE7hk7hM/0if6BCNya5eoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EF0lzY4K; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742597649; x=1774133649;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mvhsFoxb3knbjZBhAwYlJyOrbhiKPHBfO+JiBw/JYd8=;
  b=EF0lzY4Kjj/gxf6GPPCQVpHNflu1JS+21OerUqcyhGVEykuD1CFc35oT
   +7vNB0K106cF6CoiZTXbukPQVM1jKE7FrTJpN21MF4WjU5cjAMyWpUSQX
   YGoOTU/sUCevmNSHtZgcfnxCLmL7A7nMdLarhincAsDks8mFz7UZ+molL
   V7G34xf1zNcOQcsSFh3fOlwmAV5hMWUqq6RPK7ntHL9qFsQIz7i7m8K/N
   PntbMUr/PLm46Un80OL4wBo3kcVVs7IAlaoktd+yyOKDx9uNgZ0+LTkp3
   Kyke0b/mpJe/F8EYJqWTT0zgnjh60FSQQ5jjuU54/hS1uyXpkc22YzLvV
   Q==;
X-CSE-ConnectionGUID: 3Mgr6KiPTQCiDkyma9+F0A==
X-CSE-MsgGUID: k4hOyxL/TCG3c2b1yGbV0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43992569"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="43992569"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:54:08 -0700
X-CSE-ConnectionGUID: ruRVGlxzTTCfMATmIpajCA==
X-CSE-MsgGUID: TQX3qPa/QC6+glBGoyp/cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="124045282"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:54:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 15:54:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 15:54:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 15:54:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTHWl6/lPAOlgla36gWkz65qb2ZbYKPeOlwu3EBLcOvhtwh5anuv448LdM+zlPjOlI64RHwHh76LK3+4VXfWENSpykjz/0W7q5GVasH7CYMAvZOgw/hvVruhorwl1lOq8bsXWL8AWBUQtLDbb9Pwt1Y1pJPp45NAfEaclvmrZTuJnTYjOBU+1d+PYSj+6c7XluD/bRumWDQoxybEzWyeLLx7wdOio1nt+rXbsNuG83BuVLJO0x9kqlp1erRhauxOM/VP2qUuFeIRf5WrrCuq8Qk45y/mo2hQJDOy78JOo2dzRn1ukEdy5AE2hG8FwStULISR1RY6grimiTs01Zu3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zzu0EKtwR+IRJMaPU3w64/3H49qXVANepcNR3fL365U=;
 b=jIyZS5aqnWwQsMVLcorhogt1xIPj0Boe89zQmIWtwO+YHEQORnRjj86fsV2Cy94tiwcfnof8Tdv6H8YYxcX0GwLU2tc86729/1Q8KHiybq01MLxkM8hIbfyVEbnyyfSI2XjHc0r83saln4XSToPwEvcmZUE5ZGgeUSPavjFiglwW5B+RWKH01aZRxcumoO3YjpqBTG7F/lqdaENsz9QySBa+TWFHh6xlT3J5jg00S//vaWBVp2IlHB407S76jD9oEc31Bj7A/R0tQVXv0/ABJtym5sJNzyAav7arz2fUtzF1zCYoVriehZAlhe56uOZ544aXGVZEnsOSEx5rOZYlXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 22:53:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:53:49 +0000
Message-ID: <f1a67245-4c29-4b31-9e29-58d6b3b2676f@intel.com>
Date: Fri, 21 Mar 2025 15:53:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] x86/resctrl: Implement "io_alloc" enable/disable
 handlers
To: Babu Moger <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <thuth@redhat.com>, <rostedt@goodmis.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<jpoimboe@kernel.org>, <daniel.sneddon@linux.intel.com>,
	<thomas.lendacky@amd.com>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <seanjc@google.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <tan.shaopeng@fujitsu.com>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <peternewman@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <corbet@lwn.net>
References: <cover.1738272037.git.babu.moger@amd.com>
 <dbb4447267592aa731c8fbe1274adf81b0ef2103.1738272037.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <dbb4447267592aa731c8fbe1274adf81b0ef2103.1738272037.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:303:2b::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 21275151-73b7-4212-57c7-08dd68cb3e46
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0diUGV4OWpPZUhkL1lGeUFkQ01FRzNMM0ZSOEZvZXlNNlNsc0dtRENTUzR5?=
 =?utf-8?B?R292RWswb2ZIc1E2QWgrdDA1WkZ3QkhWYmlPbW8vZXozelVEdG0wQmRDNERu?=
 =?utf-8?B?MGxqaFY5a0NkaGR2VmZWZUJmNUtOcTdSTEQ3KzVnMGJEMmFFUUJsS3RkY3J5?=
 =?utf-8?B?dXRIUWsyRDRCMW8rclhqR3BDZzJlL0YyVGlzWFdWOS9TOWFuSUZXUzNCMXBu?=
 =?utf-8?B?ME5LblhLQk9rRy82N2g3bUNiZGg3cW1IbllyU0I1MlNIMTBRYTVNb2dHV3R6?=
 =?utf-8?B?NVJsS2J4NXBOQkhuODllQTJ3MWpkTWthS0ZHNlJUQy8wOW82YTNoNG9IOXpM?=
 =?utf-8?B?QUk3bS9INnlkZ0JQRHp5MTQzOWlhSWRZazl5ZDdzcERXNlRNdzg0VDQ2bUJX?=
 =?utf-8?B?djF4RlhyV3RYc2RsQi95dTNrK25qRDhBbGd0OGh6VVI2Y1lDc3paTWowVGF0?=
 =?utf-8?B?d1BzcStHVlVIdXp3NmlESDdWL3pZR1NDNUxYVC9TSkp0NktiSmp3SGZLMjVE?=
 =?utf-8?B?aTFuKzJ3ZlE2R0lublRRclJjMlc1SHlYUVI4M3V1NCtEbXpPbldscm93NFAv?=
 =?utf-8?B?cy90YThYQUJhWUJLNXdBR2VhZ0o4bFVTNDFpcFFDQlpQNFYzZExxV3NuRmxw?=
 =?utf-8?B?NEdpTFk4Z3BXekJlNmZnSlJCK0hOb28vMmxYRzh6eW4yZjhZYjRwblprVndm?=
 =?utf-8?B?NmFjZkhkdFlKWDgwVWkxSHhGRG51RVV3bFNDYm0xSWxDczMvQ09LQkJnMTFn?=
 =?utf-8?B?Q1hpekxud0s3QkgxcTBEcHpCU0lCK3YwWE1GZEZrT3JVYUlDNHptMjdGM0JD?=
 =?utf-8?B?bmxjdlJ4UTV2UmUrME1Kb3l2ejBFYTlveGRET1hIbkRseElFVGtRaXJBMmNY?=
 =?utf-8?B?eXAydDN4RE9RN1hKWWV6amh6SmhsaGtpNlkzMit5RjFEODNsVkVVZkh5U09w?=
 =?utf-8?B?dTBjVW55Uy9YMVl4YzEwcVhSNS9kSldPaXNhZko4OHk3NXIyanpmeStTeGxP?=
 =?utf-8?B?Y2t6VmpCdUxOTGJrU1ZpOGRmNzNNR1RjZlAyZzBXODZzYlA1NXBsTkVvWVBF?=
 =?utf-8?B?eHFmZzV2UHlXOFRIc1JFdlUzZGliYWFlZFgrNHpZSmQ0VnYwRnlOVjBTN1Vy?=
 =?utf-8?B?Tjh2RlRTODc2ak9ra2xHME9sUXFUbFN1amdWeDR1aHBobjRuSXVteGVpMmtw?=
 =?utf-8?B?eEpZNURyRjlnT2JwU3ZyOG4vS3lCRzBOb3F0aktqbWZadU13Z3FIZlRseGgv?=
 =?utf-8?B?YWpTV3pRZXcrT1UvUm9ET0o2cTNNeG9JZXl1YU01U2g1WGlEU0c0V2ppUktU?=
 =?utf-8?B?RE82SGdPVlI5UUd2QStqNmE5bkhLM0dUTTNtaHcrRDd5V3RUajZrVW1uR2Z4?=
 =?utf-8?B?R1RHZEJCQmxiQVBhc0Z5b01tN2FyUnBlM3dac2Fka0hXN0tZOG5MeVlLWUs5?=
 =?utf-8?B?dEtwSzdDV1R3Q3UxWlpQS1hvOVd2NXd0RmpCRUdCZHNRdzFVNmRvcVd4ODNS?=
 =?utf-8?B?dWNjZFhMTGxGNlBLVi9aSlJTZUJwYnhIZnJDNFFIZlp3QXNFNGMxNjRGOU5Z?=
 =?utf-8?B?Tm92NGRldUJpMVBiVmdseFpTenZmNnB3NU5teHRGZFpJaTZ4RlFpWW83Uitm?=
 =?utf-8?B?dGlqSVZ4KzN3TUpPRm51R3BQQkhoOWI0TFh5eDV2QldkOFRYME9iODEyNGZX?=
 =?utf-8?B?TjhRalJaWjJiR09OaUo0Tkk0Q1dHWHZkT3ZpWlFQc21TS1MySmxsQVpmVnZV?=
 =?utf-8?B?ZnlMQzFMbUgxNksrNGl6dnJQaUhsM1VEVXI0cXA4azYvaS9QUVBhQzhjWHJy?=
 =?utf-8?B?aWphTnFtWGlFMENhVU1HV25PeGhNZDVudUFzc3ZzbEVta0IrbUlpRHRxZDdo?=
 =?utf-8?Q?WqZfjADKlnkWw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU5wZzhrWVFYNFIvQVYxa1JuSVVSUFRyWDVXdzlRTGpzSkRwQ1RyQUppUHMv?=
 =?utf-8?B?cXlQVU1TcEVqaWdPVDRsREt5a3FNUzJjRGNpamdzSUZnZ2owSzM1QlRKcTRo?=
 =?utf-8?B?WmVLZEY1dTNJb0dpL0JlaHRRM0Zma3BUc1AvWVZqNVNhOWlpZDRBQ1Z3N1M0?=
 =?utf-8?B?U0VidGN0c0E3KzRxc3BDanhyN25IVzJUUHpZSGxsa1FFcUYyZ3U2RktBTWds?=
 =?utf-8?B?eGZneUxnTENydm1SZHFKYTlIUWdObkVBR0hwaUgrMURZczNkbzYrbXBVU3Jy?=
 =?utf-8?B?TzAyaFRKcmtiSDRkaEc5ZlZNTXpkeFBLbGNiRzQ4ckExZnhrZkFiell1U3Yz?=
 =?utf-8?B?aVNFdGxTRVZVTmFrTmk1YlNta3Npa3R5ZXRXMDBDbkRQc1EyZm5CZkc0Tmla?=
 =?utf-8?B?djlSQisvRU1nZkYvSnMvOWJRN2h2d0Z6KzljRjN6dzlhUjRsRjJPaW1uaC9M?=
 =?utf-8?B?ZXZVNnkvZmp3MERQQjdKZ3pTRWk4and2LzhvWGptR3FoQ2lFMGVqU3RuSzFC?=
 =?utf-8?B?TFZyaW1Wc2s2TG9yYWZyd0I4b0NqRGFGbWpycnk3YzVNR3REWU8rSk0xaHZ6?=
 =?utf-8?B?eW81WHYzcDkzYUE2UVRuRUhveUFzTGJQcXRPY2REaGdCMEhBNi83VHhmN0NU?=
 =?utf-8?B?OVBYZlNOQkRaZVZ0M1RPTHJ4d1RjWUpvbVQycmpmOEMzRlJ3b3g2SG53MGZM?=
 =?utf-8?B?RlJUOUNTUE1UNVk2OXUxcExlYVpId1BwS1BtVkZFVnIzalk3S3d4UG8xMFp0?=
 =?utf-8?B?Qm0yNGVNcUx6VlhRSEt0bW1YVlhNd2grY2ZScHlqWWwwQTdSM2RxSGg0NW4y?=
 =?utf-8?B?YXRZTWVJY1BuK3djc0xOL01aVHBaeVdRZ21yZ05uTkh5aU85ZHFYNmwzMk9W?=
 =?utf-8?B?dTF0WmZ0QSttNjZmQzBHMXpHdkRsQUxnZWViQVZmc2ZOcnRmZGVXOHFCQ0JZ?=
 =?utf-8?B?eDNRaEFNeG9IRGsyZ0p2dHZYSWVOMC9aaVNQN0RSODYxMjFMNEN4ZzlzZk1V?=
 =?utf-8?B?NHV0d0g4SERkZ25ycjJ3L215N3RtZ1pTSTV4YmdkeVFMUDV0K2xpUmJGc2dH?=
 =?utf-8?B?MXdieGZTRWN2TW9zWTdJRE1LbGcrZk4zbk9pQmJZSVlxK1pxVVljUkxoU2Fu?=
 =?utf-8?B?ODhiUkprNW1ZZDQzc3FyaWd0UnJKYXlIQVZ1MGVoSFRObUE3RW0yR0dGWHdX?=
 =?utf-8?B?YzJnR2VuMDFlY2ZQU3VXUjFxUkpCSU5XWFowVThXVmhka3hqNUV1Y3ZpeVR2?=
 =?utf-8?B?SHBVdy81czNxMGpvemNZM25tR2JHMGVvYWhYOSswd0l1MldqZGlJWHZWOCtx?=
 =?utf-8?B?Rjc2OXYvc0FLMWN4ME92OEJ1N0xHNUwzVE9BTERRRlg5N0JEV2U1bVhkSlkz?=
 =?utf-8?B?WjNVK3ZXcXYvNURxYXdhTnFKWXdoanFNOUcrTy81QiswUXRTY2czbDJWTDIr?=
 =?utf-8?B?SnZ4ajNLc3dLUFN5Ui9PQmpsRmx4Ulc5M0k5WTlpbFluWmV6aU9zeVRxQ0Ey?=
 =?utf-8?B?dVkwdHE2Mm93djdBZ1FaajZKWVY0ZXloWnZFamVDUVNBODZHOGh6Mkpmd2tl?=
 =?utf-8?B?eGVTMG80NkVsVHJRalJrTTBWWUNXNWdLelhuc0p4MUIvejRPSHdUWkp2cHN6?=
 =?utf-8?B?dmFtNGJCRGE4MTNIb0EvTWc5RHV3N3JrWmo3cVg0OFBYdTgydkxGUVFoL0lS?=
 =?utf-8?B?cUxpb2VSRkxMbGl1ZVBLM2s1Mis2QmZEZUROeVgvcHdRNXFQMmVvVmVQV0Vk?=
 =?utf-8?B?dGx4M05iY3g0WkE4V0l4YjJGRmZnSWMwVUVyNzRsV0ZrQ2tVMGRGMWpzaFda?=
 =?utf-8?B?NkN3MzB3T2pxcUhsZXdDVkt1RzRqR2J3Ukt1UVZCRTNWQjA0SGRWcGNweWVm?=
 =?utf-8?B?VW9mdXo3SlJNdUFJS2JDVGZyaUdOL2hqL0pqaWwwdVlDWWIvbW4yeEEyaXQ5?=
 =?utf-8?B?a2hLRlVXT1c4WFBKL2ttTDNNaS90OXcxcVVoTjFjd0RBSzJURDF4bFNmK0pq?=
 =?utf-8?B?N3pXUUVlV0lUdGNIRW9oVmNSWHNxeUEzaVEzTTRsZ0RWQmh4cUJlazJNTjhq?=
 =?utf-8?B?SnltZHhXL2MrWGhGMXhDM0xtT0sxRGYyUldOZFBLdGVUZ2IxS2ppUE1zUktT?=
 =?utf-8?B?WHByM3VnaTEvdGJySmdlbkdEcHVrUDBEdnZ1WG9NeklzL3dKZzllK2J2Qmpi?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21275151-73b7-4212-57c7-08dd68cb3e46
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 22:53:49.0256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQbJsghgwSCGKsrD0xFkAfBL+A/9UAJtf8vNJmf88RsV+zcALj8WLPEp8Z0z5tqGpCZ43+8VR8HAukJPEoy1Ew3o33ce0toOFjugfZkUhtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com

Hi Babu,

On 1/30/25 1:20 PM, Babu Moger wrote:
> "io_alloc" feature that enables direct insertion of data from I/O devices
> into the L3 cache.

Above is not clear to me. Should this maybe be ""io_alloc" enables direct insertion ..."


> 
> On AMD, 'io_alloc" feature is backed by L3 Smart Data Cache Injection

(mismatch quotes around io_alloc ... also below)

> Allocation Enforcement (SDCIAE). SDCIAE feature can be enabled by setting

"can be enabled" -> "is enabled"?

> bit 1 in MSR L3_QOS_EXT_CFG. Apply the updated SDCIAE value across all
> logical processors within the QOS domain when modifying its state.

... it could also just be "Change SDCIAE state by setting (to enable) or
clearing (to disable) bit 1 of MSR L3_QOS_EXT_CFG on all logical processors
within the cache domain."

> 
> Introduce architecture-specific handlers to manage the detection and

This patch only seem to do the enable/disable with detection done in
earlier patch.

> enabling/disabling of 'io_alloc" feature.
> 
> The SDCIAE feature details are available in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
> Injection Allocation Enforcement (SDCIAE)
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index dbe6461f3fbc..e77c3b37bad4 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -343,6 +343,15 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
>   */
>  void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
>  
> +/**
> + * resctrl_arch_io_alloc_enable() - Enable/disable io_alloc feature.
> + * @r:		The resctrl resource.
> + * @enable:	Enable (1) or disable (0) the feature

Please be consistent in using periods at end of sentence. 
This could be made more specific with:

	"Enable (true) or disable (false) io_alloc on resource @r."

> + *
> + * This can be called from any CPU.
> + */
> +int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable);
> +
>  extern unsigned int resctrl_rmid_realloc_threshold;
>  extern unsigned int resctrl_rmid_realloc_limit;
>  

Reinette

