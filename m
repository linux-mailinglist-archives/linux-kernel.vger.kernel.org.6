Return-Path: <linux-kernel+bounces-570026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE0A6AAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3E8188280B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB4F1EC01E;
	Thu, 20 Mar 2025 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BTHKoTS4"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010005.outbound.protection.outlook.com [52.103.11.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED853363
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487820; cv=fail; b=k8zp2mJUJ0voyUIX1XzYqjDV915DK/B6t4FiMhDlh9o0b+hLjYAXOdGonIo/0NLo/PBPciGDO/h8gulv0E7/rT36z/4HU6GFU2VyuV5ibgyMMNxdfE+ghl/jz4aagdxU0Gj837pNIbPOZLoe4EtbgMSpjnNUYqIr6RfX0JLBJ4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487820; c=relaxed/simple;
	bh=+X1WTSpU+lSVViXv97+BRTzxG19qSWuNgtPxO/d3YFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZbXLReYic6zmClOeqeOO8obrxPSx8cnX/hCeFwLMxZzdi4TFRAoAlDbK6xUQu2mKpmBmf4wXUd2Tcv+gsmM9nmmxoTzvYkQySGX1XWY/eg4uHs/yzIGX3fyyMCtOnKFubPU5mq97RkZU0NBLGE2ybQDaZH7hd78+Y59f+698Z90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BTHKoTS4; arc=fail smtp.client-ip=52.103.11.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6GZaPWYcHzE8rTSEmMXeCS07W4Dimfq7l5Ttb9ykfdcwtpVbpGQ/VkXFXFfXjlFfMY0cqaCFo5FUllHrbu87e1LSyHaJhOh3nno8uKD4lPhV6v2eT8gz7i2eREiIpfQ3WG7+bboMm/MmKsxsXKmANqWr8vR8acjT2qMcJEZuMBFwxCWB0FbyNiwjUQGTUQTs/AIW9o/9jc8GxlKYvXu4GxhTzCrA0sfKIXvikVWdaDg8u6xk85JPhMk6PjnnCAjEsR8hEU+RJZrc9UXMyjJmVncrGU7wTHkgIwR7yrvVtZWOaMbD7gSVgSKM0ndjCMrYUZ/iZiplSvZHNvmdffGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HU/TziOhNsaoPx4iBphWfHqUYrFSi0wCuSjpHzdKVE=;
 b=gJNUKJepZa3vZFkCcBoLpZcpQ4nos9Jx5ie32o9pc+l4IT7smd2pt937ZRPEZCAIHYG72Du3DzyDY/8ZOl9R6RUaHtUrl3FVU2PSBhZAGYUdrPi/dFFk8Vg818FxqxlTrAPFX66q/ZLnFF0eUPmRLqybEy5haQh7PgS6/UzcyaisGYHyoQTLTsM1et2rDX2zgFTWjX/NkVmhs45mZfcCLq0wazb/XMqdHWHRmYyBOc2kftP7qE1ifKvDm/OtJfxin8WRWZCGCIIFzwxMBbRYk9sVJE21kvGEqJ+NMPDsC4t2hJL9PTW2pC5o6s3wjnQ3Z6luSsI2pKn8PESPnIRWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HU/TziOhNsaoPx4iBphWfHqUYrFSi0wCuSjpHzdKVE=;
 b=BTHKoTS4mxotnlpo0TxwEVnOyKDB/duaHQ6Kecjcm8y+OdvD1IavwjCcKGQrDXcko/aYgtD186Rd0ETFn5lx8MfBbFuRsuPzd+VO361fKHOVxscxTK3pre2SxGfJAE4U895cXsrMntKPHiyhNqkEeKFlKh8MYXLl510hTdxdKlyukstFFMWp2615yRknEdqRdp3fCufbzmngClN1adPmswL+nqsZ/cFZlh7Hy+gSh+/ok++UtViQOcXukCKdt3aP0iH1piv+Sn98ujA5RQV+9p/PXlz3bkJsFUdFY/TmGJcQ6if/s2DMCFJVjR8b/FUtwMGyP6nI6OidE8eiZUnSgw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8516.namprd02.prod.outlook.com (2603:10b6:a03:3fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:23:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 16:23:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)"
	<xin@zytor.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar
	<mingo@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [tip: x86/core] x86/cpufeatures: Generate the
 <asm/cpufeaturemasks.h> header based on build config
