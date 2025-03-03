Return-Path: <linux-kernel+bounces-542692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D66A4CC7B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B76817465F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230002356B1;
	Mon,  3 Mar 2025 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNgahwQW"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613851D8DEE;
	Mon,  3 Mar 2025 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032591; cv=none; b=Fw57J/KyOLhzuDwJutoFXcxi25m+AC/kLPV67XrhVQzArbhfyZmthgq/j13Vrcsa9JsG7brl1P6fTZ9KjsDbB///t1ptWkiFv0J1FIhyzq+EusR3wKcHSJK4Th7g7mZx5J+z5aJeWZUvrqCPbEhpM73EJ2rQBXKvEYSMF+u87Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032591; c=relaxed/simple;
	bh=ak0uLAYOdPdOsOHTGiLI6WF/evbmhtkJgkzO+RvCUSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb+b2dOTuf8dGMG5zDYd7IswG7JmzTWWcQ4a0BQFOBICFwhIYq9KWp6AGWptSqb6tpCaXBk1h7RilklieJaZiuz2hUnPqhhuUFv0h63ZFbCap7WNIP0UHBNS7oW1tI4XovclTjmgE7/4hsb+rDXisefKruQdsf7Jq6bytQYPE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNgahwQW; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-471fe5e0a80so45940651cf.1;
        Mon, 03 Mar 2025 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741032588; x=1741637388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=db22fiEi+hGGRsW4Uw3D7Qv3wZB3dOWlWmyWq/YDVS8=;
        b=ZNgahwQWIxkasdDcP9TyivCD4+6SUwBy+PQPBe9u9zSyjxOfcbx7j/2hX3HkvRNti+
         XpLHCIQfWS35p+uWDtIIDqkhcJhZqFkoWBy7GcesJfDAyWbAPpN1MIzAIjDNh/2nSuuS
         i/0yNrSX3Ps4vPbSzr2WUZLYIHwn5w9xF8Evs9Y7ERIswmMRZVnq0LVqkHMW2GyJTZHR
         Ns5+GLlTE8pcGgNO7gHOqUTasa2gj+wRkizw/9jF+p+l7M4Dk6k4jmBiWH6CU+y4/Ked
         BRWDr8G5kE9O4N8eJ0P98Ioh2XhfmBssE/IjAunnmzo59qQUzqc1VIfBJwO71QNDtPpn
         vk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741032588; x=1741637388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=db22fiEi+hGGRsW4Uw3D7Qv3wZB3dOWlWmyWq/YDVS8=;
        b=PZF7kcxWALfLHx6IrLjjukD8kCKCVwJu+rwNadfzdcwMAz8ZqedbNJJbtIpHXGV3qW
         ziVITkNhz3DAC7zJjPoNGtH92BsyyfSyR03tSJratBm771Nt6h17itKIR9Z6D+smfQMJ
         uJ4EluAqCK8SsQ/TWU2wjti+pCW/QRrB3TFmgakw8IhKCCnfbFTwrhmAGg4X3OxY5JsU
         XvmbQS9nw3C2CDrMPb/phOwJheomCMT8X5yV93w8RAgsOA+LgtSq9O3ElTajMX0ijL7S
         Bj5dBVWgCi+lBVfIthAiNgyQUe+qlYo77WiTWEHuYIEziL4MH55Ul5wOggjGU1kvSnTq
         d4rA==
X-Forwarded-Encrypted: i=1; AJvYcCVWW1pjGCP3W2c9is81WfnhvrsQ70mizyrKvw3Gcf61bhrseN8V7DDNz5prcfFbus90GQpOfh93uqFCDt8=@vger.kernel.org, AJvYcCXKNxWdKSH79yc8CTCq0LupTDFJZ4RyrUPbd1vML7efzkUdLO5CSPIRRytXJC+IyJxHXA9UMddXGWA84YxqXN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq9x/57MYwI99eNu29FdeuwPGZf4FLyyLz5Fq/s91JO1Ratojo
	3kWuX1tN3D5sNFvEogE2biS8M+/fY53YHWvO1VUSPvCfPHa75Sna
