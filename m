Return-Path: <linux-kernel+bounces-422869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DDB9D9F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC55166A78
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDDA1DF742;
	Tue, 26 Nov 2024 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VevgPNzn"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F471DA632
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732659808; cv=none; b=mXHjaTYAAuC2ooB7W2WZvkBZWozMKzU986zOa329olsJaKJmnk5FCpgeI23ti6HXb0mKOneT70vDyhxAilPf11csd7mGRPdTZLl6n7WTzdFmtsVeruRhqnXx7Q38iZQpYlWqmcZZWgpQS3U9HNZU0ZmuLedtds7q/g+STatG8tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732659808; c=relaxed/simple;
	bh=64QuomPLSn2fJdRoGYxUcwXZxwOWcK7OEcOuj1HAT/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuiO6fc62h3cEQnORauFTUhNTAO74u7K2lJ77mDV0OhLQhio21dAdO4M+q7nyfZMYRXi5O0lu5tfKFhy86U6CGnPZ1hE1URP3PAQrzT5cWgmyjFSOY0hw/q+b8ZHG3mNVOk6MzOThDYFbBQs4hUmLeC2uefS1V4q8mRSGAwqEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VevgPNzn; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b66639a5f1so216667685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732659805; x=1733264605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0q4xLZXbnND1sGpDGERrnzfNa5gxVkUBDFwlvGaH9ZE=;
        b=VevgPNznYqxq98qzkaQOFQoq4aTbvPfxDh5UmMqH/llLMi7sUGvz87fOk+/3ERqzbv
         yPfIGPaIQMIUakJ7H1rAVgX/sSJ9P+rI6WYFeFjxApoEGJ7VcVrXuqJ8EblHmwGObJPi
         JoqaEB15C8mHKRQ+pWOYMF0aevqGpOTt1WSogjA76fZBx2vKhq0BIOI5d/rYMUxnmh+z
         iuzr6/K94UF4C2ns1UYRHpQq/yW9B6Ii/ip3MiotfAAwqRv5SOjNyr+N324BliA8bcBs
         xP4bD/orUmIvwIAhxjuf8c9vewNzuxg8T3Hp2pvKcxcIpDUAaS3hV7jVSjyzsr6EFHvZ
         qT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732659805; x=1733264605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0q4xLZXbnND1sGpDGERrnzfNa5gxVkUBDFwlvGaH9ZE=;
        b=d4mf48Wr8atSP9dgESBuuisc1od8Wy6TLIpytHHqSjBWZHcBjFRUyQc/nPo5t4MzQv
         y2518Gl7sY/GNN4Oheatd4TpQhpC776vxraWz4tBDyow7QPazeTnX7PWaXwSB7Vp3SZ8
         oVppy4e15NfFNCRne44hYVSYndeL6zxVfK6kNPoCq9gqeFN2L8WquJZoDMatUfShTZ+y
         FdalKTO0xyYa5sd/dlgYwogiwAxMaOOni0ebDVdfkIxobWJtl+QEeKKXRgEFPOH9EjaR
         dMwF8/L64b4x1dCt7QWWLgRTziMwCqdhNUe/TUdUxCXvOy+B9jJaZ++XlTbbnpY54iG/
         LqSA==
X-Forwarded-Encrypted: i=1; AJvYcCViSWs0NTef+fv3+V+mr9D8j/De5mxwWndp6kCzjqSBW7b6MRzlVw6c87C1/1H/bzPuG5rPMJ3zedVD9Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcsoau6YVo1AJFRF9D9bSWnwZdUfPuSgybEhsfP+/um8ZpLFvT
	HCpzs2rqrt1nTbZGiQw7dcN30hUm4m/s1qtnghZGzEU4sTfqiNQH
X-Gm-Gg: ASbGncvuGAYnEBWaKELmYHxrQKhdS9x/MOCdZ9jCiogRQk9gpth6Nk2tPrx3czEQqdk
	33oDbJIZJRFlo29A8fppmMOIfVWikekm37yi+K4TYVj0+Z8V6q9ZB86gjekROmCK/fAqIccPUBP
	e1bRjs5arzoB+ZoF8Av20WZYhN8TD/sjL0r9729ejizUP1xlU10TmOYPONZHwKcWWzgySew4xZe
	+5aOCRcRbTkX7kGG+VK8R3YGIkHjylbu2U2TZP7rcyStVq5vuydY6wNKMqhgxxw5dg0peOpIarJ
	arD4r9IByg9l4+cEid2kfBP4Y4+lTAEQuUhmwlgH
