Return-Path: <linux-kernel+bounces-528513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBEBA4187D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7964C18989BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE279257AD1;
	Mon, 24 Feb 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIzOAyNR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47024A06E;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=LBs4QqaRTP3IOk889nmHp7VvOBdyhG4CymyJgkXrPg1H7S1yUifsSMp7MAq9aIJKJ0+6pGKMutV8O6VOFc2KWyLuEuOW5IINWZoxw9uk39ZCu0WHe+9GUVvqHbtGhh1ra0j9DxILXYZkNNeZnKgRYctvjPV83TzZ6xOtLFGKUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=eHvxtpg5BcZjO8Wx7MxCSiuYJ025kjhp7csGrstaq+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOBZkuGP9CiFVM/FUjsSHVCtLqIGnsl/e56Ov///WFN1Fv8VYkYjes3rAdMnwIHdUL0q5AYz0RjnN+jg0lG7edIZtOGSm3DpKECMeeh/p5IaQ5n8BjhwvhCaQ4h4EdFPeePIQDuadUhVMsSyHOnGgVmh6EpuloW1xYkoqIDJgwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIzOAyNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1D1C4AF0F;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=eHvxtpg5BcZjO8Wx7MxCSiuYJ025kjhp7csGrstaq+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIzOAyNRO8+easKwXcS05uOtYtJnTHBBWFLpiNlAs5UvytYWn6cZO3Y7bhVyqHISa
	 7JFlcLRh36k3qyfkOCV/ppnxcZV7+4HEozZc+/iJmCLfo+HFVwAwC3bpZM6bIOvi++
	 9Llc/UNSaAwYTzXUCweyEqSwCuhoN+L7k5i3z8j15Yhz5YkVsWmkDR+tdoaEJ66zOY
	 uluvw/17fyFLIfdacYYSnQSrk3nlVt1mowzH8Zavcrcv88phRfWuKP1aycO2kWhVe6
	 MduYoApakXGUUEK8+Fj1Jw8SnvXzQU/2A5UVZf1V5VTA78Vn8WFb5D+XqyUz0cavh6
	 lHZ0xvNr9StNg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p56-25Ff;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/39] docs: sphinx: kerneldoc: ignore "\" characters from options
Date: Mon, 24 Feb 2025 10:08:32 +0100
Message-ID: <3f2738d2e077232f5ee4c7a9f15ba6a59bdeab72.1740387599.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
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


