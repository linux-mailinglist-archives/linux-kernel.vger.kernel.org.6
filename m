Return-Path: <linux-kernel+bounces-235134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FB691D090
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD2D1F21D0B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED59442045;
	Sun, 30 Jun 2024 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T4XAwoAT"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazolkn19010004.outbound.protection.outlook.com [52.103.38.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC753AC
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.38.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719736306; cv=fail; b=c4xkDn3kpprImtw/ua7rijd5y0hOzhikise0eDqkpamv7E0J71smunuV/s/3nOlT8tRrn/a+gML8bbKB465zbnwDFE6xZti5eaE/zuaiyGMt+Fh+Fr4JYtTIWEK+/cICYs9YM5ix2+68TmFRCX55FXhFGa3tzk/yxpFE+lZxjpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719736306; c=relaxed/simple;
	bh=s7uXXyEEohwHT0elQa7sGFIoU98edapm40tF3qsBqZU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YmdrlrOIyeYNw/fbPsOkMbC8tkeuyHj+lylfzdkZglhh4kDj2SSl8qiMr93aPX7fg+k/48kvf4O/8U8DREmVHHS0NZTclY97ECkXU9mhEZ1DRkQyqwUBlyQCL55RjKILwq5xwNfMVNwofxNQoZ/XAvmz0eq4K2ChxAuBfX2e9oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T4XAwoAT; arc=fail smtp.client-ip=52.103.38.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nod7Aw7070ElkvJelGcq38OQcTpw7Ebx3vX/i6/AHdzmhORRCaveRWyZJNEdXq33iwtWbbJb3HUEgn4tDfdd58/fXAte/TnoBfDQteJSisS0Zk0p9zHw5r7tiKFTtbNcIZIwlff3IhbKvwNn8PvfhWEdSD6MqPu9xs72u/1BUFzqIz63fU5/dSQ5JKirOMKZnJ6Txx1VA4XlWgAemzu58GbgXlF0BvgxJamQTIgAw3XVBOIcvJrgH4Rh2yudg5n5TWm1d06+fMhJJC/8Jroeq+UQ44NRfvKm/07Z3aZMZNlB5PyunYqPWVuXsbKeiFDIbmuvTJt9DW9ob0qZwl6Ktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7uXXyEEohwHT0elQa7sGFIoU98edapm40tF3qsBqZU=;
 b=GNBAdFPxwykj+dSt4bbQGgELUmwE2uC1Uzmm/x1govufW1c/pIGrYulBwXM6nkeXH9VVmN8Ihv8qAvm/Gl2M5MXxDkKaWUoSkytV6EKXfkgs9XYY/E0U4/nt1a5ctKVw6Pl2Kji4aAThR6SU6DUYesT82ApqIIONCBFPB1+JRq03jHEnhPNhtW5+//z+cUNKY3nfWOgAqidwgOuKoo2+KbgSl4e6x+aQjv6jYfduih12UKXdoRYeEvkc98TZWzUcxf4T+pLiWJQmM0yWnsvyULnOrBuBvipM+R9kh18//mcI3WQwvDCJkx6AFfLyLdr8kEI9UtzBqwCQfMXO7wM0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7uXXyEEohwHT0elQa7sGFIoU98edapm40tF3qsBqZU=;
 b=T4XAwoATcNe77mtCXUArsso6id+a2Cah13C8LIgmemCje2DoDdUC4TAYvF6qE+Mle5m+kLj7VRjboeibl/Rr1lmVeJ7Gig4ul3Fsd0S7j12f5bBCAOWSDHGxJIkiZsuLG39XAyyCVawI1OZHB6Gr0iBw04Ha41mQ6pMonYNmKn+Bk4slbHpHgK/PxpOebGQuAECA1Txq6OlqSc76mzaSHADqOyVpwELAgftopuk9xEWUEYEkZUF4mAeXzK3xAzcH45PYbEL+2Je3rgz4tkUFjhnMggOSIKKsuNUvbHVTy9wcyY87fid5gZvbGwvzrhGsc/jeb395HI9HFfaa8OtfpA==
Received: from CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1da::7)
 by LO2P265MB3513.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 08:31:42 +0000
Received: from CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a912:f233:4847:e806]) by CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a912:f233:4847:e806%5]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 08:31:42 +0000
Message-ID:
 <CWLP265MB65161FE430650BBAB28F1885FDD22@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v3] Staging: rtl8192e: rtllib_rx: fix alignment
