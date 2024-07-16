Return-Path: <linux-kernel+bounces-254437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD5A933330
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1946C1F21094
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E3C57CBE;
	Tue, 16 Jul 2024 20:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QyxY14jq"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99661208BA;
	Tue, 16 Jul 2024 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163525; cv=fail; b=PsIxPNo54rxPccrVyN1NTaDIXNe3hZ9liILUTdlw8Pmd6A4dTwINjAko2bi5FRjCcAif7MPieuPiyPwK2+2dECRheGCzatqWDBZekVPkEHoAhguUVLUt2PN639yoS66yvNUsDTI+fjrHIXEcR+knFIZJJ4cFYzQnv5w6MGlxzFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163525; c=relaxed/simple;
	bh=lCADtUJT14vZScYylZ0pW2zQ3CMRR8ZZeR+tqe3vsVQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=od9HfxqcOEsJQBoHstYzwqh/30/OVEc+pKa15ClgghQUa8TM/HuAxMqXeazvcCssw/d0/gTqWg4mCuWchFs0ec9/Tv9ea45Y1/1qRQtwttFROm2Fa+5O0L2yax1sbnXDXEOY1SwF1tgPca4/jhuDWDbC+VvQzuwuUZh1CkP1nKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QyxY14jq; arc=fail smtp.client-ip=40.107.102.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdeSQxf9kFFAauFbx/ARBpcHo/F7k/ZwYWGNsOi9NaFFfqJ4yNoiTROeDl2S1R2IfRaC/T/rJQdBuJF3P0YCdJ4ME1qRygCXftYdcqSF6i1mghQNJx9zNzpa6JN3DVP9uSbs9eZo5eE6UaCjT9rhg5jJBoIif+N2Nx2APhUzMZh7F93FNTDSc4H0Ptey/FpeZt9UBQy9fJLLPyN+YcITbECMYIFOCU219gdKtn40uObzjR95eKvpShPKUmJKJ9meGB1VnLFH0Zywxi/P0f9kABDiCR/LrtLO3CXP6MYnPPoiUzbm5Hfa+44iZlEHdhhyKyOz+yz+N2u/F5wMPVVvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=804HrPNBjw4LFDnNNSdG7s96xb9twVgIcvPSOM5wvtk=;
 b=rVSk6rb55ks8/DnyxwL1XkT/9+YK8IADFCWeIy3zK084D6RZ0VjH0uRsDzDRCs1Jbwj2qF9YG3vcWdBvJVZY+F/8glb0w+61VQTnUQJT3MsWman9m355RbVcnOnpdBdqeTk+lyqM4nP/czAVC7l1ivjvI+UWCKD0st9tQFycBWn197u9jZJOLxlfvVhF9ai2ocswYevAwUKic7ZQBR85ABKBpvaGPKzswdrsTjS7NiCWYQFoY2bHIE8PG1U/5hFv6NdWNack8D/jvTsolhp3fkYcSB8RpzThoaO5exkGeDdWx82B8wsJAPiBkgDSjPOGDZS2Rb3ShNjygV6jfR2O6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=804HrPNBjw4LFDnNNSdG7s96xb9twVgIcvPSOM5wvtk=;
 b=QyxY14jqK1Vrj2anYLY98SC/EIvyA2nvnJnMfr0aZBgrcM6FvizkVVZHvjvVAhtAl2RqJhJWagKx6yRMfc6ZY/pBaS21P1VC4sWXkGm9ZjrH6pjEIOI4V2OEfehrCQyEsr7732WvqO1BBJ28IwbV0jZ2LUuN7KQSWYye05c5EdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Tue, 16 Jul 2024 20:58:37 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 20:58:34 +0000
