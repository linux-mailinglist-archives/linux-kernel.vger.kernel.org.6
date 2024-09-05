Return-Path: <linux-kernel+bounces-316459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0037E96CFDE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848D61F23D04
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0501925AB;
	Thu,  5 Sep 2024 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=macq.eu header.i=@macq.eu header.b="Nf2AYDGr"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2099.outbound.protection.outlook.com [40.107.247.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C5192584
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519540; cv=fail; b=a/gRc6/7HbtXTZuk6lKPu/5FgE1hTnZQL8ncaivXqotGi+YUf68JTNOcxP1bVQSI2V2BXoNZnsZrpxkLzsbXpEFUIAGZQNBMWkxz0QxWYfghsE0wMwQLAiW1JYi3TiqylZVpxLceUcUAJIz0mkn3VoovZkP3kFV7peYEbfZ1iAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519540; c=relaxed/simple;
	bh=5JenCCk0yEw2/RpxgAM7ABG8x97pdA1XOPszH9qTZS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0xP/4yQmU27HsXm0AFq2emSJGKWY7jgSJPFuZ5nMTsUXZIq8Mr+nEbiTFpMmmOMW5OqYxalgFrKSCIJcU3aZw2FAlaw+z8BUkRRctRjVc0MvipI0HxaarEtrqiVYUUXPW2EwVNGZjtSzb8hkDcN3od4GIaWe6iBmFqQIl22JyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=macq.eu; spf=pass smtp.mailfrom=macq.eu; dkim=pass (2048-bit key) header.d=macq.eu header.i=@macq.eu header.b=Nf2AYDGr; arc=fail smtp.client-ip=40.107.247.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=macq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=macq.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzxEiMxXx4wKehTtc6RN9Ig/21GlfaSFkctRqvHi7jqHZXZCQD/gehar+qxl08mSxOx4JqwjFveWmEOw3AcDg9Y8xBPkExBxf2qZbOuNFGSlxDf3iUvEHyPFV6prCWxC3eMI7ISQtXluliFIuo38JoIu+2F06xuifS67AQdrYbAGzwL8aUVvrUMFCdDCotbnLJ/yfYBI7LW/qW5O69Xzpjf7E3u5SQS7toEa49oui8msXmutMSiKJ2eBN6+lGlKzkctSR6t2iqs6iT7yDtmAWlbnCy3c9XT93t6cglr0nzbcGfR5pzO1F66IPY5Dla1ScR9Kl4TRvMNXBbfDpfyzQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbTJUxOUF4B7LmPGweKZgdUVoHb+zFAfXNZx0wZy5CA=;
 b=Ow4ezs/lSozMXOMOypEb2XMgv6WjUf1KQzupBi4EJ48RGTDQJAjKpWs/znyp3aFP67mTVktCUHCAn6PjMDAH6+QxSz5HUUnS8yuN4WWPRdTO8hH2IUxtJ4SAkZVXQ4YD9NEnIr6ARbENmqMxLG9v1pSZHRJrRuyp0s6DDP9yXonrMpBOcaxzcvsxi10eYVyOJ78XS5xFJplp7VbzMk0S4yzX6AE9eWMGimmFWZo6Z3v64Tv53aMl+PBfsHk6ka5Xjri6QiveJBSMuRUAQddybIiPc20L3c1/va6jhqWyrEyIFsjo+28uI0nVKX7DRdXmax1vMuD3mEmNlPIgeinOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.183.173.212) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=macqel.be;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=macq.eu;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=macq.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbTJUxOUF4B7LmPGweKZgdUVoHb+zFAfXNZx0wZy5CA=;
 b=Nf2AYDGriIiTS9cb7/v8itTa+5pQ3TjDk2IUykyx+nFq5jGYWBVCx23PuJ5PjyV5vBPpECRyoqoNJAerzMfoKzLGNHK62Zv6UbW3WnVTDog8TMsOQ2Z9i3IzQ3/R1SbvEgwpSJ8zLb/XNSNluBtBlqKcmqMEND5ijwj+1LtY+AhbIlSl6sRwYJLeNKIi8hpKPyoVD0VY7aP7snP2Ke2+pR2gfKKHn79Iaf6lif1tA4XuDQBuYCeu2zuqZzO6MMlVvH+wbBelm9Y4i87ggxyQ/MSPs9a4NPhFgKc26p4NYa3LGJRJJDJmtYERi4G1RRqpHYeia7x84pceAEmfOkWW0A==
