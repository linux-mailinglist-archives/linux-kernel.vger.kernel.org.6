Return-Path: <linux-kernel+bounces-407529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AD09C6E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FDA283C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41E8201275;
	Wed, 13 Nov 2024 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKmADP4R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF13200C90
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499313; cv=none; b=KfbmMgS6Kic+5em7vyt4xGNr94831VHEdKR05Au87BeCiRKrEdKN2mm8klC5cs5mRC6ghCCz4AoXBOGcMzsu/B9jxq+4Na8VbBYfprFJ+B40/kc12zxtJuu0dVJ/3tOartzjBwM8m90WaAHFQ5Y1VN4ebClZuao8jKSuPhdgO3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499313; c=relaxed/simple;
	bh=ZRNu98X/Aq7FMdr669P99K9A18RVmmAu4sWC/JQfSa8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EzhRtisel92yCyqGqdbBKJ48ckhseDIWzGA2fByAGJGDU8nN6J/bhpe6DeGx/530E4MmbD2YKBWwsAZJJGAbd4LAhQU65Im+OGdtBPSFbUMXP640fDEb7x7eoIEFXuxpIAT5T57MHb5Bae1Q1Q7GbK28ezBHaNeKzXTFbhcQoPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKmADP4R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731499310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i64/HfOLCzx+xwWoMfRTr2iqUATuC1Oi6/xkRusoSNU=;
	b=YKmADP4Rt2GvP4l7sQSFm7/0kem6MLDWI33A4nGrKnAP/B/vZ5uD4qklBZE9zZdfgm2KWN
	fqBxinJrrqslTS5jc0eMMUchJAkezDXcLoU0dtGAzegvvhcj3PIYJgR4bfc1GbuEeSbuYU
	OOBHhGA9VPjEIqid98nvlisIvZOCKK4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-lZrQ2DvcOzGkdpuagMY_CA-1; Wed,
 13 Nov 2024 07:01:47 -0500
X-MC-Unique: lZrQ2DvcOzGkdpuagMY_CA-1
X-Mimecast-MFC-AGG-ID: lZrQ2DvcOzGkdpuagMY_CA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A3151954226;
	Wed, 13 Nov 2024 12:01:46 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0ED01955F3C;
	Wed, 13 Nov 2024 12:01:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH] KVM: x86: expose MSR_PLATFORM_INFO as a feature MSR
Date: Wed, 13 Nov 2024 07:01:44 -0500
Message-ID: <20241113120145.388071-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

For userspace that wants to disable KVM_X86_QUIRK_STUFF_FEATURE_MSRS, it
is useful to know what bits can be set to 1 in MSR_PLATFORM_INFO (apart
from the TSC ratio).  The right way to do that is via /dev/kvm's
feature MSR mechanism.

In fact, MSR_PLATFORM_INFO is already a feature MSR for the purpose of
blocking updates after the vCPU is run, but KVM_GET_MSRS did not return
a valid value for it.

Just like in a VM that leaves KVM_X86_QUIRK_STUFF_FEATURE_MSRS enabled,
the TSC ratio field is left to 0.  Only bit 31 is set.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8637bc001096..03b409deb7d7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1675,6 +1675,9 @@ static int kvm_get_feature_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 	case MSR_IA32_PERF_CAPABILITIES:
 		*data = kvm_caps.supported_perf_cap;
 		break;
+	case MSR_PLATFORM_INFO:
+		msr->data = MSR_PLATFORM_INFO_CPUID_FAULT;
+		break;
 	case MSR_IA32_UCODE_REV:
 		rdmsrl_safe(index, data);
 		break;
-- 
2.43.5


