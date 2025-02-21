Return-Path: <linux-kernel+bounces-525934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD5EA3F784
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDAF37ACB86
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A509E204C00;
	Fri, 21 Feb 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0LQGyqS"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E520E019;
	Fri, 21 Feb 2025 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148854; cv=none; b=emclvoINqh34O7NJvD3QQvFqnvjuQ3jicegZVRWRPpwsCkM0PMawYV46EDykIPimOEBV9OcKmbWQCVByn7vKWbtpUivi8xcH+W56Zh2HKa5BfVGTlg+8iOKMzZ+dr1CPMccWIIQoENZB0gEeNOHa1DEecC6gwXhw1GLiK/tFmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148854; c=relaxed/simple;
	bh=gBM4rGXKwM89b3laHdm7cDSoxEtTcxFIJAghFfojcAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfhz+RtziFFraTBetuaVCZUfR91azHBlWH3VKfWwGNTD0ralaKU7dJl8rs4D4hMmiAfNcdk+Kdke1gVlmGKHgRHwcGgcO8In7IiECVdR3ZaKXcLD29QqM9sSYlEBTu+W6mXZGP5Mt33RuGdoep6lCELflPcylg9S2VpK70KY1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0LQGyqS; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c081915cf3so268820885a.1;
        Fri, 21 Feb 2025 06:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740148852; x=1740753652; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CjtIIzpG75Cs6V+/u982+t1SIkzgoATVSwfDxiXNI8g=;
        b=f0LQGyqSJrDQN5sJBzq6++KuOIsr97m8a8JG72TVLLfmRr+hOGLDRQMHVOW3HfPmxL
         z4O1fY6kp2X3Q5pYu2UhLTenOIgYoyHiCyh++ri4XjWXFWMz2PcQ/nmjJHpyaeQZyXtg
         CNUjcXyp9Oe4Z3AwRg/G8AAZIqW5r5ea9rYGduXH5RMchCTLl7VPyfy7WNpZRwJ/5PzY
         ovp/PWJ6+3l2094KLumnQO9oG+zIlfHypeAk5FHV0W7MdxnJ49EZ9dWpecNeR6kyNYTM
         JIHS8UPDyum7Hd1nNjkJpw1jxKK+9sLYrQJQNj6GaLpbHQLLQGqOavw1VUL1esayFoPc
         x3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740148852; x=1740753652;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjtIIzpG75Cs6V+/u982+t1SIkzgoATVSwfDxiXNI8g=;
        b=dTSygLe0WKXiBfL4rp+v7+Z8AtNmjLlnggkEp5nS64Jvn5jgY57OrZS9D6XX8aVt0u
         CloCm0pakAZVYC2mHNJc1Fymyo8VzYrDYnMCeYt3hNILBb4fgM6ZN2oHmeP9QVG8T9kF
         zQkf/xXyLP2UT0O2Zm4tKajD9deg5OGAW+oXteWMu9btpiqK/GjTKrABTLV7EM1K8TvR
         JzDVbBJZQazfMjbsEMLDO2cr5g79z/a91nRImGnG4/YUnotwBGecePnjdMR3MWsb3ijr
         jriEjWXrmKnbWmnSTMwH2UYJEGw0YoSG6TLheN0w+QSqeesJGgkdtUYGuPb6LqCdXj2f
         xXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxOM7TwOtYshyQ5S2NifIw1x0YAxdfLzUPVOYsFLL6KR65+l2T7lzNVrSS1an4gshhqohUVCWgILuqch8=@vger.kernel.org, AJvYcCXr0WCdVzQcyHPa5eNIZeOzjHsH3BOkWX6N4xb/csQF0ko9V6csTulPF3LNjhGEdu+IkvKmCiYDrJ3Zi+eXccY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4tSlLrWJ7X/bFplZOUzu+WQgO8ajTcoWjdeB8cJAztyFYLn9p
	ioeg2HZN2BuyAk04iRTLQGyXTvxSfDo2SYplPN8+l5etlu2E3Ouq
X-Gm-Gg: ASbGncsbRh453DREow7ftyFz9/sKy2ruSCu+5V9dHft7vSuizciRSmaHqLrDzB/pdbC
	z+uP8Y/7p2eVHeFCza9tYb2eKus0fzPeA2q/O6Mc9V75K9SFKXvrcQ22ATCU99+1EPhIjqLhhYM
	n0WspQVCw6p0IBcPn9z+9kXKNqzOoifhmxXteN0SIrhjWPxWgJoIfd/NkPzG/trxHMHw5Cl5sI1
	cdgxpzJ9LiWS3pfOpyDw9TeMoxClspoj3Ml7m/881IqQjXbe4NAjKlwfPsiaACTiPxeEP53pQKG
	Dzfb8d3ESWZ+7ydOyBtr4z6dNcWVXkIyWD/iV942Mm48e/+bU2XNXOy+SsIt1UfSmL/TNofcpgs
	99AklJw5UdUotbCAl
X-Google-Smtp-Source: AGHT+IHgIa3gQYxUS1R6ZA+i369MgVWXpoxvN/GC2K6v0xfX8o1A7USflNNc3bu/crqDA6U1GeJfUg==
X-Received: by 2002:a05:620a:4115:b0:7c0:c2ac:c09b with SMTP id af79cd13be357-7c0cef561f4mr386180985a.42.1740148852017;
        Fri, 21 Feb 2025 06:40:52 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0986fa1d0sm645565585a.26.2025.02.21.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:40:51 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id D74591200043;
	Fri, 21 Feb 2025 09:40:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Feb 2025 09:40:50 -0500
