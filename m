Return-Path: <linux-kernel+bounces-529573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94D1A42801
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE1C3A30B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC16C1A3176;
	Mon, 24 Feb 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fpb9Ersd"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013011.outbound.protection.outlook.com [40.107.159.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01481262D25;
	Mon, 24 Feb 2025 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414751; cv=fail; b=iSjdC6gEuv6Fm5GRrI+k+cnB1vmuh2MRTKlKxYy51zDynyWgmB8vvgY3z3VfSaxdtECc2JPttUJ122nwaO9acojpNYBq8t4Ka42ZRhfIHToE1qpkCBRne+q8ERIzkF1gcwXdmKeQtDiwg+xNJYWyYXVJIex7i0wf0GYVF2+TkAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414751; c=relaxed/simple;
	bh=4Vf10lMZRsP82JJUKvG+vKPoMOqdtRLWflhQfZheXMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GTXXQ2Lhx9Zhs/KQbT0vUcM8bxB1vTWEMqisa5iAVIufcgqvqKK3Egl18tfRGpyghil9GhfmCmfSowUFg2qOOyc6nY1g0hadXVIh0l8YZdO+9q8klmnQkfHnNN+0Jc22IYbCmkHnYcPWrLOiCf9C4jCvB1a6tQQt4Ea6BWZriv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fpb9Ersd; arc=fail smtp.client-ip=40.107.159.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f19YKpj41NT7zs8/yu5EW2CnEtFapkpYZjShscITlNqSHJuP+pPTV0PbGHU9CqhlfsyaDdAizlAPS9E50S5ospF2y2IJNHsx9kqRg+r3QCHAE8cqLb7sVei28ukf3biC0XfSAQuvFMLlMMk2utic4aDkCYdcx6OerVNHCWcZaFnTf41dV9WeLDSHzkpPXbHTy+PnqzSnNlFM+s84lrp+8yfDwZaPjGJ3LoLM8z9wfr6WsOoehWeLj4AEIBzmbREfuWYJyd7viTvQvSbpWumjIk3bKHKdo+s75b4jyAZKBrJCGzY5T2O6QZKYX0enz+XOd8zqlv2CTXR9q5xCpOFkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96ZtmsrPvwtbyxhHtP9KoZ8pRkBOymkZogUj8OUztgg=;
 b=QBBeRnKT+S/Jmqrc4UWQ5Sa2cICo+pHeU/l37tyZy2sa9J2Ff/ytxOMyc8kH2JE1M047b6X+VYwczKQwNwMuPYywxPGtMFknx08sm7RoV0Jd7fiWVd8W1NJYC9P1EFH9PeicXtiJq0QE8aF3jMqV6i+NLfeTIeiGCe8DKGhJgpQlnxkAf+fuzycu6R43tb7+LjRbuG8+75ph92/WCfupqP96VhkaAu3m5nRJw5lHFqADivq63OSTTO1ESWjX55/ixPxhUl0XUIk1c9ppkkEo4gZUM6nw/N2TbQAX94UEYO3LZCTzadx0c9mGqNxgJDznxSIhnjIdBcCnUGHmJa5pvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96ZtmsrPvwtbyxhHtP9KoZ8pRkBOymkZogUj8OUztgg=;
 b=Fpb9ErsdHeD1LJXX2wbJdYvZeKPLhudEcbczdz+zHaOeLYs2g2CcaEquH8CjvF17nMC1Ndcq15afnU/DcOucDc8/xzyCnwPfC7vFF4xu0fOpnt31z1FKAsYovMsZ15d//ygJvNO1QBbA7G2qQt67y+ZcGzTGelK9bEowgMlP5FIJ39YCHkVWd2xiMPMdw4P3lc73gq2dxuLx03voyGC7N3mKhD1EzxmozkAq2eaCWvtOU0BQW2/DylcH3YgmT0GAIrEbLTein2wTG1sO7sbcXpUrerqSZbi2Dlbeu6mSAnPgDcGDAwAvyziKA+j0cQ4GhkAAHvjUY1mmGBoLlvzgiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9944.eurprd04.prod.outlook.com (2603:10a6:20b:682::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 16:32:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:32:26 +0000
