Return-Path: <linux-kernel+bounces-292168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7ED956BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59254B2715E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E91170A38;
	Mon, 19 Aug 2024 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdN2v5mv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB70916C86C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073795; cv=none; b=DxwgRO4jXUEp0so25OJV0bL4+fFu2RpJjmkPaqmjqep/DFo+SVlHmh0Q0oIeozALD5bLt4kPVnW0QUrJz/DFEW8A2r6I1kA1hRAdNEYpiFC9BZKHpP8Ie5sBGR1Qj750Xp2Rtb7aByqHBXTp6r849hVjkYpmvdF3tXksZ8TvTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073795; c=relaxed/simple;
	bh=Y78tMoSTvQ5pNGwRl2U9/ONE47YeR8ac4eWLcVpfmyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mptx6JVozy+xufjJ8dwhra1X037syHuBtBsa+nROzCj7vP7L4DKvclAYkmUwvlDrDFnVbQVJs5P4Nv0DYUwfsj8J/nVH0FcrUxJmtcKIz8G4TlbtUx7dauPjgiAYgXrIiGv6tArBqLS2Y0ZEg0cr55MLyDwhs4LWu/qePYE3SS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdN2v5mv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649E2C32782;
	Mon, 19 Aug 2024 13:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724073795;
	bh=Y78tMoSTvQ5pNGwRl2U9/ONE47YeR8ac4eWLcVpfmyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jdN2v5mvPoMzJ2Mrq4zyg+244b5eL/21q5l6Bxd9jzYSLw9NlvnJfw4QIG0eGqBJ2
	 iSdiHSd3nkjWEQajTcde5woUCqz1p8U9DfUE0AwuzkTGLB0Mw1fMARY9iXhINxSjnX
	 qaxo95QG5asi8X4Rbe8TL/fQGX3KhN1E0+sgKLTTecBC2HxFNcvZumIBhp10bYRmsh
	 kSohoyNBxtA161PbcUnVktDicdQVi0VDiIkSLIZIl52f7bt1xyOW49unrR4OG+8tgL
	 w7d2DYvdLJ3f/Bphcntf3Nb14ucZptDwKs1C/m0JwWuZjBXkSHSEpFII4QxNTu2Y8F
	 eiay9p1Aq/P5A==
From: Robert Foss <rfoss@kernel.org>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Liu Ying <victor.liu@nxp.com>
Cc: adrien.grassein@gmail.com, andrzej.hajda@intel.com, 
 neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com, 
 jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, daniel@ffwll.ch
In-Reply-To: <20240813091637.1054586-1-victor.liu@nxp.com>
References: <20240813091637.1054586-1-victor.liu@nxp.com>
Subject: Re: [PATCH] drm/bridge: lontium-lt8912b: Validate mode in
 drm_bridge_funcs::mode_valid()
Message-Id: <172407379209.1397922.13488425635790063899.b4-ty@kernel.org>
Date: Mon, 19 Aug 2024 15:23:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

On Tue, 13 Aug 2024 17:16:37 +0800, Liu Ying wrote:
> If the bridge is attached with the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag set,
> this driver won't initialize a connector and hence display mode won't be
> validated in drm_connector_helper_funcs::mode_valid().  So, move the mode
> validation from drm_connector_helper_funcs::mode_valid() to
> drm_bridge_funcs::mode_valid(), because the mode validation is always done
> for the bridge.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: lontium-lt8912b: Validate mode in drm_bridge_funcs::mode_valid()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/fe828fbd8778



Rob



