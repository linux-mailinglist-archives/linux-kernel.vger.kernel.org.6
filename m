Return-Path: <linux-kernel+bounces-551082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7420A567E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1668B1897FC3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F23A21771E;
	Fri,  7 Mar 2025 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lNmkfd1a"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63DD14A4F9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350900; cv=fail; b=Gu9a/ysbCxOVakfvE5OD7hpWmfjQeveM93M/q4IH5ldr9/4BvMKeOqgY3GrLgaLskgugQ0Y2UnNxJMbm4+BUr9tE6ibB4siO/Bmt603mUK1Jm1DZb+8T7+FN18tNsyiWrhDj8a/2s1NvttLVX39knQtaFemlalZtWFJIog3X3i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350900; c=relaxed/simple;
	bh=QaqUEorh9zxTT+sCMeIobEFGiHnMUMUqo3rrbD+yHdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mx1/AXczIlWKFLX+dEufjeHjtIqo44m8F0wJRz9WAWjfnO3elYJG0SbgoI/2axQXTM5zWWU3WKfhO/oc8x90tNa2WH3aKfhfptjn0Jr2aaIF4t21YnjpEgWPUqlTekmKK6dHyGagHkw2yn7DKriYEI+cs59crSMjbRYzMn8I+yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lNmkfd1a; arc=fail smtp.client-ip=40.107.104.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEEtzQ9AUjrlCA2vPQbPtbn3erRS55wXSdjnSqacPT16TpfjSkrWRzOrxjN4HYlKadZxtVnHnJpXymAAgpFP0xmXO7CJZ8HWEUOyRJXVenMz4DUThUg2zjsyT6ZOLOQUfD4cc1G5C0SdwFr5j3wklmbzxYfhTYBshBl9FLx4sOqx/igJ7YKr0HZbVs/9g6ygmiX+6EUAN246/nHpY6yCSfrQ4P0amM9qibZQhfXP9Fq5MZH18JSiiP78mmv9mpMNhC7imFdN9ZrRkI1Y134NgiR8Arx5FTySC+TRv8M5yrMcFF7vP9A/l3NtFma7ItthW8G12GhZ1bd4y4+2JAQvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdRaW3XEHGfY9LYLWegkJuYi6DLx3ZjGeGnfoLEjVYQ=;
 b=eZQzA9k/GyMVufpAZIfqU1YKI9uPNWJ/hAcEA1q3CsjnNe8GnhpeOFWF4lQ38wNuwcqMQVOz7JOloZuG6Y0SasEnC2KIXgAcxtFb2coEThpRU7oACGaaDsWqycHfQtntqOou01mKJiH8eYcO4uDhf93CaX7XBB5UfhXNg42R71V/P36z7kGHcpWN9Qh6ylQi3tvAySVsk+yoTsQ/pMjCi/pi5hEsEpKRykS/mUJFQBE2a6N+pgHZwX3anxvF3ylMSMKn8Tts7zRtVqNrxJvmqvc17+0t/h4eYHLxsKO923EvH7bjDYY2ojO8B2G13fic865077olR4S0/qrdgjwCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdRaW3XEHGfY9LYLWegkJuYi6DLx3ZjGeGnfoLEjVYQ=;
 b=lNmkfd1aZ6jcJ71ZZuqg3HyEEOTTJYefyxvYS6c8t7Hn0vx3ANDwompCqPlbVYau4V227qT/A8+t0And/yzVilFVfZMYvTRfImFRzyl273WxM5bbuLbFv82PLWaLutg+td7fmhLdwLnWGxbOd3G8GbyRPTpahwx+RxQjxKgc+zWTkUMVzkVWiD3dzbgzkRJq/CxBFTB8nMsp4M6DHKvmTaPh5bEz4CE+dEUDb8uYZW1rMANA8JW+4YvLdCr1MT4Gl1HfgHTC86MzxgHKrzy0vfpsXyXbxMxpkbTz4rKh0xyfrEmNCO8b55eWw6dJU3WJkOWo1swBIsR5/L646ORhaA==
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 (2603:10a6:800:1db::17) by VI2PR04MB10881.eurprd04.prod.outlook.com
 (2603:10a6:800:27e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Fri, 7 Mar
 2025 12:34:53 +0000
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee]) by VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 12:34:53 +0000
From: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rvmanjumce@gmail.com" <rvmanjumce@gmail.com>
Subject: RE: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
Thread-Topic: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
Thread-Index: AQHbhmrgLz9oTBo3ckmGrUVlGQqbF7Nc48qAgAjnVUCAAIGuAIABWKqw
Date: Fri, 7 Mar 2025 12:34:53 +0000
Message-ID:
 <VI1PR04MB10049E260B10FD83E57B2DCB78FD52@VI1PR04MB10049.eurprd04.prod.outlook.com>
