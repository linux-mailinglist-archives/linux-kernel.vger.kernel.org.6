Return-Path: <linux-kernel+bounces-289697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DB0954AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF42528208E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52E1B3749;
	Fri, 16 Aug 2024 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YB/Oppta"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78B61AE03E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813307; cv=none; b=g7jurj8VbMlLoclV1Ed3N1S+7fWvwwZnKxTqLmcL/hKNe6w6EssKOvdonYDH63X0RWT+tt3AZFQIsNofF+ZQiwT4RhbFXE5q7VG4kdqyIGUtYQht709rIYoALrgeyoLjSzs67a3qW3V90Jj/yh1e5OLKvIS2Rr681RwFDtH89nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813307; c=relaxed/simple;
	bh=IXxUcnblXZcQKB2Vwla8WVo3+6TI41Xh/OrHwOQReno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rL/WbrcvAv6d4BMsxNNbJbkmCp1b+j6bp/CfRINbCtp9rllCbnGQxuHGB7ETTKwVHc8XHgUi5ZloJoCsJBQW6fSd0MFfT1RI8hWN1r8GIgU3emSV8Z2/JZD8Yj/tRfywl3O3UKtvbMsAu4AIk7OziTKCazcjKU79Cn+h2McX1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YB/Oppta; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723813304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C7VlMMtXqudPTjMdW7XebeqNFyDobGJD3oTuG5nZyC0=;
	b=YB/Oppta6xZdVgmERdMVd8R1PVMltfjU8XrOppBOVTh0n7RtLtrmV7ssfI6MCrOe4MaP8D
	Yrcr7GtRQTiMTVF/qeNNORPQOabZFqV29oy+Uy/x0Pgq2UVWI+yBhOk5zMIQPehIoPuTOF
	1ZimS18Ge3gaR8rm6KAyYSgtoh7jo2s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-gRSc8D1NMP-ZkB7Id26wRw-1; Fri,
 16 Aug 2024 09:01:43 -0400
X-MC-Unique: gRSc8D1NMP-ZkB7Id26wRw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D9A51955D56;
	Fri, 16 Aug 2024 13:01:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEBF91955F35;
	Fri, 16 Aug 2024 13:01:40 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] KVM: selftests: Re-enable hyperv_evmcs/hyperv_svm_test on bare metal
Date: Fri, 16 Aug 2024 15:01:37 +0200
Message-ID: <20240816130139.286246-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Commit 6dac1195181c ("KVM: selftests: Make Hyper-V tests explicitly require
KVM Hyper-V support") wrongfully added KVM_CAP_HYPERV_DIRECT_TLBFLUSH
requirement to hyperv_evmcs/hyperv_svm_test tests. The capability is only set
when KVM runs on top of Hyper-V. The result is that both tests just skip when
launched on bare metal. Add the required infrastructure and check for the
correct CPUID bit in KVM_GET_SUPPORTED_HV_CPUID instead.

Vitaly Kuznetsov (2):
  KVM: selftests: Move Hyper-V specific functions out of processor.c
  KVM: selftests: Re-enable hyperv_evmcs/hyperv_svm_test on bare metal

 .../selftests/kvm/include/x86_64/hyperv.h     | 18 +++++
 .../selftests/kvm/include/x86_64/processor.h  |  7 +-
 .../testing/selftests/kvm/lib/x86_64/hyperv.c | 67 +++++++++++++++++++
 .../selftests/kvm/lib/x86_64/processor.c      | 61 -----------------
 .../selftests/kvm/x86_64/hyperv_evmcs.c       |  2 +-
 .../selftests/kvm/x86_64/hyperv_svm_test.c    |  2 +-
 .../selftests/kvm/x86_64/xen_vmcall_test.c    |  1 +
 7 files changed, 92 insertions(+), 66 deletions(-)

-- 
2.46.0


