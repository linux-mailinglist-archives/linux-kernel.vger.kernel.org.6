Return-Path: <linux-kernel+bounces-570160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A13DA6ACF2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D1717401F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EFD226CF6;
	Thu, 20 Mar 2025 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hAdfJCFw"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09222579E;
	Thu, 20 Mar 2025 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494372; cv=fail; b=MJ2SmFq4HyztLrvGadRLg+7xH8uMF17AmVg8W2ks+uE7WpXunbI9jH8cBHR4YgpftEaUviD4gEhIMnLi1P+2cKKtKTv4Y/ctoyaE4C4mMLcA45allARH8xnwc/huaYzFkKmFwYKnJb2CwPkmjKbTI37NDwGUv2mwWZWMcQN5kOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494372; c=relaxed/simple;
	bh=+XBLD028e8VSYHHp3YRb3yiOz7l358j0tJZzJL/EVyw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QEuiUohosj/O2pZe41qBkitZ8+9AgAZEHEp47BepEP8u7Uip7sYstHr+RX2FyrlXlPryoIBwpDDQzHSax7FUwmIenfnUc9EjeQkv8tX424Tran+beYHYDj4JuYvG+HO/Flp58EDJctEb7g+ZExpEvB7m0+NQTAb4b9A1Bpj+4ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hAdfJCFw; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DulKySSlVR19Cfe/CDxjitbHN96Z5uF3ihNq0JALbkhd6GosB4bjzvG0RWHD7Z7JdyyqvoxEnoo8KDZs+XcZq86N8YvyI92+k5rg34KZGrpgB96LiP6Df6knmmACktYtraPvULcFXTx5RG994yS6PyfYALeUfZ0uPpz1sTJ3DW4057nIrkDw8yHRD34Wg8hp0kAOFJGgo27OoIelFX/9lPy+Nd/Z7ci8LwtBx7WNxbRO1mYaFzxI/3MWQ1gCNaBNsBTl5L1f8XzQjYXDxzC7sXw0O4h3WjUU96C9mGgi5qUx53gTS/mJFT9akK+j0q4bRUsw1mjn/qE+z6o0gfY7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8/z+KO5wmn3+OnlT5I2Qe/aeYcYHd70jN/HIfxOXjs=;
 b=dWr74TeHopjB2Jz+t4YAUYeivYWN9UDuzjnH9pnT+oxlRb+8H20lGQTgJAF03fQo2Ocu/u75szauEvRwmA9Y/U+0Cf6iDZShj3+4+XuGdR44nGKl4sK54I3EpYwmPX/HIJftYDXHJW7bpLIqwl1UaeSARRk+IVxkH3aYtNTp80Ob4NE9cspdPeMgZsxOGhzGrCF3Pu+rzXXpwDjTclNaUXUoJTdSDh03cQOkpoHjJ0QcBRLZ+FQffl9rA3EZAgCG5H/hxO3Skm4jvPwjAkDDMszEeMqBwbFrpE51Gb6ZrvrDlKnySY8aedSui4q5znmEpvJWwz0LURWQfwwRreJ00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8/z+KO5wmn3+OnlT5I2Qe/aeYcYHd70jN/HIfxOXjs=;
 b=hAdfJCFw5a0jSH0YWQIqP6TeZG9pFTps1mEz/byJb8wJ29NXA3n23v9qnKwbEktHQb5B5ycbSUBB5pqWX6xrdTtkr6+hWG9fyxOxKWryxAM+dx2qdah0earIoiFFydeFREdrhrJyNVbgFyh+yYN1zNq5pY0Ick58dAn68FFB4vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 18:12:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 18:12:46 +0000
