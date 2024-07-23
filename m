Return-Path: <linux-kernel+bounces-260205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C5E93A479
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C434284B12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFD11581E1;
	Tue, 23 Jul 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EO1VFI//"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A2E152515
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752824; cv=none; b=oLKUwGwe1ZDJ/e6s2Zj1OaGXJ3GzkQ+Ri/e9AdqrkTP3mRTG1kiKnAMeVGHqe7K4twYWbUmgg0Ar3aaFm/OpUfkKjdxeUvRTw/79v4S8bfbTaaxgqUQiUUvnYOt0Ad93nS7OSP+pQd3iRn50FZdEKXn/MLeFqvRNmiadtXvMcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752824; c=relaxed/simple;
	bh=Y7CKp72LnLmGYmZWrPoxonnGTmgCZ9J4nLMnTR8Tayw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jxPPVANcyDjC81/i6rvV9MJXsAljSk62hn7AxILLwq3b5pF+hsGybFrMZY1weYjiVcTzG5C9A0A5UNdUY5+xEqKRwRxDuXEoRK+uQ7GFA50DQ95Tuh5TDh8HsdkzdM1ClizexH13eCliutWWsLToSlQ5xf03rf+PDWXz9PoCaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EO1VFI//; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e08904584edso5250311276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721752821; x=1722357621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a0j2SkfwXb0n4ZsaJL4p0KSgeKz0AKwKkQzPd1dXsk8=;
        b=EO1VFI//I/L8X7toN7E4DPje7wBd5mOMMY9I+NnlOkENWBzXLyN8SN2L6zGGxx6HhA
         4l09N68KvW9H8lHn8TiUbvuJokWdwfi6L+A6EUzso7iJ7cvoQC9oR53kp4/H8RIhJE9o
         EC6OqE0jRFX0D2lAFgWTL65sA0lCWal3+JztdPZc4O+wowLxdZNpkcKV7N5EopfpuvdC
         J8tJ9N+5llhFQZrJDcO9gooaKNa6fMC7mfeVX/VOuiOFbSIAj8Qs4yHSKNvZ+rA0oXEt
         JUTO/dDaynQISGaJzGaPTedhWBpjYXJAMfTffBrowZoQ6z8CEii8F3JqM5qyjURRFOut
         b/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721752821; x=1722357621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0j2SkfwXb0n4ZsaJL4p0KSgeKz0AKwKkQzPd1dXsk8=;
        b=Ow7LUGF5vG15sHSiU0joG80z+8w7sy+CHF2xa242eApaO9uqZ9BHl5Zpp5MEsHRKTO
         k7HRGIe7YOjgZGkf/BIQdNsAMCof9YhRIKto39sHIQEqa+ROpVP9VXjV076ED90+mbnu
         Q6BHmzcF2NUh9k61KCRexpanvANWlfOhHBqrZ64u2d3TxFlBDnJji98SwcY6UTzpc85Q
         pex8BYuRBLRLu19zIAr9nyg8sR5PYYzVIB+lkKCa/VAJBrUuxDIK6KocIkc+fR2xrDhG
         WpbJFBrAqmlBRxkFBuTF4kTXwr1YMjrdQ+b4wVd3cl3PHZ7jSupeyFUOKiS4RV9A0sZy
         oqyA==
X-Gm-Message-State: AOJu0Yw7BCo0fkkyGW5ek1FVjI9n6R2rb1Pn6aDi+LJ3E50CX7rlT5tw
	Q+swadc6WmX3ZhfCFFL1A45ntsMHFCtybX2rWA4lYpWhOpnjEKyPAlp0SqtwYJh8CRDedNrg3jL
	QTXvcVUemjA==
X-Google-Smtp-Source: AGHT+IFDsEOs0Doqu1u8gnDl8g9FblPQo19/Q6Cg54hyhbYRuk7On6RB+qNE7AOL0ndMCRdzFol8b+1kBAFdvA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6902:2b8d:b0:e03:24ec:709c with SMTP
 id 3f1490d57ef6-e08b5aaf99amr5377276.12.1721752821431; Tue, 23 Jul 2024
 09:40:21 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:40:17 +0000
In-Reply-To: <11faf952-c0f8-6e1d-3560-12d77847a8ac@i-love.sakura.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <11faf952-c0f8-6e1d-3560-12d77847a8ac@i-love.sakura.ne.jp>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240723164018.2489615-1-cmllamas@google.com>
Subject: [PATCH v2] lockdep: upper limit LOCKDEP_CHAINS_BITS
From: Carlos Llamas <cmllamas@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	"J. R. Okajima" <hooanon05g@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
	Peter Zijlstra <peterz@infradead.org>, Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"

From: "J. R. Okajima" <hooanon05g@gmail.com>

CONFIG_LOCKDEP_CHAINS_BITS value decides the size of chain_hlocks[] in
kernel/locking/lockdep.c, and it is checked by add_chain_cache() with
    BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
This patch is just to silence BUILD_BUG_ON().

See-also: https://lore.kernel.org/all/30795.1620913191@jrobl/
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: J. R. Okajima <hooanon05g@gmail.com>
Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
[cmllamas: fix minor checkpatch issues in commit log]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..04668248225c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1515,7 +1515,7 @@ config LOCKDEP_BITS
 config LOCKDEP_CHAINS_BITS
 	int "Bitsize for MAX_LOCKDEP_CHAINS"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 30
+	range 10 21
 	default 16
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
-- 
2.45.2.1089.g2a221341d9-goog


