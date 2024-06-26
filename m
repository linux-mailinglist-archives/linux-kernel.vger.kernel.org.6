Return-Path: <linux-kernel+bounces-230685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1736918088
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0242828C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E67181315;
	Wed, 26 Jun 2024 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhqCh3vl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9964180A88
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403593; cv=none; b=hCfS1rkrFpRWvUYOll/URirowFTVrMDjHYsdP6AO0zqar43qByHWYxLImZFunN+6l2eW0I8HgFjM29UXevpBWSKTFYM/j6gXrCSXBtznl0S1tBjFclbvYsjwcZNJU3XNA7BXTnKJtbNzo3kQ7LBgy8WfcKKp78DnehciXhwvEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403593; c=relaxed/simple;
	bh=hHmrnmVkA+icg7WMUj6EJBFmbuxO5bQ3bYPlOLRcydA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HvaxWPrddKAWZp+bbdpqCwW8pakaxrWiII8mUlY3vvQ9/sCbrG4H+Mpwfj26gWMgIEWd+i5gJi0bIVPVf32iNowRtBN3/tIzgczv0voH1j0Efn6daVXHJw3oJy32tMFWpS0uoIL4qX4ML+Xa6MQwf6FYpNY03ypVXM5FmVKsvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhqCh3vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A663C2BD10;
	Wed, 26 Jun 2024 12:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719403592;
	bh=hHmrnmVkA+icg7WMUj6EJBFmbuxO5bQ3bYPlOLRcydA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=RhqCh3vlTEedAXYD86vsPOTqA/T6mY2xn7PIBn/P16eZS840B/3si/pU+U+QLaRxR
	 h8nMJXZ9l82ubbRhoffXiC1fnlP6O7EY/3wNAczIOlzdwu85/lWIvn/haVMf8UYzHb
	 wcz2OMQo4r6/Ga139fRL6dq52/0zDAserzFDy7sGdwoR/Z+qYPYP56cRrB9dP3Zb03
	 A/JC7aFXW8xY00t76TxH74wc+j67u/Qv/NXimUyLqmqku1wXAtKIEpO9JhVYRflMcD
	 WG3vmouZHG5zl66kLYzk0Hskh3oj8xSWpbA1uXLOhqGvxfxY4WopnqPJ8Zvr+4Yayb
	 3sRkrtR8+GMRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3660BC30659;
	Wed, 26 Jun 2024 12:06:32 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Wed, 26 Jun 2024 14:06:16 +0200
Subject: [PATCH v2] kbuild: scripts/gdb: bring the "abspath" back
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-jag-fix_gdb_py_symlinks-v2-1-1a05406c8063@samsung.com>
X-B4-Tracking: v=1; b=H4sIADcEfGYC/4WNXQ6CMBCEr0L22Zp2VYg+eQ9DSKE/rNpCukokh
 LtbuYCP32TmmwXYJrIMl2KBZCdiGmIG3BXQ9Tp6K8hkBpR4lCVKcddeOPo03rTNODc8hyfFBwt
 U5myksdVJI+T1mGyubeZbnbknfg1p3o4m9Uv/OycllDiUWjqJqnKtu7IO/I5+3w0B6nVdv7Wnw
 dnAAAAA
To: Jan Kiszka <jan.kiszka@siemens.com>, 
 Kieran Bingham <kbingham@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=ELA3O2VefITuAlFWSunBt6d4ILv4gEPSDCYoeDsUf/w=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZ8BEZ7361AGuuL1AzQ/hAcHZJ4bCyhOod8M
 AJJ0PxwNRIyY4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmfARGAAoJELqXzVK3
 lkFPbMoL/1UPGDA+dGpVQ4m8RzzzYa06hQnsp4OoNOVHK0R5EUVb0sZitdVbGD3TzLBcvKVPf51
 Ov0nMnZJ48icshqAXD6gOhd1KPJiMFJMBEtvx7QLUfa/4Hg6fhZC6XOtNwUgLO5iLdmc1MP2It7
 Uif0r7/c+MLSEUO1YtW8vUOA9jI4CiaPHD59RlcLPe2dPW/W0Ne7ODSFKD8tFLjK53pHavt9X0/
 qa0AFZZV/IKdl0zg+TWc3ZRKCXiPD7KlD2grhLbSdlcS74G3z+kiDk8KDwbR77xBAMjNNKnxMm8
 I8Ff4Mf+epcgueu71td/Jr/5QMmpEw7wYGXPWFMJbFjCSJhHTcFN7oR36zkROHPCE8dtEDS6lGa
 oOw1AzU7sEhetdDAJaz8AftBm6KRM/TopvO4beNPZF1+lbEJ/X6piysWETAIVOQYFECBDRvKPy6
 eRcMlZWYDyBODOOPFvNDRuiR3Dgav6rX9JY2oAmLHqa0ecLrnDCwNpFN3XmsdKRwzUsPlD/X3U4
 iI=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

Use the "abspath" call when symlinking the gdb python scripts in
scripts/gdb/linux. This call is needed to avoid broken links when
running the scripts_gdb target on a build directory located directly
under the source tree (e.g., O=builddir).

Fixes: 659bbf7e1b08 ("kbuild: scripts/gdb: Replace missed $(srctree)/$(src) w/ $(src)")
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
Changes in v2:
- Rephrased the commit message to clarify what is happening
- Link to v1: https://lore.kernel.org/r/20240620-jag-fix_gdb_py_symlinks-v1-1-36a0f0217fbf@samsung.com
---
 scripts/gdb/linux/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
index fd1402c0a1a1..fcd32fcf3ae0 100644
--- a/scripts/gdb/linux/Makefile
+++ b/scripts/gdb/linux/Makefile
@@ -5,7 +5,7 @@ ifdef building_out_of_srctree
 symlinks := $(patsubst $(src)/%,%,$(wildcard $(src)/*.py))
 
 quiet_cmd_symlink = SYMLINK $@
-      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(src)/%,$@) $@
+      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(abspath $(src))/%,$@) $@
 
 always-y += $(symlinks)
 $(addprefix $(obj)/, $(symlinks)): FORCE

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240620-jag-fix_gdb_py_symlinks-21d9d0de75a2

Best regards,
-- 
Joel Granados <j.granados@samsung.com>



