Return-Path: <linux-kernel+bounces-387692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4052D9B54C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DC62841F1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693ED2076A2;
	Tue, 29 Oct 2024 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpaWBnBg"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2B1991CD;
	Tue, 29 Oct 2024 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236354; cv=none; b=MOmIofLqi7S5LC8FBtPV5pvhuW994EKsb2rNCHpnEBMWiOKTw4WkrJ5VQ+pz+snDe7HgCPjatgJNSs8ReoVm6yHUY1XUG+M0Ww6Ohid9pF6Qxm6IFoUGKurmeCKQ0hqAh2kSo62vHaEhKgWgG3gt2waUBMQghV4ZXC3H1CA/1bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236354; c=relaxed/simple;
	bh=204BV9XbDi7xTyMgZCCLdtJzxzTmC9djfzMFwknc3I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTUymukAFrRKzGYJkq9VaJNLha91Ayc7D1jhhWXI8hsWDbJ21BGhPI6F5qKP7YaiZruEp/+k/E0jZ2txLo1YMOxIgQfGX0ck2UwBBsrTz1cqfWqNGLkKwC54t+wa1E+n8ZJtgPa+aSd7FOUkY4IkKJZbN+76kpM2OXMnFdxLcvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpaWBnBg; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460dce6fff9so43257171cf.1;
        Tue, 29 Oct 2024 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730236351; x=1730841151; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob3s5eW5DFFmF/sJYltP1wSc/GVzO5gvkP17mjeImM8=;
        b=lpaWBnBgI1+yImECKr9xXorNiU94jbviCc+ppI3sCJo5L+0VtzQ6Z1QvystBKxUd7o
         nZ8ogqqM5sCDk0OwDZ7H0IEJVZ7rAORPuuxnmtuFNxwjsl1BixdipigLM1Bw9Fp/Vy9W
         5HEQWDhOBXZV/YqmpOB+oANvQKOW7Z8LQtjvxuTlTjerXmNCWrEiY3EkdVUVaoyjg9Ns
         Z1ztM0jIg6X3ZZW7VNMH1m6lnrL0T7eTnvyXTCA8Aj/VUsdLXuqDYOUd9wwuHB0w1V/X
         0G3EtihzPR8GbseJmQkZjZcWFu1do0qiX/kic1W0gbv1etrdAnpj/O0TGhj9yRvBWSMi
         azTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730236351; x=1730841151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ob3s5eW5DFFmF/sJYltP1wSc/GVzO5gvkP17mjeImM8=;
        b=hlxikVGv/EIoY0GW/VN/19fjDLGO/4zYFo4svFamPfHP+isFmJdxH1aTASFq6rexXg
         ENqNseOX3294EKDXqoTuiTfPJmrvjqLYq+5rW2htaxtIf3SdSB0QBV7g/xEL+8oOpL7y
         EBuY56V8Jv3WmUlurE7bMULMwcGfajGI5lVmVIg9dEMm02KEaqDCtI+ahm3BT54pRr/X
         70WQMlXH8tMLVRKeSOCoGZDvsj0n6ABLNCI67lGNvDnFlGOd65XOLGM5T2EFtvGybhvb
         vQNY2tB9GgB31sxKs6Z99teEjlPhJpBHHztpEsk9pOxlBq6Q4xN6g6Z24K16PU7DmOeS
         SUag==
X-Forwarded-Encrypted: i=1; AJvYcCVaMQyrEzcHrEKvhhB7J8H8BlKBqo6cELF2RvJJIePUVW4uw5JIq4Qt2uJm4VK4v1SZdbTrUy+YS5HlER4bMTc=@vger.kernel.org, AJvYcCW0fPy7nBzw9yvocR9x/e1HJhE2KQM8j23eBuFF9Zheu4JqLPqsAR+mEWpntlpeN9ODlDlvO0g3tyNv0oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYF6zAhL+XWfmLj+S3wppkrgAQJNZyhdx2li5KR7mZmF7P47Jp
	rvAG5RrBbFxetc2q6RBgPtH4u7QdbCQlHn12NT04OQ7mcoNq/uJ9
X-Google-Smtp-Source: AGHT+IHSmmyxcd/2Yj9vg57U61l66xXmn8h145jdJFp5JjfJN3yfgTdQuWx93nU2BQH6MzbWClE6+A==
X-Received: by 2002:a05:622a:110b:b0:45f:873:ff5e with SMTP id d75a77b69052e-4613c1b54b7mr196318231cf.57.1730236351560;
        Tue, 29 Oct 2024 14:12:31 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46132376491sm48090281cf.66.2024.10.29.14.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 14:12:31 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 74589120006C;
	Tue, 29 Oct 2024 17:12:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 29 Oct 2024 17:12:30 -0400
