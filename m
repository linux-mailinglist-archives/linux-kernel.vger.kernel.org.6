Return-Path: <linux-kernel+bounces-248417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B8492DCE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A57286B82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00048161327;
	Wed, 10 Jul 2024 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQ37ehsA"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07A215E5DC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654968; cv=none; b=mogf9og6BNJgo7uv7+R5M9raoE7Xw2hfttnedVf1+ZqcsIjV3T2NydU8RIgXdULGkITFryAvIvVHYuRSz+HoAlcaKsnrgACkuWjunHb2kB3R/JWBpdc7Zw+trb2p9vZ5E69plF035A7BTOwKV16vVwvBmL1z/e8F2jEQDY1/oRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654968; c=relaxed/simple;
	bh=oWnYdn0BgDHSxRNKslgfesdd9yEejwT/yhYAWEJx0EU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aOxHnKJYj2CqSaDa+ftb96nL0xXkCAUkRdHX5GT8U78esyT9Bj0W23A46+pL42mCKBXu4prZX7V92umn6z5i9+AtKpcbpaljL5DK8SOAIviaQ9xLbNsw6aZHoHyg/Qz3nsjLxEVokEiqKJSTsHKLC7q7Ex/xfz8nTDAaqKFEn3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQ37ehsA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64b5588bcafso5499577b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720654964; x=1721259764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W1e4HHE4z+5Knov3l2/RvFGqy44M6oXcmkh1U5rufQM=;
        b=cQ37ehsAZHZ/fS5YDkSexvaRxXJno5PLOWbF8zdHMICrqwfOM6TRgcGsE89x2vuS72
         qTVVdk4N0P//WDrPT0pDJTlOK+RrwdLAGNlO552d0ONRNWj/YLYAS18nI8inrML6kk1R
         hgYgHZmesf7EtVfrnnZhNCURHJlggTCyyvHELrCfOKc8W7GX1ToTkM3HAoKtfcFQKtRe
         uwoA01PReifS6nRjBcQqOLDYh81N1ussNCyn7BidgbzR3Pdg3TJ87VPyVb35DSw0E5Bp
         uOmuVaKQayhqV+LX2NXp0cof9ZefM2SSQLQNeCQC9y/++tmRAcMQukN5VYYJkCXOcrzR
         /AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720654964; x=1721259764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1e4HHE4z+5Knov3l2/RvFGqy44M6oXcmkh1U5rufQM=;
        b=aCxbr4+Pxgt0lsFQ+wjgrxLlVfE7PAL/kiEFsyu88KVKdtUmGozAOLuUvqar2XwED4
         UjGFAmCk7UpGx64jC0DxT8ic3ZG6alzSh/MhKT6GVX+3z+JgMulw0r0v8syDMXck0YKH
         DGef7UlLi1iUVf6AHjWHiE3xckoapp7vQJTcyqLYLA+/w6W+XNIv+I9E6u27Ku/kpPG7
         BNqFZqy8Uj2i4Pf00bvSyzMAfHjlY+TBw6+tV3jhhMpUZ+Qied3ALvG0Cavg+b+xls2u
         jhYAf2aKyiDO2b4wMwyEFpqkH2FMP+eaNF2MKHO965i0uBor8UKVNDgd6YBNSJ1wy+q4
         0zzA==
X-Forwarded-Encrypted: i=1; AJvYcCUivEGCxohaleUwEuIFb4nyLG7OvcaO5uHYUsG5PkOkwm9KbkcSvdU+L3RI349KNpKircSkLykTQkiQXccLU/H/9kgT6raT2cBq1Vy6
X-Gm-Message-State: AOJu0YztKBA3PGT4OLcnfUMnMoipo6eLIF3W2y1f4ICPJq+IRwdwrx9r
	w3ie+A6viUwt5V/OcY3WpfejjqG5wHRSSSzlvu+nFznuGYPLk3L5hAqgLwUeNYOR/gZ3pedHvNk
	TjTWTu6hYWtH1ynphcw==
X-Google-Smtp-Source: AGHT+IH5NTISR7DBZbSKRJUHRXFWyLuVrVBePrqFfNwytKF1BLIU+MNslDD3lgHeZpjWWwkTnE/TGMGwZ5jaEHpH
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:690c:7244:b0:62f:22cd:7082 with
 SMTP id 00721157ae682-658f01f530bmr1591717b3.5.1720654963909; Wed, 10 Jul
 2024 16:42:43 -0700 (PDT)
Date: Wed, 10 Jul 2024 23:42:10 +0000
In-Reply-To: <20240710234222.2333120-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710234222.2333120-1-jthoughton@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240710234222.2333120-7-jthoughton@google.com>
Subject: [RFC PATCH 06/18] KVM: Add KVM_MEMORY_EXIT_FLAG_USERFAULT
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Peter Xu <peterx@redhat.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is needed to support returning to userspace when a vCPU attempts to
access a userfault gfn.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c84c24a9678e..6aa99b4587c6 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -429,6 +429,7 @@ struct kvm_run {
 		/* KVM_EXIT_MEMORY_FAULT */
 		struct {
 #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
+#define KVM_MEMORY_EXIT_FLAG_USERFAULT	(1ULL << 4)
 			__u64 flags;
 			__u64 gpa;
 			__u64 size;
-- 
2.45.2.993.g49e7a77208-goog