Message-ID: <1244c9d3-233a-4da7-97d7-2c4097b3741b@amd.com>
Date: Thu, 20 Mar 2025 13:12:41 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, "Luck, Tony" <tony.luck@intel.com>
Cc: Peter Newman <peternewman@google.com>, Dave Martin <Dave.Martin@arm.com>,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com>
 <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
 <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com>
 <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
 <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
 <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
 <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
 <7f54f9aa-1102-49ed-b830-6facb6f48366@intel.com>
 <c840cb69-41fe-49a8-a7a8-d75f68e1d84c@amd.com>
 <0cecd52d-253c-4b2d-9841-a86870d5945e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <0cecd52d-253c-4b2d-9841-a86870d5945e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:805:de::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: e2221055-608b-4e65-4afc-08dd67dad0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlRIbG44RmF6M21rTUZTVG9WcnlVQnVlR3VyMmk2YXA0b2k5UDRZQll0MnZG?=
 =?utf-8?B?aHN0T3hOY0FGbnE0Um5qc2c5Z1dQb1I2bG9TMlJvT2NTa3FPQk0wRTdWQnlr?=
 =?utf-8?B?YXFBb2JkMENKeWRNY2psaVFZejlQSHo0NjVZV0l5bm5wZHcyaUxjWStkNVRF?=
 =?utf-8?B?UFpNc1haUWtkQmcyR1R4SDRNTWcxRFdKZUhMeGtsNk5TLzNIRzBaRFgvbXhX?=
 =?utf-8?B?eW1HeHFFSjluTmtaUHJPNmJJVi9OTGgxUVVzSmpHVEYweTZVbDVWMHZodkx5?=
 =?utf-8?B?dVlzY2F5eE5INEh3UWZuL2VmOWZGaTJCRkZOcEZucnhyVE01eUhwNEZaWWdD?=
 =?utf-8?B?SHBZMVBac2lTNWZIWlBFdU5DRE9NczVZV2J5YWlzM1BhUmRVdEo5ZlpYMUNq?=
 =?utf-8?B?NE1EZHlUYmZUSWRzMnVoOXp2M01Cb3hvWHlRdk93SHNEa2lOVzlmanprazVo?=
 =?utf-8?B?NGt5RFVqbTNic3pTWWszRzl3YU5ObGVmMTQ4VzBFVW1iazlWQjZyMUY2amhG?=
 =?utf-8?B?RDE2NnFZQm1BdUtleUVuMm11ZUdEMkJWaEJRTUZ0aGRqS01JQWJJMXJ6N24x?=
 =?utf-8?B?U3JzZ1pyUjZZTjR3RmNYb3Urd2hzNzhvL3dFVjY4cVlLNUo3ZHo4SXZsSXpj?=
 =?utf-8?B?WWRiSXNBRUxBWmVuQ1pCK09uei9oL3QyRTY2V2tEaFJtQmErWTluYkhFQnlv?=
 =?utf-8?B?LzM0ejNiREtrOTNkczRQdlN3Smo2MmFjK1kzZDFCNEdrZWFTTlhBOVNJWE9s?=
 =?utf-8?B?dXlXci9NQW9ZWmx0THhGelNwWFJaSmNqekJsblVvUzMvWERMTVFhcEhOUUFQ?=
 =?utf-8?B?MWxacm5jSTh1Ynh3eWFFSExYclAwR1NIcDRyWlhYeDhZMnVGMGYyV3Jrc1pj?=
 =?utf-8?B?UVNKYnNEZVhOa3JLNlFrY1FKYXo1am54UE40ZGN0cU5kK2tOQW44ZFM5alp0?=
 =?utf-8?B?OVdHRHZPdStITUNWVDBDbzA2UWFxZG10NTBwcDFKQU11Ulg3QnNBbHNPTEEx?=
 =?utf-8?B?VHRFSW00NUErRkpqbDFVZjl4S0ZmeTE0Nmt3UzFFN0lITHJVdzZONkJDV1VI?=
 =?utf-8?B?NFNZZmpncGROckttc3U1UlNHUmp4VzR6NFVaN01NeHpmYVppZCt0ejNKUDR6?=
 =?utf-8?B?QUl0RklwOWVGbTBjdk1xT21tUkNSbE94TExDcEFTSDIzbE1US0tZK3IxNHg3?=
 =?utf-8?B?YlY0QXp5ZHNXSUlwNkdXa3UvQW5RTmdxemRBNXM0eGFWTDJmTFU4QTU3THk4?=
 =?utf-8?B?ZXpXSmh4VFFnQUxlUG1wOURRTzJzOUFRWURHYTJqa2w5ZzV3ZXphRHN6VEt5?=
 =?utf-8?B?aTNxNjQvMzdWTGwvRnh0cllaYVpYR3BodStGdjNjbGJUeW9VY2xBdjJ6bkNy?=
 =?utf-8?B?djVVSFU2a2pjOTVRNFBNck8vNVhQbFdpSzhoVmwxVkhxT2NaajJPL2plTGtt?=
 =?utf-8?B?NXYyUkd0Nmh1Rk5DTUo0cmR4ZVpwcDFFa0Q3M2pia1h6THVhSnlpR0xwVTdT?=
 =?utf-8?B?RkZDUEpHZjRMTDgwc3YyME1xaGJsUzcyc1hkMitacldPaURxZjF2VGRFS3ZB?=
 =?utf-8?B?TzlwS1hRWjFGQWhHQ3VoeStiK3pMN3FYUzZUNENrNnZyK1d4WVBkSjlTOGh4?=
 =?utf-8?B?TTIyTTUrK2ZUQU5pUytvRjhIQVBLQ2pSaHhyTkVCZ0NaQ25ZOFp6cFI2MHVS?=
 =?utf-8?B?Y2NsOUtJUzU3Y1JITVFFUkVscjJMZFRLUThnWlJDWlNqWHdhdlRxVXQ0RDdC?=
 =?utf-8?B?NHp2MC8xK2dGVFErRnFKTFpJMUxldHRaVEJtVEx6SVErWEpsczg5Yk5GVUFC?=
 =?utf-8?B?d2lvdElacmFxOFFCeW5yWGZ5U1hSem1YTCtjSGZKWlpFaXJPc3JjV0VpLytW?=
 =?utf-8?B?UG01ZWlQV1BUMGg2SnVhT0JUenBFS05TeTVtV2JLcFo0VXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW9SdXJoRDFldEdsOEpyUmZCTm9JWmVJZEZ1YmpxcS9zUmNWWG5PVWhieWpk?=
 =?utf-8?B?SUpqanovQXlkWXFveHd5cFRpcGRxVURCQmwvcGhTeEVKdVN1dEFOSmh0aFFa?=
 =?utf-8?B?dTdXSmF2YWQrY3JJSXhFQ2srbCswUDBGWERLNVRHUTRPc3g4SkZZam9JRHF2?=
 =?utf-8?B?d01oUE1nRzkvZDJTeU9NNDcwMG1ldy83dnA0UFFvSWE4RHBzL0R2b3QrQy9X?=
 =?utf-8?B?akFkQSt0eld6a3hJZndqaGZSWE1ZdExRV0lWZFlud01BdmJUWGp6VFZhRVlx?=
 =?utf-8?B?R3lneXNXdDlkKzZPYmd3Y2pnOU1SNWk0c3RqcmJtY0ovWVdRVDA3U2Jsd2VB?=
 =?utf-8?B?LzE5K20xUERJVUoyWkl4NW1QdmZEUDFVTHVBNjZSMzk2TDBUT3k3MGxZYzhG?=
 =?utf-8?B?WHRwb3dwT3NuSzNNTzU1Qzg5Y0QrREMzVHZKZnNJVXBTR253cUtPZXh5dVBD?=
 =?utf-8?B?MUNFS0Z1RzBRdk5KTWwySE9aSUlobzhjZXREY25mTkdOblFvRE9UeEJhQXdZ?=
 =?utf-8?B?WUcrbkpZSzVjYmhBYnFsaGRuYnpPeUVwR3ZNWktiZk8rdW1nR3F0L1hMajJh?=
 =?utf-8?B?MGxQZ1Rkd01JRWxIdEcyUXhSb1REYnRIZzhOazZMMjZBMjljd0VMV2F5Nm9V?=
 =?utf-8?B?TEpYWTUwZVBJY2R4YVJSZ1BsL084UWl2L3VUOERJOEdwcWNhSTVKaFl2T0ox?=
 =?utf-8?B?SDBVRWl5UnF3bURMMHpuQVVPdlJZVnk4bzQ1SXNXMHMvdE5maE9iZkZBMXVK?=
 =?utf-8?B?dDBEMzRkeXlJNXN3Ym1UKzZMVmY4dko4NVhVL3JtYmlvV1ltYWVaZzlRQWY2?=
 =?utf-8?B?Uk1nRlp2aVhqdHZYTVQzQUl6T3hXaEJMNG00MjNtckJ6SUdHRUZ1WVV3Q2hi?=
 =?utf-8?B?bDd0U2JYc2xTbUNObEdnMFljbU1XdHViak1kNkJvNytvZ0JNT0lxanJZTDBR?=
 =?utf-8?B?MElRcUUxOThBQlRJcng1ZzB3YldlQlZKK1lWck1OZkUyVjRIK2JrUkxjSUhD?=
 =?utf-8?B?NUNYOFhzN0xrYW5CaDY4UVBWNWszZzhmMnZOSmIzeWh1bjdHRXAzWkVYU2V0?=
 =?utf-8?B?dlFuNnRlbTRLRVhnYi9kaFZOUGhmWHM1TnhQQXkrUTM1eHc3MU9DaVdlQlRN?=
 =?utf-8?B?bmR1SWhlTTkxajk0SU1uR1V0TkpjSmNhS3U5L05GVlY4WXVGZkhkcWJtUnVZ?=
 =?utf-8?B?SUNHcHBEOHRaYW1yc0lHaWVzWkdPaFhlUFRHNFk4U0FZWUZyQzFwTEFyUTRn?=
 =?utf-8?B?UHRVZnVsbUU5V1M2UXZFVGcrUmVYN3FWaW03L2tNdHNsOTZrL1lROEI2S2I0?=
 =?utf-8?B?QVBvYmtNKzFROXZUMUZUdFVTdzljbUE3T0dVS3RTbEtvV2tLQU93NlM4bHNE?=
 =?utf-8?B?ZU45bmd0cXA4UDA1dFZCMUptTllobkplSWt4WnRJM3FXRmNjemc3UkJlb0FR?=
 =?utf-8?B?aWlsWS8vaHFVaWVmS0hLSDlVeUFiejY1c1UxVlE2OW1ZT0cxZmg1VHJKeE56?=
 =?utf-8?B?eHA2UzVkTzIyMDV2QzNvMnI2WEFsb3RFTFl2RnpJL2RrV1hFK3RUUnRTazA5?=
 =?utf-8?B?N0hhVWNoaXhRYzQvcVhXMlZWcEw5STdDTDVWdStIWHhnYzd0bWcyU2ZLU3Rw?=
 =?utf-8?B?b2wzVlVKam5tYlZpRUM4NkErQlhKQ3dNeFZnUVNVczlpdlU3TFVabU1OSHVM?=
 =?utf-8?B?Um1DY2szUXhBTDdVdldoUnZvYXQwVnRjYWVWTDVoQ1ZUWVA0bDc1T3JVTUxo?=
 =?utf-8?B?VXdrMHlLdFI2ajdmd2I5NnFraFRmUjhpOHdKaGhVRTc5UkU3OTlHSWhrWWpL?=
 =?utf-8?B?WWh5QW90c2JTVGh4K1NtRTJ4KytodnhsYUVXREtQRnZYMmJiNzRucUlmTEtt?=
 =?utf-8?B?LzA4djRFMC9ETFAyN3ZUN29aQnc1aTFlWW5LNmdRWmIyRVNWZHBGZUQ5aGFW?=
 =?utf-8?B?Mkh4Tm5iWVpCalNVVmdTUXhvc2I4NmUwd0JTVUUyQzZ4RUlGUE5MV3EyMFJM?=
 =?utf-8?B?UlBuRmZOdU82akQ5RVFTaDI5TjNodkppMW1id0FoY1N6dFp3Mkg0cVZJRVln?=
 =?utf-8?B?QitEQytMK0ZaUGR5Sm9XUlcxbHBtZGpTeGRWajNEOVBmck5VajdZdWJjcmZN?=
 =?utf-8?Q?G3Wc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2221055-608b-4e65-4afc-08dd67dad0ba
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 18:12:46.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1lZkQDemQXOvliEur+ooXgLQvCDxMopxqvWFUzmc9BojTvh/fbQF7kcROOkUTEF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