X-Gm-Gg: ASbGncuuxJ6mcKAXf/GlX5FBXRFMhJSPOzam/nGNDM89F7oJ3m0IuOkolnkcfQzLJWg
	wWYrDig6nQ3PPiQrE9OEucpogaXnRxmdc2auosuccj0DSTmlqVMAN5sTXsELnI2EgzcgXbfOaP5
	oNLpqRsbULTcf5kGhXw2JfDvn9lVdg7pAJ0Hr4xB+07KIBJckICUuhS2dUn1aTvhzlXEd9VjKNL
	qe8+4/V4+rJdPyMS+kfKNHja6lr/J8BHvGJl6d+e7GdnVrf+jXZn56QNf/FFABEp7xPm/Kpi/rU
	43wwMXqnpBWPVBCB1fjSW72wIIqIRh7NmGZoF5tYQHnqWx5ES0HiCIZp/divbv6HgX/DKNqDOXG
	CFlt5/f2ZONMmLVQkVAj9tfT6Ah5gGy3a5eg=
X-Google-Smtp-Source: AGHT+IEGE3tL8GklgaxBgKCmuvBxSl98F8xYTsuVaIP68aXbDef7LLSQMRDFdPvP3NnT2UnrWW+Ktw==
X-Received: by 2002:ac8:7fcb:0:b0:472:13f8:a974 with SMTP id d75a77b69052e-474bc0ff398mr193507931cf.41.1741032588072;
        Mon, 03 Mar 2025 12:09:48 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474efb85808sm12724511cf.38.2025.03.03.12.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:09:47 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id CA2B21200069;
	Mon,  3 Mar 2025 15:09:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 03 Mar 2025 15:09:46 -0500
X-ME-Sender: <xms:igzGZ6BHVTIavAAf-qxVp9Tb3sKXVHPK2nT33JWA4s4zcqKoJYreIA>
    <xme:igzGZ0hbHxwLGhUy-G6d_nJy2HJuH723qw3j_mgLQRADpm8Xv4GNhqUZMdThie85V
    iRBV5KUGSA6k23BfA>
X-ME-Received: <xmr:igzGZ9nlHLO-dl590YhcRN33K4iXnPvRBTNqIYYfGSknE5A9TGUJBMybO7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddttdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepgffhudfhieeggfffleevvedvieettddv
    veetfeejjeffjefftdefieffgeetgfehnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    dpiihulhhiphgthhgrthdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlh
    hithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehg
    mhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepuggrnhhivghlrdgrlhhmvghiuggrsegtohhllhgrsghorhgrrdgtohhmpdhr
    tghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoh
    eprggsughivghlrdhjrghnuhhlghhuvgesghhmrghilhdrtghomhdprhgtphhtthhopegu
    rghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihse
    grrhhmrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:igzGZ4w_vpCqjZEgLzu-3YYDC80mEYkATCCm5BtwEAwJxXK9zuUMlg>
    <xmx:igzGZ_SabMcg403MF9xDW-r-7c8elq1CwKxZxNzOI9SI1oW1Wgq3Uw>
    <xmx:igzGZzbOS24mlcxS0ZYffeiNB_iQ0F2iXRQtwVgn0RFX4JkbnLQ4_g>
    <xmx:igzGZ4Ti8HHrgKkEeB8JIIZOCAZdQXfgM_c1mSDlkL26sr19hmj7eQ>
    <xmx:igzGZxDXc0HG1fhA41rf8gQR_gSoy-8YafdVh7iCFkSrAm3ygQ-gDpiE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:09:45 -0500 (EST)
Date: Mon, 3 Mar 2025 12:08:46 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	iommu@lists.linux.dev, Ralf Jung <post@ralfj.de>,
	comex <comexk@gmail.com>, lkmm@lists.linux.dev
