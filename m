Return-Path: <linux-kernel+bounces-289730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C235954B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5E01F22C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E8E1BBBE8;
	Fri, 16 Aug 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GPePJ0bI"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010047.outbound.protection.outlook.com [52.101.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6B1A7056;
	Fri, 16 Aug 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815055; cv=fail; b=KWQHbvrnFSMwcohIdaiyxyUEj9CDggXhioRvN2eNYpGGCjYLk3pLYgzQWqY/gTMKwe6t8zBFF/oUvr3yLbEgjp4+uv+CSbjB3+WT/gbMqEw3WXnaMxvYVciU0VfacwuGk6dzfMIQC8fwSLHXuqa/vwGQ+cU533IVcBgb+oCVGDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815055; c=relaxed/simple;
	bh=TbkfEDEUpNm6w50D2ycg3XX17kdlkLSoFrFKdfTryGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RncFO0yWU0eS4kV8SsJioFeshb0287BZAPuDRjHamzolmoD0ljSROgqN15zDu7rWHU7bYJyCLhVr4ApyO/FYEsfKJWH6HujHi+M9Cih07QrAP8UqOmyURbh3mvaHhHwA/+4LkKpF/RhHAf4co72SXkOBvu25iXLsSbgZsgEuN5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GPePJ0bI; arc=fail smtp.client-ip=52.101.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEU1I6pb3Ti63Zk/JrsCdZumpIhddjSEffEPEZCyTM41j6cgp17/1zuGBrXuAFFWwf/1HpnynNznhMlREkVxWBJR4pzB4z1rvEeix/3f5XSA0eaqBQEnz2JmjkY5yWWVCAjmIF20Gyj18fFvN9zyhbjiwq2WGLjwMNig2tn9TgWrTsedVhonz2v9bnrSAppW50Rsmrd4pO2Be7/K+ipXKvevBDEkRdRXDJSDrTVqGu9GpMu8A+NTSCpR5/N+gTnOD9nxgzrNDdUyHLt5LSW7mZbh+OxIaQYmtp4THevKiCrLkdUznM8ZN3LnYJJeRaqPfQrfGQlui9ea8HJGd4ChZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbkfEDEUpNm6w50D2ycg3XX17kdlkLSoFrFKdfTryGo=;
 b=y/LCfC4n+o1qKC90YZHKWynRG9TWjG8hV158QEZlaC9hdqTF9g8/Gkp+oUq+DB7eOBULOIYp2zDkT/uub2IBCkXFkwtZFCTF1h6hZ4HzZd9zYMeYkSVb6HIPWmYODehuLZf84mxaXw59vtoIrXKh4/nQi7Y8xO/kzE0Youd4AXacQD5V1IUrbWK/n5KnRhE1e+lXMW52gipurdQEFWslT42qHf70kTb3KlONw3wVehcHzKS+DzuCvArZ1xjWiC05b+Vsncc+3ZWsn4AWXlzaooEmo+p7yD223+X8MiO0VZUCgVh5gUb06I7m2PFn7hBMtfHmJnLHsIUCUZdRc4ttOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbkfEDEUpNm6w50D2ycg3XX17kdlkLSoFrFKdfTryGo=;
 b=GPePJ0bIhXhHdZt0vUEApKrriyHIPvS68fl2j2zmNdLYDCt2/1kcbt59gf/CCBcijkrnrAUweVWlw+ZFs2vQILGWVsYOGHc9rqKwv08V6aoAoElqE77EYoOXkgdoZlGdxWY9xBt30K7sj3pXUcs7VKRo9Wd7LsS6wrrputDvHOLQC4UdZZHwsFQ02VtJCLOxWroOOXlFYtLO3KP6cw0Xxq4fhdyfLb3hChtr2snoq3PtsWK7aod5++dU5+NxekwEOR8/DF9FyeqnVbjWC0gHY8mx7ZK1gXKWkPhZl4G18ZZ8MiplrsQUus6BT7n+94Y4xkeAJIuC7TU0w1QyAUx9kA==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB5740.apcprd06.prod.outlook.com (2603:1096:101:ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 13:30:44 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 13:30:44 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjFdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogY2hl?=
 =?utf-8?Q?ck_Null_pointer_in_EP_callback?=
Thread-Topic: [PATCH v1] usb: gadget: u_serial: check Null pointer in EP
 callback
Thread-Index: AdrvzihtFNSOcxRwTAOIHI6tveAOMAABV00AAACqLAAAAoTOwA==
Date: Fri, 16 Aug 2024 13:30:44 +0000
Message-ID:
 <TYUPR06MB62177BCD4AB43C19E38990D3D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62177737F0054278B489962BD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081608-punch-coherent-d29e@gregkh>
 <CAOf5uwnsgcJjp1=RLa7qx9ScQY5rZvwX-Zu6BOqxBBhBCz+CFQ@mail.gmail.com>
In-Reply-To:
 <CAOf5uwnsgcJjp1=RLa7qx9ScQY5rZvwX-Zu6BOqxBBhBCz+CFQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB5740:EE_
x-ms-office365-filtering-correlation-id: 7be2fdfd-742e-4cd0-ae76-08dcbdf7a16c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTExc01mOXFyb3Fzek8rbkt0UWNMVHlJTkxGaFBPQXVTcVBjNURRWjQxSDBN?=
 =?utf-8?B?dUE1RENodnhRZnFTZ1drOWVmQ29wWmtld1RmTFVqWlRRSjVpRzRMcWQ4N2Fy?=
 =?utf-8?B?WEwxcmJ6VmxnZGpVUzZQekkwREtrRWFRV0xTV0JNazIzLzYxVFpyYXUrQ01L?=
 =?utf-8?B?dTF2NlBBYVRlclJoQXJtUXZPb1ZyaTRPeDlJdVM4cDJFZzZ4dUx4aHJNMVkv?=
 =?utf-8?B?K2F1SFJiV0x1dkVtOStDdnJQL1BQU1dZR1VBeVErS1F1dEgvQVY4U3M0bUNZ?=
 =?utf-8?B?aW5obGttaDloWXkzalJtYVR5OEdjVy93WTdZVjdpNjVFMTAzMFN6bFdyY1Bi?=
 =?utf-8?B?U0kvbjVqUkUxc0tSZ1VwMFpLMEExaHBoR3B5VGlkNGxKMGxKdVZrdUg5dFBh?=
 =?utf-8?B?Q0xVNUpNaEc5M0t4REFBeU1ncEdxcnRkdG5LNlFGZGdxa0N5U1VYY28wam4r?=
 =?utf-8?B?Wm1vemM4bnRWTTBNbHJnUEN4T0ZheGlMR2dNUUVFMWw0bFl6VUNXdS9nV3lG?=
 =?utf-8?B?VFptdGU0TzhYaGJZSmJwUGkxeTN1R2tVekJ2bTZPeis1aUVTa2g3TExLOHVV?=
 =?utf-8?B?OXp4MlBYUjBLVVJOdTlQcmsxeGl3a2JkMHEyYUdHUTE4QkJ3V1JBcWhiTkdy?=
 =?utf-8?B?NUh4S1BUOHRMVEx1bXdSWFY5OGhFTzcwTjRzY2IwdE5mM1ZDUExBcEt6c0hQ?=
 =?utf-8?B?emQzV0Q1VTlReUNzeHJ1TkI4WFpwVC9WbW1BVm5wMCtWS1c5c3p3WDhtcEZF?=
 =?utf-8?B?OUVNT2ZhcDBNOFJnb2NKVjhPRFgyK0hiWEorQTdpWkVlc1k4L1JxOVVCWWNN?=
 =?utf-8?B?VTJDS2k3L29YVDcrOGkvVXlKUGNuOEN1Vm80U2F5QVhJd1JEdm9haFNIa1Iz?=
 =?utf-8?B?ZGpuL0RzYjcreXZvRFNtaVlQT0ptS0pINWcxcGZSekVmMHpHM21aOHRraG5H?=
 =?utf-8?B?WGg5Rk5KU0VxOXBXanFTU0UxQmlORHREMTAvbVkwdGtNTElDTVE0Z2U1UnJL?=
 =?utf-8?B?ZFh2RWhNOStpWm03U1JwdFA3M0FCRWQ2WTNoMjFyVTRDMEtSVVV1dnBRdkJt?=
 =?utf-8?B?ZHRVeDd0a1VCUWV2NWZNRW1UdnM3S2t5UGM0M0dVa2tnTFNmbGFEd2htaHVh?=
 =?utf-8?B?aGxuWmVvZXN4Tmp5a2hjVzlWUUlJK1dDRTRmU1JFOTRTZGgwOHFUWVFaakV4?=
 =?utf-8?B?M21rT1M4My9mdmdjbDdRN2ZoWUNWUmp1blpIRDRZREN6b0NTQmNiVEJ6Zk5M?=
 =?utf-8?B?QnJ0b0tyLzlXZ1AwS2hiMTlPTUhvSVFRSlRlWTM5ejZNT1BOYVpoVHBWWU4v?=
 =?utf-8?B?OVRySC9CWVllb2llTkFVVmhRQ1VFdVF2cFNvV1YvMERGS1lFRmFyVW9Ja1RH?=
 =?utf-8?B?NFAyVUljTk4wQmdlTnVzRkRVNDA3eUtFU1EvVWdMckdTVk9FWTMxL2JKQ2Q1?=
 =?utf-8?B?bkN6bVBWcWVCRDZQSFpCZnZFamptMEoyLzI4UlRtMlFqOVRmUWVFWE82RTZn?=
 =?utf-8?B?K1QyU1ZJdzM4a0c5bmtlQVJlQlppam9kODVmMzBDMzkvU3VaQVI4UnNhTWZz?=
 =?utf-8?B?ZkZyMVRBQXFjVnJnY0JiL21QR0ZNS2lJU2E3T3VaWGFGRjJZRWdqRkg2a1NB?=
 =?utf-8?B?emtOVXJweXA4azNzT2JMMi81M2xEK3VXbk52cVVNSHlmVjFHckp5NnZDdzlq?=
 =?utf-8?B?bS9hdjRqdFZ0alhNRk1relV0b3daM252em83bkxwOTdEWjhVeG0wbFc0WW1Q?=
 =?utf-8?B?dWxCZ1Brek93aEdmZDcxWFhBMlhEdmtPdjRQWUl3dEM3aGlIV3V4dUZpV0JP?=
 =?utf-8?Q?hOwp9x+EdC1534eb6iFw/0da0raVs+Yncx8/I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bS9SclVRaWFzdERLVTVySUVnQ0tmUG1oWXcvKzVLU2wrdWFZOUU1eHR6NzlI?=
 =?utf-8?B?MWcxeFlZNDA4WnRDVXlxbkh6MGtXVWtnNnZ5Mm1JNWxGdlpkc0RLcHhvQktw?=
 =?utf-8?B?c1EzR0ZOZ1JyeW1qM0QyeUtEZ0FNWEJrb1YrY3F5Wk4zc05lcjFUb0s1ZHlk?=
 =?utf-8?B?RzdMWHo2cGVGYlYwVmJwUlE1ZU1RcXNMUElySzF3aVdLNmplSGJaZnJXcHJt?=
 =?utf-8?B?SUNUQkVnVlFlZTQ2dlU5ODhvOWVsb3VMV0VLYU9GS2FuNnBYaTVxQTN1V2JJ?=
 =?utf-8?B?S0ZXOFhRdE1mdEMzamJDc0xCQnpFTHV0VHpnZTlHTmlzbU9Wbk0ydFBQbDZW?=
 =?utf-8?B?OFROVFNyQjJoc2Fic2pTb2p0YUViODBSeC92L3dMUGRObzdYemRYK200bjM0?=
 =?utf-8?B?ZnBoRXFyV2xCRWlteHlyem5DSm9NUzg4WUlNeU50Sk1QL1RDczg4S2JTYU1H?=
 =?utf-8?B?ZWR2SjNUTlZ2UkRTRnR2UkQvcVo1NXBOU0UzdWxYa0RONVloeGVBU09WUGs0?=
 =?utf-8?B?Z3BlUlkrTTY3UjFzM1ZJNnh6NW9ONWEyUU1HMkFqdnkzK1ROOG9wZ0xkRUFh?=
 =?utf-8?B?SStiRk9QVVBDRVRsZ2taY0YxMjVyTDhnNnFER01IWE5tVXFmSC9RWk5XYzgy?=
 =?utf-8?B?c0pMQkc3R3RLK0MyTzZqdnVNalVsd1BJdmh1R1NPQjZZVDk5WkxVc2dzanhp?=
 =?utf-8?B?T0UvWEFpZm55cTVIWHZLWHBDR3ZwbHE0bE85WHkrakJqRDg0WjJzZ2dJQ0tZ?=
 =?utf-8?B?eFczYnZBM1VBUWlZYVVHQ3hvdzY1YlJxY1U0Um1NWlg1M2NhLzlxV3JuZndB?=
 =?utf-8?B?QUhvWTdYZDBCeG1wcDRzekFYalFoRHQzSGxRQnVwbE91NWYxa0l3NnA5TXFS?=
 =?utf-8?B?UnNOdzNlaXRVWTI1QisybVRISCtNbDZkU24rZFhaQ1dFWEJsb1M5cTM5Nkk0?=
 =?utf-8?B?SlIvRlJ4UTB4Q2NWc2FUdUhHNFRGZm4wcmVibmtYaklxdE1lNzF1R2hyOE5x?=
 =?utf-8?B?QW5oVnpTa0FJRzBGc3BSWnFXR2hjT2ppMCtUZ09Jb2U4VVpZaWtuWUFFWkNC?=
 =?utf-8?B?TjF4RGNXbmJ6eTN6clRNcjBscENCUS9Iekg5WHVJNnZ3RElucU1CT1RBMmQz?=
 =?utf-8?B?WkRPMHhtSGZyeVQ4dGRRQ2o5cWQ2YVk4ckIwZ2h2MVNhTlBHQm05Z3ZLUWhZ?=
 =?utf-8?B?alkvdEpnMmxvWGdYRGxCZm5QK0VMNkdqLzZObE44NU03YlZhYTJpSkQ4ckZn?=
 =?utf-8?B?cjlOUmxCRDJxVU44K0N3dmtsNngvS3NEUHNrT1NVU0M1eE1LMFF2My9aWVBK?=
 =?utf-8?B?ZkJXZkt6Rng2QWc0N0dVSnJNZzhXWkxJZld5NVJYSkR5cTdZQ0FFYWw2eWpS?=
 =?utf-8?B?NkZHdU44RXpIZ2ordkl1WWFCd0tIRXVFTDcxWW91TWxka3BCTEVDWiswc0Rh?=
 =?utf-8?B?YlcrNTZRREdheXV3RGRNT251YlFhaHVPMVJkYjdrOG85UG04ZXNKRDZZQXh5?=
 =?utf-8?B?MUlJdk83V3c4cmhkM1hEU0ZDNEhFSzhUOGZPTjBkb29xUExMSlNFVnlOT1or?=
 =?utf-8?B?QXh4cnVNZ20zQXl3WEszZXhlOGpDOGQ1QUFzM2JKSEdlVzU5TzhIZGNHWWQ0?=
 =?utf-8?B?NUgwWEFLMFc5R3dET3lrZHZXZGZrOExVdHozMzdSZUxSSW55bjZIK2F6TllI?=
 =?utf-8?B?SDNxWktPZ2pjcDZRMTBmMyswYnRzTkdLMU9kWVM0aXBQOWltYUlWRHpVazZ0?=
 =?utf-8?B?UnRjUzYvcnRNUGJ4VWN5Qm8wbzZUaFlyVkVmUm5FcGQ4UnI0cDV5VnZSNTM0?=
 =?utf-8?B?a0dtZ2xHeW9uQng1ZndqZUhJSWw3VjM2NEUvNXhHTEZZME9lRDRvTGppTXNy?=
 =?utf-8?B?Nzg3Njk0eUNsS0N4RWQrU0Z0VFVwdlVxSytaa3RaZkcrc2Ntd0lUWkMvMUpa?=
 =?utf-8?B?RGV0dUNVZ0tlMW9DMHJXbmI4Y1NIWVQxN1pNY0lGZjd4UVZ2U2xmUE9FNENs?=
 =?utf-8?B?MmFvWFUwc0NQNldMaUdVS1N4WUJJN1lwZlUzZ1ZaM29lQ2xxVldKVDlzNENi?=
 =?utf-8?B?Vnk1Q0J6UmJocCtHYysvcGJCRlF0dTJxZW1udTdMM1hsaFZ5L0w2TzNLUlJY?=
 =?utf-8?Q?6vRs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be2fdfd-742e-4cd0-ae76-08dcbdf7a16c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 13:30:44.2196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLsptExRnY+0dxRurmzlejdyCyDGv5qwAJMpNYhH1TOpUXYnNCWgN8A35+DGY6sdW03QQwh9S9s0nxR/uo6wDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5740

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KUTogQXJlIHlvdSBydW5uaW5nIGEgbWFp
bmxpbmUga2VybmVsPw0KQTogWWVzLg0KDQpUaGFua3MNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0t
LQ0K5Y+R5Lu25Lq6OiBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkgPG1pY2hhZWxAYW1hcnVs
YXNvbHV0aW9ucy5jb20+DQrlj5HpgIHml7bpl7Q6IDIwMjTlubQ45pyIMTbml6UgMjA6MTcNCuaU
tuS7tuS6ujogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcNCuaKhOmAgTog6IOh6L+e5YukIDxo
dWxpYW5xaW5Adml2by5jb20+OyBxdWljX3ByYXNoa0BxdWljaW5jLmNvbTsgcXVpY19qam9obnNv
bkBxdWljaW5jLmNvbTsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgb3BlbnNvdXJjZS5rZXJuZWwgPG9wZW5zb3VyY2Uua2VybmVsQHZpdm8u
Y29tPjsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZw0K5Li76aKYOiBSZTogW1BBVENIIHYxXSB1
c2I6IGdhZGdldDogdV9zZXJpYWw6IGNoZWNrIE51bGwgcG9pbnRlciBpbiBFUCBjYWxsYmFjaw0K
DQpb5L2g6YCa5bi45LiN5Lya5pS25Yiw5p2l6IeqIG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5j
b20g55qE55S15a2Q6YKu5Lu244CC6K+36K6/6ZeuIGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRT
ZW5kZXJJZGVudGlmaWNhdGlvbu+8jOS7peS6huino+i/meS4gOeCueS4uuS7gOS5iOW+iOmHjeim
gV0NCg0KSGkgTGlhbnFpbiBIdQ0KDQpPbiBGcmksIEF1ZyAxNiwgMjAyNCBhdCAxOjU44oCvUE0g
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3
cm90ZToNCj4NCj4gT24gRnJpLCBBdWcgMTYsIDIwMjQgYXQgMTE6MjE6MjRBTSArMDAwMCwg6IOh
6L+e5YukIHdyb3RlOg0KPiA+IEZyb206IExpYW5xaW4gSHUgPGh1bGlhbnFpbkB2aXZvLmNvbT4N
Cj4gPg0KPiA+IEFkZGVkIG51bGwgcG9pbnRlciBjaGVjayB0byBhdm9pZCBzeXN0ZW0gY3Jhc2gu
DQo+ID4NCj4gPiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVu
Y2UgYXQgdmlydHVhbCBhZGRyZXNzDQo+ID4gMDAwMDAwMDAwMDAwMDFhOCBwYyA6IGdzX3JlYWRf
Y29tcGxldGUrMHg1OC8weDI0MCBsciA6DQo+ID4gdXNiX2dhZGdldF9naXZlYmFja19yZXF1ZXN0
KzB4NDAvMHgxNjANCj4gPiBzcCA6IGZmZmZmZmMwMGYxNTM5YzANCj4gPiB4Mjk6IGZmZmZmZmMw
MGYxNTM5YzAgeDI4OiBmZmZmZmY4MDAyYTMwMDAwIHgyNzogMDAwMDAwMDAwMDAwMDAwMA0KPiA+
IHgyNjogZmZmZmZmODAwMmEzMDAwMCB4MjU6IDAwMDAwMDAwMDAwMDAwMDAgeDI0OiBmZmZmZmY4
MDAyYTMwMDAwDQo+ID4geDIzOiBmZmZmZmY4MDAyZmY5YTcwIHgyMjogZmZmZmZmODk4ZTdhN2Iw
MCB4MjE6IGZmZmZmZjgwM2M5YWY5ZDgNCj4gPiB4MjA6IGZmZmZmZjg5OGU3YTdiMDAgeDE5OiAw
MDAwMDAwMDAwMDAwMWE4IHgxODogZmZmZmZmYzAwOTlmZDA5OA0KPiA+IHgxNzogMDAwMDAwMDAw
MDAwMTAwMCB4MTY6IDAwMDAwMDAwODAwMDAwMDAgeDE1OiAwMDAwMDAwYWMxMjAwMDAwDQo+ID4g
eDE0OiAwMDAwMDAwMDAwMDAwMDAzIHgxMzogMDAwMDAwMDAwMDAwZDVlOCB4MTI6IDAwMDAwMDAz
NTVjMzE0YWMNCj4gPiB4MTE6IDAwMDAwMDAwMDAwMDAwMTUgeDEwOiAwMDAwMDAwMDAwMDAwMDEy
IHg5IDogMDAwMDAwMDAwMDAwMDAwOA0KPiA+IHg4IDogMDAwMDAwMDAwMDAwMDAwMCB4NyA6IDAw
MDAwMDAwMDAwMDAwMDAgeDYgOiBmZmZmZmY4ODdjZDEyMDAwDQo+ID4geDUgOiAwMDAwMDAwMDAw
MDAwMDAyIHg0IDogZmZmZmZmYzAwZjliMDdmMCB4MyA6IGZmZmZmZmMwMGYxNTM4ZDANCj4gPiB4
MiA6IDAwMDAwMDAwMDAwMDAwMDEgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgwIDogMDAwMDAwMDAw
MDAwMDFhOA0KPiA+IENhbGwgdHJhY2U6DQo+ID4gZ3NfcmVhZF9jb21wbGV0ZSsweDU4LzB4MjQw
DQo+ID4gdXNiX2dhZGdldF9naXZlYmFja19yZXF1ZXN0KzB4NDAvMHgxNjANCj4gPiBkd2MzX3Jl
bW92ZV9yZXF1ZXN0cysweDE3MC8weDQ4NA0KPiA+IGR3YzNfZXAwX291dF9zdGFydCsweGIwLzB4
MWQ0DQo+ID4gX19kd2MzX2dhZGdldF9zdGFydCsweDI1Yy8weDcyMA0KPiA+IGtyZXRwcm9iZV90
cmFtcG9saW5lLmNmaV9qdCsweDAvMHg4DQo+ID4ga3JldHByb2JlX3RyYW1wb2xpbmUuY2ZpX2p0
KzB4MC8weDgNCj4gPiB1ZGNfYmluZF90b19kcml2ZXIrMHgxZDgvMHgzMDANCj4gPiB1c2JfZ2Fk
Z2V0X3Byb2JlX2RyaXZlcisweGE4LzB4MWRjDQoNCkFyZSB5b3UgcnVubmluZyBhIG1haW5saW5l
IGtlcm5lbD8NCg0KTWljaGFlbA0KDQo+ID4gZ2FkZ2V0X2Rldl9kZXNjX1VEQ19zdG9yZSsweDEz
Yy8weDE4OA0KPiA+IGNvbmZpZ2ZzX3dyaXRlX2l0ZXIrMHgxNjAvMHgxZjQNCj4gPiB2ZnNfd3Jp
dGUrMHgyZDAvMHg0MGMNCj4gPiBrc3lzX3dyaXRlKzB4N2MvMHhmMA0KPiA+IF9fYXJtNjRfc3lz
X3dyaXRlKzB4MjAvMHgzMA0KPiA+IGludm9rZV9zeXNjYWxsKzB4NjAvMHgxNTANCj4gPiBlbDBf
c3ZjX2NvbW1vbisweDhjLzB4ZjgNCj4gPiBkb19lbDBfc3ZjKzB4MjgvMHhhMA0KPiA+IGVsMF9z
dmMrMHgyNC8weDg0DQo+ID4gZWwwdF82NF9zeW5jX2hhbmRsZXIrMHg4OC8weGVjDQo+ID4gZWww
dF82NF9zeW5jKzB4MWI0LzB4MWI4DQo+ID4gQ29kZTogYWExZjAzZTEgYWExMzAzZTAgNTI4MDAw
MjIgMmEwMTAzZTggKDg4ZTg3ZTYyKSAtLS1bIGVuZCB0cmFjZQ0KPiA+IDkzODg0NzMyN2E3Mzkx
NzIgXS0tLSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogT29wczogRmF0YWwNCj4gPiBleGNl
cHRpb24NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpYW5xaW4gSHUgPGh1bGlhbnFpbkB2aXZv
LmNvbT4NCj4gPiAtLS0NCj4gPiB2MToNCj4gPiAgIC0gT3B0aW1pemUgY29kZSBjb21tZW50cywg
ZGVsZXRlIGxvZyBwcmludGluZw0KPg0KPiBUaGlzIGlzICJ2MiIgbm90ICJ2MSIuDQo+DQo+IEFs
c28sIHNhbWUgY29tbWVudCBhcyBiZWZvcmUsIHdoYXQ6DQo+ICAgLSBjYXVzZXMgcG9ydCB0byBi
ZSBOVUxMDQo+ICAgLSBwcmV2ZW50cyBpdCBmcm9tIGNoYW5naW5nIHRvIE5VTEwgcmlnaHQgYWZ0
ZXIgeW91IGNoZWNrIGl0DQo+DQo+IEJvdGggbmVlZCB0byBiZSBhbnN3ZXJlZCBiZWZvcmUgd2Ug
Y2FuIHRha2UgdGhpcyBjaGFuZ2UuDQo+DQo+IHRoYW5rcywNCj4NCj4gZ3JlZyBrLWgNCj4NCg0K
DQotLQ0KTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpDQpDby1Gb3VuZGVyICYgQ2hpZWYgRXhl
Y3V0aXZlIE9mZmljZXINCk0uICszOSAzNDcgOTEzIDIxNzANCm1pY2hhZWxAYW1hcnVsYXNvbHV0
aW9ucy5jb20NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KQW1hcnVsYSBT
b2x1dGlvbnMgQlYNCkpvb3AgR2Vlc2lua3dlZyAxMjUsIDExMTQgQUIsIEFtc3RlcmRhbSwgTkwg
VC4gKzMxICgwKTg1IDExMSA5MTcyIGluZm9AYW1hcnVsYXNvbHV0aW9ucy5jb20NCmh0dHA6Ly93
d3cuYW1hcnVsYXNvbHV0aW9ucy5jb20vDQo=

