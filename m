Return-Path: <linux-kernel+bounces-294118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE9D958978
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E271B1C21470
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3A418E756;
	Tue, 20 Aug 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qmrnjvNj"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2062.outbound.protection.outlook.com [40.107.255.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D99819149F;
	Tue, 20 Aug 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164506; cv=fail; b=CgJuYT9NhNb7PCf7ExRSVI8lIJiSzZcXk6AUl9jJBESvRnUBKG6erxWAnIS7vNBldBRU1Tg3nrXjxJj8DhqSK2UgdN+s9HiQkxFAvDcD3wQo0/OhGOtx/4pSbaRsf3af03uOmRLRzHDtd61wCYkPCTM7tuWkQzcsJcCFSDF6Dmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164506; c=relaxed/simple;
	bh=cZMTjvcfHcJHOdXo0sjrC+puMBdnhM2okBgxTJb72Do=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j20zjorVuGZ5y+9PUBpUHpUILU9noM5enfozCijkkVrf/2Dds1uQHVB7mWR9VqxfNSBcexjeT/yzbdEfFRVLWbeQzItb419X3RXLU8ECWjRwuY1ZFSzQVQuuvD3EwjBHe3TMBGQrQX6EovSRs0Z9c14TaMni6McRkw3GIGa6ngY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qmrnjvNj; arc=fail smtp.client-ip=40.107.255.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JttmQgHQ7bIpvxNANVtn5/6o6gRPZw1XREEXMDGmGMDlxcUUycMPdpA7sCa6o+5V2um6J2YuWGmSo3aDE7GC/6ux/f8he31KMGn9CfxTGBibu1VCh6RqWAPIzwMjuI1Y/hMLrYd+PRGIzD3GIbf7kx/UrKLAW8RIaVxYHqaKVE1tLYqdb9aLMnN75DPQzTuD0VD6jBAsJhx0smFZaxT/Z2NlEkj13Y32jcdE3/qrLflRpeg3UMbXwxtOeO/PpKFjdSoH/KHpC1wDKt9fHSj131Dj+26cAE8Nmt/M/CLk/zE0nJDL0E5g8q1WEX6De8dYcMiNR6t0BZt0yWdOEFkERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZMTjvcfHcJHOdXo0sjrC+puMBdnhM2okBgxTJb72Do=;
 b=HV6j+JMUXHMB/lc+otcJnfrudfCBMm0vPLOgNdGoyLApy/AfMdiCCc/paAf+829ye7wk0wrKV/B5rgA6cf5lB6Cfq7PaX+9CX8/4DwZx0xlk9sBUZZfTgaunYeeExRy35boN7PpSEoA/uAtDPYjHToY12ovOA8yqfPU0ENiq8qDQ4DQFLephrKlOw0hxC7hdhon0roZG7bh5qyoSjggvyxRwZaHnL8pUg4Fyml3iw+F1xlVEE8KTwg0rEj58nw7McyB/0biYLN20yfv0ENr537DATWZw0LkqCEz4oYvt/Th1rJSkLmsx7B7mpESmIgq4uii/oCV/V9qEPtSorLkYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZMTjvcfHcJHOdXo0sjrC+puMBdnhM2okBgxTJb72Do=;
 b=qmrnjvNjr0YiSkXhkjjZNjXK2H9OVGFRR3zqw1EmMKkHd4WvViNZ0pkmLXF8c+k3ugAy8eAwh1QVupTTY7L6cJiKm0q0rHWUOpu9B3EUvBv5VxkmMOS9M2KCKxAd81qGu5slxlLCk5uzH+TB0yOlFBMBNcDKuc4V/M0v2VBNb2MirJy95tn1m7MhCtD4IWSZ9EYMbd0BxqY26d9RNJy5ijJO3qJceRc0IFgHRBJt7SdbckI+42Pp9CDWAmcBWlewOcT+oBKQOZSCjKnaMQiXCY72xzT8FnJ67Zh+AhfL9jjFXKszN9N0vhHtF0qPZ44T/7NFqJYXEC52qLbTSlF6sg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEYPR06MB6932.apcprd06.prod.outlook.com (2603:1096:101:1da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 14:34:56 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:34:56 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"quic_prashk@quicinc.com" <quic_prashk@quicinc.com>
CC: "quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>
Subject: [PATCH v3] usb: gadget: u_serial: check Null pointer in EP callback
Thread-Topic: [PATCH v3] usb: gadget: u_serial: check Null pointer in EP
 callback
Thread-Index: AdrzDKh8N5M3/u4TSCCS0RPgLRR/KQ==
Date: Tue, 20 Aug 2024 14:34:56 +0000
Message-ID:
 <TYUPR06MB62175A4C6BC97FBAAC9DA72CD28D2@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEYPR06MB6932:EE_
x-ms-office365-filtering-correlation-id: 19126159-a8e2-46eb-2877-08dcc1254341
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2kyMmhRQW9WMTYrQloxZ0xrTXllcnA3d1g4cUR0Q2pkZmI2VFhtMGV5dUVU?=
 =?utf-8?B?WDJZQ1JIM0pQQ2p1VHMrdmdaSWR3TlU0MkxCQ3JQY3MrYWZsNkpMV1c1OVlD?=
 =?utf-8?B?YkJqRlZXNjFuSEdITEhaZWVRdWpwM0J1YjBIaWFNRzBMRHl0YnY4QnlXdVlN?=
 =?utf-8?B?cXU2V3l3UzNGUERCc1REVy9KWHZWWmY5YmhhU2R4bm1IcW91NzdhZ21pYTlq?=
 =?utf-8?B?NGkray9YMzdUSEVSYzdUYXp6S0E0NStUTGVMN3lZYnVEdWxrdUxZdWxadlhC?=
 =?utf-8?B?bTBjM0JwbFZxUEdtc2dWMEovWjFHMkorUTFpcXNydnZ4aXdHV0d1SzM0Z2Ru?=
 =?utf-8?B?b2p3Rk9lT0RSbDF1aDdDNHNrUFVjSXlZRGptbWhJS08zMTNxZk82VytLeUVw?=
 =?utf-8?B?TlZBUU55YWZiZEp4VndzSVF0L0NHRUJyQk9vdzFjZzJHaFh2SVAyS21DUmhZ?=
 =?utf-8?B?a3ozd3o0WmNIbWZCRXo1VyttTlhTTk93Q0cwdk5mVldnT2gvbktkL1NTblpn?=
 =?utf-8?B?OExOK3lhYlROR3FhS0NYSXFDQ0tDZ01Ma01OaWM4d2JrRFFseWhlbWplQmJy?=
 =?utf-8?B?WEF0YnpTSFFydXBMVEkvNVBKVDl4Zk5SeVhTbVVMd3k3WU9NSCtkcXpKMjhm?=
 =?utf-8?B?MzlRcTZWbjNlRmwrendwcTJIVzBONS9DbHBqTWdoU21XYmhtaU12MFovTzIz?=
 =?utf-8?B?NXpDOHpKUGtPcFhoYjlkMGJiYTFNU2gyQVVrakxuZmNXeWVqc1hCZVpMZVUx?=
 =?utf-8?B?dWE5ZE5MZWVoQ29CbDNkMzRVbEZ5M2QvWmZUV1VBTitERG9OaXE0K0h0Wk15?=
 =?utf-8?B?QVFpUW5YNldsV0Z0ZTRDRkM3Tm54M0t5ZCtPWGNqMnhKTkM4L0xQR1B0RFR0?=
 =?utf-8?B?TzJZTXEzTVI0WWI1WU5qeElHdFBnUlZQbnBpM1FLV0ZYVlhRTVArV0xTVFZm?=
 =?utf-8?B?T1RqQU5QTUtoR2MxVXFEUytUMncyR1VsQzRWMGw3MTJHY1NnV1Z4Vzk5L21h?=
 =?utf-8?B?Y2h2YnB2ODBMV2ZTd3BYUFp6YWY1KzB1OEFUSFUwM0N5Yys4YVlPakFNeHhx?=
 =?utf-8?B?RURPaU4rdnZLeFVUaExyWmlTUFdFbm8yR2RvbnFWZ2xGMEd2ekZ6b082a0lt?=
 =?utf-8?B?T292eStURTZEb1N6N2VXVXRUQkFMU3NXeFhyTGR3dUVtOEpyd0JlV05acElI?=
 =?utf-8?B?SFdPMFI0VmxPYWhjQ0RoOFFoTFJPOWFWaWE0L0tTd0Y4d2dVQ29RcWs3d1gv?=
 =?utf-8?B?ck5sVmFKZTJPQ3B1YUlXRnFQb3VreUd3MjJ6dWZ4bklWeHhXMUtCOE9GeEVs?=
 =?utf-8?B?cDV3WWE5RU5iNUJjeXRVODdzMzZyc3U0RkZGeUJCL05ZTWNoNEJlRXFQeTFU?=
 =?utf-8?B?TitPSGlYYUlnQVVkYmNNSGRIb3ZBMGpqcHVPeVV5L2tuM3FkcEkyRVp6NmU1?=
 =?utf-8?B?clRkV2ZFZ2JKTXpuTnhCZW54Y2dKRXFkNkY2eXRsTzQwQTVYR2F6UnVrdnZx?=
 =?utf-8?B?UzVJWFp0RFd2RFBLblJlQlBFVk96TVJWZkd6M0RWMnRVZ05uMlVDS1IxNlVK?=
 =?utf-8?B?ekJ1U3pXRDNvcXlwUkc1bGxxK2RpQWFuVXZqdFE0cENUU0RmdTRDVWhMcHRM?=
 =?utf-8?B?S0xqYjdlc0xFN2ZTMGxJM0VXQ0NLMG1UVERSeXRIdDlOQXdSYldTVUJWTGFs?=
 =?utf-8?B?R3FLY2xVanluUVk0OU4zSUY0ZDN0bmZ2bUhkRTh5Tlpyc2FwVE5CVml3REV3?=
 =?utf-8?B?cGZPcEUvTnUyenR0RGZkWEsrT1JWeFJOR1oydUlnMkNZdTZPQ25VM2ZIamdH?=
 =?utf-8?B?ZU1OWnRNNTBaREplWUNrYlNYcHZSQ0MzWEp5c1hOMTd6emd5OU9HSW91c0lE?=
 =?utf-8?B?NkR6WlFJR2hmcDRYNkdTUm1PcVJHODNzS2dBTDdDTFhBdUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmV0V3hONGlyUjBTbGVWbkNVa0t0Z21MS1Y4ZVQ4ZW5VdXVFU25jRk5mZWx2?=
 =?utf-8?B?U0c2d1RuSnl4Rm9BeEJvWW5VU0dDVXJnRCtyamFVd2s3M1crQWxwQUZyZk53?=
 =?utf-8?B?NVdGY2c1RFpZL0FQWWRLTFVPeExqaGFJNGJ5NnVKQ1lGSWczWTY1ZytTQklL?=
 =?utf-8?B?ZFZCM3d0T0FMRWRmd3p4VERybkVuKzNYYXYzMnRtWVdsd2tKWGZXREQwemJw?=
 =?utf-8?B?Uy8waW4rOEEreUo1Yy9IMU8wZ0ROYVhjYVE2SmZ4eE9TbWtCRFBkM1J3SGZY?=
 =?utf-8?B?T1djbXRsNW04UE1hL1RBQ0NlRlo1V0Jubk5aczNTNEcyeUJ3aWV2L3ZEUDc2?=
 =?utf-8?B?cUc0dTNpNXBadnljV1kvZzdiU1J3SEdVNzY5TGUxRTZMc2RRZjFPSTJwK0dI?=
 =?utf-8?B?UGJocTNIQ0t0SW5MbGp0dUhwYTlTVDMvTXVDUElwTEpEOXV3b0tUbXlVSFVY?=
 =?utf-8?B?L3htdDNVcVRRd0hibURXNngrL3EzV2p0UmVXNnRTcXIvRUdTdnpicHlHKzJr?=
 =?utf-8?B?YndPQWR6d3hpUVRSUEd5a1AwbUlDSFFGZ2g1dVJiSjNwaGE5Q0hiZGJrM21Z?=
 =?utf-8?B?aHhqQlIvRk5rMUg1S2JLemhKVk9SYkRPNzZPU3F3UVRpdEFROVNQaDdmZldD?=
 =?utf-8?B?eHl6cWs4WGw5a1o0Yjh0WisrRmtsaXpGU0tVN21iVURUTzJ5Sm1nUThJZjVS?=
 =?utf-8?B?ZUg4U1J1ZEwwb0FVSG5FSzBPVlF6QTJDSW16ckJHUjM1c0tzS2RRYjh5Wkdi?=
 =?utf-8?B?QTlNdVM2Zit0S3N5NkQ5bUxNcjE1cWQ4ZFprOGZ1Y21ycng3VnNTRXdTZ2p4?=
 =?utf-8?B?VUhpYnRORVp5bFN1YldvZHJlZk9aMW5ET3NrbitvMERIMEppYTdQSmdqZWZa?=
 =?utf-8?B?ZjJRaFVRZ3hGbUxYc1NYOVdPUWhqQXlCUi9qZWc1OGxrL2dsUU9PbUh2dWpD?=
 =?utf-8?B?NkI5aUxIa052bkg4UXp5Z1owTkNTZ0tiTzdFakJHME1uSm1BNWtzaXplQWZy?=
 =?utf-8?B?SUo5TXhIYWxYS0RKVnpxR3Qramo3MmN2MWZJeFFGM0NMWlVuRk1RbDl6U09a?=
 =?utf-8?B?b1ZNZmtrTzFmekliRkpHMHV2RkQzNnFTalFRYkJWOTVnR2k3MTgyU21meHNF?=
 =?utf-8?B?U2ZyTVFDemZTWDdrT013eWdRQmpQWkZ3Qm5hS3BVT2R5Z2RIaGVqWXgvWjNJ?=
 =?utf-8?B?cjdmK3FzRVFvaldRblp5clQ5V042SG5oRDAydFQ1VmNlMDRKM2JoR2szL1BX?=
 =?utf-8?B?MHIxN3Z0aTRQcGNvNFhpa0xDcmRmUGdsZzlqb0pJeHNZRVhoVnc1NWYwQXh2?=
 =?utf-8?B?aUViMW90dHNybzFGRUNWSnZ3TVF4bXIyWjQycEM4RWJrOHdsdEZLeVF2YWpo?=
 =?utf-8?B?eWpETmxzcnV6OXRNajE1VE9EUUxYdUNwM0tWaHdHOFdqWXpEaFVkL2dac2xK?=
 =?utf-8?B?SW90c3ZFUlZ6MERmeFUzcnQzaENCVzhLWmxIbytnamFoTThGZVNxMmo1bU92?=
 =?utf-8?B?SXd1S1IyVmpONWZNcHNhcDNaVE85aEdUQXU3NzcyTkQ2b25EMHRhOWlocmx5?=
 =?utf-8?B?dS9KMVFXSHYrdE8xSDR3aWVtTWY2emdTK2UyNCtBdXgzblJ6V0VEcEVUN0ph?=
 =?utf-8?B?anExU1UzL3o2TUtKYS94U0RDRWdIYUZVYW9sVk1HWW1EdXpSMi9rY3hjK0NL?=
 =?utf-8?B?L3dBU3VqQTFTMVJGOVZTU3FUV3E1NDh3M2ZBWUwzcXlwS3F6QWxuWjRtUjh3?=
 =?utf-8?B?NUVXald1L3ZseFFIVW5zRk5xZ2hkZTRCekkyTk9wSlNTQWswRUFHTCthQnlD?=
 =?utf-8?B?dlIrL0RFYmNXYkRLS3NSblU2WlpYbU1ObFp0bnFNaU8zZnJaenVkdW1Kallw?=
 =?utf-8?B?ek5oSEV4ZGNnNWNJdjdLWExYZXdNN3ZsNnhkTzByN3RobnFXVkZ3cElYenJr?=
 =?utf-8?B?K1ZkTmd4NWdhUDRJSEJtY1U2K1RyNXdld1FpS3VjbkFYdFRMNkQwU1BPRWRD?=
 =?utf-8?B?UVpVR3UzNW5ReUtGREtMQTY0L1BrTnNCOTdnYWM2YzBNUC9QekZIa25tQloy?=
 =?utf-8?B?dW9Ka1h4K1hJelVjRm9TcDh2STZ3ZUZOdDVqMW90aGk3dUUyRkZWbmMxdU8r?=
 =?utf-8?Q?x+zU=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19126159-a8e2-46eb-2877-08dcc1254341
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 14:34:56.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CT6/X7hiIn+q32Zl4PYcu6gBwcGanQRWivGdc3IsbtnCDKOPqp4GjFc2EiYPBZFJp+DLmUodd5yfkeYU0k+lCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6932

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpBZGRlZCBudWxsIHBvaW50
ZXIgY2hlY2sgdG8gYXZvaWQgc3lzdGVtIGNyYXNoLg0KDQpVbmFibGUgdG8gaGFuZGxlIGtlcm5l
bCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQNCnZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAw
MDAwMWE4DQpwYyA6IGdzX3JlYWRfY29tcGxldGUrMHg1OC8weDI0MA0KbHIgOiB1c2JfZ2FkZ2V0
X2dpdmViYWNrX3JlcXVlc3QrMHg0MC8weDE2MA0Kc3AgOiBmZmZmZmZjMDBmMTUzOWMwDQp4Mjk6
IGZmZmZmZmMwMGYxNTM5YzAgeDI4OiBmZmZmZmY4MDAyYTMwMDAwIHgyNzogMDAwMDAwMDAwMDAw
MDAwMA0KeDI2OiBmZmZmZmY4MDAyYTMwMDAwIHgyNTogMDAwMDAwMDAwMDAwMDAwMCB4MjQ6IGZm
ZmZmZjgwMDJhMzAwMDANCngyMzogZmZmZmZmODAwMmZmOWE3MCB4MjI6IGZmZmZmZjg5OGU3YTdi
MDAgeDIxOiBmZmZmZmY4MDNjOWFmOWQ4DQp4MjA6IGZmZmZmZjg5OGU3YTdiMDAgeDE5OiAwMDAw
MDAwMDAwMDAwMWE4IHgxODogZmZmZmZmYzAwOTlmZDA5OA0KeDE3OiAwMDAwMDAwMDAwMDAxMDAw
IHgxNjogMDAwMDAwMDA4MDAwMDAwMCB4MTU6IDAwMDAwMDBhYzEyMDAwMDANCngxNDogMDAwMDAw
MDAwMDAwMDAwMyB4MTM6IDAwMDAwMDAwMDAwMGQ1ZTggeDEyOiAwMDAwMDAwMzU1YzMxNGFjDQp4
MTE6IDAwMDAwMDAwMDAwMDAwMTUgeDEwOiAwMDAwMDAwMDAwMDAwMDEyIHg5IDogMDAwMDAwMDAw
MDAwMDAwOA0KeDggOiAwMDAwMDAwMDAwMDAwMDAwIHg3IDogMDAwMDAwMDAwMDAwMDAwMCB4NiA6
IGZmZmZmZjg4N2NkMTIwMDANCng1IDogMDAwMDAwMDAwMDAwMDAwMiB4NCA6IGZmZmZmZmMwMGY5
YjA3ZjAgeDMgOiBmZmZmZmZjMDBmMTUzOGQwDQp4MiA6IDAwMDAwMDAwMDAwMDAwMDEgeDEgOiAw
MDAwMDAwMDAwMDAwMDAwIHgwIDogMDAwMDAwMDAwMDAwMDFhOA0KQ2FsbCB0cmFjZToNCmdzX3Jl
YWRfY29tcGxldGUrMHg1OC8weDI0MA0KdXNiX2dhZGdldF9naXZlYmFja19yZXF1ZXN0KzB4NDAv
MHgxNjANCmR3YzNfcmVtb3ZlX3JlcXVlc3RzKzB4MTcwLzB4NDg0DQpkd2MzX2VwMF9vdXRfc3Rh
cnQrMHhiMC8weDFkNA0KX19kd2MzX2dhZGdldF9zdGFydCsweDI1Yy8weDcyMA0Ka3JldHByb2Jl
X3RyYW1wb2xpbmUuY2ZpX2p0KzB4MC8weDgNCmtyZXRwcm9iZV90cmFtcG9saW5lLmNmaV9qdCsw
eDAvMHg4DQp1ZGNfYmluZF90b19kcml2ZXIrMHgxZDgvMHgzMDANCnVzYl9nYWRnZXRfcHJvYmVf
ZHJpdmVyKzB4YTgvMHgxZGMNCmdhZGdldF9kZXZfZGVzY19VRENfc3RvcmUrMHgxM2MvMHgxODgN
CmNvbmZpZ2ZzX3dyaXRlX2l0ZXIrMHgxNjAvMHgxZjQNCnZmc193cml0ZSsweDJkMC8weDQwYw0K
a3N5c193cml0ZSsweDdjLzB4ZjANCl9fYXJtNjRfc3lzX3dyaXRlKzB4MjAvMHgzMA0KaW52b2tl
X3N5c2NhbGwrMHg2MC8weDE1MA0KZWwwX3N2Y19jb21tb24rMHg4Yy8weGY4DQpkb19lbDBfc3Zj
KzB4MjgvMHhhMA0KZWwwX3N2YysweDI0LzB4ODQNCmVsMHRfNjRfc3luY19oYW5kbGVyKzB4ODgv
MHhlYw0KZWwwdF82NF9zeW5jKzB4MWI0LzB4MWI4DQpDb2RlOiBhYTFmMDNlMSBhYTEzMDNlMCA1
MjgwMDAyMiAyYTAxMDNlOCAoODhlODdlNjIpDQotLS1bIGVuZCB0cmFjZSA5Mzg4NDczMjdhNzM5
MTcyIF0tLS0NCktlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBPb3BzOiBGYXRhbCBleGNlcHRp
b24NCg0KU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KLS0t
DQp2MzoNCiAgLSBBZGQgc2VyaWFsX3BvcnRfbG9jayBwcm90ZWN0aW9uIHdoZW4gY2hlY2tpbmcg
cG9ydCBwb2ludGVyDQogIC0gT3B0aW1pemUgY29kZSBjb21tZW50cw0KICAtIERlbGV0ZSBsb2cg
cHJpbnRpbmcNCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIHwg
MzMgKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdl
dC9mdW5jdGlvbi91X3NlcmlhbC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2Vy
aWFsLmMNCmluZGV4IGIzOTQxMDVlNTVkNi4uZTQzZDgwNjVmN2VjIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dh
ZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQpAQCAtNDUyLDIwICs0NTIsNDMgQEAgc3RhdGljIHZv
aWQgZ3NfcnhfcHVzaChzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQogDQogc3RhdGljIHZvaWQg
Z3NfcmVhZF9jb21wbGV0ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpy
ZXEpDQogew0KLQlzdHJ1Y3QgZ3NfcG9ydAkqcG9ydCA9IGVwLT5kcml2ZXJfZGF0YTsNCisJc3Ry
dWN0IGdzX3BvcnQJKnBvcnQ7DQorCXVuc2lnbmVkIGxvbmcgIGZsYWdzOw0KKw0KKwlzcGluX2xv
Y2tfaXJxc2F2ZSgmc2VyaWFsX3BvcnRfbG9jaywgZmxhZ3MpOw0KKwlwb3J0ID0gZXAtPmRyaXZl
cl9kYXRhOw0KKw0KKwkvKiBXaGVuIHBvcnQgaXMgTlVMTCwgcmV0dXJuIHRvIGF2b2lkIHBhbmlj
LiAqLw0KKwlpZiAoIXBvcnQpIHsNCisJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNlcmlhbF9w
b3J0X2xvY2ssIGZsYWdzKTsNCisJCXJldHVybjsNCisJfQ0KIA0KLQkvKiBRdWV1ZSBhbGwgcmVj
ZWl2ZWQgZGF0YSB1bnRpbCB0aGUgdHR5IGxheWVyIGlzIHJlYWR5IGZvciBpdC4gKi8NCiAJc3Bp
bl9sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KKwlzcGluX3VubG9jaygmc2VyaWFsX3BvcnRfbG9j
ayk7DQorDQorCS8qIFF1ZXVlIGFsbCByZWNlaXZlZCBkYXRhIHVudGlsIHRoZSB0dHkgbGF5ZXIg
aXMgcmVhZHkgZm9yIGl0LiAqLw0KIAlsaXN0X2FkZF90YWlsKCZyZXEtPmxpc3QsICZwb3J0LT5y
ZWFkX3F1ZXVlKTsNCiAJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZwb3J0LT5wdXNoLCAwKTsNCi0J
c3Bpbl91bmxvY2soJnBvcnQtPnBvcnRfbG9jayk7DQorCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JnBvcnQtPnBvcnRfbG9jaywgZmxhZ3MpOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBnc193cml0ZV9j
b21wbGV0ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEpDQogew0K
LQlzdHJ1Y3QgZ3NfcG9ydAkqcG9ydCA9IGVwLT5kcml2ZXJfZGF0YTsNCisJc3RydWN0IGdzX3Bv
cnQJKnBvcnQ7DQorCXVuc2lnbmVkIGxvbmcgIGZsYWdzOw0KKw0KKwlzcGluX2xvY2tfaXJxc2F2
ZSgmc2VyaWFsX3BvcnRfbG9jaywgZmxhZ3MpOw0KKwlwb3J0ID0gZXAtPmRyaXZlcl9kYXRhOw0K
Kw0KKwkvKiBXaGVuIHBvcnQgaXMgTlVMTCwgcmV0dXJuIHRvIGF2b2lkIHBhbmljLiAqLw0KKwlp
ZiAoIXBvcnQpIHsNCisJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNlcmlhbF9wb3J0X2xvY2ss
IGZsYWdzKTsNCisJCXJldHVybjsNCisJfQ0KIA0KIAlzcGluX2xvY2soJnBvcnQtPnBvcnRfbG9j
ayk7DQorCXNwaW5fdW5sb2NrKCZzZXJpYWxfcG9ydF9sb2NrKTsNCiAJbGlzdF9hZGQoJnJlcS0+
bGlzdCwgJnBvcnQtPndyaXRlX3Bvb2wpOw0KIAlwb3J0LT53cml0ZV9zdGFydGVkLS07DQogDQpA
QCAtNDg2LDcgKzUwOSw3IEBAIHN0YXRpYyB2b2lkIGdzX3dyaXRlX2NvbXBsZXRlKHN0cnVjdCB1
c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcSkNCiAJCWJyZWFrOw0KIAl9DQogDQot
CXNwaW5fdW5sb2NrKCZwb3J0LT5wb3J0X2xvY2spOw0KKwlzcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZwb3J0LT5wb3J0X2xvY2ssIGZsYWdzKTsNCiB9DQogDQogc3RhdGljIHZvaWQgZ3NfZnJlZV9y
ZXF1ZXN0cyhzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCwNCi0tIA0K
Mi4zOS4wDQoNCg==

