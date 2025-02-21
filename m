Return-Path: <linux-kernel+bounces-526739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835A8A4029F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4441118852CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A6E24E4BF;
	Fri, 21 Feb 2025 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rZsteLpY"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6772045B7;
	Fri, 21 Feb 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176704; cv=fail; b=HRKYJNkocbhSNWnf2u3nHyVUgws7KnNk8vu/Umfb2AejSYx13DdTJ1UDro8J/R7/Siy3Nxygo5sJE3viJlDgZNySxuXnS3jHcOLF/IOV8cIOPHvs7ij8ilIIri8U7+dTpQnx5n7Gxy2+/+Idn2qHYwiBPUu2QDzGdsoTX/0bZ5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176704; c=relaxed/simple;
	bh=XYTewVZNa7YujSATsUdWzJmc5x/8dyQMz7XHrhkDI9A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AC0KDXDMzEE5E+r8lWJ39jWaBqDEDZypv5RevR+3SDvgJR8DplVlNSBdLFVRBEnpC5NnJkP2b7qxe+OeZCiqe3qDIHnxi4oXC7fjSqCCzMDup89XRcyyCWDfOSRTVBjDkB3HIWLy43zR2rOAZwWddW73TbcKI5Cwb+orF9OMIJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rZsteLpY; arc=fail smtp.client-ip=40.107.96.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ud4WDgZAjBzbbBt2GAHbcNhRUAWvGwb3tnsge7DHZp6wfFthpm9yFTI1I8oJMdY+xdDuPejGW0g5VAjrprWnpBnKHa+ugQnHs3LFa2KJ+krm4BwrSliO7+PTUiIwkQ4JqN7ehcmp96qbix9V3/DbJbAH4TxccxNLZukpfD7bUxF+0KCrrWAlCKLy/hp/4jkrf0X61M8ipBPwBXxuVOKnuvZVDzzjpo6EBKro77fkHd/C4rxMWzG9lUpSRLE7f2+1LQzY5/yNMV+h9D3qYbS+Q7HrOebTZjUhile/WhnRg5acmE7vqCrXwj1KciuHR2UytrFyr9ubRNA6+3+v0+Q+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHENJYZTSZ0DevP8UplJRiADX6asdyT6lgk2cuxS1OM=;
 b=qsJErDP0DFHaPj8QFXS9FvdQIZQY/bM1MgabHzBjZUqZlaZXMI2fCkYo47HEgwbwH3dCOPlI3T45HJZN7c0ILDP0hBC+iThXo3oNjS0TELjbbvkQO70KkbMf77Is1+iVPhwK6TZjm9wiedF9x1y8kKDm/5pD4d4F+WUOHO8eVhIX4fso1B36rsW1aVAtVBHqDMSPLGOQ1chF8bGP/6pwJIvAs/M3ptILRZOlhpXQym+cXZdPX4xqZYrUz54EbkwSuAPcDs5FEs8OdC/0bC2ok8uTPTDthK3ot4NUlaHqTqaisDUBml43ZScXXjRoE68lFEhwz/sATGk+eT/OqQOf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHENJYZTSZ0DevP8UplJRiADX6asdyT6lgk2cuxS1OM=;
 b=rZsteLpYNjRMUsEeKqOAy+fjkqvYYqZRtCtVosjguSdz5alVZLkhwgvB7Ru/xnveALGmdZ0QgcrMj9G3HCwcfXtWR03LWH1Wzwbffk3HefjE+552cWhONoU2rHFT8KpSWfKRJNkwhlLayIjLWANDxE6kGwaDVClJpl3IUWqJTtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 22:24:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 22:24:59 +0000
