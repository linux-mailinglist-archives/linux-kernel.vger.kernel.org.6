Return-Path: <linux-kernel+bounces-294461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25331958DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73DD1F22F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD11C3F20;
	Tue, 20 Aug 2024 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nv2LkYgC"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78583194149;
	Tue, 20 Aug 2024 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178268; cv=fail; b=sYRO5CZC8sL0dbwyuvUDAoPBpXgfjhyeR8kXApZ2S5sixJC5f+pCPXt/VuOgNyvaasjmrJli4W08ztMAq/YeWEV0VgVGW8uHUS82V+TchwkyherVzfIt3xZrKPPScrdlii6tmC5QwSTwaTHCVVhtjGDqC8weJWBTlwS6Br7L/YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178268; c=relaxed/simple;
	bh=XXT+lOyYVKTDv+glvHaKQOqHKmTEQcPpDi4XQZvT/6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FJntOAYGovOQ2j0zNJPeYUH1y/Q1uSnhcM+zR1cHMjiDhIiIhoXRTnqKq6slepyLZfesqxb+AhKCDS16qLCGGKExQOD77Vqj273HC0MFehFEC6UW1vPj7Ybd+cz9lFXOrp7oSXInJQ3iibO7yn8PtHLIAYHE6F7YcJqjLnbbCVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nv2LkYgC; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRxJNfqyGaGDB8RdOExriRAYUldB3DOXAQHB2nAhRrPwx16GYVSkf7zz9fqTgCKd0T+ZPr2ibjvIV+IwD8XPQsrsieqnJaeKIplfyyXPC1gtzzbHG+NeXa3+ccW/LW9y+pq2ZW8i35r3AYMlyYkNthTfrlxxSugqegm7jde/2LRk+dnDTW9Rf96f7A5j8/cxvkDn/EGIRBVGfwDgSeXgCwRUBrhoc/9Y/dyMbC5BhafqTny/gJEFsiyCadk7fZxklqyMXaPut61FstOKMoKiZibPPJ07NVCKcLhvEnK6i1vJa49xeXI3jdxZ8XNb7EkpoOck/fJIZAECjAICJJo7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDFDMgsbp6/Ba8qG5RWFrDTTzUz6zAtzyA8FCJmOnak=;
 b=u/352xC2zM8k2DwYiW/0g8fLZ2KSFJluwL/2TTj4+nlIJeZ2mOFOjuSF4nlupa0Y1fWPRLUIvAj9HudxLtxB6V5wDP/lTLlXagpiCE1VRctcn946x0Mnt7eVhO7I6aTz1YMq44LXy5mtOROb2GmGMLRv0hUwJ8Grh6wbvZWDVhlNCqamiCEB9uAMBfv9e6NsEpFV0n023x2ZuwuZedqJ6RNGNwFtUk4jVr1+H6KacQgcA2R8FCg2DSK1J7vsF4sHlD3mqWyMIr4fdb2JI3TmEXxNJ7d3YZyuzy8WQAtmbxRlBFK9VsZ55fdILPazNe29QeWoTuXkzmQOx88LOaM1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDFDMgsbp6/Ba8qG5RWFrDTTzUz6zAtzyA8FCJmOnak=;
 b=nv2LkYgCnL5Rb5dZfaD3U87L9swtHl6VEC/7nrgUXCEN2R7emkiwbqiLpQI6vNLx6fb48weQe3mmYlVsGB0EtcFlyJ3T7005aoGr3J0AAK/HTJ/WNZrrAy3CgAAPDK804kGyrOREqA94UKbmzx+lKYto6CslBbpgj6zVBKT+qno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 18:24:21 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 18:24:21 +0000
