Return-Path: <linux-kernel+bounces-360365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434DF999A18
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473D61C20937
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D411F4FDF;
	Fri, 11 Oct 2024 02:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5mJoFqi"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27D1F4FA3
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612664; cv=none; b=AxdQazySapfHLfDR4MIxc8UjHeAjmH4fBpzSzebAYzm6DZgQ17R4O6CFiBLdnSqDsvk67TtzvCw+kY14S2hDVUP7SG7cFrrK1c6P6WKJAi4F11fjexZ7f0ybxeYr79smJ0Y7eh/pP3qF1Ie+9WtnvcmLMMB8ywZZRSzwX/9LzMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612664; c=relaxed/simple;
	bh=E3IXDKgcyUCE+TmbZTTwZzg1L4bUxpva3WFh9qzTdFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GcZuNz5DUIIWvcYlY38F7a4SN43NjOXsaZjcEYXKeqsCXx15WNyZKybn1sAvjMU4yISdlHDymuxTpG9zqR3Pe5W/TGAm+o8o9jl6hmv7aR+Kxm4V9BGsvtzAPCwBOGGAOASSRfLrs8A+Kr2ZMSVbuDrmkA5CElaMyN1coP6oRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5mJoFqi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2acec0109so28042307b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728612661; x=1729217461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfRd4YGDidyx6Q8cdQBlESrYYtQMzsNuRjsxO0/o42k=;
        b=p5mJoFqiWrKPNXn3tzposfZ/LwMyFOC4Qi/F6zOxZZ+WzeSw961jBZGR0nNjeoUeAd
         wIutWcEuNHESvCc90p17R8Jmlizw37Vhb+OCnYJ7eDweqT0DMbvZ938z5xWzgTYHaXx4
         UNlwodEOof06CzkhBv2lWbN+KJ/SwjvTP6B9/NOElMthBbV8TgA4G5Z8SLEQP93/BJLs
         AFkkICKF+uGb7ILyteK9uzucetMrRF6M+G0B6ka9RJAJLLvSazSq3cWuWAqw0iWnj7bk
         9SgeLLPICHGUtXrSSfy109fBTNPZtVrXwjKSwxlbLXY7PiPhg//1ONlaP4uuXP7n/iiL
         SqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612661; x=1729217461;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vfRd4YGDidyx6Q8cdQBlESrYYtQMzsNuRjsxO0/o42k=;
        b=hNvz3aKwLOODwOpY5ZDzxcJjlxyRMZQRxwPPMJKQwvG7kT+bUKEozGbAMF3QTZ3QRp
         YSi+xPijLtPteRZrKlaCxyMqff5bfIc+0RPD4G8fymQqB4okytX+MaokJFn3JHCGm8tS
         eXc1kxNahJm8cNdkCSf+YqZgk02pBJYxsqkLFGyqV19LfApMKarnH7/gZxSOQiYb4Zow
         AQxMhCcPzVTcjNhHxhYuKJWEKvhM8ZGXn+/MTtOVTfE5T6YOVm8BRzgfezF7hBkihBbI
         qYtLlJdF3mgseEIcIq454644DxEW3CcppbF/+q6gQO7j2QxBBwIG05LA7VBrU9PJsGij
         cW3A==
X-Forwarded-Encrypted: i=1; AJvYcCXYFrFxhH7ldus3yQ6zWmT+A8TY0ilBudOCDVwfzE/TCU1nouPvZ+zXChXzevmrj3Nd0X/tuppHkdxuF3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTonXFDIP6yUgF5vod+Sqx1Wd0W7s9ax+ipw0hdCJzBWq2xcC0
	Polye0Q2rQedfKy44KP4RxlLBPJZ2yYbOoeF/a914BMfuFKiQkIUPF5maJP4PpXE1ykwlMxHEcK
	WBw==
X-Google-Smtp-Source: AGHT+IGmrtxjHtrBMHGZEUy3JQ2tvJIUU8sN8vV3zTrSpyXnDiKaHwy98K8xzQupsJi3j4s85TEUOMvXyAM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4384:b0:6e3:15a8:b26b with SMTP id
 00721157ae682-6e347c70e18mr57427b3.8.1728612660902; Thu, 10 Oct 2024 19:11:00
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 19:10:36 -0700
In-Reply-To: <20241011021051.1557902-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011021051.1557902-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011021051.1557902-5-seanjc@google.com>
Subject: [PATCH 04/18] KVM: x86/mmu: Don't force flush if SPTE update clears
 Accessed bit
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Don't force a TLB flush if mmu_spte_update() clears the Accessed bit, as
access tracking tolerates false negatives, as evidenced by the
mmu_notifier hooks that explicitly test and age SPTEs without doing a TLB
flush.

In practice, this is very nearly a nop.  spte_write_protect() and
spte_clear_dirty() never clear the Accessed bit.  make_spte() always
sets the Accessed bit for !prefetch scenarios.  FNAME(sync_spte) only sets
SPTE if the protection bits are changing, i.e. if a flush will be needed
regardless of the Accessed bits.  And FNAME(pte_prefetch) sets SPTE if and
only if the old SPTE is !PRESENT.

That leaves kvm_arch_async_page_ready() as the one path that will generate
a !ACCESSED SPTE *and* overwrite a PRESENT SPTE.  And that's very arguably
a bug, as clobbering a valid SPTE in that case is nonsensical.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 176fc37540df..9ccfe7eba9b4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -521,36 +521,24 @@ static u64 mmu_spte_update_no_track(u64 *sptep, u64 n=
ew_spte)
  * not whether or not SPTEs were modified, i.e. only the write-tracking ca=
se
  * needs to flush at the time the SPTEs is modified, before dropping mmu_l=
ock.
  *
+ * Remote TLBs also need to be flushed if the Dirty bit is cleared, as fal=
se
+ * negatives are not acceptable, e.g. if KVM is using D-bit based PML on V=
MX.
+ *
+ * Don't flush if the Accessed bit is cleared, as access tracking tolerate=
s
+ * false negatives, and the one path that does care about TLB flushes,
+ * kvm_mmu_notifier_clear_flush_young(), uses mmu_spte_update_no_track().
+ *
  * Returns true if the TLB needs to be flushed
  */
 static bool mmu_spte_update(u64 *sptep, u64 new_spte)
 {
-	bool flush =3D false;
 	u64 old_spte =3D mmu_spte_update_no_track(sptep, new_spte);
=20
 	if (!is_shadow_present_pte(old_spte))
 		return false;
=20
-	/*
-	 * For the spte updated out of mmu-lock is safe, since
-	 * we always atomically update it, see the comments in
-	 * spte_has_volatile_bits().
-	 */
-	if (is_mmu_writable_spte(old_spte) && !is_mmu_writable_spte(new_spte))
-		flush =3D true;
-
-	/*
-	 * Flush TLB when accessed/dirty states are changed in the page tables,
-	 * to guarantee consistency between TLB and page tables.
-	 */
-
-	if (is_accessed_spte(old_spte) && !is_accessed_spte(new_spte))
-		flush =3D true;
-
-	if (is_dirty_spte(old_spte) && !is_dirty_spte(new_spte))
-		flush =3D true;
-
-	return flush;
+	return (is_mmu_writable_spte(old_spte) && !is_mmu_writable_spte(new_spte)=
) ||
+	       (is_dirty_spte(old_spte) && !is_dirty_spte(new_spte));
 }
=20
 /*
--=20
2.47.0.rc1.288.g06298d1525-goog


