Return-Path: <linux-kernel+bounces-418009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0619D5BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E069283BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB481DE3D4;
	Fri, 22 Nov 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MfR9+gkv"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013020.outbound.protection.outlook.com [40.107.44.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880911DDC32;
	Fri, 22 Nov 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267097; cv=fail; b=uQ5NXAhJiVHvWGYj6YzNFeKQMnBXXLlBrvxhLcyDx+liqzrmblFaK0NFWAPL8Dl4KJ/GgzzdGBlvpbGr7kmQGTXFY+EbdAOjs7TsiD9ypeSvJGMqQoDf7GxvbaDy8T1Ya67RTXkwj8yqXX8+higRAs4eMCQDs3qlGH4w6rd/jRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267097; c=relaxed/simple;
	bh=fOmpEg7f8dg+Y6XoMd7Z2kX3H17IHLmaygV+ZEd5Avc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RWwX5pe3oO+WwKi5kCrq4rQwjtioRfQDDTHwBRnMvOsDKv8D2DJHXWWBcuGKhxUbaXj/SR1N/RZmKSc3AIxgeVAJw1R6vNNdqQvU2pcS+gIwuOWHCX7GcAEVIvAZh4ElsdhDCFaCga0Y/74OQStmlw/WVQ74m3uDDZN25+czNuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MfR9+gkv; arc=fail smtp.client-ip=40.107.44.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abqQCXe3ypeRfa7cRuVmGkbWDeVLQ048ktYn3z02Ph945CtVs9fFahW61em1N6xHjc+OfC6W++wUheZgTAe4BXlwvZl2R9ZhTHEBRzsze+3DtP7VQAMiCnPnjWG+/JOFOX5EKwCbprYU9wc2WH21SVUxLLfuH6zHeWXSDlXB62nrHx0+tGC7aECXMuzhysGPyKkiHNrh6kaR1ag/TY4agsRP2iH8FngzDSrCIG+8MmbYTJ+dIWEQ0pzyvh2I+zzXoZ1MJjzjiuLXb8+VqGYanOxhqOKUIJx88++GYK8/E7FLBjAA8XBGz8RWPw/2M4LvNKl8RQhHsO9UXJP3RK+Xvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOmpEg7f8dg+Y6XoMd7Z2kX3H17IHLmaygV+ZEd5Avc=;
 b=vzSXBri8wu/zC8On2n3i4T1wLXwGAd7zk433C4vIwYQNVgXN6wy0k4voQY6n+UDTrgIzEXH3qvXl27ma1I3yclGQsglNI5chE5HBm8Ch/m0vsg1oshm+mY+5W1Dx0Se6L7dhtqzqQ6+8sNwsv6g77nRLqOuaOgAsy9g4Ajw7S61xpIZtnp/lSvoz5ytdNT6xJ+Tpb8QJVVepQaWb+VxGJJ4lW1PFY/M+h1LMiVX1vYvpXMt4nmuGc3z//GbrUpH1osLYMUebXcCP8OijKQvjDTvIH715YwrABOYHGDKj0um4IFlvQpFEzF0V7fZC/9FcIpDiMGcW7IJx221ZUJfl/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOmpEg7f8dg+Y6XoMd7Z2kX3H17IHLmaygV+ZEd5Avc=;
 b=MfR9+gkvl6bjwzYjiSwcO4N8snGESQRUIlypUu8woDXS0U8SVg1GUmRQSBLEwjMkHglMIM/Wg/T7FPMfaBpKxBFmWfTuXyxdGa/4m8pmCdnkosahbyRPu824SpI9+4MvMVqHU5ShJ1/qKIgGow/G+ZPkltsMBVQXJNC2eFY42KCCYb6E96xtLSzmdcj9+6wY8p/+18shTqGfyn02ist5WuEWMNTkWYf8R9bZ9Eq4IwdR9CS7vXZfvu3R4veo3YbLoTxRjb8UmxB11yyGK8KJJ44eSKmsa1qe7FB+C/Zbt2XnHmHNA5RQSlNLVGSPi2SxvvymoCMTPCun8d706+tBUA==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TYZPR06MB6914.apcprd06.prod.outlook.com (2603:1096:405:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.12; Fri, 22 Nov
 2024 09:18:12 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%6]) with mapi id 15.20.8182.014; Fri, 22 Nov 2024
 09:18:12 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: Prashanth K <quic_prashk@quicinc.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "quic_jjohnson@quicinc.com"
	<quic_jjohnson@quicinc.com>, "mwalle@kernel.org" <mwalle@kernel.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?gb2312?B?tPC4tDogW1BBVENIIHYyXSB1c2I6IGdhZGdldDogdV9zZXJpYWw6IEZpeCB0?=
 =?gb2312?B?aGUgaXNzdWUgdGhhdCBnc19zdGFydF9pbyBjcmFzaGVkIGR1ZSB0byBhY2Nl?=
 =?gb2312?Q?ssing_null_pointer?=
