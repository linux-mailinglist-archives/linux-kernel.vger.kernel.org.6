Return-Path: <linux-kernel+bounces-526811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA97A4039C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4596619C1463
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F8724C67A;
	Fri, 21 Feb 2025 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4PYVuhF9"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E81253B74;
	Fri, 21 Feb 2025 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181386; cv=fail; b=JtEtRgNW5JMQndyT7PqIAFruP/iAcH7H8cuBjQiVCQ84sZsFxl6gm7gYTCJMy52yCwrJK45vv4cU7iTUQnNijgPLRRZTnz7OATUsYEWs85TbSSrO5x/Eazt36Y+5OZVFhwyw5ZZB7SWX7iGmZebtdI+RktdXONH/3J/oKsARu8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181386; c=relaxed/simple;
	bh=q+5GEhu6m7Jy8MAoH+BJNvIdkABvvzLtLLLbyiL0xfc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N/M6Nm30MlBR5FxjNqt+uu/Sf2Pj1bi1J2SPg3Nuz43GLqmX7CUwnOJdpWWZ099pyCyqaV4CUJPzaHVXTgoP9QExsBDbs0dRGq40lMS9fYomArSsHRcfdyGZOfbbd2/zKpQe7cS+9BZgAX3XQnE+dD8kbc3zPpGAGako2nNEEXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4PYVuhF9; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xj/Hf/iCjw7CetpMgTvVkYhEn0nip03lVD5597VJZZmbw9dCRcOKaBi6pQH6NUnUpHlpNt/GpZ+98SroVqMKwXPHC1UI/XH85p6kTut64QsqluwDboInrSjW36esXP+Y2SjnXrT04W/TjE+HKj3LNsVqj3C/V4xG4ophFXhpjylp0/h/+8WmSGIzfwkiouaDq1ulsuNKRpBHqNxA/d3R/qJg8iGcLizCMnjdDB2lRyg1YjFv7zdJZUbwiZ6XG2un9l7UjA6rAU2GmMm+665QzMvnYLbZPUBqI7BQ8kDsOs8FxlQzrMjCnhY3o3VPA1WKbdmRT1Ap+8CAGbApRZKWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmhj/E/cAVMvlVcjDwyJKTE5EDGwbB0/YbKy0CIN2hU=;
 b=P32YqLwegz28YzwsQkDlrlA89xIqQ/Uaey/ZXyrj54yPwPzbxPUHp2RdUV9um1v8yTS4qH42vtJ+PpoI0Bp/40bypfMlZfcx7L6vjhQWs2rPxOvNpsOQ0PegBFRoYt563GXTUF1KZOVy1YzHuwQ5KU4whWytK5ATENg4FVWs0aP+y/4VI8iF1sSqNOrCcj+mbN9pZwDcNGAemU4fSYuPUmzNPLn5NDz5ebG6TPYJ0iNhsXPMs7cFOp9n1mUL9651agtmKKhRHCW/SLi99YMrjlv/Y2+ekOgknnwlYVSwYDMF7yfNf9E+Fqt0go1/fl7vVyGG9h081Cz/oZpSveT2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmhj/E/cAVMvlVcjDwyJKTE5EDGwbB0/YbKy0CIN2hU=;
 b=4PYVuhF9nT1+MzOS8DBbqQp2ziy8b++k6Qtw7f7a/EyKolHVPYPb7lRRnhqnDVVd93lXhJqmmVdWTjVe4+NM0NONrMjmE1OpufQQS6P/jzm9IXU9jl3s1UED/aL4G6WzfRdyvFdiJ6kQTBplnBj8758zRCVMhmnmGxJMbFScTeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 23:43:02 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 23:43:01 +0000
