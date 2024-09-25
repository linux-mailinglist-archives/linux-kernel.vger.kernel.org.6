Return-Path: <linux-kernel+bounces-337947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EF2985156
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C701C22E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88649149013;
	Wed, 25 Sep 2024 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MGQRfQwW"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2047.outbound.protection.outlook.com [40.107.215.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A370C1B85EC;
	Wed, 25 Sep 2024 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727234196; cv=fail; b=p2Wl6AAYloheRh6SmQ0EyhA6ND1CJi0PKVaKd1UqpgzjCZIchItsLZnJIXJjo9myyO+jJVyFAjjVSi3y1sfuF696i8wJW4EmGc010vdCxPim6L8B64NCfNe0ROOGJEeR8OLD4QTlHsjBbUtYYKXeM5Bm2gLCUjAqSjjBWWkFW7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727234196; c=relaxed/simple;
	bh=1G7DatTAi+/a4pROanNqE7Yxbu6UySyP76dYSyy/aos=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sMyTpoo5GX2MFFJ6pSNuQPpoHBB6UBPp99WWFlcj2fQ53r+J3jyhExNAU9e7cjk65Y+q5cvHhSr7jxWQqDggQ1UGe2t6Mzav93hTk2o/8PpMc7nQS9r8C92H7ZiOaKo3o6aVxMWi/ZIJhrCdlxE2Sn3xUG0AHB7t9ZK5ccSt5cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MGQRfQwW; arc=fail smtp.client-ip=40.107.215.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHWRaUWHpNrQ+Zm8h/GV4Q3DZRPOWKNVBwx/ct2Ien9zOY9LawrHwK6DkWedomQdAiEqZXELwQejXjWf+i2fSE2m3D8ZZfy0suxMQuDRBwewxZBExTXRL8JUR1NaNe+L7k+3ZrrIP0Nd3EoJcRWS3DQAqpJhPivZlODK579cZQDvdMjeZQ9hgMzO8cTaM9Iu3+AxrFjk5AqeBSK4+UkbNe4FEcCQaydFOZ0eNEO8dCenMMyrzQFUbUYjFlBjtXcI1nk6TNmVf9odARTNDFTqkQKP+xz2Jh3GEYqniwlTw6Ie4MmG2HQ6at5S7Nzjh52qxpKxI5PgsbV2enjL+EUyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G7DatTAi+/a4pROanNqE7Yxbu6UySyP76dYSyy/aos=;
 b=MzOaKd2JOGyzT0V9or522z3CDOF3VM+C2tdH7TL0JkNRYad4oq9vWzj0tneQ7i5VV0ocWoSsqMmxK0xr35P/orlzHxMjb6BGOyRZ0qow6zfERSx68QzHKUCZOGLQXqbori1HUbskxZpqVMQ7Hjb0J0m5fEwfw1nnCPfkZav3S+fbvipC5TMk9YKrWq6hFhwdvloTa4Xv3gP+4Bayp/Bn0NBAnCIlEiL1VSatV+a/uNuHr2tV8i46+AOuWPRVfiM78p+6UsBkZU+FY6CWxTzqZ6Y6j3cVBpzcTVEKqFr1wA9LpO8HXavPkr9u2wfzPGllRK26U0cE2DPplYOA4fK5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1G7DatTAi+/a4pROanNqE7Yxbu6UySyP76dYSyy/aos=;
 b=MGQRfQwWOMwtiGnOkhwfE15lDNRaWRWeFi//vS/9qFAYjAJlvdw349qrN+XktgQbLgjIxIAdazBaR2Gu4MOfJgIlLoArpR+J6rqEB7LR4akk3qq0kn3s42Ee0Lks6oMB/biP91UpMhZ/rF1skvKzBG+6T7G0jjQVK5FSMDhPU44i5GNYMWP9KLBk23YrMSgDguOV/zgMD9gGyOCuXYTICZRLk12smDkvmSof4Tqvq7q1eI2s7WOJy5tNyJYJB8EToP1OlXor4Uiai77IVGPbR0EXwZExpty4LlJZ3l4ujEyDbIuYyPmil3eyUhKuF7oBSoxV8RZvr0wI7JVceUo1KQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by KL1PR06MB6260.apcprd06.prod.outlook.com (2603:1096:820:d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 03:16:29 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 03:16:29 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"mbarriolinares@gmail.com" <mbarriolinares@gmail.com>,
	"wangdicheng@kylinos.cn" <wangdicheng@kylinos.cn>,
	"mmccarthy@mcintoshlabs.com" <mmccarthy@mcintoshlabs.com>,
	"xristos.thes@gmail.com" <xristos.thes@gmail.com>, "cyan.vtb@gmail.com"
	<cyan.vtb@gmail.com>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
