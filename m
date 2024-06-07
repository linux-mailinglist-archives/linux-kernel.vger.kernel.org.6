Return-Path: <linux-kernel+bounces-205221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC33C8FF99A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439F11F236F3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9921810958;
	Fri,  7 Jun 2024 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZKuFRBED"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21646DF53;
	Fri,  7 Jun 2024 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717724069; cv=fail; b=I5EynNb56fi+VYuDQhIK8nKpl8VUeD+MwfS4UiCkDb+74uyaSfroh73QyseJbO0Vm40KQvtG6YzFLyCyhuUFibSMa7+PQxBlW3fA/EcR3a4woPKr3N6aaMr/VHvX8kRp+IwII5Yh9ZNLXZ+6obyqF+WXMfh/bxcPcwwlG3EGN7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717724069; c=relaxed/simple;
	bh=zBNzEOUss63wF4vcReIpr2s6Y4W4X2IKYCRyh+DrtRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QsSYu+OBdZzbkZt0wLBzHg9au36eRAWsIZ5qlOq1DFcJ03dNYfVPMKyY33KZKZTY5D0Yan5dMug+3Tk9vqx1NBskxoJ4fZi2WXBfKarREo991KKRNNfZdvyYq3+rJ1TXEZV7EEfe2AlW0vJzMUl9HiqYDpA32lbzGrIFQA/ix24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZKuFRBED; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjLecfW4wlwrdBWXnBaa93ePsWl9+dehKo+Z+JHChz02VBuW75dj+/jwiTc5caWvIa/UwzL8UMBR4jVLKi3FCeDoCTKZu169L+nZaEEQDT389AtqitcPvlpCCai6hrPV2tWGC/esN4vHQO486bmA7W5WOmNItNujuETiURzkurZP6/ROQ3R1dM3gMoH8R/KdZXtbHSVuiNc+ik390Or1pD5F7smnpW9KGpCGexLID2kRPODbQx+B5TqNxeA35J46RMUUyrTmzUb2aqdkvXSga/q8m4jF16DrwMh9CLaYS4jp+ltOOf3KpyHnmf1z2f9hRpIdsuIa/TJV5BMYQBPTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBNzEOUss63wF4vcReIpr2s6Y4W4X2IKYCRyh+DrtRM=;
 b=ISoWisP0+DZUzoKoLltsQVpkboykPyHd/oZCv9x8o/yLEDGdUTaFV/v8dZ9vO28eeo2y4jZLBLgxKCWN9+Z52Y0z5ab97aU5ZT+n/iLa+zZ4OCH6Vn3FAvDkrrniAsBk4gUPsupgSRSwDDeU3U1tsXgxe14aT4mjWacYmRpl3gTpJn9kTciC4K0dxRUJ+BwipWCt4CKXAjG10YUO7oIedgCqtiL+FHp5M4vFq5Zzvt5oIIq4OWD8Y74smFwxZtl+bh6gHMZk+uoqOWo/VNLjwL3Zylx8oW4pQfSoU58KPs9qak9uByLaa/rAA9Bw+4OBCIuHpCqFabbf8ivo072U9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBNzEOUss63wF4vcReIpr2s6Y4W4X2IKYCRyh+DrtRM=;
 b=ZKuFRBEDiS+LevHtJdXrtYrLDoqXlJZJ/tG/IHdmU30rHLIaVdszMMePx7CN3I1KdFfhhExYn0Hl78xX+PP+6y0adB7nPA+79DlUI1qH4s8VXlzN01BQ/YMCA65tMdkHBEYARv7OqMuPpNNtoP/EY57w/vbA7/JmE+TL4l8Ttsk=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by GVXPR04MB10451.eurprd04.prod.outlook.com (2603:10a6:150:1ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 01:34:25 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 01:34:25 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Aisheng Dong <aisheng.dong@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH 5/7] arm64: dts: imx8qm-mek: add i2c in mipi[0,1]
 subsystem
Thread-Topic: [PATCH 5/7] arm64: dts: imx8qm-mek: add i2c in mipi[0,1]
 subsystem
Thread-Index: AQHauEIerHA6xjrJu0SxKxk5t1GM5LG7hQuQ
Date: Fri, 7 Jun 2024 01:34:24 +0000
Message-ID:
 <AM6PR04MB59413CFC31B63EDDFBF7212E88FB2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
 <20240606-imx8qm-dts-usb-v1-5-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-5-565721b64f25@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|GVXPR04MB10451:EE_
