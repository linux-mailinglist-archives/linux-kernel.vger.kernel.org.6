Return-Path: <linux-kernel+bounces-573376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9893EA6D68B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA6216AD54
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7271B25D542;
	Mon, 24 Mar 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="017Rpmt+"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7F19ADBA;
	Mon, 24 Mar 2025 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805922; cv=fail; b=TQh/ObHmVYNZasnpRXCyoNHTx5rcYHMQRWB6Z2LPSFj+JrwIVc8BUhzm7zeeNmGSYH5iARIRDD3wcg6IEAOQIkqdby7M6OMy/nXJRrRExl/xxtfnje29RixusU11fQJdc52Z5ZVOq/mq5bTjp9iZiJ+ogqtmamOBULwFd+pgb68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805922; c=relaxed/simple;
	bh=cth4OM4ma7hX9U6MSJyIsUPUaXYAnlaTob2AqSh5z5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F37/WE+SQ0pa+xgdamM1/ssCypPOibQJZsiCrDlg8j434vxpkszFyRjTbwHiRArHyxcG+0aL/HuKFjvsHIr0n5MaN0GfjreVg3cGfFHCyg78vPdjLuA2NdiRn2E5Q9TwGs17aIBZG3ihpSlqD2CI1GXZuPiW3l+42kOzohvYVCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=017Rpmt+; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O7Ht1s009263;
	Mon, 24 Mar 2025 04:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IP7Bf
	1sRSAX+O4UQGiKbOo4ynZQhtgei4rlZAjDXQ0A=; b=017Rpmt+eiPfd12yZZ6HM
	8WW/lhIu9Sx646VmgnEZ07JDmMjH4QV3qj9iCGVFxgYrMvE0e7VVgLUcj1b9470H
	Sx4j1uKKwGM29zaQhI50JFEV7inxPic0UPOTY2iKiRR6QGfWR0Gh+vdfWEOYIEJ/
	tDUtp30zQr+KgGVXKrGEhcWQCZAA6Dw1DCF5BmNd2qeUDnNOTRtLSPnYxNBfrFik
	9BAP7EcB8SACVebsArOex61OBexCZ5J0OXjZP6uF9ifHhjMtvw45P0gyb5ACEfWK
	FePoOVjHtNOXv2RK94IKJbm7qFTZU+O3ZBgsrb1EtSM34k+mjZMppm7VRVEyLvCA
	A==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45hpyc8vf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 04:45:10 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNp+hN5tzGH1X6bIdPvtpl44/DpyKT3G2F2phY8DqPNfc6QxAtSVoyxjNkueniWRzmldRkNME2UZyIIO0bnsjMwNtThFEs+StELFBAv0+wqIz15NpwzJdd3vrNxVHitSK7mk1Wfnj/iKca5371Jfb+R5m82tVmgs92rAOdVRnHIdzRy1gs/naQ6aySTyF/ZpZVlNITthoIZFopKowU2wCRph8sh9PnbB3b9ADnOZKnVmVrVU+FEf6I5uysjuUdsPCT7PvjkqspaW1Xa/D/I7+nEN5GqoOi7AIJfwI0GjIZ0jf8CB1kohnhfSY9MOSmilSs96U7asEYASwCYrs1ao9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP7Bf1sRSAX+O4UQGiKbOo4ynZQhtgei4rlZAjDXQ0A=;
 b=t6S3QEqu9YwOgUZw4jil8XEPG+LKRcDzfEYJJr3PGP70QLZSbm9lf80gmIFSLpMGF/B6M7f1yS1tXwomQrfF9OW6+fORgVER/IA+qv+MPUcyyyMB4BV0nnL7lkDMrhzzf1XvpGFDLfZVOCAumi7xeZmx1hJAZPJAGCwPGIaLNU54uOQfcZaS6cIJRyRgKAwGCRNrBhOTVaH0XLWZLa6h7y1TWFLY1jbuqsWEwrhzoB2d0V3+wWWarFDP5IBhKAwfWf0QrdD0Sj9u3WGw5R6VnguHSWV4gLmEF6qQPkBxlUh9aNdcuscp4rLFlHoIu4khCn58askHHFVOHK2939Ua/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by LV8PR03MB7493.namprd03.prod.outlook.com (2603:10b6:408:185::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:45:08 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:45:08 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] regulator: adp5055: Add driver for adp5055
Thread-Topic: [PATCH v2 2/2] regulator: adp5055: Add driver for adp5055
Thread-Index: AQHbmWTtW3DxArp2x0Ggn/ZQxT+UzbN7vOuAgAXU+VA=
Date: Mon, 24 Mar 2025 08:45:08 +0000
Message-ID:
 <PH0PR03MB63517D9E6EB47162D205E47FF1A42@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20250320-upstream-adp5055-v2-0-aac2d3705802@analog.com>
 <20250320-upstream-adp5055-v2-2-aac2d3705802@analog.com>
 <20250320-flawless-sambar-of-aptitude-395df0@krzk-bin>
