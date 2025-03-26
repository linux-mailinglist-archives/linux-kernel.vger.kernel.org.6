Return-Path: <linux-kernel+bounces-576476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84124A70FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A01792C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F108145B25;
	Wed, 26 Mar 2025 04:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNotFfFh"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02084A29
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961798; cv=none; b=V/SBrxWRnOd0R8YthJ8h5wfsJXLMITU1KQiyPLHOYPe5gGQdaVqyL4SPin7EhiqkWovVr1GKVGRxa3chZVtEybJ0s9bnt12j9wlAzIzZ6CsbyS3NB9BB+jPKOfQcDs/47ND4z3mf0v/Fc5hsEo+elDJMyC8+CMFjwqRspuxJ1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961798; c=relaxed/simple;
	bh=Fn96vV1/njDTatpB28ybdXP6sXgt//jEX9DOcPkvHG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIUn70vTLbOQ+ltzUt9n8GOwPxP6q2cbePeoNNV+ZNI0d53b5FZD4YLZYXPoYFOlkr/cgPDbP6knHJs2mRyqpWfYqSqsqYIOSAvcumElL6zQiHNvYOYIfQsVelRMXMNTzSn3KAKYCXy69F4Mp04iIs8phPCr5zPt4n1TSzBkK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNotFfFh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2264c9d0295so122475ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742961795; x=1743566595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwNtDSof3cHXFHVcfHNPtdaXTxRkadKyo1hZxNKgJvE=;
        b=qNotFfFhjxOuyA0IcoxYyjU5NuRb/kJXseAhr7/svKmaKPpVAAcaqlmylaN9+33cPq
         D1bahy2+iIFH9NjoOPCOGyHwfdAo0gmnOQyoFmcOf8udu7tJeOyegy/UU/hQ3jtoCjAA
         9G1j3XJfwtTW+5U4EgububxrhL/tkqus3yZei0EYQaeopF29P/2cNPzmkzNKLPAgMs3c
         ETVimVZJ4upnJn7EJUbtpkOzS7xwkTKMCogJRbRJlzcuxrQExY86YZy2epxzoX07jkuI
         fffjSZMtFlAiJxxhKfYp20HrEgA0se6v7A5m09BFj910uKJlYoLa4uWVyzS3I9QK2hvV
         etEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742961795; x=1743566595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwNtDSof3cHXFHVcfHNPtdaXTxRkadKyo1hZxNKgJvE=;
        b=ZND5F88aS/XqnWaXunXZjgyexWRU5PcEljkc5mk0bHFCG6Qa3mcE5VuYJik+DqkSAm
         /MNrtN1h/4s7dToWO1nTdIdxY/oXSMSgu5ksjLAw3O6yCcN8lXy6rgGDn308JDZzFCen
         nofG0svz7QSeQUdSa170vXlHYsDnTW9RutlPNfyXh0edv3qQD4N0aWH3zZQ1xerZP3Dk
         Wd+nmO41SFJxiINl9RzEktJ9j6QNJ73N3Y/gvFgHqtC5KKLIZcmRGvbqY4uuRpIyEJJ6
         Fzo+XVYl2RrvrZ95+qnH2+mqBAT8WNbv1Om4lWOoNBbFvs2MVf5dj4ipPGOhWIioHmEs
         6Hng==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5gyQWCPWGNfAqHdoPmJSj4N1D5hj9olWMOMaz8PQzmEWqwXmhVdK67JrY7IXrLR7RXM+wRykg44Dt64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeyHfrMCfWcX6Gj4+z1q++w9oUq7FMP+0cLxSnhARQ8nL95Bwz
	ARYPgwZoVJRrtK+fHOsEY8JVWXeXfTAGpbiZUWSJX9N/OGa4Hfp2jBXTU5KxoHibekqyoNFWmRq
	gnPLHPdQsneKl+YXmjFWn3WZE4eHIeCg87r1UeFrvkQ49QfNFGI8=
X-Gm-Gg: ASbGncvqJOuWcOP2/qADlYJMdcXO/W/29d5EAIB0vJXh/Ukd7XXBxxnP1QbEWoVkqVM
	+SaEKFehSGnm7lv5PIrRx+zS/bDOdxPaDGzfuAj77QIIUeDNs/KoeBdiCSlxdHQHEoVzvaMptUS
	jGiSkY3tlyLlURbO8Z1Q8yE69QxdXjFjL2+jJ66z+YYZaeq60s8T65YsU=
