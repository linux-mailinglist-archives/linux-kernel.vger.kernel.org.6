Return-Path: <linux-kernel+bounces-406144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6F39C5B71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16CD1F26629
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AF1200CA7;
	Tue, 12 Nov 2024 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nZm716pi"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A043AA1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423947; cv=fail; b=YqyCvTlJwOggqOlmd9NCK55fOmrPKMZxHdOJtyxlz3jnowk/3Wx1zEU2yUeAWyrYWu/94lyO42b2HOqL4qt3FSNc+WMneWvsIjxVt9MQHlWZYUCgFaBWC5g+oE3qnb5Y1zrI6l31NL1GRbnRsoZAnt29LzhKAvX5SGKXz7NTJvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423947; c=relaxed/simple;
	bh=Bh9fmJHBUbLYIsJmXRr+SgaF5mCQUkQD2h/NEXFoWmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xjmo58hno5FQjZSkWcDswqk7RnabU9W6iO3aZlzi+D21NKpaUZ/5fGcZ+F4qINd8nmqDEqGRSs+znHz4UnYegk2y6WZyk++xyLMGUyLev07vncZUpubLPPKyYp4B0myWZzv98Rf0R8N+6qqHNP/eZWZ9b/5wQIEZbyEgBbRb3j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nZm716pi; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOo4xZVspj9pfziGF508/wStvQqjfLyDFyO/9cv+vHRbTcV6YsrYh3xkQxMcDusWNzKXpS6xK1IqhXKVUbrttRUCU4cjOTtJCYttSICPcoNK5oPTNb5PYoh2xbgpBStGlKF5ouWzJ0Fbo/1wR/pBKkQ4hovrLUz3B7vNmFIWu2EcowvMBD4Z5ZOh/dccSYNRzRPJl1vMrkasELiqVSnt3w/cVPnCyCM4wiEwKBpse4XzNllSGrH/m+wIjXvOaw+2LOkB2RDSCoMQpfDQttWX6wG/ycX1StqGqHuloKS5CvLnVQE1OIDZf1mhLRrRpCn5cYimocE4Y4mRs7FRN4bE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5NSkrfhJWtislgLgtbKQWP5V1xra4b9EWJes6tvxGQ=;
 b=Mx/yVdKBZekUfgj7U22IzmOLo4XqGP1Fe4JUqN3mWpHgsDe9j+jtihQzk8HEkY+Fys9EvgKG2OofCmclFRSN7PbHjRziHOD4xpyHJfK+8TsKnyrtFgcHr9vFUqmmBGT1tsiXHz1zTpoRl6MHClLrWpFezUKNQ708E+gMAIcr2KrdYdn1xXrW22mKKqwhXkUtKnG+T5hAl6xNqUyiAOBnjlxdKPazySHq3tfCeP26MCbfb8MzycZDdyRa7wh/In6hBk8s5RwWHWw1h3uxtb06tyRpEvyPXJNK8lq/UBvC5+1oJjvT5TafG/Pn3hdAtjOITrHO2SIBRHIPqLakfZlXhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5NSkrfhJWtislgLgtbKQWP5V1xra4b9EWJes6tvxGQ=;
 b=nZm716pieVsfZw8iFxgTGIQ97SaB+SeiXKd34YeA6r/QuCrlxvSH3BI8wZ02sDTElZnrI+otgvGR7+3lQCMWv756y0yqhAWslugmAve9RwbTZAZ/2MVtZdUqZvVp+mITKz9hA+QkmBdQfEKLJsJwMSoELMo+fM4dAAuY1BjpVUEIYMx4EVAQCu19kGV1JRndq847VpRldoIWcI6CLzac7wCJmx4HKQwGH8tAvSsExcvLrkNLTeSRwIHJEIgs2knFpgo+HJy90JL0mQAut0Iana6Tlx9Weqbar15Oo5PcUWlvCm75T8NMXcTaV/mDAVSosfGZq29rDyPLqQokmjnj0A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 15:05:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:05:38 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, open list <linux-kernel@vger.kernel.org>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Ulf
 Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH] drivers: core: clear wake irq in device_unbind_cleanup
Thread-Topic: [PATCH] drivers: core: clear wake irq in device_unbind_cleanup
Thread-Index: AQHbNBsiLuERqOydIk25BCtx4F2EIbKzh3sAgAAW9QCAAA5wAIAAC69A
Date: Tue, 12 Nov 2024 15:05:38 +0000
Message-ID:
 <PAXPR04MB8459FFCD910ED7C261FC672688592@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241111092131.1693319-1-peng.fan@oss.nxp.com>
 <2024111207-baggie-eskimo-d2b0@gregkh>
 <PAXPR04MB8459A924A74FE917897F9F5288592@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <2024111213-eradicate-puma-3592@gregkh>
