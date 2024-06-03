Return-Path: <linux-kernel+bounces-199544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB178D885F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C838C1F225E7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2657D137C29;
	Mon,  3 Jun 2024 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="j2qs75v7"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7516135A46
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437822; cv=none; b=cUGkAYcdXJzdywteaUuGnhBZtQMvia6HCTcH6VvLgymFY0Yppo22vWpFGtybUvKVDH1f7krYDy/yflBTwzWZ+jXNKgBzIcMrj5hARQROz12w33vh8cpibqk7CIhjqqLcYnAgjV6sAodxV/uw8PZ1Qa6GwQS8izVGQ+SyEfSFToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437822; c=relaxed/simple;
	bh=qkR+XwK2cnQzgCZgDWp8dL3MNwc2lgcgu16NqnlBhRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ufZwPS8bEFKJmq2CNUWNeN2XKfAGdpj9LzTE8ZehO1X1fhp3+qp8Mk9/KsgMesuYg0RP6UOjdA5GNnptio3waOdfsG6uFGPY3hVkSHBQAZP3tYpd/c3UL5xQmjrhk+mlzFPkwWDQXZ1Z4azgPbzfAt8T0hQ7yBIswPRPuaoAczU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=j2qs75v7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a32b0211aso144867a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 11:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717437819; x=1718042619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7TPkYuHgg+gLnBsrbKhRQC0OqluG4mID27p8/iWKRL4=;
        b=j2qs75v7IyagH3DJAwm3MpTe3MrGGVdXlA936x32HT+27zkaWTXfwwboXb58IyLbvj
         0B/rNIeS1NQ0N25/RQ1biTKtvqU5mVCvyFHbJE7R9XGr7y2FUYOd9gHIvz6sYXVPeOA5
         41QzT7Ze/t7gd8jJfKb8pmcXYtb7gqoS0GSU9uzIB2Y4zcwdRbJ/Wt0vUoCz7zXhGBFc
         B0DVBXHJa4+53jh5QFX4i4PLwZHI8W141Dln8P9nKiy3023FRf4mrxpMXbzGzy/krB33
         rmOg1LBe6Iuyub5Ic/VziCWE4bGNGiUeu1sAkucWTdrTwomxaINCD++ZjtU36e0qHNCu
         erKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717437819; x=1718042619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TPkYuHgg+gLnBsrbKhRQC0OqluG4mID27p8/iWKRL4=;
        b=igacPOTwqrCWP6XbWnWPKwdlPRX3TsLzfxTcmzLUkKYhDL13aSTE0/ICQFyQgOF/Vy
         tqEzQybE6R6NuDUdk3bpx7+m9H/CQJBpFgBqQdf/cBXiMZ+wV5tliFfu9IHrq4WAi2Np
         aVRJPu5oV0B1bz8VAV1GJzTm3m9pl5qDVqCkPdOj5wrJkPd4n0Q/hzVpFqoLcT6fNYta
         7Jp6e6AllHEIhDK5RTETaaVawHDO2wBV3zL7bvn5C/Pva8CiJGgKqJ+rcayan+lizZ1v
         kExCdQgDfej5i4sS4kAV6wJ0HloV6j/+ZVamk53aY/EeMdZthwtcJJbfd9LG/TZghM2h
         Y4lg==
X-Forwarded-Encrypted: i=1; AJvYcCWe3V1SlKgpmKoepNMN+VmeD6w2MNwHyFS8jfJr9AcbO4Bu8yxmmET7PdLYn93t+mf/En4fpee6VHDHv23N6Z5o0U8BCRvbG907s3gQ
X-Gm-Message-State: AOJu0YwoRuAxgjFNa8ce6bQ1s4SugMXSezkh07/ODtOyWe580STcAYN1
	pM0ZG/D1l+9tV74Ycl/9aUxieuArEqxFpWgYKGZnW1fO7YoJ+qJsWormThqK8oU=
X-Google-Smtp-Source: AGHT+IF3e1jIAkkZakp9bDQCCh8sQNC6LAEwH/bHwmzy6c4E4ZcH5ahX5INbvrL04dlbGKPBJ578ZQ==
X-Received: by 2002:a17:906:f8c4:b0:a59:e52b:39dc with SMTP id a640c23a62f3a-a682234b8d4mr621238766b.67.1717437818913;
        Mon, 03 Jun 2024 11:03:38 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-81.dynamic.mnet-online.de. [82.135.80.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68b4b09cb9sm391917366b.178.2024.06.03.11.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:03:38 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: lucas.demarchi@intel.com,
	ogabbay@kernel.org,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] drm/xe/vm: Simplify if condition
Date: Mon,  3 Jun 2024 20:00:07 +0200
Message-Id: <20240603180005.191578-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The if condition !A || A && B can be simplified to !A || B.

Fixes the following Coccinelle/coccicheck warning reported by
excluded_middle.cocci:

	WARNING !A || A && B is equivalent to !A || B

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 4aa3943e6f29..3137cbbaabde 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -85,8 +85,8 @@ static bool preempt_fences_waiting(struct xe_vm *vm)
 
 	list_for_each_entry(q, &vm->preempt.exec_queues, compute.link) {
 		if (!q->compute.pfence ||
-		    (q->compute.pfence && test_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
-						   &q->compute.pfence->flags))) {
+		    test_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
+			     &q->compute.pfence->flags)) {
 			return true;
 		}
 	}
-- 
2.39.2