Subject: Re: Allow data races on some read/write operations
Message-ID: <Z8YMTiKS4T9wC4t_@boqun-archlinux>
References: <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
 <tnwDK3QN_Xr0Yoa3U8HVxS5OqjvxIhgmmO_ifTGJR_EtIzjoxawOHtnbOJ9yChsUWXyFPcU9beIdrgbpfGZI8w==@protonmail.internalid>
 <3202F69F-397E-4BC4-8DD8-E2D4B0AB056F@collabora.com>
 <87bjuil15w.fsf@kernel.org>
 <t4HxdvR7WBX_861hiTXo72jqC9F9oRpIzgA_dD2yhcSuLISEkC-shMfSgllrFPpnkSZXGfRcc47keudMooNiIQ==@protonmail.internalid>
 <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
 <87ikoqjg1n.fsf@kernel.org>
 <KpWTCfIlcLYFBpSvWPfALJ9VQn5a99_RAvxgMBc1aCrSalPB-qaW9IhXyaDG7HM1AcFPX5chj_Yr7IQp3F7UqA==@protonmail.internalid>
 <CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
 <87mse2hrd8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mse2hrd8.fsf@kernel.org>

On Mon, Mar 03, 2025 at 08:00:03PM +0100, Andreas Hindborg wrote:
> 
> [New subject, was: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction]
> 
> "Alice Ryhl" <aliceryhl@google.com> writes:
> 
> > On Mon, Mar 3, 2025 at 4:21 PM Andreas Hindborg <a.hindborg@kernel.org> wrote:
> >>
> >> "Alice Ryhl" <aliceryhl@google.com> writes:
> >>
> >> > On Mon, Mar 3, 2025 at 2:00 PM Andreas Hindborg <a.hindborg@kernel.org> wrote:
> >> >>
> >> >> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
> >> >>
> >> >> > Hi Benno,
> >> >> >
> >> >>
> >> >> [...]
> >> >>
> >> >> >>> +    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
> >> >> >>> +    /// number of bytes.
> >> >> >>> +    ///
> >> >> >>> +    /// # Examples
> >> >> >>> +    ///
> >> >> >>> +    /// ```
> >> >> >>> +    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) -> Result {
> >> >> >>> +    /// let somedata: [u8; 4] = [0xf; 4];
> >> >> >>> +    /// let buf: &[u8] = &somedata;
> >> >> >>> +    /// alloc.write(buf, 0)?;
> >> >> >>> +    /// # Ok::<(), Error>(()) }
> >> >> >>> +    /// ```
> >> >> >>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
> >> >> >>> +        let end = offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
> >> >> >>> +        if end >= self.count {
> >> >> >>> +            return Err(EINVAL);
> >> >> >>> +        }
> >> >> >>> +        // SAFETY:
> >> >> >>> +        // - The pointer is valid due to type invariant on `CoherentAllocation`
> >> >> >>> +        // and we've just checked that the range and index is within bounds.
> >> >> >>> +        // - `offset` can't overflow since it is smaller than `selfcount` and we've checked
> >> >> >>> +        // that `self.count` won't overflow early in the constructor.
> >> >> >>> +        unsafe {
> >> >> >>> +            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset), src.len())
> >> >> >>
> >> >> >> Why are there no concurrent write or read operations on `cpu_addr`?
> >> >> >
> >> >> > Sorry, can you rephrase this question?
> >> >>
> >> >> This write is suffering the same complications as discussed here [1].
> >> >> There are multiple issues with this implementation.
> >> >>
> >> >> 1) `write` takes a shared reference and thus may be called concurrently.
> >> >> There is no synchronization, so `copy_nonoverlapping` could be called
> >> >> concurrently on the same address. The safety requirements for
> >> >> `copy_nonoverlapping` state that the destination must be valid for
> >> >> write. Alice claims in [1] that any memory area that experience data
> >> >> races are not valid for writes. So the safety requirement of
> >> >> `copy_nonoverlapping` is violated and this call is potential UB.
> >> >>
> >> >> 2) The destination of this write is DMA memory. It could be concurrently
> >> >> modified by hardware, leading to the same issues as 1). Thus the
> >> >> function cannot be safe if we cannot guarantee hardware will not write
> >> >> to the region while this function is executing.
> >> >>
> >> >> Now, I don't think that these _should_ be issues, but according to our
> >> >> Rust language experts they _are_.
> >> >>
> >> >> I really think that copying data through a raw pointer to or from a
> >> >> place that experiences data races, should _not_ be UB if the data is not
> >> >> interpreted in any way, other than moving it.
> >> >>
> >> >>
> >> >> Best regards,
> >> >> Andreas Hindborg
> >> >
> >> > We need to make progress on this series, and it's starting to get late
> >> > in the cycle. I suggest we:
> >>
> >> There is always another cycle.
> >>
> >> >
> >> > 1. Delete as_slice, as_slice_mut, write, and skip_drop.
> >> > 2. Change field_read/field_write to use a volatile read/write.
> >>
> >> Volatile reads/writes that race are OK?
> >
> > I will not give a blanket yes to that. If you read their docs, you
> > will find that they claim to not allow it. But they are the correct
> > choice for DMA memory, and there's no way in practice to get
> > miscompilations on memory locations that are only accessed with
> > volatile operations, and never have references to them created.
> >
> > In general, this will fall into the exception that we've been given
> > from the Rust people. In cases such as this where the Rust language
> > does not give us the operation we want, do it like you do in C. Since
> > Rust uses LLVM which does not miscompile the C part of the kernel, it
> > should not miscompile the Rust part either.
> 
> This exception we got for `core::ptr::{read,write}_volatile`, did we
> document that somewhere?
> 

