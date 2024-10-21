Return-Path: <linux-kernel+bounces-374534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C039A6BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B1D280D66
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9591F9AAB;
	Mon, 21 Oct 2024 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XBikVcUv"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE41F80AF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519705; cv=none; b=dJ5GuNDm+N31STT7hktj/psZGLg+u6Uk7CWQFPGuCEeYN17bYPWIgZrsiBGN4y8dCRLO+ErIwgD4hUsR2jt0c814fDKeIVxlUNXeUUQIXfVgNBV0zhPJ0eQ7pJs0IYgswUV4zQ+4NO10SE2NArXjrpGF+m5b7EwpiPy9TopaJwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519705; c=relaxed/simple;
	bh=1q9cAD7VxRnLeVa0WQH1ibBnEmicIHZOce8e+2t9JMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEsDBOCiNc2DTZNUotTJtmlGKRgUwSOtaBb0UmNaeMiZ63jy0Sa3VUsrfzDsKIkAIsOgbsaJm7Emx6z7EGYrIN3W35yB9c8Bup+s9HXlyocCpHAYdYXLWPQwsPm0vE6Gjc016BFOTye2zrWZQvAOFm9QJuN94W02K4zhYgeNs+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XBikVcUv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A5AC18B9;
	Mon, 21 Oct 2024 16:06:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729519592;
	bh=1q9cAD7VxRnLeVa0WQH1ibBnEmicIHZOce8e+2t9JMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XBikVcUvALTtM6eoMckNqaCTTcFD7snAw0RbAWIX797OJ4rHtYCUJ2xCmKRAQje9u
	 juKiQpG6fFleh4lgl4CH7er0JDBRcdnTxF+1kjoqMFIPKva52n0V0dTwXSMmh6YNAQ
	 xifn0vI50z67VV2kos32QQdUzK2fbF6a3CiapJZ4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 21 Oct 2024 17:07:47 +0300
Subject: [PATCH 3/7] drm/tidss: Remove extra K2G check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-tidss-irq-fix-v1-3-82ddaec94e4a@ideasonboard.com>
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com>
In-Reply-To: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com>
To: Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jonathan Cormier <jcormier@criticallink.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=963;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=1q9cAD7VxRnLeVa0WQH1ibBnEmicIHZOce8e+2t9JMA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnFmBNB8YAVBBsW9C7Qu3rJKCDj7kd7zVLgXUGj
 o7J2z31cFqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZxZgTQAKCRD6PaqMvJYe
 9eouD/0UpgWjIbRmVs4qd9KM4zU+ULBEJ1Zah+myAQaDWAqNB2FCrKjqbXfkP3rkqskfXXpfCwv
 tM81LZ3PQ8fn3XTuiMNnS49iBJt3qL6DZ5vkXNZ2Jfpmz69R6n+fTptq4Bkz8F7vE2KAojRKWMb
 bsCmlqm0hqzkNXw2RPT9NZyqvhLMT0fgwIuig5aEuTxBpgvIp0/St9CpH7SNXOXNM9XKL6uGlDQ
 tmLUsagaO9mVI/7O2ojjLqRGM4s9QpgovpJRqzKO0pjklJJDB71gz7BzpTTE3l8yGkwATR6JF7D
 TE5EFazPcrq3qsJx+5ldHeRf6Ud7jY2PE4isme00GhRMkvCRCicYbn9rY8L8Bad60+cfViSfLSc
 4EkMNeH1tIVO3APaxSw+7l1TEmCwxYZPSFnyCK3Vly6VvbW7o3SZPBSnlbGsDLFkA+MeUj3bsZR
 SFlFCv6O4DpkVEvIBU5bsGvEsvO9ciNUF8xHs3rpPsLOAlUi0dpax3QSwtfscagfF0i+nHm4FmP
 HA4TdCUKVHk5WKDj31cj+t57JZiRV44vNctuVRXNsOKTHu1CO/RBPlqMUXM2beX2kfibQzimU3p
 BbQKmCM/+iK+uZh886gjm6kcaItvjvyVyLnXtPlo7gBs0B1OA/tODR//CLg0b0LHGcihJ1JLZgQ
 CbC1728dvCllzNA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

We check if the platform is K2G in dispc_k3_clear_irqstatus(), and
return early if so. This cannot happen, as the _k3_ functions are never
called on K2G in the first place. So remove the check.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index f81111067578..99a1138f3e69 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -789,8 +789,6 @@ void dispc_k3_clear_irqstatus(struct dispc_device *dispc, dispc_irq_t clearmask)
 		if (clearmask & DSS_IRQ_PLANE_MASK(i))
 			dispc_k3_vid_write_irqstatus(dispc, i, clearmask);
 	}
-	if (dispc->feat->subrev == DISPC_K2G)
-		return;
 
 	/* always clear the top level irqstatus */
 	dispc_write(dispc, DISPC_IRQSTATUS, dispc_read(dispc, DISPC_IRQSTATUS));

-- 
2.43.0


