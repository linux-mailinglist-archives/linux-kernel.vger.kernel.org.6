Return-Path: <linux-kernel+bounces-569853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8D3A6A87D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272951B62A08
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C9B22259C;
	Thu, 20 Mar 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNGP6xM2"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7BB2222DA;
	Thu, 20 Mar 2025 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480409; cv=none; b=M+e9Q5IMHHcRTVx8coJulTYyAE3ZGjmNesTsXi6PlhrSth+MLj2O8OGHQSwcyjaMN6MQ+2bzzLU2OeMmE6XFAMmVE0GLP0gnYQjWLWVYAW//3Ed4MEv5Ogp7aHXDwvJ9kcfDhkdUXzLqtpNZVss6GuTNuy+1J41E20IdTwep/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480409; c=relaxed/simple;
	bh=dH8kqMOzYKRkO8AFezYTvcfiSExxo1tsEVf2jq0pJzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=G8PkiuKYxtsidrBa72H3upd0FiE2uerwL4I0wp7hdsJCGa7hzaqeWjoJXunETQFLZ8YYyKoS/8VuIrRBpb9Njl5wekB05iVgUy2uZ8m+XIKXUlLS3MmCAoofuzFgAiIKFYmUB+BuziIRovU9ChSYKWIo9BKSOKx+dKckSKhnybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNGP6xM2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so13397355e9.1;
        Thu, 20 Mar 2025 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742480406; x=1743085206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d++5qthA5Opum/cYe1SfT054ozKie7YLEL3LQBhRUG8=;
        b=mNGP6xM2koKQldqH36fmkyRMAG5dQO8dXeUwXLXw+L4IkJq6l0qnWpmRRWgzR5S3SS
         oEb44Jy3J+bgRyFBVVgjyIQSgLuC0oAn4U6h0wFrlbHBD4SaWKc3z3x/rwoyPAYsD8Ux
         2MK86wA5Jm6TjgqNBh1dsxhmBZvRm1cM1J1RBLs/l3CLYMiAXhNNww4egNPWTJCsBU5C
         JLA8pkTmV9OSDYPFgOALqhZDEEoBSNLzbDu5CSUtwqYVXmgXj1Bmk47DDZsmfvrkw3kV
         HS2I6Bm02hKXRpOCVgpIi9CoxuRkKMPcs8d23GI5eigLmurbpk2va1jMiG1us9Ih6FYR
         f6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742480406; x=1743085206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d++5qthA5Opum/cYe1SfT054ozKie7YLEL3LQBhRUG8=;
        b=v8wtR0l3NbUbzFDGyCTyYfzOAUk+zVgiBAZraSZwtwtqhH477T8k7nHge0Nda+pflw
         665eyEH3bpzBPWr90Qu9vKrWsS4iLllfCGxREUHAd7mVt/jnzezCSEaURqNnqduh7XtG
         KgsrwAy/aArZR0JjDBWU08dOqa49O20H0pXj8NYZCMHa6gY3bxKQUBzGMn0uNkRw+Rkr
         uVXLJ48NP0/dWntRNG+BQVZekNHVt/zTBRnPvzwl5zConDfK1+rVAY5328vA9IkgYYhN
         6idZu6MVW9eh/Ycd9hZVpd7G0GN8Jqkyxo7vS/g1g5Ro5FyDw2Js3fhgTbSkTIX5D4TX
         zD/g==
X-Forwarded-Encrypted: i=1; AJvYcCX19fX+fuKoZI+oX8Ui2tTJDMvI/sJ7wZoypnd0roiGglOxN267EYfaLT73apIaPerkEOdLYQh8DHfCR7/DU8YnTdmL@vger.kernel.org
X-Gm-Message-State: AOJu0YzrdDktBoNMK6tLueMzIjkpLhFtrQRN8fIfOKN9H+VlWyokRpQH
	L9IHoHziEBGpMQpGcKcOcKXExcXtgVfVNMweB+01euYJd1xp3MgQ
