Return-Path: <linux-kernel+bounces-366630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A5499F801
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BF11C21EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD941F818B;
	Tue, 15 Oct 2024 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuSshw48"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E11815699D;
	Tue, 15 Oct 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023463; cv=none; b=b613rfRN1d+MLakaaBquTtFqA7xURRcAP1cPCXRPv8dv4nM05TvJWZ8a/RRX+fOzAcpcWV47wjRMHU9zWi7uEl3zVDA/TcO7v2lsFeCa8AhCo842FZpY/M5qGCtxwhDhSyEI0yNG1r6c88zswpVJLkRY4LZToeI+a9IpuHZEy5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023463; c=relaxed/simple;
	bh=dVyHyTA4F3oyIt/YjsGBV4VmzH4VqO8inQbhC56t0DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CR/kyyng49mfZBIz6HXQuc182gJ9AeJruy15JxGu7SgNc2NhZcWn/jtD91yZvDEYR7mQj16QWz+HWmd0+gDB0sptj8p4/xjEZ0OtYBbcqVZZsTW2NrQu3iwLOgK7VOiXx8FZoSGLurEEiaOWc/N2B2gwQw/8UDpt4Y4EGUBZBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuSshw48; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b13c0f9e34so65470385a.1;
        Tue, 15 Oct 2024 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729023460; x=1729628260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7e8wUvCLZ+54cx0pCJlcOJobLkCUpxQGFBNFP+yb+f0=;
        b=XuSshw48d9j7l/tASDTb14pZfyU4Utmb7+COW6/1nIEjOpIS26/6mzAEV9dUlTdhPW
         gyq0HtTKhPJ/PnB8yq7O6pf0Xu+3obGmvLzIXp61sv9E1xJZr+WKkRPSj/JxXeI1S04K
         0p6Sdzei4Kd1kMnRA9QfU1/thrzwXuF7mha7aLtlNQoFklTyA48MpK9niUIn6QxmH3I1
         sDAk9Vr/QsZWPb++4nPF2xZsG0j3N89Dqfg4xL7tC6cxJSwGVl4DJv7Lf01++LFxXT1l
         V/A3c1A7bywlN1TOgmaiDO0DQhE+4Vp5SUTnjsgwFF27C+J96H3eCN3lSiZNhnMQqb2A
         UDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729023460; x=1729628260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7e8wUvCLZ+54cx0pCJlcOJobLkCUpxQGFBNFP+yb+f0=;
        b=gyoOnLL2HEqm4x2cZD8H2ue+EbLpTzg+IccsKB4hX9dkA8dX4Y0Etatm6dvtxFrc4R
         xeHGxDVRgYB9AL3UYx70M1PCvfXW1hYeA8JRLAjQ98FC3NT7FMzkjN4drfDjYptNWBE7
         zLizglCtI5O7u3bSZvfq/sg3mhlILeGhc112Mn3u+JwCQo9d31LaT13DN1nARD2o07E9
         OZ6ArKDZZLXyo1Rziigl/Q0YYdPZF/WzpMu+LUOqUjkY4/pCqCc+SiYJ4gjAeb+RGAqv
         4asGnZsVsl6+t+A/ge9/egL1kRfV+XGFTQa4rAnLGCnYz8JXsrfren74L6vm+IgAktEa
         ZH6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWX3q/3KD+TWVEMGseNGHVJSOO2OTpFZSiB2PVKZV7bGHrXjBAyY3I4HfyCB52IMgQ2gZ+5WuFgPyP5lcXkI6g=@vger.kernel.org, AJvYcCWZn7IQBQK+J5YC56VrnGhTBczUHAzAB1gpdCzdUjnfVLq8B8Pj+X36obIfCA45IZF9BOybXxfX+/+TAgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHdPRv9TnxV3qlG8a3bpANOafIEnQ3RQXp4uU9ruJp6QGlCFl
	Mo40q4wBrJGbEB7mfHTUhfrzl/duPyiC2PUT6dIiYruWvhpY8kcD
X-Google-Smtp-Source: AGHT+IH4pGSnZufgTJwMduOZM9YXuuJhe6snWsw4uMRMrDf5UC0QWPC8FlBqJ/HVtjiq18bW8pGnKg==
X-Received: by 2002:a05:620a:3916:b0:7a9:b8d1:a1d with SMTP id af79cd13be357-7b1417f3a82mr245116685a.38.1729023460368;
        Tue, 15 Oct 2024 13:17:40 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13b9a3996sm88330785a.39.2024.10.15.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 13:17:39 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id E8AED1200077;
	Tue, 15 Oct 2024 16:17:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 15 Oct 2024 16:17:38 -0400