Thread-Topic: [tip: x86/core] x86/cpufeatures: Generate the
 <asm/cpufeaturemasks.h> header based on build config
Thread-Index: AQHbmL/tCQztYwdxdkmEec0xfywcqbN8L4iw
Date: Thu, 20 Mar 2025 16:23:33 +0000
Message-ID:
 <SN6PR02MB415756D1829740F6E8AC11D1D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250305184725.3341760-3-xin@zytor.com>
 <174238223959.14745.6970497940010271580.tip-bot2@tip-bot2>
In-Reply-To: <174238223959.14745.6970497940010271580.tip-bot2@tip-bot2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8516:EE_
x-ms-office365-filtering-correlation-id: 18d061dc-322a-4800-151f-08dd67cb8f1c
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|8062599003|15080799006|461199028|12091999003|1602099012|10035399004|440099028|102099032|4302099013|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Z6FxgySa3f18dpCee5+UJjgQtF4n1gjnnHbQJ22hcIjl097Tzn15OkVsMW+n?=
 =?us-ascii?Q?7moHH4mXXJ6jqvCwWvYUlZEGWb8R20TOOB0tGQfjN3AmgQh6IzEqUif9FYQ2?=
 =?us-ascii?Q?bEgtbXvXXVvkc6TCggDhNRCKGE8v8dBEdokIqmQFCcCXOXsHDF0d4k5oiTAi?=
 =?us-ascii?Q?4dy68G6SurMG5VsJd+DGLnDFO0+w5D5/cprek7c3gt7wBBLly6VwyrWusUGA?=
 =?us-ascii?Q?LlfxBEY9T42nHQ4GVL+2I3wZQ/540ecsgxKvr90HYdE5YESPdXUaJz3wK60/?=
 =?us-ascii?Q?japH6wxEz8nDmRNxh/mVp7plyGPa4fBC8Acdq8NpFOD+kU+Y4LXz0swlKo5+?=
 =?us-ascii?Q?7bEn6qe5aDRg0UBT/F8G6FPS6VSUbFU9DePIXXb4ON59DJLXyF2Xxe8Vqohy?=
 =?us-ascii?Q?G0capMDjI4Hz9Jj3/4IoMAOimx4zSV4wjeDoX38zflufaUEmB7z3LKTjgD0Q?=
 =?us-ascii?Q?24hGwJCFOmAGUpaE7EbvwUFkDQQJ+NeqXy8Iu+CrAyqKhHprqAgUPA7a1TUH?=
 =?us-ascii?Q?ZI8BnoyCxht1TtL2z+yhRb2DACyeBX25+F/Ds+5Ys+h2gF0Byei/L8VeC4/g?=
 =?us-ascii?Q?v/EsFEnvQPlcVjA8wLmEjLd84lnT2ZODPpO0Y5KNMlrBjS5xotNmuxZ94Clv?=
 =?us-ascii?Q?xaIW0ipsuU35JFw5C6ssrwx4PQpCLQzeKxczmZ5OG347vePxq4L0tQKnkoNe?=
 =?us-ascii?Q?I/nD+jMjNcQ/dwzLlzAEEAuH9f5X4fT8865/L20D4eQbLaMfbi2/l7dst+wt?=
 =?us-ascii?Q?pCwG4/fBoEzWpk4U4RfAa4JI7Pt+M3wk8hNanPE/6Pa7RIgDdwkuaHZQaPON?=
 =?us-ascii?Q?GgCFk6zSG3a8Z+hfJUJk5oeOL7EzLJlGTCdkiJR2iMJg+/EW94tRcqgQdDTb?=
 =?us-ascii?Q?lXm2IWFyGFLFJGPq20p/9UTpun+kL24XESkJtCfudncX1LlsyithSpbVoRDI?=
 =?us-ascii?Q?NyN1aPKWuV6iph1arHKFJYeuUJ/ZRx/cBvAwuvgS6nRZbGQpVjzcfUcHvAki?=
 =?us-ascii?Q?+t9BfLUGr/Cs9L4XrfDnDKslEPqYMKbaJB6FhhWuwcgTZGmMVyqvJ1QESEOa?=
 =?us-ascii?Q?Jq+vP9xwZ2X4FFk7WwjE+Kd0geTnEm6ce5OdLkA/ff1UrETM0M6B98UgRDNd?=
 =?us-ascii?Q?ye5KXtUjO59VaM0GZN56xSo4ompo4cwhTj1eHFINi5VMRdN5ioG7Ryt79ID1?=
 =?us-ascii?Q?QA8g/di6WHQKZGVfGGwIJePGiNb4zBdC/ukpawOWezSu/QlKCuBo5hj45Qk?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yg/4DaBTtItwvAFIPdwsc8oQoIUpa9H0WYJsfZxY1oGWDLRDNy7wDQCyGgje?=
 =?us-ascii?Q?qVt1Wh7N77mDi3Qn6LiPWZnnALYeglGCqvThMdMl7weHC7mv+FISSkLkTJpe?=
 =?us-ascii?Q?v7judPI90D2UybmuRKBoDULpt1hCCwUDVJexQTHOeL6zpJfVQrXPcUP/xDdL?=
 =?us-ascii?Q?gjybwHDp2xqTX5cq3Ko2Y4Cr6VpVAD2Q9mEAXC42QUbGDm420AdJCicPOHEK?=
 =?us-ascii?Q?h8RpXUa6Htra17pqnYwXhaVFwRIt1cWwJZjTD5Sf10MxvkLGt52qzJOOU4st?=
 =?us-ascii?Q?oUMtNMgkvODnnHSeAM5pp7qPTUOidM4APdHk0+Xy4fu0GYvLOKHuEiy97bzZ?=
 =?us-ascii?Q?F0cXakfPv3FhkQpHNpBP+GIG0Otm4ncvtWIdlpB+/frukbm2UhNPp1zDyAjX?=
 =?us-ascii?Q?9LBmx2Yxo0TIByL7H5Ty/2uNtBM2VYVTyreRZnVGrxaTmySy7ZKfWNA8aHi+?=
 =?us-ascii?Q?qA4iXjMn5+Y9egrhrcp0G3oaOTRXXABR/q8B/hO8xfzHppOJscD9YL9DksJm?=
 =?us-ascii?Q?gXx7RsH16PYzzcwm2lNIBLTu3/GMRKQFcrGNNyum0D11LCNTUJ7wzcyByYM9?=
 =?us-ascii?Q?5hl+tSNlK9r3HbhHtBmL8UDVS0OkRfn3NZZ7Qy+fcI+vZBIBWk2D0xDo0aVt?=
 =?us-ascii?Q?Akgwy0F/DJIabWINNPsNOzTqx/g6HAtID4ITkC+avNrtDvW3YPM+/B4dTd5p?=
 =?us-ascii?Q?0WcHqF8Tx2kgEFzIBRnZ9q4MsJ+zKdLMf4A+VQibdpzQ7fP9pmejXHjjEvsp?=
 =?us-ascii?Q?iYltJ6xuJtdFI6yH7Pt8/LUkYz/51t+H+kmnT9WfWe1uz3EjiLR36F6v6yeh?=
 =?us-ascii?Q?69cGTReDsRS2BzWeTW0cRPPGXcOAb41H9lUnK2IlqJ/tbWY0JwQTPUWNNrIp?=
 =?us-ascii?Q?YfDTnDdpDzucvonuov49+U5e66N1wpaVUmKvYeMFOE562Fi7aMDKowlyhr6k?=
 =?us-ascii?Q?nNRjYxo9elhYcwIj8JLBCzOGND7AkweASGxteCMpCYIjjm1BmV8VZ2qqZirX?=
 =?us-ascii?Q?iS4miLPVG5ZIWrGn75eUIywSEkMFt0VLdq5Wz11a1jk/t025Za80QIHrqrsn?=
 =?us-ascii?Q?z/UczPhWsrbYJQeGh5rIQU2h63P+BYrEvcud3aqzvX3hlydWEQ76QEXKEJYt?=
 =?us-ascii?Q?HwunRbDv/UmNzAjs5aIanM5qUB+iLysHRP1X5jAt+KPldWV4SLPFjSEArmSM?=
 =?us-ascii?Q?DY8aL8ikCtm36DarpBQ9sVQGbV0JXGkxMPP0WX1TcuZifFrHNSBfIMFWKAc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d061dc-322a-4800-151f-08dd67cb8f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 16:23:33.3415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8516

