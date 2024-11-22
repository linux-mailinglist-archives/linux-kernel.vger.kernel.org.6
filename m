Return-Path: <linux-kernel+bounces-418565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9369D62FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74F3B20F60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488F71DF984;
	Fri, 22 Nov 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="piJTHrkZ"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF831DF255
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296224; cv=fail; b=KdpcfYlCSPUYiOdLNWbhoDkms+TtQ5uKy2Vi3A2BUlvYu5nORQFZuOkY+yf+R1nFVGz3a4o4G379uVmljBl9tMwts4KdnXloW1xLYrpnEjQK+QT+nWpeoTI7iH/EovmULOeARACXSJpaGjUGXs/USScyU0WBn8LdxE0bcBj9d+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296224; c=relaxed/simple;
	bh=31SFm3JUXCQje8h6BXLYKKq5DPWIW9iAZhwrqHvA5FA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kUxRJQnUwo1Gua0hchR42ffFCoAg2PhK7Fww5k1rrD59p7Fu626HHt5ClAmPjIWoEpttTBV/rGOg4ubMbTS1SYSh23ZRfBSHKdW4OMpdq8CCsPuCP7OWC7h7+RD8Tr7MWycFkK6gnPLycLJlL25QRAui+sDpu/P42CzYfrnOGcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=piJTHrkZ; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Za5PmclBy13a7PgeDhTdOtqqRodz6TBTLU2SgjVfa1jgogDuJZRo/qV/N75incvFW+yUZAwksVkoech2krQ0gcFUuUPnbgM4BfvHGRAJuNY5Wbh31CO+1YVJx5cmGvrL2jquUhPOdJg7P8RYmELMrXWs8iRrLoBvtiQatYXJ3P26TSmcb/66mxHXUN0L3VyzC9S6xFCWBbrK6AAgM4i5KUE4GnIUuQwESbnMWTu8m5jwgpRhQYKFhQ3oPFkP3T4yY7PmOZX2nBoZI0hn4o1kXPnsGyilNPGTM9zZeJkgPbLNAwbHeVZw/nAtV1iuJjVmtLz1jpxj23jjgCOf0I6bZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31SFm3JUXCQje8h6BXLYKKq5DPWIW9iAZhwrqHvA5FA=;
 b=VfHKlQ/ix353jwaILGJ7BqpckCIhcAu1ai9W1xmq6PdU4OcO9tuYRS59fkl7yAQjq7fh6CzNx23d7thtDUa9HLPlfmsFONT9Q88c2E/bEeHrAim427GuU03W3z/8+O9HbRoUqmYUmDbBTjWjp04lVe60TJhTdBlN7dEudRLAGrXnrQe2pYxr+npfyYfmgvBRYPPAdlI498dn5tqeCeACZt3wses/TU65gEUbb2Bm0Hp/Tb+PZ0OpIsgOFPqh+y+Bo+GFGRr82jkKfBU5ydMJfJU1kJZ3i84c+ISUPAjnEXLK83qnWoGQ4vW781QDsACMfFlrgNpxGfZ9lXSST3HuvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31SFm3JUXCQje8h6BXLYKKq5DPWIW9iAZhwrqHvA5FA=;
 b=piJTHrkZT7aQHI3142N93avnZWPLE2GnIQCo3y1BCFCc7IY/UDh9sIIdPkrhvSVDGAlHcEwDLM8YgHP2iG9XaNNOuqvvAj0zz3O4PKboGHcK0qJoH2CP+6rncDZtvYNa0Uo/dT5+QKbZy/VsEAWXMq+yzeY2cWU/89637OfXD1o=
Received: from DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Fri, 22 Nov
 2024 17:23:39 +0000
Received: from DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6]) by DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6%6]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 17:23:39 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Brendan Jackman <jackmanb@google.com>, "Manwaring, Derek"
	<derekmn@amazon.com>
