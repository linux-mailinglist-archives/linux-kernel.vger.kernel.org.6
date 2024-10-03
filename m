Return-Path: <linux-kernel+bounces-349425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09E198F5D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E942831AD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5331AAE3A;
	Thu,  3 Oct 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQf0ZL8R"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E691A7AE4
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978892; cv=none; b=ePAj4fyX60KM+1dpKD6COL6BX/Q+UA/0sI9eg04NtIPNWk3Gl/Vz+pmTnrq9LQCRBlXOPoLdLkblKbgiNE7zNCiD1wU8ktnUj3hI60pu5xxOAyGlrWfmHvUpO3YSKJr850LIu9sQ0c4uEo2dCy0Kthm09NNPgs4etiG68FCqfvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978892; c=relaxed/simple;
	bh=1kWAuTM55LUN+TXIyYIpkhlOnivX/uNwYuTDcEtXuWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLZlubxE5FMXyWB6C0ygm4p3EUb44TOMix0MDr8fpjhGhSQVL3kfMsMCDQBqFUGnj3ju93XTVlDYbIXql5QXmTq/vOuZcQSXwcrVD8aptsLnyhnuIe87vbfFbepyCWNHmNuteIaV9zsKKmSApIC4JnMnSPUhKWnw4yfHkl//bBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQf0ZL8R; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e25d164854dso1122064276.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727978889; x=1728583689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KHOfhrHbiqVkFhI0PFlKS2ZdLPB0rFNP5j2p20rDxwE=;
        b=ZQf0ZL8RTN/iGu9hcGEfmhXToUykuCAWuVbGYTdsvTptmjCWycbMTY0h1+Y2zTCKQs
         X85wsIb+F6wxmaCdWHctTeMs510oKWs9wtzCiN2avMaEleLR+X/3ajbrCVzgWPH7zEdb
         OiQ+W+IoBJBXWag1aHU6nsKBGfu1c0BBLNof48igywhEWtDGJzXMm0WYDK0fyHSDNZN3
         ZYHHw11OGxC6mPGE0H9dqeWpleeiWkY3O1yo8rDuVyDsDF7OpeJQCC6Fr30eOOMVjuRs
         X52XvqIXcDiV/pxAXVO21HgjB0NTlvrAPyeFPHxTBbxOmM1ZJb7HW1MPNStgPWSXcjjZ
         Lj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727978889; x=1728583689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHOfhrHbiqVkFhI0PFlKS2ZdLPB0rFNP5j2p20rDxwE=;
        b=cLulWw+Jexpfg3uESYphHBJxWIs5MFOUuOVsDZuZSywbvm7sFDvomIyzxx/R3br3vc
         2l1xwskmt1Jb3LdDzqGW5OnnFYCxPWLAFXi025xhIUjXaipSpPkoGL2aWlCcLa+rTkn6
         MLr08VNmAoJVtP9XXNic034EceSM0/cSVPUDhylQG70BsILuwBfCQFAnSRcN63Tmf99x
         7UNIslkASrUnskE/l+01GOihYAKtLm8+Av9I3UeYVFbIyJDpnXyn/rPTyvg+maH0HjxH
         05kv5g6wOB5NJCgmS/qmDACh54EFHloYY1UwBIW+Re1nztA9hXP4IDyrb29suJoY8OR4
         i9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUA4cCONhoj8wdrBxaC/a6T2D6RfahaDs3vMqiLLdN//7+ARqRXFMz4Xbbem6P9cLOiod6pV4EQcIkBbTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoqw6MO6eQCdWA1a25mKMq6QQquaU4eRVNOHeZC2KEktOSEB1p
	n683rB24TXGvdUkE8KL0ZEwTNt9OoS2b8/YcI6ol1YzcS8gNTjcLZYFkqfDhgxAqiIadPTDMFia
	k6UjchBJ+yS80NT9oFKZgSKDuamI=
X-Google-Smtp-Source: AGHT+IGGkR8t28uSr/dZhExrFyUAIG5+jfvceLLJHdxcQmzZkt/kQ+BHrh7WzQdSFw31yMn/1ykb6WxzkMRD6Ssqf24=
X-Received: by 2002:a25:d613:0:b0:e28:6dc6:279d with SMTP id
 3f1490d57ef6-e286dc628f2mr3761360276.41.1727978889058; Thu, 03 Oct 2024
 11:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001175358.12970-1-quic_pintu@quicinc.com> <ZvzALYgWMSUYXsol@casper.infradead.org>
