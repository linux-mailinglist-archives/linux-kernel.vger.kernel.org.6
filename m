Return-Path: <linux-kernel+bounces-184112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15098CA2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F031C212CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE3C139587;
	Mon, 20 May 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqhHYiKQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3A7139588
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233234; cv=none; b=Tku7wya7GsjI1L7Y9qU2AwIG5xcxnyx3EmXwDe7+pkdvPrl/WJcSejd+Aqov/IbI+l5LzwK865uhhcxLqegobpGecmCU7keEoZYGsPqV/lehUioP3aGwJy09uIqeQpCTudEiRyuYMZgBh7M5rm+JMHejGFIyp9ZtWY53WVAd9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233234; c=relaxed/simple;
	bh=2TnMREiRIAIebGgTkLzHrsGe9BV1po7cFaa8eIolCVI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KlqJSpk4pfccIltt+6aBEnT/4NMQxtNidEftW/lGyGXuHFLciOvt0BeTSZjTZzSekGF5K7I22FfKLU719qKSdioeeWNp9GqRqOhB5S/a81UiCRB9aV5DH+C8fB3Z/k5Jv2hxQh1TnZvcRwaNFsq7swBA9BUurB8LLtg5sfVIQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqhHYiKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16DFC2BD10;
	Mon, 20 May 2024 19:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716233233;
	bh=2TnMREiRIAIebGgTkLzHrsGe9BV1po7cFaa8eIolCVI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IqhHYiKQYX4qNcIZCqN6+WS5oXtqo4c3TZ89YK82kNnsHJC9ma9L/Uyvv2d7NjXZy
	 GFemFybXYvCdT1hlg4fEnHKdxHVF1WvOIj/741gYUNBMofyBKOfgBe1ClggNTakO3b
	 LExPSp0hFrv10QTqoZzvYKOCGIXuDqzi1ya9nYr34tqc0nOcbHz5lRmX9CmNM6mexI
	 3vd9AnpiP3WI7GrzRnkN9QZKI0vs63U286WM3iXEnwUmw+H78wiyYwpiES0E1f2qR2
	 Yl0JvNVlGqu890d/YnfJTbc+VCDQSH5EbKy1eB+b3eBOhCOx/+6LGFkfnSlywCATYe
	 W5TwyFzWgNb4Q==
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <ZktCpcGZdgHWuN_L@fedora>
References: <ZktCpcGZdgHWuN_L@fedora>
Subject: Re: [PATCH v2 1/2] regulator: pickable ranges: don't always cache
 vsel
Message-Id: <171623323257.94554.15001762747135346135.b4-ty@kernel.org>
Date: Mon, 20 May 2024 20:27:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-621fa

On Mon, 20 May 2024 15:31:33 +0300, Matti Vaittinen wrote:
> Some PMICs treat the vsel_reg same as apply-bit. Eg, when voltage range
> is changed, the new voltage setting is not taking effect until the vsel
> register is written.
> 
> Add a flag 'range_applied_by_vsel' to the regulator desc to indicate this
> behaviour and to force the vsel value to be written to hardware if range
> was changed, even if the old selector was same as the new one.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: pickable ranges: don't always cache vsel
      commit: f4f4276f985a5aac7b310a4ed040b47e275e7591

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


