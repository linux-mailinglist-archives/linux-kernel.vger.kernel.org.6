Return-Path: <linux-kernel+bounces-571240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E11A6BAD3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7607A5E91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC03122759D;
	Fri, 21 Mar 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="CjCHBNeF"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CFCA5A;
	Fri, 21 Mar 2025 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560752; cv=fail; b=CvJWVGqiyk9syJZ67EM2vpaggorxdUrXtg3VO4uJYJrE7x4mrQOO9jEuckYFNFRMsdSaxWIuFmq4HwrVlm1M7ZlWdHhTZJ6wR14wAQT0pTlnGoe3NZf7A3V61Yz3G6jVPPvzmhxE4aYhIsrzzvNzOSZmkWydfMXeww8T+TtIB1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560752; c=relaxed/simple;
	bh=63LBWkbK6GbFmH3HEcM9jFhI2jKF2Yf86fv6MEBl4Fs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=TLee2DSmZWqqlLukdRPYKE4lO2kEyEBBf56bfNaY3RZAlG3/jarfOZVo3uJSN1eo8lfTTxlpFDI+gXBN627JaiyWuKr26ptDB2n19UEpbCBtbXcVCIuwFsrPcNDCbv3qnFZ039A0fwaZ7ORrxpU3nSGtDZheRAPwZLl2EtJQ++I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=CjCHBNeF; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbxKJHKNtBdb6Wjtc+3xhrhd+pIGMBVGuleKQG+AXJUNrwOj8d7lK9Vq4YO7VnAsBLbNflXLCFQrkOPprNLfpgLYVVfcpX893CRk2+b9NsLdyVsFYAe1aYhw19IyHH1TyIrZfpQrzjkfp5pH9rSaQdD+RmBiqQWId+nRVlrHF/77ExdNMQj4EJEEdYQZHXBamqNQXd98/ayd1PqKcMMMPJSTXRo90jyvcKZqn00pVtKW5r5/FnD55NdOr3nwok6uVbkMvQI3XC8zXD8D3EmZJC167C/djhCOOBBGRgWKl3GSSWl8WEYcN6n34hjWIb9Bn+H+obRTd5ZjveQyWrcA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1/Sw7bbH3Mz/DpdtqiKdwtFtZUTWuTXCYdsqDx8P64=;
 b=bbLNnJCabVMJfa4zVYhcvw21t7sceJj2z3qUMaQ8E8vFpV9b1DwHYoykcnjVqwPBKUpfPALzU7k3oqgX5agyk2uzucJUz30BD5BgLhMLN+mhTI73/8qt/AHge6awbbrWNpVrdiXHO7bmZ4UCXjIbzwA2x+AX4/WoE6KdTQOQD+6dk2Ayvloeh0Sat5el0JYGwz4kjgd2OjlaT50JZmOsViXajizmBR13FB10kMGm1wIUSJeij2L49Zk6j+QqgxG1x9oY/2XJQz/JBehiThf2YL3SF5Ti8q+0Zc0Bk2+iYuIPMnVRT2V3iF0wQvNra7ZFgXzCMl+9Ml5gx5zBeVGPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1/Sw7bbH3Mz/DpdtqiKdwtFtZUTWuTXCYdsqDx8P64=;
 b=CjCHBNeFwNklCjUPUN2OqqLxTaxAKM4oLtqhP2K5M6dqXpJD4/GZgDeq/7PnepOoMItZr8KnonMXnKSweL0SqfiZSEl1QbQfiEtTbBdQRLyERKkpU1qT2UnApakhnKcg0gNE53PqBEuhdrP4hf/2BkYyfc7kPkRt/zBNWdloKUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by DB8PR10MB3611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 12:39:03 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 12:39:03 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Lee Jones <lee@kernel.org>
Cc: Colin Foster <colin.foster@in-advantage.com>,
  linux-kernel@vger.kernel.org,  devicetree@vger.kernel.org,  Felix Blix
 Everberg <felix.blix@prevas.dk>
Subject: Re: [PATCH 1/8] mfd: ocelot: refactor bus-specific regmap
 initialization