Hi Reinette,

On 3/19/25 13:36, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/14/25 9:18 AM, Moger, Babu wrote:
>> On 3/13/2025 4:21 PM, Reinette Chatre wrote:
>>> On 3/13/25 1:13 PM, Moger, Babu wrote:
>>>> On 3/13/25 11:08, Reinette Chatre wrote:
>>>>> On 3/12/25 11:14 AM, Moger, Babu wrote:
>>>>>> On 3/12/25 12:14, Reinette Chatre wrote:
>>>>>>> On 3/12/25 9:03 AM, Moger, Babu wrote:
>>>>>>>> On 3/12/25 10:07, Reinette Chatre wrote:
>>>
>>>
>>>> Here are the steps. Just copying steps from Peters proposal.
>>>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
>>>
>>> Thank you very much for detailing the steps. It is starting the fall into place
>>> for me.
>>>
>>>>
>>>>
>>>> 1. Mount the resctrl
>>>>     mount -t resctrl resctrl /sys/fs/resctrl
>>>
>>> I assume that on ABMC system the plan remains to have ABMC enabled by default, which
>>> will continue to depend on BMEC.
>>
>> Yes. ABMC will be enabled by default. ABMC will use the configurations from info/L3_MON/counter_configs. ABMC will not depend on BMEC.
> 
> I see. The previous dependency was thus just something enforced by OS to support the
> chosen implementation? 

