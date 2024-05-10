Return-Path: <linux-kernel+bounces-175285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204F78C1D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C474C28370B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317AF15E5C4;
	Fri, 10 May 2024 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jAYtvQCS"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3183C152786
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715318118; cv=none; b=G1/yTGliJLT639kXHlnXzNA05RhbVR8Yr5iODl3g/PwK6eYdzhtqyRBinKiQaksNcB3QqnunDmKQLrOY7o5anagz88wtj4HD4B6xC8/aFSkTvrbHvYoOfZBz1TtuaDXTxSwpP/HI2jAMdhBTVAmfLwyokIayDtM2GTxJM6c2tbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715318118; c=relaxed/simple;
	bh=5g9aqIrd/CSisewRoD5xcikITn2+u3Jq5S9fr5CZlsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcsfYZw69ahyqeXrJcBvlleBA/GCXMW768K18MxgI65c4I3yrbYUMogMAZ8BbOwO1xbRo8Hxmet3gJA1D1dZJyTNTNmXn0CIkd2TF6OWXQGYfAxzEycWX6ZHnflb3SC5EZSxNZgpE/Tc1QNq3ZxtLnPqIaPGR6P/TQ5bdd0qg5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jAYtvQCS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ee38966529so19511665ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 22:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715318114; x=1715922914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgyaaXbsvqD2LsppPxdAFhGM87M6tpgqLYTXW/9G1I0=;
        b=jAYtvQCSKlJWdnaFqFm4oNeLQoEAzIowF/acMcKaHs4OpQBRIWGiZJUEeH+ZvjeJgB
         xYZpWOX60x7zP9W/IenR4AthpIH/GQJ1zjGLFM5iA/87NR1MUNmphfBYMNWUVOI4cP5h
         fYgF1do73z6V0w0IBpWiaBUOKMzkB0Fgx61IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715318114; x=1715922914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgyaaXbsvqD2LsppPxdAFhGM87M6tpgqLYTXW/9G1I0=;
        b=vROSHe8tRE5cj2Xq9TBqq3iSaoAz7NWBlXK+L222GELBFhAFeJjGBwtTNKKU1V/q3O
         15O8Fu9H/ZEMwPYp1fqJcqwo43HL40r6hdoaHu4s+M01AxpweOG4B/6WtF9hrMTV/CO8
         mte2yeBvwfcRfEcvOONdPYejV/lr22mpKOjyFsQDHChzFWm6z4GvwDzorgj9QOALG/ut
         4hlAga8MOWCT3C47P/kBSYxeMdS9u/Fv+NCgiDhmpwSETFhCtQm1kMXrP5uiBVQ7Iz7I
         vzPaZMSpgb6235osWB+NPlsy1e0H3mc7A3yTJDqP5GlFO4w7bEQgsmCQ0jprodJiGXmC
         /9Sw==
X-Forwarded-Encrypted: i=1; AJvYcCX/FoKAnUQl20DPMlfiz3JTcHklC5ITCjkRnj/5a55BINYDLUQTd8bYIdd0g6QaATb2Gu7a/OqTS7OhDqwKNuWVwak3p+iK/lzv4sQz
X-Gm-Message-State: AOJu0YxP9P23RLDtIO87nRgl5sn2Ir0heEkQ3FEIDqgEXJ7hAMxgLO/F
	TEfbQJ5i7RxB7F4Sr+H94TMGbSZBqKLQHK0veZPt6410xCTh80HOpTR3BF5dQw==
X-Google-Smtp-Source: AGHT+IH7Hm/lOPljffiTQlTyKmy5eyFByNf3HR9v7FBg8O8DcfEkdnc1sFp0c5lqNAE+UzNDn6j1fQ==
X-Received: by 2002:a17:902:f68f:b0:1e0:9964:76f4 with SMTP id d9443c01a7336-1ef42e6e646mr25664035ad.14.1715318114238;
        Thu, 09 May 2024 22:15:14 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de58:3aa6:b644:b8e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136b2fsm23433415ad.241.2024.05.09.22.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 22:15:13 -0700 (PDT)
Date: Fri, 10 May 2024 14:15:09 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCHv3 00/19] zram: convert to custom compression API and
 allow algorithms tuning
Message-ID: <20240510051509.GI8623@google.com>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
 <ZjzFB2CzCh1NKlfw@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjzFB2CzCh1NKlfw@infradead.org>

On (24/05/09 05:43), Christoph Hellwig wrote:
> On Wed, May 08, 2024 at 04:41:53PM +0900, Sergey Senozhatsky wrote:
> > 	This patch set moves zram from crypto API to a custom compression
> > API which allows us to tune and configure compression algorithms,
> > something that crypto API, unfortunately, doesn't support.
> 
> [...]
> 
> >  21 files changed, 1203 insertions(+), 111 deletions(-)
> 
> Why can't it?

Well, I asked crypto folks if that's doable and the only reply was
"did you try using compression libs directly".  And that's not a
bad response, I take it.

The handling of parameters becomes quite intrusive very quickly.
It's not as simple as just passing a new "struct crypto_tfm" to all
sort of API abstractions that crypto has, it's a little more than that.

Just as an example.  For zstd we can work in two modes
1) load the dictionary by_copy
2) load the dictionary by_ref

In (2) we need to guarantee that the dictionary memory outlives any
comp contexts, so cyrpto_tfm-s now begin to have "external" dependency.
But if we load the dictionary by_ref then what we can do is a
pre-processing of the dictionary buffer - we get CDict and DDict
pointers (specific only to zstd backend) which all contexts now can
share (contexts access C/D Dict in read-only mode).  For this we need
to have a pre-processing stage somewhere in the API and keep the
"compression's backend private data" somewhere, then somehow pass it to
context cra_init and release that memory when all context were destroyed.
In zram I just went with "we do only by_ref" and handle all the
dependencies/guarantees, it's very simple because all of this stays
in zram.

But in general case, a typical crypto API usage

	tfm = crypto_alloc_comp(comp->name, 0, 0);

should become much more complex.  I'd say that, probably, developing
an entirely new sub-set of API would be simpler.

So I implemented a simple zram comp API.  I can't tell how much effort
it'll be to handle all of this in crypto, I'm not really familiar with
crypto, and I'm not sure if crypto API folks are even interested.

> This is an awful lot of crazy code duplication just
> to pass a few parameters.

I see what you mean, but the majority of the code is unique, there
isn't too much code duplication in fact.  Params handling is unique,
dictionary handling is unique, zstd implementation is entirely
different and pretty much specific to zram (we don't handle all sort
of cases that zstd API support, we focus on things that we need),
lz4/lz4hc implementations are also different, etc. etc.  Things like
lzo/lzorle may count as code duplication, but those are like 20 lines
of code or maybe even less (which isn't that crazy).

