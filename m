Return-Path: <linux-kernel+bounces-415003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9589D306B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6FD3B23EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E961D2707;
	Tue, 19 Nov 2024 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gQx1nGmx"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81261D279B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054943; cv=fail; b=m2DAFc2AN8kHSAh0Mjqu0lMnaAsds9/DxljpZAhPBjYih693Yh00Ld+bGarOhXJLbDtiJ6f3kEmteOsuhSd/ZLroYDsl73o0akahT8RXNbxbvsLd/tLW07SSIYTPCP6AHlbGx4GOtLo44oW2naXPbG8fMIgRN3Qd4uVWBfSiVF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054943; c=relaxed/simple;
	bh=KU5apm/b/lKhKTMZ2nS+62gG2/h1l+v64TvjB+X5Y8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SUr03mXHJZ7n4l9bkpQRl0qqMgRMJASAiRLtbkSNXDkC1rU/2ZoEoY7vldNXyJ9RPDsinBvLO7UqCeGvYVUvWFlH7iEVaPy7a7i1eOohAdmD0xQJ0mZhkF3i44raUW+HSYshdbDhKWXZyXWsl8p4Sjds1TRuSuPp/4oLnJGXRsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gQx1nGmx; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqHSbCPEN+ZjT/GQ4YZMQFnhCYfaGR7YXlDYRcWa7GZUa/2MgyyglR1sAtUBuXiFmPzuX3Db9hD3u84+FEdDNlByod5FSyHHHd1W/z/9eQARUuln6Ixz3iP5XLJn3pPyML1ebCx38TnT7QU0sE4VmXoyNzs8+XfmHGI9/+tqemEybOb6Ied9w7bDPGTDrAiUQefIwYdrq5O72wEf4laaAexHffI8QrcFikxgZceqJSHugFBm3WTQoZQpRxS9paFwqKK21BMNXmPzeSdwycHjoHNrPp/o0sbm6xx3E71/Ymmzc1SUE/0gUIZ7sTXxT67iTAEptQfVlgBMdoUvb43MMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jE9rztFxO3MeevDN1ojsQQZQceb9K085o6C66X7YfuA=;
 b=mS+vgiEdydupj4Uk+6ZLAAJS9/YbP33NaFjnGRJW6ppS7D65PdHjma9Ne3gliqcEMc2OjvH5EehuSh4HW73pEowaa1LquWeQs3liAcgwaGZH9d/He2Iws03xPSBc5LLUHERZc2AgjbKJCyh8oj7KRbHmhoohda/bQPmhIGsIINlIbP38to4nxpfWVeTTihnYhBsNyBXYjQOnowt3YRARyyk9yJCvwbsXQy2S0ADpWbkOECJImuf/MQU/xtov8ISBsa6JBG3OXE1DChFUXqqUxLCeDerq9DDHo4TTTbTrkpB38XYh174UOboGgYHzdsR3xSbgwIB5HcsxIQPGoVJFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE9rztFxO3MeevDN1ojsQQZQceb9K085o6C66X7YfuA=;
 b=gQx1nGmx4mAzRibxlkrH21d/Ymee8KT1FHgQaf1sWCag8H8NQdMYszq7pwvGcvOlPyaUmQtCvZgXEl7fjh3cmJE4QbERS5iuZrCp1bvI3uDi2XA2Cp5LbAsqHbrUuhpKfG6nLO0RIOtWGEGTRUe1H8WP7b0uX5VONXeP+CS6lmmCAIIt4ZybmDisTsJ7ZOkCvnkk/elOoVEjJ7o0D42cuncrZVej2i/GUCQLhBEUOH0v/p5Hy+6psLnwz2+mOCcmclrO4+j1w1vJN4MWwZ+c6OVCbzyaYCHlLrSG6KtWz1W/jkmwfGDJ2CXo7kz7TLh2RpdRi+P1suYvOoMq6Zpajg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11030.eurprd04.prod.outlook.com (2603:10a6:10:593::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 22:22:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 22:22:15 +0000
Date: Tue, 19 Nov 2024 17:22:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: regmap I3C support
Message-ID: <Zz0PkWwR28NSlz7L@lizhi-Precision-Tower-5810>
References: <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
 <88f34137-b215-4bee-b117-3ff00402ba6c@roeck-us.net>
 <ZzXfmonkRB-KaBhi@finisterre.sirena.org.uk>
 <85584c2e-2c45-4ec4-89a0-111fa5ad1080@roeck-us.net>
 <ZzYyu4ptPtYT6vJC@finisterre.sirena.org.uk>
 <f904ed54-da90-4746-8230-0ae5dd0ca276@roeck-us.net>
 <49526254-546e-41e8-afb1-14aadeaa391b@sirena.org.uk>
 <dd02b307-f8e9-4b5d-9a4d-d429c0dff051@roeck-us.net>
 <ZzznQknCF7VVHyDK@lizhi-Precision-Tower-5810>
 <0779827f-c51c-4407-8544-c87ca6d76500@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0779827f-c51c-4407-8544-c87ca6d76500@roeck-us.net>
X-ClientProxiedBy: SJ0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11030:EE_
X-MS-Office365-Filtering-Correlation-Id: 907385c0-88b0-430e-a996-08dd08e89f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6CatIzJOp4sss2y7j3EBS/G6+kzJ87s8DCIdBqX+sWMQOQoQMEkuR/ob9LSP?=
 =?us-ascii?Q?tkamT8ea0jEAHZsOcNh98Jst8cPoFfTpbSG2i0o9D2BTSoFkXKr/CXpqkcmg?=
 =?us-ascii?Q?+pLJcLbss/986xeQWPl8e/Lj6ioOFmcD4vOO8AYC/6sDwaKNy9HgzJQBczmO?=
 =?us-ascii?Q?ahjhh4Ly2jM+BaKyxSPInpXIQFQ0pqpP0tH4zC5TOhr4OngP2Z9WIrW3htXo?=
 =?us-ascii?Q?gNkjyN6IIzHZMjOEHG/ccfO0W5v8TsF85IeVY3mq8ZBn29yyhwwzX28OH/y9?=
 =?us-ascii?Q?CItvj/FDA3g2eS105qJXG95/VZIB7yaBAYTrMPSax/32YrF44LWUD97YLWOb?=
 =?us-ascii?Q?TBwX7mDEFUsw231Wl7tVwyoGsTRuqrj8qLaD2fz8/IA15I/RooEsH1WKxFT6?=
 =?us-ascii?Q?B+JfQOUPD62AyQRut+vCU7vZVMxq4AS0/ZHsjTTAqIr51Wd+S47sJT5+OlWj?=
 =?us-ascii?Q?nztwSM5I0Z11oIIvLK+De/s/KkmvML2mh6Wcnml+AfYhYXbJcMx7CNcy3Ozj?=
 =?us-ascii?Q?ogC5fW/rfH2OnFDrDJsJYq+KlV+9gGpvFFSdBN01ssXiDXGk9REN+lwpYv6g?=
 =?us-ascii?Q?UHq3nlROAookW+CkTAN9ASFmcNdNzsHzXPabyjtLeugUYzCkDQlr64jU3nKC?=
 =?us-ascii?Q?yhAkXUT4m2/UGjBZ0cVcPLgzEyayCkAOKd6IGzMLNX/8rasvWlyj/lJRg+mX?=
 =?us-ascii?Q?c8x/rm2aq9jPU6wevFw/b0QOgroSg7p9oBuQaQzjhXxdFJh9M8W4vm7nEjdR?=
 =?us-ascii?Q?MsGJhNTCRBoQUHz1waEwF45HxkH9SEAjnvwCpHVNGqdoO2MaK/FWsxEXWjNR?=
 =?us-ascii?Q?nuJ+iAt/waZaXOxcewnCA/uUd0AFzwwsh7P8XsAvEFoj9gHn3e8CwIq1ZOR6?=
 =?us-ascii?Q?YxpEhCk3MJYxsl5lKZHilf8syBLVcTU9E3gx2ojsbdKXFI0Kde0WIQC78Y7J?=
 =?us-ascii?Q?JgHiy7voErIfH6Dok1t9oE6uaV2VhcMq/aOJ+L5D9tYwl8mwLr7eojeyVMAn?=
 =?us-ascii?Q?4YoCU+Y7XQzCyu7fLspJ/jMrABmqgdag8bITfFWX6qfDGLMtF88MMo1uSUcw?=
 =?us-ascii?Q?bH6DDEZXRz3ttvVDZq3Akq9/AnYwVkrQpMA7ua9K12RECbjiQd71330He/JQ?=
 =?us-ascii?Q?GLT24hp71QT+/xPeEjDbt/6fBvZcPrbgMxWM5icC8KE1J0lmWjFEZXErdgdm?=
 =?us-ascii?Q?c1SK5y8oZCp+JUMN3fVikOPHtsXUAEAdelI4wEjBGzO/ftL0nrzNZPnEml+j?=
 =?us-ascii?Q?eS+ux618I5mpyprwhFhQu6vYrASHWBvNFIijmWhOMgQnzdq34HqMBuz8fmeT?=
 =?us-ascii?Q?3dm15zdNd+fr0t72yCnCof7gQ41IO1WlwT/YP4EP4e6MsVfuOLZCrkDGaXjt?=
 =?us-ascii?Q?YRVElgCtpyen5tmiOYpZLY413h0t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jbwh04Vq6BAcrPZetvYmghZQ+xTB47iXYcBQLhHWHj0TYqOUrzL1heP07eWK?=
 =?us-ascii?Q?+qWTz35mCdP+4jcIaGc5z7QOpCKPlkYLErZw8xuNolOK42acEBnhpKsUaFKV?=
 =?us-ascii?Q?+pcCyAcImXdXmzLndOTY9Vb8NN/e3P+JlTwV/iIY5d//smryDwV86VSeslBM?=
 =?us-ascii?Q?8mkUY2W2Zzjj/At5vPk9W0tekL4pegtJRWjaSNhhHRFwtbUPNCy3Sr1VVI45?=
 =?us-ascii?Q?awepzK/4tFRSv+5mpjPgGE9A29l47vlAwSrOTqAS+oghxoxYaIMdcBhcl+rK?=
 =?us-ascii?Q?AUJjUKqow7fAXInAr7yfhjV+p2o1iR01KuO4yoYehAG/549g2iL7hMxllobq?=
 =?us-ascii?Q?8uqyOgkmkmX/pzT9NQBnQ80kvFAwp6mII+uChKKaQKkBNDnRBTo/5+PT8RRN?=
 =?us-ascii?Q?slMHjjA8ZakTngVTT2afSgAsEqX8ieeYI9CzgutLHUY0gb9S+9HtoqQiI4ct?=
 =?us-ascii?Q?VcEqbiNKOOJCMO287f2heF8iB8/2uFzlwHec9vLW4Al3fEOOvV0sL/kW9kJD?=
 =?us-ascii?Q?ZOnMJT1Te+EsnMFrNyRMziFj4H1+soRllfOvf4v4BoaHuXeBpV8i5bb13dKE?=
 =?us-ascii?Q?x0W37zTMS9ysj5MYQlZmKVc2+8utsjAYEZg9Rc1GV5/We6n5qik6uta+NysC?=
 =?us-ascii?Q?KGWF3roBJGZag5DLAZ1O3Z82nOb9adjo48+7Dnp7xS+zuHX+Cc52TmUiKI7r?=
 =?us-ascii?Q?Yowy8UEGcCovw6g4hh6x/Ljcq9tBRD/CduqWeSBviX4hoPMMg12dfd0OO3Y4?=
 =?us-ascii?Q?e5wtGhmdBxhPAox9Xj7XWb8XOLKTFCJbW3Xmn+qQQ85G3LJgcGjnfUqB9EGc?=
 =?us-ascii?Q?muLb9cOfTX+6b/SyFv4XopPDoojtOleuePJF0oGx5h3PHkVvbFZVxG8kezgH?=
 =?us-ascii?Q?P1Pnp4OTDEzbThvztRhkkU0ox6oRUGY5PQd/UTzlIGm1EHsIXdQVQOeJeZVU?=
 =?us-ascii?Q?ecBtKA9VZQRK1jZxv6kVsg9dtb1fq2d1wIIdPYp+eDK0HGFVAMHkZvlxpddW?=
 =?us-ascii?Q?FU3oE6UVu423KViTkpwVwBs1epjaapItRg7Sfnz/g7XTEd0RDgv5sTbI4EeD?=
 =?us-ascii?Q?XnDOI8bGe/Y5OGeAl6vWx1iglTnfDI2L35V9eHxKPM2rnrIyKvpOhj4s8l5S?=
 =?us-ascii?Q?2bUvYagsK36aCGXx7drOV57Np7XjxbTVQEtU/otFHDu/HiqKA9wBDtAnpEEn?=
 =?us-ascii?Q?vj6CYBh53RTHXedxT6NS3adzFhIPlzCv8W7w6enmuM/ZmoKl1tli1TFZba16?=
 =?us-ascii?Q?fSKNn2LMD5cudAzgcEb6ZEAioKAX24znfIveo33iZMdKx1KK9I/IWDC3Pjbi?=
 =?us-ascii?Q?ArgAthGjygJHq/SFS0xCTF4aZTUEAcBNaG9cvWjNuQf2xaCT6w9suEC1x/ay?=
 =?us-ascii?Q?/OShbUlnAC98x1PtipQgUTT99knt79A0JRHYDFtZEOjhSYEV7bEX0/tMcBFV?=
 =?us-ascii?Q?Bqky4dlcnFHBpspjTpfFYLv4bSVtkgL4g/kUOye/8ASH6QrDccMfSKNW8bNF?=
 =?us-ascii?Q?Vu6Lht55t0APJeoNR5GzRMQY1hiS5Rjv3MFigBFlZaUGk/KUUyFK+0D6lfl6?=
 =?us-ascii?Q?LWAqdwZ2fMOB+ri+4i0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907385c0-88b0-430e-a996-08dd08e89f25
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 22:22:15.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNwq9zyrBt2MA5R2CAYAuRHx408LOIoAVjimWAlGPJcTL1mH5WuQtDFwV6KFZ4xuBceuUzj+zLG7oCfh9wvISQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11030

On Tue, Nov 19, 2024 at 01:57:38PM -0800, Guenter Roeck wrote:
> On 11/19/24 11:30, Frank Li wrote:
> > On Tue, Nov 19, 2024 at 10:41:05AM -0800, Guenter Roeck wrote:
> > > On 11/19/24 09:46, Mark Brown wrote:
> > > > On Fri, Nov 15, 2024 at 08:35:04PM -0800, Guenter Roeck wrote:
> > > > > On 11/14/24 09:26, Mark Brown wrote:
> > > >
> > > > > > Right, so the fact that I3C depends on I2C deals with a lot of the
> > > > > > problems that plague the I2C/SPI combination.  Ugh.  I guess the helper
> > > > > > should be OK and there's not much doing for I2C/SPI.
> > > >
> > > > > It looks like we can use
> > > >
> > > > >          if (IS_ENABLED(CONFIG_REGMAP_I3C)) {
> > > > >                  regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
> > > > >                  if (IS_ERR(regmap))
> > > > >                          return dev_err_probe(dev, PTR_ERR(regmap),
> > > > >                                               "Failed to register i3c regmap\n");
> > > > > 		...
> > > > > 	}
> > > >
> > > > > even if a stub function is not available as long as there is an external
> > > > > declaration.
> > > >
> > > > > I don't really like it, but it turns out that this kind of code is already used
> > > > > elsewhere in the kernel. It looks like dead code elimination can now assumed
> > > > > to be available when building kernel code. We live and learn.
> > > >
> > > > Ah, that solves that problem then I guess?
> > >
> > >
> > > Yes. It actually goes a step further - the IS_ENABLED(CONFIG_REGMAP_I3C)) in the
> > > probe function isn't needed either because the entire i3c probe function is
> > > optimized away if CONFIG_I3C=n.
> > >
> > > I'll send a patch dropping the #ifdef in the tmp108 driver after the commit
> > > window closes.
> >
> > Already tried this at v3
> > https://lore.kernel.org/imx/7bdd2db8-41c8-43d8-ae73-84a221d2d004@roeck-us.net/
> >
>
> Yes, I know. Sorry for that. We live and learn. I didn't think this works,
> but it does.
>
> > but I am not sure if it is good on rely on the compiler. Maybe some option
> > like some debug option or -O0 cause problem.
> >
>
> Yes, I thought so too, but it turns out that the kernel doesn't build anymore
> with -O0 anyway, and other code already _does_ depend on dead code elimination.

Good to know this, which keep life simple.

Frank

>
> Guenter
>

