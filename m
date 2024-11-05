Return-Path: <linux-kernel+bounces-396105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8569BC7E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FBE1B2364E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADB01CCB44;
	Tue,  5 Nov 2024 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="FZvso0oZ"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2119.outbound.protection.outlook.com [40.107.215.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16441CCEE7;
	Tue,  5 Nov 2024 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794619; cv=fail; b=Z3LMpvg7r8yYpJa0wzgxMxBQiNtUIUOXLWzPiQd4blnaE215KqgZRaeaHnWYLHw5hlqjgJroMJ/fR858Xx7N6m8hijJhG7Fx8r9cmd0pHbUZC1M4LT/txJRW6xEk21oJ021SULeEuujLn7ILVwEMrIBFJY47NFGBzJ85z1YOJ7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794619; c=relaxed/simple;
	bh=7xzSjMQeeOib+T5/xCDyyA+9Z4EKmGIhPimTXzgoR7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ODR6GPdut9zuGMRpPRVeW2sbRrsz/Pgtl6jzuKkMr6w9O7nUB8wltn5zGoyGyL+d+/2iru10mJoqM+rUy3iNewkPwfCSO7aWPiJkKtiDsBq24NpfcT3WJWAIvRenl1K+H2XN8u3b3OS449C8ASkyn0s/wo3pC+xz5av+iKbZ/Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=FZvso0oZ; arc=fail smtp.client-ip=40.107.215.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chYhhv8/llleqmv4UcJJJ3TAYwUcYKSA7xN3PvQi9L0D5MSYWA862oXHx1SjdyagY2fSToDzOrpPmA63KdOSzyr98+0MnzFvy82+25dCNKKh4kEie8UxWOPp6oJIRnJe9TSV43/e+p6osFLd849bljroT1ghOQBuq2ldDLMtRfnmQ25ok7PPA/ZYqOfXHpyilWemO0M5pZU97jo53ZZlcMkBm7nxtOVjNMzCd2NEgCwR/1CMBf1RkdAxZP227pJT6TV3A5QOvTYBBpX6Oew0rif4b61rGG3FmfXbCh1lBsku7sJRmwe8LhfP5ZuGOycHfKx9ZuNqoAYF8fNGMx2u6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygGiAEUn7d1Jr7i0poiW5FUpO73Vr/Jzxdj9ZphWQ54=;
 b=YO3UtPnsMsb5bqsjRMFdz0ZqpPyqBq7qowORLqK4cjQcZZiqOo8WE+ZCMergsuVpg/lDL9WmGEkGSxemFcbNe3FcycZkToTXiUvAudw3n7KCKMwFLBPPJnMyncvvz7pV4PMorVCih9whFiATm2HxfJUA2xJk5/CgNr6FVNfzORreJShD8l2b05+QpuvrUk9DUsAnPRYhjKkxOIB2SJcpH1iY5LsNInnL3puf7XZJy8YjWNCqb0CkmBRAowiqcHr2gwOvqpS6nP1QUzfZDCX0l+wHCLsfW8qmRZkoaNlL3reJAkOZUInIHhMiUfe2r2FHpVII3iaxvAiylDgrSJ428Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygGiAEUn7d1Jr7i0poiW5FUpO73Vr/Jzxdj9ZphWQ54=;
 b=FZvso0oZZAPHAp8WTVj9Yz6C62+JM8jKMZNZ+XnxjUM00yn4HAGcAod0K5smerbdHVft7/qUfmHpn0tymBHb116vQg54ZfngWido4FMBQGRfcTg3OvfAG6/YCDVUsijlO5zYKMqoyKvGOacZYWn9kEkz8mXnRpVNCSAtQ+1BLlvwQx2Wr9pfJ6XN/sBo26VYV4ym5hyYmjSm5gh6rv33nhG/DSHGaSqoo/r5mzQTryrm0vQ8yhL/CGunQUtZmQynig7osFVSGRfw19bXMIcwy8bh8uqO7hFTZ5H2vhX5bDj++vLcvSnlhR7EXni2YGM/euQ7Ie8zls7o6DHAEUYBew==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by TYZPR06MB7335.apcprd06.prod.outlook.com (2603:1096:405:a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17; Tue, 5 Nov
 2024 08:16:51 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448%4]) with mapi id 15.20.8137.013; Tue, 5 Nov 2024
 08:16:50 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Akinobu Mita
	<akinobu.mita@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: pwm-fan: add
 retain-state-shutdown property
