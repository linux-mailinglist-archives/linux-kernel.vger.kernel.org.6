Return-Path: <linux-kernel+bounces-208379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995B0902442
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41490B25898
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96638132121;
	Mon, 10 Jun 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pf9Q43yE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9E480BE5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030447; cv=none; b=FZAT2umZllvU2jRzvk4HVa/j54RoaUq2BEcwL47yCJ27GLIx4i0tYJV1NAf1ZwPs3339ofQe+ctip0y3JCYPk1Ep0Xq9hSP2dKisDs+IgbzsMfb3OyokubWxYef96RELG6k6Z0zMy9+xkXNWHlGfu/ixX/NDvAa5trRJWYGCc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030447; c=relaxed/simple;
	bh=yc/dwowaEYBTvrkdMBgKRZV7SmYF1J4czz7n87U4ih8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rdY6+VNHosvqKcb6pI/8opzdL+Mzexbso0i2f+EiEonpVR529BRTwb++fWlcAFFLao7HpqosM7sRMquqN3eZQdFOj7jN+REeqSgLNzrJ5IoH8ilmOvKnKKeZvbO4qG8QuxRc77PikOfMqmBIQSYRKobVzhfoB3J0rMGYpKvPiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pf9Q43yE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CACC2BBFC;
	Mon, 10 Jun 2024 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718030447;
	bh=yc/dwowaEYBTvrkdMBgKRZV7SmYF1J4czz7n87U4ih8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Pf9Q43yENLzdGJDmzw/qCpmJPBmOO5LmQbIHwiY1YxeHCQb7XMkTnDGJjAh7dxjSb
	 lCc3htCCUi9cr0cltuQ7sW0zr39CBtI/rmS6YnQQLbR+CZkooiqfehK/barUsAvAkq
	 UCQDqT0T51fYru9lP3qKWAH9j6AZGlAh06z4/xjqzDukXXNs2w7yYsHWj0VEC1ahz7
	 CDCIVz4hbhIOnjQSH6viozgyWG0E2S6Jx6zmFQfNGIKKUz9a4hmqQMtLw9YX4fa5hD
	 Nx7Y/uMwMeBZB6DXCjFc1DPIuzyYLEnQ1BuojNTD5qF8+pz7E6AfnVO3GYwJSZYrZP
	 Q1yvgngXUE4nQ==
From: Robert Foss <rfoss@kernel.org>
To: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, kuro <kuro.chung@ite.com.tw>,
 Pin-yen Lin <treapking@chromium.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 David Airlie <airlied@gmail.com>, Kenneth Haung <kenneth.hung@ite.com.tw>, Daniel Vetter <daniel@ffwll.ch>
Cc: Hermes Wu <hermes.wu@ite.com.tw>
In-Reply-To: <20240604024405.1122488-1-kuro.chung@ite.com.tw>
References: <20240604024405.1122488-1-kuro.chung@ite.com.tw>
Subject: Re: [PATCH v1] drm/bridge: it6505: update usleep_range for RC circuit charge time
Message-Id: <171803044399.471764.13517934474897792377.b4-ty@kernel.org>
Date: Mon, 10 Jun 2024 16:40:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Tue, 4 Jun 2024 10:44:05 +0800, kuro wrote:
> From: Kuro Chung <kuro.chung@ite.com.tw>
> 
> The spec of timing between IVDD/OVDD and SYSRTEN is 10ms, but SYSRSTN RC
> circuit need at least 25ms for rising time, update for match spec
> 
> 

Applied, thanks!

[1/1] drm/bridge: it6505: update usleep_range for RC circuit charge time
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=8814444e62b8



Rob


