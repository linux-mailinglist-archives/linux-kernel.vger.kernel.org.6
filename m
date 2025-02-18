Return-Path: <linux-kernel+bounces-518784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AB2A3948C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88005171736
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAAE22AE4E;
	Tue, 18 Feb 2025 08:08:22 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB001FECAD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866102; cv=none; b=D66UCHNu2tq7Uzdnqh9IjujuW7JErF4s3/WPLfmbsqTg1/7pnHYysRZaTxnQHFiO7PfQafkgdFXnuidNP+jhTxg4Rf4YbsIS3i0xvnF87n5TDrSylbWzSoQkVwO5SmxjJbPwDUJj7Phho5sgEYS3S/A4YgDSussixsnd1jfYzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866102; c=relaxed/simple;
	bh=j6H6oVqYMGS6D3VJkggcAv1qxGcui/OzylaqNBXvkrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSSarN7+rnYj14Pnc9EblK/SesN287UfS8FkDP6CGJWDriFeDur8XghRljKhXdjBaz4BAVsWa4SM3HLoVdwGZT3qQVbxfczhe20mPTVkr2hV+GxAm3CBKRpvjdEP0LmrS1fOWVsAL9XLJQlAdhJVUag86B1d9jf0auzm6257AJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5209f22ecfeso717285e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739866098; x=1740470898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9MwgkOHrsarAXnf9TuQkNcaIA+s+1gcKpDOdbCbxlU=;
        b=F/3Rt+VSvj4jQq+2n4+YLao0GCrxlg/1TjfX3gEy8nuppdw/OUQsfDTLQg8bVwXBkT
         AOPrO7pj6GfVT5r+QccmSN9lSp7Gi80JHOZfz24mSe3SRM7FriV/5NepH+KdNl1OOm4D
         0RDb8qk9Uw0+ZfMIJvrCS1JziaHSH5Nvt3molvU7bg5kvul1OweFGP0q1Sw1XH14yeha
         LOQh3pIcsGkKuqKlSe/a8uDaFihqpWMijExPY5ARza44e/wnWRn2/0PmS4bPWFQLl8Yg
         M5bmB20RiW4zD87JH+bPFL+QOjCjqQX+ekYTpoKBbIGrDVVJu7NwCRa5Yz2bmbyGGczA
         ZGYA==
X-Forwarded-Encrypted: i=1; AJvYcCUZTLJU90HRpWIbFnQLa04rMhTYvub/NN+KKwMqj9I/ShIfFZI5lK1PU07nY00I1cWLKPm+ka4oTzLgTXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlLMKKGKmH0KeYWqOPH/EZkKOT2UG2oUevECyoK/f+IvS/oiTt
	NgpcSxs4Vhk9vl/5Q4TzT+jSWc+NMSfd+716pX/3F6MUxXq8qhFbQ0MXw7rhxTc=
X-Gm-Gg: ASbGnctMAce1AjOii80XqmI3BbkKerGsvLxSPmqTEvcr8NhwJ89AgYQ2MJ1vItOyUcO
	2/LenTAl1h0zLshIlgggbmXXqy/NkNoCW/mVljSWOpcVO71zRYYWtg8kHG27Qf+IR0imIXpqRO3
	4NWl8/isXRjhgQWM4vgEd3sqXXQkFIRyqbArUZ3yL5myx3aoX9+e+8ccICsX10yR45ac1M3Ro2O
	XjnF5oSwyPclD2PURLeQ7BWF4ia7yll52k+BocuXIlj3ZzeFBwqSbm+/8BfocU3ywqQgdJlgG93
	nWTj0fbn/0hEiRKD86j2NdDC8KO+6wTE7xLdEWRkD5euVQaKxMNRfw==
X-Google-Smtp-Source: AGHT+IGuLRL5X9liyyEm3RoSQsY+4vNFI0AceAHn9Jm7Aud5b1nng3rdID33fj4QvimEuIC/M6vtUg==
X-Received: by 2002:a05:6122:488a:b0:519:fcf2:ef51 with SMTP id 71dfb90a1353d-5209dbc02a2mr6325312e0c.5.1739866097837;
        Tue, 18 Feb 2025 00:08:17 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-520a8496db7sm1376462e0c.2.2025.02.18.00.08.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:08:17 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4be55c93be1so360486137.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:08:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEGkz0W0el3gSbnsFCBYrWIxCppiLkgxRSeme5KU7SHsRf0Rz9tG8oS1o2nwMJrhiwBDDQI+oGG7kWRn8=@vger.kernel.org
