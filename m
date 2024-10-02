Return-Path: <linux-kernel+bounces-347287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A7E98D080
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2B8B25148
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A350F1E5019;
	Wed,  2 Oct 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="U/yF9mvi"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE91E201B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862777; cv=none; b=lWjikDnk0B7VOLM3/e8qY0wq2YYpB82RwJqZSdGV2ZLdUI6H6OvsqGFHOcoA8fA9i/eBguGbc8GzrNs4A3gRVNgQycBsga8yrPmziQTFw0I8iSHBB4QHtVGDSFYGBKUQXK6RKFsxa54Zn9uGdOIpBssMcKGxL9ej2SjxGJmDt20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862777; c=relaxed/simple;
	bh=cBmS4a05aaR7mbhMwQWco/X9t659MyL7blbdEaWcl0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVy3OOva1LmC1PEcrKI5yttky8pHIOc1EzkhehHutjs3+e1F19rLi+fLJ0ITWY/EWKpF3HTAPcG12+c6o5oQIYAw28akIKdV4nt5jO7hSk6XjA56kq49U8h0qxKCNy4e9dvRcBP0s65tqINTXzAnucQf7jZQOhZWa4RXu4aEv18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=U/yF9mvi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so79800635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727862774; x=1728467574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
        b=U/yF9mviuSMPDu8IbA6+cwWkRf0H2XKUx91avIqGE6Nsy+PJtppUP6LC9g/7xGqNRN
         jTSC5OxlyYLEVlmZjXwQVrBnq+kW0B4ccvQz4ir0+xEa3zK9RjcZDx+wTjdujplMCn06
         Bsu4TNVzctFohBqMaA61odj+HjIKJRiR2cGiTRhPvDLINa/NZePHBxXEftuZAVqMF/WH
         8lpK3B2zz1vrXXl7Xl/Imu0trZqfiUT/QmEZiLQJGqYbiEhOUk4tXnYupf6yfM4eRn/H
         ytw322C/isrAvWFgasG8ei/MnH1wJNX4BixUmkmaTvHX+DxduLDL+GgoPtAPO8FmV8m4
         +Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862774; x=1728467574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
        b=leO705WysfLhvjuMMtRFdeJ+xKMMI/7njR9CD4nBWNZsNZUfxaN04anMY4yKIRt9v3
         WfRCunbSA5i2IcyswOuwbhyeVEMRzJcIXGo3OcSS6Ae9XGKYj1Az/jI/JjijkTzcimJV
         rwF8jbg/ZodVBrYqi3YyLzo8/DXtgVC1oz8CdhbpuvGlTPMPmP2t/nb/DHLrVBFJ1pC+
         qPUlmctogxXxQac4sRavFz4YB2mZGAgqjCiSVMQpwpNruANgOxqceUsvSu1yndgoQmzJ
         paGXhoCH1mRFjXx9IwmV0ZX5FcNr25oMifhbr7ZTRWGVTZ1WKakp/FmIHt6JIQjeWYpH
         wxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLpTw5DdlXB3n3Q+zwDRfgc3sfFmojufSTn44VYJQ0GjlRcCrrQ+uXhGCiAOJBBeQCchWlboFHw5RdKnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFdHD6LAvZBnkJ+3Tt4SJVdpezQdOcuYC2Rb4mu/9NXS7qhuJ8
	obUQqcENgJartKCpNDsUbLfGYzO59r1pR2TcVihNh/ydMwJsBSxa+HnM8AB4Rrs=
X-Google-Smtp-Source: AGHT+IE0E9p69PU3vGQFD/QhNve6jT4Uf5BUVtK8HDGAKcf4CAa0yHBNpeEPbPAZ5NKbpYPqBjXQKg==
X-Received: by 2002:a05:600c:35cf:b0:42c:b555:43dd with SMTP id 5b1f17b1804b1-42f777b2039mr22081415e9.3.1727862773313;
        Wed, 02 Oct 2024 02:52:53 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:52:52 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 31/37] armv8: cpu: Enable ACPI parking protocol
Date: Wed,  2 Oct 2024 11:47:22 +0200
Message-ID: <20241002094832.24933-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the generic entry point code to support the ACPI parking protocol.
The ACPI parking protocol can be used when PSCI is not available to bring
up secondary CPU cores.

When enabled secondary CPUs will enter U-Boot proper and spin in their own
4KiB reserved memory page, which also acts as mailbox with the OS to
release the CPU.

TEST: Boots all CPUs on qemu-system-aarch64 -machine raspi4b

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/cpu/armv8/start.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 7461280261..544a4a5364 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -178,6 +178,18 @@ pie_fixup_done:
 	branch_if_master x0, master_cpu
 	b	spin_table_secondary_jump
 	/* never return */
+#elif defined(CONFIG_ACPI_PARKING_PROTOCOL) && !defined(CONFIG_SPL_BUILD)
+	branch_if_master x0, master_cpu
+	/*
+	 * Waits for ACPI parking protocol memory to be allocated and the spin-table
+	 * code to be written. Once ready the secondary CPUs will jump and spin in
+	 * their own 4KiB memory region, which is also used as mailbox, until released
+	 * by the OS.
+	 * The mechanism is similar to the DT enable-method = "spin-table", but works
+	 * with ACPI enabled platforms.
+	 */
+	b	acpi_pp_secondary_jump
+	/* never return */
 #elif defined(CONFIG_ARMV8_MULTIENTRY)
 	branch_if_master x0, master_cpu
 
-- 
2.46.2


