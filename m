Return-Path: <linux-kernel+bounces-534823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A822A46B83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5EE16BC11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC5F256C81;
	Wed, 26 Feb 2025 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecKu+W1x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56A25E452
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599750; cv=none; b=dsGIGTq7al8eEEmSCBX0H9P5+b9hSYKjLsX0JyhdZt3LL6TAfrATMtxyyV2bFi/XjPiEigb9yZPNP9h+MdWUesogNjMyvPrrYFe5N8Tg4XX510WxjLtj41sm2C1+WqwXpsg1tnSbyYIJczommWkLSN+WBUm4qNZr7Rt1m2WcauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599750; c=relaxed/simple;
	bh=71c0Xtv1G3sdZShTLwpLDw/Yx2zIkCmErPobYWY6JJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H645Io+yl6Nfh3z5d4YXN23niX7Y76memnTauk5YgKyhiFdxoYsodjIDfgbDnpawiAYO0Co8DhP5jxlIU4pxWPgWlzTN48zWm8QB8KU3N7hYH2HrxcacDysGEejJuWwOdKrUtNWMXHmjN4set8xMSGjfllHL/WpVIgk0hd/q+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecKu+W1x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740599747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIU7KaERyuJNgcNNJI4KzTDkF/zeQ9fHuKz3CRSp9RE=;
	b=ecKu+W1xtqw5cCcyOV5F0//UCHyDpEjgRxq/s2C41lRdDI2Uk/qtofdf7+j4p9oAIK0M3R
	Rp12LMc0pRwB8JVimAZAunWxTbTC/8O3hKJqb2Lv45tb19PAiWZgjHW9bOzhGGGLrvMEpM
	C8NNy3+ZX+wZVA8khmhvc7IiZqC8eIg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-AL00vHvIPo2IKzW5Vb-kpQ-1; Wed,
 26 Feb 2025 14:55:44 -0500
X-MC-Unique: AL00vHvIPo2IKzW5Vb-kpQ-1
X-Mimecast-MFC-AGG-ID: AL00vHvIPo2IKzW5Vb-kpQ_1740599742
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6BB219560B9;
	Wed, 26 Feb 2025 19:55:42 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F2001944D02;
	Wed, 26 Feb 2025 19:55:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Yuan Yao <yuan.yao@linux.intel.com>
Subject: [PATCH 08/29] KVM: x86/mmu: Do not enable page track for TD guest
Date: Wed, 26 Feb 2025 14:55:08 -0500
Message-ID: <20250226195529.2314580-9-pbonzini@redhat.com>
In-Reply-To: <20250226195529.2314580-1-pbonzini@redhat.com>
References: <20250226195529.2314580-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Yan Zhao <yan.y.zhao@intel.com>

Fail kvm_page_track_write_tracking_enabled() if VM type is TDX to make the
external page track user fail in kvm_page_track_register_notifier() since
TDX does not support write protection and hence page track.

No need to fail KVM internal users of page track (i.e. for shadow page),
because TDX is always with EPT enabled and currently TDX module does not
emulate and send VMLAUNCH/VMRESUME VMExits to VMM.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Yuan Yao <yuan.yao@linux.intel.com>
Message-ID: <20241112073515.22028-1-yan.y.zhao@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/page_track.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 561c331fd6ec..1b17b12393a8 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -172,6 +172,9 @@ static int kvm_enable_external_write_tracking(struct kvm *kvm)
 	struct kvm_memory_slot *slot;
 	int r = 0, i, bkt;
 
+	if (kvm->arch.vm_type == KVM_X86_TDX_VM)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&kvm->slots_arch_lock);
 
 	/*
-- 
2.43.5



