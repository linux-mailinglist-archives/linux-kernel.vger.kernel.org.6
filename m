Return-Path: <linux-kernel+bounces-447029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3922A9F2C40
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B955A188368A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E41F200127;
	Mon, 16 Dec 2024 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="czk9nM6j"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38FC20103B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338938; cv=none; b=PMF4xzmqfmC5G2WX4iUwfXnynNdw39ZSNJWMFXEsy7r9S9u25GzSkQhjOUgOsYMrF3W0sV0iuv2Gxr8wJFEsl4Lx7XE2UL5kxx8J1EMeu9tu8zgR0yJXdJDbER8iM8BW6QsAfFEavRIIh5buXn2G4laQGvYhMkqTn1vvPZJCFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338938; c=relaxed/simple;
	bh=43icYDitKGAJFCQcQUQh+xigsEvTJRoq6tVP0e8YBXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBC4dPMVNUOPxZ7TpLTamWIZ59DhfnR+zPmnxUwqokDd+fcx+tDYFxZkmBBFuQWUoYV4zLAbLs6Tj2WnxuDF1t1Zk5QE4675gBEsuIhgCrtYe6IINNYMmSbDBjUVpowcvXX27yqILrcWq/+Hk4Ya4gtaYtSLwto279dsf5trFAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=czk9nM6j; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21634338cfdso44901615ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734338936; x=1734943736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTubMU2kWF4VQtI7+afjrAi0Qg8VFM9pvYCuyyQx/90=;
        b=czk9nM6jwQ7mbHLJcOt306xGlayywp+cwTu66eAkox2nv2tMeVaEFEaKt6UdzZVxN7
         zEl2heWSX/GsoA6HLLKihPPqOWDNmbG9c9b+NC8B8dPkt2EfFwI8NbpGTTK9qSA3S24I
         g4aEl9Pci3ko13gwdZY7fhFks1SZ5AV2UKKoKfRwQmfKObreF4hH0pSg4TTa1okHdNQW
         ngbDDz+xqQ5lq8I4IuKHQnN9mXe+0vx5bBQpG03M+19kHf2D7xJJ6mffIPIYFzq1BpqR
         ns/C0/wzt9x2nXLfu1j6vmOn8MGwTbEfWbpig3WaTDTNAqx5TUfez10qUL9+22oloXko
         pCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734338936; x=1734943736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTubMU2kWF4VQtI7+afjrAi0Qg8VFM9pvYCuyyQx/90=;
        b=WT+Va+1S6Trlu88MyLJckvvnTS5WkVUTmhL6ZbDN5PZYd9c2rWmdr0H+HRkOq5c2Uo
         LKXx3URcNVpzyK6kLfHis5sBfRNYIpswnVGeSOv6I4GQLoRm4IWqIo2dAagd6EUrjgQP
         0x7qA/23wTRqeyeEqvCrByTNR2amNNHF/+0Cji+8bM3WbLQDB9zY3xioX7W56wfN4t/w
         NVbqWzzGh3iqCXihtWKKhxuMBFpzTt0RNuUNpbya5SOxfDt7Np7D/KZv+qHFWhmkcyci
         eR8oLQVa03RBxgC9HPp7XVeRCP2IKkPtpPePstEhP5PNjArxZkRtFACCuAhpC11q9UNg
         T52Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtyK99iMFsOt4HPcGMqwXgxffLpLmzC+fW+1bwJIwiBB8fyN3LKv3zq015GGxha9urYtje1HJ0eXPkcgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlcYl1SECq6h0ZzE9aG1h+xW0789ws+wQYXoiDUmAA98ULBweB
	NzwqfupOhbib9zqKe+OpskCL4+jBieuzXozPS0ywEsa3vPaIKLMwxFLTTEjezEs=
X-Gm-Gg: ASbGncuzDPxGwoqswWh9edQS1whsy2v5LYG3KSPwqrcYAZjOmkaBstl2U4PtyiBH6aO
	72eo6G8zQjwErfoNbEWMtsuM05sgd5FIWs5iURG5I/BelbJ31d9qxmg0hEYesJVczlb/o1bk+pu
	0vXpq6JsjvH/52eN3GuvYm+RZUtQBL9MyJA8wm+7g77L0JHqeJO45f63Z2u0GvuhnX37JGwHiX3
	vxZDdn1QPlbYtZfPRvDqKk9CZrCJwBgTU0n9l2uUY3dOJDZIzbangpCCPlMzxW62NJ3h0UcPctk
	J34739+KUl+ZYnI=
X-Google-Smtp-Source: AGHT+IHpuJTFzeEhjSiGdehFNiKlPC/zQ57iedGa+8ilj9RzYBUBHeCW2l8Z59j6jtt7ugE/4lqbMg==
X-Received: by 2002:a17:902:ec90:b0:215:75a5:f72b with SMTP id d9443c01a7336-21892aed1eemr161821665ad.53.1734338936193;
        Mon, 16 Dec 2024 00:48:56 -0800 (PST)
