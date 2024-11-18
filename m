Return-Path: <linux-kernel+bounces-413530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 369229D1AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B307D1F22312
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F261A1E6DC7;
	Mon, 18 Nov 2024 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kElKd6D4"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC3256D;
	Mon, 18 Nov 2024 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965497; cv=fail; b=cgPha6Zkla2lflRXpJ3QnCfujsHLQ2ee3OuTx8F/pJdtRrUoIZn1NUjGZsDokEMgp/Zo359WgL1AGf5MQD/V7lI6FInQLcrur7QRH2LGkG14MAHQD2/V6+np3MoIL6IuubF+gle/dV4NODdXtEbrSSQ/Xx1v1VcDgJ7afyeopI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965497; c=relaxed/simple;
	bh=oi6f7G2HYhux4I4TER9b1ek+MgTUGjUqOLM3BGaRMgo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r/WkxAumr/f1B34ZlGSgxAiTCUSi4XPexaJ/27MIEA5FQyyOdpuh8p2CmOXsOesvemj53cZktEEGJ1Sb1GXSOasJQTTff/oejiJSLFLyguBrsudgYhnR34bEw/2RKobCLUkA9QSMP4tifmNG+xvA7Sgs0BSmOBxv5uZkpNJ7JxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kElKd6D4; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5KU1qeSoN1FS3k55//K97UIy4CfKJla5fLsdQkmqjuQX9nyhWsO/zv80J9cBlvD3sMR+xZtlioQCoDMmLKuQVzQAne8fqMM3GqosGSDy3h/Gnb7fuPjPP4baxZX8NzsQEmxgWt95I0EXV5GiUDgIdGxpi4Favu6/RiA3qhr1jSNMG6yULNJR164Go7uuO9yB8LeMg6qVxMOsxAhZOxmShyxnxAWzPLrWcaGU7TSU2cYZsTvtKvoVVn3EYCf2kSfiVoOt7KB63GFIVbEgCngqF3b5sIEjXxp/H0o6WPoHuyND0T62jNOqTMAXHAazmwfaCP2x3rcB3OyTAjhKM7rQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srU8XIlB1WD4iPLzewd5b1fDFYS5H1/JFO0eQU4rlOc=;
 b=a88DzlwG5HnTQZ/ioUPoqXgdZD2ardi0wQAXNBECRfXFPpmgFpR68p/cGGzuFx/CrEAP4xoVOsBS6Q6XXEjl2+AKySIGCnqXEun83pOGA0uEgBkMXp3eJqY8iCdHC9F4vDnBA66HVuJOYaO4CGsPrdRXL3CdYB+IAhvZnob4YPg3zEtC7qfeFTt01m79GO1LlMjSZU5oCDi8AsX259BZkbFw9K5R9kXyB4QcMQcNCs7XULk9jHvt8T1A8mzrkJ3QDdqcB6hh+fFObFXD6HYUqUOITIyM7IRTjwxREfz8lPBv8IC0Hq07jmUccUX7u/xj3UOUuSw9mbKjxRzCBDzXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srU8XIlB1WD4iPLzewd5b1fDFYS5H1/JFO0eQU4rlOc=;
 b=kElKd6D4aURCL9sL0rI1zBivOVIPnNTPe8A7rnk4TcHnfdcGuaXb8H1nhDMaHFeoVDwrwSsh26PaVxgmSHcz1WvZDWVYAeubGVkpB7KDlEFMe5RFjMYUsHArfM8oeWDh7/Z+iFssI+0dfjZvTOTekEWWFLImiMwcn1ZHmlGbNg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 21:31:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 21:31:33 +0000
