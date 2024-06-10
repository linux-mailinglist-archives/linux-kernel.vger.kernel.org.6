Return-Path: <linux-kernel+bounces-208084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8237C902071
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08CC2B23508
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DDB7D3E0;
	Mon, 10 Jun 2024 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAihqqsn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3664F2594;
	Mon, 10 Jun 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718019453; cv=none; b=RKuZ/8use610S4Amfu92a2yS7LfIsmwEZCQmwisQVuztgXdZJORCX56iVPGgJNtB6VpP7D2pD/+lESxa6Foh9dqLuq0sDtQJgLkTqRn2I2cgdAhCTGdUAYu9XOYKDJbTDvlhrBUKE9LVQwAaTd+Mv1yoHTFKeJC5JvVxye1OJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718019453; c=relaxed/simple;
	bh=W5QzFncy0sUTy2B+uXEQTMtsMrR22hJS0osVxJ7jZF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GMsNmxpON5dyGJU8nhR8HEBiXVlD9RCJ4YDwfmxu7A5RaQPwMir4GG9uoHy8qoOFG1X1xbHdVwsezwYErqxeGJxaEPbFSP2kZedkNEMyh8rD1oSy745vqKLy+u8CwAH4WRqfwhG8QJ/XIhlKA19WmYhNc4YEOFezOsBwCa9zIiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAihqqsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA96C4AF1C;
	Mon, 10 Jun 2024 11:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718019452;
	bh=W5QzFncy0sUTy2B+uXEQTMtsMrR22hJS0osVxJ7jZF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UAihqqsn0XnGRCucJWFCNxmRvk8TZlo++RhoqeW6SiLXJW3f/EIFyyKSJUNWNC9ak
	 /Iq6ALFJZhvYeOIa9kh24gOnK3/HCqMMyFldZQSrSjjhYpYCB7XOYzr/wUC8PuQ/8w
	 c99nxitWMQCtKSJj2K/FXdI+hbKiNYCWIs76EfqAzhFX/DA+mFBzbF687jJARrHRD5
	 +fsOLl43LeJCWZPGEy95l7d5s6xLw0/ibmN2a2lOEiMRD36izWJo1qx7ic5KQg6dMz
	 EbCW8a0Wmke49XVE3Iots7qdCl71BlQ+QPqg+pC5YD8Ary1mROmWlBgjHJhvU2k0FK
	 MyGxsWuojx2wg==
From: Robert Foss <rfoss@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 David Airlie <airlied@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, kernel-janitors@vger.kernel.org
In-Reply-To: <6c8c6746-34e2-4a97-9dff-622ed29071e9@kili.mountain>
References: <6c8c6746-34e2-4a97-9dff-622ed29071e9@kili.mountain>
Subject: Re: [PATCH v2] drm/bridge: it6505: remove unnecessary NULL checks
Message-Id: <171801944880.382402.4293639602145071155.b4-ty@kernel.org>
Date: Mon, 10 Jun 2024 13:37:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Mon, 10 Jun 2024 13:50:26 +0300, Dan Carpenter wrote:
> Smatch complains correctly that the NULL checking isn't consistent:
> 
>     drivers/gpu/drm/bridge/ite-it6505.c:2583 it6505_poweron()
>     error: we previously assumed 'pdata->pwr18' could be null
>     (see line 2569)
> 
> These the ->pwr18 pointer is allocated during probe using the
> devm_regulator_get() function.  If CONFIG_REGULATOR is disabled then,
> yes, it can return NULL but in that case regulator_enable() and
> disable() functions are no-ops so passing a NULL pointer is okay.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: it6505: remove unnecessary NULL checks
      (no commit info)



Rob


