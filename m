Return-Path: <linux-kernel+bounces-250576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6E692F942
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC23284320
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5569316C867;
	Fri, 12 Jul 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPGS5q8r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327A16B751
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782233; cv=none; b=mgGh3nxn9viRbK7T6PJdPX84m/PWRqPwgVZcXfKfLaKzV+qEA2g1o0cNFik6P2cCPJHjfp4ZEyIXdRQXfFYPlCM7tuI4I2pOCzvr7+uh/E/Fi4jy0gLACaJ/KWIzBDj93iWbHNlORifpP+pmpch6emrg0UPNtHr7zK6IEtGNkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782233; c=relaxed/simple;
	bh=PzMJUqkQiNB6ha824+KU67DXfXi9Wu+ZYqT0X9x+bOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdMMCguuyMdhJv+R96Kob11JqlhTwISSS9a6eUscYYNnP0e+swgKRBbDmI1c4ZdSoOpeECzRDIkF9YkEjj7dxTwHlDk1hm8xWtMxrNOdc4RU5VBpavztyZp62VF0sV+4nmpiI+ESikBbzlFB9IGLm1z1MQi4pI+ZfZAurvTSnr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPGS5q8r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720782231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsvQ75fAXsh3PNmutFTZ+oUFOtcjE1xAsn2yQswaCk8=;
	b=ZPGS5q8rPig0LzqVp2WerVnME3BkgVPJ7aaP5SkcVT6EDcls4Z9SUT1tDrthgKRgFD6OQj
	E+vp0Cz/r3DBlxygnTXF8vPjLr9+MCF2+NkoL6vo2FHiu2PeN8wZYzBM4MO4wzEORJEoMx
	CMRABnYdy89QHR7xBGcIt+X0LupOwDI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-SSysnA-vOAWCuf4CpofEUQ-1; Fri, 12 Jul 2024 07:03:49 -0400
X-MC-Unique: SSysnA-vOAWCuf4CpofEUQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-79f0283223eso244768685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720782228; x=1721387028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsvQ75fAXsh3PNmutFTZ+oUFOtcjE1xAsn2yQswaCk8=;
        b=SFzew00LAgFfx7C3JpzfKtjgyaNRy2x8HreunuVbqgdCYy5mclxpUXvXsdnI3tF++0
         DOakGsGHyYTBL3nhwF/Yn4qWhzIDYl4bzBQH+vI6UtmQJ3eagyfCApQRaXPZxAALpiOA
         n2135g0LtZfV96weVA49hCFNdSOw92b2OlIsGlCKO554aTFw2NLaAKQ1o43oSunQ7NwL
         CCZPkFmSolgdivDoG2Q1DRMz587TWF4b1C/C7LWxqlCxSIZdP3cLzKYpyy1f+T2fXknn
         zTmJ6UuGzR2KwFWYW5B9Jk2JEByrk9r7PZiizBQj2oBelOsjxnXawMB3ftCnXi9z39lh
         4s3g==
X-Forwarded-Encrypted: i=1; AJvYcCUX9XdRwL3rm1QUWPWXrXesc7Vw30+FVyR9WG2d/zcIkoRNDkdJ8AkN+c4aedH/osz69qsEWr6tT74irlhdD+xCZY80xGJPojpflLDg
X-Gm-Message-State: AOJu0YyXbluuhHUE8blvNLCc2iw2YsHzZcNNJZ79Aom1eDXKaOIZxIih
	35Hv6corFzjVvRxmkk5H3Sww0LUnNi0HkFyUbCRsb0ckuKqLz9AQXlJ0UBoEBt7XlLWaW6Y7G6x
	RHcWgXWugXWoF6B856dnYx1xXpm6XiBNpWD5iNp8LzNFCcaE+i7V6F5RWwayHPe3/fB/WjQ==
X-Received: by 2002:a05:620a:2186:b0:79c:119e:2b44 with SMTP id af79cd13be357-79f19a51d7fmr1225833985a.3.1720782228655;
        Fri, 12 Jul 2024 04:03:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/x1W3ipOkWAMomp0zXTQ02Ix+7KNx4A712Y6gcZalpd9XUggvSO3hVJNYViAZWFdOQfl+eg==
X-Received: by 2002:a05:620a:2186:b0:79c:119e:2b44 with SMTP id af79cd13be357-79f19a51d7fmr1225831585a.3.1720782228362;
        Fri, 12 Jul 2024 04:03:48 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f45e50062e5f8c654844c9a.dip0.t-ipconnect.de. [2003:c9:3f45:e500:62e5:f8c6:5484:4c9a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff834csm390498685a.5.2024.07.12.04.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 04:03:48 -0700 (PDT)
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
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 3/3] KVM: arm64: vgic: fix unexpected unlock sparse warnings
Date: Fri, 12 Jul 2024 13:03:32 +0200
Message-ID: <20240712110332.10970-4-sebott@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712110332.10970-1-sebott@redhat.com>
References: <20240712110332.10970-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of unexpected unlock sparse warnings in vgic code
by adding an annotation to vgic_queue_irq_unlock().

arch/arm64/kvm/vgic/vgic.c:334:17: warning: context imbalance in 'vgic_queue_irq_unlock' - unexpected unlock
arch/arm64/kvm/vgic/vgic.c:419:5: warning: context imbalance in 'kvm_vgic_inject_irq' - different lock contexts for basic block

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/kvm/vgic/vgic.c | 2 +-
 arch/arm64/kvm/vgic/vgic.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
index f07b3ddff7d4..974849ea7101 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -313,7 +313,7 @@ static bool vgic_validate_injection(struct vgic_irq *irq, bool level, void *owne
  * with all locks dropped.
  */
 bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
-			   unsigned long flags)
+			   unsigned long flags) __releases(&irq->irq_lock)
 {
 	struct kvm_vcpu *vcpu;
 
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 6106ebd5ba42..480b5c7e2031 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -186,7 +186,7 @@ bool vgic_get_phys_line_level(struct vgic_irq *irq);
 void vgic_irq_set_phys_pending(struct vgic_irq *irq, bool pending);
 void vgic_irq_set_phys_active(struct vgic_irq *irq, bool active);
 bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
-			   unsigned long flags);
+			   unsigned long flags) __releases(&irq->irq_lock);
 void vgic_kick_vcpus(struct kvm *kvm);
 void vgic_irq_handle_resampling(struct vgic_irq *irq,
 				bool lr_deactivated, bool lr_pending);
-- 
2.42.0


