Return-Path: <linux-kernel+bounces-399406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 445989BFE86
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4591F22515
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BDF193429;
	Thu,  7 Nov 2024 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0ffS97g"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906C1426C;
	Thu,  7 Nov 2024 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961386; cv=none; b=qnoifPvwwPojL+C58vXfkbO4WqToYcEp3xwCyCRDsxBVSCBl1VHFlgbVcQaNlw4LoDJKUJ61lmBkFdD9UCvgLnBZs3xL3znZFL7RXCTFmuxMVYDGuKiLVeTNUruJqVC4Wagc339i+K27oq73kw08f5mrIHjmpjX08GrNfb+VdtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961386; c=relaxed/simple;
	bh=guIVPpGhXDuZz5lSMYaKxEnL14XvM6sjR7x1/usB0KA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E1vIRvViCoWhQK/SAHjwtZxMrKazdkDw4AELss2DgbNVkU/bKu93ifVZ8+A3s8dpoILxnJOaFBXuMUnG6qxxh3fmAFFjJ8EaFBWRjtTdg1nhWM7qZDVGuoPgNuF+cJy6gjIOiUmD6eMGAtrZSDtEkFUAH5icYL0f/U5KPwhWzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0ffS97g; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2884e6ed0daso282599fac.0;
        Wed, 06 Nov 2024 22:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730961384; x=1731566184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YRREKyxHqLad5U75koI+gv+wvbkh7+AWEDayDITERHc=;
        b=J0ffS97gm600ALfKiOfne6Q6x454NZVvj+oVHv0HwjTv217j7EvE+HXcDTzg5ZKC5n
         WNybg767IRnGVt/euIEMTcBhuZrCAC0j3Wdlf7hUxNdL9bu3O8muI5f68wztfhxViNP3
         LW1RxQTvo9ChdYdgFQyEIhokMeJ7wNt8qGJ+SwgnlVISXT0mbELdgZJuOPsYQzmW1lWn
         yP/vPsY50d+raUtEyKCuHESenw/kFhiF+yy/66Y6WDrU6pYGUBsqSOMPdf5GyudPNnZE
         NYejS4ynus5L70elUvTzjwonC0+XZZd7xcNZP2MyYl0x4+AhLOCeufFrr+3mGiY1gA+M
         fgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730961384; x=1731566184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRREKyxHqLad5U75koI+gv+wvbkh7+AWEDayDITERHc=;
        b=hb3cfesUpcEuMAVJWfXZ6TvjacpXz0r6eLy1uVQ21YIIpa2515v3vdGH+YeYvRqfLU
         1VAfeW34d/U15xXEKldFGD+cDjL3i7JfPBeZisavcDwMO0MaIn8XnazZv3MWRpvfNk0S
         SiK4FKbSzcMuPwfKCc3hLJjM4zZX0IoduvnIolnaDJPrgsmem8G7/sP4RZRjFlB3QS5U
         6e+J0v91ypDA/IMT4ncZZRp5BDNiEFkDBKNsh2j/gP0cvUsOD97q7AEdOjxG59ECZTdc
         GXA3lUBMQBDZO54qDfai/vwVluNMhv6GVoNTOUfnqtPndkDJJEUtXRzwz7RZhgqnGbHq
         FttQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEYtmz1ikRe7si45DnFgDYIEGbr/lx1K+Yqh+FuVpup6BEO/eDpntojItGPgQOT+33VJf38MXzg76q5LU=@vger.kernel.org, AJvYcCXeUBhFXQu1+2UX8cWDxw5JK5o4JverPSntFClXmem8PfKKMHdB5PPx3nEexAbYj74rMmjpt/sggKmGxYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+PE3eFC8w26zYhvwI4b0sF8SAoKKICarJH/1iWE4Tr3p/P3d
	IvP47nfGzG2xtXy46AHxfXkFf5zXdZE9UKHyFt96WdFzT4WtiUJw
X-Google-Smtp-Source: AGHT+IGxPjF5mKCWTsENDugEJtirF55iBlvGQQvgV8rcaVaHFl6SIQ2KHWNSbkHPI3GR+eax/Dx99A==
X-Received: by 2002:a05:6870:1699:b0:288:6a16:fe1 with SMTP id 586e51a60fabf-29051b73046mr35418062fac.18.1730961382927;
        Wed, 06 Nov 2024 22:36:22 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4040:6ec7:2441:f176:85dc:94fe:adc7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5bab50sm517097a12.25.2024.11.06.22.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 22:36:22 -0800 (PST)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>
Subject: [PATCH v3] ASoc: SOF: ipc4-pcm: fix uninit-value in sof_ipc4_pcm_dai_link_fixup_rate
Date: Thu,  7 Nov 2024 12:06:09 +0530
Message-Id: <20241107063609.11627-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue detected by the Smatch tool:

sound/soc/sof/ipc4-pcm.c: sof_ipc4_pcm_dai_link_fixup_rate()
error: uninitialized symbol 'be_rate'.

The warning highlights a case where `be_rate` could remain uninitialized
if `num_input_formats` is zero, which would cause undefined behavior
when setting `rate->min` and `rate->max` based on `be_rate`.

To address this issue, a `WARN_ON_ONCE(!num_input_formats)` check was
added to ensure `num_input_formats` is greater than zero. If this
condition fails, the function returns `-EINVAL`, preventing the use of
an uninitialized `be_rate`.

This change improves the robustness of the function by catching an
invalid state early and providing better feedback during development.

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
V1: Initialize 'be_rate' to 0.
V2: Add conditional assignment based on num_input_formats to ensure
be_rate is used only when assigned.
V3: Add WARN_ON_ONCE check to handle the case where num_input_formats
is zero, ensuring proper error handling for uninitialized be_rate.

 sound/soc/sof/ipc4-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 4df2be3d3..18fff2df7 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -603,6 +603,9 @@ static int sof_ipc4_pcm_dai_link_fixup_rate(struct snd_sof_dev *sdev,
 	unsigned int be_rate;
 	int i;
 
+	if (WARN_ON_ONCE(!num_input_formats))
+		return -EINVAL;
+
 	/*
 	 * Copier does not change sampling rate, so we
 	 * need to only consider the input pin information.
-- 
2.34.1


