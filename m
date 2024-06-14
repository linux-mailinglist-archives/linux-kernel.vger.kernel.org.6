Return-Path: <linux-kernel+bounces-214360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7583908340
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277B61F2379B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DAD132103;
	Fri, 14 Jun 2024 05:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EendjkDw"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4725619D88A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342206; cv=fail; b=N0SQA2ZzER2BTgFprSihswYB+OBiLX7wB82QeC031zJTHNk21yK8aDBHKbaTBUDsL9vCarK/S9KzbMcbFuguoeR4d/7CerdbmiIboy3Q0ziMRPFDRUOSA/UTBY1UZXVCYc/bPURbhBb+IWM/MIG0EDaO+O/HJhRcjYV2vFPr8tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342206; c=relaxed/simple;
	bh=+av2u2YsQWHGce2DmU5Dr1ChP50JsPcsvChLMB4tnNU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QYxaxyQ3F2guYe9EGZcEvBV6j85P9MfCSHCmvgPUkSa4tcnOlPlzlESRwiikpMQ+Ph62pZN8cbveY5fYXGgxzOuLfMYCMC+8BrZiPnhd1XgkqUJUw3CL03SzzDUbcGzAGpkFsJQYLonBdL5njAQK6O0MLWfKAvAgaWUkRjuyVdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EendjkDw; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZ3OusTho5/rHoMkgRTXZ7/3zMUSm3Gend6n3T0RMqA/SglCg8RKSgJZdFFbHNRrvORlsjI5rHFses3fyJKXAiu3zMeP2fe8GfDk7OLZk2DnE2I78Xaan/8VUrrcTJfpMdAZSD2IfgXBlVOkqLAS+nvYj8Ebzxy+pCtkhLpE3HGxLvAHivH+D2Oda2z8uH+N8NXxYqp4LS+UabdUIaUt4UttR8/I43NQkbIrTMOEhOtgYAm9SyHu+fA9xzFdgS+kKh7YUeJwWMGaCf2tZP1PhSZxQ3haZi0wrPGMt5FvFfbIO2Wkj2Efvmh2YUGyQdJ25Dsfh7g9UvjiHlJLd7IMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+av2u2YsQWHGce2DmU5Dr1ChP50JsPcsvChLMB4tnNU=;
 b=V9E1JDtRJa5OWdA2rYJ/fKwoA1Kql5NYma9u4x18e0nQ2s4WEBEL1HjtjrzJcAauN8RrA0yaISMg+PaI6rYm34jD0izm7n+PjTQuDLch7WaMv8d4vzyy27rlaKPKWYBYDCmcLW6z5Je+9L9nCTc55Q2BWtoFCz5DeKGurWbgdb0OdUAXuMEDwxhEEUPDiMGdV+kU7HRaZRSgAETSy56JNkkEpcuZkXGfvfh/B4aKxIwaygJ6b7hOWhh4vNCGuKaz1rNVTqSBae2ADKdaPvMnujRFUvX4iF5QPl+sHZT9yfoss7MQLQYy1uMR3ZN4pZkmVwZQYYBCGoke0R5/oYle9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+av2u2YsQWHGce2DmU5Dr1ChP50JsPcsvChLMB4tnNU=;
 b=EendjkDw26sA/M0LZwUjONTUttorIgs6c+qefsM8FBNMhyVVlClkjvcuL+EzEdqVtMRAHCS5FmzzjUk2qY5cu5HqcnE9/O/u9fDmeOUe9LEBS3KMCHCEqzY0YbC5kgCfQ/IWj4C9Z6+54Pd7cKSOXXn1GVFnUzKV6wkVS8g7iHA=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 05:16:34 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%6]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 05:16:34 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>
CC: Vinod Koul <vkoul@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: RE: [PATCH v2 4/4] phy: zynqmp: Add debugfs support
Thread-Topic: [PATCH v2 4/4] phy: zynqmp: Add debugfs support
Thread-Index: AQJ83aedMQVFXzZR+sovobCavopdtgGvrfvSsHOmC7CAAGaQgIAA7UKw
Date: Fri, 14 Jun 2024 05:16:34 +0000
Message-ID:
 <MN0PR12MB595380A6FBC3B67B312E440CB7C22@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240506170110.2874724-1-sean.anderson@linux.dev>
 <20240506170110.2874724-5-sean.anderson@linux.dev>
 <MN0PR12MB5953519A685A222CC603A2FEB7C12@MN0PR12MB5953.namprd12.prod.outlook.com>
 <8349516a-84bc-45bf-a84c-ff05d8f50bf7@linux.dev>
