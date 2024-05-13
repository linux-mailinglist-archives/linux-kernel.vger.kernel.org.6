Return-Path: <linux-kernel+bounces-177505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E208C3FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE321F22A41
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C514C5A1;
	Mon, 13 May 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KekUXzHc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810914C584
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599986; cv=none; b=Umt7wDCaYkPMLcFiyeeVLtNSTyAOICYyqeENx34FLwUpepJyevGKQSbs/FWitE51nr7msJ5VqHmgzMPRImBaobt+dJXV1b/c7m/2iqILeEtznqMp+wdb9RdVKj3DkbHLdiGdqASrbqlaSV1Do50ywc9DIXOYd6IO1aLphOE9NQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599986; c=relaxed/simple;
	bh=0k5DBiev6Hez4iRlP0Z+hV0EZ/1rw9D59hE5bmw14XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbaKQ999v+iYf8GbDR7zL1bG544nwFBlgdaWzSR5HL4icjPwsY3gBPleNQksB1ezVvKZQ7GIwj/0cRoM929prBZ5aHIK6my+//V7npJ5woJ50sNh0X2xqMfTMu2skMWBjEgdx1h6Ung8+l5Y2T8fQzCq0EtmaSdw+JGhNSgicEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KekUXzHc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715599984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=54evBAuhpnIbgDCbHAgBJwdKwEdND6gn70BNk2pLCuo=;
	b=KekUXzHcLmvOQDNh7PXtS3qLl5XDYdKHpt8kcItRCBA90QLgDiuZ2fJD4ZcDG5DoqrYeTi
	nTrGIbEyPiCREMOx8m1L8UxzwrfZgGPnHPck/a022rHgPAzvBxquKmOWNbKTsJQhYJzP0x
	U47aZULiqyUcov2hBGBPKSMM8/kcR/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-b22GMANPMli0g95TKxwUrg-1; Mon, 13 May 2024 07:27:02 -0400
X-MC-Unique: b22GMANPMli0g95TKxwUrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3D328025F9;
	Mon, 13 May 2024 11:27:01 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6AC691C00A90;
	Mon, 13 May 2024 11:27:00 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>,
	Jan Stancek <jstancek@redhat.com>
Subject: [PATCH bpf-next] bpftool: fix make dependencies for vmlinux.h
Date: Mon, 13 May 2024 13:26:58 +0200
Message-ID: <20240513112658.43691-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

With pre-generated vmlinux.h there is no dependency on neither vmlinux
nor bootstrap bpftool. Define dependencies separately for both modes.
This avoids needless rebuilds in some corner cases.

Suggested-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 tools/bpf/bpftool/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index dfa4f1bebbb31..ba927379eb201 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -204,10 +204,11 @@ ifeq ($(feature-clang-bpf-co-re),1)
 
 BUILD_BPF_SKELS := 1
 
-$(OUTPUT)vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL_BOOTSTRAP)
 ifeq ($(VMLINUX_H),)
+$(OUTPUT)vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL_BOOTSTRAP)
 	$(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) btf dump file $< format c > $@
 else
+$(OUTPUT)vmlinux.h: $(VMLINUX_H)
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
-- 
2.44.0


