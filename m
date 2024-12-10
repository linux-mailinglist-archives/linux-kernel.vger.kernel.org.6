Return-Path: <linux-kernel+bounces-438818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC97D9EA6B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAB5188B294
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00811D5CD4;
	Tue, 10 Dec 2024 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eQ/dSiZ2"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70292208A7;
	Tue, 10 Dec 2024 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801765; cv=fail; b=PLNB+GQ4SVsUY/R7Ph850ylLE37k2XZQHp+MNqntRw1wfgc/j2CZE+Yayd94tCF1+Dlo+UOToh9Tig9WEneO26xhwALIOlSMGvziLEA3YrsmHOmd565Bclx/C+1WkfpeXwVrRYs75zOsBNRU1Qr1l5FD6+GU9TPeeHbN2tJP4G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801765; c=relaxed/simple;
	bh=vO6dmgDIddG/3cr+Yt2xHSvooegMxHTSQLpnGZA/RBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hMrbrUsSvqgAbagRUbkGcLrR/6zkz1aapYnLGM5/22ILhFhRk2VXEvSc6Zaf5RBKIXB+SMf/9zcrz8+19e/zMZDWQXn5FnvwZC7JRHzJipmwxq+makC9ize+7M2sDOqZCBJHzf8qQWkQ5eLEdwM7arIfWw6rh0NbnY2MI4NrqfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eQ/dSiZ2; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubwaj1+CkqzLDpbVpH7LAcG7TsmFlvNY9m6in2EB+r3OtofKCerYaQktpXqbdI+zDt2ej+qHtMMtxd1Cfylsbo287UnX8wlFZM2XPEIljcGvCvWkGf2qD8/hbQackfmFuHB1nEpmr9EgB27a4fN1FxAaj8SdwMiCFFgldjNIx86HwW9B7ETFRP1Wpce3BrBIhtRHgnp+xzujR92O8IuY8Ek1mGdIxfzAEQ/1je905Nmu847JjyKVPO/b+Y8MJ52JqYXP0cVtU2QVa4sWycToALAOIK8jHRuxz/icwRxS1T7cXdgRuSQzmxdJrXA+ZRqQn26hXqCrkcknw7e0F6pIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vO6dmgDIddG/3cr+Yt2xHSvooegMxHTSQLpnGZA/RBs=;
 b=BanMRa4kecMuCneneYw9THeMmKqTUcGgAJw7AHG2ZcWy6pzhX7sI5GcsEzz7Yb/Qz6jwHTLLbM2Zdl+uxyLQZ30+6Q29BiA/8Z3O4dsE/RWXkVAfvvtpuDsLnM6AacRggh0J39qvJXVc7bP0fm6rqtTszksWaWbZI8e8UGzjWX2u8Bt54CI3+swh0mTpUkBaSY5BHr98WvtnnOwH1m8VVlNQShD7SslBjfzEydGmg/0v/Ba5hTyTratsx15XDtRF/jE0S4Gl02zNDZu6bU8MnAwqYP83VURCPrpM0GI4LRr6fQcX+2bOhW0kPJuRCNJMtKo6WVpssxShAwxJ6ygz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO6dmgDIddG/3cr+Yt2xHSvooegMxHTSQLpnGZA/RBs=;
 b=eQ/dSiZ2hF6X/loqpMfZ+D1yIZkpJ6qIn0l/FLTwuHD0ReJkol2dUWJi9s5ctRYDaRIVYmTWvq6F95ma+wj+2b/QMpsxpYARQl4mrj1HHrhthwEY2Oj3tKFDMX93dl94ohiUQg76wyVj120BQOrzB3XKeDILXm3fmR+1oLRzB3RrgAdl94ciW8vSdEqjnJfcio6yGLqm1FXp26HeErxRrXj/hZyg6DkZFHYEQ0NKwhzB5Kf8xK9jcUDqv4QUUx3Y7CWmhvV29ydVnzbcxTgg2U8NQxP2THNCaz8zdi8XZIDCmyGDP0Srpz+t6FWIcWT48mUzVbJKkxGO60J5o4aGEw==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 03:35:58 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 03:35:51 +0000
From: <Dharma.B@microchip.com>
To: <Balakrishnan.S@microchip.com>, <robh@kernel.org>
CC: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: sound:atmel-at91sam9g20ek: convert bindings
 to json-schema
