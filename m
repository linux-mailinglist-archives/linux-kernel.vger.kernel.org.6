Return-Path: <linux-kernel+bounces-515381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C5A3642B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA46E3A6D92
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E66D268686;
	Fri, 14 Feb 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="PYo6bfhS"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F64F267B1F;
	Fri, 14 Feb 2025 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553229; cv=fail; b=YA17eyOEwMs4KOWsPLxYISOhBwW0TJ0JMLCrj94VSE5t4JhsPvAyDdEs4xZlc3n1Z1ajJfYErln3xL8Bu1ZBL4+CjELpe8CRbqQ8lH+keXKTEojpeU59mbKxcoqfTP2/h93r8aSwhzVts5C7MYN84JdbteGILIMTdB3vfK7uMjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553229; c=relaxed/simple;
	bh=EEh+Av4WaYemz7uBdqrkPaVaFSBe9MSbJOEFNnCOreU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S95BA3JHUl0rQikVHgcJ4rMMwozTexcvT7aARubZ4OLTnGorzg7PRA0iz+97Cf78fcLkvVJKfJAmZROOwtZifmmiTh4FKMnxdxig5C1MblSYvwqZ5zU97m//pkoYgrru/yFkt6Tjubx/IRFNXtMM0lIrdH3GIeAj5JuA9S1TGDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=PYo6bfhS; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EAO4M0021523;
	Fri, 14 Feb 2025 09:13:32 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44t41n8nng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 09:13:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fc3KQEGayFFQcmPPTCsha71xcpw8FpgUefW82O5vaCvO0YDkPLL48kWb/DEe655VskbusAki0AbWgIsQD6cp11v6Gyitwn76LBn3cYNcnYqJw9tQL2XBLc2qaz4uW+wA1q0ZMrhT9amJkufdgWnF8xXWG2/GYlBOL8tm4kfWu6mXXp4uEWHi9Fpj5mdeyvFI4ZET7Wo+BGvwWdBImOGc1agl2Zb+8AzPmJER6dD+8sm2EKZoXTh3p+xkLe5MmFQ2SThGC2oMxLfzP2PG1Z6hFVzDxNUN/o7SfKdM3GkQy+WQjg+6KRl7Luf95aQcs8Pxolq9h//rZyqplsiP9CCjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEh+Av4WaYemz7uBdqrkPaVaFSBe9MSbJOEFNnCOreU=;
 b=Gv1QJd6knWERMUlj6sduOKCbql6iihbLQu85NJrrnK3W2cebsmkM3U0FQw3z4kbZYTw/gUhZqThW722q1eUly/RXBfSsaxABUYpVIKBxtXi3HqdDJ0DQZsEPC857ZbLQty9ychW07YZ4I+1yb878pudzyHMcigBjmAcyBcgI8ypSxhlEfXTgJ2VfBkI8mGEmgC7ZME94i9Fzzd9NubFh3ShMXliD7dzQ3GnwFQCnhWyCU85VWRRyl7jnwSC+liXHx6WY2acUQBrkKdtY7iukDRLIgBgavrqaaTPt973dkUwwIZ1IDM37wU+x7cdsud5dGMzcFZfrGRyIp7VgfRT4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEh+Av4WaYemz7uBdqrkPaVaFSBe9MSbJOEFNnCOreU=;
 b=PYo6bfhS6vd5FY29abXL9yQLTZd3FNiJZfZ0FHOt11/KqpE6SSr0ahKmhOBBFZlb8cidCgd9j/IO1nvsgBSBZsgWewSGCp4G9aZqkvAYmMdGqQ1V4FE0wL2VfKljJ7JL92tcpgdzhFK7OY9Zdht6o2ZUd6WR0L1bIOLMLi3qTUc=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by MW5PR18MB5093.namprd18.prod.outlook.com (2603:10b6:303:1a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 17:13:30 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%4]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 17:13:30 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com"
	<gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com"
	<sebastian.hesselbarth@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        Sanghoon Lee <salee@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>
Subject: Re: [PATCH 1/4] [PATCH 1/4] reset: simple: Add syscon device
 compatible
Thread-Topic: [PATCH 1/4] [PATCH 1/4] reset: simple: Add syscon device
 compatible
Thread-Index: AQHbfwPEpItv2FmWXku+E0ei6VxORw==
Date: Fri, 14 Feb 2025 17:13:30 +0000
Message-ID:
 <BY3PR18MB4673C5C5CA684C64B2C218AAA7FE2@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20250214065833.530276-1-dingwei@marvell.com>
	 <20250214065833.530276-3-dingwei@marvell.com>
 <6dd9ed2750abe1f5174805673411ccb919ee5461.camel@pengutronix.de>
