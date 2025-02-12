Return-Path: <linux-kernel+bounces-510430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66DAA31CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907893A1906
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943981F9F47;
	Wed, 12 Feb 2025 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fKW9fDp2"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6941E1D7E50
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330526; cv=none; b=LNgGGFgzHcf40WlJvSesjo+oyEXBdKfXL8+8Bq+Lt8tobA9PH67G8GDCp7sUMA6LAyjWxxd6VuE8oeH35j7GHicbwX07PyBRS8M7bFO9p4zAQ1OG705/PZNAv6Lukua6HYpnVUSFHPeSmW+busarEQ5F0qfdDa0qwnuD8J3K1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330526; c=relaxed/simple;
	bh=PT30LLdMtYpa2VkGGccvOtXA9HUhUF4omPyr+dgwXow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udHZBND1yYOi8C4Y67xyicGrW3VOQwU9ubC4HbavzN6QHObW85RgDk3LkjMR3EFd5X0jA8cGzSTWW0c+8UduhYX/IhCJ1nSJ4BVSmLbXMCLx3S0j92AloERXLhf3W2sse5dO5FWtokDk1ndZrcyW/uKPy+UctdyVbRw8q6KRlSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fKW9fDp2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2166db59927so13167095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739330523; x=1739935323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlSoQdNptgY7247+UT5J4unGLwbIYWVI4vHulpaAU8w=;
        b=fKW9fDp2tFP/xaBH4j02xTqPENg0CY4C1V9yvjlbf2JfdBiPP4Egi1G/IKpypaxKLn
         jaJiyhvJ/NiT7MUyqWdXIKuODWWjfvj4ZHx4nIrcspQDdNAqCjCfCbnQxyO+qFoHJ+3r
         Gc7JYbGnUCUbrW8xYgwHZJ66xs7dgjcMkNcTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330523; x=1739935323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlSoQdNptgY7247+UT5J4unGLwbIYWVI4vHulpaAU8w=;
        b=u0H1ZW1Z6+aLjwMQ+c/RXWr7I2kgPSNvXx87dvusGBZziB/JopS7JK4zYFh0FxfDEa
         4R8GbnFHsdAcA82D6hPgAukbFEa+LmRdDahjl7jd8gKoT5AXeSlL4XvQThz1JdUPe9au
         4wCnzzLJhugLDM/PsFPyUAXyeojfEKMkjO8N2AABLeHiXbiOIJTSemaG2wlPG5VDaPrv
         wMkihly+9iTpVfaCpRRk/YhaFdrg9mXz2rO3xck+6Ufdqz6UsFI9QnqCBsh4OtYR5kxi
         QS7In2OmW2SFNnA64ifkssJKrWneDL23CNsgkBC+UiVrffEXpVo3NoKx6TVQkscA9NYq
         46nA==
X-Gm-Message-State: AOJu0YwU6cZH1xy71Q4bTpeFLNtbBC0OH7kYM+xaQHjJ1IZVOxZ9E2zd
	v3WxwIsDdMNlFQ0ECKsLVpxghN7IxSky5PpbcLn+fXQO8DPp31LMUXOYbbDmfQ==
X-Gm-Gg: ASbGncv3gccYKsqK3ief/3TLdrgbgICT3VQbHCRcGd5dNRljxfRTVoaFvzmT10yHQ/H
	kgWSfKtzYKIYBE8TIVyKTg2vYit4fmIos01q+Wm5XIYTTB8uzLc0LpFSi3nkXCxXRQQxVTeS92n
	za/mio15Tg8jvXCTNW/NlTfAwVYSQmxT9ufYJhbrxTmBLWjkdHuvB0q/RuA2F3ApAYummzvY2Qp
	cnXh4F14DkxsEmZv/YmD5GmX8PO10lgfvIYunRz6wbO9+O6S+3smBb8VrZJHjM0FvZq/orEjuGZ
	dI8OXSPO0eBZ+KBQpPIaCcIX8/OdAxOQMaJeo60eJkuenuirMw==
X-Google-Smtp-Source: AGHT+IHih9DPBHtIxeZtSPdWvKIHKG8FUBtw2uxCsB6lpgOAKvHZ+pA5HJl7oCK9T6pOYiqVU0U5tA==
X-Received: by 2002:a17:903:2bcb:b0:21f:356:758f with SMTP id d9443c01a7336-220bbaae950mr11340995ad.3.1739330523575;
        Tue, 11 Feb 2025 19:22:03 -0800 (PST)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21faa49249dsm32295415ad.158.2025.02.11.19.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:22:03 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v5 7/7] mseal, system mappings: update mseal.rst
Date: Wed, 12 Feb 2025 03:21:55 +0000
Message-ID: <20250212032155.1276806-8-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212032155.1276806-1-jeffxu@google.com>
References: <20250212032155.1276806-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Update memory sealing documentation to include details about system
mappings.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/userspace-api/mseal.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..1e4c996dfb75 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -130,6 +130,11 @@ Use cases
 
 - Chrome browser: protect some security sensitive data structures.
 
+- System mappings:
+  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS),
+  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso, vvar,
+  uprobes, sigpage, vectors, etc.
+
 When not to use mseal
 =====================
 Applications can apply sealing to any virtual memory region from userspace,
-- 
2.48.1.502.g6dc24dfdaf-goog


