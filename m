Return-Path: <linux-kernel+bounces-346621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866F398C6D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413722857FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3481CEAB0;
	Tue,  1 Oct 2024 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f+tuvN7J"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3DD1CDFB6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814551; cv=fail; b=MlgyyDpanFL2nEBl6IPXFRvQnarTGwX+IlgOyy4ol0LQKPJVe4k/cwXc6fFuyOmUTQt9B/3wQWH8S52nIIElt3BffUsvAOcQN/3IMMcChYgwfDU50S0z9MOEbOizW5i0By1ZLgTLy61aSW9ZFvTA4osi67C8Me50sLNkExNEzhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814551; c=relaxed/simple;
	bh=Xboey0z0LIy4nDMFfCEpcQChEccWaqKcI6ep3yznVMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c11bS4vO0fEMtu6eRgjqTRDZt8xqGlpGn3jO0kY9IZjfqt5LZ9EnGOgY+1q6dOi8jfsEyLCE+yvwSfy/Fq560K77KUgoU9hrMQJ5PQ3QjeTx3YE0EKEZMt8ei7SjdQHoZNNYpbO/Vxk5qGhKlBdoj02dmtspwcUg/DaeN8ftYbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f+tuvN7J reason="signature verification failed"; arc=fail smtp.client-ip=40.107.104.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqTi8DiIhBy5cP1vr+iX9YaaQHlfeWVyVxC0imWFX1bAuxSYa9vcdquHTVpU/Eh0EUgvvcdbOXjhqrzPfCGSXgMBF9d6dGpBKCn33R6nkklJzJurOQqnHAIiYvaRZnveBgc9QMpp3hvDBvGb4w3YV1nQ+w5d//AbkRJGB4rxrceD00SsZu2MwfO9ciCKN0ikAU21mmzHeAo60Pw4UW3NWige921st368wMD8FJK44AVhHV6C9WzYHRuHVjH6sKUO653laV8PBPvbse15c45paoF/KvZ9dy1KZK20S/zL1e6JEAN6QsUikANOZer0DczML/OXdZ7gBxmWJpJBabcPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHEFsbACc93WN7Tf9UsF9SHPgO0k3sa9ulDrtXShA/o=;
 b=a2wHKujL+L6DLZcGYQlmE24bjqdNiiP6BirMUDFaqxwYPmd6jRlRnH8EWAGo5VxZeS0rvttDuB6LEyDNtAK4txgMVhwTRoyU71NzsT568aY7VxrOLxppiX2YHQgmKdZ6TvQqgyuFv+q/jLU1ZChD38j3Noj3ZUgztWDGkovyiqIbgeX9WfLO6SrnePBfLgKDUnEIfJ9BsvrkVA6kqBcb5aA7KuzvAxUhjOycWPnbHs5vSJKVZU8eEkKJN5o8Vwyd3ssfcDdp4w3AHlJ45RKgSJBdmRKPLLh2HN/xHd61gAcsPVLD1TtkWa7tcwnSMHV/jchpovzXMDJorDTtLM6EDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHEFsbACc93WN7Tf9UsF9SHPgO0k3sa9ulDrtXShA/o=;
 b=f+tuvN7JQUQ36QEJoSDuemg2dRjK7OlCWphjkJXm2KKI5xdMUv5jJrtJ7g3j4LF4uks5SDwAS5qp7CL2r0rXGfyZvvQQE+Uy5GRn9TAxr7PhALVaEN/szSvgL8iRT3piL1LKmNTZF9n8w3dM7HGsUpcf69NV1Ov77KWJNFGsgK1/8w2s2HWteOdlR1sFDfvszfjaSl/HR8ZjX5jZWTCTNVeS+j9seyQRXfICP4LUnCCki7VbyRQAjmtq2ES36VpVrnWC3FpeefWBRSqBrpSMNrFoF1p6E+ldR+Y1zz8m4TAJcIrOD2/9WBRRtDCBSfJGyajkAuKp5NrXUOq+M27sBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9573.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 20:29:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 20:29:06 +0000
Date: Tue, 1 Oct 2024 16:28:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v5 4/6] i3c: master: svc: use spin_lock_irqsave at
 svc_i3c_master_ibi_work()
