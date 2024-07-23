Return-Path: <linux-kernel+bounces-259878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E90939E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1881C21FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AD714F9D6;
	Tue, 23 Jul 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFqt9Qfk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F114F132
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721729544; cv=none; b=f8rlbY99O/b4plsVyRxqRoVpiLR8E46fs7oxNSlW7tkdAQWLMfe54cDDlJwfDWexkwX5v4x+4s9TFk8dCtizZu2jK8YktwyWh96WJLpDrQyhKjM2WrmfQlgeeKeFAImk/dI3o7P5byASzGlNWGNWVf8rzK2SZDKCgYTxBIJn+NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721729544; c=relaxed/simple;
	bh=rTkj/gLNEoKH1Qi6UhwNBuSC4NJP/u445SQy5IWYwE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZZFzLAXxaRMYiihRQ6TCOXyrJikceKL+dm5ohGqGBY/pqeOYftm19L8zRglz5L5C7f7lpQEZeZdd6k56SRNWf7mPLPCbUlftEV7IDn+KHRIpHlxN0y97HQNem0FPn0grzEaZ8ILM1AR54Z9vmPtEmIA7D3eOmi++08kpTCtCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFqt9Qfk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721729541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QS7Q6moReX0ytgpoj7OMDTRK1GZLav9EGBrr2p1MFoI=;
	b=YFqt9QfkOA+mQRngYttFttLSkzy4/37LLV49DOi6V1kuXpy3zb5BQCgpU5wPZD0AIcEhe+
	TeqxybcovNwKTMOyPZhc031MD1Xap0g4kJxritqzVUR4ZJRdU/h3HQEDrfAIw7AI9QWLNb
	PxPJpVSUj7z8vGSUg/Zp8o33I8qp74w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-QKpLSU4tMK2pvkakO5eHTw-1; Tue, 23 Jul 2024 06:12:20 -0400
X-MC-Unique: QKpLSU4tMK2pvkakO5eHTw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79f0283223eso713733485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721729540; x=1722334340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS7Q6moReX0ytgpoj7OMDTRK1GZLav9EGBrr2p1MFoI=;
        b=A3RNu44aabtHlTZ1HxoHTLf20Fr1JKdH16GvVSWyhe+rL7+gmQocXjkCJw64Swp1Mg
         iMiVz1IRZVOCRWkFVSD0s2Y3yooOcBYkI1v9mYfRsjv1EIGV22TkknSDxz3jcpHASv8s
         7T41oNdyTxB8SFPhal1yOlmF5fkGc+XQ/6RSWlZPTpAw1pntSELNnbsChhWTf1xvJadl
         hhf+XKbyOHiz5cQSJqo6+FgcUM42hKMokBKwtjVlArbvp4J2QjByQvAeBR9X9S+nXNZD
         P2rUOhq13LOUN7Rjg9snx7R/DTZW7XUsdu0Dc+YRTTacIVv8AQUrx7FQ7YRC2+32fmxw
         0PrA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4RB7hqn9+u++UGR/SKfqyG5d+U5F92Twx7J733GlJrCBOWqiO2rWAWqeAfB7EsrJrDz1s1G9RhRzOo9IP3ohG5Qr1fLVr9P48fo9
X-Gm-Message-State: AOJu0YzKyorq+G2A/xeLia5xCQSUxhQOSCIDb4VeIEBrwvriF9M8FQqn
	H87bKmANJ5VZ+M05eOm/Yvik2+WN5PPeT6SvPO3UDm3Zkj3PtGEwe9AXDExMqFJVM0D/8pMMjkH
	Id5J+QEP5j0FDzFLZCTKTHCxKD9trokR9vTvKFQTZlNBGwyFplb9ELd/ucO4wUg==
X-Received: by 2002:a05:620a:244d:b0:79d:569a:699f with SMTP id af79cd13be357-7a1a654db8cmr1283855785a.39.1721729539872;
        Tue, 23 Jul 2024 03:12:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2wFZtBagU/E46pV0uxTwzvChsAR2Dj7XVxuoFQCCKIFbTAHgkyz2V/BD0RPFoS8SnlRhwYw==
X-Received: by 2002:a05:620a:244d:b0:79d:569a:699f with SMTP id af79cd13be357-7a1a654db8cmr1283853185a.39.1721729539500;
        Tue, 23 Jul 2024 03:12:19 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f45e50062e5f8c654844c9a.dip0.t-ipconnect.de. [2003:c9:3f45:e500:62e5:f8c6:5484:4c9a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1990063f2sm463780085a.64.2024.07.23.03.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 03:12:19 -0700 (PDT)
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
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 3/3] KVM: arm64: vgic: fix unexpected unlock sparse warnings
Date: Tue, 23 Jul 2024 12:12:04 +0200
Message-ID: <20240723101204.7356-4-sebott@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723101204.7356-1-sebott@redhat.com>
References: <20240723101204.7356-1-sebott@redhat.com>
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
index 03d356a12377..ba8f790431bd 100644
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


