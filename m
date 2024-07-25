Return-Path: <linux-kernel+bounces-261827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E893BCA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 309D9B23137
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC8716D4C3;
	Thu, 25 Jul 2024 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jd+9GWmc"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010004.outbound.protection.outlook.com [52.101.128.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C75589A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721889621; cv=fail; b=oUSghfn5Y/OhrvgOZaqFTo8oN8zU27ap9U9RjBTNrD9m796UoZF22Jz53DE8tGBo42GR+olCpF6nS80LU4KZSVwdnUBjlfRDSGsrjfYYdmEpjGYoXwgdWWQpoQX7e939/kSYVkal/b+9Kd3N/I+So50yVGC8sszvTBVLPabzLbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721889621; c=relaxed/simple;
	bh=rBeJnfmJsiTyjQTAowXyzuvQ0OZs+bygKyUXu+Y7SUY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d7nO8z1cUfgLE8v4qiNqLSFQ6S2Ihe5lH3TbuXGTjFy2KSdlbVLCRhitYqFpTAE5mDfbJCbRzY59aklWiRaLPXL+JHPtswIkF4XpHl9UnoIcRoWI39srpAYKXa7rLcYGPGWUwO/zLHbNfxudARUCB4XwlL8havKmFKOZUAV3VSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jd+9GWmc; arc=fail smtp.client-ip=52.101.128.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYBb+IqaQon2hmTq8e7H3k4+Lmzm+fCIm9mz1pM8F0WPS0wTozzBmGnhc13XQQ6pUs0AnfF7+bsU/f5Rz/MSuhGtK8W6t6/dJ9M6cAqUPVlKq7+uD7VnTAnoWRbOGrd9QhKf50yiANDVgT/sajSuAEw/i1y5XJbvckVXsR3YEFoqJLHCdHVqoHVD/6PoNuQNcksH/rfjkulpX9u0kDxYR7moDfdMCQO1uqSLTokdK23WcPltfDdb5hKuOiJYzt+GkQmG/KjBp5h+bp8/R9l5gknNX91vvEJEapsnDMkszZ/jx4gbo3rihd09EVpgxaM9Gyyral743R8kiZhQhOjtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBeJnfmJsiTyjQTAowXyzuvQ0OZs+bygKyUXu+Y7SUY=;
 b=EDdNg8rrhnIbkRc7wk4mOuwuknhom7qdHCQ8qRsK8JDa+jB2LVJTa7Tad0SiCobk1khpbnjyI8PJAKc/MS+AQBVpT1SO0goplPsZFBfYWACmgRKAGA/CfoUMBBMb0fe8dsQXJytnqEV2nDheFK1DQ2h1l2QoGBtAl2zcXUHn7Hfu9jFOhsh6LEi1ZIgKty3Hq7z9mNA3N+tEXNdVLWzI1417eRvSoB5gYjpeiflDfJDkfx97jcDb7bD65L/RaBTCPO4ONtYTVNqtpZFRPXTzOxcChAsfBbvu7KAqGUwetuSvbHeH6dzre7mpFHi2jmktZQD03i/hf0EjMykai5YbtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBeJnfmJsiTyjQTAowXyzuvQ0OZs+bygKyUXu+Y7SUY=;
 b=jd+9GWmcH9oFXUeNsgW6ZD8+UX/jKafcNU694y8hMcxSM1zgvWrQQyf2Oj5walFWaZJ2n2Kj32fPtJNUet5RQTi1zZ8Z3zg+VOLMJM1kiuMNGZWpLQvsoThQmEE00jdMKxZAxNUN2PC7SF9nlWSN016sh4tdz82izf1wcZVOccna8lsYeDIZUzf4EDkjbrlDke/sQ5K8FndaHs0C8WflAsVLAq1CNA0MqHq0v8xgOjnu3rXs4TwqmsFG+gSBNxiEAV5ILhdeEau+AqcYMEp4w7IMTglWGmiXMy8mmT+XmrSwNdOxWAwXSjhfJLY+0Htjy/Cp4sosqwv7IlxpjR+NAw==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by OSQPR06MB7201.apcprd06.prod.outlook.com (2603:1096:604:2a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 06:40:14 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 06:40:14 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: opensource.kernel <opensource.kernel@vivo.com>
Subject: Subject: [PATCH] usb: gadget:Fixed the problem of abnormal function
 of mobile  phone as UVC camera.
Thread-Topic: Subject: [PATCH] usb: gadget:Fixed the problem of abnormal
 function of mobile  phone as UVC camera.
Thread-Index: AQHa3lyzXY9H9WK/m0mCSw8O0x0iYw==
Date: Thu, 25 Jul 2024 06:40:14 +0000
Message-ID:
 <TYUPR06MB621753631B9F7836583E7BEED2AB2@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|OSQPR06MB7201:EE_
x-ms-office365-filtering-correlation-id: 1010e606-2d3e-4785-1bf3-08dcac74a3ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZndiT2Q0TnRoMHArSFV3RjhqWk9HRkJTNmUrSmU1N3NiK1h0RHNFbWlVZ2JN?=
 =?gb2312?B?YU9VWGk3NXlaOXM3d0NzVTRJN1R5Wm1LbXBjcEc5eHZjUStQVXpXckJocXo4?=
 =?gb2312?B?NmhmZTQzWjFhREk5eStSdVBwb2NWMTdVYnYzL2lUc1Z5VndEaHUwajRjQXB4?=
 =?gb2312?B?VnFGdzRwV08xL0xTU1Y2RXh6QTJKY0h0b1NKWHFKV0VabVNjN0NUTXhUNDg0?=
 =?gb2312?B?TXMxWWIzMDQwbGdRQ2ZiK0FVdlFiK0pTdnhkZGNjcElkcWRaOTJ1RS8zbUZi?=
 =?gb2312?B?dVFoeWhja3RocjFLcDBZZDJ5aFM4TnREQjUxYUtnWU5hMHYxRmhyWTlCZ2hn?=
 =?gb2312?B?VzVBNnhLT1J5azF6aHZRMlNBc1ZlVmgrSko0eHcwOTBpK0NzdUQybFpyS24v?=
 =?gb2312?B?czJNZWRmb1ZEajJFRHhhdkoxSTZXK2xwNmNHZG1qZHFKcDJQLyt1WTdQQ2U5?=
 =?gb2312?B?WjhNRzNEeG84VW9CYVN1N3VQVkpCZGxaKysrd2w1QVN3UVcwcXpPeEVrcExv?=
 =?gb2312?B?Sk9pUEdJbEdHWkI3QTZlcjRqK0NrUHFMdXlTWkRSR1RPRktRVjZBS0drY2lo?=
 =?gb2312?B?Q1NSdUJONlYzSjVWakIrMTl3dG1sMVlmWEEyd2xnYnVORmpEU3VFRUcyOFpi?=
 =?gb2312?B?c3cvTlNYbjVvbHlLd3pXeUNxT1Z6b2M0aER3S1hsOTVkS1htbzZPamthU3Z0?=
 =?gb2312?B?QjJsbDRCQ1Q2TEVIVzdOVkJiT1FabHhuYjdCQnlBR3czMldiZUF2NHBGK2ZW?=
 =?gb2312?B?WFVJcjVWaFNZa2dmWU9MTVh5NlJZS0M3RVBpZlpvc0JQNGl2blhQMlkzSUY2?=
 =?gb2312?B?QUk3MVRXN3VVVG1IMjQrbk1iaDJndGE0czZuVDl3Yk1TcTNQcGN2SmxGaklu?=
 =?gb2312?B?WjRPY05FL2lCd01DSW84blBBSHhwMEMzT0tSb3NvOGtONGlGeXhQYlo3V2M5?=
 =?gb2312?B?RVNVZFYzS3IwM21waVVESG9qRHJIc2hBZTZWMDIwUW9rK1h5aFBaOXpENWZG?=
 =?gb2312?B?d3B1VTkrbGRQSXU5TldxWkxwUG9LaU9WZmluYnNLR2lNQWM1NUFKaWllUHVO?=
 =?gb2312?B?SHVJT2Y2VUV6eklMZ3pOSzhxb3NrY2ZKT0ZLV3I0OEo2Slhld1BseFBzQ3pP?=
 =?gb2312?B?UjVYUU43ZWhydDdTd0ZpZ0t4WjdjSi9GT1JoTEMxQ1hoTEZ0bXNySllwdVg0?=
 =?gb2312?B?MlpZM2E4aTBTUXpGQVlCNk03VzJDM2YwM3JoTzB0WDNZcy90Q3RsU3N4bEpY?=
 =?gb2312?B?MnVvUUtEdnZ5SHl4K1p0dkxpYXVKak9kdC9RTlFlcjlhWVlNRFpSY1ZRVkxs?=
 =?gb2312?B?NXdQUlVYTmRaNHJueG9YVXk1L1kyYWdOUE1nUlVIbTFrRDhhK3FzVVE0WHJ1?=
 =?gb2312?B?RFd1bXlKUDZMem91UnRqdU5SVWtmMDhPdnBFNityc2hCK0tCb2NXK090ZGlS?=
 =?gb2312?B?eS9BYW5oa1NqZ2liWExYU0Z4R1ZINmlNR3pueFAwMnN4TlRQamtVeVlGcnl2?=
 =?gb2312?B?VldLSk1CdFJsTlhNRHBXTUk2LzRLWmMwcGY3MjVNZXNCUURoMXBHSHBrbHZ0?=
 =?gb2312?B?S1N5Z096Y0NDVmpLemV5RGUrSHhnOTFGeVdzM2VHcHpPdVcxK2hIRE5FeUVW?=
 =?gb2312?B?YkpzNE41eExha1VKbVVKWDR4ZUR4K2dVMUt0Y3ppMlk1cm9hV0kxVlpyYytS?=
 =?gb2312?B?djRMNjUzenlpYWhiMGd4bWJmUmptRFVmdmxldmQ3UjhsOTE0T2N0RGRXYmE3?=
 =?gb2312?B?MWsrWU54UVFJMUp5cDJ1Y3Vicm12ZmRkT2pTaGd2ak1VMnc3ZjJVdzRLcFVs?=
 =?gb2312?B?dGpQSmcyU3FWVW1ucXh1V0l4WEcvUVZ6ZWFLMlNtV2hVdmtUTnZDUkYvU1FG?=
 =?gb2312?B?bnl0SmlpemU3Ym9aVUN5Wi9WWDIwTGhNcEFTdXhyQ1dBcFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bUwxNkpRNXN4N1c2Ujk1NnZBc1o5UHYvZWdtNUsrUHgzVXlEa3JRNzduV3Qy?=
 =?gb2312?B?b0NDQzFEcWFSNTdWWFk1ZUxJZktlUFhsODU1RFpkcXJ1a0VBcjFhS1lFalJX?=
 =?gb2312?B?MGwwWDJlOFNETks3cXJkUzc2aVBtdHZjZVlHenRBMzZFR1NVRWlRdnRscDJU?=
 =?gb2312?B?L0VVWFlRbWNOWERFSWc5VVBDQVRTdmhSaEJ6NGVZNlZiUnkxdHAwSi9EaVZT?=
 =?gb2312?B?S3pSVDhVeFBnVU0rejJtZnlHbEFxN1FvbDR3YVd2dHJrU3E1WUhMTDRGODRi?=
 =?gb2312?B?dDZQUVgyenUxTHJjdlJUTVI1bUNoNGR4YzJwcDVaL0RMbjNiUGUvbi8yTnJE?=
 =?gb2312?B?R0JzV09QdnZ4aXdOclFFbVl2K1ByZkpYa0dXM3gzZ01vSUkzUkR1ekpFWWlz?=
 =?gb2312?B?cVh5NTlVcFZGSUoxd1ZwSDFLNXo5aHc4OUhBSU9FZHFNUFBuL1BKUjF5UVZQ?=
 =?gb2312?B?TFdra1Y5dzJWeXFoNitUUTl5RTdOdTZXR01NTVNGSVJsMGRXZGRlUmNIY2Zx?=
 =?gb2312?B?eWdKNWZObHlQOXpYdGgxdStNaXlCUzJyajlzRkFtYkxXVnFNUzdCV2pnOVlZ?=
 =?gb2312?B?KzZJRVQvN3prZDJFTG00MzIvbjhxZk01L2FUT0hRZ2h1VkNxbithRzFrdHl0?=
 =?gb2312?B?REVuelRpQ0pmSnVwUWVNTUowdVNHU3Z3RlovbmZsR0Z3azcvam82Vm1sSmVp?=
 =?gb2312?B?djNjVUVrOFE5MkV6Y2JpZ0xxQ0JmSTNqNG1TZi95MUZXMWJRMmk1QjZNWDJ1?=
 =?gb2312?B?UjY3dmkwbXhSRktWOStQTy9GTGlzT2hMNll5NGlOeE02Y0dneUJPUjJMcFNz?=
 =?gb2312?B?dkx3T3FUTDg1VnpFNWZ6ZXM2dWpzRytzd3U4V3hrV1hpVElrb0c2YmNVbTJw?=
 =?gb2312?B?MUdZOEtUYW9QYWljY2locmNkZmpBMlZLaXUwbmtkNXp1STZWbi85OXppNHNL?=
 =?gb2312?B?MERXSHVDZ1J2S05wZnp6K2Rvc1lLMHhmMmUvSzYxQXZWL0h6Wi9oTDJNRVVY?=
 =?gb2312?B?eW5lbXBmaXFVMDZRMmxPbWxFUlFjcWhKRjFQTjRKVUYrc2dGN0dydTdnanZP?=
 =?gb2312?B?V1FuUksveUdDamRlUi9ZOHpSQVNpR05CMHJxMDk4T1VUZTUwWDNhOU8zRXZW?=
 =?gb2312?B?QXQwSldCSmd3YTVRek9aQWZWSWFUK05mZmtvUm1SbkxackM5a1NCbDU4N0dH?=
 =?gb2312?B?Umx0VWxzYlRXSWlHZHZOSWZFMGVnaWgvY0FjdTNoRzRuekEzVGhsMDFPT1hJ?=
 =?gb2312?B?Z3NDSFhpYVdOenFYdjQybFVSMDVVM3hUeVFwdEMzTE5Xc05ac3BoaEZRYXlH?=
 =?gb2312?B?WGxNa2FReW5CWUFDTE9ZbmJsQXRRMjB1SWxraWlKU2t0NWl5ZkY5dWFkQVVz?=
 =?gb2312?B?TEFweEliNE9BWndwM2haZGYwQ2NtVmRlU1dQVkZGUXBZNEoveTQ1c0gyUkdS?=
 =?gb2312?B?NzY5ZGdsd2l2TUtUM0gvZWdpTWgxZHptMExuYlVyQnMrUWJPM0daN2Q0V0Qz?=
 =?gb2312?B?akZEUWxZbXhhVEhNTzN4MmFMRXRQa0xzUWNnYnREZVZkdlpZRWtYc3VHV0tm?=
 =?gb2312?B?T1FNRkt1ZjM1TmY5aFhFNjMvUWw1TGhXWnBiTXk0bkd4SXByVC9IU2ZZQTlJ?=
 =?gb2312?B?bThGajZQMEIwUTJvVnl5ZXBqWDVycndiUkpxT3U2alQ1WmpXV3RUOG9wVkhS?=
 =?gb2312?B?eUdkRndhbjlYeS9FaFJIRWpQWDZkOXB4OUJPamNlUkkxb3RMMm5zWVpnT2x1?=
 =?gb2312?B?WWhQNHBzNkxHcC8xNlBxaFlLY1QwYmZld2F5aE0vZi9KWkZWbTJocmtZOUky?=
 =?gb2312?B?RE5vRFgrVllyV2NWSFUrZnhFeFZCandrV2JWZGpPK1ByVDBCS1VDQTBObkJh?=
 =?gb2312?B?UjhRV3J1ZXptMlZFdG1oYkJJTERteFhKcGtuUGd4SDNhRWUrayszUEVkNk5m?=
 =?gb2312?B?blM5WXVGbUIvU05HcEtrNDU0aWZISmU0SmpNNTc2c0U5SDJydHFwZytoUndH?=
 =?gb2312?B?bWFRMHdlaW5MNHQyZkhiLzRoK2ZGMWw5dTJnRnpkTjFEdDdWcmtlWnFLb21m?=
 =?gb2312?B?TXR0TW0ybnZaU1Fndy9peG91S2hXQXBybi9RcFREcE1CQnM1S2p6L3pORjdV?=
 =?gb2312?Q?Uheo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1010e606-2d3e-4785-1bf3-08dcac74a3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 06:40:14.1499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pT8LT6oEUSdfC2mAlB6Btcestm4iOSEXKGN2hMti9fWJwAcGUf5wNlB4T66hoU8KgLE3t/KQuTXvNOz9B1SLFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7201

RnJvbSBiMDA1ODQ4NGUzZmU3ODMwYzIwOTJkNWQxOWI0NmJmMWJhYjczZDgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaWFucWluIEh1IDxodWxpYW5xaW5Adml2by5jb20+CkRhdGU6
IFdlZCwgMjQgSnVsIDIwMjQgMTg6NTI6MjcgKzA4MDAKU3ViamVjdDogW1BBVENIXSB1c2I6IGdh
ZGdldDpGaXhlZCB0aGUgcHJvYmxlbSBvZiBhYm5vcm1hbCBmdW5jdGlvbiBvZiBtb2JpbGUKIHBo
b25lIGFzIFVWQyBjYW1lcmEuCgpBbmRyb2lkIDE1IFVTQiBmdW5jdGlvbiBvcHRpb24gaW50ZXJm
YWNlIGFkZHMgY2FtZXJhIGZ1bmN0aW9uLgphZnRlciBzd2l0Y2hpbmcgdG8gY2FtZXJhIGZ1bmN0
aW9uLCBVU0IgZW51bWVyYXRpb24gaXMgYWJub3JtYWwuCnRoZSByZWFzb24gaXMgdGhhdCBiaW5k
X2RlYWN0aXZhdGVkIGlzIHNldCB0byB0cnVlIGluIGZfdXZjIGRyaXZlciwKd2hpY2ggY2F1c2Vz
IGdhZGdldC0+ZGVhY3RpdmF0ZWQgdG8gYmUgc2V0IHRvIHRydWUgZHVyaW5nCnVzYl9hZGRfZnVu
Y3Rpb24sYW5kIGR3YzMgY29udHJvbGxlciBjYW5ub3QgcGVyZm9ybSBwdWxsdXAgb3BlcmF0aW9u
LgoKVGhlcmVmb3JlLCBtb2RpZnkgZl91dmMgZHJpdmVyIGFuZCByZW1vdmUgdGhlIHNldHRpbmcg
b3BlcmF0aW9uCm9mIGZ1bmMuYmluZF9kZWFjdGl2YXRlZC4KClNpZ25lZC1vZmYtYnk6IExpYW5x
aW4gSHUgPGh1bGlhbnFpbkB2aXZvLmNvbT4KLS0tCiBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vZl91dmMuYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYyBiL2RyaXZlcnMvdXNiL2dh
ZGdldC9mdW5jdGlvbi9mX3V2Yy5jCmluZGV4IDQwMTg3YjcxMTJlNy4uNmQ2M2JlYTE0MjExIDEw
MDY0NAotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYworKysgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYwpAQCAtMTEwNyw3ICsxMTA3LDYgQEAgc3Rh
dGljIHN0cnVjdCB1c2JfZnVuY3Rpb24gKnV2Y19hbGxvYyhzdHJ1Y3QgdXNiX2Z1bmN0aW9uX2lu
c3RhbmNlICpmaSkKIAl1dmMtPmZ1bmMuZGlzYWJsZSA9IHV2Y19mdW5jdGlvbl9kaXNhYmxlOwog
CXV2Yy0+ZnVuYy5zZXR1cCA9IHV2Y19mdW5jdGlvbl9zZXR1cDsKIAl1dmMtPmZ1bmMuZnJlZV9m
dW5jID0gdXZjX2ZyZWU7Ci0JdXZjLT5mdW5jLmJpbmRfZGVhY3RpdmF0ZWQgPSB0cnVlOwogCiAJ
cmV0dXJuICZ1dmMtPmZ1bmM7CiAKLS0gCjIuMzkuMAoK

