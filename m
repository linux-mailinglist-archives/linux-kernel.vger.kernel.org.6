Return-Path: <linux-kernel+bounces-194333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD588D3A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE98D2864FB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1BA17F39E;
	Wed, 29 May 2024 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAy1XNia"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A217DE30;
	Wed, 29 May 2024 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995400; cv=none; b=fDNgzM6yj1NUAzZ+FE8AdgRiDYQoAUs/IbJAHxvsVfBv1c3RP6ICX8O/ALwDdIsbGxQQzA/wCQpZmILiVyu0t+T81tG141hoX3m9UV7jqDixWNrbFc74wSkZQum55E9yi2OgtTy9iEH2vKGtZYPRia5yDXG7YHBWaklP6QuG29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995400; c=relaxed/simple;
	bh=Xhb3zJFmFfGlU8AJi68kSsih9jBID7aB32p8Q47N+Oo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WBpbSHHWK+o948ZQl+JWcBK9NT/YDrMcwv7MDl/t89cPaYfR4UifORWEdpGMoXRXFRbEsU7ifJD+AdB9RuN5zbxXE7QRdF1Wmr8XdqGrakGrHmxUEvFq8DqzH+b1B2BJCb4ISDyy4yDohKVgyyxiiHMwjmQ/zo+dGC5DzKOb4hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAy1XNia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B379C113CC;
	Wed, 29 May 2024 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716995399;
	bh=Xhb3zJFmFfGlU8AJi68kSsih9jBID7aB32p8Q47N+Oo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fAy1XNiaqdFHRcQjhbDjF29KzwVn7lKBIldDFYUzYuNAIXqqpkxIyXMEdmdjXnD92
	 1oQgLo4yTsEVa0Qas3rHTAzCd0NBxyc7aE6dv9O8COmPRIg4fKmxfPdMgHDRLtcXA9
	 aYOk3retWoghQ6VGbESChBFNjqK3KkeBOnY2CsbeHKZFxJoPbk8VQQ1vrOOBB5CWcD
	 PqB69C2xALgXFcSoMex3114vwzsUZB0BfUxIw460Q6ao5IW9itfCSBFJ+kbyY/Dnk3
	 rQVTE7WMij3VndgU8lqJ7KFdMaQIL7Jxrfiqk8ij4K1+PzQSEYwpnvWgqgSYV9Au8+
	 R+Llv088MhBfA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Alina Yu <alina_yu@richtek.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 cy_huang@richtek.com
In-Reply-To: <cover.1716870419.git.alina_yu@richtek.com>
References: <cover.1716870419.git.alina_yu@richtek.com>
Subject: Re: [RESEND 0/4] Fix issue when using
 devm_of_regulator_put_matches and add compatiblity for both fixed and
 adjustable LDO VOUT
Message-Id: <171699539775.117971.10350524168531143563.b4-ty@kernel.org>
Date: Wed, 29 May 2024 16:09:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-2ee9f

On Tue, 28 May 2024 14:01:12 +0800, Alina Yu wrote:
> There are two types of LDO VOUT: fixed voltage mode and adjustable voltage mode.
> 
> As the fixed voltage for the LDO is outside the range of the adjustable voltage mode,
> the constraints for this scenario are not suitable to represent both modes.
> Therefore, A property is added to specify the fixed LDO VOUT.
> 
> In this version, a software bug has been fixed.
> rtq2208_ldo_match is no longer a local variable.
> It prevents invalid memory access when devm_of_regulator_put_matches is called.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/4] regulator: rtq2208: Fix invalid memory access when devm_of_regulator_put_matches is called
      commit: 72b6a2d6506843375c7b91197f49ef38ca0c6d0f
[2/4] regulator: rtq2208: Fix LDO to be compatible with both fixed and adjustable vout
      (no commit info)
[3/4] regulator: rtq2208: Add fixed LDO VOUT property and check that matches the constraints
      (no commit info)
[4/4] regulator: dt-bindings: rtq2208: Add specified fixed LDO VOUT property
      (no commit info)

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