References: <20250224031754.1001101-1-manjunatha.venkatesh@nxp.com>
 <Z8Ha+T9Vc8Bhz25A@lizhi-Precision-Tower-5810>
 <VI1PR04MB100498A9CFBB48DF250CC73B98FCA2@VI1PR04MB10049.eurprd04.prod.outlook.com>
 <Z8m/zE9JvyiNq1HG@lizhi-Precision-Tower-5810>
In-Reply-To: <Z8m/zE9JvyiNq1HG@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB10049:EE_|VI2PR04MB10881:EE_
x-ms-office365-filtering-correlation-id: 88d5fd37-38e9-4b33-ded2-08dd5d74763e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yc6Ue2ThJUOzIO6gYNVleEhVV0S0G43D2d08hpZSG3EoxUICIjuiU/SR7XfJ?=
 =?us-ascii?Q?M5RE8/DSxLb63VqMljZVVYQhY1k37yfPalURKaPbjtnM2zXVm9uP4UQCgzfY?=
 =?us-ascii?Q?T5dWmlxOnQYZGIInOQ7M3Hn/VXaGEBtuTsVMwTswU7xTxENBJw5PNpK7RRy3?=
 =?us-ascii?Q?mwa/mvaOaLX8JRvmkG9tw5ANiUhQI153/azfCtAvi917AtzzCFWHrS7q6tRa?=
 =?us-ascii?Q?adcjJtY87goDzihf5RHMKAH4BekgDGNLUH4ST3VMV5TLvkGEheiqqm09Ix0W?=
 =?us-ascii?Q?1FLLhQrNIrVxsSYKVAK/rGRK8HtdkReUO+6WIK4iTpdJxfTZ1ABF81bNewAr?=
 =?us-ascii?Q?gK6gaXZDnDv8kBmP2ZhN7TjS4JVBV+iK/sFsngj7yu+qis7rdrr+CKqjbnAc?=
 =?us-ascii?Q?/Qtv2hQwlF/NnC4MzWryOzeMLvCQqn1+D4hV3Flaa0luYICgYs9gM32YVQhF?=
 =?us-ascii?Q?uupdP+wWA7oLrQK+56yCKlxM86/peaTylsz9j+A9lobqvQ2IihVirfG63Fbc?=
 =?us-ascii?Q?AGlvfwV1AWRDW7MhnVWX2LBvlFF/+LR0HtZUArK+EBaUrx92HE9j4DPJ7qWz?=
 =?us-ascii?Q?xWa64LnplOiUmTKclfBM8PkCHtXNlxBrUjQxZQ6fOErUywfoM4ojoGmkZLRX?=
 =?us-ascii?Q?6eWOb3HP/lH11G0yTUvNm+gkvpS6ATyD3/YuI9N/K9pygmCXWEIaV2f31gpO?=
 =?us-ascii?Q?JvQSlos71yu9yV5oVaZN0BDuE8A2reZQZaNxetihRMQo5MR7dGGH1KtYDaKQ?=
 =?us-ascii?Q?DX9/KEEswOP/YuR4/uhXBl/5ZXEQobfdfa7tQ1nlCXg+l/6gys0LRonq7q+L?=
 =?us-ascii?Q?USdq6h6oyQRklDUTu3Hq+owFSSGf8yeD4at3Nz2+2WVWAZvLdwx8yPImJG9z?=
 =?us-ascii?Q?HmQeyJ2xIrgn8FRJ8XCC/UJX2di1IEm3y47SGNe/nogJS4gyIEWBzcW/leQg?=
 =?us-ascii?Q?NcbbaGwh/s2ODnrXnnrhj21UWwYBWOCE1P3obHFPhVMo9flC8nT4fTULK1uO?=
 =?us-ascii?Q?8FcH7eKx0K1HwcNWykw0/s2aOW2igCz7LrdoIm/98pUd4W7xXtEcUYKY/1hR?=
 =?us-ascii?Q?nvs0GgfTQj6U3I43ZmWWOasLLOjhGKCbmgu/1VRWparlOAzutt2wqTeV3k/T?=
 =?us-ascii?Q?niS/7/xVa8iDVgPz+gQw47Odhop4a6Xi5gn2c3AVaryt6OnuBQMWlZGUw1R/?=
 =?us-ascii?Q?JEKHrqwGK7/YGSLYrgAL771ZbWhk7qqKGxDLJ3KWrELvZP5QcXJeL0arGpv7?=
 =?us-ascii?Q?/A5r9teyll94ZMqKxgn+iR18718yIuDaZKbboECg7AaaGzesEg5WmMgRa17O?=
 =?us-ascii?Q?M1RIoPslHZGCGsfrEYYFwirZqhWKu+pEpfreIKojPptps1IWkXV+zdikIiVE?=
 =?us-ascii?Q?Xk0Fpa1WTz/aFBlwhPVDspM0EO20a8H0oEM3FcqhJM2QtUhscOwxoX2VIMCb?=
 =?us-ascii?Q?Rsh+SM8yVNhTmNfNmcqgQI9365gNkDhp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10049.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R6xFasDqYgDoOGn16JXh5kXOVV7giwAbE5Iudx97vU8oPULUoCQG2O9GrDJM?=
 =?us-ascii?Q?9eQYh1NWz5rt+pxSh56XT3L+0uZztgUgazcc/QOL9ksk6Lnes07fDoLMnzYe?=
 =?us-ascii?Q?g34KnWxe/SUVBih81KIbVCnLPcz+6gDkUZ2/O4UFSGzjosjHRLSblHj6q8iR?=
 =?us-ascii?Q?7hL+eZ/2j6LzL66dtqC0l6iMgDYYQ1BgUU21fTF57gTFEdkja7EntexnzLyX?=
 =?us-ascii?Q?i2l1YUdtzD9zOzBU78vCXkxZGgSKLtEQOBJ+QKIoU7qsW8P3d1vEim/b4Qx7?=
 =?us-ascii?Q?vL32u+ceiu0FW6rMzy3oW9M667rIGyPFgf6Q8hn2r/ut3HcGhXQGD4W/9noV?=
 =?us-ascii?Q?hZjNpvgnXeaqBkd+WjsQsBH0gJaIKubXqZuP7JIXm/qdbqFNvsCizLrz06QV?=
 =?us-ascii?Q?yB0qY1KXEuAOPye28/Lk1Hqzw/5xOraWRzLh7ddumlSfKHAssXYxFltKsO5v?=
 =?us-ascii?Q?llxUuu/h9yLBABY2a1KYBQ5kwAcpyENLyzsgoGNPHhhA7BwPNQNr0vdOf+lE?=
 =?us-ascii?Q?yrXnoqOcdVUMhXxJEDTmK0IXaBAzGZkyTFbBeQeu9qaPNPBDKBdqs5qsPAM6?=
 =?us-ascii?Q?GZGmQR5z3wuMA+YS4Q81ozgxxxPVfWpcKBgXR+oWawae4mLLvRQkgBxPAoRJ?=
 =?us-ascii?Q?QQQwLZod7X+l0RofPw3LpCprAPPhcDPHHniUms+kRmIwgU9Jtkr2/rWE31eJ?=
 =?us-ascii?Q?uIcyy9BG3K7hTUHF0rUaVihboDmw9ZmR/CcRoTLtZCxs0q9p/y1OBQHDBIE7?=
 =?us-ascii?Q?gxtt7QUa2lK4cfhAH1kw5VfIFNRR0WMILwbNzmJECL56UBUeNu65tfqwrmEz?=
 =?us-ascii?Q?5i+/jW61gIGHJEAXvDMUM7So0CfCtL6UKgLa0snx9zISQuUQ751dzYNS6jgR?=
 =?us-ascii?Q?p5wt3YBUjsSg0I2T8IY09sh+EDY6MAlyNhcPCO5EJwCryxB6+ytpelhF84jo?=
 =?us-ascii?Q?jPSoUfhNGYq4SB6Imu5FVfUN8Nd/49wCux18+yIYkR1kXX/t2BmcjcoQqe9U?=
 =?us-ascii?Q?T9FKukiE7WBrbKmpXmnUqfSHrQS1LR4hUUHnRUHPtgS/paL+N6yWeqXsMjpr?=
 =?us-ascii?Q?f8+B7J0JopNTH02UW2EdKg+c8U7v+WdCOjaIXWaR/YhgVWLgQrwYaDHG3rl6?=
 =?us-ascii?Q?XAHRDe27/CoosbCvRgs3+ZleWtwR9Qaoh1G2rOqnn8FDFCeTJv86rez7EurY?=
 =?us-ascii?Q?bg40PFl+8rosHD30K3G9TicuIaGWvdsamT2sZvyNduyAb0FVR5HGfNjHc9Ng?=
 =?us-ascii?Q?GOhBLgupuWqF7W1+0VTDMXFolRvQgprAlFAxrp5LuviMV2eyvUGkWfU6FBJp?=
 =?us-ascii?Q?bufO4AlFh8qzpuc8L4B07ssf/9yqTS4CGkLhXUnhUEfq0W1MZsPaW/f8AerX?=
 =?us-ascii?Q?L3Qy3/aY4pffC/n3nRgsLKhG5AJV9/1b/9ZtczLJ8GYD9YfaJvivgJ12ltAh?=
 =?us-ascii?Q?EVH+UCKPjHdit8goG1cMyQme3xu2TaioboRUwnAA+LD7sKttSLvXSBNhCG1a?=
 =?us-ascii?Q?1pJVXyzoaupQtdXIg11rjvIWKlXb1ZfNYjate305frJyz8faqBhcOSrUsmw0?=
 =?us-ascii?Q?Qs467Zpi3OjPpLSANb2Cs1D5dzWQQO5YpTQFfGQeRSLsF75bX11LeekhY0TY?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d5fd37-38e9-4b33-ded2-08dd5d74763e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 12:34:53.7874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mN8F+STnvlU96VEXjJa/GDcyfz/z/kJOyAqGZFvJH7gWoyXm9LObaN/DQJ4FtAePmBrN0HHty1I8/9e1qWS3x1WBso6DeK+GaXTNUV9vnDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10881



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Thursday, March 6, 2025 9:01 PM
> To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> kernel@vger.kernel.org; rvmanjumce@gmail.com
> Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
>=20
> On Thu, Mar 06, 2025 at 08:31:29AM +0000, Manjunatha Venkatesh wrote:
> > Hi Frank,
> >
> > Please find my inline comments.
> >
> > Regards,
> > Manju
>=20
> Avoid top post for linux kernel mail list.
>=20
> >
> > > -----Original Message-----
> > > From: Frank Li <frank.li@nxp.com>
> > > Sent: Friday, February 28, 2025 9:19 PM
> > > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> > > kernel@vger.kernel.org; rvmanjumce@gmail.com
> > > Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue
> > > fixed
> > >
> > > Subject should be "Fix read from unreadable memory at
> > > svc_i3c_master_ibi_work()"
> > > Or like below pattern:
> > > 	Do ... to fix ...
> > >
> > [Manjunatha Venkatesh] Tittle updated as per the review comment.
> > > On Mon, Feb 24, 2025 at 08:47:54AM +0530, Manjunatha Venkatesh
> wrote:
> > > > I3C Master driver svc-i3c-master
> > >
> > > Needn't this line.
> > >
> > [Manjunatha Venkatesh] Removed this line and submitted the new patch
> > > >
> > > > As part of I3C driver probing sequence for particular device
> > > > instance, While adding to queue it is trying to access ibi
> > > > variable of dev which is not yet initialized causing "Unable to
> > > > handle kernel read from unreadable memory" resulting in kernel pani=
c.
> > >
> > > Can you provide more detail information why/how this happen? which
> > > varible read cause this problem?
> > >
> > [Manjunatha Venkatesh] : Below is the sequence where this issue
> happened.
> > 1. During boot up sequence IBI is received at host  from the slave devi=
ce
> before requesting for IBI, Usually will request IBI by calling
> i3c_device_request_ibi() during probe of slave driver.
> > 2. Since master code trying to access IBI Variable for the particular d=
evice
> instance before actually it initialized by slave driver, due to this rand=
omly
> accessing the address and causing kernel panic.
> > 3. i3c_device_request_ibi() function invoked by the slave driver where =
dev-
> >ibi =3D ibi; assigned as part of function call i3c_dev_request_ibi_locke=
d().
> > 4. But when IBI request sent by slave device, master code  trying to ac=
cess
> this variable before its initialized due to this race condition situation=
 kernel
