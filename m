Return-Path: <linux-kernel+bounces-361812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBBF99AD49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B3028205B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F901D0E30;
	Fri, 11 Oct 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wq3EwDci"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B251CFEB8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676834; cv=none; b=TUFOYcTueUn28g9mtoPlW9mjqRXeUINK20dnMdYgjXSMCMUE1xk4Ba7ifKZ4PLEAQxwo29F/M2oZZT/MkEuVupdCabYTmAubQNkIgiwWhMjs+hcxstZEABNHLKfuJ5Ac12GWvMTYNkmpaCTqUGbXW0kxAZ+Nw4zG/lsCA52s9/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676834; c=relaxed/simple;
	bh=DuKDDGu8TSkmXBzAtZnzPczE056d+qxUX2o57Q9dSfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WiBE++rO4pKxc51Z7joN3YW5iZYUZxNcb37bLQZ4fWqOzrp08V8Rja9NxvZwtRbMBEpNmaVsbhsD2ticE14RsheJXLiBogffTlDcTZrGvEZG5MMPb0EWQrAXLjef9M+ySwh7qqqhvFDKwFs0bomHXb1eintPvAGdem4WAXMnLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wq3EwDci; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728676831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dbQgie+An3FsfT7/2xbvqwyjDp2Yp9ZZ+SvdAmcNQdk=;
	b=Wq3EwDciPHBtvaLnTfG3SOWs4UDu/iygxMa/wa/th6f8aBfZATs0qa21zadqheEECybFxD
	zW83zPMSBAhaoB1dI8QB6ZkeIOfz/hyPLAjkmhe91KtM6OMuoBoijyaHE58LPAyNtuDQgQ
	yz1s/M75Z9plhbKoumstcESpoCvbUzc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-8Kc4tQLzOWuFz6q9bkeosw-1; Fri,
 11 Oct 2024 16:00:28 -0400
X-MC-Unique: 8Kc4tQLzOWuFz6q9bkeosw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E7091955E85;
	Fri, 11 Oct 2024 20:00:25 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.39.192.233])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 233ED19560AA;
	Fri, 11 Oct 2024 20:00:17 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	acme@redhat.com,
	vmalik@redhat.com,
	williams@redhat.com
Subject: [PATCH] tools/resolve_btfids: Fix 'variable' may be used uninitialized warnings
Date: Fri, 11 Oct 2024 22:00:05 +0200
Message-ID: <20241011200005.1422103-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

- tools/bpf/resolve_btfids/main.c: Initialize 'set' and 'set8' pointers
  to NULL in to fix compiler warnings.

- tools/lib/bpf/btf_dump.c: Initialize 'new_off' and 'pad_bits' to 0 and
  'pad_type' to  NULL to prevent compiler warnings.

- tools/lib/subcmd/parse-options.c: Initiazlide pointer 'o' to NULL
  avoiding a compiler warning.

Tested on x86_64 with clang version 17.0.6 and gcc (GCC) 13.3.1.

$ cd tools/bpf/resolve_btfids
$ for c in gcc clang; do \
for o in fast g s z $(seq 0 3); do \
make clean && \
make HOST_CC=${c} "HOSTCFLAGS=-O${o} -Wall" 2>&1 | tee ${c}-O${o}.out; \
done; done && grep 'warning:\|error:' *.out

[...]
clang-O1.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
clang-O1.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
clang-O2.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
clang-O2.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
clang-O3.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
clang-O3.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
clang-Ofast.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
clang-Ofast.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
clang-Og.out:btf_dump.c:903:42: error: ‘new_off’ may be used uninitialized [-Werror=maybe-uninitialized]
clang-Og.out:btf_dump.c:917:25: error: ‘pad_type’ may be used uninitialized [-Werror=maybe-uninitialized]
clang-Og.out:btf_dump.c:930:20: error: ‘pad_bits’ may be used uninitialized [-Werror=maybe-uninitialized]
clang-Os.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
clang-Oz.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
gcc-O1.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
gcc-O1.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
gcc-O2.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
gcc-O2.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
gcc-O3.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
gcc-O3.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
gcc-Ofast.out:main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
gcc-Ofast.out:main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
gcc-Og.out:btf_dump.c:903:42: error: ‘new_off’ may be used uninitialized [-Werror=maybe-uninitialized]
gcc-Og.out:btf_dump.c:917:25: error: ‘pad_type’ may be used uninitialized [-Werror=maybe-uninitialized]
gcc-Og.out:btf_dump.c:930:20: error: ‘pad_bits’ may be used uninitialized [-Werror=maybe-uninitialized]
gcc-Os.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
gcc-Oz.out:parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]

The above warnings and/or errors are not observed after applying this
patch.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 tools/bpf/resolve_btfids/main.c  | 4 ++--
 tools/lib/bpf/btf_dump.c         | 4 ++--
 tools/lib/subcmd/parse-options.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d54aaa0619df..bd9f960bce3d 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -679,8 +679,8 @@ static int sets_patch(struct object *obj)
 
 	next = rb_first(&obj->sets);
 	while (next) {
-		struct btf_id_set8 *set8;
-		struct btf_id_set *set;
+		struct btf_id_set8 *set8 = NULL;
+		struct btf_id_set *set = NULL;
 		unsigned long addr, off;
 		struct btf_id *id;
 
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 8440c2c5ad3e..468392f9882d 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -867,8 +867,8 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
 	} pads[] = {
 		{"long", d->ptr_sz * 8}, {"int", 32}, {"short", 16}, {"char", 8}
 	};
-	int new_off, pad_bits, bits, i;
-	const char *pad_type;
+	int new_off = 0, pad_bits = 0, bits, i;
+	const char *pad_type = NULL;
 
 	if (cur_off >= next_off)
 		return; /* no gap */
diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index eb896d30545b..555d617c1f50 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -807,7 +807,7 @@ static int option__cmp(const void *va, const void *vb)
 static struct option *options__order(const struct option *opts)
 {
 	int nr_opts = 0, nr_group = 0, nr_parent = 0, len;
-	const struct option *o, *p = opts;
+	const struct option *o = NULL, *p = opts;
 	struct option *opt, *ordered = NULL, *group;
 
 	/* flatten the options that have parents */
-- 
2.46.2