Received: from AM5PR0301CA0031.eurprd03.prod.outlook.com
 (2603:10a6:206:14::44) by DB3PR0502MB9969.eurprd05.prod.outlook.com
 (2603:10a6:10:43a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 06:58:49 +0000
Received: from AM2PEPF0001C711.eurprd05.prod.outlook.com
 (2603:10a6:206:14:cafe::a4) by AM5PR0301CA0031.outlook.office365.com
 (2603:10a6:206:14::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 06:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 91.183.173.212) smtp.mailfrom=macqel.be; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=macq.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 macqel.be discourages use of 91.183.173.212 as permitted sender)
Received: from frolo.macqel.be (91.183.173.212) by
 AM2PEPF0001C711.mail.protection.outlook.com (10.167.16.181) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 06:58:48
 +0000
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 080DCBEC0C8; Thu,  5 Sep 2024 08:58:47 +0200 (CEST)
Date: Thu, 5 Sep 2024 08:58:47 +0200
From: Philippe De Muyter <philippe.demuyter@macq.eu>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: disable SRAM at startup
Message-ID: <20240905065847.GA5215@frolo.corp.macq.eu>
References: <20240904-fix-cf-virt-mem-sram-v1-1-fb007028d717@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-fix-cf-virt-mem-sram-v1-1-fb007028d717@yoseli.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C711:EE_|DB3PR0502MB9969:EE_
X-MS-Office365-Filtering-Correlation-Id: d938f304-8861-4b67-813c-08dccd783118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|14776008|75936004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yqp63OxDYy8Na4LSZJYvcEQC0heRjqI3XTv7ORYS3/kthgL39uumMxzXFyyn?=
 =?us-ascii?Q?oiE5rBTpJYySjWmb2CeVYIp9gB8cUj+sNbug4IPJRLsIWd3oQlzkavh+6xGe?=
 =?us-ascii?Q?0Ts3ABXPCaZT327Syc34YTWeAriSxY2pNv8YVBA5Oq+wmnJb01S3YoTET+XF?=
 =?us-ascii?Q?PRPVKjZYAO95zZuPYvxO48w8C8Es5z0lw6olQ6lD7ObS97p6+UqV6QJa08r+?=
 =?us-ascii?Q?XRlO1l7P+OobDZeJd8TKF0gr0PzsQ1gx8ab714K0Axh7HvwnC4tqh0EW8F4a?=
 =?us-ascii?Q?reZ1OyPwnmnTJctVWsx9vJms8ID1LV7adZ1TEw2k6k+FpaUMXEpJ0WBlYlcQ?=
 =?us-ascii?Q?OkO7U3F+gCeYDvfqsV5X9JG7d0uGqvSnswpJe01I75kceuorpO9PKX0Ppd/s?=
 =?us-ascii?Q?zw40Y7mPc0KM9HzX1NoILNHKkjOvXBMB9fErxHnVD0L5HgDbYjdSTFs6JSHu?=
 =?us-ascii?Q?Q5DuSw1xHKDZnZdYW5uHQhk0t3VKW3SRF12V/nsxWJlshmWS7tqgRlES97cx?=
 =?us-ascii?Q?NBam6vfQ1Ty7NBH8+rNimBFK/LmGUYJOcyUrCXD5+C4fAZfUPghGRiDWkVQf?=
 =?us-ascii?Q?ECXoK0Z6myE0I03kxYFdtWN46f3Lj408xVSi1efCiZ9QnKSaiA5pOMJ/3v6T?=
 =?us-ascii?Q?sP+HKGAEt9ZKBCLbDmr2DkiRn1bfXI2eqFgs6yfBZhszJ+X36SpXjmwI596M?=
 =?us-ascii?Q?Yo3Mtt6Ag0Cw2EbfkNF8XyscbojHuuLPq6b+80xIo3LNVG2lvCAAt4CWASUU?=
 =?us-ascii?Q?wgEiVJsKx6YiiIjIS+XPCNd7u+zcJ27GkBDNP34ipb/CEodKZhHjJHiQboP+?=
 =?us-ascii?Q?lo2Z7G+jjd4ASLkJRNut78YntJQ4/V5g++mRdflGCIAuh6Vx0RbM16jHH7F2?=
 =?us-ascii?Q?n9Y5FJ9BIftsQrcrkqu2FOLWOfmS2ypk303kOS3M4Mx3IIK8n+gRLevbcz3A?=
 =?us-ascii?Q?ZmUlcHqYtWgsHYZUEMUdzeJOpF0UzBTeH/dMfV9i3t3D/OUxwAaMVJ1P1ZOq?=
 =?us-ascii?Q?kiUP1OnYubw6AUVzkrcMgVtQpOgXn11KpOOed5EcQGGlfWMEkXVU0O+gFSo5?=
 =?us-ascii?Q?ttbACySWSNMUzdNH4CoNaLHHPKvOaDE63PmZZ/W61nrVvEAu5b7SGW5HBFoT?=
 =?us-ascii?Q?x3J5f9B8hA2XE+KYNWgRpfXlWkJ0W0YvGDoscJsAWmW28/C/ZAzIbUD/7nG/?=
 =?us-ascii?Q?jfFgftqEIqwtf97rguOpyclYIdCNBKp7eqmOiUs2JZwKBdQVmT4ULy+fNykZ?=
 =?us-ascii?Q?m02CLyHKxvxiowVpOrXdRNCs8syNiBmuIiRfjkJccwfqNfnzHrGvxBWH24rX?=
 =?us-ascii?Q?nDmF/zvgsYvRLtqAe0NEjBENNDjRzG/lLG+RL72aibYuEB2JzOMdj3z36hxx?=
 =?us-ascii?Q?9kA0O62kEpU8g35Oj6R0nb186PLYjSqAw42sye/HCgJWKQ6CBmqnIANWJwH7?=
 =?us-ascii?Q?I6QEe1cPOeLd7Mxbblc3ZWDIg0mbrukBZFWHOMbInpD7wREDlOj/7MaXQOJ4?=
 =?us-ascii?Q?AT37arNBTgoZkHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:91.183.173.212;CTRY:BE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:frolo.macqel.be;PTR:212.173-183-91.adsl-static.isp.belgacom.be;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(14776008)(75936004);DIR:OUT;SFP:1102;