Message-ID: <ZvxbizZG0phiS56Y@lizhi-Precision-Tower-5810>
References: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
 <20241001-svc-i3c-hj-v5-4-480ab8aed849@nxp.com>
 <20241001221509.7d418d15@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001221509.7d418d15@xps-13>
X-ClientProxiedBy: BYAPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:a03:54::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: f04a272c-6f0c-450a-57a9-08dce257b250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?4VCP/FaP+tV4yo3Ip/SB00gey+76RnpYZNpFmCSYAZqQWV1ySmY1ZIWR+j?=
 =?iso-8859-1?Q?8FYd4aS45+VpyPBwR2dSWJcEgd+GYVu+oZQVfdNK6+Hy7MGNI8b5r6ULSc?=
 =?iso-8859-1?Q?kk/SeAzkI+AXw0XWw9TqY0u6jxYz1Fl1QbPSv8EXqCKQKlbL7qdWVC0wuU?=
 =?iso-8859-1?Q?t+xMQLvVJ6fgZumqhTmoyeaUeMu8CKtkhPOP4L3whi2b+XL0qVyxWSwt5T?=
 =?iso-8859-1?Q?OvKmpZd2gSzHN00rKozSUoWycxMVQI95WA4K9e+v8fP7FbhNM7yCNQ/Jv1?=
 =?iso-8859-1?Q?wIloloahUAUjfAIvTbJeRi19Dor5ChpSqCEzsVe4MBk4gVTobHeuwKEzs3?=
 =?iso-8859-1?Q?XvDGmJm3n4qfQv2yeLBRMG3Qiv8Javt1+pT3FSZOdRmxrqXl2FsMBjTogp?=
 =?iso-8859-1?Q?NZItOC8rZF9bHzd7zCHKyGl92uAabDvvXjSs7pnHnuFmKCHl2pv7PA6LDF?=
 =?iso-8859-1?Q?dx8mfMpgjLa4j64LdJK2oyJWE4YvmLo/DeccOeAUla4jM9ZJS3u9jVdiwS?=
 =?iso-8859-1?Q?uyjKVIYbveMmb8mbB+nSsiSDPjg9IHt5IvwyGG19HoZSktxj8Iu60Y4GOJ?=
 =?iso-8859-1?Q?2oo83j2pqUuqWS+v1KqiVJ5meGQl834c7Q8fj+EkAFVGDNzJVMfm02ZLfb?=
 =?iso-8859-1?Q?zVzUwpwbS0orMLGTk4TOUWR9/zVsbLCn5E0ud/h64wuaJuloFfNsJqlE+D?=
 =?iso-8859-1?Q?QxRRm4PaLwF4cQgcsLhwN2ImmBfrSUj7tFdCCMIT98cZzJ4DgCgMKrxEp4?=
 =?iso-8859-1?Q?BHdU4H+FjV3zfZnAyGNdg09m7ZLrOLN/arlTaYwVT2DeSWd++49qAPZXmv?=
 =?iso-8859-1?Q?xYqM6zpR4CfO/aWvCyRB/MJ1QlBTi3CIHE780d4aUXIYZIZNWNYZgHsZHn?=
 =?iso-8859-1?Q?0db8zN4U+g78vgfSBgGKup0jpPdiX0B67FDHZRdEtZsv4IRf+mZ8GyNL9y?=
 =?iso-8859-1?Q?ufMmaw/Q1ePOM8+czeQg0KrcBjCblpVDmblgItY4QMs/f1cPqrHnQ8SbbL?=
 =?iso-8859-1?Q?xz6YkkKeaqeSQbYLNTUm+CJembYBBT+MNVMIBj+eZc7MaTUBB3u9GcuxZs?=
 =?iso-8859-1?Q?dh0HNE9SxSph0Gft1cF34OGnOVrzcnAovIrPvJiEEHqoV4/wy1Pw0Anc9R?=
 =?iso-8859-1?Q?yuz3rxwLQEhA0edXL5YdIgNyuqdBqhd0sYRt6ogon85FlAiIHOzKsEEPVB?=
 =?iso-8859-1?Q?Sx7xLHKvAjJ1aihjCjnqpA16tHQ6lDA4wKNWGEFAEQRnWyHxWwRPnoziwu?=
 =?iso-8859-1?Q?N9Ff7MTJMjVNuaoFqHxZJf+PYl6ImdI4kVhBbN9v/MsIyNAw9GCEjvyKNW?=
 =?iso-8859-1?Q?DHwKAOnC7f23GtTTmXrvweJkhAGws9Z6/nDJZiTg4fa0Ac46dwSwCYA6rE?=
 =?iso-8859-1?Q?+U5qzbphOGd8FRLtTbho0cFFhN5clKN0Y1qrqi9IwzJwmOuqBJw0QD0k0b?=
 =?iso-8859-1?Q?sf1fOUIpc5Zl/EvXgqrw+AMHfhjCdJXG5shrhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?UAwDSYVSYAktI02V/D9acKdX3lkoreKqFBnJFQdG6kEjxTk+FFbGj/WuTH?=
 =?iso-8859-1?Q?lr1BNnJZe/+nWxvpE7kMAK4O0LphA1lghfWIOfmQR1B9URSJ4a/xO90Zy9?=
 =?iso-8859-1?Q?tfP1kSWSpSiL+OgE4v8crDRoj20KGG+LK4LWkUqenJ2EX6MGimw17w2KRh?=
 =?iso-8859-1?Q?r6KvqxmF/eh5v4ORM8xzVRixSM2HdBwj2YqDLBNzQsBHYrtbvQCpHyrP9f?=
 =?iso-8859-1?Q?LGC0l2WacjYViFcKgMTx+jRak6X3jMS9PT3aS3BUNjRYNBLibt0s31RCAf?=
 =?iso-8859-1?Q?F46PpooKXhAoYSmQ0Hgg44CewACVC6OVTMyCd272TUm+F78CpYztrIdUtW?=
 =?iso-8859-1?Q?WQwkBF8XHGEeXFtDfGBR2L7VN2cmDNe9CkLX5Sn4uPC3pAcwnqSurnR/yM?=
 =?iso-8859-1?Q?IPm+9PJf95lQIhJaQP+MkLXVN0LEVaBJ4zJYxfnzHOG3mSxuGrLH49d3qT?=
 =?iso-8859-1?Q?RNIHzfwGR67ek0nY4idYrRWKRDEV88lqYqipk23m7xm3HokBLZ+EcnAmj1?=
 =?iso-8859-1?Q?yVErVkQ87kKRwp7ritPkHMG1lTJWtSakCg110hoXas2NRXRjmuucHgml+U?=
 =?iso-8859-1?Q?i0KKPKYc8Aj9UinORv0OD8N5xN1vNfkZc0KCOPaooIRytyiQs+Vkk5eBmU?=
 =?iso-8859-1?Q?B88Z5Dtn/4XfKIZ4IVoWyYCJ+s/P+0KSMj71bo43cjEuHj6/6TBQt9UaJ1?=
 =?iso-8859-1?Q?YF/yqFa3zJ77eql10RFj+IzF1OEFEwsxbEzP5bJ8P3B3w3zALOsowcw1cm?=
 =?iso-8859-1?Q?Jqx3kv8od31hEltxnszg27zIENGsAsToFh4tVfRchgXjsvN4jhzGiM3T8H?=
 =?iso-8859-1?Q?wIaTrqsV+W6JxFak5YA5pICGEBR7Jf5E0Fj6DqxKOv9utztr1fZcEKHqRl?=
 =?iso-8859-1?Q?RxdLTAwsGl9iHv+jsNKHYqPNg9wYD5VvuUTFq6mD9ksSxQpCOeRsGuQdig?=
 =?iso-8859-1?Q?Dl8MFU0MMnMu4R9t+HwUb33hnSckeHhGl/4L/YZMXaDViGuL0SZJK7SX82?=
 =?iso-8859-1?Q?ik+GyVydQWRB2gAOeQfdf8AtWiwUabzPKT2487ceyFiUmJDZO1erzDtKHT?=
 =?iso-8859-1?Q?KXSCl0Ml+qy1FBVI18w47/KDM16HvWDckjeiY6Kh2BkdjsSWyRzZnE26t+?=
 =?iso-8859-1?Q?Quynz5tegac4p9ydQZG2TV2/KmBe5JAF3Cem64RxM5OkuTKvE2dVuZbh5O?=
 =?iso-8859-1?Q?S5CTVhJL3JpkQKwc25k7IUtolrezTKf3Kav/knSmMjsJicp7NN9ezq/g9K?=
 =?iso-8859-1?Q?ycTLiJv5JpLRSOB7ATcR3S8EWU37xeO9cEMSkFYGYIQ5mHcxwMYXfn77pi?=
 =?iso-8859-1?Q?HcRilSwXiLlZaTocReiBK15GE9k67OjCMIwJZGUewEsmVi9rXXj/AWxJ13?=
 =?iso-8859-1?Q?85zrc2cOKUD7syvE+rr+uOlAEUMMymBWkvSUQ+V+4ftFjjTYAWO9f9uJI/?=
 =?iso-8859-1?Q?ag4AAVZR1KQR5D8hTpyYM4jYJMLZSZE4kl+H4It9uGZ1ydYnsutEgLI7t9?=
 =?iso-8859-1?Q?USWpr1SUpFjEPGwic181dHJweSWx0kNcNtfZbe78leCwxI6rU7GqPi/QaB?=
 =?iso-8859-1?Q?8KaKOTAUYZG5JdOr308xMKEv8gpNX00MwB3c+aOIwjS7gVgS7h6dfFnLrf?=
 =?iso-8859-1?Q?r6sqnTyjg178tuswjHfpY+8mDzj/HBTgSV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04a272c-6f0c-450a-57a9-08dce257b250
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:29:06.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pn5UjneVNU+ReLoML8qqSiGiwLBKJWbSeugFnKZj+XUikne2nvzaY1vPLQsJ7GYI9nBwTkz8ySQzA4eyaqQxkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9573

