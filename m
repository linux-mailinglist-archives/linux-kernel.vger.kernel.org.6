Return-Path: <linux-kernel+bounces-573377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A1BA6D68A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BA7188D0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A925D545;
	Mon, 24 Mar 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0Qv2X5vX"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA2C7082F;
	Mon, 24 Mar 2025 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805922; cv=fail; b=gSK8zscPLL8yoWd5cAr1WhKyTczyxgdsX6OwCPIM9bEL0emUfGMedQ2Nx9MXij2zsH+Qa5vL+sNVqQazYEzCWCzGhIl4f61Lx07hf5Sjfn+WyGSSmVT3XQF1ElbGDnhTvlYnh9OHA5k+UZ6PBy+02UM4ZlDRn8J5i4XcrEFs/Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805922; c=relaxed/simple;
	bh=2ttscVwupyeQ6BDDaSEI9sEmTJCqbSaUfhtGR4Fk6iw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ABY4BIeub45fniOqwxIwnCdbK5Yiv6eDUyHUPVXH+s6ofO6ABFwA6qvmDipS663oUBKI67ddXxv/iAdJRbcbfzUH30OLbe7AZOw7y3Fb4lhCyjqYP5alcXag00+hVHDDIseoL7foKsoH6YlwxcA0yafWeWdQGXJRipPC1G7OQPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0Qv2X5vX; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O85jRw010581;
	Mon, 24 Mar 2025 04:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2ttsc
	VwupyeQ6BDDaSEI9sEmTJCqbSaUfhtGR4Fk6iw=; b=0Qv2X5vXCE6M0hNt4qHCY
	ErVk4w/0oDgks1e3fHsElleWrmMoX6nIDmAygmdb7QoD5l+XbCWGDIsoagBSFFtf
	y+nCfIMwAhP8MmSwnla3+xRKEaEoXJOnzEOnLtKI8k06A8tRsdkZuEMt0RTJPgji
	IjjK9cUOgck+Ogx+ieiiUwBcMiJVcObCk9O1kueuZFquWuFzeH5HWOzfCaPjZQPN
	fH8HK4yXQK2sAuO0QeCXFPxaqw7NIB0vCg20E7JfakLgBsZAS1IuRFIBuZcLBLUU
	WIAbTVK+HVwGwHnLqhYagG6Ihb+911wTk+VxqZc/7wGNwdYnbnKavLbjrTGpEtJv
	Q==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45hpyc8veg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 04:45:04 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7hlpRcTSFZSUOjFXz1pmubXnZgdvoPS53ZOpo7MXNG+sCZjiLADyAa07y292fGvUv+ySKKBAUjiIsLIN3Q321QnPEm1rtqDUeyrr1d/skhexCeabeoePKJP5b1G1ZgcE2fqVbGMrtItRCTnen8eJFQ6C+Q8/2Qrq10mzsTwyhmu5rD0KZPKTDovvX6AUgrNR4892MLnZuMKFVs9LjjcxiK0gE494ixau2e8haD2HV63RkwQdHhZ3AKE/cp1JrLZTpde8iutUlAPJl51uBz0ym6wIAylGfxulJwfejV7bEBY7qbo7cB9VscGaGx2F2kxVokbVBPMdZqhXrSTpGLWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ttscVwupyeQ6BDDaSEI9sEmTJCqbSaUfhtGR4Fk6iw=;
 b=e3LD+9YK5NDSF/Ws6D/Hev1ikMUP32u0o8Q/B7U6bIIYUUMR2o8YVjKu2S4BG8o5HIbkV+tFuN07PX7f04ezbq9F18wKvmJCC+e0Ms5p+kZrcqeQV7ZOaaxynVyEtW/EMUnLOU4z5bLJ+V/W1LBAavObPCakgPXH2CJJl86cEmls0HvN7VrE+8BDya1QrFYj7q9EsFd/1mlqSB4J7wHWehBPa841EiIbFn97O8yxh0dQx0jtJimV7X7CbUMK5JDaT2B6+FI1xZ/oodS29LAR7DA7X0Ddud7DkYkpKt0Lq8kYid//Er0tF7JP/6PRsCFEThind5XfFdQkQPscTp1Y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by LV8PR03MB7493.namprd03.prod.outlook.com (2603:10b6:408:185::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:45:03 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:45:03 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: regulator: add adi,adp5055-regulator
