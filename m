Return-Path: <linux-kernel+bounces-364530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBF499D5C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB6B1F234F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D0F1C3300;
	Mon, 14 Oct 2024 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="laWWqWSL"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F22231C8A;
	Mon, 14 Oct 2024 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728927985; cv=fail; b=HxSiExV3WdQKTAkdG1W3Jl2c3zPqDhbKcNbkfaPy2xOS7PtM6Dazq+j3Hb+b3b6cPQvyecdBoXNvy+cSV72klHNvnekrMBmbiOZCGn73eO4G8owDL5XJzaIdBK08Jvp6bvERJRiz19824cu0nCXrE5uCSAptQ1YNfw87XbcRCBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728927985; c=relaxed/simple;
	bh=aeOvmxjSKMeKwqj6q3fcDddngXywdJSjK528H3VY0hs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hn2g1Yo661icEUGI3/QBKpG/glgmMAnpM5lV9m542WMT7fv0ZZjMmGfxSr134KcBfmVT8NZ1O5aTDuA1OMJyadKYN1Y870aIY74u15mHdbsDQTXYanOEdO6f5qdGLKdWPP79sb7J3/6PZ3RTQIQnD7/ImmOA1+AjFRqSbXhVvCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=laWWqWSL; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7q1Ck0LjYKWDdqjTgohXMefSXNVRQOhhaGT9esXFQ6xVVrTxBNp+X79MeyRGKIKfb/wQhZcPtySMKOYfn8rmWzCNZkEs9qi8w3rXkTMTxpzXyMP7nmSmytrtk9vsY31AsAOEUaBjSv6NyqjwsJVDyZV76WdUlu3226Q2fNuWXJ6fCIgbna5JRKl2Lk6UGFAhethl6z5Xn/sFCgmM7b5AuWh2PwNFVNSzFJaSyMbtEvnQMKIsqIkxY+tM4StgfAKNAKqffAm8NykoGis7YLlu0bwoTyDBRgS0J5Q4Cv3vUceWNZyCo6PjGld3kQ3s8Z2pbJywzpPMNEukRwtEssuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njPRrVOF4Z3cbd2vnwfvKWLUqHRJjhXFZgItpFrS+Qk=;
 b=MH8zV8IG1SYyMbb83F2LzEKXoNsPCtG+8oVYabTEtYUtjjG9P8CkNN+7qzSjxZx6OXo5+BJ6C0lmgRy2izXbq54qwNRuSo5NzOgn4JolCw8GtGjRJ/JBl+6423oT1aRA6L6uLVNHNJBL+U6PKjj68rZnk0c+BoHmj9b3c1OALjN2OY7R/Bxs4fU7IIu2f2Kasu7MU21jW50GmklX5d52ufqIAIPVioXxlA5gAB5mNJzom1FQeZgM5s+Kau9hqj0fZqEvvM4+pmaTrnLjkxtUb15n07W9SS0az6mcxgTqGz+t6916hcBuvsQzWQiYN1uolx00A+2imkdxkgr9SUh6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njPRrVOF4Z3cbd2vnwfvKWLUqHRJjhXFZgItpFrS+Qk=;
 b=laWWqWSL6FNmGcbMiuSiyzEMX0RbjjZ3KJrx48mtmxjuHJCzU5McwNDhQtUxBNFruaJA+9xok1zQrvryrgHNS1+uqw7IC+CDlddOOQCY0TQGldG5W/PDWXXQs60o2s36ZRj5ngQGNS2csof5bdTFHBARu3RHP1JkWKdg7SZhzIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 17:46:21 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 17:46:21 +0000
