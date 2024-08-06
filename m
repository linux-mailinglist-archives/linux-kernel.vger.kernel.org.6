Return-Path: <linux-kernel+bounces-276260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F248694914E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0CE282911
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A031D1F59;
	Tue,  6 Aug 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLrWJwni"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763C1EA80
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950785; cv=none; b=Hf/ZFd3jNKbJecRkIIR7PVvp1EqAU5bQSxRg/orZkAbP38P0ezV8rsXg5WcBIFj47bTaMDpMoVezB+S9d/lqwte5oGdHTpzyoaXNPm++RuTfL7rHmwWDiFCBr93u1IG71/yDzteZL3xlSUmyaLB2kb3c9JiMteAkkjXQ8WuE4fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950785; c=relaxed/simple;
	bh=bpW6gr4pw4V8ugoxEp30eVt/fRQwYnE2NOY5lty9K/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A7L2ck1dPoHV1j4C0Njp/N4nj7H4MXyKyTMuLZpJWWwp3z6klWXFlY+Ac7lcLrbDaJPZabZNUrcuEu7wZvBSjszMiUNUYlkjPaXUEss8xpgoM/wjzgtBZzYvmzCCBkfAiTWpti8ksEQsqOsoAfXxWX7GKR29lFGHbDijnMoRs6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLrWJwni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADEEC32786;
	Tue,  6 Aug 2024 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722950785;
	bh=bpW6gr4pw4V8ugoxEp30eVt/fRQwYnE2NOY5lty9K/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XLrWJwniOqhfwQy22MWoiAryKK3YqSsDhoaLdd1YmEqYDkrSSE9GU8FYn00FE16RK
	 xn7/08UGv5/g5hP33Y2YnYdryYEFWFJ+JgBfjmW5j3vxP3TyPgFGwzpomj+jn07bCk
	 YaLHghyfawpJ8TgbCkceYGsT7NLYNSI/BWBzBCEkOnsGj0Nf3h4t/57GC72BCgNvHG
	 grpHNi+hBv6HmDNfyB5t8Tq91eeR6zAPBBZewfu1TP3YUOXj2m9z1F8jYoE2cdwOAE
	 pc5JYkkvBuVydAf7ai8qHwYZHgBQa93L27mwBsJ60HOogwwnG9+RCLq3AtJKp3FiP8
	 MeqGj9XeSuz6g==
From: Robert Foss <rfoss@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240701-lt9611uxc-next-bridge-v1-0-665bce5fdaaa@linaro.org>
References: <20240701-lt9611uxc-next-bridge-v1-0-665bce5fdaaa@linaro.org>
Subject: Re: [PATCH 0/2] drm/bridge: lt9611uxc: require
 DRM_BRIDGE_ATTACH_NO_CONNECTOR
Message-Id: <172295078214.1812660.11522667072788670082.b4-ty@kernel.org>
Date: Tue, 06 Aug 2024 15:26:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Mon, 01 Jul 2024 21:19:51 +0300, Dmitry Baryshkov wrote:
> There are no in-kernel DTs that use Lontium LT9611UXC bridge and still
> require creation of the drm_connector by the bridge on attachment.
> Drop support for !DRM_BRIDGE_ATTACH_NO_CONNECTOR by the driver.
> 
> 

Applied, thanks!

[1/2] drm/bridge: lt9611uxc: properly attach to a next bridge
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/7c5537cee9a8
[2/2] drm/bridge: lt9611uxc: drop support for !DRM_BRIDGE_ATTACH_NO_CONNECTOR
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/7b6cf6c750da



Rob