X-Google-Smtp-Source: AGHT+IH15nHM32sadtbp7RdLa4dNsA2koMfipOSAHMIQKQSQ+vzPQ5l8QXWN7pMwJHsvxTNXsDBxdK45REfcIuP+css=
X-Received: by 2002:a17:902:c94f:b0:21f:3f5c:d24c with SMTP id
 d9443c01a7336-227f3395b21mr792355ad.0.1742961794337; Tue, 25 Mar 2025
 21:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325034210.3337080-1-senozhatsky@chromium.org> <Z-MlsM2Gmxdvl_1D@google.com>
In-Reply-To: <Z-MlsM2Gmxdvl_1D@google.com>
From: Richard Chang <richardycc@google.com>
Date: Wed, 26 Mar 2025 12:03:01 +0800
X-Gm-Features: AQ5f1Jrhoxq3b1PQNHYaqAX9y8uQmHyyoefKyW9Afpy38YjPwTCRerZefhpdKWA
Message-ID: <CALC_0q8Mv_UWvFjo3HW_gRsG2N8P--R1OqDj7=2x_98XiRXy4w@mail.gmail.com>
Subject: Re: [PATCH] zram: modernize writeback interface
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,
Since the input buffer length is only PAGE_SIZE long, can we reduce
the duplicated "page_index_range=3D" strings?
Eg:
Turn
echo page_index_range=3D100-200 \
         page_index_range=3D500-700 > zram0/writeback
To:
echo page_index_range=3D100-200,500-700 > zram0/writeback