Thread-Topic: [PATCH v2] usb: gadget: u_serial: Fix the issue that gs_start_io
 crashed due to accessing null pointer
Thread-Index: Ads8EVVJRUOwpsmOSCeQNLdPNS2SOgApnW0AAAHW7qA=
Date: Fri, 22 Nov 2024 09:18:12 +0000
Message-ID:
 <TYUPR06MB62179BCA9CDFD1125DC8CDEED2232@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62178D00DC96CC2702114CF5D2222@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <b0c787ad-55a1-4fb1-b9cd-1f688ea65316@quicinc.com>
In-Reply-To: <b0c787ad-55a1-4fb1-b9cd-1f688ea65316@quicinc.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TYZPR06MB6914:EE_
x-ms-office365-filtering-correlation-id: 9871a4aa-dbd0-4366-83b1-08dd0ad696b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?Y0hKYmxDbXJKRFhGaHZDQjNwd1JxKytwUWRSeWZ2ZXcxTlFyUWxTSjZXWTl4?=
 =?gb2312?B?Nmk1V3BzQllOUVRvZWJYeFVlNlRWd29PUW42UWFsVm5YSkNMNWlvdFdGRlJ3?=
 =?gb2312?B?N0FQRXRHNXIxZXZBUHEvZnRoVjg0QmNQTTZJcTUrVG1jNHphZjFZbE9MejZ2?=
 =?gb2312?B?MEZrUit5MG80OW9IWGtHcXJQTTVxNlJ0eVZlOXNGNlQ4Yk9rYW5xWGFidHov?=
 =?gb2312?B?cFNOLzlqOFhraW5xNW1KblV1UFRpam1YOUR6SDRDdUVWVnVmNEpuZGt5SFFG?=
 =?gb2312?B?UEFiUExlT1F0Sm0rK1JuNlYrNGpiMDF4bjRuek9vdnJJQXNQZXQ4NzZDb3pC?=
 =?gb2312?B?bnlQNGcvOVBOeldtOXliR3RrRmwzRFd5N1pUNkVzWHRhRmhBNHg2SFluU2RB?=
 =?gb2312?B?ZnVvRnFJeGR4VEdONVlaSTBtaGFQYi9STEgvcjhEcGJhVzVsMmpQdSt0dTJl?=
 =?gb2312?B?bkJwa2hVQlowM3c5RE02WUZUZkMrT3p0T1B1UEdvZHBSSERQbDh0bm0vZk02?=
 =?gb2312?B?L094YVZpTG96UDBjaGUxdzArUUtTdjY2aGNsdGFlOFVKcTZiY0w4UVo0TWxt?=
 =?gb2312?B?VnJsNS9mN1pIN2w3K0dKcXhRSFY4WVFPMXl6VVp4QTZBU2ZtcElwQTVxQ1NZ?=
 =?gb2312?B?L2JlTTVDL1E5YXhqVXVSLzVwVlkzdmVNZGJ1MmxXbXBvaFR1ZFZwRDlaMkRU?=
 =?gb2312?B?Y0pjN0liNytNTTNTSFdpbjR2ODVyTnFVMXFMQTJYUWtCNGdTZkdZVVZXK25r?=
 =?gb2312?B?Z2pwRUpPZ1JQOE9OMGlKRXJPNnEwL1hWNFUyNVVwQ1d2cXVuS2tvRXN5U243?=
 =?gb2312?B?OVhoZWY4eHE0MXZLWUMvRXhmS05RYlUzVTI0ZTM4ZDVQSWNncnhaOVkyZkdS?=
 =?gb2312?B?VFdQajNwdlBqV0V4QWZTNTZsRThuaC9VL3FWRjh2YkUvOHkyVElnTFJ2SzZZ?=
 =?gb2312?B?ODNsZUJnTnkwT2FxOGI2UGpHeWMwNzY5MnRVcEdjbWRxSFdpYVl5RDNsa3pP?=
 =?gb2312?B?ZU10TjhsT0xENmVlZUtaL3gwNTVOajQxTTdJcEtlODdNWVBhR3VrTFlqeDJ0?=
 =?gb2312?B?c1RHaDBsVjRINk0zZmFWd0tPSmQwMzV4dDFPc2pzV3k4UE1oOXVLZ0VBUUVB?=
 =?gb2312?B?amd3U0VTUTF5RnltK0M5WkJjS0hBOGQ1N3hZRXk0UlRTSExQaEVBWEFSWkpu?=
 =?gb2312?B?eEl6KzZvckMvVTJIUGZLM2dEVVRGa0UyNEExeFZqRzk5NzRjakJoZHdNbUJX?=
 =?gb2312?B?S3dQV0dTV0JiZGFHajROR3hkZ2crYWlVT2g2REZJdVIrL1FrY2NQS3NiYy9w?=
 =?gb2312?B?TmYwOFZhZ2hQV0cybnNZMDVWWGxpZDdyaDJlYTcwS3p5M3JBZlA5TldmMGNT?=
 =?gb2312?B?UlZlSW4xZWpFSWh2V0x5L2ozMmRRS3htWmRaV1NWUEU4a3NkNEtZR3VEYXAv?=
 =?gb2312?B?UjdjRkIzRzh5dnZmOWdWRlBubGRXbGJlWnBjbFlQbXlMU1ZCSHpzTGc3SENL?=
 =?gb2312?B?MnNXeWhVSmUzYUFEaFcreVFnaHN5VXF0WnlpZzEvcHk1TW0yZmVrSUJNeGVV?=
 =?gb2312?B?WWNyQ1V4RVlRcXBoU1ZYMjdxbUdqaHU5TG9NWTBPZGU2bzNRNFdNM1djNERj?=
 =?gb2312?B?OXdrUVJoUHQyWFh5YzZaWEY3RlJ2aGZDN2x0WkdMczdacjFqNnNMdENGUFR2?=
 =?gb2312?B?VzZSM3B5VnlyelBKd0xiaHpDdmF3cXArVnArVTRKWVdJeDltQVkyNXlZQk5X?=
 =?gb2312?B?RG1tWitHNmtrUWxRcmFZbjdhcUw0K0NRbWpBYWRXNEgya0R4ZXBFdTBuYXBq?=
 =?gb2312?Q?WOAhz4rFkruN2j8mS7fMAvFJi1lTETpeYganE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Zm41RFB5ZEdIa3hyaGlsV1JqTi9meTRDbFM0VXVoWERNRi9CUlNESmF6cncz?=
 =?gb2312?B?L0NmaVExL3JGdE5ldVJOaExKWEtKMUF2dGlYRlR5eGx5T0QrY0dTWWtwdG1z?=
 =?gb2312?B?T0NXTDRTVUlkY1FJWWNySEJpTUsvVkUzZ05aRGUzazdGT3V3YUtUamlXNndz?=
 =?gb2312?B?T1liWjI1SkV1cjhxdkhUWVBwa2NsakVJK2drZVNjOGdJb1hWTDF2S05GQ1ps?=
 =?gb2312?B?VFgxeGxhTllhMEpGM0V2OXI5VEJjaTI3c2VMNzFMVWFNYzVmY242Yll0OTFx?=
 =?gb2312?B?eXQ1b1kzOHVOUU1XWFRFNkxnUXVnQ2dtTGNXR05ENzdSNFBobGJiZkxKL1dk?=
 =?gb2312?B?ZFp4WTNUS3FIdmlEekVqVDliN1Y1dG5YUzE5WTh5cjFiczRGTTJ4YzV3YXBh?=
 =?gb2312?B?MFF5NmdJWFNsYzlGL3ptUm01YXJONWRid1hqUWc3R1I0cFFxWklyT1ZBS2Rl?=
 =?gb2312?B?cTdhRmNMUnc0WXhWdHVxVm1DOENHbmRvZ1NQUmJjTEtWakhnT3N1MzhyS0F3?=
 =?gb2312?B?VWFpaUdPK3ZSTkpPUm9XZEVGbU8wYUYzNUdBOTErSE1SNVJyMUV5R2FaOUtH?=
 =?gb2312?B?eHIxdzJ3Z2lNaTNUZ0RLdnhESWNNQWJnZkltQlJKalBGejBlRDltRXduRmpl?=
 =?gb2312?B?QXZ1eW81VmtRa24wZ2VyTEVkSEk5QzRId1pmcVNqY3o3OWhkbW9mOXFlVXNu?=
 =?gb2312?B?V2F2bnY4VEsva1NRNTl6OWZHK1hBWHNvbVRob2M4ZmRPdmlURDJDVTNpSXZy?=
 =?gb2312?B?V2djc2xQTWY1SXlUbHRZU2lVSEowZnJ0UlJBY0pPakxIUzJUUlNLUDBzeElu?=
 =?gb2312?B?SDNxbXBROXZjc29nTVpqSkFibFdTSHRNc1U4WElYZkQ2d09UQnFFQ0txKy9B?=
 =?gb2312?B?VERCRTlXcnFpNUl5R2YxUmhSZXlWT243L2hSR09yczRyMHZTdDBaajgyb3lI?=
 =?gb2312?B?RFQ3WGk3U3ovaklsTzN3TVpiNEFZeWNNa2tkWTJjNXA4M1ZCaFZXbGZHeU1L?=
 =?gb2312?B?cnp4Nys5SVNjVlgwa2VHNlBjNzVHZlJGMjVybUVrZXlkbHl5UWtTMEk1Y1lP?=
 =?gb2312?B?dDkyYmh2aHhOekc3RW5XMURyVEtNK09WVnoranZIMWVPTVlWaUdEV0dqK1ls?=
 =?gb2312?B?bUJTZ3hZUjFLd1pUZW02Q0FqdkdWYktDZnBDQmU0ZmZhWXFBdVVHWXhLckd4?=
 =?gb2312?B?dzRnQUhCcFMraXdOeHZRSE9hVGJ2ZGtWS01LODdsTXpBWFc1RnBVN1Jnc2pY?=
 =?gb2312?B?bm1uQ00xME5EMXMwdGIvZmY4V1Q4aDIwQ0NjTnEzNzJKNGhZUjUzSFRCb0tX?=
 =?gb2312?B?OUZPZ1l0cHpGK1YydUR6b3FWQ1luVGtHV093T3RWczV4ZFhlOHdwb25HcXc2?=
 =?gb2312?B?ZmpQQUR4cDFuK0p5TnBsU1RqMGVySmpWeUI1SGZ2cXpwbTVNQWI1V2lrVmo2?=
 =?gb2312?B?d3lraE90MUgzZVoyLzVodUtXMzVkQjlxTE1jLzAxN05MUm9KWTQ4VE8zQjFk?=
 =?gb2312?B?Sm53S1ZCU0craEk5b1hweHBEbFprVXlrQ1ZoaHhTc2NXTmRYL0pQT2hadGIw?=
 =?gb2312?B?dDE5UCsrb0RUanZva2puVFpidG1jOTJWNytJN3VVRkwvMStyV1FQa3ZLSnZD?=
 =?gb2312?B?N3Bad2sxNXhOTE41MHU4c0k5RFZTaklQTjhHVTF6YlRXbjAvbHNkUDRINDlY?=
 =?gb2312?B?V01MYVM5TWVWUW9RZGZWamVMOWRxVko2STFYb3ZIWW0xQVpMVU1nRHhsZk56?=
 =?gb2312?B?U0pCMys1U0RIRTByeDdzRFNkSzFwSlNPZVJtSWprVWFDY2YzQkhPZ2xFUlor?=
 =?gb2312?B?a3ZQNjZxZjFiRmJKcVlkTUZ2WEV6OSswVi9uV3c2cVhNTHl6eVJScEg4UzR2?=
 =?gb2312?B?eVllWXRaNml6VVhkTmloWHdmbUVGM1AyZ0JhWVJyOHZnMHptY2pqZzB6WUVn?=
 =?gb2312?B?VTZET0pOczQ3N3FSdDBlaFZDS251WGd0Y1Z1UjVtY2poNWMyQm4vQ2lGMlFi?=
 =?gb2312?B?bFlqYWxmNkJBRDhzMnlvcmQ0cnhxcEtjaGxuZ1FLVnFDVFVkYzlUS044TE5U?=
 =?gb2312?B?NGM3S09NMERuT3RxSjczTmZ4NU1yM3BieGlLM3c5WE5WeXhXNEhnRWFja3lG?=
 =?gb2312?Q?d8EI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9871a4aa-dbd0-4366-83b1-08dd0ad696b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 09:18:12.3825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgSW6SJaa6zF57YzDxavd3L7uFwS3PxEVnv2BGEVnwyBezdLEBOZqDA9OpfrGga7Bu3QAQf2f1GJQeGLjJFqZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6914

