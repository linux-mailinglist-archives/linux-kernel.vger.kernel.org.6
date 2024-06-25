Return-Path: <linux-kernel+bounces-229700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B538D9172EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105B8B2235F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA6417E45B;
	Tue, 25 Jun 2024 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YxWYDU1y"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01olkn2105.outbound.protection.outlook.com [40.92.113.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921F17E448
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.113.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349512; cv=fail; b=Q7YVjrVvFyZxLl4kmTm8fSWM4SG1H2im1sOVNOAQwb/Wh3aySsHjEULoUt1enVG3k1GbCnC3pe90sPBigTf632LhMIiDFHO+MEUDGx7/DUpRQW4HBHGGCYCwOSPfBCAGzc3+PGGS2obz6t+MOn6e56vu4yvTdXQE48SEnRPMlUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349512; c=relaxed/simple;
	bh=htxNNxFTdXeTNmNiq78sssjux9OPUZI8WExUXx3th20=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W3zM+z4c17SwfQdM/V+K1BzK3uJ3aDEkZWBZF+ZNr29JkIGNZHFONdtnyh/pLg3khLWm1olKWiIJfcJ4C+al9MDXh4rsYMkWRTmt2lIFdEDf+QSJgrWMTZn29VeAfaOT473DDO3w3QH5Hz2qBFBvg2VNYjDNhJn/FDQyKx22qto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YxWYDU1y; arc=fail smtp.client-ip=40.92.113.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNeDvF78+YLasud7oQNS5zDi87H4lT1opmS+0mKpvYy8xcjW6vJ4xo9wKSu12GRgmxzIGpiMDYBAbm8rNYDAjHTOH6+GuKx/GImW1xiY+MeZMTRNgvn8f2rTRDuufjlyb6c3Rctz60/6IFlBj0MRFSAjYmTmMYYEYkYf4NWTRlyGykNowcLGsqngdavqp685Z0+1W3MTw4BGTN6inh7TBYuYRDYJwxzhkpnTWz+yxymTH3VGO2JIUqb3nwVGQRpo5zthuS/5IZEs26Vgzs3l1Qz36gTxTCsKPvWBm3IkOzNn4J9EHbgGY5w4ihF8YBHf20av2EiCnYtThHGaUOTl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htxNNxFTdXeTNmNiq78sssjux9OPUZI8WExUXx3th20=;
 b=laON2cgOsbL2Yti2oDsHgU9WjCWJZoILrUHXPt8gpyKG9As/WYs9/NKeRnS6SevExCg2PMZv6EXVoP1mo4K/c1tcKA21EHYDoVbhllXj/rpD3AMpJAoV6DDwaOHGrbN/h+hayKPD6NoUu7O3nbo/33Dx7X7NsvP96qeUrm5Eu3m9+7tYAO7MHzXro8fuL650p7h65Zf5G8f3wjB1Zsoek/lAFen+tVIYoBxmm6sm2NJH86sGsbX6rNSJctaTtAtS1jnTOQ4Mi+OOtWRQM6lce4ov1XkWEWSDnv7ZE3eksTghJ7DO1yIwv1DQpxlXtM+6ximXFJxlEIXu4aU68SXctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htxNNxFTdXeTNmNiq78sssjux9OPUZI8WExUXx3th20=;
 b=YxWYDU1y7C98ff4mCvy3NXA1BT/gRgteO/3w7OX6PEqvZKEXT8Ybf2snWSIn+o+wCDKc5tO3G0f151f3MfdTfLRw3cgRXw7Mc4acmZDfldBwWBlmNPoYocjM7ekIFFygsHHow7bBx5m86hDeRAFPFStrxd6/QOFYikug0+y/qBDhWa0+ioWx+UHbkNKBiW/KMXiw1HhC80P9m2F1uxzhqBKffCK8+wH27OwMYKDRIa3Ooqw4Ryxw/OruS4sr4QjJDJuYTzHUPAzNhMtRrwxQCQGzkV7eYCB8mXMTayBvoyL7a5USho0NAa0VHW317vmIk3GpjjITBAjNlRKU+jAzLQ==
Received: from LO0P265MB6518.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cf::9)
 by LO2P265MB6312.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:257::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 25 Jun
 2024 21:05:08 +0000
