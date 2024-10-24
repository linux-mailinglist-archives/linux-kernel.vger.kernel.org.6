Return-Path: <linux-kernel+bounces-379743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524209AE30D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7341F2331E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEC81C761C;
	Thu, 24 Oct 2024 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CLLhXWSK"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E901C2DA2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767058; cv=none; b=RLOEikq2SZIHga+JDOhCh2rrTcCmvwo/QERNaEFGM3guPu8MNRDcxmOeLVwds5qAOoZtGlLti2AsDEHP2O3wHJZW4m6WZGVWkqUwzMwduQ6Xhu+I9+/+SGM6b+vm5eQzcQgB9fDwclDr4+vOImrIq50NPcFMyC9hYt5Gx1zIMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767058; c=relaxed/simple;
	bh=/h6ScMpXgJdRH24J2FYQ5XhtS9CARF4+YWkkB73m6QA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4mxZQel7JDgRaIDzkswPI7x2tuNisLgE7sKlIw6xBE4KiCFJAqPM28Swg1Ne1C/unMoMpL+LhvkAL5SzmWWX2JzQByKz3rHWGLYjJ5t1v1AohJHePbMbABm1mVZsdq2aeK2xOmhporhufB5r47Rl3vbtulB2kuHAgW9aSrde+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=CLLhXWSK; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cb6b2b7127so915079a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1729767054; x=1730371854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qWdmaHz7Nux7p/WW92k3YpnxPIwDsMgrq5DymSLCxY=;
        b=CLLhXWSKg8MX8CqJSpVBsP41Oo8RTtUDSAuQ2CNYNrtjmfkEphrA4un6FL38WTtStd
         1UFZwsY+NyNeNtuQvSWZfBHDCPb6F3c99km6CIAqnGbujtBKbfnOWlE0Ge2OZ70znRqD
         Ms5OuvzSfGGsrKv+XfoAFkxZC7e8Nj2KVSjkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729767054; x=1730371854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qWdmaHz7Nux7p/WW92k3YpnxPIwDsMgrq5DymSLCxY=;
        b=qy7OAb2lygv1pXx4Oc8FOakcxW8OyhqmhgJ91kvO6XmTueSw4JCZWhphvuL5onO1Yi
         6ajagTBCs4+MmdW0HspQohtcvzqNhx1WGDAwmWpO0lTBkZpqKE7DR9jC6FNvISTVOiiO
         uZbl6nercXagJbZbg70fMgNlBKTy2GWSP+WgapMACuSWyXf9o9W90b0GvNdp2KS6cQE2
         ohsgYGWVNrhRAgcnAr8ABQW/J6MDw9l1qY1h/h5pnWzTVdaKv5g3vuckF5rpq7jRsIJc
         N+FJHGHci47NJMzdrpJnXy3/w1K4tE4w6UqGd8gGSv9f3BqUkblQLCfwxwhYu/yeaBMC
         +aCg==
X-Gm-Message-State: AOJu0YyUG38sY/lBk2S2D445CZv0CD5t7/NUODl4z2AxJgQOMUgwYBRr
	0X71gy6EqDjUp3+m7WKm+E0oTPTnLO6s7CEEl5Zf7MVUlbtmU7Mavd/AGN7IHUNxtePCEal/F51
	M0hg=
X-Google-Smtp-Source: AGHT+IHWsyISWq/FYUrYWrdlaP7r5eYT4H8Hp8tVEO31BNXzH1CneTvHOtGnGAb8Qb6yAFj15jLtQw==
X-Received: by 2002:a17:907:3faa:b0:a9a:f0e:cd4 with SMTP id a640c23a62f3a-a9abf964edemr607896766b.55.1729767054232;
        Thu, 24 Oct 2024 03:50:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:f79d:49dd:b804:3f48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370723sm601132366b.100.2024.10.24.03.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:50:53 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panel: synaptics-r63353: Fix regulator unbalance
Date: Thu, 24 Oct 2024 12:50:46 +0200
Message-ID: <20241024105050.3483542-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Trimarchi <michael@amarulasolutions.com>

The shutdown function can be called when the display is already
unprepared. For example during reboot this trigger a kernel
backlog. Calling the drm_panel_unprepare, allow us to avoid
to trigger the kernel warning.

Tested-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/gpu/drm/panel/panel-synaptics-r63353.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
index 169c629746c7..17349825543f 100644
--- a/drivers/gpu/drm/panel/panel-synaptics-r63353.c
+++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
@@ -325,7 +325,7 @@ static void r63353_panel_shutdown(struct mipi_dsi_device *dsi)
 {
 	struct r63353_panel *rpanel = mipi_dsi_get_drvdata(dsi);
 
-	r63353_panel_unprepare(&rpanel->base);
+	drm_panel_unprepare(&rpanel->base);
 }
 
 static const struct r63353_desc sharp_ls068b3sx02_data = {
-- 
2.43.0


