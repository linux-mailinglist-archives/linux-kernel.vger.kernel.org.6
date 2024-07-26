Return-Path: <linux-kernel+bounces-263870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39CB93DBAE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FC12888B3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ED517F388;
	Fri, 26 Jul 2024 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gyMRMEom"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD917F4EB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038026; cv=none; b=FZbqSufPFBUT+6imjZL7FNB7irtyWcUU08+d2kPf5dCP1MuFEVAYFMuA59G5NiBfbrI44ceZ3QUlPAbFHgLTFZczwnKk+vO6i906u3kq/mwjGGxaEA1r+ATAN3JoBRckERXxA0SNrUIK6xn48ZTWEhsmbK31jBFzidEuM6PxjVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038026; c=relaxed/simple;
	bh=uf9ms+u2NfXkgc6o314wQs4yJxndrotou5MTD6pjg7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GfBEXzX0mnZoamSjVJwQFeet6WDHE2OPHDhU97io2/M5hozJ0kICmUG9Rn6/KNMeu4AY3/t11p07XUXgmouDveLe+5sSKgtHNAJC/h42910Ck4PfBdOnpb6cMEqaW+jLG8fvtyQwg8ayC0+5u7XD5jntpw5aZY8SJst6RdqSJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gyMRMEom; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03a694ba5aso407994276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038024; x=1722642824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bC28fbRseb42Ch2zMqBFWEix5TOk22ZdgToO+ip0K/0=;
        b=gyMRMEom/TNpb2Aguqkw3Kr+W8GXK/pp4oC/n2rU2H6jg8xkOLsImfx1d2KBq1W/KA
         hDRhilSwXDaHxn+hxc0K8RfRSgTrAwYu25j3kBEGHEJXpPkCo109wlhRLMgkAgFEgVtC
         TRb6k+tcTcw30j9t3AGJv2rze6oZbgLTo9Yy+Dx2utk0ZLVArHJQ6PLYJWjXaOjRHfHC
         LaciJesXaFtuZDdXBmzHeP3HdYu6uu6XPV3NInXni1dBocS2VkvLEvf+4mChUxdqSYs7
         7O7bx5/M4cBWhyOc8ePFQR8EAcLoQibQXydg4n/QO63ZJMZylzLXzMbPyQS1pxOsqNdj
         qt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038024; x=1722642824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bC28fbRseb42Ch2zMqBFWEix5TOk22ZdgToO+ip0K/0=;
        b=cuvFi1U4ULrF6LY2S1Jhb0dcoIoyxMsui5yE0whT5QYVr2FFPdvD8fDPY9ZRZasqIP
         Oq6PNQG8tftm/jcjP/8sDu7oPlXjNtmdLbDB/VAafJmH4W4Z6hALp8t5hs1Wor6GoHvT
         4aS+dsTHgokgEiihLWdUmUj2iQsLLOVYarAeHmw6Q2qSAzUHMhYI7AlI3tx6smR+XHcZ
         ssBhdKV12vHd8obySrOj/ZLDsGpQdq6S+VI17Lh522+vBsN4vKU0rNwypED+tU51T8mJ
         CojpDMCWxt8GCPWwWBhNvksiHndoxgzIkZGgP2Ip9zCZn3mSlMojKTPQ6bvIQSbD3JMg
         bWtg==
X-Forwarded-Encrypted: i=1; AJvYcCXzcsDuondDKbFeJfOXGlECinKgomO1m0bqn1uSIO28yQbcAM+qNqE8y96bKxePKADjFTkTI9VfbDHFesnf/QU2kjOX25YKZrZzLujr
X-Gm-Message-State: AOJu0YwN4ovyBKznTMNbzY7cYVoli60AmtBknGRJ+zwBiLIL70sC7cii
	wdAc2laCekvs3qWjH5Kzbk/Ow7tnoQ/KsA7db7zHXuxZr+HyPzS6V1b1HDso75PBHM11NqM/ItP
	qLg==
X-Google-Smtp-Source: AGHT+IFe6CawsiHghHJz6goDA5MI5OiaYSIvtgnV/oY+y/tLOOW/H4O66kyosfEcqs3UQ2nQeG3uHH/jimU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:181d:b0:e03:5144:1d48 with SMTP id
 3f1490d57ef6-e0b5452490amr2050276.11.1722038023813; Fri, 26 Jul 2024 16:53:43
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:51:41 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-33-seanjc@google.com>
Subject: [PATCH v12 32/84] KVM: Get writable mapping for __kvm_vcpu_map() only
 when necessary
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

When creating a memory map for read, don't request a writable pfn from the
primary MMU.  While creating read-only mappings can be theoretically slower,
as they don't play nice with fast GUP due to the need to break CoW before
mapping the underlying PFN, practically speaking, creating a mapping isn't
a super hot path, and getting a writable mapping for reading is weird and
confusing.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a46c7bf1f902..a28479629488 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3142,7 +3142,7 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
 	struct kvm_follow_pfn kfp = {
 		.slot = gfn_to_memslot(vcpu->kvm, gfn),
 		.gfn = gfn,
-		.flags = FOLL_WRITE,
+		.flags = writable ? FOLL_WRITE : 0,
 		.refcounted_page = &map->pinned_page,
 		.pin = true,
 	};
-- 
2.46.0.rc1.232.g9752f9e123-goog


