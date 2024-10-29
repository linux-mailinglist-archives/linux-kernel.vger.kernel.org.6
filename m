Return-Path: <linux-kernel+bounces-387690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4779B54B3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94512841B2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E6F20721D;
	Tue, 29 Oct 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX2JqPLk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B31D3207
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236068; cv=none; b=DyQtsuDEui0J/pbkQ8oV5Eqnf6dbWNQOy/RlEemtxpy21kQcOHhHDSa6OAPT5BxvG3fTnCm7nKisI1bqzFZQBxaApGNJH8h4DarhPovc6ozIMvXNepp2IdjpJRVkSFiQmX084vvb1Z/e4NpUswlZSG3tGeUtF/Y5euMGYwJHq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236068; c=relaxed/simple;
	bh=e6THEqLuryUAEjOAmZVpeKc69TqrxSmB9069AO6oeds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ecnKqpvKBMQM5aoH3Cy3yWRg5/xO2TDE6fHDqqtUixDJzPlf5BkYX5gjC3UG7uBBKTLEEXCvq48OCxcPXAr4Wgfg5naBh18ZydhWRw6bopnMf7q1/JySoLNPsdjiyNKr/YG0skvCuhJvnPtoxMC99RHtyJLxW6zSTXFMNfufhJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX2JqPLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7184BC4CECD;
	Tue, 29 Oct 2024 21:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730236067;
	bh=e6THEqLuryUAEjOAmZVpeKc69TqrxSmB9069AO6oeds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VX2JqPLkki4vYc7S6Q88G3DwLAvXyPyt8cW2UkDZt7VJLRjUw41HUiXGYYBjx9hoh
	 IG4zcVg5yiNOAUHIxouQAeyaNLaBbS4GLNU4DlKwT+Fbgd2rxO9O/mAoLCnCohgs9n
	 uhntfkx8xt9aLS5KRSsJHU7F5mGU+S99R18tYwTmm9yQ/OiFv6fft+Vc3iFymfNCLk
	 iQJlwiA4H50eCeZkcU4PyVEjyMLQxNO+6FxShvvKE2wBCz3xri4CDgMcUt8DgZR4HL
	 sC5vXHi0D/BK4+9x/wAwfUvREW/gy8jCH7fffeIQ9g7PyA7bW77JGv8HqFYJDIpaf4
	 kQYb2/PVZPzMQ==
From: Mark Brown <broonie@kernel.org>
To: Cheng-Cheng Lo <locc@google.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20241029081941.3264566-1-locc@google.com>
References: <20241029081941.3264566-1-locc@google.com>
Subject: Re: [PATCH] regmap: kunit: Fix repeated test param
Message-Id: <173023606719.179218.11325012064814139935.b4-ty@kernel.org>
Date: Tue, 29 Oct 2024 21:07:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 29 Oct 2024 16:19:41 +0800, Cheng-Cheng Lo wrote:
> There're duplicated elements in the test param real_cache_types_list. The
> second one shoulde have cache type REGCACHE_MAPLE.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: kunit: Fix repeated test param
      commit: 96a54082424dc9d430076563031d9b576176674e

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


