Return-Path: <linux-kernel+bounces-367344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E94F9A0129
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A90F1C228D1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B418919B59F;
	Wed, 16 Oct 2024 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="PlsKfRnu"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4C19993F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059218; cv=none; b=uGOGcKKBQD8ffRYI+JPpRvqkenEDPrtzlyVqf2NYzq155Ao+qiYUCcQijaJV1pfEIK1PbyDvEg6T1+ApPcTiq1hAWsBqZnwRFsOJX+Zud+a2z13++y/MnyjmKwRA2sxR0Zb0iWev/N3xvII8Lvqw+2ozPlGuZyxs6uU+Etg7akA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059218; c=relaxed/simple;
	bh=cBmS4a05aaR7mbhMwQWco/X9t659MyL7blbdEaWcl0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSoM+ZuYmIZ98uw4yhFNvtDelnqm44a5K8kuU7EoJ1/t4B7CTJIdSOV77o9A7q1KiGjY5q71JhLsDFgKJlC/3J9L3ZBxn6C957keVfN2ypKueAUuzyMm27qNIUtLpZA8kP1WPzntXMG/hhEnX6Mkq2ELxQK9lRlvRfVMXnLUlr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=PlsKfRnu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d495d217bso5531110f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729059215; x=1729664015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
        b=PlsKfRnu2ZJw15qAY6rKoFpr/sMz3Z1SxUa66BYyDCVD9LIZ0fDO/MVz8YAAtlqVoU
         lEJccHAfayhYQrB9su+1NZown2HRTKV1sYaEaFfMdKX1rQyAi7T1qZEr7W9oBuOvk38G
         5ovQBxuW2eyH1PFkLZ4nDACn/HzLiWGtr7a17/mGzchp+7kLPDlqU8Y4s9SXQAHGGuGq
         AD2SC3CWcxMq87IXzR6aK1ju2OdgmEqVDXEjmsNoiWhZDUfLi/hT0E8d96v8RTMS2WWG
         7EiGWFygyWpUUTWBRyfh1uTESHH2l71DPXbCR/KJq9FOAIR1j2302hx1nWLhCkMeoBtR
         JBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729059215; x=1729664015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
        b=ezg5dz/sJRmnEos1b20nlXdkfR21fWaqVfiqmoaDuolnYYEELMIrtdxjVHvMO9MmWj
         X5eVkoARZeZxNXYQ4ZTvPCwMzktCKS4C1KdqdVQK8RUemeQ12rdiYeOnk4eBiZncqMK8
         6XcbPPQYH2QjGqf42X8Z54heAagw42CtBCutfG28uHIe6xenK0AuiDSW7FBwNU96WIIi
         BrTAKtZXN5sqtDYgaEdIcsGPBR3qkSkc83M6YIL1q2sp9dQpEStR4rgHJqgewM1DZ7bR
         qlVtgSlzDc0VQ++N+tIlvggGDg/0Ucd/HJl328uD+FEb36qvWhZfTrzVYzGuvJl+9R1d
         Xxbg==
X-Forwarded-Encrypted: i=1; AJvYcCWo4qdCbucXjayP4tqSa4vEUbeS2wPxzEopYHAOCya13ITT8gP+dOJ8P8e5jCd+o2g7XBBSq9hiJr9tHO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rjZ+lQyzw9OyjAppTjBFq3aeef3uSDThcOqWjEjTgtaEoXwM
	Z5L7YqW9VkrAHQfzsAwijTtNRTUwGAD0Yl7jacR1DsIJU1lwsw+KldwXOqkpXmU=
X-Google-Smtp-Source: AGHT+IF0WF9262pXm3AimlPehYVZDw7T5rdGjTAdRucV8iABeQqaQ+6usn9UsgCP8UQq2Eb5AUp86A==
X-Received: by 2002:a5d:540a:0:b0:37d:47e0:45fb with SMTP id ffacd0b85a97d-37d5ff86f1dmr12103470f8f.21.1729059214701;
        Tue, 15 Oct 2024 23:13:34 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:13:34 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 31/37] armv8: cpu: Enable ACPI parking protocol
Date: Wed, 16 Oct 2024 08:04:17 +0200
Message-ID: <20241016060523.888804-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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


