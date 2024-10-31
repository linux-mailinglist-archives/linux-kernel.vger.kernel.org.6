Return-Path: <linux-kernel+bounces-390938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0469B8047
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9E32838D3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B8D1BC092;
	Thu, 31 Oct 2024 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UbCX4rll"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D750E1974F4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392685; cv=none; b=ou029usQ07jpzbMWCTEbmVRa9aywR5/zXmgrf+aFhx5dSWCPsBInI2fsgI80ov+Kv/KBxydHJ1ReUfufWIh3d9krU6kwZyurAf9hgHklJlOdOzf/SKqhRMq/bt0d8xzNyVHYtejNDa0/X4xxMIiTtJO1rFRoTzBJ/fqlAoAJ6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392685; c=relaxed/simple;
	bh=3U1ZiJmvD8aZd3Ni/hhC3pmLL4CmGo8yEdwrbILytnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cr84r1xZxqR7IxBr1Fk0c2JQ+ahUvDq80BipWbMPwPnAk7u1RLcS6EE0mBe3Ace4POqMm6m5aZU5rU3i9GC+R0J3T+373CcmbHA6epBmFTv69gCJ/EH5WLc4F895TtfzrMBi5XGZXef3jL2XGAKpQIReld5mRHGJ2yp02XcqU/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UbCX4rll; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730392680;
	bh=3U1ZiJmvD8aZd3Ni/hhC3pmLL4CmGo8yEdwrbILytnA=;
	h=From:Date:Subject:To:Cc:From;
	b=UbCX4rllqBK0swe0Lwu9c0QkxjTiFXSs7qdvb3Shr6E0boLSfcTCXe6fT3I4LsqMW
	 YRxcZxsOM+MqkkcOB+Rfl+fQmIF4uuUDKhCfKGnnnGMn2+IFjf9tMEvMmXs1gxubN6
	 3OxP1vfxWiwdg3AFmJAPuT9nHrC38OmYaI36fmoZFELcnTVtPwb/TqV/A7llr0kTAf
	 D5EEdQvq7/34FdIgJgCLEv7mGYRyPvLdgP9ibutl709xeeaikIKV5hny2g2l1+oj5s
	 sFHSIotyu75wrCHSWsdozav0rfuTMwqmr336s+YSC0UoQe3GjxzytY3cM2TPhqWMsL
	 M0xH7ZilTUJLg==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BEAF617E3692;
	Thu, 31 Oct 2024 17:38:00 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 31 Oct 2024 18:37:04 +0200
Subject: [PATCH RFC v2] regmap: maple: Provide lockdep (sub)class for maple
 tree's internal lock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-regmap-maple-lockdep-fix-v2-1-06a3710f3623@collabora.com>
X-B4-Tracking: v=1; b=H4sIAC+yI2cC/4WNTQqDMBSEryJv3VfyU/+6KhR6gG6Li5g8NRiNJ
 EVaxLs3eIEuZjEzzDcbRAqWIlyzDQKtNlo/JyNOGehBzT2hNcmDYOLCmagxUD+pBZMcofN6NLR
 gZz/YyaLSVFApCwlpvgRK8YF+wfNxhyaFg41vH77H3cqP6j955cixzKua8lLWrDU37Z1TrQ/qr
 P0Ezb7vP+EyT8TJAAAA
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
Changes in v2:
- Rebased onto next-20241031 to fix the conflicts reported by Mark
- Link to v1: https://lore.kernel.org/r/20241029-regmap-maple-lockdep-fix-v1-1-7589e57390bd@collabora.com
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
index 8d27d3653ea3e71e7b134cd3e47be385860e7375..23da7b31d7153450e1b16528be47216d7fbdd872 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -355,6 +355,9 @@ static int regcache_maple_init(struct regmap *map)
 
 	mt_init(mt);
 
+	if (!mt_external_lock(mt) && map->lock_key)
+		lockdep_set_class_and_subclass(&mt->ma_lock, map->lock_key, 1);
+
 	if (!map->num_reg_defaults)
 		return 0;
 
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
base-commit: f9f24ca362a4d84dd8aeb4b8f3ec28cb6c43dd06
change-id: 20241029-regmap-maple-lockdep-fix-f368ce6e7363


