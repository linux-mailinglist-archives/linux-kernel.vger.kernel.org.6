Return-Path: <linux-kernel+bounces-322667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD4C972C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF8D2880CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0A8184555;
	Tue, 10 Sep 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="tNY8bcpw"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2053.outbound.protection.outlook.com [40.107.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067BA14A4C3;
	Tue, 10 Sep 2024 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956463; cv=fail; b=DqnZsdlHheDqmYVaEso/pNUMkZvL1TDWceRY5Cfgo9ro3jvH6w2fFRFpeMk4J6EJdiw+auz+he2zXzTRuxB6tnq2AhYzBXBKzYpIBcTPvIczE68j3ZiKMBWa4QOf9qxdLYT+Ngj5LO5yUigwvIexPVwxyOYPU36eM3deJBkbdwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956463; c=relaxed/simple;
	bh=QWGW7ykYo4DDLRrR1TKFuJXc9PYaKOGbIY8u7tngefk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p+93n+zJRH9VuzU7r+qApKnB1d0qXe56pGCrwRCi7gO/fe3cbvfdQ8+qwhtavH9Fb4AqkxFL+HDbd6JqOlo09M1JJd8fCdepGoH5hVflAarrQBzXiSlX3+qbhCkjn4K1sfXFmr7cYxF486YoNy13k1XqPlxxz42+pi8uBZ2MLOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=tNY8bcpw; arc=fail smtp.client-ip=40.107.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8mlsuVdXSNPn9QasNyFLIgY8sp0meO0evqPFjD1hQyzALwlQKtcmG58jK9VjeAX/qrmr60xsGMCdnX0aaRdvCKni108hHtYzbHNTuckDP0MEVXggO/JKIXF+TZmCIFdZz65wmXfXrNyMfjZ2hcQhrK6QDapmmPQBaIDSjT8MV1+L5N/warERsBYWaCWWxqCXCw/Pa4uHD/CcL5+Yc3daB4iJnNXcrllwWzadvv4VCN5ZsRPmPWLYV/RoPuaOLGDWPlUN/O9ESoyvZBoF0kPQ6gBuhW0/qdIbTUBlgk5wz+HSsz7nFasBmfuCM/NSMLbT7ASpZDag2c4WMLB8hLTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWGW7ykYo4DDLRrR1TKFuJXc9PYaKOGbIY8u7tngefk=;
 b=Qh118B/DRt4aPz1CPrsem4R6lsldh9hAk2l+sPvBBeGc+IOYiB6dtK+CCtp4gKxtQcYF+jEHc/f6h6n/rE9L9JShz1L9RGdU+rtb9SVIWvOspx6Zh7F7GfPG7ZMt8Xc8fjbY+NXbD76dPk3LvAVzisQ5SxXeYvG/9gM9uffJpsSoCGyoR55JJkN93i1FLyk83j56FvOFOFiUkAq83PHU53A8jsWe2RJJNkwGiUG4e2m8tjSyRSpfDvBKpXq2QPCGK55DUClw14NLBg0pEA0hInQngmGKMQYM95aZ4k1X1tE+Tui6ouYS1FOJO7MosntxZiLbiyw+e1TFNIl75aWsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWGW7ykYo4DDLRrR1TKFuJXc9PYaKOGbIY8u7tngefk=;
 b=tNY8bcpwHgrZs/bpQc0Y3zc+uhNzWvNHMnj1X0jfexcLafdLq5O7UHElgZAw24XbwpIb152TI/+TO3bOQlZjnB7RhmJNz9q5f/wqJOtsamBz59ydnXXx6OKFiUgDbd73DEW45YXdXHy9zOBHSboDgKcC3EZoXEjVBvfkzA63jfYH5FDHn+03zbP23ME746ouq7Nqb63nQ9UHvtALd7k1VlsrFj4bPleQcNuFlYLL9CEGGX2thWX2VrPZhD1gPbgcAg8Ar4MeCJNItNMoVju5ljoW6FIBPyrireomVuBIu7EU+T2/4+7qfeY+7+dz/HlPj4T7JsMx6R4bmSDJ+DuIqQ==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by SEYPR04MB6871.apcprd04.prod.outlook.com (2603:1096:101:d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 08:20:58 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 08:20:58 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable interrupt setting
 for pca9555
Thread-Topic: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable interrupt setting
 for pca9555
Thread-Index: AQHbA0xDBqBHzMeSJ0qlHcI2T1uCCbJQoAuAgAAMc/A=
Date: Tue, 10 Sep 2024 08:20:57 +0000
Message-ID:
 <TYZPR04MB5853795FDC6497F7E0114E43D69A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240910063952.3006665-1-Delphine_CC_Chiu@wiwynn.com>
 <42049344-fafb-4aee-8423-fe09a1a977f2@kernel.org>
In-Reply-To: <42049344-fafb-4aee-8423-fe09a1a977f2@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|SEYPR04MB6871:EE_
x-ms-office365-filtering-correlation-id: ca0d9223-c803-4ff2-0101-08dcd1717f7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1k5d1B5VEYyTjc1bk52S1NKa0ZZVzZnRUh4T29VYTVib0RNeTQyRlJJZ1lz?=
 =?utf-8?B?aG9YTytCZ3IyVkNoelloL3VJRzA3VjUyWVRScVIxdVN0VHlqOTQ1TFUwbGVV?=
 =?utf-8?B?RkszS1VhUloxYjFjT29EaXAvZjhsWFcxODNmT3JMK3VHWWJ4NkREdXpJNTQ5?=
 =?utf-8?B?TVdQcFJQUkcrN29rMkM5UmtmNnp5anJHODFPQ3JoV3VBWlBCYzFTclN5QW1P?=
 =?utf-8?B?ZlhlRW44OUJqbzZlNWVBVkpLYmJmWk1KY2tDTkw0QlhKazRBMUwrWWs4NStF?=
 =?utf-8?B?MWovTXZLVkY4MUcvQmxkeTRwWkVoUWZib24xWkZFQVA4dXFrVkFhSEJQbS96?=
 =?utf-8?B?Ny9aMUduaEFsaWdRMk92YUtVdUN0TE5zTXYzZjJXUzdZTUFoeVpxU29kV1Uy?=
 =?utf-8?B?ekJEREwyV1dKOW4rR0FBWjBnUytLM3I0SGtwb21zckRYZGFZcC9PdWdoei9y?=
 =?utf-8?B?dnE4SEhNa3prb2JXM3hLNHQxT080dGttdlJIQWorM3daSGpHT1o0V2k5WDRC?=
 =?utf-8?B?UjVMVjhZTGV2L1BRZ2tINzBEY3hTbG50WkZzZlU4RXRCeERxdzl5Wm42L0F0?=
 =?utf-8?B?WUIvMFpwcG5rMmFPYnBEWXZjdVI0RTFDOUZNSTRWRU9Jb3RidUZTYW5IWkxq?=
 =?utf-8?B?aHpsdnhMMGxKVzEvMW8zak5CSjJxV2NPNXBnbnV2ckFtKzJxdmNYUXlHZmww?=
 =?utf-8?B?aG9PTytGc2lpSVdLcmhNRGRRQmMwMDh1UHBPTVlJeUdES2hLeEtPTExyM2RN?=
 =?utf-8?B?SmtXNnFyZHdWSGcrRFlPN2MwNVBYeDVTMG1FUUp1ZkNDRDVpN0svc3h3aWY1?=
 =?utf-8?B?ZmFjTGJsL2tLcUZROVJjZEFKelhQbzF3ZTl4Kzc0c1lJeVV6VEhnVnp6Y1lM?=
 =?utf-8?B?NkVWcnlMR3dYeGpBSTBSWUxmdlVUeDk2dVNvWTFkR3FRaXYza2NYa2dVSXRM?=
 =?utf-8?B?SzVQVTl5Qk9kUVRQT3B0L21TZDN4UnUzYnZJckdXbXBqR0pOYW1QemZWMVkx?=
 =?utf-8?B?UzU1TTJxYllNdGlHSzJFL1VNR1JuMGFSZi9CWStLOVp1WXJPV2JkeVJMREsz?=
 =?utf-8?B?WUc4ZTNMOG9mam42Zk05a29BcFM3K0cwbXQzcHdEQTEvOEd6UmpIL2lXZklZ?=
 =?utf-8?B?Tmg2aEJ2bUNXc21Mdy9XSStUY2hScmg4aHR6NEoyZW1IMmMvdUU5d1ZIWFEv?=
 =?utf-8?B?S0EreXkrRkNpQ3BNWDJLRnNSdklDcnlZTDUzbWx6c056SjhtakQ3elJlQS9L?=
 =?utf-8?B?N1M2WGZWTkJUejlBamJYWUl0bUhwWVpURGN0OHZvOGlMN2hCTUFkSWpxZU9V?=
 =?utf-8?B?eU5zUENKZ3BWY1Y0dk5ZYWlEZ0w1MmhncFQ2NEVWR2NrcjJIWExId0hGN0h5?=
 =?utf-8?B?MjdUcG9VNk1OQit5ZG9BTEJsMG5yV2VySmx1Wk9NMUI3ZWRreExnTzB6ZDI4?=
 =?utf-8?B?N0dqUnNkVjVrTlA4eTJzTmtuS1NOQVU3L2lqZjFPQWRSRDlQZGIvcG5oNlZM?=
 =?utf-8?B?UnNIeURLRGhaV3VKSzFRR1Y4c29od1dRVUxOYlBLK1dnS1d5M0tWcmlyMkgy?=
 =?utf-8?B?aFQ4ZndhYmZwVis2cDFUNHQvZ1Awcm9abk51b3hlenlUZ2dRL21ya05ZQ01n?=
 =?utf-8?B?OXVjblIyNzZEYXZUaUFOV3lUam5hTFE2dzM0SDlvUnpaU0hmOHNGdmhDNjcr?=
 =?utf-8?B?ZlFKZmhPUFV1NDhPaEtQOHkxeElPcEhjODQ0amdGNzFJVkhWOXIzRFNsTnZi?=
 =?utf-8?B?L3JWWnhnemxQN05zdW12MXlsS29yWUVOd0dIeHU1SzRVU0d0aE9hNm83ZjNH?=
 =?utf-8?B?cGJQejBWdnRhckcxRDlDWm9acThPb1ZEVW43OThWOGZhTHhBR2d2T0UrM2hC?=
 =?utf-8?B?dk0vQlhjMjNncnpGUVJ4MnNVcTg0Rk54clVXTnZkWjdUTFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2RzTEVmRWdnZFYxb29PblE4NVRxbTdCZVZwdlNlTklhRlBCZVVMeVN6dmlv?=
 =?utf-8?B?TThLajJaeEpxTmJEUnNmczNjeEJ1ak5KRCs4WmZHZ3VPZUR6VC9YZGVIbytE?=
 =?utf-8?B?R2FJN3VPcm55dW1WbHFZb3VjVGdwcVBHVHZHeVBtSndENCs2QS8wbzRNTzhL?=
 =?utf-8?B?NmprRmF3UUhIR082QnNDOWVkRWVQWHQ1UjIxS092aGlsVmVpRjlBVDZ3UHFq?=
 =?utf-8?B?U3V0eDZuV1NTZk90a1d0NTRKLzF0YjdQZDhyTjZPNjc3L2ZRYTZsQlpWdUNW?=
 =?utf-8?B?WmdKWWR4Z0RqblVsbXlzNktWVHR2MHpLWHJGKzBTaUtOVWQ1cXFiWlUvRUhQ?=
 =?utf-8?B?UEg2eEkyYjhBR3Q2VTlKdUVJVERzelBqV1cyU1dMVEoxaEQrTVdid3ViZFdE?=
 =?utf-8?B?NGJmUTJjN2l0YkxSZEg4YlJwWVNYY2doNUhqY0h5N2M0OHNmdGlKUXlScmVT?=
 =?utf-8?B?bmZncW5scUFOZk5yeUxEVVMzeE1IM2w1NmFyMGZkdGtYNVpmRHFpUnRERTY3?=
 =?utf-8?B?M2xWUFE2OXhCTXFNVHhDNmJvKzg2QWgvd09ldDI0a1NWRmtPQk5BNysvUGJY?=
 =?utf-8?B?cHczMjQ0anpIQVJKd1JWa09jUlpWSmJlRHVYZ1BUUzMxNWNINk5LaktENlJ1?=
 =?utf-8?B?K2hyekxhZGE4cXdDRUFZRkg4ZG9JNkhGb1V4MFRuSDlFWVR2UXBhTCtVR2dC?=
 =?utf-8?B?WER2K0NBNlhjcVY2aDNTQXdvV2s1MzdPMWhZL2FqaFYzVFppN0YySVBzTUZE?=
 =?utf-8?B?ZlJ0Ry8vSUU1VDB5MmVnTkhyUURwTkFocjdzK3d3YTd3WERuM3JOb1ZyYnpS?=
 =?utf-8?B?NmtVcHBJbEdwQWZnR3FCL2xCVUJ1VW1lSVdpVzlBL3FwYWpISXlIWE8ydDVu?=
 =?utf-8?B?MkFzUmVkcDVxS0E4VG1vcS9YamU0b1AxRWdEZWh2N1RQcVlzRFJtdWJCanBR?=
 =?utf-8?B?QzlnWFF1OWFHbnl2Q3RZdGxtYURIT2VmSWZCVEpxblRnYzEyMHByVDNNVTNm?=
 =?utf-8?B?MHJuZ0d1Zi80NEFPVzNHaFBDdXpsZm5KdUlUSHk1YUZCcWl4ZkwyM3pqTERu?=
 =?utf-8?B?WmFGeEZDUng4WXB4Ynk5dEN3VnFybThZc3dMcUcwVzM5M0NHYmZNWndFcU1E?=
 =?utf-8?B?dGEzNXR0NUNqcFlYM1V3T1V1aytmdUsya2VYaEwrZzVWOGRZQm5RTU9qVm5E?=
 =?utf-8?B?WXEwN09nRzNqVTlsUTJGcEFFa0puL3lTQlNVd2ticHo5TklEVDVCN1NkRnYy?=
 =?utf-8?B?N1BJN090VDZmdE5BVWRmUjhTamI0b3hCWXNFanNsdzE5RDVtM0JhSkgwSlFX?=
 =?utf-8?B?b0pOYncxb0RncExYS2loaERQV2pjZkhDSDF1d2JjV0NVb0kzMVBDMFZsNEZF?=
 =?utf-8?B?NUI1Wk9vZ1ZSSStzUXc1WHhqTWY4VjlYVU9EM05kYm14MnRTOWx1bVdVdXF4?=
 =?utf-8?B?OUZNUUozYjFDSjM3K0RERkwwNmhoQVNzYVpZaFFYQ2trTEtURXcwclQrYi8y?=
 =?utf-8?B?UGx6eEdIRHczemM1RUk3TDRtZkNaUEVmMDBsMlovUTNsR0JNRkdZYnRybWJW?=
 =?utf-8?B?cVpIbUQyVmpsR2ExYVExcTNPdTliSmxWREw2N0xJVmdzclptL0lkNWpXWHJp?=
 =?utf-8?B?RENEY0hOWVRXdmpacHFRNFlpWldMWlNuV3d3QTNvUjhSUmpack9XRVlOVklv?=
 =?utf-8?B?ajNmNjJKUUx0d1B5R3NWYjdMQXNITlB0SFF4cElUOG56eS91VER6TFlhWHAv?=
 =?utf-8?B?NUJrSS9uRlZCU3hEc2hST1RxY0F3QVdzL3hsaUpJTUVZYXFYNmtHQ1d2bFlw?=
 =?utf-8?B?QlNOZWNzZzc2YkppQkl6ZEFPczc0SjJiR3NBNDd5ZGl0MHFNV2J1aHM5SFk1?=
 =?utf-8?B?dTUvaHBIYkxGUVd2ekJpZzZxS0t5L2VVcnFZN1gyRVdlZENnRldPbWU5T2N4?=
 =?utf-8?B?U0RBTnJlTTFyUzUwZlZDS1h6S0daay9rUlo4QlBCRGx3SWVPOGRBN3UyREhN?=
 =?utf-8?B?a1NxYlczTHFrSm9vajJpZVloSm5QNVFhOFg4NkNEcCtOenpVNWl4UVdYbEN6?=
 =?utf-8?B?UmpoWk9sbFNwalRLbmVsMmVxVS9VY2x5ZXZCdzgvR1RLKzNXVyt6OVNQdkk1?=
 =?utf-8?Q?OTcUD/wIJzapid7fZVj2FqZ3w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0d9223-c803-4ff2-0101-08dcd1717f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 08:20:57.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEmuZMm6FC4nzWPw4FgQxsE21a8JSD/69gpBLCJ5dfi+1w9fphT+qxaBqJsdE3kL6gzZmsiTySS9ZfG0en+trA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6871

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTAsIDIw
MjQgMzozMSBQTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8RGVscGhpbmVf
Q0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtlcm5lbC5v
cmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0YW5sZXkNCj4g
PGpvZWxAam1zLmlkLmF1PjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNv
bS5hdT4NCj4gQ2M6IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwuY29tPjsN
Cj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsNCj4gbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gQVJNOiBkdHM6IGFz
cGVlZDogeW9zZW1pdGU0OiBFbmFibGUgaW50ZXJydXB0IHNldHRpbmcNCj4gZm9yIHBjYTk1NTUN
Cj4gDQo+ICBbRXh0ZXJuYWwgU2VuZGVyXQ0KPiANCj4gIFtFeHRlcm5hbCBTZW5kZXJdDQo+IA0K
PiBPbiAxMC8wOS8yMDI0IDA4OjM5LCBEZWxwaGluZSBDQyBDaGl1IHdyb3RlOg0KPiA+IEZyb206
IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwuY29tPg0KPiA+DQo+ID4gRW5h
YmxlIGludGVycnVwdCBzZXR0aW5nIGFuZCBhZGQgR1BJTyBsaW5lIG5hbWUgZm9yIHBjYTk1NTUg
Zm9yIHRoZQ0KPiA+IEkvTyBleHBhbmRlcnMgb24gTWVkdXNhIGJvYXJkLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndpd3lubkBnbWFpbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogRGVscGhpbmUgQ0MgQ2hpdSA8RGVscGhpbmVfQ0NfQ2hpdUB3aXd5
bm4uY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2steW9z
ZW1pdGU0LmR0cyAgfCA1Mg0KPiA+ICsrKysrKysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDQ4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0DQo+ID4gYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1mYWNlYm9vay15
b3NlbWl0ZTQuZHRzDQo+ID4gYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1m
YWNlYm9vay15b3NlbWl0ZTQuZHRzDQo+ID4gaW5kZXggOTg0Nzc3OTJhYTAwLi5jYjI0MzYwMzEx
ODEgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMt
ZmFjZWJvb2steW9zZW1pdGU0LmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVl
ZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRlNC5kdHMNCj4gPiBAQCAtMjk1LDMwICsyOTUs
NzQgQEAgcG93ZXItc2Vuc29yQDEyIHsNCj4gPg0KPiA+ICAgICAgIGdwaW9AMjAgew0KPiA+ICAg
ICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJueHAscGNhOTU1NSI7DQo+ID4gLSAgICAgICAgICAg
ICByZWcgPSA8MHgyMD47DQo+ID4gICAgICAgICAgICAgICBncGlvLWNvbnRyb2xsZXI7DQo+ID4g
ICAgICAgICAgICAgICAjZ3Bpby1jZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAgICAgIHJlZyA9
IDwweDIwPjsNCj4gDQo+IEhtPyBXaHk/IFRoZSBwbGFjZW1lbnQgaXMgYWZ0ZXIgY29tcGF0aWJs
ZS4NCj4gDQpJIHdpbGwgcmV2aXNlIGluIHYyLiBUaGFua3MhDQo+ID4gKyAgICAgICAgICAgICBp
bnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvMD47DQo+ID4gKyAgICAgICAgICAgICBpbnRlcnJ1cHRz
ID0gPDk4IElSUV9UWVBFX0xFVkVMX0xPVz47DQo+ID4gKyAgICAgICAgICAgICBncGlvLWxpbmUt
bmFtZXMgPQ0KPiA+ICsgICAgICAgICAgICAgIlA0OFZfT0NQX0dQSU8xIiwiUDQ4Vl9PQ1BfR1BJ
TzIiLA0KPiANCj4gTm90aGluZyBpbXByb3ZlZCBoZXJlLiBJIGFscmVhZHkgY29tbWVudGVkIGFi
b3V0IGFib3ZlIGFuZCB0aGlzLg0KPiBJbXBsZW1lbnQgZmVlZGJhY2sgZm9yIGFsbCB5b3VyIHBh
dGNoZXMsIG5vdCBvbmx5IG9uZS4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQpT
b3JyeSBhYm91dCB0aGF0Lg0KSSBzYXcgeW91IHNheSAiQnJva2VuIGFsaWdubWVudCIgaW4gdjE1
IHBhdGNoLg0KV291bGQgbGlrZSB0byBhc2sgaWYgdGhlIGZvbGxvd2luZyBmb3JtYXQgbWVldHMg
eW91ciBleHBlY3RhdGlvbnM/DQorCQkJZ3Bpby1saW5lLW5hbWVzID0NCisJCQkJIlA0OFZfT0NQ
X0dQSU8xIiwgIlA0OFZfT0NQX0dQSU8yIiwNCisJCQkJIlA0OFZfT0NQX0dQSU8zIiwgIkZBTl9C
T0FSRF8wX1JFVklTSU9OXzBfUiIsDQo=

