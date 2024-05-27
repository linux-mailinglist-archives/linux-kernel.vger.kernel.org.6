Return-Path: <linux-kernel+bounces-189942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A728CF782
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8502812D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 02:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D47C129;
	Mon, 27 May 2024 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0dezIaZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D701FAA;
	Mon, 27 May 2024 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716778511; cv=none; b=LCWkWepT+bCPLt4Ij6HoM3mIYVyuDnxxez0rQYtVvBU43bFyYa7UaJyOze4vlQXpf1/DB6imtIGZieASiD4RomIiFuhqv2MFLTvzHdBjDsw2j00sIeUK1egePpglS+yxtYWeflkcMpO+ni96srQVnFZBHLIf/oJwNQtD9AJu8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716778511; c=relaxed/simple;
	bh=39qO4ArV4WMkI/+MoaGYnazaqANez7q1UTHks9np4s8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C139/x+zJJhf6iFl0BU6gu5qwlJzA9q7u9bNy1NaYxm7jVO3TBRf7bZt3HuZvt2v9E+tqbVQOnOS/b/DVFkQcyq4+QNi/P+MtRU5SfPgZfr2eAInxMTctI9KGQOYiAys7XkJnBAfh25LEASRWcrmhAVo97Q6p29A2JUhnRud2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0dezIaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 297E9C32789;
	Mon, 27 May 2024 02:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716778511;
	bh=39qO4ArV4WMkI/+MoaGYnazaqANez7q1UTHks9np4s8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q0dezIaZxlrFzGX+kwhj2Y2qgdgxgguKN499Jh6AowH8IHeJppEuw4g7xqZYAYgo4
	 G6jUAAyLWCEVkfsD1mDJANpVjyLnmRrtZ1eU3E9kpfsI0eX1WgAGhz3mESO/wstYxW
	 KlXPs9J3jsrQJzoXpOpH/QHieyH1dbeIGfY1v333StXkq31ugdlHGSzYvAQAkP4yg4
	 RFj9WNzlbshlmUt3F7cb2b24HyGrIagt7+DfXiVHUgmWb5CUxpW9qjgd4L1Gb/FQo6
	 z6/h2XYMLL8Ql4Xq45fK8WJpGmfFeZVXW/qU8OADaNbi7VhNG/thDKBeU77W2mZxyF
	 PJefczsOXHIPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13421CF21F9;
	Mon, 27 May 2024 02:55:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] drm/mediatek/dp: fix mtk_dp_aux_transfer return value
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171677851107.1901.3212994325646956148.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 02:55:11 +0000
References: <20240417103819.990512-1-wmacek@chromium.org>
In-Reply-To: <20240417103819.990512-1-wmacek@chromium.org>
To: Wojciech Macek <wmacek@chromium.org>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Chun-Kuang Hu <chunkuang.hu@kernel.org>:

On Wed, 17 Apr 2024 10:38:19 +0000 you wrote:
> In case there is no DP device attached to the port the
> transfer function should return IO error, similar to what
> other drivers do.
> In case EAGAIN is returned then any read from /dev/drm_dp_aux
> device ends up in an infinite loop as the upper layers
> constantly repeats the transfer request.
> 
> [...]

Here is the summary with links:
  - [v2] drm/mediatek/dp: fix mtk_dp_aux_transfer return value
    https://git.kernel.org/chrome-platform/c/8431fff9e0f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



