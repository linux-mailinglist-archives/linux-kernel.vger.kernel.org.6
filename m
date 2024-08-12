Return-Path: <linux-kernel+bounces-283120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F276594ED71
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DF01C21BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056EE17BB01;
	Mon, 12 Aug 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P+cPJ22Y"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192E016D9AE;
	Mon, 12 Aug 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467437; cv=fail; b=Druy9Tr17FG0moKhuOXD4Mq5zle2DzgWrkw9uAqqFUDp7ONl8r11kMho7/NuyLEFAFzKDJhXpvP6NuSNx3DCPdLdqLdWgmOx85iVedflyTwrPzfjAJvhPXrTZf14RZvBggKQM//lNWieXs47ARMZ1CLBq8PXCfle+WwJFXbphac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467437; c=relaxed/simple;
	bh=TxaFcbvP8A9cAGQU3We9jHrOSRCPqaqnIzwxJDyj+9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GLF1tFipS7R4CpejzFTmzeiDK/93vvUp3BySr6BCSrCCchN27naCA9n/e7CbjH48TLwcsUjphZgBSE+ggOFRUIVDuTJtpIcp4KCve8NXXEHES7OlXNsVlWV/idoHUiNkvximb5a5e8Ch8t06cRivrzY4njBehOm3Ccm5IKVFJJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P+cPJ22Y; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvQiQDJpJiPMcEREXZcc6XMQaMvLJl7EhIOkrXuYe/coSECgVPFIzLuL1HccmfhO2Jr7uwz6r4IrfobtC1tBgQKTMYCY3QQ0N4x5sjj3BCtQ6G0h+XiQhNl6uPj0fxDaNF2GKgGKmK8QIWKXt/qUwzzlNJoZ20mO+fb8hWZYD0jnE3vPEtYx7dKtjSmu2J1lm4sIO1prtUxtgOTV9PmbUQmTM2V2fMG6QmCFBA4LRa70GS+tEd3MsYe/FF3JY/cX7WGDtXxvUTEGciH4DVGqFMIUURB0NJtl1TUpz/WVAM4TfskH1jbxdeMP2yRlohVQkXHTmYKAIC+D1PUpmEV/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxaFcbvP8A9cAGQU3We9jHrOSRCPqaqnIzwxJDyj+9I=;
 b=jk+w+8oS1ngDoUMye7lN+pWHnzijX0mmOb9dfAwo35sIJ5+Cih47t0d/YMCZLY+t7yZgrvEw2S2cxDCKzQ3MpblGKw2FB6Sw877Qxa8DUc/V/2YUhbXf3OXGjyiSXy6BStT+jc3iw0W2IMJ8Cof7sVrEv9aWxOGc1hft7O1XS5fr+Tii3YQlOfO4/c6lv/2z41leJxfbjF/poEBqz29Q3dXi0lk+bSbrIBf5TbQ7tXlQ00gObDmx6qxcSiWP/lPGYuIVpKWZSFeHU3wwrnfpPAx2XL23uTYMNjuiImeDOelPS7ygMVED8ssYSbBelPKKnHPVp8MITaFdEH7eR2iSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxaFcbvP8A9cAGQU3We9jHrOSRCPqaqnIzwxJDyj+9I=;
 b=P+cPJ22YizNmBJXoMZ036gpTswop6ho1+RNAwEWfU5aq4iwDHYhAnK2QIIkneXM1gZw4Jh7LwXebwl/WxqGpxJDBkJUOz9OCtMqNvTmmCxjb0k/I89hVKLrDyTmiiB1S0K/uYBG12t6KmGH4vkg94gOQMJcXuOalN8vOdWb5ozU=
