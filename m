Return-Path: <linux-kernel+bounces-548287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEE4A542DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3517F16BFF3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9ED1A23AD;
	Thu,  6 Mar 2025 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4hxahaQ8"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A719C554;
	Thu,  6 Mar 2025 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243217; cv=fail; b=j/t4cS9sJUhf0nZcufurIhVGt4pEXDbN2Pl49Umi5drXiFGhUWNN64q0kgd78HnA4EX5as71NaIgrw6Npz27EtphSWUTstCHFvksKosOdpI3kOi8UO7EnPYnq8hKT3yLefiOv2uOHAk+lIyB2JscXzHkReS+bKHghKghTCvxnsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243217; c=relaxed/simple;
	bh=Na9XZN51kL01ipzaU5dTyLjyXMzmp4hiSxNKS5gH08w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVSE1ahPzgfOIvQAOty4ry0SPk5sJ15fVmp+PV84LaYM9+60FfZyyqFhEWNHxvn/t13Sl8C1b2evnV80IQDAavqledDoQ/yU31EfyjLEJBhPtlEIo0Px2iCwTPnRsI/Z76v6/cneB6TsaGNpIZx9nqHvPPqU7OjNL46US1mli+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4hxahaQ8; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsjBzxV9/LERegQaNnZdTW8MzBHS4hdjcXd/vnOYfbxkkDy2xSoByBSKuuzlRDnileM6iQSC4i5ioY26Tu6zwtzxafbwztGgyuz9xRiw3sriXZfl254QBYlR8EgD6A2LZ2eD1lxqg4Zqk/iCCfM4GrGCf1edjIfD9hRdl3p3Q3Yij9wGa+DkyWMa8YiYBGBGnqEIvjKZvuAvThcmXQT6ykk/H0IRfX2rHv/k11l5OQVSOrQcLdwCY+VsZVzxxPk/G1SG1Sp0H6rFIddLspCPZI3UxgWMk3+BCJFlFs6fXdWpid5zFd0/AyX4aGs55siT2E4SCMwKZ6YuuGwr40Q4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Na9XZN51kL01ipzaU5dTyLjyXMzmp4hiSxNKS5gH08w=;
 b=DrbaeonaHaEtc9oD/6qc1kmHvbw5uOsZSE1AoYZ8Wxqo7EkbdUpqL8heYwV5pO1CcbX4kY5BX00LZXBrhKlAvguoqXZNskBqrU06xEI5noV/e/ONu5LBp4ejp67XC6ca+5EObT67zf3fWfy+PIQHyEmKqXouHONi46HRIEJ5Btk3eBVEOK1udILsaJSxrDwVVmt8SVbm/qry10VIHcSCqnpsWGIwQlBJopIkvYcabyQRwSOJBZ3CZeZ8UURw54JsbN42t4pPb1fDcN2+YCmyUkTxAazGVqq1RGYJGdF8aq7wHKK0oDtDrkXzgRa7jUtqB4GqO+e8IuTOsG8SQLc5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Na9XZN51kL01ipzaU5dTyLjyXMzmp4hiSxNKS5gH08w=;
 b=4hxahaQ8LeT9a5aBxa5MdtBDwPAZguixdKPpstGUyXOy6DCQfRetazH/Hrr4beSMBSuelUMvpu4sKSVwFUmtc5VL4N75JgWQdNZPVH5NdaV7A0z3aIwQzJASaFp+eo1QpR7A9T3nNXrnGkq2eRVWuJudoiTH0ZWrkW8RxxodoC4wMfz7tuolSfC4K1LftZrQM1FOi3zWDoOXDJDcyr6dOW8fvQKMJCSUuHoOfOY1El1idL2XCP3NBnvyLBzpwEzrS1rlm0Gz9lgJUFgUbEpMgE69z7QDs1mVU7zydCI/z7M3+/dczqpoSKWQvclCNy67EyHDYzRc+7eYWGM4/nOoZQ==
Received: from PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16)
 by DM6PR11MB4547.namprd11.prod.outlook.com (2603:10b6:5:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 06:40:10 +0000
Received: from PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d]) by PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d%3]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 06:40:10 +0000
From: <Manikandan.M@microchip.com>
To: <miquel.raynal@bootlin.com>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <tudor.ambarus@linaro.org>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <richard@nod.at>,
	<vigneshr@ti.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <Varshini.Rajendran@microchip.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address
