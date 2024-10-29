Return-Path: <linux-kernel+bounces-387721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA03B9B5542
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C92283CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB7120967D;
	Tue, 29 Oct 2024 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cwZ5Pajw"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40585194AD6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730238644; cv=none; b=NCY5lLvYDpKX7zEhzSHrWu2xHlCt8YuZt/8sE3IljuT7iMYgZS1h0r08xIyw2rpK6rlMhaFQcWwj2/I+YN6qa00Fod7PxiJoK/0CLpyigoiOj2d1TWizbT+33YwwdoXsaAl0GZ/sRkFVNGDM2TAaMa4lb8r0cA3SQLA7n2g06r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730238644; c=relaxed/simple;
	bh=CV1D7APyWZJ5vxmnt7I72xqN3EP4hyc4p4cEN36kXnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qwIF78g6+4281PttvbdJTJMaVA2+zfO34HxM9EMVuC4LAIzRD/WSipRqP6ADsFbNb/wZY8Kshse1+hxPl5tdEydq9DRhVDcIA5h6q4NOHwKcfqChtIKn0v/zMrthyNDh8NcsCGJd768+4rzENTSarUpsyrB1N5Cy4Tg3Mt+qRG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cwZ5Pajw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730238640;
	bh=CV1D7APyWZJ5vxmnt7I72xqN3EP4hyc4p4cEN36kXnU=;
	h=From:Date:Subject:To:Cc:From;
	b=cwZ5Pajwhc/kbxB0pPPIjbJGb8aKaj6x9AEbajPokeL0pmewUrZcqGBpl3fpKjkgH
	 PDEmG7sbE3EcKrm610O7pXArnbFnsDyJTDqnORvuDOHg1xdN/PDke/ecWs3Yuq1HOh
	 FV5GSKa6/VI+/ozw/eMB5+dbf/5mxTt0g8u+VPZkWciZBdN5dhoo47so8fZ0ztH0RD
	 SlKUu7Ajg4je6bBhAYGpL1ReVCT+cd5ELhiErKG1HOsSQk+03ZLSFaU7APj8ySQu7t
	 TOXb+Xe1Yyf9Jj87tKLES8lSUsqhzkxRkdaplYysVp0jmf3cqMKVSDAmQAnjzXCduV
	 2o8ADyz2ts6vA==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1F8C217E376A;
	Tue, 29 Oct 2024 22:50:40 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 29 Oct 2024 23:50:12 +0200
Subject: [PATCH RFC] regmap: maple: Provide lockdep (sub)class for maple
 tree's internal lock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-regmap-maple-lockdep-fix-v1-1-7589e57390bd@collabora.com>
X-B4-Tracking: v=1; b=H4sIAJRYIWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyNL3aLU9NzEAl0gzknVzclPzk5JLdBNy6zQTTM2s0hONUs1NzYzVgJ
 qLyhKBQqDjY5WCnJzVoqtrQUAU8MayG8AAAA=
X-Change-ID: 20241029-regmap-maple-lockdep-fix-f368ce6e7363
To: Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
 kernel@collabora.com, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

In some cases when using the maple tree register cache, the lockdep
validator might complain about invalid deadlocks:

[7.131886]  Possible interrupt unsafe locking scenario:

[7.131890]        CPU0                    CPU1
[7.131893]        ----                    ----
[7.131896]   lock(&mt->ma_lock);
[7.131904]                                local_irq_disable();
[7.131907]                                lock(rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock);
[7.131916]                                lock(&mt->ma_lock);
[7.131925]   <Interrupt>
[7.131928]     lock(rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock);
[7.131936]
                *** DEADLOCK ***

[7.131939] no locks held by swapper/0/0.
[7.131944]
               the shortest dependencies between 2nd lock and 1st lock:
