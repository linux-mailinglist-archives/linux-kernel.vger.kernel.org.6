Return-Path: <linux-kernel+bounces-405311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E92519C4FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7621CB259B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90520E018;
	Tue, 12 Nov 2024 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gB2oFB+k"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F120E013
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397257; cv=none; b=TRxIvrzeXYnTnPbnOEKJVvSzI3o/JbOrZ2G2Orjh+77divyUyjNloasMZ4xA1/HZcCny8gkcn4HSavJg06GRJ3jIiXb5t6pTKmB+/lbr1prINREqdqq5ikvx9ERdsiOmGNWX7r3ONBkBnhAKzzc/lm6+jyycEdZZB7iZfLGAwIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397257; c=relaxed/simple;
	bh=LCGPv+6YwJIdrNnGREkhyKDHGqnUI/KiwmLaMOf/yJs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LARTWEHTa8/y7B1Re+MPj7nwWWuCuTqwEq0e/gZ26Yj7QXnU3MaXNsMLQm3f0sVBwkLhNnk+0k37Wou7aZg3kbEnV62/5KMHo4+zj8wREU67Jls68bzOgCzp3lyUKxUKCnNsd+lSiIWNcgzNnx5gyuoLwPAejD3WdWZdQ/7PJMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gB2oFB+k; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea258fe4b6so97027057b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731397254; x=1732002054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PrZPIuWY1b6bcFJ7xG9KK/ME+qoSvMHLOuT1F2kJLZE=;
        b=gB2oFB+k/ny2rJr8baBTDpqQ+xSWQoAtpFnu6zTTPbWCpao7HhmAOZHbC0DCIPzZu/
         fdXSgbPQmON9hCTTQdjBcs27L+Jh/F+tg0n+cTu3qqnGO5qmOEc2c4s42CyQ0CY1bYCd
         vvbG/55ppA7S5+yVRj37CQLISFWX58UDHLwehNqb1bIOLN9dOiU8jusln0pAhjjAtLyp
         ippqwdOcak35A5Wgg9sm/cx28tji9eSJ5Yqd2xjg+nddT4seH06D2HDDsTBA/fCJHeD8
         6aQIFDh4hdmjPqPewJ+8OgRIRuYqGgVHUZ26/AecWj1NMNA7BgUl1HMrstBEIkYdP2He
         qW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731397254; x=1732002054;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrZPIuWY1b6bcFJ7xG9KK/ME+qoSvMHLOuT1F2kJLZE=;
        b=fRP4uvLCyuVNrXsUQwjcVoKPg6Wd00dT8oxVr2e/A4wTwC+zgRmmoRC40OqqlI1tjl
         sUI32EcF60mtTXKoHW9aPdx8yExuqL35eXwoOHCGCWsSeZEtUHeiwhZlWr/3/6foQkFx
         GAr9RhDtZTRnWJhulF3IXwicLniYZ+zub6LT0kRzbH11cxaX1lk4FJDaB8wzArew/TTm
         GsNBytHvWvUSbkU1KT3ozqgnsPE9ytN97SxBwb7Fl0Ln0LXOoNQOxIRcM/jXwybTOOFA
         Tbwj09XrPWisH6UkKfLyjHX4Xd4BAj19rQrJiU3YAJdbIi6eZBL9rucr70nZtNeFUIJb
         Zz6A==
X-Gm-Message-State: AOJu0YyoNd2t1VwYbwZJZklQRL67Y+utqauJSPRHjHEkLF/2vk2qXeHC
	FKGN54Vw3qJnhXb7JQd7eTPLxuxLU+JhdnY1UEWWbHimX+rgfccqIR5zWHG+kAXenhKE45nqzwR
	/Rs1BJU9e3tm9cnC0i7fMfOt9pgk3yYyVJGXSl0Y8XNism1PlPxHKBetqbRpvB6hkuz/r1OuC6V
	kurcr28KWDbDKh93N+y1aTiADy+mpUW7OsDqHytcWtjAeM7QCIqmShHjyZ
X-Google-Smtp-Source: AGHT+IEdDPa0Xt5ebacxDlkHdUDoUVS+NEyLA4yLerHiyZABrnK1IxrW5FLVo+Dl608HpYDtwlBzmxgWfufmzc4=
X-Received: from mmaslanka2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:b8d])
 (user=mmaslanka job=sendgmr) by 2002:a05:690c:887:b0:6b2:6cd4:7f9a with SMTP
 id 00721157ae682-6eaddff31bcmr1717127b3.8.1731397253863; Mon, 11 Nov 2024
 23:40:53 -0800 (PST)
Date: Tue, 12 Nov 2024 07:40:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112074048.1762371-1-mmaslanka@google.com>
Subject: [PATCH] ASoC: da7219-aad: Fix detection of plugged jack after resume
From: Marek Maslanka <mmaslanka@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marek Maslanka <mmaslanka@google.com>, 
	Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Don't notify and mark the jack as unplugged during the "set_jack" action,
because this action is called very late in during the resume process, forcing
the jack to be unplugged after the resume, even if the jack is plugged in. Let's
leave the responsibility of managing the insertion of the jack to IRQ.

Signed-off-by: Marek Maslanka <mmaslanka@google.com>
---
 sound/soc/codecs/da7219-aad.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 15e5e3eb592b3..2745b55fba662 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -33,10 +33,6 @@ void da7219_aad_jack_det(struct snd_soc_component *component, struct snd_soc_jac
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 
 	da7219->aad->jack = jack;
-	da7219->aad->jack_inserted = false;
-
-	/* Send an initial empty report */
-	snd_soc_jack_report(jack, 0, DA7219_AAD_REPORT_ALL_MASK);
 
 	/* Enable/Disable jack detection */
 	snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
-- 
2.47.0.277.g8800431eea-goog


