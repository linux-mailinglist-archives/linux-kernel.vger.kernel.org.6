Return-Path: <linux-kernel+bounces-521701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52541A3C12A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C72C17B2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA651F4169;
	Wed, 19 Feb 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngStJ/MV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34F1EA7FC;
	Wed, 19 Feb 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973480; cv=none; b=pGseD1XKjRoYNnGBzZtszIe21YT1PWi6m9GVV1SStu+XPkmNnfumvoCKlhoyqyk3ooAPlIe53NJrHUM/dowVxfbAu87i9r5MItwkPswjU1MLE4fouexeVz2juPc8ZrZlKZbAgpSbXlAnVJ29GIEN6G9iVrqsFQ1acKk3NlPm6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973480; c=relaxed/simple;
	bh=rBaRLeMqhVMdPKl/arUfcC4DaRWWHoHCgWfY19slLGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emobX3N31yM2Xy0V9GWCsV0q9B8ho2yGCgAJQD/wnVY/P05vcxbuq46FoQlN4ljvbA2DTtLGnW5YnF/hzYdeDmLTGdRWNjMl26HzrZsxNL1MLdwNOQO+mMHtTj5suendKsbMtNv6J/KtQK3crBbo+b8GHVMrBHQH48YIETWxBkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngStJ/MV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB49C4CEEA;
	Wed, 19 Feb 2025 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973479;
	bh=rBaRLeMqhVMdPKl/arUfcC4DaRWWHoHCgWfY19slLGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ngStJ/MVsUwnkG7aIg+T+X+o3GoSHfSNzrOip1z+EmcxYkJiXNFNtFfghK/1qT3if
	 sQ1FjimRwzDNAHGLKVAtsOkvqH0WnU9LReVEL7gTm7pgKZt7qH2lEkmyV9xwrzRjCK
	 7661RYghivpATmEdbfaQ5ZPIJ6fcmaxkpWwzp2kSQ9ec8S2rGPI20JFcfR1yL/oXMo
	 H+XrgpUSD6z8eX1vD5+nP3QtH9rLTh3d3iX39oITvKDe2nr9hrZEsc9FcU5+AHYlDE
	 h8o2ilVl4Tsp73oILLz3u4rbonDzd9yJsLCcmpPql/4BRWsJxMvBQ8PdXdIp91sfEK
	 kulRxchBWdn3w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkkaL-0000000H1jZ-18Zk;
	Wed, 19 Feb 2025 14:57:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] scripts/lib/kdoc/kdoc_parser.py: remove a python 3.9 dependency
Date: Wed, 19 Feb 2025 14:57:41 +0100
Message-ID: <209f61b25b68dd329e7cf40d9d0bc3b574cc1d3f.1739972906.git.mchehab+huawei@kernel.org>
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