In-Reply-To: <2024111213-eradicate-puma-3592@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB9415:EE_
x-ms-office365-filtering-correlation-id: 1a8ad300-2647-49df-3c3f-08dd032b77eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Sa25ijMsMr8OL8+0ke1yKg/Era6MIkHgq4p9JND2VZ3MFHNKqOWbCJNa+pJK?=
 =?us-ascii?Q?cyEahhc+oa9o9TA5FVvjhwCJYRVH9J8HvnX6GJrIiB2WgrqEODrNcSyqYQE4?=
 =?us-ascii?Q?5anRFExlHZBx8jgo9O1g2iNacRrsydxOKgzLadUnvHxqaiyVR0iFicw5eEyB?=
 =?us-ascii?Q?JfW5EUCZA0vhQrx5uEIpxOcEHverx3wzTbDoF/74zYA1lFdd/80rRKubP/5f?=
 =?us-ascii?Q?dr4R2u9Mqn2OzZKxjACoWjnhIVnmVz+MMyt+DLG+8b2qx81/7uE/+K2DPQN0?=
 =?us-ascii?Q?zfzpm4GYS3/MkkMh1XxVy7Wwd1nLX31XOJVg/yBXXcxqHoKGlyQ4C5HdB8to?=
 =?us-ascii?Q?Qsrclq/mIMlF1zV7v9v7XvAk3u9LPkSJuW4Br2tbbgD6YLhyt52DeTnYInNS?=
 =?us-ascii?Q?aVirkqP9UqWE23YBsv6ns+P8PUmqZ8iGEV330UkQd/ZWt6jUR3/wun34M1wM?=
 =?us-ascii?Q?vFYfOvySFQCmOvdf7GnCgFnizBG9Xxbmt8cla0gTkJVhOHxtYduNN1Q9YbGX?=
 =?us-ascii?Q?Nc0RCygpjqIv82sBiBIAnbLFWQqkhUjInU1XuyPx/fc9JF6NZtu5kAZxmilK?=
 =?us-ascii?Q?JpJ0sgmbwW+O2iZvuio4CNnpPyx/ShHfSpEqOGazyGOMSKGm3SH0EbaliHep?=
 =?us-ascii?Q?bz67y1PiSefhQyzmauNyXSD1+943VBpJpdgiGKSFAspLeqYjB17qi2mo0EPa?=
 =?us-ascii?Q?r2Ukug6i9u6R8hpEbmO13BQtx2/XEX3hZ+CzSe3U5fknG5MUPXoourVDUiFj?=
 =?us-ascii?Q?BrHi37lSRNHoC9a1V0S2dTneHUVTDG6K2ht6f7T1v4u6ae4oY2lWhpr7ETkF?=
 =?us-ascii?Q?N8UnUq1+4BbNgSuYG2isonzN70vP1MB/v4XdnwiZtkSaR68avMjHcugW+uGu?=
 =?us-ascii?Q?JwQQFHL3dYLSTQfsjZt6LZV0OQG+BzJOzcrCbWLQDSsPam2PPpXCbKcg6sPh?=
 =?us-ascii?Q?9NdYc4OblroQCW6C50tu8WQN8fNaSWi2mV215Te9KW2okNeUAPa/n0qItiA+?=
 =?us-ascii?Q?86HqJyWYdwByT28oEyE20fXGJb10EPWU230SQL15n8b8C45pI8V/1uOYWhT7?=
 =?us-ascii?Q?MeiIUH3thWWfa33ml2El6FQc7AwVJxoU+FRsXan9eYywpQML2fL0PEgK63i8?=
 =?us-ascii?Q?PTJZNEZR/hbppZ8ksaXUxFi1Fu4tRkpOwConUFsiSo4kH9cmRrL6MOPZNgCe?=
 =?us-ascii?Q?TGC0S7wvzh3i2uWKMKKS6IkYh5evkKbfbOp3P1Oi96kNz/xiy95/EazC6FVy?=
 =?us-ascii?Q?nYrMUhhNsU/EXZF682Eh9FxLXbTkwPR36LQrVvxS2xHvkOEqBsyN9jfQcCiy?=
 =?us-ascii?Q?stvnJ5a+a0snV/p6/uBL69rq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yz6Ob6dIpfWak7mlt6KFcFrqJOzu1DtuIauJ6A8cErE+EXP++T874EeB7bOW?=
 =?us-ascii?Q?qovJsb5zwu9qJ791VBf3kJq3ZWnS3oW30eYQ6V9YEaN7uLKqvhw/zaVyLlOj?=
 =?us-ascii?Q?24J3Cs+3pHH4h5Apxn7HroIBmSXYfrDbq4b7OiTo+z1PnEdW4HbKKJk3x//3?=
 =?us-ascii?Q?yklcgSto8PZB5BeJHMNxRpSg2NHulwDVNQLPqgOWM4uPI9HFJFNYu25yfJi5?=
 =?us-ascii?Q?xKY6M5ci+tvqqinrT2XfIeffV8+F+0Z1k2u0YzB41N1Wcgo1izEy1OlTdJx/?=
 =?us-ascii?Q?bs09AmOvewREDR1QJmSuIPnY9HnY1xBNh6STzpWf+eA8DBx9M/rtITZnzQOP?=
 =?us-ascii?Q?KrCr9oPKX+asXkNigoQKgdg1I+agjVa5r/+QXSXjLD4+JHJ5utdfcXnJADwN?=
 =?us-ascii?Q?xIkMftgawCxVoRAUPm9WqpBXAcfTu4yIdkrsmFIhayR6KadGD38BAm9OKrg5?=
 =?us-ascii?Q?V8rBEnE8RC6arXPUaW2F+PDApdw2hWx+pfDbJ43/Tz5HYA6VxnhsSrE8EfJf?=
 =?us-ascii?Q?T8Zx4hC/aztLMcJFDjvrjSqZRMT7EJvinbq6LlvhQlveBpKuJ5t/YgN5TwzU?=
 =?us-ascii?Q?tjdkd92lawpkfKmZOxM4DdXy0e3IKl/pwhX34+xRo3jz6YoYzDB9Augjs875?=
 =?us-ascii?Q?4JQTQKHRmvu4et6qAZjanPNsL1dNvc0b2YGdd+fgqi8n4MszIQzbOx6k/Q8z?=
 =?us-ascii?Q?FY/ajbYwQgvQF4cJnqWH9g1fVp0Xe5stzhvq+VmEnAaCqutAElTY4mXKixCX?=
 =?us-ascii?Q?2oErbxIJWrrZHWyj3Eok/6tFTixGqHHRed0YjqetYdFyQdVyZq7znT3+aulB?=
 =?us-ascii?Q?i9Zee9SE6BFWQrZ4+Tb9M8JpKSVXu5TwrgSurKoYyDf4WhmzLC8/x4Tqo5p7?=
 =?us-ascii?Q?MUOaC5TTf1aig/5ZZrcRCz6ZwJMgOfP+hIlQ65xv2IldOv75jlHS0DX2WIGc?=
 =?us-ascii?Q?cKxTdy9WKKLrOKXxMFrBpH4LMXKvPMGyFgj9SmX5wItG5qqt+P8KTF0W0W/E?=
 =?us-ascii?Q?tUeD+i4sDicovPO6y9xkorj4v7AkQcnYUzzbj79MVepDUpeHemA7ZB6ajGEl?=
 =?us-ascii?Q?vNa2n6D7YQdAnLhuAyqxUXe+7t/5uRPz6DG+a+R/MI0RxA5hRDgH2aUj41n7?=
 =?us-ascii?Q?i/sVy7pyMJcFeN1wywagfmhMMA1vFcdfSCfnsbsIh0YTqacvE5FGmRiBJhxB?=
 =?us-ascii?Q?U8AzWxBPgsZFCDPmXP6VH6tAHVdEFEwS/ek+Zdq2EKdcbbDiztFriXDbix8t?=
 =?us-ascii?Q?QrwJBA+Y/5DnI7VuMnXJrDGhNPIPMiS5kVmlARZJscnoqv0Z6kJOUVFsfnfH?=
 =?us-ascii?Q?fF1Az8u2OzAh6Vb6E0/MEnwMDg4jZh49vuyRpKw0KIswbhf9z0ymg0lXQn0f?=
 =?us-ascii?Q?SS5Kfj/f6VYx5F2unHAqhl2yP7J2NahA1kfI4nrsgbHwBMafkvsmtiBKREo2?=
 =?us-ascii?Q?DQy6Kn0hDAJucAuynsQjP7nlH9Y5WeW8RKvcsBJmvNgvYFAsLpOW1AOm2ZI9?=
 =?us-ascii?Q?jI3zl6maRQ+aLzQM/8VdNXOBjQsMrYRwPobXLgDApvhuOn0ZZAeNxgWM9/8Z?=
 =?us-ascii?Q?9w10qC+EqcewF2JjHzY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8ad300-2647-49df-3c3f-08dd032b77eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 15:05:38.6498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WltjtHsvYR/ATW6eB5dQmOBEZ1WcfzhY/+/atH/0xCwR7iD5vKaD13/IcV6UlKwC3pCxyE0mdD7A6thAkbFOxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415

