Return-Path: <linux-kernel+bounces-362997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2085599BC53
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 23:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2697281780
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D77F14E2C0;
	Sun, 13 Oct 2024 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq5IRj51"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E413F43B;
	Sun, 13 Oct 2024 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728855793; cv=none; b=rvBepDbQIzdP9bC2iOWgqxFeHrgVeQhviYvFCGiyjzNXJnPzicaQQwS+Nfc/KTZ8Y1trhGYrzN5oxyyEFOXMHZX0+JL0i2xkxi8vkU07KrCoyU4pgnCWmja5P5NvorEZZdHTn4t4heO/mf9k5yI2oHg2ZSU+b5of3hAhfJCFDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728855793; c=relaxed/simple;
	bh=tCStQr3z65tFm9oKRQ+M3I/f8YNEv7e7y/GeqYFwujc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZiztgFLW9ZZGfe7RPQGKqFevAJJ1onKHrQXHTkTSzwQZHi7A2FlPVra0WoqMDDZ6zYrzZz5q1FQ+h9TjxewmazFMG3Jr2WdkkfI3xgY+vaKxRSUv5evQF3T0xQ7KJSAkUaLEyZQdCE535jEUJnHi4r00bBBxtlUeOzI6X4Yt1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq5IRj51; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b110709ebeso266683785a.1;
        Sun, 13 Oct 2024 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728855790; x=1729460590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+3Hw16kEKVdh6zlTavegWZ1sHjvmfIe8eboirfITWU=;
        b=Zq5IRj51taseBIgGrOLvvcCTPlFebURd1iOsmo2sbZJmc/A90z8QSZHlA3WwvlNngw
         lEVfkxsxJPARNh3NqFVoI/Rg8EA3a+8HdZ2TUgm73btb/Gx8q96DEoHH2Caev0dkZpGw
         HQXPZOPJs4ixPOgtV9/1YumKs2U6jkNG+Uej1pjiAEAryOV8gq+VO4bb5uJvNeFfp26p
         nIqMtecmdg2m5g6wXsvhUxDZpkcZjZZmEaoMTHGNwc9GfstyYEW5Fb6Hsp51GzXLpn5G
         eW3FLh9DdBoVOPuDI0UIKl1Vqz57VpII1QThRI0nnMP0gbo+D2d8Z9sdBJ9pf0kHouia
         /2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728855791; x=1729460591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+3Hw16kEKVdh6zlTavegWZ1sHjvmfIe8eboirfITWU=;
        b=epaFFowqjC9VTaFLxWCRLY6xbOtN70msZoJfN7Hr+fVAXFi7lTTfhjfL09TlBYUaKn
         6VA6zJ4CcL/FkFlev6UoZqS1++uXIErUlo8ADdp97OP10IAaL2HQbiZcMNLoCV89X5YI
         mPMuN+ebZwVATdCd6NG5HL+5k3Mp9w/l6qct11ZSzzMwkierUYOap5u9kpx60sDMrXXn
         528GfIVunBEhVtuqznuxjn1NTIEDqP0BDXhr0CtCKCnR/8w8nQZZjz7tgvbccioLwQyM
         +VF1DPDGg33FgQzvqDXe43h34VC25n1SoFd8knEHqNFzav4aAMv6Z0CfAosebYqCjLIx
         mS/A==
X-Forwarded-Encrypted: i=1; AJvYcCWHklEXOK8QBDIdijyzZsTvFkl67Yk/PMseAHfJCD4RCnrhRNlhq3Koo9uOFRxhiMtUn+Pw0Rzyq4730aKFtgo=@vger.kernel.org, AJvYcCXgGxLs9E0vTx2F6W6xXEYdcJVmvWrNCex0u3Gdly+yTACIu+3/s3LYXGhR1zLb7gpmIgIx6FLXdNvZN6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz56yogOkT8utHk8upIpFHmphpRCZIa+iJ9GfcLGXRy0AH1L/Fp
	VzM0JeKSdZ5xK1FPZECdyg9MTYzkvjOTMj91jfgvTJhH1leRnF+C
X-Google-Smtp-Source: AGHT+IEV5jf7Q8B7GnKjjKTMF4Ewa5Wk2w/VkBWPo8E3D8kkv3dvNUopUXrd7UjOLPBMSXdjPx4zPg==
X-Received: by 2002:a05:620a:2903:b0:79f:a82:51b6 with SMTP id af79cd13be357-7b11a3952b8mr1357065385a.37.1728855790593;
        Sun, 13 Oct 2024 14:43:10 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46042807aa1sm38399721cf.47.2024.10.13.14.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 14:43:10 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9EDD21200074;
	Sun, 13 Oct 2024 17:43:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 13 Oct 2024 17:43:09 -0400
X-ME-Sender: <xms:7T4MZw1agnS_pwDfnZQSnFm37QlHxG91_71aXGaNlLYvwSISrxNA6Q>
    <xme:7T4MZ7EhWkp33DqQqBeSLvDxLHxLtxXmIi_EuDIxRNe5CBOCmmicMwQPd_ThOa_8p
    55aD4GvYMLdpxMFKg>