In-Reply-To: <20250320-flawless-sambar-of-aptitude-395df0@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|LV8PR03MB7493:EE_
x-ms-office365-filtering-correlation-id: 7af2d296-fc04-4ce3-93fb-08dd6ab02e8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2SAAv5trTcXgyOfLjiRGFGaW8Ky++wWrADdPHXaH8jRw8dthPtuYE3RAVFP4?=
 =?us-ascii?Q?VUuESLC87mlWRcoK+wdbn23WHjrGXEbxeRsA8BnMTLJ00FTGhX5M/oMSpp1j?=
 =?us-ascii?Q?wRvbdodYENG8mcI3woqjS2+KtYfghpmee2Qju9OsC/94MqMrmwVhCC/lztaB?=
 =?us-ascii?Q?6F1nsQWA3mFt/wPNqNUKNVT8DxJdR+hmoy+w00iCzOAXw9ZQ276F+HgtHqYC?=
 =?us-ascii?Q?NPa7BC17GJXbjnL9EaWl2QFPISaGY7zPFGG0MxaeTWTrDImoZHEUSPWJjmE0?=
 =?us-ascii?Q?lmbIHl0fiowNyqQekHsYrH1sOC/eFSDxTh52rvsqTgBuSAIZ6PW0fRXmAf2e?=
 =?us-ascii?Q?b3eJ90WMuAjwtJ/XNN2FzfFkbo7V/JlUIdmdpCxLm8BU5FsZkJLqTefkGqYj?=
 =?us-ascii?Q?GNI4Gaan/JxwWCUcfd8TdicuZtEqVaHI00KMe2+DqKge8wrr4MaPmdcmZrY0?=
 =?us-ascii?Q?ylw05I3UpHNUB8U4VI1NXEnX9Vr7wjHbbC1a683NaXBifE2h/39B/2G8JEK+?=
 =?us-ascii?Q?xdOnB3wQfTdx3IWxjB8pbgG7ChEOy0iOdm8PbMj4XbDE+JhasXmVpQsLJAHd?=
 =?us-ascii?Q?OAbt3R8MdRrbw3jt8SpNc1HI5tLYol7I7/xd8gGNGN6W8z0AfudmHPFEUBlV?=
 =?us-ascii?Q?gK+BvYzifu2poGeYDOodP6TBjfhBzbQvotWHx3BohpEc/jmNuu6LC/48AEs3?=
 =?us-ascii?Q?LBRtv1VKT63JBrtwdXGaefjCevMmnR7wgUCdTywiKp9C2rTIGxslTerkjdZp?=
 =?us-ascii?Q?Eo8fSoWo+r9YRZ/+Q0OCjzBT040lO4yHi+R7qzKrDUgfdiRQ/BE7geB8ZROr?=
 =?us-ascii?Q?BKPfQxax1ERIvP/qdgXUaVDb7ZWaGgBtrFUTly9gPY7KKPhgDA52W2ENDS5X?=
 =?us-ascii?Q?VqLmNxqcceTZgqCfyt/JVzfo4wKGxfR23MK587z9QU9AFMf5hMx8g2OiWFSz?=
 =?us-ascii?Q?scxROiH7ZCsOhtoxeViSZjlDXcz7sJTtmIprxEjVkizU2FuzxkHQHkKbMtAW?=
 =?us-ascii?Q?QRabmU2zC5MnJQ2cHTOcZpnJPz7VW1sAcCks/789ly0IxT3u66ze96ZFJKUn?=
 =?us-ascii?Q?5+tjPw6loKItu78HqKjqTEZVwA+etIkxU3IDIurNAPgafOyhy4pbPqYKkbh/?=
 =?us-ascii?Q?U865boOnyzjLTRuxSQvmxWBtuR7Nt7QNq/eHFpp9rBkzQYmYx9GUH7SdsYh1?=
 =?us-ascii?Q?ahRVebGWaGwtCZDfel2qqIj+B65W/5ETwDMB3flHKFH6RU332x51zdWT+d3e?=
 =?us-ascii?Q?3cqg4S36RZtcf4nWesBNAbIUnznkZPHpxhfkkawh4oHlsNp2B6Z7BZXmCix4?=
 =?us-ascii?Q?TkBgit4IjDAZ8dI3Lh3FA50W8vw0S0Tl4Glf6Ni4QuoXBJFBTxSK67aQ6Qfq?=
 =?us-ascii?Q?mJGK1T4arNNf19C9ZEc0OA29xnT9FwiTaOOJQz1kySE/gWwpVhUHE82maFCG?=
 =?us-ascii?Q?l6Tlvt75MFGCuqnvtXqiREBPFxaCy9Lp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yfghB6TeaRmJVc21q811LuFBMPb8t+PwLRDeH+N/psdNLj9uXNo5UqszN3DP?=
 =?us-ascii?Q?PpswaSujXukJJd+QpwOzBnZKhPVt6dhjedKBDUhigbDFhdVWdVvw1u5N+29E?=
 =?us-ascii?Q?oEJeq6COnBibG1Gi1/EleJVx36OL9tplw6cieLFGE69RCnufJad2pU6EwCtE?=
 =?us-ascii?Q?331HiGSBS/0RxQhsBrmViW8aMgvZx/LFrXMD2sd4vICXXfKI4/UxkyuOVmXz?=
 =?us-ascii?Q?0A7zrh3MF8OmJT19dKm/KKsZTRTBLvdZwgOAqANjLEf4v9CRcK23bG5dpMmf?=
 =?us-ascii?Q?/oZEC8CZp2wiA+dLhvKjeeE/QHh6kOi93OKBG72VF/Oyc9vBzz/TkfnPdBUn?=
 =?us-ascii?Q?5H8iKeQkIej4iwUptOWv7i30Y8f3D9ktIA3NfNahNjZ4l2K5L9AYmNiOSzle?=
 =?us-ascii?Q?JNKfhmbwHE6AGcm4GUJ2xh8lmgGbJlKqg505XowCTA3Sn2TdUbU+Upy8hfUB?=
 =?us-ascii?Q?8ajRwcWpV0i4LP7cxH+zM6sz5i2mUvBxs1Ce6ltFZz/9Zs+/GsriUl3CFBm9?=
 =?us-ascii?Q?E27GUFi/k4GBsXcO9JfTswwX19z3qjwffsYg0xLQCTe6Q3GkTL642AHjf9i6?=
 =?us-ascii?Q?PIG/YzolwX6MIQqJ+yDQNt8axbifNXr6NtzBJZwS0DrcGOo2K3hLzjssZB4i?=
 =?us-ascii?Q?GmTDucRlJit6GhN+/K79dC6I0yCZZZnkUNfwElXFKXuE2E7zEZobPWnG1tIe?=
 =?us-ascii?Q?/fENefUpsuidLaXBgeRP2bLaj9S5ZehPDQHpGeWpiyrU45DJRNT6dTYaC6BM?=
 =?us-ascii?Q?EfJTHRXu5EZbn7bRoOvd3CJn9NXDLLQZYYC6CvMflkqr7G345k9g01ay7+jg?=
 =?us-ascii?Q?UvtzNb7gH5WywjAFSUsqnlWQq5Uoh0aGQqT7XD5WUiryDM5j/nzmYAyqkAN9?=
 =?us-ascii?Q?Y4vhqOeXTqZYgk/WcbfJpYeILZKrudNxF0aTjEQlKAhKVXuKWZwflmc5Xorh?=
 =?us-ascii?Q?0IQvAW34rszjZMqPZulX2/iKx7TzxZn7QE6BHqhxslyhz/gQkfgaus3gMMNw?=
 =?us-ascii?Q?0BOTJ/h5NRXliHhvraYUO3go8LJkbZoEG1HXO4PAVn7QTUqxLRWK8yB2nSAd?=
 =?us-ascii?Q?HEzY0K7w0KshoTznHdMvGHFVuFa24HDXuCzazPztwo0rdCo/guOtSm//NJj3?=
 =?us-ascii?Q?IFtqg1p8hCE+v8VMdR8fspNHtMaZTY5QszT8VSIC6/gvXt6p6B587qUKmN+b?=
 =?us-ascii?Q?wGWa9IAdHuLwzL9XqwHucEeerdfToeomX8CumjjG2skbCnrwswf/fRysT8SC?=
 =?us-ascii?Q?LZ66rLy9MCdZHTM/Cfqq8eAk9qeMojdZpDuywqCdvtO+MyfoEdsuQyc5g+/c?=
 =?us-ascii?Q?gLtmBAL2liK8PJnG9RRfmIUpTGZ2D1AXFs/qIHOz6XrekoESjm6T2qNkFt2r?=
 =?us-ascii?Q?6Xs6Oo2JyeHdW/sQi4jWz5eYUgQEmZzF9p5+XtaCtVhWSqoY+IT++Tsvck85?=
 =?us-ascii?Q?NgHWDwBuzIjvfcHVxJTLXW15yP1sOLcjMWTL/qGoGLvVRv9ZiGg2MAfjHngT?=
 =?us-ascii?Q?Hz7QKMv1+FTXlafbb9wV7G2sSQClaj1RktrPkUEM1+7LHPXq6Xw/TDwcNbO9?=
 =?us-ascii?Q?RT9A7AbtJjV5w9jsK9YENTW9p6mXlELxBKmNvyAwl2YZFrI2QKCCljj7ruPA?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af2d296-fc04-4ce3-93fb-08dd6ab02e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 08:45:08.4009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stpsIkIcyR4jf7ZYePzDZyTngWi5XcX+t/PUXoALbb/CFeKXlCPikaLHLZkun1FLmJnXtl/hUAUYeUYbOnp3AulltJhQK4Y25LDS9RzkOMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7493
