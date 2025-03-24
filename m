Return-Path: <linux-kernel+bounces-573143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039A6A6D387
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 05:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8513AD19A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 04:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4435718B464;
	Mon, 24 Mar 2025 04:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpE2JBjM"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929C2F3E;
	Mon, 24 Mar 2025 04:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742790232; cv=none; b=a9Cz8umYqgZsPGDtewl9kXZ0qlVthdUfXXTr3f6kuYRyDp/bByD9Q3XuVQDO7dE64XnSvu+CqR9/t05bzxc6V+slOAKhPcyoadxwEZmosVmuIWtsViA4hgIuMu4ga7tim50ReZLJ7WLqQQ83pvPHU7NN1LGVWS4F8iu5i8s3r4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742790232; c=relaxed/simple;
	bh=OhQTM0oPvorXpOX6xascKz4fAPipJPuQnPzwGvw7uIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE53BmQLYolte2IUuP8J8vr8rsDBphVwWJadyGG0D5h01zquPCZFkXW1Yfs/Vqwt9QtRQZja9KYYKR5bgobg4TD82y/PVfYyR8oZSTgaeQef77sXJRl+p0Dc+D2TG4JY55dpBjS7q3Tk8e3a7J+33K9dCTgF5s73qC85dKD+ovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpE2JBjM; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so50066686d6.3;
        Sun, 23 Mar 2025 21:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742790229; x=1743395029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ncJdng0B2Xy6DMBtk4X6687fyX5Q3U18Frs5Fc9lOM=;
        b=XpE2JBjMvzBV6kJkXNiiP1GGUa/sb6ysCNzEotRlzRHEw6nJeqWZPEmmzhytS0rB/E
         IF8ti6r/w2BNxwtIhBCnhfbGN01K7FBJz4M7qeNWSpX17G3IBVN1JMcRdE6VX8ne/q07
         u/nh1nSg9t16T5xDq+gFj3QqQdY7qhX0h7Q400DCYO5n9etzfgMRCUTP1h1eUi2dNQHK
         oHmvnSFZ2BzwVSFBDwSvdJh1Nb883qnFOWtuJ0TasjESbq317qUneD6OEXg7U6TtYTDN
         OPDL68yY/wcNMoLTWhPEbQ+JN9mbaMzN60otoIq8FiGIw6oCPVEA/f6Sa10p58Beo/BD
         V7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742790229; x=1743395029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ncJdng0B2Xy6DMBtk4X6687fyX5Q3U18Frs5Fc9lOM=;
        b=qQppxZyDaEWpFlxKfYcL7Hdb4/undlDts6rCDHrTWjPPBUGkHjXJ68ZW2xBjCQPrPd
         g9NUA/pyt9kg0LeXLrkwt1hqfmkziAUqbCFBZKK8v1v02zIwJHoCdw7yEJWBGZ80OUeu
         CNzcqaYLlffiUeBGDswshIOKSrgY/Kkuoc1rOwi6fF+3J/f2dul2U+9KSajM3cdytS5U
         6btuRIye+fMqdmGuASQO3ieVfpNGYoCTyx8LQ/wELSguRQ0Nm+Qkv1PzL5/oYJYLIo9J
         y+SWDWHpTHeQLTg17O/EgmGawGv65/k3yxBTvhrgvxFDVv3Jew+pamvB/uAt5VU0hhA0
         GNvA==
X-Forwarded-Encrypted: i=1; AJvYcCVW0Q43dl2deABHSredyMdOo+2Ci8PlHe0ZHNaLUPhgfYpZKA5rpm9Fzg75epgEM/xzx35fQ6SP7VSVf+M=@vger.kernel.org, AJvYcCWsjyzAIzIEl5hl+2ga+x1iH63e9Uk7Sm8mHYEfyyPXTEA7k8EoUgk5hcQyP0vTAts2RYEC/ZowArPMoRcSGoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJebvOCp0GZSHN/hzZmu/Jd508F+5e2SI3iZ7Cm5t86iDg6uR
	3aSmXS7QaHbHgRpqTCM68Q7IH9g99PODJIH4zfWf5wSZI5s5KlFF
X-Gm-Gg: ASbGnctkEBsDjaE5GgzNhEwZ/6zFsvccWW/8QDMD4BYjFqQ+gD/qZJWhZZRkeo/KU1z
	83T6LWD5Tvg7Vd116g2ySPYIo14ZrRy9mrjtWugMACrHgOPCQKVRp+d2989IB+l7bb/YPJ5MnYs
	CoaLC9I+Ie3sa6oDr4uPHxw+DVsUJE1YopW02dWN8QR8lCth1aZ7wPXnCTs7VuMhkAf2JcCOpqg
	WKIemR29Pwe5uedytvmNcmksNgZPWMU0738F7F1sjqaapu1aq0dUv/W2Sx5fXT5GIenUlY2P4/2
	JNAlui1oSAKPIM1ZIUSqQSJL2iuU17xj+X5q/Cv2Nk5SanRSKLxDtRn2mQVpCJR7ylP+K7xoq7I
	9/3dnujVNaU1K/2FqWv7NES9o02pwUuCsuG4=
X-Google-Smtp-Source: AGHT+IFYj4MuiWqakak2B3w+iKIXGikciSs3YkdDYfrd8r6Jjbs72ELdlAAXvKZwDHD1U9wUUWwU0g==
X-Received: by 2002:a05:6214:c8a:b0:6e8:fa7a:14ab with SMTP id 6a1803df08f44-6eb3f284a8fmr109954316d6.6.1742790228928;
        Sun, 23 Mar 2025 21:23:48 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0ebc1sm39588166d6.9.2025.03.23.21.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 21:23:48 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id B3C931200043;
	Mon, 24 Mar 2025 00:23:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 24 Mar 2025 00:23:47 -0400
