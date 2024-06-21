Return-Path: <linux-kernel+bounces-225173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFCB912D14
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08E91C23D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B1B17B438;
	Fri, 21 Jun 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrOjmxiC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A07179206
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993567; cv=none; b=OG0LNQjBoHc6b231toqFzmZPPrf23IdDai6QUMm4/BOW3SaaQ5xe7OcIczt+nqc9NN2rOSOmf/my/L2LUiQ1tcudj6m6YUPloqSya2wYsmNuY9D/iwu4VCRTi0FH9HoH668ujnExIdbgf4FkMA15z8FwjnQXcgiN+T71xS6qkz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993567; c=relaxed/simple;
	bh=Y599k+zSybdg2JOvHy7OaMyrh1jyQwSGQbme1c7buBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+V0N+cpwRmErOFuRMksmXIQgFaYYqjYdGawe/Z3+c7MTClJ5k2JDk46qLRzjQuHefVZp7YhFfZUZZUYSS7xJkeYGY63WRohYRdIhFisUkihFjPC9KT3tTwP/iZc7CqekQHuSb9fsg5YdDozMOPKv/DkRERQ81Kd4Zq3ecogEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CrOjmxiC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718993565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cr6dk5Gx+6xUDFsSwN421Zwok7Qnwc3SYB5JfAAmbas=;
	b=CrOjmxiCtavf54hUV+gvivkyf+cCd5LafjsPp4H8OFJHHM19Kfc4ruZAF3JqZ8wluusEmw
	h/COkpLtIPpmzKZs9khxUi7SImv0Dv+ZgkWllya8WZJJjiUA56+R4UUuCgdcmsS8Hoij3f
	EGjmV7qwGAhEtogIx4FXsl/WfccgCqA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-WM9VARPvNTWwGJjXM4GQRQ-1; Fri,
 21 Jun 2024 14:12:41 -0400
X-MC-Unique: WM9VARPvNTWwGJjXM4GQRQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2E2219560A7;
	Fri, 21 Jun 2024 18:12:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.154])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F5FF1956056;
	Fri, 21 Jun 2024 18:12:36 +0000 (UTC)
From: Audra Mitchell <audra@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	aarcange@redhat.com,
	akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com,
	shli@fb.com,
	peterx@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	raquini@redhat.com
Subject: [PATCH v2 3/3] Turn off test_uffdio_wp if CONFIG_PTE_MARKER_UFFD_WP is not configured.
Date: Fri, 21 Jun 2024 14:12:24 -0400
Message-ID: <20240621181224.3881179-3-audra@redhat.com>
In-Reply-To: <20240621181224.3881179-1-audra@redhat.com>
References: <20240621181224.3881179-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If CONFIG_PTE_MARKER_UFFD_WP is disabled, then testing with test_uffdio_up
enables calling uffdio_regsiter with the flag UFFDIO_REGISTER_MODE_WP. The
kernel ensures in vma_can_userfault() that if CONFIG_PTE_MARKER_UFFD_WP
is disabled, only allow the VM_UFFD_WP on anonymous vmas.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index b9b6d858eab8..2601c9dfadd6 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -419,6 +419,9 @@ static void parse_test_type_arg(const char *raw_type)
 	test_uffdio_wp = test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
 
+	if (test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_UNPOPULATED))
+		test_uffdio_wp = false;
+
 	close(uffd);
 	uffd = -1;
 }
-- 
2.44.0


