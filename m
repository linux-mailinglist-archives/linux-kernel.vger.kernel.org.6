Return-Path: <linux-kernel+bounces-556478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E397FA5CA58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE3E7A62E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012EB26036D;
	Tue, 11 Mar 2025 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTbbffLr"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6611B25FA14
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709319; cv=none; b=Wqg2sJRp6Trd7St6VhuSgBXDxBMmtGGYZW6nEiWf61aaIaSLIm50YkpWS0E2xjRjdW5oidA/6UE9aXRT5TdRE3Cv5a9RfLd/JDLdXH1lE63MicOsQvT7M9FmUL6RbuKlvNn+4ty9JhGGzP0Xo0YOHU+cnb3rF9BiY2pLSN55Kp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709319; c=relaxed/simple;
	bh=0JyQVQNXAvmJ1/n8UxRyRWsOn+wf5nWtMrbcEr1qgqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPzR1TzD+StDYv7nEOrIs4XQ2evtksu9mAEyfnE72VURYH2dDFSCdliYLLj0VqFUnnhKqsnpDeCQt/oy98MVsn9K16vmZla9aDPPyF0xC+lWiUPRtTL3nEnpuVDMnckknOUEaFgbgxbBgGGIZnfGxN+c3/6H+ice7WZQkOHbhzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hTbbffLr; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30613802a6bso61271141fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741709315; x=1742314115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcjlvQ20Z+LP3Azhfy6nFMLexKDv2Y/3x8IawyIsoTw=;
        b=hTbbffLrkgs8aWE0ihiJgubeavcGhEQG6xM/foE2BNKjgqINpGUMGbOOqm8crtsKFU
         XVES0G8uZ99YcU3NYYD7YCN6XjCBLHb6qyBkR9wvQC3UcMp2m4jNrSoHaJm+hnbrbaRf
         WFmH2La8YZe+zMSQgaK7WHL52wS4lbLk2PwEf+Tww33CUtTm9Uy+4EG8nGN4MULxrdHh
         IpiE65qmMQIUJPcCLQMtbYuFTN5Oty5XUrdNFH31AnLfkQ6I/K1I7TMX6JSTWshiHqV7
         7SeNq06JmQXDjQ7siQwXvd8DFt+4QxG6jgjaAFKNCNsGaw4DLRQCu9FllDvHO1Z0d8gj
         86lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709315; x=1742314115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcjlvQ20Z+LP3Azhfy6nFMLexKDv2Y/3x8IawyIsoTw=;
        b=LTMSt5ofbTgOJmbngOcLKGqXfoSFMqPniJ3C41QQtBdtjatCnGeqB0HAKHXZEBQ6sd
         hxGz2bu1DWW9YQ7tK3HTMx+ziNe3Xhi6YTIio5ExoWhzMJmN935B4yZfryUOqTexbdsA
         HYCDUd+D90kkG29Q7UC3pX49LksSJYD1JocRwsS2Q6iDr76Tuc009YkZyw7CnwhogL8a
         C7ebjroadi1oIrfBuoc5uVCg0qmh/onGzeHko5eKtdf+08yOHpL2GRZfk0H9MrwsWzAb
         4o8UXHu3Q4jn9E3/3WQfTs0Zyx9RrmCezQXmE20khJe8Z9UX8SEbrqUbvefM/ReWvg0g
         o2Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWoWlvKnPeQ7n98KBc3KLflfD1J0eIoH7brMfqXNofl7rJLQXqK3dfaN1HrlQUfboc/N7Uwf+X28wRme+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqO3XDdCHjKUudIwsAEvu3Qiw2lZ5cvkj6NskbkG06nuiSM2K
	OgLKK/MuueIpLegjuv40burXuuIfJykMhm5eUG8P3TNoJlchcUUooW/ctHu1Tbs=
X-Gm-Gg: ASbGncuSxXoG5lMM+e1rEKt3b5jJosknd8FHB+Xq4TVhluMkOzSc0oPsD1NTiv4Dy+2
	W0i1BwvBFMT0fesZlf4Uessy7ussUQ9KS28CPIZg9kY8u4enBMeImgOPtYne2iFgPRqOSS2KCDr
	PDiE6g2/+/5yiGX5807ljm/iyfUc253gQhn7GoefXDlNt2E6zGp7GPnhtQftEQv1LkxifTaICRd
	QnJHgA58bxH2PNCOrdah7nnpQn8RABtFZMJz8pXANjxf7aA8tetAV2suYFwGoTI60mxjKAYaaWS
	NCE9ZvOfz88x7PFMQz58Xxxaq3+cChbUIYoXq1J1k/ARnZ6Ax0Ah/fYn+TzkdcCoQ1ZRBCZqiyn
	y4Ve8qDNdvUHHJe1Men0=
X-Google-Smtp-Source: AGHT+IHqEinybzI7v0pVnETj2v5LwyPFnNPlZDH83XrlF6Z5frt4mvnADmS29mGe3LSIyUVtpKjvJA==
X-Received: by 2002:a2e:a9a7:0:b0:30b:cef8:de87 with SMTP id 38308e7fff4ca-30bf44fa059mr66552361fa.4.1741709315430;
        Tue, 11 Mar 2025 09:08:35 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9918c54sm20761671fa.62.2025.03.11.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:08:34 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] PM: s2idle: Extend comment in s2idle_enter()
Date: Tue, 11 Mar 2025 17:08:23 +0100
Message-ID: <20250311160827.1129643-3-ulf.hansson@linaro.org>
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

The s2idle_lock must be held while checking for a pending wakeup and while
moving into S2IDLE_STATE_ENTER, to make sure a wakeup doesn't get lost.
Let's extend the comment in the code to make this clear.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
 - New patch. Suggested by Rafael.

---
 kernel/power/suspend.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 90fb06ca07d2..b7aa1db278ff 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -91,8 +91,12 @@ static void s2idle_enter(void)
 {
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
 
-	/* CPUs can't be hotplugged here so let's not protect for it. */
-
+	/*
+	 * The s2idle_lock must be held while checking for a pending wakeup and
+	 * while moving into S2IDLE_STATE_ENTER, to make sure a wakeup doesn't
+	 * get lost. Note also that CPUs can't be hotplugged here so let's not
+	 * protect for it.
+	 */
 	raw_spin_lock_irq(&s2idle_lock);
 	if (pm_wakeup_pending())
 		goto out;
-- 
2.43.0


