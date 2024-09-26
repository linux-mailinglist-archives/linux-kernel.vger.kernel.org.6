Return-Path: <linux-kernel+bounces-340092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C730986E79
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5341C226E2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C432A1A4E6A;
	Thu, 26 Sep 2024 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="dVsxz76b"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A301A3AA1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337825; cv=none; b=ZaKERzMhkWddfY4jNZ0qD+6QlsANMx/ci3+o0yfQEJi5AKi9FraX2yazAFRHS0isePqnHFH2exh68cI0Kr2NrkGY3LF/pUOgwVEgd421rVXMnkg30exk2huLoV8UugW8sGCDr+cI05GIQxfumT+iaWryPvV9N6brikyuAfYBX8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337825; c=relaxed/simple;
	bh=8NgYmc9OSQd2FIvDVwln7UQpoNxX6QKcKAGO+xVbgv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9akqhQ45VrEuVnXZDZ8WvAmHX9ChvbcMIDYlWXi77sKQP38cOYs8c7EpW6+5QdksmnwkJxzAqLHqN1q1WKzZ95BOoJz/hPGS9MKnXEmTPq97yJD/rv0drsb31Y6goFqViUr07nmftATJfYPp1NotllEIN35agRBp3KWfwxZmpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=dVsxz76b; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so8983231fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727337822; x=1727942622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+td+bn1sYI2kmc3DCFaQ6qTxQDzn/n6yrNIueFnBvk=;
        b=dVsxz76b9ZROMmP9vbqPXje0cJxvkXwB+ZLKC0o4M7wE7tF75QoX0MXuEBSvzh8aYy
         azmneVYGR60OHg17AVnbzitNPtyEDJm2MdAY/QjygEYfZnIBScmVTd6IAzK90l4njx+2
         3ipJbkaHi5FZPScgg+ECDWfH/xxvEQ9/+NTXiqPQHbUpusI5TqrHSOuzzHYQP4bfv36A
         cu6IC2e3d/YSkkpuoVIApqlA1qJhSYkbwMgSwRzTiAL7xIDjd1PPw6KHS6VQSl8nXPkj
         EPE+dtt9cHj4QiOdJo0FO/ZEb0O8nZFeburdYwlARSxUXt6yTqIQyVuGP8GG4DXHLpIn
         WLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337822; x=1727942622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+td+bn1sYI2kmc3DCFaQ6qTxQDzn/n6yrNIueFnBvk=;
        b=KA1oFh3bIinXDBtf1ahTCzpMRiqyr2IiorC6WkiAw+XdU86krhaafmsxJaJ46hwMhP
         OWPfU1k1X1ddMbTK0uJnAISqOk0+yqeBSbFtxoKR5clv6V5uDyv7oIbwZG4J967snuUC
         8q4S4idJqBPTb3Kgw9jgDtztu4lgij/up9WOCkHdzegGIFJZJLFsnxpZwEdRD+x3blYt
         IDS40dwKnOrdqKEhCoTUSN4RzL0kjIRblVepacUGECYMUWNV4t6r/OECGqac4C6cG+62
         CabuEkmAPVOF3konfAAVukFgA9ZgGCBuBRRSYIfFlM+zAm910D/CvbrIQ3YDE1g97sIB
         dlrg==
X-Forwarded-Encrypted: i=1; AJvYcCUbOnHPJVJ1qXJfY2410NORdDUbbT63hOzIJjlHvY6J3b4h5PANhjBWBWE7/UlbUC8QVdznu0Y+OLYhL+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfr3l5RWOsqWtrM4bwTcuMmxUHNkcSQMJWJHqfFOTHOcCpE1xf
	XJmaSZW5JhZYXQDTZHM1iyrhDk00P/qC1eu0WnCdRfwRl67bxsHLrP+DTQV+Z1k=
X-Google-Smtp-Source: AGHT+IEtiL6A+X6CMQ4LGDxeg7rMSKAwMAfDYoL6CEGkbrIlpm5koOFd0bVqreqj1K/05Bah+V1ymw==
X-Received: by 2002:a2e:d12:0:b0:2f6:62a1:25ff with SMTP id 38308e7fff4ca-2f91604ced6mr37983791fa.28.1727337821640;
        Thu, 26 Sep 2024 01:03:41 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:03:41 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 36/36] azure-pipelines: Enable qemu_sbsa
Date: Thu, 26 Sep 2024 09:59:24 +0200
Message-ID: <20240926080021.148031-37-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add QEMU's SBSA ref board and run tests on it.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 .azure-pipelines.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 93111eb612..2881851ecf 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -250,6 +250,11 @@ stages:
               wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
               export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
           fi
+          if [[ "\${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+              wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
+              wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
+              export BINMAN_INDIRS=/tmp
+          fi
           # the below corresponds to .gitlab-ci.yml "script"
           cd \${WORK_DIR}
           export UBOOT_TRAVIS_BUILD_DIR=/tmp/\${TEST_PY_BD}
@@ -415,6 +420,9 @@ stages:
         qemu_arm64:
           TEST_PY_BD: "qemu_arm64"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_arm_sbsa_ref:
+          TEST_PY_BD: "qemu-arm-sbsa"
+          TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
-- 
2.46.0