In-Reply-To: <8349516a-84bc-45bf-a84c-ff05d8f50bf7@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH7PR12MB5830:EE_
x-ms-office365-filtering-correlation-id: 0b20bba0-781d-4af0-a918-08dc8c3128ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|376009|366011|1800799019|38070700013;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDFFK3k4MkZHZlZuN3ZaMVEzSzFFMjByL1p1WGlUalpMZ0RydHJRcWJrb1p4?=
 =?utf-8?B?aUQ2aFFCZnpEdjBVY3VzUlBkWUp5SCtyTk1LV1VjOTRDemFmSnJ6SmZ1SkJy?=
 =?utf-8?B?ZS82cFl5SEdET0duWWFWakRzSTVkUGVHU0d6cXRXcEZKT2lvVWFYM0FnYTBL?=
 =?utf-8?B?aDgzcExvVkxQb3MrakFmQTRYaXphUWV6c2xPUmN0UFZOcFRYL0ZzUVVGUUpz?=
 =?utf-8?B?NVh1QVN2bENKd3lJR3VmVHJ5TU5tSmNPRk1nZlJtZnZ6SUZ0M2N5WlBRSWlj?=
 =?utf-8?B?UjR0K01vb05QZk16M3g2MGJOeFFzQmRmbDRpaXRKdnlibzRRY2poNkpib1o1?=
 =?utf-8?B?Q0tjSWxnM1JFSi92dUlsRmVmRlRsaitCVmE3SDJWaEZjN1p1TkR0Qlp4WkN5?=
 =?utf-8?B?bFR0TXkxZ3A1dnVKQmlTVEJtNWxzWGhjM2hYM25NcERpc2pxMnh1aDhUTS9Z?=
 =?utf-8?B?cURkNVhnSEFjYXpNNFR3Q1hoRERzZXdEUUhrVXFrS2p6NlNIZEVveUxWaG5Z?=
 =?utf-8?B?aXdTandBUEV3QzZOc01WeVZWMXN1ME9pVEY2QkVlcUNlSEZHSlp1NDJ6QXow?=
 =?utf-8?B?Y0lxOEl5Mnpqc1gxaVRGSkdFRWZCeW9EVm8wdVFKcDVVeExJK1doM1FsQ25s?=
 =?utf-8?B?UkJDdWtCY2RYa3RGbW9Lbk9ZUjdjUFgxMndMNWRTNXBMZC9FQnBaeTZNUjNJ?=
 =?utf-8?B?SVhnSFozeEVHZHU0UG5jaVJMZU9RVk5CZXRmMlJHZWNwZFJ6cUkyaWVWYk5n?=
 =?utf-8?B?djVPUUpXMURCUVZBbDIvZVl5aDQ0aDdQckVNRDN5ZHorMGFBNnRKUVdqU1R3?=
 =?utf-8?B?V1loWXNKZCtHMi8yQWVxRGVYL0tLekZ1aTVjZlR4S1FEYldaakJzT1poNHk4?=
 =?utf-8?B?bm0wSUhxYy9NTnF3U1Z0aFl1dFpYTWpod3llcUhHQ21RWTF4MFVuZUhEMTFF?=
 =?utf-8?B?UlU3QnJIZjlVdm1rOFQ4TjNUN05jeG5lR0JVZE41eUFJRVdmSFo0Vi9iT2Yw?=
 =?utf-8?B?Z3pjTHpRNTQ5M00zVU1pSkRCZjh1UVJWT1U2K0IxVHVzWnlXSXZxVzhNNmpE?=
 =?utf-8?B?QTdjM3BhcFlUcElROE5NMlFTSFFOc3ROVHBqSndpaHYvZnF4QjNCbityNkVC?=
 =?utf-8?B?aEMveHNqVkhqV212cUZYdkhCT1lzQzdQZlJoZkVxbUxBTDhoZ1l0YU1NbW8v?=
 =?utf-8?B?NXFRdUQwVGdOVXZaSHhodnl4TFl2Q2dOV2VmK1lVVGUwWURsK0JoME80d2t3?=
 =?utf-8?B?c2lqSXFrU1owa1dkNHBlK1M4aWJOV21qaWt1SG9VNTBJU1ZHclVSVHhtK29B?=
 =?utf-8?B?RmdBdWZpdFFZcnBvYU1oTStTQlUzTjU3a3ZtOUJyZ1NoZG9XS0xBQ2xrUnRY?=
 =?utf-8?B?c1F0czY0SkdpaVJnUTNjTFI5WGJnakZRNEV1ZTNjcDJHOU1BaWNaR3VpbEQ3?=
 =?utf-8?B?Rzd6NEJtTy8vWUFIMjNmWXJiUlo4SUdkeUp3YXpMMVNPdDluYVE2ZHpqa0tk?=
 =?utf-8?B?TmtUUEZDMG1OUjFad2xJWnh2R2NuQkFXdk8zL1BtWTRueGxxc3lkWGZJWXVo?=
 =?utf-8?B?VVlOVFRiaDcwWE55Q2dtM0JESEx4UXZCR29DRDd5M3dYdExMUUFwQUowL2pp?=
 =?utf-8?B?eDF3TnRodVZ2NExMVWFkeEk0RTY0Z2pOSTNrOXkvWWVqZnNXcnN5NDc2Zmdr?=
 =?utf-8?B?bkI4L2JFVWQzNUJOV0h6cFQ3RFM5YWRWYnJqWkVUVXF4bU9HNE1OeW1xSlJh?=
 =?utf-8?B?Wi9pbmcreFMxNFVhK2hXSVhEY0tvdnpLSFVKMUpYRk9kWmhCQzNjMkVFUmlL?=
 =?utf-8?Q?V6Nm2mc723AdyHl6uFsDTn+PlcQnQNmGqN6t8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(366011)(1800799019)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzY3ejgzN0p4YXI5a3hmaGprODZyQnJndENFelJIWlZjWDdCZkhFVmJ1TVcz?=
 =?utf-8?B?d0J4K3BXYm5DMStyZWp2R2FPVmFHVGVzZlJ6VUMvbXlpQVRJQnRjZXRudzVE?=
 =?utf-8?B?ajJ1ai9IaFJMU1R0dUR6SktlL1NGSk8vWTNOUHpzYmh4c2NBMTZ5ZVJwd25l?=
 =?utf-8?B?Z3c5YnpTYUNpTzk3Qm9CNTJ5ZlpvL3JSVUl4dWhMZW10ZGNDbUFhcGt6T1NZ?=
 =?utf-8?B?dXZycGd1U1k2S3pVWWRPVHBFUXJsL0tLTGsxb2ZvM1FLQ3BwL0ZvTlIvU21D?=
 =?utf-8?B?dHdIbngwcFpkRytyYTI1em01QXltVjByMndUVnpqUWVlVGJEM003ZXk3ZlJ2?=
 =?utf-8?B?cEpTd3pBUkYwQlpKSkdvS2ZrL0xQdzBaREhsQzVzVkJXTExXRjFOTnJhOE1V?=
 =?utf-8?B?TFJXTE9jenN1dkVMTndLZkJnNU1Ic3lmb0NrQXk2NGx3bW81dGJoSk4zN28v?=
 =?utf-8?B?SDk5WTFsbWRzNy9RNkErVk9zUWxPYnFzbTRqWTBFTmRDWFNMM09kbHlldlZU?=
 =?utf-8?B?ei81cTZabWpEVy9zMGwrVTd3NWk4WjVsdC8vSFltWklieFkxMzFvcERLTWpE?=
 =?utf-8?B?S0VmT2tvVnkwdEErYndUa3d2ejA3UGtrVGpyQlRPM1Jqb0VFdTFEK2RydXhH?=
 =?utf-8?B?aTdwZTZlZk0rNGIvY3dtSnY4Mk5sRkpRSk1DRUxISDFNcnZJUnQyaUhkTUx5?=
 =?utf-8?B?UjNXdEt4QjIrSHRJSzFXT2o2aTdIQmVTM3YzM3ozYS8yZHZkRHprVzl0WHd3?=
 =?utf-8?B?WmE5WnBmaUhac2svR05kL2ZsK25vcElJTmMzcWNSSDNoNTI1bjdidHhLcWJ5?=
 =?utf-8?B?am9FRTNVN0NMWUw3V3pSLzc2ZlhPVW5oaUdJNHNtbUdDVlBLNDVFdXA5aTRh?=
 =?utf-8?B?NlpFeFFpYk0zMURQaDk3NGRkREM5ZkRIZ0FmOGUwaTJsMGNjK1NkQWttSHlh?=
 =?utf-8?B?cThTbFU0NWtGUjVONHVjYk1oWi9ZRXBSNGZVQ2VwL2Uzc1QxSWUyaTRVbFMw?=
 =?utf-8?B?aHVwcUlCbnhRcWdxeXpndnhOV0x3M0RpU2g3UXo1TG0yV09xZExjYVR1ajhS?=
 =?utf-8?B?QUpKeGEzWkFleDU0V0JteWZLMGtqbG14dk45Y1JheERJQnRiaU8xb1F2SEtv?=
 =?utf-8?B?V0Ixa2xvbWNyc1Z4ZzVTWDBVMnV0ZnpRZlI5M005SW1hRzhOUU11M3BlOGJT?=
 =?utf-8?B?UnRCQ2tlTkMxQlBnQ3EvdVBFTUFrd2dEbmFsQmwyYTZoZDRyZ3MzYlN3Mmtz?=
 =?utf-8?B?aFBqLzZNQzVRNDJScVJXZTJGV1hrOThHN3Z0cFVPRi81RUlBSnJLMGkzNldm?=
 =?utf-8?B?SEsyVDNzcjExYW9VNUVYbFhJMDlkR2Q5NENwU0ZYTjJtOExUV3AwdG1kVDFt?=
 =?utf-8?B?Y1RXQWdOL1VweEozZjZSYzhKWmJ5Z01ieWl6UHBUd3V4ak1obXFDNlVrY0ZZ?=
 =?utf-8?B?UmFCT3ljYzdaZVBDSkEvV2J5dHFUbXZ2ZURXRHVreVVieTU0L0NON3prSjNY?=
 =?utf-8?B?V09yck43OGRhK0JBM1dhdDFWUDBhblRvMnprKzlFR1MvL1VrRmV5dnA5L1NL?=
 =?utf-8?B?NXFrcHMxRXgxSXBuZ3IydkxqQktmTGR0bjVzVUxQOWxvTGEvTHhJZ1dMWW55?=
 =?utf-8?B?OU9KdUs4RTByMGJFaGdadmxEMzJ6Zk5NOVN3cXBJUTE2MzZUVCtVNk00NkFn?=
 =?utf-8?B?YU5vMEJWdzkzck1lMjhKcXN6UFpEdkVxaFlVbEU1QVhCYnlFeTFuZmZ0WC84?=
 =?utf-8?B?MGlRaDRpcXJSSDdPUHNWWUhDMkdjbHczWC8xaG92MmRVSDl5Z3NKd2hHYVV3?=
 =?utf-8?B?L3RPR3VQMi82eURtclhheU9xSHRMcUhxRVM3V3ZRV05kS25iYThUUUw3WWgz?=
 =?utf-8?B?TlRyMGxtZUFNS2pKNXhLaHBBWnZrU3ZWRmhsMVdURlZjam5VSURaVVN6WWlu?=
 =?utf-8?B?Q0xNNDVlblZHdFF0amYrSDVrRjNiNUxaYm5ZMi8xamlQYUVUVTAzYzhQcEd4?=
 =?utf-8?B?VzZ1ekVZNElMRE1vVUNKd3o2OCtsSWliZDEyQTdBc0Q0T0JwdEZCUWs0Wkh2?=
 =?utf-8?B?S2N6MzM3bmdHMDY0SnRIMU1haWFoRHlnWVZDdVFkVyswYnVxZG55azcxbit1?=
 =?utf-8?Q?BO58=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b20bba0-781d-4af0-a918-08dc8c3128ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:16:34.7825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8D3JKXoymw2nW1jC3aO8xbIqBUv5zu+IiILvrbwnJhyuMeEAxjMa1rCVZAlwiOB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZWFuIEFuZGVyc29uIDxzZWFu
