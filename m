Return-Path: <linux-kernel+bounces-291308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE39560A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7763AB2282E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92AE1B95B;
	Mon, 19 Aug 2024 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJMy2M5/"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996151A270;
	Mon, 19 Aug 2024 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724029145; cv=none; b=hyclH2g74Te3sAIx41xAoLQ+WQSrDUVl4cFXCsM6vdc4Ky+MUIbJ4tP++QyO0moKpAvIYn3o4EaWDtFVNCxtDPvF/TMz5bkW5HY9rQLPHeMNYwfJBylCngdby9yBD0XYyT8XD2LU7thLdcUzYDCzVS1wbqsFhtUIIO7DTgYP+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724029145; c=relaxed/simple;
	bh=ePUdj/ZE81OvktmETgRpWvt5LKmsFGszZ8HNCE9wMsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsjnTw69kS4FmnIpVTapAoG+H8hiQgaSjoPYfkXlYRMA03A7zt6K0x/eP0/m7q7NUSNsX7EYbeGJ7Bbso8ahfXC4wkCzuLaeZp8NgU9a9wpdQmRrq+0KpCbfWghvOAu2dRkBoI0JTGyTBLdzqcWEanoSCUnI4cJN4qqBac6YrJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJMy2M5/; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6b424e001e6so15225827b3.2;
        Sun, 18 Aug 2024 17:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724029142; x=1724633942; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gBEN4kKahlifSMx/vtIFM18E4PBGnSMiEn2+NSH1nGg=;
        b=bJMy2M5/bIcYZ8nhbCOaOnqtdUhrBsDGX/Eg1t4MFOu9ejPiXNMYCodM25XcYY3c7p
         qm56kh9OY6/ocQez3hvFreiKU8V+TMYgHG63y4XUS59YxrI7GwPkn/7rIGPNZ8oKP/zZ
         hLxN/dtsxKFxGLIDxZrZs30YJLgus3wmuyRk4ZZ9Hg6Ttp4GZ9NS7JVvfSFO10b6IDjb
         uCjzM6uoW/oeHKBhM6ZaH1wbjpb8lJSZC7Kx3jubgYZZlqi9PG6TIw4i0SWBhqboXh6X
         KoJtOKUUHiBOCuSokZpg/Zywo/tgGN2MXgUcbqVEJIVaOtWZijmI03eFu6vRkJ0qZwBP
         4eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724029142; x=1724633942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBEN4kKahlifSMx/vtIFM18E4PBGnSMiEn2+NSH1nGg=;
        b=c6mOVng4QWgRF24RY+VlH1WI0LaNZyffINVWF23dxi4clurdryJyd51uAAozEHa3gc
         D0RHaxvTwRWPORnCOFPolbQQd3NrsXDwFDTtOOzDRb8EJik4MwRsiopx0UW2afrmQZvY
         svEkATbD56ltr0ceGWptmsROmiGU4W/yRSnJB6ommqpcxXrsi4+Ys++Mx0NEDBX85+CM
         FcSAliWSQWllO8lDt9bov0YhKtLOsr0FE4TypPckPfOfGfDVI20vJx+TfPKqBN0LPVFA
         Z99KrVhtkM0bThkHHDTOWqSVHZiHijibAbSDnQgXoUy4JNlMhXmf/AuuArNREpBK5kjw
         C0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCX9ReAHR2IMZ6NpsJyjFf/98H6I+lZrnbNzxYy+7cRswyMisdOUq4nBk75vAw7fcx5wLTKCmaduMgejPYiFl5ht/P3V99w9AjXqzdo/A7LW92Uoe/wOw0zLeJZcoB00zZ9gqGNID40a8v7kWSw=
X-Gm-Message-State: AOJu0YwJklVtd5+aqgcCzE/DNHoLUgBiUCjBc0ufsSB1lUSlW0tTC52y
	aHPD2aaMy4ITsW9apbaPxwopU+Ux4tmcqi3EEIUwKCLQ/C88Huoq