SGkgUHJhc2hhbnRoIEs6DQogDQo+ID4gQ29uc2lkZXJpbmcgdGhhdCBpbiBzb21lIGV4dHJlbWUg
Y2FzZXMsIHdoZW4gdV9zZXJpYWwgZHJpdmVyIGlzDQo+ID4gYWNjZXNzZWQgYnkgbXVsdGlwbGUg
dGhyZWFkcywgVGhyZWFkIEEgaXMgZXhlY3V0aW5nIHRoZSBvcGVuIG9wZXJhdGlvbg0KPiA+IGFu
ZCBjYWxsaW5nIHRoZSBnc19vcGVuLCBUaHJlYWQgQiBpcyBleGVjdXRpbmcgdGhlIGRpc2Nvbm5l
Y3QNCj4gPiBvcGVyYXRpb24gYW5kIGNhbGxpbmcgdGhlIGdzZXJpYWxfZGlzY29ubmVjdCBmdW5j
dGlvbixUaGUNCj4gPiBwb3J0LT5wb3J0X3VzYiBwb2ludGVyIHdpbGwgYmUgc2V0IHRvIE5VTEwu
DQo+ID4NCj4gPiBFLmcuDQo+ID4gICAgIFRocmVhZCBBICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgVGhyZWFkIEINCj4gPg0KPiA+ICAgICBnc19vcGVuKCkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGdhZGdldF91bmJpbmRfZHJpdmVyKCkNCj4gPg0KPiBZb3UgY2FuIHJl
bW92ZSB0aGVzZSBleHRyYSBsaW5lcy4NCj4gPiAgICAgZ3Nfc3RhcnRfaW8oKSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb21wb3NpdGVfZGlzY29ubmVjdCgpDQo+ID4NCj4gPiAgICAgZ3Nf
c3RhcnRfcngoKSAgICAgICAgICAgICAgICAgICAgICAgICAgICBnc2VyaWFsX2Rpc2Nvbm5lY3Qo
KQ0KPiA+ICAgICAuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLg0K
PiA+ICAgICBzcGluX3VubG9jaygmcG9ydC0+cG9ydF9sb2NrKQ0KPiA+ICAgICBzdGF0dXMgPSB1
c2JfZXBfcXVldWUoKSAgICAgICAgICAgICAgICAgIHNwaW5fbG9jaygmcG9ydC0+cG9ydF9sb2Nr
KQ0KPiA+ICAgICBzcGluX2xvY2soJnBvcnQtPnBvcnRfbG9jaykgICAgICAgICAgICAgIHBvcnQt
PnBvcnRfdXNiID0gTlVMTA0KPiA+ICAgICBnc19mcmVlX3JlcXVlc3RzKHBvcnQtPnBvcnRfdXNi
LT5pbikgICAgIHNwaW5fdW5sb2NrKCZwb3J0LT5wb3J0X2xvY2spDQo+ID4gICAgIENyYXNoDQo+
ID4NCj4gPiBUaGlzIGNhdXNlcyB0aHJlYWQgQSB0byBhY2Nlc3MgYSBudWxsIHBvaW50ZXIgKHBv
cnQtPnBvcnRfdXNiIGlzIG51bGwpDQo+ID4gd2hlbiBjYWxsaW5nIHRoZSBnc19mcmVlX3JlcXVl
c3RzIGZ1bmN0aW9uLCBjYXVzaW5nIGEgY3Jhc2guDQo+ID4NCj4gPiBUbyBhdm9pZCB0aGlzLCBh
ZGQgYSBudWxsIHBvaW50ZXIgY2hlY2sgdG8gZ3Nfc3RhcnRfaW8gYmVmb3JlDQo+ID4gYXR0ZW1w
dGluZyB0byBhY2Nlc3MgdGhlIHZhbHVlIG9mIHRoZSBwb2ludGVyIHBvcnQtPnBvcnRfdXNiLg0K
PiA+DQo+ID4gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNl
IGF0IHZpcnR1YWwgYWRkcmVzcw0KPiA+IDAwMDAwMDAwMDAwMDAwZTggcGMgOiBnc19zdGFydF9p
bysweDE2NC8weDI1YyBsciA6DQo+ID4gZ3Nfc3RhcnRfaW8rMHgyMzgvMHgyNWMgc3AgOiBmZmZm
ZmZjMDhiNzViYTAwDQo+ID4geDI5OiBmZmZmZmZjMDhiNzViYTAwIHgyODogZmZmZmZmZWQ4YmEw
MTAwMCB4Mjc6IDAwMDAwMDAwMDAwMjA5MDINCj4gPiB4MjY6IGRlYWQwMDAwMDAwMDAxMDAgeDI1
OiBmZmZmZmY4OTlmNDNhNDAwIHgyNDogZmZmZmZmODg2MjMyNTQwMA0KPiA+IHgyMzogZmZmZmZm
ODg2MjMyNTZhNCB4MjI6IGZmZmZmZjg4NjIzMjU2OTAgeDIxOiBmZmZmZmY4ODYyMzI1NWVjDQo+
ID4geDIwOiBmZmZmZmY4ODYyMzI1NWQ4IHgxOTogZmZmZmZmODg1ZTE5ZDcwMCB4MTg6IGZmZmZm
ZmVkOGM0NWFlNDANCj4gPiB4MTc6IDAwMDAwMDAwZDQ4ZDMwYWQgeDE2OiAwMDAwMDAwMGQ0OGQz
MGFkIHgxNTogMDAxMDAwMDAwMDAwMDAwMQ0KPiA+IHgxNDogZmZmZmZmZWQ4YzUwZmNjMCB4MTM6
IDAwMDAwMDAwNDAwMDAwMDAgeDEyOiAwMDAwMDAwMDAwMDAwMDAxDQo+ID4geDExOiAwMDAwMDAw
MDgwMjAwMDEyIHgxMDogMDAwMDAwMDA4MDIwMDAxMiB4OSA6IGZmZmZmZjg4NjIzMjU1ZDgNCj4g
PiB4OCA6IDAwMDAwMDAwMDAwMDAwMDAgeDcgOiAwMDAwMDAwMDAwMDAwMDAwIHg2IDogMDAwMDAw
MDAwMDAwMDAzZg0KPiA+IHg1IDogZmZmZmZmZWQ4YWUwYjlhNCB4NCA6IGZmZmZmZmZlMjY3ZDBl
YTAgeDMgOiAwMDAwMDAwMDgwMjAwMDEyDQo+ID4geDIgOiBmZmZmZmY4OTlmNDNhNDAwIHgxIDog
MDAwMDAwMDA4MDIwMDAxMyB4MCA6IGZmZmZmZjg5OWY0M2IxMDANCj4gDQo+IFRoZXNlIGFkZHJl
c3MgbGlzdHMgY2FuIGFsc28gb21pdHRlZC4gQW5kIHRoZSBiZWxvdyBzdGFjayBjYW4gYmUgc2hv
cnRlbmVkLg0KPiANCj4gPiBDYWxsIHRyYWNlOg0KPiA+ICBnc19zdGFydF9pbysweDE2NC8weDI1
Yw0KPiA+ICBnc19vcGVuKzB4MTA4LzB4MTNjDQo+ID4gIHR0eV9vcGVuKzB4MzE0LzB4NjM4DQo+
ID4gIGNocmRldl9vcGVuKzB4MWI4LzB4MjU4DQo+ID4gIGRvX2RlbnRyeV9vcGVuKzB4MmM0LzB4
NzAwDQo+ID4gIHZmc19vcGVuKzB4MmMvMHgzYw0KPiA+ICBwYXRoX29wZW5hdCsweGE2NC8weGM2
MA0KPiA+ICBkb19maWxwX29wZW4rMHhiOC8weDE2NA0KPiA+ICBkb19zeXNfb3BlbmF0MisweDg0
LzB4ZjANCj4gPiAgX19hcm02NF9zeXNfb3BlbmF0KzB4NzAvMHg5Yw0KPiA+ICBpbnZva2Vfc3lz
Y2FsbCsweDU4LzB4MTE0DQo+ID4gIGVsMF9zdmNfY29tbW9uKzB4ODAvMHhlMA0KPiA+ICBkb19l
bDBfc3ZjKzB4MWMvMHgyOA0KPiA+ICBlbDBfc3ZjKzB4MzgvMHg2OA0KPiA+ICBlbDB0XzY0X3N5
bmNfaGFuZGxlcisweDY4LzB4YmMNCj4gPiAgZWwwdF82NF9zeW5jKzB4MWE4LzB4MWFjDQo+ID4g
Q29kZTogZjJmYmQ1YmEgZWIxNDAxM2YgNTQwMDA0YTEgZjk0MGU3MDggKGY5NDA3NTEzKSAtLS1b
IGVuZCB0cmFjZQ0KPiA+IDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiA+DQo+ID4gU3VnZ2VzdGVk
LWJ5OiBQcmFzaGFudGggSyA8cXVpY19wcmFzaGtAcXVpY2luYy5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KPiANCj4gSW5jbHVkZSBmaXhl
cyB0YWcgYW5kIENDIHN0YWJsZSBrZXJuZWwuDQo+ID4NCj4gPiB2MjoNCj4gPiAgLSBNb2RpZnkg
cGF0Y2ggY29udGVudCBhbmQgZGVzY3JpcHRpb24gYWNjb3JkaW5nIHRvICJ2MSBzdWdnZXN0aW9u
Ig0KPiA+ICAtIExpbmsgdG8gdjE6DQo+ID4gaHR0cHM6Ly9hcGMwMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZQ0KPiA+IC5rZXJuZWwub3Jn
JTJGYWxsJTJGVFlVUFIwNk1CNjIxNzM3RDE2RjY4QjVBQkQ2Q0Y1NzcyRDIyNzIlNDBUWQ0KPiBV
UFIwNk1CDQo+ID4NCj4gNjIxNy5hcGNwcmQwNi5wcm9kLm91dGxvb2suY29tJTJGJmRhdGE9MDUl
N0MwMiU3Q2h1bGlhbnFpbiU0MHZpdm8uYw0KPiBvbSUNCj4gPg0KPiA3Q2Q2OWMyYWQyZDQ2ZDQ3
MjYxODZjMDhkZDBhY2VmNTY1JTdDOTIzZTQyZGM0OGQ1NGNiZWI1ODIxYTc5N2E2NA0KPiAxMmVk
JQ0KPiA+DQo+IDdDMCU3QzAlN0M2Mzg2Nzg2MDYyMjM2ODAwNzglN0NVbmtub3duJTdDVFdGcGJH
WnNiM2Q4ZXlKRmJYQg0KPiAwZVUxaGNHa2lPDQo+ID4NCj4gblJ5ZFdVc0lsWWlPaUl3TGpBdU1E
QXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWYNCj4gUSUNCj4g
Pg0KPiAzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9TWhGWWJxcmpVQnlxJTJGbnI0YlNZeVQ0T3lY
ZmNjQ1JSb2ENCj4gYzY2em5nMUc1SQ0KPiA+ICUzRCZyZXNlcnZlZD0wDQo+ID4NCj4gPiAgZHJp
dmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgfCA5ICsrKysrKy0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQo+ID4g
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KPiA+IGluZGV4IDBhOGMw
NWIyNzQ2Yi4uNTNkOWZjNDFhY2M1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdl
dC9mdW5jdGlvbi91X3NlcmlhbC5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0
aW9uL3Vfc2VyaWFsLmMNCj4gPiBAQCAtNTc5LDkgKzU3OSwxMiBAQCBzdGF0aWMgaW50IGdzX3N0
YXJ0X2lvKHN0cnVjdCBnc19wb3J0ICpwb3J0KQ0KPiA+ICAJCSAqIHdlIGRpZG4ndCBpbiBnc19z
dGFydF90eCgpICovDQo+ID4gIAkJdHR5X3dha2V1cChwb3J0LT5wb3J0LnR0eSk7DQo+ID4gIAl9
IGVsc2Ugew0KPiA+IC0JCWdzX2ZyZWVfcmVxdWVzdHMoZXAsIGhlYWQsICZwb3J0LT5yZWFkX2Fs
bG9jYXRlZCk7DQo+ID4gLQkJZ3NfZnJlZV9yZXF1ZXN0cyhwb3J0LT5wb3J0X3VzYi0+aW4sICZw
b3J0LT53cml0ZV9wb29sLA0KPiA+IC0JCQkmcG9ydC0+d3JpdGVfYWxsb2NhdGVkKTsNCj4gPiAr
CQkvKiBGcmVlIHJlcXMgb25seSBpZiB3ZSBhcmUgc3RpbGwgY29ubmVjdGVkICovDQo+ID4gKwkJ
aWYgKHBvcnQtPnBvcnRfdXNiKSB7DQo+ID4gKwkJCWdzX2ZyZWVfcmVxdWVzdHMoZXAsIGhlYWQs
ICZwb3J0LT5yZWFkX2FsbG9jYXRlZCk7DQo+ID4gKwkJCWdzX2ZyZWVfcmVxdWVzdHMocG9ydC0+
cG9ydF91c2ItPmluLCAmcG9ydC0NCj4gPndyaXRlX3Bvb2wsDQo+ID4gKwkJCQkmcG9ydC0+d3Jp
dGVfYWxsb2NhdGVkKTsNCj4gWW91IGNhbiBhbHNvIG1lbnRpb24gaW4gY29tbWl0IHRleHQgdGhh
dCBza2lwIGZyZWVpbmcgcmVxcyBpZiBwb3J0X3VzYiBpcyBudWxsLA0KPiBzaW5jZSBpdCB3aWxs
IGJlIGRvbmUgYnkgZ3Nlcl9kaXNjb25uZWN0LiAgTWF5YmUgeW91IGNhbiB3YWl0IGZvciBvdGhl
cg0KPiBwZW9wbGUgdG8gcmV2aWV3IGJlZm9yZSBzZW5kaW5nIG5leHQgdmVyc2lvbi4NCg0KT0ss
IEknbGwgd2FpdCBmb3Igb3RoZXIgcGVvcGxlJ3MgcmV2aWV3IGNvbW1lbnRzIGFuZCBzZW5kIGEg
bmV3IHZlcnNpb24gbGF0ZXIuDQoNCj4gPiArCQl9DQo+ID4gIAkJc3RhdHVzID0gLUVJTzsNCj4g
PiAgCX0NCj4gPg0KDQpUaGFua3MNCg==

