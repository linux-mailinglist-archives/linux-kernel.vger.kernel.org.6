Return-Path: <linux-kernel+bounces-405896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE669C58A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BF528115E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ED913BC0D;
	Tue, 12 Nov 2024 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O87fqqxp"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2080.outbound.protection.outlook.com [40.107.249.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2071136358
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416968; cv=fail; b=Hsm64o686b97qvxWISEd5mIQ/1RwnBSBl4sl6QRcPT/QMBzA7fDwInaiG2S6pQLyx9in+uK11YI/rnOJl5OjVuaayoRCVeqOznja/QSEQYJvstE9zRepaCDu6PgJcOOKuHNXoSIOemE1xi39aDSjzdm9KfoKmYr1JyfsnhcH9WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416968; c=relaxed/simple;
	bh=8BQd8a1Q1qAdwb5J3k/lt9Tgv1Z/mFOleV7DzIYminQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xc9m8eodpGrpHEed/2zg+Ed3UgNGOf1LIoRgO3ufcGkvG4qGRnwkJVXqLuVt32ONfQl8DTuLyXmaTYKCbr3+fbKwL4AGyV11j5nr2k5ucuWR9YHFFETjH9uJlEjiiffgw2o99pwTYRo6heg8MBuBiB9EctbdNLrd2RUW+jMm/j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O87fqqxp; arc=fail smtp.client-ip=40.107.249.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKpGFDzZa4qX5PU+bVcWrsn8QMktcFXnca6QGSQ71Zh33/DxVX75smex0lBsoUgc124y7ZSAOVFrT3M731M+f9Qnsz76ehFd9gKITnIXVNMMzlnsOjd6d1hFwli2f5iEvuGv4k4dVlfWa0TWQJPD/iJPFocNiHKoL9FMY7s6gvcxiCjNceGZrLVMdTG3cporHnvgSp2+r2e7la1t9r1d6g+2QBmB7mCnkholgUOQsvDq8rmGFjV8LFz0tNuU9BZhe/95qLGAJ5qvw8qYn+dgj0zAgz1BgJDd+jN8xLBuBlwptrL7IxJbpkngBL+UDgCejirnQpEEkk+SkP2OqlvRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9lXdItkn843nTQyKZfIhXb7sjSGLKNJ4CERkGGkIhQ=;
 b=rRn11j0NjX9q/mxCyDGvGInDXuc0sJpX/Ag8WeckbDHrbtQeyc32uWRyvpT5Ndj3W10SFpq5a4hEVQ0WOItOsuyQKMgikLBc8V21jGC3Y5iiyU8BENzcT/46j/iMDDeICltHXIoERwImAMOeu7BrLMl+taW0fJCL9KPxqa56YYnFwLZdm6grKAdU8wXo1q/tbg93rKAMLmAd0Ryg++nMrpErHl3oMkcDm4E9T/RJ/vg5LMCKU3G0wbkaB+o4QnuZ0yM8as3a0HmyD28JQDY/9tKvBEPnAlngMfof9sbkX6/1RyJQ3VUy4e16T82gxdl92nL6cFeXqXAh7woWQpBPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9lXdItkn843nTQyKZfIhXb7sjSGLKNJ4CERkGGkIhQ=;
 b=O87fqqxpMXN7EmM+g11FlYuLsggdFHxY0OmjcnocpVJ2Rp7n/YHFItitaCN0Bl3mDi4SAPmAfY9d4cbZvu0jOtENJZ6taUMI/07LZxUYrfZyD9mIdCnO/k6VhI5l3V7ooK5fKCHr43fuxd24ziVAknrz1P88wEekkp3F8gEeTdaZ4nfOfvB1tmrpYI2HYgDuIQdeKpsag8W40eYjjyqDov5UHCAB6NlrP0ONqSZX59htvMS/2nKtDPhCgSryOfl9iUlmNEtQPWxfh2TxYTu2/sjwXvlRMdb7c7ZozKHkfKQP4BSTN4jJSLyMZ8kDLOY08nOLLcAarQPZ4eVKYC3xkA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 13:09:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 13:09:20 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH] drivers: core: clear wake irq in device_unbind_cleanup