Message-ID: <c0afa85d-d196-4873-acb7-08b515410fcd@amd.com>
Date: Fri, 21 Feb 2025 17:42:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 17/23] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>
Cc: Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, tony.luck@intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
 thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <2119b76ef8be21b1d8b2deedfab23e8e33ba724c.1737577229.git.babu.moger@amd.com>
 <Z7XfcV05ZZkHm6bc@e133380.arm.com>
 <CALPaoCiPkjbTf2He2tXsguxHDtGF+YfVUZScL8dseVc6rvAfvA@mail.gmail.com>
 <ac6860d4-92b4-424e-af4f-d6e3d5722232@intel.com>
 <CALPaoCh8siZKjL_3yvOYGL4cF_n_38KpUFgHVGbQ86nD+Q2_SA@mail.gmail.com>
 <Z7cw4JTp3Hfx/4li@e133380.arm.com>
 <2889da50-b654-403c-910e-13b9144596fd@intel.com>
 <Z7i0etOZcZ9jM/ZU@e133380.arm.com>
 <5f651b5a-3470-4ca8-80dd-4593acef6df4@amd.com>
 <84e31944-39a2-4e15-9772-56f82e70fbe6@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <84e31944-39a2-4e15-9772-56f82e70fbe6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:806:21::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 3541c659-6584-4f82-8881-08dd52d17aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1g4dU5TOXkyTXhKTHNidXpod2lVZDhDZTNnQ2hzbFBVVHZIOE0vTGczNHJM?=
 =?utf-8?B?NjlwTldYM0I3MjdGZjNiL05BU3NwMXRyYmNXakpqMjVlNVdpQmdpREQ0WVRw?=
 =?utf-8?B?N0lhdTdXWEdiU05rTmNSVkVuK0ZTaXpUc1VGSGdrYlEvbVdEWVV5RVFtc3Rm?=
 =?utf-8?B?SkRNUEhTTVZqc2E4NGRESHYxUUZ6aGYxOG1qZjhNb0NURTZmcGQxU0hNTkJ3?=
 =?utf-8?B?L0tlQWZnNno2bG9PTkp6VHJ5djR4T3RRTHU3WVhsS3hJNWx2ZGxXYSt1Kzd3?=
 =?utf-8?B?OXhUU2JObHFEdEVEZVJTcnNmS2t0UGQ0dkY1RDVndnNCOUNCUzVDTXNLRXB0?=
 =?utf-8?B?QWlXalZkeHhOeGVvdWkxdkIwa3Z0eG45N2wwUlVjcEptQWZ0Q1BWVFViTWNZ?=
 =?utf-8?B?ZjA5d1dRd1pxM0w1bC9CNHZNbExkZ3B3dE5QMGQxVzFTYWlUYXF6NmlpZ01h?=
 =?utf-8?B?cStUVWd5aC9hU0RQcVBteGg2ek81S0tJNmQ4dkdBWmIrMTM1bXhYL0RYYlRa?=
 =?utf-8?B?WnJLV0FUUFI3dDZxMlhKbk9iT3RCSlcvdWZwWUhvWDkyT09SdU1EdG1WZHgv?=
 =?utf-8?B?QVFlaUFjWTByZnZ4RmNwc2t1NDg2OTBOYjRweVc4SXJTZExka3FlSHhJM2l1?=
 =?utf-8?B?K1F5b3d4Y0lMbk91ZTd5bjZyYThaT3lwZG1aWEdrcWRjZFlDTmJEZVB5bkRW?=
 =?utf-8?B?Q3ByNWlsS09KM3BnSXdxaHRjOUgwOW5qODA2NWJucTJuR01YbEJ1Ky9YMkRp?=
 =?utf-8?B?MUNmZ1ZqM1hNVENCVysrZm9mcm16QkRkMkhLVHg1TkdWTGFoTkd5cU4waUhu?=
 =?utf-8?B?cmtqSEVTTzVuTkVvSzlRYXdidTFiUXl4dEtubnZibTBDVFlDQUZXMlNodjBC?=
 =?utf-8?B?ZzJOZy9HaDVSN2lyc0ViaG1hSEkxNlJVSFBxdFVlYTNsWXhjVWNzakpLVk44?=
 =?utf-8?B?bUtXSjlLajhVL2RCMTBOOU9rZi96UkZhdG9UdUFhRTJ5NnJiTGROamFVZU4z?=
 =?utf-8?B?d2txTTFjNDlzVFVUOUsreEppNGlaWG5Ha0hRWGJqNURFclAzVGZEWEVTTGRr?=
 =?utf-8?B?RlpOYXRuTEZvUVl2aWMzc3FSdW1qRDIyMVpvY2FkZGNmK045YjkycGRSNWhV?=
 =?utf-8?B?ei9NYklZbzBHc0pHcFptSE5ZY2xGdzQxSDYvNDBSMXhxY2dQbWtiMnRqSkFH?=
 =?utf-8?B?WHh6c2RKYkpGNjFPN2d1bG4xbk5VdTcyaTBkWXdTSWRKZ3RUTCtaNDU3UGpY?=
 =?utf-8?B?ekJJUEZXeW9QWi9tSXpEWTFsWUZlM1lFNkNWQTZQU3c1VFF5ak1td1N3UDY4?=
 =?utf-8?B?S3g1QUdWeTJuenUvNWRPektMMHA0bVBwaldmNkl4aG9nTmJrSUxPKzBNYWFl?=
 =?utf-8?B?dWgzbENtT2loaWZCSzBLNEpzTWsrTHFOblEvMmNtQzZKYXZNbXlWeUtHZHNG?=
 =?utf-8?B?eWZoQ2hGdmhPbmZNdjhyRXJaaE9kc0pyeFptVG94ZkJpL3FEbzJ1bkhOWDNi?=
 =?utf-8?B?ZFVEaFBkWUNkY2FNVDJmTmJ1SVF0S3gyM1pVekh0cVJxbjAycWplUDRteUU4?=
 =?utf-8?B?SEk4YkJTQzYwQzFHS252WmszcXJSRVExY0hubFB6VEgzdmZsSFU3MkRlUjJV?=
 =?utf-8?B?eVcrZU1ZdWpsdDk0ejBOWGRoRXFOcytPRStDY2RCK3QrdFRRV2F5Wk5wbnh0?=
 =?utf-8?B?YmVLNW9JUWUxcEFmQU5oK1J4YW41MjdMVmtWZTRMZXlleU8rSjRiaVMzYUky?=
 =?utf-8?B?RGpwc3lhWjdMbDM0UHFZMjNaWWYzUWFLSFBCaDNSalpWRnhoVDhYWGxraXps?=
 =?utf-8?B?RXNYdEp3RHl5QXVndDBLd1hrWHhGb2JjVzhhTzFmTFNoRk5CaEtqNW9tYlly?=
 =?utf-8?Q?w1UkQkTMECupL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VERkd3Z6UmVEc01VVmZ6eHowbGtlcm9uV3NpV2QzbHpyNVQ0SjRUaHN2blE5?=
 =?utf-8?B?QWgrTVJTUXR3WFdLV3FFUE1wRDBEUHJmOEtibEozeTFPNWQrdXdzbnkwcnBH?=
 =?utf-8?B?bjRpYzAydktGT2g4aE9sWHZVbFBwK0NXUTFHbDh6b3NPc1haWi9KNVVBM0o2?=
 =?utf-8?B?ZW9rYmlKTHdtRTl2NUVIcG1KazZvSHZMOGV0N1FBd0doZWdoYWgyQzhlZXBr?=
 =?utf-8?B?R0ZmNmN2a0ptbUJTQUN4UXB4U2Z1TUVvZU1QRnYrL3pvSUp1NWk3ekNNZXBY?=
 =?utf-8?B?VDNFcWZ6MlNFcFBJVU1MVituR0dpbUozb002Z2pPQTZEQm5CUWtoWVd5R2dN?=
 =?utf-8?B?bzN1TEFxNEZlSHBDWUdkYk16TTFpcE90aEtDMkhSQ2xsUXNyTlNPY0NwdWZW?=
 =?utf-8?B?a1BhUG5wRmpKUDhESTRnWWtmS1JkVmJNZ1R6NmZvUWxmREZZQVJjMHZ4dDVx?=
 =?utf-8?B?TENVdHkwbGc5cDYrN3p4MldkYmNSaGVVNWJiekR3TG42RUdrZDZBb1daNjJw?=
 =?utf-8?B?dkt3SlVQSVpxSVppUkMzMzRLaWxRZmU4NHhleHBPL1BnVnlnVFdibzJOc0k1?=
 =?utf-8?B?aG44VTkwSmRJU2ttWlphZnR4ZUdZUGtZd2FHaUxwMTJodDlKR3hNOERxWVVq?=
 =?utf-8?B?WkpyWVZnRkJqVFhYQlJWUms2dnBORFZHRUxjeHhoNWNOR1BUK3VmT25XWGEz?=
 =?utf-8?B?aU5rU0c5SVg0N0h3TmhuN0JYdUcyRFpxOHlTSTh4QlpZSjM3Smg0VmJWSGtx?=
 =?utf-8?B?VWdTK3J6UzFGSm9ublZjVUs1T3NMdHFFaHd1TDVxOGQrQ0ZXeWNZNkFoUWVR?=
 =?utf-8?B?bExOL1YydFZ6NG4wdFBtWnI0Y2hWTUU0QlIvMW5xM28za3ZWTk1JbVVqZE04?=
 =?utf-8?B?dUZ1di9WZVFrY1JhOUVSYnprQUxjWlVvWUlibFI4OWQ5cW16TTlPSXhWdWtW?=
 =?utf-8?B?M3A5S09DQTVXSGJEUFBDYkptUE14R1dQcVdLMUh1UHlHNDZEOFA0WDJWSnp3?=
 =?utf-8?B?cTk1QlorMmZKNFl4bTVXb09zVDdOZndibm5raWRQaXBXOUJhUHlmalpPVW1C?=
 =?utf-8?B?UjF4RWV5ZlIyVXh5ZlAwdTZCQjhzUm5YdmZ3b3hIc09qbFo1aTYzeWt5SzM1?=
 =?utf-8?B?SldJWVFSMVM1Z1dhTUlaZFVUZDdsTlVDSEVielpEakpmZEJDU1ZBbjBxcmRq?=
 =?utf-8?B?WnBQdHY5WWMrYVEwMmhKbzgxSTlrUlZQOGN6OXUxVU5jbCtMaFBUYjJ3cGMw?=
 =?utf-8?B?NHBib2Z0Vm5OMlhnSnhjdzRISnFKeDYxcGEwaXRhKzh5Tzk5UUNGOFRVcno3?=
 =?utf-8?B?MUlCc0J1dnZiU3J4UHA3K28wV3VZbXhaaG40V01iWmszN3FTZGk4bjFOR0J3?=
 =?utf-8?B?L04wQXhXQi9aQnJLNlR6bFlUR3JmR2dkSUg3TWl1blFFZlB6Q3JWSUh6Ritv?=
 =?utf-8?B?aDE2WDRaajhIV3Z5UFp0U1pwaXhUUVc5L1ZmeDZBZkQxeWNtRjlMUFNWRFVz?=
 =?utf-8?B?cHJSbk1nV2FyZDBjOUxldlFaQ2JqZ2RXT3NmR1pHWXZlbDRtcTFlb3Z1Ukdp?=
 =?utf-8?B?a29XOWtxVCtGbjBxOEhJRld3aHBRckNVZDFQdTUvZEt6RXAwM3kwWjUzV2lH?=
 =?utf-8?B?OTNHVnVzWTlCNFI4bWlUNEFPTXRpdndGWisxdm8wbXdkRGltejhXZDVCRjBt?=
 =?utf-8?B?Y1BaMldXMVAxcmVQZFJ3VjlVZ0p2ZU1MWDAvL213aDBQTnU0dDYvTzRJVVVp?=
 =?utf-8?B?ZHc3UUNublJtWlQ1ZkZ5eGtTN09HSEcwNWpsL1NzMjQ2UkZmOXQrbU5UeEc4?=
 =?utf-8?B?Q1grY0NxTEJVNzUvY3Y5ZjJqKzNWR3BoSDZ2SCt0cTg0Z0o5R1pTQWZwQjBH?=
 =?utf-8?B?VGg4ZldtUUhTSkpOdDlDbld4S0sybHNPd2xJQUV0NURrd1NEY1V3VHdjVnEx?=
 =?utf-8?B?elVpZFI0OWwyQ0NyT054NTd1alpNS0FCOVhTNEZOOHJTVld5ZHFYMVFSOTJX?=
 =?utf-8?B?bDhyUlk4OEpJWVBIS2hwRUhaZUZSM0lnVERhL3l2ck0vaFJVVHlDdEZIbXlh?=
 =?utf-8?B?c0VuV0Rzd01vK3VaR1RDdTcyQW55b2oyVHpzdUwyYjdTV080QndFOFFzMkRi?=
 =?utf-8?Q?XD8M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3541c659-6584-4f82-8881-08dd52d17aac
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 23:43:01.9189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwKK56ZwOts9jLJpWU83cBuULkN8SZrOc+x700Fg0AxRcjGw24W6VILjwqTetTzm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391

