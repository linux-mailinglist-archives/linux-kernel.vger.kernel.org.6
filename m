Return-Path: <linux-kernel+bounces-421926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B4F9D9207
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A14FB221B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D81E18FC79;
	Tue, 26 Nov 2024 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bvhPDqb5"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2066.outbound.protection.outlook.com [40.107.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B62940D;
	Tue, 26 Nov 2024 07:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604444; cv=fail; b=uBsrljQBZhaoZ1e4cQhceQlFZbfi0AlZRi2unKpWfiNITdiSiWNUkYz4byJb3Jza0kGC0FgxiFG3F4bft8J5Q5q4C/17sCT8Fb6ln3Rr5CnCHBO9y4punzt19iaeYDKHZmO3eCN5FiU47WBowMjKkbvR9T+j3qFz/EO2mCnjMGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604444; c=relaxed/simple;
	bh=1WL3SDN1Du0bkTmxpapsxP1zFFJ638qiS5qvCazlcoI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T96dix8lkrKsiSdiSHy/Vc6alpm5EzAHe2w3bFz1MDSp27Q8ExAR7dadVfXVJrGeDzC6EEeczplpTdddqd+n2O10JySNpFQevrB7LqLWFmIFPaq1OxCZBhM4DlYXAKQ4Nd9ekILnsGwuUKJDcCgN0HjZn39SXfUxAKakq95LgO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bvhPDqb5; arc=fail smtp.client-ip=40.107.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgHhCay0XB1YZCqtYj7IdMdlQj9Rh75lH6i7CYTbo6WA9/7+2iO2Ff6pIQR5G0gsK9oQQA0aNdD4n4n6UNZKseMKXF/w7zEc3/LIOzl1CtRW+/AvcZzN7Pn6YSvPZ4Vd26+OZfkv1BsA4Tb8cfIu8p1d3eLI+LuwGj4qP60L9IVMOAYguLl4rnOFtOHhAMDkz0crQCFg0BDg6dKSXerJYu1Xwj4ExiXeJyAq/2Y0N7QZz/rz/lbIY9OncT7zofDYV2YDfvkIsNCeyo8WA7oxoOAu/UHOBK8ztESJpjIWRMNsSkBeZNMjs0JGtrut12jxU4fDaqfumphv8GO45SeC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WL3SDN1Du0bkTmxpapsxP1zFFJ638qiS5qvCazlcoI=;
 b=QdcsnJJJcL0WkbYRQYUM9FvRaDNKl+RsBO237Trp78ktBctwFRQJSN98iPix0Iuu21tgcam3g7dA8ecJxhWw1KgVn34tgHfTiGkeyAzm8pbqo9+wLOin///xmHyyoSBUBXObo566fQi9CBCmeTEBc5NNd3tCGtn0Sx0XMQCdueQG8NnQbJPZeJV/HJFgGMxSOeJRursrnfd9Te/q7pyD9dpZJa4VgLHkOU+r8I+aKL0k2qhIDLS4m58SPoMIdAxxZ4WBmmsQI+PPiS4xU+XA/u1E/6NVKcrk/5oP32unuAm1Sr6ceI1Cy+QdgQwauvYTunjQ5S+kj4tCO+3A67UAOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WL3SDN1Du0bkTmxpapsxP1zFFJ638qiS5qvCazlcoI=;
 b=bvhPDqb54eBv4UyR3MNsrBZ4J1itq3WghrquzQ4Glq20iUC5CVYN3TzF5R03knINDS4fyhja1ILz0dBYhS0RiZpW2JjI8UR1X6zx6Ai8ED2uGoP+xFo7HsmIXME3qa5NytRXGyipf6nZA6179Iniuf4nRDVrXvka9eDENwDZqoc+L1RoUJZOS4oBOxTOA0/6jnCSk5KX/yjWwR6rAUTyIGTRToNfgwQetZWr79QCahBDoqDUm1Vae5G4zC+wFwgE3Fb2nYskO2Sesdkg+0tWgMPLFBEh8QftbGxl28ewbEC8GzTaShLEWLOXZjwGApRTHWRlj3mvxk7EFEpak8QmwQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TYUPR06MB6025.apcprd06.prod.outlook.com (2603:1096:400:359::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 07:00:36 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%6]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 07:00:35 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Prashanth K
	<quic_prashk@quicinc.com>, "quic_jjohnson@quicinc.com"
	<quic_jjohnson@quicinc.com>, "mwalle@kernel.org" <mwalle@kernel.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, =?gb2312?B?uvrBrMfa?=
	<hulianqin@vivo.com>
