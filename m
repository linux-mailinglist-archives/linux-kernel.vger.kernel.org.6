Return-Path: <linux-kernel+bounces-189974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7B38CF7F1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E6A2814C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ECFDF60;
	Mon, 27 May 2024 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTlhTC7O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2D79F2;
	Mon, 27 May 2024 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716779226; cv=none; b=S0pmqZf2p7ZLTOUGs5/Nm+8GrKc+4SVWEb1Nm8J2tg4l6TK/3gawVWzhHJpTGKE+Bpd64DY27krnRg/vVIewtKZT2RMMz3DugGcjkgL5aB5ttu0vJclFBrdvxoFByQk2DFdfcWMsoFfTIM1OltB8+hTTbjkMojxc8qgxxTeU58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716779226; c=relaxed/simple;
	bh=V0pcoxiScDQe0zi5pcugxdyFa3kNMUT0YjglHWD7vvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D+2XwrHc9/Y9lXOCq94spHChGJgtPiKClMQ4GELig7JeoSRBS0hURUbrInepFjAi9tBncvzvn1hpURzf0qc/vde9I4EID1WrA3GmpY5dGRcTn8+hxjwgzhzJFm3BfG6EkAsxExX9vLJzE7KJsT8cOK3t3/b/3Vb51XkN844PfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTlhTC7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3F93C4AF08;
	Mon, 27 May 2024 03:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716779226;
	bh=V0pcoxiScDQe0zi5pcugxdyFa3kNMUT0YjglHWD7vvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sTlhTC7OsK22UDnsIs9n0/tAU9EjpKKUDsg8PQl7qbEvR41N1JDkNDDxYEEcR2nJ0
	 BQveAiPLIg59AY9GnhoZy1Wdwgc8aEv+8BGhDv18l45JgLlySi2VgHp9pAr8CRqDBh
	 9mktd0xh8O4m/02wsj11btazwYnZCMkPdtTFjrXI75ocBslFULWD3D59vy5XTNrS4K
	 LVWI5xacBLKo7TkFc0wdSnaCcYac8N/SQFaiVZacJNohMkb2OchAU1J8l/wIDUmU2m
	 k7fVoEsdOpVnnfouWqnPEH/4WcQEcW93l5cyciuGGHti0vfBqwYy0huealRqI4L672
	 kL4iz1cyMR9vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E35A3DE4000;
	Mon, 27 May 2024 03:07:05 +0000 (UTC)
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
 <171677922592.1901.1875168136657939730.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 03:07:05 +0000
References: <20240417103819.990512-1-wmacek@chromium.org>
In-Reply-To: <20240417103819.990512-1-wmacek@chromium.org>
To: Wojciech Macek <wmacek@chromium.org>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
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



