Return-Path: <linux-kernel+bounces-273063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7F5946430
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF2C1F22F15
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E7873471;
	Fri,  2 Aug 2024 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6tJGctS"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3779D4C61B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722628903; cv=none; b=M2hcaLF1AojgDV+OjzdSvEdw7YhE1rwYa/IVklxepBgfKlAkLrbUi+E1zj4xzwCQvskXdaVmHTJw2GHCJmGnws1+wLKFW2VHWDeha6MEl3X+6zGVfjXWeE9/F+Ifhpec7R+lhb3PhMS43OFrEbqmfmP0dq1cLjakeaqNqq013t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722628903; c=relaxed/simple;
	bh=eggCc2iIcNGUqxlTvkV0QVMXd9vYfqCFOgNyFcQOOTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HNqzSR6yFmApH9Icfvhzba/WjEc0BvACgeaFOzzl2U2PruvzGrIDbIdPo/w+uBx+2gWJdS9dXqEReU1qveV4sUJodN1lCPXTfr+s/duUqLkjSCgU31T+AOhyQYSuzjU9ciRmW16xSqa3+oIFn3P20waORkgZPHX2Hnw/YbTzPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6tJGctS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2cb5ba80e77so10183904a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722628901; x=1723233701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xQLoSNAIlbI381p0LRgfP/Yiv8RuXN9KeorgYSd+JBM=;
        b=B6tJGctSiWJ7lpRmNAvOErsdBHwMzRlsInYceU9zUV9KlyUzkkB5gQHhqDh58y5Lhg
         cEWgko/bGFaj32siwTBXTZk+87Zi4wQmRx+EjsIh3MH1v4S8eSYE6i68nnKABkpXiEaX
         fOhK/DrINjZWWX1L+2CWrQ2jq0+GOLteH6bEG/73hGCBVujUJVINGglMbIubpphgo/ov
         GWSEceA6PewvJRWmp6kgxDSy6MXnH/+SMaKvxUJvmLW4xV54FugEkaQcd+T7E6E4VoC1
         YzVDbLLaFPka8OCfZu/Ir0C3S3ixIwpdC9hCtpeyFasKBmNIGnQ5nsYBPF275BhbH3yD
         YE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722628901; x=1723233701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQLoSNAIlbI381p0LRgfP/Yiv8RuXN9KeorgYSd+JBM=;
        b=Yic2gl5U/HV0OD649KXAOfINJMJhQ5+b1dNQteZ/v3LN3zCBlcxromsDqqSxLKeoO8
         udTPfWvp2QwjNYZEYH8YD8csz5w7cNpZPnzLglu+Z86wCE5tPcgV2uAtQW7UQjips8Yu
         LUTZab7brbT1//SfE+PWO1j+i2PPP8RbqqzN4Et4IgsboI4UDfHrtMkytRnG7xy6muRZ
         x0cymmJnpS6Y7eSpcscXrqUfYR+WdEArIp3jZdzwKIQEjXwL0927uVYVo5LuN0/d4RiG
         FvwssN/xz5OQsAyvcU16Ng41HKGrwr3Co0J/tRF49gLIVNE4COlzrzXE6Ze1YyemlGVk
         M8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJJ+DNfkCNmZtXBMpxJt26UiMD+xAWbN6CB/sFubg3VL6yE+mhNFlcj5SdIXw3lytByieCKmubAH3Wap6iOFl6Jrl+8n6gm7GLgxu7
X-Gm-Message-State: AOJu0Yyr17HLaGJ+QlxUPGpBjwJFu+vujguyqwJOuW0YjXI1dmR+9ELy
	kWWLnVLviV/Y1h4mbgWMsKQe6SqRC1SvnHWx91tG6Rh2jqYKmNDfOPJLXJuZ/14mdtO6GBwQPw+
	RHg==
X-Google-Smtp-Source: AGHT+IFId3HHn5L5fWCDKxPTuecTBLeAk2p3kpSjqAki6o3dAad+BGMQ+YjK6m4jW2ZqIb6OkUGH+CX4xls=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:ee94:b0:2c8:9052:58bb with SMTP id
 98e67ed59e1d1-2cff93d2bfbmr119920a91.2.1722628901308; Fri, 02 Aug 2024
 13:01:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 13:01:35 -0700
In-Reply-To: <20240802200136.329973-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802200136.329973-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802200136.329973-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: Return '0' directly when there's no task to yield to
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Steve Rutherford <srutherford@google.com>
Content-Type: text/plain; charset="UTF-8"

Do "return 0" instead of initializing and returning a local variable in
kvm_vcpu_yield_to(), e.g. so that it's more obvious what the function
returns if there is no task.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d0788d0a72cc..91048a7ad3be 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3932,7 +3932,7 @@ int kvm_vcpu_yield_to(struct kvm_vcpu *target)
 {
 	struct pid *pid;
 	struct task_struct *task = NULL;
-	int ret = 0;
+	int ret;
 
 	rcu_read_lock();
 	pid = rcu_dereference(target->pid);
@@ -3940,7 +3940,7 @@ int kvm_vcpu_yield_to(struct kvm_vcpu *target)
 		task = get_pid_task(pid, PIDTYPE_PID);
 	rcu_read_unlock();
 	if (!task)
-		return ret;
+		return 0;
 	ret = yield_to(task, 1);
 	put_task_struct(task);
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog


