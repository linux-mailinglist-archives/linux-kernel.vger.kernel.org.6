Return-Path: <linux-kernel+bounces-280805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5369294CF73
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDFE282B3C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA1E192B9E;
	Fri,  9 Aug 2024 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tfgbj+1v"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B315A848
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723203703; cv=fail; b=Z0q+lNFMbW0juBp9f8eTarRTm4KxwBurumcYzdbDRaA/BO4ypxa9ZsXIYj7ACWyQmFEM1leVwicQhGVzN4I7lq/euEcAZNr77xLYK2N03WL989Z9U1mpiVHAxAAufvj+MKtLAsk9IFXD+fB9LbfOpdL+4ubytf940NwAgY5xjXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723203703; c=relaxed/simple;
	bh=gyDoxqnFzGHf4BPZXUJDtRIlS1aaWZhuLu+7thpd1SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q0NrHhLsGP+jQ+1xDTYTwzZ2eadPWSq3MaPLcLHB6yMwNCnRskyhsuM+GlC8CM+WN8gZGL6PRiT4pFE2ZPtSUcDF3B+yZz8ZiHbHQ3cKm02X9ttd9ki0GKXv4CrFQ4fszK9Eeo96q83Sv4EZVKL6F1/GgHO/M/XzigjJ4Q8Gnx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tfgbj+1v; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOAtDlC2gdpaOCVrUmjCiUmlyr+DOtRePbq+tw8xhU7jNcOz/QAa1YpFiNTRKYxmaKnW63byho5VFjymBqeaLSIw9vbW4ic0Adg8w7B1o0Okiw4/cNaF8Tmv7ts8YR+3jzuUxpmUx+ih2X9pUR75pIF0WQSubVy6WOydTwp8D2UDDBH90tkJrxl2BjGXzJSrgTSZQOfDxzTE7alnKNQlgb2fHBsNYri8WLeaHu1dGokCdYTsNu1PYriUqJmWEPNC5sllCWBbMTJvNHjp+iN2hYUFD8/tNh9jnvS6jxgPz30J/RR2r7I8bmV8fCGO6GYIiDgNgTScTXGlHTPkYuDslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xcv92glPPhAISlKL4iZxciKVTNetK8x4bgNG4UUvbN8=;
 b=Yp27hXic0ykNKCRq/cSlPSytwZuVPLMA62R9ANuO5Gn5CxH9tHJ94cGbepOlkQ47erIarx6WjKqxc861Eq6wCjDSwdgNv16mpDeOs6jD/LdQ0c/VNm3GJIC6rCNE7atj9yj3nOsCKiz0ZuAhMUmdktuSopQtyIBRD+1Hg9/Q6V/h+wt7AoFWu/hZq7QM4+T1B2LDgW9PswaRX/EWJsmSz24+M9JRgSnRGgI4akYYn0opCFiibuCub8rGDtXiV/7no11UBZXzjuu8mPI4lZlzdWY8wmaDhZ0l0KxnZd4tRuA3XoGDCIH8S/ZF5wcSQU23ZFrdZwRp1SsNSs9C0a5UXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xcv92glPPhAISlKL4iZxciKVTNetK8x4bgNG4UUvbN8=;
 b=Tfgbj+1v2H0TZ6vP3eq36gsqWLY7zbkP0pYdb6JPQkvfhAZLM/3vhTXJolCh7SNg9b9/fyfBIOMVfRskVosHOpxmtTt/ntGQRdWvXOjxO7kVq/2b4wQJ5Ymrru15cSnAS8qvQvAROF3yN9hoIx+AG1Yep8Yh6H+HVdwccBX8QgEhQEM9ynYHFwr75U5I5VejJsmw0K/H3s/lMB9SaveglhGvBdkcG6WrvbfQjstDZXgFo4bFQGLV8XgeJh8Py5gLszsH7iLAchvBsyqoCjLDK+4nPn847HPoJx4bOABibh9ekCz0F0sKJho6uPUh79SSN/X5B66DUO4B152iTz8tXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by VI1PR04MB9931.eurprd04.prod.outlook.com (2603:10a6:800:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Fri, 9 Aug
 2024 11:41:36 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%4]) with mapi id 15.20.7849.013; Fri, 9 Aug 2024
 11:41:36 +0000