Thread-Topic: [PATCH] dt-bindings: sound:atmel-at91sam9g20ek: convert bindings
 to json-schema
Thread-Index: AQHbSrSc+7sd8T8aHUmwCmUdzr8U7Q==
Date: Tue, 10 Dec 2024 03:35:51 +0000
Message-ID: <1ab38f1d-f153-4e43-a41f-466acacb321d@microchip.com>
References:
 <20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com>
 <20240214135824.GA692740-robh@kernel.org>
 <62a9f501-64de-47f6-9d0f-f1b48df6e5e6@microchip.com>
In-Reply-To: <62a9f501-64de-47f6-9d0f-f1b48df6e5e6@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|PH7PR11MB5818:EE_
x-ms-office365-filtering-correlation-id: 18f89c79-6084-4063-46f1-08dd18cbbee1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGl1Y3M2a1RybEQvR20vVFBOa2Z4VmxNb1VQV0FiZmllUUY5WFBWUHVsTGRy?=
 =?utf-8?B?Vks5TC9BMlMrR0RJcDByd2d4Z0ZhbWFvR2YyNVZISkpiUDFvVTV4azljdTNI?=
 =?utf-8?B?RmZWaEdoMDdJdW9OMVk4bkx3TUt1aE16LzVZMnlzUFlncW1iRWg4eUw4ZFI2?=
 =?utf-8?B?ZGcwUUFwU3p4QnJzaDdTNWYwVmZzZE0wcUJ0OCtZTDVMRGovT1pPNFF4TWtO?=
 =?utf-8?B?cktVNGJIdk0xL2dsUzhEazBQaWk0c1hNODdzSGhxOFkrUklreU8zbTJ2am9n?=
 =?utf-8?B?TXR4OGVMS3gvZURIWHpsNTI2OHRMeCtRaWZ6UkV0RU9uaCt1VEdHQWUxSGRW?=
 =?utf-8?B?ZWdRaENJRDZPNjdhczBuUDFRODhMdXBlK0JRVTFkd0VzcEJMYXNVczdYV2ti?=
 =?utf-8?B?R3h2bmgxT20zbDc2Z29MV0l2NDhIajM5K1N5eW5MSHhKbVh4UDMxYWE4eXEy?=
 =?utf-8?B?NWk3ejhmVDFKUlBidnp6d2lzRmczemVqMllDQkI5eS8wVERxMVR4NEQ1dGth?=
 =?utf-8?B?MmxQUDQwTEV2K2NKMTZra2JiMkFRcCtzK2ZZWEcyeFJpVzNDTVJiQmJ2eXhO?=
 =?utf-8?B?aVhRMTF1S3lDL2tkTlFHNzZUaysvOUg5dkdKZCt5bDVvWGh5enZjVndXdldo?=
 =?utf-8?B?UStoWDQwR1ZjcEpEY1pHeFp0dHhFNS9MZ2QyV1Vwc3J3Y3IwY1dzbFc4dTN1?=
 =?utf-8?B?SjhpeGVKTkxtcTUrd3Zsb2dxOFJ6c3VWWElWWUh3Z3JDS0NOUS93NzlDSWUx?=
 =?utf-8?B?Uk9YK2FsUDlycTNVYkxJM0hKMFBpbjQ2RXhOS3VJTWI3SWkyNmtyMk9qcEZh?=
 =?utf-8?B?cGFaZUxCVk55ZnJzbFBHWXd1SVMyY2RReGY0NzUydzNPQXhQdy9iS2lkZXY3?=
 =?utf-8?B?di9rTHU2OEJFb3g3SjF3UGRXSjZ4UlVmaGU3Rk9QcXVxTnpiRlRCdnNTcmIv?=
 =?utf-8?B?VERqK2hDYWJNWFlDUS9pMFY2VmhhZW0ycWVCbmMxdUpDTVdYckRjazhQdmVN?=
 =?utf-8?B?aEt6cUY4OUVTbEZwMDRMbGE4TFUzS29lOU9NSU1xQ0d5cGdkV3IvU3J4Smxt?=
 =?utf-8?B?WWNhOHowNml5Zm5QRjh5Y09laWp5VXNCMCtlRGs2YVBUNGx1Tm1iRTlwbjRa?=
 =?utf-8?B?UnI0a2tYYjNtZHJ1VjZJVjdSdUEzaGVPOFdzR1hHYzUyRVBqNU92ZVl3aSs0?=
 =?utf-8?B?ZUNRM3VCVlN4ZGdtZUcyN0E3VDdXdVZ1RXI4c0RuZ20zdFkrOWZhOXBQN3lV?=
 =?utf-8?B?a2llWUVOdkVLRG9MRWlucitLNk1yZGNWNWF3bjg0UGtIQXVFSmw4dDZyazA5?=
 =?utf-8?B?QUhHdXBRUU0xWWdqU2JFano0cjRVRUtmS1FkSHo5MGlOVlVxS3JVakEweGhm?=
 =?utf-8?B?MVhsbDZKYWduUUtFTjBPd211R1lDUzZBTzdnVW5EV3pxY093eFFQTWNyOEky?=
 =?utf-8?B?elNCdHR6aWFNaXU3NEhKK1VxNHdublpKczdnMnVaYUZiS3hqTmJPclhWSmVw?=
 =?utf-8?B?ZU9yTVZLU0ZpZGdXazlyUWxsMEtNUlZLOWZzeE1XODV3eU9BMnhBU0g2OEk0?=
 =?utf-8?B?YXhGTW4zazlBR1BtWit2dXZ2WjA0R1dIOUtLNktoKzFDVEl1YmkwL1FQK1Er?=
 =?utf-8?B?V05oSm92bnppWndVU1IyTHdjMmlHQ3VyWVRVeHhlQ1NJSkdDM3VOOW9Qc0hr?=
 =?utf-8?B?YklnS2FrRWhnZkU2blF5QTdPR1l5K2xYSWMwWDNVUHdmVHR5VXJXM0dWYUNj?=
 =?utf-8?B?ZTZQRFFISlhqSk9TZ1B4MWNpekNiRnBqeHVFbGNJMnU1VXRDT3FKUlVWMUc1?=
 =?utf-8?Q?jEbZHDMTrtWKSRTnRVg8WFOaLchUhxEViZnUA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkE2UG04cEZvWXZpcUx1OHdocmFwZUZ0V2pJQlNWN0l3TU11WGtnMkRLdkZt?=
 =?utf-8?B?djZSM2liRDhMUHRiYXVrUmNGSUNtclNmZkdVZHQ5dlcvQUhVbFhtSk16aGV6?=
 =?utf-8?B?TUp1M3RkQWwwaFpHbVkweFNpbm10d1puZExybjJYM1A0T1krMVRiOHFNQ0pJ?=
 =?utf-8?B?ZXhPNXB2dk9oOG1lMk9YdERzcHRldXlvQVordFVtMXhyMG91eDBDV2hpdWlt?=
 =?utf-8?B?S2VTZUNibU9CYjdCY2RiOXkrdHMzWWJCRXZWdlkwN3V4cmI4UTJ5TUFmdStN?=
 =?utf-8?B?NjFiOWNXVmlHNFZnUGVRdnd6ZnNEaWtkVHIyZ0o3YVluZ0NzUXpxUjlwWFl2?=
 =?utf-8?B?em9NU0lGdHNGdmozODJLMStndXMrRUhaZzY0WWVhWnM2MnFGUU53Y0ZXY0tp?=
 =?utf-8?B?Mkx5RVNGRG1ubndSY0M5Rmt5T3JKQ1hleEdKUkJUOHhReXpiL2QxNk85c2Jp?=
 =?utf-8?B?Qk95V0tpZUtlR3AwQWhHVG1Vd0Y4aDFaTUhEV1BTRHA2b1hadjVFU3ljNUJp?=
 =?utf-8?B?R3h6OE40Y2I3UTdGWU9keUluMjdTeHNncjR3LytHOUpOZktJZlFnb21kWDEz?=
 =?utf-8?B?b3NPWnlXZWkwajNtNUFhY2p0aGZzdmtva2MvYTRDd3hycU9hTFQ3dk92b1NB?=
 =?utf-8?B?bjJIZUgvcEFlYzV3VnF4bGxwOEhUR3o3K2pNNmlSYkpoSWttTGZvY3NBdS9D?=
 =?utf-8?B?N0c5WThSQUczcEpHcEZINHNHbk9PTkVFZnR0TFU1VlpFdUk5V3lOWHpGbHdl?=
 =?utf-8?B?RHZvNlFNVWZ1Z2RoZThsSDcrUHFnaEhqdU9LSm90QkJmN2dGSkJYbnc5eVIw?=
 =?utf-8?B?aWFtUk5UTWpUdEZEeTIrSEVNV3RuUWtad056Y2w3c25SempkOWNWNStuaFI1?=
 =?utf-8?B?YUJYaDZkd1BhWWx5d0VvSlgzbWRYK1liaUxGY3BjR2Q0QVZtNzNuSTVQd0pl?=
 =?utf-8?B?cFRvamVrMFNvRGwxY3ZLTURSc3lhODFVSHAxR1Y3TTJUOHF3VERoUkVQeFpy?=
 =?utf-8?B?NWF0aG03Tk0yQXNQU3FxVmxNOVhUZW9HL0pmTEsvc2E4NXVOM3lnbTdQYnU5?=
 =?utf-8?B?VTljYnZwd0tBbzFPeEVEcmtPSno0ZWd2dVM0RndpUlFCNFZrVUxSMmUwZ0RF?=
 =?utf-8?B?bFF6VlltK2FkYkRYbkF5QXloY3dML1VMR0pQck1abWF2dzhDekc1RW1ETHJG?=
 =?utf-8?B?RUFnaEk5SXBWdUJCZCt6UVQzTTFwSmNMemNRZkNPUGxONDNieVI1VmNoQmU4?=
 =?utf-8?B?ZWNYb1M0eWxzMzlFbDAyazgzb1BXSzhGMHJXK1lHMmIwRDA1N1FhWENOYndx?=
 =?utf-8?B?V01tSDY3SDZmVTZISHB4RlJ0cVkwRDQyQ1hLUGNLV1AzMDhlcGNaVnFzS0Fn?=
 =?utf-8?B?OW1yeHZvbTNJOVZvRkNTekVUeWkxWlNqemtaZDVWMDVkWmZZbGZzaUV1MG4x?=
 =?utf-8?B?MWo2dFZXaVJGRStlMld4c2NTdlZDNGtGUEdTblVHOUxIbklqV2pzaHpyQVVK?=
 =?utf-8?B?WkF6c1pYTjEvdkRUbHg3QmlGSUpoZ2RnWFNqTmdFSUZaTUlUZnM3M09Za3k2?=
 =?utf-8?B?Vk53Qk1QRGoxdnZPdlBnME5lcnRWMkRVTkJkTGNqTFUxWTd5a1lBS24xeXZO?=
 =?utf-8?B?bFJSN0o4dWtXUHphRHk2cmgwbnNtenE3dlZEaEVWMmJESVFiM3RmbkYyRVFH?=
 =?utf-8?B?eHNNMDM4eVpXdUdFcVJGNUxDbzVpS3puZWczSGJxdGJsdFllMTJlUnRHMGFZ?=
 =?utf-8?B?a01VODVLL2oxM0dXejJxeGxsWXNGTlRMWkcycE01T1Rscng0ZUorbTIxcDFp?=
 =?utf-8?B?ejJ6M2NtU3hFYkJ3RkVMQXkySHFTQnpDbnJEcW15aE5waVFINmJRQ3JKUmla?=
 =?utf-8?B?ejBsQ0ZiWXdaWVVaNHdkSXQ1U0xkMURNOTZ4dk94VHZTejZodERJUUdOa2hW?=
 =?utf-8?B?YWFJeHppaHVCMWpJeHdUVDNGZzk3UXd4RnRQcWEzWWkrbVRTeGI3bFk5blBD?=
 =?utf-8?B?TkJBQXF3a0RNSU5aUERDZmtpZDFSaFlzb0phQW12UG9tSUVrOWxkV0NRcURJ?=
 =?utf-8?B?RiszTTBSdXg2bTVKUEFLZHpwZHVBcFF3RTBua091QVFzSU04dXBxU0lzUHJB?=
 =?utf-8?Q?N3BfDvq4tmCRlLHW6hLHd4dxP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A59D6EF1ACFC144C917BF83A01BC57F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f89c79-6084-4063-46f1-08dd18cbbee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 03:35:51.5964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2opBCuEXV+z5aMwQhBs4nsg7D3utaE3AxmtrpvBgL+gv0C3jQwvA6z2A1J5QKT8fvTpDHXmjPvTDW5bXEBRGGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818

