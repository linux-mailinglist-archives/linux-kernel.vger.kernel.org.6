Return-Path: <linux-kernel+bounces-527483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C72A40BB7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 22:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AAE189EFA7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264AB204C24;
	Sat, 22 Feb 2025 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmIdt5iK"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0DD20468D;
	Sat, 22 Feb 2025 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740259583; cv=none; b=mvxKjjacMytpckcriM8e+HbLUuy8AkGpXTjT7NAI672AyEwr0QjirC9z7UjTQTxBeLFcvxa01oNDX/DCeLn+dX3Nr3axewqmtdYAym3jUtYi6q5/85IslvmbYjjFCL7D2giTSTLqMgZIDJQ9DkMHwn8xQxXKkQah9c/DXzOzxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740259583; c=relaxed/simple;
	bh=cqEf+aQvCd21+lVXTtNOyHA4FiqVkg85I2UEZ1HyaqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akUrSQx5bhyecWgjAUWrUF2tJ3xMaIVHLzCuZTiCHmjJa87qFToGvSyRZR4uIB05vdRP2NnFv2vJAp95Ecw83yk3KJlPD9SHThcnsauqp5n/0omwhggNiVh9K80jojUQXAMaA+KH7nttHBeEXIU8Ye/zw4iMnaglZhAMNFRwSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmIdt5iK; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c07cd527e4so306267185a.3;
        Sat, 22 Feb 2025 13:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740259580; x=1740864380; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0yhDnARrBdVqwowHBLWajQ+jKlgWjbT7txKq6E4c1n8=;
        b=DmIdt5iKtufiY6xETnja3aWruo5omPEOP4pPXPcybSuvImWMr7l5wdwodPo0U677N9
         7+OnMoZoSr2vPMczwrrbo65YUA+RYWlAc5QHyVfzTLdsVwlYl5N5Fb6nAyuhsn0/pQGV
         ATZWzh9OI2K3Zpk/+02RU6imzi5WgMkbzOCqwsai+phQ3J+pAo9D0LExcxQbMx2Y6SmI
         DHKYgqW3A/5+Oaxa4CBC77lX4Opd4UaHfuvUPl/3nGCQRP0jryDBDgJSd/faQrDUWzpi
         Tzjf2gsQt4eWryQT4XHn+cimSvtvJjahof/be5EtWH+O9J3q7DWVpwW8VbtoKs6iqADO
         NXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740259580; x=1740864380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yhDnARrBdVqwowHBLWajQ+jKlgWjbT7txKq6E4c1n8=;
        b=foa51ZN4k8KGgHRICC06Jpgd9KnFMGYzaolZ1wy4QG8PZRAz+drKOEV8mm/Sj23gNo
         DNiQL52WYvE2RJQlnXK6tyCVviTMXWnWEExWhr1Qi87efanQ7EYkg1pi5sIZia2eAFEb
         DPuDoJzSEfLDE/QE8oYMPyPqWzirXo5We1ydTpjHnF5rZZDsYKB+8PXSH6MFM6GfOVMK
         thMPw3PGZKY9aBrgt4Uc3hBjF3Jx1Tf/aLnrR+BSz0BL9wgxu1A8McRp83eFZXoZ6pzz
         NdWQdHqMSxRgOLEhbaHhQBrcTSKfWl0ogeDVFqu6rywI6/qG4xO3xAsZktlxN+hob3DM
         8CQw==
X-Forwarded-Encrypted: i=1; AJvYcCVFQF5XA17W6inRrjd6IpqWNmphV7u48nI3Su4DlmX/L5DPhaOPoJb8DV0N3zN7SuON5f5SmxE6Yts0ZLZHCP8=@vger.kernel.org, AJvYcCVr8HroozwYfFAozPiQHdTf/iNHQxsBOd15wv8aoWaIIPEPMe1ZbJIIphv+ZVNZDWi753dVA29SQJg/c0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZPz9C91exeZIPx1GoaVEDRnER8MYiW5j0JPl+JDvFrFajTqu
	Pu3F806HBx3razDOYLGTULjPgl1uSbWgTzo1f3BC4EE+9p9blu5Q