Thread-Topic: [PATCH v2 1/2] dt-bindings: regulator: add adi,adp5055-regulator
Thread-Index: AQHbmWTs0tq9YZuaRU+BZzr0M0+ierN7sYCAgAXWiKA=
Date: Mon, 24 Mar 2025 08:45:02 +0000
Message-ID:
 <PH0PR03MB6351789B0AA5464755D98049F1A42@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20250320-upstream-adp5055-v2-0-aac2d3705802@analog.com>
 <20250320-upstream-adp5055-v2-1-aac2d3705802@analog.com>
 <174245934743.3732121.176471277866008029.robh@kernel.org>
In-Reply-To: <174245934743.3732121.176471277866008029.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|LV8PR03MB7493:EE_
x-ms-office365-filtering-correlation-id: 89797d00-1aca-40b3-a015-08dd6ab02b4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHhOcWVuRW1iaWtDajVtbWtUdVovbTVWaDd3M1J0ODQwR2NxV0lSUGRBT3F6?=
 =?utf-8?B?L2UxTVBtK2VDOW9ldytvTEtPaDhzK3puaVFMMGdaVm45dEZyTDFObktXbU9Y?=
 =?utf-8?B?b2FrWmw4U3B4YWJaNXVXbW5tRTFXR1crNS8yNkpSc3V3Vy95YkVxNzVDaUhV?=
 =?utf-8?B?V01rcDlVVHhYenFkTnl3cE5qMU1JTFBvSnlieGdrWWZ0eU1DMURVZmtMUmxT?=
 =?utf-8?B?NmYvZGdrdkZwS25aMWNOZGFRSHFSYUtmV3pPbDRMejlodzhlQ3VNSGhzeG1W?=
 =?utf-8?B?ZXBpbVE5UnpQT1IrSTlINGMzVmpEZ3hxSW83OUE4SXVlMkpGVnNubnZ2ZkdC?=
 =?utf-8?B?eVJoUnVkdG5SVjZ0d1lYUEJpeHF5cWZiZUhNcWw3LzBFa0ZjVmhuUll0YXF2?=
 =?utf-8?B?K1k2OTVSYUFacjkyYXZGeldTT3JwMlpFU3E1WWYwQ0RZWll6V2Y4MkRrNklN?=
 =?utf-8?B?MUxoakh5Zk5tcVQyZHkveWM0VGFmc0ZjM2ltanRKR1pTQzJrTWUwTERTMFVQ?=
 =?utf-8?B?SUJPeERCQlRiUGVZaTNnQ20zTkJJbDErU1pJOXNZZVB2NlFMSmJOOE5QdFVa?=
 =?utf-8?B?NzBhaXltZzRXVjBwNTdJalZLQ1h6WnNpMlFJMjVhV3hNWFFhbTBvQTI5SjdD?=
 =?utf-8?B?QURrVDRuZHRNcGxUTVlraDVkOGdSVzlLWGlwK0ZWVWFrVUFGZG9ZZDR4Z1JY?=
 =?utf-8?B?SXVTeUgrdElDZzBJYjVFcHA0SThXQkpSL252U1JmSytLWTZMa2VnOWFoVFl1?=
 =?utf-8?B?akZmeWVpV3Zvbk5TTWZrOXVXOVFKN3Ezb25BRUs5SjA2dnhQWHBJZFBOTW0v?=
 =?utf-8?B?cTcza28yTHkySGx4aDlVcHFyNU5DTndNUWZ5TWkzenRMTW9od1A5ejFOVCtW?=
 =?utf-8?B?V3c2UDQ2ZEtCU3I0amZYYUJTckxvaGJZNVAzY1RlbldzWXNXK3JrbGc3Q2hN?=
 =?utf-8?B?MUl5NGg0K2pYSUpyeW5sUGJWSEVFN3h2eXp2cVpGcjduaU5HRVdRRGVUU3ZR?=
 =?utf-8?B?d25lNWZPMXZ0aVcxYXRPbXNKT1poM3FJb3RKTWwzUWEyUmxSZzRKMmE0ZUFE?=
 =?utf-8?B?K0ZEaWFlQmt1alNpc1J4b1R1a0NCQUNGQnhiZjVySSt1ZUlCZGd1VzR3eUNO?=
 =?utf-8?B?L1JXRWp1cWJHYi80M3NGblNLRWZoemp2bUZQV3dJSzR2d0tWVlp3VVh0bWVz?=
 =?utf-8?B?WGhyZDZwR2lTZDltNUpFUUdMbkQrRGZZeFpIVlJlZlpObEJ4WXVSbWYrZkRk?=
 =?utf-8?B?ODRHNnZ5MGpVNmxoaENFS0d5ZUd5b3NWaUtQbDdnMXlCMlBjdXFRQk9lcEln?=
 =?utf-8?B?YmhkcUdyVW84NFhFNjU0UkF2T2pyVk01SkZDZWN5YnE4UDAyYnpMbzVaQVhX?=
 =?utf-8?B?Sk5LT1g0cEtJWVN6OVRvSGlCUG85dzlUZXFJUDM0YTJmNGdhNUdCeWFhRjc2?=
 =?utf-8?B?cXFKK0tETldhS1c1d1ZldklHL3hnZDU1TFUwaFRha3dSamszZy8wVVZzRDEy?=
 =?utf-8?B?aDh6NHJiWXlhMUNqZHd6NGZQUUlVS00rcC9lQlV2ZVRBOXRkaWx5aEx2bWxI?=
 =?utf-8?B?UzhDRXlua0p4UHpwSU43ZWYweisvNkYxdHJnQmg2L1ZYL0VXblNuMDRFeGl5?=
 =?utf-8?B?U2Mza2VWYkNqd1dML1diUS9weTNMaDI0ejQ4UjQ4TDhkSWUrNmplV0dWVHpy?=
 =?utf-8?B?c09qNHU4bDRXVXhFWCtXRldIREtMS2wzOWNNM1FhcGFrRGFZR3VRcWtLQ0NF?=
 =?utf-8?B?cnBxd0I1dlNSR0tlMmlHMVduOU1lWE0wbys0U2pTM2h2MWpzQnpyTkVBaG5i?=
 =?utf-8?B?SUZxNlVjemtKcTZ3eVgzL1FxbG1OcjdlM0RmOHRjZkpLVTArTUc1N0F5N0VI?=
 =?utf-8?B?WFI4VnlhY0cwcXZQaUdPV3dPT1NvVy94UitDZjZnSUk4dUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWNxWXB4TXgzT3NObThndWs0L01BRHJIS2p6eHU2eWFpaFBrSlRYcEZOQ0RN?=
 =?utf-8?B?NnI5TEZQaUlRSFRwa09WNC9jWVFGN0Mxb0MxMHN3NzBrQkFGb0QyOW43bXlm?=
 =?utf-8?B?U0hxaDhUQVB1ZGlaK3U1T0EySTh4N0w3VnZuZnhOUVZIaG9ycnFuVU83dnpY?=
 =?utf-8?B?ZlJydVJLMnNFMTlUdnhKUzVUVlROdXJSWkVyQmZGZzZtMGNiOGRyT2lyd3BH?=
 =?utf-8?B?VndNdDBSanBxNk52Y1p5Nks5VlJiaDNUcXZwNjYwYjQ5SW5mQ3N3MUxJM2F3?=
 =?utf-8?B?RFN6WjU3MmtNWFQ1NTJvVk9rVGhsa3YvYVB5aUNvZXRTb09YZkVRS2hYai9u?=
 =?utf-8?B?UkhrMTd0TW1YWTBhUXZ2KzZIbFhuTVBOd0l0b1lwLzV6N2FoQVRJRmU1R0xm?=
 =?utf-8?B?VWRRYnJac09Ud2d5U1pjQm52c1FwUGhVNWMvK2pBMG9BbDY5Snpqc3hqM290?=
 =?utf-8?B?azZxM2VUcDQvci9sVHZGOU5hQTRrM2g4alVOeWtsZG1saWVFSUZtVFZyM0d4?=
 =?utf-8?B?emZ5bkd1eWRuU0JDc0lXUllhL01sSmdGVTNEWXBMMnlkMDlIUitmTlpHRU9O?=
 =?utf-8?B?RWFoalA4TkRuM1JhR3BDV0luNUFlOTBicVNEeFM4bkNXbS8rV3ZyQXFuczJL?=
 =?utf-8?B?M2txdGpjWFljN2dvdXZaQUJsZ3BZRzI5cTZkK0RaYjhyKzJEa0dFNVBTcmhk?=
 =?utf-8?B?OXhpL2pjT2cyQkNHVVN0Q3RSNW0vWFBDNzVnQjlLcmk3dDF0TUs3MWlnU2t6?=
 =?utf-8?B?R2xNbDdPSTdUQW1jRDZ0ejVrUG1CTTU1ZW9XQXIvWHhWNHNZQ1ZRRkNBM2lI?=
 =?utf-8?B?Tmx6dkY2MTR1bXNaNGp1UHNhY0hrcEVUQnRzNjk2clFmc3lpbitIeXJhUUYy?=
 =?utf-8?B?R01CM0k5aUVqTldZMG9NUUdUMEVRTDBIUW94UExQRm5xS0pHczIvajgxYm50?=
 =?utf-8?B?Z04yTDlDanczOG8zMDIxOUZuTEFUZE5UQVZDa2dXdTRnWldpTzRhQitHWUxL?=
 =?utf-8?B?NDN6MC8yNHdJMXhOSlpPWXdyT1Fsb2IrU3B4QmllWER1amswWDVEbkw5ZkxH?=
 =?utf-8?B?WTE4R1BhcnJVMWZHcFgzdWRnYlk0MlhoTW03ck9EcllmRVFLcTg2aDFnczQw?=
 =?utf-8?B?cEQ4N08vYXVtSjFwa3E0SU1idmJ1M0NPckZydTh1WG03YnRnMGxvM2ZtbDhS?=
 =?utf-8?B?eWZxbnZpZlVTT2g3TG1yNUhmQlpZWGtQVnA3Z2FDMCtkUFoyeVNRN2lJSGFn?=
 =?utf-8?B?Zmh0SEFuNlg4ODg2K0k1S05iOGlKN2IrVWc5Ly9UejVGWGN2UUhpbFdpRGVP?=
 =?utf-8?B?bWRHOXFQUUcwbzBHNzVFNHg3UzVmSHo0RUgzL3FIMTdjYW5hNk1ZdVNBUUhF?=
 =?utf-8?B?eGtRN0p4dEw4SkFSQ3FOdnZCRWR1Rmw2YTU0WXpPYTdYL2YyMSs3MmVNNmlk?=
 =?utf-8?B?bmwrMUs4Nkt6aEQ2VmFoT1BFV3diU25keWhERGFHUVpvMENMNEhpMGJUbldY?=
 =?utf-8?B?NWlBVDRuVVF0MXVIRzBKQ3h0MFE0eENoM09jVmRLelVaZGNXRThGV1dXM3U3?=
 =?utf-8?B?R25Od0hYVVJJbVlGbGRraXVDa3dkNHl4Y0xRT0JKTmVxNkZYaXg3d0ZNWnJD?=
 =?utf-8?B?VTk0eVltZFJieU13OW1UeFRpczArelNoMFdycmh3YXE4djh0SENIaHVMT2Jx?=
 =?utf-8?B?MTNqZjJNbi8xRUVpaGg5Q3lqcVVIVHc3S0dpT0RPNjVOSTlLZXpyb0EydkF0?=
 =?utf-8?B?TXc4TGZKLzVKMGZHaW92dlRpU3M2OG1IZHpuUGovRGdzZ1EzdjdFWVcrTS9m?=
 =?utf-8?B?R29ab1JkeHRUMGNyVGl2YWtId1hqRThONGh3Z1RmVVh1eCtXaTlEN2doVkts?=
 =?utf-8?B?NjFMTG9BaStGMUxpeUp1NjdOQTR6R2x3SnlWYUhUUW53S0RIZTJ4dGhGZDhQ?=
 =?utf-8?B?TGFmWmlZa3FiSWlFbmhiWVlrZjh2Sit5RnphMlRXdzRLY014UFFIVXRwQ0J2?=
 =?utf-8?B?aGhzNkM4Ym0xZlFXbm5BTVd3VmJmb3NLV1ZVNVhxdjFwSWdaZ0ptR1d2ZVNC?=
 =?utf-8?B?SzVNL1k0VC9xWnlrY3gzeCtVaForaFZzRmJYL1VVWmpIa3BSV24zRXJScTFL?=
 =?utf-8?B?YWdxUUgrL1JVZ2hpMkJkR2FHdlBYMGVTR0RWQ0lPOExhNWEwbUl3Szh5WU1H?=
 =?utf-8?B?SUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89797d00-1aca-40b3-a015-08dd6ab02b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 08:45:02.8975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFWkJS/moc/KbdzAdD4Q2WTq8Rl4Cj2ROBDz4JyJKg+oFxL17BGQAkJP4pvAD5Y0bUT3KHh9jZKZ0r+Z/UjpSMItKTe5a/NauBEcwyachek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7493
