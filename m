Return-Path: <linux-kernel+bounces-423924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93B79DAE55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E56D281E18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29942036E9;
	Wed, 27 Nov 2024 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvaXwOHB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F72036E2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732738227; cv=none; b=EL7XaKOxGBEJJYstNRzy35ywb8psMw0iTDsmeR+hXL0Ma2aOwNvvTrufe7eXA3yM7WK35h2BbSYZfLACrl9g6tRLK4DTOfvPlEfurKSvnDvGDTiiRjdowbexPSciB8hojNkD1zndESjGi9Mg9RXHri2cK+I9q9KSPMBXWKIgEcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732738227; c=relaxed/simple;
	bh=wf9np12P993ALL8S60/z6IZ5ESfqcSyxbLLGF9CbH7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RAnCHRHsnKHzC6fJV4ksmvExSLRGgFdNHRhsKXC4co+rv4sqP/pD3SP33XDWrEMHpMIr4bpNRjKYWmV5jQh8TbDulLlPcfm/npoD/jkYiJVDC57WmT/ml2DC6SOfbdUG7Y2uVH1MGIiHXjOQodpWjqAbCAFsUVmOrfggVUu33kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvaXwOHB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732738223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZpuWQ1ZfKTxADNs95f7KBjnO90pMOcxXWIMopnr6LPE=;
	b=bvaXwOHBHgzaWpSI+PlZjFrt9fd7gj5t/XNwCZzhbJq5JYpTnAPXIMX6em8lySgsz11RXx
	+P7oCmOjtGxSaEZxEMyv+p0WrR8fkOUaOVkLQVbzmPZSDA6cmBT7Cq5yBVPM8FfCbBbs0y
	PJGvZGQYRRFTm9NzK5NmxixUfXIJpnc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-OkcTq4PaMR6AhpIYDnEPxg-1; Wed,
 27 Nov 2024 15:10:22 -0500
X-MC-Unique: OkcTq4PaMR6AhpIYDnEPxg-1
X-Mimecast-MFC-AGG-ID: OkcTq4PaMR6AhpIYDnEPxg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7A511956088;
	Wed, 27 Nov 2024 20:10:20 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2BA0F1955F40;
	Wed, 27 Nov 2024 20:10:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: kai.huang@intel.com
Subject: [PATCH v3 0/3] KVM: VMX: Initialize TDX during KVM module load
Date: Wed, 27 Nov 2024 15:10:16 -0500
Message-ID: <20241127201019.136086-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This is a slightly reviewed version of Kai's same-titled series.
The changes in patch 4 I include rewording the comments, adding
a check that enable_virt_at_load=1, and an error message for
!cpu_feature_enabled(X86_FEATURE_TDX_HOST_PLATFORM).

Paolo

Kai Huang (3):
  KVM: Export hardware virtualization enabling/disabling functions
  KVM: VMX: Refactor VMX module init/exit functions
  KVM: VMX: Initialize TDX during KVM module load

 arch/x86/kvm/Kconfig     |  10 +++
 arch/x86/kvm/Makefile    |   1 +
 arch/x86/kvm/vmx/main.c  |  41 ++++++++++
 arch/x86/kvm/vmx/tdx.c   | 160 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/tdx.h   |  13 ++++
 arch/x86/kvm/vmx/vmx.c   |  23 +-----
 arch/x86/kvm/vmx/vmx.h   |   3 +
 include/linux/kvm_host.h |   9 +++
 virt/kvm/kvm_main.c      |  21 ++---
 9 files changed, 245 insertions(+), 36 deletions(-)
 create mode 100644 arch/x86/kvm/vmx/tdx.c
 create mode 100644 arch/x86/kvm/vmx/tdx.h

-- 
2.43.5


