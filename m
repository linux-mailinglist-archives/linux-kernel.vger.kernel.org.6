Return-Path: <linux-kernel+bounces-273776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3EC946DEC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 11:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F91280F25
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 09:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721EC2261D;
	Sun,  4 Aug 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="IZqO5DHA";
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="Opf364Oy"
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E78D20DC3
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722763571; cv=none; b=BZelh0/9od9t2AgoMc5EcIkmPWFYIRafwppPIu+/FT4u3Ey8nlmsvpJ3l82jSpGhhfSjdqIt4H5fWERt4ZAw5MNy7Ryg27GoWlTvlPHzywDEaVTrp8YPx2AoTAW8z120LqNT0gUbo8u/YHio+lT2kdDHbzigD7U+FvYdGXJx0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722763571; c=relaxed/simple;
	bh=PUNtupVBkgdPaBkzwexADnKJVGtpOaVaXYTKNh/eqqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tnp3PrYTYiQHzgHC9eECh2M/GCOyb8R063eXlA7DrkooyYfzWo77+al1QkDlDZgWWmrJwDeWpHTz7HeOzt/QPJdQCYw14LxrWwUs8Fdi+TRzRjqoZFMp3uZxE9QKDCSF3VGXR01NjZP2LlASW7teW5OzZu5X7EgvxskWgg8/MXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=IZqO5DHA; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=Opf364Oy; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1722763156;
	bh=PUNtupVBkgdPaBkzwexADnKJVGtpOaVaXYTKNh/eqqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZqO5DHAAFf9tB7gHeSE6uGHFaV2B4b2HRTH74KOgrtIEQnCoN0cP9muXZf21EwIt
	 gIGmD0E7srCvZVp+lqWEqLfTbAfvnI1/+uiz4ES/0XK0HpasQydBgTPv9THWsc+hr/
	 pYqSg4sTVxP3visP+q1nDkS+OQbN+yfy4gjj1kIG0rLjvmdURKB8GGkwcy4UwEWWzK
	 ZS3uzPnPsxyzxGcENyIx++KORTGQbEXM2U/nsSdpJcdSBFLEkj4gODBf2Jnan4Q82m
	 p8Zt5RhBfHodUTDE1EyuAjvxhLk3q0Nm1gM7PZjiplvYy6y2n/yz2j6XArWQqqYxyz
	 NuIaj80WIPMaQ2hecJq9Hu5nM9qH2wsSDdVWJU8W2gzSomvO4Ql2zPtK7jYXitVV2A
	 sCO6VB/36y53YXaUBLRcLH/rG0mw0LhcnofjqpaENKqRMKwpAPr4A9x8bnir+VJadm
	 KnY5Xv5+6oQl74jD3RrFuajs+tpmqPZf/rRZ7B+Xn0ciBqcFNpwX6x6KXs1s3vgD4I
	 SryhTL5UKQqJezwk9VxTpBN/9WX/sOE/ueeyv0qiQM7ZvOLGGK2RDh1KJWNZ1aBHo7
	 uq+xTYmfBHZ1GXyFMKnaeZy2JO7O9sf+OFHxQouVtHP8AAYIdHLjwV0qWpRn61I+IN
	 V61CBmr9/qsyro/Xbdiktlq4=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 64BC71DC09C; Sun,  4 Aug 2024 17:19:16 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1722763150;
	bh=PUNtupVBkgdPaBkzwexADnKJVGtpOaVaXYTKNh/eqqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Opf364Oy1QRoUGbBsugeKctsO8VhOkTXLClJwlSx61qOgfSHEStTNrlHLU5cMIbfo
	 6IEYAdAOsCYS7/hoXXPNRD8raEEdVxtIijDjLEzFP7rlDbwG/HNaV0j5zK95aC5aH5
	 yeQG7nzlf+A1jl9o8OpWTzF5rqY8/TaXl9dl75L85AtUhcg0xG8iQu7osvMT6TXRRk
	 QjSUacWDd3uBwdl57teCOQin6CA+lFqtMmr8Ip6AMMHrZYAmueE/UHqN1Nwkbf+zsr
	 CT8YJ3V2zfuo1iKorZZwT1u4+YzPbUxyQsevzowJg5gBatF775JDJPNP4nnepmX+op
	 RDVRMHDqO1VvgHazy8UWllt4JYNroz+9xzrmBbbZ12H/yTMHxPG31/xpVQQ2HawtI3
	 6z4F5cNRiqGrDAFfB/+KzN9xXHgLkjvYfR/E1aFb3h4Z/j8GP8ean6P5tWMm0nup3v
	 zZH0CFsiF4RGoOfvyL2JraoB7vCRpD5ec9l3xBwEj2uSnKUQwx0u/mfLj/s2c4kYGU
	 xxmDnTwUk646X5vaShNWRRZvtLAyNQDr0Wug9nc40GY3v+czD/X+tcC24TPu2ilybB
	 cXetXJqbxzi59hLtlE4NNX+VsQulBytz7DmpOQF59FwOd1p1vCJS/LAm9NFPEJOSRs
	 JxRFBoqTuL0nG+CUodZsfRUk=
