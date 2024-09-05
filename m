Return-Path: <linux-kernel+bounces-317008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7296D96D83A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AA51C229CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BEB19C578;
	Thu,  5 Sep 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8SRqH/3"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7319B3D7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538833; cv=none; b=TSztEVkPyJ0sZXgj7dJkvyIrY/79PjH2Mko+KcYeDP/ZH9/4/6FGQ7pqKoVFX4AixBY+N4/fetPZLZGCjiPhWKRCwF/ztEALji0EY9GdsTMTY5pR1apGUzbYAiaww1vCJlHd5BiPNKMNsc3ZYoQntkgX+Jp/yIr8X0KcmkKaeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538833; c=relaxed/simple;
	bh=OAsAsiEJlHxcTT7lZwa4RqWMBUNVvehe/z+uh0mgj48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRniDnIrsUsbEL/lynCuF8x7eMmyC1TTmIzUsaiCbr5JeF4k9wsdoWnHp3SHPn9WkIbuqfAcmhEHeL6YhFlmmElw+MayrAyfMy8siLhWe0xNVIgIPMs/kVBJepJzhJ6oKkb7RHhlG1ZbA9rdvwC47SHwDQFZ4kRIn1QziZ1NBIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8SRqH/3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374bfc395a5so428595f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538829; x=1726143629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD7NTe7bgmL4j+ZOUWe6Vz/irb7OPA4CTAynHWYcSvE=;
        b=F8SRqH/3yV63/osdnS/o8B9Dl8MiZgzizNwjW5Me4XP/ay5q0nkUaMTjIu7dSgU4J7
         a1Ll3/6TEiJrl6EoHVUWLGd3TFCtPGvbjWqy9TlfU3MZS3pNLmqxtzYKXa2jfhwFRv07
         GgMoBZ/c6S3NgyThVslZqrDNuC8lCzW1l4Zsivanjh8YZnGOj0eFK1/mO2kczpX5GRXx
         kRYMoKn0BuSfO43BN5xYQoWIBKPkM9Fh2Fw0IfWxeItLPrsDpP4yDOfME9fRa3AfdKrv
         1n2TgXEUllhEPN6CV6bTkQvl8dVbVkY6NFZZgwDF4lNhilI5hcNp6dz42JrmPUviDpIc
         CdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538829; x=1726143629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iD7NTe7bgmL4j+ZOUWe6Vz/irb7OPA4CTAynHWYcSvE=;
        b=IDgWTj52XCf8NSpfcfLt9iaYMvTbF/mbfX6eaAMcEh3/F/1bcYztuNor5o/P5488s8
         MDYQB3DYltbJ7YK5GvBWrzj3/GRlLF2G8LBI7W4TeSCuM22VOyKatXzRG7Qn978R4FuK
         iIPNRNHHvbf2zWKvprfBO5emwaTGOTaM3HnfRdCkd9fu1mznpyKW/Ur4zJC43+5u/Fwn
         DW9XBjz9lnB9k2ytMOn4pVBx4FiYbIIP5s3AyHIIx8NSNUMsv8UfmhB6h8Fa/5nxsPp9
         UeB3ze7bPzwN6jylk8TywoZ9M4bJsqM0Lm6LA5ph3HIsNkgs0qmIULHY8BudSqwgEIa6
         PIWQ==
X-Gm-Message-State: AOJu0YwD1E17yfbzChm461umcSCovbQf3JBfL+NuzXVhagPUw83axXE/
	M3brm4BS13vh1zm0ZgrI+56/KVg2RRSk4T81yJpp1+Opap6S1q5eWkrMHipdvo4=
X-Google-Smtp-Source: AGHT+IHa0fVf6EKsDAw+gxmmQXJ6NX7kn1nNvzKP1vs+nY3qqO/a3JqoKC8nQD5litjqwafLqGt1BQ==
X-Received: by 2002:a5d:464a:0:b0:374:bf6b:1021 with SMTP id ffacd0b85a97d-3779bd1864fmr3502807f8f.27.1725538828407;
        Thu, 05 Sep 2024 05:20:28 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:27 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 02/18] drm/i915/selftests: Include <linux/prandom.h> instead of <linux/random.h>
Date: Thu,  5 Sep 2024 14:17:10 +0200
Message-ID: <20240905122020.872466-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Usage of pseudo-random functions requires inclusion of
<linux/prandom.h> header instead of <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/i915/selftests/i915_gem.c    | 2 +-
 drivers/gpu/drm/i915/selftests/i915_random.h | 2 +-
 drivers/gpu/drm/i915/selftests/scatterlist.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem.c b/drivers/gpu/drm/i915/selftests/i915_gem.c
index 61da4ed9d521..0727492576be 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem.c
@@ -4,7 +4,7 @@
  * Copyright © 2018 Intel Corporation
  */
 
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #include "gem/i915_gem_internal.h"
 #include "gem/i915_gem_pm.h"
diff --git a/drivers/gpu/drm/i915/selftests/i915_random.h b/drivers/gpu/drm/i915/selftests/i915_random.h
index 05364eca20f7..70330a2e80f2 100644
--- a/drivers/gpu/drm/i915/selftests/i915_random.h
+++ b/drivers/gpu/drm/i915/selftests/i915_random.h
@@ -26,7 +26,7 @@
 #define __I915_SELFTESTS_RANDOM_H__
 
 #include <linux/math64.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #include "../i915_selftest.h"
 
diff --git a/drivers/gpu/drm/i915/selftests/scatterlist.c b/drivers/gpu/drm/i915/selftests/scatterlist.c
index 805c4bfb85fe..7e59591bbed6 100644
--- a/drivers/gpu/drm/i915/selftests/scatterlist.c
+++ b/drivers/gpu/drm/i915/selftests/scatterlist.c
@@ -22,7 +22,7 @@
  */
 
 #include <linux/prime_numbers.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #include "i915_selftest.h"
 #include "i915_utils.h"
-- 
2.46.0