Hi Reinette,

On 2/21/2025 4:48 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/21/25 10:23 AM, Moger, Babu wrote:
>> Hi All,
>>
>> On 2/21/2025 11:14 AM, Dave Martin wrote:
>>> Hi,
>>>
>>> On Thu, Feb 20, 2025 at 09:08:17AM -0800, Reinette Chatre wrote:
>>>> Hi Dave,
>>>>
>>>> On 2/20/25 5:40 AM, Dave Martin wrote:
>>>>> On Thu, Feb 20, 2025 at 11:35:56AM +0100, Peter Newman wrote:
>>>>>> Hi Reinette,
>>>>>>
>>>>>> On Wed, Feb 19, 2025 at 6:55 PM Reinette Chatre
>>>>>> <reinette.chatre@intel.com> wrote:
>>>
>>> [...]
>>>
>>>>>>> Could you please remind me how a user will set this flag?
>>>>>>
>>>>>> Quoting my original suggestion[1]:
>>>>>>
>>>>>>    "info/L3_MON/mbm_assign_on_mkdir?
>>>>>>
>>>>>>     boolean (parsed with kstrtobool()), defaulting to true?"
>>>>>>
>>>>>> After mount, any groups that got counters on creation would have to be
>>>>>> cleaned up, but at least that can be done with forward progress once
>>>>>> the flag is cleared.
>>>>>>
>>>>>> I was able to live with that as long as there aren't users polling for
>>>>>> resctrl to be mounted and immediately creating groups. For us, a
>>>>>> single container manager service manages resctrl.
>>>
>>> [...]
>>>
>>>>> +1
>>>>>
>>>>> That's basically my position -- the auto-assignment feels like a
>>>>> _potential_ nuisance for ABMC-aware users, but it depends on what they
>>>>> are trying to do.  Migration of non-ABMC-aware users will be easier for
>>>>> basic use cases if auto-assignment occurs by default (as in this
>>>>> series).
>>>>>
>>>>> Having an explicit way to turn this off seems perfectly reasonable
>>>>> (and could be added later on, if not provided in this series).
>>>>>
>>>>>
>>>>> What about the question re whether turning mbm_cntr_assign mode on
>>>>> should trigger auto-assignment?
>>>>>
>>>>> Currently turning this mode off and then on again has the effect of
>>>>> removing all automatic assignments for extant groups.  This feels
>>>>> surprising and/or unintentional (?)
>>>>
>>>> Connecting to what you start off by saying I also see auto-assignment
>>>> as the way to provide a smooth transition for "non-ABMC-aware" users.
>>>
>>> I agree, and having this on by default also helps non-ABMC-aware users.
>>>
>>>> To me a user that turns this mode off and then on again can be
>>>> considered as a user that is "ABMC-aware" and turning it "off and then
>>>> on again" seems like an intuitive way to get to a "clean slate"
>>>> wrt counter assignments. This may also be a convenient way for
>>>> an "ABMC-aware" user space to unassign all counters and thus also
>>>> helpful if resctrl supports the flag that Peter proposed. The flag
>>>> seems to already keep something like this in its context with
>>>> a name of "mbm_assign_on_mkdir" that could be interpreted as
>>>> "only auto assign on mkdir"?
>>>
>>> Yes, that's reasonable.  It could be a good idea to document this
>>> behaviour of switching the mbm_cntr_assign mode, if we think it is
>>> useful and people are likely to rely on it.
>>>
>>> Since mkdir is an implementation detail of the resctrl interface, I'd
>>> be tempted to go for a more generic name, say,
>>> "mbm_assign_new_mon_groups".  But that's just bikeshedding.
>>> The proposed behaviour seems fine.
>>>
>>> Either way, if this is not included in this series, it could be added
>>> later without breaking anything.
>>
>> How about more generic "mbm_cntr_assign_auto" ?
> 
> I would like to be careful to not make it _too_ generic. Dave already pointed
> out that users may be surprised that counters are not auto-assigned when switching
> between the different modes so using the the name to help highlight when this
> auto-assignment can be expected to happen seems very useful.

In that case "mbm_assign_on_mkdir" seems on point and precise.
Thanks
Babu