CC: "bp@alien8.de" <bp@alien8.de>, "canellac@amazon.at" <canellac@amazon.at>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "mlipp@amazon.at" <mlipp@amazon.at>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Thread-Topic: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Thread-Index:
 AQHbMDg1JLBBlMsMQUStBRLaO7h7dbKqT+jQgApQQICAAKyDAIAACV4ggAAL0gCAAAL+UIAACkKAgAEguQCADQMkgIAABhCAgAAM1+A=
Date: Fri, 22 Nov 2024 17:23:39 +0000
Message-ID:
 <DS0PR12MB92737A247219B1EC0BCAFA6494232@DS0PR12MB9273.namprd12.prod.outlook.com>
References:
 <CA+i-1C3R=56CAMiDwuzrtxmQN+CN14hUeMfbv4k4WqyQfexZ1g@mail.gmail.com>
 <3676f073-028e-4855-aa87-107e0607be24@amazon.com>
 <CA+i-1C2cyypfrTNauqEn_640k36Cvtf-qw4vJEDx0bQuJOO6gg@mail.gmail.com>
In-Reply-To:
 <CA+i-1C2cyypfrTNauqEn_640k36Cvtf-qw4vJEDx0bQuJOO6gg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=10a06979-9646-4764-87dc-e68081885089;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-22T17:22:49Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB9273:EE_|CY5PR12MB6105:EE_
