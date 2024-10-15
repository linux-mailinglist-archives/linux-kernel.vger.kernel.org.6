Return-Path: <linux-kernel+bounces-366649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C115499F840
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8019D288C54
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C51F81AE;
	Tue, 15 Oct 2024 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EwDHsf3O"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713F2158D9C;
	Tue, 15 Oct 2024 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729024975; cv=fail; b=btkCbaQFgVE6b5Gft0cle8iWk7mv9H0XqbjWY4ATRa+FA3DpmsAK6iIA8Pcvn1WzGQhKBGrblmq+egsYz9hC/d8oSgROz2VUhq3lMZabSGhhSfcuF4AdjRntDgZhwkCgCuUlNkp2o35+G7OZXph36zn/A06DrUJKOVHCNZp5AVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729024975; c=relaxed/simple;
	bh=E6WNnl854sb8Il2BouRiNLkIvzo/NtsVdZAPPa5ZK70=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W+/E09iKZJXg/cUeN92LXDvKBqTtN/5yqnOdedsUOlAfYjC3rigw7EcoLFj0oGlRxcCgwOvXjc/FMF3HLghYN14u0FHIDobaUJlyemsDPjqg5sbleVm/5XKHLeQYDtx7eyD4gyUVf6XDNd5oUdu3ybhAUdsXPSrMFmTr965kebk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EwDHsf3O; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Emzr2bf0YulESPtXxUj5SAnITevM56Ub/+zETaPCasxueSPPIIGdDOtvF7kw4mEeVyrU6FVgHzYqDAS/dl1uj5LOap06Yi4Yf5HBQ9AsOS4TGu1LZjEthnl3Lt4FOucaLnR8jCD4qmLePA5lrP1Y+YzRRpmOU1+KhEpXJNv0gpfendd8/JCB9W0PjE3z+A9NKQvDIa0qH+homWL/cmSgUuWxgF/aVLsatwqYmWy5zPdOZm0vdUIna3jRZk76qOH20Hui76xq3pO/cr/aMI+wB0WA8jpucgBtZLJyuhs5/NULI4NQCqcIi7nlHO0QOjqDXDrNMFBus1AC67ZExhUcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AN2+BGgrB4fzI6uCuSR2eTTgQ/eFQXb1rdCr8rc2ef8=;
 b=ZYVQ+i7yiBVUqha+YL/a5pOrvODMyv5AkgY8V47ZTs9QuoDDl9xlFqZBy7q9Dnn79iESzi+arIYyYD1lN2qH/C8+Quf9O4SGc/j141m6qGsfpPmb0x6sobsv+hxEdxV+6W260KY/y/dbRuaQHJ6h1dYjN+fiNiCI/VuU9f7ELOxL9h9yKhZ2nCxmiC5Chd9skGb0P2aqb/y7B8uWgTsmm1zu11kE0gboX69p/7YDg8sj9ljTZjdzd9jYT7JkPuodoRzZFne333Mj4O87KC+h4Y2Wh1VVwYkBYmoNu2va0YRTpYE+j2R4b8C2XEX4A+Qp7qvz9zG3UOOXIxVbrg3b4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN2+BGgrB4fzI6uCuSR2eTTgQ/eFQXb1rdCr8rc2ef8=;
 b=EwDHsf3O1QNChytfXhypdBIvOSWGfR7MYxFI+h2uFLIop2ThbUI3r+2TCD20AhWhXIv/vh2FLkm74wyl6kNZsmuP583mJgxz8eqQoutjmx8yC5dkayHsttL0u1v8YSXDFsrlAPbKwiF5XklRmeuC7+aoykySDYDakim6Vx6yCAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 20:42:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.029; Tue, 15 Oct 2024
 20:42:50 +0000
