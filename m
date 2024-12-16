Return-Path: <linux-kernel+bounces-447326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483089F308D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A46C163373
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6340204C3A;
	Mon, 16 Dec 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IUeZ3Jnh"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011065.outbound.protection.outlook.com [52.101.129.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060A204588;
	Mon, 16 Dec 2024 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352314; cv=fail; b=EHoTxoRafrXTU3eoxz3W8LNGGc2kvOa2dz49WpgR/vNAMdyd5+5XO7bApPsPEu5ivSPX2w4cbXR1ErdGYsFPeOi3B2yvIsZnbfuj0D4zWD5g/cFJWPGVNvgdXYQin44E4vfroTgTc6LmiScj7QfjBEUwAFJtG3YWqRjnsbHPtYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352314; c=relaxed/simple;
	bh=vFoeEY74IzkqecGcOTdfJpWMtRTe/i7DsMiW5ZXMlUk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UWfnwikxCK3Odmy0YaDSNfxRvUVJ2nn5hpY1EeNgH1JoFOJKLA+V1TG7WDWFgKnroWP4Co0ahtOIh3USXa65p6wADGfojLo636/SkZyjSKwmCJu9vkJWORWehs3r+pfzlH3nkR8WVQ6mQUisiSyyHry1kPTXbgceeTZZCFM7bXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IUeZ3Jnh; arc=fail smtp.client-ip=52.101.129.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5doyofEaUHoe8RTrVdgXmpjyUKMWxaMzySNran/51bao7dxI12pKPtMJn+umxu8HRZG790pSKhskT5ysNtjatioZGBNY76eDL0kFvwPB4uGnsi6BCK2Sd3AGDctiMHPRJg2lelqD0nK1NOfn0rylwcNleMGZpOnjoI9c7RjNBsoypdsITdZxnnYDl203TyTV8PW16yvZstgqwba85RUYaOXJAX9/elJ6bl9aflRfYmKPF4RRFHMMRDCoT+0QFGbnRfDLwf0EuM9FjVS7cnuLQ07W1XEwBRZie3lk3HQC4qad6Dmd/qKJVuYSfSGJFEy71E/tVHyTScXzXMPtzunRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFoeEY74IzkqecGcOTdfJpWMtRTe/i7DsMiW5ZXMlUk=;
 b=LCFYV5itrO489rypbPMeybdotGwvTT46UmRVuoCRiKj+HJyQe+OC7ol705LZgGSO4NdxZh+2r3jp4GrKo+FN66341AlLWRaInJtlYI0oGYNUeZloE+6GV94hXF4uLbNL4Yadu0C2hRmv1UNzftW8mWBvwhZpNb9c8KYuWd5/SaTsG2CM8IelN8Ts3+7GonEKXaMKFAOcCSoxHQuiPklpLOW4MlLVjzmfquHlJ/fgD9M2lwwZxbFF/v9pTKHWNXSKmppMXM1QLyXmrnv6vBpmEmY6K+jEpNmaVH6qXn1eXjULBJ3fD0R0WI+BBuouCJPYn7OL2lPEa+hu9Gjg0AgsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFoeEY74IzkqecGcOTdfJpWMtRTe/i7DsMiW5ZXMlUk=;
 b=IUeZ3JnhOEotpa2FIYdZoDMNVWkG2z0bwafu+SeQwJYxkAy0xv1vhS7XQfgfTsh4cUlrVm2NMvRo54wosyIsvTt+V+ggY5nKXRd5hxZ5+trzF2PPHvcHdvGqUokO6EA7zj8O8DI236wfG7o+NZGpw5BmgQpndECsYOc2/Ih7DZQwP9KVsduG0R7j2beeejTdKEjpNk834L4dR1UYi8xOYav+VtZu/Ryt/1VHKCPQ70/YL9wWwpld4z1mPRlmRt+4iBXJ6ndWbtADZIllNySDr6KY5Ht0oXS+WtUdZMNp3cftNXHzOeeKZ6cYg+h/RPzPfkuC8OY7cGvhzwtTIlw/aQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SG2PR06MB5406.apcprd06.prod.outlook.com (2603:1096:4:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.8; Mon, 16 Dec
 2024 12:31:46 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%6]) with mapi id 15.20.8272.005; Mon, 16 Dec 2024
 12:31:45 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Prashanth K
	<quic_prashk@quicinc.com>, "mwalle@kernel.org" <mwalle@kernel.org>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>, opensource.kernel
	<opensource.kernel@vivo.com>
