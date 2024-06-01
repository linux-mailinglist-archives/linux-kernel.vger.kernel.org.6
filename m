Return-Path: <linux-kernel+bounces-198046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAEB8D72C4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865CE1F217FE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 23:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05375502BB;
	Sat,  1 Jun 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yRqlS/sR"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D966444366
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 23:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717285126; cv=none; b=QFl6E+sJ9m1XSp1ZeInqTZdU2mcJb9NSWKdI0ZHSpvJHCxj6yQL+yjEr+PmHrbdCBVN5VaTsva9eqPP8yFzC3aL9r3t7PoG13q08LsscasZYeBGYKyVVAmpqrePk6llU1BDYN5SG8EqK+CAiKWMGDoEzRgc01HSZJLqDWSvstR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717285126; c=relaxed/simple;
	bh=YGSo7bG+CVxTrsXCdfBRBuScN4cwkutrM9kK/+P5JwQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qxx31MjM7+1+kzrAqAjR00HRsIZWkNem1eaQ4t+N/dx0L0lkeJbuyomFWLT+0t7ue/xxjnsTlYNQwYsEJYOTYkh142uxCvCKQv3DHynvYMdyk3luqg7YOpMOktX8Xnbi/RUTmUOQYSmsmWunz3kG7uQSl4WlscfvXIH5makvLiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yRqlS/sR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-629f8a92145so39465547b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 16:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717285124; x=1717889924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FPlK8KMOgiMH8BL53S6QmZVvN+9Fwb20HpIRKgBlI3A=;
        b=yRqlS/sRirV602MobLDL8IVK3+OjkYx0jscuRGCqWZ83KgUA2D3UpBmqIX2lToXUH+
         +uLgv6+QvyZPJD+18rfoDFksjzq/P+XYu/fL7WA70Hcm45Sg5jAqbajzuuDslkr6gmNS
         VFU7PsmNeNU/V4WunONPJKR/3UxGUvjyCrZrn50yxuwVkYVPX7EzJ2XSyvTRjfVK74Vv
         k63P7JJi33CnAEFRzELU8nhxzQM1SmXFDBBTJVM3+b9x4gSOMhlvfiuHk4QCfUnbd9tU
         bn9n/Vh4GLJhC6zbuEfElh2Y5zPVhbQ7RlwZQ1cQoWtChltzv+1J6lg9ErVqcQW4WUeK
         pBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717285124; x=1717889924;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPlK8KMOgiMH8BL53S6QmZVvN+9Fwb20HpIRKgBlI3A=;
        b=k8pbS3Fl366JVW3zy19ELjV3QTM4YpdOOxH7DVTRr+tKVru1QM2CUZ/gVISLYdYaZC
         KOxH7yFZ/8qhHqNkRn3xHH/UDcKn1bpOcokYyaDxj3fp7Pt2nAf84c+83IFJzqik8Y1E
         D7mMDZeNAQEuTquk0uty4wA+gZZx+3B9Cx0fcKegPcaRFzbz6fcCHJFQSbxA1vusRX7q
         Uj1L3OCH/nBdTwrTNtCaKkV239UrYkKd91PHbQeuxBOmfmyWf4MTl7LIsS13gAf6Fv6J
         xpB0VTCIY85bm+JyFE4KRylTTYgBJV2Ebs21Dx5xw5aP2tTfVAV9rEikB9Dl8g51o8bJ
         UIWA==
X-Forwarded-Encrypted: i=1; AJvYcCW5zuxOhrHvaZNJkdgxTsojGlThQkFYfuhyDjgbysIcIPPbimMsTz1hayB+hOvY88jWmipBf36wxCPtK79TxMNqi1TuHoUP2HQ9399U
X-Gm-Message-State: AOJu0YzjlGdJPp9mHsRYQgrbkyFyIuI3BrBpV4mmDXHnVhXytVe9IGg7
	soBZZxG/LQ50MJUkhhwjUudOfRfZtmz52QEYEi4zXBncig+8OulMRfaD+LKDDqLo566ALB5ZtF4
	+KQ==
X-Google-Smtp-Source: AGHT+IGm8HxfFZovshJ86zIj9g/16DuQC3fPXmHv4ccZrIbf0SyFq/cubbk5fdciVXmRxizXb7oOgEqk7+A=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:81fd:fd40:a37b:76d1])
 (user=surenb job=sendgmr) by 2002:a05:690c:d83:b0:62a:45ce:a268 with SMTP id
 00721157ae682-62c79863e6fmr15511257b3.9.1717285123926; Sat, 01 Jun 2024
 16:38:43 -0700 (PDT)
Date: Sat,  1 Jun 2024 16:38:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240601233840.617458-1-surenb@google.com>
Subject: [PATCH 1/1] lib/alloc_tag: fix RCU imbalance in pgalloc_tag_get()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, pasha.tatashin@soleen.com, vbabka@suse.cz, 
	keescook@chromium.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

put_page_tag_ref() should be called only when get_page_tag_ref() returns
a valid reference because only in that case get_page_tag_ref() enters RCU
read section while put_page_tag_ref() will call rcu_read_unlock() even if
the provided reference is NULL. Fix pgalloc_tag_get() which does not
follow this rule causing RCU imbalance. Add a warning in put_page_tag_ref()
to catch any future mistakes.

Fixes: cc92eba1c88b ("mm: fix non-compound multi-order memory accounting in __free_pages")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202405271029.6d2f9c4c-lkp@intel.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/pgalloc_tag.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 86ba5d33e43b..9cacadbd61f8 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -37,6 +37,9 @@ static inline union codetag_ref *get_page_tag_ref(struct page *page)
 
 static inline void put_page_tag_ref(union codetag_ref *ref)
 {
+	if (WARN_ON(!ref))
+		return;
+
 	page_ext_put(page_ext_from_codetag_ref(ref));
 }
 
@@ -102,9 +105,11 @@ static inline struct alloc_tag *pgalloc_tag_get(struct page *page)
 		union codetag_ref *ref = get_page_tag_ref(page);
 
 		alloc_tag_sub_check(ref);
-		if (ref && ref->ct)
-			tag = ct_to_alloc_tag(ref->ct);
-		put_page_tag_ref(ref);
+		if (ref) {
+			if (ref->ct)
+				tag = ct_to_alloc_tag(ref->ct);
+			put_page_tag_ref(ref);
+		}
 	}
 
 	return tag;

base-commit: 065d3634d60843b8e338d405b844cc7f2e5e1c66
-- 
2.45.1.288.g0e0cd299f1-goog


