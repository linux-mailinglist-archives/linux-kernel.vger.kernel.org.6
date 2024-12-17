Return-Path: <linux-kernel+bounces-448570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A229F41DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0884E188C33E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D44A14D70E;
	Tue, 17 Dec 2024 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZuWxelUp"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F314D70B;
	Tue, 17 Dec 2024 05:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734411620; cv=fail; b=aSqPrXmo8vXJOcF61hnQkOw0slAv7FNNSJEVO2wr0x6rP81WN7NVzwx29Qug+9E2VlDyM/Li43Y9Xji+HNTY5UfqSD3fvOP9wTN4X+hcEiOuQ70UkGKH6KGNPRxwfUAn/pxK8m3SVd22I4dw9U/VZr8Entq5EC6HcWns1TOx5Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734411620; c=relaxed/simple;
	bh=FgpIzz9+xMTI7dcJ+QmQgB878cSeUquRr0jO8gJtpFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k6vs9f4pJOR8/uyAI1fx/Q4HLcW6BGLI916a8C34nLr2bTFXdCTWoEWvrMdZIQJu8fH0uM+dOYxnVgjLqjZdL8souEnD1joxEmXdhxf9tN/JfyIx4zG0nK4iHganEfjLR6FrdDcdRgyaGTUkP6ZYkRu40cqFJLErZ96kLycI5BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZuWxelUp; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWVJVTbbXlvlid+13BWuLzT41y3FcfT381V4LSsU/hrlUTiijNzg5/GuIZ/kv/7WMqwCoMiJeLlQG0ZrGrsyAAnlnIDfTVFKahu4wb6B5L8986IhhsgM74yHI+Hkp6E63RbeTTBMDP/V38sJDMo5w+gXpM9nYXnAGgEGt+OSgSxXU1+fKr/bN3vKR7Sfst0x3eyxbUNQ2UF4ql1Phw/D7J/VUxS5BT+pfOSf3krJKt57BKqYIY2QGGkKWTGfBaJNmEsQ4DJA/8hTzBrV269OGbS/Exm/0BRBQcLJeEK8zr6Kp7QE++lDBXRYuajCRrcIj/xrUlImfTqcq+af58DL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgpIzz9+xMTI7dcJ+QmQgB878cSeUquRr0jO8gJtpFI=;
 b=vY14zjN7I8AQobMLGbghLDAB8QG0naXoBLEW2m4EEi9PcaHpcICcwCZcBzGPavAge4i7FjaTFaKlePCj+nCWoZFGxMVQyxuJ6GcTC75T7CMTS4koVc1u6Z+RY5mxb+4OdqrPoDLrMVzg5H3ogFO5oxLFP5IAzXuDZpewn6bfGyeU7Iex7X0+Ox5pfg32JO2NCuOPQ5ZPbImMuQH6HiG0w905QGCD8FCPsLVyVkNruDxeYYEJtyNlrjPIiNjNdQ+eCwfvIrZPjhAZJiW1shpksime630jTI6op6SBvbFECcKgKnVpqyrDY/fwe/nZV9+JJmbXJpC990c8OCjB6y7lAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgpIzz9+xMTI7dcJ+QmQgB878cSeUquRr0jO8gJtpFI=;
 b=ZuWxelUpF2fP4Q+WC9LpOdxGnUofbMFHNjmUDIDi9Wocg0w5zu9PjvF6KyNlv8X4LRkL+S3Rk3/rnzIiqZhOTAUSSy76Uqk0vVO/GnExCEikSwrzsaDpz0eJMWOVQoF9qSlXbHhBhO+uES/ibSl/WmImr2z8gTAt7aFv7CVzW30gQ5m552pon5wEeJObecNoGfoNWb4iEkFGBBIUu1IMRkoxEd04Ym0+KSXVhk1+K+gkjm8WoRcJNjmxRET/iSEtOIzwO6SglXn7ag7iEnU6AAgq7SPGkoPNrGGHdAKWEZ6ETeWpkBec2tXxBkiHkNxkRzL+Xt3eSb6uJl5dOxR7RQ==
Received: from DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11)
 by BL3PR11MB6340.namprd11.prod.outlook.com (2603:10b6:208:3b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 05:00:14 +0000
Received: from DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710]) by DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:00:14 +0000
From: <Charan.Pedumuru@microchip.com>
To: <krzk@kernel.org>
CC: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: atmel,at91sam9260: Convert to json
 schema