X-Google-Smtp-Source: AGHT+IFU3KNwLbwBlHWJk5u3x4m19dvb3MVpayig68r2+FsWJJFHJefHCurxG/Wb+CyR/2R5ha5U5A==
X-Received: by 2002:a05:690c:f94:b0:6ae:1e27:c994 with SMTP id 00721157ae682-6b1b6ebe997mr102775347b3.3.1724029142556;
        Sun, 18 Aug 2024 17:59:02 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef223csm38478526d6.122.2024.08.18.17.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 17:59:02 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 9AD6E1200043;
	Sun, 18 Aug 2024 20:59:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 18 Aug 2024 20:59:01 -0400
X-ME-Sender: <xms:1ZjCZnDU6PyIo68SRh-tDJOhRGpDDMcb4R0rql_EcSZAkSvbaoOQ-A>
    <xme:1ZjCZtgvNR0sYQi2SlF9wjhEH1xcbJVaMYT9cedxmNli8xPEIH45TPh9Adjf0UJC-
    UFoGwKoJKKXhTrdNA>
X-ME-Received: <xmr:1ZjCZinHIZv5SGdyHNSxdbkNLZ0Ugx0oXWnlhoVPBKL8F3lvCZMVR-6n1L8vZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddufedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeekgeettdelffekfedtveelueeiudevjeeg
    ieekvdegkedufeetfeeiiedvueelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghi
    lhdrtghomhdprhgtphhtthhopeifvggushhonhgrfhesghhmrghilhdrtghomhdprhgtph
    htthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthho
    pegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhih
    hnuggsohhrghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhl
    sehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:1ZjCZpwOANPZazV5QB3I6LkmQmXu2OptxtPoWsnHOo8gcbpji03hZA>
    <xmx:1ZjCZsQkOuBNiSw8-RBuHFteEuzOb55kzO8t9JTAnL0DrjD7ZqqESg>
    <xmx:1ZjCZsZbYBPc9dXwklde_2gamCAqah_zlfBYRoNLJqfWOzBJznwXEg>
    <xmx:1ZjCZtSIoJMRnZg85lt06dfe1cz7ZFGmRs8stmP8UWx1iPQK64IWGw>
    <xmx:1ZjCZiCHaRroXeIm9puOh5ManX3P845GlksbcA5y0c4sHPTFFgZpVr4V>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Aug 2024 20:59:01 -0400 (EDT)
Date: Sun, 18 Aug 2024 17:57:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: rust: auto generate rust helper exports
Message-ID: <ZsKYcdN2mC5Ud6SJ@boqun-archlinux>
References: <20240817165302.3852499-1-gary@garyguo.net>
 <ZsFEpjvE9osKDb3b@boqun-archlinux>
 <CANiq72k81VrS+3Skh7gfYzkcxTsGscUJOhroV4MXH-LZgroZFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72k81VrS+3Skh7gfYzkcxTsGscUJOhroV4MXH-LZgroZFg@mail.gmail.com>

On Mon, Aug 19, 2024 at 01:40:44AM +0200, Miguel Ojeda wrote:
> On Sun, Aug 18, 2024 at 2:49 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> >
> > This also passed my test script (x86, arm64 and riscv build and kunit
> > tests).
> 
> Hmm... I think you either tested another one, or you manually fixed
> the dependency (`$(obj)/helpers/helpers.o`).
> 
> Or am I confused?
> 
> > Miguel, I think it makes more sense if we take this one and the
> > helpers.c split one as early as possible, given they are treewide
> > changes ;-)
> 
> Agreed, we should take it soon. I have rebased it on top of
> `rust-next` and fixed the dependency.
> 
> Please take a look:
> 
>     https://github.com/Rust-for-Linux/linux/commit/0d6e3e8d3677ee7b5cccf9bc002e18f140c02a4e
> 
> I will put it in after we confirm we are not confused :) (and after we
> get a linux-next round or two for what is currently there).
> 
> Extra `Tested-by`s would be nice!
> 

I cleaned my local .kunit cache and re-run all the tests, they all
passed.

Tested-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> Cheers,
> Miguel

