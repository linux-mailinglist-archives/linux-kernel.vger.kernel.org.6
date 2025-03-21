Return-Path: <linux-kernel+bounces-571508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58562A6BE1B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58BA189784A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987741DDA09;
	Fri, 21 Mar 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r8CSeBZG"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010006.outbound.protection.outlook.com [52.103.10.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C51DB551
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570204; cv=fail; b=uZOBMJ0pKo9Sfi4XvxN6p2pvqggWzrQi/R6vOmdhIAFkI4Q8811vAsBE61ulRLnx41jltyKt39ZCYjl51CQJDiQEuVl0IxLOr060k3ZLmS9Vjhmn38P44RTUi1+gSGQIWntR3oiyXymcbZ2Eydg5M+3sitH2BBF+TY7DvJzLBKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570204; c=relaxed/simple;
	bh=W8ZsXk+Ic+gwkHMCR7+9xQ/oRo9DUa+4bZYUj67tHm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S1JMpcJfWGziVXDCldQz+SP6VwbDzX2ZM/tlGSdfoAHdsz2ZYx2AC2o9KZd2mZCeT6+yHxNu+zu/VWtWa6pG1YYFw4ArrURMy0Zn67xlyZqtd84Oxro8aWGzRXy8PX6JPc3k49ubDYuroO4+NX03Auk0ySQSIODD8pPfXRUYG/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r8CSeBZG; arc=fail smtp.client-ip=52.103.10.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymew2Sv2vdEYpbdNiD9ynCjeANhsORuvp8mA2tldX1mQE7vdtwFaLeq7yEqZkw9oYPzkIUPKmX3QqB8xRM827IIH9mXVOqJieIFZut2B6v07jIBcE+6Fc1T9eNSu62TlSiQ0OwjuuJbMth+LuGT3ioxmvuAtCYNXOZfxlfxLgBqPoKXOHZvtYAban9FGSkjXSdkcR7zLhDE/B32jzXQPJb0Mta1oBc9vvGJOB40W3dCTeL4zkWKl4BW/obXph+zbgug/u6IgsI+G1yDtGMe9UFiWBSTRLzWCFdeZRjpFoyOtrBwCjwQJrNWhU646T1xvitzHsNQxUQ6dJUvyBSaUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Yu/wRmT+SLFRCuNb1cnPlmyjPAJFbQGWsZXWn2xqzY=;
 b=RVWAubTKCVBZ5TMfzcus3k9r3dJL9J9y2KfOuMGAmeWsgH8W2qtWB2MvFTGXi9I1wMJFXb2DCEb+cGE6iwUB1V+F7OW7tIU+BnDBeGogYrxHyiNZWC2nIhIf3WY+mZvkmBjUfFA71b+DOUqnyRlqspUeSUzUlu4XD2JAzIW+X3xq6vlhzbj1OIVhIroObwyU87V5z6VkjEL818psuWUb9GuT2EH/2PCr4PbRoJ7k1agcFrj4tUVwbEVQiJRKMuWHVJ/vw1okH5yQ7ZSgVlWT2NXiTKa+eFiym8pUqw0dWY1oUEc+LveK5CQ1v3xgL7lbqHbCKm18OwcLr6A6+nle1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Yu/wRmT+SLFRCuNb1cnPlmyjPAJFbQGWsZXWn2xqzY=;
 b=r8CSeBZGY/Cs+/FJXWn4HS+7hsuruTM7pMR20BJcktHn+/LEgizFIhiRj2BKbu8ZuUvWGTPwXZ69B0xzQZYvEnQBIvzIC9X3O97lWuM5UE2PUXg3NhfZc7DMDpPUh40Md9Us6IBVaR6RUmel5qn0xuhXpCCfZCqVKbobVRH0HenGiukZhvSpBW0Tc+YEBPMFvh5NIaXvX/qaZTKbrXtgLjN681MYaDXDFhrUw7sS9TyFPacmbMYCSzT8lw0NQK3DV228ZkjbHZLkagCuQ0Ybva3g8OwlkaAQeKZhkAQBYbX40uk0eWXptrP4p6G1fwgRZS/Xz9HNc2n1FIOvofj4Pw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6774.namprd02.prod.outlook.com (2603:10b6:610:a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 15:16:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 15:16:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Ingo Molnar <mingo@kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, "terrelln@fb.com" <terrelln@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>, "brgerst@gmail.com"
	<brgerst@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Compile problems w/gcc 9.4.0 in linux-next
Thread-Topic: Compile problems w/gcc 9.4.0 in linux-next
Thread-Index: AduZw3CVEeBLGArOR7mAlPxdXuU1qQACZlCAAALC4gAAArDlMAAUVscAAA/WCVA=
Date: Fri, 21 Mar 2025 15:16:40 +0000
Message-ID:
 <SN6PR02MB4157E2AC0708EB2074302E6FD4DB2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
 <SN6PR02MB415765C109AF9820DDC3AF0FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41575C4BA0C467B1C95EEB21D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z90XZqJVwuWkarnX@gmail.com>
In-Reply-To: <Z90XZqJVwuWkarnX@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6774:EE_
x-ms-office365-filtering-correlation-id: f569023b-ed06-4d7c-93f0-08dd688b61ae
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|15080799006|8062599003|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MGOZSCFz5ATpepL6gFzvCoaewO3qa5ei1pzW/YH+yj9ieXWR7EkUZtSKCOT6?=
 =?us-ascii?Q?KRUhQPiZbqV3PN1Om2HokqTFpoij92ZOC437qXjQkrlBrWx8M55sgOBV9+4U?=
 =?us-ascii?Q?h67z+p+1GqjAos/mzdxbA0YTep96Gj9F++czXkxNSbsBUlV9huo/BqTNev3d?=
 =?us-ascii?Q?UP6UF6B/VgQuA5gNWCFDCmQlsq0ACfIDLgKaAAMiSVyofg9HAaOOg+cQq/VN?=
 =?us-ascii?Q?WIwx+CnFUFOSlXx6hUF/4QgnnQrThRRlQMGNl+9RVTFhBcmvK9TwY8Z4zhfk?=
 =?us-ascii?Q?qFILX8zXIeAO/xchzQ/n/omEtlBIB2s+2fU06iDwOncnindMxK3kVlF4FcVn?=
 =?us-ascii?Q?RdhHX6gna787Ibc5KwdstixdDVaW627ANnxeukUwA4L8EQmy7dW6jgLBoedG?=
 =?us-ascii?Q?PbKqdLMSBmuKUq2e/XMQwPB3n6mLT6YPR7xPdGHNzJNJScIUXpj0UQtnb9wn?=
 =?us-ascii?Q?X1eqfmkwy3nUwbAfQkZSAPlHOryNQFfuiICg8rlYBoqnjjCd/1DmiSVVnTkv?=
 =?us-ascii?Q?WDrM1uJ+Hb/ijtYqn90fu+ytvY4q7JPIGaSG2xQnEvI5ARjjcX5qVpSmISry?=
 =?us-ascii?Q?191FDICBQP0Hj1l8BXyHESY/iaS2jLY/FwvEjOSHB6yp7PuEEuzHIgIXJbsm?=
 =?us-ascii?Q?5RsAZv+K54WOJ8FBDEH6HaAtCOHaSpJCtqMfoS9Coakr7BaYtbK4RjjQJ0KI?=
 =?us-ascii?Q?S8y9G+gOd3iaD9ALw1c9ao+ZR21snt67kPQDbPjT1i0E1ZAaStRnQUwmgwEe?=
 =?us-ascii?Q?/TB8Vy/MUd+8VOUdTepImS/JoJv1OaYmb0nk6DK3leA4t+HmV3/KZP1UZTA/?=
 =?us-ascii?Q?MfuVp7bav202FA/gb+fOnNdLaz3vOV21rcuFRRcjV5/tNZth5Lpu9P7m/hev?=
 =?us-ascii?Q?yBZVMol5CB8WXa+Cml0IeGLSt6q4+HgmbL3dmqk06roFFnFjKOEHsoC9illf?=
 =?us-ascii?Q?ybdx0c3yciKCYbwsh2+9M0DIwjb01+pw0+4VEcKbeP4s5fQvi+SY+T+sMz3L?=
 =?us-ascii?Q?3FB9DmKfLP3hR21yU840W2gl15HCx7DvtHxWU1d/h5NoRMeDMZZ2UQBKLVIj?=
 =?us-ascii?Q?hkZnoL5rxz1ekCF8jevgXti3TfblrQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HzOWAR6l23tCxQerWgF3AP34QeVXIDTno3njJvYxbVWzrPZHasMciZTFHKex?=
 =?us-ascii?Q?PdVlkqICAhQpnCGahZMWXEPpt0/npLd54ivXroICQ+6GM6p2w90VWcJxR5Xu?=
 =?us-ascii?Q?AgdcPhMSINLl6W3dL1KZ3Ny2kFglLGFozUsv7Gc6dyg4hUE517FaAWirOY9N?=
 =?us-ascii?Q?dDBVtaGCPxH/V9G4FDhs2h4QkA7VDHpn6fE76CLdhrMUbgo5OHgWt55dvzN2?=
 =?us-ascii?Q?jYc6asb4x8ByFl1R3vyT4w+INNQRbzbg8tumnxRh1G6x81dBodF1v8aiU/x1?=
 =?us-ascii?Q?/3pJtWwacAfM8wxNKPEtuOuhR3zLNlO6/bm7YMHP1IGpcEYs0e4VJmt3SPJQ?=
 =?us-ascii?Q?xSUy1bWgbLDxwOvtxNfAhWWYvDw8gRLdjEfVGS8zQl74gC3rciZ5oFJRt2s8?=
 =?us-ascii?Q?ZfbehCdQ03w8uuqyS+rgTEtlnGaopge1tbzY3cjWXNk7iSlY9bCLkIR2fNtB?=
 =?us-ascii?Q?QV7DEkDMBHxpwRHLeRyxdI6iU2LONEhce/TQQ+zaxDgg/gtnz2Mg4NP9wTxR?=
 =?us-ascii?Q?iIcLokSzDwPaiXTTcHSkq3+cDY86tsCiZwvHsRLEM5DUvqLbyKhIXiMfJ4Yg?=
 =?us-ascii?Q?DsfmXklBA3NFGYz4TxnAp/UTuNf/bagxLoUCqOgciReD2T6TggbJaMSM95Cz?=
 =?us-ascii?Q?JD0RUavnX2cSL2FhCy+xmkkwz7qz7VJvNa/hT1Sd0fkZwsW9Gh04E71+NpvK?=
 =?us-ascii?Q?b3SYO/M0DtdDYj1UzQ4D+/bP1Zr+P2dmrsIcy/0GBA086v20FP/aG+jDZtaL?=
 =?us-ascii?Q?+kW3G4S6XrjqUfFe3wP+BfXOfQ2WSVC7xz2L/JKwclQp1nvXYHSXHIIVyCs2?=
 =?us-ascii?Q?CZJWjjMpejoCXtl4yqAe2Mf/s9J0jaAUUPZZ6VRi0my5sdLEfXAwmwIifok8?=
 =?us-ascii?Q?yJ5BuEN/w/4w6lUyOKZWMs+D8jcrSPraw2zlEboBFve4kh/tylf7RW/SGe4B?=
 =?us-ascii?Q?HS0ukTPMmqkbVICi/UhIgPkUSCLszHzYtd5GmdC9d8/M4XnvnepAX0aDwlwQ?=
 =?us-ascii?Q?K48XT6S90wSuj8ZLWnPHlspNXc6tAyeSw+eoY1GkGgyevLZpYo7p8cmrQ7a4?=
 =?us-ascii?Q?n2elFXV4kl4zlgWVkjZUpWsNHxocVJszIQ0tVr9DDY0fB0ayxggKcYPgwDbI?=
 =?us-ascii?Q?Iehk7ElCUdV0G7v5ZFNINnVo4WFHwWJnf/otjkR8Lh2p/2mmQt/lmeKz5bgr?=
 =?us-ascii?Q?tld+iwH4K1tnOh6GFbo9DpovqNfWYLt//lgrZLAePipdGTA5uqoIul3k+Eg?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f569023b-ed06-4d7c-93f0-08dd688b61ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 15:16:40.4727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6774

From: Ingo Molnar <mingo@kernel.org> Sent: Friday, March 21, 2025 12:38 AM
>=20
> * Michael Kelley <mhklinux@outlook.com> wrote:
>=20
> > > What are your thoughts as maintainers of lib/zstd?
> >
> > FYI, the same segfault occurs with gcc 10.5. The problem is fixed
> > in gcc 11.4.
>=20
> So the patch below would work this around on GCC9 and GCC10?

I've confirmed that the patch gives a clean compile with gcc 9.4.

Note that I confirmed yesterday that the gcc problem is fixed with
11.4. I don't know about earlier gcc 11 minor versions. Lemme see
if I can get the original gcc 11 release and try that to confirm that
your patch has the right version cutoff.

Michael =20

>=20
> Thanks,
>=20
> 	Ingo
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
>  lib/zstd/common/portability_macros.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/zstd/common/portability_macros.h b/lib/zstd/common/porta=
bility_macros.h
> index 0e3b2c0a527d..0dde8bf56595 100644
> --- a/lib/zstd/common/portability_macros.h
> +++ b/lib/zstd/common/portability_macros.h
> @@ -55,7 +55,7 @@
>  #ifndef DYNAMIC_BMI2
>    #if ((defined(__clang__) && __has_attribute(__target__)) \
>        || (defined(__GNUC__) \
> -          && (__GNUC__ >=3D 5 || (__GNUC__ =3D=3D 4 && __GNUC_MINOR__ >=
=3D 8)))) \
> +          && (__GNUC__ >=3D 11))) \
>        && (defined(__x86_64__) || defined(_M_X64)) \
>        && !defined(__BMI2__)
>    #  define DYNAMIC_BMI2 1