> panic happened.
>=20
> Write above reproduce steps to commit message.
>=20
[Manjunatha Venkatesh] : Next commit will update this description.
> I think it is common problem for i3c framework.
>=20
> You'd better change i3c_master_queue_ibi()
>=20
> void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *=
slot)
> {
> 	if (!slot)
> 		return;
>=20
>         atomic_inc(&dev->ibi->pending_ibis);
>         queue_work(dev->ibi->wq, &slot->work); }
>=20
[Manjunatha Venkatesh] : Actual issue we have faced with respect to 'dev->i=
bi' variable.
Pointer variable 'slot' is with respect IBI received from slave device cont=
ext and 'dev->ibi' is with respect to initialization of slave driver these =
2 are asynchronous events.
dev->ibi =3D ibi; is initialized at i3c_dev_request_ibi_locked(), this is i=
nvoked as part of slave driver IBI init sequence, this is what we want to c=
heck before processing the IBI request from the Slave device.
master->ibi.slots[i] this is where all device ibi instance list are saved, =
so here our slave driver init IBI stored with respect dev->ibi index.
So adding 'if (!slot)' will not help to resolve this issue.

> Frank
> >
> >
> > > Need fix tags and cc stable.
> > >
> > [Manjunatha Venkatesh] : fix tags and cc stable updated in the commit
> message.
> >
[Manjunatha Venkatesh] : Last commit message missed to update fix tags and =
cc stable.
Will update that information as part of next commit message.
> > > Frank
> > > >
> > > > Signed-off-by: Manjunatha Venkatesh
> <manjunatha.venkatesh@nxp.com>
> > > > ---
> > > >  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > > b/drivers/i3c/master/svc-i3c-master.c
> > > > index d6057d8c7dec..98c4d2e5cd8d 100644
> > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > @@ -534,8 +534,11 @@ static void svc_i3c_master_ibi_work(struct
> > > work_struct *work)
> > > >  	switch (ibitype) {
> > > >  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
> > > >  		if (dev) {
> > > > -			i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
> > > > -			master->ibi.tbq_slot =3D NULL;
> > > > +			data =3D i3c_dev_get_master_data(dev);
> > > > +			if (master->ibi.slots[data->ibi]) {
> > > > +				i3c_master_queue_ibi(dev, master-
> > > >ibi.tbq_slot);
> > > > +				master->ibi.tbq_slot =3D NULL;
> > > > +			}
> > > >  		}
> > > >  		svc_i3c_master_emit_stop(master);
> > > >  		break;
> > > > --
> > > > 2.46.1
> > > >
> > > >
> > > > --
> > > > linux-i3c mailing list
> > > > linux-i3c@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-i3c

