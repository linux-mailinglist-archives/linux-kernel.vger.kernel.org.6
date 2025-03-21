Return-Path: <linux-kernel+bounces-570749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D3A6B423
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB4E7A95B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2951E98E1;
	Fri, 21 Mar 2025 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E79IXsKZ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2078.outbound.protection.outlook.com [40.92.42.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60E3597C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742536227; cv=fail; b=e17DBIjTqYoDwj1Ru3ATm4ljcuQoSu0xdeiT11oXFLat38eY++QyZkf1yAqAsjsH5DjMFrvQh6a3Qjj2QOtpVhlirXq0yzLVqDyE+K8MBLKPsKLDcwFMEErpaFupQDep0YDX4GzA2a/jY2or29rqBL336VAQyXoXp17lEYfMgl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742536227; c=relaxed/simple;
	bh=6pEEmYdWDKSNGpPgTKcCsfMM98Ckh9h78dyl/rgAsZU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NzzNaWc2Xx3xI8GLmvLpyDGtUDjDzfXi3NF8yumvT1f9z4WfOlzVZBJAwqhl4DtT0EPQKNM4WTuxMpR1kVu9L9IRhiqzYuMIQ7dCO0k7RYirA7Z1pI4vdUsk6w+tHUZodKDpM+es4c4l9mKG4YBx64Dn6DXRngu+P0WcGk9MRvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E79IXsKZ; arc=fail smtp.client-ip=40.92.42.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+3JbREA7S6pZORoDRtrVGsTqai7KMZsPixF+kieo+8HkjOiYWAeyQcT8bEH2CDQl1XCnQsCT6hmpq8iWxVGPsRDitqcLmvw+WyzDI6651CpoX2dVdCh4IBhd2qb+3FDp/6XlOMZeMCqJiJIvTUBrhdLfbzUA4hrNPm4WC/1AODw5t3hjxnTA6AmnZalHNjO+n9eK0u9xWqbOJ27n63zW52CeT5p35p0eqMekxgIqfm2yH46MbE3Lw/E78V67YUdvma848nE6EKdP/SdVYy/3ARcH2GXHncdyygiCB+ubzc2YTH6zPHIYLF5a6ZQaSEG5OQIZgyXO18wdm2lrT+v8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7W2vdSRbBYA3pbFDD00DfmJsL/pDdXPamJ5H4fiUSY=;
 b=cuIcVwBjvRH9n4jzs35WYiF+E4BLaS8YdRoxuwO8tiIcixlaBp+QDaM9jWVddqs+WvSDXa0BUu+K6e7v6aUa4RwiVl6vFl6BOAJemNxpNj2X4hjKV2ZonntQ7VyKZyj/FvB9IFG8S83qOL2HQo0BlHniuux2yAIC84dbQJU4D8hw+u0DlQNbfKZRgTpXldsDGlDb6gAvtiZeLykIlnJOmwM8nrwbwVW74A59b+OT+KW5/o3Uy77ZKuXu9IzpFEUWWkmLhPkjyAoSauE8jjDN2G3CX1BYhBwhtFi5FNG5xQYfalopYGT7ICYALSK8e/L1X08Xf2vkCoERU7Ce+4JJzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7W2vdSRbBYA3pbFDD00DfmJsL/pDdXPamJ5H4fiUSY=;
 b=E79IXsKZyfNFU1yjncgLj4/grzrFw9k7SvMNvbo2yyji6tjShLEMlG1RryhYGaMp+Q3mbtUBCGQeQS/k0aFuCgTbyfMilEAT2eJqTU6VkD7mJ7SLj4giq7vUXtq3zRGT2BjXtpmcti5kPrPHRUn22zrLIV91YD3yGBBA//Vxd/PQHYy2bGNnNgHGdlVRVM4L2OR3R1YtvhlLz8z5clcXqvaZesmmRHKxp482Z/frO+rplcuF2I5qIcNLlrmfLAYNRNVcmt6GSuD3cXU1HJ0Fp7VR4PGtPNax0ETidmFknqN3WynLWBrr9saRRVJueNIK3l3qKAHnyjmtmb70ZV25CQ==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 05:50:22 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%5]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 05:50:21 +0000
From: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>
To: David Disseldorp <ddiss@suse.de>, John Sperbeck <jsperbeck@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "brauner@kernel.org" <brauner@kernel.org>, Fan Wu
	<wufan@linux.microsoft.com>, Lukas Wunner <lukas@wunner.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [ISSUE] initramfs: Failed to decompress the built-in rootfs and
 entered panic without log output
Thread-Topic: [ISSUE] initramfs: Failed to decompress the built-in rootfs and
 entered panic without log output
Thread-Index: AQHbmf+k0rKFPoR7Jkq7Ths/9IBztQ==
Date: Fri, 21 Mar 2025 05:50:21 +0000
Message-ID:
 <BYAPR12MB3205E9E6754A56DDFF805E2ED5DB2@BYAPR12MB3205.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|IA1PR12MB6018:EE_
x-ms-office365-filtering-correlation-id: f923644a-097f-43cf-0917-08dd683c44c1
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8062599003|461199028|15030799003|19110799003|8060799006|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?UWhlcU4zTUlRSXpCRFJRb0hVYy9TRFI0WFdJVVAwcDZVTDhMNFZsV2E3?=
 =?iso-2022-jp?B?eFhId0NJdUFPcUV5NVNTM0dueXdyWDRoRTRnSmZiTXVIeG5TN3hlVFlY?=
 =?iso-2022-jp?B?WDJjZEYyR2dmSVVFN254SUoyMEVRclBJVEZEWUVzb2lVcTN3QVcwZEZJ?=
 =?iso-2022-jp?B?V0FHR0k3RElmSTJxUjNUSHFmYWhTcXVHQmViVXQ1RStBZzlmdzhtbTZR?=
 =?iso-2022-jp?B?U2I3Zit1YStqOUplRWpiVmFaakpGOGo4b3Vsek9DaTh1Mngxc0t5cmMw?=
 =?iso-2022-jp?B?VFpFcVVGL3FIV2RDVWZ2eHg3c0ZLc0c3bE94NjErMklQeE5LK0w5ZWkr?=
 =?iso-2022-jp?B?UzN6MTZVUWk3OVdJS1hqeWlIUlZwY0M5T3dGcTd4em9yaE5mMTAxVWFT?=
 =?iso-2022-jp?B?Vzg1d2M1OTd2T3NkT3JuNGRrWVNDSnZtS0YwM2F1U21aSTUveEFvMVFw?=
 =?iso-2022-jp?B?NStDUHpsSUV5RVhqZlhDTmM2emV0YXhxQzVNUzZNdmpMRWRzczJ3Q3RQ?=
 =?iso-2022-jp?B?a0hZbnlCM082Vk1rWmdtZjhsWFRNWC9ZVXlsaU9GaHVaU0pndjZwZ0E5?=
 =?iso-2022-jp?B?eFZpQnRaWlJocmx0Y2FqbXVwQXJJYmo5eGJjZkxnYWNmU3ljS3dJWWhR?=
 =?iso-2022-jp?B?TjVZWmpRdGNzUE1MOFpPdDRHZmd3Y294Z3F3ZWxaQVlxOXpxTE83UGx3?=
 =?iso-2022-jp?B?cmlaWnlKREdhdWs1QytYZ3c4QitwYStOaDNZUU9hWUFwVHQwY2lVV2Vy?=
 =?iso-2022-jp?B?OU1xYWVFMXUralVaTk5NRWUreFp0UHhUaEhLNFVvak8zWm0xcEdLajdR?=
 =?iso-2022-jp?B?bmpLeTJrS3N6dEc2YmxVLytPM20xY2FzRUJFMkhhTHdiYlpWdGhzYmR5?=
 =?iso-2022-jp?B?dEVJbXNpdW5LN2kxSFdoREJaWWNDMW9VQjZ1dXpjbXpGejVFWkxrV1B5?=
 =?iso-2022-jp?B?MHF4RDdNbitXMlE3clArSERPTUQzdlpjVU1uZEZCUkJJcDRMSVVCa3JS?=
 =?iso-2022-jp?B?YjF2SGZNWTV2QXZiYjhZWkc3RTVZQ2hsZWFLekRYQ0dVcDVMeXhOWWhJ?=
 =?iso-2022-jp?B?Ni8wSHBTejFPUzBDemE5cHBqNWhILzd2Z0wwcUZCZi9CMCtsWWYvYjQ5?=
 =?iso-2022-jp?B?Tkh0cjF6UDJzdlBCWjMrdXlCSUVPbGh0dmF6TDlkeE0vWWoxNnllUFg0?=
 =?iso-2022-jp?B?R0hrdndSN3VvTERzb3NtK3hlMVE3dDB5SmVHWkVSYjMwUUxLVGg4SkNr?=
 =?iso-2022-jp?B?OEY3ZDVBT1A5dm4xRjBtVzVlT0tIVGIxTVJId1M2cURYcy9qdW9mQXBZ?=
 =?iso-2022-jp?B?TDBpdDNYTzRaSWxsUzQxeE5ZTEpqVTRTelY0VFZZODdYL1p4dDFFOW5C?=
 =?iso-2022-jp?B?NDdCMDZJNjFkK3lmYUhMQU1LQmNTdFJoSHdkZGRDTDlNeTRtcndWSGdM?=
 =?iso-2022-jp?B?eTFNMjBIT2Z3MkxEZmRmS2UwV1VRSktXYWJ2MDJxNUxvR3pKQzRZYUFS?=
 =?iso-2022-jp?B?cjYwN3lwdkdoaEU2bEJBNFl3VUV6REFNbWlvMUxtN0RiQkdaRnpWblAw?=
 =?iso-2022-jp?B?YXVIKzBJSmtJSW1sVWZ6cVR2YnNYOXFsQ3kvWE1lRnlyMzdvcUFNSmNv?=
 =?iso-2022-jp?B?T0EzNWxzWlJtMWtnVGo2dXZp?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MTFKTjkzMlMrS2IvM2Vkd0Vodm9zL2ZVLzMyZWxRSFk3RzVlWWtpQjM0?=
 =?iso-2022-jp?B?R2FDeEo3bURrVjZsWm4rbnd0MEFvRzhQOGJuSU1LTTNNZnY5dTJuTVF3?=
 =?iso-2022-jp?B?R2twZGJ5Vm5ISllXMHRQcXptd1dydlVrNmJ0VnVoRmR6SThMajFtYXlj?=
 =?iso-2022-jp?B?cXMra21Tb2ZuNjUya0tLQTFGZG1xQWt0K3l5RTMwMno2enVBeXIzU2JM?=
 =?iso-2022-jp?B?NFdyT0tZVXlsc3ZudjNJQ0pZZHhjei9vOERRRytIWlJNaFQ5b3VvaUVQ?=
 =?iso-2022-jp?B?UzNPRXNBelQ0ajVQS0loY2I0LzFBUlpWbUpidGxKY09BdCs4ZXFpY2FP?=
 =?iso-2022-jp?B?RWcraDZ0K0tUYkEyWjUxV0pGVmtRanBURjdBenlRaGVxd2tVUUVucm4v?=
 =?iso-2022-jp?B?RkhxSWRPaEt4WndyZjFCck1aTWMzVmMyMUxmejRKaEZPeU10R1oxRWgx?=
 =?iso-2022-jp?B?WlM4bm56Z01YWS9Cd0tMTlhsSi9YMzdZTUpWdEExYzhwSUhKNklBdFYy?=
 =?iso-2022-jp?B?VkpPOFR4UFFXcUJiQTVWUWl1ZEZaNExPNk5HcjhkeCthV3hqMTBhbW9o?=
 =?iso-2022-jp?B?QllkL2REc1ZFN2ZyQzVTRjN5ZVBva1kxWTlVZXZRN2RsRWZxM2RxakV2?=
 =?iso-2022-jp?B?c1pXWDZqSWdtcnhaTDQycjNXTVIyN29vZlp4YTh6dnMxaUlOTk96cTZm?=
 =?iso-2022-jp?B?MzVFbnJ5UlRFTWVNM0lKWkhXR2RLYlBkR29JbmVobzl3cys0K3FFemRC?=
 =?iso-2022-jp?B?WXBkWkZjbURJSmRMRUhDR3M4M3U5eE5panNoNTgzc3NXRnRxbUgvWDZ4?=
 =?iso-2022-jp?B?OWx6OE5DaVduMkpCVEZTYjFhdi92dlRscFpqSEJ6cldNcXdITWZvdzVJ?=
 =?iso-2022-jp?B?UisycVVHT0dGTitUK2N3MU95MFJLMFA0YjRzMFZrRktkKy9VS2FOb0tj?=
 =?iso-2022-jp?B?YWNINnE3TTArU2ROdlhDTTgxWWxLOWVMUnl4NExieDUyNG9hakkwWTRQ?=
 =?iso-2022-jp?B?Rll2T2lPdmxpd05LOVhjK3V4UThQblE0OXZuNjgvOWpFdWUzT0pyU0ps?=
 =?iso-2022-jp?B?S3ZqeGo3cityWlRkMytRb0hWbzk1WFFwN3cvV2NkbmRwTUFTQUZ0dGdS?=
 =?iso-2022-jp?B?QzdzWHBuZGZqWWNKY0JwMXNVQyt3ZHF0TnhJbDRRTmpCNE9zUHM1dWgw?=
 =?iso-2022-jp?B?L1JMaFJiamx5aGF5aDEyTG5oMWkvVHlEMlU4UXF5Q2xOaXVZOHpuNjdL?=
 =?iso-2022-jp?B?MzM3UG9MdmFUcUV2ZWozZG5KTmtCTElGUndnWTlkT3drV05KTWZsT3JQ?=
 =?iso-2022-jp?B?U1JIanBJY0dWTGN0UmZNbjhXR3Vrb05hYVhWNEFWUlVGWnY4cUU1YnRP?=
 =?iso-2022-jp?B?K0kxd0FvYThGd1BrTWc0VlZaWVcweFlDNlFzeTB5MVdDdHNrTTBlRGpo?=
 =?iso-2022-jp?B?K2dVUFBrREp1Y2RIaGhmcDRTTVdocndaRHJySXQycytDQ0l5SDdpMkZi?=
 =?iso-2022-jp?B?ZHVzVTRFcWpyc0EzcW1XaHArTUZ4dFhOR3VVeFFOUCtlRyt3NVRYL1VH?=
 =?iso-2022-jp?B?cUdudWVwV29MVmlYRjFxWldON2tQY1N3YktZNFN0SVNqdTlCK284ejA2?=
 =?iso-2022-jp?B?QWNzQ3llYVRtSlpSNTUra2dOL2dzYWJ2NUFQckpZdnhDc21pVWM1VDBP?=
 =?iso-2022-jp?B?K0M3UFJSS3M3YmpaNThLUksyK0ZhZHhrbzNrdDUrK21aaVBDWkNPRTJK?=
 =?iso-2022-jp?B?Sm10LzJNLzNhN3VnTlZvbG8zUU9udG1ZSXlnb00vcTIvOWxXN2dFN3c9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f923644a-097f-43cf-0917-08dd683c44c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 05:50:21.6871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018

Hi all,=0A=
=0A=
I found that if `initramfs` fails to decompress the built-in `rootfs`, it w=
ill=0A=
call `panic_show_mem` to make the kernel enter the panic state. =0A=
=0A=
`panic_show_mem` will call `panic` inside, and `panic` will call=0A=
`pr_emerg` as the log output interface.=0A=
=0A=
However, since the decompression of `initramfs` is in the early stage of=0A=
kernel operation, neither `console_init` nor the serial port driver has bee=
n=0A=
successfully initialized at this time, there will be no log output.=0A=
=0A=
Although `console_flush_on_panic` will be called inside `panic` to force lo=
g output,=0A=
there is no available console at this time.=0A=
=0A=
`for_each_console_srcu` cannot find any valid console.=0A=
=0A=
After calling `console_flush_on_panic` to refresh the log cache, panic will=
=0A=
immediately perform an operation that seems to be idling:=0A=
```C=0A=
for (i =3D 0;; i +=3D PANIC_TIMER_STEP) {=0A=
    touch_softlockup_watchdog();=0A=
=0A=
    if (i >=3D i_next) {=0A=
        i +=3D panic_blink(state ^=3D 1);=0A=
        i_next =3D i + 3600 / PANIC_BLINK_SPD;=0A=
    }=0A=
    mdelay(PANIC_TIMER_STEP);=0A=
}=0A=
```=0A=
There is no exit condition in the above code. In addition, `panic` will cal=
l=0A=
`smp_send_stop` to stop the work of other core processors, which means=0A=
that if `initramfs` fails to decompress the built-in rootfs, it will fall i=
nto a=0A=
suspended state and no valid log output will be seen.=0A=
=0A=
The decompression failure I currently encounter occurs when `initramfs`=0A=
decompresses the built-in `rootfs`.=0A=
=0A=
The required `block` exceeds the limit of `tmpfs_max_block`,=0A=
and the error `write error` is returned.=0A=
=0A=
However, when decompressing the non-built-in `rootfs`,=0A=
it did not enter `panic`, but called `printk` to print the log,=0A=
which would not interrupt the operation of the system. ()=0A=
=0A=
After the `console` and serial port initialization are completed,=0A=
the error log can be seen normally.=0A=
=0A=
I am wondering whether the decompression of the built-in `rootfs`=0A=
should also call `printk` instead of `panic`?=0A=
=0A=
Below is my debugging environment:=0A=
board=1B$B!'=1B(Bvexpress-v2p-ca9=0A=
kernel=1B$B!'=1B(B6.14-rc7=0A=
=0A=
Has anyone encountered this issue, or is it already being addressed?=0A=
=0A=
Thanks,=0A=
Stephen=

