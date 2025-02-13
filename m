Return-Path: <linux-kernel+bounces-514004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74AEA35138
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F7C16DDB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9682C270EC3;
	Thu, 13 Feb 2025 22:25:19 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D31270EBA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485519; cv=none; b=Vwmv93Sm96MIBcM/955T5XBI2y+GZZYAJUxgVlO/VIqjniPYlQhbAmbVra48u/3NKxv+1SMQEJgTYsrHBRJQz7OWFJvz13o1lwAb7JaWv9W2Nh9cIW19SmY5NNl6xLZ/FRXsD0/jWUekxP8z+noUASCJF+A/jIt1xzlF8NByIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485519; c=relaxed/simple;
	bh=reJZqKGA9Pqo8284TKtpEfsscDRdBI+RDmImGM4D5QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flok6fjDifYwYrzW9j2lKa3q4mk/MKYKf+CuNDOL65f/WUgjr8RAcyPvm4YoeG+FgFUU5HhFp1Waxj/YqLYbpcJX1CH7CrAAGzVAQm90NCmoCB/ufMcpMWuGIn1cIX+QbRiEZ7wa5ny5YakYnKj4yyXkrpNtKIWuUgdJ8oOuIto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72700b5056bso752416a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485517; x=1740090317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eTQnFsqbcvmvatv+aySiG7hGLvYa4g1Z3Z6TofLd/w=;
        b=eDQkZkPJGOvLD0wnTs/VfZLh3FfpyBdoeZW8kUU+gsystDiYydshTETF9MwvDiFBsw
         wV9Pn6WJ614nFOOFpSIrJFeh9bvsj6pSVcv3rpAjNQFoLRvoJHMqOFdg3IYWiYQSoO3z
         NnJN5z/n9aV0e1gbtcIzbNkB7ePJHKwkcL2OUvw8wIOFREoZS7PFR564kv/womVG9UXV
         gDmsPgzQAR3mUWiZNmWkZf65KAhC+eX1EzKxxDAbt4auGMiMhh+NxanogtFTo1qR/UHw
         0tys9KrYk7BkeH+Qq6A8Jq0fkT6vwPtH63cZdHwTNni7MQ7M/X0XIW6D/ZkhAbRPhvr9
         jRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMjOv+qQ1GKEaLi44PNMK6QCpqTJkCoi+I8RjZErifejdGhvyrkS+1HyN7x18XR1g8VzA7EOpuxi1GycM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgYcBCi+B0W5ShPaSpa4EGIEHWNq9zC9tSg53UfiwXW+ISyivk
	s/wFjY0kGd4NYDdATKQghlmvO/U2ovYdCZbEzp0dVSjgMBksuEmx
X-Gm-Gg: ASbGncv8QMCCEwjgKUuk/1/quGrvpv9OelWy9Zoun312TckDAl2D3szopGfpxrNcaoi
	lHUXYwGBqDzik3JamBuiOd6mGC60pxeyWUaejXkFk8U7wRJUlvibP4NZlZflOU6sE8qCyBDkXdl
	1T+KXQqdk9vSwKNTiNXKkUc+pp2bORvhagVqZaTzjfXKVknqVVokqNT+ls8SUy6FXdrVXw3vKBm
	bWAkXwJyavIFCCds+LoDWqirbXYdrNnzW3t5O0FLc1MJtYRuu7cz7mxvZ+/IUj1CtnWIS6yfALc
	nJ71Li5JqW3++l0r
X-Google-Smtp-Source: AGHT+IHipVy8Ez4Nu22Q47V+pVq+mOtomnXSTAzpHpquTaE6egG89MM7IbaCk2ntH6Fzt5ZgWkCvcw==
X-Received: by 2002:a05:6830:6e8c:b0:71e:15f7:1a3a with SMTP id 46e09a7af769-726fefd3a0emr2801644a34.2.1739485516705;
        Thu, 13 Feb 2025 14:25:16 -0800 (PST)
Received: from muster.uejji.net ([47.188.205.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cde00sm984184a34.5.2025.02.13.14.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:25:16 -0800 (PST)
From: John Edwards <uejji@uejji.net>
To: Hans de Goede <hdegoede@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: John Edwards <uejji@uejji.net>,
	Andrew Wyatt <fewtarius@steamfork.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Paco Avelar <pacoavelar@hotmail.com>
Subject: [PATCH v3 4/5] drm: panel-orientation-quirks: Add new quirk for GPD Win 2
Date: Thu, 13 Feb 2025 22:24:52 +0000
Message-ID: <20250213222455.93533-5-uejji@uejji.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213222455.93533-1-uejji@uejji.net>
References: <20250213222455.93533-1-uejji@uejji.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Wyatt <fewtarius@steamfork.org>

Some GPD Win 2 units shipped with the correct DMI strings.

Add a DMI match to correctly rotate the panel on these units.

Signed-off-by: Andrew Wyatt <fewtarius@steamfork.org>
Signed-off-by: John Edwards <uejji@uejji.net>
Tested-by: Paco Avelar <pacoavelar@hotmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 9e6708cd1..e6148cc31 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -339,6 +339,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
 		},
 		.driver_data = (void *)&gpd_win2,
+	}, {	/* GPD Win 2 (correct DMI strings) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "WIN2")
+		},
+		.driver_data = (void *)&lcd720x1280_rightside_up,
 	}, {	/* GPD Win 3 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
-- 
2.43.0


