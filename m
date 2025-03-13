Return-Path: <linux-kernel+bounces-559307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36083A5F22D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63746178DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCFE1F03E4;
	Thu, 13 Mar 2025 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="cPg2ztc9"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011034.outbound.protection.outlook.com [52.103.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFCA1D7984;
	Thu, 13 Mar 2025 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864723; cv=fail; b=QyLwJXyW3JSR+kLyPQM9dleBsPqdHAX3iZfBxVS0ShC6acizhl7dBooNHRN6AGr4jPyRUCaQ6TpKP/5bwHbmNAEBkzf3mTUyGL0ciZfyHEewaqZdIyjkW/nR1pDdHFM17YjIqU9RNJ3sQRaEtocYPkJ79PPpy1tDt6ghOFhmXEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864723; c=relaxed/simple;
	bh=ZABWzDjYsBICUn01v2WcUSK/f/4L54EJC+9AlwLTEgc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VGn5PrrPUZYog9PVUvuVVDlHajPlvJ4/ECDNGJnvlqt9l8ZuCjo8ZG474nVqzeGhnwfBN5Oikog+fDKKbw1EyA4GNcm8lagLR9hbwsxDFpVui5hhhr8sqKMdIXCpYcphEe2O5Ye7jUhFThdFRFe2Bv/3sRgpKhRZUBldXZFk2r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=cPg2ztc9; arc=fail smtp.client-ip=52.103.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+IEM4apbvzrdSk8h4/BuZBcxd569GVvNhDmi2zUeC9LADmFFkSAc5C6anw5Gpryoo7hAuLDC57J+FJD0Pio88Bs8LObXRezsGTTKfDz5FMMCNMB7cMKstDsLmvN20/SAgBvus0MGrc1xXA5wM1DN1BVJNoDTzbAD2G013evCrg/6vWKQjCdSIpW+E7Q/HtAobA5BVtnjSuPKFtI9CVc57JNcOkaMMQw4RYf3+aeQN9SGyc8F5L13cY6mP7XRCEz0Fvo6Zn7+I+q52lQqwK/1JIgrh4VPCCWVdPaAZl6cE6o9bL+bw1+wGreQN2bXCbA00Mj3etsgckzq0/y3c5o0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MN3m75mpt9gJ+jObw1f7IobYUx5ddvqpWdizzDNSq0k=;
 b=tGijSfRugkQHK0YvpTlhEvwxAAFJ6TBFmIT9ZtC3ce+uNsSZo03v9+CZw35/umAYzrKy4rAfQO59KBnqD5RYmvjjWtVHkdvVWYHisANJ7KAEDH3nrJR7xIniBYK26OtN5kwjc3Y1V1x6/rz9a5J+/LJeEOOyrHNDHzjHEz+eFORoZ6EhL+mRZeqa5Xi0KMalMkHNgpS/MlNY/yUFc86KBhknG/oKwElM6TDs0CubEsH3AgF6mYr7Lmbpb9RBVmSsGU3kvT9z+wRfPqV5S6gHuid4D8wv+BdiJQWhIdHQSqfzap3gu7QxL1pHllv8QIhykJTQrTRo1ZeQ1VfsKywpBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MN3m75mpt9gJ+jObw1f7IobYUx5ddvqpWdizzDNSq0k=;
 b=cPg2ztc9fEBPeWeeDBj00J1GXMZW1pL0v/mh1Ctukg4iVA0qtI9vt8/FLXfanpzeFtTlFMfEcW77DKHy2C7p908u2y6vnWaBOkZmsP+qAPbM/FW7TmOJG9ZqDOpGUixcgu2h/+CJVsfysg2734+MIdio76Fxb8SO37y3TD8B0V7Ar5tsbjBffV0mifs6hCfnkTQItctZpbC68znCq+/buN+ONHp3MmqEZtKNzMrHNPfesnvE3dSSsfkrQOeEsVrxeAPPqzZjRyUS9/NHnE3lWDhnI0fjTAncaPT5WsFu0j5CghO7X23RPCdd3km3R+7WCa4Haj1jUwePRZqA8jD/LQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PPFE52A1FAE5.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a04::331) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 11:18:32 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8534.025; Thu, 13 Mar 2025
 11:18:32 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Petr Mladek <pmladek@suse.com>, "keescook@chromium.org"
	<keescook@chromium.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sven Peter <sven@svenpeter.dev>, Thomas Zimmermann <tzimmermann@suse.de>,
	Aun-Ali Zaidi <admin@kodeit.net>, Maxime Ripard <mripard@kernel.org>,
	"airlied@redhat.com" <airlied@redhat.com>, Simona Vetter <simona@ffwll.ch>,
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	"apw@canonical.com" <apw@canonical.com>, "joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Hector Martin
	<marcan@marcan.st>, Asahi Linux Mailing List <asahi@lists.linux.dev>