Date: Mon, 24 Feb 2025 11:32:18 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v4 3/5] i3c: master: svc: Fix npcm845 FIFO empty issue
Message-ID: <Z7yfEunAWuR8jchq@lizhi-Precision-Tower-5810>
References: <20250224083908.1880383-1-yschu@nuvoton.com>
 <20250224083908.1880383-4-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224083908.1880383-4-yschu@nuvoton.com>
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9944:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab4c0ba-2b5d-4589-964e-08dd54f0d291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RhnHGMM4elj/XDDe8WG1rHjyuN2KQktKkJUGQfCvsLgHBiJx73ZJNDd8t/TL?=
 =?us-ascii?Q?2qjXKBzYGLGOR5MzzVUXjDaXjDPSpff1cSqfl0urQ23H35M+bKkHiqo6dcBF?=
 =?us-ascii?Q?BnrID3v8tkDTCsb+pfyr4iEcxf1xy4doCSAHotj02HyOaJ0V39W7klEWeiuz?=
 =?us-ascii?Q?8/1abTz075QcgpTXvbBqXCK5qECtumHeAsyAFtOyU6RSop1NA2es5JzbNqzl?=
 =?us-ascii?Q?q0ASFh8/BilZneVDOBA+tkQkAbmYzMe0xsHdOcZxBnbCzhpvvsf4jINpDGPm?=
 =?us-ascii?Q?UdO64RjbyoyifOeILCUFBm/eMMqyhUiSkTpoBofBQJJFp3jLW/fc5UiWHv33?=
 =?us-ascii?Q?ATXxOVYoH3gZpJ8O6gIFlBcZ7G5+AuNzKqWHHaji57b06tI4Gl4ONVNdMHVn?=
 =?us-ascii?Q?oxuk+KYGYtTtxk6lt6yb+eq8FsxamUNCWlk+A2pPf0RSSMIriMOYSdRBSTiN?=
 =?us-ascii?Q?ih2nAkFUSZNRhTYiQAwFdMUn3f2D9jQga6Nni6Coo6lcOJ0SP3Z4UUQy8xh5?=
 =?us-ascii?Q?VQQDOAA2EefsfzdKuavnE1WamPfw6nYapHvUuPwtrk6dBR5LKqUPr4/AGv/5?=
 =?us-ascii?Q?3Vgw/zqKF3UcPg499C006CfXP3mZWXGAR3d+rMoTyAe0MU+umijF72zKbdQS?=
 =?us-ascii?Q?0bMKhOL+IGVYNRBUkjPmrF2wk8JQXcJywTsLwEDLlcqCMU0lhzAhk4h9/De2?=
 =?us-ascii?Q?pO6AcecmlWR91TKCdQFHFg9eS/wd77XyJcPQX6Lzo8/Xx+x8fbd1KXbB6wP0?=
 =?us-ascii?Q?tOCdtfJf11o+ntxydQmQ70s+Z1Dhsanecel23CVMQbty0xY56tjj0NuVONY9?=
 =?us-ascii?Q?4oY8Dsz7g9ZgP4POamN9BbdEPmXiaBsaE2Azigmr17ZmHq1uqeT2OMFpYHGa?=
 =?us-ascii?Q?RU9bRyYCFRsPMYTc2YmfED+pmn7y60PiVdpMwxCapmXVt1yWUI1TcG8lXOL1?=
 =?us-ascii?Q?6Y06N6I5UlRe7n/TK+7830ZQKZaMmi6J/Nlf1ildIesl+kqXwA0/g+DyF3+D?=
 =?us-ascii?Q?jkD50VIOgHBSfjJHBrCpfqgouvDCqu7rND3bHYii4j0CCgvO9hki12QeMMwc?=
 =?us-ascii?Q?UdaP21D3n+GxCb2yUakpmaCdPEU3ADu3k74PHgBVlI6hJ1LyDQ6EkI2G/u79?=
 =?us-ascii?Q?yCJuQW7rKlCWFWVNL0/yQ3XEXtL5VbBYK+YjRuqK1MiHzQf//MqLwcK6Vl4M?=
 =?us-ascii?Q?4qS9NdmQHX+oeraHPf6H0iXNOQcNMRG8kX6v6tDdK/fA4idaISINmy+mS9QS?=
 =?us-ascii?Q?/Og/C3+Y4zv1G1frl8n3IfnUPqQ1r9lxmuoLOjzJyJcbfNUd6wma6zAzrLgW?=
 =?us-ascii?Q?TDX4124Jf5is15/jCvr9dzVzFH5xgukZgc2KBCLCXTkpUjIbn7Fag33LRQU8?=
 =?us-ascii?Q?dfQA2qerVI1BRF++wXc5rg9gl9f8msa1uuhLRm1+fIzh6clSLUB0XfnVwdKC?=
 =?us-ascii?Q?Iw1vvf+T3Sg5OmAk52Ynoli99G2QTXo7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vYsPL4psl4qlVZUnIKHd5OO6uxgWcH4F9lVAckV14j/TdmGbsqsnjUlOTIDV?=
 =?us-ascii?Q?7HIOKg8Vfp2vlyb1FHwPYYwZ831Y5MN0Kykf1w+8mtCHCCOjtIWFbwl7THIt?=
 =?us-ascii?Q?vWMHj63Om0ha/Sjh1C2vK11cLJ83f8r1QwyRKXyEL6XoJ9UymO0wIJWT5Yrd?=
 =?us-ascii?Q?aVl+WBIFZmTHV8FzWQvd976w4M9cZwyU5qS49qVhnPrdc1h30eNKOpHEakdd?=
 =?us-ascii?Q?rXPhW9tB93MfrCNjDvnB4jMdjhLmWkYiPnZvtdCysy3wHLYB8n0X8sQ6RRu4?=
 =?us-ascii?Q?RJIL/kdsncf+Cvg0pjZAP+tncejIhLMKkcOoD+FDe2GG4UIbUCY8x7nC3H/a?=
 =?us-ascii?Q?kRM2/SRgtQXSq5Iae38Hgpig/YxUJdLD8qZANeVO5LyISDI3oCDbXgFtE989?=
 =?us-ascii?Q?GYTsDly7QBX8o1QqGbcwPpse2dH1wyM8Z4DdS00ORGvUFk9gvkZqs+s05VO5?=
 =?us-ascii?Q?m3fCtltP6wO/XsvPb9+/APZz7tEuYX+PisVKbIc2tCYQUWUP/NWp00X2OYUR?=
 =?us-ascii?Q?JCmOKwRCTUUm2gppPkICI8JJp+Kcz2NNDelHCiqAKZK3n9WY9YomWpGa1NKJ?=
 =?us-ascii?Q?GqYHAbghtoK+nWuPP5NRBFnAoZSDOwvD1AAFrvr47Y3fKhxUv1hO8HLrIz5q?=
 =?us-ascii?Q?utD0CM2HUmnBA7H6jEGxy2W+frttf27vQhuzI3uKVcvRUrU1O9j5yaFnIpGm?=
 =?us-ascii?Q?FMyDUyefcb7Wj5RkKnpp0vvA9qn70+8RRF0iN6PFfkc8P/65aoKdVeezl19L?=
 =?us-ascii?Q?QVQvPj+dn6qmsGvdsItqOJt7VYw+XBgz0L8/g1CaOtQ4m+tWuCdiECZwkqGd?=
 =?us-ascii?Q?dC9983oIQn5sYrWs1DEHbqRXAgIknNZa0pyTizi9XS8qk40pmwPhsB5KH+R8?=
 =?us-ascii?Q?QTqCrm8JHAwBctUXC5Oz8+12LHDgm+Km3ySpr2tVyvkkIMQ4iZAAK6/36YUd?=
 =?us-ascii?Q?mlR3gnwto7OXVjjrX9H44e3WIJ7Y9n4FxmcfLkZy+hl//QhFFi70MyEO94Bv?=
 =?us-ascii?Q?hoENA0mqc9DrRZ8mVTysLqsfgX2KZU7KJaGCOKm3T1B0/61XUVtVGMlxu+w4?=
 =?us-ascii?Q?MwibX7bFhjLxDyS5y2cXlVhsomcYTkjAWRCWYmckKw2FWbokMI++jymKviuT?=
 =?us-ascii?Q?tcpdNKmgkxJCnZolDLaUNZkSfljHLuiNWwJcwytBIm4MeBqp9ZcCUuey8fg2?=
 =?us-ascii?Q?b/ET0UD7Ni9tP7vXHIm1Xz55NZeLv+doaRyG1QnfcRzB+7+N+H8FsR0K2ZKr?=
 =?us-ascii?Q?QSZPFSlUKIiRf2F6PF+mJzgH6hxDhO/52CrtMIrIEQhI2COKpwxCckWqUENB?=
 =?us-ascii?Q?Im+gUisnGDzHLYexocFrSd1e1gik937P6IdhkwkIG+99dGDgf6L3heuJdtVo?=
 =?us-ascii?Q?73zqt6W9Bfnic25l+V0CfjnBuO2hBhwpZFpjf17uHrEMAf7K4ol6Wy2vf/ES?=
 =?us-ascii?Q?RWqRySeDvueLd7PXL3gPSc9QZW6pZ8JIc+R7IM4KBngqSzJQsgPFkkGj5hCn?=
 =?us-ascii?Q?XCc8rwnPKeSXkbifAInqmZnGR7idH0BQR+eXgA/kL/0iWPGGB6zSiS6/OaIT?=
 =?us-ascii?Q?E+V/3yNSRTf7Dcaw79DBPHbRr5OfiJI3T6FKYy4F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab4c0ba-2b5d-4589-964e-08dd54f0d291
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:32:26.0053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZPTPpNOnj0nfVCT2Cx36wcTRFSUJpkh7edm4z5m2xHxHzklDpDlrVfXYL146GE5mXmD3zrsdT5qwH5krLtXIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9944

