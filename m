Return-Path: <linux-kernel+bounces-556982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F13EFA5D1D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891A2189A6A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80385264A99;
	Tue, 11 Mar 2025 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBx/PxEY"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41563229B01;
	Tue, 11 Mar 2025 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729259; cv=none; b=TRpQ/79Y+7QZg25419yBHEgD9AmHS7Cef5+KFoiWVytd5dgqtSBmCBbVyYMqGxcu3L6WP42PbaTQVcmy7i5EePRxR9CYvaJDXTri6DVCViUiTTSIA4mO6M/fRhrjEknHeQhq0+H/dI9WVizXGwO6IWlON+wpLTKACMiGMI/OEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729259; c=relaxed/simple;
	bh=mBCt5DVViGyr6F53dITbXU3RR+SpY0NSXUE/e52XkOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThxPayxwjZYJjO+pLfXK8rb15QSR6xAHu5Q8mlhPYA222g1hejMYClzY+eeABtvsW5WIXYIIQSc4ofhFbEI5xMJ5Of/hhEEE2IRP5hiloWGRy7tiLixFu0KmSrxP7vIB23nEuV0/MNkk4XxHuuxIuVdwSKUvG1APYlSXLr3gf4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBx/PxEY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c554d7dc2aso387531285a.3;
        Tue, 11 Mar 2025 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741729257; x=1742334057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPL9VhcAgHullg/5Xk9/yS9RHHTCQXF4RVuf70Be3R8=;
        b=VBx/PxEYVFYtWPeM1TA/7ELC4XeSozdMEugWcH8ZYE0B2kYLwJpOPtMaUlsaYHyk76
         Q6OydZdiFd2P6ILf8HatCOpvXgCVJEYpTWfr0szo06zMya6VSKv83YEc6ue49yEuJtqB
         wjW77CKRZqIdOZQMfxxSdcWzia6A2oj9i7MGjj6CkDLv9ZJ9ijbB0Tywv8XlxDBLwSZk
         aBHFzKjCG+mdmbac/mDnJA3zydRmZC8U7u87XSX9qMHHETqq7ZlhXEOhZtDcbKHKJL3s
         MPzf+z2AAlPoNMjH47LtpL08ZQKdJ8XT4qc0KBhuT8C6LxNTWdVMNiglBelz/QtBUuFs
         Jndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729257; x=1742334057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPL9VhcAgHullg/5Xk9/yS9RHHTCQXF4RVuf70Be3R8=;
        b=KzoX+ZqWK5ZqNaKoMDYWKu5B59ye0dBkSuN+iVLamHGoQlR1jmVmpLjcRBeEIHyrsM
         hv6jJwXJAZ5SWzdo9CN2W2T/+eLCrR7++LSoNuCwZxqpQ1QrxTt/WXpJiNGm8tvNda4B
         hXo3Q2rwqNG7Z9XkatL/lubKY8U3M6m9D3KaT1Ep0uwgYYKXNsME+Ge23N4i/kmtdcNC
         0JB+68JhrEtgkr5DNhxGWBqwNRgawsjW3SW3gcemQfZoOLiH8LG7QdvjqhJG2SkAcBN2
         0Z3ijk6NtQYUL/q2+GINns97Q9HcCj6D+hkfeDnoXJ7LfSPEr/ZnOQss6qPI46woz9Lr
         d5gA==
X-Forwarded-Encrypted: i=1; AJvYcCWz1mMaz4+FczN9N19ftwr4U5qs3t7DY+ocMwiiUdcKUQtClulYhEkVi7I56L4DAt2x/jW4MGyptIK8h4QJ3eU=@vger.kernel.org, AJvYcCXWtJphXJS5pmqAzg+DbYorYBeg9qamfrnISt3inGAT2/hmxdM+xUYmuVdRplc5c7QAiRqf8wyODy5Z+1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhue60QfztYsMQhmLZ/pFPnZP8ml6fEXbMMuyeuVu87fdcU3T3
	9BE1mj5oyH278o4ny7mt4EV3gRWh+z0p9oKCoZm+oQF4Sae5skp6Sdez1Q==
X-Gm-Gg: ASbGncva0Uh08nTr76x/COA+whx0QugcHEFAATU00Vwkb6BEwtOb5yVNiEVGa6q51+B
	NjU02+oZKlwdxXs7CMFlOq5sRRO2Xo/GlSf7FWYa3GdqZGFqPyJQXx70YqkP5KoKSMsvNdarvV5
	lUKcuwbm0MavCsfes/PiQTNXQqKWHCDlMrdVVjiHSb+qrPgPCoaOn1lsYg+Mfm7Y1ymX3VzFvcc
	PV446WZxmIpJm03I9ua2JsHrm9PT+mB+xfFN5DfyRm6s9S0oS9JMQ01yI/ZDRPOISaNe1z+HGdA
	fFXM2G6hgmx6ucbTK4+reN+mPBhKCFU/OR/8peL/QnsM2ZiAqDNReb49IDT+wy/1E/2h+IizLMh
	xl5XikGIJePvFP0mAL2yIdQHg3PImIoUs/o4=
