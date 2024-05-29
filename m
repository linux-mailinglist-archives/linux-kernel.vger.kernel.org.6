Return-Path: <linux-kernel+bounces-194382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5DA8D3B52
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B21AB22FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA0A181B9D;
	Wed, 29 May 2024 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUnAPCZx"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A5D15B115
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997627; cv=none; b=o8p4phMrmtgYd6CmvdlWHccc9GcJOCxQb8d+Wfh6QwSmjzVJkGxOQ1paHIM4tJBwQ1CB3PjeKjrNCQ3XU/H6pPGwuGDK7MRh7qGIz0TdTYr2h+RMHi49KFssHvCo7rQ2xIVqMBZljCdTBnxMPs22PRuPMdQSoro4RP7/2kaCcUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997627; c=relaxed/simple;
	bh=PBFURNvgqdG3HFj6VU1DZDCOa1PrJn7g3K6VyJFq/Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kyzwoqbzWWxfE6Tkxem8ZvxdORC8h7esw0EpEr+inya56tJyo6KsHTriGQVa+/SFBIf74Sbsk2ucRep9gDl6LU7cGrM4zyfg6ydAQYQWUkSsoeIrROpkPCDZdS35YPJIfu58FktUhIENqIiuuKTUp0u+zkfDcBTHQswIMvjAFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUnAPCZx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f47f07acd3so19336685ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716997626; x=1717602426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zql6ooItQ72w2cXFny5Ss77uqHp1EjByj2FmbV0T398=;
        b=HUnAPCZx6Oy18WJgSt9NjklV9cFf3P4WA4E5nEt2Z4WxrBnD14tYn/lzgUh5t0pu9V
         w7HTIeL7cCdhkwU6G85TQcPx/fsxYBBMSw2v1reU9C4H2MHu0i3qY0R4IASxTa7GpNgK
         ZM8cOlecD9CfTnJPTyIF2D0ALQIqK5lkZdVXx3R50oE1g0lEx9xfXIEo3D5Fee1dtlBV
         MAmU8MamXiQcjFU1cbZ7KGlYrNv0NshIa6QyyMcdFNA88CIsyVFJNncfjH+QlO/mJ3JP
         Kry7aypf2C+tccxid5Dn8sQLx5hHgV5Fk4WpuVRNVhyZzBLvDPQyoDSDVawJNNGdu4p8
         aOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716997626; x=1717602426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zql6ooItQ72w2cXFny5Ss77uqHp1EjByj2FmbV0T398=;
        b=CBRtAdsvdodWLB6qZRdFgRzj65l8Q5H+n5wRQGVd66MwjMHMsg1MW8osK0clRNLGdW
         mxLRqNG/mN0pZB+w7bKVw3bVC/dsZjmbucjciQwZVsC+NnG+TwXuLBmXqaPSolXEbn8m
         Bg/qu/qv7svZBGkpIkxc8yqFjPhKJz3eHvwE6yITdSEzsxu+yw6j0XeFXkWopWJ4fgCZ
         d7VrkZC+apXftHuTKK50gIcmFIOcb8yfGGYL/FCyIOe+5zAAkTMfthfzAsbiRyk2aQEu
         /SgVpIZMMy10zeyPKrmtCDjCMxsO3ypiJ5fvH19xEcEcwyqWS7S7xLhlJ6HhfOMAsarV
         Uq3A==
X-Forwarded-Encrypted: i=1; AJvYcCUI8Hnl0DyOVQGKMQ48H3BdwPCn3K4Ej4tBUqFAjsjnih3IMF9JgjGSXfuCsMlVmE1KQwS+z/GQza8XYkjhnFuzfFd9Sy1rfKRX8dRQ
X-Gm-Message-State: AOJu0YyvZPkHPmrZZWeAlKOBW9ZfNtCih6mMgswqKP6izVkhH+i4YPGJ
	I4/tAH1ot2JU7ENNj2QDGf0c4a0kwJPudZ4RNL5wSm7tPljgwHxQXnGRNv0/
X-Google-Smtp-Source: AGHT+IGNQzIXJ6QNfGMf36WvrUgi5CkoFRL3hKyPiny3FhISdwU02s3kZ8fHbl+awbcbzkfR9IIq9w==
X-Received: by 2002:a17:903:2a86:b0:1f3:4d8f:e5f3 with SMTP id d9443c01a7336-1f4486d606dmr172701615ad.15.1716997625764;
        Wed, 29 May 2024 08:47:05 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-220-62.dynamic-ip.hinet.net. [220.143.220.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7b53bcsm100771725ad.90.2024.05.29.08.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 08:47:05 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] kbuild: Fix 'import module' error
Date: Wed, 29 May 2024 23:46:21 +0800
Message-Id: <20240529154621.21354-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

Commit b1992c3772e6 ("kbuild: use $(src) instead of $(srctree)/$(src)
for source directory") only changes 'symlinks'. However, 'cmd_symlink'
is not changed accordingly. This leads to the following error:

Traceback (most recent call last):
  File "/your_kernel_obj/linux/vmlinux-gdb.py",
 line 29, in <module>
    import linux.utils
ModuleNotFoundError: No module named 'linux.utils'

Fix the issue by using $(src) instead of $(srctree)/$(src).

Fixes: b1992c3772e6 ("kbuild: use $(src) instead of $(srctree)/$(src) for source directory")
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 scripts/gdb/linux/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
index d77ad9079d0f..fcd32fcf3ae0 100644
--- a/scripts/gdb/linux/Makefile
+++ b/scripts/gdb/linux/Makefile
@@ -5,7 +5,7 @@ ifdef building_out_of_srctree
 symlinks := $(patsubst $(src)/%,%,$(wildcard $(src)/*.py))
 
 quiet_cmd_symlink = SYMLINK $@
-      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(abspath $(srctree))/$(src)/%,$@) $@
+      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(abspath $(src))/%,$@) $@
 
 always-y += $(symlinks)
 $(addprefix $(obj)/, $(symlinks)): FORCE
-- 
2.25.1


