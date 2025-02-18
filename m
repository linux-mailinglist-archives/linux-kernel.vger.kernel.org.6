Return-Path: <linux-kernel+bounces-518812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E575DA394F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5499E175908
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98444233D87;
	Tue, 18 Feb 2025 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbO+c5W2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF37522C352
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866466; cv=none; b=O877ukWaar+giC9R/lX9J2zvWcBNNYz/qadLJ4pWSriDLrAGB6JETP+dRBTThQd8lJ3Uvcx76XZe4weWiQ/Nb4MlxFWK66WvnKIIUxHLBFcsjZo5QCPYgI15bSu1yfklVing1kC8B7EoZQf8r1b9CcaDRXZhqWuSL8vbUlw40JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866466; c=relaxed/simple;
	bh=sK8OvyySumMdynSgRGKgZrd8TTS4U8uKw9PAHIAk3Nk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PCvRCcWK4uQ4ZDaW33HCRZBDXK24eqa8Hcygomk3RN5GUzqLimClTH6GLcHE2jrUcFPGBU5h+vTVPCyDUC0t/J8oaX0QJS/PHqVLYuQwcB013zRsd6sg0gKl8aHYLJqUijHF2kv68Vdbr7sefOBSlP08t03V14lSFqspJw7odC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbO+c5W2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50A1C4CEE2;
	Tue, 18 Feb 2025 08:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739866465;
	bh=sK8OvyySumMdynSgRGKgZrd8TTS4U8uKw9PAHIAk3Nk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AbO+c5W2a24zWrFd5vgoqYvGkVnewmOK06KO3xgUWlJxlgZ77vB+Qj40jFr+veER+
	 EffIu3gs1hoykD6InX2z3Crz+23eojDl74vcfDijznofFjJzl4QXJ1qWOfuw++BL6X
	 6CmFz5fY38hEmMljy/JpAxwgrdGU/wrRAq62/PEy0e1ppWLQUcIEX2U2fWPfarqC9U
	 1MK0XSUkiffveOsH7LC85lGQG0YK6gGb4ydi5sZivqTI/pDmYDD9+cG91c5iLOeYNe
	 baZzG0KBrQ9z3WpguqmAok9WkK7pK/cabMa4s6xWmOkQAVuRX/8CNcWrSjll/Km93Z
	 8rASBGHGWRwdg==
From: Robert Foss <rfoss@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, oushixiong1025@163.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Shixiong Ou <oushixiong@kylinos.cn>
In-Reply-To: <20250128065645.27140-1-oushixiong1025@163.com>
References: <20250128065645.27140-1-oushixiong1025@163.com>
Subject: Re: [PATCH] drm/bridge: analogix_dp: Use
 devm_platform_ioremap_resource()
Message-Id: <173986645947.826953.17434979178193947426.b4-ty@kernel.org>
Date: Tue, 18 Feb 2025 09:14:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 28 Jan 2025 14:56:45 +0800, oushixiong1025@163.com wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource().
> 
> 

Applied, thanks!

[1/1] drm/bridge: analogix_dp: Use devm_platform_ioremap_resource()
      (no commit info)



Rob



