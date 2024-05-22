Return-Path: <linux-kernel+bounces-186467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0CB8CC48E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25C81F22D51
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAB013D88D;
	Wed, 22 May 2024 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mMkcNsv/"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2144.outbound.protection.outlook.com [40.92.63.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38E825753;
	Wed, 22 May 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393306; cv=fail; b=aEXmmZQucNvBXRNaBjkPXidiKMLw0TOKMTzSb9lEfDSa5l1F6pfBbkWhTrK4HzQ/b6YpwRI1var6CMQSuhhNiNtJHG42WtmF84OFrmthLvmSdbE+aM7AIKBlCLvynIRhICQm6uVKMqV2WqovM7l5+ovyLRXLWrAIHOykJ9NqGug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393306; c=relaxed/simple;
	bh=tsPlzEXbIWJqPtZe7ckeocGXxRTNF3/J/88vAjKEQjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qmIETpG6TsR9mREkjF88c93hTZPth5dUIxSuAxzWxzWeBpvkqTpzn1TJb3w6PTIQxbB5iV3YfaVLuNNwQCP1y5WaDtYPezXogOIlX+zgAGL5c1bMbrelvQlZ0LSSptyVdE3xOEVtnUAZSmUwLfBPCE5wDUDpNNBtuEq+DqinKnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mMkcNsv/; arc=fail smtp.client-ip=40.92.63.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4Au8ODQNv9NBG6UeCaBKpCrhfGz2zhOGxbIccon/vVGv4+XmcVOi+sM3DEqBmHVVrLtZ2m69p8tI6lFMv4n5K8cyucpe/iHh/sm7wuvtACaW4y+ubsNXTn1rOTFZRpxvxR/gXK3Tooyzvg8a6AD1TrsAq11MtEM+iistIh/uHPnCdvb/uqgGMzehRlEW+m/YVzVcLgfSQ/QUzKwPom7I7U94pvCS4x9M9VFMffeo9Kca5+5ZkxyTzBh5ayNj1Df+f5rRrk8axFwiNHdC+rWZVAUrY5X+ku3Tu7I2By9Y6ZkR2YoGDx3YTLvxCfpkqJi3rW8Sv/yeUwSPF0WUqJs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsPlzEXbIWJqPtZe7ckeocGXxRTNF3/J/88vAjKEQjg=;
 b=hmSJHjmjxfd49ZOXRycTiPlVWUoZvo61vEriPw1jUtTNhPyogXX9Ut1I2Q3XfBI9UjvwsCpXTuWjL7QGRtIAzG8kbgHGjHZehtgH9H9vccZMCG9qbjJb5PukEeNBHjMHd15853+SP376YHrDA/G3BpWsChoBtPS4TDhsLyk6z7nCqpf6Omwmo2A7F2pj2lppvsyIMJAZMl9VqLtqB6X9oOys+v9GxM5u9xwugZThLJH1SXUtKeBuKdY6LyMFQJ2jEW4/b9wK1J9jG9EtACqq54+WQ6ABL4kGqBUMXackqbOMknzvsKAsSW+ewOnMZIhAvnjl4Ax6m1vpiJOmh7YTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsPlzEXbIWJqPtZe7ckeocGXxRTNF3/J/88vAjKEQjg=;
 b=mMkcNsv/KAMPJZ7Ic55VhXZrgM0IdRN47IhTzSCLFv5Mtf28cZln9U26gQN7ZZszN+AFgMU/g277QNE7RgFPzyQw4hpOQfXSAVM3VHhUUTLqqcso86W/139lZXSJqw51397Ai/DkMnYiFs040oCCsyt8oDz3BeLxhbb2uaD9OB2s0I6JlzSGmKpplxSM2d31zn9/eCnqfOhssWkmh8QoyzmbWkSolMDzAkFL4hOqUuS6N4nba6Yz0RVPNlt69vqpMirlLexocz1bILwkz3nmxZlyBtISirszzWA4GHB61HdMwW4Sa9V1l+pebEquR35OBt179wz6TyPmjoBUJ2yWHg==
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:228::21)
 by MEYP282MB1816.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 15:55:01 +0000
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e]) by ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e%7]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 15:55:01 +0000
From: Roland Xu <mu001999@outlook.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "ojeda@kernel.org" <ojeda@kernel.org>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: kernel: make impl_has_work compatible with more
 complex generics
