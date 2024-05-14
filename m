Return-Path: <linux-kernel+bounces-178245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060808C4B07
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4A2283A19
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7326FC5;
	Tue, 14 May 2024 01:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lz0Xa7f8"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77058469D;
	Tue, 14 May 2024 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715651684; cv=fail; b=nfItfXwqSao/T/MKI2Hs2oTAbNveiyqNVCQBqq0VTFopqf3bzemMdZxHMurxQX105vHrR1DvADsKpWwuVDoovsewAPtZ1iLlzIgigVKBG51MVRu+kiccVKw2QJ9BZnDwgtv14N0RFga3t7XpevtvuEUUiTNeJxUJUxNsytP1NUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715651684; c=relaxed/simple;
	bh=xExJF3EbiiK+5wlqQzZzOUYYFiNSafY+CrOMlGImUMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EDhdnj7Z1JSbHX1PApd5E8mxG00pShnYmrlvmbfOunJqXPooZR/9pXEv0SK0LuHgdCj1LSbsMLvwDvgALRL3VVrA23K21El8D1Qu/Vj++AqLWOG3FOh+KGwPh3SMub6GF+s2uIN9CQsulW9A34do13syI4l1FXSwV5iMS4HfRC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lz0Xa7f8; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxOi8Iwx4NOgDwnLwRWHBaU0jQcAl63vgcfcccZiJTNmF53SIyGmq/npHZW61OApcKawSLgqVbKKE84ZYAO4z74CzhgcWsJUSIxIfDp0Ju/bbg104X69WfdB/7VQy0di0XrQ+xZVK1EJN8TE4tXow5TBz6wuaJBS6weh7LjWAXsJeSoA2IYJvmRdER7YgahL4AXkTfAptncpubPc6YL2AUnPQSU9q/4gSd1zcBQuloDpGdQxqGSP7geD8/DrMHfs2MtjJ838hZXNA9i2YIBTrj7dT04QZPYYPf9d7OPz9IGkCYhvi5z0tEKoLqj45VUz7xdgHVgL4D84svqi6eJUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xExJF3EbiiK+5wlqQzZzOUYYFiNSafY+CrOMlGImUMc=;
 b=glLmGeACzVnrhn0TWi/7rkCUdOb7q2uUNcfl4yT4cTs2XLNdL8m5VX8qPhGLrTT2dWRdh3C9XzWwJr7NkXRJttGnbAzYUgYS3Y17gOXvchWPX7b6aJUNroO46z/3rl4lXqkmfiG6AUR6qCAv9N74eZ/jx9QPuAiliCJLq/j9NuAeIWRxFhdWgJb/CxKJB9wv10BqA+WN/sKrMp3HyAS+EGzCfXrEoPyWqEo83O+SrdiAb0PE4xu1At5wyIUNorzdvs/pdT5C+erv1PDdreelKCirJcc4VTJV7fL/PRaKqiqP108ZLxWRxmFQ1lcABQiaCv5zR3Bkf5AQ5JZqQiRnZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xExJF3EbiiK+5wlqQzZzOUYYFiNSafY+CrOMlGImUMc=;
 b=lz0Xa7f8jMiUwvl0bh4Lppm87ut07TulkAaabRYef0cJTdpFl716N5bc2zCMMcvMkTFGmp2Vz3ZjdfvBPuHTWULg+m7SmN5UhCxD9oGZKaC4RG1acrdo1ml/B1fwU3y3uCSxi191VihvKM2Wi7EDjtys6h+c59HJOwih3JiDMeY=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB7510.eurprd04.prod.outlook.com (2603:10a6:20b:294::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 01:54:39 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 01:54:39 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Conor Dooley <conor@kernel.org>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, "kishon@kernel.org"
	<kishon@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	Frank Li <frank.li@nxp.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v5 1/2] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Thread-Topic: [PATCH v5 1/2] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Thread-Index: AQHapNap+4z6SgA6Pk+HHQHhaZycpLGVU/mAgACeNjA=
Date: Tue, 14 May 2024 01:54:39 +0000
Message-ID:
 <AS8PR04MB86760A3E903013C0AEFE9E958CE32@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1715563324-6391-1-git-send-email-hongxing.zhu@nxp.com>
 <1715563324-6391-2-git-send-email-hongxing.zhu@nxp.com>
 <20240513-antonym-flanking-5a812dd49920@spud>