X-Google-Smtp-Source: AGHT+IH7sWpdFXJE2oF/yEeiqNpVVm8YnEgrqfufAMXAENIUzZfwvQSPn5c0TBE01Wz9/GFbrekLog==
X-Received: by 2002:a05:620a:8018:b0:7c5:4c49:769c with SMTP id af79cd13be357-7c54c4981f5mr1840233285a.6.1741729257063;
        Tue, 11 Mar 2025 14:40:57 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f71727d1sm76488426d6.117.2025.03.11.14.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 14:40:56 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 09AE61200043;
	Tue, 11 Mar 2025 17:40:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 11 Mar 2025 17:40:56 -0400
X-ME-Sender: <xms:563QZyIRNHwSUL2t0WWB-c18Nb4s-U9N9oVjzWkktLwVMXmBbHl3zQ>
    <xme:563QZ6Lz3TgvYHEiu5B9ZVcoQ4bB2GsaPZPP97EoL0Z-rjTzB2RmnrPlhV8JMkLd5
    J4EM4NxWekNQp0nfQ>
X-ME-Received: <xmr:563QZyugHKxY2pz09g3oFLz7Pqu63Or_WwIoN77C7bXB-oiNsiJ1pKrNbKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprggs
    ughivghlrdhjrghnuhhlghhuvgesghhmrghilhdrtghomhdprhgtphhtthhopehruhhsth
    dqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegu
    rghnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhope
    gurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghinhdrmhhurhhphhih
    segrrhhmrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghl
    vgigrdhgrgihnhhorhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:563QZ3ZAnjYSrDtnbxhuQ_vRTe1DGIxPxzgKdnrvtkPrzcfg6k8JYQ>
    <xmx:563QZ5Y6V2w4ScQOD-GFDIoXh3Cm_hXcfyoOdQsPgNRlTGkkYdF3_w>
    <xmx:563QZzBS9RbtZPnScNLKm4HW7Kla_OYa_nbxV0uCYVTyaDmCwOiycg>
    <xmx:563QZ_avKAXo8diV-k_gcc8iZeBNYFbtMCObLdtJlKID-g-SS1b5gw>
    <xmx:563QZ5q84lN5eZ203ZovN5f0b4J3BNPd16YvTKRmfWjU91zsA5_jPtTx>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 17:40:55 -0400 (EDT)
Date: Tue, 11 Mar 2025 14:39:32 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v14 02/11] rust: add dma coherent allocator abstraction.
Message-ID: <Z9CtlJTrWchPKuIJ@boqun-archlinux>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-3-abdiel.janulgue@gmail.com>
 <Z9B9CNRatBtyAO8Q@boqun-archlinux>
 <D8DRCM2FOEBN.3IVEVKW9A65AL@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8DRCM2FOEBN.3IVEVKW9A65AL@proton.me>

On Tue, Mar 11, 2025 at 09:34:19PM +0000, Benno Lossin wrote:
> On Tue Mar 11, 2025 at 7:12 PM CET, Boqun Feng wrote:
> > On Tue, Mar 11, 2025 at 07:47:58PM +0200, Abdiel Janulgue wrote:
> > [...]
> >> +    /// Reads the value of `field` and ensures that its type is [`FromBytes`].
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// This must be called from the [`dma_read`] macro which ensures that the `field` pointer is
> >> +    /// validated beforehand.
> >> +    ///
> >> +    /// Public but hidden since it should only be used from [`dma_read`] macro.
> >> +    #[doc(hidden)]
> >> +    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
> >> +        // SAFETY: By the safety requirements field is valid.
> >> +        unsafe { field.read_volatile() }
> >
> > I agree with Andreas that we should document the exception of usage on
> > {read,write}_volatile() here. How about:
> >
> > When dealing with a potential race from a hardware or code outside
> > kernel (e.g. user-space program), we need that read and write on a valid
> > memory are not UBs. Currently {read,write}_volatile() are used for this,
> 
> I would use the singular `UB` here and below.
> 
> > and the rationale behind is that they should generate the same code as
> > READ_ONCE() and WRITE_ONCE() which kernel already relies on to avoid UBs
> 
> s/kernel/the kernel/
> 
> > on data races. Note that the usage of {read,write}_volatile() is limited
> > to this particular case, they cannot be used to emit the UBs caused by
> 
> s/emit/prevent/
> 

These above all looks reasonable to me.

> > racing between two kernel functions nor do they provide atomicity.
> >
> > Thoughts? One problem is that I don't know where to put this document
> > :-( Any suggestion?
> 
> I am a bit out of the loop on this one, but why not put into the safety
> comment? I.e. explicitly state that this is *not* sound as per the usual
> rules and it is a special exception?
> 

We may end up with multiple uses of {read,write}_volatile(), and IIUC,
Andreas wanted [1] some clear documentation on this. Also if we have
some document it'll be easier to sync with Rust language people on the
"rules" we following in the kernel.

[1]: https://lore.kernel.org/lkml/87mse2hrd8.fsf@kernel.org/

Regards,
Boqun