Subject: [PATCH] ALSA: usb-audio: Add delay quirk for VIVO USB-C HEADSET
Thread-Topic: [PATCH] ALSA: usb-audio: Add delay quirk for VIVO USB-C HEADSET
Thread-Index: AdsO+FBn473lP8g0TTuwq9xMocctZw==
Date: Wed, 25 Sep 2024 03:16:29 +0000
Message-ID:
 <TYUPR06MB62177E629E9DEF2401333BF7D2692@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|KL1PR06MB6260:EE_
x-ms-office365-filtering-correlation-id: 208fcc85-4c5e-4116-9c2f-08dcdd107297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?V2RsNVk1dlRPcXRSNDVEU0FZQmZoanBqYjZDMk9pN0Ivb0JqTzR4b3FkN2JC?=
 =?gb2312?B?WUp4UHcxMnU3UytjdUlybFZvNkEzV2U0dEoyVVpVLzJQWlg2U2xBWWc1Wld1?=
 =?gb2312?B?aE83cm5lOVdaYkNiUXpJRnN6WVVzRmFtczZWZWF6UWxQcmpITk51OHFiMmlN?=
 =?gb2312?B?N1ZBYjZMdU05dWcraTlKdGsyNmJpdE9EVElReHF5Y0J5NzdrUVVmMDdPVjVs?=
 =?gb2312?B?NmhNVTE2REpxQTgzc255elE3bWZLYnhCQkZtZkZJUGM1S3d3OXk4WExVSGxP?=
 =?gb2312?B?QlF0WnVRZFNCa0U1L3NXYk1jcklucCtHQnVrdHc4RDJ3dVZRYXBVcngrYXpZ?=
 =?gb2312?B?Qk5aK2Y1TlJwSkk2R2N6elFuTzRuMzVyd24xTER5STM0bjFYY0VSc2g1bTVp?=
 =?gb2312?B?UDJkQWlwUGpoSS8wQS8zWE56R2FDQnJCQTlTRHQ1VnRZWDA3ZG9XUG95QTQ1?=
 =?gb2312?B?eXZ3NThhczVvamVJU1lzQ0xidG4rYkJpb080WDZzdHd0OFVxT1lUWVhZV0cv?=
 =?gb2312?B?eWZhWGZuTWRkaC9TdExMRkxyS0dWbkhtajhJUE5yNFZsTFZCSXhxendSRVdH?=
 =?gb2312?B?Nm1VZXpLVGVkUmdROFNKQXZqMGtFdnZ6K0FJeG5lV21CV2pEWHpvSzJ5dUd3?=
 =?gb2312?B?alFFcVZDNjRGWk5INWZxOHNuandNbDZGUkRYR01rQUV3blEvUUNiV1kxZCtq?=
 =?gb2312?B?alVjY3JLcU85cUduRTAyRjZVNTZGUlI3U1pNWjQzT0l0VnhMS1lUMzZrVWdP?=
 =?gb2312?B?QklzRVBQWEhlQitoZk1vNGFob0dEOUNyckhkNUR6UDFhMDJLZ2J2dXFaQ0lI?=
 =?gb2312?B?TnA4d1p6czZkTlAzQUtJWWlsTG1TNDZPY2U3NmtxeHlkVkFCekR2TU5SRHZo?=
 =?gb2312?B?S29rejRJZ09NZ3ViazEwS0R3N2JialB1dW5TZklIYWtTY2o0ZUpDSGsxUllC?=
 =?gb2312?B?Y0FnTkxRa2lHdERXdlluOEdGV3lxUnRGU3V0WXBnVElRK1NDU3I2a3U1V055?=
 =?gb2312?B?UDN3S3kyNkF3S3Z4K211ZGhwMzEwcDk0QlNVOTZpbGNGL0xpY1M3ZWwrckVE?=
 =?gb2312?B?Y0J5aWRaMS8zSUd6bmpNQ28zcnFiVjl2NXRrenZtTTJqbGRCcU14cVY3TXJH?=
 =?gb2312?B?dU9pWnZlb0ZiTXVCNk1MTWJnTkEzWHVYNGo1K2pnVlpmQnpDYURZZ2JocTZN?=
 =?gb2312?B?NTgrK2ZtbVVPQzZFWm9tMUlyRk94YjdNbDVDR0dETGVwaTFKeVZIaHZuK0J2?=
 =?gb2312?B?bEMvbzVrNEd6Mlo5RDZVVDJTUXNYR1ZkRm5qbDVkM2VmT2JOdUFGbTZGZk1W?=
 =?gb2312?B?TWN6WUNNbEtUdk9mMStMNkZGTTBVemtRcWErMlFUOFZrRUxRQWpncDNYRzEy?=
 =?gb2312?B?SHZ1dGwwdzJFZVUya2kvSUJ3ajlQdlMvS2lNVkVRN0o1SWxsb01EeU5KV0kx?=
 =?gb2312?B?NjBhWm5lSkNSY2oxbFo3TjlKazV1YVJSTzlaZktydzFRaTJTcElsbWxOUURB?=
 =?gb2312?B?RUVDKyt1VE0wRGdBSlRBcnAwZVlRSTlQTmFUSmlDQ0hWd2ZldmxRU0lETjgr?=
 =?gb2312?B?OVVXclFRSklSaHdLVGhNSlN6L1FkdWpRT0NJS2lkYWlNRFZXdUdrMjhSVkJF?=
 =?gb2312?B?Mnd6eU5aenZ1TzdlZkdZQndaY1EyZGp4Njl6TEhEQlhBTmdRc2xYVGpsbThT?=
 =?gb2312?B?U011ZFBBa2F1bXFoNmh5ejRxUmRNZFU4VWlLVElxVGc2ZndsOEhUb1FrZUtv?=
 =?gb2312?B?aTQvaHJKNlU5OFBaWkRsa0JmYTBMalhOdUJhSkFtTWgzc3lMRjAxVjNJSzlE?=
 =?gb2312?B?Rk43OERKYm91MTJTSk5BVERnbEMrc09iREo2QkV4M2JFNGIrWUNPSEJKYW1Q?=
 =?gb2312?B?clAzd3JPcjU4UGtna0tvU0g2bWNkZytzQWFoYy82UUx4Y0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RTM3emx1RW5taElDTTE2UFppc3UzQktOZEpFZWIzbHRQK2NITTNoSTQ5djFo?=
 =?gb2312?B?VnNBREhRZ0VzbzJpeVc1U2crdEs3akQ3OURYR2VXNUtaaWJsdWpVajcyeWps?=
 =?gb2312?B?b1g3LzRWc0lMUXg5bWIwK1lISVN1QU00Vm8rWjUzaDFlMWFCWHdNRUltWFJW?=
 =?gb2312?B?SlNWTTN6NHNjN3FBcDZUem5JOTM1UHo4eWgwZ1QrWThIQ1BqaXpkdkVRYU82?=
 =?gb2312?B?U1RNeFVlYkRuK2FxeFFJNGMzak1rVnFrd0w1YXhFQmdyOUFLU21XTllodmxS?=
 =?gb2312?B?YzFnMjNqRU5pNmFtQUF3VldNMi8ycng5aW9CcWx3RTluenNJd2M5SllzN09S?=
 =?gb2312?B?eEcxTWR3SlpiTGNLckgyN0JJQnRtNXFkRG5KY0F6ejFCVm5uZ284T0dPVjZs?=
 =?gb2312?B?bllsbG5kYnVwTzRsaXI3YTZFN0pYd1dOaDJnNHd3bmQ2VlBoNkRFZ25uVUhK?=
 =?gb2312?B?b09OZnlnQUMwWGFJOEpjQUdhK09jQ2RNcTNCbGQyY1RFYTZKdWJxVThOT1pJ?=
 =?gb2312?B?V1NLbURUNzRFa1J0S0FuaEd3dmVhY0dBanZhcHcxYUVXaS8xVGxZd3REQTR3?=
 =?gb2312?B?VEE0cDRUODhMYzZ2UmhjMlM4VEJFejRlbWw1R3N6eGtsTlhpREV2Y1Zpckxl?=
 =?gb2312?B?SnVmb2RkcElpc1V3ZkE2THkyUHIzdVBUeWQvK25KcGF6YmhNNWtUclRmbGhv?=
 =?gb2312?B?Tkp5aUlrWE5LbzdrcHdtdEtNVUhZTDVJcmlFYWw2K1puZnVhZ1hCWWsydkV4?=
 =?gb2312?B?MWdGcGdXS1crTjJRUXBEU0pscTFIMUtPVEZNdTBlYXRjemhqUGFyNmVMNGN5?=
 =?gb2312?B?RDZ5ZzhZUmhXTy80UnM1MVVZS3lJS3RVYjA4RE15UWdoR052Q3ZnTlZBN0c1?=
 =?gb2312?B?QkJQbEphSzBqWm5xVjF1UG55UEEwbnM0ZDc2Z2JZTFY1OGUzOWdJQjdPQzZR?=
 =?gb2312?B?TmlUSlQ1VFRhbllqWXZ3L1psWURzUkt1WFJlTi8waVRYWDlNRUJHYzhZUGF6?=
 =?gb2312?B?ZmN0emdQTnlQcktjRzZzTGs4eXhjem41TCt5TVRGVGJ6YU1tdUdSOTFaek83?=
 =?gb2312?B?Z2lQODgwYjc1NVJKL0RwSHp4WlAzRUJPRUdDdERSNTBHOVpFUWVyQ05zcGx1?=
 =?gb2312?B?OGk0ZURSVzlzV1FFY1lvZTd5aHJXKzJPRUxVbkFQQVVsdFdiS2ZMVE55QW56?=
 =?gb2312?B?ZDdKM2t3N1lUK2VjWGRXRzM0SDhEcUZFVW90cjlOUjJ6S0pHTjZIam5qUlZ3?=
 =?gb2312?B?c3REZEZvYVZlUzlqd2NBV3pxR0JHYjN2bitHcllsdEhmZjZCYnloM25ieUFa?=
 =?gb2312?B?dDExazdyMkdVTWgyWG15alFKa3dGRUl6b0l3RVdkY25sSjNYbEJUQVJlWUE5?=
 =?gb2312?B?SEwvbitFUXdUL01VRmNWY01mc3VycEk5aFhaQWR4T2FjQXYwMEp2SEJ5Szls?=
 =?gb2312?B?eGNMeWVtUEJvanBOQVRGaUxkN1ZWblVPN0wvaVcwWTkwS2xma1lSNnZuRlkw?=
 =?gb2312?B?MERHSUFsakcwY1JHSnZqdnFaeEpZVmRVUG5FL2Jmb3hObmFGYkxDcUlOYnRu?=
 =?gb2312?B?emU1NjZvbEdyWFFLZ0craWNsK1loQ1UwWGF0T1hXYlFjWXBaWjF3blhzYWN4?=
 =?gb2312?B?NDB2RkxWa0NseUo5MGYyUFlJM0NqQ2Y1dmFGNjFUZWFaZ1dVcm1OS3YyY0xV?=
 =?gb2312?B?MTYvWmxPMzVNYmJyelk2SzIxU1JOd0NMR1l1a3dKT1FteFVrRTBDQlNIUjdr?=
 =?gb2312?B?SVZwdHI5Z2ZFMmMvR2tVZGZDVk40M2lXUTF2ZlNsQzAvZDJsOWRLZW9mNWpu?=
 =?gb2312?B?Mm5BQ0ZwVmxKWjdDUjFoSXRzSFlnMWVCSXF4ZW5LcFk4QzlSdnVrWWNBbWxM?=
 =?gb2312?B?U1BxUENlOXJFYWxRMzVzZzViSW1lSnhtS1ZjZFA2V0pBc2hLMkhQSWllNnFR?=
 =?gb2312?B?WHhvK29DY0t0WHRKQi8wd2FSSDZTWGwwbTl2Q29XWFNneWo3TDFkMGVDakZt?=
 =?gb2312?B?bWJBMTlGeFdpbmlDR0ZRSE9yMCtkbS9ZS1Q1L2F6bEhQWDRzeTZUb1dDeXpC?=
 =?gb2312?B?M2F5OFJodjM4ak9qUHQvM2l6aEVEMVo0OUI3MzZhU2Jmb0pEMkl3bmNscVlB?=
 =?gb2312?Q?QAAk=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 208fcc85-4c5e-4116-9c2f-08dcdd107297
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 03:16:29.0958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZPUlK7p2LzrgsnzbEcqOPstHdxyGvBKCwMRK8MZuhdf0aSyHVidi2zastH7cGRMHbV80g67bSAqamQFgeJNDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6260

RnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPg0KDQpBdWRpbyBjb250cm9sIHJl
cXVlc3RzIHRoYXQgc2V0cyBzYW1wbGluZyBmcmVxdWVuY3kgc29tZXRpbWVzIGZhaWwgb24NCnRo
aXMgY2FyZC4gQWRkaW5nIGRlbGF5IGJldHdlZW4gY29udHJvbCBtZXNzYWdlcyBlbGltaW5hdGVz
IHRoYXQgcHJvYmxlbS4NCg0KU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZp
dm8uY29tPg0KLS0tDQogc291bmQvdXNiL3F1aXJrcy5jIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9xdWlya3MuYyBiL3Nv
dW5kL3VzYi9xdWlya3MuYw0KaW5kZXggZjYyNjMxYjU0ZTEwLi5jN2E5YzUwYTY1YmIgMTAwNjQ0
DQotLS0gYS9zb3VuZC91c2IvcXVpcmtzLmMNCisrKyBiL3NvdW5kL3VzYi9xdWlya3MuYw0KQEAg
LTIyNzksNiArMjI3OSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNiX2F1ZGlvX3F1aXJrX2Zs
YWdzX3RhYmxlIHF1aXJrX2ZsYWdzX3RhYmxlW10gPSB7DQogCQkgICBRVUlSS19GTEFHX0dFTkVS
SUNfSU1QTElDSVRfRkIpLA0KIAlERVZJQ0VfRkxHKDB4MmI1MywgMHgwMDMxLCAvKiBGaWVybyBT
Qy0wMSAoZmlybXdhcmUgdjEuMS4wKSAqLw0KIAkJICAgUVVJUktfRkxBR19HRU5FUklDX0lNUExJ
Q0lUX0ZCKSwNCisJREVWSUNFX0ZMRygweDJkOTUsIDB4ODAxMSwgLyogVklWTyBVU0ItQyBIRUFE
U0VUICovDQorCQkgICBRVUlSS19GTEFHX0NUTF9NU0dfREVMQVlfMU0pLA0KIAlERVZJQ0VfRkxH
KDB4MmQ5NSwgMHg4MDIxLCAvKiBWSVZPIFVTQi1DLVhFNzEwIEhFQURTRVQgKi8NCiAJCSAgIFFV
SVJLX0ZMQUdfQ1RMX01TR19ERUxBWV8xTSksDQogCURFVklDRV9GTEcoMHgzMGJlLCAweDAxMDEs
IC8qIFNjaGlpdCBIZWwgKi8NCi0tIA0KMi4zOS4wDQoNCg==

