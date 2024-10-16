Return-Path: <linux-kernel+bounces-368572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F6D9A1180
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFD42881E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE24213EC8;
	Wed, 16 Oct 2024 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLI7RXIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78871212630;
	Wed, 16 Oct 2024 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103199; cv=none; b=fyuLTp2ns6ZzRtFA8GdIzpRkxNu6zGKx9acfTFHnepRzYW3dQ2IAuwpj0Nqdm2j4TW/vvEw7Rit2aFQpzW7Hob+9K1SfRyZ1/kAYjqo2t3dg5bmRLL/hbXPcg8Dme4p1JkKIfjw9tlUjMD/zw7QP2cNRljKvlUjWx3UfCgOSsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103199; c=relaxed/simple;
	bh=VzEcdM7oxg8go3c06Uetl0AaBL4Nyw8umwHBNlCH7RE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ceh1wkIKykyYdUZoRwXhya+ocw3x8WhyiIjIYNRqjhRGuT3V7f0IrNILWuPq/Xn1HU+XgIh4T8D1KsXhvOrzMKr0X9AyFMXYWUAYgX/qllYp+c+bcvUxbX3oZbl4rYXvvIsVIfT80d4/qxHXPiuZpT5/5iGKnjrJ2xHT07iN6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLI7RXIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C58C4CEC5;
	Wed, 16 Oct 2024 18:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729103199;
	bh=VzEcdM7oxg8go3c06Uetl0AaBL4Nyw8umwHBNlCH7RE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mLI7RXIZ8p1Pg+Oo11M03Y0owKEKpR+zIRwNuD2phQi+AM3rpFNXNQg8fN8fxObHa
	 i83p+4ttgkPrSHBPJfjAHXsF3ysit2WuGQZ7K7hcY3PtVsbcv3VIYWvyCM3S/XBlNJ
	 y/nQDOPrCBbJgGjzwntVupTKZuUWvHyvyI2CxKyQMOxwlrgo3SGXvScyzynZInog1X
	 E/+uMl0mat0kT4Do4sL4CUmqdIemyySQgSI7PADT8EJNB40zyQxLjod3RC/pOIllEC
	 5b2xblTGCqrt2MGPS38Q3E+DbjFnTypiCTWS5+L3DGaC4eXug1TaPkG92Mx5G+fW8f
	 1s1BECml7Gh9w==
Message-ID: <de44454fe6d3c7238e28ec5545b2b84e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240906082511.2963890-5-heiko@sntech.de>
References: <20240906082511.2963890-1-heiko@sntech.de> <20240906082511.2963890-5-heiko@sntech.de>
Subject: Re: [PATCH v4 4/5] clk: clk-gpio: add driver for gated-fixed-clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
To: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com
Date: Wed, 16 Oct 2024 11:26:37 -0700
User-Agent: alot/0.10

Quoting Heiko Stuebner (2024-09-06 01:25:10)
> In contrast to fixed clocks that are described as ungateable, boards
> sometimes use additional oscillators for things like PCIe reference
> clocks, that need actual supplies to get enabled and enable-gpios to be
> toggled for them to work.
>=20
> This adds a driver for those generic gated-fixed-clocks
> that can show up in schematics looking like
>=20
>          ----------------

Applied to clk-next

