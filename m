Return-Path: <linux-kernel+bounces-315803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B5596C72C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2FE1C24A15
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781EE1E2010;
	Wed,  4 Sep 2024 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HjHwqogy"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013005.outbound.protection.outlook.com [52.101.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C7145359
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476885; cv=fail; b=VNuulq7S6NHFhckgVzWA9lo6G1Xp7KI7zjO61bUDSsdYdBHBGdkfOs+8l8L6MW1sg1BB++9hxNCvaubAzVamIZPKS1uAePWcMQccqudO2uh2WLSUk0wjtbfWF45EjyY6o8Q1QyEm2g/bdufu0UJbEmPnERWvsHbfvnNnGuPJhFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476885; c=relaxed/simple;
	bh=CfQDz1RHvK+57+cCe2x2lXk7vPt0X0j4XWr/B+8N2b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tFdMl0Ve5bEiHrVmCdPOuPqdEXGzV59v8PaHEHfnbF780vnA4J3BdaGe1nXeI+ns4EbrdBJH8o/DyeGraZ77/KitpPIxY691RIcl6NR1fvWGOlmb3qIjRrQpVA7T9la1Wkhis3jrUvYr+7OTWFWrYfTCv6L+UP/QUg+psXAKa5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HjHwqogy reason="signature verification failed"; arc=fail smtp.client-ip=52.101.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uORTMBTESn4hcs3ApVqRiZs8sTAm4iU1CzRS0fE6pkx/Adygs7KpVcvBJjANMrp/4IzuTkNboZ6nFzj3MIfxYp3N34uF+Jr+Q73GoIE5XB+xx952lke+oZ/SCZE7e8TpPhPrb7jfERfoNH2eNG9J9QH1wzE6kTuqUuFasXLGnfRjawYdRfo0YUjJsuNZzt9jJnTt0MlmTo2kgGpvHn8haHwg5NqBCOHIWStrUglgNA2y3e6zE6E2h4X27BI6RkpKjKMlkgB/OEFSFkIF89T4so4ndb9fCqHZKfFgzgnT67tqVMi/2NTxoziBFKeopnPpAUb/aDqyvC1U+OLyKq/z1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0pcnbZ6siZSJsk5YmUDdSthBm9tNqjXw/PK70O5sxM=;
 b=hyrQIh0RV8JVdfo3aU7ZgDoPbwJeEZzTEubHndnCQgJNGKiW4Zc8azADqMD02u3AuM68lL8K3ZBINBBqzDc0kLV3ZYpZdUWoqCKw3i+vYCWvzi+7gvYPL8hKcCjW9PnTqI6UvgdX/nPKRcV++wl1mbuc3vP50eC7dhxhCiZTgd2cMKN3e5g9aJN/eQjGFMsMron8+mRG04AMBVxXiObYhwHOL/nXU2neWVWmamGh9flNVwpCVxgHyBI5ALZfnEcTev0D5vO9Evt2/eQagiRugGZJNp3nf3BHpmnx0PCm/WYms9sEfAW7aVhpGjFpIfs0djwuDyzjur7xR4qLw0GxJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0pcnbZ6siZSJsk5YmUDdSthBm9tNqjXw/PK70O5sxM=;
 b=HjHwqogyheYDNhJFrD9m8+ndhAr5ffS4B1+GVOVVTDvLi3jayqAdOon8iw2JBSh7dTPkalTYZtFzbduxnJczjIgsB5lpkPBFw8h99n4ZF1n72PZAmOQj2CSFU/gCTlyKyKOUxY2y3hBdlFrQSZLTi1EmcNam0/j93eNVJTcSbsacOAmR1ZYt78BXgYptu97bHYFlwbVRalgzj3EznfyiT3Q8u9lbC5KXxPkIVX0Zuwdr9uOTcCHAgusb5yajvphJ/OXytfJB7fJgqC4vV7HsBFKo/s4dEnK5xpRx5Emy+4Ojn2KNo/AQbgbfxJZtUlj2O/7Wj7Klb6wtpQuIk5C5nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10858.eurprd04.prod.outlook.com (2603:10a6:800:27a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26; Wed, 4 Sep
 2024 19:07:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 19:07:56 +0000
Date: Wed, 4 Sep 2024 15:07:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: carlos.song@nxp.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-imx@nxp.com
Subject: Re: [PATCH v3] i3c: master: support to adjust first broadcast
 address speed
Message-ID: <ZtiwBUDaVgL9Ejr+@lizhi-Precision-Tower-5810>
References: <20240826050957.1881563-1-carlos.song@nxp.com>
 <20240826101323.746b617c@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240826101323.746b617c@xps-13>
X-ClientProxiedBy: BY5PR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:a03:167::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10858:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a17284-5658-4557-ad46-08dccd14e271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?5/V395DPyH/Mbw64P7w5n4IwqVXND8OB3l7u6o6vI1YtRUJVIaUsfU//88?=
 =?iso-8859-1?Q?CxYAQkxbTcCe02LZkT86TqwSXNvbuy/weyvsuFjamoF8ydSVz8IDiIWomS?=
 =?iso-8859-1?Q?Hp5dNBv8uZcU+0ZCVF3KNS/w/DbOXVYOesp5vCdfVrh54JGrGHPVepoqAF?=
 =?iso-8859-1?Q?4nkDukjfy1hXBGopL4lKEP/WKAHZOsOE5l9V5KtVnpZosAiQYKL2JAA622?=
 =?iso-8859-1?Q?Vrkf/S/jbxGWpaSfPEi4yaq3R9Fe1QH4UG9lCS+jyxQ4TU+RUA3xgIeN28?=
 =?iso-8859-1?Q?V+d09khZR5QRrDBPs8+1uhsxF3dpgrm3fZ/BCArLhKvDHUZnGdVoh/lMP+?=
 =?iso-8859-1?Q?GkTys27mUuFFDoBOFx3JtgB/5PQXjlzXb2vybdxg/LLKIVw5Wti+rLQse2?=
 =?iso-8859-1?Q?gnm0lQfYLO3Z7/vEp4sZMhOInT450fL0mkDwg3OJhMCOdlQkCQosve8bNv?=
 =?iso-8859-1?Q?k1ufXLWG7TsLEujNJrPt0rQppoJVWu8ytsjW7E+TJH8z9E98A/5Fptd6Ew?=
 =?iso-8859-1?Q?LmSNQxgYQRbfeSXq+h1szZ1d7JtslHVvj1b+ic6HWz/O8nBEag1h5pBKB2?=
 =?iso-8859-1?Q?R6kNqbt5tN7StI6QYv+6d4BT8K6ocw1mIVmZG+lQviyT1olpwKMEvB63Ps?=
 =?iso-8859-1?Q?WtSqCxUcyhrY24EIkAKdVsX3vP/1+0n1lFBu+9PxilRO3TEWm98PjO4agg?=
 =?iso-8859-1?Q?fZCFnvflzDS+BUpOkeOs9BN19cOLRqvEA2ovvANsXMeLOJr7SWFBh/0OEq?=
 =?iso-8859-1?Q?x8Z2wCQ2TwMHaqiLJ09sdYM4R0ONdApBiWSXLRCH0Y3TYDOGah85Zq0bpk?=
 =?iso-8859-1?Q?d3plrl31Z6zL4RBlJlekxpRUlUyjN2hmSob6tooyzMOk1q5Cg7yTBwPxHq?=
 =?iso-8859-1?Q?tAHoZE8dfAU76Fw6Ww7w0VPVlCVO668mJjDbvWq9NwonHpKs3+mgm+D+kq?=
 =?iso-8859-1?Q?3XWsQq946JL3tzOR/KdZrratP0+lDjUIGwFe1A9qr8S8UmanuPrgv5Pgsm?=
 =?iso-8859-1?Q?IE7MpjpQ5onAGwzM+3r77VcXHUsTWXWSVbawjUXBPPGrbYvCr4dVVt3ULp?=
 =?iso-8859-1?Q?iqWPtP/LgpzzYBquYQlwnfh2HhoNc9jeEYcykc51EWXBQzLJVEF8a4PysT?=
 =?iso-8859-1?Q?xYFczN/v5YASFVQBMXoWP+DYNgH5ar1VSb6KNYa+dqg/iRhG3Ckyl5TzoS?=
 =?iso-8859-1?Q?84I46PpkGIZ65CYCB74O8V3vUllUrhM4FYZzF+KEGUP3m1ol9t52Ilvceh?=
 =?iso-8859-1?Q?oEPFQH1Pnxj96r68j6B8lghbiQCGAisZCg1eh54ZJySPKa5a9X/3uu8/Mz?=
 =?iso-8859-1?Q?cqeVWenPq8+uzAqPiHLwy0QKgAuQL7bwlzn1ujjhrOYUkxyn9mN2z4jblh?=
 =?iso-8859-1?Q?+19vl1lovb7uYy8sI6ndsx0Dy+iqrWc8NxbG5dsjok3k6i73u89bLFDQyv?=
 =?iso-8859-1?Q?LnvNsCBM34y9bgIo5jeKQ4WXB3k/BkggYkZnQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ecW/xu7SVN7MYGmtScx7TS0nPZ2ZBCHZsSyk+O/UpY353bMSDxtoLGSTW0?=
 =?iso-8859-1?Q?J9G1insxfEWhfKP4cMUnfHnuIKYdCa5xl8NMI6I2HKhXdfHPMpqKGk5aWb?=
 =?iso-8859-1?Q?XY67OkYJ/s9zhb4QQ7LvjfpyU879XCqJqYHZIBDR/G70qNDrD43T5xmqH9?=
 =?iso-8859-1?Q?qMXvIjVbThdEAtWONhLjpDmwoyVAictG8zE4FqgnLE+t2nwhhzGJuWPH9B?=
 =?iso-8859-1?Q?bcuMiwksAgpSe9lMh9kqicFgwDVbU1XPkpYaOsjIUjlpPcWfcgmLA5quM1?=
 =?iso-8859-1?Q?XMJ9w/DTzzx3q/KcyuCq1HePbuy51L42LQucKOMnZvbHLou90THWoce6IV?=
 =?iso-8859-1?Q?Sr6S+zi+qQyqoA9ncSDswgEMp/U8TaflQWrqvExQTQv/SLv7hkprWLXWMg?=
 =?iso-8859-1?Q?jxZpDrNtZwJlooepySp+q1cgdCa5rdIieISBGjDJ2msHAhN1pnaDIOyUCN?=
 =?iso-8859-1?Q?Uufn2+N9yoXUiOIOBWUXZklqI0/KACM83Io9b1SuWa1AT7DQPAFP8d9B/E?=
 =?iso-8859-1?Q?ZIs8bExJhc+LoMD+JnHlv8tGKz9oOjnA+7BqvyT6k0+1T5KLMFtMXiYFw1?=
 =?iso-8859-1?Q?x9GcAn2ke73nWb1VbGRnXCuyO6VuW7LYIBnhoPFJSh2UCbSnNIxXrFtA1f?=
 =?iso-8859-1?Q?nX3aQDH6QUaBqDp59BLKiCK5sDrDaR+Qpaf4o0kYI5Kkfh0fo7KI04sndE?=
 =?iso-8859-1?Q?GJLYFallkrmbjv5b8x5Rp2jvhkWoYfFhBa9J3XD5xGrECjzZ49cXq6wQj4?=
 =?iso-8859-1?Q?Cx5OR4oonPnSi7KxntsAkfwms3aSOyS/3bf69WwT2Fwi/uXqtdMaSznpa+?=
 =?iso-8859-1?Q?ALwMw8YVpbtilXD5dNwDsTnzXNZ0RXfZJAqpfhrQ53tRkg4oJL7jnRgNQc?=
 =?iso-8859-1?Q?vlkz9WPyS/oh4MuQEGWsAPIeUJSfVt6WWLMSmhNKRitOxJ+/AkhoabUJSM?=
 =?iso-8859-1?Q?KkiSbaWd/ITNLIIbun1p5T4NKuKPbsKxsl9Fu5DZIpVaI2yrk5+oO6U4HC?=
 =?iso-8859-1?Q?RmAtmYb/AqayzkoiVJLMSqP6pr6beBcKwpJHpqyzbg935e8iytipQyMMmt?=
 =?iso-8859-1?Q?37IAKfArYtZIaeI8yHscoYGhOlJhY6X1El3F9L0P757CNjq8mb0pnPcZCh?=
 =?iso-8859-1?Q?EhMJ8Q5otG0POZsMHybMK/fqkzowCRo9rPrjkd2VdHhE6wRu9wzL6hP8iN?=
 =?iso-8859-1?Q?+ravbeUUfwvyQuvs8fL7vv9lcB7/xAhgHrE5Wp/JSvPBI+zhLntqF2nq0j?=
 =?iso-8859-1?Q?5tp3KcNewzQdSl9XuJwiSkdTF9uuTjnGCYZd9zo7Kc/AnfEC5qRwEESptk?=
 =?iso-8859-1?Q?WhrOnsGhSjw1D/19tEm1U4ApM0CZFS8yWLEXqA7KXxJDcAs8BG8jxys49/?=
 =?iso-8859-1?Q?lNtAB+8UpEb/4lxvWI437KtajNdTqBy0fsskJhOVJVq/9u/i4rTwKzvRZM?=
 =?iso-8859-1?Q?ror34HnkY0ajbQguLg1Zva+CDIeaf54FbcfKTgdeCEc6A9KLW1nxLA1zk1?=
 =?iso-8859-1?Q?b9f6lP10Cvs7nHpmVGWWPFsL0zhyaeM5wuw1Z2OVo6XI/fT+ua7Zn2Yga+?=
 =?iso-8859-1?Q?2KJv1nMoHGpEmUZVbAtIQ+VP9RVWLgkqRlKeOjkqK44uwdfl0pIO0AG8kJ?=
 =?iso-8859-1?Q?K5Aaeadlx6+1ihuocGqeLx+D8yTQoGPY5i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a17284-5658-4557-ad46-08dccd14e271
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 19:07:56.3866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cja4uWnbkxwHtnyk1+0jL3EnvK2Yugk+hxmfTetyXeylupUXtV+qRxlXj+SJHzrLFIjy+vubQ4r9fQqXIR5Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10858

On Mon, Aug 26, 2024 at 10:13:23AM +0200, Miquel Raynal wrote:
> Hi Carlos,
>
> carlos.song@nxp.com wrote on Mon, 26 Aug 2024 13:09:57 +0800:
>
> > From: Carlos Song <carlos.song@nxp.com>
> >

carlos:

	I just realize you missed sent out svc implement.

https://lore.kernel.org/linux-i3c/20240807061306.3143528-2-carlos.song@nxp.com/T/#u

	Suppose both patches should send out together.

Frank

> > According to I3C spec 6.2 Timing Specification, the Open Drain High Period
> > of SCL Clock timing for first broadcast address should be adjusted to 200ns
> > at least. I3C device working as i2c device will see the broadcast to close
> > its Spike Filter then change to work at I3C mode. After that I3C open drain
> > SCL high level should be adjusted back.
> >
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Frank, did you test it with eg. the Silvaco master?
>
> Thanks,
> Miquèl
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