Message-ID: <91f63f7b-32e8-4a67-9851-1c080fe62e23@amd.com>
Date: Mon, 14 Oct 2024 12:46:17 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <ceeaf5a7-190e-4c29-89da-ba9e83693360@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ceeaf5a7-190e-4c29-89da-ba9e83693360@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: b518e987-3651-4347-278c-08dcec781d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXM2Z0ZXM1hsazlhT2RBKzlONHk1VnZXdjJkMGhPclFka2FFVWVwOEh5Y1Zh?=
 =?utf-8?B?ZHdUZXkyYWF4Sm9kUW9DV2Z0eGZZR1dyS1BsdEVhRUYwUU10aTlhMEFMa2FH?=
 =?utf-8?B?NTBGMUhIemliaDQwOWlmWDRBRkFQSVlTc2twSkpoaGJkVHZ1ZWlEd3o0WXFq?=
 =?utf-8?B?Z0t6NjBWZjdOUUgyMTZQTHdsS1VQRlVNOGtrK0lwMklBempPYWJBbllJVUxN?=
 =?utf-8?B?Q0g5a09hczlkLzZaRWo0UWRoTGR5VDdYbkMvMXF1dmUvaVhabGoxZ1FlcWVn?=
 =?utf-8?B?cklvNXoyRlJZajNJaGpITVlYeS9GbFNJRkJHb1FLWU9aNE4vK0lETStnMklt?=
 =?utf-8?B?b0JrMVlmZFdEWGVtZ050VkdFZUhRclg5K3lQWGtRSjNlb2pkRmplYytOM21v?=
 =?utf-8?B?UlJNcWNZdElDZVNKVm9SaW02U2hTMk5qeldwbGxra2NvTGJYQ3pJOUZIM2sy?=
 =?utf-8?B?WHcxd3JydTZNSVpDdmJLNnZGMWwrZ1FEYTM5QUIrQkR5NVM5ZXlQVXVZa2NX?=
 =?utf-8?B?d0NJblJzSUZPMkNOeFcyc1lMWDNRZ1BnUTJYbDU1R2twakRuS3g3L0dxUjhw?=
 =?utf-8?B?UGZKckUxZSt2eDFMakp2eGpTeXhxR1NDVFlNRnZuR0g0c0VtM1BCWXFSWEhV?=
 =?utf-8?B?QkFHeW5DcjZVTEhqT2NYQzRDMWVBbk5TZXFRVUZaL2Fkd3VNeXBXNTJjalF0?=
 =?utf-8?B?SDUwUDBzV0lhRzRjd3MzdDhad3Z4QkluL3dUdVdDYlQyUVlHeU9yRE9id2dl?=
 =?utf-8?B?NnFnd1JkU3dzejMzRS9OYXI3NnJRbEpLMk1GK2VkdkJWTmtTejBzOXR5UFY2?=
 =?utf-8?B?dkRkSGplZzNGV203RGp1R2RXRkd0c3RlN0doK29ObmJlZUF3TmZjaE9hRXhN?=
 =?utf-8?B?ZTBmOGszSVJzTUY1YkErakthMGdKdXU1UjU5M2lUQzFVS1pSRk50eWpmdExG?=
 =?utf-8?B?Zm9jLzUxVUVYb05Qa1ZLQitLdHFFSnBqcE9KeW5OUk95dXFwaEV3OEZtS2VI?=
 =?utf-8?B?SlJrM2gzQ0Y1NTJiTWJYRWJPeXkweTBYQTFqK2ZTYzlkMXpmK2tISGRPTEpt?=
 =?utf-8?B?TW9kV0ZsQldKS010ZGJWUVBYc0loUkVxRVlvWW5kSkQ1Yks3VEhWdEYrMmZF?=
 =?utf-8?B?MStDbTA3SlR0WW42S2p2a2NtM2ZkN01Kb1BZcCtNaThsaW1iSWIzSExXU05R?=
 =?utf-8?B?ZVozK2ltMGUxZUdhK1dXVkxnd3o4VkVBdkt6Q2ZWODZQTVEzR0ZkN2pFcEFo?=
 =?utf-8?B?NmNNNm9sQ0Erc3FPTWI2ZWszYjdvak1vVi84L25QUkZFN0dGekk0SithUWFX?=
 =?utf-8?B?OEI0M053SnNjSTNTUTJTTUNtelB5ZHZLNUhtU3h6ZWJ2QmFOYnMxdUlDajBu?=
 =?utf-8?B?QmhIK3d1Q0ZoRHdETithT0VDalprV0ZoaHkvb0lnQ3ZyeGlrSStORVFtOFJr?=
 =?utf-8?B?TEljUjNXTzZPbFV5M01FeXBUVm9qa1NHSGx2andnYlVqNmhGK0pnck9wOWdJ?=
 =?utf-8?B?YXhvam5qVk5NMWhoQlQ1aTdJS2E4R0JhVnVvSCs1R21FNzFVTDNOOFlIUG5l?=
 =?utf-8?B?Y2F6RTVpb202UDJ3TTEwOHl0SWhNcjhGL3NWRlI3T1YzN1oremVWRm1IS1k4?=
 =?utf-8?B?NmJGakIrNHRvQmpHMnVGOW16Y1d0c1JYVWF5c05QaVBsWWhFSmU5SW9LVzUy?=
 =?utf-8?B?dXoxSDhRTzhON2Roa0xHSmNlUnFWd1NIMSt3TW5sYmdkOEt4WlhqVWtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qys3d3dyR3lMdUljbkMzbklQN0dYNjJxM0RTMkFHQ3dzSWFWWFdZY0RuN1VH?=
 =?utf-8?B?Y2hNZEZjenlPcGlvNWh0OXBlUnYzMEJMT1RWTXFZM1BYNnBDbTF2Q293UU5z?=
 =?utf-8?B?RDFZZFJLeGlERkVsRldSY1VZM0RGQUhiR09CRGVIdzFrbDVMWFEzN21EdU1H?=
 =?utf-8?B?aFAzYjFIVEdKSXljeGxKWFczWU1wTGdEd2o3d2hEZlR3OUo4NXMrcDk3L3Rp?=
 =?utf-8?B?UFZWcWhEa2ZKNTNZZHpMVEEvTHJTQnZrcjhuTmxTY0NXMEE1NkhMVjVkTi9M?=
 =?utf-8?B?NXNsMGVjQkw3MmxwTnFZRnlqUkNVWHJWUzZpV3ljQmdBTzA1c0p5bTUxZElh?=
 =?utf-8?B?RXEwRzVaRWNpOEZzaXdYY3BSdHkzSGhRYUN6YzNYOWJmTklMUUdPTGJZZEZU?=
 =?utf-8?B?U09yWHJhZTgvbjE2L20xb0d5SWtkWFpVTUxTM1gzUmNhOGlFMEJ1T2hkMThn?=
 =?utf-8?B?YzgyWjZ4aGg3cWlUOW5YMlllQkxEV3RUZkVYR1oxNDN6SGpMK1BiYTZHL3BI?=
 =?utf-8?B?Y1FpQVFRTERZZXRIVTkyOGZKNDYvYk42cDRzc2dHTzN6MGEwUjkwVWNFU0Mv?=
 =?utf-8?B?ZzdvZ0JIam52QmhJWlVaakMvR0t5TythbDdOL3g4bi92UUxXL2NUMUZwU2Zw?=
 =?utf-8?B?aElOZUZUbHdoYjF2aWU2SmNvOUM0SWJVTGp1MmhiL3VGYjFEVXVOZnlKdEhF?=
 =?utf-8?B?ZTNaV1VsbFFHZ2ZiMWcwNFBZOFpmYUlnRU9lYzdTekxZbkdPeUJVVVo4NXBx?=
 =?utf-8?B?ZnZKeGlOeStvSlg5TUpLWmtBZCt0WnczRUVrNW5DK0VIRy9GQitoOGpjUmMr?=
 =?utf-8?B?REpDNE9FdkRQZ1FWTW9KR1IySHcxTUovYTBBUTdWUGpJOS9RMG1aWnkxa212?=
 =?utf-8?B?cWhENzdvRzRlZ0JQaEpWZ3lYWXpmbXZ6cFZ0Tmg2YlUzVTZTc0wvcXk0Nzg0?=
 =?utf-8?B?WlVZbzlsSUNWU2dyQm4yZlhLOWk1d1RyUXRvRGkxL1RkcjhrZFY2NGJuamFw?=
 =?utf-8?B?dWU2UHV3aXR3RGdJWTN0ZnNxNzJtY0Z2L1BVdkJFVTZKRTV4YloyMm5BMDRO?=
 =?utf-8?B?bEg3TERxYU01K0lqeFVYMUtwUHV2QnI4M2JYNjdPWUJycGRUbmlRNEJ3WDJ4?=
 =?utf-8?B?UTBWREJ2YjVYNmNMOFVKNUxkTzJEKy9Ic2FRM3o4REJrdkltQWFSTWhmU2g2?=
 =?utf-8?B?T3ZTRjJDbjBsNnkvK1p4QnloQ2F0UjZjOGJ0b2tzNkRZK1U2djNsaVg5MXN4?=
 =?utf-8?B?OVNoSjZ3UmdHYnhHWFpoRkg1ZHpJR0h4RksxZzJCWU9CUHVBem9NbURHNFpj?=
 =?utf-8?B?YVRvMThkUnNsMGF5bHFsSEo2ckZ2eUwra3FvM2ZYRDJuWElsWm9zaVBvRWtC?=
 =?utf-8?B?ZUU2WkhQOVFRN1U3SWIxekV5RUlmTnVsUGV3cWkwUy91Q3pGN2RVNUdJYVBK?=
 =?utf-8?B?SFFGTlY4ZlRXejFhQTN3bndWZis4RFhkaEh6M1pYRFg2RExTcmcyVGdTaDdx?=
 =?utf-8?B?cXRoQVhEZ2piRmtCSXdsUTZtMjlFRXlTR09oSWRVSFNFM0xudXFZbkw1WmhB?=
 =?utf-8?B?KzJtOGxGWGRJNmQwc0lpTHZrUmMyc0VxTC82ZUozWlZuaUNDaVhCM0Uzckla?=
 =?utf-8?B?eC95SUYwaFozTEU0N1FtUU82VWE3RkNqZzg4UVVWdmVxK0tVaXdmY0Q5Y09F?=
 =?utf-8?B?N1BLZVpSK2xCZW5VdWtwdUE3RzFESTNNMGhJVFBQeHdsVjNPSC9CbmJ6Vlh0?=
 =?utf-8?B?NW43dGxuTGZYanhWUk5UVTF1bFd5cTZSTlI5ZnpyZjVEbjJXY0tCU09idUlh?=
 =?utf-8?B?NnRXbFB1eDZKaVN0M0x6eFFxUUViY0NEcGo0aHhTbHJhS3o3aytSVU9SVmk0?=
 =?utf-8?B?M3FoSStOcGxwYWtCRUZHS05wN1NKTmJueUxUUWJoMWhqSnFQUzAwQzRFbjV2?=
 =?utf-8?B?WmNleEJpZjBkeHZwUTY5NlNnMW1CSEI4eTc3Y3gxN0xJSHRVWjN6d2NhV2dU?=
 =?utf-8?B?Nmxkb1o1NHk5SG44M0dOb2VzQmZtY04ycjdoNlJRL041Rm16MFN0aElZZW12?=
 =?utf-8?B?NnRFb0pLZzM3b0YrSyttMlcyd2d0aktGNWhWV1l0NGlZM2RMWkJSc3hUTllW?=
 =?utf-8?Q?Kt2E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b518e987-3651-4347-278c-08dcec781d63
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 17:46:21.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzXx2oRYyB6JFHV/RBdL0D4vn8LPAyohcu7LgVJC6zGsCj7q6CzlZJB3AqVJvNMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446

