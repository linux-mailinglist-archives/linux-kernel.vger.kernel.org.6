Return-Path: <linux-kernel+bounces-529771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C444A42ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F079C3B66B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B620B26560B;
	Mon, 24 Feb 2025 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyM+P3nl"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE817BAEC;
	Mon, 24 Feb 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420600; cv=none; b=j225kSe33pORxEc1/YwSuimhtcgIdPCZLrvdMqTTfyPMBAkk1aXSuJxKw8YOuPAMJrkhQt1PaI6RsGJVbSkvEDKR4wLGMqf2sKdFJ4oaxnTs3Z7c/cUryZHJHUR46MDEM3IMGeZyxYeDMJvoJ58ppgBoNBjL1OvsKpz3s4bjTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420600; c=relaxed/simple;
	bh=gU/CvK4LTvvfzt5OL3/XHB79eCswcfCi/MwYgtvXhAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBf3hgqxuWVoX/husmwEZrUYfRJDjPKCpl8/Yb3dIV0p6dbukp/U8/oYM5eoiss6rxAMdpSyelO4TstPNJRg/lDY2Cwrm+k+0zUYKtpQKBLz6MF3F75dzshWmCh2EjsjY7ItRUy5Ogi0pws95QwkX5IUaYhByY58Rcmyv37bKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyM+P3nl; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6dd1962a75bso37060526d6.3;
        Mon, 24 Feb 2025 10:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740420597; x=1741025397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5REyHtGy5MsWEghLjl4rKd5uHvNMAxs6Ggs15MzzX90=;
        b=DyM+P3nlcu13f73ajYoE8s+dvvvyGrOoEun6u/dBfNUdChMkoCr1nV9Ew9zG9xBmH9
         VENAHMW57O3f8+Ibt7ij69x4GlLd5cmXXb4Uf3HWhmASOIXYQSCMKowVezzAhczuLrbC
         Fq2L78eu5qx0Hiheqf2kbCFfRFeY9PgAxAt/tN46J6L0cdDmTFF4dpUSwX6xG8Lhdx+O
         XOii7zpG2Yd80N4C8o0uWR1YowJcFzYqV7Csa0hfvl9wAazGiWf3mH9n2IB+LAHrYuML
         s0Z8hQnIGdoo6GPy3hxmyxNgkSIuVjC6PqFuFhbyrP9z23HDLmmbVU4IwFlyXATSo7bn
         fI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420597; x=1741025397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5REyHtGy5MsWEghLjl4rKd5uHvNMAxs6Ggs15MzzX90=;
        b=aRxSKiSrSQegn3A7jFaa4aCuelPjRLKa9O9d5a3IHQLK1VtQBNjKE6UgwrAPetZKsl
         H2N/gVmmEivoKqeWEFYDGEPof2atTi3EeQSxWdqfwsBIfTjeeIOHVAbFJQcBthc1GDGk
         t1OtmYe7+piPhY2MzBjFdwfcp8BGSSmMiJAq0tTVKjbw6PaveRCpknmvYjiAcLEvbHRE
         wYdpcoysA3Leo1MqPLFtvlUea7q1kd//rvdfcYh+K2TTLugM3TVTBbmGLyZ29JGXhgiM
         A7Myuwxdd0ohWSjm4/+sXRXoDfDHKXly52HcJlyw14+duiZSyVagfdLB+IfrapWWZZoP
         w3CA==
X-Forwarded-Encrypted: i=1; AJvYcCWxm1XaQLkAmzzeTJ3MglpZNRiVxPtVVhKs81Y7n0Hj7rn59jmLeff8YLXch/2865shel2a+0oKloakAmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUsRXyBS9/lYtwYsF9oamt7x/w0nDs/pbrVEWdJ+n5XSsWUPs6
	dzyjHzN5vaBKs42Tdi+0lubdfWKv03J/aEZCugkXFXLWfBGS0hoi
X-Gm-Gg: ASbGncugsnPRKgitJa9TYuGRUuKN6rpHY0QEU/ONU51zd/j6CGKJ+/8IQOgk6RSbXk1
	nceu9T0oefx6qkBhc2xxm0KyM6BQ/0kboijYg3SpJaCXFkZknI4N6gILouL2HbOkz8W/g+K7RPA
	wpin/U7cwUCkOhuP5q1KKu136Qy5y650E2rAp85TczRUpCZUW42XBR2O3qd2CRQ3QpSCIhY2inW
	p1eoQD9ZUM3Qkvh38em3tcYiEafJcuJx+WuYPwfbAhYSlwwZO5x+Nm49sBX5Jl5x4vWUrgv8hk7
	QXB5vER6AtbZqYVAgXiY2nWa9nSeApReOEjSUipo3nqAX7iaJnbu2uwkCQ+eRcSVlDmRKlo6fFP
	qJ0kBAlwHazDpBiU1
