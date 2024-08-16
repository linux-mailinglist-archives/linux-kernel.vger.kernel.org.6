Return-Path: <linux-kernel+bounces-290203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AE49550AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8D91C210A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CB71C37AE;
	Fri, 16 Aug 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Adrw3IOR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8687E8288C;
	Fri, 16 Aug 2024 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832292; cv=none; b=HBp2euvx5TvrfJngtXxkr4Xf7zjgngUx7kl3chj6DWQT7sU2udrjCeAhMNcdgbHqLjersVTHidrQGYjRbMQ40sCQGyqT5l8oCYKkIvxetA5yhI579XaDBfyJfK5yhBUEaHA446e6j3mArsuIVIQlcwdn9QXFw8yhzlm0B6Jz25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832292; c=relaxed/simple;
	bh=54UJubvXe6uN8iJpD8UZtkY1GLXwHibslRiJHaA2Bsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSkPLsh7ZQfY1hX4qFB583azlqw2zfW8OMSljxKeussKXhM4ePhqENwoN9mWAvhXCkp0CEtdilbeWCoLiWT4esAAyqJDmYjdMpJnFl1OemxpiHgbU2l82ZaVfqVQBRIYxF7hUENlxRMj78tvzs0rYrQdhtwZLPxZFIAwZW0mNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Adrw3IOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3AFC32782;
	Fri, 16 Aug 2024 18:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723832292;
	bh=54UJubvXe6uN8iJpD8UZtkY1GLXwHibslRiJHaA2Bsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Adrw3IORhiqqD1LCaNz8aAnLZHvY0rbf3DuWy0bka+LT21WrLeNdHNq/gdz12DZQJ
	 URoQDSgqIrFAkSSbGs3Gxu3rWdag6LNK0ZrsO5Dm6F90sfa2ekfXnsHBbQFAmOKEq0
	 1DObPnqF24ZihGjahw3G4qV1kTYYfLEY3hpJ/jDGtaJjQS7JLIN82pkW/5qQW4xUnY
	 hazdICTGB7zfZ6WASj/zawTy756u1BszWrEiTHg7e25XNE/J+ClrWxuiPPL6MDGZ65
	 2xdE2CJe7MoOyCVK8xQyiDzh8Ud+oBrGaBl2NLb6yK6SnCEPRncLqxCnvgBG+w0hMm
	 RZr1DeqXX4B2g==
Date: Fri, 16 Aug 2024 11:18:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v2 1/2] net: phy: Add phy library support to
 check supported list when autoneg is enabled
Message-ID: <20240816111810.64355472@kernel.org>
In-Reply-To: <20240813181515.863208-2-divya.koppera@microchip.com>
References: <20240813181515.863208-1-divya.koppera@microchip.com>
	<20240813181515.863208-2-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 23:45:14 +0530 Divya Koppera wrote:
> -	if (autoneg == AUTONEG_ENABLE && linkmode_empty(advertising))
> +	if (autoneg == AUTONEG_ENABLE &&
> +	    (linkmode_empty(advertising) ||
> +	     !(linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> +				 phydev->supported))))

nti: no need to wrap the linkmode_test_bit() in brackets:

	     !linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
				 phydev->supported)))

otherwise LGTM.

Please try to put links to previous versions into the cover letter.
-- 
pw-bot: cr