Message-ID: <c500c170-c0af-40ae-9bb5-410edc7feaeb@amd.com>
Date: Tue, 20 Aug 2024 13:24:16 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 12/22] x86/resctrl: Introduce mbm_cntr_map to track
 counters at domain
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
 <e905666d2341a5a8c8e8bf3a337291375a80e6ce.1722981659.git.babu.moger@amd.com>
 <7e0bfa19-e18d-4c43-917a-c56ad869feb9@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <7e0bfa19-e18d-4c43-917a-c56ad869feb9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:806:121::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 65611dc1-9c3f-4322-6006-08dcc1454fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUJKRmxVOVlQSG1VYkhKck15MjA2d1JyblhWTGtDa1JXVmpFMjgxTklkdGkx?=
 =?utf-8?B?N2F5WXRSOEtmQjQxMlFmMVg2WkoxV3VWTjFZTDd2SmhBa0FDaFI0R0NuVDVs?=
 =?utf-8?B?S2NzMUlOSjJWbGluQ01naU9nN21kVS9oa1VBc0ZvR2hSL21sQWdscXhsdml2?=
 =?utf-8?B?alNzMXI5ZjhrdFRnMHFtTHRLeDRoc0xUSEx2TXFXTUhKemM2eHE4TGs1VURq?=
 =?utf-8?B?eUV6NEFDR21taXVGVnlHYTV2Y1BZWWVVK0R5ZFJWVFR5V2h0bmpERWJSQUdW?=
 =?utf-8?B?VjBLWmxLR2lrYjZ0ZXUyR01sWWpRV0hYbkh4YTRHK0FUWjUwNzVyb0NTRHBt?=
 =?utf-8?B?bWVJOHp1MytHc1BkMmE5Um1UOUorNk1xY2dSNHRQc1FDSVVDRnBLczRremps?=
 =?utf-8?B?ZzFaRGxvNzhaT2g1VXlWaXVFOENodkRnb2FzSXBheUVlMFJYcHYwdG53RGJh?=
 =?utf-8?B?MkxxVStObjBQclQvalBRdzFjb3hhTm1GNmp1bnkyUElyU1NKWlNZV1NISlp0?=
 =?utf-8?B?RjhNWDh1SWdhbXEvWUhPWkM1dFZOSzNkUWlqQktTemVxQy9Od280VFVFTExL?=
 =?utf-8?B?T2pFdm9nK3J1SjR3Nmxqck8yQWQzM01pM3FiSEd0REcwSmpwU2xjSGpoNFVQ?=
 =?utf-8?B?RUVvdHU3blIxZnVzc2pja1dFMmZYS2JUbmwxLzZsZk9TWnJVMFdYOVRBUkZp?=
 =?utf-8?B?TDVIZ2FCNXQwVGtRQWdYN2hBeVNrd0Q4OTFlZ0hnWE9zbUNIRmZ6WG5VOHRE?=
 =?utf-8?B?em1JbjEyTTZGbUNsZzB6UlhGTlp2cEVrMXo1aHhMOEZnd1NaNzI0cUlIeUNy?=
 =?utf-8?B?UmZuaStwaU9CZ3p3dzMyWVNYMElGM1pNU1VMQndYQ1ZtaTZsRzZ6SFV5R0Vl?=
 =?utf-8?B?N1U2TnJkK1hycVl0aDVYdjJsKzNaeEp1Vm03R1N2djR2T09JNW9PTndkMWZK?=
 =?utf-8?B?b05GNlRBNnFXcndOc1c2UlNjWTQ0ZnF5SDUwTEMxeVZNNHlWVGNkODRMWGdY?=
 =?utf-8?B?aS9xdUVUTGJBL0NBWW1wTWJiYzNCOU1nUGtvZm8ydDVCMitteG9HOUVGeUla?=
 =?utf-8?B?NmQ1Qkd4Zks2Qk1WWmJjZE1tUUxzZ0hqd0gwdFlBMVg1cVI5VUFRalZ6WG10?=
 =?utf-8?B?ZkdrbngxaXpsc2dTN2MyNlFYRGpOeDlhaWtyMytSRzVHT056WjNyU2NXbjd1?=
 =?utf-8?B?NkpLaWhpNDlTbDZaWmVWZld4eTRDNUpNVzVRekN2ZERHL01CRmhHdU4zSTVC?=
 =?utf-8?B?bjExWGhMc0M2OURsVVlVVmppWUR6WkdPcHozQklONlFPM1Uyb2dlM1FaU211?=
 =?utf-8?B?KzRzcjg2eGEvODV3UEptK25EUGx5N3RzU1RHSlVUM1owUU1sVDI5bnBpVUlK?=
 =?utf-8?B?eHdpcVZIZDZWWWNMeU9sWGRxWm5VdHc4N0ZFMlpFc1lyeFkxODZpMGswYTdY?=
 =?utf-8?B?RGVsVG5jL080S1Zta3dxZk41S1lldUtGKzlrVEoxTFNkSW10TWdmZDkzY1VQ?=
 =?utf-8?B?TDBNSVRESUxNb1JraGVqTDNmUjRvYTl0ZUVwWjNLMEk2S1R4STlFYkNwVVQy?=
 =?utf-8?B?K3J4ZHVzVGEzbkVUNm1PNHhmYVU2VHJGVUptdncyNDNVbGtIVjRkVVU5djl6?=
 =?utf-8?B?eEJiTmttK1pmb1VwcWZHQmlqayt1VGhNK1FmYUIwYytRbThaaER6MVpSRE9K?=
 =?utf-8?B?dWFUL3FLYjFTZzMxWWlvMGFFc3V0MkFuUUNmWFM4d1p1S2VSVGlTRjN4Yy9J?=
 =?utf-8?B?MWRhbEpQZHdMVmhKV0UzWk5GVi9GdlI3Sy9VelFuY3ZmRTFLTmJVdEtOMkls?=
 =?utf-8?B?dTZBT3Z4WEdyalVUVXh3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGpmRXhrMzIyZlEvOVV3T0tPNTZhR1IxS1haa2lwVmFEQ1puMnJIMllZbXZF?=
 =?utf-8?B?OGNwK0V6ZW1qL0x3NGtmaGNhNjBpeEZqT3NDY2ZWdHd1ODlqNll3RmdxMm9t?=
 =?utf-8?B?YnJuZzZzZllLT3VyTVF0YkdzT1FWZGZhTll5S21lbXAvZkVFdHE4d0lPZlJY?=
 =?utf-8?B?TWpXbHpUbTdhbUluV1BUQzN3R3NoNjh0Zk5Rdk1MN2NyZ0xtWW1WNXk1WDZK?=
 =?utf-8?B?cmhLTHByZHlvUlBydnpUeUI0OVplRUg3VVcwVGtONHY4VnN2VGRJT0JXOU9B?=
 =?utf-8?B?bEI1eXZtcHE1Y2UwUFJXbHZMWFJEVWMraHlRN1FKaitzNTZuZ29WTElNUEp1?=
 =?utf-8?B?d0EwWXRQbUYraTRxTVZDWENqZGx4RjFVd0ozVW9ESXZzazBMaG5xSElWd0hV?=
 =?utf-8?B?Y3JWQmxuMDV1NTlwb0VHZGJxbUt4Lzc4L2pEbmxVQkVEd09IZ0hFYllzVjF0?=
 =?utf-8?B?SXlwcDY2TlZQdWFYaUlpcmZjSll1ak5qcGMxWHBZcmU0amdvLzduM3dpZHF3?=
 =?utf-8?B?MjZ3UjZMSFJBVjBxd01JOVhxQUFIKy9MMWNzMWg2dXFKZ1ErNmZkcEw2b3lw?=
 =?utf-8?B?bUE2NXcrWHMrVWcxYjI4WTRxaEpvSDd2S29jRWxaT0ljUk9iUUlQbXkvODkx?=
 =?utf-8?B?VGtidmtpaEdIZWNGMWJ3RFlkMnpLZTZpYTFHeVh1MGQ1WURuTkhmS29qZ25t?=
 =?utf-8?B?bUxmeFVUTGkvV05LbUdlTVJGckFZTEdqYjlXYnBrY2NHRU54SXk2Q1VuVmlM?=
 =?utf-8?B?UUZhQUZTNlU5Z0I1NThJaTU5V0t6TjhEdmdIakhlU2wwZllXcEhkcmNyNkRW?=
 =?utf-8?B?cno5UWNMNmtpL3FlZzlhd3crN3RHQ004WS90TkpxeW13dFBzaXUrU05oUnBz?=
 =?utf-8?B?cDlNYmhFUERjUW9weWtUTXViZTRJOGJsRk9aRTNJWmtjeExjT0JEQ3VOeUlM?=
 =?utf-8?B?bytiZGNrbGpGS0JMQmRpRGNzMFk3cVoydGRtejBjdXJJS3QvczlVeVpzZmg4?=
 =?utf-8?B?Um1PdE5uZG9xdnZJbzF4SjEzMzZqNTI5cC8ydG1FNmkyOGROSFhpTUFtM3p1?=
 =?utf-8?B?UkJUOHFBVHRaaW0wdGFpY0FqNkovSTVuUUl4b3F1VktPQ0xVRTdVUlA0Q0Zk?=
 =?utf-8?B?KzdiODE4ckJQMytEYnFLQ3YvN2Q0RmJXVnhWY0N1dTMwZzBGMXBOeU5OWmFl?=
 =?utf-8?B?QWo4aldCN09Mek01R2RPZGdTREpsbWJDWk44b0dBYlMydmxBOGpya3RvdExP?=
 =?utf-8?B?eGhIaStRUHJZaFlvdlpaZll5TFdqajZ6Q2krNlVpaHZLNm4xV0llMFVqTHY5?=
 =?utf-8?B?ek1xSy9iVDROYUNBMVR2eDlCNW40RCtqNHhmUG5BK3Y4NE1vbVdMZ3hBYkNY?=
 =?utf-8?B?TWtXa0JXRGh6eUN0MjNCU05wTlRjcCt1QmoraVFqcDlvRXZVL21NZXduYlB5?=
 =?utf-8?B?ejVIZ0hUWVpQWGNMelJVcHozRmVVb3pSNkRUM1JnWVhtN1RWMHg2VWtzejdR?=
 =?utf-8?B?U3lMb2pIVGFXZ0pyNHloWTZ3S2RhWk9ISjAzUW5MRk9VSHdUSlEyMkUvTWRP?=
 =?utf-8?B?VWN5NDVlUnZ2UkdzZjhWWkRpSStNb3IvUmhzbDc1WlFmK256eXR1Nk81enh5?=
 =?utf-8?B?ZWg0SkVaOFdFSC85RGV1a0pCaGdnTVlCUXhVUDlheVB0VU56Mzk2TUR1b2Jn?=
 =?utf-8?B?WlBoQlU0N3lWd2VDR1ZJNDdlWXphN3FYSGRrNU1CVUhqT1FYZUtubTlzMm1P?=
 =?utf-8?B?UHYxY3JBWk5QT05JSWxBQjZyWG1ULzJXQ3NjRkJvY1hDQVR5ZDcvaVpEd2hH?=
 =?utf-8?B?eGJYeklrZHNVQ2hISWpzWmlRbTFGTjBjQXd1SzJ6SjJ1UVYwUXZYSlZQRDV4?=
 =?utf-8?B?dkNGQ0EzOXRrUWl2ckUrbmZ4dVQyNHcvWnNTUS9iL3hBR0RnTFBlZForMXJL?=
 =?utf-8?B?NkptV0Rxem9RSlVSOEFVYWJ5UkdSTHBjMHlkdVp4QTVnc0k1WUFIZ1d5OGZw?=
 =?utf-8?B?SkFRYTJPWGtmaURlMXJ1U09JSnliQytzbkdRYXBkNzFyZFRXWUJHUEI3MC9l?=
 =?utf-8?B?TGxwSXVBdFBlbDNtOFpHMXdYUWlYUktwZFBQNlM1Z0Irc2IxVEpzZ1RJMGx2?=
 =?utf-8?Q?Z74o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65611dc1-9c3f-4322-6006-08dcc1454fa1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 18:24:21.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJ8WRIG5KMHKxXDtkxNjwSJRG1srNvAtd5KR6p0VA1YDk79bGHSU2pkD8TvzQt+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

