Return-Path: <linux-kernel+bounces-542116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60018A4C5D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3CD1892B3B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB7321578D;
	Mon,  3 Mar 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqQt3ceY"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3849215048
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017304; cv=none; b=ERIPaCkdMYvaQpicY5rzctR0F+NF3skvPM/c63Zkuu55OZDtKt18axc8d0KSmRZiaYH+miQcyUPJoQun5lBRl9WsydBXVlWsL6B/bncmen1PD+1WTyyZJ9Lb9IzJd/3H7xgKcBMmdIE1B1RLC0k9FV8IcF0Dmx/jPXecgK2nzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017304; c=relaxed/simple;
	bh=I0meQ2OzTW9SsLY9Bpn/gBM4gxUcsCHxtyk7vJv7imQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+ss8Q+gt+By/LPvRL3+1SVd14ejHrghjgDGpZo5PIAY/jaXs9odphkMCMUCCzDTFFsDJcBpkgH08ugEbWSFezA5V5LXH+g39KP+ij2Ue/Bm3gEIlxWqTyeudQ9YFjADjlMLBFkUao6ZcXMA40J7BcQ5Ptzl9G5gdURw+7VKLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqQt3ceY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb37dso2082333a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741017301; x=1741622101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOrMXNYmOokUmaRVc2NxBdXMyKzVfUwM81fMAG8xe60=;
        b=dqQt3ceY/sFPtA0NzbAzYs0IN5CVH9VXRyw8jpUsPcjg/YfGLSAIQ/t51pnvTVjn0H
         yGunZ5UNXuawKQqZvQdfjTJOeDr+nruzIy6p4qwjZz29RYwXm766w8PPAgFVtDSegvec
         Mmb6FRW6gATlCSaNsMgLg+OffwtMQXfZY8iNuiZfaXW69AeUgrLY1eImrCRtV4lUVdNE
         sYE6BEguOQjxgwJB5PqHc8XQ2X1fjBGgruXR4BSAL8G312ILxrl2kKuKRyKojokD2vkO
         onc4oZrprEpcCPPmLBBnNp1VE4JED6SIZQx01D1+Mn8GoUkV8jQ61wqYjzXloahNne1Y
         weuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017301; x=1741622101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOrMXNYmOokUmaRVc2NxBdXMyKzVfUwM81fMAG8xe60=;
        b=RVNLr6ZgHAfgsXcMiir9WzMMchk1QKA4oTS7wIQoVXdJ4PyaXWK9dWd2Pcdsg7iZG1
         N47YjDarru/E5BWOKCQiA3o+/GeoUAT9SSkXTPQ6wF6sEO4CNBwR0kFfxAf9UFqctI5l
         xHxIl0eh+b6DBvUq0/MfT7hB1NsgEiCYLWO22A0dTcLx1LP/xVoZDHq2Uj723ZrLlH0G
         6qLtdgoP8rrGGfG64rV5RndhcLI3NOrKWqMxlc2I4eWRvKgiJk2qIbtitSjEAd/1gpBJ
         KY5s0UsDTyIsBYr7/MdPdUJBeQyk4hpDlOK4EAJvVSGP1U/eC5w3dcizK5elfPnQ/+bc
         ZSTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8EaLHiwcdEgG5Z3hrqvhuLh9uUeGJ+Jb357YuQiA97oqRRiiUnX+BhKLD5jRPw4+hR4OMMeCsq7qDIO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBb4iFoKX83MpeK7S4Bm1mn0FoTLU+czg9ntXj/jtHulnIeN+m
	ODf4hQmDvLsKDCTQ1qg5UAT2CFQNLMex6Ugw5B4QGRqnvQlVZIxg
X-Gm-Gg: ASbGncuQ9bw1OslvrZjPilv9shkoSeOwLcCxJ3QxrH+s7NjW5djGfKnDP+O3nIPeha4
	5nPMYPT8AA9Wk51KcaJN1vnG/qtIoXTA1jFZ05Fp6hVjXMq+TDYbNTKP00lxxNAmk4eW2KBEU5K
	6MFYOpHrbiO1SBiIMaPzPX4jgJno2FpmJz8GmEj/lXdO0c9oVq4ofDPr3nck/RkmzbVUcYYS8Hj
	oZ/PoT+Zu2Xhxov2+OClGVHKn0mcRTpJ3d09/aJVQ2w2wm7Gi02orLi115LC+ggVTQ4uD4AK0lZ
	grwZ/txtjZb5+o4/fpZscQHdqopolW6IOntuGov3RGHGEvqmTXnuRw==
X-Google-Smtp-Source: AGHT+IG34tbJjUBevodhILA1PDcxVwXgZy43/WkbHfPkYZzI5UEVDw6MCdoPVuVRI0mlv05kPq5+Pw==
X-Received: by 2002:a17:907:3f18:b0:ac1:d97e:3e4d with SMTP id a640c23a62f3a-ac1d97e4894mr315802566b.33.1741017300917;
        Mon, 03 Mar 2025 07:55:00 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf6c405547sm305699466b.110.2025.03.03.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:55:00 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 5/5] x86/irq/32: Change some static functions to bool
Date: Mon,  3 Mar 2025 16:54:25 +0100
Message-ID: <20250303155446.112769-5-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250303155446.112769-1-ubizjak@gmail.com>
References: <20250303155446.112769-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return values of some functions are of boolean type. Change the
type of these function to bool and adjust their return values.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/irq_32.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index 2428d661faaf..566a93ddf418 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -29,7 +29,7 @@
 int sysctl_panic_on_stackoverflow __read_mostly;
 
 /* Debugging check for stack overflow: is there less than 1KB free? */
-static int check_stack_overflow(void)
+static bool check_stack_overflow(void)
 {
 	unsigned long sp = current_stack_pointer & (THREAD_SIZE - 1);
 
@@ -45,7 +45,7 @@ static void print_stack_overflow(void)
 }
 
 #else
-static inline int check_stack_overflow(void) { return 0; }
+static inline bool check_stack_overflow(void) { return false; }
 static inline void print_stack_overflow(void) { }
 #endif
 
@@ -65,7 +65,7 @@ static inline void *current_stack(void)
 	return (void *)(current_stack_pointer & ~(THREAD_SIZE - 1));
 }
 
-static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
+static inline bool execute_on_irq_stack(bool overflow, struct irq_desc *desc)
 {
 	struct irq_stack *curstk, *irqstk;
 	u32 *isp, *prev_esp;
@@ -80,7 +80,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 	 * current stack (which is the irq stack already after all)
 	 */
 	if (unlikely(curstk == irqstk))
-		return 0;
+		return false;
 
 	isp = (u32 *) ((char *)irqstk + sizeof(*irqstk));
 
@@ -98,7 +98,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 		     : [thunk_target] "D" (desc->handle_irq)
 		       COMMA(ASM_CALL_CONSTRAINT)
 		     : "memory", "cc", "edx", "ecx");
-	return 1;
+	return true;
 }
 
 /*
@@ -147,7 +147,7 @@ void do_softirq_own_stack(void)
 
 void __handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 {
-	int overflow = check_stack_overflow();
+	bool overflow = check_stack_overflow();
 
 	if (user_mode(regs) || !execute_on_irq_stack(overflow, desc)) {
 		if (unlikely(overflow))
-- 
2.42.0