In-Reply-To: <6dd9ed2750abe1f5174805673411ccb919ee5461.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|MW5PR18MB5093:EE_
x-ms-office365-filtering-correlation-id: c9d24bec-b92d-46e0-31c6-08dd4d1ae753
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3NZdDhTRnAxdUptcFdUZlRWaGZvQjcrUVExVTMyYXV3ajZHcUxGaS9STE1t?=
 =?utf-8?B?cXhuamVQeGQ1TnE4dXhob0J5NVFTbXcybzRraEh3dVhKMU1KajIydGF1K1VL?=
 =?utf-8?B?ZWpJVFYwc3V0bmRhUGY0dlV4aTNMeU84elVIRHlBN0xWamxMSTRxMFRpZTNx?=
 =?utf-8?B?cTJxcHpyMG5sYmNwYU90cjhuMCtJL0IvUjQ4NVB1OHc5MDJzOXRId0NMRUp4?=
 =?utf-8?B?QXlwY2lrc0VqbU5MM1ZEemVZeVNpZ3VJcEQrUFB4YkNpOTNQcWlHTXdvS2px?=
 =?utf-8?B?dHBuVGdKQWNiTStHczBTNzhCWkFGQ3ZKdFlDNzRVd0dxUmo4T0kxMXArU3M5?=
 =?utf-8?B?UitwUU9YR2ZXd0ZJdmNLbjhyamhScGZOWVZpc2JrckRQdm9aeVJmL3hYS01G?=
 =?utf-8?B?YUs4ZXBoREFWWnczY3BsZDNCMjJ0OHgvRFUzZjAraUZnUHJDWHEzVnFnd2NU?=
 =?utf-8?B?aFBkNFRtVlVTQldoMUF6VnRvazdES091aGU4Z2xpbHBtV0d4TUdCTzVzQVFk?=
 =?utf-8?B?Z0x3MytMeXVPRVc0d1NLVXVtdEFONTFnZkFyQU1leTZESzNHWmZSOTZ2RFBC?=
 =?utf-8?B?OXRYRE5vVkM1OHU3ZGJ6eHVaWERRMS9MMklNVDh4bmxZMVB3WkRvMG4zUExS?=
 =?utf-8?B?NFJIS1c0Y21QZkhLMEQ1MFlicGt2ZGJXSmZBb3NVSFpWZktlbkVHby9reHJS?=
 =?utf-8?B?Ry9nWGhYMkZxVU53b2l2Yyt1Y2pRUmMwMDdvS1FIRXVFeGM0Zk5zMmZZVVdC?=
 =?utf-8?B?MEtNMVNqMDNFb0gzQk9mcUVJSE5iY0pMaWRWYU8vdjVaVmJrVzhlVXlmZStJ?=
 =?utf-8?B?VmY0WWJiUHlJVVNqai9tWktvTkgxVHV0cTliRUwvN0daR0c2eCsyS2YzeVV3?=
 =?utf-8?B?cE8xdEIyWnZtMlBiK3RiUXFVLzBkSDFoN0VObVNibjQ1ZU9iK1hRZXFuNnZV?=
 =?utf-8?B?Qi9wQWN2SmFyNDBmNnV2azEwa2VZamExcm9wR3hqM2hSOTJHWFArM056U3Zo?=
 =?utf-8?B?b1JIMklxSzBOYnJseVJrVFFDYng5U1AzcHEzVzlSK3UzR041T1c2aG12SzVk?=
 =?utf-8?B?N3lEektSRlVPbXFFY3JKUDFmM0pzTkx2bTdGWmFDVW83UCtNT3l6TzRUUWYv?=
 =?utf-8?B?Ulg2dXUzd3FyRlJoMmg3cndIQTBSR2N0bjQrRk82dnBkdHRoN01acVdWSFhY?=
 =?utf-8?B?Ui93ODZRQ3VidXRpL2IwNFdUK29TVnJzYm45OURPYkVWeklQekJ0UlhzU0cx?=
 =?utf-8?B?NU5Md0dmK3RiajdnelFYcXpLK0VKWHRGK2NQZTUwbDdRSkoyVzVNc3Q0bE1B?=
 =?utf-8?B?WHcwMXkwZEh4Z3Y2MlRubkI0S2JteENJckVpMDV4ak9pa1FsNGR1L08zOXFx?=
 =?utf-8?B?bnNEa0haWU40bjVpSW15WjZXZEpDY2kreHZteHNkVGErbGE3Q2JCUitpVUxl?=
 =?utf-8?B?RlhNcElLRVR2WTkwOGNNSXhxOWxLWTNZZTN4cUNhVHA3MDE0bDZpd3kyV2ZP?=
 =?utf-8?B?ZFdVRzdZWWpNWGNEZGlJYXZWQ05iTCttanlqMjVZU1ZsQlNkODZBRUNNSUR4?=
 =?utf-8?B?THV2WkR1QmhuUmVTcHNCS0VjR25zRXh4YzJ3cmhmZC9rdnQvZitteXpqanBF?=
 =?utf-8?B?VDNHeEdncUNUT29qYkJZcjZJeVZvUXlHdG5hZFdqTnlLTXNvUWNhTGNQL1l2?=
 =?utf-8?B?bVloNkFuWTF5V3NUdm5QN2dNcElEclZxTmpIV2lsSGIyRjNJY3hSaGJJeVcz?=
 =?utf-8?B?NGxmNXE5RXZMMTBmTk5XSXV0Zmp3OWptd21RME1VWStITGRxa29XemRwSlhD?=
 =?utf-8?B?YkNPbnpEditoaWREK2Y4N3Z4bDhGaVVVMVBNTXVleWdCa2o2OEpLZlBaZDc3?=
 =?utf-8?B?TkhxaHhJWG5iMlhrYy9qQWlYUEIyZzA2MWFYOWIyOUxqeFk0a1FsTWI1UzJF?=
 =?utf-8?Q?tyRJhjXj8iywZU4CKOkW/62rO/gYBQ6Y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHlNSmYrMHU0cWl6enlaakl6Z1lBc0JhU2VEL3lFbTZ3ZlNKM3VzZlg0Vmpt?=
 =?utf-8?B?NTdIVWlMdkxNemZtTDZ3bjY2c01yTndDNGlGcFJXdWUrZzRhaDBReDBQcjdL?=
 =?utf-8?B?K0Nob1E4cHF4Rnl3b0h3VC82UGFvbFN0NTU1V3RXTGtSd1paM2FGbUJodGpG?=
 =?utf-8?B?V1pKM3ZwUm5OcEdYdUtHVCtFMWNlTHd1SFU1ZE1rT0wrKzFJRUNWTE10dTlI?=
 =?utf-8?B?VnZRMFlDRVNyK3o1NDJGMlNlY2tsRE5XdnJhTUN0YVVGWTk1M1VrbjdjdVgx?=
 =?utf-8?B?VU1oQUtic0k5RmN3N1FrVUo0NnErWDljcWcvRTJmVVNMREJhL3l0cHhsNWtV?=
 =?utf-8?B?eWFWUVh3TksrRHR5VStIK1dqaFljKzRKd21RYzZqZk9sb1lWOEM3R1hJeUZm?=
 =?utf-8?B?eTJtcFNwdlZJMTdkYkdYMFdibHpxVUFsVFFFYlQrVmc1aUNxTk4vTGk1SlFa?=
 =?utf-8?B?L2FOOWljRW5XQkNHU3ltbkNhS0VwOGhyK0NNYkRFVmhIay9lTUZXNk01c21u?=
 =?utf-8?B?NXJQWnFWV281aE9UaGdEY2U0Ry9DdEV3NDFCcnlLdkVsOTFiWlQ4WGJ3MlpE?=
 =?utf-8?B?N0s0T051V0pGQm5GRUpxcnhrUEREVHBlL2IzYURwOTNsQU1ZbzZ1MFRka0hU?=
 =?utf-8?B?K2w5a2tSUGF4K0M3bkJreWZlenhaSzFmK3ZRemQ1Y3c0TVVha20zNW1FWk9U?=
 =?utf-8?B?cjNkMFFIWktpWkVwNDI1YWFXZHd4cWpCQ2hzSElrWFp1ZktFdi9Sc1NQWHk1?=
 =?utf-8?B?WWhyZ0drdXNOWnc4c0pKWEhTODZCc2VHTjdNeGkrMTI2SmZreVRUK0ZtSFFZ?=
 =?utf-8?B?QnVnZ3p5SVp2dmdKYTJCTmZ6RDJ5cjR0VmhObzF1TVZuVFZLeUhydkN0WGtq?=
 =?utf-8?B?V09vSVpJS3l2QXEreW9XWld0d0c5V3p4TENxTGhUODA0Mkt3YTM1WDhJVm81?=
 =?utf-8?B?UUdmSFI2V3U2MFJ6cElVc29hU0RGS1g5MlZTYWhNSFNMQithUU44WUxmOTZU?=
 =?utf-8?B?b3hLQkl0c0dybnNQeTZCUklIZDJIc1Y3ekdsZTRROTBqZG1VZmRZRTJlR3l3?=
 =?utf-8?B?VXBaYXBqOFJEQkZ6QlRjMkRaN0VqeHphRnc3M2lvT1hEL1hTSzlmUlZuNzg1?=
 =?utf-8?B?U09GNlV0VDFLbmo0Z0MwcExmbStxbis1TURrQjV5RzNzQU13UUQvWXhGaHl0?=
 =?utf-8?B?bVJROGFQd2F5SnpzdFBjTW5TVytQeGd1L1BPdHJiNGFZZWJqZ1JhTEgrTjV2?=
 =?utf-8?B?QmdpN2ZGaXBkdElPM0pINkg5YW9ndkFSaU1YcnpVcDJ2SVgvZ05YVFBwOHdm?=
 =?utf-8?B?MFNoRjFjdjhWb0hoalNlcGVGSGtxRWhQb3h5czhyQjdrYWI5QmN6azZXekhh?=
 =?utf-8?B?aHhoUGYwYzNpM2RLdmh1WGJvaEUxQmx3ckR3U3cvcUh1QVBvVGwxSzFxbFBX?=
 =?utf-8?B?dnpPMEh6R3dVQW1RUGMwbGgyWno5L3J1Y0FMVmlaVXpxazQ5QjhTWGQ4THZz?=
 =?utf-8?B?TzdkT1MvMWl1bk1EWEFvbWlUUnpmd3RXTXdHS2VpVVUzUEpzaTRtTUJTalJV?=
 =?utf-8?B?aFdNcm9EeHpMZXdjeUhnd2UxL2hGb3RkQ3BZbUZ5emU1ZktXRFd3MFlPcmpW?=
 =?utf-8?B?TkxkdzArZ0wveUVKUW9Hd2ZiYTNubzRFcUNvVEM5NDdVVkNBZDUzU0RCc3lp?=
 =?utf-8?B?L09vYm93WldGcE56RkpYVXllcURqQjIxOHI2ZEFZMEx4bUVNZDhYK2tUcUtX?=
 =?utf-8?B?azFyVldYTWZIQS9KZ3crdU8rRE5VWitiTWtpVlkxWUhhc1Q5TVBBQzBPTlJw?=
 =?utf-8?B?dld3ZnpESFl3elMxK0pqd1cwbUowWDVtZE14d3hncmd1eVYvWnpWLzdnalAz?=
 =?utf-8?B?dk1PZEJUUjQ2OW44a2VSMzJrTUxGdkgraEJvZDdhdmpQZndqd3dmb3RQc0d2?=
 =?utf-8?B?N3Q0QjFnQ3lFZzk2VHMxNDVzR1Z5NGo0TmVkUHViRkJZUDgxWVNxeUpraVdu?=
 =?utf-8?B?aGNhTGxkSGdvOHJIM3JiVkhka1VObnNLaDJlTXRQMWE0UEt5NmNpK0NScVlu?=
 =?utf-8?B?anNrbmZNTHpKTmVQNms2aFh0TGJQcUdOVEx6MkpvRVQyK1FHREY1SjVWakVG?=
 =?utf-8?B?czI5azZadGpUQ0RBaUFCK0VrUXR3WkM2aWdXZmlJS05NUTlSVENHclNQTHBv?=
 =?utf-8?Q?0C0+CvX/wHBAp2Dj0k/ZeWt4iKW+2FsHn083e339iGGY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d24bec-b92d-46e0-31c6-08dd4d1ae753
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 17:13:30.1902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLwG5J2iyDJMtOmhH62Lvn0epfkMrYihGsoj+YcAytZkDMwZ6ak6TQMEHRJXg+ZrbV5Ysmg++AqGXEHsWD0Gtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5093
X-Proofpoint-GUID: GK816YM4_COEWcsCCFXJkZZZkadPdL5E
X-Proofpoint-ORIG-GUID: GK816YM4_COEWcsCCFXJkZZZkadPdL5E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_07,2025-02-13_01,2024-11-22_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcCBaYWJlbCA8
cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAxNCwgMjAy
NSAzOjU0IEFNDQo+IFRvOiBXaWxzb24gRGluZyA8ZGluZ3dlaUBtYXJ2ZWxsLmNvbT47IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGFuZHJld0BsdW5uLmNo
OyBncmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb207DQo+IHNlYmFzdGlhbi5oZXNzZWxiYXJ0aEBn
bWFpbC5jb207IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPiBjb25vcitk
dEBrZXJuZWwub3JnOyBTYW5naG9vbiBMZWUgPHNhbGVlQG1hcnZlbGwuY29tPjsgR2VldGhhc293
amFueWENCj4gQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj4gU3ViamVjdDogW0VYVEVSTkFM
XSBSZTogW1BBVENIIDEvNF0gW1BBVENIIDEvNF0gcmVzZXQ6IHNpbXBsZTogQWRkIHN5c2Nvbg0K
PiBkZXZpY2UgY29tcGF0aWJsZQ0KPiANCj4gT24gRG8sIDIwMjUtMDItMTMgYXQgMjI6NTggLTA4
MDAsIFdpbHNvbiBEaW5nIHdyb3RlOg0KPiA+IEludHJvZHVjZSB0aGUgbmV3IG9wcyBmb3IgdXBk
YXRpbmcgcmVzZXQgbGluZSBhbmQgZ2V0dGluZyBzdGF0dXMuDQo+ID4gVGh1cywgdGhlIHJlc2V0
IGNvbnRyb2xsZXIgY2FuIGJlIGFjY2Vzc2VkIHRocm91Z2ggZWl0aGVyIGRpcmVjdCBJL08NCj4g
PiBvciByZWdtYXAgaW50ZXJmYWNlcy4NCj4gDQo+IFBsZWFzZSBkb24ndCBhZGQgYSBuZXcgbGF5
ZXIgb2YgZnVuY3Rpb24gcG9pbnRlciBpbmRpcmVjdGlvbiwganVzdCBhZGQgYSBuZXcNCj4gc3Ry
dWN0IHJlc2V0X2NvbnRyb2xfb3BzIGZvciB0aGUgcmVnbWFwIHZhcmlhbnQuDQo+IA0KDQpJZiBq
dXN0IGFkZGluZyBhIG5ldyBzdHJ1Y3QgcmVzZXRfY29udHJvbF9vcHMgZm9yIHRoZSByZWdtYXAg
dmFyaWFudCwgYWxtb3N0DQphbGwgdGhlIGZ1bmN0aW9ucyB3aWxsIGJlIGR1cGxpY2F0ZWQgZm9y
IHJlZ21hcCB2YXJpYW50LiANCkJlc2lkZXMgcmVzZXRfc2ltcGxlX3JlZ21hcF9hc3NlcnQvZGVh
c3NlcnQoKSwgd2UgYWxzbyBuZWVkIHRvIGhhdmUgdGhlDQpyZWdtYXAgdmVyc2lvbiBvZiByZXNl
dF9zaW1wbGVfdXBkYXRlKCkuIFNpbmNlIHJlc2V0X3NpbXBsZV9yZXNldCgpIGludm9rZXMNCnJl
c2V0X3NpbXBsZV9yZWdtYXBfYXNzZXJ0L2RlYXNzZXJ0KCksIGl0IGFsc28gbmVlZHMgdG8gYmUg
ZHVwbGljYXRlZC4NCkluIHRoaXMgY2FzZSwgdGhlcmUgd2lsbCBiZSB0b28gbWFueSByZWR1bmRh
bnQgY29kZXMgaW4gdGhpcyBmaWxlLiBJIGRvdWJ0IGlmDQppdCBpcyB3b3J0aCB0byB1c2UgdGhl
IHJlc2V0IHNpbXBsZSBjb2RlLiBNYXliZSBpdCdzIGJldHRlciB0byBmb3JrIGEgbmV3IGZpbGUN
CmZvciB0aGUgc3lzY29uIGRldmljZSwgc3VjaCBhcyAncmVzZXQtc2ltcGxlLXN5c2Nvbi5jJy4g
V2hhdCBkbyB5b3Ugc2F5Pw0KDQo+ID4gSXQgZW5hYmxlcyB0aGUgc3VwcG9ydCBvZiB0aGUgc3lz
Y29uIGRldmljZXMgd2l0aCB0aGUgc2ltcGxlIHJlc2V0DQo+ID4gY29kZS4gVG8gYWRhcHQgdGhl
IERUIGJpbmRpbmcgb2YgdGhlIHN5c2NvbiBkZXZpY2UsIHRoZSBudW1iZXIgb2YNCj4gPiByZXNl
dCBsaW5lcyBtdXN0IGJlIHNwZWNpZmllZCBpbiBkZXZpY2UgZGF0YS4NCj4gDQo+IElmIHRoZSBE
VCBub2RlIGhhZCBhIHJlZyBwcm9wZXJ0eSwgbnVtYmVyIG9mIHJlc2V0IGxpbmVzIGNvdWxkIGJl
IGRldGVybWluZWQNCj4gZnJvbSBpdHMgc2l6ZSwgbGlrZSBmb3IgTU1JTy4NCj4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogV2lsc29uIERpbmcgPGRpbmd3ZWlAbWFydmVsbC5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvcmVzZXQvcmVzZXQtc2ltcGxlLmMgICAgICAgfCAxMTcgKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9yZXNldC9yZXNldC1zaW1wbGUu
aCB8ICAxMSArKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMDcgaW5zZXJ0aW9ucygrKSwgMjEg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9yZXNldC1z
aW1wbGUuYw0KPiA+IGIvZHJpdmVycy9yZXNldC9yZXNldC1zaW1wbGUuYyBpbmRleCAyNzYwNjc4
Mzk4MzAuLmU0ZTc3N2Q0MGE3OQ0KPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Jlc2V0L3Jl
c2V0LXNpbXBsZS5jDQo+ID4gKysrIGIvZHJpdmVycy9yZXNldC9yZXNldC1zaW1wbGUuYw0KPiA+
IEBAIC0xNSw4ICsxNSwxMCBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9lcnIuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZi5o
Pg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9yZWdtYXAuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3Jlc2V0LWNvbnRyb2xsZXIu
aD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3Jlc2V0L3Jlc2V0LXNpbXBsZS5oPiAgI2luY2x1ZGUg
PGxpbnV4L3NwaW5sb2NrLmg+IEBADQo+ID4gLTI3LDEwICsyOSw5IEBAIHRvX3Jlc2V0X3NpbXBs
ZV9kYXRhKHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYpDQo+ID4gIAlyZXR1cm4g
Y29udGFpbmVyX29mKHJjZGV2LCBzdHJ1Y3QgcmVzZXRfc2ltcGxlX2RhdGEsIHJjZGV2KTsgIH0N
Cj4gPg0KPiA+IC1zdGF0aWMgaW50IHJlc2V0X3NpbXBsZV91cGRhdGUoc3RydWN0IHJlc2V0X2Nv
bnRyb2xsZXJfZGV2ICpyY2RldiwNCj4gPiArc3RhdGljIGludCByZXNldF9zaW1wbGVfdXBkYXRl
X21taW8oc3RydWN0IHJlc2V0X3NpbXBsZV9kYXRhICpkYXRhLA0KPiA+ICAJCQkgICAgICAgdW5z
aWduZWQgbG9uZyBpZCwgYm9vbCBhc3NlcnQpDQo+IA0KPiBObyBuZWVkIHRvIHJlbmFtZSBvciBj
aGFuZ2UgdGhlIGZ1bmN0aW9uIHByb3RvdHlwZS4NCj4gDQo+ID4gIHsNCj4gPiAtCXN0cnVjdCBy
ZXNldF9zaW1wbGVfZGF0YSAqZGF0YSA9IHRvX3Jlc2V0X3NpbXBsZV9kYXRhKHJjZGV2KTsNCj4g
PiAgCWludCByZWdfd2lkdGggPSBzaXplb2YodTMyKTsNCj4gPiAgCWludCBiYW5rID0gaWQgLyAo
cmVnX3dpZHRoICogQklUU19QRVJfQllURSk7DQo+ID4gIAlpbnQgb2Zmc2V0ID0gaWQgJSAocmVn
X3dpZHRoICogQklUU19QRVJfQllURSk7IEBAIC01MSwxNiArNTIsNDANCj4gQEANCj4gPiBzdGF0
aWMgaW50IHJlc2V0X3NpbXBsZV91cGRhdGUoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpy
Y2RldiwNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCByZXNl
dF9zaW1wbGVfdXBkYXRlX3JlZ21hcChzdHJ1Y3QgcmVzZXRfc2ltcGxlX2RhdGEgKmRhdGEsDQo+
ID4gKwkJCQkgICAgICB1bnNpZ25lZCBsb25nIGlkLCBib29sIGFzc2VydCkNCj4gDQo+IEknZCBj
YWxsIHRoaXMgcmVzZXRfc2ltcGxlX3JlZ21hcF91cGRhdGUoKS4NCj4gDQo+ID4gK3sNCj4gPiAr
CWludCByZWdfd2lkdGggPSBzaXplb2YodTMyKTsNCj4gPiArCWludCBiYW5rID0gaWQgLyAocmVn
X3dpZHRoICogQklUU19QRVJfQllURSk7DQo+ID4gKwlpbnQgb2Zmc2V0ID0gaWQgJSAocmVnX3dp
ZHRoICogQklUU19QRVJfQllURSk7DQo+ID4gKwl1MzIgbWFzaywgdmFsOw0KPiA+ICsNCj4gPiAr
CW1hc2sgPSBCSVQob2Zmc2V0KTsNCj4gPiArDQo+ID4gKwlpZiAoYXNzZXJ0IF4gZGF0YS0+YWN0
aXZlX2xvdykNCj4gPiArCQl2YWwgPSBtYXNrOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXZhbCA9IDA7
DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJlZ21hcF93cml0ZV9iaXRzKGRhdGEtPnJlZ21hcCwNCj4g
PiArCQkJCSBkYXRhLT5yZWdfb2Zmc2V0ICsgKGJhbmsgKiByZWdfd2lkdGgpLA0KPiA+ICsJCQkJ
IG1hc2ssIHZhbCk7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgcmVzZXRfc2ltcGxl
X2Fzc2VydChzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPiA+ICAJCQkgICAg
ICAgdW5zaWduZWQgbG9uZyBpZCkNCj4gPiAgew0KPiA+IC0JcmV0dXJuIHJlc2V0X3NpbXBsZV91
cGRhdGUocmNkZXYsIGlkLCB0cnVlKTsNCj4gPiArCXN0cnVjdCByZXNldF9zaW1wbGVfZGF0YSAq
ZGF0YSA9IHRvX3Jlc2V0X3NpbXBsZV9kYXRhKHJjZGV2KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4g
ZGF0YS0+b3BzLnVwZGF0ZShkYXRhLCBpZCwgdHJ1ZSk7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0
aWMgaW50IHJlc2V0X3NpbXBsZV9kZWFzc2VydChzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYg
KnJjZGV2LA0KPiA+ICAJCQkJIHVuc2lnbmVkIGxvbmcgaWQpDQo+ID4gIHsNCj4gPiAtCXJldHVy
biByZXNldF9zaW1wbGVfdXBkYXRlKHJjZGV2LCBpZCwgZmFsc2UpOw0KPiA+ICsJc3RydWN0IHJl
c2V0X3NpbXBsZV9kYXRhICpkYXRhID0gdG9fcmVzZXRfc2ltcGxlX2RhdGEocmNkZXYpOw0KPiA+
ICsNCj4gPiArCXJldHVybiBkYXRhLT5vcHMudXBkYXRlKGRhdGEsIGlkLCBmYWxzZSk7DQo+ID4g
IH0NCj4gDQo+IE5vIG5lZWQgZm9yIGluZGlyZWN0aW9uLiBCZXR0ZXIgdG8ganVzdCBhZGQgc2Vw
YXJhdGUNCj4gcmVzZXRfc2ltcGxlX3JlZ21hcF9hc3NlcnQvZGVhc3NlcnQoKSBmdW5jdGlvbnMu
DQo+IA0KDQpTZWUgbXkgcmVwbHkgdG8gdGhlIGZpcnN0IGNvbW1lbnQuDQoNCj4gPiAgc3RhdGlj
IGludCByZXNldF9zaW1wbGVfcmVzZXQoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2Rl
diwgQEANCj4gPiAtODEsMTAgKzEwNiw5IEBAIHN0YXRpYyBpbnQgcmVzZXRfc2ltcGxlX3Jlc2V0
KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2Rldg0KPiAqcmNkZXYsDQo+ID4gIAlyZXR1cm4gcmVz
ZXRfc2ltcGxlX2RlYXNzZXJ0KHJjZGV2LCBpZCk7ICB9DQo+ID4NCj4gPiAtc3RhdGljIGludCBy
ZXNldF9zaW1wbGVfc3RhdHVzKHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+
ID4gLQkJCSAgICAgICB1bnNpZ25lZCBsb25nIGlkKQ0KPiA+ICtzdGF0aWMgaW50IHJlc2V0X3Np
bXBsZV9zdGF0dXNfbW1pbyhzdHJ1Y3QgcmVzZXRfc2ltcGxlX2RhdGEgKmRhdGEsDQo+ID4gKwkJ
CSAgICAgdW5zaWduZWQgbG9uZyBpZCkNCj4gPiAgew0KPiA+IC0Jc3RydWN0IHJlc2V0X3NpbXBs
ZV9kYXRhICpkYXRhID0gdG9fcmVzZXRfc2ltcGxlX2RhdGEocmNkZXYpOw0KPiA+ICAJaW50IHJl
Z193aWR0aCA9IHNpemVvZih1MzIpOw0KPiA+ICAJaW50IGJhbmsgPSBpZCAvIChyZWdfd2lkdGgg
KiBCSVRTX1BFUl9CWVRFKTsNCj4gPiAgCWludCBvZmZzZXQgPSBpZCAlIChyZWdfd2lkdGggKiBC
SVRTX1BFUl9CWVRFKTsgQEAgLTk1LDYgKzExOSwzMQ0KPiBAQA0KPiA+IHN0YXRpYyBpbnQgcmVz
ZXRfc2ltcGxlX3N0YXR1cyhzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPiA+
ICAJcmV0dXJuICEocmVnICYgQklUKG9mZnNldCkpIF4gIWRhdGEtPnN0YXR1c19hY3RpdmVfbG93
OyAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgcmVzZXRfc2ltcGxlX3N0YXR1c19yZWdtYXAoc3Ry
dWN0IHJlc2V0X3NpbXBsZV9kYXRhICpkYXRhLA0KPiA+ICsJCQkJICAgIHVuc2lnbmVkIGxvbmcg
aWQpDQo+ID4gK3sNCj4gPiArCWludCByZWdfd2lkdGggPSBzaXplb2YodTMyKTsNCj4gPiArCWlu
dCBiYW5rID0gaWQgLyAocmVnX3dpZHRoICogQklUU19QRVJfQllURSk7DQo+ID4gKwlpbnQgb2Zm
c2V0ID0gaWQgJSAocmVnX3dpZHRoICogQklUU19QRVJfQllURSk7DQo+ID4gKwl1MzIgcmVnOw0K
PiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlyZXQgPSByZWdtYXBfcmVhZChkYXRhLT5yZWdt
YXAsIGRhdGEtPnJlZ19vZmZzZXQgKyAoYmFuayAqDQo+IHJlZ193aWR0aCksDQo+ID4gKwkJCSAg
JnJlZyk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJ
cmV0dXJuICEocmVnICYgQklUKG9mZnNldCkpIF4gIWRhdGEtPnN0YXR1c19hY3RpdmVfbG93OyB9
DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHJlc2V0X3NpbXBsZV9zdGF0dXMoc3RydWN0IHJlc2V0
X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCj4gPiArCQkJICAgICAgIHVuc2lnbmVkIGxvbmcgaWQp
DQo+ID4gK3sNCj4gPiArCXN0cnVjdCByZXNldF9zaW1wbGVfZGF0YSAqZGF0YSA9IHRvX3Jlc2V0
X3NpbXBsZV9kYXRhKHJjZGV2KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gZGF0YS0+b3BzLnN0YXR1
cyhkYXRhLCBpZCk7DQo+ID4gK30NCj4gDQo+IFNhbWUgYXMgYWJvdmUsIG5vIG5lZWQgZm9yIGlu
ZGlyZWN0aW9uLg0KPiBKdXN0IGFkZCBzZXBhcmF0ZSByZXNldF9zaW1wbGVfcmVnbWFwX2Fzc2Vy
dC9kZWFzc2VydCgpIGZ1bmN0aW9ucyAuLi4NCj4gDQoNClNlZSBteSByZXBseSB0byB0aGUgZmly
c3QgY29tbWVudC4NCg0KPiA+ICsNCj4gPiAgY29uc3Qgc3RydWN0IHJlc2V0X2NvbnRyb2xfb3Bz
IHJlc2V0X3NpbXBsZV9vcHMgPSB7DQo+ID4gIAkuYXNzZXJ0CQk9IHJlc2V0X3NpbXBsZV9hc3Nl
cnQsDQo+ID4gIAkuZGVhc3NlcnQJPSByZXNldF9zaW1wbGVfZGVhc3NlcnQsDQo+IA0KPiAuLi4g
YW5kIGFkZCBhIGNvbnN0IHN0cnVjdCByZXNldF9jb250cm9sX29wcyByZXNldF9zaW1wbGVfcmVn
bWFwX29wcy4NCj4gDQoNClNlZSBteSByZXBseSB0byB0aGUgZmlyc3QgY29tbWVudC4NCg0KPiBy
ZWdhcmRzDQo+IFBoaWxpcHANCg0KLSBXaWxzb24NCg==

