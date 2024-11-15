Return-Path: <linux-kernel+bounces-411361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7A39CF6EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 22:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02257280EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0EC18BC3D;
	Fri, 15 Nov 2024 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BopIwSEF"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835031DA23
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731705493; cv=none; b=Z88o3QrgXIOokXJn1K+xlYb6aGS5cE1WSTP8jI663ZBSc20CknG8TzW5SpM5Ab2bM28m3GCiACXnod902ptPh+G3BN0GjJLvYG07h9GtKADFEgWmaLzKF8M2+bBTZdO/bNjFX2PnvnsD6pOY4K+MSbJK4e3SmRjwclWfpc5eMOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731705493; c=relaxed/simple;
	bh=U31aJb3nj1WK48aQ3gyY/5Ox2NnZ+GIJLmYe5LXz9K4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bmwFX3HQiTtn7zpmTV6+zp/SI/XvTLiZRpFpH2Of1rjxmiVSVADLTmWASs5+PFdi264Lp2G9pkJ5GQ1nFdR5PvmAI3oICdgBfkpQb5oAiXntZcEVg3qmTC9W+zL5mo3x9tRfapNLufwyNYwIxD4NbeP/jfct1fY7cdt70FhNBRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BopIwSEF; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b150dc7bc0so356785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731705490; x=1732310290; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ktpPIpScaeZrvvX2nXn5N10awI15hiN2fEar3uZkg4=;
        b=BopIwSEFVqLMAT9N4Ilv/HkZTf2hAipuiuu3ON7c68UoOQ42cglgC0bCuhNLh4fWym
         qCXckI3uXyMyU65QPTc2TKC/lCB/9SgqpBP6RmZAmcX2RcR6FUdIkC3db+JMx1gMfvxS
         R52Wg1GadUvRSIKGGAZvEXVMSgn5atW0WAWkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731705490; x=1732310290;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ktpPIpScaeZrvvX2nXn5N10awI15hiN2fEar3uZkg4=;
        b=wxYS5wzUXBGNRyYbpEISIe1Nsfs34XuN+AO89sqaX9ZW9irbpLiq4GFGyVTtVbSh6J
         IM+svqeln02aIyiw2K37hyqrzByR6QkLC9IXisY3bq3cscAtA1RJPqTYcmOggjlfoEbE
         n8S11oTgnVx9xZYAXi/LMwBn3BpTGVGm6gpYtm6MD4z8GUfmWroOJER+3j6ffjZ6lbZf
         ns4a1NbzBn4TSXABkEgpvLQEPfDUhpg3unXVgZjh1SeIqpRF7Uz3f8cwkFQdY8KoiZDh
         e+44iM5ifjLkWk2WgZcW0YMJ5GehtYgUmWaCcFsk8oVxXkdHWKxKZ9lLox+MtJelnJIr
         H+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuDxF96P4MxGbug8L1Sz3bpXmk0hK7IFZmU16xXf6ZIhstOu7A9oVTHqEVwD0wqTWL8niFDpt/C2L6jIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+L+EH8WVpDUtQ+0hJH1iJLqzzFJysVl/DG0aFyeewEo985iF
	67+gF8TXcp8PuDVRzBGPqlWmJrdxjhTSGIXT3Fw3XBrGd5beBaG5/XqTO6QCww==
X-Google-Smtp-Source: AGHT+IE2A9GCtwE3/owQJADRhxcYUckzzduFbZHTdlECCq0jAYNjYOc/PgF+/w+kQmwAjzx8y1wjNg==
X-Received: by 2002:a05:620a:c4d:b0:7b1:4536:8dc1 with SMTP id af79cd13be357-7b36236406dmr634270585a.62.1731705490448;
        Fri, 15 Nov 2024 13:18:10 -0800 (PST)
Received: from wilburliny.c.googlers.com (204.246.236.35.bc.googleusercontent.com. [35.236.246.204])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca58f06sm200356385a.113.2024.11.15.13.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 13:18:10 -0800 (PST)
From: Steven 'Steve' Kendall <skend@chromium.org>
Date: Fri, 15 Nov 2024 21:17:58 +0000
Subject: [PATCH] drm/radeon: Fix spurious unplug event on radeon HDMI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-hdmi-audio-radeon-connectors-v1-1-d6d66d3128dd@chromium.org>
X-B4-Tracking: v=1; b=H4sIAIW6N2cC/x3MwQqDMAwA0F+RnA1YmaD7lbFD16Saw5KRThHEf
 7d4fJd3QGEXLvBsDnDepIhpRWgbSEvUmVGoGvquf4QQBlzoKxhXEkOPxKaYTJXT37xgHnOOaRq
 nT0dQi59zlv3uX+/zvACACToWbgAAAA==
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Steven 'Steve' Kendall <skend@chromium.org>
X-Mailer: b4 0.13.0

On several HP models (tested on HP 3125 and HP Probook 455 G2),
spurious unplug events are emitted upon login on Chrome OS.
This is likely due to the way Chrome OS restarts graphics
upon login, so it's possible it's an issue on other
distributions but not as common, though I haven't
reproduced the issue elsewhere.
Use logic from an earlier version of the merged change
(see link below) which iterates over connectors and finds
matching encoders, rather than the other way around.
Also fixes an issue with screen mirroring on Chrome OS.
I've deployed this patch on Fedora and did not observe
any regression on these devices.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1569#note_1603002
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3771
Fixes: 20ea34710f7b ("drm/radeon: Add HD-audio component notifier support (v6)")
Signed-off-by: Steven 'Steve' Kendall <skend@chromium.org>
---
 drivers/gpu/drm/radeon/radeon_audio.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 47aa06a9a942..5b69cc8011b4 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -760,16 +760,20 @@ static int radeon_audio_component_get_eld(struct device *kdev, int port,
 	if (!rdev->audio.enabled || !rdev->mode_info.mode_config_initialized)
 		return 0;
 
-	list_for_each_entry(encoder, &rdev_to_drm(rdev)->mode_config.encoder_list, head) {
+	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+		const struct drm_connector_helper_funcs *connector_funcs =
+				connector->helper_private;
+		encoder = connector_funcs->best_encoder(connector);
+
+		if (!encoder)
+			continue;
+
 		if (!radeon_encoder_is_digital(encoder))
 			continue;
 		radeon_encoder = to_radeon_encoder(encoder);
 		dig = radeon_encoder->enc_priv;
 		if (!dig->pin || dig->pin->id != port)
 			continue;
-		connector = radeon_get_connector_for_encoder(encoder);
-		if (!connector)
-			continue;
 		*enabled = true;
 		ret = drm_eld_size(connector->eld);
 		memcpy(buf, connector->eld, min(max_bytes, ret));

---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241115-hdmi-audio-radeon-connectors-f8ffac989b0d

Best regards,
-- 
Steven 'Steve' Kendall <skend@chromium.org>