Thread-Topic: [PATCH] dt-bindings: mfd: atmel,at91sam9260: Convert to json
 schema
Thread-Index: AQHbS8APw+ZU4Xjwh0acaGZqn7hy2LLorvwAgAE6oIA=
Date: Tue, 17 Dec 2024 05:00:13 +0000
Message-ID: <92579055-5a46-4f20-b579-123188554a03@microchip.com>
References: <20241211-matrix-v1-1-5ef0104a3af4@microchip.com>
 <dxgqkdo6ulmqfa5vyerwta3vubuy32gzzu2cxfwwtespydfc4b@5wjrno3lgjsp>
In-Reply-To: <dxgqkdo6ulmqfa5vyerwta3vubuy32gzzu2cxfwwtespydfc4b@5wjrno3lgjsp>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7410:EE_|BL3PR11MB6340:EE_
x-ms-office365-filtering-correlation-id: 7fcf37d9-5ca1-4923-a8a6-08dd1e57b12c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7410.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFVlcitCRTJveU5oaCtFMUlaRnZ3c1dUazlDNnl6eHFZcG1ZeWxRb1grWElm?=
 =?utf-8?B?eVRQVFk5VE1oem1FL3RQdWtad0g1MzJ6MWRzU1FESXN2RHlWR1FmdmlRYWRZ?=
 =?utf-8?B?Q0puWEFQYlpZekxpREFJNlFYTWNrak1qdWNITGVtTDFiUm41SHFNZm5mOThD?=
 =?utf-8?B?cUs4U3RaZzdOVnBHYW1FV1RSSmZrZHRuL2N3dnJQOG1FQUNnZlIwWkNpbGFV?=
 =?utf-8?B?V3ZmWG85eThkNTFzTHdiMUxHR3hGQW9ienZNWUJqZ0VINGFJWE53bm9DbU80?=
 =?utf-8?B?WGNSanBOQ0p6S1dvbjlYem1aQ1JGNGpVaUtOSXFIRHBhYm16blBXZEw5YjRj?=
 =?utf-8?B?L0g5UXZLZnZTbkNyV2hzVVpIT1MvaTVQM01IN3hjQ1lGbTQ3ck80OHRXb0ha?=
 =?utf-8?B?T0VuM1pTQXhrYlowVmVTS0d5dGhXdHE2TXc4YmxDVmdiT3dJWlA3SnhYVzBH?=
 =?utf-8?B?Wm9TWHVXNE1qcmVVeVRrazN2ZUpPVWE0ZzdXOTBqN0Z3eUJYQ1VEYk9uRzFs?=
 =?utf-8?B?elFzMEJGTXB6WHVRQmtiNzBiU01YRm1PV1ZqZnN4SFJBWWV0MTZZcUo1bHRR?=
 =?utf-8?B?YkM1MWVpbFhvKzhSd2p4Qy8wakhkS3hCSytNR2lrZ2JaVkorWENFR2ZXZGNJ?=
 =?utf-8?B?STdjdE4yMUtEem52b1ZzQ0RUbkR3SzJiNmthYTkrYmpJYzdHM0JLU1NnaVFF?=
 =?utf-8?B?OHNOZVdCTEIrdnQ4c2dGTFlsaVV2bTdRRm5WZ2lxeTNaa2Nib2hvdW5TdXFQ?=
 =?utf-8?B?V0FSZk5sbjdyaEhZa1ZqNTk0N0RyS01lZGZQM2JQcU9FRnJGNllOYk1Ga2F0?=
 =?utf-8?B?NkRVMnhZcWxFbGh5UEh0ZlZyRUVxWS9yK3RVUjhXOC8vYUE3RzRjdE1LS1Qx?=
 =?utf-8?B?UDlueUtwZWR0QnJOdlVydWNyTS8wR0xBaUVyb1g0VGJSdkhwaXhCUlNWUGhY?=
 =?utf-8?B?K0x3eWdQd0hqM2ZQbUQ2TUJtY1lxZ2JEa0lEb28wRVRCL1NzTDJjRkV2Y0F5?=
 =?utf-8?B?N2dHcVRLM1V6YUZneDdSeGl1cnRaQXplVmowa0tsa3NqM0tFYU8rVXQ2K0lo?=
 =?utf-8?B?OHN2ZVRuVmdiRjJhb01zdy91VThXU2ZaTkZWWU5xZllnVFpmd01CTDVKT1Vv?=
 =?utf-8?B?S2tnNDNnWExwNlRqc2NlYUNpaW1MWmRPYVZFRUMxL21lWW9hVXNMckNlZk5X?=
 =?utf-8?B?eTBJMG1ESlRyRGZpS0VFdGE0ZHg1SC9wMFV2WnB3eFlZUU0wSFo2eTdIbHpI?=
 =?utf-8?B?bGhOcEJYTlcwRFFBZ01XNVJtQ3JTNzZUaWpqS2RYMmlHU3lYc0U1aEFvdG5u?=
 =?utf-8?B?ZTN1V2hFMmVZYlNkUWgraytZRWM0ZGYrcUFVZHZKZWl2akJMWUNrVjF0Ulp4?=
 =?utf-8?B?aElscndwMm1nV2tjN3ZJT0tJQzN4RjRrZ2NsRUVzclVVNUZ3NVVJa0pEZkVY?=
 =?utf-8?B?Vlc1ejFBV21oalc1Ry9uS2V4UVVxdzgxNVNYa1VXbFRxTmJDZVpzWGFMcjBO?=
 =?utf-8?B?aURvSVI5cnNwUlYzam51RnRiOXluVEt5cC8vMnZhSU9VaDhWZk9OWC9LQXJG?=
 =?utf-8?B?SHhJc2w1ckc3Q2tRUkk1QWdsMnF0UFBDZ2EyMURtSmdBSFR0SUlNZEdWSWZx?=
 =?utf-8?B?Wm9GUFNCdCt0Y0VRTFFoTHFveHloNXFZdjBzQ2c5Zk0wdWdkRktVakcrcjUx?=
 =?utf-8?B?K292OUxweDVJcFdpWmVJQWRuZ3pjSzNXNHNrSXFZZjFPUkNDbTdSYjVUZjAz?=
 =?utf-8?B?SXh1TXJoVlBXNDY1WFpsRlY5R2wzMkVKRUttbXI0TWFBVmxHL2l2aE0vVUVI?=
 =?utf-8?B?Rjl2aE1qMzJXUEtFMlo2VTN5SXdQR040amNpV2lXY0RWUjZuVDRWb0k3WnFt?=
 =?utf-8?B?TFRQZTFmVmF6S2d5RUJEeHZpRUpQQ3lsOVBxWW05SGlxaGc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVdENDFFcFc4MVhlcTVqMmY1ME40V0lwOVR0WThCSXJCa2tWMW91aTNWcHNU?=
 =?utf-8?B?QUlQOThJYWNwQmRSVXl6TnJoUmtNVEJVdWg0WVRaRnA3OWhKdjNUSm4vc2ls?=
 =?utf-8?B?Um9oQ2xnR0VMb2NCai95OVRCUlFsZHYrVmxQdld6ZzhZYk1pVklWMkxZRjdW?=
 =?utf-8?B?TXpiNHNwL2VRYSt0dGo1ZVpFangvc1BRSnI2L3ErY3ZJcWVpSjVOY1V1R3BW?=
 =?utf-8?B?L0ZaMTJYZU9NdXNrdFVUQlNKb21JWG9rbDQ0enNHb3J5UTY0anFmbXkvOXdT?=
 =?utf-8?B?eWRUdW8vUU1Cc0RtN1I3YytucDhVTVBDdVpjZldmempGVXU5aDFQd3BUeGd1?=
 =?utf-8?B?TnBQZDF3amNsWFQvcklRL1l0dXFERmxBdEYxaWU1NzhzMTFkbkcveDF0dk5N?=
 =?utf-8?B?dEU5ZHVneTV3TUxwSllSVTlxWmsyL1dGczNJd2g3TVNYS1RlV2xTcXRFYkkv?=
 =?utf-8?B?QWdIR05nZG9Zd2taaXFXanRibTBzd1pxYmpLNFJiOEFDcWdQK0QyUEZZTk5q?=
 =?utf-8?B?cHJCdjllWkFYbW5FaGdyWWJ5clVYTDlvSUlwa2xjelQ3V2pvdEhtR2xsaFZG?=
 =?utf-8?B?V1NpNWEvcS9HaTQ4bkhGWThibXhwclpjQWpZVktrZmdQT2M2V2tCbWxXd0dK?=
 =?utf-8?B?OTIrUkVHYlpVTitEOTc2OFpaZXkzT2hKRWEwYjNkRUkyQXFGOHRMTlA4Nzht?=
 =?utf-8?B?a3VGWWVSWkozNzd6bkp0VFRmWEMrMFZYb2xxMVZPWnFSZm1iL2ZHRlp2WUxI?=
 =?utf-8?B?bWxIUkRmTkcvK0FpcWxuSE5iMy95K3JGbFJIYnJjcm9mVTJIZlNnNkdyRzZ3?=
 =?utf-8?B?ek9xZHhtdnJNa0paM3FLcVJobHF4OFI0N3Q5SEtEaGRpMHBRNXMxUzAvZFd2?=
 =?utf-8?B?eVluaXc1WHZGU3FuM29Wbmx4TGdrS1JiSkxOSm94NmhaSEtiaW1TcWZsZTU1?=
 =?utf-8?B?K2RaeTh4S3Q1c1RYZGU4UTg3Q3BmWThvb1BzNXNNNEEwY09WQXlOc1A4TnZQ?=
 =?utf-8?B?TzlOaUZPWjF0dVY1Ymk5R1V3NGw5R0VVbWtZK241TENwWFpRdzB1Vkd5T25U?=
 =?utf-8?B?bmc3eVRZbVo5VnlWVnpBbkZzNzBxd0VGczJuaWJwL2ZrN0FzMUVicjFUZGFD?=
 =?utf-8?B?OWJKT3hxMlhVSjRKV3h0Y1l5T2JEc1lFN1laR3BWUFFKaVV1MVQ3WnBaZEZo?=
 =?utf-8?B?aFg3aTVWR2x3WWtpejBrK1UyQkNtSlBNT3JscjhEWHl0Sk15cFptVEoybHpt?=
 =?utf-8?B?NnMzZ0NybnFFRkdEZndsT0orbHFnM0JXam51cy9uNzRLVCt4dzdEQ3lISkxr?=
 =?utf-8?B?emdmN2QwTGpMZmVGczl6bGFrZHp3M2QzQmptUkdyNXpOUUJwQXovYTFtbGpy?=
 =?utf-8?B?TExyZ3RVMENTTGp2UWFQQUlUZzI3ZXFtbGVtbnNSZm1vaGhxckF3WVpIdUZK?=
 =?utf-8?B?ZmRIdGgxWkNKSmlaaEQ5T3EvTExiMnZ2c1kreDdsNnhoU0xHWW11OUlXeE9n?=
 =?utf-8?B?T1lxc213NHRvdER4aVBMcWhZQm11ZkZpUVlkZGFpTTZ4YWZzU0pnK2tydGdh?=
 =?utf-8?B?NVpqcy94dUJtSWE3YkloUFhhbFFiV3lFL0c3K2dvMkpWSFc0dktqcHFwWUJM?=
 =?utf-8?B?WXVUMktnTzBHV0t3UE1MWWUyWlZvNXhGS1pIU0l0VUkzOWZ0UCtxdVY3cTdo?=
 =?utf-8?B?aHV6anRsZG56a01OZVhGTE10ZDRuYmd2WVlUMzVVcVR1djdSK1RPTlpvWlhP?=
 =?utf-8?B?U1NHRXE3UldtQ05vK2twVU5mcXVOL0dRdVVra3oxRlpNbnFjUHFLbFZLMzZF?=
 =?utf-8?B?QXUwYWFXQXRQdnl5UUVLcHN6d0NzcDBPek5ocUJJRWsxSjR3ZWg1UU9OcXRt?=
 =?utf-8?B?NnltOTd1b1NpNmVmYTZUUFAycmlOa3lnQU52djVGMXhBMkw0SHR2d091dXVi?=
 =?utf-8?B?KzRINWRqZEk1dW1YQzlZd2VKNE5VYWFQYTVJTUVncGt0cGRYNGpNRHRMTzRl?=
 =?utf-8?B?aHczTmZjczRTS3ZyZG90UkhyRTJpaS96SHBpcFpJN0d0dWlmYTBXTVgvWElx?=
 =?utf-8?B?TDV2Zkl2bUhhelNaMmVjVWVmTVVCYkdZMFVQR1UybXF6VXV4dXluR2xlVGkr?=
 =?utf-8?B?dFBPT0dPSjBERUlkS3djeWdjSU4xNDczSEp2YlREM214SGNrNENieWlaYmxD?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52B64CE11E1EFE4C91704F144C4A1804@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7410.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcf37d9-5ca1-4923-a8a6-08dd1e57b12c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 05:00:13.9554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXWdPq/uXpWzThtbVNn38dk4MAqN+MM5jH8g/qhHCcDSb7ArssTbokX3ozRiP9OTynRmU8mU93EiewJNNaSyP15F4Dq6EYsbSuQK3nh3/04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6340

