Return-Path: <linux-kernel+bounces-275497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD9B948688
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52481F24541
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B71EBE;
	Tue,  6 Aug 2024 00:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UVBmax1F"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E3625
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902957; cv=none; b=IloddtJe41C3tuuDOzVVuIPiPUSiEKJQLtSCbBpbPj8MTXZYijbEMHGkGVeacs9uog9ndgoQskrW8mCueenaxE4cPNe7Atnn1LZ/1a7Zjt+kLV8TBj+0pdoWwIgkWXLfbbLTvJaOe0Euy+Wq1wlPLWGKwkk/mve/w3Bq79ABtwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902957; c=relaxed/simple;
	bh=R6MOIkZuJBuFqSF8tqOnUxEyKt8uQ3N4KcXwTYj2IeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BElXSOnEI/xX7PVRG0udG+1oNi5S+IQQbtNRXcSG8W/KmENZuxZJCSDEP/qAdKhl5kxIeTGN0jrXm7OFmdL4+4Yy+cEayhF1pIrToLFc/8Sn44TCC/ExPVyyas1Xuo9j+wUH7A7ixq09yPhuxZvxYDiDx472hViv21UN5THNc6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UVBmax1F; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1d42da3e9so11566585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 17:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722902955; x=1723507755; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eXLI8wHyVdI6kvmwcMZ262mNarDv3w8K9hN3q9ZyawI=;
        b=UVBmax1FkPHOhlPKsNP4IbRtIoupq2A+pvmTirtuQabZ3GHOqLRPcM6ZqAA4tWhUti
         XFy0+AQR7Un7NK71xBuVV/8hCzquCRu+cnvBBoTVvT5+b2Im6uxrsiI0T4wP2GKr8dYB
         OnhjlLQDojHX/m2p4zbEkfwLTmaxYWSdgDPZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902955; x=1723507755;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXLI8wHyVdI6kvmwcMZ262mNarDv3w8K9hN3q9ZyawI=;
        b=Ix6EY07mY6fuN6Dvqq8PfbUuiVWTAu0Z0qDfrm29TVUVXrn969KHlBeN/4lFBiE0dr
         +BqhLt5fFMIZ3L0aoIFd0Dki8Gyfv00QTHCb3/oW1a8iKVQX+7m7uv37v7FXklyxKorr
         q8l41izg+ZXtYid3Y8c3CaUJDddeHIcGO54BqEiQUHc22sO0K7/GHEVMSts2qTLdqSi7
         qjLnynhDTEbiObDb9ZTSEpy79b0a/UgP/6mmiS9PoHAZFDPh8DLyWPY8vIuPvJ6uwHgy
         7PqQQJuhu2+J7tujdZ3WxpU9ciefTasmTtC9Im2Nnpf/beXo230HsaSdKTj0WDHPsQQ1
         Fnng==
X-Forwarded-Encrypted: i=1; AJvYcCVW7Et6WEbPXJV/leYppSMKVoFcDAMhlX7rxqKVNeOc3XgDHExkDHigM/KnkeXtfLwKiFgIwOzEx26etRkB5CS0EtX6ezYRclbD4tjG
X-Gm-Message-State: AOJu0YyDaxAmWWxtxWkI1azdHYJpt2ql8u+SFu8f0IraM9MLO52qkx6D
	3W2dE+MWPJAujPcFqWXSEumoMZMVhM4fyt7jjfa8eyFASB9r/a3OzZkh4Qv6ZA==
X-Google-Smtp-Source: AGHT+IGYHOxtSbB4Mzyzks5148QuRo36C5zZ7fJBUfAm/CwA0XoNyW8GIPaCPTpDpRYgGH4p13D3fg==
X-Received: by 2002:a05:6214:4805:b0:6bb:8c08:8830 with SMTP id 6a1803df08f44-6bb984c57c1mr154234956d6.56.1722902954681;
        Mon, 05 Aug 2024 17:09:14 -0700 (PDT)
Received: from wilburliny.c.googlers.com (200.234.86.34.bc.googleusercontent.com. [34.86.234.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c87bb90sm40166026d6.130.2024.08.05.17.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 17:09:14 -0700 (PDT)
From: Steven 'Steve' Kendall <skend@chromium.org>
Date: Tue, 06 Aug 2024 00:08:24 +0000
Subject: [PATCH v2] ALSA: hda: Add HP MP9 G4 Retail System AMS to force
 connect list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-hdmi-audio-hp-wrongpins-v2-1-d9eb4ad41043@chromium.org>
X-B4-Tracking: v=1; b=H4sIAHdpsWYC/4WNQQ7CIBBFr9LM2jGApiWuvIfpghYosyg0g0VN0
 7uLvYDL95L//gbZMbkMt2YDdoUypVhBnRoYg4mTQ7KVQQl1FVooDHYmNKulhGHBF6c4LRQzeq1
 b0XptL2aAul7YeXof5UdfOVB+Jv4cR0X+7P9mkShRWz0YKWzXeX0fA6eZ1vmceIJ+3/cvElM8q
 sEAAAA=
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Steven 'Steve' Kendall <skend@chromium.org>
X-Mailer: b4 0.13.0

In recent HP UEFI firmware (likely v2.15 and above, tested on 2.27),
these pins are incorrectly set for HDMI/DP audio. Tested on
HP MP9 G4 Retail System AMS. Tested audio with two monitors connected
via DisplayPort.

Link: https://forum.manjaro.org/t/intel-cannon-lake-pch-cavs-conexant-cx20632-no-sound-at-hdmi-or-displayport/133494
Link: https://bbs.archlinux.org/viewtopic.php?id=270523
Signed-off-by: Steven 'Steve' Kendall <skend@chromium.org>
---
Changes in v2:
- Now instead adds value to force connect list as suggested in review.
- I tested these changes with two monitors via DP, results identical to v1.
- Link to v1: https://lore.kernel.org/r/20240802-hdmi-audio-hp-wrongpins-v1-1-8d8ba10d77f8@chromium.org
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 707d203ba652..4e7361d1d518 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1989,6 +1989,7 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 }
 
 static const struct snd_pci_quirk force_connect_list[] = {
+	SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
 	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8711, "HP", 1),

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240802-hdmi-audio-hp-wrongpins-f88606f8d3ab

Best regards,
-- 
Steven 'Steve' Kendall <skend@chromium.org>