X-Gm-Gg: ASbGncuCQw8hOjsslzZHGdXuClQlI771M1EgIySemoOWybp0W9Wdl6X4xosPB2+KasB
	TcS63NdqtNbOytBsCpU8Hp/K/VtdQ/k/XgO5/34Y1JOr4NLTc23pS+Pgfuu8497/43B5LT4bwex
	M/mg7vIa199oVXYpmL9tPP2CpdmuE8ddJsrCf+yeJ3lhEQeMM2blHvq2onwex9oll1k/KHjY+Mq
	u0euY9rdzscAjEO9CszP8pWwfJPHRiZRiZGxH1y+8Obg7nHkCRT1sYeaYxIw/HgrA8o5Iu0fZFL
	fQksq+sgrGOhM+vtLxWqmN1HB5a/pDeE/OyGdAs0qsVSTkiA6IpqWi6+/Rv4KMlifnqq/iETZ3q
	SM7EEk0cCyPIIc0ld
X-Google-Smtp-Source: AGHT+IGVGTHfLEg+mckIv5sJYQeZvhy+BiBIC5AirMgVAY0yuRgym4DzxeJ639TCzHVdvxQe4qoeqw==
X-Received: by 2002:a05:6214:f61:b0:6e1:f40c:b558 with SMTP id 6a1803df08f44-6e6ae9a1285mr91214886d6.44.1740259580302;
        Sat, 22 Feb 2025 13:26:20 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7848ebsm114317086d6.32.2025.02.22.13.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 13:26:19 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 406571200066;
	Sat, 22 Feb 2025 16:26:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 22 Feb 2025 16:26:19 -0500
X-ME-Sender: <xms:-0C6ZzCMcuXkp9sBenTi-a26abNcnJg_xyzPRVOiNwy-0zemUFhcjw>
    <xme:-0C6Z5js7r_FdYnPy879sRxndMHkqpLCUGjLME5bEj5Dk_red--8QNcxJvvcX1Wdu
    RNTZeUWcb2EYuf1yw>
X-ME-Received: <xmr:-0C6Z-mky0Qmg84Tnei3X5B0fN_pslO29RVElpsLgzPCHXtLtvg3na5-WL0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejgedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeeugeefvedvieejkeeludehgfehvdejtdej
    fffftddtffefgeelleethedvudejvdenucffohhmrghinhepiihulhhiphgthhgrthdrtg
    homhdprhhushhtqdhlrghnghdrohhrghdpohhpvghnqdhsthgurdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprgdr
    hhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtrghmihhrugesgh
    hmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrnhhnrgdqmhgrrhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtth
    hopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehl
    ihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghgrrhihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:-0C6Z1z5jZqy9fsPdyN0g8XnHQAMhLz3QKYDm4Qqs4jdHGGOFJVn0g>
    <xmx:-0C6Z4SYj0H7F8haFfsxKbTinSDL07vLNx71--kMdqTA6pyYe06RwQ>
    <xmx:-0C6Z4YkwX9xllKaYBEkHJ0Ywoa1v6MVbzb2EIIZgHHWoVra_UQuFg>
    <xmx:-0C6Z5SCMj4zMS3JIdpSR35tRMdaOQ8jXBBAOTE3fYupXBofNBdvNw>
    <xmx:-0C6Z-Bd8523-TNttsod7k8_QgOtJvsP21AUpYQzqBz9u7KsLESYZNLA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Feb 2025 16:26:18 -0500 (EST)
Date: Sat, 22 Feb 2025 13:25:46 -0800
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
Message-ID: <Z7pA2rnb3a892r1S@boqun-archlinux>
References: <djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
 <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
 <87ldtzhexi.fsf@kernel.org>
 <87cyfbe89x.fsf@kernel.org>
 <Z7iQcDa72XnJ5zGC@Mac.home>
 <CAJ-ks9kQccoa7znFNzWAgi6_G0TKvLUARWPZ_Dbed1C-d4Lr+Q@mail.gmail.com>
 <lP-bWmvvDdcUDicFow-u6piINSeNk1_a_BWKDDFMbFpE3Mo_5lxqfpA6v_8yYqTXNDmVZLXyz6RY3cQHhMoVrA==@protonmail.internalid>
 <Z7iZevQkYVGDoeTa@Mac.home>
 <87y0xycowa.fsf@kernel.org>
 <87h64mcimw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h64mcimw.fsf@kernel.org>