Message-ID: <42c4ac2f-2b18-48d9-89b4-5c88659bee2e@amd.com>
Date: Tue, 15 Oct 2024 15:42:46 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: Reinette Chatre <reinette.chatre@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
 "kim.phillips@amd.com" <kim.phillips@amd.com>,
 "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "jmattson@google.com" <jmattson@google.com>,
 "leitao@debian.org" <leitao@debian.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Joseph, Jithu" <jithu.joseph@intel.com>, "Huang, Kai"
 <kai.huang@intel.com>, "kan.liang@linux.intel.com"
 <kan.liang@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Eranian, Stephane" <eranian@google.com>,
 "james.morse@arm.com" <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
 <ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com>
 <541d6c15-ed5f-8794-506c-8fa4065ca170@amd.com>
 <SJ1PR11MB60838F3FFF40AE2718ED7833FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <43654ae1-c894-409b-bcb8-065940644906@amd.com>
 <SJ1PR11MB6083379F790967B379C4232DFC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <a972dfe9-341b-416c-a245-0834583c6620@amd.com>
 <567bd687-a69f-46fb-ab19-3f8d95c5e798@intel.com>
 <b4d9b572-4df3-4758-a40b-cb48fde0b595@amd.com>
 <8fa57edb-996c-4867-8a7e-05a8fcb9fe3a@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8fa57edb-996c-4867-8a7e-05a8fcb9fe3a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0113.namprd12.prod.outlook.com
 (2603:10b6:802:21::48) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: a6956129-0bb0-4851-7afc-08dced59ef7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkFBOEpENGNHakxpWERZWmM4aUo3MkhiMGNoVno3MXJEMWhjaDBPKzl5Y2ZB?=
 =?utf-8?B?ZmE0QmZDRlZKelNoeUhwUy84UXU2S080M3UwaGtZVmZvMFU5OFlZN1BEVm1V?=
 =?utf-8?B?TmVMdG9qQTNjd1E2ZVpCNDl4R1NhTXcvdHhPUlE4STRNYWUzRFdjcThrN21E?=
 =?utf-8?B?ejRTdkVxR0tIakNBZ01OdytOT2duRUpPSVI2S2IvOVRFNDAvNHNEV0xnSGp4?=
 =?utf-8?B?aWJZWStRZFlFQUhuVXNRbWtNQ0c3WmtHb3BJcWZtYnFkc003b3ZWWHgxaG5q?=
 =?utf-8?B?R0ZjaXpyYjZDek0wVWs5dkY5SklqVmhFWVNWenBtREJRRm1yUGR5aHR5NnBR?=
 =?utf-8?B?eW5Gc29GOEQzdUNrOExTT0lYN2dNbXRQWEZMMTRNdWhYWG9YTTRqTWs2RFJS?=
 =?utf-8?B?MnFObE9VbU55M0NCb0VhYVR2R1EvV1U5cXU0UHZ0NGthOEpGcTNIZUtJcm1u?=
 =?utf-8?B?OWdiUU5ObUJCUjhERGJsQzZDS2p1ZjlIVGR1V04xc1RxMDk5cHVPUUo1MHg2?=
 =?utf-8?B?anIzNVlQYW9hRTJqMDczYnAyTDRlWHY5VGVDSVJaNkM0eFlvTUVRR0xVOXZK?=
 =?utf-8?B?L25LV2VsU0QvV1VDRG1iMkFHa2tkM29EQVY0RXIxYkV3bmdFdXlYc1pma3pQ?=
 =?utf-8?B?K21HSVNtSllpemVaeXpxMjZzRXZtbkVVWWZ3SDFZcDdkZkZ6cnhSUFI2WEZW?=
 =?utf-8?B?UEZmanJ5b1pldkVTYmJKMlJKQ21IYzBoRHlkWkhGMjNhT29ZUFQyekJaQVBQ?=
 =?utf-8?B?RmlCUDg3MUtnRk9rajFCbDAxM2ErcjhiWGZSaXU4dHpDT2RhVVpnQnNnckRB?=
 =?utf-8?B?dWNFNW9Nbkp6UzQrY2pPSVAvWDltaU8zSTRGN3dGNld2UDZ5WVhURWUrNzFj?=
 =?utf-8?B?c0RFUzJxUHNDU3ZqUnBJWS9jalJHV1gwQTQxWUtBamtkbGpvWmtCUkJKWVlN?=
 =?utf-8?B?dTA5WWpGYmRmaHBNc2gyVlBqT2JnWjZucSs2WGs1d2N4TWlDL2lhdXlRODFz?=
 =?utf-8?B?V21tMndWNXlSUDdUQ3cybGlnZ0puMFhwbUxtUXBaS3FXOEtYRjBacTNwaEVE?=
 =?utf-8?B?Qkl1ZWg1MGs3VG5uSG5XWnovTGZobVVidlZDYll0a1oxK0VTNWd0SW10TUsy?=
 =?utf-8?B?bGZGRXlhRjUrRCtNczJMWHRaZzZVTmFreHdVakpVbXY0dzZVYWhHU25qSTZ0?=
 =?utf-8?B?K0VlcjJDZGF1d1NuMEZoWlJKRUJKZHViSUttcTRsQjVSdE01Ky9nZURKdEo2?=
 =?utf-8?B?RWVDVWRGWmtVVjVONXMxWDhqWnREV1lVUnJkYTY2bjhOc3M1WFFWcmpkR1Ji?=
 =?utf-8?B?MlUyU1lwVDR0K2JxQjFwVXVBaSs2SVNaL2MyK2tjc3BubjNQTHhmY3lyQXpU?=
 =?utf-8?B?Tlk5QmVYckJ2Y1IxRVRPYkRXWDJrbXc3UEllbEp5ZmI0U05pRTNTb29kSVNH?=
 =?utf-8?B?VWlrSTNHcENjcWZSOFhWa24yeGZHaXVvZnIxS0pQQmNWQ3FxKy9HV0dTWENL?=
 =?utf-8?B?bkttT1BNVkdLY3RVQ0lCYmhBb0puMWJ3b2pwYjlueU9pSHErc3FyVnRWV213?=
 =?utf-8?B?Z2t3ZXIwSDZEV1ZDcHV0dC9rREM5enQ5dGVNWWZnanp3eEp6WVVDRTRJRlZU?=
 =?utf-8?B?RjlqV29yTCt4TTBrbkgrS1ZTYW5UZE55ZHRkR3pCUkdTMUUzb2p3ak53cWIx?=
 =?utf-8?B?RzEzTnNRS2ozNEtDWkRyalZFbjBOeFZNOFFuK3JZNDhlTnJKbHdtYUxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnVUTUtYMG9mN1Q2Z0FiSk16UEs5dEdlaWhUKzNWUjU1OEgxSU5SWFp3alRU?=
 =?utf-8?B?dFhXT0dLUHNWV3h5bnVpTkQrVXRxVCs0eWI4NThvR2E3WStIdHpWcE8xWGNW?=
 =?utf-8?B?SFlNYVYxNE1DL0JFcStzODdmNm9FZk9JVUc5cmV5M1E5L3FzWDZGT0hYdm56?=
 =?utf-8?B?eDVQNHhvSVVWYWZjSGVYY28rWlgralJ0KzBhaC9XS09VWEppTngyc2d0RlUr?=
 =?utf-8?B?TitSVlQyWFhMUXVXNnQrNGxwdlFYL25VOGtxMDIyL01BZFN3NUZWS08xQjE3?=
 =?utf-8?B?bUJCTGFWa3RNajhqRllRTzEwWWdncGhjUjVEcmpOR3F1d1pYM2hnc21hZTMr?=
 =?utf-8?B?QmhKZWZJa1ZQK2locTc3NWQrNDBJUWE0azM1OTlkQmlEdElVUnpDajJRelJo?=
 =?utf-8?B?cUpKM2g4ZGtFaVBoQi9mSlNtNkNienk5SjJUbnRGYjE2TXBtTms0b0k1QWwy?=
 =?utf-8?B?ZjZ3djFMQ1lUNGRaOGRoa1FmQUdNaFA1ZEd3WC80NDBXOWsybngvY0JmejJZ?=
 =?utf-8?B?YjQxZnZSYnlsRm10WldTYXNWTEdvRFMwNmRjbXpEanpmdlIxTVdYVG8yQXZ6?=
 =?utf-8?B?S2FCNW5jLzZadFNUMlI4TFB4TjgvV09NdHEwbG1tbGRXUXBnd3l2NkhaYUQ5?=
 =?utf-8?B?TENmaWwwSEJramVFR2lXckNGL01jUHg2TWtnNDBjSnlBVXQ3RW96WkUyWnoy?=
 =?utf-8?B?M3A2Ni9EZ2ZGVGNLQVBKN3RWOFY2aFdUeDF1T1dTSExDNys3NVhWbFREd2dR?=
 =?utf-8?B?RkcwV1hocXhtVTdUc21rVEdhb1A5TjJ6QWxFdllCNXV0TEZGVWFIWkxWWDlM?=
 =?utf-8?B?K1RiNXU4ZEtZbEhwM1l5RDBMWVh6R2I1REpQbERFUDlPMVlsbjMzNWFybk1a?=
 =?utf-8?B?VUZRcFV4bEtobXBiVTlFN2g1Y1pWNldyZ2pJREtFeE9XL3dQdXZqQjlSR2VY?=
 =?utf-8?B?WkdrM2xZZytzeGFESk5MYXhrdW1QRG8rRzc4em1iL2JQVEZuVHU0RW8xdXgx?=
 =?utf-8?B?VHFxemNac053b21LR3J2enZQcDNDL3hCUG1KWCszUms1MGlwbUh0MnEyT3dL?=
 =?utf-8?B?eE44b1BQczl4ZnI5MEtYQW9sMWVUc1pXa0lKWEV1ZE5WUU9HYjRKMWJObWtx?=
 =?utf-8?B?R2NISkE3ZWhDTytHZjVYSGNaK2RheXd6b3BZRnE4QTFJL08xc0lOQVltNVQ0?=
 =?utf-8?B?Z0VjbW91alpRd3hrUGFWVi9BUmRQb2hHTkRrQ2YxOTB2OHQ0ZHBGdzV0V09K?=
 =?utf-8?B?YUR0VWQwVDZkcDY2WVJZQXdaT1BxSzZVa0NEbGh2OEY4VGVYNDVVbGlLUTNM?=
 =?utf-8?B?NEdrR0tuVXNqZmpBbVR4NG90UlhxWkxwSDNWcW1ISVFacTlKUk9BQWMyVms5?=
 =?utf-8?B?b1NsaWU5NEYzdmtzNlpsL3B0TksrcVlTT3F6SWowZ1ZCVWJMTkdjUDZPeFVZ?=
 =?utf-8?B?Wnl5QkJnYnVpcW5nVjQyQVNmZFV0ZEw5TU5HZFp2YlZOZVZ5Q1NqMmdjZ0F4?=
 =?utf-8?B?cUpmOEZ2alFaSGFKako2QkRxSlpBV2R1WWo1RUNscERiRWFZRTlPdGhEQysv?=
 =?utf-8?B?cGJWdUdrNlpJdEU2Z2ZocjR0M0J0eVFoZjFTdWJqTHBERUdFTkZYWWNDZnM1?=
 =?utf-8?B?bWhpRlF3M2ZCUU1UazBRNnY4L1hwZkNIcmhXM0E4MlQ4ai9lYXo2bEI2VnA4?=
 =?utf-8?B?aXdseERXZ1VjRG1xcEg1bkJWZkZLMTRxSFRibytEZDJOUTVsV2NDbzFLb3R5?=
 =?utf-8?B?d0JuRzV5Ym0rSll5Rlo4YytucWNtdGdvNDNQOTRBQ1V3ZmYvRVNEVFVGbVFj?=
 =?utf-8?B?UnlxaHJBcEswd3lMUnhaVDVRQ2VOKzhScTJPb2kxd2JhSmhQN0lIMmxIMklS?=
 =?utf-8?B?cXNPTWZlS2NDa2FIZTBrc3ZGZWtSc3pzbkpTd1NOY3MzM1FpYm03SUlKK3FL?=
 =?utf-8?B?NERaem1GK3RHYlFPZlROcTdpVTkrYk0xWmM3cVdLR1k5RVVxQXh4cDQ5bGN2?=
 =?utf-8?B?NEszTjJwVzFPejlEWUFlVVd2SHlGZFZBamk2bmYzdG1adUlTTFh3SysrdDV0?=
 =?utf-8?B?d2FmK2kwL05xaE9RTTZWZTYrY0FvbCtsNEJXdmZjVzl6R08rdWZEMmlMQVoz?=
 =?utf-8?Q?c2aI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6956129-0bb0-4851-7afc-08dced59ef7b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 20:42:50.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /o74w97UPsLFhKiWiaqmqFlrmjuXeR1kOLN/R69MIeHshsZu9X0NyFnLe763Schk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258

