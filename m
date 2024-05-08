Return-Path: <linux-kernel+bounces-173896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6B78C0754
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB1D1F22896
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3561332B7;
	Wed,  8 May 2024 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IoptlRlN"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E751D130E4B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715207370; cv=none; b=jnpbgHv/kW2kgzvVLzaxZpJVGc9cpwEpxQ/NJc/uVx2JElxCvxhgZ/UQBL7bF8c6g48VXWQUX9PjSRatOmo5DqlYRso1n9P6jplHRtH+ESB82TG/OtqREr4AKYLYEXvZvxZYFpSbW75qGzDtfrNcJ2fdJDNu4/SciegaNUYvzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715207370; c=relaxed/simple;
	bh=8B9U/Jq1YW4M/1V/dd2FLPL91hKSUgdh2KH3CarfTVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y2bcmqu2JcgHL+JxCF1YUekBOx27iog0la5RsBjcE1arCD1plWsGuyOlQqV4ON8TtXnqMnXnAKyng/++UXoHKpgV2815qpHHAyA5uiuWa5HZkSs8ur1l5GWxmdC2+XSp66N80ky7JOHgRSQ61FGseqjJeK6P5bUaLYjVlx1tkU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IoptlRlN; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-792bd1f5b38so15278585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715207368; x=1715812168; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtYXFaRMkuNbSKWGsrMMLWmq/9Bm3mRH0FfZ3hEbB6k=;
        b=IoptlRlNNYHLQMbi8gvoIjgfcIdgtLHNUFx64Wmy8q6Hj8AtLqoZBNcLVOyxPVipXr
         +SnxNKNwJObHuKMsaagRrNVFxrhUY/pz2oga5Ow8KvhDpIYMrEkEoyjH4LaNEZhwUPVd
         mP5W7unquv0MCfWgJ7kpuE8sMrrNiGxoL2ctA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715207368; x=1715812168;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtYXFaRMkuNbSKWGsrMMLWmq/9Bm3mRH0FfZ3hEbB6k=;
        b=WnPDT9TTiOMyKHZYpX55ojcJt0MIAtBgZOZlaZaH+xxfrlZ+KmPNeopFL2d920dTV7
         R+frgtSiVObNWtDWc2RYreZyBDEwRQO+ryDsAcrvvCtZmeFylEVFalXUJmeP0XSRAgTc
         MuWz9NsAVBuYQ1cnHM2aFPuYVjp+SSoNkFu+m8UAheZxaa6k1XuGaUXDUBM4cWPsfJdX
         LsLSY9XpEmWM8xbdbAWtnWfhcQmxcn9JF9Ijr0qlCipH0dP1wmPaOPHK07CA6GhVOc21
         1OhNYWDoSKSnA7q4qn2qzFAMsO5da8/FG5w0waQaqgB7ntnPs5A4A0yzheoAqhUJk9UK
         R8Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVRbsYn23xFLmJIgXRXQ10t17Swrg1/wSskgQQlTdMzabgVThds+KeoPNuHWvYOVW9oEj9VLqusSPlPBejS8E2cxQYmf6f+Cuaykrf2
X-Gm-Message-State: AOJu0Yzd3GFQN4B1LT2sN5rCVmsdsoz9ZohnOGcl8DZHX5jRawcKixlQ
	2BbzfNMd2tlHz/Qprlfg2LE5+w1NG3JXwltaQwDrXOWNlJdTscLA03oLtLFyt4rj1UMWI5EjTY0
	=
X-Google-Smtp-Source: AGHT+IF522O8v28imST8TxoifwAGm3r3WEAHh5gz2AFejF7YlVXd5l2jd/arFQNSy/japXHab8qAfg==
X-Received: by 2002:a05:622a:199e:b0:43a:89c1:6b76 with SMTP id d75a77b69052e-43dbf754902mr31637171cf.65.1715207367851;
        Wed, 08 May 2024 15:29:27 -0700 (PDT)
Received: from wilburliny.c.googlers.com (200.234.86.34.bc.googleusercontent.com. [34.86.234.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54b58b5sm272411cf.7.2024.05.08.15.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 15:29:27 -0700 (PDT)
From: Steven 'Steve' Kendall <skend@chromium.org>
Date: Wed, 08 May 2024 22:29:25 +0000
Subject: [PATCH] ALSA: usb-audio: Add name for HP Engage Go dock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-usb-audio-hp-engage-go-dock-v1-1-9e2984d49e63@chromium.org>
X-B4-Tracking: v=1; b=H4sIAMT8O2YC/x3MQQqAIBBA0avErBuYxKK6SrTQnGwINJQiiO6et
 Hzw+Q9kTsIZxuqBxJdkiaGgqStYNhM8o7hiUKQ0tdTjmS2a00nE7UAO3pTER3Rx2bEl26lB92Q
 GC+VwJF7l/u/T/L4fLFhvam0AAAA=
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Steven 'Steve' Kendall <skend@chromium.org>
X-Mailer: b4 0.12.4

This dock previously presented as 'generic USB Audio'.
UCM may now be applied specific to this dock.

Signed-off-by: Steven 'Steve' Kendall <skend@chromium.org>
---
 sound/usb/card.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 1b2edc0fd2e9..bdb04fa37a71 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -425,6 +425,10 @@ static const struct usb_audio_device_name usb_audio_names[] = {
 
 	DEVICE_NAME(0x0fd9, 0x0008, "Hauppauge", "HVR-950Q"),
 
+	/* Dock/Stand for HP Engage Go */
+	PROFILE_NAME(0x103c, 0x830a, "HP", "HP Engage Go Dock",
+		     "HP-Engage-Go-Dock"),
+
 	/* Stanton/N2IT Final Scratch v1 device ('Scratchamp') */
 	DEVICE_NAME(0x103d, 0x0100, "Stanton", "ScratchAmp"),
 	DEVICE_NAME(0x103d, 0x0101, "Stanton", "ScratchAmp"),

---
base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
change-id: 20240508-usb-audio-hp-engage-go-dock-50b629480a9b

Best regards,
-- 
Steven 'Steve' Kendall <skend@chromium.org>