In-Reply-To: <20240513-antonym-flanking-5a812dd49920@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB7510:EE_
x-ms-office365-filtering-correlation-id: 66352420-265e-409e-0fe6-08dc73b8d0c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?gb2312?B?NG9QeEY0NytseWMvVnZZVFBzMWVwMFhoNFJ2dTdhbHY2TU1CKzFmaGhMem5l?=
 =?gb2312?B?cVRSaTlDdjgrR3hOb1dpdnBNUTM1WnB1Q1BNUkxwNTBzbVJTb2tlVi9aWUVY?=
 =?gb2312?B?UFRhOU9Cd3NodmpQMGQ0enZKOEFFbjJjdEV2R1lMTnlzbWkxNU9jM2VmalRI?=
 =?gb2312?B?QldnMnIycVJ4Q05vQlByWVprWXZUemlWVkVmeHFCcjZtdk50dEhtTkQxTVlr?=
 =?gb2312?B?c1IzdHZURXFVdHBrVzZya2VDbmdsd25zVEtvNy81TXlqZ3RBVVIyakxFMWdh?=
 =?gb2312?B?a0FEOXZuMUEyYWRIMTR2ZnNya3k3Szc4Qm5oZi9MMmNUWGtnNVBzTEJLdE0w?=
 =?gb2312?B?RmQ5N1dlTDlnbEhreUY0aDlVZ1JvMXNaYVhNK0cwdmpYZHZSN2lzWHAxS3hY?=
 =?gb2312?B?RmxhK3BzM2FLSnRHZkdaa2dhc2NGZDRKSmFnS0FVQitwYXVQWWJBbG5vV29r?=
 =?gb2312?B?b1N2QVpBS2ZJem1oMVlQSzc1ZlcxeHM1RENiYjNQZXVORXRYRCtoV0daYmpC?=
 =?gb2312?B?TC9UNW84MFEvdDQrdk1LdXh6Yi9qMWMyeWp1cXhiSHFOVURoTDdHcFVyM2U0?=
 =?gb2312?B?dk80MUJmVm9YUWZVT3J6aTRSZFlWN2tLY0ZiVjZNSjM3V280K0F2YUc3ZTNo?=
 =?gb2312?B?VHcwT1RGaGxlSVNtVFowZ3lxNFBXL1RYbHNpWGc5enhpZ0s2Vk5NVWl6ZEs2?=
 =?gb2312?B?eVZPNGwxK0JON2V1NGltd2Q0YjBDdGZhOHBqS2pnRUJ1ajZ3QWQwdWdSVlR3?=
 =?gb2312?B?RzJaZzJSYVdteUtOcm0yT3dHYXYyU09FYUUwdkMyQlZuM21jdXAzcWhwMVdq?=
 =?gb2312?B?cDE3NFJxSWx0OEhFclI4QU1ySWlMUXpqbTNrWlVWc3hXYndXVkc4YVkrbXlP?=
 =?gb2312?B?Q1p2MWFrVnlkU1pUNXBmZndGMGR5RjBDNnJEaDJhemJWelpuMGlkZlFyWnBG?=
 =?gb2312?B?S3hWNXBiTVVySDlYWHAyVVgzL0pINGoyb1pwNWZZak1UU1ZRbU5qdUlxaDRL?=
 =?gb2312?B?THZoWHJBVDFIS3B5U0tDdTh5WUFhaWJQK2FvOHIzZ0dGUEhCcTVHeDRkdjhD?=
 =?gb2312?B?cXVLMzFxckoyNFk2OC9lQ2tSbHRrdmpaSUxDN2FFQ2NuZElORjB1R0NvL1pJ?=
 =?gb2312?B?MFg4U0VQL1p5Y1JOTEppSkU2aGpjbjVmaXdHUm1RcG56SlFteTFQQ3NKbHY2?=
 =?gb2312?B?TFZaaStrSTZ2TGVmRFM2SmxlS01JU2hEWWhNdHI2N0NuOG0zZHAvMUExZ2ts?=
 =?gb2312?B?bmVBWWdFWHJNWWtiMUtaQXJTQ2J1cUxTcWUrU1BmS08zd3V1RHc5aDdYa0lQ?=
 =?gb2312?B?czRBQ2RvcXhsSjBsSlZ0dGRvWDVaa0pYSktKd3UzS001MGVkSXVYK0pkTHYr?=
 =?gb2312?B?WXJsOTBjMVVWUFlZdGhHYTNzYVhmWU1RdmJ4RUhWWGtwZG9xZ0VqMFRJSTRm?=
 =?gb2312?B?a1NhSFVpZDVpZ05uYWNaRnZXVWY2ZGh1NmFDK2JBRVdwb3RZcTkyY1FXMjIw?=
 =?gb2312?B?eFE2eHIwVUxtb0FrRmt1K1k2V2trdlh0WmlnRzRPSGNTbWxkSGl0VGdIanlE?=
 =?gb2312?B?TkxDT09IVnFRQUk0VWw1cFg3bXFZdUlMZFlIaUpDTFFxZG1RcEVEbGdDQzBY?=
 =?gb2312?B?cXhZblMxaG9GYzdGbTd5STF3VFQ3VTdoRXJOU01GRmNQU0ZOVGkzSXJTU0Fm?=
 =?gb2312?B?eEMvQVp4LzVzL1Q4c0Vjb08zakFzTExKa1A2QWJsalBKZUtDWU9CdGs2Umxq?=
 =?gb2312?B?NmxZSnBYWGxZWTlNdis3SldXODJkRjVBc1BzazFWaW1OZVNnOXlYcmxJNS9W?=
 =?gb2312?B?SFNoRkR5VU8xa3ZKTFk4Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RWpuMWx3UDRQb1BZOFc3Z1VKNFU5amNDV3Z4eGtnZUw2M1U5d05WODVLR2NK?=
 =?gb2312?B?RzFnSis1OEVKUjF3SFcrYmJ0RTc5SVlMSGcrMG8rbEZYSWoxa0xrQ2RFRC82?=
 =?gb2312?B?NzNBQS9zVVZBT1l4K2wwbUJzWWtlUW5wZUw4cGhxM3VveURKVFVmMGFrWjBj?=
 =?gb2312?B?NTIzQStOTDZ2eGFqNlJzS0xtUHBQMElnYmRDVEF1bnFZTHIzMksyVnRjaUpL?=
 =?gb2312?B?ZkNWN2FBU1RqUDQ1YlppWVg5T3cwc2crbXFSNGdhVk83eGtKVitlRVZlMlVP?=
 =?gb2312?B?NGRpc3F3VEVaeHlaUlZuVjRsa1UwTVJ2ODYrb3dyNG9QcGFId2Jjam1uRUk5?=
 =?gb2312?B?S3lFaWg2UGRTdHdNKzZtalN2V2xSZmMvOGpEb25rWmNSOThYeW1vS1ZLZTFE?=
 =?gb2312?B?STFDUU8wa0lSVENXRnV2cjdtNGhsMVNIUVhZVnBaTVp5VXN0MEs3VDA5ZGNC?=
 =?gb2312?B?bmZ5ejlLcmVzZUdTY0RJR0NYckFLU00relMrdEJ2a3RpaXpjL3dRb0dHRnFK?=
 =?gb2312?B?alpsMDdFeXkwbkhpME53c3VET0FESnRNVDhmQjgrMnVwcklIeG9iNWF3K3R3?=
 =?gb2312?B?Zk9PSjZ1bXA1bnl2aXVtZDNyMjZScEh3SzhjZXNYakNTbWwzUWNtRzJ2RHVN?=
 =?gb2312?B?cXFNYTFHYUdiL0Fld2dSeHBPbTJqOEpYbGd3bjRDSUYyeC9LelhWeERYZ2lw?=
 =?gb2312?B?cW56OVp3bzBxU2NYa1ArZk85bndyOURQMm9HV1B2WXUrV0RhVityQmZDUVNB?=
 =?gb2312?B?N0RlK2w3QVlNK0RMdXIrUXB3KzBxb1VCVjl0RncvaDUyQkFCTytUd2dXaThp?=
 =?gb2312?B?VllCa0tNRHJSR1hJWS9RbGZFdGNDOXNQeWc0Q0g1Qi8rRlZPMlV1TGF3L2dm?=
 =?gb2312?B?allqMDBPUHNRMklkU0Rqb2R2MGJONTlGaFlSdG90U1RkZEZUTWkzdi9pRjUw?=
 =?gb2312?B?VWpvYmljYm50OUFNYVBsRDJrVVdHL3FTNzFqWXlNSFFWbm1KajdVYzVOT0Jt?=
 =?gb2312?B?Tm9RZUlDN21tZjI3R0hwUjVSQktab0szTGRMczdrYTlWbHQ1OTlFcG1iUVAz?=
 =?gb2312?B?Mk5BZVlMcDdycTNuYjIyMTFlckRBNU9XRUduYUpTejhGOE5xSkYwTTZTTWJH?=
 =?gb2312?B?RjhPdFdmSjZIRkhpWmY0Qm1OYzh0YXc5VE02ZkowWEdZai9wbDFxSEpMNC9Y?=
 =?gb2312?B?Yk5ZcVp4UzJYaTU1NnRzbXZQS3liU2Fzd3RySVBtd3BJdlY5MGJYS3V2aDdr?=
 =?gb2312?B?RVFZNEllblpXUmJCQTVzR0RyUDZHbjVCZHV4VmZFTmFGeHhJMGs4MVg0R1Fj?=
 =?gb2312?B?MWdoN0NSZUJDc0wwNzRFbW5haUlJM3RvN0piRXhIeGZaSGpUOHJFSzJZeXRo?=
 =?gb2312?B?VDE1L01PREh2MHRUZFlQd1ZOQWUwU050dk5BSU40eEpmNzNvOGN6bTU4eFNF?=
 =?gb2312?B?QmkyUkI4WEZKcEFwTjk2cUtkdUk3RWo5ZmdIaDNmWTk4TEVkZ1NTd2hKeE52?=
 =?gb2312?B?WVlCdm5pSHNxaWpPZ0hpeFdMRTF5Z0ZrL3NxMXc5OFAyM0NTb2F5Vitid0xn?=
 =?gb2312?B?dUo3Y1pwdEFiMEF4dFVvUnRKZmhXUXoxR2JzdHJ5bFAxVUJJMjZhWHgvaUlj?=
 =?gb2312?B?WGprcE5lWU5yWGs4RFhGVWJsTHJkN29ldWd1L1pMak5CQzFvWFBsVm81ODUv?=
 =?gb2312?B?UC9YdjFybXFGM29JRWFEbi9NbXBIcGt3SzI2bjlHMTZpRnA0bkgyaDk4a1Z1?=
 =?gb2312?B?a1ZCZEJSWE40cVJuUDF2N0NYQmtxK2lTMy92RnlWVXczdW5xRjhyTFVKRUp5?=
 =?gb2312?B?Y01rSHVycjZ4bTJTU1N0UENtMW1sdHFjcCt0TFNRRmZXb0Y3UGV1c1NaUWJk?=
 =?gb2312?B?dHV1OEozNGNvUlRYNjBZajBBYkNFanFYM3NpUFRWTk8wWEczU0MwSENFZ3Q4?=
 =?gb2312?B?aWsweUxYMkxaVk5XOEd1aW5xME8vVVVQUDNPZWxMSFNWUFc1Ni9IN1ZBdGNP?=
 =?gb2312?B?NlpqY0dUR3dsYmFGOFd0OTQvV1c1OW5LZkZtKzBXQktCajBWL1k1bFMwZk1m?=
 =?gb2312?B?VXA1aEZMRy9IbDFIbGxSYzl2RjFhMTVLWU9jODFESzFSQ2xOQk41VkIvYkE0?=
 =?gb2312?Q?KIiwOa2el7+98oWv+W3LMUIt0?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66352420-265e-409e-0fe6-08dc73b8d0c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 01:54:39.3162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AmI+MC/X2qUsrJgahm5L28j5YmW1a9pDNdRM7htC9tZJeXfNCjLimsniDSzP4nboScYXiGXRD4Q2WIsxztvbPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7510

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9y
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jXUwjE0yNUgMDowMg0KPiBUbzogSG9uZ3hpbmcg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IHZrb3VsQGtlcm5lbC5vcmc7IGtpc2hv
bkBrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2kr
ZHRAbGluYXJvLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiBjb25vcitkdEBr
ZXJuZWwub3JnOyBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBpbXhA
bGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMS8yXSBkdC1iaW5kaW5n
czogcGh5OiBBZGQgaS5NWDhRIEhTSU8gU2VyRGVzIFBIWQ0KPiBiaW5kaW5nDQo+IA0KPiBPbiBN
b24sIE1heSAxMywgMjAyNCBhdCAwOToyMjowM0FNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToN
Cj4gDQo+ID4gKyAgZnNsLGhzaW8tY2ZnOg0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAg
ICAgIFNwZWNpZmllcyB0aGUgdXNlIGNhc2Ugb2YgdGhlIEhTSU8gbW9kdWxlIGluIHRoZSBoYXJk
d2FyZSBkZXNpZ24uDQo+ID4gKyAgICAgIEJlY2F1c2UgdGhlIEhTSU8gbW9kdWxlIGNhbiBiZSBj
b25maWd1cmUgaW50byB0aHJlZSBkaWZmZXJlbnQgdXNlDQo+ID4gKyAgICAgIGNhc2VzLg0KPiA+
ICsgICAgICBSZWZlciB0byBtYWNybyBIU0lPX0NGRyogb2YNCj4gaW5jbHVkZS9kdC1iaW5kaW5n
cy9waHkvcGh5LWlteDgtcGNpZS5oLg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFt
bCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKyAgICBtYXhpbXVtOiAzDQo+IA0KPiA+ICsvKg0K
PiA+ICsgKiBSZWdhcmRpbmcgdGhlIGRlc2lnbiBvZiBpLk1YOFFNIEhTSU8gc3Vic3lzdGVtLCBI
U0lPIG1vZHVsZSBjYW4gYmUNCj4gPiArICogY29uZml1cmVkIGFzIGZvbGxvd2luZyB0aHJlZSB1
c2UgY2FzZXMuDQo+ID4gKyAqDQo+ID4gKyAqIERlZmluZSBkaWZmZXJlbnQgY29uZmlndXJhdGlv
bnMgcmVmZXIgdG8gdGhlIHVzZSBjYXNlcywgc2luY2UgaXQNCj4gPiAraXMNCj4gPiArICogbWFu
ZGF0b3J5IHJlcXVpcmVkIGluIHRoZSBpbml0aWFsaXphdGlvbi4NCj4gPiArICoNCj4gPiArICog
T24gaS5NWDhRWFAsIEhTSU8gbW9kdWxlIG9ubHkgaGFzIFBDSUVCIGFuZCBvbmUgbGFuZSBQSFku
DQo+ID4gKyAqIERlZmluZSAiSU1YOFFfSFNJT19DRkdfUENJRUIiIGZvciBpLk1YOFFYUCBwbGF0
Zm9ybXMuDQo+ID4gKyAqDQo+ID4gKyAqICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0rDQo+ID4gKyAqIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCBpLk1YOFFNICAgICAgICAgICAgfCBpLk1YOFFYUA0KPiB8DQo+
ID4gKyAqIHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0t
LS0tfC0tLS0tLS0tLS18DQo+ID4gKyAqIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCBMYW5lMHwgTGFuZTF8IExhbmUyfCBMYW5lMCAgICB8DQo+ID4gKyAqIHwtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLXwtLS0tLS18LS0tLS0tfC0tLS0tLS0tLS18DQo+ID4g
KyAqIHwgSU1YOFFfSFNJT19DRkdfUENJRUFYMlNBVEEgICAgfCBQQ0lFQXwgUENJRUF8IFNBVEEg
fA0KPiB8DQo+ID4gKyAqIHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLXwt
LS0tLS18LS0tLS0tfC0tLS0tLS0tLS18DQo+ID4gKyAqIHwgSU1YOFFfSFNJT19DRkdfUENJRUFY
MlBDSUVCICAgfCBQQ0lFQXwgUENJRUF8IFBDSUVCfA0KPiB8DQo+ID4gKyAqIHwtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLXwtLS0tLS18LS0tLS0tfC0tLS0tLS0tLS18DQo+
ID4gKyAqIHwgSU1YOFFfSFNJT19DRkdfUENJRUFQQ0lFQlNBVEEgfCBQQ0lFQXwgUENJRUJ8IFNB
VEEgfCAgICAgICAgICB8DQo+ID4gKyAqIHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
fC0tLS0tLXwtLS0tLS18LS0tLS0tfC0tLS0tLS0tLS18DQo+ID4gKyAqIHwgSU1YOFFfSFNJT19D
RkdfUENJRUIgICAgICAgICAgfCAtICAgIHwgLSAgICB8IC0gICAgfCBQQ0lFQiAgICB8DQo+ID4g
KyAqICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Ky0tLS0tLS0tLS0rDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5lIElNWDhRX0hTSU9fQ0ZHX1BDSUVB
WDJTQVRBCTB4MQ0KPiA+ICsjZGVmaW5lIElNWDhRX0hTSU9fQ0ZHX1BDSUVBWDJQQ0lFQgkweDIN
Cj4gPiArI2RlZmluZSBJTVg4UV9IU0lPX0NGR19QQ0lFQVBDSUVCU0FUQQ0KPiAJKElNWDhRX0hT
SU9fQ0ZHX1BDSUVBWDJTQVRBIHwgSU1YOFFfSFNJT19DRkdfUENJRUFYMlBDSUVCKQ0KPiA+ICsj
ZGVmaW5lIElNWDhRX0hTSU9fQ0ZHX1BDSUVCCQlJTVg4UV9IU0lPX0NGR19QQ0lFQVgyUENJRUIN
Cj4gDQo+IFJvYiBtYXkgZGlzYWdyZWUgd2l0aCBtZSwgYnV0IEkgdGhpbmsgdGhpcyBzaG91bGQg
YmUgYW4gZW51bSBvZiBwb3NzaWJsZSBzdHJpbmdzDQo+IHdpdGggdGhlIHRhYmxlIGhlcmUgbW92
ZWQgaW50byB0aGUgcHJvcGVydHkgZGVzY3JpcHRpb24uIFRoZSBRWFAgb25seSBvcHRpb24NCj4g
c2hvdWxkIHRoZW4gYmUgY29uc3RyYWluZWQgcGVyIGNvbXBhdGlibGUuDQo+IA0KSWYgdGhpcyBw
cm9wZXJ0eSBpcyBhbiBlbnVtIG9mIHBvc3NpYmxlIHN0cmluZ3MuIFRoZXJlIHdvdWxkIGJlIHRo
cmVlIGlmKCkNCiBjaGVja3MgdG8gcGFyc2UgdGhlIHBvc3NpYmxlIHN0cmluZyBpbiBkcml2ZXIu
DQpJJ20gZmluZSB3aXRoIHRoYXQuDQoNCkhpIFJvYjoNCkhvdyBkbyB5b3UgdGhpbmsgYWJvdXQg
dGhhdD8NCj4gPiArDQo+ID4gKyAgZnNsLHJlZmNsay1wYWQtbW9kZToNCj4gPiArICAgIGRlc2Ny
aXB0aW9uOg0KPiA+ICsgICAgICBTcGVjaWZpZXMgdGhlIG1vZGUgb2YgdGhlIHJlZmNsayBwYWQg
dXNlZC4gSU5QVVQoUEhZIHJlZmNsb2NrIGlzDQo+ID4gKyAgICAgIHByb3ZpZGVkIGV4dGVybmFs
bHkgdmlhIHRoZSByZWZjbGsgcGFkKSBvciBPVVRQVVQoUEhZIHJlZmNsb2NrIGlzDQo+ID4gKyAg
ICAgIGRlcml2ZWQgZnJvbSBTb0MgaW50ZXJuYWwgc291cmNlIGFuZCBwcm92aWRlZCBvbiB0aGUg
cmVmY2xrIHBhZCkuDQo+IA0KPiA+ICsgICAgICBUaGlzIHByb3BlcnR5IG5vdCBleHNpdCBtZWFu
cyB1bnVzZWQoUEhZIHJlZmNsb2NrIGlzIGRlcml2ZWQNCj4gPiArIGZyb20NCj4gDQo+IFBsZWFz
ZSBydW4gYSBzcGVsbCBjaGVja2VyIG9uIHlvdXIgcGF0Y2hlcy4NCj4gDQpTb3JyeSwgSXQncyBt
eSBmYXVsdC4gVGhlcmUgaXMgYSBzcGVsbCBtaXN0YWtlLg0Kcy9leHNpdC9leGlzdHMvDQpUaGFu
a3MuDQo+ID4gKyAgICAgIFNvQyBpbnRlcm5hbCBzb3VyY2UpLg0KPiANCj4gPiArICAgICRyZWY6
IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3N0cmluZw0KPiA+ICsgICAgZW51bTog
WyBpbnB1dCwgb3V0cHV0IF0NCj4gDQo+IGVudW06IFtpbnB1dCwgb3V0cHV0LCB1bnVzZWRdDQo+
IGRlZmF1bHQ6IHVudXNlZA0KT2theQ0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQNCj4gDQo+IENo
ZWVycywNCj4gQ29ub3IuDQo=

