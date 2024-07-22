Return-Path: <linux-kernel+bounces-258615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FD7938A85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEAB1F219CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C935C1607B3;
	Mon, 22 Jul 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="nXy1SW5X";
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="Ua19Yot6"
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3401607A4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634967; cv=none; b=jlUx6PqLIqaWZcxFnK64Yw9s5BiWbz+TIZUf4SRqniVLFt9yZAx5wNAfqQsI1mdblC1iyp9JvLmltKORUPeAI0X5kfb6xIGip7biP8isqzGQzfRlHFmLOMjZ12YGanOq4yN9iaVYdpmaNhwkGQaA2qZdlmW0vT/dhxTCRU0C0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634967; c=relaxed/simple;
	bh=sIsoIaEC5q4HVUj+ZnhPfTbfbDCCvrTzn9RJcdcWQUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cgija9gBWgEdYVl91jx9eA2Y57OCcNPiqeW86Si9265xDWofTCdZn0mcwnWpQQ/COEsjhsrWCm5KnmPkjw8uUE8hBJhZD+RvXDNklguofTppOQ2Ft+3/AE9Z6cLRxB+LAqkeo9KPT5o9000RpR5pJRrUDkEXBFxukHhaZ6ptXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=nXy1SW5X; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=Ua19Yot6; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1721634358;
	bh=sIsoIaEC5q4HVUj+ZnhPfTbfbDCCvrTzn9RJcdcWQUw=;
	h=From:To:Cc:Subject:Date:From;
	b=nXy1SW5X0ni4nNdvSDr4LN3qkl4tEaxu9//KIrzRGqH3K+Tr6TglKOknJxdX+X9lL
	 6JvBfDpcVljpQASsR+fRcddyJlKO4vRpewF1H2VEEeG2jhQJlUd0zfyi+KtR1/imzU
	 KUtCORpu4+UVHZjothx6breyp/sIu7pdD62I/KBGymkIoGQ3b3+fqmLJ2tXDpM7i7u
	 ef5/fTwBRznNPk7KP9/vT5bSqXMtT+vJSmVA6ela2y9+hFwubyTAaVYs7phNcPogyN
	 lELjCG2uHWHVcJg+pT9DFPTT2NYQ1xeJbC8KQooZ/kNPrQG+JcRbjs1HKhpZTsg5el
	 cWU/wd8MFEfenNI84ySDTXlracjPPAVyk5ecYuzJvOeadrBWL1xtuAOzzOBjMkJG20
	 PGVDYukO9nNIktvepipfpHSjrUOv8o/D1broCd31Y/m5cSaFNasbE/f/OXtlUIoBTx
	 jS6gg1J7IBS5GM0PKrZsXcHNmKThubmylPm3ezz0rS9daj+e2mn/mTSsgN4TY5Z71i
	 8E2t6uSpCmQfxWqaqMn00HfES5KPSlIjXBVz1ng+Svb9i560PK0jJyBu7OMwuegHJ6
	 a0WrCL8JMVTJPlq/SyImjAXmbZNOYNcjmj4fQc3pbXX1TRW8u9lMN1Atg8n7LrPbNT
	 yee5tCX1E9YTCyqVgB5nKUQM=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 09AD11DBB82; Mon, 22 Jul 2024 15:45:58 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1721634355;
	bh=sIsoIaEC5q4HVUj+ZnhPfTbfbDCCvrTzn9RJcdcWQUw=;
	h=From:To:Cc:Subject:Date:From;
	b=Ua19Yot6XTtFZsoc06vjBWA6nh8nCIjfjBldirI1IlLivXLtPf5rvPoKkL2AwnDhd
	 l9gaB9eEcwjC2vTkjhOG5JNcMUV1MOL24pcf4TV6Pltze5SlZkZDZiY8B+9R7YiBSr
	 dunv6f6NiFG18aWxfjpbiZertqef+BD4LAO5J/kyMvl9OgeH3Q06NepUmom/8TET8z
	 wHB1YDOSzvfK2zxjyLsInM0HPLDmhHssIvkLiU5YwfQ86pASMji30h7lGS6hT/Paq6
	 +48xJ/9s/k3tDnPvQUMVFlRru3Hi3k0O+jvB+3eihEWktIR0Sb9RGijf/8AmkGrKwR
	 ksFutMtBvPd9iIRaO5MoZeRPOBKnxbTOulrlmbwPZ4z+7JARYsgFRSDLIjR26t/bx7
	 6VPd6oUJWfNMAN7u0khwjivEfUCBuoFYDKf2L5HUmAoT4VR1r1yX/GycJWJagzp3QZ
	 krg1N18B5ZqQeYuwPVvDv6BLWxsJEu7W0OJP5Ktcy67nrl/Jt8MZLgdkGlrMImiiCx
	 A2vFS9fB4YAny2qO7x15aANA7wgFV9KOurGCYYNjQPLCCGGI6/Pboz8s+9UFHx+o+F
	 5t6OGvxJhoawV6w93iTXPH0anXaFIB8FKIsGRlUz+0AyXK0c/+8zzWWOmrZje2uXZW
	 zqN7Wgj571uR0aGN34o+/V5w=
