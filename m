Return-Path: <linux-kernel+bounces-366632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4013E99F806
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620EF1C23212
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A821F8198;
	Tue, 15 Oct 2024 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZMbVhdy"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766915699D;
	Tue, 15 Oct 2024 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023706; cv=none; b=ULFJce3J+SKH/sJVOmH4KtGFHGKcLE+6caRcgRFKD31vjLWqEX7Ze9D0Y2oGTXJyH+dnG3Om7OK3gXXdh2+uZCNsC1asfJ1396XGXkp4bNVx9mqRU59I2reGJW2X/RdUBEzdACKVowXxpFEx12IehvfzJdVz8YPOgsBaKN1NEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023706; c=relaxed/simple;
	bh=TsQoUn05Or380T54uJ70aBO00/spSAkqgsSOR7g1kM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfIRWayE2VbrAU736b9NM3FI2epVHTZ++qhQQPSwIosxc42V6Rqjg0aBECABlHlEzChW9epzmF81U2lxdJ8T7msjisWI3fBgSUuvtxHzUVUF93ncC0p+umzppm5GRSb2UYC7T8OfQcyBJBWniVlcf78NOy/7VmL9Z4ufVFSUgR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZMbVhdy; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4607b8c5392so11310721cf.3;
        Tue, 15 Oct 2024 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729023704; x=1729628504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ6hEDkjFzC0f40auFtQ4iNOTFauqf8PDSFmxPj3NqI=;
        b=FZMbVhdySndvr54Fx6ieKUPSF2twRS7BGNQN8Py2nMgbDkJTaSTPGZlDicJwojbOUm
         Iwpvn7K/KdQYyXvfUQsUs2PtISsw/8kh9laqbpNOgZvCxONQ2PAv157dCxjumDn0DNaF
         Z+n+xIHp4+l2er02q2LOpCVpfuR3aOivm+fqAWYfipJTAmbUc8fnah+phMtykhNA+P4M
         qqsN+519HDgKw04FVB2c7MuzJPSwliQLESVv/zR5688jwet5V2MjZWd6Uw+ZP7AaPCG9
         t30VDebZesnnljjGqcigiI4r1r9kk9fuf91TrJhp7EOYWzsJchbeh7sdGFgju7PunIaN
         n5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729023704; x=1729628504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ6hEDkjFzC0f40auFtQ4iNOTFauqf8PDSFmxPj3NqI=;
        b=T74zi3+rY6aF77yaBL+EXsflSAb+1KcmDYglGZQNLJmx5ycifqQQ2x+PAG7DXnQDv/
         Q6BdN49TFJ+ZMEr8ibopWQUbYoe3RGe3ey93kRwUHAjjuWsUz4F1pJFhv2qs614iL0TS
         vy+tYJzgTzNwlWsuZbQ9SVyRitkG6IY9K3shr/MV4wkS1Zd+UD6MUjLzD72tpZ8rQ5tZ
         VycAI8fXDtEw9q4DYc99AZWSlvHtqjnbpujjffbHxh5wO6U1gkNxHFlhxmY1sKTrw8un
         mAyK245Id8J+3gqX2HELZFyBIZIudxegMLxm/0JRY0bvytB2DWtBPTqyIjPJB/4Qp88o
         HhYA==
X-Forwarded-Encrypted: i=1; AJvYcCVd/dbIMzb2SI/8hM5xZ0PI0UuOihOUgPEmjJ+ohqVCMQ8Z/qExaFZmIbLkTWXSzx9VqQdG4eCTrrWUsH8l0fY=@vger.kernel.org, AJvYcCWAG78HRd6zb+QAYtiAvABMQ4l6/b/l6TgymF5KEOtdCqdfI9CwRPnx9QsMiVsgoj+++k5VYlKBX2UBxIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRII67N7lbjRYoZDZxA/6zjqrKePojkKUhQiUmaphBC6THi+yH
	KwbNwPVmim2jFHB4Bb4sWJg6eK0nOVOLKcyuzuY0C5c/ha7GWvEa
X-Google-Smtp-Source: AGHT+IEsFTVOPoFdOxRx/b7iHwpk4gLxKGsQRXQSz8uWbQLC4gmvta6yqQEv5/0HGc5k2rVbNKBfqw==
X-Received: by 2002:a05:622a:5917:b0:460:37a6:ed80 with SMTP id d75a77b69052e-460584d073dmr222804911cf.40.1729023704133;
        Tue, 15 Oct 2024 13:21:44 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0a28d3sm10236681cf.18.2024.10.15.13.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 13:21:43 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1A4091200066;
	Tue, 15 Oct 2024 16:21:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 15 Oct 2024 16:21:43 -0400