X-Proofpoint-ORIG-GUID: UADHJBiYJPKAKd2vVewS55JWyziFU76T
X-Proofpoint-GUID: UADHJBiYJPKAKd2vVewS55JWyziFU76T
X-Authority-Analysis: v=2.4 cv=P5g6hjAu c=1 sm=1 tr=0 ts=67e11b96 cx=c_pps a=l9lnEPKonMfu/vbXsUzXcw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=_ycENK7GZne0dzK1hUIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240063



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Thursday, March 20, 2025 5:10 PM
> To: Torreno, Alexis Czezar <AlexisCzezar.Torreno@analog.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> <broonie@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] regulator: adp5055: Add driver for adp5055
>=20
> [External]
>=20
> On Thu, Mar 20, 2025 at 02:53:55PM +0800, Alexis Czezar Torreno wrote:
> > +#define ADP5055_REG(_name, _id, _ch) \
> > +	ADP5055_REG_(_name, _id, _ch, &adp5055_ops)
> > +
> > +static struct regulator_desc adp5055_regulators[] =3D {
> > +	ADP5055_REG("DCDC0", 0, 0),
> > +	ADP5055_REG("DCDC1", 1, 1),
> > +	ADP5055_REG("DCDC2", 2, 2),
>=20
> Nodenames are lowercase, always.

Noted on this, will apply.=20
I based this on the act8865 driver, which seems to be a rare case
now that I look at the others

>=20
> > +};
> > +
> > +static const struct of_device_id adp5055_dt_ids[] =3D {
> > +	{ .compatible =3D "adi,adp5055"},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, adp5055_dt_ids);
> > +
> > +static int adp5055_probe(struct i2c_client *client) {
> > +	struct regulator_init_data *init_data;
> > +	struct device *dev =3D &client->dev;
> > +	struct adp5055 *adp5055;
> > +	int i, ret;
> > +
> > +	init_data =3D of_get_regulator_init_data(dev, client->dev.of_node,
> > +					       &adp5055_regulators[0]);
> > +	if (!init_data)
> > +		return -EINVAL;
> > +
> > +	adp5055 =3D devm_kzalloc(dev, sizeof(struct adp5055), GFP_KERNEL);
> > +	if (!adp5055)
> > +		return -ENOMEM;
> > +
> > +	adp5055->regmap =3D devm_regmap_init_i2c(client,
> &adp5055_regmap_config);
> > +	if (IS_ERR(adp5055->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(adp5055->regmap),
> "Failed to
> > +allocate reg map");
> > +
> > +	for (i =3D 0; i < ADP5055_NUM_CH; i++) {
> > +		const struct regulator_desc *desc;
> > +		struct regulator_config config =3D { };
> > +		struct regulator_dev *rdev;
> > +
>=20
> Where do you parse the 'reg' which you said is a channel number in the
> binding?

As stated in my [Patch v2 1/2] reply, I changed it from channel to regulato=
r (but I failed
to update the bindings completely)
The 'reg' is no more, I now use the name and id of regulator_desc to differ=
entiate

>=20
> > +		if (adp5055->tset =3D=3D 2600)
> > +			adp5055_regulators[i].ramp_delay_table =3D
> adp5055_enable_delay_vals_2_6;
> > +		else
> > +			adp5055_regulators[i].ramp_delay_table =3D
> > +adp5055_enable_delay_vals_20_8;
> > +
> > +		desc =3D &adp5055_regulators[i];
> > +
> > +		config.dev =3D dev;
> > +		config.driver_data =3D adp5055;
> > +		config.regmap =3D adp5055->regmap;
> > +		config.init_data =3D init_data;
> > +
> > +		if (adp5055->hw_en_array_gpios)
> > +			config.ena_gpiod =3D adp5055->hw_en_array_gpios-
> >desc[i];
>=20
> So a GPIO per node thus enable-gpios in each node.

Discussed in [Patch v2 1/2] reply

>=20
> Best regards,
> Krzysztof


