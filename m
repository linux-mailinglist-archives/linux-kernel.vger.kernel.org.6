Return-Path: <linux-kernel+bounces-176372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD8B8C2ECE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5931EB232CC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA32134B2;
	Sat, 11 May 2024 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTCXJPKE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7017BA8
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715393183; cv=none; b=GurLPHT5dwG0OeZrsHCiGIyj6e5RPm2Xjg7kEY0qwjUOcKaicsWYExOoWcadMjWzM2hLLQPtIj/hAx9/1wSe6u6Rj9BNJ4sNxFYhMVRlAupM/L645gGnLvYpJBh0Lj0AR9TKo2W+hG2V8/CDPJ30a9FEYJ1n7y3a74K+1impul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715393183; c=relaxed/simple;
	bh=Bcez1ZN5jbmAN5kHQs22HRYPeO0I1pr0xQfDxseeOm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9BMgvb3wv9oDBtP/4EekNPAmWOV02S/CTA+pNygQkIK10iEt0ptM7AaJUcAAmg+Wb+2eLUmoNABVmxZQU0YAWZRWHlFqQuYKutB6QfsPMtSH9U+jMQ79nU4NtQf0YDlUtG6RxEtVH8nSXhg+r5KjlPWIC81Tl2wS8uWaL3z7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTCXJPKE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715393180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=daLsFH4iE+jW5hdu/+FJhyzrOZc6lCSRVtz3ul607bc=;
	b=JTCXJPKE1YAmI/rZqTAy32xyR08i+1wRyCR4usdTHb/vWj01riLjPYu03PLnvAPhh2qjAD
	epw1w2YgFwo1+SVAY9FEFzrKloqMD2LFOxE1bu1YceS/rZwJNqpgpzmWWghcvDUJWVw2Jj
	F3EaziMSPxgbucWG3rJxEiWwkXCP8G0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-3eL-TwjiMVe-RPnuOxgheA-1; Fri, 10 May 2024 22:06:19 -0400
X-MC-Unique: 3eL-TwjiMVe-RPnuOxgheA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-792bd04759eso330246985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 19:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715393178; x=1715997978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daLsFH4iE+jW5hdu/+FJhyzrOZc6lCSRVtz3ul607bc=;
        b=s2dQiRResNIHyjjyrNGiR6m40ftAItKPp4f7ZT81ItwPegpJnTJwYUWNPlfDOf3WEW
         L3ighs6ojfATBW22cwf1/VOA1EnS+WL4rVAsxvh2ZNrc0xu+dcV1B1y6Zl3ZQQmN9NCE
         8macTKqY7rmLTvQCGosJiol1oOgGdiosUa36iJ87vtYy+UPnEdgE9GtjksV5nZs786rN
         edn1AYhTR6or3ARHMykSRWXd2T5P+AZegqDHHWG4OUn7TAF9mq3+tmkSxUFHigTa7CIo
         ftNGvxVmbwByTS+QmDRViesSr9m/iZjgDaYmnW3dEL15WF/dl8hCuG31cmEjTCrM/0Ci
         haYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm5OclhYFvY6FjEYFcfgyEeeVIgEge40mbaUKaQOMGlw3UDf765iJzMtiSHiuOcowIK2E/++3rVpAFWTpiJ4oJfXaSZzqWDn3i2knL
X-Gm-Message-State: AOJu0YztNVSE5t/+v1ZuFnWEUTTdEgRfTuvihNGCncbCQNMXO8MKx6K3
	vDYgs4Zino2Ug9WEgAQHTBe8+2SyJop4IrTysFXZmlqRH6IQ+GiT/UpUtWvCoot7mQkMReY6ceA
	xUg55SwZdWioCtV2eIAtmtolkFN63GmGdaDex2LYfIMtuJ+e0zRRAGMLbeSRKAg==
X-Received: by 2002:ae9:c015:0:b0:792:93ed:2e7c with SMTP id af79cd13be357-792c75ff5a1mr431256185a.76.1715393178515;
        Fri, 10 May 2024 19:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH86M6/EY092LhOYAVSvQkpGYBhapdn8Z01/VuAAKYTz7sXyjWnHbl1sDCKD2FEHUZX/sHoDg==