Hi Reinette,

On 10/15/24 12:18,  wrote:
> Hi Babu,
> 
> On 10/15/24 8:43 AM, Moger, Babu wrote:
>> Hi Reinette/Tony,
>>
>> On 10/14/24 21:39,  wrote:
>>> Hi Babu,
>>>
>>> On 10/14/24 9:35 AM, Moger, Babu wrote:
>>>> On 12/31/69 18:00, Luck, Tony wrote:
>>>  
>>>>>
>>>>> It is still the case that callers don't care about the return value.
>>>>
>>>> That is correct.
>>>>
>>>
>>> Are you planning to change this? I think Tony has a good point that since
>>> assignment failures do not matter it unnecessarily complicates the code to
>>> have rdtgroup_assign_cntrs() return failure.
>>>
>>> I also think the internals of rdtgroup_assign_cntrs() deserve a closer look.
>>> I assume that error handling within rdtgroup_assign_cntrs() was created with
>>> ABMC in mind. When only considering ABMC then the only reason why
>>> rdtgroup_assign_cntr_event() could fail is if the system ran out of counters
>>> and then indeed it makes no sense to attempt another call to rdtgroup_assign_cntr_event().
>>>
>>> Now that the resctrl fs/arch split is clear the implementation does indeed expose
>>> another opportunity for failure ... if the arch callback, resctrl_arch_config_cntr()
>>> fails. It could thus be possible for the first rdtgroup_assign_cntr_event() to fail
>>> while the second succeeds. Earlier [1], Tony suggested to, within rdtgroup_assign_cntrs(),
>>> remove the local ret variable and have it return void. This sounds good to me.
>>> When doing so a function comment explaining the usage will be helpful.
>>>
>>> I also think that rdtgroup_unassign_cntrs() deserves similar scrutiny. Even more
>>> so since I do not think that the second rdtgroup_unassign_cntr_event()
>>> should be prevented from running if the first rdtgroup_unassign_cntr_event() fails.
>>
>>
>> Sounds fine with me. Now it will look like this below.
> 
> Thank you for considering.
> 
>>
>>
> 
> I assume that you will keep rdtgroup_assign_cntrs() function comment? I think
> it may need some small changes to go with the function now returning void ...
> for example, saying "Each group *requires* two counters" and then not failing when
> two counters cannot be allocated seems suspect.
> 
> For example (please feel free to improve):
> 
> 	Called when a new group is created. If "mbm_cntr_assign" mode is enabled,   
> 	counters are automatically assigned. Each group can accommodate two counters:      
> 	one for the total event and one for the local event. Assignments may fail
> 	due to the limited number of counters. However, it is not necessary to
> 	fail the group creation and thus no failure is returned. Users have the
> 	option to modify the counter assignments after the group has been created.   
> 

Looks good. Thanks

-- 
Thanks
Babu Moger

