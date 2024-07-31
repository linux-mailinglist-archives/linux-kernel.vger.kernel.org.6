Return-Path: <linux-kernel+bounces-269091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54115942D77
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0732B285EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0591AD9F3;
	Wed, 31 Jul 2024 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iKZSf4jP"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2065.outbound.protection.outlook.com [40.107.255.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3681A8BE6;
	Wed, 31 Jul 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426558; cv=fail; b=IktNMFUIK/bhkx0w7+ZtOUXNhkkF9bShIWUlsX3YmaKbeibyWmJtb2P/RflhuUcOx1ULmqn+YWeEluYO5oWmi3Obx43pkw4z3kCzJhD32pD6G90jCc5+lXjeWpQ23J95eRwBMh7PISFaWqFiTDp5HMIowupvZDRhNj6WgleVwLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426558; c=relaxed/simple;
	bh=JRarj0BFR6m01sisJExv46Skkp/UMRV3P8jZ7bTykrU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PHVLS9a9tFYF9cDKOaB8n1m43Wu79J/OJja0kRT3hUBf19xFOZP7t/UWoJRkh0NYdVkIUbUGH4yBpQw6NjH7uL6/o5WHdMxE1pmjDznqOFB9VhvYDkiSjU5udODENbp/3X2nkRtV3SAbcc0a8VUgQQWBj70SQwbDdPpwdQvxPPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iKZSf4jP; arc=fail smtp.client-ip=40.107.255.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xN9RaLUZIPdm9cOscLZRA62FmsgEgurXgHXVsrjKOv8wfNTq/hoplooWDkTBbk4sAaacE4/JEFbEExWkrIkUCmM+gc6mVA+xGgmseyP5ebFjvkFBB1vg9aIyQXtH5UT9yXqAtsNoydgSoGIbIJK3ggYGrEkLrqKJ0eIgbbACNyPZCqIt7zej5NV5gk83fvGWYFgWcsNOTtikmhq0cW056iSzR01/TmshPmDVaH40s0r/rcgBYJGCuSYA9QMGuQtO1YePMDDv97aobzPIl7ISOLlHzwwPwRycdeMzTvY7sMtVgXyp8/XV37NfsD3RzY5gZuwHh5BxcastmAnjzv0OiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRarj0BFR6m01sisJExv46Skkp/UMRV3P8jZ7bTykrU=;
 b=bUaiRgWMym8Bh5L70iahgXCG35WL1boj1O2/TvRU7ED0cEu6/2DFT7xQhZ1Px4bB46B5lV+TjRr0L1TwzMga3Ld3ZZwQHNz1LlFvh2h9bZnIdqNLlrNY8hqNmAxBxt0vQOtWR0xn9c8LLbv8KVX3G7J0pCmybDIi/cBYeu0P7oLDZuj/Hdwrac6QEorBUtU7W8sHYfICm+eyy+qkb9fOOoGQe6EKzqL7j+qtli2VwzcnsOXVUci2s4OrHO89DJTnPeWgGOsFX7VJ4XfpgJxdx20XQDj1f28nw1xARJgW6XZU4NY82kwqXtXjL+LqHVtTfGcGBujVzmGfLku6mPX+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRarj0BFR6m01sisJExv46Skkp/UMRV3P8jZ7bTykrU=;
 b=iKZSf4jP6XoGLtjrMx9dD8yY9I8DLR2eX8oTjvH1ONfepGKeslRMqeaoDZbMKntd1cTu1KehhItaNfmkxoPoxuNmi/nir6Yn4BolIQMuJHN3sUgQPUqAPnkArx+bV5LsvUunvjmeCrT4GeD7fY7AMNqHcZ6bTN0bicX0zhlulWmDFUHWU3XkcHD2skzKodTvZd9ET/Gn2h5LCiYsEZJSEyE4s1xipzklQk+RE78K9r1VxTEyrPS14ApLPc3kCUEHP3fTYssnOPLKrkQkg+ot6xtXUMkdAh6gah/8DCrsRwy1+onvLlvAYKTVHb2QiC8v7uZHg2o1EBi6X1LAO8l9cA==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by KL1PR06MB6473.apcprd06.prod.outlook.com (2603:1096:820:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 11:49:12 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 11:49:12 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIHVzYjogZ2FkZ2V0OiB1dmM6IEZpeGVzIHRo?=
 =?utf-8?B?ZSBhYm5vcm1hbCBlbnVtZXJhdGlvbiBwcm9ibGVtIG9mIG1vYmlsZSBwaG9u?=
 =?utf-8?Q?e_as_UVC_camera.?=
Thread-Topic: [PATCH v2] usb: gadget: uvc: Fixes the abnormal enumeration
 problem of mobile phone as UVC camera.
Thread-Index: AdrjPy5L8mvqthR7TX6KWxl0Ter/Kw==
Date: Wed, 31 Jul 2024 11:49:11 +0000
Message-ID:
 <TYUPR06MB62175899DECC7A9B0DA0DF01D2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|KL1PR06MB6473:EE_
x-ms-office365-filtering-correlation-id: ac38e28d-c586-468f-e10d-08dcb156cb87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzFmWUdZak1KdG85MjJYak5jM1YvUnRNV2RtUFZlczBVQVlRK3VzOUlJeHJi?=
 =?utf-8?B?RjdybHhabjFjQWxoMUhzNk4waVpIRnJWQVlxM2pzT0c2Z0ExUnFaR2U3elFD?=
 =?utf-8?B?RkhGcmV2MzlrMlVUTGxWUklaVUFrbk5XUEEwSGttYjIzQWtZU2czTml0VkZp?=
 =?utf-8?B?TEh6cXJvR2RSY0l4OGVEcUpMWStSQlNHWTJ1OWNud2FyV0JjUnpIemJDSkUy?=
 =?utf-8?B?RytQbEFRWEF4WllZaTVlYm1mN28wT2RVdjN2S2lraDZMWUQ1ajBLYzl3cTYz?=
 =?utf-8?B?WjNRaUg1UjV4aHV1b2t4SnVicHhXY2lJOWlpRzVHcW91bk1McFZEdWZPcFBL?=
 =?utf-8?B?dlpubzRlWGMzd2J5anMxVHJJYmVmNkhxNVJvd3ZVczFnOW5UQmlaSkxBQ3hv?=
 =?utf-8?B?SytubXFsSEpUbHBwVnZDL1NGT3pncHQwcGNWRFJ0T0JjUUZDUjJKTVhOcGtZ?=
 =?utf-8?B?WHZMaHh2NzJTL1R6N0N5Q09JQmgzNFc1QWRFRlV6bE1WdjViS043NVI1MFVu?=
 =?utf-8?B?ZGZ4c0FTOFJ3NXloaDhUVE53dzhiRUJ1MHZHcmVxS0hMOG11TEM4VXc2Snh5?=
 =?utf-8?B?ekJrVkFNZkt5Tk9abjVvRituaEZmV1RQTG9OQi9YMmN0YkZqUUZIa1RBVzNW?=
 =?utf-8?B?SUQ4QThTZlhhRXJ5LzVVT1IwOEQxa1B1L1R4YUsrb2JMK1BEcTFFNHVVcnIr?=
 =?utf-8?B?TDJlT2hmSG9ZdGhXYWNKakdFcjFGQU9MSkN0a2hWNlpJRWdRTUtzTWZNMjJX?=
 =?utf-8?B?dWl0bmR4WEh6T0hIZGFJaXJYbHdMRExXMWp1dENXYlZPWnhZa1RGZFhKZE0v?=
 =?utf-8?B?L2s2bk8yNmJOVXlFN3RxWXVuQ2lwdVhCZjh2RTBxY3pmTUdVbk1LNDVDNlFq?=
 =?utf-8?B?V0t5NG04OVlGenVscERuSEEvSEVFYkhzNWhnazhpWktZYzc3Rkd4Q2x3NkZr?=
 =?utf-8?B?R210OE1Fa0Y4WkNMZ1Z4OTdUb2ROV3A5ODBaYkFjSEg4bXBma3FTZnN3a3Vl?=
 =?utf-8?B?RVRhUGYzKzVqZUY3c0NnTE9sNVdLQk01RXF6Z2hYQ21WRFM4Y0tnNkVZNXRa?=
 =?utf-8?B?b1JrT0Mvb1lVbnlsM1JRaWxtaFFlMmJ6MTBYMXFRZ1dWNzlrQkN2YXlUY3pO?=
 =?utf-8?B?bWRLUEJkN2FPWGJnc3dwZnBRb2tiRXhicFFiL3VWdmpjRTBpbk5nN2VvMFFK?=
 =?utf-8?B?TmtJTGc2WXl1QWRCTUFUVmdTb09KZThWZVQ3K1FNdnhqYmFJRDVhMTE5aGpB?=
 =?utf-8?B?NHc3d3d0dzZxdHMyQS8yUlA1ekxoRDBLRXZxTXJGYTNTMTJYOXBKMWRvaHd5?=
 =?utf-8?B?cFBCRmJ2OUlBd2EwVCtCWU91MnpwUmhaSVRHZ2Q1NHRpVGtnQTVnOHB6MFBm?=
 =?utf-8?B?QXdaWDNWMW9jV0VhVkt6MjVhM21BRXBPSmd0blhRUTkrUzNFUDVsckVubzQw?=
 =?utf-8?B?UkIvd0h0T0ZpQXNuajVpcjVUTGR3NkpXY1M1MnRacVBMenlWV0UwcENOeVJm?=
 =?utf-8?B?SmFmMUhSSW5qYXptQ082b09vTWxEN1F3Mzk5L2x6MCthbUk4UHEvdXk3Vmox?=
 =?utf-8?B?YURYWWM5MGJkZU0ralRvb29jSnB5bGZKdlVUMFB1UU9JUmFESG5tQk4xU2tk?=
 =?utf-8?B?SmZ4UGhXRDJxc2hGazFBZkxMRHhPM29aQ3hjL3FUQnlBcHBLMURwdUtmZ3Ix?=
 =?utf-8?B?SUpFd3lvNDFBRk1tVnA5VldmWlkwNGZCRXlJdEFRc0FKMGpxWXd0RW1RNU4x?=
 =?utf-8?B?ZEtDOCtQbENxWGdHVk04NUgvTEYwZHVxSEZ1TU9RV2ZHVDhmWVZzNDhTcWVl?=
 =?utf-8?B?bWpFNjRmUFBQYktMTUdqTHZQaU4wRjNjajRmQVJjSGd2ZmZUZk44MmwwK0pw?=
 =?utf-8?B?NVlnY0dwTWdRenU0TVgwOGRCa1VaVnpWSERZd1RGNFUxckE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2FkVWRhbkxucGN4UmZHdFdqQ0NkeUV3T0tEN2pvTXBmNlBNcGtoTlZlSHFW?=
 =?utf-8?B?UkhiZDVMTVdhTk82ekk4TUpRUzVpRzdRQWl0WkR0Y1dRRHVNbHJxYnBMa2s3?=
 =?utf-8?B?ejBsMSs4S3I2K1N5Q2lRNWhnUDN5clRKVzZtZk5BcjFVa1ZiTmVjK1FPYlE5?=
 =?utf-8?B?Z0FnOS9tMTN3SVZUSzNhMDRIejJUb04vRC95ZXJ6TzY3cndYOXhWM0pleStO?=
 =?utf-8?B?YkJtVU1IOU42RVZmbXg2SUdtUlFCWkxqMWpYU2RqZ2xUVkVGOVZyZUpiN01O?=
 =?utf-8?B?Y0xTcXlPbUJYVXpBYTlmbTA1SkZRNGlkU3B3YmxBSDdaVWswWGtlUk9ta0Y1?=
 =?utf-8?B?RkRyczF3SGxEMEtvYUFMSENMK2ttbEluUm9PU2xkazUwSFBIbnpzbll6a2pD?=
 =?utf-8?B?ZmpmaW5TV2lhTDJ0WUVpcW45VllCdGszZVRHTjcrZDB4dktUaU5CSzhIa2Yz?=
 =?utf-8?B?b0tUV25XN3FWZVlkckVZOUh3MlRySnNpNDY2d3pjWmptbUdiZ0lJN2lMdklS?=
 =?utf-8?B?aUV4bmFNUTlJeHBYRzNqWUNwblZ0N1VMV21ObjFZMEwvTkVMbTZNdDM0d0NO?=
 =?utf-8?B?Q3N1V1Q0MjJ6ZHhlVDBIZVVDK3h1S0lSbEI4bFZyWmlzYld1dkZDTEdZUzQ5?=
 =?utf-8?B?R2VoUUkxU0d5SThmaUhpdkVJdE1ZWUV1aENDYjAxTEZ1RU02bnRXNFk1QUx4?=
 =?utf-8?B?U3FzVnh5K1RJNkhhUWgvKzV5cWowN1ZVbXZkK1pzemh0eDgvUWFhZTU5S0w1?=
 =?utf-8?B?U1BTMHZyV3RXcnBOZHBETHd5L2wwUE9YRFZTZDJUQUlONm01NTVLZS9EK2I2?=
 =?utf-8?B?YWtpNll2QTBZd083VXpUdFJCcGxYR0RCeVhHek9XU2NWeURzdlQvSGljc250?=
 =?utf-8?B?N0ZUUE9kVjBPUXZFaWZteUMreWNmUmtvRkVpNkk0bk80Y255VUNRbEdZR3lr?=
 =?utf-8?B?UVNBSS9ncndXaFovS1ZWcm91Rlc3SXB3aHg2ekIwckE2R2xxZzIzVkFpZ0tG?=
 =?utf-8?B?dFJhNy9GNFFNLzc4a2YyQ2Q3R2M2Y3RYSVppS2NwOW9ROTdmUU1QMTNvbkRY?=
 =?utf-8?B?M1VJWTJ6dHJrUVVzMmxUemIxQWFab0NUNkJLZkgrb0VnVHlaMU9KUVZ0SkhU?=
 =?utf-8?B?eWhQVjQyN3FkQ2wwMEpwNkR2ZDNJa1c4aTJkVlBmWXdZOFFsWlFJMi8xSmNn?=
 =?utf-8?B?cVhQUDZHdml6aWVmQkZwQytUUjlJSlpSOGJJNEVOTmFaQUhSYTZmeWNQR3ll?=
 =?utf-8?B?OTRoRUN2enVmVW01czZ3QTY5TGdPM0pkM2tOSWk0cU8ycWFBNGQvYzQ3dnRO?=
 =?utf-8?B?T1pheW1wQ0NraEMvRjZoUDNpbEdqbStuVUZtRHJ3emJ5TS9DTU51QTlMOVBW?=
 =?utf-8?B?dGpxRXdlMGxkWERKZ1RCazNlZWdXVmtNRUxUQkxlMzMySDg5ODhKYzdUZ1lJ?=
 =?utf-8?B?aTVTeTlrRDgxcEFxRTh1QlArNnBDZ0g0R1NPUEN5bFVSRU5PQVlYbEtubkd3?=
 =?utf-8?B?bUo2eFB6U1FBdkZUYmZnbjUyTElXZmhBNnlXQVRGTGtOSXNWL3d4YjFETXND?=
 =?utf-8?B?b09obk85b2ZtTTZmb2xycmQwRXZyTUtXcDVRK0hxRS9OeUF3TEE5R0Q0b1Bz?=
 =?utf-8?B?VEo3L29UaDhNdHBzUjhhYTQ2K1NLd21QT2ovVUJ4b1ZBTUNTb1RaSUlKSW0x?=
 =?utf-8?B?NzVYT0ptOTByM3ZXRHk4ZWFBajRvVE9UUzBVVVpKTlU1bzkycFhMVkIwaVJD?=
 =?utf-8?B?S3FMTkJKOHp6ZmcwUXNBVVNXSGlxVjdWNzQ2aHVhaDJHek96SkhwMkpZZ1BP?=
 =?utf-8?B?ek1KYzZLaGFQY1diZTVsN2d1aVVrU0NiWFdUZjluMnd5dWdQUFlWKzAzUi9t?=
 =?utf-8?B?eDhlakc1ZG5TdUtNaWNQczl5bkdNWEZsRi9ZNnprMzk3WDR1UG1qRnB2d09y?=
 =?utf-8?B?d3pvUlhxSkxlc1ZwUCtwaFBFekR4VzZSbTc3SThqVkdzTTEzUmNham5aaGFj?=
 =?utf-8?B?ZFptOE9JVzRQQ2hhQUlKc3kxVEJ2b0x0YXUrL3hjeWY0OTZDZWRlYjgwbThY?=
 =?utf-8?B?b2wxT21oUUYyOHlHc2kzbW10VDhqOUNhMnNsOXArcHFzMWV1SGZEZEFnb3Yz?=
 =?utf-8?Q?hr5o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ac38e28d-c586-468f-e10d-08dcb156cb87
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 11:49:11.9248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPIUpaHSTpRuGzfQfQVc2etxBGOPxhZqOQF4WoXAwA48W40UdbYpYFg4tMC9pUtEd0b8xDswSgJzJ9c7b8Yr1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6473

V2hlbiB0aGUgcGhvbmUgaXMgY29ubmVjdGVkIHRvIHRoZSBjb21wdXRlciB0byB1c2UgdGhlIHdl
YmNhbSBmdW5jdGlvbiwgDQp0aGUgcGhvbmUgbmVlZHMgdG8gYmUgZW51bWVyYXRlZCBhcyBhIHV2
YyBjYW1lcmEgZnVuY3Rpb24uDQoNCkJlY2F1c2UgdXZjLT5mdW5jLmJpbmRfZGVhY3RpdmF0ZWQg
aXMgY29uZmlndXJlZCBhcyB0cnVlIGluIHRoZSBmX3V2YyANCmRyaXZlciB1dmNfYWxsb2MgZnVu
Y3Rpb24sIHRoZSB1c2JfZ2FkZ2V0X2RlYWN0aXZhdGUgZnVuY3Rpb24gaXMgY2FsbGVkIA0KZHVy
aW5nIHRoZSBleGVjdXRpb24gb2YgdGhlIGNvbmZpZ2ZzX2NvbXBvc2l0ZV9iaW5kIGZ1bmN0aW9u
IHRvIA0Kc2V0IGdhZGdldC0+ZGVhY3RpdmF0ZWQgdG8gdHJ1ZSwgd2hpY2ggaW4gdHVybiBjYXVz
ZXMgdGhlIA0KdXNiX2dhZGdldF9jb25uZWN0X2xvY2tlZCBmdW5jdGlvbiB0byBmYWlsIHRvIGNh
bGwgdGhlIGNvcnJlc3BvbmRpbmcgDQpjb250cm9sbGVyIHB1bGx1cCBvcGVyYXRpb24gKHN1Y2gg
YXM6IGR3YzNfZ2FkZ2V0X3B1bGx1cCwgDQptdHUzX2dhZGdldF9wdWxsdXApLCBhbmQgdGhlIFVT
QiBjYW5ub3QgYmUgZW51bWVyYXRlZCANCm5vcm1hbGx5IHVuZGVyIHRoZSB1dmMgZnVuY3Rpb24g
Y29tYmluYXRpb24uDQoNCkFmdGVyIGFwcGx5aW5nIHRoaXMgcGF0Y2gsIHdlIG1lYXN1cmVkIHRo
YXQgdW5kZXIgdGhlIHV2YyBmdW5jdGlvbiwgDQp0aGUgZHdjMyBjb250cm9sbGVyIGFuZCB0aGUg
bXR1MyBjb250cm9sbGVyIGNhbiBiZSBlbnVtZXJhdGVkIG5vcm1hbGx5LCANCmFuZCB0aGUgd2Vi
Y2FtIGZ1bmN0aW9uIGlzIG5vcm1hbC4NCg0KRml4ZXMgdGhpcyBieSByZW1vdmluZyB0aGUgc2V0
dGluZyBvZiB1dmMtPmZ1bmMuYmluZF9kZWFjdGl2YXRlZCB0byB0cnVlLg0KDQpTaWduZWQtb2Zm
LWJ5OiBMaWFucWluIEh1IDxodWxpYW5xaW5Adml2by5jb20+DQotLS0NCnYyOg0KICAtIEFkZCAi
Rml4ZXM6IiB0YWcgb24gdGhlIGNvbW1pdA0KICAtIE1vZGlmeSBkZXNjcmlwdGlvbiBpbmZvcm1h
dGlvbi4NCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jIHwgMSAtDQog
MSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2Zf
dXZjLmMNCmluZGV4IDQwMTg3YjcxMTJlNy4uNmQ2M2JlYTE0MjExIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdl
dC9mdW5jdGlvbi9mX3V2Yy5jDQpAQCAtMTEwNyw3ICsxMTA3LDYgQEAgc3RhdGljIHN0cnVjdCB1
c2JfZnVuY3Rpb24gKnV2Y19hbGxvYyhzdHJ1Y3QgdXNiX2Z1bmN0aW9uX2luc3RhbmNlICpmaSkN
CiAJdXZjLT5mdW5jLmRpc2FibGUgPSB1dmNfZnVuY3Rpb25fZGlzYWJsZTsNCiAJdXZjLT5mdW5j
LnNldHVwID0gdXZjX2Z1bmN0aW9uX3NldHVwOw0KIAl1dmMtPmZ1bmMuZnJlZV9mdW5jID0gdXZj
X2ZyZWU7DQotCXV2Yy0+ZnVuYy5iaW5kX2RlYWN0aXZhdGVkID0gdHJ1ZTsNCiANCiAJcmV0dXJu
ICZ1dmMtPmZ1bmM7DQogDQotLSANCjIuMzkuMA0KDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0N
CuWPkeS7tuS6ujogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPiANCuWPkemAgeaXtumXtDogMjAyNOW5tDfmnIgzMeaXpSAxOToxMw0K5pS25Lu2
5Lq6OiDog6Hov57li6QgPGh1bGlhbnFpbkB2aXZvLmNvbT4NCuaKhOmAgTogYWtwbUBsaW51eC1m
b3VuZGF0aW9uLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgb3BlbnNvdXJjZS5r
ZXJuZWwgPG9wZW5zb3VyY2Uua2VybmVsQHZpdm8uY29tPg0K5Li76aKYOiBSZTogW1BBVENIIHYx
XSB1c2I6IGdhZGdldDogdXZjOiBGaXhlZCB0aGUgYWJub3JtYWwgZW51bWVyYXRpb24gcHJvYmxl
bSBvZiBtb2JpbGUgcGhvbmUgYXMgVVZDIGNhbWVyYS4NCg0KT24gV2VkLCBKdWwgMzEsIDIwMjQg
YXQgMDg6NDU6MzFBTSArMDAwMCwg6IOh6L+e5YukIHdyb3RlOg0KPiBXaGVuIHRoZSBwaG9uZSBp
cyBjb25uZWN0ZWQgdG8gdGhlIGNvbXB1dGVyIHRvIHVzZSB0aGUgd2ViY2FtIA0KPiBmdW5jdGlv
biwgdGhlIHBob25lIG5lZWRzIHRvIGJlIGVudW1lcmF0ZWQgYXMgYSB1dmMgY2FtZXJhIGZ1bmN0
aW9uLg0KDQo8c25pcD4NCg0KTm90ZSwgd2h5IGFyZW4ndCB5b3UgdXNpbmcgc2NyaXB0cy9nZXRf
bWFpbnRhaW5lci5wbCB0byBmaW5kIHRoZSBwcm9wZXIgbWFpbGluZyBsaXN0IGFuZCBkZXZlbG9w
ZXJzIGZvciB0aGlzIGNoYW5nZT8gIFBsZWFzZSBkbyBzby4NCg0KdGhhbmtzLA0KDQpncmVnIGst
aA0K