X-ME-Sender: <xms:1s4OZx7-IbCG5aayqf4syBScqqYzuBGba9KG1F3vfG4AWzHjmokUWw>
    <xme:1s4OZ-5CZhjsAyt93rpeauDZj9wuklKo8CNq2uAtmiAGHuJ0f02XCzlxtADQl5SaI
    iFYZzd__HyHL1wu7Q>
X-ME-Received: <xmr:1s4OZ4erdFJGVY3OqmaJPQRG5U0spbIbm4aTiw5MO2T-EAIxB4AUx9jzy4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehruhhsthdqfhhorh
    dqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrhes
    rhgvughhrghtrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihi
    lhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrth
    drtghomh
X-ME-Proxy: <xmx:184OZ6K-H2V1CbMnSVQMmuHRjPIEVhK9l_NihfYtrxoXEWQQNyPptA>
    <xmx:184OZ1J7ZQlfOxhUtCgFPi_xrUj_Zuk2jtF24mCgFpyfPnQQ_dp2XA>
    <xmx:184OZzzKf3lufnz4b_Tr_NXL3JTpkN7cYrP_rws_wlox-Ry6hRmNqg>
    <xmx:184OZxKVCHUiA-3aIx0bwsUNGeOSl81XKte7TqmlgX5R1OEFq8xQFg>
    <xmx:184OZ4Zx3pu6JMG4t0bULaAf704opPi8QFf3fuwX1afNYv6fPuYPyLUE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 16:21:42 -0400 (EDT)
Date: Tue, 15 Oct 2024 13:21:41 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Benno Lossin <benno.lossin@proton.me>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v6 3/3] rust: sync: Add SpinLockIrq
Message-ID: <Zw7O1Wn7cwHDcCQl@Boquns-Mac-mini.local>
References: <20240916213025.477225-1-lyude@redhat.com>
 <20240916213025.477225-4-lyude@redhat.com>
 <8734lew7jn.ffs@tglx>
 <0a802e5fc0623ac8ae4653a398d0dfd73c479b96.camel@redhat.com>
 <59803e6abd88dc29c402ff2b7ed020e45f4df1df.camel@redhat.com>
 <ZwPXSs62WY0qNLr6@boqun-archlinux>
 <87sesxa5i0.fsf@kernel.org>
 <Zw7N4RKzWAS9qi4I@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw7N4RKzWAS9qi4I@Boquns-Mac-mini.local>

On Tue, Oct 15, 2024 at 01:17:37PM -0700, Boqun Feng wrote:
> On Tue, Oct 15, 2024 at 02:57:11PM +0200, Andreas Hindborg wrote:
> > Boqun Feng <boqun.feng@gmail.com> writes:
> > 
> > > On Sat, Oct 05, 2024 at 02:19:38PM -0400, Lyude Paul wrote:
> > >> On Fri, 2024-10-04 at 14:48 -0400, Lyude Paul wrote:
> > >> > 
> > >> > FWIW: I agree we want things to map C closely wherever we can, but part of the
> > >> > reason of having rust in the kernel at all is to take advantage of the
> > >> > features it provides us that aren't in C - so there's always going to be
> > >> > differences in some places. This being said though, I'm more then happy to
> > >> > minimize those as much as possible and explore ways to figure out how to make
> > >> > it so that correctly using these interfaces is as obvious and not-error prone
> > >> > as possible. The last thing I want is to encourage bad patterns in drivers
> > >> > that maintainers have to deal with the headaches of for ages to come,
> > >> > especially when rust should be able to help with this as opposed to harm :).
> > >> 
> > >> I was thinking about this a bit more today and I realized I might actually
> > >> have a better solution that I think would actually map a lot closer to the C
> > >> primitives and I feel a bit silly it didn't occur to me before.
> > >> 
> > >> What if instead of with_interrupts_disabled, we extended Lock so that types
> > >> like SpinLockIrq that require a context like IrqDisabled can require the use
> > >> of two new methods:
> > >> 
> > >> * first_lock<R>(&self, cb: impl for<'a> FnOnce(Guard<'a, T, B>, B::Context<'a>) -> R) -> R
> > >
> > > I think you really want to use a `&mut T` instead of `Guard<'a, T, B>`,
> > > otherwise people can do:
> > >
> > > 	let g = lock1.first_lock(|guard, _ctx| { guard });
> > > 	// here the lock is held, but the interrupts might be enabled.
> > 
> > Is it impossible to limit the lifetime of the guard such that it cannot
> > be returned from `first_lock`?
> > 
> 
> I was wrong saying the original doesn't work, because it has a
> `for<'a>`, that means `'a` is lifetime of the closure, which cannot
> outlive the return value `R`. So this signature might be valid.
> 

But another problem is that with this signature, `cb` can drop the lock,
which is not expected, because the lock dropping should be done by
`first_lock` itself.

Regards,
Boqun

> Regards,
> Boqun
> 
> > BR Andreas
> > 

