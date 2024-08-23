Return-Path: <linux-kernel+bounces-299370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6964C95D3B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1925828299F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28B3189B93;
	Fri, 23 Aug 2024 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mppxf4sF"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6E2D7B8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724431555; cv=fail; b=kEm5wroJje8iK73jktQpgtk39+pdBj1CUGHPr/zRYtwwY6AQU/qLoTEEyHC0ZhtoVBIKiB88yOZhBogW48MVNZyst75W/2dSmFu3whihhxwMP/B61L4WpD3G4zWO7Nx1bwbQekswX0N2TwA06anLcEDDZ8TzyXDY8UVPSJDzEP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724431555; c=relaxed/simple;
	bh=S6LJ7V0naziP3X3Ro7BhC0+Th+JKkclL0o6zJNXy77c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pUHqkjGKZ++tFA+1NdpfyONV1pEMhcLchrLHnQF5AI6CFT8V6wGr0XMPeVorqg4tANWXru1e+DDYNVO7f6ZvxOTtISiZALGz5B0+OB908iu1UvzPbgaWGv2KqCaJKs7X6X+bsuLu9zfKt7z+Mb5j3p42b/T8/Fa+WNQ/49kSyz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mppxf4sF reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khfz00q6moIaqjQlJPBRTrHeDf05duOGmPyYHr24f2sgqULTZmFZdmvInJkA0IJlBH64VhrqOPLeb2H7lRXH6vBDRcAHvD7XxDMtfWHr6Y0zcluUKCImo1sw94E3YSIfYBeI+nIodfkMdklTNQtgZxh9C7eW3aiLSTo0gydLqCIWGbX7Vkmm72onqytKJigOjySsdKSu/uzOPrqhLTxY7vR8FP+7ussLWdzx+tkbyoGLu9h3U+C0DcaBXIeaBNsBTxla54WCowWVQtqLo24j7vNUKm7MyslEw6LpMQm3lFB7RPZWcDBUZHjTrVMR+9Xr2AYkwSFmjLcSMW+L3KCkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4+UtLemHmTLbYZCoxZRaHN66WyCpIZHzIN7cf1TS8o=;
 b=GAkLsn/+E/q8NiXBM+hlx7I1vvLHw6+lriPcnsGhAEeX7B31n9mWqXGgv5yYHAITqfJPdWwq5G3cCDyB3A4dWtHqp+HiSKRgeXdkHvt1t+Y9uNN6BVH6OjpnPaNbknCNLs9+VSaCCJPPVgtXJ9yTx6qkv3cAbrVYxt/lq1OQ3b9E6Orpj3B9+J+eKIJNBz5q6AXjQpYMKxXQcv+tlIVyATMHXHqu5GRsIkzsnA1bP/yKlgQYwr4pchb91ZhzbpixbmI/6WEVMtIP5HWetp1qqxJJ8aPwAZqdyapiR0owKkGpKVzvjbHqTV0/Xwv7eivCwZkafcOaYQmF/mKLoEu3Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4+UtLemHmTLbYZCoxZRaHN66WyCpIZHzIN7cf1TS8o=;
 b=Mppxf4sF9V4h4qkO52mA5w/QmlacJ08pkYhnkcoGdeWJG3jpcRKZGhMfsn/dvDZoQQGCOJcOo4x4SdWBhaPTD+3l2tu6CUSR4QeL0Y+CuXW0vAyv2hY9O3aCPzTa2MD6TjeHgp+G/G05hXJOW12z/Xu4fw/qEsDyosfg3D2W4LI88EI1JOfMzyy846yisXLE4JaU/am7wCASrVJ3nHwPFS1+hGaaqX8Fwt/OdM96eNAFwrhXiqHDHeuwiKe5r076kzcFgnhXWG24W0zA5ZSV80DTFlqWty29uqQuoAJjB8xdh6pa0a3Pa6qpq4kqPs97TPFCaHSZyEZFU9ocSxRDnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8147.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 16:45:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 16:45:50 +0000