Yes. That is correct. We went that route mainly not to change the
rmid_read operation.

With ABMC, we need to set Extended EVTID and ABMC bit in QM_EVTSEL
register while reading the cntr_id events. Will add those patches in next
version to make it clear.

> Looks like the two features share some registers.
> 
>>
>>> How would the existing BMEC implementation be impacted in this case?
>>
>> BMEC will only work with pre-ABMC(or default) mode.
> 
> ok. Does this mean that if a user boots kernel with "rdt=!bmec" then ABMC will keep working?

Yes. That is correct.

> 
> 
>>> Without any changes to BMEC support the mbm_total_bytes_config and mbm_local_bytes_config
>>> files will remain and user space may continue to use them to change the event
>>> configurations with confusing expecations/results on an ABMC system.
>>>
>>> One possibility may be that a user may see below on ABMC system even if BMEC is supported:
>>> # cat /sys/fs/resctrl/info/L3_MON/mon_features
>>> llc_occupancy
>>> mbm_total_bytes
>>> mbm_local_bytes
>>>
>>> With the above a user cannot be expected to want to interact with mbm_total_bytes_config
>>> and mbm_local_bytes_config, which may be the simplest to do.
>>
>> yes.
>>
>>>
>>> To follow that, we should also consider how "mon_features" will change with this
>>> implementation.
>>
>> May be
>>
>> # cat /sys/fs/resctrl/info/L3_MON/mon_features
>>  llc_occupancy
>>  mbm_total_bytes
>>  mbm_local_bytes
>>  counter_configs/mbm_total_bytes/event_filter
>>  counter_configs/mbm_local_bytes/event_filter
>>
> 
> I read the docs again to understand what kind of flexibility we have here. As I interpret it
> the "mon_features" is associated with "events" and there is a clear documented association
> between the "events" listed in this file and which files a user can expect to exist in the
> "mon_data" directory. Considering this I think it may be helpful to provide the
> counter configurations in this file. This matches well with mbm_total_bytes/mbm_local_bytes
> being treated as "counter configurations".
> 
> Whether counter configuration is supported could be determined by existence of
> the "counter_configs" directory?
> 
> For example,
> # cat /sys/fs/resctrl/info/L3_MON/mon_features
>  llc_occupancy
>  mbm_total_bytes
>  mbm_local_bytes
> 
> # mkdir /sys/fs/resctrl/info/L3_MON/counter_configs/only_read_fills
> 
> # cat /sys/fs/resctrl/info/L3_MON/mon_features
>  llc_occupancy
>  mbm_total_bytes
>  mbm_local_bytes
>  only_read_fills
> 
> This could possibly be a way to support user interface when configuring the
> counter. For example, a user may easily create a new counter configuration
> by creating a directory, but there may be some requirements wrt its configuration
> that need to be met before that configuration/event may appear in the
> "mon_features" file.

