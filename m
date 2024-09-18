Return-Path: <linux-kernel+bounces-332770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C540597BE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2855DB20B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346011C9ED0;
	Wed, 18 Sep 2024 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Q6lQzuV8"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAFD1C9858
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672984; cv=none; b=pG6/j25hKT9VCRP3O2AFJlqGxiPGP98AMy8e5rj/yrp2bo7i4ztgDghVFQPa+kyzRlKc79wqJQk83Skqv68YH5BM4HvacvysWTyf7hOFudJIsEl6p6HnnIEEhHcOWE7dU+fTDj0Mm0TKz0GAR83zFDF3vwgNScDVpZvQOjYLUew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672984; c=relaxed/simple;
	bh=nkZQw9uG0jzd/yRNKRphBt/G222s0zjXctNB36t/HbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMyfmGPw422P4cUEFLyVQVnkLqTVInyWJlHPj4L5lQN4w44Wl6Y7A8wLDaXX3Moyjtq8Ip38FdK7LL1kvnXxh0EOoEB3Tz8WT1gS9atsbblVBjGaWr68hnMSV9WEt7RNieyW1JMLrMksRSyP9Nb0wjvMI9XgSwXdofSS3j50EGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Q6lQzuV8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a90188ae58eso881990766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1726672981; x=1727277781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE3gGM8Mbt2P9fn0Xds2zmj9qx168rJGAMqKfFc4sfg=;
        b=Q6lQzuV8cUd9OtFt8UAFm8+5TgA+QgotnUmYb1ole7o+lDXk1ZIMthbaVFMzq67B0y
         Bayz/m8ouNcljQfTSKladkjwN8Ue76M9kFkWoQGez7VmegNiT430ECfEiFauhpdN9xLM
         NokSobi2cYeGQ5Pkci92z+anfkclRReCs0DrP2ZFWhzK57nC8PwVdaQVqm/EeL2JDP3O
         S4uV9VeL5sROuX8KKg/jPoFRsfK8CiiUT8iAVC88hKMYnvo8d+LHevkG2Zobcc+g4JvL
         Vz8om5NjKysYF7Tz7enOha2nK6LaCciqKAmEYzbustyZgPeFnp0Gfmuiu25Kx11m80vv
         zD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726672981; x=1727277781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE3gGM8Mbt2P9fn0Xds2zmj9qx168rJGAMqKfFc4sfg=;
        b=J0UjTDWv3TPp/b+lyfyRa7e7vEV28IG67XS//NpEb4U/h6rPTEMe5RsryJW3fiZrBY
         1WXBtCx4o6LpQNcbOVA11H/tPye0ILS8PNGo+ks96A0dakVJdOjXWBS0LuNKRk9r+u06
         hXAL3FoeSjAUijsRUNXUhXJBhgMA6i/OijnWM45QElyq/BlwtYQdhPIPpGerWACRot/n
         wwgOfhGDq+UYyxo6WAjFql0btbHbTvfhnrhdeyEi2gQ2T2uHAVWvns/jEVfSnTFjgU0L
         9y+fUCfQJ5zfrTX024rB0ppq309b+r+gwSxP1cZSn/8/AARdWMHjbu/7DHQfk5aSZqkw
         1fyg==
X-Forwarded-Encrypted: i=1; AJvYcCXpBH06/xLIbbrbHkcD0U22uZBrY3+GO/PDFN60TDTyuP+R0nxqzxocyZh38KpIgZQnpO3eufAIQ4Pmpq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq1hoTNEALH6SZabsVOQgso8Yz29N7A/QStxp3NKexBcWg9rN5
	CV7iqag0vZzEtp6/fn+1+uoAevVYnfadx7xbhKmImNAlSAC9H7gt333ucTa28+c=
X-Google-Smtp-Source: AGHT+IFZB6sAh/kAQGwAowejA1xcEpL25R+X2uEkScWFnRNv+StVwWIATE1PFF0+dki0vHr4NbKQ4Q==
X-Received: by 2002:a17:907:e283:b0:a8a:af0c:dba9 with SMTP id a640c23a62f3a-a9029444940mr1955750966b.16.1726672981129;
        Wed, 18 Sep 2024 08:23:01 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 08:23:00 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 31/35] armv8: cpu: Enable ACPI parking protocol
Date: Wed, 18 Sep 2024 17:20:35 +0200
Message-ID: <20240918152136.3395170-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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
2.46.0