In-Reply-To: <20250321114159.GJ1750245@google.com> (Lee Jones's message of
	"Fri, 21 Mar 2025 11:41:59 +0000")
References: <20250319123058.452202-1-ravi@prevas.dk>
	<20250319123058.452202-2-ravi@prevas.dk>
	<Z9skKTf30m9DVaC5@colin-ia-desktop>
	<20250321114159.GJ1750245@google.com>
Date: Fri, 21 Mar 2025 13:39:01 +0100
Message-ID: <87r02qeexm.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|DB8PR10MB3611:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8bd81a-d152-48d7-ab0a-08dd68755cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6wwxj+W5A0YsNHnZuJXPuhrwjOgQeDm7bvjYMxz2V5L4P2+kWhXeWUFnr4eX?=
 =?us-ascii?Q?yilv5XkQR1LemjcIhcx/Vqa5+iCyu0zYcOM5yp7JijvVk603WZOeQO1UlN1u?=
 =?us-ascii?Q?fJ84rnbW7equNPk6Wccp2R/EmsFj11e+V6sLIICgL/aXHKDx+0zxv3hbtKaQ?=
 =?us-ascii?Q?LCglN/p8wU5cUV/GN7CTdXkS3tZzlK4mgP2oD8m1yvzB3GInEbH3Yg32d5Lw?=
 =?us-ascii?Q?7I8xLkebRhYL8O4P+9sQ7VOvCGXdaOSAWumNwdxmk9b+0WSimezxMtOsiF0F?=
 =?us-ascii?Q?Xauavqyt2mcYx5D050v9NqettSnMP8vBl2JZoSLgZSFHSN0md5RvNLliAKyi?=
 =?us-ascii?Q?xAgjH7MI34tQqbhXj715nm9SspiRY3UgXh4B1pp1TbeLeqyARw0vRbLSxNV0?=
 =?us-ascii?Q?sCT/BDRSL+7L2ypm7rgUdNvz0SQpxERPcecWYwnWo3O9wtP/q2B6YaTVL10o?=
 =?us-ascii?Q?SXaC4jIC0pRk/hK1ihMaSbkB1/PP9nrXX9eWToHmoZdqOTwVhVkMOhNEK3UC?=
 =?us-ascii?Q?qhhBPvnENoAH7EZlvroyx13dYrnrBWpMCikclMuvnmymfwMc8MD4eFk7DS1Z?=
 =?us-ascii?Q?S/Plkn0NdALzz+sqq6xw0fm0MiUdr0gaGEItguhb+PRHUKlhbeNXoKov88st?=
 =?us-ascii?Q?g90SJL3uI3cHZN/xK910RN7EazOIct1Psy7Kg3xsMh0RFgrXT8v6E/+fSmXF?=
 =?us-ascii?Q?TUGy+D62o0IDozbzf8q1rv/Qzj7mq5uYWMJFNsCZqirPTGTcpA4uguaq/+93?=
 =?us-ascii?Q?5WrUhOwbD0GLO/x1R2BbQHCKYnR95imrkakKzYgV5STR/zx1zxgFaVJPFP+2?=
 =?us-ascii?Q?RW/QC6MoT5M1CjS3qKTi3wiJIH31RCuTQLvroPVcZX7jQ4fKoHWjrM69UWLE?=
 =?us-ascii?Q?zjtZuuRMdf98vj3p5lSlH2nFQMqSa7MOnselC8Rif8/qPpoiPwJVKHdJQ5qD?=
 =?us-ascii?Q?K1dtYS4/vF/E8NpvWZpCS+59lRsenw5qd7Bg1n1RUV8XgJ4zsFeQbd1GJD2H?=
 =?us-ascii?Q?YLPoUcHm7snCmzu6Ou/giDHcICBWJwk+E1XiRGLzlXwyX4u5Cmuw5ie4EplT?=
 =?us-ascii?Q?zlPD75MYE0cj7T/cTbR1cWg+JlY4IeAAiwJNDoTfvhO3UYdJ3ndap4AEokJI?=
 =?us-ascii?Q?AM07XbVugzKJo0ca6u+l257kPDbVw3xyznHUBKicPmGk4lXv4CzXvxtWVTCy?=
 =?us-ascii?Q?NwmzwsZUxrsPs6ZsTwaU7LmB2SMqLPixo0igLXApNkBDV/Ow7GLZssgGUWc5?=
 =?us-ascii?Q?w9xwHXOd1ECR35EGVyll3lC9NVceBURDEMGcm+egcK8/q2L8J2UrFEeHcE3p?=
 =?us-ascii?Q?N2mj0MJVYB5GVQXupL7MGpYM8xY9AFI+qq7IPAQxuGR444E/qGsKS5WWwHeu?=
 =?us-ascii?Q?Yt/1Wp7RbtJk8qMxd7i7IJFBOmPGIIOJb8t3xZoqpkVfeVgQtnG4cvUftm9r?=
 =?us-ascii?Q?Zpf6ey+pfgAdi5EKZGIZ7nOpkHTLQb63?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ggqs826SpMM07sB+hUkECsC/4y7IfGahVHQ0gC0JjVzJkgsEQZT0/v3ihrz/?=
 =?us-ascii?Q?g12aE3FbVpLkuurq1i01RmLKuOVV52F6uQaZ+Bkza9Z3lWf55gNUn3kijveY?=
 =?us-ascii?Q?PKtKK/hx5yCBFT4Xu6eD8P8EcSH97YhsVHyAWEGCAyFHOhXPR5aTWVKzFhl4?=
 =?us-ascii?Q?Fih8wCk5r5uq8erbccmzXLK/InDBLSOBkogI1CgkJP+4b6sonBMIlUocMIRB?=
 =?us-ascii?Q?wrcbx33n/bqXrYUHpYOxOUzW3pw6M8hfwIjjpyv4Qah58m3KAl66SDY/J3gX?=
 =?us-ascii?Q?nUidl3MVmWuHd9LvDAXydWxz2n5ExTCb95V3YyuJTws+aG0ytS9vACwP/73w?=
 =?us-ascii?Q?UNuDFnaZJJQZpx4lFylhAeu9lBSn8mLv7ZZBrGCyOh6ZyLnaErIOUT9eW80M?=
 =?us-ascii?Q?d/HlvMtqY7otM8UQZxj4X4VXbuVjW4sQFPnQPeVim3waAPALI1kIJiIw0WuU?=
 =?us-ascii?Q?wtKtex8e3ILC8q8EhsdSBp2mTA8JgdQR8VZf9avGdjIdTQwffPfZiSA3bYxR?=
 =?us-ascii?Q?Ei+9y0r2Fq1iYSMDn4gEBNs/+tHGmi5NxzoMxo49P1T0e4t/x6njca5TJGU4?=
 =?us-ascii?Q?Wl9YzKFp44iqI4rQ6+9i8ggzLJhlAo2GK3bN5oKMAPdmC2lU9QfHpC9uPmMV?=
 =?us-ascii?Q?Cx2fcFqfGGi8GrOOMZ1AQYFQboZNhqyayQnJ0JPVtvsIVTQ2mYQseDUtm/vw?=
 =?us-ascii?Q?3foVqV/JFUu8+Ac9ybm8MreilctM/VmzTAVn4kPKTLqp5TxYouA9NkMhd9BL?=
 =?us-ascii?Q?ssMXhmk02Pp8Mb+9brYRH0/BQ+zcnhr/9U2FHyzR10D/Jm9nBVPZdoDFZl0i?=
 =?us-ascii?Q?mM6IBaWyWJNpPlZJOVbS1nYUm0KAWJRwlLasAN0Hx9mduGSo+wKbcDp6eXcI?=
 =?us-ascii?Q?13n9Z7WMPsrCJSVBOm0XcEWG2b6rkgAcCVAvWeibXl3nGhkli5BYaIio0qp7?=
 =?us-ascii?Q?MRJukSznCQEuB8ROrqx3b305pSCLr4g8tPeBnmWN1qIrEptw/5bo2wUFaxm9?=
 =?us-ascii?Q?gATFmA11oX4kJgqC/L2t3QS73szJIqREvFaTXzofz0WLnvXPi6DnD2YVLUGZ?=
 =?us-ascii?Q?JsSDm2NHrfEdlWO0lBbPqPh0zKaiBuQTOc1j2FHNQXPAZt57y00xBpqcW7XO?=
 =?us-ascii?Q?s96OhZft7IjfpzMiwLJMZpfa+oE109DbFMt+ZU37Wx2yEK1MTLVBdrx0nKfo?=
 =?us-ascii?Q?0MT59NQGkiUZaaqnZh33hmDId7oAyi1WCwXLPY3GFdRhhtELQk252oWAv9Ak?=
 =?us-ascii?Q?9YnPkoP1uRyhlfzJc0BsnjEp0EpQXf+Mjg/FYEqhS+Jr2BGExquhLWxzNF/N?=
 =?us-ascii?Q?Fe3OLeqFzfoTX7xO/KdaRIypUvzsqxB6DUIRDLKpeMO2Q3v4F7fA3Q2aK1wI?=
 =?us-ascii?Q?aHNvc2MdRpqtr9hmyVOpXFz8GE0lnTrgg+tR6GXTQpe2W4T2L7vmF0p+M0up?=
 =?us-ascii?Q?m/maB5Cgym/8oWBJZis5uCBtkRtBPbwaUEWKvuXWfqspOwrasA8Duf+jQQ8o?=
 =?us-ascii?Q?7FewlJlBzsKp9LdtYtv0MzWIzcyYUlDU3rG9vuaqjd6lxB3NzwxFvzJI8+E7?=
 =?us-ascii?Q?Gsb/fKHJ9ksfINIxAD4lSCbk4AeRCfmFBQXcWRwWzvTvow5oYeHVe1MZbpWM?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8bd81a-d152-48d7-ab0a-08dd68755cb9
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 12:39:03.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB5KevGCxhfgwrQ/od6w7AR18lRIznXQlHC/UBVuDfWqBp7+od200K83aCLSt4dg9xwXz8hPkDL0GRcgc+/qlZ6t7Pl4pW2seQWw9En3Fdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3611

