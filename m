Return-Path: <linux-kernel+bounces-528506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 568CAA4187C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3931898068
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35625745C;
	Mon, 24 Feb 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxmuszss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B629024A054;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=mX02FZO0NJYZAiIy/fSC9IJ9Wzn8UUH5EQYxqoOuO0nFuhukELykUZjdKeTb0Obe0LapESqkw8mVXifwvoTWQfVmZR4gmKNgwOQX9/VTIrIWAwnizr0F2hIezqFdKy4lCKmUgE2lv7AXkdmGMCmXPRXLHuthXaXMIXIbMeobxqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=pOTBzlS7I7jZeyW/hygW6cvMdWH+uYsFy5DDt8PknnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyNv4M4DMtD+//J1KjmOvgGQZr6Dw61fL7RUoMa2yOdFjawL41ryARl/Gz9XiYbkbWlzsrFXmA6UirWIW3++peNMYITHPjLH/pFG/mCaeEwPuo1NchMnlSEz1HImIFRBMWse+bWw7QU3tIdPOjNoPsIqyYwSK1Cd9i2fLNM/LZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxmuszss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D21C19425;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=pOTBzlS7I7jZeyW/hygW6cvMdWH+uYsFy5DDt8PknnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxmuszssznMv7P7YOO5J8q07gJP6bvjuQVxOGVT+x1T8N4nbPfZkqeu3nl/MNG8IP
	 6QcMq8c1Cty1Q6QJh0USRlw/M633YR4lJpHAL2h7uv2rn+01lH8V9cLB9/CmW3PMCr
	 1Wl8EL+UVm5ATsHK3QsvZBJ0lE8m70EqlPURMHI3WDXkfzKikPeGghd8dQgrOGBv/a
	 +t1ev3eXLYKoSQL0mCsf5e2eeDIexm7prTzjgr5UVjChCLbPgwxzwFX9qHQ6YYJS2I
	 eXGd66ikQBcAWYpTuYCEJBrvu0F7vY80MtuJ+eiHzlMYj7kvFyCiRQh2N5eMXlI2vb
	 R9MflnkJTB6kQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p4y-1rQR;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/39] docs: add a .pylintrc file with sys path for docs scripts
Date: Mon, 24 Feb 2025 10:08:30 +0100
Message-ID: <184b5b90b3ee06c50c05888b5df82abac4ea7ee0.1740387599.git.mchehab+huawei@kernel.org>
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

The docs scripts that are used by Documentation/sphinx are
using scripts/lib/* directories to place classes that will
be used by both extensions and scripts.

When pylint is used, it needs to identify the path where
such scripts are, otherwise it will bail out. Add a simple
RC file placing the location of such files.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .pylintrc | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 .pylintrc

diff --git a/.pylintrc b/.pylintrc
new file mode 100644
index 000000000000..30b8ae1659f8
--- /dev/null
+++ b/.pylintrc
@@ -0,0 +1,2 @@
+[MASTER]
+init-hook='import sys; sys.path += ["scripts/lib/kdoc", "scripts/lib/abi"]'
-- 
2.48.1


