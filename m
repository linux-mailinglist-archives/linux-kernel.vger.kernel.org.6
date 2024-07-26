Return-Path: <linux-kernel+bounces-263750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7C93DA22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0593B20C82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A45149E06;
	Fri, 26 Jul 2024 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzx47l72"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129F1CA80;
	Fri, 26 Jul 2024 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722028928; cv=none; b=KE0C3aAbFn7Wx6Gksu/JwZGx7wOEuIOfgBqDzbLcPnK1fBvECeoewT42e9uc2BNUSj5LmVtXrjme2bpx9UhyHEUal2/Q3FB2KUWVYZyzzD+VYGXV8uoLxaX9ID+XPf0GRI38eMuLMYPpkGHfkGo8k1MHFY8/jsGGREf/IQmYS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722028928; c=relaxed/simple;
	bh=dswZpf/9e633T5v81dQQpqW5+Z74wVdsMxvf79HhdjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxKRFODX8FYdJ+w1ZWHYLwAO7+JjOybrYxN16uPOyioKo4sWFtEGxnBSze8Fwr8dx2UXd/i3l4fZZauwqxQNsKxGMvpWm4jGoY+LAnnBKfY0O9Us03vWaeL3Lht7mHbZYX1UZbzI77uJie68TJB3G2bSnXD+PCnP2Ewgx/TVwtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzx47l72; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d024f775so74083385a.2;
        Fri, 26 Jul 2024 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722028926; x=1722633726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dswZpf/9e633T5v81dQQpqW5+Z74wVdsMxvf79HhdjE=;
        b=kzx47l72Vg5mTmsJA5m3OTbUKy7GDrURgS4xHVgP1siXzN2R4FA1VbdMQZwC/q9MWA
         CdFncVv2ksG2DqFetsq/QBYXtcr5Tb/K4lwUHXBj6nshPQSfts+KgVADCY1+sWvF02nP
         vD/yKJXfv8y2CqAuts/ONvVmlQKswaE5q0ljaY5eI3ep5vEBBESVVJlcr6rggd6xcJIm
         RDvjWqDu2BPAL3ZeHudURK+2x3S4awK13Z/HASqf3v+Nf+xZuVHQWJzkluBT3V7Yu+J4
         /mGQBUN59wioS6nAXTUcutwoQacDFoQ1/192YW8Y+5Y7vFI6inEzMECitmOZq7VHzx+d
         bRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722028926; x=1722633726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dswZpf/9e633T5v81dQQpqW5+Z74wVdsMxvf79HhdjE=;
        b=JrONu4spUzetSS9IxCKizzd7KLM3XLXY7iUNwDw2f84PBbAEYwOv/RywzJnMhFgcYN
         SiynW7LbVWMsbh2/YGC2Fl/CthWOhFqp3mn2ZlgwKdjdLPdSY+inqK2LLLjOkdR+Oa6k
         z5TeaFbJylQq7Odnuz5Yl5fNuuhBAaFxbcKVVOEn9IaPjYidpTXTJZKHwjLpzxkr7wHE
         uRviTpYmKx/iS14qtvstobtRafCIj/MJtuLc8EenyaHKhJZaptyMfHYU7YR4vqV6io2f
         KJEUvBeOxlz2VN+dz8hfwYpvbuTvYMIpC6ERbJe3qYUBmzcuzu1gjrU5yR1iZ4BdSDQt
         gcNw==
X-Forwarded-Encrypted: i=1; AJvYcCWMszQSorihDKA413/6jSigxqlRJufvpWAP7kEh8RTHQhFSWaAAVmO0fL/BGIFP3VNWMsIIkxnwrFKxIy0Kx7xXv4YhWxO6UJV6YDFn
X-Gm-Message-State: AOJu0YyUNxEHQdAYfnugt7bQwdq6IoeUrJRjdE5RFS1FJwQF8bEyZyM+
	9wFpr8khwk+KVjhWnOII0HroQURMQqGq5ICvNaMmHuraK5Scezfk
X-Google-Smtp-Source: AGHT+IFKvhPkRAq3qkDLqMSjOP4G6cm2nMSXnju0lI13K8rG6BVr2mhwMK+M/+43WxIrRPKhQ7qqUQ==
X-Received: by 2002:a05:620a:bcd:b0:79f:baf:ed0f with SMTP id af79cd13be357-7a1e5247b82mr102466185a.23.1722028926107;
        Fri, 26 Jul 2024 14:22:06 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7446afdsm211113785a.113.2024.07.26.14.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 14:22:05 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id F130C1200069;
	Fri, 26 Jul 2024 17:22:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 26 Jul 2024 17:22:03 -0400
X-ME-Sender: <xms:exOkZmVnHNzG1RKQQ-Hg4Lp0MldrC_dekC-4-uu8RUavPM4hKqzLiw>
    <xme:exOkZingDmzF5QRcybV8zQ-IUb-a2emyK-FSSRI1coBy0tDcxyX7p0x8xah8Tgz29
    teEGAMOSZ8oZylPqg>
X-ME-Received: <xmr:exOkZqaf5oqHNjzLKSd8Eu8eAmlv-fpSpEwluTgqHHyPQTMta0UGXoF-8K2NaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:exOkZtWJjL3Tshrs3LKCwrn3LBApaXDI-b5IRdWDm7BqGas2EGxuRg>
    <xmx:exOkZgnSS_sKWe7oICUfgVzKmI7X3oJMSIF5D35seg5NLPD3iztOAg>
    <xmx:exOkZicgLw0wTAvxwQ_TnbF05kFbL9SJC6n5DzwIuz-hteRj1cnkeQ>
    <xmx:exOkZiFMhdw1Uym7PlOnN10Vcj8prqyvKkU82j30WYhb1GF2Tn16jw>
    <xmx:exOkZuncQ3wWCoSNS4yU_HMOL3j38izlEbbE_UIY9kWfPSVsDPJP6xJw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 17:22:03 -0400 (EDT)
Date: Fri, 26 Jul 2024 14:21:33 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Aakash Sen Sharma <aakashsensharma@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: Introduce irq module
Message-ID: <ZqQTXUl4w6LRPqLh@boqun-archlinux>
References: <20240725222822.1784931-1-lyude@redhat.com>
 <20240725222822.1784931-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725222822.1784931-2-lyude@redhat.com>

On Thu, Jul 25, 2024 at 06:27:50PM -0400, Lyude Paul wrote:
[...]
> +pub struct IrqDisabled<'a>(PhantomData<&'a ()>);

I think you need to make this type !Send and !Sync (because you are
going to make it Copy). Otherwise, you will be able to pass the irq
disabled token to another thread on a different CPU which doesn't have
irq disabled.

Regards,
Boqun

