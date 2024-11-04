Return-Path: <linux-kernel+bounces-395339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0896B9BBC98
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B75B228EB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83A31D0BB2;
	Mon,  4 Nov 2024 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="rMePH+z0"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2107.outbound.protection.outlook.com [40.107.215.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B701CBE84;
	Mon,  4 Nov 2024 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742891; cv=fail; b=Yrp1TaBNU9DRUUbZd6favRdOplHXwDAJ/otVIWqRYUZmdUjmw1SPOTah0OEn1KQv5ROO9OVecd+iY5ctMyTd+lIXBuXP3SehIMI9/B6Nv8LZqHOjPj0isClzU8VU4ofXEi9pIAUP+TcrD5n8oDU8koBE7JiqS97A+GfMOYn4DN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742891; c=relaxed/simple;
	bh=6DfGe+fP48OMPm6KfQ527wTnTHU+jSDQDRIsmWS73Ic=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mxdJ8X6cci2N9rX8TUB9M8iFe36k56TsDJpz4xADW0ReQhw2Xt0kDOlIF0uj3/3ilpvDNSZtDuT+c/poXaH8aieIlqME2NNxR7KsOSjE/yKuA5MgZvyp8TZlxN1njGuF+20fsbE+y2lRgQ5qQe9k8Z1iIeg6aOzG8s639LkNrlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=rMePH+z0; arc=fail smtp.client-ip=40.107.215.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqjADq39dFLZLV4a+9f+XNsjgpupf8DUF+jE7CXYolTdkaAKSv+oTASN3fl61SNsp4LGJSuCmdOWfUR5cDB3P4FTfdeHO1liCXD8uhy+bicftmjlknwlD5dVOnF4qEr2NuupDmhXJAxEjltOt/iWzmVPBr+WXSKQq//8fK3Z9vfxlBJgzU++4SbBtFrA9xYInHcWsGy/V4d+CAkjLlJtR7R0iQNb5XZCEGchX6t+K4D1akzYFWfdrfjMtTKWqAQuFaINrEfJ8KtsF6OFanYl0oDVOyYWbsOJqpa1xxEBwQljIUuTook848JRXeF+2qPHfL15nOBsUu6Jcc+HEzbqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAubdd6oXr5ft7kyRghP0rb6yS6bEZMYxkg5SmnJtGI=;
 b=i/T5FvQUgb4Jz03W9GbsdiEPjR6mN0pLIq1VcTMQgOZ5Fm8g81fKbwmSW1WzvOvkJLboIst9YwJ0NfmW/aRF+8RqRkHkoooMP3Rl/6bGllXMlki1stqHhO4UiRQUnmU45JcrQS7g3TEehCwjNxgHCBybuTxhwT8GxYIouQOr/iGVh3rfTpP30PmeQOLgPc6Rc8aWmmHZFxpynt69qraZjjDRYHKos7kLt3AqCeDxw8lzAffrilAu5WcSROeskGSG2M0Pa9kOstD23qwwz+a9ktpZIEqM5l/iHmhOKfrCT3SVD4UAy1K4QyZasGKMWlkhfQ2L/EEs2wMEGDsxM+gf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAubdd6oXr5ft7kyRghP0rb6yS6bEZMYxkg5SmnJtGI=;
 b=rMePH+z0OixtJI/AEfHI6Nq/xCxwVQXdZcrmR8axl4bZzI1+9ggE7XwIMB/NH8XHw5NHRuX4jjBUn9CPFLXPrkDk4MtPprh0gTSMv/aEUtsD/UhLLta8bTGGpd1J7Zfy2vlnTxTHEHxwtqXk4dPny7HthWYa4i5NZnWe2tK4LZM=
Received: from SEZPR02MB5495.apcprd02.prod.outlook.com (2603:1096:101:4a::13)
 by TYZPR02MB5889.apcprd02.prod.outlook.com (2603:1096:400:1f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 17:54:43 +0000
Received: from SEZPR02MB5495.apcprd02.prod.outlook.com
 ([fe80::4fba:bc9b:33e3:6f95]) by SEZPR02MB5495.apcprd02.prod.outlook.com
 ([fe80::4fba:bc9b:33e3:6f95%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 17:54:43 +0000
From: "Haowei Cheng(Harvey)" <harvey.cheng@fibocom.com>
To: "chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: 0001-usb-mtu3-fix-panic-in-mtu3_gadget_wakeup.patch
Thread-Topic: 0001-usb-mtu3-fix-panic-in-mtu3_gadget_wakeup.patch
Thread-Index: AQHbLuJOhIt9NRu7m0GuzhYM0mppkA==
Date: Mon, 4 Nov 2024 17:54:43 +0000
Message-ID:
 <SEZPR02MB54953820B2A9EEBD807D0ED18E512@SEZPR02MB5495.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR02MB5495:EE_|TYZPR02MB5889:EE_
x-ms-office365-filtering-correlation-id: 059a4903-c1a1-416c-6094-08dcfcf9c351
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|8096899003;
x-microsoft-antispam-message-info:
 =?gb2312?B?N1BYZEJUSjQvNTlzUzZneTBialIxS3l5NEV0YW93WXhLV2N5MEhjMUlJNUlh?=
 =?gb2312?B?YnBDUXNwVk5lWjI5bDZPbzRBZWhpSHNPQnFOMzR6VFUzOEdlU056alhkZ05Z?=
 =?gb2312?B?U09QeDJ6Q2tCR0VYR2U1UU1VVTVJQVp2UzZhZ21ha2VIZGRCalAyOFQvQ3RT?=
 =?gb2312?B?cHRSRG1vL0xsMHlnbmpaLzVUR09rY3p3M0ZjRHdqMnRqQlgzWVlkZ2t0NHV6?=
 =?gb2312?B?VHovYkg3N0dCZkp4R3FBSjAyQ2pZU0FyVjhwV0VmSG5xNFZLNk0yK3JDWEk0?=
 =?gb2312?B?SUU0TUx5cXhPTmFVeUVZZFF5dEYxTHh4ck94VEdHQVQzazNaSC9FbUl5cVhk?=
 =?gb2312?B?alI2dWhCYysrNW1JUUNKUlROUXZZdEg4MnlZMXRwcWtyUFR0WjR6YmE1Z0py?=
 =?gb2312?B?bjhvZUZxNEF2SlppWUFFaXcxWXpVcFF2aFJrZElSQTVGMm9YQ2RmdGVKZEN4?=
 =?gb2312?B?azZmSlBGUGJCdXNsbVE5VzRGcEJrODBYZTlIT3hMQmNRYXRZckU3QkIyYm0v?=
 =?gb2312?B?RWFPS08xZGxyRlAwc2kwMkdmNkJINWNkOXJPSjdHYW9FSVo0UkFBUnU5OTZZ?=
 =?gb2312?B?bjlQbFVGa0JTOVpBU29hblFrbnZUWXJ2S0ZXQi93SGtyaXhZK1lsRnYyUkdl?=
 =?gb2312?B?U2kzMWg0QWJEK2V5d0VVQTNReGgwdVZkSVBpRmh6aHp0YisrVE9ncVMwd0ho?=
 =?gb2312?B?Z0orLzM0R3FGMjRpbnlQVmR0d0d1MFBpekp1V29DWVlzR20xeitvWG50YXI3?=
 =?gb2312?B?T1dVSGtuN2hZTWQxY0VFMG82S2g5dDFaZUdXakRjdEJhY1RvSzFhK3FISXQ4?=
 =?gb2312?B?LzVOUnlkbDI1TmQzTDkzczRwcWpOSDNQNWpQWWtEYk02UzZGMzNLWDNRYjJt?=
 =?gb2312?B?MzVZdUZvUXhaNTZYQ2drK3pEMUs0Mm5oMTE4aTdqZzROeDdBWm1UbUtLUE1O?=
 =?gb2312?B?eEtIQ2ZBRFVJTk12UzUweHBxZTBod1d2UjVNOEdMSnUrM3JBWkhLZ2pyVTJt?=
 =?gb2312?B?RXlpeGFKNk9NejkzYm82UGdja3J1UVNRa2hKYXVOczd4dFY3ZnFoZmJhZm9U?=
 =?gb2312?B?cmdZek1YeGs3YTNlTS9NU1BQSVlaaXZZWTJHbWR0WmExTEYwcnUyZFd6cVp6?=
 =?gb2312?B?d2t5dWJmczhHYlc1OVdUREh4eWU3Ymx4VFVTamFOdUNaSXRIeFJKV3czSjdr?=
 =?gb2312?B?YmNXTlYyTlkxaTh1ek9VVFRjUDE4ai9PcStDR05nbUNlaHpHNjZxWnU0OC9B?=
 =?gb2312?B?aTBPSlcwYlBRUS9Uc3IwdnkrMWhFVHkxZXJlTnpVVGVSMFVDQy92R2t4MHNF?=
 =?gb2312?B?dlQwVVB2QWMvVHpmZUtWaHhScmp5U3lKTUxkSE90QVZVZENyUlV3TExOOVhs?=
 =?gb2312?B?RUo5WGF5T043L01EWFZocVdmK1J2bXhod0ZZaVFObEhoMUt3OWJaZjVnRnNE?=
 =?gb2312?B?THpEcytyMDVmcWZPLy9jWXZibjNlT2FXa2x6M3FrS1dwY0NSd205Q0hsaCs2?=
 =?gb2312?Q?tug1sY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB5495.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OGUxYlM1WE5GNkZ1alF4M1JmQVFXcXdxRG9sbWJqbzlLK25oQ29EaE1mcDJW?=
 =?gb2312?B?ZERYSEhYVEc3UGY2OGtFZnRDdjN3NTAyNWdQK1diRHg0UmRXY3FpVzRmc2FF?=
 =?gb2312?B?VExMNTNUWFNCU0ZzTWRpTVFtREE5d2hnY0xubk1xeDJyMk5DQSsrQ0pZNThJ?=
 =?gb2312?B?RllhVW9GcTlXVWN5aEw5SkphRU84anZuZm45TzYxNlBBNFdqZ09rOVlReUVV?=
 =?gb2312?B?YnFNOVR3Y0szV3FLQmw4QmxDb1Jod3Z0SzQ1bUU2TzhRa0V4UWd5QmJsd3Av?=
 =?gb2312?B?RnB5cHpuS2hqM1pPQ1RBQ21FZXZ3Ry9CcElsVWY5aS9oVXY4S09wMURQaXVV?=
 =?gb2312?B?Z1FSNE5BRm54MmVVWDR1V3BJaHBwYXFUeGRKTkhRZTZyemZCRURJVFpuRWEv?=
 =?gb2312?B?QUJIcmM4dTQrT3dKWWV5VmVsM01YN0xEVlcyamVSOG9UdzJxdGw2Y3FDdU5Z?=
 =?gb2312?B?TzkvOTd3bmVRQ0pjdUF6c1ZnclhreG9VKzVhd1JCRE1LZVdKYytabnM1Ky9P?=
 =?gb2312?B?MVd0WW1KZzRjb1lYNlNySkRHWFZtTGZuOStTTUd2UEZxb3owaGo5RU5PMWYz?=
 =?gb2312?B?dEdvZEJScGRlek92UkZyd0h4Qkx6ZFBPTndqbFdxRTRmNGFGOVFjc0JkaGxp?=
 =?gb2312?B?UThQVEt6ZThlYnRUSFZqbWxtTnF3bmZlSjY3QlNyOXlFQ2w3Ukx6OWVyNndG?=
 =?gb2312?B?ckR1Q2V6cXNGQmdZYVo0TmpKQnh6M1N1Tm5iVnVJd2hFMVJOcWtnWllzOGRM?=
 =?gb2312?B?TjhkWWl1L2xpWFBrKzJjdHMxZE1nVGxCaEFPT3BUbjVidUVUVUxWZUtHTlZN?=
 =?gb2312?B?Z0t5cUh4SWYwbHRaaWxoZE9scEdzVUFQVUFvZFJTNkE5NXg4dC8zeWgyaHNr?=
 =?gb2312?B?R2M2Ykt3d2FpVzFLZDVSYkFoRGtobXlGZWY1cmg1Wmd0dmtTclF0eDkwWk8v?=
 =?gb2312?B?VC9rU0hzLy83ejAxN0lLaTZmUE44azRyRFIvbmFEdzlwa3FKR3NDOVBkK0Vs?=
 =?gb2312?B?QXJwWVlQbGFRaVpvNG1hM3VWRGV0Q2p6WExJMjdKVmZuRzJYOHFXSnZFb2hk?=
 =?gb2312?B?YVZwQmN4MEQ4cjNVemdMQmxNZm1jN3Zia1MyMThyS3VPcE0wMGIyTzh4Vy91?=
 =?gb2312?B?VHpUWC9TK3hXdHBDNUtpdUtIS1RraXJhUks1UGpMeGVtNFp1amxndDNadVRF?=
 =?gb2312?B?UThYczhjZlFXRWtqUUJqUVFVNjJFYmFzWW9zZUx1c3RCV2hsNWdGTEFHSVJI?=
 =?gb2312?B?NWI2ZU8wdXdLaVhjc3UxZUNXd3ViWGZ6SDlPemtOcDBqeGcyMkRLaDl5RXc3?=
 =?gb2312?B?UGREb09MS1dzUnBTMS84RXlXWTNzL2xnRGxYb2RsVitRbUJiQlFKa3F5UEtI?=
 =?gb2312?B?Vk1vMitTYjlkTW13Z3QwMUFSTWlTZ0g1bFRSbWJQQzBJQmE4WWtReUdBMmxY?=
 =?gb2312?B?WXU5WUtpMHdscFZDRWFrN2JibXZCYzg1VmFGd2JyOXgzK0pSNmFZY1VkU3BJ?=
 =?gb2312?B?eWxNb1VKSE94RGJ1SkhwbS9Wa2g4VFFFcFk5WjAwMDhXbjh5cDQ4YTNDRHR4?=
 =?gb2312?B?Y0tTVUVBWWtyd1N2aVFRVktNNitZMmF3TU9RNHE4ZUpmdjRqVmRzSVBZVFRU?=
 =?gb2312?B?ZkFic3hIOEd2QzNjaXU5UTd4QU9aVjZkcm1yUlM0NVNpa0UvMFpnRmE2RU5a?=
 =?gb2312?B?M2xUVkxNNWlteVJCOFVDQm5iNFBpdnlnYkNkOU5mWHVrVTBxMkErY2RpYmNY?=
 =?gb2312?B?SHRKaVBxTlR2OW0xSDQrUUxQcHV1SlVxRDAzOW10Y0kwcHFOZ0xaM0tnWXMy?=
 =?gb2312?B?THZ5TXpOWXEzQnRWMGNNS0ZXcm1qNUpFQ1NFRzR5MWtVb1dnd3NMUURjcGQv?=
 =?gb2312?B?WHN2VEZ3eEZDSFZLcGVwU1NOSGYydko1dDFCQitjcVpRN0tvamhaTi9aWDlj?=
 =?gb2312?B?NGZRVjlWSm1OMXovd0NiZ0JsbmRYU1ZTQThRWERHdzMxS3hTY2JlTHZtWFRZ?=
 =?gb2312?B?MEdxVW9VY3owRjNHRjF2OVBuVVVMU25vTGt5S2c2eUd3Z3Bub0NHeC9YSjJB?=
 =?gb2312?B?ZjQ3Vk5mTUZ0UHlhM0lkSDhVVWVpMHkvT2syd0l3emkvdUMzaEcveGd5RzlW?=
 =?gb2312?Q?VVSZVZ+NVfKw2tkTSP1kySKE4?=
Content-Type: multipart/mixed;
	boundary="_004_SEZPR02MB54953820B2A9EEBD807D0ED18E512SEZPR02MB5495apcp_"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5495.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059a4903-c1a1-416c-6094-08dcfcf9c351
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 17:54:43.3117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8L5qLrSP5pKYL3OkZiSV9ocYncLxekxPEo04jQLklVPZEkihhPZmK3vKrZuVsFT0yJLhIEaXGEMaauhBkxTs4ikkBAfmnM4uNy2ir8hjfzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5889

--_004_SEZPR02MB54953820B2A9EEBD807D0ED18E512SEZPR02MB5495apcp_
Content-Type: multipart/alternative;
	boundary="_000_SEZPR02MB54953820B2A9EEBD807D0ED18E512SEZPR02MB5495apcp_"

--_000_SEZPR02MB54953820B2A9EEBD807D0ED18E512SEZPR02MB5495apcp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

DQo=

--_000_SEZPR02MB54953820B2A9EEBD807D0ED18E512SEZPR02MB5495apcp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: =CE=A2=C8=ED=D1=C5=BA=
=DA, sans-serif; font-size: 10pt; color: black;">
<b><br>
</b></div>
<div id=3D"Signature" class=3D"elementToProof"></div>
</body>
</html>

--_000_SEZPR02MB54953820B2A9EEBD807D0ED18E512SEZPR02MB5495apcp_--

--_004_SEZPR02MB54953820B2A9EEBD807D0ED18E512SEZPR02MB5495apcp_
Content-Type: application/octet-stream;
	name="0001-usb-mtu3-fix-panic-in-mtu3_gadget_wakeup.patch"
Content-Description: 0001-usb-mtu3-fix-panic-in-mtu3_gadget_wakeup.patch
Content-Disposition: attachment;
	filename="0001-usb-mtu3-fix-panic-in-mtu3_gadget_wakeup.patch"; size=1769;
	creation-date="Mon, 04 Nov 2024 17:54:11 GMT";
	modification-date="Mon, 04 Nov 2024 17:54:43 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4OGFhNzc5YzYwZjk5ZjQ3ZjQyY2E0ZjZlODViMjc3NmU4N2I0OTRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiaGFvd2VpLmNoZW5nIiA8aGFydmV5LmNoZW5nQGZpYm9jb20u
Y29tPgpEYXRlOiBTdW4sIDMgTm92IDIwMjQgMTA6NTE6MjIgLTA4MDAKU3ViamVjdDogW1BBVENI
XSB1c2I6IG10dTM6IGZpeCBwYW5pYyBpbiBtdHUzX2dhZGdldF93YWtldXAKCldoZW4gdGhlIG10
dTNfZ2FkZ2V0X3dha2V1cCBmdW5jdGlvbiBpcyB1c2VkIGluIGFuIGludGVycnVwdCBvciBhCm5v
bi1zY2hlZHVsYWJsZSBjb250ZXh0LGl0IG1heSB0cmlnZ2VyIGEgc3lzdGVtIHNjaGVkdWxpbmcg
ZXhjZXB0aW9uCiBkdWUgdG8gdGhlIHVzbGVlcF9yYW5nZV9zdGF0ZSBmdW5jdGlvbi4gV2UgaGF2
ZSByZXBsYWNlZCBpdCB3aXRoCnRoZSBub24tc2NoZWR1bGFibGUgZGVsYXkgZnVuY3Rpb24gdWRl
bGF5LCB3aGljaCBjYW4gZml4IHRoaXMgaXNzdWUuCgpCVUc6IHNjaGVkdWxpbmcgd2hpbGUgYXRv
bWljOiBzd2FwcGVyLzMvMC8weDAwMDAwNTAwCkNhbGwgdHJhY2U6CiBkdW1wX2JhY2t0cmFjZSsw
eDAvMHgxNzQKIHNob3dfc3RhY2srMHgxOC8weDI0CiBkdW1wX3N0YWNrX2x2bCsweDY0LzB4ODAK
IGR1bXBfc3RhY2srMHgxOC8weDM0CiBfX3NjaGVkdWxlX2J1ZysweDUwLzB4NmMKIF9fc2NoZWR1
bGUrMHg5NC8weDQ2OAogc2NoZWR1bGUrMHhhMC8weGU4CiBzY2hlZHVsZV9ocnRpbWVvdXRfcmFu
Z2VfY2xvY2srMHhhOC8weGUwCiBzY2hlZHVsZV9ocnRpbWVvdXRfcmFuZ2UrMHgxNC8weDIwCiB1
c2xlZXBfcmFuZ2Vfc3RhdGUrMHg1Yy8weDkwCiBtdHUzX2dhZGdldF93YWtldXArMHg5MC8weGQ0
CiB1c2JfZ2FkZ2V0X3dha2V1cCsweDFjLzB4MzAKClNpZ25lZC1vZmYtYnk6IGhhb3dlaS5jaGVu
ZyA8aGFydmV5LmNoZW5nQGZpYm9jb20uY29tPgotLS0KIGRyaXZlcnMvdXNiL210dTMvbXR1M19n
YWRnZXQuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbXR1My9tdHUzX2dhZGdldC5jIGIvZHJp
dmVycy91c2IvbXR1My9tdHUzX2dhZGdldC5jCmluZGV4IDk5Nzc2MDA2MTZkNy4uMmFiNzMyNzAx
NTUxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9tdHUzL210dTNfZ2FkZ2V0LmMKKysrIGIvZHJp
dmVycy91c2IvbXR1My9tdHUzX2dhZGdldC5jCkBAIC05LDYgKzksNyBAQAogCiAjaW5jbHVkZSAi
bXR1My5oIgogI2luY2x1ZGUgIm10dTNfdHJhY2UuaCIKKyNpbmNsdWRlIDxsaW51eC9kZWxheS5o
PgogCiB2b2lkIG10dTNfcmVxX2NvbXBsZXRlKHN0cnVjdCBtdHUzX2VwICptZXAsCiAJCSAgICAg
c3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEsIGludCBzdGF0dXMpCkBAIC00NTAsNyArNDUxLDcgQEAg
c3RhdGljIGludCBtdHUzX2dhZGdldF93YWtldXAoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCkK
IAl9IGVsc2UgewogCQltdHUzX3NldGJpdHMobXR1LT5tYWNfYmFzZSwgVTNEX1BPV0VSX01BTkFH
RU1FTlQsIFJFU1VNRSk7CiAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm10dS0+bG9jaywgZmxh
Z3MpOwotCQl1c2xlZXBfcmFuZ2UoMTAwMDAsIDExMDAwKTsKKwkJdWRlbGF5KDEwMDAwKTsKIAkJ
c3Bpbl9sb2NrX2lycXNhdmUoJm10dS0+bG9jaywgZmxhZ3MpOwogCQltdHUzX2NscmJpdHMobXR1
LT5tYWNfYmFzZSwgVTNEX1BPV0VSX01BTkFHRU1FTlQsIFJFU1VNRSk7CiAJfQotLSAKMi4xNy4x
Cgo=

--_004_SEZPR02MB54953820B2A9EEBD807D0ED18E512SEZPR02MB5495apcp_--

