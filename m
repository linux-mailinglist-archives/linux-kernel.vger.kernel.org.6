Return-Path: <linux-kernel+bounces-393208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D719B9DBC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 08:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB678283F39
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A37815539A;
	Sat,  2 Nov 2024 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzNLwY7d"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220745016;
	Sat,  2 Nov 2024 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730533048; cv=none; b=LZUt462i2SW2ypd0GSSR+5J9+LiYo0GPwqYH1qFS1QI5WmesykrwuIc7PlDm/Sjrpu5NOSyKhEKNwuPevq2HF75PwJ1tOXk4wczwgkPxipADJ3R5arGcNWk1zB2Jt6wdp2Fy/BTvCTWfFTpHVKzYUI0Dx2SZSXL+V0shU4Z9q+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730533048; c=relaxed/simple;
	bh=dklRbIY/mUInDT+b8/wRQfEfzkMNBkjmTdc8xV2shZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VkpLsQL5e65+PkAtPycs1M593HCgaHCFuSGLxurk0p7SvNbFwPmRPbBNwk9HDRSTg3XNUA3Y2HUnkh2N3aOVpKqPQcig5xqweC7aMjaL0wV8lAQSEeYYZ4Hoy5yx8/tNvNR8pvpxnnRlxD9oC5r+oPYU9E4oge0/WySj/kRoiyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzNLwY7d; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c805a0753so25357675ad.0;
        Sat, 02 Nov 2024 00:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730533046; x=1731137846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JuFkpD4Ej+eBtUbmQcpmyqTe1MglqkEa8v9mMQvGlkw=;
        b=DzNLwY7dkxupH90fKEdYLekiDsCWcwzyGKYLb7GAU734ZZ81IVB/K0Mc9ajkwWg0Sr
         Y5oK0r29tmiTsvTePZZq0tSrLWTeFU5NfsZJcRreobGXp4UIkMAv2X31fx9ldDZqH7eE
         rynFq7qzvvt7zkL1GHvXVK8EDefFH1p32gY8VLzsFccref1CqjlMun15QnTGV9YstBfF
         3Cy/ird9qfoDYoac7OjBhaQNZORghGV9PvtPf18SR4pBrvELZ6a+oeIiKpX9m4bmX8lA
         zhV+Q+0y+aQFNJupYqBb9M+NXUUZHN2fZRqmHTL6uOA0QVfZfJ/GvcMTjvjyQX6WsI5y
         Aupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730533046; x=1731137846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuFkpD4Ej+eBtUbmQcpmyqTe1MglqkEa8v9mMQvGlkw=;
        b=WRFLZe11Pk4iZjarYxasxxH/3gIrDvXrGJMwRNlN3CJobsOGsLLk9t4n9JfEidUjF4
         NWJIso+O9LPBEKHKs07PP4AJeExZOhVCJV4qqGorqRrfTeWgIG8w3H/Fm8cCHfcsozsO
         iX4dy8P9yWepb4NyQHqSmXfrYIZZ6wnRbfOQQdHN/4viiSHMoDxsRevnUwchkNeOBemN
         ZT/tY4sdTPntJsT+yIixXne/XqR/h8ANVglToJBFkb2yBV9yUhWrrpNmZ41z4D3y0SbT
         UqM6oeQh0AaE7PhW2uiFNp0jWqA1rigkwADY160+3FQdQyjtN2ZShkxDSIDpdlTGz9jU
         fwlA==
X-Forwarded-Encrypted: i=1; AJvYcCXEnbPfOgxWudyK3/+1AiFE6oQPRWksylP9Ddssk1/d/eFH/N/tAC5DDFOzFb4ydu/DTYPjMCUgqzg=@vger.kernel.org, AJvYcCXv+XPfIfiZIErb6nhV4B2GnQ6TGDVXWjTdhxvDbZCaDkvK76+cW7QVhUnxR5TQq2+AMcB61R5sxHw/p9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfOU47yupaBuRrZ2FNTnyrS9T9ZOPbW+Di7yAz5PqCGJltYo+t
	xD0juwpwBf7tpaeuCzJEJuYNxQNjCbzfPco7b2qJQKe/+m/HgJb52SsTzyaVkrg=
X-Google-Smtp-Source: AGHT+IEhDZQ3xjUskKBqIJ5NheHjTuM+tJa6hT3eFe63rXrxHsDaIb9lMzYixpZ2NG0r7qeFZb0YJQ==
X-Received: by 2002:a17:903:2445:b0:20c:bcd8:5ccb with SMTP id d9443c01a7336-210c6c0610amr366251015ad.30.1730533046304;
        Sat, 02 Nov 2024 00:37:26 -0700 (PDT)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:7d08:cd12:4b73:5f28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a5c2dsm30297145ad.174.2024.11.02.00.37.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 02 Nov 2024 00:37:25 -0700 (PDT)
From: anish kumar <yesanishhere@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH] ALSA: machine: update documentation
Date: Sat,  2 Nov 2024 00:37:18 -0700
Message-Id: <20241102073718.64040-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

1. Added clocking details.
2. Updated ways to register the dai's
3. Bit more detail about card registration details.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 Documentation/sound/soc/machine.rst | 30 +++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/soc/machine.rst b/Documentation/sound/soc/machine.rst
index 515c9444deaf..af7bad7ba134 100644
--- a/Documentation/sound/soc/machine.rst
+++ b/Documentation/sound/soc/machine.rst
@@ -71,6 +71,18 @@ struct snd_soc_dai_link is used to set up each DAI in your machine. e.g.
 	.ops = &corgi_ops,
   };
 
+In the above struct, dai’s are registered using names but you can pass
+either dai name or device tree node but not both. Also, names used here
+for cpu/codec/platform dais should be globally unique.
+
+Additionaly below example macro can be used to register cpu, codec and
+platform dai.
+
+SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
+	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("spi0.0", "wm0010-sdi1")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
+
 struct snd_soc_card then sets up the machine with its DAIs. e.g.
 ::
 
@@ -81,9 +93,13 @@ struct snd_soc_card then sets up the machine with its DAIs. e.g.
 	.num_links = 1,
   };
 
+Following this, ``devm_snd_soc_register_card`` can be used to register
+the sound card. During the registration, the individual components
+such as the codec, CPU, and platform are probed. If all these components
+are successfully probed, the sound card gets registered.
 
 Machine Power Map
------------------
+---------------------------
 
 The machine driver can optionally extend the codec power map and to become an
 audio power map of the audio subsystem. This allows for automatic power up/down
@@ -92,6 +108,16 @@ sockets in the machine init function.
 
 
 Machine Controls
-----------------
+-----------------------
 
 Machine specific audio mixer controls can be added in the DAI init function.
+
+
+Clocking Controls:
+—-----------------
+
+As previously noted, clock configuration is handled within the machine driver.
+For details on the clock APIs that the machine driver can utilize for
+setup, please refer to Documentation/sound/soc/clocking.rst. However, the
+callback needs to be registered by the CPU/Codec/Platform drivers to configure
+the clocks that is needed for the corresponding device operation.
-- 
2.39.3 (Apple Git-146)