Thread-Topic: [PATCH v2 2/2] dt-bindings: hwmon: pwm-fan: add
 retain-state-shutdown property
Thread-Index:
 AQHbJ33nzUvUzWmfmEOHL30M1fRtN7KbEXGAgAENKgCAABwRgIAACcyAgAMqcoCAAARkAIAHU3zYgABI0QCAAUijhQ==
Date: Tue, 5 Nov 2024 08:16:50 +0000
Message-ID:
 <OSQPR06MB725265027B4038A1CD3B51468B522@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
 <20241026080535.444903-3-akinobu.mita@gmail.com>
 <ijdk5uuurnfd2shnwwj2nm64bno6lmrhdyqp42pzjc3i2e5cyh@v5ljkrsgo6ac>
 <CAC5umyitFp7oGR-eYXMVaS8bY1AGe3QwEuSPoEz3DxWwH=dUsA@mail.gmail.com>
 <e29e2c9e-60c1-4f32-ab71-e74f331e1921@kernel.org>
 <CAC5umyhCw+62Y+h3Jvh3=0Ocs8XJsSu_vaiPpO_g=65Jo4vUFg@mail.gmail.com>
 <e4985609-0642-4ff4-b074-8c5a34f88a24@kernel.org>
 <CAC5umyhrNCA4BHqC_k_tSaSOANcvP_vt485650xtFTPwJ+6snQ@mail.gmail.com>
 <OSQPR06MB72525057883A59578441E0988B512@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <62e24ed4-3579-46ff-a77a-c5733125012c@kernel.org>
