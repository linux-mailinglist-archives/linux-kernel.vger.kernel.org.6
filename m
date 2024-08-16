Return-Path: <linux-kernel+bounces-289142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD55954262
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A861C23ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1427112C46D;
	Fri, 16 Aug 2024 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VsVdHxex"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8621778C68
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792126; cv=none; b=C86mAyeGNv3NMjo6+ACa4GiqipM377xhz52j/wzG/unOMWjSH2EXigRTpH3iC5sG+8Hea6HUrKMIKIYvNzj2JIk32+ZtkdyMNIcbLOOlplf5LBa+hkGd5BEuvAMgnz9TwrpfsFwKZJlg1noAnL2ikfD8KWXtE4CNf6x7TN39ugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792126; c=relaxed/simple;
	bh=+cgzoNrTHcsPJhyV3oUxmRMuDGlYCJuvoKOnicaOo1g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p4vDBR77fG8VwD7qXkYoLqCTTqpF/MsPPhOYZK3wK3KIQEjt8zw3w8LTYS4CbJfVg+Hdph4BAqik2OFLVhQKjJ6Bhq6x+oEJe+Y+N2jSO2qpGqWN1V0JU00XnZ1/GnmqTQI2+AJIvXBF/ErlCA6M5jQPv26YyuxHXRDISfPehns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VsVdHxex; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d1d6369acso1813625b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723792123; x=1724396923; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Vqa4H3pvrihbzfusj/3lrV2Ez3LbOAxuSneAwjr3tQ=;
        b=VsVdHxexiJfKZrY/6SE34bejBNM7O+8N1evY10Lg6ID4FUm6lI71YaDVr4OFuTY3Uk
         CG8PGcosPhCM7jbhVZHthJ0fRapGllnDwTDgUJBxP+A9zc8mmEIUF91ejkKtnw9mgP1x
         MaBBrnqkFz0e5JS77jLfArMVrvNVw1fRoOwy6ILcpjXXFqRKDK7ui0D1aLgQgYBgWRfs
         EmS5iGa6ooOs+kegvHIEcnpEVeEhtiKkK2AYgsM7nF6oHnsA6Oy9XilhfEyZ22HSeOzg
         q9t/hXx6kZJc9no6HJY+MkTouJVr7lVFOkPniJgUzsBKfawyIJcud61/RuA/uajLVQit
         2h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792123; x=1724396923;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Vqa4H3pvrihbzfusj/3lrV2Ez3LbOAxuSneAwjr3tQ=;
        b=sYWnTeS75v7uFgahTC3mKy5/45NhJHzCGObcJyWVnGe9cYVXHogroW7cpIEi04djri
         Ok0H3helbd2F/vd3M6oY+eY/KO2pFRtglFPytKqF3tZ84cmnjBDr8wBbv70RzLAVy3/Z
         sDGugjiO2ydHruSs+U08QtRqUOTXGBGSAxs3SgZ7UJzr5Y7N28UuSpd8Ug4R5eH9Oxuq
         kULAEzz0mPRLh263BgDnjd2IWCefWq+tFrE8VR8G7+js4ZUYJEgUf3rQdzar353FQ6Mt
         38jFna16JvDPbxg5DVfB4SslYopIgz8C6/Ysd9Mn/ycZ8Ci1CrnK+fgzN+opVKxCjKHX
         pcMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVww1PaFK8Gdf7kVpSDKzHDVJcyMko7QzdM03AqHXeQ/FBUpSy1wqHgtlC4vRNN6EGbksCbeFmhkjivhs6yuk5WtRx91/bNzUW3Hw1r
X-Gm-Message-State: AOJu0YxdM+CfdyiTuYD+/emgG8Q2ZQNf65hrFafCRl9UfPWuij0GLDvA
	eF0TtZwNHW5JJLCmnLIl7J1j6thI57i8pAgClVsmaW+SkeeYeodEnud07x4cP9tMuGKUPiEf3Vj
	x
X-Google-Smtp-Source: AGHT+IHuF3rytZSdgjc6a/3GK/MB0ehKK5Zvbzf8Akserc/e1RWHlzoIrY6wFrSMS6kbKYCi1UimYg==
X-Received: by 2002:a05:6a21:9996:b0:1c6:b0cc:c44b with SMTP id adf61e73a8af0-1c8f86dff79mr7925906637.19.1723792122792;
        Fri, 16 Aug 2024 00:08:42 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b636bcabsm2293792a12.90.2024.08.16.00.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:08:42 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH 0/2] Fixes for KVM PMU trap/emulation
Date: Fri, 16 Aug 2024 00:08:07 -0700
Message-Id: <20240816-kvm_pmu_fixes-v1-0-cdfce386dd93@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANf6vmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNL3eyy3PiC3NL4tMyK1GJdIzNzU5MUo0QDc/MUJaCegqJUsARQS3R
 sbS0A5sIugl8AAAA=
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

This series contains two small fixes to improve the KVM PMU trap/emulation
code. The issue can be observed if SBI PMU is disabled or forced the kvm
to use hpmcounter31.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Atish Patra (2):
      RISC-V: KVM: Allow legacy PMU access from guest
      RISC-V: KVM: Fix to allow hpmcounter31 from the guest

 arch/riscv/include/asm/kvm_vcpu_pmu.h | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240729-kvm_pmu_fixes-26754d2a077d
--
Regards,
Atish patra


