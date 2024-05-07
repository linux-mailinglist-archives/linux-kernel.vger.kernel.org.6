Return-Path: <linux-kernel+bounces-170650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9CB8BDA34
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9260DB2278E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A55465C;
	Tue,  7 May 2024 04:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="dfqDoKgA"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546981849
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 04:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715056455; cv=none; b=lzjfPC+1tQX5jVeOWN2IZpMYJ7VIxqAwGJ/y4w5jSOP2UqFLBPEc3rsM4dif7EumC4JlX/T5L9zv9mVnkXbPxzepVtEHAIxM8XdfxBQYThrfl1vDlaX/tqelqq8C5JXRD8usgaI+Q2bNXfirCtY4ab/eGUaf40c7hyRtn0Xga20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715056455; c=relaxed/simple;
	bh=VoLUIrz/OU6msMrgeqVOJYoI9HwcHFS/vVFRyCpgzQA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mma+bzr2dbA82rug4RMexfW6ebmf33QIJF8uywbRfpuXF+0QhXv12x8lckr2MyLgmrjxGidvI6KBm6lGUfEqYMObhf3zuw5LsCrdoHK4h1NNbGQ2EUk3UngOvSEN0V/ZI/Bp3cXkvVqqK4FOB7QHToX2PfeaCEG1b83HNNZSXK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dfqDoKgA; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7e18170ca14so39457839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 21:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715056453; x=1715661253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L+ig3H9HcjFVWhM4GpWFctrqstrntznWN1owqzDtN7o=;
        b=dfqDoKgAa1K4rb2rt+oMOuK3l9n9QoqAfcsq4d0dXMy3D6ecMfmj+WY2Iq4Rz7pDA0
         WvwJwQhhIAfLO/672Vwk4liEZsdo7GI3ywWLo+XYNCkFmP6g+a/qrfzkSg3SnT/loTI8
         iQLcQgNENdyRSTNmk2zlNB5/172ggPCGTMpvVXTzPK62xIgauS8KpbuYGWlXH8qt2D+8
         yM2R6/1tOjM4FxjdyiuTuJ3baXY3/3TbdEjszLVFnLPevv3ng8kTQMM0CTkeUrkclyK9
         ENiVcb8zrp+tyvEatx1+yvRWuGHCm78xVTgEAfEX2rfAE2tcv3hrgW0Ow1y2ohWKjVA9
         QTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715056453; x=1715661253;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+ig3H9HcjFVWhM4GpWFctrqstrntznWN1owqzDtN7o=;
        b=qECzAB1hPxCRL57sgmecdHv9B7NS1pbGD3BixE0ZnHSsRKoIX4hvZi1Zky9VuyXN09
         /jEjUk7gVJ3Rv6NrLuJZLdtCYnY8KEVCOMWXEm6NGdGfcn8KOJDCIKHBH8QI4eXy//G+
         u/d/hyP8pxH/nbZ34jW8RY2gJpp1JH6RKW9ltsXUVr08B/YT08f+cSU1JYEkCNB4CKvb
         xzGJ7tEZ4vv+MEAK3h7UUsNu6tgZaj1ONDkqYq2Zxiks+67T6HRuXPSLz03JkD/OYxBk
         YPOGmH8J8moGiHKq0ZFjIzlcXOsKfGtw5uc8QAHxLXoAewGv5Wj8KqqwgOBq1xqqrFRW
         tagQ==
X-Gm-Message-State: AOJu0Yy4iurOTgGAHhRkQBf6BuBIpvXFb0CL7FIb4OICwbU71AQZObSa
	o+IwDeSI5k1fiAx6fwkVo9NiJdptQIfpRNlwQja6GWTTTOSrqwyKSwbsL/QUBpplv+MwzUVDO7/
	i3wYDpyS/B0DgJry2/bc2fA==
X-Google-Smtp-Source: AGHT+IGTILHjt43TXCxmtYxcfmS+4MJev84ovtenP1+KQDd/DVDEtEeUQDg3yhroMHs6a9dHyrDWNkWaDI7ujZB31A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:4c85:b0:488:59cc:eb42 with
 SMTP id do5-20020a0566384c8500b0048859cceb42mr378207jab.3.1715056453627; Mon,
 06 May 2024 21:34:13 -0700 (PDT)
