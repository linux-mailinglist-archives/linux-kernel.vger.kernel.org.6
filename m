Return-Path: <linux-kernel+bounces-575935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739FDA70909
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0CE16817B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3855B19CD0E;
	Tue, 25 Mar 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrOdJN/n"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239019CC39
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927412; cv=none; b=PS9keEvFdxP+iOPZfftnlUkKek0eZexh4rbPLMN/Ch/+uCF03MONHDLxzcXeBLNBCZvryvgxiAZR5dq6Tl5ln/DRJw1qYv+tcgiEWWmR75ncfk3zJXZaG1CbkxDPL4R+pm6Kp8LqPv0uuHcQsFqjn6J0JNX49VBZAruetSzWuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927412; c=relaxed/simple;
	bh=Z/9lJhVTBRGnad0GoyXoA1eCrn4cxADU5RuFqiIZpj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHXHKi/JnjIuflXNhuOlKx9gxuNZeF+kE7ZP+EW60hCCj/m2aUQdFqRVoy4zamzDTYBH0gNkgLYnuVuCArIFutjQtKkZJSoM9RPdsRCv0wUl5xT3aJxkLMIDUnt1nUuD7xFDSa9ZKwkmT5N/xA9qcV3Cd0W/OKuz+D9MORz98dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrOdJN/n; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c592764e54so682032385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742927408; x=1743532208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8eKmhB4IFnu/wWz9bz23aTCFYM2BiZ97FbsYtffbs0=;
        b=JrOdJN/nlBYE3+2gVX6beWB8PzKRfWRY/8t4/vXnVZBf23pOVXAG7FgYCiF3b7kODy
         SOXdrqzFtLkKtqDtWurnP8jCqhZ+ZzfpH8Pi0PeDhVC4ftXol3hENL3krPkzZ+fdNgvs
         tu68bVgvJ1lF00Ei8NKWlXcjwW9J4A+B6GGEIiaVbe92sU/zcJHcdjRVy6I899OdJlWd
         jKFeEzo4WnpP5b1Xv1bo5PF0EeAB5o6hLYeFdTTpQ0dCbKfHDOTn9Irsuk9x8UKzF9Un
         T/+6jVKQuY8ddd/XmUv61ORFoMJJjEW+1j7n3gWnUExJFAl0aFkdJtfdQmJ0wygKfJvM
         gEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742927408; x=1743532208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8eKmhB4IFnu/wWz9bz23aTCFYM2BiZ97FbsYtffbs0=;
        b=ISVPY4Hu6WmQQSgd1A/D4Vc6UoyhuU6e85mRVrkakmsBgelI2xVVynZOKDDqM7OFio
         +l7HbJNvSHZFXMgPLLvTEIdsPDuQlnyuYIvuvM2UnDZCinxESn2X934E09Svunn7LI13
         /pxyOl3WBGT2N1qaycipQPgwWLDcz5ziMIBznldNeN2+4gJDqMFYqa3MYSRzxzWpxeTb
         5jNApqVvD1VOJRMcjr0HZAd9z+XyLQ8gycSzgkGtSWXmPB0VgaMfbmiw2uKDYehovlrQ
         k3CC+DBlL1g7pwjZFwXlekrKRGYPNeAIHobcHR55omLrUQ9pEvqmIP4xL5IxI+KxD2+4
         Nm7w==
X-Forwarded-Encrypted: i=1; AJvYcCXGlR/wNfjzFMekCj8aZIWqStEw+mj/21d+CcpsSvm+RgaRIY+LrggbsfZ8Q442cAt0agP7n4q/tjU/ndo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznjwELFF+/nOZL6Rh3yQWt+8eq1eaUrwSnFserjaFCjdTyma9+
	sSGMdqcJLLNbRT1/TQIGr5patc6WuTSsyRlUeMs3zU0CJUn9nrCU+KPZ8A==
X-Gm-Gg: ASbGnctxxYPViJCt4fR3Ds+2ZSE3RU1T4S6R0iRyjrprySfdhWGG0tSe8D0zX0tKowM
	NBP1K3It3gUqIPg6YgC8Yr1MbLmb0bFjefUXnA6sXbmC4McFjB+NjkOoV/+Ft/GZWkb1q9Bxjaj
	lH8CJIBmvWmyG6xMAq1w7vkcT2Wo7X6QppeoqozsmhLUsbXHJT4YELA8uhmM/do4wO4athBLesA
	2FzRo4VNu2b6WOmcGbcI4YsrY62LW8nCkQoYrBgafUKAdGDixw3nyB8nkSIWLxftdL28JoS2t0r
	MKvuOa6rN42//nvNN9yes2gpFObmSGg3gvUtATmFjoD6SVJkHu4X86wjeQA7mRbLBzibQK02zFR
	HSJFLdwqMnK82ILL0NQGm+f6Jh2TzlZNhHrA=
