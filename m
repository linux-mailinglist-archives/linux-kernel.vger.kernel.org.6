Return-Path: <linux-kernel+bounces-337972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4748D9851C5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9E7B21F03
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB7714B94C;
	Wed, 25 Sep 2024 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oAfFL7Su"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012056.outbound.protection.outlook.com [52.103.2.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F914B087
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237080; cv=fail; b=TCaF19wZvzWtWwM7PrFgqlO6wcn1OIE4E0N9znehnlosFAEWlnPeRkkMySsfOQbajQwUBKcs2QU5eBrOODIJ+uS65PEDrXzx/FgdqP374s9IRVeXr+TDobwS6htTYFBHeelbv7CF5SvSJKqETIDJH7FzbpxZyB5fTryymtCfN0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237080; c=relaxed/simple;
	bh=9iLw96yw0QxetnaqbxuhF5R0hg66bP6DzqFeK9TDbvs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uIYI6sBSpnSYR9hsayWdYKvWnYZNC8IulwqYb5HtfyWO3bVO96VbQWJxNptw80mgKlU0ak6OO2P7cmnLg+thMAm4UXcEPtyK9igJXOQsoG7FZExzXY77rcG7t1MgMQu8e4iJmeaGlKUfOr8MSi0J4A9lbQQzvn34gfKug0ioN2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oAfFL7Su; arc=fail smtp.client-ip=52.103.2.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMGtSwd/DRlxOTJGsyQooxHxKgdpbBi5dT3D4PohBN9o7gbQx/ZefrfFQzwM3pMkl6mtG5x8OD/ElQ0otzROpfk12ogEI3Hsbq3lliCIpPY5OCTLxNQK09ghIU8kzK48cFX9QV77ZVzlZCculpFjaWSeUCERcjVPzrsBtkRIq+Lk+12D9YAqgHCtDvQ+yT05gQQjy/vpV/u/By4A7/bqC6eEFecluqkFiGQNh6Ece63TQ1n2N0YRIICj8Sbdjd+AeZSNUiEaXMtAlQOeqr4OiVtUW/TdBFOfy1kT0ugvbxzfPu64Q7WAd1y9cjuxVkW42o05x+LFK94+r3uWh+d2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9spivek/3suXziEE4INSoJZcHsjW1pS0deYXQgM32hI=;
 b=PXLVv7IvBlz4XopgP4j6vgGOAEom19MEtY6xqMhZKaWIwcPBZmDf3HLAY5iFguyhu22nGxcC33xmNazOEN9+tH4vYJcsLRF0FokCDfLpQvEzv3xBD8CwZXRkdFJVBEdKj4VnAL89TAl0+kvmbSZ2f56xWH1EV7kKxkFLA1ko2JXM78t/79un5DTFHuG8rOc4bDrmr5QxIrzMRLCsmAYuhsFL2f66r2/KjE3YVM3mNVb5cYpi7Z1EwezhgkWdpjVi6ZVSr98gX4iXS2Rxu0hOL5s/23/8ejXsaHdeOYgkIPXti6B7oHp7+DrOMxtjLCabtLiVc0cGSHVQ9Z1Q/moM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9spivek/3suXziEE4INSoJZcHsjW1pS0deYXQgM32hI=;
 b=oAfFL7Su8fRm4qVeMjzwgcmkzenc1g5Wt9rk01BT4s4PX7sERMm5wKtamr+tHISNmMvaswJJkIfcOzdQYflunXQ2/8KKEuNg6L9qsN8bTeqMTXK2LFgJgHPi6oYVncnpZxrtmkg8aJ+E9WfLhEL8cQCY60SNxT0WVtjHUVcSaXcja3If6JpGvkbpl6080SjwsjnpA6sNihEOnYLeG5N8WfdCpgrC0qkwvbvNrmr4gFkBV7n2pWD4+GPFfzxblOeqb1mqn08cVxpZkHr4E45p3ufoUUAnMzZKb2Ah8x/bmSIQro9NOcOXuzmaqXXeWPo+CYUDSUAZ0upc9fCht3d99A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9554.namprd02.prod.outlook.com (2603:10b6:610:125::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 04:04:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 04:04:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thomas Gleixner <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Yury Norov
	<yury.norov@gmail.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Question about num_possible_cpus() and cpu_possible_mask
Thread-Topic: Question about num_possible_cpus() and cpu_possible_mask
Thread-Index: AdsO+nSV28XUjpufQ325P0s8gOEPmQ==
Date: Wed, 25 Sep 2024 04:04:33 +0000
Message-ID:
 <SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9554:EE_
x-ms-office365-filtering-correlation-id: 4dc780cf-0027-4424-ebc2-08dcdd172a0c
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|15080799006|5062599005|8062599003|102099032|440099028|3412199025|10035399004;
x-microsoft-antispam-message-info:
 Ie0XWa+3HvL1jCGh53Z7nJSVHXBx0i+SZ8ucQPyP355jQINL2nF61kqeAa3/ru/ZRag/GVnH8/nCeR9A6/psEEp2gzlMBbzDIJeZRRwCXT+XESKIHuNUPk1iFFGzYBNLV7g+FV3l0x1uZTwlrgUifQbcafLvIExECwvWJRPA/prybw6D4+S9GlmioxmezVNFs0xuaoyiCQoyVaEIvqcpg3Y9uGmntVPMeYXVDPhs1iCS0Wtvgc+df3DqyDz4T5BbUONkaRTf5HLF3ncI3o12C9Yxr6hg9AzN5P50mhWRuTfpVo4dikom2zQwFOlDXIa4nPQyOVJHH/3tJIvmci2HPmP7TD6+BQ4pJwf3cJPiTgaF3U1RufhqE1RzSvy5lfiDidwZgs+2bq/EzpwoE3E7Cqfq9b7BtB1VhH6qrR/8ue0SeEES9ToOfUWLrBXv4z9lshJ9cajUbcWxSTgOqYitoHnBRXp6ZGfKGodW44FH6oWLYuBF7h/mj7w6y8Ry6yvl/EmXgxG29EzdkjE6rZj9loqFqM2OyFJg+ZFCxKjMOXMp5sjRjYfImZNHxrw1KQRHKFQttd7gU5H55mmfJEcgELpn+I1tPRIEeOBzbLfErU7FlacVt5ZE9G+kMpScMi0HxnNZDbloSl+qOJ/qfnMwhZK04yQpVMVun2rFbTdHieo4/8EiHsMgil6ea7+FqYUXVaO95rEvY2HkSqq7PqrqJUuAgDSCMu8kuIdzezihdVvFyS2EPTRE0Bt2PRSY1duhE22/mR9S9JIf4aVGjrclH2w9SB0XMsiL8cuKEoRTUT3lkHGHKkdgQTrabFv/FyEAOUGd3FR6MqYT88HEtf6Ix769a4LjOockl/Y/dj2aF6ty9i52uDRIM87SJA54X/YA
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oeNONzh4qDVCcnk0VIjbmQ6UsG+6vRRKeJ1SPH/x7jNQOdSvPpTeq3ozxf24?=
 =?us-ascii?Q?eexqvyQq/iisLp2jzc7rnDlVSuFwngISpJuWnrSZ6ZL/hO1EeTQ9cjkxljiV?=
 =?us-ascii?Q?By+fjBGgoVtBJ0c1cv0bfWsfkev9I4R3G5mf8KvibR5f5OIaGMxw+urrZffb?=
 =?us-ascii?Q?scF8WDeXfGrrkj7gUNG5U3Fx125bFMFuJrnNuKkSAE8Zgfr+MWmR0mp0c54j?=
 =?us-ascii?Q?8yjo8/a/5qTbMFB6batUhGtEC2p7HqA0HQYqex4nMJCWNX0JqAAWE5Gd8i9i?=
 =?us-ascii?Q?8YEx9C4lTn4gzioFMUOX5WaJFKrJednfL4lYv4ieuJ6ArJSzuJgxOQKygoE+?=
 =?us-ascii?Q?Q27OuGtAM1QxnXFvaEtgFG1L48RpOGEBgygKP/18E8tD1pjoq5pKe0A5sS1k?=
 =?us-ascii?Q?INHGiKVAC6IXJ8w020HB1LOTdnbELU9Fr17vWfFCBd7OipEw0pVTXHVeWlg8?=
 =?us-ascii?Q?do5wlhIW2yR4+D63Tw03HYbK9dvH/TsnHIdn7I8ODBgT4iWOXTHrWCiZ4DfA?=
 =?us-ascii?Q?+xV8hISesHIiSxS82uX1M0tGSjEvIjneCo8TEa+VkzSGb3J/zudyMvLvre2M?=
 =?us-ascii?Q?PnW9PuqfC+v60LAsA15UilZlqrbJ+v8CWcSFnZldXbir7Qhcs3rV/uIEFFDI?=
 =?us-ascii?Q?bkvPZt5y5UrMCWpkRFO79sBZ+sFINO8UK8y8uw4x+WbzxbcVmyoQSqmqnG8y?=
 =?us-ascii?Q?bf5WZq9A0HAzex8gWzhHPlDm95P0zQnsr+AZM9OxDfp2Ovvts0miMimDOBfV?=
 =?us-ascii?Q?10cVZFoN/LP5xujme3J5IA9qN591epZH5rNoh9Wr58jEu4k31/3S3rr8gPol?=
 =?us-ascii?Q?4ZD+y8k+SR5wGXLQkSjBd+lQkua6o+9Z4WG86/fpEYWc8sd7bVhC4e/2X+YQ?=
 =?us-ascii?Q?yLICiDDNoPK1BkCoLsR/b4r4X+sjCJqHCDOlJzy0jGNoQfjeE5pVF/cxSjID?=
 =?us-ascii?Q?je0rnQXKYQ7pFhrfyi37cPUMvQX4uk/nxZhkqhOLuTXBPg0zIbYGvW/TP4x/?=
 =?us-ascii?Q?GFNc1rernCkN4INekysGi/p7qGr2oU6MtHwyC16SPXEVUSyzjZNOagkronHn?=
 =?us-ascii?Q?9L8OAXAxxVR+Bin58DFMs6zsWX/JkaFTg58De1wtPJdY4euFg0NFxRcuPOJK?=
 =?us-ascii?Q?uBkqW/WfZ/eiOBWfH4P5IxuN2YDiO+SaU4dOQaV8fi2QSCPbieSvexo2iZ7O?=
 =?us-ascii?Q?T9fFWXOkA63d1HlSjgptNrSn70CC1SXmyBbab9YdtTfvTamhMynqumL5cbM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc780cf-0027-4424-ebc2-08dcdd172a0c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 04:04:33.8707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9554

Question:  Is there any intention to guarantee that the cpu_possible_mask i=
s
"dense", in that all bit positions 0 thru (nr_cpu_ids - 1) are set, with no
"holes"? If that were true, then num_possible_cpus() would be equal to
nr_cpu_ids.

x86 always sets up cpu_possible_mask as dense, as does ARM64 with ACPI.
But it appears there are errors cases on ARM64 with DeviceTree where this
is not the case. I haven't looked at other architectures.

There's evidence both ways:
1) A somewhat recent report[1] on SPARC where cpu_possible_mask
   isn't dense, and there's code assuming that it is dense. This report
   got me thinking about the question.
 =20
2) setup_nr_cpu_ids() in kernel/smp.c is coded to *not* assume it is dense

3) But there are several places throughout the kernel that do something lik=
e
   the following, which assumes they are dense:

	array =3D kcalloc(num_possible_cpus(), sizeof(<some struct>), GFP_KERNEL);
	....
	index into "array" with smp_processor_id()

On balance, I'm assuming that there's no requirement for cpu_possible_mask
to be dense, and code like #3 above is technically wrong. It should be
using nr_cpu_ids instead of num_possible_cpus(), which is also faster.
We get away with it 99.99% of the time because all (or almost all?)
architectures populate cpu_possible_mask as dense.

There are 6 places in Hyper-V specific code that do #3. And it works becaus=
e
Hyper-V code only runs on x86 and ARM64 where cpu_possible_mask is
always dense. But in the interest of correctness and robustness against
future changes, I'm planning to fix the Hyper-V code.

There are also a few other places throughout the kernel with the same
problem, and I may look at fixing those as well.

Or maybe my assumptions are off-base. Any thoughts or guidance before
I start submitting patches?

Thanks,

Michael

[1] https://lore.kernel.org/lkml/20240621033005.6mccm7waduelb4m5@oppo.com/

