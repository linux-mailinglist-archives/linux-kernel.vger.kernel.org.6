Return-Path: <linux-kernel+bounces-396188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 582D79BC91F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897A21C211F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D091D041B;
	Tue,  5 Nov 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GNGgmD8/"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D470837
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798969; cv=none; b=gVJzQGFRMQ0qI+ioubxAlLr8ck4pAGHUgTt9Z3zXfs6S1gHXFbQ6KGOVTqetTNaZWUZdGwovbldYQeQH+A9DqtZoY5+vIeedHZ0ZGBKjL3twWudMLpwKAyAhDnbtvfofO202T7bLxvIKVELtwTN8YHXlE0jhwixWaT8tPPdKS2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798969; c=relaxed/simple;
	bh=T6guEfpJVtMsisu+e0e76q1MbvtRUM1Eg+AO6idpxgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtHMIoMWNpQqd7rF+otU8bDDamSxLQEYFpJcRgiXm/K7uUZFsRd3QzJwXm6OO7BkRAEhkDmPr54DqzZkMydVhBWXekuwTgrku67z9TbFpuEoNgzOGTv4ul3Tehx6ekkacq50qMrd0EGUQw3eiEq+fCncZaGppADOwWn8Mj/NMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GNGgmD8/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e59746062fso4272548a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730798966; x=1731403766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qE5HCyg61ikvJ6X0lEHZILXMMCdxd5npMW3fd1/VuCY=;
        b=GNGgmD8/VBo3//eAJadtfSn1oDgmeAvxFZJe0xfAVg9KEJdhqk+s6BShgyDrbnYI4h
         3esmT3IJcz8uNLhpK5rbeQl6yB3SHXqqm1oCJwZST73jTXxrQn3sU0lAHL3v+1WzUcC5
         HoUlWPjItUAr5NpbvcxryE59WlfvWV3pvX5R+AjnV3/5Ayid4HWUy9CQ9rxWzcB+ZBxr
         Sh5P8IBKiajZ8YqUU8S9eG4NJzH+NJZS5HmrzwyWgaenW9eH3Z1pdQbB3Ciu8Vhq8wJy
         /aSpfro9QO5sQ0rvot/feyK/pNshmDF+oV/ZV3YTfAMWH8L/ukskAF88+F09WBgfuZKu
         nrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798966; x=1731403766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qE5HCyg61ikvJ6X0lEHZILXMMCdxd5npMW3fd1/VuCY=;
        b=f9OpLd0v8KlCH8MDMdHtvP7tiNc3a9ziRA9ClfKh+nUvzEm2xP0Y9/eAHGexnUxMnM
         Uu0kN/cbq5w4aRdVl3G7xdtj1C3dqSk0IR1fJDfhfuLjPIsIVILYEAUU19tl73M+y1p+
         dU5+6xuItkxnSFB5bS2kdOQoSj41eYTQcv4rdFVB4c8CSpdJdFFAWI5J4LQ+V8mOxblq
         3YRlBjPVrbi9SKi8nRnKzcMxf+7xuim+Wf0pg9B4uN7/JkoIw+TpoDyVYB3bxU6O5Mwv
         cMDwP0pJvWGPnr/DMEzBskaBKeae/rkLONf62JXVXQqKIcEuWI4bGRAaiBoWmx+PLY7m
         I6tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkK40dFU+1kDbB9TqOVaZmPerXsJJAxhgoh8Gm2jVGAfyYGh5IvRF1ZwHrnFTcUvtJA9Jx88JqQL+4x3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPI4c4ix5J5KqM4o7hK4BEs0zM7J/cdxluzLwdHwfi9IKelKN
	qkXg9XFXqMaOSaGjRhV2bKUkbhtO2UUa0Gnf3LomnzWCyLAV39ggSCoHDXxOjtDLjrEvns6oYHG
	UK1aS8bNgYm2fPXGxagm0i3wLin3Akk97rnUy
X-Google-Smtp-Source: AGHT+IFJ4pg4HxMXCgs+o2MApEuvQXKMYtRif9RYO0x5A4ERvljwX4CzD776yRxMixI3xyY5vVT1ZhMBg2/6Ri5IQgU=
X-Received: by 2002:a17:90b:1a8e:b0:2e5:e43a:1413 with SMTP id
 98e67ed59e1d1-2e93c182879mr25488015a91.9.1730798966084; Tue, 05 Nov 2024
 01:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104161910.780003-1-elver@google.com> <20241104161910.780003-6-elver@google.com>
 <20241105091342.GA9767@noisy.programming.kicks-ass.net>
In-Reply-To: <20241105091342.GA9767@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Tue, 5 Nov 2024 10:28:50 +0100
Message-ID: <CANpmjNPws3_sODe3_KcHp9UFx79xk4Ow0QvVxYHGf_axGdoEag@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kcsan, seqlock: Fix incorrect assumption in read_seqbegin()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 10:13, Peter Zijlstra <peterz@infradead.org> wrote:

> >  static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
> >  {
> > -     /*
> > -      * Assume not nested: read_seqretry() may be called multiple times when
> > -      * completing read critical section.
> > -      */
> > -     kcsan_flat_atomic_end();
> > -
> >       return read_seqcount_retry(&sl->seqcount, start);
> >  }
>
> OK, so this takes us back to kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX)
> and kcsan_atomic_next(0).
>
> Which I suppose is safe, except it doesn't nest properly.

Yes correct - we just give up on trying to be special here. It would
be nice to also have readers have a clear critical section, but that
seems a lot harder to enforce with a bunch of them having rather
convoluted control flow. :-/

> Anyway, these all look really nice, let me go queue them up.

Many thanks!

