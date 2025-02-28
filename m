Return-Path: <linux-kernel+bounces-539430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C153BA4A422
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96C8178612
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447AD276027;
	Fri, 28 Feb 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="BikfexsN"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511A123F391;
	Fri, 28 Feb 2025 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773920; cv=fail; b=rJ7dcz63JgFShT5GEXVbQX7Xvt3kCjajiZVBPAg9CIaT8gvY5d965O5hWUbZCY5nZOWg0C3oa6f0SqbLe1A1IK05kjewmqmMpXVfERs6HM72lJGpdbHkDosc7RCiDUWd8C9kJfsAnSBW4WvptEDzExp7JGzsR2kGA1N6zzUS2LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773920; c=relaxed/simple;
	bh=v0qThQeNVktjCqNW0iHnYkcN9SotcCiIG7+Pb408Y70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=R9R5ee+xYPl0esxjlTx3ITZW0wVpDGbn4r6AlhE/b+5QQL9Nf9gYsE8A0DbJk/6PHVCX4Mr1TK/4lLeTf5IGllkIc/oWcxOMRPA6lJTxDnBswFwt5ccdH4KKNVHU39sZUNvlBi8udKbBGhPxx8S6zfckx+Co/6w2bKwUjcLPJH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=BikfexsN reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SHecDi014999;
	Fri, 28 Feb 2025 12:18:22 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 453hr6g9xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 12:18:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnIY7iwfbOlE/DNsUNXPPtHm42FYc6ji41wul0Zers1PLdbmEayMs7PJhzhF9qbn0hQ8YWyqdzzdzBBYAVLxHYPhBsU7NXkrhMMYM2kQ+MGxK+5rqUZ/yu/g42eOna0b92TRd2RsIU9CNcNDU3kmI8GbUXjMR4RO0IcPZhMbhmPBB5hplX8JFUgx5RlgbDtUDlp7b4MhMJiopvkK9Qlww6hHU76d6cJowr0BqIDYdO1DNXKr13yoxy9Q2wCCP5Sb6q/KGvKfJSxHsxvOKStuHpDZPqTWVSRop9ntZkiZs1L4anf12c5zrrURlHVbjrICea6vRtI0JxTlnSofmn+eCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OlUCowk82WMqqAA5KiAL42OJKXy5d/K7RJ2m5SmACs=;
 b=oYYys6SWPzRj89qtbgFHr7R9vwrY8JSbv0X39Q0FHUEt5zuLVeZ8d2bfirdOntCz4dqH17rL2D7YwscG2blOYmBZhyw2e1NxrU64UpDlJsZ7FCU/Ctff32bUuyznIrizmiWWzhi61NLrOhvIGpB1DbaEQ9cBfdgG8GMafGdMbNU+oCfZtEJg/qDGPAy/WZSE9sQ0BEpq8Xg3bCjBdHxIrCNuE7DF5o+n9oDl3j7AqNLzcfCI7QPTHlbwprEgPhv7sYfKZfsaxMpCz6SdMRt04d+fUnobHlp0DmFMRi7js2XfiEtsxKGnCtVjy0bvFVVDz2uDCSR5Hog/f86IKnpg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OlUCowk82WMqqAA5KiAL42OJKXy5d/K7RJ2m5SmACs=;
 b=BikfexsNtcFl6XfLFaFoDjjGe+hxg6/Xn+KGd1Sp/YE9gCVPL8bCtDy6o07mR+dNd1qMlLb07wIW0wH5snKHmDD/WCUrO+ahd5UYGNCcd1IX/2UOmkMImBctmJxffz5QxFKwCHyu6LdqSeSqEvOJcUpP4qhCz/HF85THOevdtak=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by SJ0PR18MB3819.namprd18.prod.outlook.com (2603:10b6:a03:2e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 20:18:17 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 20:18:17 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com"
	<gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com"
	<sebastian.hesselbarth@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Sanghoon Lee <salee@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 3/3] arm64: dts: marvell: cp11x: Add
 reset controller node
Thread-Topic: [EXTERNAL] Re: [PATCH v3 3/3] arm64: dts: marvell: cp11x: Add
 reset controller node