(we had some discussion on zulip: 

	https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Timer.20support/near/501291973

, replying to restate what I've said for list discussion)

On Sat, Feb 22, 2025 at 12:40:23PM +0100, Andreas Hindborg wrote:
> Andreas Hindborg <a.hindborg@kernel.org> writes:
> 
> > "Boqun Feng" <boqun.feng@gmail.com> writes:
> >
> >> On Fri, Feb 21, 2025 at 09:46:08AM -0500, Tamir Duberstein wrote:
> >>> On Fri, Feb 21, 2025 at 9:40 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>> >
> >>> > Hmm... if you mean:
> >>> >
> >>> > trait HasHrTimer {
> >>> >     unsafe fn start(&self, expires: Ktime) {
> >>> >         ...
> >>> >     }
> >>> > }
> >>> >
> >>> > Then it'll be problematic because the pointer derived from `&self`
> >>> > doesn't have write provenance, therefore in a timer callback, the
> >>> > pointer cannot be used for write, which means for example you cannot
> >>> > convert the pointer back into a `Pin<Box<HasTimer>>`.
> >>> >
> >>> > To answer Tamir's question, pointers are heavily used here because we
> >>> > need to preserve the provenance.
> >>>
> >>> Wouldn't the natural implication be that &mut self is needed? Maybe
> >>
> >> For an `Arc<HasTimer>`, you cannot get `&mut self`.
> >>
> >>> you can help me understand why pointers can express a contract that
> >>> references can't?
> >>
> >> I assume you already know what a pointer provenance is?
> >>
> >> 	http://doc.rust-lang.org/std/ptr/index.html#provenance
> >>
> >> Passing a pointer (including offset operation on it) preserves the
> >> provenance (determined as derive time), however, deriving a pointer from
> >> a reference gives the pointer a provenance based on the reference type.
> >> For example, let's say we have an `Arc<i32>` and a clone:
> >>
> >> 	let arc = Arc::new(42);
> >> 	let clone = arc.clone();
> >>
> >> you can obviously do a into_raw() + from_raw() pair:
> >>
> >> 	let ptr = Arc::into_raw(arc);
> >> 	let arc = unsafe { Arc::from_raw(arc) };
> >>
> >> however, if you create a reference based on `Arc::into_raw()`, and then
> >> derive a pointer from that, you change the provenance,
> >
> > In this case, the pointer will have the pointer of `Arc::into_raw()`
> > will have the provenance of the original reference. When you turn that
> > pointer back into a reference, won't the reference inherit the
> > provenance of the pointer, which is the same as the original reference?

If the reference is an immutable one, then it won't have the write
provenance, and if the reference is only to the `Timer` field, it won't
have the provenance for the whole `HasHrTimer` struct.

> >
> > As I read the docs, getting a reference to a `Timer` from a reference to
> > a `<MyType as HasHrTimer>` by converting `&MyType` to a `*const MyType`,
> > doing a `ptr.cast::<u8>().add(offset).cast::<HrTimer<T>>()` and
> > converting that pointer to a reference should be fine? The final pointer
> > before converting back to a reference will still have provenance of the
> > original reference. Converting to a reference at the end will shrink the
> > provenance, but it is still fine.
> >
> > Going from a `&HrTimer<T>` to a `&T` is a problem, because that would
> > require offset outside spatial permission of pointer provenance, and it
> > would require increasing the size of the spatial permission.
> >
> > Is this correctly understood?

Right. Also in this case, since eventually, we need to convert to a
`Arc<T>`, the pointer from `&HrTimer` or `&T` doesn't work because write
provenance is required.

> 
> How does provenance work across language boundaries? Should we actually
> use `with_addr` [1] when we get pointers from C round trips?
> 

I would suggest we assume that C can pass the provenance via pointers,
that is, if we pass a pointer value to C and eventually get it back from
C, we should treat it as having the same provenance. The rationale is 1)
considering LTO, C may also have the same or similar provenance model
(e.g [1]), and 2) the C part may get rewritten into Rust in the future,
the correctness about provenance should not be changed by that
possibility. `with_addr()` is not necessary then, because pointers
should have the proper provenance when it passes Rust/C boundary.

[1]: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3005.pdf

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 
> 
> 
> [1] https://doc.rust-lang.org/stable/std/primitive.pointer.html#method.with_addr
> 