X-ME-Sender: <xms:4s0OZxmtaMsNyVtmPXfq5KMRbmVnJ7awKBXXJGplgQJhudy1yfS3Mg>
    <xme:4s0OZ81FGDDCNlVS8SW-rqCAVtK1T_BIp9BRkamo7Jl0fvzhxf7ChDuAL9Jh7ke5i
    RiOG8ZAWzJIheZy2g>
X-ME-Received: <xmr:4s0OZ3o-aF_ZXA6Qwy6_aafnxMm5D_Djzd4KU0xPIu-vKuSJ5QaiEMOhu-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgudegjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:4s0OZxmi3_A3DNegqY91ALMsbytXxlYrrKszXP0tL-g7badTNbVEbQ>
    <xmx:4s0OZ_0-KtT9vP3AItiR_KfySnG9y_2VKWvbAAhus7A6QM9XKjPUFQ>
    <xmx:4s0OZwu8tkI9ygjjZKrZK7coMzhnExFdI3caTyHSSwqSpa6pzqjenA>
    <xmx:4s0OZzWEgetPJ1qQES8Gu0-cV5Zz814nvVv3XrDn-ti2UhBK7RKXpw>
    <xmx:4s0OZ221eYJOJipl7yfahUb1Wh_rk8eX2HW-kqndIvWKdT0IfBgf__ku>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 16:17:38 -0400 (EDT)
Date: Tue, 15 Oct 2024 13:17:37 -0700
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
Message-ID: <Zw7N4RKzWAS9qi4I@Boquns-Mac-mini.local>
References: <20240916213025.477225-1-lyude@redhat.com>
 <20240916213025.477225-4-lyude@redhat.com>
 <8734lew7jn.ffs@tglx>
 <0a802e5fc0623ac8ae4653a398d0dfd73c479b96.camel@redhat.com>
 <59803e6abd88dc29c402ff2b7ed020e45f4df1df.camel@redhat.com>
 <ZwPXSs62WY0qNLr6@boqun-archlinux>
 <87sesxa5i0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sesxa5i0.fsf@kernel.org>

On Tue, Oct 15, 2024 at 02:57:11PM +0200, Andreas Hindborg wrote:
> Boqun Feng <boqun.feng@gmail.com> writes:
> 
> > On Sat, Oct 05, 2024 at 02:19:38PM -0400, Lyude Paul wrote:
> >> On Fri, 2024-10-04 at 14:48 -0400, Lyude Paul wrote:
> >> > 
> >> > FWIW: I agree we want things to map C closely wherever we can, but part of the
> >> > reason of having rust in the kernel at all is to take advantage of the
> >> > features it provides us that aren't in C - so there's always going to be
> >> > differences in some places. This being said though, I'm more then happy to
> >> > minimize those as much as possible and explore ways to figure out how to make
> >> > it so that correctly using these interfaces is as obvious and not-error prone
> >> > as possible. The last thing I want is to encourage bad patterns in drivers
> >> > that maintainers have to deal with the headaches of for ages to come,
> >> > especially when rust should be able to help with this as opposed to harm :).
> >> 
> >> I was thinking about this a bit more today and I realized I might actually
> >> have a better solution that I think would actually map a lot closer to the C
> >> primitives and I feel a bit silly it didn't occur to me before.
> >> 
> >> What if instead of with_interrupts_disabled, we extended Lock so that types
> >> like SpinLockIrq that require a context like IrqDisabled can require the use
> >> of two new methods:
> >> 
> >> * first_lock<R>(&self, cb: impl for<'a> FnOnce(Guard<'a, T, B>, B::Context<'a>) -> R) -> R
> >
> > I think you really want to use a `&mut T` instead of `Guard<'a, T, B>`,
> > otherwise people can do:
> >
> > 	let g = lock1.first_lock(|guard, _ctx| { guard });
> > 	// here the lock is held, but the interrupts might be enabled.
> 
> Is it impossible to limit the lifetime of the guard such that it cannot
> be returned from `first_lock`?
> 

I was wrong saying the original doesn't work, because it has a
`for<'a>`, that means `'a` is lifetime of the closure, which cannot
outlive the return value `R`. So this signature might be valid.

Regards,
Boqun

> BR Andreas
> 

