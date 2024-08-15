Return-Path: <linux-kernel+bounces-288246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE40D9537DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C020B211D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F361B1512;
	Thu, 15 Aug 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVYup4L1"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57A1AC8B8;
	Thu, 15 Aug 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737835; cv=none; b=qFUsfr33KTTcrlzrxesDy/Uv8JWWe0hnykutPxt30sh/q2kszsAVNONH5dR8O2FKmd4p8OWns/j1LO/I/JvubYGZ+hQ+UuTCaBWHw0YFjMYi65pl84c08kopn+/NpgpujiBP3sRvBFbEgKlXpJSwRawS+EemY3JhzdBzJvRhbOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737835; c=relaxed/simple;
	bh=zbkCRVVKkKwwTmRjusB6sNFL39uthbtKw5xdpUIUnjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHFyMsKVlOhFRBmAHaiwsWtVjyquy5Zm+raBW5AnlKTSptbLYJVCVot5RQfeE3U7lTjuT8AA87sFqkCPJVACG7kCg+KHUVIfaJiV7pDPuCMtM5tXSK0dzMrdcvsOGwkAb+4ogfL+1Vk8RolRwIDwrjp8c8NkUdEF0jwboI/lY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVYup4L1; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d024f775so75503785a.2;
        Thu, 15 Aug 2024 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723737832; x=1724342632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaqjfIK59wjp5g+Q0vXpZIrU4EmvhuZc7qeQbs3GIK4=;
        b=cVYup4L19n7TRW8YC7wwNhbUeCz0NtYKY6c1qWul4NI3QFIFkNEBgDRJmZcyvKZyOS
         ba47lV+0HA5ckm+YkhU4gqR34nXcBN6BVN+RMkB5/ja4tTAAF9XaZE/gtoO/2DRUKMFd
         e152BoJA6e8Zf8LETENWadaeVRMEwsAPXJf0NWx0ImUJZLIZ7ds7YqG11XCtjIhgCD2L
         kS03La2sho4oV1BwPGDJ8rmhq9TpBzR122DmdL5Pz558l9dtz3yaGWNgtEdv7sf0pDxo
         hPjGi2EzkrEvf2aWPZVE6Os6xY7zKSGRDCbk0+03Emr6gAw9Xk7apC43426DIFXiwGhN
         Ib+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723737832; x=1724342632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaqjfIK59wjp5g+Q0vXpZIrU4EmvhuZc7qeQbs3GIK4=;
        b=U3sX35jsMJTU8iYfPS0XJh0m2dNaoUtjwmZrdG3zmFsH7ep+WEaWx+1/gwW232Fuoq
         2pDPc/4vruZ40aM7Arlcz5n3z9efxkYAQ+z4mfLS6JQs6+uf+gv0Tf+Aw0XpiaYOB7WL
         0tqQngxZilmMNfZo7tzdG0JLp24LDpmH272pMy1UzTz7NZ6Z7atKzxqrW3zphMPfE1EO
         6/mrNiFGoCV45ps7fW7RFYKJ6Wu1TCn91jcGr7zNIlJ45gSGn+/Ahs5KL1t+y1DsmGL2
         RO9BPN2WKLl/MUW939vlHh1K6GWbmWoAEIxsjEP+TIYxZe7tgJCzkM9KzI7sbPgYqPV6
         wJow==
X-Forwarded-Encrypted: i=1; AJvYcCVtnpcon3s/TYeyUmtyHMLko+8ZUYOMU3EiIxPtzjK2ska9FPkieCkjvya4HE1JhGGmh75jNdFMryfqKmO74yGHOC6G1G6jh/Tb8LSxJ1OLaosWdxBsfvwU38/tBtqc5a4VdvaqwmwAXLPNOcM=
X-Gm-Message-State: AOJu0YxKnLI/NvOSnzfuPJCV7JVKNugCJhm0W1NA0D4qNfz6mZ+ETxew
	I13jAepTNtJXpHwhsi0yot7lYBOMkP1PlT5UytSUyF7vPJLs0601
X-Google-Smtp-Source: AGHT+IGOOzO3Smu467t6/kbFgN3Uu3QM3TFFP276cZXHHDnNDXlo4QG8X/6ZeeVmF2vdPDGo7K7Pew==
X-Received: by 2002:a05:620a:244e:b0:79f:18b8:5de6 with SMTP id af79cd13be357-7a50690936amr11984185a.7.1723737832266;
        Thu, 15 Aug 2024 09:03:52 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e06ccsm74128385a.93.2024.08.15.09.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 09:03:51 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 33151120006B;
	Thu, 15 Aug 2024 12:03:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Aug 2024 12:03:51 -0400
X-ME-Sender: <xms:5ya-ZmAvHfqHPJCUgFWYsTfxTWumiFFnWJ-vHyChSlFVHFiCaDcdog>
    <xme:5ya-ZgiIc-ubnGRYZhXwHwhECIUt8JjTNT1ivrTYAG0fHjt9x-hf8zamn4T-DoNzQ
    NxyCt9qpLdWWa3eOQ>
