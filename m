Return-Path: <linux-kernel+bounces-547086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D435FA502E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287251667BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1173250BE9;
	Wed,  5 Mar 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="u9iNdr+j"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2050.outbound.protection.outlook.com [40.107.249.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310724C66B;
	Wed,  5 Mar 2025 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186202; cv=fail; b=JKHXqI4mRTjEGQwZxxc71YEEYnOHZXGiJbuqhI8Q8DvtGkjwWsYH+Nn2m2uSm5rsU/euajwPv+/foOXJzq6+3nNi2eDIGyuoDTO6N55TE2ePKCME9Q4ORlq8DsaxsgQMK0N1I70bE1ppT7PqMrD9j/wKISyprHh+my6CbmiXsBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186202; c=relaxed/simple;
	bh=K2x+Qn8zeUHVHMPrOxpdAhI1v9IOVXpG3QGtNwHiHOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MJJc7mFvm8eee+jgpDe5dUapAOALYF20yp653RZjcKY/+LX0Y0crQgsOP6D6Iy0BWovaO5mKYUUagElzmNGk35rH8BcYnuZWYfXi5NcEqW19KlAhgpVRBh9y/YjyU8PB0wrLYcLW4wTggSnD8Ihoq1jElxbM6IbWyckPwnD/heE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=u9iNdr+j; arc=fail smtp.client-ip=40.107.249.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzEk/0UAePPUodFboxYx57bXfDa6vnmzJieA14b03kdwJqiAhm3B8XnB50SuO54JMduMQzDXII0KojqMfSiVQz5Pa17Ug1qPqAlidEwRTpSYaWHpsDhCIPKz1tWyE2joz1wXMYNj5f8xg8Bzby/HtZpCm3lu6KAOh3rHRAnh14OXnUeIzTn/QLzDoHL7sbC71cqJU4jEIMaTTDwPduUi07Ev9ILUo8Uny29biOleQvO25OZTNaR/xtbBlDjfHBBjwzCnqpX+lvw7i/wdDI6SYzKLIrzd0FM1fEJXl0zMt1AzeO+n1BLqnQT2zgxRLPBXzc7NbJV4RXWvMO9q3VHu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2x+Qn8zeUHVHMPrOxpdAhI1v9IOVXpG3QGtNwHiHOY=;
 b=B/BTVGjYy+regaQ8Z+hsGlcVBClBYySt9+gMVF54PKxpEXFLTyJZPW97INvyZU4n/vsdP5BCrwI9pTXBCWCiVWgVyfZCapJLtUXgvXqYtLGar3te38CBiuFP1EWuvY4PYWnGNhu+p55xcfEvvjoOGk2a49sXPMxLAZwDu7e4+wWTX67GsEFU25TW4OZUzzyFMTxoWakUBvguGDQ+zVNlrN+AbAZwX44dK3aHygAIVuEa5WYDmQtUtvlmhZc1wyC7q6gfcRIIlG4NvUDOJr/9XoPUP0L/dHCk1mx93rmwWOpK9g4wywVVtm20arOOUkADA6Pz3X8nQPkD20Jr5wqCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2x+Qn8zeUHVHMPrOxpdAhI1v9IOVXpG3QGtNwHiHOY=;
 b=u9iNdr+jfMJPeN4qdUOnDLrukifM2qRvpOd46ZT8clyqrybgisF2MyIDNWdxlAivLr5MWxGqnjnAe72PK27dsN8qErZE+ovmn1ieYxxtNuuafXHWpM/0tpchRDrzcR261wVwioS6E9+3ggn2M0Es4G2WmQFMZxV6uTvx5ksQVcTu06m3bqH6P2vMukCkFKrCwbHoYQUofroNEzViTRTAJt0Trlo3ZE4doNknGiC2ModHoDNS5ZC4i7sR9j7an3M/tETa22aCUHh7LiIPbcP6x493Zi22nngmDdONbASasR29ExvlLFeZ8qD2B5J8I7fEDN3MncjAVHt3+niPvhzlmQ==
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by GVXPR04MB10803.eurprd04.prod.outlook.com (2603:10a6:150:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Wed, 5 Mar
 2025 14:49:55 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 14:49:55 +0000
From: "Florin Leotescu (OSS)" <florin.leotescu@oss.nxp.com>
To: Daniel Baluta <daniel.baluta@gmail.com>, Frank Li <frank.li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: "Florin Leotescu (OSS)" <florin.leotescu@oss.nxp.com>, Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michael Shych
	<michaelsh@nvidia.com>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Viorel Suman <viorel.suman@nxp.com>, Carlos
 Song <carlos.song@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "festevam@gmail.com" <festevam@gmail.com>, Florin
 Leotescu <florin.leotescu@nxp.com>
Subject: RE: [PATCH v3 1/3] dt-bindings: hwmon: Add Microchip emc2305 yaml
 schema
Thread-Topic: [PATCH v3 1/3] dt-bindings: hwmon: Add Microchip emc2305 yaml
 schema
Thread-Index: AQHbjd3byn0+dbEVn0q23j6/m6JDKg==
Date: Wed, 5 Mar 2025 14:49:55 +0000
Message-ID:
 <DU7PR04MB11163EE82B1F5228F797A0D64FFCB2@DU7PR04MB11163.eurprd04.prod.outlook.com>
References: <20250304162136.1963384-1-florin.leotescu@oss.nxp.com>
 <20250304162136.1963384-2-florin.leotescu@oss.nxp.com>
 <Z8cp1xoIXT8lgD8T@lizhi-Precision-Tower-5810>
 <CAEnQRZCT4vfFBApv+C3Wp17Fk0-Rwx36h4eCTTygaXFYFipEGg@mail.gmail.com>
In-Reply-To:
 <CAEnQRZCT4vfFBApv+C3Wp17Fk0-Rwx36h4eCTTygaXFYFipEGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU7PR04MB11163:EE_|GVXPR04MB10803:EE_
x-ms-office365-filtering-correlation-id: 1e364a7f-5e21-4a37-231a-08dd5bf4fe5e
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFZOSWZQM2pLUUJTdHpjSmVRZ0NGYkFwL1VaRUJhRnU4czRKbE41cXlyck5G?=
 =?utf-8?B?d0l3ZUg4UmVoQ2E3MmJkUVduY3FvVDh6Q21yUnFrd0tsMkord3BXT3NMdmJO?=
 =?utf-8?B?dHNuS2lFWG9QbGlmOWZCUmh3eEVOZ202NjFiNVQ5MXlicjFVWXQ0Yk9WODJB?=
 =?utf-8?B?YldOeVIzSVNHdWRVaHVXRjEyVGtqR0lMSU1jdllNYlpqSzRTU2hHVmQ1eW4y?=
 =?utf-8?B?SE96dENEaWIvNkI1VXJhbE5nKzJiaThzLzhZMVJuZUR0SEt3SUFSNmIyNy9Q?=
 =?utf-8?B?RWpTekh0TTZXZXFCbXBzNFd5Rm9HSjdRZjQwTFl5QmNiS0lzeXppS1ZLSzRm?=
 =?utf-8?B?bnRabW5NWXorUW9WNHRTQ0xTVGUvL0tpR0RlcU1KakszWHd1cnptdWhKUUMz?=
 =?utf-8?B?M2tOT205S0RUTTU4cjdlNUZ0WXVEZjNCSE5lMURmUkZMbFBVK21TNWFsTXI5?=
 =?utf-8?B?WE5JamRJNllpeGF4VlZGN0pXeGVtTTZXRng5b1c0aVdjS3V3eWk0L21OdGJF?=
 =?utf-8?B?UlhQaU5obklWVzRRTWtrSWNLSS9XeklYSng0bi84Ni9qZDQrSTV2SVBUeG8v?=
 =?utf-8?B?YzBJRldHb0VLdWt3cGVxMDdPajkxUHM2YVhKNjdHWXMwNUMxejVNL095MDNX?=
 =?utf-8?B?MGcvUVZTVGxYUkVMcnQvNCswZkdtZzNoaWNQeGdPMVpFMFZWT3k2bnJjYzNS?=
 =?utf-8?B?RHl2RmoxY05Fb2lEVEdZSjV0VjRuMjQya1dTOTU1dG1UZFJ1ZHljY1p5UXV1?=
 =?utf-8?B?ejJQVllmRWV2T0pucDBDU2pVUGFuSVB2UnlmdmczSVZNR0ZNK3lnc2Y5d1pP?=
 =?utf-8?B?NlFiLzh2UHlYRW1aWGJWajdTeEI3cTlDVlp4dVNBSkZtVGxIWFI1TkRQdUhx?=
 =?utf-8?B?V3hWcTc0eFJtYW5TcVgwZ3lWMDN5a0ZBeXVwMjhtbGhLL2hjL1QwajBLNkxU?=
 =?utf-8?B?SUJSeXdQcVpKa3ppdTlRZVJLYjBlZFFQMDYwTW9pUS95cG5MQjdYclpPYXA2?=
 =?utf-8?B?eGhmZDJZbnM1THcrRStPWDAvc290WjBNOHhRYVVSS1VhbTJyOFBPSnZ0cUNX?=
 =?utf-8?B?NThZcktENWpNUUt2VExORS82M1ZRQ3pLQk8xVVBvaTgwVStYaVl4ZkZLMEN5?=
 =?utf-8?B?NGNIRmZsQzRWWHpyREczbTFpQlZaLy9NZzlKSWhlSWRmalphY1RoQjdYN05l?=
 =?utf-8?B?TnJFdUpYN3dJRlQ4Qks2YlBsaFZYNzJZRkhOTFhrWjBUb1d2SXZQaWROK2FS?=
 =?utf-8?B?VEptdzE3dS8vdDVGTUM0K3dCV1VkVHYydkFvRk8zNzJrOGVDVjZsZWZLbTRC?=
 =?utf-8?B?U3F5dnltTTl3UThsNmJYV1c0NUlmTVB5NHhqVmFwdWxrQ0dUNXlJcVlVcm52?=
 =?utf-8?B?Ymlla1RqWjJPT0VJNWlKcW9rN1lzbk0vUDJNUEVmOGZ0TDN2OGpMZGhrQ0xH?=
 =?utf-8?B?VTRldU5yQW1TazJmUE5BZW10Y0cvZUVCYm5sOVJYQytqL2NaNjhQVkRsaS9u?=
 =?utf-8?B?MFBxOG8xRUVkVktHdzJoeEtwaTB0N29RcFBockhSdWpjNUVFdGNET1RiYlVJ?=
 =?utf-8?B?bUlMdkcvUjd6RnNacUZ3SjhOSkp1eVJWWFNjVkZ1cDlNenRDNVU4b3RIelor?=
 =?utf-8?B?NnE5T0hObmU3VmtvK2tkU3BRenk4SytmcDNLRkNEQS90Y2JISmRrWDVINTZ4?=
 =?utf-8?B?eFhXNk1uYlhXUzdwTWxrckJlUlN5YU9kYW5EQThsSlI5dGZaUVVoMUdWbWln?=
 =?utf-8?B?b1hxdEduZjlJaHBucU9IbEZjZWdhN01JQkNBSExpT1FJWmNydk5KSlF1TEdJ?=
 =?utf-8?B?akJ4SC8rQjBMUlhEUXhvQWgyblpsTXRqSmRZanFhcWM1OW5ENEE3eFl3b3ZL?=
 =?utf-8?B?eFFxOE1NTVYxWVVGU2pNVDdIT2lVZzcyNU9XdUx1UlpINXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dThpeU52a0FPbHNsYUpDMStScFBqTjZibWZQS2N2M0crbHJhTHpQSUNtdEY5?=
 =?utf-8?B?NmhGVjNiWVZnNm56QVJIc24xaGJzb0p6b2dVeUo3Z29kTUVqVTdUQUx6Z3Rt?=
 =?utf-8?B?ajhkcHluL3ZyaFlHcFZhSWh5ekZJdUJWRzNTYndYemlyamNLYUZXSVI5aVJm?=
 =?utf-8?B?YjNWeGJ4ek91SGh0VEhvblJMTzc0TExvdXlhR1MyVHY2d3g2ZmJtUWtodWNj?=
 =?utf-8?B?YmUrWmk5VGd1Q29qSTMyOUo2bTBSc3ZCRkRpVmFYRWl4Y1dVYlVVaGlrNnN5?=
 =?utf-8?B?TzMrM3g1K3VBOTFPMnlhQVJncWRab3ZvVERSc3BKZ0pYcDNlUnpIUWlXQkQ2?=
 =?utf-8?B?V2NCeUF4Z1cyNFZ5cVFDaTlPYUlQTGRwY05kWGRxRS9PQXlkUERvMmU2WWV2?=
 =?utf-8?B?Zlh4N0hlS0pJNW9DL21YcFMwcW5sZ0NsUUpmd2duMk9PR2FBMm9YN2huNFJn?=
 =?utf-8?B?NnRDQjdUYVVWZ0ZuOTNWalg3SHpwbEpZUDZJcGF4QURlbnZwdGdnL3RwVWMr?=
 =?utf-8?B?S3Jqd1dDYlBqV3BlS1czNEJDamN0eFI1dmZJdXVFVE9PTy9SVCtCbGNHcFoz?=
 =?utf-8?B?UmZUYWtMRzhYWFkyVzdNcUkzV2kwOFJLS3pIV2FzY3N2WnVwRFoyaHdkRnVW?=
 =?utf-8?B?MDdJUVExbDRtL2FjQWRJdlNHWHN6UDJ5MGFyWWlLcWZIOFhTTVh0NkRDRUl0?=
 =?utf-8?B?V2ZPSW15ZGpHcFhGWHJaQ0pOMnRMbjF6NUc4RTE3d3gxTEZlSk1yOUNvV2gr?=
 =?utf-8?B?SWJwdC9VR3JyelJvNkhGc1M4NmswWkFFZS9DanIzOTVuSjRKTFBYYVZ0R3kz?=
 =?utf-8?B?YjNRTXNLOWxvaG5QQzJvQlAzY09teEN1YllrdGtwaGdqK3ZpL2xFNDRyRmJK?=
 =?utf-8?B?UVVsK2lVRGh6TTZvTzBSckd2ZGtXQmkvSnF4aFNZZHdMZisxWlJhM01VYStP?=
 =?utf-8?B?a2RSRmU5RnRBbWJVZmlvaEtWUGcwZHdTUXVPYytBR083SDN5dE9JUnAvMGdV?=
 =?utf-8?B?TVY5dHFtMWV2U3pzR1JWY0ZFWlpFWjJZOWxhdm9pNnJXaUFHN2JXNi9qZVE1?=
 =?utf-8?B?M2FtRkFIZldIOVRBa05iWEgrS2w0WG1xa2s4YklhWUwwZS9uYzFsZnZXUUVU?=
 =?utf-8?B?a29zOXlIanhTR2JpdVk0LzVnZkl1RDVlTG5sRVRJdjYzbnpvY1d6NzQvTG1s?=
 =?utf-8?B?Z2YyKzY2Z0p0OVhxcDNrazZ1eENqcm50VUF2UU02NFBBUDNnaGd1R05xcGM0?=
 =?utf-8?B?eXJ6dEJJdGltZTdmMkZhSk5EN2FyZ2prNXRJdWhOcWRSWEdYbFhVVmdoYjlZ?=
 =?utf-8?B?K21OYnNHOUp2RkRUL0FlZndTMUh4ZmwyNEpJZWhkc2V2QWViTVlLUzhQaHlu?=
 =?utf-8?B?dlBaR1FlMFJ2eHFlbHJmdE43QzVuYnMwSytkUlF4VDBjT0lCY0dsQnBxc1lG?=
 =?utf-8?B?QlpGWWJwTzhXcFppcVVReEZRWkdlYU9CLytqeGJtVkdUMEpqQ3ZZWFVZZ3ZE?=
 =?utf-8?B?T0RKbU81eElIWVA2UW93M3lYUGJNbDRZdERKQ1dwckVYTHpDUU1IK2RFZmVh?=
 =?utf-8?B?WXl5Ujdmc2wybnhZSWc1LzZ3YVpibElGT05XaW5jQ0dWTXBPT0l1MHVnRWZx?=
 =?utf-8?B?WmZ2K3pWdERFVitOZ3dRKzllcWVoT1lkc3drdEhMT2NNUjkxU1BrWkIxV3lm?=
 =?utf-8?B?R2ZPV2hzUkE2dDFSUFVoYkZHQmZ0YkZ1NU41Qmp3ZmQyRGQzQy80dnlFcjg1?=
 =?utf-8?B?cHdZclEwaURkaHhKUW51aHV4eXZ2czliazMwVURoT09IN0ZScE05ZzM0ZlNp?=
 =?utf-8?B?OXoycVNBU0IxQ3RaTlF0VkxkSllaN3dpS1g1NkdWUU9KVmN4a21NZ2tWSkVo?=
 =?utf-8?B?d3I4QUI3bE9laCt4cUlJQm5mRFZjNlh4aHNacHE0OGRNazV3V1dSd1dscG5N?=
 =?utf-8?B?Z0QxRHE3R1hoaWFaQU1FQ00wUEVUcDRTSno5RmdMQWdEcThxcEpHaE9ZUzVw?=
 =?utf-8?B?dXoyQ2JDTk9ZeTBFUXdBaFkvdjBHaVd5TzJMUFdDNUhLeGNwZnlnQ0tBc2No?=
 =?utf-8?B?UkhHOUgrdDFwRkR4ZEcvZ3Bhd0Nkbnl1dWhKc1diOVJFdUJYUnhOaGRPVDU3?=
 =?utf-8?Q?I0DvVXLfDOCaOJWnFstuWePiz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e364a7f-5e21-4a37-231a-08dd5bf4fe5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 14:49:55.4034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5ddYJywyrd6HjHT3wO2DcxFjXZiF0VuxIzjmvcK9Eg475vdVI3QKeG6rnZ1ZbaBdcnzNFw4edlBYqcRtHQEHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10803

SGVsbG8gRnJhbmssIENvbm9yLCBLcnp5c3p0b2YsDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBm
ZWVkYmFjaywgdGltZSBhbmQgcGF0aWVuY2UuIA0KV2Ugd2lsbCBhZGRyZXNzIHRoZSBjaGFuZ2Vz
IGluIFY0Lg0KDQpSZWdhcmRzLA0KRmxvcmluDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQGdtYWlsLmNvbT4gDQpTZW50OiBX
ZWRuZXNkYXksIE1hcmNoIDUsIDIwMjUgMjo0OCBQTQ0KVG86IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPg0KQ2M6IEZs
b3JpbiBMZW90ZXNjdSAoT1NTKSA8ZmxvcmluLmxlb3Rlc2N1QG9zcy5ueHAuY29tPjsgSmVhbiBE
ZWx2YXJlIDxqZGVsdmFyZUBzdXNlLmNvbT47IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVz
Lm5ldD47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9y
K2R0QGtlcm5lbC5vcmc+OyBNaWNoYWVsIFNoeWNoIDxtaWNoYWVsc2hAbnZpZGlhLmNvbT47IGxp
bnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFZpb3JlbCBTdW1hbiA8dmlvcmVsLnN1bWFuQG54
cC5jb20+OyBDYXJsb3MgU29uZyA8Y2FybG9zLnNvbmdAbnhwLmNvbT47IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsgZmVzdGV2YW1AZ21h
aWwuY29tOyBGbG9yaW4gTGVvdGVzY3UgPGZsb3Jpbi5sZW90ZXNjdUBueHAuY29tPg0KU3ViamVj
dDogUmU6IFtQQVRDSCB2MyAxLzNdIGR0LWJpbmRpbmdzOiBod21vbjogQWRkIE1pY3JvY2hpcCBl
bWMyMzA1IHlhbWwgc2NoZW1hDQoNCkhlbGxvIEZyYW5rLCBDb25vciwgS3J6eXN6dG9mLA0KDQpU
aGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMgYW5kIGhlbHAuDQoNCkluIHRoaXMgaW5pdGlh
bCBwYXRjaHNlcmllcyB3ZSBvbmx5IGFkZCBtaW5pbWFsIE9GIHN1cHBvcnQgYW5kIGludHJvZHVj
ZSBhIG1pbmltYWwgYmluZGluZy4NCg0KPiBIb3cgZGlkIHlvdSBwaWNrdXAgdGhlIG1haW50YWlu
ZXIgZW50cnk/DQoNCldlIGdvdCB0aGUgYXV0aG9yIG9mIHRoZSBmaXJzdCBjb21taXQgZm9yIFNl
ZSAwZDg0MDBjNWEyY2UgKCJod21vbjogKGVtYzIzMDUpIGFkZCBzdXBwb3J0IGZvciBFTUMyMzAx
LzIvMy81IFJQTS1iYXNlZCIpDQoNCj4gSWYgb25seSBvbmUgcmVnIFlvdSBjYW4gZ28gdGhyb3Vn
aCB0cml2aWFsLWRldmljZXMueWFtbA0KDQpUaGlzIGlzIG5vdCBhIHRyaXZpYWwgZGV2aWNlIGFz
IHdlIHdpbGwgYWRkIHNvbWUgc3BlY2lmaWMgcHJvcGVydGllcyB3aXRoIG91ciBuZXh0IHBhdGNo
ZXMgKGUuZyBwb2xhcml0eSBldGMpDQoNCj4gTWlzc2luZyBkZXNjcmlwdGlvbnMgb2YgdGhlIGZh
bnMsIG5vPw0KPiBtaXNzaW5nICRyZWYgdG8gZmFuLWNvbnRyb2xsZXIgc2NoZW1hLg0KDQpEbyB3
ZSBuZWVkIHRvIGFkZCB0aGlzIG5vdz8gQXMgdGhpcyBpcyBvbmx5IHRoZSBtaW5pbWFsIGJpbmRp
bmcgc3VwcG9ydC4gV2Ugd2FudCB0byBhZGQgdGhhdCBpbiBhIGZvbGxvdyB1cCBwYXRjaCB3aGVu
IHdlIGdvIGludG8gc3BlY2lmaWNzLg0KDQo+IFRoZSBlbWMyMzAxIGxhYmVsIGhlcmUgY2FuIGJl
IGRyb3BwZWQsIGl0IGlzIG5vdCB1c2VkLg0KDQpXaWxsIGZpeC4NCg0KPiBUaGUgbm9kZW5hbWUg
c2hvdWxkIGJlICJmYW4tY29udHJvbGxlciIsIG5vdCBwd20gaGVyZSBJIGd1ZXNzLg0KDQpTdXJl
LCB3aWxsIGZpeC4NCg0KT24gVHVlLCBNYXIgNCwgMjAyNSBhdCA2OjU24oCvUE0gRnJhbmsgTGkg
PEZyYW5rLmxpQG54cC5jb20+IHdyb3RlOg0KPg0KPiBPbiBUdWUsIE1hciAwNCwgMjAyNSBhdCAw
NjoyMTozNFBNICswMjAwLCBmbG9yaW4ubGVvdGVzY3VAb3NzLm54cC5jb20gd3JvdGU6DQo+ID4g
RnJvbTogRmxvcmluIExlb3Rlc2N1IDxmbG9yaW4ubGVvdGVzY3VAbnhwLmNvbT4NCj4gPg0KPiA+
IEludHJvZHVjZSB5YW1sIHNjaGVtYSBmb3IgTWljcm9jaGlwIGVtYzIzMDUgcHdtIGZhbiBjb250
cm9sbGVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRmxvcmluIExlb3Rlc2N1IDxmbG9yaW4u
bGVvdGVzY3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL2h3bW9uL21pY3Jv
Y2hpcCxlbWMyMzA1LnlhbWwgICAgIHwgNDMgKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgDQo+
ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL21pY3JvY2hpcCxlbWMy
MzA1LnlhbWwNCj4gPg0KPiA+IGRpZmYgLS1naXQgDQo+ID4gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaHdtb24vbWljcm9jaGlwLGVtYzIzMDUueWFtbCANCj4gPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9taWNyb2NoaXAsZW1jMjMwNS55YW1s
DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmNhYzAw
NzVhNjViYg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaHdtb24vbWljcm9jaGlwLGVtYzIzMDUueWFtbA0KPiA+IEBAIC0wLDAg
KzEsNDMgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBP
UiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvc2NoZW1hcy9od21vbi9taWNyb2NoaXAsZW1jMjMwNS55YW1sIw0KPiA+ICsk
c2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4g
PiArDQo+ID4gK3RpdGxlOiBNaWNyb2NoaXAgRU1DMjMwNSBTTUJ1cyBjb21wbGlhbnQgUFdNIGZh
biBjb250cm9sbGVyDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIE1pY2hhZWwg
U2h5Y2ggPG1pY2hhZWxzaEBudmlkaWEuY29tPg0KPg0KPiB3aG8gaXMgaXQ/IGxvb2sgbGlrZSBu
b3QgTWljcm9jaGlwIGFuZCBod21vbiBtYWludGFpbmVyLg0KPg0KPiA+ICsNCj4gPiArZGVzY3Jp
cHRpb246IHwNCj4NCj4gTmVlZG4ndCB8DQo+DQo+ID4gKyAgTWljcm9jaGlwIEVNQzIzMDEvMi8z
LzUgcHdtIGNvbnRyb2xsZXIgd2hpY2ggc3VwcG9ydHMgdXAgIHRvIGZpdmUgDQo+ID4gKyBwcm9n
cmFtbWFibGUgZmFuIGNvbnRyb2wgY2lyY3VpdHMNCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+
ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gbWljcm9jaGlw
LGVtYzIzMDENCj4gPiArICAgICAgLSBtaWNyb2NoaXAsZW1jMjMwMg0KPiA+ICsgICAgICAtIG1p
Y3JvY2hpcCxlbWMyMzAzDQo+ID4gKyAgICAgIC0gbWljcm9jaGlwLGVtYzIzMDUNCj4NCj4gQWNj
b3JkaW5nIHRvIHlvdXIgZHJpdmVyIGNvZGUgbG9vayBsaWtlIGFsbCBjb21wYXRpYmxlIHdpdGgg
DQo+IG1pY3JvY2hpcCxlbWMyMzAxDQo+DQo+IG9uZU9mOg0KPiAgIC0gZW51bToNCj4gICAgICAg
LSBtaWNyb2NoaXAsZW1jMjMwMQ0KPiAgIC0gaXRlbXM6DQo+ICAgICAgIC0gZW51bToNCj4gICAg
ICAgICAgIC0gbWljcm9jaGlwLGVtYzIzMDINCj4gICAgICAgICAgIC0gbWljcm9jaGlwLGVtYzIz
MDMNCj4gICAgICAgICAgIC0gbWljcm9jaGlwLGVtYzIzMDUNCj4gICAgICAgLSBjb25zdDogbWlj
cm9jaGlwLGVtYzIzMDENCj4NCj4gU28geW91ciBkcml2ZXIganVzdCBuZWVkIG9uZSAibWljcm9j
aGlwLGVtYzIzMDEiIGNvbXBhdGlibGUgc3RyaW5nLg0KPg0KPiA+ICsNCj4gPiArICByZWc6DQo+
ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21w
YXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBm
YWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBpMmMgew0K
PiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICNzaXplLWNl
bGxzID0gPDA+Ow0KPiA+ICsNCj4gPiArICAgICAgICBlbWMyMzAxOiBwd21AMmYgew0KPiA+ICsg
ICAgICAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxlbWMyMzAxIjsNCj4gPiArICAgICAg
ICAgICAgcmVnID0gPDB4MmY+Ow0KPg0KPiBJZiBvbmx5IG9uZSByZWc6DQo+IFlvdSBjYW4gZ28g
dGhyb3VnaCB0cml2aWFsLWRldmljZXMueWFtbA0KPg0KPiBGcmFuaw0KPg0KPiA+ICsgICAgICAg
IH07DQo+ID4gKyAgICB9Ow0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4NCg==

