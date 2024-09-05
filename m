Return-Path: <linux-kernel+bounces-316745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E6C96D36D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF7D1C25AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AADB197A97;
	Thu,  5 Sep 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OjdgMlJo"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD0149C4D;
	Thu,  5 Sep 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528850; cv=fail; b=ICR44ZpjL0cWT7KsWhNsrZaZq0GrVxjEwqVZglr5CSc4iJan3mC2RZ5Vh0lQ3Cl054w+5QOBTrODMOZcgk1/DyNDomgDHZWh3iaXZ5oqdoGg1/LFmuPB0CLVQwqNJeNK6YX6w5FMNystBf8ERuLExQasMaHDqIX1fsVZw7Ckz6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528850; c=relaxed/simple;
	bh=aMGrLxHfFTcVwHWhRVeec44SMZJGREZPZK07pWWsuHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iI1nTbdASH2eF51sWjrqdABWKMWmibdHAQ29gWgLXXql5wiba6jaY/2uOi4tkvLFLHBr20MXjYoMKk3I95IcbhD15bxB9ZXZNvfOW0YRbMyIj3xtPpLb0oS6IAaKNm5cEL/J6VJAPCzdCPVo8NrMqx75d4hIngVUkj52uiknWiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OjdgMlJo; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gemG3DSuONhz4IQTFlF+iAeTv7Vmos7jTNipETtmgZALmN72FMyZ/T4hurF5R671oslBjFgfYbFMLAir4JKzl58zy39GLPcCRXZvBbX31hoG1gOFm8tL+rziD3O5HOMV4p87/X7XKdQfjYQYk0oxHIclSgTMMwiD2rWTK/7yUbJ36mQzhvSZfsTAXKGlDEnvA45xPRQLFZg1UaFoB3ubw03bqwSBIXbs0gstzGyWheJPt48XJDNEO2pemM0orCmUrlbplQ+tiY9g/cnQveAmPyPZTwhVam/0yDnALyJklHKPY5GenMxQlskIwi+MnCkcfUVOFtevzrl5tnb/2IkKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMGrLxHfFTcVwHWhRVeec44SMZJGREZPZK07pWWsuHk=;
 b=mgZGRV8WEN464EMoqfTBxL2yi4Xn7BHIFH+Nqtdg6d+9rCHKnc4QfmGO+UYgjm74/+FKbfXO+TUneloFzyvuKbVgZBwog5CopP9gqZNA1mKT3WiSyaKK6dGDQz1l5mPCxmqf0KDapXUJLd4uhUE8yhZYIFuUIIc6ivOkMrxwqv7ofip5n9N+mdqFVhFqlvyHjvvceuYME8ZPSnCl3eECcJIccctkhghvAGktuK6hjU2qKFR+7GZCpFijmRTP5ToBNhJrwqY9VQuVkww914MS4hp8W6Iz5TmuRXYfRXJunbJBQXD6i4OFOeUrukBmbXxnmCli/degCepPS0SbHdFi6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMGrLxHfFTcVwHWhRVeec44SMZJGREZPZK07pWWsuHk=;
 b=OjdgMlJo2EPkhMbgrbG16YeKUDEnQ8oEeJL+zh2XFoCdYLYl24AvXG+yDmV4xEsRcsqGrDBGwvbKLd4e7DiqtGtkXJiHd+dEo8hKEQqAqoOJTuout1Nk1feHqMMvgEYLBB+ELbciMhK4yYzhb/xr82O6mRGzDBML6veUo0ql9cg=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 5 Sep 2024 09:34:06 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 09:34:05 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Colin Ian King <colin.i.king@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] usb: gadget: udc-xilinx: Remove trailing space
 after \n newline
Thread-Topic: [PATCH][next] usb: gadget: udc-xilinx: Remove trailing space
 after \n newline
