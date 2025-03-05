Return-Path: <linux-kernel+bounces-547693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB8A50C71
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D19170DBD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410F425524D;
	Wed,  5 Mar 2025 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="Q30ZMAOD"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503817B50B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206370; cv=fail; b=IGG3nI+c0F79WBCheFz4ZH2sppmBWshi9Pxk1pXoeuDDOjj11dg5WcjJBMe1jJvo7BvPCskJcqnJp+va3697w4D715YiZwN/PbrH443BAXDo39f+r2Nex6Uu/p3faDsQviTMsVhz9WurNUWUuo4CrnooGV6h5I6vicM83Jm8aM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206370; c=relaxed/simple;
	bh=0dVE7V4CyCJR+0uWLA3Elytho3TwVRrsHKYeJjMwNyE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C7zSvmGXU/Km5fUaPxLWd1zoZSoNjmwwCG4kO4bziliYIp8Y3KXgxakkrpbvATVMhAu/s1pqhGlKVkb35pPC/n0848Pwhh/UZURACRmitqpcHJsjhR6Z/ASE9yop2HQkDirBCkNFeLVrXe0h7YHgId4z8nDiXzb1qU9h4l0f4Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=Q30ZMAOD; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ovl7okT3SJeAO/R/mic2xwVDp9BCc00LxL7rZU5mMkNgsngDLkPgfL71kujEpzOAiAhcvq8cN20xH2QQJ9abjgbasv5TixGaDXpB+V6YQnrXc+RIjXPQKW8L5OuawrOAe3+iAMUGyvePUh3DzjicylBO5BfhhvQ3WrZ52nznBlr9pF4y99Go3L0ij48iGBC1s3PNg1NQ1INqQcPyYUUmKl4hpiIF9rEWWRFdB6hx7NcZXBg7jYVIYh6b0tG25SEaWJw5TqpwGsSf6IWwIe3G3l2KtaCdqOh+9BrM4/mxE4kRZI3xihQchSQgnU3EZZLZ9iyOhIQmwE0K3IBKkhHwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CHq4JqxWtw05a62eY3vef8upM75/XYJ2bBZG1WTDu8=;
 b=kpa3SqoO4TGyEpqUrSmzRdMD/AcidF6gEo4N1SaxxqairA3bCHQnHvtYbuUKQC6Va7HI+bmBmJ1665HQQr5z0zZMUp4q7DhZpYVFmGxQsFToAABz0Kl9e7xHmNiKZnh7bM5Xcac6Gmz0tI9sIY2Jt+cLVlR4WLTwyKV3dpx2+HS3nf5vURzF9p2x6A3ey7HLij3MFG3KEy3df/dtIcIV/ciPE4Gh3p/fjHaZfvZ0kP1b3zCEC6qQgMIDKrZ/ACYo598tIb8/n2xTTGzppdQEQZKiK8jT1SV3fp6KYcCn/zNjmOkg/RRIxuTyqe5WAsrDQiAgWrF+ri9RNbdtXoAchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CHq4JqxWtw05a62eY3vef8upM75/XYJ2bBZG1WTDu8=;
 b=Q30ZMAODIcosj4/Y0vvK/qfn25dX9AFbJl0N3Rbws6FRVW4iiM5DitLY6aTdF297XTKJuCOxAMDzfY12xdqjiywg98VZP6jwMTRCF80QfRp0GBkQRBlbZ18/+XrLv3pDr4nQKR1T8qQmBrxGQB3fGFFmLX7Ko8YVXDYweguW8A0=