Message-ID: <e7d7cd3f-47d1-470d-aa08-49f36682a55a@amd.com>
Date: Fri, 21 Feb 2025 16:24:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/23] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
To: James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
 corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 tony.luck@intel.com, peternewman@google.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, jpoimboe@kernel.org, perry.yuan@amd.com,
 sandipan.das@amd.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 seanjc@google.com, xin3.li@intel.com, andrew.cooper3@citrix.com,
 ebiggers@google.com, mario.limonciello@amd.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <d0bc17f3f5be4175df34011a366136cddc8df6e2.1737577229.git.babu.moger@amd.com>
 <21666e6f-9886-4657-bc14-af472bc878c8@arm.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <21666e6f-9886-4657-bc14-af472bc878c8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0074.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 574f77f3-97ca-41c2-b7e5-08dd52c693a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ai90QlduY2sybjBOK01TcUowRHN0bkw3cnZIUWFxTXlkSlEzeWpiVXBrRFZx?=
 =?utf-8?B?dExYVm4xdkl6c3NqOFNISE1UeVdUcUs0TUNCS2FlNUwzdUYrZnRDZURuK1NP?=
 =?utf-8?B?YXd5L2pHa2JPazBvcDNqQ1hSL1FGQmVwRElRdDV5L3FaKy9rTzZ0ZFg3ZVl6?=
 =?utf-8?B?Z0hGTHAyNWhaS0R1SVhRN1M0N3lHRGxLQ3FPWlFrR1R6cFdCQzI5ZlZZMHhl?=
 =?utf-8?B?YzZUQkIxdWZiTXNzUWltMitCNTdDaEZQNUI4bGEyb1dYRHdHc24yc2cxd0h6?=
 =?utf-8?B?ajY4eVp6SXRSdnRMWE9ZOXRDN0ZBZ1JWYmFYOWhTS3JXU2xEM1lwaXRpSWhn?=
 =?utf-8?B?dGx3bEV1amFMMzVpbGFpRVBWdzlFRy95SHk3QlJBVGJ0ZUpoUWtKSHpzeGt3?=
 =?utf-8?B?RjFlZkN1MkhyMFk4QXlGVmVxUVVJVndsSG9UbWlZSTJraSthTnAyVVAwRjhv?=
 =?utf-8?B?TVNnU3RmVnpURCtOWHhFWjhEdDcwZjBMZFdzdDhQMHFHNDN1dXpXSW9NaEM4?=
 =?utf-8?B?SEgzQ0hrbmp6VlR6Wm54OXdOWUlkdGQyTHBwQ1l3Sm8vODROY0I1UFMrN2xT?=
 =?utf-8?B?QUZsSFhpTUFjdEJpWWpwaDRZbXVlUDZ1RXoxVzVSMnhJdE1BRjJMUVB1bWZ1?=
 =?utf-8?B?TFRoZGxQM3RuY0kyR3B3bGlVL2Yrd3oyL3RMbm45N0lzR2tWbmNta25xeTVj?=
 =?utf-8?B?RHJpSkFBMHRlRW03WDdjVHRUcEtDb2l0L1JtTDdFMEcxTlVCcmNGaEE0OXpm?=
 =?utf-8?B?enpTZHQzVy9kWWNWSys3TS9vdTZUTjEzUUVDdGNtVzAvU0ZsQUREa2pXSEMy?=
 =?utf-8?B?OVN2NmNIOHRla1EweHVyb2hQcVFJNWZYRGFYbXZOeTFYRzlTS1FZajV0Vkts?=
 =?utf-8?B?K0lYVWZEZzlLMUJtK251bDNPb2QydmFscDFrUmg3RlFtUGo5cnlYMUN2S3BW?=
 =?utf-8?B?ZC9hdHFMYm5ZTytzLzMzU1VOUmpTK2hFZkZmUVVnZFUzaEk3VW1xZTNFUnhG?=
 =?utf-8?B?eEl2Q0R5SmhiVjNqSFZWRU9xVVQ0QnZUbm1aSFFmMitmZUlIaEpVTmdmK211?=
 =?utf-8?B?ZitjK1VNT3ZEY21ueTVEUjh5a2ttYlAzZ0dtMSt6MWI5M2lXdDRGV3o3MkFh?=
 =?utf-8?B?TVMyOGNGWHpOdTM0bnlLSkRSVGZOaW5kUDE0Q0FKd1pRb1pJeGNJa2ZqcFNJ?=
 =?utf-8?B?RGNpZXZUdERDc01FbGY4NkR4U3NPRHJ1UExZemYrSW1pQ0RQV0lneERKT0p0?=
 =?utf-8?B?c3ZsdEllOEJZQTZEaDlOOWxrRnlxV1ZJeENVRzFlNC9ZQjN4ZmRyb0hlU1d4?=
 =?utf-8?B?Uy8wNEhFTTc5NWMrcUFvZmVsYWVnZVQzbEZOTHlmUHExMGk4Vk91Um9rTWFk?=
 =?utf-8?B?S0JKdS9sNUR2L1docVkzOEVWV01mWVk1SGZMNVIyZTcwWWVzeXlDdEdpTlYx?=
 =?utf-8?B?RmN6SE5qRnVwcDNxd0lUdVFMZm45dzVKQnhnOXgrOFdNRm9YM1IyOXk5WVlr?=
 =?utf-8?B?R0ZyYVU4MDBqSy90U2NDenJ0Ny8rek9hUitVNXJEeGFjUUxrTFNqZXhGTXd3?=
 =?utf-8?B?TWR4dWttM1NrbWhIdUlCd1VBZFFieVVHN0FyOU1QT21IL0lpUE5Gb2p3RG1i?=
 =?utf-8?B?OXNIMFovdWJqZmVWRlVuUEZ5WWRPaFNObE9YNmRPU25jRmJwaEtBQTVoSUZT?=
 =?utf-8?B?dnZPOWpRWUJhK3ZjUDNPNHVMd21QcXorczdoVFVNQlM0VXVQak83bDhSOXF1?=
 =?utf-8?B?clBQVnphT25ZaXNGcXJVNEdlTStiUGpUMkNxOGM1QWxvZy9uc3M0QmtBNkRC?=
 =?utf-8?B?Vnk3U25OeE1pRVhQNXNKZ3FkbW1kaEhvZ21vNEFuL3Nsd2F3RjI3cnVoMWRV?=
 =?utf-8?B?UDRRelI0TjBjcm5xZkJSTWFuelBpSFVvaG9aV3pDS1IxUjM1dkVHZ2tHY2NQ?=
 =?utf-8?Q?RIyQUke2M4o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFRSc1RUOTRSTnRMbFJOeGNuZ3FXNEdtd0ZsZjBSZVFlTHVnVXZCS1l6RjJo?=
 =?utf-8?B?MFg4OXQzNXJXSnlGZUM0ZWI0VUd2Y1JPVFcwVFlTdmppdFlrZzczd1BLQm8x?=
 =?utf-8?B?YWc4NUpLUXUvaHNseXk1eFhSdEZqSHd1dndyUVZHMEVCSnVXTllWVStHY0RM?=
 =?utf-8?B?dXBaaThrN05tSVlFdnplalE4aGZhYVF4Q2w0RmNROGVvMmEyT1VabjhDR25O?=
 =?utf-8?B?QTk3dllnSkdiS2JYSGUzaU16TDhNOXJ3bWx6Z29ld3N1cW8wL0Q3bjRxbE5m?=
 =?utf-8?B?RjVGb2EzVTNiZmVjWU5hck5MRE11WXVBc2xzb2w4WThvVzJlSVpIYUVSdUdz?=
 =?utf-8?B?UlV1T0I0emNDNWd6bTFXU055OUdrQmFKVmRra1lyeTRVbDRBR2ZjQ0FwNUc0?=
 =?utf-8?B?SmpxMjRPamJNYklHNkZ5bFdlSXZJUGFpcXZ6OXhQT3M0SFpOcDJucUUvVWdP?=
 =?utf-8?B?U1lmZXFlbHQyQ0hOdUJIZjE5bGM3QUh5ZnhkblpzQlZvMDBqQ3pYclJYTFpN?=
 =?utf-8?B?T0xSZ2poYlNZS2lvcGwxZXFCWmYvRjNoZEhWQzQvMnF2UXh6R3QwYUlySy9M?=
 =?utf-8?B?Qk9CNW5ueW9JRWpxaGx4UzZyUjluMVhjb0kwMlc2WHU4WUJYL2xhTzJwSElk?=
 =?utf-8?B?ckFDc2ZYdVBqR0NVTDhIWkFYdUd1Y0VVTE9tVWJ5TVJMelF6RTZ6S1VpTTFV?=
 =?utf-8?B?NlcrZFBwcTZSY2FjTldPbTFMUXdTaTZ1UW5zWDBLSlp5SWVDTnVBMmFBYVVR?=
 =?utf-8?B?U3RMa2VvSXJIeCs2MFBORUNMTEpUOEE5eXlGWDJaVnJYbmR0UFFkZUtsZWJy?=
 =?utf-8?B?OWtET3NKRm4wZzdRUzNYdG9OQUZLSE1DZDNmeElVaWFqdVJEN01BZHpvN2xN?=
 =?utf-8?B?Wkt1NnlNWTNSWmVHZVptY0tPeUdBbFVVL3A1ZzJJTTVhZm5kTlJudnFrVDVz?=
 =?utf-8?B?NzhNZnpWalZwbnk1V1NpcThReXJBWmtPMjBET3RueUZTTTIwaXM2K2VtbDdS?=
 =?utf-8?B?bG80djBDdG5mYmdjLzlodlpLNStPVHFZbnJzaEd3L3pjOUtaSENNV1NvUHZv?=
 =?utf-8?B?MnA3NHM0TndheXZNY2RHb3FPTUo1TmhWVVFsMVJ5N1kyNXhYWEE0Ukp4N1Bl?=
 =?utf-8?B?Rms3TlQ1eEVsVVpKbUpFQUMzSjk5ZkFCQUtMYzFaV1RyRXEyLzhKY09BZTZy?=
 =?utf-8?B?cmxDbnZXQ1F4NWFnK2F6Sm13OXc5akJjYVExTTdnSm5mcFBBNmtBb29JdEpa?=
 =?utf-8?B?Y0xjaUIwcE9laXNXNmR0MXRRMStXeXhKTUxtTWdoellFcFpXMy96aVJ3SEx2?=
 =?utf-8?B?R29DL2gzNU1pYXJwTGhvS3VKdzFOU3M4RDBaYm9xQkI5TTh5MTB4OGpjRU1q?=
 =?utf-8?B?U0RvYzVCcCtLMklxdlE1SURLbjJzQjRJcitlUWlmd0Rpd2htUXFFSEluWEd3?=
 =?utf-8?B?VW81c1NDb2xCRUpWMitVU2JkMC82d0pMczVUWFppVTFnQ0I5Mi91ZXdCL2N4?=
 =?utf-8?B?KzNFdUU2TlV0ZW5vMFRDWmpXOG5aeHN2KzJuY0hwUlp3Q3o3RFNacUp5a0k2?=
 =?utf-8?B?V0hONUxnV3hucXppL0tnbEpCQU83SDR6bW5UNm80Y2RjNHZXTytCWlRTbnpL?=
 =?utf-8?B?Y0c5R2VNRHN5RjJsSjBQZHlyY2hSYTVpbndSRGNwR0l1VHpRYVA5QnU2L0dJ?=
 =?utf-8?B?Y3ZLaDl6NzFzeUR6RkpHVDl5WWQzaHhBYUc3RWhSUzRCMkxuQ09BREo3YUZQ?=
 =?utf-8?B?NVp0SWNyK3E1Yy9OSHZXOS91bVhjaEFxbzg0ZzVxT2djS21Mc3UySEZkS0xk?=
 =?utf-8?B?MFJPTXpSekNWOE82ZmFHZ0s1TitqNlZGNkNwTHExTnB6OGtQR2NLNmxqbUI3?=
 =?utf-8?B?MTVROHp6Tm1TdzkyQS9UcllHaWdLMEQzL2pPNHlhVzlScmtRYmRZSXFOcnNn?=
 =?utf-8?B?R1k0MURuVVlwcDV4dnpZaGFCREZManBCcjcvb0haUDBLcXV2M0JaNDJ3bEdG?=
 =?utf-8?B?Z1U1K3dwSXdueTNqRjgzVUlaVU5rT3BBaUlrZVg1N3Q3MUI5N05TdmVXMjFT?=
 =?utf-8?B?bjB4cDVvcEUxQ1RUOEtkU0JEL0tNNUlkZzRYeHA4QWFpK3VieTJ4YlFZdFJo?=
 =?utf-8?Q?4ej4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574f77f3-97ca-41c2-b7e5-08dd52c693a6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 22:24:59.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ov0w+dvOwHmolbnxEFJm8lZojn2lOLpYFmNMtOcoUsMaPtByg0MdPT70t9wYhSMu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848

