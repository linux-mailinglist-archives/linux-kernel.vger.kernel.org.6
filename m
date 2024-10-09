Return-Path: <linux-kernel+bounces-356957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E8F99695D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519F12843B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699AE192B81;
	Wed,  9 Oct 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC9sZIAf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF1188718;
	Wed,  9 Oct 2024 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475070; cv=none; b=lt3PuX1iL4VcKepK4PgP0kPhZYbAf88d0flZPYP4e7N+W9ZpBC9ROZnCokMGcHv1CKHZgFQvhcOoqoe63Y7597eBMX7iwKPcKY/u6HmPRkS4qye893YYFo9j+uYlbboTaaMiJF31ybkCc1joKZky++X9xvIHsGgJbzrTo3cUIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475070; c=relaxed/simple;
	bh=HKypbYoAQlu/exlzm2QOnvGfns3PncBXqA2lmjJfQbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIWHSjDLCYEYCT/4t51u8NV6smSumg3yCuavoYS9KlROJ6Fikl8pIeSP/vG7H0XoYkURF9YY+m6jpoR08iENySjo5vx8cXK49qa/PRGR4ATfRBkDPs1OHGw7+pnP7IdCFLA2DMVZNkHRKtEC4o+McHll5KpTCAJZKzNeTZ6Fb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC9sZIAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94A3C4CEC5;
	Wed,  9 Oct 2024 11:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728475070;
	bh=HKypbYoAQlu/exlzm2QOnvGfns3PncBXqA2lmjJfQbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dC9sZIAfgWAd8oYQOe+d1shgtCg2px6PNAV7cUhsqfWFI5cFL4fHFbxY1b4eGyPT6
	 T2Cv4ijildG+rd/MmiAlqhcMnrDShvfrA3HQ7VZ0rAMgShMuCH0EGhDa63st1/GpEi
	 jsJ8JZ+0wlYGB0CJF442/An7RjPy6bbB7OXgPZeXb4B5Wz6RLbgZGUvw0zBK3PlK0a
	 PSDED0Pu0+CGGRGoKwz8FP+fOXmq1436d4vsIJVCNE4NDqyhaUtDWvsdMSwYvvLM4m
	 mlDt3KLgzQGKnOwNA9LOCxuiG0q1Lvv9MKkaFz0VZng4TJ1r1s1NX7l5pfRXYQbatL
	 JFenc/YWjGYfw==
Date: Wed, 9 Oct 2024 12:57:44 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
	hkallweit1@gmail.com, andrei.botila@oss.nxp.com,
	linux@armlinux.org.uk, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 2/2] net: phy: c45-tja11xx: add support for
 outputing RMII reference clock
Message-ID: <20241009115744.GK99782@kernel.org>
References: <20241008070708.1985805-1-wei.fang@nxp.com>
 <20241008070708.1985805-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008070708.1985805-3-wei.fang@nxp.com>

On Tue, Oct 08, 2024 at 03:07:08PM +0800, Wei Fang wrote:
> For TJA11xx PHYs, they have the capability to output 50MHz reference
> clock on REF_CLK pin in RMII mode, which is called "revRMII" mode in
> the PHY data sheet.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Hi,

As it looks like there will be a v3 anyway,
please consider correcting the spelling of outputting in the subject.

Thanks!

