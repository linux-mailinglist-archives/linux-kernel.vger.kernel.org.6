Return-Path: <linux-kernel+bounces-378093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042239ACB39
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41E31F21C34
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434B31C232D;
	Wed, 23 Oct 2024 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="J01Kl23v"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1061B85E2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690172; cv=none; b=WpC8UaUPBnIjZIEImkHZAasaJR6XmR14eVilzjyhXzFzjmxvpC9+rPfGAob2E7iuF2Y83UeD58NcjPyMNVcFI3RsR7kLwJL1vcLgtBn8jtPKvRBbhvK0n5w0zTfqiIMzUhEH/yttk+fKZC88kDtLx7VClgDXl/AvKi2T3wOmjWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690172; c=relaxed/simple;
	bh=cBmS4a05aaR7mbhMwQWco/X9t659MyL7blbdEaWcl0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmVXE8k36lnyYZYfXeYHvISLYH53Xi4QtGPcLQm4Mwx7Gud+jBPFo1VwV70Layr+fneMzaKGgeEoBUDoBK5JezbWzaLzd6EG1XaZpn6UsnMo/+kOPKjT1kHvEjRu0mlMjXOaAEqs1fsxflG5a4eRN8UhH3muQZWuc5K8FnU/wqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=J01Kl23v; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so59562145e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729690169; x=1730294969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
        b=J01Kl23vNTzjtUOjIc+h5UpxPtpb4AVOxWWdLJJ6plua0S/HE+imb74TQqZDbBI+9r
         ZRQ85dEu/4LRStYbq/BTrLI1CvE1pkrx5z1yNLYEzXlflRop3PqnqADzWtAKvPPWzUMH
         0ePgiyWDDDNoLk/5+N3F2lmYTqKOGFSTXoGfdUQfg/a3U1A4ezjNl4kDlQ1rydhRtcCg
         TIkspkBJxdefK9y2eBIaSCOAnT3QiLlKJlmYgXZtFotzNHcQO/M0XL2FGVZeI+2BaV+1
         cIKJgyNmbxnyewy2TuShvbFaTWpzBjngE2dNcO3LkldBahooVewkDI6gVEpueIwM3Rew
         RbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690169; x=1730294969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
        b=B8lxV6PuURqzMLe6LeieCUbxZt3mb/HLCvUZ3FuyFOp/1561nu1RImu4h1haZ06goG
         eSmw/O9OB34bqSHscPbpaNKgNHs1r7eIRot/jbFCC4zYwxy60PAfks7czaP5w7ATTIzm
         O4dsO3kydIV6drLyV+ls4cyHG7eVch04tHMj6Sg41noSDIRJ0p9YgbnLW6nbldfHnU0u
         Hd+cguOdDi4NQ3LoLNyzYyce/JVlhSVK/Nh+Op3DdwMmvLz0225rMfKIr9OEUA02frFb
         GyCmec/JBonHP3L+IGU749lfrImv2J2LuvkpUU+msBXHhV6yB4Glm4JXebV8O7FM/vhl
         WKjg==
X-Forwarded-Encrypted: i=1; AJvYcCUP/gtKcNTotBt0f8vAcjte+ek1pSvt4nYNqeLtyPBCYf+24eAAdS7SWqXQA4I4TuZXam2dzvCede4JYSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgtJrzL/AzoiHpG4W3NRoNl81T9CCPwavM5yk6hcxADrdzyuE
	DNIZOqd4FypHh5NThO+BmzFGtDS/UWCH2SkXDi5UHX5QKpggk/VaMHdGViznMNE=
X-Google-Smtp-Source: AGHT+IEbHRtadZQdck4N2LEJCemaMzwAbIa0MY+3Lz9kbX0/yOaw6eHHlCryU0TMeT5GC0OP7yDQjQ==
X-Received: by 2002:adf:ea47:0:b0:377:683f:617c with SMTP id ffacd0b85a97d-37efcf0b7afmr1841728f8f.23.1729690169008;
        Wed, 23 Oct 2024 06:29:29 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:29:28 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 31/37] armv8: cpu: Enable ACPI parking protocol
Date: Wed, 23 Oct 2024 15:20:14 +0200
Message-ID: <20241023132116.970117-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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