Thread-Index: AQGXmtRoIEciM9fB5+0KPGFXap4EOLLPt4ew
Date: Thu, 5 Sep 2024 09:34:05 +0000
Message-ID:
 <MN0PR12MB5953D8FCAD8C095B33F74DD5B79D2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240901162357.144222-1-colin.i.king@gmail.com>
In-Reply-To: <20240901162357.144222-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM4PR12MB6544:EE_
x-ms-office365-filtering-correlation-id: daf56a57-e0fc-4de6-2cfb-08dccd8de2c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVcxbVhnbWtxd0JqbTFsN3B6Z0V3aEJ3YVR4dDJTRHh5SWU5UzNyeGZ4WE9G?=
 =?utf-8?B?Y2Z1TFgzclVYYjltaVZyQ3hNaGNpNzdwYlpKQnNuS0c4S1VjSEdhdTZLNTk4?=
 =?utf-8?B?a3Rpak1jNkR6TkJtbjZLNlBMV0twemZKVDVlSXJwelJzMExYMHVOdklTaEZy?=
 =?utf-8?B?UFhrcG5PMzNHWFFTSGcvRXNNRUVhYm5uMlE0YjNlZ0hYTjQxMnJLN1JuQmVX?=
 =?utf-8?B?OG5CTEd0cjRqK1p1ZTJOakpZMTRQQTJGZVFkaHlScUpGSUhjei8yZTNPQ2c2?=
 =?utf-8?B?VzlleGFRNkFDd2hGME1ERXY0VlY3SHBveFVsQ3d3UUdtd0ZQQmZLdXIybU1v?=
 =?utf-8?B?VFp5RFl0Qkw3RndlekdGR0NDUFR1eGR6VnZNdThRUGZyZHFLMFZadk43Rkl5?=
 =?utf-8?B?R1BWSEc2Qjg0Mm9adWl6MzFkZ01uMCtObFZBMmdJYmlRNUx5WEloTWJLNkNM?=
 =?utf-8?B?S284NG96SnBSekxYYUl3VStnbWkySi92SUtUQ3pHK2JBN29zb3dWL2d4QjJ6?=
 =?utf-8?B?cUNlZ3F3N3ltWHBJVjY4VVUwKzhBdC84NmFLOXU0d0hENEwyR2hVNVNqem1Q?=
 =?utf-8?B?L0pZSTA4YnB0Z25HOS96UG9yU2VpVEkreitkVUtncmxxU3hvOU9ZTVIzK1hR?=
 =?utf-8?B?L0FRcUdXY1dlWkk5RmhVRThrY3F0UjZ0Mm5oWFZRSUdFQTNrOUZuOW5aUVF6?=
 =?utf-8?B?SVF6OHg3MFM1aWNHMFlsM01EcEZFUXRjMHdlaUlYN2pWNFR0eWJudFdUQys2?=
 =?utf-8?B?SnIwTE8yWGFhSG5zOW81R0U0MGNqOTJTMEpTZk1TeEU2UHE4YnBhT25iY3Q0?=
 =?utf-8?B?dmdUMGRDOFVqU3JzZ2ZlMU1LWlpyaFpLZTRFU2xJUkozOERoNzhUaE12b2pX?=
 =?utf-8?B?cHUrcEFCN01mejl2K0JNUjA0aURBY0VXcFo2cWRGYmpGSUdmQ3AySDcxK2U0?=
 =?utf-8?B?TFp4Slp1YmovRXlVT0RWcEZtWnRKRVVwdDJLZ1RHRC9JY3VLOUJiYmtUMWha?=
 =?utf-8?B?bVNQUXgrRkhYcmU1ckpPa0JjclNjbmZLNHdsQ01tbUlBVW9QbFVmUCtnTk10?=
 =?utf-8?B?QlEwckR6cmdLL1lmOGlTSVVsY0Iway9Oblk5RDMrNERpRGJVRFRnT3JPQWNh?=
 =?utf-8?B?L2lUbDRFTFlEQlkzVUFJNzNQSnQ3NVNEcityWk9FbFVzUWNrLzZVMlNZaGlC?=
 =?utf-8?B?NEFLeWxsY2pKYXMwV1JBUkxGL0M3NDRVblFuMml6TFBjQjVyZ05tMStQaTNk?=
 =?utf-8?B?S0NVSEcrc3M2ZGdhQU05N3JpbXdhODJWcy9aQm1mM3gyTW1Qb3ZodU5LZ1Ur?=
 =?utf-8?B?ak9hMFNqc2hwVXZXQ2t4dHFVdXd4a3VRRzFvbkRYemZRRVE0VEYzeUJxWkJa?=
 =?utf-8?B?NW5HejBQTFVlV0VNT0pBaElTYlJCdWRkc05vVG50anFvK3lUWFluNjlxcE9P?=
 =?utf-8?B?SjdrVkhyaEFNcVFqTCtGN2N2YUczK1FvbFpoOE9iUDJNT0dWMnlxVGp0TDgy?=
 =?utf-8?B?Vzh2SjJLc2N2Y0NZeTUvSFlFNzVSQ1BqTkwrRm5kTGNCdElsWE5XcTQwSTZm?=
 =?utf-8?B?S3JsbmNVd2tRTTFCRnczYTlzVWJzRlZBeTVXWHhSSC9FZjVqRkZGeXA0SVV3?=
 =?utf-8?B?WGtLSi92YUhXSHM2S1RiTkVadnVnN1cySDhpVDRBQ2pNTEtZckdLN29yYWhi?=
 =?utf-8?B?Uy9XeHpqZXVlSTFEWEJ1VC81YmZHczFnN05LNnJ0OXp1UUtqY3A0VjdMUEFG?=
 =?utf-8?B?WTZNK0NDb1laSDBvd01QUFhqbVNMdERoaVFQcExZV01wMmxQai9rMytHays5?=
 =?utf-8?B?UDE2d29DZFJVL1QvTFRnajRBRTdBWE9zQU1yeFNHMXFSWW9JUTBoLzVuSTBZ?=
 =?utf-8?B?U0xWb0RRTjNtODFFMFVJMFZvZVZ1V21KUytNRldNa1NtRlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUtGTjN0YnlXS1kwa1JoRDZlZGNxYXQ1RVhIMXV0TUVOYUg3eGtiSnEraW83?=
 =?utf-8?B?NUhVUHI0aDhVOFN2YkptTWkvbGxpaTkxNTY2SnV0Wk9zNGJYdU1vcVhVeFJq?=
 =?utf-8?B?c1hqTXIvSmJzSFllZXhVZlBoSys3R3RRdm1TNzY5UEJOUlM3a1U5dUNXZ2Nq?=
 =?utf-8?B?Q0RObUtXTkU1TVBDSXYzR1RxQkJEQW9ucXN2UmZLUlNyb24yRkEvN011V21U?=
 =?utf-8?B?aGJjTFJTcjBqWC9ocGN0djJxU056QVFmUlZrb1JxRDl6NG5ycHdMeFVsMG4z?=
 =?utf-8?B?UGpsUzZaOWJVbXc1bkVyQmJmNHNWcjVFMlRRVWlIUmVzbG9rTHcyWVM4dU5Y?=
 =?utf-8?B?RmxIYk9rWVVIWEtnMVkwc0poQzJWUHJyY1RVRzBob0VIczAyeHpEMUtGYXVh?=
 =?utf-8?B?NG5YQjFHcHk5M3BYZDBsMEVKRDBxVHUwZ21ZbFlCVzJxWXY1YlVDSVBwaHBx?=
 =?utf-8?B?N0s3TW9SS2pxSS9EUE9wWXR1TFFKRHZtTWUwR0ZDT0QrNFpObVFKcmdTd1RR?=
 =?utf-8?B?VzVNeWdPZ25rdE80MWpZR3l2RHArRjgwN3JKendTcGpCTjJFcVArVEZDWmh5?=
 =?utf-8?B?blRIcGQwbHZNcC9MTTJHSFFwOHNBTS9HaHRSNVhMN3RxYWpJTmN3NjE2K0dT?=
 =?utf-8?B?cnRSUFY4eDY4TGlJTS8rMjQ1L3BsTjh0S3J6ZGI4TkowZ2YyVThkTHNHdXZ2?=
 =?utf-8?B?T2JuT0hsWjJNbXZEenJmYk5BV0RiL0l0bVBOS2FsU3M5cVY5TzB2RWxtSllC?=
 =?utf-8?B?dG8rV2R6Qk9DYmZiM1BXK3pleDIycHR2U2d5ekNucUpXQXlIR3hTc2R4WjZB?=
 =?utf-8?B?Y1V1YmtWN2RrR2dXZHhEUjVvdWRDNmM1ak9kQUlPTy85TmZKZm9IamdReGVN?=
 =?utf-8?B?bGFKZk5mMFd5dzFtd2VNRkJ1c0hxejVVeG1OU2hIQzFuaUF4YThGaG9JUDNT?=
 =?utf-8?B?K2l5ZXhzT29jWTlYNUVPU2VqL042V1dyQ0JoZEFUMFBZYmdId0lKMGQxQk5D?=
 =?utf-8?B?WEdaQUZqdml6MFA3MmNsTDdQdWQ3cnVIdVdqbzJWRW5yUWdOb0FKb0t0TW9K?=
 =?utf-8?B?bHppbHVPenFZSXlXMHVvaE16ZytUTjJEdGlqN0lyUGZPTEZ0aEUyOFJ6QnJH?=
 =?utf-8?B?bTFtQWNsYlVlczdSUzJqaHVwd3NGdFlWaGtWWlNVK3NSdXN4azB0ZXgrVUph?=
 =?utf-8?B?amliVkk1dnpQZWZTaUEyMXY2aTBWbWFISGE0R3RlMDNNRVd4ejJUZHpXVkx6?=
 =?utf-8?B?MVJwZ3B3cmxsV3FTRXJlWjNsSnFTK2pTUkg0MEZTZWZOdVNLbDR6NU1ic2k2?=
 =?utf-8?B?TTRFOGZoeGUxaWdHWi9EaGJTVml1Q3pld05LQ3JjNUVkYitxMzF1aitub0Zk?=
 =?utf-8?B?bUJhbXo4a2JZZW5scW1uZWtnNnc3aktzQmRxQkRsNXdhSWo5WWNmMGRHemVX?=
 =?utf-8?B?bUtPdklJMmJXRG5FdWxCQkcrVU9Lb004YWthVHF3SzhGYko1dkpKUGVCdGlv?=
 =?utf-8?B?Nm9uRUJWMzZyb2dyRWtON1VRWHFud3ZYRGE0dFZuRTVydTdRcVV3NnZMdTlW?=
 =?utf-8?B?andFN2hiS0NNRGh2d1hVMmdVeHBXUmZHVWZZSllhRGUwZGtPbktyT1dpc2VH?=
 =?utf-8?B?OFZzS1VTM044ZGZ3TllSZ1Y0WHZsS2d1ZENFcks4aUJualFlbHIyVHVXaFJN?=
 =?utf-8?B?UTk2Tm9zK0duaml0b0ZQU3NFQTlJUWp2L21aZTMwZm1qWW5KckE5aURIYjZh?=
 =?utf-8?B?dG96OUdWMTBvc3hrSTlOZXluWk9BYzg1eFZWVE9aSXh1bGhLRUgrREE1aXBi?=
 =?utf-8?B?OWpVVnZDZmxJZTB1V3pBWTVCeW5DWmVBd1RxRVJZOS84VkQyaUk0ZWpOV1Vq?=
 =?utf-8?B?TFREMGdCaW1TZmVlNkxwR0NOMDkzYkpsenBEYlpaTEJac1MydjZYRXZYTkc5?=
 =?utf-8?B?ZTZMN1RDTVNyanErc1BQK1BvRFo1dWhtOFIyY2RhcnQzUnhxMHpQQmhPcmlt?=
 =?utf-8?B?dnM0SjZJUWViZ2czYWdGNy9lUUsvK3RlQlkrNHllTEhKTXdEcGNoUUdTaTVB?=
 =?utf-8?B?djdwa2FNdmRqNG5URTJHeEcraU1EZmYzTENFTTNwUzAvTjNBcVJKcmkybjdQ?=
 =?utf-8?Q?El7s=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf56a57-e0fc-4de6-2cfb-08dccd8de2c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 09:34:05.8398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /3QalIQgizh3XSa7fxum7+fztJ7+Ytt+QoKbko4jL5gPPBUbKrkdK1NzjhtvO/uf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29s
