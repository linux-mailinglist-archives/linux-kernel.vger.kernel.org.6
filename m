Return-Path: <linux-kernel+bounces-288329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F1D9538E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00E91C25219
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E431B9B59;
	Thu, 15 Aug 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag5ta62P"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006F29A1;
	Thu, 15 Aug 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742438; cv=none; b=fZiOhiG8rSEfTZB0wfh6+gowXgc4YNQyGVvcAjyRDOGIVbz/1G280pWJgcj1QvICXPYn6Ku4byaaBTbT2p/p7KHs9LadpUpCCoa+LhV3fiBd4DEddiRgI7ESANaE2wR4ygsJ2phqRKnZWDR4Xoyt0RCzKFU4DetD73lP2iO0XCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742438; c=relaxed/simple;
	bh=XUHVz7yEGk5IAlb3cYzpq2y+0jE9EuCFrg8BbQ9e29o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg9MH+P4W9BbfwDb4NiEWKmv+XFmHll/PiZCGM3/IhadyLDvgMzAPeTDrJjHS1mK2cR2+fNQlU8gx6UPqJ5Aac24MODseUN6GQlcB5iqVnPBlQe2+uFh2D9qtXNS4tlld8n2U2l0UaMfqlh6mxsDulndAXjlYsYQwmx3/ywIbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ag5ta62P; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7a4668f1fso7059496d6.3;
        Thu, 15 Aug 2024 10:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723742436; x=1724347236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JEMit7NXWy1oM7PwyAX/lr16pflfyaQomIcHR1s8G0=;
        b=Ag5ta62PQ4U/8JuggTuItM7W1Ghp7RpyGytVvij28ITEA4OrFi8aUwVcNreinymSAR
         0SQ3cVOW/8H1kbPDyR9WcPJmx1F+beKmlFFcjKMCPyaMljcZojIF200FSj12aoIELUHT
         DIeBdf1hSNGMu36hxVhVgex8H9A5vB8xISc3KYpUCdz0uVRhssguEHJJksGkciDWPstm
         N50oSZyAtn/qyHUKH2+q/RiYwmgHEnQzc4x28iP1g3NsHiAFb9yzTvAJp28zJxahI8Cm
         vbV7/G2jOA7Ugxk5FjzQ7/V/uWHQfdkbfzL+H3b65gzdSiY6VB8XzDsdT6rvBOccDiD9
         9uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742436; x=1724347236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JEMit7NXWy1oM7PwyAX/lr16pflfyaQomIcHR1s8G0=;
        b=tZLC6nQ25b0KADFx7JkMvu080eUpAKfoubFokxdKd3dE85Dber1i4aUAKIiRuPFtDe
         1EDdmG3xpDjRzed9/rlsEMSeq/lS9QM4AQwfmFItlUp5aBkhm/BmtyeSjZH4GuZd+D0G
         Hb1hlP7G60kU42n/M3kY1ZRXUufcNaU/tiy13kdTP9aNJOcjMuEmVKs9iSzT+q5qCCkG
         MGoPcDI/pxZa/RkVBGmbu4jn0VcgUoh3dPb6WtADWX7E1G7Uuv0BpVPOvc5/nZTQ2EoL
         oNf1z4CkVNNAa7SvDh+T/RobR+3xErnAQRbnkBxwomgj5FYlJqsXJkBKtl2hzi5L4Pll
         WsUA==
X-Forwarded-Encrypted: i=1; AJvYcCU15NACqn//+Cbdjxs3MTQY1KNKD2N2AsLtYjMyJq71xuxdTUZSTV9iHbJHWe3CUgh8bOGbwoMzd/oAl35ITP/mBO5MwPfsBRPRmZRfcDLOciwcsYueWUgKu3bRDvS8FSPTLVlDO86OaFatEzE=
X-Gm-Message-State: AOJu0YzP+FwWlkyauKDYwyCRp1Dv7VUzVVGMz/7lz2fBZfFLkGvwA79h
	hVjDudB+6XeY5OnsD5ZJxXkBxK6yqHvfQP+1Fpw0eRpAueXGPF+5
