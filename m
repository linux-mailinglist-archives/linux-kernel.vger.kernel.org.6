Return-Path: <linux-kernel+bounces-199181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F868D8377
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A16B22B02
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C19130487;
	Mon,  3 Jun 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiNRe/6j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2204212F360
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419936; cv=none; b=Ebtyg4UNt3xeQeMmkkLiqEqgyjHg8FLD+llSY3JN2e3VquSKTglgzCGwA4SvroPYiK3Z1Mhm7FpDsTuv5xWZOU8CL4bfzc15+K15P2wCp45PYcdvWmXoPBXCLef1FjUp8POdQHQdQP5PpF3lOdfvWKQwDi2ruSUlTfbcz4rDcvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419936; c=relaxed/simple;
	bh=Xg3rnsN00i+ckdDX25UYE+Fpofh+iwRaHfKXTsHVsqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWCFAT3OP8ppQE1KdAjTfZMANcNgwZfHBU5SwKZsNr1gusuwgsJmO+9EGDM/+9bLFWDlDMOMsqQbIpZ+1+EPWC/pl9Q5OKQoo+eeTBKmhGR1Hl30Rj2s8vxJCWQTt2109g2q8SjTpQJt9E+o9yGsrIxF6bVCwm32dGdgr52f0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JiNRe/6j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717419934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvEydmzzbvl2Ff0xpZlhwXwl7LHoKN1DgH3CccwPGZw=;
	b=JiNRe/6jfe6gW9ME/ieHCX7eSgkd77ACa2/8fdziYwtoWXtBAxJ27/5pyeKW92KTmL86jf
	lV7jh3e5U9X/U941nwE1PhoxbeWbxwpCw2UdEhFSBdseiO00e1Hb3nt8AjoFJbwCj/7M33
	AJ16W6eTKTYTuE1Mgpmh7Lhi1U5jaPg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-gX13Fg-6N_ObKaiGZhgVnA-1; Mon, 03 Jun 2024 09:05:32 -0400
X-MC-Unique: gX13Fg-6N_ObKaiGZhgVnA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ae1535f30fso44309256d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419932; x=1718024732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvEydmzzbvl2Ff0xpZlhwXwl7LHoKN1DgH3CccwPGZw=;
        b=tpjOQqUk5yIkSVWWMJedQGxv8wq3NsBC1mKd72IV2jAVXV0mrr8VrjAznK5UWevZ9p
         8FUnkGSZysY1a/1DSdzcEk1XIlO5vhMoAfIRC92qtuYFuhjJ/25v9IomEnPigjpdls39
         7zWRXeufQogw9yJTjyjPU+sL+uO+/ZDw9q7aGfWQHZ/DhbgrtUFbY+oDaHV/5WLjjHqw
         QIO3dbxJ8anE7mu5TDM4EVN6NZlcarhu00nZwVzHcWJuE4BFSPV+LvJmRBDZ7jE6jZ2M
         N8UJl9a+mQKBamybudE1tXBIENkOpZgrFJAHYZoBmgXtlhx6B6qQKBAyLfpTNeqFj7Nf
         0hiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTgvb7fiOtGFdHSHmocy1HarwK1tSIwosj4AN19Ef3P5LBxtxcrj2Uc2YAn2JJ5NNL/CFqaX5o2EIWzNp01ZbX7iVib38M9WS48qs+
X-Gm-Message-State: AOJu0YxqrpPgrPubeNytk+GwNSCHeaKeWQgFBSNp9p5J7QV4WlyF9a98
	yilO48l4bR89LfNjCUWRQCUEOLI541c/ieBNbA91nUNye9FxdrjwFayoY44oO3kqW5195uTublm
	XWAvAdOwgn19KDp4Yf/yqFaHatLXoY4SyRxqPBFTGgT39tp3xFvbn2JO8ZdFj8Q==
X-Received: by 2002:a05:6214:3f8d:b0:6ae:1063:eea7 with SMTP id 6a1803df08f44-6aecd598cafmr108985796d6.20.1717419931976;
        Mon, 03 Jun 2024 06:05:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7+iy/Dv8ZzX13aFueLNEWj86HkkwR7fT77Dxvoy35+yUzuJEcF3YgXQkFlAET0CFWorT4Fg==
X-Received: by 2002:a05:6214:3f8d:b0:6ae:1063:eea7 with SMTP id 6a1803df08f44-6aecd598cafmr108985266d6.20.1717419931395;
        Mon, 03 Jun 2024 06:05:31 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f02d1004c157eb0f018dd01.dip0.t-ipconnect.de. [2003:c9:3f02:d100:4c15:7eb0:f018:dd01])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b4179f4sm30558826d6.113.2024.06.03.06.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:05:30 -0700 (PDT)
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
Subject: [PATCH v4 6/6] KVM: selftests: arm64: Test writes to CTR_EL0
Date: Mon,  3 Jun 2024 15:05:07 +0200
Message-ID: <20240603130507.17597-7-sebott@redhat.com>
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

Test that CTR_EL0 is modifiable from userspace, that changes are
visible to guests, and that they are preserved across a vCPU reset.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 .../testing/selftests/kvm/aarch64/set_id_regs.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/set_id_regs.c b/tools/testing/selftests/kvm/aarch64/set_id_regs.c
index a7de39fa2a0a..9583c04f1228 100644
--- a/tools/testing/selftests/kvm/aarch64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/aarch64/set_id_regs.c
@@ -219,6 +219,7 @@ static void guest_code(void)
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR1_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR2_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64ZFR0_EL1);
+	GUEST_REG_SYNC(SYS_CTR_EL0);
 
 	GUEST_DONE();
 }
@@ -490,11 +491,25 @@ static void test_clidr(struct kvm_vcpu *vcpu)
 	test_reg_vals[encoding_to_range_idx(SYS_CLIDR_EL1)] = clidr;
 }
 
+static void test_ctr(struct kvm_vcpu *vcpu)
+{
+	u64 ctr;
+
+	vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CTR_EL0), &ctr);
+	ctr &= ~CTR_EL0_DIC_MASK;
+	if (ctr & CTR_EL0_IminLine_MASK)
+		ctr--;
+
+	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CTR_EL0), ctr);
+	test_reg_vals[encoding_to_range_idx(SYS_CTR_EL0)] = ctr;
+}
+
 static void test_vcpu_ftr_id_regs(struct kvm_vcpu *vcpu)
 {
 	u64 val;
 
 	test_clidr(vcpu);
+	test_ctr(vcpu);
 
 	vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MPIDR_EL1), &val);
 	val++;
@@ -525,6 +540,7 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 		test_assert_id_reg_unchanged(vcpu, test_regs[i].reg);
 
 	test_assert_id_reg_unchanged(vcpu, SYS_CLIDR_EL1);
+	test_assert_id_reg_unchanged(vcpu, SYS_CTR_EL0);
 
 	ksft_test_result_pass("%s\n", __func__);
 }
-- 
2.42.0


