Return-Path: <linux-kernel+bounces-297073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB9595B2A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C31B2824C2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A303D17E004;
	Thu, 22 Aug 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceWcxheo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EEF2033A;
	Thu, 22 Aug 2024 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321497; cv=none; b=tn76WKTt1wjgM/DanelwzH5NABlpjyVvGsyQ8JOWFRmqp6R4AHIhxcrax1+ykWxee7Y2iy81jmMzRDQVss2VkIyxftDd6LHc+zGw8uW4PvHK2UNGNk6dnm2hdkQeIawZtG0xefYFm40bQ2VWUjYzN9BA1jX19wtuJN+Umo6c+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321497; c=relaxed/simple;
	bh=bgYDPzutrzDAr5YMb+PdbaWy4xjt/hdjmclU/iDKrUE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OAMfOHFfmMIhRaZ33cBFTeOSajHakvPSOY9vglKeWHKM0Uk0oXxnd87Ch4XOJOsDKuA9oBirrNVemLgwEIz2RVHtJM05u/ZtUNnCcBV7m3RL9/ggUM0sNzxFVIUm0PZZvPc50AZfJ6ElI3s9L9gzCPvam3D37ZrrOom8fJ8hEBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceWcxheo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A11C4AF0B;
	Thu, 22 Aug 2024 10:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724321496;
	bh=bgYDPzutrzDAr5YMb+PdbaWy4xjt/hdjmclU/iDKrUE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ceWcxheoWDtnYgg985x45KYHmTV5oTZOhKwraHXxGsy7HTP/LFIFjnC+DwVniTqn8
	 H9NLuDZQpjh7YacHZqImBYeAZnE+rF0cfYudqz8zJqoSrpRhX8WmarquHOz2Py4QLj
	 zQr5vl8E/qDbXcfIX9QO3tbOBRlEKYXcWIwNoOeXWow7xY7Y+qlnXCDUsAuTAYGU+p
	 K7KyFiW9gpb8deb7VLWaLfyUA2HoCeihoZFeYgskdcVZZqgA7TSshA/cRJj6VdQxeo
	 t5qcNJQ/64y2HlAwdHZdSXDcBv8VqXqZSHcPOs3JsJ+pj5mGYq7r19JxSqh43KsZWh
	 ukcVCqbEnRwBA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, tzungbi@kernel.org
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20240819102326.5235-1-tzungbi@kernel.org>
References: <20240819102326.5235-1-tzungbi@kernel.org>
Subject: Re: (subset) [PATCH] mfd: cros_ec: simplify cros_ec_dev_init()
Message-Id: <172432149544.1248859.6275161639600844545.b4-ty@kernel.org>
Date: Thu, 22 Aug 2024 11:11:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 19 Aug 2024 18:23:26 +0800, tzungbi@kernel.org wrote:
> Simplify cros_ec_dev_init() by the following changes:
> - Get rid of label `failed_devreg`.
> - Remove a redundant space and comment.
> - Use `if (ret)` instead of `if (ret < 0)`.
> 
> 

Applied, thanks!

[1/1] mfd: cros_ec: simplify cros_ec_dev_init()
      commit: 70596c588adb5344e7002086d78ab5792d7d1069

--
Lee Jones [李琼斯]