From: tip-bot2@linutronix.de <tip-bot2@linutronix.de> Sent: Wednesday, Marc=
h 19, 2025 4:04 AM
>=20
> The following commit has been merged into the x86/core branch of tip:
>=20
> Commit-ID:     841326332bcb13ae4e6cd456350bf566a402b45e
> Gitweb: https://lore.kernel.org/all/20250305184725.3341760-3-xin@zytor.co=
m/=20
> Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
> AuthorDate:    Wed, 05 Mar 2025 10:47:22 -08:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 19 Mar 2025 11:15:11 +01:00
>=20
> x86/cpufeatures: Generate the <asm/cpufeaturemasks.h> header based on bui=
ld config

This commit is producing a subtle change in build behavior, as seen in linu=
x-next.

In the current behavior, assume the kernel has been fully built. Then if no=
thing
is changed but the modified time on the .config file (and the contents of .=
config
are unchanged), a new build runs

    SYNC    include/config/auto.conf.cmd

and figures out that nothing has changed, so it does nothing.

With this commit, changing the modified time on .config causes cpufeaturema=
sks.h
to be rebuilt, and then all dependencies on cpufeaturemasks.h are also rebu=
ilt. It
doesn't figure out that nothing has changed in .config. A fair amount of
unnecessary rebuilding is done.

