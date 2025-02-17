Return-Path: <linux-kernel+bounces-517178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B17A37D62
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB587A397C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CA21A8402;
	Mon, 17 Feb 2025 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ooQ0KidS"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799A1A4F12
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781913; cv=none; b=rLceXqsE4Kt70xRyH9SHrKfnpEAQEzvDsapIi+azUdrS6L/pJtooyveSWzPZz/zfKMER9jVsJlGyGy5Gacukqd7tcINmw/Ijj+GqdxuHIqJ4fL9uZAKe4/qt4Be5En7CJt/14q2PAJqlDZOph/yoWKNmD97/17+LemGp5zoP7UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781913; c=relaxed/simple;
	bh=2Tut0PY2upP5Cl+GzK2sIbXrM5UY9W46/YKCJOvbOiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5kvE2JVCwRq46F2PmNY+QgkPGErcxjH+JPHgDa4kKl9A2p+fOVzCOMRdFpKaP47negbmx1VspMTQNyUhqcn8UumqLYU/ldYtXrjHD7n50yyxPw7VxtCq+3BVKaSe5aKRlse94wb25asqFqLJHU5MPlGpBYKXLg2KNe1YDFokV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ooQ0KidS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f378498c9so1302186f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739781909; x=1740386709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmOiuBasU6JQWrtvlHuH5EGMnpuZux+G/rw1YW3ZnKQ=;
        b=ooQ0KidSvlEn95evQDZ9cPJ/0tijkYIsvqCm0cRqZmjlEEBYTlXGtiTig5vKFw359w
         PVm5zzg0YWFbeEjHjLhSyKo0YihJnC7rYcJWLAb5HkzZu7ekG7gBljwblhop4XIzpkRB
         tJazWF3r8GxdLr8Pfpj1zObNSdDymLh2mfBpM9VKYqktVKb4iid1A7G6Dmx3OKXhMFZR
         YkuDy8i3FXzGorqG0TRHHwg9mpOVItvTBEp6IPuz2TT/enRIAb8AtQtuPr5h1LmUiUSN
         N50beiV5+b1UHdu9eESGs8+3jFOyeo+YQ0VH9pRMG7AmN9F8F2Wcc91UbxKM0Klj+TDi
         KdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739781909; x=1740386709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmOiuBasU6JQWrtvlHuH5EGMnpuZux+G/rw1YW3ZnKQ=;
        b=Nm63P00AvdraQHI2zcU5WVRW1gDu6w5X358jiGl3MmtoFmcR3nXvnNxm7ZpXMFSvFi
         bFv5Jg0hiK7R4htDzxirRzV4wDCl9cWZt05NwNDxKL3EL6yTg83ogEf3FwpNfKZP+aRh
         IP9paH0caA2M7HNUC3SpJo9QTQNAUOkYjua9lghFYD0hHREly75crgUV9abJdoGFKTvo
         xDN2iCFkMGLuU6sfdDnWNI+nAgkpKeVxofnDvUMjz16aczhE2xSaxiOXO7KG2aud4vyN
         qcWKI0KpGg4gHaEjMKl4gnmqnVqpecwK3Or/K/ndhEMe5XmDAE7wn0TXjqz3BJuDgX1d
         bzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOp6G0sTiXprraMVrZHIljCEXe9ocTF7a1OGswJ4iAz5Z/i8gWkdj4HKtVpFM6ah+GmaQmGnkwR7EGe8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV3nJ4oG8Xik1C5HbXPwRmTEI+1v54PnZdsk1d5MMxZMk8U8na
	Hv7zirVeF4gHEyXCIUmPlhiNxX8qyTBOkRUPMXOwp2qIHol5poCjxqAD1vKP/nc=
X-Gm-Gg: ASbGnctLAKMHQsrkY8VtcMUdqxOoWyZhNt2A5mpIdfSqdBAH9UJH35wKuUwkoA1uXbu
	3ApeXZ3H7nT+OKtC1lqoW4cVW93PwE3yi6oOHafSbFg7n6IzodWxblyOehOdiy5JbFCn2UPAc9W
	zHYzSTdRPXGh8ImeIMpeLMnvlLTm0UbUGiReW4Gf8fgZazAx4QBFyn1jBfLg8/q4VzJonwQCx0t
	m0n+7x372kH6Kq8New/LVsl3yakPc3znWOsELQ9HiN8JUlMcgCPWtdMMyyN1LG2Jx/TdTYk0+KS
	7m8=
X-Google-Smtp-Source: AGHT+IG4XexX5u4a9ST4SKpxQS8lH/aGBNXid1q/a0drWF3aciYyLxMBoUybxw0lIHE5NbqdkQOXHQ==
X-Received: by 2002:a5d:694b:0:b0:38e:65db:517d with SMTP id ffacd0b85a97d-38f33f5107dmr7035502f8f.40.1739781909479;
        Mon, 17 Feb 2025 00:45:09 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f8c4bsm11630555f8f.46.2025.02.17.00.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:45:09 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: anup@brainfault.org,
	atishp@atishpatra.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	cleger@rivosinc.com
Subject: [PATCH 1/5] riscv: KVM: Fix hart suspend status check
Date: Mon, 17 Feb 2025 09:45:08 +0100
Message-ID: <20250217084506.18763-8-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217084506.18763-7-ajones@ventanamicro.com>
References: <20250217084506.18763-7-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Not stopped" means started or suspended so we need to check for
a single state in order to have a chance to check for each state.
Also, we need to use target_vcpu when checking for the suspend
state.

Fixes: 763c8bed8c05 ("RISC-V: KVM: Implement SBI HSM suspend call")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_sbi_hsm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
index dce667f4b6ab..13a35eb77e8e 100644
--- a/arch/riscv/kvm/vcpu_sbi_hsm.c
+++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
@@ -79,12 +79,12 @@ static int kvm_sbi_hsm_vcpu_get_status(struct kvm_vcpu *vcpu)
 	target_vcpu = kvm_get_vcpu_by_id(vcpu->kvm, target_vcpuid);
 	if (!target_vcpu)
 		return SBI_ERR_INVALID_PARAM;
-	if (!kvm_riscv_vcpu_stopped(target_vcpu))
-		return SBI_HSM_STATE_STARTED;
-	else if (vcpu->stat.generic.blocking)
+	if (kvm_riscv_vcpu_stopped(target_vcpu))
+		return SBI_HSM_STATE_STOPPED;
+	else if (target_vcpu->stat.generic.blocking)
 		return SBI_HSM_STATE_SUSPENDED;
 	else
-		return SBI_HSM_STATE_STOPPED;
+		return SBI_HSM_STATE_STARTED;
 }
 
 static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
-- 
2.48.1


