Return-Path: <linux-kernel+bounces-547601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CB9A50B84
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E2C3AC982
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2395253B7E;
	Wed,  5 Mar 2025 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="K1Hpl/0L"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3E19C55E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203035; cv=none; b=D3zMbDW9rD9e9EqEVY2FbDGVyJTtB7LuGS6PpMKZmFnuqiNsC5874RDu20mThUyU/ACoxGmzTja3E6eTaYkXHOjXIbfVepAt+ylRI/k1GoNtQN1tDkGT8uQlA8UrfPjOVfFweo+dWzyi8VhkSGbwR3cGH25Bq/OQMt2nSBRLmsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203035; c=relaxed/simple;
	bh=t6SiDVwaTHvhAlwjcDp2TYwOA5pPtU4A7kw092Af/vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4KZZJlOT6/hyJQ6pRZd+Roeg+XvoSQAXSgf0NssKMzhWUBqbIx7kKBkVj9MesH6XdcnyIleDK7bGf/g2vodJ9T1Wq3R0lNddSuLsjRVwqUwO5mVxGswCW0vPFXvypS4R5P0gh4MxNjulpaGEDPum9gwVqWjI92slG6774FcmEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=K1Hpl/0L; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c3bf231660so347661685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1741203032; x=1741807832; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oId15+YDneGVvUrzPX64hfAInMf60MXmTWB86DACpPE=;
        b=K1Hpl/0Lf2e0SMJsD78cI6VUZa8YeaVGGCzQxRGADes3BSjSQp5MCTIT7pduSbLp3Z
         rqPQiRCGHImqUOmJtdm6EbBZOu9getLYxNi7Tax+opRvbAJr3Gneh+LVQZqRREGf20zW
         4turkQEZZhp/Px7w34mnLx7bNjJaa+5MyqFC2cVPS3kriaOEqHsEDYVNTPRFK2Q6wC3s
         A6kKge3iwyrZOHtYD+7RTPNxTjw4BP+SspGU+LqGiWeuxEyrJFoYqO+oXe9pHf+MQ7GV
         Yht1CVgXQHbbrrTwMgiuk6NLPQaQrlZt9O55ePQz0DnuPERl8xrcDL97DeM/vu0OEdA7
         J8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203032; x=1741807832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oId15+YDneGVvUrzPX64hfAInMf60MXmTWB86DACpPE=;
        b=cKu+QKq2y5tolNIWB/4gktjXgQizm3XYKCGAVwnDD+nAyzS0Druh3h0CB0OUthZnJt
         UdE6VvNX07ngQd/id403sr80manBds9GRGf1uPHe8k4DfQ484biEQMu0DKK2M0vlvS5h
         QKgCOywfEkDbYfM0IVpuNNBBqXAeKu93FSMmZSe+vxRsyK3Dn7aFTTKIk5uE2H4JYUj8
         +nHN5eYws4w/EbNAwRsNJ4AA6RrVMgeO87UTo1a6WIBKJlU31SgZFaYK/itfoVneLKO+
         fgO8U/dfT+pBN7EZeAXLU2RDHJ3yDjCfyORGkU5kNBzA+2nlVyDD51GQ1MbXButnldj6
         BcYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwrLPfVY2w2539c9JWPWf2iyLpPrR0Su1bc9CcFVCobEsFxX8nFH7x9U5l2lMtci45oNviXAhdQHWVHAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaS5He53qb/ajR1SuMizGImWk+vHv0mZI+PoJATserNhVl/5OZ
	x8hBMF+CCSzt1Oo7n/evpPJc4dvHo5LmLjKjxqU7mlleX6i64mdoTFK5e5fQMQ==
X-Gm-Gg: ASbGncvBRDGiMga/zg+91gRTyY5aMeFL2mJNFO10/pyWS3I5wnEYjPlkGETvF0QYqK6
	9BzWfwpHGdxCsBYG/K4isf3moykWM80BdGCdRoUOgVTLBFH/dWcwiGzxEJywgogXZt3Lz2zUyhe
	EoGpvRuREQYU9Pyq/p8i3GEGqh+Gnx5lOKf+4ab0M1Q0FqwpBLEQ75XUNUvNhbfpZoklD46hyg3
	jYNF6SFcrp1rvhVFOyCmea+tWbWe/ON5BshaWJ4pggUKIcNpmG4u8yPJRcM5fxNZk1XCECWW8go
	3LK/xpZX+9J8ua29zRjt2a/aPvIEA/u2bl6HsRhQwEPxhZaqT6+yPQ4EmgH5C+bf7NAkybFvmel
	V0hWaqKP0NKCGJshU82OeWkZtGEj/c37HBp/eng==
X-Google-Smtp-Source: AGHT+IEdHIEYyOFA6iBD4IRAvEEK44U33sXsSKu1qSukoScCCId/HavsdZVIN+N6mZ49Avbu1kb/wA==
X-Received: by 2002:a05:620a:84c4:b0:7c0:a0fd:7b2c with SMTP id af79cd13be357-7c3d8e55666mr759133185a.22.1741203032165;
        Wed, 05 Mar 2025 11:30:32 -0800 (PST)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3d30234c7sm214999985a.34.2025.03.05.11.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:30:31 -0800 (PST)
Date: Wed, 5 Mar 2025 14:30:28 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Ralf Jung <post@ralfj.de>, Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>, comex <comexk@gmail.com>,
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
	iommu@lists.linux.dev, lkmm@lists.linux.dev
