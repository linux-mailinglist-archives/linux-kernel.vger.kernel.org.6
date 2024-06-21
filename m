Return-Path: <linux-kernel+bounces-225293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C97D912EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CBB2835E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B313C17B4FE;
	Fri, 21 Jun 2024 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1P+YL0o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F6016D311
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002593; cv=none; b=CPWIn/5rlvjw7Kgj6KnybsdwTXG3uGC6fRrfqchacI+Wf8p4YnmKjWfIKCw+6i7zPJfayBtuebl59TinxwjQsfmewduWpu4EgmtIR7lYUiqrm2nfBlH8994G0j+u9FkIu09BHei0tOstM9oYuGO0GUDjMXQXKO95Ejn4+kDSpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002593; c=relaxed/simple;
	bh=dRy5vRpeDiTqPPMeffSPGkngJuGcPYfg8nXfrG0yiZY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OavUedDuWI34j6Oo8+ejJggxkU0TOqIXb7QzO1loXv2CpTk/7GBG6JC8peEAgCWxUF0KFhlArRI1UGFBkVo0/ZnEjj8F8p1UtDTsseHTYjNBzQSQKYOm8fezOB4hxPDOmRa0gxQRAcVLIsw+Q809Pnlq6Gl6tXsYjzkW8wpEDLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1P+YL0o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719002590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gZl2w99Fl76PceNodwmMtywOPMfrUGpvEcdrP2/nIC4=;
	b=T1P+YL0oh4Dttn5czoQ4Kb6lPt/+1KGTi9+ppRpfHApIlHIZrFh2PbX7Lpb2VLPcPx5czJ
	2EBcnoPPCuvgiJ+499BaJltE42t52OYoFa4RFObxS3wmIoA+YqxZnNKbArPElYRSPUwMNV
	VBqYWBHAAfH8D/96yL5ffTl7CtcTEQM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-jqGj7A73Nm-7eRKxT-_AmQ-1; Fri,
 21 Jun 2024 16:43:08 -0400
X-MC-Unique: jqGj7A73Nm-7eRKxT-_AmQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 765491955E7E;
	Fri, 21 Jun 2024 20:43:07 +0000 (UTC)
Received: from starship.lan (unknown [10.22.18.76])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 18B171955E72;
	Fri, 21 Jun 2024 20:43:05 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 0/1] KVM: selftests: pmu_counters_test: increase robustness of LLC cache misses
Date: Fri, 21 Jun 2024 16:43:04 -0400
Message-Id: <20240621204305.1730677-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Recent CI failures brought my attention to the fact that pmu_counters_test=
=0D
sometimes fails because it doesn't get any LLC cache misses.=0D
=0D
It apparently happens because CLFLUSH can race with CPU prediction.=0D
=0D
To attempt to fix this, implement a more aggressive cache flushing - now it=
 is flushed=0D
on each iteration of the measured loop which should at least reduce by orde=
r=0D
of magnitude the chance of this happening.=0D
=0D
This patch survived more that a day of running in a loop on a Comet Lake ma=
chine,=0D
where the test used to fail after about 10-20 minites.=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (1):=0D
  KVM: selftests: pmu_counters_test: increase robustness of LLC cache=0D
    misses=0D
=0D
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 20 +++++++++----------=0D
 1 file changed, 9 insertions(+), 11 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D