x-ms-office365-filtering-correlation-id: 65f783cf-cc5e-4c49-c972-08dc8691f6c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1hwcU55eTBienc0b0JYSDdyQ0RpTGdsWUcyNTB4VXV6QUk1NjVFUWhnYWdG?=
 =?utf-8?B?SU9CcmV6L285bUV3S1ZCclBBaXkrK2VYeXhjb0NMYis5OFhzdmlGQjVJZWFm?=
 =?utf-8?B?Z2c0dkEwVFJWeGFUOTRCV2hxZWJpVW45QXJObXk4NzNxSWQ4MTdLL0U4c3gv?=
 =?utf-8?B?NEFxckVaeVp5SFBRbks2QXFLNUNvTUNyaERFaGhEQjRCNWlDT1l0OWpPTW0z?=
 =?utf-8?B?REZXUmNxUXU5dUlVQnBnVTFLVlFTMzh4Z0VVRDlDSjIra3JoTWdqb0FBdzJP?=
 =?utf-8?B?QkVqNXhndEVYU1Rqd253RTBBMzRVenBKYnE0NXdWUTBwZXAzTkkwVlhLYURp?=
 =?utf-8?B?N3htSWVkbTh3Lzk4Q1h3bUd0dHE3aHRqRlR0L090OXFBWTJXanp6QUZhSVYr?=
 =?utf-8?B?Rkx4Tk9lSllQQkgwcEJYYVRlN3gvVHh3dlNFbk5aNGlYQkdGNk9GUzBpUW9L?=
 =?utf-8?B?czhnRmlqTDJ3L0xPeXRabUtLdytEN2lJdWQzWWhBZHpkMU1MS0FrdXEyNWNz?=
 =?utf-8?B?aUp1ZWpmemFWSHdHMzFOT1Bab09OeG0ybmhOUHphQmxxemtkSFk1bXQ3aFcv?=
 =?utf-8?B?Q25pVDU4ZHVsdVgrMmQvREJSOFc1VTV4clBoMlp0U1NkSlpmbTJCUE95UTZZ?=
 =?utf-8?B?aTNjZGJ4WGVLYjNrZFpYaDR4MHQ2elcyS25nQkViVzRBOHNNR1dwejJkUHFY?=
 =?utf-8?B?aHgweWlsWUZuOEl6RVlaRnhURG9YT20ybm12K1BqdUF2MkY2MTRvdXdNenlY?=
 =?utf-8?B?YmRLY0s5WnRoMjBkZVIyK2hyWk44cWFXdGZQVjBETFZlZ1duS1h4MnNsK1ow?=
 =?utf-8?B?NzV4RmlzdHd1TmhCU3EwUDNMVHZ6TTN1UVRHVmZTZklVTEFvMkVuc3duVW9B?=
 =?utf-8?B?WU4xWnNxQ2JIaFhXb2h1ajFrQTF5NkpaN3h3ZG5EMjRCbXQzT1d3VXdHdTds?=
 =?utf-8?B?SGhQbjVDVzErK1BNakI4dEcrbzc5RjN1UTh2MjRXcy85ckdYcFZtakNNVHZV?=
 =?utf-8?B?TFRIb1o0QlZhVEpTcjZxMnZRV0tVZkVaZGp2TUF0N1VZeURKTUhCcE1LMUJT?=
 =?utf-8?B?NmgrYTV6RHhSUHpOa0NxNkwrWFFRclBPYWxJcHBNaWtjK3VtcVMzKzdzTmht?=
 =?utf-8?B?MHVGRUZKN3dxMnJ6M0l1VFcwV2FxWjJtL2lrUmNjSm5XKzBGQ3BJc2pFSnA3?=
 =?utf-8?B?WmNWdTNTTGtFMWtuWG9sOXlEYmNFTFVaR1JTMjYvVVlYSjJOb3A0YzVTY1U3?=
 =?utf-8?B?Z3hrLyszWnVHRVRzcmVLbnppMXJ1Z01sUG42aTJ4WmZwMWxTL0RpSmZqek1o?=
 =?utf-8?B?V1E0NVJuT3pncVFJOHZ1ZHZVclBTWU1FdWM3ei8yMFVKRytCY0hidUh0aVFy?=
 =?utf-8?B?bUYwenBLZUNTWVpkUlpINmdpOHZpdm9uQVRJS3dmZzNuSTMrbDhmdW0zelZO?=
 =?utf-8?B?SG5sR01YTE8xenVPVm9rNDRpc2lTU3RqVThrZGprUzVVQXdEdWUzSWIrdTNY?=
 =?utf-8?B?MDZ4VVpNeGZSUlNKdTM1RmphWFFCRXF0SzZobmNDdXVUMXdjWmczL1BYUDVs?=
 =?utf-8?B?SzlYMXY2VW5pcERWQ2dJSlhUdGJVS2tWV1JGUTdhZTliT2g5VFZQTGNNa2Iz?=
 =?utf-8?B?TDFDVzk2MmdlTjFVRWtyWDExRDRmYmo0Q0U1K3V6UmlyWHNLY2ZzeXNodmRU?=
 =?utf-8?B?S0hLREhzTmdFQjJDd3huUnFwdUp6Tmt6MmI3YU9JV1hwWVdKRWRYN1dTaTFo?=
 =?utf-8?B?NzZoczNFeGpkdmFaci9adjBDc2MxZ3NTZGtSckk1cXZFT0ZxUklDMitTWmNC?=
 =?utf-8?Q?l2ONrPTrL60yxiCIcGbvKUHsyBhtSJ2skRYSQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEZNVzR2REFUby9PNDkrS3RaTHFBM0xrOVlvcGpVSHZaQTBZb3ZUM1ZkTk52?=
 =?utf-8?B?SjhlK0Z2QXlERDZ6UjNwTFc2enlCRFhoejhLWWgwckNzYjh6NTRTSG14ejBO?=
 =?utf-8?B?TkxWZ3JOTWJNaHl1YzRIU3gzL1BBUTE3REhzS21BM2pOWnc3WkZ2enN6VFYz?=
 =?utf-8?B?aTU5TTJadHA2dVBTakcwZ3VmbTN5alRibm9SaTJhTWd0Y3Jpb2VDZzJQTXly?=
 =?utf-8?B?ajcxbUp6TmJOeUpnVTkvNUxLd0N0cUpaeHFKdXByNWkrZGdnSFVBK0JhSVhv?=
 =?utf-8?B?eHNZRzRtMkRlWTkzZUsvbWUvcEwzRjY2eXovTFMrcjRlbG9DajdTWUcxN2Uy?=
 =?utf-8?B?U2tVanpsOUNKRTdwbFlHbDZ6aWIyc2FLMW12K3NocTE5K0NLM2hWNmNGcS9S?=
 =?utf-8?B?NTFVNXhaaEoyczF2R2dObFZYVUlobnVaREdIeXRpMHhoWFBZU3cvZkI1R1oz?=
 =?utf-8?B?dGlwc2VtdHhLRkl0bDhnMDVNU2E5U3lZV056UmVzd1lkMkMzRXZrZ2IvWkJm?=
 =?utf-8?B?TXgvRTVoN2JldTlJWVVwN2g1eEdkbnFLQmwxNXYrMnJ0WnZnUGFhUncyeGdR?=
 =?utf-8?B?SE15YWlSbUszRExVbys3NU5Ub3d3K1B0MlBIc2U3S1hsWll1NFVXWTR2N2Nh?=
 =?utf-8?B?RDRVQ25MeTBnL3dFd05LSTVIMUEvU2JDUGlDYU92YkJSSXVhZCtVN0VzbnE1?=
 =?utf-8?B?TzZjenZ3RXEwVVFOd0E3NzdCKytBQW16cHNxWjFmSHhERHBMMjgrdVJHWWxQ?=
 =?utf-8?B?MTY1NTFRcytGTXlBZytKUHVaQVpsd0UxQ252YVRQbndYQnV5NERtV0xMUVQx?=
 =?utf-8?B?d3pwTkV3N0RTYlRzL3dWOVhMUDhtNWROVkkvazNIaE1WaDZwRE8zT0swL2x3?=
 =?utf-8?B?NThtSkVpQVZwcTVDemlyL0FPWUYzRVQ5clN1VlNiVVN0c0VFTkNycnJoeXhy?=
 =?utf-8?B?NzR2SUFSbitmVy9rcURTd21OUjFmNGxFQVN0U0tGQUkycUpBU0Y1dld1V2oz?=
 =?utf-8?B?ckFZRjFWWXFqNDZYNjM3U1hzTXR6M0M0SklBdk56OU1ueG1UTCtBcFFIUk8v?=
 =?utf-8?B?VUZDQlJXQUd5Zy81VHBWNkNvc3UzaEh4aUNMM2xaZDVMQmpVSzJIVVh0QnNJ?=
 =?utf-8?B?Q0RURkFJbUhDL3dEbzZsaTQyaEhLQXFCbVZDU0c3ek1FNFlYbzdqb3h6Ymty?=
 =?utf-8?B?TTFMZC8zMjNaQVE3dC9UL0RzS0IzajZPTFRxQ2VTdW9FRHFua0tNVWpXMzU0?=
 =?utf-8?B?MXhzUEFBRnhFVThYcE1JbHBmQ2xLS3R4VmFPSGF4ZzBYaVdhLzJ3N0ZvWXVW?=
 =?utf-8?B?ZmtBUVpGbXQ2bEQrVlV1b05wMWJuTndHd0REY1pvNFJzUXVYSDFFZkxoVGtn?=
 =?utf-8?B?L0RjaGtHVXVoU2htcU1vYTBjeG1nVVFjMjNpcWZ5MzNiNVgwYUlSeUdsSjNG?=
 =?utf-8?B?MnJMSnhVVVlibXdUVVovQ084WUVySnlhNGdjMVZmYzRQeGE4SWkyRFBLZi92?=
 =?utf-8?B?VWpoM242ZWpTNnZZWFJpR1BVQUZzbEtCVXdCNE82U0QzN2c2ZHBKRDhtb3Ar?=
 =?utf-8?B?ajBsNjRUN2pzWTBWb0pvSnVhS1NLNS9aemUyZExwT1VFZjdtTUN2cjA5a2wy?=
 =?utf-8?B?RXhaRkxmTUF3aWJqNGN2VTgvdjFETU5WdGxydGkyZWpYUGY3cHAyK2U5Wnpv?=
 =?utf-8?B?RnhSUE5NV0NWR1lTVFBIdVk5OUgwT1d5TU5XcEcrUE8rbldmWDMyaDBHN2p5?=
 =?utf-8?B?M1N2aXY4NE9OSHRpRU5GSEwwck5ScDNYYWZld25LUk5iQVd6OEVOR1QyK2M4?=
 =?utf-8?B?T3gwcXNheU05VGt3UmlHWWlMR09FQ2JiZG4rSjJNRHR3dFBaSHc5TTBSNTlF?=
 =?utf-8?B?MEMvdFlKZUxNMC9vRnVHUmJaTFhqZ2FkemFYUERtd05IQVYrSXkxaFY5cUNo?=
 =?utf-8?B?aTB4cGJWZlYzd0NHcFRBWUpqQmJTSUN4K3prWDZYRUg4bG5uaTJXNGdwWjdV?=
 =?utf-8?B?aXdiTXlxNHo0VEpzS2hieFNYSmZXOGpXOGtCdWcrcGpsU1MzbU1Vc0gxVVRQ?=
 =?utf-8?B?TTZoZllndGEraDF2dWJOZEFIZ3BtcEZ5d1ZHMDJJYWdsdkcrN3FqVFRHVjJU?=
 =?utf-8?Q?tQU8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f783cf-cc5e-4c49-c972-08dc8691f6c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 01:34:24.7884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ja2r//RBmi+TwTXdwDyGdMmjTKlLmnrWsLt7Vfmle/y099QKXjh4D5rosncV+jWOGUutJQLm2ykQlDRIEEUugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10451

PiBTdWJqZWN0OiBbUEFUQ0ggNS83XSBhcm02NDogZHRzOiBpbXg4cW0tbWVrOiBhZGQgaTJjIGlu
IG1pcGlbMCwxXQ0KPiBzdWJzeXN0ZW0NCj4gDQo+IEFkZCBpMmMgbm9kZSBpbiBtaXBpWzAsMV0g
c3VieXN0ZW0gZm9yIGlteDhxbS1tZWsuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBMaSA8
RnJhbmsuTGlAbnhwLmNvbT4NCj4gLS0tDQpSZXZpZXdlZC1ieTogUGVuZyBGYW4gPHBlbmcuZmFu
QG54cC5jb20+DQo=