Subject: [PATCH v3] usb: gadget: u_serial: Fix the issue that gs_start_io
 crashed due to accessing null pointer
Thread-Topic: [PATCH v3] usb: gadget: u_serial: Fix the issue that gs_start_io
 crashed due to accessing null pointer
Thread-Index: Ads/0KOYIMV5fb0KR0SoXAeOq8TMMg==
Date: Tue, 26 Nov 2024 07:00:35 +0000
Message-ID:
 <TYUPR06MB62170A30651D64EB59F94B88D22F2@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TYUPR06MB6025:EE_
x-ms-office365-filtering-correlation-id: 682a00df-1c13-443d-6272-08dd0de806ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?SU9mWGVSdEp0MUhJaWNHMHBST2pMaUdhZENPSjFFWmdtZnNjUnBZR2pGVUs1?=
 =?gb2312?B?UkpVU3NUMDdWRDFXVk9pa3hSUFR4ak8xYWRMWDdieEtlRUNneU12Vmt6VEVK?=
 =?gb2312?B?dGYyRnZWNklDZ2tSYzNRRkkxd2tocTc2alZoRkdJREdHTnVYeFRqUUJnT010?=
 =?gb2312?B?RWlqM3ZzMWgxbktPUWRHdmZGc3pnbkY0KyswSnZKRGNLWHV2d3QyM05QZzZn?=
 =?gb2312?B?cm1CK281M0ZQSGFNdWk5bkorMmdOT2dUOGlZeFdXVjcxWFU4RDUyRjNLTWZ2?=
 =?gb2312?B?eWUvOFZwUWUzQ0ZZY2tCTnNEaUxNd29oRlQ0SlltVjVMNDJNeTE4RHE1R3A3?=
 =?gb2312?B?Wk5NWkREOFl3YkdIRXo4VlNEZGpKcUtCY2pzUUVzWjhtbEVza0pjVjh0cEhw?=
 =?gb2312?B?ejc5RTZ1YWtMTEI1ZWFkUTdod0pKSUJ4VXZjZ0ppNGtEZmZQb0RvVHY3Z09J?=
 =?gb2312?B?S3JyS283UnF4N0wvNUsxdTY4bXZvRHFxMzlzczA1VXVTVCs0VjlBTWxvZFZo?=
 =?gb2312?B?cndJUStpS3ZheW9DSjlaYVBVdHRZZ3hiT2tvRTNJT0tqTmJ5a3V5RnNDbzA1?=
 =?gb2312?B?ZytGL0lWVDlZeklDbVV4TW5Ib3o0bjN3WmozU3hoTENJZk5tcnB3b1ArVThy?=
 =?gb2312?B?NzdzT2Y0elZwcTRPdjNHWi9IV2ovV25lRUJtZnRHRlhwVjBOMk8xQzVIZVY3?=
 =?gb2312?B?aVJzZjJUMUdIWlRuTm9SanVES1pVR2ZCU0w3S2FqS2RLQ1FLZmU0L1ZEblpt?=
 =?gb2312?B?allWY0kwQXk2SVpSRXVLdjF2RjFFdzBxT2NLQTJrTXRLRzFSNnppNktudlVh?=
 =?gb2312?B?YU03dVlIVnB1R1RXdmZ4TmJpUzVRN0Jramp0SUZLMEVnV2hkVVl5a0ZYenJW?=
 =?gb2312?B?U3QrL2lsNEhOSWlZTWh4QzI2NCtiaGNaamQvRTRIVlRuTk5CVlo2UFhXZ2wy?=
 =?gb2312?B?d1E3U2lCYnA3NU5hT1N6OXFwRDVqQkNYVStuMmwvRnNHeHoybERrVEIxL0Zi?=
 =?gb2312?B?VFZjTmo1Wmp2eEhsQ2o2WHpXR29aVzUxMDRncHRjV1FTZld0VElReVAvaDV2?=
 =?gb2312?B?TDd3RzlDUDliK2pVTTFkK3hpdTFZcUh5OW50L0Z2RytnZURHd0JHdlloZndG?=
 =?gb2312?B?ZW1HV2tIeHRxbVBWanhqWWdDd1RXKzRVWUFKMTg1aVRTQ1hMcnYzSjFSV20z?=
 =?gb2312?B?VityQjF3OG5IWXIxZWdlWlNndVVNWlhJOVRCYXl3TkYxUXBoUHowNkhndXRw?=
 =?gb2312?B?Q3FxdHpOaDFFeFR2VUxHRHNGdFBIMUNhdldZdVdvYlFNQW95bC9UWFRZRjlZ?=
 =?gb2312?B?MUQ2V1JBejNKTUlsTjhRcENUMCtGMlFYOXBJNVhaWUM2Q0ZiRU1KclcrN0dC?=
 =?gb2312?B?RktSNmNhWTFYaVkxN0VTcXhMR21rOEFwMkExVVBMdGR5T3l5ZHd2N2tRL2tB?=
 =?gb2312?B?eDhTejBBbUt2WStKS3FQK2JQSkR1TkpabmRIa1NFSXdYNkN2dlBCbUcvZjZW?=
 =?gb2312?B?V1ZmV1FRNmhtVXM5MUhJb2VsK3F3Z0VCeWtobXJYSjVPbEJIS3NwSjdETzV1?=
 =?gb2312?B?aGQ4YnFQSUNZQ1VybThzaXF3Smxld09UeEI1Z3k1cmowbEZqNlRUYVlnVDh2?=
 =?gb2312?B?L3VLd000SVp4cDBWRnJYUXpwK3N5a08rd0NqWXlWWHZmaDNGb0czNjhWM0ly?=
 =?gb2312?B?RkM3eWRGQ25VVlMwZExlL3RKL1p4Sm5KTGx0eS9HSjNDd3JmOTZjQjllQWtV?=
 =?gb2312?B?NFZjZGVqMm9JeURlRm9wYmlRZEt5bEZPR2RvN081SEcybmJyMnZKYlVHaDBx?=
 =?gb2312?Q?XJw/bGmhNiKahvAqzlUaw7cUG1YWblRrhM3jU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RERSb2tBV29ZVS9LR05zYzIzNDdMbm5jY21jYUJReFhlQjFPYnFQblBwaHFz?=
 =?gb2312?B?cDBwZVBZSjJwS2s1TVpsTXphSTJXV1lTVy9IbDRJQ3JpMUZXYjdEd0FOUFJa?=
 =?gb2312?B?YWhWVFduU1phRzJ1ejc3d2dVbm1XU1ZaclBnS3ZSNHJZVnJLeFJTczdGUjlz?=
 =?gb2312?B?Vi9yZU1NaHBBN1hlamVCL1ZyUkRBZzBXVTFSa3BPSHI5NllUQzBUcjlCaWN1?=
 =?gb2312?B?NGdodUF0RTFnZWNiZFlMWmVPTmw5aHNNKzlxeFpQaUR5M2pTeEhVa1dEV2VY?=
 =?gb2312?B?c1ZQV3pUZmUyRmYxbGNRT0RxZVRVOU5sRUp2ZG5JaXRkMkF1N0xLdEtyLzlp?=
 =?gb2312?B?V1dXcWZ0akZGQWc4c2dNV0FZbjY3ZzVTMjJaZ2E0N1J3dVplVUdweWtVYXk3?=
 =?gb2312?B?VVVtV3RaZWd4cW5BNkhud202TjZtZHhPWGFnSGYyTnFsME9YazB6UFJEaUNY?=
 =?gb2312?B?ekErejdlSUwrRG9IbnpTbWgwell1cVAxSFJtUVFBS2hLWG8xa1gzU2dwRmlU?=
 =?gb2312?B?TlVUYTFMTE8yMzVGeVQ3aVgxMmNvK1hBQzJRNS81ZHRBa0VQUkJBT2JwSFF1?=
 =?gb2312?B?aWdXUWRGYUxDL3NQS0dwQTNtRGpBclBZeEQrMmYvRnpqbnRDbFBkUURmeDcv?=
 =?gb2312?B?NzJSSTJwdlVEQjV4bjJ1OXMzQ3BmOVZHWXpvS3RtRkpCQklFQTFpclJGNnRx?=
 =?gb2312?B?bzgrRXpVZmF1MG9WUDFCK1k3eDF2TUZlc1hERndDaUNjNlN3RzVTNXlwVWxw?=
 =?gb2312?B?UEZ2T2NDVllIeTFzN0FBV0s2ZTVoNDNIWHViaUdOWUpGU2duYVc5Z00vWk10?=
 =?gb2312?B?V1VrbDJ1bHhiT3pkNGtlY1ZaSXREanE0dlV6azBrREFvbWk2RUNlc0ZuVzAr?=
 =?gb2312?B?cFNBTWdJRkVmZlc2UFNhTVFHdGVGY1NnMGNKZlVWZm9ZR2N5VTY4UkVqb2d3?=
 =?gb2312?B?UDBFVUM5b2RFS3o5aGlsa1hOcFpPYUg4QmRFZzRXb1lXK0tSVWVvelh6bFkz?=
 =?gb2312?B?TVR6RmJxTzN6QjhScExUV2xRMTdPaEp0L2Y3Z3ZyK2JPZm91cWo4VmFyL2hl?=
 =?gb2312?B?bVJDRnhxMTZZVzE0MUd3Tm8rbXA1VG9nOUMrYTlDMEM2L05xUVI5d3BCemJ4?=
 =?gb2312?B?b3VCRE16ZDBKenJQOUhJR2tZV1NIeldtbUdLdGJYbTJrbld6V3MzY0s4RHdm?=
 =?gb2312?B?ZWc4Z3lpKzFtNFNQcmdEck1NQjJ2c25UNmhPelJDVWpaZnQ1MFE5N1V6YWZn?=
 =?gb2312?B?Y2EzeTBoL2VKbi9kOGN4OUV5NnJTczZHb1BNTHE5RWZYWFFERGRPVFcwVysw?=
 =?gb2312?B?U3Y1K3A0TjBsZzYxV0oyaWhxdWFKYnNsWlMrS0JCVFlmY1lqMTg0NEQzM3Iv?=
 =?gb2312?B?TW5GR09nVjRhWTVaT2xGV2FyVHZjbmU0WFI2MWwzQ1J3YXA1U1dvb0J6SWs3?=
 =?gb2312?B?QzBPTzc2NGxhMlZlN1RIV1JoYUQweHRydUg2SlhZQ25waHIwN1ZwNnJINU5n?=
 =?gb2312?B?TjdxY3BSejNlSTJLc0VvRTM5eXZEaHdKa3ExOCtRUTJEYklheldzWEp0NWFs?=
 =?gb2312?B?WWVZc0x0bmxqSFVNZTlOMVZrNSt2bm9oekJRSjBMdzBubXUwZks0WmdvVHRn?=
 =?gb2312?B?UU8rc05nZXo0TWt0NFdCY1Y3M05RUDJPSEJGT2ROZ3I5Y0Rsam9FQk1TV2Rx?=
 =?gb2312?B?dmtmYmxyZVFZbXRFUnZWdjVVVWJGaEVJOEs4a3FSL1ZkQ08zbG03a01ndTJ0?=
 =?gb2312?B?MnI3RCtITUxWcTZBK0VyV0lCRmJNTWtmQi9DbFc0U0xDZ0huSnBOZWp3VVdQ?=
 =?gb2312?B?anNWMktwOHhBNll6bzVpSXVRMVBJRy9XWFZjaGhkS0xxb2U2dnhaa3AyaTM0?=
 =?gb2312?B?citzWGpCSU1vTWdzTzhaeWFkcWhCMzFwQTB0MjdINnF5dk4yaGV6V0N2MjdJ?=
 =?gb2312?B?TFBaTHZ6b0J6Mmc1QzlGeFlWSFQxN29qS2VLR0hmcU1ZOVQrN3orUUtsM0xL?=
 =?gb2312?B?cGt5RlZNYWFLREpud2JwcUt0ZlZDSHlFMVBUWkh3TU5QQ05aL3pOZnBuaDJ4?=
 =?gb2312?B?d2hJbklUNGc0TWptVmIyMFZjeGRzNGZXOTl6d1h4Z2o5cjFMaUVUckVWSnJY?=
 =?gb2312?Q?ku8Y=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682a00df-1c13-443d-6272-08dd0de806ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 07:00:35.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zy6Xz54rFUayQ0qDZ+Fas0fyOpiJrS5WzBXOFDOA1u5/Vf4HTxtUM6ECUebAohowL1qYu8xF/e72vktL+PSPEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6025

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpDb25zaWRlcmluZyB0aGF0
IGluIHNvbWUgZXh0cmVtZSBjYXNlcywNCndoZW4gdV9zZXJpYWwgZHJpdmVyIGlzIGFjY2Vzc2Vk
IGJ5IG11bHRpcGxlIHRocmVhZHMsDQpUaHJlYWQgQSBpcyBleGVjdXRpbmcgdGhlIG9wZW4gb3Bl
cmF0aW9uIGFuZCBjYWxsaW5nIHRoZSBnc19vcGVuLA0KVGhyZWFkIEIgaXMgZXhlY3V0aW5nIHRo
ZSBkaXNjb25uZWN0IG9wZXJhdGlvbiBhbmQgY2FsbGluZyB0aGUNCmdzZXJpYWxfZGlzY29ubmVj
dCBmdW5jdGlvbixUaGUgcG9ydC0+cG9ydF91c2IgcG9pbnRlciB3aWxsIGJlIHNldCB0byBOVUxM
Lg0KDQpFLmcuDQogICAgVGhyZWFkIEEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBU
aHJlYWQgQg0KDQogICAgZ3Nfb3BlbigpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBn
YWRnZXRfdW5iaW5kX2RyaXZlcigpDQoNCiAgICBnc19zdGFydF9pbygpICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbXBvc2l0ZV9kaXNjb25uZWN0KCkNCg0KICAgIGdzX3N0YXJ0X3J4KCkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ3NlcmlhbF9kaXNjb25uZWN0KCkNCiAgICAuLi4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLg0KICAgIHNwaW5fdW5sb2Nr
KCZwb3J0LT5wb3J0X2xvY2spDQogICAgc3RhdHVzID0gdXNiX2VwX3F1ZXVlKCkgICAgICAgICAg
ICAgICAgICBzcGluX2xvY2soJnBvcnQtPnBvcnRfbG9jaykNCiAgICBzcGluX2xvY2soJnBvcnQt
PnBvcnRfbG9jaykgICAgICAgICAgICAgIHBvcnQtPnBvcnRfdXNiID0gTlVMTA0KICAgIGdzX2Zy
ZWVfcmVxdWVzdHMocG9ydC0+cG9ydF91c2ItPmluKSAgICAgc3Bpbl91bmxvY2soJnBvcnQtPnBv
cnRfbG9jaykNCiAgICBDcmFzaA0KDQpUaGlzIGNhdXNlcyB0aHJlYWQgQSB0byBhY2Nlc3MgYSBu
dWxsIHBvaW50ZXIgKHBvcnQtPnBvcnRfdXNiIGlzIG51bGwpDQp3aGVuIGNhbGxpbmcgdGhlIGdz
X2ZyZWVfcmVxdWVzdHMgZnVuY3Rpb24sIGNhdXNpbmcgYSBjcmFzaC4NCg0KSWYgcG9ydF91c2Ig
aXMgTlVMTCwgdGhlIHJlbGVhc2UgcmVxdWVzdCB3aWxsIGJlIHNraXBwZWQgYXMgaXQNCndpbGwg
YmUgZG9uZSBieSBnc2VyaWFsX2Rpc2Nvbm5lY3QuDQoNClNvIGFkZCBhIG51bGwgcG9pbnRlciBj
aGVjayB0byBnc19zdGFydF9pbyBiZWZvcmUgYXR0ZW1wdGluZw0KdG8gYWNjZXNzIHRoZSB2YWx1
ZSBvZiB0aGUgcG9pbnRlciBwb3J0LT5wb3J0X3VzYi4NCg0KVW5hYmxlIHRvIGhhbmRsZSBrZXJu
ZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0DQp2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAw
MDAwMDBlOA0KcGMgOiBnc19zdGFydF9pbysweDE2NC8weDI1Yw0KbHIgOiBnc19zdGFydF9pbysw
eDIzOC8weDI1Yw0Kc3AgOiBmZmZmZmZjMDhiNzViYTAwDQp4Mjk6IGZmZmZmZmMwOGI3NWJhMDAg
eDI4OiBmZmZmZmZlZDhiYTAxMDAwIHgyNzogMDAwMDAwMDAwMDAyMDkwMg0KeDI2OiBkZWFkMDAw
MDAwMDAwMTAwIHgyNTogZmZmZmZmODk5ZjQzYTQwMCB4MjQ6IGZmZmZmZjg4NjIzMjU0MDANCngy
MzogZmZmZmZmODg2MjMyNTZhNCB4MjI6IGZmZmZmZjg4NjIzMjU2OTAgeDIxOiBmZmZmZmY4ODYy
MzI1NWVjDQp4MjA6IGZmZmZmZjg4NjIzMjU1ZDggeDE5OiBmZmZmZmY4ODVlMTlkNzAwIHgxODog
ZmZmZmZmZWQ4YzQ1YWU0MA0KeDE3OiAwMDAwMDAwMGQ0OGQzMGFkIHgxNjogMDAwMDAwMDBkNDhk
MzBhZCB4MTU6IDAwMTAwMDAwMDAwMDAwMDENCngxNDogZmZmZmZmZWQ4YzUwZmNjMCB4MTM6IDAw
MDAwMDAwNDAwMDAwMDAgeDEyOiAwMDAwMDAwMDAwMDAwMDAxDQp4MTE6IDAwMDAwMDAwODAyMDAw
MTIgeDEwOiAwMDAwMDAwMDgwMjAwMDEyIHg5IDogZmZmZmZmODg2MjMyNTVkOA0KeDggOiAwMDAw
MDAwMDAwMDAwMDAwIHg3IDogMDAwMDAwMDAwMDAwMDAwMCB4NiA6IDAwMDAwMDAwMDAwMDAwM2YN
Cng1IDogZmZmZmZmZWQ4YWUwYjlhNCB4NCA6IGZmZmZmZmZlMjY3ZDBlYTAgeDMgOiAwMDAwMDAw
MDgwMjAwMDEyDQp4MiA6IGZmZmZmZjg5OWY0M2E0MDAgeDEgOiAwMDAwMDAwMDgwMjAwMDEzIHgw
IDogZmZmZmZmODk5ZjQzYjEwMA0KQ2FsbCB0cmFjZToNCiBnc19zdGFydF9pbysweDE2NC8weDI1
Yw0KIGdzX29wZW4rMHgxMDgvMHgxM2MNCiB0dHlfb3BlbisweDMxNC8weDYzOA0KIGNocmRldl9v
cGVuKzB4MWI4LzB4MjU4DQogZG9fZGVudHJ5X29wZW4rMHgyYzQvMHg3MDANCiB2ZnNfb3Blbisw
eDJjLzB4M2MNCiBwYXRoX29wZW5hdCsweGE2NC8weGM2MA0KIGRvX2ZpbHBfb3BlbisweGI4LzB4
MTY0DQogZG9fc3lzX29wZW5hdDIrMHg4NC8weGYwDQogX19hcm02NF9zeXNfb3BlbmF0KzB4NzAv
MHg5Yw0KIGludm9rZV9zeXNjYWxsKzB4NTgvMHgxMTQNCiBlbDBfc3ZjX2NvbW1vbisweDgwLzB4
ZTANCiBkb19lbDBfc3ZjKzB4MWMvMHgyOA0KIGVsMF9zdmMrMHgzOC8weDY4DQogZWwwdF82NF9z
eW5jX2hhbmRsZXIrMHg2OC8weGJjDQogZWwwdF82NF9zeW5jKzB4MWE4LzB4MWFjDQpDb2RlOiBm
MmZiZDViYSBlYjE0MDEzZiA1NDAwMDRhMSBmOTQwZTcwOCAoZjk0MDc1MTMpDQotLS1bIGVuZCB0
cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0NCg0KU3VnZ2VzdGVkLWJ5OiBQcmFzaGFudGggSyA8
cXVpY19wcmFzaGtAcXVpY2luYy5jb20+DQpTaWduZWQtb2ZmLWJ5OiBMaWFucWluIEh1IDxodWxp
YW5xaW5Adml2by5jb20+DQoNCnYzOg0KIC0gVXBkYXRlIHBhdGNoIHN1Ym1pc3Npb24gZGVzY3Jp
cHRpb24NCiAtIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9UWVVQUjA2
TUI2MjE3OEQwMERDOTZDQzI3MDIxMTRDRjVEMjIyMkBUWVVQUjA2TUI2MjE3LmFwY3ByZDA2LnBy
b2Qub3V0bG9vay5jb20vDQoNCnYyOg0KIC0gTW9kaWZ5IHBhdGNoIGNvbnRlbnQgYW5kIGRlc2Ny
aXB0aW9uIGFjY29yZGluZyB0byAidjEgc3VnZ2VzdGlvbiINCiAtIExpbmsgdG8gdjE6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC9UWVVQUjA2TUI2MjE3MzdEMTZGNjhCNUFCRDZDRjU3NzJE
MjI3MkBUWVVQUjA2TUI2MjE3LmFwY3ByZDA2LnByb2Qub3V0bG9vay5jb20vDQoNCiBkcml2ZXJz
L3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyB8IDkgKysrKysrLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCmluZGV4IDBhOGMwNWIyNzQ2Yi4uNTNkOWZjNDFhY2M1IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCisrKyBi
L2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQpAQCAtNTc5LDkgKzU3OSwx
MiBAQCBzdGF0aWMgaW50IGdzX3N0YXJ0X2lvKHN0cnVjdCBnc19wb3J0ICpwb3J0KQ0KIAkJICog
d2UgZGlkbid0IGluIGdzX3N0YXJ0X3R4KCkgKi8NCiAJCXR0eV93YWtldXAocG9ydC0+cG9ydC50
dHkpOw0KIAl9IGVsc2Ugew0KLQkJZ3NfZnJlZV9yZXF1ZXN0cyhlcCwgaGVhZCwgJnBvcnQtPnJl
YWRfYWxsb2NhdGVkKTsNCi0JCWdzX2ZyZWVfcmVxdWVzdHMocG9ydC0+cG9ydF91c2ItPmluLCAm
cG9ydC0+d3JpdGVfcG9vbCwNCi0JCQkmcG9ydC0+d3JpdGVfYWxsb2NhdGVkKTsNCisJCS8qIEZy
ZWUgcmVxcyBvbmx5IGlmIHdlIGFyZSBzdGlsbCBjb25uZWN0ZWQgKi8NCisJCWlmIChwb3J0LT5w
b3J0X3VzYikgew0KKwkJCWdzX2ZyZWVfcmVxdWVzdHMoZXAsIGhlYWQsICZwb3J0LT5yZWFkX2Fs
bG9jYXRlZCk7DQorCQkJZ3NfZnJlZV9yZXF1ZXN0cyhwb3J0LT5wb3J0X3VzYi0+aW4sICZwb3J0
LT53cml0ZV9wb29sLA0KKwkJCQkmcG9ydC0+d3JpdGVfYWxsb2NhdGVkKTsNCisJCX0NCiAJCXN0
YXR1cyA9IC1FSU87DQogCX0NCiANCi0tIA0KMi4zOS4wDQoNCg==

