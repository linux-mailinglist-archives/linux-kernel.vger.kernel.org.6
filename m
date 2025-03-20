Return-Path: <linux-kernel+bounces-569795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A92A6A7A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282D63A8DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C42222A0;
	Thu, 20 Mar 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDxILjp3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B173221F25
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478613; cv=none; b=gJV1YuM7v4xCbVWapuS7hix0UZ822Fbs5IKUl9uOPb5JygwPgK/3dx0vO+bysKMGo0xgSep001V3yPAV3Wep0e9w7J2QyGgWw5nYM7KG8jiLxywsyyeIohXnoxJve1fTxZ4QQ7hajahzCq3hlbPWzWO2JaKJZ8AR+sbI/jjZgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478613; c=relaxed/simple;
	bh=BJPegLawj4uPq+KzjweLJYu58/cHqaWL/lpgD3gMquo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4oyn97VtVL4dll4ZMKG+AZytcVM7SSZrr8PhY1MTOC0uTZq5xiedIKA+T5KWkPrW9HhqPiEaF05tV2xD2aD/6CHDSE5aGNiRA7XmaoiM8SXW7nHsvQF6YQq7dMpPqfgLZjfBXyWikw31S99OyLIgQg+Goch0XBAKd5Pne1Dc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDxILjp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9706BC4CEDD;
	Thu, 20 Mar 2025 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742478613;
	bh=BJPegLawj4uPq+KzjweLJYu58/cHqaWL/lpgD3gMquo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDxILjp3k0HiTKJciXKC2aQN7EIyH0hg7Jre1+L3SpC/OF2DZAukNh7VskYqMifPy
	 aAIcq7DWEBJM4gCTApBQGRmIcCzn/x5viuuXjnuQr6LVSntEFic7eH+D2pRrBZo9VZ
	 8sS7+KJoTfUjuIbmKT+zsmTVTHz7+YTbqk+h64+Vrce30DLwj5uNvAIvDx4mliuZl7
	 HyB95ZQ3XzMQmvXFLImSX37nmw5zhZolVhnkGXiL0aKbpJoN9AD1WP9ykooMnc4Pkg
	 XC8j1qVVrztmWOz8wOvmgS4cOPsfgIunbDHntvc5vTOegx/wN4KKgtD7T5OLU82dEW
	 F73pA7ehgXAwA==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Simona Vetter <simona.vetter@intel.com>
Subject: Re: [PATCH v6 00/16] drm/bridge: Various quality of life improvements
Date: Thu, 20 Mar 2025 14:50:07 +0100
Message-ID: <174247860591.84994.742849930325234742.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313-bridge-connector-v6-0-511c54a604fb@kernel.org>
References: <20250313-bridge-connector-v6-0-511c54a604fb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 13 Mar 2025 12:59:54 +0100, Maxime Ripard wrote:
> Here's a series of changes after to the KMS helpers and bridge API
> following a bunch of reviews I did.
> 
> It's mostly centered across providing an easier time to deal with bridge
> states, and a somewhat consistent with the other entities API.
> 
> It's build tested only, with arm64 allmodconfig.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

