Return-Path: <linux-kernel+bounces-171711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1278BE7A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B79286A82
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93E716ABC8;
	Tue,  7 May 2024 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUVtv26u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870E1635D5
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096705; cv=none; b=FlzH7Cm4NDSdOOmCWOm3+dqrXd8jbXi8KWOZ7P/3daJZcvlitze5fEhvz5VQhabJkyM/siysbRsCXZ6kxwbF1KN0kUE/yjS/igknubg4XdiX6W76aBqO5D8B6tU5XOU0t0U1djsy4xhvKeY2/kWUyO1p/X1VEO9pw6EqlDwx+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096705; c=relaxed/simple;
	bh=3EKyAa8M7cx/xE73k5vxAGMUtwqen/TT/5gLXWqWZ9Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QhbAfbw6OxmBsMC63aGFMOKY2O/ef+Sk2FBTYJaST5wHtKMzvNXp1TV+tQjm1IMZD+YEaaN96XwwFshgn9ZNZVTsxtE5PvKq7JLgh5wpQsGP1PPSY9jspsCZVyTTjWh8Dp1JYF8K6eLMLUGZlbHi3KXmXB6YafLfSjq4sxCmSfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUVtv26u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715096702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bB7ooeC+6+Eo7pbT0iOPQxNvJmou4DDO/iz/oRY16T4=;
	b=CUVtv26uSenUslQB2G37n3792fmrnujRDvciiDKonOPA47AiLFXRP+x5Bh01YTGufhXiRa
	Ok38ZBLofO3MBCjiZKGIrnt47WCP3UK9NfiT2y6bGYt+bVit7JBxB3PhoX7DtIWYcXmqtW
	5ocoIcRO4RktbnJxNABojqetxdIl060=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-yMQWyBTfMDqtxEwx2BSFkw-1; Tue,
 07 May 2024 11:45:00 -0400
X-MC-Unique: yMQWyBTfMDqtxEwx2BSFkw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8355229ABA11;
	Tue,  7 May 2024 15:45:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B7CAC154E5;
	Tue,  7 May 2024 15:45:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 0/7] KVM: MMU changes for TDX VE support
Date: Tue,  7 May 2024 11:44:52 -0400
Message-ID: <20240507154459.3950778-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Allow a non-zero value for non-present SPTE and removed SPTE,
so that TDX can set the "suppress VE" bit.  This is taken from
https://patchew.org/linux/20240416201935.3525739-1-pbonzini@redhat.com/
with review comments addressed:

- do not dereference an address from the VMCS to include #VE info
  in the dump

- fail hard if the #VE info page cannot be allocated

Paolo

Isaku Yamahata (2):
  KVM: x86/mmu: Add Suppress VE bit to EPT
    shadow_mmio_mask/shadow_present_mask
  KVM: VMX: Introduce test mode related to EPT violation VE

Paolo Bonzini (1):
  KVM, x86: add architectural support code for #VE

Sean Christopherson (4):
  KVM: Allow page-sized MMU caches to be initialized with custom 64-bit
    values
  KVM: x86/mmu: Replace hardcoded value 0 for the initial value for SPTE
  KVM: x86/mmu: Allow non-zero value for non-present SPTE and removed
    SPTE
  KVM: x86/mmu: Track shadow MMIO value on a per-VM basis

 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/include/asm/vmx.h      | 13 ++++++++
 arch/x86/kvm/Kconfig            | 13 ++++++++
 arch/x86/kvm/mmu/mmu.c          | 21 ++++++++-----
 arch/x86/kvm/mmu/paging_tmpl.h  | 14 ++++-----
 arch/x86/kvm/mmu/spte.c         | 24 ++++++++-------
 arch/x86/kvm/mmu/spte.h         | 24 ++++++++++++---
 arch/x86/kvm/mmu/tdp_mmu.c      | 18 +++++------
 arch/x86/kvm/vmx/vmcs.h         |  5 ++++
 arch/x86/kvm/vmx/vmx.c          | 53 ++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.h          |  6 +++-
 include/linux/kvm_types.h       |  1 +
 virt/kvm/kvm_main.c             | 16 ++++++++--
 13 files changed, 167 insertions(+), 43 deletions(-)

-- 
2.43.0


