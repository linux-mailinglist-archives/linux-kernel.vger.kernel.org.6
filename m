Return-Path: <linux-kernel+bounces-528512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB90A41886
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B42C3B6F72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3410257AC7;
	Mon, 24 Feb 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ8IKALf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22424A070;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=PjK9G5RExRFmINlFreAqHFoA5Fqbedsc23vdLT2oQy3SY/Do5TDdfj2NK2RutBlO0piN3CTSXriJUKgWnuremEYzbwMoV2KahWmdpJ4MvpRkY/jkWj53ILCX4A/0O0xtoARTvemoWve71ujcSPfx+xA/4T8YtHR0Vw/5mav+sRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=RPy+c9M9XnSF7fnvH42jTZeZw448FaaVZdh7+FOlT+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkK2nwwwFuzUEncBbwmTYVP0Z1bKSIklSRNciX6Nm8RM6QPVe4ALcFWtRO2pHhvEHXqZsyuKBmzvjUAwIBTtv4bq2E0XiIDmS+S1gSQ9knK3l2lvD9SfUQal+TQS5FAZX9t22wEmcqompVBqoZo+mac15cL9ChYzGMPQRhtKUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ8IKALf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62551C2BCB5;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=RPy+c9M9XnSF7fnvH42jTZeZw448FaaVZdh7+FOlT+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZ8IKALflLotBxCoEeyv2AbjhjosmzsfIY9bKWgjxDYBsYNB+GB0zQ3cJrZW7IuVa
	 7QgQ3JgO3hNPaJ/s0xz22XkXG1toLR2S7wUL9bBj/NQufW1cj9Yq8rpAq3D7/064hn
	 FVofkdkWRHG1CBDspmhj7arlreXGMAwgyYwmHfQMnfHj4GcYeUur22p1TJtwi2Ab+0
	 J0fgpN8DYHWMSWcZSiTlmCmDy2LHTBQ59+67akbb6AGv/TynfqebfAXUx/9SkKx95b
	 2IsKdPVvddl+vRV3HMmmNeR2PoNPcFfR6vK+POJQ1xdtNQiO2XBA7xNIEu6js48Ypw
	 momNAPq+0wdhQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p5E-2J2i;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/39] scripts/kernel-doc.py: Set an output format for --none
Date: Mon, 24 Feb 2025 10:08:34 +0100
Message-ID: <8c4b7ce0e79c20d6b5804e6e3cb86e3d47fc09f5.1740387599.git.mchehab+huawei@kernel.org>
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


