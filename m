Return-Path: <linux-kernel+bounces-232687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A24491ACE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40E9B27610
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2271993B4;
	Thu, 27 Jun 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SJbCIIC8"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606519922C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505948; cv=none; b=drO5eyW8n31PenJy9pzB/CcwOMV+FYLCX0/vq95fTTrM7BbzEZ5I1hUAE2G+KfaukgGLzUJ6Gyc7KyV237R/p9dMKWu0Z34SbEEOnMb+Zc6f5nGZPoZRINZbSLFR99T5RHcBKZ42/BKnbYdsMU8pIx5i/zOobN36wvgDMlBgvko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505948; c=relaxed/simple;
	bh=prDkbAgooKAcK1vTJuLjMcPZfqon387HpjmxbgTD8eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxiLD+Yd0nM+zYQPPkKkQmg7ATzAI76/vSolDDiwEy8m42dNLPIsJoCZx3W8o7Q6qMY909aIEfbHR5aexoGmQmmEdVaDrweJRKybiyUqBfkaUEITy7h+e3nTTlJEstyLbMQBt1ZgX1eSV0EaE/81yYI4L0/TMLR1jj/ih8nuZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SJbCIIC8; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec1620a956so96838991fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719505942; x=1720110742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ycSebCrQAPdM5kjmLyRXlbDvO9GJ9QZljEbMZ/M6I8=;
        b=SJbCIIC8VJ1Vlyjd6QqQjWBTMa0LfTntk3VQm3ockqjAp23+ZD+zwJ5hefwpxVtw/0
         AtkOlXFzUgNSa4AKlztmKlr8F13d5rlUH4FAYWKh4tTho02XHXbBOcvRzRi2qvsCqK0V
         2CfUxjaMPVlzAvTGluWCNkeogcKg+aTRhS/H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505942; x=1720110742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ycSebCrQAPdM5kjmLyRXlbDvO9GJ9QZljEbMZ/M6I8=;
        b=kVILEaHfaTrxRWRnUs2FyUlhGpXuxqD1e7qeFY3xPBRhh9bhkKkgoseqyn+ItgJbfT
         pYZYDGwU4eb1o6oOBXJbGtd5ZnzWcEfuQEvT7dWxoq6Lo412jmtn3mWN3emgeRcXx7B8
         8F1U8nMZQtWvMW3TtQGQ916MMxDd2FwZSqVSsc0KyhhmAATuRVL+cFIa0unXK0QsLJzy
         KIIRAx5ftibaBrWrFuG8Le2S0zkoA2d25oByWb6WNOncoLljt8nIayADU/8eNUJu7l8L
         yfRJtmAh784wFAAdbFgbMuVlJi57Nb7/qz97P1dSOIbvqt13BGpj9KPgxa1WaTvzghDe
         MkNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGstidj46RlazEtOsJSfSv+yTwrH5HH35aNbI5JABDtl8+R+yjqZpUvokiJcID0y6uDTkjGj74gfzfXse9Ir3MdRZQFymYrbY+p8aa
X-Gm-Message-State: AOJu0Yy5gWuFBpdoSNQnPxwl0uXPFb1xtz/AjduuTg1/LXcnded1Z0Tr
	IXFB7dtZDiAElX8wumu1mfzj8ruTC3G3oauj/6rGJG6UaT9CHoThhI9YHNCLJQ4aL4e2U/T+W7d
	IHXd6dA==
X-Google-Smtp-Source: AGHT+IH8gcv5YEJNL0LWMIHph1RaF8fkoG/D533Ao8SCjsHU9xOcLy1JOSQstgSj8u6ClfYI9EUCKg==
X-Received: by 2002:a2e:9684:0:b0:2ec:53a8:4b3e with SMTP id 38308e7fff4ca-2ec5b387fcamr84217961fa.38.1719505939994;
        Thu, 27 Jun 2024 09:32:19 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a344206sm3016561fa.20.2024.06.27.09.32.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 09:32:18 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdc4d221eso6855534e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:32:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGX84QDTF9Fgacdcm9Lmdx3CCTAL/5kRGutUd8HmsdKNHu+QcRqg3O1CT9Otnw14EMyzvM80TNWtSI4ANFduLEjZTrhgVZiXXGbrSY
X-Received: by 2002:ac2:5639:0:b0:52c:deb3:e3cf with SMTP id
 2adb3069b0e04-52ce183504bmr8087314e87.24.1719505938254; Thu, 27 Jun 2024
 09:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406270912.633e6c61-oliver.sang@intel.com> <CAGudoHF7ys8bTCE0G6vLzEbo+_NyQXmAEEGPJ4hx1yoYmBsoUA@mail.gmail.com>
 <CAGudoHFrMkdo1CoVxJUiEvQ_DyW3hzaCz18GjvLi4ny=o-q9ZQ@mail.gmail.com>
In-Reply-To: <CAGudoHFrMkdo1CoVxJUiEvQ_DyW3hzaCz18GjvLi4ny=o-q9ZQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Jun 2024 09:32:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7PXo_QbBo8gv27OpbMgAwLh9H46kJRxAmp0FL0QD7HA@mail.gmail.com>
Message-ID: <CAHk-=wg7PXo_QbBo8gv27OpbMgAwLh9H46kJRxAmp0FL0QD7HA@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jun 2024 at 00:00, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I'm arranging access to a 128-way machine to prod, will report back
> after I can profile on it.

Note that the bigger problem is probably not the 128-way part, but the
"two socket" part.

From a quick look at the profile data, we have for self-cycles:

  shell1 subtest:
      +4.2   lockref_get_not_dead
      +4.5   lockref_put_return
     +16.8   native_queued_spin_lock_slowpath

  getdent subtest:
      +4.1   lockref_put_return
      +5.7   lockref_get_not_dead
     +68.0   native_queued_spin_lock_slowpath

which means that the spin lock got much more expensive, _despite_ the
"fast path" in lockref being more aggressive.

Which in turn implies that the problem may be at least partly simply
due to much more cacheline ping-pong. In particular, the lockref
routines may be "fast", but they hit that one cacheline over and over
again and have a thundering herd issue, while the queued spinlocks on
their own actually try to avoid that for multiple CPU's.

IOW, the queue in the queued spinlocks isn't primarily about fairness
(although that is a thing), it's about not having all CPU cores
accessing the same spinlock cacheline.

Note that a lot of the other numbers seem "incidental". For example,
for the getdents subtest we have a lot of the numbers going down by
~55%, but while that looks like a big change, it's actually just a
direct result of this:

     -56.5%  stress-ng.getdent.ops

iow, the benchmark fundamentally did 56% less work.

IOW, I think this may all be fundamental, and we just can't do the
"wait for spinlock" thing, because that whole loop with a cpu_relax()
is just deadly.

And we've seen those kinds of busy-loops be huge problems before. When
you have this kind of busy-loop:

    old.lock_count = READ_ONCE(lockref->lock_count);
    do {
        if (lockref_locked(old)) {
            cpu_relax();
            old.lock_count = READ_ONCE(lockref->lock_count);
            continue;
        }

the "cpu_relax()" is horrendously expensive, but not having it is not
really an option either, since it will just cause a tight core-only
loop.

I suspect removing the cpu_relax() would help performance, but I
suspect the main help would come from it effectively cutting down the
wait cycles to practically nothing.

               Linus

