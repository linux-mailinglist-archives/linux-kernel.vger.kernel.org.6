Return-Path: <linux-kernel+bounces-339092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E0E986040
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F7E1F266FD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DBD19E810;
	Wed, 25 Sep 2024 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="lZpyKkO2"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC819D88F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268444; cv=fail; b=nMnym1s+tguCiSnNd68wf8TG6vtzek07apZhHaPtpH+ePZqOZQQSKtFMiCQ1B0KwThZ/mbYdvfhfwpDBC9P8uSVuD55NCmgkhuYLwwHF2kqy7TZrr/3tczca01/9WYz+7oGqF43oD21vW6lZnb6tIMjoKTiKyqjRwsZ25SYQu/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268444; c=relaxed/simple;
	bh=mmBL1Xape1T4XlIRnXJvxq2E1qySuXeQsA5NZA6xg3M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DZlbuwev6kTt3d/f619mHUNfnTsrozm74h3TMxvWpsB8wcve/mM/XCiGi1+Fah0jnlqeSy2vqRkazC8+Cfca6WuMDrqUFF63ZO9m39PnPnGuYC5qX4n5fKuUEUtUiUwjp9erIGVcMJwxMiGwnJBJzduuJ1rz/AcOgM4CVdJ7UQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=lZpyKkO2; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PBvBnb002025;
	Wed, 25 Sep 2024 05:46:54 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41vfp3rrds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 05:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6Re3qlQMCAfuG2FbZFXZnV8xijTIQB3K/b7ZAWLnFwYuffC2PkzA0cQ3J9Ef5NZyC279OzgDUZqtO8UfTwS1sOORE1a8c5Ao5e4HrCp6tQlloxhji7Kldi4EViHTw/XFaO2Ro5H6ZSa41gd6hwRKN6qhGwsTfq47uTXI1/YAW3mviu+oTLobwEa5lufYDhCkJdTCAsOaywQ5LVjOvLImTUaRRLap4WvU2HKFo7gKVJMI8yjLJ+FWfke8cVVVToEKwGtRRWhV1+RPeoYxrNgCw3WqpAkUAweWhgEp9qh1O0EHcuXj4Eu93KSejsBgXYinLr0DcQSOMpf13/jCvRjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmBL1Xape1T4XlIRnXJvxq2E1qySuXeQsA5NZA6xg3M=;
 b=xKvwqCKoXmZo/gFFWc34q/SOwtLDX6NL1YbFLM/V0v7UJfD5bPXqyyjhRFJ8INX7v9xUU9l92PI32OeHIUPror67FqSOZv5+Relym8/ALTu7YalSdNQrTrYEDlyE2SsNvbzlmY3H8N0fmH4GaafSE+Db24CnUdAN0QjrXUpEuLgY3AmGsCkUzDlBGzkAKJDBAUMfv1/6G60yM738rjpVGwuVaDfLwXvfkNppF4Y8b/KzS7q66+sbeEvkrI69jmm7angoe/4BH3IfToRiMnyEKPu9NOg0UmmWuXsEILibNBUkZ0rKjCrhKEg5lOSN59GJPRsx4te0SH0NwIg9u6rIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmBL1Xape1T4XlIRnXJvxq2E1qySuXeQsA5NZA6xg3M=;
 b=lZpyKkO2Z9UT77sLncw0Z/d4gFBYEQtK7nVyNCkGiFxZoS1pC2+ZdDc1h40D9Qh+w3+Y0kvNi/DjpbvnQkqWzWpkA+C8Yh5b7szpmwHoptsnWupj4GjF0SqiQWtWKKuLrUUL+Hc5Qf6GSSBX/jzFJcDS1O6jf8NLYxpLD0wVa6Q=