X-Received: by 2002:ae9:c015:0:b0:792:93ed:2e7c with SMTP id af79cd13be357-792c75ff5a1mr431254685a.76.1715393178118;
        Fri, 10 May 2024 19:06:18 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a800:8d87:eac1:dae4:8dd4:fe50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2757aasm234550185a.8.2024.05.10.19.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 19:06:17 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [RFC PATCH 1/1] kvm: Note an RCU quiescent state on guest exit
Date: Fri, 10 May 2024 23:05:56 -0300
Message-ID: <20240511020557.1198200-1-leobras@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of today, KVM notes a quiescent state only in guest entry, which is good
as it avoids the guest being interrupted for current RCU operations.

While the guest vcpu runs, it can be interrupted by a timer IRQ that will
check for any RCU operations waiting for this CPU. In case there are any of
such, it invokes rcu_core() in order to sched-out the current thread and
note a quiescent state.

This occasional schedule work will introduce tens of microsseconds of
latency, which is really bad for vcpus running latency-sensitive
applications, such as real-time workloads.

So, note a quiescent state in guest exit, so the interrupted guests is able
to deal with any pending RCU operations before being required to invoke
rcu_core(), and thus avoid the overhead of related scheduler work.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---

ps: A patch fixing this same issue was discussed in this thread:
https://lore.kernel.org/all/20240328171949.743211-1-leobras@redhat.com/

Also, this can be paired with a new RCU option (rcutree.nocb_patience_delay)
to avoid having invoke_rcu() being called on grace-periods starting between
guest exit and the timer IRQ. This RCU option is being discussed in a
sub-thread of this message:
https://lore.kernel.org/all/5fd66909-1250-4a91-aa71-93cb36ed4ad5@paulmck-laptop/


 include/linux/context_tracking.h |  6 ++++--
 include/linux/kvm_host.h         | 10 +++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 6e76b9dba00e..8a78fabeafc3 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -73,39 +73,41 @@ static inline void exception_exit(enum ctx_state prev_ctx)
 }
 
 static __always_inline bool context_tracking_guest_enter(void)
 {
 	if (context_tracking_enabled())
 		__ct_user_enter(CONTEXT_GUEST);
 
 	return context_tracking_enabled_this_cpu();
 }
 
-static __always_inline void context_tracking_guest_exit(void)
+static __always_inline bool context_tracking_guest_exit(void)
 {
 	if (context_tracking_enabled())
 		__ct_user_exit(CONTEXT_GUEST);
+
+	return context_tracking_enabled_this_cpu();
 }
 
 #define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
 
 #else
 static inline void user_enter(void) { }
 static inline void user_exit(void) { }
 static inline void user_enter_irqoff(void) { }
 static inline void user_exit_irqoff(void) { }
 static inline int exception_enter(void) { return 0; }
 static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline int ct_state(void) { return -1; }
 static inline int __ct_state(void) { return -1; }
 static __always_inline bool context_tracking_guest_enter(void) { return false; }
-static __always_inline void context_tracking_guest_exit(void) { }
+static __always_inline bool context_tracking_guest_exit(void) { return false; }
 #define CT_WARN_ON(cond) do { } while (0)
 #endif /* !CONFIG_CONTEXT_TRACKING_USER */
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
 extern void context_tracking_init(void);
 #else
 static inline void context_tracking_init(void) { }
 #endif /* CONFIG_CONTEXT_TRACKING_USER_FORCE */
 
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 48f31dcd318a..e37724c44843 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -480,21 +480,29 @@ static __always_inline void guest_state_enter_irqoff(void)
 /*
  * Exit guest context and exit an RCU extended quiescent state.
  *
  * Between guest_context_enter_irqoff() and guest_context_exit_irqoff() it is
  * unsafe to use any code which may directly or indirectly use RCU, tracing
  * (including IRQ flag tracing), or lockdep. All code in this period must be
  * non-instrumentable.
  */
 static __always_inline void guest_context_exit_irqoff(void)
 {
-	context_tracking_guest_exit();
+	/*
+	 * Guest mode is treated as a quiescent state, see
+	 * guest_context_enter_irqoff() for more details.
+	 */
+	if (!context_tracking_guest_exit()) {
+		instrumentation_begin();
+		rcu_virt_note_context_switch();
+		instrumentation_end();
+	}
 }
 
 /*
  * Stop accounting time towards a guest.
  * Must be called after exiting guest context.
  */
 static __always_inline void guest_timing_exit_irqoff(void)
 {
 	instrumentation_begin();
 	/* Flush the guest cputime we spent on the guest */
-- 
2.45.0


