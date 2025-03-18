Return-Path: <linux-kernel+bounces-566319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277D6A6763C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB86169689
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7A720DD43;
	Tue, 18 Mar 2025 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cQcOPhlI"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88E20D4FE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307734; cv=fail; b=hHHSzSuKNZiZxRkOaZ3Mi7T0bqaLMK+9MHh9yEaByeeTBzPFWKcHVVFMu/cWMuFk0jKmbod8mo/jFExYPJRv1da1fvcpxZ5KKxUt6+8vBG2+wTI4o4undDtiFPnoAAyZFpAlo9U6zYowOL1XR9x3GPHVUCFB5c70fI5rAsfsUfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307734; c=relaxed/simple;
	bh=kNqcrIC2uXF2rPkRU7AcZdy4F0LM9YE0eIKN0Wjfa/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n571xtdcLs54rZEL3rgGQQl7WIdXG7HOen6i6ooCSId6B6WTZx1msokXF4Am58fCnWshbxC3KeDnHBQKLLDkC7GHsK4Aoe20kWNcNrJDhPgQSF7371C2GFx0uXv78/IIpAb9yW2uyrvf1btEW7xDTSMd4psEmQruzEgqq9A3CyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cQcOPhlI reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mB6WP3rh3ZcjzUIgfMPyc3IM190sxs9mYeLcDzMCy4Z7/AnZ+wb6d+MtaRAmBUKowBbuF3dGA42bfqmXNmNIh/3L604ZrAoHe0jx/b2hg899ZTIuldUgpSW0jjzZmY+KkEhRAM8yaW3nOSqXguxHeIXMf3cILdkhbNSKzQKltJj9QRzd+r+puMFsCCSRXZGDM5UoihzxQrnTMah7RagjGZbtcmDJIBPtYWkeCppsIJ1NsCQcin/1P+yrkttdXqNUMF4aF2ARVmVLh7+Ss6Pwt/kRxRF07GltNy8hbGGOyksan4VecZKUCzYynW3NiTV5KO6fECeddgUuub7r5ISUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLyYx/I2Tqs1ckQbty2ys1JUPD8q9priUHHgwPLsxwY=;
 b=U7dBYykvbzUf2IBcDJK+CtX1ybp356StCUqt5HKHdfIpUoB3h3Ic34ATge0W1Dl5V+ECZjurPvW1kGWsrUh/pmZrlmbff3Yw7Zz4jqhlP44VW8w1q5xw6fiBB1KHdy/aDi0TlR3bKSHY3v9XWIsXL8wkF/orsX96Pe2mff6yH6vFGy6d4/H6yIZmcQ7OgioaYMYu5qq2+AXWIos8LLvQUopmEKpdVbiwrIchiEz1khDtMXZjClIv2uss5tQxaBZViPaJCdBxg0kwWmMvNlp0aMGAIlLP/rfME4h+ewA7qWixM85cm7Lg+WzWhaCuJVr8DzlF4vaU5egNeL9IzcTHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLyYx/I2Tqs1ckQbty2ys1JUPD8q9priUHHgwPLsxwY=;
 b=cQcOPhlIIvmZTlyJbYr4M0nz7XdHSYBciQrXSXvy2fMpNagYacmZJDKfgYRn5oNwQeU6juhyF6OMwvf5Z9yLhwIc5Znw3BQxlUpAVU/OOPDfdlwPJQbXFQ6ulHSuCHL5SDQQr3yAq8J+uJAYL0wo8b+H2cC8LcSUhh5XJZ6NmV4f9WbN/XCXma8MnjLgYisvlhwhmHCyVmiDpxWYWITe+iA+rG14sUII73iN5eVT28OnOK87+2FVNM/CA/XT1KXQA0TawmgxyXQBSCuIhzi+SuHO1ECap3K+qT20dSTTojtgyXmyFI1v8R6U0J+d3K2dnVdZqR60cx9KUwyRRTDdzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by PAXPR04MB8621.eurprd04.prod.outlook.com (2603:10a6:102:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 14:22:06 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 14:22:06 +0000
Date: Tue, 18 Mar 2025 16:22:03 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Stuart Yoder <stuyoder@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Maintenance path for the fsl-mc bus
Message-ID: <j6vj5xreo2ub2mf2saabh6hxvcpqkgboj26wgmi4y5iecboddo@5urri6jzvue6>
References: <2xzljdzktgpsyag5jhfwbxc2sroaacljecsq36hlxefu6jnz6g@zlorxu7niqnq>
 <1d822960-85a7-42b3-88cf-9d3dbc75a831@csgroup.eu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d822960-85a7-42b3-88cf-9d3dbc75a831@csgroup.eu>
X-ClientProxiedBy: AM0PR02CA0103.eurprd02.prod.outlook.com
 (2603:10a6:208:154::44) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|PAXPR04MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: f88c254d-5377-41de-a9e4-08dd66284290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?H/vrLVR2JEX7g2qnkDAypHOPkkA393yVUZ5HKC1TNSgyDrIUWn8O0feAWQ?=
 =?iso-8859-1?Q?lRddaKuozWsAzIK8/6VOFI4YnHyFClVqiON2vpZeFt1SZjD83Yo9RYAEy/?=
 =?iso-8859-1?Q?wt+a4JoCRW2Y7Bv5ZR354hrWEtmSInrq+qeU8K+Fq1UrF6rUX905AvN4tV?=
 =?iso-8859-1?Q?NQ75tSW0ciXm230Vs6Yy1c2ZAJUBcqm85eh7cqF6ru++p+/8jdu0ceknHw?=
 =?iso-8859-1?Q?G0q1ow0HieyzqZtYwW9o4rgpJj3D1yGCD1yg3JQyKgF0Cjnb7e9l1k7tqy?=
 =?iso-8859-1?Q?Pge8dVHDR+EyMVNwLH+nIs8NYXjUoIJAR9GSodmEIB6btM5zNYw7AQzg5T?=
 =?iso-8859-1?Q?fItd1j9v8dV18BDMOHsuezS87Zr75VCd519fSljbGawkWRn71PRGHc/eSU?=
 =?iso-8859-1?Q?aGuuEjDOjATulKA91Jor2PahA7BpcGc4hKd2hFNK2lEJjIKo52jObInS+K?=
 =?iso-8859-1?Q?RF/gXtx4P7DRvid0B5vQvVCSQwHp4c9Gxo1tqsjlcvt/oa3+U50q7Y5nfU?=
 =?iso-8859-1?Q?c57XSwQQh5yNcYaPAh7b2XaGt6WvqGre+x1F3taXnZCziH+Zmh19w7pbs3?=
 =?iso-8859-1?Q?o3E2mz0HkdtK0nIlkB89qyzcBEcJ1HRk/hSxZNpxH16GutKR2ZmGIE5hb7?=
 =?iso-8859-1?Q?yS15xzrVwEToBSfkfGO0WSNHXfKMkBp/3ZYy76SGujg91uT+BfNdW3Zols?=
 =?iso-8859-1?Q?4uilEmkZM2n3j1fJNbhunlzBv6gwNzY2cLKT87IEfYdXM/TSiM41oKSEBq?=
 =?iso-8859-1?Q?P/AtWjXrYXuZ233zCzHfnnDXdiOS9tZoEvDKRIZw3fM3UidOywORwHmdqL?=
 =?iso-8859-1?Q?+aay7+apkQpJ4S8/ZBMmAag4euwWM5iua1FhOfz2hyXwyPfPJpj228rm32?=
 =?iso-8859-1?Q?KIjDjqdc6BUfNP7euhsho0oiM1+MX2L+lm2gG7HkWjrX0RkPUrGJFp6FOY?=
 =?iso-8859-1?Q?maF3MDqQuYgEWNxB0JShgfXzJCbiZuKacUOVkzY9oVPq0W5s5tzTSJ9bsG?=
 =?iso-8859-1?Q?4raIDr4sMWcFZGh/coTW+YxjMbTKuN3nVBpzDG6nka4BUtkRLh8nPu3+Tu?=
 =?iso-8859-1?Q?kklf534Z8LrXz14z/mozFrzOApulcJa7yKUypmmKgO5diyrHpOEgoW2HAm?=
 =?iso-8859-1?Q?QACd2hvPBIjHl48UudIg9h5ox5i3+Sr8G+5iu2aBf+xs/rT5nJN7osEU+L?=
 =?iso-8859-1?Q?1JB5zs6pe3ZZ/th2oXC8BUw3MotxOdhfFs8gqOFaFgjKmINhDDpRR+I864?=
 =?iso-8859-1?Q?43EmXIOMGD8iAyETy5IdCJrlXJsJK71t2g94Ve5Nint5fO9yH9DTVD9BF3?=
 =?iso-8859-1?Q?7rrCbt1K6QjKWbOM576BcHICf0mwbOQNduKpcFcnjPeUEpZ3fudAK1Adla?=
 =?iso-8859-1?Q?fbETA4JpiDdHS8HS3bQwF6lMKq+/1rjmmbD06WlzvLs6N10ep4ikceN2GX?=
 =?iso-8859-1?Q?X4Fk1XT/b5Vnrac6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?CZpsQdGv4QBJ9iaiCAQ/lbuhPVQBmrauXvJvKVRGSW1HUdiK/NGudflUkc?=
 =?iso-8859-1?Q?QD6AZ13gtmzRMpVtWJxe8KlZD6WZInctljubpgrE3y1GpPLrXCUN3OMdNc?=
 =?iso-8859-1?Q?Su1nr/6x0XjtI0LuYfDC72biDJlD4twyJql4YZyW0ZhoJisFsh+wvTCo2/?=
 =?iso-8859-1?Q?fO7N8rBcbBNrSiv4kDglPChexbbX04egwtLDELRfdYZO+NcSYnQo7BoK7T?=
 =?iso-8859-1?Q?SN9U/TbgDlnnUZJFHOJq/UXg7cVyRVrHPRmiaMYSs1UbVTSIXoUWySBuJq?=
 =?iso-8859-1?Q?y3qXQwNSgqiPxZsHBK1r44mWJTXN+4UqcHroYRqoUV3r0KodSYqWkZdFYz?=
 =?iso-8859-1?Q?NcXjjYFLkWvvbBS1D/aU5ZuCOOfZP954dGOPbb7aa0Vipj4OyVBYpIH1vJ?=
 =?iso-8859-1?Q?3Xox5rJY1J7ZxJSAB/wGz4f7Q/FnQyETUEpjoC0wdfCMYW6yBEIK3tYpMn?=
 =?iso-8859-1?Q?7uT7ZnBfMFWJj+AbCvE5GaPO0UfjuqBZzI4UOVXOJmbWZLkmDy/18Wlww0?=
 =?iso-8859-1?Q?+yJf61JZNhNusH8xzXuMVQk1pkVkJY4M4CHGHKvWZ/3M/PT0YQDG6UsKvK?=
 =?iso-8859-1?Q?oxKSYLS50d8iimMnBBhV121KbC7GN6qXt6p0/g1t2H0kXS73jebz+C9wXq?=
 =?iso-8859-1?Q?HHPKJ4OZfyUZTWAheP3jWCh3o4lS1GtL6JfmJXykFfk5sxx3Vy6lrik9iN?=
 =?iso-8859-1?Q?NeCzdbSouup2JRwABIFoWmd4wv1Xi8zH+FueoBrHVDcj99Oo++nLhA7cwT?=
 =?iso-8859-1?Q?zTClNsavpy2LUzQ8DN/EzVqC7DGPBQMKIgkidfF6uPBRT0dIP3CFbjvFxs?=
 =?iso-8859-1?Q?3Gf/bYI8r3fw7ZGZcFRcRhXtRky82vTqZjHBZrj5oUtqjxCvU5R50hs6dY?=
 =?iso-8859-1?Q?nVHYzN4EF8FLE7RshmCRWQkRiz2VsKewoPag54RAJQfcpwtFaHjeYwycfn?=
 =?iso-8859-1?Q?LY/nII0ydKWdI0ZgUR5/bAGWed3IjNsGDDlFq6FroW2Dck38O0gIR5QF/2?=
 =?iso-8859-1?Q?0LD6pw0Asi6qdJ3yXjw2sUpylzsWRA5eFpdEaVNHncwmKZ8hol3fJwJh/X?=
 =?iso-8859-1?Q?K+mnb0aouYLlMytWqTzhFbBDhmHLJvTry+3XLL901KsyNCwgO0hrq48f8E?=
 =?iso-8859-1?Q?3IxLCNfSrOZ6dsLA4cQgrhI6ZbJvrhunixanx8KmA5XMQ9HnBbAdHFEgIW?=
 =?iso-8859-1?Q?XBaYUADG68ZjtvPYITAQ1YQE46tNWbjiWmfEY8Y6zqFOZ4P7hDG2bx+2gp?=
 =?iso-8859-1?Q?ml3liVX43yABATeMTWCmRUYRqake0NiN9CkKdexu++zKSlAcTQAln0RvOi?=
 =?iso-8859-1?Q?LlqU+o1cSu7g/vstZ7VF71Wu+IIkJkijt+DYHFH8xY/Ds/mr+q+hzymiBQ?=
 =?iso-8859-1?Q?BmSHlnl+GJJD42H28jqepgapUhPH8rycC4NMzBJNDn+XE82GSHLG0Uo3X/?=
 =?iso-8859-1?Q?KKv+kw2zwjSTSMJWSEX5QW58McPdWljCQvsdWV+xwW5vN1xuQXGa+PPCro?=
 =?iso-8859-1?Q?DKT7DkVRcG1xFI11+LmrDolM7RIvAKwZSqMCg6klRTJToSQr/QnqPuANwJ?=
 =?iso-8859-1?Q?cUNDxq9vt3Sen4Sk3CJMj2H/0XapJ5Hpw4scIOpOfhWNQGcvyChF3XPW1A?=
 =?iso-8859-1?Q?2+bFDX61qXnrjhgPqYz3uIijkygg0pA9aC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88c254d-5377-41de-a9e4-08dd66284290
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:22:05.9621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVreZG9SuG52cZ1HfGh7Q3QNlbvpvoIolQNINeotk7gCMi0wJwEGlE+DU56fAXbBxTjYIoDJMzqfvrtNla+JRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8621

On Tue, Mar 18, 2025 at 02:46:55PM +0100, Christophe Leroy wrote:
> Hi Ioana,
> 
> Le 18/03/2025 à 11:40, Ioana Ciornei a écrit :
> > [Vous ne recevez pas souvent de courriers de ioana.ciornei@nxp.com. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > Hi,
> > 
> > As highlighted by the discussion in the following thread, the
> > maintenance path for the fsl-mc bus is not clear.
> > 
> > https://lore.kernel.org/linux-arm-kernel/Z9Lj9_yM1EK5pKee@gallifrey
> > 
> > The fsl-mc bus driver was first added to drivers/staging and because of
> > that, Greg was to one to pick up patches through his tree. Once it was
> > moved to drivers/bus/fsl-mc, patches on this driver were picked either
> > by Greg or by the Freescale SOC maintainer at that time - Li Yang.
> > 
> > Conceptually speaking, the fsl-mc bus driver is contributing to the same
> > infrastructure level as the SoC drivers maintained now by Christophe.
> > 
> > Christophe, would you be open to pick up patches for this bus driver
> > through your tree?
> 
> Yes its fine for me to take it via my soc fsl subtree unless Arnd tells
> different. But be aware that it will be purely administrative. I will have
> no mean to check whether any changes are actually working properly.

Of course, I will take care of review and testing.

> 
> In that case please add the following entry in MAINTAINERS:
> 
> L:	linuxppc-dev@lists.ozlabs.org
> 
> 

Thank you,

Ioana

