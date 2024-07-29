Return-Path: <linux-kernel+bounces-265535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DC093F288
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1441E1C21CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E6E143C53;
	Mon, 29 Jul 2024 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Q7n562fj";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LspDYTYI"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62574055
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248655; cv=fail; b=proO+lBT4393WLat0cAV33mteVGOFSvq1aR+wZLr/EupyPTZmOgr1/GfvXSrxbqhh0gG08wJXapBBRJxo+WNDXMNYR1WS+6q5RAuQHgepXokde5W6piLiSebU1QaqYk0C6HsVRFH9mKVVpR+PHvAS/hMqiDwQR7tER8NDrxUwe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248655; c=relaxed/simple;
	bh=aatS7rpwUhI1AzQEe1+1adSXE+crUs0WcA4k9KhocjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NbufTmGzvmRueOViuv43ZqiSY6EmtS8xliA3z2hFoVtmyd2dsOz2mZK4zJVc07wqvqkLjo7D8KC/+eiTo33TlqvvlPj5OR2eFY5F+z5B0ekEfnZiw15TKWPnK/PT7xD5lBKfqH4n/ya/81EFHDC2499BKvu7qC8v3XKlRiYk5EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Q7n562fj; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LspDYTYI; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722248653; x=1753784653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aatS7rpwUhI1AzQEe1+1adSXE+crUs0WcA4k9KhocjA=;
  b=Q7n562fjPvDgogcKZlkga+y+hp2gruXaPnv5+ObWXGltcoDSQJmh9X0t
   YSQ7RCcSYR5yKfuyJmdhPRNdCV6wENSjyTn2vYcw5p5b1Us28ir9ZVp8/
   oiBhe9ZIxt4tK8TmZduAgAPpMEXVIzw/DsbjUpDSsj6xWGMHJz8Dn8hix
   2EcKsnayzNhI9XO0+0e3IXUzRtISGfpQHSpIAfQYmAxKeXrm6eKGpj6cv
   uF2gCxcrZp/PxP8U6zPuJwKQLYtWRPxfgNqnjnHO3G70lZi/E/SbLX5p7
   +idjY840sH475cSUQkf/am5SNrpyy0l6HaIf7zBwDZpzCKnI9dCRlU7gh
   g==;