x-ms-office365-filtering-correlation-id: 12bd89b7-760a-45c3-2646-08dd0b1a67eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ak0wd1gzTHE3SlV2dktPanJVa3V4UGRGV1V1MlRaSzdIaW56eGZKdDFrRWxZ?=
 =?utf-8?B?bXFVUzBiSXZuK0w4d0trOFNPaFVtUEM3OG5EdWRZb3hlUW1iQVBFWHlOU0Ev?=
 =?utf-8?B?L3VPTlZjUzY3SlQ0eTBqZHo5S0NTQTFicnp3UGhjUDh1TWI5blJHZDJmQVZ5?=
 =?utf-8?B?cmRMbTNTeHRqb25BOTl4c1hIcGFoNG9mWW1ib1N3cUJsWFBKczI2ZjlTMm9u?=
 =?utf-8?B?TWJOYUdpbnQvNnBGUzBtRysyWFB1NDNLU2xubjhSVGlTa2dWbGpEL1lJSFJR?=
 =?utf-8?B?MEVUb2htdUZIVzJTd2hBTDBGUG1TbUw4Uy9UNWVMRXNlNnJZdElDUzNtMXlk?=
 =?utf-8?B?Q05Ycm12NUxuSFVhYUFmUkpzelVuOExFN3Fva2twTHhGeC9JNFdhYVQwemkw?=
 =?utf-8?B?eXVzeTN0dFBycXRSNEtWM2t2QnVWdEcvUUdwNWtYMmZZckhzc0lnbnNXVDZt?=
 =?utf-8?B?RWxRWUY0eTJoVU1aTTgrMnNlekIrbGVBU1gxdm5YSW5nWXZibWNUY2J3Tjla?=
 =?utf-8?B?dHg5RTZYbWRzVko3SGoza2xobE0xUUpLZ3RCNmFHenJFaWFPSDhrdmV0ODFQ?=
 =?utf-8?B?ekpFbXg4Q0s5cExrSUM1R3IyY0JXM1dZTm8xalBETU9tSDZzU01lWDJNOHdB?=
 =?utf-8?B?SVBwQVFKTkR1S1Z2T3NFNHJFeFFDK3lnaTRCU0lOQ3J0eTFKRExySE1WQkl3?=
 =?utf-8?B?dnFLSHZDUmdIRENTeWYybmlVVStwb2FNb1JJWTVwazZVNjdJZjZVY1JIU3Nq?=
 =?utf-8?B?eHcxWHJNVTlwZzV3bUIwUVFtc21JcHRFajltdTc1bkRkWmxnSGxZOGFZZ2wy?=
 =?utf-8?B?K1pySmpxcHNHK2J0NW9hWXVnWlp0dE9ld3VDMXZrWEZ0cGpscXVwRmxXZHRl?=
 =?utf-8?B?R0twb1FRRXVZcGEyenE5UWd4MGd3UHNQQVd6SGpITkM1dFlLU3FieW9md2Ri?=
 =?utf-8?B?Z0l6QkRoZXJJdWNpMzdFc29oUXU0SXBRZjhnMUpha0hSc0ErM29XNUVHNjRK?=
 =?utf-8?B?aTgwVmdqL05xdDdBUENqZUdoVGVod2FCUEt0WndqME5oQTFQNHJCMU1EZDJ4?=
 =?utf-8?B?OU81Rm16bER6UTVrS2pxVW9jSWM4K3dpNTYzWWg5T2c2QTBINlZOV3FIUXM3?=
 =?utf-8?B?dTlWR0NDT29rSFdITE5rNDZyOWhBbXI0aTAxOGE4VUl5RDhhSnRYMkZjN2JJ?=
 =?utf-8?B?aXdDVGVYRDZWMWNtd1Qyb2QrMDQvRS9DVmtiSzNQWFpZNUlOSHhRTTF6c2tQ?=
 =?utf-8?B?Mmp3Y25FZzBadlBSWXI4M1Y2QncwcllOUHhWMnNQa2hVL3VVOU4xQW9oNklo?=
 =?utf-8?B?OVhqVkh4OE9pUzlOVUVOeUFadUR3YWxvcmIvdzlxZzdTT015TDRCVTNuQ0dy?=
 =?utf-8?B?ZnZlNG5xbURwTDJmU2g3T3R5dlEyK0lhY3QzNHlaeTlKQ21NbzRtSnVmK2l2?=
 =?utf-8?B?anNjRjNYWnpMbEQwM01rS1JjcGFteGxUNXdkNUhJdWtKUjJ6ZTd6Mzdwc3ZZ?=
 =?utf-8?B?WG1yV0E1Y3NRTkx2VGVCVDBBcjQyN2o3MHA5WU1kd3FGaHhhQzNvMWtiWjRt?=
 =?utf-8?B?aVVoREhCN1B4WWtMc016TXQvVEFtODhaNy82NHE3TGkzTVhaUTFsMHFGbG9x?=
 =?utf-8?B?WEhMUllZSDgwbmRjNEU1dkl2enI2OG56Wk5NT2xiZXRwWnNIemJGekJ5cTFI?=
 =?utf-8?B?bEdFcWNmbVRVNmVTUlNrYWROdlk5VTc2eHJqZlpISmlMZnBUdFBncnNnMStG?=
 =?utf-8?B?UVVHaEtoSUgydW9sY1Y3S1VBQmJSSUJiVG5TTGFYbFJLTGl4ZjBhWUtSTytE?=
 =?utf-8?B?amlKUVVzN2hmcERzZnJSV21MZHk2RmhtNWZCWm5UbXVWYXNWb1pwQTdvNmZj?=
 =?utf-8?B?RkFwNy9nUWhzbjdvRHRJQXVwb2haa1A5NmtmcUpKK3JsMWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3A4MDZtL2g3M001ZkpLa2FQN2tyTkNjTHFIbzUxdE1VNHh0R3N5MUp5MWRL?=
 =?utf-8?B?VFFicFVRQzBTeHp5bkxWU0dVK1RFN2hqdmo1OXc4Z0JSMGVId2hsNUkyZzQ0?=
 =?utf-8?B?TGsrZ2JOSlUya0FzMzNzdEJkNHJUQ2p0RkI3c016cVdudUhUdFJvRFJ5RU9O?=
 =?utf-8?B?MHB4Q2hqNi8vY0ZacCtjazFQZXBZWFFiamFDLzhzeXNGeDRXSWlhSHAxOGg1?=
 =?utf-8?B?dHVJUUljMWRCanBPTWd2dmVHbks0U1ZHV2VzK1FRY3UrSmkxZmNIUUc3bTMw?=
 =?utf-8?B?ZDdaODc1M2dFRXg4ZVk4WmxOYng4L3NqUVdaQU94WllpK3RoRmpkMnBHblNJ?=
 =?utf-8?B?ZGtWUklrVGl0bkFUQnFLdTFCaE1OOVAxNGo5RHRoQWpXeDVVazJNRWhReXow?=
 =?utf-8?B?dUlRclVhZEYvS3dmd1d0cFJva2NBS2N0RFE4YUhyWkRvdjdNNENPM0plajNz?=
 =?utf-8?B?QWZ6cmVZdWdHME4yQWhLQ0pvbm5mTnpwM1VSdFpvRTNwVFNtaXN1dm9MaUNI?=
 =?utf-8?B?MXM2N0NMUnhod1RZVlR3SkE3aFZpdk8rekowQmdXUWRiaVdHZDJaMlROZzNJ?=
 =?utf-8?B?dnF3Tlg0cVMwSEpFaHFOd0hQaXNpN3VVb0FITyt5anp3bERPQmJsc2svSG01?=
 =?utf-8?B?MU44NUdOV1VxSm5vTDVYZnlUb2xKcU1SSWpZQjlxTEl3Zm1YRTlkbXFzclB0?=
 =?utf-8?B?WlpVb2xWd3NIOVZaSXlXU3dnKzJQSzRDcUdoWmVzd1hSNWJQaDVhWDl6WkFv?=
 =?utf-8?B?cG9XMmwzUlVrcUVTVTJpalpRa21jTnRWT1I0b0tQbTRtZDZtdnBQOExUN1Ja?=
 =?utf-8?B?dDVYWFRvSmpVdFBrd0JYYTFkaEtkQllqd09md25NUWlZZEFtRkxNQkc3MHRy?=
 =?utf-8?B?YU0vTnZ0eEhXZEdNZXBpNkM2K3k1aThMbm5aOVZZdnhTc25VcldVQjEyNTJU?=
 =?utf-8?B?Tmx1V1l1NVdNOGdZNTdZTDBZZjJkWHlrOGZLRzNLNSsrR0RQakYxTVBSazBv?=
 =?utf-8?B?cUtYaXZCNEUvVzlrcnh3cnBDR244R3ZBN1l3SHZsc1hhSlRoRHFVZTB3Tlh0?=
 =?utf-8?B?azJsSGEvTG9oakRvL2lyeERWbW0rZHV4Yk1reE8zNGlpUE4raEFmZVRXRDQx?=
 =?utf-8?B?dC96M0FXZWM1T1BhblpHYlJFckhESzZLRjBnS3M3UGljajM2QUJpdzArZ09H?=
 =?utf-8?B?dGlCS1RhNS93TTNSM3BOZC96aWxpK3Z1ckZRSnVYNlFjUEJhbzBTQzBmL0hj?=
 =?utf-8?B?cFk4TE1DcXpxdEZuVDdwWkZBY3o4Vm5VQkRERjVzM3oyRmw0ekVwa2toS2ti?=
 =?utf-8?B?NHkxVUVrdzhuNFMvQ29na0dNL2NtaUR5VFFpMFZKeWJ3OHZ2RGlzaDNINlAv?=
 =?utf-8?B?bFhvRGtvRDU0ejJCSGdkb2xVaG5rd1lXdk9CMjRkbXAyQmZvS3VKVGo4Z1VO?=
 =?utf-8?B?Y01pRHN0VU52UVROekcxQU1ScUpBVWVNSm5BVzluL2JOTTJJMVRGZHdyUWNE?=
 =?utf-8?B?dUlCZElpVDVWNldvOE5Fd25UMjViOVJDL1I0NlpHSFl3RnF3cXVuV2x4Z2ti?=
 =?utf-8?B?ZGI1MHNDMDlNaEpJZ3FFN293eTVIZXFMVVJXY1ZMZCt4aERYYXh1N2gyaVlU?=
 =?utf-8?B?MHBtM2xlYTFzMmdaZXZxNVRqSHVLR3V2MWRwVkVmZHNBbDJRclg3bVZNaGw2?=
 =?utf-8?B?czBSRFJYVlJLV3BneWhsS1M3dWRGbEJ1S0tXcFQrTVVkMEQ3bG5mVkg3QjlX?=
 =?utf-8?B?VkNlZTdzSzY0N0NxN21YTm8ydlZlb2dnd2YrVE84OEZYY3ZrU1NML0NVWmx6?=
 =?utf-8?B?c1lFOXo5cENwQVI2VklpSUpBVHh4VThXM1BLOEtVOVFEaUJBaUxqVkxlS2Fv?=
 =?utf-8?B?RlpIZ1NHb0xzeGxMVm11WDRacWwxTEZYdXJaL2MyVkg3QWh6MGtLcE9Bek9J?=
 =?utf-8?B?cXdJbnA3RVFESVppR1hxZ1dtQ2lHQ2JPdmgzUHp0WkRRQ0Q0elpEbnhpSkE3?=
 =?utf-8?B?WDFld1crZi8vMmtMWkFMVVloY2lveVZoem5Jd2I3V0EzMEt3UjBycFZrRVY1?=
 =?utf-8?B?VnVHZkJiQ2pCZXVQaStHeS8zTkdKbERPMWE4dDZsYnY0c1JRS1BhQ0Z1SWhm?=
 =?utf-8?Q?U5FU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bd89b7-760a-45c3-2646-08dd0b1a67eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 17:23:39.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09b4d15B0eFj/y0ZVQmqDiBj29AIFedmAZL4GcYXELYfTvCLNfv7L4gjXnuBqkPa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmVuZGFuIEphY2ttYW4g
