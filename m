Return-Path: <linux-kernel+bounces-278514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A84094B125
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47EF81F22679
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DDF145359;
	Wed,  7 Aug 2024 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="JtMT0AXe"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F9364BC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723062095; cv=none; b=p3CLjt1WLUh2YIE3hGTdnPFx32jRn3xh3ymzgyT0W8I179akyL//eSmPFvm5O4gbQGi4naWlWp8tVQx7+qcAehLNgiqAQbQ6/Re7btzBazkG+4f5ZjonlaUoM+6aEgWALonyZ5B5fzsi4mpcbggwrS4AhF5O8/K8p+F5hrdmfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723062095; c=relaxed/simple;
	bh=Rp4mlrjP7QLZutZtr8XdDQ4/lNtj5IjymBb8o2NFAtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FOZXYCDmHW4slhomUDZeKnXP7kLYWbfc1GfY7N/O619wJSepep4l/X6yNmseEiqB80bNXyKchtmuJrYUXkVnHmb+QakhLDLXaPLhTONdt6/R4jeBQDcIH+dSxKKxJO9+Dzmp2pfZVFBvnSp+HjPuBKpaUXn4k+Raxpz5sPhaMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=JtMT0AXe; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso304439a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723062092; x=1723666892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4X1/+A4ARSAdI+l8r/PaTc1tSVNBTTGzDxsEIt0H8M=;
        b=JtMT0AXerqPHR/4BJzVYDEvILkCIfb3mXutIie7smH7fwDTXuZ9VtnGNlkxKfTg8Po
         DkD7lkz0rPZnkiX81Oaex1GT2mf7NcKN7LCB28IY/2JZCSsxn7MLe3mvjmX64mVrwulP
         jUNebO/mgi8R9rAJhcWIgYHu1tKPN2YrvV2N+BqveB0zTkMg+Ifra/pOZ1fvBrf9Z5FU
         bKov6nV909diBWkZLqsEldIn2lP3knqrIeGHTJDIuW1EIJcIlmw2itHKVUi3ueramq51
         a6SUg9b8pKrTMqxEx+1tI1f+rXjRJWLh1msXPwcMpP2hZ3EGEwgwL4k0NYyFKwHB/0ZZ
         QUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723062092; x=1723666892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4X1/+A4ARSAdI+l8r/PaTc1tSVNBTTGzDxsEIt0H8M=;
        b=BAIxRHE7iZtd63ilwPea6tonBaUFrchzbiGifnaZoCP1/uQm2YqfwdAPPynZxVwcOV
         3z0w08JaM0tp4ikcnit0hudLnylQ1A7p7JCZUcn43nd2H5L9d/ieuZBkQV8664/cgX/X
         rv7tGge8bNT4W0LRYIWInZMzy7XSbzYoPgMicXakDKngdcBHsnJULEYvZzn7Kin7qNwI
         uSR57CWfxPN8s4zi+C9MMjm+ItJSlHmuSZ1EQRSw4eHa4wng08NVzahAhcfgO+2V/IMX
         klsDwlKC8ny1AJKMH1rCczmGGv9ka0sPDHn2cO4gLiQrFAliwFoGXtn/VjK+MpuxPU8F
         B1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIJQjKUwKoVbcgScvJpgLXxPKIc7q6eOpfU+Yfz9Nn36FvOqul/AmISJs1dua2kk0drmb1JjlRLkBPPUS7eNorYCshLxlNbMeMXw41
X-Gm-Message-State: AOJu0YzNPGNDRWACvIpZmhwP7uXLLuEE/inKOZ4nNIODsFIpfazg+TZD
	ZScE6ddT741BluwW3Rl+vHXlvga7Fb43Q6omiAJf6Z/Mt68vwxKSh/8KWhXu0mjnNx9Py8zqVIp
	iZcc=
X-Google-Smtp-Source: AGHT+IG3cOPvJ9ZkCZ88ekCEODTh9Bsjt5Em1rI+r3qZ5LW0b41f9BBVAF+DAZPVJBB0M+s39MgZzA==
X-Received: by 2002:a17:907:2d91:b0:a71:ddb8:9394 with SMTP id a640c23a62f3a-a7dc4ff1ad2mr1408109966b.40.1723062091623;
        Wed, 07 Aug 2024 13:21:31 -0700 (PDT)
Received: from fedora.fritz.box (pd9e1640a.dip0.t-ipconnect.de. [217.225.100.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0b6casm666122766b.51.2024.08.07.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 13:21:31 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch,
	jonathan.cavitt@intel.com,
	andi.shyti@linux.intel.com
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v3] drm/i915: Explicitly cast divisor and use div_u64()
Date: Wed,  7 Aug 2024 22:20:39 +0200
Message-ID: <20240807202040.54796-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As the comment explains, the if check ensures that the divisor oa_period
is a u32. Explicitly cast oa_period to u32 to remove the following
Coccinelle/coccicheck warning reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead

Use the preferred div_u64() function instead of the do_div() macro and
remove the now unnecessary local variable tmp.

Inline the if/else and invert the conditional expression.

Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Use div_u64() instead of do_div() after feedback from Ville Syrjälä
- Link to v1: https://lore.kernel.org/linux-kernel/20240710074650.419902-2-thorsten.blum@toblux.com/

Changes in v3:
- Inline if/else as suggested by Jonathan Cavitt and Andi Shyti
- Link to v2: https://lore.kernel.org/linux-kernel/20240802160323.46518-2-thorsten.blum@toblux.com/
---
 drivers/gpu/drm/i915/i915_perf.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 025a79fe5920..6ff905d2b78f 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4063,17 +4063,13 @@ static int read_properties_unlocked(struct i915_perf *perf,
 			oa_period = oa_exponent_to_ns(perf, value);
 
 			/* This check is primarily to ensure that oa_period <=
-			 * UINT32_MAX (before passing to do_div which only
+			 * UINT32_MAX (before passing it to div_u64 which only
 			 * accepts a u32 denominator), but we can also skip
 			 * checking anything < 1Hz which implicitly can't be
 			 * limited via an integer oa_max_sample_rate.
 			 */
-			if (oa_period <= NSEC_PER_SEC) {
-				u64 tmp = NSEC_PER_SEC;
-				do_div(tmp, oa_period);
-				oa_freq_hz = tmp;
-			} else
-				oa_freq_hz = 0;
+			oa_freq_hz = oa_period > NSEC_PER_SEC ? 0 :
+				div_u64(NSEC_PER_SEC, (u32)oa_period);
 
 			if (oa_freq_hz > i915_oa_max_sample_rate && !perfmon_capable()) {
 				drm_dbg(&perf->i915->drm,
-- 
2.45.2


