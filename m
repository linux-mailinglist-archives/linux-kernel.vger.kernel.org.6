Return-Path: <linux-kernel+bounces-187738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6B68CD79F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C7E282355
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866A514F6C;
	Thu, 23 May 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC7h3/wF"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477E134A8;
	Thu, 23 May 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479283; cv=none; b=cfABsSjnQQIAc2eaCKU9QgbN6aotV0t2KmA7MmxmFNy87lcqcSln443R8ukOt+DH4ax5RDrmXVTCL7Y8RjbAfjrh9Hvxmgif4q69Dvd3o2nb4SujsuAvx4BuOLAcT0rejvKZcfjRGSFLpSoffZOAtjS9//Hmj/yxCcmemEDdkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479283; c=relaxed/simple;
	bh=ZHnkNKioKAsUjiXsf6jPQAnEKGSvbHAO3srMeXpA3fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q5A+GAS5xfRSN+b/s2YEYZMNXlALE0BqIrYBxWThcGjlmevNfN98m+7BFZGvY8GxdaBx4Hrbub2ssxi4Upj9qSQLyayeyj7bFfJn4144yHxem8iTV5ZIBQe20SvmErlF1CAeUa3z6nr6DYypk220QfirPry0xlhCU2BKm/3jlwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aC7h3/wF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ee0132a6f3so19216665ad.0;
        Thu, 23 May 2024 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716479282; x=1717084082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o78m7F2cS5EFemgK8KupdgtjgpDVHetWIF7RgPFVkmY=;
        b=aC7h3/wFlG+kmPo2X+ibumjsiIzuWZ2d45KMdYg8og2xXtT2KL26n6B/XZ2KtCDU4b
         szMqlEAVBvh9siHy0tL90l8S0CD0jh3kTC4mku5Ezf0rwDfr1sihtAQW9GRlrye9201D
         ZHOXIrLE9vcSGnEsVkqYBtHbdPKOYosXBEK/ktJIetYY86ULu6/Z508iKLuwb0XyzaAD
         jsMVPnmELyaL+vir7hkMH3oYC0CEYoWn5r2AI46pnnTP1n81iX7XUD3WE7C2ak3y3a/n
         eKDzTe3TNpEQKmg967Ne/9KRVnwRzaB6A/ImWcurybPr+KmvDUOJLb9uDXO8ZgJGr4Uw
         scgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479282; x=1717084082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o78m7F2cS5EFemgK8KupdgtjgpDVHetWIF7RgPFVkmY=;
        b=l/IfsTb45yx5Ep1zEREHAcp86Hg7pF4nEX49os4Pqe32OmUd5EjskmM2RsGGsXT+dr
         Z/yO0mO4W1GIIe5C6tj26Z1F3KS7Aczj5Het7Xx+2154yqSVsQSVIV3u8fltOZuPsCMy
         pi+FFvyc+hncDpOHED30ImnXBA05cH2rL5xRwFrOel4QuBglpmeFRug2U+kJ60DLFCi8
         LCHqaWilBMNw2tmUEBeZmz6JgVg2lHpGCRzEFtJG6o9VRiDP3b1k2jov18fH4uNW5bdD
         YT5PYetBpt6grZmFx55kQ2YoLHt9Zaeb3e0qAuVWnuj2XIVCUh1Z1c/8m5ndOHZdmnNw
         RbHg==
X-Forwarded-Encrypted: i=1; AJvYcCXzGGJ2/F3QnIPGeCmi9SBNpD3sNjgU5pP9s0949uqFz4donDWhkP7S/EnZgvJZL8FCJv56KwC6aiOoxK9CZnhOg5X0YKhIDa5CVcXBEdWT2HbXh1ooJOpp/uNc1oXf/s8+B4/JgSxrcA==
X-Gm-Message-State: AOJu0Yz2Dt1uT4GFhfuRBY3veo5DZ7vuI/EDlO4aD1jOrW7HUpj4T9GS
	xUxiMWGMigFpoeUSHZOmaYeIKemhz0MnZcJhKnb+LSUfBXAwHHcy
X-Google-Smtp-Source: AGHT+IF4h9aBQCAvqJguyc60LZJdBtiCQ1a9fs+Yy1U0Hmo3zlBITbxQlQVsAh2MWnwEKIk4VYa9SA==
X-Received: by 2002:a17:902:dad1:b0:1f3:4945:28af with SMTP id d9443c01a7336-1f349452ae3mr13316705ad.11.1716479281862;
        Thu, 23 May 2024 08:48:01 -0700 (PDT)
Received: from localhost.localdomain ([223.178.81.93])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f3361a6678sm18321085ad.178.2024.05.23.08.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:48:01 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
X-Google-Original-From: Kanak Shilledar <kanakshilledar111@protonmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [RESEND v3 0/2] dt-bindings: interrupt-controller: riscv,cpu-intc
Date: Thu, 23 May 2024 21:17:46 +0530
Message-Id: <20240523154748.22670-1-kanakshilledar111@protonmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches converts the RISC-V CPU interrupt controller to
the newer dt-schema binding.

Patch 1:
This patch is currently at v3 as it has been previously rolled out.
Contains the bindings for the interrupt controller.

Patch 2:
This patch is currently at v3.
Contains the reference to the above interrupt controller. Thus, making
all the RISC-V interrupt controller bindings in a centralized place.

These patches are interdependent.

Kanak Shilledar (2):
  dt-bindings: interrupt-controller: riscv,cpu-intc: convert to dtschema
  dt-bindings: riscv: cpus: add ref to interrupt-controller

 .../interrupt-controller/riscv,cpu-intc.txt   | 52 -------------
 .../interrupt-controller/riscv,cpu-intc.yaml  | 73 +++++++++++++++++++
 .../devicetree/bindings/riscv/cpus.yaml       | 21 +-----
 3 files changed, 74 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml


base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
-- 
2.34.1


