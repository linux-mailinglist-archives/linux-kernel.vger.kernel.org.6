Return-Path: <linux-kernel+bounces-576154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C12A70BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A274D175EED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E33526658E;
	Tue, 25 Mar 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QNRNl9Qd"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0E81A5B88
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935680; cv=fail; b=r36+zC/fmxddFy796LDH9p/IaQEcLgKQ2xZAEC2qb+ilJITUwoCRShDoGtpftNVeOqHYgacc5AVX/zC+HnQY/tJGh73jOM13Lo3tverFgQZI673/SiAFsZ01OYzFKs8gzXIEm5OcmNv0xOc/zEn2qVJgu+3Z5ffU0u9oHr5ecL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935680; c=relaxed/simple;
	bh=3duZDowmKaK9vq8h6e5GtQzxFRLjofmClN7ISU6IqXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=WlxJ7H/FFFavUmSEt+WL91WP8wPCEEG3DgEkKlUnRGXKTe90IgoCRNETdbXfuqskILzuEB1HdfOe+b3WBG5FwCIzvx+A90OsHS+QmMvhIXIAnnX9tJp9CEfdDvn9zgncBofxY207hGBvS49s/zMp8JVpPjDC2hNTH7LTMwefI9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QNRNl9Qd; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PKfNxv025949
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:47:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=3duZDowmKaK9vq8h6e5GtQzxFRLjofmClN7ISU6IqXI=; b=
	QNRNl9QdzoDiTU7J1xTxhIVU6JzGeIla0W5mJv91AU/C4pi5CwWSi13kLufT3Lzz
	Inm3F9VsIcr5d/EzLU8MHA77GmUQL8bD96BIw/BR3864I5/GnczzS4CpsoHV/5ig
	jh9Grj6t4rFqeGY1haelBS0zu2Mf0FfiqMlgxOKeXugdKxBRSeUgK9aTKjXAlM1v
	RKWBff13seR4d4R4Ji2Bi6p/q9Hx2GUrgqHZsNWGhSlQGpjM3vUpCjZeypOKI1dM
	W59hYJocH6l1ihEhdVDIXFjxYNldrt4kuTOzC1Hww/B46RlUTZYiWZOuBBV54oYd
	3y4lmhQMZvSzAuVQaBaeTQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45ky76tsw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGnCDw44zJkYtir2AwwyODiFNzA5PPxEa2wpPy5MFvToIyEquRzEMfqYoMUSgy+jVj2DyU7l4YUL5RuLAg7LefI1Rulk/boCxX5A6oHCXHtkfu02aTamCsx9bj/L/stiZu0y2I+2VBkhWqHec6Nrr2HoHigUDYdcKF0tuo4jBB9fbGNTgkaC0Xt/TCxcIKtO+gDNKhe+GqshFMhOXt4qeJPjLqzCHTRX4o1puRuVG/0L5rWsnQbopwiw4ZAVdK8GCaDHyYX1Zwd1f6F5nJu3O4N6fCGaUCDXKVWmyTQuScdpRLCPfI/WqFX9t5VhFLvS4tx0+Eab2TXS6u4Z05On6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebNaU1RbJyfJlCowea5e9GbUdtmnFhgXOT3O3UfiR/w=;
 b=kLjME2szXAI5tUIvlUHgvNMMAjgaPFc11KYyqNqItFM+m27VK6W/RYflJwmSxXtDIokxsK/LI5VVGCPQownXRdQm6Yx30HHYz6eEf2hh53QMRdsgN+d7SoADcbsaiiLD4PC5VHZZHoxi6yQNzkY6MUc53WvFmDxIcNjKUCo8oFDIqFDTmcTOOhd66GEQIBNBazHCJWIDRuZ7h8fnQJZGcB31CuL9XDO66Xo1Y3tMtA/tWXUokWNGZAjFpkaCSAar7EJI55yNBafOjQXR7B1go6JaDQcVV8p4GnhOGXi0BqaNyGo+nYYqhoXIJrg5boQD1W0y+ynfaSGq1LTG6tb1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by SN7PR15MB4160.namprd15.prod.outlook.com (2603:10b6:806:10e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 20:47:52 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981%5]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 20:47:51 +0000
