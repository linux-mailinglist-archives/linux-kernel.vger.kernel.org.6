Return-Path: <linux-kernel+bounces-362885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FA999BAB4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918CC281B52
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726B91487CE;
	Sun, 13 Oct 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb66guR2"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E4C7711F
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728843100; cv=none; b=J/A6HmmkoaDUNdmmoKWxnkw4RHSO5NQkodsp9jllF7rywyPDKsHIWIwIzyk8TlDGc0jY9U+8CkhTVU/d+XSJe3G6Cpm7LNi5aK3hvfAWQIoUyiYmWwQ4qxTp6J+GDcClKxw4HKSrGD+LfPYhOCglbJPdauawzsKg9WwPDGTb4D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728843100; c=relaxed/simple;
	bh=srLtoALgpH2ycJBqVY37tb2RPDzJt/d7FCNiw/5wN7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cgH3tO5aDElQuC+A8kkZoq+7f2v+8ygwEqE2IAxDZMluIkBgteaEhmJA/WovHnZBKKGp83xv8zHkPb8jaBQB4yHN/LAIJYClFwkrVkIH8PBi/yU55Ew2Sq5Ri4Xa61e9gnoFB5rGDQQRD5lR2j6WSS2OwQF4dLDqacKhVvOMV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tb66guR2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d461162b8so2316949f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728843098; x=1729447898; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2zAy+FUcsg1zkQlCl4ViFL7ab4bn9CrF2AFAn7y+v0g=;
        b=Tb66guR2eN0riKry1sI0KK8gN//jeJ4rATLPXtWtJNIUMGUX9Vidgeyta0OMGCtZru
         NQrLVexokk0m4P42qKT6FrnhvMCSw44hZf6zEkLZkVgeqj2rX+ivuSv1j5DskXmOy4bd
         mZi51ZEgOsuhhd1/EPRUGktwjB5QRZdL4S5YtNxxtNYqjZ7ODXddFHB3NaDF9s+hEdv2
         C0ZIyK+tNahJ3frf8mUlD836eTapeq0emKwVuWR6dwszCsgMixaQ37G0Q65pCnLWtHkQ
         P25rDcDzhmhbzUhlPkdsfaPSS41mtjHSmj1Wa4o38OJAG0WjhwFvpY4O9JnztxjE2kEZ
         rVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728843098; x=1729447898;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zAy+FUcsg1zkQlCl4ViFL7ab4bn9CrF2AFAn7y+v0g=;
        b=aDEOwo+l+wntZxHbZVz1fIgsY5dKfwHnkWLeaPq0EcvmdYJML8RBYqZdPBjXiZJAuZ
         6K61x/p81J7aLjsBbDrXNHyYSFSD/OyDYyz1uxO/xDH4/tTiB57EhtiIB1M5we6lhlGn
         DPNw88zT35VmkrScGeC3fLfoET6DbG0f1t6d9XbjTfswqbIRA62W9TDbhKc1YMMFvrXs
         BJeIa4dVkuJ4XqjbMs1R3dGWm9x6ar/7VD/xjkx7QRfW1MZLDUnCbNzUuC0qWKy1wh/U
         QnLbs8pXP9YDrGiA3J0QDjDcdombgwYlpZcEFwFf0rtsHKkEGgukAorwGKcrKpeTNGpM
         kUvA==
X-Forwarded-Encrypted: i=1; AJvYcCWCVodYEJmalmWaMfff/95zWzLUnPAgeqn+Ve42EV8tQ2ByJXwNGKPz9yPjucifRr89BJoGR8N7aT4CpwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYcAH0hW9clKIy/L0zhZI0IS1wyhbOzIRS8y+JLiQQgUiwEOg
	cBnrObs/1n6ND0kIeRroAHEo2waic02qh7G8eogZFlsDbbTiSb2L
X-Google-Smtp-Source: AGHT+IFPAFcveA8f3QvCLbwjqtO/rjeE4AWYqTqzBQ+pHh+j2qqAvDTEvKu58Kd9Q4R9rRI0qyef8Q==
X-Received: by 2002:adf:f3c2:0:b0:37d:3dfc:949c with SMTP id ffacd0b85a97d-37d5ff6cdddmr3859390f8f.41.1728843097396;
        Sun, 13 Oct 2024 11:11:37 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-fffe-da2d-f221-edef.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:fffe:da2d:f221:edef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f9d9sm9287647f8f.77.2024.10.13.11.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:11:36 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 13 Oct 2024 20:11:29 +0200
Subject: [PATCH] drm/bridge: tc358767: fix missing of_node_put() in
 for_each_endpoint_of_node()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-tc358767-of_node_put-v1-1-97431772c0ff@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFANDGcC/x3MQQqAIBBA0avErBM0LaurRIjUWLNR0YogunvS8
 i3+fyBjIswwVg8kvChT8AWirmDZrd+Q0VoMDW+U4EKyY5FtrzvNgjM+rGjieTChrORc4eBUCyW
 NCR3d/3aa3/cDjCo2v2YAAAA=
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728843095; l=1203;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=srLtoALgpH2ycJBqVY37tb2RPDzJt/d7FCNiw/5wN7g=;
 b=JMfU2cuUQPmSZDm+OGVR6jmL2LoX9ZciVXU4d4jwAJNW176LKXFdL5fSiR1Rhwp7Q3iCuQPMz
 X7Tai3xrTacDE0hGbRQI6MS61IMTa81cwphNYPRe7E9ZqgycSJ88VCP
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

for_each_endpoint_of_node() requires a call to of_node_put() for every
early exit. A new error path was added to the loop without observing
this requirement.

Add the missing call to of_node_put() in the error path.

Fixes: 1fb4dceeedc5 ("drm/bridge: tc358767: Add configurable default preemphasis")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 159c95b26d33..942fbaa1413a 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2405,6 +2405,7 @@ static int tc_probe_bridge_endpoint(struct tc_data *tc)
 			if (tc->pre_emphasis[0] < 0 || tc->pre_emphasis[0] > 2 ||
 			    tc->pre_emphasis[1] < 0 || tc->pre_emphasis[1] > 2) {
 				dev_err(dev, "Incorrect Pre-Emphasis setting, use either 0=0dB 1=3.5dB 2=6dB\n");
+				of_node_put(node);
 				return -EINVAL;
 			}
 		}

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241013-tc358767-of_node_put-14a3004e9f45

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