Date: Tue, 07 May 2024 04:34:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAESvOWYC/x2MQQqAIBAAvxJ7bkHLEvpKdFDbai8mWhGIf086D
 sxMhkSRKcHUZIj0cOLTV5BtA+4wfifktTJ0olNiEBqtwuqgvwLeiRxK0xs7ars6klCrEGnj9z/ OSykfpVeGvmEAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715056452; l=3068;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=VoLUIrz/OU6msMrgeqVOJYoI9HwcHFS/vVFRyCpgzQA=; b=H9gQ5PFH0w23ZB7xRv9INspYuKzIhVH014LQHjdeRlKZw/sFAHK0God3LCBXOJwShjxnVIZ4K
 uAen7JztfIyB7uoeFaR18jV7cx8FJGVE/vhjSfsSgKurk0StUR1Unf3
X-Mailer: b4 0.12.3
Message-ID: <20240507-b4-sio-ntp-usec-v1-1-15003fc9c2b4@google.com>
Subject: [PATCH] ntp: remove accidental integer wrap-around
From: Justin Stitt <justinstitt@google.com>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Using syzkaller alongside the newly reintroduced signed integer overflow
sanitizer spits out this report:

[  138.454979] ------------[ cut here ]------------
[  138.458089] UBSAN: signed-integer-overflow in ../kernel/time/ntp.c:461:16
[  138.462134] 9223372036854775807 + 500 cannot be represented in type 'long'
[  138.466234] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc2-00038-gc0a509640e93-dirty #10
[  138.471498] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  138.477110] Call Trace:
[  138.478657]  <IRQ>
[  138.479964]  dump_stack_lvl+0x93/0xd0
[  138.482276]  handle_overflow+0x171/0x1b0
[  138.484699]  second_overflow+0x2d6/0x500
[  138.487133]  accumulate_nsecs_to_secs+0x60/0x160
[  138.489931]  timekeeping_advance+0x1fe/0x890
[  138.492535]  update_wall_time+0x10/0x30
..

Historically, the signed integer overflow sanitizer did not work in the
kernel due to its interaction with `-fwrapv` but this has since been
changed [1] in the newest version of Clang. It was re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Let's introduce a new macro and use that against NTP_PHASE_LIMIT to
properly limit the max size of time_maxerror without overflowing during
the check itself.

Link: https://github.com/llvm/llvm-project/pull/82432 [1]
Closes: https://github.com/KSPP/linux/issues/354
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 include/linux/timex.h | 1 +
 kernel/time/ntp.c     | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/timex.h b/include/linux/timex.h
index 3871b06bd302..976490a06915 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -138,6 +138,7 @@ unsigned long random_get_entropy_fallback(void);
 #define MINSEC 256		/* min interval between updates (s) */
 #define MAXSEC 2048		/* max interval between updates (s) */
 #define NTP_PHASE_LIMIT ((MAXPHASE / NSEC_PER_USEC) << 5) /* beyond max. dispersion */
+#define NTP_MAXFREQ_USEC (MAXFREQ / NSEC_PER_USEC) /* scaled to microseconds */
 
 /*
  * kernel variables
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 406dccb79c2b..19027b6d0827 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -454,12 +454,12 @@ int second_overflow(time64_t secs)
 	}
 
 
-	/* Bump the maxerror field */
-	time_maxerror += MAXFREQ / NSEC_PER_USEC;
-	if (time_maxerror > NTP_PHASE_LIMIT) {
+	/* Bump the maxerror field, making sure not to exceed NTP_PHASE_LIMIT */
+	if (NTP_PHASE_LIMIT - NTP_MAXFREQ_USEC < time_maxerror) {
 		time_maxerror = NTP_PHASE_LIMIT;
 		time_status |= STA_UNSYNC;
-	}
+	} else
+		time_maxerror += NTP_MAXFREQ_USEC;
 
 	/* Compute the phase adjustment for the next second */
 	tick_length	 = tick_length_base;

---
base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
change-id: 20240507-b4-sio-ntp-usec-1a3ab67bdce1

Best regards,
--
Justin Stitt <justinstitt@google.com>


