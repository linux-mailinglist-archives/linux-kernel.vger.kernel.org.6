Return-Path: <linux-kernel+bounces-314106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1932696AEE9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3AC286461
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE93847772;
	Wed,  4 Sep 2024 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI6iT4ls"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CED4A15;
	Wed,  4 Sep 2024 03:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725419567; cv=none; b=dv6a05drQWlcbw9iqfJYSVgvu0SlQKIWhTdIJWtuiA7d+rTP17jLP47VePJjf5j9jC0QPjzV9biYT2gq3D2hUWPrh/v+RtqPEXfK18Urbfo1pYecogYHMlAZHEUrM8OarMdMGFbj2WTZOfR1C+tLXK4MUHP8nxR4d47AXSAf5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725419567; c=relaxed/simple;
	bh=KKXN6bVHQyvQe5DAEryYyZ3CiVfbinIUAkpj59tKEmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3fWJS5lRhk9M5fNV4S2NIgo+01TaOkixOqvuAYabZ0dQaH4PK4y1/pkfEkr/X2sr5LM+8fwTssOS+wR6Rq+E/FshoR7FwmE0t42NGaUfEz+bAfI3fgH2GaKXGuxPFyefCoqknj2Sea3kvjMUbOBFefWPYHBEIhZ+zgUa8rRyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hI6iT4ls; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so272301a12.3;
        Tue, 03 Sep 2024 20:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725419565; x=1726024365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BuUOiBL+3Emr7CBJB9z2PmaAlePmvtgF30QbjTVjrJE=;
        b=hI6iT4lsHMOudo8laIY+CLDdkZraANqHL8DIu02IPFNUKsVCHxWpRoKcNNlm/gWAne
         ldvVRz9NBauavM/MBFQR67vESOEkGmwx4+vSmff6Vl/0inEuIhJlLQcIe3gbdg5YJE7x
         qRa4bD8E1oLXAKlGOLhFnEh2FFlceGxWToy1LX6uDNdvlMPuICWPDmsmDI+OEuOoijeP
         1WAjNZ8ZDMHtgMOfhH7b9vlNjpqvddh7qtLdQK0QnSFbN8wvk4qker2ZuojpEj8peFHV
         S80rHnAyDGzitlt2mdzZ2KmWyssokIXkYtQe7kcXfVYo6sk+dNJzkuvHNbBf+rUDd8z7
         2Iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725419565; x=1726024365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuUOiBL+3Emr7CBJB9z2PmaAlePmvtgF30QbjTVjrJE=;
        b=iTSoV0zY900D2/vaaszl6yDFrNu/LPJ8B2z/jamaB/eB0t71l1ECO/sklWal3OwlfU
         dWwIKp//yIj/Z4DJQZNZgNt1tcs48Ea7QfolF8nlGVNGVxKwQ1FDfBwhWCWDi1TxCiK2
         LDD5iHgJl7linin34lr8ZMn4Xhhk8IYVD9mm8tpCBlkSAU2+ro+VIB9ogSqxryU9QmcZ
         t0m7PGrqG7Hh4clr7w9YlI9VjFMs1umXL9JhduPEL6ZQWcq1YNpg2q//dMNx4NFnLkcg
         Suid8Fr51e7Iw822QnAxFJHE6fT817sxRpKmCpBX2cnxcSWlI0MsJ0R6AP8CpnL89LoH
         RflA==
X-Forwarded-Encrypted: i=1; AJvYcCVlIMY23zfN2y31fhKJDrQh+7hBln57RBcGl4BigREuveRKbQZOdQNXUZMrn/DDgcjFn67tvlxwbO65emQ=@vger.kernel.org, AJvYcCXhcAka9iZHkqXN5w9VZU7E3Abp/Ah2GZl7KKE8gvA7903iY1B/LfDp471aD9o7s/0m1sYSz6e1r1hYMGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiuMqsJpzYk6O3yew/7iqUmf6ZyIsACnxG83rBJWOusqCYlW4Y
	Amzm6P0HoJ6gwbPpw4GyosXjj9KfyRAyYAov4duRel7R6rldddcB
X-Google-Smtp-Source: AGHT+IFkBwhwna1C6OUckJKYjQ7/c7pFK29F1zoMHBB/xkq3DDr/EAdhgN9LZBND06jEOSrY39SRrw==
X-Received: by 2002:a05:6a20:9f47:b0:1ce:f752:46ad with SMTP id adf61e73a8af0-1cef7524723mr5695798637.42.1725419565150;
        Tue, 03 Sep 2024 20:12:45 -0700 (PDT)
Received: from imac2011.vn.shawcable.net ([2604:3d08:5c87:300::2e49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae90cf63sm4817695ad.43.2024.09.03.20.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 20:12:44 -0700 (PDT)
From: Maximilien Perreault <maximilienperreault@gmail.com>
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maximilien Perreault <maximilienperreault@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Support mute LED on HP Laptop 14-dq2xxx
Date: Tue,  3 Sep 2024 20:10:13 -0700
Message-ID: <20240904031013.21220-1-maximilienperreault@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mute LED on this HP laptop uses ALC236 and requires a quirk to function. This patch enables the existing quirk for the device.

Signed-off-by: Maximilien Perreault <maximilienperreault@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f67190a8c..6f96c0c67 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10183,6 +10183,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f6, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
 	SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
+	SND_PCI_QUIRK(0x103c, 0x87fd, "HP Laptop 14-dq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87fe, "HP Laptop 15s-fq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8805, "HP ProBook 650 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
-- 
2.46.0


