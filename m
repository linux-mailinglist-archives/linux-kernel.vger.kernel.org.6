Return-Path: <linux-kernel+bounces-257741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479D3937E58
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046D42821C8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB68512C554;
	Sat, 20 Jul 2024 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByBG8mQT"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DDC5821A
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433710; cv=none; b=TyooJCG5TfZD4zBKC9FlCdvaHlyXMMEp4YaDSs+7DRWAKhRxw1gEkz7N36zT+nVy/Bu8xntvczUlMIH2u0wceZtbIIlykPtIyM9oeUmTXNB5kYg+IXB6lJFlSxGVjneLQz5ymrrjwi1vko1gHsnHHZ+X8EUMjytzWdjHbX9bUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433710; c=relaxed/simple;
	bh=MFLtkL/1x53Q6UUfm7ynJX/aenkLzsfwcLQOqXgYplI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tMCGFN5Icy+gpGQLn1ygw8SoskhUzzQ+xHupS6laVzNOOdUYIAbMaom45XDAGCoELJUIR8YUhnWqA8DxrJjfk3YNx26alaRhKKLjEd/F3ZPFqDEW2yIWkclB1dlzJrdp1eAsQVPRajy1aN3n0+MGLNqtL7tMi4w6WkxxuW+E2nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByBG8mQT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0871f5589dso777944276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 17:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721433708; x=1722038508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=htNTaIxfaR6n9UdbBaZJqnoxR10sdpaYRsT6NfFpXRs=;
        b=ByBG8mQT8CeUfe33B1X+e6VO/47WnVQ8KhIgbsLbvNLvOOYqjN93W4Di/h/6vnRv6u
         T9DJEKtyygfduPlOnXzzL1vHVrnhtmT3hW9da/ptP1+txzrIGov5NwhX8zcQAjgxMIDd
         d2duXEG86TSCNd6BLrJHgWJ25stqIClr+t4Drj7cuKNsoCyBhLAOddKdkhqZZBdwASzu
         W0V15yY+CQ6IxBxkfnjM4IXBTR486Sgy4xs2nF2jAMX4EaNdjh7bH3VhTCCq+DVvyDoA
         he5+0gzYtEJpT2DekUMmBu6WzB8iGoXg6Z+jn5/o4IHWdz4yPYBDuSGciVjpdw7n41Ag
         4YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433708; x=1722038508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htNTaIxfaR6n9UdbBaZJqnoxR10sdpaYRsT6NfFpXRs=;
        b=m7fL95sT/V84ZaSYUoXhtd9gOBSG5hOCCJ6F6M6yUEACCnCBsOahpc5cPzvdQJR+1k
         NqzCDqI6Zl9a55a/SUb/HoBz8SwTI6hg00CLB00Jlc+rB7PMaDd/dDBg+I6Lu4MzO0t1
         BzVAdgbeDDEjK/jECHUqCjQdhg5eqHHhB4nP4qPQu4jYB0pxMAslJe9d5Hh1XmI0pc4j
         ti9LA0Ts6OvO4qlq2eULqo8kI6BWw5bDuKhGzXTuOs9QeDUJYYRe/WvxLPkMAB+J9loA
         byScrnJDomg1KcFzmXPzRYVzRXQcfbsxBPuWsuiErZv822ZFMZfKtO4KrevRGKeOjYAG
         awow==
X-Forwarded-Encrypted: i=1; AJvYcCXC7M5CA4ZmvsbIkj3glFPRWXZLAtpSeaBDEyJiymYxZVgF8NEausVGY8IufTyfAN1c+yJWdXy7ncAR/+g1o5zVhp9KJpwxJVnNoo41
X-Gm-Message-State: AOJu0Yyu6SGPbHoIeTRYL+C+ylJzJucqHLAHxfkOJfk6bBfI78oWPJjb
	bUg7nh1gUDv16sRAb3neMU8y8djhaItACoChtsKHo4vx2OCwcvzlQmcTYt+1z11igq8fL2XHwV3
	g7w==
X-Google-Smtp-Source: AGHT+IFf5Ki3AK6jumi0dajUtxJd0gFSN1CWjiYodUX6vzIqzLQzbhvgvz6WRixdyl/5GA4Rn4URhEzNpxc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:870e:0:b0:e08:6c33:7334 with SMTP id
 3f1490d57ef6-e087044445emr31630276.8.1721433707785; Fri, 19 Jul 2024 17:01:47
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 17:01:36 -0700
In-Reply-To: <20240720000138.3027780-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240720000138.3027780-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240720000138.3027780-5-seanjc@google.com>
Subject: [PATCH 4/6] KVM: nVMX: Track nested_vmx.posted_intr_nv as a signed int
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"

Track nested_vmx.posted_intr_nv as a signed 32-bit integer instead of an
unsigned 16-bit integer so that it can be passed to kvm_cpu_get_interrupt()
without relying on sign-extension to do the right thing when the vector is
invalid, i.e. when it's -1.

No true functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 42498fa63abb..dc0921bc4569 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -208,7 +208,7 @@ struct nested_vmx {
 
 	struct pi_desc *pi_desc;
 	bool pi_pending;
-	u16 posted_intr_nv;
+	int posted_intr_nv;
 
 	struct hrtimer preemption_timer;
 	u64 preemption_timer_deadline;
-- 
2.45.2.1089.g2a221341d9-goog