In-Reply-To: <62e24ed4-3579-46ff-a77a-c5733125012c@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|TYZPR06MB7335:EE_
x-ms-office365-filtering-correlation-id: d1f0a3fb-20e4-4e52-4a55-08dcfd72334d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?dD7frh7yxd4FR6fSKTjV2reVjOf5ZaICYdIUENX2RVpk2GjeeT8VxoeS8c?=
 =?iso-8859-1?Q?TYklsrMR8lir1YaSKE1ZEx2BpU6zf5jJuDylk+fXqhU4XDZgBptBxSrYka?=
 =?iso-8859-1?Q?8TZKpAf0zGG5lx3Md6KmVlBleLg9qRws1eG16R9jY5MEYCJMOXTJr2BVKz?=
 =?iso-8859-1?Q?1EbPfHyLR9QKtIUcXXa393oBlqraWzKI+eqKQdFWX7QSkM6EffaGe+Rks1?=
 =?iso-8859-1?Q?iVOr8yda5sVHwyPslas0Lpp8YqhSxpeF1TaTHiQkcnScS7E4sc+yJiqcQ/?=
 =?iso-8859-1?Q?rv0E9xJMR31e1z0/9mocrSjq/9F+6JJufbW+z4Kh537eDKifJ5zuon+qka?=
 =?iso-8859-1?Q?lFnkIcfL2RpLYN1PpCUOmra9hQ4k5BuZKiIULyUm9NzX+kNnfxoWXpSB0J?=
 =?iso-8859-1?Q?NCCqSN+WX0ZUUQztY7TmiH7q1O6shOcSHQ+WFAxhrA4M+pRjDg0hdPSRPG?=
 =?iso-8859-1?Q?l4ERjsNyJFKfV9rLCOcvddmmPtu2vNClNe6pdzU6Zf1Kg8Z+jMcLAg3EmO?=
 =?iso-8859-1?Q?DECxK04FV5JzxIN4/OxpN554rg9j9F8qBFRuyC08eY6yNlJhv7q9wYGeRc?=
 =?iso-8859-1?Q?51ucEK1WLPbupUE/aeJZxUrJNnZoLhyn78KS4Yu1PGU8My9cYnRt7BR1Z8?=
 =?iso-8859-1?Q?TPLZRuSqX1IWEZXcQXbJhXaW+OvNLCEpnaObGuaU894+f3UMJwlF9xqJRD?=
 =?iso-8859-1?Q?V6HoWW3khuLMXSE1tyYFfrDIWWFgXNnhfmIHI8ZxLlvGijdxjm6UNJeqL+?=
 =?iso-8859-1?Q?A6lvGdoR0Eu01OVn/EMIFgKgBwZiBqfFLUkN95uHzBI8ClOVMolhwdNJRD?=
 =?iso-8859-1?Q?530BUu7+lY/R1ppwkp9s/ZLgROcFnXOpJ3z2WLrDFw9WUdX0fEK+wNW/f3?=
 =?iso-8859-1?Q?SXL1OwZVyprEmtikKdb490+9KrLeFVGYtCS3fNMC8osBuwZisihopAGes9?=
 =?iso-8859-1?Q?NpNlGJS4KaLTuAkkgP2qCAvPwKXn2nULaKYA1+B1R6qeDUL27Euy6bWGUW?=
 =?iso-8859-1?Q?KFLr32RLBJcIIpYrpMFnECi8pBTLC0OvIsocfxYWOTgBLBoCLZMIS26GhU?=
 =?iso-8859-1?Q?X2wdJKWKZzAQcPMLmcFYT+bg/Ruw6aPxz+Rfv3/r4naZfHqaxV4GF3iO9X?=
 =?iso-8859-1?Q?1lFV73oJaRjdBpwTPM7AW7UzsfLNYjhsS6UqD5VmHsuZoIWY1EcYJWMU4A?=
 =?iso-8859-1?Q?ye7ATfbfFeabkXWRvXq4kyoRgGvVgrGRJykKmCNL2NSBMmRkwMmDYkJC89?=
 =?iso-8859-1?Q?+dqWmrV4kkb8aVzLzVYjsqHkPsDSxvtrM4K3ZjXgwAS2DTsuCFwdq8VWEb?=
 =?iso-8859-1?Q?GEfVoH2K9WAShf4K6PanJmETRQM8SrGi7r9yjxgnD/Y67BcCfV9Y/EsvM0?=
 =?iso-8859-1?Q?Qf8z8xZUcSqK/fY7e/4N4/mPpndJazYQWsSp0qeQ//iKbi2QF8eoQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pt1dKy7qn64+H+jq/hHbw+kh7mxVT1XSMrgreeReg++gExrp1uDTxaG/8s?=
 =?iso-8859-1?Q?VwMuIRY/rK8fo4An7dJA+zwLk3bprECwAW2b4doXdvwHxO7ruNsu03iedu?=
 =?iso-8859-1?Q?37KNWF8FxBUuSRCTKieLTJhKH9qneZDOEB8eZmVStjqj9CAB+GTPswBb/N?=
 =?iso-8859-1?Q?5hIMNP+AIdIQDMqC/bp6xKM/VehOL/d/iWJJq1HE/mnzoQZ20vJYiJPi6y?=
 =?iso-8859-1?Q?LD9e/fmCSnX3rW9KYiabmD2arU43mQGrgb5GyPnXTDcZ5+rZZJmaO3BDks?=
 =?iso-8859-1?Q?Ccg5tVctdLApIa1sgpSs1MbLo+ztmwV28SDTnNs19RufWg5hRdS/eBUDa1?=
 =?iso-8859-1?Q?bM9OONscl+VxoBZQ0AMmpsZ3USfNC9rIqnWXp2dv4GFf2j5lZOtW5Enqu2?=
 =?iso-8859-1?Q?kyJNGpcpXtCLzswhRIGFmFU9X11XpOr6JNQzaTwX2O8y60Ua4vdCsPo2UP?=
 =?iso-8859-1?Q?3mxIWZUEFr+TeyG5sxTimUfcniTjU/plL+oz6mCgonEk5+f/G0ocUdE1q4?=
 =?iso-8859-1?Q?gQXCWqZl9v3ScQJ3c5DcCpznyKiwPjBL4RHSnByJeaqnHtAo86tLUVY7SW?=
 =?iso-8859-1?Q?7WI626gzFdvJ4bwOmeF4MVMEKCs8M0+hSXny9qFJClPXaBO2CtM8fhJzLX?=
 =?iso-8859-1?Q?8lksPWH+3fEdC3O66pD+4ciIQNrfhzVmkGzy6rZyNnSIrWkOYRWgIpURhI?=
 =?iso-8859-1?Q?SgmcfaVuIpit34nJ49VC4727OZJWChWHJjx9jgp3c9gjXMeLD7QiZUoJTF?=
 =?iso-8859-1?Q?QDZhfsSBDbxIlWJ/ONm4l0eXj/SrF+qAt9P880bMUcs9u2HUR0Jm1etzyB?=
 =?iso-8859-1?Q?t/gY6aNvvpa6H+kT5LfaLquaZAUFyT/BzcQHRq8bKZH3a7QwNznYE2EMc+?=
 =?iso-8859-1?Q?j+7x8rc6Zfe8YEZzrQQXDm0PZ6Zve+D7iaO3eG7+6vyVM7RfXI8OKzarLY?=
 =?iso-8859-1?Q?opp4l7lr3ra50WEPYGyr39lRv/FWwjBSGQyhd4liu7WVjAnC10MwBsUgK8?=
 =?iso-8859-1?Q?W1BV3W4j5EYfwkJRf8Ut+QkBtRYiiSCDFSk3+hPkVtt47aKUeYkXskOgbc?=
 =?iso-8859-1?Q?ZbxjWvXYcE2/bBegBQgHzkW5qTYTe9e5T4PbVeDeZVYQwNtSX3H36Li6Wv?=
 =?iso-8859-1?Q?CJ8GzWt7v77LUnTnzfl49z/P/PRtD5xHbeU/lAKtJYYkw6TVuAlH7N7YE2?=
 =?iso-8859-1?Q?okWMldI6xOmXvTKaU9Sc8V2Lpv+g66Dzn/ibNgGi2sl6GxNrY6ik1iUJSN?=
 =?iso-8859-1?Q?DsX4WGQnW7giyC6fxY0JWXSMvge9yKDZjPyQKrpHs86I9/v2sljpJmG7EV?=
 =?iso-8859-1?Q?nqX8Y1cZSjQVhB/zDZSp+Z/jSLz2PKTuhEjdJ2RBGVC6eF++uzcAkGIS1N?=
 =?iso-8859-1?Q?Nhg0I4jxAfL2u/gMpTWHqR9fFb/c0b1QRkrMFVlQMJyM5ZnEXDXuqEhbKI?=
 =?iso-8859-1?Q?UVoy84XQFC5OyjBtr0YmbGgzu5gQnIaFd8qCC6bpZT/YGToQ8y7DJ0LoN8?=
 =?iso-8859-1?Q?O1/5XygHHWY3DQHP8KmSvuEG8UJ6OttEYfz+6ISGAJ9kpRkFD0qRx2bz4k?=
 =?iso-8859-1?Q?5Zm8y7Ru9uoa4InAkisoZZRPoaYeQ73HCZi9GXadZRtvYCyEZmUIY+RDRh?=
 =?iso-8859-1?Q?vUMl+mJb1/AIvs7lO5OmuIxLCeCMdbDF5W?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f0a3fb-20e4-4e52-4a55-08dcfd72334d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 08:16:50.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYZ7y9XX8vVSZ2FkkSxcABKIZX5yqsTUUEpnNIk2Qyej4tXUFc0WWp79LJOD7ZAibLAVGDJ03prOHrzDfuwEg0M5Gj+guJr50WGObrKvNws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7335