Received: from sparky.lan (unknown [IPv6:2001:8003:8824:9e00::bec])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 1C2881DBB78;
	Mon, 22 Jul 2024 15:45:55 +0800 (AWST)
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
Subject: [PATCH] drm/i915: Allow evicting to use the requested placement
Date: Mon, 22 Jul 2024 15:45:38 +0800
Message-ID: <20240722074540.15295-1-david@davidgow.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a78a8da5 ("drm/ttm: replace busy placement with flags v6"), the old
system of having a separate placement list (for placements which should
be used without eviction) and a 'busy' placement list (for placements
which should be attempted if eviction is required) was replaced with a
new one where placements could be marked 'FALLBACK' (to be attempted if
eviction is required) or 'DESIRED' (to be attempted first, but not if
eviction is required).

i915 had always included the requested placement in the list of
'busy' placements: i.e., the placement could be used either if eviction
is required or not. But when the new system was put in place, the
requested (first) placement was marked 'DESIRED', so would never be used
if eviction became necessary. While a bug in the original commit
prevented this flag from working, when this was fixed in
4a0e7b3c ("drm/i915: fix applying placement flag"), it caused long hangs
on DG2 systems with small BAR.

Don't mark the requested placement DESIRED (or FALLBACK), allowing it to
be used in both situations. This matches the old behaviour, and resolves
the hangs.

Thanks to Justin Brewer for bisecting the issue.

Fixes: a78a8da51b36 ("drm/ttm: replace busy placement with flags v6")
Fixes: 4a0e7b3c3753 ("drm/i915: fix applying placement flag")
Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11255
Signed-off-by: David Gow <david@davidgow.net>
---

I'm not 100% sure I understand exactly what went wrong here: I'm pretty
sure the patch is correct, but let me know if the commit description is
way off base.

My system works much better with this applied, but it's possible that it
could work better still with further changes: the buddy allocator is
still chewing up a lot of the CPU, and there are still cases where this
notably affects performance (though, in my experience, these are now
'hitches' rather than multi-minute hangs).

Cheers,
-- David

---
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index e6f177183c0f..fb848fd8ba15 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -165,7 +165,6 @@ i915_ttm_placement_from_obj(const struct drm_i915_gem_object *obj,
 	i915_ttm_place_from_region(num_allowed ? obj->mm.placements[0] :
 				   obj->mm.region, &places[0], obj->bo_offset,
 				   obj->base.size, flags);
-	places[0].flags |= TTM_PL_FLAG_DESIRED;
 
 	/* Cache this on object? */
 	for (i = 0; i < num_allowed; ++i) {
-- 
2.45.2