From: Yusef Aslam <yuzi54780@outlook.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>, Bagas Sanjaya
	 <bagasdotme@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Greg KH
	 <gregkh@linuxfoundation.org>
Date: Sun, 30 Jun 2024 09:31:41 +0100
In-Reply-To: <43cae9ee-e05e-4447-a62d-eac8307e9670@gmail.com>
References:
 <CWLP265MB65165E806F938F87CB67BF87FDD62@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
	 <2024062727-diabolic-lusty-7baf@gregkh>
	 <CWLP265MB6516AB499D407C0AB0CF106EFDD72@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
	 <ZoCeul3pAjZLOT8E@archie.me>
	 <43cae9ee-e05e-4447-a62d-eac8307e9670@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
X-TMN: [cgVhzp2Tv25La3JLusoNG0qBwsxnm/qv]
X-ClientProxiedBy: LO4P123CA0297.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::14) To CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1da::7)
X-Microsoft-Original-Message-ID:
 <28145002862684f66323b5a3e252ea37f4166aaf.camel@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6516:EE_|LO2P265MB3513:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8a6dc5-d4c6-4fb3-b0ab-08dc98df1190
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	ZSjwLbkI/NPpx+axms+3yG8pkrCIIKgij81HIKZ/U/OMngm+4YoGMdCiwLy6950LDSfxdL9F+Xy/N8X4ExE/D7q2atF8Ph65sbnL1wcVNAgXgeGUuSRUz9YtI/H2qa64lfG6++KTXAVui5uokKyFnLxpoYyxJgjr14Wf0eIcMBfen3bur/GjZxWcMYtU/H030z4bxtITEQm7m1SRf3NdVZJ9V839rxN3Nt4vEW96xCtXhdOw0aqyK5GNx5GFa1Jp+eWP9Lg8xsK6QheD7wW/78cwbHS31LeLwZlQIM3J7cgK3H4pOI0UMV2DwDFrGrMqpX2KNp0+mTomuqbKz5k66GpM3zo9Iz/xnDKiCprXNFZ36RvQNgLaD1GLxkDk0IPlFghfL3htTS1YKfAtqAmD5rj/krY7SXFtUSl/veA/fQl9C6vAbIsn5Az+ibZzath6JuKcGNiOglCFC1uuBwe1Iup/NE3iFNVTpsoNwrvWUuqTevGpas5XbmPoJwWn9UYtTHsZWMmIjBdYn2jQQ/V5KPdDId6UjuQQvvp3PGxu0IoYQwgvTRXevkQIb1W+pxauRyc2MtKJDaRM0KH8439X1VC/oP36t0HomJbxiF9n3Tv8InvA78cBXLHK6QNmK9XK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3BJR1NPRlVKYlRWd25DV2haalA4aE1vOTBUdTNVUC9JN3ZORTQyNkgwcERy?=
 =?utf-8?B?Qzl0VE1RRDk0em9mUC93bnliMkE0aCtvK3E1NVRlT1lBczRvNDJ6ci9wbjdM?=
 =?utf-8?B?L2ZWSnJhRVNMQnk2SEFkMG4vRVBCcGg1eFFsWTZDOGZ2dGpEVitobU9sMjJh?=
 =?utf-8?B?cU42dHcyRTE5aS9LOEZnNFFnSW5YSFFOL3YreG1yR09uV2E1YU0vZ2F5SWd3?=
 =?utf-8?B?K2s4MXNDdHpQd2hwVktmdlNmamZ1RTExYTZQeEFHbTMybWhKUTk3anNvTTlq?=
 =?utf-8?B?YkZaOWxZOUxhRndqRFYwdGVmdHBzUFFQMTA0ZjczSDNaMkdjYlpVd21GaWZH?=
 =?utf-8?B?NEp3N1FCOTM0QXpRME1tbjJCMTRrOUUwUE5yZ2pJdjZ0Z1VteU9PL1BsOUtN?=
 =?utf-8?B?WmdJS2JIek9PSzJ6WmpQR25sT1V4MTB5aWpaa09vVGxsMktCZnNLUld1Y0tV?=
 =?utf-8?B?MGVQSTFWaUFRcUZUcGUzVHh1a0FUNjlJMzNGaGFEVnh4ZWU4d0pSVDFmVzh4?=
 =?utf-8?B?WFNHbVVIZTllVVhXQjErQTZVMUkreXR3SHNVNjNDdmRxeUd0dm1OZHA5a1ZU?=
 =?utf-8?B?U3RjNWZjdGNDWjNyL3o1TjVibGJZZVVyYmtJYjRiUG9JSXRLN2xoRVFnbU1N?=
 =?utf-8?B?OUgyOXJkQ2ZQcktVUW81N2VyVCtMNUU0bnZKb3YxanVoWXRLdGoyU2tIV2pH?=
 =?utf-8?B?VlNQNVNwUHU2QVl1WDNzZHV3RjZON3dwMlNOenY1aVNVenlYRmQ4SDU1K045?=
 =?utf-8?B?SysyUFBJRU85UVg5K3RrWDU2MUtJQXpvWE9hUWd1M3l3TGQ5UDdtL2dhUkRH?=
 =?utf-8?B?TjBXWGxCbWE4VFQxY1oreWg1UUEwbGZCei8vNFllOERaUEZiZXNVNUtVb1BE?=
 =?utf-8?B?U0dsb2ovOWxKVEtHUytkNDl3S0VHR2t4K3hwcndiOThjVUpwaWxlczd5ZUl6?=
 =?utf-8?B?Yk1pZk5PdVVkUm1BVHB4SjA2YkRaSVRXWDJOdTQ4VFdZOGtRcFlZN1MxRFdY?=
 =?utf-8?B?WGFCeDlXbFhpNThXMm9ZelVpVmZXL0JJVVpUemdEQmZvSmZ1aUhYdGJmdHlQ?=
 =?utf-8?B?a3MzMnhnRlFjMFI0T3lDNGRyVVdoNFNYcjFoa1dwTmpWaVhIN0Q3TWFzN2lS?=
 =?utf-8?B?ZmlkUkZBYk5vbUwyWmZHTFZmQUhYSCtkWWowOS9vRms4b2YwV1FnOEh4aWJC?=
 =?utf-8?B?N3N5dGw5ZmRuRHpibEZJZFhscjJXSjZwa2x6QUthRmo1dzFNWXN3WDllTXlC?=
 =?utf-8?B?RVJCaFhWSEY5TzF6U3Vqb2hsUFFLK2hMSXBkckF0aGZQeHowcXdmVHpUdTZ5?=
 =?utf-8?B?V09OQlZEOTFCVzNUZ25mWDBWRzdzUVZYU2NnaXFoVHV2U2ZmOEFNQ296U0Mv?=
 =?utf-8?B?YW1aMHhkaTM4RHFaTGsvN1BsbWZTSGdDanhrQm9CZ2U5ZUs2TG1UVmVoekNm?=
 =?utf-8?B?dkJrT1dkU2pWeVlqcy92L1greC9iSEdaMTNtdmFvcVQ1cHl0QWVEWnRTVDJ1?=
 =?utf-8?B?QzdDbFpUYVhEUWVvc1hTVGtwZktLUFZwOTNGTzByQUh6UFl3dkRxdEZWQ29W?=
 =?utf-8?B?OCtsR3prWGFqcTJoeGhHbUxBT1pTeG9FOEJ1SkM3ZlkvS1FJOGYvWmRUa1Rp?=
 =?utf-8?Q?cGitXqGWTzgoSSOMsZAPbg4QjlnD0aAIt2Ni/lQGwOyQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8a6dc5-d4c6-4fb3-b0ab-08dc98df1190
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 08:31:42.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3513

