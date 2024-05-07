Return-Path: <linux-kernel+bounces-171735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0ED8BE7F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2648C1F21190
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DD316D33D;
	Tue,  7 May 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N9cyq3CQ"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE716C870
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097324; cv=none; b=N27/p46KxI7+3STPCbCQ0K1E3FPLyecM9ATokGxB4vMO/DpRMjq7Tql1rH7wKEXx17gY4plFOVj8IuGLBgOKjg8ZDeFvNBVAmPLb8idqu4gw6t2SrI7PPARSodGb6vEFWuuK0R4bncCyPRv5SUuY6zMgecymCEJAlfwSZL+xOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097324; c=relaxed/simple;
	bh=qIz58J9D08HEDbRnnXnEvA94us7AQDo0d2kZB+Mdj40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EfoCfAHhdqatBGiWoy/jgxSAFRaPLDGFZSN1i/T3dO90wDpTFMDFV2F+a4GdIu7Xc5WQDUHyheKhTCusOc7nT4FX06LU7iIKQXmGdrqloMHcmjvrAaLybhfef18PF/RlhUAcfkHfsUb/ANOnw1tYV/XLbECANn6r/blh9ILotqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N9cyq3CQ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-34d9b4d3a4fso2001347f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715097321; x=1715702121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENm7dGdRCegViXpKOlFOwQirdvQpMHKuwbsV2GUz3rE=;
        b=N9cyq3CQJy3fi/exqKi9OitPCwx9QKdlWuqzjZdXQ3R6OmMC64JoXHbvXpg4mqA9MK
         +1ihrfxoV7T2HK6tfA2aUeCqoQPkRR2WLVI9Pgm7HirT7sgPm8IvLTtdc0E0xAi25Bop
         19jGbiMK9JB3jTY5ncUhFzW6CE+h/lFp6iKyDLzFPBbZ8E8LY2tmT7Mg2GWZwssJB/vQ
         clAKgcmGCw8L9Uat8/C52EEyecbu1kX+DGFzC93SFo3Ev3kZ4Nw1gGiMYlOUtoiZogqK
         FyuDr4696/htDJxEMQ9btgZwdtvlNkEcNqYNtwO/wWOOvot0DG7w4ltRQbz8YlEOZ/s/
         r6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097321; x=1715702121;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ENm7dGdRCegViXpKOlFOwQirdvQpMHKuwbsV2GUz3rE=;
        b=DE+era91jqgNWRqJdXpCxT1ii7ZC4+G3LV15qz7ba5jM6DQkMFHOy+QVXbSu6oZiTG
         UUF9+FB6tdD0sEoiUYFUAgK/FK7Qab8EyefNocLYE2VHguSGzcTTYiwGUNrepIcX34Pw
         0F8FsJBu9AS3S8EfIFgV2Q7Lo4pLw0+iFW13GZC/X8hlTf331bGr9gZJJRnL2w9mwMXa
         cv5VR9O43TYLcLxWvkO3wB0skgsGkWTbdzO1z7+RC1i1ZzEpyXhFI9T5fGn8trcdhRgJ
         K4npygQ5dj2ToK1kqe4DtyZlQ5TqzhM6NJDqMvcQZL45Cx3m7gMwmB7kIFBx63uklXP6
         sPFw==
X-Forwarded-Encrypted: i=1; AJvYcCWZVvjZneAvdSlVR/xlyiE9GDloqDorzHtXJy7JsK0D0XnUz8FQuCWKsJyUo/WOoirQfLMvX73pFWOLds8+IET96zFBO4JUP3X5d4sy
X-Gm-Message-State: AOJu0YzPTFbMWd7LWLvFdwviwOX8v87CIo1v4vig/VYomOZeFaosB7qV
	jjEndkkmErpLBwqZdRWUlGoRVXZaT5/fmuFJBxAnAOuPFgQJfumXWuKtbF2H295DMRRXTngxzHe
	JPgaEG4IONQ==
X-Google-Smtp-Source: AGHT+IHGZ0yavujoh3USa9TPTOqVQ47cF03iCo0u4JgWlc3kP8zUzp3F+JtX/FYOC3mCEQ6JEWGwA5+DbsxNUw==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:adf:ed83:0:b0:34c:d3c5:b12d with SMTP id
 ffacd0b85a97d-34fcb3aaef5mr233f8f.14.1715097320472; Tue, 07 May 2024 08:55:20
 -0700 (PDT)
Date: Tue,  7 May 2024 15:54:08 +0000
In-Reply-To: <20240507155413.266057-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507155413.266057-1-panikiel@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507155413.266057-6-panikiel@google.com>
Subject: [PATCH v3 05/10] media: dt-bindings: video-interfaces: Support
 DisplayPort MST
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a DisplayPort bus type and a multi-stream-support property
indicating whether the interface supports MST.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 .../devicetree/bindings/media/video-interfaces.yaml        | 7 +++++++
 include/dt-bindings/media/video-interfaces.h               | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/video-interfaces.yaml =
b/Documentation/devicetree/bindings/media/video-interfaces.yaml
index 26e3e7d7c67b..7bf3a2c09a5b 100644
--- a/Documentation/devicetree/bindings/media/video-interfaces.yaml
+++ b/Documentation/devicetree/bindings/media/video-interfaces.yaml
@@ -94,6 +94,7 @@ properties:
       - 5 # Parallel
       - 6 # BT.656
       - 7 # DPI
+      - 8 # DisplayPort
     description:
       Data bus type.
=20
@@ -217,4 +218,10 @@ properties:
       Whether the clock signal is used as clock (0) or strobe (1). Used wi=
th
       CCP2, for instance.
=20
+  multi-stream-support:
+    type: boolean
+    description:
+      Support transport of multiple independent streams. Used for
+      DisplayPort MST-capable interfaces.
+
 additionalProperties: true
diff --git a/include/dt-bindings/media/video-interfaces.h b/include/dt-bind=
ings/media/video-interfaces.h
index 68ac4e05e37f..b236806f4482 100644
--- a/include/dt-bindings/media/video-interfaces.h
+++ b/include/dt-bindings/media/video-interfaces.h
@@ -12,5 +12,7 @@
 #define MEDIA_BUS_TYPE_CSI2_DPHY		4
 #define MEDIA_BUS_TYPE_PARALLEL			5
 #define MEDIA_BUS_TYPE_BT656			6
+#define MEDIA_BUS_TYPE_DPI			7
+#define MEDIA_BUS_TYPE_DISPLAYPORT		8
=20
 #endif /* __DT_BINDINGS_MEDIA_VIDEO_INTERFACES_H__ */
--=20
2.45.0.rc1.225.g2a3ae87e7f-goog