Thread-Topic: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address
Thread-Index: AQHbjbXbTNB5hzSu106BrFJRNUN76LNkVYiigAFUQYA=
Date: Thu, 6 Mar 2025 06:40:10 +0000
Message-ID: <84b1def7-fba7-4f29-a49b-d117efe26d26@microchip.com>
References: <20250305100134.1171124-1-manikandan.m@microchip.com>
 <87ikonydym.fsf@bootlin.com>
In-Reply-To: <87ikonydym.fsf@bootlin.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6609:EE_|DM6PR11MB4547:EE_
x-ms-office365-filtering-correlation-id: 2ca76b00-f2b6-4c8c-fc14-08dd5c79be09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzVxMGZPaUJVVmwzY2lSL1Z5V1VhbzFJZXd6bytiNnJLSitGajFzTTBRemc2?=
 =?utf-8?B?VnU2WU5UcmtJeG9CUUdhTWgxd1NrNzFoWWlTYXBTWW8vcStTdG9CeWJzMzRR?=
 =?utf-8?B?SGl6dXVWR3pORWJqcFJZSGkrem50NW9zV0o1YnBzNXpnVnU3MXZuVWFmWEJu?=
 =?utf-8?B?QmdFd0s5Rm9xdE5xTjdUTUJKYW81T1N4amNPVzcyQ3dOUGRoSDVZM3V0SDgr?=
 =?utf-8?B?YStad1h5elhKUFF5a1NJb2RYYTlrZjh0eFRaMmFpalZ4emt2cXcyV0hVdUpa?=
 =?utf-8?B?K2dXRW01YzhtMUIwQTFERlNzTk5xdG0wUHFtbFFXeFM4L1JtUEcyS1VHMkgw?=
 =?utf-8?B?c1hjYnZyU3kwb25Ibi9QZkJDclRVbGFSai9iTXhKSzdHMzB4V1ZmeUFIb28z?=
 =?utf-8?B?d2NXUS9QYUozbHFtQTBTZ24zdjltUjZFYUU4eVRSakIyYzVCaHY0WkxEOXVl?=
 =?utf-8?B?b21HdEkrcVorYzN0NTErTDRqMGVFUHFxOHhkSkdYUFg0dXdYNURmeTdSYVpR?=
 =?utf-8?B?Q2pNdnB6MWFQa0xweFNmVXdYN2dOQzBjSHRzbXo2OXBHMEdsMEluYzlrMjRk?=
 =?utf-8?B?c1Qyc1JSS01yUkttdmkwR1dPYnJkakh1blM0QTFXSXk2d2lzMnhmWkFpdWtx?=
 =?utf-8?B?OHJwRU1hbW5laERPTEVvWHhRWnVOK0IyR3g2TkVIQ0JzcFlobTFpOEErTTRO?=
 =?utf-8?B?WGxReDdqZGM5bE5oNEtreXJ2dk5XeEFVREdNZjdGZ1JzTmxObDBMZU9Tc1BT?=
 =?utf-8?B?a25UckhVQlpYVFlkTUduQm9PTkZEc1ZFMng5ZlZIS1l2R3FxeUY1T0twTXVW?=
 =?utf-8?B?U2tyMjRaVEZ1RHdJVjdYM2NCckVCeEgrN1F1WjVtdXF6RXhYNk1TL09pSThY?=
 =?utf-8?B?MXI4ZEJrZHFKNy9xNFdueGh0YkJZUGZOOCs2cCtZUFVxaTdSK1BtY1psNjVu?=
 =?utf-8?B?TWh2ODhzUGJzNDVBaEZyTFRDWjJRWVBncTU3NzdhdnVGaHFrMXJselJ1eUFz?=
 =?utf-8?B?YzAvaVQvM1h4cjV1Z002N21tMU1Oa1hMSXg4T2lwMFMvWUdBVVdMQ3ZQeWlW?=
 =?utf-8?B?bFM5TGh1azNlWXkvL251T0p3bERwTk83UnI0VEN2aUlOR21xTXZBblZMSThL?=
 =?utf-8?B?ZUVGNzdLQmpTd1lhY3NKQmR0Rnd4VnJXYmczbWU0M1dVOXdiTS91Qy9BeFlO?=
 =?utf-8?B?K3A3TGFXWGt1UlJDaG5iOWtjVU5wdUdBdE9pYVN6Nm00ZmFBc1MwVVZZNjRh?=
 =?utf-8?B?akhGa2UvVTNXSmdvcm92SitsSXpXZTVzTE4wZXdPZVZNZ0VTQXp5UExNV09C?=
 =?utf-8?B?T3Ruc2pBMFZGc1NrSkQyVW9IZVp6WWxvSjhNNkZXYnZsWkdYYWxIWlMrQkNi?=
 =?utf-8?B?RHJzUU1pNkprcXZNVUc5SkM3elFRZ2krQUtHWDBCNUo3Vm5HNnoyWmsrNXBI?=
 =?utf-8?B?SVc2NDRZRkhIdnhQMnpVRmpPbElVRlBhc0xXYU5MbEFLeHBqY1FqUXBZWURL?=
 =?utf-8?B?WEpscWhLWUlSckhJWW1XdmUwNjVmOHVPaEJ4a2crQXh5bnc4SEVpRUs4SDNv?=
 =?utf-8?B?OWk3MkxYaTZOaHZMYnh6Vm1KVDNKd0hSZW13SVJYSWJoVE5QZUU4UUZZY2s4?=
 =?utf-8?B?U3pPcnU0NFY2cnNNcldTM3I0clpJVE1rYkNGZm4yNnJrVTlMRHA5QWQ1T2o3?=
 =?utf-8?B?bjR4YjkwSTBjRnlmTi8rTU1WL3psZDZuNVdiUUc3dlFiMldCSjVOeDhaQ3Ry?=
 =?utf-8?B?S0o1MHJBaUhZWTUwMmMvRFlBUkpyU1h4VFAzWmtVamxwSTVwMFlQRVk3b2J6?=
 =?utf-8?B?Vm1rUStRcUJEcUhiUWZ3WURHNjFJbjZsVXh4VkhPNHpXL3BLUzZ4aHVQK255?=
 =?utf-8?B?V1NzbENsQjNNMVhvd25OTjZBTC9iK2dtWk0vK1U4Z1NyMDBUWkN6R2xMb0p0?=
 =?utf-8?Q?51OSOiDDCgBF0NO6Zj2fM/3oz6xpgO1p?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6609.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0NHTkl5NHNmY1NPanBQSStTdEIyL1NnQWQ4d2krRFNsbjgySktCbVNJaFpB?=
 =?utf-8?B?bFlETzFSVzdvT3pWNHJXdkdwV0ZCQXhra2RPc2JWYmx2dVBselkvS2haVUtR?=
 =?utf-8?B?VnZmT1lSNEx5VHRWVnovbktNbkhGR0R6SHZCTzdQamtJWWt0SEdYYWc4RVRu?=
 =?utf-8?B?OHBwNzUrY0VxUnUxNW9BNWlBRERWUjZ6RTdMVFRkTnNvQWJYeTlaWXFtRDlX?=
 =?utf-8?B?L3RYNHJjWU5aeTlLQzZGUVUyVWRpUE41dE9pSDRLOUN1RUx6d1NnZzRYbXVy?=
 =?utf-8?B?R3gyZVl4RlVMU3FBeE9lT0UxQjJtNXZ0UkxLOTBHQ1Q5amU5SDI0cU9sSXN2?=
 =?utf-8?B?aXBYcVB4RHUzS1lzWWVQSko5TC8zVVp2ZmJpdW4ySU5GM1F6UlFFc1ZTQVRG?=
 =?utf-8?B?Qmk0Y3k4Z0hyMUpSZVhPTklTZVVKVzdiQS9GVGhLRHIzR2o5dk5GQndZeTc0?=
 =?utf-8?B?dVFBZXBlck01WGI1Vk1XMWQyYlFqWGJaTzRtTDVxVlB4Vk1YU3BuN2MxNUNG?=
 =?utf-8?B?RlhzVGxZNWt0QnlNc1JjL25KTnhCeEdHYms3djVEL3RPNk92T1ZDeDVUU2ZF?=
 =?utf-8?B?OHc2YzFBZ3RhcVAwNkJIYXp6eW5aelRVL2tJSmhldGJjSzd5VmN6bGUxNW5i?=
 =?utf-8?B?ZlZRb1RQT3d5ZXBEcDlpajRIUkxqQ3Q3VEhQOWo2MVhCNFNOem5KaGo5eC9z?=
 =?utf-8?B?bHc2My9nR2lEQ1oreGVyQ1FEcWJWSm50dWdXS3lVM25iZG44a1hsNjE2Rkx6?=
 =?utf-8?B?ZThVQmlWbFZyTWRjQml3VmF6ZTdMSFNQZWdsdm5NMWxrVGRuT0wzK2s5eTRS?=
 =?utf-8?B?WjRsOWp5WU05aEkzdHdlMjZlODJFNlFwcnFOUXBCblp5Y0RpaTZTbnNFcGR5?=
 =?utf-8?B?KzJXUlBCMnVDZmxEMHRTenE1eHRtUWxZZFpQSTVhUkNEN0pvNWNIV2tOS2NH?=
 =?utf-8?B?YVo2TG5JYnlYOTI5M0RpK0dpVThJM3ZqOWxxSHhLWTY4YjZlSFV4VlN5RHJH?=
 =?utf-8?B?MHNEdHkzR0xPU2dJa2tLRGc3RjBuRFYwMllNQUJsZE1pSWVkcGx1SExKcklk?=
 =?utf-8?B?dm43a3JsM096WU5LSmNZTjFHMnhMM0M0SStvTDNmSnZXa3RtYWxvVGVtVVBT?=
 =?utf-8?B?cnB0dzc4bW1CNWlweEkzbVp0VkYydGFHemNuZTFpd1J3UHBOOXB6V04xbTNX?=
 =?utf-8?B?TVI0dmFGaU9GOHR2NHQ1dkRQYldLT2xzSXd6UGtGazBuS0tRU0NkdXJMdFFn?=
 =?utf-8?B?MyttVGpBODlVYWF5dW9lNUw2blV5dXY2RE5RYVR4Ty9DTnZ0VWR1bXZpVS9B?=
 =?utf-8?B?VDFOTzhoRy9GanFBSXpTblI1WURKZVp2eldnYlY2UG1VKzVPNElGY3EvV2p1?=
 =?utf-8?B?L2ZRZlNETDRVeW0raE9kck5pNnE2ZVp6b3JjcXlIRzNWRGVCMTNMSUEyN0ZU?=
 =?utf-8?B?dHFMN1RGM3hKV0FnaVNoQTAvem0vZDMvbGo4UVppT2Rra0ZMOUdLTldjVlBr?=
 =?utf-8?B?bnVoYlMxTU1jbGlPRHJOeU91aHQzM0VjZGVnRWEvcEtJZWRhS29wTGZ3YTdK?=
 =?utf-8?B?RHRnRm83Y2N4VkpjblNpZXdBUGFCTi9IR24wbThHZmcxVWtuU1M1RlA1dmFW?=
 =?utf-8?B?d3Zheng4eDN0dXNUM2JCV3EyaFZ3UnBrZkRMSXUrd2ZDSm5TNnBMczMxTWJB?=
 =?utf-8?B?djJQdHZTUEJMR2N1UHRWditKRnZsVVVJek1hdldGTGEzMjBHdXVFNEZQQ0pN?=
 =?utf-8?B?bUYxRWU2TVVmTUgyMklZQ3dNaCtPTU5xVlZwSElBN25vaDA2WFU3NkNsSlFU?=
 =?utf-8?B?dkpaN3pPeExUa3M5SXNxOWhDcis5bWNGY3JmUC96YklJajZNMXg3aWZWL1BN?=
 =?utf-8?B?ZU1qTVE4UzZabjltNUxDV0hnZ1UzWUF4V1UyMzlmYVpBVk5McFExcmhMeHVW?=
 =?utf-8?B?dE04MTBXRXM2WTRIZmxGRmFTZkxMSTZlVjFEdFd5elhzUTc0ZEJVZXh3NU1u?=
 =?utf-8?B?enhsQzNQTzRhRGM3RGZHOW5Xa0hrOTRXTVhmUXNSTCt1OC96dElOeSt3MVFv?=
 =?utf-8?B?VTNENlQ2RlpMS2J2QjRVTWQycE5Nd05KZ3kzamI3dEgvN3QzZG1sc013TjI2?=
 =?utf-8?Q?qR9yJiC627SqQ+H4MJnusIxAg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D377360B4FF28F4884D02F913EF35BF1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca76b00-f2b6-4c8c-fc14-08dd5c79be09
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 06:40:10.5431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFsWSWf8um7Q+We7VELOOrZ/sk7NUbp1lO88nYhPI/Kn03hH8qKlxEzNXtQueH+TdLAuw9RwBq8AeF5Y507bbsN5ENHMirneGiWMVNLwvIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4547

