Return-Path: <linux-kernel+bounces-432052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4035C9E4712
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B18B67784
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672602066F2;
	Wed,  4 Dec 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLzC5YlO"
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36538202C25
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733339665; cv=none; b=BtyDumwzPiiABjPTWXF0iwjDx0vgE/iHEzOfjmtXvS3lYJ1vNm7aGroy2hb+44YU0M5KOZ1/ZmDRe1vVIgrFgv0CK6x/EYlwkUHYu+qElpFnftDi2Jw4pIBfnlotYUnLTRkQkw93ac+Wi2yWbumP/MzUoTdjfixTjpunKpEzLEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733339665; c=relaxed/simple;
	bh=xFw8gMJXJ08WDMuWWWZTgPnAYLLdNgG37mOiDKQ6GfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D+dq1PsvYWDuXjeUz4li8afmS6cWttBsV487svbEihRMkfEkPbAXcxXUjpoHk5s3PfONIYPtR1F9RSMXXVpbqsz72NR77Mg/6xM7S3zxZvJBOWMw6Oqk0y87pn8hc/WC1lgHn35SJWXg8+9RtffMnGShewH4893ugpr6wUE+YDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLzC5YlO; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-46720a5dde3so1666771cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733339662; x=1733944462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0Bh/8/p57GgUO0KFv6z2qw3B4ssWvPHnpaRRwgHkKo=;
        b=RLzC5YlOkHSg5BEp9VK3913OpLGrLK4OgYjfdvSzcOVUpnM47LjFNp4MyD4pSxJr28
         4klhyJ7clyEi2w8gqLffEOKz5UEREENNz3K1l8RWmfYDedVORsdpi5SVKlKP7Ax3mYuS
         zcD2oltS7NeXcEB+hH+ULoYe8G/AyaiDNJqt1SSAT0O36G+d+0Wc0Bx/n/Z29lcExIDI
         LVeKySYNhbFhL0e6ra9hxwatT95xCDId4+U/T8DGaHztYdXeijwdNk090H4mtF0zTPrC
         ohIfq6MXSpwiXUkBjzH2++5Y6Cqf3Ehb+2+9ITgOJoCjdjLrIdT+LpRZEvcMtbp9bBeQ
         ZOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733339662; x=1733944462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0Bh/8/p57GgUO0KFv6z2qw3B4ssWvPHnpaRRwgHkKo=;
        b=vBchplgDOHQxXzX0zfbWwCOlDW91ESBZAcKhE8z8UMr0YfyNcPx0CDa4s7mJpNjUVU
         aONI2OzOvg9rMY67EeRZtT7HWiHu93KB5RrN421dLveY8dckz8LW2Ng6A3MXsPMGOl+V
         GRB7iBZpk8l1NawZ/6K0MZ/CQgqHZLM9oOZXoFyOkwSUP/NWr/r+88riHBV5OL8Fi1vV
         3uDdfuEXc0khshQm1skPKD8+oS5wYnnUA/2zFphLDYQu0cRCKJCndpyg+Oi03pLSlOs2
         maRj534ytrbwblbEGJMiOhSyMHKGhc7NypVxTqwKfLxobH0l8R9xUJWlV7t+gEF43eh0
         MalA==
X-Forwarded-Encrypted: i=1; AJvYcCXS9fdfWztB2S4FZ15onABnwoTqPK/lL6vUzpgdsTvhvFFbEloRSofkbly7RByNVcO16xdVvRiKhbAUaGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvrYTkgvgFkE4r5upYsjupSaiJop8RCdp0WhYrHojpc+hes0NQ
	JpfFcOzntxYxgNEaxb3d/0vLsWN3fLfQ06Mix5eWIeHRKby8pwMPr4Arj7khHkjoFLKgYu0p96T
	VKplYucxuZImxJwfEiw==
X-Google-Smtp-Source: AGHT+IFL6Yzt0JAsezCjVnC1Ege7Dcb8t0Na16LNTuDgarqYjisKQzOlRXRbl7knWaQbVhi5EaZ6me/AizxIjPXb
X-Received: from qtbcf26.prod.google.com ([2002:a05:622a:401a:b0:466:a2a5:c51f])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7fc4:0:b0:466:7a01:372b with SMTP id d75a77b69052e-4670c0c1884mr95272281cf.30.1733339662158;
 Wed, 04 Dec 2024 11:14:22 -0800 (PST)
Date: Wed,  4 Dec 2024 19:13:42 +0000
In-Reply-To: <20241204191349.1730936-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204191349.1730936-1-jthoughton@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204191349.1730936-8-jthoughton@google.com>
Subject: [PATCH v1 07/13] KVM: selftests: Fix vm_mem_region_set_flags docstring
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Yan Zhao <yan.y.zhao@intel.com>, 
	James Houghton <jthoughton@google.com>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Anish Moorthy <amoorthy@google.com>, Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>, 
	David Matlack <dmatlack@google.com>, Wang@google.com, Wei W <wei.w.wang@intel.com>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

`flags` is what region->region.flags gets set to.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 480e3a40d197..9603f99d3247 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1124,7 +1124,7 @@ memslot2region(struct kvm_vm *vm, uint32_t memslot)
  *
  * Input Args:
  *   vm - Virtual Machine
- *   flags - Starting guest physical address
+ *   flags - Flags for the memslot
  *
  * Output Args: None
  *
-- 
2.47.0.338.g60cca15819-goog


