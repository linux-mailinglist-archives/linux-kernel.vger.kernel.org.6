Return-Path: <linux-kernel+bounces-316672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9034896D29A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4CB1F231EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5FF1527B4;
	Thu,  5 Sep 2024 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q5soH3YZ"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D19194AE8;
	Thu,  5 Sep 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526672; cv=fail; b=RtXwo+TsSZCQSNfKxMZa6PMBxd1jmxW0ECGdUjcFNOfWdQ/g1WjYv7lirobEEVC3azfYa9M8GLAm57eM57XbFEfYhPoIspd/f+qoT8PN+Bs0amUtNzAJjzz7+ZJrEn4sjzdXY/GSpdUjIkP97TZKqhUBVMXPR7HwEwAuj8EPQZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526672; c=relaxed/simple;
	bh=Q9SxmdbeEYQdxGINXEjYulCA1aqDTg7q/2cs1JknmLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YGyAiTFdZ8QMt8DXaidmty5athT+NnQOK1d5FveYZaTqdSBeC0K1Depe7/dZ9fGckGn4PNf56vSQnY+dzq707ZbrktrWkEQucajY3AojQSS9He54sPAGFCZBiZUeINFVO0Hlrg/B6QN5MwA7bvhTbofSaMSPhEoeCfpUNlcNI9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q5soH3YZ; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/Ii4P7Djuh59YSOixgoY5iv1cspu59Zort3xlfdl4PMArylMmCnRz7QDJhy/iM0/gYAObT5SWV18nErYJH1jpyVPLFyqE7Sd8gf7ArOHMwMjZDPSnarRFdERsXIg0eeMjPavdk8yApzyDaABWoyztqw1wqSTTPlSXlivurhd7+98LinBg5OgX+8gzlbvw8FLDJi5c8Scrk1gZh27p4c5qijCKR0OxSjKjqWcBTi8HxjWVDGcwdcDMMTr6rtW/TkqKHz4qmAqe6kRwnirhXPpkT28yrUbyJYDei1BY8zra4XdAtAQlCdxKfVlchQlUPUFI1yafJvFGmtnoEtv2HZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9SxmdbeEYQdxGINXEjYulCA1aqDTg7q/2cs1JknmLo=;
 b=j6iNznAit4uemGYSXZnOYwKISdYt8KXhS93O+26wUIfMYN2NgFb4EHV6sa3gEQHQUe8KKK+etfFVbZtFgOJwwiG1uvQ88n78Aajxs+BNLdTAlF6DCBM9wnXOdIkYYvf8SyOyrew+fGzheK96eMPnCMPPVzjwSjX94WwvddOAjD1SCJlm1nPbRd41OVHPGQGbA/fq62hZBws/TW43Yjl46MZmQYf/hPdE+Gco/KdoyrRHbrMgacJFHjBZUj3InKDdlMJpyQ+zY9wECwqlhQj9Yw7ghOSYT8qwP+kWDI2lSK1FwQ33T/P+PWV0oJJwi0IGw4Q5wWAs6ZDggaqU9t3WRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9SxmdbeEYQdxGINXEjYulCA1aqDTg7q/2cs1JknmLo=;
 b=Q5soH3YZyM2LTh5SlsKiCMesN/h6G+uLkMyDJzF71YrObP4jpjXhepNoBJ7fnjVXgWtVUDk7u9+d0pnmtweiz7SQjjyfSvuuPivTuoqXwoaGDfHliEEFqUe6mGNQS04IzuBdiF3fgYARxU89AaS4eCVuQxGZhtzObRuXc4E5R+3oghnIeZnvmYcLdBxZ5zDeXKgYxjVtMGRMc9OerIXFXJYLOzPt1pd4b0FJ3fZAI32X/gW6c23NcPMP1wtBvLU0ygjX58oYIOAeXARmB2ppr61zlwdFLF3s84uflHhBLUKns7bVhoNd7XxP+xyY4NT6rfC/DZR6xurKDwx2B/vXoQ==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by AM9PR04MB8323.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 08:57:46 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 08:57:46 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "abelvesa@kernel.org" <abelvesa@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2 3/3] clk: imx95-blk-ctl: Add one clock gate for HSIO
 block
