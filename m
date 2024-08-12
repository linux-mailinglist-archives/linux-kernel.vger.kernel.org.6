Return-Path: <linux-kernel+bounces-283775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4633294F893
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CD92826E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FCE199246;
	Mon, 12 Aug 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KTTMvf4Y"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B56194A68
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495830; cv=none; b=Y8MITJNH5hLiIxFnVqylP12GjFzuEWj+S6MOlfnT0G7pYLNDb+aJFeAMxKbVLEcsFhHbup/OPoUEseGqC5sOTjW13kxKEnsnlU3HHmdlcm4NupZWV7YK964kN9dcrTr3CPP2WhlN0D7Xqhj2eG2rdY7RmczHQvXqStZU0LJSNcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495830; c=relaxed/simple;
	bh=PXBSGyJ2lJkOBODV+E+wW90W/9DAyUDr/2f7Jxi0Zr4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j26j2cDza3JCwYCtPWEo78lTE5BPDeDsJvwcr4XX7bnCDUqZKyhFNeovLVamBQfDjgDypMqCbbtgo8NMOT+A3J5hfIhl4v0MnwZ7I/GbodCapvo6qxipQCB6KN3YKqAAVoeezwnJmURp2uZFiCtyzWuJw52xzz+mFnzK/yx0YSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KTTMvf4Y; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723495825;
	bh=PXBSGyJ2lJkOBODV+E+wW90W/9DAyUDr/2f7Jxi0Zr4=;
	h=From:Subject:Date:To:Cc:From;
	b=KTTMvf4Y8KJeM3nudqlNqMx7g4fxWr0PW0wvMe/BHg6Hku84B+aporKI+0A2p5NHK
	 98EonBwxfTQdFoSQpYw6WKXp2a3AbAFIIR4ZNMaJqOpcjrI06iiu2eWJUfjEmxwV9P
	 dNAvPbr18Jb8BQVoV9lWqXyZAeq34uh3jKEMs0eE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/3] tools/nolibc: clang LTO compatibility
Date: Mon, 12 Aug 2024 22:50:16 +0200
Message-Id: <20240812-nolibc-lto-v2-0-736af7bbefa8@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIh1umYC/03MQQ6CMBCF4auQWVvTKSiNK+9hWNA62ElIazqIG
 sLdrbhx+b/kfQsIZSaBU7VAppmFUyxhdhX40McbKb6WBqNNo1tjVUwjO6/GKam6Rou1a02vHZT
 DPdPArw27dKUDy5Tye7Nn/K4/xqL+Z2ZUWvX2SAdsfDt4PD+JRcSHR9hHmqBb1/UDh3CO46kAA
 AA=
To: Willy Tarreau <w@1wt.eu>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723495824; l=2136;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=PXBSGyJ2lJkOBODV+E+wW90W/9DAyUDr/2f7Jxi0Zr4=;
 b=uMJStOCxHqDWYd4Px6kHueLvZjsWBNpwiySdZEAnuhq7rYT1MMj00fxfM6AT8H/HGgsHCxhVn
 n0He3nEaEcjDiniyU7X1ZrnesN08rREvIxK2kEBavt+sGGlVd429nKH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

A few tiny bugfixes and refactoring to provide compatibility with
clangs -flto.

$ CFLAGS_EXTRA=-flto ./run-tests.sh -m user -l       
i386:          195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
x86_64:        195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
arm64:         195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
arm:           195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
mips32le:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
mips32be:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc:           195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc64:         195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc64le:       195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
riscv:         195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
s390:          195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
loongarch:     195 test(s): 192 passed,   3 skipped,   0 failed => status: warning

GCC is not supported, for details read the discussion in v1 of the
series.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Drop GCC support
- arch-x86_64.h: Don't try to wrap the asm functions in C functions,
  Instead just replace the local symbol with a local label.
- Link to v1: https://lore.kernel.org/r/20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net

---
Thomas Weißschuh (3):
      tools/nolibc: crt: mark _start_c() as used
      tools/nolibc: stackprotector: mark implicitly used symbols as used
      tools/nolibc: x86_64: use local label in memcpy/memmove

 tools/include/nolibc/arch-x86_64.h    | 4 ++--
 tools/include/nolibc/crt.h            | 2 +-
 tools/include/nolibc/stackprotector.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 22ba81c50a49468d80055674d8d6f78afb1c92c4
change-id: 20240728-nolibc-lto-331813b72a0b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