Thread-Topic: [PATCH] rust: kernel: make impl_has_work compatible with more
 complex generics
Thread-Index: AQHarEpnKGVgPPoxHUmAHGalEiJC2bGjVUWAgAASSU8=
Date: Wed, 22 May 2024 15:55:01 +0000
Message-ID:
 <ME0P282MB4890167E8316FECBA35D7533CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
References:
 <ME0P282MB489023110AAF1163F0A4B2E1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
 <2024052213-uninjured-stricken-cc20@gregkh>
In-Reply-To: <2024052213-uninjured-stricken-cc20@gregkh>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [W2KJyF4mR8nhOszsp0GeA1QnenaKLcMhnfDSuTWd1IM=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P282MB4890:EE_|MEYP282MB1816:EE_
x-ms-office365-filtering-correlation-id: 7da71135-bb88-4b31-93b1-08dc7a7789c3
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|3430499023|102099023|3412199016|440099019|1602099003;
x-microsoft-antispam-message-info:
 OO3jobWqOQzX6p7wBvzG5FIXybmq5+vzEsKcsshah1uWRhXCphVxF3uuIkm2GZ1Z5GEFojAy0HpyJCsHTZznBmjH1uhACCLW+JCruna++F/oktfoNsTL17yG56kNRFS3wXegA4pomOYfBsm2lbejDJBPvNamaqsIuTi0iIRf/6/sxb8seBjXaUiB9wvj1UnPGLP3atxhMKupszCwqgTXzbjdXzLbgVG+OoSxEjFD+tjckl/ZYxEn0fU5QSFXrGfHPmnhNgPCv7sOQCbC9cnZZJpqCTC3f+CGmQzB6jH8AiVeJyvlaoTtHVJbsgW8onb7XbIC8ft012q0gkek4A1ass7RIfy2+SnrqJoxWZPmOR0yFg6M6spP2ri4LMfhxlEt20GzYWazA6ULT9Fj5JR0eb5m0XoL23w4312IBudKrCxxUC0botndvfqhg7o1XOUPp5aTTNMQst+erQSZZtDSREa/iVBpx/hVv18H5ZvqXmxY6Z4dV8bF97DRIBhjFIeCo7wfYC4yQI9J6GEJN/5731uXX9WlwoPjcTdDehOXovCArMa4J2pibLPekccMgpvB+JUh+6mM4rsnvv/XcGJ2Wb7iuBtpLZeZE1hrrIscpPlXA/nXdoK4U0xtbZyHxIFn9apIzJmmOAORJwMRBbmALIGJMf+bjdgBPLR0iGw+8OI=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RLrOMJ8epMguv/NKyfQ7w74Mp+lQpGWwNsMMBKyx8ywCzpHUGsqOiYZiPPw6?=
 =?us-ascii?Q?HL1WXvL3f7HoUKUjrxPYt5PME8RQRnq5L/i0rGSpot9F8olPGmbGoRiZI41f?=
 =?us-ascii?Q?9hyIbb9I9yMk1mM7iat+XqViexa7vIUDTIDEu3L2yjldQbI880qk9jizwD+4?=
 =?us-ascii?Q?AxrUlx46SyBqN3FPJ0nMzstOgdxLkSMyJLtcnqd+nkCO5zAzBuC0IpHrF06h?=
 =?us-ascii?Q?2QPbtzqprKjzRqN7DB2zG03NvpmerxGXfrjdFY+dbU0GvUaZmDaA6LF59gEk?=
 =?us-ascii?Q?UpCeSTZ+pOc78L4VO9KVd+0xkPV/Aw9WMZZk49z0nkn22v2jhAFLG/SPsUbw?=
 =?us-ascii?Q?UoYvNXgjeIoGuo97qbOfiesKbepQPry8cCZo3B9wyyQBRDnNH2a1fbuNpN2s?=
 =?us-ascii?Q?I/0Jpb1FqojgFW7lFQ/u6DiE1zWuxGmpHDAIMoKMiH6O166N2+PNttTTeuh7?=
 =?us-ascii?Q?wBqUlN6SFVH7AOlt3Sla6U+yUrM6IlJ7vCZj+jgd6xIIBvmgRv+NGCo03fsm?=
 =?us-ascii?Q?kJz5pxj/mT/Qkb+eeMqEqDt0457bXn8iYgxlFt7oiel9HwYXjOpqxZcdSXXc?=
 =?us-ascii?Q?14vRDLpzcAFhAqHPLV/k+eIpltBEhbHDhbAAifxv9nubjHTKNZQNBIk2lNaB?=
 =?us-ascii?Q?gNlsrke3KRnwh0ZLJrjq9ufp3SGIioEx6XZ86p/I6pwxa3/Ax2c/8xahy4JL?=
 =?us-ascii?Q?EO1yv6MmknoInUiXkK+rq+PCWSR3eAS/9aS9uN3ZaC0/ks5BvNdqRu5RWU5B?=
 =?us-ascii?Q?UotadqYH3huVaBe2M0+kTTejZk1KUaGWp+WOQ0adqLmfET1ahYnSSGfB7kc5?=
 =?us-ascii?Q?Nh7F0kJi8o+O76QySPCSCcGNID9aq3UrMJnRqsQ7txay4cGnxKYpvWbWgsiE?=
 =?us-ascii?Q?6ofzHlX+2ZXxm/uEF00YnQxwj++/FJIWW3uk2p2uKZP9Yit21ey58HPOiWdT?=
 =?us-ascii?Q?5BeA66Lj56UV8s2QDk6tDHFqq4aX5pnSPtx0UB19CfUTSwh23l4L4E3eaL27?=
 =?us-ascii?Q?oi2jleP5oVnGEoQt3yMxgzAA6PR6n5pVJBsSva7S7Wg84T6SICIzj05tcx17?=
 =?us-ascii?Q?zbV8QHVVwINfN9/Nmw4qBBqMub40zuBQaBgshhLC1sj3kBHHsv+jpLpq6mBw?=
 =?us-ascii?Q?zW1LtSCvnegVosGyLyFTQyeBsz5HUBTGA4myEwSWBRFarsZ1rvaryF9f+DN8?=
 =?us-ascii?Q?IFUkuWNV378Nm+x505UMJEOmiej80G3wKZgPVTzgbiljyKqp1JQn/0X+c+E?=
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
X-MS-Exchange-CrossTenant-AuthSource: ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da71135-bb88-4b31-93b1-08dc7a7789c3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 15:55:01.0425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1816

Fixes these in the v2 patch, thanks!

Greg KH:
> Can you wrap your lines at 72 columns like checkpatch asks for?

Greg KH:
> Please don't point to external sites for "more information", include it
here in the changelog text as this is where it is going to live for
"forever", random external sites hosted by others usually have short
lifespans.

________________________________________
From: Greg KH <gregkh@linuxfoundation.org>
Sent: Wednesday, May 22, 2024 22:47
To: Roland Xu
Cc: ojeda@kernel.org; boqun.feng@gmail.com; rust-for-linux@vger.kernel.org;=
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: kernel: make impl_has_work compatible with more =
complex generics

On Wed, May 22, 2024 at 09:16:33PM +0800, Roland Xu wrote:
> Make the impl_has_work macro compatible with more complex generics such a=
s lifetimes and const generic arguments.

Can you wrap your lines at 72 columns like checkpatch asks for?

> See more in https://github.com/Rust-for-Linux/linux/issues/1077

Please don't point to external sites for "more information", include it
here in the changelog text as this is where it is going to live for
"forever", random external sites hosted by others usually have short
lifespans.

thanks,

greg k-h