LmFuZGVyc29uQGxpbnV4LmRldj4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMTMsIDIwMjQgODoz
MiBQTQ0KPiBUbzogUGFuZGV5LCBSYWRoZXkgU2h5YW0gPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1k
LmNvbT47IExhdXJlbnQNCj4gUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJk
LmNvbT47IGxpbnV4LQ0KPiBwaHlAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogVmlub2QgS291
bCA8dmtvdWxAa2VybmVsLm9yZz47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2ltZWssIE1pY2hhbCA8bWljaGFs
LnNpbWVrQGFtZC5jb20+Ow0KPiBLaXNob24gVmlqYXkgQWJyYWhhbSBJIDxraXNob25Aa2VybmVs
Lm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA0LzRdIHBoeTogenlucW1wOiBBZGQgZGVi
dWdmcyBzdXBwb3J0DQo+IA0KPiBPbiA2LzEzLzI0IDA1OjIwLCBQYW5kZXksIFJhZGhleSBTaHlh
bSB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogU2Vh
biBBbmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBsaW51eC5kZXY+DQo+ID4+IFNlbnQ6IE1vbmRheSwg
TWF5IDYsIDIwMjQgMTA6MzEgUE0NCj4gPj4gVG86IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQu
cGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT47IGxpbnV4LQ0KPiA+PiBwaHlAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KPiA+PiBDYzogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz47IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPj4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+ID4+IEtpc2hv
biBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkBrZXJuZWwub3JnPjsgU2VhbiBBbmRlcnNvbg0KPiA+
PiA8c2Vhbi5hbmRlcnNvbkBsaW51eC5kZXY+DQo+ID4+IFN1YmplY3Q6IFtQQVRDSCB2MiA0LzRd
IHBoeTogenlucW1wOiBBZGQgZGVidWdmcyBzdXBwb3J0DQo+ID4+DQo+ID4+IEFkZCBzdXBwb3J0
IGZvciBwcmludGluZyBzb21lIGJhc2ljIHN0YXR1cyBpbmZvcm1hdGlvbiB0byBkZWJ1Z2ZzLiBU
aGlzDQo+ID4+IGlzIGhlbHBmdWwgd2hlbiBkZWJ1Z2dpbmcgcGh5IGNvbnN1bWVycyB0byBtYWtl
IHN1cmUgdGhleSBhcmUNCj4gY29uZmlndXJpbmcNCj4gPj4gdGhlIHBoeSBhcHByb3ByaWF0ZWx5
Lg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29u
QGxpbnV4LmRldj4NCj4gPj4gLS0tDQo+ID4+DQo+ID4+IENoYW5nZXMgaW4gdjI6DQo+ID4+IC0g
VXNlIGRlYnVnZnNfY3JlYXRlX2Rldm1fc2VxZmlsZQ0KPiA+Pg0KPiA+PiAgZHJpdmVycy9waHkv
eGlsaW54L3BoeS16eW5xbXAuYyB8IDQwDQo+ID4+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKykNCj4gPj4NCj4g
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3hpbGlueC9waHktenlucW1wLmMgYi9kcml2ZXJz
L3BoeS94aWxpbngvcGh5LQ0KPiA+PiB6eW5xbXAuYw0KPiA+PiBpbmRleCBiODZmZTJhMjQ5YTgu
LjI1MjBjNzVhNGE3NyAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9waHkveGlsaW54L3BoeS16
eW5xbXAuYw0KPiA+PiArKysgYi9kcml2ZXJzL3BoeS94aWxpbngvcGh5LXp5bnFtcC5jDQo+ID4+
IEBAIC0xMyw2ICsxMyw3IEBADQo+ID4+ICAgKi8NCj4gPj4NCj4gPj4gICNpbmNsdWRlIDxsaW51
eC9jbGsuaD4NCj4gPj4gKyNpbmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+DQo+ID4+ICAjaW5jbHVk
ZSA8bGludXgvZGVsYXkuaD4NCj4gPj4gICNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiA+PiAgI2lu
Y2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiA+PiBAQCAtMTIzLDYgKzEyNCwxNSBAQA0KPiA+PiAg
I2RlZmluZSBJQ01fUFJPVE9DT0xfRFAJCQkweDQNCj4gPj4gICNkZWZpbmUgSUNNX1BST1RPQ09M
X1NHTUlJCQkweDUNCj4gPj4NCj4gPj4gK3N0YXRpYyBjb25zdCBjaGFyICpjb25zdCB4cHNndHJf
aWNtX3N0cltdID0gew0KPiA+PiArCVtJQ01fUFJPVE9DT0xfUERdID0gInBvd2VyZWQgZG93biIs
DQo+ID4NCj4gPiBQcm90b2NvbCBzYXlpbmcgcG93ZXJlZCBkb3duIHNlZW1zIGNvbmZ1c2luZy4N
Cj4gPiBTaG91bGQgd2Ugc2F5IE5vbmUgb3IgTm9uZShwb3dlciBkb3duKT8NCj4gDQo+IEVpdGhl
ciB3b3JrcyBJIGd1ZXNzLiBJJ20ganVzdCBtYXRjaGluZyB0aGUgZGVmaW5lLg0KDQpOb25lIHNl
ZW1zIGZpbmUgLSB3ZSBjYW4gcmVzcGluIGlmIHRoZXJlIGFyZSBubyBvYmplY3Rpb25zLg0KPiAN
Cj4gPj4gKwlbSUNNX1BST1RPQ09MX1BDSUVdID0gIlBDSWUiLA0KPiA+PiArCVtJQ01fUFJPVE9D
T0xfU0FUQV0gPSAiU0FUQSIsDQo+ID4+ICsJW0lDTV9QUk9UT0NPTF9VU0JdID0gIlVTQiIsDQo+
ID4+ICsJW0lDTV9QUk9UT0NPTF9EUF0gPSAiRGlzcGxheVBvcnQiLA0KPiA+PiArCVtJQ01fUFJP
VE9DT0xfU0dNSUldID0gIlNHTUlJIiwNCj4gPj4gK307DQo+ID4+ICsNCj4gPj4gIC8qIFRlc3Qg
TW9kZSBjb21tb24gcmVzZXQgY29udHJvbCAgcGFyYW1ldGVycyAqLw0KPiA+PiAgI2RlZmluZSBU
TV9DTU5fUlNUCQkJMHgxMDAxOA0KPiA+PiAgI2RlZmluZSBUTV9DTU5fUlNUX0VOCQkJMHgxDQo+
ID4+IEBAIC03ODgsNiArNzk4LDM0IEBAIHN0YXRpYyBzdHJ1Y3QgcGh5ICp4cHNndHJfeGxhdGUo
c3RydWN0IGRldmljZSAqZGV2LA0KPiA+PiAgCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiA+
PiAgfQ0KPiA+Pg0KPiA+PiArLyoNCj4gPj4gKyAqIERlYnVnRlMNCj4gPj4gKyAqLw0KPiA+PiAr
DQo+ID4+ICtzdGF0aWMgaW50IHhwc2d0cl9zdGF0dXNfcmVhZChzdHJ1Y3Qgc2VxX2ZpbGUgKnNl
cSwgdm9pZCAqZGF0YSkNCj4gPj4gK3sNCj4gPj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBzZXEt
PnByaXZhdGU7DQo+ID4+ICsJc3RydWN0IHhwc2d0cl9waHkgKmd0cl9waHkgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4gPj4gKwlzdHJ1Y3QgY2xrICpjbGs7DQo+ID4+ICsJdTMyIHBsbF9zdGF0
dXM7DQo+ID4+ICsNCj4gPj4gKwltdXRleF9sb2NrKCZndHJfcGh5LT5waHktPm11dGV4KTsNCj4g
Pg0KPiA+IERvIHdlIHNlZSBhbnkgbmVlZCBmb3IgdGhpcyBsb2NrPyBUaGlzIGZ1bmN0aW9uIHNp
bXBseSByZWFkIGh3IHJlZ2lzdGVyDQo+ID4gL3BoeSBtZW1iZXJzIGFuZCBkZWNvZGVzIGl0Lg0K
PiANCj4gSXQncyB0byBwcm90ZWN0IGFnYWluc3QgbW9kaWZpY2F0aW9ucyB0byBndHJfcGh5LT5y
ZWZjbGsgYW5kIC0+aW5zdGFuY2UuDQoNClJlZmNsb2NrIGFuZCBpbnN0YW5jZSBpcyBhc3NpZ25l
ZCBpbiB4bGF0ZSB3aGljaCBpcyBub3QgcHJvdGVjdGVkIGJ5IGFueQ0KTG9jay4gIEFsc28geHBz
Z3RyX3BoeV9pbml0ICgpIHVzZXMgYSBkaWZmZXJlbnQgZ3RyX211dGV4LiBTbyB3YW50DQp0byB1
bmRlcnN0YW5kIHRoaXMgcGh5LT5tdXRleCBuZWVkLg0KDQo+IA0KPiBUaGVzZSBhcmUgYWNjZXNz
ZWQgdW5kZXIgbG9jayBlbHNld2hlcmU7IHRoaXMgaXMgbm90IGEgZmFzdCBwYXRoIGFuZCBJIGRv
bid0DQo+IHdhbnQgdG8gaGF2ZSB0byByZWFzb24gYWJvdXQgdGhlIHNlbWFudGljcyB3aGVuIHVz
aW5nIGEgbXV0ZXggaXMgZGVmaW5pdGVseQ0KPiBjb3JyZWN0Lg0KPiANCj4gLS1TZWFuDQo+IA0K
PiA+PiArCXBsbF9zdGF0dXMgPSB4cHNndHJfcmVhZF9waHkoZ3RyX3BoeSwgTDBfUExMX1NUQVRV
U19SRUFEXzEpOw0KPiA+PiArCWNsayA9IGd0cl9waHktPmRldi0+Y2xrW2d0cl9waHktPnJlZmNs
a107DQo+ID4+ICsNCj4gPj4gKwlzZXFfcHJpbnRmKHNlcSwgIkxhbmU6ICAgICAgICAgICAgJXVc
biIsIGd0cl9waHktPmxhbmUpOw0KPiA+PiArCXNlcV9wcmludGYoc2VxLCAiUHJvdG9jb2w6ICAg
ICAgICAlc1xuIiwNCj4gPj4gKwkJICAgeHBzZ3RyX2ljbV9zdHJbZ3RyX3BoeS0+cHJvdG9jb2xd
KTsNCj4gPj4gKwlzZXFfcHJpbnRmKHNlcSwgIkluc3RhbmNlOiAgICAgICAgJXVcbiIsIGd0cl9w
aHktPmluc3RhbmNlKTsNCj4gPj4gKwlzZXFfcHJpbnRmKHNlcSwgIlJlZmVyZW5jZSBjbG9jazog
JXUgKCVwQylcbiIsIGd0cl9waHktPnJlZmNsaywgY2xrKTsNCj4gPj4gKwlzZXFfcHJpbnRmKHNl
cSwgIlJlZmVyZW5jZSByYXRlOiAgJWx1XG4iLCBjbGtfZ2V0X3JhdGUoY2xrKSk7DQo+ID4+ICsJ
c2VxX3ByaW50ZihzZXEsICJQTEwgbG9ja2VkOiAgICAgICVzXG4iLA0KPiA+PiArCQkgICBwbGxf
c3RhdHVzICYgUExMX1NUQVRVU19MT0NLRUQgPyAieWVzIiA6ICJubyIpOw0KPiA+PiArDQo+ID4+
ICsJbXV0ZXhfdW5sb2NrKCZndHJfcGh5LT5waHktPm11dGV4KTsNCj4gPj4gKwlyZXR1cm4gMDsN
Cj4gPj4gK30NCj4gPj4gKw0KPiA+PiAgLyoNCj4gPj4gICAqIFBvd2VyIE1hbmFnZW1lbnQNCj4g
Pj4gICAqLw0KPiA+PiBAQCAtOTM3LDYgKzk3NSw4IEBAIHN0YXRpYyBpbnQgeHBzZ3RyX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4+DQo+ID4+ICAJCWd0cl9waHkt
PnBoeSA9IHBoeTsNCj4gPj4gIAkJcGh5X3NldF9kcnZkYXRhKHBoeSwgZ3RyX3BoeSk7DQo+ID4+
ICsJCWRlYnVnZnNfY3JlYXRlX2Rldm1fc2VxZmlsZSgmcGh5LT5kZXYsICJzdGF0dXMiLCBwaHkt
DQo+ID4+ID5kZWJ1Z2ZzLA0KPiA+PiArCQkJCQkgICAgeHBzZ3RyX3N0YXR1c19yZWFkKTsNCj4g
Pj4gIAl9DQo+ID4+DQo+ID4+ICAJLyogUmVnaXN0ZXIgdGhlIFBIWSBwcm92aWRlci4gKi8NCj4g
Pj4gLS0NCj4gPj4gMi4zNS4xLjEzMjAuZ2M0NTI2OTUzODcuZGlydHkNCj4gPg0KDQo=

