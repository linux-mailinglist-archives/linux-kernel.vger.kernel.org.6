Return-Path: <linux-kernel+bounces-329725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA9D979505
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 09:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEE51F230BC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC8D3D96A;
	Sun, 15 Sep 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMTu2CHO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627222CA6
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726385420; cv=none; b=sX1m83iPq8l0yHiRoDunF5Z+QLGBDP6s2KTHeAHQYexBA6kzr3Fr6CPszXyDRl/2LyNqT/Tf5Lxa7DGKHttEHHAqfoosazoGzdCKFMY6uabst5Kgva8FQhShieAVfCkYh2xoRIlXnTHcuLepVMOdS8pdVlYRJpxeLgA8ZZ5OvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726385420; c=relaxed/simple;
	bh=igxUPKGkvORmzyvgY+L9YnXwzGMDMJrpyPMJ812vTpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CWUfHATf2dy2T4bBm4rkxocI6sM/tdwQbgxuyxmNiqR/rEBG041uifPxoih7NUc17Bp9BAmKNR3oJLHYS2W/SrrcctfYSq6fb79HDIsGj0vx9qph4Y3P8VxAjqakk6SHIqcf7q4SrJefLmare3gZ9h7EQAXqCKuJ6ia+5APVDGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMTu2CHO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726385417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p0S1kKmf3+2KLwssvqX+Fi0rqEw/yiDyRgWCh7B76Fc=;
	b=IMTu2CHOFmTFQOetIr5THAbBcTbd4gqAwlUDT7mZ+CkXRNzi26rBd6/I+ArDpnWd12tZp+
	wPduMWjbFwvST0VfDczYiROCScXxJZKg/nnRDHurCKXwkb/GjEhlTD0QV2MBr2Pq5tFlIM
	6tcwAeh49tEokoy4fNb55QImI9zZqfA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-i17LOYJINXybKfLgxagIxQ-1; Sun,
 15 Sep 2024 03:30:13 -0400
X-MC-Unique: i17LOYJINXybKfLgxagIxQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A11871955F41;
	Sun, 15 Sep 2024 07:30:12 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B33C51956088;
	Sun, 15 Sep 2024 07:30:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM revert for Linux 6.11-rc8 (or final)
Date: Sun, 15 Sep 2024 03:30:10 -0400
Message-ID: <20240915073010.5860-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Linus,

The following changes since commit 59cbd4eea48fdbc68fc17a29ad71188fea74b28b:

  KVM: Remove HIGH_RES_TIMERS dependency (2024-09-05 12:04:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus-6.11

for you to fetch changes up to 9d70f3fec14421e793ffbc0ec2f739b24e534900:

  Revert "KVM: VMX: Always honor guest PAT on CPUs that support self-snoop" (2024-09-15 02:49:33 -0400)

----------------------------------------------------------------
Do not always honor guest PAT on CPUs that support self-snoop.
This triggers an issue in the bochsdrm driver, which used ioremap()
instead of ioremap_wc() to map the video RAM.  The revert lets video
RAM use the WB memory type instead of the slower UC memory type.

----------------------------------------------------------------
Paolo Bonzini (1):
      Revert "KVM: VMX: Always honor guest PAT on CPUs that support self-snoop"

 arch/x86/kvm/mmu/mmu.c |  8 +++-----
 arch/x86/kvm/vmx/vmx.c | 10 ++++------
 2 files changed, 7 insertions(+), 11 deletions(-)


