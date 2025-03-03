Return-Path: <linux-kernel+bounces-541014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD7A4B772
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E4B188DA77
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A51E9B31;
	Mon,  3 Mar 2025 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="liCFx+bP"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BCB1DED56
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 05:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978582; cv=none; b=E5WB95hsOke56decxWuC5O1QHgwUYcEi8Pa54HOIcvsiHMoye9LOfXMsGRnQiapEDmKwL7F+z4pyI3uE/BVUHYSv4A/hAOm9G+mJZCAKJJ47lbU8n2A85rq13/Z7RMbsFIawT4VTQi/LbFKt0ZZI0pjLQfkpfs92/xO2q628kxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978582; c=relaxed/simple;
	bh=WLzo15XZCOUhn48p1nU5oCESt5AY/XAN1+82zsPI/4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EssG16JPztam5bXTMgGvvcKo7OpXyp7f5Jag2M7F75+X9+Uc8RfR9PtTiiGOjwotbpjxUP9xup5f2yXdSJyjSaW1kV/2+5DV7pXVIp1TUQSJY92lGY9W7YpyzH5TnxC7Zc/mc+L0oZ9mMVjoOB3gWGn4q+SS47wmfFWcX7VCwPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=liCFx+bP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e064eff5daso592406a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 21:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740978579; x=1741583379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYjwm8dHrLXGz6gb7qV5M3QfXuZDejaPJfbAmodOPNU=;
        b=liCFx+bPN8LLL5lhssS5CRtivEw4TPdaaCXsWoGTxBu43/B29kAaBateO593VCtUtQ
         d+idFLivxLJqGtcQFj2gjgwpF9L0KmZa5FNp9m1ySOLicnTz0i3GJNQ4kCE3sQeXa5jp
         1seC5xXl27XTCNdX9/z0V+/qHvEUCL/5M5ySI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978579; x=1741583379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYjwm8dHrLXGz6gb7qV5M3QfXuZDejaPJfbAmodOPNU=;
        b=CvF95U6HofID6BVXSjllt089W7ykKFQQjdV+XT2R5oP0cjItAYNc6VQj/1n2sEznnz
         +TBPi2COmixpnp/F99VE8EXCLm96cmb1oRapFyDlQeCe9AVNw9X2LVNTBCUI/eW/xFdm
         ekachEqFp1+Gr5FyL7jOniTXeDHeax7cZG21Of6j5Bln1dcpr2ExarXDYMFM6JfDXpmq
         gowJzP/4Zqp+yfO661SVS3ldhslHWlnSQ8IW7T2gzIR07cZPJka+XNN5dGMAP36owTPB
         rE5veNiN02Xn1Lij6jQfo+0JZhdLCEOf08SouevCajvySOcvGM8cmhDp368mSxIuc41D
         GpPg==
X-Gm-Message-State: AOJu0Yxihuqjo/CerxzoAod18lyuUDA7EuxXzEO0n5vZxNUDggJ6DNAH
	j2RCh+KUBokSS115Ibsnn9OCf8n+ofhEgAzyo/yPF8Fvy8gsTJ7XB0yannN2nA==
X-Gm-Gg: ASbGncuczstNmXnFvl5rZXQb5SnLKus+8N5gAYsBGSJYKOTkm1HKdd4dnN2WqTfK8Pd
	5MoXscJQZv3T0OT3trsJmcgc18NcdhGrL6cUXbacp0mXxhtHaOBrj6RC6c1hWpZo+DpO5QfOr2n
	CFOys96N4MZTaE1uTkXKEhDIH3Q/jflXAh/E/cKekj6e/Tdqon84J4JvYFsIQ5iC9nAsmAsDCn6
	Cx5b9tBw2b3oxDGyU3yP8K27aQoRp6fed2mTR7R8Yrp2DwJBt7jDSZjMeklNc+IfHqAjeqQFS92
	ZB8kYoNaAacVhPPvknnooM/w5aUCUb0Byl/rrAuat4CyzRmgnJp6paZuB9uYnwAi3s7Ekdr72KT
	V
X-Google-Smtp-Source: AGHT+IHtOuKA+9OaPh5jrHwcaVGv4sg/p5d2FB/xdLoG2RY8640XMMB99IsWJcicRocUIUi11DwD4w==
X-Received: by 2002:a05:6402:518b:b0:5e4:d192:86c5 with SMTP id 4fb4d7f45d1cf-5e4d6b85dd2mr4581736a12.9.1740978578724;
        Sun, 02 Mar 2025 21:09:38 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm6248635a12.50.2025.03.02.21.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:09:37 -0800 (PST)
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
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v8 5/7] mseal sysmap: uprobe mapping
Date: Mon,  3 Mar 2025 05:09:19 +0000
Message-ID: <20250303050921.3033083-6-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303050921.3033083-1-jeffxu@google.com>
References: <20250303050921.3033083-1-jeffxu@google.com>
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