Subject: Re: Allow data races on some read/write operations
Message-ID: <471eec19-1abb-43f1-aec0-d0db56f6ca9e@rowland.harvard.edu>
References: <87mse2hrd8.fsf@kernel.org>
 <Z8YMTiKS4T9wC4t_@boqun-archlinux>
 <ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de>
 <88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>
 <hkhgihg4fjkg7zleqnumuj65dfvmxa5rzawkiafrf4kn5ss6nw@o7kc6xe2bmuj>
 <25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de>
 <CAH5fLgidPHQzdUORNpNhtRFsKPU1T-0xdn5OSwYYZh3BgOVRQA@mail.gmail.com>
 <18cmxblLU2QAa4YP25RWCKEnxuonOwWXavYmSsS4C5D40o8RaCkIXo0UDZ2SPnksk5nWYB29Y4zHkjQeOgd4ng==@protonmail.internalid>
 <3aabca39-4658-454a-b0e3-e946e72977e1@ralfj.de>
 <87eczb71xs.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eczb71xs.fsf@kernel.org>

On Wed, Mar 05, 2025 at 07:43:59PM +0100, Andreas Hindborg wrote:
> "Ralf Jung" <post@ralfj.de> writes:
> 
> > Hi,
> >
> > On 05.03.25 14:23, Alice Ryhl wrote:
> >> On Wed, Mar 5, 2025 at 2:10 PM Ralf Jung <post@ralfj.de> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On 05.03.25 04:24, Boqun Feng wrote:
> >>>> On Tue, Mar 04, 2025 at 12:18:28PM -0800, comex wrote:
> >>>>>
> >>>>>> On Mar 4, 2025, at 11:03 AM, Ralf Jung <post@ralfj.de> wrote:
> >>>>> However, these optimizations should rarely trigger misbehavior in
> >>>>> practice, so I wouldn’t be surprised if Linux had some code that
> >>>>> expected memcpy to act volatile…
> >>>>>
> >>>>
> >>>> Also in this particular case we are discussing [1], it's a memcpy (from
> >>>> or to) a DMA buffer, which means the device can also read or write the
> >>>> memory, therefore the content of the memory may be altered outside the
> >>>> program (the kernel), so we cannot use copy_nonoverlapping() I believe.
> >>>>
> >>>> [1]: https://lore.kernel.org/rust-for-linux/87bjuil15w.fsf@kernel.org/
> >>>
> >>> Is there actually a potential for races (with reads by hardware, not other
> >>> threads) on the memcpy'd memory? Or is this the pattern where you copy some data
> >>> somewhere and then set a flag in an MMIO register to indicate that the data is
> >>> ready and the device can start reading it? In the latter case, the actual data
> >>> copy does not race with anything, so it can be a regular non-atomic non-volatile
> >>> memcpy. The flag write *should* be a release write, and release volatile writes
> >>> do not exist, so that is a problem, but it's a separate problem from volatile
> >>> memcpy. One can use a release fence followed by a relaxed write instead.
> >>> Volatile writes do not currently act like relaxed writes, but you need that
> >>> anyway for WRITE_ONCE to make sense so it seems fine to rely on that here as well.
> >>>
> >>> Rust should have atomic volatile accesses, and various ideas have been proposed
> >>> over the years, but sadly nobody has shown up to try and push this through.
> >>>
> >>> If the memcpy itself can indeed race, you need an atomic volatile memcpy --
> >>> which neither C nor Rust have, though there are proposals for atomic memcpy (and
> >>> arguably, there should be a way to interact with a device using non-volatile
> >>> atomics... but anyway in the LKMM, atomics are modeled with volatile, so things
> >>> are even more entangled than usual ;).
> >>
> >> For some kinds of hardware, we might not want to trust the hardware.
> >> I.e., there is no race under normal operation, but the hardware could
> >> have a bug or be malicious and we might not want that to result in UB.
> >> This is pretty similar to syscalls that take a pointer into userspace
> >> memory and read it - userspace shouldn't modify that memory during the
> >> syscall, but it can and if it does, that should be well-defined.
> >> (Though in the case of userspace, the copy happens in asm since it
> >> also needs to deal with virtual memory and so on.)
> >
> > Wow you are really doing your best to combine all the hard problems at the same
> > time. ;)
> > Sharing memory with untrusted parties is another tricky issue, and even leaving
> > aside all the theoretical trouble, practically speaking you'll want to
> > exclusively use atomic accesses to interact with such memory. So doing this
> > properly requires atomic memcpy. I don't know what that is blocked on, but it is
> > good to know that it would help the kernel.
> 
> I am sort of baffled by this, since the C kernel has no such thing and
> has worked fine for a few years. Is it a property of Rust that causes us
> to need atomic memcpy, or is what the C kernel is doing potentially dangerous?

I agree; this is a strange discussion.

What is it that people want to protect against?  If the issue is 
undefined behavior caused by a second party modifying the source of a 
memcpy() while the copy is in progress -- well, there's no way to 
protect against that.  You just have to make sure either that it cannot 
happen or else that you can cope with potentially torn values in the 
copy's destination.

Is the issue a matter of informing verifiers or sanitizers that a data 
race during a memcpy() shouldn't count as undefined behavior?  Surely 
the way to do this depends on the verifier/sanitizer in question.  As 
far as I know, there is no version of memcpy() whose arguments are 
declared to be pointers to atomics.  (And if such a thing did exist, it 
would be part of C++, not of C.)

Alan Stern

