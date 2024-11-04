Return-Path: <linux-kernel+bounces-395191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066F09BBA28
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BD61C233CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006561C4A0D;
	Mon,  4 Nov 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sd4wqmLV"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7C41C3301
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737170; cv=none; b=kpzN10jOVcVCWYBCNjK2ptSesgrcdYIlWVGFEtuMnSnDebsuk9VsvzV2YKaaVL3IfCP00hjULJ4Y2S68sd+ffu8FZumvMVd4jZrPI9mj633iVPxeHOYf3uAifrPhoweH8Mb06DJy+mzFrdS5dwTl7Ye3M1IQwQkQUd5/13BLe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737170; c=relaxed/simple;
	bh=lUc5TertTv6v/DNguptt7P2xUp+ooVpcLKkDyjzxF5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bLLdGruKZVKNZ+R+gj3X++UoF0drouHEUB0WeZFwlNTCrQIy6uIs9Cap6ED2+3d01/251gSGKw1o2AdyCHaDBQM4YIg1tfzAST1eUU093Ypi7rnDLwFHnfpi/D7YZjVL1HG9Aghw5qSNz67J6k/L8ryF8JRwobqmQLhQ6XVpwnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sd4wqmLV; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37d609ef9f7so2286830f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730737166; x=1731341966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9zIGQ63tMUKGGfo5aLFc1OFxRhvBbjK0JxcXzvrQ2E=;
        b=Sd4wqmLVaX/Xglj1JO7x6cawt9hiVRm50+PsxRNYH977iwa3bkxMssSjB3g1/w3iKV
         3c2aVbh/Z3JJRrM1WkSLi4My5/etysSQY1ZixbjpHXZ14QYwjdbLnQRs2NKpZkzalyTw
         zz0RqxraR7Vh/jMoG7bhZTSOUQQDpX75x+vtIZvXJVNvc6NR7/NuKg+q1KCyQiaZVJSd
         wMbCKDRVdIlRbJkgFz+XxQGnK74sl+My18GXiWJwFl60RNIiyGSNDy3Etk3dD4ex0ZFI
         2IM9yxOE+DpCNujiurpq1XD23o/UYyQGmi0Mhik5tDcgdKdmEq1LQYACJ+5kT1uX2LdD
         j3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737166; x=1731341966;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9zIGQ63tMUKGGfo5aLFc1OFxRhvBbjK0JxcXzvrQ2E=;
        b=wsfqYeXuHCDLSNKPQVXAYju1mr+e6iyYJqsIqerjImq+qDN3IfKaLlZ0QGKi7Xrk+s
         pukoA+cAsGqRjhXq4WMK82Ug+6CXTMewFtUUYBiWQLY+kVgyJHnNDoJ/QIzhtYdFuhZN
         BJAp6LJDKOrirWdhdej4RXwoMsVRp4H9s+oRchsy64hZydLaVEppFO+HXlQ3kKIVfkOG
         bZZ0bXR0wlWwQUPJoH08L2NQzPx257gWiuIj98Z6fApqxc5w1cP7PeQsaNN5giZ6xeqT
         AU3vbIystWY1Mypbrla4+ioaigcswBmIudn+rgo/cJGTiyvxodsUfcwvvDpTBScWre8D
         qcmA==
X-Forwarded-Encrypted: i=1; AJvYcCWTMpPzsvzdwqxyIBt093OL0P3ayreb5RIDf0si6KChUYa3VtbzxDnNC1P4Z3BL89d6VGJN1isr0MbHFv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjEbgdys2oBAl0BBVqCRZLT1DzgJG3YNkPdCTFQFNBCcaKMiEF
	Pp+IZaEv+3NDowgQItAlpK95i03HNwYCfNXwq5CucYHOD9suVN3TFqj1oW1HYfN250NgaJOIsw=
	=
X-Google-Smtp-Source: AGHT+IHS0+6h/UBLulc4DyiTN6UHNskaVEbiMgEJ6V0E0xUDQO9SGhU+3nV/ZEnM+3FaKpvsFAFewAG/VQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:dc4d:3b27:d746:73ee])
 (user=elver job=sendgmr) by 2002:a5d:44d0:0:b0:37e:d5a2:b104 with SMTP id
 ffacd0b85a97d-381be7cf9ecmr7013f8f.6.1730737165815; Mon, 04 Nov 2024 08:19:25
 -0800 (PST)
Date: Mon,  4 Nov 2024 16:43:05 +0100
In-Reply-To: <20241104161910.780003-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104161910.780003-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104161910.780003-2-elver@google.com>
Subject: [PATCH v2 1/5] time/sched_clock: Swap update_clock_read_data() latch writes
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Swap the writes to the odd and even copies to make the writer critical
section look like all other seqcount_latch writers.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 kernel/time/sched_clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 68d6c1190ac7..85595fcf6aa2 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -119,9 +119,6 @@ unsigned long long notrace sched_clock(void)
  */
 static void update_clock_read_data(struct clock_read_data *rd)
 {
-	/* update the backup (odd) copy with the new data */
-	cd.read_data[1] = *rd;
-
 	/* steer readers towards the odd copy */
 	raw_write_seqcount_latch(&cd.seq);
 
@@ -130,6 +127,9 @@ static void update_clock_read_data(struct clock_read_data *rd)
 
 	/* switch readers back to the even copy */
 	raw_write_seqcount_latch(&cd.seq);
+
+	/* update the backup (odd) copy with the new data */
+	cd.read_data[1] = *rd;
 }
 
 /*
-- 
2.47.0.163.g1226f6d8fa-goog