X-Google-Smtp-Source: AGHT+IGxo0QxpuFcMdqnwzlUAZHM5lMQiUUAH5kTPL/bPZU9ZoYGvibodVn7t3KtMivCaWzBWQj8Vw==
X-Received: by 2002:a05:620a:170f:b0:7b6:7133:b8a3 with SMTP id af79cd13be357-7b67c2793f1mr121869485a.20.1732659805200;
        Tue, 26 Nov 2024 14:23:25 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b673ac4bc7sm151404885a.52.2024.11.26.14.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 14:23:24 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3E6161200076;
	Tue, 26 Nov 2024 17:23:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 26 Nov 2024 17:23:24 -0500
X-ME-Sender: <xms:XEpGZwvJfvYELZRwZOLRTX7BxK7S4GXjQVbTs6NFynUE_EJn08Fu-Q>
    <xme:XEpGZ9eXtQQgGKC4Fho0ECKAids0uAvTYFie2v4trgu1Pe0LSI5KrS-eRuXJNO3jY
    JpAtcnpIzD994Ftkw>
X-ME-Received: <xmr:XEpGZ7woUYvkiWKsBKqCk4IzPivc2VCj2aKvTlH872exW974SPWQ7DATfkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeejgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeuveehvddtkedtkeegffeiuefhiefghfffgeej
    gffgleehjedtudekheevleelhfenucffohhmrghinhepkhgvrhhnvghlrdgukhdpkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvd
    eghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtgho
    mhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegsvhgrnhgrshhstghhvgesrggtmhdrohhrghdprhgtphhtthho
    pehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhose
    hrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhh
    ohhmrghsrdhhvghllhhsthhrohhmsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:XEpGZzOsWhZD4kQJOxnFl0tOJ3kSzVne2rxDm3ykT9wGdwXVFPGPxA>
    <xmx:XEpGZw_omDC5f0kcukj8HbQcty6uNK-WG4dtH2e8NTRP7I_FggLnhQ>
    <xmx:XEpGZ7XkUoIB1c25Iqgau_tTJEZMmHUuheS5PeO5oUepF1RXErg2Og>
    <xmx:XEpGZ5eQPzY8nuTQuMO5IP9K2_-DqvL4XzuY0sfK1xG6q6hsHIuLBQ>
    <xmx:XEpGZycH3Xq7SeRmnYH83DYJ7A9XoEtD2vh09dsbNCrN6Adg-YfvTDkM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 17:23:23 -0500 (EST)
Date: Tue, 26 Nov 2024 14:23:12 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: Unexpected lockdep selftest failures
Message-ID: <Z0ZKUByBtv4aPXOP@boqun-archlinux>
References: <9025e912-7151-4a1e-b1ba-91eafde12179@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9025e912-7151-4a1e-b1ba-91eafde12179@acm.org>

Hi,

