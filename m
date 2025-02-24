Return-Path: <linux-kernel+bounces-529546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF14A427C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659433AB243
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C2026139F;
	Mon, 24 Feb 2025 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fdqe5tOd"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699D225A64D;
	Mon, 24 Feb 2025 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413912; cv=fail; b=OK3Bwrt34sXmJ1i9yO7p+6vFNm1UpZJfc0s4OoC6S2G5k1UX4CGt6p/Rqrh5ofco3HY9q7panfkD5IPoLKTu5meY2cTefIw8CTJXxqKiiCrmUXUrY4D5VYxDez5x0dXj6lpEq9XYgX7RNIwuOj6l6oU949ZOU+vYglarq/R8hDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413912; c=relaxed/simple;
	bh=0BtnLZI+9/2jDNrnlNIIGZwFbLasjka8FPG1Xl2zUGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kds13CZD2C0HUtf7Ci2WQIu8VI5eEeVoDKYuQvKG2rupttHZjrdTvaFGZTN4UFGwGaL3hojdA+vS/mLkGqTqtbkG3HCUP0aioCjFB4OtIcyn/3jPACXJ1Mas0hhSjd2NHwB9PIvU4LOrIQmEpiHQWpB6eJtALWx4oNyWyTk77xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fdqe5tOd; arc=fail smtp.client-ip=40.107.20.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZA/uvYi9LWtYCB1TRWgBhrN1wLC7dWahs/+fkXCX0n6bmCYbVomxwVyBgJQOzicb/68RbqMrIbv4r0RjzfVR97s3L1m+4/ds99kat0buV7islDOns5fyW8AZT/yI5bgLBVny2WdvOZVijdwFihBIUTxzQ7COrQ8kfD9A6i5BXmdX6EzWrgSoFSKe2rZKCBSvP6y+4DsG5Ha2VVfZCmQayt7icNmd2Ng/xICtq8FdWxEQxmGBB/cMIEyFuZesiz4K7MKvZlsnloeW6ugdnjFhzqKZUX+uHd5JejwvTumD11o7Ao7w3pOGYYifqd0d8NmAenWu8O4V7jEl0ohF8SFySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnQXct7G6NUNOpGqiafZ5fmEyQBcYPr/ZaKMVWzEnvA=;
 b=FEgAPeWbw/xQIvCHC9I3hvPTBSrD+SZYn5PhpcVa0SBDnmyZ6IwNwWAXu0Z4FAY2Yipy41w0AbSg+ph6nAlM6APXtay00g6lxIsVkJ+EstrrfoZ94iwQaDpBXZxzYiK1ZMiTbsBvWbCCbWfVYef9115ABQKnkvpxsUip5cY9QGUEpHUZ4wzmEpa6jUcxPb6o9BwOoJAq/QGRnaQRdxojWqlfTMUbbOX4xk1Fqzp5Mp+1SbFIHBN1jG86pTrVtxKTinzpuKX8wxeTHqaX2JtwA2+tyEbC0ehG2YXaePuE3TpWSOXnmVYEQxDSZMrNxfSPHknDJpEs5PbNVLVApbbDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnQXct7G6NUNOpGqiafZ5fmEyQBcYPr/ZaKMVWzEnvA=;
 b=Fdqe5tOd7SCab8H5N7atbJHkjinOPZKeNf0+YoXNte9Lfv1HUJ6v8yK3q6DD3+241pvJa11HIEYGFNiEmudpTPj+Gg1QqtQDCxS92EEnGGwssSd/CIctz0gesX/AzBW8AuBXi8oDWRGgAxHq/4LKLhSR3hnHuo71CGyk5DuFQ9b7CrQatVN9xIJ3KRIkMyk9J/WbeHYarJjy/apqxfZz8AqY7oqRnwK8wSOO2q3tAOTSo2LnFbg1ByQCdBWy1RWjGe4/MRnzw0S++ueNXKw1Zzj5sBGvJKEEaBzk+/9V8l8+I9n+TbSgmnpD+RrSXuU0ZgbghLVRnJR4Irx7ZTWIbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10788.eurprd04.prod.outlook.com (2603:10a6:800:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 16:18:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:18:27 +0000
Date: Mon, 24 Feb 2025 11:18:19 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: i3c: silvaco: Add npcm845 compatible
 string
Message-ID: <Z7yby6cc/yuaJFmM@lizhi-Precision-Tower-5810>
References: <20250224083908.1880383-1-yschu@nuvoton.com>
 <20250224083908.1880383-2-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224083908.1880383-2-yschu@nuvoton.com>
X-ClientProxiedBy: SJ0PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10788:EE_
X-MS-Office365-Filtering-Correlation-Id: 988ed4da-2920-4918-a933-08dd54eedec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NAa2XsDq5IU5/ITCgzxwzsByzKcQ8bixFUIeaMYcPXqiPwrMKU6dkSnpJRp+?=
 =?us-ascii?Q?GxjzVQFtyweIk0yGLxRSXeJK1zEGyiPQt4IKaRW2gsAOwFUt90zsp1a1SfVB?=
 =?us-ascii?Q?PrHflSmQtVM9pkbQQPJ5PntK2xVLGTrrv+0TrFO8MHHZd0kIpQJGRSE+/3xj?=
 =?us-ascii?Q?S7RhE4alRB0+qkU5qHx3yWqJevcdAsKCwXOI0Il67xEdsZECc9sqcF3R8R2M?=
 =?us-ascii?Q?0Cj98UeEb+trhLpHvxVAkm1BkUAqjgTHxdLRMRPLTYo7IYGY2D2n4w9CYlFv?=
 =?us-ascii?Q?14Gs7eayNIuxF1Abo3t3KN6DQ5+AVd9iszqTyTdk1f+SQqvTKstI4z34Zpxe?=
 =?us-ascii?Q?64o8VLF4D4yOxy2JZk0usC4cOHR5juTJmUB9XD/Y6NAmWQ/4iC4YdGNbpjjf?=
 =?us-ascii?Q?Jfc4qGbJ9yNwJf/WhR12SqlF4+crLfjCFVwsJ5bhXXcUBwcdmgyGk6tGXT5Y?=
 =?us-ascii?Q?+BE8HPq83FSxggYn4/5Tn6ON0SJGHcg+DpUgJ8Mz00ueVlERujIlMSny4bjY?=
 =?us-ascii?Q?yyM9+LPhIhd81Lm1hp0aw+ZIx971DOWn9JZZrx8ojedCzHjHNCAMRM4R0yrF?=
 =?us-ascii?Q?GWtOu3fRe+Ld2JzaQ0Faz8ll2qXiJw3NwsmpcHUuW712YOChrN1tEBhGfKKa?=
 =?us-ascii?Q?zr0J9RD+Flw1q55PnDuU4QmxNdfnENN2XUtNJ/mC/ohmqnLMAijjgWLY5peK?=
 =?us-ascii?Q?uATLenXba3eIhlkd/Gn+FMTwjGVNUbToV0idpNtRiqCuBFAmaqE6QMW+G47O?=
 =?us-ascii?Q?D07xk95GUVwHfu7EDO6DSRm/tzoF5US2AmqXeF4Jlg9UPqoURukKzqskibBH?=
 =?us-ascii?Q?PaysFYfusCNyfwA7wI2lWGSJGCgk6exrnkYLzwWKX56IaaQbAdFArslRptVr?=
 =?us-ascii?Q?WB1SnGPFmLmo4KvFCSh+ca4ELAaR1xHLzAjU+0OJjAcfV2ZLps9tmjmj0aev?=
 =?us-ascii?Q?uDJVdOLpIiai53mcrkuo7y0Ns5FYJ5rpGcV30nWoEd1JqXqf5F8QUTa3CfeH?=
 =?us-ascii?Q?mr8+dMYieZt8wg0xYEXf4UlNHlGMNQSITqbzisTkiDNDHT5Bz1uG5Cm40oZJ?=
 =?us-ascii?Q?HiJlkB9mx/1EsIfJvDGuGF1xwTUF1JmfSxc+WfsvorGThUYV/lz3uxkEzCHt?=
 =?us-ascii?Q?i4ZKcdobZki/A+z5wDq4edkT8CVo/jvM4MF+tHNafrQrt/vy2ruLesudBlb+?=
 =?us-ascii?Q?x8fxt/QayP53V2pKe7Hc3Q2g4JhSXZuBGGf5u9zE+Vg/6heo6YuYjRnvHMOq?=
 =?us-ascii?Q?HUvsjobENIuYNsjUtEqLZxqra8TwkVaIgKZWaS8xPx0dtVl6JKPK5EMbd6mP?=
 =?us-ascii?Q?jot9XMQnwD+g+9ukxmfk1cBeBNHSi6AshKRlifM0R1b93Gmh0gaS6O2oFxkg?=
 =?us-ascii?Q?0QPv1goWKkeECPWqD1mVKcG96FILh3prIEAdkLVkGoZce2Ze5/ENOU5qYbFT?=
 =?us-ascii?Q?LZDrkuLDrHWjVJAVcBpNidw8jjdJ5Pjz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3CMtyS4/PtVXuQ+1r+/3ZQDEMg5B7dJoh8hJkERV3U/42VJsFrAvIkFZtepU?=
 =?us-ascii?Q?29D6xiBa8aQcCNmtbvqD3REQp/eoWb/M4WEbwWBQhoL8DljADI2/1XCDKx+9?=
 =?us-ascii?Q?E96I8yLjq9vbDWAJkJVOoCf5LZMn5yPo0LRU4X3ZRcHzqB2XCWgY3UEu4Ece?=
 =?us-ascii?Q?riwm0UhhoGRtMazWN5tbMDW+k+MvIgjNIoVDe+vPN9dcmpD1n61zPqq7L3wL?=
 =?us-ascii?Q?nxeOEyB/4ffT/R5H+U/5kfnKU0jYVOwnPGFJQPqU+G+3mV7x3rgbMudmllkr?=
 =?us-ascii?Q?cE4xO7+SueJl1hxsbG5lhRSXfTB4Ao6Hun6AsclPwiSnJc2Eo1zgQYZ2ps9/?=
 =?us-ascii?Q?jsnhw8T9Qtd8c+o7OO97Udrz6DNYyDkHxW+C4moACk9bhurz+uAkbOFtL5oA?=
 =?us-ascii?Q?KI2NtT6/9zqJ+wfNjc5ECWfzQrXfBhOvLU8c4QlhvAFdmMlg/ENdCDSBzWrv?=
 =?us-ascii?Q?otrqBn0b3O1iTKzBFwY9KQys5W7axVnLYgd82Tc433VoXpgfPQ6KA6DmQtY7?=
 =?us-ascii?Q?fUbxUQ2QhuDfqxxeCsA5eNh2YOLEw15tQRxKxLa5OolStxRzpBJIXZ1Xp0H6?=
 =?us-ascii?Q?f+rEXA/G+KK2+MQB1fMDUTen401038bkXV0IpnhMiblo6IvWqjmz5OifRVWD?=
 =?us-ascii?Q?ADx3ae1m89Hi4l8Z5W4I5+x5BMqO9LALdkCDlpoIsXKmrZE/NJGHz+W9t2+8?=
 =?us-ascii?Q?Z5beLv2bvyByxvMXioFcxDpSVi4R2SfgSwTa2Ix7kL/VEEYVMN65GBz3bk33?=
 =?us-ascii?Q?2S3Qw0byVQCkGTWo3EYrJc/qzngV8EhrNDk9o1g/RFcLyO4/bSStjQfSLP3N?=
 =?us-ascii?Q?xnEcBM73kGKjcX3PsKXak0hy7f5YqQ3bd9ofGZB6L8DnM3mX3sqRPst+h4Br?=
 =?us-ascii?Q?mKaRHftZFd9buouzZDtKRIuOZL0wCaX37BKXygzL+Jstp2IYsNdeDBJDKCwl?=
 =?us-ascii?Q?mDzXW0MdGx5wquuudM9xD48jBpFj9Zevx8C4SsPWEEnO4og5zGiLeG2rXmRI?=
 =?us-ascii?Q?+sWvi8jxBLuA5dW48uuyK7aBiIu4JDG2pGsWg2DrCSAq91FN5msVfZY5GJ7f?=
 =?us-ascii?Q?m7lnH67Jb/PDGqemm/xEuEqYwpItkf0zFjoS01PGU0A6gzWzS8zv5Da4IDWJ?=
 =?us-ascii?Q?dI1ga3ALXWC1D6atU4iEHeLhv8Akx+fxO2ejKXAXFf+DtOn70wEqAQaK5TlY?=
 =?us-ascii?Q?NCsFSfFRnbgkGRlldBv0uw0hynfyod4YRAAwDIUxyTvsXrayO1nK3Ycv5w+e?=
 =?us-ascii?Q?/mpyPYPIbSYRH0+YLfAcB4rlB+k5ofghNaH4XGy/h06Qaceu4uAQ202OG3PQ?=
 =?us-ascii?Q?AfGjc4rdMpWyJ7nedIR3asJlqwgbINSX7RatZF4Cbdjnp0OmvcYN0znOKNqg?=
 =?us-ascii?Q?mkgvnA0uNx63k70Wju9LlqwF/GKSgv2IccP70y9kITJ7JXQK7Y4v/MtFLatS?=
 =?us-ascii?Q?aSaaRjF3tH3WGX3kHYq+l2UA2OxKnD7My+h1rmtgjIkxVuACraQ3HQI3YjSl?=
 =?us-ascii?Q?gT+jjD0RnivFZ26t3bB+2D7p8hmn2CPb4fV6SIDHoCOXLySKBwveYPdO17Mg?=
 =?us-ascii?Q?vWpD9KBT57VhYWX3rVTjsF3niCE/AxvaPj9K6fBq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988ed4da-2920-4918-a933-08dd54eedec9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:18:27.4847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZaAN7Aj90aCbnDsSsRwce+60qedhXoRIRdFAFFvGZnRiIhEucWNYnxRKiTmuGGplFfZYa24qkzbDkzOk5CX2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10788

On Mon, Feb 24, 2025 at 04:39:04PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
> Need to add a new compatible string to distinguish between different
> hardware versions.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> index c56ff77677f1..4fbdcdac0aee 100644
> --- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> +++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> @@ -14,7 +14,9 @@ allOf:
>
>  properties:
>    compatible:
> -    const: silvaco,i3c-master-v1
> +    enum:
> +      - nuvoton,npcm845-i3c
> +      - silvaco,i3c-master-v1
>
>    reg:
>      maxItems: 1
> --
> 2.34.1
>