X-CSE-ConnectionGUID: wDnFQLFeTiae37w7GX9hEA==
X-CSE-MsgGUID: DuF6LSIyQM2J3IS2cA8OEg==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="29773851"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 03:24:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 03:24:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 03:24:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jogRvBlN0gCTm5jv60YQ4g0M2ctxqvpV+KObL+14nFtvcZlTxYNvKcZ3uH07VX05vJVbN0bgLtWtXpUOPOoI6n5F+g6+R7Gyx6ETmiAutVlDrmwq/TWGCiWkXSi0ipLo9tuxeTYSkcfr8PcF87zXdjTUiLCm87Fiia5vYCxrg/eJDIXrnLd1T1CB6cu4gVOIQ77H0om01J3CfL8kBuJLySdiSec4tu+7w3IcIVaWLYnaA5O08Mjyl8VFeABcZDGr/+mVN4CvrxsPNsPgBGw+vHJBvhMHfVzOgu/oD1SUILv+/VDBjTSfRJq6bONuPqUKOwxMhKVNI3X18reRkbsmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aatS7rpwUhI1AzQEe1+1adSXE+crUs0WcA4k9KhocjA=;
 b=ufs/ODMsgZyKQOfNNQk2MKbVqJMiZ6JAv6TZqevNb1ygeyy330cYPYA9jPsHSc52yj35tgrZL7l6dDBEpGAfj28khuq1fTSmuKWGLzcFnE7Kl6kTyMLTKF+9yaIRguliJBgpeu5soayt4j0JwLYmnHt1WxBYDnwfT/SJ4BPXxlvQ33EJ2yOfblOPG9maRa2ec6nlgSa/o9Zc2nv2PIqbvwFcFxR+kZ8YbhRctbIQ4cb5ZKut9QMtrL8ytz/nLN1y2EaEA20KJkC18Kf2ktssVoXzMs9Y+G9s4+3Y0Y3kRb3DlHaU/Ckz8qECIVZFMJYGhoctjmxpGD5P/tUekiKotw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aatS7rpwUhI1AzQEe1+1adSXE+crUs0WcA4k9KhocjA=;
 b=LspDYTYICbtpv5mSOAOukHtEm3zqdknjvLbnkBPOd1/42OgV9QzEHZgNY/nXPhUSPPweckVUXNUKj/T2ecvcDe0K4l/G/j5aHoynPhIgs4LjdMaASb3SpfCBUusX8Vd0f+XnDptEpzS26A6Eh8+5LUwrQoY7CDHWWddM4IdNPjQcObsQAetVpBLlJ6c0GreMBob3f3+S9crlBX2dt9byN8pUhC4NWDHIqIYmvbO1zzwHLN9Zs3/MdlEXktgPTb8ZQcOLW9+xxSOx2D4o46r/zORJSE8A8Tn6LD+jPamAwiabBKXbxkIfIZUIiUTdmeXhwqHf9SLcvsAsTTd7TqRNyQ==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by CY8PR11MB7875.namprd11.prod.outlook.com (2603:10b6:930:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.25; Mon, 29 Jul
 2024 10:24:08 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 10:24:08 +0000
From: <Varshini.Rajendran@microchip.com>
To: <tglx@linutronix.de>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <Hari.PrasathGE@microchip.com>
Subject: Re: [PATCH v6 17/27] irqchip/atmel-aic5: Add support for sam9x7 aic
Thread-Topic: [PATCH v6 17/27] irqchip/atmel-aic5: Add support for sam9x7 aic
Thread-Index: AQHa4YYlLOmbIGCRQ0esMwTHOBYGi7INfdOAgAACA4A=
Date: Mon, 29 Jul 2024 10:24:08 +0000
Message-ID: <b6f21567-d2d1-4b2c-8d8d-6c4a04d81e0d@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
 <20240729070829.1991064-1-varshini.rajendran@microchip.com>
 <87o76g8puw.ffs@tglx>
In-Reply-To: <87o76g8puw.ffs@tglx>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|CY8PR11MB7875:EE_
x-ms-office365-filtering-correlation-id: 2d4af630-156f-4e1b-d4fa-08dcafb894aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WEUyNEpVcE1sOC8xY0dMYXY0bTBkLzRuVzQ2TVE1bklmd2Z4dVl1djI2ampE?=
 =?utf-8?B?MGlSdGVUWW5PVUdmb2lEMnhDejltWjV5RlBlMDFkMEJlV25GbCsxMFB2SG9J?=
 =?utf-8?B?QXNJYUphN1FwTmcxVExnUzRmc25pS0pDNHE0ckR5RWxpUW1aQVowcWg5N3Z3?=
 =?utf-8?B?UjdQazNRZDBaemphZXBZTDBRNjQzOXJSSWs2N0d5V2kweDFCK3NuWGk1UERU?=
 =?utf-8?B?eG54WHB6bWhCcXErYW51UjdWQUlHSHVDYUdFVjVnRHQ3VENXdElXNVFBcWZM?=
 =?utf-8?B?bWI5VHFQTFR0aEZPdDRRcSsyb2JhZG9VeGZpL3hqdlNKdnJIN2RlVmt2L2lZ?=
 =?utf-8?B?Qk1ERkp6Q2oxbTltVk5jS0g1ZTRGZVMwZDVmb0F2ZkgwTlBuZTNVaCtOYWRr?=
 =?utf-8?B?c1ZzVGlML0pYZEQ0V3YvZnRFdlQ1cFVUeTB5cllTMHgyTENSSHNTMVNQalZO?=
 =?utf-8?B?QXNGK0RZRWNKd2N3NUtQQ0xoTm81anY4bnFtcWp0c1NNS2lXQWJrN2dIOTBH?=
 =?utf-8?B?eEUrREc1SERjRjMyaEwvVEJQb24wSEJFdS96ZEtGWk80alpkRDZuUlpxTDR2?=
 =?utf-8?B?Mm9BRWwxdml5b2x4dGZaWEZic2VqRXJJZjdjYUtOSWtSRmxKZWl3a1V0TFBD?=
 =?utf-8?B?cThjQ2Z5OEFYL0R1TE5jcWpieWxiek56cmM0VkxMRDFXTUVLdXBoQ0VMcVdr?=
 =?utf-8?B?NFZJc1A5OGRPNFpGOGluVEpqUFRsalJVcm9KTXdKamNhOHoyWWNqQ3FmR0Rj?=
 =?utf-8?B?TUVmaUt5cGpnMVh2RU54QnZBbFRiTnAwdVM3ankrcjhuLzJQUldocFZGVXkx?=
 =?utf-8?B?SE5jZ3ZENlFvT1hscEtUUUxUc3lWNEJQcTZSb2NDbGFYN3dhUkRNdTZQdTNE?=
 =?utf-8?B?TVdjSGxnSk0xeDNiYXdWRXBRRDF1dDhvS01FRnpJMXB2MUNsRnNIT0lpWk10?=
 =?utf-8?B?YWMxWm9ZSUhodzRlc1N4WmdDeTZiTE9PcVBmWDNFYlNiR0c1Wk9UWDk0c3pN?=
 =?utf-8?B?YTdMWmJGd2ZzL3Z6ZHdpWVBjV21iNDJiQmFWcEQxZmtES3QzTlZPd0F4U3lo?=
 =?utf-8?B?eFM3bitjc3BqUWlnRWhmWWlIWXQ3NUJESEluZ2huMExkcWdhNGZlc3RiZk1F?=
 =?utf-8?B?ZUJQelhiR0hwOGk4UFNVUDRBZTRqTXZpcno5bytGdit6VG4rTXBtc1VENkdn?=
 =?utf-8?B?WjZsQnhRSTFZKzhWd1hmdW9MaFpXanRTaXJUU2tRTCt5eDdOV2o0RUVGNGo0?=
 =?utf-8?B?bWMyUnRkS3QrUURYSzdSeE1kaXdMam8yZlIya01sYWFKcWN1SU5ic0psZjAy?=
 =?utf-8?B?MHYzdXFGRG15Rk5XbDNyUUxxWjBIc1VHWkMzakEzc1dXYkJrSGFrNU5QV0pZ?=
 =?utf-8?B?eWlUUTF2UXlpUWVNMTFqVCtSN0o0U2k4UG1Nd1ZreXNVYXY0d2JlTTdrNk9r?=
 =?utf-8?B?UEt3dFBMT1NWMXlnWjdsNVVPcktYbHVUYnFGR1V6aU5lNXFLM1dRTDhueVNw?=
 =?utf-8?B?enQ5cnhYNGdQRExOTkVQWk9wNFpYcm9Jb3BYRWRzUWx0VUEwTjlVSGl0bFlo?=
 =?utf-8?B?QkwxeG0rd1RxK1l4MHJEZk5yZU9HeUdMOGRTQnBncWdSOUNhc3k3TnlHV1R1?=
 =?utf-8?B?aC9NWE1QMUhjckpaaVMxbENPVUpleTZvTkVHVzhwZ3RlbmZYZVRIN1JRL2o4?=
 =?utf-8?B?L01EY0xsOWZpVndUSVMwS1JMbmdUMythVzA4SnBuMStsSUxaNVZhUnFlTXVG?=
 =?utf-8?B?VVhkeXZ0Q05objJXQWZJNllRenkvVlpqMkNZWDhYWVRIK1l2YnZyY2dVejRw?=
 =?utf-8?B?RFpaVGVQWDhLQ1o5MkJNWWVIQzFjMkJWVndPMTNma0FJTG1pZVJ0MHdud1Jz?=
 =?utf-8?B?Z216Z3ZxKzgvcFYrR0VFaERFNVE2T3RrSEdjblREZVZrK3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWdLOTNYK1BDRk1WUDdpb0FwMFlCRklrb1BPWW1taWtFUTFVOE9hMnF6MEtz?=
 =?utf-8?B?RGRaVlhKV01MRlozWmVBRUtRZ0dCUkxMMitpQUJwNzBIMXBWSWFieVQ5RlZQ?=
 =?utf-8?B?enBCN2toQXZONGpsMDVwcFpTMFlnOVBYZ0E2SUJhNFEwSkVkTUZJSHEzV2xS?=
 =?utf-8?B?SDVDL1JKOUZHSjFQaCtsRHh2c2tkenJveFZuaVF3Uy9Va3JVWTRsS3NXdFRD?=
 =?utf-8?B?S1FtWXI2bE1BRnBlam9xR1QrZndNbTNRTGx4RU1iYm9rYmdjR1NzanM2aTFP?=
 =?utf-8?B?RUhhWEViblFpcXRPRWJsUEpvM0dpSzBRTkdvdis5TS9YYWEzR08xWUxWSE5a?=
 =?utf-8?B?VG5kM3JFem16Rm9vWEZwRXRydVY0L1Y0cVloOTdpYzlPeDhlVmxqRzFMcnFU?=
 =?utf-8?B?ZjBodUdDTVh1WTVxMzhFdzZiZ3Q1aldLU2lhS2FHOEhGR2tZMFovSlRGSlQx?=
 =?utf-8?B?OER3ME53Y2FSZkV5T1ArVmdDaE1telg5WVR0dmVJNGVGUTdxL3FKRGJ6NHBp?=
 =?utf-8?B?eC9uMDB0b0xsaVRTWk5NMERXZnBsQXRReEp5NStjWCtpLzFodVk4MUo0bEVR?=
 =?utf-8?B?ZjVvbUhDQnk1ZlhiTUxEYnN3ZmVyT0RMVG80OUVNRm5wL0lEOWd0Ny95M2ND?=
 =?utf-8?B?TDA2TFpZNUhZcXpOQiszdU9jSU5KWFlHWjNnOHlyZWhNYzBURi9ITVlLMjBH?=
 =?utf-8?B?K0RGZVB1aWswakRNUlhUN0kwQWx0MHpIZzZzMmhyakpPbkNDdVZPQW9UbnN3?=
 =?utf-8?B?Z1pMVW52allNU3hUUm9WRTY3Z0JuL1JpaFVuRUgrdkhtcThNQ014L2NyQlNl?=
 =?utf-8?B?NFV1eG5yZzRsemtFR0tJOHlMTWZkdkRYVjR4QUpFUGFvQzFrYmtlRFZKWC90?=
 =?utf-8?B?eHUzc0xvS1NLSkExaklnVWdkNU1PWTlzaVdWYlhIVHUvOUV4UDFsKzBRM3dr?=
 =?utf-8?B?aEJvM1VNSG5ManJ3YURPNmpYOWh1TW1HdnFBTmgrY0gvVlE2bUszREdWcGJp?=
 =?utf-8?B?TG1zeEZwRHdZT0RuWEdEb3hHK0xtY09MVGtBWjlZb3R5ZWhJdEEwK2dqN0xm?=
 =?utf-8?B?eHZOclI3Y2p5eGZIcEt2azJkc3hVaU05TENscGl5WjVJKzBURjhTSVJXWG96?=
 =?utf-8?B?YTFDc0ptNTQwV1o1Q0NIMHdiWE8yNFVCSEJOakdUT3ZaSkptc3pNbmxGMFFT?=
 =?utf-8?B?Z0Z5dXlWWERVTnBjMEM2V0t4WEQwTFZvR3FJZFV0U1kzUlNqeGQ4NVZtUDgz?=
 =?utf-8?B?Tk54TlZ1Mm9RbUtNRjhMamhCeGJDZE90NXlzZFRqZmdURVJSdW5Sa0s5M0Mw?=
 =?utf-8?B?dHhTOEw2Y3U2cUFmVlRlOGVJVTlEeDI2NXBqaDVUUjhaaTVYc3F1bkpFNHhX?=
 =?utf-8?B?U0lMTldFOEJlcUdwdFZxMGVqeE45TXJTNng5bWpDUFpDK1NSbE1TWDJ6MnZU?=
 =?utf-8?B?VEdXTHk2TzVrTUxLTXVmZysvQmNibFE4SFBTcE1JS1ZSUG9UdVB0VHRUMTd2?=
 =?utf-8?B?NTJmM3dtTlBhV0krekEraEJJYmJUc2tnc2FmMTFFODBIaEhiUWVXZEVxOExB?=
 =?utf-8?B?QWo3NFZkbHhobTBwQVhzUmVTL3Q2M3FSc2VycTBIUHlMWlhIakR6SUZJcTN6?=
 =?utf-8?B?REx3LzYzeGhkUWs4Zm9mdjBpYW5IM1NrQlZMSGUvVDM4bmUyMEVkcGY2Ny94?=
 =?utf-8?B?eU1CMnlZL3o5a2pXQUVuMTJtWjdoK0hReU41bUdZRVgrZWxQbmtBOVMxUjNE?=
 =?utf-8?B?R1N0SEVaKzVUVThIODRZaFV1OUE0S202eXNMTTFZZzYyWE1sZjVmNUlJbDRk?=
 =?utf-8?B?dUhSTkQrRUEvUCtUTStlYmU2WVpIU2VZaFY3cit2dDNocHQ0cEo2Q1ZBRCtE?=
 =?utf-8?B?ZllXeDVDNmY5QW4vTWk4L3czWUREMUl4UGVra1NPd1c2dzcreTViQU9FenFH?=
 =?utf-8?B?N1hoeW5UMm1HRmUwWHpjekQ4c0lLTTFVNEllMDNDeTMxUXZCcjlqU3FINGxJ?=
 =?utf-8?B?VXVES2hUeExLaGo4QmtyQSt6bnJMdElISzJneTU3ZktoZTVxM3pFL1Eza2dK?=
 =?utf-8?B?QVhUSFVoTExMQ3R1N1AzNzlvWlQ5Y3g3c1pQZ0VuUEd1MFc3bkREdGVBaGlN?=
 =?utf-8?B?cEFTYXFXZzBEWVhFblpFY1FBKzU0aE9YOVVNNjRJd2VlN0xOY0dRaGxoSVph?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE2E68770338A84FAE2DCBFA3640342A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4af630-156f-4e1b-d4fa-08dcafb894aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 10:24:08.2286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xWW6dSSge/Ev6c4Ne1oqXfyTBzmXc6k1nlLGiEByyLIzw4MkH+GfvFWczD8y17TIiHSbLcDsrLkvDLb3pHhdJRnQ0UwqhJuDbOv/tShrzsC2a5Bf1BUxcoHAqNiOm50o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7875

SGkgVGhvbWFzLA0KDQpPbiAyOS8wNy8yNCAzOjQ2IHBtLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCBKdWwg
MjkgMjAyNCBhdCAxMjozOCwgVmFyc2hpbmkgUmFqZW5kcmFuIHdyb3RlOg0KPj4gKw0KPj4gKyNk
ZWZpbmUgTlJfU0FNOVg3X0lSUVMgICAgICAgICAgICAgICA3MA0KPj4gKw0KPj4gK3N0YXRpYyBp
bnQgX19pbml0IHNhbTl4N19haWM1X29mX2luaXQoc3RydWN0IGRldmljZV9ub2RlICpub2RlLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRldmljZV9ub2Rl
ICpwYXJlbnQpDQo+IA0KPiBQbGVhc2UgZ2V0IHJpZCBvZiB0aGUgcG9pbnRsZXNzIGxpbmUgYnJl
YWsuDQo+IA0KDQpJcyBpdCBva2F5IGlmIHRoZSBsaW5lIGV4Y2VlZHMgODAgY2hhcnMgdGhlbiA/
DQoNCj4gVGhhbmtzLA0KPiANCj4gICAgICAgICAgdGdseA0KDQotLSANClRoYW5rcyBhbmQgUmVn
YXJkcywNClZhcnNoaW5pIFJhamVuZHJhbi4NCg0K

