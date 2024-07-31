Return-Path: <linux-kernel+bounces-269095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520E0942D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093A2284593
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09F41AED23;
	Wed, 31 Jul 2024 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DCZMRKeE"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2060.outbound.protection.outlook.com [40.107.255.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9E1AE876;
	Wed, 31 Jul 2024 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426858; cv=fail; b=JmxNgUnCmLVTvGRMw4PFEtJP/t1TFsRAyeOK+ekNOXVws9KhxVN6fWOd71j57KXq5HO/UQBIyGgRSl8siS3Bs7B/jOycaDX0gySDGODgGKowx0UN1bEjetxdCLSys5g61LPKzmm2GQmowryuLnXBah/me4BHBncNCPvQnuHRCRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426858; c=relaxed/simple;
	bh=myEqsl+ZJrF0cXJ2pXGdB7NpofZj1KzOJ/OESo6v3+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NVyC3YowPu2MTS7DijpdW4E4nYS7VyN2pyxaSLXvK92V4GHMAiZWEDSNRBXeS8nEY/mVDJaKoM61+41CDp3YETVINFUzSCahbnh3EWi9FRLg/ic4p8p2mGQc5Khif/KV6MYyaeEw66jc6azIz6FHvp7C4odHnlUS2U1Qr7XK+UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DCZMRKeE; arc=fail smtp.client-ip=40.107.255.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AX2vyIJcRnU1hUwwxBafnXWDL+1rGrSKgWpZxs9G04cUGSPrSQ18j1mLOij4vFKqc6jruZkAiUKu+dmG68m8qGezviwMJAkTpm8L7S8sfqfJpZj2BIEkQHwieE/skWg8z9wkm8D65iaB2gKHcaUijfU1z3ZvEw+4oe9VMyMB06s4TwSgdDYZauXFjPixxaDuJZnA1sUADpdfxKkty23qilnOlGJr1YOa1jmGx2ZT0p919unjAVlhUPAXE2EIUJpehtZiQcLSdNzDmPGPeAeDnN/PHBJT02b7CUkzuVzDiNExSyb4HKjNPWvOup/1e07NlYy2Us/ruEcdYnJg9Jk2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myEqsl+ZJrF0cXJ2pXGdB7NpofZj1KzOJ/OESo6v3+k=;
 b=n1bkisP8jf2hO4nkxcC+hKYcwRx/YsE2dYcwcshYOjT4yzUodwU530sWtCa6MldRQDOGkd+724yNoRtrFCvRKQvwYNebNs4Yd/rySZ93x2/ooCT91yLSOlL5Jy8TD2vLQvwi3isRdLlxAw/d3GGGFCvCtp1SQ99SJ/jC5esjDdQ0nEZAH1BMoDrIzQVQk14VJod4iOts/gADh5cz0dcJIQBccgl36j1LHD8ZUKw8pfqs8loJv3KE4nxX+kRkmPCOCprzjD9jkb2srPXbzBiR2FJDeLRro1f7QJT0loPLp18cp+DedLE6rV/LrTwmlMmF1BIAbj9rQ2s6rKnjq60SwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myEqsl+ZJrF0cXJ2pXGdB7NpofZj1KzOJ/OESo6v3+k=;
 b=DCZMRKeEMYudJxBeZv8+gEIFWeLHxx8o+QMPN2dCfF8HxZSRSzRQqRJ1gL9XbQhEzT3PHQsdsMMp1N8s1Tor+S/pY/PK7uxACXipdaE62HjDVzAhgbEDWpsJAdGDXMDfSUu5jTR0g3FIWN72SLif0BJDkIAqn1Ex+i+9gp5TFdWtmIb9kufirGCXXUF/BzuAJaJYll2BSmKiMx11jclVJY/oYM9x4w7SSlObyaEaeChzVuimw7+52BIyvO/VYjWVvd/+cnV98jtZEwuRqrmv61AjtmU9CuU7zqOQyU0lSJIzWVl8yErqN+OVlQJujKDYM/x/8OwVc1ojJ/k/2bVktQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB5072.apcprd06.prod.outlook.com (2603:1096:101:38::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 11:54:07 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 11:54:07 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, =?utf-8?B?6IOh6L+e5Yuk?=
	<hulianqin@vivo.com>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIHVzYjogZ2FkZ2V0OiB1dmM6IEZpeGVzIHRo?=
 =?utf-8?B?ZSBhYm5vcm1hbCBlbnVtZXJhdGlvbiBwcm9ibGVtIG9mIG1vYmlsZSBwaG9u?=
 =?utf-8?Q?e_as_UVC_camera.?=
Thread-Topic: [PATCH v2] usb: gadget: uvc: Fixes the abnormal enumeration
 problem of mobile phone as UVC camera.
Thread-Index: AdrjPy5L8mvqthR7TX6KWxl0Ter/KwAAO1HQ
Date: Wed, 31 Jul 2024 11:54:07 +0000
Message-ID:
 <TYUPR06MB6217535BCA10D2DBB25919E2D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62175899DECC7A9B0DA0DF01D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
In-Reply-To:
 <TYUPR06MB62175899DECC7A9B0DA0DF01D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB5072:EE_
x-ms-office365-filtering-correlation-id: aab9e675-3a58-466a-ea27-08dcb1577b88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?akFuK1g2cVpuMVQ3RXhUNHhLM3dJclBMSXhVRmxxV3FnSjZyUjFxbUllZFNS?=
 =?utf-8?B?TzBBS3lHWVRSVHlLZ3M4QlQ4OENLL0lqV0N5RE5Id2tCajNVWCtkWm5rbmVP?=
 =?utf-8?B?N0pwY3FpQ1JjamYwcmhnQ1BJVGwxaHdrMlNCbDV2ekNDRDFTMFFKMGZJUHM2?=
 =?utf-8?B?RjBsaWxQeS9sMmI0YWRiSU1jVkRXRVNEWjY5VGg3VlppczJXR2EraU81UEhi?=
 =?utf-8?B?aFZIQjFqQ005RDBTd0NUUGQ3S2NUM0hxQk91TjRkaEcxS3hvSW9vUzJNYlRz?=
 =?utf-8?B?UGF6ZnpKNFVhREtIeEdXS2hUaS9GemhYL2ZZbnNaamlCdXAyMTNyMVhMdnFz?=
 =?utf-8?B?K3pJYnpEZDU1RWJjbnZ3VVd0T3N6SVRQb3l2c1U1WHdSbWt5cFFCRDBtYnhB?=
 =?utf-8?B?ZkpDN05iZjl6Y3EvRkx5MVlFNWNtc0tYUUdJd082UW1ucE43bG5XRkVpMGZ4?=
 =?utf-8?B?Qm5lS08rb2IxTmVVbnNFTnZ6VkZ0b3JXUEtmQVExY080UytPa05IZWF3dmJT?=
 =?utf-8?B?M0pJR3d1dFdScXBlWGYzK2pjUStNSHg5U2JERUJROTVWNkludXB1T2VDL1JE?=
 =?utf-8?B?WVUybGszTGhzVG9kd2x5ZkxLNkhtQWtMZGdUSUlvaDlyTEdWbWdTeGNHNE1q?=
 =?utf-8?B?a2VoV25tTWhsNE0yMGFIaUgvbU1jbXNucnB1VzQ1VDNOYnErNzJSdTdlRzda?=
 =?utf-8?B?YTlDNUtjcFlyT0swdjV0TERDcm1TSmgwanJLcU1TOEIyNkZSVDByWE95cFYw?=
 =?utf-8?B?N29XZStUQzJmNVRob0x0NGxGL1NDY21ZenZXSFgxdkFFTDFHSVl3SDRjSFFV?=
 =?utf-8?B?V1g4cTVYNWRna0ZKbmZOV0x2Q09RYm9JMzhQMzl2OVQ2cFh6SW51Z3M0ZlR3?=
 =?utf-8?B?eS9IWkhJbE5VSFRJWU0xektBUWhYcU9ocitnTUdjVis1aVRkQkRla0pCajhV?=
 =?utf-8?B?cnNrR0JLa045aEovTjNYdk52ZVN2cGhrMVpCanZBaWN3WVpmTUtlamw3SnFO?=
 =?utf-8?B?ZVN2TnZibUp0VVVGVlpNV1FkZ3d1aW5NYUI3TWJNb2NNRUR0ekZFamFnK01i?=
 =?utf-8?B?Sklld3BEV0tyNWV0R3E1c3kwbWFvNmwwNkNMNjRlTzB1UXkreEdMS3B4ekZH?=
 =?utf-8?B?ak9yandWNjJRT2Vlb3Z5VzVUTnRra2RqS1h1Z3dENWlzd1AzVW0wMDVIUGlP?=
 =?utf-8?B?NjloRVlObzNCVTAxR1NtMEFHWFlvWHVGUlExR09IT1RsNUlCbU1uOENaWm44?=
 =?utf-8?B?b1BCcU5Ma1RDd1dmOXdBQ2NpdU9neFhkRU1DOTdBVG16YlYrSmc2SStVKzht?=
 =?utf-8?B?UHdZSGFXRitlekE2L0RBU0M5bU40UTVEc3VUTU95ZjlEa2pGMW1NdXJrOUQv?=
 =?utf-8?B?Z0dGTkswZ25sVUpObHVmMFNQbUJ6b2hnU3VCYzQrMFVSb1A3c2padXJjK1VV?=
 =?utf-8?B?V1V6dnlIN2E2Yi94R1FmU2RaYUZxQTNsSU1oRmxoYjBvWUhDMXErcHlwWm10?=
 =?utf-8?B?dlZMbFVGZTBTS1VlNk1IamI5ZCt6dEpmRVl2WjRXVDUrWGVadTVxUlpleTdx?=
 =?utf-8?B?TmlwK1ZVK0U4emlqOHlvQmdvY3llczZLTjZ1cUc3azJJbG9TZ1RlOVcyL25R?=
 =?utf-8?B?WFArVFNGa2xXQmYyOUVwUXZRclFhbHY0bURoS0JHby92VkkzZ0xlaHNmYW5z?=
 =?utf-8?B?MTNzOTFoRHdIMVdUN1lZQ2t5R1BBbmdhSXM3K0tPcUpaUDN4ZnBTQ2tuS3lD?=
 =?utf-8?B?SkFScU5yMzB3NWF3REJ2djQwZnZnSGMvNmZsUUY5SmJMaEdpSlhYdndPYVB6?=
 =?utf-8?B?TUtvTXZCTkQvenR5NmJ1RWdWTGNXU2JaSDlVQlB6OVc3NmF2RDVMQ1J2Y2Ft?=
 =?utf-8?B?ay8rWnVoMDRqZVNBYVlkRkk0U0pjU2hSd0dNUFIwRFRWK1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3RPTm1nRjgzaFBoOWpMRnFWbmtod3R0NExoMzB1b2NGcS8xMENhem0rRUdP?=
 =?utf-8?B?L0cwdGxMVG1OcXErZEJ3c085MmJNeUJkNHdWUU12andDUHpYVTFSRmdLd2tr?=
 =?utf-8?B?Z3VXdTgyUnRuSUJpOW9GQmo1NDNCMEUzZDFVSVdYRHBZODcwVXd1VlVpY3B2?=
 =?utf-8?B?VG9NS0krZHRFVDJ5MkhNR3dnc3lIWlFaUXNBdi8zY0xVTUlHVGRmdm9wM2o5?=
 =?utf-8?B?NW1uSmdhTi92VVpGUFBrVlRwbFQycGZ3ajBVa1VRZmtTUE9UMEVTbTN3RWx2?=
 =?utf-8?B?RHVTMWJQNFl6RFloRkpiSzAxQUY0WHdGMzdtaXZOR0R0WkdtOWtsNkRRN1Ix?=
 =?utf-8?B?YmR4WElJSVFtQTZtMUFPZ3lrMnlwVkxseXhnTW9NTUMxVlRZWlcvOThCdGhy?=
 =?utf-8?B?ZjdKQzNNUlBQWVkrUXk3a0RvTmh6STBiV1FOandQK0hWd2xZbG1VbXFOTlFV?=
 =?utf-8?B?RVpSelBsMTkzT3AwKytTZExiWDhVMy9XSHVvbi9vcGJKbEN3SWtLVGw0T3hx?=
 =?utf-8?B?WU9hRG9sYkRSYnpyTEJVYm5PUmoxUE1sV1lHNUJlenFNaFFyZTg5VGxKdUtS?=
 =?utf-8?B?WXhWUXJNTTJuNm8vZnREZ2VuQU0reHJkOWNqNFBTV2RHZGt0cXVxb3lnZ0Mz?=
 =?utf-8?B?bzVLeXpjRmF5MEZseHJudEd6VTU3U0Urays0QXZtbkdpV1pHSWJQM2N3UVdu?=
 =?utf-8?B?Mm9SM0EyWENjRnUzQktuTlFaM1M1SWwxSThsQ3JPUklFRm5HWFBZaVJzNXNs?=
 =?utf-8?B?RERnSlEwbkw5bjRXQ1NVN0xzdnRuS1VwYy8wQ3RSUEI1NHdFNDZzTWxsUXA3?=
 =?utf-8?B?SlBLOE0xMllxaHRXSVlZcWxQeDZRS1MrM0JGcEhnRnhQZCtHTUpOVU1BS1Vv?=
 =?utf-8?B?OW1ibGVNS0hnRkJ4ckNSeFVQbHQ0eXcyMVlQQWJ6N2RJeXpTdExYcVErODFs?=
 =?utf-8?B?MndKS1plbGF2dlRKWmpQT013MXp1eDVvZzgwN2tQNHdhMXMwK1kyb3N0MlRM?=
 =?utf-8?B?NGx0Y3FDeGlKNjJvUVpSdlUySWZ1Tm4wU0ZORWNEZ1NzT0J3bW5qenRjQmEv?=
 =?utf-8?B?S29QUjdzTTRmVWRIdVRGTExxcG9BeHkxZVBFdzJ1ZFNBK1NEeXRsYlpYWFFn?=
 =?utf-8?B?eXFweTlYN0l4bzlqRVQySUloR091WWlhM1BmQ3VEWTNmSmZwV3FndzVzQkE3?=
 =?utf-8?B?WTN3UUFONmtCbzB3RDlJYVRhQ3c5SlpodlNUc2dSRTdrbDRzU1BONEVMVGZE?=
 =?utf-8?B?WTJmdS91eHFZU3RZLzlDUXlBeWxkdWMzMnJkYUpYakh6SW5DTHdhSVV4SUZN?=
 =?utf-8?B?T0dwSjRnelJScUZNeStUa1F3UEZmWVcxYmFRZ0NrYXFuY240bXNXQlVQQkdG?=
 =?utf-8?B?dGEvQ1lrMFUwcGtrVW9JZUhGTHN3NFFBQUl3Y2J6clZVRlRQZnU5NXRadWhW?=
 =?utf-8?B?VFVWOXZIK0xkdDNvQUFwbmdRN1JTWjNVWkJ3a0hOMDVlaDZCWitjeWpUbmFF?=
 =?utf-8?B?UUwzeU9EaWhJNG9zRmNaem1JOWw0QUtRNm5Cc1F4dEREOUoyN1JIQ0lLVzJz?=
 =?utf-8?B?RWg5cVRaV0Rld1dCNkI4cXJpUmVLMDlKU3psRGlmZVpyRFJsQVJIMVFCQ1lU?=
 =?utf-8?B?TGthR0dKUWszclF0YjFlbU5yd2dWWXp6YlZwbGd5UFY3NmdrSjZib09ZN0p5?=
 =?utf-8?B?alArZXFBejJabnBLWnE5TWJ0VXRoMVQ2ZVVhZFBpMmZBbUFYM2FiTXV5NWF3?=
 =?utf-8?B?Kzl0TjkrZURMQVFzZklIOGcrZ0dlTGhvM0JPZGthS1dHMUlKa25rZG1LMDgr?=
 =?utf-8?B?MC9aYngrcnFUVWVoMElLZlROQ1d6c1FNZnBBaDArb1JEcDErZVhaZGxwViti?=
 =?utf-8?B?MFlXczk5ZEhSS2gvMDR1R1pSaU1hdkxYRThibDFtM1J0dWFQYk1iR0RaS0V0?=
 =?utf-8?B?RTVJOTRob1BrbnFuUHdLZU9URWtiYW9kVS94M05IRFAxLzdHSFFjRW5Pb2xW?=
 =?utf-8?B?MWw3UFdKV0FYSkFDS0JsRDFWRTFFSTUrRTYrU0N5dnlvNUoxOWYxdzBISTlE?=
 =?utf-8?B?QkNqME9vK0VIaFpqTkRiVXJJS21tbFB0ZDEzRDEzdmtLdG82WUxyc01WL24z?=
 =?utf-8?Q?y+2Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aab9e675-3a58-466a-ea27-08dcb1577b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 11:54:07.2384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /u/nysP4qYaOzB7VHTXYYMq9vCspv8vOrh2Elz35OvqX7eKIpwjIOzdqCHymM3L5Dm1cVKrJ9g5QJ56H8Pu+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5072

PldoZW4gdGhlIHBob25lIGlzIGNvbm5lY3RlZCB0byB0aGUgY29tcHV0ZXIgdG8gdXNlIHRoZSB3
ZWJjYW0gZnVuY3Rpb24sDQo+dGhlIHBob25lIG5lZWRzIHRvIGJlIGVudW1lcmF0ZWQgYXMgYSB1
dmMgY2FtZXJhIGZ1bmN0aW9uLg0KPg0KPkJlY2F1c2UgdXZjLT5mdW5jLmJpbmRfZGVhY3RpdmF0
ZWQgaXMgY29uZmlndXJlZCBhcyB0cnVlIGluIHRoZSBmX3V2Yw0KPmRyaXZlciB1dmNfYWxsb2Mg
ZnVuY3Rpb24sIHRoZSB1c2JfZ2FkZ2V0X2RlYWN0aXZhdGUgZnVuY3Rpb24gaXMgY2FsbGVkDQo+
ZHVyaW5nIHRoZSBleGVjdXRpb24gb2YgdGhlIGNvbmZpZ2ZzX2NvbXBvc2l0ZV9iaW5kIGZ1bmN0
aW9uIHRvDQo+c2V0IGdhZGdldC0+ZGVhY3RpdmF0ZWQgdG8gdHJ1ZSwgd2hpY2ggaW4gdHVybiBj
YXVzZXMgdGhlDQo+dXNiX2dhZGdldF9jb25uZWN0X2xvY2tlZCBmdW5jdGlvbiB0byBmYWlsIHRv
IGNhbGwgdGhlIGNvcnJlc3BvbmRpbmcNCj5jb250cm9sbGVyIHB1bGx1cCBvcGVyYXRpb24gKHN1
Y2ggYXM6IGR3YzNfZ2FkZ2V0X3B1bGx1cCwNCj5tdHUzX2dhZGdldF9wdWxsdXApLCBhbmQgdGhl
IFVTQiBjYW5ub3QgYmUgZW51bWVyYXRlZA0KPm5vcm1hbGx5IHVuZGVyIHRoZSB1dmMgZnVuY3Rp
b24gY29tYmluYXRpb24uDQo+DQo+QWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaCwgd2UgbWVhc3Vy
ZWQgdGhhdCB1bmRlciB0aGUgdXZjIGZ1bmN0aW9uLA0KPnRoZSBkd2MzIGNvbnRyb2xsZXIgYW5k
IHRoZSBtdHUzIGNvbnRyb2xsZXIgY2FuIGJlIGVudW1lcmF0ZWQgbm9ybWFsbHksDQo+YW5kIHRo
ZSB3ZWJjYW0gZnVuY3Rpb24gaXMgbm9ybWFsLg0KPg0KPkZpeGVzIHRoaXMgYnkgcmVtb3Zpbmcg
dGhlIHNldHRpbmcgb2YgdXZjLT5mdW5jLmJpbmRfZGVhY3RpdmF0ZWQgdG8gdHJ1ZS4NCj4NCj5T
aWduZWQtb2ZmLWJ5OiBMaWFucWluIEh1IDxodWxpYW5xaW5Adml2by5jb20+DQo+LS0tDQo+djI6
DQo+ICAtIEFkZCAiRml4ZXM6IiB0YWcgb24gdGhlIGNvbW1pdA0KPiAgLSBNb2RpZnkgZGVzY3Jp
cHRpb24gaW5mb3JtYXRpb24uDQo+LS0tDQo+IGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9m
X3V2Yy5jIHwgMSAtDQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+DQo+ZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMNCj5pbmRleCA0MDE4N2I3MTEyZTcuLjZkNjNiZWExNDIx
MSAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYw0KPisr
KyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jDQo+QEAgLTExMDcsNyArMTEw
Nyw2IEBAIHN0YXRpYyBzdHJ1Y3QgdXNiX2Z1bmN0aW9uICp1dmNfYWxsb2Moc3RydWN0IHVzYl9m
dW5jdGlvbl9pbnN0YW5jZSAqZmkpDQo+ICAgICAgICAgdXZjLT5mdW5jLmRpc2FibGUgPSB1dmNf
ZnVuY3Rpb25fZGlzYWJsZTsNCj4gICAgICAgICB1dmMtPmZ1bmMuc2V0dXAgPSB1dmNfZnVuY3Rp
b25fc2V0dXA7DQo+ICAgICAgICAgdXZjLT5mdW5jLmZyZWVfZnVuYyA9IHV2Y19mcmVlOw0KPi0g
ICAgICAgdXZjLT5mdW5jLmJpbmRfZGVhY3RpdmF0ZWQgPSB0cnVlOw0KPiANCj4gICAgICAgICBy
ZXR1cm4gJnV2Yy0+ZnVuYzsNCj4gDQo+LS0NCj4yLjM5LjANCg0KLS0tLS3pgq7ku7bljp/ku7Yt
LS0tLQ0K5Y+R5Lu25Lq6OiDog6Hov57li6QgDQrlj5HpgIHml7bpl7Q6IDIwMjTlubQ35pyIMzHm
l6UgMTk6NDkNCuaUtuS7tuS6ujogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxhdXJlbnQu
cGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbTsgZGFuLnNjYWxseUBpZGVhc29uYm9hcmQuY29tOyBs
aW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrm
ioTpgIE6IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IG9wZW5zb3VyY2Uua2VybmVsIDxvcGVuc291cmNlLmtlcm5lbEB2aXZvLmNvbT4NCuS4
u+mimDog562U5aSNOiBbUEFUQ0ggdjJdIHVzYjogZ2FkZ2V0OiB1dmM6IEZpeGVzIHRoZSBhYm5v
cm1hbCBlbnVtZXJhdGlvbiBwcm9ibGVtIG9mIG1vYmlsZSBwaG9uZSBhcyBVVkMgY2FtZXJhLg0K
DQpXaGVuIHRoZSBwaG9uZSBpcyBjb25uZWN0ZWQgdG8gdGhlIGNvbXB1dGVyIHRvIHVzZSB0aGUg
d2ViY2FtIGZ1bmN0aW9uLCB0aGUgcGhvbmUgbmVlZHMgdG8gYmUgZW51bWVyYXRlZCBhcyBhIHV2
YyBjYW1lcmEgZnVuY3Rpb24uDQoNCkJlY2F1c2UgdXZjLT5mdW5jLmJpbmRfZGVhY3RpdmF0ZWQg
aXMgY29uZmlndXJlZCBhcyB0cnVlIGluIHRoZSBmX3V2YyBkcml2ZXIgdXZjX2FsbG9jIGZ1bmN0
aW9uLCB0aGUgdXNiX2dhZGdldF9kZWFjdGl2YXRlIGZ1bmN0aW9uIGlzIGNhbGxlZCBkdXJpbmcg
dGhlIGV4ZWN1dGlvbiBvZiB0aGUgY29uZmlnZnNfY29tcG9zaXRlX2JpbmQgZnVuY3Rpb24gdG8g
c2V0IGdhZGdldC0+ZGVhY3RpdmF0ZWQgdG8gdHJ1ZSwgd2hpY2ggaW4gdHVybiBjYXVzZXMgdGhl
IHVzYl9nYWRnZXRfY29ubmVjdF9sb2NrZWQgZnVuY3Rpb24gdG8gZmFpbCB0byBjYWxsIHRoZSBj
b3JyZXNwb25kaW5nIGNvbnRyb2xsZXIgcHVsbHVwIG9wZXJhdGlvbiAoc3VjaCBhczogZHdjM19n
YWRnZXRfcHVsbHVwLCBtdHUzX2dhZGdldF9wdWxsdXApLCBhbmQgdGhlIFVTQiBjYW5ub3QgYmUg
ZW51bWVyYXRlZCBub3JtYWxseSB1bmRlciB0aGUgdXZjIGZ1bmN0aW9uIGNvbWJpbmF0aW9uLg0K
DQpBZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLCB3ZSBtZWFzdXJlZCB0aGF0IHVuZGVyIHRoZSB1
dmMgZnVuY3Rpb24sIHRoZSBkd2MzIGNvbnRyb2xsZXIgYW5kIHRoZSBtdHUzIGNvbnRyb2xsZXIg
Y2FuIGJlIGVudW1lcmF0ZWQgbm9ybWFsbHksIGFuZCB0aGUgd2ViY2FtIGZ1bmN0aW9uIGlzIG5v
cm1hbC4NCg0KRml4ZXMgdGhpcyBieSByZW1vdmluZyB0aGUgc2V0dGluZyBvZiB1dmMtPmZ1bmMu
YmluZF9kZWFjdGl2YXRlZCB0byB0cnVlLg0KDQpTaWduZWQtb2ZmLWJ5OiBMaWFucWluIEh1IDxo
dWxpYW5xaW5Adml2by5jb20+DQotLS0NCnYyOg0KICAtIEFkZCAiRml4ZXM6IiB0YWcgb24gdGhl
IGNvbW1pdA0KICAtIE1vZGlmeSBkZXNjcmlwdGlvbiBpbmZvcm1hdGlvbi4NCi0tLQ0KIGRyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jIHwgMSAtDQogMSBmaWxlIGNoYW5nZWQsIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9m
X3V2Yy5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMNCmluZGV4IDQwMTg3
YjcxMTJlNy4uNmQ2M2JlYTE0MjExIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL2ZfdXZjLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5j
DQpAQCAtMTEwNyw3ICsxMTA3LDYgQEAgc3RhdGljIHN0cnVjdCB1c2JfZnVuY3Rpb24gKnV2Y19h
bGxvYyhzdHJ1Y3QgdXNiX2Z1bmN0aW9uX2luc3RhbmNlICpmaSkNCiAJdXZjLT5mdW5jLmRpc2Fi
bGUgPSB1dmNfZnVuY3Rpb25fZGlzYWJsZTsNCiAJdXZjLT5mdW5jLnNldHVwID0gdXZjX2Z1bmN0
aW9uX3NldHVwOw0KIAl1dmMtPmZ1bmMuZnJlZV9mdW5jID0gdXZjX2ZyZWU7DQotCXV2Yy0+ZnVu
Yy5iaW5kX2RlYWN0aXZhdGVkID0gdHJ1ZTsNCiANCiAJcmV0dXJuICZ1dmMtPmZ1bmM7DQogDQot
LQ0KMi4zOS4wDQoNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZyA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IA0K5Y+R6YCB
5pe26Ze0OiAyMDI05bm0N+aciDMx5pelIDE5OjEzDQrmlLbku7bkuro6IOiDoei/nuWLpCA8aHVs
aWFucWluQHZpdm8uY29tPg0K5oqE6YCBOiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBvcGVuc291cmNlLmtlcm5lbCA8b3BlbnNvdXJjZS5r
ZXJuZWxAdml2by5jb20+DQrkuLvpopg6IFJlOiBbUEFUQ0ggdjFdIHVzYjogZ2FkZ2V0OiB1dmM6
IEZpeGVkIHRoZSBhYm5vcm1hbCBlbnVtZXJhdGlvbiBwcm9ibGVtIG9mIG1vYmlsZSBwaG9uZSBh
cyBVVkMgY2FtZXJhLg0KDQpPbiBXZWQsIEp1bCAzMSwgMjAyNCBhdCAwODo0NTozMUFNICswMDAw
LCDog6Hov57li6Qgd3JvdGU6DQo+IFdoZW4gdGhlIHBob25lIGlzIGNvbm5lY3RlZCB0byB0aGUg
Y29tcHV0ZXIgdG8gdXNlIHRoZSB3ZWJjYW0gDQo+IGZ1bmN0aW9uLCB0aGUgcGhvbmUgbmVlZHMg
dG8gYmUgZW51bWVyYXRlZCBhcyBhIHV2YyBjYW1lcmEgZnVuY3Rpb24uDQoNCjxzbmlwPg0KDQpO
b3RlLCB3aHkgYXJlbid0IHlvdSB1c2luZyBzY3JpcHRzL2dldF9tYWludGFpbmVyLnBsIHRvIGZp
bmQgdGhlIHByb3BlciBtYWlsaW5nIGxpc3QgYW5kIGRldmVsb3BlcnMgZm9yIHRoaXMgY2hhbmdl
PyAgUGxlYXNlIGRvIHNvLg0KDQp0aGFua3MsDQoNCmdyZWcgay1oDQo=

