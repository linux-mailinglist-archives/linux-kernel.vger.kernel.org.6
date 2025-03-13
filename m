Return-Path: <linux-kernel+bounces-559595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6111BA5F5EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C0B1886373
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD13267AE1;
	Thu, 13 Mar 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GedkEBqv"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBA5266B73;
	Thu, 13 Mar 2025 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872320; cv=none; b=gdYjY5SD1Nnms4e4IyeA/vncVuLbEUPEP9E9kGaew/JhiVe5njllkuUlZyysTg5k9c1FfoOgIFvBRLzzDJwv9s9K9l1oLR6wkrHMkOyani9ieXvFUzDeLU7fngBIBNcUR6offhjlF1fwfpBgqeM2KUf5yBrKJwfKYrM4IgXjfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872320; c=relaxed/simple;
	bh=AzQsSEcDe7w/OOBpJoKQT9Hq4elC2jmXAtjGg3hdDrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/Cl2kWQtfiadYlzxxRec932aj9rKxbvt88fGQ8KUoNBKn6MZEu20MbNKZE8IBHkkljTh5BLtgQMa0/yh/M0m+n7x3HIcrmKoatirLq7U8Y7UB5Ygt6CpUlNAQMDcJEMcxJesCSTkMQLHe5/RwNPvIEXgF4/+XUmc3FAZliANG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GedkEBqv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y4Lm4YZ3BFWz1g1FrDh9R2DUroubnxR1ccujrip328I=; b=GedkEBqvZu3WjhDB/hUqKCpuOn
	cgjYxWNCvscRWpwihg5EaAu9QpSWodXfc1uO6v5OKa3CcN3pT00u1Rd6u1QCwJKh+yX+hMNpko7As
	vuVSlDej5feEYkU8DbKQmLUsc0Zi4Z1CQDh0SzQhb8kmtuG3DQI4MCsI0SGcxy2HJHqM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsiYf-004zy5-KZ; Thu, 13 Mar 2025 14:25:09 +0100
Date: Thu, 13 Mar 2025 14:25:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kees Cook <kees@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] net: macb: Add __nonstring annotations for
 unterminated strings
Message-ID: <634dbbef-d7c0-41ec-8614-efee824142a9@lunn.ch>
References: <20250312200700.make.521-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312200700.make.521-kees@kernel.org>

>  struct gem_statistic {
> -	char stat_string[ETH_GSTRING_LEN];
> +	char stat_string[ETH_GSTRING_LEN] __nonstring;

This general pattern of a char foo[ETH_GSTRING_LEN]' will appear
throughout drivers/net/ethernet. Maybe Coccinelle can find them all
and add the __nonstring ?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

