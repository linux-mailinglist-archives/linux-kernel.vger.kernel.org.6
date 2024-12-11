Return-Path: <linux-kernel+bounces-440659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8CB9EC28B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155AA162B89
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5671DF258;
	Wed, 11 Dec 2024 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5szOOaQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC111FC7F5;
	Wed, 11 Dec 2024 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885618; cv=none; b=VcNdTJEMd5v2/yUQoD1R/DriHqEjSlzQzrt9q+HZCXQ/AfzsZyd/FFcjA1Y6z3c7uMunP7EdYRhZPCi2H81MWfGGOW4XTrgLI4kJFeqrGo2bUIP5eqbIaAT+5RUf1LBaBmBNEtrOXUkEN9W2Gag3EGyX0CEEX5/kQsDMxPZcBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885618; c=relaxed/simple;
	bh=kgWBMklWM8V29sGMM6VzfCLkm4RGB7Q58jibb4q0dC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyioxBYl3gUTGEkBEaP8WvG6kkiMVpMy943RHqvvjJHSBT9TjThG5nNcgMrvGuorWK6swecNRrflb6od7GYDbHvGzBJyAjuzOj179Ma+n4US2p4WN1/cFcHJ+W2szwbecOChAy4zBmocpt5HJnTWqoyFGPC5ZS/7IhX+iy4kB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5szOOaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E696EC4CEE3;
	Wed, 11 Dec 2024 02:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733885617;
	bh=kgWBMklWM8V29sGMM6VzfCLkm4RGB7Q58jibb4q0dC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k5szOOaQmi8sDeBJ6d44SGuuLSoP6QRhYk6qZCmdgFoNndLjLaYN+xMDBcZewEQXC
	 07BiOtkOd/TySTUM5ITEE4i2Za0ubi0T3y/swOlR6LKblpQQsw0ksWYcy9Nul7MBgu
	 Vf/zUV+eaeh2xsJn7BEACaFuqE6GWBGNNtsLsb3mPzbqisgmVX/gLLo3snx4gZZX6C
	 YL1iIuwI4qn8KTcZI8WpL5+10O+7kkepR7ZS9+abQ4N6LzefU7RT3YEMwPveMDbL2D
	 AKnk2FeoyYdrFaGtdULLYksZhP/0I17r5RwckQuZO/Wrf0ccaud6k1KpYFuGkUVbGt
	 kO4bKGun8PF7Q==
Date: Tue, 10 Dec 2024 18:53:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Woojung Huh
 <woojung.huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, Phil Elwell
 <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 04/11] net: usb: lan78xx: Add error handling
 to lan78xx_get_regs
Message-ID: <20241210185335.7568ce45@kernel.org>
In-Reply-To: <20241209130751.703182-5-o.rempel@pengutronix.de>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
	<20241209130751.703182-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 14:07:44 +0100 Oleksij Rempel wrote:
> Update `lan78xx_get_regs` to handle errors during register and PHY
> reads.  Log warnings for failed reads and exit the function early if an
> error occurs.  This ensures that invalid data is not returned to users.

Should we zero out all the returned regs, too? 
Make it more obvious we failed.

