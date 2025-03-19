Return-Path: <linux-kernel+bounces-567353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DD2A68501
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3020F880149
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDA4212B0E;
	Wed, 19 Mar 2025 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X/Auh/Yv"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA6145355;
	Wed, 19 Mar 2025 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742365075; cv=fail; b=FvxGnVfzlN0ZCa7TqRTeJwwNdWSouI3V9Lc8AfyVPEnx7PdmjunfnqBuMOvL40Xd/zoN/OV+Wj6iqHZOsbS1EXqLCTNLCuAdjw7DTMhoFa0Y6Amu7wC+a1TKICodksFzdRdM2etawW37GuA5O0kHvd8iKyJaI1sDd6bxjPfzSfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742365075; c=relaxed/simple;
	bh=j+kf92F5yUB9zt5VvwYEYtYlJtY3aeWR6/H7CQ4yBm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JvIINUK+qHMKSLE97hBy+tuX3yRAWJg3Ya/Tg7qeV+Z6gbe5J+CWSe+jzcYOTSfp4EbdRaRft9SdvKTz+PQPfe1PR56VuH7fV8It7KhPkAmYcXwClSRCoK/HWDyHWZFF/Rh/Z8YQ3NLppbj2RC7sJY5MQQiVnb5nvLkNXqxzHJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X/Auh/Yv; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNjRhME4ULI/5TF8WpVCyBE2RsIeWai9LQF62YSBMS89UXUTZSTQlusVopIXXY1641xcBJxcDkXEZMQ+9ckUPkWpWRXTPr2zBnmHkSPifg0ghK+knBYitHpVAQLm+kr3xrA2IsdWpVne4t3hDmsCOX9fvHCPOpn35QNBNAMsGaiuvVkbr4A9lHORszfyLDgjmdI71PHVfBAwxUF0uylz8f/Q7t3jFy/qY9JGfe3Y9HOMtSEaJpGu8Nr6BOrnoUmKg29b2whmEqUFcYbkyZwwPkFb2p+8j0PGjjrG9t6oxnYTQeOagv62gfmGq03ENtTB74Z1oMoQjldKMrsyLEIVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+kf92F5yUB9zt5VvwYEYtYlJtY3aeWR6/H7CQ4yBm4=;
 b=ZZYReDvOJtPS+TL6gOpPqHTRoAq+WwEDsEDrxwXSYVTxNPSMm4Oc2mWQSeO0T9kGipwZfS7KqpcndE9X+Zwn+/nRH9+7V/lC6AvxDmzFvod+uSqeQs386kESslOeYQpAvTm4TaFFBGk2Le22WS4iNVcesLj/Y+NK0DoDSaLr/7u0yvtJSZImO9qumqeFRStmIP4k6fzGU5nVfcSWotD4PacYVF/qcqaZifpZT1mnBPX8aqn7AwS6WIsnlqFlTyqomknJ583g7rbSLCkAXrC4dK5QvO5wPJDchZBMBBOd76tbeGq0+5FBwf7Vvmz1UsBBdD6+r2nMRuGNdQhGAUyIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+kf92F5yUB9zt5VvwYEYtYlJtY3aeWR6/H7CQ4yBm4=;
 b=X/Auh/YvSHWkkGAwIjnp17KqsPVVqsoeJy7TxrmPjqGh+Z/8uEEHSPF+RSnd9gB1dP3aIPbFrXhfPDyAsoatKJthmv5/CcrC3vKY9IlNJ7UtP8MQY7m4ckVul2l99yq2ggcYxdUWLpoHADkBI7mqh0YB0JKGH3V6LoWHgZIHX2o=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 06:17:50 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 06:17:50 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>, "amitrkcian2002@gmail.com"
	<amitrkcian2002@gmail.com>, Bernhard Frauendienst <kernel@nospam.obeliks.de>
Subject: RE: [PATCH v12 3/3] mtd: Add driver for concatenating devices
Thread-Topic: [PATCH v12 3/3] mtd: Add driver for concatenating devices
Thread-Index: AQHbd9MxLQsfHKHRn06jkLCPeMCORrN5TCNcgADfGyA=
Date: Wed, 19 Mar 2025 06:17:50 +0000
Message-ID:
 <IA0PR12MB769956849D2B41827F0B5B53DCD92@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20250205133730.273985-1-amit.kumar-mahapatra@amd.com>
	<20250205133730.273985-4-amit.kumar-mahapatra@amd.com>
 <8734fa8hed.fsf@bootlin.com>
