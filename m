Return-Path: <linux-kernel+bounces-308692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CF196607F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE17D1C22B17
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0280118F2D5;
	Fri, 30 Aug 2024 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MZyuU9fy"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2037.outbound.protection.outlook.com [40.92.42.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5017B4F5;
	Fri, 30 Aug 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016890; cv=fail; b=MJgdfLoB/kFgHWN6sthQ3H8NsIr2IYHO1oQAlbzxsv+2kXv4IWlZABcVs9eDoOV8gEWSiXtrYTzakJI/6QeF8xwGdJTByCoJ34EPtRRrUff6cXS5xvpHKMDwZUl2tLb97CmLf5OMslytATb34ERHOyaDP2BniZQ7ICuvcw8ifgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016890; c=relaxed/simple;
	bh=KsDp8LgPkvVDHBaTqRuqQwVuznD04IboiBW6Lfnt57E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RK8lsjtCpgp1x0wrS5s4CWX1nvctKMGZ8x/mAlIXZm93LC4lyve+PqYSqoRWqyWyvOY8QMY26oBSNuA3Iv9oFgvAn9TJB8YQdy97DYuKaPZu0gXiXwfHV6468iU5yeV2Laip4Peitj/R1sq++ervtcqVXPdzMC5EqfzEeApIbX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=fail (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MZyuU9fy reason="signature verification failed"; arc=fail smtp.client-ip=40.92.42.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtIPNUoadn88SC1XKOpeXCpOApWAtdhfPMq8kZwXGdeyQ38MfS5vY1cdzC8IDzekHZ85UrtrfLUgXfHbQDbxmdyIj7PZdxCM1h9AQLSi5juGOEfXBvSVAqTEjO66X5xI36Wquu4SJ99yMM58Ui7pubWKTzZkZrkAYkZVEf29Jryv7RMNzrR+9XKODAzgxA/WeC+5yHAHVlLsaOOFVIANi3xof9aurglB/CaRVQvAe90ES9lHno9HWQxlwkazhZO67HPKcxQQm1VaKPLZRBTc2KpLzKKGj6N+23Me74+uYb9wo8NvEofyzc/+wg/kiHY5IshtGruy98E8xJlY7m/6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBw/ShkxgyCx8P7AI3iBmG4g1YW8TotUnOsQziQonwI=;
 b=mNIytMKrg8BC/NwAmf/IR+w1R/GGWPTrKfIiac/Nal4cSI27iEbwGpVrEfRUVT9Vf4FtMtC0NXS9fOr4XKYTnWdffbbRy0Q7f4xAM7h0b8yuYVqm6iNJMrjdiWKG7BaMWUz1HZQqLqoD9GQXcPy67ieBRqXavaCEUy+dLCOst5fOokCIIejE52q2wFaR76J4snv24AQlh7Eg7mrOyVlCn+SpEx/qOrUV7olK/IYN0af4OZIYIpdnztTIDsUemu+S8fHO+bbfrtfphMS4B3uOISt6PZ+r8Pc8J4qHJz2G0Qd2PzsU5Tah4zskoAC2ha1oyeGVPTmfXMFO4FC5z275kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBw/ShkxgyCx8P7AI3iBmG4g1YW8TotUnOsQziQonwI=;
 b=MZyuU9fyG4FquVcsEC1oxtkXgXmX/ygfuExhLDM136ToteaTnqrj7MXapAIfl7XIVrHVwTVNbpU7qD/Y+5btM7o3zBAzbi4Chw7EQLcBldmYkEkkVhn58RzHCn3WzbYZprmg7CAahn8KWZPuF4BQUn4RsDIhjx8UHrg2tPeMzYOa9j2vQPXso7wAOmEvZ7MeqN8/PfHOAUeuuC4pMl1At2W56Vn3mnA6OPDwYsNJWmNNkiYrvC11QxnKMb/7QroiAmK2TDIesreHIBjTfMOw3nAnV01puszHu86TgPkKQ13ylzvObrjsrWB1zEroDCiTRpZngtg1s3dZK2d8xwdldA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ0PR20MB4383.namprd20.prod.outlook.com (2603:10b6:a03:42b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 11:21:26 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Fri, 30 Aug 2024
 11:21:26 +0000
Date: Fri, 30 Aug 2024 19:20:20 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Chao Wei <chao.wei@sophgo.com>, Conor Dooley <conor@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 4/4] riscv: dts: sophgo: Add LicheeRV Nano board
 device tree
Message-ID:
 <IA1PR20MB4953AB5F2E922EA4E1E74184BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
 <20240711-sg2002-v4-4-d97ec2367095@bootlin.com>
 <IA1PR20MB4953612773890B94FFD0C9EABB962@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822AC58BC43FDE03802E773FE972@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <1b202582-0487-483c-ba80-47125551eb5d@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b202582-0487-483c-ba80-47125551eb5d@bootlin.com>
X-TMN: [aU/dwTnRLffBxQ1mLqobZvg0f7h+9W5hsoabw+EzwTk=]
X-ClientProxiedBy: TYCP286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <imjioqy667h66iltv2ljygn6f5tnp7lzgsw6y3yxbnm4oxdjv3@sixojxedap5e>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ0PR20MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc660fc-0ff3-4c95-9f85-08dcc8e5e2be
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|8060799006|461199028|15080799006|6090799003|1602099012|440099028|3412199025|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	/V2dbM2EIMo4/dk00UDuDQZZGDhAWgO96ZAgXDlcZynFQ7rGX8mOSviUKt3uWZrMtx/esx2R1fg87hcqFJJxide+QeYQ9KMOvqjHwX/1OThSRTAwJFhENuDB3pMg+8VV9Uswmc5fZLXSYsdwrh31n1AC+grc8CL70gyNY8wRCXAHMqYyh1WN4VAib8ZtFxsfEPBQ1VCZeTBRn98L8z6mDY51xJtQ+OpndtcHmpd4d7HMdJO0SY86fy9V6fwLU7n6Sl8KkQR0QqmdIXNkLyqm+Q8yj+S7hg4I8NIxkWuxFTnAw8PgpZvLeh71zplxnXOuVFGlFpFLYOcYufnpWiL/fQblR7xQoJDL6eA6Uz1NBQpAlh6Gdz5c1sR1Rf4d8084U1BQlrnTuyU1gCi4C4tcNsUQ8gGrwg4X4S800WEdyTiOJvAgXrWAwvqA/1RIrO7Qz0NYVDL6umcNYCXSVtiCacCm8VTA0HNnfAJ4nEvt7TAx3+jKyDwZMTavFVn6VREhYJFK5ILullCzG16zOHJWq6cKnAvCDRwzwCytPTwDc/l/okQ6jf2PdSd5jQp8AZGAiDj5mkfTDaNcVcvSmtoVKY1FKTqQygoVozLjPSft0Niaxc0HJSZjBkfxN67Qu3L+KUrwoPnXeyqaePe4mHvUSK0OVhXwR9sKwQGUZY98DP0fdsS0W2T7qEua/zKZODktvzPiW80dIyBNNO6yhBWOJOEV4vpkhyNrTcrvsglyfUsmY2ggBAyTsQKtWslF/6qtVPu6g22DI64at+u9H09UfoZYUkX2sishPF+EOe8AFQnVj7e2C8pFzFydBJtDblbOAGQjL2TJwee9fMR/whjUFPLyGsZW2usx1sG1/rsZGK5I0B23O66Uz/5VdmITixlEOc8UrrIW2OcUfGoG2n0vZVKMhGCmk4z7RzhJ7lkyp20=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?RVmg1x7ljtICz4qIY9E4V+DlA0EGf6hSus8bvBUacfnu+KakRAalQREyb4?=
 =?iso-8859-1?Q?7KIj9W+FSdGy0as//NFriLSVrzfkuu8LnctYVHqON1SyY+MML6jknSj8bd?=
 =?iso-8859-1?Q?+NJkTLAQmyEkpIMRHSV+/W5UGdgfFsIKAkf1BcgUZOZltxVt/SgrxbjI4g?=
 =?iso-8859-1?Q?K7BT9gXxyi+ZOvfAWcBKbQ02ywIUqM27y8kd1N4k3gDMxpB6uxWseXbz0F?=
 =?iso-8859-1?Q?bCJYePaBS5Ae+vc8jS5fcS3jrk2zBAJ9nQpvKyM06q4YltdEIUD7flOAvb?=
 =?iso-8859-1?Q?AEVItNQ7Kwe1oaB06XBarUFdZZPOcK5QxrdfLQDcomTgbhMWUFzfR+/81g?=
 =?iso-8859-1?Q?wzby6acFAL+5RNfqqFx7gyy6jKnYa6rUMH98EeWDGxuNI3K3bC+eRTzTwf?=
 =?iso-8859-1?Q?9xX2Ba7DV06A6nPm2+KGEVqb+AF4FgNteWtxx8VjFm6SMwIkv/YgX/o95+?=
 =?iso-8859-1?Q?X6uCFvHFcZxrw7cMaGE3C1FM2sPOAnU81Exme0TForI9DshD7HT4pym8Qt?=
 =?iso-8859-1?Q?LLNNPq+ED2NQHBuZJKmTbGRP/0LTVXewM5XkckfNid2CXJjVAhT+6soE11?=
 =?iso-8859-1?Q?V34o/zN8tpJVW72VqsdTXxv5LIPb5tFT/uJNhokKACXPmETSGFonJjD2Xd?=
 =?iso-8859-1?Q?1XIwRygp2NQC4slHpxay5bjJQAJtB6Dao7hwHvXBDs8ACBUUm50gWYzJaZ?=
 =?iso-8859-1?Q?r6JqjIfLbbemVaVyqlXMUzBaFXx3cM6FAjuKGA3Fc3duXVreUTNT8lYTo1?=
 =?iso-8859-1?Q?MA0oy7lWygz5khpSK19wlf+hRu6XYWKk6+KwLyMHWuF0uNUy2mGU6AAEhT?=
 =?iso-8859-1?Q?MhEo9uBwgGvVtjdjTPROmcsRBuJGifsEfm8YLZ9wJtivO+kcnenAVidEnL?=
 =?iso-8859-1?Q?3VaXWmK2Ox27pSJ0A242fjGZVrlhfrYUoGH6PNJkNivVt+zpMkOICqnKUO?=
 =?iso-8859-1?Q?KqzbFo7aXaMeRaDIcfZWhTbwBkj5k3nOKiB2diNZXu0BQwLsziQNtJGxNV?=
 =?iso-8859-1?Q?25XmYuDYIyOoxYmGUBu+02XflI/+8MyvPIkhWxLTvreBXbhSmytI4x2kA9?=
 =?iso-8859-1?Q?0RKC/fZifq+wa7DBXgkkvxJJ41SteG9IFy9bmfm1dBZBwPdkXeNWYHNmgn?=
 =?iso-8859-1?Q?ULg2Mi7GD2lKcbVYF8EfN7AhqtO1Nl3jg+rHHv0KOKvPealAmUQphhwhAx?=
 =?iso-8859-1?Q?bi1BHCavu8qex3Tf9nLyhU7DCW4F67ovQ6DSucgyopiKzhBDpN5oQmRHKW?=
 =?iso-8859-1?Q?MJPArzSmuBcrIcwvekhSxelobHkVy2vLDfnWCOmAaP2MKPnlbh2ebo++St?=
 =?iso-8859-1?Q?xE6s?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc660fc-0ff3-4c95-9f85-08dcc8e5e2be
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 11:21:26.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB4383

On Fri, Aug 30, 2024 at 10:06:45AM GMT, Thomas Bonnefille wrote:
> > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > +/*
> > > > + * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "sg2002.dtsi"
> > > > +
> > > > +/ {
> > > > +    model = "LicheeRV Nano B";
> > > > +    compatible = "sipeed,licheerv-nano-b",
> > > > "sipeed,licheerv-nano", "sophgo,sg2002";
> > > > +
> > > > +    aliases {
> > > > +        gpio0 = &gpio0;
> > > > +        gpio1 = &gpio1;
> > > > +        gpio2 = &gpio2;
> > > > +        gpio3 = &gpio3;
> > > > +        serial0 = &uart0;
> > > > +        serial1 = &uart1;
> > > > +        serial2 = &uart2;
> > > > +        serial3 = &uart3;
> > > > +        serial4 = &uart4;
> > > > +    };
> > > > +
> > > > +    chosen {
> > > > +        stdout-path = "serial0:115200n8";
> > > > +    };
> > > > +};
> > > > +
> > > > +&osc {
> > > > +    clock-frequency = <25000000>;
> > > > +};
> > > > +
> > > > +&sdhci0 {
> > > > +    status = "okay";
> > > > +    bus-width = <4>;
> > > > +    no-1-8-v;
> > > > +    no-mmc;
> > > > +    no-sdio;
> > > > +    disable-wp;
> > > > +};
> > > > +
> > > > +&uart0 {
> > > > +    status = "okay";
> > > > +};
> > > > +
> > > > +&uart1 {
> > > > +    status = "okay";
> > > > +};
> > > > +
> > > > +&i2c0 {
> > > > +    status = "okay";
> > > > +};
> > > > 
> > > > -- 
> > > > 2.45.2
> > > > 
> > > Have you test you patch with a real board? Especially
> > > for device "uart1" and "i2c0", I suspect your
> > > configuartion does not work by default.
> > 
> > Hi, Thomas Bonnefille,
> > 
> > Can you please double check and feedback, I want to confirm this before
> > acking this change.
> > 
> > As you know, rc6 will come next week and I'm planning a pr next week.
> > 
> > Regards,
> > 
> > Chen
> > 
> Hello Chen and Inochi,
> 
> I'm really sorry, indeed, those nodes certainly don't work, it was a mistake
> on my side introduced between v1 and v2.
> However, I can ensure that "uart0" and "sdhci0" are working fine.
> May I suggest to remove those two nodes? I can send a new iteration if it's
> easier for you to handle?

As you need a new version, please add pinctrl node and necessary pin
configuration. And I will take the first two binding patch. So there
is no need to add them anymore.

The pinctrl patch (note it also needs a dependency):
https://lore.kernel.org/all/IA1PR20MB4953DC78BB0FE0C57EA94F91BBB32@IA1PR20MB4953.namprd20.prod.outlook.com/

Regard,
Inochi