On Fri, Mar 21 2025, Lee Jones <lee@kernel.org> wrote:

> On Wed, 19 Mar 2025, Colin Foster wrote:
>
>> On Wed, Mar 19, 2025 at 01:30:51PM +0100, Rasmus Villemoes wrote:
>> > diff --git a/drivers/mfd/ocelot-core.c b/drivers/mfd/ocelot-core.c
>> > index 41aff27088548..78b5fe15efdd2 100644
>> > --- a/drivers/mfd/ocelot-core.c
>> > +++ b/drivers/mfd/ocelot-core.c
>> > @@ -200,10 +200,12 @@ static const struct mfd_cell vsc7512_devs[] = {
>> >  static void ocelot_core_try_add_regmap(struct device *dev,
>> >                                        const struct resource *res)
>> >  {
>> > +       struct ocelot_ddata *ddata = dev_get_drvdata(dev);
>> > +
>> >         if (dev_get_regmap(dev, res->name))
>> >                 return;
>> > 
>> > -       ocelot_spi_init_regmap(dev, res);
>> > +       ddata->init_regmap(dev, res);
>> 
>> I remember changing this from function pointers to the direct function
>> call during initial development, per Lee's suggestion. I like it though,
>> and I'm glad to see multiple users now.
>
> Yeah, we're still not going to be putting call-backs into device data.

OK. Can you explain why that is such a bad design?

> Either pass the differentiating config through to the core driver

So you mean something like defining a new struct ocelot_backend_ops { } with
those function pointers, and pass an instance of that to
ocelot_core_init (and from there down to the static helper functions)?
That should be doable.

> or handle the differentiation inside the *-i2c.c / *-spi.c files.

I really fail to see how that could be done. Currently, the core file
has a hard-coded call of ocelot_spi_init_regmap(). I don't suppose you
mean to teach that function to realize "hey, this struct device is not
really a struct spi_device, let's delegate to ocelot_mdio_init_regmap()
instead". So _somehow_ the core will need to know to call one or the
other init_regmap implementation. I could add some "enum ocelot_type"
and switch on that and then call the appropriate bus-specific function,
but that's morally equivalent to having the function pointers.

Thanks,
Rasmus