X-Google-Smtp-Source: AGHT+IF8fmg4I+B8rEkpCzJ9vZrzmfrPoPS7NxmAcijA8z9J02igDc/sMh0QE8yYMXtrJcly3KuVbg==
X-Received: by 2002:a05:6214:230e:b0:6e6:5efa:4dfa with SMTP id 6a1803df08f44-6e6b010d162mr218039686d6.21.1740420597220;
        Mon, 24 Feb 2025 10:09:57 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e6b1759af6sm45083216d6.93.2025.02.24.10.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:09:56 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 285C01200068;
	Mon, 24 Feb 2025 13:09:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 24 Feb 2025 13:09:56 -0500
X-ME-Sender: <xms:9LW8Z3v4khZ874NcNBmIIVm-GOYNs4Z60AyCMFOZiqVpdom6m8MfOg>
    <xme:9LW8Z4dqLKvuBkw0Oljzf7Q5ABsBzq5Wnu_u1siNVw4QXG5labOv66PJ2_fOCZzLN
    XvRnbCSGKM1eLtNJQ>
X-ME-Received: <xmr:9LW8Z6z9cgefCXi9SweXhp4JtiHtQuU081-586KjchNlH8OmFq971qu33p4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrmhiirghmrghhfhhoohiisehlihhnuh
    igrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhn
    uhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhjsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjihgrnhhgshhhrghnlhgrihesghhmrghilhdrtghomhdp
    rhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgi
    drghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihg
    uhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:9LW8Z2P2UcOGPZF1fv6VVdHbI3bQhNG2tHFSkFj-Jda1y40JNfrgbA>
    <xmx:9LW8Z3-eygbY6aDUy991ql--SViGlzLdLQgE4ES7SoYqrYCGHnotsg>
    <xmx:9LW8Z2Uypq6enlIKURQtqg1vecHYfsosILMcdA1wadLBhce5IfSOzg>
    <xmx:9LW8Z4fEwyvetslMAn3kE3KeDFib9nu5XysSSCxeuuWkmSCFtxjuJw>
    <xmx:9LW8Z1fEEMzpxYNOnco5UHe17XoqEMjrT2pWO-uAAlQZT70tdKOdWgc0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 13:09:55 -0500 (EST)
Date: Mon, 24 Feb 2025 10:09:17 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Konstantin Andrikopoulos <kernel@mandragore.io>,
	Danilo Krummrich <dakr@kernel.org>,
	Roland Xu <mu001999@outlook.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: workqueue: define built-in bh queues
Message-ID: <Z7y1zZTi3UQzsvQh@boqun-archlinux>
References: <20250224142326.38396-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224142326.38396-1-hamzamahfooz@linux.microsoft.com>

Hi Hamza,

On Mon, Feb 24, 2025 at 09:23:23AM -0500, Hamza Mahfooz wrote:
> Provide safe getters to the system bh work queues. They will be used
> to reimplement the Hyper-V VMBus in rust.
> 
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
> v2: make the commit message suck less.
> ---
>  rust/kernel/workqueue.rs | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

while you're at it, could you also add some usage of system_bh() in the
example at around line 77 in workqueue.rs? It could demonstrate the
usage and generate unit tests. Thanks!

Regards,
Boqun

> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 0cd100d2aefb..68ce70d94f2d 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -703,3 +703,21 @@ pub fn system_freezable_power_efficient() -> &'static Queue {
>      // SAFETY: `system_freezable_power_efficient_wq` is a C global, always available.
>      unsafe { Queue::from_raw(bindings::system_freezable_power_efficient_wq) }
>  }
> +
> +/// Returns the system bottom halves work queue (`system_bh_wq`).
> +///
> +/// It is similar to the one returned by [`system`] but for work items which
> +/// need to run from a softirq context.
> +pub fn system_bh() -> &'static Queue {
> +    // SAFETY: `system_bh_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_bh_wq) }
> +}
> +
> +/// Returns the system bottom halves high-priority work queue (`system_bh_highpri_wq`).
> +///
> +/// It is similar to the one returned by [`system_bh`] but for work items which
> +/// require higher scheduling priority.
> +pub fn system_bh_highpri() -> &'static Queue {
> +    // SAFETY: `system_bh_highpri_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_bh_highpri_wq) }
> +}
> -- 
> 2.47.1
> 

