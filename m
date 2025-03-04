Return-Path: <linux-kernel+bounces-543660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E7A4D845
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424F816F5CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0751FDA8C;
	Tue,  4 Mar 2025 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qW8kpVch"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597B200BA1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080345; cv=none; b=AFO2RfSjtRC1JloIpLbbg5m2W+wCq+e3uI5TL6Uy+BYtv8I9aXV8JlX98wrV/U/gPqjBX8X50AiSeNYf2iwOZNr6vmuMkF9XMvROu9GKygoD1uAOr1cA0Hg2UtJbtiVkV8gkwt3SBiGfyNerogzRCIjI1Fkm6J/R7V7LdUk7Sas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080345; c=relaxed/simple;
	bh=A7gPHEZIEQYCG49NjQ38GqM0IYCU29sZ4kgbaVoDh5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KxnQW6BXQsvODzgknsKKs8KpPlqpadnNBFjOEO5KcbfjG92O08tFotN4IoySubB7im8KSp32kEq36IXhAcr0I7RXLzZz1Kq8TqGPSVgMnrh17HO/QY2BdXCIZ85oVvoAsQ8znMd+I3expc9JUIxUvivUkLOqCYTotMlYN91CGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qW8kpVch; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e54bade36dso2167823a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080341; x=1741685141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NsOo3OXCYTu9WQHyv5ORZtwu1IzgjlVv8TtoKqxnnY=;
        b=qW8kpVch/2lef4718yfMZbrKvq8oqvrMJ1Zs8wJZ3cysiWvrEDmP2vqWHjc0bO3sEf
         IqbhcoBfsyEN9LnXVnKlu2nf89pRJmfEvIbKLV14FhpeqBu/R4TWhXY9jTyqasrhiI8A
         OcMvg+rE/VYrVYqgDnK0cDqO3tbiyHDA5y2FMzHTuaA73KEoNBYqD9zZqVaZNS8up7D7
         kNcAbm0h3mTS5eIbs6nb/v2cela2VnQXqwYlr08LEfsgz+FeSbuNmJ4p/U9PazsM6+xd
         o0m21zGV8/LL7CB4DlomPWCcjBxU6mQhI8QY9PQTR8M6FIF08dZVjgwyikEtSicg0MO1
         XNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080341; x=1741685141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NsOo3OXCYTu9WQHyv5ORZtwu1IzgjlVv8TtoKqxnnY=;
        b=Gs6XsXbE8czCTmZ+mqHqbTwgjws0WvfOzPVaAVQC2fXu/0E47hxZrYSgAGUh7DuMQH
         gGhebtaxUp51A57HtJPXucGarbw75+dQ1b8kEerjb0FYcwNmNHb3+v98HAGOe7JFqpv/
         jkv1Zsr5sh1WD1sQpt+3wC9g2wqsoxfD/35twGqQnBf/NXG7tJ4PreSTfM3CL4vG9pMm
         66Oe3ARTDBZlXdja6tr077aQ5x1b5UXXVjsUFupdGKimZe6ErwHtPzYcmmKRn5lxvQSc
         OHXVJNr19By5eWG3eJrN8PgFx4cKV9RUNEYO2M6YoW4xNmSTqFOoZIRpQFltgPJI5mwt
         zr+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFqWmLHfsS/4ZCXUIDJ1lcSLNillVMu2KGhFySpJe1JalO7JRSpYiAt/nxbAzTE/fnwwLn3uNTWm1s5G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHi59BA+43gIg4zdGz5cdM1v4Lq+oRUJ+oNwgWreHNI7/8gM/
	/NckZ8miSGTwqaWVZQfq4yOelLWqYuDOTuXXGsyCLAOjJqhV6KXtyb8DXU/hmYTMRgduGqhJWw=
	=
X-Google-Smtp-Source: AGHT+IGvHnVCTmDxfH/8wK0cbMQMdd2+QC7Cg7+dh1AXOrq291KoSLxad8RL5shMmiF0TMtX3LbCMTR8+g==
X-Received: from ejctb11.prod.google.com ([2002:a17:907:8b8b:b0:abf:60e8:559])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:43c6:b0:5e0:7ff3:20c
 with SMTP id 4fb4d7f45d1cf-5e4d6b0cb67mr18149547a12.17.1741080341679; Tue, 04
 Mar 2025 01:25:41 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:11 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-13-elver@google.com>
Subject: [PATCH v2 12/34] bit_spinlock: Include missing <asm/processor.h>
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Including <linux/bit_spinlock.h> into an empty TU will result in the
compiler complaining:

./include/linux/bit_spinlock.h:34:4: error: call to undeclared function 'cpu_relax'; <...>
   34 |                         cpu_relax();
      |                         ^
1 error generated.

Include <asm/processor.h> to allow including bit_spinlock.h where
<asm/processor.h> is not otherwise included.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/bit_spinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505..f1174a2fcc4d 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -7,6 +7,8 @@
 #include <linux/atomic.h>
 #include <linux/bug.h>
 
+#include <asm/processor.h>  /* for cpu_relax() */
+
 /*
  *  bit-based spin_lock()
  *
-- 
2.48.1.711.g2feabab25a-goog


