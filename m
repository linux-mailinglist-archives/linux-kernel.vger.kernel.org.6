Return-Path: <linux-kernel+bounces-262772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EB793CC8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BD328259B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A5E19470;
	Fri, 26 Jul 2024 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lwDOwXL7"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2078.outbound.protection.outlook.com [40.107.215.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97F320F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721958609; cv=fail; b=myokPUtsUcaZgvz9xGsslGjMImDsDZ/ayqwlXKiYpFeB39KFIRJXup0CHGDxNaEjWMbPrN/7TV2EVDFr+NZvuO8c6RZDxVdnpM8dMB3BvqWZo7gqj0UITiI2Wpeij9VmqxOv0z7Qwu2rNiD1NQugNA+7kxgHxLHrWaSbmsc1aVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721958609; c=relaxed/simple;
	bh=JJq4gIuI8fdOQab79rzwx2oIn/5ZVl7J7z2zftWTI1s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UmkezktidFbTl6UO7SAZNSSnsjWvJqw3b9HuE+/vBmqcWQ4UNwpm3cxfoouOAnBhB5sVMEySNhVbN6xUsjtzddFlTbq8mJ6BvlieHqgq907XqAziDFsyao3ISEGiwqA5H+xAmLRnGJ3n/Ef4b6suaVsSy82IUme7UPB02W7t5Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lwDOwXL7; arc=fail smtp.client-ip=40.107.215.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsghTlH6VfEdPd5w80KRWDc71cDuy8qgG3BrvWr5XjjliSqbQ8OyLFCo1NAqUWF4lmBY2zmRf2ecBbymLUxqHaopY/kWaGjSz/pMA65XlsELBFO761hIknWVTRkKi/8vTylOHHWqY6xm7SVbCLXIAiBVrZdP8dI9hmuJfF9SoKVBssQaS7uTalKPVO4lJgLWzPqmwB9r+RSY/IwiiKa1ddYKNdBD5wAN1/YhTqXg/cdAMFxty+GJIfOkHiPrjSNDbzLYE739zXpf5TL3ep0tPUzXBQT/co+BqRO+/iYF4q+YG7aRX1AJrfjFn3EsZiE9VPHsA1Zc3m7l7wwgJgg2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJq4gIuI8fdOQab79rzwx2oIn/5ZVl7J7z2zftWTI1s=;
 b=aaU/7UXWNKfYjgIFPBXIGOSdV+lFlP2Jpfm325Sx8ziGYi+Cb5tyPdlWPl5RZAbVfD8YP58G+oHwRArK363FRoXFJJQ1mUetZGgXVjMN3/679rHuwHRIm40d2rptIpfM3MGlUiEy0aj3W1061yig6vEZMrDAKEmzSgAiKmKn2+qoXUe7+ET/JUgYpPJdvL67suc2Ii4MmWlUltjbG72Kt/FL47eIQoJCoYr0zUnAUBQUVoEo7BncvqWcHzIaNZ4PH/lnUyzZcIY1vjn3LhJgVHn06wmAf3WH5dfGBPB1/A2ZaEnvAmvlIbMfZf9pNu6dHwFqqsGHqBXlp/Grt4DTsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJq4gIuI8fdOQab79rzwx2oIn/5ZVl7J7z2zftWTI1s=;
 b=lwDOwXL7kL/5i4AB4mQioSgSp9XRm1pg0/IPRxtb/3miwVEZuuEo0isJvU5o+M4mpTartJI3JQWvKLk+bgvCz456ETuqRC4qPf4nJEUK95YWQMv5biwYiPsbAArkvG3DbpKyHSMz6IkPG6uuFRJmbWDuJ45XPnoayfEySdjDt7+yxB2HXeQ3HP5Pi6SDQRJLbtCrCfUcNbNtWpmIdeSJOHQzFdEoZzjoXqyBxC2/IZGxfvrg/t3WQoQhdpNir3h36DJifz/UIgXHV18vfzOJs9rljtzOgRfrmVtZuuzeN8C+is4TzYdC6SSdySFkJnC8/PmLP2r6fm+3hNCrc1MdNA==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TYUPR06MB6244.apcprd06.prod.outlook.com (2603:1096:400:35c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 26 Jul
 2024 01:49:53 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 01:49:53 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHVzYjogZ2FkZ2V0OkZpeGVkIHRoZSBwcm9ibGVt?=
 =?utf-8?B?IG9mIGFibm9ybWFsIGZ1bmN0aW9uIG9mIG1vYmlsZSAgcGhvbmUgYXMgVVZD?=
 =?utf-8?Q?_camera.?=
Thread-Topic: [PATCH] usb: gadget:Fixed the problem of abnormal function of
 mobile  phone as UVC camera.
Thread-Index: AQHa3v4bWL8TcmfBF02Uvx4MhGAQEA==
Date: Fri, 26 Jul 2024 01:49:53 +0000
Message-ID:
 <TYUPR06MB62176D779EE13F08D6295C3ED2AB2@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB621753631B9F7836583E7BEED2AB2@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024072537-landowner-diaphragm-1d22@gregkh>
In-Reply-To: <2024072537-landowner-diaphragm-1d22@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TYUPR06MB6244:EE_
x-ms-office365-filtering-correlation-id: 94039638-7701-4bbd-df40-08dcad153e54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OHAxVFhXTXlhQ1JwSW0wSzBXeDg5TlU0M2UrOTFiU3BqZ3RLVnFtRFJiZUpF?=
 =?utf-8?B?R3RKeHY2YVhvbWZraDU1aWNBVklBRzVGYkRsVzVIZFVmQVowQmtNRVBuanZB?=
 =?utf-8?B?aXNWZlpFVjlteVhDU1NISEE5aUw3TlBLZmhBOXpoLyt5QnBuUGJlYTJCRDlL?=
 =?utf-8?B?YmplbGppa1BLVnBLMHYzcTkvdUdQamxaT3B2WUVNcUpaaEwxZWFiR1BmWTRy?=
 =?utf-8?B?Nkl4d1JqVVVEMDI3TWNGODJ6dFF1NklqOVhIOWJRSzJvNXBlbS92RVpuNEZp?=
 =?utf-8?B?K1g5UEwrRU9sVTRtR3NBSGtVMEZvQ3grZjdaUDM3ZlhBSVVCTmFHVC91ajR4?=
 =?utf-8?B?L29tdEp1Nkl3WEV5UkdSZWF5bTlZais3WW5GMlAzQTVpVVdjdHFzeU15ZjJV?=
 =?utf-8?B?cDhaTDNFWTRtZkZqbHdacjI5NU4xOXhyeUowS2tVUXM2emRDMnMrSVhGK0xt?=
 =?utf-8?B?N2xqc0FkYVM3Mmswbkwzck5hbTNJWkVWZVYwYmFZczNpcElzaXFaL3pZTzR4?=
 =?utf-8?B?dHp3U1hoZlMyNGxwTFRiaGwrWldTT3YzcXNGQW05VXkyNUI1RHcxOHhwcEJl?=
 =?utf-8?B?RFcxMzZnME5XUE11NXd6Y1ZIdW1veUlEeDBMdlRPZUF3U0RoMXV4WUFSdnJ3?=
 =?utf-8?B?eWpuZzN6M3ZGQkRTeDdUQ01waEJaYjZXVDVweUc4Zm51YWxCcUhpRVNFTHYr?=
 =?utf-8?B?Wm1JTS9NNFhYUlRKMzFiM2ZmVWlGUUkyYVZHZ0pabm1vektrSU5jeWxjQXpZ?=
 =?utf-8?B?Y3d6RzJMYXlPVnpsYUd3NTJpOGt4bFB0RXB1VkUyZmhZakJsbTBXenpDSkFs?=
 =?utf-8?B?VVFJb1JZZWFCYk5FVWJXSnhzd1QwYTRaRnZMQVZ0b2wzc0J1MG10Nkxuc3pM?=
 =?utf-8?B?ckZrQzEyVnNvYWFxSmtkVEVWallwS1E4VE1ySTl0MDB0Yko5TUlIbkZHWU1N?=
 =?utf-8?B?S2dOc3FOQnludkN0Y2VhMStHQ2tUUStpb3dIVldsSldrdXA3T1owenBIVDVz?=
 =?utf-8?B?OEl0NGpPdFozdGJEdzllbUdEYmpKWjB5WGFFbk1XVVVzWGVGTFBIdHg3OVl5?=
 =?utf-8?B?bDQwSW1BUlE2VTJmc3pQaFVYaWluZ3hjVFlaNWdPSEdyWnFBRFhFNjlublB0?=
 =?utf-8?B?Tng4Z2N5OW50WW9xU21YdkhjaFpIcmx2aHpFZzFvbFJRams1cHgvVWh4Mmtz?=
 =?utf-8?B?UGJBVzM4c0c1c2NERHJ3L1FGakN5RDNyOSs4ODF0N0psUU1iazFyVXl3RkRy?=
 =?utf-8?B?Tlo0YmxiQWk2S3U0RndHZFpPMlZrdWhnaEpKZXRSV0pTY3NmVW41bU40THFn?=
 =?utf-8?B?ci8yenl2dkRIdzdZZURweUU5em5UQk5yaWViQTZ3eW1sZUFNblp0Z2pRbjdk?=
 =?utf-8?B?QTRQdkpqMXFEWEJxbUU4WkxxTGk3aHRMamlMQ0FhU3UrOFVaUktGQ1o1UHhD?=
 =?utf-8?B?Sm9LTk41M3pHQ2ZGa0lWNElJamhDNUpKZ0xmcWJlQTFONStpTHkxUUVUMzh6?=
 =?utf-8?B?K1oySlBNYldvb3RURkRKeTlEMkRzNXlDcDIzdW5CZXh1ZGhCcjNWd20wQ2JF?=
 =?utf-8?B?SGxpdVAreENoZVY2dlFzakx1VmphNE1jYVJKNWhFWUtwc2RhRXZ6M1BTTXJ6?=
 =?utf-8?B?SGhreGFjVkhUaWsxTG1mMndyM251ZkwrR1BPYnFJR1NCZGhhMFlTcDZYeG9T?=
 =?utf-8?B?eHZ4ZVJJVG9sVkgzMlFlZm1DNlpPY2VMMHppL1h6MDJCNVlSYzBwMnF5WTVG?=
 =?utf-8?B?U2x1eXUvQTkxWjFnZ1plM25qWkFSU0tMNGxXNVlyRXhBbWVCZXJ5allaa29G?=
 =?utf-8?Q?4MY1iOYCrOZy1fi+nGWBfaKjYRudQgJlNarEY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Si9hMDlYanFiRjJUdWY1VFVkY2srcURaNmZyVWkrZlNIem4wY3I3Vks5QUQ4?=
 =?utf-8?B?UzdSTXJjUHErVUwyVitlZzR3RGRuN2JoeWUxeUJWSGczOFVhZllSWk5LUHln?=
 =?utf-8?B?THhFTWUyTTlHZlB3OUxBTzdCcy9hbzVJa0xpWjRCT2RwdDV3QXY2ZllPYXpl?=
 =?utf-8?B?SVUxdWZ6OGY5MXRqekg2Q0U2MFEwUXlHcFlKRHh1T1IyVCs1Z2dXejJ6MWZ3?=
 =?utf-8?B?Y0E0dzNGY0JPd2l5YjV0b3dyT0dsbzNOc1ViSW03OUpTVVNpN2F4SmRaWmVI?=
 =?utf-8?B?dUZZVzBUZnZ6em1pV0d6ZTNSMGZTMEw5ZkVpMyt4SkVzR3F5d3lWdUpwZU1V?=
 =?utf-8?B?Si9BSGZqYVNnSjl5WmtTRVJBS3hDK3VHVFNicFgzTWhHZjdaRm5mbEU1TGtI?=
 =?utf-8?B?UWlXYitZQVRxcGgwS3pXelg0Q3J6S3hsSmJBcStXOFR3aDdla0JiUm9NbmdI?=
 =?utf-8?B?dXF0S3VMblhjakNxRmIweXB3aFRxakZPdFdMdmZ1SkNWbGlJSUVLblRhc3da?=
 =?utf-8?B?QmtNNEl4RmRpdGhNTld3RmFUZE84SzBuOVFZODZoalZRWW43RUoxM1Nwd2F0?=
 =?utf-8?B?dHcvbXNzRklpWTlRNnI4OFR3TERUZTJGYWcwS2xPQkcraDQxWWZVL0MvME1n?=
 =?utf-8?B?dWtveEtEWHFjU2FiaGVGb1dTNFZMZHVyWnRuMVZ2emVHM1RUSk4vVjFVblFY?=
 =?utf-8?B?NjFTQUFvY0dLeXpibFhvVmRLS0hnYXAxODlBdmRTd2JFMnBMMVBjTUlVWlQr?=
 =?utf-8?B?V1owMnVuc3pKL0hqYzV5YWhvN2NNMmQ2UzVXZzdFc3NqYzREeWt3N2dxTS9J?=
 =?utf-8?B?Mmo5RExnelBGc2JsZW5ZazByOWhORndYckx3azc2U0dDb2Vqa2VyK1NlTUE2?=
 =?utf-8?B?eVVXZlJCWEtxcTdrbjlGVkJSS2dtWi91SmxzcVVwcm9ZL0ppczUvaXVkdTZQ?=
 =?utf-8?B?TE1BcTNScWNBUFpLQkxqTEJPYm9DSDlOV3FuWi9FNnA0MzJPditFTUxvQndt?=
 =?utf-8?B?OW1KUEZ2N1Vma1VMR09VNGo1ODhUZDVHbXFqeTJXYWhKRXA3U0xMTW9DRnhx?=
 =?utf-8?B?R2orUlR1ajlERTlVTExZUkNoK2xSbHFYL3gwbGkra29aaTJ4d09nTEZWMmMw?=
 =?utf-8?B?L2RtRk1yWkdWSjEydVZ5WlZhbVV3NTlkNmJtcEh4bG9hMk1qUjc0djNFZkhE?=
 =?utf-8?B?bjRSODJYOExFaS9RL1ZoelNBZWpMUTlnanVGblh4ZFcxbFpNSHU1L3JXRWhK?=
 =?utf-8?B?bEFRckRKWjlieDVqN01KS1lDOTNtRk50ZnJYOGthbzY5UzBRUzBpbjFlQ041?=
 =?utf-8?B?eWNYbS9PQWI1SDk3QWxrSmNkaVp3aU9rKy90UWNuQk9XV2pVUEdva0hhZFFF?=
 =?utf-8?B?enJMNTI3V2xDM1hDQ0F3VnAyd0RLY2VCUjBvc2ZDSHRITXQyNFhPSWtRVWNM?=
 =?utf-8?B?THlKRFRBcmN0NFRpNGpHRGdYYTRhc0Mwcm1tR3hRT1pkUk5pMFJmNW5MWVR6?=
 =?utf-8?B?U3lXbitGM3Z0cWtxTjJtaWVVbHJiNHBYTCsyTnkzeFh1Qy9NT2orUjJwZEZ0?=
 =?utf-8?B?cXJYOFBGYTBLTy96aUF4N0hPTXhWZ0o5Vmx0VTVRMnVRSlg5WGliT3JDNGhM?=
 =?utf-8?B?NHlvN2ZIMjZFU0ozekFJQzRoSFJMekZvRmJLNUJ0SEJuNHhVUjBod3U3aXBB?=
 =?utf-8?B?QWN6ZklpOUtYSXliWlBlZTY3YmhZbk5SS2o0dFNraGN4S0Z1Y3ltaWJjUm13?=
 =?utf-8?B?SGdWN0gzOW5qYXdhVXpLc2JUZm92R1graTNsNk1EV09zbkl5anp1U3lOQnp6?=
 =?utf-8?B?aUxuZTdWS2VSTTh1ZEQ5YTFyWEsvalM1U1lYRDBJRDJHeWZBRjRWSTFpMGJv?=
 =?utf-8?B?VTVVRStEbVF0Zi9uUE9vQkZ4a1RSazBramt0blY3cEQ0ZW1tNGlOWDV0SFlS?=
 =?utf-8?B?VDZoMytmTW5ESU1KZ3AzdUtzWCtpNndZL3Z0ZWZmWm44dnREWk45TUQ0bjAv?=
 =?utf-8?B?OUc5bGxtODlMUSt4Sm9LR0tXSk9ERktFbUJoZG9DejRTakhJZG1MeXdXbjZB?=
 =?utf-8?B?VGJSc0dMQ1hoV1JOSTRlanFqd0RjK3o4U2w1d3FUNnVWNWNWZ3BkeXNEWDlP?=
 =?utf-8?Q?Hvf8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94039638-7701-4bbd-df40-08dcad153e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 01:49:53.1257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MvE6Nnn01THZj7c7uIl/lDveGf7h951E5FIas+Pjx4Dge4CV8sTh2oDM7xjUU2VDG+Pfc4U+CecudkEZ8mSv7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6244

MS4gTW9kaWZ5IHRoZSBlbWFpbCB0aXRsZQoKMi4gCj4gQW5kcm9pZCAxNSBVU0IgZnVuY3Rpb24g
b3B0aW9uIGludGVyZmFjZSBhZGRzIGNhbWVyYSBmdW5jdGlvbi4KPiBhZnRlciBzd2l0Y2hpbmcg
dG8gY2FtZXJhIGZ1bmN0aW9uLCBVU0IgZW51bWVyYXRpb24gaXMgYWJub3JtYWwuCgpXaGF0IGRv
IHlvdSBtZWFuIGJ5ICJhYm5vcm1hbCI/CiAtLS0tLS0tLS0tLS0tLSAgClNlbGVjdCB0aGUgIkNh
bWVyYSIgZnVuY3Rpb24gaW4gdGhlIFVTQiBmdW5jdGlvbiBvcHRpb24gaW50ZXJmYWNlLCBhbmQg
dGhlIGR3YzMgY29udHJvbGxlciBjYW5ub3QgYmUgZW51bWVyYXRlZCB1bmRlciB0aGUgc3lzLnVz
Yi5jb25maWc9dXZjIG1vZGUgY29tYmluYXRpb24KCjMuCj4gdGhlIHJlYXNvbiBpcyB0aGF0IGJp
bmRfZGVhY3RpdmF0ZWQgaXMgc2V0IHRvIHRydWUgaW4gZl91dmMgZHJpdmVyLAo+IHdoaWNoIGNh
dXNlcyBnYWRnZXQtPmRlYWN0aXZhdGVkIHRvIGJlIHNldCB0byB0cnVlIGR1cmluZwo+IHVzYl9h
ZGRfZnVuY3Rpb24sYW5kIGR3YzMgY29udHJvbGxlciBjYW5ub3QgcGVyZm9ybSBwdWxsdXAgb3Bl
cmF0aW9uLgoKV2h5IGRvZXMgdGhlIGR3YzMgY29udHJvbGxlciBtYXR0ZXIgaGVyZT/CoCBXaGF0
IGFib3V0IG90aGVyIGNvbnRyb2xsZXJzPwotLS0tLS0tLS0tLS0tLSAgCkR3YzMgJiBNdHUzIGNv
bnRyb2xsZXIgdGVzdCBub3JtYWwuCgo+Cj4gVGhlcmVmb3JlLCBtb2RpZnkgZl91dmMgZHJpdmVy
IGFuZCByZW1vdmUgdGhlIHNldHRpbmcgb3BlcmF0aW9uCj4gb2YgZnVuYy5iaW5kX2RlYWN0aXZh
dGVkLgo+Cj4gU2lnbmVkLW9mZi1ieTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPgo+
IC0tLQo+wqAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMgfCAxIC0KPsKgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91
dmMuYwo+IGluZGV4IDQwMTg3YjcxMTJlNy4uNmQ2M2JlYTE0MjExIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jCj4gKysrIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L2Z1bmN0aW9uL2ZfdXZjLmMKPiBAQCAtMTEwNyw3ICsxMTA3LDYgQEAgc3RhdGljIHN0cnVj
dCB1c2JfZnVuY3Rpb24gKnV2Y19hbGxvYyhzdHJ1Y3QgdXNiX2Z1bmN0aW9uX2luc3RhbmNlICpm
aSkKPsKgwqDCoMKgwqDCoMKgIHV2Yy0+ZnVuYy5kaXNhYmxlID0gdXZjX2Z1bmN0aW9uX2Rpc2Fi
bGU7Cj7CoMKgwqDCoMKgwqDCoCB1dmMtPmZ1bmMuc2V0dXAgPSB1dmNfZnVuY3Rpb25fc2V0dXA7
Cj7CoMKgwqDCoMKgwqDCoCB1dmMtPmZ1bmMuZnJlZV9mdW5jID0gdXZjX2ZyZWU7Cj4gLcKgwqDC
oMKgIHV2Yy0+ZnVuYy5iaW5kX2RlYWN0aXZhdGVkID0gdHJ1ZTsKCldoeSB3YXMgdGhpcyBzZXQg
dG8gYmUgdHJ1ZSB0byBzdGFydCB3aXRoP8KgIFdoYXQgY29tbWl0IGlkIGRvZXMgdGhpcwpmaXg/
wqAgU2hvdWxkIGl0IGJlIGJhY2twb3J0ZWQgdG8gb2xkZXIga2VybmVscywgYW5kIGlmIHNvLCBo
b3cgZmFyIGJhY2s/CiAtLS0tLS0tLS0tLS0tLSAgCnNldCB0byBiZSB0cnVlIHN1Ym1pdCBsaW5r
OgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxk
cy9saW51eC5naXQvY29tbWl0Lz9pZD1mMjc3YmYyN2NmNWNkNTZiY2QxYzRiOTVhZTE0MGY2MTY4
MGE2ZTgzCkkgaGF2ZW4ndCBzZWVuIHdoYXQgc3BlY2lmaWMgcHJvYmxlbSBpdCBzb2x2ZXMgeWV0
LCBpdCBsb29rcyBsaWtlIGl0IG1ha2VzIHRoZSBjb2RlIGxvZ2ljIG1vcmUgcmVhc29uYWJsZS4K
ClNob3VsZCBpdCBiZSBiYWNrcG9ydGVkIHRvIG9sZGVyIGtlcm5lbHMsIGFuZCBpZiBzbywgaG93
IGZhciBiYWNrPyAgCiAtLS0tLS0tLS0tLS0tLSAgICAKSXQgc2VlbXMgdGhhdCB0aGUga2VybmVs
IHZlcnNpb25zIHVzZWQgd2l0aCBBbmRyb2lkIDE1IG5lZWQgdG8gYmUgc3luY2hyb25pemVkCgpX
aGF0IHVzZXItdmlzYWJsZSBjaGFuZ2VzIGRvZXMgdGhpcyBwYXRjaCBjYXVzZT/CoCBXaGF0IHVz
ZWQgdG8gd29yayB0aGF0Cm5vdyB3aWxsIG5vdCBhcyB0aGF0IHdhcyBhZGRlZCBmb3IgYSByZWFz
b24sIHJpZ2h0PwogLS0tLS0tLS0tLS0tLS0gIApUaGUgIkNhbWVyYSIgZnVuY3Rpb24gaW4gdGhl
IFVTQiBmdW5jdGlvbiBvcHRpb25zIG9uIHRoZSBwaG9uZSBjYW4gYmUgdXNlZCBub3JtYWxseS4K
QW5kcm9pZCAxNSBzZWVtcyB0byBiZSB0aGUgZmlyc3QgdmVyc2lvbiB0byBzdXBwb3J0IHRoZSAi
Y2FtZXJhIiBmdW5jdGlvbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18K5Y+R5Lu25Lq6OsKgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPgrlj5HpgIHml7bpl7Q6wqAyMDI05bm0N+aciDI15pelIDE1OjA1CuaUtuS7
tuS6ujrCoOiDoei/nuWLpCA8aHVsaWFucWluQHZpdm8uY29tPgrmioTpgIE6wqBha3BtQGxpbnV4
LWZvdW5kYXRpb24ub3JnIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IG9wZW5zb3Vy
Y2Uua2VybmVsIDxvcGVuc291cmNlLmtlcm5lbEB2aXZvLmNvbT4K5Li76aKYOsKgUmU6IFN1Ympl
Y3Q6IFtQQVRDSF0gdXNiOiBnYWRnZXQ6Rml4ZWQgdGhlIHByb2JsZW0gb2YgYWJub3JtYWwgZnVu
Y3Rpb24gb2YgbW9iaWxlIHBob25lIGFzIFVWQyBjYW1lcmEuCsKgCk9uIFRodSwgSnVsIDI1LCAy
MDI0IGF0IDA2OjQwOjE0QU0gKzAwMDAsIOiDoei/nuWLpCB3cm90ZToKPiBGcm9tIGIwMDU4NDg0
ZTNmZTc4MzBjMjA5MmQ1ZDE5YjQ2YmYxYmFiNzNkODMgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAx
Cj4gRnJvbTogTGlhbnFpbiBIdSA8aHVsaWFucWluQHZpdm8uY29tPgo+IERhdGU6IFdlZCwgMjQg
SnVsIDIwMjQgMTg6NTI6MjcgKzA4MDAKPiBTdWJqZWN0OiBbUEFUQ0hdIHVzYjogZ2FkZ2V0OkZp
eGVkIHRoZSBwcm9ibGVtIG9mIGFibm9ybWFsIGZ1bmN0aW9uIG9mIG1vYmlsZQo+wqAgcGhvbmUg
YXMgVVZDIGNhbWVyYS4KCkZvciBzb21lIHJlYXNvbiB0aGlzIHNob3dlZCB1cCBpbiB0aGUgYm9k
eSBvZiB0aGUgZW1haWwsIGFuZCB5b3VyCnN1YmplY3QgbGluZSBoYXMgInN1YmplY3QiIGluIGl0
IDooCgo+IEFuZHJvaWQgMTUgVVNCIGZ1bmN0aW9uIG9wdGlvbiBpbnRlcmZhY2UgYWRkcyBjYW1l
cmEgZnVuY3Rpb24uCj4gYWZ0ZXIgc3dpdGNoaW5nIHRvIGNhbWVyYSBmdW5jdGlvbiwgVVNCIGVu
dW1lcmF0aW9uIGlzIGFibm9ybWFsLgoKV2hhdCBkbyB5b3UgbWVhbiBieSAiYWJub3JtYWwiPwoK
PiB0aGUgcmVhc29uIGlzIHRoYXQgYmluZF9kZWFjdGl2YXRlZCBpcyBzZXQgdG8gdHJ1ZSBpbiBm
X3V2YyBkcml2ZXIsCj4gd2hpY2ggY2F1c2VzIGdhZGdldC0+ZGVhY3RpdmF0ZWQgdG8gYmUgc2V0
IHRvIHRydWUgZHVyaW5nCj4gdXNiX2FkZF9mdW5jdGlvbixhbmQgZHdjMyBjb250cm9sbGVyIGNh
bm5vdCBwZXJmb3JtIHB1bGx1cCBvcGVyYXRpb24uCgpXaHkgZG9lcyB0aGUgZHdjMyBjb250cm9s
bGVyIG1hdHRlciBoZXJlP8KgIFdoYXQgYWJvdXQgb3RoZXIgY29udHJvbGxlcnM/Cgo+Cj4gVGhl
cmVmb3JlLCBtb2RpZnkgZl91dmMgZHJpdmVyIGFuZCByZW1vdmUgdGhlIHNldHRpbmcgb3BlcmF0
aW9uCj4gb2YgZnVuYy5iaW5kX2RlYWN0aXZhdGVkLgo+Cj4gU2lnbmVkLW9mZi1ieTogTGlhbnFp
biBIdSA8aHVsaWFucWluQHZpdm8uY29tPgo+IC0tLQo+wqAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL2ZfdXZjLmMgfCAxIC0KPsKgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYwo+IGluZGV4IDQwMTg3YjcxMTJlNy4uNmQ2
M2JlYTE0MjExIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2
Yy5jCj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMKPiBAQCAtMTEw
Nyw3ICsxMTA3LDYgQEAgc3RhdGljIHN0cnVjdCB1c2JfZnVuY3Rpb24gKnV2Y19hbGxvYyhzdHJ1
Y3QgdXNiX2Z1bmN0aW9uX2luc3RhbmNlICpmaSkKPsKgwqDCoMKgwqDCoMKgIHV2Yy0+ZnVuYy5k
aXNhYmxlID0gdXZjX2Z1bmN0aW9uX2Rpc2FibGU7Cj7CoMKgwqDCoMKgwqDCoCB1dmMtPmZ1bmMu
c2V0dXAgPSB1dmNfZnVuY3Rpb25fc2V0dXA7Cj7CoMKgwqDCoMKgwqDCoCB1dmMtPmZ1bmMuZnJl
ZV9mdW5jID0gdXZjX2ZyZWU7Cj4gLcKgwqDCoMKgIHV2Yy0+ZnVuYy5iaW5kX2RlYWN0aXZhdGVk
ID0gdHJ1ZTsKCldoeSB3YXMgdGhpcyBzZXQgdG8gYmUgdHJ1ZSB0byBzdGFydCB3aXRoP8KgIFdo
YXQgY29tbWl0IGlkIGRvZXMgdGhpcwpmaXg/wqAgU2hvdWxkIGl0IGJlIGJhY2twb3J0ZWQgdG8g
b2xkZXIga2VybmVscywgYW5kIGlmIHNvLCBob3cgZmFyIGJhY2s/CgpXaGF0IHVzZXItdmlzYWJs
ZSBjaGFuZ2VzIGRvZXMgdGhpcyBwYXRjaCBjYXVzZT/CoCBXaGF0IHVzZWQgdG8gd29yayB0aGF0
Cm5vdyB3aWxsIG5vdCBhcyB0aGF0IHdhcyBhZGRlZCBmb3IgYSByZWFzb24sIHJpZ2h0PwoKdGhh
bmtzLAoKZ3JlZyBrLWg=

