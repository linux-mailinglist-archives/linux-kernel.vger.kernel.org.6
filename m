Return-Path: <linux-kernel+bounces-171734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 455918BE7F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ABD0B261C7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B1316C86A;
	Tue,  7 May 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x5NNW2yH"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B4D16ABF3
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097321; cv=none; b=dO+Kswpff7A/CbOOAmg5tXMVN/JTSzWIhgf+Ts+R+1QMqlyMiJysAgb/oA0Bjmp0JGPaymqMyJe7tiwrMdG9g5q6h166D6Bj8nPYCJ8WryKUhNYmvfz7mcggM91Bv0kaQUuq2FbRqzp0dpYit8sQG+h65cTg+M91KGZbgCR79oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097321; c=relaxed/simple;
	bh=KhCbjoA/06jeubkCS11tvBfMHVe5ZRQaUzmvzb9QDSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GyKUNAuZqeemybM/GwGTjgABLbbfFsBN/bWBEZUkuzZLCjGU+Jcg6rIOISVKpWUfBtankqdjOotRb747d6xcAoDJ0S2B1P7Lnad9pJ2mgXgyWJHsXB2jmeVQATLB95JQSQNEL88qylrC/S2VNc+fnLjJ03on/c9Bjd5VsqfYDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x5NNW2yH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-41c01902e60so17353725e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715097318; x=1715702118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzknyEmyvVzgzBEo4OMYewpyUdmIS0YAGmrGG+LYZzk=;
        b=x5NNW2yHVQQjFUuOeDgw+Vu6ssbVXbva1XxMq06ZQq/9PhbQdQEs1+xbnszHLRmBbG
         JbTsYzNJbt5yQKPOoYBRAuB+pFN66R94gBE5FwC+FjQMig5too1NQQSNsoQ/GJ7VNvsV
         FeS6EY3DGmV8kO9ugM662kWjq0NNweO5yRyITYHH7aen7pt+hMKfTKYUcg58JrIjGHnm
         P9pRqgvnX/KWAVNz82LN06qFzYH+DEa76KaJZGQhOdbExHStM6YQZG+I027R8VCW2ES0
         zXnr8Y/uKrqmpn0zZYgFyqhrGGBhADjL/9aMpB5DdWG4vKMzAEN+lGgQagS4bW3L7gyy
         ZRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097318; x=1715702118;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RzknyEmyvVzgzBEo4OMYewpyUdmIS0YAGmrGG+LYZzk=;
        b=J00ZGR9p1fVp5umkdbRL1y68PCy4WVVo52/Bijl337uj0DBDq1xFbNRX2ADooSexG4
         RgiobtxaAbM39/yi1XI6JOX0McISgQDQkTxcW5UOv60Y9zyzao4NoCE2OyZPC76Sr/RS
         7f0hRXMBegCyplqgjc3oMMzZqZZu6/6HKCrDYlSBk+akbLsp8RtyjMXUFoMs/FE9wjJU
         bfJnDjQBXNv1lWRL0wOIvmKGKyak8Gs4VIO4zvVfidQemtAdpSe5hH1GuN043H9SurL5
         S3jlHYp+Rg1y+DwqO/vidrFbU1NnBCwV0QUAd3beVJkJM9Ov4ifpsvBRJJyzY3bGm2gS
         Ku0A==
X-Forwarded-Encrypted: i=1; AJvYcCWUYGDCVi7FfA2kZYaGpAolPtyZ1bBKgVOt23mW3Dfr7kEYrTmHpmoB9h2Vb+o+wAVxCIjHDsmPGxflb+nj9abyOATMsuqdjTbdciCN
X-Gm-Message-State: AOJu0YxB0fmraVe/H4ydpGwbO7VlTgOZZwUWbOOiBI6dW7ipWs7f0RbM
	vZOveYnpCV0Xlz93tSV0qfIRH/0mtQ9dGr8uZBOTQ6wEGpzVWjlVJdomoC+4Y3DIg7n1+E41qdQ
	XP/EobJsxnQ==
X-Google-Smtp-Source: AGHT+IEfytt8Dhiq2I47yZrUwHQciNP88LYTB/g+cEA/4WS4cOKmFtLwYQq3o/Xf4ToqYtBf6nBzC/fJeCL3Dg==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:600c:3b8c:b0:41e:a06a:1688 with SMTP
 id 5b1f17b1804b1-41f719d5d8bmr35295e9.3.1715097318342; Tue, 07 May 2024
 08:55:18 -0700 (PDT)
Date: Tue,  7 May 2024 15:54:07 +0000
In-Reply-To: <20240507155413.266057-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507155413.266057-1-panikiel@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507155413.266057-5-panikiel@google.com>
Subject: [PATCH v3 04/10] drm/display: Add mask definitions for
 DP_PAYLOAD_ALLOCATE_* registers
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

Each of these registers contains a single value, but not the entire
8 bits:

DP_PAYLOAD_ALLOCATE_SET - Bit 7 Reserved
DP_PAYLOAD_ALLOCATE_START_TIME_SLOT - Bits 7:6 Reserved
DP_PAYLOAD_ALLOCATE_TIME_SLOT_COUNT - Bits 7:6 Reserved

Add definitions to properly mask off values read from these registers.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 include/drm/display/drm_dp.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 4891bd916d26..1c397a5f8fc5 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -734,8 +734,13 @@
 # define DP_PANEL_REPLAY_SU_ENABLE                      (1 << 6)
=20
 #define DP_PAYLOAD_ALLOCATE_SET		    0x1c0
-#define DP_PAYLOAD_ALLOCATE_START_TIME_SLOT 0x1c1
-#define DP_PAYLOAD_ALLOCATE_TIME_SLOT_COUNT 0x1c2
+# define DP_PAYLOAD_ALLOCATE_SET_MASK	    0x7f
+
+#define DP_PAYLOAD_ALLOCATE_START_TIME_SLOT		0x1c1
+# define DP_PAYLOAD_ALLOCATE_START_TIME_SLOT_MASK	0x3f
+
+#define DP_PAYLOAD_ALLOCATE_TIME_SLOT_COUNT		0x1c2
+# define DP_PAYLOAD_ALLOCATE_TIME_SLOT_COUNT_MASK	0x3f
=20
 /* Link/Sink Device Status */
 #define DP_SINK_COUNT			    0x200
--=20
2.45.0.rc1.225.g2a3ae87e7f-goog


