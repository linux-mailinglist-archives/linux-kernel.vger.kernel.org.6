Return-Path: <linux-kernel+bounces-242511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A98928926
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A379B22516
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA7C14B940;
	Fri,  5 Jul 2024 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGgJumVx"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77114A614;
	Fri,  5 Jul 2024 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184396; cv=none; b=WTdFA4F5YcV0mYcifcrT2q5metu09ZD1Mf3/GUXgVZTJ3k60bnnDry7xVhYviwsU+YMTow4mRbST/fNHiwINlgx3xQ+Ttct3YhbfhofY0EcqQYrGkGHlmLaOvp1NArpOVpU4/gcnH30zFycvkXQj6op+yMggVXFOGZTkVRjv1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184396; c=relaxed/simple;
	bh=VzS+ic2YFjoOYqTywkuQAT9X6IwIbcB7ZS625NxgHdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RErdgzOUnYDpvuU4HQ2FetfzPJqCdMbdh1isEl66PRtLWrU2eSMqV7BgktYABEq+ZjBWot98br28m7P34ab6hFc03SawG8yYRpWFW5DHCxMdG9KsX7neaY/xAe31/8quaHQXyNtY2gWMBR+Dhz74cUf1uWQ14cbBn2fU/+S+ToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGgJumVx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so2288227a12.1;
        Fri, 05 Jul 2024 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720184393; x=1720789193; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pPHWBuGWsy1zU9N/El+E2fV7OQ1j1Ymj+M4e88iwJ7M=;
        b=HGgJumVx3lUdxK1LY1or1GNMa8mMTb5OgY7fEyf9wEgJrzzAIbcQsVac78oZUeJ/PB
         PiE7+iNEL2opp0Qq5bytK6bzdLxPuxN8xN5RZykH+YJqGBXvFrBQ/lXE69yndCRlb9/S
         DgTaM5w6NuPbObwzGEdCqAYF8F0UH1ZPoDuFfxiiKqsTOey1mLoD52IW23yXkZTc3wwQ
         0k5yoRH2l7nLz/PGdr9xk6ij1iiWXr5io1JirSOeBiw2KIQawN4X33xTpk9sEc/Pyb8C
         nyTSJ6/LMmXVnwvwBk+P2EJczFNRLbdHzN4e2HYmol5pAgxZWYUnjx617Lwta3kM7UaV
         9sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720184393; x=1720789193;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPHWBuGWsy1zU9N/El+E2fV7OQ1j1Ymj+M4e88iwJ7M=;
        b=FRK7i1oScgtVZwQfgFyy96OAGG05zluYPEvT6L+IoS1062vJZsFQj6t+DECcu0qzBC
         2TDcVGX33GgOS0IOaU1slsif7p+W5CA3KjiA4W3QKJ7cneOV/k26VhdPHShjCEwFHjf7
         ZQlWgWxuYRxkKQMJZvM/DwVFJmv41ulEbnwYnXC6wbk45OemMPJUDMTdCPBrDAlPFVt0
         o6jffa+eEYQXEA6TGfDvt7lfZk8RibFje2FQtrbCWHSO3pzphfZz3mc/wExJxq2ZHy3Z
         CTGC/aySQ7scubZKbh4vezXYnGUVZXTc6WX0rjtZPl0g5ZSE8zBumwpA7mTiqoqPF8mh
         IPtg==
X-Forwarded-Encrypted: i=1; AJvYcCUiKamBFqxZ/suyayobkETTDLhTFhF+qArsX2om+LECgeLSeHOwIVFpP8GMOYF7MIh814UtHFQYXrj4hDSuJkdOuUj2djj2/TTFj4ZKkjwJF42NXJQuypZ5wlYyAbOum5o55X5uuYSeshQuy4cTqMOeXuL8V0i/870AFA+KEGhc2ptAfQSOI1rhnAGOCKWZhdBLuY95eGoDiP5yP2zSaJk+d30=
X-Gm-Message-State: AOJu0Yy7DCapqosZDJvT1lBGnZg7ZwM+vU5G6y0PJMcYzLJqUuxd4JCU
	7UhuA8480y3YD7emY1GK/AJtR7HTsG1eZIFSZqAbOX/Nrcmio4E=
