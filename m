Return-Path: <linux-kernel+bounces-248416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE64F92DCE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FDE0B22428
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E0F161313;
	Wed, 10 Jul 2024 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Z2/FJYK"
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A315EFC4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654967; cv=none; b=AZdbF8RX5RpAH9oCjfGq6AOyVFlZ1q/2S/owWBCv9JNMZvI1Z/D1g4CvTXPdqsIYC34JuW/UQmEX/QPPX41U5V5WTaPFWb3SOG/Qp0ROx1fLlpWTRqPtxhUEX5fDrmhsgrwMcLogahg0hUDWDBVJ5K/aSCB5ZMMoWwHp40dlPjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654967; c=relaxed/simple;
	bh=0X56a4gN8b7VQgThnVkXYUH34LPfOMnmnpB6+EHKoT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lvO3odYEocRHhgIw7Dox+Kepp23YB+waLK3zmRi/i45C4o86ty/TKsMyV42Kd2bbMpE+YSkMjwaXvEflaDMeVsk9aT9FDWua+l9oc142J6rpnXm9Hw1UYnt/VUC5wjHP6pMNhVDq5mQvJ5mbHNUr3daQraB7577bV1GnLrdU6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Z2/FJYK; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-8102fc9fdd2so72184241.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720654965; x=1721259765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TURU+uj4JjtASnposo8ch9F78eTbKidxkEMdeXOCkww=;
        b=4Z2/FJYKjWb84XWgA4jz6adOCqXSO4ooYNzTgDHYNBGqj0E9z42IvXZnNdXQKNxBum
         jcKCUM3z8KOnd5wJ6ui3CbRqBDUsgUJxziiXiPB/zifpnk/VQjQhxMh/y+PuaVr/F/Us
         lRWbcVWEEFZ5dWzasCENbA/TX3DR5FBP0gU8C45OMuslryx/Y8c5cxxKYXgBPCKAo5ck
         m8L3XgxLOYRXHGtPZL4CiSQoC17DUn0V2xmj/OoEohSpqapaQxzmChQxiaRfXAlWxgyV
         GueGUp9AeTIfH0uBlAKKZtpU6yGEuBpMXuBSxBJoZwbJl4wnR7mfGa2Wa03Rh3CptsZJ
         I4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720654965; x=1721259765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TURU+uj4JjtASnposo8ch9F78eTbKidxkEMdeXOCkww=;
        b=ahI1LUw5Awxk5W4zFDXnfysdcLhHnFLUYPbL9F/FW6CtpNDmh/y9klovX13g9ngLXp
         i3rHvlkTvzAqEiPeS6bCyvZF4PUWXkw7Caudf88aN7KkiduxUjAvpyc5uV2oEX6mYg7O
         47JjcmrJeifY7s90IBm7Iw/zST+xrw7HxsVowOwkDr/cER1hZEwgYrxm2qLWFCmnn5oL
         SZKJJpBaHRMtEU4roylMbjS3z8LqO4MBnxlnjoxwBUqYkM69Zvn6Zka4uUEVQXgijXCu
         66cDoHlFt6sMU3ZDGEqR6a02CAUbsD+GpIvI4J09q8GWzmJuu591A/5bP4K58m/QtbC0
         8f5w==
X-Forwarded-Encrypted: i=1; AJvYcCVDVgkv0RDLwWmMWrfsizaGfq9tRJMhASqhwUg095IMzDS5WL0l9/pBms6+AvaSTykbcP4HOs9zHhDNsF9XxQCx14BtnKCBcnYnw0HA
X-Gm-Message-State: AOJu0Yw0St7G5D2C7D+rtBQGIAGMu+Pi5XBW38g+rqJrF8Y/q1zGLuVC
	YBKPq/NCOVDqkryBDZEokVWLmJg7McluDhaGKaB5EPdJ88AeHAxLVP7DFgrwrsfMAYt/FYR3L+4
	/ODXtdFRFx/i/hxsHzw==
X-Google-Smtp-Source: AGHT+IHwjQCn8pz3/iqiomOrjrLQUXcW8j3Cmfdd9IBi0Npw4AjyC0JLSC59kn9LukO94PmnEj6ZVNwxW2iE6Npb
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6102:2929:b0:48f:137a:78b2 with
 SMTP id ada2fe7eead31-490321d3690mr113577137.5.1720654965123; Wed, 10 Jul
 2024 16:42:45 -0700 (PDT)
Date: Wed, 10 Jul 2024 23:42:11 +0000
In-Reply-To: <20240710234222.2333120-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710234222.2333120-1-jthoughton@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240710234222.2333120-8-jthoughton@google.com>
Subject: [RFC PATCH 07/18] KVM: Provide attributes to kvm_arch_pre_set_memory_attributes
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

This is needed so that architectures can do the right thing (including
at least unmapping newly userfault-enabled gfns) when KVM Userfault is
enabled for a particular range.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 virt/kvm/kvm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 840e02c75fe3..77eb9f0de02d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2514,6 +2514,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	struct kvm_mmu_notifier_range pre_set_range = {
 		.start = start,
 		.end = end,
+		.arg.attributes = attributes,
 		.handler = kvm_pre_set_memory_attributes,
 		.on_lock = kvm_mmu_invalidate_begin,
 		.flush_on_ret = true,
-- 
2.45.2.993.g49e7a77208-goog


