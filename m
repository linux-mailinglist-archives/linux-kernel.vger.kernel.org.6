Return-Path: <linux-kernel+bounces-442897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69DB9EE39F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BA528710A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B262B210197;
	Thu, 12 Dec 2024 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="e2OCnne4"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F320ADFF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997845; cv=none; b=SiU/9EQQXiOXmTf1L6cOadHT2NH8Ei+rVtSEKjtlzLbFsI9MR1D72gCtA/fWfNjtRcJ95mV+B0tv7cyZai8yFgEKAfW8IOpW6iRuFbAW33tSTIVliREU4AxKVygp+qc8cztHHpwdCLkvKBjFONMno2iRR+Gmt6S6rL0s2A64fTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997845; c=relaxed/simple;
	bh=patOWM4riuqf/kOI7H3TasBPgT14KB9ytScnVdsb0kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k66FGN/EwFgoGhEmJpfGNY0bVtJWng49kHKpd4qUhZk48aunvhf21xzetkIvrVnoWOpBui5+kR+CNHDO68HBY+saH5Fi/CfRwjdknBmnPb8ZnAiE6Yc4tpdOjguDyaKDzu/2llEJ/guPlp+zK+egYyIXiZO3yUiYFwSv+HXS7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=e2OCnne4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361c705434so2664965e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1733997842; x=1734602642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y189+FYL3S0sHeJXa1RbUedOKNtwkrgPlP3+sKk2eYY=;
        b=e2OCnne4ICK8fx4NQ215CI2zwt0+FKlBjWXB81BEo0giy5lF4ibq/VxaWU49CeMoeq
         pV9BGYqgdXuYhlyw50Diw5GZX/aEPZxqXTW8ZWJYqV9StH8tD5dqKQ/dpSWpCGleHDlw
         wl4dYUFZn7E0VApbgbfb/rJ2A6Gvdknhwn6i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733997842; x=1734602642;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y189+FYL3S0sHeJXa1RbUedOKNtwkrgPlP3+sKk2eYY=;
        b=ToNVTQ+biyyAvlH0hrutEb3uSOWBSmtYOCpcQ1YtaqRaSYTqYzEyDpWOmCBqFvq3Hf
         kzEKPbiyjWMGCU55+5TwI5i7W2CGI3fcE6I9cQYBitH7+EB0zoXsjOvuEql+iZpfsuhj
         yzO0kBkRDXy1X97BF3EqllSNob+/dh/F4MYf1mhlvHWOcC+r61rNKUK1Z0KO5z+08zVn
         4zY6fI3p07/BD9Jdi/Xx/Er3l5G5DDqLkyzUW1PvKgLdYGnQ3PqW7UHhpLFFNhQ7EgCY
         rhxy5zdxCnNX/h2od7wePta4qNwL42NQtzMow/rbNLbBPEf6xvcWI+QDAPsmxLIJj1Y6
         DV0A==
X-Forwarded-Encrypted: i=1; AJvYcCWJpb5N/cIYeQ1KdVRK/uqJGI/YLIfBngQBghAbgn4xWsu0oETBGug252NfYPbPfa6LtZ/MArNXcdnLthI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1aLFnl1TJjgwxJoh9P2/hM2OMYeMXQAxEOsPWctwv8yNO0kBw
	zrob1em4KFuj6xcQUiBdemhVzmBR/tHqbdPuONuW/teG9xrf2p6asmbHsVynWiA=
X-Gm-Gg: ASbGncuDHaVPXowQqpHPYdCNWOP4DK5Hh5Hf1/3RHE4MK5fuy81qlJ40ahYMKLBvmGw
	OXFGk2Mizl4fk7f9FSFTLBMcoNblZB3CN3iWm9AbezuK+xrgTHGkhoKs+or4Aq/MDzT0uPy9cEy
	xwPjOLe7b6NppDKRzJfwYuoIftbFKAdpOQrloxz3hiKiQWu42Ib9B8LECYdP8NTXeqCp2FYc/1X
	7oZR6pMaB+W9at4NE92nn3jerIUpus5VZWtL95vw1dhZ5GblDfpsNinJbEpyZkqu6U/
