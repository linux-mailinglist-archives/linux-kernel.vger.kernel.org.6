Return-Path: <linux-kernel+bounces-380292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893459AEBC7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AB51C2278A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946D81F80B9;
	Thu, 24 Oct 2024 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyQ9R+Py"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8F1B0F16;
	Thu, 24 Oct 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786834; cv=none; b=f1eM+RjSuzy9NwdjZ11Z16vPbyxR5Im/3WEGoj8skXzZR2hjwfPH3wPG846p5dasDrrbkyf1oSkuw30hsNgroKhGePDOUfr7pUklG7zBLGQVX/11MKNajGhAmZeONr8nsc+HjIEo9wlXwhmrQ5eswcEFOR4iv+NnvbeBGwZE5Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786834; c=relaxed/simple;
	bh=Y8Rgx5jOjflLlPs7Nf9yLu0bT4vcdUWwtwso6LqrjS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsJMBQrDH3PAQTG6KlSVM8ORlxz6Zq8DcScZTE/t00EzVwfCBPwY5jGTQEeeMVGVMk6Oj7HGycedq5IRmtgxBkSuewZ9pU1C628VePTbPxvDy8+xmx3kz4yd/cxCZ9l8+6uReQRHywGFPNS+e+vnZyhGNqGFG3fu1BrHrxR6HK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyQ9R+Py; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cc250bbc9eso6924536d6.2;
        Thu, 24 Oct 2024 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729786832; x=1730391632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIdsOKA3czoGJIx1Zf2z3KM/oyGGy6VzPqA/VM0UsXI=;
        b=EyQ9R+Py/FPXrElB2imhi/3HJCt7dqwU+R488uxMLeUXHYBRyFszWbKM+2cwr22qMq
         4nWDRVH5VPpKGSw91mPN8q6SwRPeYeL6nOu/boFq+Zfhm8udbFtjpy8c/On85fHxt+L3
         omWUUVRWGiI6iD80Lv/4YcdGuh1Lsq8OhylEAiUC7QZ/vYvKGepPg9cRGAaKV0bb7Vfq
         sGUSGxniocfTYrsl1OrmsHPMgZQcjr4tgowo+ycpO8P4/SOrA5DpcgdHD2OvnPBPFQNQ
         LE5xLFjEwnzYvmNhCMz9/yEBjGrHit+ZZsdQwHyhXDwpAHcfDqs9wUKOHCayZAaQc7Qh
         HAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729786832; x=1730391632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIdsOKA3czoGJIx1Zf2z3KM/oyGGy6VzPqA/VM0UsXI=;
        b=P8/Ssnek05y7rF8vM8WPM7svADvEWKSlXCZ8l5PbMncl3XlIBtJIqsTTyRJXX2srWX
         eslIfAnBBWIU5uesopFK2L8vt4g0SFVdIdNVZNsqsf34B7oFfppr2xDLeaj1o42/lofs
         KvFgGmnstvnWqByyaoIVj1KgXnEeAEn5cWLDw5kUhZiiQAhpZhL6+ao5npUALqa86wi+
         WxGDSZJgax2Nn4tRylQ4ItJEvvsb1p2J7tVJUyk9Lu2WreV5YzVlONocXU8gTUJA8BzX
         b8ZtOMQb5Q7atUuRHy6ygj1FYuYvlWaj9f9Y1CYuH75kmwZAkk88MsTWuFhQvytQUKWi
         i0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUmKeoKH6oROXw1FV9BWGACM7U3ZmoLvN5eu4qJEfO+0pWvS8oHksUw77GkVSRYWsiUpU1UNPGoEPNgPEHQSpU=@vger.kernel.org, AJvYcCWAiklxzrxdB68guYjHw6xUZkOmJtWHUSVfQyVaRSvX2kVJozCKbXEbcFJekFh25x/8KmChzWfCOsbgi/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/WVYa7r5Q2G5A0wdrEK1bMbpGtXMPiTvE7vBfMZogZjf//JN
	8Fksh1DvlwkO9YaF2TGr+KUpqto4aZsJOC6V/UEpWcJYoNYxLANn
X-Google-Smtp-Source: AGHT+IHNXYfo5jJXKqaDZB41a8s3uB+7CeKjUO09n8CEz4H7pqYy/60uGv6AjXTo8ldZiDkKwdZsOw==
X-Received: by 2002:a05:6214:3d9f:b0:6cc:53a:70b8 with SMTP id 6a1803df08f44-6ce34130e98mr80996746d6.1.1729786831659;
        Thu, 24 Oct 2024 09:20:31 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00a04406sm50871686d6.145.2024.10.24.09.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:20:31 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8D3BD1200070;
	Thu, 24 Oct 2024 12:20:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 12:20:30 -0400
