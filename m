Return-Path: <linux-kernel+bounces-307527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376AF964E90
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87952825FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F761B9B37;
	Thu, 29 Aug 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BcPzDm0f"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001A1B86D2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958862; cv=none; b=CrL4yEjtOnKfzLzgq06jsrx6i7y0OTZQL+nse64RBw90EifyRMmhWCDanEuFWVbRoLLE4DJw2eRUH5tag/zJY9mZmNjp3fldefMF5Xy+eb0yj9wfmtzPloMMTRKqldCF3WsGC5VbIs+N+e9EyShT+Lg2Ng8hqWuJozFP7WJHAn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958862; c=relaxed/simple;
	bh=cJHMpC7vgpv1Lwn+ptEjWUCI7ldigKfbsNIq3n90DEQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kRTtnILIf3LwD6ty/9WdpJNkMvQQNVBznv6rrZAGfQt3FHtzS/Dh414HSvucIxSAFKYkxMNBk2LDZyYkGXmbHkrkuKHuSUOF89a74rvZA8Jd2UIy/i6gc45rXuL6aZMhXNva4yke3P5VBhHMhILJ3aurDOQbRDDeraqLz5iiUU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BcPzDm0f; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7143af9568bso1051977b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724958860; x=1725563660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bdd1bqZu2OfsU0H+yc8PooA7Q+uh4HMjeMd4hAZvzq4=;
        b=BcPzDm0fGI3xqgL8F3RvZMpWCivktFPuSTeMPhJRxX6cstQP/vROSY5LrQpf/vNHKp
         JyZW3OuyDi1GRQqcWfNFtJS1qqOL3Vki8DcoRWUF6zCwEPxUiObMnjplf80F75Ou6pD8
         H6dOP82n70OMEMDoAoAJnkFbjWpc+EG0yaFiaO6/EfV4Qq3lSr3U1vzdDU+x3ixTsPpC
         9S6+3o1qkM/iaWtmR3QqQK2rvDY+8Vb7z8KmWoOhueegUZNJheWlNuAohQjyO4eirojZ
         M6z+M/Sz9bbZ5ehRt54G3iHd7wH4y+hUoirv0S3BX/OzxuTR/JQbKEa/0aT/ZfZ+RQFJ
         1e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724958860; x=1725563660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdd1bqZu2OfsU0H+yc8PooA7Q+uh4HMjeMd4hAZvzq4=;
        b=IKsU6zaPJDdvGcQ6FnBPTmKsSImkvsWzpu4/YyHfwd705S0k4EeLRqniYEVWim+hHM
         Z6pY6TcWIT3XdCPBnmzYtAALSlWMCImgMHwO0KnhYOIMxqsw1Gr2kzH3qTI5O9LsfORu
         EpNyu7qEyEGBHS8VSop65xI4zimkJa5cHAa5uP+5LdBJMxJhJ6wLamwCnLd3N7i63Xi7
         Zc/spYS9x0487E6o22cTB9l9/32oVEFqQ589HLYJNq0Wuq1/VAEsaIZTOH9/2h1VlUGj
         HgBCnZKBpy1HW3P56Zti022/Sa0gsLFuspHHmm5OMFk/z4KSpOXEvcLJB1Nwmj149W7B
         Py+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwVVdqcLzwvLXQK2Z/0Jm5fw/Y232MGKWFsLDpPVQ+XPwy8dAWEOQ8PMMg0Q2+s9E2HZR6XbnBpqC9Kow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCsY+lLZe4kl6xnofqtnvx0bRbLhOpoEupln5qmugkY+Fkwc0w
	0lXE0FulGgTsjCmNVOfSs5Mwc4rUlc/nWHfZA1eOEztFwj3n8/x2UTNARssQyglvSX3REXHxP2V
	z9g==
X-Google-Smtp-Source: AGHT+IFI5knHr8eDZe+aAWAjZbJUFgdwRoECKFK9pGBCJ6gib+ILUE8raQtt3xxNRmgbuz2VadvCBGfBPsc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:82d2:0:b0:70d:13c2:1d08 with SMTP id
 d2e1a72fcca58-715dfc74100mr8803b3a.3.1724958859860; Thu, 29 Aug 2024 12:14:19
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 Aug 2024 12:14:12 -0700
In-Reply-To: <20240829191413.900740-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829191413.900740-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240829191413.900740-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: Write the per-page "segment" when clearing (part of)
 a guest page
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, zyr_ms@outlook.com, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Pass "seg" instead of "len" when writing guest memory in kvm_clear_guest(),
as "seg" holds the number of bytes to write for the current page, while
"len" holds the total bytes remaining.

Luckily, all users of kvm_clear_guest() are guaranteed to not cross a page
boundary, and so the bug is unhittable in the current code base.

Fixes: 2f5414423ef5 ("KVM: remove kvm_clear_guest_page")
Reported-by: zyr_ms@outlook.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219104
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 92901656a0d4..e036c17c4342 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3582,7 +3582,7 @@ int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len)
 	int ret;
 
 	while ((seg = next_segment(len, offset)) != 0) {
-		ret = kvm_write_guest_page(kvm, gfn, zero_page, offset, len);
+		ret = kvm_write_guest_page(kvm, gfn, zero_page, offset, seg);
 		if (ret < 0)
 			return ret;
 		offset = 0;
-- 
2.46.0.469.g59c65b2a67-goog


