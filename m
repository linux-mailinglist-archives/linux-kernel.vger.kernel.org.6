Return-Path: <linux-kernel+bounces-513451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF98FA34A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4581892CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97D1270EB4;
	Thu, 13 Feb 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9joyma8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEC3270EA0;
	Thu, 13 Feb 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464212; cv=none; b=aEl6yKSot7nf+msk0xJd71evIBCSbqa79sRIctEyMO1f+mjJJp7Ui23U+egxaoffb+rZXaAnpDUwRsT5r06PWv4Nis+2xpQYC/Xm5p+v2+ziy+f/kMhoXYvbBPOJJ36YTlgyvfDDIuCJ2TpJn3gCvAAFAdTZAipNK9RXECTuzqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464212; c=relaxed/simple;
	bh=8QpDcZE+APUsYKXJBDyaQSBRggWWhSlZEUeUv4tuXYk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FaJn2Gv4xXVqUhwBU5b6wo2UhgkZCtddg9TlN9ZJkG2J3EgD5tyGS/b9rleNQJWZ4xycRcvZREOj/pA4KuSaGYp/qlJj/kOW+wxO/jvfPcjRG6ohT7MEa+1rEFaSk1YGXZOK5ivY/5WjCzUImWTn+daXpp7+5rv37/iACfxzPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9joyma8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7277C4CEE5;
	Thu, 13 Feb 2025 16:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739464211;
	bh=8QpDcZE+APUsYKXJBDyaQSBRggWWhSlZEUeUv4tuXYk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=R9joyma8gjOe+/PzXClgFb+oUJk1vODRcHlZmI2XLhL1R4Aw63SRwmVYMVPH4QumV
	 fortxFI1i+mg/5ZujKaZL+glNS4NBBcS0jTWKgu1bVRnsKExEwYBTn9nFq6vwBrLcU
	 iRapJdMC48D8METYqKub5B9XvK0+H4iXVr1usKotG8AgwI/5Cqse6erwXcRifiirb6
	 cHY62vx6S67An9yrny9KddaE7JY+lR4HVf/6yoygAMvbSboYxc9cm1ycZg79K/VeRh
	 9hXD19voicR3BNg0It038iD/GhgxoxU00B9o4/78qZE8OyjkpsORp9jmU5TCO1wo9k
	 zMON+WbQUSfpQ==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Sanyog Kale <sanyog.r.kale@intel.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250114200726.969501-1-krzysztof.kozlowski@linaro.org>
References: <20250114200726.969501-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] soundwire: Use str_enable_disable-like helpers
Message-Id: <173946420957.270661.16264499406247931837.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 22:00:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 14 Jan 2025 21:07:26 +0100, Krzysztof Kozlowski wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> [...]

Applied, thanks!

[1/1] soundwire: Use str_enable_disable-like helpers
      commit: 836c8a2edb96d78de6f00b60d6d8e24f2ea87e57

Best regards,
-- 
~Vinod