In-Reply-To: <ZvzALYgWMSUYXsol@casper.infradead.org>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Thu, 3 Oct 2024 23:37:55 +0530
Message-ID: <CAOuPNLg4YO+6gVtSRYaCzRJTghB5gtPMOAmmBwNeYMH-52zKZQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] zsmalloc: replace kmap_atomic with kmap_local_page
To: Matthew Wilcox <willy@infradead.org>
Cc: Pintu Kumar <quic_pintu@quicinc.com>, minchan@kernel.org, senozhatsky@chromium.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	joe@perches.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hi Matthew,
Thank you so much for your review and comments.

On Wed, 2 Oct 2024 at 09:08, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Oct 01, 2024 at 11:23:58PM +0530, Pintu Kumar wrote:
> > @@ -1059,12 +1061,12 @@ static void *__zs_map_object(struct mapping_area *area,
> >       sizes[1] = size - sizes[0];
> >
> >       /* copy object to per-cpu buffer */
> > -     addr = kmap_atomic(pages[0]);
> > +     addr = kmap_local_page(pages[0]);
> >       memcpy(buf, addr + off, sizes[0]);
> > -     kunmap_atomic(addr);
> > -     addr = kmap_atomic(pages[1]);
> > +     kunmap_local(addr);
> > +     addr = kmap_local_page(pages[1]);
> >       memcpy(buf + sizes[0], addr, sizes[1]);
> > -     kunmap_atomic(addr);
> > +     kunmap_local(addr);
>
> This looks like memcpy_from_page().
>
Yes, I checked and both the above memcpy can be replaced like this:
memcpy_from_page(buf, pages[0], off, sizes[0]);
memcpy_from_page(buf + sizes[0], pages[1], 0, sizes[1]);

> >       /* copy per-cpu buffer to object */
> > -     addr = kmap_atomic(pages[0]);
> > +     addr = kmap_local_page(pages[0]);
> >       memcpy(addr + off, buf, sizes[0]);
> > -     kunmap_atomic(addr);
> > -     addr = kmap_atomic(pages[1]);
> > +     kunmap_local(addr);
> > +     addr = kmap_local_page(pages[1]);
> >       memcpy(addr, buf + sizes[0], sizes[1]);
> > -     kunmap_atomic(addr);
> > +     kunmap_local(addr);
>
> memcpy_from_page()?
>
Same here, but I think this is memcpy_to_page().
I replaced it like this:
memcpy_to_page(page[0], off, buf, sizes[0]);
memcpy_to_page(page[1], 0, buf + sizes[0], sizes[1]);

> > @@ -1798,14 +1800,14 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
> >       migrate_write_lock(zspage);
> >
> >       offset = get_first_obj_offset(page);
> > -     s_addr = kmap_atomic(page);
> > +     s_addr = kmap_local_page(page);
> >
> >       /*
> >        * Here, any user cannot access all objects in the zspage so let's move.
> >        */
> > -     d_addr = kmap_atomic(newpage);
> > +     d_addr = kmap_local_page(newpage);
> >       copy_page(d_addr, s_addr);
> > -     kunmap_atomic(d_addr);
> > +     kunmap_local(d_addr);
>
> copy_highpage()?
>
This looks tricky. It does not look to be a straight-forward
replacement with copy_highpage.
There is a loop in-between which cannot be replaced I think.
I am checking more, but I need some help on this.

>
> Maybe check the other uses, see if there are appropriate helpers for
> them too.
>
Yes sure I am checking more.
Will share the changes with V2 in the new patchset.

> Also, what testing have you done of this patch?
My test setup is as follows:
Enabled: ZRAM, HIGHMEM in Kernel and compiled for arm32.
Used, qemu, arm32, 1GB RAM, ZRAM (128MB) to boot the device.
Using test program, filled zram area, then run stress-ng utility to
simulate memory pressure.
OOM occurred, freed some space, and again triggered allocation.
-------------
              total        used        free      shared  buff/cache   available
Mem:           1001         988           5           0           7           4
Swap:           127         127           0
Total:         1129        1116           5
Node 0, zone   Normal      2      1      9     15     11      2      1
     0      1      1      0
Node 0, zone  HighMem      0      2      5      6      0      0      0
     0      0      0      0

Thanks