On Fri, Nov 22, 2024 at 12:18:40PM -0800, Bart Van Assche wrote:
> Hi,
> 
> With the for-next branch of this tree: git://git.kernel.dk/linux-block
> (commit 12ab2c13ca77 ("Merge branch 'for-6.13/block' into for-next")) I
> see the following:
> 
> 
> [    0.887603][    T0]
> --------------------------------------------------------------------------
> [    0.888763][    T0]   | Wound/wait tests |
> [    0.889310][    T0]   ---------------------
> [    0.889867][    T0]                   ww api failures:  ok  |FAILED| ok
> |
> [    0.892597][    T0]                ww contexts mixing:  ok  |  ok  |
> [    0.894638][    T0]              finishing ww context:  ok  |  ok  | ok
> |  ok  |
> [    0.898020][    T0]                locking mismatches:  ok  |  ok  | ok
> |
> [    0.900689][    T0]                  EDEADLK handling:  ok  |  ok  | ok
> |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> [    0.908172][    T0]            spinlock nest unlocked:  ok  |
> [    0.909484][    T0]                spinlock nest test:  ok  |
> [    0.910902][    T0] -----------------------------------------------------
> [    0.911824][    T0]                                  |block | try
> |context|
> [    0.912970][    T0] -----------------------------------------------------
> [    0.913890][    T0]                           context:  ok  |  ok  | ok
> |
> [    0.916613][    T0]                               try:  ok  |  ok  | ok
> |
> [    0.919235][    T0]                             block:  ok  |  ok  | ok
> |
> [    0.921852][    T0]                          spinlock:  ok  |  ok
> |FAILED|
> [    0.924666][    T0]
> --------------------------------------------------------------------------
> [    0.925852][    T0]   | queued read lock tests |
> [    0.926506][    T0]   ---------------------------
> [    0.927132][    T0]       hardirq read-lock/lock-read:  ok  |
> [    0.928496][    T0]       hardirq lock-read/read-lock:  ok  |
> [    0.929860][    T0]                 hardirq inversion:  ok  |
> [    0.931269][    T0]   --------------------
> [    0.931827][    T0]   | fs_reclaim tests |
> [    0.932383][    T0]   --------------------
> [    0.932932][    T0]                   correct nesting:  ok  |
> [    0.934252][    T0]                     wrong nesting:  ok  |
> [    0.935518][    T0]                 protected nesting:  ok  |
> [    0.936784][    T0]
> --------------------------------------------------------------------------
> [    0.937936][    T0]   | wait context tests |
> [    0.938516][    T0]
> --------------------------------------------------------------------------
> [    0.939661][    T0]                                  | rcu  | raw  | spin
> |mutex |
> [    0.940646][    T0]
> --------------------------------------------------------------------------
> [    0.941798][    T0]                in hardirq context:  ok  |  ok  | ok
> |  ok  |
> [    0.944946][    T0] in hardirq context (not threaded):  ok  |  ok  | ok
> |  ok  |
> [    0.948072][    T0]                in softirq context:  ok  |  ok  | ok
> |  ok  |
> [    0.951206][    T0]                    in RCU context:  ok  |  ok  | ok
> |  ok  |
> [    0.954345][    T0]                 in RCU-bh context:  ok  |  ok  | ok
> |  ok  |
> [    0.957477][    T0]              in RCU-sched context:  ok  |  ok  | ok
> |  ok  |
> [    0.960612][    T0]           in RAW_SPINLOCK context:  ok  |  ok  | ok
> |  ok  |
> [    0.963927][    T0]               in SPINLOCK context:  ok  |  ok  | ok
> |  ok  |
> [    0.967252][    T0]                  in MUTEX context:  ok  |  ok  | ok
> |  ok  |
> [    0.970571][    T0]
> --------------------------------------------------------------------------
> [    0.971702][    T0]   | local_lock tests |
> [    0.972422][    T0]   ---------------------
> [    0.972965][    T0]           local_lock inversion  2:  ok  |
> [    0.974319][    T0]           local_lock inversion 3A:  ok  |
> [    0.975708][    T0]           local_lock inversion 3B:  ok  |
> [    0.977106][    T0]       hardirq_unsafe_softirq_safe:  ok  |
> [    0.978595][    T0]
> --------------------------------------------------------------------------
> [    0.979723][    T0]   | lockdep_set_subclass() name test|
> [    0.980424][    T0]   -----------------------------------
> [    0.981123][    T0]     compare name before and after:  ok  |
> [    0.982423][    T0]
> -----------------------------------------------------------------
> [    0.983434][    T0] BUG:   2 unexpected failures (out of 395) - debugging
> disabled! |
> [    0.984441][    T0]
> -----------------------------------------------------------------
> 
> 
> Is this a known issue?
> 

Yes, these were reported at:

	https://lore.kernel.org/lkml/Zw19sMtnKdyOVQoh@boqun-archlinux/

and Thomas (Cced) send an updated version:

	https://lore.kernel.org/lkml/20241017151007.92215-1-thomas.hellstrom@linux.intel.com/

, which wasn't picked up. :(

Thomas, could you send a fix ontop? I'm happy to review and test it.
Thanks!

Regards,
Boqun

> Thanks,
> 
> Bart.