I'm seeing this changed behavior specifically with the make-kpkg script on
Ubuntu 20.04. It's not clear why make-kpkg is updating the modified time
on .config, but prior to this commit, that update had no negative effect.

I don't know if anything can be done about this change in behavior, as
Makefiles and build dependencies aren't my expertise. But I wanted to
point out what's happening.

Michael

>=20
> Introduce an AWK script to auto-generate the <asm/cpufeaturemasks.h> head=
er
> with required and disabled feature masks based on <asm/cpufeatures.h>
> and the current build config.
>=20
> Thus for any CPU feature with a build config, e.g., X86_FRED, simply add:
>=20
>   config X86_DISABLED_FEATURE_FRED
> 	def_bool y
> 	depends on !X86_FRED
>=20
> to arch/x86/Kconfig.cpufeatures, instead of adding a conditional CPU
> feature disable flag, e.g., DISABLE_FRED.
>=20
> Lastly, the generated required and disabled feature masks will be added t=
o
> their corresponding feature masks for this particular compile-time
> configuration.
>=20
>   [ Xin: build integration improvements ]
>   [ mingo: Improved changelog and comments ]
>=20
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Link:
> https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.k=
ernel.org%2
> Fr%2F20250305184725.3341760-3-
> xin%40zytor.com&data=3D05%7C02%7C%7C6243cf4a3cb84dbe135208dd66d70d34%7C84
> df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C638779796029571293%7CUnknown%
> 7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMi
> IsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DTSpia2XulsyZ%2BwN=
qB
> 2tdp66Z4hbaojEHgZ0x%2BUi2OF8%3D&reserved=3D0
> ---
>  arch/x86/Makefile                  | 15 +++++-
>  arch/x86/boot/cpucheck.c           |  3 +-
>  arch/x86/boot/cpuflags.c           |  1 +-
>  arch/x86/boot/mkcpustr.c           |  3 +-
>  arch/x86/include/asm/Kbuild        |  1 +-
>  arch/x86/include/asm/cpufeature.h  |  1 +-
>  arch/x86/include/asm/cpufeatures.h |  8 +---
>  arch/x86/kernel/verify_cpu.S       |  4 +-
>  arch/x86/tools/cpufeaturemasks.awk | 81 +++++++++++++++++++++++++++++-
>  9 files changed, 105 insertions(+), 12 deletions(-)
>  create mode 100755 arch/x86/tools/cpufeaturemasks.awk
>=20
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 6784129..a607769 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -269,6 +269,21 @@ archheaders:
>  	$(Q)$(MAKE) $(build)=3Darch/x86/entry/syscalls all
>=20
>  ###
> +# <asm/cpufeaturemasks.h> header generation
> +
> +cpufeaturemasks.hdr :=3D arch/x86/include/generated/asm/cpufeaturemasks.=
h
> +cpufeaturemasks.awk :=3D $(srctree)/arch/x86/tools/cpufeaturemasks.awk
> +cpufeatures_hdr :=3D $(srctree)/arch/x86/include/asm/cpufeatures.h
> +targets +=3D $(cpufeaturemasks.hdr)
> +quiet_cmd_gen_featuremasks =3D GEN     $@
> +      cmd_gen_featuremasks =3D $(AWK) -f $(cpufeaturemasks.awk) $(cpufea=
tures_hdr)
> $(KCONFIG_CONFIG) > $@
> +
> +$(cpufeaturemasks.hdr): $(cpufeaturemasks.awk) $(cpufeatures_hdr)
> $(KCONFIG_CONFIG) FORCE
> +	$(shell mkdir -p $(dir $@))
> +	$(call if_changed,gen_featuremasks)
> +archprepare: $(cpufeaturemasks.hdr)
> +
> +###
>  # Kernel objects
>=20
>  libs-y  +=3D arch/x86/lib/
> diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
> index 0aae4d4..f82de8d 100644
> --- a/arch/x86/boot/cpucheck.c
> +++ b/arch/x86/boot/cpucheck.c
> @@ -22,10 +22,11 @@
>  # include "boot.h"
>  #endif
>  #include <linux/types.h>
> +#include <asm/cpufeaturemasks.h>
>  #include <asm/intel-family.h>
>  #include <asm/processor-flags.h>
> -#include <asm/required-features.h>
>  #include <asm/msr-index.h>
> +
>  #include "string.h"
>  #include "msr.h"
>=20
> diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
> index d75237b..0cabdac 100644
> --- a/arch/x86/boot/cpuflags.c
> +++ b/arch/x86/boot/cpuflags.c
> @@ -3,7 +3,6 @@
>  #include "bitops.h"
>=20
>  #include <asm/processor-flags.h>
> -#include <asm/required-features.h>
>  #include <asm/msr-index.h>
>  #include "cpuflags.h"
>=20
> diff --git a/arch/x86/boot/mkcpustr.c b/arch/x86/boot/mkcpustr.c
> index da0ccc5..22d730b 100644
> --- a/arch/x86/boot/mkcpustr.c
> +++ b/arch/x86/boot/mkcpustr.c
> @@ -12,8 +12,6 @@
>=20
>  #include <stdio.h>
>=20
> -#include "../include/asm/required-features.h"
> -#include "../include/asm/disabled-features.h"
>  #include "../include/asm/cpufeatures.h"
>  #include "../include/asm/vmxfeatures.h"
>  #include "../kernel/cpu/capflags.c"
> @@ -23,6 +21,7 @@ int main(void)
>  	int i, j;
>  	const char *str;
>=20
> +	printf("#include <asm/cpufeaturemasks.h>\n\n");
>  	printf("static const char x86_cap_strs[] =3D\n");
>=20
>  	for (i =3D 0; i < NCAPINTS; i++) {
> diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
> index 58f4dde..4566000 100644
> --- a/arch/x86/include/asm/Kbuild
> +++ b/arch/x86/include/asm/Kbuild
> @@ -8,6 +8,7 @@ generated-y +=3D syscalls_x32.h
>  generated-y +=3D unistd_32_ia32.h
>  generated-y +=3D unistd_64_x32.h
>  generated-y +=3D xen-hypercalls.h
> +generated-y +=3D cpufeaturemasks.h
>=20
>  generic-y +=3D early_ioremap.h
>  generic-y +=3D fprobe.h
> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpu=
feature.h
> index e955da3..d54db88 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -9,6 +9,7 @@
>  #include <asm/asm.h>
>  #include <linux/bitops.h>
>  #include <asm/alternative.h>
> +#include <asm/cpufeaturemasks.h>
>=20
>  enum cpuid_leafs
>  {
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index 8770dc1..c0462be 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -2,14 +2,6 @@
>  #ifndef _ASM_X86_CPUFEATURES_H
>  #define _ASM_X86_CPUFEATURES_H
>=20
> -#ifndef _ASM_X86_REQUIRED_FEATURES_H
> -#include <asm/required-features.h>
> -#endif
> -
> -#ifndef _ASM_X86_DISABLED_FEATURES_H
> -#include <asm/disabled-features.h>
> -#endif
> -
>  /*
>   * Defines x86 CPU feature bits
>   */
> diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
> index 1258a58..37ad437 100644
> --- a/arch/x86/kernel/verify_cpu.S
> +++ b/arch/x86/kernel/verify_cpu.S
> @@ -29,8 +29,12 @@
>   */
>=20
>  #include <asm/cpufeatures.h>
> +#include <asm/cpufeaturemasks.h>
>  #include <asm/msr-index.h>
>=20
> +#define SSE_MASK	\
> +	(REQUIRED_MASK0 & ((1<<(X86_FEATURE_XMM & 31)) |
> (1<<(X86_FEATURE_XMM2 & 31))))
> +
>  SYM_FUNC_START_LOCAL(verify_cpu)
>  	pushf				# Save caller passed flags
>  	push	$0			# Kill any dangerous flags
> diff --git a/arch/x86/tools/cpufeaturemasks.awk
> b/arch/x86/tools/cpufeaturemasks.awk
> new file mode 100755
> index 0000000..59757ca
> --- /dev/null
> +++ b/arch/x86/tools/cpufeaturemasks.awk
> @@ -0,0 +1,81 @@
> +#!/usr/bin/awk
> +#
> +# Convert cpufeatures.h to a list of compile-time masks
> +# Note: this blithely assumes that each word has at least one
> +# feature defined in it; if not, something else is wrong!
> +#
> +
> +BEGIN {
> +	printf "#ifndef _ASM_X86_CPUFEATUREMASKS_H\n";
> +	printf "#define _ASM_X86_CPUFEATUREMASKS_H\n\n";
> +
> +	file =3D 0
> +}
> +
> +FNR =3D=3D 1 {
> +	++file;
> +
> +	# arch/x86/include/asm/cpufeatures.h
> +	if (file =3D=3D 1)
> +		FS =3D "[ \t()*+]+";
> +
> +	# .config
> +	if (file =3D=3D 2)
> +		FS =3D "=3D";
> +}
> +
> +# Create a dictionary of sorts, containing all defined feature bits
> +file =3D=3D 1 && $1 ~ /^#define$/ && $2 ~ /^X86_FEATURE_/ {
> +	nfeat =3D $3 * $4 + $5;
> +	feat =3D $2;
> +	sub(/^X86_FEATURE_/, "", feat);
> +	feats[nfeat] =3D feat;
> +}
> +file =3D=3D 1 && $1 ~ /^#define$/ && $2 =3D=3D "NCAPINTS" {
> +	ncapints =3D int($3);
> +}
> +
> +# Create a dictionary featstat[REQUIRED|DISABLED, FEATURE_NAME] =3D on |=
 off
