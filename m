Return-Path: <linux-kernel+bounces-409677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861FC9C8FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315D61F22407
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0161218452C;
	Thu, 14 Nov 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqYh0PYl"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627F17BB25;
	Thu, 14 Nov 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602493; cv=none; b=F3f6BljiReWtOArY1mRcOFSpkytVSxss0S4btdylwWzow4KH4i++psrEq0ioLA5Y7oi/dwrYPyFYuAXefqTHlMl7txWIvzo71lhUSfbdYMuex1wgDb8EYJC3GDITnwZhzhpb41zXwekNZR0k63WqyAWwFlJ8pmXukPT5nmrjgVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602493; c=relaxed/simple;
	bh=7RU4vCIjsk0niKUMhRyi0En6cKsUi29+xzahzLiLwRM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OlRQe+O2btsXp9KVFyr0IWykeYYXbxPq71F6DAhABmM23PkCtQuVXbVuTw22gSDspMLrXLaLJk+TibfY97/JDkKuCbObuIGSn7Rm+wMf3rKfcympSORhBYHhaiWQO6U0qog5CqopJVYaJTZuqkE29C+Vaakz5ehhKBIw84UX9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqYh0PYl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20e6981ca77so10651545ad.2;
        Thu, 14 Nov 2024 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731602491; x=1732207291; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZNvgc9cduMfc71Hg8t7p1gO2W7FC1n294bvwhBmrT4=;
        b=dqYh0PYlYaz90iITkeTftJ2eaBSzsP0wiru3C01oc62gB+X7fJrQi4wsMg8HHRhxSD
         MJVf4o6oIYOiVVBXXgMLa0mL9LMnuneN192QQlY6LZLUHAd5ePo6O6bsXMLvrMF9unB5
         UUMi50QNz7DCR2vgXOlV4kXKcsgO+fwXpIB2H0i3Nvdvzz4HhpXIWVys8iExwSWNtrC/
         8FUxP2az+2D9w47LkSq8CvqiYPA4tnMkRFhlI8gSxKNnDniGb7uF2WyUrUbzyyTynGlI
         HK7F1oA7QTV0qToetavbHP84CQQgmgckHzwrcUI8z9v8KQ4A8aZuB61IX87mpYe1mTf0
         btjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731602491; x=1732207291;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZNvgc9cduMfc71Hg8t7p1gO2W7FC1n294bvwhBmrT4=;
        b=AK21sg0deWPl4TPvydQMkowyy1ttuyULni8kXm600hrreFKjXTl9NBjAAluQFa/XAy
         MgfzMnQwEu6v8O7k5BYUpxU2oEz9HLIyuj5ckBLcXabC42oKT2q9z8toY5ALSuNAnut3
         l2bs+T63ESuHQ0zOL/bRKVwD2XK3MtaGPJ5uen7ifv0+QYLLNrwTmb1yMl28EGERI1of
         vgmIdWI3ASkxXFftornRyNSX58gyDMMmrMVrLP7MKbWuC5mm4VT3j/m5tFTp0PEAfTde
         ws8FsBeoFnABggh5jDkrycIkiFIbOKJS3yIaWJglxQcGv7b380YCOUrjA0OT+FF3CK3n
         MEAg==
X-Forwarded-Encrypted: i=1; AJvYcCUvRAu0L/ld6Cl2oVixqSPyS9mjBV/YVRjcoydtcmWxOp+SMpooGZEKCXMnqZAsimZhdvNBZBX4Ysx5w7s3@vger.kernel.org, AJvYcCVs5wR6PyWbZ0wjtr1xdncQ3z0vK2oZ3rzSV+bhJ5RTxdeY/8+6gNb4SPWTx6qI+95YLEOQNAWOdyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIqu7XjPni74gwiNQmzPMKqwL72KLIs+l7TGPy/OYgFtXWO6x
	a3niFP3J4OPsFkSgbEOiZDUC/F4PUmkulkNq8ywmImBRsQSEUfFT
X-Google-Smtp-Source: AGHT+IGQzHMdpQzoS8TEk9TYuGHbxuPk45n8PEcKTkCpa51mPZHhJGi1iHg1oyC1H4ofSlZBuvaxBw==
X-Received: by 2002:a17:903:1ca:b0:20c:ce1f:13bd with SMTP id d9443c01a7336-211b5c3f07cmr81020015ad.18.1731602491171;
        Thu, 14 Nov 2024 08:41:31 -0800 (PST)
Received: from [10.113.16.67] ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d24a00sm12844915ad.244.2024.11.14.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:41:30 -0800 (PST)
From: Hridesh MG <hridesh699@gmail.com>
Subject: [PATCH 0/2] Fix headset mic on Acer Nitro 5
Date: Thu, 14 Nov 2024 22:11:18 +0530
Message-Id: <20241114-alc287-nitro5-v1-0-72e5bf2275c3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC4oNmcC/x3MQQqAIBBA0avErBtwxEi7SrQQnWogLDQiiO6et
 HyL/x8onIULDM0DmS8psqcKahsIq08Lo8Rq0EobIjLot6Btj0nOvHfolLUqkgvROqjNkXmW+/+
 N0/t+favK7l8AAAA=
X-Change-ID: 20241114-alc287-nitro5-90880d19cd89
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Stefan Binding <sbinding@opensource.cirrus.com>, 
 Kailang Yang <kailang@realtek.com>, 
 Simon Trimmer <simont@opensource.cirrus.com>, 
 Joshua Grisham <josh@joshuagrisham.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Hridesh MG <hridesh699@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731602485; l=1134;
 i=hridesh699@gmail.com; s=20241114; h=from:subject:message-id;
 bh=7RU4vCIjsk0niKUMhRyi0En6cKsUi29+xzahzLiLwRM=;
 b=mvoBDywM+2Q6QoDzKmWR4ADQjK5hleodPeGtJWz4Q712Cv20wZ1lwhN8uUoH7z+VHzel/G6y+
 e2cTHwU4cX9Dd77ZqOaPjuQrQ5XW0Kw2rnjQ1Yn/Pe9E0EqqT8YOJ8m
X-Developer-Key: i=hridesh699@gmail.com; a=ed25519;
 pk=otVQutD5ZTsEpajsGv/haM3pQj0yofkuYrdNcaX5AUE=

The headphone jack on the Acer Nitro 5 AN515-58 laptop with the 
realtek ALC287 codec does not pick up any input from the mic,
this has been documented in multiple forum posts[1][2].

This patch adds a new fixup model and a PCI quirk which adds the
required pin configs and verbs necessary for microphone input.

The pin config and verbs were obtained by reverse engineering
the windows driver using RtHD dump.

[1]: https://community.acer.com/en/discussion/708528/installed-fedora-linux-40-in-nitro-5-an515-58-when-i-plug-in-my-headset-microphone-doesnt-work
[2]: https://forums.linuxmint.com/viewtopic.php?t=419160

Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
Hridesh MG (2):
      ALSA: hda/realtek: Fix headset mic on Acer Nitro 5
      docs: sound: Add a new hd-audio fixup model

 Documentation/sound/hd-audio/models.rst |  2 ++
 sound/pci/hda/patch_realtek.c           | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)
---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241114-alc287-nitro5-90880d19cd89

Best regards,
-- 
Hridesh MG <hridesh699@gmail.com>