Received: from SJ2PR19MB8094.namprd19.prod.outlook.com (2603:10b6:a03:536::15)
 by PH0PR19MB7480.namprd19.prod.outlook.com (2603:10b6:510:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 20:25:56 +0000
Received: from SJ2PR19MB8094.namprd19.prod.outlook.com
 ([fe80::179d:230e:aab9:ec3a]) by SJ2PR19MB8094.namprd19.prod.outlook.com
 ([fe80::179d:230e:aab9:ec3a%5]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 20:25:55 +0000
From: Kit Chow <kchow@maxlinear.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: pci_p2pdma_add_resource of bar memory rejected by memory hotplug as
 out of range
Thread-Topic: pci_p2pdma_add_resource of bar memory rejected by memory hotplug
 as out of range
Thread-Index: AQHbjghVdFcw5+9Z1U6qqHaQNfy9rw==
Date: Wed, 5 Mar 2025 20:25:55 +0000
Message-ID:
 <SJ2PR19MB8094482894628FF87E806CC8A4CB2@SJ2PR19MB8094.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR19MB8094:EE_|PH0PR19MB7480:EE_
x-ms-office365-filtering-correlation-id: 6e5c3f4f-45be-4d1d-642e-08dd5c23eeb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?wx32MSU7mm9MGl7OAspp/WS2oTdDaBfyRFpT55HOly6bAP6IM4UIfMWyVD?=
 =?iso-8859-1?Q?ZPhu9f7SFcLnxIRcr0ZrAaNTNMpaU8sfTlImZu0+K6xEhB/MDbYUsnfKcD?=
 =?iso-8859-1?Q?AlOarSzRpOqwHZhhM9kUIHXTTOfk4oPPhAZtUC+pUyvpA+oHYjVS1q8Zu2?=
 =?iso-8859-1?Q?TS6+mgSzQiVa1DmjkkhiC0Zkabb5uo6OtzOsy8w0IKbtXZiRNsGCEWzAYS?=
 =?iso-8859-1?Q?ePYr/8YZn+NhjCb2NyI7KYbSn6U0jkle30dvDXqA110bCJxkUG4Ls7Kzfu?=
 =?iso-8859-1?Q?P1mI27IuZzoURPwCGsE1jQ2RLIFbrPetbvgGw7s0yCUwhU3GGB2B91Av5m?=
 =?iso-8859-1?Q?gITjr027fLXB4biTovghKjbn6rpDUArslIfasR+76yjGO3qxJBkWq/2qoU?=
 =?iso-8859-1?Q?ofDQuNUuOFFkRgz75hSSiIQFjAbAH3HFXcsQHpEBXdIo04tROen2zAPpwe?=
 =?iso-8859-1?Q?codRr9Q+FfKPArn+elx8BusWkVrRzdeliTrLmBsHXHY/vk0KLXF2F2Up0d?=
 =?iso-8859-1?Q?t8bhLDvhWyKPwp6PIN/fmoX8W4wbpy5KdZ8+F/HfXOGIc9dUL24GORI7Xr?=
 =?iso-8859-1?Q?7Ybf3xiZ+hPJ2VtZ+N004Ra5krIlndZItKmweSxSHxmbgcWDI4laQrICuZ?=
 =?iso-8859-1?Q?lUfecpI7wcn61ed59HMWbFFHLRrfw7xUKa8uvGXZfBD3lowQ3cqHfZL9g6?=
 =?iso-8859-1?Q?4BCErrPpHrVCITR81NNVoV4IjWpzJazX5R8gXN4LrUopIlVWkI1OLSh1fZ?=
 =?iso-8859-1?Q?F+uByKt1M9hq1dRjQqU3a7zJS46Txl4oQ08JF95D+FKDSAYvb2WG2niefQ?=
 =?iso-8859-1?Q?HUt6n10nAa6EX5DDR18fmLrmV0AJVgrOwZmLAd5tLVJK6J0uLfIeCym8RK?=
 =?iso-8859-1?Q?hmyj2Oha+fqw9NWuwbrNWAujA9aC0lVCc3mWL1VkRBw3x5/KIrt4F8JsjC?=
 =?iso-8859-1?Q?nm7v0LiRe+/HPFx5BUgtEfVM8VnoD7RffoCUVN79hV/GjRYeBugw3Q/eky?=
 =?iso-8859-1?Q?PrWiwM7aPsCl97tBZQayN+UORhWmLgqAg/emshMdLHJuTOnWr+81mm4ZEF?=
 =?iso-8859-1?Q?3iY1bPjsdgL/s8ki/XL95LWuVmqBWDkbZ0/FKPzvLf8VeFRkzLkykw8iN2?=
 =?iso-8859-1?Q?M4hWkB17ugJtKycyC/zFBYdBG64xV3w4HWL1tA5Zz6kX9ll82yikoiKogR?=
 =?iso-8859-1?Q?R0bNTVE6ZVRGGMcQKElYplkKvCf/JzasFJzSa6HyPihTmj25sdKoY7jG0G?=
 =?iso-8859-1?Q?oznSm+tw4BU6vSvMdEnyZbTFlzCu6gCVzXeyttGQay/v+/WjfKopkVV0em?=
 =?iso-8859-1?Q?YhsPusKIF+2Ifm1y0cpr4FBT/ueLVB0Cf3YKSglWVWQXhlmCOYjCI26Jbt?=
 =?iso-8859-1?Q?vyXLRfgqc6msUOsrePbwYAh8bX0887TJhbGHPQFtx9NPJosox5gwU2EbxV?=
 =?iso-8859-1?Q?sqr9MLG4BF6gaJcIcLArrcmw2XpPSJm1AOA7J0pytXxgIymhFDsQHxWLhO?=
 =?iso-8859-1?Q?Np08l7y4OO/DJ4LxgsUS47?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR19MB8094.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?g98cZn+BY1ke2ZnLd8bJTFwhtLgmYuo5zv/azsdHdj7u0UeMP5dwRtqKNo?=
 =?iso-8859-1?Q?aLliYb1a1Dz/WvFRiJtgolw8aZBkhfocW7hu8Erjwqcwy7Msg2vrnLOqF1?=
 =?iso-8859-1?Q?KnTYKdwPgHk0/Ty5R6j3zmz14i6tyWPbHhWNmEGCT0ui2YAXOW7edzYY66?=
 =?iso-8859-1?Q?1UuLhLjkzUrKzeEbD7U/htvEPvaCwPzRzIyTzAEDasKy8+LYfLOeqVQ30v?=
 =?iso-8859-1?Q?gUa5crRpbv74aeCq/TJDb83PWeY4zs0UyXtqYsnq3Qll+YTQIm49ORT9ci?=
 =?iso-8859-1?Q?RxxIx+D6cYVJR/b7vw5fzY4U5xeaSizbFIpEs4vw3tL9KTJk5eq/btdTU1?=
 =?iso-8859-1?Q?lwi63etF4LZf3uiNgT5eU8/H98dF3i6BQIm2Jn7z6M2dhicuPCwS2swq4O?=
 =?iso-8859-1?Q?mhbDI319Q8YJfCYf7g7A7NYF1T63HQBuVBU6JnzufX7vEfCp34BVGwnudr?=
 =?iso-8859-1?Q?9cRhZuS3Gtm9raKAK613Xoc4f3gukRxRaB4S57xpa3yWh0t18Y9aqJfkd0?=
 =?iso-8859-1?Q?WWFeQGfJ3gi+XAR6I0CWojBUyE4eZnGPueuh/l5Qny0f6dfY/XgG2Ybpnw?=
 =?iso-8859-1?Q?ZSNj08NbWoryBpVWsjc9StaBM98RfqzM0/+jrk8uub/AHceHSZs5lV3cji?=
 =?iso-8859-1?Q?ckive4DtHnGAlauJSLvpYXLvSKjrwGS0MCjVG4jktHvjIopnfiH7d6UgGF?=
 =?iso-8859-1?Q?eYqqNRSL1CI6/hX4r2HAEBfMnWEiFtoN79i9fOFyJCTWufsxVB1nCtdYPZ?=
 =?iso-8859-1?Q?heU5iuoD7fEW28lb1kjisJXz0kuO/ScrHmveT+53sz0Wjmu7DoPnR5KP8Z?=
 =?iso-8859-1?Q?3S0pR8b9ys0TaGxgbjk6ToY+NM76UVZIThCNZdgtSS3duVEq6qBiVlq2C2?=
 =?iso-8859-1?Q?GGE1IvGLLV6BHtkReJaBEu297ZJklLWYAgGaZFs2MJUSKckEh0w23U0VgY?=
 =?iso-8859-1?Q?ATdpn45d9XTDOcqvX7bpiyfAjGPS4K9t1BZuPruUdwwpsah+E+qMYBqag9?=
 =?iso-8859-1?Q?rCsZAfqqqKJ/YSVgFnhyMNzMnIWVbiFIf6AsOkdCUHMClCQD8GqsWNBa7b?=
 =?iso-8859-1?Q?4qP5amJFRntslVSSUEGn11t2Esmx6T3xeO+IQ4EQpiZG+BJ3PHU00Z4evW?=
 =?iso-8859-1?Q?qNOmHAm/fKvWKKXcvyzQUCG3NvAgF7b0QpdFy5j6jX8gHzVAlQaCym+lcn?=
 =?iso-8859-1?Q?T4+LQy04GxkSzLnkVPNeRPQavakx9U2qa2VTlwM7oodh8Ro6WTs/KxsQei?=
 =?iso-8859-1?Q?vfOowex2dTixtAgSdkh2BtsIUF3fzluaOmbZFCwAOoH1GTH8YGhccGLJWt?=
 =?iso-8859-1?Q?AQMrDgp0a7th342kvJ2z/E/exmH6w4VXkAhyCrp7V8L5MLJZWJ78i1W4LB?=
 =?iso-8859-1?Q?ombfsP+5CtF71imBP4nyB8sW0w+uSrbGmvOstD1a/chaKxrDsraNpwFBA/?=
 =?iso-8859-1?Q?GGw8OvwHrgflHthzTHfhvO2eJaKjfZP9FLdn4WI7szUEHaXj+2zvawFgnJ?=
 =?iso-8859-1?Q?FVHQ8Z3NwcAaJxmN2wmTlvj3dZtUHsp+DuXmFK27RmLloihc+U0LI2Cuax?=
 =?iso-8859-1?Q?KQaokGhIUmS/+a/n//s9prHGLVGtXqEQ8ygQLyCmMTz4uQ44aI8yd6dkeO?=
 =?iso-8859-1?Q?KvlOcIs3WVB4nHTxqBBAVy/cq3jtb1IPV9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR19MB8094.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5c3f4f-45be-4d1d-642e-08dd5c23eeb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 20:25:55.4227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v30lIh7KG/i/lw14o4B8ckEyZlL/ikbZRX1ZIMqbTwHuVrLeaNEdL5KqYTIuKYPHk/Pa0ErywwXGaMJ0VD2fWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB7480

Hello,=0A=
=0A=
I am getting the following failure when I call pci_p2pdma_add_resource() wi=
th a valid bar memory address range:=0A=
=0A=
[65246.333251] Hotplug memory [0x202ffc000000-0x202ffdc00000] exceeds maxim=
um addressable range [0x0-0xaffffffffff]=0A=
=0A=
I see this failure in 6.8.0.51-generic and 6.8.0.54-generic. This was not a=
n issue in earlier 6.8 and 5.15 kernels.  =0A=
=0A=
fwiw, I also get this failure with with 6.13.5-061305-generic.=0A=
=0A=
Do you know what might be causing the schrinkage in the memory hot plug ran=
ge?  And is there a workaround for this?=0A=
=0A=
Thank you,=0A=
Kit =0A=
=0A=
=0A=
=0A=