Thread-Topic: [PATCH v2 3/3] clk: imx95-blk-ctl: Add one clock gate for HSIO
 block
Thread-Index: AQHa/z6onsCdOf28E02O3IS7syJbf7JI1kkAgAAODUA=
Date: Thu, 5 Sep 2024 08:57:46 +0000
Message-ID:
 <DU2PR04MB86778C9EE3D4EE1F6A6CEEC18C9D2@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1725503468-22105-1-git-send-email-hongxing.zhu@nxp.com>
 <1725503468-22105-4-git-send-email-hongxing.zhu@nxp.com>
 <PAXPR04MB8459A02F50EC633EB4694F1F889D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8459A02F50EC633EB4694F1F889D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|AM9PR04MB8323:EE_
x-ms-office365-filtering-correlation-id: f6412d68-7189-4f9a-070b-08dccd88cfd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?gb2312?B?SCtOVEZTZHoyUXpKcmZqaCtyb1BVUkYwdE83MENETWdyeGFZRVM1WmlsMnE3?=
 =?gb2312?B?L3JLU3huZ0FIOWhVaWF1QkZlNWg1Uk1qcDdpRjNqY0Z4YWJZSUVYa3NxMThx?=
 =?gb2312?B?T1dycHZoZC8yZHFzazFOaEdHa01YQXQyRXFzTWgzUTVRT2I0R0pnbUtQTXFT?=
 =?gb2312?B?TzRtWXB4ck02TVE2NFBFYlc1TzErQkVuaFhabHhFWDA1Qkc3bFN2alcxNzdN?=
 =?gb2312?B?L0hrbmV5WFdVcFVjZmpFck5xVVNHMXFCaEdlWm41QURrOXkrMGpVa01VOVFN?=
 =?gb2312?B?Q0xkNEJ4MUVEZCsyUGpTVnB2NXRUUlFaRlA0LzlQMkJGNVUvcENPZ2doL05T?=
 =?gb2312?B?NG55OHM2cFFmaDl3WEpnY2FTbDIvbEJDYjc1WmlTYm1JQ0prOG9MWllsSXJ5?=
 =?gb2312?B?M1hCbEcxNXFNTndZeWxuZGpyY1ovQmk1RGdrRDQxeEtrNXZNKzBCNlYwc2VC?=
 =?gb2312?B?Q3EzclE4eHFnNlk1Y1RXSmtBTGxWd0RWUjM4S1hRQmxFTVpXRWRLSlZuVWF0?=
 =?gb2312?B?Vkk5Y3Z4WExEbGRDYlVZSlduOXV3Rm10NnRHeXNqNUFyN3FxRFhHUU80a1pL?=
 =?gb2312?B?ZDdrejNBR2FpcXVvTDd6WkxGWXVLTjVKR2dSa09LcUE5UnJ4MGRZaGExQ0xn?=
 =?gb2312?B?dnlCaGl6cVR0OUVjQ3FDaGZOQnUyNVNsaUUya0xTd0JSNkVGcW15ejlMT0lt?=
 =?gb2312?B?c1ZLV2xGL0NFVXlwWFFYNGYxU2FaUGZMQTkwZkw0Wit5WkVWdEJyQkwxSzdL?=
 =?gb2312?B?V1RjM2JINzdURGNNWTRDQ2Nvb2ZnMlJyZElXY2dZQWJSYUVDT0NIZ0Z4SHpx?=
 =?gb2312?B?a1VRSWszYVBLdWNNV3dCeHJHbzVJNm9ELzJlOUdYV0tZcVRheU5nWXdNUWpI?=
 =?gb2312?B?V3JyQ0VhYk1tQjV5MXd3VXNodDBqYlZDdEROLytsT3R3OHI4Y0swVW9lUkJW?=
 =?gb2312?B?dm1FNUZMQ3JMQldyMGFjQVJJVEV5NXlNY2UwRzVSMVNQT2ZVN1A5V1pSTW9B?=
 =?gb2312?B?N1paYkw2K0xVcGEybmdjVjM0UEs4NTVUWVVTQzg5eC9Oc0E2VCtXcmFOcnk4?=
 =?gb2312?B?b1ZmYmhoRmRZK3NFM1dVWTN2dGRqVGpGc3R6bmhjNXo0S1RFaFdPVDcrT2pr?=
 =?gb2312?B?MGpCbnR2SnhDRHh1T2lWVzJkSDl1R0hkd1YvNGxVUXlxYnB5Zlh4MU1aNk8z?=
 =?gb2312?B?MTdWOEpsT01aZWI2MytmS28zTFF1ZTgwSk1jWTBSZkptbmJQcmgvZEEvZi9V?=
 =?gb2312?B?V3h6VkI2SFhIY001NzBoYXNTK3lvbFZqMjJiSmEwQlpLNHlmVndZTWg3Q3RW?=
 =?gb2312?B?UVkydUJuTVNFcVozR3R3MVY4bGI0WnluSllCVU9jTFdySUpHZEtKOTQyUG5m?=
 =?gb2312?B?ZVRjMkQ0SURKdlhHenZTRCt2Y1BDUUdOTkdaZ3cvZlFkRTBibUR1OERLSVYz?=
 =?gb2312?B?ZDNVeWxuekdzMVo1eUxQRnJyMFdpL2ZSMUpNTnRZUnZZMHhYb09tb3Z6WjFE?=
 =?gb2312?B?MER3MGY2bzhLTXRPL244MmZDNmFYV0lpQThJYkxiT2xoK0lQeVdwbFVBWkl4?=
 =?gb2312?B?U3pvNjBCaW5UVXByTHdNZlhhNDMvbk1pZ1Yzc0UrSUtHZGRob3pzVzh2UCt6?=
 =?gb2312?B?NHFGdFRuOXVySDY5UmR3WFY5WGdBVjRhOE1ncXBZcWVLRStQRCtPYldxOVBy?=
 =?gb2312?B?UXg2TVUwT2FGSWJyN0pmQ0pEMU5VTEFaZkhnMXg5Z2R5NTlvWDdSa2RCVFd3?=
 =?gb2312?B?UHZjM2xxTGMrd1RSTlV0NVFxM0pib1V3cTZNd2lSZGprZkJiSDV5K29uNXBl?=
 =?gb2312?B?bUl5UkhKeGs5UkZJemo3dFBPVEN1TWFkUFdhNFJVY3Rvb2lKVzdNVXA0NzFp?=
 =?gb2312?B?ckZ0VCtiZ1daZjFwd2lEVVlJNzZrWEZDR0M1eWo1dXlFY3NqcW85cUswbU1h?=
 =?gb2312?Q?26qrd2LJ2as=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TjdzMTVwYkNKbkFsQzVYa2VNWmxrTUZFSnpMYnY1MFlNSzlWOEJIT1VLUFJi?=
 =?gb2312?B?SHh2REhZa0ZyZjRTVWFoYWh1RjA2OHVVTktrWlZhOVJTT2pOcVhCekVzRDRj?=
 =?gb2312?B?TTZvcWIrajlCNXZYYlg0OHFwUUZnWjFTbWJxT0w0Mit6TTBOcERkRHdLR1dh?=
 =?gb2312?B?ZXZvY0hadVZMd2RZK0R0UjBUTklYZEQzYUZac3V4MmN6MCtXSTJYOXVianhw?=
 =?gb2312?B?TWZpaHhHTnNsbHJVMkg3Slk1RkFwc0NxSEhROFdaK3hHU3NvcXI3YXE5OEJ3?=
 =?gb2312?B?dG5hdHl3Z2N2d2N4VkE4a2o3V3ZzTnl2d2lnMy9iOE1LZjFPTHNQWEl1UFhj?=
 =?gb2312?B?dExQbE11Wmt1eGtveldyRFRCVGRYMFY2alR4UlI4bmlRb3dKRzhDMFZkbTkx?=
 =?gb2312?B?T2tJcVJKeUYwNXFKekR3Q2p3L2RWandkZ2ZtSG1RMmRuUEdVTWZGMDBOdFV4?=
 =?gb2312?B?TnFNbmtFNVcxVXE1RkRNMERHOXliTnkwWkNuZlNkTXF2eXlHb1E2elBVZ1BK?=
 =?gb2312?B?NExsaFdLWU9kdXZOUFJTL0cyaUt6OURWT1FQUkUxZWFVRVFWQnFsVm1RVGpJ?=
 =?gb2312?B?V2wxS2V5aFkvVG9YWlNLVXBSZUtlY2k4RkhxazU4SnorUHRCQlBQMXpCWDNN?=
 =?gb2312?B?NWFMMnRsNjlVTU5yS3ZnT1B1ZFRvdHVQQlBDUUp1OXZ0R056bTZGMGw1TW8v?=
 =?gb2312?B?bUN3UjQzVDNvSzlIS3UrSVBOY0Vob1VXMHAwS1JwQnhYVVJtY3ZjQXY0Q0ta?=
 =?gb2312?B?aWZGZE1YZ3FQMU5pT1BnK0NlOWtFRGRzWVVUUW9ydXFHcW9aajhJejZlcFVw?=
 =?gb2312?B?aTFoMWtOQllxaitEUEFaSmxjMGtrc2ZtakE0RzhnU1VQcWUyUU5WSThpcHcv?=
 =?gb2312?B?dm5lUWhLSVZJMVpsWWxKVEZYY2RrVjhVQmdUUVBDOE9FaDdTa05pekZ4WitX?=
 =?gb2312?B?UEt6UUxQbURQclErTlFLVG9BWUhZVnN2VWx1MFdPckdYOUlYdmFqL1RxS01t?=
 =?gb2312?B?N2N1WWltM3k5Uk91RzJqb3FRQWRYQXkwNGNvOFNBY3RDclRoWXAwV21QMFk2?=
 =?gb2312?B?cWUra3VzVEx3a3ZTbHQxa3hyMXJjR3U3aU4yOWJIeGNjdEkremFXYWlUWG12?=
 =?gb2312?B?TzkzcmNodk1LQldPTnNOZDV6S0xqcEJYbnJYZGNUK29OdUw1dHlndldRRW4z?=
 =?gb2312?B?ZGI4TnBkS2J3aGxtY3RnT1FwL3lCOExxZHFweUNibHdmbHp0VGVUS2dvNlJ1?=
 =?gb2312?B?VGduL2gzaTl1V1lXdFlKUEdDTzBVTWZsYlNkNnYrR1NmeFRnNGlJb3MrME1w?=
 =?gb2312?B?eTJ6Lyt3MmFadUM1L3EzZDlEdFhrUC9hb0RIdEk1emR4Sk5JNmMxc2Z3YUFS?=
 =?gb2312?B?bkwvQm9OQnRGOW1uQm9CR2hHU0NUaS9lWDlhaCszUkRWSXhwaEZpK2IvQmpP?=
 =?gb2312?B?eTVhUjJ5RW9nYzltTUFOYjREejVDOFFZTHhRWW1GTVViMmhBeGtDSEJ6RGJv?=
 =?gb2312?B?U1UxeW15Q284L3NXQU5yOTlhczRabi9uZDZXcEtSRW9aWDFVd2Fra2xqbHo3?=
 =?gb2312?B?Mnd3OXlJMCs2bXFicWRrMWRJbkFxNjdRNXZGWVVEV3BlNFB1bEhUeDNJMlAy?=
 =?gb2312?B?SFhTQnVidFRtdUpiZWVzQjRlR0ZjaGlkVDNHaWU0RWROS3RzMVczV3NBVmJH?=
 =?gb2312?B?Sm1SK1VyanZOMy83UWNrdU5MZmxDTmsrbjgwa3AzcTF5bStBL0M1aloxZzBU?=
 =?gb2312?B?amxoeDg0QlJQcklIdUZPdko5cCtiVG84ZDFhNVVEb1o2NEkwdTRVTGtHS3Va?=
 =?gb2312?B?WGdRa1dVT1pEaWlDMHhXZy9iaHpoc0FqODd4WXJJcENPcm9mdlhkdm1DNWZN?=
 =?gb2312?B?SXNwNGoyRXl5WVlHSWoycWJ2Sm1EWW5aYkRMWDVCVzUrOS9VaVU1ekkvMm8r?=
 =?gb2312?B?YVZUZjl3WW5udFI1L1V1bkJLNFRlcm5RTm54U2piblNSbUI3eWZ1RUI3cjZ3?=
 =?gb2312?B?MjJVRzhsRkFQVFNjMjl0ekNoNlNvemM4SzZkdVA0cndLK2hub0ZIcDZMWXlz?=
 =?gb2312?B?bUZMYk9EcXdKeHo1SUNnYnF2Qzl2RkZLWHAzSnNtaTJFbG9LamE4YjNTM3o5?=
 =?gb2312?Q?zoDc52GJ1tJK6Kt+9HayQkudW?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6412d68-7189-4f9a-070b-08dccd88cfd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 08:57:46.5642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hd9q2IF0YFZnwIRfKIoamdPWlAZQTwxHhHcnmQ7RZ2VvVUPwN2vFsearJaULbp3ZbRk/MQJpelciDYZ0QbkzHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8323

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqOdTCNcjVIDE2OjA2DQo+IFRvOiBIb25neGluZyBaaHUg
PGhvbmd4aW5nLnpodUBueHAuY29tPjsgcm9iaEBrZXJuZWwub3JnOw0KPiBrcnprK2R0QGtlcm5l
bC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGFiZWx2ZXNhQGtlcm5lbC5vcmc7DQo+IG10dXJx
dWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3Jn
Ow0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb20NCj4gQ2M6IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtl
cm5lbC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsg
SG9uZ3hpbmcgWmh1DQo+IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQ
QVRDSCB2MiAzLzNdIGNsazogaW14OTUtYmxrLWN0bDogQWRkIG9uZSBjbG9jayBnYXRlIGZvciBI
U0lPDQo+IGJsb2NrDQo+IA0KPiA+IFN1YmplY3Q6IFtQQVRDSCB2MiAzLzNdIGNsazogaW14OTUt
YmxrLWN0bDogQWRkIG9uZSBjbG9jayBnYXRlIGZvcg0KPiA+IEhTSU8gYmxvY2sNCj4gPg0KPiA+
IENSRUZfRU4gKEJpdDYpIG9mIExGQVNUX0lPX1JFRyBjb250cm9sIGkuTVg5NSBQQ0llIFJFRiBj
bG9jayBvdXQNCj4gPiBlbmFibGUvZGlzYWJsZS4NCj4gPg0KPiA+IEFkZCBjb21wYXRpYmxlIHN0
cmluZyAiZnNsLGlteDk1LWhzaW8tYmxrLWN0bCIgdG8gc3VwcG9ydCBQQ0llIFJFRg0KPiA+IGNs
b2NrDQo+IA0KPiBUeXBvOiBueHAsaW14OTUtaHNpby1ibGstY3RsLg0KTmljZSBjYXRjaCwgdGhh
bmtzLg0KV291bGQgYmUgY29ycmVjdGVkIGxhdGVyLg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpo
dQ0KPiANCj4gRXhjZXB0IHRoaXMsIExHVE06IFJldmlld2VkLWJ5OiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gDQo+IFJlZ2FyZHMsDQo+IFBlbmcuDQo=

