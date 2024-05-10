Return-Path: <linux-kernel+bounces-176013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4378C28BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0438B2872E2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF794175573;
	Fri, 10 May 2024 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="s+BF2aXy"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DA176FD6
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358382; cv=none; b=PRQNPMm1PTlkh8dHT8sPbiOnAcj8nJ8g1YLFhWgVBQM40zHcrI7sHdQOklFBQlTvG91xVwpX8uGXOlhu97ayjrN8Su588UE0qIoYb1hAL000IYkmeSF67p+utenjCflXpCyRYd5Q6xqFIea2mHOdKtfR+5qXOlSaF1tFTt/VOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358382; c=relaxed/simple;
	bh=KbpZ8d+RgwRLaIMQKqSigv1pMFc5n3ynVMEzJAYBd0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmxD3AqFspYOuKFH2oeZPZFaZkuthSjpQe7lNurndfoNHPPzvqu4D1+nO3IPVM0aB2e56E1xKh6kb8/PeGpIPAuAGSOaXbg8Xkg6KaEgLHV1HZ+8sgOYD2MmWlJxbxIkSB4WWw4i6GmtqOyIq+KinYxkqClPqpS4EKZ7waHM+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=s+BF2aXy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34db9a38755so1963785f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1715358376; x=1715963176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR5Th4rgsENBGC1XHGIaoOrv3KgiGLQWWbPFYgnaOZw=;
        b=s+BF2aXypt2jr58DeNFOn2BHSyW10ZqG83XvjafmJtepCygO1c+J788odMPsATwUcF
         pd7RaXS19SrYF+8lHaprfICoQFxDeezqKMyWpLB6j7HxZPfa/SHcAbv6+DfZrdb/zrrY
         Xiuyoq3g+LYlI1G1DAkHoD7/woLmjDf3uxbn7LlB6JaAu8W3DXXdmOQAj47hkaBlJJaU
         YWZmQtArzxn6ZuxLNGqahXi7sslnVVO6+FphG1mxCVO7fEradADWcb/r6J1vzrwxuKfr
         A/ofCw8NGnkr+6iNo2MtSKPJxFnMke5QfSQ7dnBQHkv5YHFRbiANhxCllyss8wfjQkgI
         7D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715358376; x=1715963176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR5Th4rgsENBGC1XHGIaoOrv3KgiGLQWWbPFYgnaOZw=;
        b=KtdOdq2cvzH1KGlPI0xrL3s/DhYobzuq0FxCba+yuJCu9QV2ng64oohEOcrRMPcf7p
         B2YktEXqzxP44e58vWHak00BsU+cK2Fs6Gg4YPbP8vI1KScEUNP4WO3D6CUiN44no5uc
         D7v2/Y2d23x+vCTMMR8nRxfmaZAHcM3IsYb4NCvdeBtcEVfHZ2C7BfkuPNIXE6Na8P6H
         86XqltRrWCvorI/lROiTZXMXRUfoWEw1N/spwq/LqXGt/Oxr5nlECENBCMT2rJbEESEy
         /YyZDtmvuqnpUpQ4VMBGdZ0a2yMOcVfXEbkwiN/DlW7790RdzTxTg0OPj6bK9L0+vAUH
         bLLg==
X-Forwarded-Encrypted: i=1; AJvYcCW7/0bDg3BYcrlge7TCipgLA1ZJgUDZSzphwmSAVpX769y4uyC8Ryj5d32bTSFTAUoBcxymZmefe6OUSe0afGHftFrDUMaM67OG/wrY
X-Gm-Message-State: AOJu0YxRbb4p0D38MZaIkwafQcAap6/XIr0rGIWlU+GrewrcZpMeZV0z
	4cErG/K/27d1jFg7ZEJ3c23sc/s2BQQitGmwO5oD7x42pna6MpV4HeKxT8pqpIqE8DsdIon2y1K
	C6Rc=
X-Google-Smtp-Source: AGHT+IGnMyhOx29AvuQhDh0cLZxd8JVQPcGXpdsgHPHaDyNcqfDQQCBeaoRnQyw34Crs9jM3D/0ZVQ==
X-Received: by 2002:a5d:6503:0:b0:34c:eb4a:1948 with SMTP id ffacd0b85a97d-3504a631080mr2882705f8f.5.1715358376406;
        Fri, 10 May 2024 09:26:16 -0700 (PDT)
Received: from fbxleo.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896aa5sm4952206f8f.34.2024.05.10.09.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 09:26:16 -0700 (PDT)
From: =?UTF-8?q?L=C3=A9o=20DUBOIN?= <lduboin@freebox.fr>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?L=C3=A9o=20DUBOIN?= <lduboin@freebox.fr>
Subject: [PATCH RESEND 1/2] pinctrl: core: take into account the pins array in pinctrl_pins_show()
Date: Fri, 10 May 2024 18:25:38 +0200
Message-ID: <6df39bd47942156be5713f8f4e317d2ad3e0ddeb.1714049455.git.lduboin@freebox.fr>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1714049455.git.lduboin@freebox.fr>
References: <cover.1714049455.git.lduboin@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We previously only looked at the 'pin_base' of the pinctrl_gpio_ranges
struct for determining if a pin matched a GPIO number.

This value is present only if the 'pins' array is not NULL,
and is 0 otherwise. This means that GPIO ranges declared using
gpiochip_add_pingroup_range(), thus making use of pins, were always matched
by the pins in the range [0-npins] even if they contained pins in a
completely separate range.

Signed-off-by: Léo DUBOIN <lduboin@freebox.fr>
---
 drivers/pinctrl/core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 6649357637ff..901f2f9bf850 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1672,11 +1672,20 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 #ifdef CONFIG_GPIOLIB
 		gpio_num = -1;
 		list_for_each_entry(range, &pctldev->gpio_ranges, node) {
-			if ((pin >= range->pin_base) &&
-			    (pin < (range->pin_base + range->npins))) {
-				gpio_num = range->base + (pin - range->pin_base);
-				break;
+			if (range->pins != NULL) {
+				for (int i = 0; i < range->npins; ++i) {
+					if (range->pins[i] == pin) {
+						gpio_num = range->base + i;
+						break;
+					}
+				}
+			} else if ((pin >= range->pin_base) &&
+				   (pin < (range->pin_base + range->npins))) {
+				gpio_num =
+					range->base + (pin - range->pin_base);
 			}
+			if (gpio_num != -1)
+				break;
 		}
 		if (gpio_num >= 0)
 			/*
-- 
2.42.0


