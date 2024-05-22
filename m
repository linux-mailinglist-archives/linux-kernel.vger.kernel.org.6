Return-Path: <linux-kernel+bounces-186202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6CE8CC109
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB927B23765
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A3813D608;
	Wed, 22 May 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWutsMvz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314B27D3E0
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379999; cv=none; b=eTUnQTLtkPOnnD6b6dM1dwqNXQYOiod/H31mEvV1nBaikDy1Xq5roMWHMlGeMnQaclYJN5fLc761twMN1CUx/vjZUMVZgtc8gjK8CEiaEEiqSFcGiMvgI+obVS30Ci5andyCVv3pRnjPFrzJddQZEEl0U28sP5h+VargsWZBCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379999; c=relaxed/simple;
	bh=Gr+/A7/ijZDQDz7elG8jrXwS23bISKQ5Fsa85hruja0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m7u7CFsMzy3IgIFIOpAbjHztYG6Xn3KXReIDkz+ebvmMsOtVXH8Gci3ltJ6WGlBr8iz293Em3WNmLIYjKBzjURcvDgS1fZgf0AWQ21fbvujKxiW+6W600DBGd/Xi5m910JN+ykj0pEfkSxdXlZm297NiGoS3VK5wcGfsNResC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWutsMvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27394C2BD11;
	Wed, 22 May 2024 12:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716379998;
	bh=Gr+/A7/ijZDQDz7elG8jrXwS23bISKQ5Fsa85hruja0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=mWutsMvzZUBTtqxqBX4RetMNkhaTTqzjlefCaYJAuPvgodzDZXQ/PkYev1wvXFbND
	 ca8sdJCoPETdGJ7iV6OuJyo+P1drtBOcfLv1k6HKTRmQyWmEeHL0j1FLzJbeAtaPng
	 oNen5q2As4+IfplhJMYDH7lASkVtUHX7XZX6xnXoU8Zm2ncmU4MAvP+Ov4F8QYyMQR
	 cf2EodStPBHiIYiJtcJuAq5AeCo8bMNDDscLRxE3MSW90R0XdW0fZ09Tm7UJR1S6be
	 x2fDatp3bqTgGKMU6PtbtG6VtafDYNnM5kWp/m1j+dp/uM8Pl/jFvZfwiHiVY91cyy
	 q74M1J4k1hyXg==
From: Robert Foss <rfoss@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Jonas Karlman <jonas@kwiboo.se>,
 Daniel Vetter <daniel@ffwll.ch>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Allen Chen <allen.chen@ite.com.tw>, Neil Armstrong <neil.armstrong@linaro.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, kuro <kuro.chung@ite.com.tw>, Kenneth Haung <kenneth.hung@ite.com.tw>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, Pin-yen Lin <treapking@chromium.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 open list <linux-kernel@vger.kernel.org>, Hermes Wu <hermes.wu@ite.com.tw>
In-Reply-To: <20240522065528.1053439-1-kuro.chung@ite.com.tw>
References: <20240522065528.1053439-1-kuro.chung@ite.com.tw>
Subject: Re: [PATCH v13] drm/bridge: it6505: fix hibernate to resume no display issue
Message-Id: <171637999486.1598011.4983921044000498146.b4-ty@kernel.org>
Date: Wed, 22 May 2024 14:13:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Wed, 22 May 2024 14:55:28 +0800, kuro wrote:
> From: Kuro Chung <kuro.chung@ite.com.tw>
> 
> When the system power resumes, the TTL input of IT6505 may experience
> some noise before the video signal stabilizes, necessitating a video
> reset. This patch is implemented to prevent a loop of video error
> interrupts, which can occur when a video reset in the video FIFO error
> interrupt triggers another such interrupt. The patch processes the SCDT
> and FIFO error interrupts simultaneously and ignores any video FIFO
> error interrupts caused by a video reset.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: it6505: fix hibernate to resume no display issue
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=484436ec5c2b



Rob


