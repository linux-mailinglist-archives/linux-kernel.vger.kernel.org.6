Return-Path: <linux-kernel+bounces-375846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31E9A9BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29D01F22F35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBB5158D7B;
	Tue, 22 Oct 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zenithal.me header.i=@zenithal.me header.b="E21S2UNI"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020107.outbound.protection.outlook.com [52.101.229.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98095155352;
	Tue, 22 Oct 2024 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583926; cv=fail; b=cN8SpA1dF2BdLntqtPzu14eci2YJN5XWHr7PYosHEl+OYq/F10FG3MCEu7t5h+aty7z1kQRGuaP0O4ZP4uuXsnij0ACXqsSMFaMBPd7urJXzI+0+XIF6/77cnkzS6JtirNLrfXZRnHcOLiglY+Mqs6eC1iisuaSh9wnr2hPg//0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583926; c=relaxed/simple;
	bh=BK0iYPHnE03FExfugIOA919P824XFaELzWnqia+U28E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LFbP6yTEzohAGdVHFCykEprmWhlBuLI0Ga06YXEYZLZnt3VnGvsh5lIphUF54K4iYaOmQ04l6n2d0FloxOPliDPQPSeDwa5xnQCKyTsQvjEp8uWDv6TDlyQAVvtDjpncypIFLep5TzrNxKJm5l0PvtocP0+ejaQn1TQs1qryxVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zenithal.me; spf=pass smtp.mailfrom=zenithal.me; dkim=pass (1024-bit key) header.d=zenithal.me header.i=@zenithal.me header.b=E21S2UNI; arc=fail smtp.client-ip=52.101.229.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zenithal.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zenithal.me
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iB6d4qM+ATU22/i0BuCo12yvxXAmORLpXU49sKOebVlhP47Wyz57qAWOB1ncMLyD7xjfaPrAyZXVf+oEsJ4rmp3fsUWJPZMqsIxsL3h/g8w/6j/iBq2yZVUjLoHuVhjghi1f7suSypLDnRbrLzjFXfyfIViIUOF5tiIZaBniNwyOPJNQ/WLLqcXINoJAWcUsuT45+Hr0bCeUmQUqDwBsdXh56HlSdWD5gfdJ1WWP8n4ue/kAvM4RRrF1P4tUJ1K0eWqJA4SPfvyXc+8IYyJMWHGOAnP3opXrG7OnXuRuwjGufdF3yKl+/Z+YhPkwhHOqT923cVSy9RIOC67jj4/tVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA9VLFi4PS2+Ewt7mGeaAgLsBfmfwdFzzwJwKP5Zr7c=;
 b=IDV/7jZn6AjVK8l0XKffPwrkppd50i8b65347VvDWdpFqEpunyFJBsrAr9MktAjQpJSRluPfF0He07OyHAEAFS2eViFN6bomQjFXv79oLhGdCxMIqhh4CNt5RjIltWDnT7//RR7OQVMK+MFVh4grYki4RGa9bMFsCsffA6kQQdM7RJ4rw0rt87q21CiM2ukMRThAKAPqXKY17FeLTqfFBzwzAwIKi7/U8+2npoUIBhq9TSb/Bm0SbWboO3tcHXNzZUZpA245VOcuFVsBZSG//Tl9PYgIjoVkKdxdtTJopXPKs27uFfnXrSGj7nkTtzhOG/us17pLeCpZD+zWICVDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA9VLFi4PS2+Ewt7mGeaAgLsBfmfwdFzzwJwKP5Zr7c=;
 b=E21S2UNI6Sb/u7kWEawjnfprq/sC2IiFbPuH8cdTGwqmMbATvZ/0jqhklhQjEV1pRNDPRt5WZDp9nLEpdtTY1RXQqxzb9UwohY9WJTff/CQhbNOienU2FH6E+qqZLCSmsvEZgQHNyFxEKYLU+zFsIdGEXb4mxl5+tCyf6dj6RVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TY3P286MB3616.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.29; Tue, 22 Oct 2024 07:58:37 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::746a:424a:348:bab6]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::746a:424a:348:bab6%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 07:58:37 +0000
