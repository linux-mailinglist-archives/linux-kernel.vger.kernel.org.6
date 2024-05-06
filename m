Return-Path: <linux-kernel+bounces-169476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C69A8BC93C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A33282897
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC72140E5C;
	Mon,  6 May 2024 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T+lbqW2k"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2057.outbound.protection.outlook.com [40.92.98.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990B8BF3;
	Mon,  6 May 2024 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983233; cv=fail; b=TXJgFy/iAPRaqa8c5R1bo7WGss7Lwn4jdEPReSvz+iuVPvnsv4HoCxDJKqqU+S2BecawyDjr43ylgaFPjsG84xNRC+ykfShVAyed1XIDYSGSnsp9J6qentAL3i+WO9F3Xtv2Ojog68Rj9/fqwNCtYCP33LfNtmJnMZCtRa9D9vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983233; c=relaxed/simple;
	bh=/t3g2DEnCrfKVCzdsk84yCPoAQ6hW2AamgzrgQ1EOwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XPp3Rl69yJ85TFDBhXd9z2Jt1cc3Stn+jVhQzXaK1gC+nyj7lOCLCgKD8XFBTReltCmkiZg2DjG85o9ebO45HUYnENhlklgmuQcrDIEH1iUYAM/1xzKLo4rhlT6073CkeuDl1+Iuxm7J6wF8c6vy9RSXq6K51z0UE90AIdDm8og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T+lbqW2k; arc=fail smtp.client-ip=40.92.98.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoxXQmLG2CIGOSKSvruPvIcH336fJzaiuycS95SJY0hLKInTNuElY0jDzL+mmUf94uyaSxMJfH0/IlRLYEJYRtezKUMaOurhrzBBMIe7MRxKFk67iNzlXkZKr4fjwnmNyfE9pPxOEQ8gOJVdM6NJKcZ9aTeeVu0LrjZI0WP4T2rJiNf6PUCf76QgUjoQlc1zi6aNvk5dryC0kImd21+m/O12AHk9dCjCIlcitTxhQxYtu9eYG9DlMgRA0agEQkIgjoZhROCdF0JuAd68wXPpn0ko3eKK6zcnGdMWD6GAy1WlVGdojPBMmsOoivtpRzHSMIvBeia3bP30O6K+VOdZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t3g2DEnCrfKVCzdsk84yCPoAQ6hW2AamgzrgQ1EOwI=;
 b=Aok2ktc+RK7jJtX1OnTjOHUG3x90cup+x0MrJoae2lZLgFShDUkBZ1fZGTK/g0R2Wl0UZ1EHkR7Y7QIcJVJ7vtUWsjoduGT2wjd72L4nufGEJaCmql0XT+cf7xeDhaTdyOy5kDPs6qOIp+FVGwEmtBYuFLrfGBDudBvU0+X0JoYLrCRgzuxRkgFb7xFns7iVriDLHTvqAg4GIWI76BKjM6LzLxm6UZWctbpgeKRJiRagXfZZutDJqaKuZGvW+onc4Jes+exwK7luOtIoAkBEk0PJB2ZwRQN9ckVLFP8PugXJ6IQpyUV6flYy1Tb4Y/90yae9nnZcshFZTEFEKIyJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t3g2DEnCrfKVCzdsk84yCPoAQ6hW2AamgzrgQ1EOwI=;
 b=T+lbqW2k3Em1+j4ykrZkZYjr5ArMLTT1UkMTmcArB5aOies16d7xrj6r8MKe4lH6o7mI35JCuHCGQ+Ih12Sl981IcfjYpBdM069gaBz3tgouWo2lplhuU5it0slyk2QFNFoYvaREWGkWFgCP58HNFukm3lHPaejjP0HJeiBNAb+RcIVFXVsc9d3oOn9HdBSLnof4Fch7oeJA8QEmwVi1q3Rf8C4oBn8Hezglftg40j1PXOvLtUQ2UCedzrJ1XrhYimEAAJpWTAMpMP3YF1RiB0pKkgusbi9BOI7LIHIVnx2VOImeInfvM2Y7XGa2d2pR9ql9Yj1JQvBrGDspreSFhA==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYTP286MB4105.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:184::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 08:13:49 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 08:13:49 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: tiwai@suse.de, Jaroslav Kysela <perex@perex.cz>,
 sbinding@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 rf@opensource.cirrus.com
