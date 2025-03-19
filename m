Return-Path: <linux-kernel+bounces-567916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7713A68BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7381888921
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00B22561B0;
	Wed, 19 Mar 2025 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="HL+eylqX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B4255E40
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384351; cv=none; b=FIWFdWz1p/kg1cdRgAuk8/fJdC3K3ut8ePOhd3ypEmR3jyzjNYjWAUsPSesyHOLMOnY8baZqSutITFSj41jqcRrhj6z3NZHH7FVYmLTiFy+aJ2FtBv+IhJGEqCgPuUPwpozv04kyLmPcshQ6Hop2TahxDfX59E3CZ9aUwZAkAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384351; c=relaxed/simple;
	bh=wSsvSlNkNr2nAKIQx6vbdaSycDEUcJGLMq0k1Pp9xg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uB2c9GQn3HFsICnSck0Jo6QnhZNNWP1tZmDmU12oTLQb116nV7xKYKlj3lOy7Y91VlscWaX0AAdF0Go/LE9gQ0mHTnhVnpSydRS0FtgtnXA0qTBwmteKRr31pyQ1igsJE0l0c7nXUFnnYmLZuM/O/uivb0PmrethJGr8kzat7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=HL+eylqX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225477548e1so117982415ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742384349; x=1742989149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJsAUn2tJ/N0GZBEAi0IEG/qBVORqD8jC/NmJGn5En4=;
        b=HL+eylqXX7DQgtbL+gzbqQ5nNgu+gfxX9388OsxUiPBZJedp4uEZrlEZwxuo9MlULW
         AlusvmNBWhrK2E8ZB8NMxswRQxiqB30tVKs4cJqIO3Mdp6AJd2ziSTUpqqh0KWD/NNlb
         veYCU6O77UbF8P35ypeU7g02eQikjlpLcMD6xYwgS27YUAHfE4o6xtMp+EKlzFCOz/sJ
         Yo7c5Bk32dLf2oBduXaPOFGSW2KIeYIyMx4bK/vLwkc31FeWcVoVGCPGHFFi9HN5LYhX
         3uSd5gMk/vvLp4Z9oQDeWnn5hdzAXzs5uJch5e8Tso8QBKIlVvBRNK1GevpEEjhNNC+F
         e5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384349; x=1742989149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJsAUn2tJ/N0GZBEAi0IEG/qBVORqD8jC/NmJGn5En4=;
        b=YYrcLiMNEUffi8WEBKPAynKvrp8vS0bqr9VMfQ3v2ABsdgwwynCEd0uliOam5uTeX7
         RvVQpzO8Gu6xuoHXQRQ2m0qfnbbqFGNJGAgHwoE8hwQB/vh/WpP3lSNTG8AjwdebHVSM
         7C2z106IVH1pe4IMTbUoEtVh2IAzHNjXA2JaXYSvOv6LUsk/V065EWDJolRqGOChGbmq
         vhHi8M17z+wlZkxnHO4ZL72fmOw/Rs14dmrmLfDr1OL3TI4UJHg9n/JZkFL4BM1nsIP/
         CPLMOYwyxcYTFN1fqe0pFlwC8/1G7oXK7twv46RYzXzeYZZd4kZkbEsjc46BdduQC3i9
         UahA==
X-Forwarded-Encrypted: i=1; AJvYcCU59vWunoUHGib814esq3d69zvbWCEtzokJUoFLX1J+iczjxyQPukprMJmL7fXLIBsOijO/Bgjg/KLTeP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0W+vYsW7KJLYFlzSSca05/fYkiG37Ifr2x69+wyhWgLyRl2WQ
	jPN+wYu2kGemX3I+/S3xBeHeP06pyR3F6pqYT352Sax5nP/IPVHwDmLptiR4dyg=
X-Gm-Gg: ASbGnctzllnvyR9ZhBbTNVQYRnl8JG9HtGsDLSUdF1IZxJvfE6GLyePSFKP1xNeQL6V
	FDGkpAlOq4ckplD90XePK3au9UtHZVU4mh64PCbQZJBqhvEVEVwqMTdMwhB73mmYx/+ATKrrY3m
	YyWhk2ve9NveLdpn04VIoydyiDcj8+sMimmL2fGJSI0y1g3zdbUJnyxHH+X8YnCd67rXQ7csJMc
	uTzXmSWwWPEHrpfnSBGDux6qqj3EClaljhArvKDhQDQxoLw2jFOtvcUaCVe5qIth1uPsQlP6CfI
	DehTyRPhq0jxBRIi7a1+wE7gwRH5kd0vG4iPSTbgQ4RqHLks
X-Google-Smtp-Source: AGHT+IGfWVdcLoiaUgIHbjMMUMvA2v0l8u40e6hMqGpDW/wkNrA/pWWYq1nd4axTz9YOadVt/J2Xdg==
X-Received: by 2002:a17:903:32c3:b0:211:e812:3948 with SMTP id d9443c01a7336-22649580acdmr35244335ad.0.1742384349386;
        Wed, 19 Mar 2025 04:39:09 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c68887fcsm111347295ad.39.2025.03.19.04.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 04:39:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 19 Mar 2025 20:38:56 +0900
Subject: [PATCH 2/2] KVM: arm64: Trace SMC in a way similar to HVC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-trace-v1-2-0fff03204efa@daynix.com>
References: <20250319-trace-v1-0-0fff03204efa@daynix.com>
In-Reply-To: <20250319-trace-v1-0-0fff03204efa@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

KVM handles SMCCC calls from virtual EL2 that use the SMC instruction
since commit bd36b1a9eb5a ("KVM: arm64: nv: Handle SMCs taken from
virtual EL2"). Copy the tracepoint for HVC to the SMC handler to trace
SMCCC calls whether they come from either HVC or SMC.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/handle_exit.c       |  3 +++
 arch/arm64/kvm/trace_handle_exit.h | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 512d152233ff..087880b645be 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -55,6 +55,9 @@ static int handle_hvc(struct kvm_vcpu *vcpu)
 
 static int handle_smc(struct kvm_vcpu *vcpu)
 {
+	trace_kvm_smc_arm64(*vcpu_pc(vcpu), vcpu_get_reg(vcpu, 0),
+			    kvm_vcpu_hvc_get_imm(vcpu));
+
 	/*
 	 * Forward this trapped smc instruction to the virtual EL2 if
 	 * the guest has asked for it.
diff --git a/arch/arm64/kvm/trace_handle_exit.h b/arch/arm64/kvm/trace_handle_exit.h
index b0308d95304d..a3a0e0a46c60 100644
--- a/arch/arm64/kvm/trace_handle_exit.h
+++ b/arch/arm64/kvm/trace_handle_exit.h
@@ -46,6 +46,26 @@ TRACE_EVENT(kvm_hvc_arm64,
 		  __entry->vcpu_pc, __entry->r0, __entry->imm)
 );
 
+TRACE_EVENT(kvm_smc_arm64,
+	TP_PROTO(unsigned long vcpu_pc, unsigned long r0, unsigned long imm),
+	TP_ARGS(vcpu_pc, r0, imm),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, vcpu_pc)
+		__field(unsigned long, r0)
+		__field(unsigned long, imm)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc = vcpu_pc;
+		__entry->r0 = r0;
+		__entry->imm = imm;
+	),
+
+	TP_printk("SMC at 0x%016lx (r0: 0x%016lx, imm: 0x%lx)",
+		  __entry->vcpu_pc, __entry->r0, __entry->imm)
+);
+
 /*
  * The dreg32 name is a leftover from a distant past. This will really
  * output a 64bit value...

-- 
2.48.1


