Return-Path: <linux-kernel+bounces-528518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BAEA41882
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A16188045C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F962580E9;
	Mon, 24 Feb 2025 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUueVpxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881824BBEA;
	Mon, 24 Feb 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388144; cv=none; b=hnwJAkkvnEJoZ9naJf+eAw2uDfYdQDKTSnx8smHPJ3U74PHkYhQ/q+KTbzJwKni0cZZdmhq7JQ6yx/L0XEYMRT/etDKkIMXEHeTrTw/+fuDJ1ot9Jvu23rCekp1HGWbsUIEAN7Z8YO82POPHIF2a0zUQttSuVEGqrfDLwPyZv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388144; c=relaxed/simple;
	bh=rBaRLeMqhVMdPKl/arUfcC4DaRWWHoHCgWfY19slLGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxzQhqnyMXwj/KCbDJC7kCc4aR0VIxFawn7TvehW3GcrP7kej2fJQixOKPsb7sp7LDMPiUgFwvoAwuK0m2+KN/fRy25EmI8qVYnGvHk9RYN4pTstYkKx2hBZ8CS9iEf+mLj2SBdQtQJaLL0S7vNteffpYyEpI4w/ZwAnxskMy7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUueVpxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A1EC2BCB7;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=rBaRLeMqhVMdPKl/arUfcC4DaRWWHoHCgWfY19slLGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUueVpxX+YhqcRo5mGSCQWROzC9oMicdHC9DsZo7F1Ux8VixS4k5lCNh0osv59C/L
	 Td9csDXGroKJHNHSaVqCCAhHA5tUbUoq56hJAnOrlKy0SCgONDrfCzblGzyiu+Fr0k
	 ojoKxUww1Osbc3TzH1V469leXdi3zhS2LOlccsg8WYXqnqvhlgi4rZncGUrSCCen7q
	 8zOmX77kbm21T1rtVejw7YKhxGSPtgZVfqCxMewz8zcKQQ1Bq+YBqwqmzPsdl7Nzv9
	 ZwXq3utZEDIg3kKRiWnxQK+v3JE+OvkUCKxQaUBKub50Cmuv9KTDHp3E/NkYlQj7TP
	 amgAVv/jn9JEw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p5b-2rRH;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/39] scripts/lib/kdoc/kdoc_parser.py: remove a python 3.9 dependency
Date: Mon, 24 Feb 2025 10:08:39 +0100
Message-ID: <e2804a98ce0fcc4208f091615004864df0ed4971.1740387599.git.mchehab+huawei@kernel.org>
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

str.removesuffix() was added on Python 3.9, but rstrip()
actually does the same thing, as we just want to remove a single
character. It is also shorter.

So, use it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 0c0fa10b942b..feac699a3893 100755
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -1652,7 +1652,7 @@ class KernelDoc:
                     # Group continuation lines on prototypes
                     if self.state == self.STATE_PROTO:
                         if line.endswith("\\"):
-                            prev += line.removesuffix("\\")
+                            prev += line.rstrip("\\")
                             cont = True
 
                             if not prev_ln:
-- 
2.48.1