From: Nick Terrell <terrelln@meta.com>
To: Ingo Molnar <mingo@kernel.org>
CC: Michael Kelley <mhklinux@outlook.com>, Ard Biesheuvel <ardb@kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "brgerst@gmail.com"
	<brgerst@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: Compile problems w/gcc 9.4.0 in linux-next
Thread-Topic: Compile problems w/gcc 9.4.0 in linux-next
Thread-Index:
 AduZw3CVEeBLGArOR7mAlPxdXuU1qQACZlCAAALC4gAAArDlMAAUVscAAA/WCVAABhwAAAC40zaAABX3Z4A=
Date: Tue, 25 Mar 2025 20:47:51 +0000
Message-ID: <9B7AFB33-E930-44F4-B5AE-1414B3E9A56A@meta.com>
References:
 <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
 <SN6PR02MB415765C109AF9820DDC3AF0FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41575C4BA0C467B1C95EEB21D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z90XZqJVwuWkarnX@gmail.com>
 <SN6PR02MB4157E2AC0708EB2074302E6FD4DB2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <323A7651-9BD8-4C8B-8784-8C9DAEF5FC88@meta.com> <Z-KDA-yFUuNM6PSx@gmail.com>
In-Reply-To: <Z-KDA-yFUuNM6PSx@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR15MB4732:EE_|SN7PR15MB4160:EE_
x-ms-office365-filtering-correlation-id: 3dcf8e6d-2c36-4d49-388f-08dd6bde4fa2
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUNoZEwxMzdsakNSWks1K2h1UFNFbkJFUjJFZTAzWVQ4eFE0MTY2SGZhZ3VU?=
 =?utf-8?B?SHNHNzQxRzR0S3VnYkpEK0pYRk1XMG54UkdWZ09OQ2Y5MW9wdkdPcEZHVVpD?=
 =?utf-8?B?ekw5SkFxakNkcTNCaWZWRTRHa2htb1hsRWtoWXJHcVpoeUdtU1R1NXRadzYz?=
 =?utf-8?B?NC8zNDZSR2pyWTJnR3NrSWFQRmhkY1JOOUhwWUYyNllHT25CK2lJV21sODZM?=
 =?utf-8?B?MGR3UjNEVHdGUWMwbW5CUkhtT0xhdlVjQ3hmb2dzN1d1bTRJUXB2S3NFVzRx?=
 =?utf-8?B?Uk9IbHVCbVF5eEJXQTdDMHVWcXY5WGw2SHg2R1VnbEdWbzVsSVJGVExKUTVa?=
 =?utf-8?B?VnRSaUFYRmJSSGY4VnVZcTFtNkJ1WDFFWkZ0UitmZm03bWdiRDNPbS9xVndn?=
 =?utf-8?B?ZkJET3pDbnN4c0xzNW10M0RtWG5sOU1tcEd3T3JUbmRuRjJ2MHhBNHpWTTRj?=
 =?utf-8?B?R0RtSmkrTnZ1V29pdGRnSUlkc0VtZFRzU0lRMUFLL2JOU0VISTZ5Vlp2U2M3?=
 =?utf-8?B?TTBJbWZidkIvUVV2Qjg0eVFPbVBpM2JCdG5XUGNFRWZ5Z0RjV09UU21xSDdK?=
 =?utf-8?B?d0xjdU1oUmVadXpxSTAwSzNYWXVTN1lTUmViSGp4ZENtaVBIcENYUldQVFBX?=
 =?utf-8?B?SUZQUk02bGtnSFFjeDFlV3hFT3ZqS09IMXdtTytYVDZrcGUycXFOSlZNdllH?=
 =?utf-8?B?RW00UHJ5TEdHS3QzUVBIc09xa3EwNHdNSVBZcEU4akdZN0pVWmliZnl0bWtm?=
 =?utf-8?B?RDhzbkpIcm5kY2hEejBxWGdTVmxJS3JBK21WM1kvSXd4UWhOanFUT1NXYStv?=
 =?utf-8?B?dUpLc3pQRHJYbnlFdmltOUZxQmZoUk81cXUxTmloc3Qrb05xN3RsdkdHWkNu?=
 =?utf-8?B?NkpsZnR5cXczUHAvU0xpZThSbEJ6TkxjakVrMGxEVmRoQk51OW5RU3hzK2c5?=
 =?utf-8?B?ODhKQW5JN0xpcU9sSXN4L1IvMjUwbzUvRlNUNTcxbmFhWmlNeHhtSXRhYnI1?=
 =?utf-8?B?NDRaTDczRGdKdjJ3aWF5a1V0Q01LUzVIcncyL2h1QjlYUE9OdU43WEpFT1dI?=
 =?utf-8?B?Q095c2kzK3J1YUk3Ykh3a1E3TFNOMWZIdFArU0NIY0lTSTdNN0RBcEdqOTVv?=
 =?utf-8?B?T21KNGcxdkczYXlPV2kvSWYyWVpvUzllc1JKQzdLYlRmQzZTQm52bFVhdVZV?=
 =?utf-8?B?WElHcXd5WEtLaUw2WE9nUFJ4Y2RZa1JMd2NpMjA5dG5tY0czbVlZbytDcXdJ?=
 =?utf-8?B?R1RjbnJmY3lsa3dPMnFUZkhxQVBDTWlFQmVGY0RuY1MwRklYRWNuTjY3dmY2?=
 =?utf-8?B?YXRZZEFVNkNQNmwxbWFJSEJudURvemZtcDdJeFRBQTVJRGtWeFBnSXdHL05V?=
 =?utf-8?B?dmFxWXdwa2kwc2pjQldBR1luajlNNEpYMTYyU1Bld21wZEtZU3o5R0tQNGVr?=
 =?utf-8?B?N1NvbkUyMFpncldnSFBQTm1oRVNLcGQvL2VudzRQdEtQNnpyYm5vZU1HOEJa?=
 =?utf-8?B?UEV3SU42eVllK0VwSkVaMWkwQmFIQXFnb0V1MTZRSkJuYTF1dDh3S2dwNHU4?=
 =?utf-8?B?U2ozaWZVMXJ6QWVDaDViSXNkZStOOWZMK2RabzExdVlaWEwvZFdMaWUwTllh?=
 =?utf-8?B?WEVVNlUzdXp5TnZuOEVIbzdLZjNPVFhsdDI1MUhqUVZESTQxN21zM0EvbEU1?=
 =?utf-8?B?VkYyV3FvckcxcStBUWpJU1hSVFJlWGR5bDhVOTBuTHlxUW4wOWhHd25ZcHVy?=
 =?utf-8?B?VW9wOURtSFVFT0s4bEZSVzJ3aEloWEpBd2VGUkdiWnRyaUIyQk51bGhYeEtG?=
 =?utf-8?B?OXFhMTluMVhnUmR6TWZUcHhpQ0VEZ08zZkpNViszSko2WmMyMVhtMW9qY0or?=
 =?utf-8?B?WDd1TDJJNU5sZS9Gc2cwTzhLZHBQR3VZa3FFVWFrdDVJK2pyWVV3NXdjNmxR?=
 =?utf-8?Q?Evk6z1Q5e8s8JHrtPtXGMWO6ghDdk8Qi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFZqK0d2YTJBMWJEQXJkbGVwNTZEV004Y0M2Z3c1RHp3T2lNajl5S1hVVk82?=
 =?utf-8?B?VlczMjZQQjFZOXNVd0FsQmwwcEpPblVwa1k4WFNkY3BpSlJzQVN6dHFsc0sr?=
 =?utf-8?B?dEhZNjM5R0lNZDNGMVZINWMvbUNGbjNES3BtN3V4eWdncE9JR2d0Mm1MYzdx?=
 =?utf-8?B?ZFlUUXA2SnBZMlJiMExCT1B0TGo5OVAvR3NrUUNlVE9IUFU1a3FEamw3S1FV?=
 =?utf-8?B?cXdFdEgreWJXR2M0dHJKYXA5ZlpvQVNVYjc2elp6Mk94Tm03akNrVW15RWgx?=
 =?utf-8?B?SmJ3K2p5Zmx2QjhHTG5GUWVIRXlrQ2dROStReGl1SGw0ZzA3ckFVT2RnZ3dF?=
 =?utf-8?B?Qkl2SEJwMzYyTTZNUEJjWHZac1JSSkdVWE96NE9QQ0RjclN5T1FoSTJXSU9C?=
 =?utf-8?B?NHJpMENXSWJHZ0ZTYVpWbi9EY1IyUFkvcHU1U29XUUJEOU5rbnJ0RU1sazBJ?=
 =?utf-8?B?ckc2ZUEvWWlGNXBjSlFuM1hFaEdaVnZBR2hFVEFVQ2YvYWFXYnNsTW4rb1Ux?=
 =?utf-8?B?aUllZ05CQlV1VlhaVGxlbVIrL2UvNHVlWEpFUE5DWEZwYldKT2ZYcnRSSTJv?=
 =?utf-8?B?ai85QXdKSFc2dE43ekVDcGkrS2NxUHVSTk5IRDZuazRvbWU4b3RoOSt4ME1L?=
 =?utf-8?B?d2tQU2dTbUFYL3hoSytlY2ZUWmZuNjhvMXV0OTNqZG8rNExJcXRzdmxPMW0v?=
 =?utf-8?B?Z004dEpmdUorbitqVERYVnhZbWRxVXZ1VGFHNXV5UWpwNEoxSDgzZEFjZWd3?=
 =?utf-8?B?TVBhZTVLakpvd0IvUjczcThybGQ0T2gzcTF3Uys4eWUxVEJXdW5FbjBnZyta?=
 =?utf-8?B?M0VxRld3MlM3RjB6RnB0b2tFV05xdWVYd3luOGJiVzhFNTVkS0RKQlVRcXJG?=
 =?utf-8?B?Y1pObUlqcEdaNURqSTBCdVB4SW9TQVM4eFlFTDBnSzVRMGR6cm5EV0c2WjFi?=
 =?utf-8?B?NmxINW5TYTc0L05KbEJlWVZlNjBZNDd2eVB1cjFmUjFFZHdaeEVac2Z6Vmd4?=
 =?utf-8?B?ekNVTWtoYkpmejdJYzcxQnNEbmc3ZWplQitlUUNGYVZIT0JHbVVlUFZJUUVq?=
 =?utf-8?B?NVU3ZE9hRXRDbGlRSGdwUEwza0E4NTR3SGhYWGFobStkR2lyL2lZNHI0Z09u?=
 =?utf-8?B?ZUF5dUxFc2pEU1R3MUZiRUx3RWlQZWVVeDkySS90NVJnMU8vNHlPbzdsZzhJ?=
 =?utf-8?B?dS9KWFBESSs5NmxJQXB6R21zR2xDa3p1OEJTMCt5TXZIdFlUcW5zd3RIbTlw?=
 =?utf-8?B?ZXFhR25CWXJQMUVFMTdmOHZ1RU5qQkJjd2kzdXNuaGcwb25oSUNORnRiRjZ3?=
 =?utf-8?B?OU9TZkZkbXJpUDRCZVZCMTZmbEorbXRoV2NSWUtxd0hQeFRVMlZGVXA0Z3JX?=
 =?utf-8?B?SlBSVytKcGFaMENiQkcyWGhXaVpSc1l4d2R0ODlZN1BTUGtjUm12cnVWT2Fw?=
 =?utf-8?B?cEZwT0pHVlZCUC9lbEtSU0VyL3lqV0VhbXBGR2lVVmZsZ0xuYnU5L2d3NE1N?=
 =?utf-8?B?N0xzZXFGRjZsVTdGUENZZk45RG42WThWdGV4aVVBRFAwUXV6dWpHTFJGTFdQ?=
 =?utf-8?B?TVUvaEJJRWpDZGRZeFd2bnFaTldiUFNVY2xiK0l3ZWZzS3MxQzNCNUhQNU5P?=
 =?utf-8?B?ODRENi96YW9mdXVaZjFyYmpEYjdGL1p1ZjIxUEZjM0xCVlpodzcwQzl5QjNU?=
 =?utf-8?B?K28yRERDMkxyL3daNytHc2YyRnJSMmNxY1pGRURhekJSTmNrenY0U2tHaURS?=
 =?utf-8?B?WWU0SDZoSURXQXFDNGdINGxIUFJSY1EyWUxoV3ZSMWRHSjVCZS9TSTlIbXBM?=
 =?utf-8?B?TmROWTdiZE5hcjlkRGt6S0xuaWVxQTJPOVZTRmsxUENPVHV0ZWkwS0xJYXl2?=
 =?utf-8?B?RVFzM1JldU95WDBvWVFHclZGOUVrRTFRSTloUXRGekNzckptQnlDZVpJL0tT?=
 =?utf-8?B?bThsSkVEZk43dEd3Y3NmQ0ZuYXhvVlMyNG4xREI1VCtjWkVFeWpnWDFVeGpr?=
 =?utf-8?B?YWhXT0tQeGFkWjFHZS9MRUt2dlRaTDI4dVRYN1hjdjJFMjZ3Y1VEbkJrenRr?=
 =?utf-8?B?azN1U2Y0SHpEdHNFcmRtbENhYm9NNVdkandCa2tFRzIrRVZJNUpYcTd3enp1?=
 =?utf-8?Q?Zjh+0abnKhQxyZTILTxhJZFCH?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcf8e6d-2c36-4d49-388f-08dd6bde4fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 20:47:51.9388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJdFTUcLvYT5iFZUWKapJLwqPOVk2NirSNo7wy6evIYxlAEyzi3T0aLmCIGHzpEZcYUba9ho+GfW9eVCfo+CvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4160
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <B55E81E12B604747A89C5760D0CA9040@namprd15.prod.outlook.com>
X-Proofpoint-GUID: IpoHXSqjaQ80O30gYXA8H_khV1EqgIZ4
X-Proofpoint-ORIG-GUID: IpoHXSqjaQ80O30gYXA8H_khV1EqgIZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_09,2025-03-25_02,2024-11-22_01



