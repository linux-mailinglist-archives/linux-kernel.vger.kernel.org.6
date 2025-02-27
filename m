Return-Path: <linux-kernel+bounces-536927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38595A48622
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D76C177C50
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09521BD007;
	Thu, 27 Feb 2025 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG6tgIUL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313581B423E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675345; cv=none; b=KyJ19Fw8gZvZcgRNYDwSHc1/bPzFmqyi00xt2u3Mm12EZ7mun1IIlXEgepi2pMq1q8zBsry/4Bp3rbS+lnr4vSVBaeQqiBBL3PY95A1jP438eV2VKNcm9kkZsAqoyGRKe6zQhP3DSuq7aYrbYMv6bdcjgINvJCr6qRytRc8IbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675345; c=relaxed/simple;
	bh=PMQzIiaM7tv42ojB3AJIVBgOlb9WCl+GQFr8e/SPuHk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FOTOTRPGffHdRnE89B+mQF6t8bWevJRXJPivQCqeUriBc/trPYpgZ/iNY8KXVy5xDy7bqC6O6+F5pkvCh77RjN+zkY9VGetotUo+dDJQo3leoKQSLShi8dCCnJ8b0bhkj/69RDtBtit3IZ2ONfJU4U2eufLRsJRozUrEFUyYq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG6tgIUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F032EC4CEEA;
	Thu, 27 Feb 2025 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740675344;
	bh=PMQzIiaM7tv42ojB3AJIVBgOlb9WCl+GQFr8e/SPuHk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TG6tgIUL8fAuBotaRDPKSVVKLXPmbDQDpgo3TRFqtHagXWwwHnAuEXJXKJr2XRxO9
	 9sfl3Dbm1yAqjc2OHWQrupL+54GEK4cAqGIIBZmEMFyX8xSJHW2r4GroHENmIkNh0T
	 JPCAeCDsvde30RAzTx0O+XczB7y2p02El+1MKtRmPOX3Gn1YpKBno4KCl41B7P4sX7
	 8GiNADBdXu8ZRAOGt7CZGLxSMEZvwBnt8wMc+YBNxaeUuq86OD3MeduUIUhydR3P9L
	 K9GkWoZU3SxEiXFOOZ200JKfgTDywS0JeBZfCjgEIK3A6LeyOSsFsAg97PvkH4i7H2
	 hWWjJ9MfJfDsQ==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250227070518.5468-1-krzysztof.kozlowski@linaro.org>
References: <20250227070518.5468-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4] phy: exynos5-usbdrd: Do not depend on Type-C
Message-Id: <174067534154.390201.8029469655401583990.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 22:25:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 27 Feb 2025 08:05:18 +0100, Krzysztof Kozlowski wrote:
> Older Exynos designs, like Exynos5422, do not have USB Type-C and the
> USB DRD PHY does not really need CONFIG_TYPEC for these devices at all.
> Incorrectly added optional dependency on CONFIG_TYPEC caused this driver
> to be missing for exynos_defconfig and as result Exynos5422-based boards
> like Hardkernel Odroid HC1 failed to probe USB.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: exynos5-usbdrd: Do not depend on Type-C
      commit: 49166afbf4ce3b5049295534150886a99b9867ec

Best regards,
-- 
~Vinod



