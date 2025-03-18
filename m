Return-Path: <linux-kernel+bounces-565507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBB3A669C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34617A5F17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6C2158DD4;
	Tue, 18 Mar 2025 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOuswNmL"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F329246B8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276829; cv=none; b=fjwYx4Q7rmYqxucONbH1z6fngVf29zJvMxaRX+5rND2I+amf+PEIJdbk0X1uQt8DjlOQreOBofyodajxvFtM+0aw1gNm32SZ8pcyT/l7TNjbrEChQ0sJ8g8lorqkhw9ppuPEkPkuBfMth0QQjpIJmozBITU15iK7HrKDzxA4va4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276829; c=relaxed/simple;
	bh=mLdYU/w9X+D2bG54VucsG4sh/kvVaOg0fmem/5R5XgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zxpo0j3mqwxIAzrc1arTntB9wWwu00TG/EGRUyV87+n22gEUvQptgzoRtEI970sFVvRWw/uKr9yTAiba8OP5Gre4EJxfXS1F0KcGZMNpBrHXlUft4mPnV9C4hjaBSvdrgqPxDOejI/74UX43ixaUGdvy3yk5XDXlRQU+GgMcKt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOuswNmL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22438c356c8so90090385ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742276827; x=1742881627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TpCgJnRkoeuUTlrXYvZ7NafdeDfj/AUprgdRQoatxjU=;
        b=VOuswNmLkFlAdEFpd/kO7CgjDo/U6RNnAxt562GORj7n2T8UW2ldgu0xQo98GbUsKf
         60WVkEpE1zPdsRbDjrmutIb4RrTrSpSTO95Yut1FABCvfnxEzs/sc78vYKCbYMo2qfvm
         Q1gexg+552pCyyMLXAn1JfHjUjnXwmrWYa4qWtwxpr1RHSU7ka6FqXVZCPWDd0UQlLyX
         wku5U7ZljuniIb5oMO8KVgFqLMdlxztV6fiei48o6ztabX/2SZDAwP6Qs8nRSPomalLq
         x6jnYmJ0sAJ63B/Qs8EhSiNMQzK9NJ/zeFgi3rpLfodbDNhrbN5uzrMjT+wrkSWpvPzR
         LjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742276827; x=1742881627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpCgJnRkoeuUTlrXYvZ7NafdeDfj/AUprgdRQoatxjU=;
        b=Mfa9gUnUmWBjmc/4AD1vhIyyKSabPT0Sfsej1BkL6m/gpplzkJga1jLaFDuq6MZyYE
         AsJo+iP7w/x+MRxnmi3AgxbVbq1s2LxVQZi5qx3iHTZ3FhUdcXcyPOAwPiLNRN1R43fx
         Qwuxq6x+G47lOzW78urUqadtOigm9e9PsTWdMX8w89hU66aqQo9LNh7CK+gevXkcvDYd
         Ug0R7/kJkaa7n2sJ+7QoaqlCPJkVmX+dUEWxVjIcZXMgVOrfkA7CWAs9MMRtbIz9NVwr
         rFMpdJywh28mm53TTJRG892hwQSJXn4frgHcxzZM6p+buDlYJuwc8/7gwd2flsc9csmP
         53Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXLQVjxIjXNW9qSpeZGqNfIDiBNB+FdZxc1XukRsIZuSoMS5DPSASksUJlBAzgrrSMrcK1zDJ/1x5WAbog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyggQ4B5gEprPM2vt6c68LQSG6Jf1nEttPcDDV5kMeVdSYMI1Em
	DvD+ZlbVYu2534Yx14vMcRTH1CVLrSzXUYnhu8U7oyjSdF1KZhb5
X-Gm-Gg: ASbGnctEJl7lRko4AYLMcaWizfrN/S9YktSfjMNbbl9E1c+C3JTmcZ6Mi2Nv/o/ozkw
	xuuHEWMduphUpI1Lb2qgAXBJzMzTg+qQcbp1omtsfSwFQ4AZBwQP1RjIp5PlwAxGS6A1lIOWZ9J
	7B2UI1r0zMXR8HHqvJ97FucvVh7HsLIaX6y28hcoGqfKJCF2joRE9jCwMQlVLzFT0v5MhLVDzA8
	iN2HU7/WBAQIabkBi7dx1owI8KoqWRIr5aVX/zPyeSgaz/GvPufPX8gB4mvlzvKCOqNTSOIOcJt
	YOp9wFYjtLvd1jN5chUWEmSGJE4eoLf9d+jeoLOHTU2jLwM=
X-Google-Smtp-Source: AGHT+IFHgr1s55Po4V8qDYywMUiJEQrSF1gWIK4sZAf5sm1nhoSpNClgPqFDYCcEN3MVgQ4e+FUFmQ==
X-Received: by 2002:a05:6a00:1911:b0:736:3979:369e with SMTP id d2e1a72fcca58-7372235450bmr17422019b3a.9.1742276827127;
        Mon, 17 Mar 2025 22:47:07 -0700 (PDT)
Received: from HP-Note-Host.. ([222.234.91.137])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73711550fe1sm8903613b3a.53.2025.03.17.22.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:47:06 -0700 (PDT)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: David Airlie <airlied@gmail.com>,
	Jesse Barnes <jesse.barnes@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bob Beckett <bob.beckett@collabora.com>
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm_fb_helper: Reduce duplicated execution of the drm_fb_helper_hotplug_event()
Date: Tue, 18 Mar 2025 14:46:38 +0900
Message-ID: <20250318054640.249840-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If drm_fb_helper->fb_info is already set,
Add an if condition as below to execute the hotplug event
only when the system_state is SYSTEM_RUNNING.
This will reduce duplicate execution.
In particular, It can prevent drm_fb_helper_hotplug_event()
from being executed repeatedly at booting time.

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index fb3614a7ba44..c042e5a2e046 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1939,6 +1939,9 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper)
 	if (!drm_fbdev_emulation || !fb_helper)
 		return 0;
 
+	if (fb_helper->info && system_state != SYSTEM_RUNNING)
+		return 0;
+
 	mutex_lock(&fb_helper->lock);
 	if (fb_helper->deferred_setup) {
 		err = __drm_fb_helper_initial_config_and_unlock(fb_helper);
-- 
2.43.0


