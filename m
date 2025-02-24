Return-Path: <linux-kernel+bounces-529594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6185BA42864
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E185E18929ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683B263F59;
	Mon, 24 Feb 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDChtEOW"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D36263C72
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416086; cv=none; b=WGtWeywR9DGMfvQbuorLKcClAasTkJlgA+3pXy0fhlGkuijP1YTCQWHXK/iO+huVRT1I/+CY5iXfG9aqyAGct51StXsQSlSH8Cnr+aaqg2Wa7NGkWcVJnzgytcdKXss/JogfsC9YDhWnTt3o+q5FIha5Fk+wuLT++uZEqWFA1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416086; c=relaxed/simple;
	bh=qMqS5eEfht6kZYvGjtkUVdSw27+r0jMN/tKHjQa2x00=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UrKYrj2lsGRMhx3lflxaH+YfWJ9EltLUjfJKJtB8XYE9R99/mx/j7Vvga4iqbrz+5TZkD9MoIqdKCoer98zc0I7U3GT5cGZxfdX8inUcgwy5dIhe/3uy2yTqjwr9SH9ZVvhP0juHCfXi080WZpqpqfiZKqoCRWCxJpGlpwg5UJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDChtEOW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc0bc05b36so15052209a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740416084; x=1741020884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mO++5hfTZIp7IqLdPpH8usJ/YROL6etz3YUnuU1xDcQ=;
        b=jDChtEOWamrjaXAXnf5OtYZz1WeXSs6iwFh466WPSD46mHWmaHE6t5BOBO9w3TSHW5
         P15fDON3VP9cUr3q+jfqjVWOxspP45P9KWXMwDwJgEtPYM1wcBx/duDG0BI/bZZEHZ+x
         /Kkm+vfrn7js/wMWUH7TARsQUjwiCVQlVDKp4wPXRHvEhbj5Z3gZyzRc0xXNRSbvW964
         UURJ2WZ3muM53n+7YBDiMTS8GRBpjH26gaEIq0vcFqVKhtH/k/YvHBH7PJkQbuo3eY5Q
         y9fL+imvsaHCfGyZ8qQF61pjxRab0X5ipdhc1BYUG8tX1OvYZPmLLvOq01HepGfk/3tm
         3BDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416084; x=1741020884;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mO++5hfTZIp7IqLdPpH8usJ/YROL6etz3YUnuU1xDcQ=;
        b=WWbvGdokVgCm4XSuwN4iCi0kuHb2uJF53z1Cqrpur2A7MnuUqWUNs60A/PTwBuhWGT
         qibLsihqCixUxZJPx37fKE0VM6aMQEMLtcmMHW98mJK7GKMiKrMLaM9J5bdKFYC4d85o
         5bYmBz6XHUKmBKeVoW1Yq/iSMkz4exmzFnTw2ic/I/vWEIHIKa+6amUSZ4wEX7wB6TNw
         F9CzlDeiFuMlejTYDH6XI8ofhos1kv6El9Qhfe/UE9tvszpRZlnzINTkifYjxu9CZ6ay
         r68WFVCzNmFfKs6+4MjmfdAHaO7VMgGINYqWhfEd2Lt8tWSFse6EWcTy/Ba1HuYFYZxh
         uPWA==
X-Forwarded-Encrypted: i=1; AJvYcCWU7G8lRJG4HjeA0NiW1TmlvgdZ8uUEivm2Z5huXOJ4kdglTKhCWpqo/W1eAIWe56Wn+3iV69ixMN4EjJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xZ57aqG2N/rFwr8gIiUv9MChUvt55BnLNcV5PNfT2fNz4V7Y
	ofVPBQNv8hLV4ivcyFFSPv3V9Db8i/WSjV3jKMT7DLxsRUrE/GS8jSLqXu/26qFjWho0LKtb75j
	UyQ==
X-Google-Smtp-Source: AGHT+IGb+f7j2I0nb12t7zmDGMmEI0YCFwJ+uRhnZXJ8MRHxJkt6TTRNK3XmV8KQPwwgSN4ciXRzHh216so=
X-Received: from pjboe12.prod.google.com ([2002:a17:90b:394c:b0:2fa:1fac:2695])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d40c:b0:2ee:fdf3:38ea
 with SMTP id 98e67ed59e1d1-2fce87243b6mr19543865a91.23.1740416084497; Mon, 24
 Feb 2025 08:54:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 24 Feb 2025 08:54:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224165442.2338294-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: SVM: Fix an STI shadow on VMRUN bug
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

Fix a bug where KVM puts VMRUN in an STI shadow, which AMD CPUs bleed
into guest state if a #VMEXIT occurs before completing the VMRUN, e.g.
if vectoring an injected exception triggers an exit.

v2: Use "raw" variants to avoid tracing in noinstr code. [kernel test robot]

v1: https://lore.kernel.org/all/20250215010946.1201353-1-seanjc@google.com

Sean Christopherson (2):
  KVM: SVM: Set RFLAGS.IF=1 in C code, to get VMRUN out of the STI
    shadow
  KVM: selftests: Assert that STI blocking isn't set after event
    injection

 arch/x86/kvm/svm/svm.c                             | 14 ++++++++++++++
 arch/x86/kvm/svm/vmenter.S                         | 10 +---------
 .../selftests/kvm/x86/nested_exceptions_test.c     |  2 ++
 3 files changed, 17 insertions(+), 9 deletions(-)


base-commit: fed48e2967f402f561d80075a20c5c9e16866e53
-- 
2.48.1.601.g30ceb7b040-goog