Received: from LO0P265MB6518.GBRP265.PROD.OUTLOOK.COM
 ([fe80::8417:bf6f:285b:4bd5]) by LO0P265MB6518.GBRP265.PROD.OUTLOOK.COM
 ([fe80::8417:bf6f:285b:4bd5%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 21:05:08 +0000
Message-ID:
 <LO0P265MB6518CD0EE3520E4312C947F5FDD52@LO0P265MB6518.GBRP265.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] Staging: rtl8192e: rtllib_rx: fixed alignment
From: Yusef Aslam <yuzi54780@outlook.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2024 22:05:07 +0100
In-Reply-To: <eb6adf15-d56b-4a23-8833-b9340081614f@gmail.com>
References:
 <CWLP265MB6516C4904E979DB10F00F9F8FDD52@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
	 <eb6adf15-d56b-4a23-8833-b9340081614f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
X-TMN: [a9y59FNDhGNZlBSruWrC41By/YcLs/hD]
X-ClientProxiedBy: LO4P123CA0621.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::21) To LO0P265MB6518.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2cf::9)
X-Microsoft-Original-Message-ID:
 <46d1f995049d3bed4dfdb1999cf0ea7f60d326cd.camel@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO0P265MB6518:EE_|LO2P265MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: 77794f28-701f-45d2-3d01-08dc955a7e9a
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199026|440099026|3412199023;
X-Microsoft-Antispam-Message-Info:
	dN5RfVpzzvVTt2lhKmWYbu7s0Iy1KdNRxTddjHXRgrkXR7buafSGTqJsJPP0Mxe6WG2E1I5itRdDyA9yjAFQkEQe+eHXbKa0Oqf72oc76Uga9C+A/YdtvPbR0D5oMokmpLTGYANbv588Afi1Xneb3dZ6XlEvpnZJLIOMgofpLpZ8s2hYO41cmuvALacKuIMoc5dacc3klWBzl01ZGbbQ/Jp3qwNVm39buH1kQmG1cNfTI6UT+/DXzf4BLm7aWQNrkcvDVVrBG1tWYNHeGeRSUhP3bZVvE5/xAxEfe0Ix93uxc8TTu3zdpO/Uq/R0h3riXDS0gCcvxfDP4LF9icNtY+YDu9cmnoIQsUMr7tbR7wA5BfZdqo9B9aH1FagCbu1/d1L2YfJ0rniUbCnmWrrUVu88rjwpksKdZuZanod4oIWFe16J03g3ggh8rShy7CMeLMmuNp3NAEQSQ8kGqdly2eJnckMUQgch1XVUtgEZ372JRB5ZHWpTBJIHC101ASGe1n6GnvygYThV1TwRSbt7BbuIG5rWB7SI/ixQ7VfgfgkZdoiaoIxkl3sABJdItx3T
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHlhWFdKNXdwN04xQkxpUWZJbUNxK1hkRnhLNG1BUjJkdU5vQ2x4RHc4NDNJ?=
 =?utf-8?B?Q1U2L3pENUR5bTk3bERPUlpITUZCZXorT2hFMnJpVFUxZFFhcEpDM3Fkbm0r?=
 =?utf-8?B?QWFaRDY2ODU0ZHlnUlNZbWFsMFNyVHFlNGdtQnJOMmY4cngyMW5MV2NiMVE3?=
 =?utf-8?B?a01QbFR0YmVLYVF2Z0JxdXhLUVQzWTRmNHM2OTl3T0pqOTUwNnVxOHVkSkhF?=
 =?utf-8?B?ajg3L3ZKQkVzaWNQaThmTGptTW5jL3B3R2prQkI4bjlZRzFkTFBwZ3FPWWFK?=
 =?utf-8?B?dU5jN3l1Zm5ZZkNsYWVNd2IvaEhOdzZrNStSckgyL1dsSE01V2hjZmlKWVJo?=
 =?utf-8?B?azN4Y214Y2FHaE9UN0RXdDlOQ3VrMm01N2xrOW1KL2JyTVZ6aXVpUHYwTnZL?=
 =?utf-8?B?ZTJyTmQ1RnE1S0ZrYnMxNzFxU1UrMlJudFBUMCtmWkVPVCtYN2ZtRERjT2Ir?=
 =?utf-8?B?WU15Nm15SzVrQ016L0ZSM0hZMTJJdmVuR3RsZWJyOHUyU0hKbDZUckFWVGw1?=
 =?utf-8?B?YmNXRmpobEVmMUt5TGQyNlZSQzBPaWp2Vk1ic2VtTm5ZNFladEVTMGFqcHdy?=
 =?utf-8?B?ZmJmOXlieXdyanFtdGlUN3k1b2o3YjdFd3dBZjAvYjRYQUVDbmFOWDBmNlFR?=
 =?utf-8?B?SkU2NWw4ZjdQZ25xWUlqNmJvV013TVhJK05IdC90QzM4L3BmTE5qOHQ2YmNw?=
 =?utf-8?B?cXlHeTZjTkxpL09seEVOSnYxemNIZGdBZzdYdVZmRTJOU0VJWDBWNXBpVkh2?=
 =?utf-8?B?OG5kYUM0VkFqeDlNQW5Id1cySGtmQVZWd0JjK2tmczdVeE9PRU5ydmxZMWth?=
 =?utf-8?B?QXVhc2NKcHlmelVPOCtnYkN1dG93TDVSaTVwQU0wNGpDZUVDUlhRNkJhUWpx?=
 =?utf-8?B?WVljYzJreG85dVdJcDQ4MS9iS09lTnk4VzdFcnVobEF3cEszTjBudEhYb2Ns?=
 =?utf-8?B?eXVBTFdhUk9Cb2tud1IzeUJBNWdCZUovWmlZQUswOXExd01HRFJTeUpvRlpr?=
 =?utf-8?B?V0grZDF0dXJkUWNWSjdnV2VsQ1V4MlN5enlnb3ZQdEZHVEkxRFFNVGxVTHQ0?=
 =?utf-8?B?aVNEZG1EMnR0dEJNVHRTQUFIbk04dUFTakdTbXFNWCtBWmJzdFFXUWtmc0xl?=
 =?utf-8?B?TjlKUlpUbWtZZjN5Nm1KS01mMXkxQUlEc1RBRnhpekNJV2hNc3ROcEVSN3Zu?=
 =?utf-8?B?b3lMQnVFdkhZN01ncm5vOWJURDdZR0k0eGxhTE5aL3ByYjNOdUN3WUFmMW5y?=
 =?utf-8?B?NUhUR1RBNkc5N1M2MTFHQzdaUmpsTE54bklQK1JWa2ZIeThQdERuc0tEWEZk?=
 =?utf-8?B?WEpZMnRpZ0I2WCtRZGIyN0JUK2oreGFkWUN0T2NlZ0RqdnNGQ21CRmVGR2l1?=
 =?utf-8?B?MGhtbCtmeE52OVhrYkRrcEFNVUpEd3A4Yi92RW9INWg2Mk95RVJodHJ6N2JV?=
 =?utf-8?B?OVF1TjNULzFUSDBDdTMxM29aRWp1Um16QVpGYTRFZzdhOU1uQ1lSYy9BMFNO?=
 =?utf-8?B?OHJOVVl6N01keXl6K0oxaUgvVll5OTdFaFhseHJrS3R6S2NNNUd4SllDdzJP?=
 =?utf-8?B?Z2IreWNsQmllZnFUYXlwYmsyTFlvZzMwME9EcTRjV3BQRHNucEZjVlRuR0N3?=
 =?utf-8?Q?xcj32N08geo/XrL4R9IZMA6DOw7qeC3swX83UB7vLhSo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77794f28-701f-45d2-3d01-08dc955a7e9a
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB6518.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 21:05:08.4522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB6312

On Tue, 2024-06-25 at 22:41 +0200, Philipp Hortmann wrote:
>=20
> Hi Yusef,

Hi.

> I cannot apply your patch.
>=20
> Please check against which git repo you develop.
>=20
> git remote show origin
> * remote origin
> =C2=A0=C2=A0 Fetch URL:=20
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> ...
> git branch -a
> my branch: staging-testing

Oh sorry, I was developing against the wrong repository, will clone the
right one, thanks.