SGkgTWlxdWVsLA0KDQpPbiAwNS8wMy8yNSAzOjUyIHBtLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA1LzAzLzIwMjUg
YXQgMTU6MzE6MzMgKzA1MzAsIE1hbmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFuLm1A
bWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+IA0KPj4gRnJvbTogVmFyc2hpbmkgUmFqZW5kcmFuIDx2
YXJzaGluaS5yYWplbmRyYW5AbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBFVUkgaWRlbnRpZmllciBh
bmQgdGhlIE1BQyBBZGRyZXNzIG9mIHRoZSBFdGhlcm5ldCBJbnRlcmZhY2UgaXMgc3RvcmVkDQo+
PiBhZnRlciB0aGUgU0ZEUCB0YWJsZSBvZiBjb250ZW50cyBzdGFydGluZyBhdCBhZGRyZXNzIDB4
MjYwIGluIHRoZQ0KPj4gUVNQSSBtZW1vcnkuDQo+PiBSZWdpc3RlciB0aGUgZW50aXJlIFNGRFAg
cmVnaW9uIHJlYWQgYnkgdGhlIHNwaS1ub3IgKG5vci0+c2ZkcCkgaW50byB0aGUNCj4+IE5WTUVN
IGZyYW1ld29yayBhbmQgcmVhZCB0aGUgTUFDIEFkZHJlc3Mgd2hlbiByZXF1ZXN0ZWQgdXNpbmcg
dGhlIG52bWVtDQo+PiBwcm9wZXJ0aWVzIGluIHRoZSBEVCBieSB0aGUgbmV0IGRyaXZlcnMuDQo+
Pg0KPj4gSW4ga2VybmVsIHRoZSBFdGhlcm5ldCBNQUMgYWRkcmVzcyByZWxpZWQgb24gVS1Cb290
IGVudiB2YXJpYWJsZXMgb3INCj4+IGdlbmVyYXRlZCBhIHJhbmRvbSBhZGRyZXNzLCB3aGljaCBw
b3NlZCBjaGFsbGVuZ2VzIGZvciBib2FyZHMgd2l0aG91dA0KPj4gb24tYm9hcmQgRUVQUk9NcyBv
ciB3aXRoIG11bHRpcGxlIEV0aGVybmV0IHBvcnRzLg0KPj4gVGhpcyBjaGFuZ2UgZW5zdXJlcyBj
b25zaXN0ZW50IGFuZCByZWxpYWJsZSBNQUMgYWRkcmVzcyByZXRyaWV2YWwgZnJvbSBRU1BJLA0K
Pj4gYmVuZWZpdGluZyBib2FyZHMgbGlrZSB0aGUgc2FtYTVkMjkgY3VyaW9zaXR5IGFuZCBzYW05
eDc1IGN1cmlvc2l0eS4NCj4gDQo+IERvIHlvdSBtZWFuIHNwaS1ub3IgaGF2ZSBhIHByb2dyYW1t
YWJsZSBhcmVhIGluIHRoZWlyIFNGRFAgdGFibGU/IElzbid0DQo+IHRoaXMgc3VwcG9zZWQgdG8g
YmUgYSByZWFkLW9ubHkgYXJlYSB3cml0dGVuIG9uY2UgaW4gZmFjdG9yeT8NCj4gDQpUaGUgU1NU
MjZWRjA2NEJFVUkgc2VyaWFsIHF1YWQgZmxhc2ggbWVtb3J5IGlzIHByb2dyYW1tZWQgYXQgdGhl
IGZhY3RvcnkgDQp3aXRoIGEgZ2xvYmFsbHkgdW5pcXVlIGFkZHJlc3Mgc3RvcmVkIGluIHRoZSBT
RkRQIHZlbmRvcg0KcGFyYW1ldGVyIHRhYmxlIGFuZCBpdCBpcyBwZXJtYW5lbnRseSB3cml0ZS1w
cm90ZWN0ZWQuDQoNCmh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3Vt
ZW50cy9kb2N1bWVudHMvTVBEL1Byb2R1Y3REb2N1bWVudHMvRGF0YVNoZWV0cy9TU1QyNlZGMDY0
QkVVSS1EYXRhLVNoZWV0LURTMjAwMDYxMzgucGRmDQoNCj4gSSBhbSBub3QgYSBiaWcgZmFuIG9m
IGV4cG9zaW5nIHRoZSB3aG9sZSBTRkRQIGFyZWEuIEkgd291bGQgc3VnZ2VzdCB0bw0KPiBleHBv
c2UganVzdCB0aGUgTUFDIGFkZHJlc3MuIFlvdSBjYW4gbWFrZSB1c2Ugb2YgbnZtZW0gbGF5b3V0
IGRyaXZlcnMgaWYNCj4gdGhhdCBpcyBuZWVkZWQuDQo+IA0KPiBUaGFua3MsDQo+IE1pcXXDqGwN
Cg0KLS0gDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpNYW5pa2FuZGFuIE0uDQoNCg==

