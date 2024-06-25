Return-Path: <linux-kernel+bounces-228752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF82916666
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F421F21EED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F93514C58A;
	Tue, 25 Jun 2024 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIqyfbPi"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F169154C0B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315792; cv=none; b=NjiDKecn90DOoVWbMixeQDy9pIWcEt+9OZtfEa74I5EC/z4NyGrTi8E3em7yr5Mm5nedGBX7BvIZjtzD8rx5N/Tnz5OzjCRqvraP9XZoJIJ+b87OHEUdkQejJZNHbNPtXMPknuj9dc3dXTNUt/RNwrXJwOKgvT+hA5J1gglcNug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315792; c=relaxed/simple;
	bh=8Jm80H9s7uZvf0aStKpkpcr3QFdofRB/PMI2VKaBG6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjLwKUAtlXvtICW+vjzwb7iqXorgN0vx+5ZujAMWh2Y4Edx9vS12qM/+pcna4L3iXJeBGUy22Gd+EJpqfuGfAv5o8YpXDfw2t/gp96gIznTBbIukLpwt8PBP6GQ8wRaTxn9+mY6oSts7ReEPo+1a0T/6v9f49tr/EVR0HSIT8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIqyfbPi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9a78c6c5dso42420875ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719315791; x=1719920591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jAq3V/NXt3fqcoe01ie/fhuO4SjwfZtkMJYxOwmCAQ=;
        b=UIqyfbPic+ar8xI0PjqY8y7fHRBwW2HQd+inIVDJKi6rnPmHxBfRd+O1wDRZeitpQX
         AZaYA2zFQmEbryYocSXYHLMfSIBLJMoVUk9yG8VoHeDvwZA2inRYNS2PGhvYJtYoQrcM
         XoGSSOAS5R9m1QTykgGvmp48oCyNoG3g6Tj2F6JrfHzlLhZU/+0j0gvpBN7tKDSJINsX
         IPpUV3u1DYsj3dFNimV93vFWPcZBT6e4c4ctf55MK0n/M8ZQWDgCOqwvDlk9sxLr8hY4
         JsI1pRdOMp36cyRTCB1vLNbUloFwxN3FxLie540b3UmuIhq2nSWtXh4rcbIm8ZizsXrq
         yZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719315791; x=1719920591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jAq3V/NXt3fqcoe01ie/fhuO4SjwfZtkMJYxOwmCAQ=;
        b=ahI5TEJzSxpunPbtYy83wQAU/D1k5CPYAqoDhiQbEmekRfZVHLYbwedXbqNZHgz2Xr
         JlwxloWqPpfNQRZ/YEOUG4aCCsZt8mXF6WPYy7zai0fUtBElfqcAfPT/4+UA5naX0IH7
         39nxSiQQd51dZK0hpD0QKvGnwzbN/mEN+ow1oVRmLNtqHJ7sEXuVE+BccgisZBGQqFMj
         3xwCrStS+1FY5/gUlcr6YDgVsyDRkqcjg4FQ7StOZRjjY4h6aljTa0/53pVUgbhrrTSx
         TWI1vIpBFWBujT5DR1ADoaGlCc1XEWmAoq820jVfy5Wrjbg6BAv7Ioi2axlobdZtpHnB
         qVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlWaqk5NO5iGKuO+3bBjekOxMC1ijNTbsTzHsKyBoeJYNMXUQ1Gg/WUetZsmWPScC/L1kKblF1+yFOOkiPVEEotBHXEpB7xVQ1zwFg
X-Gm-Message-State: AOJu0YyvL/bSrHv7l5cu0BcAphEiEqyObYcg+kD6T81aMvRpgEv4pXHR
	SoejM++V5JDZr0Phxf+pcQNX8E8zadYxD+iuI8oEV/UyC5lKMrtC7Ud87w==
X-Google-Smtp-Source: AGHT+IHxZMQADaFGMjDTm1G/i5o+tMd1MNmvFxW8cw/GgcrXFR3zRCAR1ET79n+sE9rkQ/isbP4OyQ==
X-Received: by 2002:a17:902:ce90:b0:1fa:1d7b:c21b with SMTP id d9443c01a7336-1fa23edefcemr84621615ad.31.1719315790825;
        Tue, 25 Jun 2024 04:43:10 -0700 (PDT)
Received: from wheely.local0.net (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f028asm79638525ad.3.2024.06.25.04.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 04:43:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] stop_machine: Rearrange multi_cpu_stop state machine loop
Date: Tue, 25 Jun 2024 21:42:46 +1000
Message-ID: <20240625114249.289014-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625114249.289014-1-npiggin@gmail.com>
References: <20240625114249.289014-1-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More clearly separate the state-machine progress case from the
non-progress case.

Move stop_machine_yield() and rcu_momentary_dyntick_idle() calls
to the non-progress case like touch_nmi_watchdog(), rather than
always calling them, since there is no reason to yield or touch
watchdogs if the state machine progressed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/stop_machine.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a..1e5c4702e36c 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -225,8 +225,6 @@ static int multi_cpu_stop(void *data)
 
 	/* Simple state machine */
 	do {
-		/* Chill out and ensure we re-read multi_stop_state. */
-		stop_machine_yield(cpumask);
 		newstate = READ_ONCE(msdata->state);
 		if (newstate != curstate) {
 			curstate = newstate;
@@ -243,15 +241,22 @@ static int multi_cpu_stop(void *data)
 				break;
 			}
 			ack_state(msdata);
-		} else if (curstate > MULTI_STOP_PREPARE) {
-			/*
-			 * At this stage all other CPUs we depend on must spin
-			 * in the same loop. Any reason for hard-lockup should
-			 * be detected and reported on their side.
-			 */
-			touch_nmi_watchdog();
+
+		} else {
+			/* No state change, chill out */
+			stop_machine_yield(cpumask);
+			if (curstate > MULTI_STOP_PREPARE) {
+				/*
+				 * At this stage all other CPUs we depend on
+				 * must spin in the same loop. Any reason for
+				 * hard-lockup should be detected and reported
+				 * on their side.
+				 */
+				touch_nmi_watchdog();
+			}
+			rcu_momentary_dyntick_idle();
 		}
-		rcu_momentary_dyntick_idle();
+
 	} while (curstate != MULTI_STOP_EXIT);
 
 	local_irq_restore(flags);
-- 
2.45.1


