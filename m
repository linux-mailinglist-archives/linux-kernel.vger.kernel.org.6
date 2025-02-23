Return-Path: <linux-kernel+bounces-527562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 129D0A40CA1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 04:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAA13BC692
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 03:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DF628F4;
	Sun, 23 Feb 2025 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CclgYAEj"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A92747B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740280380; cv=none; b=jSv9yx3zymMFBwUoyE4SmLwcUHnSnzyYtO46VV+T7QBCtqtxKNjm85gTMMEQ/53sZdN9WpVjz2PP5+KonMI9YQmyc49FzWtAnvyE2Z3bMmMCweIL362eB6vu3HgilrNR0h9ZW61UOjCt6ZaVZ2dVz5mgjbcKGnbp6D3HhWsbG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740280380; c=relaxed/simple;
	bh=qZgYp4hiy5AbktBK/6uq9C27b6p0D2oN047rwlhl410=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEZoT5IMWKPBnvelngD09JtSffVn2bpqtZdwMnhzig5mmx6YDziLylG/jY3VUG2yp1bRf5rhTyaashOMg08l0hwl3GEVXvYCFTPQV7wIb7FmcYkJlCiLfPObkwZrtA4SkPQQv3tBQ4krq5VN5LMRGXu4NjHZBrKF0RZaUQR3ZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CclgYAEj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fbf77b2b64so6895005a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740280378; x=1740885178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4hSWwxP6ZiCusbLhbTnvl7H4ZNzc7v3lXbdR+X+u7U=;
        b=CclgYAEj78dxqtoUE6kb5fSQYk+1E0Y8qRa4gd4Yc37X4mwHWRlwQHyqI4pycK1MzL
         jF18x5kAKy4gwQstTnvebA+q9T8CCh/PO+lxHWncVO23P2jwD+20OarKhmYL69Ijfwg8
         GDWudYEgnhtAHRtdxz82z7dPHkT5g3aAhMh+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740280378; x=1740885178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4hSWwxP6ZiCusbLhbTnvl7H4ZNzc7v3lXbdR+X+u7U=;
        b=hbjlUycTcXJI68V1PYC99HSamtt4T9/9BznHrypFlGaGsNxet7JZ3NQWXNn/VSAZyo
         D+AaTkSBFBhcLEjSWI/+gdycrXsgcPQMgViiw6dKiNBxOIDCBl8OY3MCybwIY7rkuZb+
         Mq4LoMkaxUlR1Wmj0gqNnVXYclxZqVdM82PmOyF+t3qvqixIKSMs0qkZetaWele5fU+I
         /B+T4PZ8p3DmuyK/L61o3GybXzPshZDNe4HgMqEi4tlUDDtDnOgvRg/MoN7X0rbcFpWG
         PdR41cujcE4cwZC5nMC6zlPSKgKR414/g9+/CGOmXLmWliSigFW0NNEhLwTbRiWWv+JU
         iUyw==
X-Forwarded-Encrypted: i=1; AJvYcCVW7pAgcP7bFrKGK4MzPaS+rO0zoo/A+qgGGJI6zys8KE35a+DXu78GonThgRlV4JxRBaXFI+7PCJRsIr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+q+RasQgXhsBk+CPcHwtds+asx4mqPHg4Omobs28TFzMbZR8p
	C6C38k73gn0Ta5Bjq3ff2BesxHcIWVGnIibdoDb+RQWw+jcy6nWwJmk3UAfzgQ==
X-Gm-Gg: ASbGncsrqVOcZJRGogXWYL/Z812ydx1eAomCzDdJ1TSJqtJswOb6np5hsa+J8+l2+qn
	BWdW0xkIpBHB13Zx4hcWmqynbuNkXGe0JLhSGRmiGTiRvmA1suIxGdmVXFYqNruY79OyamVCNpg
	/o+IXO9oehFjZYwc1GQt6KUhu/bL6j03aTjakhj14BK9Lm8iAo52NkWS8VUOTo02JsmV5nS01O2
	l/PeyKqy5/uaOUnYjV5n3Ht8vJAPXN0+HTyzr1mktoNkWpD9xNNkBi/L1ucT07NMlPvuW8rFYBR
	2wcRcBl9N5kGOqHRJiobRDLhSY2L
