Return-Path: <linux-kernel+bounces-344515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5589C98AAA6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCE51F2316F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBA7193070;
	Mon, 30 Sep 2024 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NVNAIR8B"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634417DFFD
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716100; cv=fail; b=CWDVUMyW44hJzE5KCPd6fXOUJRcEWNVWq0AbLR6CBkyECbYQ1ROE7rzVHJfWKotSJNdpDPidTJgoeH68O7gOIVSqyvBQ73QVBnGfTHpKuN78z2JB+KY9+Z16l/VOutbrLL4FWje8JX6fq3xMeJfTgqS4vTrbNaEsRVreOC6gn5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716100; c=relaxed/simple;
	bh=zTjszg6v+WhamFLkpZYSoyje7Q8q6IUQzbH8eMMCc2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=drdbs0xnGR8r/ncshe+zTzxCabsRL6LJvelPUm3P8jS2J0KzH3PcH08eqdLa4ykde8hb2S6dyokTGdzYBs2vWtHWD1C0E2O9b/eJ5P14YzeUWZPzEr7pa+HcutdpgmREmEbHQPZ4DDSqHqccVkv1WCMV3kJ1momg55UHsZoU9Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NVNAIR8B reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPHvj3gjfDxxR/bzI+V9wBe7V7FhIJZCenlzBGQQRBcwQrS5pMi4zka1Fod7hgiBWhzJ1fyXCvdrXHjiwpAGbcrl3E3mTVmOjw8HriInMiL0aHBIfjaa2UDXpW0vR3rOlGEfAsSk1xnLn8KR8a1oDXzxYyFyBg5SKhAzpBUmyHTHZ5+89i2IcX2lJVqpAeSKsIKlF6uIprB+wVFfkeZW37rvwSFYCmNrq+HO2ARgKs4XVNe0QzqAkddhUMNB2YK/qCj8YB54yM6B1ZtFV97/8r8Gcu7hmBhOb6ISJZRAaHbZ2Z27+vb85gMJ2RC4Wq16O9fjTTXaqmw4PefW5vO2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfsCV9hUentf3q5Pb3WOdHHttglDv15g0aHhXg0PiKM=;
 b=vUgEiDTlE3mu93ZoDLcST9jWtddo04N6iEIaDIkOKi6CYh/MeoJljO/t8dCltwJh6D958lbtDAJw/hmNfS39X3HwmcWoKyP0H9auBc8Lv5RslXBgkpwQsn5xD8fMOYbiiBnDtacD1+dSQWz+o0lugBLGbOfo+goGkeUeYU8ba1zSUhSDzsbgZcvBhPR+DKmtECDApFzH8kxQZoy0zy2pyYtzlXfi/mJ1WMmkTTyhVlnCxLXMfgXTwHqU8ER8NBr5hfzhir2MSBq25x2PNI29at3lMeKkLWSuAoqBf3PZsMAulyQ5LlxGSkLTMqSEObdW9wd5AJ0W1iC4VIFV51MSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfsCV9hUentf3q5Pb3WOdHHttglDv15g0aHhXg0PiKM=;
 b=NVNAIR8BDnt8Izv+10dmy9mLXpuj3lHQFlc6dPjN7J9D7cKXVBTS1DgsGWmDoacOTN+rFauwodgDLerSRZiyBgjpKxR1xcAQlg1AwumNAsGQidNNmdolxew8udLr/72P8vQ4CSFVwH82QKhxXQYSLfdqFkWAK7unu/XX/2nOJjTxUrK2cZYpxKZ2PIe+F12YolKbajN7nUy5DrVfBQvujGVbrLjm8wdPNqqrCWxD+hP38rUlX7LIvGZOtueJ+5izX3SWswYZT7v216hDfgqjLkqdAJ+2f/H7HnrcRY8QEbpskA0zOdaE0yY4o3zYhT/BuNNZHzrMnDWQYhc+5OUA9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7977.eurprd04.prod.outlook.com (2603:10a6:10:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 17:08:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 17:08:14 +0000
Date: Mon, 30 Sep 2024 13:08:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: alexandre.belloni@bootlin.com, arnd@arndb.de, bbrezillon@kernel.org,
	boris.brezillon@collabora.com, conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	pthombar@cadence.com
Subject: Re: [PATCH v2 1/1] MAINTAINERS: I3C: Add Frank Li as nxp I3C
 controller driver maintainer
Message-ID: <Zvra9mFa9vD30PGO@lizhi-Precision-Tower-5810>
References: <20240815141609.4089406-1-Frank.Li@nxp.com>
 <Zt9VDJ546znNR7AT@lizhi-Precision-Tower-5810>
 <20240930182235.52c4530e@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930182235.52c4530e@xps-13>
X-ClientProxiedBy: BYAPR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:a03:100::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a97362f-9b30-4f31-b19f-08dce172788e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?ZsyH1GkRA8GttLtm8fZalfs2Sq2/ld6FEXQuqBqPTTOJgq8GR8YZEHPaCA?=
 =?iso-8859-1?Q?C8hLDxtWc30ZIV/0/6zPvZ2CNRL13b76guJO0O0i6BdAUUNVQKP8gBe5nk?=
 =?iso-8859-1?Q?Pc+X9dTpvpPfLyCiJMdIZ+4qIDO2i+BXT7PcLzVbW84j/fkngMhfg4UQJC?=
 =?iso-8859-1?Q?ezIsaMBgxkULjRJO8lUgGiqm7zPSPr6p2VG81CQqOFE7875aBQjrgQkr+V?=
 =?iso-8859-1?Q?dx0qyRYrInbQ0XZj3ckDBub+JMQmBsDdPJEcwfb9uJ7wiSsje8fhXjiVKs?=
 =?iso-8859-1?Q?3jyR0u3aJt7aI2SSQkXnsL2HLKyTLOsr0+rqIGiAX6VsAcbPHi1cUREbpz?=
 =?iso-8859-1?Q?LmW/hTexPRhIe4cqNlCdnvEzzSyIygKWrRs9OBP2hhqfdDeSwtBpP/sq0e?=
 =?iso-8859-1?Q?wmKv8uXQ/8VJTQBzjx04LF+Yr0x2+bspcuQr72OLxnCQaTLVBQzSdJztVz?=
 =?iso-8859-1?Q?E0uTkPXkVtTdUlDel/1IDfvd4jbkojXs9bp1X9qtIQRsoBP3KVZqiX2TTq?=
 =?iso-8859-1?Q?0Vggr9ghHkGd05mWHFHSUPPao22t36iNHwgSWW7rG++aw0boQGVzlPFNpY?=
 =?iso-8859-1?Q?+q9rKksDtQKuASOwsMbNkruvfAC+uMbEX6SMvdudpaqs4uOPo0PUvmNGJy?=
 =?iso-8859-1?Q?WBLXXgHGJJORSTV1KsPJvGmp+6DmE3m3Hs/KTRjyZvcsOB9klODx0eH/0/?=
 =?iso-8859-1?Q?1TK63v6boJ2BG/JDaz1umYc/KOBaRoX5iDzqehq+s1FMvHsRSimBMAoPJ6?=
 =?iso-8859-1?Q?Sb3JTqbbRVvjBfITa2lP6y/pYJi5c0JabpBrRTzLDMbvnVVw25TYoCBZHx?=
 =?iso-8859-1?Q?vOde/JyaIRxuQY9o9om+KYup3/MP8UmrBtTSXKZd/J2Z1btdKhvuoywnvd?=
 =?iso-8859-1?Q?mO9n2IU7Ojf+LB/8Ieh3fnLf9NqstwPkrl6Fjd0iSbkh2yMeq6IzNi/3IF?=
 =?iso-8859-1?Q?9wBg2nBMlftAtay92avCLpkEAd+7Yn45uJmVuFMCR5gCS2nNT6pULcH+LW?=
 =?iso-8859-1?Q?guYBNWDETjQ4hCHBoe3X/ZBaPY/eStzjIK6IqJMaRW3OPE2Pn2TUCqKVWe?=
 =?iso-8859-1?Q?cBxL6eItKhgQo1i1LjUxpZRCoR9MzNpb75zMIQJVF+C9SdhQ7WXqjpKomz?=
 =?iso-8859-1?Q?EPT4bd+Jk3yoMmOVTqi9UQDYSsb9VNK4IAf309s53COJ+5iibnqWs6IPIR?=
 =?iso-8859-1?Q?0tSNtciIerDyus0z7Tl67mg0kWnBq0ePecHSFrUo/4EqJi5shZpKJaFaml?=
 =?iso-8859-1?Q?8h3TtjLFCnE9BNv7Xpvbo79b4l90/sbTElAigOFEtX6mi0CTQogAVJbuZU?=
 =?iso-8859-1?Q?W3Be981v+SSSOl1fOw55CWwgz8MyBuJnqmId5HCzVUdUqwggtEefhdrROv?=
 =?iso-8859-1?Q?Y70GTa8+9F9hNwb2uj4ih1bFwUclcdBqNKIrrdT4p4iKFv4W+J6lGPY0yQ?=
 =?iso-8859-1?Q?EUxlquGURa928fZAQ1zEl3/NlhXNDH1JvzoDTg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?MfwXuViRWMglLOLvaCaH1X1s3Lw0gTm7zii9zdQqzAyU8vJI3UGAhV96IQ?=
 =?iso-8859-1?Q?B8eYYY5ozu9LAZGBASWsvPjdYfN1BLs+77IKdouxXpugpUqopzy7mggtYO?=
 =?iso-8859-1?Q?8HUETwjsSCkHB2gg/BaGwspHLnTXwbb03Hl/3yVFZfhFXpPYMVtJPQZGA9?=
 =?iso-8859-1?Q?hOvslFrpgesdHSbBkTYM9DDPX0gNPFvxtob76PsD+cqXdeMOYEv3wUZEga?=
 =?iso-8859-1?Q?m3/CI3mu3iiugfEs5qB5ZSG/x2UZtcArAALZ8HUezLgDuQNp0nlCIWKHtk?=
 =?iso-8859-1?Q?6TnitkrD4Uy75Q+bk/jHFpts3wCzoJfWKEgUijEO6gT9FuCigpI80INatK?=
 =?iso-8859-1?Q?u9HZAFHd2Ge8G4YdL50dlv1kUgeArPp3NaibKbG7DU1M3nLYp4FS6K4RKY?=
 =?iso-8859-1?Q?S7B5oeLIhYlSjX74c8U5rL253aEbbDuDjVkicnYDmyZebkKqj9hsmw/RIT?=
 =?iso-8859-1?Q?ZH7zNO1uaoBNp2TJ76QxwqvOtEFtx0fGZdFS/ap529qpbE9FRlMem8LoRG?=
 =?iso-8859-1?Q?oAZobJBKpcgfvgPiuqGEi/RYz5GpsI3VifSUMw1XLjeNT9NfCOK9LwA/RG?=
 =?iso-8859-1?Q?yvadrSB8h6+YIseBwwn2ThIFnpuEqqOgcZsqEgu84ag65CdkmvGug057zz?=
 =?iso-8859-1?Q?1D4n7OL1JMqP/18qkTruJ/Tu0kCtSF+mFnVI/x8EMKDmqenuAAlfObPIze?=
 =?iso-8859-1?Q?ae1ZIMrsSyuAnsU7AVKwMEA+Q/f3ssWrgRkNP8QxDGmP7jN1Nl5mwwvHh2?=
 =?iso-8859-1?Q?hXuGU2Twg2pjUd3K7svr9TpPgVaG53lPpWUXloqlXJ7NErDgtWYdBeGBBr?=
 =?iso-8859-1?Q?MmFhsXhM/XRrYXDl9ZMIXdQL70yUudVe60JrmXhMS6BbeJKyyaYtFc9FFg?=
 =?iso-8859-1?Q?iIV68Sj9TVzu4APNGH9f/1CQ5M2VFZwhJy3emUg7oWR4Uwm+bJSMj6SaaS?=
 =?iso-8859-1?Q?HuCozD40qV0pZBsffsCp1DCOu56f//VFfza4dl4CtZG0F3ShTNjaXatnQp?=
 =?iso-8859-1?Q?rsplojCQXcJlFhSxR0RaS57uEGwrkXzmjwX2y9KbVWsUmp0SqWij99Zm2v?=
 =?iso-8859-1?Q?dKnAe4ai7gnPWTuJYRMWYtn3wknWlnzneBWgfa5OaJG6+A5aCzfHIsbP+h?=
 =?iso-8859-1?Q?8ngQkjKe2JJaOVX4WNFGJ2z5qQ9mBU7+f3h9guue7D9aj3zuMFwkGcid5f?=
 =?iso-8859-1?Q?Z7fxvQMNleapU2NbVp34qvp9eEp2Pr+nyaUzj5Y4d3WaYit0up2+qH6daF?=
 =?iso-8859-1?Q?PjOnX9n+1EjING6sy2x9hBioeh7ehudiiHXi0SQpN7jz+TmU03JmydWrKu?=
 =?iso-8859-1?Q?7e7h/8vQg1/egHb08SgjPzxKS+BmQvg8DQ5KXHzeMp+CnuTkObGQ6Im9Fk?=
 =?iso-8859-1?Q?nzPBKidtAJKtP9pTaImstKK6dq58CjrBQgj+VjX0t7Qz0xYgx49H0tT8mk?=
 =?iso-8859-1?Q?bhFUfYZTx+foIvBcKCNF+GcF6YkAynEdoWkPpGx8S7cRhpkHwexoG0/9NA?=
 =?iso-8859-1?Q?X5nEr3bAYvea6SBNxE3ZL4d1bVHeQuYNxVx9cENt6tQKOQRIremLate1O7?=
 =?iso-8859-1?Q?w+SP+vQ5Tlvrl59iHcMJDETcdZj+bkWJsap8MxBQ4X4nzdQNEgSpZAOial?=
 =?iso-8859-1?Q?vhZ6ZQB0LUtmE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a97362f-9b30-4f31-b19f-08dce172788e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 17:08:14.5921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvGMAICMj+8Oj9bvD15NTIE5/IUsl8V5GH+WWDBnUREzf4HCP3BacUwH0e/Dj08HcL/pOoFIzuF6uxOVJSK+Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7977

On Mon, Sep 30, 2024 at 06:22:35PM +0200, Miquel Raynal wrote:
> Hi Frank,
>
> Frank.li@nxp.com wrote on Mon, 9 Sep 2024 16:05:32 -0400:
>
> > On Thu, Aug 15, 2024 at 10:16:09AM -0400, Frank Li wrote:
> > > Add Frank Li as NXP i3c controller driver as maintainer and add mail list
> > > imx@lists.linux.dev for it.
> > >
> > > Add Frank Li as I3C subsystem reviewer.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> >
> > Miquel:
> > 	Any comments?
>
> I guess we'll happily take your feedback on patches targeting the SVC
> driver, you've been working a lot on it. However, in general there has
> been a lot of discussions happening on your substantial patchsets and
> little to no convergence in the end.

I think this can't prevent no any feedback at this thread for more than
1 month.

Basic, this patch did two things, one add mail list imx@lists.linux.dev to
keep us track all imx related patch in one mail list. generally, we don't
check linux-i3c mail list frequently.

The other things is add me to maintainer, If you have concern about it.
You'd better said as
- point to the path to be maintainer, such as do reviewer first for some
times.
- or simple reject this, I can post the patch, which only add
imx@lists.linux.dev.

Keep simple, two questions:
1: are you agree on add imx@lists.linux.dev?
2: are you agree on I as reviewer?

> I understand you want to push your
> patches upstream and I also want to make things move forward, but maybe
> one of the reasons for the stalls is the lack of fluent exchanges
> between us and the difficulty to explain bigger pictures in a clear
> way.

I agree on "the lack of fluent exchanges", No any i3c maintainer involve
my i3c target support discussion, even just said, it is "not good at all".
https://lore.kernel.org/imx/20240507204311.2898714-1-Frank.Li@nxp.com/

I post HCI issue/concern and not any feedback at all.
https://lore.kernel.org/linux-i3c/20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com/T/#m16fa9bb875b0ae9d37c5f6e91f90e375551c6366

Frank

> I believe maintaining a subsystem still requires a bit more
> experience on this regard.
>
> Thanks,
> Miquèl