Yes. I am fine with this approach.

> 
>>>> 2. When ABMC is supported two default configurations will be created.
>>>>
>>>>    a. info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>>>>    b. info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>
>>>>    These files will be populated with default total and local events
>>>>    # cat info/L3_MON/counter_configs/mbm_total_bytes/event_filter
>>>>      VictimBW
>>>>      RmtSlowFill
>>>>      RmtNTWr
>>>>      RmtFill
>>>>      LclFill
>>>>      LclNTWr
>>>>      LclSlowFill
>>>
>>> Looks good. Here we could perhaps start nitpicking about naming and line separation.
>>> I think it may be easier if the fields are separated by comma, but more on that
>>> below ...
>>>
>>>>
>>>>    # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>     LclFill,
>>>>     LclNTWr
>>>>     LclSlowFill
>>>>
>>>> 3. Users will have options to update the event configuration.
>>>>     echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>
>>> We need to be clear on how user space interacts with this file. For example,
>>> can user space "append" configurations? Specifically, if the file has
>>> contents like your earlier example:
>>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>   LclFill
>>>   LclNTWr
>>>   LclSlowFill
>>>
>>> Should above be created with (note "append" needed for second and third):
>>> echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>> echo LclNTWr >> info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>> echo LclSlowFill >> info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>
>>> Is it possible to set multiple configurations in one write like below?
>>> echo "LclFill,LclNTWr,LclSlowFill" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>> Yes. We should support that.
> 
> Reading Peter's response (https://lore.kernel.org/lkml/CALPaoCj7aSVxHisQTdKQ5KN0-aNzN8rRkRPVc7pjGMLSxfPvrA@mail.gmail.com/)
> it sounds as though this part is now in the fine-tuning phase.
> If there are other formats that is more convenient for user space then we should surely
> consider that.

