Return-Path: <linux-kernel+bounces-267481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 041499411FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35721F24287
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D719F460;
	Tue, 30 Jul 2024 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmfuHjwa"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E103819B5AC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342900; cv=none; b=hl94DVF/eh6kvhlC1Rcf9j9yZ4yfJrnQSCFobHdngOj3gqFzRBikkREa/aZa/D7aV6MX4Zkgs2k5nxV1QDHPiHXzDoyCYKh5iZ/HcQafMgDfUM2480OJ2lD7t/jD9iBgGyCnrum9lGWgHtfSf022BL4Iis3gPV0cEU4eAK0a1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342900; c=relaxed/simple;
	bh=ABflpZKoOYsEzqc2k5CwUb1A4GL1l+x2TfH1iE+T+lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXlnAsTC//0U4ORF0XHQg5fOq5X8/gz3fGTobsU6+KV3FIxx5i9h+zgH+dvs8c6iYUedMKsiBSXsVgOLi1104h6+tomT2E2mTED9Mrr3ayGKnxw3tjbdfJUxi34XcJUaQ9hdksqrV7Yfym2+HVGhcDucTvPC8cvJphmya2B5qzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmfuHjwa; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aa086b077so394195366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722342897; x=1722947697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLI0Gp0XhbBdVYY0KCB9wI3IWm4WXL6Bchcon2mCV3c=;
        b=VmfuHjwaTo1CJfvSHdUkbO7ie2SxkGKDRVzAQ2ibAfMu32ZrJ0Gfjxf+R3W+wBlOO3
         3wsS/F3OtZ5Hjn6fElML3U58BMtAr524gxbbOFx7ixgQF06JIzFajZPsmQglj4xzZaIq
         2/kNHcU8WgM37PHe6KEVB14thkXpr2Vl8IbcaQrgfCtwKDjOr+i6eJudFWieVD8JNWJC
         yu2UWaoRU+v05XZlc92ms7cvIZhJLyGSgqsB/puqFTaPwEK4A34cCHmG7KLcj2uYpZ4t
         zUibGy5kmASIC1jUx4E2qaVfpuBPDpcaoSjrx/g1BJrwlWNLQVve3LEFLqZogwefL0nx
         j9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722342897; x=1722947697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLI0Gp0XhbBdVYY0KCB9wI3IWm4WXL6Bchcon2mCV3c=;
        b=LuwxAd+NaSiwFhpFnmKFQMdUSymI0Cl6fmGZqKMuqVwPUWUMYLa/rk9TsHTXwqPgs9
         /waxssKsohAotdMa2K6I79zdWCHQ/+zhIk32B/01iktNV0LlOTqqu9R7SJ99TTkpVcWB
         w8jkbi+scNipAKT8AtNkjekUnVOVFXtReH/g0vg9Z4I8bYh9Ak1NW0ry4NWMQNUZqBJ+
         WVvZNS6tlaz9L6Lun5Ovx/kZJiMRqaWCIU2UpbgolKmT0liEf2DOUzceERTMhK4/xapI
         5YtwTGG0ikwMKwmCCo3D08Wnec8RyH7TGENNYHCV1BMpqA+Lj3KWkmph2zC+cCD/IAlU
         CIsA==
X-Forwarded-Encrypted: i=1; AJvYcCUQB5+1DeJoBA0/aJ7V8B7aZu8XwMwypTwAf9epnxsJKnWo3eZdw2VQ9UgxGoHg8KqOvTHdIWiVRu5k0QHvLI4qiER6M+SIytmHmog0
X-Gm-Message-State: AOJu0YxUxNTPg7PISYFNTcB/EPeL92mywRC+SfrLWEzikCQSd5IG6Hhn
	BcVPOqOHuOjKHluR7TulenOmot07c2I1RIEVPXiCDz1ebx2AYFBA
X-Google-Smtp-Source: AGHT+IFJtDD5DJfLtCJSd2Wgv+RHdYMTSm8PvQx9eEYwTfX+WWDBmTdo9xQCQUn/uNc0tXh6MU4yxg==
X-Received: by 2002:a17:906:99c2:b0:a77:cb7d:f356 with SMTP id a640c23a62f3a-a7d40112387mr826769766b.51.1722342897032;
        Tue, 30 Jul 2024 05:34:57 -0700 (PDT)
Received: from localhost.localdomain (93-103-32-68.dynamic.t-2.net. [93.103.32.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad414e2sm638429466b.127.2024.07.30.05.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:34:56 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/z3fold: Add __percpu annotation to *unbuddied pointer in struct z3fold_pool
Date: Tue, 30 Jul 2024 14:34:17 +0200
Message-ID: <20240730123445.5875-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiling z3fold.c results in several sparse warnings:

z3fold.c:797:21: warning: incorrect type in initializer (different address spaces)
z3fold.c:797:21:    expected void const [noderef] __percpu *__vpp_verify
z3fold.c:797:21:    got struct list_head *
z3fold.c:852:37: warning: incorrect type in initializer (different address spaces)
z3fold.c:852:37:    expected void const [noderef] __percpu *__vpp_verify
z3fold.c:852:37:    got struct list_head *
z3fold.c:924:25: warning: incorrect type in assignment (different address spaces)
z3fold.c:924:25:    expected struct list_head *unbuddied
z3fold.c:924:25:    got void [noderef] __percpu *_res
z3fold.c:930:33: warning: incorrect type in initializer (different address spaces)
z3fold.c:930:33:    expected void const [noderef] __percpu *__vpp_verify
z3fold.c:930:33:    got struct list_head *
z3fold.c:949:25: warning: incorrect type in argument 1 (different address spaces)
z3fold.c:949:25:    expected void [noderef] __percpu *__pdata
z3fold.c:949:25:    got struct list_head *unbuddied
z3fold.c:979:25: warning: incorrect type in argument 1 (different address spaces)
z3fold.c:979:25:    expected void [noderef] __percpu *__pdata
z3fold.c:979:25:    got struct list_head *unbuddied

Add __percpu annotation to *unbuddied pointer to fix these warnings.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/z3fold.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 2ebfed32871b..379d24b4fef9 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -144,7 +144,7 @@ struct z3fold_pool {
 	const char *name;
 	spinlock_t lock;
 	spinlock_t stale_lock;
-	struct list_head *unbuddied;
+	struct list_head __percpu *unbuddied;
 	struct list_head stale;
 	atomic64_t pages_nr;
 	struct kmem_cache *c_handle;
-- 
2.45.2


