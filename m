Return-Path: <linux-kernel+bounces-577446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 020D1A71D23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AEE171208
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A28D21930A;
	Wed, 26 Mar 2025 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mtroyal.ca header.i=@mtroyal.ca header.b="cn5I5NX/"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4175219301
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010120; cv=none; b=HwA1BlsRwT7/Y46grMHNVU/InZ9QWrfeJ1xqt+Koa7mXQ1FvDCKxhfmCbahBDYywbtB4fMvXpk+tnWrcm3eJMrMdaHFggNkXV09YnwEAyeT0v6WYVCWv3m9f7JnqIWGwziBJN8uYQchqkRiqKGCo/poL0OERrob0R9VE7do8/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010120; c=relaxed/simple;
	bh=oKt+TJWqyStRMCKk1W9jz+VuWUxxZ79pbpj1FVu5hKo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VYDXV0/HDRJp6NXmxr0D4Al4EukrEgc1GkhuSfvvsljIue28Ng4fF1MW0G26OhfAQWq+ZC8Cd9HKcZ9WBOeMzQOGfg//PdktRZAiN6rrS/0xZBiaesGpzS/5/gtQDTL64QSOLcejhcTdMI0Xt5bZEGhWII4PP5eUXQzPfZIDhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mtroyal.ca; spf=pass smtp.mailfrom=mtroyal.ca; dkim=pass (2048-bit key) header.d=mtroyal.ca header.i=@mtroyal.ca header.b=cn5I5NX/; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mtroyal.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mtroyal.ca
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523ffbe0dbcso108969e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mtroyal.ca; s=google; t=1743010116; x=1743614916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DnFKKB83AHK6QdBloILmeM8/LL4TGbDb871A/NdEh+g=;
        b=cn5I5NX//IiFFUrWEuf2/VCc6jFR76VQjdyfb1ipYiXcra/f83XxloXiL+RuX5yQIK
         Ns8edghr9PepNjcW3SFgW8mSw54PkyocTo0evyI5H35+ThpgelFbyJe/bixQRZRCZ5SA
         K8QypVqCGd8F/NCFv/iH2SpIZaBiilJXxOSoj7bjiuLoIh43sycjv7t5fmInSJ77K3FF
         P0NxLHqiEW2Pa62+Zdo5ZCT89X8TaV67vH5GxcmhIN/NMkf8NNcWHGUDCWlFK1aDO6HQ
         V8WvKIsnqWkEzStubpLVG7lWH8N8FV2U0D10BsKVGHd16BUykMSHRCPL766lr22/obup
         1mrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010116; x=1743614916;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnFKKB83AHK6QdBloILmeM8/LL4TGbDb871A/NdEh+g=;
        b=vSxv6OgQB2ft5WHkLr0sf8CSlghPH9AoUv2Wd5kKWSloYRchkN/wGe5HDvLC0YvubK
         PGjVBffAz+3HWNiS5z/HXBJ/siLSxMyzU4ezbODSO9keN3pFJduAUeR5WeroWL3/TQiQ
         yObwQSx+v7YOWXQqN+10ZWnYgfx4qF1I7JFt6MznriVHSTgHvOhg0wALXPAPhhaq2v87
         Do38p0Sn75KZx5OKQ1FhkFQKjlcwBHNMNgB0cxMKYYIkJma7DUgZN8tOlj8BruN+Jdds
         Dz43Zx7qusdaLGhcA4B7SYVQR/UU8Q+Vy/m/uLRq5hyrxM57Pq6xWN7kzKd6gQrSGr/t
         /LVw==
X-Forwarded-Encrypted: i=1; AJvYcCV0kNtokeBmAoImerLR+K4hyZRWvZ9ahteZCqLJ+sIW/h2Ed4WipJZ1j0Dmw7Bsab8oN6DTei7Lhw/8SNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5YbwwRBYvL1i2MkLGqfqG8aHiSohEl8K9+/pK4T+QaTk6U52Q
	AM+NKY4mS4D3Yjsf4UTrjfS8o7dERd7y+vPBGEFBhp1/inABwOhSKne2l+glWwB8IVyVlX1yQ2o
	HeXxIesfevhoYeDJzk4CU53p49RueiJaUZRMv
X-Gm-Gg: ASbGncvFtqkpZ4IiLtdJWLGryD2nhAgNU1s38wAeMcFp94SlbjO55OgRytxGRa0Plq/
	AyXF88UwsCnmyl+bkqW8U0GiSy4OOKqs/Hzf3EQHL8RjPG3OMVodfWB7z3r81z5jw6mBpyjo1nL
	4rjZqNGogU2x3CkUsZRpPO/qsVIMCwVb6zukxzp52VH7oX5GDsUAWmUsPwhro=
X-Google-Smtp-Source: AGHT+IHTEVES3E7yvKEH6kXCoK7OqzN2cJjE/BYKxwOODulv2btgTc48eKqaBdFhGyOwAyJGFKhRUpfyqRfJUgkDklU=
X-Received: by 2002:a05:6122:8d3:b0:523:f1f9:d03f with SMTP id
 71dfb90a1353d-526008d0d5fmr581007e0c.1.1743010116288; Wed, 26 Mar 2025
 10:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matthew Hrehirchuk <mhreh594@mtroyal.ca>
Date: Wed, 26 Mar 2025 11:28:25 -0600
X-Gm-Features: AQ5f1JqrPHaHofLZCfX9KpSinbKHknbHEky92oCIwp1iHqZDQ-IW1rGaj7YxIq8
Message-ID: <CAF3zC4z36GuA+vZte8TwLSfPEe9tZUUbT+=GRAFtZvt2g_Jsnw@mail.gmail.com>
Subject: [PATCH] added support for PRIME B650M-A AX6 II motherboard network card
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: marcel@holtmann.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From 2bd405f7ce07d6891bff195c58c5b1a0c823a0ff Mon Sep 17 00:00:00 2001
From: Matthew Hrehirchuk <mhreh594@mtroyal.ca>
Date: Wed, 26 Mar 2025 10:17:16 -0600
Subject: [PATCH] added support for PRIME B650M-A AX6 II motherboard network
 card

---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a0fc465458b2..44b9965541f3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -536,6 +536,8 @@ static const struct usb_device_id quirks_table[] = {
                              BTUSB_WIDEBAND_SPEECH },
     { USB_DEVICE(0x13d3, 0x3591), .driver_info = BTUSB_REALTEK |
                              BTUSB_WIDEBAND_SPEECH },
+    { USB_DEVICE(0x0489, 0xe112), .driver_info = BTUSB_REALTEK |
+                             BTUSB_WIDEBAND_SPEECH },
     { USB_DEVICE(0x0489, 0xe123), .driver_info = BTUSB_REALTEK |
                              BTUSB_WIDEBAND_SPEECH },
     { USB_DEVICE(0x0489, 0xe125), .driver_info = BTUSB_REALTEK |
-- 
2.48.1