X-Google-Smtp-Source: AGHT+IHGdJ9pU0p5MvXCP0KQeaP2XqUR3h3aauTkKl1mBnuGM+AjKEOAePQH06YoMSm6v5bIHMzPdA==
X-Received: by 2002:a05:6214:4890:b0:6bb:b21b:d158 with SMTP id 6a1803df08f44-6bf7ce7b5c0mr1111866d6.45.1723742435947;
        Thu, 15 Aug 2024 10:20:35 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe2748csm8018416d6.63.2024.08.15.10.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:20:35 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 6F99B120007E;
	Thu, 15 Aug 2024 13:20:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Aug 2024 13:20:34 -0400
X-ME-Sender: <xms:4ji-ZoEM_3ZPhHpHa8mCUb-L1NMvhb0jJDD0ydvrzxhSdHuj1MfjHg>
    <xme:4ji-ZhVVtnzvD-qiTWSECmNa2EruqugW4IZU5sOXTDB7pE-BFCbxl3UBz5WXkZshW
    Tb2YXNGwy5YaTj2oQ>
X-ME-Received: <xmr:4ji-ZiJwz4bbTq30QMWg6Y-1cWCcMZD7_gVvbE4N-RcwnSbHnpIuixdnwC3j_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepuedvgeekjeevgffggfejgfehueefteeuffff
    gfehteekjeffvdfgkeetgeeiieeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprh
    gsthhrvggvrdhrshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeile
    dvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgt
    ohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorh
    esghhmrghilhdrtghomhdprhgtphhtthhopeifvggushhonhgrfhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjh
    horhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhho
    rdhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhrgh
    esshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhl
    vgdrtghomh
X-ME-Proxy: <xmx:4ji-ZqG2TOXIgstRyOPciAxc5joEklizNsxZD6FevJ2tPc2u0m9kUg>
    <xmx:4ji-ZuUsbsTfIUTrnn4aV1fdzUSdSOFH5JbH7C5Ta3kJRxKWMRJq5A>
    <xmx:4ji-ZtN3QRnHONEnUZSB6TzEWaSsd-aXCes5_3b1UO2_YSrQa8Svhg>
    <xmx:4ji-Zl0oqXUCoH04696eiNSVNnNakSarWxC5xtTGfn3QsyyinEV8KA>
    <xmx:4ji-ZnWKtvdnZC_lj0FymiBWebImdMu1a3bncWuhdqsc6zLi6ycKNMiy>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 13:20:33 -0400 (EDT)
Date: Thu, 15 Aug 2024 10:19:03 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 00/26] Generic `Allocator` support for Rust
Message-ID: <Zr44h-4A3rm-ALS2@boqun-archlinux>
References: <20240812182355.11641-1-dakr@kernel.org>
 <Zr0GP0OXliPRqx4C@boqun-archlinux>
 <Zr1teqjuOHeeFO4Z@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr1teqjuOHeeFO4Z@cassiopeiae>

On Thu, Aug 15, 2024 at 04:52:42AM +0200, Danilo Krummrich wrote:
> On Wed, Aug 14, 2024 at 12:32:15PM -0700, Boqun Feng wrote:
> > Hi Danilo,
> > 
> > I'm trying to put your series on rust-dev, but I hit a few conflicts due
> > to the conflict with `Box::drop_contents`, which has been in rust-dev
> > for a while. And the conflict is not that trivial for me to resolve.
> > So just a head-up, that's a requirement for me to put it on rust-dev for
> > more tests from my end ;-)
> 
> I rebased everything and you can fetch them from [1].
> 

Thanks! I will take a look later today or tomorrow.

> I resolved the following conflicts:
> 
>   - for `Box`, implement
>     - `drop_contents`
>     - `manually_drop_contents` [2]
>     - ``move_out` [2]

Have you considered naming this `into_inner` which is aligned to std
`Box`?

Regards,
Boqun

>     - `BorrowedMut` for `ForeignOwnable` for `Box<T, A>` and `Pin<Box<T, A>>`
>     - `InPlaceWrite` and updated `InPlaceInit`
>   - for `RBTreeNode`, make use of `Box::move_out` to replace the original
>     implementation partially moving out of `Box`
> 
> @Alice: Please have a look at the changes for `RBTreeNode`. Maybe it's also
> worth having them in a separate patch.
> 
> - Danilo
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust-dev/mm
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?h=rust-dev/mm&id=ef80ccca2ccebf3c7bcafdc13d1bfe81341cbe63
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/diff/rust/kernel/rbtree.rs?h=rust-dev/mm&id=c361d66df7fb7760064fbca6bf9d72171c352a73
> 
> > 
> > Regards,
> > Boqun

