Return-Path: <linux-kernel+bounces-263642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A84F93D893
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C23287120
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A32446AC;
	Fri, 26 Jul 2024 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxO+PdxI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB793BBF1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019925; cv=none; b=EVSO2IqRBQ7jxn1N/pEtfwV7Q2OMQmdaGj+d1DE70pcJ+FUqBaOr6F0CHUEdF0YFBYsQVzyVLaxXxtE54IRxnVL6JPJsJJ2dEdS0Lhk9GyEF81qjMfaRPWfh/QLVX6iytvqKKMamty360n99StJNd7wpA5v7cXy6FPBi+CvxZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019925; c=relaxed/simple;
	bh=ymP5zSuc1XAfrT0qYpWtAW4ya6zvl0fQ5aJA6v8gXt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HAs2jPATXHPD31YxpQTvL/6AIWxZ55dGNtbv6IGZ3z38/SMa9D1mbjmNZ9YINgr0XrxCj6akx8ibxm2bO3ydJxpBkerH+28VE4pjs+a6jJhtivziauZU6Xr8klY0Mu5h90w++sVVM8pB/C7jz2WM6uIFsjE6yX7CSSWw2rq81cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxO+PdxI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722019923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K7UqT8JGG+s7y0EBj5ziB3IQQklD/kMpeSyBaQUq1m4=;
	b=WxO+PdxIyykJGJbubAhM8p417mKzAoIVWVYhGDIOgNLD2j3EbguXj3sj7QJMFeAUSPf3Q6
	53E0/X/K1ZR0/+nEaCKiv7ekyE+gXF8TWaD0iEiPCuzFa52S/2SLOtoTXi1KMVwMM5vSfV
	3ePdeWePhBE6iB8UM6MZjCry2p0jbkA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-yDmXqo1wOJ6v8bMkVlS7VA-1; Fri,
 26 Jul 2024 14:52:00 -0400
X-MC-Unique: yDmXqo1wOJ6v8bMkVlS7VA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE7B81955D45;
	Fri, 26 Jul 2024 18:51:58 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 201873000194;
	Fri, 26 Jul 2024 18:51:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com
Subject: [PATCH v2 00/14] KVM: guest_memfd: lazy preparation of pages + prefault support for SEV-SNP
Date: Fri, 26 Jul 2024 14:51:43 -0400
Message-ID: <20240726185157.72821-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

There are a few issues with the implementation of SEV page "preparation"
and KVM_SEV_SNP_LAUNCH_UPDATE:

- doing fallocate() before KVM_SEV_SNP_LAUNCH_UPDATE will cause the latter to fail.

- checking that only private pages are passed to KVM_SEV_SNP_LAUNCH_UPDATE
  is done in the guts of vendor code, as is the check that pages are not
  passed twice.  This goes against the idea of putting as much common
  code as possible in kvm_gmem_populate(), for example it returns -EINVAL
  if the page is already assigned.

- clearing the page is unnecessary if the firmware will overwrite it

- the "prepare" bool argument is kinda gross

The important observation here is that the two paths that initialize the
contents of the folio are mutually exclusive: either the folio is populated
with unencrypted data by userspace, or it is zeroed because userspace did
not do anything beyond fallocate().  But in the latter there's no need to
zero and prepare the page at the time of fallocate(): it can be done instead
when the guest actually uses the page.

Pulling all the zero-and-prepare code into kvm_gmem_get_pfn() separates the
flows more clearly, but how do you recognize folios that haven't been
prepared yet?  The answer is to use the up-to-date flag; there is a
limited attempt to use it right now, but it only concerns itself with
the folio having been cleared.  Instead after this series the flag is set
for folios that went through either kvm_gmem_populate() or that have been
mapped into the guest once (and thus went through kvm_arch_gmem_prepare(),
on architectures where that is a thing).

As a bonus, KVM knows exactly which guest is mapping a page, and thus
the preparation code does not have to iterate through all bound
instances of "struct kvm".

There is an easy way vendor-independent way to obtain the previous
behavior if desired, and that is simply to do KVM_PRE_FAULT_MEMORY after
KVM_SEV_SNP_LAUNCH_FINISH.  Note that KVM_PRE_FAULT_MEMORY *before*
KVM_SEV_SNP_LAUNCH_FINISH would not work, and is therefore explicitly
blocked by the first patch in the series.

The bulk of the changes are in patches 1, 7, 10 and 13.  Everything else is
small preparatory changes; many patches in the first half for example try
to use struct folio more instead of struct page and pfns, which is useful
when the code region before folio_unlock() is extended to the callers
of kvm_gmem_get_folio().  There's also a couple cleanups in the middle,
for example patches 4 and 8.

Paolo



Paolo Bonzini (14):
  KVM: x86: disallow pre-fault for SNP VMs before initialization
  KVM: guest_memfd: return folio from __kvm_gmem_get_pfn()
  KVM: guest_memfd: delay folio_mark_uptodate() until after successful
    preparation
  KVM: guest_memfd: do not go through struct page
  KVM: rename CONFIG_HAVE_KVM_GMEM_* to CONFIG_HAVE_KVM_ARCH_GMEM_*
  KVM: guest_memfd: return locked folio from __kvm_gmem_get_pfn
  KVM: guest_memfd: delay kvm_gmem_prepare_folio() until the memory is
    passed to the guest
  KVM: guest_memfd: make kvm_gmem_prepare_folio() operate on a single
    struct kvm
  KVM: remove kvm_arch_gmem_prepare_needed()
  KVM: guest_memfd: move check for already-populated page to common code
  KVM: cleanup and add shortcuts to kvm_range_has_memory_attributes()
  KVM: extend kvm_range_has_memory_attributes() to check subset of
    attributes
  KVM: guest_memfd: let kvm_gmem_populate() operate only on private gfns
  KVM: guest_memfd: abstract how prepared folios are recorded

v1->v2:
- patch 1: new
- patch 7: point out benign race between page fault and hole-punch
- patch 7: clean up comments
- patch 10: clean up commit message
- patch 11: remove ";;"
- patch 13: fix length argument to kvm_range_has_memory_attributes()
- patch 14: new

 Documentation/virt/kvm/api.rst  |   6 +
 arch/x86/include/asm/kvm_host.h |   1 +
 arch/x86/kvm/Kconfig            |   4 +-
 arch/x86/kvm/mmu/mmu.c          |   5 +-
 arch/x86/kvm/svm/sev.c          |  17 +--
 arch/x86/kvm/svm/svm.c          |   1 +
 arch/x86/kvm/x86.c              |  12 +-
 include/linux/kvm_host.h        |   9 +-
 virt/kvm/Kconfig                |   4 +-
 virt/kvm/guest_memfd.c          | 226 +++++++++++++++++++-------------
 virt/kvm/kvm_main.c             |  73 +++++------
 11 files changed, 206 insertions(+), 152 deletions(-)

-- 
2.43.0


