Return-Path: <linux-kernel+bounces-517177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C556A37D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C6A165BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DFE1A5B9D;
	Mon, 17 Feb 2025 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WXrnlq1V"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB361A317B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781911; cv=none; b=OV79gjpWTab2uVnE6I63/h4e+xBJZxSFvfOPcAWELSc6+F5HATRWoqksqjxMR1Ic1gywERocxGqaUrbdh3V3yUuBnan7FPpH1ODA2nmM04YMV+Cqn9HFWh8BKirQA5tzbK8YFRMH38WtZR0EZuS8kaOVKHIMDqZ0HuUW7Bq1mzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781911; c=relaxed/simple;
	bh=NceHRzo7rfPzw9qlSpoCUbMFfY2h6D1qiOQGzNjwyFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Om4qlGb89M3+VyDdCAQkmvOhcl59S/G74u6NxmX3RjTa7vYgSa2rKzjbuqdkoIXsv3NtPQWED7kIbM8SMmdLoYly7/vh7kM/aWCLoJUInCaD3tdv9KPhBv8Q4xnJDDtKVIiMzbSHizLkWjRnBwEKih4HqjfQMHh+PMzvUbqGMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WXrnlq1V; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f3ac22948so564940f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739781908; x=1740386708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GPsKALm7Yq13goem1fMBJYo69c+TVWg7YcZfawoJnY=;
        b=WXrnlq1V9uIna3e18b/lTCXtDYw4ToE83osFNlY72Ecm9Hk5EgLvdXDW+LfpoenBhJ
         ehblgStMuOQy+8mifi9iBrmk2ic8OOZf0zSmY+f68SVwsXVcY42x/7ZybB/H42HjSkae
         lxwqfBjM3GdBOxPLqNSbpTjzIiuhOo3pBMhMmQSm0yk4fz/uakSIzsaTI+RswNOs35FQ
         GvV7AS1Ow1yKW0gEw6oxV/36rN8B5SoWtAIOZW6R0GyfLJ6nueIXpMS99AzuiJK91Ig3
         Lawh9met8yncZqC3E/8GPSJ7+7dS6ePWtPHOq7hcVG1/mQzJInxlZA/Hx83lF4YxhY6m
         40CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739781908; x=1740386708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GPsKALm7Yq13goem1fMBJYo69c+TVWg7YcZfawoJnY=;
        b=obUa9ZpEEbsI+2yPGYEtDNE3dTTk0PDiKwea9X7yH4+CHVuwqBx9Y74eglBzxtSpte
         Wphng7OLB3Ry6SZ4KFTMXXH4NI98dXJmKgkGT6RqJV5a3yTXJko+0xeIyv2PJJygr0XO
         1jj96FK87VkchbNfHaoX2ScjUY9890ZGdbs2JNk5Y0uUisd+XXx4FfbKpVOScyRigL3I
         rHIQJmwOTkGqRla66ZOfWjhtFcagVGctXHhmNs5Xqc7Sp1jNorgOdchA4tzHU6UCaBKO
         /TrH9176jl+roeOxwovJYlmub4FQZmyELc/b5/qBL3NHPo/t7NeV+hX71XhvpW8e9xTX
         hGlw==
X-Forwarded-Encrypted: i=1; AJvYcCXTf6nbi0+6NDHUjzColJUCDHF3oOSRdtKqS92Gw9Gqv9WNmDqsqy7TE7j3+Q+AjsGFYVJQ9XbrGEGEnX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznFFyIGvmWJI3itNCPz/FrZYNX5/rW0HWNGm+aQE2fQ0XcpBp5
	MUFnf3HH9WP9KIDAv5+ZxvwehcSaGkU/vEjZRlWQluAeEUdnpCaybrZYlRR4vME=
X-Gm-Gg: ASbGncuqcUsBUzgxu8o8wMvmfdk4VBLQcinNVqPfWzfuAfGZkHNVhZQV73P0YB+PcR7
	k9ofNnKhLMqI7YmpMbna2RlMbqEC6JuBrJBzaKrJEHdXsvFKUdsPT3ZtStHE/gDIPw6trT501X1
	coqBLeiU9H62x7pBB9d9c8broVD7oyZugsauWTD/BgtrShlku/XNRWMBO8kUV/zo9UEc5IZXtos
	4aOJ2WYXPEn7nbXdvOQ5PYZVWF11G5VkKyEdfsNfJ4DEQ21O1uQmj7vQEMmqIcF2D2izm7UuaDq
	wdI=
X-Google-Smtp-Source: AGHT+IHp9BY0m/Q6kFaedN0UGWMC/ZwJ9KU/eUOLSaZCeTXH+n6PgSUFQ/UOHrMVcwrNPsAg/8wITQ==
X-Received: by 2002:a5d:47cf:0:b0:38f:38eb:fcff with SMTP id ffacd0b85a97d-38f38ebfe58mr5923816f8f.29.1739781908113;
        Mon, 17 Feb 2025 00:45:08 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f771dsm11482660f8f.81.2025.02.17.00.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:45:07 -0800 (PST)
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
Subject: [PATCH 0/5] riscv: KVM: Fix a few SBI issues
Date: Mon, 17 Feb 2025 09:45:07 +0100
Message-ID: <20250217084506.18763-7-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues found with kvm-unit-tests[1], which is currently focused
on SBI.

[1] https://gitlab.com/jones-drew/kvm-unit-tests/-/commits/riscv/sbi

Andrew Jones (5):
  riscv: KVM: Fix hart suspend status check
  riscv: KVM: Fix hart suspend_type use
  riscv: KVM: Fix SBI IPI error generation
  riscv: KVM: Fix SBI TIME error generation
  riscv: KVM: Fix SBI sleep_type use

 arch/riscv/kvm/vcpu_sbi_hsm.c     | 11 ++++++-----
 arch/riscv/kvm/vcpu_sbi_replace.c | 15 ++++++++++++---
 arch/riscv/kvm/vcpu_sbi_system.c  |  3 ++-
 3 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.48.1