Received: from sparky.lan (unknown [IPv6:2001:8003:8824:9e00::bec])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 9512F1DC093;
	Sun,  4 Aug 2024 17:19:10 +0800 (AWST)
From: David Gow <david@davidgow.net>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Gow <david@davidgow.net>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/i915: Attempt to get pages without eviction first
Date: Sun,  4 Aug 2024 17:18:48 +0800
Message-ID: <20240804091851.122186-3-david@davidgow.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240804091851.122186-1-david@davidgow.net>
References: <20240804091851.122186-1-david@davidgow.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit a78a8da51b36 ("drm/ttm: replace busy placement with flags v6"),
__i915_ttm_get_pages was updated to use flags instead of the separate
'busy' placement list. However, the behaviour was subtly changed.
Originally, the function would attempt to use the preferred placement
without eviction, and give an opportunity to restart the operation
before falling back to allowing eviction.

This was unintentionally changed, as the preferred placement was not
given the TTM_PL_FLAG_DESIRED flag, and so eviction could be triggered
in that first pass. This caused thrashing, and a significant performance
regression on DG2 systems with small BAR. For example, Minecraft and
Team Fortress 2 would drop to single-digit framerates.

Restore the original behaviour by marking the initial placement as
desired on that first attempt. Also, rework this to use a separate
struct ttm_palcement, as the individual placements are marked 'const',
so hot-patching the flags is even more dodgy than before.

Thanks to Justin Brewer for bisecting this.

Fixes: a78a8da51b36 ("drm/ttm: replace busy placement with flags v6")
Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11255
Signed-off-by: David Gow <david@davidgow.net>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index fb848fd8ba15..5c72462d1f57 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -778,13 +778,16 @@ static int __i915_ttm_get_pages(struct drm_i915_gem_object *obj,
 		.interruptible = true,
 		.no_wait_gpu = false,
 	};
-	int real_num_busy;
+	struct ttm_placement initial_placement;
+	struct ttm_place initial_place;
 	int ret;
 
 	/* First try only the requested placement. No eviction. */
-	real_num_busy = placement->num_placement;
-	placement->num_placement = 1;
-	ret = ttm_bo_validate(bo, placement, &ctx);
+	initial_placement.num_placement = 1;
+	memcpy(&initial_place, placement->placement, sizeof(struct ttm_place));
+	initial_place.flags |= TTM_PL_FLAG_DESIRED;
+	initial_placement.placement = &initial_place;
+	ret = ttm_bo_validate(bo, &initial_placement, &ctx);
 	if (ret) {
 		ret = i915_ttm_err_to_gem(ret);
 		/*
@@ -799,7 +802,6 @@ static int __i915_ttm_get_pages(struct drm_i915_gem_object *obj,
 		 * If the initial attempt fails, allow all accepted placements,
 		 * evicting if necessary.
 		 */
-		placement->num_placement = real_num_busy;
 		ret = ttm_bo_validate(bo, placement, &ctx);
 		if (ret)
 			return i915_ttm_err_to_gem(ret);
-- 
2.46.0