On Mon, Feb 24, 2025 at 04:39:06PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> I3C HW stalls the write transfer if the transmit FIFO becomes empty,
> when new data is written to FIFO, I3C HW resumes the transfer but the
> first transmitted data bit may have the wrong value.
> Fill the FIFO in advance to prevent FIFO from becoming empty.
>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 44 ++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 8834f87a4767..07506ae0f914 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -942,7 +942,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  					u8 *addrs, unsigned int *count)
>  {
>  	u64 prov_id[SVC_I3C_MAX_DEVS] = {}, nacking_prov_id = 0;
> -	unsigned int dev_nb = 0, last_addr = 0;
> +	unsigned int dev_nb = 0, last_addr = 0, dyn_addr;
>  	u32 reg;
>  	int ret, i;
>
> @@ -985,6 +985,17 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  		if (SVC_I3C_MSTATUS_RXPEND(reg)) {
>  			u8 data[6];
>
> +			/*
> +			 * One slave sends its ID to request for address assignment,
> +			 * pre-filling the dynamic address can reduce SCL clock stalls
> +			 * and also fix the SVC_I3C_QUIRK_FIFO_EMPTY quirk.
> +			 */
> +			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
> +			if (dyn_addr < 0)
> +				return -ENOSPC;
> +
> +			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
> +

Although there is 64 clock time after issue do_daa, it is still better if
prefill dyn_addr before sent do daa command?

If add a debug message before i3c_master_get_free_addr(), does it trigger
hardware issue?

Frank

>  			/*
>  			 * We only care about the 48-bit provisioned ID yet to
>  			 * be sure a device does not nack an address twice.
> @@ -1063,21 +1074,16 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  		if (ret)
>  			break;
>
> -		/* Give the slave device a suitable dynamic address */
> -		ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
> -		if (ret < 0)
> -			break;
> -
> -		addrs[dev_nb] = ret;
> +		addrs[dev_nb] = dyn_addr;
>  		dev_dbg(master->dev, "DAA: device %d assigned to 0x%02x\n",
>  			dev_nb, addrs[dev_nb]);
> -
> -		writel(addrs[dev_nb], master->regs + SVC_I3C_MWDATAB);
>  		last_addr = addrs[dev_nb++];
>  	}
>
>  	/* Need manual issue STOP except for Complete condition */
>  	svc_i3c_master_emit_stop(master);
> +	svc_i3c_master_flush_fifo(master);
> +
>  	return ret;
>  }
>
> @@ -1225,8 +1231,8 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
>  	return offset;
>  }
>
> -static int svc_i3c_master_write(struct svc_i3c_master *master,
> -				const u8 *out, unsigned int len)
> +static int svc_i3c_master_write(struct svc_i3c_master *master, const u8 *out,
> +				unsigned int len, bool last)
>  {
>  	int offset = 0, ret;
>  	u32 mdctrl;
> @@ -1243,7 +1249,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
>  		 * The last byte to be sent over the bus must either have the
>  		 * "end" bit set or be written in MWDATABE.
>  		 */
> -		if (likely(offset < (len - 1)))
> +		if (likely(offset < (len - 1)) || !last)
>  			writel(out[offset++], master->regs + SVC_I3C_MWDATAB);
>  		else
>  			writel(out[offset++], master->regs + SVC_I3C_MWDATABE);
> @@ -1274,6 +1280,17 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  		       SVC_I3C_MCTRL_RDTERM(*actual_len),
>  		       master->regs + SVC_I3C_MCTRL);
>
> +		if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
> +			u32 len = min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);
> +
> +			ret = svc_i3c_master_write(master, out, len,
> +						   xfer_len <= SVC_I3C_FIFO_SIZE);
> +			if (ret < 0)
> +				goto emit_stop;
> +			xfer_len -= len;
> +			out += len;
> +		}
> +

The same here, you prefill data after issue sent out address, timing still
tight, only 9 SCL clock time. should it prefill before issue address?

Frank

>  		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
>  				 SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
>  		if (ret)
> @@ -1335,7 +1352,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  	if (rnw)
>  		ret = svc_i3c_master_read(master, in, xfer_len);
>  	else
> -		ret = svc_i3c_master_write(master, out, xfer_len);
> +		ret = svc_i3c_master_write(master, out, xfer_len, true);
>  	if (ret < 0)
>  		goto emit_stop;
>
> @@ -1362,6 +1379,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  emit_stop:
>  	svc_i3c_master_emit_stop(master);
>  	svc_i3c_master_clear_merrwarn(master);
> +	svc_i3c_master_flush_fifo(master);
>
>  	return ret;
>  }
> --
> 2.34.1
>

