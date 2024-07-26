Return-Path: <linux-kernel+bounces-263917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A0B93DC51
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF401C234FF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3659B19149F;
	Fri, 26 Jul 2024 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wbwXGnaY"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4F3190697
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038124; cv=none; b=BIMjrkXNWCyS2m8t0Andv4ECQfKgfgD1GmAUGHTDHuBL8Yw82vEIMlmGoaSmZx1/TiWLvY5BLepuqZoylSY4a2ZgMScJI6Lmhkd2rf9p+DjsEhEyvl5toxk2HMvT3r0hW0TVdSiqNvoaYFGSaGlbnYrFWfKGb44QK9T66afnI2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038124; c=relaxed/simple;
	bh=7Hftste+MoYv6vvr7E6Hei8BDRxdZZ0dk5NIAY9vDsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mKmHrMB1X/Nd3S80sRB/eiUNv/uUNMj93iPMnAEuOBzjPZRDKXSxXNiQvUFz9fzhwhJQjyWBKHrGAF7vH1JUz4D55q/j69nCxrvi/Zrh/4605pVVEYEEFSiLoNUB8CbUH2nDp00RNqxbOcztj+7mzGhdlgzhi+fOlHcemUiRnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wbwXGnaY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664b7a67ad4so6081557b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038122; x=1722642922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dTOlfH+mhloY9mYg+/p0IQai80b+6RXS/WhBEV7av3U=;
        b=wbwXGnaY9nAIseiLuQ4bca3z4IuGDHtp7BYIy3d1mvIArYsO0R4Pr0ghKZyXFT9nQa
         EHt2czpEIrDwsfFZBKXec2oCvXEy4Dm2ZIYotju3sqyA67Xeabk9vizw+Za1u5PnBS9f
         KW5UOI7FWsDM2mATePnEf9NQ5YtQaPJvC4G16vm3CNo4QM0a16siak/to9qKB2LIWkMT
         +F+E84/0qQqX+1UriXVxIsJIiN3cRkAFuZISHYoExZyfTtcZtH1fDPfB7KOLroM4sW3S
         QSUsRqWvdr9J9Xtp7Cmp8aaPh7Xlyb7WgM4bDzk5Fc7E+H9zlxLWPWT7AHNYdWjwTXrL
         z2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038122; x=1722642922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTOlfH+mhloY9mYg+/p0IQai80b+6RXS/WhBEV7av3U=;
        b=kxfJKWZ7289P5yOLv7P8KFdWttBkjIyt7K805IeehvMhuC72a4Ctf7h6qZJ5t0Qwle
         jKTvt95Ykt6Ax3Tb8gn0sLopm/Wr+65+QaxmK9KAvImOQ65nRyMwTNifDei1UEhY/POD
         1l7eBqif6C4qfWD2tZlKYJ+xAfKGka+2faH4513NeohGzqKKPKsmCQTI0R+dTMguVRoa
         TWBf28agnl7/+YO9vr4SkAw4TxklGmVWMJ/VlJwVkdKYDa3PR1yt9l2oPhA83OWV0Nmb
         Jd80/WL07pzeZA6Si/LT6petUgJqoOLo/7CC/ewvTCSm06qZKCuIS7akWoYYkNnO/Q85
         RMig==
X-Forwarded-Encrypted: i=1; AJvYcCWeDJk/Nc4j+MQB4qbDHEiznP46aKAVa8lGqbT3vKLv6VOdgA/qy2sR12yby44PUW5BhWmhVQis2YULaBLnvOKZ2DZHXoAxB7KOQSNg
X-Gm-Message-State: AOJu0YzZ+vRF9MI+3tCWq7S8nqGMwxBLIOWnMZ/6gzJH7yA4QmsroK2Z
	mB8r546ea3oKc2o7Z2uF5yIKCvZEiel5WgAt8i6pjS5nhVGmX2fNXepHGCvYx/p4WTqcHHfX+Xi
	9qQ==
X-Google-Smtp-Source: AGHT+IGgifSFTGz9fVU5jdzVocA5wMp2MITnk/v5MkueXs++Udesz0kCsEkHm8VEDJpbtR+Hv7uv12YKgg8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:f0a:b0:62f:1f63:ae4f with SMTP id
 00721157ae682-67a052e5dccmr429907b3.1.1722038121721; Fri, 26 Jul 2024
 16:55:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:52:28 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-80-seanjc@google.com>
Subject: [PATCH v12 79/84] KVM: s390: Use kvm_release_page_dirty() to unpin
 "struct page" memory
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Use kvm_release_page_dirty() when unpinning guest pages, as the pfn was
retrieved via pin_guest_page(), i.e. is guaranteed to be backed by struct
page memory.  This will allow dropping kvm_release_pfn_dirty() and
friends.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/s390/kvm/vsie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 566697ee37eb..f6f1569be1cc 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -670,7 +670,7 @@ static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
 /* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
 static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
 {
-	kvm_release_pfn_dirty(hpa >> PAGE_SHIFT);
+	kvm_release_page_dirty(pfn_to_page(hpa >> PAGE_SHIFT));
 	/* mark the page always as dirty for migration */
 	mark_page_dirty(kvm, gpa_to_gfn(gpa));
 }
-- 
2.46.0.rc1.232.g9752f9e123-goog


