Return-Path: <linux-kernel+bounces-443707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DCB9EFADF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0C2289330
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C8223316;
	Thu, 12 Dec 2024 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr9sr5GZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A070222D72
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027970; cv=none; b=qKpLf3nH8s6r1t4TSq8IJlel+5YedTSa6EAZE0qhki9kHd3Ao3zjTypB+N6ABBsKrnJMYG+ZqB5qGjpQRz8txS5tIi8/Y8PIgGNGnLvEFzdfQIPV/2HpKpmah3TzYcDzwAMreWl+fQz6VeZ1uFubD2R3pmpGA8qxSMCBmMQnins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027970; c=relaxed/simple;
	bh=RH12guya7hHkRqMA1YIPRNRE76exB6tD/Q+lk8aumJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n0fZLCBkrFRadwC/X4tw9MN8dZEBSwr/2HrHPF4AWS0h47uMk/9ZVwpLT/9zr73oMTwXj/5tlr+gSzd5ps2u37ljzEMy+MmZe6Xeg04iCk3Ej7nmm/Co0gahEC6t/8XsKGHjk2oOo3EkSc/GrrEbWlrQs4kCdaUCb9Cc/9EzEBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr9sr5GZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29FBC4CECE;
	Thu, 12 Dec 2024 18:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734027968;
	bh=RH12guya7hHkRqMA1YIPRNRE76exB6tD/Q+lk8aumJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qr9sr5GZeXvITeqIvJy+HDqV3VEPaW6MiJAkoNXGVgixQYMeJLc28ah4yOMt5Q5CQ
	 YWc8T9Xt5VeOd0tQ+CZ9ajJIfFK7n6SKKxRQqy9ZCkU68Gv2zrhPlXPWl5sFB9wIwZ
	 UHceclgzw6d/IfzT2NN74lMgGLE3dL1qjG+3A+1rQtCo7eS4P95ytV5NAKbIw0IZbv
	 6Swr3B/ThrD3xQNhBC0+lkjnxLk9jarfssQj7HSeN6U9Cdz/xgc/fhNWnOzj7hW6UN
	 2lbmb8B6s5/ZyXib0YDVGddAfTtmoqL4Ww3NRHPn4KLyLQxelaH09YySre6EhyYPrn
	 Bnyt2ZzOpvLhg==
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20241208150028.325349-1-hdegoede@redhat.com>
References: <20241208150028.325349-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH v2] mfd: intel_soc_pmic_chtdc_ti: Fix invalid
 regmap-config max_register value
Message-Id: <173402796741.2350874.6904270916195670392.b4-ty@kernel.org>
Date: Thu, 12 Dec 2024 18:26:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Sun, 08 Dec 2024 16:00:27 +0100, Hans de Goede wrote:
> The max_register = 128 setting in the regmap config is not valid.
> 
> The Intel Dollar Cove TI PMIC has an eeprom unlock register at address 0x88
> and a number of EEPROM registers at 0xF?. Increase max_register to 0xff so
> that these registers can be accessed.
> 
> 
> [...]

Applied, thanks!

[1/1] mfd: intel_soc_pmic_chtdc_ti: Fix invalid regmap-config max_register value
      commit: 1e19ff6d7ae149d933d0a6fbf09f6977c516b198

--
Lee Jones [李琼斯]


