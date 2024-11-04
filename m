Return-Path: <linux-kernel+bounces-395513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF6A9BBEE9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2001C21F18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE601F5854;
	Mon,  4 Nov 2024 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UZ5ycDGk"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2054.outbound.protection.outlook.com [40.107.103.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE11CC159
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752951; cv=fail; b=f6cdeGRH0tvGHigb5zrmFgNgZHP+ntAum2AakDp9mG4y/M4N2j0BNXg8pUJsbCXcwt8dbTA7a4+GdT4qqo0wQfEz5WFAcdmSBCmnw5NW9Lm3cGm1sKBebkGlS1DMbsuX6OvX026aEishtrPkjpofCijRqpClIlF1+9UqTOt1QEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752951; c=relaxed/simple;
	bh=kiLGarPLIvGVAnhynS4JnN2Rtt/OTJZ0h2nrKmgCwpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r94ZNDmGBEH72WioQwXbxXLSSq/8pwevRpgaWM/SoZ9BX2hpFYjETMh9pQhHtLnpoB9HKiwycD0hkibb6hLw7j3SK7exjYr4chaYQMfrffGHsspD271aBX5Ebs6uOH8fN1qOxa34/ia7akNc7RUYWG0u+4Q8Gz0tk82bjYQvSUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UZ5ycDGk; arc=fail smtp.client-ip=40.107.103.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekDkjUu7A51IROlbQQn12zEEG+VyKp3Cn0EKLwW6l63vbQ6uLQN4yXNEnL5mWH/my0LPVaRndnQOGXJWpMRWrQMwYQAf1JWjDk6Er9UQWdgukec5T4mN5phfLklEm+qMXIH7lz3xRkSBlbegf1ohGWaH6wbvueNrzmP5ptrw44aHM/9F0pfGil5sRkzoRI0ks2x6+Pa1+oQYyhJEMTSj8MA3IfjsmlkO1TS2IzsTmuIyDRj2hqEI/TrPv+VEmUPBNhCY6PlU3dhV/GUl8dwZpafwlsOHEPffOBKSczFYQD6isH6rCzkdpbUr2E+LcvxkcPKoevRr5pYdZfXAvDDwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tkj2Gys7O+La/9vq+ytjF/l9QOftyf6e6t9Q3pILko=;
 b=y9H2o6K7qNVkqFKjFrvQ0gzVjJl3k9tmFvuXj8hhZNWzDSviGhgBDav2vpOOVDnjy6EvR38/WeFcuJGIC75WDfC+84n5EbesrNVu55U/sdj44A8GOKLes8JZvSXOZL9BALUxRneLu68rams4+0zvgi6F/RTWW/0pX2TZ8fsFyav453xv6Ah5YXUUEwV61c/e5+YUzSQLp4/7FJki8mYlEi9E786OvHDwNoT3u/Uf2yHFBq5YWzQxXVcYlb624q61y8pAGkujWdbGBOSvkKky/efYme/REE9KNPkOWOSw9nnZAfF2q729CMBm4NmOGzYT85JckjVAMw/ffgppqBCnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tkj2Gys7O+La/9vq+ytjF/l9QOftyf6e6t9Q3pILko=;
 b=UZ5ycDGkgn88dshwqQBY4QvelHwO1K4LRUfgZSYm7iQORVxBawzaJl/5CR5MDaaIktYcAvbQXN3hqr7LP3juIZzOVRdAHS8m6yZDoUfykftvr/DnwBo5JAbid2K3EEzOyIHY4a0bn3pUblI5LeHK1EoOmMuhDHcW8TSAt8zewKjS8iTXkBRJYEfYX1DWnDhLWonJJ64DPCvLjQkB6W7FMN5eeKlG+NvntlNYN7FEgsYAXnqGmUDuJIvd+tNZbr1liYdYVOxRoolnq3oLqsaGs80QA040oixy4zlRC2u83a44RI2u+EEjV5TTwZDaU/5VcSdm7ByH7BB5kXmLtbrhIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6865.eurprd04.prod.outlook.com (2603:10a6:208:181::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 20:42:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 20:42:25 +0000
Date: Mon, 4 Nov 2024 15:42:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: alexandre.belloni@bootlin.com
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: Document I3C_ADDR_SLOT_EXT_STATUS_MASK
Message-ID: <ZykxrQ8DDCrbtF2/@lizhi-Precision-Tower-5810>
References: <20241102132841.2446176-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102132841.2446176-1-alexandre.belloni@bootlin.com>
X-ClientProxiedBy: SA9PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:806:22::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: b416d305-ab34-4666-81d1-08dcfd1130e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XVWsJb+Sgs+uJzMYyEIzgoGH0tYWTKIzATQH3uuPSKMq/W+6fKcee3XA7C+J?=
 =?us-ascii?Q?ItMpiLTfQH+V2kd0WGMhgjBzfjU0zr+Lbz0OfzXL9qHL6r27Wx6U4prKkYaa?=
 =?us-ascii?Q?uQhTzzuy3aMfWn96abPhhT5/G/hqsjY4CZMdbyoXE0HLXC5L4Xfw0H1A3tY6?=
 =?us-ascii?Q?jbzBEqmLAlX9lD7jS5jXqjLGjjxbKi22CGO/v6EgxbJFjoovrNoAj3ho0jQa?=
 =?us-ascii?Q?BK7ySYEuc6BYSwAn9q/Jm70S8f2jyLFqAF8n5vBYLrDQHMtf1M+kX+q0EMo7?=
 =?us-ascii?Q?2az+76jTGOtlGBAUJXGGXjTSFDil8x1E4FUZuAdqpIe28dGvVO59cBEqBgy3?=
 =?us-ascii?Q?RxddB1KyAtHq+H4g+LqF5plGftwJL44AUUpBTNeSPgY/VrrPoshyNVcLyzcl?=
 =?us-ascii?Q?CsDIpLHzkJpLlLe3T9WlBTx6u6ajV0uJmeChU22BObCxtqKSK4MTqUdOChd+?=
 =?us-ascii?Q?3q56QzTzcSdyTPV7EEwiz+BS0k8D+Mol/ChaLHXpvH1lbatHO6R3TnnkikTI?=
 =?us-ascii?Q?+dUywpfjOrfl3BXxFMzDbUBK7VbF8IUlDL5QM2WJA3H2llEWCspaHkvubhtW?=
 =?us-ascii?Q?YtN7k/ZkyKUqbtKkmlRk7PzBf4/nmI/555NBcu8BXXCWhrzC9Ko4BZUwqCuu?=
 =?us-ascii?Q?b2XwiJD3YpzTr1Rk4ijZIJzT1KSmHn3Wg7r7LM15HrPY441oORVdxwdsnfii?=
 =?us-ascii?Q?a4q+8ZTbS57O+O5XehnaoQy46G/iXt2ASrptbIdQqUtD6VkQ6v4TOBryt+tf?=
 =?us-ascii?Q?1aXHu/0rheiVOVAZoz/ol+ZYJSJH1S2/azV/xlGyf06OkzLyXdLpxkCk4y35?=
 =?us-ascii?Q?FkeKh+RR3zdJ5k3Gfu9Ov08kq3PZcymTtBRXKOA4S39bCka5U8nJ7/vqybuo?=
 =?us-ascii?Q?Rxg2Hndr3ae7MniNimeDrdzhSdwMJ59L89A96aNe0aFD3Yfwe/thaPwUHKo/?=
 =?us-ascii?Q?zx3ycb5G9OeEOmFHgj7LJyrSCJmGCA9En/R4sQS9LogQqDUeSMmzm/3gjdbn?=
 =?us-ascii?Q?AzuuCRp2Vt2n/4dktC5qT9rT43OiuSPr/EBoUPauZU/gf4inMRusr0avMnH4?=
 =?us-ascii?Q?M+uH8/dFM4r85CeeBvt5Sd5BiOFBxfuDvVDZ9fWEEZV0oQBsnEUMeKbqtK+P?=
 =?us-ascii?Q?bW0fdmeU3aXC0Tpv1ZpipTY6e0s8isqhZFP1Qb5tWKnn+mKMgrCKHj2NjVsg?=
 =?us-ascii?Q?RRutq/zaQnX9a9wutx0XAyOBTR3055Zg16HCiiZmysJ9qtBXhkSGM/v+7K6/?=
 =?us-ascii?Q?JD68haGl/acJRP8I7F4X12ayrlJr9OuE7/WnFyChc+yhoU795L+OqhEcMP1u?=
 =?us-ascii?Q?GKFJOKWscAzmd/s6O7WO2DwA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L9TgFW1awp0Hdkvo/UXmZ29vC6aGSk45sudTELFDi8iRWRuEefK2QCM8SZIs?=
 =?us-ascii?Q?d3qg63/y/yi0U+VhfzfBXT9gvHbu3mI9aOzbmSV4xmBSM1O7KE1+7g4Y/mvb?=
 =?us-ascii?Q?sypsB8vXqxtZTIkIlrDUa4ae4WtTyQu2AX8Bllkg0mGjfMKPOPGy3B1dcW+s?=
 =?us-ascii?Q?NpA4xxylY0Fn700Bl3+FKnxdkS1S9zlQG+VzypY9liuADk3K7NORTo7TgUw2?=
 =?us-ascii?Q?rK0ArkrZCBmQ9OFgYFY3MhbjpIywLmBJK5iLwm+rKf6vrovYKHmf0XrlH35M?=
 =?us-ascii?Q?KlJYvDalEZfd6WOaorKj1W5BSsaBdKDm3KQs3c9pW3EQPzeAc7wyHo/99BVr?=
 =?us-ascii?Q?E1ZFRYOM37j8RxWfE7cfCsWbR7en4u5qWJLRztUsbyG88tYdmu059R3h4THw?=
 =?us-ascii?Q?F/2eRL6OFPynL16DRSusvZrN73UAfadnTLv5iZ7jEqtazTihyiNK5KkL8eTQ?=
 =?us-ascii?Q?4lKD+Z0jb3rSjAh58sqsP63mfs7Nb081nkTTptLvW2hZUAus+mOT0TGyVa5J?=
 =?us-ascii?Q?xTJr3PrZJMn8shRhyemP/Dme7YWJHrQO8fUkV+7hTwVPV6RG1Zfvl6Nt+DLB?=
 =?us-ascii?Q?On3TQ2zjwZnhfsBf0BCSD2EWRIJNl2dv7259jeOarqIYte5G1GRB+FL5fIP3?=
 =?us-ascii?Q?axgoa3UIAPG5LZP8Zb1XqKJKtCfoEmsQ1hZu+qzbP0/U814X0/YZF1oPyO6o?=
 =?us-ascii?Q?9P4KyRL67REiXnvRuBcHxaZ4BNSlYxjPqI7LMLibf2zgILFiANUGmGahhkz8?=
 =?us-ascii?Q?GNSAhPV1MV2mDj4FjOMMs5OPv8Wh2HudpJ74IvTFQOF+HKf0qnZ8kLZv+Yi6?=
 =?us-ascii?Q?xab5zS4lsPnTMM/kEjy5TSwQPmpfF7TsCkaGpPs7zzpduSrZi3GigS80N8dc?=
 =?us-ascii?Q?9QBdUAX71aFQXsvEHd9Fn3kVrM2cr2VkTIZm3Ope0B41Ylz2rDEQXydL7p30?=
 =?us-ascii?Q?yEPnCWTWuSH3JbguVJKNVsgHGjRWa4xZih+qfIrtDqYSDWXGXp+A8Z/hYYDF?=
 =?us-ascii?Q?mG5447z0cqrst+IyQiwXzmJ8XNWHm5FLm+6aAo1yLJy59Hhiu7mjk3+fxjzk?=
 =?us-ascii?Q?EVpvyhyPpNLKnkuuklJ5BIpFKNMfOS0tDjS5/kZYjjUp3nak+6XgnplgkI6N?=
 =?us-ascii?Q?SrM76dvvdcxu6uRed2rXuP2TjfiDbe0xl0V2+xTEQPoHzpce1AyjSEbh6h19?=
 =?us-ascii?Q?Eui27ggyxt9VSnG7yC2O7Ermc0ZnjXXrp4jtWFJuE1IVJ59fgLzf6eIF1NnZ?=
 =?us-ascii?Q?Cg2OvrbtSkXbdNLRmECPqTfL6bTndbgD49wOzfvOUVSdKjTlIw0HnuKEvDVF?=
 =?us-ascii?Q?VmPgrOI7QwrRn27SWz5b39LFJPGRc5dWU1i965rbKF1Incfg+TYiRt7S+ZE/?=
 =?us-ascii?Q?+cufQ3hcyQxsM9L/KNQSuSHjOqZcRpCOdCzvhqRHLukZxA0lF1ZICIfTIS/V?=
 =?us-ascii?Q?X3QTssdMyL82P2uvcx/y0R+RDqeDMwl2w1JR2VqhD0ZYiqh+PjVT/AaXylsL?=
 =?us-ascii?Q?U9IcdOXcOG7KKAUK38Xwi2QBiHYGObxczXSDq7SyiwcVCBtXpag+OgEuJ5bH?=
 =?us-ascii?Q?evxAYPRDkw2qvxJk8TQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b416d305-ab34-4666-81d1-08dcfd1130e0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 20:42:25.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCXUDNRC5KAxlSOnRgczM8FllmzYfLcMlkwxn6HxBUuNqeDqOCOcBCAz++MO5y7XQiwDfrvokuYQc5clFJaUJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6865

On Sat, Nov 02, 2024 at 02:28:41PM +0100, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> As the mask is part of the enum, document it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  include/linux/i3c/master.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 6e5328c6c6af..12d532b012c5 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -298,6 +298,7 @@ enum i3c_open_drain_speed {
>   * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
>   * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
>   * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
> + * @I3C_ADDR_SLOT_EXT_STATUS_MASK: address slot mask with extended information
>   * @I3C_ADDR_SLOT_EXT_DESIRED: the bitmask represents addresses that are preferred by some devices,
>   *			       such as the "assigned-address" property in a device tree source.
>   * On an I3C bus, addresses are assigned dynamically, and we need to know which
> --
> 2.47.0
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

