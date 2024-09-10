Return-Path: <linux-kernel+bounces-323816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8259743D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D3A2B24A78
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9F31850B5;
	Tue, 10 Sep 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vr9F8sJ8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4651AAE08
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725998643; cv=none; b=Uc0aGfHMmYJveU70pSINr4cjw8A6A7SoUUtC+suJ63nG49V5uyEBAK/rkOw4Snj3WfVnWUges4cMAGB+9xUG++zc73SyA0HH/F3K1Gl+BvQuaD6TqNAXeruIdHkGSx7eepu1vuB60CsCdVJvN2nqMTWmB9QnbqXfvQB5XiMiq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725998643; c=relaxed/simple;
	bh=a1MXMzov8K8NsGhzawwRvtgkteSTRXsbInyTHxWth+g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=e2c0tRtF95llMd4nqbjkf9AbraZ+vCyf883tJCilDuWgV7DnKY9c0B49TjOB5riA/PvI1XR5CcHpcvfTpNxx7WeEKWqFe21s7rU0cPndMNOnjUP5b+XBOnJ/6y/Q3oeX9bKjinfD9HKdWnWPe9p5o+U/l8PdI1fijI7bEx2kxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vr9F8sJ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725998640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nmY8Ls7+3bTkDgrl9z41fR6FmH7GZWGRs0hv8SxFyZM=;
	b=Vr9F8sJ8Egar4r7IUtWXzYRSCG159O5AjwxR2kEyGknikzpBlx07GpvBF5JxtT2y8Zo/HG
	8RuMlqoCBxXU0tpouxuZS5WlFsQsHl4LCGvbuxleukB4CRzf+EXDiFAu29FvhYBH0rkAG8
	dwtveIJ9TSqDxZ0SEUS2YtcVlokcQiQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-lA_PWS2hNJC1uy3aBECxfQ-1; Tue,
 10 Sep 2024 16:03:56 -0400
X-MC-Unique: lA_PWS2hNJC1uy3aBECxfQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 952C41956080;
	Tue, 10 Sep 2024 20:03:54 +0000 (UTC)
Received: from starship.lan (unknown [10.22.64.235])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 277111956086;
	Tue, 10 Sep 2024 20:03:51 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v5 0/3] KVM: x86: tracepoint updates
Date: Tue, 10 Sep 2024 16:03:47 -0400
Message-Id: <20240910200350.264245-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This patch series is intended to add some selected information=0D
to the kvm tracepoints to make it easier to gather insights about=0D
running nested guests.=0D
=0D
This patch series was developed together with a new x86 performance analysi=
s tool=0D
that I developed recently (https://gitlab.com/maximlevitsky/kvmon)=0D
which aims to be a better kvm_stat, and allows you at glance=0D
to see what is happening in a VM, including nesting.=0D
=0D
V5: rebased on top of recent changes=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (3):=0D
  KVM: x86: add more information to the kvm_entry tracepoint=0D
  KVM: x86: add information about pending requests to kvm_exit=0D
    tracepoint=0D
  KVM: x86: add new nested vmexit tracepoints=0D
=0D
 arch/x86/include/asm/kvm-x86-ops.h |   1 +=0D
 arch/x86/include/asm/kvm_host.h    |   5 +-=0D
 arch/x86/kvm/svm/nested.c          |  22 ++++++=0D
 arch/x86/kvm/svm/svm.c             |  17 +++++=0D
 arch/x86/kvm/trace.h               | 107 ++++++++++++++++++++++++++---=0D
 arch/x86/kvm/vmx/main.c            |   1 +=0D
 arch/x86/kvm/vmx/nested.c          |  27 ++++++++=0D
 arch/x86/kvm/vmx/vmx.c             |  11 +++=0D
 arch/x86/kvm/vmx/x86_ops.h         |   4 ++=0D
 arch/x86/kvm/x86.c                 |   3 +=0D
 10 files changed, 189 insertions(+), 9 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D


