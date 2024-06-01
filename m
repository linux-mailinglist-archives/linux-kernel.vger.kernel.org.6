Return-Path: <linux-kernel+bounces-198010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A29F8D71FB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 23:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E1B1B2167F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 21:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AC31CD2F;
	Sat,  1 Jun 2024 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="JDlDB9yO"
Received: from smtp-out.freemail.hu (fmfe12.freemail.hu [46.107.16.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB42D058
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717277589; cv=none; b=t/+B51Lh91DhaWR8mgBEz1Dq9ZpkwZ7M1wKUNPdBEe/D02NqXpXBTzPc6IdJ/IhhCUAeTwVEFhrSc6zh29f1AYHCF/kUqNYgn4e2dgCPy5AKoEwQyBmpx8ZS7pMsdKFy7nrnk4YarBFbRqVBmhOyRnJokfSrex2xtla7Sxd3tCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717277589; c=relaxed/simple;
	bh=kmCs3tuTpxHxU/J3vT0o4lQF95dFYC3u7ThGWPyd5js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EI32ft0n+UBgdHnkJJfV9VZy22b3M5Be1TWWOMANm+Nst2BZy8L5+WZ3XScD2aO5BSFkXNTutV3r/ebRN2vuWdJUdQM49to6762odELSrO/M6Ke6XdruknPiAyGzS6P2z8JgB1NFpICWR1NNfx0NBTeBMysHrIrXagFqUE0LYAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=JDlDB9yO reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from fizweb.elte.hu (fizweb.elte.hu [157.181.183.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4VsCdP0FrDz1mp;
	Sat,  1 Jun 2024 23:23:05 +0200 (CEST)
From: egyszeregy@freemail.hu
To: bskeggs@redhat.com,
	kherbst@redhat.com,
	lyude@redhat.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH] drm/nouveau/i2c: rename aux.c and aux.h to nvkm_i2c_aux.c and nvkm_i2c_aux.h
Date: Sat,  1 Jun 2024 23:22:47 +0200
Message-ID: <20240601212247.54786-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1717276985;
	s=20181004; d=freemail.hu;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	l=6462; bh=CnHSqkRX34kqCWN2/oPtvm9wm8HJCe8QhPwQypdpi3w=;
	b=JDlDB9yOQDBY7EDnRMrt8qYnWfH8J/LKYKb90434FH1tuOL04za+3TXXSbU0uvs0
	hWYDYjpbob4XGgUcd1s+lCkerOgDwkpWJWKFW8N5j6WENAKdR/hWJgcma2JEDDotXZ0
	cisYRrLsQBfjyKkBWw0qv/5PDe7vliytix5oP2piBPJC+uR3pN8OKck/+zLBGlJY4za
	qywwOiMNzHAdyOJT5kCg0yd+k186Oa1jX93iCpiRk5mxJQqJJcAxfW8rYbKRXi5QQTl
	SymDGdZ72wK5PkHxGgpZ9qXZtFV3eH4+95xNzpoPowMkXFkBy1uMClZzxv1oBmRo8o6
	CXPcfsWUsQ==

From: Benjamin Szőke <egyszeregy@freemail.hu>

The goal is to clean-up Linux repository from AUX file names, because
the use of such file names is prohibited on other operating systems
such as Windows, so the Linux repository cannot be cloned and
edited on them.

Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild                  | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c               | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c                | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c              | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c              | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c                  | 2 +-
 .../gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c => nvkm_i2c_aux.c}   | 2 +-
 .../gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h => nvkm_i2c_aux.h}   | 0
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c                | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c              | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c              | 2 +-
 11 files changed, 10 insertions(+), 10 deletions(-)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c => nvkm_i2c_aux.c} (99%)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h => nvkm_i2c_aux.h} (100%)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
index 819703913a00..c488dfce4392 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
@@ -25,7 +25,7 @@ nvkm-y += nvkm/subdev/i2c/busnv50.o
 nvkm-y += nvkm/subdev/i2c/busgf119.o
 nvkm-y += nvkm/subdev/i2c/bit.o
 
-nvkm-y += nvkm/subdev/i2c/aux.o
+nvkm-y += nvkm/subdev/i2c/nvkm_i2c_aux.o
 nvkm-y += nvkm/subdev/i2c/auxg94.o
 nvkm-y += nvkm/subdev/i2c/auxgf119.o
 nvkm-y += nvkm/subdev/i2c/auxgm200.o
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
index dd391809fef7..30bf84e77db9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
@@ -24,7 +24,7 @@
 #define anx9805_pad(p) container_of((p), struct anx9805_pad, base)
 #define anx9805_bus(p) container_of((p), struct anx9805_bus, base)
 #define anx9805_aux(p) container_of((p), struct anx9805_aux, base)
-#include "aux.h"
+#include "nvkm_i2c_aux.h"
 #include "bus.h"
 
 struct anx9805_pad {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
index 47068f6f9c55..9e07ba444ca8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
@@ -22,7 +22,7 @@
  * Authors: Ben Skeggs <bskeggs@redhat.com>
  */
 #define g94_i2c_aux(p) container_of((p), struct g94_i2c_aux, base)
-#include "aux.h"
+#include "nvkm_i2c_aux.h"
 
 struct g94_i2c_aux {
 	struct nvkm_i2c_aux base;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
index dab40cd8fe3a..8709b728c38b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
@@ -19,7 +19,7 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
-#include "aux.h"
+#include "nvkm_i2c_aux.h"
 
 static const struct nvkm_i2c_aux_func
 gf119_i2c_aux = {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
index 8bd1d442e465..f40c5709d217 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
@@ -22,7 +22,7 @@
  * Authors: Ben Skeggs <bskeggs@redhat.com>
  */
 #define gm200_i2c_aux(p) container_of((p), struct gm200_i2c_aux, base)
-#include "aux.h"
+#include "nvkm_i2c_aux.h"
 
 struct gm200_i2c_aux {
 	struct nvkm_i2c_aux base;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
index 976539de4220..736275f0c774 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
@@ -22,7 +22,7 @@
  * Authors: Ben Skeggs
  */
 #include "priv.h"
-#include "aux.h"
+#include "nvkm_i2c_aux.h"
 #include "bus.h"
 #include "pad.h"
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
similarity index 99%
rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
index d063d0dc13c5..6b76df02c63a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
@@ -24,7 +24,7 @@
 
 #include <linux/string_helpers.h>
 
-#include "aux.h"
+#include "nvkm_i2c_aux.h"
 #include "pad.h"
 
 static int
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.h
similarity index 100%
rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h
rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.h
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
index 5904bc5f2d2a..e9c55a57c878 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
@@ -22,7 +22,7 @@
  * Authors: Ben Skeggs
  */
 #include "pad.h"
-#include "aux.h"
+#include "nvkm_i2c_aux.h"
 #include "bus.h"
 
 void
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
index 3bc4d0310076..1af64e25d838 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
@@ -22,7 +22,7 @@
  * Authors: Ben Skeggs
  */
 #include "pad.h"
-#include "aux.h"
+#include "nvkm_i2c_aux.h"
 #include "bus.h"
 
 static const struct nvkm_i2c_pad_func
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
index 7d417f6a816e..997a5a2146c4 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
@@ -22,7 +22,7 @@
  * Authors: Ben Skeggs
  */
 #include "pad.h"
-#include "aux.h"
+#include "nvkm_i2c_aux.h"
 #include "bus.h"
 
 static void
-- 
2.43.0


