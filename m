Return-Path: <linux-kernel+bounces-410812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 374199CE294
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E070B3B300
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD2D1CEE92;
	Fri, 15 Nov 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eAkqIAhj"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F251B218E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680997; cv=fail; b=LaHAf4/LKoTF55YPp7iyutD47OC5CT+Vd+6aGBcL/K7dHxX6A7T/8M/SIMgU/sgxuDCGQzPm94Nx9uZsKW1U/pO4TfQVDgyN5ZmZEq20r2HhjRS4A7mqOgicoUDHQOWMR4/wnpLf/susdm2g7bXZkJiAQ5xiHu43baJFozEBtlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680997; c=relaxed/simple;
	bh=WvuAraTAbaHiP6OlC0uVlHk6MCFrztMvZuCDlrJhXY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sQBXh9ahQ9Syo5IrOs3AtHQZUbcPju6CD2/2RYz4+prgxN8QmMREs/3DQ5Dt2+KYsS/r02FlXVvM8PYH7KjzFxmfnqTHPMAmAk2E0z5pN8HgR1yKKKOumc1qPYnR3AydawkrfVvlhvw3RG0QCe0Qs8jUqN825O/WUgwyYGugWIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eAkqIAhj; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBtcFqmd1p4q2pAYLH2C/yf5x55oPRt43WvKyfIhhDZGXuM9CSLu3Cvc60VIeigQHaVz4LLPHkTKY+3O2cBYUODPDHGgGIdtYKVtHAC3RkzT/n0GWJcMSGX+GNk4Mk3hYE+3UIuimuwroffJxc2KFuYyJfM3c59ZE1V7MknUiwLm9oD3dWH8xloAy86YuJ6FqHOoJOnAZkjV6puuJvFpdE5/i8wFgphCou/EuM/kQBxZM1M3/fP2/daPhdIEEfLmcGJv25v+15o0IOaLY9Oz+ymxJ7bv810nPLdRgfQfuU6CWpUJkMvK8JMeCUryb5+E286a2rs/k1qanl0jWERYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJiH4sgnRXv2/Dv2rXj7vQxLBCBzZxvlrTj5aF83z74=;
 b=qjRdqHA8k967ms5Nu7QJvj2fpMfW/9GYSnNFog5Q0MZrZLHnQmZZvPy7+TOVcaKD58qSlKuBbc6QATO5uDID7D3hQcKOo/Gjya/m3w4SqtY+Cq5WwrjgYhmJIGGX4efoLKJ9ZyfP5qG4noVj2vS+pAk2nTpIU1Hs5GCu2r0aYwXXzEwodqdg9awEi9ChBgbY1qdYb6wUVF1pEFDV4zE//S1DubhdbMiZikO72Rl2m92n66Mi0xh3TY71Fp9hYoMRnb+hlrpbNUq8DB8scUaYqGssH0Qw5qSVdwSbn6uksdAWD9CSFOrMvUibYyEXIxCIwI8S5WIHxU1ZGjLlfDolHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJiH4sgnRXv2/Dv2rXj7vQxLBCBzZxvlrTj5aF83z74=;
 b=eAkqIAhjJG+R7uGg4SycDPnvozbre8aZ+QWlyWzF0V6Lk2NnV73iJwrbBiWyOMrAoLat859UMlD5NL+De25vHCju7AY5ksHlccWj4zHNHaqpLeikQewPDYrHCAvQUWU7fCzfSRgKII+uptnbfOYsp0UhwFvKCcsmsOV0MAMfOU/uii5jwpoN2bHgOgOYbcExwekCP76At0tOSWVJcylC1tIG4XgaEqxsITw+Er/ZhrdkF/lBFdNLV0ODNB0W0PVv33WBV7ljlFnakD4UiI3BENVtVdNxNvfUDSn6jsQFoMLHLjd1URXjvCFkzdAiJglmDFZqC4wdIy1GJgtuB1rhGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by AS8PR04MB8769.eurprd04.prod.outlook.com (2603:10a6:20b:340::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 14:29:51 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%7]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:29:51 +0000
Date: Fri, 15 Nov 2024 16:29:48 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: stuyoder@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Of fsl_mc_allocator_driver_exit
Message-ID: <5ogpp4jskwjdxyrnrw3j6szxbvv3gy7at2pdse2v6nynineltw@bruwu2w5dts3>
References: <ZzdRhcE2kG5z6NLk@gallifrey>
 <ZzdUE1E7ypErPuSz@gallifrey>
 <xly4pttb77ivx24tjd2zhqnrrwvvcdqdgdirvvshb2lugcbdq7@njdg5ogzho7u>
 <ZzdaC0_V6P-HsUdo@gallifrey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzdaC0_V6P-HsUdo@gallifrey>
