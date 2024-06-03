Return-Path: <linux-kernel+bounces-198861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857388D7E6D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39ACB283219
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F77E765;
	Mon,  3 Jun 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="EswRUQok"
Received: from smtp-out.freemail.hu (fmfe14.freemail.hu [46.107.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0AE53392
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406586; cv=none; b=sG9C3emIzHhAtIXDQcUJL2ievPfwq3xPU1THTGrsf2TcGYpR8+v7p8QgWA2FmcrmNi3J6edOqrNi1qRIdNcHk+3twjtvsKtDlNHCa9VHpE1NyP26/NhAYG5JuHvMfC+M150dUQ9E7iRJ++tBf6iqDTolpEJ4UrUljh9KRrJ8TcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406586; c=relaxed/simple;
	bh=OzfR7H3OeR2RqQmQTLf2+MCUwPhQROHuvSQDJc/SIiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K8ENu7Di9EAXxOtWG3+8UBbi9SIWAMTzQe1FLNnajwdu8JWSvFLPMfKCTQAECma8E/Al7BDM4VvlDbJnoih6x9Foxt4o4ueZPYLwhFmGgGJn6qM51R/cr4LvPh5qedd/CIuex+L2vGDZhJrPhS7/+gFpOIQ2PBwxq3gBQkkLpPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=EswRUQok reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from fizweb.elte.hu (fizweb.elte.hu [157.181.183.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4Vt7Pd3jnlz18V;
	Mon,  3 Jun 2024 11:16:05 +0200 (CEST)
From: egyszeregy@freemail.hu
To: bskeggs@nvidia.com,
	kherbst@redhat.com,
	lyude@redhat.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH] drm/nouveau/i2c: rename aux.c and aux.h to auxch.c and auxch.h
Date: Mon,  3 Jun 2024 11:15:58 +0200
Message-ID: <20240603091558.35672-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1717406166;
	s=20181004; d=freemail.hu;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	l=6337; bh=rijsPYYSbzi73ZsjnyWe6jiHuk3OCHTuD8vMOf/445U=;
	b=EswRUQokcslT1G+LQHyFiWcRQDM6iHCHBCJnkI5ThJ9yuZXovaAM4OGKMTKeIy8N
	ZS7ZaMhyPrJjAwxVMfcz9vqbuWjY5IlsIJuM0bbFLubPWXpZZU1DIx1NK5nmXhFatsd
	u5OOgr+zZzXXuLadvS4ijLtyGtUW81X6xwTqH0Qxn61igzSmqcm6Gz3utPGl8Hhmxb5
	7C2zK07XLbmeZSUmT9TfRGo4jGyxH6WSHnWlWtBeJ13c8j8ejdg3X+kO8HwugiNGyLD
	jnlF2xpRJa1Teyu3z2yj5jK1QQfg2WuYa5+XCzb/EH+A16hkqSk7If1DOszoavcHFhl
	fPls79YWXg==

From: Benjamin Szőke <egyszeregy@freemail.hu>

The goal is to clean-up Linux repository from AUX file names, because
the use of such file names is prohibited on other operating systems
such as Windows, so the Linux repository cannot be cloned and
edited on them.

Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild             | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c          | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c => auxch.c} | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h => auxch.h} | 0
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c           | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c         | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c         | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c             | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c           | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c         | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c         | 2 +-
 11 files changed, 10 insertions(+), 10 deletions(-)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c => auxch.c} (99%)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h => auxch.h} (100%)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
index 819703913a00..2c551bdc9bc9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
@@ -25,7 +25,7 @@ nvkm-y += nvkm/subdev/i2c/busnv50.o
 nvkm-y += nvkm/subdev/i2c/busgf119.o
 nvkm-y += nvkm/subdev/i2c/bit.o
 
-nvkm-y += nvkm/subdev/i2c/aux.o
+nvkm-y += nvkm/subdev/i2c/auxch.o
 nvkm-y += nvkm/subdev/i2c/auxg94.o
 nvkm-y += nvkm/subdev/i2c/auxgf119.o
 nvkm-y += nvkm/subdev/i2c/auxgm200.o
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
index dd391809fef7..6c76e5e14b75 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
@@ -24,7 +24,7 @@
 #define anx9805_pad(p) container_of((p), struct anx9805_pad, base)
 #define anx9805_bus(p) container_of((p), struct anx9805_bus, base)
 #define anx9805_aux(p) container_of((p), struct anx9805_aux, base)
-#include "aux.h"
+#include "auxch.h"
 #include "bus.h"
 
 struct anx9805_pad {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxch.c
similarity index 99%
rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxch.c
index d063d0dc13c5..fafc634acbf6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxch.c
@@ -24,7 +24,7 @@
 
 #include <linux/string_helpers.h>
 
-#include "aux.h"
+#include "auxch.h"
 #include "pad.h"
 
 static int
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxch.h
similarity index 100%
rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h
rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxch.h
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
index 47068f6f9c55..854bb4b5fdb4 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
@@ -22,7 +22,7 @@
  * Authors: Ben Skeggs <bskeggs@redhat.com>
  */
 #define g94_i2c_aux(p) container_of((p), struct g94_i2c_aux, base)
-#include "aux.h"
+#include "auxch.h"
 
 struct g94_i2c_aux {
 	struct nvkm_i2c_aux base;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
index dab40cd8fe3a..c17d5647cb99 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
@@ -19,7 +19,7 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
-#include "aux.h"
+#include "auxch.h"
 
 static const struct nvkm_i2c_aux_func
 gf119_i2c_aux = {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
index 8bd1d442e465..3c5005e3b330 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
@@ -22,7 +22,7 @@
  * Authors: Ben Skeggs <bskeggs@redhat.com>
  */
 #define gm200_i2c_aux(p) container_of((p), struct gm200_i2c_aux, base)
-#include "aux.h"
+#include "auxch.h"
 
 struct gm200_i2c_aux {
 	struct nvkm_i2c_aux base;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
index 976539de4220..ab86e11e7780 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
@@ -22,7 +22,7 @@
  * Authors: Ben Skeggs
  */
 #include "priv.h"
-#include "aux.h"
+#include "auxch.h"
 #include "bus.h"
 #include "pad.h"
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
index 5904bc5f2d2a..cc26cd677917 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
@@ -22,7 +22,7 @@
  * Authors: Ben Skeggs
  */
 #include "pad.h"
-#include "aux.h"
+#include "auxch.h"
 #include "bus.h"
 
 void
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
index 3bc4d0310076..1797c6c65979 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
@@ -22,7 +22,7 @@
  * Authors: Ben Skeggs
  */
 #include "pad.h"
-#include "aux.h"
+#include "auxch.h"
 #include "bus.h"
 
 static const struct nvkm_i2c_pad_func
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
index 7d417f6a816e..5afc1bf8e798 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
@@ -22,7 +22,7 @@
  * Authors: Ben Skeggs
  */
 #include "pad.h"
-#include "aux.h"
+#include "auxch.h"
 #include "bus.h"
 
 static void
-- 
2.43.0