Message-ID: <ad4cfa10-21e2-414b-81e6-3c5c86650529@amd.com>
Date: Tue, 16 Jul 2024 15:58:30 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 15/20] x86/resctrl: Assign/unassign counters by default
 when ABMC is enabled
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <89b7b4c59f3389034337301c1741ce224e19061e.1720043311.git.babu.moger@amd.com>
 <5877c7ea-45ad-431f-8595-3d8a49d3fe05@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <5877c7ea-45ad-431f-8595-3d8a49d3fe05@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::9) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e694aa-a41e-4d70-ddaa-08dca5da0ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wmg1bmRJdlRhTGhtTW1pSkRhUDNpMVV3SVZvZDJ5NUp2U0pldHkyTm52UTlP?=
 =?utf-8?B?RHM3SXNnbzhTTFY0a0V4dW00MkV2Yzl2RlNyV2U5eHZQa0xZem9kOHArcmZj?=
 =?utf-8?B?akVVUHlPV2NwNTNpK28xRGpuOXV5M3FybGRDcitvNE9iMklvWDRLRkx1ZWg3?=
 =?utf-8?B?N3EvcHAycTRTWitkUFFycHNWZnZrK1RjNGxBcTBQd1Y1NWhhd1prTys1K005?=
 =?utf-8?B?OEZwcXB6SGN0UE5oYmpZRHB5c1ZpbWlYeXl5QlNPLzExdGZJbFVQSUhmdVcr?=
 =?utf-8?B?Y3gwcGlqcVlzcWdXYWk4NFM0eG15RlVqNVg2a2V5SlY5ZEQycWNyRVhjaS9N?=
 =?utf-8?B?R1huQlo5MWFzekh4SXlNU0ttMmptRUl5RlFIclVFVnhLSWN1RXVrUDhlcVBF?=
 =?utf-8?B?RFZpSjdTOGdYMmpqKzVwdlFkMkl0WTA2QUFMdVpVV25EWjFYeXc3bnZ2Vklt?=
 =?utf-8?B?WjFaMTlEOVBQQWpSVGp0TEF3SFNrd25odHl1dkt2L2NOeS8vYkhWc2t2bXNV?=
 =?utf-8?B?TWdWMVpTclJpVWNYS3VhK0hxb1I3M0pRemNScHdUb3hVd01JTGh0Tld5S1Jz?=
 =?utf-8?B?NU1UbWVrS2pXRjVlN1J4REZacWsxZlh5cmVNREQ5RXBUWElydFpUNzdrSlBr?=
 =?utf-8?B?Smd6YjhteUphc2NIakFrSGJRU0dKb1hGTjU3ejE4c2p4NmVTNGFTUDBweGlt?=
 =?utf-8?B?QU1CWTFuZ0U5STNRd3RaRFJITGNVT1BFeUpZSVZvT3h2NnVOU1FRYkpJa0RQ?=
 =?utf-8?B?S2FIU0dxd2FsenoxUTN0bkhxeUpJOVk0UVFRd2toUlc4b0Nta2JuTXZEeFY4?=
 =?utf-8?B?MWt4NUhkMUlIQ2JpNEhtTHZoRWZiRjY2Ky9idVBkc0FSdlRqSlRvV0UyQ3Z0?=
 =?utf-8?B?amowdGlQWXFVWHNua3N5cXlsYisya29rNjNqQ0ZVdmcwVlNSTkVCRkZYOHFS?=
 =?utf-8?B?ck5tNFV2MlpXanVzWXJWd251OU5VYUFLS3ZrcDB6QlFsSnlFOTZBaUxSbkF2?=
 =?utf-8?B?TWxuLythejFUTGFYUUFwaXl4YlQ1OGNESi9jd1YxOTg1VkdjTHNIMTlkRHVp?=
 =?utf-8?B?SDhpM2V5dHVza0dOcXVaLyt2Nm14cjg0L092RmV5SERHSzlFa29pQ2J5SGlj?=
 =?utf-8?B?WlFiOWZIOFgzUDVkMjl6RjJXN3pKbkNocmxXV3JLV0xkRGNKeVlZSFptOVdn?=
 =?utf-8?B?ckYwT2V6WDJHYU5Kb1JGN1hjSUYyVjNldm0yY3J4TmgxbmF2WGtvY0Y2Z0VB?=
 =?utf-8?B?S2w2UHA3QUQ2SzJqOVZBNVZHMWZsWWlNRFFMT1ZDNHJhVHZlNWZmMmQ1Mk5j?=
 =?utf-8?B?RDBMR2ZPMnRZcEVJdXFpZFZsVlNrdXlPYWRhbmlEM2wyV3NLWkFBS0dnQjZj?=
 =?utf-8?B?SVlXMEREaXFYWUJ5S04vS3dnT2JoY3JiQlFHbVhQM3hNRXRqZGJGQ3laYklM?=
 =?utf-8?B?bUlyTnRFcDhwbWIwVlA3NlhZcmlKTDdVOGgwS3Y4bDdoQ0xCSk94TjlCZ2o3?=
 =?utf-8?B?QnBzaGpsUzBJUnhOeGVFRXdGbkxGK1oxVkhveFEwUEVzOE54Vk52NHVwSWln?=
 =?utf-8?B?YWRaOGNJTU9sY0RQdExqU1FTemZDTE0rekNhcDk5TnJlMFQybzlRdUVUTUZI?=
 =?utf-8?B?RisyZGUzWEU1YTlzWWh3RVN3UlBlMGJ5d2Z6aW1HZEgxMUl1b25GMXJmc041?=
 =?utf-8?B?NG1EZ1JqV3BjUXRFNEdDeit6dzQ4Skpsc2ZMT1p6Mi82c2ZLVjdvQUtVTUtT?=
 =?utf-8?B?Undxd0cvWnViU1JZcDRWbWZVNTgvRmp6bDhRUXJ3bE1oYUZKdnFSRDhxWWFL?=
 =?utf-8?B?SE4rMU9hc0ZEZGx4SlYxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dENPZmtydElCT3BsRnhVQWpjSklCNWZmM21XVVdOZDN4ajFFMmNRZ092c1kx?=
 =?utf-8?B?TTh5elBWMTRJbWc0OWcyZ01YRFF2ZHllUHM5dFZYWUpoU0FVNWVaZklZSk5Q?=
 =?utf-8?B?aXMzMW9zZHZNZExJZXlTZTY5b3VJZVlXUzZOSEU4bTVSQzFmN1hHa2p0OU1k?=
 =?utf-8?B?UEdhVE8wZXkrejJVRzJPS2VheEZIVGNYZWpWSkxNT3QwMmRuK1VVc0FYUU5v?=
 =?utf-8?B?SlV3bzVzQ3BnKzVBK2ZyaGxBTFluN1pGdytIRUJ2ck55aEJpSTllbzdERUFo?=
 =?utf-8?B?SlRjYmIzUFl2Z3dWdUJNQ1lJam9oVmVqejF6a1ZSWXdWWThkbmN5MjQzdndM?=
 =?utf-8?B?TEpvRlYyUERFUWVkTUlZZTczWHJNZ2lQNktJRW50Tk93RTZSaTN0alpGdkpL?=
 =?utf-8?B?MU9IRU9kc3hIamdZcENxL0dQVTJua2ovbXE2eDVLTVBQdFRRKzIvMXBxSXpa?=
 =?utf-8?B?S3NvUFVyQXRXaWg5L2NWN3Y4ZjJQOUxjTjZ3NWdRa2R2MGlPQ3E4eDBicXNX?=
 =?utf-8?B?cVlYbllpaEpkd2wwb0p2VVhPcWUwQmdxbXRlYXQ0Sk1NMXRxRXVYS243QytW?=
 =?utf-8?B?VkdOT0dqOGt5YnlCSG9URk5SYXpXNm4rNnQzemRTb0YvbjdOZWJrYzdUR1FC?=
 =?utf-8?B?a2N5dFE5QmYrL05FODhoK2NQUkdmZmExVnB6dXlJVkZ1dk5VWTh4UHJmMC9D?=
 =?utf-8?B?MzRPa2RjZllCR1E4ZDBDeXAwdWROaUZpcWxDRkt2RCtJTGZXV2VBNUJWVFcz?=
 =?utf-8?B?K2t4L2N2Y0pYVFhvanZWWDhMam5yMUdrOEZTWHN4SFdZUUxja0g2T1pBUmlD?=
 =?utf-8?B?M3cxaDA0NzQraXAvUUpOTm1rYzBOOTIvdmpIbUJPazRTRDY2RVhlaUo4aTVa?=
 =?utf-8?B?RXB4N1lEMi9pZVQyTmttbE1rMjN1MW9CL0Jrd3Qrc2FMZEtXOG1pTmxjSVVj?=
 =?utf-8?B?Z0IvejdDeEpZUkk0Q3lmdGVERWtRNVBnS2txMkNPRU1ncWc5VkJkZlcvT3NK?=
 =?utf-8?B?djZQY1FQb0xqNDVxdC9NL21BVTdkZTFIdzJzMHBFdHNYSmUxbS9XMm9TVTU3?=
 =?utf-8?B?aldqcks1eGFvWXBQWGpzS3hyUHFyZjl5aVJIZitGZmMvUzRxb0x4amxhM1hw?=
 =?utf-8?B?ZCszZzNyeTFCWjJITEE0YjhzVHZXS0tvT3pEYXFMamNDcEVoc1hqQlV4dzEy?=
 =?utf-8?B?KzVjZHpkOEM3SlZKRHpJNEFzeDNzbFhwa3ZxMHBrVXlueHVzMkszL2R1eHBs?=
 =?utf-8?B?YVBIQyt5TDhYT1FzRkdEeUluU1dONFpLT3ZXaEVoVERKWDBWVkk5Y1NzZ1F5?=
 =?utf-8?B?emF5d3NqRk5GWDF5cVUrekVkTlBLU1dhK0hhQ3crdWJmWkYxVUtGTWVSZHVG?=
 =?utf-8?B?dkY0Z0s4ak9CdVNTRWNFenE2NzJzdjdaSUxWeFZvRkJHeHlUdXM2Wk5vWGNZ?=
 =?utf-8?B?S1VEdjd0Q2pTbGEya05yb3N1MDF0YTdSd2JHSmdZUzJNT3MwMGdXMng0Tnox?=
 =?utf-8?B?eEVINkExeEQxTlNDVERhYlVHM2grUmVWbDFQQTZmRjdRY0IxNDNuZS9wTU5E?=
 =?utf-8?B?enlzcHhyclZXWmVXd2VXb2tjdjYyZXcwUU53OHVmOGRGdzZUcWJpbHNPMzVu?=
 =?utf-8?B?VGpXWUoxWGo3ZmxlTExFREdmZTk2d0Jka25xZWVxSDgyS1hTWTExc3ljU1dh?=
 =?utf-8?B?N25wLzBxMmdFak5ER3QyQndaT3drTzlhaXhOcEtnUDBnd055cWF0R0ZwQVpX?=
 =?utf-8?B?elRQc2UxS3RZdCtSYyt4SU10MnRoZ3h5RDZsS1VCN09QWWdaWk15N2lGNDZi?=
 =?utf-8?B?S1NQb0VHQ0pJOVFYMzAvTlVuMjZ3bEdDWks4WG4wcFJpLzJlRGpDS2I1ZnU1?=
 =?utf-8?B?VzZGZnpmdWVWNElpdVJKckJFZ1c2NElRd2ZlOFR1SnEwR25OT21hVi9YRnRC?=
 =?utf-8?B?U3I4SEhEUEFvTGUvdUV2V1A0M245Zzc5YnF6YXJpbmtCdjNEbTh3cmJzRnpu?=
 =?utf-8?B?Y0tUNHI0ZC9WcGdOYk0wWllxQndBR3JjdDI5UTRrK2pzc1c5NExpeFRwODlP?=
 =?utf-8?B?aWtOTUJQdWx6OVZwWkRKUlVIbmFmd3B6WGtITFp1ekYxcGJadTFjM3hDOGVY?=
 =?utf-8?Q?7nIE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e694aa-a41e-4d70-ddaa-08dca5da0ead
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 20:58:34.9058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9qmUR/2Z5w1DdOwYr8jrLMmIuTHU2Pq0J9NBxkv/6CW0DuBpjYN7Cmc3kQZj40g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324