On Tue, Oct 01, 2024 at 10:15:09PM +0200, Miquel Raynal wrote:
> Hi Frank,
>
> Frank.Li@nxp.com wrote on Tue, 01 Oct 2024 12:02:53 -0400:
>
> > According to I3C spec ver 1.1, 09-Jun-2021, section 5.1.2.5:
> >
> > The I3C Controller shall hold SCL low while the Bus is in ACK/NACK Phase of
> > I3C/I2C transfer. But maximum stall time is 100us. The IRQs have to be
> > disabled to prevent schedule during the whole I3C transaction, otherwise,
> > the I3C bus timeout may happen if any irq or schedule happen during
> > transaction.
> >
> > Replace mutex with spin_lock_irqsave() to avoid stalling SCL more than
> > 100us.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v3-v4
> > - improve commit message
> > - needn't mutex here, other place already use spin_lock_saveirq to protent
> > i3c transfer.
> > ---
> >  drivers/i3c/master/svc-i3c-master.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > index 5df0ec02d73ce..1ee6ce186195c 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -436,7 +436,16 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
> >  	u32 status, val;
> >  	int ret;
> >
> > -	mutex_lock(&master->lock);
> > +	/*
> > +	 * According to I3C spec ver 1.1, 09-Jun-2021, section 5.1.2.5:
> > +	 *
> > +	 * The I3C Controller shall hold SCL low while the Bus is in ACK/NACK Phase of I3C/I2C
> > +	 * transfer. But maximum stall time is 100us. The IRQs have to be disabled to prevent
> > +	 * schedule during the whole I3C transaction, otherwise, the I3C bus timeout may happen if
> > +	 * any irq or schedule happen during transaction.
> > +	 */
> > +	guard(spinlock_irqsave)(&master->xferqueue.lock);
> > +
> >  	/*
> >  	 * IBIWON may be set before SVC_I3C_MCTRL_REQUEST_AUTO_IBI, causing
> >  	 * readl_relaxed_poll_timeout() to return immediately. Consequently,
> > @@ -456,7 +465,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
> >  	       master->regs + SVC_I3C_MCTRL);
> >
> >  	/* Wait for IBIWON, should take approximately 100us */
> > -	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
> > +	ret = readl_relaxed_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, val,
> >  					 SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
>
> If we now are holding a spinlock and expect this to happen within
> 100us, then I guess the timeout should be reduced?

yes, 100 should be enough for timeout. Normal it should be set at 9th SCL.

Frank

>
> >  	if (ret) {
> >  		dev_err(master->dev, "Timeout when polling for IBIWON\n");
> > @@ -529,7 +538,6 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
> >
> >  reenable_ibis:
> >  	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
> > -	mutex_unlock(&master->lock);
> >  }
> >
> >  static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
> >
>
> Otherwise,
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
>
> Thanks,
> Miquèl
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

