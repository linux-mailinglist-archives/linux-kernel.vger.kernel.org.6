Return-Path: <linux-kernel+bounces-178390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4BC8C4CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6071C213E3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FEE225D0;
	Tue, 14 May 2024 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZis6710"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F742230C
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671493; cv=none; b=cySTKO2+T+KNkFT0jLoEJCgw5lL/3HED2VLJ0gCKvUL4XBZ1xxXVjBx0RbO7F6Z5vClFxAcHN4/uG/pYRl/Sn01tlrgmaBbTqUgN8Tj3NkoCKpKrh0VnJX6V3whkP7eiam39XG5Clg9ucd58PzRXRF9ldet1a0pHedn+zWpsf/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671493; c=relaxed/simple;
	bh=GKU8aDad++UHg7ULCq5a+WASZrV1XSR5fQTRpdyDPAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF3G36yS5r8c0ZNINJJ98lorR3TV++5iIVUsqcWmdG6bg33LJnoRWurgyTle9l7u0o3gPDsnSwLX2rqT60xvRDsk+nBs8DNYZE0vvz2kfReopZ7q3MtZ2XvBEw7p0YjCEFMqiyWS4EZpMvO2U1+UXdnhr8RBCihhIGGu7WVeC6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZis6710; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715671491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ir9ch9TLrkkINczF+u09rhfqVntFlPUGfW92ABaqtP4=;
	b=EZis6710d7TwB/U+iI/xTIyVzSBfB6ekYsEJtMQcVNNitFREeRr5G1S1gzmcMyCmsYy4gj
	n73ZLJSNwltLMX8MApGm6pw3BCNikT7gBz37Y14RNslbtWyusLMy2QqUJYPF+eyncTPi0e
	/qbPyFKw+OLq4txZ0in2PEU21bn1c6I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-svXIcDRKNtyf-ftbWYgYUg-1; Tue, 14 May 2024 03:23:08 -0400
X-MC-Unique: svXIcDRKNtyf-ftbWYgYUg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-792c365cb16so603582685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715671388; x=1716276188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ir9ch9TLrkkINczF+u09rhfqVntFlPUGfW92ABaqtP4=;
        b=Wek9PnpBDcnrKpRrXlEX9cJqUxANFGS921BqGh6hdzwwfsl2SsehxZcV6/Af3nHV0D
         n1KWYcXwbc7SlGHr3q/qZX7YrrxV+gLJDvj6yI1SvR4ATlHfvCAxvfzdKDaHmJGr29HR
         +qBJGuwQ2XDoYFh9AkiLjEVNsvhPoqKE67SQakynesL3sDCpjUQAXwq75IsdcSrVCOla
         JsQvsdr9ohhrzGHa2O7PZzbL7knmWM0RGlBKy8K6S9ROO0Rb12sOeB8nuX/X2Al/1aSd
         potAuPZN20C4cERfoOAXwbV+Qj2HSwPtKRB3+abdRMMPxCDI1DDhSPyiVVUPylWFA/dg
         n5sA==
X-Forwarded-Encrypted: i=1; AJvYcCW3QpCX2Wv5vQla5an4h7JIThqdTUdXcOAscMG2D4esQx0b7WFuAiqsl9EzNkCIO1CABdRaYmuP55lc1sXtlgkEUfYsvh8Sata2QfLo
X-Gm-Message-State: AOJu0Yw315mzXGUQChfr3U6qWz1XUUnxUw1FuZRU8FQwSZ9cxL+wlqsi
	w+hWrkbPEVse291OsscOytcsnZZ00Y6SDCbIqSAIrFSle71nWF6/l9zJHrXrNqnYYJYWomQuMZE
	ETirlcsjvXYEJkWpu3/oUkjEChQAZ3H6jb9h9drESmq8aSWZNOP8oYiUCIYG6LA==
X-Received: by 2002:a05:6214:4309:b0:6a0:d21b:c914 with SMTP id 6a1803df08f44-6a168217e82mr153404496d6.51.1715671387989;
        Tue, 14 May 2024 00:23:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIbQ2Xnzp0GccgqjWLFujOwJhCg38lH8DFppsuBR5FMZevyxek/6u2nIsapmQtCwGG2EXSrA==
X-Received: by 2002:a05:6214:4309:b0:6a0:d21b:c914 with SMTP id 6a1803df08f44-6a168217e82mr153404396d6.51.1715671387689;
        Tue, 14 May 2024 00:23:07 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1ccd4esm50917516d6.97.2024.05.14.00.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 00:23:07 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 5/6] KVM: arm64: rename functions for invariant sys regs
Date: Tue, 14 May 2024 09:22:51 +0200
Message-ID: <20240514072252.5657-6-sebott@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514072252.5657-1-sebott@redhat.com>
References: <20240514072252.5657-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invariant system id registers are populated with host values
at initialization time using their .reset function cb.

These are currently called get_* which is usually used by
the functions implementing the .get_user callback.

Change their function names to reset_* to reflect what they
are used for.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 1b6ab483e21e..bae72a4ce72b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3795,8 +3795,8 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
  */
 
 #define FUNCTION_INVARIANT(reg)						\
-	static u64 get_##reg(struct kvm_vcpu *v,			\
-			      const struct sys_reg_desc *r)		\
+	static u64 reset_##reg(struct kvm_vcpu *v,			\
+			       const struct sys_reg_desc *r)		\
 	{								\
 		((struct sys_reg_desc *)r)->val = read_sysreg(reg);	\
 		return ((struct sys_reg_desc *)r)->val;			\
@@ -3808,9 +3808,9 @@ FUNCTION_INVARIANT(aidr_el1)
 
 /* ->val is filled in by kvm_sys_reg_table_init() */
 static struct sys_reg_desc invariant_sys_regs[] __ro_after_init = {
-	{ SYS_DESC(SYS_MIDR_EL1), NULL, get_midr_el1 },
-	{ SYS_DESC(SYS_REVIDR_EL1), NULL, get_revidr_el1 },
-	{ SYS_DESC(SYS_AIDR_EL1), NULL, get_aidr_el1 },
+	{ SYS_DESC(SYS_MIDR_EL1), NULL, reset_midr_el1 },
+	{ SYS_DESC(SYS_REVIDR_EL1), NULL, reset_revidr_el1 },
+	{ SYS_DESC(SYS_AIDR_EL1), NULL, reset_aidr_el1 },
 };
 
 static int get_invariant_sys_reg(u64 id, u64 __user *uaddr)
-- 
2.42.0


