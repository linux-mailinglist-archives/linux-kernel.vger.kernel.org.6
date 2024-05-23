Return-Path: <linux-kernel+bounces-187384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E49FC8CD106
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832691F21F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8331474CD;
	Thu, 23 May 2024 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IponsUZf"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E31474AD
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462836; cv=none; b=kSoxsDBl3yg4G7l38qsjOnheQrtcWv/xfaes2cuMI4B7VQkM2AkOr6zU/1Ek0Hg1V8T/XxX4xhoXvmYkkOmO+hqS0WBgHhSx19ZWij6jk9YGJMb4o87Mn94mb7zMmE42uJnt+/c5wIGGxC3Skb1k0JJBYuuKzH19ZBOWo5ZIPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462836; c=relaxed/simple;
	bh=vniUVQGgbZH5XUSS0fWMGrRPi3jnpi6vMBuF5oFpj5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X3mLeva6jM3GxCY9o3r6fjRl7JdIixnAeIsk2bSfTLZClbCiiQZbDCd7bfpYx7RFTOYZDXoj/LySpyTKg2GMSzV5ODwFb9vaf2+/+6OaJDcLXLdp6TQ2elnXSUR/t8aSQ07ZQ1NpRDZHqrYgqnK7LDxS5J87Rw/PbZ6i3ACtDE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IponsUZf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f304533064so13856075ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1716462834; x=1717067634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKyIwcUjX1px2GE9S/CV6LaiV7WK04/0FO5MZQuO7/8=;
        b=IponsUZfWWnVFxsS8C9Y2srnxHBmJBe0FJ3Xcvg/Tqi4kX8Byp7/JgU5BHzyKL9FCc
         vDGjwKPLhk0qrZiAF7ZLzI7IgHs/Z7O9I24P5hb9DhviPdneK6TwVOKBDh+ebOKkSUWk
         6Z/yLKaW5iv1VjH9lCdH4uk7ZhGvPMNoCwb4YIbVFBejMYeSaGCEejxSCY+ox7xey49H
         GvoItSHrNenaq4RUsIfIJxW2Q36wE+CprS2IrmzHtUz3HUlPF8h1ibS0E1JA5j213RXZ
         avFhdGf35sMP0KDk8hw+zPm7eK1IbzVnx1VLNO/HJ1OraYAfnX6THpxT6frKW5IHEnXZ
         S6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716462834; x=1717067634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKyIwcUjX1px2GE9S/CV6LaiV7WK04/0FO5MZQuO7/8=;
        b=ovJiYmMV6Yq+57GrXWHPjUhzT4smUaRcrh/18VwqxVE3efw2XOAKxUFkANObre++CO
         9eJdkpUgYGHZuhA/WJgUwWBNnc4ra02blWyBn8AgsJgY1aCAC7AhP8saVX+ySqkbPCZf
         cBiej9BWf7eDO6QuTg8PUiFp4IWmZV5LNvImZK3ioUyS0Vrm428zGliDQsf1km9JzYl8
         z7B5lIQ3YWXEXVRv+AihRah4PMDdtdDF3Rz0AgBxsaDXOswGSzjTNEHyT+0CB9yavguU
         LZpge3M/WP4dowkFnrNoSBMuhsCdlhQSHfQKYI/j6/1N68OVuqRUMvjno9k+4jfBb/p7
         PjRA==
X-Forwarded-Encrypted: i=1; AJvYcCUYDmv68KARaQm+1q8rVyl8Wj+I45MovsfJSyZlAAS9PXAlgpsDsu9znpRPS92BF/4Z+3W/JguVXeHTkDFdevT1UQ4bOTqaOi9jOyd0
X-Gm-Message-State: AOJu0YxL8rIZkQoFoDJh41Ay50MdkevZrG4WPGP95GmmRmdP6a7X56Qg
	5gk3UGv9pqprsr/gssZnrhXum7IlnrNJ8C5RqE/M4d8QCFaKXixVUXWLzAOfStU=
X-Google-Smtp-Source: AGHT+IF28aGrHScmfXD9R1tHK/6jmVsl792vI89tw9o1F0p1t+mCK4U7dtx62wkc9E7Mq6lP3ETRug==
X-Received: by 2002:a17:903:1245:b0:1f2:fbe5:7d62 with SMTP id d9443c01a7336-1f339f602aemr23791545ad.33.1716462834501;
        Thu, 23 May 2024 04:13:54 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fb4ca0ebsm76399555ad.119.2024.05.23.04.13.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 May 2024 04:13:54 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	sunilvl@ventanamicro.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	bhelgaas@google.com,
	james.morse@arm.com,
	jeremy.linton@arm.com,
	Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com,
	sudeep.holla@arm.com,
	tiantao6@huawei.com
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH RESEND v5 3/3] RISC-V: Select ACPI PPTT drivers
Date: Thu, 23 May 2024 19:13:22 +0800
Message-Id: <20240523111322.19243-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240523111322.19243-1-cuiyunhui@bytedance.com>
References: <20240523111322.19243-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After adding ACPI support to populate_cache_leaves(), RISC-V can build
cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
configuration.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f961449ca077..a9ebecd72052 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,6 +14,7 @@ config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_PPTT if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
-- 
2.20.1


