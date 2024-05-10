Return-Path: <linux-kernel+bounces-175421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588758C1F67
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BA71C21679
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B45C15F3F6;
	Fri, 10 May 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rc8csvL0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24215F321
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715328292; cv=none; b=hhxVxUSNhljqefnxWFzxOUN91senIYUbEwEKi5Sx0XgyVgY11VooHf9f30Qaa5GXdNczNW8+9wRY+To3aqknVRkJYv2dhLF0AxILVssejEcU/9JBG751i3UUXEpd+uOZ9bQyNosQ1QqpEVqLGypIORsJNDpzQxQELYmrHefPPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715328292; c=relaxed/simple;
	bh=NTWQV8utlMEfCOAQgZ2Ys4MM0viNvXW7Auv8Tvj/nrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KwDT47HuSGRbotfErXz5no6rf7u6sYU09rfflUyCkOxV0QmabNEjYTrH0/hjJHj4BphDz7GsauFUPbKewTtckcpthzyjp/Dn2huLVfb868dPdyIGhjIh499yLqwJFMvQbDlBfYfW8OjsMf5GeSk8CR5fC+1yPhGHOHuScAJKc24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rc8csvL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3533EC2BD11;
	Fri, 10 May 2024 08:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715328292;
	bh=NTWQV8utlMEfCOAQgZ2Ys4MM0viNvXW7Auv8Tvj/nrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Rc8csvL0dZJCS87H7IBNkVQKO5bBSDn1ygDnEoc9nTNpbj1fp7OTerzVnq4T0bCPK
	 TM+nuNRREc1zshzbL6pSWQtAQ4Ns0qHNQKCGWsPB3f3xujdj9gKCq0sgnQSk74zkDo
	 ElwGAs/u79UqnaK54UgZvsK3gE92ZbGKo7QnSVP/UqNoRtpHRiUEboX3vUusA8Owou
	 tLRzJMnTkLAOoEfFZ8nwUZRUlzMWRngjSP8EqzYtW9rLpo2nGtVIl2Lhc8gesrWLKn
	 U1Hrc657g8n3msWlOuesIYrpEXkVB5a+7DpgSTUUgycrK4LeqK/t0eyzAd/ligPZd1
	 x0dDuZRhU0ybw==
From: Robert Foss <rfoss@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Neil Armstrong <neil.armstrong@linaro.org>, David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20240507180001.1358816-1-sui.jingfeng@linux.dev>
References: <20240507180001.1358816-1-sui.jingfeng@linux.dev>
Subject: Re: [PATCH] drm/drm-bridge.c: Drop conditionals around of_node pointers
Message-Id: <171532828886.1578080.11788819313522587297.b4-ty@kernel.org>
Date: Fri, 10 May 2024 10:04:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Wed, 8 May 2024 02:00:00 +0800, Sui Jingfeng wrote:
> Having conditional around the of_node pointer of the drm_bridge structure
> is not necessary, since drm_bridge structure always has the of_node as its
> member.
> 
> Let's drop the conditional to get a better looks, please also note that
> this is following the already accepted commitments. see commit d8dfccde2709
> ("drm/bridge: Drop conditionals around of_node pointers") for reference.
> 
> [...]

Applied, thanks!

[1/1] drm/drm-bridge.c: Drop conditionals around of_node pointers
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ad3323a6ccb7



Rob