X-ME-Sender: <xms:vk8hZ-bojyLvPpXRrD0ZlUkjH6vJ2JAcFXaeGtAv2xT0FmyGb6z_SQ>
    <xme:vk8hZxbqgnI2jVmBm3A88k2JAnns0lnwfGmk5eZdTVoe0WNjZWlquBg1huDJeI2Uw
    emsOhU7oZSdpj6CUA>
X-ME-Received: <xmr:vk8hZ4_HtTeWIujdpoTLjbdQ73JTMKWWLapB2IEV9OkT_xPG8MX-N9iGBfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeefhfehveetieettdevgeeggedujeffjedv
    ueeludeugedvfeehgeetlefffeeiteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    dufedqrhgtuddrnhhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqie
    elvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdr
    tghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishes
    ghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    vghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehrvg
    guhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhn
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:vk8hZwreZ0jZGiONx-u9UM9QEhELvLw0mBM1sfF1LVwWoUjuaCrAAw>
    <xmx:vk8hZ5pKMr85r_ImOIkM9rVJg8gaN5RAg_yhHlMzsNMGrV5S5ewjcg>
    <xmx:vk8hZ-S7Tmpt7Ch9yJG0NA1E0gTRPSILQNQ-YgDVhRxew2H2PdVbDw>
    <xmx:vk8hZ5ppImHpD7AbWl5SoM68KuaWvMmJF3wqSy0n3IqnFqrPZpVG0w>
    <xmx:vk8hZ24fMDVji3zkhuCL27kPNT7vRm27Qipz6xV-XTn6SLa8Jua2d6mY>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 17:12:29 -0400 (EDT)
Date: Tue, 29 Oct 2024 14:12:28 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v6] rust: add global lock support
Message-ID: <ZyFPvO4jNLieAXUe@Boquns-Mac-mini.local>
References: <20241023-static-mutex-v6-1-d7efdadcc84f@google.com>
 <Zx_OoCRrA_WTay_O@Boquns-Mac-mini.local>
 <CANiq72mb9X0LiDtDe9ptbqm3Ls527Xp+szX7px+Zw6OP8-aefQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mb9X0LiDtDe9ptbqm3Ls527Xp+szX7px+Zw6OP8-aefQ@mail.gmail.com>

On Tue, Oct 29, 2024 at 07:48:21PM +0100, Miguel Ojeda wrote:
> On Mon, Oct 28, 2024 at 6:49 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> >
> > In addition, I've also queued it in my lockdep-for-tip branch:
> >
> >         https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=lockdep-for-tip
> >
> > as I want to help route Rust lock-related patches into tip, so this is
> > a practice round for me ;-)
> >
> > Miguel, feel free to take it via rust-next with my Reviewed-by, I will
> > drop it from my branch once if I see it shows up in v6.13-rc1.
> 
> No, no, it is great if you can take them :)
> 

Thanks!

> By "if I see it shows up in v6.13-rc1", do you mean your branch is not
> meant for v6.13?
> 

Right, so I'm acting as a sub-subsystem maintainer, and I submit pull
requests to the tip tree, and then tip will send pull requests to
Linus. So usually (yeah, I'm calling sometimes I've done only twice as
"usually"), I submit my PR at rc2 to rc4, and tip will carry that into
the next merge window. For example, since we are at v6.12-rc5, my next
PR will be at v6.13-rc{2, 3 or 4}. So if this patch is going via me, it
has to be in v6.14.

I think this patch has no problem to go into v6.13, so again, feel free
to do it ;-)

> Couple of things I noticed that I would normally double-check/fix in
> place: the "// SAFETY: called exactly once" comment could be

Got it. This particular one needs to be "// SAFETY: Called exactly
once", right?

Note that since lockdep-for-tip is not watched by linux-next, I have
some flexibilities between queuing a patch and preparing it for the PR
(I will need to rebase anyway). This could give contributers an early
notice and we both would have less things to watch (contributers can
just wait for the patches to show up eventually in Linus' tree instead
of checking the list for a reply, and I only need to focus on my branch
for improvement) for normal cases.

> formatted, and I think the "Link:" tag should be before your SoB
> (well, at least b4 does that, which makes sense since you added it,
> but I have seen commits done differently too).
> 

For this I'm following the precedents in tip tree: always put the patch
links at the last line. See the "Commit notifications" in
Documentation/process/maintainer-tip.rst. (And yeah, I have to manually
modify this after b4 applies the patches if you have to ask ;-))

Regards,
Boqun

> Thanks!
> 
> Cheers,
> Miguel