X-Google-Smtp-Source: AGHT+IHVDFCV8qTqG4FJzegIMjR3/fJ7gxNzTodnB/J4AH0Rh+ZJjWS7hvQCEnQpfy2gIJPzhvI2Bg==
X-Received: by 2002:a5d:6c65:0:b0:385:e013:39ec with SMTP id ffacd0b85a97d-3864ce89848mr5209003f8f.8.1733997841396;
        Thu, 12 Dec 2024 02:04:01 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824bf0d8sm3580473f8f.48.2024.12.12.02.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:04:00 -0800 (PST)
Date: Thu, 12 Dec 2024 11:03:58 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Lyude Paul <lyude@redhat.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
	Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@kernel.org>,
	mcanal@igalia.com, airlied@redhat.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [WIP RFC v2 05/35] rust: drm/kms: Add bindings for drm_connector
Message-ID: <Z1q1DtxI9AlNBiJ6@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
	Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@kernel.org>,
	mcanal@igalia.com, airlied@redhat.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	open list <linux-kernel@vger.kernel.org>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-6-lyude@redhat.com>
 <02A84CFD-BE91-40E6-995C-4E81A8DAB92C@collabora.com>
 <7b57940a3987532963ce5fbd3a999665c17611ab.camel@redhat.com>
 <Z1lQnhKmH39C7Erl@phenom.ffwll.local>
 <f648903a13d204a9a96e942edbead3173c5badc7.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f648903a13d204a9a96e942edbead3173c5badc7.camel@redhat.com>
X-Operating-System: Linux phenom 6.11.6-amd64 

On Wed, Dec 11, 2024 at 07:34:10PM -0500, Lyude Paul wrote:
> On Wed, 2024-12-11 at 09:43 +0100, Simona Vetter wrote:
> > On Tue, Dec 10, 2024 at 06:41:52PM -0500, Lyude Paul wrote:
> > > On Tue, 2024-11-26 at 18:25 -0300, Daniel Almeida wrote:
> > > > Hi Lyude,
> > > > 
> > > > > On 30 Sep 2024, at 20:09, Lyude Paul <lyude@redhat.com> wrote:
> > > > > 
> > > > > +
> > > > > +impl<T: DriverConnector> Connector<T> {
> > > > > +    /// Construct a new [`Connector`].
> > > > > +    ///
> > > > > +    /// A driver may use this to create new [`Connector`] objects.
> > > > > +    ///
> > > > > +    /// TODO: Add a way to handle creating connectors after device registration. Also, that's why we
> > > > > +    /// don't ask for a UnregisteredKms device here.
> > > > 
> > > > Can you elaborate? We can try to help if you describe this a bit better :)
> > > 
> > > oh - totally forgot to respond to this!
> > > 
> > > So: out of all of the mode objects, Connectors are a bit special. They can
> > > actually be created and destroyed after registration (hence why they have a
> > > refcount). This is not terribly difficult to handle before registration, the
> > > complication comes after registration - where we'll likely need to split
> > > Connector into two different types:
> > > 
> > > UnregisteredConnector
> > > 
> > > Connector
> > > 
> > > Where you have to sacrifice the UnregisteredConnector to get to the Connector
> > > object. I don't think this will actually be too difficult to implement, I just
> > > didn't get around to it yet because there were so many other open questions I
> > > had about the design here in general.
> > 
> > For connnnector lifetime fun please also see Imre's patches for fixing
> > some races around mst hotplug. At least on the C side I think we will
> > split connectors into dynamic and static ones, to be able to handle things
> > correctly. It's a bit a mess unfortuantely.
> 
> Thanks for letting me know! Honestly I think this actually should make things
> easier to handle in rust, since I can just push off dynamic connectors for the
> time being and simplify things a bit.

Yeah it definitely clarifies the lifetime rules on the C side, which tends
to help Rust a lot since yolo lifetime is just not a real option for rust
bindings.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

