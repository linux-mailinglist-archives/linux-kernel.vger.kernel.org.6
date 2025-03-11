Return-Path: <linux-kernel+bounces-556477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C113A5CA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE1A1894D46
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807EA2253AB;
	Tue, 11 Mar 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/1gEMZP"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD725E809
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709318; cv=none; b=QVmVIRrTzOejz1RFQ11hEPrZk1G9ecovGn6qTEORCm/7D2bZPI9lsv6shovIO13HtUKj3YzJDscTcKXjwh3R92lwpKDcssnrYdxU+8X7beEibAKlnP7RRreQjeGUbLEPPrkb8Km7XhkdYaY0IglRUzqwGbPnmaYHN52s88zP7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709318; c=relaxed/simple;
	bh=l0PCUhBXASLDRPE0V1mUAP8XYiUY2TDG0y8AdPdT3hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5IaNQqD7tLVcW8V/1c+DuF9t9IKz4VyetBjCxZi63DIA3NVf8PEVxtmOSzCt0n6rrkK8xSA563EA9+ghTJpn5nQQpM7TKnBOKm5RQeRgpaZBaMXjkHcok1qjkndiTlRMGcdPzifvVjNN9nHhIpKRDz+BvtrsrcW3hW8YC8da0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X/1gEMZP; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso48582691fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741709314; x=1742314114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5rCPhsAPbcHexhTKW956Un6CdUeaMwNbF4Qw3OxTxc=;
        b=X/1gEMZPy2gj3MDGVOg+pGqde63nzvwid6ousqgiHOZwKJ4eZ0XP6C/yd7QtepWuNt
         2nlCT1Uo9os5q4za+MJKcS9/TKOp1P+ZIrpPmy0OtebrCFzyyFz7NdhaJHgU7Mlajz21
         Lxs918+ovmtjBchlttZpCedBvAozplp8j8T9zmWQcrsn36WqS1IJky/C/PLv7kCRJtLQ
         /kzxGGp02bgLOEyeUH/o6DL6aY3LGL09WrLuZ+LtpHU9X1v8R+OYfywrf2ruWE0EtXls
         ZGoQS34nq4rlfs51L8IG4vFVGJUba/4KEU06NLfsEdWrcKu/3j6twsXkaWJbWm6TXyAk
         CaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709314; x=1742314114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5rCPhsAPbcHexhTKW956Un6CdUeaMwNbF4Qw3OxTxc=;
        b=sZXKcOEaOsTT9tZ8tOLVCdXsL8I31DfFazlAkImH53YfBycHeXDJV1aBNfaDKih8Bo
         mLiqd/tB96AdB7aWduRTbtEc2VBter25qXKATIc7vBppLHI7dhi0s+GXWYQh98Jlfy2M
         fxhZS2awen1eeZ8n7gQqPYqAyX7Qvtf0uO24v8rNa5rLoQQIPe0hKVpSB/QGEBpEtjRv
         bwlOwI2C/lvkkymhcBUx7TLMtwa8mHe+N5NRxji2HaMZzjskJZ98RLpzJJQIJwamEX/L
         hqcpS5zXTU1Htyc7BSexW4Kj0vSiM62WgVIsLbFSCUcrwJoSi+CSOq4kU7w92kA0sdgv
         mx7w==
X-Forwarded-Encrypted: i=1; AJvYcCVdb1ut4XFxe5JHQcwdO/F8Pwfst7G8C7rclorQ6lxwmENueZDAUUan4ZRiKBXWB6VKRYpD51UFXypi9Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMbbWDMApxyUAXii1PUybl8goffe3Q8sMhmkbbeFBcjoNSZFA
	0r8e6OQB0ZHCqBRX5LJMSlpD9eD51USxBZDdC8X3L/G3z+S83KS07B44jBbnTHk=
X-Gm-Gg: ASbGncs+hh0+0PDl4XQXCenSjg4LU7q6J6QyjTRrBw3Jk9tJHhTVBIRf+RTkBf9oUbD
	+ifOnsoH115Hu5ZZTTu1mqIndyNugMym7hUrIQlA3ddeuDaorTFlzYmmQuGLoh9BIINiqNTqhVQ
	C98/BttWArAxwYpaNAaYffx0QrTRe4pee16chhpMnw165j026K2TFzrxch04P5BNWiSjqxWRgYB
	BZV9DBta2HMvo/ir6dB1JEYBJQwDQesdxC5dy3Mo6/1N0J4u09v9yrJFCDZUCrv/zecwuBz7Yuz
	m0Uoiix7vreKlqEXSlahQVnCqAK1bOrw2gfLQoC8TDMEKj0S3IYErIcoPpSf2eBa+/4N1MzVfAa
	VTGcV5J/A7ONpzdCHQN4=
X-Google-Smtp-Source: AGHT+IH6xH3iIw5WZ9UvcU1KhACB9sxLwodKE2eiTaozFPA2Kckvhc5eL9CtKwpWSsZqvDw73UKNyg==
X-Received: by 2002:a2e:95ce:0:b0:30b:b9e4:13b0 with SMTP id 38308e7fff4ca-30bf4518301mr57630211fa.12.1741709313621;
        Tue, 11 Mar 2025 09:08:33 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9918c54sm20761671fa.62.2025.03.11.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:08:33 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] PM: s2idle: Drop redundant locks when entering s2idle
Date: Tue, 11 Mar 2025 17:08:22 +0100
Message-ID: <20250311160827.1129643-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311160827.1129643-1-ulf.hansson@linaro.org>
References: <20250311160827.1129643-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calls to cpus_read_lock|unlock() protects us from getting CPUS
hotplugged, while entering suspend-to-idle. However, when s2idle_enter() is
called we should be far beyond the point when CPUs may be hotplugged.
Let's therefore simplify the code and drop the use of the lock.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
 - Added a comment in the code.

---
 kernel/power/suspend.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 09f8397bae15..90fb06ca07d2 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -91,6 +91,8 @@ static void s2idle_enter(void)
 {
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
 
+	/* CPUs can't be hotplugged here so let's not protect for it. */
+
 	raw_spin_lock_irq(&s2idle_lock);
 	if (pm_wakeup_pending())
 		goto out;
@@ -98,8 +100,6 @@ static void s2idle_enter(void)
 	s2idle_state = S2IDLE_STATE_ENTER;
 	raw_spin_unlock_irq(&s2idle_lock);
 
-	cpus_read_lock();
-
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
 	/* Make the current CPU wait so it can enter the idle loop too. */
@@ -112,8 +112,6 @@ static void s2idle_enter(void)
 	 */
 	wake_up_all_idle_cpus();
 
-	cpus_read_unlock();
-
 	raw_spin_lock_irq(&s2idle_lock);
 
  out:
-- 
2.43.0