[7.131950]  -> (&mt->ma_lock){+.+.}-{2:2} {
[7.131966]     HARDIRQ-ON-W at:
[7.131973]                       lock_acquire+0x200/0x330
[7.131986]                       _raw_spin_lock+0x50/0x70
[7.131998]                       regcache_maple_write+0x68/0xe0
[7.132010]                       regcache_write+0x6c/0x90
[7.132019]                       _regmap_read+0x19c/0x1d0
[7.132029]                       _regmap_update_bits+0xc0/0x148
[7.132038]                       regmap_update_bits_base+0x6c/0xa8
[7.132048]                       rk8xx_probe+0x22c/0x3d8
[7.132057]                       rk8xx_spi_probe+0x74/0x88
[7.132065]                       spi_probe+0xa8/0xe0

[...]

[7.132675]   }
[7.132678]   ... key      at: [<ffff800082943c20>] __key.0+0x0/0x10
[7.132691]   ... acquired at:
[7.132695]    _raw_spin_lock+0x50/0x70
[7.132704]    regcache_maple_write+0x68/0xe0
[7.132714]    regcache_write+0x6c/0x90
[7.132724]    _regmap_read+0x19c/0x1d0
[7.132732]    _regmap_update_bits+0xc0/0x148
[7.132741]    regmap_field_update_bits_base+0x74/0xb8
[7.132751]    vop2_plane_atomic_update+0x480/0x14d8 [rockchipdrm]
[7.132820]    drm_atomic_helper_commit_planes+0x1a0/0x320 [drm_kms_helper]

[...]

[7.135112] -> (rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock){-...}-{2:2} {
[7.135130]    IN-HARDIRQ-W at:
[7.135136]                     lock_acquire+0x200/0x330
[7.135147]                     _raw_spin_lock_irqsave+0x6c/0x98
[7.135157]                     regmap_lock_spinlock+0x20/0x40
[7.135166]                     regmap_read+0x44/0x90
[7.135175]                     vop2_isr+0x90/0x290 [rockchipdrm]
[7.135225]                     __handle_irq_event_percpu+0x124/0x2d0

In the example above, the validator seems to get the scope of
dependencies wrong, since the regmap instance used in rk8xx-spi driver
has nothing to do with the instance from vop2.

Improve validation by sharing the regmap's lockdep class with the maple
tree's internal lock, while also providing a subclass for the latter.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/base/regmap/internal.h       | 1 +
 drivers/base/regmap/regcache-maple.c | 3 +++
 drivers/base/regmap/regmap.c         | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 83acccdc1008976de681396a300b78b701bbfa3c..bdb450436cbc53031c3d921f9f6067d26eca2549 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -59,6 +59,7 @@ struct regmap {
 			unsigned long raw_spinlock_flags;
 		};
 	};
+	struct lock_class_key *lock_key;
 	regmap_lock lock;
 	regmap_unlock unlock;
 	void *lock_arg; /* This is passed to lock/unlock functions */
diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index a6a894aaf41bef56a95c92d27d88bef1631db83b..f3bbd771b1d7d48dab7e6a375bdf517673207e9c 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -317,6 +317,9 @@ static int regcache_maple_init(struct regmap *map)
 
 	mt_init(mt);
 
+	if (!mt_external_lock(mt) && map->lock_key)
+		lockdep_set_class_and_subclass(&mt->ma_lock, map->lock_key, 1);
+
 	for (i = 0; i < map->num_reg_defaults; i++) {
 		ret = regcache_maple_write(map,
 					   map->reg_defaults[i].reg,
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4ded93687c1f0ab3584947c61398cd6333b2e72c..53131a7ede0a6aad54bc85e970124f6b166a8010 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -745,6 +745,7 @@ struct regmap *__regmap_init(struct device *dev,
 						   lock_key, lock_name);
 		}
 		map->lock_arg = map;
+		map->lock_key = lock_key;
 	}
 
 	/*

---
base-commit: dec9255a128e19c5fcc3bdb18175d78094cc624d
change-id: 20241029-regmap-maple-lockdep-fix-f368ce6e7363


