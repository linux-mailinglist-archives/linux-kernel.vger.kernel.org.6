Return-Path: <linux-kernel+bounces-521697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FA9A3C0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9114C189C985
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A71EFF81;
	Wed, 19 Feb 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPQ6QDDo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108AF1E8347;
	Wed, 19 Feb 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973480; cv=none; b=GA6oW7B2Afwgar3a3D8vpwdCkEenhjqlgGggA4Anh6+GkkMXgk2pEWna1Ncz/+imHSDXRCE9sQA3pkQ2vmUHV758uuATZKuXT1/3r3RBJu1//OKj6vs2kZQoWiVznL2ZngDHG3qTZf56VBL1AeByXbRgdPVplwX+yOzbqFUG8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973480; c=relaxed/simple;
	bh=RPy+c9M9XnSF7fnvH42jTZeZw448FaaVZdh7+FOlT+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8rAe14WjcxPaiZ07CzXxOkaWmhELZw4aAr/IKFdPMeg0e0XoNykqst34Oy2t7jsNmG/9D8WgdmzDp0pAqUas6Yz1B0EqTERFNO99PROOCRD2Q5hK5Uq3ck5xIq2ChLbL1b7nC6mEPSKOADepE9smELrOFHSNlPnx68h9iTE2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPQ6QDDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AE9C4CEE0;
	Wed, 19 Feb 2025 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973479;
	bh=RPy+c9M9XnSF7fnvH42jTZeZw448FaaVZdh7+FOlT+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPQ6QDDoZ4F1MXQEUy+Z+h7yDNVxu5v2g/DwNCiQRC7YwmbivCptds62RpRUt/JZc
	 PaO4rASQMvfsLoKX5babgf2we+TfomBqsuKmne/dgOzvT5yPICoM17FLMOt+M9J4Lj
	 20ayGoQMOHsbl2p24vgwkP0HnNM3v7lo5cZeiqYz2h0wg4b60cfBezn0ebCOnDWmLy
	 UzXq0zjpxHUEFXXIk93N7JhDxkpI/u1eLEqWijsXHyjX+2uw36cEXZTKRH8oEkvhPy
	 Ke+ME7zAttBxFjyDSzq3ma36/nCD6HUSPXj35OG1z/WPP/VfJT29949cg+wdLbWvrC
	 IOAXbQcpkkVQA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkkaL-0000000H1jF-0Zk9;
	Wed, 19 Feb 2025 14:57:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] scripts/kernel-doc.py: Set an output format for --none
Date: Wed, 19 Feb 2025 14:57:36 +0100
Message-ID: <465a4660df470b214aec6abe1b2b931781ef2122.1739972906.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739972906.git.mchehab+huawei@kernel.org>
References: <cover.1739972906.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that warnings output is deferred to the output plugin, we
need to have an output style for none as well.

So, use the OutputFormat base class on such cases.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_files.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index c215ae3047b8..957aaeaed7e6 100755
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -19,6 +19,7 @@ from datetime import datetime
 from dateutil import tz
 
 from kdoc_parser import KernelDoc
+from kdoc_output import OutputFormat
 
 
 class GlobSourceFiles:
@@ -137,6 +138,9 @@ class KernelFiles():
         if not modulename:
             modulename = "Kernel API"
 
+        if out_style is None:
+            out_style = OutputFormat()
+
         dt = datetime.now()
         if os.environ.get("KBUILD_BUILD_TIMESTAMP", None):
             # use UTC TZ
-- 
2.48.1


