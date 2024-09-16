Return-Path: <linux-kernel+bounces-330648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E195C97A241
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6823287287
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AA51482FE;
	Mon, 16 Sep 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEg348KV"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F914F9D5
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489623; cv=none; b=IWqcSXoJYbH8iUJkPtiJpJphP4gjRtcypoAL4NnlEV0TftnVN85TScK+rPb03m/3PGLnsdvB7B+nSDLRzp47sWEJ/CtjWC3ZBn/t0+ROS0XHbsqOSJDEtbz71xBsC9raLVZpdZ4pQ4t/UHMmkSbOx56QxnvtaphZgUn67R3Co9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489623; c=relaxed/simple;
	bh=DFPhNfr7hYwKA9cyov4Ik6Y18sTDWCejmluJKi2Yt2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kN3KYWkzfMqYF8k7fMCVwDA3ND/roZmG5CesjKDmCkAUEr/Ncvd6sxrcG42u/oeJe2s2MGbBGyzHcqEeSU+z5ijgIc5iQkbh9IOK/FcO1RuP9ZmTauz/i9E0BT9sWHdZ7Mrt6FIvTUYOZESVT1WpvXXCjqOkWo2RFu5x7hZKvp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bEg348KV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so43328435e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726489620; x=1727094420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=15A8yM/DyPjFL6/g9+SQPBBqxk8J5Uf7zhxTAVeSYR0=;
        b=bEg348KVd2LM99eSTbZi/S6MP8ilTtTJcGluI6+T+HzuF8WNK0EYSYefVwjR250Ch9
         7tvEykyORDENtx/hZfDSFtwHcnn0YJ4fjJpPCKIyT6hjM1jnGTUqsDe+DCex0lT5+l+2
         wTS9mCLKB/mkeqd30aQqKM58fFCZuM06Nx7x5uakG+nIHNBldsDgUAg//BohEA4YZJBZ
         tlbRErtvUjDn1AZCQvKvhEMxyJL79yfSgtQQ4JC4SDaR12jceHx6GYDZLYFytMICKhwT
         kBHu+v8vZ2nw8eT2HZcNb9a/U8g8ST8gB1pfnTVVMQszLribDT4/r6fYg3krkLYyyiVG
         88Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726489620; x=1727094420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15A8yM/DyPjFL6/g9+SQPBBqxk8J5Uf7zhxTAVeSYR0=;
        b=urc5Y3rzcq9Fmt41CZFFup821kVxELoiom1mSJI9Eng8s7Vo03k2JR/Fe+V/fmsUst
         h3Nwg0ywtxJ7VLyiPAjx7zm+q1x4ljNHeRDMh2+zs4auedsTuiBjbt2Aig19Numi20TW
         dqQLDV1f2zXgFerY5hCHPpsv97qgKAkLnJ2zhuYXgJzzrjNX2IQUjmADSXJjIJFO6+HI
         FrctfYzFYX+41oNy9dXGUWbZX+/L99ITwV1GV0ktUfK/xPB4330L+XLinwMUzcsHaImO
         +0jAYJfjG9aqRrfywsD9kUbtaOILNHJlopm1JXoJ9b8m1E+coxeGl5qUm9hf/FOgHMUV
         E7aA==
X-Forwarded-Encrypted: i=1; AJvYcCUAadZNXPzrZND2PCZsB5uq87MaLwnPX6B2UqDzTiEd7mBWNarQHbsKU5I/HT8KrvK+rh0kSwiZse4E7a8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx70wpFWE29HcgIBBWmeRZDE61u8SAfhhdnry6J8pq0tdlobsKL
	6vDJoqJITVABcpwCE4ihORoFtjx64backoHKEnvvGlmgoE4e8uIMsl7BD/78mg==
X-Google-Smtp-Source: AGHT+IFXXqArRaKN8lGBqGMZxuy2MN0d1q9ekHi709FhVqk+dt+tqGTyO5rnafncd8Z5Mm4RnI1h8g==
X-Received: by 2002:a05:600c:46c3:b0:42c:b16e:7a0a with SMTP id 5b1f17b1804b1-42cdb5486c4mr92830385e9.20.1726489619782;
        Mon, 16 Sep 2024 05:26:59 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b189acasm109513545e9.37.2024.09.16.05.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:26:59 -0700 (PDT)
Date: Mon, 16 Sep 2024 13:26:55 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: John Stultz <jstultz@google.com>, g@google.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, will@kernel.org,
	qperret@google.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] KVM: arm64: Add clock support in the nVHE hyp
Message-ID: <ZugkDxmBGTJwjFXb@google.com>
References: <20240911093029.3279154-1-vdonnefort@google.com>
 <20240911093029.3279154-7-vdonnefort@google.com>
 <CANDhNCr8ptL+JbCTFwtkRx+=yLscqrTQ=P0dmu3rGStuZiBeuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCr8ptL+JbCTFwtkRx+=yLscqrTQ=P0dmu3rGStuZiBeuw@mail.gmail.com>

[...]

> > +static struct clock_data {
> > +       struct {
> > +               u32 mult;
> > +               u32 shift;
> > +               u64 epoch_ns;
> > +               u64 epoch_cyc;
> > +       } data[2];
> > +       u64 cur;
> > +} trace_clock_data;
> > +
> > +/* Does not guarantee no reader on the modified bank. */
> > +void trace_clock_update(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc)
> > +{
> > +       struct clock_data *clock = &trace_clock_data;
> > +       u64 bank = clock->cur ^ 1;
> > +
> > +       clock->data[bank].mult          = mult;
> > +       clock->data[bank].shift         = shift;
> > +       clock->data[bank].epoch_ns      = epoch_ns;
> > +       clock->data[bank].epoch_cyc     = epoch_cyc;
> > +
> > +       smp_store_release(&clock->cur, bank);
> > +}
> 
> Can't see from the context in this patch how it's called, but with
> timekeeping there can be multiple updaters (settimeofday, timer tick,
> etc).
> So would it be smart to have some serialization here to avoid you
> don't get parallel updates here?

Yeah, it is serialized later by the trace_rb_lock spinlock. 
 
> 
> > +
> > +/* Using host provided data. Do not use for anything else than debugging. */
> > +u64 trace_clock(void)
> > +{
> > +       struct clock_data *clock = &trace_clock_data;
> > +       u64 bank = smp_load_acquire(&clock->cur);
> > +       u64 cyc, ns;
> > +
> > +       cyc = __arch_counter_get_cntpct() - clock->data[bank].epoch_cyc;
> > +
> > +       ns = cyc * clock->data[bank].mult;
> > +       ns >>= clock->data[bank].shift;
> > +
> > +       return (u64)ns + clock->data[bank].epoch_ns;
> > +}
> 
> You might want some overflow protection on the mult?  See the
> max_cycles value we use in timekeeping_cycles_to_ns()

In the RFC, I was doing a 128-bits mult. Now as I have the __hyp_clock_work() in
the kernel that keeps the epoch up-to-date, I do not expect this overflow ever.

But then I could combine both to fallback on a slower 128-bits in case the
64-bits overflowed.

> 
> -john

