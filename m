Return-Path: <linux-kernel+bounces-357986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7FD9978C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6231C226AB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB61917C0;
	Wed,  9 Oct 2024 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd5imAp+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A492A1C9;
	Wed,  9 Oct 2024 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728514881; cv=none; b=KQi51htAV6659lMISVIervrufqrp+eTXctxW8N7+mkN2NWdV3rkpbNA1SljFYdiaXmpZaQyt62yDE51y8HI9TrelWSfx4GBGsuLXbY3HDBT9CSaE3J3i+yqk/hQ+UfRD5eG9ql7fsu1kAEOMDDjpVshB6IvBoyieQN2l1gTfrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728514881; c=relaxed/simple;
	bh=uGdAjmstr/NYDBu5FtcI7luJ+EBjhJ14RKCnRsBkAyA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ilVZu8lwaKNio8o99aJZNQGklHyCwhX2pxmy/AUydSdE3oTon2k8vTYazNcx/u3puHFqor7qPZ3PrJ1YAVN7moCytboqWCfFaSecnq+u0odgpdgX0Dtb9HJRiH58IO3QllbIcomq6FxUZdk4DWsLDV7dRQGmMeR27OYFh+iMvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd5imAp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9054C4CEC3;
	Wed,  9 Oct 2024 23:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728514879;
	bh=uGdAjmstr/NYDBu5FtcI7luJ+EBjhJ14RKCnRsBkAyA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Wd5imAp+fA/EiUB0kuhPCKGpACEC5xw97OM/1pOTvaJzer+QSsqMfU3Q6I3effOdZ
	 yv/QYfVtuzl7u/hQreEhSjAiPrPpfyZFs4qmSfE4duUH8zCVyU8eKAuvYrk3CLPpBe
	 nNp9pifXvENEmBI/0RlOt97n4d+qjrRJ9r1Mw7m8cDZr8UGuuxHFn8TYh2BvO1uEG+
	 kA9IMUF22GW72x7HB2n4pJD+Urmhibm2rB0+258gupLfNAd2TFdAOfQau1l+gpPEw/
	 cL6+tTyEgXbcNxPKs+mslJ9W1b3RbKw+1Q5U2wsZCE9z4qye19s5QcPdE5pYLBVkaR
	 5bBiAbBSKB2gQ==
Message-ID: <93bf1c44c5a6e763e9a9590aaf752ec7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240918123925.41511-1-david.hunter.linux@gmail.com>
References: <20240918123925.41511-1-david.hunter.linux@gmail.com>
Subject: Re: [PATCH v3 1/1] clk: clk-qoriq: Replace of_node_put() with __free()
From: Stephen Boyd <sboyd@kernel.org>
Cc: David Hunter <david.hunter.linux@gmail.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com, shuah@kernel.org
To: David Hunter <david.hunter.linux@gmail.com>, Michael Turquette <mturquette@baylibre.com>
Date: Wed, 09 Oct 2024 16:01:17 -0700
User-Agent: alot/0.10

Quoting David Hunter (2024-09-18 05:39:23)
> Use __free() to have automatic cleanup instead of calling of_node_put()
> manually.
>=20
> Compiled without errors or warnings.
>=20
> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
> ---

Applied to clk-next