> Subject: Re: [PATCH] drivers: core: clear wake irq in
> device_unbind_cleanup
>=20
> On Tue, Nov 12, 2024 at 01:09:19PM +0000, Peng Fan wrote:
> > Hi Greg
> >
> > > Subject: Re: [PATCH] drivers: core: clear wake irq in
> > > device_unbind_cleanup
> > >
> > > On Mon, Nov 11, 2024 at 05:21:30PM +0800, Peng Fan (OSS)
> wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > With dev_pm_clear_wake_irq in device_unbind_cleanup, there is
> no
> > > need
> > > > to invoke dev_pm_clear_wake_irq in driver remove hook
> explicitly.
> > > >
> > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > Cc: Rob Herring <robh@kernel.org>
> > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  drivers/base/dd.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c index
> > > > f0e4b4aba885..ea3a871bdd11 100644
> > > > --- a/drivers/base/dd.c
> > > > +++ b/drivers/base/dd.c
> > > > @@ -26,6 +26,7 @@
> > > >  #include <linux/wait.h>
> > > >  #include <linux/async.h>
> > > >  #include <linux/pm_runtime.h>
> > > > +#include <linux/pm_wakeirq.h>
> > > >  #include <linux/pinctrl/devinfo.h>  #include <linux/slab.h>
> > > >
> > > > @@ -556,6 +557,7 @@ static void device_unbind_cleanup(struct
> > > device *dev)
> > > >  		dev->pm_domain->dismiss(dev);
> > > >  	pm_runtime_reinit(dev);
> > > >  	dev_pm_set_driver_flags(dev, 0);
> > > > +	dev_pm_clear_wake_irq(dev);
> > >
> > > I don't understand, you say you don't need to invoke it, yet you are
> > > calling it here.
> >
> > I mean not need to invoke it in driver.remove hook. With this patch,
> > we could remove
> >https://elixir.bootlin.com/linux/v6.11.7/source/drivers/input/touchscree=
n/ti_am335x_tsc.c#L498
> > and same to other drivers.
>=20
> But you did not say that, and you would need to make this as part of a
> series.

