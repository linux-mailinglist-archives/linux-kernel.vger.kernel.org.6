Return-Path: <linux-kernel+bounces-449326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E609B9F4D43
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94DD188D91C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3101F63E4;
	Tue, 17 Dec 2024 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TuXGk3Y7"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C31F4715
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444564; cv=none; b=Ud3En3OL39a08CE/R+5ZVHjbKCue70VYpJrHPYHnNJZxKIwxFh4Q347wRzIrA9uKIYni4q1BLstrrDJzIUJvRbD7cLJOAsEIbaQpPgY888osvJBA+1mZ5NqyXy68jZtcwd75rpwLoydL79dBwiuB9S4Fsz+YQoJxa81GE9fxQ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444564; c=relaxed/simple;
	bh=ahxj2ZuvgdqAbrr9kxcrRePlld8qQb0+q5BUmhEK5wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhFV9n45DiwPeUuOXF6p4X2gd+IaxErqeqEP5JafFWoDjuJE+NpmDfNJ+invlmGG6ys4v58l950ik5MWk3Jt1buBEaqBmyQkEHCLHs1bOWHT96e5WXp0BAA9XPlICwYNOntoGaMhTzr11BA6TKP0U3j8wrCLF//fyz1FSmHAi5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=TuXGk3Y7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43622267b2eso56665015e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1734444561; x=1735049361; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCGlkgVuqQzqrbUexKTG0Z2+N/cbqdQ/0IOQRwtrcEU=;
        b=TuXGk3Y7kJCwkDR6prqC5HtJcTVU1vfxAabD7zILKtwDWf/tatSIUO33CbNjR/3Jr1
         vCAeSRsRcYlL4JE01X8nYKOR71ZT9xKIhe8Dw6FnlKKMzO1IKn9UdxGdc69ZT0WROywj
         vvkI0fvi2GmfVaDHkBcvIsryUNR4LbJIhIPbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734444561; x=1735049361;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCGlkgVuqQzqrbUexKTG0Z2+N/cbqdQ/0IOQRwtrcEU=;
        b=rLjtmuk01W1nHzpLvYMNvPPW5heyOky+OZu9FvB/zpmj/6KbDz5uZuZRzRixUjowLQ
         1Xp22aWjeYMGuX96Cu4S0a0MPB7GipVlMyt5YsWEflMgb3A6MhTsVPfXTzsX1Bu0c354
         8aGCadqFM6fUknKyKSyRoOqibhVRo+vHG2nZNhtY38ldAxHZpoBuRyc+AyLAz213//8/
         Uaqf6fwcwLHZ5h78mO6gKYWRgs+zbCVcSuNg5xPgxuOBWnTOEhDFMIHiovQBrL42WWGH
         N05tnzflJqzL7qeCGuR2lOtxe+qtM+X/DSAjDM0+cdwE8fbvBLXaLslgHd2De4WwVWW+
         PjJw==
X-Forwarded-Encrypted: i=1; AJvYcCV7lcEZwoinbQx0CSq4+fApJvFTf1LkdPYYm26xCzRjwYMmee80gmt5nGKmSby/kFFU+/+xh/JZIgkeVFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfzAox2yb7QX6Q3A9dn6+oE1aEt7xA7h/qCQaN+Di+g7FCnvqW
	WN0pchn8TWpil6sUcEwgeZ/1eurwKEB3J+219ayq6A3lMozw5JJlQp/GUktIQ9g=
X-Gm-Gg: ASbGncvB8ZAwKMSq5zDMHAU1vMiIRCBOOaFhno7o9jYrmOdoEojwa14hLeOUcDKjub/
	3ElEu0Pz8g51fD4dyixktiKCprrApNXBLtyl5PeiLl+kyvyzvZkra4nGeNKCdDUpK/9lWON7Lb+
	FFHlVZqiJG0z1FbvTnVUInSRyaZQrWyMGkyhFXEOkMzcGp4miI2BBSBhsgLzcR3uh/2uM25QCnJ
	1SIkVGuZWVF4A06WTz0LxN5xkUfb+OJkV5+szzAO8fdtqX78E5LhJH0frpQjMDX2bSd
