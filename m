Return-Path: <linux-kernel+bounces-211111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E1904D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530E42851ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A8B16C6B2;
	Wed, 12 Jun 2024 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCw/Q+Ks"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A69216C69A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179026; cv=none; b=AgTZHK58oO+2ULII/NkrIXsE/DG0LKqN4qvC2wxPsc1QlxNfUCCd4lGhvQo4OPnyNGvjRY7J0zRW6MNsZxpyQWoFGxdasEZqDZAxnpqxcycGyJQhMGltEZWkTJjN7lZb1Pj2xzDv6+2TdLQih8RJzZQFCGJekzbT7ipAUHaey18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179026; c=relaxed/simple;
	bh=hESmEHrQk7WtxKynr/6hcy4GMsBs6FznD7ZDEnXzOqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6/UVyZULDTxTC8wBZKHWDwKOxzwYOMTicWsvjHI/ZSpXTZYs/k4h3Sfzpk4+F6XAqyiPuRM4dOj3Z3gbFz5L8gwHSlBj4yDbs/2eXn8rLMm74zT6nslPSrESNNyxXtar3o39VDIjAQHRRWT7IhtFoNNSMt6Y3+Fi5dx4i0rsQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCw/Q+Ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955CAC3277B;
	Wed, 12 Jun 2024 07:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718179025;
	bh=hESmEHrQk7WtxKynr/6hcy4GMsBs6FznD7ZDEnXzOqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCw/Q+KsYXtgn/fPiS76aWlM7QL+2rbkPu2yKxx35dexv6Lv+6l2LUysiI38vX3BB
	 Xg3MqkGpvtDom18PuFoW68C8QU2J0EYMFOliXNfuXTPzWycZmErA9cCKg2Cqcfck3c
	 WfdZqZN0RtNAEfvbsUcNkQ38oOUtFucjri3wZFoZxKPhK0gQAv/v25YlHkI2nMbIPk
	 Q341ZJdXEmFJwKGFC4t3YNEUOInpFeJNKMrhx0C/WWMGMq3p1fpY8EXO3V0SQ0tSn7
	 vtqqOElOkUObCTrFTzyjU/5hGBWffuaN9iLQknLnH8KIVp0MhpwIfwWoHi7yYCy/f3
	 QU7C2lCnYZBQw==
From: Maxime Ripard <mripard@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Douglas Anderson <dianders@chromium.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: (subset) [PATCH v2] drm/mediatek: Call drm_atomic_helper_shutdown() at shutdown time
Date: Wed, 12 Jun 2024 09:56:59 +0200
Message-ID: <171817900323.766520.11311110578010469430.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611102744.v2.1.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
References: <20240611102744.v2.1.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 11 Jun 2024 10:27:44 -0700, Douglas Anderson wrote:
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
> 
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart comes straight out of the kernel doc "driver
> instance overview" in drm_drv.c.
> 
> [...]

Applied to misc/kernel.git (drm-misc-fixes).

Thanks!
Maxime

