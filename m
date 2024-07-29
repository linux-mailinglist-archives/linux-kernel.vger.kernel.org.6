Return-Path: <linux-kernel+bounces-264927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586F593EA43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44BF1F21E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 00:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BA423D7;
	Mon, 29 Jul 2024 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qf6o7FRe"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2058.outbound.protection.outlook.com [40.92.23.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622157462;
	Mon, 29 Jul 2024 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722212685; cv=fail; b=I90my0rUccDXySbhMpZg+akIZ7CKwh6vhvgVJhHLtPFAxFduaSjT+H0HBczhKq925Pt71soW+MlJ0g0ieo8iWZf4wjqYgQ15sULDe4PK1rFVQKlGfTBCh1HDc2f1+8qpLBlQ4apqI1079QXOdwq/meiZC+odKQjAtEzHyfzIWrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722212685; c=relaxed/simple;
	bh=AZKZHDtK6hgGX1fzdgq/ZYx2eOtpuzrkrS9jN3kJqNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VABYsGTYpzTxag+KpN+p1gfcW38w5iETNG7629ayiJZwzfbGOypKPW37h91pyAmQ/6AU3UdHyOgjH7XvgE+pwqlViDzRUiCkSs4N1Uy2Xy5z0T3RT3pdfcKA+ycNp+6/QOcrXvbZdn1ADgo5ZOkaYdgVN2h1eyZUb17GyhW4Fhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qf6o7FRe; arc=fail smtp.client-ip=40.92.23.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8Xhs6Y172zP3fJ2OyLlupaVSuv0jPA67H9ymsnaJG3ZBi9uL3k+u1Me3PGuYxCO/QH3KBbo26BrsEt0oYcJJZobZHlhTqLdK83Q1E2PkwePVBlgNC3TQPTe4P0RnRxK+85hh0L2W/5EiCOSl8gqHdGfMF8Fw/APGZB75WHjmj78tdWMvpqDkr87MwWvKfuxhLj80z+y7rLqOJcAWdyoWPB5SJmMtclDxDD4E9+KpsRYN8o1B1wo6iq8USJzMPYo4YGGOgFcUYNEiF/lXtizdID5fBHa520yZIIA7VkTk6L2XbAQaR5PxIynTuLPg2+uBO1Oz7hfz6ABUPe64xFq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp7XdrNo9pSv7YpMlGpP4RfK9cPjOaa22RNrEUUh/uQ=;
 b=NL5ZY6dgupLZ2a08Y9A+GusGTyXYd/wj6gM71sljG+JMi/1Z0bXP3HNCRA0eq9XJOycqEiujsG/9ihdI0luMzL7Rn9NecCU0D5ASL2f3ID0c4yTAnuYRcxtATCmYQ+7eyzXK58EeYpipaR3omA1SwnlJXovbrepUNivJoo/lsPyFyj6l4bWzYL1TeOpY0ihSjdb8kQzNXzqtnGnvoOM2KyO9fVX2Yv7hUckXRDHMbbrzubYg34K3Eoxlhj5l6r+wx5pm+6/4mzswUk88ReDBjh1mBrLJHMG6DC+PbH0Y81XeTddQMdGd+kmKTNaRVobrWZo3eNbtO7YzZ1XK0dsWbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp7XdrNo9pSv7YpMlGpP4RfK9cPjOaa22RNrEUUh/uQ=;
 b=qf6o7FReQoQP0s6+Q5ErwY1mH9wAXUEf+/HngYNGCDrfBKlkNlFMogv6t1Ww9wb0+YA2cJwAw1y6ZvBNU19hkJAV93DAVpuAFfCoh3yuxR2BKqpeZHwFWzg9KD1bJkgOzJ82fFUmiL7A+qw5eWWd6IzR2x5ET9IshfwTxxV20M1FpcBX/XXZiRfqeFKjgJYdroN/6qXD1gz3vFcQywTuOADNWzsepLbPFf/26KrNwbJLzX+Y+SHalAWpOqvD4yOeK7ZTNcTFMenWURrsn2FCn6TgWPsoOCWqF0S0bAVnffbGmLZMvU/U9eRR5xZ3TSmEsWxsugTuHJdG645+yPN9KQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW4PR20MB5274.namprd20.prod.outlook.com (2603:10b6:303:20b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.24; Mon, 29 Jul
 2024 00:24:41 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 00:24:41 +0000
Date: Mon, 29 Jul 2024 08:24:15 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: Add sdhci0 configuration for
 Huanshan Pi
Message-ID:
 <IA1PR20MB4953E36FD6384F3A4E7AAD0BBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538AC83C5DB314D10F7186BBA92@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822C12B909AA82D6602FC12FEAB2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB2822C12B909AA82D6602FC12FEAB2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
X-TMN: [4d78yEad1YZ8ZpIDAGqHonM6hfzaTDFAGc9pUguO+HE=]
X-ClientProxiedBy: TYWPR01CA0022.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::9) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <beknb34g6of455g72wehqebaomtlaefpyi5pabuffrxtn2zkuv@b5je6pxqtbza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW4PR20MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 979df449-51ff-4c63-3fa4-08dcaf64d63a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	JOBd4c3bnOylw4OkutfGNSMX76fngTM6p5FUOD/wpxaffp3vCbppeLPhZNVaYkiDu+By8cicgQbmHMCJHV2YRdjl2J4Bt+chIX3qb36cuowdlj+0jlonsSkGn/CgkbuOXszQV456lqAJ48cKzEiUxXrL+Sf5qMSIbMJOHNPdUcDBxHcb2BIzVV+eK2hmhPEZgkX4tF2B8DwSe9uz7zkdGrVOCMJb/DS9Wo91Rvm8mJn6HHOAveFSNdpJc9PL+phLrdrRva4799O+2g00mkbYu/RLgHvufBqyah82t0sm+OmtjP0qykufhyV0HTnyCIwPqcqFOGfdocd/wB3rMkJ5N9dWAnKJdbk4EfgElXxj5aRWPsfQ7OATMaU6F0k30atugPNadOzKHAwNbkWGG7WnKS3+T0unl8AiCO/wYHL3OJbzM1v0wZIUN8XdbPSv2naeAzKd/fiS+YFbMlwb2cOnsBXDxsSLYSQzA69jxSuds/e3xT6FKoknqlo3sab+ykkHHis/7YsVq3xc4s0O7w8+E6aJmuk1PGWXk1l99TlD8d725pWAby+QRAr0XgvnfEjDUmpCA9AoV5WDa2/7kIhfxe6ET/t6T3X7Xk7Ow0GZIf9qa95dzSxmUqny+PQeK0+/MJ8HPznLoR99gsn56zpNJiON+Hm7QK+IZ9JPSBJe0osYRBw3skfhepfNLNe0Ov14EUUdVIj29hPapTVzkndTZg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YJFErhI6mhp1ydkUV68mCh6bGXBzuhKfHv8n/DpSdAP793LJFRjrl2DL7akS?=
 =?us-ascii?Q?1A+cfQToeTX+udVY2/Of+167Vg/mVJ0FMqx1DBjfHcGdM3wfN4zUQs8b/SZH?=
 =?us-ascii?Q?0Bz3No6HWya1E9C2Az9pqeTcwvecE/gFwqjyhfmzb7lYTcVb4ePAPR9E3Nkh?=
 =?us-ascii?Q?E9H+3EafuhpAv8JjBtJD5axC9+F3YnPOoD9CPQcVpoWkd8oZObaYpoVNQHR9?=
 =?us-ascii?Q?tY1XJsqjrpsAK0GHRhTicqo0GK/hMBjlHPRgQ0WEMzbcEMscrEvoOIucBRHe?=
 =?us-ascii?Q?dJ1sZbESlOx9ErNxDsDz3FzLbuute6LF8meHycpMZUPszbXFiz8uJte8cEjb?=
 =?us-ascii?Q?O3xOxheXtgP0do597nKyoLtuehYyXKgkrzzHp6lCVBqxblN81vWEO3G2FJ6x?=
 =?us-ascii?Q?1/x+Y9pcG10nyYg/wNiPKb44NRYdRZ9MVyGi/5aTHmKt/U8pmQiXYX7Rq38g?=
 =?us-ascii?Q?i3NqwWeh9jBGzYiqmlhQVKMnMGAFYShp4Bev4Icr0+grcB8p3iBOHPFXTYyn?=
 =?us-ascii?Q?Ie3cgtyKuopsUS8KR7e5r3q7A4DpKRcsWWwPedZs2HXk+5KZltiI1fblT6pZ?=
 =?us-ascii?Q?VwdmR3/KtrraNbCvRVLXpbfq9tVtJWrg7jIEkwZj5scvpUx7dt8VGWVgx38l?=
 =?us-ascii?Q?ZXP/sbtEAtrVoJPbVzvAEztlKAN/ql16AEj6tsz9ooDRc6PesUW3ibaykkX8?=
 =?us-ascii?Q?I5z1tzoxVNc8J44kQjZs+VbrNK1m8Xe78dGYZLTC83We0+ARn+BwPh9q9NO1?=
 =?us-ascii?Q?rQRm+/AzuOBBJXQ2DtcWyJwBaJ3yuieaZ7ErwnHBnSOEDa8jJJ2B4lRnrtNq?=
 =?us-ascii?Q?TCD/mZh+EPvsNVxx0YCHkbthaExN03ibn91uPZPHOvancSvJz45VrNVZ+Eem?=
 =?us-ascii?Q?DFHsROanmquxMGm54Cd5UtD6lyXf8T370bSV9VWBEElBbxh2Z6Kv7QD+Pqgv?=
 =?us-ascii?Q?RzGVhhJlpaqMjJQsWmDUEKcFw2IMS5u9UQ6MOU7ex6tc1NDk+rBsWUabSiMN?=
 =?us-ascii?Q?+3pSPmWmy/xvrJi0RILP1zq/J8cGw371iEEbokUPh1OIV/E8fiVH+IUTdQ28?=
 =?us-ascii?Q?aDYDgSPGU2uNaKr9ryp68PWkPvBJyBliDUDrPgYY0W6A9dVpVgqbkyOSMsma?=
 =?us-ascii?Q?w+2qZhTGWbEXmsUxo/sTFd88IhVQZ3JaGNH8sHPMZekQHDM3FHeQ1VyT5OFx?=
 =?us-ascii?Q?mxRppz9mfZ0zB9uDMAn7oS3r1fFVwbhUgBhn8aAckqxjSlFD9n3RXAk/tqAo?=
 =?us-ascii?Q?+AqddM44cBee3lv3pMXu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979df449-51ff-4c63-3fa4-08dcaf64d63a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 00:24:40.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5274

On Thu, Jul 25, 2024 at 02:41:28PM GMT, Chen Wang wrote:
> 
> On 2024/7/23 10:18, Inochi Amaoto wrote:
> > Add configuration for sdhci0 for Huanshan Pi to support sd card.
> 
> Huanshan -> Huashan
> 
> Others LGTM.
> 
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> 
> Thanks,
> 
> Chen
> 

Thanks, I will sed it when applying the patch.

> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> >   arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> > index aa361f3a86bb..7b5f57853690 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> > +++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> > @@ -43,6 +43,15 @@ &osc {
> >   	clock-frequency = <25000000>;
> >   };
> > 
> > +&sdhci0 {
> > +	status = "okay";
> > +	bus-width = <4>;
> > +	no-1-8-v;
> > +	no-mmc;
> > +	no-sdio;
> > +	disable-wp;
> > +};
> > +
> >   &uart0 {
> >   	status = "okay";
> >   };
> > --
> > 2.45.2
> > 