X-Proofpoint-ORIG-GUID: OWIW-BEgTpV59jfJqoNiW9uj1bEjITN2
X-Proofpoint-GUID: OWIW-BEgTpV59jfJqoNiW9uj1bEjITN2
X-Authority-Analysis: v=2.4 cv=P5g6hjAu c=1 sm=1 tr=0 ts=67e11b90 cx=c_pps a=PK5aExQQjalka8oDlC/sVA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=uherdBYGAAAA:8 a=gEfo2CItAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=0awkmHLjsCMGZ7zvgVIA:9 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240063

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgKEFy
bSkgPHJvYmhAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDIwLCAyMDI1IDQ6
MjkgUE0NCj4gVG86IFRvcnJlbm8sIEFsZXhpcyBDemV6YXIgPEFsZXhpc0N6ZXphci5Ub3JyZW5v
QGFuYWxvZy5jb20+DQo+IENjOiBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBM
aWFtIEdpcmR3b29kDQo+IDxsZ2lyZHdvb2RAZ21haWwuY29tPjsgTWFyayBCcm93biA8YnJvb25p
ZUBrZXJuZWwub3JnPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtlcm5l
bC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8yXSBkdC1iaW5kaW5nczogcmVndWxh
dG9yOiBhZGQgYWRpLGFkcDUwNTUtcmVndWxhdG9yDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiAN
Cj4gT24gVGh1LCAyMCBNYXIgMjAyNSAxNDo1Mzo1NCArMDgwMCwgQWxleGlzIEN6ZXphciBUb3Jy
ZW5vIHdyb3RlOg0KPiA+IEFkZCBkb2N1bWVudGF0aW9uIGZvciBkZXZpY2V0cmVlIGJpbmRpbmdz
IGZvciBBRFA1MDU1LiBUaGUgZGV2aWNlDQo+ID4gY29uc2lzdHMgb2YgMyBidWNrIHJlZ3VsYXRv
cnMgYWJsZSB0byBjb25uZWN0IHRvIGhpZ2ggaW5wdXQgdm9sdGFnZXMNCj4gPiBvZiB1cCB0byAx
OFYgd2l0aCBubyBwcmVyZWd1bGF0b3JzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGlz
IEN6ZXphciBUb3JyZW5vIDxhbGV4aXNjemV6YXIudG9ycmVub0BhbmFsb2cuY29tPg0KPiA+IC0t
LQ0KPiA+ICAuLi4vYmluZGluZ3MvcmVndWxhdG9yL2FkaSxhZHA1MDU1LXJlZ3VsYXRvci55YW1s
ICB8IDE2MQ0KPiArKysrKysrKysrKysrKysrKysrKysNCj4gPiAgTUFJTlRBSU5FUlMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKw0KPiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDE2NyBpbnNlcnRpb25zKCspDQo+ID4NCj4gDQo+IE15IGJvdCBmb3VuZCBlcnJvcnMg
cnVubmluZyAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBvbiB5b3VyIHBhdGNoOg0KPiANCj4geWFt
bGxpbnQgd2FybmluZ3MvZXJyb3JzOg0KPiANCj4gZHRzY2hlbWEvZHRjIHdhcm5pbmdzL2Vycm9y
czoNCj4gL2J1aWxkcy9yb2JoZXJyaW5nL2R0LXJldmlldy0NCj4gY2kvbGludXgvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9hZGksYWRwNTA1NS0NCj4gcmVndWxh
dG9yLmV4YW1wbGUuZHRiOiByZWd1bGF0b3JANzA6IFVuZXZhbHVhdGVkIHByb3BlcnRpZXMgYXJl
IG5vdCBhbGxvd2VkDQo+ICgnRENEQzAnLCAnRENEQzEnLCAnRENEQzInIHdlcmUgdW5leHBlY3Rl
ZCkNCj4gCWZyb20gc2NoZW1hICRpZDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3JlZ3VsYXRvci9hZGksYQ0KPiBkcDUwNTUtcmVn
dWxhdG9yLnlhbWwqX187SXchIUEzTmk4Q1MweTJZIS1lV2pOLQ0KPiAydzJmMHVQdGtmYjRoSDlz
MXRsblhycUF2akJ3MmlWVXlnM2dzSThnSXU5b2JrMFdOeFJBN2lDdm1UVGxVTGsNCj4gR0dwUTZ0
dHhXYzJWd1BmNEEkDQo+IA0KPiBkb2MgcmVmZXJlbmNlIGVycm9ycyAobWFrZSByZWZjaGVja2Rv
Y3MpOg0KPiANCj4gU2VlDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3Bh
dGNod29yay5vemxhYnMub3JnL3Byb2plY3QvZGV2aWNldHINCj4gZWUtYmluZGluZ3MvcGF0Y2gv
MjAyNTAzMjAtdXBzdHJlYW0tYWRwNTA1NS12Mi0xLQ0KPiBhYWMyZDM3MDU4MDJAYW5hbG9nLmNv
bV9fOyEhQTNOaThDUzB5MlkhLWVXak4tDQo+IDJ3MmYwdVB0a2ZiNGhIOXMxdGxuWHJxQXZqQncy
aVZVeWczZ3NJOGdJdTlvYmswV054UkE3aUN2bVRUbFVMaw0KPiBHR3BRNnR0eFdmSFoyN1o0dyQN
Cj4gDQo+IFRoZSBiYXNlIGZvciB0aGUgc2VyaWVzIGlzIGdlbmVyYWxseSB0aGUgbGF0ZXN0IHJj
MS4gQSBkaWZmZXJlbnQgZGVwZW5kZW5jeQ0KPiBzaG91bGQgYmUgbm90ZWQgaW4gKnRoaXMqIHBh
dGNoLg0KPiANCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIGFu
ZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZSBlcnJvcihzKSwNCj4gdGhlbiBtYWtlIHN1cmUgJ3lhbWxs
aW50JyBpcyBpbnN0YWxsZWQgYW5kIGR0LXNjaGVtYSBpcyB1cCB0bw0KPiBkYXRlOg0KPiANCj4g
cGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0KPiANCj4gUGxlYXNlIGNoZWNrIGFuZCBy
ZS1zdWJtaXQgYWZ0ZXIgcnVubmluZyB0aGUgYWJvdmUgY29tbWFuZCB5b3Vyc2VsZi4gTm90ZQ0K
PiB0aGF0IERUX1NDSEVNQV9GSUxFUyBjYW4gYmUgc2V0IHRvIHlvdXIgc2NoZW1hIGZpbGUgdG8g
c3BlZWQgdXAgY2hlY2tpbmcNCj4geW91ciBzY2hlbWEuIEhvd2V2ZXIsIGl0IG11c3QgYmUgdW5z
ZXQgdG8gdGVzdCBhbGwgZXhhbXBsZXMgd2l0aCB5b3VyDQo+IHNjaGVtYS4NCg0KTXkgZmF1bHQs
IGl0IHNlZW1zIHRoYXQgSSByZWFsbHkgZm9yZ290IHRvIHJ1biAnbWFrZSBkdF9iaW5kaW5nX2No
ZWNrJyBmb3IgdjIuIEkgb25seQ0KcmFuIGI0IHByZXAgLS1jaGVjayAoZm9yIGNoZWNrcGF0Y2gu
cGwpIGJlZm9yZSBJIHN1Ym1pdHRlZC4NCg0KV2lsbCByZXN1Ym1pdCBhZnRlciBJIGFwcGx5IHRo
ZSByZXZpZXdzIGZyb20gdGhlIG90aGVyIG1haW50YWluZXJzLg0KDQpUaGFuayB5b3UgZm9yIHRo
ZSBzdWdnZXN0aW9uIG9uIHlhbWxsaW50IGFuZCBkdHNjaGVtYSwgd2lsbCBhZGQgdGhpcyBpbiBv
dXIgZG9jcy4NCg==