X-ME-Sender: <xms:znMaZzXvBQE28LKK4XqPikQ4wxEu76ZGJT0mqKzQbu2_FW0la3mOcw>
    <xme:znMaZ7mTQofBnYBWzFx0zkfrDPYGlXHuidCwyQkBmtNw5Dw1rI8rIJHEYbO6IpDcE
    9q4eF-szqECMCFMgw>
X-ME-Received: <xmr:znMaZ_Zz_fumYWx_2p4LOmViIub3iU7mbjrkXeDQ6J8JGovurS3xWmZsE24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopeguihhrkhdrsggvhhhmvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehlhihuuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlh
    hinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrhesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtg
    homh
X-ME-Proxy: <xmx:znMaZ-XPxIBcyH1l7CLnkzt5TZFHo1ZmDqQD5JRf9CsdesaydaPtfw>
    <xmx:znMaZ9kG9B_A90W9pqhCYObm1jYwZz_uF3RizW_uVk6yffarE9xPTA>
    <xmx:znMaZ7d8ANh6OvE7Mzsc-DyWrrjwltwvNuiHLo67xraeo6RFtEnqpQ>
    <xmx:znMaZ3EVk4XoR_tmUwSMPk6qJh29jwSTdZQBua2V3mnTFiipzRMzQw>
    <xmx:znMaZ_lzwM9Kp8hKhj2wkINaNi4PsAdMyrj2TSPdncobzwcQDGi14X3L>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 12:20:29 -0400 (EDT)
Date: Thu, 24 Oct 2024 09:20:28 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dirk Behme <dirk.behme@gmail.com>, Lyude Paul <lyude@redhat.com>,
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, will@kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, wedsonaf@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>, aliceryhl@google.com,
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [POC 1/6] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <ZxpzzExItrGMISp3@Boquns-Mac-mini.local>
References: <20241018055125.2784186-2-boqun.feng@gmail.com>
 <87a5eu7gvw.ffs@tglx>
 <ZxnVmCqk2PzsOj2h@Boquns-Mac-mini.local>
 <87zfmt6hk2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfmt6hk2.ffs@tglx>

On Thu, Oct 24, 2024 at 10:17:33AM +0200, Thomas Gleixner wrote:
> On Wed, Oct 23 2024 at 22:05, Boqun Feng wrote:
> > On Wed, Oct 23, 2024 at 09:34:27PM +0200, Thomas Gleixner wrote:
> >> local_interrupt_enable()
> >> {
> >>         if ((preempt_count() & LOCALIRQ_MASK) == LOCALIRQ_OFFSET) {
> >>         	local_irq_restore(this_cpu_read(...flags);
> >>                 preempt_count_sub_test_resched(LOCALIRQ_OFFSET);
> >>         } else {
> >>                 // Does not need a resched test because it's not going
> >>                 // to 0
> >>                 preempt_count_sub(LOCALIRQ_OFFSET);
> >>         }
> >> }
> >> 
> >
> > Yes, this looks nice, one tiny problem is that it requires
> > PREEMPT_COUNT=y ;-) Maybe we can do: if PREEMPT_COUNT=y, we use preempt
> > count, otherwise use a percpu?
> >
> > Hmm... but this will essentially be: we have a irq_disable_count() which
> > is always built-in, and we also uses it as preempt count if
> > PREEMPT_COUNT=y. This doesn't look too bad to me.
> 
> The preempt counter is always there even when PREEMPT_COUNT=n. It's
> required for tracking hard/soft interrupt and NMI context.
> 
> The only difference is that preempt_disable()/enable() are NOOPs. So in
> that case preempt_count_sub_test_resched() becomes a plain preempt_count_sub().
> 

Ah, good point!

> >> and then the lock thing becomes
> >> 
> >> spin_lock_irq_disable()
> >> {
> >>         local_interrupt_disable();
> >>         lock();
> >> }
> >> 
> >> spin_unlock_irq_enable()
> >> {
> >>         unlock();
> >>         local_interrupt_enable();
> >> }
> >> 
> >> instead having to do:
> >> 
> >> spin_unlock_irq_enable()
> >> {
> >>         unlock();
> >>         local_interrupt_enable();
> >>         preempt_enable();
> >> }
> >> 
> >> Which needs two distinct checks, one for the interrupt and one for the
> >
> > No? Because now since we fold the interrupt disable count into preempt
> > count, so we don't need to care about preempt count any more if we we
> > local_interrupt_{disable,enable}(). For example, in the above
> > local_interrupt_enable(), interrupts are checked at local_irq_restore()
> > and preemption is checked at preempt_count_sub_test_resched(). Right?
> 
> Correct. That's what I pointed out. By folding it into preempt count
> this becomes one operation, while in your POC it's two distinct checks
> and operations.
> 

Yes, I seemed to mis-read what you meant previously, much clear now, let
me put this into implementation for a POC v2.

Regards,
Boqun

> Thanks,
> 
>         tglx

