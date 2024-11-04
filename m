Return-Path: <linux-kernel+bounces-395196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6739BBA31
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DD1282DEA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB2D1C232B;
	Mon,  4 Nov 2024 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9klFaVi"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76E1C9B68
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737180; cv=none; b=sP2Z00ui/tQt7AmNdco2DvIFKRmqKfNr7Ys3O307J7QSGxWYkF3Z44M8BWI23DlTo3SrtvSnsttdLxTe2FwAdvX0Qzr7JOlKnRXC6c77pbN7q1HO3ZVD9PwEiZ+1TalVjJTppQ/9yoCE+QGkkFEem2gX3MYBqjhsMoaOKYOIeVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737180; c=relaxed/simple;
	bh=5Xt4Fkz1MQW5w8UbS0tu5hc+USWbleuAt8BZVlSI+ks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K2W10/rnW2T14TbhM5yRB9gXmTlZ4kFr6R677GcO7uuY8KTo0hRUjYHusuKXRTpRrydNDD3SUiIyPQcXUCuY/i+M1EngF/iTg1JOtGeWZjto9JeOVEZD2a+OphIuoaAVp+ojJbxu6p7MiMYBEZo7SyJHsnH4FEi+qQLhdwhXDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9klFaVi; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37d531a19a9so2366763f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730737177; x=1731341977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKj0s9xjK+saMHMRM1ZIudsUlk4SnRJVysUql1YTd+A=;
        b=c9klFaViDRvVoW2eYQ0LJD/cjOOBknFad0ba2xjUurXry0KimKtNitoVlo3d49iyfl
         7XDxXrX7p3gAi1DoDSmmVuttxfqvld+7VklKqLuo90ZEqI16Drqo2FwWmPaTnLUcWt0M
         uBS5Su7uKMKXwt9xBUkPfE4AHEkW/feXHRfKkHWpIJSHvQcZMkU8Q5HGbkgNG2vhGaCf
         MtwZYQIdr0lkrb1DOazWjV/LmnhDJd3tfn5YuZR/ANGuejJ7S+tFrIrXQHLiDS53LQyC
         zXV7fNvHp6tdIbu2Utu0cYwJ5mbNdewc2TYUdjvxHHFZuHI+arZI1TA3++nCVkyP1Se7
         BA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737177; x=1731341977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKj0s9xjK+saMHMRM1ZIudsUlk4SnRJVysUql1YTd+A=;
        b=lESbIVyJodZihd98YkT7ioBe7AawcYDSstLbxgrtFgk3qpzOgeVhfOM88NwK3UHtZ9
         anI0qO+gjizdNxWqvttgIR9QU8JEn7JgvAcNI/UgQiyzQbOKlKSgPd7mlMo3iVT7pzPN
         OPR1iORHfOPvmGpkOp3H5QCWnBKnv+PJxTD72FtW6GHHg291axmsGBOVg0ehkOSKDDDk
         u8Qr+K+CQYcZusCVvF0e7Zv16ZHAihVGH4lEUA+xMjrUG3JRKFViMfF9iW0Uy1TFnsxT
         l6H6BJIbRJ5xPXdYcva8h6vlSDouJHr8ArN5ZPH5ioDs5yS+NiOZ68yxz+ThhsD1akZe
         cObg==
X-Forwarded-Encrypted: i=1; AJvYcCWUbYOwioaBaW+xgWiwOs6xDEPMZBzgLclMYtnsYMGFBSk75nIjoEfrv2Dd8dTC4w36nRYnB3qpZ7UVFms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzowYo1inMPnptJSoRWWUNYPaxXj6L0OoH50hpG8g4XsarADvLW
	PYB9S2PwG6grXm/eSROXFm2y8miSWit5Pk44cv7/ANJMRPGgmjMKdb5zlwI1MFxLC3aXF1acxw=
	=
X-Google-Smtp-Source: AGHT+IFYYQcvbot0gcoCP5b6QfEJHJaRpAbBNrY7qSGTa/FrddCLO5titnk6bblSV7Xeur6I4XZZDbNdVQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:dc4d:3b27:d746:73ee])
 (user=elver job=sendgmr) by 2002:a5d:44d0:0:b0:37e:d5a2:b104 with SMTP id
 ffacd0b85a97d-381be7cf9ecmr7016f8f.6.1730737176936; Mon, 04 Nov 2024 08:19:36
 -0800 (PST)
Date: Mon,  4 Nov 2024 16:43:09 +0100
In-Reply-To: <20241104161910.780003-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104161910.780003-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104161910.780003-6-elver@google.com>
Subject: [PATCH v2 5/5] kcsan, seqlock: Fix incorrect assumption in read_seqbegin()
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

During testing of the preceding changes, I noticed that in some cases,
current->kcsan_ctx.in_flat_atomic remained true until task exit. This is
obviously wrong, because _all_ accesses for the given task will be
treated as atomic, resulting in false negatives i.e. missed data races.

Debugging led to fs/dcache.c, where we can see this usage of seqlock:

	struct dentry *d_lookup(const struct dentry *parent, const struct qstr *name)
	{
		struct dentry *dentry;
		unsigned seq;

		do {
			seq = read_seqbegin(&rename_lock);
			dentry = __d_lookup(parent, name);
			if (dentry)
				break;
		} while (read_seqretry(&rename_lock, seq));
	[...]

As can be seen, read_seqretry() is never called if dentry != NULL;
consequently, current->kcsan_ctx.in_flat_atomic will never be reset to
false by read_seqretry().

Give up on the wrong assumption of "assume closing read_seqretry()", and
rely on the already-present annotations in read_seqcount_begin/retry().

Fixes: 88ecd153be95 ("seqlock, kcsan: Add annotations for KCSAN")
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 include/linux/seqlock.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 45eee0e5dca0..5298765d6ca4 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -810,11 +810,7 @@ static __always_inline void write_seqcount_latch_end(seqcount_latch_t *s)
  */
 static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
-	unsigned ret = read_seqcount_begin(&sl->seqcount);
-
-	kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry() */
-	kcsan_flat_atomic_begin();
-	return ret;
+	return read_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -830,12 +826,6 @@ static inline unsigned read_seqbegin(const seqlock_t *sl)
  */
 static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 {
-	/*
-	 * Assume not nested: read_seqretry() may be called multiple times when
-	 * completing read critical section.
-	 */
-	kcsan_flat_atomic_end();
-
 	return read_seqcount_retry(&sl->seqcount, start);
 }
 
-- 
2.47.0.163.g1226f6d8fa-goog


