Return-Path: <linux-kernel+bounces-181715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB0D8C8029
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 05:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22C1282B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 03:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5A4B672;
	Fri, 17 May 2024 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/bmhaov"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB79470
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715916259; cv=none; b=XhdykCb5otzPbvnDDSDEeUT4xfJfg8UVnEfFzv3hjjpmAgzM1FpDmKbWrzt9R18Xl8O9xEkaJCxARWjeCQ2MkGrTRdEbwyfY0WWjY8bgTaknGrs8cuHiFUsuRDTewD7revG9tO24xtP5ghlxZM1MdRsDFeAxqMGcyoi7cMlUjwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715916259; c=relaxed/simple;
	bh=IOPutvIpfO2y5V0fCmOVIYS37QKohYrmV2SvxEstUHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqlfT+vIPk5pXbnjB2kq6HLhAF4STp05gIf9ZBMO5p11sO4kFkND5AtnczolBsxEHvtjGthDZkzjZmWZbHDIP8HAaFdt01NbEZeynCk7b6qZOUquXqOCZEbp2tHNqMcTlNfqH8UPZIRwEXC3B2ILm9R+tNVIgofePqGKT5R9h/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K/bmhaov; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f44a2d1e3dso921494b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 20:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715916258; x=1716521058; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yTi86NLko9+FJmcjB2JWS3oT0tnePKfTstbRdxRL7Zg=;
        b=K/bmhaovayTx1oNAgoM3J97UQJdwYNuGN4kh9sdwwNdzVuWLe9JO2GMSLpQJpHH1yG
         qfitfQd38FrD3eBudlIsAhvM3wJShbhukbqRX2ZxmLcTi8kRahnRYW6eZKkBJ7wlcPDj
         iNZiid0iyuFYY75Mm/mneSZZbF/MD0lGJUS199OnKeAdclXQGCCXoxzBZ0GlBQa5xKdO
         jT4jb5LQQ3wDbVu7bZhtTab0KMU+9pBF9cKOp0xCy8uOtMe1u36SkPZ+8+UeFE49rKXP
         Zfo7BuZufdhUSNrzwdV8itLZRweikGzhH6xVYUuJBA+KJH7TddOb1pdX/NtM3FjjPYMJ
         9cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715916258; x=1716521058;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTi86NLko9+FJmcjB2JWS3oT0tnePKfTstbRdxRL7Zg=;
        b=NRw0inml7weK+tI/YstBKJWV+QPaGgRW78Yw/uJxoOMuHN0f0qiDTbQGrqitZ82p3W
         lL9ZI5rq1TABv2PKNG7IV30nzf06yra66X27A+GKR3+lBbt0/tiCjz6EYvfMyPk5V06B
         bBrLCKsf3APDqCUtFFYQCRpmWps5Ie25NR5ew/CyqyE1XBlJcXRWxfdZRMlQa0C5ACjE
         qsQ6RxcgPIxw7sl25coVaF/6uuSPROeWsITTbOZhHCHuK8Yisr97kxVHOFazQjqAzV79
         oLOVtnxoCjd7riWTkGP6fOZxx82fIDjYdazrBLLyOlfsgcnXr3Gki+pAcocp0EK2Snwk
         k1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa/DKW4O/ivo7Z9P8LPi1Jk5XEOiXnj//1HSbIwI+t+Zm+azchj3brGl6zuLhrzkQ38EqZFc6q1p82fDZPlUkb7ICC97mflWNjiHm0
X-Gm-Message-State: AOJu0YwLD+mMU+M9Qq4weHS0ODl2S1nZ0Mjcfb0mXyhNJ2thUyK1LGOk
	MZ0+px0aZRB9+UyERvAo59eDs5rrMe0/fahFME5usyBm+fLDml/53t72UyVZYQ==
