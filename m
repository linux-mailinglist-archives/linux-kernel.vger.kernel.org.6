Return-Path: <linux-kernel+bounces-268910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD5942B09
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA97F287DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7884A1AD3E4;
	Wed, 31 Jul 2024 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BJEKjiyf"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2058.outbound.protection.outlook.com [40.107.255.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA141AD3E3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418765; cv=fail; b=XNo8JAa4Qd06AC5pjiKdOjT2mwNrrDDAvjXeNdOXqViYtvWRpToX3EEmGSkff0v4enyzIIhmD3gR9I/kAeukVL4auDtxCdpA8FSsFSeA/z2iSFNniODtoqPHw0WEPc8IoqiG/bzxLUmU+IVizhLBIxcsrG+gFNnUSUQHbgf/qsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418765; c=relaxed/simple;
	bh=u70oh2EAciWahoK23XDlkML/DoVl2j5cI7bfoyeo5jc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cvu4FmEsKzX6X6WhjhagcWiYXbKEZ5F3FNHxaiz7hJ5zZMwnrxdNncRFzuAAWHASSmI3gWsxfTbTV/WwGBXqDqBenpjGRntQiqzKopheA6Xl+EAgCaQU3Wep26ygJv2mIT7EiyPlFQdkMZm2lwiwK3+6eYD19F98Q2xnc7J68+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BJEKjiyf; arc=fail smtp.client-ip=40.107.255.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xm7cNZ4p0YNZgEJTAJgUYJPRxtj42PmrsoMtXb/9ifXxXSwoKQSoo0ExscXUNaLZNHcNTcPqd+aMWSEP714IjrgaGU5su9+zfX39GEjUiPy9LyEfTC1o/waoLZYgdBb/hoYmYjp0NmkPEi6A3/pH30emVxzLeO/SPck79P/KGxxvQ7QkIaMIT9y1uRNldS+6hmWx6o8Xmh5PshpWLxYjJeWkQ22B0dneQ3iNoKsbO2ZKYV5QBY64Wh7CZgeesLQSU0fiyFZ6SojIMbADlWiwvzrdTcXXs25sxGe7ed9P/3hU43VFFFRXy70KyfzOCLSvlXi6z0PJdgsW4djwA/m7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u70oh2EAciWahoK23XDlkML/DoVl2j5cI7bfoyeo5jc=;
 b=KoV/r7cA3tk6IhYlqkjLtlYOXZ5fXdp1mmhix9KrryegpwO0yX8BU5XHRwyh6Bnr+JfHBg8TMEhff3vYP5iLgxnS9PrRiSTyO2B87yjlpT5Lb9cZkjjHNQ7ASJUijn06rP4yYGyJDI/WdTtMu/2rtR39t8z4yUqTjFDGQaLAgkygg5yOg0//XCU5KAf5xSvHCa2ze7DknGo5smU2C5Ir5O2lRYUPSB01QHMyjTb+f3T9n4Sci81epuL822BcyPPWPs4CyoGphuwktIyoxP9UypyhZ79p2Bqs796ZYXMluG2XN7prFzJOMfYwsREQXrSApEP6rDNuTDIvGcJZmLZyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u70oh2EAciWahoK23XDlkML/DoVl2j5cI7bfoyeo5jc=;
 b=BJEKjiyfV5YJpXOhU3CTs99SoU2KZzj7WCKSIrkHBJNs69Vjt4k6cmBXNsBfPBKRaLW105S7AHQewsRGq4MOZmjPOptr9D5Gbr4La3RZ86jZ9/Hl33uyAAiiv8cMHZde5zDj4OU3LqzbvyxZ7nXG/yPQdCKftxq8JhQysArsplaZkcmnSta8uvKUy7QIouKvZ/4TNsCizSGGIF495PwViJl9YGGsGOhBUgyBJ9kFoaZDyJIAyaz+SuFZoKZ3QepG8gJhRdaDei/PuHiYyRAXjAlhfitN0LAOvOQZW2+CCiIplWgEulZgYxfvgpE6P8Pku/fLnxsanO2VXHSFfSYGdA==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TYUPR06MB6269.apcprd06.prod.outlook.com (2603:1096:400:351::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 09:39:16 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 09:39:16 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIIHYyXSB1c2I6IGdhZGdldDogdXZjOiBGaXhl?=
 =?gb2312?B?ZCB0aGUgYWJub3JtYWwgZW51bWVyYXRpb24gcHJvYmxlbSBvZiBtb2JpbGUg?=
 =?gb2312?Q?phone_as_UVC_camera.?=
Thread-Topic:
 =?gb2312?B?tPC4tDogW1BBVENIIHYyXSB1c2I6IGdhZGdldDogdXZjOiBGaXhlZCB0aGUg?=
 =?gb2312?B?YWJub3JtYWwgZW51bWVyYXRpb24gcHJvYmxlbSBvZiBtb2JpbGUgcGhvbmUg?=
 =?gb2312?Q?as_UVC_camera.?=
Thread-Index: AdrjLKBYeuw9cUTERGuSafMbnHpv1Q==
Date: Wed, 31 Jul 2024 09:39:16 +0000
Message-ID:
 <TYUPR06MB62176C90FAD82DB165866B19D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TYUPR06MB6269:EE_
x-ms-office365-filtering-correlation-id: 6b397d11-1b0f-4841-863b-08dcb144a522
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?QmhCczdwcFA3UGpjZlp1a0V4Sy8xYmwxeS83YnFxM2RPWGxKcmtNVjFOYlpV?=
 =?gb2312?B?QVV3eHhUWEd6ZmtHdE40VFNnb1RQeHNDWG1zOFdZQWU1a3JsMEVCK3dBYzgw?=
 =?gb2312?B?SVlOZ0xyT2NYckZzWEpnTThoUTJEcklFOTBZRXlUaGt5TXg0RlZ0enF4Wkk3?=
 =?gb2312?B?Qk0vdTk4TlNBQjBrWkJhYjZhYW5lS3ZBRVFFa0FUV21QL1RycDBrTXhrTjdO?=
 =?gb2312?B?YkpjWnB2STY0dmNMcElXQ0Y0UkpoQk9PWllYS3FLM2dyanUwSFpNcXA3Mkk5?=
 =?gb2312?B?NG9BYTFnTkh6QndxQzV1WUVFUjNRWEdtckNIcHVTT1NCMUViYnlmQWIvVXNa?=
 =?gb2312?B?aUYyTFpscHJmbXlCTUVVT3JJdFMxWHpiVlpGSDF2L1NOdXBtQ1lBRWRnUWNC?=
 =?gb2312?B?Z3VpdnZMWS9KZHcxeUVVL1MyRkF3QldpK2UrU01DWW9FaU5BclNvL0pSdkhC?=
 =?gb2312?B?Slk4M3FKazQzWWtuQm5Ma1JWQjR0amJuZmpsVDZKSE9jR3RyKzUwVjBKSkx2?=
 =?gb2312?B?a2tFWVlSV3dhTFpDZnZjQ3ZvWHdJY3QrTG1aWmRRZ1dKNml0VUU4MWtFOE5J?=
 =?gb2312?B?MFVmd3grajNveVp6SFFTbUdqNkFoT3VxL3BzOVBYRGFQN1VERWdTQnJKVmVZ?=
 =?gb2312?B?OTFiSWMrMEc0OWR1b1VwdW9EVGQ3ays2amw5TVZPQi93U3pkdXBTQXJMc0Zl?=
 =?gb2312?B?L0RjV0hibVJjaFNnSHNHSFUwQkc5Z0xNMHlZSUYwZ1I1S3dZYUthQ2dhWFdP?=
 =?gb2312?B?QlFZNktTSTVIN0ZVaDVVZjltRUloQTloZWgvRE5aMVlNWjlJRGpxWmIvdU5V?=
 =?gb2312?B?K1lYRG93aDRtZUtZcEZ3QURzNEx1d2JEUXcrZXJnTVlwSjlvNkFjbGxIZE45?=
 =?gb2312?B?Z0N6STRGRzZhNWhXWU9ZVUNSUVQ5THdQQWxDNzYvcGJXbUZXZ1pQSVFzYitH?=
 =?gb2312?B?OTU0ZWFVWS9EeWR6cWlWYWtKQXYrenR5K3ZQMTJIZ0Z6aFkzbDkxMktWOUJJ?=
 =?gb2312?B?S1ByVjViamdFZjlCVnhPcjRVVVZQOHN2Y2xiL0gzcGJzakVUVCswVzIvK0RN?=
 =?gb2312?B?dWRXdmp3UFdTUks1YSt2ZlI3cGU5bVp5eVFzdHU5TEkwY2Vld21INEkxNTlF?=
 =?gb2312?B?OVk0ZEF5d3VCdndzWmFSckpZWG5CdjdHa3J1RlZiUmMzcjRVTmFJblBTNGN0?=
 =?gb2312?B?dGZrVk54UGVsSXprcnVSS3dzRzVldThReWFraUFaN1hGTXhETXRtK3p3VlRk?=
 =?gb2312?B?SVQzUmxIbUFyZE8zSFV3VXRtWmdDQWNHUzJ2bHRKTTAyWnRWeGZJUDlHSFdM?=
 =?gb2312?B?MSsvTWV1Tmx1OE8xMWt5TXJIRGJNT0M0djVoREdEcE9Kdk5ZWmhFR2pUTDdN?=
 =?gb2312?B?Z2pPWlg2Ny9QbkZpNUJvUGIzUEVzOU1Bd0xpbVY3UW5iTWJpQUVVK283Wlgx?=
 =?gb2312?B?dllNamlVZFdPWXA5S0FST2drTUQvVTNMRlA1d0RDeFVWZlIxWThtaWFTYkJn?=
 =?gb2312?B?Nm9nMkhxNENqQkNOU0U2VnRpcDlBSEwrb3UrbGMzOXU5ZjJRS0w3dWt5TjU2?=
 =?gb2312?B?TTF5VERxekxIL001S3EvZFVwbHdWTUg3aEFXMG9zUHptVTVQOHNEemJ1WHJ1?=
 =?gb2312?B?YXhwOVROMWczaDQxdFI4VExmcjhLU25ab3pLUkpFdC9oNFh1WHloQ3JNMm55?=
 =?gb2312?B?SGpjRzhWUUN2b2lHZ1lYOGI5WWlFcWU5bndSRzI5VVB4LzV3elNNbEhTdXJ5?=
 =?gb2312?B?YjJKeGswc1dMRDVNVk9HUm1xdVpBSnhQWG5nUHNUeDhrUHJqNWxhSXlrcTVs?=
 =?gb2312?B?NUx0WVRLUXR4aUgzT0E3NUxoRHZHdCtUVUk2Q0M1c3AxUzBYNzFNYzBGT0Rh?=
 =?gb2312?B?c0w4V0UreHExU3RlNjY0VWxpQmlwVEVqUEJUQXNvUEp2UkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VmJLc2ZqaUdqQnduTWhMdU5saEdhRzROSHVlaTd3THNqRnZkb0tXYkxLNUpX?=
 =?gb2312?B?b0tKa0xRQUU3OHRhUDVoUVM4aWhMa0l6bUtlekdlNThlbzd2a1NSNVNxdTR5?=
 =?gb2312?B?ekxwMGdFZVczaW13bjBTTmtFV1dmOThuWEtqazJiMXdwVVpZbXVrUUFpU1l1?=
 =?gb2312?B?cXZnUTNsQTU2QjFZQ2lZOGVKYlhrcVkzRVVXZ1Y3TkcrME83OVFLYzBueE9w?=
 =?gb2312?B?MXRDMUtZS3R5cHF3Q0k4VFVLTEVVQm1HVkFUV3hyN1BUY1cremxQejBzenhl?=
 =?gb2312?B?SlVhc2FHY3lUU0hLWXBZcmYrcEpkMzkrNloxM3VqT3VDRXZDQmlLa3BENjEr?=
 =?gb2312?B?bjRiWnBrRllyYzdQRElFU3Y1eFZOT3Ftamtmb3Q0Ukp6TWduWVkwNkN3cm9v?=
 =?gb2312?B?RzlJOHllZW43eWg3MXRuZUhIaHltUFBXNGVlVVBnLzdUNmEwQXFHS0NmbEVD?=
 =?gb2312?B?cUFvNDNPd3V6TnozRFlZZG43UmYvUlM0VkpZSW0xWEMvQ2Njbjl6NjR2RzdQ?=
 =?gb2312?B?MytQa3FxamppSzV0ZDZjWDcvUytiUkpjL0lOZlB1czdpZ3poMzBTZElMSnRp?=
 =?gb2312?B?T01WaklGRDhjUm95T2ZNK2VWQUZrb3lteGVTb2t3WmlBeXVydm1xM28xaXpM?=
 =?gb2312?B?SHcwUm9HQlRFcTZFazNMMGo5Nk5aMmQ4RS8rY2ptVXhIRGpDT3o2a0V1Q042?=
 =?gb2312?B?Y3ZkVzBrYitsQVBmalJhU2o2T2lwZmNkWDEwREdEVUpPWmpidVBIdmwvQ2lT?=
 =?gb2312?B?WVQrZjhzOHluT2hhSDdXcWViakMrV1Y2TTNCTGEzUkxVaWIxbFc0V3ZYcXlE?=
 =?gb2312?B?ejRtMXZ5QUhhZGNJWlZHWHNEOW9iZkFBM1U0UVc0NEZEelB1bG9iblBya2V1?=
 =?gb2312?B?MnJuL2JydXYyditkbDEzcVphMkp6LzM0a0MrdmFic0RvOVcvN3pycjNNdHNh?=
 =?gb2312?B?b3BkUks2ZjRNSXFxK1BTS25JaWl2dkFoclE0QXN0T0NMU0hrU21PbWhpRjdD?=
 =?gb2312?B?eDFVdmZGNmliZW8zKzBMZk1ueTFtbEJJZUkydGtTYlUwN0QxNFRwOUdCcys5?=
 =?gb2312?B?QStJbUlLUlRUQ1dDZFJhRkplNzF0N1NmMDdCdnkxamhWR3poUUc5S1NWL2Nt?=
 =?gb2312?B?QlJ0Z21XSFJEdFl5VjFuS3pvQmpnUTB4V1Z1UlkxMXZDV3F0RU12RHY5bHZv?=
 =?gb2312?B?d0VtR2QvanlkU0JYVXQ0L3VrT0hGQ1hUSGlyUGRZOVo4TDVFTTRFNEFVTUFW?=
 =?gb2312?B?MmQ0bUw5QkxRRWxGNW9LdXBRMFZSMTRObnRKYVBWWGpJUE1Wb1U2a25pS0FK?=
 =?gb2312?B?anNwSy9oOUxndCtIb05iTTFoYURMMWJ4QWpPNE03Znh3cTdhWENESnp2VUZ4?=
 =?gb2312?B?Q0l2OXAxRzN6K2xaNEpWUFU3T1JpYWNteVlvcnRJK2dNd21VSEJUNGtyOVZV?=
 =?gb2312?B?SUhKZFBNbFlCUDY0dUs3eUwxVGs5ck50QTM0UWtoQm9EcnZvWlhVTTNEZnd6?=
 =?gb2312?B?a3ErSEkvL3BTUHc5cTY5c3d2cy90cGtrTTlzcUIxQjNiMkxXcGdHaG5yTkdp?=
 =?gb2312?B?b2c5cElUNU5MN0EwaVVTMFZpOXdIeDA4SkdoODRZS2tvR1NrTGRubFdCZUtz?=
 =?gb2312?B?Smc5L3FtKzFrUUFGRUIxOU12QzZUUzRGM0JWMFIwaHZDN0RaL2krY2Fvd1di?=
 =?gb2312?B?WG9JZ2F3akJZZTEvT3YveTN3dHk2STJiNXpIcjFWcFQ1cjYzU2ZyaDZCQ3p0?=
 =?gb2312?B?d2RvbEJpaUhpV2RtNWdLUVRrR2o2b00vZng5ay90T2I4Mm1sREUxUUpMUi9k?=
 =?gb2312?B?alJDOFVORENVdHdLV2JDbnRlY2FwSmZMb3o3TGFwcmxsY0ZpT1VPQS9hVmQ2?=
 =?gb2312?B?QTB1dGdCUFpzb3BPR01sY1lSRDNpRjNuN3BzMWcyQzJKaGppRDcxYzVXYmlK?=
 =?gb2312?B?c1AwTFZXMFZKQnMvcFVncDVxVnZiMDVEcmJhRG9idG8xVUtLVEpXZHdhOGlo?=
 =?gb2312?B?T0hvazZwdEladHhNUUcrL3lhWExPbTZZUm9vd21nSFZrNUNXbTR3WFJad3VD?=
 =?gb2312?B?ajVPUEs4YXlCNDFzSHZEM3JJWnVuUXBBcDhxQ3EvUXFnNlRrek90MTFGbGQ4?=
 =?gb2312?Q?HJsM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b397d11-1b0f-4841-863b-08dcb144a522
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 09:39:16.5540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2eslACCM5WQYnVJ2voTJ9TVz6S2RiM57LgZi2Kns5zLEGY9NEjgFz9czLTPNQ/GI2EVhooyh2tkfS39Suqukg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6269

V2hlbiB0aGUgcGhvbmUgaXMgY29ubmVjdGVkIHRvIHRoZSBjb21wdXRlciB0byB1c2UgdGhlIHdl
YmNhbSBmdW5jdGlvbiwNCnRoZSBwaG9uZSBuZWVkcyB0byBiZSBlbnVtZXJhdGVkIGFzIGEgdXZj
IGNhbWVyYSBmdW5jdGlvbi4NCg0KQmVjYXVzZSB1dmMtPmZ1bmMuYmluZF9kZWFjdGl2YXRlZCBp
cyBjb25maWd1cmVkIGFzIHRydWUgaW4gdGhlIGZfdXZjDQpkcml2ZXIgdXZjX2FsbG9jIGZ1bmN0
aW9uLCB0aGUgdXNiX2dhZGdldF9kZWFjdGl2YXRlIGZ1bmN0aW9uIGlzIGNhbGxlZA0KZHVyaW5n
IHRoZSBleGVjdXRpb24gb2YgdGhlIGNvbmZpZ2ZzX2NvbXBvc2l0ZV9iaW5kIGZ1bmN0aW9uIHRv
DQpzZXQgZ2FkZ2V0LT5kZWFjdGl2YXRlZCB0byB0cnVlLCB3aGljaCBpbiB0dXJuIGNhdXNlcyB0
aGUNCnVzYl9nYWRnZXRfY29ubmVjdF9sb2NrZWQgZnVuY3Rpb24gdG8gZmFpbCB0byBjYWxsIHRo
ZSBjb3JyZXNwb25kaW5nDQpjb250cm9sbGVyIHB1bGx1cCBvcGVyYXRpb24gKHN1Y2ggYXM6IGR3
YzNfZ2FkZ2V0X3B1bGx1cCwNCm10dTNfZ2FkZ2V0X3B1bGx1cCksIGFuZCB0aGUgVVNCIGNhbm5v
dCBiZSBlbnVtZXJhdGVkDQpub3JtYWxseSB1bmRlciB0aGUgdXZjIGZ1bmN0aW9uIGNvbWJpbmF0
aW9uLg0KDQpBZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLCB3ZSBtZWFzdXJlZCB0aGF0IHVuZGVy
IHRoZSB1dmMgZnVuY3Rpb24sDQp0aGUgZHdjMyBjb250cm9sbGVyIGFuZCB0aGUgbXR1MyBjb250
cm9sbGVyIGNhbiBiZSBlbnVtZXJhdGVkIG5vcm1hbGx5LA0KYW5kIHRoZSB3ZWJjYW0gZnVuY3Rp
b24gaXMgbm9ybWFsLg0KDQpUaGVyZWZvcmUsIG1vZGlmeSB0aGUgZl91dmMgZHJpdmVyIHRvIHJl
bW92ZSB0aGUgb3BlcmF0aW9uIG9mIHNldHRpbmcNCnV2Yy0+ZnVuYy5iaW5kX2RlYWN0aXZhdGVk
IHRvIHRydWUuDQoNClNpZ25lZC1vZmYtYnk6IExpYW5xaW4gSHUgPGh1bGlhbnFpbkB2aXZvLmNv
bT4NCi0tLQ0KdjI6DQogIC0gTW9kaWZ5ICJGaXhlczoiIHRhZyBvbiB0aGUgY29tbWl0DQogIC0g
TW9kaWZ5IGRlc2NyaXB0aW9uIGluZm9ybWF0aW9uLg0KLS0tDQogZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL2ZfdXZjLmMgfCAxIC0NCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYw0KaW5kZXggNDAxODdiNzExMmU3Li42ZDYz
YmVhMTQyMTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMu
Yw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMNCkBAIC0xMTA3LDcg
KzExMDcsNiBAQCBzdGF0aWMgc3RydWN0IHVzYl9mdW5jdGlvbiAqdXZjX2FsbG9jKHN0cnVjdCB1
c2JfZnVuY3Rpb25faW5zdGFuY2UgKmZpKQ0KIAl1dmMtPmZ1bmMuZGlzYWJsZSA9IHV2Y19mdW5j
dGlvbl9kaXNhYmxlOw0KIAl1dmMtPmZ1bmMuc2V0dXAgPSB1dmNfZnVuY3Rpb25fc2V0dXA7DQog
CXV2Yy0+ZnVuYy5mcmVlX2Z1bmMgPSB1dmNfZnJlZTsNCi0JdXZjLT5mdW5jLmJpbmRfZGVhY3Rp
dmF0ZWQgPSB0cnVlOw0KIA0KIAlyZXR1cm4gJnV2Yy0+ZnVuYzsNCiANCi0tIA0KMi4zOS4wDQoN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClF1ZXN0aW9ucyBhbmQgQW5zd2VyczoN
ClNvIHRoaXMgaGFzIG5ldmVyIHdvcmtlZCBhdCBhbGw/ICBIb3cgaXMgdGhhdCBwb3NzaWJsZT8g
IE90aGVycyBoYXZlIHVzZWQgdGhpcyBwcm9wZXJseSwgYXJlIHlvdSBzdXJlIG5vdGhpbmcgaXMg
d3Jvbmcgc29tZXdoZXJlIGVsc2U/DQotLS0tICBUaGUgY3VycmVudCBhbmFseXNpcyBoYXMgbm90
IGZvdW5kIGFueSBvdGhlciBwcm9ibGVtcy4gUGVyaGFwcyB0aGUgcHJvYmxlbSBjYW4gYmUgc29s
dmVkIGJ5IGNoYW5naW5nIHV2Yy0+ZnVuYy5iaW5kX2RlYWN0aXZhdGVkIGluIHRoZSBmX3V2YyBk
cml2ZXIgdG8gZmFsc2UgaW4gb3RoZXIgd2F5cy4NCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+
yMs6IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz4gDQq3osvNyrG85DogMjAyNMTqN9TCMzHI1SAxNzoxNQ0KytW8/sjLOiC6+sGsx9ogPGh1bGlh
bnFpbkB2aXZvLmNvbT4NCrOty806IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG9wZW5zb3VyY2Uua2VybmVsIDxvcGVuc291cmNlLmtlcm5l
bEB2aXZvLmNvbT4NCtb3zOI6IFJlOiC08Li0OiBbUEFUQ0ggdjFdIHVzYjogZ2FkZ2V0OiB1dmM6
IEZpeGVkIHRoZSBhYm5vcm1hbCBlbnVtZXJhdGlvbiBwcm9ibGVtIG9mIG1vYmlsZSBwaG9uZSBh
cyBVVkMgY2FtZXJhLg0KDQpPbiBXZWQsIEp1bCAzMSwgMjAyNCBhdCAwODo0NjoyNUFNICswMDAw
LCC6+sGsx9ogd3JvdGU6DQo+IEhlbGxvIGxpbnV4IGNvbW11bml0eSBleHBlcnQ6DQo+IA0KPiBU
aGUgZm9sbG93aW5nIGFyZSBhbnN3ZXJzIHRvIHNldmVyYWwgcXVlc3Rpb25zIGFib3V0IHRoaXMg
cGF0Y2g6DQo+IA0KPiAxLldoeSBkb2VzIHRoZSBkd2MzIGNvbnRyb2xsZXIgbWF0dGVyIGhlcmU/
ICBXaGF0IGFib3V0IG90aGVyIGNvbnRyb2xsZXJzPw0KPiAgV2UgaGF2ZSB0ZXN0ZWQgdGhhdCBi
b3RoIHRoZSBkd2MzIGNvbnRyb2xsZXIgYW5kIHRoZSBtdHUzIGNvbnRyb2xsZXIgIA0KPiBoYXZl
IHN1Y2ggcHJvYmxlbXMgdW5kZXIgdGhlIHV2YyBmdW5jdGlvbiBjb21iaW5hdGlvbi4NCj4gDQo+
IDIuV2h5IHdhcyB0aGlzIHNldCB0byBiZSB0cnVlIHRvIHN0YXJ0IHdpdGg/ICBXaGF0IGNvbW1p
dCBpZCBkb2VzIHRoaXMgDQo+IGZpeD8gIFNob3VsZCBpdCBiZSBiYWNrcG9ydGVkIHRvIG9sZGVy
IGtlcm5lbHMsIGFuZCBpZiBzbywgaG93IGZhciBiYWNrPw0KPiAgU2V0IHRvIHRydWUgZm9yIGNv
bW1pdCByZWNvcmRzOg0KPiAgDQo+IGh0dHBzOi8vYXBjMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdC4NCj4ga2VybmVsLm9yZyUyRnB1YiUy
RnNjbSUyRmxpbnV4JTJGa2VybmVsJTJGZ2l0JTJGdG9ydmFsZHMlMkZsaW51eC5naXQlMg0KPiBG
Y29tbWl0JTJGJTNGaWQlM0RmMjc3YmYyN2NmNWNkNTZiY2QxYzRiOTVhZTE0MGY2MTY4MGE2ZTgz
JmRhdGE9MDUlN0MwDQo+IDIlN0NodWxpYW5xaW4lNDB2aXZvLmNvbSU3QzMxODgwODRjMTljZjRk
NDRiYzk2MDhkY2IxNDE1MDJjJTdDOTIzZTQyZGMNCj4gNDhkNTRjYmViNTgyMWE3OTdhNjQxMmVk
JTdDMCU3QzAlN0M2Mzg1ODAxNDEzMTg4NDM0NjYlN0NVbmtub3duJTdDVFdGcA0KPiBiR1pzYjNk
OGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uDQo+IDAlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPUViN3d4eFBJRWRFNkdjaSUyRlpqcDha
elV0M2I2djlJZ2NDUHAzbTE4SlRuNCUNCj4gM0QmcmVzZXJ2ZWQ9MA0KPiAgDQo+ICBJdCBzZWVt
cyB0aGF0IHRoZSBmX3V2YyBkcml2ZXIgbG9naWMgaXMgb3B0aW1pemVkLCBhbmQgdGhlIGNvZGUg
bG9naWMgaXMgbW9yZSByZWFzb25hYmxlLg0KDQpQbGVhc2UgdXNlIHRoZSBwcm9wZXIgIkZpeGVz
OiIgdGFnIG9uIHRoZSBjb21taXQuDQoNCj4gIA0KPiAga2VybmVsNS4xMCwga2VybmVsIDUuMTUs
IGtlcm5lbDYuMSwgYW5kIGtlcm5lbDYuNiB2ZXJzaW9ucyBhbGwgbmVlZCANCj4gdG8gYmUgc3lu
Y2hyb25pemVkLCAgRnJvbSB0aGUgY3VycmVudCBwb2ludCBvZiB2aWV3LCB0aGVzZSBrZXJuZWwg
dmVyc2lvbnMgd2lsbCBiZSBjb21wYXRpYmxlIHdpdGggQW5kcm9pZCAxNCBhbmQgbmV3ZXIgdmVy
c2lvbnMuDQoNClNvIHRoaXMgaGFzIG5ldmVyIHdvcmtlZCBhdCBhbGw/ICBIb3cgaXMgdGhhdCBw
b3NzaWJsZT8gIE90aGVycyBoYXZlIHVzZWQgdGhpcyBwcm9wZXJseSwgYXJlIHlvdSBzdXJlIG5v
dGhpbmcgaXMgd3Jvbmcgc29tZXdoZXJlIGVsc2U/DQoNCnRoYW5rcywNCg0KZ3JlZyBrLWgNCg==

