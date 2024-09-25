Return-Path: <linux-kernel+bounces-338062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AD49852E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AF5B22956
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AED1553B7;
	Wed, 25 Sep 2024 06:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lc6NUfI6"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2058.outbound.protection.outlook.com [40.107.255.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A2647;
	Wed, 25 Sep 2024 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727245778; cv=fail; b=YPSWavVE7do/KPmw2NL6aOqjUwuEmcKEDVAwA5R84xaJB4x2HpTdGGos8sw9ZcvJIHZwmdjC9gtZuXw1/uQ63gsh61LmRMMK8qEfQw1147GxDJeR8LtoY5UeFAMwdUMtQMUi5Dy7RFMpVnZj9dpdPtCGTI4Ege6y6ZqH5+tk1gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727245778; c=relaxed/simple;
	bh=fu2GtYlzTZpbvC7g+6qD7+bnie36ivONJ+qbfgkc+Z0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uo1sBfx4n6hCRl/udVzOiS2c3USYM1R0ddr38ZoE/X9pAB3tSy2OXiyJfAiUyyBCItYbpvGUqqXQxFG7LglE0LoJLcmB7gFrvjWdPJLtGlABSO3UIedMidXgRc8z079XkWtFw1CBGC+11tc7LfdYuQZ2zt8+HE/iAo7ReNykzNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lc6NUfI6; arc=fail smtp.client-ip=40.107.255.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5XYQ18ZCHXXrXtSzC/Z6lbLLnZKLZVY5nel3OHqqsv3MrGL7DU/9vJzT7xQHFDWXKUHHE4jsC9qnFlmtrnfDKmLAUh/fiWNF61xH0wjZetwC7iIJoi2sGjg6lvBbPsXTHwkMNVb9hSTwBaIcTSDXEk+ivdfc53Ems+yX5MPHSX3H8CLby8iUgMv54CQowSD6hwBzy5OKVnoIlQKjDKYAtFeBx7lzylQEAXcfof0s+gZEWE50oATOFZmulfP28X357e3P4eYw601wfHhSao8W2w0y5e3bLV0MHgqa4OL+/6SPC1uzXPjlxcBZwZNW/BunbqKJ3gDnqtoMTtlKWWQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu2GtYlzTZpbvC7g+6qD7+bnie36ivONJ+qbfgkc+Z0=;
 b=gsZp7+W7N7PhJfFs+61H2+ipbJXwfeMfQAeRzW4k1QGuBznYhlJRwVUBVaHc06mA2rIRNLHQZxR3NwcpNUKnPxhFsYJMeLO0KPJAHUu09bztFb+EiL4ytJhuwzWHUf8R79wKe0Sy//rPkHew+R/BwhMUFK+mpGN9IcMQ7jKJEjReSSIqfvjOdtnBw0jNkfbWC1IMbvcUny8B+aIQehhdNFcFX4/RM6BoDRqvlJB9/SmwptwivfqoNoidLFHWklaY6L95PwQRQ7pE0WVdA5PBqLDBuoyHfmK38yhOcSsqffge8u3ZmdI6zhPcD9camT4dsyzS4c/SM6WGJSkhlNYAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu2GtYlzTZpbvC7g+6qD7+bnie36ivONJ+qbfgkc+Z0=;
 b=lc6NUfI6VA3/3ycN3SCYdUSa9E7Qg+RzuZ5/V+/XquFzJt+ohC8AaljddLvxsR63t22CcHHMfWEODos7zGidu0A82PDKHe70qz2zFlRXB+av6K3FPbjwAOPxfcaMLwO0jBptaYEEoMCBx7RF/TNI1ePdWzMNa942sTak1J8rHewCoaL/qQojiODwX4wvz5sEp56E6cQKhJ2/BKGuvCTZWsZku2cVj2Svmiowfbbh9rD264An+Df/HzA5/e7C6TsrAny4n4Xkh7J5cRR7t6K+mmPIAasMQB8cvBw+BQ1E76E0e46CSPystyBx96tVr/iloNRi8gvg5aPHrSnVA8IzRA==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TYZPR06MB6936.apcprd06.prod.outlook.com (2603:1096:405:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 06:29:32 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 06:29:32 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Prashanth K
	<quic_prashk@quicinc.com>, "quic_jjohnson@quicinc.com"
	<quic_jjohnson@quicinc.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjldIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogQWRk?=
 =?utf-8?B?IG51bGwgcG9pbnRlciBjaGVjayBpbiBnc19yZWFkX2NvbXBsZXRlICYgZ3Nf?=
 =?utf-8?Q?write=5Fcomplete?=
Thread-Topic: [PATCH v9] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Thread-Index: AdsPE1bYjUtvsR7DQN+/HxlvWWVxXw==
Date: Wed, 25 Sep 2024 06:29:32 +0000
Message-ID:
 <TYUPR06MB6217CBC7A42AE66F2B7DAF9AD2692@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TYZPR06MB6936:EE_
x-ms-office365-filtering-correlation-id: f02a2ad8-aaca-4d9e-3121-08dcdd2b6adf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFIzNnhTR3VrR1RGV3N1SC9IMlNBOERRamtNM0Q0VURWNHlqcVBjRVFGMG85?=
 =?utf-8?B?bEZRaDlnTzdJWUVsUDVKK0s0eTg5SzRhaXkzZDNMNmhxSVZHRnVPaEdQd2NC?=
 =?utf-8?B?aDk4ck5RbjE0QW4zcVFXTjYxTk1LakhHSFJEQ3ZoWVQ2Ni9JMHhXaXNFcXpm?=
 =?utf-8?B?ZGdwS09xR0U5NUxiRjFPc21VWHNUdmMxT1Ayd2gxam1Zb0FiODdhbFFldmdz?=
 =?utf-8?B?aG9Rby9VQXpDREtWY2RmVW9uV3dYV1hkczNpMmJOOTBNSE55SmpsKzlBYUNa?=
 =?utf-8?B?NWgvbk1UZ1ozbHgzNFk2YWd4aTYwcUIzLzRoT0MzSkV3bTYycHppRUVXSkdj?=
 =?utf-8?B?ZHBhTHZ5MTVHZTJmNXh4LzJLU1BjdkxIQlVYeElNQ2xLVWdyOWdrVzR5U2ZX?=
 =?utf-8?B?RU54QU5IcGNJZTA5VzdLRkZoOE5LOFArN1RFRys3RzFHR0ZDT2Y5elRNY3Nx?=
 =?utf-8?B?bFZWTmswNVpEUVU4alpxVzlyNE9FWUh2Y0ZJZG9qZ3hmczFPb1l4ZlV1RTNP?=
 =?utf-8?B?UE10bkdGSXFvakk2a0tBT05LcjE3Y2pURjNVbTIvR1k2dTJkRWVqZk1CN1hO?=
 =?utf-8?B?RnVudW9LQ2ZFd3JDazh2M2xQeGN2Z3B2NHVHQjI2WkQ0OWs0SEVlKzIvZWJX?=
 =?utf-8?B?RVhqL2ZiN1FGdFQ4NzBvdHlmc0gvZGQwd0hZd2xUV1VBYmhaWU1Uc3ZmYXUr?=
 =?utf-8?B?ZEFnajJKTUk4V3p0SURraTNURWU4MzRuQTAwZ2ZFQnhNdUhyeUJoKzJZRDZH?=
 =?utf-8?B?UldkZlErS28zQzhualZ4YldTb0tjbFJqa0lsQUp5d1hJL2lpaUFXZ1BHUFRt?=
 =?utf-8?B?Nlpjdnl6ZjZKYkRreEppb1ZNT3crMVhYL09ySFpJdEhTWW1TV2JOZmdqVFd3?=
 =?utf-8?B?TDBhSWJVd2J0ai9ld1ZDTll0eVNQUnhkZDVScEl5N2ZlWldsemVYUDYzNlNV?=
 =?utf-8?B?R3pYdzgraWFnek5vUFNRKzJtdXN1NDhWc2xPaWs0MFdoYmtlQWZzSm9CYlhO?=
 =?utf-8?B?a0VVak1QVHpJTEdwY0ZiZ0p3NUNaYktVc1QyWnBSMVVCVHMvc1RhL3Y2RUJJ?=
 =?utf-8?B?L0VoT3ZKM05qZXdEamk1anhyancxV09ya0Y0NEdINXJiT2FtcXcxL3IvTWRm?=
 =?utf-8?B?ZnV2OWVXYlNiOXhZVWNIeXBxMzVrekV0TldyRzdYNkw0NC8rUENnSElqYmpM?=
 =?utf-8?B?V1RpTGZYSlh4SW0zMEgrNXNaejdmbUw4cUJVazhVS1lBSU55a3VEcVBBckls?=
 =?utf-8?B?U0F1ZDVsOUFSWDJHNWZiTlhkUTRKbnNlbGtld1FzTnFoTmtIb1c0NEE3MmVw?=
 =?utf-8?B?WnFMS0Y2QVVoYkQwcTJWZ212K3E3WWlXZVUvc0N2ZUJDWUE4Z0VsTStzdlcy?=
 =?utf-8?B?cUFNWG1VSGwzcjJ5R2oxNHJGZll1aHpqSVA1K3dVbXdkMzJxemR4bTJOYncx?=
 =?utf-8?B?RGZDMGhINkVrTnYrOWllVEhFeWhQajZTS1VGZFhyZlBMNVllNDF5OEIydFhm?=
 =?utf-8?B?M1JqNCtKZVM3VHlDMHdiZGpONXF0WGZQaEV6b3MvYm5hQUNWSVM1VmovVHJj?=
 =?utf-8?B?d0YzS0ZxekVOT3FvdXZ4RWdJcUk3U0pTeElZY0o4eXNROGFNUHBkWS94RS9G?=
 =?utf-8?B?WnRlUDI3Z3FuelYwWWFranVYcGVpeVFLUjRxT1FBNWNTbkFiMjNxR2l6VUNy?=
 =?utf-8?B?Z1BaTTdDWTV5M1NiclBDT1lsSVFSK1lzM0dKTFFEZG1VakVnU3NBL2NibXFM?=
 =?utf-8?B?SERvSURZcHJLQmY3MXl4WTdnSG9oMldoUUNPT1dsWmJ4V3BSdlFVYnBwd2oz?=
 =?utf-8?B?NlBRQ3lodG9BazVjRFRjWG53eVhwNmFJYmN4aCsvMXRCMjZicEFhMS9GbW4x?=
 =?utf-8?B?dTYwSEJudXFNNVNXbWdJcVNZNTY5aFE3dlE1bmZSRzJQU0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXFvZm1yeFE4YU1yV2xtaTNTMEVVS1BpMG5PQ1Z2cVBzTWhYaUYySGxNSy9o?=
 =?utf-8?B?UkxZd2dzWUt3ZExud0wrS0FCaS96THVCcDdqeXZqMk41TzduckN6a245emY0?=
 =?utf-8?B?T0pMNy92VmhabzVRUWZkWEZiV3pJaTJ3eXVRWHJEa1hHRU9YZE83VGIvcm44?=
 =?utf-8?B?ZWhwZ3o4VU4vVmVHcUF5YWNzYkthT0x1d1FaZDlLUk92RmxXREJQT3MyU21C?=
 =?utf-8?B?Uk5Ba3JXMmdCZ1BJZUxmZWU2b3JqaDBRNG9jeTh5YnMyYUVBdHZ4dlFVSlU2?=
 =?utf-8?B?bVhKNEZJY1MwSnlqSFdSTE5lUXo3aEZ2MXdZcyt3REV1QkpLMWNpRWRlbkxs?=
 =?utf-8?B?Ri9mYzdSWjhzUGRtVldoZEJYcWVZbEd0NnNwLysweXhoaVpzM2JFZGdXSVZO?=
 =?utf-8?B?dzdQZlA0WFRVakVpN3BZSm9uNFBHeEJ4bHBEVW1NWnQveWlqS0YxTEwvZWtx?=
 =?utf-8?B?WjVFZ0lJNVpyOU1hUmJtK0szL2hQV1pMV3RFSnZ0bWlreDFhNXR6MUxxZVdI?=
 =?utf-8?B?NHdrRGhaOFh0bEZHRXR4ZFVjVFcxRGVMTWJURDZkazg2eGFNZHpjUDNQb29q?=
 =?utf-8?B?bjNuU0RCNW9hSkwyQ3lPR2diL0ZmaW5JNk1tQmtxeElWaDFJdU1iVkhnRzht?=
 =?utf-8?B?QXozRWlnbG42dXRKUmh5K21QRGJwazZXNWk0UTg4aVdpb1ZJZVRocDRRUzhY?=
 =?utf-8?B?cEc2d1Z3NCtWc21FRllUR2lYZ3FRSGU2WktsVzdGbHM0NVBGbzR0NlJ1TG5Q?=
 =?utf-8?B?TU1vblg3dlkzNitBb3h1SmpzN1I5dlRoQm5CLzM3cnpFZWZvelUrWG53MFN1?=
 =?utf-8?B?ZUFKZXpPc09Wc0pPOXJiZHIxUWRlRzNoaTZ6NHIvMkRsUkhndzJHNTNudkw5?=
 =?utf-8?B?cTRFb2NETGw0TzdUdHozU1FtaDBqVC8wb3VVbXVxTHZ3Njlpd0d0VkJqcXBz?=
 =?utf-8?B?TTRGMHBkZkNMeWRZQ000SzdZZ2dNbElwOWNoU3Rnb3pCUUprOW1YUWZwc1ZF?=
 =?utf-8?B?S1Z3aUpzRVZ2Y1Y2Q2x3OW1MYlNmMWdyVWFRUjB4RVlqQTg2L2lGQnF2VjV0?=
 =?utf-8?B?VVczek5ockwrQUxsb21FbEswRnV0bTUzcG9oZ0xTaFk3dXBidkNWenZQODF2?=
 =?utf-8?B?bUU3MktmZHFUQTJiU2NlNldvZHNienpUakJpMk1oNE52QW1QRmdxbzJaMERp?=
 =?utf-8?B?QjNWR09jZWRpRWFJVDRicEZtRE9NV1MwWU5nb2NDcFVLRGFEK2xxZDdoWngv?=
 =?utf-8?B?SWVUS25jL2p4RFF5ZU05N0JqUjZsWVlXY1RRL05sdCszWlFuLzZaY3BxV0F4?=
 =?utf-8?B?QU0xbmx5bTFlNy9wNnZqMmxjVzNaaFM2Q21RTVFVWVhXUmJZR1FFSE9RdldJ?=
 =?utf-8?B?M2lVMWpTRnJnTXdBK25SdnhFRXVNdk5MRzFlSEJDQ1ZOQ2M0WXBNakZhTmlq?=
 =?utf-8?B?NDlJeFF1c1huWlBveDFLS2M2R3d4ajNDMXJXQ3pYOHR4UWhROGhuK0pFM1U3?=
 =?utf-8?B?dHoxUEMrL0NWTWh1WXh2VDJtTXNGRUtzc2RUcHBGMHVjZkppWUo3NVNzYTNZ?=
 =?utf-8?B?QlBUREF6bys5VHN6dlp5bEZ5NXBBSXBUL1VMRGZRalRSdVlQQmVFVmM5akl2?=
 =?utf-8?B?eUVmdHZ1M0FtSDJ0K2lNUzlNTXNjL2dWS2Z5L0JnYlhHWlN5UkRWZXU2dm1F?=
 =?utf-8?B?YkVCcjdmcFdVWHg0dWMrUGp1NDRVSzloUm5HQWJXSVJuTE5TQzlPUHNuODZ5?=
 =?utf-8?B?K0lhTjUvV0VkT04xK25Wd0t3ZEZWc0trVEZOY1VjRjV0cVdqQ0NLT3FqQU5z?=
 =?utf-8?B?djExcTFPYlorQ3NQelBBdVJsNFNBN2NzMkcwUi9SemFtS1l5dWFRck43TkNH?=
 =?utf-8?B?M0tFSElUb1N5bnBSRHhxUFlrRWNwM1VqS3F4QitYblB6bHZKMDUwM1pUMkZS?=
 =?utf-8?B?amJ5c2l6YmFrRXZ1aVZ6QTNzQkNWMGNEZ0hSWWc2SWliQ3JlSFhpaGdCRWFV?=
 =?utf-8?B?U0RJRjhobTBEWFgyelVCdExVcHN6cUFvZlRFeldpVkNXT0lndzYwb256OFZi?=
 =?utf-8?B?K0diNG5jekJKZ29IL1JrbjFEY0JpTE5mZ21KVW9wTzgxbExUQVZmam55Wktr?=
 =?utf-8?Q?AbXE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f02a2ad8-aaca-4d9e-3121-08dcdd2b6adf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 06:29:32.6040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCfsJBWzVw6fyPIL9bAkKlQwnXBjQHT9iN3XKtjJ9pqxb+gwkxP9h4BFbk9iJ2hmpH/x/uhfuUjhBFxFUyPucg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6936

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KPj4gPj4gRnJvbTogTGlhbnFpbiBIdSA8
aHVsaWFucWluQHZpdm8uY29tPg0KPj4gPj4gDQo+PiA+PiBDb25zaWRlcmluZyB0aGF0IGluIHNv
bWUgZXh0cmVtZSBjYXNlcywgd2hlbiB0aGUgdW5iaW5kIG9wZXJhdGlvbiANCj4+ID4+IGlzIGJl
aW5nIGV4ZWN1dGVkLCBnc2VyaWFsX2Rpc2Nvbm5lY3QgaGFzIGFscmVhZHkgY2xlYXJlZCANCj4+
ID4+IGdzZXItPmlvcG9ydCwgdHJpZ2dlcmluZyBhIGdhZGdldCByZWNvbmZpZ3VyYXRpb24gYXQg
dGhpcyB0aW1lIGFuZCANCj4+ID4+IGdzX3JlYWRfY29tcGxldGUgZ2V0cyBjYWxsZWQgYWZ0ZXJ3
YXJkcywgd2hpY2ggcmVzdWx0cyBpbiBhY2Nlc3NpbmcgDQo+PiA+PiBudWxsIHBvaW50ZXIsIGFk
ZCBhIG51bGwgcG9pbnRlciBjaGVjayB0byBwcmV2ZW50IHRoaXMgc2l0dWF0aW9uLg0KPj4gPj4g
DQo+PiA+PiBBZGRlZCBhIHN0YXRpYyBzcGlubG9jayB0byBwcmV2ZW50IGdzZXItPmlvcG9ydCBm
cm9tIGJlY29taW5nIG51bGwgDQo+PiA+PiBhZnRlciB0aGUgbmV3bHkgYWRkZWQgY2hlY2suDQo+
PiANCj4+ID5JbiBsb29raW5nIGF0IHRoaXMgZnVydGhlciwgc2hvdWxkbid0IHdlIGp1c3QgYmUg
bW92aW5nIGFyb3VuZCB3aGVyZSB3ZSBjYWxsIHVzYl9lcF9kaXNhYmxlKCkgaW4gZ3NlcmlhbF9k
aXNjb25uZWN0KCk/DQo+PiANCj4+ID5DYW4ndCB3ZSBzaHV0IGRvd24gdGhlIGVuZHBvaW50cyBf
QkVGT1JFXyB3ZSBzZXQgdGhlIHBvcnQgc3RydWN0dXJlcyB0byBOVUxMPyAgQWZ0ZXIgdGhlIGVu
ZHBvaW50cyBhcmUgc3RvcHBlZCwgdGhlbiB3ZSBrbm93IHRoYXQgdGhlcmUgaXMgbm8gb3V0c3Rh
bmRpbmcgaS9vIHBvc3NpYmxlIGFuZCB0aGVuIHdlIGNhbiBjbGVhbiB1cCBwcm9wZXJseT8NCj4+
IA0KPj4+ID5Ob3QgdG8gc2F5IHRoYXQgeW91ciBjaGFuZ2UgZG9lc24ndCBmaXggdGhlIHJhY2Ug
Y29uZGl0aW9uIGhlcmUsIGJ1dCBjbGVhbmluZyB1cCB0aGluZ3MgaW4gdGhlIHByb3BlciBvcmRl
ciBtaWdodCBiZSB0aGUgYmV0dGVyIHdheSBhcyB0aGVuIHRoZXJlIGNhbiBub3QgYmUgYW55IHJh
Y2UgY29uZGl0aW9ucyBhdCBhbGw/DQo+PiANCj4+ID5IYXZlIHlvdSB0cmllZCB0aGF0Pw0KPj4g
DQo+PiBUaGFuayB5b3UgZm9yIHlvdXIgZ3VpZGFuY2UsIHdlIHN0dWRpZWQgYW5kIHRyaWVkLg0K
DQo+SSdtIGNvbmZ1c2VkLCB5b3UgdHJpZWQgd2hhdCBhbmQgd2hhdCBoYXBwZW5lZD8NCkFmdGVy
IHRoaXMgbW9kaWZpY2F0aW9uLCBvdXIgc3RyZXNzIHRlc3QgcHJvYmxlbSBubyBsb25nZXIgcmVj
dXJzLiggSSdtIHNvcnJ5IGZvciB0YWtpbmcgc28gbG9uZyB0byByZXBseS4gVGhlcmUgaGF2ZSBi
ZWVuIG1hbnkgdXJnZW50IGlzc3VlcyBpbiB0aGUgcHJvamVjdCByZWNlbnRseSBhbmQgSSBoYXZl
IGludmVzdGVkIGEgbG90IG9mIHRpbWUgdG8gc3VwcG9ydCBwcm9qZWN0IGlzc3Vlcy4pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyBiL2RyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQppbmRleCBiMzk0MTA1ZTU1ZDYuLjE3
MTJlOWNkMDhiZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3Nl
cmlhbC5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KQEAg
LTEzOTUsNiArMTM5NSwxMCBAQCB2b2lkIGdzZXJpYWxfZGlzY29ubmVjdChzdHJ1Y3QgZ3Nlcmlh
bCAqZ3NlcikNCiAJLyogUkVWSVNJVCBhcyBhYm92ZTogaG93IGJlc3QgdG8gdHJhY2sgdGhpcz8g
Ki8NCiAJcG9ydC0+cG9ydF9saW5lX2NvZGluZyA9IGdzZXItPnBvcnRfbGluZV9jb2Rpbmc7DQog
DQorCS8qIGRpc2FibGUgZW5kcG9pbnRzLCBhYm9ydGluZyBkb3duIGFueSBhY3RpdmUgSS9PICov
DQorCXVzYl9lcF9kaXNhYmxlKGdzZXItPm91dCk7DQorCXVzYl9lcF9kaXNhYmxlKGdzZXItPmlu
KTsNCisNCiAJcG9ydC0+cG9ydF91c2IgPSBOVUxMOw0KIAlnc2VyLT5pb3BvcnQgPSBOVUxMOw0K
IAlpZiAocG9ydC0+cG9ydC5jb3VudCA+IDApIHsNCkBAIC0xNDA2LDEwICsxNDEwLDYgQEAgdm9p
ZCBnc2VyaWFsX2Rpc2Nvbm5lY3Qoc3RydWN0IGdzZXJpYWwgKmdzZXIpDQogCXNwaW5fdW5sb2Nr
KCZwb3J0LT5wb3J0X2xvY2spOw0KIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZzZXJpYWxfcG9y
dF9sb2NrLCBmbGFncyk7DQogDQotCS8qIGRpc2FibGUgZW5kcG9pbnRzLCBhYm9ydGluZyBkb3du
IGFueSBhY3RpdmUgSS9PICovDQotCXVzYl9lcF9kaXNhYmxlKGdzZXItPm91dCk7DQotCXVzYl9l
cF9kaXNhYmxlKGdzZXItPmluKTsNCi0NCiAJLyogZmluYWxseSwgZnJlZSBhbnkgdW51c2VkL3Vu
dXNhYmxlIEkvTyBidWZmZXJzICovDQogCXNwaW5fbG9ja19pcnFzYXZlKCZwb3J0LT5wb3J0X2xv
Y2ssIGZsYWdzKTsNCiAJaWYgKHBvcnQtPnBvcnQuY291bnQgPT0gMCkNCg0KVGhhbmtzDQo=