Subject: [PATCH v2] usb: gadget: u_serial: Disable ep before setting port to
 null to fix the crash caused by port being null
Thread-Topic: [PATCH v2] usb: gadget: u_serial: Disable ep before setting port
 to null to fix the crash caused by port being null
Thread-Index: AdtPtYeiqzUBNnqHShOjibIiJOIUEQ==
Date: Mon, 16 Dec 2024 12:31:45 +0000
Message-ID:
 <TYUPR06MB6217DAA095A9863D4B58D57CD23B2@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SG2PR06MB5406:EE_
x-ms-office365-filtering-correlation-id: af6796de-cf31-4055-bbf8-08dd1dcd9a51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ckQwamlpUVBHaG12RHJZakEzdGVta1UxZWhvQXlvd2NGSkdQMkxFeEFya2Y3?=
 =?gb2312?B?YmhmNUVDc0E0eXB2R2RWSDhNR3VCRU5FQmQ1VUNkMDNTc3c5OW1oL25MTXUz?=
 =?gb2312?B?eUpJSlZ5WmRHb2pDaUFYbnZuUHdyaW1rVk83djFDelVUVk5qaFRnVXdIYXRm?=
 =?gb2312?B?R1I1ZmtEUE1PcnFTRVIxVTFFcVJBbWprQnR3NG1yd1dWSjZWOVJtZ2ZmZWY1?=
 =?gb2312?B?WTU1dHo3YS9tcTVqVnpYYTQ5RkxPL2tPbHF6YjB2T005MTByWmI3QUdJenI3?=
 =?gb2312?B?ODBkQkMwQkVoeGxBWk1OU2lpRWFmZldqemlqRDZJdGpzTHRiVTNGRzJrRzF1?=
 =?gb2312?B?emM5cVdpMlNxVGp6bit2UitrVis5OG9JdG9GNnFEcUpUdDQ4NWlIOGZHR1dj?=
 =?gb2312?B?a3lDMmtHbjhId3hhQzhhUnhrMjJ6eEhYSnlrbWNodDUzMGFIN1hoOFVpZEpa?=
 =?gb2312?B?RGlFQXQ1bHpBL3ZIUmlkb3VUMUxXZ2ZoZDI1OWZaTXNlemRiejNFSzFTTVlq?=
 =?gb2312?B?Z0k0bi8vZjN1TWROdjRlQjRzb2Z5NjFZWEF4QWNYNWdxTFhwQlhSMzZYQVhE?=
 =?gb2312?B?ZVc0L2Z4TVNkV2trcGlIMEw4RXZ4OUpGQ2o0QlRURnRYc2xhMTZLekhWSW1a?=
 =?gb2312?B?QXh0OU1JQUpsblNITlBjREFIbktxUndLTjRLNURmWFNobzZCdHlTVXlIOTdi?=
 =?gb2312?B?WGZLdnJmODRjcDlVbVI0UkV2cGxTUHUzREVrRTBIL05DWWRJR0xxaTZOK1N0?=
 =?gb2312?B?UlhHQ2ZnWkVvOXNRSHlyQUUveWRJd1BUQ3Y3RWh5dWYrdk5xb29YYXVSU2VZ?=
 =?gb2312?B?SU5EK1ZpakRZZ1M2cUlLaFY2MXhLVmZvZTV4QmxUanlBckZSWWhxQkpNdURy?=
 =?gb2312?B?dXlyT2xaY1B3UDV0MVVsSXA0UVhTVWtIaWcwWHhJdVpSMVpjK2VLaGlKYlJU?=
 =?gb2312?B?dzAyUmxlMGRFMXRnOVYzcU5oYUVHRGROS1BTMC9zM1oyK2plMU9Ra0pScm1x?=
 =?gb2312?B?Z3ZEYVY2djJWUlAzdWg3R1krNFBFKzYybXI5QktEamgrODRZcDBWVVF1NHhT?=
 =?gb2312?B?aDJXNmNpdXhNOG9xMUlJZkNWRE9SbUF1Nk5Za24wbjZwSWt5Tk4wTFFVeVZv?=
 =?gb2312?B?eURmKzE0bi8vRXJHZWc0YWZzbVNtall6blNNelYyUFU4a3I2bVY4aFNpRGFI?=
 =?gb2312?B?M3dmczg2K3AvcWJsb2VEbFlna0lsVDkyb2U2SjlOOTVyaFFnNTdhaE1HdURa?=
 =?gb2312?B?eGljWmM1RWFRQUJ6cHBnTzl5SG5vTlpGZFlna0tRTnIvTUtiOEpmYnhjbGU0?=
 =?gb2312?B?bWJqb3gvOFZCazhPekFVYk5xeEorazkzZ3NrN1AvajNkaHZLMy9mcDVQQnFN?=
 =?gb2312?B?RkFsSzZwU2JYaFhIMVU2ZVVLaUVqell0cG8vSDJ0Ymdpdlp1QjVMaUFHeExS?=
 =?gb2312?B?SERnejZadm5oY3daRjUvMU9Rb1V5YjhQVUFrSlVJa1dkc0xLLytub09pYUhH?=
 =?gb2312?B?U0RncDhyaXk3SE5wU3VPNUNnOFhibEs1b1VTdUlRdXJxRUQrclYzcFFVMXBG?=
 =?gb2312?B?N01hMWlseXpwcEl1Z1MyVEJ5V1JSWkcrcFlqbXA4U2ZDUFVzbXFTRVdldGg1?=
 =?gb2312?B?TmZNVVJIKzNIUHZRR3d0UjYvSHNmbkNkY3NJbHBNT1YzZVZxcTl1Q25iSzJh?=
 =?gb2312?B?RW1vTllDNFdaVnRRRFA1Nm9uK29OVEUrZHZRL3prSjd4cUJhVExYc1k4cDl3?=
 =?gb2312?B?bUVsTlFzMkdPd09vQzRtcDlNSytCcm9LZFRFSHFZdkNPem1KRjEycGh1a294?=
 =?gb2312?B?aHBVZHpVVkJ1VUswa2lDb3NOdWF2TWg5UTltNGtmbW4vRW9BREZSYXpENmc4?=
 =?gb2312?B?VzRkSXlLc2ptbDRDZ0ZZbXZ1NXdUYnN0WFBDOHVtTVZ5cTZKcmhlRHNmdHdn?=
 =?gb2312?Q?eEAZSWRCwI4nO4afckQIEJJMiGpCJV2J?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aVB6VUF3K1lBV0hSVk54eDJLaXQ5MHpLditVbnI4QmdST1p1anBkOFJQNDgw?=
 =?gb2312?B?dmg4SXNsNFhxNHkxbHp0VlhYS1VPeVEwWnFXakhGcjJFUzB3emExZnRIalpQ?=
 =?gb2312?B?b2t0YWxjMjJ5RGxRSFJFakcxNEgwQm4yUFptTjl4NE1lZG9GTVNmSHhSRFQz?=
 =?gb2312?B?SkJCVDdEREcvMFV5elFYVHRpdThsU0psWVczbjRPSEVnTEpOTk4xWFlGSm1n?=
 =?gb2312?B?TUh6RWdwdURqL1JYd1JvS3NTNWZFbE5qWllkazBOTUFNS2xuMVhteWlsZU15?=
 =?gb2312?B?SThHYTVLZWZZUndxZ0pHK0pmbXZHUVhnc2FPVE83cjlUNUc0OXh0NXNXRHdi?=
 =?gb2312?B?cmttUU8zNEJBeEYvSGw3QTNISnNuZ0lMcjBrbTAwN1NHRGRRSXM4NTV2Nzg4?=
 =?gb2312?B?SnhGdXhnYTdKVXZHOHFzWlNqMzdpQ0NGclZ0ZFZlTVJHek9zWUdCWUYydUFi?=
 =?gb2312?B?ZFJTbEZaMGZXK3BSbEZsdmZmT0dwd1g5eU5Ca2p5ZGhvcFNtRmRGQW5TL3BM?=
 =?gb2312?B?S3RUUlU2N1I5dkdlK0J4NDJlV3ZuVmx4SzFWQTdWQktFOTBsYXNHWjdsUFB1?=
 =?gb2312?B?cW9lc3ZLT0o1ckNlYVpUL2Z4aWlQQWxKTEdEWUk2OHVRQm5vbjZibWF3cE01?=
 =?gb2312?B?bDdGaTZJcmt5VGNHMm9kNFJkZW5obFdOcmFoZld6MExmblVMMTZITDRCUjV6?=
 =?gb2312?B?akZuSmdBZDA5SGRJZXkyNlFlb2FqWFBDZWNlTDhjZzc5K2ZPMHBObExqS1pS?=
 =?gb2312?B?S25yZ2M4STJTTFRKN2gwVEhGdU5DcDlmK1hWM0gxT0xFUE1zOWFKWlR4eVBm?=
 =?gb2312?B?V3NTeXF3Z3BMaW5JSUxRUlhIWitiR2NqT3puN0dZKzM3eE9uT2pFdFBoME4w?=
 =?gb2312?B?aXB0MEZqRWNEZThmeTJRUWJKd3Jib1psbGRLZDZDZXVUSXRCSU1YM1k3RmFE?=
 =?gb2312?B?N0QyaTZDQ1d2SHgxWkFpZHRXMC9DYTdOd2lWZmQ0L2N3TWxTYXdrVS9Lc2pL?=
 =?gb2312?B?RkZlWnRLaFNmNFQwbUFaRVNIY09JdkRCQnBqSHZCbE9ob24xUHNaVGlsYURy?=
 =?gb2312?B?eXJxTFVZdit3Tk82VTlHbWprcHUyQWxrNi9LYW1FOG9lKzdlYVFMdnV2WUpU?=
 =?gb2312?B?dEVHbkRDTnkyNVlkWFQ3aTY0UkM2MnZVZ21yejZwL3g3Y092Rkk4cWVpbE9E?=
 =?gb2312?B?dGN0MndONkNKN1lQbVptWjh1SUR6dzBsbFpPZUg5cUROblVTc3FxeXJsV296?=
 =?gb2312?B?Q2wva3VxOVlaUTdKcmVVT0JkYTNldnFyV3JrZGl6VlQvY2FpRWZTQzhnbGoz?=
 =?gb2312?B?SWpWUFlFd3pMTEdIRTVkeEYwNWIxd0FZSzl3alRSU29nb2w3cHBSOVBqRDJM?=
 =?gb2312?B?ZDh3MU1wbmt0VmlCRzFzU1JQaDJDZ2d5bldXbXVudVM2K09GdmNHNFdzQWVR?=
 =?gb2312?B?K1cyQlRDdW9xdGxGWXpQVGhwRnJLOGRuMVpOcXZrT1hHTXFLMnFlMHh2dTly?=
 =?gb2312?B?WnJCb0tFU280NVlkdzVWUEZoeTd5RlBHcGxtOVRKcG95d3FpeTU1aXN4YjdY?=
 =?gb2312?B?cENwOEIzd0VjSS9pT2R4YlRhV3d3S3o0K0pqZnlZekVRWXQrOXB0cWxHMHRo?=
 =?gb2312?B?NWZlVXJyS2JYQlNKUHgzSDEyMko2QW5hQzFkTE8wZERyZjFaNWVkZXoyc1BD?=
 =?gb2312?B?VmY2NWh4djRGUVBkNGpMeVEzY29oYno5UFhZb1dyRUs2YXZlQWw3cVBmY0wx?=
 =?gb2312?B?OHlnU3pubGFra3hmbU9TQW9vTVBEdDI5aFY3YTF2WUZxallzZENXcGFHR3NE?=
 =?gb2312?B?MkRqOUZQZEJVWUVQYWVNWC9kN2FDYTVmcUdETllPdFo2TkZOWjlLTTlMZjN2?=
 =?gb2312?B?OTJvQ0FhWUdYVHN1MEFoalJUQSsxRG9laFBLLzZ4N21MOVZRelJCMnNGYUMz?=
 =?gb2312?B?RUszMG9wUk9tZVV3dGRPQ0xnSGQ2NjBwb2RxQTlzQTYzNk5sOGRBbytqT0tl?=
 =?gb2312?B?VVc3TXNvY296OVBFbnVwdG1yK21Fc3dsclBMOG1hUTRHT2cwSEUrMEZkdXky?=
 =?gb2312?B?dWNmRFBmbm9rZ3NtdGxuNkxYdFpLRDZmQUUvWndCazc5dGFYQXNSWnJlcjdN?=
 =?gb2312?Q?85HA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: af6796de-cf31-4055-bbf8-08dd1dcd9a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 12:31:45.0611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1FRNR+xtQTn8+bLF59fZpRNFV1xynd6lRjXMls+m7bo8NlSFgh9yHrUbNCFxTP+CIpjipAKGBXBxd41FBq4kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5406

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpDb25zaWRlcmluZyB0aGF0
IGluIHNvbWUgZXh0cmVtZSBjYXNlcywgd2hlbiBwZXJmb3JtaW5nIHRoZQ0KdW5iaW5kaW5nIG9w
ZXJhdGlvbiwgZ3NlcmlhbF9kaXNjb25uZWN0IGhhcyBjbGVhcmVkIGdzZXItPmlvcG9ydCwNCndo
aWNoIHRyaWdnZXJzIGdhZGdldCByZWNvbmZpZ3VyYXRpb24sIGFuZCB0aGVuIGNhbGxzIGdzX3Jl
YWRfY29tcGxldGUsDQpyZXN1bHRpbmcgaW4gYWNjZXNzIHRvIGEgbnVsbCBwb2ludGVyLiBUaGVy
ZWZvcmUsIGVwIGlzIGRpc2FibGVkIGJlZm9yZQ0KZ3NlcmlhbF9kaXNjb25uZWN0IHNldHMgcG9y
dCB0byBudWxsIHRvIHByZXZlbnQgdGhpcyBmcm9tIGhhcHBlbmluZy4NCg0KQ2FsbCB0cmFjZToN
CiBnc19yZWFkX2NvbXBsZXRlKzB4NTgvMHgyNDANCiB1c2JfZ2FkZ2V0X2dpdmViYWNrX3JlcXVl
c3QrMHg0MC8weDE2MA0KIGR3YzNfcmVtb3ZlX3JlcXVlc3RzKzB4MTcwLzB4NDg0DQogZHdjM19l
cDBfb3V0X3N0YXJ0KzB4YjAvMHgxZDQNCiBfX2R3YzNfZ2FkZ2V0X3N0YXJ0KzB4MjVjLzB4NzIw
DQoga3JldHByb2JlX3RyYW1wb2xpbmUuY2ZpX2p0KzB4MC8weDgNCiBrcmV0cHJvYmVfdHJhbXBv
bGluZS5jZmlfanQrMHgwLzB4OA0KIHVkY19iaW5kX3RvX2RyaXZlcisweDFkOC8weDMwMA0KIHVz
Yl9nYWRnZXRfcHJvYmVfZHJpdmVyKzB4YTgvMHgxZGMNCiBnYWRnZXRfZGV2X2Rlc2NfVURDX3N0
b3JlKzB4MTNjLzB4MTg4DQogY29uZmlnZnNfd3JpdGVfaXRlcisweDE2MC8weDFmNA0KIHZmc193
cml0ZSsweDJkMC8weDQwYw0KIGtzeXNfd3JpdGUrMHg3Yy8weGYwDQogX19hcm02NF9zeXNfd3Jp
dGUrMHgyMC8weDMwDQogaW52b2tlX3N5c2NhbGwrMHg2MC8weDE1MA0KIGVsMF9zdmNfY29tbW9u
KzB4OGMvMHhmOA0KIGRvX2VsMF9zdmMrMHgyOC8weGEwDQogZWwwX3N2YysweDI0LzB4ODQNCg0K
Rml4ZXM6IGMxZGNhNTYyYmU4YSAoInVzYiBnYWRnZXQ6IHNwbGl0IG91dCBzZXJpYWwgY29yZSIp
DQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KDQpTdWdnZXN0ZWQtYnk6IEdyZWcgS3JvYWgt
SGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBMaWFu
cWluIEh1IDxodWxpYW5xaW5Adml2by5jb20+DQoNCnYyOg0KIC0gUmVtb3ZlIHNvbWUgYWRkcmVz
cyBpbmZvcm1hdGlvbiBmcm9tIHBhdGNoIGRlc2NyaXB0aW9ucw0KIC0gTGluayB0byB2MTogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1RZVVBSMDZNQjYyMTc2M0FCODE1OTg5MTYxRjQwMzNB
RkQyNzYyQFRZVVBSMDZNQjYyMTcuYXBjcHJkMDYucHJvZC5vdXRsb29rLmNvbS8NCiAtIExpbmsg
dG8gc3VnZ2VzdGlvbnM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9UWVVQUjA2TUI2MjE3
REUyODAxMkZGRUM1RTgwOERENjREMjk2MkBUWVVQUjA2TUI2MjE3LmFwY3ByZDA2LnByb2Qub3V0
bG9vay5jb20vDQoNCiBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyB8IDgg
KysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMg
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KaW5kZXggNTNkOWZjNDFh
Y2M1Li5iYzE0M2E4NmMyZGQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vdV9zZXJpYWwuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFs
LmMNCkBAIC0xNDIwLDYgKzE0MjAsMTAgQEAgdm9pZCBnc2VyaWFsX2Rpc2Nvbm5lY3Qoc3RydWN0
IGdzZXJpYWwgKmdzZXIpDQogCS8qIFJFVklTSVQgYXMgYWJvdmU6IGhvdyBiZXN0IHRvIHRyYWNr
IHRoaXM/ICovDQogCXBvcnQtPnBvcnRfbGluZV9jb2RpbmcgPSBnc2VyLT5wb3J0X2xpbmVfY29k
aW5nOw0KIA0KKwkvKiBkaXNhYmxlIGVuZHBvaW50cywgYWJvcnRpbmcgZG93biBhbnkgYWN0aXZl
IEkvTyAqLw0KKwl1c2JfZXBfZGlzYWJsZShnc2VyLT5vdXQpOw0KKwl1c2JfZXBfZGlzYWJsZShn
c2VyLT5pbik7DQorDQogCXBvcnQtPnBvcnRfdXNiID0gTlVMTDsNCiAJZ3Nlci0+aW9wb3J0ID0g
TlVMTDsNCiAJaWYgKHBvcnQtPnBvcnQuY291bnQgPiAwKSB7DQpAQCAtMTQzMSwxMCArMTQzNSw2
IEBAIHZvaWQgZ3NlcmlhbF9kaXNjb25uZWN0KHN0cnVjdCBnc2VyaWFsICpnc2VyKQ0KIAlzcGlu
X3VubG9jaygmcG9ydC0+cG9ydF9sb2NrKTsNCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2Vy
aWFsX3BvcnRfbG9jaywgZmxhZ3MpOw0KIA0KLQkvKiBkaXNhYmxlIGVuZHBvaW50cywgYWJvcnRp
bmcgZG93biBhbnkgYWN0aXZlIEkvTyAqLw0KLQl1c2JfZXBfZGlzYWJsZShnc2VyLT5vdXQpOw0K
LQl1c2JfZXBfZGlzYWJsZShnc2VyLT5pbik7DQotDQogCS8qIGZpbmFsbHksIGZyZWUgYW55IHVu
dXNlZC91bnVzYWJsZSBJL08gYnVmZmVycyAqLw0KIAlzcGluX2xvY2tfaXJxc2F2ZSgmcG9ydC0+
cG9ydF9sb2NrLCBmbGFncyk7DQogCWlmIChwb3J0LT5wb3J0LmNvdW50ID09IDApDQotLSANCjIu
MzkuMA0KDQo=