> +file =3D=3D 2 && $1 ~ /^CONFIG_X86_(REQUIRED|DISABLED)_FEATURE_/ {
> +	on =3D ($2 =3D=3D "y");
> +	if (split($1, fs, "CONFIG_X86_|_FEATURE_") =3D=3D 3)
> +		featstat[fs[2], fs[3]] =3D on;
> +}
> +
> +END {
> +	sets[1] =3D "REQUIRED";
> +	sets[2] =3D "DISABLED";
> +
> +	for (ns in sets) {
> +		s =3D sets[ns];
> +
> +		printf "/*\n";
> +		printf " * %s features:\n", s;
> +		printf " *\n";
> +		fstr =3D "";
> +		for (i =3D 0; i < ncapints; i++) {
> +			mask =3D 0;
> +			for (j =3D 0; j < 32; j++) {
> +				feat =3D feats[i*32 + j];
> +				if (featstat[s, feat]) {
> +					nfstr =3D fstr " " feat;
> +					if (length(nfstr) > 72) {
> +						printf " *   %s\n", fstr;
> +						nfstr =3D " " feat;
> +					}
> +					fstr =3D nfstr;
> +					mask +=3D (2 ^ j);
> +				}
> +			}
> +			masks[i] =3D mask;
> +		}
> +		printf " *   %s\n */\n", fstr;
> +
> +		for (i =3D 0; i < ncapints; i++)
> +			printf "#define %s_MASK%d\t0x%08xU\n", s, i, masks[i];
> +
> +		printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS !=3D
> %d)\n\n", s, ncapints;
> +	}
> +
> +	printf "#endif /* _ASM_X86_CPUFEATUREMASKS_H */\n";
> +}