> On Mar 25, 2025, at 6:18=E2=80=AFAM, Ingo Molnar <mingo@kernel.org> wrote:
>=20
> >=20
>=20
> * Nick Terrell <terrelln@meta.com> wrote:
>=20
>>=20
>>=20
>>> On Mar 21, 2025, at 8:16=E2=80=AFAM, Michael Kelley <mhklinux@outlook.c=
om> wrote:
>>>=20
>>>>=20
>>> From: Ingo Molnar <mingo@kernel.org> Sent: Friday, March 21, 2025 12:38=
 AM
>>>>=20
>>>> * Michael Kelley <mhklinux@outlook.com> wrote:
>>>>=20
>>>>>> What are your thoughts as maintainers of lib/zstd?
>>>>>=20
>>>>> FYI, the same segfault occurs with gcc 10.5. The problem is fixed
>>>>> in gcc 11.4.
>>>>=20
>>>> So the patch below would work this around on GCC9 and GCC10?
>>>=20
>>> I've confirmed that the patch gives a clean compile with gcc 9.4.
>>>=20
>>> Note that I confirmed yesterday that the gcc problem is fixed with
>>> 11.4. I don't know about earlier gcc 11 minor versions. Lemme see
>>> if I can get the original gcc 11 release and try that to confirm that
>>> your patch has the right version cutoff.
>>=20
>> Thanks for the report & proposed fix!
>>=20
>> If you can test gcc-11.0, that would be great, otherwise we could just
>> cut off at (__GNUC__ >=3D 12 || (__GNUC__ =3D=3D 11 && __GNUC_MINOR__ >=
=3D 4))
>>=20
>> I am preparing the zstd-v1.5.7 update, and I will pull a patch that=20
>> fixes this into my tree. If someone wants to submit a patch I'll pull=20
>> that, otherwise I can submit one later today.
>=20
> The proper cutoff would be GCC 11.1, not 11.4, as per the testing of=20
> Michael Kelley, right?

Sorry, I didn't quite realize that the [tip: x86/core] was a commit. I'll d=
rop
my patch, and just make sure that the fix is preserved in the zstd-v1.5.7
upgrade.

Best,
Nick Terrell

> Thanks,
>=20
> Ingo


