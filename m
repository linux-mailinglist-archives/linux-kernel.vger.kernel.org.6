Return-Path: <linux-kernel+bounces-194242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10E58D38D8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E55328B4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C44137911;
	Wed, 29 May 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDbMD5gf"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4DF13777A;
	Wed, 29 May 2024 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991837; cv=none; b=bP/NbkxNAP9o87dZHnFjgwpFmd+5ZmmxJy5k5MJq0V7ZNv3pRnz9+3ho5bD8IUzt030pD8KQ7cK2mVeeufB/oXjebfN5i/V7Ot2FVAaQ8j3UnWx3UT0ZAOBSaEACpuN/fiIE/R2V1/2T9qMN0zJhEpHRFo7jBkBGdgFSBB/2CNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991837; c=relaxed/simple;
	bh=xGxCwNAa3h6hUSat+wLsUt/LFxDta4PN8t++ItIHRgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CtdiObD85bixg0jk+RHy6XntRe9zjIfJ8RuXt5+/Sbbect+ivU4CnmncmJT8oS3J9uydaiqoLJtPB++PlP38mUGA1fnynsKut6dG7JCIph9TBauIE/TvnU+7Km5cbN6Le5GR8U73oxUMGAOrATZ8pWHSat1uAvDY4BmrgfzWIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDbMD5gf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a63359aaaa6so270955966b.2;
        Wed, 29 May 2024 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716991835; x=1717596635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=seHfK1T0CIDoh74FZ9rFB1MYhs/7Ky7lSWNsiaH4Ato=;
        b=TDbMD5gfEUSrwuIJ6bfB/KYwtJA0lpqUQwP/HEeFmp22n4pxRYSMhfXW83td77dmxR
         wcy6DbGIpWgBMH4vjFishbYOvB9EBT2THOx2dOsnrGU52k5315QbGqBzNvlfIgYHPa3v
         P09dJa6nydqU8ihxowbqL1q4wwI2X3iLDQ4ZiqtWMZwqqLDRIppcQ5G3MzgUrI2h9jR9
         hK/vA47WZ7Mf4S3cfA/mDErH+9tLU1NWQ5bT4hUt6rdWb8CXzUH7kJvG8o6ZYg0qTsbj
         Vqq3ol1CwN/UzBwrvzV3ASoYgGAcIYIayHwqG50K9pZSLnubZvgUooryaN2be9FqQHM6
         TbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991835; x=1717596635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=seHfK1T0CIDoh74FZ9rFB1MYhs/7Ky7lSWNsiaH4Ato=;
        b=FnYos2ZB322wkv2wm2hTwuUT96NA9vYPFgUyUZGyQ08YMQKdvwGRWnYHnR+hoEMKHt
         zCJBDz/2jfOuAPChdCKhCGnC5mfGOVlfTyakzuCBHDp5iAuVpha5HnU+6y5lO0QwVksK
         1cN2NIFHh0IU+1bTvhdzsuutOmTvJIHQBMlh41aS/3thlZHk/8tGpv8HH/hdPpYKL76p
         xLDWy62GV1Aj7RsLyQoiGZGe9/iR+q4nMgS5O98uDDEKE/8SKxLrQPKbBwX92mO5k+fl
         qkgMHTKwv4446AxkLZAlIe6Tc2EohLWRX81adEfcc79h1jBPL1y6lw/YuKPYsE41Q1Tv
         zYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDGpkDlO+lPPZ7FnYZ3yir4gPec8Y00jsbkdEuGXJcEYYFoHNvw+SqxnFkoN/aMDAc3Llz+nLMZs3QVSgKAceHv/Pw02WcwBN7Lz0i/YEzJ2vq53axZ2wlIcYGDhSHihPEhAhOWmtf9w0=
X-Gm-Message-State: AOJu0YxYuDAbikt6nS4DlG7MgG01KAGsA5BeFOK5/gS3v82jUtFPzOLA
	am/Idwgfr5X7JeAuffPD7MiKi7bGE/ZQpIp4B6ibLUcVERdRhed8
X-Google-Smtp-Source: AGHT+IER8t7cuMdH3WgXBrJavuAe0qg/yrQsSI5WtFPMXA+CURNazRJm23qelZOFl3U7mrYlhQ6UcQ==
X-Received: by 2002:a17:907:6d22:b0:a62:9699:5125 with SMTP id a640c23a62f3a-a6296995222mr1042831266b.14.1716991834383;
        Wed, 29 May 2024 07:10:34 -0700 (PDT)
Received: from localhost (host-95-246-50-43.retail.telecomitalia.it. [95.246.50.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6357bf05f6sm130830066b.206.2024.05.29.07.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:10:34 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Marcus Cooper <codekipper@gmail.com>,
	=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Cc: Matteo Martelli <matteomartelli3@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s mode
Date: Wed, 29 May 2024 16:00:14 +0200
Message-ID: <20240529140658.180966-2-matteomartelli3@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found an issue on the sunxi i2s controller driver while doing some
tests with a Pine64 A64 host board and an external codec (ES8311).
The A64 i2s controller is compatible with the sun8i-h3-i2s driver.
The LRCLK was being inverted when the bus was operated in i2s mode:
normally should be left channel on low LRCLK and right channel on high
LRCLK, but it was the opposite instead.
I noticed this issue due to the playback being addressed on the wrong
codec channel, then confirmed by analyzing the clock signal with a logic
analyzer.

Note that this fix applies for all the i2s controllers compatible with
sun8i-h3-i2s and sun50i-h6-i2s, but I could test it only for the A64.

The issue had likely been introduced in commit dd657eae8164 ("ASoC:
sun4i-i2s: Fix the LRCK polarity") due to a misinterpreted bit in the H3
or H6 User Manual. I suppose that the i2s mode had not been tested at
that time. Can this be confirmed? Otherwise there is something else
going on and this patch should not be applied as is.

Matteo Martelli (1):
  ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s mode

 sound/soc/sunxi/sun4i-i2s.c | 143 ++++++++++++++++++------------------
 1 file changed, 73 insertions(+), 70 deletions(-)


base-commit: 47d09270d7776e46858a161f94b735640b2fb056
-- 
2.45.1


