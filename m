Return-Path: <linux-kernel+bounces-278069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C684994AA8F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2995B2CDC7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDDB85270;
	Wed,  7 Aug 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xl6duz5M"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3C84D04
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041577; cv=none; b=CyLncKAO5hmAsbP2tmPeawG6FCDKB0sHdFedq9Yl86GBIZia0AvowzJ8mrGIxSmnHxsMt3cHAK2NUjoK1SFxQ939rVgOKq0YoYPT4j+RNYJyHysbZPW3Zx0Tdbtszkah5irx586AaS8dXAll3/sjalXKkx1RGzsNnASHbfBZaZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041577; c=relaxed/simple;
	bh=AuD1e/htfG1lFR9kSdMvIEtoeOyeABqQKaB/QtDE2F8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EAQGQIr/2LzkuQFzsu6fRQrlsokR3yXZWLtCSzKQvlK9/NifkQgYQqH3dSnBZn27CgDrFSE9dA+fRIBkSbS9VaRIr1MVzcXPVjcbdLLeo7aybBKNp55IbqQ/IsLpsZHxosjTRf/q3o3DnytyFBjuMJIPyJVQAHB5F3WGu/9BXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xl6duz5M; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70eb4de4eb9so1911538b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723041576; x=1723646376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=26uLUGt1PbHjw3R3dD99uteqgjJ71bdj6keYRqjuSeo=;
        b=xl6duz5MIKSbbkUrFT/cd6sTwK25ZYwWq75wbDbcuUH6IQs0qdBKUQQyXhDjH1otd4
         UnvShibEA3kicEQLFSKwQVRZYefcfp+OdRvK+JvDpbp7lJUiDRmw39r8eHSzIRcwVSJt
         4XBsPlQXKC4Jod5l9adDefdkxuJdZCVAFKoamRDObiBNwmEsWKjTX7IBNUePDUkoOaLI
         z7iRNU7VsJv4cSxOoM6s/eBxra4RvyqoYEI9wWzdFX0Hx++EZ7SoPs97DfY6k/LadAXy
         Z2U4GR8WujkH+7ZEu0ZDmFx+SLI27pcPtTI8feDpIjezk09ngHg3h4KC1JGehPIw+f54
         3m4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041576; x=1723646376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26uLUGt1PbHjw3R3dD99uteqgjJ71bdj6keYRqjuSeo=;
        b=HBmPFRFPLzanjkfgFgo9kBRVY4qaCBFzHBKOUWtnW+i+ewYKlXPIZJp77bCmNKvffn
         hnfrKjUE37Fz/rIlp1lWCkSHhhiqx6VKhty/k1rAwP+mkgkvDdVQbbKCuLpQBdo6lb2p
         a8TNmUVoezJ7tfxFhI4p9SttpJLje0/jQAH+wU6bqHWXeDASVKUDn0DUF/NAlzM+oUjA
         scfExbKgktICPAk6Xq1EDUDV37+fwCdFJ1EXG1HBXVYtF5/Q+op3EfOrz3h1lHSd+B/1
         3UukcE0b9HpKBZ7ppokaUstc906B7gr61Q7MFufk7DYJCzHK6FpyZ/vUFzSlZAWbO+WY
         t0ZQ==
X-Gm-Message-State: AOJu0Yw7uUGzhoLCZI4WTSyzj/ltkmwXhCpjNz88NznukXE45xzalDDz
	N+L5NsKy6JGSwfQ+SnG15uAatZ2gA7DWjhNKjoZkhmDCaWHG7PEiKOV9QsM7GAIa2+QcPWVIBNQ
	gGQZjm85y2A==
X-Google-Smtp-Source: AGHT+IEZMcCt1x+PG1vtH8TF7MugLb9TpmzKqwXDpbLZ8DPfCHSERoPeDJ86A+OyXAQiHcK24I8oxCxpxP4D/A==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:6f0b:b0:710:4d1c:9ee0 with SMTP
 id d2e1a72fcca58-7106d0861efmr343810b3a.4.1723041575752; Wed, 07 Aug 2024
 07:39:35 -0700 (PDT)
Date: Wed,  7 Aug 2024 14:39:19 +0000
In-Reply-To: <20240807143922.919604-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240807143922.919604-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240807143922.919604-4-cmllamas@google.com>
Subject: [PATCH v2 3/3] lockdep: document MAX_LOCKDEP_CHAIN_HLOCKS calculation
From: Carlos Llamas <cmllamas@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Andrew Morton <akpm@linux-foundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Waiman Long <longman@redhat.com>, Huang Ying <ying.huang@intel.com>, 
	"J. R. Okajima" <hooanon05g@gmail.com>, Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Define a macro AVG_LOCKDEP_CHAIN_DEPTH to document the magic number '5'
used in the calculation of MAX_LOCKDEP_CHAIN_HLOCKS. The number
represents the estimated average depth (number of locks held) of a lock
chain. The calculation of MAX_LOCKDEP_CHAIN_HLOCKS was first added in
commit 443cd507ce7f ("lockdep: add lock_class information to lock_chain
and output it").

Suggested-by: Waiman Long <longman@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: J. R. Okajima <hooanon05g@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v2: switched the comment for a macro as suggested by Waiman Long.

 kernel/locking/lockdep_internals.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index bbe9000260d0..20f9ef58d3d0 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -119,7 +119,8 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 
 #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
 
-#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
+#define AVG_LOCKDEP_CHAIN_DEPTH		5
+#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS * AVG_LOCKDEP_CHAIN_DEPTH)
 
 extern struct lock_chain lock_chains[];
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog


