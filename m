Return-Path: <linux-kernel+bounces-208048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B311901FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921A42857A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D43514E2E3;
	Mon, 10 Jun 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDevtlI6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF07CF18;
	Mon, 10 Jun 2024 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016373; cv=none; b=qe3nKFRurZ9BzsKBdPUJdJh/GHaEw5pmmlbHvdZDzbm68PQJdY9Uif+e2HGBjcbql52aWEdyUUIPm88pXZZEaPGn9K8vYEbSDn2CUSeIS2YyFzrK9faQzW7jDpQ1zVWUdtdkBiMwXlKQJoE0Is/tRpmYHV7nvc9aDnysmn9G5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016373; c=relaxed/simple;
	bh=OZzw3rDNyqrxI631FqQQD5pS7djLOOM/VvVOVFyL/VY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KHwkExVYnjQgtpEpyeWfWvKCbPfztuREjS2tHCmABxOuC1On2Nd9z63TuAxRxGnEg0OVYad69VaYkfxpiHUq8Y8akv4lMxwdLrJRWjvfFXwH0RsBAAZ5ldZgQxN+t+3Lpn0sg89HIkojuTTZ4RzOM6XjMF0ehwD+4UzCj5hvsWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDevtlI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B652C4AF1D;
	Mon, 10 Jun 2024 10:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718016373;
	bh=OZzw3rDNyqrxI631FqQQD5pS7djLOOM/VvVOVFyL/VY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XDevtlI6JD74OBfchpbh+8zzEKDrgzN9aoAfVnpqzS9XW4Psx3ne4gakQBAhBDcLl
	 qDDg/CmpTz980hYogxSjYRHzITXgrMAiGG7bGEfy0vlOVh5ni8pHxqJMLRWedstj++
	 c1dnlHsQpQUa3vYwP1cf6vIzGSbZk5xXw5uhykbF1zOjnDvHL7xnNvWhX4PWkQbjhM
	 6IGt9yyctZnfAU8aC2CvGYZ/vC7qoswO6vM4n/0wB95h/zU4XvIaa7j5/zcOujRaeq
	 nIVOD95yXUvWoFn2Tf9E1yDaO9HOaMft3aNaFmXyLa0+WaPe1l+L8ZXQf8Wbt/Hu7k
	 EP/Y+Xe3+firA==
From: Maxime Ripard <mripard@kernel.org>
To: linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev
In-Reply-To: <20240224150604.3855534-1-megi@xff.cz>
References: <20240224150604.3855534-1-megi@xff.cz>
Subject: Re: [PATCH v2 0/3] Move blender setup from individual planes to
 crtc commit in sun4i-drm
Message-Id: <171801637114.423417.15912541590264684056.b4-ty@kernel.org>
Date: Mon, 10 Jun 2024 12:46:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Sat, 24 Feb 2024 16:05:57 +0100, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> This series refactors blender setup from individual planes to a common
> place where it can be performed at once and is easier to reason about.
> 
> In the process this fixes a few bugs that allowed blender pipes to be
> disabled while corresponding DRM planes were requested to be enabled.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