X-ME-Received: <xmr:7T4MZ462MSfoYpfQIVfZWphOxSckV3cBqFQCypjqUhrlMNmH2CYdD-6W8uY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeggecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomh
    eqnecuggftrfgrthhtvghrnhepgfegudffhfehudekfeeilefgtdeitdettedvledtkeel
    teejuefgffefleeijedunecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgpd
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddupdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgt
    phhtthhopeguihhrkhdrsggvhhhmvgesghhmrghilhdrtghomhdprhgtphhtthhopehlhi
    huuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhu
    giesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrhesrhgvughhrg
    htrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:7T4MZ526-Q0bJdENtxA2k5lIvD_IsZ877MOjQ3tCOpoWx8rSdDNRFg>
    <xmx:7T4MZzFH_bsHKEwYQOjwa2rMnRNHA8Gp7fCiEeTDzhZaGWV4xcUG2A>
    <xmx:7T4MZy_y3zioumTw0idlFxXqMCAb4eH_IVXDnp5yDe9m4zd22wRSTg>
    <xmx:7T4MZ4np4eJyY7D8XgmkN3eurTm0kCToKZILOk5NEj9PRAuNcBb65g>
    <xmx:7T4MZzFS_rLiyilzfYxpZGoBDdbtxlTgFgBgkhJhmmmlQgM1joCg2Yx7>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Oct 2024 17:43:09 -0400 (EDT)
Date: Sun, 13 Oct 2024 14:43:08 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dirk Behme <dirk.behme@gmail.com>, Lyude Paul <lyude@redhat.com>,
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH v6 0/3] rust: Add irq abstraction, SpinLockIrq
Message-ID: <Zww-7DO8jeQfnItV@Boquns-Mac-mini.local>
References: <20240916213025.477225-1-lyude@redhat.com>
 <aef35907-b92a-4f56-a330-b4be06f11984@gmail.com>
 <875xpvhlgm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xpvhlgm.ffs@tglx>

On Sun, Oct 13, 2024 at 09:06:01PM +0200, Thomas Gleixner wrote:
> On Sat, Oct 12 2024 at 07:29, Dirk Behme wrote:
> 
> > Hi Lyude,
> >
> > On 16.09.24 23:28, Lyude Paul wrote:
> >> This adds a simple interface for disabling and enabling CPUs, along with
> >> the ability to mark a function as expecting interrupts be disabled -
> >> along with adding bindings for spin_lock_irqsave/spin_lock_irqrestore().
> >> 
> >> Current example usecase (very much WIP driver) in rvkms:
> >> 
> >> https://gitlab.freedesktop.org/lyudess/linux/-/commits/rvkms-example-08012024
> >> 
> >> specifically drivers/gpu/drm/rvkms/crtc.rs
> >> 
> >> This series depends on
> >> https://lore.kernel.org/rust-for-linux/ZuKNszXSw-LbgW1e@boqun-archlinux/
> >> 
> >> Lyude Paul (3):
> >>    rust: Introduce irq module
> >>    rust: sync: Introduce lock::Backend::Context
> >>    rust: sync: Add SpinLockIrq
> >
> >
> > To have it in this thread as well I just want to mention the discussion in
> >
> > https://lore.kernel.org/rust-for-linux/87a5falmjy.fsf@kernel.org/
> >
> > which results in the impression that this patch series needs to update 
> > `CondVar::wait` to support waiting with irq disabled.
> 
> What means waiting with interrupts disabled?
> 

`CondVar` wraps a wait queue, and `CondVar::wait` accepts a `Guard` so
that it will 1) prepare the wait 2) drop lock and schedule 3) regrab the
lock. The usage of it loosk like:

    let cv: CondVar = ...;
    let l: Lock<...> = ...;

    let mut guard = l.lock(); // or the `guard` can be generated by the
                              // lock_with_new() function.

    while *guard != 1 {
        cv.wait(guard); // here we drop the lock and wait.
	// lock is re-grabbed.
    }

2) is implemented by the `unlock()` function of a lock backend (plus a
schedule()), and 3) is implemented by the `relock()` function a lock
backend. Currently SpinLockIrqBackend (the backend of SpinLockIrq)
doesn't re-enable interrupts in `unlock()`, and of course it doesn't
disable interrupts in `relock()`, and this is actually correct, because
SpinLockIrq expects the caller to provide `IrqDisabled` token, so it
doesn't handle the interrupt state itself, therefore `unlock()` cannot
enable interrupts.

But that makes `cv.wait()` not working, because interrtups would be
still disabled when schedule() is called.

I'm waiting for Lyude's new version (with lock_first(), and
unlock_last()) to see how we can resolve this. We may need to redesign
`CondVar::wait`.

> Spinning? Why would you want to do that in the first place?
> 
> There are not a lot of use cases to do so, except for core code.
> 

The use case currently is that a timer callback need to modify something
inside a lock, that makes the lock irq-unsafe, if a task is waiting for
this modification, it would need to use `CondVar` to do the wait.

Regards,
Boqun

> Thanks,
> 
>         tglx

