Return-Path: <linux-kernel+bounces-311481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B89689B6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB031F23B41
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2B420FAAB;
	Mon,  2 Sep 2024 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxHByPkP"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EA920126B;
	Mon,  2 Sep 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286687; cv=none; b=LbmkTAkl7weFgLGXhw9MYRo1lxcrhf3x/RjMsVYTWbSxOv6lz32AOqSz8LdREipwXky6Xo+ItuDjaHnjpSmG4mg8oKDv+SHVplsoY20Rh5UmaS2lSY2UAzLi8LpZ6IZqS2s+1sOTk0YQlzTnvhFQ+jN+BHo66EtQOq7VK4q0stM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286687; c=relaxed/simple;
	bh=jMCex3px73EHSdRzyEBYShIRB/5DiCyonwkt84ZnbVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1c+8pTcmGZM/zXEbBVg7kOqw8HgzR4wKZNNB3BNcnUaLfVQ5VbCCEko2Awej/n4a017a3PLMIx1g1FtVcS1QyqpVF+PYbbx9/gbZPohHSb20TSA7jtX4CZbykG/GkXHqDyjezVBZXdT9ZVPrD49s3HNVkhfko4k58n86QqHxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxHByPkP; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf6606363fso23179986d6.3;
        Mon, 02 Sep 2024 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725286685; x=1725891485; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n6ivKodbavAmFdOS3jjnN7jrM7WOCONoPyhGHCp74yk=;
        b=dxHByPkP1snIVFawnaHLF04VfQJB4dzn+BH5B9wv8HxQetaxR2QPntmvEvvkc55rDQ
         SRJJg3Q+3aLFr2zfio1VMwviYzIMVtV5G5NEJ4poSdNftV9apf4UNl0i9oh60nRQAPQB
         RY/o8eR+VZw4tLLZGUl8EovSu85aijoDbwi4Vdx6UnX3+Fz2kALLMDH9Cb7wTKunMqSR
         FN3zjcrJaTPWkCuzPfZ4Pp7OvZljFOtbM3Joi8VLU4xdwOypVdgtVlYjyvx4IIiL2qK4
         btrfjEWzjH/CvIsgz0U3iO0m5JrdGSrpPTeDYeD3+Mz8mDBsF1viHq+eaM6C56xq2BCv
         wapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286685; x=1725891485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6ivKodbavAmFdOS3jjnN7jrM7WOCONoPyhGHCp74yk=;
        b=wEtMZXBa4Xr3qDRB7qbo8rYMGOA3YWYllRofsDMaMyuGBvhz0ZxYRKts9uwxYBIBhC
         Kf8FQ9s5T52i30KRjMtX+Xk/s43z2D/4JNUSiEPAnpd2oWOa9BSvtYwX7OpuDB+LeAvM
         nSCMsnDa1aa8f1XNqt+wr9T3lnh/cmYJdYGRN4ZyORoJPGcWS5jyAyjC5oDSakVMiM6y
         G/SLnGDjpLyNbMXnGRBaEL4X+8DugFZD+gPk7yX1g9+TGP7qELQ5JwqjtYoq3bpXGWuR
         98RngR6xikemaL8pydKr8c8ZmTHW94LbhBrUJ6o0HQ/iCvHirycXjOUG6EXyHMNbRHd2
         qK8w==
X-Forwarded-Encrypted: i=1; AJvYcCUUDVsK4+tijLB5IXd3+3uqQKQaaseXe9UFcgEtENmStcsFhiMrNiyKpNQ1ZqwVudYP27jePJnHsVq/UCY=@vger.kernel.org, AJvYcCWUnJMrf+0cEipc0ylHzgQhwUFwYwp2JxM07lrPvkLxYLv+prWFCtYSG/uibUMbe1dPd7NilkvTd2TkTEO+e+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSVjAblPd1PUGSLRCcO4zEU4UYcVdAgrXdfbAg/bt2zVRYoWr5
	9jGuCGiL6nC3D7DRzOXit/jqPJUizRLaBiw88qaM2lXBx3etJHlQ
X-Google-Smtp-Source: AGHT+IHjEzrLsj5R4Z2mOwcHCPFNU/trTrlsrw2ZW58duHyGU6GBZVNq/zWqJMkut0Y7cQHi+x656Q==
X-Received: by 2002:a05:6214:4498:b0:6c3:5d9f:ceaf with SMTP id 6a1803df08f44-6c35d9fd0dcmr73252546d6.21.1725286685318;
        Mon, 02 Sep 2024 07:18:05 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c34fbb01d5sm31112106d6.39.2024.09.02.07.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:18:05 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 883A41200043;
	Mon,  2 Sep 2024 10:18:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 02 Sep 2024 10:18:04 -0400