X-Received: by 2002:a05:6102:f10:b0:4bb:d45c:7f4b with SMTP id
 ada2fe7eead31-4bd3fd72a27mr7350475137.11.1739866096976; Tue, 18 Feb 2025
 00:08:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202502072019.LYoCR9bF-lkp@intel.com> <2421077.NG923GbCHz@camazotz>
 <Z68CX3HMEUW00WYi@rli9-mobl> <9791da8a-fb5f-46d0-a86f-66738293d155@app.fastmail.com>
In-Reply-To: <9791da8a-fb5f-46d0-a86f-66738293d155@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Feb 2025 09:08:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU3MazCqD6PaeyLTW1P8mVZr6BVEConT713cTHe830bTQ@mail.gmail.com>
X-Gm-Features: AWEUYZnH9dq957HqwTY97HF9xwG7uxLoVu7EqjIV6dduDusvg_uATVUem4tufXg
Message-ID: <CAMuHMdU3MazCqD6PaeyLTW1P8mVZr6BVEConT713cTHe830bTQ@mail.gmail.com>
Subject: Re: include/linux/thread_info.h:259:25: error: call to
 '__bad_copy_to' declared with attribute error: copy destination size is too small
To: Arnd Bergmann <arnd@arndb.de>
Cc: Philip Li <philip.li@intel.com>, Elizabeth Figura <zfigura@codeweavers.com>, 
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Fri, 14 Feb 2025 at 12:26, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Feb 14, 2025, at 09:44, Philip Li wrote:
> > On Mon, Feb 10, 2025 at 02:39:46PM -0600, Elizabeth Figura wrote:
> >> On Friday, 7 February 2025 06:11:47 CST kernel test robot wrote:
> >> >    In file included from include/linux/spinlock.h:60,
> >> >                     from include/linux/wait.h:9,
> >> >                     from include/linux/wait_bit.h:8,
> >> >                     from include/linux/fs.h:6,
> >> >                     from drivers/misc/ntsync.c:11:
> >> >    In function 'check_copy_size',
> >> >        inlined from 'copy_from_user' at include/linux/uaccess.h:207:7,
> >> >        inlined from 'setup_wait' at drivers/misc/ntsync.c:888:6:
> >> > >> include/linux/thread_info.h:259:25: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
> >> >      259 |                         __bad_copy_to();
> >> >          |                         ^~~~~~~~~~~~~~~
> >>
> >> This was caught before and mentioned in [1]. The suggestion there of changing "args->count" to "count" doesn't help.
> >>
> >> Somehow gcc 12 thinks that the array_size(count, sizeof(*fds)) parameter is constant, although it's finnicky and depends on exactly where __builtin_constant_p() is evaluated.
> >>
> >> The bug goes away with gcc 13. Is this worth trying to work around? I don't have any ideas for how to do so.
> >
> > Thanks for the info, at bot side, we will ignore this error to
> > avoid further reporting on old gcc.
>
> gcc-12 isn't really "old", we support gcc-5 through gcc-14 at the moment.
>
> Maybe the change below would address it? (Not sure I handled the
> "+1" right here, but something like that should make it obvious
> to the compiler what the check is).
>
>       Arnd
>
> diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> index 055395cde42b..ae13aae9194b 100644
> --- a/drivers/misc/ntsync.c
> +++ b/drivers/misc/ntsync.c
> @@ -873,6 +873,7 @@ static int setup_wait(struct ntsync_device *dev,
>  {
>         int fds[NTSYNC_MAX_WAIT_COUNT + 1];
>         const __u32 count = args->count;
> +       size_t size = count * sizeof(fds[0]);

array_size(), to keep the multiplication overflow check?

>         struct ntsync_q *q;
>         __u32 total_count;
>         __u32 i, j;
> @@ -880,15 +881,14 @@ static int setup_wait(struct ntsync_device *dev,
>         if (args->pad || (args->flags & ~NTSYNC_WAIT_REALTIME))
>                 return -EINVAL;
>
> -       if (args->count > NTSYNC_MAX_WAIT_COUNT)
> +       if (size >= sizeof(fds))
>                 return -EINVAL;
>
>         total_count = count;
>         if (args->alert)
>                 total_count++;
>
> -       if (copy_from_user(fds, u64_to_user_ptr(args->objs),
> -                          array_size(count, sizeof(*fds))))
> +       if (copy_from_user(fds, u64_to_user_ptr(args->objs), size))
>                 return -EFAULT;
>         if (args->alert)
>                 fds[count] = args->alert;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

