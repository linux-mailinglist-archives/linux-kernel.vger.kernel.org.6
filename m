Return-Path: <linux-kernel+bounces-365594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D7099E4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCADE1F24193
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658321E7666;
	Tue, 15 Oct 2024 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="w9sXKcvb"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF741E6DEE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989796; cv=none; b=kj63ONP2fbNk8xcjESyPTdQL39Lelzn7F0MMJOAtXC8qJCknvyPXb47VzcNG8giwtoklPPG5qlVb5P9HnVeAy34SDZ6r6a9AtR5f8KaRZZm61vLBZpA/MeuOLuZtV0nwK/ssLAR+tjZiy7JlwLqafnVcmA/EWr8I8hxE5Oz82UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989796; c=relaxed/simple;
	bh=POHh8g+2CvyZoU0L+E1KmaYOw5grZB9aKoaGo7YEz6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i+0G9wb7V1OEViPQUnlf2tF2ZKwJA4GNgD30/K4oQ4FnHRF35mg1mBwU3KYmy/1ZrApfJcmZOU0vvLnGjhgXl3vERG8I1fwGTLxccytk7gF+4h7K52ogfOAUsqlAn6qwVApIYFFxXsyQPqyQmgf0sUsOe4pm/JFSGiTlme4r0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=w9sXKcvb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d462c91a9so3330456f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728989793; x=1729594593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OB/wBkvSEUCyn6Pce3Sw/d9S+YTAmxmeVBF6YPbGUIs=;
        b=w9sXKcvbLnUe1a5tQ22wsZYvHb4Tw3cASFTgrym2nJ0UggtAwMDJl7JYrsrIFJxA32
         9bDU++pW7fZ/9N3X6xYfI9cwxflLMhAU/BOPjBIimDlwutivGbWfpqMm6Eu+jNG0ZGEi
         cwieASLOIgo3qrk4QLZwxje2vgGCJWLlcmVvV2u3g3R4jNy0jcE8RVYf75f2EPUbkui9
         +RZNWcN9q4WRG0NOX/lvEOR5skEL5comTMzqS+Rm0iwFeodFEFf3or+xaF68oIOHTU3D
         byZw6ymKQckv3E/2i0veXzgBj6KUGUCKU8WPO0Ju+viaIFXPoSiRK/Td7ldMvGnr8HBo
         yPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989793; x=1729594593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OB/wBkvSEUCyn6Pce3Sw/d9S+YTAmxmeVBF6YPbGUIs=;
        b=qrRWA/mFZjEmXvtgA6y+ttc9c5HAaHLHdaSu12V9Oj93j93YT3wM3Hp9uCQC8kxSc8
         9zYeIAjQNdjsNaNWX9WC26H70D9YjGJqEPhVzyFUrxR1spqPzfzyw+6ALlopC6/10uaO
         rF1uZ+W8TSGo2nEetXSUd6RpsiWh0AouuUlC2XRxkfbBA6LyDirshyx2YRbW0AFCfONu
         qPvKW4sDJixqwOP5CxBFr49YwNX5HAT3oLoQBXzHEFxWzeI7ZfWdypYuRAEyWcgTU6gJ
         jrNBpUYLPXh2/uJPDhWksrY4gyJYXnPGqyBE8iz3500hXZtATarI67iHAxY4LMXjTyn/
         mdTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8Dl9D3OpdOwUshmfaFFLP969hP1H509jczMThrXwHbRK0nqau195jqGW1XEkwCxLhv2JbhCm/ZOhJPjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxEoMNgeVbfsg20mbpvqDZvFyGcCp2OPM65JHXsruiJluF+5bd
	RzqCq7iRqbPO1pBorotTgn3aEbdj4lv3gu1nsMYGVfOFl3Kc8LP8yP+LX9SiLfzBQ5Z9bpD+eRX
	w
X-Google-Smtp-Source: AGHT+IGPDhoxi4t0FwbzmOsIZ+cexOTtluzQbWzttetOTGpkuLst9zhZTEkHOz6D3ry6ydwqci61oA==
X-Received: by 2002:adf:f288:0:b0:374:c4c2:fc23 with SMTP id ffacd0b85a97d-37d5529fabemr10540698f8f.56.1728989792803;
        Tue, 15 Oct 2024 03:56:32 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d382:b11b:c441:d747])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc403d3sm1254115f8f.101.2024.10.15.03.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:56:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 15 Oct 2024 12:56:13 +0200
Subject: [PATCH v3 1/6] gpiolib: notify user-space when a driver requests
 its own desc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-gpio-notify-in-kernel-events-v3-1-9edf05802271@linaro.org>
References: <20241015-gpio-notify-in-kernel-events-v3-0-9edf05802271@linaro.org>
In-Reply-To: <20241015-gpio-notify-in-kernel-events-v3-0-9edf05802271@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=782;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=zMsMSJX1Nl0+caHE+JZSEzX7KhbE4YG1tQGrQmi8r44=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnDkpeBfCLeK9n2OwNNmJVy5zXeg4cQdpyu/cED
 vlQToy6702JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZw5KXgAKCRARpy6gFHHX
 crb9D/9Z4QrxjSsPaqs/c9ITfR89kkLc9Ke/IetJgq89alayXHBv62HDxc2ES/R8CD14LiZAeXu
 aYdLFTwt4qndPwq+Slj6jgdbUrCc7/YKeTRLYgQdPbgCDGC5KBW38BUZg3V/EQbkeHaY+6z1TL2
 sszaWxReN0zuGFopufoQPH9CK6KNFVT8087Fs84p0jAGRAkxgX1AW68Oxw5gMDz86PTl30U0R0g
 YWc4BKkfgNyBnFN0CzIlUrLHfyo+hZRKTyIFE3UHG6YtHnoFxsz204NUShRT1dYkxnQu4SZd6P4
 QDzjqzL1r1wYBn7tFERmJryQvX7Kut2vl3Oyc55H3ZM0QtsuZolwi0rhE2r589Wwj7tFCI3t9dn
 Jy7ZapZ1X/GdoVJa+QDFIR0SrwPXE/PmTs9ub/GmdzqR3VbrZAJ2sRGm+g/T38UOnDU85CGcBk8
 Yuny6fVfxlz78r/GQaHcMRSJf7sOwOdvr5dTZFA2l05HmtujRQuUwR1ao4xh3/CNKpjAnYq3yj2
 TCuK3HsSf+vf0VwJrAcYWCVHK8PpzQXu0X4GLAR1C5QiZ6IObqF7NF0meLcH0RFrSw+No2MRLPr
 FxvATwHmJMw8YXtikGAoeSuPh5u1vYJc5chUYH9WYwowKcOGLp8tAHFMsHi8bg0zsRzZPNRZpyo
 4yYXGcxw5KL2OAA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We notify user-space about lines being requested from user-space or by
drivers calling gpiod_get() but not when drivers request their own lines
so add the missing call to gpiod_line_state_notify().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 97346b746ef5..c09464f70f73 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2532,6 +2532,8 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 		return ERR_PTR(ret);
 	}
 
+	gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_REQUESTED);
+
 	return desc;
 }
 EXPORT_SYMBOL_GPL(gpiochip_request_own_desc);

-- 
2.43.0


