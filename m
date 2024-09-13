Return-Path: <linux-kernel+bounces-328257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66863978120
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123701F27C01
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F61D1D88CD;
	Fri, 13 Sep 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neKkML90"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0E1DB552
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234037; cv=none; b=LneK5hO4RH7ZNeijoEe3q6NkWX3qIHZ0ihdfIvp3jJM2IDTFgTj0DUz1QlgbdC9lYIIS5TOSX8uFqStur5SdZuK6sOF+6zxSQRj9TnquhSoictqAvDOvK/XOv9e4lqQBpDTNOJSJfSh546jpG+VYfuLZOGeM8WqeAxwDh+TF63A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234037; c=relaxed/simple;
	bh=/dWHW16qX2DkRGWXpD+15atzONRgFU19ebFt8gO5Rx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tlgj/nwEaue8kMdKXOD+2YMlc1iIWN0J31OawPhuP4doWstvJGb45jmiveTNiyQ3zzNKWWKWmZteNvmZzmv6h/rz6gmCVEWDOGZMsuJYEhTxHjBGV1UVttJaRijeKggxQHmYwAJFRSyejro9iP01X9krj2alukwlhdd5pGLHQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neKkML90; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so8215185e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726234034; x=1726838834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dWHW16qX2DkRGWXpD+15atzONRgFU19ebFt8gO5Rx8=;
        b=neKkML90X6Eyfw4UbyRkjFquCcDYeKKp/xzUb7nP+56Lc4DloDo/ld7rxILTz887PI
         oFU9ErZFy0o+WVK3vjxvw/c9d661GrdgJQgkGcGiM+Mxae9lsbEcymIktGNRRqwXYbfJ
         P6ze9bW2lDMeXTov8+4ZhdkJy9c9LnWufVMHwU1HfrDdwnbc10gXR7dGv7yBGeqgA4U8
         WRi5epNm7V+ZUldawTpsPi3fPuhC1t1qkWjcLlzij1OyGw+Zu6tjq+EKbd4v3KAMyA7g
         yTwYcozB9pxjLFyXNKGSUuAYFkHzOQllv9zPPg3pG4OC2WQKlvqbMhEMo9NKt5ZvlGnu
         XUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726234034; x=1726838834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dWHW16qX2DkRGWXpD+15atzONRgFU19ebFt8gO5Rx8=;
        b=gxFgxnQ4Uhmw3kFCBpFPUwWJp4jnc+CyHktk6vsw2928bf8y/TtVIR2MT+4bWSn3vO
         kv8s9z8e0kcp1/HR0sUQ9OadGJTXWWEcKCnRADpDJAlcJlJpva2dUIcrHYqKOnwxsMNP
         WOpPFPh/htZkTC3Nhf4ZEJcub/vVZZ5ylm3JHLxRutT8T8j0ZsqRhg7+PQ9lf4KZy9yl
         EheAoMHt+qLyl3OFJUyU7AQFGiqz82C6a7uKu/NGww+7vIkYjUxb1/b22iLlcwDmRA5L
         D1F3HOu8PYhXEsKenhre/fkkauEvB7V9xbLThc5pddqzRDqVeaTk6xqIVOkxjjAljZv3
         vMbw==
X-Forwarded-Encrypted: i=1; AJvYcCXIVjHFj8/wC7zGf+XoEi9Zn1mpjVPrrt0o/xeJcqu4nArOy3GGeIHnZN33aMDbnzfi58eXpzxWQeHKUBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySZ3Nqzfy5M04jFU3u1H2oHMHyADiYRJ3B0xdhLVupneDXV6yZ
	Uhafjhen6hQJbYWEL07Iwf3AE+2i8k7ZiN+dKceGXfaDSZt/RY9gjVY/ZPGeSYvHQXz5uUMz2MH
	/I/tsEN3wazonPS9Cg1QDo+XRJI53tQ==
X-Google-Smtp-Source: AGHT+IECze5FuOLdpZqptn6lvbr71iYBCuyk7Xo54O53SFoEfeNUpJXM1nvOPEYA89clAzHMc9s2ERGAopoHd0CbbNw=
X-Received: by 2002:a05:600c:1d05:b0:42c:c08e:c315 with SMTP id
 5b1f17b1804b1-42d90827159mr26429435e9.16.1726234032925; Fri, 13 Sep 2024
 06:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZfFZCCq6ZQuVHoKY2tRJ3z1p0ftPW360-s=1JWd5Rv3JQ@mail.gmail.com>
 <c71a884d-714f-4741-906f-4df162bde303@suse.cz>
In-Reply-To: <c71a884d-714f-4741-906f-4df162bde303@suse.cz>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 13 Sep 2024 15:27:01 +0200
Message-ID: <CA+fCnZfc5yhxkE+DQeOWcstH9P6g7T96eyCF4wzYXWNVfFrQ1A@mail.gmail.com>
Subject: Re: Question about freeing of empty per-CPU partial slabs in SLUB
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linux Memory Management List <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Imran Khan <imran.f.khan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:34=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> > "If the partial slab becomes an empty slab after freeing up the
> > object, it will be left in its current list if the number of partial
> > slabs for the concerned node is within the limits (i.e < slab cache=E2=
=80=99s
> > min_partial). This applies to both slabs belonging to a per-cpu
> > partial slab list and slabs belonging to a per-node partial slab list.
> > If the number of partial slabs are outside the limit (i.e >=3D slab
> > cache=E2=80=99s min partial) then the newly available empty slab is fre=
ed and
> > is removed from the corresponding partial slab list."
> >
> > The part that seems wrong to me here is the statement that this
> > applies to the per-CPU partial list. Based on the code in __slab_free,
> > it looks like it cannot reach the slab_empty label for a slab that is
> > on the per-CPU partial list.
> >
> > (I know that an empty per-CPU partial slab can be freed when the list
> > overflows or via shrinking, the question is about the slab being freed
> > directly by __slab_free.)
> >
> > Is the article wrong with regards to this case? Or did this behavior
> > change recently (I failed found any traces of this)?
>
> I don't think the behavior changed recently in this aspect, only in some
> other details like tracking on_node_partial with a page flag for better
> performance, and slabs on per-cpu partial list are no longer frozen.
>
> I think the paragraph you quoted can be interpreted together with this pa=
rt
> of the preceding one: "However while putting this partial slab on a per-c=
pu
> partial slab list if it is found that the per-cpu partial slab list is
> already full, then all slabs from the per-cpu partial slab list are unfro=
zen
> i.e they are moved to a per-node partial slab list and this new partial s=
lab
> is put on the per-cpu partial slab list."
>
> So while flushing the per-cpu partial list, the per-cpu partial slabs are
> moved to per-node partial list, and when __put_partials() finds some of t=
hem
> are empty, it applies the same s->min_partial threshold to decide whether=
 to
> keep them in node partial list or free them. So in that sense "This appli=
es
> to both..." part is correct, although as you say it cannot immediately
> affect a slab on partial list we are freeing to.

Ack, thank you for the response!

