Return-Path: <linux-kernel+bounces-304152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8072961B17
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6290D1F2473F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE3512E7E;
	Wed, 28 Aug 2024 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K97+GN4p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74AEEAB;
	Wed, 28 Aug 2024 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724804996; cv=none; b=Oq7FIQtvkTURhitqFuE5xd1QYjmbFpq3OODIl7DIgUesU9eJYRC/QqIQWayKMAJoHXhxUQs2LqYY7da9e3jkf4WIw42s98FUuLi5m+8TW0vSksoI8a+zefhfZ26HBlm1uc6snmeJ0NhTzayNfMu0Ywngua5vBG+92D9t6UpOPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724804996; c=relaxed/simple;
	bh=qV8brj5nPKMxJx2hd5zb1fORI9/mTy1Wy50PtTUi/BU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=uXM9veH8wz0Y+ESl2tYGBP9vinbU/4TCdCwt7k7dQzkIZKYqyYtBPTtTDhhNxmaHhFG7XU4A0AAkuLYnSrbV5qDE0unIXompaP5+oeUUoT7F0fkt10IQSJzpdwObhAaySRVQZ4bBwiFRU6z14nLoSiBIhXVMsTTHL5Az4/y7UdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K97+GN4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C729BC4FEF1;
	Wed, 28 Aug 2024 00:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724804995;
	bh=qV8brj5nPKMxJx2hd5zb1fORI9/mTy1Wy50PtTUi/BU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=K97+GN4pglzLTdsFz5dnQhOVq5eLZY4mN2fXbsmjFpYyUK498O6OoV18LS3DhHfcv
	 IvC4CqL1hggLGFcDzxWZOntHoXP+jB0BVb6Squ6mlgWGE6u4ltj2+OgPqYzBA88c3h
	 ASwjP+TQl0qIwjWU2980RHbf5vc6dvtxfXeCXFRuJuH2gdleI5zChIMw/ROqAMmdK7
	 lOuiQe1UJwatdlFn9kl/CHISSLiAkGooZNnaeutPE6o1ob36HWGdAV8lJcFFIXRKKI
	 13TcwP1+koXbESx8ZtNsIp3kiz0rO667Zonu4suMFpZ9vEprF+4Ab5Kila+ltjsh2I
	 k1CzEgQFfprEQ==
Message-ID: <d2bb3de1d48ab59847084dc2617cbb47.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240820102119.130298-1-link@vivo.com>
References: <20240820102119.130298-1-link@vivo.com>
Subject: Re: [PATCH] clk: lmk04832: Use devm_clk_get_enabled() helpers
From: Stephen Boyd <sboyd@kernel.org>
Cc: opensource.kernel@vivo.com, Huan Yang <link@vivo.com>
To: Huan Yang <link@vivo.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Aug 2024 17:29:53 -0700
User-Agent: alot/0.10

Quoting Huan Yang (2024-08-20 03:21:19)
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
>=20
> This simplifies the code and avoids the calls to clk_disable_unprepare().
>=20
> Signed-off-by: Huan Yang <link@vivo.com>
> ---

Applied to clk-next

