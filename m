Return-Path: <linux-kernel+bounces-413295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9AE9D16F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA3928457C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3696E1C1F03;
	Mon, 18 Nov 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6ealFvd"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED291C0DED
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950406; cv=none; b=rLce3tJsrMVcwDpPCoI5SAnu0AdPsz50B4ygbAh9AqtoulymFZiKf7CvHalm6N6IIyP2oGKKtzTV770G5rzYa933kApMTQji6QDsZFQjgfkUBldP7j+/evTp/mBTAiwIQx1xZiGlulfYGlb8+k3is2QndtFgN7EvCfc3b5s4tz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950406; c=relaxed/simple;
	bh=1jI3ULDI1a9rCFZ1Us9rWYeHRUMtPt4yMIsfQh9tk4c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Vw8hwsCDpzLoZbNaxfVH+9jfgKp5EvT4DlAC22BD489C+5ST217gL3WuXpg8JSHoY5Qa8Fo2JObBUDrzgmDMjEMZ2fm/69Y39TYLY2ts6NXs8B2G1uz25WcaV5jJ1ZRklPeOlEmd/rDS91yV2xPeXYq/w4pcBsn6MkNEk5Qupo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6ealFvd; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-720397dcc7cso3150057b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731950404; x=1732555204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ky6FJcmYTMi9G40huepN+3Su7qA9jw5okKykESK4qIM=;
        b=r6ealFvdosJAkxR5ZHcw3mjmmlzsMjEzwbvdw6gGWrwW1980Dki4o3nJ1sCtVZ4r0E
         vLTTFCdgk0UfOQTSz7xIkzRqQJcr7DW5qKNcxrDUen0IAMrjIULzyScQ64OVJgIH032S
         HAFVq57UbvJjGYKjbqfYVqcW46v2sNuEWfqkVMuLb2+gO3nQgnUmQATWdbh04bEAWBzF
         0kvI+kK3uDFUR8QpL71SSbmrUwZ/Fdj6ADLlCxmoiIaiqv208q6lTfwc5lCWp5gw/41p
         VJHaAmNEeYR3ozQjLymNb9rKbKor02IdSL0yy34PwdgOMUHGQ2+JXegQswvtd6PT4YRM
         yh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731950404; x=1732555204;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky6FJcmYTMi9G40huepN+3Su7qA9jw5okKykESK4qIM=;
        b=RALzyyRLvrUlLpEXxq1wy60VOH06Cw3x0kVFNZ+aaY2YumVvnndSnfwD2UsdEl0t61
         6X1zKeI21y5Qabj3GUFX4p1PJV74umSC6aVBFie4j/kOB9CxnTKnNRaE5rKNeT2hIs4a
         PF4HOeu2s3e49SJpd3O4YqHUrG81AktxTdfRBNsxBWyk7Fqy53Cd0khTRlCaNKjY42bJ
         Wbf95M5TEIWjoYxHUHFqutd2/I6v7o8yg5umhqNXEpSm2lfE2m91egyOmYpWjXMVvmep
         +a1wZ9dcxr6NVqxOk9zaYMpF33GUrSyUr3VwueLpkhOICiG2FpR3uuNWM5forLjug00R
         WlVA==
X-Forwarded-Encrypted: i=1; AJvYcCW7dyIZ5gdXvMXABa/zJC++a/f71d0WiYaXKaAKD60VRjhMIMePzqYDu6/Y8rV+jncqLd0Slx2lq20qzm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQfBYBnZbSUrRx85/Ra4HE9dzEl4pLdZ4wYjwRLIQbS6lfwk9x
	fR/nfY5ROzQ2uzIe1JPRGAxEHlz4LcTXSy9wwnqBXPu0bPK5K44IJeGQ5p962gS9Xa2d3+uo3Ce
	rAQ==
X-Google-Smtp-Source: AGHT+IHH4vEqXfWsqhCEybKMxEJ+7ogcipKSZwO5ZmC15IH6YH8dEDZmsqVnP2vj8hg0hg9+rNRlt61hcGo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:234c:b0:720:b04d:8fcb with SMTP id
 d2e1a72fcca58-72476b84887mr152218b3a.1.1731950404700; Mon, 18 Nov 2024
 09:20:04 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 18 Nov 2024 09:20:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241118172002.1633824-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86: Fix more KVM_X86 Kconfig bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Fix two more bugs in the KVM_X86 Kconfig.  The fix from Arnd resolves a
build failure, but practically speaking is a non-issue because the failure
only affects 32-bit !SMP builds that effectively disable the local APIC.

The second fix is far more urgent.  It resolves a bug where KVM's Kconfig
doesn't correctly define KVM_X86, and will build kvm.ko as a module when
KVM=y if neither KVM_INTEL nor KVM_AMD is 'y', e.g. if KVM=y, KVM_INTEL,=m,
and KVM_AMD=m.  I don't know if any distros use that combo, but it broke
our production kernel, so it's certainly possible that it broke other
setups too.

Arnd's fix was already posted, but I bundled it here to avoid a trivial
conflict and to ensure it doesn't get left behind.

Arnd Bergmann (1):
  KVM: x86: add back X86_LOCAL_APIC dependency

Sean Christopherson (1):
  KVM: x86: Break CONFIG_KVM_X86's direct dependency on KVM_INTEL ||
    KVM_AMD

 arch/x86/kvm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: adc218676eef25575469234709c2d87185ca223a
-- 
2.47.0.338.g60cca15819-goog


