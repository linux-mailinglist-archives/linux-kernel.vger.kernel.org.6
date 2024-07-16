Return-Path: <linux-kernel+bounces-253240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFDB931E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A207E1F2222E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA17C4C74;
	Tue, 16 Jul 2024 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KoPSs5a8"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013021.outbound.protection.outlook.com [52.101.67.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DE6AB6;
	Tue, 16 Jul 2024 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721093098; cv=fail; b=O/FPYoG7A1YUuB8mokD89wALyi5eHPmIOiBv91efRSN2Tr9Yuq0ba6rHMkCraHasd4fdYtpfcQj3vfTenxikE744nnbVnszEyFmod5NrGaUTCc1DXDHLVvkDqV07G9CTYsQ6Qmp1WMQCCs128VM2DJx2x7+Okh6T3gaMB7GTrls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721093098; c=relaxed/simple;
	bh=3CiA5gMGxOvN2NInuELvLa6NY2jNeLIuHSY458ZhY+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IckLIqoilJCQ010gt10BIxKygC6BXpIdyywwPo0xI8QcQ3AHiy4HYWn98Nc4bvCIyZZ1eUtgXhSc/n09Di/45E1Bu/x432+cawwncszGWuRC1Z1JlqlWJl3A5JH0GnAj1DrizJl4zvttJH2UOg3ODOosZQVByst4W8Wfq3XhTNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KoPSs5a8; arc=fail smtp.client-ip=52.101.67.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdbZerBnInE7jSFe1fBfEaBnVhPpnjvnOSNhRO1MmkilO4GpCs4oTp1n/MZXPZY2mcx6cup6kNo6QnfQ6092My4Qdu5OmWLFB06AdoyErfFDvcOgtfwNGq8agKvyySwHu0bcqYuN6rC/GimVNoOf2Wgx6JsNKI/swt7CeoSokrVCkekF91F0SV2uYfh3Reanj5VvPzyxqbsJH+4pAPl3aQpgSX1JovMhsMfLetWGerzPvCai5wDl5gn6Tk9xG9k1BIsrHsn79/jSoHoTXD5QLAH6DfAKRNbUuZ/7v0nSH5/SHR6PkUCI5u1mFuYZHHsa41yr32r8RLrd75Qxq9AGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CiA5gMGxOvN2NInuELvLa6NY2jNeLIuHSY458ZhY+o=;
 b=w6XP6PtE5hPGjGmK2ZuWCpoQ1F2y1r8zw8N+jp9uww05OFnWdyxMHbu+C13ldhvZze1LM8evDNORpXQBvRh9doaRH2zjV4ORLsLN2ICSYMaFavPJRONHLgTSLMzCFqoQ9L6Wyunpimh+LSRdJKqrCSpm8K0wM2Tnf9hupFXNp8c8PalF29/dDgJQytLSlXC9KuCP7EqQWH6wfENKamtIWCCB2XGYp+6NygHCj4qSQItGiipf8nt/JfJ67sbZdf8xhDjhJtpm4cZnbqwrhEVNBLkYCzTtzYWWBbkZ9NPJMREE8MeekvhATnbRq90pfdEYgsfKD4POtK5bBuftnRd8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CiA5gMGxOvN2NInuELvLa6NY2jNeLIuHSY458ZhY+o=;
 b=KoPSs5a8r8N9uJJIIW79+kyHhNz8BAUuBCe8p0xh0IQGfTin9lwDUNY/mT+cxY+9nhYKMN7KVdJsXQWbc67cLazXhzXGJAW9OGAB+wbk4kJ55CBmdC/ygXiRYC4L8uH08kOLtyI7OO0nKqGWWh/w3CueWjXXjJ1BBGTiq6WndR4=
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GVXPR04MB10134.eurprd04.prod.outlook.com (2603:10a6:150:1b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 01:24:52 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Tue, 16 Jul 2024
 01:24:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Adam Ford <aford173@gmail.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "S.J. Wang" <shengjiu.wang@nxp.com>
Subject: RE: [PATCH V3 05/15] clk: imx: imx8mp-audiomix: remove sdma root
 clock
Thread-Topic: [PATCH V3 05/15] clk: imx: imx8mp-audiomix: remove sdma root
 clock
Thread-Index: AQHauN4p5iIGLXV380i5STgXcwipUbH2rYKAgACIPLCAAX99AIAAFryw
Date: Tue, 16 Jul 2024 01:24:52 +0000
Message-ID:
 <DB9PR04MB8461113195809FE1680E5FA488A22@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
 <20240607133347.3291040-6-peng.fan@oss.nxp.com>
 <CAHCN7x+pzcdwSq19LefsyYAPUp8=kQYJeVbHm9sgSeaKXigMZg@mail.gmail.com>
 <PAXPR04MB8459E0FEFFFC4F7FB257F32B88A12@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAHCN7xLDqLOe9Y8J7R5cEij9Xq=GS1Au8t3hrayf=-zSyorG-w@mail.gmail.com>
In-Reply-To:
 <CAHCN7xLDqLOe9Y8J7R5cEij9Xq=GS1Au8t3hrayf=-zSyorG-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|GVXPR04MB10134:EE_
x-ms-office365-filtering-correlation-id: 4d799de1-8dfc-4e57-c9d5-08dca53617bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YW5wTlUyV1NkT2dvU1V2UzZMdUtLdDhmZC82UXMwaUZjQ3R3cW43NEVFVDlk?=
 =?utf-8?B?VlM5VjQxQkRINHFEQmFoTWk3b21VQ2FBVTRNbTNPWHRNazJjdEVTcFliSnQ1?=
 =?utf-8?B?YzdIbGxDcSs0QnhUOCt4M3B0dklDM1E2YlloVGFzMFN3UnEzMUZlN3FPQ01s?=
 =?utf-8?B?NGprSXpkdXgxM1hvUDVsVFp3aDY2VkRxNnEwKzhxVzVBVkk0V09FUUR2TmlI?=
 =?utf-8?B?SlF2QnZxN3NUQ1JWVkV4Q25FVkhFWmQwWjNHK1EyUlo2N01zaUdxdDFxWUpn?=
 =?utf-8?B?Qm5KRkVhN2JpVmVTTEpGaXVud2FiTlRiMXN2L2gvVWZsOEdQdU5EY0tnb2VC?=
 =?utf-8?B?VUdCUFNqMGFHd2doaVdLMkw2R3ByVW9FUUU0Ui9VTVFZNmxnTWo0MnVROVJU?=
 =?utf-8?B?UzBBOFBRcmJMdGtvRk1zdGNJMTVGYTNVNFdydW1rR1FwRDFsS24yQjIyODFQ?=
 =?utf-8?B?eEswdmYvbnpIR2c3dURFcHJ6MFlUVmhjUE5MTEpRYWVCaFJLZEZHeGg4V1pr?=
 =?utf-8?B?NlNqSzgvc296S3BtSUdIVUlGS3AvRVE4aGtsUG9ORWhZWHk3akJuYVoxR0Iw?=
 =?utf-8?B?aWRIKzB3VWVaaWJGSTdlTVNJV0c0ZitLbGJXVEt1TVBGY2tUZnU4V3VYR3RM?=
 =?utf-8?B?ckoxTnVFN2FHVWUwcFlTVnMxU0cwN0YrOTN1YitFZzVrOS9Oem9FVGNrRXVz?=
 =?utf-8?B?QkZ0aTd3TUpMckxSb0d4WGhjeVpJeUVST2JqNEYvVW5reEZiblVNTExVSzVI?=
 =?utf-8?B?elFIQUk1MGRlYWtsZU96Mlk0YVNuSU9uYkp2bCswL1FWYXBLc0lPWVRjQVVs?=
 =?utf-8?B?NHBEMFc5NVZTN0N5ejZJNGFUajYxNi9wK3ZBeklhZkN0VnFpT3h3Uk9CZ0VO?=
 =?utf-8?B?WmQyUnRkdTluUVIyZnZGQ2RLSWpYSkl2NW92MXNXVUY0Q3lrc2xHKzFya0xO?=
 =?utf-8?B?d255RjlyS0J6ckZob1VpRGhGNERYbjVRbitKRjhwaFJ2L0t6aVF5bTdKOWVv?=
 =?utf-8?B?enlEK2tMdkxiQXVyM043UTNWeGFlWW5YQVVzRzEraXU1MFhjN0dhbyt0VEVT?=
 =?utf-8?B?RjZPTHRmZXJ0ZlN6S0kvbC9QTjRYZTNJSC9TTmRyZ2g3bTlhdFMrQmFCSXFM?=
 =?utf-8?B?aVJEeHlvRXVoVTJHL0VvQWswTU11cWs4RHRJSDhsb3FONnBzVGdtcG5qZjUy?=
 =?utf-8?B?VlVrQUVTU296Q1RsMWM4Z0F6dTFyakI0UGJIZklsWHJseXRzdXd3L0F5SUFF?=
 =?utf-8?B?aGNoR3NYRWp3aVBQSDdMU3BpU3IvVlFIb1luc05vRGpZNTNmVHRPQ0VxcWxY?=
 =?utf-8?B?STZCQUNNemhEUnZrbWVOR2JsN0pyam4zTGxBdkdJSElJT25abUxnaElxdHk0?=
 =?utf-8?B?aE4rV0NXNXA0djRzaHFtWmRzeXdhTFh3c3FzaTJuaWZHM3Rxc0RmVldxWlRT?=
 =?utf-8?B?c29sc05VajdHTHZtOWVsdTVEcHdqdWdWSHYweDJrSWdXeEtDTEgxUzFTVmxF?=
 =?utf-8?B?UThLdzJZbWJkOXdhWTllNko0SnhYT2NTV3dTRW14R2lZQnJRSnArczhjVlRj?=
 =?utf-8?B?L1l3eTRxWkw4T3p1b01HYWxjcmxMbnlYR1dQd01hcjZsZVJUbmJpMHJLUkU5?=
 =?utf-8?B?cVNPSUlFMW5hN1BlQTZGR3NDZFhHYUlZaERwNUxWZlgyVkRhelg5S3p1cEVy?=
 =?utf-8?B?ZHVJRlc2Zm9ORjVqSEhhVVJoK1QwbjlwMkJjVTVsQjFTU2w5SG5aM0tVRGdk?=
 =?utf-8?B?NHdaZkU3K0pDaTRvZ0FVUDlOdTFIV1BaczZkcVJpN3B5QVFFMTlhS2U3emdF?=
 =?utf-8?B?WGVEaS8rY09LWHFkSGFhcDMvV3MwTVRTRDA1Qm5xaklWRXgxbXl2TUo5anYx?=
 =?utf-8?B?REVMSmsxNFEzSHNyL3djdURtc2VXL3RFN1FaZ01zMGtXVXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3Jlb0tTREU3NHF2VHpkRS9oUXVELzcxUHBOY2RyblVpK2svcTFKSXRDdjdr?=
 =?utf-8?B?Vkt2WVJrSFJHYiszendxYVEvS29EWVZxM3dKb21rTlFUTmRNd2ZacEpWS2F4?=
 =?utf-8?B?akhRQnVMWmhqT0NTU2RxV1hzRkNZaFdmV0Y1bk5nc0Z4cWR3Z1JKM3dNM0lo?=
 =?utf-8?B?MVhXYnFWd3ZocWNJYzJjNzhaS3orTk5Uc2ZKZ3U2ajgwUUZiRlRqRW1EMzhx?=
 =?utf-8?B?Q1UyT2tjMHRsVWV3TUlKUFZCWFE0WVo5WmRGeGJqTU1Qa1pMRXA0MVhYbGgw?=
 =?utf-8?B?SmVMY1FmOVp2b2tCSE81K29RL1NWdURPR1F1R2FSenlHNjh0dGtqNm9nLzlp?=
 =?utf-8?B?MzFKYnpBcHU4UGNwZ3p4ejZMNzFEdndKV3Z3NnQ1NHI2NEllc2piR204V3M5?=
 =?utf-8?B?MjdmdHo4UG00TEdJMEJNWU01cDZWMTIzcEIvc200ZXJsTTNtaDZSbVp0QjZZ?=
 =?utf-8?B?SFI3dW9jNFRHaENBZUs3N3c2T2dVUVpqalJDcjZNNzZpZVY1dHErZjRwQzZL?=
 =?utf-8?B?eVhrQkxzakc5ejR3eHJ6a3ZiY3RMWUNzUXorWDFzdDVBUE9pRE03L0E2L3lr?=
 =?utf-8?B?eHQzMnp2S25iTXZGbW9tQUxoMi9mVzlXSmZ0VFJGV2grbGcycFlmSUdjclhL?=
 =?utf-8?B?dEYwbUVlM25oL2p4QjZIYnhyYkZLclBCZ2NETU84MXJBbkZQbzVQNUkyOHpJ?=
 =?utf-8?B?Z0IzQWlaZjN1WDBWQ0pERVNwZFF4RS9mQ0JhNFI2Nmx5QzBEVFVud2dLVHFM?=
 =?utf-8?B?RWVRbWZXZW9GQzEwUlIzOVFTTERCcGRLOWwrcmY1M2lOVlozMi9mZDJ2N2Fl?=
 =?utf-8?B?ZmlMeFhsYUtjazNMall1SXRvUVdFNEVHQm1QU2VobFVpNDYvakhqVzNRTTdh?=
 =?utf-8?B?U1N1ZGFnR2VLNzMzQktCSzhVdE9WOWdCdE9OUTVjWUEwY2FjdFBZaUtpRFJG?=
 =?utf-8?B?TjFXRi91RTVheHpuSXRnNnFabjYrVWU1azkvZW5wZEF2TEE3ZDBKS0lYbSt3?=
 =?utf-8?B?RisvWGlrbTFnVzBhTlQzeXlJZmwwOVFzMVp4aVliVXBnKzYwTncxbTJWaGd0?=
 =?utf-8?B?V2RpYkM5NWVMTmFYbmVpUUZubWV1THhVYnIybzdOenNCU3hqV3l4aTFtTE8r?=
 =?utf-8?B?RjQzSWRMcW0rZmhaaTlwNUo3aFArVE9jaGJvTEpZQ1VwaWpKV3BWdkFraHBT?=
 =?utf-8?B?cXpUVktqTmVvb0xGKzkwUUU1RHl3T1BiMHJBVlI2MElXZG9VVDFLSGlPemxP?=
 =?utf-8?B?Q3dtZGpNcXdoWHlaOWlIWTNYU3BLcjRxNlpkNzc5MnlJL0xWZzJ6U2dveXdF?=
 =?utf-8?B?WVQzMmVacHkrbUhWQUtIQ1dnV0krWEhWZUtWZlFyZmVUSkpidDdEYmkya3hz?=
 =?utf-8?B?VlVhT0RMWTJLUml6ejJDZ3ZvRnFRRm5PK2R2TE92bm50M1NLaG05UzY5azBG?=
 =?utf-8?B?KzRQUndFSk1Jb2N0ZTJWb1Z4dHh5ekdiWW9Ycis3V3UzSHBJeExKd2NCaXV4?=
 =?utf-8?B?bTVTNElXQ0dhKzF2QTZrczY3NGRtT00rckFSMTUwSDRUOElYOXBpOUMrQTdL?=
 =?utf-8?B?eDJXZ01BZlF4alMyRk9iV0RQNjU4bkl6S1dsMi95UVM2L0lrWWQzWHZyNFox?=
 =?utf-8?B?bjA5cUtNTjlJR0l3NHhTOFo1TjR2VmI3L29GYk9FOUlvRnIxa3N6ZXBIN3Zz?=
 =?utf-8?B?MEg1UmZ0QzBMd1ZCRE1YV29EVHFQMHl0amRMQWZtb1l6eVNIYnBLeDFmYkNI?=
 =?utf-8?B?UWdkN09PeEcwRmdub3M0enpvQi9YR0RWMW44cnVOcXgzMWNyTHRjNUwwSlJh?=
 =?utf-8?B?ei9QSm9tRmVPRURVUXEwVlF6WUdXZ0d6cG5TY2N2THRtakZaMDVPR1NUcnl0?=
 =?utf-8?B?RUNWcWlSbDE1eFQzLzNuaW1JUC9URmdvYlFGU2E3MndxY1U0TThlUFBjRys2?=
 =?utf-8?B?cGFmWkNRM0pobjB5cWF3YWlsdk5wTnExV3F4QnF5d085ZTEzUFhzMzV0aU1v?=
 =?utf-8?B?WkFlekNKL0JWanpEcSs4M3ZuV1V3S1gxamZtU3h4VWk0bmxJQXA2d0JmaS9P?=
 =?utf-8?B?STVkM3JmaHJWdFRVc0V0WUYycVFnYWw0VXVQMmhFWXFDUTNTZEhobE9PN2JQ?=
 =?utf-8?Q?wLbU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d799de1-8dfc-4e57-c9d5-08dca53617bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 01:24:52.4447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtkJ0AngNsJjvFfbvKu7S8LMFOZpEYroTEWGt2ufkdPstMTjanmMLRdNJeA3CbbC1frLhZwmPAh0VylEUz39Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10134

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDA1LzE1XSBjbGs6IGlteDogaW14OG1wLWF1ZGlvbWl4
OiByZW1vdmUNCj4gc2RtYSByb290IGNsb2NrDQo+IA0KPiBPbiBTdW4sIEp1bCAxNCwgMjAyNCBh
dCA4OjEx4oCvUE0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDA1LzE1XSBjbGs6IGlteDogaW14OG1wLWF1ZGlvbWl4
OiByZW1vdmUNCj4gc2RtYQ0KPiA+ID4gcm9vdCBjbG9jaw0KPiA+ID4NCj4gPiA+IE9uIEZyaSwg
SnVuIDcsIDIwMjQgYXQgODoyOOKAr0FNIFBlbmcgRmFuIChPU1MpDQo+IDxwZW5nLmZhbkBvc3Mu
bnhwLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBGcm9tOiBQZW5nIEZhbiA8
cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gVGhlcmUgaXMgYW4gaXNzdWU6DQo+
ID4gPiA+IFNETUEzIGNhbid0IHdvcmsgd2l0aG91dCBzZXR0aW5nIEFVRElPTUlYX0NMS0VOMFtT
RE1BMl0NCj4gKGJpdC0NCj4gPiA+IDI2KSB0byAxDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSB3b3Jr
YXJvdW5kIGlzOg0KPiA+ID4gPiBBcyB0aGUgcmVzZXQgc3RhdGUgb2YgQVVESU9NSVhfQ0xLRU4w
W1NETUEyXSBpcyBlbmFibGVkLCB3ZQ0KPiBqdXN0DQo+ID4gPiBuZWVkDQo+ID4gPiA+IHRvIGtl
ZXAgaXQgb24gYXMgcmVzZXQgc3RhdGUsIGRvbid0IHRvdWNoIGl0IGluIGtlcm5lbCwgdGhlbiBl
dmVyeQ0KPiA+ID4gPiB0aGluZyBpcyBzYW1lIGFzIGJlZm9yZSwgaWYgd2UgcmVnaXN0ZXIgdGhl
IGNsb2NrIGluIGNsay1hdWRpb21peCwNCj4gPiA+ID4gdGhlbiBrZXJuZWwgd2lsbCB0cnkgdG8g
ZGlzYWJsZSBpdCBpbiBpZGxlLg0KPiA+ID4gPg0KPiA+ID4gPiBGaXhlczogNmNkOTVmN2IxNTFj
ICgiY2xrOiBpbXg6IGlteDhtcDogQWRkIGF1ZGlvbWl4IGJsb2NrDQo+ID4gPiBjb250cm9sIikN
Cj4gPiA+ID4gUmV2aWV3ZWQtYnk6IFNoZW5naml1IFdhbmcgPHNoZW5naml1LndhbmdAbnhwLmNv
bT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+
ID4gPiA+IC0tLQ0KPiA+ID4NCj4gPiA+IFdpdGggdGhpcyBwYXRjaCxJIGZvdW5kIGl0IGJyb2tl
IHRoZSBpbXg4bXAtYmVhY29uIGJvYXJkIHdoZW4NCj4gPiA+IHJ1bm5pbmcgYXVkaW8gdGhyb3Vn
aCBhIGNvZGVjIGNvbm5lY3RlZCB0byBzYWkzLiAgUmV2ZXJ0aW5nIHRoaXMNCj4gPiA+IHBhdGNo
IG1hZGUgdGhlIGNyYXNoIGdvIGF3YXkuICBJcyB0aGVyZSBhIHdheSB0byBtYXJrIHRoZSBjbG9j
ayBhcw0KPiA+ID4gY3JpdGljYWwgc28gaXQgZG9lc24ndCBnZXQgaWRsZWQ/DQo+ID4NCj4gPiBN
YXJrIGl0IGFzIGNyaXRpY2FsIG1lYW5zIHRoZSBibGsgY3RybCBuZWVkcyB0byBiZSBwb3dlcmVk
IG9uIGFsd2F5cy4NCj4gPg0KPiA+IFlvdSBkcml2ZXIgdG91Y2hlZCB0aGUgU0RNQTJfUk9PVCBj
bG9jaz8NCj4gDQo+IEkgaGF2ZSBhIFdNODk2MiBDT0RFQyBjb25uZWN0ZWQgdGhyb3VnaCBzYWkz
LiAgV2l0aG91dCB0aGlzIHBhdGNoLA0KPiB0aGUgc291bmQgcGxheXMganVzdCBmaW5lLiAgV2l0
aCB0aGlzIHBhdGNoLCBJIGdldCB0aGUgZm9sbG93aW5nOg0KDQpUcnkgdXNlIHRoaXMgZm9yIFNE
TUEyLg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNsayBJTVg4
TVBfQ0xLX0FVRElPX0FIQl9ST09UPiwgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmNsayBJTVg4TVBfQ0xLX0FVRElP
X0FIQl9ST09UPjsNCg0KSSB3aWxsIGdpdmUgYSBsb29rIGFuZCBzZWUgaG93IHRvIGFkZHJlc3Mg
dGhlIGlzc3VlLg0KDQpUaGFua3MgZm9yIHRoZSByZXBvcnQuDQoNClRoYW5rcywNClBlbmcuDQoN
Cj4gDQo+IFsgICA3My4yNDUxOTldIGlteC1zZG1hIDMwZTEwMDAwLmRtYS1jb250cm9sbGVyOiBU
aW1lb3V0IHdhaXRpbmcNCj4gZm9yIENIMCByZWFkeQ0KPiBbICAgNzMuMjUyMTk3XSAtLS0tLS0t
LS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gWyAgIDczLjI1NjgxNl0gV0FSTklORzog
Q1BVOiAxIFBJRDogMTA4MCBhdA0KPiBrZXJuZWwvZG1hL21hcHBpbmcuYzo1ODYNCj4gZG1hX2Zy
ZWVfYXR0cnMrMHg5NC8weGMwDQo+IFsgICA3My4yNTY4MzJdIE1vZHVsZXMgbGlua2VkIGluOiBv
dmVybGF5IGFmX2FsZyBkd19oZG1pX2dwX2F1ZGlvDQo+IGR3X2hkbWlfY2VjIHRwbV90aXNfc3Bp
IHNuZF9zb2NfaGRtaV9jb2RlYyBjYWFtX2pyIHRwbV90aXNfY29yZQ0KPiBjYWFtaGFzaF9kZXNj
IGNhYW1hbGdfZGVzYyBjcnlwdG9fZW5naW5lIGF1dGhlbmMgbGliZGVzDQo+IGhhbnRyb192cHUg
djRsMl9qcGVnIHY0bDJfdnA5IHY0bDJfaDI2NCB2NGwyX21lbTJtZW0NCj4gdmlkZW9idWYyX2Rt
YV9jb250aWcgdmlkZW9idWYyX21lbW9wcyB2aWRlb2J1ZjJfdjRsMiB2aWRlb2Rldg0KPiBpbXg4
bXBfaGRtaV90eCBidG54cHVhcnQgbnZtZSB2aWRlb2J1ZjJfY29tbW9uIGR3X2hkbWkgbWMNCj4g
bnZtZV9jb3JlIGV0bmF2aXYgaW14X2xjZGlmIGJsdWV0b290aCBmc2xfaW14OF9kZHJfcGVyZg0K
PiBkcm1fZGlzcGxheV9oZWxwZXIgZHdtYWNfaW14IGdwdV9zY2hlZCBwaHlfZnNsX3NhbXN1bmdf
aGRtaQ0KPiBpbXg4bXBfaGRtaV9wdmkgZHJtX2RtYV9oZWxwZXIgc2Ftc3VuZ19kc2ltIHNuZF9z
b2NfZnNsX3NhaQ0KPiBzdG1tYWNfcGxhdGZvcm0gc25kX3NvY19mc2xfeGN2ciBzbmRfc29jX2Zz
bF9taWNmaWwNCj4gc25kX3NvY19mc2xfYXVkMmh0eCBzdG1tYWMgYWR2NzUxMSBlY2RoX2dlbmVy
aWMgaW14X3BjbV9kbWENCj4gc25kX3NvY19mc2xfdXRpbHMgZWNjIHBjc194cGNzIGNlYyB0Y3Bj
aSBmbGV4Y2FuIHRjcG0gaGQzc3MzMjIwDQo+IHNuZF9zb2Nfd204OTYyIHNwaV9pbXggY2FuX2Rl
diB0eXBlYyBhdDI0IGNhYW0gcnRjX3BjZjg1MzYzDQo+IHJ0Y19zbnZzIGVycm9yIHNudnNfcHdy
a2V5IGlteDhtbV90aGVybWFsIGNyY3QxMGRpZl9jZQ0KPiBzbmRfc29jX2lteF9oZG1pIGNvcmVz
aWdodF90bWMgc25kX3NvY19pbXhfY2FyZA0KPiBzbmRfc29jX3NpbXBsZV9jYXJkIGNvcmVzaWdo
dF9mdW5uZWwgc25kX3NvY19zaW1wbGVfY2FyZF91dGlscw0KPiBkaXNwbGF5X2Nvbm5lY3RvciBz
bmRfc29jX2RtaWMgY29yZXNpZ2h0IGRybV9rbXNfaGVscGVyDQo+IGlteF9jcHVmcmVxX2R0IGlt
eF9zZG1hIG13aWZpZXhfc2Rpbw0KPiBbICAgNzMuMjU2OTk3XSAgbXdpZmlleCBjZmc4MDIxMSBy
ZmtpbGwgZnVzZSBkcm0gYmFja2xpZ2h0IGlwdjYNCj4gWyAgIDczLjI1NzAxNV0gQ1BVOiAxIFVJ
RDogMCBQSUQ6IDEwODAgQ29tbTogc3BlYWtlci10ZXN0IE5vdA0KPiB0YWludGVkDQo+IDYuMTAu
MC1yYzctbmV4dC0yMDI0MDcwOS1nYTkwZWU1OTMxZWZlLWRpcnR5ICM5DQo+IFsgICA3My4yNTcw
MjJdIEhhcmR3YXJlIG5hbWU6IEJlYWNvbiBFbWJlZGRlZFdvcmtzIGkuTVg4TVBsdXMNCj4gRGV2
ZWxvcG1lbnQga2l0IChEVCkNCj4gWyAgIDczLjI1NzAyNV0gcHN0YXRlOiA2MDAwMDBjNSAoblpD
diBkYUlGIC1QQU4gLVVBTyAtVENPIC1ESVQgLVNTQlMNCj4gQlRZUEU9LS0pDQo+IFsgICA3My4y
NTcwMzFdIHBjIDogZG1hX2ZyZWVfYXR0cnMrMHg5NC8weGMwDQo+IFsgICA3My4yNTcwMzddIGxy
IDogZG1hX2ZyZWVfYXR0cnMrMHg1MC8weGMwDQo+IFsgICA3My4yNTcwNDFdIHNwIDogZmZmZjgw
MDA4NGY2Yjk4MA0KPiBbICAgNzMuMjU3MDQzXSB4Mjk6IGZmZmY4MDAwODRmNmI5ODAgeDI4OiAw
MDAwMDAwMDAwMDAwMDEwIHgyNzoNCj4gMDAwMDAwMDAwMDAwMDNjMg0KPiBbICAgNzMuMjU3MDUx
XSB4MjY6IDAwMDAwMDAwMDAwMDAwMDUgeDI1OiAwMDAwMDAwMDAwMDAwMDEwIHgyNDoNCj4gMDAw
MDAwMDAwMDAwMDAwMA0KPiBbICAgNzMuMjU3MDU3XSB4MjM6IDAwMDAwMDAwYzU1MDQwMDAgeDIy
OiAwMDAwMDAwMDAwMDAwMDAwIHgyMToNCj4gZmZmZjgwMDA4MzE4MzAwMA0KPiBbICAgNzMuMjU3
MDY0XSB4MjA6IDAwMDAwMDAwMDAwMDAwYzAgeDE5OiBmZmZmMDAwMGMwZTU0NDEwIHgxODoNCj4g
MDAwMDAwMDAwMDAwMDAwNg0KPiBbICAgNzMuMjU3MDcxXSB4MTc6IDAwMDAwMDAwMDAwMDAwMDAg
eDE2OiAwMDAwMDAwMDAwMDAwMDAwIHgxNToNCj4gZmZmZjgwMDA4NGY2YjMzMA0KPiBbICAgNzMu
MjU3MDc4XSB4MTQ6IDAwMDAwMDAwMDAwMDAwMDAgeDEzOiBmZmZmODAwMDgyNjg0NWQ4IHgxMjoN
Cj4gMDAwMDAwMDAwMDAwMDYzOQ0KPiBbICAgNzMuMjU3MDg1XSB4MTE6IDAwMDAwMDAwMDAwMDAy
MTMgeDEwOiBmZmZmODAwMDgyNmRjNWQ4IHg5IDoNCj4gZmZmZjgwMDA4MjY4NDVkOA0KPiBbICAg
NzMuMjU3MDkyXSB4OCA6IDAwMDAwMDAwZmZmZmVmZmYgeDcgOiBmZmZmODAwMDgyNmRjNWQ4IHg2
IDoNCj4gMDAwMDAwMDAwMDAwMDA0MA0KPiBbICAgNzMuMjU3MDk4XSB4NSA6IDAwMDAwMDAwMDAw
MDAwMDAgeDQgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDoNCj4gMDAwMDAwMDBjNTUwNDAwMA0KPiBb
ICAgNzMuMjU3MTA1XSB4MiA6IGZmZmY4MDAwODMxODMwMDAgeDEgOiAwMDAwMDAwMDAwMDAwMDAw
IHgwIDoNCj4gMDAwMDAwMDAwMDAwMDBjMA0KPiBbICAgNzMuMjU3MTEyXSBDYWxsIHRyYWNlOg0K
PiBbICAgNzMuMjU3MTE1XSAgZG1hX2ZyZWVfYXR0cnMrMHg5NC8weGMwDQo+IFsgICA3My4yNTcx
MjFdICBzZG1hX2ZyZWVfYmQrMHg2MC8weDZjIFtpbXhfc2RtYV0NCj4gWyAgIDczLjI1NzEzMF0g
IHNkbWFfdHJhbnNmZXJfaW5pdCsweDFlOC8weDI3MCBbaW14X3NkbWFdDQo+IFsgICA3My4yNTcx
MzddICBzZG1hX3ByZXBfZG1hX2N5Y2xpYysweDc0LzB4MjAwIFtpbXhfc2RtYV0NCj4gWyAgIDcz
LjI1NzE0M10gIHNuZF9kbWFlbmdpbmVfcGNtX3RyaWdnZXIrMHhkOC8weDE4Yw0KPiBbICAgNzMu
MjU3MTUyXSAgZG1hZW5naW5lX3BjbV90cmlnZ2VyKzB4MTgvMHgyNA0KPiBbICAgNzMuMjU3MTU5
XSAgc25kX3NvY19wY21fY29tcG9uZW50X3RyaWdnZXIrMHgxNzAvMHgyMWMNCj4gWyAgIDczLjI1
NzE2OF0gIHNvY19wY21fdHJpZ2dlcisweGRjLzB4MWM4DQo+IFsgICA3My4yNTcxNzVdICBzbmRf
cGNtX2RvX3N0YXJ0KzB4NDQvMHg3MA0KPiBbICAgNzMuMjU3MTgzXSAgc25kX3BjbV9hY3Rpb25f
c2luZ2xlKzB4NDgvMHhhNA0KPiBbICAgNzMuMjU3MTg5XSAgc25kX3BjbV9hY3Rpb24rMHg4MC8w
eDljDQo+IFsgICA3My4yNTcxOTVdICBzbmRfcGNtX3N0YXJ0KzB4MjQvMHgzMA0KPiBbICAgNzMu
MjU3MjAzXSAgX19zbmRfcGNtX2xpYl94ZmVyKzB4NmE0LzB4N2Q4DQo+IFsgICA3My4yNTcyMDhd
ICBzbmRfcGNtX2NvbW1vbl9pb2N0bCsweDExNDAvMHgxNzgwDQo+IFsgICA3My4yNTcyMTVdICBz
bmRfcGNtX2lvY3RsKzB4MzQvMHg0Yw0KPiBbICAgNzMuMjU3MjIyXSAgX19hcm02NF9zeXNfaW9j
dGwrMHhhYy8weGYwDQo+IFsgICA3My4yNTcyMzFdICBpbnZva2Vfc3lzY2FsbCsweDQ4LzB4MTE0
DQo+IFsgICA3My4yNTcyMzldICBlbDBfc3ZjX2NvbW1vbi5jb25zdHByb3AuMCsweDQwLzB4ZTAN
Cj4gWyAgIDczLjI1NzI0Nl0gIGRvX2VsMF9zdmMrMHgxYy8weDI4DQo+IFsgICA3My4yNTcyNTJd
ICBlbDBfc3ZjKzB4MzQvMHhkOA0KPiBbICAgNzMuMjU3MjYwXSAgZWwwdF82NF9zeW5jX2hhbmRs
ZXIrMHgxMjAvMHgxMmMNCj4gWyAgIDczLjI1NzI2N10gIGVsMHRfNjRfc3luYysweDE5MC8weDE5
NA0KPiBbICAgNzMuMjU3MjczXSAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0N
Cj4gWyAgIDczLjU2NTY1OV0gZnNsLXNhaSAzMGMzMDAwMC5zYWk6IEFTb0M6IGVycm9yIGF0DQo+
IHNvY19jb21wb25lbnRfdHJpZ2dlciBvbiAzMGMzMDAwMC5zYWk6IC0xMg0KPiANCj4gV3JpdGUg
ZXJyb3I6IC01LElucHV0L291dHB1dCBlcnJvWyAgIDc2Ljc2NzEyMF0gaW14LXNkbWENCj4gMzBl
MTAwMDAuZG1hLWNvbnRyb2xsZXI6IFRpbWVvdXQgd2FpdGluZyBmb3IgQ0gwIHJlYWR5DQo+IA0K
PiBObyBzb3VuZCBpcyBoZWFyZC4NCj4gDQo+IEkgaGF2ZW4ndCBsb29rZWQgZmFyIGludG8gdGhl
IGRyaXZlciB0byBzZWUgd2hhdCB3YXMgdG91Y2hlZCwgYnV0IEkgd2FzDQo+IGFibGUgdG8gcmVw
cm9kdWNlIHRoaXMgYnkgZW5hYmxpbmcgYW5kIGRpc2FibGluZyB0aGUgcGF0Y2ggc2V2ZXJhbA0K
PiB0aW1lcywgc28gaXQncyByZXBlYXRhYmxlLiBpbXgtc2RtYSAzMGUxMDAwMC5kbWEtY29udHJv
bGxlciBzZWVtcyB0bw0KPiBjb3JyZXNwb25kIHRvIHNkbWEyLg0KPiANCj4gYWRhbQ0KPiA+DQo+
ID4gUmVnYXJkcywNCj4gPiBQZW5nLg0KPiA+DQo+ID4gPg0KPiA+ID4gYWRhbQ0KPiA+ID4gPiAg
ZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXAtYXVkaW9taXguYyB8IDEgLQ0KPiA+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1wLWF1ZGlvbWl4LmMNCj4gPiA+ID4gYi9kcml2ZXJz
L2Nsay9pbXgvY2xrLWlteDhtcC1hdWRpb21peC5jDQo+ID4gPiA+IGluZGV4IGIzODFkNmY3ODRj
OC4uODhkOGJhOTc1YjVhIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xr
LWlteDhtcC1hdWRpb21peC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14
OG1wLWF1ZGlvbWl4LmMNCj4gPiA+ID4gQEAgLTE3Miw3ICsxNzIsNiBAQCBzdGF0aWMgc3RydWN0
IGNsa19pbXg4bXBfYXVkaW9taXhfc2VsDQo+IHNlbHNbXQ0KPiA+ID4gPSB7DQo+ID4gPiA+ICAg
ICAgICAgQ0xLX0dBVEUoIm9jcmFtYSIsIE9DUkFNQV9JUEcpLA0KPiA+ID4gPiAgICAgICAgIENM
S19HQVRFKCJhdWQyaHR4IiwgQVVEMkhUWF9JUEcpLA0KPiA+ID4gPiAgICAgICAgIENMS19HQVRF
KCJlYXJjX3BoeSIsIEVBUkNfUEhZKSwNCj4gPiA+ID4gLSAgICAgICBDTEtfR0FURSgic2RtYTIi
LCBTRE1BMl9ST09UKSwNCj4gPiA+ID4gICAgICAgICBDTEtfR0FURSgic2RtYTMiLCBTRE1BM19S
T09UKSwNCj4gPiA+ID4gICAgICAgICBDTEtfR0FURSgic3BiYTIiLCBTUEJBMl9ST09UKSwNCj4g
PiA+ID4gICAgICAgICBDTEtfR0FURSgiZHNwIiwgRFNQX1JPT1QpLA0KPiA+ID4gPiAtLQ0KPiA+
ID4gPiAyLjM3LjENCj4gPiA+ID4NCj4gPiA+ID4NCg==