Philipp Hortmann <philipp.g.hortmann@gmail.com> writes:

> On 6/30/24 01:54, Bagas Sanjaya wrote:
>> Authentication issues?
>> Confused...
>>=20
>
> Hi Yusef,

Hi.

> I use gmail. There I have 2-factor authentication enabled. I am
sending my patches in via mutt. To be able to use mutt I have to create
a app-password especially for mutt. I have no clue if you need to do
something similar for outlook.com. I recommend to use gmail for sending
in patches.

I was having issues like:
msmtp: envelope from address yaslam not accepted by the server
msmtp: server message: 501 5.1.7 Invalid address
msmtp: could not send mail (account outlook from
/home/yaslam/.config/msmtp/config)

Even though everything in the msmtp config file was correct.

I created an app password for outlook and used that in msmtp, but it
still didn't work and from what I have read outlook is phasing out app
passwords so using msmtp with outlook will be impossible. What did work
though is not using msmtp and setting the SMTP server and password
directly in the .gitconfig . But as I mentioned outlook is phasing out
app passwords so this will not be possible aswell.

But when I sent using my gmail account through msmtp it worked
perfectly. So I think I will use my gmail address from now on to send
to the mailing list.

My GMail address is: yaslam0x1@gmail.com

> Feel free to write to me directly for further questions.

Ok, thank you.

> Bye Philipp