X-Google-Smtp-Source: AGHT+IGnRQychXs+K5YClf+sKZxkZMessKx1cEMa9+lNbZSGPCGrEsRoDJCorxXBGuSk5UpMIG9gVw==
X-Received: by 2002:a5d:6d03:0:b0:381:b68f:d14b with SMTP id ffacd0b85a97d-3888e0b98d0mr12740846f8f.45.1734444560749;
        Tue, 17 Dec 2024 06:09:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80605casm11402211f8f.86.2024.12.17.06.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:09:20 -0800 (PST)
Date: Tue, 17 Dec 2024 15:09:17 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg KH <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Trevor Gross <tmgross@umich.edu>,
	Adam Bratschi-Kaye <ark.email@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v3 0/4] rust: extend `module!` macro with integer
 parameter support
Message-ID: <Z2GGDVytlj5enrUC@phenom.ffwll.local>
Mail-Followup-To: Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Trevor Gross <tmgross@umich.edu>,
	Adam Bratschi-Kaye <ark.email@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
References: <20241213-module-params-v3-v3-0-485a015ac2cf@kernel.org>
 <4Dsa69UGULRGsMbRbwOJNp_puyfsSSFt1QTcYU9AL4azd8vbfEFFtc7YNSsGegc40AfCZqVqZETfxg4TggUlSw==@protonmail.internalid>
 <2024121324-overdue-giggly-bdb8@gregkh>
 <87frmrepo5.fsf@kernel.org>
 <CAH5fLgh+iOefU3vG=e8aAFhcKh0W=6M0odUt3s_wfDKW+rGNOg@mail.gmail.com>
 <8734ireo4o.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734ireo4o.fsf@kernel.org>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Fri, Dec 13, 2024 at 01:57:59PM +0100, Andreas Hindborg wrote:
> Alice Ryhl <aliceryhl@google.com> writes:
> 
> > On Fri, Dec 13, 2024 at 1:24 PM Andreas Hindborg <a.hindborg@kernel.org> wrote:
> >>
> >> "Greg KH" <gregkh@linuxfoundation.org> writes:
> >>
> >> > On Fri, Dec 13, 2024 at 12:30:45PM +0100, Andreas Hindborg wrote:
> >> >> This series extends the `module!` macro with support module parameters.
> >> >
> >> > Eeek, why?
> >> >
> >> > Module parameters are from the 1990's, back when we had no idea what we
> >> > were doing and thought that a simple "one variable for a driver that
> >> > controls multiple devices" was somehow a valid solution :)
> >> >
> >> > Please only really add module parameters if you can prove that you
> >> > actually need a module parameter.
> >>
> >> I really need module parameters to make rust null block feature
> >> compatible with C null block.
> >
> > Instead of providing module parameters to Rust code, you could
> > implement that part of Rust nullblk in C. That way, you discourage
> > future Rust drivers from using module parameters without making it
> > impossible to have them in Rust nullblk.
> 
> If the opinion of the community is really to phase out module parameters
> for all new drivers (is it?), I can maybe move the code in question into
> the Rust null_blk driver.
> 
> I was kind of looking forward to having zero unsafe code in the driver
> though.
> 
> On the other hand, rust null block might not be the only "rewrite in rust and keep
> compatibility" project to ever see the light of day.

We still have tons of module parameters with the _unsafe annotations,
because they're really convenient for debugging and testing. Yes they're
hacks, yes you cannot use them for production, but they're useful.

So for drivers I'd say we definitely want to keep modules parameters
around, they're just too convenient compared to debugfs, especially when
it's things you have to set before the driver binds to the device.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