In-Reply-To: <8734fa8hed.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ca09f48c-8064-4276-af44-4145a88b16c1;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-19T05:12:01Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|CY5PR12MB6179:EE_
x-ms-office365-filtering-correlation-id: a88722ba-0940-4e33-4bf8-08dd66adc675
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3dVajZsNFFNc1lUV01wVTRqcjFjVmtrMUpVVFJTQldyZG0ycjU0N3pLWUpM?=
 =?utf-8?B?c1lEamxMT0ZUL3h3NHU1SmZxNGVvSTZBR1dTWWd4cldHYTBja05Pa0JZV0ov?=
 =?utf-8?B?WnZ1N1N4RlBOWmgzK2FXNXpZRzJZRVFBbGxWM1NTUmFnbURZL3Z1Zm9wN3hh?=
 =?utf-8?B?R21oQzFDNFNpR3l5QW50UHU4NmU0ODZHcTJaV2dKckxvWWowSDFjWmJTbWVB?=
 =?utf-8?B?czhCcmlqTzZ4RE53ZU9oMEFRTG5OUk9SZ1RDallRS1ZsQkpvQ0I5YjhiblND?=
 =?utf-8?B?TDlsTW9BcUNJTlpPM05uelh6LzVGSENUN1RyQ1JWUjR6b0hYSk02a0dxTW5W?=
 =?utf-8?B?NTFTTVdqTll2OGV5dHJ4bjY3WXM2M0Jnd2lwbEdYeitIQmQwVjFUemhMTG4r?=
 =?utf-8?B?bzIyOUFodExiL2hzb3F1bTZRVDN6RCtmMWtEZlpHb0xkaGRsVHJiUUFZdk5m?=
 =?utf-8?B?cEhhRlM5MjlQbzNGK2pFeDRvNk1TU0dsaktqeHRkcFpwSzdEalJWdVNGdkl4?=
 =?utf-8?B?ZXRPUkFiTjg0Qm9JK0RFS2ltRW9JR25ReVpFTXozNmRYeUp3TmIxTVo4c1NU?=
 =?utf-8?B?UDNpT3BKUkg0OXpZTEtmTHFTbmFYeFo2czZQengzM0ZYRE5RN3BZSDRvK2VR?=
 =?utf-8?B?R1VuL2c2TVhEWWRhcEt5NFFVb2I0bkN1eG4wcWhmUllJcFNYbjlqVW1lcTJF?=
 =?utf-8?B?dEhCQjNESklLNzZFS2k3clFNVXVmeDZQV2pseDFrV2gzRnNLY1h0c1FsYW5X?=
 =?utf-8?B?TlV5VTJvMDZOMG8zTGVGNkJoNTd0U0VsMWJ4K1RERkZTZkxYMS9oK0ttWDF4?=
 =?utf-8?B?VHNUNGluVGpDc0tmYkVDdWllRHkyZUE5anhGTC9hK0JsdWl1TXJZc0laYS8r?=
 =?utf-8?B?T0k0ZHhEa3FsK2pLekpXZmtzcnJoWGMyVmljMmdzRVZ6YnUrd09yVXpRQ3hE?=
 =?utf-8?B?bHdDaDZKeTBYVDhCNkNYWS9JOEhMNWIwY1lVZUZaN1VVMktBa3pIbnJ5djRM?=
 =?utf-8?B?d3RCbkRoRDNvN3lFNk1kUWhVdGFtbnA0c2xlZDAycVMxa2ljMDJreVdFS2J2?=
 =?utf-8?B?aWxnNjBnSFJLZXBRQThKUTI1NmoyY0w0TjZsZmhHaDFHSVhxdVlQcWtMOGZ4?=
 =?utf-8?B?Y1h1SDJrNmtHbGsrWmRzK3lCdkJ0YWVLUU54cFA5NDJrTXVNOUwrM2YrZkk4?=
 =?utf-8?B?SzFDekoyc0FqaFZUbHJLMkkyelZUMGRRNXRITTRPdDIyN1NBVmRlY0lOWDNm?=
 =?utf-8?B?R1JKWnRkZGN5VlErZmlqbUQxK2NBcnFLM1FIOUQ2Tnlpak5SUHMvTzJKbGE5?=
 =?utf-8?B?a0J3ekVXMkx0ZStDb3FMQ01NcjBMMzR3Tm5JaEszZi9tRXVkY2tWcGprZFhZ?=
 =?utf-8?B?UU1iRkNZQVI3RUV3RFMvMzhZRWRoV0Nzbnl0QUZQUmhwMDFzTk9qUTBzQkVn?=
 =?utf-8?B?blY0YzlEQWxJcWZXcEUrM2EvWGk3b1hNNTdJSHNQR3kzL012bC96WE1xZVdM?=
 =?utf-8?B?VzNEYm5PdTJ1Y1pmaG9DZlFac3hxcWVrc0l0UWd3cGMyc25OZlRpMlp3VEh2?=
 =?utf-8?B?STE4UjI1MElMcWRTbTlsdEJDbHVkWDIvM3dWVnEvNHFuU3BnaUJrZ0taWW9x?=
 =?utf-8?B?Y1dYdEVNNU05WTBqVUs3VjV1L2FjNEU5aHJzbFFyWUJnMCtWMVBQTEdqMnlC?=
 =?utf-8?B?eDVuL2VTdGZNbStPM3dFSDl2aVoveDdDaFVsaHdzOE1Ydno4NWpxQXZFcERS?=
 =?utf-8?B?RGsxNlhLRWwxa3dVZXp6OVZ0TE53QmRZdTdSY2VkZTVwa2RDT3NDRSsvcjdK?=
 =?utf-8?B?cHQzVGExcThvYUtGdUxTQ2ErN3JVNUEyWUZmOW8rS0VOdmUwQkJYbmRaWnBi?=
 =?utf-8?B?dHN3QlZ0VWJpM0FCdVRrdmRpSjJVU2VyYjFGSGNhajdpRzNwMWtMeXpoS1FU?=
 =?utf-8?Q?l9SwTiitLZ0CCKA5LUVd8WCKsdvnNVQm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEd1VXBNZHJsRmN3Umtqa2oycGlwZjYrTHIzL05FOFYrOUFnRmpNM1dhMGZW?=
 =?utf-8?B?QlZEcWtlTTRjSEZObGtBa2NIaSs2b1o1NDk0QjJZU1M2eEJ6amh3QXJDYUIz?=
 =?utf-8?B?ZnQ0aVE5YU9KYmlNSEVVYktLMGVrUHVWSVd6c1dFamxXSUNRR2gxQzJqT3RB?=
 =?utf-8?B?WjQvQXEzWGN3OGIrNXJsbjkzL0NwTGl0U3c1YzRKNHdPcVFrditXd3AxWGJW?=
 =?utf-8?B?SUc2ekJqWVNrWWxPWkJVNFNFL2xGd0p1Uk4xQWl5Wmhwall6ajBsZHZXdnMv?=
 =?utf-8?B?TjRWM1UxNWZZdjFIYzhabUpTWnR4ZTgwQUhsS2IvckpSSVRsVjFWbkZLc3Zy?=
 =?utf-8?B?MXIxdGg0ZFI1aTNMTjdlZXpNM2UvQzJmdTY4RzJBTEdKNVJhOWl1dmxPZmE3?=
 =?utf-8?B?YUkydFgrU3R2dDFrTmJiMWx1d3lLbU5xcXVPK2ZOdmdKenpaM1ZHYmwrWlZ6?=
 =?utf-8?B?N1Ewa3ZuZnRhenpQc3VOUi91STczR3p2bjd5QjVMaUtEaS90UnFDOEFZL2JH?=
 =?utf-8?B?MFlIZDRKZkpOMHMzYjlwYndMS2Qxa3I2dFJ4VDJLS2EvYkVvS05NN3JKbmRy?=
 =?utf-8?B?eHo2aFJ0ZFNaZ1ZIN2c1WFkrZU11U1ZpNEVXV04yamVHa1ZtdXZMQ3VwYXhS?=
 =?utf-8?B?RHBSZzM1WU9IL3U0MUgzb294b2dMbjhncUt0VGUzSjhXcGROZ2NKdEh5RFJJ?=
 =?utf-8?B?Q3ZrWU9tdUJqdXZLRHpPc0hPdmpuL1RFVHR1WWlVMXcwU0huTEJCQ3BzRjBZ?=
 =?utf-8?B?VWxwUWVDeFNERlhtYi9CajhGS2lnNjh5ZjFudThsWU12M3Q3Q1NUcWtBT0FI?=
 =?utf-8?B?ekZjOEh1ZXh4VDFyNmViN1dtZHJESlZSNjk0engvbkc0M2NWeHRFNWY0c0s1?=
 =?utf-8?B?T1RsS3VCSWliNnBFVmVGcjZNQlZFcXorNFN4K0NETHhqSFo0TE9XblpnSG8z?=
 =?utf-8?B?TE9DL2hjQ3lnQ21zTUdMNWxuanNsdytHVmp1bGpHSGN1eTZaM0J6VDFYam05?=
 =?utf-8?B?T1J3WlZ1WGVlMkxHK05zT1BIcHAvUjQ0VlZXQW82YUkzNnE5NVBXZ2QreXhK?=
 =?utf-8?B?a2tTWWZKRDhLZU5CbXM3RU5HY1JkZUlRZlYwUkgzSy9WaXdkTXRwdVJGSndS?=
 =?utf-8?B?QzZISFhLVEIrb0NEWjBFODhsT2s5cm55V2dDakM4R1BFbEJuWDJxNHc2OFFh?=
 =?utf-8?B?Q01iNGw2bzllWkpFcE5uS1VxblNQY0lvK0dIUmZzQmx6SGxCM3dPWWtMK2ZS?=
 =?utf-8?B?NjIrVjI4UTA5RkYyaEU1dkVVRTZGQi9kZHJldGM2aGZWRlp5V1dwOU44WFZJ?=
 =?utf-8?B?d3JscXpjdnZ2aHBETktSamoramxnRVRoMk1ubTd3R2NvaDEvdEZHSCtBcm5a?=
 =?utf-8?B?RVFKejdDSWNSWVUrWDNZenNhWHdZbmVkSHVXZmtGb2pQY09lSGRpNkVtRDRZ?=
 =?utf-8?B?QlUwMHZ6eDRERkJxbEZ3S3VETklTTjNvZ0UyR29lN3VGUEFBQUhrRUhWMFFa?=
 =?utf-8?B?Z2hWdFRPaFFLNFM5bkJ3cDJtTVpnamxtUVVDbllBT09qZXpLSlJtT1I0a2Rj?=
 =?utf-8?B?aTJLVllXQlNodHVDclpEY2htWWlXUFVTSDhBVUQyVjFOeHNyTXVyRlRWVk90?=
 =?utf-8?B?SHNnclE4bk93WVQ5UE5vMkI5R1lnbTlnZUYwY1ZUa0RFK2p6Z056ejA3STVC?=
 =?utf-8?B?WHM4Q3ZUaU1BdEt0ekpOM0JReGN1NDJqc2ttcWk3VXg5UHNPWE9jemVTQktE?=
 =?utf-8?B?R3l2SVhQWUFJZjRsL2dsU0ZNRlcya0pLb0dLdEJSS09KSm1uUUZBTE04UVpT?=
 =?utf-8?B?ZVhnemM5d3VyR2Q5K05VaThhK0tsU0tqek16V3RlNzBtd2IrUURBamZUYkNu?=
 =?utf-8?B?OFNTYmNjZW5Qc2Rxc2lZRDhJR2ZIdTRaVVlmeGZQNDVSU01tM1FiR21mbThU?=
 =?utf-8?B?WE1CVU9zSVJ5ZGJWeHlYWnp6OHI5UGFPSU0wckh0eGpuT0xkTUFYOG5mZm9M?=
 =?utf-8?B?eXpXb09tNW9rRGdhSFo3YjQrWElWd0xDRXJWaWJGTmVYVy9jMzYwSll2elg5?=
 =?utf-8?B?UjNocWU0SGpvVVVmRTRkbmVlcjRpT1pUQWtzQzlaVEZHQldJSTFPYzhJYlJM?=
 =?utf-8?Q?6PW4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7699.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88722ba-0940-4e33-4bf8-08dd66adc675
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 06:17:50.1357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAgcUVYrKZol2S0TOlKYFDPXYV0NK1sKd+fV0m6Yx6fMDSlyyV9UtfJrbiQtO7ppUNy740CTS/WveFAcJ1h/hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGVsbG8gTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIE1hcmNoIDE4LCAyMDI1IDk6MjMgUE0NCj4gVG86IE1haGFwYXRyYSwgQW1pdCBLdW1hciA8
YW1pdC5rdW1hci1tYWhhcGF0cmFAYW1kLmNvbT4NCj4gQ2M6IHJpY2hhcmRAbm9kLmF0OyB2aWdu
ZXNockB0aS5jb207IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPiBjb25v
citkdEBrZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGdpdCAo
QU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPjsNCj4gYW1pdHJrY2lhbjIwMDJAZ21haWwuY29tOyBC
ZXJuaGFyZCBGcmF1ZW5kaWVuc3QgPGtlcm5lbEBub3NwYW0ub2JlbGlrcy5kZT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MTIgMy8zXSBtdGQ6IEFkZCBkcml2ZXIgZm9yIGNvbmNhdGVuYXRpbmcg
ZGV2aWNlcw0KPg0KPiBPbiAwNS8wMi8yMDI1IGF0IDE5OjA3OjMwICswNTMwLCBBbWl0IEt1bWFy
IE1haGFwYXRyYSA8YW1pdC5rdW1hci0NCj4gbWFoYXBhdHJhQGFtZC5jb20+IHdyb3RlOg0KPg0K
PiA+IEludHJvZHVjaW5nIENPTkZJR19WSVJUX0NPTkNBVCB0byBzZXBhcmF0ZSB0aGUgbGVnYWN5
IGZsb3cgZnJvbSB0aGUNCj4gPiBuZXcNCj4NCj4gQ09ORklHX01URF9WSVJUX0NPTkNBVA0KPg0K
PiA+IGFwcHJvYWNoLCB3aGVyZSBpbmRpdmlkdWFsIHBhcnRpdGlvbnMgd2l0aGluIGEgY29uY2F0
ZW5hdGVkIHBhcnRpdGlvbg0KPiA+IGFyZSBub3QgcmVnaXN0ZXJlZCwgYXMgdGhleSBhcmUgbGlr
ZWx5IG5vdCBuZWVkZWQgYnkgdGhlIHVzZXIuDQo+DQo+IEkgYW0gbm90IGEgYmlnIGZhbiBvZiB0
aGlzIGNob2ljZS4gV2UgaGFkIGlzc3VlcyB3aXRoIGhpZGluZyB0aGluZ3MgdG8gdGhlIHVzZXIg
aW4gdGhlDQo+IGZpcnN0IHBsYWNlLiBDb3VsZCB3ZSBmaW5kIGEgd2F5IHRvIGV4cG9zZSBib3Ro
IHRoZSBvcmlnaW5hbCBtdGQgZGV2aWNlcyBhcyB3ZWxsIGFzDQo+IHRoZSB2aXJ0dWFsbHkgY29u
Y2F0ZW5hdGVkIHBhcnRpdGlvbnM/DQoNClN1cmUsIEkgdGhpbmsgdGhhdCBjYW4gYmUgZG9uZSwg
YnV0IEkgdG9vayB0aGlzIGFwcHJvYWNoIHRvIGhpZGUgdGhlDQpvcmlnaW5hbCBkZXZpY2VzIGJl
Y2F1c2UgQm9yaXMgbWVudGlvbmVkIGluIFsxXSB0aGF0IHdlIGFyZSBjcmVhdGluZw0KdGhlIG9y
aWdpbmFsIHBhcnRpdGlvbnMgZXZlbiB0aG91Z2ggdGhlIHVzZXIgcHJvYmFibHkgZG9lc24ndCBu
ZWVkDQp0aGVtLiBJIGJlbGlldmUgaGUgaXMgcmlnaHQsIGFzIEkgY2FuJ3QgdGhpbmsgb2YgYW55
IHVzZSBjYXNlIHdoZXJlDQp0aGUgdXNlciB3b3VsZCByZXF1aXJlIHRoZSBpbmRpdmlkdWFsIGRl
dmljZXMgaW5zdGVhZCBvZiB0aGUNCmNvbmNhdGVuYXRlZCBkZXZpY2UuDQoNClsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1tdGQvMjAxOTEyMDkxMTM1MDYuNDEzNDFlZDRAY29sbGFi
b3JhLmNvbS8NCg0KPg0KPiA+IFNvbHV0aW9uIGlzIGZvY3VzaW5nIG9uIGZpeGVkLXBhcnRpdGlv
bnMgZGVzY3JpcHRpb24gb25seSBiZWNhdXNlIGl0DQo+ID4gZGVwZW5kcyBvbiBkZXZpY2UgYm91
bmRhcmllcy4NCj4gPg0KPiA+IFN1Z2dlc3RlZC1ieTogQmVybmhhcmQgRnJhdWVuZGllbnN0IDxr
ZXJuZWxAbm9zcGFtLm9iZWxpa3MuZGU+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBNaXF1ZWwgUmF5bmFs
IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFtaXQgS3Vt
YXIgTWFoYXBhdHJhIDxhbWl0Lmt1bWFyLW1haGFwYXRyYUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL210ZC9LY29uZmlnICAgICAgICAgICB8ICAgOCArKw0KPiA+ICBkcml2ZXJzL210
ZC9NYWtlZmlsZSAgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvbXRkL210ZF92aXJ0X2Nv
bmNhdC5jIHwgMjU0DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
ZHJpdmVycy9tdGQvbXRkY29yZS5jICAgICAgICAgfCAgIDcgKw0KPiA+ICBkcml2ZXJzL210ZC9t
dGRwYXJ0LmMgICAgICAgICB8ICAgNiArDQo+ID4gIGluY2x1ZGUvbGludXgvbXRkL2NvbmNhdC5o
ICAgIHwgIDI0ICsrKysNCj4gPiAgNiBmaWxlcyBjaGFuZ2VkLCAzMDAgaW5zZXJ0aW9ucygrKQ0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tdGQvbXRkX3ZpcnRfY29uY2F0LmMNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9LY29uZmlnIGIvZHJpdmVycy9tdGQvS2Nv
bmZpZyBpbmRleA0KPiA+IDc5NmEyZWNjYmVmMC4uM2RhZGU3YzQ2OWRmIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbXRkL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL210ZC9LY29uZmlnDQo+
ID4gQEAgLTIwNiw2ICsyMDYsMTQgQEAgY29uZmlnIE1URF9QQVJUSVRJT05FRF9NQVNURVINCj4g
PiAgICAgICB0aGUgcGFyZW50IG9mIHRoZSBwYXJ0aXRpb24gZGV2aWNlIGJlIHRoZSBtYXN0ZXIg
ZGV2aWNlLCByYXRoZXIgdGhhbg0KPiA+ICAgICAgIHdoYXQgbGllcyBiZWhpbmQgdGhlIG1hc3Rl
ci4NCj4gPg0KPiA+ICtjb25maWcgTVREX1ZJUlRfQ09OQ0FUDQo+ID4gKyAgIHRyaXN0YXRlICJW
aXJ0dWFsIGNvbmNhdGVuYXRlZCBNVEQgZGV2aWNlcyINCj4gPiArICAgaGVscA0KPiA+ICsgICAg
IFRoZSBkcml2ZXIgZW5hYmxlcyB0aGUgY3JlYXRpb24gb2YgYSB2aXJ0dWFsIE1URCBkZXZpY2UN
Cj4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb2YgdmlydHVh
bCBNVEQgZGV2aWNlcw0KPg0KPiA+ICsgICAgIGJ5IGNvbmNhdGVuYXRpbmcgbXVsdGlwbGUgcGh5
c2ljYWwgTVREIGRldmljZXMgaW50byBhIHNpbmdsZQ0KPiA+ICsgICAgIGVudGl0eS4gVGhpcyBh
bGxvd3MgZm9yIHRoZSBjcmVhdGlvbiBvZiBwYXJ0aXRpb25zIGxhcmdlciB0aGFuDQo+ID4gKyAg
ICAgdGhlIGluZGl2aWR1YWwgcGh5c2ljYWwgY2hpcHMsIGV4dGVuZGluZyBhY3Jvc3MgY2hpcCBi
b3VuZGFyaWVzLg0KPiA+ICsNCj4NCj4gLi4uDQo+DQo+ID4gK3N0YXRpYyBpbnQgX19pbml0IG10
ZF92aXJ0X2NvbmNhdF9jcmVhdGVfam9pbih2b2lkKSB7DQo+ID4gKyAgIHN0cnVjdCBtdGRfdmly
dF9jb25jYXRfbm9kZSAqaXRlbTsNCj4gPiArICAgc3RydWN0IG10ZF9jb25jYXQgKmNvbmNhdDsN
Cj4gPiArICAgc3RydWN0IG10ZF9pbmZvICptdGQ7DQo+ID4gKyAgIHNzaXplX3QgbmFtZV9zejsN
Cj4gPiArICAgY2hhciAqbmFtZTsNCj4gPiArICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgIGxp
c3RfZm9yX2VhY2hfZW50cnkoaXRlbSwgJmNvbmNhdF9ub2RlX2xpc3QsIGhlYWQpIHsNCj4gPiAr
ICAgICAgICAgICBjb25jYXQgPSBpdGVtLT5jb25jYXQ7DQo+ID4gKyAgICAgICAgICAgbXRkID0g
JmNvbmNhdC0+bXRkOw0KPiA+ICsgICAgICAgICAgIC8qIENyZWF0ZSB0aGUgdmlydHVhbCBkZXZp
Y2UgKi8NCj4gPiArICAgICAgICAgICBuYW1lX3N6ID0gc25wcmludGYoTlVMTCwgMCwgIiVzLSVz
JXMtY29uY2F0IiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uY2F0LT5z
dWJkZXZbMF0tPm5hbWUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmNh
dC0+c3ViZGV2WzFdLT5uYW1lLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b25jYXQtPm51bV9zdWJkZXYgPiBNSU5fREVWX1BFUl9DT05DQVQNCj4gPw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiLSsiIDogIiIpOw0KPiA+ICsgICAgICAgICAgIG5hbWUg
PSBrbWFsbG9jKG5hbWVfc3ogKyAxLCBHRlBfS0VSTkVMKTsNCj4gPiArICAgICAgICAgICBpZiAo
IW5hbWUpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgIG10ZF92aXJ0X2NvbmNhdF9wdXRfbXRk
X2RldmljZXMoY29uY2F0KTsNCj4gPiArICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVN
Ow0KPiA+ICsgICAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgICAgc3ByaW50ZihuYW1l
LCAiJXMtJXMlcy1jb25jYXQiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgY29uY2F0LT5zdWJk
ZXZbMF0tPm5hbWUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICBjb25jYXQtPnN1YmRldlsxXS0+
bmFtZSwNCj4gPiArICAgICAgICAgICAgICAgICAgIGNvbmNhdC0+bnVtX3N1YmRldiA+IE1JTl9E
RVZfUEVSX0NPTkNBVCA/DQo+ID4gKyAgICAgICAgICAgICAgICAgICAiLSsiIDogIiIpOw0KPiA+
ICsNCj4gPiArICAgICAgICAgICBtdGQgPSBtdGRfY29uY2F0X2NyZWF0ZShjb25jYXQtPnN1YmRl
diwgY29uY2F0LT5udW1fc3ViZGV2LA0KPiBuYW1lKTsNCj4gPiArICAgICAgICAgICBpZiAoIW10
ZCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAga2ZyZWUobmFtZSk7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVOWElPOw0KPiA+ICsgICAgICAgICAgIH0NCj4gPiArDQo+ID4g
KyAgICAgICAgICAgLyogQXJiaXRyYXJ5IHNldCB0aGUgZmlyc3QgZGV2aWNlIGFzIHBhcmVudCAq
Lw0KPg0KPiBIZXJlIHdlIG1heSBmYWNlIHJ1bnRpbWUgUE0gaXNzdWVzLiBBdCBzb21lIHBvaW50
IHRoZSBkZXZpY2UgbW9kZWwgZXhwZWN0cyBhDQo+IHNpbmdsZSBwYXJlbnQgcGVyIHN0cnVjdCBk
ZXZpY2UsIGJ1dCBoZXJlIHdlIGhhdmUgdHdvLiBJIGRvIG5vdCBoYXZlIGFueSBoaW50cyBhdCB0
aGUNCj4gbW9tZW50IG9uIGhvdyB3ZSBjb3VsZCBzb2x2ZSB0aGF0Lg0KPg0KPiA+ICsgICAgICAg
ICAgIG10ZC0+ZGV2LnBhcmVudCA9IGNvbmNhdC0+c3ViZGV2WzBdLT5kZXYucGFyZW50Ow0KPiA+
ICsgICAgICAgICAgIG10ZC0+ZGV2ID0gY29uY2F0LT5zdWJkZXZbMF0tPmRldjsNCj4gPiArDQo+
ID4gKyAgICAgICAgICAgLyogUmVnaXN0ZXIgdGhlIHBsYXRmb3JtIGRldmljZSAqLw0KPiA+ICsg
ICAgICAgICAgIHJldCA9IG10ZF9kZXZpY2VfcmVnaXN0ZXIobXRkLCBOVUxMLCAwKTsNCj4gPiAr
ICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgZ290byBkZXN0cm95
X2NvbmNhdDsNCj4gPiArICAgfQ0KPiA+ICsNCj4gPiArICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+
ICtkZXN0cm95X2NvbmNhdDoNCj4gPiArICAgbXRkX2NvbmNhdF9kZXN0cm95KG10ZCk7DQo+ID4g
Kw0KPiA+ICsgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtsYXRlX2luaXRjYWxs
KG10ZF92aXJ0X2NvbmNhdF9jcmVhdGVfam9pbik7DQo+DQo+IFRoZSBjdXJyZW50IGltcGxlbWVu
dGF0aW9uIGRvZXMgbm90IHN1cHBvcnQgcHJvYmUgZGVmZXJyYWxzLCBJIGJlbGlldmUgaXQgc2hv
dWxkIGJlDQo+IGhhbmRsZWQuDQo+DQo+ID4gK3N0YXRpYyB2b2lkIF9fZXhpdCBtdGRfdmlydF9j
b25jYXRfZXhpdCh2b2lkKSB7DQo+ID4gKyAgIG10ZF92aXJ0X2NvbmNhdF9kZXN0cm95X2pvaW5z
KCk7DQo+ID4gKyAgIG10ZF92aXJ0X2NvbmNhdF9kZXN0cm95X2l0ZW1zKCk7DQo+ID4gK30NCj4g
PiArbW9kdWxlX2V4aXQobXRkX3ZpcnRfY29uY2F0X2V4aXQpOw0KPiA+ICsNCj4gPiArTU9EVUxF
X0xJQ0VOU0UoIkdQTCIpOw0KPiA+ICtNT0RVTEVfQVVUSE9SKCJCZXJuaGFyZCBGcmF1ZW5kaWVu
c3QgPGtlcm5lbEBub3NwYW0ub2JlbGlrcy5kZT4iKTsNCj4gPiArTU9EVUxFX0FVVEhPUigiQW1p
dCBLdW1hciBNYWhhcGF0cmEgPGFtaXQua3VtYXItDQo+IG1haGFwYXRyYUBhbWQuY29tPiIpOw0K
PiA+ICtNT0RVTEVfREVTQ1JJUFRJT04oIlZpcnR1YWwgY29uY2F0IE1URCBkZXZpY2UgZHJpdmVy
Iik7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL210ZGNvcmUuYyBiL2RyaXZlcnMvbXRk
L210ZGNvcmUuYyBpbmRleA0KPiA+IDcyNGY5MTdmOTFiYS4uMjI2NGZlODE4MTBmIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvbXRkL210ZGNvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbXRkL210
ZGNvcmUuYw0KPiA+IEBAIC0zNCw2ICszNCw3IEBADQo+ID4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4
L210ZC9tdGQuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L210ZC9wYXJ0aXRpb25zLmg+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9tdGQvY29uY2F0Lmg+DQo+ID4NCj4gPiAgI2luY2x1ZGUgIm10ZGNv
cmUuaCINCj4gPg0KPiA+IEBAIC0xMDY3LDYgKzEwNjgsMTIgQEAgaW50IG10ZF9kZXZpY2VfcGFy
c2VfcmVnaXN0ZXIoc3RydWN0IG10ZF9pbmZvICptdGQsDQo+IGNvbnN0IGNoYXIgKiBjb25zdCAq
dHlwZXMsDQo+ID4gICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiAgICAgfQ0KPiA+
DQo+ID4gKyAgIGlmIChJU19FTkFCTEVEKENPTkZJR19NVERfVklSVF9DT05DQVQpKSB7DQo+DQo+
IE1heWJlIElTX1JFQUNIQUJMRSgpIGlzIG1vcmUgcmVsZXZhbnQ/DQoNCkFncmVlZA0KDQpSZWdh
cmRzLA0KQW1pdA0KPg0KPiA+ICsgICAgICAgICAgIHJldCA9IG10ZF92aXJ0X2NvbmNhdF9ub2Rl
X2NyZWF0ZSgpOw0KPiA+ICsgICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgZ290byBvdXQ7DQo+ID4gKyAgIH0NCj4gPiArDQo+ID4gICAgIC8qIFByZWZlciBw
YXJzZWQgcGFydGl0aW9ucyBvdmVyIGRyaXZlci1wcm92aWRlZCBmYWxsYmFjayAqLw0KPiA+ICAg
ICByZXQgPSBwYXJzZV9tdGRfcGFydGl0aW9ucyhtdGQsIHR5cGVzLCBwYXJzZXJfZGF0YSk7DQo+
ID4gICAgIGlmIChyZXQgPT0gLUVQUk9CRV9ERUZFUikNCj4NCj4gVGhhbmtzLA0KPiBNaXF1w6hs
DQo=

