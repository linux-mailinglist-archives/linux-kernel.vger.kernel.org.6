Return-Path: <linux-kernel+bounces-400526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CE19C0ECA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D741C25F2B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9C5217677;
	Thu,  7 Nov 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3MoWKu6"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F927E782
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007194; cv=none; b=aTfJUOKp+luyEPuTl4SQthVH/EuSGWAOwYf8pE+0egFp9CKuu7jXX89Xim6Np208+eFVGBQjalHmQgemOE1CncH6zF11tHdK42RWNc98y0wHeqbDNWR4NQE53fkUMBJn/nkJ2hrGV+DyT33/KI4MfEY0lOEKOvNV1kw5YoqzJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007194; c=relaxed/simple;
	bh=epwaAKL6z/vr9Qa+iuSsEHyh1Wat9F+jzorfnphZDzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n66BU1AF/z7OEQlQ4+zht4U959G8p0ZAnqn+4LUKw5j12mclZTzJ+5Dy0SYxvIjAfEXDdmI8urHG2hgB2Ha17Zcn7WYVNxKhFyW0kKIh3tw5uzjIeuss/usEsnVf2oyLH5uWoRCb/d5oMxYQaO6DE4eS6mrSTMnwg7g1PRH9uw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3MoWKu6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e8522c10bso197756466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731007190; x=1731611990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lz0x5nr+zytSDXNC3TjwSD3fvnHBp9KDDJ6PheBe2/4=;
        b=d3MoWKu6pPBAzFgNqaU3krvxA15JrwZvuqpes6Bmtkqqmy33+zUMVoYz5fvla2rG7k
         vdsAbifq8VWLLH4l8sdmuxOwQqbb/Z4PS8ZTOfFwCCTPVCicevrZ5AZLlqCC8YliTafY
         x/4wkJhKC0QxegGywqJSdov4/bY/j7j6Ji9ca1wGUKlrrk3bQBhVCd/uIAzzCGghyy/6
         AyTUxiMCRS8SlGpzAcIa0rch5EySGbAJjdEWhPeNa9FHwyh6O/T/lJaNJCGGzb5rk2ol
         8wFgqnNV1otmG5eJd682ocbtsnP4XYIsnA8jrxv+g2ewbfLgZHBsM8vZ9QStNB/AXcjT
         kJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007190; x=1731611990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lz0x5nr+zytSDXNC3TjwSD3fvnHBp9KDDJ6PheBe2/4=;
        b=SRUsUiv0bW1Kiq9GpatETS/S6GfxJAuD5bOScdyhk5gxodlMT7jDkM1cSIXdtcSy0b
         LQkmfCRiAOkiHFae4zI+iS8ej/5lczGHY42SCWJLzjb9pcSPdqKgvAc8OZ3M/JIA8f1z
         xMz7Pa/R7Ul7HXwW41mb6xXofZQf0Ec7GKrmDtPZx1WFQNe139C0d57x0CdXk6q46Bc/
         /vLZxRJFqBoo47xfJIYsqP3LVFvgD/8kK2IldBuHZXl/nitUYuyar8eNdhzCw/AU4PfM
         xQy2ld4RrPZ0wtcE3d6T2TM+UfX3lq3xQw2Fyi4HslxNgc/7KQNkUBjP0ub3pk13sJDI
         sC8w==
X-Forwarded-Encrypted: i=1; AJvYcCUkBUvWVucIX07f2ED4oNTKZC+BPbHzrfNTsRrtdj4g37cOppnpfZnAcCmFF3ggKjGvmGgel8zrmoFw1uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMG9LIEcD6FL79Z7LUi10oCHlCkKg1ZuQHVEqPJDW2kwCUQ0Cv
	OS4Bq3+GlH+LZp7z9+5fWzuBE0KsdpCz7PE8ES1rzNFATzNIoN3J
X-Google-Smtp-Source: AGHT+IEkLuumkMpxInzmBkBdOYglzCszz1XgQbRnyBEWkOKX6vYSz1RY83BmnkN2yhVDyd8CXPOasg==
X-Received: by 2002:a17:907:f1aa:b0:a9e:b174:9cf7 with SMTP id a640c23a62f3a-a9eec993bbfmr62509066b.13.1731007189753;
        Thu, 07 Nov 2024 11:19:49 -0800 (PST)
Received: from DevOne.. ([85.206.117.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0abea92sm133553066b.85.2024.11.07.11.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 11:19:49 -0800 (PST)
From: Gediminas Repecka <gediminas.repecka@gmail.com>
To: mst@redhat.com
Cc: jasowang@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gediminas Repecka <gediminas.repecka@gmail.com>
Subject: [PATCH] vdpa: vdpa_sim: vdpa_sim_net: fixed cofing style issues
Date: Thu,  7 Nov 2024 21:19:41 +0200
Message-Id: <20241107191941.37300-1-gediminas.repecka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed coding style issues reported by checkpatch script
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 6caf09a1907b..0705aff74cf3 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -53,7 +53,7 @@ struct vdpasim_cq_stats {
 	u64 errors;
 };

-struct vdpasim_net{
+struct vdpasim_net {
 	struct vdpasim vdpasim;
 	struct vdpasim_dataq_stats tx_stats;
 	struct vdpasim_dataq_stats rx_stats;
@@ -293,7 +293,7 @@ static int vdpasim_net_get_stats(struct vdpasim *vdpasim, u16 idx,
 	unsigned int start;
 	int err = -EMSGSIZE;

-	switch(idx) {
+	switch (idx) {
 	case 0:
 		do {
 			start = u64_stats_fetch_begin(&net->rx_stats.syncp);
@@ -543,7 +543,7 @@ static struct vdpa_mgmt_dev mgmt_dev = {
 	.ops = &vdpasim_net_mgmtdev_ops,
 	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
 			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
-		             1 << VDPA_ATTR_DEV_FEATURES),
+			     1 << VDPA_ATTR_DEV_FEATURES),
 	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
 	.supported_features = VDPASIM_NET_FEATURES,
 };

2.34.1