Date: Tue, 22 Oct 2024 15:58:34 +0800
From: Hongren Zheng <i@zenithal.me>
To: Zongmin Zhou <min_halo@163.com>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH] usbip: tools: update return status when failed
Message-ID: <ZxdbKiwZ1fz4kAZw@Sun>
References: <20241022064856.4098350-1-min_halo@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022064856.4098350-1-min_halo@163.com>
X-Operating-System: Linux Sun 6.6.28
X-Mailer: Mutt 2.2.13 (2024-03-09)
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|TY3P286MB3616:EE_
X-MS-Office365-Filtering-Correlation-Id: d566d5fb-a358-4cbd-6616-08dcf26f55f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|41320700013|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rKfAnkeHH9OWGjd4PpTt0UHw8wVG8y7H0TMj/i7hEOPc6mLcbS7LioyE4Z9J?=
 =?us-ascii?Q?+iw9oM+qgtetQMzxxLHBqs73wYfw5LaZO8A6pJ7413eaByDGLTYJdEh0Zd2k?=
 =?us-ascii?Q?ozhrtBbg3wBwjOwho/fMbt7/sCeJQFnrBobcEc+gl1EIsLTYQxb5pd4CRLM4?=
 =?us-ascii?Q?pbdA40Y3V9Xp5c7uid6cprQhQMcZZw0hGMwUzUE6OGW58CCYNnJx9OdwOH6b?=
 =?us-ascii?Q?Rlb1aBjgCrdgrV2oX127GmU+EAHiq/2GCBwCSducmT8Fy70+qdypCjnbOCAs?=
 =?us-ascii?Q?lo9RO+4UnVqilq/Sa+Z2reDz/cCnixxMm4tOF1MXM64+NeO8T+Igli2+3+np?=
 =?us-ascii?Q?668oblAP3kdTGbaEnzLbJqMXO7lwU4xWZIIn5pMh0W5Z2P69NprfRr+j+5cV?=
 =?us-ascii?Q?2XlWsIMLLofsjL8Ul4lCef5reXgOZSFWZcGNdTBOlZVSQed9DfOcBhGT4Rnz?=
 =?us-ascii?Q?FH19wJ0450iOrj6HisHKJxoqMUdWYQAFJzQVlpEhePbUIUWlNkNDuXa9wY1J?=
 =?us-ascii?Q?b2hT2JM/RZ8WQKPNZy/FqtI25pRTKkvG4nL6DIKHNYcBbjGOMVRL8eiXgXuU?=
 =?us-ascii?Q?7I/x4UjdgWI7J7ZK6Kxx0/pSAyENh456DqvEurZnV/bsb3Hmd6ebLkDThIFE?=
 =?us-ascii?Q?hdvfU9xnm5ol90MQVxpCS7/Pu2aLpvRXolcUIpRIk5ZnNWYOeVuyQJSKEM5H?=
 =?us-ascii?Q?1b+pPDXzwqgchrZahKgWI0KvhwItZGDJ7QbqeTZMLWxo4RHc67B5YljT+U7+?=
 =?us-ascii?Q?+YjZLOtIbJOb5Y6GnhmDYHzO8uMNxd/OfsAXI/IbQ/BNuvgCqwX5rQ5x7vR5?=
 =?us-ascii?Q?khU7nfCvBAdikkPxuUnme+P7mWpTbXc3etTHt6bsv5ex6d378qZq5rJFEwGR?=
 =?us-ascii?Q?MQ5ygTI6LqSG6PH3IIOmgSMMKWOekMyKXrBS23OT9Ffv8DP+7FU4XvhDFr08?=
 =?us-ascii?Q?tXaW8H4pHLFjHY01ci0g0RCUP+ooBuqNIAAnCSZEm8ogQVisfAxt9OGp84IB?=
 =?us-ascii?Q?3WCa95dOiT6ZwX+RmexQi9hNWYVCTfM4uUrPzxcG5zp3A0lkiRmbM1SJJDLJ?=
 =?us-ascii?Q?/84fmCegmKGdz+xpzuEvTUu8pajHq5wHALHyzVqUW1lsUnOrqHPVB7CG+hn/?=
 =?us-ascii?Q?B3M3U+68Qvmwwje/goiSBNaDPfYyO+Slp4cdR5/ZmPZJe4XRF/7JdzKVmToP?=
 =?us-ascii?Q?6bThB24FJrXNQL86dT4UbmbGC4ltOpm9TM8k4OMZOBVnWGxoY6Uaz3kk48wL?=
 =?us-ascii?Q?ybRCrmbeWFgCD6anaxuZoUwMkmcJEoMvq+LYFFp+OF92YOlCC5xHxe3f34fB?=
 =?us-ascii?Q?H4bNXVEqeutr/2IWg1JUxXq9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(41320700013)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FpUeJQvRfKA1Co2JPBkdGSe22lOLIAizzlowYAT3Xbqadyg36c6Iopj5ZIhu?=
 =?us-ascii?Q?3rzW3qm2FMM/K3LCD1JXkaO5PAo2WLJPYytN7WBtCj9k+Uk6IzxB9X5ajwC3?=
 =?us-ascii?Q?u77apWFDzB3zswMO34WtCuHgl5A8bEiJ+QiL+ck7hLkLWPDRzSBZPfY8BWTY?=
 =?us-ascii?Q?AvIzl+TfJG4nvx0dxf3A/0W0GXLJRcF18szDHjyyETbqNi2+rt3KYDvS6oYM?=
 =?us-ascii?Q?NWavUb8UWbGu+3NjlIgrOavh/KwvI+/A2T3y+UWPWKT7vsq3hozeiwGcZyIo?=
 =?us-ascii?Q?CjnuQUnXT8TxVl0yk7fkshXXTR6DqfmH3AyMwAi7VduqlhXgmA47L/mMoa7/?=
 =?us-ascii?Q?ClVUqWr0zGu0Dv5GI5n8bNHca9Y+/T4ytuhh/O4Ak8qxEpyi8yzcGApTtYCu?=
 =?us-ascii?Q?XM/YsJvo2/KzuYxr3P7c5ad0JyeUQtMPe742Xq01dlmiWR04cb0H7o0xWP6E?=
 =?us-ascii?Q?qa55CAp79y6L8/usct7GfF+klSACu+PV4b1iG3ryu5u1NlnpTc4vTDG9CsX6?=
 =?us-ascii?Q?Gsapwvqv/AYDC+uvAULmQ3aLHY6BV1pt/t89S/yECy5xZNcziZny3yseyByM?=
 =?us-ascii?Q?n8wOOqA4uF62ohYtnYDrrMxU1G76sr5riQELjuG+DmDR69s5+fFzFExy3Gyt?=
 =?us-ascii?Q?s0K/8d/4kIWdRhJpzLdL9SQ839nBWbhISG1aRi/lJE6dVcdqVP9TqhaooOCM?=
 =?us-ascii?Q?L3eEJNtQVgpflGJorfdYaQsgyfxJLg8YOUfa8dl38X+sr25RuZo8TgSWojIb?=
 =?us-ascii?Q?JKfTaLSmRWsX+bQT9Ax9utCaafs4XxJyd0Cad8+h/07vkN4Z+32W9P1yQxhs?=
 =?us-ascii?Q?xMKK4KGVutO+GpuO/Wpiw4es4NXpccA6pno6ifl4PGGUHNv+Bp3RPkKeKlLw?=
 =?us-ascii?Q?SA798N0Q51iSOXwTmoAmukcDY/xgLxi4Pm+Y3hP17jJhH1gJtfp0xnj1HSbA?=
 =?us-ascii?Q?QuOWbL5cnI/hHz6vooyNiqTKLpDM/kn5lfg7QSVy9khOPykdP94aOEjYO5Aa?=
 =?us-ascii?Q?b5sFI8O4vnWFnUUqkHjpr1U7UajsSO5QIkG7g8k04vEnKsWZMKFkRFa9Ez14?=
 =?us-ascii?Q?0iQMDdRp4oeHT87qnnK/vId+2yH6QUpZ/dfdyCJ0meOg827oPxScw3tu9DhT?=
 =?us-ascii?Q?7Qj93h3a9/njDwmJJFhPAFkLMPTGyEmiUIA62fZgJ2lvl1t1D2o0iPunwxEt?=
 =?us-ascii?Q?I9663CZIbX+Zy2HwcZyNywt/8vk1XihHHc+BfkP65tnLw9jfA+8C1W1oClh6?=
 =?us-ascii?Q?yMSFHc/yLXO3VMvyGR+7g9qCBI11c5+Q1MdlrGXbZWRU1LkkBJlkwpfGQo+Y?=
 =?us-ascii?Q?FWAopdqnJHAm5VnYXJedHx4hrtwb2Jd1Xy3XbGRGSKdD7UGRtzBD785sanm8?=
 =?us-ascii?Q?bTQ9EXvxNAP0eEOhdd/EzPo3zZ71UZbP94ln024bMGSOS6Xx5JHriYg85gbY?=
 =?us-ascii?Q?iGUPLk4//2LB3ywJ6q4CtH8iOrQuLXHdSDMPyIernxvfJON3gh8FsYItlWHG?=
 =?us-ascii?Q?UZCMgJHL9tRFYF47y3AbMUFBOzlSR7HjD3TrKxGBKPy1H3tY2JcRDHhkEUuG?=
 =?us-ascii?Q?j5eLoc0IUACV1ttQfUiJ6zUHuEPFmP601NJhot5I?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: d566d5fb-a358-4cbd-6616-08dcf26f55f6
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 07:58:37.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMFuLm93/FvYpuUe1RqiVQUfnoYk+F6mv2Hsmz/UbnXxPNwDinEtfoLQEQFD3VVA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3616

On Tue, Oct 22, 2024 at 02:48:56PM +0800, Zongmin Zhou wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> Have to set "ret" before return when found a invalid port.
> 
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>

Reviewed-by: Hongren Zheng <i@zenithal.me>

> ---
>  tools/usb/usbip/src/usbip_detach.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/usb/usbip/src/usbip_detach.c b/tools/usb/usbip/src/usbip_detach.c
> index b29101986b5a..6b78d4a81e95 100644
> --- a/tools/usb/usbip/src/usbip_detach.c
> +++ b/tools/usb/usbip/src/usbip_detach.c
> @@ -68,6 +68,7 @@ static int detach_port(char *port)
>  	}
>  
>  	if (!found) {
> +		ret = -1;
>  		err("Invalid port %s > maxports %d",
>  			port, vhci_driver->nports);
>  		goto call_driver_close;
> -- 
> 2.34.1
> 

