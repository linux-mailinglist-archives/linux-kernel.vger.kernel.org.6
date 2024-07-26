Return-Path: <linux-kernel+bounces-263762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB1D93DA3D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245C81F246B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A072914A08E;
	Fri, 26 Jul 2024 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LduuHISb"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A9111C83;
	Fri, 26 Jul 2024 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722030089; cv=none; b=WXf2p34lNqnd3aI+e2mLYw2EGwOQhcmj1AZkq0Mvo9y74hMWoKuft3U8A466q49zeoBap8U8xo9J5hnDpe6qn5zeRF8Rg2qpmF3B1c/Szw1H46Eum6y1qbGvDG2YdOa6RhVxldu2Tlm/OrtdDJIVd6nI50DbL0rbfbeza0mSSVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722030089; c=relaxed/simple;
	bh=KflkFDmEqXqpbaBRjC6/jLBVdsSA4DBaVaH/HMeyBOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ryp07mgTm/YDbKXz/Vdzj9MScFJh01iYm3BHzs5Y1u2AIMFifl9f7AEGCZ4hGgECKBIL5s2SxGBpTyJeWdR4+I6pjixvm0YKmb7D3Zv1JC74b5MhvzbwqjWXQwBVyHmV9hEsdvwhsBI9iBMhffR/341EVfPJpMKcQKdgDAgUZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LduuHISb; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79f19f19059so70010485a.0;
        Fri, 26 Jul 2024 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722030087; x=1722634887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeQ2uA4KQaQ5BFYzBQC3DI/Kd0HVQEyWRWUcs7oTDN4=;
        b=LduuHISbxzkdCQ/oimO+3ZEbVsRFsLMrnvpnk+f/y5HtCNy6SpA1rdRyJBcX6BQE9X
         fPxiCWvz1OXANqDV0JB7x5wGze5HB9GHiwQC972Brf01NRgv2FZydJuli5vVPs94VZnt
         LeKsAEhcqo+ezRpzTqd2UEt3F4D4EitKM7FxOwAt5JhkhCCzfn7aXzEAuA78+twpum7I
         6H/SLvIzbjeuOZvhkEG3RwK2e1Rc5s9cq9GqEqqu+VPBfdU4WKgBPcsl2mhPXmFBI2Ra
         +c+9ZXAvxHu4AGQ00QnSItnjeELIEV829Ge3cqFFomYjoSOjgEC0xtnHjBeiw+LZ1Y/1
         CQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722030087; x=1722634887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeQ2uA4KQaQ5BFYzBQC3DI/Kd0HVQEyWRWUcs7oTDN4=;
        b=vNoN5JlLMYzaJTabhQnYumlATpHpeK5MOOh9ahqO74tdczi9xUavAnrpCiJe2B1NbC
         j3Gbg0ixSTeLdRnf4HzI5rISzLXlTGyirdvwPOXtIfJOGZdl2QJcj9mBa1bt/ZA67itM
         DPpKcWJ+sCNgEa3emTV4g9m6rQP6odVPJGQMUMvYZeiwV5sjwFCnlOnol/AKxH+1SaPH
         U1p9MmVtOByEGD2Z+iecXbiAY1TIKLem8wvRAK/w+4NIox92s7wxJBXWJ28Mb5C2XFva
         /Qdw+1D26M7H65aKadozFClW2Rxkh/wB7Pq2VuVlKNKS228qAJZnyNl9f7UcI2A7gjAx
         oBgw==
X-Forwarded-Encrypted: i=1; AJvYcCWmaCBBAFvODRnFUpQk1Ss6zpx6Y9d+LYvnnenojxtfBGNiN4+7/uA7rxDCVhRrcx0oJ3PZWWAcyxEmUgwTZ4AulSzTIms1xJS84GR1ZGXyMjI4FBuUbEgT9TlVFf+cwP2YmUXFBxKPM2qlhcs=
X-Gm-Message-State: AOJu0YzkKXp4Xf+Du0Q4TfqVkmGylNPaFNYNSzhu0Ie7IvBfnAQ3OhZV
	6dodAsHfm/zcw0X6KZWXMbL+pod4cXkIXCvFVVNbOHpkX/XeNF+L