Sorry if I not describe clearly in commit log.

There are many drivers are invoking clear wake irq in their remove hook.
I was thinking that if this patch got accepted, I could write a patch
to clean up the various drivers.

>=20
> Also, are you sure that ll drivers want to clear this irq flag?

Without clear the flag, module test will report a kernel that
wake irq already initialized.

  What is
> wrong with just doing it explicitly in the drivers that need it?

Nothing wrong.
Dmitry commented on my patch to see whether the clear wake
irq could be done in driver core or not. So I did this patch.

>=20
> > >
> > > What commit id does this fix?
> >
> > I am thinking to take this as a improvement, with core code has this,
> > the various drivers no need explicitly invoke it in their own driver
> > remove hook.
> >
> >  And what bug is this resolving?  What
> > > drivers are broken without this?
> >
> > See here:
> >https://lore.kernel.org/all/ZymxvLMkkktRoCXZ@google.com/
>=20
> Again, this seems to be a per-driver thing.=20

If driver not set wake irq, clear wake irq does no harm.
If driver set wake irq, clear wake irq in driver core could avoid
various drivers doing this work.

 What do you break if you
> attempt to do this for all drivers? =20

I could not guarantee on this. Sorry.

> What about drivers that share irqs?

From my understanding, wake irq here is per device, not
related to shared irq.

Rafael, Ulf may help comment.

>=20
> How was this tested?  On what platfoms?

Test on NXP i.MX9 platform.

Anyway I put this patch as an optimization, if you
think it is improper, I will go back to do a fix
in the=20
drivers/input/misc/nxp-bbnsm-pwrkey.c

Thanks,
Peng.

>=20
> thanks,
>=20
> greg k-h

