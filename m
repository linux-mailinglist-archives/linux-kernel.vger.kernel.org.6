Return-Path: <linux-kernel+bounces-432054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 390CF9E445C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E869A2880D4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63BA206F31;
	Wed,  4 Dec 2024 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZCIZO+D"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21951F5430
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733339666; cv=none; b=GYWyKk7qipAHZv7dOo9uLN7qvvBGMiECvfxTEbQYk4uENvPJIRXyyfifWfaFbISf5xufyKN0VnKznYnWV9kuRqVOhr0OLSDH+6GdknwY7wuwRYA3PtgR2qjme6sCVtKAOQ/BPyjY8Gg3hL9Pd2DIvGpZi0DRKnmqiOOrGSP+0w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733339666; c=relaxed/simple;
	bh=+IUtnc1DFoGPVy1DRFRoxmxu2aWJ46Lvmm6jdceQ08U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J6y7zF+Prnuc2+w/qGU9YRYiJiucNyXehwZh0aifW7oY4O5zER4UqSjgCjF9RYb0xQrJUKcm6BHcBGH1rtaa8bDjWyLIgbqHu8RBOj9I1iaqbHKY7a5SdP/QtTK2m/tF4cwaUdzxkUpIjb+tHvaqLP9XNWTgugjQy8lv5TGTgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YZCIZO+D; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b676e150fcso16685085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733339664; x=1733944464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gP/1ZRcuFjEEMybT5UMVVNt/puu4fP/kE3PemhzVNvM=;
        b=YZCIZO+DbqhbehBvM69e/tEJJ8i5uXPoksPv/Ke0UFiHSA7MXTrhPGufAqeGVtdTwu
         SwqXXdHmPMagW4HABsEFIIBJezCiRYotazeptUCHcPr8zR303RpnZw7IMYZ8TJySJTVb
         e04Ypoxa+s5hZTPssoLkzp0sZzAp3+SAxVw/vpSghCJTneWTOXOfpMj9xuf0j7xHZFL5
         s11MEDla4jfa0ononUrJ+VA4hzP4lgFI0Dg1rLYcod83Lr23FYaI/bpxjbkApzrg1nH2
         XnbQqhDl7WiLcOSZ6yd7t/NrFFM3f7OOu68l4vyQQsNnGgp35X8U8fM8pX1a2NZr55kv
         HW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733339664; x=1733944464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gP/1ZRcuFjEEMybT5UMVVNt/puu4fP/kE3PemhzVNvM=;
        b=ArEk0bwDUYCIYQr17yDYBkpJWoltbTDofkdRCTP/kb/ZaDmqeNs0d0I3rsMYw/Lx4a
         p7iBGtxXfmaqaoY6ZqXWzmJl4FWgjOvfi+Do/ujLbqy2zyuMxD1hyxriX5aKeJuuVa27
         0diJnHT1vEU4iMsa44dWQqWI6HhKxROQUc3PD/kSC2KOT/5XAm5H0OWO01zcl9gTDthq
         vQC2QcDR1EzBenFUeG398MV00CLTocwgVkX21//LPvQfxN29sl5VyfHQfgEhAROYB7XJ
         e1K3o+zWNpAgEQTdNW/+yIhsGmgjfy9TqPfQzDuAQP3AC4UOaoidE1wXdgQMlDRoY8Ci
         9X2w==
X-Forwarded-Encrypted: i=1; AJvYcCXEvgPSNRVzzO/gngWZPzaEE9mDy9A155cud40Fc7VQF3q0hRV5/qak0K54MtB3yoFFJKoFNnXCCSDJPBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHIc8cUQk8LtSounae0ce9hH4QVGCf+c1a6T1VCdxkpJeEUjsd
	Mybf/+7rvUVJflfGV78sM40b33+k23qRlLjEQRBSpBbHBzywle91bDZQjF9BBi8jeMKa/KXbxM6
	EA1foVR2ODo0S639NQQ==
X-Google-Smtp-Source: AGHT+IGl8+Y6jXlfDxpaeYQWcz7MkBYaeVCfdRzcMWgZ4EOOrzmqxMS37+BVzh9ZHq4dtxMyhyVDFBoslVL+V2Wp
X-Received: from uabih6.prod.google.com ([2002:a05:6130:1f06:b0:85b:c307:6bbd])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:44c4:b0:7b1:52a9:ae1a with SMTP id af79cd13be357-7b6a5d2aa5bmr858557685a.4.1733339663968;
 Wed, 04 Dec 2024 11:14:23 -0800 (PST)
Date: Wed,  4 Dec 2024 19:13:44 +0000
In-Reply-To: <20241204191349.1730936-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204191349.1730936-1-jthoughton@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204191349.1730936-10-jthoughton@google.com>
Subject: [PATCH v1 09/13] KVM: selftests: Add va_start/end into uffd_desc
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

This will be used for the self-test to look up which userfaultfd we
should be using when handling a KVM Userfault (in the event KVM
Userfault and userfaultfd are being used together).

Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/kvm/include/userfaultfd_util.h | 2 ++
 tools/testing/selftests/kvm/lib/userfaultfd_util.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/userfaultfd_util.h b/tools/testing/selftests/kvm/include/userfaultfd_util.h
index 60f7f9d435dc..b62fecdfe745 100644
--- a/tools/testing/selftests/kvm/include/userfaultfd_util.h
+++ b/tools/testing/selftests/kvm/include/userfaultfd_util.h
@@ -30,6 +30,8 @@ struct uffd_desc {
 	int *pipefds;
 	pthread_t *readers;
 	struct uffd_reader_args *reader_args;
+	void *va_start;
+	void *va_end;
 };
 
 struct uffd_desc *uffd_setup_demand_paging(int uffd_mode, useconds_t delay,
diff --git a/tools/testing/selftests/kvm/lib/userfaultfd_util.c b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
index 7c9de8414462..93004c85bcdc 100644
--- a/tools/testing/selftests/kvm/lib/userfaultfd_util.c
+++ b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
@@ -152,6 +152,8 @@ struct uffd_desc *uffd_setup_demand_paging(int uffd_mode, useconds_t delay,
 		    expected_ioctls, "missing userfaultfd ioctls");
 
 	uffd_desc->uffd = uffd;
+	uffd_desc->va_start = hva;
+	uffd_desc->va_end = (char *)hva + len;
 	for (i = 0; i < uffd_desc->num_readers; ++i) {
 		int pipes[2];
 
-- 
2.47.0.338.g60cca15819-goog