X-ME-Received: <xmr:5ya-ZplzKFuU6kZIS6KPVm9oAoQ_F4xXBw60j5RtxRsn4AI6adjCjobFLu0TWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtoh
    hnrdhmvgdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghkrhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghirhhlihgvug
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhngh
    hmrghnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:5ya-ZkwaBKw-4e3jjQD0uSoEV1UTZYsdD0JQtzcwUBq8DOIpCwgnnQ>
    <xmx:5ya-ZrQ-s09a9Tyzv1HrA2t36iO6tch9hUfphFfaFttIcCfzB8mfPQ>
    <xmx:5ya-ZvYGfmBWDofETwdph1RN7R5deP0mWI_gB6Gt6WXAYnOTyy_ajg>
    <xmx:5ya-ZkSMT4EUzHeixCY3N6Yl5rBHWgwQoIjzJkY_7oa10K1ys0UfpA>
    <xmx:5ya-ZtCdRNZed23H8ioFfOFkrfoe00cO_Ghh3yXfYjpdaPBMdiTc9ehn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 12:03:50 -0400 (EDT)
Date: Thu, 15 Aug 2024 09:02:20 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Aakash Sen Sharma <aakashsensharma@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/3] rust: Introduce irq module
Message-ID: <Zr4mjM9w16Qlef5B@boqun-archlinux>
References: <20240802001452.464985-1-lyude@redhat.com>
 <20240802001452.464985-2-lyude@redhat.com>
 <Zrzq8su-LhUIoavm@boqun-archlinux>
 <1bcae676ec4751ae137782c4ced8aad505ec1bb9.camel@redhat.com>
 <Zr0QyN8sQ6W2hPoJ@boqun-archlinux>
 <9855f198-858d-4e3f-9259-cd9111900c0c@proton.me>
 <Zr0aUwTqJXOxE-ju@boqun-archlinux>
 <Zr2JryyeoZPn3JGC@boqun-archlinux>
 <2b139d06-c0e0-4896-8747-d62499aec82f@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b139d06-c0e0-4896-8747-d62499aec82f@proton.me>

On Thu, Aug 15, 2024 at 06:40:28AM +0000, Benno Lossin wrote:
[...]
> >>>>
> >>>> I haven't found a problem with `&IrqDisabled` as the closure parameter,
> >>>> but I may miss something.
> >>>
> >>> We could also use `&'a IrqDisabled` instead of `IrqDisabled<'a>` (note
> >>> the first one doesn't have a lifetime). But there is no behavioral
> >>> difference between the two. Originally the intended API was to use `&'a
> >>> IrqDisabled<'a>` as the closure parameter and `IrqDisabled<'a>` in
> >>> functions that require irqs being disabled. As long as we decide on a
> >>> consistent type, I don't mind either (since then we can avoid
> >>> reborrowing).
> >>>
> >>>> So the key ask from me is: it looks like we are on the same page that
> >>>> when `cb` returns, the IRQ should be in the same disabled state as when
> >>>> it gets called. So how do we express this "requirement" then? Type
> >>>> sytem, comments, safety comments?
> >>>
> >>> I don't think that expressing this in the type system makes sense, since
> >>> the type that we select (`&'a IrqDisabled` or `IrqDisabled<'a>`) will be
> >>> `Copy`. And thus you can just produce as many of those as you want.
> >>>
> > 
> > Hmm.. on a second thought, `Copy` doesn't affect what I'm proposing
> > here, yes one could have as many `IrqDisabled<'a>` as one wants, but
> > making `cb` returns a `(IrqDisabled<'a>, T)` means the `cb` has to prove
> > at least one of the `IrqDisabled<'a>` exists, i.e. it must prove the irq
> > is still disabled, which the requirement of `with_irqs_disabled`, right?
> 
> Yes, but that doesn't do anything. If the token is `Copy`, then we are
> not allowed to have the following API:
> 
>     fn enable_irq(irq: IrqDisabled<'_>);
> 
> Since if the token is `Copy`, you can just copy it, call the function
> and still return an `IrqDisabled<'a>` to satisfy the closure. It only
> adds verbosity IMO.
> 

OK, so I think I'm more clear on this, basically, we are all on the same
page that `cb` of `with_irqs_disabled()` should have the same irq
disable state before and after the call. And my proposal of putting this
into type system seems not worthwhile. However, I think that aligns with
something else I also want to propose: users should be allowed to change
the interrupt state inside `cb`, as long as 1) the state is recovered at
last and 2) not other soundness or invalid context issues. Basically, we
give the users as much freedom as possible. 

So two things I want to make it clear in the document of
`with_irqs_diabled()`:

1.	Users need to make sure the irq state remains the same when `cb`
	returns.
2.	It's up to the users whether the irq is entirely disabled inside
	`cb`, but users have to do it correctly.

Thoughts? Lyude, I think #2 is different than what you have in mind, but
we actually make have users for this. Thoughts?

FYI the following is not uncommon in kernel:

	local_irq_save(flags);
	while (todo) {
		todo = do_sth();

		if (too_long) {
			local_irq_restore(flags);
			if (!irqs_disabled())
				sleep();
			local_irq_save(flags);
		}
	}
	local_irq_restore(flags);

(of course, usually it makes more sense with local_irq_disable() and
local_irq_enable() here).

Regards,
Boqun

> > Or you're saying there could exist an `IrqDisabled<'a>` but the
> > interrupts are enabled?
> 
> No.
> 
> ---
> Cheers,
> Benno
> 