Thread-Topic: [PATCH] drivers: core: clear wake irq in device_unbind_cleanup
Thread-Index: AQHbNBsiLuERqOydIk25BCtx4F2EIbKzh3sAgAAW9QA=
Date: Tue, 12 Nov 2024 13:09:19 +0000
Message-ID:
 <PAXPR04MB8459A924A74FE917897F9F5288592@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241111092131.1693319-1-peng.fan@oss.nxp.com>
 <2024111207-baggie-eskimo-d2b0@gregkh>
In-Reply-To: <2024111207-baggie-eskimo-d2b0@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB9787:EE_
x-ms-office365-filtering-correlation-id: a0d64069-2bf1-4216-4af1-08dd031b3855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?j8zuFBGwu8iwjB/34OukAVZjceXuItQdbmfzyxplWmz5F+4Xbkgtmi3cZnd8?=
 =?us-ascii?Q?0m4rh9GoFtxd1swQK8laK7CQGLCitdd1MHkLBCmVfuRM1FERg8q79eervzcx?=
 =?us-ascii?Q?0Wrq6h5KCTX7JAlCqtQC6LH/V6yeTi4zfI79xpDPf1FVoW7ec2rBLYbc2cvW?=
 =?us-ascii?Q?qxCmZIi0u485C9LVX5UTnTJAts6IgH0d9By6W99DKpZuvaFXFdG+mNMZ8gGL?=
 =?us-ascii?Q?GcryQkW8uHUoK4vQW0mpJexIIp4R5dPb42nTX6JmcIbo/jwviFOs2sphtbDn?=
 =?us-ascii?Q?txW3xVrq5ROyD5dWx0z5WYdMjPeqb0MuPp8wMJrmkq3z2F0M++0bd+YSuhDh?=
 =?us-ascii?Q?jNlnajbp4C1Yen55duHz6Kuc8EcZcZ9t4A69AkQx3MNM5uQ8DLTe3jFbObPm?=
 =?us-ascii?Q?Q3G/bCmEV4UFA4Kz9xevs+DjpTa7hmf7NV7/9gtz2s8ieNnKMlYAf3nsH+/d?=
 =?us-ascii?Q?Wcl2BMBIFw710IcSG5mr/IoBxrraSba4gmCnzUgvuF+/KN427z11tOdJ8lAa?=
 =?us-ascii?Q?F7SQnEU4C53fzJB1K49onPhar6ZrCPGYaTXNKhTZadm9DXpLNbUzl1AMrGes?=
 =?us-ascii?Q?K9oJXaFnmiKtLj/L0pfr85/3219q7E+eFS3/UDJMBWBe3gPgGoJbkljkzVDY?=
 =?us-ascii?Q?NZGvyRCHrYmgJnK94X39WlRfkOUrP80o4XIt4Xw3G9viS0GqPNVaUivB7Gue?=
 =?us-ascii?Q?yKSslU77UBDq4AOHeVZ2xV/TwogyxXJgy514zYA/mO0BlI8FWEseysdT7KVe?=
 =?us-ascii?Q?eItn3JMxsJAbJXYT4IzHV9mhjuHaT/i2kTCjpUmJ6W/e2+dEWDSXMogibcAj?=
 =?us-ascii?Q?J/3djqf4FcZxDvwMTACG8VOwTSfXJpUnqhUo1EKs+U2chbmNGntu3apBtpI8?=
 =?us-ascii?Q?bCe47mTl/fYvvhiTbZD/jMFIQzfoXvc2wk7NRV9tnYbn6DSMTmxKvxlb37Kf?=
 =?us-ascii?Q?ppaX9b3CH00cnGWBYVV+yBmM75hl2mLy5Cmo2En97YQFnLyI/f/F7FanTBYf?=
 =?us-ascii?Q?FVLwLtfaQG9ozQNKBnWfYFWHQ93S8wCrNDRWSftZVUXNQPfp5caC5o4yLO1b?=
 =?us-ascii?Q?ANJkvV6/6PyqKPsZNrLHmDu0/4t+5ZgfAdEPxlgqq9KraPsQ+ll3TrbiVF4N?=
 =?us-ascii?Q?EtGLC42MNMR9DTRx6rFwttBUwVFtcS6Q3ErYwe4/bfsIl08xxLsZeEL3AUt5?=
 =?us-ascii?Q?kiRFWOtPyeeAzMjlwIxcN4Rjql+LSPFZbHXeamU5mSlU9u5Qcd0pk53JI7ye?=
 =?us-ascii?Q?IAGCk4vS4CRKxXQUAIAtMHj9xqlVncVAHbIDhXV1ppGKvjlAb1KvnMaULFdU?=
 =?us-ascii?Q?a83y1CpWNus4sFjjZmTAnmg0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rS6yuQyrUmsv9GpS88Wyqia+M0aFXsHd/XpFcW0tiUeK3zECv1gcvwHAorK8?=
 =?us-ascii?Q?bk60SfxhrsvogAX3Gtc4TNP6iFoAT2V1d9UUfWPjfnGROhkYYDoIg1N1BN5I?=
 =?us-ascii?Q?aDnN+WYM9mZSPI0k7/Irx1/FZpYdrfFM5m+IFg02Aj0euo72aEtPNfbdiAHB?=
 =?us-ascii?Q?xO7IFcfT05gQYvCPMSK2M2KgmyD0yZjJPU9IWT2lvAXavRYbuMnhviwF1bup?=
 =?us-ascii?Q?VR+IZ+Izmi72ocOq6zJXl9IFg4UsKGBAhwsUWN/E8vnhWgPYDfiwzSZrcxO8?=
 =?us-ascii?Q?Z4gdM24PDK1jkD6TFeJurqn56UIkVBrbYB79RgNJAu5rNTE2LCaNdLVmoPY8?=
 =?us-ascii?Q?Q4nibQnm1Wva3ssQTG5UghH8imlfmX1Uoiy4tIfvXHHqQ4c1DqkLGWVSHC53?=
 =?us-ascii?Q?YQg7iIsp3FXJQhfkWkL9aPJolDx/Gh07eienub1wFjFphv3Mp9gCOn12btZV?=
 =?us-ascii?Q?Bq6x975RcOUY/rnDr/THqPwEhkY0rQi82r7VaRZEiF5tcWpCe7WwGE6oD07Y?=
 =?us-ascii?Q?cNW2HuU+yEng9Fk12NzbuzttlhQgiVmqtzE7qjpUcofQmn08qxh2i/xypcfV?=
 =?us-ascii?Q?o330I+9UjvjY6fj6ktlpVs+LBehVGYFB9NTiF8yDapVK8beFquMhRPCcrDCi?=
 =?us-ascii?Q?IKIF0Ba6+vWrv2GZ/AQasTC/fvOO9sbrVlJnXzFjb9miCEs0b1hbXOddhEyK?=
 =?us-ascii?Q?mmUDdp9o6srzXIdqW49p9EV7xmQnNgUDGB4G/TRdkSqL8DfYrqQu1FO4G4M+?=
 =?us-ascii?Q?VnO93gI/olPmN/UCDqDsjSQmcgWBy9IjMPOkgOW/YOcwKFE0kyVJS1hUcNeE?=
 =?us-ascii?Q?Ufdaz4y4a0QGPFBFrwoW/IKaDpW3hk+gCoFkIu0EGG2Cep3ZeYNR8adknWKq?=
 =?us-ascii?Q?eGhQoKOix8j0hwYBzv2dAEcg6eq5xiy+XS8MFne5DmqsWXcKgjuex0F24rUF?=
 =?us-ascii?Q?MKO1uIiemJDHxmaCvidjZmjjCMMdhIFD2Cd0PqaeXKOh/avr26OBJuDZ32KJ?=
 =?us-ascii?Q?vvgXyB1g0GqKWHmuzvtji4wvoa5f5aFmIRue3m3v/ytYY8IZ4mk1AyN0MUVs?=
 =?us-ascii?Q?LtbKJbbD6/Afp+Xe4Wri+y90hzN4IjfMoMmhsSTQ8n1bPZ0j/CzwlOxC9XBE?=
 =?us-ascii?Q?uLtLN0XHMyvmR1HEsVIrL/Th4oMt7ZqQP7/2rUPg2UEkBhOc7h+LC2QD+6MV?=
 =?us-ascii?Q?bcWQZjOR2OVETpkgRVQ8wyaYPzpbPokNe2vvdyzUKPiz8i65ZdqSVPNzv3er?=
 =?us-ascii?Q?a61aBJuuZ6eChTO/Jfsb61aY0PllDG/XTrzoDXfWqhv1L/43+lUnuHKDgPdv?=
 =?us-ascii?Q?70bJQqC2FuUZQOhEHY0JPGAvNo4bh4ser65D/TW/KuJ8wJBuTtBLXaiyqFMo?=
 =?us-ascii?Q?VCcnc93KhkpoSzSsglhoo1BxjfUCo34snA00sxziy+dhGpDgvgotDKR9f7Tr?=
 =?us-ascii?Q?LSj2R8ah2MvML4FMciZsPbewP+7By39cKIUVeV3RyZSwxzKbooaodVCTPh1p?=
 =?us-ascii?Q?/Tp4j51szsxSsuFUBIhExx3jQph5BLk1tFBfKSfY4mIrz/tUB84OyFsCvnFC?=
 =?us-ascii?Q?z4V1pRJFzWgHcx/zuhM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d64069-2bf1-4216-4af1-08dd031b3855
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 13:09:19.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3WCPQqIuqCiLbSSpTdhcwzXvDKM546hV5C3YWdoWgvqK0A7bTF6L3Ar+GlUYCLaznWIVLLn6LeY1S//u5QAPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Hi Greg