Received: from DM6PR18MB3289.namprd18.prod.outlook.com (2603:10b6:5:1cf::15)
 by SA0PR18MB3533.namprd18.prod.outlook.com (2603:10b6:806:98::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 12:46:51 +0000
Received: from DM6PR18MB3289.namprd18.prod.outlook.com
 ([fe80::6a44:6658:d0cf:bca2]) by DM6PR18MB3289.namprd18.prod.outlook.com
 ([fe80::6a44:6658:d0cf:bca2%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 12:46:51 +0000
From: Anshumali Gaur <agaur@marvell.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "arnd@arndb.de"
	<arnd@arndb.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nikita.shubin@maquefel.me" <nikita.shubin@maquefel.me>,
        "vkoul@kernel.org"
	<vkoul@kernel.org>,
        "cyy@cyyself.name" <cyy@cyyself.name>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>
Subject: Re: [PATCH 4/4] soc: marvell: rvu-pf: Handle function level reset
 (FLR) IRQs for VFs
Thread-Topic: [PATCH 4/4] soc: marvell: rvu-pf: Handle function level reset
 (FLR) IRQs for VFs
Thread-Index: AQHbD0j+tfgyVIdeOUad1+JHJU7YMg==
Date: Wed, 25 Sep 2024 12:46:51 +0000
Message-ID:
 <DM6PR18MB32895C157AEEE0D3C1995A8EB8692@DM6PR18MB3289.namprd18.prod.outlook.com>
References: <20240920112318.2722488-1-agaur@marvell.com>
	 <20240920112318.2722488-5-agaur@marvell.com>
	 <8f3c9f97d2de59ba73bf3c50f16d262d68ef4b2d.camel@gmail.com>
	 <DM6PR18MB3289700364A89C7714973C70B8692@DM6PR18MB3289.namprd18.prod.outlook.com>
 <9d0bac264a62f4b5f161a53bcaca35b6cef42376.camel@gmail.com>
In-Reply-To: <9d0bac264a62f4b5f161a53bcaca35b6cef42376.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB3289:EE_|SA0PR18MB3533:EE_
x-ms-office365-filtering-correlation-id: 868edbe9-0790-4588-1248-08dcdd602090
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDJDbk5ZckpaMHlNZTBXSVI3K3htRHlDQndZTnVEOGxiYkppN1JidDFZaXNj?=
 =?utf-8?B?ek9xVGpMS1U4bGRrT1NCWmtSLzNyMlZDU2pua29YR3JGYkk4UXpHWko3VFVX?=
 =?utf-8?B?WlN6Z21RRnNGM1l0TElHcFJidk9YZnRwOGR2ZFYwOFNYUkM0UGQ0aGpaNGNv?=
 =?utf-8?B?L0JJRG5TbUJocXZjd3Q3ak1McmdtVU5OY2JTNHgzYmFKUDhTS0lRdFc5R1Y2?=
 =?utf-8?B?UENuc1J5dTNnYnhOUW5xUEk5S1g3c3kwdW5ZZEh5cDU3VkhkSURidHlsVkJs?=
 =?utf-8?B?N3dIbFRKdGZLaXNPMExQNWdQR3cvRnVPU3djbVNBNGlHTHVXUnRmV2RvNUdx?=
 =?utf-8?B?K1hzTloyREloL0J0d3FLOW96U1VQM1JYTlNUNy8yYnBReTdwcTd6VGUwd2Rq?=
 =?utf-8?B?OUhRK2x0QW1LYnJwK3hIUVJTTk9IRko3Tk1rK3p5cXY2dXJNYTVDZGZKT2Ex?=
 =?utf-8?B?ZUZCSEgwbHRaOFVOZkVZNVU3UHRmaG5WMkxuZUErSTF5R0ZLQUNwcTdjbU96?=
 =?utf-8?B?REd1dmdvTkVjYk5LN1BKV01sUzN0eGtYdXBNQVJnV2dTVnNnakJGbWhlMGZK?=
 =?utf-8?B?aGxwaGtqdk1VZFFjdWZ1aExYODdKUTllSmhGWmgrUzNiSit4d0J2NzJQYmF0?=
 =?utf-8?B?dkEvbVgrKzVabDZVRHVLR0szQVNDMkEvNk1QUGV2UGFvYWdvZ2wvZWpkamdi?=
 =?utf-8?B?VzBDWk5Ld0pNNlIyU2lhSFRsU09zRGhYcWMrOFRURTFLR3FzTVpOaHFScXls?=
 =?utf-8?B?VXZaM3R6UXhDTGdSeUFIQ1lpY1VGV043V3RBWGpMM01yNTJ5bVNWaDZrWS9S?=
 =?utf-8?B?RmpzeXZ1clRlak8rN01sMmpqWkdVcUlBQWFiUnRqdHk2ZU9ZNFVHNUptVzJ4?=
 =?utf-8?B?cFpreEdmK29CaXRpVmYycDhJZ2lQZWdZclY4eVNjV1Bkc1BWL0daUEF6bzMw?=
 =?utf-8?B?UXlCQkZYSmtXM0RWQmtKQUlsRmR3YXpDK0duZjlGTXVGNXc5REtpbUpIazF5?=
 =?utf-8?B?RHh6MTdkZjZPc2VNalhYSHVjYkpjV0dkT3FNSkVqcm56c1duL3JpMFl2Tzh0?=
 =?utf-8?B?RlVzbFh1LzBMelQvczgya0Z5Y284OXd5dW00VU5heXBIT2IyYWtWaWhMeGpS?=
 =?utf-8?B?VlIzKzRPa1c4S1pGbjB6UnRvTUJSUlU4SXVXM2ZET3JqL0tCSDgwaDhzaHZr?=
 =?utf-8?B?SGFySzRBcytyK0MyMlVFN2VaUU1oUm5nUFRIUmpoRFYrN3lhZ29mNUtsMVFK?=
 =?utf-8?B?UDlaT3VUbW42a1pxU0d5dmNNVnM1V0R6ZE5pdE0xb2hLdFJ3TGRkOTg4anNr?=
 =?utf-8?B?S2NXTHdRV1F5Nng5YXQ4SzRyVCtQVDhZeEdBM0t2OUw5L1I2dUswTFZrZVZq?=
 =?utf-8?B?UFlLTHhFa1hNN2tVQUlMQlZ5SUgvSU1qSnViZ0FMazRONDJibWc5QnZ0VEE2?=
 =?utf-8?B?V3RoZW5SeGFHY2grMjE5MDRibWNMMnN3RnhnVWJLaWM1L2FHeUVkYXNYVjdE?=
 =?utf-8?B?V0hEeTNTVUNVdHI0enZwTDlISVV6ZUFCMnZRQlREOFc5U0I5Uk1vRUoxUis4?=
 =?utf-8?B?T1pOTkdkT0RvWHkwRVdLLzBPRjMyZTJYdlhPZ3hHZ1FwUFUrUGZIckNVMnND?=
 =?utf-8?B?NGVEMGlZa05UU1F4L3NGbnJqQ3hUWWdDR1BVd0JpMTlXSXVxaG9Oa2hKZmJp?=
 =?utf-8?B?TFBSR1A3RUM0dGVrWDN5UU1YTFZ4cDRNZURCTUVwaXNPUjdDdWl5QWxtbmx0?=
 =?utf-8?B?cEswL0VBS0V1NFcrN0I3ZHd5UE8yV01WV1NzVDJVems4ejQ2S1NiM0ZzWkdp?=
 =?utf-8?B?UkN1Q2dwOWliVjRmVXFmUkR0MXgxNXZMcDVVa2tsellpWmlRTjRVS2tDRUJF?=
 =?utf-8?B?aW1QbStvdXBCLys2R2svYmxPd0NjRjAweUhBbi9XL3JZcmthQjZoVE1EZXdv?=
 =?utf-8?Q?FE5HzhRuh9k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB3289.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmhsMENmbkM0Z2pRdWhOQmlkNm1heGVxbVUvMGwyMXhYd0hrMUorYmFOV1Ja?=
 =?utf-8?B?cnJlN1dEN3ZjTWgrcW5VL1hLOHE5cHlYQWpOdmRTQUZDUklwMXNibWxhb3JS?=
 =?utf-8?B?QjJIa2k5eU5jRUZzZW5QaHlSVnJYQ0xtNE53TG1sUUtnaGt6UlltOVVGbmpR?=
 =?utf-8?B?K1dIZW5XUWx5bWJoSyttQmJoOHdtSTVveklqQ29aU2c1UFlSTGdzNmM1M1RX?=
 =?utf-8?B?R2tVemNSUUFTV0M0K1JnM3k4d2JMZGM4eTUvaytEZWd3QURJRjBON1dkcHd6?=
 =?utf-8?B?Q1FsSFBoTUF3RkhmT3lyZm9TUi9lSi9XS2d5eGQ2WHZ6eDJydlZzZEJBV2VY?=
 =?utf-8?B?eDJ3L0RUZEo1TTRWMWw4Umo4SUMrZ0o3Vmp5cjFYeXQwWTBKR2ZqSG1xNE1T?=
 =?utf-8?B?cVh5akcrNFhwa1RlVGJScWdKYlVGMHN6MlB0cy8ycVptNEFkNy9NQTJScTNN?=
 =?utf-8?B?MTVhMnhpekY1UExkQk5yUS9aNG5pSGsrNVhVZHpxLzBoTDB0a1ZLaDVzQ2lS?=
 =?utf-8?B?ZUFlVTAwMmZvSkt4MFFBbGluTUpQQjIyYWFWNmhlL1pwbmNURmVkMzR2N1Vv?=
 =?utf-8?B?N3I0UGYxeSs2K1ROdG5WelI4ZU5lUUd1VWltMXZKV1pUeFcvVjd1TlB6TWxI?=
 =?utf-8?B?Tzcra0F1Z2VqMng3ZXBBRytiS0dLQWlOTExDVnExTTVrenE1T29GUmlTREtO?=
 =?utf-8?B?NWQ3V0M4Z1c1TVdqdU5EQ2ZaVEdrVTB1QU1rT2EvZzJqdmZsVnozcWZObzJq?=
 =?utf-8?B?OFhSQmpiYUVhWEZ0VU8wcWF0aDgxbERPd0tQa2ZQS3FpSmtCRXVGbVExbjUw?=
 =?utf-8?B?SWRmYldVbEw5VFh4d2FMWEYzbHppZmI0cjFRS3hLQ3FqcklzWWZRWHB1Z2dl?=
 =?utf-8?B?d1ltMUJTY2VQOFM2OTVUanF5em84SkV1ZnQyQUdUR2pXREpJZTNraExyVU9j?=
 =?utf-8?B?engxYzdMRlhWZ0Q0Z0psQTBWUzIwYWFZbFZnOVlMZ1g3SVQzQ2Mvai9RcFZz?=
 =?utf-8?B?alFPTFRGMWtoanZzcjB4bXByUHBxVFZxMytYcGV3OGhtNFBoa1dYQXZ3WWJW?=
 =?utf-8?B?S1BGKzVjTjBPRXBTRlk3WmpRcnA1d25hQ1dINnNCeVJ2TjRJc0hIVTVZMHFq?=
 =?utf-8?B?aHF1NjNnc094Y2FyTEkvK3NiM05zN1JDUFNlYmtpMUNyMGdyaUNjbXhBR01X?=
 =?utf-8?B?Um51K3NNc0hkUVQ2QjZ2bjhMNVpGdGRZT0VVdHZyZG1xU29wWGUwR2VwaVBT?=
 =?utf-8?B?a0FzdGNjblowWm1PNm5XMm53ZUtic0pwZTZJNWQ5VmNhUmt2dkN0ZDREcS83?=
 =?utf-8?B?aERaS3o4TlpEQkZwN0htaTRlSzFOd092NVloYWJrQ04wUFJ0NFlVTjlJZ2pX?=
 =?utf-8?B?OXRnd2pFUXZQaWRJVXpESjFqNW0raitpY2wzOXk0Z1Jtdnhjb2pYUjN5OUFS?=
 =?utf-8?B?SlkwdE8wRW1IaWw2NS84WXN2OEU4OEZIOGRES2R5dStRSTFONnZueGNvbW56?=
 =?utf-8?B?TVVHUmk0alRtWFJjdWhKRmc0elF5RmI3YWIxTjdtVkk2eHFuTGsyZ1NjNDFz?=
 =?utf-8?B?KzNuQlJtLzRlTXR3amtnQ1N6KzlaT1RUVGxTNjRVODJISjV5YjdXMXdkeTQ5?=
 =?utf-8?B?eG5veDY1Kzh5SkUwYjdDMVUvVFQ0RFJsREpkTkRWcHdnMS8zQ3BQejNZaE5S?=
 =?utf-8?B?OFFFdUpIYUNqYWQ4TXZyZkFET1ZwWUNhdytTbnRFWURBbFJLMGt2Ty9MRDc3?=
 =?utf-8?B?ODFsM3YwaTBCZ21OMzNMVXh0RlRrZzF3Rmh3UzZhb3kwL1pmd1FVcTBPWlEw?=
 =?utf-8?B?c2ZvaU12dm5MM0YvWEJpcHE3ajlvcURGa21sMzc5ek5FVnU3UjdRUkxsdDJN?=
 =?utf-8?B?NlpGSVpvSUhjU2V2RkpoYVhOQXhNeTMrVTdCaWR1V0xkb0FyOXgwVHdQeTFs?=
 =?utf-8?B?NlFVaWpyM3owWVZoQS9jUmlKN1hndllWTzE0cFpYZ3Y5emJTbXhLbWpJVUlB?=
 =?utf-8?B?UWdRbWlRMU80Y0pzVnhlTVBkSGNZeXdhWDlaZ1Z5dEo1d0JZOXBtRXJEcllo?=
 =?utf-8?B?UnlqNVNZUTZlc0IvUW5OTFdFZUVXSUF4Rkk3ZE1SbVNHaGJsU0RmZis5ZERj?=
 =?utf-8?Q?dTP4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB3289.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868edbe9-0790-4588-1248-08dcdd602090
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 12:46:51.2443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C7wEwapukMtu6d+4rpeGu7+0gJLAO9Kmo2fJnJVdgLZU/K9UKArnLaECZ3u4tVOQcYLbcsIFIwG8wn28wWvvLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3533
X-Proofpoint-GUID: WCK1oz_R2fr_Xoo7JTaAP6_G09BtNoyg
X-Proofpoint-ORIG-GUID: WCK1oz_R2fr_Xoo7JTaAP6_G09BtNoyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVyIFN2ZXJk
bGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIFNl
cHRlbWJlciAyNSwgMjAyNCAyOjQ5IFBNDQo+IFRvOiBBbnNodW1hbGkgR2F1ciA8YWdhdXJAbWFy
dmVsbC5jb20+OyBjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbTsNCj4gdWxmLmhhbnNzb25AbGlu
YXJvLm9yZzsgYXJuZEBhcm5kYi5kZTsgbGludXMud2FsbGVpakBsaW5hcm8ub3JnOw0KPiBuaWtp
dGEuc2h1YmluQG1hcXVlZmVsLm1lOyB2a291bEBrZXJuZWwub3JnOyBjeXlAY3l5c2VsZi5uYW1l
Ow0KPiBrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IFN1bmlsIEtvdnZ1cmkNCj4gR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80XSBzb2M6IG1hcnZlbGw6IHJ2dS1wZjogSGFuZGxl
IGZ1bmN0aW9uIGxldmVsDQo+IHJlc2V0IChGTFIpIElSUXMgZm9yIFZGcw0KPiANCj4gSGkgQW5z
aHVtYWxpISBPbiBXZWQsIDIwMjQtMDktMjUgYXQgMDk64oCKMTMgKzAwMDAsIEFuc2h1bWFsaSBH
YXVyIHdyb3RlOiA+ID4gPg0KPiArc3RhdGljIGlycXJldHVybl90IHJ2dV9nZW5fcGZfbWVfaW50
cl9oYW5kbGVyKGludCBpcnEsIHZvaWQgKnBmX2lycSkgPiA+ID4gK3sgPiA+ID4NCj4gKyBzdHJ1
Y3QgZ2VuX3BmX2RldiAqcGZkZXYgPSAoc3RydWN0IGdlbl9wZl9kZXYgKilwZl9pcnE7DQo+IEhp
IEFuc2h1bWFsaSENCj4gDQo+IE9uIFdlZCwgMjAyNC0wOS0yNSBhdCAwOToxMyArMDAwMCwgQW5z
aHVtYWxpIEdhdXIgd3JvdGU6DQo+ID4gPiA+ICtzdGF0aWMgaXJxcmV0dXJuX3QgcnZ1X2dlbl9w
Zl9tZV9pbnRyX2hhbmRsZXIoaW50IGlycSwgdm9pZA0KPiA+ID4gPiArKnBmX2lycSkgew0KPiA+
ID4gPiArCXN0cnVjdCBnZW5fcGZfZGV2ICpwZmRldiA9IChzdHJ1Y3QgZ2VuX3BmX2RldiAqKXBm
X2lycTsNCj4gPiA+ID4gKwlpbnQgdmYsIHJlZywgbnVtX3JlZyA9IDE7DQo+ID4gPiA+ICsJdTY0
IGludHI7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlpZiAocGZkZXYtPnRvdGFsX3ZmcyA+IDY0KQ0K
PiA+ID4gPiArCQludW1fcmVnID0gMjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWZvciAocmVnID0g
MDsgcmVnIDwgbnVtX3JlZzsgcmVnKyspIHsNCj4gPiA+ID4gKwkJaW50ciA9IHJlYWRxKHBmZGV2
LT5yZWdfYmFzZSArIFJWVV9QRl9WRk1FX0lOVFgocmVnKSk7DQo+ID4gPiA+ICsJCWlmICghaW50
cikNCj4gPiA+ID4gKwkJCWNvbnRpbnVlOw0KPiA+ID4gPiArCQlmb3IgKHZmID0gMDsgdmYgPCA2
NDsgdmYrKykgew0KPiA+ID4gPiArCQkJaWYgKCEoaW50ciAmIEJJVF9VTEwodmYpKSkNCj4gPiA+
ID4gKwkJCQljb250aW51ZTsNCj4gPiA+ID4gKwkJCS8qIGNsZWFyIHRycGVuZCBiaXQgKi8NCj4g
PiA+ID4gKwkJCXdyaXRlcShCSVRfVUxMKHZmKSwgcGZkZXYtPnJlZ19iYXNlICsNCj4gPiA+IFJW
VV9QRl9WRlRSUEVORFgocmVnKSk7DQo+ID4gPiA+ICsJCQkvKiBjbGVhciBpbnRlcnJ1cHQgKi8N
Cj4gPiA+ID4gKwkJCXdyaXRlcShCSVRfVUxMKHZmKSwgcGZkZXYtPnJlZ19iYXNlICsNCj4gPiA+
IFJWVV9QRl9WRk1FX0lOVFgocmVnKSk7DQo+ID4gPiA+ICsJCX0NCj4gPiA+ID4gKwl9DQo+ID4g
Pg0KPiA+ID4gU2hvdWxkIGFueXRoaW5nIGVsc2UgaGF2ZSBiZWVuIHBlcmZvcm1lZCBpbiB0aGUg
SVJRIGhhbmRsZXIgYmVzaWRlcw0KPiA+ID4gYWNrbm93bGVkZ2luZyB0aGUgSVJRIHJlcXVlc3Q/
DQo+ID4gPg0KPiA+IFdlIGFyZSBqdXN0IGFja25vd2xlZGdpbmcgdGhlIElSUSByZXF1ZXN0IGhl
cmUuDQo+IA0KPiBCdXQgd2hhdCdzIHRoZSBnb2FsIG9mIHJlcXVlc3RpbmcgdGhlIElSUSBpbiB0
aGUgZmlyc3QgcGxhY2UgdGhlbj8NCj4gDQpJbiB0aGlzIFBDSWUgTWFzdGVyIGVuYWJsZSBpbnRy
IGhhbmRsZXIgd2UgYXJlIGNsZWFyaW5nIHRoZSBQQ0kgVHJhbnNhY3Rpb24gcGVuZGluZyBiaXRz
IG9mIFBGVkYgZGV2aWNlcw0KdW50aWwgaXQgaXMgY2xlYXJlZCANClRoaXMgQVBJIGlzIGNhbGxl
ZCB3aGVuZXZlciB0aGUgZGV2aWNlIGdldHMgcmVzZXQuDQoNClRoYW5rcyBhbmQgUmVnYXJkcywN
CkFuc2h1bWFsaSBHYXVyDQo+IC0tDQo+IEFsZXhhbmRlciBTdmVyZGxpbi4NCg0K

