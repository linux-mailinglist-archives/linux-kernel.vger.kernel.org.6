Return-Path: <linux-kernel+bounces-399228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC069BFC55
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939811C20A57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03343168BD;
	Thu,  7 Nov 2024 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pWFA4cBV"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7E16419;
	Thu,  7 Nov 2024 02:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945244; cv=fail; b=eiOuTl7c+ztKqng9/zmPs9MZwZD6JmXqTX17BOjK8m2Ztl9xL18jf0e4meYbwLYlQLFJD4gDDaF+Y8rQVm5ij6x+yBUVA5n7PdGaS3UvSMGCabPpzc/LmBrqHg1g9zyJJeBhm2iEthAZX03HgKCmjKiwcbsE23+CM1LknTJK0Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945244; c=relaxed/simple;
	bh=q2Jy6mLXiPczWDwIfUP4E+sq/Jd9xsOnMinBgp4U8Og=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HAbMHSlxO98EPwtlcNu90JBtI9OyL4jCPI3MuAQSJwtaG7iGSPavBBOwW9uXpyqUZ4ZoiCqttlRJaCw9b74OoXdgMk+SQwy+DNZWDKbTXCfJAAG+JVevNlnoTpyv+SXGVpiV2KBN4i+L1A6D6yQN7NdwaasoNmDzX5mePMea8g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pWFA4cBV; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6N29hk031608;
	Wed, 6 Nov 2024 21:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=q2Jy6
	mLXiPczWDwIfUP4E+sq/Jd9xsOnMinBgp4U8Og=; b=pWFA4cBVNYpIMNHr6JPIg
	drghqYek1owDWpFPKQ238MYbkPvdPSCf5teg68wBSwUDe8X0u6veULSGbhpVMLKR
	FGd/BVcd0N5RLSiSzY4kgj1KK+YEDS03wH7dXLm1EB132XsLYhxAnCYWAwdIk22h
	dVG0e2pZTxSbvmh2UZiAbCHdUpWR3/2Q0os6IHTlW6+sB7tfwK5Uq4cXyrd41eok
	kIgYN29Tb5bOVCNShPXfeBgctQIbwC8iSOfzIRRbQg0Her7lBPJLpsLHpw1GTw1y
	91MmiEVLmc7VBls+nSsdqb98ScNyuJF/xfUgIk7hrLoKpOxN2hgxiT9/UiHlX1/O
	Q==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011027.outbound.protection.outlook.com [40.93.12.27])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42rhsb0nnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 21:06:50 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyrcpU/RC4NzbjfPSEXJwSiunlXWHp24QcT6/i+o16D+NeTNbtF7EvFn8asrikD2wfO/BzxB95to44lV8BeWGG0dXTWAuBrIp/adrd5E1U3BIPxXGrR7IEk/cDPltUChJIS03R+6ETOV/8EGIOZBlhRvuckGgckFlPf6r/SyjisCB2fTcvxg05adv5MdX+Jc9Y1CVn3nLrEzRnFD0iARL47Kc6Q8LjJW2/u8Hee/bUX45fLw7PDeHsddkZ4lcn34iVYhMP0fs8sZ9bHi+/NQebzG+yDweeMF7UqIvS9kdNJt9ICXeNyBLK+9R69ZpUXNYcFHMq9pbX+Xgkd4n4TWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2Jy6mLXiPczWDwIfUP4E+sq/Jd9xsOnMinBgp4U8Og=;
 b=evxjXrBtfX5JxyLNqBDhWi198O9SOxbAiwcq8GPLTtLITMy+Hy3kerQV+SLr5OLt9q+EbrxFwuJjZleroSivQBjmTCVcVfzxWAN8kOlwEjEvWN/tjC9NTCQjJu5RSVM+h1tDkG6KroDBAfmIK1wuN7oQyLubWv7xZjp9HcGZr34BFSF74dOcR/zSX9lZN/IPAMZWJg4b8wNEVk7JKCap8E3TchwJrfKU6t1W0HWDV2qia7OQkblKaPLtKFmXTeYaQymX0ak9XHm575zXeUuE0xHCgGcz33DhScTtWfPrUTY32Kab371SUsqdL3Z0wZUM+fSDOfwQT0xU+Ay8yRo5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by BN9PR03MB6154.namprd03.prod.outlook.com (2603:10b6:408:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 02:06:47 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354%3]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 02:06:46 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "Sabau, Radu
 bogdan" <Radu.Sabau@analog.com>,
        Jean Delvare <jdelvare@suse.com>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
