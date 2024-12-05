Return-Path: <linux-kernel+bounces-433522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361129E5983
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E213164B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0452921C174;
	Thu,  5 Dec 2024 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sA5xJuT8"
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68A45464A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411693; cv=none; b=EoHBJjFTdcd6sAg0/EjtYBUpwo2BuliIHsjukby1NDoD++pQMu4J7WMcgqgHdt8n3vkusFpA+EyiQnKHKehDcUQ9oh5chEnA/o1/bJCifRx2V+Cp6fbkq2RZTEKbwzHU3WySFQpCik68twkFytSiJ+m58x7xHbFeL12YmZfjILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411693; c=relaxed/simple;
	bh=+AVsd/PP2QHE6YB3OOownKvn3cyd5p5cKQhjKNpdcsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGbEfH/DVzdBX1mjOqxVVSfluvNx6Kl4HIfLCifUx75nKUHOH3huFbe+4Tx++h7d7q2MB6gWsbP/51NZPOhtzEETL9SaUuzWkXfNy8vzvenw4slYq3rN+rz08iy0S6byR4HdUrs29QKaDM7oQMLUA9F/BaPFcRuFsCR2YPk/7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sA5xJuT8; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id JDXitQowyIesqJDXqtNVEr; Thu, 05 Dec 2024 16:13:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733411619;
	bh=8CBHgaf7AxzET+ND9Xt/+TNs9BaI7qCRt+Attdqsh58=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=sA5xJuT8MhvJu3LfOPbmI5qUEsKEqZXoiElWnF77aExi2qrPKjZJZ6olZgzYaT3wZ
	 AOLkK03z7Rv9mjLut3pZyqLrR7i2zVLfYelxJX/hB+i2IEcEZzvAOxw3HpFEcXVntO
	 di+ges70hAK5YbTKG/W7Uh9NWeTm0n9N8ZUfITsZuBmLajWPJEs8YZCKjT3q5yTa0p
	 rO0TpHh/wlx966WhpIuOAuq6kkyteQdZn1xt34Rkj86NxvXtF1R/kvZB79vJfu1QRS
	 l+ylmt4kqfHvnCAMzx8r1iwuplwrdfftKGeIBnJe0ah6HdTRlLuE+FyG/DsWXlw9n0
	 Innn3gNJ4ufZw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 05 Dec 2024 16:13:39 +0100
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] build_bug.h: more user friendly error messages in BUILD_BUG_ON_ZERO()
Date: Fri,  6 Dec 2024 00:11:46 +0900
Message-ID: <20241205151316.1480255-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=+AVsd/PP2QHE6YB3OOownKvn3cyd5p5cKQhjKNpdcsE=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOmBh3l6zspmtRv6nvx5S+q7fesOu78suXPO3JurWFcrc PqO5nf1jlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABNZfIaRYeMTgcxuhTbbaztv RAgb9G4qsu5q7FTxmXpcMOdzpPHXNIb/ybclhI1OfxGscum61VeU9P1s0eHSF5viy96Lfn1XpWD JCAA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

__BUILD_BUG_ON_ZERO_MSG(), as introduced in [1], makes it possible to
do a static assert while still returning a zero value. The direct
benefit is to provide a meaningful error message instead of the
cryptic negative bitfield size error message currently returned by
BUILD_BUG_ON_ZERO():

  ./include/linux/build_bug.h:16:51: error: negative width in bit-field '<anonymous>'
     16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
        |                                                   ^

Get rid of BUILD_BUG_ON_ZERO() bitfield size hack. Instead rely on
__BUILD_BUG_ON_ZERO_MSG() (which in turn relies on C11's
_Static_assert()).

Use some macro magic, similarly to static_assert(), to either use an
error message provided by the user or, when omitted, to produce a
default error message by stringifying the tested expression. With
this, for example:

  BUILD_BUG_ON_ZERO_MSG(1 > 0)

would now throw:

  ./include/linux/compiler.h:245:62: error: static assertion failed: "1 > 0 is true"
    245 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
        |                                                              ^~~~~~~~~~~~~~

Finally, __BUILD_BUG_ON_ZERO_MSG() is already guarded by an:

  #ifdef __CHECKER__

So no need any more for that guard clause for BUILD_BUG_ON_ZERO().
Remove it.

[1] commit d7a516c6eeae ("compiler.h: Fix undefined BUILD_BUG_ON_ZERO()")
Link: https://git.kernel.org/torvalds/c/d7a516c6eeae

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/build_bug.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index 3aa3640f8c18..f4460a36f10f 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -4,17 +4,17 @@
 
 #include <linux/compiler.h>
 
-#ifdef __CHECKER__
-#define BUILD_BUG_ON_ZERO(e) (0)
-#else /* __CHECKER__ */
 /*
  * Force a compilation error if condition is true, but also produce a
  * result (of value 0 and type int), so the expression can be used
  * e.g. in a structure initializer (or where-ever else comma expressions
  * aren't permitted).
+ *
+ * Take a message as an optional second argument. If omitted, default to
+ * the stringification of the tested expression.
  */
-#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
-#endif /* __CHECKER__ */
+#define BUILD_BUG_ON_ZERO(e, ...) __BUILD_BUG_ON_ZERO(e, ##__VA_ARGS__, #e)
+#define __BUILD_BUG_ON_ZERO(e, msg) __BUILD_BUG_ON_ZERO_MSG(e, msg " is true")
 
 /* Force a compilation error if a constant expression is not a power of 2 */
 #define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
-- 
2.45.2


