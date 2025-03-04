Return-Path: <linux-kernel+bounces-543259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE13A4D370
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C834A3AE503
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286071F873A;
	Tue,  4 Mar 2025 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GK9m/VAH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9261F4E30
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068434; cv=none; b=blRbXygnHzcldrXGxnx6zRbJcv8E8nLKEKTh3gws4TYb3b08LRmidJHVVQyjiT3t3ZRvoVShTgE4gE522pNrsILzNG+gSXQuq9r/DkldIklCDpxq27MPe2u2YR/Vful4ulmyNoWUek0iifqx4wx6FAmL96zLwAH3Oke6qmY8yvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068434; c=relaxed/simple;
	bh=WsLGljyHCX0zroN9NjHxnwSRav5wouWwgj/kVngfrBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQJgs5k3SGw/jNrH2QIF40WMGiMh3sFmFzj3ps5tSYPxso/lN5PW22jH9k8+KB0wrfQeXwMR+dHAgOvEQqLOKYMKqtO60wgkVHzoC0IUDxseDu6EuzmJQHRaBCjbikupsgY5En06AxoIVgw65fJv3jBiTmGWtDTuZINstXlxqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GK9m/VAH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741068432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GdEIWZIH2eKGHtQySdvQ9TzxOHVfZXOqEG078/YncxI=;
	b=GK9m/VAHg5psC5fr2hDWDZ7wSVbSV8D9+jaKvg3Yov0ZQEQkeFt2/IZQKyjdON/b2S64fh
	N9bBLcLvs2oVjBJE3XnAknLemygMOGIX83+r+UnXdtRQayhA1PnmsslU+qXG5HPLyHh3EA
	v8h2GZUpf/bbUKrO7BRvxY9pmwZvaNk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-zm5kK5PXPheefPrXRTyvEQ-1; Tue,
 04 Mar 2025 01:06:51 -0500
X-MC-Unique: zm5kK5PXPheefPrXRTyvEQ-1
X-Mimecast-MFC-AGG-ID: zm5kK5PXPheefPrXRTyvEQ_1741068410
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52D491944D45;
	Tue,  4 Mar 2025 06:06:50 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6860519560A3;
	Tue,  4 Mar 2025 06:06:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: xiaoyao.li@intel.com,
	seanjc@google.com,
	yan.y.zhao@intel.com
Subject: [PATCH v3 1/6] KVM: x86: do not allow re-enabling quirks
Date: Tue,  4 Mar 2025 01:06:42 -0500
Message-ID: <20250304060647.2903469-2-pbonzini@redhat.com>
In-Reply-To: <20250304060647.2903469-1-pbonzini@redhat.com>
References: <20250304060647.2903469-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Allowing arbitrary re-enabling of quirks puts a limit on what the
quirks themselves can do, since you cannot assume that the quirk
prevents a particular state.  More important, it also prevents
KVM from disabling a quirk at VM creation time, because userspace
can always go back and re-enable that.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 856ceeb4fb35..35d03fcdb8e9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6525,7 +6525,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			break;
 		fallthrough;
 	case KVM_CAP_DISABLE_QUIRKS:
-		kvm->arch.disabled_quirks = cap->args[0];
+		kvm->arch.disabled_quirks |= cap->args[0];
 		r = 0;
 		break;
 	case KVM_CAP_SPLIT_IRQCHIP: {
-- 
2.43.5