X-Google-Smtp-Source: AGHT+IEkArU/HVjoiphBvdDPCvGy8fE7knsktSkjFzUd0A68OQYpoVfXVTDmXJAOFwe/nbrLfhrUBw==
X-Received: by 2002:a05:620a:3196:b0:7c5:592c:c25 with SMTP id af79cd13be357-7c5ba1f7562mr3290100085a.48.1742927408168;
        Tue, 25 Mar 2025 11:30:08 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b93482d9sm667748985a.82.2025.03.25.11.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:30:07 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D275A120006B;
	Tue, 25 Mar 2025 14:30:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 25 Mar 2025 14:30:05 -0400
X-ME-Sender: <xms:LfbiZ3L0s-uxxazgHFWoD3FXWeadjSNLM0zw3SaLgMy_gH743OhUlg>
    <xme:LfbiZ7KcS4a2rLX4-DWyr244gG5AT-G39Ihj3EIxJ-r4kALdHdc6yx0TZYy1eNv8Q
    dhGK8J64CKp_qCAgQ>
X-ME-Received: <xmr:LfbiZ_v7ceRR6YlXnhxe1dOEbx2LU_ocX8A0Oyl5oWrlwkc8Y8eFW68BJe8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeffeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghighgvrghshies
    lhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegtlhhrkhiflhhlmhhssehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhr
    tghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgvth
    gvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepphgruhhlmhgtkheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtph
    htthhopehrhihothhkkhhrleeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:LfbiZwY4M-dJxruBtDlVTZCbVkn8kRSmEXzJR3mpjPItwQ9rOxb--A>
    <xmx:LfbiZ-YC8Io--R4sQyjcPuB2gUMfRSWU_6HrFv7pnuUtWFGsh_sJgg>
    <xmx:LfbiZ0B8umsgdONgT7567Kq9-xrbPQue3feecIIV8rIGq8dqwb2fSw>
    <xmx:LfbiZ8b4pedorhcQx9YLNFJ_N0qKFWYlJWuhlIBK_mp1euyq53iKxg>
    <xmx:LfbiZyqdZdJdfe8PEdkbLh1ndOOv_QbyEEEg2ZCi_Xi5ClbAB4ebB2zU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 14:30:05 -0400 (EDT)
Date: Tue, 25 Mar 2025 11:30:02 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Ryo Takakura <ryotkkr98@gmail.com>,
	NeilBrown <neilb@suse.de>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Borislav Petkov <bp@alien8.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] lockdep: Fix wait context check on softirq for
 PREEMPT_RT
Message-ID: <Z-L2Km8nHE7Eevis@boqun-archlinux>
References: <20250321143322.79651-1-boqun.feng@gmail.com>
 <Z-J6jE0lHJpWA20l@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-J6jE0lHJpWA20l@gmail.com>

On Tue, Mar 25, 2025 at 10:42:36AM +0100, Ingo Molnar wrote:
> 
> * Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
> > PREEMPT_RT."), the wait context test for mutex usage within
> > "in softirq context" fails as it references @softirq_context.
> > 
> > [    0.184549]   | wait context tests |
> > [    0.184549]   --------------------------------------------------------------------------
> > [    0.184549]                                  | rcu  | raw  | spin |mutex |
> > [    0.184549]   --------------------------------------------------------------------------
> > [    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
> > [    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
> > [    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
> > 
> > As a fix, add lockdep map for BH disabled section. This fixes the
> > issue by letting us catch cases when local_bh_disable() gets called
> > with preemption disabled where local_lock doesn't get acquired.
> > In the case of "in softirq context" selftest, local_bh_disable() was
> > being called with preemption disable as it's early in the boot.
> > 
> > [boqun: Move the lockdep annotations into __local_bh_*() to avoid false
> > positives because of unpaired local_bh_disable() reported by Borislav
> > Petkov [1] and Peter Zijlstra [2], and make bh_lock_map only exist for
> > PREEMPT_RT]
> > 
> > Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Link: https://lore.kernel.org/all/20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local/ [1]
> > Link: https://lore.kernel.org/lkml/20250307113955.GK16878@noisy.programming.kicks-ass.net/ [2]
> > Link: https://lore.kernel.org/r/20250118054900.18639-1-ryotkkr98@gmail.com
> 
> That's a weird SOB chain. Following back the history of the submission 
> I believe this line went missing:
> 
>   From: Ryo Takakura <ryotkkr98@gmail.com>
> 
> I added it back in to the commit.
> 

Thanks! Looks like I lost the "From:" field when I post the draft of v4
at:

	https://lore.kernel.org/lkml/Z8t8imzJVhWyDvhC@boqun-archlinux/

I must re-apply that email as a patch to my branch, hence the "From:"
field got changed. Sorry for the mistakes.

Regards,
Boqun

> Thanks,
> 
> 	Ingo

