Return-Path: <linux-kernel+bounces-310236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A15296769F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 15:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFC11F20EE7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 13:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3FA17D374;
	Sun,  1 Sep 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek31ZHao"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051523AB;
	Sun,  1 Sep 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725197509; cv=none; b=s8fP8PfTGfVhcF9W5/dqTA3PtD8tikltT4+Zt+FGxsjN7+i7yiZbfx+Nqt4D0uJaWwrxApRwuamm5mdFrMgvSGPw+4fyjP4jP9N8tdDnBc9Zcrxewa1TTYceVdYLthj5ndJVb/PHeaiLOBStmEeM0nD1vg0MqE07AluLg5+knd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725197509; c=relaxed/simple;
	bh=JNljzAsLk1yix2R94u1el+6SzsoPt7b0S5WPiCNk9lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8USlSG/J10FOYtzDOnJF9bSnNRTM8vf2oh42cbrMdLi21EXZEAIQQUZOCi/Itpy072Crh9kuYKzQ3H1I92mSM9b/gBJ7UQthYTR34fi8D1wnrcMohpYNmpn9Nq4Gb9wZhuyahKFXsz6+B3W2lxIhRg0CZS1u+XqLt06NN3H00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek31ZHao; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2055a3f80a4so3388365ad.2;
        Sun, 01 Sep 2024 06:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725197508; x=1725802308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YsKWtzwZWeFCKs3FaZQWcU1tv/xpkAb6aBGtye2T5F0=;
        b=Ek31ZHao5L+hxnrkqW9bPl2ntlEMLBkD+w/3x0KATR2fo6VAZFDwvVeUEtdtd0L725
         Ud4chjkLlTJSNXjwQyJMhvdNDQTRY/Bd/kHspMJP3vLvZyMV/NuI9CkbBuK7yHIc2dbI
         jZfUS5Ah8Wg1Y5IsFQx9h2ggZJaKJuBUH2qMGBbWufueTTf5swb0LM4SkO+Oh9ltKR6+
         Xg+rpGiWU48AN1ToAMo3r4ntz45+axXwoJPOIPtCOzYiXBUg3bp9r0sih+7cQaIQmyok
         wuJbW6YMbc0i6ujS3pr8PoCK/vqI4Qj53NGWOf2SdmGoozVhC/29urXnWZEt8Fav0PJQ
         S7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725197508; x=1725802308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsKWtzwZWeFCKs3FaZQWcU1tv/xpkAb6aBGtye2T5F0=;
        b=LAEhMqvIHTvlmZAANnpoXgmVIZIFun/jytHFJfDZz4RyrKQRp8Qs1+3/6QaxrJj0GU
         jF9QX57alODRO3HWmpaNuQGwKRpAPSvhkaTMNygey5mMO0qPri1PYOQZUrYbZqXpFICf
         zt4aWB3kh/0slRqWnKLNwEGM1KIU5jMbD060cFJaGZbfZVmLnDNcwXojB38JlcvxZTqN
         mrN5VV0E77ZEriYGbrHdNGwLZrIjmcowvU9mPA+0/zmSVYjUqWBnVgTujlr1qJoqVPBf
         krQ0xAEdXOqCjFokwWG7idYVAeZJDC+VzljUohvM8eExLZkg/UlIWtbKxDVhqjnHxXJg
         17MQ==
X-Forwarded-Encrypted: i=1; AJvYcCULYX6OLVh2XDe7D48u2SkQFuMy7CaaioCmEmYNod65GuKPOceDYrqzg/bI3TQ5L82Ol8v6IZiP/ixB1Dhq@vger.kernel.org, AJvYcCVWY6SYDY4J8ctp6qH9UvmzcvJbAKv5kvqu64puI0WsTC1TmoOcqkDoIbCE9uR/BHj/i4zD5pqYajYm@vger.kernel.org
X-Gm-Message-State: AOJu0YwXakDzqQFSX+JNVgivQiS/JThexyauDOG1r2Uk8iIphQMMD3Mm
	S2yFmV/qJQQlAjJuXNC2BlpYua2/w++RrZhebBGZRPpfwGBBgZNr
X-Google-Smtp-Source: AGHT+IHQskFo37TXYCxhkNM81uJOuzYc6x2rHUQiqaFyx3ld7bVbcmmjdrJ/L9XTt8DUGUelsCLEcA==
X-Received: by 2002:a17:903:228c:b0:202:508c:b5a6 with SMTP id d9443c01a7336-2054477bfafmr50122015ad.46.1725197506157;
        Sun, 01 Sep 2024 06:31:46 -0700 (PDT)
Received: from eleanor-wkdl.. ([140.116.96.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515537a2csm52691525ad.176.2024.09.01.06.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 06:31:45 -0700 (PDT)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: laurent.pinchart@ideasonboard.com,
	thierry.reding@gmail.com
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH] docs: devicetree: Fix typo in lvds.yaml
Date: Sun,  1 Sep 2024 21:30:46 +0800
Message-ID: <20240901133046.962263-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected the spelling in the description of LVDS Display Common
Properties.

Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
 Documentation/devicetree/bindings/display/lvds.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/lvds.yaml b/Documentation/devicetree/bindings/display/lvds.yaml
index 224db4932011..b74efbea3be2 100644
--- a/Documentation/devicetree/bindings/display/lvds.yaml
+++ b/Documentation/devicetree/bindings/display/lvds.yaml
@@ -16,7 +16,7 @@ maintainers:
 description:
   This binding extends the data mapping defined in lvds-data-mapping.yaml.
   It supports reversing the bit order on the formats defined there in order
-  to accomodate for even more specialized data formats, since a variety of
+  to accommodate for even more specialized data formats, since a variety of
   data formats and layouts is used to drive LVDS displays.
 
 properties:
-- 
2.43.0


