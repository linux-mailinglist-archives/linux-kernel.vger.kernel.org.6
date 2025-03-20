Return-Path: <linux-kernel+bounces-570192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623C2A6AD61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92DA18984BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028EF22837F;
	Thu, 20 Mar 2025 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krHYCiGG"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82D8227EAF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496780; cv=none; b=dUqa71ThjBg9ueCLu1GVkaDHMgG4M6hZcpTPGDLkXC+roxcwnVS39lpJ7/wltidjdToFwOk+/uiVGprNUevN8xMPsJRL7BBJQyvnMtUE0jINaKi8yMoY6LUa9JtcvluMcwtYwsbLfNHPDQb0tnHraP3C9A3UxBQEuywSkhk3w9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496780; c=relaxed/simple;
	bh=4AJQ9/fTZnBfTNmr54vZ5hCXDEoIiB04E+EP8sWh27c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suLsMGEaqfxlo8Pxv1a6sjKZwujKD/FWy3/fHSZOt+QJUTjFypb0WIRxGR9dCcoQz7LZa9lhs6NxRINBXpSazKli7qlNX4nG45s0HqXXXjv2Bhe3mTSSuUS4kTp/RoogXI2POpWI1daFoyp6TotwKaXv3zSLq6LMDzLpWGXP5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krHYCiGG; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85b41281b50so31008739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496778; x=1743101578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcpeXIgBKTB5NFbofa9/asJwSsA0oVZhqq9QNH8OPg4=;
        b=krHYCiGG8ikwI5yE6jWe++o0F6hFflFuERZ/noBCcJXTGariZ9xC6KB/MHhMy7CwvK
         HgI9IAn24qo1p7oERIQalyhPL7Wz7LAJtGwDe8YCwS5f4gAjAbmf6oByr61ufol6lj0h
         OLeZgA0CEw5KDJZwuMjqIn16HYvWQAfncCPzEcuEhGuOPz7FkNxHBeZ/ShDknLqc/PB2
         7JqtGdxpFn8QgkMAWOQKU7EBg6YRpAt81ICUugzjibR8lHmspF1M79qO31ycJNnstgGj
         2putzLPriFyn2s0XpFP6Bq57eCo8Wpe47r54rB9h82wfsG92gDT/4YeehHHYv32LS8Vr
         s1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496778; x=1743101578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcpeXIgBKTB5NFbofa9/asJwSsA0oVZhqq9QNH8OPg4=;
        b=k00j9AtQuyVHZYEiUvUv3kzJ7G/5L4JC230QTQStS1ZkykeAidfF+hEYGaR7xYJLDB
         XJpMJew+pomtGbue6rj9zaxRxaR4ZPz/J4vWcyCTiMqGDTDk1gFha9Zq0lJAr+ggMx6g
         Ceip7VQKl0bmAXtzYBNgKDGt7DnNKPwzWVhlGF1d8ZO9rUb4o+1emHmR26tayThUl9RX
         sdSJ6HoAcXSJZwCE+jHwNM2mV2vhXXQ5CNe/FyNd3GVMWFf1xpG9805yB1ieso2FR7v9
         tiijv8PtQ+oC+A+fUwB1SZ7UQ2qZ7VXf4H9GN3Hydz/QAgur4yfiObXAA2prDC7CC+j3
         B+8w==
X-Gm-Message-State: AOJu0YyzgAxUbdso8/6M9q5NLVLQcSxAKIhoupnKTdE1gkiTe93NUhNQ
	TFmcBgP8taEQak1S5lqcarYSjqJfY0ZuqxJxOzPizTQh5Fdb/SizIlTYlm2Z
X-Gm-Gg: ASbGnct9i/vvvINmI0U17IzQ7CcVHrkYSLVLqQaWv8M71C78fkm7ogDiAg2Z8cQw31m
	xCEHIIYsntHEHViAgH6UclMBf+5Cxplr2RnjuioXzIeNY5cAI4dqJQRvV/UiMZAXF/CNdqkZ9R8
	yFKfzjMp5+InkXZz1cSii8yAjq/j4VvQDsUH4DkGJ6xbQphksJYLbC12Rr3z3KMVwJaPZF7zXFG
	Yrufw7tUdtkFS/Qo647QkeU89gRc49fskUpZWEk0/jUoD4V0vowFqu/88DPPpET6NaEFTVifLJK
	7cbQiur6jHy0BeftdpZ3bMKdKGMKXIK8N4yAsUdvxLyE0a2IVDxd/Jg6Q604LRqcMCsbpFTYimW
	UsQ==
X-Google-Smtp-Source: AGHT+IG/WcgSDWYGaIGUJzJjoUwRAkD/zIPJ1dWq3GZRtzQHb9p2LQ4+giHWWoVJtCcIbGbNZ3Q//A==
X-Received: by 2002:a05:6602:3719:b0:85b:3791:b2ed with SMTP id ca18e2360f4ac-85e2caaa5c7mr41988539f.8.1742496777818;
        Thu, 20 Mar 2025 11:52:57 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:52:57 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 01/59] vmlinux.lds.h: fixup HEADERED_SECTION{,_BY} macros
Date: Thu, 20 Mar 2025 12:51:39 -0600
Message-ID: <20250320185238.447458-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 1d926e259d8f ("vmlinux.lds.h: add HEADERED_SECTION_* macros")

I flubbed the defn of the outer 2 macros; they missed the extra arg
needed: _front/_hdr.  Fix it now, before anyone notices.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0d5b186abee8..c9c66089ea2f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -219,10 +219,11 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	KEEP(*(.gnu.linkonce.##_sec_))					\
 	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
 
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+#define HEADERED_SECTION_BY(_sec_, _label_, _front)			\
+	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop, _front)
 
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
+#define HEADERED_SECTION(_sec, _front) \
+	HEADERED_SECTION_BY(_sec, _sec, _front)
 
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
 #define LIKELY_PROFILE()						\
-- 
2.49.0