X-Gm-Gg: ASbGnctkRjY3IO2agiWh5qr+00F/zZr7xNexfc2BDYHwPpAnRwbvkWtZkOUmDu5Zneq
	3vtdcbCFhZRkkNsraSGgVhRmW7m/qtjqC8Xufi4WejDVZur3JhnnhCtujQ7Zhqi/uab4oMWNjMl
	XxtlLuipq1nNuPen4OUKX5H0WRUBsnl08XAEFKws3VIfALFn/cM4hjLnEgsQP2trVIFeLAlALrx
	napjisSNxwC3y/lt6WhEhMUFZSIIFSX9HnM3QaY1KdSzrSoELV+4k+NXKtJaAs+DoP3OlzFQFWR
	Rg01dVyZJvd9LcEiys/oo0a4Xq9gkSbs9bGs99TWNr74kya2if7h/fSF2KwbrcHMwg==
X-Google-Smtp-Source: AGHT+IF3l+WLY4jkAz298OXh4bWEj10Qycnuga65VLJ+RBNkbb+Ywo27cb98HEL3SOAtb+0m5yIeLw==
X-Received: by 2002:a05:600c:ac6:b0:439:91c7:895a with SMTP id 5b1f17b1804b1-43d49172281mr32751085e9.7.1742480405391;
        Thu, 20 Mar 2025 07:20:05 -0700 (PDT)
Received: from pop-os.fkkt.uni-lj.si ([2001:1470:ffef:fe01:4c36:e005:5f88:7d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f556a4sm50352695e9.22.2025.03.20.07.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:20:04 -0700 (PDT)
From: =?UTF-8?q?Ga=C5=A1per=20Nemgar?= <gasper.nemgar@gmail.com>
To: ike.pan@canonical.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Ga=C5=A1per=20Nemgar?= <gasper.nemgar@gmail.com>
Subject: [PATCH] platform/x86: ideapad-laptop: Add a few new keymap entries
Date: Thu, 20 Mar 2025 15:19:42 +0100
Message-Id: <20250320141942.67391-1-gasper.nemgar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Added entries to unsuported wmi codes in ideapad_keymap[]
and one check in wmi_nofify in order to get wmi code 0x13d to trigger platform_profile_cycle

Signed-off-by: Gašper Nemgar <gasper.nemgar@gmail.com>"
---
 drivers/platform/x86/ideapad-laptop.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 30bd366d7..624889703 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1308,7 +1308,17 @@ static const struct key_entry ideapad_keymap[] = {
 	/* Specific to some newer models */
 	{ KE_KEY,	0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
 	{ KE_KEY,	0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
-
+	/* Star- (User Asignable Key) */
+	{ KE_KEY,	0x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
+	/* Eye */
+	{ KE_KEY,	0x45 | IDEAPAD_WMI_KEY, { KEY_BRIGHTNESS_CYCLE } },
+	/* Performance toggle also Fn+Q */
+	{ KE_KEY,	0x3d | IDEAPAD_WMI_KEY, { KEY_PROG4 } },
+	/* shift + prtsc */
+	{ KE_KEY,   0x2d | IDEAPAD_WMI_KEY, { KEY_CUT } },
+	{ KE_KEY,   0x29 | IDEAPAD_WMI_KEY, { KEY_TOUCHPAD_TOGGLE } },
+	{ KE_KEY,   0x2a | IDEAPAD_WMI_KEY, { KEY_ROOT_MENU } },
+	
 	{ KE_END },
 };
 
@@ -2093,6 +2103,12 @@ static void ideapad_wmi_notify(struct wmi_device *wdev, union acpi_object *data)
 
 		dev_dbg(&wdev->dev, "WMI fn-key event: 0x%llx\n",
 			data->integer.value);
+		
+		/* performance button triggered by  ...  */
+		if ((data->integer.value | IDEAPAD_WMI_KEY) == 0x13d ) {
+			platform_profile_cycle();
+			break;
+		}
 
 		/* 0x02 FnLock, 0x03 Esc */
 		if (data->integer.value == 0x02 || data->integer.value == 0x03)
-- 
2.34.1


