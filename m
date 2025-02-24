Return-Path: <linux-kernel+bounces-528511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669AFA4187F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E261162F87
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE05257AD0;
	Mon, 24 Feb 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="al+Zq2Id"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51524A06F;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=kWOj8I60jeNLR+IDoFaFg14CI3pb6v0nYK4lhfu7TbWIt2xp9JfRXi/AZAWADmKSUiRk5YLsEiFyuyf6+frsqycTO/FKwT7e2Mpiyl/LILGYs0GReLjfuycujqiGnJCC1EvjgUDe5xlhwg4lgqlKgr8FDvlryLk5xKc2Dy3pWx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=nv2FWo3LGyCll6dWzmoWsroR9XM0kzMdOA2DYqUHwCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EriE5YuF1IHSV0nqgwiGBOKsYw2IK8akdYS7x6pUGImMpwqFInqO5JmCnTrPfjcCGn4ss9o/8RQYf0VWtkFGbaAJIRaeh6vHlvF7yvZvrCKf6jMAdJ0eWZQ8r2wvkKW0JFwlVgWzdZOWok98Hm8tzv5CTtBKyeD9cDb9z4pArhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=al+Zq2Id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB1BC2BCAF;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=nv2FWo3LGyCll6dWzmoWsroR9XM0kzMdOA2DYqUHwCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=al+Zq2Id6hZVKqX6SFl78E7mwKEUDlYGzUQ751uJ5CxgoxU1b8tM7dSa1cQQSbmIR
	 YcZCatMiC/qnIJSlaOlBtfkJBtDwK4tqZ28GGV3n2sCLQ5NcEFqadt7zH8w3cicJo9
	 v+yT7VQbObQvYWn3nhfE7jgq4xhL+Xmnl6KnyEKmElWRNTLeRnRKMhfC1gB4era1zg
	 l65LQFizPFyTCtawJkc3Ki3hIQ0tDB1mxSZaU3FCQvWB3loYcLqeF1Yyz9gw577cNs
	 D/9F2yja4dTV5SQUpTMbbvZO5PuRqHxQct9CRaK5MiT5FIDkKZ1DNvdTVFACBPSgCO
	 vDZr/pgpi/jfA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p5A-2BzD;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/39] docs: sphinx: kerneldoc: use kernel-doc.py script
Date: Mon, 24 Feb 2025 10:08:33 +0100
Message-ID: <c5d81e54daae8f69c924499afaf74740b6de1041.1740387599.git.mchehab+huawei@kernel.org>
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


