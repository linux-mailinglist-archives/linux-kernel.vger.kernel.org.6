Return-Path: <linux-kernel+bounces-171282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F98BE225
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A8A1C236CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF007158A2D;
	Tue,  7 May 2024 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y0Ntwsoj"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1673530;
	Tue,  7 May 2024 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085113; cv=none; b=cP3PZY7NX3bcjUG4taGBW0KP2OAPcH628zHTpGL94kGbRqVwNPSoz/JH+3qa2H799kyPt97OJXjyZnjdfHv1pV0iPU7pJPvV4FUzUMv3c+EjTlvoOnLFEtKxBSxcpfayPgGTqazkAMwBkUroVc7JlS5CTDjr8zVNFjn64Cx4qFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085113; c=relaxed/simple;
	bh=PmZ7UZqfMlOc2oaKBUdRKgo93Ls9NurJiUV4r1GKUoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct9DIzHgVPwpZ3RaHkpba0BoOHrXK0DqXj6RwS5/v7YDV5xZ8EKcaW4Fh57NHqY+m4ob8JQTcFMApdnA/m1s9KbAyfXuYZlOOoZ/FzNwbmb8upgCIeKdQkQd0AAf6iSgMTh8koZuBT1cQhtPCOEzsSUYNuyuv9Mw5okpBBOQMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y0Ntwsoj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3Px43D9WhbnEpU5l+CqafWytQt70Xp5M2g0c30Ems/k=; b=Y0NtwsojhHStF8f3VH6h1sO+2B
	M6X1WwknVEX4bCk+DZwVEJAcpUTAyL6229GYiRwaJQjCmrO6Y7UGeg05SNMu73RhYT7wqi2IvM9oT
	kV4ltxYkmYvgg0Wkbz5ssPUHTU9ySdrX+Hjni7E6zkD+yX1td1plyenWT9S3A0SnXI6Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4Jyu-00Eqvr-FF; Tue, 07 May 2024 14:31:40 +0200
Date: Tue, 7 May 2024 14:31:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ricky Wu <en-wei.wu@canonical.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rickywu0421@gmail.com
Subject: Re: [PATCH v2 2/2] e1000e: fix link fluctuations problem
Message-ID: <83a2c15e-12ef-4a33-a1f1-8801acb78724@lunn.ch>
References: <20240503101836.32755-1-en-wei.wu@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503101836.32755-1-en-wei.wu@canonical.com>

On Fri, May 03, 2024 at 06:18:36PM +0800, Ricky Wu wrote:
> As described in https://bugzilla.kernel.org/show_bug.cgi?id=218642,
> Intel I219-LM reports link up -> link down -> link up after hot-plugging
> the Ethernet cable.

Please could you quote some parts of 802.3 which state this is a
problem. How is this breaking the standard.

	Andrew

