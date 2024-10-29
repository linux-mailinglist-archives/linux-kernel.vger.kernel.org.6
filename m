Return-Path: <linux-kernel+bounces-386211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ACE9B407D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6209B281D22
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62CD1DF74F;
	Tue, 29 Oct 2024 02:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="m8tORYM3"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023074.outbound.protection.outlook.com [40.107.44.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C79F1D7E4E;
	Tue, 29 Oct 2024 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169303; cv=fail; b=f9qYwMMdZPJjeQStJnCPtc9FSMBndry41szMFBNXVDjRH8esC1977ueiEURF3xbvyLgrWYPJH6bBzWO7swD4UEl1kfkn0TVc/StWfoF5O1gFh+CjTyzF4mrtzo1VP9wQzxcB11/cYlU2Aj+P/QGmJzHPIWXoeaOHP2QsfcWs1cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169303; c=relaxed/simple;
	bh=A5gDvFczkkbmM+HObtKEd+YRhRKMtlswkiaDGrAuDSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jl+ajX9UCawX3K29n+lsnaUn70pwNljG7V/VextcQQxDHGRYzWmy0eeH+SARE6Y/y3o4OIE9D+P+RgAWrg7DENN6ltC/pJrIC7fnjrPTU1Z0d0XZ/wOZnGnQP5ydvfJjHuVJ2APCM5M19BL9eDljExg/hRyxyipyApZKzMQU9/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=m8tORYM3; arc=fail smtp.client-ip=40.107.44.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VISdrrqjuL0wv/G0BtVBo+XHqZaF8W/Td0MrmkWjkBwLXw4VDtjHtAednOP6oNIlxh0RwUF29kOUrbKvHqNEggbbuWuFguknWch5Af+FjjeDGedeBkMw0JtXiRq/oqtmUA89AF7UisT1unkqlAuCKn/8TH8EUtZYorVJTni+KP/sopWKeL0LWTDCC5G41F7vqKRMqwLWwWeEaYrEjKyxrBix7GBkgcfsNQTS9Ju+LRBCQjQCxtQumWGZtU/DJ5Xv0M0c3a0Neh2C6slVHdVrhIK6gXFK1iH3gSJLdk+n33pjixpB7z1GYji3RwaW0iKkEaNrKmA9RM+LONEwdb5Q2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0GdqqQBDrFM4iGHBl7CCpRuGs/yGKVAa9FIlBDnwDw=;
 b=c8V6a3ACH38hQDXVg130E4uACP1stob3lRp/X8L8xGTftU5Yx+38z+rYzUnZJ3UZ2TA0aoO3DJi6Z/NV97khGWjTSd7tpDv0QdYDyw+PfOI28C2SWNgSMa5Qs0yoRC5Z3jzr6/lCIseHM7N7W4j96UeK7th2/QsUSb8VPsIRztghXIgfuOMz8JVlRST+5GBLa5wCc2fnqXa+d2Te8fIYfK9X3qh5wOctiaJcm1S874wIBDFs1NjaRBUUlj7KmJUApdT8eVVfz3gLeLsc/cW9RU9qRvGEoKPDwTYn2VW7b2tDL1Mb36TleWDR4e0xj+UMSqDaNzlv3OxjxfphZVCu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0GdqqQBDrFM4iGHBl7CCpRuGs/yGKVAa9FIlBDnwDw=;
 b=m8tORYM3HKgINy5d00lXPI73hit6EItz/io5uRoG7IOopfAb9mSXgEX5DpRlNKYS8yvcw+S87fIrh5rCwOBN1rQMpkTsCcDiUgj2CxOJPjOy+/6oQXGeCM4/JMlmqg+SJmYMWA9TUoJ0zYz/RazQZedrapcdpUlH84xZ1b5HDkKq8oFedKoFFDUQLt5a9ST2zy5Ug7tRShvo8pbBPCeTuuei+2EYSYkoO6HNErz3b001y+wX1j2r2Ukju7CYPToGZrndUpZ5yZWdoFA1BAYC7wJhTs8EYx5H0ZsccbofBIWdlIIj0OjwomKr9eUaYJfxCq59+yAj3PCBvRv3rhELIA==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by SEZPR06MB4999.apcprd06.prod.outlook.com (2603:1096:101:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.13; Tue, 29 Oct
 2024 02:34:56 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448%7]) with mapi id 15.20.8093.014; Tue, 29 Oct 2024
 02:34:55 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Akinobu Mita <akinobu.mita@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] hwmon: (pwm-fan) add option to leave fan on
 shutdown