Date: Fri, 23 Aug 2024 12:45:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Conor Culhane <conor.culhane@silvaco.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 10/11] i3c: master: svc: wait for Manual ACK/NACK Done
 before next step
Message-ID: <Zsi8td/+4CZSjDbN@lizhi-Precision-Tower-5810>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
 <20240819-i3c_fix-v3-10-7d69f7b0a05e@nxp.com>
 <20240823182240.4096619b@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823182240.4096619b@xps-13>
X-ClientProxiedBy: SJ0PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbd66d8-8e6a-4239-f86b-08dcc3930bd5
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?DaW047ySGIIDlB+cBKp7tNOLFCAofkTdZd/HdkMckbBkctT2+GIBkOFFYO?=
 =?iso-8859-1?Q?lLegBhLogQ6Ys9FSq9EwEWqiEDrCqhgm6OgUPvyV35IOsxzzy1MnetxpdK?=
 =?iso-8859-1?Q?14gvdxCT2Q1SN8TJmfCdCQV38TK2GHqysPBuHa6LV1pNUr8nEqAEyzoxkM?=
 =?iso-8859-1?Q?vniLguZva3oOtC0+oZ+jwRf+HLwn0OFdSAu9n2QknIxFXjCxaCHNWUm5v0?=
 =?iso-8859-1?Q?lGRM5ODiRvwVC5eefuxUgCPKSTGvKNCw6Ed+ECTUEKtrRq+e0YguSmi76q?=
 =?iso-8859-1?Q?uaPUkr19+CWHXSfw3c8VUo3zPVKtA6oqz2aQRZykroKBaip54oUPVc1VPx?=
 =?iso-8859-1?Q?Ma1AjoKv9P8WkUb1wKFye50wCqwSBgOqVgjirMVIRjyuQaa/rEljuaPBDB?=
 =?iso-8859-1?Q?FdoPWKlzt0B7NDw87Rxt6VJ5lgXYdku8cWT+R+7CDw8y3ySSBOUaGe7TTH?=
 =?iso-8859-1?Q?UFMVA/ETqAMfk4AezRdAbH5+XxgsWaNElbL0W8oR7ov98ydOxr3HAvuk/Q?=
 =?iso-8859-1?Q?E494B2oV519l4alAMqjitWvrlwG02WHGPzZUj1h7JHUdD5K0D5gPOIyRUi?=
 =?iso-8859-1?Q?a9/RaOdTZA+gjV31uHH27Jw8TEPEg1bjlcHWUJm3SYsGkC3P6i5aeWrPwH?=
 =?iso-8859-1?Q?ePFRBfbUN6aVC1eMFyzMuPNF2xOPaTCLPtRrDeStkkmvwqm2IV96GJ4Ax9?=
 =?iso-8859-1?Q?7jsPZF+l/2ggBJjKotVl+xashGvyfSbM4Ui955AHbiWBxnhkzQP+tfEwGt?=
 =?iso-8859-1?Q?7Q4WflusThrZkATd4NzcW9rUQs4FlqhM7l2QGzNguvUgcPeZ9A7kOo5yXb?=
 =?iso-8859-1?Q?GELxAKP34RvN7gB14IqmSpqk70Ys4G67eHqMiS5DDqxgqJaVEe64WHUbi0?=
 =?iso-8859-1?Q?O3aXtfYdTrSfazZur6hOVeVjGWLSWC44TiR4h+G3qvcpxQpyI8pCtRDZEw?=
 =?iso-8859-1?Q?cY1LD95HyRNpEcTVCxZaHgdvxGMwUxv5UD6ljvNF3FNtg1R2+6+fAQ7/ll?=
 =?iso-8859-1?Q?o0HmTKRlLzv8amHuyxbNk/dVl6JTzE6kxwUscQNSj9os3+eoOr5uOrDNRK?=
 =?iso-8859-1?Q?4DFfssSeYa1KXWd4wuoRvjRK129mZ02lKPM6UfDtUfPMQU4t5snEJGyvD/?=
 =?iso-8859-1?Q?iwEFOjJ3PROIhfpbMKgGKaEEAhOwYQe27a8RXkz33Fac4grNu7VTZlvYoV?=
 =?iso-8859-1?Q?PMVjGpFdeH3AIVUqOEuFsepCeKxcdjMKeBzqraRzTZvfy/AyjFBHKh5iMg?=
 =?iso-8859-1?Q?Y1Gcn3K7NhnfxdJ2Um657qJS9O6lfltAKNW94VecwqBGN0YdKeIkmi2mxA?=
 =?iso-8859-1?Q?0reAIuyOTwqByroyPfE85ZBX55UzSxp2pDTcaigK116GrTOEIr/lL50kOS?=
 =?iso-8859-1?Q?xWkT2dP/isAeMm10ltirLr6bQ2A7/ppDshaE9WtBChIEVbmYRmodSz2Kt9?=
 =?iso-8859-1?Q?paV/nQ7oxXU5655aQL4YJmooLtsCIqxOdsmFfQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?VGlAKSPYQNE3Tp8CatOSHA7Qi7XAZPZMjngxM/Ryc6gD5+4kAOWzS39I8s?=
 =?iso-8859-1?Q?o6fHlHXgrQN3ZC1XrDpJVA4r5nExeQ37RKrmoR8Fv3MEoZo7+ug58wAmck?=
 =?iso-8859-1?Q?Yc1tS/6Rh2Ynxi0i3HPwwPWHx6epe8vxdm6t70BFPAb1bZrKf/pZQJ7ua0?=
 =?iso-8859-1?Q?u0ZVKgDi9kY5iBZqc/bMRO5YcTHIgb7xzoeNj5DRgzLxu8bjuKGIDpvpta?=
 =?iso-8859-1?Q?/1fvmp0opF1oj83I0FmCeGOWWCG2EzPTz30QQy7ziMU0hOzS0wA74Zgnkd?=
 =?iso-8859-1?Q?pdMQMiN9ggvcdoaGDMXkj6+5+uw6ABG4QTfw1Ao21cDc0IjNYBPHcD64VY?=
 =?iso-8859-1?Q?J0E0bW1WdNEcug/3XOVrbqJUeQ4Rv+i4mEZ6ETB+vWOebNoDCUytZ1ttVr?=
 =?iso-8859-1?Q?LYJKk37JVr1kEHkfIquRmBB8HheV68tYuHSd/9WLt+2ihwEkNl9S/ZI3Jj?=
 =?iso-8859-1?Q?nUJ29H+dVyQrfZGMSG3/P0zgxAY6oFcyFo4RG7SZjm9WFiZkPzD8Do44cd?=
 =?iso-8859-1?Q?H/t6miLlkNjrS8D1ZAJCjODF7/lziwT3IqpzqgKmEzOJMqKrTqXjIhcCXJ?=
 =?iso-8859-1?Q?s5fsu2mZGKidKpcv7WzE1fDgoavqtkNoGdBJ+TDI8+tFnqgUOcSUEHoGhl?=
 =?iso-8859-1?Q?MqzdGyMd5cyq7pwsEPQlE0O6G/kT4qhqDys8jmNeraIvPTwfXW1YtP2FU0?=
 =?iso-8859-1?Q?9cZwH3wYYHsoqHasbi7puy54jrCgNhh0lwjYp1VS2gYjP030c99c+krTF6?=
 =?iso-8859-1?Q?6G9lS/3VV60gvAIfEHMQNzCiZEh5yDnj2suZ4bB32H+2xpwgqLUcaNodrh?=
 =?iso-8859-1?Q?JAi1j8JfFIOKuy7U0RQa+6q3q77XPJ7IXnPsUR7In2KTZvGhPKEuMSEJKA?=
 =?iso-8859-1?Q?KhPDPoXFUIYm88CLJZeDh+XI5dVhb+NYPqPA6J7TdQ1qVSDWe+yJT7WDtm?=
 =?iso-8859-1?Q?n2vp8gxzQpbVW65kM2xOQ3ckiV8oK7Xghnj33XKWl3LHjIR/vlO8shd9B6?=
 =?iso-8859-1?Q?WhiubvDukH4yswCQeDvnbJ0k2N4acniSePZhAVvs2QY7ct4sBKQSAwEeJ/?=
 =?iso-8859-1?Q?vE5Vc2FyadkyEggSdNuwHs7hb22C/if1xdwisGwklm5VAqsI+Ara76L3pU?=
 =?iso-8859-1?Q?GR4MGz7FlAanLOsgRr/fH5EgoZ1CsL9soxu+S5W5RpZjlEm4EeqKBjqXoB?=
 =?iso-8859-1?Q?IfJjxk2yX9TFcOUUblPDz1NEouAu94R4MtqiGoHATgFOR1zsjm3kZyRguP?=
 =?iso-8859-1?Q?A6+ylXQPUzA4qyjASxk0sDiULcas1Dt33YcNl3quyfXs01LlmpkaPCEULM?=
 =?iso-8859-1?Q?uFBP8myHwK1PGv8lbXyfAreVXAZJQWNfhdNZ4M7H5kh92JAigTAt4fRWnP?=
 =?iso-8859-1?Q?NabVwNQepfXKym+thzdX2Zb3JBpnAlmMU17+RvfIGRh14IHUYmxFzZropr?=
 =?iso-8859-1?Q?xCwU1oueal4FS8/ePJ/xamkU/JqJQh+WM9HydK3GJ5gR6mmp2ERYyCyx9I?=
 =?iso-8859-1?Q?CG9r4F0hYKI/c9s4xNB4G57GjipF2lyuTY/OcWU6JIIKySvndcXrnoh1Gs?=
 =?iso-8859-1?Q?fQRZ1Pt822o8fjMw1Zgdr0Gs8MJoJxFCo81Z6PvTg62/O6a3LTm3ETajUL?=
 =?iso-8859-1?Q?N7qfVfjDNE2gI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbd66d8-8e6a-4239-f86b-08dcc3930bd5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:45:50.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crg30GceM+9vMlUT79rRM2cZ+6BLmjluLrEcac3mRscAxOYFSN+CD4anSpE561q+cChvOALah1T9t1UEdcM81g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8147

