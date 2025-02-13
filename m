Return-Path: <linux-kernel+bounces-512880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5BBA33ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410793A30AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5B1221575;
	Thu, 13 Feb 2025 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmrPXy85"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08F21D3EF;
	Thu, 13 Feb 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448388; cv=none; b=gIBtgA4/BMKkeaxBWhDLITLKnjSri2jpf2XOZ7deS9BrVRX2uBz1WeJk7QWqr7Vp9vzJu+RmaclPffHifxe5kEz/tx1EZvWfa/K24XcloWOJ1krV8XnI/PTCAEMazLWDOntABg5/fXi4b8weFKdaV3O1zBhwJW2C9bPU7RYoWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448388; c=relaxed/simple;
	bh=hlPjUyTzbn/CpVeUfGXZ6ojH2AiMhs+zPylzYlG0MLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XukvjZ4qhHRhz1VFnXjsC4BikdD0eljZB5wGZRxHgewMuIozGFRzyHKc1C20EtLO327kP73neXKZp7XKx3wII2oIwBYlzZrXM/j/kCAvEiYQYvG+7D/ped7niLZmPvj9urC+BoGQYzSDec+thhb1jmVfBGnlfH5NKX9HLY5PX6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmrPXy85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5C0C4CEE2;
	Thu, 13 Feb 2025 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739448387;
	bh=hlPjUyTzbn/CpVeUfGXZ6ojH2AiMhs+zPylzYlG0MLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OmrPXy8576+hCzdAghdtJzOZY9/yQAmrqg4hEvurF0rlOms+FPLOvsmfhVRFddzv4
	 IJWu30zSiX0gHWkaFdOQhedSWiFkGwk4crdShaRMkA4SIYNbaqnWV+rDma+hUES5nd
	 tDrhyF6XWCkjAahuyvjhD0UeCZjpqYN4sYf42ZyDeyycaTIhVBIS9DW1fkFC8Mki+0
	 RfE8gbcpLNFrqb/9QMTeKTxfAvl6d5h03gfX/SITQsk5jJ4ScOgoIDPwU2oO/V/Ffi
	 g8c8GFMZlLywu2kZh0zb3IQQgEu5cgTovKunMJ6LoV8PO182BWnbToFM6iSk6nNNvC
	 s2fc+hPOTPUTQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tiXz7-0000000BIVK-1q6H;
	Thu, 13 Feb 2025 13:06:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFCv2 5/5] docs: use kernel-doc.py script for kerneldoc output
Date: Thu, 13 Feb 2025 13:06:18 +0100
Message-ID: <3e6c607ac65550036f743cb5daf8e8c524515e0b.1739447912.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739447912.git.mchehab+huawei@kernel.org>
References: <cover.1739447912.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Switch to the new version when producing documentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile            | 2 +-
 Documentation/conf.py             | 2 +-
 Documentation/sphinx/kerneldoc.py | 5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 52c6c5a3efa9..a35de321b084 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -60,7 +60,7 @@ endif #HAVE_LATEXMK
 # Internal variables.
 PAPEROPT_a4     = -D latex_paper_size=a4
 PAPEROPT_letter = -D latex_paper_size=letter
-KERNELDOC       = $(srctree)/scripts/kernel-doc
+KERNELDOC       = $(srctree)/scripts/kernel-doc.py
 KERNELDOC_CONF  = -D kerneldoc_srctree=$(srctree) -D kerneldoc_bin=$(KERNELDOC)
 ALLSPHINXOPTS   =  $(KERNELDOC_CONF) $(PAPEROPT_$(PAPER)) $(SPHINXOPTS)
 ifneq ($(wildcard $(srctree)/.config),)
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 0c2205d536b3..655be15267f0 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -540,7 +540,7 @@ pdf_documents = [
 # kernel-doc extension configuration for running Sphinx directly (e.g. by Read
 # the Docs). In a normal build, these are supplied from the Makefile via command
 # line arguments.
-kerneldoc_bin = '../scripts/kernel-doc'
+kerneldoc_bin = '../scripts/kernel-doc.py'
 kerneldoc_srctree = '..'
 
 # ------------------------------------------------------------------------------
diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index be5b8fbf373f..39ddae6ae7dd 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -62,11 +62,6 @@ class KernelDocDirective(Directive):
         env = self.state.document.settings.env
         cmd = [env.config.kerneldoc_bin, '-rst', '-enable-lineno']
 
-        # Pass the version string to kernel-doc, as it needs to use a different
-        # dialect, depending what the C domain supports for each specific
-        # Sphinx versions
-        cmd += ['-sphinx-version', sphinx.__version__]
-
         filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
         export_file_patterns = []
 
-- 
2.48.1