> >>>=0A=
> >>> On 28/10/2024 15:57, Akinobu Mita wrote:=0A=
> >>>>>>>=0A=
> >>>>>>> You described the desired Linux feature or behavior, not the actu=
al=0A=
> >>>>>>> hardware. The bindings are about the latter, so instead you need =
to=0A=
> >>>>>>> rephrase the property and its description to match actual hardwar=
e=0A=
> >>>>>>> capabilities/features/configuration etc.=0A=
> >>>>>>=0A=
> >>>>>> Is this description okay?=0A=
> >>>>>> (Reused the description of retain-state-shutdown in leds-gpio.yaml=
)=0A=
> >>>>>>=0A=
> >>>>>> description:=0A=
> >>>>>>   Retain the state of the PWM on shutdown. Useful in BMC systems, =
for=0A=
> >>>>>>   example, when the BMC is rebooted while the host remains up, the=
 fan=0A=
> >>>>>>   will not stop.=0A=
> >>>>>=0A=
> >>>>> Nothing improved in the property. You still say what the system sho=
uld=0A=
> >>>>> do. This is user-space choice, not DT.=0A=
> >>>>=0A=
> >>>> It seems better to implement it as a device attribute.=0A=
> >>>=0A=
> >>> I don't know about that. To repeat: if you say what system is suppose=
d=0A=
> >>> to be doing, it is a policy. Describe the hardware and its configurat=
ion=0A=
> >>> and maybe this would be suitable for DT.=0A=
> >=0A=
> >> Billy, could you please write a proper description for this property?=
=0A=
> >> I'm not the right person for this.=0A=
> >=0A=
> > In our hardware, if the system reboots and power remains on the PWM con=
troller=0A=
> > will retain its original settings. However, the pwm-fan.c driver curren=
tly disables=0A=
> > the PWM controller during a system reboot. I need this property to prev=
ent pwm-fan.c=0A=
=0A=
> If we change the PWM core not to disable it, then we have to change=0A=
> bindings?=0A=
=0A=
If the pwm-fan.c driver doesn't disable the PWM controller, we don't need t=
o add this property.=0A=
=0A=
> How is this binding applicable on system (e.g. on *BSD) which does not=0A=
> disable PWM on reboot?=0A=
=0A=
That's why we need this property?=0A=
=0A=
> > from disabling the PWM when the system reboots.=0A=
> > In my point of view, the description can be:=0A=
> > Retain the state of the PWM on shutdown. Some platforms (e.g., BMC) wil=
l maintain=0A=
> > the PWM status after the system reboot. Add this property to prevent th=
e PWM from being=0A=
> > disabled during the system reboot.=0A=
=0A=
> You again describe what OS should do. First and last sentences are the sa=
me.=0A=
=0A=
> Probably what you want to say is that fan is some critical component=0A=
> which should not be turned off or left unattended. Or that this hardware=
=0A=
> keeps last state of register on reset, so some boards might want to use=
=0A=
> it? If the first, then probably different property name. If the second,=
=0A=
> current seems fine, just choose some description describing actual hardwa=
re.=0A=
=0A=
I think it will be the second one. Is it okay to change the description to =
the following?=0A=
Retain the state of the PWM on shutdown. Some platforms (e.g., BMC) require=
 the PWM to maintain=0A=
its last register status on system reboot. Add this property to prevent the=
 PWM from being disabled=0A=
during system reboot.=0A=
=0A=
Thanks=0A=
=0A=
Billy Tsai=