PGphY2ttYW5iQGdvb2dsZS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMjIsIDIwMjQg
MTA6MzcgQU0NCj4gVG86IE1hbndhcmluZywgRGVyZWsgPGRlcmVrbW5AYW1hem9uLmNvbT4NCj4g
Q2M6IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPjsgYnBAYWxpZW44LmRlOw0K
PiBjYW5lbGxhY0BhbWF6b24uYXQ7IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgaHBhQHp5
dG9yLmNvbTsNCj4ganBvaW1ib2VAa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbWluZ29AcmVkaGF0LmNvbTsNCj4gbWxpcHBAYW1hem9uLmF0OyBwYXdhbi5rdW1hci5n
dXB0YUBsaW51eC5pbnRlbC5jb207DQo+IHBldGVyekBpbmZyYWRlYWQub3JnOyB0Z2x4QGxpbnV0
cm9uaXguZGU7IHg4NkBrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTkvMzVd
IERvY3VtZW50YXRpb24veDg2OiBEb2N1bWVudCB0aGUgbmV3IGF0dGFjaw0KPiB2ZWN0b3IgY29u
dHJvbHMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRl
cm5hbCBTb3VyY2UuIFVzZSBwcm9wZXINCj4gY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVu
dHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBGcmksIDIyIE5v
diAyMDI0IGF0IDE3OjE1LCBNYW53YXJpbmcsIERlcmVrIDxkZXJla21uQGFtYXpvbi5jb20+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gT24gMjAyNC0xMS0xNCBhdCA5OjMyKzAwMDAsIEJyZW5kYW4gSmFj
a21hbiB3cm90ZToNCj4gPiA+IE9uIFdlZCwgMTMgTm92IDIwMjQgYXQgMTc6MTksIEJyZW5kYW4g
SmFja21hbg0KPiA8amFja21hbmJAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+DQo+ID4gPiBBIGRpc2N1
c3Npb24gb2ZmLWxpc3QgbGVkIG1lIHRvIHJlYWxpc2UgdGhhdCB0aGUgc3BlY2lmaWNzIG9mIHRo
aXMNCj4gPiA+IGNvbW1lbnQgYXJlIG5vbnNlbnNpY2FsLCBJIGhhZCBMMVRGIGluIG1pbmQgYnV0
IEkgZG9uJ3QgdGhpbmsgeW91DQo+ID4gPiBjYW4gZXhwbG9pdCBMMVRGIGluIGEgZGlyZWN0IGd1
ZXN0LT5ndWVzdCBhdHRhY2sgKEknbSBwcm9iYWJseSBzdGlsbA0KPiA+ID4gbWlzc2luZyBzb21l
IG51YW5jZSB0aGVyZSkuIFdlIHdvdWxkbid0IG5lZWQgdG8gZmx1c2ggTDFEIHRoZXJlDQo+ID4g
PiB1bmxlc3MgdGhlcmUncyBhIG5ldyB2dWxuLg0KPiA+DQo+ID4gV2l0aCBGb3Jlc2hhZG93LVZN
TS9DVkUtMjAxOC0zNjQ2IEkgdGhvdWdodCB5b3UgY2FuIGRvIGd1ZXN0LQ0KPiA+Z3Vlc3Q/DQo+
ID4gU2luY2UgZ3Vlc3QgY29tcGxldGVseSBjb250cm9scyB0aGUgcGh5c2ljYWwgYWRkcmVzcyB3
aGljaCBlbmRzIHVwDQo+ID4gcHJvYmluZyBMMUQgKGFzIGlmIGl0IHdlcmUgYSBob3N0IHBoeXNp
Y2FsIGFkZHJlc3MpLg0KPg0KPiBZb3UgYXJlIGFsbW9zdCBjZXJ0YWlubHkgcmlnaHQhDQoNCkFn
cmVlZCwgSSB3aWxsIHVwZGF0ZSBteSBwYXRjaGVzIHRvIGZpeCB0aGlzLCBzbyB0aGF0IG1pdGln
YXRpb24gaXMgYXBwbGllZCBpZiBndWVzdC0+Z3Vlc3QgcHJvdGVjdGlvbiBpcyByZXF1ZXN0ZWQu
DQoNClRoYW5rcw0KLS1EYXZpZCBLYXBsYW4NCg0KPg0KPiA+IEFuZCBhZ3JlZSB3aXRoIHRoZSBm
bHVzaGVzIGJldHdlZW4gZGlmZmVyZW50IHJlc3RyaWN0ZWQgYWRkcmVzcyBzcGFjZXMNCj4gPiAo
ZS5nLiBjb250ZXh0IHN3aXRjaCBiZXR3ZWVuIGd1ZXN0cywgcmlnaHQ/KS4NCj4NCj4gWWVhaCBi
YXNpY2FsbHksIGFsdGhvdWdoIHdpdGggdGhlIFJGQ3YyIEknbSBnb25uYSBiZSBwcm9wb3Npbmcg
dGhpcw0KPiAidGFpbnRpbmciIG1vZGVsIHdoZXJlIGluc3RlYWQgb2YgaGF2aW5nIHRvIGZsdXNo
LCBpbiBjb250ZXh0IHN3aXRjaCB3ZSBqdXN0DQo+IHNldCBhIGZsYWcgdG8gc2F5ICJhbm90aGVy
IE1NKiBtaWdodCBoYXZlIGxlZnQgZGF0YSBpbiBhIHNpZGVjaGFubmVsIi4gVGhlbiBpZg0KPiB3
ZSBoYXZlIHRoYXQgZmxhZyBzZXQgb24gYW4gYXNpX2VudGVyIHdlIGZsdXNoIGF0IHRoYXQgcG9p
bnQuDQo+DQo+ICpXZSBjb3VsZCBicmVhayB0aGF0IGRvd24gZnVydGhlciB0b28sIGUuZy4gd2hl
dGhlciB0aGUgdGhpbmcgdGhhdCBsZWZ0IGRhdGENCj4gYmVoaW5kIHdhcyBhIFZNIGd1ZXN0IG9y
IGEgdXNlcnNwYWNlIHRhc2ssIGlmIHRoYXQgZXZlciBpbmZsdWVuY2VzIHdoYXQNCj4gY2FjaGVz
L2J1ZmZlcnMgd2Ugd2FubmEgYnVybi4NCg==

