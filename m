Return-Path: <linux-kernel+bounces-360936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446F499A181
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03801283365
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A8B21730B;
	Fri, 11 Oct 2024 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="adv+xbub"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878DA216A3B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642929; cv=none; b=LYiAcJyfDknYjBKV40HBFGFB70sxcO3lFEo/vGgU/kaYn8BGf+ENVHLF/kXkW9b13kjhfpr1BJBUOVB3Dz+gWkPSm2O/wp1KxhLBcqGHQ+pFFuf8yTUAj6DU4mOWolUFAIKM5rwXC/wd0yh2Vz4HCf9H5lfMLx/Mukcdg6BqIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642929; c=relaxed/simple;
	bh=cBmS4a05aaR7mbhMwQWco/X9t659MyL7blbdEaWcl0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUj0XQOrOq4lCvmHDKXE5KwV383Srmkhaszbk9xpnS5VvUouUUBsfi7/YOmvYVnuoHeh3LFS5yBnmXZq+7z/4s8rUP/SQB8T/Srj9wJVh9Tig+e2njDb2juVIJ0srXNBVUyxHHewYjv4d2BbvzFsra8GBNQuDnQMn/+ux4PEeF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=adv+xbub; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c89f3e8a74so2475165a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728642926; x=1729247726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
        b=adv+xbubLNXxqzFt/dXB/kTkC0MSgTnsX5E9hcJcAaVlLWOQX0bjOg1ktn69DizcLP
         n/v4Y01GI3VYz/fdovQTAfy+N51E+Tej004ORHeglT1MDA7VEFeRPuMJ06jgJIYeIDBs
         ihFRfLRnobPI6pcMM4EO/VhDclcMQzRu8NJoYHzQqE+dvkm6toHoZghK6o3J7iSLY5N3
         1356BxN1pF7LNVV4ASAjhtZabJ6R2J8dSeHB/o6O48vritcs+jVm9XIBU9ghtSDX1o6z
         Ejp+72FRKgYMgfHnV6CkpABroLgDkvqJeT2YSBevR3BkJ/CFe092Ben8xrzd/MdVMnZj
         ZEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642926; x=1729247726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
        b=fB7KVAGc6BF2HMNM1FNb5cQSXNrff9FMBvoUCePsFkkFaSzLDIv+hbZ8jQtbumd6M8
         f6zQjxYHZQ48tXqyLyLEGTlfEZ/fy2iRkJLEkNIjm4Tngm8pXI+l0/N9NuNgqNo2ij8T
         fg/vIegWCqFUdab4+P7p0cL6M64y5MJigiBBqu+ikU1myw0wFlJe6ch9iMV4qxNiPPZy
         P0H55cUnylNjN+9AANRsk86DfKbKRFfKSXJb6rORNNCPv6jzh2izwuuU6BaBurKvfcE+
         5H8+GBsFAphw3NIjdKEBvhiMCdmbYU0ZtiJjcuzMG0iCv/aSh5Jq8QixdwMJnE1tnOke
         6aDA==
X-Forwarded-Encrypted: i=1; AJvYcCWysMpZFxPFfA1O19Ai3p5xafA5TbUUrwiVJFxncqBQZE9weqhfC8uxzZ62xGMMiCFJxUCbRVY2T63jQxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy58ASmE458g9Lnn9lwXdOsLpEk27wvcqBJaUCJnENHdIf98uAv
	JcRLNzku4GGMbU7B+8l3XAr5M+6RKTwhdPwqdiXaJGwMbcZTRzUMkcZwaX/cnDE=
X-Google-Smtp-Source: AGHT+IEgC5xNmfKCbZyhjbL8OTm7WM7d/PpARIGX6jw5YvqVKaxBRwJfSr3oMu1MrQ3eiPkPCFA5fA==
X-Received: by 2002:a17:907:d596:b0:a99:537d:5d14 with SMTP id a640c23a62f3a-a99b93c7905mr185664366b.28.1728642925803;
        Fri, 11 Oct 2024 03:35:25 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:35:25 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 31/37] armv8: cpu: Enable ACPI parking protocol
Date: Fri, 11 Oct 2024 12:23:12 +0200
Message-ID: <20241011102419.12523-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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