I aggee. We can revise it further as we review.

> 
>>
>>>
>>> (note above where it may be easier for user space to use comma (or some other field separator)
>>> when providing multiple configurations at a time, with this, to match, having output in
>>> commas may be easier since it makes user interface copy&paste easier)
>>>
>>> If file has content like:
>>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>   LclNTWr
>>>   LclSlowFill
>>>
>>> What is impact of the following:
>>> echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>
>>> Is it (append):
>>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>   LclFill
>>>   LclNTWr
>>>   LclSlowFill
>>>
>>> or (overwrite):
>>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>   LclFill
>>>
>>> I do think the interface will be more intuitive it if follows regular file
>>> operations wrt "append" and such. I have not looked into how kernfs supports
>>> "append".
>>
>> Just searching quickly, I have not seen any append operations on kernfs.
>>
>>
>>> As alternative, we can try to work the previous mbm_assign_control syntax in here (use + and -).
>>>
>>> For example:
>>>
>>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>> LclNTWr
>>> # echo "+LclFill,-LclNTWr,+LclSlowFill" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>> LclFill,LclSlowFill
>>>
>>> With something like above resctrl just deals with file writes as before.
>>
>> Or without complicating much we can just support basic operations.
>>
>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>   LclFill, LclNTWr, LclSlowFill
>>
>> # echo "LclFill, LclNTWr, LclSlowFill, VictimBW" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>   LclFill, LclNTWr, LclSlowFill, VictimBW
>>
>> # echo "LclFill, LclNTWr" > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>   LclFill, LclNTWr
>>
> 
> Looks good to me. As I see it this could be expanded to support "append" if needed.

thanks.

> 
>>>
>>>
>>>>
>>>> 4. As usual the events can be read from the mon_data directories.
>>>>     #mkdir /sys/fs/resctrl/test
>>>>     #cd   /sys/fs/resctr/test
>>>>     #cat  test/mon_data/mon_data/mon_L3_00/mbm_tota_bytes
>>>>     101010
>>>>     #cat   test/mon_data/mon_data/mon_L3_00/mbm_local_bytes
>>>>     32323
>>>>
>>>> 5. There will be 3 files created in each group's mon_data directory when
>>>> ABMC is supported.
>>>>
>>>>     a. test/mon_data/mon_L3_00/assign_exclusive
>>>>     b. test/mon_data/mon_L3_00/assign_shared
>>>>     c. test/mon_data/mon_L3_00/unassign
>>>>
>>>>
>>>> 6. Events can be assigned/unassigned by these commands
>>>>
>>>>   # echo mbm_total_bytes > test/mon_data/mon_L3_00/assign_exclusive
>>>>   # echo mbm_local_bytes > test/mon_data/mon_L3_01/assign_exclusive
>>>>   # echo mbm_local_bytes > test/mon_data/mon_L3_01/unassign
>>>>
>>>>
>>>> Note:
>>>> I feel 3 files are excessive here. We can probably achieve everything in
>>>> just one file.
>>>
>>> Could you please elaborate what your concern is? You mention that it is
>>> excessive but it is not clear to me what issues may arise by
>>> having three files instead of one.
>>
>> All these 3 properties are mutually exclusive. Only one can true at a time. Example:
>> #cat assign_exclusive
>> 0
>> #cat assign_shared
>> 0
>> #cat uassigned
>> 1
>>
>> Three operations to find out the assign state.
> 
> ah - good point.
> 
>>
>> Instead of that
>> #cat mon_l3_assignments
>> unassigned
>>
>>
>>>
>>> I do think, and Peter also mentioned [1] this, that it may be useful,
>>> to "put a group/resource-scoped assign_* file higher in the hierarchy
>>> to make it easier for users who want to configure all domains the
>>> same for a group."
>>>
>>> Placing *additional* files higher in hierarchy (used to manage counters in all
>>> domains) may be more useful that trying to provide the shared/exclusive/unassign
>>> in one file per domain.
>>
>> Yea. To make it better we can add "mon_l3_assignments" in groups main directory. We can do all the operation in just one file.
>>
>> https://lore.kernel.org/lkml/efb5293f-b0ef-4c94-bf10-9ca7ebb3b53f@amd.com/
> 
> I am hesitant to respond to that message considering the corporate preamble that
> sneaked in so I'll just add some thoughts here:

