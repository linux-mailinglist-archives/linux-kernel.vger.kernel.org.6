Return-Path: <linux-kernel+bounces-534892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBD6A46C55
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F8318812DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8173B256C7C;
	Wed, 26 Feb 2025 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BXQPDPNZ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54130275618
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601513; cv=none; b=HylPPARQQvJHO9tGXjMLDTbVAoYgYwg/Gk38eG4BywBeRQr7rAFaguGB/e1wGBmmncR7uiWoe5Tf2P3TZ7RERfPOmafbZkjPnoCibIHaDYxiuD//+P6HP+4Oneun91+SmJ8xtHiBvL6GQDgngaBGJg+qp5fTjoKFT0XQLoDvPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601513; c=relaxed/simple;
	bh=13OFkK4DG9rlwr0Q6UrPqb9K5Q7tJkO1UyK3M9GC5A8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eHU0uoj3f9W1bMoaGcYUq7dr07oEDqknj4QJoloPDM5729mn8Nr73iZ2qTcljp6ghBoAQio8LsJdnQ2rlqodGAze2piqkUIXUSMGbp6kpTwUiLCh5NOdcnI0/LHPwE7AIzZ9nRz0opn7SxEQgUeOOqNpRT0ekWEdudyh+Pds+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BXQPDPNZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-221050f3f00so2958175ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740601511; x=1741206311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sbKkO5vslqQzNclWEzfBDF/g1FIfkcy+q0e0Bhe+Aw=;
        b=BXQPDPNZbX13CwkrIyYIjEg+U58EB6MUFXSyyF9WOWONVJYXG5FuaygjySUX46g8Go
         h+WXZwMOubdtLoc4mE9A1a23bHPjBGqn8iY2KWCKOqYrV1OT+DonxYw7cnubFWMnZu9O
         yJsqqt8hvmdp3kPThziblnH87SBYXi95v1isx+/xb3jFLQayUgsz5mbPR0/3oA+qorhq
         1gZHnB2NwnsmONtzMFa/z75gUekNWiMHWw1sk0KqMmMR2KF4JKxwfVoQ1GvN9UlwvUzb
         M7sNYLyLogYSBQHqTsHN6mzXpkfRsHkUpbpRTHruXuima+Clf2WDylAT5NtweNcOOk+Y
         1t3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601511; x=1741206311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sbKkO5vslqQzNclWEzfBDF/g1FIfkcy+q0e0Bhe+Aw=;
        b=M+GX8axwEGGWkC9GG5qm+m3lei6mKRoyFQqRicLAcoEgPes6FIQGL8Znr7MbdUQhwi
         EIEy1fgAvcEfy3rxYsn2k+Fby2R9uIAOjKWjhztovr7JEFm3Js2JcF2XLQu2XL1KXQH+
         +7muZcRS9zQLidOYuWb+ArvZQs1p/ELClK7YfJX6BlDgLfR9ZEIBoBeUVlP2AAczlj2k
         L9GW3K5hboaQ1GdME0EEyJ464iGN6fMr4Evxd8E4xrs6rEiLKBfWZuP+0ZLp6aDGWB0N
         7/zhltoNFaVuAfP0ORLj14Krg1Z9NFPpHIlDaFoGa+myHPZ8l9UA4ZX4CSM/ZUjhmWeg
         W4eA==
X-Forwarded-Encrypted: i=1; AJvYcCU8I8Y6cXHyq+zZ+NXa/RTX/kCLQcovGrc7Gh1BdlMN5jOgxgu+XOO5iWWALeWh9cAICiiiXq7wYQuHRkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UxM6fgb9nRHALcDDv0eT8H1yyYVm/FRUssmEDyNGqaz4p+48
	KjNsW8K1AqFCpdQCHi2U/k2kY4zvoJ2nSOspJ/xd4zOwiKL1NnpV9ePdz/NrIJ0=
X-Gm-Gg: ASbGncseM+i8z1BRe0dt7wr9xhU25+jiSNDKeoxPHbdfPe25lw9KZW4etrEHu8JeeN6
	+UpKpQNn8S7hIHMe36w/aSxHfcCBUZln9MT6mcLAppO50uV5PK51DCPr6ARlOYD79xB6bhQPQOR
	pyFxAyOzoQEeiHptS9txitGdKddN/QACdgbq1G3NPzldOiGvWIsg7F1WUdFcnCXjx5SWV2Ha18o
	/XVA3B3wp8l8tOg8221V94SOxDxmRcy73aoQx3t5/0fm4uFmBS+W5BtJ1tMZ6IJykHzp/MoPW7b
	JHRmpqh4u50i1M/C+nJJt60tpaLHqviAM6qczXM=
X-Google-Smtp-Source: AGHT+IEWIj7IHjMpuZgHnt8pmhZWNooJK4EQmrGTIUbek2AswW1q0QzF8a3PR6HcOQhdoiMYN4qKxA==
X-Received: by 2002:a05:6a00:1ad4:b0:730:888a:252a with SMTP id d2e1a72fcca58-7347918d99bmr11980276b3a.15.1740601511484;
        Wed, 26 Feb 2025 12:25:11 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f7de2sm4100963b3a.106.2025.02.26.12.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:25:11 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 26 Feb 2025 12:25:03 -0800
Subject: [PATCH 1/4] RISC-V: KVM: Disable the kernel perf counter during
 configure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-kvm_pmu_improve-v1-1-74c058c2bf6d@rivosinc.com>
References: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
In-Reply-To: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

The perf event should be marked disabled during the creation as
it is not ready to be scheduled until there is SBI PMU start call
or config matching is called with auto start. Otherwise, event add/start
gets called during perf_event_create_kernel_counter function.
It will be enabled and scheduled to run via perf_event_enable during
either the above mentioned scenario.

Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 2707a51b082c..78ac3216a54d 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -666,6 +666,7 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 		.type = etype,
 		.size = sizeof(struct perf_event_attr),
 		.pinned = true,
+		.disabled = true,
 		/*
 		 * It should never reach here if the platform doesn't support the sscofpmf
 		 * extension as mode filtering won't work without it.

-- 
2.43.0