> Subject: Re: [PATCH] drivers: core: clear wake irq in
> device_unbind_cleanup
>=20
> On Mon, Nov 11, 2024 at 05:21:30PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > With dev_pm_clear_wake_irq in device_unbind_cleanup, there is no
> need
> > to invoke dev_pm_clear_wake_irq in driver remove hook explicitly.
> >
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/base/dd.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c index
> > f0e4b4aba885..ea3a871bdd11 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/wait.h>
> >  #include <linux/async.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/pm_wakeirq.h>
> >  #include <linux/pinctrl/devinfo.h>
> >  #include <linux/slab.h>
> >
> > @@ -556,6 +557,7 @@ static void device_unbind_cleanup(struct
> device *dev)
> >  		dev->pm_domain->dismiss(dev);
> >  	pm_runtime_reinit(dev);
> >  	dev_pm_set_driver_flags(dev, 0);
> > +	dev_pm_clear_wake_irq(dev);
>=20
> I don't understand, you say you don't need to invoke it, yet you are
> calling it here.

I mean not need to invoke it in driver.remove hook. With this patch, we
could remove
https://elixir.bootlin.com/linux/v6.11.7/source/drivers/input/touchscreen/t=
i_am335x_tsc.c#L498
and same to other drivers.

>=20
> What commit id does this fix?=20

I am thinking to take this as a improvement, with core code
has this, the various drivers no need explicitly invoke it
in their own driver remove hook.

 And what bug is this resolving?  What
> drivers are broken without this?

See here:
https://lore.kernel.org/all/ZymxvLMkkktRoCXZ@google.com/

Thanks,
Peng.

>=20
> thanks,
>=20
> greg k-h