[Cc Ralf, comex and LKMM list]

Some related discussions:

* https://github.com/rust-lang/unsafe-code-guidelines/issues/476
* https://github.com/rust-lang/unsafe-code-guidelines/issues/348#issuecomment-1221376388
  
  particularly Ralf's comment on comex's message:

  """
  @comex

  > First, keep in mind that you could simply transliterate the C
  > versions of READ_ONCE/WRITE_ONCE, barriers, etc. directly to Rust,
  > using ptr::read_volatile/ptr::write_volatile in place of C volatile
  > loads and stores, and asm! in place of C asm blocks. If you do,
  > you'll end up with the same LLVM IR instructions (or GCC equivalent
  > with rustc_codegen_gcc), which will get passed to the same
  > optimizer, and which ultimately will work or not work to the same
  > extent as the C versions.

  Indeed I think that is probably the best approach.
  """

* A LONG thread of the discussion:

  https://rust-lang.zulipchat.com/#narrow/channel/136281-t-opsem/topic/UB.20caused.20by.20races.20on.20.60.7Bread.2Cwrite.7D_volatile.60/near/399343771

In general, the rationale is if Rust code could generate the same LLVM
IR as C code, then if it's not data race per LKMM, then it's not treated
as data race in Rust as well. But this is not a "get-out-of-UB" free
card IMO:

* If both sides of the racing are Rust code, we should avoid using
  {read,write}_volatile(), and use proper synchronization.

* If atomicity is also required, we should use Atomic::from_ptr()
  instead of {read,write}_volatile().

> I feel slightly lost when trying to figure out what fits under this
> exception and what is UB. I think that fist step to making this more
> straight forward is having clear documentation.
> 

I agree, and I'm happy to help on this.

> For cases where we need to do the equivalent of `memmove`/`memcpy`, what
> are is our options?
> 

Seems we need "volatile" memmove and memcpy in Rust?

> In case we have no options, do you know who would be the right people on
> the Rust Project side to contact about getting an exception for this
> case?
> 

I will say it'll be t-opsem.

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 
> 

