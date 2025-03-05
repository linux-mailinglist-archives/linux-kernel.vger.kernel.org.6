Return-Path: <linux-kernel+bounces-545964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 337B4A4F495
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F483AB6A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3C619343B;
	Wed,  5 Mar 2025 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PU8dIdgL"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA26191493
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141054; cv=none; b=THsLXH5rwrcylsR/fesuGdvMfI6A5PNJm4bIBTTZL3MSEORSzA4dfajP8EpN//TfjzpKQdKghAQMht51piFYFgYXeMNHLBpVN6lobGdFAdaUoEBrash/L/qCHJWeZGmEjBCvstbWs1ZE/aDXcJovGeZpszykDdYCcgtuo0Npjak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141054; c=relaxed/simple;
	bh=ML+ucgaM1zLS4gZ6mZ2KqV9AZU93TB/vBQnHE0rNQZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBuTm/MJ9zlyjYW58zydlPcBJnFtAOcmXbWoy3Qdw7jM81Xi9viFfdklzJN5MdecHgK68KB3KNxMRiaikuTf5yiSnHpC+SwF3SsouL7Af6tZf4CLvSfEzui5cK/VkVHt0MoyGCnPSTBUodkYjclE2X/KS50CZ6NSv2zYvx3JlOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PU8dIdgL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dbe706f94fso986451a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141051; x=1741745851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9Nf9XNBMQ1NmHLDzzCeL0iA/og6eQYJ7zp4LTTGbqQ=;
        b=PU8dIdgLWMy28Gr0lDRmhvShPlTfvBkQsMo9FYlZv1lZ2v2kTufPhfyKvpfmK09Dpn
         yWKCdji0MhcCaVeXGfp8Mk1h1k+b98NABFzzft+82W3G/yNLNYfDaxaJxLi+l+OGTAhA
         pG/irDIpNqeeaYxQiqvg6U4CbpQgv2ZUELX9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141051; x=1741745851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9Nf9XNBMQ1NmHLDzzCeL0iA/og6eQYJ7zp4LTTGbqQ=;
        b=rcyubqwJERHA8ZtUAjrEjkxC6GPo0P0llZuPt9H/1ACqd15crvWIjBkseBYRGTTFiS
         K+T5VvzJ9x2j61o2Xh5f7Ha2KiRKu6h4he+/VDkc9sS6hyhf4nlFldzn+jvFurRfoxk6
         z0LpRQhOe/jPXPtGUBTQMcD+RelfYtqLwur8DL1p0NfbSp3FEL8pOItBGAZl4rNvxXVq
         t+e25B09bV7vXBO5FktAmyebM4KqkmMSnANz+OhvWsJFNiNbdxeAMYcSMPBvwyPe8Zdx
         vltEe3Vr1ayXIZ4lR0uQ1hIDayAjkvgwoAD3JRuXG9sfRgTTHnH27oC1Fau566WU6paE
         6Qsg==
X-Gm-Message-State: AOJu0YybegxjjOEnXjTH9q9U6ILcLcebzO4y54i9qudblHslq0UzxPGw
	1JabUnAgVnC0OImdotI0uuju657oEqAg+3niyf5Pgqk1lQJeUw/2oZZvkzMMbg==
X-Gm-Gg: ASbGncusW3pErap3KidDp9UEFnZ6ElcJ2jE/7Za2HzIevxubTN3HIjydQMgN502L6fB
	xXUNNQ7SjBYLm4iBYzHgfjmGbNM7RRH8uR5dmr1sCqIBC8jNj39133tcTzF9OCWfpyeFrYJyQeg
	041UZaPhCRLqStm/0mgKoW97LloRTlx1trderskpfwJhjLkGaAM75jlao7i685/wNGdSZcDj2Hc
	QEtEBqqu3htZhcX2GvDROthhs9ktGbtNhwkrHkKcawYLjDLt6SvlVuO8WFuMGSMr75uVBZ57p/2
	YroX5YWZAzp4GUN0SxICYekWTa8y+AbVwjES4m4Tv7SWzlOUPTc9Of/ZyzZVUMBGHPcRCSBWLdm
	w
X-Google-Smtp-Source: AGHT+IGXOInOt+Os5+KEs9jkrygME+p8EJ7lyp4fBieT6azksEXHSkiN9x/wGTG7JxavxNz91t/jFg==
X-Received: by 2002:a05:6402:34c2:b0:5de:a752:3c6a with SMTP id 4fb4d7f45d1cf-5e59f47072dmr442395a12.6.1741141050866;
        Tue, 04 Mar 2025 18:17:30 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:29 -0800 (PST)
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
	linux-kselftest@vger.kernel.org,
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
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v9 6/7] mseal sysmap: update mseal.rst
Date: Wed,  5 Mar 2025 02:17:10 +0000
Message-ID: <20250305021711.3867874-7-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250305021711.3867874-1-jeffxu@google.com>
References: <20250305021711.3867874-1-jeffxu@google.com>
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
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 Documentation/userspace-api/mseal.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..56aee46a9307 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -130,6 +130,26 @@ Use cases
 
 - Chrome browser: protect some security sensitive data structures.
 
+- System mappings:
+  The system mappings are created by the kernel and includes vdso, vvar,
+  vvar_vclock, vectors (arm compat-mode), sigpage (arm compat-mode), uprobes.
+
+  Those system mappings are readonly only or execute only, memory sealing can
+  protect them from ever changing to writable or unmmap/remapped as different
+  attributes. This is useful to mitigate memory corruption issues where a
+  corrupted pointer is passed to a memory management system.
+
+  If supported by an architecture (CONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS),
+  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals all system mappings of this
+  architecture.
+
+  The following architectures currently support this feature: x86-64 and arm64.
+
+  WARNING: This feature breaks programs which rely on relocating
+  or unmapping system mappings. Known broken software at the time
+  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
+  this config can't be enabled universally.
+
 When not to use mseal
 =====================
 Applications can apply sealing to any virtual memory region from userspace,
-- 
2.48.1.711.g2feabab25a-goog


