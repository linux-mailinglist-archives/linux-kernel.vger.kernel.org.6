Return-Path: <linux-kernel+bounces-386007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930119B3E04
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1B91F2319E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9191EE005;
	Mon, 28 Oct 2024 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U7y0r8Hy"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8811E22E4
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155856; cv=none; b=ICGFAAJ6AhKqnCN1729u8Jdwqq/LLn0YANCwOE/S2aWliBfsf/SfMlYPO5A1kUPxhidkglliuYXGlfLk7s4R8hZ80nF0ttVIVE33wj2n0DEAW/wKux07TvlVVFSY+nOA3wK8x3DUmkgBnFepUa3eozxcxFf03pFxRYBVYEgqNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155856; c=relaxed/simple;
	bh=0H8DFmF7y5ovlaHbJUj8X0ThVLF5mF7KlEW7bI+3/yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=orC7JXOzTs8G3+9hmrCTw6FH6C/4OpFBKw1vEw6HwVHUzBilxxDGIvE+3vJpbiHhCvaHXyJsGUtJTMo64fCQXPLOWyclBiDXkLJ3ujWtOzdvnnD6fkATqDGKfrv4VfyKs4HP0QoP0EhJP8Je37QyIqClg8ok+PnbC2J/0iMHKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U7y0r8Hy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315eac969aso33952795e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730155853; x=1730760653; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AHbs6/0mSLooEm+thfv53bqPunINve7/jCO5kyMCTTk=;
        b=U7y0r8HytB6IuSHagBWsa5QSd2XtxyawrsMPaUglcoT0Fbtxrm5M3jF9Unx5xo3eve
         07fpmvGFvRif7bc9R8N239IIJbzBk2I6+d4TKm+6aMNTSmjuuWn8FKAMbLv2TmsFO86k
         c+N069warQj7TmYCKNZed6rp+xcA4WHOAPulOiQoMCfCGYj8WiAKvA0xBU5yvKcZC0YU
         uwKUMz+eryCvL5depHSqxbPyl6nXVfZeYQKdmjDnHAniZcUzowZuWds9biS9nM8unJRC
         F0KN2V5xW0p1FWpYxddy7oXmLdl++8HCoCV6invy/M8duf3YqITeXmIq3a57lLAjMrBl
         We9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730155853; x=1730760653;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AHbs6/0mSLooEm+thfv53bqPunINve7/jCO5kyMCTTk=;
        b=xFYNdZ4u+FJVYFQzb5m2wL9YpMUUFoHoJ+QdDR6bQbgJd38pwTjikxxml2ecO6Eezd
         3Tj6N3QnXME0gNOS1/fzwEYpL3cOdc6HVuAdIqin9uG6wlt/G6P/nrxQmIg6sAHKMYxV
         JbFa/lMaBQoz10p9+Cmvy0xFAITrHF5pQ2Rayw2/T9VqvR07cScVvurk+dDzZpKw6ap+
         w8oghQVndjyU1clahaXOpMgofoLxFVSx+vz9NJK6TcJJaX4U8+SMWEdApWnsA3TRoN8m
         wq0zlikFLX9tAd2QtmXvTy3uejnyrAwRbWwVQFWP8XziqMX6QZxORUyRFA1vXJ0rsmfO
         uQwA==
X-Forwarded-Encrypted: i=1; AJvYcCW+o0on+zUu7j16C+bTrrhurQBjQA0y5sbfaFm6dlkco2aPoprMDmGuHl+hdy5hLq5epOeH+TCedbuWXQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC98HAVokY5RDVDwk/uAMzG7RwbZp0XRX7rzPACsi1LUU+jNd9
	j4Y+JQPQkFc9576y7p5M21yt6GbsUw16MQPFq6ngem7GcLJ58C+kPFR+CfxJCA==
X-Google-Smtp-Source: AGHT+IFMb4eytDVqC9RhangzDfmj4P9hfRrryG8fhKdC1BivhfX1vuTe3qToeQLtrAUMlF5BQg5i4w==
X-Received: by 2002:a05:600c:5106:b0:431:3b80:6ca7 with SMTP id 5b1f17b1804b1-431b5630e8emr522865e9.13.1730155852938;
        Mon, 28 Oct 2024 15:50:52 -0700 (PDT)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f6db9sm126894465e9.29.2024.10.28.15.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 15:50:52 -0700 (PDT)
From: Aleksei Vetrov <vvvvvv@google.com>
Date: Mon, 28 Oct 2024 22:50:30 +0000
Subject: [PATCH] ASoC: dapm: fix bounds checker error in
 dapm_widget_list_create
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
X-B4-Tracking: v=1; b=H4sIADUVIGcC/x3MTQqDMBBA4avIrDuQDKYUryIu8jM2QzGRDJWCe
 PcGl99bvBOUm7DCNJzQ+BCVWjrsY4CYfXkzSuoGMjRaQy/UGjH5fcNQvyUpxszxww1X+aELnp9
 kR+cCQT/sjXu+7/NyXX/VPWv2bQAAAA==
X-Change-ID: 20241028-soc-dapm-bounds-checker-fix-5bae621455b2
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Aleksei Vetrov <vvvvvv@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730155848; l=1354;
 i=vvvvvv@google.com; s=20241028; h=from:subject:message-id;
 bh=0H8DFmF7y5ovlaHbJUj8X0ThVLF5mF7KlEW7bI+3/yk=;
 b=ud05c+Q/+5iy0MDJTuWQh8oNcHrqNgswkh3uuGHryM7n/yWqOZw/bfSZnx6hWMosFyHe1CkZ3
 Yl1W/TmD3+mCAKIe1m1b/Rl4G4QWkNvxEghilO4Q50GvwEJEIBoCJuu
X-Developer-Key: i=vvvvvv@google.com; a=ed25519;
 pk=b4c4Uc4EKDS3ie6P4xhkyobon88ZGFLMHyo8kw1IuM4=

The widgets array in the snd_soc_dapm_widget_list has a __counted_by
attribute attached to it, which points to the num_widgets variable. This
attribute is used in bounds checking, and if it is not set before the
array is filled, then the bounds sanitizer will issue a warning or a
kernel panic if CONFIG_UBSAN_TRAP is set.

This patch sets the size of the widgets list calculated with
list_for_each as the initial value for num_widgets as it is used for
allocating memory for the array. It is updated with the actual number of
added elements after the array is filled.

Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
---
 sound/soc/soc-dapm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c34934c31ffec3970b34b24dcaa0826dfb7d8e86..99521c784a9b16a232a558029a2f3e88bd8ebfb1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1147,6 +1147,8 @@ static int dapm_widget_list_create(struct snd_soc_dapm_widget_list **list,
 	if (*list == NULL)
 		return -ENOMEM;
 
+	(*list)->num_widgets = size;
+
 	list_for_each_entry(w, widgets, work_list)
 		(*list)->widgets[i++] = w;
 

---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241028-soc-dapm-bounds-checker-fix-5bae621455b2

Best regards,
-- 
Aleksei Vetrov <vvvvvv@google.com>


