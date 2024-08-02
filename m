Return-Path: <linux-kernel+bounces-273240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BA994663F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 01:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEEF72829EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944DB13AD37;
	Fri,  2 Aug 2024 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l4I8QxHq"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD013A245
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722642622; cv=none; b=gegkrA2lWL+pgiwWNkuoRw8nxfF8bneaGjxisOjK5A3zXLwZ7Z3OUKCNup1H+D3xzdvmZAmW/1+Ag5YaguOyMOcwWLa6tIOdKBZXrRnA1jlGpzI0QVyZB7BjnJ0rChOluOfAlHQZU8rrMVRlfmVA9FaBBEfbEimT/NqLEZ2Pwqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722642622; c=relaxed/simple;
	bh=HZZKOKBtxpjlkoQFp4cJicu8lxw32wL3IJROduhb6xY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rNrSGHCCVVYIXc6Gy6x/ZX5SYA88oB5QuuV0OsptWdZBnhP9w69IUUZXZWR8y9ArgS25dw8KH/9ByO3LDqi6hJMVgqMMzepDwi6EejDSDSu1IJ1sSA0mRkFHa0wpYjjKbld5Kr/AqiKhE/LBJy1pQDYturKjjDnstwegCODTgpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l4I8QxHq; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b79fc76d03so48854486d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 16:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722642620; x=1723247420; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D4XYocTn+pNPWt0L7L14LMVVJ06I8yBBoe1EZGTqQIg=;
        b=l4I8QxHqCQbOevY/mrv7JGGk8OTeIXwuuoS9rDqZl5KRZFsPuEEXI9E9wYeGiFGl4o
         oYfhSHr7ZdPeHqksiB5pAUAxDHKXqy0mCbMRX4cLP418R5QLPupXqD5CLKhXV4NhHm1/
         zMT9YZNX7Y0xgYoNljjCIDSgWmr3cZHGMAkes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722642620; x=1723247420;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4XYocTn+pNPWt0L7L14LMVVJ06I8yBBoe1EZGTqQIg=;
        b=ofhuGV1dpSLGiH+djCFNevVOvGruLTTW19U+jjQgOGbq+q0GME+OuermlbgC7WmEDj
         GpT90WV/g/g/04eRo/AwhgZfbQoCxUFR7GjBF3lumRwGqe4mng4gX6cA3TxrrSFpOojE
         nhYLeqbjAaF4d8++M1Rpf2k2PjZ2HiSRJKN+Xj9wRABYIi7EWaZmGt2P7vKoJPIG651l
         Q69jHwKa5faWPqtd3vnVMLt9ydnBi7vk1psk+OLNJ+NVS+uy8Kt0hIO3bULFS8PD5pxU
         tPadByLcUiggqCJSCS3UrJvQL1jBxkz4rkCkRYDjtLo0kcbyXNXIl2cWNDypLqkTLagk
         GvZg==
X-Forwarded-Encrypted: i=1; AJvYcCV5eUwBtdmHm7PcFgIdKfp5h9z3kikFhA8twkwQ64Uulsv2FNIO82JovN67M/x4PMzBzUJeaYqyejcGPynP1YPssYmbLKmrnN8q4t5h
X-Gm-Message-State: AOJu0Yx/dMiSa6lustT4ajT6MHiok2swSCkeRRpYjyDs+JwyLcOr8Rqn
	j/ShDqmwqsixieLcScfXYTNvo1mFBC76O7TkMbWelj+UwU82KryQV1h6bxHN0w==
X-Google-Smtp-Source: AGHT+IFuV35DEopal41iDz2o7MrEzXaR2/N5I3z8L/RTuEhAHmh75MLAy2R0IAOqHsk0cSQwfBidpQ==
X-Received: by 2002:a05:6214:3907:b0:6b5:e8d3:6bf9 with SMTP id 6a1803df08f44-6bb9839253cmr71633366d6.28.1722642620125;
        Fri, 02 Aug 2024 16:50:20 -0700 (PDT)
