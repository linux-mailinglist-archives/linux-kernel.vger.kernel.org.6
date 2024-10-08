Return-Path: <linux-kernel+bounces-355707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F108C9955E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C551C25926
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219A52071F4;
	Tue,  8 Oct 2024 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="H4hHv94/"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FEC20A5F9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409352; cv=none; b=f93TUH4r9oqj01yPP2mLusS6G3FlXyY+disVZZbTn7fyNZTYqhjaFz6aEliTt79H+uiwyu/ZjoQMJyALRbl8R/OOijA5qyjOuYNWBuY8LcBCVbn/+LvkRQz1jnL6oiR0jRjtWM84hy4Ce/ThaPwnbUX+TEVNXYo+JikNBUTdch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409352; c=relaxed/simple;
	bh=nT4KIH53aTZyRAzIGhljOBBqba1mX47mVRjQ/Y1ohBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+blbLpnUDDbjPNu0XkqLsgrK0Qr21psPp4HYQ5ENlvrwCBcAa9/76dQTCQdF52FLS80jCLZNHHd4monfpD8ZaC4pnU/VVIf2yPNsI6gh8eRMn0DhFyum4+xt+2h1LSJTaeghzBFnE1EVdRt01jE06WVqxHQjPrY2zHl2aNBWs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=H4hHv94/ reason="signature verification failed"; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e3937ef498so3135266b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728409350; x=1729014150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VN7nq27/Zc23ABcQ/rS/ZQA8gDRSyDCq3NgiP8/pXfg=;
        b=H4hHv94/2XCim882rEr6k58p8KBaJ5uBCSloNy4vPXa0BSEtliDsXChFK/wm9cIkR6
         LyV9Pw+eQX0eJ3ES1lGZAHRynGLYcFm02Q1I0eYjIuKruIsEcuPpdhqNsLh8syo0Hazf
         9Z0vpFFUw09jv5atveCeAPo+vZf6NbqmrIre4PPclLGsRkSeRZFJEfl9WY6l+X6lgyB6
         dJApqOaGLs6rCEn0PMhlpWX0B5kmsNCvZqUe3NHm/617dBQ+2eIz2R8PPWpp3wja+v2U
         sQgC+6PqnksSym6+8/MVJtWyNpSDWhEECh0SZqcTSwybK6/N3EaaFYQsx9UsMMDlx3qj
         R+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409350; x=1729014150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VN7nq27/Zc23ABcQ/rS/ZQA8gDRSyDCq3NgiP8/pXfg=;
        b=BapbHeCnqb4HQJyiN/sc/Y8EEHe5UUDUr/nIuo/kd2rykexONKn9PHf0LspGQoTijs
         87ubqa8JuVLxJe4azPN3cuDZmOxsGgdDq90WAOLhqYT5miud1y+AaThos5v7/LzBVptW
         v0t5uUOHK9cDYse+7oYlKPXe0qxbGtH+6mxUnRzTQaMvLiKdvh02vk8LpEhixFGR01gQ
         4TKfxTjAUsOuGah1TMc0J8S2t86kv9DdFynZxjTIzKaI01qMmTUKSSYeNF2VoiQ3ss+U
         LmXT5HJ3f7t98ltq/3JZdLZMevtoi0k3wpV9T87VEz2xb3mnNVWCqWeUEFHN8YipuQUv
         wqgA==
X-Forwarded-Encrypted: i=1; AJvYcCVUJZJhsmBsQwVoNDkDfphFU6bhBRy7HF+wC2Dn81VgBqgiFkENDx5T24o5lH8+I0EZEPygkgFaivfeSlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+nUTRU344y+Z5q0Ow/oAFzoLqdUktP+u6vSebTVoDYtGRO+9
	3FrkUjzkdGhSKZS2SFRRzDiJ80CKtF9ixUh+BC81tx0ZFBJ5NueiPJM0nUyIUQU=
X-Google-Smtp-Source: AGHT+IHUKizUM0XF28YwJfMVg0EB/GPiE3Ua/dfgDBCYQd/B33n6P3+z/RmZ8Ak3CsjiAirh8QorjA==
X-Received: by 2002:a05:6808:22ac:b0:3e0:4aab:f5b2 with SMTP id 5614622812f47-3e3c1337d46mr16697655b6e.25.1728409349897;
        Tue, 08 Oct 2024 10:42:29 -0700 (PDT)
Received: from localhost.localdomain ([132.178.238.28])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e9f6833e45sm7069867a12.54.2024.10.08.10.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 10:42:29 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt721-sdca: Clean logically deadcode in rt721-sdca.c
Date: Tue,  8 Oct 2024 11:41:20 -0600
Message-ID: <20241008174122.4696-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the same condition was checked in inner and outer if
statements. The code never reaches the inner else statement.

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 sound/soc/codecs/rt721-sdca.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt721-sdca.c b/sound/soc/codecs/rt721-sdca.c
index 36056cb7a3ca..4fd26e490610 100644
--- a/sound/soc/codecs/rt721-sdca.c
+++ b/sound/soc/codecs/rt721-sdca.c
@@ -611,13 +611,9 @@ static int rt721_sdca_dmic_set_gain_get(struct snd_kcontrol *kcontrol,
 
 		if (!adc_vol_flag) /* boost gain */
 			ctl = regvalue / boost_step;
-		else { /* ADC gain */
-			if (adc_vol_flag)
-				ctl = p->max - (((vol_max - regvalue) & 0xffff) / interval_offset);
-			else
-				ctl = p->max - (((0 - regvalue) & 0xffff) / interval_offset);
-		}
-
+		else /* ADC gain */
+			ctl = p->max - (((vol_max - regvalue) & 0xffff) / interval_offset);
+
 		ucontrol->value.integer.value[i] = ctl;
 	}
 
-- 
2.43.0


