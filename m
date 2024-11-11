Return-Path: <linux-kernel+bounces-404044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69729C3E77
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A28280FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AD318A6A8;
	Mon, 11 Nov 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIhkPCt9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB614A62B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328470; cv=none; b=RgWV1Bu1rzNtboIumK4H+tTGlNPv2ppzg/od3pfvJ5ITL8U+EufTpyV6UwcfwJWH0diJQg8TDmGlxnMWd1MN27j1ptB3nZ1OnySLavigFmNgOsgUwlvBFrstsLplmSKqwTfTJjwYpNr5idRBwwNYA+aX84SFhZJyUlFUFu9RJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328470; c=relaxed/simple;
	bh=4JKLe75Ad8EHAGqUPxv6uuNOhO+vJJVbPfSAbuNecXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUZ4ZdVmiu8mAMvU/gFtTFhxzIj3smYMduATYlT3iHTdfbgAJjzZf7futLwjA1p+94Et8QooFw4o2eT31ELixKPvt6h9vNk+1dzNXl7g8OepmYa/huBzhEkredxtNyKOz7iiNfiWYsYXjzZ3bFUu0wMqZWopEDhQjG/RNbUgzH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIhkPCt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A768C4CECF;
	Mon, 11 Nov 2024 12:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731328469;
	bh=4JKLe75Ad8EHAGqUPxv6uuNOhO+vJJVbPfSAbuNecXs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FIhkPCt9TwzoNQfArQzMY/u6lcbn98WQ9fYZ2BlnETQfriO6banoqYzoNwpZkjL22
	 yKmJLqSLFSHEJ02YdhvhRQSt+i9/l/2r1orpTeTKtvg/hIfMxTopfq8PJ6dkhFRmVr
	 4dJarnvEIu2iLBRPdd+4QeyCw9vQeWKXIJRCWsT1POcvN4Ns73TeLK7mtm6vRtOsIV
	 YD3dylLQ2l7RCZpgpRrl19dOI5J5ISfK48JchweUgax62xZrhyrJ50x0T2QiNURK49
	 7eirY4RWC8A8CSH5YdWSvlkylnzXUDhubka6UTiKRmutNaiKuTZRKckY0bq8SWJ3db
	 ux5j+HVHWLmhA==
Message-ID: <fcc45713-1653-418c-b33b-774e5d4921a6@kernel.org>
Date: Mon, 11 Nov 2024 14:34:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] soc: ti: pruss: fix the return type of these
 functions in icssg_prueth_sr1.c
To: guanjing <guanjing@cmss.chinamobile.com>, s-anna@ti.com, nm@ti.com,
 horms@kernel.org, p-mohan@ti.com
Cc: linux-kernel@vger.kernel.org
References: <20241109050150.265374-1-guanjing@cmss.chinamobile.com>
 <20241109050150.265374-2-guanjing@cmss.chinamobile.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241109050150.265374-2-guanjing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/11/2024 07:01, guanjing wrote:
> There is a mismatch between the return type of these functions and
> the type of the values returned. This fix ensuers compilation (of
> drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.o) to work without
> CONFIG_TI_PRUSS.
> 
> Fixes: 0211cc1e4fbb ("soc: ti: pruss: Add helper functions to set GPI mode, MII_RT_event and XFR")
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