Received: from wilburliny.c.googlers.com (200.234.86.34.bc.googleusercontent.com. [34.86.234.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b5b0dsm11231226d6.63.2024.08.02.16.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 16:50:19 -0700 (PDT)
From: Steven 'Steve' Kendall <skend@chromium.org>
Date: Fri, 02 Aug 2024 23:50:11 +0000
Subject: [PATCH] ALSA: hda: Manally set pins to correct HP firmware
 settings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-hdmi-audio-hp-wrongpins-v1-1-8d8ba10d77f8@chromium.org>
X-B4-Tracking: v=1; b=H4sIALJwrWYC/x3MTQqAIBBA4avErBswi5CuEi0sx5xFKko/IN09a
 fkt3iuQKTFlmJoCiS7OHHxF1zawOe13QjbVIIUchBISnTkY9Wk4oIt4p+D3yD6jVWoUo1Wm1yv
 UOiay/PzneXnfD2TVcyNpAAAA
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Steven 'Steve' Kendall <skend@chromium.org>
X-Mailer: b4 0.13.0

In recent HP UEFI firmware (likely v2.15 and above, tested on 2.27),
these pins are incorrectly set for HDMI/DP audio. Tested on
HP MP9 G4 Retail System AMS. Pins for the ports set to escalating values
(0x70, 80, 90) to have differing default associations, though in my
testing setting all pins to 0x70 also worked as suggested by the first
link below. Tested audio with two monitors connected via DisplayPort.

Link: https://forum.manjaro.org/t/intel-cannon-lake-pch-cavs-conexant-cx20632-no-sound-at-hdmi-or-displayport/133494
Link: https://bbs.archlinux.org/viewtopic.php?id=270523
Signed-off-by: Steven 'Steve' Kendall <skend@chromium.org>
---
 sound/pci/hda/patch_hdmi.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 707d203ba652..dfcbd41097f8 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3115,6 +3115,25 @@ static int patch_i915_hsw_hdmi(struct hda_codec *codec)
 				     enable_silent_stream);
 }
 
+static const struct snd_pci_quirk kaby_hdmi_list[] = {
+	SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
+	{}
+};
+
+static int patch_i915_kaby_hdmi(struct hda_codec *codec)
+{
+	const struct snd_pci_quirk *q;
+
+	q = snd_pci_quirk_lookup(codec->bus->pci, kaby_hdmi_list);
+	if (q && q->value) {
+		/* Recent HP firmware assigns incorrect pins, corrected here */
+		snd_hda_codec_set_pincfg(codec, 0x05, 0x18560070);
+		snd_hda_codec_set_pincfg(codec, 0x06, 0x18560080);
+		snd_hda_codec_set_pincfg(codec, 0x07, 0x18560090);
+	}
+	return patch_i915_hsw_hdmi(codec);
+}
+
 static int patch_i915_glk_hdmi(struct hda_codec *codec)
 {
 	/*
@@ -4620,7 +4639,7 @@ HDA_CODEC_ENTRY(0x80862807, "Haswell HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x80862808, "Broadwell HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x80862809, "Skylake HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x8086280a, "Broxton HDMI",	patch_i915_hsw_hdmi),
-HDA_CODEC_ENTRY(0x8086280b, "Kabylake HDMI",	patch_i915_hsw_hdmi),
+HDA_CODEC_ENTRY(0x8086280b, "Kabylake HDMI",	patch_i915_kaby_hdmi),
 HDA_CODEC_ENTRY(0x8086280c, "Cannonlake HDMI",	patch_i915_glk_hdmi),
 HDA_CODEC_ENTRY(0x8086280d, "Geminilake HDMI",	patch_i915_glk_hdmi),
 HDA_CODEC_ENTRY(0x8086280f, "Icelake HDMI",	patch_i915_icl_hdmi),

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240802-hdmi-audio-hp-wrongpins-f88606f8d3ab

Best regards,
-- 
Steven 'Steve' Kendall <skend@chromium.org>