X-ME-Sender: <xms:HMnVZuy63hH5NAWGqHGO0L3g3UEjiPsPdzz7Cz0Gmn5PWnYh-IZWEg>
    <xme:HMnVZqS6S_lWD-wmdVM2RyQBX2fLGhkEYj_3YGJJXKEfjjkH51lhExVZ59VQz1eLx
    M7wWt5J3dlIy5WALw>
X-ME-Received: <xmr:HMnVZgUofm0tim-e5vRmELr96Vzr3KlUg0Kqx_gy4OyAnbdjf62QYqcieP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepheeuhedtgeffudelkeekhfefteehtdekkeel
    feeufffhvedtgeetudeugfdtfedvnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorh
    hgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgr
    ihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtph
    htthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgr
    hihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfigvughsohhnrghfsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthht
    ohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheprg
    drhhhinhgusghorhhgsehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheprhhushhtqdhf
    ohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HMnVZkj0KnaAIcZkL9IxdHNd__fVX6SyLgT1zw15-x4rdgYH0wfolg>
    <xmx:HMnVZgB3ZsYOjy0-cHbxvz0qWEecLcyAIAVj3w33N-ZGZ8W2pI1LGA>
    <xmx:HMnVZlJHcb0LvM0fjZa9sinkJiRLJJsOWfzlDR1Next0Q0q4VaWMwQ>
    <xmx:HMnVZnCbhL0ZbUJq59XbRDZKrnFENlLaMl-2Q5Z8lvSjrOQqily4bg>
    <xmx:HMnVZoybDUn5Wz3UFf_RQBbOd4yqjUO9nc99WQZretGdek2Qex6ZHCPh>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Sep 2024 10:18:04 -0400 (EDT)
Date: Mon, 2 Sep 2024 07:18:03 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: add global lock support
Message-ID: <ZtXJGzse8CN30Cp3@Boquns-Mac-mini.local>
References: <20240827-static-mutex-v2-1-17fc32b20332@google.com>
 <10453342-d269-4b78-8962-821ef53d3cb5@proton.me>
 <CAH5fLgh-DYvXobXQVaQ9txYS4Rx8QhjyVvfTphk6vvnUOGzPnw@mail.gmail.com>
 <3b557f61-cead-4568-b2b4-4a56c4cbff52@proton.me>
 <CAH5fLggE-fWDuZXH_F3ixDSo7sQEFwnUV3cd+9_rpFH+XmnA2Q@mail.gmail.com>
 <CAH5fLgiZt3uVZiU1xXPcvYNR-Em2V3y+-C9EbsqrNvkScbiAYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiZt3uVZiU1xXPcvYNR-Em2V3y+-C9EbsqrNvkScbiAYA@mail.gmail.com>

On Mon, Sep 02, 2024 at 01:42:53PM +0200, Alice Ryhl wrote:
> On Mon, Sep 2, 2024 at 1:37 PM Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Fri, Aug 30, 2024 at 3:22 PM Benno Lossin <benno.lossin@proton.me> wrote:
> > >
> > > On 30.08.24 07:34, Alice Ryhl wrote:
> > > > On Thu, Aug 29, 2024 at 8:17 PM Benno Lossin <benno.lossin@proton.me> wrote:
> > > >>
> > > >> On 27.08.24 10:41, Alice Ryhl wrote:
> > > >>> For architectures that don't use all-zeros for the unlocked case, we
> > > >>> will most likely have to hard-code the correct representation on the
> > > >>> Rust side.
> > > >>
> > > >> You mean in `unsafe_const_init`?
> > > >
> > > > No, I mean we would have `unsafe_const_new` directly set `state` to
> > > > the right value and let `unsafe_const_init` be a no-op.
> > >
> > > But how do you set the right value of a list_head? The value will be
> > > moved.
> >
> > Right ... we probably can't get around needing a macro. Can statics
> > even reference themselves?
> 
> Looks like they can:
> 
> use std::ptr::addr_of;
> 
> struct MyStruct {
>     ptr: *const MyStruct,
> }
> 
> static mut MY_STRUCT: MyStruct = MyStruct {
>     ptr: addr_of!(MY_STRUCT),

I'm guessing you're using nightly or new enough rustc, in the current
stable (1.80), this would complain using static mut without unsafe:

	https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=2954daab193caf14d1fb91492dcf325a

, which gets changed recently:

	https://github.com/rust-lang/rust/pull/125834

Regards,
Boqun

> };
> 
> Alice

