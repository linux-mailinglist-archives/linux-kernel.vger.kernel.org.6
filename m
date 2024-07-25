Return-Path: <linux-kernel+bounces-261642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0906C93BA3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE6D1F23355
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29C0D27E;
	Thu, 25 Jul 2024 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uxiu3K+6"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B10A5C89
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871727; cv=none; b=qqP1npfc32KZD8FAhozK6+nUbzsO2NUGxcWbJixT8KrU6k/oMRF02J/QYu+HOnCCG2XrQgE6ccJGeQ2b7zvJYXNhAxrvF13h40oSk2XkbDFxv1A8hckq1V2WwQkhzUre8q6DImdhkSsT/P6bOhnjbpnXnWEvXeDn6Qv3de4WX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871727; c=relaxed/simple;
	bh=ujM1XJIxa/ere7mxRTXOLq9tnMVH6DzADLhZoNYsU94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MNdO4it3uJqOkZzwCE6cS6+BUPcMHpYN2YMCnNcNr1kj+o7l58SbApBiyYlfDfTFnCHYRYPKXUoqpwfhmCwHu+AZVsIyUN5nVRk5PLx4qp8Tt3NEKAUo4wEfiCHFB4f+NX+EZzdLZ8fizVfekJhKJGtWNXigSgpRdgtVSIl5KuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uxiu3K+6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a81bd549eso3342266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721871724; x=1722476524; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BbCh2qq+GqJnDj1NLZnr9Rls+DkMZwrRCOx9dR1Do1E=;
        b=Uxiu3K+61sZUFDGhvx86UvUxrDLr48j/RDDc/BQlceLSb9lDPm1+FYLcOQlE6tIb4L
         quNcpgkovDbFedprBq8mdlsWqyFVHtYvtm2UmYQZo/DUneMAJxqpe6gWOWU+9UktCtoD
         eKz74B0OBnnh6NGHt0m2OiQLgrRGIvHtbojqEGxz07tmtLiJiF9kEouJUC1UfSPCA5Kf
         AAXRLU2Gad4aP9oFL+JiOMVvgeTxIj2RaLTkuqlfCGFu5J2/H9w5av7qS0RRf43mmLQr
         bic22zph+T0hOWPw7FkSo5H+6+jf74rjsJdDL3+GZNipIatoC+7aS0BwRTCyfpz596cS
         ZV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721871724; x=1722476524;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BbCh2qq+GqJnDj1NLZnr9Rls+DkMZwrRCOx9dR1Do1E=;
        b=p9nC1ScJGGmK0CIzjoI+HLAakxfGFA5/2yHvEAIC2H/MFsxEPfGwvXA9Ho2XrDvopp
         mPwtyODdYuTQwvw/2VJGQoriy5sfxbNCT/QHdv6du8+uKA9dR7anbxiplYOINpVUhPlh
         pyx+ZFfBW9cCsuSc0kGO3WZUUE2oOMa3GQ7NX/PfUxm0pLWB9hfKaLR9kyltSbMdKWXN
         x6BM/jJ+GKTAIdmZ3rSw/mWHLhleyMSN6DYqHFPupgBxlw/FTKabVABBMquUWwVs+1TU
         qxqcuSevHBTa916HtHP6qxaEUGAmxO0AK0UYizCnhkNeoOEZx/Z6okAhfZcetQQ06Ir5
         70bA==
X-Gm-Message-State: AOJu0YyEZFLB7/vo2+Xbrsmzb4sXP2NylB7QETf/XJElb7BkPdIjZgWl
	fPizU1bwYUWjYr0GeIxL+uxnQY7VkApQBFtnSDwFcAPJXZaoVFGM
X-Google-Smtp-Source: AGHT+IFk3Ms/SyOdiC39YFmwoxbzYL/KBF5t+PsVfe5ruS/QQcledGnBNNjWB+rCtaq7rwicVZt4Pw==
X-Received: by 2002:a17:906:c148:b0:a77:eb34:3b49 with SMTP id a640c23a62f3a-a7ac4f40e95mr83707666b.37.1721871723509;
        Wed, 24 Jul 2024 18:42:03 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9a2asm17354366b.218.2024.07.24.18.42.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2024 18:42:02 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/5] memblock test: add the definition of __setup()
Date: Thu, 25 Jul 2024 01:41:54 +0000
Message-Id: <20240725014157.17707-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240725014157.17707-1-richard.weiyang@gmail.com>
References: <20240725014157.17707-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 1e4c64b71c9b ("mm/memblock: Add "reserve_mem" to reserved named
memory at boot up") introduce usage of __setup(), which is not defined
in memblock test.

Define it in init.h to fix the build error.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 tools/testing/memblock/linux/init.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/memblock/linux/init.h b/tools/testing/memblock/linux/init.h
index 828e0ee0bc6c..036616a25427 100644
--- a/tools/testing/memblock/linux/init.h
+++ b/tools/testing/memblock/linux/init.h
@@ -28,6 +28,9 @@ struct obs_kernel_param {
 		__aligned(__alignof__(struct obs_kernel_param)) =	\
 		{ __setup_str_##unique_id, fn, early }
 
+#define __setup(str, fn)						\
+	__setup_param(str, fn, fn, 0)
+
 #define early_param(str, fn)						\
 	__setup_param(str, fn, fn, 1)
 
-- 
2.34.1


