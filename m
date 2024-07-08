Return-Path: <linux-kernel+bounces-243765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 715D0929A53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 02:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E651F21225
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 00:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CDB80B;
	Mon,  8 Jul 2024 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FkbGpZcd"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86B1368
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720397331; cv=none; b=ZPStih5fgBsQYkLyc1g8zuglQgH/11nZMD7D8LlMuo0siNgx4zf75ABHW432H4FuBBZ3BYMamUOi5YZi/UADyNT77zpLCweru53HokZOqF2HaEn5QWkIxPIYsByZxpVoj7w5QljRn7dDnToJzRTSvBVDZAfl7o70+i3QSjAEbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720397331; c=relaxed/simple;
	bh=vn3ej6uz5HJ27Cac3DuFzn+uB9SQgk0rY+AAwVDZ1TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfyeiE/uqmJtJs3GICoUlAupuyhemBSB7igbjZY8/y/tXnWiKJD1s6v7Lm//pNIHXSoEskHrameuzk6fx97IeMVitc0rYhCEKR1e0Ls2jTyNw8W7qf2BA4ZkfmgN1mtBUS+2V7+A+f3RGw5FLkbjf3QT83Vvh3PZKzSXLoht4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FkbGpZcd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso4128081a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 17:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720397328; x=1721002128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AxHB4WSH7xbSrF4sriiEMDo3clBzyxps6KE5BYXF8FA=;
        b=FkbGpZcdMCsQ+ZpUFN+aszXCb1MaCgEXa4dW1DdBTJ37QSVMNsuu4w/ctVdShHTGdB
         hh+/E91TKRc7wUdy1aDd79eia7lFY98kTMqNt8nBOgJvxyFTrirp2MYm4kpRMfRl7wSX
         yFxPeLA4IaLmPJ0H3o4gjmPdHqpYmPvgWoNKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720397328; x=1721002128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxHB4WSH7xbSrF4sriiEMDo3clBzyxps6KE5BYXF8FA=;
        b=apTWaD5T+nAsDq7vx1hdJJaHiLEZr8dY2IZuJUP+OpLOhZnf23NAFc1FHM8JrnQD76
         yUopt+YxCTk27223ugVEbblxJoslF7UuKNpyYOKjAb/RLanqa71i8bfwxZ5p46G4vSCz
         XOC3B714zUl8+xlBMrtSUN726rrDEOmvRWWSvaRFn5YYE4Bu/PTC5N+H8MTlMkiDoKJG
         5HjDqh5MWWHAm4kh82BtgQFdjIH4lWClgh0QwDMENSII/fG9Xj1AYSDStfpnxNh7HlPq
         FrojnUmmEg6bSKbG2tewQ1h91LKOGxSUO0V6k3HNeY00b/sXoa5FRqgCYC5twX0Fb38S
         98ng==
X-Forwarded-Encrypted: i=1; AJvYcCUZJrs262uBKwF4Jl0kB1gSBbu5PHZe2pFS/SFVtMqq5zKdj1ic2Niwf0pTAf70K+rBjhB0DZOIlQz9OXRJLy3AB3aKHfcUP9lS2rcW
X-Gm-Message-State: AOJu0YzMBx9mBhVlvON3UcdA3teMnrpzSEhPuwKoEdj4/Sjs6Qak+q+w
	0smWytPK7NdvN6DankuQIZdnZvi62PhtY3Ertr7G2B9mKlh04NPkIYUtTWzW5G7pShYe+ML0hII
	ERKxEMQ==
X-Google-Smtp-Source: AGHT+IH3FJWAQBLwmc54RPBHYihB/++LumloZUKn4I3ScF2GiC9drtTF0b/lWVDmjUKW3NrzZsARjg==
X-Received: by 2002:a05:6402:2684:b0:58c:804a:6f09 with SMTP id 4fb4d7f45d1cf-58e5cd15b48mr8794280a12.37.1720397328010;
        Sun, 07 Jul 2024 17:08:48 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5908749c8c7sm2586000a12.1.2024.07.07.17.08.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 17:08:46 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77dc08db60so224505166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 17:08:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgGATdW4CBCjLShqhZBpQuo72wFaX9+HpM9rtOXmCyUcy5Kw2/jl2rLeu/jX13zI6aCh9e5EkRImxP62PgTdsiNwlELmWm9BkKO0FD
X-Received: by 2002:a17:906:ce53:b0:a6f:af8e:b75d with SMTP id
 a640c23a62f3a-a77ba4552damr759244366b.8.1720397325858; Sun, 07 Jul 2024
 17:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707002658.1917440-1-Jason@zx2c4.com> <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com> <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
 <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com> <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
 <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
In-Reply-To: <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Jul 2024 17:08:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
Message-ID: <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: David Hildenbrand <david@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, 
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jul 2024 at 14:01, David Hildenbrand <david@redhat.com> wrote:
>
> At least MAP_DROPPABLE doesn't quite make sense with hugetlb, but at least
> the other ones do have semantics with hugetlb?

Hmm.

How about we just say that VM_DROPPABLE really is something separate
from MAP_PRIVATE or MAP_SHARED..

And then we make the rule be that VM_DROPPABLE is never dumped and
always dropped on fork, just to make things simpler.

It not only avoids a flag, but it actually makes sense: the pages
aren't stable for dumping anyway, and not copying them on fork() not
only avoids some overhead, but makes it much more reliable and
testable.

IOW, how about taking this approach:

   --- a/include/uapi/linux/mman.h
   +++ b/include/uapi/linux/mman.h
   @@ -17,5 +17,6 @@
    #define MAP_SHARED  0x01            /* Share changes */
    #define MAP_PRIVATE 0x02            /* Changes are private */
    #define MAP_SHARED_VALIDATE 0x03    /* share + validate extension flags */
   +#define MAP_DROPPABLE       0x08    /* 4 is not in MAP_TYPE on parisc? */

    /*

with do_mmap() doing:

   --- a/mm/mmap.c
   +++ b/mm/mmap.c
   @@ -1369,6 +1369,23 @@ unsigned long do_mmap(struct file *file,
                        pgoff = 0;
                        vm_flags |= VM_SHARED | VM_MAYSHARE;
                        break;
   +            case MAP_DROPPABLE:
   +                    /*
   +                     * A locked or stack area makes no sense to
   +                     * be droppable.
   +                     *
   +                     * Also, since droppable pages can just go
   +                     * away at any time, it makes no sense to
   +                     * copy them on fork or dump them.
   +                     */
   +                    if (flags & MAP_LOCKED)
   +                            return -EINVAL;
   +                    if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
   +                            return -EINVAL;
   +
   +                    vm_flags |= VM_DROPPABLE;
   +                    vm_flags |= VM_WIPEONFORK | VM_DONTDUMP;
   +                    fallthrough;
                case MAP_PRIVATE:
                        /*
                         * Set pgoff according to addr for anon_vma.

which looks rather simple.

The only oddity is that parisc thing - every other archiecture has the
MAP_TYPE bits being 0xf, but parisc uses 0x2b (also four bits, but
instead of the low four bits it's 00101011 - strange).

So using 8 as a MAP_TYPE bit for MAP_DROPPABLE works everywhere, and
if we eventually want to do a "signaling" MAP_DROPPABLE we could use
9.

This has the added advantage that if somebody does this on an old
kernel,. they *will* get an error. Because unlike the 'flag' bits in
general, the MAP_TYPE bit space has always been tested.

Hmm?

              Linus

