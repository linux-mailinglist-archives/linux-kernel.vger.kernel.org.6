Return-Path: <linux-kernel+bounces-414233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA79D2503
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1860B280F33
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB91C9EB7;
	Tue, 19 Nov 2024 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OkBF/J7q"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4081C9EBD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016343; cv=none; b=bvKD8ZlC4Jih0BYW+4TC5U2QdO7I4Vz+DOzgdz60wKjDI0JDl/9pbeH0A58aEsXrZrsLQ8TWU3X9Sud/K2tj7ynlcH44Nu6M8n+9HKINhd4g2giQBB02N1jRt9nQ0HgQmGgmbhBpehd4RA5UGDka1a5ToebE9bJSzHXBnJitGRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016343; c=relaxed/simple;
	bh=oZ9tqA6L62aqjrupnvxT6JvlAwUuZLXArFlxVG2qKr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pzk7p6s/wGXlnRj/uS3B7t/FTq/0/4DH4jtyh7uYWPxHn1JIieqLO02mTje5+VtutxuuynIO0wpFgn+4IbwZHfmHRwwTOhV9YB28oL23rtX6QpaLaBcsbCJa5sZdCLkrWJMjLwQ/jv+Q6DsGPaZbOeO2/Co0Dd8nqb2ozRsGt5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OkBF/J7q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315b957ae8so3045565e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732016340; x=1732621140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ5xLXq1auqcHSe45YUJ8SRlrVXe/jZLSm2XCMGI+NA=;
        b=OkBF/J7qYTozvh93wEqnUSzhxgc72ivuqYG/xK4zLSuvckpkekcWO+vYuWLlAlqHF6
         qRK614xsfx6B9KrdN32C2IF4+hN+8wDofxfT2v3EvPQJd8nSv6gjRc0EoyeTc3FKxE4b
         pCmuah9W3AxJ6bpd/pPlQX50f8CwSH5q7yn3yDSSPYaTpvjTY2wD85jR5/3g35GLLVp+
         gqf2w8lt2vC/YASR1mKqtrcvLBSjFxlbqo5iDJLeHgyx2alyKsA+2oeyfj2lHAVwcwnM
         pgSWp+eAviKshgKvZ2yltBEYvYp8Rp0GgVHlDmGduVmMJ3pjLTzo+0Cl245XviQ9CQSL
         9QKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016340; x=1732621140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZ5xLXq1auqcHSe45YUJ8SRlrVXe/jZLSm2XCMGI+NA=;
        b=IxkshmSy6QesP2g7P+CP8/PU0yiQSYhOpI0NsWp1ImYIhas4AFl134wh6W8K3Kjlxd
         I25r+dYtHIIuVerecMxDXtQwu/vvXp35djM36srDk79dk3Od4jEixRSgOpajIC2V/ZDG
         jxr+xkpUw03lu8uhhcSDHMGg7NwhRROtJAqxvF0ja0/O3H64Hh0yYfy1gkU9bpA+NYy9
         xQVI3PgfbxwvsuLLr+9/ByX4OzAzv27eJV/aG7eAxuv+ZvpsbAN3iKirU3/yzOq9a9IU
         TxQ/UCRiHAKBn6WH+HSsMe3JWc2P5Wuw7yrthIKmh5l991IbWwCpD+3tZn0odJc/Hny8
         tv9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe+IRCOkyVjsYQWmBV/AdvoNdrxuh0ybbHEvuK53RerKydSfCVQVFkv/JCPzC64E0jOj5Kru33pJ+lVV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaujPgASlMbp3R/bcH71f7cS0Ms3hPLd9sWeQuhGs8tNwKUARh
	zrztEeFrtg8Q5/Zm5U4I3WdF5NGEMI66NTC7v72We2//LDm1YuMGKvC+Oav8kD4=
X-Google-Smtp-Source: AGHT+IEfjAhyexdqiJfCVcYCeJhp7cyp1yYQsZIhT1vcXE1GZmBclRIgAIdt7QwVoKkA+QeG7xh4IQ==
X-Received: by 2002:a05:600c:4710:b0:431:558c:d9e9 with SMTP id 5b1f17b1804b1-432df78ac1bmr58711265e9.5.1732016340235;
        Tue, 19 Nov 2024 03:39:00 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28b76fsm198451965e9.28.2024.11.19.03.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:39:00 -0800 (PST)
From: Petr Tesarik <ptesarik@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Jinbum Park <jinb.park7@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v2 0/2] Fix mm/rodata_test
Date: Tue, 19 Nov 2024 12:37:37 +0100
Message-ID: <cover.1732016064.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that the test actually reads the read-only memory location.
Verify that the variable contains the expected value rather than any
non-zero value.

Petr Tesarik (2):
  mm/rodata_test: use READ_ONCE() to read const variable
  mm/rodata_test: verify test data is unchanged, rather than non-zero

 mm/rodata_test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.46.1


