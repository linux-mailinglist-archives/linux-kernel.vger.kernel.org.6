Return-Path: <linux-kernel+bounces-199178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCBA8D8373
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9BE286057
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E3712E1FE;
	Mon,  3 Jun 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yg3efjl8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4140712C491
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419933; cv=none; b=drD4pmOIjtZjR8J7ebRGi2l+mWQKwM9T6sNAp6Oco41K5iErMGMZiorF3+eughdyn1VmCRCBdj5l9rAMJFiCK/qXIU6x6jKylhiCxSf3z+A0hJ1O/bcQu8Ue4lQOpGfSdy5MC1UiVlyzTfvgdjGrcR0lR7npmmBBS0/JzAOtL3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419933; c=relaxed/simple;
	bh=71m52FJi8Um7FJFoETG+FaMXe3M/vfBj7cNFVRSvdGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7kHskSLYO5Bp8xP2J3s+CYAvh1AywlpIsnAF752Rud8Efa4ftaRNeTyLjnimlGTBXp6D5kLmtpTxYw1b88y07n5vvQK+St/5Gc5uFxgXcHkkIHugOhEFNlBGir1X6olJks8n67ygtKR8BsKgZmOpnnb96iYQr5o7AQCa6aVyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yg3efjl8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717419931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hDp3mJM+KL3UzD0Xul7NRSgkymM8l/Ae4m4/fkqIqo=;
	b=Yg3efjl85g1Qp5zzEfL834tXrpUlox4SznO8JEiEdmx/KCJzcg2DCe+H4HI8GqZf+bcqU6
	xn9G1Qtqa+62OTQINpAJ6ZWlXnAOmOI1S4yFABPbBvPDSgyPyF94w75JIuFTqd6qZ+7kjc
	5N7ZigHqbCRDNAp9KFBzRNwo7DhZkwA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-HcoRjgNdMAqHB-X06LZWYg-1; Mon, 03 Jun 2024 09:05:30 -0400
X-MC-Unique: HcoRjgNdMAqHB-X06LZWYg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6af22efee18so35966776d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419930; x=1718024730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hDp3mJM+KL3UzD0Xul7NRSgkymM8l/Ae4m4/fkqIqo=;
        b=iTPr6Ns/HNSpveKL/DS3rbagvBdg3WhiN5meVmhdNiVUeoJG/M4D0lVb/mxY8LYfRb
         EA6JGdb/iWq+fzijfuOUvf8bJx2FYzAYUHRGlgIu7WOmo0QXGbFq+QpjtcbIL0dBGai9
         qhMOSQv/cI9avQVebCURtlh3HpLBp8vnXsXz3BTCydBUG6/v+wtjdNi9n7kyn5Ly5hAS
         DkngGZyrIy+hZFE84x0/D/4XqGKv1Lii4zallMn9wdnqkln0h2SE8N7ETimoevQbgDwd
         HaGyukMTlaVgOkMsFNBe3FcvcJZxpsmu+8OAOkZbdxWbRi2taNNlvL+eJzz/u+G5RYX8
         UJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/5KaO+2dxPGB9va3pDKK9aDzVal4NJ2nEsz+i9bx6qfxNOLDGF1XLX7rmm9m0uwrFLsBuz1dlTlnt50NefzVNer0ZQGytbXCgynlh
X-Gm-Message-State: AOJu0YwL+LgsXNUOz+S4KggxzGzC9FDNCVexmsYRm6mMieu91oOa4p0v
	SG3nkUINf1Cm60o4xDEjrfhJW5n9PUInbKuh6jScPh0p5NqtvR3luvOr7VRU9WC9ivA/ypiAOzo
	k4VNK3uHycs3FiI7rgp1KCheG/QdYhNLkVvCDTT4OcE06z/sCJvrcqorkPNLfoQ==
X-Received: by 2002:a05:6214:53c2:b0:6ae:ba6:2136 with SMTP id 6a1803df08f44-6aecd69c655mr116485986d6.36.1717419928916;
        Mon, 03 Jun 2024 06:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIqrN3yZy5lXpQG4/otUItFzer4jmPLCycJ2Rj//HPLUZeLLc+f0g23vFqngAb9IsidJe/Vg==
X-Received: by 2002:a05:6214:53c2:b0:6ae:ba6:2136 with SMTP id 6a1803df08f44-6aecd69c655mr116485636d6.36.1717419928535;
        Mon, 03 Jun 2024 06:05:28 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f02d1004c157eb0f018dd01.dip0.t-ipconnect.de. [2003:c9:3f02:d100:4c15:7eb0:f018:dd01])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b4179f4sm30558826d6.113.2024.06.03.06.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:05:28 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shaoqin Huang <shahuang@redhat.com>,
	Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v4 5/6] KVM: arm64: rename functions for invariant sys regs
Date: Mon,  3 Jun 2024 15:05:06 +0200
Message-ID: <20240603130507.17597-6-sebott@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603130507.17597-1-sebott@redhat.com>
References: <20240603130507.17597-1-sebott@redhat.com>
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 8008120d021b..12ce8461323a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3799,8 +3799,8 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
  */
 
 #define FUNCTION_INVARIANT(reg)						\
-	static u64 get_##reg(struct kvm_vcpu *v,			\
-			      const struct sys_reg_desc *r)		\
+	static u64 reset_##reg(struct kvm_vcpu *v,			\
+			       const struct sys_reg_desc *r)		\
 	{								\
 		((struct sys_reg_desc *)r)->val = read_sysreg(reg);	\
 		return ((struct sys_reg_desc *)r)->val;			\
@@ -3812,9 +3812,9 @@ FUNCTION_INVARIANT(aidr_el1)
 
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


