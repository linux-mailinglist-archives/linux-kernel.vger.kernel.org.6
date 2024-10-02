Return-Path: <linux-kernel+bounces-348392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D9598E719
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF6AB2461B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9153619F107;
	Wed,  2 Oct 2024 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJSu6Rky"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D81991C9;
	Wed,  2 Oct 2024 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912193; cv=none; b=AsovuofekPOWikdmA8UmH+ZZvxgi1xqDWZ3vrites/mn7sUchCrdc7+qgzCfUNix8LPDmyH7YbWzdJ3xo9BzNyL/k5IRyZyoGNbK1+dWlXWdpGcz5oSu00+SRPINp93RzdIi4BQ32F54ER8JmjHn47Bv07pFkEbd4eF8nmsCtnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912193; c=relaxed/simple;
	bh=HyrtHeAPOivtYCgQ4nQSGDVQaHlhKfwSeUxDJUJuZZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLizJpFvvJyHYxVDHn2Os+/yiJIGtT2jhp5x6Zm8h1lFEJr7qCmbPeshivBmJCFk6lT11pert59fOmF/mUq74xprQy9uuaxTdvwHDTAW3Ra/y9nVbLe77xe6KSmLngW2yLohZIyzD3Ou04pYSJUmSEwamk21HREgR9meg8WKOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJSu6Rky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461A7C4CEC5;
	Wed,  2 Oct 2024 23:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727912191;
	bh=HyrtHeAPOivtYCgQ4nQSGDVQaHlhKfwSeUxDJUJuZZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJSu6RkyIIspeq4fY3ihUa+g0MzP3pEl9wiNEl8UmxuIAxITAbXlSEqZfQmu+5lxq
	 0Vb1Wkd6vjGP8arRiAH7rjOWD+SbdNG/AcmsakHR5jb23UiV68hRD8h3CfT24FYlSh
	 vnx49MWym7CKuD3Pu71TnSW5Vr+DnIAAkIrx66eNI4p4M/6ColssFiCmFYLba9R9Ca
	 fd0Vi0tE8jz4VErPYJ+LezJUSjk0vemGQlVEA5AUreAsorZJxYfLl+UIAtn6C5E0MV
	 i61aEzBVUhNMKgb+kAcCreN/UAMoQ5qVDcPKG99E7Jm954A0fJVieEZDApWUTeudma
	 ZGyYtD/LvWbpA==
Date: Wed, 2 Oct 2024 18:36:30 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
	valentina.fernandezalanis@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-riscv@lists.infradead.org, pierre-henry.moussay@microchip.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-amlogic@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 07/11] dt-bindings: clk: microchip: mpfs: remove first
 reg region
Message-ID: <172791218968.1549326.10092947836585074554.robh@kernel.org>
References: <20241002-private-unequal-33cfa6101338@spud>
 <20241002-alarm-drop-down-e37c31e50a48@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-alarm-drop-down-e37c31e50a48@spud>


On Wed, 02 Oct 2024 11:48:05 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The first reg region in this binding is not exclusively for clocks, as
> evidenced by the dual role of this device as a reset controller at
> present. The first region is however better described by a simple-mfd
> syscon, but this would have require a significant re-write of the
> devicetree for the platform, so the easy way out was chosen when reset
> support was first introduced. The region doesn't just contain clock and
> reset registers, it also contains pinctrl and interrupt controller
> functionality, so drop the region from the clock binding so that it can
> be described instead by a simple-mfd syscon rather than propagate this
> incorrect description of the hardware to the new pic64gx SoC.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/clock/microchip,mpfs-clkcfg.yaml | 36 +++++++++++--------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


