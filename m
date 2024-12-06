Return-Path: <linux-kernel+bounces-435367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3732B9E76A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39D31882A20
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB041B4138;
	Fri,  6 Dec 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKyfF8Cg"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362C206274
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504609; cv=none; b=RqM3RZtCum9B0VN+6HYLa3cB8n8k6zoJmfcbXSLx54F+f5oHpySwMek432XvKXwXv2n8dbCoECnP5IWe0XJPWLx4zX5F2SLnd3xOhMMMvQ9DKZ3cCdOWqOe7POY5nDGyTiftiB2VwhKIj4mdgk4ANYOTi6OyvwyyVUMehHAKOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504609; c=relaxed/simple;
	bh=lfyH55q9UYpWYXdB/6XDXIazuOkaVWqE1/7ZCh9lgsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t67hHztxVmWXcw5TQTUgWngXsZLPJzFFROBgHuT92TGDhWr38sEmiUvbJydcd9wCKFZfvluX/w5YTd3lRepc/tGVX8vroIS399xctz7EIEzyqyhiPYecTKZWQzDC6ZOzr4ozjuncHLTEZytQtul7SNQ7ohg5WB0wNWB/HYTB4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKyfF8Cg; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-841a9c504d4so147358539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 09:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733504607; x=1734109407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dFYeC2ggW3uAbNOBdbSsj7OtslV8NoVLj4AJjNTegtE=;
        b=LKyfF8CgV4NcnN0j/Sh1H6QIkazWo8AHcOk73XyAcibjVomcY7gRv+v3kIF03IS3of
         8ux6N5puOWXzO0k510oDNMm3qir8Zr2pwfxBnCxtekGE3d9doGeqekWsCVgAZHrNz51J
         n0mfgXs0UR2kNxEEX31hgBQnJfDLXySox6RoCsGMVprrV1rjVdstUdfqPNWGRNhP7Df4
         DdAXHRNfdmG97xDBpjHIeAeo9oGRSNRCGvFBvGrUK8EtkUItfulYwFRyL1F2K2pv5yp7
         bvrNJ+8TYyL1hxOfPcm4K+h/eI099DagaxlOTHMBVRN6CvP6pm93u4EqTLAZGvkJAgF+
         Oehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733504607; x=1734109407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFYeC2ggW3uAbNOBdbSsj7OtslV8NoVLj4AJjNTegtE=;
        b=ukjroz0rSCFK7GaWqf8Q3a5nLgGUY4TffVpnK3cJPhtRD91PMZjgx1P90pEyozJHw+
         wGyfWxY0Qq3zfDylhDaDXfAyg8ZzB7yY4Ncj+nQSq2wirO0wfLzdOf07vvw9XMeqG56h
         QdGVVagro/7ohfTwhvP0zfu0HlI8FrU0tAO2TuTNqbwTnX9+7iLWtMjYtImMmo39HAAJ
         wsmbrnkhEVDJ4lO7tBXUZdu3BhXCfW0UZl6NRRYmxHDBew0jeiSrmcK1FEp1t9jkZ+T7
         LBfIpPEiXl0ZbVjHUIGyTylOI42nO9xGem5aHpG9VVWYCHYclWSEqj3DItoMYlPoQRu2
         dc9w==
X-Forwarded-Encrypted: i=1; AJvYcCVY8TFre3XHbl3TUwzdN9VlA90iQXK/jQUTJOvKzvSWhjXQSK9WKOyFjm2DzEyMGINkSB2BG/++JUlQBUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8cbIEmW6LBo5Jy2bsjIYL2WvKu0P3VZ8t8mM3ipecZ5mLIC/C
	DGUATaSZz/epVtCF56DWxFJjRMYc7euqs1QQdrairgwWlFS8dbJTwj6zoQ==
X-Gm-Gg: ASbGnctLHi/ny61nHmOKzmx6sIFXkF8hL7v/iq1gqXy76p4Ec8GJyoekkKbYHSeECFp
	bIlFBiTfNM1uK1Ci50eiEJJyLhA5+8+aYlWeISXryYVKpgU2zirpaJwDZxqP2wCQLOmmLNMSdjf
	q6wE2e8tF4HDRffEKtNId+PrzOJi9GlFc050GcYNRUqvHrCDfCOH1/QIMV1+Sc5Smm+Ya8iF7A5
	jvZ3WB4SSZ+9gN8+rAcbIr912QGyO7FwH8UqRvgHVK9kUh/h7h30qMc0BnTolsFjbr2P8rSTpEN
X-Google-Smtp-Source: AGHT+IHfrrwfd6H9P8Y9TtM8QUR2MQ/vH2sFi9rdk0KMDhijn1+TWzSMrAkdqBOETOtYMyNanxdcyA==
X-Received: by 2002:a05:6602:3402:b0:82c:e4e1:2e99 with SMTP id ca18e2360f4ac-8447e296ad5mr431902039f.11.1733504606846;
        Fri, 06 Dec 2024 09:03:26 -0800 (PST)
Received: from inspiron7620plus.lan ([172.59.229.198])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844737bc53esm110519039f.4.2024.12.06.09.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:03:25 -0800 (PST)
From: Guy Chronister <guyc.linux.patches@gmail.com>
To: maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	airlied@gmail.com,
	Guy Chronister <guyc.linux.patches@gmail.com>
Subject: [PATCH] drm:panel-orientation-quirks Added DeckHD support
Date: Fri,  6 Dec 2024 11:03:20 -0600
Message-ID: <20241206170320.2789-1-guyc.linux.patches@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces a new quirk to handle specific orientation issues for DeckHD panels on the Steam Deck. The quirk ensures the correct display orientation for these panels, enhancing the user experience on Steam Deck devices. Tested on my Steam Deck to ensure reliability. Feedback and further testing are welcome.

Signed-off-by: Guy Chronister <guyc.linux.patches@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 4a73821b81f6..9a3beca9f79c 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -455,6 +455,13 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galaxy Book 10.6"),
 		},
 		.driver_data = (void *)&lcd1280x1920_rightside_up,
+	}, {	/* Valve Steam Deck (Jupiter) with DeckHD */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Valve Steam Deck (Jupiter) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
-- 
2.45.2