X-ME-Sender: <xms:U97gZweSXPmfd9XLE6SKa-fys5SCFYKm5mGAx9wV05aTGGQMBVOeKw>
    <xme:U97gZyOTBlCSm7pGlU9Jk3JCFnfpTq2POr9n78bE3SoNUAluzD7W5U4Zza7VW2cK9
    4CQxHxXh57H6OTE6A>
X-ME-Received: <xmr:U97gZxhwovApCeqBR--zYKfoc2DHre9UtPNDzXAWrob420waxGin0Aa4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheekjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeej
    uefhhffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepkhhunhifuhdrtghhrghnsehlihhnuhigrdguvghvpdhrtghpthhtohepohhjvggu
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphht
    thhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhn
    uggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:U97gZ1-24tAJn3BK1e8_WScaCRECw0qeKJ_D0n8IUFTHOpgCEO6xmQ>
    <xmx:U97gZ8vEOF5vhXZJe-pCeVQCgWBBqNNVpfGAUzbDq9qANXZED4rpMA>
    <xmx:U97gZ8HIBBX6f7smFasa0uiGXmyPR4-93VMmWWwoLOS3dmdKmtXOpA>
    <xmx:U97gZ7Nx8CEl6Nam4x-Pzmu0KTvbFqdQkbqaJCGCJzRK69lF_LjYDA>
    <xmx:U97gZxMIPI1w3ra8nnehC9gtcSXr3TDBM8HVXw3eDne4RQ10m6sOlAIG>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 00:23:47 -0400 (EDT)
Date: Sun, 23 Mar 2025 21:23:46 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>,
	Grace Deng <Grace.Deng006@gmail.com>
Subject: Re: [PATCH] rust: sync: optimize rust symbol generation for CondVar
Message-ID: <Z-DeUmA-aouWUZBT@Mac.home>
References: <20250317081351.2503049-1-kunwu.chan@linux.dev>
 <Z-BL_DFA3afcRYGE@Mac.home>
 <0d0b186d-6e07-4a46-b8e2-698a97796e44@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d0b186d-6e07-4a46-b8e2-698a97796e44@linux.dev>

On Mon, Mar 24, 2025 at 10:08:29AM +0800, Kunwu Chan wrote:
> On 2025/3/24 01:59, Boqun Feng wrote:
> > On Mon, Mar 17, 2025 at 04:13:50PM +0800, Kunwu Chan wrote:
> > > From: Kunwu Chan <kunwu.chan@hotmail.com>
> > > 
> > > When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> > > with ARCH=arm64, the following symbols are generated:
> > > 
> > > $nm vmlinux | grep ' _R'.*CondVar | rustfilt
> > > ... T <kernel::sync::condvar::CondVar>::notify_all
> > > ... T <kernel::sync::condvar::CondVar>::notify_one
> > > ... T <kernel::sync::condvar::CondVar>::notify_sync
> > > ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> > > ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> > > ... T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> > > ... T <kernel::sync::poll::PollCondVar as core::ops::drop::Drop>::drop
> > > 
> > > These notify* symbols are trivial wrappers around the C functions
> > > __wake_up and __wake_up_sync.
> > > It doesn't make sense to go through a trivial wrapper for these
> > > functions, so mark them inline.
> > > 
> > > Link: https://github.com/Rust-for-Linux/linux/issues/1145
> > > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > > Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
> > > Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
> > > Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
> > > ---
> > >   rust/kernel/sync/condvar.rs | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> > > index 7df565038d7d..a826896ba3f0 100644
> > > --- a/rust/kernel/sync/condvar.rs
> > > +++ b/rust/kernel/sync/condvar.rs
> > > @@ -181,6 +181,7 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
> > >       }
> > >       /// Calls the kernel function to notify the appropriate number of threads.
> > > +    #[inline]
> > >       fn notify(&self, count: c_int) {
> > Hmm.. I think CondVar::notify() gets inlined even without this
> > `#[inline]` attribute, do we need this actually?
> 
> Actualy, after add '#[inline]', the build result is (compilecmd is 'make
> ARCH=arm64 LLVM=1-j8' ):
> 
> $nm vmlinux | grep ' _R'.*CondVar | rustfilt
> ffff800080019e90 T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_ex
> plicit
> ffff800080019e90 T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_ex
> plicit
> ffff800080019e90 T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::panic_cold_e
> xplicit
> ffff8000805b8c7c T <kernel::sync::poll::PollCondVar as
> core::ops::drop::Drop>::drop
> 
> 
> And before add '#[inline]',the 'nm vmlinux | grep ' _R'.*CondVar | rustfilt'
> appear 'notify' function,
> 
> Seems like the LLVM didn't make it inline.
> 

Your commit log said:

... the following symbols are generated:

$nm vmlinux | grep ' _R'.*CondVar | rustfilt
... T <kernel::sync::condvar::CondVar>::notify_all
... T <kernel::sync::condvar::CondVar>::notify_one
... T <kernel::sync::condvar::CondVar>::notify_sync
... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
... T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
... T <kernel::sync::poll::PollCondVar as core::ops::drop::Drop>::drop

so no *notify* symbol even before the patch, right? I also checked with
my local build, without your patch, there is still no symbol for
notify().

Regards,
Boqun

