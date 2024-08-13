Return-Path: <linux-kernel+bounces-285061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2629508BF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C1328750C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311961A0708;
	Tue, 13 Aug 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mJFRleCl"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC119FA9F;
	Tue, 13 Aug 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562226; cv=fail; b=qzRdDF0Hn9nxcX6Ue26u1fMIJHoJp607faVlPRtiPnrXl+MrltMW9SfXZf1XXXmPFTAJa3xXMj9oRhOuGrZ+MTn2A0dFkug4Cd6HQMgEZkN+8Z9Y2zZzb+YJ0L3nzoAR1GZVifIiD0/lLVCchSh1Pf/JygN9Yyq7TXDvcsBbNkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562226; c=relaxed/simple;
	bh=eG/5bt5BOSIx3nM51/uPJzvq8eZCcb6rBkQQoOTdA24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MZrb0f0EeD67ZPECP0MDSN5xCzT7ufWrpOCo1gQ7FBSOlUGIlO1E5RfvD2yLeGGEhH9Fo+PF23zIHlc7xTdPR58N9MgMEoZXV5YSMCb+Pz5xg3QXcWeLKla/hbmvPCJPQCW597WEnwhnbEaf7njzkXCybEHzkigV0lpDvLFLRBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mJFRleCl; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Edvu41t6gxWpWWF48PkU2kBbAqx01vfvEe/a2I2DHVO21POulVk9Vebl+mbuQpBgg9xmRi8qayS8irAVzi5Uxw3sblur7G8UnmiIsPrFIhMeGQCK5wZoMYwONgSddWWrf8A8saNlLp1CsigdW5rAIw/cPbpXwwKT+NKa1CkaCRKzmh6vVPWWULuLYCYkgcUJ1OW+fbGrmBWfy9qKVsK7MLlViQk+a6iRF+I2TN1BJ5t2/9ydB0yo2eJhQwpBy2fPGbe47s57tDETbMC6964J/qULFKmm46ppeys24BUs1g2Hh9p3HENHbNYzBn3/W7FsQ5l0RqQAmAOfJfAxxcsb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtS3jhDgdOg4ZUwgkvpgHnOYIn1qI+cFKJhkY0Mg4hA=;
 b=SU7UffCKMgT8yukZZmrcnwLJciim+IF8f4izoX6VLwVa0yHon3WubDArGyWgoMEx1cYzh4W9/s26Q+Ae0V6Ib/Z0rAfVJDp4ofALSxZLfGxqWqaQJX39ohEscH4qr1aAAlPAHcaOeZ1b+LtYYMTxOY2vBHgtZyBY734K8du7AWTk//QGPvl30jj6cLwN3+bzRfBVuiYLvQqRy+yEKeEVYhiAn7GO+fva9/DwKjDaKTXMeeZ5R1/tsnQG0LC+dw+K1QVKkXb+6F3QO9KFNier4p5NlF1JnrWqZAAjAVP8k+CVKTRU27TE7f/KRe9aSlY1JSrZD9Tkm1HuQQdeMVATWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtS3jhDgdOg4ZUwgkvpgHnOYIn1qI+cFKJhkY0Mg4hA=;
 b=mJFRleCljDkX8/HTCWgIyM8+Bx0G/QQ31AyIf03oXdVC0KmBPYUVYyZnoa1rrSPLcruLoCXhTNSMjFvKiNzQvo/gKrRlRFzyP0Bz114NzVloRisyOq6xQg+WcNjAvWGodAGAsmQB5y8RmCfnySfqKzGHdNoa8sYRBTCoBsOGyHVruqsJJVekkf3R1Mz8yKPksw75xIrniu6UUxo0p9+Pwx/r8TANCSDEibRqIX5Ur0y6caeO2XBryvBICoT+SCAGLATaVsKt6HRJgPEaeal5R9NLgvWotmqXYeV/8cJ3VKXUEc8Ufr6qyGTWRB1HnGra088dyC4aXqvGAOYJXwf7Fw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9935.eurprd04.prod.outlook.com (2603:10a6:102:387::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 15:17:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:17:01 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: Dhruva Gole <d-gole@ti.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"saravanak@google.com" <saravanak@google.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
Subject: RE: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Thread-Topic: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Thread-Index:
 AQHa4YQqp/DPlb92g0GK3FOKE5oYXbIk+n+AgAAWN+CAADhmgIAAAK7QgAAY3oCAAABJcA==
Date: Tue, 13 Aug 2024 15:17:01 +0000
Message-ID:
 <PAXPR04MB8459D35BF6FD55B38350E67388862@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240729070325.2065286-1-peng.fan@oss.nxp.com>
 <20240813085703.zz6ltcxmrrbdgt77@lcpd911>
 <PAXPR04MB84597171A959F40CD9A77C7B88862@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zrth0Ypog2TXBlxf@pluto>
 <PAXPR04MB8459B2CF515DC89DE98A1B7C88862@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zrt3P1FH13edqjoC@pluto>
In-Reply-To: <Zrt3P1FH13edqjoC@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAWPR04MB9935:EE_
x-ms-office365-filtering-correlation-id: 927fe61f-cf7e-4a73-5a08-08dcbbaafb84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZmOzxoJVBxAlza4aUrAnmsRpcZFxPVf29mQf+9TKDiEiT2y51dpMG9BfnnPM?=
 =?us-ascii?Q?0NOiWeLTyVZSJyyHSLAewkVNrio6qs1sramzOVozVPOJOO7tmOvPBNKFTw8C?=
 =?us-ascii?Q?xH7tmwoGb7Ai+6mXCnnMoFJFJs9GiwEVGLlqERwj3fgzQQml8hr0Y0fE9z1q?=
 =?us-ascii?Q?r6A1mRpsYcrfn6K/p+9ISeu92ecYMi+ip9SErYcsXQefkltWmlwpu4rTYsdW?=
 =?us-ascii?Q?+biNjkY5Y+b+5qoodJ0l1dRQYKN1BBFHFujebd1ObxMb3Vw2X2wslxMiYcN2?=
 =?us-ascii?Q?lLCtWxRtWsEqLLO+pcEyO4di2tV8fPu1R8qfHzddWSC7KlYH7XhmpFsTEUrf?=
 =?us-ascii?Q?2eezb9hWQwxP/Qp2vtpk43Pw+hQG9SuyWm8usCmtq8a+9wppXWfaBQfQgC5S?=
 =?us-ascii?Q?nHqVH4dbdGWZk/brG5LSR5v4Sxpj7zRzIYr52V8XCldta+N+zgNz8o41fU1h?=
 =?us-ascii?Q?0OwOD3rvAQeLrJuehxDRNxGsWQ44++mOAlSHaCgCe3R/CiDgty2Am/kOPyad?=
 =?us-ascii?Q?g1Sg6/Fp339zRvfObB3OUaF2RwlSo1vXUJAPeUChCkHeRxNZixxGHhFHPp7C?=
 =?us-ascii?Q?aSNEAJLbBuZyZvbrhEK5VzoeMO6LLTS89xz8629R17br2gY4UxehCE4dYqyi?=
 =?us-ascii?Q?JqSZZplY6uQwNCbhklXAyMBEyoYjQXRiJvFTphdCOMc1a2YGoRGznjkXlEi6?=
 =?us-ascii?Q?s4TSk7h+DcLW81VIAUNUPQM6GHxtUrmfalyYsB9RK7m3dGlx3wCJ9flxW6ig?=
 =?us-ascii?Q?uia2i5dXarW4+gy1PS/AAgfstlkaiikDG5mW3OkvPbiw6mr6NItzzBCs20Z4?=
 =?us-ascii?Q?0fyL0ByA1oBikLLHW23XVG61b1rocjmXhEzxFBv2UTE0eQqfQcmWkDDTJni9?=
 =?us-ascii?Q?psvBQ5zyQVbYoRgH5YKpyJvirhRVMpxGL1w4otfl/MwU1HMUetV5qWwUcaFD?=
 =?us-ascii?Q?QzpSSYHiauunUYBbxf6KnyzdyJRqVWNAsz9Azwlsg99ZmvjTi3nIPq7UloP6?=
 =?us-ascii?Q?8Dhyw1U5NEeY2BpcR5xURNCqNRJtARLGV2C2f+NnWuk2rHiJA3NI3wWVyV3N?=
 =?us-ascii?Q?LJUJ5RsyePRIYlJCmTfS9emXd9UKdGbZ9z5KSsasLlqDXII3OJ/IarxGeDjt?=
 =?us-ascii?Q?ybPtzAknVlTQ7hZzayVngiA2eL3Kl/CBglsxl1q6SO++K9RuTrLmGjrV279d?=
 =?us-ascii?Q?phfiGROVZU+DPju1eEc7TWdXPWADrJWBw6Ow0OpczOMcPjXXZ8PiLxP0Fzyu?=
 =?us-ascii?Q?MFRWy1GvsJ5YP6/r9Se365T/j2H8bWhRNYorz6l5Yzx6Oy1lm1r8Meprta49?=
 =?us-ascii?Q?IRnPaNS6bjNAsjTtBXK2OTTnshNEzhqeDrXCZ8JvlfB6kC/u77T33ZUGT8aJ?=
 =?us-ascii?Q?K9NA3Bw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A708iFQKRapd8n62bmptSDloXHuZ3tSnnfoPK2GJm0sIIHaaj1fcPrQZY9dO?=
 =?us-ascii?Q?+Ba1HYEuT7WKgvhP9kDj/CUhr53/tizZlbSVDamIsFg8IeXi/vnr64Gvt8zt?=
 =?us-ascii?Q?K2LAEusRERYyabHwGzygpZ+9QyntdUyNnnir+Wzo8AUz+Op16x3Y8KUH1rlW?=
 =?us-ascii?Q?qeiE2TbyF5yAVGy97EgcvgnqEqwWin8mxu9PzBVLCh/qqGKbiGOGKP1LMktC?=
 =?us-ascii?Q?tF1LqhJdZFmrho9iRCr6eB0I8b9QzjqJ0SBz1SnWvgaZ5e80e9N7GHyZtwKW?=
 =?us-ascii?Q?QpPr0yrogYhfzGKGd3bG1w98LG9qSC75agI7b25OO+8VR+sAHK1fsp316jsS?=
 =?us-ascii?Q?EsY8rA6lKSTGVctiDhxAL/kPX/SturlQTbSlfaZVHwOve95JjnhA5MtJ/Pwc?=
 =?us-ascii?Q?qjiNjiwgmWkWpsBjCZ2JiKrWdLnYl+0hjSbBbfyQpNi8C7qR4+T0YCdc7HbQ?=
 =?us-ascii?Q?4cSzxJR7m4PswGYcQwsnoNbXPXG22Fk1bMgHYsh7AhhFsqKFmI8j3BFAuT/i?=
 =?us-ascii?Q?QP2zFns4/V8cqMyYnKPTgVJ8tW68+wEJOk78GARJtfqvizPNEA60JTIHdRVs?=
 =?us-ascii?Q?yg4GUC1NS2YdfCXE6yzWSCjhlJ5AmorGklTOXRcJeWP5DcjDi5ws/3+nIC+T?=
 =?us-ascii?Q?aAiGExy1xmq4t3hoyuQrJkUZfW6dqdBh3yqlVg8C7R/k9sE9mU51ZpNWdFga?=
 =?us-ascii?Q?HyFiq4AgL7Vq6uWAaV0ZuWJvD5u90vi5o/8dKIATHRXz1MeyKH41bqDCJiT+?=
 =?us-ascii?Q?IGQ9XhyVn2I39GNKb2BxC6MOEXZvps7NOSy/vO9Kg/6Z0pKz8l4LUN0gV2tP?=
 =?us-ascii?Q?pofPTPrE6YyMHuQ3xwTL4/4pFwkpkx7TwhQQgBMwVl4T5SzymxyH+PM/3XXC?=
 =?us-ascii?Q?zWcx9HN8SlFmqRer8ve6xpo3h3ptXNEi56jWjpwZPQ08l3l1MhhtVHtzgT1J?=
 =?us-ascii?Q?kc/XLeAEc6TuGTbySHyLkbiZG23/jDN2XIR6bz2lmlq+07m8pbQunfKruJMr?=
 =?us-ascii?Q?nkNLchJ3Z1mCcBWnpl1Ym/0BvwRn8k52z2SKQM9bbgaTML1LRY8bdm2hF47/?=
 =?us-ascii?Q?5I4MMeWbbgK3rHbr2vaBMbbBjT7WiGuPVkWzvHJ7hCmwXfBLZ559DB0mIxL0?=
 =?us-ascii?Q?ojqGMidKOqrWUJOGK7Gldyxdj+xI8SHyP/wfj52pm/nBbVYpjaUJLzw1PF19?=
 =?us-ascii?Q?6/rrGHmSC/kvEtGP5Er1ipds77PMATS1GsT2I8thljkE6lWZbnjmokW+Xyn2?=
 =?us-ascii?Q?5dBtLM+x0Cv4s6jdKcAa6Tzfngr1MAiA+9BVOMchpadUUkJi2s3arkM8SLbV?=
 =?us-ascii?Q?ma/0vbyGayuXhyxhF+lLXL1ypkZoY1q9UUD1tUrT4x4NxqNrhnxIn9prmBLP?=
 =?us-ascii?Q?m701iYzJBbvlEdIkpKbYOVJRw2QvGRjdaI/IWk81+2HunDIIg6Ah1AvJvtvO?=
 =?us-ascii?Q?xTIAZjCDumBtcSwJ9sz8ngAXv2LxbpLujRvEzGUu0802ZNQOAPJV9Ek7lcaA?=
 =?us-ascii?Q?ddQgm/GBfZ+tunDM/s2yjWZv1nUshNDdCCTki8L2ImwiBhNc+blRXja5R6Yj?=
 =?us-ascii?Q?8rpUL6eF/dQRCf8QgsM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927fe61f-cf7e-4a73-5a08-08dcbbaafb84
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 15:17:01.8028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MP91Isxm1KqMCyAroc4m/zyGZ4cbd+obzkkyo/z7oKolgPfP1ptTa9GRbNuOj6XxQTE7aHF/5d9PmKatfMbHbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9935

> Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode
> for scmi cpufreq
>=20
> On Tue, Aug 13, 2024 at 01:52:30PM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set
> fwnode
> > > for scmi cpufreq
> > >
> > > On Tue, Aug 13, 2024 at 10:25:31AM +0000, Peng Fan wrote:
> > > > > Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set
> > > fwnode
> > > > > for scmi cpufreq
> > > > >
> > > > > On Jul 29, 2024 at 15:03:25 +0800, Peng Fan (OSS) wrote:
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > Two drivers scmi_cpufreq.c and scmi_perf_domain.c both use
> > > > > > SCMI_PROTCOL_PERF protocol, but with different name, so
> two
> > > scmi
> > > > > > devices will be created. But the fwnode->dev could only point
> > > > > > to one
> > > > > device.
> > > > > >
> > > > > > If scmi cpufreq device created earlier, the fwnode->dev will
> > > > > > point to the scmi cpufreq device. Then the fw_devlink will
> > > > > > link performance domain user device(consumer) to the scmi
> > > > > > cpufreq
> > > device(supplier).
> > > > > > But actually the performance domain user device, such as GPU,
> > > > > should
> > > > > > use the scmi perf device as supplier. Also if 'cpufreq.off=3D1'
> > > > > > in bootargs, the GPU driver will defer probe always, because
> > > > > > of the scmi cpufreq
> > > > >
> > > > > The commit message itself seems very specific to some platform
> > > > > to
> > > me.
> > > > > What about platforms that don't atall have a GPU? Why would
> > > they
> > > > > care about this?
> > > >
> > > > It is a generic issue if a platform has performance domain to
> > > > serve scmi cpufreq and device performance level.
> > > >
> > > > >
> > > > > > device not ready.
> > > > > >
> > > > > > Because for cpufreq, no need use fw_devlink. So bypass
> setting
> > > > > fwnode
> > > > > > for scmi cpufreq device.
> > > > > >
> > > > > > Fixes: 96da4a99ce50 ("firmware: arm_scmi: Set fwnode for
> the
> > > > > > scmi_device")
> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > ---
> > > > > >
> > > > > > V2:
> > > > > >  Use A!=3DB to replace !(A =3D=3D B)  Add fixes tag  This might=
 be a
> > > > > > workaround, but since this is a fix, it is simple for
> > > > > > backporting.
> > > > >
> > > > > More than a workaround, it feels like a HACK to me.
> > > > >
> > > > > >
> > > > > > V1:
> > > > > >
> > > > > >
> > > > > >
> > > > > >  drivers/firmware/arm_scmi/bus.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/firmware/arm_scmi/bus.c
> > > > > > b/drivers/firmware/arm_scmi/bus.c index
> > > > > 96b2e5f9a8ef..be91a82e0cda
> > > > > > 100644
> > > > > > --- a/drivers/firmware/arm_scmi/bus.c
> > > > > > +++ b/drivers/firmware/arm_scmi/bus.c
> > > > > > @@ -395,7 +395,8 @@ __scmi_device_create(struct
> > > device_node
> > > > > *np, struct device *parent,
> > > > > >  	scmi_dev->id =3D id;
> > > > > >  	scmi_dev->protocol_id =3D protocol;
> > > > > >  	scmi_dev->dev.parent =3D parent;
> > > > > > -	device_set_node(&scmi_dev->dev,
> of_fwnode_handle(np));
> > > > > > +	if ((protocol !=3D SCMI_PROTOCOL_PERF) ||
> strcmp(name,
> > > > > "cpufreq"))
> > > > > > +		device_set_node(&scmi_dev->dev,
> > > > > of_fwnode_handle(np));
> > > > >
> > > > > I kind of disagree with the idea here to be specific about the
> > > > > PROTOCOL_PERF or cpufreq. This is a generic arm scmi bus
> driver
> > > right?
> > > > > Why bring in specific code into a bus driver? We will never fix
> > > > > the actual root cause of the issue this way.
> > > >
> > > > The root cause is fwnode devlink only supports one fwnode, one
> > > device.
> > > > 1:1 match. But current arm scmi driver use one fwnode for two
> > > devices.
> > > >
> > > > If your platform has scmi cpufreq and scmi device performance
> > > domain,
> > > > you might see that some devices are consumer of scmi cpufreq,
> but
> > > > actually they should be consumer of scmi device performance
> > > domain.
> > > >
> > > > I not have a good idea that this is fw devlink design that only
> > > > allows
> > > > 1 fwnode has 1 device or not. If yes, that arm scmi should be fixed=
.
> > > > If not, fw devlink should be updated.
> > > >
> > > > The current patch is the simplest method for stable tree fixes as
> > > > I could work out.
> > >
> > > So this is the same root cause at the end of the issues you had with
> > > IMX pinctrl coexistence...i.e. the SCMI stack creates scmi devices
> > > that embeds the protocol node, BUT since you can have multiple
> > > device/drivers doing different things on different resources within
> > > the same protocol you can end with 2 devices having the same
> > > embedded device_node, since we dont really have anything else to
> use
> > > as device_node, I rigth ?
> >
> > I think, yes. And you remind me that with PINCTRL_SCMI and
> > CONFIG_PINCTRL_IMX_SCMI both enabled, the scmi pinctrl node will
> only
> > take one to set the fwnode device pointer depends on the order to
> run
> > __scmi_device_create.
> >
> > So not only perf, pinctrl also has issue here, fwnode devlink will not
> > work properly for pinctrl/perf.
>=20
> ...mmm ... the standard generic Pinctrl driver and the IMX Pintrcl are
> mutually exclusive in the code (@probe time) itself as far as I can
> remember about what you did, so why devlink should have that issue
> there ?
> Have you seen any issue in this regards while having loaded
> pinctrl_scmi and pinctrl_imx_scmi ?

No. it works well in my setup. I am just worried that there might
be issues because fwnode only has one dev pointer, see
device_add.

>=20
> I want to have a better look next days about this devlink issue that you
> reported...it still not clear to me...from device_link_add() docs, it see=
ms
> indeed that it will return the old existing link if a link exist already
> between that same supplier/consumer devices pair....but from the code
> (at first sight) it seems that the check is made agains the devices not
> their embeded device_nodes, but here (and in pinctrl/imx case) you
> will have 2 distinct consumer devices (with same device_node)...I may
> have missed something in your exaplanation....

It might be false alarm for pinctrl, but it is true issue for perf.

Regards,
Peng.

>=20
> Thanks,
> Cristian

