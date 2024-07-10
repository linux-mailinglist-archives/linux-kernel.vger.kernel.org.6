Return-Path: <linux-kernel+bounces-247160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D0092CC01
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE101F22BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8290784D0D;
	Wed, 10 Jul 2024 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+cXkk9n"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEA556458
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720596988; cv=none; b=I8diXBky+yNMLBN/EUAD0ujI6x88+UFC47ZQ/GbG5x1VP0uN0qpSLn5O4gf4UEnkP7zM4Czf0iYdPpLYpSi7hTKYIke+ZZSEf838iZSc2pq1KMfIpXmca863E36tkwtD2ghrswZYyw0Nu5Kzn14ekjbGnHxlSmVDR6SK9YPhPxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720596988; c=relaxed/simple;
	bh=AXDTQiOUe+sk2xVyvNXQw8kniv5/H1hlzYclQjp88nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caoL3D0I2SR9mv2n+qiM1ybnih1ypGoVMDlmwwIhmhORYrYhbHsNjKUPtbH9tFZmtUQHah+7HRuKfJvx9EXpy1XBiRCil87lXam3CKybMAoluSvpiodCUmnmczVjPEiph6WVyCALbkrCP5oqjTnhtO+X4LhR2WppRFViNnHAr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b+cXkk9n; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70b4267ccfcso1731012b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720596987; x=1721201787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ib7gCSaVLlpxg25S4ZxyQLMvzlSiQ7LEAEKDAEqbxxI=;
        b=b+cXkk9nlTvsQncBuLaPLoRiXQvjttPTvw/139tAfsFpkiasxmTZm/kbVnniGszKmI
         PKw+SA6GDJey2aQp229at7e7bJDuGfdKeKUErt+Haw0CXKHMBzmzTwDWSaTr4koif/An
         7QGYuii0oOwH9yqEZn/z8W7Jqp32pvH1yD1r97PapdBSzu4oC0225hfHiEfCUtaL22KE
         JpIJ01SRy80snehVqjg3S2rugAuGwqyHdzKcdZ81IAh9jlUj0gax7DEzDOeFmbgoGzDz
         J55BIx7Ol5OTNiqGgavb7tUX6sqkuP0yH0QT+E6Pq95ib4VdxAXzAX1XFzblMpRCXHlw
         IshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720596987; x=1721201787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib7gCSaVLlpxg25S4ZxyQLMvzlSiQ7LEAEKDAEqbxxI=;
        b=oHS9srorHYOe6Vhey/7yRaONk4R09Oz3KxnsY4STrHNI/wYF6NAE7uwL/k6M1K5GqW
         YnQb4QcwPZAB2gH0k6RvWPADz6gCnXhTNCqmoT//BL51/5MiPaTOm0EJNIJKlXNidZf6
         JeVG27ylcrxcaxRgBNLxdj8bMwQVMlHezymZdcFKftMbyAuz+3NM2+3j1Fl7V8BMu63A
         MJMr449mVeRQ0qEAact8iSmmBToVrF2pAUitJngLQxyYkd57tgMuuLLFr+BWOF4Ajm5U
         FK5/U4GdRqtjPJGjKF2F0clVz3qWVTbHwdWSdv58XMC0QcKmY62SnBpsW3tCb3DFxN8s
         s80Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrKYYgqKHBdINcxo2tvMddybd4+wWdLU8FMFv7N6BxLKeZWjv9MtdCRK/iycNOoQ6G4fOk6oeExf7NWJSVIDSjtEmiq1QbA2d2oZcv
X-Gm-Message-State: AOJu0YyRs+zdt7GevT7RRYOyzfvBAYzWcCicpq6/oUNuZPeLRqrf8EBc
	f6HI7/DlremDDYnBYZ23kGx7me309Mcw3xhONUtxOJDX0k2QJq1SXb6/7omWFwk=
X-Google-Smtp-Source: AGHT+IHg433AhW7OnnB4QmPzublPxbiEIgkyNA0iz+B1GaI1iSou2hECJs1ftjC8msq7230tW5DcQg==
X-Received: by 2002:a05:6a00:1251:b0:706:700c:7864 with SMTP id d2e1a72fcca58-70b4351fde0mr6327577b3a.4.1720596986761;
        Wed, 10 Jul 2024 00:36:26 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b9afbsm3065996b3a.191.2024.07.10.00.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 00:36:26 -0700 (PDT)
Date: Wed, 10 Jul 2024 13:06:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V3 1/8] rust: Add initial bindings for OPP framework
Message-ID: <20240710073623.qdxatsqvumkguabp@vireshk-i7>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
 <fe8e9a96b29122876346fc98a6a9ede7e4f28707.1719990273.git.viresh.kumar@linaro.org>
 <ZoVvn0QCSR8y4HQJ@Boquns-Mac-mini.home>
 <20240709110245.o73xnrj6jsvz2v2w@vireshk-i7>
 <Zo13PB-fZ8B9WEYy@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo13PB-fZ8B9WEYy@boqun-archlinux>

On 09-07-24, 10:45, Boqun Feng wrote:
> On Tue, Jul 09, 2024 at 04:32:45PM +0530, Viresh Kumar wrote:
> > On 03-07-24, 08:34, Boqun Feng wrote:
> > > On Wed, Jul 03, 2024 at 12:44:26PM +0530, Viresh Kumar wrote:
> > > > +// SAFETY: `OPP` only holds a pointer to a C OPP, which is safe to be used from any thread.
> > > > +unsafe impl Send for OPP {}
> > > > +
> > > > +// SAFETY: `OPP` only holds a pointer to a C OPP, references to which are safe to be used from any
> > > > +// thread.
> > > > +unsafe impl Sync for OPP {}
> > > > +
> > > 
> > > Same for the above safety comments, as they are still based on the old
> > > implementation.
> > 
> > Do I still need to change these ? Since we aren't always using ARef
> > now.
> > 
> 
> Correct, you will still need to change these. You're welcome to submit
> a draft version here and I can help take a look before you send out a
> whole new version, if you prefer that way.

I am not entirely sure what the change must be like that :)

-- 
viresh

