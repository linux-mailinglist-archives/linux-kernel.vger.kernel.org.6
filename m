Return-Path: <linux-kernel+bounces-556886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E27A5CFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5225518943DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C5A26462C;
	Tue, 11 Mar 2025 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSCfDhN2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08160217719;
	Tue, 11 Mar 2025 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722552; cv=none; b=Y1s6LpLXy8XUfSlgpY1g9mJEyIggVebeeBQO7KpJB3/tNlLryJEC9v594Uw/EgLHnfOAjnMVcnKLbxQXHAIwfM9pOERdYP4PSW2S4C8NMQrbwCfdyZuDQIyxlYyegkeZyCKCnBWNJmq9QJZ5EyJqXPwro/myUIduzFUo2+bLpsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722552; c=relaxed/simple;
	bh=foDxJvYl6KBasGc4dz9ZaDGclCUqmjAtTLkdrSdETis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgN9vGfIgWFdkN6F589D29taskwECIA0knaNjbP9UbiNYfeK/utMoYfjrwli+W/xAyUZpomMEugfR126oxOtlvVJpJM+K9bXuAjSYmmwRDyRy5vk4awOdeysASxfkiYH5a/kc3fyq0Nr85QOBVtLE6Giq+NkyRi2JGQKTJVj6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSCfDhN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D10DC4CEE9;
	Tue, 11 Mar 2025 19:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741722549;
	bh=foDxJvYl6KBasGc4dz9ZaDGclCUqmjAtTLkdrSdETis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSCfDhN267WTd7uP6GT6lqCzD7QWFJY8RLRlu2G8GvlIbb3i8vPXYQWARMpHgw05u
	 +14u0y7nvmEKpMGXRvR1q9UGtpp9oW/DDyqRGF1WAFgvKJvmEZJ9UaOIrqWGLeMjCo
	 9r9sbhYnO1uDgS1Mtt4M+Px5UiwG4C6ucMZuIC451D86zc/AMm2teed5vxjQB5fsR5
	 jZ1jFVDmj6fhxbU3vW/NqqJmDZUzm5e0Usbbd2CnIBR5origWHzAUW4wDHuq0qbu2m
	 aVOIjOafmp7oQABWKnZAgh3W0t9WudUcXhPV0s4HEdBOWy7E0lYlDlEWWd9f90Evlo
	 ccW6DoFHIjCEg==
Date: Tue, 11 Mar 2025 14:49:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-rockchip@lists.infradead.org,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>, Liang Chen <cl@rock-chips.com>,
	kernel@collabora.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Yifeng Zhao <yifeng.zhao@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: rk3576: add SCMI clocks
Message-ID: <174172254786.8700.16296927950928692659.robh@kernel.org>
References: <20250310-rk3576-scmi-clocks-v1-0-e165deb034e8@collabora.com>
 <20250310-rk3576-scmi-clocks-v1-1-e165deb034e8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-rk3576-scmi-clocks-v1-1-e165deb034e8@collabora.com>


On Mon, 10 Mar 2025 10:59:56 +0100, Nicolas Frattaroli wrote:
> Mainline Linux uses different clock IDs from both downstream and
> mainline TF-A, which both got them from downstream Linux. If we want to
> control clocks through SCMI, we'll need to know about these IDs.
> 
> Add the relevant ones prefixed with SCMI_ to the header.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  include/dt-bindings/clock/rockchip,rk3576-cru.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