Thread-Index: AQHbiU1lL+VUO6yWOk2KsdzyM2pe7LNcSUkAgADBt8A=
Date: Fri, 28 Feb 2025 20:18:17 +0000
Message-ID:
 <BY3PR18MB46730C150D4CB9619B3B05FBA7CC2@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20250227192536.2426490-1-dingwei@marvell.com>
 <20250227192536.2426490-4-dingwei@marvell.com>
 <d085c34a-fdbf-4950-a2e3-b3d25a1c0145@kernel.org>
In-Reply-To: <d085c34a-fdbf-4950-a2e3-b3d25a1c0145@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|SJ0PR18MB3819:EE_
x-ms-office365-filtering-correlation-id: ba77b490-fdcb-444e-0569-08dd58350987
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUVqZ0ZoOUZ0bU95bzdwM0dvVUh6SlNITnNxUVFLeTkvYkgyMzlTTjJ0SDBK?=
 =?utf-8?B?UGxoMnlWdUZBWmVQd1JNdmJ6THF6TWJlNWhDSjBVaTVJMG5xMU8veis0cXNI?=
 =?utf-8?B?VmF2ZTZ2MmR2NHl2OVpqVVJkUUFUSkg1Nm1ZaXliUjQ4ZnpkcTZZU2kxOFFM?=
 =?utf-8?B?RVRaRmFPV3U4cFdOWEJYRHNsK3FPQTQ3Q0wxdnN4M0ROYi9JU2diaVFuRzEv?=
 =?utf-8?B?RHE4emNlOHpkaWllWlM4Zk4xYmVmZHpLUnlrQ2pTY1A5b0VyNWU1cjJWV09R?=
 =?utf-8?B?WXltRzBuVUdNM0xQYXh3bTBjV2UyMTZ1djJzSkJId3hwWWV1cVpsaW1FME5r?=
 =?utf-8?B?aWYrN2ZFcFN6QW5pVmFrc2s4VlRrWmR1bzZRdVZMSW0vU2lld3Rpd0NmMW1S?=
 =?utf-8?B?d1ViYkNJWEhWUFV5bXd4SllCTkJNS0pRaG00ZVYydnNCQW5XU0ZhVTRkNTE5?=
 =?utf-8?B?Tmo3M1Q1ZUZhanhjWjdNOHduajNCSE9sWlBSNnQzenR1UVRuUWVma0E2OCs4?=
 =?utf-8?B?cmd5MjNabFFmVjIwa01mMTBUOVpPSnh6dTJnY0hqcHRSQlg3MHRDZnJWOVd3?=
 =?utf-8?B?WWVnKysxNzY3ZUlKZFBaRk0zRzRBUHVsZHNvQVRXMWxQWW1paU1VRjhjQm5K?=
 =?utf-8?B?U1E1dkxGckltS3lhWnZkVEFETitERDVHbVpieS9VLzZmeHZ0OWltN0xaaU5Z?=
 =?utf-8?B?QWJRSGdRcy84N0hsNUY1VU9nNERvOHBWUm5hWmFQUW5UUFZLQlR3cUlKeFdw?=
 =?utf-8?B?OWRCdGl5bzdNZHozTEQxdHhuQ2Q3TG1pK2VJQUs5QVU1SEFtdFlVNmRObERm?=
 =?utf-8?B?Y204eUFCQU9VWTVzRTBXNkNBZjFHYVJ6N3dmYm5CMk5CK1YrR1lSS0ptck93?=
 =?utf-8?B?eDBxZDZDSFJqSWE1d01SOU16RmFHc0hxclJFVG5RUUhZTXhLamg0VCtGanN2?=
 =?utf-8?B?RWlNamNhYW1MTmN2NFRDWDdqajZnbHo1UCtXK280dUhnOHlYRm52L3pVUFlM?=
 =?utf-8?B?aWZqUmdVRDJxYlcvRHY1bHgrQXQzdGR0ODcvRllOTDR2K0JTQWRVSitudGdy?=
 =?utf-8?B?amFuNDAybDNscllwaERyVElwNTg5Wlgydnpod3NBaUJ4TUhpdy9adTNrV0Iz?=
 =?utf-8?B?RXJxZXNHeW9WdnZxMU8rYWN6ZXd6T2hkb255ai9pTTRxZzNWZjlwb3lWVjVi?=
 =?utf-8?B?Y1FhdDhoSXlVWGZRbjllY0hISkVhT0pCNzdPYXl0VkhTVzNsOEFuNHVVY0NV?=
 =?utf-8?B?aU1wTk0wclovcFVsKzFGMy9hWkIxVGFnZHhZZUppblFWazdGQkc2RGhJcGhX?=
 =?utf-8?B?MW10ektnSzVyZkhoSVptUGgycEFxSTI4UWs3WmhkLzRXaGdUS1o3bFFGK2ha?=
 =?utf-8?B?aWMvWXQ1SjJ0Nmk3dWY5akJtK3hFcy9yRmQ5VDZsL3Nja01NaDB6eEJyL1Qy?=
 =?utf-8?B?T0tTZ2tOTlp5MlYxbGt4TlBIQjRPZmpUejR5bWxwMVZQaFFJeU11Rlh2MHgr?=
 =?utf-8?B?bllwYWRkUXBiV09rT3lnMkJEMmFXWkZqck8wZUFFbmt4RXFsVEVnUURmd1Mz?=
 =?utf-8?B?QUhkUUQ5MVlkY1dlSGN5NlMzdmRLNXNXYVJRNEVBSUJRQk0xODZIb0VDeHBw?=
 =?utf-8?B?aWlEcmIwdEEvOVVuZlc1Qml6SGhveE9zZlZSYXhZMUhrWEowNWd6UHdiejIx?=
 =?utf-8?B?Yis4WWU2MGRZZG8za0IwcDhaMUk3a0lxcGxjQ2I3RkhJMmQ1L05KNXZRbCt3?=
 =?utf-8?B?ZTAwM3N5RjAxSVlteW9OcTBUWHV3REhVUDI2UzNCSEZhRkZMa0ppMlM4RStT?=
 =?utf-8?B?eU9TWWNFRnNQaHpOTEIwb01URDFUSlNQWFNpLzRxT3lHeE01Z2lqS1BBYk1Z?=
 =?utf-8?Q?4TMpocmtL29If?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlRCUmN0UXRldFA1azM2eDhieVAwNEZOOUd5djZkYVlPZnppZklna3FNTlpZ?=
 =?utf-8?B?VUdMZzc4RVE4QmswdjlYSThDWTQ3RGRLL2ZDUUV6UndmOFlBZEFJb1RxYjZu?=
 =?utf-8?B?K09rUGxWQzEwTGRCd2k4eVRQRC83VTJ6bGMvTXN0UXpvOWk3cjVDM2IweVZm?=
 =?utf-8?B?YmhRREVEWFBLRWNhTXJBY2l3R3ZiNEhuNXAzS093MklUbHhvMFkyN3NCd2Z3?=
 =?utf-8?B?d1dlbEIyRnorbFF6S0ZpaTA4R0o4NjBReFp3RFloQWE1b1Y2L2M2YksvMUtK?=
 =?utf-8?B?NXJyQmZaT25YdWNYTzA5NVdnOWdPL2FQN1VuekJoc0MrZEhQWUI5OUI2bVEv?=
 =?utf-8?B?TnZnK1F3RHgxemJ6bFZnMEtoVG9iczBDaURvaER5MEQrb3pYR2Z3M05TRFlx?=
 =?utf-8?B?Zk95QXpjMFY1THl3eXBLNGdZMXZ3NDZmR09JYkpOV3l0QVFPRzdHRTdKc21m?=
 =?utf-8?B?MUJtVFk4R2YrOTJKYjVIYjN5dWFUN09uRDBYWGw5dWZwR3J0VzhLZjc5azNw?=
 =?utf-8?B?NCtZd2QyNXNYbWdzRS9FR1J6My8zOW0zUDZ3SHZINkRxUVVNU0ZJZWhKOXVT?=
 =?utf-8?B?YUtsYXJyR0h2OUkwZS9WSDFNaW4vT0FDSndQSUNjTUxhVVZMWHp1NVRjREVx?=
 =?utf-8?B?Tm1QNm5pRlJWenAwSnVyVkU0UTZwdVBwVm9hamVaQ2RIYU9pVFY5UGp6VThz?=
 =?utf-8?B?cExjU0dsZ2p0MFBBQXgvWDM3dE9oNUdNc2ZNQ25jV0JoVFZtM2JYeU41cGpk?=
 =?utf-8?B?ZWxPTHl0dEVQelpGdFB5U0pDWFBHYzhpa3IzblB5UVZZTkI2b0hZdjVaTVFE?=
 =?utf-8?B?ZDlhNllrOTdnQkZkczZZVjE0aENHVTJqWmM4cE1ncjZNVURXL01XbS9HNEly?=
 =?utf-8?B?NFo0TGRoQ3hJeHh0dXp4ZGUrY2RSajZJbDA4a0RGODdjc0F5STFUSXNUT2da?=
 =?utf-8?B?aGNXWCs2MXRPczE1TU04Tk51YnZFSVRteHREL1B2bkorRVFXdkJkRlJzVHBU?=
 =?utf-8?B?bUpzcUxWVGpiY3FVU1hxelRsazdEZjFrTWtYMk1GNGNObDNHQmMxcUxoWWlN?=
 =?utf-8?B?TmNtai9TT0lBNmM2KzdFT1dpci8vRGtueFk4U1FLUkF3VGplY2lIY2QxUzRL?=
 =?utf-8?B?SGRrTTlzV2VoT3ZpZEhjUS9sellxL0Y0Vy9jNUdSTFQvWkppWGRKOGFKaXVU?=
 =?utf-8?B?VUhSVHNCaElDN3o2VXpmQWs4bWl3ekFMRUZjNy9VOERWYjRtR1p4b3B0NjJH?=
 =?utf-8?B?SWRuN2V2MC8vYlc4NnQwYUpBUElnUDVoY0QrK2dyWE1IOGZzdzNKZkdGRjg3?=
 =?utf-8?B?Y1Zkc2FMaUpGNHY3R2xUemQ4YmVXbmFDakQ2SVFsSGpMQXE5NVl1ZkpZNFVu?=
 =?utf-8?B?bkV3dGJhSjZ4S1F5bFhjSXZqN05Va0ZLVHA5OHVHTzRuQlMzWGN3M0R2cEJl?=
 =?utf-8?B?MTNNbFhlbEhLRXpKK0FmMGN5ZUpNMXVSV3lOeExNMUx4akdGeFdOYkE5bXZu?=
 =?utf-8?B?ODVNRkxPRUYySkVodExnSG5WSkJhSjlKc1BxQlNuQ2hUSVlid0lFS2dVd0FL?=
 =?utf-8?B?bDhmcmZtRGg1eDBPajBiTlhrd2paSEZUby90dUl4cXc1Rk9RcXhtcndRVGhI?=
 =?utf-8?B?Nmh6d2RvdEZCZHFrK2JDVTE2TXdJRVAwVVo5VElhZmVHQjVkcWlkS3V1VVdj?=
 =?utf-8?B?RmVxa2FCMktvM2NBOFdENWZpUHZVTTZuQ01xZ1ovWmNscGF4anQ5Y3JNNzQ4?=
 =?utf-8?B?bWlqeFhoT3pnRm5BTWExYk81RE1GdUc1OXVtTTRGVmRpOUt1eWQ2YTFETHRK?=
 =?utf-8?B?RGx0VDVnRE9Fbm9RVVFnMk5kNzJYU3FWZjR6S3F2dm1rcHZUZXJuQlREb1RZ?=
 =?utf-8?B?cnpsaWpGd3F4em5kWkVib2hMZzEveWpucjQ2a0xlMWZBWlh1c0FkcmlLaUV4?=
 =?utf-8?B?NnNjaE1peDRLSm42QjhjRkRsSmNJQTJ0aW5NTnlDV2l0VWRYLzF1MjRkY29V?=
 =?utf-8?B?Sm15ME0xanRSeG10QVVJVXJIeWRFcTZydlY1T3JnZFhiQmZkdlB5aFZ1ekVC?=
 =?utf-8?B?WU9MckZvM3FlWDlLOGh0Q2pmM05BRXR6cWpIdE5qRkJMbEFRUE9ZTzhXSHdv?=
 =?utf-8?Q?rfR0=3D?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba77b490-fdcb-444e-0569-08dd58350987
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 20:18:17.2595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gP9JQyOtbFYW99I7ORRqr4cWsxQHSvkGD0OkSuKqk0mIqBiQV1dB7wM0htweCzy9ZEDfkLEjjtWyt27ZJmAiTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3819
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Mrmo63ae c=1 sm=1 tr=0 ts=67c21a0d cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=JfrnYn6hAAAA:8 a=P-IC7800AAAA:8 a=pGLkceISAAAA:8 a=RpNjiQI2AAAA:8 a=O9rMLvU1OJ3WHwl7zg0A:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: oSHkm2f7q9ny3UpalVd0od8QhJEUSNl4
X-Proofpoint-GUID: oSHkm2f7q9ny3UpalVd0od8QhJEUSNl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Thursday, February 27, 2025 10:57 PM
> To: Wilson Ding <dingwei@marvell.com>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: andrew@lunn.ch; gregory.clement@bootlin.com;
> sebastian.hesselbarth@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; p.zabel@pengutronix.de; Sanghoon Lee
> <salee@marvell.com>; Geethasowjanya Akula <gakula@marvell.com>
> Subject: [EXTERNAL] Re: [PATCH v3 3/3] arm64: dts: marvell: cp11x: Add re=
set
> controller node
>=20
> On 27/02/2025 20:=E2=80=8A25, Wilson Ding wrote: > Add the reset controll=
er node as
> a sub-node to the system controller > node. > > Signed-off-by: Wilson Ding
> <dingwei@=E2=80=8Amarvell.=E2=80=8Acom> > --- > arch/arm64/boot/dts/marve=
ll/armada-
> cp11x.=E2=80=8Adtsi
>=20
> On 27/02/2025 20:25, Wilson Ding wrote:
> > Add the reset controller node as a sub-node to the system controller
> > node.
> >
> > Signed-off-by: Wilson Ding <dingwei@marvell.com>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> > index 161beec0b6b0..c27058d1534e 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> > @@ -226,6 +226,8 @@ CP11X_LABEL(rtc): rtc@284000 {
> >  		CP11X_LABEL(syscon0): system-controller@440000 {
> >  			compatible =3D "syscon", "simple-mfd";
> >  			reg =3D <0x440000 0x2000>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> >
> >  			CP11X_LABEL(clk): clock {
>=20
> Wait, no unit address here.

This subnode came from the existing code. I didn't touch this subnode
in my patch. As you can see, the system-controller has a wide address
range, which includes clock, GPIO registers as well as the unit-softreset
register.

>=20
> >  				compatible =3D "marvell,cp110-clock";
> > @@ -273,6 +275,12 @@ CP11X_LABEL(gpio2): gpio@140 {
> >  					 <&CP11X_LABEL(clk) 1 17>;
> >  				status =3D "disabled";
> >  			};
> > +
> > +			CP11X_LABEL(swrst): reset-controller@268 {
>=20
>=20
> So why here it appeared? This is wrong and not even necessary. Entire
> child should be folded into parent, so finally you will fix the
> incomplete parent compatible.

We do need the reset-controller as a subnode under system-controller node
for the following reasons:

- We need to have 'reg' property in this subnode so that we can get the off=
set
  to system-controller register base defined in parent node. This is sugges=
ted
  by Rob in V2 comments.=20
  And we need to know the register size to calculate the number of reset li=
nes.
  This is suggested by Philipp in V1 comments.

- We also need to define the 'reset-cells' in this subnode. And the consume=
r of
  the reset controller uses the label of this subnode for the phandle and r=
eset
  specifier pair.=20

As I mentioned in my reply to the first comment, the reset-controller is no=
t the
only device within the system-controller register spaces. Do you still thin=
k I
should fold it into the parent node. And what I proposed is exactly same as
that the armada_thermal driver did (See below). I wonder why what was accep=
ted
in the past become not accepted now.=20

CP11X_LABEL(syscon1): system-controller@400000 {
	compatible =3D "syscon", "simple-mfd";
	reg =3D <0x400000 0x1000>;
	#address-cells =3D <1>;
	#size-cells =3D <1>;

	CP11X_LABEL(thermal): thermal-sensor@70 {
		compatible =3D "marvell,armada-cp110-thermal";
		reg =3D <0x70 0x10>;
		interrupts-extended =3D
			<&CP11X_LABEL(icu_sei) 116 IRQ_TYPE_LEVEL_HIGH>;
		#thermal-sensor-cells =3D <1>;
	};
};

>=20
>=20
>=20
> Best regards,
> Krzysztof