Thread-Topic: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
Thread-Index: AQHbMCrJ4Y9sFgRAo02CKADXnFeaqrKqHK0AgABLmQCAAKoFMA==
Date: Thu, 7 Nov 2024 02:06:46 +0000
Message-ID:
 <PH0PR03MB6351CDD33902BBBEE58A126DF15C2@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
 <20241106090311.17536-3-alexisczezar.torreno@analog.com>
 <ZytSCD0dViGp-l2b@smile.fi.intel.com>
 <55825e91-b111-4689-bb3e-ede2c241728d@roeck-us.net>
In-Reply-To: <55825e91-b111-4689-bb3e-ede2c241728d@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|BN9PR03MB6154:EE_
x-ms-office365-filtering-correlation-id: 318017b7-f8ea-4faf-8ed5-08dcfed0d583
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmQ0S1M4MUtwMkMxYzFHd2hlRUhEVHU3WVZsK0xhcVFYYy8vQzhYWGdmZ0Js?=
 =?utf-8?B?OTBEVDMwUUdDUzIwczA1WE1FbHZISElRYXorbTQwRjcwVm5qRWdZQkpHVTRN?=
 =?utf-8?B?OFlvVkJENCszbVdodWhFMUlZVFcyWk9HLzNxQ2ZoUW56Y3RXd1ZTQnBtLzRQ?=
 =?utf-8?B?THRKNUd1RHRrVzdjWHJUbzZsdWZKak84ckV6ZGYxbVkrSHlBZHlqUTJuVnJm?=
 =?utf-8?B?QXUyVWVjbDVlVkNhNTdDdnE5aExhQ2lJZ1BRVWRUZDRlWE5FN3UrR20yVFlE?=
 =?utf-8?B?OGVOUktwcTF6TnJma283NW5lbklhNTBRd241MG5Ic2NlOVNDczBIRjJIcnp4?=
 =?utf-8?B?WFJ2Umo3WE1xSDRYRXBaWE54KzBrRW9OQXNDcFdSbkpNbXAwNVZjZFMvdkIz?=
 =?utf-8?B?Q3pnSE5OSzFHdWhKcEVlUDI0ZFlndXU0bjVqcGJDcmpXemJlUzhqR0NiR2JY?=
 =?utf-8?B?S21vMGViclFsaEFpVUxYREFTajhMdmZFaklhbW9WcHZGWnpIcXpCT2xuVkt3?=
 =?utf-8?B?azZWaEpOZDBXbWl2Ny82VjY5YlVqZDBKZytxK3JVRzlLOW1SK0lNRXBhMkhK?=
 =?utf-8?B?TGZ0ZnVXNWZJdXJMejU1NXJ3Q3JrSFhTaUdZOHkyN2M1UU1mTmNSZjJpc2R3?=
 =?utf-8?B?Y3YwZDhqc1Y4NE1KQjFUTXRrNFV1SDRleUZ3Z1NaN24zWm9rQ1lnYkRvajF6?=
 =?utf-8?B?T3NrVWZqY1ZvQ21PNWZFeFJDUmZEMXF4eWpWMEE0VThiUitJTGZZc3hKRHlM?=
 =?utf-8?B?dit4cmtsOTYzNVVrSjBIYW1WbFRzdmpWTGdyejd3N3o1WUFZTlNtY3ZYU1Fl?=
 =?utf-8?B?VDJwSHUzNHhIL1E0YnM1VDR6RG9Zbklqbmw3SHpTWXgyNllNWUMvNjBnYlJx?=
 =?utf-8?B?MS9aVEwwSXFxbnNKamRkdUtwRWd6Z1pUcXRiUzlmMndLWTZncENUV0FaTVZN?=
 =?utf-8?B?cEJYSlUxbU1YNTF0NnBVTUtaVWJUekoweHZ2R3hrSVN4dXRJcXg3UGwyYlZp?=
 =?utf-8?B?SXRUOVhNRGxqVUxnQXg5NXQ2THBmdC9MZC9ESWxCRFJZeEM5S3JWcjdpL2Ex?=
 =?utf-8?B?VHhXUHd1MU1GQWd2Vk1zRkNlQ0VsMmx4S0VBSnBwTVNXSzR2TmJJdFIxQ3pu?=
 =?utf-8?B?WXdQSVdWR2xwdURuWGl0Vklrb251WlFqS1ZRLzdzNE1tK3lGU05aRFJaRkhZ?=
 =?utf-8?B?L3JKdEdDUStYWm5aWnNvYUNOeDhuZ0N5WUFLdVovQlh3UC83V3ZnOElmZ1li?=
 =?utf-8?B?VmlJL212QTUzbnlncUJ4MDI4ZkFTeXlsTFJMYVJxeFlFa2doRzR4KzdiNXYv?=
 =?utf-8?B?ZkZHZFI2U2p0ZDR4VWFCVmp5RFpYMi9DVkN3UmNvYzJyaWY4OXVuSnNjd0hj?=
 =?utf-8?B?NkZaVGpod3hqeVErREM3SitwdFcwdmFFRU5rSDJTV2tSTDhyRktEVXdVbm5H?=
 =?utf-8?B?NnVKM2tZMjVKbEt0STVoNmlZaUVDa0JkMnVhWnBnai9HbUU4TGtOZmJvNW1q?=
 =?utf-8?B?QnhGNWpSVVlSbUtSSnFKMnREMEpyUytkTkQxNHVoclV4dWRPOFVJaEFMRkUx?=
 =?utf-8?B?S2F1cWJiTUNrbmRjZWF2OTVwNDcxUUlQYTlmcVlBUFI1TjdZbTg5aEtWbzNO?=
 =?utf-8?B?eGt5bUR1aHVEQnBRWUhobHZFaTlKL0pZblFLTk5MYXN2WWpPYlV4R1NSZ1Ni?=
 =?utf-8?B?WHVrWk9wZWdleXVNejJac1VZWGxzNkhiZVhIWDNuUG5hdEkyTzhZaENFZlZ6?=
 =?utf-8?B?K05KTXMyZXBCRnpLTldaNGd3QVFjRUhYT3hDRmlGeW11TzBTbC9YSXFWTmNn?=
 =?utf-8?Q?Pjp66fwWT9sfyffE0DWdQ33uLWP6kdpfXce8g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0RCK0dIUWEwUUY0OTF2bGJsUFBQdDNyczBJajBHMld0c3d4UEhBcXZXRjFG?=
 =?utf-8?B?Nk5BamNnZzlXb1huZ05mdGNxT2N1eVk2V0M2RFBHV1ZiUzhSLzFwUW5XTVRx?=
 =?utf-8?B?WjVmMVVQazBIN2xLb3ZlTGx4ZlphZFN2VzYxV2graHJRTUVwMHpMdENqZEVK?=
 =?utf-8?B?Rjhub3VQeVV0YU5paStWd1h2a0htMnZIZ3I4THQ4VTJNRGJoQzJNdmpiTDB2?=
 =?utf-8?B?RWQ2SlZNemU1djVlaHlhSlJTMTlkR2UwbVRTaFBwdmxXMVMwejF4K0xJTnFP?=
 =?utf-8?B?a2FMK0syQzhxOVo1UGNXY09MeERzc1BSVCtSYmhxZXF6NGwxWHl6bW1VQXRm?=
 =?utf-8?B?N0FoUGIrSXp1V0orL1ZTeUZmZUJlL2J2K3MyZk96emlmS0hsMFNHdlBVYTY1?=
 =?utf-8?B?MGdRZWxNYWZMazAwRGlMYzcwcWRHK25mTWdNWTFyYi9zcGlHZTgrZVI0OVhB?=
 =?utf-8?B?a1ZJZCsrdkU2dC9Bd3FYOW5ldWM3NFQrZHBhNkJqNUtLbEJWSHRnb25qOExa?=
 =?utf-8?B?a1Fva0ZIM3l0MWkreFVMMmErVEdYTkdHZ1ByVHMzZTZXaTBmVjhvYng3MGg2?=
 =?utf-8?B?YkpielJPSFcrVSs1TitzWmpVQ0tSVUVCbE1hd0lZeTluSjBUVWRvVmdNNWtB?=
 =?utf-8?B?YWQvRFJQZllJZTVBVWdpZnhKS3FMWG5odUgxRW9xVWZpeGtDNk5idlNmc2pM?=
 =?utf-8?B?b2pweUp2Z05BbzZ1cmUrdTFDR3BuR09BN1dKWlBicERXc2lnZDBxTGJkdE41?=
 =?utf-8?B?UnBseENOcVQzNU4xclkrNjN1QlUxbFpxUVNEZDBRU3N5eCtMWXRObVBoWXVk?=
 =?utf-8?B?bzBhMzhTSFBxQTVKcEd2bE1hK2NnY0llbWVJbTV4eS94MlM3akUrNzd6ZTBU?=
 =?utf-8?B?KzhORkEwbTNIaUpUMTVwNEZvZkc4N0FEclFUMGxoaDFIK1dENFNvTG5pZTAx?=
 =?utf-8?B?b2R6bVhhKzlYSGtUTkNaQlR4WjA3U1paYURDTEh6Y3NqeHVSVEF3UkpBYlo1?=
 =?utf-8?B?TGpmQTRFaE84cjVYSCt0YmIrVE9sOEpVT0QrVFNxS3RQK0RDU0Z1Wkk1VGt5?=
 =?utf-8?B?WlFyQTdqTkRMTW1xVERuaHBiZXMvb1Y3bDZ4NVdvR1QyUjVibVIxdSszZnI2?=
 =?utf-8?B?cC80WklYdjJBMVlwQWlYNDlNWFhNL3A0bEVKUHRobU52RmlHamNvd3NNeDRZ?=
 =?utf-8?B?aWRlN2pURnF5OHkyR1RHNVljbC9vM3FiS2hIN1c0K0toUkFBY1BMQzUrS2V2?=
 =?utf-8?B?YmNZM1JXemoxOHFIWXpSdHZaSTg4Q1BlaWtlZzFlR3l1Z0Q4WVgvYUxQU3Fp?=
 =?utf-8?B?MVhyekJWNks5QWNCRmJxYjdCL3lNTTZvZnVDaG5YRVlPUzZLMVFNUFVhNE4w?=
 =?utf-8?B?bDVqM1YrNXo4VHNJeDJ6WU0rSHRwb0tVWTlQeEpwTDJkVEhJMWd0MkZFV3J2?=
 =?utf-8?B?cmZkN2FHRWdsaTdVK25MeTYxL0Iyb0d2K1ZlZDJQNnRPczBCVVZkbUU1djh6?=
 =?utf-8?B?ZWpvOTltZWIxRXhTV2RsVFlVb0VCVWlmdkJuZFcvbjJ2dTRxd3U2T3Z6UHg3?=
 =?utf-8?B?QkxUZm43MzgxRjJMZHpnOVB5VXJGZnlJM3hPbzNBQnkxaXZkZ003d2JyQnk5?=
 =?utf-8?B?WC9FWEw1NW9RZGdSQkZ1QWZwR3BwQTZqNHI3cGYrcDVlb1BZdHJiTlpINTNC?=
 =?utf-8?B?anBxUzRxWXZRVGM2TFNsaDFQNEdXdXZwNGZWN0NqK2RWZEszZmxiSURYN2Rv?=
 =?utf-8?B?aitMYkdSNXJDNzgvRndPYloxcWpVSENQQmlyb2xwV0VraU1ydlE4TmtKT1RH?=
 =?utf-8?B?L1pLZ1NDNHJselpjZlhxejNKdVRXOXVZajYzWkxHWkhLZzdTcGw2UWlLNk9T?=
 =?utf-8?B?Q1I0bDlwTTBHNzdPQlJBMHJQMXZzcDliQ1J1eWpVcW1DeDV6Q2lleG5qemM5?=
 =?utf-8?B?VkVIcWNkOW92QkxlTitHMnZyTVhzZHBOS05pdVFxUzZpZkp4VmxJaTg0R2ly?=
 =?utf-8?B?NkNtYzNkZlpOVXNxZmRlcW1vOW9oZUpmeVpKM0g3Q2N4SGFBVDg1cUc2VDlT?=
 =?utf-8?B?U2gxRFUzeWl6ODlIUlBrcEl0S0l2OU5lOFdpbDVCR0REbWdsZjB4cnYvbzYz?=
 =?utf-8?B?c1djTGJVbnMyOU9IbGZpbU91SElKUnBNVnJraFZ2TnZHYm9nTVl5RmFpaDFi?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318017b7-f8ea-4faf-8ed5-08dcfed0d583
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 02:06:46.8362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6u728C1jJ0/gM7z6aSDo6/99unQemgYZYobxzmqtSN9SAr3D7CE5de9GjClg7Zevil5ENnViL9/99n11eqFDFzUv5GZbCAowqtyMsB/m9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6154
X-Proofpoint-GUID: R5DZ-TZx3R4FKkff_JGIDKZKdjiXq7xO
X-Proofpoint-ORIG-GUID: R5DZ-TZx3R4FKkff_JGIDKZKdjiXq7xO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070014

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayA8
Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6IFdl
ZG5lc2RheSwgTm92ZW1iZXIgNiwgMjAyNCAxMTo1NiBQTQ0KPiBUbzogQW5keSBTaGV2Y2hlbmtv
IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+OyBUb3JyZW5vLCBBbGV4aXMNCj4g
Q3plemFyIDxBbGV4aXNDemV6YXIuVG9ycmVub0BhbmFsb2cuY29tPg0KPiBDYzogbGludXgtZG9j
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZzsgU2FiYXUs
IFJhZHUNCj4gYm9nZGFuIDxSYWR1LlNhYmF1QGFuYWxvZy5jb20+OyBKZWFuIERlbHZhcmUgPGpk
ZWx2YXJlQHN1c2UuY29tPjsgUm9iDQo+IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlz
enRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yDQo+IERvb2xleSA8Y29u
b3IrZHRAa2VybmVsLm9yZz47IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+OyBVd2UN
Cj4gS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDIvMl0gaHdtb246IChwbWJ1cy9hZHAxMDUwKTogU3VwcG9ydCBhZHAx
MDUxIGFuZA0KPiBhZHAxMDU1DQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiAxMS82LzI0IDAz
OjI0LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gT24gV2VkLCBOb3YgMDYsIDIwMjQgYXQg
MDU6MDM6MTFQTSArMDgwMCwgQWxleGlzIENlemFyIFRvcnJlbm8gd3JvdGU6DQo+ID4+IEFEUDEw
NTE6IDYgUFdNIGZvciBJL08gVm9sdGFnZSwgSS9PIEN1cnJlbnQsIFRlbXBlcmF0dXJlDQo+ID4+
IEFEUDEwNTU6IDYgUFdNIGZvciBJL08gVm9sdGFnZSwgSS9PIEN1cnJlbnQsIFBvd2VyLCBUZW1w
ZXJhdHVyZQ0KPiA+DQo+ID4gTWlzc2luZyBibGFuayBsaW5lIGFuZCBwZXJoYXBzIHlvdSBjYW4g
YWRkIERhdGFzaGVldDogdGFnKHMpIGZvciB0aGVzZSBIVz8NCj4gPiAoc2VlIGBnaXQgbG9nIC0t
bm8tbWVyZ2VzIC0tZ3JlcCBEYXRhc2hlZXQ6YCBmb3IgdGhlIGV4YW1wbGUpDQo+ID4NCj4gDQo+
IElzIHRoYXQgYW4gb2ZmaWNpYWwgdGFnID8gRnJhbmtseSwgaWYgc28sIEkgdGhpbmsgaXQgaXMg
cXVpdGUgdXNlbGVzcyBpbiB0aGUgcGF0Y2gNCj4gZGVzY3JpcHRpb24gYmVjYXVzZSBkYXRhc2hl
ZXQgbG9jYXRpb25zIGtlZXAgY2hhbmdpbmcuDQo+IEkgdGhpbmsgaXQgaXMgbXVjaCBiZXR0ZXIg
dG8gcHJvdmlkZSBhIGxpbmsgaW4gdGhlIGRyaXZlciBkb2N1bWVudGF0aW9uLg0KPiANCj4gPj4g
U2lnbmVkLW9mZi1ieTogQWxleGlzIENlemFyIFRvcnJlbm8gPGFsZXhpc2N6ZXphci50b3JyZW5v
QGFuYWxvZy5jb20+DQo+ID4NCj4gPiAuLi4NCj4gPg0KPiA+PiAtLS0gYS9kcml2ZXJzL2h3bW9u
L3BtYnVzL2FkcDEwNTAuYw0KPiA+PiArKysgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL2FkcDEwNTAu
Yw0KPiA+PiBAQCAtNiw4ICs2LDggQEANCj4gPj4gICAgKi8NCj4gPj4gICAjaW5jbHVkZSA8bGlu
dXgvYml0cy5oPg0KPiA+PiAgICNpbmNsdWRlIDxsaW51eC9pMmMuaD4NCj4gPj4gLSNpbmNsdWRl
IDxsaW51eC9tb2RfZGV2aWNldGFibGUuaD4NCj4gPj4gICAjaW5jbHVkZSA8bGludXgvbW9kdWxl
Lmg+DQo+ID4+ICsjaW5jbHVkZSA8bGludXgvbW9kX2RldmljZXRhYmxlLmg+DQo+ID4+DQo+ID4+
ICAgI2luY2x1ZGUgInBtYnVzLmgiDQo+ID4NCj4gPiBTdHJheSBjaGFuZ2UuIFRoaXMgcHVyZSBk
ZXBlbmRzIG9uIHRoZSB5b3VyIGBsb2NhbGVgIHNldHRpbmdzLg0KPiA+IFRoZSBvcmlnaW5hbCBv
bmUgc2VlbXMgdXNpbmcgZW5fVVMuVVRGLTggYW5kIGl0J3MgcGVyZmVjdGx5IGZpbmUuDQo+ID4N
Cj4gDQo+IEFncmVlZC4NCg0KV2lsbCByZXZlcnQsIEkgc3VycHJpc2luZ2x5IGRvbid0IHJlbWVt
YmVyIHRvdWNoaW5nIHRoaXMuDQpUaGFua3MhDQoNCj4gDQo+ID4gLi4uDQo+ID4NCj4gPj4gK3N0
YXRpYyBzdHJ1Y3QgcG1idXNfZHJpdmVyX2luZm8gYWRwMTA1MV9pbmZvID0gew0KPiA+PiArCS5w
YWdlcyA9IDEsDQo+ID4+ICsJLmZvcm1hdFtQU0NfVk9MVEFHRV9JTl0gPSBsaW5lYXIsDQo+ID4+
ICsJLmZvcm1hdFtQU0NfVk9MVEFHRV9PVVRdID0gbGluZWFyLA0KPiA+PiArCS5mb3JtYXRbUFND
X0NVUlJFTlRfSU5dID0gbGluZWFyLA0KPiA+PiArCS5mb3JtYXRbUFNDX1RFTVBFUkFUVVJFXSA9
IGxpbmVhciwNCj4gPj4gKwkuZnVuY1swXSA9IFBNQlVTX0hBVkVfVklOIHwgUE1CVVNfSEFWRV9J
SU4gfA0KPiBQTUJVU19IQVZFX1ZPVVQNCj4gPj4gKwkJICAgfCBQTUJVU19IQVZFX0lPVVQgfCBQ
TUJVU19IQVZFX1RFTVAgfA0KPiBQTUJVU19IQVZFX1NUQVRVU19WT1VUDQo+ID4+ICsJCSAgIHwg
UE1CVVNfSEFWRV9TVEFUVVNfSU9VVCB8DQo+IFBNQlVTX0hBVkVfU1RBVFVTX0lOUFVUDQo+ID4+
ICsJCSAgIHwgUE1CVVNfSEFWRV9TVEFUVVNfVEVNUCwNCj4gPg0KPiA+IEkgZHVubm8gaWYgdGhl
IG90aGVyIGVudHJpZXMgaW4gdGhlIGZpbGUgYXJlIHdyaXR0ZW4gaW4gdGhlIHNhbWUNCj4gPiBz
dHlsZSwgYnV0IHVzdWFsIG9uZSBpcw0KPiA+DQo+ID4gCS5mdW5jWzBdID0gUE1CVVNfSEFWRV9W
SU4gfCBQTUJVU19IQVZFX0lJTiB8DQo+IFBNQlVTX0hBVkVfVk9VVCB8DQo+ID4gCQkgICBQTUJV
U19IQVZFX0lPVVQgfCBQTUJVU19IQVZFX1RFTVAgfA0KPiBQTUJVU19IQVZFX1NUQVRVU19WT1VU
IHwNCj4gPiAJCSAgIFBNQlVTX0hBVkVfU1RBVFVTX0lPVVQgfA0KPiBQTUJVU19IQVZFX1NUQVRV
U19JTlBVVCB8DQo+ID4gCQkgICBQTUJVU19IQVZFX1NUQVRVU19URU1QLA0KPiA+DQo+ID4gT3Ig
ZXZlbiBtb3JlIGxvZ2ljYWxseQ0KPiA+DQo+ID4gCS5mdW5jWzBdID0gUE1CVVNfSEFWRV9WSU4g
fCBQTUJVU19IQVZFX0lJTiB8DQo+ID4gCQkgICBQTUJVU19IQVZFX1ZPVVQgfCBQTUJVU19IQVZF
X0lPVVQgfA0KPiA+IAkJICAgUE1CVVNfSEFWRV9URU1QIHwNCj4gPiAJCSAgIFBNQlVTX0hBVkVf
U1RBVFVTX0lOUFVUIHwNCj4gPiAJCSAgIFBNQlVTX0hBVkVfU1RBVFVTX1ZPVVQgfCBQTUJVU19I
QVZFX1NUQVRVU19JT1VUDQo+IHwNCj4gPiAJCSAgIFBNQlVTX0hBVkVfU1RBVFVTX1RFTVAsDQo+
ID4NCj4gPj4gK307DQo+ID4+ICsNCj4gPj4gK3N0YXRpYyBzdHJ1Y3QgcG1idXNfZHJpdmVyX2lu
Zm8gYWRwMTA1NV9pbmZvID0gew0KPiA+PiArCS5wYWdlcyA9IDEsDQo+ID4+ICsJLmZvcm1hdFtQ
U0NfVk9MVEFHRV9JTl0gPSBsaW5lYXIsDQo+ID4+ICsJLmZvcm1hdFtQU0NfVk9MVEFHRV9PVVRd
ID0gbGluZWFyLA0KPiA+PiArCS5mb3JtYXRbUFNDX0NVUlJFTlRfSU5dID0gbGluZWFyLA0KPiA+
PiArCS5mb3JtYXRbUFNDX1RFTVBFUkFUVVJFXSA9IGxpbmVhciwNCj4gPj4gKwkuZnVuY1swXSA9
IFBNQlVTX0hBVkVfVklOIHwgUE1CVVNfSEFWRV9JSU4gfA0KPiBQTUJVU19IQVZFX1ZPVVQNCj4g
Pj4gKwkJICAgfCBQTUJVU19IQVZFX0lPVVQgfCBQTUJVU19IQVZFX1RFTVAyIHwNCj4gUE1CVVNf
SEFWRV9URU1QMw0KPiA+PiArCQkgICB8IFBNQlVTX0hBVkVfUE9VVCB8IFBNQlVTX0hBVkVfU1RB
VFVTX1ZPVVQNCj4gPj4gKwkJICAgfCBQTUJVU19IQVZFX1NUQVRVU19JT1VUIHwNCj4gUE1CVVNf
SEFWRV9TVEFUVVNfSU5QVVQNCj4gPj4gKwkJICAgfCBQTUJVU19IQVZFX1NUQVRVU19URU1QLA0K
PiA+DQo+ID4gRGl0dG8uDQo+ID4NCj4gDQo+IFRoYXQgb25lIHNsaXBwZWQgdGhyb3VnaCB3aXRo
IHRoZSBvcmlnaW5hbCBkcml2ZXIgc3VibWlzc2lvbi4NCj4gSSB0aG91Z2h0IHRoYXQgY2hlY2tw
YXRjaCBjb21wbGFpbnMgYWJvdXQgdGhhdCwgYnV0IGl0IHR1cm5zIG91dCB0aGF0IGl0IGRvZXNu
J3QuDQo+IEkgYWdyZWUsIHRob3VnaCwgdGhhdCB0aGUgdXN1YWwgc3R5bGUgc2hvdWxkIGJlIHVz
ZWQuDQo+IA0KPiBHdWVudGVyDQo+IA0KPiA+PiArfTsNCj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4+
ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkIGFkcDEwNTBfaWRbXSA9IHsNCj4g
Pj4gLQl7ImFkcDEwNTAifSwNCj4gPj4gKwl7IC5uYW1lID0gImFkcDEwNTAiLCAuZHJpdmVyX2Rh
dGEgPSAoa2VybmVsX3Vsb25nX3QpJmFkcDEwNTBfaW5mb30sDQo+ID4+ICsJeyAubmFtZSA9ICJh
ZHAxMDUxIiwgLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSZhZHAxMDUxX2luZm99LA0K
PiA+PiArCXsgLm5hbWUgPSAiYWRwMTA1NSIsIC5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdf
dCkmYWRwMTA1NV9pbmZvfSwNCj4gPj4gICAJe30NCj4gPj4gICB9Ow0KPiA+DQo+ID4+ICsNCj4g
Pg0KPiA+IFN0cmF5IGJsYW5rIGxpbmUuDQoNCldpbGwgcmVtb3ZlL3JldmVydC4gDQoNClJlZ2Fy
ZHMsDQpBbGV4aXMNCg0KPiA+DQo+ID4+ICAgTU9EVUxFX0RFVklDRV9UQUJMRShpMmMsIGFkcDEw
NTBfaWQpOw0KPiA+DQoNCg==

