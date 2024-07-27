Return-Path: <linux-kernel+bounces-264231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8849093E06B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A40DB2105D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75BA186E42;
	Sat, 27 Jul 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gQ6+L22u"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D074411
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104217; cv=none; b=Mc6aP8K0te9sxB2olR7jPaKtfsLZCSsMWl5Kc2g8plomwS6upalHxfS56AnGbL9kP1Mw/GvPkkU8OQ2t6VWT9qX3Yk6KxrZ//Qt7yTEZdh+1+ktmoVPX4SRK19MOeeptMF08LPkvkXaiFl+GQoCrYTWrWB8ufJ08CeSby0Zwtpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104217; c=relaxed/simple;
	bh=kW/4gXUk6F1yB2qi00XQkWYCcAqmnJCZximrn0yej+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+69H5O1CttNxmWFf1IabWf1xpaxt/0S4JkwTQeM1GaJbC0JosWj43W882a6EkvCzKEkOK0Xi5zIKpgcXbilMwPV+PtjhQTTHBI/b3IEAYaZ8m+uXphMNN4e2aRFQMJsb7RbjMqNau4pwWcsmT92Ug+3RJ2XOXCkDaFUf9RUeZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gQ6+L22u; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso3980009a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722104213; x=1722709013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N7MXJDFanOvjXGeDbmsv4q4l8yEMA8rUdIcZkh48+uU=;
        b=gQ6+L22ugtwDaCP1UkrL5vGcRE8/bx4Kn7zyiZeuSV28NwTZKAHx4pvpoxWigOtWsA
         8qTh1Tpf6ZewGI1Ir8H8+vSLdd4UaKxs3Qt5A1x+LIHd7gSH3g2R0q4GzTuFRWWYcU9O
         rsLi0hW9DQXDq9cJe/jKXj5xAY3+RmtwUB04U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104213; x=1722709013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7MXJDFanOvjXGeDbmsv4q4l8yEMA8rUdIcZkh48+uU=;
        b=KuSh1puLKG4QUI76hUbFBnP6DavwCQzU/tIevJGt99XoibJ7Ak/K54QrgCNaRV1wcd
         oxu8o09HJLEzVJ93PqKYxaFTNkYdKIca1XVeI9pIO9Zqrj3aGaSrBR+LOCAot71raRYQ
         FWTFmXXlfs9LEEaVJ8Q6El/aJ90/GKrhoTaNIkU3ppwGE+1o/qDSEhd9UwNsGZxQPonf
         mC5wUubKZ0GDHUGxSXFapiM03+DL1AbjUap70sEkE+DBvSWchVxBwukn1DPWATxdYH32
         7TuAHoZLu3Lv8YLAG0PYM7atTGixTfaxtqQ/7PJn4+iuG9wRt+moJQeCD0DQHPzevdGh
         y1Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW96aQv5UXp+VS8Vr7k4i7akyZXIBOlQhEKfzXqSQijeE0JQjAhOb3kWMAgH95TRaNxcgwoEvr/SL1B8rSxCmB1Nrc+sfKzZYGa5sNW
X-Gm-Message-State: AOJu0Yx7q/rx+/P/6wB/MuTcMHUWBLAAATfOPq44IBWm+N3ZfXdplRmR
	I6PflePNxy+kcpxRrXIiUqQICj6ILAoEVlT1kpAUITrGDVkD+QFkobP+hPTFYSYSAMVtP2s3f40
	j/mVzDQ==
X-Google-Smtp-Source: AGHT+IE1yFSDdnSmkm93v8Ok7xUQ4yjImwsGXI+ngTdnReJLD9bcLX1IbuPHZVDX2E0aWMDFKbKGiA==
X-Received: by 2002:a50:cd54:0:b0:5a0:c709:aa0b with SMTP id 4fb4d7f45d1cf-5b021f0c45bmr1886574a12.24.1722104212842;
        Sat, 27 Jul 2024 11:16:52 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b033fsm3323366a12.1.2024.07.27.11.16.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 11:16:51 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so4285447a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:16:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuGqotg8UybL9hqeLwq852wS+0orXMr9x4mEC5okFrWgMv3A2GGABEqteEPvK6HYfVVcRznrzGFMhKR6LzWv3KVphpntiX6HjOIpfF
X-Received: by 2002:a05:6402:2813:b0:5a3:a4d7:caf5 with SMTP id
 4fb4d7f45d1cf-5b0224cf4eemr1877971a12.36.1722104210954; Sat, 27 Jul 2024
 11:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local> <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local> <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local> <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
 <CAHk-=wgVZwBrCXyphH+HcY9X56EK0KNQrnWZ+Qb0Bz79POLSUw@mail.gmail.com> <ZqUvgRJZQUmyHpna@casper.infradead.org>
In-Reply-To: <ZqUvgRJZQUmyHpna@casper.infradead.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sat, 27 Jul 2024 11:16:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0UOUydauODOLAcS=mDzQsnxd=tGsJRLja88qrWjABWA@mail.gmail.com>
Message-ID: <CAHk-=wi0UOUydauODOLAcS=mDzQsnxd=tGsJRLja88qrWjABWA@mail.gmail.com>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jens Axboe <axboe@kernel.dk>, 
	David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jul 2024 at 10:34, Matthew Wilcox <willy@infradead.org> wrote:
>
> In the specific case of PageLocked, that can hopefully go away fairly
> soon.  We only have 24 instances left in tree and five of those are
> comments/docs.  The ones in fs (btrfs, crypto, f2fs, ocfs2 and pipe)
> should be converted to folio soon.

So unlike the min/max mess, at least in this case there's some
_reason_ for the long lines (ie it's not some long line because of
just mindless expansion, it's a long line because it defines several
helper functions intentionally in one go).

End result: I don't think these are really in the same class as some
of the min/max expansion issues, but:

> But I have been wondering whether the way we define all the functions
> around page/folio flags is sensible.  Every file which includes
> page-flags.h (... which is most of them ...) regenerates the macros.
> You can't grep for the definition of folio_test_locked().  There's
> nowhere to put kernel-doc for folio_test_locked().

Right, these things do have their own issues, and the different flag
handling helper functions _used_ to be simpler than they are now. It
is indeed a pain to grep for, for example, and yes, it gets included
for a lot of people who simply don't need it or want it.

I'm not convinced having it in a generated file would help the
greppability - I certainly don't use "grep -R" any more, I use "git
grep", which by definition will never see any generated files any more
than it sees pre-processor output.

But whether those functions should be in one core header file at all,
that's clearly questionable. I wonder how inlined they need to be
either, outside of the trivial cases.

(And when I say "those functions", I don't mean just the pageflag
ones. The folio ones largely have all the same issues - except the
"page" ones have a *TON* of debugging code in them, so they expand to
be much bigger)

Side note: one very simple thing to do might be to short-circuit the
"constant bit number" test in the bitops that the PG_##flags cases
use. That's a lot of noise to select between "simple constant bit
number" and "generic variable one" when we know they are all constant.

                   Linus