Received: from localhost.localdomain ([223.185.130.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e501d0sm37711495ad.116.2024.12.16.00.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:48:55 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [RFC PATCH 4/8] RISC-V: Add defines for the SBI message proxy extension
Date: Mon, 16 Dec 2024 14:18:13 +0530
Message-ID: <20241216084817.373131-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216084817.373131-1-apatel@ventanamicro.com>
References: <20241216084817.373131-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add defines for the new SBI message proxy extension which is part
of the SBI v3.0 specification.

Co-developed-by: Rahul Pathak <rpathak@ventanamicro.com>
Signed-off-by: Rahul Pathak <rpathak@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index bc35ad750e28..18817efba430 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -35,6 +35,7 @@ enum sbi_ext_id {
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
+	SBI_EXT_MPXY = 0x4D505859,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -401,6 +402,64 @@ enum sbi_ext_nacl_feature {
 #define SBI_NACL_SHMEM_SRET_X(__i)		((__riscv_xlen / 8) * (__i))
 #define SBI_NACL_SHMEM_SRET_X_LAST		31
 
+enum sbi_ext_mpxy_fid {
+	SBI_EXT_MPXY_SET_SHMEM,
+	SBI_EXT_MPXY_GET_CHANNEL_IDS,
+	SBI_EXT_MPXY_READ_ATTRS,
+	SBI_EXT_MPXY_WRITE_ATTRS,
+	SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
+	SBI_EXT_MPXY_SEND_MSG_NO_RESP,
+	SBI_EXT_MPXY_GET_NOTIFICATION_EVENTS,
+};
+
+enum sbi_mpxy_attribute_id {
+	/* Standard channel attributes managed by MPXY framework */
+	SBI_MPXY_ATTR_MSG_PROT_ID		= 0x00000000,
+	SBI_MPXY_ATTR_MSG_PROT_VER		= 0x00000001,
+	SBI_MPXY_ATTR_MSG_MAX_LEN		= 0x00000002,
+	SBI_MPXY_ATTR_MSG_SEND_TIMEOUT		= 0x00000003,
+	SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT	= 0x00000004,
+	SBI_MPXY_ATTR_CHANNEL_CAPABILITY	= 0x00000005,
+	SBI_MPXY_ATTR_SSE_EVENT_ID		= 0x00000006,
+	SBI_MPXY_ATTR_MSI_CONTROL		= 0x00000007,
+	SBI_MPXY_ATTR_MSI_ADDR_LO		= 0x00000008,
+	SBI_MPXY_ATTR_MSI_ADDR_HI		= 0x00000009,
+	SBI_MPXY_ATTR_MSI_DATA			= 0x0000000A,
+	SBI_MPXY_ATTR_EVENTS_STATE_CONTROL	= 0x0000000B,
+	SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
+	/*
+	 * Message protocol specific attributes, managed by
+	 * the message protocol specification.
+	 */
+	SBI_MPXY_ATTR_MSGPROTO_ATTR_START	= 0x80000000,
+	SBI_MPXY_ATTR_MSGPROTO_ATTR_END		= 0xffffffff
+};
+
+/* Possible values of MSG_PROT_ID attribute */
+enum sbi_mpxy_msgproto_id {
+	SBI_MPXY_MSGPROTO_RPMI_ID = 0x0,
+};
+
+/** RPMI message protocol specific MPXY attributes */
+enum sbi_mpxy_rpmi_attribute_id {
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID = SBI_MPXY_ATTR_MSGPROTO_ATTR_START,
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
+	SBI_MPXY_RPMI_ATTR_MAX_ID,
+};
+
+/* Encoding of MSG_PROT_VER attribute */
+#define SBI_MPXY_MSG_PROT_VER_MAJOR(__ver)	(((__ver) >> 16) & 0xffff)
+#define SBI_MPXY_MSG_PROT_VER_MINOR(__ver)	((__ver) & 0xffff)
+#define SBI_MPXY_MSG_PROT_MKVER(__maj, __min)	(((__maj) << 16) | (__min))
+
+/* Capabilities available through CHANNEL_CAPABILITY attribute */
+#define SBI_MPXY_CHAN_CAP_MSI			BIT(0)
+#define SBI_MPXY_CHAN_CAP_SSE			BIT(1)
+#define SBI_MPXY_CHAN_CAP_EVENTS_STATE		BIT(2)
+#define SBI_MPXY_CHAN_CAP_SEND_WITH_RESP	BIT(3)
+#define SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP	BIT(4)
+#define SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS	BIT(5)
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
-- 
2.43.0


