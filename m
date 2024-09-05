Return-Path: <linux-kernel+bounces-316561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6807396D145
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA741C21E96
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23958194A5B;
	Thu,  5 Sep 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="R+SVEy7y"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2077.outbound.protection.outlook.com [40.107.215.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD6194122;
	Thu,  5 Sep 2024 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523550; cv=fail; b=S8gAivp3/VPKlTx/H9MhqZ/HTC+/gB6DwX/CPs1YxVjaksg+KFKmKf3F0N301CD2d8I5ABd3ND60osiAXPLyCizrpzkQSonT0WhCWWhxnyU59eEYO/mwUkCPNW3bfgbmG4hug088v1teh2nhIeIkIDAetgJ1Htna005MRG62Drg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523550; c=relaxed/simple;
	bh=rRuYQQ6Fv5clo7QMHp/QGPVVJLpT7kY35uKUSBPTY7s=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XjhpxDznpR+YnZxjQE1odLKUb0LsizOEj5QpO/xTe6ftdCqlGc4ti/nfHG+dRlt9lgI+dyMOsEayqMXwLofuwqc3TP3+ESIeaiAWx4P4fXsknMR4BvQhBytASQFJwEz4VTO6ffdM4KMM1xq0DyYiNzVpTwQ1W4KYWJhExWyswFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=R+SVEy7y; arc=fail smtp.client-ip=40.107.215.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkQIQ88E20/GdCRWjBPJcf29K87SO6bf9aneqpwWgUHa2ZNc2HmqFWFufs5gsPd1Sbu1yrNicWbT54sfBj07W/cOTkeleiHSC5mNlLrpC0yX7f9JkW7ocHoHJuwcaBDG8DsBg9LiaWLiBNhSZnFwYCJUfmgey8YusShCpEuRQuHXixT8q9bMtavRzIjtC+r0uIOs8SPIWImzWsL6kwnXP91a8egGAOiHtKWX76e/920qOCsePkAd2G+8AVm6wR3z+TrwlJtL+62nmnXwEyOVwgb8XANthnsdCYAJV8UTpUbZT4U+IBBMF0COWkYzyKIkFvn5786/rPhqqEsLxNpeEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRuYQQ6Fv5clo7QMHp/QGPVVJLpT7kY35uKUSBPTY7s=;
 b=b67FFXDBRnPN90alaRcw3GbdCZXHGXPCNu9AP+hysmYRaBmaZgAiIyGe2HNLerZiumu26x5fQWbUI+xcDKbfyRkQAY2bcvDr4yutY4v7zqp4imLS9jd2XmqB3hcR58KnXp/v3VewDU46LTpS+4fDKBW+XxqGCgoxUWDDCjWji6wRRdyVI5YSj3aarkqDLFXDq7/wKTo6Qtbz984cx2hjjP/1rLtyzkDmydC2GJ7gMc5YrVKBpukd/NSEDGlbGj4un5oFOG8O0BpR+7IjjkKKAN6v3Ao1tKeWc3euoDcg51P07iARIsRlD8mprBzNxKCKMPft6LLCydzdIR2YIelwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRuYQQ6Fv5clo7QMHp/QGPVVJLpT7kY35uKUSBPTY7s=;
 b=R+SVEy7yGlJHqTTQl3hr0NrA/iaS1sCz/MXVUpUpEOEAp/1IimdFnfDLRKVz51JKsV/6Sks75LTCNCyRKObvJq56S1qK7WC6YJ0cblanmR+K466gCCs0svQHN2upnH0/Ki0LQ9l6ko8bIQ8ya+6yL+IS8sLkF7ltdAHkrvq9jOXXkWNEgAqvafG9BUHs6/6jabS8Nc2ZqX9TAWvJyZy6zFTIAWav4KHK+3tQM2oxxVkKck3HrRr/wUmB2l3BfYg/zAwui2Z6uOIISfnYxYgh9jnThRfCxdt4GDB1iQIAg/4zsgkXEn/c3EEdPDbcLqd2h4mkf7572LeURQRHKh0F1g==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEYPR06MB6780.apcprd06.prod.outlook.com (2603:1096:101:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 08:05:39 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 08:05:38 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>, Prashanth K <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, =?utf-8?B?5p2O5bKz5p2+?= <liyuesong@vivo.com>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjldIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogQWRk?=
 =?utf-8?B?IG51bGwgcG9pbnRlciBjaGVjayBpbiBnc19yZWFkX2NvbXBsZXRlICYgZ3Nf?=
 =?utf-8?Q?write=5Fcomplete?=
Thread-Topic: [PATCH v9] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Index: Adr/amOPjrLzDvPPRQu8m32ypYGNVg==
Date: Thu, 5 Sep 2024 08:05:38 +0000
Message-ID:
 <TYUPR06MB6217E6BD48B0B491AA169E67D29D2@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEYPR06MB6780:EE_
x-ms-office365-filtering-correlation-id: cc77d19e-ec15-4e2f-c5c0-08dccd81876f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MjlQbk1MNVFhcHI5bENuV1JENW5Bb0hwM1BySkNQd3RwbElzZjNyTmxNTzdZ?=
 =?utf-8?B?YXArSERBNzBvNllOL1VoSy9zak4rQm1KcXA0TVIvSzVrTmhDU2dvZndmUUlW?=
 =?utf-8?B?TFNNcjJKdXRYVmFSM0VScTE5ZFoxRWpyRW5FWEtvSmhlM3ZQaVhwYmxJc2dQ?=
 =?utf-8?B?MXZjN0NXODZHaDlod3RBKzFySS9WQkkwOUFKTVpsMG0zZFVIK0VoMUdzQVFi?=
 =?utf-8?B?S29VbmhqTTdHbm1NUSt2S2MvaWcxV1JyQmhnSFQvRWZOMmZYbUJDNnhjbkpX?=
 =?utf-8?B?ZnR5UFU2dW00eHluNVY1YmhPZElMQ2FXQlp6VitwQ3FFR285Q0JVSDZmYmFa?=
 =?utf-8?B?Ym05U3NEdlBFU1F4aDJEQ2pGUXFtSU8yb2lzdmpjRitBcU9pcFdXeWE0bGJm?=
 =?utf-8?B?MHZJZG9Nc2FzZVFIbTlITTFZSFpwdUhCNk42WGVXMU14NzF5QlN4cGphcUsz?=
 =?utf-8?B?ZVN6djRLdElCUldoN1F3OGI4UVk3dWxtS0ZUcTdVVy9QUG8yMW9FOEtCK0Rh?=
 =?utf-8?B?emkyb0RDQkRPMXpIVmVPRHQ5N29DUHZTQmlacjFQWUgxNHhiN2g5czkwZGhr?=
 =?utf-8?B?Q3Zxc0pKclRuSDBFcWZOTTF1ZFVHdHAxeGhXUlA2UnhtZC8zcjdhV2pWQ3k2?=
 =?utf-8?B?UVpZUXduNjFlc1pOQWRmR2hQODlWMitmN3hUTTZvKzFqSG9MYjhxcU5LR1ZR?=
 =?utf-8?B?ZXNHdXdCU1lERjIrdThJNmNqYzJ5cDU1R1E3NGU0Rkw0Qi9nY1ZFVko0bGF0?=
 =?utf-8?B?ZkU1OGcxUXluK3kwQXV2RmswSkpSZXQ2REYzdDNLM2x6ZkdZNHF3ZmVFbVBj?=
 =?utf-8?B?ZTQ4cjEzckNkR09CeHhXRmpVQTQwQU1XdkgrUmFERlFEWFRWbHNTSlNWdkN1?=
 =?utf-8?B?Y1ZzdVA1V3R5enRxNlZLWDJLdjZBZnRQL1pxM3d3TDNSTTFta3IxQzVDR2hv?=
 =?utf-8?B?NkRTUXJoWVcrUVJVc3hhdStkRW9tRjNFTGtIcVB2MjFHTFlKSnNLc0tQYUxz?=
 =?utf-8?B?bWw1VDZFUkFObnFMc1RGZG5HZktqQWFKZkU0ZTVLOGppUjROcWE4bDI5Zjlx?=
 =?utf-8?B?NW5UUHpZdkpXUFQxOXhISHNMV3RzZ29FUjRmajFSTml0dmdsdUtBV0JZbTk0?=
 =?utf-8?B?VldkcnlZYnIvT09vSHd1NDdUb2pKRmlvbWQ3Z01IM1VDVVJad1QwUnY4cm9j?=
 =?utf-8?B?emg5RWJta3hocEhFNGJ0Z21MaWRpdFBkK1AzaXVsUk5uRjgzOUFjcFBrRTY1?=
 =?utf-8?B?a3doeG9jOTRnOVZWd2VEbXFsa0lFdlBzZ2RNZzNzeVhab3BoS3U1V3FnMDM0?=
 =?utf-8?B?V2hINnlXdzVtMXZxaUpjWXVxaVpGUUJ0U29GRmlmTlBiRWJ2QXBNNGlKcDhm?=
 =?utf-8?B?UFRHaEZ1YVdtaWJvYi83QnQ3bHZFYVdOMExxVktWR2RHdXJ2Y0NuMndUTC9k?=
 =?utf-8?B?V0cyMlpsZVZyYWVkZzZHaVQxSnBlK2FuRW1nbXpxaERzc0M5QWk5WHpaVzBy?=
 =?utf-8?B?dXVnN1UzZTJxNmczbS90VTVMRDc0T3d0bDg0SzBZYXh1akNSNWZvTlUvMThn?=
 =?utf-8?B?NzJ4bllieGN5TXB0WDdvL1hZZ0ZmSlRyZytqaHNudk5DSExjM2N5RUFKblZC?=
 =?utf-8?B?WWxIVmJBVUNIYXcrd0lROGVuSVAxdU4vZVpSc0wxaVc2bnd6d255ckJLZXhz?=
 =?utf-8?B?NWxzZ3hpUTgwUXpGUnJwMUFtT0F3UGc4L1dMNXJFTzVDMDZTdW54M1N4NVhH?=
 =?utf-8?B?WjNiLzNhRTE5Tm80Qm5WZEUxSDQxRFF5Zkd5UWVFaFpXVFpGc0UxVFRIaE5K?=
 =?utf-8?B?LzFrR2ROYW0vcG1XZS9WRDB6UVlwRWNMRWpiU1F0RGVDdmZEMWxWYkl4cFA1?=
 =?utf-8?B?Z0FxUkx3NkhVV0pYTFFnMW1QMEFTMEk0bGpDRVhVYTQ5enc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yk0wd0pDeTFZTElnVkhydmxMVk9Za1BuS1FaWDZDWkgwaXUvSGhYek5GQVBY?=
 =?utf-8?B?WnRXVGFEQ3p1a3cxbWZwcmxwaVE2enNML1crOVNaMk00d1ltMVN5MUh6WFpi?=
 =?utf-8?B?SFZhRWQrSFZZU0d6UnlWcUJoUHgvc1gyTkFielUycVRlYyt4R0JEaU9iamtr?=
 =?utf-8?B?aE11T0RBMGRxNGJ2OUxybVFHbzcxQ2hqRTNKZFd3ZkxIajhVRjU2US9OSWRB?=
 =?utf-8?B?QjhzZlFFMlVVY1lUR3AwZThiWVUvU3U1RXVaVURscUp6ZFlHQXRodVVwUzNL?=
 =?utf-8?B?R3RzQ0h1dXF3VEZmWW9nK0hFN3pzWUtDcUdxK0ltSVBkOHRnYk9zbVQ4QnlK?=
 =?utf-8?B?VVBIRVdkNzY5eWtBZUY2R0tYT1NLcEZjZnRVaU0rL2s0bHJHVEVzN0tjOEI3?=
 =?utf-8?B?bnk3Yms1d205SWlvVWZPblgzWTRLdEVLRk5RRzRxTDE4MEpkWGpDSHVXUC9m?=
 =?utf-8?B?S1A3akwrUlROanVINVdSanJ3cHdQS21CV0M5djRsTW5haEVUamVtVFI1cGRm?=
 =?utf-8?B?S3ZOalBVTTMvQU9lblFObnc1ZVdOcU1xQWQ4dlR4ZXNNUGl2VGZtWndUcmVi?=
 =?utf-8?B?bWRkY2ZoelJycnVvUFd0aFl1QWszSmg0UWdsYVFDSVJFbUZQODZkR3JjNUFi?=
 =?utf-8?B?dG9aQTRSUGZQU0ZCRGwwUU5BNzhiWTRpY3l1UXNyM1JDMFFpckNWWnV5TWNL?=
 =?utf-8?B?VmV3UngwRjVwMGZCMTZRSjhibjhMcWlEMEZ1Z2laNW93eEhwZTlXRkp3VDJ4?=
 =?utf-8?B?U1pMNy9BSzRjS0FxaHM2Q1BEMURwdXZVZHhrZ2ZZd000VUU0clZ1dGFWZ09O?=
 =?utf-8?B?c05lM1pXM1I4ekFodEdud2c1VXFnaUZRa0NQREc4R0gzN0ZCMk1KOUZBRU5w?=
 =?utf-8?B?U21zUXhiYTFyRFdVdURsNW1UczRHL2dvZlowalBuclpHUDZNeGdJL1ZUWVBa?=
 =?utf-8?B?dzQ0UzhrT0ZHZ3JHRytBSHVETjF4R3lzV2NLNmhSYjBHMlI2LzZKRUs5S2hW?=
 =?utf-8?B?VTlwcXdOazdSSGJvVFFGbFEvL2xxOFFEMkswWEViaGt2QnRjNUl1WDNFRDJu?=
 =?utf-8?B?TWl4MVVWTlBYSzN3RGgxTFN5MVVzU0dhaWozODJCY3NVVWV3SFRFaVJkSDN3?=
 =?utf-8?B?M21KdTZFWEVJWEppeEVWSTJZQXdUKzczVTZNNFBUWGtRb2JoS28ybjY5Mm4r?=
 =?utf-8?B?YzBHQmdleVZjUk5sSE1iM2ZUMHJKaExodFduS24xK21WczU5VnpOcGxrbW1J?=
 =?utf-8?B?UTBVTmw3OVBrUEJGWGFHdkR4RUVsNkJlUy96UzNoUk5xR0ZNL1dCVExCR0lK?=
 =?utf-8?B?ekhTbzJmMWZQWklzZjM4T0hiNHVSMENYaklXczNCWEV4ZUNYUVpsclVtaFUz?=
 =?utf-8?B?Sk91bW9GYXIxTGRZMlIwSVIyQXRidXJMVGFaS2ZCeUptU0J4eE5RNzRiT2hE?=
 =?utf-8?B?WWVzWDVVdVBRSXhRbjJvOTJwbU1UdXRoTTJMYUNRT1A1MWcvc01sMDdTUjRB?=
 =?utf-8?B?RkJGOGI4b293MVh1V05mWDNoeERFOVFjNTJLSFVkWk82Y1pydEdHSk0wZHM2?=
 =?utf-8?B?UUpwR0RRUFUwSmpMTmlzSWZ0UXZ3RFVxRFBCL1RCSlpwQUlIRmRkcUszb3A0?=
 =?utf-8?B?bmNDckNxOGRJVm80ZWszYm5UOGJtTFJYcThPNlpBb1lJTHJkN0F5dXA5YzZ1?=
 =?utf-8?B?REFFbGRUUEE1NWZSTzR4bHhxSFJXcHlDSlc5OGdiZGNMMWFEU2NrbTFvbFpI?=
 =?utf-8?B?SHozYUxnQ1U2UHRLUnJDK25jZVF1VnUyOVJkcEt5MTJna0VtSnpXbUltdkF4?=
 =?utf-8?B?WDlaVnZYUWZ1S2hDdkFKTWZhM04xWXQ0akgzcTJ2ZTUwV1hFekdxR0ZNblpu?=
 =?utf-8?B?U3A0VmJEa01vK1NPQmU5YUJ4VzVIUFBGdkJqMWF6dnh3ZDJlWFFmNmRUSTVh?=
 =?utf-8?B?a28xNUdPOHJRWWRqcG1RcEIyaWxlRmEvREVCTGxlYWZNVGM5eFlnUFlPaDBn?=
 =?utf-8?B?L1FBQjBEczhaRG9yS0NmbklyNk80RVprZ1EzMER3dTRENURJM2NuMmxyQjJ1?=
 =?utf-8?B?S3pJY05RTVZGK1pldWMxbW05MXpMV20xc2t6emVFUWZoU252VTMxS2Yraitx?=
 =?utf-8?Q?rvxE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc77d19e-ec15-4e2f-c5c0-08dccd81876f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 08:05:38.6324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +udEE88j2P4t2efvZ4aE/niS/ink1B1lm8oouiUAGaa6qcJxFMbdiXJa1uURQcu4EG4fLqQcXkSTLgKp31xY9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6780

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCj4+IA0KPj4gPklmIHlvdSB3aXNoIHRvIGhh
dmUgcGF0Y2hlcyByZXZpZXdlZCBhbmQgbWVyZ2VkIHF1aWNrbHksIHBsZWFzZSBoZWxwIG91dCBp
biB0aGUgcmV2aWV3IGFuZCB0ZXN0aW5nIG9mIG90aGVyIGNoYW5nZXMgdGhhdCBoYXZlIGJlZW4g
c3VibWl0dGVkIGJlZm9yZSB5b3VycywgdG8gaGVscCBjdXQgZG93biB0aGUgd29ya2xvYWQgb2Yg
dGhvc2Ugb2YgdXMgcmV2aWV3aW5nIHRoZXNlIGNoYW5nZXMuDQo+PiAgV2UgdXN1YWxseSBkbyB0
aGUgcmVsYXRlZCBwcmVzc3VyZSB0ZXN0cyBhZnRlciBQYXRjaC4gRm9yIGV4YW1wbGUsIHRoaXMg
cGF0Y2ggd2UgaGF2ZSBhIFVTQiBtb2RlIHN3aXRjaGluZyBwcmVzc3VyZSB0ZXN0LCBhbmQgdGhl
IEFEQiBST09UICYgVU5ST09UIHByZXNzdXJlIHRlc3QuDQoNCj5JJ20gbm90IGFza2luZyBhYm91
dCB5b3VyIHRlc3RpbmcsIEknbSBhc2tpbmcgZm9yIHlvdSB0byBoZWxwIG91dCB3aXRoIHRoZSBw
YXRjaCByZXZpZXcgb2YgdGhlIG90aGVyIHBhdGNoZXMgb24gdGhlIG1haWxpbmcgbGlzdCBmb3Ig
dGhlIFVTQiBzdWJzeXN0ZW0sIHNwZWNpZmljYWxseSBmb3IgdGhlIHVzYiBnYWRnZXQgY29kZSB3
aGljaCB5b3UgYXJlIG5vdyBmYW1pbGlhciB3aXRoLg0KDQo+V2UgYWx3YXlzIG5lZWQgaGVscCB3
aXRoIHRoYXQsDQoNCk9LLCB0aGlzIGlzIGEgY2hhbGxlbmdpbmcgam9iLg0KDQpUaGFua3MNCg==

