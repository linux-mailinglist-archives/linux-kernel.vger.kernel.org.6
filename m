Return-Path: <linux-kernel+bounces-439107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A599EAADD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8164166450
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA062309BB;
	Tue, 10 Dec 2024 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KY3L5Auj"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910D2309AB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820164; cv=none; b=FE3L/NyV8lqqJlGkF6T3r2lHhlY2sx8zYRkEcXU1zj3RAUWOkhtvjvK6rKjHv/7w+O+qLGnrm+iAXQCqgmAb5Sl4qMvykrkdWP+kLly/dWkkXla5mPUlA/jqLe2xX9FFfmQXEwpOqm13J5Rjem4V/kPPwSGIlD1J7C/TV/4PD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820164; c=relaxed/simple;
	bh=PodjqrPVGlUWwKYl8BcoAYxdo5Inlm5LcMY0Tm2hEx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CbJKAV4xW+EhQ4LssL/oKvcGcA5DorPBA13STexHFtRVZx6jwAU7RbHiqNwgPByFMYZMmAbzqmHb9XKm6N7SJ1IYImxuZxLVvBh7wSHss/g8aPXR0dPhgMvFelVuL3sCUUjpjmuCYGLkuS/hYHJEnRedgWkAQeaZ/24SVjzTy84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KY3L5Auj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728e81257bfso17812b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733820161; x=1734424961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zax7EN62Zge5TyiAMCtlwlcwdhFoF4SzkCJ1+TpsME=;
        b=KY3L5AujjIHDi9g6o8uGF7FEEern1o9kpa5CSIJF+hARIVOcopWGZb3Pnl2r5KkhQk
         kafA+h0xQ9SWES9F2ZOFAHvpLqXKh/Kp34jeVaB2P8UxXreXz9ty8EiabYPbk6m9p1e2
         94v/OwFAbxe9AaJJjUHe2tzFCXaf4eYhGlTNFxXLGJ+1w26xQ6giAo/F0xqKL5Ij+gDz
         ENygu/T87Z3bkduXRra3E/a69/sSABD013FaULbGAcDqcfX71C71VpjDwR+JPjVqGDsM
         ajB0ENtSQzpYPXZImAXwg1erm2Si04Xm3Mfl/I9uHoqpkxFTCa97iYswpjqy/tMxFdoS
         xaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820161; x=1734424961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zax7EN62Zge5TyiAMCtlwlcwdhFoF4SzkCJ1+TpsME=;
        b=E21uYsFRxNXeRSQhjQVpRs6yijG0oxSYAlSuz4etUykgBghcT6m82WMc+h4r0qokzW
         MX8039n4EWI48E6dtunXwm5qxQbD47AQ/y7UWOmudTlNG6jpJjGbRvDQYcJ8/GsVpdjR
         JFP1tldQgdyM2EhaMGxEBkzEL0dQ4CoanCKebDrWVfM+u3JqAlBZK1KB2fvAklei3D0J
         +O62vG8wTf8nqHx7rZPBctjJmHiRS0QaUqxMlwkpLcJ2ULup5PPsZB9ifDAwV8uMyNXy
         FDdukeGDTcw8w753hzunqw/Xp7TASRhR5TCXKr4Kt4pBuHBM3aCP4sRLWk6UMcp1t1xr
         jiEA==
X-Forwarded-Encrypted: i=1; AJvYcCVeVvgPwrFS1HoPJmHwVbIzEcAuhDIsm6Rc+BHhmj908hdAzZbwCfimcwf7QQGd26LuYXwHCEQQxAaB7wA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6K8Ge0sbQm8b+xPe/iLw+WWaTiSdaSa9Z7huwUJV3ewm4CV6M
	6nj2yGdsdXEvbudS63qp7OMYce1GVCESTZBvtz4QOnDva8bxPCkljkxO92Bw5Go61aDCt4h5uaB
	9
X-Gm-Gg: ASbGnctS5dylC3fwXBcBL5ap6EflUDRyYTD9XbyOz9QIlYsDnJ8WHycqs0NY96tU6qm
	Ru+c8jojrKu35PW4NeL9Jrfc+kYCv4ysqrhBqg8TrasrSf2MjNs9PrIYb9/gGDpRXPZ+Oupztd9
	ndSAGyh/OuRzm5WTIWy/C85k0fBRnv7jevkg/+1Wz0nKoKWpGoRWYZrC+qDQW2V2l3VICzkpl3Z
	M9SknM69qzpT54rjDFKhgnmxEzBMXBEQvsS+aJod6P4P1UMXU+V1suu5NIadzpSOJbi7BPTqNaE
	NMfe/W9Fh6NOCrhbyMU=
X-Google-Smtp-Source: AGHT+IH1gRl/JKCwvOjoMJe/2aqSAEex1BHuTnYZJLpcrk9acieiAuFurl5AA3HMy2rCqLHQ4EoUsw==
X-Received: by 2002:a05:6a00:4613:b0:725:8c02:8dbc with SMTP id d2e1a72fcca58-725b81b5cf5mr24503375b3a.22.1733820161348;
        Tue, 10 Dec 2024 00:42:41 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5ad8sm8859539b3a.8.2024.12.10.00.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 00:42:40 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 02/11 fix] fix: mm: userfaultfd: recheck dst_pmd entry in move_pages_pte()
Date: Tue, 10 Dec 2024 16:41:56 +0800
Message-Id: <20241210084156.89877-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <8108c262757fc492626f3a2ffc44b775f2710e16.1733305182.git.zhengqi.arch@bytedance.com>
References: <8108c262757fc492626f3a2ffc44b775f2710e16.1733305182.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following WARN_ON_ONCE()s can also be expected to be triggered, so
remove them as well.

if (WARN_ON_ONCE(pmd_none(*dst_pmd)) ||  WARN_ON_ONCE(pmd_none(*src_pmd)) ||
    WARN_ON_ONCE(pmd_trans_huge(*dst_pmd)) || WARN_ON_ONCE(pmd_trans_huge(*src_pmd))

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/userfaultfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bc9a66ec6a6e4..4527c385935be 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1185,8 +1185,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 	}
 
 	/* Sanity checks before the operation */
-	if (WARN_ON_ONCE(pmd_none(*dst_pmd)) ||	WARN_ON_ONCE(pmd_none(*src_pmd)) ||
-	    WARN_ON_ONCE(pmd_trans_huge(*dst_pmd)) || WARN_ON_ONCE(pmd_trans_huge(*src_pmd))) {
+	if (pmd_none(*dst_pmd) || pmd_none(*src_pmd) ||
+	    pmd_trans_huge(*dst_pmd) || pmd_trans_huge(*src_pmd)) {
 		err = -EINVAL;
 		goto out;
 	}
-- 
2.20.1