X-Google-Smtp-Source: AGHT+IEgoOMDvBE82xHyFnbjSOJmt9XW0j3+gWQzHYq/4KLh5fj2PXjm2hQ9hnfmJfkxMpmeMIH/OA==
X-Received: by 2002:a05:6a20:551c:b0:1ad:746:b15a with SMTP id adf61e73a8af0-1afde1c5775mr16976882637.47.1715916257519;
        Thu, 16 May 2024 20:24:17 -0700 (PDT)
Received: from google.com (57.92.83.34.bc.googleusercontent.com. [34.83.92.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2567ccsm146502685ad.301.2024.05.16.20.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 20:24:16 -0700 (PDT)
Date: Fri, 17 May 2024 03:24:13 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Tim Murray <timmurray@google.com>, John Stultz <jstultz@google.com>,
	Steven Moreland <smoreland@google.com>,
	Nick Chen <chenjia3@oppo.com>
Subject: Re: [PATCH v3] binder: use bitmap for faster descriptor lookup
Message-ID: <ZkbN3f8cGu4QPknY@google.com>
References: <20240516133952.4072309-1-cmllamas@google.com>
 <CAH5fLgjP8eozdA3wSari2LHyVUzaOMNTU12JWb2rzGgy9RRpsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjP8eozdA3wSari2LHyVUzaOMNTU12JWb2rzGgy9RRpsg@mail.gmail.com>

On Thu, May 16, 2024 at 04:10:40PM +0200, Alice Ryhl wrote:
> On Thu, May 16, 2024 at 3:39 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > When creating new binder references, the driver assigns a descriptor id
> > that is shared with userspace. Regrettably, the driver needs to keep the
> > descriptors small enough to accommodate userspace potentially using them
> > as Vector indexes. Currently, the driver performs a linear search on the
> > rb-tree of references to find the smallest available descriptor id. This
> > approach, however, scales poorly as the number of references grows.
> >
> > This patch introduces the usage of bitmaps to boost the performance of
> > descriptor assignments. This optimization results in notable performance
> > gains, particularly in processes with a large number of references. The
> > following benchmark with 100,000 references showcases the difference in
> > latency between the dbitmap implementation and the legacy approach:
> >
> >   [  587.145098] get_ref_desc_olocked: 15us (dbitmap on)
> >   [  602.788623] get_ref_desc_olocked: 47343us (dbitmap off)
> >
> > Note the bitmap size is dynamically adjusted in line with the number of
> > references, ensuring efficient memory usage. In cases where growing the
> > bitmap is not possible, the driver falls back to the slow legacy method.
> >
> > A previous attempt to solve this issue was proposed in [1]. However,
> > such method involved adding new ioctls which isn't great, plus older
> > userspace code would not have benefited from the optimizations either.
> >
> > Link: https://lore.kernel.org/all/20240417191418.1341988-1-cmllamas@google.com/ [1]
> > Cc: Tim Murray <timmurray@google.com>
> > Cc: Arve Hjønnevåg <arve@android.com>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: Martijn Coenen <maco@android.com>
> > Cc: Todd Kjos <tkjos@android.com>
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Steven Moreland <smoreland@google.com>
> > Suggested-by: Nick Chen <chenjia3@oppo.com>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> LGTM. One nit below, but it's not a correctness issue.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> > +static inline unsigned int dbitmap_shrink_nbits(struct dbitmap *dmap)
> > +{
> > +       unsigned int bit;
> > +
> > +       if (dmap->nbits <= NBITS_MIN)
> > +               return 0;
> > +
> > +       bit = find_last_bit(dmap->map, dmap->nbits);
> > +       if (unlikely(bit == dmap->nbits))
> > +               return NBITS_MIN;
> > +
> > +       if (unlikely(bit <= (dmap->nbits >> 2)))
> > +               return dmap->nbits >> 1;
> 
> I think this is intended to say that we only shrink if only the lower
> fourth of the bits have any bits set, but for the condition to
> actually be that, you need `bit < (map->nbits >> 2)` here instead of
> `<=`.

True, the range goes [0...n-1] so it should be "bit < n". Let me fix
that. Thanks.

> 
> Alice

