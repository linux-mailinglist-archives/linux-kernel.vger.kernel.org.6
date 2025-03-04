Return-Path: <linux-kernel+bounces-545495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB06A4EDD0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EEA3A8CC3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1782620EA;
	Tue,  4 Mar 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW6OYsCr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9A525FA0E;
	Tue,  4 Mar 2025 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117793; cv=none; b=AEWoBGAGwsvUyaDfkijROTeGhNEwaNPigvdjIK0IyCq7OTsnN2plyqZT2TIwRLbnYqwzspg74R16Y2gR65aqIqnphNBKQGRn+Ib3PDnt7amvUXKjOF7g2Fs7xGpHXpJEIVfz1sNS3FlYuQx+1iXU7hfAOq1UcJ1LUPzGtBorD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117793; c=relaxed/simple;
	bh=YaSgsivxqyV3yPSsK9Kts8rLmIRD2zXyCwJ8TTaOhTc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Me6UbEKoq7j5RXBv+93st1FM2kedGlu3tb7jLv60yWm+XtqOIqnk6+cc8CArzfJq8QTVU9RueRbU5NkozE+iU/rjE6O7sn2eip2KfWnJDRwJQM/UBiaODnRN7Yo2SK0PCsIYLCWw9lgsUMyJ8Y0QLeRBtPhFrb49PVl3JDB/Dwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW6OYsCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BEEC4CEE9;
	Tue,  4 Mar 2025 19:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741117793;
	bh=YaSgsivxqyV3yPSsK9Kts8rLmIRD2zXyCwJ8TTaOhTc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ZW6OYsCrxSo7xiEJgnQ/sDFRXqAwyK4lL22HIrpQteRpS1ivnAzTtNGlTXQt87DEz
	 P8ocMKcgsxU3AY+iFjlkKdTcQGTM9TE0WumKVm4EgM8xIwp8zqTqlNgaxRmHGxLUY7
	 /8H4/6XAbhmSVph6CgaeZTV0f5X0NRaKj2fg1SkY3N4bny0qcvc1hkM6EkayQ286ak
	 pJY05a2iY/t6L2U17iJt1bFxTseqsgXK5LZub0d4lmrHq7aX5L9a0c70+ne3kXWRvh
	 TgOnN1xTtkC4d82aYm+4KeLYsdoDxdH2WesLYcabaOFbEBmV24e0ZKmyySTmAOMGRc
	 /d5KsQHma4+cw==
Message-ID: <65e5503016f79f6c89219b5841c75b8c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250123181913.597304-1-afd@ti.com>
References: <20250123181913.597304-1-afd@ti.com>
Subject: Re: [PATCH] clk: keystone: syscon-clk: Do not use syscon helper to build regmap
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Andrew Davis <afd@ti.com>
To: Andrew Davis <afd@ti.com>, Michael Turquette <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
Date: Tue, 04 Mar 2025 11:49:51 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Andrew Davis (2025-01-23 10:19:13)
> The syscon helper device_node_to_regmap() is used to fetch a regmap
> registered to a device node. It also currently creates this regmap
> if the node did not already have a regmap associated with it. This
> should only be used on "syscon" nodes. This driver is not such a
> device and instead uses device_node_to_regmap() on its own node as
> a hacky way to create a regmap for itself.
>=20
> This will not work going forward and so we should create our regmap
> the normal way by defining our regmap_config, fetching our memory
> resource, then using the normal regmap_init_mmio() function.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Applied to clk-next