X-ClientProxiedBy: AM0PR06CA0139.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::44) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|AS8PR04MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 05782ab8-e60d-4f80-d656-08dd0581f71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3btcu5z8l/ZwZ/qkfya7ZXS1Tz62rgNATuDKuwwggepiXCkXK7PE9dgqKnq5?=
 =?us-ascii?Q?CqDE72Rfeclm5wokMp2vGHltfjUSQnbfbEXna2jcLE0U1y2R+Fdf+6vJoLgK?=
 =?us-ascii?Q?i1e+yyWlci8kmO+KbOOI1RekAJdHOPOGBvuRMPRkbObgGB/N88KxaGlR+zey?=
 =?us-ascii?Q?/bHx/KzutBtRfSwmfqpczWnN+WYAWLxuiqiC3zMn7qwVjHB/Ery1fYS0uKm9?=
 =?us-ascii?Q?aTWIQrAHvWb6LMWT2So22QbG6KwK/r4LqTyKp33lDMlnHZMQpSxAsRPTztuQ?=
 =?us-ascii?Q?SHQq+9IOC316iEW9CXtnA2MDorFDipKCQg8u97Un0JXkqKJZeAkxpKL4iQWN?=
 =?us-ascii?Q?UvSFBqBIUbp6D51L6BULRdPaSc+aYcwzS8vTVLETcicNH0Icj2rpcv41ru94?=
 =?us-ascii?Q?5vv0OMh5wrcVZtHxWpOP1dMSw4vCpFop1CO7R49MDJ2cBK69yALqX+PDgQOj?=
 =?us-ascii?Q?Jn5p+3eCB3gg5z2I4h+VILe5p/fVwtaMzselvmqDgjynx0Ou8UbWXz8KtobC?=
 =?us-ascii?Q?KX1Sxk5K8J6Sbuuw7Er5gY6I+3c869lSY+RxVzDe61mqFDPU6r6Pf39+5Bs5?=
 =?us-ascii?Q?2QurjMXtQj/wHI+FIifHnB8yWf7FsTnRSR5kkhDnNrfENO4dQ3bQIsPQkZHl?=
 =?us-ascii?Q?kYkSjHDPqird8Qsbo7Jp4U+v2M2ISX9YWM7QDEgdWgsi+/U0LXtynu7F5xj9?=
 =?us-ascii?Q?w6A6qw2UPyDEYVbszB4TkgiQ3gVQAYixP/rnU4V03NYesx9dh9zBO9G+l8UB?=
 =?us-ascii?Q?LvLRQDzqWsnOaFOchPi+nMahuwLeQMGa1b2B9oVE1IYcT+r/x10pGjmq5U2g?=
 =?us-ascii?Q?EK3gngEK+XRSsNKdsSv/z1lG/VJRwTGWyXEfFr0EdpupfmcXBTQZiH9LkpAO?=
 =?us-ascii?Q?P3Pml3F3usIjnPv83ma3E/91luAYWtM0Eqo3FMyww4PBryLRCUSA8kXxIxFt?=
 =?us-ascii?Q?3gmif2Gq2WAA+NhKVw8rJ0y5W2bjIo12njy2py03VoBZJLOjXk9EZnI4tAx1?=
 =?us-ascii?Q?s8PNh0lcEVRtA7FIFfaHM2bfqK5V9VrU14Z/XKwgxErn8Gm9YeDd8Z+2QiCl?=
 =?us-ascii?Q?qGUkX8lXl7+3i4hih9FwIJSzPEzkAhxf4cn9KoLvzpOjkLm2Vgxe2MG5TPqw?=
 =?us-ascii?Q?VLTgdokAZ8VSbimMKE1XBXNyj+RPQjQJ8360mKuWBYglw0hcQwXnYL0WD231?=
 =?us-ascii?Q?aA+C+XjhDggodSZj/X1ywkijHF0e7xeLqMgKb2ChEhTIhc0D5XoPna3hVwh4?=
 =?us-ascii?Q?moRYNMWkXKMUjAC/ShIkOkcA8B1Oi4ROTAcH843drOS8F5JnJmnUo6slcs2Y?=
 =?us-ascii?Q?qRM50KTTG86w7MDFLEsIZVXF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AEJEsJrh8Czz6hRSEwc1cIVSUft8kCqjBOSPYFSpt8joBNuuxyaeXtFiKHt2?=
 =?us-ascii?Q?6BBee0CZ6DCeLeP+nLqWP2lw4N1HWhfv8AAKL1jNpkYWmXbhy2ayj55LgmCH?=
 =?us-ascii?Q?HwFx//dOILf/A2Pa9sQ8rNeDDquNutc7+wDhf2iSXUKXaMg0zXpstLE8i4Ym?=
 =?us-ascii?Q?a8QjndFQdAUCwVLFEbKwa3NBIsT35VGWKnXVPakDV1il3lwTrxA3lFgCIjaX?=
 =?us-ascii?Q?NNp4gJOoAU/XslzzIXocxVp+rJrUa86zZo60ag0rKvWj5BJw2GUoflQGoXLe?=
 =?us-ascii?Q?5dhj58AzYSs5r91DcVgMrHi5VOrzrp6AfTIa+Jb3pvMkGIctepzaxBBiiaLe?=
 =?us-ascii?Q?xeG4jTg2f/sDYbglumjjhmeRVQcodTpRWHveu3RDmiEfOLy9it+cSroEz/aB?=
 =?us-ascii?Q?hawsdm+GR114ds+PPFRYIwunzB9SLAFB+LR1ibTqB0zH9tIWxSBNki8/9CWC?=
 =?us-ascii?Q?StkPLGUClPLVgH1/WH7LclmZcfM8UgCfD9odC8f0F4G5DPaIE6PM2QS9ujdF?=
 =?us-ascii?Q?acnOJLrWLtiqcB0+W/SONMvrQzOrZBj4uL+7xIf8nIaSzWDfwIPv4sSlHzB7?=
 =?us-ascii?Q?og2QRBIPhu637OkuQGpEka+FoxPDxiR8linGPgLEpBcL1hbLjl1YyjTle4Qb?=
 =?us-ascii?Q?U7fdqPKAdjQlWiYJfqLx8PG8I5dsHSzDpoSOZsEDZfDyXDtC32Qj5iCsGda4?=
 =?us-ascii?Q?vwxuHICVgeLqj/eGtr2I+cu/RD8gFiH3EYUBkbSOVsa2mgSkfBEjhfIYobyR?=
 =?us-ascii?Q?auyRds/mZI3Rv4swZf4QrAQZlhfRT29/5ix2G1ZvIawfEDrs80MSGZjq/Cei?=
 =?us-ascii?Q?+r3Xg6EO23R3f6m0HXpkmLyqyJT9lBRjIeAUS+QTPMoL1D52TtOwu5L8f/7b?=
 =?us-ascii?Q?mK9ZFtIS93+UXb+QReceISdtdJ0bKmo2VDzmjOH/6uJdeCUDGQGldw6daUpn?=
 =?us-ascii?Q?p05h7OAE0zifMVoO84O0cOnawCy4BEivDm3Gafxw4Tsbge/BcLeL2zUV3OB5?=
 =?us-ascii?Q?zUmPfKhVasCqtF5JDNxPIGXuWs1Ccf5iyTdxN4GeS+45ccREvTEwZ0wmFaWR?=
 =?us-ascii?Q?4L5UH+tRS5Uuh87OEe+9qe6FrkCE/icC3mhJs0v8mwRCmLPjYft+yLMXIj1/?=
 =?us-ascii?Q?s+zO+lpPBjGxushlUkTRpeVZpxG0oud054Apvnr89K5QqbGfUF0Ui5XkDtjd?=
 =?us-ascii?Q?f4aS6y7IDfvXelL8AR33QmFS7nA85ijfjZ84jvq/XcG1APr9r3d9jIQ0/023?=
 =?us-ascii?Q?5IyFkYGEzBe/DyjpLqiFZyh91SGDgeQsI0MpitPo9Mhrqw49ylT4pqHI0ddz?=
 =?us-ascii?Q?WdFXS4JVR2oqr7wSoZo9kwQFw/zgx5/9e+AvTcEQFjeO1BXUweXM+YUY3tql?=
 =?us-ascii?Q?AeFISv+6eWGfdjn76Z+ndm0AA9xcrbvuPYW8OypPiAwIpo2rCwBtYhw+1FTF?=
 =?us-ascii?Q?xyk+V7d7Ni3vtrtkChsU00+tzVoRXfY9y88fjfcvfb1hI7yphbp4pGsa1VsZ?=
 =?us-ascii?Q?soVW1xD5fs4b5FwdLmgFd0Pz52XMXiiY1N7p8OkF45sPIu/RyVwslbH3NlZE?=
 =?us-ascii?Q?04+MF5mNIO2znG1lSXUCbyu708icKhIBbfXQpXFN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05782ab8-e60d-4f80-d656-08dd0581f71d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:29:51.2571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjt8HFBWzM5o0Tc0NGegbBLKKLq3F9LWNUr0t9PUZp2S+WcZnbGuizWfYgNJYJwpfDsrromIo1X+I4tMp+F40w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8769

On Fri, Nov 15, 2024 at 02:26:19PM +0000, Dr. David Alan Gilbert wrote:
> * Ioana Ciornei (ioana.ciornei@nxp.com) wrote:
> > > * Dr. David Alan Gilbert (linux@treblig.org) wrote:
> > > > Hi,
> > > >   One of my scripts noticed that fsl_mc_allocator_driver_exit()
> > > > was added explicitly in
> > > > commit 1e8ac83b6caf ("bus: fsl-mc: add fsl_mc_allocator cleanup function")
> > > >
> > > > but appears to be unused; given it's a cleanup function it feels like
> > > > it should be wired up _somewhere_.
> > > >
> >
> > I don't think that fsl_mc_allocator_driver_exit() is of any use at this
> > point. The entire FSL_MC_BUS can only be built-in which means that there
> > is no module_exit() which references it.
>
> OK, well I'm happy to send a patch to clean it out, I was also
> going to clean out fsl_mc_portal_reset().

Sure. Please keep me in cc so that I can give it a run.

>
> > The same thing is true about the dprc_driver_exit() function.
>
> Hmm, that's explicitly called from the error path of fsl_mc_bus_driver_init

My bad. I missed that.

Thanks,
Ioana



