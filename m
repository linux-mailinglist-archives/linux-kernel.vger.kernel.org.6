Return-Path: <linux-kernel+bounces-266534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058E6940147
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371581C21BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E47190489;
	Mon, 29 Jul 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnRl7cWK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989FF18F2FD;
	Mon, 29 Jul 2024 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292660; cv=none; b=eTxU1+aMZunRb4Nj2ucr70KlCylT97a1g5cD+aYmRdhFkbPf4XEaqU5yOQsfSasuz0k2fGL/0kCqryZSch3i9cPUxtTRgCkDCK3sVJenfLBMNZNy74SIsLUwQZSVMRGwPxAofSPVXcPF1/sTN2jXA5Nf+lsxmS8RZxuzo3k/pMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292660; c=relaxed/simple;
	bh=D6mwweKmN8jdrEMRzN0PVB7taUVfH02s8ZKzYztglK0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=egWWh04HZaT1wbjA1jpmeJE9LUX1sw9Z/0U4AHaxgvUKYfFvsD9vAfs9zJbeof+5oxFW/W/Y1pVokv+RaLnJTnYFTVB8kqIY5FyH5NsQbrcvqXvf+AC05vgRO0Xk0N4HWDabU59SJhLT7eiMvu6KJGgBWZOBEnYzYSPAFT0kj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnRl7cWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64581C32786;
	Mon, 29 Jul 2024 22:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722292660;
	bh=D6mwweKmN8jdrEMRzN0PVB7taUVfH02s8ZKzYztglK0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UnRl7cWK/dALs/MmxWM0sGFOIZGaAS66HvROtgjNEmUSOPoj23fvApw5NPl+CSJ6e
	 digPOBU8kE60wtcmncwtpnFmnf00rXR3V+4jKNCtr9tB4F2+rI6c/kYl2PNvNJH8Qy
	 NSvcINAru96l7DOPL0iItTWz0hMAuGE/yNbgtMuyflFEs8i84gXmuJdSghXE3wRcY6
	 Q/XA/oxU2hX3d9P21PTpgJZzpkHxrXxF+6q6QaKbQWoXkyC19fddpRrxH5yZXsZLqr
	 aVUL3hDOtMnofOkrLd8ppfxWqTehU1jr4KRKsvVSyq8kJ6Vl0WZd+gUhTKE6ZY6o6f
	 z+3UAvP2hSinw==
Message-ID: <1c25853ce67aa1b169ecd41e4283ad4e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240718210513.3801024-6-sboyd@kernel.org>
References: <20240718210513.3801024-1-sboyd@kernel.org> <20240718210513.3801024-6-sboyd@kernel.org>
Subject: Re: [PATCH v8 5/8] platform: Add test managed platform_device/driver APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>, Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 29 Jul 2024 15:37:38 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-18 14:05:04)
> Introduce KUnit resource wrappers around platform_driver_register(),
> platform_device_alloc(), and platform_device_add() so that test authors
> can register platform drivers/devices from their tests and have the
> drivers/devices automatically be unregistered when the test is done.
>=20
> This makes test setup code simpler when a platform driver or platform
> device is needed. Add a few test cases at the same time to make sure the
> APIs work as intended.
>=20
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Reviewed-by: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

