Return-Path: <linux-kernel+bounces-545963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2CFA4F493
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066D41890806
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F68189B9D;
	Wed,  5 Mar 2025 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E/Vh7wRq"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649FF18F2EF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141053; cv=none; b=lzzp4nej9R2vP0EpIhbHkcYfWA6mahQgtuC79MlXa8uVQ6UE1Sgc+TRmc/W+n8OS5OKZRZDNW6Gg7B6PnIC6SjcbZ+xua/KTyslWlPeVe+M1isHsaTAPk87mDuVnGCuIXf0DvrVGtW2X+PZWBVjn2C3XiIAHzv2PQKOsPgfjerw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141053; c=relaxed/simple;
	bh=92tjd51ZxlOW6iKXAPr3x72R2NqaT4p+LyMw3QPXUtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJpYvSivCg6waC09lAehyviNye1pooT7aVSJ8YfmFNu85yVdKZBfZbdCfcWCgtaK8mhMaj+mGi7Rdg3gmnZvjIePQeYHWmlBGdtkam5gLHBTIMejV2Xj51JRbsCfaERcGA4Gz4MCWV3vrz82METe3jqFaOSDXr2XPr1lCpg2H3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E/Vh7wRq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dbf5fb2c39so762390a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141049; x=1741745849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GUuWdJKxZ3/BvY94DN0LEqc9J/B6h1FHzMtAHgZb/M=;
        b=E/Vh7wRqVxkMZ+wUn6gWYwv21ASEkrgMxBDITGLZxksCXvscZbl1VNBLnFimoZshcy
         LM5947BkIiIXZ1q5QiAIQlGKZDg2Us2953USRmBhaTr72Iy71NvBaOCRrKH5sZcKK1AL
         j8K3mvAxXObXdl2X3dxed6jrWpmQxDj4/Vy1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141049; x=1741745849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GUuWdJKxZ3/BvY94DN0LEqc9J/B6h1FHzMtAHgZb/M=;
        b=iqtFuC1DCptFuLxQ+eJMUTRkghKNxybKvIHXaShZmkHcE6tHBrXobkBxBa2OEfceCz
         brMVFCWMolOFJHC2SYJlI2qW8+lR0dcwabypLQYk5hjcP6LFP7zwp3J1cD5Qv9NMvs2c
         zw5hKH7i4QG7cO+WT1IjEfwxlbBK5L//YQvqVLtK8i3QQY/DI/hlWZotLYhVro3qrG52
         oUOVDBrdwQG81yKrCpdTvfaayf7w2+oit+zEbb8dS0g/BfeBOuUme67UhhmdRQvxV+ix
         r5ZHjtaXvte8ic7m2euJ2RfTbiYuXFVv3XjunBzE8BdCcS87eHCw0NgBUBczZQaK1H9h
         fcqQ==
X-Gm-Message-State: AOJu0YwIgtW12qMWfI6Vjt8ABAQ9d125TvunA6GSjfqva+vwYPyK5Yza
	1fCS3j/lcBOBe5SF8usuV/nklK+D0hJUeNgsss6ofY9PzCKKyp9lqaXkesSrsA==
X-Gm-Gg: ASbGncsBCDoxWqdisCWSb73idSbCEj0lx2a7uXLoSvBJTcih8DJdSRaU8IaV9VxF94O
	msQRKLtU8sQaO15fvdpRWL+npB7y0EskL6vXcp2pCgG6Q3qJKqHXIElWjNV4tmR+WW5iMHURdbE
	Dfrm7la6pQ5IsBsxzdOmlUV2gv2wcIUm+viY+8MeLh4C+jfqFkqX+TA2nVdEanrg054cTrcHzPm
	Tx6n6gA536NJ9IAlGEIUqZlqX1wkJewzdu6Pf19RDCCzQd2sM7NEHvqWv0qCCcDeprZS6JouB0e
	4l7LMfLjn4G9bHeT0o9E86WKndDKYBMDPSuFSLGdd6VtgdEFOtzfr7XW0bC9yuKeIcfRHaX4Fld
	n
X-Google-Smtp-Source: AGHT+IES9/6N/5toY1Cf9aspTXKgI3/7p+xl7igipg0af9FRFEO+OX7pUZ04JGOESjzxfe8IxQnMgQ==
X-Received: by 2002:a05:6402:51d4:b0:5de:cb8d:1c82 with SMTP id 4fb4d7f45d1cf-5e59f3a84f8mr383796a12.4.1741141048576;
        Tue, 04 Mar 2025 18:17:28 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:27 -0800 (PST)
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v9 5/7] mseal sysmap: uprobe mapping
Date: Wed,  5 Mar 2025 02:17:09 +0000
Message-ID: <20250305021711.3867874-6-jeffxu@google.com>
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

Provide support to mseal the uprobe mapping.

Unlike other system mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime. It could be sealed from creation.

Test was done with perf tool, and observe the uprobe mapping is sealed.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 kernel/events/uprobes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bf2a87a0a378..98632bc47216 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1683,7 +1683,8 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	}
 
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
+				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|
+				VM_SEALED_SYSMAP,
 				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
-- 
2.48.1.711.g2feabab25a-goog


