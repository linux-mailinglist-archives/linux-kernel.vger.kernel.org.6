Return-Path: <linux-kernel+bounces-208047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6D1901FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E593D1F2150F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E1A14D2BF;
	Mon, 10 Jun 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3OHPHQG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4612A14BFA8;
	Mon, 10 Jun 2024 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016371; cv=none; b=lAo7qX3Trym02CxlSszuE4ZyuV2dSRaewlrR3517sePB4Xal9Nkumzs37dvTukdpwWUuzpKdyPbCMjZmM7FFqCEa4uz1QA1hDdnWVTjT9dZWbmsARqvhVH+Evs20Br5WgWQTyLVHTsrUn6qYj0yw/Hg2ddphUAhStEtAgXLDwUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016371; c=relaxed/simple;
	bh=RohZKedQ8hCwuKle3kQFh2lbTizbfj4MBLXRuGSRmRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kyn8c7sYTvGUbWZ9gSCEH1tsPvuIbq4vkkbp7S8oirr0cI6RIgAmytjyCDYAMgb+onjFRZWhLmCP+c9obIECtaNGVV/VERpQ90JyTnT0WODOCce5tpvNH6lJkCBKwPkmv1cCaUkpLNwY19i+f/DUIxSDNdL/4ogk4qd9WkpHv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3OHPHQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CBEC4AF55;
	Mon, 10 Jun 2024 10:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718016370;
	bh=RohZKedQ8hCwuKle3kQFh2lbTizbfj4MBLXRuGSRmRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J3OHPHQGBrYfPeQOOtj4IP5MiWBphZe+qsdqv3lleSov7MH2WxgFpTkL9PVN7sPoT
	 fTuN8K0eTQATNSv/okqHfaDloiryZtOPhpuZBjfBAaUpc/x9Dh8r/CAkeMysNrk1ez
	 /ochIONg5jGcJj11/yTnf48DuSKPaCN9Hmsu49gITXlIjnd2Udydk6wxvg63wkcJ4V
	 b/lWVQo+5aPaJ9f9g/6LHlilKqsf25g7P0PJoYSn72a9n7BB0/7PDgoWD0+WsNZrNN
	 7gyrce364V7+DaYpbkT7LYYiP4GJmkOxfhznfUu5TgvJ0KUp1BN99pJ2KyRCtxK984
	 c62U6qSjheVkw==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, 
 Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dave Airlie <airlied@redhat.com>, 
 Sean Paul <sean@poorly.run>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240609-md-drivers-gpu-drm-v1-1-89e9a316d513@quicinc.com>
References: <20240609-md-drivers-gpu-drm-v1-1-89e9a316d513@quicinc.com>
Subject: Re: (subset) [PATCH] drm: add missing MODULE_DESCRIPTION() macros
Message-Id: <171801636830.423417.18054042484903735990.b4-ty@kernel.org>
Date: Mon, 10 Jun 2024 12:46:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sun, 09 Jun 2024 11:42:53 -0700, Jeff Johnson wrote:
> On x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/gud/gud.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/drm_panel_orientation_quirks.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/drm_mipi_dbi.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/i915/kvmgt.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/udl/udl.o
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


