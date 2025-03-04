Return-Path: <linux-kernel+bounces-543653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A630DA4D831
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476E53AF8C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F70E1FE463;
	Tue,  4 Mar 2025 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scVZ+iz5"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6C1FECCF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080325; cv=none; b=ffV3ZSjP+k51SpeMWDOQZfRJV7mVVxiU2shLq7xbxJFqi0XQ55WBpMQi+GqnRVhUyma+KGRQllSjmUY3yJYRip5qZQzBsD710gIyjcq+qGjuWMbhSxTYxpfnEuetsx7yNuBi7V5AcbxFCab0XQju5gRTbD7nsjBsKcGy+ivWR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080325; c=relaxed/simple;
	bh=StYpncqzFSXHEYm8ZOW/8xsOKbkMA3l0kvQy8Snle/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TKKFuj9+PUPBhJsOdM7A/l7xHXGYVYjgSMePeRw+at6mDaNq15Wt56Bs36YUPPwYk95UuzDVmckQRqBqeEmPVEdXyDlg9fpXxiSGt15agf04BzMC+hzJirWODNM+s1VaR40wlR8jFQSFNkhVRtDBeOuWKegXuTyDSEwl1vgO4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=scVZ+iz5; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e4becb4582so7133075a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080322; x=1741685122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp+E8sKoonvgdGAMVoQXSiL/gMXgRdJZHQEkz4wDB8k=;
        b=scVZ+iz51d3NKfYcrDAT7foKOBgwosQbwsV6wvyQNI64abLBrDh3kInDKqEL2XZ2yI
         i/QZrCOLpx273bv8NHyFfMkQaEWrn+gVldrsOScezd369MRxCkFon/5fDKG3/J6LLe2Y
         /Rt2C3SRfGIkS4ckhqBpP2oarSPq8DXVGzU83CN+VTEPdX6PELSIYgXMFiA5JrRwOvRw
         qJcNkstNO1s+24/ilf3YPA860LBYfj+jGrKgER2EpZJ30Mu3wnVVCtrUgCVx+9zW6f58
         bbuk0W9+4Yn8rXXv+O7ED6LSWG+ZGH4EFSkSprX9pQazlOX1H+ktLbCGNglRfh7f3OmK
         q0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080322; x=1741685122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp+E8sKoonvgdGAMVoQXSiL/gMXgRdJZHQEkz4wDB8k=;
        b=q40HlcBJu+LUaaZxsIZqpgHzQS4ih0ek7i4ONBZSQ087S1NlQZpQEn53gU3R5iPqYh
         yq/zoqz9DhY5cNoT5DY2XPB1Tahk/ykKttasVJH85huJhRldfK6QJdnW94u7snKCbbBW
         bxgxdJEdFfxKNqL3UqhIeiCpUCb92niWAHrUFqPWVfiBZuixPvMrR2oqO8UYVLTJcQ/s
         T6wFSR9dfngyK3ri7PAi2ez7cteyuf6yOHA5tsoHj+BA6okUwqn3FnW90oQrMXNK8RE1
         ekbiT+qrmK/edv/36WtR1yWv7wd7zppcnKh+iCQMw+A3ygwv/Q68CYqLjbBxgldWK5M8
         yQNA==
X-Forwarded-Encrypted: i=1; AJvYcCU/HlNVKuo9WJVaAEIyPKYyjVo6n1K3St4fOxgI2q5pGS/3QYOhxW3+SQJsQk1nh30kgWBQmR0ysq+PSd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEBcMiAhT0cGZB7Mr78w8Iw7kY5d+TJUDQK+XLHNLgBQCwM4pr
	Gq7D3KhByN3kniSOzga1yXx7GkmaBq6nV957NEs5WrpM+Xu+j+I3lnD9mkKesbqUNMw5ip6Ggw=
	=
X-Google-Smtp-Source: AGHT+IH9KyF8MJ1v+l119Ih9d9zKK6oLF4W3jM8vNIisJnYl0p8zp9JkukwRd5xgRYNmt/zF9O2bCVvi1Q==
X-Received: from edpr11.prod.google.com ([2002:aa7:c14b:0:b0:5dc:578d:62e9])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3487:b0:5de:3478:269b
 with SMTP id 4fb4d7f45d1cf-5e4d6b75ef2mr15880706a12.32.1741080322290; Tue, 04
 Mar 2025 01:25:22 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:04 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-6-elver@google.com>
Subject: [PATCH v2 05/34] checkpatch: Warn about capability_unsafe() without comment
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

Warn about applications of capability_unsafe() without a comment, to
encourage documenting the reasoning behind why it was deemed safe.

Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..c28efdb1d404 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6693,6 +6693,14 @@ sub process {
 			}
 		}
 
+# check for capability_unsafe without a comment.
+		if ($line =~ /\bcapability_unsafe\b/) {
+			if (!ctx_has_comment($first_line, $linenr)) {
+				WARN("CAPABILITY_UNSAFE",
+				     "capability_unsafe without comment\n" . $herecurr);
+			}
+		}
+
 # check of hardware specific defines
 		if ($line =~ m@^.\s*\#\s*if.*\b(__i386__|__powerpc64__|__sun__|__s390x__)\b@ && $realfile !~ m@include/asm-@) {
 			CHK("ARCH_DEFINES",
-- 
2.48.1.711.g2feabab25a-goog


