Return-Path: <linux-kernel+bounces-543667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCFDA4D85D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13C8170015
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FF420409E;
	Tue,  4 Mar 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4Brh2ju"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A7203712
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080361; cv=none; b=Br32PfyR+h4zwWKZ+WzyanZEc6sQIN/AplSa2nOjmAk36Odt/Q6isELkMO1d8ADvf+agl7K7pIA9+4aUiESb+55wEUaNF8nUvryiS8gPF6YG5JdV+fgcZDdi/rqvJD2k9J9ZaP79xaX3wII+vNCUkxa9a7ZHfu2SwX/yFzMd7wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080361; c=relaxed/simple;
	bh=lUYIYSgoA2ccoaBS4kBmkDa5sN11OxStd6T3cwMJmGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XY5eYbcXGM2JSSPe24MWCQ3OeOK6xl/7v2NCdGJDaLdd6I6BXG55os+Le7tDneJoZs1gLDJUMiP53b3RVMfrcXldkB8di3ZEhOEs9DiZw6ZkHW4oU+XfneBqDBY7ZOV8acK5XM9v8MLmgmJzNjkqWczdwqCykgt8kM4KVz472vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4Brh2ju; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390f000e962so1444077f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080358; x=1741685158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNf/nM4zXVueSeYIgASkm7nQo4wF4e7ceuZttNxifgI=;
        b=U4Brh2ju0/JzGeQkFzpz6Pa5S+ndwwj+YO/0zui4JgZqTpWkrRXeiobNwYy6GF5uJw
         7W7dW3ze6w+baD98PiqhEmYABT651n/BMYhi5kyDXUr8n+mB43S3wFq3bLPwzLi1rNuc
         GUNv+3c5pe391eo3hgyqolcIMFXVwlUXgmiSDjLl+P3i8BZdx+rD1wAlu204S5jZpItF
         uqFIuARpFw0X1hMGQNZ5khmk6NGwzFV2Te71IM0xGw0PlQ22M8UbEPCmwLPMJ+IcTLtz
         n8YlclBp81Ru2voBb/uop3JcdVVkq23FpIY3I04ZFkNjjaB7n31JsfzC8olIiXwaVZjC
         5TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080358; x=1741685158;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PNf/nM4zXVueSeYIgASkm7nQo4wF4e7ceuZttNxifgI=;
        b=O6O1OAIyhljXKpVpAtLamiAfA9KLb3xdk+rMm3bPrK5PqLt9V+kdPVvH06GlWTkmq4
         Iz2+EQsuEkNVYZv2C8hB5T1MoaLU8MneOI8muHQhSsV52947qO6KjacCUVRp98p2alOD
         TUTranLf/s5s2/kM77NTsAKjhvLLs5KxYVwKy7Ln8BbXchI49tq4JI+iD8wInurFZLMG
         K7suoUp9NpW8jbRzmgEQ77++sR9bR89SqlrCxGqeJNasr6RSsjX8WVY/gqeNYqLjSFOz
         5J0WJYhMLRldiOKyAnfFNd0lvZlTZ1nF4MHb8eH1/WiI27RRbOn4HB5wlOfCi2bfP5qU
         Zrgg==
X-Forwarded-Encrypted: i=1; AJvYcCWid5RHB7RSSJGFNSWtW0OQ5SqyEmX4h6pzAJ2dm8aoNqQIu3Qmdc07S38tR6BIhJLQ+0/Ly94IY8EfMJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeiHByP99H4VlYw0HpGKOREIaJf9CZKn7SQFCpAAC85y6p7rWV
	vEONZlFJLY5GNVNXCEWU7cWH3Bty4ZwM0YVopM0Zy/IEP9l1z84RVd0N2DQqo/u0RBNII2aJrg=
	=
X-Google-Smtp-Source: AGHT+IHNV2rVLk7DI7p2vN5TAoqWsmdPeX6tGGapgde3jO/7IaOi1K3xi+RVcuZ51YKSvmN00fSkAHnG5g==
X-Received: from wmbbi24.prod.google.com ([2002:a05:600c:3d98:b0:439:8c33:5ed6])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4022:b0:390:ffd0:4138
 with SMTP id ffacd0b85a97d-390ffd04350mr7740206f8f.24.1741080358018; Tue, 04
 Mar 2025 01:25:58 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:17 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-19-elver@google.com>
Subject: [PATCH v2 18/34] locking/local_lock: Include missing headers
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
Content-Transfer-Encoding: quoted-printable

Including <linux/local_lock.h> into an empty TU will result in the
compiler complaining:

./include/linux/local_lock.h: In function =E2=80=98class_local_lock_irqsave=
_constructor=E2=80=99:
./include/linux/local_lock_internal.h:95:17: error: implicit declaration of=
 function =E2=80=98local_irq_save=E2=80=99; <...>
   95 |                 local_irq_save(flags);                          \
      |                 ^~~~~~~~~~~~~~

As well as (some architectures only, such as 'sh'):

./include/linux/local_lock_internal.h: In function =E2=80=98local_lock_acqu=
ire=E2=80=99:
./include/linux/local_lock_internal.h:33:20: error: =E2=80=98current=E2=80=
=99 undeclared (first use in this function)
   33 |         l->owner =3D current;

Include missing headers to allow including local_lock.h where the
required headers are not otherwise included.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/local_lock_internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock=
_internal.h
index 8dd71fbbb6d2..420866c1c70b 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -4,7 +4,9 @@
 #endif
=20
 #include <linux/percpu-defs.h>
+#include <linux/irqflags.h>
 #include <linux/lockdep.h>
+#include <asm/current.h>
=20
 #ifndef CONFIG_PREEMPT_RT
=20
--=20
2.48.1.711.g2feabab25a-goog