On Fri, Aug 23, 2024 at 06:22:40PM +0200, Miquel Raynal wrote:
> Hi Frank,
>
> Frank.Li@nxp.com wrote on Mon, 19 Aug 2024 12:02:04 -0400:
>
> > Wait for the controller to complete emitting ACK/NACK, otherwise the next
> > command may be omitted by the hardware.
> >
> > Add command done check at svc_i3c_master_nack(ack)_ibi() and change return
>
> 	a "command done" check in
>
> the reutnr type
>
> > type to int to indicate wait done timeout.
>
> 		flag possible timeouts.
>
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/i3c/master/svc-i3c-master.c | 31 +++++++++++++++++++++++++------
> >  1 file changed, 25 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > index fbb6cef405577..2010495906eb3 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -384,10 +384,12 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
> >  	return 0;
> >  }
> >
> > -static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
> > +static int svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
> >  				   bool mandatory_byte)
> >  {
> >  	unsigned int ibi_ack_nack;
> > +	int ret;
> > +	u32 reg;
> >
> >  	ibi_ack_nack = SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK;
> >  	if (mandatory_byte)
> > @@ -396,18 +398,31 @@ static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
> >  		ibi_ack_nack |= SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE;
> >
> >  	writel(ibi_ack_nack, master->regs + SVC_I3C_MCTRL);
> > +
> > +	ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
> > +					SVC_I3C_MSTATUS_MCTRLDONE(reg), 1, 1000);
>
> Still concerned about the _atomic.

It may be call in atomic context. Because hardware design limition, i3c
transact have been in irq disable context to avoid 100us timeout issue.

Frank

>
> > +	return ret;
>
> 	return readl...
>
> > +
> >  }
>
> Otherwise LGTM
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Thanks,
> Miquèl

