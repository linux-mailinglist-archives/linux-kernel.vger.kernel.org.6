Return-Path: <linux-kernel+bounces-271744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646FE9452D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C271C21470
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9B014EC50;
	Thu,  1 Aug 2024 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38WhoNgc"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58AF148FE6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537313; cv=none; b=ZkF+OD2iSN2AAi3CyLyLSy8vSL/GP2uyCOowZxcy5btycd7f9ILgEDNgx7Soe3mDWJEBsd15y6FL7r4ThlYoQ+8lOvdjD6bebuWBFSK1SZFTCAs5L+B6XT/mbmPPFfq61IfkXlXzHgl2TDZaGW0IrTUnw6OdstyDHHbL7/f7zDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537313; c=relaxed/simple;
	bh=RbIH3IP3u28tDH3NR3/offoYXurj3HvTAqkxRIuQJEQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nUA2jTqUAd4tkNrWzpyP0u/vwvrYZglmqa+vXbvls1UUHXOTcjX9WxHORvpePZfCjQ1judPpwGuZmejQJuF4STQr3MaQVjhT5RYtWZXqc/QQPOBcqqvhq4jPjskmK2zGbOhyiIqOAG+BTsek2iZfkLtQTZuIBQ8c/HEe+WOw24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=38WhoNgc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03623b24ddso10619637276.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722537311; x=1723142111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=reMwPkVdpNL6CI3+i6mf1k9M5Xmr8NrhYIDXv6qn8Wo=;
        b=38WhoNgcqwS1ix5Duj6UAQjG74zQZN6kXOnA8QAjZxDHPynKrn8mwHwbqhFw0Vgu7s
         uKCv/OEnLAcKY7on2oUUyUNZMXRVyjCnDnXrxGVKxq5fuKUPLvWc4f/NfvmzcvNVj8O5
         UDuuxE33Hzwgj9k9x2D3ma5rdrwRqnakk9OjzA8TchN4u6KC7qVXVA6N0EUxN03LFP/K
         MK65/QCl5tdOCxJsE7M4AshoS/qgDBOlfqRbV3lyO7YoYn9nAL2aL/cvtTUf7sMvdv3x
         OA75tTlfPTmC6uLLIFlBPpjWDOZtaK3ShrZIQhGhxDu9mPOrfVmFxe9LSPk+pqF/t+sA
         OXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722537311; x=1723142111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reMwPkVdpNL6CI3+i6mf1k9M5Xmr8NrhYIDXv6qn8Wo=;
        b=wGM6coc1wHoqztdjhpJjRraCVgKNNuC+kv+j7/atiUSsa5NxvFCTVNyYutaCD7DEjn
         AJdB4USVq97FzjGo2Is7A4I7ndMLXnZLqtyGrhOa8AL8g4231XyCHKZoqT+VsXrHW1T2
         PvxDe13zqCsONeQZnq0HSQ/VipG2XASU2zBy0Uzu8imqE2yGVDhg/PBMJkqZuROBxo5u
         NSrwbTDBa1bHg5LX3xS/DgCIpfIe4xDzthmXjXKWA6RLwIg09f8TQm6JoB+PlS4scfIt
         68YUq2oxWzj6yJoXb6IrSGgjkj3x2d1dq0dnv7//JfFOkEIcE5SM0CHIkjfZHVsheeaE
         Kxzg==
X-Forwarded-Encrypted: i=1; AJvYcCX0qcK/vpQdexJKefViYALhyDT0qWtM7RGjYD4muX1fpuqR8CEikjb7rubgB/67V3UrY9cTtTqgsiHx7M8raeuHy/t9FESOXTq6H23M
X-Gm-Message-State: AOJu0YwsOYAs7crBjQnUlgotRH+ODwi+kwQNQ5ICL5wJ0CElkNN41CWq
	SvR+KUFnvqyZxyVClGHhWyTGbrWN+2G/cs5HslpuA/OV0iA+xAG+BKS4kZELPg5ix4nvx7PpCjx
	kWA==
X-Google-Smtp-Source: AGHT+IF7cOBWTMyYm7b893kA5i2raHJ45P5vW+o+z7f1YVRpVI+wpdWY6KX7vJ+SzwpepoEVO382RoCb96g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2483:b0:e03:a0b2:f73 with SMTP id
 3f1490d57ef6-e0bde2f3cdbmr14329276.6.1722537310980; Thu, 01 Aug 2024 11:35:10
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Aug 2024 11:34:52 -0700
In-Reply-To: <20240801183453.57199-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801183453.57199-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240801183453.57199-9-seanjc@google.com>
Subject: [RFC PATCH 8/9] KVM: Plumb mmu_notifier invalidation event type into
 arch code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Forward the mmu_notifier invalidation event information into the arch
handler so that arch code can take different actions based on the
invalidation type.  E.g. x86 will use the information to preserve
Accessed information when zapping SPTEs because of a protection change.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 006668db9911..1fce5cf73b8e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -252,6 +252,7 @@ int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 union kvm_mmu_notifier_arg {
 	unsigned long attributes;
+	enum mmu_notifier_event event;
 };
 
 struct kvm_gfn_range {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e279140f2425..3aa04e785d32 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -719,6 +719,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 		.start		= range->start,
 		.end		= range->end,
 		.handler	= kvm_mmu_unmap_gfn_range,
+		.arg.event	= range->event,
 		.on_lock	= kvm_mmu_invalidate_begin,
 		.flush_on_ret	= true,
 		.may_block	= mmu_notifier_range_blockable(range),
-- 
2.46.0.rc1.232.g9752f9e123-goog


