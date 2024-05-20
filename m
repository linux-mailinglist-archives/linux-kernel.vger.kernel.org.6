Return-Path: <linux-kernel+bounces-183489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EEF8C99C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3871F21691
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A041CD20;
	Mon, 20 May 2024 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoyEwHah"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349DF1BC23
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193300; cv=none; b=GrpurlJ0ockC7/SZim0t6f08KZiTpfdoRcigJxF8D8IXR9eOWHZDZPUmZcfNUPuCEF4TdCkl7NQX2Qd3kH9bSEJGCEvDt/5IrXOwNhpTGTD9y7hwKEWpFHenyJ/ZhsXHfQkauZBjUlZcdIzG3Iq26kx+flRrkWOb1Xrrry29KsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193300; c=relaxed/simple;
	bh=mfDNx0N0p20uPgD7lLp2G6uKC/nPQ4db0+1RjxMoY0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kt+nyG3w97mijQJ0m7l35Q4zKbdUOnr8YA/HVdudtNc4ZtKv7WMDQ4EqjrGypNFMaKwc6lc+qtStjWgWWClyfnJICk6mcTeIX636BvtEEakAFheLw4mygRWDy0D5K6PHt5V8rztwXXKO2X69YnlDqWkShMQgnQ8lrzxtA3Zr40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoyEwHah; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34e0d47bd98so1114397f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716193297; x=1716798097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RLOkKVCpFX3u54FOqCOA4zzRUntDO6MyxWoG5jTKe2k=;
        b=AoyEwHahFhrGDEFCjUO1q7Aq+bRnByZqln4iAC8CaeNsK2P2AwN7gMVZ0k+YQwFtsQ
         p4PMNfCrL5Vy5r/LZg6t4Ykdo+BHncHc77nUuUdmux+Riss/GXNDnQXw0xvsTfiUFppl
         za2y9u8vlZPyS/jCfQpG6PX0SF9OgFJQVALqXfAiklJperdXqrn+uKRgm1fNI5z7vPEB
         mF7rjr6gvjTwBqIHcqqSRTPZ4q3XEJ7iBoXkWYQ4ZCl5IR/Ug1JfpiWryrleB/3tWblt
         4njTayNBsJdiBEvIc9OSZHf430DeX5v9vMwnYyDwEiC7z3ZU+KqyzQiHIc2nBlm6cALW
         1nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716193297; x=1716798097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLOkKVCpFX3u54FOqCOA4zzRUntDO6MyxWoG5jTKe2k=;
        b=gEr9JEmUvDQEL/QUjfisUJ6vAjz6ng5Tgp0xgx9GyThBTLHwE9l9jUnhW3dvpJup8y
         trunL7Bz/WO/9BwCcEpjeQ+nGGqdkVdVkEgYb99ZsonF3PfLkakOaf0kNYrwX8qOE20h
         uc9cXPruUh3VB9NgntZ70BBZfWMhNjxT5Jv4y7mSOd/Wjx9UnwtX5C0dxftJOMUM5W7l
         XccVedHZwuCLwLz9GFzror5S4+8Llj4J3PDKLDk4Hyl/gn13dgDalgIrusiEykgSYqT+
         x/aemVDInLbfTHN0fHdrVHq9Mq8dmuHXfB8emJ4vE4qM6stKpkDW9XBgfRlqulpS0+7d
         Wbmw==
X-Gm-Message-State: AOJu0YwTYfFfcQE3JVdKKPBcICRKvNiD5z8/8l6iuRlcNFNxwHiCw7MN
	iiHxhGDil+B6MElduVxXEud9/mxCNZgQemn5B5xXc30YZASLzRwEuZwcpSFgShY=
X-Google-Smtp-Source: AGHT+IHQSRhAY0ZwPublPM/5ASwi7DkCFsntaBUwKLGNCnAEsFbrfbPRF2T/DGxBAqDMeLaF0Oa5fw==
X-Received: by 2002:adf:fdd0:0:b0:34d:ac38:7d3f with SMTP id ffacd0b85a97d-354b8e0aa81mr4710989f8f.17.1716193297038;
        Mon, 20 May 2024 01:21:37 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbf9esm28348545f8f.91.2024.05.20.01.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 01:21:36 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/percpu: Enable named address spaces for all capable GCC versions
Date: Mon, 20 May 2024 10:21:14 +0200
Message-ID: <20240520082134.121320-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable named address spaces also for GCC 6, GCC 7 and GCC 8
releases. These compilers all produce kernel images that boot
without problems.

Use compile-time test to detect compiler support for named
address spaces. The test passes with GCC 6 as the earliest
compiler version where the support for named address spaces
was introduced.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d16fee6bdb8..c9e0a54f469e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2430,7 +2430,8 @@ source "kernel/livepatch/Kconfig"
 endmenu
 
 config CC_HAS_NAMED_AS
-	def_bool CC_IS_GCC && GCC_VERSION >= 90100
+	def_bool $(success,echo 'int __seg_fs fs; int __seg_gs gs;' | $(CC) -x c - -S -o /dev/null)
+	depends on CC_IS_GCC
 
 config CC_HAS_NAMED_AS_FIXED_SANITIZERS
 	def_bool CC_IS_GCC && GCC_VERSION >= 130300
-- 
2.45.1