Subject: [PATCH v2 0/2] Use proper printk format in appletbdrm
Thread-Topic: [PATCH v2 0/2] Use proper printk format in appletbdrm
Thread-Index: AQHblAmmplIrx6cOXE6tZjVEfKqGxw==
Date: Thu, 13 Mar 2025 11:18:30 +0000
Message-ID: <F61E0F31-980B-4855-9AA8-D594BEEFEC6F@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA1PPFE52A1FAE5:EE_
x-ms-office365-filtering-correlation-id: 1718dba0-01fb-4e49-86f3-08dd6220c932
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|8062599003|5062599005|8060799006|15080799006|7092599003|440099028|10035399004|3412199025|4302099013|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ebY+WoKd9mptYqE/fJt1tHwds3U5YsB3SZVA9klnEEeRIEDoch1K4bwKAf3v?=
 =?us-ascii?Q?7UvftDXf88GsFf7Ro0RTk3JTvzvSIswva55EGkSDq706WQwDzojaQ7hDFDG7?=
 =?us-ascii?Q?n7pcmdBTtI1NHzlIPI8zWrulnsLFvkXw5jHGXVDP4TFdFCq2ajllXnkikZRb?=
 =?us-ascii?Q?KcXbLZM17wfTfT6Bf9TujK7jvZ6vgynH4aDVb3kib57qgt+XUOAaM2pvr9lC?=
 =?us-ascii?Q?3r2Qg/zM47usEMU4nqbVAXGldM/Or6JYAT0tWYsqdewcqYh+3bJ1wCyu3uiJ?=
 =?us-ascii?Q?KZncC8YZBRzfIfogTNdvqniS3Fq/0jpqvYsPALnDqv+r0l01vSu3m2SGqwX9?=
 =?us-ascii?Q?NCWTT/DmkkAucGt5AdgPHA87hSqwVYYdbTrJLaUpKoJbYVnUTKEtxbVuUr6e?=
 =?us-ascii?Q?lE1LdSp1fdinprM3QZh9ycXwy6ptoaegCceJs/PBY7mTO9bHZtWxvW36sp+6?=
 =?us-ascii?Q?RN23GG5AjizewM787vKcui/k7C6WZlQa1Rvdh277hzAp/Mvlwwa6FQLRgqvv?=
 =?us-ascii?Q?xpVw/yBb0TmdXGfL2oOXDAyjHCG0kpoKzf6PpX++l3rUYr8bsvLKAlWYRsWh?=
 =?us-ascii?Q?cjaLWnckIiSsxK4HYLr0rbU2V9EOpKx5dN71AzscsUhRB+kWkARw6GHpvHwB?=
 =?us-ascii?Q?dvHNkVb/c9eZ7flI+t9DUza+n3oxrWsN5DsRqp38pv6bkXSs9AWECwBe08gy?=
 =?us-ascii?Q?PXjx6YVXLf8UD8JNdWYZ3bvf+LtfgHL0Qo3Elfjv0RpcDRFS8oj308qzCnpu?=
 =?us-ascii?Q?VYvNeT5fe06ZmNjp22BF4uK/kntCz7A78f0UUkh9aygDECTKlVLXuA0FAl/g?=
 =?us-ascii?Q?X2gqnZQrA1BLYgo/cyNqJAvWwlDKNym/0ID5SPBp3Kik/iHmiiV5RDDZ6zFm?=
 =?us-ascii?Q?nkFdFrDPNLoNVxdGluer2/KGw8uz+rKSAWuiCSJixBc1nB8uDzePJLVKC/1u?=
 =?us-ascii?Q?tD8l4MNkorXWRoVtbjEbD0HFyzAPFvM6Ug+zyLHGgBsJcNQaIokgJCSgcSTN?=
 =?us-ascii?Q?YGk3E0NHEBk6cP7bmy/T9aNnNOU6Mv4CCe2rzJPHq/zBPBrxQRuo7T0NXdoZ?=
 =?us-ascii?Q?3b5Wo8AQcIJlrr0s3ypHa6xWj2HVkvDc2shVCDnhcfXZFdtYNuSgXs8TOqL/?=
 =?us-ascii?Q?l6LqSHMXoou1lDZ9HFSrdHh3jfjOYC6H2vwUJsVrPhsrmHL1Q1bLrPRoL8+g?=
 =?us-ascii?Q?gR7Q5ushNejGWJQxZEGrIJCItg42OzRGeFOKEuyxpedUQAMYZyVOli44n47Y?=
 =?us-ascii?Q?aPezEVZsaAn032Bk6NTDkohHO3X9T69Ih2Ug+45SAw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R58wi1/QUoyk7cXaEAzdaIlTE2p3RLmScdZdoa7S5MI5rYjMCzfxWJilNrEr?=
 =?us-ascii?Q?d5CeYVrfM81PU/duqEUJ1HGYI/asmSIdKtY2Lxg5x3Ha6XbHVm/F11kqqZdn?=
 =?us-ascii?Q?1ted/8+TAXfRGiT6jjs5qDNUBqqzSXHn+G+AgmgLZm02e/AUGko1aiNEyVtI?=
 =?us-ascii?Q?UGrW+s7OHPkDWc9pi41kI+Cp/L36qiUtCujuVF0Oo8iUbwEOLHGf5jJib6ZI?=
 =?us-ascii?Q?OTnwdZJKOviKc0NjUXxum+CR93oSDTWDQd+4jaoWXJ6rC2cBmy5JUdkW0+lO?=
 =?us-ascii?Q?d1fzRDxbGSGi9XqVkHAbnTEt4Vi9ipOAH3R1FSO8PwIfZkU1XMDHMOW/soQA?=
 =?us-ascii?Q?NUOo2CYKyFc/uh9ltYWG2TG7tnpIpfYCxn9R8tQ9GBhOvoaiR1QcgEC+rqYt?=
 =?us-ascii?Q?jWX2a/0duApCFOovRca2s5KsT19XCGx4Uk7L7PpiKCqr1HhfBf2fpG2rFfq4?=
 =?us-ascii?Q?P/VHLWf01SyGrsdRBcyhxw2y9KGGxsNT+ygrEJBwhOGlEvuq0Ip4bhssdYtw?=
 =?us-ascii?Q?gTY8P291vljpH0bmVYDEEuWXfiihnHrto2mhqquJnXxIzy7qui8GO4KT51Nv?=
 =?us-ascii?Q?1EFG6MK7TaxZ+zOFOmaGb1We6TYbPtN8j8p9+9+YltuKF4d1LTSp1FEF+sLS?=
 =?us-ascii?Q?Hzcjo9fKHttiEJIJol+WWjjEZohuH5lol2LyCdqiZOL59FYJdLEZ8ItLY7s5?=
 =?us-ascii?Q?v7+W73YXMjt9dAALKr2jNTsYQj0ppaEsO7XjP+/ihkdKVdmlhcvPoxKWLjkS?=
 =?us-ascii?Q?daiGAkxfGY8BmCaTayvxP1mOlwjmTfqKMnAc8yeTh3A7Ey04cULuKp3a4TGs?=
 =?us-ascii?Q?CXWI/pTQNcHSguIGvFOlASu4UhV5UaGdSw3RwhrvF4zkuC4gjku9j0hl/D27?=
 =?us-ascii?Q?S2M4B5ooQ0R5iCP+xRWDyQCICzrUOEIdOleol2OV7lfkrLNbu+OJVk5qD+wx?=
 =?us-ascii?Q?vQS/V+KDdm9xiwkW22FhNfM1L+m5+s6RvFse/1CcflEVi7KdPl6s2hJyhFND?=
 =?us-ascii?Q?y6WKZa+afv2Jmlfsx14xV3x7a/aSdtUVWMLIHCBNIwSGJq9UV0H5aPrlStdD?=
 =?us-ascii?Q?xGOLT7LX7Ar6KcChn41b1OiJx6PiGYySo/8c60eiNy5oFMvDC9C56XhuqFik?=
 =?us-ascii?Q?nTSuRIo3mKk0c+xUnMjgCtTpMsr7N0WgjdBh/JV/dgItfj2/lr/8cpq8tkYU?=
 =?us-ascii?Q?jZHxqW9uKMouDmIIkGFZwS4QoqoONRRFmCql8byFLrrm/b7b2frLM4dAKg5F?=
 =?us-ascii?Q?MzlITzsdVmgMoDmM2+jlivghpuoiyELBRdgy+h7/OlzJoBuB46QX0Xeb9ION?=
 =?us-ascii?Q?IsZ46zDuyKt5vw0SLBhmCoJa?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <42A4C100E78E9048AC8BE285CC2BB5BD@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1718dba0-01fb-4e49-86f3-08dd6220c932
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 11:18:30.9863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPFE52A1FAE5

The vsprint patch was originally being sent as a seperate patch [1], and
I was waiting it to be taken up. But since 6.15 merge window is near, a
potential delay between the drm and vsprintf patch might make the vsprint
patch as an unused addition in 6.15. So, I am sending it together. From
what I have observed in LKML, vsprintf patches are being preferred to be
taken upon by trees which are actually using them.

v2:
Remove printf tests, will merge later through Kees' tree

[1]: https://lore.kernel.org/lkml/1A03A5B4-93AC-4307-AE6A-4A4C4B7E9472@live=
.com/

Aditya Garg (1):
  drm/appletbdrm: use %p4cl instead of %p4cc

Hector Martin (1):
  lib/vsprintf: Add support for generic FourCCs by extending %p4cc

 Documentation/core-api/printk-formats.rst | 32 +++++++++++++++++++++
 drivers/gpu/drm/tiny/appletbdrm.c         |  4 +--
 lib/vsprintf.c                            | 35 +++++++++++++++++++----
 scripts/checkpatch.pl                     |  2 +-
 4 files changed, 64 insertions(+), 9 deletions(-)

--=20
2.47.1