X-ME-Sender: <xms:cpC4ZyOk4R7mdF7fmCG9hi0Z_WE7QAFbuzQ3DItmFYOeYyxLVa0MQw>
    <xme:cpC4Zw9xxNET_rWR0yZUZxcYCdiNHjBtoRmqLMW52GU9xVN2iSPetWV1brLMTfbK2
    G2FDtlhLiSL45IhSQ>
X-ME-Received: <xmr:cpC4Z5T1awGmsVNfBXL0PhzbHw4uWvo-NGfnzhptIY7UhUK18w5wiQWdRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddtpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnnhgrqdhmrghrih
    grsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprh
    gtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhg
    rgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuoh
    drnhgvth
X-ME-Proxy: <xmx:cpC4Zyv07ZrLk7BR9QDWRQMpk9AZJAynbuOioQoq2Kp2dBwR2igPdw>
    <xmx:cpC4Z6dcl16nYINXoZKRaUfeDxSUR7Va5XNxjkr_Hd-DLMkzNZ4kAQ>
    <xmx:cpC4Z20ZiwA1NtSs8xRvhLzbLJ0H3VNroG-kyFOWsApzQmuG6hizDQ>
    <xmx:cpC4Z-9SK53xmBp9t7X3V0pjwS_MWtmkQLBEDCqvIhkzbedqCEOQ5g>
    <xmx:cpC4Z5_W-ZbKo4bJ1CLFFNqRTQJ2J7T8WNXAyTKZAo1lh89D3xFm4aTb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 09:40:49 -0500 (EST)
Date: Fri, 21 Feb 2025 06:40:48 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
Message-ID: <Z7iQcDa72XnJ5zGC@Mac.home>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
 <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
 <KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
 <CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
 <87wmdkgvr0.fsf@kernel.org>
 <djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
 <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
 <87ldtzhexi.fsf@kernel.org>
 <87cyfbe89x.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cyfbe89x.fsf@kernel.org>

On Fri, Feb 21, 2025 at 02:28:58PM +0100, Andreas Hindborg wrote:
> Andreas Hindborg <a.hindborg@kernel.org> writes:
> 
> > "Tamir Duberstein" <tamird@gmail.com> writes:
> >
> >> On Thu, Feb 20, 2025 at 4:19 PM Andreas Hindborg <a.hindborg@kernel.org> wrote:
> >>>
> >>> "Tamir Duberstein" <tamird@gmail.com> writes:
> >>>
> >>> > On Tue, Feb 18, 2025 at 8:29 AM Andreas Hindborg <a.hindborg@kernel.org> wrote:
> 
> [...]
> 
> >>> >> +    /// Get a pointer to the contained `bindings::hrtimer`.
> >>> >> +    ///
> >>> >> +    /// # Safety
> >>> >> +    ///
> >>> >> +    /// `ptr` must point to a live allocation of at least the size of `Self`.
> >>> >> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
> >>> >> +        // SAFETY: The field projection to `timer` does not go out of bounds,
> >>> >> +        // because the caller of this function promises that `ptr` points to an
> >>> >> +        // allocation of at least the size of `Self`.
> >>> >> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer)) }
> >>> >> +    }
> >>> >
> >>> > Can you help me understand why the various functions here operate on
> >>> > *const Self? I understand the need to obtain a C pointer to interact
> >>> > with bindings, but I don't understand why we're dealing in raw
> >>> > pointers to the abstraction rather than references.
> >>>
> >>> We cannot reference the `bindings::hrtimer` without wrapping it in
> >>> `Opaque`. This would be the primary reason. At other times, we cannot
> >>> produce references because we might not be able to prove that we satisfy
> >>> the safety requirements for turning a pointer into a reference. If we
> >>> are just doing offset arithmetic anyway, we don't need a reference.
> >>
> >> Why do we have a pointer, rather than a reference, to Self in the
> >> first place? I think this is the key thing I don't understand.
> >
> > Perhaps it makes more sense if you look at the context. One of the entry
> > points to `HrTimer::raw_get` is via `<ArcHrTimerHandle as
> > HrTimerHandle>::cancel`. This user facing method takes `&mut self`. The
> > handle contains an arc to a type that contains a `Timer` and implements
> > `HasHrTImer`. To get to the timer, we need to do pointer manipulation.
> > We only know how to get the `Timer` field via the `OFFSET`. The natural
> > return value from the offset operation is a raw pointer. Rather than
> > convert back to a reference, we stay in pointer land when we call
> > `HrTimer::raw_cancel`, because we need a pointer to the
> > `bindings::hrtimer` anyway, not a reference.
> 
> I changed `HasHrTimer::start` to take a reference, and I think that
> makes sense 👍 Taking an `impl AsRef` does not work out when `Self` is
> `Pin<&T>`. I'll go over the whole thing and see of other places could
> benefit.
> 

Hmm... if you mean:

trait HasHrTimer {
    unsafe fn start(&self, expires: Ktime) {
        ...
    }
}

Then it'll be problematic because the pointer derived from `&self`
doesn't have write provenance, therefore in a timer callback, the
pointer cannot be used for write, which means for example you cannot
convert the pointer back into a `Pin<Box<HasTimer>>`.

To answer Tamir's question, pointers are heavily used here because we
need to preserve the provenance.

Regards,
Boqun

> Best regards,
> Andreas Hindborg
> 
> 
> 