Hi Reinette,


On 8/16/24 16:37, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> The MBM counters are allocated at resctrl group level. It is tracked by
> 
> Are they not allocated globally? (but maybe that is about to change?

No. It is not changing. It is allocated globally and assigned to
RMID,event pair in a resctrl group.

> 
>> mbm_cntrs_free_map. Then it is assigned to the domain based on the user
>> input. It needs to be tracked at domain level also.
> 
> Please elaborate why it needs to be tracked at domain level.


The user can apply the counter assignment either to a specific domain
within a group or to all domains in the group. The mbm_cntr_map will be
used to track the domain-specific assignments.

> 
>>
>> Add the mbm_cntr_map bitmap in rdt_mon_domain structure to keep track of
> 
> "rdt_mon_domain structure" -> "struct rdt_mon_domain"

Sure.
> 
>> assignment at domain level. The global counter at mbm_cntrs_free_map can
>> be released when assignment at all the domain are cleared.
> 
> "all the domain" -> "all the domains"?
> 
Sure.

>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6: New patch to add domain level assignment.
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++++++++
>>   include/linux/resctrl.h                |  2 ++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 0047b4eb0ff5..1a90c671a027 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -4127,6 +4127,7 @@ static void __init rdtgroup_setup_default(void)
>>     static void domain_destroy_mon_state(struct rdt_mon_domain *d)
>>   {
>> +    bitmap_free(d->mbm_cntr_map);
>>       bitmap_free(d->rmid_busy_llc);
>>       kfree(d->mbm_total);
>>       kfree(d->mbm_local);
>> @@ -4200,6 +4201,15 @@ static int domain_setup_mon_state(struct
>> rdt_resource *r, struct rdt_mon_domain
>>               return -ENOMEM;
>>           }
>>       }
>> +    if (is_mbm_enabled()) {
> 
> This should also depend on whether the resource supports counter
> assignment, and that it
> is enabled to ensure that r->mon.num_mbm_cntrs is valid.

I can add the check if(r->mon.mbm_cntr_assignable) .

> 
>> +        d->mbm_cntr_map = bitmap_zalloc(r->mon.num_mbm_cntrs, GFP_KERNEL);
>> +        if (!d->mbm_cntr_map) {
>> +            bitmap_free(d->rmid_busy_llc);
>> +            kfree(d->mbm_total);
>> +            kfree(d->mbm_local);
>> +            return -ENOMEM;
>> +        }
>> +    }
>>         return 0;
>>   }
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index ef08f75191f2..034fa994e84f 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -105,6 +105,7 @@ struct rdt_ctrl_domain {
>>    * @cqm_limbo:        worker to periodically read CQM h/w counters
>>    * @mbm_work_cpu:    worker CPU for MBM h/w counters
>>    * @cqm_work_cpu:    worker CPU for CQM h/w counters
>> + * @mbm_cntr_map:    bitmap to track domain counter assignment
>>    */
>>   struct rdt_mon_domain {
>>       struct rdt_domain_hdr        hdr;
>> @@ -116,6 +117,7 @@ struct rdt_mon_domain {
>>       struct delayed_work        cqm_limbo;
>>       int                mbm_work_cpu;
>>       int                cqm_work_cpu;
>> +    unsigned long            *mbm_cntr_map;
>>   };
>>     /**
> 
> Reinette
> 

-- 
Thanks
Babu Moger