Message-ID: <35fc70fd-0281-4ac8-b32b-efa2f4516901@amd.com>
Date: Mon, 18 Nov 2024 15:31:28 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 09/26] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, peternewman@google.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <447a268e3cddcebc30a0b2c5ccb321e3c6b9c8d9.1730244116.git.babu.moger@amd.com>
 <b6ef8e35-7acf-4391-9cab-76d7910435d7@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <b6ef8e35-7acf-4391-9cab-76d7910435d7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:806:24::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 14cdb6a3-cd71-4791-bfbd-08dd08185f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTB5aC9Hb1lFbGdnUW5KVFB6YTExVEhlMk9iZWM0TkFHTmthVVFFY3l3djRL?=
 =?utf-8?B?TDJTN0JNYWtDT3R1RWJkakYxQVJlSE1oajcxM3Jvd3F6VG1FdkJEZDFJeUlv?=
 =?utf-8?B?MzljRjV2Zk1QM05VTDNBck1OR3R6ZmNqenBtajJhUVJOK0toR01QbVFEQ0xw?=
 =?utf-8?B?Z2QvbnhKMkdsUWdrOGcxSWVlbFRveXgzK3FYUXVOckxETEVLVFY5MFdSL1BO?=
 =?utf-8?B?L0VPRERVeTJVdHduQjk4ZWJOcXR1NWYxKzQvRThXOXNuaUhkbk02RmxseTVn?=
 =?utf-8?B?b1ZZblB1THk2U2x1d1h0bU4vSUt4aVE2dUQ2UHdlYnNGek1EVEhrT0pFK0to?=
 =?utf-8?B?dkNnZU55UnFhTGdBSWE0ZWJLQmE4aUJrcDhkZHdKVENCa3BuQzI4aE9UVlNw?=
 =?utf-8?B?VThZbGQ4NndrT2J1cVhzdDZGWHFUenJBN0ovdmxuWHpIZ1Y3TWFoUjZaalRJ?=
 =?utf-8?B?dFlRbXljaWRrbkVBeGsra2poN01vZklWSTA5NnFlWDkwOHQzdVVyT2RUT0U2?=
 =?utf-8?B?dG14cngzYmd4bFhwWTU5c1BaSVpwRVN5a3hyVm5uNHhkWGFGM09JNkpjcWph?=
 =?utf-8?B?K0JSYzkwWk5URmtjYkpJaGJkdDd2dkQyTTR6WkN1RExGMGZJMHFDVUVsMmhz?=
 =?utf-8?B?Qmo0bDBhUzdvQTFkN3R2anJhS1RnL3BJcWxNc29JOXl3M2pqKzcvbWdRYjBC?=
 =?utf-8?B?dmMxWXRDazNURmZiMjJ4REwxWFVHT3J3V2NkZ08zZkZqUk1RQ3dUQmhFeW9U?=
 =?utf-8?B?S0lnYUhCazRoTzFTSVNxb0tGamNMaldFQVpCaXFHMWJZUy9XVFZtM0FyU09V?=
 =?utf-8?B?NzE1QnVydHlVV3V2YnRsYmZuYVdaOHVWUkgvWHFGUDlhR051UldZUEVYWGdu?=
 =?utf-8?B?WXJpSWRaeTZKdFgyQ2k5NjZ5b2FEaW03SmdNMXdBdVUwa2dyLytkaU0rb2NO?=
 =?utf-8?B?WGJhc2pMVEI5RzRRTzVRSll2SG5kOXFsaTRXT1BCTGFVWEFOWkFlNnVoMU1p?=
 =?utf-8?B?dlpTS0F3aVUxSHNJaXJHZGk1R3o4clo2RVRsbERjYjVDQ0VhTUlrSUhhSzND?=
 =?utf-8?B?RzZjTzBsdmY3QWFKcU05OUtKbWd6VjlPSEdQTHZhanBLMlgrakJmMExGME8z?=
 =?utf-8?B?dStUaHhWVmJSS0J2TVg2SEwxdUdnVU5ra2pPMzVDbUlkMExnNTlqQzdQbjRa?=
 =?utf-8?B?TTI1NUtVVnhOSDhoWEtFdDlsNWhCWjkvc3NsRnR4QUZJZk1TdTYxS3lzSTRF?=
 =?utf-8?B?bzB6U3R0bWU4YTh3RVZ2S29KZFBkVWN0WmhlTEFiemU4Um02clFsbzFCZG9R?=
 =?utf-8?B?K0FnRlVLei80MmR0MDVZSkprN1lDNFZvdWRNRkpIQTdpODljT1hCVUJ5L3Ru?=
 =?utf-8?B?b0tTWGFsMUIrTTRnU2JUTDdxN0IzbElVbW1QYlVnbkdPM0pyd1dUNnc2bDF6?=
 =?utf-8?B?ZTNrVVdLeHlJUzdORCtrM1pwYkZRcnhTY214WTBhbDc0ajdXUHlKM2IxcmZm?=
 =?utf-8?B?Rm5tckNKM0tBM1FlNUhSbmVvOWpaRk1yOGs0RnBGYXFUUkJUTUx0T3UwRUh4?=
 =?utf-8?B?T1VIdDNaOStHaUVuaXBpVGQ1SlF2VE56THFYVHhwSitzaWYrR0kzZFVKSldK?=
 =?utf-8?B?T1ZwRWZIMmNIa3YyajFGbmlLc3dUUXJDQnp1NzFkS1lmSWh3dHBxdERPaEYv?=
 =?utf-8?B?cUd4blZKdlYvSkhVYjZaK3RJNms2czRqaWsrMzAwUE9keDZUSGkxMSttbkhj?=
 =?utf-8?Q?mvfXZIznqBXhqTCekeqlMt6wai0doFu71RJc7vo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTRORk1UZU1zblNmNWg1YkRZeHk5Zmd6NmFVSGlXVWNZWS8wZHhDR0poVFF0?=
 =?utf-8?B?d1pxemhoWTZKR2dWb3NiN3V5OFhZWGNrZVRsRU5rQ1FTK29hY1FQckJhdEtL?=
 =?utf-8?B?WlE5bVlGNjNVNllLcHlqUG1DMGlYR3ZxcE1FNGlPYjFreDM5ZklVdlI5QzdY?=
 =?utf-8?B?eHVkbW9FYkRnTXYrWFlrY0VUQXV3WnUwOVJRVHZQcHQrVkk5K0Nzb2lwUXE3?=
 =?utf-8?B?dmR1QkpnQmRpRWZ4cHlQNUh6S2tHNmN4VjY3dy85Q2ZodUZEOVN4WTlLOFBz?=
 =?utf-8?B?VUlHaGhiNUF0RGpQYUFZektsWXdMRTlMTUdHWm5zanlmTG5Mb0d6a0xpQVZY?=
 =?utf-8?B?T0c3ZjlHQ2hOcGVtMUU2ZGhHOXNNVGtWMElmb0lhL3Y5amRZUnZaLzN2THVn?=
 =?utf-8?B?UE9ZckR0Uy9kaWRZRWMvcG9hODZLUGpaS3c4Ym5lbmpOWmFrRGFDajk1MXRO?=
 =?utf-8?B?QVpBUElpQzFGQmhCWWs3djVBRDh4N1pkdzJlcmRJS2o1V0ZDN0JuTzd6bElT?=
 =?utf-8?B?eDFaSDBCS3NycEs1V0N3cE5zZnhrelQ3ZktwK2k4ZUIvZnBTMVJTN3JaT1lR?=
 =?utf-8?B?WGNzSTNEbDZiTWI0bmhNdll3MjRUc2RmZXBVNXNqdjRWd1B1WWxIaUJtczFB?=
 =?utf-8?B?WkNZanJvR0ZIRXNqM0FXTWJWajdxRlJSbFk2dmVkZWh1YWNENFp3b2Z1c0xO?=
 =?utf-8?B?L3o2UTRzSW5pTUFzMklwbDY2aUJqUzY0ZnAyZUI5TnFCNmFmU3piRGdMNjB3?=
 =?utf-8?B?VGhYS01mZC8rTTZhQlgrVVlRbXNMMTJPMTdaTXNwRW0rSnJZRElXMU5TaW9l?=
 =?utf-8?B?U2VPRUd4eVU5QURacnFHQlVtREp3Uy9nU1h4SVpic3lyTnpBOENyOUVFeTND?=
 =?utf-8?B?bDEzSXFFWFI4RXpBT1RkRzl4MFZMcUltK3hBRVVFQnFhZjRBVnRWZzE5YURs?=
 =?utf-8?B?T1JuNEw0MkJpSmZ2c1VsZTMzc1RYeGlCZHZ0VldzZ1psNWVBVnQrODlGUGcz?=
 =?utf-8?B?U2s1Z2JhMlpsRStiUXlkWml1SjNJaldmUEdZY2pOUzI1TXZCRTkwa2U1dE9o?=
 =?utf-8?B?Qi9vUThkNWp2clltaFJtemd5NlRtZ1N3RlpyZmlzbFptYkZoVlNaR1Uxb0VE?=
 =?utf-8?B?USsvQVRQY3dQNENqRnJUT2pjSGRxOFptcHc2NzZndUIyYWZpc3NLSGpyRWtB?=
 =?utf-8?B?c0tycHZFZGxyU0ZzeEtNdzFpYW9rSWt1YmRvd2xmN21vSURrN0NoaStmSVAw?=
 =?utf-8?B?dnMxYXd5VUlSRkd5OXZXQ3pkaEJrQTQ2Z1NYVkxDUVllQ1lrNGxHdmZBcnlY?=
 =?utf-8?B?K2luTWRWdzNnc1JKRXNnaTNtNzBObHQwNkh1VFprc0VkNVhpUHRteG9tN01k?=
 =?utf-8?B?M29BSzUrek0zaTIyMTl0MytqRy9OUnZMT2o3dHdJTktpaGozempBUGZORnhr?=
 =?utf-8?B?S0xEU3hJRFpwSXFOdmNWM2Zuejh6Tmptd2RiV08xWjZ3eE9zMFoyVVg5RWVh?=
 =?utf-8?B?RmtqbWg5S3d0UEJYMjdLM1VVZCtFVGowcVpGWHNRVFY4L01BNE1DZm1FL09h?=
 =?utf-8?B?amRmdHN2QU8vUUZGT1k5aW4zMVYxYzBVUFZXTjBnUGJZRTBMdXhpaWJIZXpL?=
 =?utf-8?B?ZTJmODY3bU1ZMUtxZWxCYWxrY2MxL1hvSCtIVVNMM01paUk1ZUE0cEpYYjVD?=
 =?utf-8?B?NTQvZ00rRlYwTkVIMVQrOGdSMklUTWp0eUdVUHhYeEtGcHVKWm5XNDlmREF6?=
 =?utf-8?B?aDdCT1NHRVg0OGU2QVl2a2FyNitmcnJ4UUJGUVNSbkN6SVAvaHg2eVpPZDZ3?=
 =?utf-8?B?ZXhmNkdsRmkybUlUZkZSdmNMRkRYOVM0RmZRZmgyV24zNXNiYmwwZUt6TXFO?=
 =?utf-8?B?WndaYXU2MXFhVVByMlhpSnBhbzlTNFZvSkFnTU5SeklWeTZ2OU9oVWRiVXJH?=
 =?utf-8?B?UjV3ZTM5SGphVEFWRkJSaFVIaDMzcjNFTlpMM2tUWTVVVExnbE5hdVA3V3V1?=
 =?utf-8?B?K1IxQ1I4bmloeGVQNEttbW9KOWY4RUJIMjJLb1M3aTdnQWNSVnN3N0YyL1Z6?=
 =?utf-8?B?bndVcVREU3RkOWhGSWZxSTRUZFcyMjh1RlIwa3dGWndYbzRiU3JTQ00yTExs?=
 =?utf-8?Q?mSuQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cdb6a3-cd71-4791-bfbd-08dd08185f6e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 21:31:33.2037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEjbmAaLiDyN/BR1aHAvdZOCb1v/wqiYOILGIl86Dm5hGrcMaynTdQmBoD7qy+ip
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

Hi Reinette,

On 11/15/24 18:06, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/29/24 4:21 PM, Babu Moger wrote:
>> The mbm_cntr_assign mode provides an option to the user to assign a
>> counter to an RMID, event pair and monitor the bandwidth as long as
>> the counter is assigned. Number of assignments depend on number of
>> monitoring counters available.
>>
>> Provide the interface to display the number of monitoring counters
>> supported. The interface file 'num_mbm_cntrs' is available when an
>> architecture supports mbm_cntr_assign mode.
>>
> 
> As mentioned in previous patch, do you think it may be possible to
> have a value for num_mbm_cntrs for non-ABMC AMD systems? If that is
> available and always exposed to user space (irrespective of
> mbm_cntr_assign mode) then it would be clear to user space on
> benefits/risks of running a "default" mode.

I am trying the work-around to get the number of max active RMIDs in
default mode. The method is to loop through all of the recently assigned
RMID's to see if any of their QM_CTR.U bits transition from 0->1.

I am not successful in getting it to work so far. I remember Peter was
trying this before in soft-ABMC. Peter, Any success with that?

If it does not work then our best option is to document it.

-- 
Thanks
Babu Moger

