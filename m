Return-Path: <linux-kernel+bounces-199190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B354B8D838A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614561F210D0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B3B12C552;
	Mon,  3 Jun 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drm6WUCS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602FC12E1C6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420189; cv=none; b=mQxLM77yPN8o1E1E5tlKF9HLvISxMEV66rA2zUvNzL0IXzW/WefkrvUNIijXCKWKm1WzTWlC9PnTg49kS5otA7ZiCoB2dmqms3AnzZHH/M+0WysMHg1yU4ENjQDxNZAWfluTqPq8gSu+st2i3IFEhFnyiVrDFKvvmRD+qP4tVcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420189; c=relaxed/simple;
	bh=YhcdwzH90218JoOWdcc1NwAP0Li4AXv2Tb893sr7v9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNIjhjShwzbS4KajdZ+yoPMKYx4XI+g/1WaSFrDP0nfDjsf/nm5YM7TNE0CWaXwmZ3pb+G4IVpVXK+b/OP1i1qV4uCRuvLbYz80h5uZFiq2XGGyeTNm+B6x3QZLvhtaBaGD+HGzTZrJSikIE6D3b1Lu2RH334zfPfyPzAtfPtyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drm6WUCS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717420177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXAmMQrgrXIFLyB/yIKENXCHvnmz0ML8IZSHNgowrl8=;
	b=drm6WUCSFiAUQ/Yy/lMllPY2nvmPDWVFRy4cmi/kGzfJ7KSlGPk1jvbj8Hp/zAAmAd8tMD
	cnPjIFsjzbsu2olvDBbySfP1Nv27ekhNgHA3CI5OjgbfMjdpXJKLBHs7CerldCm5yALepa
	0xzsN3cSYqeoG9aLy+fsfW6NIXf+whY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-AzBsRabIO4SWrz_DQFw8JA-1; Mon, 03 Jun 2024 09:05:32 -0400
X-MC-Unique: AzBsRabIO4SWrz_DQFw8JA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43ff7b96a3fso33491541cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419926; x=1718024726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXAmMQrgrXIFLyB/yIKENXCHvnmz0ML8IZSHNgowrl8=;
        b=OcpZhrNOhWvhPd5BZ/5kHEl1cGq2kkse0fw3SM4e8HGd7CZBDpXcb/SH0rQrXeBsRV
         zwOMm7ZLZL5JLAdrEVvzum4mMFyf4I2sp//5NTXJ1HKFSX0NBOmj3VB5wRf7Gv/po9CC
         W9w5eyJus2M5bTsDd4TdzKdL8pmIaqipXAfE529BJbrtjTQuOEeYNtIVOL9K8RJYq5EM
         3E62QenpqnKKfGH8bhAakkclBqG0iy8egg8uFa87VEePWvkYCjOH3fpoIDE1oDv0/sgp
         KMOh92Dqgeyd8rl8iTjHsmrt/7dKQNk6R4/3DUNURBBYA5HBsKxCLuV7QvIpJ1CYj23J
         w1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVWdd5iemjEeeU1ZweFg1V3oJwUM82RzM6zHNhYG8B3QKUlf0qvG8ssuDs+meXDjTvWKu0U9cEkOQ8NV7hfAihtU3TNHnnoyt9NHM2j
X-Gm-Message-State: AOJu0YzTqy2TAk6lRPxLjgH8StJ9nAVRa01unNN1Lb6mSURroBLNPyDY
	N/xpJ3DMEwC0yBJ/ZiT0qPrtLxfuRA//qK0EqvzeDP0uCxFrSwanhLZg95Ly6RF+aarkw1l600P
	LNAr898DGQV4vhyLwfpG1KnzC8Yed/CxRITywCU7yiXaIA4nmc3JMGdiDxqirCA==
X-Received: by 2002:a05:6214:3b87:b0:6af:b70d:55e9 with SMTP id 6a1803df08f44-6afb70d56b0mr37258186d6.42.1717419926036;
        Mon, 03 Jun 2024 06:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLGteIxc3SVsMMA5OIbdqpk/I/qYvB4QX9ht7y8iaF54/X1TCt3zDCTxhbKhkVly5RHbTheQ==
X-Received: by 2002:a05:6214:3b87:b0:6af:b70d:55e9 with SMTP id 6a1803df08f44-6afb70d56b0mr37257636d6.42.1717419925390;
        Mon, 03 Jun 2024 06:05:25 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f02d1004c157eb0f018dd01.dip0.t-ipconnect.de. [2003:c9:3f02:d100:4c15:7eb0:f018:dd01])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b4179f4sm30558826d6.113.2024.06.03.06.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:05:25 -0700 (PDT)
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
Subject: [PATCH v4 4/6] KVM: arm64: show writable masks for feature registers
Date: Mon,  3 Jun 2024 15:05:05 +0200
Message-ID: <20240603130507.17597-5-sebott@redhat.com>
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

Instead of using ~0UL provide the actual writable mask for
non-id feature registers in the output of the
KVM_ARM_GET_REG_WRITABLE_MASKS ioctl.

This changes the mask for the CTR_EL0 and CLIDR_EL1 registers.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 39057718fbcd..8008120d021b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2566,7 +2566,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
 	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
-	  .set_user = set_clidr },
+	  .set_user = set_clidr, .val = ~CLIDR_EL1_RES0 },
 	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
 	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
@@ -4125,20 +4125,11 @@ int kvm_vm_ioctl_get_reg_writable_masks(struct kvm *kvm, struct reg_mask_range *
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