X-Google-Smtp-Source: AGHT+IHTV/cG8LJsYeKSwuY3SkyzUVcP52RZ3SV5iUZUNO9nF749TRMCoTZI++I2KrI84E1vVOKnoA==
X-Received: by 2002:a17:906:48d8:b0:a77:da14:840a with SMTP id a640c23a62f3a-a77da1485b8mr64341966b.69.1720184392690;
        Fri, 05 Jul 2024 05:59:52 -0700 (PDT)
Received: from localhost (host-79-17-25-43.retail.telecomitalia.it. [79.17.25.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7525fb8387sm454063966b.94.2024.07.05.05.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 05:59:52 -0700 (PDT)
Date: Fri, 5 Jul 2024 14:59:51 +0200
From: Andrea Righi <righi.andrea@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Johannes =?iso-8859-1?Q?L=F6thberg?= <johannes@kyriasis.com>,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <debian@fabian.gruenbichler.email>,
	Josh Stone <jistone@redhat.com>,
	Randy Barlow <randy@electronsweatshop.com>,
	Anna Figueiredo Gomes <navi@vlhl.dev>,
	Matoro Mahri <matoro_gentoo@matoro.tk>,
	Ryan Scheel <ryan.havvy@gmail.com>, figsoda <figsoda@pm.me>,
	=?iso-8859-1?Q?J=F6rg?= Thalheim <joerg@thalheim.io>,
	Theodore Ni <43ngvg@masqt.com>, Winter <nixos@winter.cafe>,
	William Brown <wbrown@suse.de>,
	Xiaoguang Wang <xiaoguang.wang@suse.com>,
	Zixing Liu <zixing.liu@canonical.com>,
	Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 13/13] docs: rust: quick-start: add section on Linux
 distributions
Message-ID: <ZofuRz4LCJD8A4fk@gpd>
References: <20240701183625.665574-1-ojeda@kernel.org>
 <20240701183625.665574-14-ojeda@kernel.org>
 <ZoeQVYda-AZN6PYy@gpd>
 <CANiq72==+YBoQDBwEVuncY+ygeTkQPEbK00yBCPN3YWVk1L9XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72==+YBoQDBwEVuncY+ygeTkQPEbK00yBCPN3YWVk1L9XA@mail.gmail.com>

On Fri, Jul 05, 2024 at 12:50:35PM +0200, Miguel Ojeda wrote:
> On Fri, Jul 5, 2024 at 8:19 AM Andrea Righi <righi.andrea@gmail.com> wrote:
> >
> > This implicitly covers Ubuntu, since packages are sync'ed with Debian.
> 
> Do you mean the names (i.e. command) is the same, or that the newer
> versions from e.g. Sid can be used in Ubuntu? If the latter, that
> would be definitely worth adding, yeah -- is that supported / expected
> to work?

Command and package names are the same. We may also have different
(newer) versions than Sid, but this is up to foundations team.

Zixing, what do you think?

> 
> > In addition to that Ubuntu also provides versioned packages (such as
> > rustc-1.74, bindgen-0.65, etc.), so in case of special requirements
> > (e.g., older kernels) users should be able to install the required
> > version(s) using the packages provided by the distro.
> >
> > Maybe it's worth mentioning as a little note, so that users are aware of
> > these extra packages.
> 
> I thought about adding a section for Ubuntu to mention those -- so far
> I only added the distributions/commands that were likely to work with
> the versions supported by the kernel, with the idea of expand later as
> time passes. So I didn't add the versioned ones since the latest is
> 1.76, so it wouldn't work for the current kernel.
> 
> But it may be useful to state it nevertheless, since some people may
> only look at the latest docs. (Or perhaps Ubuntu can add Rust 1.79? :)

Actually, considering that this doc will go in newer kernels, probably
it's not worth to mention the *old* packages.

About Rust 1.79, calling out Zixing again... :) He may have newer Rust
packages in his ppa at some point, but I don't know how much we can
consider that ppa "official".

-Andrea