On Wed, Mar 26, 2025 at 5:52=E2=80=AFAM Minchan Kim <minchan@kernel.org> wr=
ote:
>
> Ccing richardycc@google.com since he has working on this:
>
> On Tue, Mar 25, 2025 at 12:42:04PM +0900, Sergey Senozhatsky wrote:
> > The writeback interface supports a page_index=3DN parameter which
> > performs writeback of the given page.  Since we rarely need to
> > writeback just one single page, the typical use case involves
> > a number of writeback calls, each performing writeback of one
> > page:
> >
> >     echo page_index=3D100 > zram0/writeback
> >     ...
> >     echo page_index=3D200 > zram0/writeback
> >     echo page_index=3D500 > zram0/writeback
> >     ...
> >     echo page_index=3D700 > zram0/writeback
> >
> > One obvious downside of this is that it increases the number of
> > syscalls.  Less obvious, but a significantly more important downside,
> > is that when given only one page to post-process zram cannot perform
> > an optimal target selection.  This becomes a critical limitation
> > when writeback_limit is enabled, because under writeback_limit we
> > want to guarantee the highest memory savings hence we first need
> > to writeback pages that release the highest amount of zsmalloc pool
> > memory.
> >
> > This patch adds page_index_range=3DLOW-HIGH parameter to the writeback
> > interface:
> >
> >     echo page_index_range=3D100-200 \
> >        page_index_range=3D500-700 > zram0/writeback
> >
> > This gives zram a chance to apply an optimal target selection
> > strategy on each iteration of the writeback loop.
> >
> > Apart from that the patch also unifies parameters passing and resembles
> > other "modern" zram device attributes (e.g. recompression), while the
> > old interface used a mixed scheme: values-less parameters for mode and
> > a key=3Dvalue format for page_index.  We still support the "old" value-=
less
> > format for compatibility reasons.
> >
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  Documentation/admin-guide/blockdev/zram.rst |  11 +
> >  drivers/block/zram/zram_drv.c               | 321 +++++++++++++-------
> >  2 files changed, 227 insertions(+), 105 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentatio=
n/admin-guide/blockdev/zram.rst
> > index 9bdb30901a93..9dca86365a4d 100644
> > --- a/Documentation/admin-guide/blockdev/zram.rst
> > +++ b/Documentation/admin-guide/blockdev/zram.rst
> > @@ -369,6 +369,17 @@ they could write a page index into the interface::
> >
> >       echo "page_index=3D1251" > /sys/block/zramX/writeback
> >
> > +In Linux 6.16 this interface underwent some rework.  First, the interf=
ace
> > +now supports `key=3Dvalue` format for all of its parameters (`type=3Dh=
uge_idle`,
> > +etc.)  Second, the support for `page_index_range` was introduced, whic=
h
> > +specify `LOW-HIGH` range (or ranges) of pages to be written-back.  Thi=
s
> > +reduces the number of syscalls, but more importantly this enables opti=
mal
> > +post-processing target selection strategy. Usage example::
> > +
> > +     echo "type=3Didle" > /sys/block/zramX/writeback
> > +     echo "page_index_range=3D1-100 page_index_range=3D200-300" > \
> > +             /sys/block/zramX/writeback
> > +
> >  If there are lots of write IO with flash device, potentially, it has
> >  flash wearout problem so that admin needs to design write limitation
> >  to guarantee storage health for entire product life.
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_dr=
v.c
> > index fda7d8624889..2c39d12bd2d4 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -734,114 +734,19 @@ static void read_from_bdev_async(struct zram *zr=
am, struct page *page,
> >       submit_bio(bio);
> >  }
> >
> > -#define PAGE_WB_SIG "page_index=3D"
> > -
> > -#define PAGE_WRITEBACK                       0
> > -#define HUGE_WRITEBACK                       (1<<0)
> > -#define IDLE_WRITEBACK                       (1<<1)
> > -#define INCOMPRESSIBLE_WRITEBACK     (1<<2)
> > -
> > -static int scan_slots_for_writeback(struct zram *zram, u32 mode,
> > -                                 unsigned long nr_pages,
> > -                                 unsigned long index,
> > -                                 struct zram_pp_ctl *ctl)
> > +static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl =
*ctl)
> >  {
> > -     for (; nr_pages !=3D 0; index++, nr_pages--) {
> > -             bool ok =3D true;
> > -
> > -             zram_slot_lock(zram, index);
> > -             if (!zram_allocated(zram, index))
> > -                     goto next;
> > -
> > -             if (zram_test_flag(zram, index, ZRAM_WB) ||
> > -                 zram_test_flag(zram, index, ZRAM_SAME))
> > -                     goto next;
> > -
> > -             if (mode & IDLE_WRITEBACK &&
> > -                 !zram_test_flag(zram, index, ZRAM_IDLE))
> > -                     goto next;
> > -             if (mode & HUGE_WRITEBACK &&
> > -                 !zram_test_flag(zram, index, ZRAM_HUGE))
> > -                     goto next;
> > -             if (mode & INCOMPRESSIBLE_WRITEBACK &&
> > -                 !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
> > -                     goto next;
> > -
> > -             ok =3D place_pp_slot(zram, ctl, index);
> > -next:
> > -             zram_slot_unlock(zram, index);
> > -             if (!ok)
> > -                     break;
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> > -static ssize_t writeback_store(struct device *dev,
> > -             struct device_attribute *attr, const char *buf, size_t le=
n)
> > -{
> > -     struct zram *zram =3D dev_to_zram(dev);
> > -     unsigned long nr_pages =3D zram->disksize >> PAGE_SHIFT;
> > -     struct zram_pp_ctl *ctl =3D NULL;
> > +     unsigned long blk_idx =3D 0;
> > +     struct page *page =3D NULL;
> >       struct zram_pp_slot *pps;
> > -     unsigned long index =3D 0;
> > -     struct bio bio;
> >       struct bio_vec bio_vec;
> > -     struct page *page =3D NULL;
> > -     ssize_t ret =3D len;
> > -     int mode, err;
> > -     unsigned long blk_idx =3D 0;
> > -
> > -     if (sysfs_streq(buf, "idle"))
> > -             mode =3D IDLE_WRITEBACK;
> > -     else if (sysfs_streq(buf, "huge"))
> > -             mode =3D HUGE_WRITEBACK;
> > -     else if (sysfs_streq(buf, "huge_idle"))
> > -             mode =3D IDLE_WRITEBACK | HUGE_WRITEBACK;
> > -     else if (sysfs_streq(buf, "incompressible"))
> > -             mode =3D INCOMPRESSIBLE_WRITEBACK;
> > -     else {
> > -             if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
> > -                     return -EINVAL;
> > -
> > -             if (kstrtol(buf + sizeof(PAGE_WB_SIG) - 1, 10, &index) ||
> > -                             index >=3D nr_pages)
> > -                     return -EINVAL;
> > -
> > -             nr_pages =3D 1;
> > -             mode =3D PAGE_WRITEBACK;
> > -     }
> > -
> > -     down_read(&zram->init_lock);
> > -     if (!init_done(zram)) {
> > -             ret =3D -EINVAL;
> > -             goto release_init_lock;
> > -     }
> > -
> > -     /* Do not permit concurrent post-processing actions. */
> > -     if (atomic_xchg(&zram->pp_in_progress, 1)) {
> > -             up_read(&zram->init_lock);
> > -             return -EAGAIN;
> > -     }
> > -
> > -     if (!zram->backing_dev) {
> > -             ret =3D -ENODEV;
> > -             goto release_init_lock;
> > -     }
> > +     struct bio bio;
> > +     int ret, err;
> > +     u32 index;
> >
> >       page =3D alloc_page(GFP_KERNEL);
> > -     if (!page) {
> > -             ret =3D -ENOMEM;
> > -             goto release_init_lock;
> > -     }
> > -
> > -     ctl =3D init_pp_ctl();
> > -     if (!ctl) {
> > -             ret =3D -ENOMEM;
> > -             goto release_init_lock;
> > -     }
> > -
> > -     scan_slots_for_writeback(zram, mode, nr_pages, index, ctl);
> > +     if (!page)
> > +             return -ENOMEM;
> >
> >       while ((pps =3D select_pp_slot(ctl))) {
> >               spin_lock(&zram->wb_limit_lock);
> > @@ -929,10 +834,216 @@ static ssize_t writeback_store(struct device *de=
v,
> >
> >       if (blk_idx)
> >               free_block_bdev(zram, blk_idx);
> > -
> > -release_init_lock:
> >       if (page)
> >               __free_page(page);
> > +
> > +     return ret;
> > +}
> > +
> > +#define PAGE_WRITEBACK                       0
> > +#define HUGE_WRITEBACK                       (1 << 0)
> > +#define IDLE_WRITEBACK                       (1 << 1)
> > +#define INCOMPRESSIBLE_WRITEBACK     (1 << 2)
> > +
> > +static int parse_page_index(char *val, unsigned long nr_pages,
> > +                         unsigned long *lo, unsigned long *hi)
> > +{
> > +     int ret;
> > +
> > +     ret =3D kstrtoul(val, 10, lo);
> > +     if (ret)
> > +             return ret;
> > +     *hi =3D *lo + 1;
> > +     if (*lo >=3D nr_pages || *hi > nr_pages)
> > +             return -ERANGE;
> > +     return 0;
> > +}
> > +
> > +static int parse_page_index_range(char *val, unsigned long nr_pages,
> > +                               unsigned long *lo, unsigned long *hi)
> > +{
> > +     char *delim;
> > +     int ret;
> > +
> > +     delim =3D strchr(val, '-');
> > +     if (!delim)
> > +             return -EINVAL;
> > +
> > +     *delim =3D 0x00;
> > +     ret =3D kstrtoul(val, 10, lo);
> > +     if (ret)
> > +             return ret;
> > +     if (*lo >=3D nr_pages)
> > +             return -ERANGE;
> > +
> > +     ret =3D kstrtoul(delim + 1, 10, hi);
> > +     if (ret)
> > +             return ret;
> > +     if (*hi >=3D nr_pages || *lo > *hi)
> > +             return -ERANGE;
> > +     *hi +=3D 1;
> > +     return 0;
> > +}
> > +
> > +static int parse_mode(char *val, u32 *mode)
> > +{
> > +     *mode =3D 0;
> > +
> > +     if (!strcmp(val, "idle"))
> > +             *mode =3D IDLE_WRITEBACK;
> > +     if (!strcmp(val, "huge"))
> > +             *mode =3D HUGE_WRITEBACK;
> > +     if (!strcmp(val, "huge_idle"))
> > +             *mode =3D IDLE_WRITEBACK | HUGE_WRITEBACK;
> > +     if (!strcmp(val, "incompressible"))
> > +             *mode =3D INCOMPRESSIBLE_WRITEBACK;
> > +
> > +     if (*mode =3D=3D 0)
> > +             return -EINVAL;
> > +     return 0;
> > +}
> > +
> > +static int scan_slots_for_writeback(struct zram *zram, u32 mode,
> > +                                 unsigned long lo, unsigned long hi,
> > +                                 struct zram_pp_ctl *ctl)
> > +{
> > +     u32 index =3D lo;
> > +
> > +     while (index < hi) {
> > +             bool ok =3D true;
> > +
> > +             zram_slot_lock(zram, index);
> > +             if (!zram_allocated(zram, index))
> > +                     goto next;
> > +
> > +             if (zram_test_flag(zram, index, ZRAM_WB) ||
> > +                 zram_test_flag(zram, index, ZRAM_SAME))
> > +                     goto next;
> > +
> > +             if (mode & IDLE_WRITEBACK &&
> > +                 !zram_test_flag(zram, index, ZRAM_IDLE))
> > +                     goto next;
> > +             if (mode & HUGE_WRITEBACK &&
> > +                 !zram_test_flag(zram, index, ZRAM_HUGE))
> > +                     goto next;
> > +             if (mode & INCOMPRESSIBLE_WRITEBACK &&
> > +                 !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
> > +                     goto next;
> > +
> > +             ok =3D place_pp_slot(zram, ctl, index);
> > +next:
> > +             zram_slot_unlock(zram, index);
> > +             if (!ok)
> > +                     break;
> > +             index++;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static ssize_t writeback_store(struct device *dev,
> > +                            struct device_attribute *attr,
> > +                            const char *buf, size_t len)
> > +{
> > +     struct zram *zram =3D dev_to_zram(dev);
> > +     u64 nr_pages =3D zram->disksize >> PAGE_SHIFT;
> > +     unsigned long lo =3D 0, hi =3D nr_pages;
> > +     struct zram_pp_ctl *ctl =3D NULL;
> > +     char *args, *param, *val;
> > +     ssize_t ret =3D len;
> > +     int err, mode =3D 0;
> > +
> > +     down_read(&zram->init_lock);
> > +     if (!init_done(zram)) {
> > +             up_read(&zram->init_lock);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Do not permit concurrent post-processing actions. */
> > +     if (atomic_xchg(&zram->pp_in_progress, 1)) {
> > +             up_read(&zram->init_lock);
> > +             return -EAGAIN;
> > +     }
> > +
> > +     if (!zram->backing_dev) {
> > +             ret =3D -ENODEV;
> > +             goto release_init_lock;
> > +     }
> > +
> > +     ctl =3D init_pp_ctl();
> > +     if (!ctl) {
> > +             ret =3D -ENOMEM;
> > +             goto release_init_lock;
> > +     }
> > +
> > +     args =3D skip_spaces(buf);
> > +     while (*args) {
> > +             args =3D next_arg(args, &param, &val);
> > +
> > +             /*
> > +              * Workaround to support the old writeback interface.
> > +              *
> > +              * The old writeback interface has a minor inconsistency =
and
> > +              * requires key=3Dvalue only for page_index parameter, wh=
ile the
> > +              * writeback mode is a valueless parameter.
> > +              *
> > +              * This is not the case anymore and now all parameters ar=
e
> > +              * required to have values, however, we need to support t=
he
> > +              * legacy writeback interface format so we check if we ca=
n
> > +              * recognize a valueless parameter as the (legacy) writeb=
ack
> > +              * mode.
> > +              */
> > +             if (!val || !*val) {
> > +                     err =3D parse_mode(param, &mode);
> > +                     if (err) {
> > +                             ret =3D err;
> > +                             goto release_init_lock;
> > +                     }
> > +
> > +                     scan_slots_for_writeback(zram, mode, lo, hi, ctl)=
;
> > +                     break;
> > +             }
> > +
> > +             if (!strcmp(param, "type")) {
> > +                     err =3D parse_mode(val, &mode);
> > +                     if (err) {
> > +                             ret =3D err;
> > +                             goto release_init_lock;
> > +                     }
> > +
> > +                     scan_slots_for_writeback(zram, mode, lo, hi, ctl)=
;
> > +                     break;
> > +             }
> > +
> > +             if (!strcmp(param, "page_index")) {
> > +                     err =3D parse_page_index(val, nr_pages, &lo, &hi)=
;
> > +                     if (err) {
> > +                             ret =3D err;
> > +                             goto release_init_lock;
> > +                     }
> > +
> > +                     scan_slots_for_writeback(zram, mode, lo, hi, ctl)=
;
> > +                     break;
> > +             }
> > +
> > +             /* There can be several page index ranges */
> > +             if (!strcmp(param, "page_index_range")) {
> > +                     err =3D parse_page_index_range(val, nr_pages, &lo=
, &hi);
> > +                     if (err) {
> > +                             ret =3D err;
> > +                             goto release_init_lock;
> > +                     }
> > +
> > +                     scan_slots_for_writeback(zram, mode, lo, hi, ctl)=
;
> > +                     continue;
> > +             }
> > +     }
> > +
> > +     err =3D zram_writeback_slots(zram, ctl);
> > +     if (err)
> > +             ret =3D err;
> > +
> > +release_init_lock:
> >       release_pp_ctl(zram, ctl);
> >       atomic_set(&zram->pp_in_progress, 0);
> >       up_read(&zram->init_lock);
> > --
> > 2.49.0.395.g12beb8f557-goog
> >

