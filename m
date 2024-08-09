Return-Path: <linux-kernel+bounces-280765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C5B94CED3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C525BB21C04
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B10C1922EA;
	Fri,  9 Aug 2024 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pazlKuR5"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2064.outbound.protection.outlook.com [40.107.215.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97E015ECE2;
	Fri,  9 Aug 2024 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199940; cv=fail; b=NsFV5BY5tMK25GZthXulLOAw/kZ6BEcWNxWCKW/cvK+nwMyx+BE4OyC116RATgTwlDN5fZVfXrTPuzIV1YpbfrExWgVCmoeZPN7z932CSraim0xQUuNYTO9786Qfa7YUkB4s2W17Mum9OcYtX8KF/RbJSnva0PWcmQ/99hJ3dsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199940; c=relaxed/simple;
	bh=eotk05NijcA4YqExMSkPcUoErW2QfKBLGjJDIm5HKYc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cq6UuHaivanTrYgJR/DA/60NGu26Z+SkBLRy5ypNIUaXaZen2r7wyPZCWUfyOULPbU7XTyjL9tX4+rZxRWzekZEqtVo8QXhuELedD3YzNzwliKVP3+OZVi1A2yWV97chym05xyrn6qxvK7TY9w9ODjYrgrQ8xi5gOCVc593nLRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pazlKuR5; arc=fail smtp.client-ip=40.107.215.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmVZZ0yOltZzuKtgr6CmOsE8dhP+2aTBW90nmzPpJkVxoJoh9bTbro/xLWbm/OqnAzInB/aoYVk+iVjWf6GKsCjp2tfYY+qTzYJGGPAHQ7gLSTx0YoXR01gIHKmdwaUUQPsjy6q72+0Y3p/TXfg96rsuf1CFgB7NnQMGUZ7dbn/FV15AAZXA7zAmfuJ59dxkXjDDIo5WscQeo1bpO96U7uCVKKA/FAcJBXON6GdJEsFbf7pFphh+M0nAqnB90zowcTEla65jmvZempdetdJxAeENTtnTJ3kT4r4N0xm/tmsMfkneFfH8QULPp1Hu+7jKC6z+8qUK1KzN1Iso8om6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eotk05NijcA4YqExMSkPcUoErW2QfKBLGjJDIm5HKYc=;
 b=Vb47W6itJB3e6oQZlxSRqoF4K1GBIx58LDY0GabnCjB0X5XZAVpFDWcn9uoV/biRm3/84iNYcaqpx3jq2TIBOG69QskloFhvu39N/xIpdbd82x796PLOZUeJ8iHZeTyK2oMlyIS1UhgCTbZAtRhmDVpCDQJilfoDqszOPcCX3R9AW0ac7E+LLk9yb8MyO96Kc+We2GRkk3fmp1GLClrgb1pPojZufuUdnjUwXAA64trbU4wLkFagSUaN2j3o6dwFaig8ZVRD0dn3LCZsnypkHzWunKBtijSFqIuDR12wolOhtg353b8VK1QsJpS142MyAuldIUjQ4hQHjPTpIUKYow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eotk05NijcA4YqExMSkPcUoErW2QfKBLGjJDIm5HKYc=;
 b=pazlKuR5WJMRRmK/RWI3KkaNZjE/fN5SvOLTtmdx0gccsxURKdUb3HY6YRSfPuHKossNbDdf/LewlgIiui9HGInc/FXXHK7mMX6JV/1OZ0RgSE4B1BQ89jw8eTU72tpJIEKGWv9Yn+gUvhW0SZraqdeh7LZGMso0MyHQRlzAzEewSOFcPy6kC0EYAVjalP7tVOQmiQVqW7K9mEf74pTFSvmfmti2VUSc48Nj0yvZ53rfSPgjgk7GCQY5Ar6ymm4ceTDVtrSqrUzn2L2fETyCILS7oQYW20lQPRJIVRDy69ukkYT9pF3KzkUDqIYaOz44BRlqgQ2mFJgwrFv/dfyr5g==
