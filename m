Return-Path: <linux-kernel+bounces-527783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C5A40F6D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 16:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0D5176325
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88BA20A5D5;
	Sun, 23 Feb 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2MdGi9E"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDB4BE5E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740324253; cv=none; b=BepNm1Pkk6Yw1M+9e39L3IKtSmneL/aduAdlFcU3ZiIKIw2iNfN3LLEG0sTv3fK2Ejx3xgvBDuO+XZMPFUuA3nGMU8qCpz0LgBvMHA8JXw+iQB8XqExuNTowWLx1F3re6slGDb8HOX0ZZlIJ26PAy+IYJYkzsml2n2FmDVb7BaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740324253; c=relaxed/simple;
	bh=QTCnTo7jATyvi6ibfSdkLeYMevxjmJzb6on/eLLP7Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SM4yj/nusVSAbNaGUtr/9Jnvf8g/dzipfK8yFnp8P9Hf8gKI5s+RcIqvxnMyy+xRiiJJNixsWZpAWbrPMbF8TxpzlrcK2Mt4+q3Qc+uAOadlk6dWHQWOROtgVB2D6HI5i0c23JRvNiVb9LgF+VQ3hplbxHoE7GKrR39LlDnW+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2MdGi9E; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso617462866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 07:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740324250; x=1740929050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xyt3PPaYlNgcA/j7n+n0sHAguVTAN2baVeJuxMTgLrE=;
        b=J2MdGi9E5Ku5wb4F5wYA8EhEpk6Z/kZM4kaFcIgOB1p3rAgICSga11SNw20mFEfsS6
         1vxlNhUGBU8KoL5hZEEUvK9CoME4kDj2RLom7hIcCHkfLc1mSCZlf6Ne1xUrT+5U4/AL
         BLaF1gB0DAQu1PST7vDKKmRes0x0aVvt6yWyJY55r3tzViLWhqeHGK97FeZ/zxSTWWa3
         PdjvI/PwQuMnPGXjTmAJf/K5PXv59LeT5VOr0EDMrZkDWp/LRdPR51yBqlhqhAbpufy4
         qc1fj2i80jzfomzV8DFwPcm6Gob8biExGSzbM+zzfW9IcG1nrs7jcIXWQGzhJM+T7BVK
         s1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740324250; x=1740929050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyt3PPaYlNgcA/j7n+n0sHAguVTAN2baVeJuxMTgLrE=;
        b=XASNf9/UP6Vj6opESh8Plz+jtVjMWzOgm6wqZ8z0153HNwAHJfBW377SrhZ/qwYZrZ
         wbtrhsJan6HuopFYQdqYr9nzBdffwsxY4ei0+Rd9AQw0GQfmbUZ1ikmt4cFYnhbYathy
         DsZMrgMWJbb2UcsHYWQY2FVq4GcsvLB3J0r3rLnV77twt7+ImA+tjpAanPGaZY/7eljF
         5nxWJ78fP/vhV7Wy4LRdIJ/rn/U40GGgTVPKQWZ5g1MxegrqZwItNw42fy9SPRWQwSNm
         K+bVEax7QQ4+q67nDA7xVo0fHXj2GjYsHqQXExBryZT328/5m8qwDLEqwQXaQPJqHgWG
         VAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvF7Wy5WkZq5AjSbQlNkRfyr6W0ZCkBwVeba01gyjlrtNYi3NuVgEyStaxT+h2BY6QWcZDm4O/tiwRr/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxldcEgZ012e84nsPGpaHq9Xr68lv9dBR18VU+lJ2f076KYqjnd
	5BIs7zgMuWF2QG6jcD82h/6dF3QGIPKWJEH9mO+yCRDheYUzHerSKsuatdGZ
X-Gm-Gg: ASbGncuvF9xg8kpV54HV3Ycq+ha7cLT6RQS62LrqAYKQ8ONXcwPUQX08BAxjjTG/Py1
	kV4duo8tzWiRnaiAFNWYOqOJkbq2/Qx7dMnFbiQag1Ny6la1XtvkiZSRshwmHxS5hpH3YDx+eeT
	pyi4x4zFCPqW3PvLXVz8qrxDrHWnwgYevMHTrjvUzdY62Gg82QHE6nO6+zss49Wx7qFcCqbHSKK
	sasTg9cW4bFZB22t1xKrThLK9/jsKU47JBa4PzPXfXB4Ak+DG6Bb9J2VJSdaib79fxdRAFNYCaB
	TRQBVFoVD0PTSo91pSguwZZoQfkopExDu3Ty+zw=
X-Google-Smtp-Source: AGHT+IFIRu2Fr+hl9WNpDQE0EmyLzkg8g5O+I7r/hC7hqDYW4YUCySAui9U2daVsbRmLB7U7g+OQpg==
X-Received: by 2002:a17:907:d2a:b0:ab7:fc9a:28e1 with SMTP id a640c23a62f3a-abc0de5a487mr1018666366b.52.1740324249605;
        Sun, 23 Feb 2025 07:24:09 -0800 (PST)
Received: from localhost.localdomain ([165.51.10.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbde327701sm872767766b.164.2025.02.23.07.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 07:24:08 -0800 (PST)
From: Salah Triki <salah.triki@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] arm64: kvm: ptdump: Initialize .owner fields of kvm_*_operations
Date: Sun, 23 Feb 2025 16:08:44 +0100
Message-Id: <20250223150844.628175-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize .owner fields of kvm_ptdump_guest_fops,
kvm_pgtable_range_fops and kvm_pgtable_levels_fops to THIS_MODULE in
order to prevent unloading the module while these operations are still
in use.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 arch/arm64/kvm/ptdump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index e4a342e903e2..50f7d39333d6 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -185,6 +185,7 @@ static int kvm_ptdump_guest_close(struct inode *m, struct file *file)
 }
 
 static const struct file_operations kvm_ptdump_guest_fops = {
+	.owner		= THIS_MODULE,
 	.open		= kvm_ptdump_guest_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -244,6 +245,7 @@ static int kvm_pgtable_debugfs_close(struct inode *m, struct file *file)
 }
 
 static const struct file_operations kvm_pgtable_range_fops = {
+	.owner		= THIS_MODULE,
 	.open		= kvm_pgtable_range_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -251,6 +253,7 @@ static const struct file_operations kvm_pgtable_range_fops = {
 };
 
 static const struct file_operations kvm_pgtable_levels_fops = {
+	.owner		= THIS_MODULE,
 	.open		= kvm_pgtable_levels_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-- 
2.34.1


