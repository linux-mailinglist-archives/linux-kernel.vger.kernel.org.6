Return-Path: <linux-kernel+bounces-527567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95316A40CAB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 05:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595907A8247
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 04:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1551D6DB4;
	Sun, 23 Feb 2025 04:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AGEvK1Qw"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8EB2AF00
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740283373; cv=none; b=ci4qFitUJRnh6Jqt5D1S6JMiBM2jJ1UA52sJoYbGFDQYPRw3zqWRQuwl1HdbgJCmcFi3rZMtqA483WtOnOd7ensoWWfeYgWJHB4CAFNL0PStxM/d/J4C1b7TpyY4Om2qM/x5UsRgsAmrWMoXZNYWg+c6u17QCPkPl6BZ/RQHEIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740283373; c=relaxed/simple;
	bh=kt8bEOKaMXqsB0Hnd+Ix9Yl8lVrPfZwch4RRsQ42UUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT30jVc803U+7o2lN1yywNhVPISZ40aknxfFhUC3MSN/rpejnDiJN2YJJsReDtqxmzOMcJlmd8+2lU+/7YAVCZS+xViJuZez86aUMwJlj3HDc6hH1Fcc9dQjFxJy0HJfVFNL8OtqCIo7V7+hJVZf/fpIRhV9wNM2d9rjPfvonyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AGEvK1Qw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fcce9bb0ecso6674518a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 20:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740283371; x=1740888171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7X/a6yKMJK840olzn4NcUlQ7572WIMjZpQOK9Wp6mVY=;
        b=AGEvK1QwAMZZp4zt9oUGtimLr9w/pfh2rXu+hbuqUkQM/VMjchb2ShYenwUbZkKMyI
         fduKGGGNrLUfrHIw94WVm/CJBQh6YvYLSWFTLunfVS/VG3jpGaV0Ui73rf2ZeYcmWKEZ
         KgKd4PvO7T74tl9moKQjRQAH/+/iLxLa3xLGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740283371; x=1740888171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X/a6yKMJK840olzn4NcUlQ7572WIMjZpQOK9Wp6mVY=;
        b=X2y0jqZIk4Gby5tZeyg8KA4zHK7vLPDt4TT3dr/SjHxuseGsbicSYFTmTRDb6rLAtu
         Bw0IVtAm9Y3I/WzX4zs/Z0/1MCmY1dgOc1zQmTTK+6aiRmwmCdaK1NJUFUU8xeHf+O8W
         iueqe1v9rS4uJ4RAOc+F4SNhJ6IwE9y76xsxVtVYo4uw/mqb/+gENkM2HrdvisbCRtdl
         ZanyOfhEVa7PalTvaJWY5SDGSf7gOavrmGeVDRvfEELWkpZeU9EszfEMnHiqDIlymq5W
         bv9ZbFMjNT8iToQmMOifr5Tp84neBbgqUXnTOePmCNFaXznTrUWWAVpW87XnzL+FVBAr
         eGIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+aEcF8TrnGdvKTgG4vGV2naMqq5UuFB73H4Ty5eH8yBcqE6Ry1SN+RLOEtU+j9oF9DQZv5xi21M5f/oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVq2upHgXg4ZYjTG/Xxr+1H9RNUBLVeac/hMqWlco8B0gGGy0s
	4BIsR/Hk6FYOWYi0Komwr3FJtnNnPHFjzK3gjlstBCuw6D3vJ8N2Cdh5XVt4oA==
X-Gm-Gg: ASbGnctKjVnyK7nlwPRZWRcn8lE/Kzo8Citd5oFxMLlXPD9GBEHFLuEWLkNvTiq/Xbw
	hodgZhC9ILlnxMlCXYyWdS20zmwQrp0oK8iCqyq9SJQGYpnxKfB1h2VHZnfpFl4mb4Mv4c+1lyZ
	TKXCxEoM047k3KTxHRil8yjy16U1kcsu8w9IL1K3/6RAMgVJN2SvKJOU1UFUecdZYBEDM+fjNQr
	ui+CdSVtgyZ0zEPkD4LQNom827tMc89TnVeRimC6FHM7R/MOnLAl3lQy0I16skqjOy9RLLBixwU
	dHK6xrdQsUZZgNU2D4mUXFlyMUHn
X-Google-Smtp-Source: AGHT+IGGp+0kbnPW/KjNjCOzaQWqa83C+/uSTXFIzfy4XdmQFLXNo8MIxjAHIe5svT4w4lKj1mV4VA==
X-Received: by 2002:a17:90b:37c7:b0:2ee:8ea0:6b9c with SMTP id 98e67ed59e1d1-2fce78a508dmr16896210a91.12.1740283370980;
        Sat, 22 Feb 2025 20:02:50 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:badf:54f:bbc8:4593])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556fbeesm157324385ad.183.2025.02.22.20.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 20:02:50 -0800 (PST)