Received: from PUZPR06MB6224.apcprd06.prod.outlook.com (2603:1096:301:116::8)
 by TYZPR06MB6379.apcprd06.prod.outlook.com (2603:1096:400:424::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 10:38:53 +0000
Received: from PUZPR06MB6224.apcprd06.prod.outlook.com
 ([fe80::d489:3d1:904e:8b73]) by PUZPR06MB6224.apcprd06.prod.outlook.com
 ([fe80::d489:3d1:904e:8b73%3]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 10:38:52 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"mbarriolinares@gmail.com" <mbarriolinares@gmail.com>,
	"wangdicheng@kylinos.cn" <wangdicheng@kylinos.cn>, "sean@mess.org"
	<sean@mess.org>, "alexander@tsoy.me" <alexander@tsoy.me>,
	"xristos.thes@gmail.com" <xristos.thes@gmail.com>, "knuesel@gmail.com"
	<knuesel@gmail.com>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject: [PATCH] ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710 HEADSET
Thread-Topic: [PATCH] ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710
 HEADSET
Thread-Index: AdrqR30bQkshD9SgS+2zVa/QkqxN5w==
Date: Fri, 9 Aug 2024 10:38:52 +0000
Message-ID:
 <PUZPR06MB6224FEB85F27A5AB7A59A1BCD2BA2@PUZPR06MB6224.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB6224:EE_|TYZPR06MB6379:EE_
x-ms-office365-filtering-correlation-id: dfa488a4-1fbc-4677-cde3-08dcb85f767f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?SXM5cTdEUlJIUk40WEd0WVJYWlc2dEVOVWpLRk9HNHV3djl1MTI2aTRRVVpq?=
 =?gb2312?B?VnM1YjdVZXdQNHVsVnJINEJlZDZ2dytHeDFWb1V3T05xOHJ4OFZpQnBGWlpV?=
 =?gb2312?B?Nm5iNHNZR0MyNWQ4VFBRNHh0VkZ0citHRmZNZi96SmdITHBWdjcxNGNWQzlH?=
 =?gb2312?B?QjFxVmtzOXEvTml0RUdtd2lrWFNJd2hCN2hIeElvNE93bEVmV2V4OEM2Y1Fl?=
 =?gb2312?B?UjhWUEEwK0hQN1doNURkTEU4T2R0THc4THlZdXBPeWRJQVhwdmoxM3dJK2Uz?=
 =?gb2312?B?OFRDOTZTVjBBQjFWY0VDcjdmZWFjQ1ZIZkNzZ000WEhrWW9Gck41aXN3emJo?=
 =?gb2312?B?TWRWZGpvZEwwYUJ0Zk8vdEJLWG81UDZKZlVPQlR2QnJRc081aTdLTm9RQkJQ?=
 =?gb2312?B?VWI1ckRQNWdoN05Tc2c5eElzNE5QY3gvdU1VZ1NKUkpjQnorQ3dJZW5jQ3dQ?=
 =?gb2312?B?bHBVTUIvUW1YTmlpL3JseStZNTBzTzFNenNGS2VDT0o5amlvazRpT0VzQUNw?=
 =?gb2312?B?eURtM3M2dU5xNVJBS0tuN2JPOTVuVkxROVBkVGN0OGRvM0NLbVlYY2xLOHhm?=
 =?gb2312?B?NndPYk9DUHFRTGpsR0MzdXNRZklweEhTeTBsTGhRc2pMVG01TXBINTl4UWk2?=
 =?gb2312?B?M01pV1puNW1RcEowUHVwVlZWL2J4cStmb1hxZ0d6MTZpcW5vSUVPdUhrRWsy?=
 =?gb2312?B?eE0zRFhraFFMMnNhRmdVQzJzM000RGFxK1h5MEdxRlNIdkZKM0x1Tm1ydFZF?=
 =?gb2312?B?Uys3SU44K1JpM0hXdEtjZTIyOEJrU3B2TDlIcHlKT1ZIeTVYLzB0TEhrRTFD?=
 =?gb2312?B?RzJuSnd3eHcvMVd1MkZnWWZ3bkFpOXBvQnZFWVJwNlBhUXo5VFlUYjhYUndB?=
 =?gb2312?B?NUd5di8xcFZlZFhPTmZ5aDR5RkMwem1KWHVzYXN0dDRKazI1T280Y1FGSDJY?=
 =?gb2312?B?dkRGQ1g5alFnZFRwUDhreDNPcE1mVDBzWW5nOVZBQ21yZUQ0dTFzK250Q0Qx?=
 =?gb2312?B?SHhnZXlpQ1psT0V3S3pMZW1rODB1LzN6R0o1K3FNeW9QSjhZV2c4SGY0RDJD?=
 =?gb2312?B?SjNzODJTSDZ5T1Q1ZFllSnl1bFhUcjdxT3ZnRW4xbC9CSUEreStoN3IxUUFH?=
 =?gb2312?B?R2FIbWExQ0pzd0M5VUNTR1lXZDVnQUxwRE9oWUhhWFVFUXdlYWdQcFdaaHV6?=
 =?gb2312?B?K1ozNnk1eUQ4WHE2OTM1MCt5OEtEWlh2eEd2WHF3N3h6T05tbkNVODlscUda?=
 =?gb2312?B?M3Jma2doZ2ZCcWRWLzRWaHo5RlZRU3pFT0tqS1FmeTdSa01Bc0RJMmh4aVV1?=
 =?gb2312?B?VTJpNVdxTy8zUHJuNGt3OWxEeGhhZU5waGxkYmVNamxuVjhKb3djV0tkMEZa?=
 =?gb2312?B?MTdIdnkwTEwyS0FDaFVBQ2J1Q0x5VythMEJaN250TWMwL1BRNHhqTURBWUt4?=
 =?gb2312?B?clJIcHlzWlNMWUlJcW5BV2tNNXRWcFRrbzFXdlpQMm4xWld0TXk0eVVibFVw?=
 =?gb2312?B?YUk4aGphVkJnUXR4Ni8vY0RlSDJ2cnhxYXBrSVAzeUFGaTRGNms1ZEpxTWFs?=
 =?gb2312?B?SURIZ2REcDc5K3Z0Q3dNd1dSclZYSnByMVBtWnd1WExGc2JQVy9QQzBhc3lt?=
 =?gb2312?B?U2lhcHh4L0FTVnVKU21zNFpISWNCUTQ3TkFDb0JQN3Zic203S0ZmNHM2R0Yy?=
 =?gb2312?B?NXVjRkIvSkM4dTc5c0o1K2xhN2VnYXdYYjJKN2Q5QjRKTUJlaWp3TlJPcWh3?=
 =?gb2312?B?UG5JVFVXR2hXS3FvbjF5dWpQYVcyRFhNTXp4dnVydm9UVlpaV1lnMUhEeTh2?=
 =?gb2312?B?YU4wSFQ5ZUhhdGRvQzBGSkJ0NHFTRS9MbVN0N0JLNytOZUJOb1ZYY1U2NlVh?=
 =?gb2312?B?eC9yN2FWZk5iZHZhTjd1bEdlVVUrRTN6UFRLU2VvOW5NRVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB6224.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UDB0WTcwOHkxK2dxekRZSlQ3Q3JBS1BzSFFqTDUrck13WVgrLy8xL3V0a1A0?=
 =?gb2312?B?WXRmY1VqSjlpeGR4Nk9LMFUzaWRJVm81MG51ZkN3VDFOeFZuWGZGeW0zcGx6?=
 =?gb2312?B?VUxkNzNjZlIrcytOem9GU1pXWEZTLzl2RWJMNjhyTnFsN0R0WlU1VzRzcXpR?=
 =?gb2312?B?czYwc1hMTTl1Q1M1ZmlkR20xYVZNeDcyd0hWVDRkUGxRbFFzOVA3N3hzYUI1?=
 =?gb2312?B?UlRDK1JWQ0hGWUowYkhuTWJBMnVudUY2MmkrMjBYbDhQanJaRU9iSVdqUjRG?=
 =?gb2312?B?SmtzQ095YXk4UGY5N0c2UkJOdVdLUzlGVHEveklTVldpZ1BlN3MyeGQraUtJ?=
 =?gb2312?B?VW16azg1Z3RUQ0ZLaHkzVlFjclJ4YjlGUHBCZkd3YU5jdnpPa0dtdmp4UUtB?=
 =?gb2312?B?MmFJdDFOelNMTWhTQTd5cC9JZ3B2WjFPby9OdERvNExwVzh0V2huSTdRaHA5?=
 =?gb2312?B?ZVZiNWF2S3F6U2I1b3dqRU9tZGFIMzlObmY3T1hITU43aEJjSE1ET0JPdGND?=
 =?gb2312?B?YzRhQkN5djI0L1hJUnRySWh5VTZPa0JEV0NHUU9Zdlc1Vnl6RHBlNUxLMzU2?=
 =?gb2312?B?cTJhdTlIZ2FhRzB2SlYxT3VUWWYrMlJHOENWUnNjRDZxNzI0UFJ5Sk1vZ1ds?=
 =?gb2312?B?aFdXbFFQTzljTlhTU2Z5YjR5NWQwbkhPM1BrajNXbWdnZlk2eHUvNEhlN21q?=
 =?gb2312?B?SjlDMU9aaEZsZFVOdjQ3MVZSZ1NYOExpS2hpaThyZXR0Njh1SDN5YmtrV1Vp?=
 =?gb2312?B?Qy9yZjlmbHoxU3NLVExhZnU5Ri9iNWRMTzNzNzk3YjFuM0tZU0xiVUUzcjBR?=
 =?gb2312?B?ajltODNNOG8yMlBBWU5vTlVXY3F1bm5jOXVteG8wcmdmazd4VFNvcnhHTFFX?=
 =?gb2312?B?UzYwazV0ZU94Z05EajRUVUFuR0E3QytqWmJMZUc0TTRLOCtERzl4UEwyaXpi?=
 =?gb2312?B?YUFXdU1VYjA3NHZOMFo4ZzVNWnFkNCtNbFlpWC9vVmIvRU1MakRQRGdQVG4z?=
 =?gb2312?B?M3hyWDhRU1BiSm1FeGcyZnFUUTBuN3B4OGpOTEsxMkk5M21ZOTRNT1ExVjVC?=
 =?gb2312?B?Uk9KSFdLUTl1WTVLRnZoOHhKTjBxdDNNY0VvZnllYXkyRDkwcXFRb2wvNUd5?=
 =?gb2312?B?ZWdEMWpVY2tOZXJlQmFiRDZnWEs5blFyaHJnK3RMaHdiUkd3VHQvWkVuRzJn?=
 =?gb2312?B?cVFUT29kbmlRNWdwVEdFbTZQOE8rRDVDWTJnbk9wOUpxNXprR2FNTHYwc0JF?=
 =?gb2312?B?ejVFU1c1bUdyTVg0Y0UwckNFREJvQWRSRXlvZU9RNzNrWjlIcDBqK0RjNUF5?=
 =?gb2312?B?ZEdHdWpJL0J5QzMrcEJYYjRNRWlnWGN2V2d4YUVGWkRFRXJnTFY2VEJzTzFI?=
 =?gb2312?B?SjZUVjlSNi9tRklDWGZOSWdZbUFKVkdVWHdWSWVDWi9BcmUreTN1T21JS1dn?=
 =?gb2312?B?bERmQjJGb1o0WXNFTlZvWjdIeTZBekpwelByL3krU2VkaWVHL011aXMyYTRw?=
 =?gb2312?B?V040NWpnM04vWWpVQkp1SG9jWERlbTZybW1HeTd0SkNsTnpKcmJ2LzRsYXBp?=
 =?gb2312?B?bXVzcXNrQzJJcDhOZTYyN3htTW5HREVrRStxN2hVdGtKTlBzeWdKM3BRMHFF?=
 =?gb2312?B?eUtiVjJ4aTM0aFdHRU1aNXlneXdVNWphUy93Q1NzcXBxb1l2N1hVQTZhcEFL?=
 =?gb2312?B?cllKOUNiRjJpRUE0QW12UVZLUUxPWXB2R0FsbVhncjZNaEhoanN1M1dxaGVo?=
 =?gb2312?B?MHdPVXlva3FoK0VMRnFCaFdkVzJTV0RtUmw4WGE5ZnZLMVduNm43MWVXQy9j?=
 =?gb2312?B?dGhjYTduMy9xTm9aVVdlTHdBVlJUUVNvVXVWTVZYNWY0bEl5U3M3b3ZTYjdt?=
 =?gb2312?B?VEI0L25VMUpYT3l4R0plQmlBK29aR0plYlV3dkRBcUtxaG1xV2lLQnpkdUdN?=
 =?gb2312?B?a1hYTkY3SXh4eDgvUkpia1ZFanBwcHMrM1NERjlubUl4WjBEeENKT3JyNEJC?=
 =?gb2312?B?cE1wOEZYWVJXaDFGaHlCRDlxS2dCR04ySE1vUCtHWkVuZEV3anAyRVZxSHN4?=
 =?gb2312?B?OGZzdWZ0cHEyeksvVmpDdldjZkJOM0Racnpqc2p2UWlBVmZSZDVHb2ZwWm9M?=
 =?gb2312?Q?ittQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB6224.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa488a4-1fbc-4677-cde3-08dcb85f767f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 10:38:52.9121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7BB2V24ubOg9AQgG0s3dmKAlj8wUhUoWQ5UP6TJ4Mav9IgeSNBWVNenVaQTJHY7wAM/IKl9HvWaieUGXupTVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6379

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpBdWRpbyBjb250cm9sIHJl
cXVlc3RzIHRoYXQgc2V0cyBzYW1wbGluZyBmcmVxdWVuY3kgc29tZXRpbWVzIGZhaWwgb24NCnRo
aXMgY2FyZC4gQWRkaW5nIGRlbGF5IGJldHdlZW4gY29udHJvbCBtZXNzYWdlcyBlbGltaW5hdGVz
IHRoYXQgcHJvYmxlbS4NCg0KU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZp
dm8uY29tPg0KLS0tDQogc291bmQvdXNiL3F1aXJrcy5jIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9xdWlya3MuYyBiL3Nv
dW5kL3VzYi9xdWlya3MuYw0KaW5kZXggZWEwNjNhMTRjZGQ4Li40YzdmMGY5ZDE1ZGUgMTAwNjQ0
DQotLS0gYS9zb3VuZC91c2IvcXVpcmtzLmMNCisrKyBiL3NvdW5kL3VzYi9xdWlya3MuYw0KQEAg
LTIxMTksNiArMjExOSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNiX2F1ZGlvX3F1aXJrX2Zs
YWdzX3RhYmxlIHF1aXJrX2ZsYWdzX3RhYmxlW10gPSB7DQogCQkgICBRVUlSS19GTEFHX0dFTkVS
SUNfSU1QTElDSVRfRkIpLA0KIAlERVZJQ0VfRkxHKDB4MDdmZCwgMHgwMDBiLCAvKiBNT1RVIE0g
U2VyaWVzIDJuZCBoYXJkd2FyZSByZXZpc2lvbiAqLw0KIAkJICAgUVVJUktfRkxBR19DVExfTVNH
X0RFTEFZXzFNKSwNCisJREVWSUNFX0ZMRygweDJkOTUsIDB4ODAyMSwgLyogVklWTyBVU0ItQy1Y
RTcxMCBIRUFEU0VUICovDQorCQkgICBRVUlSS19GTEFHX0NUTF9NU0dfREVMQVlfMU0pLA0KIAlE
RVZJQ0VfRkxHKDB4MDhiYiwgMHgyNzAyLCAvKiBMaW5lWCBGTSBUcmFuc21pdHRlciAqLw0KIAkJ
ICAgUVVJUktfRkxBR19JR05PUkVfQ1RMX0VSUk9SKSwNCiAJREVWSUNFX0ZMRygweDA5NTEsIDB4
MTZhZCwgLyogS2luZ3N0b24gSHlwZXJYICovDQotLSANCjIuMzkuMA0KDQo=

