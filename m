Return-Path: <linux-kernel+bounces-521112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4F6A3B44B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D21189C21D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205B41E260D;
	Wed, 19 Feb 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvuZwJBK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFC1DE2A4;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=AtkKB/qkclfa1NaJ+n4w9gVh9xMx38AGUx3ejeAYiKmv021bU4NKPaKEqqURwNe8kdRc8kOqA9jabI6iQsABWGpRgqoSyg05+USH/WCYgG/mZTZv1/aloaJ0NQfpEOKyH8UV/sNcvPFd2QRYKJSGx0i3AffqykalrKCRs3R0mcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=eHvxtpg5BcZjO8Wx7MxCSiuYJ025kjhp7csGrstaq+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvIvOQnlp/Orn/XDb+0zauVlEEJLOgaopv5ItqiRu0/kx4dZ9DASCTdqNhFTF1NGfat8NHl4iKiptQv6tu22xa6O/RFuO8x3MoHtVdKySXQsvlUNNJec+rSk6zGzdk76uQH/sPTcJ5TVeeiO8aEDO49CrXPkiqk097DFnpuLcK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvuZwJBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92717C4AF0C;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=eHvxtpg5BcZjO8Wx7MxCSiuYJ025kjhp7csGrstaq+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvuZwJBKY+BCzjgyroayxTnMc6oSdlqSxsWIrQN+aYCvuZZpZ+xpiKstXge3ahodk
	 i9dn32GHBiuRwuYalcjI9phMhk7hLgnNEpgeLB8D2V1lvnCd+q+TxVGXKyiQBaOnKi
	 oCnVvUohqCM49/1JgIo+77cDITxMfJH78UquydhU7z3KsKMSifyQeh3P0zyg1Z0Abe
	 63USo3EgCKKBHKJrfMxFtFKsXvBh7RsTl9Msda397lsRQB6KgsgYYxmQSBVzl6E+AJ
	 gGabKFZ1wectFQAJRrX966r39LPP6aZY8uBCg2A6OtaKTcJYL+7zvG6e3EFhhUlEkB
	 vvOru2BUJwXCw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv5x-2dXe;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 26/27] docs: sphinx: kerneldoc: ignore "\" characters from options
Date: Wed, 19 Feb 2025 09:32:42 +0100
Message-ID: <f1275ae418f52d6046c1f49f6f88fabec4587c8f.1739952783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739952783.git.mchehab+huawei@kernel.org>
References: <cover.1739952783.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Documentation/driver-api/infiniband.rst has a kernel-doc tag
with "\" characters at the end:

	.. kernel-doc:: drivers/infiniband/ulp/iser/iscsi_iser.c
	   :functions: iscsi_iser_pdu_alloc iser_initialize_task_headers \
	        iscsi_iser_task_init iscsi_iser_mtask_xmit iscsi_iser_task_xmit \
	        iscsi_iser_cleanup_task iscsi_iser_check_protection \
	        iscsi_iser_conn_create iscsi_iser_conn_bind \
	        iscsi_iser_conn_start iscsi_iser_conn_stop \
	        iscsi_iser_session_destroy iscsi_iser_session_create \
	        iscsi_iser_set_param iscsi_iser_ep_connect iscsi_iser_ep_poll \
	        iscsi_iser_ep_disconnect

This is not handled well, as the "\" strings will be just stored inside
Sphinx options.

While the actual problem deserves being fixed, better to relax the
keneldoc.py extension to silently strip "\" from the end of strings,
as otherwise this may cause troubles when preparing arguments to
be executed by kernel-doc.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kerneldoc.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index d206eb2be10a..344789ed9ea2 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -118,6 +118,10 @@ class KernelDocDirective(Directive):
             identifiers = self.options.get('identifiers').split()
             if identifiers:
                 for i in identifiers:
+                    i = i.rstrip("\\").strip()
+                    if not i:
+                        continue
+
                     cmd += ['-function', i]
             else:
                 cmd += ['-no-doc-sections']
@@ -126,9 +130,17 @@ class KernelDocDirective(Directive):
             no_identifiers = self.options.get('no-identifiers').split()
             if no_identifiers:
                 for i in no_identifiers:
+                    i = i.rstrip("\\").strip()
+                    if not i:
+                        continue
+
                     cmd += ['-nosymbol', i]
 
         for pattern in export_file_patterns:
+            pattern = pattern.rstrip("\\").strip()
+            if not pattern:
+                continue
+
             for f in glob.glob(env.config.kerneldoc_srctree + '/' + pattern):
                 env.note_dependency(os.path.abspath(f))
                 cmd += ['-export-file', f]
-- 
2.48.1