Hi Reinette,

On 10/14/24 11:25, Reinette Chatre wrote:
> Hi Babu and Tony,
> 
> On 10/10/24 8:12 AM, Moger, Babu wrote:
>>
>> All good points. How about this text:
>>
>> "num_mbm_cntrs":
>> The number of monitoring counters available for assignment when the
>> architecture supports mbm_cntr_assign mode.
>>
>> Resctrl subsystem provides the interface to count maximum of two memory
> 
> subsystem -> filesystem

Sure.
> 
>> bandwidth events per group, from a combination of available total and
> 
> Is this "from a combination of ..." snippet intended to hint at BMEC?

No. We support 2 MBM events right now. That is why I added combination of
total and local. I can remove that text.


> 
>> local events. Keeping the current interface, users can enable a maximum of
> 
> What is meant by "Keeping the current interface"? Which interface? What will
> "current" mean when a user reads this documentation?

I meant not to change any interface to support mbm_cntrl_assign feature.

> 
>> 2 counters per group. User will also have the option to enable only one
> 
> "User will also have" is talking about the future. When will this be the case?

Again.. will have change the text here.

> 
>> counter to the group to maximize the number of groups monitored.
>>
>>
> 
> I think that we need to be careful when making this documentation so specific
> to the ABMC implementation. We already know that "soft-ABMC" is coming and
> Peter already shared [1] that with software assignment it will not be possible
> to assign counters to individual events. 
> 
> The goal of this work is to create a generic interface and this is the documentation
> for it. If this documentation is created to be specific to the first implementation
> it will make it difficult to use this same interface to support other
> implementations.
> 

Agree.

How about this?


"num_mbm_cntrs":
The number of monitoring counters available for assignment when the
architecture supports mbm_cntr_assign mode.

The resctrl filesystem allows user track up to two memory bandwidth events
per group, using a mix of total and local events. Users can enable up to 2
counters per group. There's also an option to enable just one counter per
group, which allows monitoring more groups.


-- 
Thanks
Babu Moger