Date: Fri, 9 Aug 2024 14:41:33 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Wan Junjie <junjie.wan@inceptio.ai>
Cc: Stuart Yoder <stuyoder@gmail.com>, 
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: fix GET/SET_TAILDROP command ids
Message-ID: <maorj3mhnsgmljcma5ands44d2iomjdbhxwcrxbmuetp4rcv5o@g6dr5aryjauo>
References: <20240808063658.2364343-1-junjie.wan@inceptio.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808063658.2364343-1-junjie.wan@inceptio.ai>
X-ClientProxiedBy: FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::18) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|VI1PR04MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 556f0169-4af3-4f1c-9a7d-08dcb8683987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZpecvQLjJKTPudTtinMw7XpWXTK0oQG1lD60tJ8UthIEn6FFTTGe8vTd+JBb?=
 =?us-ascii?Q?pTTBShMU6QKjcCiGzuTuJPewj/GCrm2zE3e4IGIrC6dEWBQCENtz6yGxtgRX?=
 =?us-ascii?Q?5FgUhNuXf9qwGpBEI/j53CDU5uJPZRxcah1jH9lnb1WQa9/AikNB5Ms1ub+n?=
 =?us-ascii?Q?1HXwSDtndaXzIPxDRPEvw0ZprP0AN+qFBEuaHW8CUxeelvsFVj0wXPuTBp9p?=
 =?us-ascii?Q?5n8Xp9ddHpTt3ZOMO0D7m8muiHG3PoAD0g0/zYIGcHn6MmxPRdjbJFwvEvDi?=
 =?us-ascii?Q?vAqn2MdNe/mBZKvfiWYfxGwWiyr08nnQhzxB2jQC/9fcF2uwlgxuCkj+JC9k?=
 =?us-ascii?Q?zlV5vp2CiMpJmYh4cj/FnwDXM6OdtN4tz/aiEevMe7F2up75rK078ZoG2EZa?=
 =?us-ascii?Q?3OniLNLGF623YNlPDtd4j0ETsxmDmuojuM5YCjXDWzSM7rLbpuC4/DetiPLU?=
 =?us-ascii?Q?DZ8M7LUGj/wzEYAhrU/6Sj5tE/ciS9Z4g/LIr1M6nMysijugq0T4DgFDMhk6?=
 =?us-ascii?Q?rBmVeIPMLeau2X1Razf0bCHtrv18FoFtse8eZ/0GkeJqqUSaKGpwXbnAPQgo?=
 =?us-ascii?Q?dGxWXcILb1z5JXyoOkv6FEd2SI0KJpCb5Zt1uJRKnuWe+hDahscp7Ah+tNlB?=
 =?us-ascii?Q?laPNm3/fC+3ArqJy7UVWLrttLPbyO3ycjdhnWpeFjRwOavBbBnWzPxP6DFw6?=
 =?us-ascii?Q?+OhJV/4aKeMHmJuDKMy0puCV4GdSXJdqpptpOY9f1Tt6U0Zft9NZx3Pi9xAA?=
 =?us-ascii?Q?74p4w+DJJB8vwcw91cDI9+ttmRBaSroMgk5xeCM6LFUCJ4myfAftgzLbEQXa?=
 =?us-ascii?Q?9T57RRpxKjuBvVGZ87uv8CFCXUzgdyPvacglWNrZLWZU3+HyArjGoEiqvL2P?=
 =?us-ascii?Q?pFRX1tbaHMWyXq3+3wWSVdP+fZJsKaD2feqUZ6anUA8GFnA3+Gyq0Xj1b6DK?=
 =?us-ascii?Q?RYjNky2Pwdzm8pYSg/LMk5+ebrTZVxs0fCpvYf3p7C9+JnmXBwhsEtg1xvbB?=
 =?us-ascii?Q?q5ejl9u/rMBtjqz9HuGKUifYIxqmjb/JgFwMYejQ7i1O4uQYNNxVey87JLDh?=
 =?us-ascii?Q?zqUFhTwO4pwBgGADQYAHVHWAxeR30z1y6gsytfMQ6xCuexxuVSxOvr38w4G6?=
 =?us-ascii?Q?ah/1j3Lz9oNE3Om9FNEeZ933/TVr6s+ot2Iegs2XOxhwiwHFsX650998RBuG?=
 =?us-ascii?Q?IMbTiDbmoemc61Qr7M22vwszxpi4X77DRkeza58x71/Ay+3eX8oRpCj1x1mQ?=
 =?us-ascii?Q?Qz6xhxyX/UMQFsrGbyoygq+4gh0TLSKryR0DMp3WcDdHprqhKw3otDRUfG3e?=
 =?us-ascii?Q?qzVoijAXMWoEbooYMRAokitLHQvA468WIpz40TIvUjjBYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LiF1mAo03ifM6kiguf4dKjMA0/pJo/QeGsiCALgmOKXvUrMfwv2j/wKAENOE?=
 =?us-ascii?Q?KgDIqm0R63vQrJixXHgMsqEeNNhnEHYwnLS7N61r/Erymg1cAhZtmXDPSW0o?=
 =?us-ascii?Q?MiP47d2asUpu0zq1T8KgfmiIWP1ruZcQyzQghcfVsWRBetucfMyF/IJUJKV2?=
 =?us-ascii?Q?wmQREjS645Ec5ZxMnhADLWnYqpp1l3DlQs4v7/KVH9BLcWRJimOAzERqso/9?=
 =?us-ascii?Q?vAiAO01IugfHKuLPLF+tyyg8A/iXv7/4uZJ9eLCvhU1skHiJqZZboeCElook?=
 =?us-ascii?Q?8QvCKZEGsZEFmH84Pqd/sBuy420yepPCFZFeGFTri/NXwhg1DEYQEBrfGXA6?=
 =?us-ascii?Q?h70VXmG0BJJ51UOYDVKTEUpwu1opnw5KRtmdGvIihFwsfSDzikHVWKpP5q4Q?=
 =?us-ascii?Q?7U4N/Iy9IWiYlktD4pNqQQvYCyjxathFTudkfuCko5WAGGLQnT7re9Yo+TN2?=
 =?us-ascii?Q?qcQgs4w8/uX3JNsmmQc5OZTrJLAK6JGI59AYt22AuNRFz8zUH6Au4A1CVsN5?=
 =?us-ascii?Q?RWzsYlyf5+XRI/Wo25/r78A/QEzzg7HX1g20Vf3oncZf9kHYKWwYbCJjwTJp?=
 =?us-ascii?Q?oTEhzfOGlt00fJUfxO1joimBdmdNQD/OSA5lw1Yiq/LpevcX+21hCHsBWYXr?=
 =?us-ascii?Q?XGA2fQZkZD9CW5zGk182NIFDDUOE1MFKWRTQosyfI/6KhudKrXYOLEeN2nkd?=
 =?us-ascii?Q?WQKkS+nB30rWGM1a7xS4nhpR0C2R4TAV08wYSUEW0ztTcJWx9azwp50HToFO?=
 =?us-ascii?Q?GHujBQ/XeX1qoKT34BC+d8RnRvdkVKvV3vkHkKMjqgkAaDy2KWk8JK79I6R8?=
 =?us-ascii?Q?CDxegDzHGnlT9eN9DKfK2xbw7wTYjx6RDUal+iEgnvBdAevlROJ/kTHkw03+?=
 =?us-ascii?Q?RBwvWKykbje1dxNCIE5AbxV1rPu0QPT+MvpoSeLMD6VA111eWuai+Liwobof?=
 =?us-ascii?Q?WjAxHx81nbmibzR3jYC7KUrdD7XLeU0VvSKFUGk/Z4LaKYo1/0CqWnG3H0jH?=
 =?us-ascii?Q?kC3LmBRaI1bSF1rOLIjwYMCRDeMI5TV348wgcSDOo6VrzzOJ9/H9mCSxKHX+?=
 =?us-ascii?Q?7PKjZceY+0XGQgzwPQbUjcivIH5tzBHDAro7FjOvHnuLQmhTw6AFUTOEWrao?=
 =?us-ascii?Q?CD/G7dKBjOvSFulrYPr3zB0oRuMmaDdDjec1KHRilbE2WzY9l/lTXkbQlpAb?=
 =?us-ascii?Q?/1HfZL8bePOTtkFAY0ZS3qaqC668VmbHaIFN8xoJ7g+NgRi4dzE5l7vglLeK?=
 =?us-ascii?Q?n87T00UNOTghW06qQLPLS4BGRN6AwFSRzfauYZuIEWkMMWSn/8UKKz+45wwA?=
 =?us-ascii?Q?0Tv8MZX8pmVs048sb6oC9tVPC2loV4EbFK4OSS/jJTpMLxrowsYeKxxXOJ7U?=
 =?us-ascii?Q?JUbKgG2pLwgZX5jo4IMpe1h2uwWcM7mv3OyZlfsqq4F7AS3G1D+0w29rrH+/?=
 =?us-ascii?Q?q48e8MpD3jCX6KyWS/cGiFS2Un0pzwUXEelB0oC2NzP2bmKqwCp30/0aeaJx?=
 =?us-ascii?Q?ELof7Y5l1x9MF6vgm5s3PHX14BcWRZemzsnXwm+1lonWl59j8kzJ8NagtvUH?=
 =?us-ascii?Q?tt/VIMpOTzMmlB5uhKunAawie/1VesmlZzNWHGK9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556f0169-4af3-4f1c-9a7d-08dcb8683987
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 11:41:36.2592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUyjUCOGX1MAkb7pu546sz3WtRLUrcss2mSHECbMVKgp6RBuNYCgZNf5l0I6S/KAhm/SvBBNZIt+OobuZjYjdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9931

On Thu, Aug 08, 2024 at 02:36:58PM +0800, Wan Junjie wrote:
> Fixes: d67cc29e6d1f ("bus: fsl-mc: list more commands as accepted through the ioctl")
> 
> Command ids for taildrop get/set can not pass the check when
> running a restool. Correct them according to the user manual.
> 
> Signed-off-by: Wan Junjie <junjie.wan@inceptio.ai>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Thanks!