Subject:
 Re: [PATCH v4 0/1] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X
 2022 IAH7
Date: Mon, 06 May 2024 16:13:44 +0800
Message-ID:
 <TYCP286MB25358A7C821DF803614E1183C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <87y18ngyyg.wl-tiwai@suse.de>
References:
 <TYCP286MB2535F8C34EB5E3D826B74C17C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB2535FAD4F73A78C410CE11F0C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
 <87y18ngyyg.wl-tiwai@suse.de>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-TMN: [IiJ7M7PTCrJK8/fKPewrsAXRdX70nuHXkcOVUQ3vdrM=]
X-ClientProxiedBy: TYCP301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::12) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID: <1929044.tdWV9SEqCh@qlaptoparch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|TYTP286MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c30a8c6-6962-4268-9f97-08dc6da47555
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	pRzoaa847Wv5TczIZqsx0kEQmYs8ES3WBPdAtGhiwXqNMU0M2zwkUDaA/te5nCWCnYpVhe8G8ANj8wIi53vsiH8m3oIBB7aXaN0YNeeGQRxhx5NbGOTLlz66fuDD5NVft9xtUh/E5xMVfKvQZUWE7mzCVocs+ilPhmyS7bouyOe3TrPpuSJKi1urm86UIEprLkxoDCwZ5S7hrXflR4KfiEe8NNYEfnlc711hR3Rm5W2xZSfEsA238bh08Xv810GCAb3Hwwvrhi9a2WDsStogMq5Q3XdOBfYzSSvgCz4b0n1zaC/hRp8I5/Oay6/bPlI+0hPZYOesmmvBowK7dFaEuDY4nCPVikSL7+9HblAFfH+sMcOQ7MJyjGmcaUDBOTBrzCxFZwh+V9BSXpY2zF1QldqCGj1kXVN/TZUb7Pm6QeNtRPd/oa9DJeDK62yB1SHdZlexnR0dN6VzqIjuOk9q1iDZcFmF6cNjuzkUf/rjkdNLtHFD2fGx6LSjwsf1zoFaMWhlhRqBigy3Mw2G/3H3eE37OdrgtXWFczby8/MNZ0uL5FMFU9x9Id0gdlbvh9J22b/flBdbljCcCmYqhOxncEO0Z0v43p91wnse9X7l3Tg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0VpY0lpRmphcCswa0YzcFpYdUZWZ2JuZERLdzBFdTEwU2hNTTFTL0FkZDZu?=
 =?utf-8?B?OHVqUWJRb0YvOW1XMUNUQkFnRGh4bjhXdnZSOTIyb2l0SE9LbkhiYlhiQzNr?=
 =?utf-8?B?NGhsekFzTXBlelgvR0pkZXZscHhESDBpTDg2aXVLa1puckR0a3BtQzVobE9r?=
 =?utf-8?B?cWhnTmFDTFZUMzdWbVlPcUJsd2d6V29EQTRSMWZMNjlpWE8yallDRTJXYU9E?=
 =?utf-8?B?VUVxbWphemRqc214TE9lbWsrUmRPZmJ5QUY1UnpjSm9wNVB6WkZTWm5wcW55?=
 =?utf-8?B?Z2x2SUNiN1pzMWJZU0JxbCtCaGRGNFV3NS8rQVNibnlDMVNhTzN5ZTFLbVJM?=
 =?utf-8?B?QW1TYkhJWXZscWN3Y1ZoaTBPUkcxbE1tbFoyU1hSMTdWRFFDUWJrNk4xMDdW?=
 =?utf-8?B?bGhJOEk1MStpemo0SG5ZVFJLNEZIeUozTkxMUHF1MWF1amRnNFVPbERBNmhk?=
 =?utf-8?B?b2JBQUM3SWU1S2wvaDI0WWN4THRJNHQva2NmTFRFL25lMndQdWpFeDdOckJz?=
 =?utf-8?B?Q1ZBUHlubzVTL3RFanI3VGNxdjVMMktjSjZrYTM4U1YxbVk2U2picjRrb0Vx?=
 =?utf-8?B?ZW1qNTh5Rjd6VFh2OFNqcjkxdGt2bUpGL1NsdS9ab2JmOTgzOGZpeGJBbk9P?=
 =?utf-8?B?Q2RlSS9aWk5hWVYzcHc1MGZvUUM5YUlSSzFFM2htSS9VQnlTeVp3N09vbm5E?=
 =?utf-8?B?QWRldFlYSmVFWjhpek4zNnVHQVp5bGxYVTBqYU1aWGM0cTJyVkJ6cGIzVlcv?=
 =?utf-8?B?V09RblJ2V1piaFJMWnc2ZTJBNlo0Q0xLWmdnVmJHQTVwOVloWmZYU2JjWmd3?=
 =?utf-8?B?SlZnYUhMbmI0TDgvOFFTbXU3QkgxM3M3Nk84YU1meU9VU1lZWGxoaEJ6ZVBZ?=
 =?utf-8?B?SS91bUVJM3hmSEczMzRoVDF1ODE4eUFUaDE2VDhPYTNKZklaMHFjclFPOWY4?=
 =?utf-8?B?a04zaEVKSlhJeVlkWHl1MEZzK1Y4NjJnUnlxeTE2eDl2amxhN0R3U2xTY3Z0?=
 =?utf-8?B?WjB4cDBXaG1Oc2xITjVFQXVEMEJEeS9Jd0tWME5Qa2UzcGFJYnF4UXB5T29k?=
 =?utf-8?B?WEFseXE1MFhMZ0RSZnFRMU5LY1ZFU0NJeFdpUmp0QzA5eWM1TjNFM0lrTlpH?=
 =?utf-8?B?ekRMTXc5ZjBGMmtrSVZ5bzRzdkhveUtNRndlSkU0eDVxTkdVWjNhcVZhT3kr?=
 =?utf-8?B?VVJrTC9lVGNUWWQwTCtaVHV1WGpaTG1TbUFLU1RQSHJhMHlVNXVtSzYxZG1l?=
 =?utf-8?B?M1FWWTZDNnYwMkdEVUZnM3NJZmFjVXdtalY0U3VqT3JISEJPS3kzTUZ3K1Z4?=
 =?utf-8?B?Z05Sb2xHeEhMMmNEZDY5L1pFeGlscWkrb1hVN2x1SVErQ2ljd0ZPZTlFcTJn?=
 =?utf-8?B?STBhbXpaenlnOCswWmVUaWkxVmNRNm1yUlZaWnU2TGd4R1IzV3p2U3pNY1lD?=
 =?utf-8?B?WnlrWXQrTElUTkhES3ErQ01IZkZqL1hXcFc2T0tGUjJHWE5JelhmblFTdmlC?=
 =?utf-8?B?UVZMM1Bhc0NrOXY4RGlVZ0RheDBmekJId2NRWlBJWGhoc3NvemlScXhWYlRj?=
 =?utf-8?B?aU0weVhJRWtGak1Ibno2V0wxQVpxeTVkV2V2ZXYrTml2NXZYUmN4TktJSkJF?=
 =?utf-8?B?eS9CUm0ydnRJOTVSaVRyVDhzMG5qaWkyWnBWcm9iL1c1bEZhMnFXOVZlS1lE?=
 =?utf-8?Q?+PfvWAUXZWCIFRN/uXBQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c30a8c6-6962-4268-9f97-08dc6da47555
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 08:13:49.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB4105

> The From line doesn't match with your Signed-off-by line.
> Please align it and resubmit.

Well, okey, it's okey...
Resend here: <https://lore.kernel.org/lkml/TYCP286MB2535E8C7B2F9E7EDD75C4382C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM/T/>




