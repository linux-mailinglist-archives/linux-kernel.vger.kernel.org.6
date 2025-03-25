Return-Path: <linux-kernel+bounces-574653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E543A6E82B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D9C3B8B60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3482544C63;
	Tue, 25 Mar 2025 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrIAAEJd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AD4A0C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867871; cv=none; b=J6G3luCSrVEc3fBjDdhZjQawkiZavV3SkUT/eNRUVFcJzWDcplD+rQnYGpxVnrMUBZfQVYJw4u6OgZTo2p83ohjtrYenY3exHWrzAgjEH6koBIG0ck7A/LSmvUwFoSw/m4mmxT9K/68a4eMZAjOvDxXJdCiMwzl0yu+ZyihkRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867871; c=relaxed/simple;
	bh=Ij/UC/V3EoUszJukWy9se9p2Z5SkuuZcxQy6mcDyK18=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ljM/G1ZreQWAFtL3cw+RHOdYTZ4/7ZtCBl5r1fRYM7drIx9/1+3F/LjTPJAcQXd3tX14uVR24KG3a5u46kZXXjhiQKKTvSzrzSLKq+yv6cgMHMFHjV6Aza8uaQSLoyP8K1SVPqsngywaWe8AR/M6jaYWhzFum2A/76keb9taawo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrIAAEJd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742867868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HnkkWB/IJYXgybfVM3A/a6LLwZkE9IPLdJKeFGOk9uQ=;
	b=hrIAAEJdyBZCFsae4VgJiha589cLD1slif899qihFVJwC/LPAby/AdHvBrg7fymghDJfcG
	h90BQthCB+rzljSX6cR8+0Ty08nOV3SviqnM+tE1/sLTOXp/q+qLDMUX1IoAXmLzTmwpF+
	dOhO1oI0+eQMwWg1BGAOuN4ZE0iwtgI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-3i8avJ-0NuqAhShzKFiqwg-1; Mon,
 24 Mar 2025 21:57:47 -0400
X-MC-Unique: 3i8avJ-0NuqAhShzKFiqwg-1
X-Mimecast-MFC-AGG-ID: 3i8avJ-0NuqAhShzKFiqwg_1742867865
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20F03196D2CD;
	Tue, 25 Mar 2025 01:57:45 +0000 (UTC)
Received: from starship.lan (unknown [10.22.65.191])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89B551800268;
	Tue, 25 Mar 2025 01:57:42 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	James Houghton <jthoughton@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH v2 0/2] KVM: selftests: access_tracking_perf_test: skip the test when NUMA balancing is active
Date: Mon, 24 Mar 2025 21:57:39 -0400
Message-Id: <20250325015741.2478906-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Due to several issues which are unlikely to be fixed in the near future,=0D
the access_tracking_perf_test sanity check for how many pages are still cle=
an=0D
after an iteration is not reliable when NUMA balancing is active.=0D
=0D
This patch series refactors this test to skip this check by default automat=
ically.=0D
=0D
V2: adopted Sean's suggestions.=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (1):=0D
  KVM: selftests: access_tracking_perf_test: add option to skip the=0D
    sanity check=0D
=0D
Sean Christopherson (1):=0D
  KVM: selftests: Extract guts of THP accessor to standalone sysfs=0D
    helpers=0D
=0D
 .../selftests/kvm/access_tracking_perf_test.c | 33 +++++++++++++--=0D
 .../testing/selftests/kvm/include/test_util.h |  1 +=0D
 tools/testing/selftests/kvm/lib/test_util.c   | 42 ++++++++++++++-----=0D
 3 files changed, 61 insertions(+), 15 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D


