Return-Path: <linux-kernel+bounces-245351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CA192B195
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB381F21B07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDDD1514E9;
	Tue,  9 Jul 2024 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bDvXZrOa"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5414F9D7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511465; cv=none; b=luDorwpYwXeV6rwROvYIb6RsSq21t7QEXXNimxmN9Re07wxbsEB5P+aiTIWCIPkga4h46X94QDMtUHMdbZKTNIC6Tjz77DOChyXHwuiv8CwaV0BSBzfkFIk8zHCzWEii5HUiCp72d+t4ocKe1U1hxGuEDYFmSuUv9mYkBRLJdR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511465; c=relaxed/simple;
	bh=GW+EbPAm4hHbTsC2x/kPcfW/1ojBg+BpcgL47NVHa7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CtdxrvYG+JXu6LTC0pSSboSIqeSAwpNxpNjule0RaGieq3KF3GhhZfbQZ7jTE3tT+pSwf2nH2ncj5BzJjgp0bJO70AQmzcYNqSLKQPJ1xD1qA3D3zubrASPlpww+Vntt8D/XBWw+NTItKpEIH+Ic6hlVrP7X6vnovJjXSHCBjqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bDvXZrOa; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7201cb6cae1so2403363a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720511461; x=1721116261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rH2LKJ5HJHgLjNSyzU2sfO5c0h5HphrNELJ/X033wjI=;
        b=bDvXZrOa310Sq5JdMHv/6mXp31f1tesUlosHL8XCbuhTwQnSero0MtuPmQmc75K7tT
         jJweti2sONTgOeObHcz5Hddhw+VizP6QH2KKUxH2JIF8d6aIwogdPCxZqOxr0rCYx6aH
         gYAQyXfu1TWWIh4TA1RBUlhw+DZnYspZoqCkC3TwwMT/sL7kb9XAkyBsFJHDpNVq65j+
         EVA5Ue5hKFH1Xh7udIL4wmgse/x3R5IHaiVJJyTqKLe0K10MwnMynqJeXRsu3nVePMLU
         widcmoLfPjkQ6oEKVlC569rPBmvYgk1PS0x1v1Xxc7KopRWwMayTe5Tr0piYJn0OypMj
         a/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720511461; x=1721116261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rH2LKJ5HJHgLjNSyzU2sfO5c0h5HphrNELJ/X033wjI=;
        b=gJf9XAL/rU5eoIKmny0vZHDHbSS+SKNiARhQrdK7mPoSsUuhgdUiQdxFmTt7ccIoL6
         zxS2eTjwJE8fo7JnvSThFYzD75T2eClSIkE9CyNK7yElZtSMQEDoLc6A+E/q+Uyh/0qO
         2xTud5ZyC0XcodRacQZkEZ/pklptCNts1eWD5qweM9HElMnoy/GNssA0HC9wugF7Bzzu
         ++/0+/FV/imZkNzKVzlTJtF2Evs1MTeMwbKjSv6ES8KfDcPlA7XaChMjbz2918B7cs49
         5xUQG22zRiP5mbE9VlobdJBrXFgvtEpkae4WWMp+WjAv2z2GLoZvq2Lu2WNd14re3N4r
         TWxA==
X-Forwarded-Encrypted: i=1; AJvYcCWooq+3qj8sFQ9sojWSvlhbdVsHeQJD09yr6szJr3LqP0RNOd5qDlxn8+T4TbVLsRKXI2HK6nib9piMtHn6KblEg3JXqPeKJs7AcN9K
X-Gm-Message-State: AOJu0YwoIsdYpnMoBptpkYTcM8GNEgt+/EoKZcheLNa7ZIWcCwhj4cGk
	+KzrHKGuk3fIhC57KO8KJNxBNFFQ5lrsmwCyV42aux1jetTiJFlMXYGnVvTKRmo=
X-Google-Smtp-Source: AGHT+IEtzhNLYwdsLUEB3IkPaB9LK4j2KJqmSU8T6ZSrbB0fgnQxWDy4bJlJajo85/AGEYmPcUSvTA==
X-Received: by 2002:a05:6a20:72a5:b0:1c2:1ed4:4f90 with SMTP id adf61e73a8af0-1c29822de17mr2198873637.19.1720511461277;
        Tue, 09 Jul 2024 00:51:01 -0700 (PDT)
Received: from PF2NG7DJ-CGA.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa621e7sm9369708a91.41.2024.07.09.00.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 00:51:00 -0700 (PDT)
From: "lixianming.19951001" <lixianming.19951001@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	pbonzini@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lixianming <lixianming.19951001@bytedance.com>
Subject: [PATCH] virtio_blk: stop all virtqueues when 'virtblk_probe' fails
Date: Tue,  9 Jul 2024 15:50:53 +0800
Message-Id: <20240709075053.811-1-lixianming.19951001@bytedance.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lixianming <lixianming.19951001@bytedance.com>

We have already enabled the queue in 'init_vq',
so we should stop all the virtqueues, just as
we do in 'virtblk_remove', when 'virtblk_probe'
fails

Signed-off-by: lixianming <lixianming.19951001@bytedance.com>
---
 drivers/block/virtio_blk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2351f411fa46..fb702be291c2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1559,6 +1559,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 out_free_tags:
 	blk_mq_free_tag_set(&vblk->tag_set);
 out_free_vq:
+	virtio_reset_device(vdev);
+	vblk->vdev = NULL;
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
 out_free_vblk:
-- 
2.20.1


