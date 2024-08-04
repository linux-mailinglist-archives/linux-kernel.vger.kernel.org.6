Return-Path: <linux-kernel+bounces-273775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2611946DEB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 11:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7471F21706
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 09:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75070219F3;
	Sun,  4 Aug 2024 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="ASNlvdi/";
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="QIGm0K3O"
Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E75C200AF
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722763570; cv=none; b=heE5IXHWIcu+fdN1iArYE1KkMbH6FXF04xMxLERJl/2VudQKzztRrlpDaGS+aSc7ygnWVpXW23GUHi6CL+fjeQy5qjmbLSZT8R068bd+U/mGIw7tdc2KO3T72BEFSdfpEv3u0rF/7zZwomVsOfEKz4PVW2xmSkeThkFmDJgxxv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722763570; c=relaxed/simple;
	bh=GTfJG1pVvOlhqeRhPSZ2jJbhnESq6sDdGs2cv+XUfw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kc2hJSkQruVHktNNVXbTu303DWfsqYtnay6D0/Wk/kQ0uJI41gst8pCJktrhqvOSpMZUCE7VOJNGYv/UMelMFucpSZS+G6+S/2OMPtd10UyMzuBJEzSHGhBKQUBizul5hD7sJgwUDIQG3Vg8RoT3cg+eXizbAJ5hGogObDH6g2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=ASNlvdi/; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=QIGm0K3O; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1722763152;
	bh=GTfJG1pVvOlhqeRhPSZ2jJbhnESq6sDdGs2cv+XUfw0=;
	h=From:To:Cc:Subject:Date:From;
	b=ASNlvdi/XbEbGIl33NUUJ32FYboHOs1OVRls5DPkp5PIWjTgZhyzQpNtcK67deqWO
	 P5akvYjTEF00zJMFNrtMdkpO6z+TmihIGgfYQJGfFWeULJ1P0t35vy/USl5SJLs+r4
	 xkvl8LH9WDsIsq/qDUiJMfX003vxqb7uBnsh8r1VKZ3E2OV3dL/ogm4uNLzd0gp4bS
	 oc42kIvZhGHAUVriGDkAkTeuAA0o5MoY6Ibz7/SidO8PmCLKeAzSmnr8OsIUyclome
	 mk2NzdpPoxRnE53goq/A/2/K1mTSfbnS3NoQjEb52M9vofO9kTt4Jto3QTuAO77qge
	 1wkiKceNnwotWfczCvkiFDf7o5xKv8FQ3P9d65HbFb5ll116c8SbcYeQbwuSD0ziqr
	 +mO8V+ns4HMmqFK78cKlzA+mov6AAHx1a46LTdyDqambimmvti+ySKYq89l/fZK5ip
	 Gs7g72kz1l54kAnUzKHPpJJBEqpuTRBuf3omIN7eiayxIJ0+/TEyAx17GAqxoVtfMc
	 KQGig57TZXhk5qDnQgmfLjwpFKtwjQ0ohIMmAdH0xGudUIDUWjL7JDOFnyx0EN16/8
	 OjHvP5rn0l3VXzPz4mJelTlsH9WQy4IUdiBl0LFn8eS5mFBLZBKtAiCsSzcViC7Uho
	 AvKawS5hLieqr8RHLGOHz184=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id A735E1DC09A; Sun,  4 Aug 2024 17:19:12 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1722763150;
	bh=GTfJG1pVvOlhqeRhPSZ2jJbhnESq6sDdGs2cv+XUfw0=;
	h=From:To:Cc:Subject:Date:From;
	b=QIGm0K3OkrTWQwqraYIIN9nqs7Lnz2DGGNuMl/TFA3ChCVqYtusuY4ZmiK5pjf8oH
	 xTFfTF4+W4RNaD+v6r8A/6k/ighywGA3tQ3ZPZEauM/nFenOdwfe0sQ4PuIslcL+8Q
	 ZduTawJWwsgZHIMRAQCRYQs/1lP8G3mbex4+XH2Jbf+0ODNa0mKiAq0s5Js02YwonS
	 N83GBCxwjNEh1R+M3Xn0C0Ng/w+CKo46lq/pNf4XWLkUOPhzA4Rf/UWjiH44yaA093
	 a13tS7Nx+pW7zUgLLyOgo8Z62S4/9phl8UDu9hMe05mk6PunmqQNXhXRt93x7x6Cwn
	 fuHWCrKU9pdYqBQnsKJBdOr4CsN8ZB3OVN9dbrFNX3pV/XbSYtqlBikYfZN+ISCdRF
	 EvF5Yy9/6TRev/3Z9hzqoSmAYojVFThuIysFIDlABdCHpE38D7qMIk9ZUXfUgvv53t
	 ZRXRUWMWAPxOiMnBHPHPc99Jxts8GNxPn9SEohomS+jvKesVUbTiPP4bjbYdVnDXPu
	 MDDqZH5+Omb5sq+/+iM1mWYiBnW10RMtWUUSROa4t/0rMbXpWw5hGGtaZPyRTHXnc4
	 mcNbFhrxXeWZovcQaSXn3RQXT5dtFowQDnF0FxMUMSjyXzn4AQ6DJWqnrlsT7l5asO
	 Ky0P7UVv42VcjvcSM5vyfPno=
Received: from sparky.lan (unknown [IPv6:2001:8003:8824:9e00::bec])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 69BD51DC091;
	Sun,  4 Aug 2024 17:19:10 +0800 (AWST)
From: David Gow <david@davidgow.net>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Gow <david@ingeniumdigital.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/i915: Fix ttm small BAR placement handling
Date: Sun,  4 Aug 2024 17:18:46 +0800
Message-ID: <20240804091851.122186-1-david@davidgow.net>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Gow <david@ingeniumdigital.com>

As described in [1], there have been a couple of regressions in the TTM
placement handling for i915, which adversely affect DG2 systems with
small BAR.  In particular, performance become very poor when eviction
from the mappable BAR memory is required, as suboptimal placements can
be preferred, leading to thrashing. This often leads to hangs of >10s,
during which even the compositor is unusable.

These regressions were largely introduced during the flag rework in
commit a78a8da51b36 ("drm/ttm: replace busy placement with flags v6").

The first patch has already been sent out[2]. I'm resending it as part
of this series which fixes both known regressions.

Thanks to Justin Brewer for bisecting the issue.

Cheers,
-- David

[1]: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11255
[2]: https://lore.kernel.org/dri-devel/20240722074540.15295-1-david@davidgow.net/

---

David Gow (2):
  drm/i915: Allow evicting to use the requested placement
  drm/i915: Attempt to get pages without eviction first

 drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.46.0


