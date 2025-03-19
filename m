Return-Path: <linux-kernel+bounces-567620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08A5A68864
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3E43ADC7D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7FD25D8F8;
	Wed, 19 Mar 2025 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCaOSDBF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891625D8EE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376781; cv=none; b=mpI87DYXaVSWCjU0qJhmUZ6EwfjNLzXkcaD+mCeNhks8U+prDkT5bCYOdNCm6dVCuSUUkqfjqE8p60Imjzhg3/LDo2eNSG/fYYpO5zCf+90WtOi0H1IfGzlrenekKTZSh+tw/6a86DptTGUscM41JGoZU9CLYWxwXbxCuouHYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376781; c=relaxed/simple;
	bh=U/ax1MvaRDrvIjffi7jRFwIYm3OR2o2Qw0xcUb1JN7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6RdkMLQfRdsxW6zzycvTaIXOsZ9NBvpJu4EQpkvDH88KfA5QccBMLD8ZL8knsbc3yL8dBedHAC1fc4QV+N1CBsKq5fpKU2vG0cCQYc9dYv93OaJZgMY1xcNQhxHcSJq+VIyjckWdTtA5STvROw50/K2qddmwGQByWp0NGHtcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCaOSDBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA062C4CEEF;
	Wed, 19 Mar 2025 09:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376781;
	bh=U/ax1MvaRDrvIjffi7jRFwIYm3OR2o2Qw0xcUb1JN7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCaOSDBFnq6cLHbacNuUh/0bFiQ/dRV7ZM+Me/nAzbybcxLOskrJfNB2+bWjlO/Tl
	 /HMiUQ628KcNrhkTDncxfZzQAgqkZAnb7lBP8BMR7xD5q8OJ4y/Z1SISgiqoWtYPM/
	 dZTGhhioxZUVIDNhEbbO8/kPBNJj1GCNZkrxxhttHCfZ0bGmPKdZhNNlrzA3MNeKKG
	 mJDaKg+zZ2WqoAsCCg0ZpuAjnIeU5imdXlHkuGP20JnvWyCC9JWzmRa/Ms1JQ+csi0
	 pxusGDxom4UT32t9iQ9WjmU4lMPlyntU8W2AhjhRE3DR5aGO7AITFvWtT4pqXjSJrB
	 9pU9pqmS2xeBQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 44/57] irqdomain: gpu: Switch to irq_find_mapping()
Date: Wed, 19 Mar 2025 10:29:37 +0100
Message-ID: <20250319092951.37667-45-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/ipu-v3/ipu-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 223e6d563a6b..333f36e0a715 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1008,7 +1008,7 @@ int ipu_map_irq(struct ipu_soc *ipu, int irq)
 {
 	int virq;
 
-	virq = irq_linear_revmap(ipu->domain, irq);
+	virq = irq_find_mapping(ipu->domain, irq);
 	if (!virq)
 		virq = irq_create_mapping(ipu->domain, irq);
 
@@ -1219,7 +1219,7 @@ static void ipu_irq_exit(struct ipu_soc *ipu)
 	/* TODO: remove irq_domain_generic_chips */
 
 	for (i = 0; i < IPU_NUM_IRQS; i++) {
-		irq = irq_linear_revmap(ipu->domain, i);
+		irq = irq_find_mapping(ipu->domain, i);
 		if (irq)
 			irq_dispose_mapping(irq);
 	}
-- 
2.49.0


