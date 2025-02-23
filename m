Return-Path: <linux-kernel+bounces-527551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E07A40C8A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 03:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011DE189E934
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 02:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737BB15E97;
	Sun, 23 Feb 2025 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E6lbOk/q"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF3AD5E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740276583; cv=none; b=cJO0aUwHx9hMKkLy02t1IVJj2zMbC0d19VS33gGPC4f/haxMP5c4FKjJ3GwVHmyezRxVQ68g2LZbwK8/+epcjPpo/571ZCVQPgb0VWDN5Y5Nis7aTunsrGGv/lYybKyGJPDI5N8+vFseHs8SfF516e6icHk/jONFVIVGmwnv050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740276583; c=relaxed/simple;
	bh=NuIBx3upqL9KNIxLQxy3GzF6zwII0EOXk8q7zJM9u9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivtnj7Ffbhvr+6Ld970urtaPR0iatRD9AqK45wOCj1NiQLLJ/TdNsetxIoT/ANGtz1U/DL/LZ4meIfw0LnoZvR3M1KrlO+pTC1gM4CAZ2h1Oweuz1RCLc+4/fRlz7qJoJ2fCBNJPudarwR87Crs53A/wnNP9vAqsCTuuRRVTsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E6lbOk/q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22185cddbffso70913365ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 18:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740276582; x=1740881382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKUNTxI3ScxWIEmge1ue/3A/mxxEuL0ykQJBIUwpXck=;
        b=E6lbOk/qq33aBS3c39xZxUvVwJ/65j04nZa7Zia66YFKx+cUS8Sxf17rzzzaIzrxpf
         NWktcdxEu3h9Iry3gvyQhn9aQ5WPB8xrw6cU14cfDYZ5lQtOxesYJJB1nmjB5QSNA/Lj
         DGzdpM7M1gKr8m+j0YVZjOrcFUjlrUwscGdFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740276582; x=1740881382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKUNTxI3ScxWIEmge1ue/3A/mxxEuL0ykQJBIUwpXck=;
        b=FxnKdKKrKhAcfkK2qfxiS+vSyNWaJ4Odgo04tBukTVHcW7IG3O9JSHAY+EhIegjDoE
         9NHC/ktxJl9afxqvyRFIg74SyzBnkEeONAhP5N/cnWIswvf2cchUDFNt8hAbqHNkUf25
         7ihq9ykyUXKsswikGTyNK/zI3TFW84R9Z55iwW/oOaZ34Piys2WI1gC9YeBxD6jrrCFL
         xUdApdG4ixFQZhidwlpneHFd+HWL1SDbs1ewnLG6n0dk8lGxZrMv9DrlKkN3hMmYZ0FF
         8H375C8FXR+m9iIA2wMOR59tkWETZrHMX14abc2dOUBEFTZSwPEDTP+/DxcHcZbTip9X
         x/hg==
X-Forwarded-Encrypted: i=1; AJvYcCWPjMQIu7f1XNOwaBm2StuizOZ1HFh4BUYsOpaw0kAdJ5/+kNl06GBoN+q97dXEEK565tI5Kame+hNXalw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRbCqG7g7Ket48qp4Ct00sUKxo5+7KvFqcOUKxanQ6eviOxaya
	Up/fUFZ9UTmjNhCC17kjRCZfCIFbnQhFndSo9wckqM2z61sVrxtwrmb3XQzBnw==
X-Gm-Gg: ASbGnctLsMOZwcbMwgSSQnp12H4BECYLEInvqiHTQjfLs+1QNNV6zQa84ygbgQBbZYi
	tCR08i6YCxN5iKD11eEfRc/OCwLWkvwUbBcu3DqeDPdvXNtdhKyxZ1PiagIU12OrwjKs05ExVSw
	BnLi+4X1os78D4htDFe3k/n3U0SuRPKuUzaxqyRc1WdbyXKhxWG2pSEAWc94k+HGFO5oUT8Q3ri
	fIm4pWgDHWMqaOAg//nQGGWLX2T9lKzrNRkW272LI+byGd1wlXOPJqzUSr/QHDniWnRurTXCGKG
	yE0D5tfIJMQhHW4owMFsPmetx/ze
X-Google-Smtp-Source: AGHT+IGyOWS8SdxcnCpNXmpsnOdPgyaUof7mfUQNC5miFn8aT5EBDEvVNb2Ow5PqSGIOE2oJnFkx1w==
X-Received: by 2002:a05:6a00:991:b0:732:6276:b46c with SMTP id d2e1a72fcca58-73425a1fab8mr14109564b3a.0.1740276581776;
        Sat, 22 Feb 2025 18:09:41 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:badf:54f:bbc8:4593])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732575e055dsm16497804b3a.68.2025.02.22.18.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 18:09:41 -0800 (PST)
Date: Sun, 23 Feb 2025 11:09:32 +0900
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
Message-ID: <u7t7gibspxu3lujdl4hambr72qd6o5u33udbojihngznlyistk@gmyyhwjuiwxc>
References: <SJ0PR11MB5678034533E3FAD7B16E2758C9112@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkbRHkb7Znzto6=RRDQA9zXZSva43GukhBEfjrgm1qOxHw@mail.gmail.com>
 <Z3yMNI_DbkKBKJxO@gondor.apana.org.au>
 <CAJD7tkaTuNWF42+CoCLruPZks3F7H9mS=6S74cmXnyWz-2tuPw@mail.gmail.com>
 <Z7F1B_blIbByYBzz@gondor.apana.org.au>
 <Z7dnPh4tPxLO1UEo@google.com>
 <CAGsJ_4yVFG-C=nJWp8xda3eLZENc4dpU-d4VyFswOitiXe+G_Q@mail.gmail.com>
 <dhj6msbvbyoz7iwrjnjkvoljvkh2pgxrwzqf67gdinverixvr5@e3ld7oeketgw>
 <lu3j2kr3m2b53ze2covbywh6a7vvrscbkoplwnq4ov24g2cfso@572bdcsobd4a>
 <Z7poTnlv-1DStRZQ@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7poTnlv-1DStRZQ@gondor.apana.org.au>

On (25/02/23 08:14), Herbert Xu wrote:
> On Sat, Feb 22, 2025 at 11:27:49PM +0900, Sergey Senozhatsky wrote:
> >
> > So I didn't look at all of them, but at least S/W lzo1 doesn't even
> > have a notion of max-output-len.  lzo1x_1_compress() accepts a pointer
> > to out_len which tells the size of output stream (the algorithm is free
> > to produce any), so there is no dst_buf overflow as far as lzo1 is
> > concerned.  Unless I'm missing something or misunderstanding your points.
> 
> I just looked at deflate/zstd and they seem to be doing the right
> things.
> 
> But yes lzo is a gaping security hole on the compression side.

Right, for lzo/lzo-rle we need a safety page.

It also seems that there is no common way of reporting dst_but overflow.
Some algos return -ENOSPC immediately, some don't return anything at all,
and deflate does it's own thing - there are these places where they see
they are out of out space but they Z_OK it

if (s->pending != 0) {
	flush_pending(strm);
	if (strm->avail_out == 0) {
		/* Since avail_out is 0, deflate will be called again with
		 * more output space, but possibly with both pending and
		 * avail_in equal to zero. There won't be anything to do,
		 * but this is not an error situation so make sure we
		 * return OK instead of BUF_ERROR at next call of deflate:
		 */
		s->last_flush = -1;
		return Z_OK;
	}
}