Thread-Topic: [PATCH v2 1/2] hwmon: (pwm-fan) add option to leave fan on
 shutdown
Thread-Index: AQHbJ33jrtn4+8YK0kKUwbKwIO1tD7KdBnF0
Date: Tue, 29 Oct 2024 02:34:55 +0000
Message-ID:
 <OSQPR06MB72524578F1E5BA93772A12728B4B2@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
 <20241026080535.444903-2-akinobu.mita@gmail.com>
In-Reply-To: <20241026080535.444903-2-akinobu.mita@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|SEZPR06MB4999:EE_
x-ms-office365-filtering-correlation-id: fb2ef633-b8e7-4d4c-1cb6-08dcf7c24684
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xvyFJef66bwoWhbK3q0/hQQcf6oynktlMCRNP1SPksmWDlVSmeZS3Ykvyd?=
 =?iso-8859-1?Q?QjdtTuJzutLY5bF+GDeryQT5PmSOsujOHedPe7DCE77JDyKcepdmc7CR7q?=
 =?iso-8859-1?Q?Ulex/KY+BjYImkwb9DUwtYq2UO6eX+nDXHMW12t6p6VrkAQZwDrimhTmX1?=
 =?iso-8859-1?Q?EYDyrgYgDgVkW110pJ/BFSttC5WI7SKSWsMhpLl5Re/IaIN4RSNUxs3OzO?=
 =?iso-8859-1?Q?t4sR2w8FN+yIcs7cFMmw5p0U+kVhVA3urNyKFyw5ObGGTA1lXrvpCDdQ5D?=
 =?iso-8859-1?Q?pfMLs6z9OcQKS4vFA+Q0szqJHHe5ZvcXwd6CgJok2SVu5h81j3zhc5gQ5Q?=
 =?iso-8859-1?Q?RnTxBxjKN2NYkWBSf4pRxfH0HA9N/ZR910ax9vr/xO4Sd63cvMtM154Nqp?=
 =?iso-8859-1?Q?q2+n00i6y+JTVAz3Ba1ypr6jnaFchDy+PGrevRLiu71kYhLDpYxw3tSzzb?=
 =?iso-8859-1?Q?WT3rk7FhFdLqACSZs7KT/dYYnY+fm85vXV7KjdU7HQgE0lqlvuRzQnOgSf?=
 =?iso-8859-1?Q?TXborGBdNcMOYXFSwTL3RwuykCfXJHDkl06KGpTjra0dgVwLNYEIypraqv?=
 =?iso-8859-1?Q?Dcnv95JJ8ViTpynYFgSBgS8PtBe7aL/qJy9NRJKTJSHi5Zo8tqlr3g9xcP?=
 =?iso-8859-1?Q?tayfW4Mwtc0g3ItULNdawPNhwQ3H8O2DNOTPZ5VoICcYx2da6cyv91oUsc?=
 =?iso-8859-1?Q?YA7hwibj0qqs/BwNQl2QeOtu0/qCa1egQri1eubd5PXfHw2ZWprB/5XLsN?=
 =?iso-8859-1?Q?oBRQnI4IQmwoPy/hnxumbNsuQ6jw0+HM0ER5Ypb35COBjBhSEq6QefkoU8?=
 =?iso-8859-1?Q?3GOIm3z8IbI9yUaVvOo21P+CMb0S9X5iR68W7bMNbN6UBxuYAkU0v6O7bx?=
 =?iso-8859-1?Q?tKOuDmO1Ol9kG3CimpPDFa8H/XtGv9spg5AEWlQVy5k+t6rEdZbJ/M2Uw1?=
 =?iso-8859-1?Q?PjtldmMfVF6TEtlWcIO/mzw4BcPhSonXqRNkG9+9miU0Z5IXqwy0dRhTjd?=
 =?iso-8859-1?Q?qXgMxOz4rYLcFeouAK9Gx5stjmAolAdkYkQqnTspIGAfN5f2/WsZKT1tPr?=
 =?iso-8859-1?Q?RQ0wvY03Gq6axoLhC1Rt003avKwCdoTkWKlSKEw2y5LIDXbf20l/Lddof+?=
 =?iso-8859-1?Q?tFiOWmeB0Zfgskc35x8gVrLyLcyksdUS4BMS8ikBv8Bb/xI4ctb/KnWpf2?=
 =?iso-8859-1?Q?S+g7XwMQM9rMpHbRaKibfZrloHlTzjyZ5yiNbc/dxyMc1TQPf4R4EKgVaC?=
 =?iso-8859-1?Q?IS/xPW6Z1QKLC6g0w5nclGcjfCFpHOnANd3SBPGl/YreUiLxtdpnya+MmF?=
 =?iso-8859-1?Q?epDbLnUjiX/0wW+vezO9jOlaIShnGa9+BziwR7dfq46Dv/bHOl8UbJ5HtL?=
 =?iso-8859-1?Q?hIZCnQIxp2bl6pmNv4sXPmkky9PeaR+C+y/Cr1xSwnQtCxMHMRHeA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1Szu/4TaYX7TGMJACeY2YvFqyMDNXWum0ElNLeGHMa5tPoeJo/ghnPpucr?=
 =?iso-8859-1?Q?7x1g/PgzAJ5h8w86CCQPf18rMfg4Ofgk3lEYsIw8pZbWMrfEHCsw6goxke?=
 =?iso-8859-1?Q?bQIjj6dP8gygDczI5+0V+kk0SAd4Ve6Cj+Kyn6qMkyBuPmVx+U/qs201eB?=
 =?iso-8859-1?Q?rN75qwH3MuaEFIolsBlQIDXmHFzAh1Ohcq4EUT4wVAV4OeR6FPtd0nwYOz?=
 =?iso-8859-1?Q?3ckZ5JJ5kbP9hGtqThiEkgTYISYZ2Zt/I45yfAALI+FPCyrNTpghCBG20H?=
 =?iso-8859-1?Q?RMZSsem+QeBcwuo4nB+2NyL+ePt4vwbH1bawOU1/kFOPEBYeF5djN5ksbg?=
 =?iso-8859-1?Q?sPTeLBMZPN7qZgCVQbYbIcnmWBaA8CpvFKICquexAnMuKHCuHyF5LMnivc?=
 =?iso-8859-1?Q?b1NXhUeskwtX/bznPpnRDLM1r5j0d0nBkKzwSBon7aPtve8McLiSBx7gy1?=
 =?iso-8859-1?Q?9p4hxlGN96epyJjyEpzMmAAq0uPIpYla+bBo3iw0o3Vn9gyElLa0o2Qjm8?=
 =?iso-8859-1?Q?0+MdtXlan2lqTAYfPh0TTZagIlARbb/qY1LNilDwKQDNgB1R204Pgqtwaa?=
 =?iso-8859-1?Q?VRLvidFGYP7qXPrrV5R/6HvtxEgRylLKaj6Jat6udTQtY/18hRrGV2cS1K?=
 =?iso-8859-1?Q?hpertKeLnCd/iDnAZkR1xJ6LvpCf43cMGOo84W5rpzdvih1I+A/pdOBi+Q?=
 =?iso-8859-1?Q?FkNO0kw/rJB8mS7p8+6FTc5kaxVzLi7YgO+W2+ENSE4XVPCyujtFJLc1lH?=
 =?iso-8859-1?Q?Xk9ep15J1LssFfTDGEZ2jFM/zak+KrtvmEL2zC1JGcGMNSb4GRM6bKzqet?=
 =?iso-8859-1?Q?HnPgry9zGQt7v7OmUf43DfOWAb2IC5fD839DW4oBcH22lXxirjOgOYFaRn?=
 =?iso-8859-1?Q?jzHrfb7Uev6AIjoSyIefAXBVstIYhYFW7QsP3WOo8GLaiN/yRpp2mHtSCf?=
 =?iso-8859-1?Q?i1472aa2EOlVl0YvXQlYwAqkLuvXeLvT1X32BL3uizI5x987xC/MrniH+h?=
 =?iso-8859-1?Q?gkJcNHcUgaJyRAtPy0S2UuGNvvU76XTSj0TY052pX0FUw09YZWKjn/Hei2?=
 =?iso-8859-1?Q?vku4dnBJvIlB98TIRkUQ0LH5v7FPMsFQy2LAOz02unF29/zrHsn47uRKY+?=
 =?iso-8859-1?Q?rnF8YDQTjUvEzb/JzsT2Fz4uXEjAFE/MNkV0my9PGbnmp4q+8oUyUzl2Ly?=
 =?iso-8859-1?Q?68fGRHFXKzOAcynrBrYMXKCoByG09X9RrZ7UINRwy2taRI9Cif/uNqwdJC?=
 =?iso-8859-1?Q?z0xqPkrxuUkpIwYpt6gIH4c4ZCwFhQUzFSJ9Qnyt8fYqPjBOpthqY81fbn?=
 =?iso-8859-1?Q?lHwc6dA3p0K/U9XhIyxrLdFZyYyuN6H4OiKpRM6ogWxD9EuQA9lPCvPtaV?=
 =?iso-8859-1?Q?hLYV6yOMNH8wR0/z48bn8qR4iK4dPr69UuDF+eihLoTKmqPmvuSUwZ3J9j?=
 =?iso-8859-1?Q?c++v/YipyWHIVjo1MyiIzawj/BfzJ3kE3Jt2hCscNe12DTdSJHie7Ka4Be?=
 =?iso-8859-1?Q?8AMMLuj7nDEbI1flWBYY1h7Mw/tum3c1sLn8TGQH5gYK4IoAwW6O1r7vl9?=
 =?iso-8859-1?Q?ZlX3AsLcbVKBuXq0FGhsvxmdYJzIqAQxVLqfaln5zR5IOSml/xlXirJ6mn?=
 =?iso-8859-1?Q?IPfvpBqJutR0jR3vCsgdfV+KM/KSCsZtOv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2ef633-b8e7-4d4c-1cb6-08dcf7c24684
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 02:34:55.8342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xqFT/huYmNPRZWUbKHDZKLR+s/70wBsBz2IlFpW3b75Bznht1v3+Lvq1JuoiN0SHFZggaXA5mVfvKcKd51aV0qGYK2zTwpULzvYnY1nS0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB4999

> This adds an optional property "retain-state-shutdown" as requested by=0A=
> Billy Tsai.=0A=
=0A=
> Billy said:=0A=
>  "Our platform is BMC that will use a PWM-FAN driver to control the fan=
=0A=
>  on the managed host. In our case, we do not want to stop the fan when=0A=
>  the BMC is reboot, which may cause the temperature of the managed host=
=0A=
>  not to be lowered."=0A=
=0A=
I confirmed that it works properly.=0A=
=0A=
Reviewed-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
Tested-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
=0A=
Thanks=

