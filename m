Return-Path: <linux-kernel+bounces-521111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B88A3B440
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDA11765DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90FA1E22FD;
	Wed, 19 Feb 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny4sZzWe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9EF1DE2A6;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=evCJ8c3vwIY8bKyKTcLvccDc633x4HJSdk5dzIlKPf4dETl30Mn4uNzoCxPg9XU5n17K7d9aCthBRsJqeNwGqn7phADSsOYsvXWERAtS2SJj2uxrcsa9ZWNFPnhyd2/wtiQ8UXZFjOKHkE+isR52ciPvzBn9dAGoq1IpiBuRla0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=nv2FWo3LGyCll6dWzmoWsroR9XM0kzMdOA2DYqUHwCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzkTrmeHyWpzZBEVvqim+Wc9G4P5qDJPJAgq1qLDVwA5fstgMC3g1WrrUY20LfY9wAdU+/NSXsZAbnHMWYy6GWTrlOKTCs4Mlpqwp6tGCbG7D9MNM8F4B/QAMayu7ejCbX6yLT5fLY3mUREvmNEWhTJ8R65FWRW536exPKZ4naY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny4sZzWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F50DC4AF0B;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=nv2FWo3LGyCll6dWzmoWsroR9XM0kzMdOA2DYqUHwCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ny4sZzWeUa7F64amtQrSA95MXHPF6R9tuqquIp1pwYt/84v+gouX65xMFltlGgbe8
	 FwApyZpv+/7W/ApoAumLjoy97R1VRf6byNrf+H1Ngp1lBO+FYCyTlZbWj3M2iGbjb0
	 bVf3j+dqN6Gzyr3b8BlmHJUwps2zYywmXqlXTpLTai7B3g2TYMkhu86zOtOWgRC9qI
	 lUKoaHMEzZfMjwa4mllcggFGvtSSJN0HxUIPS6WIRUBCDwaPoWGnYqHQwG3zESPgyM
	 h+g1RjdlahRj4Xb5TeKnKQM0PxYhaxlIxqZk7/BchEvgnCXUnXYcvTj01GqQuZNFVl
	 aYGf7YoLEMTXg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv61-2kKE;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 27/27] docs: sphinx: kerneldoc: use kernel-doc.py script
Date: Wed, 19 Feb 2025 09:32:43 +0100
Message-ID: <f84a14d5f339f871fa2a8c91b6a7a26fce140eb5.1739952783.git.mchehab+huawei@kernel.org>
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

Switch to the new version when producing documentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 2 +-
 Documentation/conf.py  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 63094646df28..c022b97c487e 100644
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
index 3dad1f90b098..b126f6760b5f 100644
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
-- 
2.48.1


