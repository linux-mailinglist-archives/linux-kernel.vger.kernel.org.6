Return-Path: <linux-kernel+bounces-178374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC238C4CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6141C20CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3290317996;
	Tue, 14 May 2024 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsG0saWk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EAA15E81
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671395; cv=none; b=gPeFShFbY14BSLc742ZeNTCf0Nbo7ob4+Po0a6faX0W/QjaL7GwXuDSEK8mGN+qmTa7OHSTlXhG/JFOr3/olX8losZfalP2jLo3rGRmTNz2S+Bd8fuMbkarYudkVkKXPzMUrALRh/VfC2BCuEtVmaAVeD3gHfO1hkolAo3J5p9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671395; c=relaxed/simple;
	bh=t7E4Xq+CwDIyBlgpDlmVyy3gj5a/gnFSGaWMtzUgsUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFcHaSOThtAe1CFz+n+D6jgBxh0aM/bH1mbh075SZxU0sEJ+iAhTFzsCcvIqP2YBpXF1HJzWa1snkjOkih6jzp2tFAzgExaPcDoENeYgTk3DSZtlrM1NO5DiJFoOUsh3VH3iaJxLD5+RKx7KgTQmUvK8Fobiuv0bSY77NvR2hwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RsG0saWk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715671393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=edf79jeIcR6SIIHgF1L+nP6ohGfiMC191SZcpJswp0Q=;
	b=RsG0saWk7RiqOrzG/o3OYywJ6M+BhRbKRm5HLs4PLD0dBjd6oO2MIHcziPspulEc0F1fYi
	jiccuQEeLE7LRFV7lCNeiozpIhDTWHCVThKsM8KF90H8acDBXary00AbpSMBtz59TZaqhi
	LUpGJq/PBV2c4WrDxT051E0mMCo0Oig=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-Mh4UboGvORaMFkv6M4Hrhw-1; Tue, 14 May 2024 03:23:06 -0400
X-MC-Unique: Mh4UboGvORaMFkv6M4Hrhw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6a0eca15156so59793436d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715671386; x=1716276186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edf79jeIcR6SIIHgF1L+nP6ohGfiMC191SZcpJswp0Q=;
        b=VkVBx/kfOSrpWLsSrzLWNUOpUpFsDuPE3zNS1D8YIhPAfddjdHWjTuqoOsqdHCK4rM
         sp6hUpnDwF4FpKAzjkIzBev/kpKwy3BCUSQYhbUpxlc7v3txBZPxXp7U3nGfF8pNeeBG
         CfvQsj5bymwtKbBl1QdV/gmaK5GSogPMhnI/lyRGMp6H+g2KlqSaHAJcYPNFFUim43mj
         zI5ELvTVyUpGraoxJ52qPPPuA4lAt7LghpZ8fCLU9d0IzssNzB7s3YUxcqyhyvrbr2VD
         UXFdx6J9lnpllxen9jWqHii22l4mHb8pcwhG6bjhY7VncI8/ohCW3ap6PF/ffohDFOPX
         T0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVbPvz7p92JFhsiVWZ+v19TWUktR0kQFEDWdo3RlWJJliAC0uVOl4TqMnBiGX4bvBllq0Z/hoJqIGDDYOj7XoVvxWWB/r9VzxwXC4UP
X-Gm-Message-State: AOJu0YyHsiFppvMDxARFCIFdWMBVMHmKes2RWSEov29WKjaHZA31KwOq
	y1zXCCYoIAsxeLlBcZAnKqC6IVfGUUpMhUb5YAO9T7Eayjdi6oi4PN3c49vfliaKxJO9FmT2xlW
	3ok3LLxz7bhIWQi0sKmN1+oI+BRVUJXqoqstUFAuxi2PhzRSFzXFrb+yk8lBbRA==
X-Received: by 2002:a0c:fe8b:0:b0:6a3:27b4:9b72 with SMTP id 6a1803df08f44-6a327b49baemr101393816d6.5.1715671386214;
        Tue, 14 May 2024 00:23:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH89ioZLBSNiqjRiyo8fWL2ZJPx4atue/rPXREABDqOjqAEr1TFGlquEEfDdLQbtkO/SiRlw==
X-Received: by 2002:a0c:fe8b:0:b0:6a3:27b4:9b72 with SMTP id 6a1803df08f44-6a327b49baemr101393586d6.5.1715671385677;
        Tue, 14 May 2024 00:23:05 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1ccd4esm50917516d6.97.2024.05.14.00.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 00:23:05 -0700 (PDT)
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
Subject: [PATCH v3 4/6] KVM: arm64: show writable masks for feature registers
Date: Tue, 14 May 2024 09:22:50 +0200
Message-ID: <20240514072252.5657-5-sebott@redhat.com>
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

Instead of using ~0UL provide the actual writable mask for
non-id feature registers in the output of the
KVM_ARM_GET_REG_WRITABLE_MASKS ioctl.

This changes the mask for the CTR_EL0 and CLIDR_EL1 registers.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 8e8acf3dd9bd..1b6ab483e21e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2562,7 +2562,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
 	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
-	  .set_user = set_clidr },
+	  .set_user = set_clidr, .val = ~CLIDR_EL1_RES0 },
 	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
 	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
@@ -4121,20 +4121,11 @@ int kvm_vm_ioctl_get_reg_writable_masks(struct kvm *kvm, struct reg_mask_range *
 		if (!is_feature_id_reg(encoding) || !reg->set_user)
 			continue;
 
-		/*
-		 * For ID registers, we return the writable mask. Other feature
-		 * registers return a full 64bit mask. That's not necessary
-		 * compliant with a given revision of the architecture, but the
-		 * RES0/RES1 definitions allow us to do that.
-		 */
-		if (is_vm_ftr_id_reg(encoding)) {
-			if (!reg->val ||
-			    (is_aa32_id_reg(encoding) && !kvm_supports_32bit_el0()))
-				continue;
-			val = reg->val;
-		} else {
-			val = ~0UL;
+		if (!reg->val ||
+		    (is_aa32_id_reg(encoding) && !kvm_supports_32bit_el0())) {
+			continue;
 		}
+		val = reg->val;
 
 		if (put_user(val, (masks + KVM_ARM_FEATURE_ID_RANGE_INDEX(encoding))))
 			return -EFAULT;
-- 
2.42.0