X-Google-Smtp-Source: AGHT+IFUtU9EuixsWuONM5tPmh1qxpsrsQEsvRyap3iWVEMhlQg6pEqF2eNnGN5F3TkJZ4TdviwHnQ==
X-Received: by 2002:a05:6214:248e:b0:6b7:a4c0:9694 with SMTP id 6a1803df08f44-6bb5599f04fmr14682216d6.4.1722030087314;
        Fri, 26 Jul 2024 14:41:27 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f943a30sm20277756d6.74.2024.07.26.14.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 14:41:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 841D71200069;
	Fri, 26 Jul 2024 17:41:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 26 Jul 2024 17:41:25 -0400
X-ME-Sender: <xms:BRikZmdWObPjR5RWDg4HN7zHRfEU-quc0zMwv5dltX8VD4Ky3HyJMg>
    <xme:BRikZgNw9BM38hdeT1xH2lRfXEoSJ5T_B5W7qfvZtgSrDr9OwTiTAaLl4PgDBs8am
    8lilugu3IQyRygN7g>
X-ME-Received: <xmr:BRikZni72u_PtmrSRTKSrFv5cUa9ZdVi86BBhVjBB0YwwBA5Y3DbMCnvsaZxXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdtkeei
    hedvnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqh
    hunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgt
    phhtthhopedt
X-ME-Proxy: <xmx:BRikZj8OE8ya2k4VEEv5QWLUK3nCwaj-kkuE0wt3tmYksmDIbCKG8g>
    <xmx:BRikZitvQQP1wC_D96S9n32ryASNIEWqkJhC0_E_84mG6-aJ9DkeGQ>
    <xmx:BRikZqGTR3O7o_AydiN8oxikzTq7Xz74Kzy7BGfJhkO8aygVv8528w>
    <xmx:BRikZhMTJo16aHgo6918PKVZ3uxKu-jAfJGertZZWdBDrp1YedpnCA>
    <xmx:BRikZvP9jWYbQA_qhl_EakHQOEJYFHdVrFj1CHTpRyIAYkmy3Ivow8o2>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 17:41:25 -0400 (EDT)
Date: Fri, 26 Jul 2024 14:40:54 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Aakash Sen Sharma <aakashsensharma@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: Introduce irq module
Message-ID: <ZqQX5hPb3yha2opu@boqun-archlinux>
References: <20240725222822.1784931-1-lyude@redhat.com>
 <20240725222822.1784931-2-lyude@redhat.com>
 <ZqQTXUl4w6LRPqLh@boqun-archlinux>
 <e46d6e12-144f-47fe-9db4-d7d04914f265@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e46d6e12-144f-47fe-9db4-d7d04914f265@proton.me>

On Fri, Jul 26, 2024 at 09:30:00PM +0000, Benno Lossin wrote:
> On 26.07.24 23:21, Boqun Feng wrote:
> > On Thu, Jul 25, 2024 at 06:27:50PM -0400, Lyude Paul wrote:
> > [...]
> >> +pub struct IrqDisabled<'a>(PhantomData<&'a ()>);
> > 
> > I think you need to make this type !Send and !Sync (because you are
> > going to make it Copy). Otherwise, you will be able to pass the irq
> > disabled token to another thread on a different CPU which doesn't have
> > irq disabled.
> 
> Oh yeah this is a good catch! (although it should not matter at the
> moment, see the end of the note below)
> 
> Just a note: it is not because of making it Copy, this problem already
> exists in the current implementation. One could have sent the reference

Ah, you're right. I was thinking ahead, i.e. dont_interrupt_me() takes a
`IrqDisabled` instead of a `&IrqDisabled`. But it comes along with the
deal of making `IrqDisabled` `Copy` ;-)

> to a different thread using a "scoped spawn"-esque function [1]. IIRC we
> currently do not have such a function, but it should be possible to
> later add such a function. (and it is much more accurate to make this

Yes, scoped spawned timers and works will be very useful, because they
can use stacks for the data structures.

Regards,
Boqun

> type not be thread safe)
> 
> [1]: https://doc.rust-lang.org/std/thread/struct.Scope.html#method.spawn
> 
> ---
> Cheers,
> Benno
> 