Received: from PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 12:57:13 +0000
Received: from PH7PR12MB7284.namprd12.prod.outlook.com
 ([fe80::52ac:918:fc6:8092]) by PH7PR12MB7284.namprd12.prod.outlook.com
 ([fe80::52ac:918:fc6:8092%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 12:57:13 +0000
From: "Trivedi Manojbhai, Naman" <Naman.TrivediManojbhai@amd.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "Thangaraj, Senthil
 Nathan" <SenthilNathan.Thangaraj@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] drivers: clk: zynqmp: remove clock name dependency
Thread-Topic: [PATCH V2] drivers: clk: zynqmp: remove clock name dependency
Thread-Index: AQHa3DFjsadbNYIEYkaS7Q2JUnj/tLIeEaqAgAWcUdA=
Date: Mon, 12 Aug 2024 12:57:13 +0000
Message-ID:
 <PH7PR12MB72845D56BF4361441AA9CB9A8A852@PH7PR12MB7284.namprd12.prod.outlook.com>
References: <20240722121910.14647-1-naman.trivedimanojbhai@amd.com>
 <ac67f76d4b4b5f4bf108c1457f1263c7.sboyd@kernel.org>
In-Reply-To: <ac67f76d4b4b5f4bf108c1457f1263c7.sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7284:EE_|IA0PR12MB8907:EE_
x-ms-office365-filtering-correlation-id: db11b71d-62b9-49d5-b3ba-08dcbace48fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?emY3OHQwUXlySmVSOW8rQ0c5a0lnaEUwdDBmTVlaWmxrV21jb1BhSjVpZEtJ?=
 =?utf-8?B?MmZRNHlpekpwNnJpclNmUXdhVDB0bS9JQ3JFNFZkSGhqRDFtclo3WnpGRC9R?=
 =?utf-8?B?S2lJWFl5MUF5K1h2ZytBRVF0RXgvME5abExmMFFORXFySHY2UXhwWWZUV2Uy?=
 =?utf-8?B?d3d2aWlpUnBsK25mS1ZLNDl3SU1FanZXdTg0ak5CZ2xBU2x0RHJuWHpramEr?=
 =?utf-8?B?SVlRQUp1K3Y4UGdPZGFYcElUSVlDT0FlUEN0ejh6enJGckxTN29vbW9GZnFa?=
 =?utf-8?B?akRGdWZDdDduQW1jbXZFL3phclRLRkUranBzTEtyT3A4cFcwVVBKakFVQU5Y?=
 =?utf-8?B?MlZueU0zcnVKc2pCWWJtNnVNMzhsc2dvSFAydzNSemI2K0FNb0laSktBeUcw?=
 =?utf-8?B?YlZGNTVaVlM3Nnd4ZFpXTW1iS1hQZUZ3UlQyaU5Sd0tHMksrRUF3NFhQLzFD?=
 =?utf-8?B?amkza0pTQ0dCOFd5OWt5SFROb0U1Wm1iMnk3OFVHSU5NcFJjbVBabHJhMDRp?=
 =?utf-8?B?M2h3VUhrcGNUVXdac3FqbWpXNzE4Q3BYZDNEYzdEYzRHdGF6S2h1MDVTNTVD?=
 =?utf-8?B?a1VyclI2RVl0bkhERHdMTnRiZjNoaHhEellCNzlkUGNzTGsxR0hzOG9DcVBt?=
 =?utf-8?B?alZuQ05Za09YWTV2K2puNy9DbzlsUU9ZaUN3V3l4Zi9PTXZ1MXU3UGhBNnlt?=
 =?utf-8?B?U1luK0pvcHZVd0taSU43WUd3S0plaUM0d1hMaWVkK1h6Qjk1dnduUWE0SVBj?=
 =?utf-8?B?Z2lYZ2gvSi95V0tSUlhTeE9vcVdRc2ZIQWR4enc4S3pMZEpIaWdjbkNjY1J0?=
 =?utf-8?B?YjhNaEVGNW80K0lrTDRTVkp0VndNZ3U4L1FWRmlxM3pBR3RpZ3VKUGUyTko4?=
 =?utf-8?B?U3ZqeGw4bjhCOTZKMEt5MVN2SlpJN3dENnNWNjhRaVFsNGE2Yjc2ZkJiVkFW?=
 =?utf-8?B?b1dmUWhDOUFGWHpQMkJaZnFUMWdCSENaS1I3RE1YR3ZaS3ZUY2x1alZRQXZ1?=
 =?utf-8?B?dzU0QmNvYnZJOEJxVlN1LzhscGc5VlRRa1FoUGFFUmRwWlZlNEhvekFhY1k2?=
 =?utf-8?B?S3k3UEpQVUhzb2Vxam9LZjBSMUE1OGgxd3JySFZFR24vZFBYYktRS2QvVHBI?=
 =?utf-8?B?TmFobUJxTDl5RjQ2L0JIVGpRcE5JS0d5dG5VSzBKYXlxa0tYKzNickIxeUZO?=
 =?utf-8?B?a2hBOEhSc2hERE9BVkR0b0lGNkd5SE02aGVENFZ2Y1FPbmRTSHdMSXFkWHhT?=
 =?utf-8?B?clo2akVpeXhwYjZmTkJ4bkZDUVhnbkc1cEc5cWFFcDBNbkRpOEdUWlBKRkFh?=
 =?utf-8?B?SzV5UjZuaHQvYk9uZDV1ZE5YMmx0OCtLcUVnSkkvR3d5U2pCTWRXcGpiRFph?=
 =?utf-8?B?NDJYQU1tRDJvSldOWFArYkJOMzExeTY5a2NoL09ZRFBvOThxV2dwNmxzT3lQ?=
 =?utf-8?B?ZUZkN0lETHRlRXo0T3VkaVorQW9LRDg4NHJoZ0VoTHdlZkR1VHh5MmI1b1V6?=
 =?utf-8?B?aWlTaStNVjdxM3ZSRjlNb2R2YVhHS0RlV01pK1dqVVIyQ3JhckhMVStaOGNB?=
 =?utf-8?B?WUMzR1Zmb3JQU01PT1h4WG5Mak5qdVcvWk9qem1YUS9qRGNvNWNWRy9wSkdJ?=
 =?utf-8?B?VmhRbWVkUHZUR2J1SWI4TDZBUm5ZOHVMYVk1bnhRZEoyS3lReXE3MGwrME00?=
 =?utf-8?B?ZE1Yck50R2E1VFJvU0xNc2FsUlB0Mys4NkkzcXZhREdJQjhadDU4c08yMUgz?=
 =?utf-8?B?VHMzcSszWW1oM3NVVXErRHZwYzM0OWFDeE5HdnZoTmVUcTdTaWROZ1lpYlB6?=
 =?utf-8?B?OXBQVUhZM0M2RFRlazlyNVdxYW1MK3U1TnVqbzkySk1scmxyUFRrcU9WUlRW?=
 =?utf-8?B?MmY1d1NCZHc3R2tJdzYwUHVZSFd5Mndhdi9jaDZQcWo1M2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7284.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?am10MDcrTU5Xem52UjlMUnR6aFNxRlVaMzZiWmc5cjlKZFVxSDk2UGJYREhV?=
 =?utf-8?B?eThVYjN5cjNHRVhCb09rcE9ETTZhWHd6ZjR1QllvalRETUdmZ3Y2QUp5UUg4?=
 =?utf-8?B?cG5ydXBENjk1QStoTHR3M0YrVThHbFFQSmE0ekpMdi83RHJVRzNYUzhEMU5X?=
 =?utf-8?B?N2ZvQkQ4SUxlL2hxdEViV1QyZjUydk1OajFhd0I2dmtBdVpkcFQ2WHZuVm9p?=
 =?utf-8?B?ajBheGNxdFkvSjc3SDkxMW81UkI2R2hGdkh5N2ROOU1SaDNncUh0eWRHRlk5?=
 =?utf-8?B?QW5POElhbWVUTi80elFFdXpyc3pOVDAzNUIwL3pQWTQrZVhsaFgzS3Z3TkZF?=
 =?utf-8?B?NlQ0UUJ0OEE4QjM5bGxTYVZQc1VCVnZ2bnNiUzdOWjdwSG0rN29LdEkxUlV1?=
 =?utf-8?B?blNTMEhOdUFSeVFoS3llZmJKU3o5dXVOeGtTZWYzRjBKbHovdVRHeHZWRDM4?=
 =?utf-8?B?bGx4LzQ1VGJVWVR2S0NPYzAwbUxuRitOcGZGZ0JWbnk3bng0SGgxRTkyTXgv?=
 =?utf-8?B?c25Ba3A0WmVWbzd1a2lzWER0OGVtVGVDVlRTOEdvcjRqVmZqeEtXUVJqS2JY?=
 =?utf-8?B?ZGlHMjV4d0NSUjlhOHRjMWliekFVcTFSMlRVSENLRFIxV1ZnZXczaDB1aU11?=
 =?utf-8?B?QXRYZnJ4eVlvNVYycWdsWUpyL2FEeVdnS3BTMkY3N0xYNzB4QVJ0SFJ6Qktj?=
 =?utf-8?B?WHR0NFRER3M4a2hrVzVXSDRvald2RUxpcHZKNzYxdlVhaENBbG5Kb3MvSnMx?=
 =?utf-8?B?Q1RCNlY1ZnFBWjd1SkQrNjVJRmNNcHFtQldWRTJYWC8yTGtudmdHOEswV2Z6?=
 =?utf-8?B?Q2lXZjNHYUpIY3RpTnJoOXFaUGpMbmFmVzZrTGR3blNVVkZpLy9mSjlrUUhm?=
 =?utf-8?B?c09ETlUxczR3K3ZFRHpYQThEZ05SL1R1N2hMUjRnLzBOQVAxUDRTUngvT3dy?=
 =?utf-8?B?SDU3UnBsUm9sdThVc1Roc09wMGN3cEg5R2xKdjdlTHA5OWhsZWJ4eG4wRnlE?=
 =?utf-8?B?WndOSE1ZZTlPc2w2Z1QwbnZrY0l6Skt6NzR0TjFQM1FrdlJEdkNJWmtXNm5D?=
 =?utf-8?B?bXd6MGFDYWx1dzZlajVpWEt3MFI5a2gwQVhCekRsYjd5QTNBdWlmYnEzVW1x?=
 =?utf-8?B?ektCRDE0ekZxanVkSHprcG5pcGJvNStzL1F1V0tuYkVqNnNtNXhHYUxHSDFH?=
 =?utf-8?B?RkFjeDhpQlp6SG5NbGNZZ0RoOS9SOWQ0ZndsbllTWldGSkZUZ0tjTW5pTU1S?=
 =?utf-8?B?aGtnS3F6RnFwQ0ppa2NHd1NicHc5VENGT1o3UEZQS0NNZUF5YXVwZHRDc3Z0?=
 =?utf-8?B?dE5adXhLSi8xU2xCMjYxNmZveC9hLzhKc1ZWZjh3L25iUmtSSUR5U2JGaHdV?=
 =?utf-8?B?WWc0c3ErdEFBVkFaVEthS1diSWE5cTdRNjJMbjNyUHFzNThDWXJNWXBHUXQy?=
 =?utf-8?B?MmVWd1huOGQ1cjloNWZRM0tQWmE0M1JLMEpybEpiMktZMlhGNkhpUE5Ncm93?=
 =?utf-8?B?U1cyUlhSaXV4MXhnTUdabm1RV09rYkV3MXVwb0lIL2NGSkY4VGNIZ3FKZUJD?=
 =?utf-8?B?R3ZmQ284djRiM29JdVpOUUlkakNEc3E0QllqZEdRRVZsVm5rTmF2NFRRbFRM?=
 =?utf-8?B?aGFHanA5bmpOK3RXdnlZSVgzTndzMXUyK2RLV2o0R2h5elFiclgrL2RyUURj?=
 =?utf-8?B?MU8rU3RRR0FoaS9BRkdyeGd4OHhZVGtjT1JDMlJKUzAzZVc2clc0djB1UGs3?=
 =?utf-8?B?QXJiWjZ3NUFWU2dxclQ5cUhERVJqSi9QUlNVWTlQeVJPNjNRbWFaQmQ3UjJ3?=
 =?utf-8?B?a20xbU81MC9OUzF4SUhXZVAvS0JjcFh5bmV4UXFnNGwrdlBjWlJDVHJ6RWRT?=
 =?utf-8?B?SzJnR0t2WWx0RjhmNFBLMGozNTg1KzBoTEgybTlrNzJiYXdsZEtCa241T3J3?=
 =?utf-8?B?K21hTmtNZStpYU44c0xROEdpVVNrMHZWNXUrZUxETWRhcWV3ZkZxQW9vZnhL?=
 =?utf-8?B?ZkhjeEJxUFNXM1NpRjdQbW15ditxNlBUNVR3OTRaSldBRHowT2FKTEFxTDVO?=
 =?utf-8?B?NGMvZDlpWkM4SDkzc1dJb3U2VGVGV3FLaGZyUlFBWE1ubzFDb3VCb2I3MUxx?=
 =?utf-8?Q?kL24=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db11b71d-62b9-49d5-b3ba-08dcbace48fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 12:57:13.0344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fel4kuzRtuhofaAZfkiy6vkCxOjBC7+qf9H7e4uNVzPzM4M3X19IGOrvGPJnziFm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907

SGkgU3RlcGhlbiwNCg0KVGhhbmtzIGZvciByZXZpZXcuIFBsZWFzZSBmaW5kIG15IHJlc3BvbnNl
IGlubGluZS4NCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogU3RlcGhlbiBC
b3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPlNlbnQ6IEZyaWRheSwgQXVndXN0IDksIDIwMjQgNDox
OCBBTQ0KPlRvOiBUcml2ZWRpIE1hbm9qYmhhaSwgTmFtYW4gPE5hbWFuLlRyaXZlZGlNYW5vamJo
YWlAYW1kLmNvbT47IGxpbnV4LQ0KPmFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgtY2xrQHZnZXIua2VybmVsLm9yZzsgU2ltZWssIE1pY2hhbA0KPjxtaWNoYWwuc2ltZWtAYW1k
LmNvbT47IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBUaGFuZ2FyYWosIFNlbnRoaWwNCj5OYXRo
YW4gPFNlbnRoaWxOYXRoYW4uVGhhbmdhcmFqQGFtZC5jb20+DQo+Q2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IFRyaXZlZGkgTWFub2piaGFpLCBOYW1hbg0KPjxOYW1hbi5Ucml2ZWRp
TWFub2piaGFpQGFtZC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCBWMl0gZHJpdmVyczogY2xr
OiB6eW5xbXA6IHJlbW92ZSBjbG9jayBuYW1lIGRlcGVuZGVuY3kNCj4NCj5DYXV0aW9uOiBUaGlz
IG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBj
YXV0aW9uDQo+d2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVz
cG9uZGluZy4NCj4NCj4NCj5RdW90aW5nIE5hbWFuIFRyaXZlZGkgKDIwMjQtMDctMjIgMDU6MTk6
MTApDQo+PiBGcm9tOiBOYW1hbiBUcml2ZWRpIE1hbm9qYmhhaSA8bmFtYW4udHJpdmVkaW1hbm9q
YmhhaUBhbWQuY29tPg0KPj4NCj4+IFVzZSBzdHJ1Y3QgY2xrX3BhcmVudF9kYXRhIHRvIHJlZ2lz
dGVyIHRoZSBjbG9jayBwYXJlbnRzIHdpdGggdGhlDQo+PiBjbG9jayBmcmFtZXdvcmsgaW5zdGVh
ZCBvZiBwYXJlbnQgbmFtZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBOYW1hbiBUcml2ZWRpIE1h
bm9qYmhhaQ0KPj4gPG5hbWFuLnRyaXZlZGltYW5vamJoYWlAYW1kLmNvbT4NCj4NCj5UaGlzIGlz
IGdyZWF0ISBUaGFua3MgZm9yIGRvaW5nIHRoaXMuDQo+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jbGsvenlucW1wL2Nsay1nYXRlLXp5bnFtcC5jDQo+PiBiL2RyaXZlcnMvY2xrL3p5bnFtcC9j
bGstZ2F0ZS16eW5xbXAuYw0KPj4gaW5kZXggYjg5ZTU1NzM3MTk4Li42YmI5NzA0ZWUxZDMgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2Nsay96eW5xbXAvY2xrLWdhdGUtenlucW1wLmMNCj4+ICsr
KyBiL2RyaXZlcnMvY2xrL3p5bnFtcC9jbGstZ2F0ZS16eW5xbXAuYw0KPj4gQEAgLTEwNCw4ICsx
MDQsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19vcHMgenlucW1wX2Nsa19nYXRlX29wcyA9
IHsNCj4+ICAgKg0KPj4gICAqIFJldHVybjogY2xvY2sgaGFyZHdhcmUgb2YgdGhlIHJlZ2lzdGVy
ZWQgY2xvY2sgZ2F0ZQ0KPj4gICAqLw0KPj4gLXN0cnVjdCBjbGtfaHcgKnp5bnFtcF9jbGtfcmVn
aXN0ZXJfZ2F0ZShjb25zdCBjaGFyICpuYW1lLCB1MzIgY2xrX2lkLA0KPj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKiBjb25zdCAqcGFyZW50cywN
Cj4+ICtzdHJ1Y3QgY2xrX2h3ICp6eW5xbXBfY2xrX3JlZ2lzdGVyX2dhdGUoc3RydWN0IGRldmlj
ZV9ub2RlICpucCwgY29uc3QNCj4+ICtjaGFyICpuYW1lLCB1MzIgY2xrX2lkLA0KPg0KPkdlbmVy
YWwgY29tbWVudDogUGxlYXNlIHVzZSAnc3RydWN0IGRldmljZScgaW5zdGVhZCBzbyB0aGF0IHRo
aXMgZHJpdmVyIGlzbid0IERUDQo+c3BlY2lmaWMuIFdoZW4geW91IGRvIHRoYXQgeW91IGNhbiBz
aW1pbGFybHkgdXNlDQo+ZGV2bV9jbGtfaHdfcmVnaXN0ZXIoKSBpbnN0ZWFkIGFuZCBpbnRyb2R1
Y2UgYSBsb3Qgb2YgYXV0b21hdGljIGNsZWFudXAuDQo+SWYgeW91IHdhbnQgdG8gZG8gdGhhdCBp
biB0d28gc3RlcHMgdGhhdCdzIGZpbmUuIE9uZSBwYXRjaCB0aGF0IHVzZXMNCj5wYXJlbnRfZGF0
YS9wYXJlbnRfaHdzIGFuZCBvbmUgdGhhdCB1c2VzIGRldm1fIEFQSXMgYW5kIHN0cnVjdCBkZXZp
Y2UgdG8NCj5yZWdpc3Rlci4NCg0KVGhhbmtzIGZvciBzdWdnZXN0aW9uLiBJIHdpbGwgY2hlY2sg
YW5kIGltcGxlbWVudCB0aGlzLg0KPg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3p5bnFt
cC9jbGtjLmMgYi9kcml2ZXJzL2Nsay96eW5xbXAvY2xrYy5jDQo+PiBpbmRleCBhOTFkOThlMjM4
YzIuLmI3OTFhNDU5MjgwZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY2xrL3p5bnFtcC9jbGtj
LmMNCj4+ICsrKyBiL2RyaXZlcnMvY2xrL3p5bnFtcC9jbGtjLmMNCj4+IEBAIC01NDMsNyArNTU0
LDcgQEAgc3RhdGljIGludCB6eW5xbXBfY2xvY2tfZ2V0X3BhcmVudHModTMyIGNsa19pZCwNCj5z
dHJ1Y3QgY2xvY2tfcGFyZW50ICpwYXJlbnRzLA0KPj4gICAqIFJldHVybjogMCBvbiBzdWNjZXNz
IGVsc2UgZXJyb3IrcmVhc29uDQo+PiAgICovDQo+PiAgc3RhdGljIGludCB6eW5xbXBfZ2V0X3Bh
cmVudF9saXN0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIHUzMiBjbGtfaWQsDQo+PiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqKnBhcmVudF9saXN0LCB1MzIg
Km51bV9wYXJlbnRzKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBjbGtfcGFyZW50X2RhdGEgKnBhcmVudF9saXN0LA0KPj4gKyB1MzIgKm51bV9wYXJlbnRzKQ0K
Pj4gIHsNCj4+ICAgICAgICAgaW50IGkgPSAwLCByZXQ7DQo+PiAgICAgICAgIHUzMiB0b3RhbF9w
YXJlbnRzID0gY2xvY2tbY2xrX2lkXS5udW1fcGFyZW50czsgQEAgLTU1NSwxOA0KPj4gKzU2Niwz
MCBAQCBzdGF0aWMgaW50IHp5bnFtcF9nZXRfcGFyZW50X2xpc3Qoc3RydWN0IGRldmljZV9ub2Rl
ICpucCwNCj4+IHUzMiBjbGtfaWQsDQo+Pg0KPj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgdG90
YWxfcGFyZW50czsgaSsrKSB7DQo+PiAgICAgICAgICAgICAgICAgaWYgKCFwYXJlbnRzW2ldLmZs
YWcpIHsNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgIHBhcmVudF9saXN0W2ldID0gcGFyZW50
c1tpXS5uYW1lOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gb2ZfcHJvcGVydHlf
bWF0Y2hfc3RyaW5nKG5wLCAiY2xvY2stbmFtZXMiLA0KPj4gKw0KPj4gKyBwYXJlbnRzW2ldLm5h
bWUpOw0KPg0KPllvdSBzaG91bGRuJ3QgbmVlZCB0byBtYXRjaCAnY2xvY2stbmFtZXMnLiBUaGUg
b3JkZXIgb2YgdGhhdCBwcm9wZXJ0eSBpcyBmaXhlZA0KPmluIHRoZSBiaW5kaW5nLCB3aGljaCBt
ZWFucyB5b3UgY2FuIHNpbXBseSB1c2UgdGhlIGluZGV4IHRoYXQgdGhlIG5hbWUgaXMgYXQNCj5p
biB0aGUgYmluZGluZyBpbiAnc3RydWN0IHBhcmVudF9kYXRhJy4NCg0KVGhpcyBkcml2ZXIgaXMg
Y29tbW9uIGFjcm9zcyBtdWx0aXBsZSBkZXZpY2UgZmFtaWxpZXMsIGFuZCBlYWNoIGRldmljZSBo
YXMgZGlmZmVyZW50IHNldCBvZiBjbG9jayBuYW1lcyBpbiBkZXZpY2UgdHJlZS9iaW5kaW5nLiAg
VGhpcyBpbXBsZW1lbnRhdGlvbiBzZWVtZWQgdG8gYmUgZ2VuZXJpYyBmb3IgYWxsIGRldmljZXMu
IA0KVG8gdXNlIGluZGV4IGRpcmVjdGx5LCBJIGhhdmUgdG8gYWRkIGlmLi5lbHNlIGZvciBtYXRj
aGluZyBjb21wYXRpYmxlIHN0cmluZ3MgYW5kIG1vcmUgaWYuLmVsc2UgaW5zaWRlIGVhY2ggb2Yg
dGhlbSBmb3IgbWF0Y2hpbmcgY2xvY2sgbmFtZXMgdG8gZmluZCBpbmRleC4gUGxlYXNlIGxldCBt
ZSBrbm93IGlmIHRoaXMgaXMgcHJlZmVycmVkIGFwcHJvYWNoLg0K