Hi Reinette,


On 7/12/24 17:10, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> Assign/unassign counters on resctrl group creation/deletion. If the
>> counters are exhausted, report the warnings and continue. It is not
>> required to fail group creation for assignment failures. Users have
>> the option to modify the assignments later.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v5: Removed the code to enable/disable ABMC during the mount.
>>      That will be another patch.
>>      Added arch callers to get the arch specific data.
>>      Renamed fuctions to match the other abmc function.
>>      Added code comments for assignment failures.
>>
>> v4: Few name changes based on the upstream discussion.
>>      Commit message update.
>>
>> v3: This is a new patch. Patch addresses the upstream comment to enable
>>      ABMC feature by default if the feature is available.
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 78 ++++++++++++++++++++++++++
>>   1 file changed, 78 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index ffde30b36c1a..475a0c7b2a25 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2910,6 +2910,46 @@ static void schemata_list_destroy(void)
>>       }
>>   }
>>   +/*
>> + * Called when new group is created. Assign the counters if ABMC is
>> + * already enabled. Two counters are required per group, one for total
>> + * event and one for local event. With limited number of counters,
>> + * the assignments can fail in some cases. But, it is not required to
>> + * fail the group creation. Users have the option to modify the
>> + * assignments after the group creation.
>> + */
>> +static int rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>> +{
>> +    int ret = 0;
>> +
>> +    if (!resctrl_arch_get_abmc_enabled())
>> +        return 0;
>> +
>> +    if (is_mbm_total_enabled())
>> +        ret = rdtgroup_assign_cntr(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +    if (!ret && is_mbm_local_enabled())
>> +        ret = rdtgroup_assign_cntr(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +
>> +    return ret;
>> +}
>> +
>> +static int rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
>> +{
>> +    int ret = 0;
>> +
>> +    if (!resctrl_arch_get_abmc_enabled())
>> +        return 0;
>> +
>> +    if (is_mbm_total_enabled())
>> +        ret = rdtgroup_unassign_cntr(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +
>> +    if (!ret && is_mbm_local_enabled())
>> +        ret = rdtgroup_unassign_cntr(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +
>> +    return ret;
>> +}
>> +
>>   static int rdt_get_tree(struct fs_context *fc)
>>   {
>>       struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> @@ -2972,6 +3012,16 @@ static int rdt_get_tree(struct fs_context *fc)
>>           if (ret < 0)
>>               goto out_mongrp;
>>           rdtgroup_default.mon.mon_data_kn = kn_mondata;
>> +
>> +        /*
>> +         * Assign the counters if ABMC is already enabled.
>> +         * With limited number of counters, the assignments can
>> +         * fail in some cases. But, it is not required to fail
>> +         * the group creation. Users have the option to modify
>> +         * the assignments after the group creation.
>> +         */
> 
> The function has detailed comments - it seems unnecessary to me that the
> same comments are duplicated at each call site.

Sure. Will remove duplicates.

> 
>> +        if (rdtgroup_assign_cntrs(&rdtgroup_default) < 0)
>> +            rdt_last_cmd_puts("Monitor assignment failed\n");
> 
> rdtgroup_assign_cntrs() already prints message, why print another? Error
> handling can then be dropped.

Sure.

> 
>>       }
>>         ret = rdt_pseudo_lock_init();
>> @@ -3246,6 +3296,8 @@ static void rdt_kill_sb(struct super_block *sb)
>>       cpus_read_lock();
>>       mutex_lock(&rdtgroup_mutex);
>>   +    rdtgroup_unassign_cntrs(&rdtgroup_default);
>> +
> 
> This seems appropriate to be in the "Put everything back to default values"
> section.

Sure. Will move it down.

> 
>>       rdt_disable_ctx();
>>         /*Put everything back to default values. */
>> @@ -3850,6 +3902,16 @@ static int rdtgroup_mkdir_mon(struct kernfs_node
>> *parent_kn,
>>           goto out_unlock;
>>       }
>>   +    /*
>> +     * Assign the counters if ABMC is already enabled.
>> +     * With the limited number of counters, there can be cases
>> +     * only on assignment succeed. It is not required to fail
>> +     * here in that case. Users have the option to modify the
>> +     * assignments later.
>> +     */
>> +    if (rdtgroup_assign_cntrs(rdtgrp) < 0)
>> +        rdt_last_cmd_puts("Monitor assignment failed\n");
>> +
>>       kernfs_activate(rdtgrp->kn);
>>         /*
>> @@ -3894,6 +3956,17 @@ static int rdtgroup_mkdir_ctrl_mon(struct
>> kernfs_node *parent_kn,
>>       if (ret)
>>           goto out_closid_free;
>>   +    /*
>> +     * Assign the counters if ABMC is already enabled.
>> +     * With the limited number of counters, there can be cases
>> +     * only on assignment succeed. It is not required to fail
>> +     * here in that case. Users have the option to assign the
>> +     * counter later.
>> +     */
>> +
>> +    if (rdtgroup_assign_cntrs(rdtgrp) < 0)
>> +        rdt_last_cmd_puts("Monitor assignment failed\n");
>> +
>>       kernfs_activate(rdtgrp->kn);
>>         ret = rdtgroup_init_alloc(rdtgrp);
>> @@ -3989,6 +4062,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup
>> *rdtgrp, cpumask_var_t tmpmask)
>>       update_closid_rmid(tmpmask, NULL);
>>         rdtgrp->flags = RDT_DELETED;
>> +
>> +    rdtgroup_unassign_cntrs(rdtgrp);
>> +
>>       free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>         /*
>> @@ -4035,6 +4111,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup
>> *rdtgrp, cpumask_var_t tmpmask)
>>       cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>>       update_closid_rmid(tmpmask, NULL);
>>   +    rdtgroup_unassign_cntrs(rdtgrp);
>> +
>>       free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>       closid_free(rdtgrp->closid);
>>   
> 
> Reinette
> 

-- 
Thanks
Babu Moger

