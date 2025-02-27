Return-Path: <linux-kernel+bounces-535677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E81A475DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959A77A3AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C941EB5CB;
	Thu, 27 Feb 2025 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="VIjxa5kf"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ADA21B9E6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636992; cv=none; b=jf9PO2wZ2eZ++IXI8C78dTQuTq3WfsqMdg0FDYUd4D2o8jeFJIaa56YZRJu8AlG3d9EI+LAoKIbCO/A4wlwqXpe/Ai7NcgueJRN8wqhqgBKDgE3z1zT+kXuPf1//qVsvMT63LY5rXebqLbpV3X98Evr1p7Q92/Zpijydskf8KJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636992; c=relaxed/simple;
	bh=FprXlwf5FNOqNXB7rLjZwqKM4fIG4idwE/s0iLleCoM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=K51QbY/Dtl77bjSlW8zeY2O6N6NBikxn9gXDXw4koYEWb/1+KMmqpiqcedTODwpdw85Fx4u+J3pnrHvmb5o87AcBU6zlnBSoxFGLuhSMsFU+7LUUMoQZGOd7uJ0TYA7yjUslV127ioSU+YxvPu0QtM1nA0MsptZl8oRlDw2r03c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=VIjxa5kf; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1740636979;
	bh=F3ApL+JeDj3lZFD/DdaVFfxrPRTF2KrKK9eGSSim+FM=;
	h=From:To:Cc:Subject:Date;
	b=VIjxa5kfcIu0r42/PiK6V26jLGe+aa0+k9QaEnW+6i0FmXSjbisdiYmaRMC2j2bhm
	 clg/VURVpZHKqmYn2Fxo5/f8EFG2oJnxce39xE6R421ERsmyOtrxLyc/113kQb4S8Z
	 bVi4YJcQXhkOAcSO98Bgm5hLTnIpGkpc8N/v6ql0=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 283BCA36; Thu, 27 Feb 2025 14:10:03 +0800
X-QQ-mid: xmsmtpt1740636603trv9hp5qc
Message-ID: <tencent_0B119ADC0E546990F05E3727AB7364AEAB08@qq.com>
X-QQ-XMAILINFO: MIOa0ndEC0BblRG9mBKOGjwVz6dYFOm/8zfpux30lV2XceDC4J3biozxfv8LsC
	 8ADOslqitConxJltL5mq5EOjZA6iDqLZ/UHQZZ+Q1FajJeVbVmcvVO2IFO8uRqa7pkJwFSewtU+e
	 Gqa8TP08EwZwR6iquaZg8jzUFP4CMzwPquxlXQpQZccaPFz6LmN5nHaCh3PPHoJo0kTC15bvAvr6
	 en1Zba+EFK+AoTwFTpD+3xv3njDIUz0nl6/f0l8wU8NFmeKck9gKDav1l7reUKaaLUTHbPn+AYbK
	 dFImohiIMbD05QAufhzRSMcvq6e3flBWbJzvghKUQxeG6ysYeZTu000MEXr24VyNW3a7iWfLwDe/
	 529bj/oDmye5RA0xnNVBIkzOMcm+sZlP7iagcDrKAKRcfBDFn0fzRWjZ+gt2Bew1rTQJgR76etcC
	 iksofHXZzBvFOWPljJsvv3Q/HzOYfhJUuvfpPbQTVpEaxvHOEJD0dsd7vOzWusS9V3MjJt8vbvUc
	 3uju1X6U43rJS3Yvt95+RIH2o66ugE6KCa4kDysH3aFZNMD+2/LtxZHRMJ4O9uoko14B6+319ywP
	 BmIeLF+U2dSfJ3Nhp0jWPu+hcjfyGhdXswxjUNn5eUaKBQdsn1b9jr3igEouQdcO95CAR3og71mb
	 o8q/bCUVa0S9sZmkkQ29zYQIsMreH04x8DX+MXuXn85P3ewdG9T/3Dp4pUhg1I9UZt5QE98le153
	 TVAzXLDQ4XogC1fc5pPq5liT94UBlUhJgHHhZtj+CVCZ0YfFcJoz6nw5WUMrt2Vwk4Ei5qz4fwTz
	 o+j0sY8PhlHIOKvfa6veFjzMLO+s946NZSoyLqUh4SjrzOvR3rOF/sitG3i4c8ezqSIvogH7QD8b
	 2XeMP+iIOlShNUFfVBONfvrwO7G1sbZProP0hMuHeyq+fcr8l3wPBC+shIFwUDxLz3puk8T2xf//
	 q5fGrSz4Y=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: xiaopeitux@foxmail.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] mm/list_lru: Remove unnecessary NULL check before kfree()
Date: Thu, 27 Feb 2025 14:10:02 +0800
X-OQ-MSGID: <ccf2e7de4caba7b16dee2aef2608f72e1ab974e7.1740636544.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

Since kfree() already checks if its argument is NULL, an additional
check before calling kfree() is unnecessary and can be removed.

Remove it and thus also the following cocci warning:
	WARNING: NULL check before some freeing functions is not needed.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 mm/list_lru.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 7d69434c70e0..7c8fb17d9027 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -548,8 +548,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 			}
 			xas_unlock_irqrestore(&xas, flags);
 		} while (xas_nomem(&xas, gfp));
-		if (mlru)
-			kfree(mlru);
+		kfree(mlru);
 	} while (pos != memcg && !css_is_dying(&pos->css));
 
 	return xas_error(&xas);
-- 
2.25.1


