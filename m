Return-Path: <linux-kernel+bounces-343350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1726D9899F4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8901C20B65
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 05:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ABD137C37;
	Mon, 30 Sep 2024 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amDFHv9x"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DAA23BE;
	Mon, 30 Sep 2024 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727672958; cv=none; b=mVcOcokzoFwC5mrv2bBQ2lehF3Bnb61G7fkhKlU3BpMHZXrHHda/6SlULDUU74XIhq+ci2SiBCKxSAsK+vEdead6au0MDC76pnwtFPj1oQ0bH+eGv3frF0N2QBXpvrklW1iWUYhYOp3gjUEaYoeD4U6b4/AWB39OgLFnxzNh3sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727672958; c=relaxed/simple;
	bh=UbHWEaB7PDuBUSDpo7Tutlq7wTW1KTkCg/ybILA2p+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=serj9F+Cqes52OOfTWRdrnXtY36OQbDgkz8tCh/fyTpxessDIX1mj6Hculd0ydVFqJMzNZKw60esxCjBWu9kVARWZvcynjOQgzH49GEZ0UBsIRjs/TndreyaLvhAD6TTjkprb58cnoYW6/26ygf5GoGSY0AhqqXimQxhc1Hv9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amDFHv9x; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so31529095e9.0;
        Sun, 29 Sep 2024 22:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727672955; x=1728277755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXIKicQnXQqkPAeb5QE3EDHC9btaxuSEd8KnxbSJwJw=;
        b=amDFHv9x+DJWjYaNjWcJQ0VbiQeHM55LRu/RdB1xYQEhRjn20plklFRijfs7b5+H+N
         yydhqB6e5A4uiU1IjYO+g7UYOtH+AlwNT/8TLGUpC7bIqW0Vl5l2J8HTa+l2+lzR6MQv
         +IlhGNd18IHgDbGEi9M7A/xZVnj+Y6yPj/Yld0lIqRPiBs4Dq6v/V+9IqzvIzN2ppV3M
         rRkTvzPiLe2QDQTq5ykg6gfE3mfWFtyyHURSJd2zZVgE7FpJUknQ39KXyNA+Qz1RtrZq
         fsoE6/OAJsQYqQa3jtsZtDD4RnZ4gi8+WpUlf3qadintZwyBOrlBNwV0M+oUQO6rmjIw
         lhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727672955; x=1728277755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXIKicQnXQqkPAeb5QE3EDHC9btaxuSEd8KnxbSJwJw=;
        b=FiP21rI3mkYpEge0JElk+VshkigRNVENJuC/E2ydJkvC7XdSATW+FqPRIO95zBTfzv
         hdDwM0hrslTOS4unMqrshjZdLHsd58PER/wQsuZRwDEogJw0ODUdUGJThZ1OFXxdCl2e
         /U+vxpVIdk3YiJ5vVd56U3po/R0CedoPsvCc9sgrTVbGMoWOMYKxK0NY6LdgLP1+zMVR
         nPyxOnHDCkjnpv3EFhU2tgDuXGSBL45JdHBjlm8BAqUlA393GNIEL9/Xf4bOwgwJqyF0
         6PZgT0YUyHbAIx4atBwEQDNyXaYpIFl/pDQ9F4NFi/+bLtLCQHR8c7BiBQAnmWYSnoSf
         qxLw==
X-Forwarded-Encrypted: i=1; AJvYcCUoHDfjGQ2fE6bqJGBJAOG4JIGV1uxo41Q9O+PQ0eOHrWkcGwtZKjKvAnppp/t3lTh5hVLuUVqEkQuEitclf8s=@vger.kernel.org, AJvYcCVVW5gBOIDWXCluJukORbRtthjU8nTrKh4YDcO5mkyMvcRdci8Yzgq5KoUqLTX7l9kR7TCNxQNtCLeogxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHzKKJ8152SQ3RnLboiYVTTCaFyIc/Itde2oOs2IucWOEgmb5i
	SKb9jwv1hHY/ECe/wFXByGzKJH/kQmxCvpe6RtQzeXHsc2prnDhR
X-Google-Smtp-Source: AGHT+IHsvJ0KqrRCDuqVkruOgQCOFi+aXkLpIjDF35uwepKZn3kHo1CaoAZHKBhD6nVxbzhhPWLFqQ==
X-Received: by 2002:a7b:ce8d:0:b0:42c:a8cb:6a96 with SMTP id 5b1f17b1804b1-42f5849939fmr85991435e9.31.1727672955341;
        Sun, 29 Sep 2024 22:09:15 -0700 (PDT)
Received: from redaops ([146.70.124.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddfc9sm139972905e9.5.2024.09.29.22.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 22:09:14 -0700 (PDT)
Date: Mon, 30 Sep 2024 08:09:12 +0300
From: Tudor Gheorghiu <tudor.reda@gmail.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: re-order exports to fix rustfmt
Message-ID: <ZvoyeO8pUJBwkYEM@redaops>
References: <20240930010931.64080-2-tudor.reda@gmail.com>
 <6d08a751-fbeb-4dd2-af78-32ae89704208@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d08a751-fbeb-4dd2-af78-32ae89704208@de.bosch.com>

On Mon, Sep 30, 2024 at 06:15:32AM +0200, Dirk Behme wrote:
> On 30.09.2024 03:09, Tudor Gheorghiu wrote:
> > In the recent rust-6.12 tag merge at 570172569238, the rbtree export was
> > added after the sizes export, thus breaking rustfmt's alphabetical
> > export ordering rules.
> > 
> > Signed-off-by: Tudor Gheorghiu <tudor.reda@gmail.com>
> > ---
> >   rust/kernel/lib.rs | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 22a3bfa5a9e9..b5f4b3ce6b48 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -44,8 +44,8 @@
> >   pub mod page;
> >   pub mod prelude;
> >   pub mod print;
> > -pub mod sizes;
> >   pub mod rbtree;
> > +pub mod sizes;
> >   mod static_assert;
> >   #[doc(hidden)]
> 
> I think we have that in rust-fixes already:
> 
> https://github.com/Rust-for-Linux/linux/commit/ece207a83e464af710d641f29e32b7a144c48e79
> 
> Dirk
> 

You are correct! I didn't check rust-fixes, as I was working on
something else when I noticed this.

Thanks!

Have a great day!
Tudor

