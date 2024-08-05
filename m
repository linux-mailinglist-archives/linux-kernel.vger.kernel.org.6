Return-Path: <linux-kernel+bounces-274960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A3947EC8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113381F22E5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E03D15B0EE;
	Mon,  5 Aug 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAw2sutK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D4D14901F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873376; cv=none; b=l89RxCXZjLaG7NNMKHFyKzPn4Pk42TTnLdO9keBFyTybyUPaTwMATH9BUhdEdPxuTbSQqrY16jNV5RI1hq1V+hgWfP2wSMHla83yPNIXS4q8itd2gsyHZeAEjnkMON0Y4WWoa1YIZSdq1gud4aeD2RooxqlXo9p3PZEhShwIjVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873376; c=relaxed/simple;
	bh=Vpt/ybgnwc0Kk+7tqfImpVn/n05UCcgeQGqDaHdPQpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LTOOTyHyVTUYmUWV1fQXbxTZlC3qrnPKaJpfEIoiPtxvBW8cyZRYQqabzHZY08Sbenll6HPmph30ZiMYuCElnA6ZT4IGwJ3BgFvX2xKueWrYT59Z/amWHUcC9NCnbCjal9meJ6m/JFkTDSiTktBG+CElTvDEXwrpEgVChdBlSsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAw2sutK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD094C4AF0C;
	Mon,  5 Aug 2024 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722873376;
	bh=Vpt/ybgnwc0Kk+7tqfImpVn/n05UCcgeQGqDaHdPQpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FAw2sutKqC3jWi4C9/T9k7ltP9qmXfbsJtfu6a110Gt5cMwqYoT6CXCbTrhcMX7Eo
	 eULP5z+gs6fmjTwfpvReusu95uWAg5/zI0/9LMj7h/ZrMEcOI/IGyUjUg9OkLis8Gc
	 zArIm0W6QGzVS/IYexlobdmcrZs+TFBWsqkH9J8kgUZuFNdgahDCbHrS1cJzb5m6tW
	 gwBVJ2GgzAAj+JXkBKMOHiRjm+nvGyWzttRhP7QEiiiKbH9q+BFyP4TP44F5EftmSa
	 tTBgT8kZwKEaVgra0sggxAiwro8ZkiKHS8aMbh4pf9OmsNth/hiqpL36yrqdCJHxr4
	 VOEeAXmj2lHWg==
From: Robert Foss <rfoss@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240711-bridge-connector-fix-dbl-free-v1-1-d558b2d0eb93@collabora.com>
References: <20240711-bridge-connector-fix-dbl-free-v1-1-d558b2d0eb93@collabora.com>
Subject: Re: [PATCH] drm/bridge-connector: Fix double free in error
 handling paths
Message-Id: <172287337262.1723177.5901681466214656738.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 17:56:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Thu, 11 Jul 2024 14:26:55 +0300, Cristian Ciocaltea wrote:
> The recent switch to drmm allocation in drm_bridge_connector_init() may
> cause double free on bridge_connector in some of the error handling
> paths.
> 
> Drop the explicit kfree() calls on bridge_connector.
> 
> 
> [...]

Applied, thanks!

[1/1] drm/bridge-connector: Fix double free in error handling paths
      (no commit info)



Rob



