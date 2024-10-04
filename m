Return-Path: <linux-kernel+bounces-350524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA0E990678
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2F51C21DAD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6323621BAF1;
	Fri,  4 Oct 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OrB2OOTB"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D4021B42A
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053019; cv=none; b=q20enQ86UOQ+vOgmdvlHIAoM1EMO9RS4RpJAws605rvev/Daz0NvJjipjNOrdzNJm1k+dXM5q491ChzSXfmBBd1qLekeVQreXFYHM4Sovof7F4EDbZErFNjjIId0WYxV5wmmV2vFLpGtgrGFwbSJoE4Xyn82sIb+hzAffAL7g8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053019; c=relaxed/simple;
	bh=LvSUVHCEYa75B76/06/pgPDfGMpyB/pmvNoZX5DqpsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gX1l7uAF1NSUr+zGhng29cueI+KjC145vLw3fp5eaHIUFawsEah/MXfmDeXeD1O1tPaZDaogOQebEIFf03pH3EucrF77K1wQrqQ/YXPTiWI0AelMFhBJ6QDxrtMvgB0FXt4rYD633CsIc7slTOPxSzFD6NMwHHmG8cY/s1O14mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OrB2OOTB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37ccebd7f0dso1488739f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728053016; x=1728657816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Ee5xWEeq7S4uSTcaRJnj1WAmTtYVkRiu3mWNu5ZDDk=;
        b=OrB2OOTBbNyh5g6l+EoRLPHnwLFEJfW/RI91dAkkXnSPjEcV29hwlrGicE1+K37xqd
         NnabvnC3IuYjXETKrbmKw10Z7jPsgokSuMk89u+kheZYttn5VdkyOFAumRrBYHlJUP2K
         sezrNzVUyVG77F0z12WAtFNzeKkSwdM+QUG5i9G8u7vP85auHFjCvH4F9NCKvMR/3p1e
         kYZuiqcagxehmOZ4232upMH605CKTgPZ0VAoizOcfzAzxoLoySxwdNnt+1og352jxPTR
         jXfMFLp2pkqE/N7S7d0sv1jR7ZNCEJHMSRhjC0qBssS1g/2U0fRsvFOCLbZ3eIXBaWxn
         oOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728053016; x=1728657816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ee5xWEeq7S4uSTcaRJnj1WAmTtYVkRiu3mWNu5ZDDk=;
        b=XFzuKsT7ax6ifAj3zvfizmDxCPo7+cydHEOsfUJ5fdWmQjxAnIxpjQICuc1ATicTBO
         waLU9BUu5eYMnA20V4xhci3ttx4rT73OtbXFZQuTpf2Dp8cv8MW4sJuBpJodnAiWoXKG
         REUOrHDbcd8q5YN6N52iYkcaQ5Oj1wQgJ9d9MoFDNONzfX7nYTBJ/TRvZO+1Uh3dm8lq
         LyGOnkU3aXBi2ehlqx4GLMCwUxA2+inPz0Jc7NWzG+f19cUv35H1taReUK8hgpc/Xx4j
         5CDOm3kXjrJY/c+Cwj+rW0i8HU26Ehg3RJ1TgJkOvbM+a1SM8rO1q4/7a37ZCaT5UyxO
         GmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYqpbdVdTR2NpvQiNxAM1CJXiWDjjFabmHgk35Lgy6vjebjqnqAMj04cI7bj3dSjwPOYQGpyuAPH653HU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Kk6ZbXfidr2nS2sUdtQAZM31BCFz8H0e2gen2v13tneLL1ez
	oKs+w6N6AtrMYzOtJORK5kfaCT3e/OaQ74nNyTRZ7GqgRt6/lRbhR5tzkyYgyWo=
X-Google-Smtp-Source: AGHT+IH4ieDJNPwdvgv8ZCcUJ8Tih8/86uatD7Q7cdXsunzkfCocXl7DsElBA37H6akaQbNlgbRBqA==
X-Received: by 2002:a5d:67cd:0:b0:37c:cd7e:6638 with SMTP id ffacd0b85a97d-37d0e6f2717mr1848046f8f.19.1728053016315;
        Fri, 04 Oct 2024 07:43:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:80ea:d045:eb77:2d3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d20bcsm3361370f8f.100.2024.10.04.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 07:43:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 04 Oct 2024 16:43:23 +0200
Subject: [PATCH 2/5] gpiolib: unify two loops initializing GPIO descriptors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-gpio-notify-in-kernel-events-v1-2-8ac29e1df4fe@linaro.org>
References: <20241004-gpio-notify-in-kernel-events-v1-0-8ac29e1df4fe@linaro.org>
In-Reply-To: <20241004-gpio-notify-in-kernel-events-v1-0-8ac29e1df4fe@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ZDhG5KXyIkg99fKOqS3EbGyFcZRvR3MZeXd4yD4FiSk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm//8VwLw9BPyfaJK7F1XyQuwU0v+1yL8kdJkRI
 df+Jf7Q3nyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZv//FQAKCRARpy6gFHHX
 ciXfD/9gDhzfHmJyWP9oWZ2apaHgQM6rVNByAOpE/kriCMCLAG3KBOntI4oZgxzz6QUpiuh3mdB
 2V6Qhos9yBVcKz+mSU1PCzeEQRe7SFHHw0N8KypvgwuegMFOvbKd16AYJj5x6lXLn4IMs7N/Apw
 /He4PoSl1jIYrrC3CmcY+2nRWo5Lf4qOc02TZkuUr7WCMaxFURxpb56XUizXYsLYsOwc9WAz8dj
 dn42OAih1Iop40J2FZbwaqP0MXPO8ASYwsibcirI5HF2WVvObQdAS9JMd6o1Ge8bVS3Kb4FdVL2
 FM9XNzQMYChBOefgeFfjbdyyjT0axb/RE1Ze1S/a4XMkZzmJXwjwxJgoP6wZyGu5s+ZTV5cBeev
 jD5CsjiOKwbAz8k7HyqwbHhMHNW9bT/hqaYag9hn07MJ6cm6Ke3rqvOwgZyG9xkwjywYPLcnyo+
 ASePfDY3VAxu0RD8hjCG7cpsbQGMidmUMOMuMs/lBzemL5Mvhsp46kT2qqx6yhTeM6/IPZviZbl
 15WHdpXXilU9DxVISpsCgqMwea5uefZd3gHV8bZ/5SSxrat/xblUzmQ5VWeO2boLFJV5HgxjhFw
 jwyjASE4azh+fBOMVxPuu7B6r+sHezH/kzf2ifgXI25PlCCvR/S8+8IZnSALifTlVuqWn18yqrU
 6yr2M0NNvsfGjog==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We currently iterate over the descriptors owned by the GPIO device we're
adding twice with the first loop just setting the gdev pointer. It's not
used anywhere between this and the second loop so just drop the first
one and move the assignment to the second.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c1051d77fb88..97346b746ef5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1026,9 +1026,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		}
 	}
 
-	for (desc_index = 0; desc_index < gc->ngpio; desc_index++)
-		gdev->descs[desc_index].gdev = gdev;
-
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
 
@@ -1058,6 +1055,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	for (desc_index = 0; desc_index < gc->ngpio; desc_index++) {
 		struct gpio_desc *desc = &gdev->descs[desc_index];
 
+		desc->gdev = gdev;
+
 		if (gc->get_direction && gpiochip_line_is_valid(gc, desc_index)) {
 			assign_bit(FLAG_IS_OUT,
 				   &desc->flags, !gc->get_direction(gc, desc_index));

-- 
2.43.0