Date: Sun, 23 Feb 2025 13:02:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Barry Song <21cnbao@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Minchan Kim <minchan@kernel.org>, "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, "usamaarif642@gmail.com" <usamaarif642@gmail.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "ardb@kernel.org" <ardb@kernel.org>, 
	"ebiggers@google.com" <ebiggers@google.com>, "surenb@google.com" <surenb@google.com>, 
	"Accardi, Kristen C" <kristen.c.accardi@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [PATCH v5 02/12] crypto: acomp - Define new interfaces for
 compress/decompress batching.
Message-ID: <o7qvt25dxoxcxj5ec2tbf5y5nopi4mkiuklo63rnyc7bldxwdm@2l5lkllmaynk>
References: <Z7F1B_blIbByYBzz@gondor.apana.org.au>
 <Z7dnPh4tPxLO1UEo@google.com>
 <CAGsJ_4yVFG-C=nJWp8xda3eLZENc4dpU-d4VyFswOitiXe+G_Q@mail.gmail.com>
 <dhj6msbvbyoz7iwrjnjkvoljvkh2pgxrwzqf67gdinverixvr5@e3ld7oeketgw>
 <lu3j2kr3m2b53ze2covbywh6a7vvrscbkoplwnq4ov24g2cfso@572bdcsobd4a>
 <Z7poTnlv-1DStRZQ@gondor.apana.org.au>
 <u7t7gibspxu3lujdl4hambr72qd6o5u33udbojihngznlyistk@gmyyhwjuiwxc>
 <Z7qNf4NerHrflmfV@gondor.apana.org.au>
 <cxspxz5jeiigd34cl7x3asyx4lowefjpffj3ip4mwpxdwh34e6@xzpqbmlihbcg>
 <Z7qYUCAqh2YFQ908@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7qYUCAqh2YFQ908@gondor.apana.org.au>

On (25/02/23 11:38), Herbert Xu wrote:
> On Sun, Feb 23, 2025 at 12:12:47PM +0900, Sergey Senozhatsky wrote:
> >
> > > > It also seems that there is no common way of reporting dst_but overflow.
> > > > Some algos return -ENOSPC immediately, some don't return anything at all,
> > > > and deflate does it's own thing - there are these places where they see
> > > > they are out of out space but they Z_OK it
> > > > 
> > > > if (s->pending != 0) {
> > > > 	flush_pending(strm);
> > > > 	if (strm->avail_out == 0) {
> > > > 		/* Since avail_out is 0, deflate will be called again with
> > > > 		 * more output space, but possibly with both pending and
> > > > 		 * avail_in equal to zero. There won't be anything to do,
> > > > 		 * but this is not an error situation so make sure we
> > > > 		 * return OK instead of BUF_ERROR at next call of deflate:
> > > > 		 */
> > > > 		s->last_flush = -1;
> > > > 		return Z_OK;
> > > > 	}
> > > > }
> > > 
> > > Z_OK is actually an error, see crypto/deflate.c:
> > 
> > I saw Z_STREAM_END, but deflate states "this is not an error" and
> > there are more places like this.
> 
> That would be a serious bug in deflate.  Where did you see it
> return Z_STREAM_END in case of an overrun or error?

Oh, sorry for the confusion, I was talking about Z_OK for overruns.

> > So it will ENOSPC all errors, not sure how good that is.  We also
> > have lz4/lz4hc that return the number of bytes "(((char *)op) - dest)"
> > if successful and 0 otherwise.  So any error is 0. dst_buf overrun
> > is also 0, impossible to tell the difference, again not sure if we
> > can just ENOSPC.
> 
> I'm talking about the Crypto API calling convention.  Individual
> compression libraries obviously have vastly different calling
> conventions.
> 
> In the Crypto API, lz4 will return -EINVAL:
> 
> 	int out_len = LZ4_compress_default(src, dst,
> 		slen, *dlen, ctx);
> 
> 	if (!out_len)
> 		return -EINVAL;

Right, so you said that for deflate it could be

       ret = zlib_deflate(stream, Z_FINISH);
       if (ret != Z_STREAM_END) {
               ret = -ENOSPC;          // and not -EINVAL
               goto out;
       }

if I understood it correctly.  Which would make it: return 0 on success
or -ENOSPC otherwise.  So if crypto API wants consistency and return -ENOSPC
for buffer overruns, then for lz4/lz4hc it also becomes binary: either 0 or
-ENOSCP.  Current -EINVAL return looks better to me, both for deflate and
for lz4/lz4hc.  -ENOSPC is an actionable error code, a user can double the
dst_out size and retry compression etc., while in reality it could be some
SW/HW issue that is misreported as -ENOSPC.



So re-iterating Barry's points:

> My point is:
> 1. All drivers must be capable of handling dst_buf overflow.

Not the case.

> 2. All drivers must return a consistent and dedicated error code for
> dst_buf overflow.

Not the case.