SGkgQmFsYWtyaXNobmFuLA0KDQpPbiAyMy8wMi8yNCAyOjU3IHBtLCBCYWxha3Jpc2huYW4uU0Bt
aWNyb2NoaXAuY29tIHdyb3RlOg0KPiBIaSBSb2IsDQo+IA0KPiBPbiAxNC8wMi8yNCA3OjI4IHBt
LCBSb2IgSGVycmluZyB3cm90ZToNCj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZQ0KPj4NCj4+IE9uIFdlZCwgRmViIDE0LCAyMDI0IGF0IDEyOjEwOjA2UE0gKzA1MzAsIEJhbGFr
cmlzaG5hbiBTYW1iYXRoIHdyb3RlOg0KPj4+IENvbnZlcnQgYXRtZWwtYXQ5MXNhbTlnMjBlay13
bTg3MzEtYXVkaW8gRFQgYmluZGluZyB0byB5YW1sDQo+Pj4gYmFzZWQganNvbi1zY2hlbWEuQ2hh
bmdlIGZpbGUgbmFtZSB0byBtYXRjaCBqc29uLXNjaGVtZSBuYW1pbmcuDQo+Pj4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBCYWxha3Jpc2huYW4gU2FtYmF0aCA8YmFsYWtyaXNobmFuLnNAbWljcm9jaGlw
LmNvbT4NCj4+PiAtLS0NCj4+PiAgICAuLi4vYmluZGluZ3Mvc291bmQvYXRtZWwsYXQ5MXNhbTln
MjBlay13bTg3MzEueWFtbCB8IDYwICsrKysrKysrKysrKysrKysrKysrKysNCj4+PiAgICAuLi4v
c291bmQvYXRtZWwtYXQ5MXNhbTlnMjBlay13bTg3MzEtYXVkaW8udHh0ICAgICB8IDI2IC0tLS0t
LS0tLS0NCj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKyksIDI2IGRlbGV0
aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb3VuZC9hdG1lbCxhdDkxc2FtOWcyMGVrLXdtODczMS55YW1sIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2F0bWVsLGF0OTFzYW05ZzIwZWstd204NzMx
LnlhbWwNCj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+IGluZGV4IDAwMDAwMDAwMDAwMC4u
ZjYzMzA3MDdmZTFiDQo+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9hdG1lbCxhdDkxc2FtOWcyMGVrLXdtODczMS55YW1s
DQo+Pj4gQEAgLTAsMCArMSw2MCBAQA0KPj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+PiArJVlBTUwgMS4yDQo+Pj4gKy0tLQ0K
Pj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3NvdW5kL2F0bWVsLGF0OTFz
YW05ZzIwZWstd204NzMxLnlhbWwjDQo+Pj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4+ICsNCj4+PiArdGl0bGU6IEF0bWVsIGF0OTFz
YW05ZzIwZWsgd204NzMxIGF1ZGlvIGNvbXBsZXgNCj4+PiArDQo+Pj4gK21haW50YWluZXJzOg0K
Pj4+ICsgIC0gQmFsYWtyaXNobmFuIFNhbWJhdGggPGJhbGFrcmlzaG5hbi5zQG1pY3JvY2hpcC5j
b20+DQo+Pj4gKw0KPj4+ICtwcm9wZXJ0aWVzOg0KPj4+ICsgIGNvbXBhdGlibGU6DQo+Pj4gKyAg
ICBjb25zdDogYXRtZWwsYXQ5MXNhbTlnMjBlay13bTg3MzEtYXVkaW8NCj4+PiArDQo+Pj4gKyAg
YXRtZWwsbW9kZWw6DQo+Pj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy9zdHJpbmcNCj4+PiArICAgIGRlc2NyaXB0aW9uOiBUaGUgdXNlci12aXNpYmxlIG5hbWUg
b2YgdGhpcyBzb3VuZCBjb21wbGV4Lg0KPj4NCj4+IGJsYW5rIGxpbmUgYmV0d2VlbiBEVCBwcm9w
ZXJ0aWVzDQo+Pg0KPiBzdXJlLCB0aGFua3MgZm9yIHBvaW50aW5nIGl0IG91dC4gSSdsbCBmaXgg
dGhpcyBpbiB2Mg0KPj4+ICsgIGF0bWVsLGF1ZGlvLXJvdXRpbmc6DQo+Pj4gKyAgICAkcmVmOiAv
c2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9ub24tdW5pcXVlLXN0cmluZy1hcnJheQ0K
Pj4+ICsgICAgZGVzY3JpcHRpb246IEEgbGlzdCBvZiB0aGUgY29ubmVjdGlvbnMgYmV0d2VlbiBh
dWRpbyBjb21wb25lbnRzLg0KPj4+ICsgICAgbWluSXRlbXM6IDINCj4+DQo+PiBObyBtYXg/DQo+
Pg0KPiANCj4gSGVyZSwgdGhlcmUncyBubyBleHBsaWNpdCBjb25zdHJhaW50IG9uIHRoZSBtYXhp
bXVtIG51bWJlciBvZiBpdGVtcywgc28NCj4gSSBvbmx5IGVuZm9yY2VkIG1pbkl0ZW1zLiBQbGVh
c2UgbGV0IG1lIGtub3cgaWYgSSdtIGRvaW5nIHNvbWV0aGluZyB3cm9uZy4NCg0KUGxlYXNlIHJl
ZmVyICJhdG1lbCxhc29jLXdtODkwNC55YW1sIiBhbmQgDQoiYXRtZWwsc2FtOXg1LXdtODczMS1h
dWRpby55YW1sIiBiaW5kaW5ncy4NCg0KPiANCj4+PiArICAgIGl0ZW1zOg0KPj4+ICsgICAgICBl
bnVtOg0KPj4+ICsgICAgICAgICMgQm9hcmQgQ29ubmVjdG9ycw0KPj4+ICsgICAgICAgIC0gIkV4
dCBTcGsiDQo+Pj4gKyAgICAgICAgLSAiSW50IE1JQyINCj4+PiArDQo+Pj4gKyAgICAgICAgIyBD
T0RFQyBQaW5zDQo+Pj4gKyAgICAgICAgLSBMSFBPVVQNCj4+PiArICAgICAgICAtIE1JQ0lODQo+
Pj4gKyAgYXRtZWwsc3NjLWNvbnRyb2xsZXI6DQo+Pj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBl
cy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+Pj4gKyAgICBkZXNjcmlwdGlvbjogVGhlIHBo
YW5kbGUgb2YgdGhlIFNTQyBjb250cm9sbGVyDQo+Pj4gKyAgYXRtZWwsYXVkaW8tY29kZWM6DQo+
Pj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+
Pj4gKyAgICBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGUgb2YgV004NzMxIGF1ZGlvIGNvZGVjDQo+
Pj4gKw0KPj4+ICtyZXF1aXJlZDoNCj4+PiArICAtIGNvbXBhdGlibGUNCj4+PiArICAtIGF0bWVs
LG1vZGVsDQo+Pj4gKyAgLSBhdG1lbCxhdWRpby1yb3V0aW5nDQo+Pj4gKyAgLSBhdG1lbCxzc2Mt
Y29udHJvbGxlcg0KPj4+ICsgIC0gYXRtZWwsYXVkaW8tY29kZWMNCj4+PiArDQo+Pj4gK2FkZGl0
aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPj4+ICsNCj4+PiArZXhhbXBsZXM6DQo+Pj4gKyAgLSB8
DQo+Pj4gKyAgICBzb3VuZCB7DQo+Pj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkx
c2FtOWcyMGVrLXdtODczMS1hdWRpbyI7DQo+Pj4gKyAgICAgICAgcGluY3RybC1uYW1lcyA9ICJk
ZWZhdWx0IjsNCj4+PiArICAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfcGNrMF9hc19tY2s+
Ow0KPj4+ICsgICAgICAgIGF0bWVsLG1vZGVsID0gIndtODczMSBAIEFUOTFTQU1HMjBFSyI7DQo+
Pj4gKyAgICAgICAgYXRtZWwsYXVkaW8tcm91dGluZyA9DQo+Pj4gKyAgICAgICAgICAgICJFeHQg
U3BrIiwgIkxIUE9VVCIsDQo+Pj4gKyAgICAgICAgICAgICJJbnQgTUlDIiwgIk1JQ0lOIjsNCj4+
PiArICAgICAgICBhdG1lbCxzc2MtY29udHJvbGxlciA9IDwmc3NjMD47DQo+Pj4gKyAgICAgICAg
YXRtZWwsYXVkaW8tY29kZWMgPSA8JndtODczMT47DQo+Pj4gKyAgICB9Ow0KPiANCg0KDQotLSAN
CldpdGggQmVzdCBSZWdhcmRzLA0KRGhhcm1hIEIuDQo=