Hi James,


On 2/21/2025 12:06 PM, James Morse wrote:
> Hi Babu,
> 
> On 22/01/2025 20:20, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID, event pair and monitor the bandwidth as long as it
>> is assigned. The assigned RMID will be tracked by the hardware until the
>> user unassigns it manually.
>>
>> Implement an architecture-specific handler to assign and unassign the
>> counter. Configure counters by writing to the L3_QOS_ABMC_CFG MSR,
>> specifying the counter ID, bandwidth source (RMID), and event
>> configuration.
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>      Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>      Monitoring (ABMC).
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index acac7972cea4..161d3feb567c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -724,4 +724,7 @@ unsigned int mon_event_config_index_get(u32 evtid);
>>   void resctrl_arch_mon_event_config_set(void *info);
>>   u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
>>   				      enum resctrl_event_id eventid);
>> +int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>> +			     u32 cntr_id, bool assign);
>>   #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> 
> 
> Could this be added to include/linux/resctrl.h instead? Its where it needs to end up
> eventually.
> 

As Reinette already mentioned in  [1], Boris wanted this moved when 
arch/fs code separation integrated. Lets keep it in resctrl/internal.h 
for now.

[1] 
https://lore.kernel.org/lkml/e524c376-9ef8-488e-8053-b49ccafd306d@intel.com/ 


Thanks
Babu

> Thanks,
> 
> James
> 