Yea. I noticed it later. Will take care next time.

> 
> Having the file higher in hierarchy does seem more useful. It may be useful to reduce
> amount of parsing to get to needed information. Compare with below two examples that can
> be used to convey the same information:
> 
> # cat /sys/fs/resctrl/test/mon_L3_assignments
> mbm_total_bytes: 0=unassigned; 1=unassigned
> mbm_local_bytes: 0=unassigned; 1=unassigned
> 
> #cat /sys/fs/resctrl/test/mon_L3_assignments
> 0=_; 1=_
> 
> We need to take care that it is always clear what "0" or "1" means ...
> Tony has been mentioning a lot of interesting things about scope
> changes. I assume the "L3" in mon_L3_assignments will dictate the scope?

I didnt think about the scope here. I was thinking of changing it to
"mbm_assignments".

> 
> With a syntax like above the needed information can be presented in one line.
> For example,
> 
> #cat /sys/fs/resctrl/test/mon_L3_assignments
> 0=mbm_total_bytes; 1=mbm_local_bytes
> 
> The caveat is that is only for assigned counters, not shared, so this needs
> to change.
> 
> To support shared assignment ...  I wonder if it will be useful to users to
> get the information on which other monitor groups the counter is shared _with_?
> 
> Some examples:
> 
> a) Just indicate whether a counter is shared or dedicated. (Introduce flags).
> #cat /sys/fs/resctrl/test/mon_L3_assignments
> 0=mbm_total_bytes:s; 1=mbm_local_bytes:d
> 
> b) Indicate which groups a counter is shared with:
> #cat /sys/fs/resctrl/testA/mon_L3_assignments
> 0=mbm_total_bytes:s(testB); 1=mbm_local_bytes:d(not needed but perhaps empty for consistent interface?)
> #cat /sys/fs/resctrl/testB/mon_L3_assignments
> 0=mbm_total_bytes:s(testA); 1=mbm_local_bytes:d(?)

This format does not tell what is going on with all other domains. We need
to display all the domains. I think that is important because users need
to know what to expect reading the events on specific domains.

I think we need to convey all the following information to the user.

1. Event Configuation: What is event configuration applied here?

2. Domains: To which all the domains the configaration is applied?
   This is useful in multi-domain configuration.
   We also need to know if which domains are assigned or unassigned.

3. Type of assignment: Exclusive(e or d) or Shared(s) or Unassigned(_)

4. Finally: Where to read the events?
 This is important when we add "mkdir" support in the future,
mon_data/mon_l3_*/config_name will be created.


With that in mind this might be helpful.

# cat /sys/fs/resctrl/test/mon_L3_assignments
mbm_total_bytes: 0=e; 1=_
mbm_local_bytes: 0=_; 1=s

This format tells the user all the information.
mbm_total_bytes and mbm_local_bytes configurations are applied and
configuration are coming from counter_configs.

User can read the events in
mon_data/mon_L3_*/mbm_total_bytes
mon_data/mon_L3_*/mbm_local_bytes

mbm_total_bytes is assigned on domain 0 and not on domain 1.
Reading the mbm_total_bytes on domain 1 will report "unassigned".

mbm_local_bytes is not assigned on domain 0 and assigned on domain 1.
Reading the mbm_local_bytes on domain 0 will report "unassigned".

I dont have much information on shared assignment at this point. Dont know
if we can display shared group.

> 
> ... (b) may just be overkill and we should instead follow Tony's
> guideline (see https://lore.kernel.org/lkml/Z9CiwLrhuTODruCj@agluck-desk3/ )
> that users should be able to keep track themselves.
> 
> Reinette
> 

-- 
Thanks
Babu Moger