T24gMTYvMTIvMjQgMTU6NDQsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBPbiBXZWQsIERlYyAxMSwgMjAyNCBhdCAw
NDo1OToyMlBNICswNTMwLCBDaGFyYW4gUGVkdW11cnUgd3JvdGU6DQo+PiBDb252ZXJ0IG9sZCB0
ZXh0IGJhc2VkIGJpbmRpbmcgdG8ganNvbiBzY2hlbWEuDQo+PiBDaGFuZ2VzIGR1cmluZyBjb252
ZXJzaW9uOg0KPj4gQWRkIGEgZmFsbGJhY2sgZm9yIGFsbCBjb21wYXRpYmxlcyBhcyB0aGUgSVAg
Y29yZSBpcyBjb21wYXRpYmxlDQo+PiB3aXRoIGBzeXNjb25gLg0KPiBJIGRvbid0IHVuZGVyc3Rh
bmQuIFRoZSBzeXNjb24gd2FzIGFscmVhZHkgdGhlcmUuIFlvdSBhZGRlZCBkaWZmZXJlbnQNCj4g
ZmFsbGJhY2ssIHNvIHByb3ZpZGUgZXhwbGFuYXRpb24gd2h5IGRvIHlvdSB0aGluayB0aGV5IGFy
ZSBjb21wYXRpYmxlLg0KDQpUaGUgb2xkIGJpbmRpbmcgd2FzIG1pc2xlYWRpbmcsIGBtaWNyb2No
aXAsc2FtOXg2MC1tYXRyaXhgIGhhcyBhIA0KY29tcGF0aWJsZSBgYXRtZWwsYXQ5MXNhbTl4NS1t
YXRyaXhgIGFuZCBgYXRtZWwsYXQ5MXNhbTl4NS1tYXRyaXhgIGhhcyBhIA0KY29tcGF0aWJsZSBg
c3lzY29uYCwgd2hpY2ggd2FzIG1pc3NpbmcgaW4gdGhlIG9sZCBiaW5kaW5nLiBJIHdpbGwgYWRk
IA0KdGhpcyB0byB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNCj4NCj4+IFNpZ25lZC1vZmYtYnk6IENo
YXJhbiBQZWR1bXVydSA8Y2hhcmFuLnBlZHVtdXJ1QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+
ICAgLi4uL2JpbmRpbmdzL21mZC9hdG1lbCxhdDkxc2FtOTI2MC1tYXRyaXgueWFtbCAgICAgfCA1
NCArKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21m
ZC9hdG1lbC1tYXRyaXgudHh0ICAgICAgIHwgMjYgLS0tLS0tLS0tLS0NCj4+ICAgMiBmaWxlcyBj
aGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxhdDkxc2Ft
OTI2MC1tYXRyaXgueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQv
YXRtZWwsYXQ5MXNhbTkyNjAtbWF0cml4LnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
PiBpbmRleCAwMDAwMDAwMDAwMDAuLjBlODI3ODgyODIzZg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxhdDkxc2Ft
OTI2MC1tYXRyaXgueWFtbA0KPj4gQEAgLTAsMCArMSw1NCBAQA0KPj4gKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4gKyVZQU1MIDEu
Mg0KPj4gKy0tLQ0KPj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbWZkL2F0
bWVsLGF0OTFzYW05MjYwLW1hdHJpeC55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBNaWNyb2No
aXAgQVQ5MSBCdXMgTWF0cml4DQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAtIE5pY29s
YXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlw
dGlvbjoNCj4+ICsgIFRoZSBCdXMgTWF0cml4IChNQVRSSVgpIGltcGxlbWVudHMgYSBtdWx0aS1s
YXllciBBSEIsIGJhc2VkIG9uIHRoZQ0KPj4gKyAgQUhCLUxpdGUgcHJvdG9jb2wsIHRoYXQgZW5h
YmxlcyBwYXJhbGxlbCBhY2Nlc3MgcGF0aHMgYmV0d2VlbiBtdWx0aXBsZQ0KPj4gKyAgbWFzdGVy
cyBhbmQgc2xhdmVzIGluIGEgc3lzdGVtLCB0aHVzIGluY3JlYXNpbmcgdGhlIG92ZXJhbGwgYmFu
ZHdpZHRoLg0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAg
ICBhbnlPZjoNCj4gb25lT2YNCj4gU2VlIG90aGVyIGJpbmRpbmdzIGZvciBwcmVmZXJyZWQgc3lu
dGF4LiBUaGVyZSBpcyBuZXZlciBhbnlPZi4NCg0KWWVzLCBJIHdpbGwgY2hhbmdlIHRoYXQuDQoN
Cj4NCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGVudW06DQo+PiArICAgICAg
ICAgICAgICAtIGF0bWVsLGF0OTFzYW05MjYwLW1hdHJpeA0KPj4gKyAgICAgICAgICAgICAgLSBh
dG1lbCxhdDkxc2FtOTI2MS1tYXRyaXgNCj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNh
bTkyNjMtbWF0cml4DQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05cmwtbWF0cml4
DQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05ZzQ1LW1hdHJpeA0KPj4gKyAgICAg
ICAgICAgICAgLSBhdG1lbCxhdDkxc2FtOW4xMi1tYXRyaXgNCj4+ICsgICAgICAgICAgICAgIC0g
YXRtZWwsYXQ5MXNhbTl4NS1tYXRyaXgNCj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsc2FtYTVk
My1tYXRyaXgNCj4+ICsgICAgICAgICAgLSBjb25zdDogc3lzY29uDQo+PiArICAgICAgLSBpdGVt
czoNCj4+ICsgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLHNhbTl4NjAtbWF0cml4DQo+PiAr
ICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLGF0OTFzYW05eDUtbWF0cml4DQo+PiArICAgICAgICAg
IC0gY29uc3Q6IHN5c2Nvbg0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAgIC0gY29u
c3Q6IG1pY3JvY2hpcCxzYW05eDctbWF0cml4DQo+IFNvIHRoYXQncyBqdXN0IGVudW0gd2l0aCBw
cmV2aW91cyBncm91cC4NCg0KWWVzLCBhcyBib3RoIGJvYXJkcyBoYXZlIDIgY29tcGF0aWJsZXMg
b25lIGFmdGVyIGFub3RoZXIsIEkgZGVmaW5lZCB0aGVtIA0KYXMgdHdvIGRpZmZlcmVudCBncm91
cHMgdG8gcmVzb2x2ZSBkdF9jaGVjayB3YXJuaW5ncy4NCg0KPg0KPg0KPj4gKyAgICAgICAgICAt
IGNvbnN0OiBhdG1lbCxhdDkxc2FtOXg1LW1hdHJpeA0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBz
eXNjb24NCj4+ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICty
ZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+ICsNCj4+ICthZGRp
dGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4+ICsNCj4+ICtleGFtcGxlczoNCj4+ICsgIC0gfA0K
Pj4gKyAgICBtYXRyaXhAZmZmZmVjMDAgew0KPiBzeXNjb25ADQo+IG9yIHN5c3RlbS1jb250cm9s
bGVyQA0KDQpXaWxsIHVzZSBgc3lzY29uQGAgaW5zdGVhZCBvZsKgIGBtYXRyaXhAYCBpbiBuZXh0
IHJldmlzaW9uLg0KDQo+DQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+DQoNCg0K
LS0gDQpCZXN0IFJlZ2FyZHMsDQpDaGFyYW4uDQoNCg==