X-Google-Smtp-Source: AGHT+IFtN36KhbjavF+Sg24ptpizXiER9hpFjSJioRr2SlZ1w260b/Y5kfU5U1Qhbzz/n+DC0vw00w==
X-Received: by 2002:a17:90a:da87:b0:2fa:1e3e:9be0 with SMTP id 98e67ed59e1d1-2fce78c9247mr13494362a91.19.1740280376731;
        Sat, 22 Feb 2025 19:12:56 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:badf:54f:bbc8:4593])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb0786e9sm3838542a91.33.2025.02.22.19.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 19:12:56 -0800 (PST)
Date: Sun, 23 Feb 2025 12:12:47 +0900
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
Message-ID: <cxspxz5jeiigd34cl7x3asyx4lowefjpffj3ip4mwpxdwh34e6@xzpqbmlihbcg>
References: <Z3yMNI_DbkKBKJxO@gondor.apana.org.au>
 <CAJD7tkaTuNWF42+CoCLruPZks3F7H9mS=6S74cmXnyWz-2tuPw@mail.gmail.com>
 <Z7F1B_blIbByYBzz@gondor.apana.org.au>
 <Z7dnPh4tPxLO1UEo@google.com>
 <CAGsJ_4yVFG-C=nJWp8xda3eLZENc4dpU-d4VyFswOitiXe+G_Q@mail.gmail.com>
 <dhj6msbvbyoz7iwrjnjkvoljvkh2pgxrwzqf67gdinverixvr5@e3ld7oeketgw>
 <lu3j2kr3m2b53ze2covbywh6a7vvrscbkoplwnq4ov24g2cfso@572bdcsobd4a>
 <Z7poTnlv-1DStRZQ@gondor.apana.org.au>
 <u7t7gibspxu3lujdl4hambr72qd6o5u33udbojihngznlyistk@gmyyhwjuiwxc>
 <Z7qNf4NerHrflmfV@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7qNf4NerHrflmfV@gondor.apana.org.au>

On (25/02/23 10:52), Herbert Xu wrote:
> On Sun, Feb 23, 2025 at 11:09:32AM +0900, Sergey Senozhatsky wrote:
> >
> > Right, for lzo/lzo-rle we need a safety page.
> 
> We should fix it because it's a security hole for anyone who calls
> it through the Crypto API.

Yeah, I don't disagree.

> > It also seems that there is no common way of reporting dst_but overflow.
> > Some algos return -ENOSPC immediately, some don't return anything at all,
> > and deflate does it's own thing - there are these places where they see
> > they are out of out space but they Z_OK it
> > 
> > if (s->pending != 0) {
> > 	flush_pending(strm);
> > 	if (strm->avail_out == 0) {
> > 		/* Since avail_out is 0, deflate will be called again with
> > 		 * more output space, but possibly with both pending and
> > 		 * avail_in equal to zero. There won't be anything to do,
> > 		 * but this is not an error situation so make sure we
> > 		 * return OK instead of BUF_ERROR at next call of deflate:
> > 		 */
> > 		s->last_flush = -1;
> > 		return Z_OK;
> > 	}
> > }
> 
> Z_OK is actually an error, see crypto/deflate.c:

I saw Z_STREAM_END, but deflate states "this is not an error" and
there are more places like this.

> 	ret = zlib_deflate(stream, Z_FINISH);
> 	if (ret != Z_STREAM_END) {
> 		ret = -EINVAL;
> 		goto out;
> 	}
> 
> We could change this to ENOSPC for consistency.

So it will ENOSPC all errors, not sure how good that is.  We also
have lz4/lz4hc that return the number of bytes "(((char *)op) - dest)"
if successful and 0 otherwise.  So any error is 0. dst_buf overrun
is also 0, impossible to tell the difference, again not sure if we
can just ENOSPC.