aW4uaS5raW5nQGdtYWlsLmNvbT4NCj4gU2VudDogU3VuZGF5LCBTZXB0ZW1iZXIgMSwgMjAyNCA5
OjU0IFBNDQo+IFRvOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPjsgTWljaGFsIFNpbWVrDQo+IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IGxpbnV4LXVzYkB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcN
Cj4gQ2M6IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXVtuZXh0XSB1c2I6IGdhZGdldDogdWRjLXhp
bGlueDogUmVtb3ZlIHRyYWlsaW5nIHNwYWNlIGFmdGVyIFxuDQo+IG5ld2xpbmUNCj4gDQo+IFRo
ZXJlIGlzIGEgZXh0cmFuZW91cyBzcGFjZSBhZnRlciBhIG5ld2xpbmUgaW4gYSBkZXZfZGJnIG1l
c3NhZ2UuDQo+IFJlbW92ZSBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5n
IDxjb2xpbi5pLmtpbmdAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogUmFkaGV5IFNoeWFtIFBh
bmRleSA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KVGhhbmtzIQ0KPiAtLS0NCj4gIGRy
aXZlcnMvdXNiL2dhZGdldC91ZGMvdWRjLXhpbGlueC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZ2FkZ2V0L3VkYy91ZGMteGlsaW54LmMNCj4gYi9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL3VkYy14aWxpbnguYw0KPiBpbmRleCA3NDU5MGY5M2VhNjEuLmViYzQ1NTY1YzMzZSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy91ZGMteGlsaW54LmMNCj4gKysrIGIv
ZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy91ZGMteGlsaW54LmMNCj4gQEAgLTk0Nyw3ICs5NDcsNyBA
QCBzdGF0aWMgaW50IHh1ZGNfZXBfZGlzYWJsZShzdHJ1Y3QgdXNiX2VwICpfZXApDQo+ICAJZXAt
PmRlc2MgPSBOVUxMOw0KPiAgCWVwLT5lcF91c2IuZGVzYyA9IE5VTEw7DQo+IA0KPiAtCWRldl9k
YmcodWRjLT5kZXYsICJVU0IgRXAgJWQgZGlzYWJsZVxuICIsIGVwLT5lcG51bWJlcik7DQo+ICsJ
ZGV2X2RiZyh1ZGMtPmRldiwgIlVTQiBFcCAlZCBkaXNhYmxlXG4iLCBlcC0+ZXBudW1iZXIpOw0K
PiAgCS8qIERpc2FibGUgdGhlIGVuZHBvaW50LiovDQo+ICAJZXBjZmcgPSB1ZGMtPnJlYWRfZm4o
dWRjLT5hZGRyICsgZXAtPm9mZnNldCk7DQo+ICAJZXBjZmcgJj0gflhVU0JfRVBfQ0ZHX1ZBTElE
X01BU0s7DQo+IC0tDQo+IDIuMzkuMg0KDQo=