X-OriginatorOrg: macq.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 06:58:48.2601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d938f304-8861-4b67-813c-08dccd783118
X-MS-Exchange-CrossTenant-Id: 5541087b-384c-4066-992a-42aa5fe171eb
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5541087b-384c-4066-992a-42aa5fe171eb;Ip=[91.183.173.212];Helo=[frolo.macqel.be]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C711.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB9969

Hello Jean-Michel and Greg,

Please add "coldfire' in the title and the explanation of this patch.

Best regards

Philippe

On Wed, Sep 04, 2024 at 04:26:14PM +0200, Jean-Michel Hautbois wrote:
> Some of the internal SoC registers have a higher priority over the MMU
> virtual mappings. The SRAM bank is one of them. If the bootloader
> enables the internal SRAM at address 0x80000000, virtual memory access
> at this address will not hit the MMU - so no TLB data misses would
> occurr.
> 
> Since 0x80000000 is the virtual start address of all applications that
> bit of memory is getting stomped over with inconsistent code and data
> access.
> 
> Fix it by disabling the internal SRAM at startup.
> 
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> Tested-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>  arch/m68k/coldfire/head.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/m68k/coldfire/head.S b/arch/m68k/coldfire/head.S
> index c6d7fd28c6023..3901a49c47c89 100644
> --- a/arch/m68k/coldfire/head.S
> +++ b/arch/m68k/coldfire/head.S
> @@ -207,6 +207,10 @@ _start:
>  	movec	%d0,%CACR
>  	nop
>  
> +	movel   #0,%d0
> +	movec   %d0,%rambar
> +	nop
> +
>  #ifdef CONFIG_MMU
>  	/*
>  	 *	Identity mapping for the kernel region.
> 
> ---
> base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
> change-id: 20240904-fix-cf-virt-mem-sram-abadb27fff2f
> 
> Best regards,
> -- 
> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> 

